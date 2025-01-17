//
//  MockResponses.swift
//  CurrencyConvertorTests
//
//  Created by Prateek Sujaina on 26/04/24.
//

import Foundation

let exchangeRates: String = """
{
  "disclaimer": "Usage subject to terms: https://openexchangerates.org/terms",
  "license": "https://openexchangerates.org/license",
  "timestamp": 1714125600,
  "base": "USD",
  "rates": {
    "AED": 3.6729,
    "AFN": 72.113727,
    "ALL": 93.964557,
    "AMD": 389.934151,
    "ANG": 1.801826,
    "AOA": 835.686667,
    "ARS": 873.778399,
    "AUD": 1.529461,
    "AWG": 1.8,
    "AZN": 1.7,
    "BAM": 1.823173,
    "BBD": 2,
    "BDT": 109.718515,
    "BGN": 1.820665,
    "BHD": 0.37697,
    "BIF": 2865.900649,
    "BMD": 1,
    "BND": 1.359088,
    "BOB": 6.92336,
    "BRL": 5.1594,
    "BSD": 1,
    "BTC": 0.000015516458,
    "BTN": 83.198044,
    "BWP": 13.799179,
    "BYN": 3.271809,
    "BZD": 2.015213,
    "CAD": 1.36507,
    "CDF": 2784.275506,
    "CHF": 0.911857,
    "CLF": 0.034366,
    "CLP": 948.5,
    "CNH": 7.26142,
    "CNY": 7.2467,
    "COP": 3938.256915,
    "CRC": 502.543064,
    "CUC": 1,
    "CUP": 25.75,
    "CVE": 102.787707,
    "CZK": 23.4342,
    "DJF": 178.029254,
    "DKK": 6.9464,
    "DOP": 58.737166,
    "DZD": 134.308845,
    "EGP": 47.8952,
    "ERN": 15,
    "ETB": 56.938136,
    "EUR": 0.931464,
    "FJD": 2.25945,
    "FKP": 0.798893,
    "GBP": 0.798893,
    "GEL": 2.68,
    "GGP": 0.798893,
    "GHS": 13.521387,
    "GIP": 0.798893,
    "GMD": 67.925,
    "GNF": 8595.804991,
    "GTQ": 7.778176,
    "GYD": 209.164328,
    "HKD": 7.829169,
    "HNL": 24.684337,
    "HRK": 7.018434,
    "HTG": 132.519255,
    "HUF": 365.727693,
    "IDR": 16252.0432,
    "ILS": 3.810066,
    "IMP": 0.798893,
    "INR": 83.351005,
    "IQD": 1309.63274,
    "IRR": 42075,
    "ISK": 139.81,
    "JEP": 0.798893,
    "JMD": 155.852528,
    "JOD": 0.7087,
    "JPY": 156.689,
    "KES": 135,
    "KGS": 88.8404,
    "KHR": 4058.74892,
    "KMF": 459.749603,
    "KPW": 900,
    "KRW": 1375.876802,
    "KWD": 0.307853,
    "KYD": 0.833104,
    "KZT": 444.686064,
    "LAK": 21317.494109,
    "LBP": 89526.679636,
    "LKR": 296.929646,
    "LRD": 193.300002,
    "LSL": 19.148687,
    "LYD": 4.865089,
    "MAD": 10.117409,
    "MDL": 17.769968,
    "MGA": 4434.453907,
    "MKD": 57.393696,
    "MMK": 2099.474469,
    "MNT": 3450,
    "MOP": 8.057557,
    "MRU": 39.440873,
    "MUR": 46.350001,
    "MVR": 15.46,
    "MWK": 1732.933752,
    "MXN": 17.2666,
    "MYR": 4.7695,
    "MZN": 63.999989,
    "NAD": 19.148775,
    "NGN": 1306.22,
    "NIO": 36.793286,
    "NOK": 10.985908,
    "NPR": 133.115309,
    "NZD": 1.678937,
    "OMR": 0.384964,
    "PAB": 1,
    "PEN": 3.73015,
    "PGK": 3.85085,
    "PHP": 57.714997,
    "PKR": 278.429963,
    "PLN": 4.029449,
    "PYG": 7426.722988,
    "QAR": 3.647186,
    "RON": 4.63522,
    "RSD": 109.132,
    "RUB": 92.081031,
    "RWF": 1290.056443,
    "SAR": 3.750565,
    "SBD": 8.475185,
    "SCR": 13.446599,
    "SDG": 586,
    "SEK": 10.8832,
    "SGD": 1.360548,
    "SHP": 0.798893,
    "SLL": 20969.5,
    "SOS": 571.337774,
    "SRD": 34.1995,
    "SSP": 130.26,
    "STD": 22281.8,
    "STN": 22.838499,
    "SVC": 8.747652,
    "SYP": 2512.53,
    "SZL": 19.008245,
    "THB": 36.963,
    "TJS": 10.907252,
    "TMT": 3.5,
    "TND": 3.148,
    "TOP": 2.385418,
    "TRY": 32.57961,
    "TTD": 6.793849,
    "TWD": 32.570786,
    "TZS": 2590,
    "UAH": 39.625912,
    "UGX": 3808.909397,
    "USD": 1,
    "UYU": 38.350076,
    "UZS": 12687.147716,
    "VES": 36.377596,
    "VND": 25345.333786,
    "VUV": 118.722,
    "WST": 2.8,
    "XAF": 611.000587,
    "XAG": 0.03609633,
    "XAU": 0.00042567,
    "XCD": 2.70255,
    "XDR": 0.759658,
    "XOF": 611.000587,
    "XPD": 0.00101969,
    "XPF": 111.153269,
    "XPT": 0.0010942,
    "YER": 250.374948,
    "ZAR": 19.032388,
    "ZMW": 26.318586,
    "ZWL": 322
  }
}
"""

let currencyList = """
{
  "AED": "United Arab Emirates Dirham",
  "AFN": "Afghan Afghani",
  "ALL": "Albanian Lek",
  "AMD": "Armenian Dram",
  "ANG": "Netherlands Antillean Guilder",
  "AOA": "Angolan Kwanza",
  "ARS": "Argentine Peso",
  "AUD": "Australian Dollar",
  "AWG": "Aruban Florin",
  "AZN": "Azerbaijani Manat",
  "BAM": "Bosnia-Herzegovina Convertible Mark",
  "BBD": "Barbadian Dollar",
  "BDT": "Bangladeshi Taka",
  "BGN": "Bulgarian Lev",
  "BHD": "Bahraini Dinar",
  "BIF": "Burundian Franc",
  "BMD": "Bermudan Dollar",
  "BND": "Brunei Dollar",
  "BOB": "Bolivian Boliviano",
  "BRL": "Brazilian Real",
  "BSD": "Bahamian Dollar",
  "BTC": "Bitcoin",
  "BTN": "Bhutanese Ngultrum",
  "BWP": "Botswanan Pula",
  "BYN": "Belarusian Ruble",
  "BZD": "Belize Dollar",
  "CAD": "Canadian Dollar",
  "CDF": "Congolese Franc",
  "CHF": "Swiss Franc",
  "CLF": "Chilean Unit of Account (UF)",
  "CLP": "Chilean Peso",
  "CNH": "Chinese Yuan (Offshore)",
  "CNY": "Chinese Yuan",
  "COP": "Colombian Peso",
  "CRC": "Costa Rican Colón",
  "CUC": "Cuban Convertible Peso",
  "CUP": "Cuban Peso",
  "CVE": "Cape Verdean Escudo",
  "CZK": "Czech Republic Koruna",
  "DJF": "Djiboutian Franc",
  "DKK": "Danish Krone",
  "DOP": "Dominican Peso",
  "DZD": "Algerian Dinar",
  "EGP": "Egyptian Pound",
  "ERN": "Eritrean Nakfa",
  "ETB": "Ethiopian Birr",
  "EUR": "Euro",
  "FJD": "Fijian Dollar",
  "FKP": "Falkland Islands Pound",
  "GBP": "British Pound Sterling",
  "GEL": "Georgian Lari",
  "GGP": "Guernsey Pound",
  "GHS": "Ghanaian Cedi",
  "GIP": "Gibraltar Pound",
  "GMD": "Gambian Dalasi",
  "GNF": "Guinean Franc",
  "GTQ": "Guatemalan Quetzal",
  "GYD": "Guyanaese Dollar",
  "HKD": "Hong Kong Dollar",
  "HNL": "Honduran Lempira",
  "HRK": "Croatian Kuna",
  "HTG": "Haitian Gourde",
  "HUF": "Hungarian Forint",
  "IDR": "Indonesian Rupiah",
  "ILS": "Israeli New Sheqel",
  "IMP": "Manx pound",
  "INR": "Indian Rupee",
  "IQD": "Iraqi Dinar",
  "IRR": "Iranian Rial",
  "ISK": "Icelandic Króna",
  "JEP": "Jersey Pound",
  "JMD": "Jamaican Dollar",
  "JOD": "Jordanian Dinar",
  "JPY": "Japanese Yen",
  "KES": "Kenyan Shilling",
  "KGS": "Kyrgystani Som",
  "KHR": "Cambodian Riel",
  "KMF": "Comorian Franc",
  "KPW": "North Korean Won",
  "KRW": "South Korean Won",
  "KWD": "Kuwaiti Dinar",
  "KYD": "Cayman Islands Dollar",
  "KZT": "Kazakhstani Tenge",
  "LAK": "Laotian Kip",
  "LBP": "Lebanese Pound",
  "LKR": "Sri Lankan Rupee",
  "LRD": "Liberian Dollar",
  "LSL": "Lesotho Loti",
  "LYD": "Libyan Dinar",
  "MAD": "Moroccan Dirham",
  "MDL": "Moldovan Leu",
  "MGA": "Malagasy Ariary",
  "MKD": "Macedonian Denar",
  "MMK": "Myanma Kyat",
  "MNT": "Mongolian Tugrik",
  "MOP": "Macanese Pataca",
  "MRU": "Mauritanian Ouguiya",
  "MUR": "Mauritian Rupee",
  "MVR": "Maldivian Rufiyaa",
  "MWK": "Malawian Kwacha",
  "MXN": "Mexican Peso",
  "MYR": "Malaysian Ringgit",
  "MZN": "Mozambican Metical",
  "NAD": "Namibian Dollar",
  "NGN": "Nigerian Naira",
  "NIO": "Nicaraguan Córdoba",
  "NOK": "Norwegian Krone",
  "NPR": "Nepalese Rupee",
  "NZD": "New Zealand Dollar",
  "OMR": "Omani Rial",
  "PAB": "Panamanian Balboa",
  "PEN": "Peruvian Nuevo Sol",
  "PGK": "Papua New Guinean Kina",
  "PHP": "Philippine Peso",
  "PKR": "Pakistani Rupee",
  "PLN": "Polish Zloty",
  "PYG": "Paraguayan Guarani",
  "QAR": "Qatari Rial",
  "RON": "Romanian Leu",
  "RSD": "Serbian Dinar",
  "RUB": "Russian Ruble",
  "RWF": "Rwandan Franc",
  "SAR": "Saudi Riyal",
  "SBD": "Solomon Islands Dollar",
  "SCR": "Seychellois Rupee",
  "SDG": "Sudanese Pound",
  "SEK": "Swedish Krona",
  "SGD": "Singapore Dollar",
  "SHP": "Saint Helena Pound",
  "SLL": "Sierra Leonean Leone",
  "SOS": "Somali Shilling",
  "SRD": "Surinamese Dollar",
  "SSP": "South Sudanese Pound",
  "STD": "São Tomé and Príncipe Dobra (pre-2018)",
  "STN": "São Tomé and Príncipe Dobra",
  "SVC": "Salvadoran Colón",
  "SYP": "Syrian Pound",
  "SZL": "Swazi Lilangeni",
  "THB": "Thai Baht",
  "TJS": "Tajikistani Somoni",
  "TMT": "Turkmenistani Manat",
  "TND": "Tunisian Dinar",
  "TOP": "Tongan Pa'anga",
  "TRY": "Turkish Lira",
  "TTD": "Trinidad and Tobago Dollar",
  "TWD": "New Taiwan Dollar",
  "TZS": "Tanzanian Shilling",
  "UAH": "Ukrainian Hryvnia",
  "UGX": "Ugandan Shilling",
  "USD": "United States Dollar",
  "UYU": "Uruguayan Peso",
  "UZS": "Uzbekistan Som",
  "VEF": "Venezuelan Bolívar Fuerte (Old)",
  "VES": "Venezuelan Bolívar Soberano",
  "VND": "Vietnamese Dong",
  "VUV": "Vanuatu Vatu",
  "WST": "Samoan Tala",
  "XAF": "CFA Franc BEAC",
  "XAG": "Silver Ounce",
  "XAU": "Gold Ounce",
  "XCD": "East Caribbean Dollar",
  "XDR": "Special Drawing Rights",
  "XOF": "CFA Franc BCEAO",
  "XPD": "Palladium Ounce",
  "XPF": "CFP Franc",
  "XPT": "Platinum Ounce",
  "YER": "Yemeni Rial",
  "ZAR": "South African Rand",
  "ZMW": "Zambian Kwacha",
  "ZWL": "Zimbabwean Dollar"
}
"""
