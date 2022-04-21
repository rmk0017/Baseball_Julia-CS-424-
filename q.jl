#EJ McKinley and Rishi Kamath
#Windows 10
#program2.txt

using Printf

print("Hi! Please enter your input file name\n")  
myfile = nothing
name = readline()
try
    global myfile = open(name) #need to change this 
catch err
    println("Error: The file does not exist. Exiting now...\n")
    exit(0)
end

#Function to initialize the matrix with input values from the file
function MatrixInit(matrix, values) 
    for value in values
        matrix[row, 1] = value[1]
        matrix[row, 2] = value[2]
        matrix[row, 3] = value[3]
        matrix[row, 4] = value[4]
        matrix[row, 5] = value[5]
        matrix[row, 6] = value[6]
        matrix[row, 7] = value[7]
        matrix[row, 8] = value[8]
        matrix[row, 9] = value[9]
        matrix[row, 10] = value[10]
        global row += 1
    end
end


size = 0
values = []
for lines in readlines(myfile)
    substrings = split(lines, " ")
    push!(values, substrings)
    global size += 1
end


dataset = Matrix(undef, size, 14)

row = 1

MatrixInit(dataset, values)




function computeBattingAvg(singles, doubles, triples, homeruns, atbats)
	(singles+doubles+triples+homeruns)/atbats
end

function computeSluggingPercent(singles, doubles, triples, homeruns, atbats)
	(singles+2*doubles+3*triples+4*homeruns)/atbats
end

function computeObp(singles, doubles, triples, homeruns, walks, hitbypitch, plateappearances)
	(singles+doubles+triples+homeruns+walks+hitbypitch)/plateappearances
end

function computeOps(sluggingPercent, obp)
	sluggingPercent+obp
end

row = 1

while row <= size
	dataset[row, 11] = computeBattingAvg(parse(Float64, dataset[row, 5]),parse(Float64, dataset[row, 6]),parse(Float64, dataset[row, 7]),parse(Float64, dataset[row, 8]),parse(Float64, dataset[row, 4]))
	dataset[row, 12] = computeSluggingPercent(parse(Float64, dataset[row, 5]),parse(Float64, dataset[row, 6]),parse(Float64, dataset[row, 7]),parse(Float64, dataset[row, 8]),parse(Float64, dataset[row, 4]))
	dataset[row, 13] = computeObp(parse(Float64, dataset[row, 5]),parse(Float64, dataset[row, 6]),parse(Float64, dataset[row, 7]),parse(Float64, dataset[row, 8]),parse(Float64, dataset[row, 9]),parse(Float64, dataset[row, 10]),parse(Float64, dataset[row, 3]))
	dataset[row, 14] = computeOps(dataset[row, 12],dataset[row, 13])
	global row += 1
end



@printf "BASEBALL TEAM REPORT --- %d PLAYERS FOUND IN FILE\n\n" size
@printf "       PLAYER NAME       :    AVERAGE    SLUGGING    ONBASE%%    OPS  \n"
@printf "---------------------------------------------------------------------\n"

#variables to help find the highest ops player that hasn't been picked yet
maxOps = 0
opsCap = 100
playerIndex = -1

row = 1
i = 1

#iterates through each player to find best OPS, print data, then iterates again until all players printed
while row <= size 
	global maxOps = 0
	global i = 1
	while i <= size
		if dataset[i, 14]>maxOps && dataset[i, 14]<opsCap
			global playerIndex = i
			global maxOps = dataset[i, 14]
		end
		global i+=1
	end
	global opsCap = maxOps
	@printf "%12s, %-11s:     %5.3f      %5.3f       %5.3f    %5.3f\n" dataset[playerIndex, 2] dataset[playerIndex, 1] dataset[playerIndex, 11] dataset[playerIndex, 12] dataset[playerIndex, 13] dataset[playerIndex, 14]
	global row+=1
end

println("\n\n")

@printf "BASEBALL TEAM REPORT --- %d PLAYERS FOUND IN FILE\n\n" size
@printf "       PLAYER NAME       :    AVERAGE    SLUGGING    ONBASE%%    OPS  \n"
@printf "---------------------------------------------------------------------\n"

#variables to help find the highest batting average for a player that hasn't been picked yet
maxBatting = 0
battingCap = 100
playerIndex = -1

row = 1
i = 1

#iterates through each player to find best batting average, prints player, then goes again until all players data has been printed
while row <= size 
	global maxBatting = 0
	global i = 1
	while i <= size
		if dataset[i, 11]>maxBatting && dataset[i, 11]<battingCap
			global playerIndex = i
			global maxBatting = dataset[i, 11]
		end
		global i+=1
	end
	global battingCap = maxBatting
	@printf "%12s, %-11s:     %5.3f      %5.3f       %5.3f    %5.3f\n" dataset[playerIndex, 2] dataset[playerIndex, 1] dataset[playerIndex, 11] dataset[playerIndex, 12] dataset[playerIndex, 13] dataset[playerIndex, 14]
	global row+=1
end


