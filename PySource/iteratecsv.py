import csv
import os

def removedup():
    input_path = 'C:/Users/jaeyo/Downloads/youtube-statistics/CSV/truedf.csv'
    temp_path = 'C:/Users/jaeyo/Downloads/youtube-statistics/CSV/finaldf_temp.csv'

    seen_ids = set()

    with open(input_path, 'r', encoding='utf-8') as infile, \
        open(temp_path, 'w', newline='', encoding='utf-8') as outfile:

        reader = csv.reader(infile)
        writer = csv.writer(outfile)

        header = next(reader) 
        writer.writerow(header)

        for row in reader:
            unique_id = row[9] 
            if unique_id not in seen_ids:
                seen_ids.add(unique_id)
                writer.writerow(row)  

    os.replace(temp_path, input_path)

    print(f"File cleaned. {len(seen_ids)} unique rows kept.")

#removedup()

def writecsv(templist):
    out_path = "C:/Users/jaeyo/Downloads/youtube-statistics/CSV/videoage.csv"
    with open(out_path, 'w', newline='', encoding='utf-8') as outfile:
        writer = csv.writer(outfile)
        writer.writerow(['Age', 'Count'])

        for i in range(len(templist)):
            writer.writerow([i + 1, templist[i]])
    print("all done")

def videoage():
    input_path = 'C:/Users/jaeyo/Downloads/youtube-statistics/CSV/finaldf.csv'
    templist = [0] * 919

    with open(input_path, 'r', encoding='utf-8') as infile:
        reader = csv.reader(infile)
        next(reader)  # skip header if there is one
        for row in reader:
            try:
                age = int(row[13])  # convert from string to int
                templist[age - 1] += 1
            except ValueError:
                # Skip rows where age isn't a valid integer
                continue

    writecsv(templist)

videoage()

def onlypos():
    input_path = 'C:/Users/jaeyo/Downloads/youtube-statistics/CSV/finaldf.csv'
    temp_path = 'C:/Users/jaeyo/Downloads/youtube-statistics/CSV/finaldftemp.csv'

    with open(input_path, 'r', encoding='utf-8') as infile, \
        open(temp_path, 'w', newline='', encoding='utf-8') as outfile:
        reader = csv.reader(infile)
        writer = csv.writer(outfile)

        header = next(reader) 
        writer.writerow(header)

        for row in reader:
            if row[2] != '0':
                writer.writerow(row)  

    os.replace(temp_path, input_path)
    print('Sucessfully done')

#onlypos()  

#def s 