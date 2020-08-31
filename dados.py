import math

# Le dataset
f = open('cases-brazil-cities-time.csv', 'r', encoding='utf-8')
dataset = f.read().split('\n')
f.close()

# Le as bandeiras
f = open('bandeiras.txt')
bandeiras = f.read().split('\n')
f.close()

# Remove linhas de cidades fora do RS
dataset_rs = []
dataset_regiao = [[], [], [], [], [], [], [], [], [], [],
                  [], [], [], [], [], [], [], [], [], [], []]

# Idx da regiao de saude
regiao2num = {
    1 : 0, 2 : 0, 3 : 1, 4 : 2, 5 : 2, 6 : 3, 7 : 4, 8 : 5, 9 : 6, 10 : 7,
    11 : 8, 12 : 9, 13 : 10, 14 : 11, 15 : 12, 20 : 12, 16 : 13, 17 : 14,
    18 : 14, 19 : 14, 21 : 15, 22 : 16, 23 : 17, 24 : 17, 25 : 17, 26 : 17,
    27 : 18, 28 : 19, 29 : 20, 30 : 20
}

for i in range(len(dataset) - 1):
    lin = dataset[i].split(',')
    if lin[3] == 'RS':
        if 'CASO SEM LOCALIZAÇÃO' in lin[4]:
            continue

        dataset_rs.append(dataset[i])

        # Add no dataset da regiao
        num_regiao = int(lin[7].split('Região ')[1].split(' ')[0])
        dataset_regiao[regiao2num[num_regiao]].append(dataset[i])

# Junta tudo da regiao num arquivo solo
fa = open('output/sum.txt', 'w')
fa.write('regiao,semana,data,novos_casos,bandeira\n')

for i in range(len(dataset_regiao)):
    regiao = {}

    for j in range(len(dataset_regiao[i])):
        lin = dataset_regiao[i][j].split(',')
        date = lin[1][5:]

        if date in regiao:
            regiao[date]['novos_casos'] += float(lin[10])
        else:
            regiao[date] = { 'novos_casos' : float(lin[10]) }

    # Escreve output
    f = open('output/sum_regiao_' + str(i) + '.txt', 'w')
    f.write('regiao,semana,data,novos_casos,bandeira\n')
    for key in regiao:
        # Converte dia/mes para semana
        mes = int(key[:2])
        dia = int(key[3:])

        if mes < 5 or (mes == 5 and dia < 2):
            continue
        elif mes == 5:
            semana = dia - 2
        elif mes == 6:
            semana = 29 + dia
        elif mes == 7:
            semana = 29 + 30 + dia
        elif mes == 8:
            semana = 29 + 30 + 31 + dia

        if math.floor(semana / 7) > 15:
            continue

        # Converte letra da bandeira para numero
        bandeira = bandeiras[math.floor(semana / 7)][i]
        if bandeira == 'a':
            bandeira = '0'
        elif bandeira == 'l':
            bandeira = '1'
        elif bandeira == 'v':
            bandeira = '2'
        elif bandeira == 'p':
            bandeira = '3'

        semana = str(round(semana / 7, 4))

        f.write(str(i) + ',' + semana + ',' + key + ',' + str(regiao[key]['novos_casos']) + ',' + bandeira + '\n')
        fa.write(str(i) + ',' + semana + ',' + key + ',' + str(regiao[key]['novos_casos']) + ',' + bandeira + '\n')

    f.close()

fa.close()
