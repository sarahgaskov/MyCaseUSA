// get office nsame from code
const Map<String, String> officeNames = {
    // national
    'EFC': 'Eastern Forms Center',
    'FOD': 'Field Office Directorate',
    'IPO': 'Immigrant Investor Program Office',
    'NBC': 'National Benefits Center',
    'SCD': 'Service Center Operations',

    //field offices
    'ABQ': 'Albuquerque, NM',
    'AGA': 'Agana, GU',
    'ALB': 'Albany, NY',
    'ANC': 'Anchorage, AK',
    'ATL': 'Atlanta, GA',
    'BAL': 'Baltimore, MD',
    'BNY': 'Brooklyn, NY',
    'BOI': 'Boise, ID',
    'BOS': 'Boston, MA',
    'BUF': 'Buffalo, NY',
    'CHA': 'Charlotte Amalie, VI',
    'CHI': 'Chicago, IL',
    'CHL': 'Charleston, SC',
    'CHR': 'Christiansted, VI',
    'CIN': 'Cincinnati, OH',
    'CLE': 'Cleveland, OH',
    'CLM': 'Columbus, OH',
    'CLT': 'Charlotte, NC',
    'DAL': 'Dallas, TX',
    'DEN': 'Denver, CO',
    'DET': 'Detroit, MI',
    'DSM': 'Des Moines, IA',
    'ELP': 'El Paso, TX',
    'FRE': 'Fresno, CA',
    'FSA': 'Fort Smith, AR',
    'GRR': 'Greer, SC',
    'HAR': 'Hartford, CT',
    'HEL': 'Helena, MT',
    'HHW': 'Honolulu, HI',
    'HIA': 'Hialeah, FL',
    'HLG': 'Harlingen, TX',
    'HOU': 'Houston, TX',
    'IMP': 'Imperial, CA',
    'INP': 'Indianapolis, IN',
    'JAC': 'Jacksonville, FL',
    'KAN': 'Kansas City, MO',
    'KND': 'Kendall, FL',
    'LAC': 'Los Angeles County, CA',
    'LAW': 'Lawrence, MA',
    'LNY': 'Long Island, NY',
    'LOS': 'Los Angeles, CA',
    'LOU': 'Louisville, KY',
    'LVG': 'Las Vegas, NV',
    'MAN': 'Manchester, NH',
    'MEM': 'Memphis, TN',
    'MGA': 'Montgomery, AL',
    'MIA': 'Miami, FL',
    'MIL': 'Milwaukee, WI',
    'MTL': 'Mount Laurel, NJ',
    'NEW': 'Newark, NJ',
    'NJC': 'Cranbury, NJ',
    'NOL': 'New Orleans, LA',
    'NOR': 'Norfolk, VA',
    'NTN': 'Nashville, TN',
    'NYC': 'New York City, NY',
    'OFM': 'Fort Myers, FL',
    'OKC': 'Oklahoma City, OK',
    'OKL': 'Oakland Park, FL',
    'OMA': 'Omaha, NE',
    'ORL': 'Orlando, FL',
    'PHI': 'Philadelphia, PA',
    'PHO': 'Phoenix, AZ',
    'PIT': 'Pittsburgh, PA',
    'POM': 'Portland, ME',
    'POO': 'Portland, OR',
    'PRO': 'Providence, RI',
    'QNS': 'Queens, NY',
    'RAL': 'Raleigh, NC',
    'REN': 'Reno, NV',
    'SAA': 'Santa Ana, CA',
    'SAC': 'Sacramento, CA',
    'SAJ': 'San Juan, PR',
    'SBD': 'San Bernardino, CA',
    'SEA': 'Seattle, WA',
    'SFR': 'San Francisco, CA',
    'SFV': 'San Fernando Valley, CA',
    'SLC': 'Salt Lake City, UT',
    'SNA': 'San Antonio, TX',
    'SND': 'San Diego, CA',
    'SNJ': 'San Jose, CA',
    'SPM': 'Minneapolis-St. Paul, MN',
    'SPO': 'Spokane, WA',
    'STA': 'Burlington, VT',
    'STL': 'Saint Louis, MO',
    'TAM': 'Tampa, FL',
    'TUC': 'Tucson, AZ',
    'WAS': 'Washington, DC',
    'WIC': 'Wichita, KS',
    'WPB': 'West Palm Beach, FL',
    'YAK': 'Yakima, WA',
};

// get category name from category id
const Map<String, String> categoryNames = {
    // I-102
    '142': 'Initial issuance or replacement of a Form I-94',

    // I-129
    '137-E': 'E - Treaty traders and investors',
    '137-E3': 'E3 - Specialty occupation workers from Australia',
    '137-H1B1': 'H-1B - Specialty occupation - Visa to be issued abroad',
    '137-H1B2': 'H-1B - Specialty occupation - Change of status in the U.S.',
    '137-H1B3': 'H-1B - Specialty occupation - Extension of stay in the U.S.',
    '137-H2AN': 'H-2A - Temporary agricultural workers - Named Beneficiary',
    '137-H2AU': 'H-2A - Temporary agricultural workers - Unnamed Beneficiary',
    '137-H2B': 'H-2B - Temporary nonagricultural workers',
    '137-H3': 'H-3 - Temporary trainees',
    '137-L': 'Intracompany transferees and blanket L',
    '137-O': 'O - Extraordinary ability',
    '137-P': 'P - Athletes, artists, and entertainers',
    '137-Q': 'Q - Cultural exchange visitors',
    '137-R': 'R - Religious occupation',
    '137-TN': 'TN - United States-Mexico-Canada Agreement (USMCA, formerly NAFTA) professional',

    // I-129CW
    '129-CW1': 'CW-1 - CNMI-Only Nonimmigrant Transitional Worker',

    // I-129F
    '134A-K': 'K1/K2/K3/K4 - Fiance(e) or spouse and/or dependent children',

    // I-130
    '134A-F21': 'Permanent resident filing for a spouse or child under 21',
    '134A-IR': 'U.S. citizen filing for a spouse, parent, or child under 21',
    '134B-F11': 'U.S. citizen filing for unmarried son/daughter 21 or older',
    '134B-F24': 'Permanent resident for unmarried son or daughter 21 or older',
    '134B-F31': 'U.S. citizen filing for a married son or daughter',
    '134B-F41': 'U.S. citizen filing for a brother or sister',

    // I-131
    '141A-RT': 'Re-entry permit or refugee travel document',
    '141B-OTH': 'Advance parole',

    // I-140
    '136A-E11': 'Extraordinary ability (E11)',
    '136A-E12': 'Outstanding professor or researcher (E12)',
    '136A-E13': 'Multinational executive or manager (E13)',
    '136A-E21': 'Advanced degree or exceptional ability (E21)',
    '136A-E31': 'Skilled worker or professional (E31; E32)',
    '136A-EW3': 'Unskilled worker (EW3)',
    '136A-NIW': 'Advanced degree or exceptional ability requesting a National Interest Waiver (NIW)',
    '136A-NUR': 'Schedule A Nurses',

    // I-212
    '144B': 'Permission to reapply for admission after deportation and removal',

    // I-360
    '135B': 'All other special immigrants',
    '135C': 'Violence Against Women Act (VAWA)',
    '135D-RW': 'Religious workers',
    '135E': 'Afghan or Iraqi Translators and Afghan or Iraqi nationals who worked for on or behalf of the U.S. government',

    // I-407
    '407': 'Record of Abandonment of Lawful Permanent Resident Status',

    // I-485
    '131A-FAM': 'Family-Based adjustment applications',
    '131A': 'Employment-Based adjustment applications',
    '131B': 'Based on grant of asylum more than 1 year ago',
    '131C': 'Based on refugee admission more than 1 year ago',
    '131A-HRIFA': 'All other applications',
    '131T': 'Based on an approved T Visa',
    '131U': 'Based on an approved U Visa',

    // I-526
    '133IP': 'Immigrant Petition by Standalone Investor',

    // I-526(L)
    '133CN': 'China - mainland born - For use by an investor who wishes to immigrate to the United States',
    '133ROW': 'All other areas - For use by an investor who wishes to immigrate to the United States',

    // I-526E
    '526IP': 'Immigrant Petition by Regional Center Investor',

    // I-539
    '139A-OTH': 'All other change of status applications',
    '139B-OTH': 'All other extension of stay applications',
    '139A-B': 'Change of status to B nonimmigrant',
    '139A-FMJ': 'Change of status to F or M student or J exchange visitor category',
    '139A-H': 'Change of status to H4 dependents',
    '139A-L': 'Change of status to L dependent',
    '139AC-H': 'Change of status to H4 dependent with I-765',
    '139B-B': 'Extension of stay for B nonimmigrant',
    '139B-FMJ': 'Extension of stay for F or M students and J exchange visitor category',
    '139B-H': 'Extension of stay for H4 dependents',
    '139B-L': 'Extension of stay for L dependents',
    '139B-T': 'Extension of stay for T nonimmigrant',
    '139B-U': 'Extension of stay for U nonimmigrant',
    '139BC-H': 'Extension of stay for H4 dependents with I-765',
    '139C': 'Reinstatement to student status',

    // I-600
    '134B': 'U.S. citizen filing to adopt an orphan',

    // I-600A
    '134-A': 'U.S. citizen who plans to adopt a foreign-born child',

    // I-600A3
    '134C': 'Request for Action on Approved Form I-600A/I-600',

    // I-601
    '144AB': 'Waiver of Grounds of Inadmissibility',

    // I-601A
    '144AC': 'Provisional Waiver of Unlawful Presence',

    // I-612
    '144A': 'Application for a waiver of the 2-year foreign residence requirement based on exceptional hardship or persecution',
    '144D': 'Application for a waiver of the 2-year foreign residence requirement',

    // I-730
    '145': 'Petition for accompanying family members of an asylee',

    // I-751
    '148A': 'Removal of lawful permanent resident conditions (spouses of U.S. citizens and lawful permanent residents)',

    // I-765
    '147-C10': 'Application for Suspension of Deportation/Sec.244/NACARA/Cancel of Removal [(c)(10)]',
    '147-C11': 'Based on parole',
    '147-C18': 'Alien with Final Order of Deportation Under an OSUP [(c)(18)]',
    '147-C9': 'Based on a pending I-485 adjustment application [(c)(9)]',
    '147-OTH': 'All other applications for employment authorization',
    '147-539C26': 'Based on being an H-4 spouse of an H-1B nonimmigrant (filed with I-539 H4) [(c)(26)]',
    '147-A18': 'Based on being an L-2 spouse of an L-1 nonimmigrant [(a)(18)]',
    '147-A3': 'Based on being admitted as a Refugee [(a)(3)]',
    '147-A5': 'Based on an approved asylum application [(a)(5)]',
    '147-C26': 'Based on being an H-4 spouse of an H-1B nonimmigrant (Standalone; not filed with I-539 H4) [(c)(26)]',
    '147-C3': 'Based on a request by a qualified F-1 academic student [(c)(3)]',
    '147-C33': 'Based on an approved, concurrently filed, I-821D [(c)(33)]',
    '147-C8': 'Based on a pending asylum application [(c)(8)] -renewal/replacement',
    '147-C8I': 'Based on a pending asylum application [(c)(8)] – Initial Application',
    '147-ELSAL': 'Based on TPS for El Salvador [(c)(19), (a)(12)]',

    // I-765V
    '147-V': 'Abused spouse of an A, E-3, G, or H nonimmigrant [(c)(27-30)]',

    // I-800
    '800M': 'Petition to Classify Convention Adoptee as an Immediate Relative',

    // I-800A
    '800A': 'Application for Determination of Suitability to Adopt a Child from a Convention Country',

    // I-800A3
    '800B': 'Request for Action on Approved Form I-800A',

    // I-817
    '150': 'Voluntary departure under the family unity program',

    // I-821
    '821SD_I': 'Sudan Initial',
    '821SD_R': 'Sudan Re-registration',
    '821SO_I': 'Somalia Initial',
    '821SV_I': 'El Salvador Initial',
    '821SV_R': 'El Salvador Re-registration',
    '821UA_I': 'Ukraine Initial',
    '821UA_R': 'Ukraine Re-registration',

    // I-821D
    '149-CAT': 'Renewal',
    '149-ECA': 'Request for Deferred Action',

    // I-824
    '153': 'To request further action on an approved application or petition',

    // I-829
    '148C': 'Removal of lawful permanent resident conditions (immigrant investors)',

    // I-90
    '140A': 'Initial issuance or replacement',
    '140B': '10-year renewal',

    // I-914
    '914T': 'Provides temporary immigration benefits to noncitizen victims of trafficking and their eligible family members',

    // I-918
    '918ABFD': 'Petition for a noncitizen who is a victim of qualifying criminal activity, and their qualifying family members (Time from Initial Filing to Bona Fide Determination (BFD) Review)',

    // I-924
    '924-EB5A': 'I924 - Application for Regional Center Under the Immigrant Investor Pilot Program',

    // I-929
    '929': 'Family member of U nonimmigrant',

    // I-956
    '956-A': 'Application for Regional Center Designation',

    // I-956F
    '956': 'Application for Approval of an Investment in a Commercial Enterprise',

    // N-400
    '160A': 'Application for Naturalization',

    // N-565
    '165': 'U.S. citizen applying for a replacement of naturalization or citizenship certificate',

    // N-600
    '161A': 'Application for recognition of U.S. citizenship',

    // N-600K
    '161B': 'Application for Citizenship and Issuance of Certificate Under Section 322',
};
