Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11020095.outbound.protection.outlook.com [52.101.84.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC0C1AA7A6;
	Wed,  4 Feb 2026 11:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770203810; cv=fail; b=HPLvV9+suo6oVwYOuHMBSGlzxc62ZtGWym3M+vBoGRylsNjqVkuSHE7ohG3o5a4XzGwlFOkEMjttIMStKw4iyE2pJPWRJCudRTSKroqzSMBtaMIDzc90kiFNe2bbXHnx+p1FhuU0Wk6Fqx29AxBMw8UD84keG1DghYDlg5P+DAw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770203810; c=relaxed/simple;
	bh=TnWQLX5NDdNSAWvIgFDEQOSW1Ma9D2Qfk57O5cETrUI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=m/IZSCRg2aBmqpOQVDY/jURvLFTvHctShLks363Z8+6pyDppULpv20kLBY6EZkqGGGvmVqCqJ/LRfU2a98nvbXHIJAyP2uyFF4cViEoWivEagTXSERT3dRL+62VJgA9KP/GGVkYfaQMuZfiVKbQVgqRxrcZ1pBnsV55yljzBhfM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com; spf=pass smtp.mailfrom=vaisala.com; dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b=Rq6WcPt2; arc=fail smtp.client-ip=52.101.84.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="Rq6WcPt2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iGq8lf1de7E22SfIlrxsPR93KovllNnZvI73bTT3lEMlrlxfXPdc4VKuaIM+aaAv3kj7g9zjykb+ZXo/Amj1E/myyg/4vAr5W94naatBzBvIo9q+7h/Y1mqdOhDI9j7D/HfKAoIkXtWv3bLOnrZQrnm6febvjsjOAUtxH3Z1VuUFUATgj/jxiIcI+NGT4AiMEu2Q7CkxQW+Yozz6ZvCi8BvApcF7gzseZgB9/2KOHU0kkj5F97JjI1ctUuQ1yNXOQi3KWXs4bNsDaZqT2ihKCwdu8anZrg5jhrQXCLGy9uV6lxJo1gDcuSlqhKssetsi97m+3O/Sboj1CX8+CTioJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gOSGlRgBULbrHZyiMUmwC45kB6dUkatiMIb4/kWxnik=;
 b=K3+OL1wAZoIKnJvxAJ+QKbWn5Tncdbq7qy5br5B5uOuLbKB3apOnIV7NnU/nwPVsZzJWaIv9nqIn+cZ5Qmpc82GIhkcfmlAceJXFh3Nu3B9FRnYjPBR8UW1DBhQA5YCa6+Xap03FhMjEQx+SHhGyCQAXeS8M6YJah2ZLqx5o/Ir7dNzSfK+r6pconmgjlnd/MLVVpbS6tirEA15k4ULOzzSwwQLxOKXNZA4pKEXd1fMJmEVrz7HeaSEyNm+gYOMqUBMAa/1xo3Jj8XjeSQ00GFuRVc8vIutw7gcTODbCesZwvaoIyCF0sbaT8OO+NTnbaPTRg7qxOTK9lvmoaVmMgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gOSGlRgBULbrHZyiMUmwC45kB6dUkatiMIb4/kWxnik=;
 b=Rq6WcPt2TsBA2g/4n1rlSTggu70jDTAqDZgdc/LGPPORHYQ9aHdhxMeW+x1l8+EjEm7tGz1FYWFfKM+mq7S1Yoj4LNLJNB69pVxjUqZzhi7RkNRLn3OLtW/Oi7x4xCzHA+U74Em5b04A9NiopK6FeyVCaVH5YCdRU7TlkMaxr4akzdDoiCruOZarvQg57fkCprDOrXsmVLcGIVLqwHKNaH76jYrgupqa8sy2gV8lRZkdXzCeyJwszwjwkFpggiYv4V9XfjG/DcmskPUSA9CDOanXyKENb17Y2QFnq1D5lFiS2vrChwSwa6e44iYTYohdv9zFPvw3UsBnaPwrE1L6Zg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from AMBPR06MB10365.eurprd06.prod.outlook.com (2603:10a6:20b:6f0::7)
 by VI0PR06MB10593.eurprd06.prod.outlook.com (2603:10a6:800:316::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.13; Wed, 4 Feb
 2026 11:16:41 +0000
Received: from AMBPR06MB10365.eurprd06.prod.outlook.com
 ([fe80::addd:5e9b:7273:8049]) by AMBPR06MB10365.eurprd06.prod.outlook.com
 ([fe80::addd:5e9b:7273:8049%6]) with mapi id 15.20.9587.010; Wed, 4 Feb 2026
 11:16:41 +0000
Message-ID: <0a3eacf2-a68a-48e1-8b88-10dfe4f0ab88@vaisala.com>
Date: Wed, 4 Feb 2026 13:15:36 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/4] iio: industrialio-backend: support backend
 capabilities
To: David Lechner <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <noname.nuno@gmail.com>, Michael Hennerich <Michael.Hennerich@analog.com>,
 Nuno Sa <nuno.sa@analog.com>, Lars-Peter Clausen <lars@metafoo.de>,
 Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko <andy@kernel.org>,
 Olivier Moysan <olivier.moysan@foss.st.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260130-b4-ad9467-optional-backend-v5-0-7da803ba7326@vaisala.com>
 <20260130-b4-ad9467-optional-backend-v5-1-7da803ba7326@vaisala.com>
 <688cbfb1-0944-492a-929d-91ebb9ab22fb@baylibre.com>
 <812a8c408c2e3a87ebe1ddc983acdc2cebe3b36b.camel@gmail.com>
 <30cf63eb-50ba-445d-a78b-d6532aacdc8e@vaisala.com>
 <177d62446d9c2098bbfe8b0f7fd9418d5afb60fc.camel@gmail.com>
 <aa5010ba-27bc-4c0d-9fce-8264216d4aa1@vaisala.com>
 <215cabfd-497b-4f22-ace2-ff8f6145d79f@baylibre.com>
 <e9f9e1b0-4cd7-4d6c-a7b9-25ea0e6e774a@vaisala.com>
 <c9a5b1b3-760e-4d55-b058-e461507fcad0@baylibre.com>
Content-Language: en-US
From: Tomas Melin <tomas.melin@vaisala.com>
In-Reply-To: <c9a5b1b3-760e-4d55-b058-e461507fcad0@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: GVYP280CA0031.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:f9::9) To AMBPR06MB10365.eurprd06.prod.outlook.com
 (2603:10a6:20b:6f0::7)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMBPR06MB10365:EE_|VI0PR06MB10593:EE_
X-MS-Office365-Filtering-Correlation-Id: c3004fc0-152e-486a-2fc5-08de63dedf1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VDVmdm9WOTVoaFJSRjB3d1hPRHlPMlJ6VlVualI5WnRpaXJmekZSS3h1SmNx?=
 =?utf-8?B?OUtoNWRCcUdxcUYwU0JQc0JEdVVvc2JKTk11bGNYemJScGFTeHE4bWY3Ym5h?=
 =?utf-8?B?TDloS3JVYXpxTHFNb2dBNURzR0pyL2ljTTJ1emJOZloweFpNNm9SbTByZGFs?=
 =?utf-8?B?aTVZdXNpWGlKQzhpbEtiOXVRTHhmOTFjdFJoZEIwUFg4SnhhcGhwMFdIWDlK?=
 =?utf-8?B?ejYzT3dLV0lreGFIYlFGQjk3R1krdU1rc2NUUWdsRnpmci9QY3dIRGZQZy85?=
 =?utf-8?B?dlpDK05yTkFDUGpMMTlhM0tvRm96WEVVc1N5Q1NvKzhVc3BDYWJNaWJJY2Ro?=
 =?utf-8?B?dVRwNzlCSXhWRTNiTHQ0MTdWbFBkRDZMM3VDV1hhWGZ5Z2EwZi8xN1owczlR?=
 =?utf-8?B?TXhWSzJOKzZCSU1FNDNzeFIxakgxbkRWbW43VGZYUUh4bC82cVp1Q2FuQTNM?=
 =?utf-8?B?THZVeGxmejYvb2haL3RjU2wzTU9IdzBjV2dXTFV2aEpVYmZoenNGN29UV2k4?=
 =?utf-8?B?cVljMmNvcFhJWC9RK0FROUVoYVprRk1jSGRmL3R4eXp2dGxtV2xvcWVzei9F?=
 =?utf-8?B?cVBFa25Jc3lTRTNuZXozaGVNY0phdlhJc2hUY0F1eTNZdER0dDBjYStuUFhE?=
 =?utf-8?B?Vk9BalhqK0RWcmZ4SG1jOVBMb0lsSndJVW93RTh6TEhXakZqL3RSVHY5WW8z?=
 =?utf-8?B?L0J0TE9rckJVYklYL2M5M29RVFVJeGg4Z3JDNFc1WCt3NlR3MXdHdE1uSDQy?=
 =?utf-8?B?NE5DN05vdjRNQWJqVUZnOUxpUWFlNzdTcTNXQi9teFpBdzFndDk1Q1A3NGhC?=
 =?utf-8?B?V2hHbEpIWGkyQXRiWmEyRHdTQWZQajFHZDJXdlFCL2wwaVRZWEZ1MnZMa1JJ?=
 =?utf-8?B?NFZXbW9KMDE0eU9kSkk3OHV5cHNJS1lBL1pnOHFIQzIxWis5dG4xV0EyWWJZ?=
 =?utf-8?B?cTk2V2VBQzNFcjZnTWNxZDFpLzVpL3RHNkpzampUR08xelpPZFUxZUlsaTFT?=
 =?utf-8?B?MTNaY0VvSDZYVVRvOXl6di84eWtHamhqcTFsVVVCcHRRT3hmaHhPUGlQSmky?=
 =?utf-8?B?VjBZTUZTUWpRbDN5YjM3N0ZQZ1FMTXFhT2VsY1VKYUtHd1lIL0lhekNocjA4?=
 =?utf-8?B?RXdyRy9wRUY2RndDT0tZWEZ6c24xOWNFWmlnbTN3dmhQOVcyWmpUTnNqSURE?=
 =?utf-8?B?OTB3SlRKTXBqekF4cWVjUnExR0pzaUlTckloZWNsdFdoOVpMWWdBdUVCcEow?=
 =?utf-8?B?NjhuNUJOYVI2OGRSaSt5b1Y1V0xjeHh2U0pqazdsbWt3TlJNUVVOYlBIT1o5?=
 =?utf-8?B?Vk5KOWxJR04vakpVa0hMSFk1M1dsTmlWc0xSOTBQdkhpSTYweEFKSVVpSlhE?=
 =?utf-8?B?VGtwQUZJU3FRQXM5MFJ3cUU5UFJuS3NaR0xJbnk2dS9jekZlSWVVYThBMjNB?=
 =?utf-8?B?NDB3SU8rYXRGbU5rYjl2UGhPNDFJSms0OHJZcFYxREQ5VzZPN2xYV1lBKzZ3?=
 =?utf-8?B?RTZOb3ozQnNsckVhd2Q2YTBRUHNDYWlUQVpvTnVYbkdTUnZkV1NrMTh0cERZ?=
 =?utf-8?B?U2d0Qmx2R29YVTh2aVhMQjN4S0ljT2VJaE1oNUZjaXN3RWhoWDB4TE9ETzJK?=
 =?utf-8?B?bUVmQjMvcEFZQTMzSVJFbjBsRDZ2QU1OTzRxMWRwRDhsdHdRZmxxYzVkYk5t?=
 =?utf-8?B?OXJUV0JzcU93Lzg5UUFzZ1VkcXlCRERWWFFwWUVzRENONXFMdTF3T2t1anZu?=
 =?utf-8?B?dGl2U2xWeHRKOXBieWJMaVI3d3A0VG5ZVU1RZ1UwS1NYby8rRWJnQ0dKdVVh?=
 =?utf-8?B?OEc2cHFNbVRuRWliTzN2WmQ3TGVIMDlYTUh5TUNKdXFDeUcrVXpyNWhhSGlx?=
 =?utf-8?B?Y3R6ZjdFRHZ3ditrYWY2OTBJZ2dOZStkcHY0aGpPc0dNa2ErYWtGZ2RuV3Bu?=
 =?utf-8?B?THBHUSs2WlZQTkJCVG12b2JWODFmNzNsYnRNWG5qdGN2MW9ETmlJQXdneW9Y?=
 =?utf-8?B?akg0MHF4T3JTaGFaWm5qVGI3NGR0TDBPL2NoWEU5ZW5WVW1xY3lKbm1EWFRN?=
 =?utf-8?B?UDhKZWRHbC9QU0ZmMU4zT2dzN0phZWRiSkVaLzlrZnRaVmZFMWdnWEo4RERM?=
 =?utf-8?Q?+MW8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMBPR06MB10365.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bnRqL2k0Q0VPWStsTlpRTVlQT3BYRDErTTcwSXpwakx4ZXpHYnZpanNDcXgx?=
 =?utf-8?B?ZXFhNlJpdkVnS1RvcGFtdDlScWRPSm5XemRqVEQ4V3ZjNmo5VlNkaGRVSUpa?=
 =?utf-8?B?QXhiRDAzOXh1QjRYUVF0L1QzL0wvL1k1Q2RUamJZcmtyME15OG1raUVJWE4z?=
 =?utf-8?B?RUR3aHp6a1QzZW5KLzkyU0FxOGR6UndwNVZ1aVMreFlpWGs3cEJwdWlZYnFj?=
 =?utf-8?B?TjA4NlNuZURJbGJ6QWZraXBOZmg1OTdjOTBoa1pjSHFWaU1ySHpIbDE5QUxZ?=
 =?utf-8?B?OGh5czdBTDI1VDdvVnJPbFQ2UVpSNU1sRjhqczkyc3h2cmNJREhBNjBURnho?=
 =?utf-8?B?ZDNmeWVzdnZwdVB5VnFtUllZdzFreXlnb1liUlhNM2RkWXdJa2lNendzYmhM?=
 =?utf-8?B?QUY1ZnNqV0lzWHNPNS9XODlURkRIYjIvcFV5RTM1NlVIM3RrcUhXaDc2WnhP?=
 =?utf-8?B?TzJuU1FGWkVIZ3JqcXJJQ0YxUVcyVzM3eUJ6ek13cU9TOEZtSVUwbStRYVVp?=
 =?utf-8?B?dms1QnMvREdsNE5nMkFpTHRjQVp3Zm4xRE42ajdxT3E1TTNXdVFCNmtBRHo2?=
 =?utf-8?B?a0U3QUQ2aTJibkt0RGVSVDM2QWY1UXRYWnpITlJnZ1U4ZnQ0UFlQdUFnTDJ3?=
 =?utf-8?B?eWx1RVE5OGd4aUl2aWI1aktZNzNCeHB1TWpTRi9uM0krais5ZnlwQW1kdFIv?=
 =?utf-8?B?ZGZ5R0drdlJlVm1vMXFWNnlRT1FNWHBEQVU0cjNrSzRpS2tlMG9JWGZkZTB0?=
 =?utf-8?B?RWpZcjhoQ1doeG5LZFRCR081ZFRwZ2JqNUUwWUpLdGx2eCtBR0VWaVpZeDdR?=
 =?utf-8?B?emtvZ0w2M1FseXcrOTA4SVlHQkdmYXJxdWVMTDcyb1ZiTEd3d1REVGJIaGp2?=
 =?utf-8?B?cHR3ZFpSd0h4dTk2M2xmS0UwVHhzYkY3ajBxangwd29yWi9MSmFwMjkxZnha?=
 =?utf-8?B?VFZYWXd2R293SXNMOGNQS0JzWkppTy8vL2dIOFFzL0RBOGdxRkF1ZFI5UjJT?=
 =?utf-8?B?RkdLT1RnbzBnMTI3L2loa2hHaEVYTFRnR1V2UlBGTllvQlZ1VFkvcTB2UTBj?=
 =?utf-8?B?RnM2cVRJRUdSUi9DdTFoS0tXK2xPbTRFY3lQUDVYRDZQaWw5a0R3QjFIN0dM?=
 =?utf-8?B?ZEZxSlVLS2t1RVZSNDNGT2hiQjVNaWtBZWdOdzdYQWFRS3BHRUdCaUMwY2tQ?=
 =?utf-8?B?SFgzQS9Oa3N1Y0lRaHdNd29kTkRxZ21SZ1BBU0E2YUY1eFdiWi9nbm9aSENC?=
 =?utf-8?B?c0RVa2N4RzFNUTNkbm5UcVpXR1RNR1kwbktmcVdnUVlnRVZhWFBXcUsyZ0xa?=
 =?utf-8?B?WmhZVTZaSkl2VjhZaUlCQnBJL1FsMkpkTTZ3NWpKOTBVeWwrdDJ3eThVOE50?=
 =?utf-8?B?VU1TNEs3YXpwZHgycjFqbG4rcTkzY2FTbXZUaGVXMkc0R2JzSFBqY1BubCtz?=
 =?utf-8?B?N0NabFVWR2Ivd3lBQnVqSmhzMGtHcTVORVFzVjJEc1RpSDBVQnBabmxUUXU2?=
 =?utf-8?B?ZmF5M052dVZFSU5WWHRFS2Z0T1BUcENDQmM1d3hYcU1jZGNvbitKWDdzYUYr?=
 =?utf-8?B?dkFDeUIyb0lRMm1OejduSlhBNFpzaE1rSTBzSzl5a0pFZW9nd084eHllb0JS?=
 =?utf-8?B?YjIvbTZuQnlpVGRWZFk1VmRIUElEMDVyREVISUV0cUxuUkJtdkVra3M2aGNN?=
 =?utf-8?B?RjdOQVpLaXFuV3ltUlpmSFlmd1creW12U1BTRWsrZ1JqUUpiWGZZS1pHSi9K?=
 =?utf-8?B?WlU1b3pXcjF0R1REYkZ0d0RTeStCNzVIWG5EUlhqdlZFUVk4bkFOYjF5S1I3?=
 =?utf-8?B?YU96MDhMZUVOZzIxYXl6cC9tZTlBVWFHZzcvdW9lMTM3ZnN5NkNZUzdsaWxJ?=
 =?utf-8?B?eDdZaXIrL3BzbHlXR0E4bXJybytkYlpmYi95V24yS1d4TEUrK0ppQjlVUm5Q?=
 =?utf-8?B?SGsvSEFuMURCeVpvQ2RsNU4rQlNacnlSRFF0VWdOZDE0TmVIdlBDS0YvVnBK?=
 =?utf-8?B?d3hOcFJOakprd3FYaDBlR1B0VUNPWjRBTmE5RXpka1ljYUdCaTdkMTZJNHFs?=
 =?utf-8?B?UTdBKzdlV3hkZ2VwbFU3Ykc0L1prblZBTXBIMnhiSDNhbzN4Y0hnQytlWXlB?=
 =?utf-8?B?V0p5SjZOMWdYc3dva3pKekNsaG9sZVNYV0pDUFA1dTJCQXFNd3BqU01MN0xq?=
 =?utf-8?B?SHRGcFZjOU5OWVBpVXMyekNSNmEySnp4NG1ZRHlvaHFZWG1nMlA3TlN0OC9w?=
 =?utf-8?B?MDgyaTBRT2R2bjE1MWZtMzlXNS9Ca20wSXdMTmZjMEl6aVVOSkM1d0FzajN4?=
 =?utf-8?B?YVRrdkZBMi9XTGtCbFFrNzB4bGRVL3lUK0xQMkNrS1pJcEVuVk1RN1pNWEhh?=
 =?utf-8?Q?yMGUvt0RhyEZvUeA=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3004fc0-152e-486a-2fc5-08de63dedf1c
X-MS-Exchange-CrossTenant-AuthSource: AMBPR06MB10365.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 11:16:41.3279
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QNSEit/FLYdMSqOaxl7RSZAFnZcJexS103RcI/gC3FJMYHDvVsUAfl+wZjEqClbhKqLamGrZ3xTU2/9Jpp6Rdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR06MB10593

On 04/02/2026 03:07, David Lechner wrote:
> On 2/3/26 3:50 AM, Tomas Melin wrote:
>> Hi,
>>
>> On 02/02/2026 17:50, David Lechner wrote:
>>> On 2/2/26 7:04 AM, Tomas Melin wrote:
>>>> Hi,
>>>>
>>>> On 02/02/2026 14:40, Nuno Sá wrote:
>>>>> On Mon, 2026-02-02 at 13:08 +0200, Tomas Melin wrote:
>>>>>> Hi,
>>>>>>
>>>>>> On 02/02/2026 12:28, Nuno Sá wrote:
>>>>>>> On Sat, 2026-01-31 at 14:30 -0600, David Lechner wrote:
>>>>>>
>>>>>>>>
>>>>>>>> Do we actually need this one? Alternative could be, for example:
>>>>>>>>
>>>>>>>> int iio_backend_enable(struct iio_backend *back)
>>>>>>>> {
>>>>>>>> 	int ret;
>>>>>>>>
>>>>>>>> 	ret = iio_backend_op_call(back, enable);
>>>>>>>> 	
>>>>>>>> 	return ret == -EOPNOTSUPP ? 0 : ret;
>>>>>>>> }
>>>>>>>
>>>>>>> I would prefer not to assume we can ignore the backend not supporting
>>>>>>> the call. It opens up the question for other operations.
>>>>>>>
>>>>>>> My preferred way for this kind of fundamental operation (enabling/disabling)
>>>>>>> would be to check with DT maintainers if we could have some kind of fixed-backend
>>>>>>> (fixed in the sense the HW is present but not controlled by Linux) dummy device that
>>>>>>> with implement a no-OP enable/disable().
>>>>>>
>>>>>> There is also use cases for the always_on cap with a configurable
>>>>>> non-dummy backend. Some applications are such that the driver should
>>>>>> leave the enabling/disabling up to the user space consuming the data.
>>>>>> For this case it's great to have the frontend leave the backend enable
>>>>>> alone using this capability.
>>>>>>
>>>>>
>>>>> I would argue the above would be something to take care at the frontend level. The way
>>>>> I see it, the always_on cap is pretty much saying that we can't really control the on/off state
>>>>> of the backing device and we just assume it's on. 
>>>>>
>>>>> If we can control it but we need it always on (for some specific usecase), I would say that should
>>>>> be handled at the frontend and just enable the backend once. Also note that as of now, I think all
>>>>> of the users (or most at least) we have just enable the backend during probe and leave it on until
>>>>> we unbind the device.
>>>>
>>>> Yes, this is debatable. It's not necessarily always on, but should not
>>>> be enabled/touched by the frontend during probe.
>>>> But anyways, having a capability that says if the enable/disable feature
>>>> is available, is in any case useful and what I was planning on
>>>> leveraging in my use case.
>>>> Fundamentally, with the capabilites as now proposed, it is possible to
>>>> select what features of the ad9467 are available, in addition to the
>>>> basic requirements.
>>>>
>>>> The ALWAYS_ON capability could be inverted, like CAP_HAS_ENABLE_DISABLE,
>>>> but to me, the ALWAYS_ON naming still seems the better option.
>>>>
>>>
>>> Ah, this is what Jonathan mentioned before about this really being a
>>> restriction rather than a capability.
>>>
>>> Perhaps we should have a separate restrictions/quirks flag? If the flag
>>> means "do not enable during probe" then a better name would be
>>> *_DO_NOT_ENABLE_AT_PROBE.
>>>
>>> And I agree with Nuno that if the backend can be enabled/disabled later
>>> (after probe), it should still be managed through the frontend driver.
>>> There should be no usespace access directly to the backend without going
>>> through the frontend.
>>
>> Thanks for the input, that use case is slightly different from normal
>> usage, let's keep it in mind if actually required. For now, the option
>> to just leave the enable/disable alone is what would help to solve
>> smooth integration with this device for me.
>>
>> ALWAYS_ON does not seem to get much votes here, but how about calling it
>> something like IIO_BACKEND_CAP_AUTO_ENABLE or
>> IIO_BACKEND_CAP_HAS_ENABLE_DISABLE?
>>
> IIO_BACKEND_CAP_HAS_ENABLE_DISABLE seems the most sensible given the
> way it is used in the ad9467 patch. Although IIO_BACKEND_CAP_ENABLE_DISABLE
> would be more consistent with the other flags being added since they
> don't say _HAS_.
> 
> Probably IIO_BACKEND_CAP_ENABLE is enough to imply both if we want
> to keep it shorter.

I would agree that IIO_BACKEND_CAP_ENABLE should be clear enough. I'll
use this in the next version.

thanks,
Tomas



> 
> 

