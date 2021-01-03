import matplotlib.pyplot as plt


def main():
    file = open('output2.txt', 'r')
    lines = file.readlines()
    data = {}
    data_counter = -1
    i = 0
    while i < len(lines):

        splitted = lines[i].split()
        if len(splitted) > 0:
            if splitted[0] == 'MINOS':
                i += 2
            elif splitted[0] == 'alpha':
                data_counter += 1
                data[data_counter] = {}
                data[data_counter]['alpha'] = splitted[2]

            elif splitted[1] == ':=' or splitted[2] == ':=':
                data[data_counter][splitted[0]] = lines[i+1:i+7]
                while lines[i].split()[0] != ';':
                    i += 1
            else:
                data[data_counter][splitted[0]] = splitted[2]
        i += 1

    # table = 'Nº Activitat '
    # # add alphas
    # for i in range(data_counter // 2 + 1, data_counter):
    #     table += ' & $\\alpha=$' + data[i]['alpha']
    # table += ' \\\\ \n'
    #
    # n_tasks = 5
    # for task in range(n_tasks):
    #     table += 'task ' + str(task)
    #     for i in range(data_counter // 2 + 1, data_counter + 1):
    #         inactivity = data[i]['inactivity'][task].split()
    #         table += ' & ' + inactivity[2]
    #     table += ' \\\\ \n'
    table = '$\\alpha$ & Total Cost & Interest Payment & Total Duration'
    table += ' \\\\ \n'
    alphas = []
    total_cost = []
    interest_pay = []
    total_duration = []
    for i in range(data_counter + 1):
        alphas.append(float(data[i]['alpha']))
        total_cost.append(float(data[i]['total_cost']))
        interest_pay.append(float(data[i]['interest_pay']))
        total_duration.append(float(data[i]['total_duration']))
        table += data[i]['alpha'] + ' & ' + data[i]['total_cost']
        table += ' & ' + data[i]['interest_pay']
        table += ' & ' + data[i]['total_duration']
        table += ' \\\\ \n'
    plt.title('Total cost vs Total duration Area 2')
    plt.xlabel('Alpha')
    plt.ylabel('Duration/Cost')
    plt.plot(alphas, total_cost, label='Total Cost')
    #plt.plot(alphas, interest_pay, label='Interest pay')
    plt.plot(alphas, total_duration, label='Total Duration')
    plt.legend(loc='center right')
    plt.savefig('plot2.png')


    print(table)

if __name__ == '__main__':
    main()
