import openai
import pandas as pd
openai.api_key = "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"

#My api key got expired on credits

def ask_question(prompt):
    completions = openai.Completion.create(
        engine="davinci",
        prompt=prompt,
        max_tokens=1024,
        n=1,
        stop=None,
        temperature=0.5,
    )
    message = completions.choices[0].text
    #return the raw strip of the response
    return message.strip()

#right now am asking for the menu text as input
txtOfMenu = input("menu text?")

#question string to feed to chat gpt
question = "Make a table(table has 5 columns: food item, description of item, if it contains meat, if it contains gluten, if it contains fruit) for the following menu:"  + txtOfMenu 
#response is the chatGPT response
response = ask_question(question)

#now parse the chatgpt text response in order to convert to pandas DF
menu_list = response.strip().split('\n')

#split rows by commas
menu_data = [row.split(',') for row in menu_list]

#create DF
menu_df = pd.DataFrame(menu_data[1:], columns=menu_data[0])

#index as first column
menu_df.set_index("Food Item", inplace=True)

#print df
print(menu_df)

#later will query items in the Dataframe that have "no" for meat column, to an array for the front end to print out, for example

