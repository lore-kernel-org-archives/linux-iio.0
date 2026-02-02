Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11021081.outbound.protection.outlook.com [52.101.65.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FFAC1B4F1F;
	Mon,  2 Feb 2026 11:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770031169; cv=fail; b=QwlV/dkI8uEhlYpt86Io4t1bO2u6DwMfvDSLxe5qBbMFErfLAPXFgoiqYLFJl+9+uprbcthklVsvk6zzU7UXEG03TXv/NIbRMEa6Y5CLVwTc8/Bm0xpyITGrBHtTqY7RtFZb/zu/BWg+b51Tc8lbQRxvJX8SWc9VLIajlFiVkHk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770031169; c=relaxed/simple;
	bh=x/hXkkDR/0ve5HEr30KdhNWOLIHrGuJwg2FQm3RgIcc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=R3yQ2Krs6gBf7lZBqkj3pnQ8iN4rMroT6R6lmHBqtXdQmHOJhfoLFufokDZae3c6y60IkaGhvzGs4q3CObL8SVfFeIfRSDrvuDgxNqj3WnHHjPdCMHLKUGXdfw76n+cYvXhwHq6AACrQG+YSfUccHlnVu/bfl2gb7jTGceiqgRQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com; spf=pass smtp.mailfrom=vaisala.com; dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b=Bs+imPJy; arc=fail smtp.client-ip=52.101.65.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="Bs+imPJy"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aM7Zz22aN+I8x/idIjl3WBGreIeRGiYuDgmmqZL2hhXVxdTE/NVx2EmsWYiaf9inQVNErUZlCrHbuGyRFlmTOCH5fjwlUeGeIVfo1rBzjnQu4Zu18By6yZ9QBAakKEi7t30/Cxl9ExkVLNXVXL3+RRl0RoGmhg9oYCqXsRlGVW9puiPqJO0ACwj3uzb1O10Npn76noC7WL6DRMlNUoBRSCD4+eBW+BEcsj4zsCjhoYKOgtaQYJylo2aSHcnQEo3alUKzUFhjOnfJhQ5S/29hsjYStNJSxurd0QF0UWfOgp0weUGMigvcNiv3DE1Mm6pWhwAvLRK32DLHAjBQ3QtxdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1zqb3x/JH7ilkeee+weIy7P9WiKBc6Bhnk9hRn8/jk8=;
 b=uxI0mnsYBO2yja8oS8KiDRa+FdirTkMZClmMaUmVCWOMeew31XmA+xJlBJNAv8/Pmb8sY3tpD77myEDXWQZnhaKY7Gvq/6GMcOT3yf8uIRzsBiUxnFk15+jPoOM6qcrbmPZCuBax0sF3+aOHGhliPSoQR8mSyxQ0vEacEFmxkGMXrSZJiW7znKTGQ5xO++xwlmsLpJ4/O2UXPevsUQ5QnQiVODSA8a0L4LMZV9GKtIYuQ16QpwX9ZcAMqIEPi/l+lwM92bpXiNJuP4q5Bxtlx4OAWE/Yu2MnTL8rRhe8QbIQR8jrbRwDN1xWVytIeOnKHs0AJ4QDsV3D4Zqc8WsA0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1zqb3x/JH7ilkeee+weIy7P9WiKBc6Bhnk9hRn8/jk8=;
 b=Bs+imPJyIX8b6sN1/QcYTC+vgsnovvxVDIwF+EdIpJ6bpai7edxiJz/ff6DRVP0igFa8Jw9u7kOG7zEarz+Lv/0Dgrcnu+6LlzJ5sWZWs+fqbjXAquPxX2WVD/pUnrLB6s9Kwk3I1T9Xrkyd72E9Z2FYZk/+nXTWxtmFsBEF61N0hCy5hOhfZ2zT81Eqp3UjvZVIrVc4/NPNfgIx5dTUo4KPKfAxDDpAb7xI0lRtgZPhcGA4MKEgDhwwyP48HZWQeg3huOls9t+DmCxkwYy5Wcn5QDXTJZSKBwKIPTOfMkaUAZTJVYXawvnPhjBoaUhjuDaTpRbONmqxVSiT63a09w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from AMBPR06MB10365.eurprd06.prod.outlook.com (2603:10a6:20b:6f0::7)
 by VI1PR06MB6447.eurprd06.prod.outlook.com (2603:10a6:800:126::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Mon, 2 Feb
 2026 11:19:20 +0000
Received: from AMBPR06MB10365.eurprd06.prod.outlook.com
 ([fe80::addd:5e9b:7273:8049]) by AMBPR06MB10365.eurprd06.prod.outlook.com
 ([fe80::addd:5e9b:7273:8049%6]) with mapi id 15.20.9564.016; Mon, 2 Feb 2026
 11:19:18 +0000
Message-ID: <885ddf2c-73e8-43f2-8b93-5a0a8a92d19d@vaisala.com>
Date: Mon, 2 Feb 2026 13:18:23 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/4] iio: adc: ad9467: check for backend capabilities
To: David Lechner <dlechner@baylibre.com>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Nuno Sa <nuno.sa@analog.com>, Lars-Peter Clausen <lars@metafoo.de>,
 Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko <andy@kernel.org>,
 Olivier Moysan <olivier.moysan@foss.st.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260130-b4-ad9467-optional-backend-v5-0-7da803ba7326@vaisala.com>
 <20260130-b4-ad9467-optional-backend-v5-4-7da803ba7326@vaisala.com>
 <9c674c11-56fd-4b49-96d6-01d8cd433003@baylibre.com>
Content-Language: en-US
From: Tomas Melin <tomas.melin@vaisala.com>
In-Reply-To: <9c674c11-56fd-4b49-96d6-01d8cd433003@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GVYP280CA0012.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:fa::10) To AMBPR06MB10365.eurprd06.prod.outlook.com
 (2603:10a6:20b:6f0::7)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMBPR06MB10365:EE_|VI1PR06MB6447:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b79af66-4f72-41e9-e732-08de624ce823
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q2hjTGJwSE5YNUlZT0FKRnRsTDAzMlplbWwvYnI0M1RCQ3RyUHZReGNmdnBR?=
 =?utf-8?B?azlwYThTdnB6bHcvbndkN0JCZG5TMklQdFp5dTdmVVJOc2toTXl6RExsd2tD?=
 =?utf-8?B?UTlZSmZrbGorSDV5dm5YMk5oVUFwVGMwYkRydWxKR1RwSUt4ckI1Zzh4bkxm?=
 =?utf-8?B?N3BhSHBUejUwSEtLbWM0YTA2T1hjaEZPbFdjWW13WVhmTlllSi9iQkF1UmVW?=
 =?utf-8?B?RzJLcHlUdWlERmlmTENTNnNFZ0VqTzhWdVBLb1BjblNnaTQ0T2xZKys0RC9i?=
 =?utf-8?B?d0xCK2Jha0tQeHJnbncycG1MZ1htU1d6YnBhU012OE54YUNpOHd5bEJxbDFU?=
 =?utf-8?B?eFpXaXhqbXdMOFF0cDNvWjJYcDgyM3M2RXYvUjlSSmdkRHlRUlNVTWo2OUdM?=
 =?utf-8?B?M3FHYnZYcWh5Z0VvZ0ZURFB0L2ozWUR3elBTb3lHcjB6dkp3bmFHeVpIR3VH?=
 =?utf-8?B?SnpJWm9xSDZLVzNsSlFoTEV0RlZObEJiNloyR3ZLRVNjMWpmL2dodUp0cVVM?=
 =?utf-8?B?NVhTd1loOUlBUmJIUjhSdUo4WUNjZ2JvME1Hb3FQWXBLRUdURjdLL29BOU9D?=
 =?utf-8?B?U2JWcTh1Vmp4T2I5YTk0Vm56UjZ4TFFEWldOZWFVZ003YU41Mk5JbzNnZXBt?=
 =?utf-8?B?KzB4dEs0K3NVMnFpS1NqUVNCKzFyUDM3MWdhUDFLTGlGWHhvYVdBSGR2QVdC?=
 =?utf-8?B?NFR6SXVBcXJBMUZpWitOSFRzYWFIMUZDUDdTZ3B3b2h4SGpmaURqM2ZwejZ6?=
 =?utf-8?B?NXdyRGRoajFpL0IrS3JSdERqSjRFVjgwZmJ4V0JKUXlvRXRralRTcGZpMndC?=
 =?utf-8?B?NmJreGF2V0szYnBINW9UZXdlMW1LbU1wcVJoU04zVExNcWFsRlJBV0Z3MDM5?=
 =?utf-8?B?dTZzZ3k4S1lGWEVLMHhVbjVTWEFxSkgvVUFzWUl0ZGp6QUFXT2VRR094Y0Fr?=
 =?utf-8?B?TEVLc1M1RnBsU2VUalN2NitZNUQvWXJPSEI4UlErMmYzTTRWU1NYd3ZHUVZZ?=
 =?utf-8?B?RXgzVUZxTmdXL1E5TUJXczltaWRtWmJlQ2Q4dmhwcU03QWlHQUZqd3lzSnBz?=
 =?utf-8?B?YUlmcVp5SFU4RGd1RnJDOGN5M1ZnOTdDdEFBeHN0TENCVE9RZ1BOT2QxQkQ5?=
 =?utf-8?B?bHNEU29ia1pYeFEwbkRwT09VUUY3Wk5wK3lQWnRmMVJ5YXhaU0hqN1Q1NFU2?=
 =?utf-8?B?T0I1TC9vdGt6SVR4aVcvUW9KVUIwcDJPVTVmNmttQW8xRVpkTlkrdDJ2WTRG?=
 =?utf-8?B?WDFBbmxSTG96YVZPOTRiWG05VEYreDhadytBQXFvbFQxbzNSZktZUnJzWTQw?=
 =?utf-8?B?eUdITEw3dG4yalREZHNVU2NtWExVSThXYTByVHArT0M1UHlzaFUvbGRBRUpR?=
 =?utf-8?B?U2hnMTk3TEJPeEJac2JaYmVtaFZQNzZTWEFNRmVFaU8wZkZ5UzNTRU5hY2Zn?=
 =?utf-8?B?c3J0WUNucTJRa284S3A0RE5aYnNuSUpDN08yZmVZdzd5OER0Z3UzQ08yWTdM?=
 =?utf-8?B?bW1KbGtCbUVXZzRmZHFibzNNRW9Rbmx1STZHeXBETWNGSVlvd2lXelJWSURx?=
 =?utf-8?B?K2tONkp2SFIxZEI2NGVJTmhLaW9oT2FNc2pISHF3NHV1N1JySU4xdlpTYkZs?=
 =?utf-8?B?MnAwdVlnMkZqc3p2MlZtcU03UEtWVEw4cmZ4U0hJczZTMitNanY2Yk5DQnp5?=
 =?utf-8?B?akgwVy81dThwakRkUmFvcnl4TmZmRnF5eThHZHcvcnVjbzYyc3dZTVp6cW14?=
 =?utf-8?B?N2NEQmc2dXpwVU85b1RVUjhJMHRqQ3pJN2Y4Z2JxbnM3T0FFUXB0SCtoWUxJ?=
 =?utf-8?B?L2ZIcUJ5SkR0NC9acWF4dS9QTUd5QXYxR1lQZmtqR1ZVVVNGSStZb3FxMWJm?=
 =?utf-8?B?SmNBb25icDBoK0hFa3NoOUYvem1GdDljYTAxOVhsc0RDWE55RGg3ZlZpYXZC?=
 =?utf-8?B?Y21RSHVQZ0lmbHh5SFltYzdQVmRwNmhxY2p2Smk3WlZXOVQ5TU4rVHpkdXE3?=
 =?utf-8?B?cmJESlZaMGFibFViZzhsbGEyZVpuVE0zQjJkREl0L3BvVGkvbnBiVGN5L1lP?=
 =?utf-8?Q?6WqxF1?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMBPR06MB10365.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MVNWV2tjMklzUEZ6cUFJSUNMZTdnVVJzQjJSQlFLaThOMENxTTBmaVpvNXBB?=
 =?utf-8?B?K3N6bGQrQUk5UmtBNjc2ZjdOK0xNNDZiOC9OQmpuR0ZtcklJWk5INW04WTA1?=
 =?utf-8?B?MnFFeVZPbHYyTy8wSS9kWDNtR1B0bDJrNlRiazd2d25NK0JoU3lMaUE4THM3?=
 =?utf-8?B?RG9idGVuN0Rvbk0zZVp0bVpKQzlMczMzQlkrSTZoVjdlWm1MaWxRdWkxVDNE?=
 =?utf-8?B?WEpnTmROTXFQSjJ3SXgwTG9RejRYNzlGK2VaZ0NMN2RXWEg2Wml5YWJudWg5?=
 =?utf-8?B?dHJtS2luS2NqTUhETHVFTXE1NndDQkJqbk5aTm9oN2U1cGpCaFQ1ais1T091?=
 =?utf-8?B?L3YzZ1c4Rjg2QkxKRDE3eFBNUmxBdVJuQzhIcThNY1R3bjFRMXBxV2Y3NWF1?=
 =?utf-8?B?Y3BSYm5YTkxNdU5HQ3cydWFNYllYZ09zZndoZXl4TnQ4MzkvUHQ4OGlXaW5s?=
 =?utf-8?B?eEgzWDVyVWZWWTd5WWdSMzZMMEN4bkxDVit6MjJyOVljMmd4eDMrMVUrb1dB?=
 =?utf-8?B?WHhMOHBDRC9oa2NpKzZ2dE40NURiK2JORHVUcVNJKzJ2OTVldEtudS9Dc2Fs?=
 =?utf-8?B?N0NzVzFvbGtEeTlsc3J4OHk4YkZ5RHhFcThFNlhwN3RMc3hoNEZudW85Qkpp?=
 =?utf-8?B?ZUI2Tk9peGkvMnk0OTlxdk9jcnY3QjZnaWw5NnRwWGJlOUZNbmdZNnFvdW9G?=
 =?utf-8?B?akFEUmtScWdMVno0cDNGM0d3VjVwYldDKzhrOU8xSlNZb3MvS0x3OENwTzRP?=
 =?utf-8?B?S21NbXZib05Ed3ZVRWRpWWhiOWFnVWhCVnMvSGJROGJOR2lBckgvZkxPcmJI?=
 =?utf-8?B?Mms2akp5QlAvYTI0Q21VMnF1Y0h3a1I2cXA2c0FOUUVhMlJMWjl6dXA3M1Z3?=
 =?utf-8?B?RHZBaVJQVWZuanozZ3ZBbXRJU3o0VEpicGpWSlh3dER2RldUL1BXQWh5Q2ZJ?=
 =?utf-8?B?QVFXSU5OM2FTQjVWWERKdVhiazhvWnkyM0Z1TXpzcTF6ek5qOGFjTTYwSFpC?=
 =?utf-8?B?Z0hWY2FvbnFNdGxhUjR2RUtsTGo2YTdMcU9ZNTZ5NFY1Z2EyYTR5YU1qL2h3?=
 =?utf-8?B?MFBHTjJDdXlxbllOeklmeWVTUWJDOXJRVnhjdE5ZRzdzVkJoMXYxMThUM002?=
 =?utf-8?B?bC8wMlM4N3Z4RGVLbDRDbU1YY3cwQkN0MFdMZXdaRjlTMUpzUzNJZXNRVnlU?=
 =?utf-8?B?VitIaktqTHJYRy9aRW5xZnZ2YmNYeTcyUU9Bd1pIM28yQWF2Zm9JT2ZOTnFl?=
 =?utf-8?B?VnFnYXlyR29VbzgxQTcveDJLN2huc0VvMTBxVTdUdG16STQ5amNjSm5ZYmlm?=
 =?utf-8?B?RTE5TUovRTE5NE05VE04SXdwZVBtSS9DdDB3UXhyZU5xdjQ2Q3FHbUNvSXZY?=
 =?utf-8?B?aTJkMHpxeExhSzZ0cjN6QjhMVGVWeVRlQ1B3aU1pcllDMGsxOWNoOHJYZ2U4?=
 =?utf-8?B?Y0tVSmNCS2dKUXlxM1VGMW1xWWFDWXhNdmtwWEZINm1qdE1LR2c2eVZka1BZ?=
 =?utf-8?B?MmdnSnN4MW5lV0Fld2prOGhxRmhJZWpIWE5ZSWhTTnozaFFscndJY1dWVVBW?=
 =?utf-8?B?VlVWK2NhWlVhL0d2ZWZUSjU4NmZIbXFMMGc5MWJVL2ZGNDVVM2dLYmxIQm4y?=
 =?utf-8?B?OGZwcksvbFhOWTlTbGd1bjNacVVFK1hhMElueHFBeGdaUHFvT240MGFoVEZY?=
 =?utf-8?B?V2M2NGJDRTJiN052ZWJuRVJGRXRpSndMeUxtbFBLa0kreTdUM1V2UTliNDBy?=
 =?utf-8?B?Sk9sTVA4ckRKV1NoQ0Q2cU1MZVoyYmtoMVBQdE5jYkYrK3czbzdzeDJjMi8z?=
 =?utf-8?B?bnNSMmFMNjFTK2xCV0hiaHJxa3I1UEp1YWFhdjFiWFFyazFVcTFZcEJLRGRX?=
 =?utf-8?B?dzB4LzFNUENqZG1TUjI2MlhCREw2Tm1NTFNhaTd5KzhPYThCQjZFZVdyTTRB?=
 =?utf-8?B?MGZYQzJHcTFIY0Z2YlRwRmJxZEtxNUMyTWZhblhKelFpNy8yQ2hRbHRsQ2Yz?=
 =?utf-8?B?VnQzZmRwSFFFL3hkYkdkRlJFN1BUZW5Hamg1WFlMbHZGQXNYUlloOHBGNzJJ?=
 =?utf-8?B?MFlNa0JXeHc0TUhYVXB3WkpqTU10WUZQNTFSVWdVK25GV2swS3BEUm9NV1d6?=
 =?utf-8?B?N3Z6aWNUOEVpNS94enRwRStZN1VGdW5JU2Q3OVdTOGxyNEZpZHZIVldCWlNE?=
 =?utf-8?B?WnVzcFRSTFdwN081WDFhb0VnZUxrQXpsRnRRdTBxQXJVcGhhOEw5Ti83VUNs?=
 =?utf-8?B?YWh0SEk3MFZyZUduOXpmZzlWWFU0clYwb3ZDYWFYZkVjaGUxc0pXOUxIN294?=
 =?utf-8?B?WndPazExT2dFbjBLS0NGanowMmpBaGZ4Q3NLNXFJcUpoMHYyb295QlZETmVQ?=
 =?utf-8?Q?V1t4/G3jjXe6FGEs=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b79af66-4f72-41e9-e732-08de624ce823
X-MS-Exchange-CrossTenant-AuthSource: AMBPR06MB10365.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2026 11:19:18.6987
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 77aOaqh1ux44pGpBMG2X4iacus/zuF71HmwhUIa2I51O2KlSJcigOZWxIEeEckoBTsXJ6AMhVx+nHBmPEmZn1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR06MB6447

Hi,

On 31/01/2026 22:40, David Lechner wrote:
> On 1/30/26 3:17 AM, Tomas Melin wrote:
>> Add capability checks for operation with backends that do not necessarily
>> support full set of features, but are otherwise compatible with the device.
>> This ensures a fully functional device, but with limited capabilities.
>>
>> Signed-off-by: Tomas Melin <tomas.melin@vaisala.com>
>> ---
>>  drivers/iio/adc/ad9467.c | 69 ++++++++++++++++++++++++++++++------------------
>>  1 file changed, 43 insertions(+), 26 deletions(-)
>>
>> diff --git a/drivers/iio/adc/ad9467.c b/drivers/iio/adc/ad9467.c
>> index 59c3fa3bcc9b..d768f7bf2a1c 100644
>> --- a/drivers/iio/adc/ad9467.c
>> +++ b/drivers/iio/adc/ad9467.c
>> @@ -913,7 +913,9 @@ static int __ad9467_update_clock(struct ad9467_state *st, long r_clk)
>>  		return ret;
>>  
>>  	guard(mutex)(&st->lock);
> 
> I saw in the changelog that leaving the guard here was intentional, but I
> don't see why.

This was discussed here:
https://marc.info/?l=linux-iio&m=176900394618857&w=4

> 
>> -	return ad9467_calibrate(st);
>> +	if (iio_backend_has_caps(st->back, IIO_BACKEND_CAP_CALIBRATION))
>> +		return ad9467_calibrate(st);
>> +	return 0;
>>  }
>>  
> 
> ...
> 
>>  static int ad9467_write_raw(struct iio_dev *indio_dev,
>> @@ -1119,12 +1121,15 @@ static ssize_t ad9467_chan_test_mode_read(struct file *file,
>>  		len = scnprintf(buf, sizeof(buf), "Running \"%s\" Test:\n\t",
>>  				ad9467_test_modes[chan->mode]);
>>  
>> -		ret = iio_backend_debugfs_print_chan_status(st->back, chan->idx,
>> -							    buf + len,
>> -							    sizeof(buf) - len);
>> -		if (ret < 0)
>> -			return ret;
>> -		len += ret;
>> +		if (iio_backend_has_caps(st->back, IIO_BACKEND_CAP_CALIBRATION)) {
>> +			ret = iio_backend_debugfs_print_chan_status(st->back,
>> +								    chan->idx,
>> +								    buf + len,
>> +								    sizeof(buf) - len);
>> +			if (ret < 0)
>> +				return ret;
>> +			len += ret;
>> +		}
>>  	} else if (chan->mode == AN877_ADC_TESTMODE_OFF) {
>>  		len = scnprintf(buf, sizeof(buf), "No test Running...\n");
>>  	} else {
>> @@ -1188,16 +1193,19 @@ static ssize_t ad9467_chan_test_mode_write(struct file *file,
>>  			return ret;
>>  
>>  		/*  some patterns have a backend matching monitoring block */
>> -		if (mode == AN877_ADC_TESTMODE_PN9_SEQ) {
>> -			ret = ad9467_backend_testmode_on(st, chan->idx,
>> +		if (iio_backend_has_caps(st->back,
>> +					 IIO_BACKEND_CAP_CALIBRATION)) {
>> +			if (mode == AN877_ADC_TESTMODE_PN9_SEQ) {
>> +				ret = ad9467_backend_testmode_on(st, chan->idx,
>>  							 IIO_BACKEND_ADI_PRBS_9A);
>> -			if (ret)
>> -				return ret;
>> -		} else if (mode == AN877_ADC_TESTMODE_PN23_SEQ) {
>> -			ret = ad9467_backend_testmode_on(st, chan->idx,
>> +				if (ret)
>> +					return ret;
>> +			} else if (mode == AN877_ADC_TESTMODE_PN23_SEQ) {
>> +				ret = ad9467_backend_testmode_on(st, chan->idx,
>>  							 IIO_BACKEND_ADI_PRBS_23A);
>> -			if (ret)
>> -				return ret;
>> +				if (ret)
>> +					return ret;
>> +			}
>>  		}
>>  	}
>>  
>> @@ -1263,8 +1271,10 @@ static void ad9467_debugfs_init(struct iio_dev *indio_dev)
>>  	if (!st->chan_test)
>>  		return;
>>  
>> -	debugfs_create_file("calibration_table_dump", 0400, d, st,
>> -			    &ad9467_calib_table_fops);
>> +	if (iio_backend_has_caps(st->back, IIO_BACKEND_CAP_CALIBRATION)) {
>> +		debugfs_create_file("calibration_table_dump", 0400, d, st,
>> +				    &ad9467_calib_table_fops);
>> +	}
>>  
>>  	for (chan = 0; chan < st->info->num_channels; chan++) {
>>  		snprintf(attr_name, sizeof(attr_name), "in_voltage%u_test_mode",
> 
> 
> Do we actually need to change these test mode/debugfs functions since
> debugfs_create_file() is only callded if IIO_BACKEND_CAP_CALIBRATION
> already?

The set of available test modes as such are part of the device, not the
backend. Based on that I have concluded that they should remain intact.

Thanks,
Tomas


> 
> 

