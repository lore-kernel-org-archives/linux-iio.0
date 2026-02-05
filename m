Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11020122.outbound.protection.outlook.com [52.101.84.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6093E3D34A8;
	Thu,  5 Feb 2026 12:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.122
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770294266; cv=fail; b=Pg6iIcoaSKU+BGUzP0s/0nRkBfod+Q9S60WdGRNcyq0xsCgvcp710fKyJG95QMC+Isiech74rbMRf5E7cOwI9cYZqMQH2d0ka0Ub7aUNXgyjZUvDLh7xEhsVIgtqDdgu1ONIpXK+PmliGlmLdP5OIw0HR04A0y5uktFJ0ewH9Ds=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770294266; c=relaxed/simple;
	bh=w0qhn0Kl9Vuh0Itcc/jtn3JaLNWxkN03BOzdiI4tPYg=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=tHmR4C9ZlZhCxJDg4mQ2sXKIs78ndyH11TkhqXHfHCYAQIs4F0pPFrDw097HC2/8L0Dg10xKde4l/czSuRmMq6c25XUtm9X4O0uCiUdwzb3Namrb5dc0XaLFG1CpECRhfyBN0Fuj4YKGOw7w6qOGwHjPhvJa/83eglH4y8dYfPw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com; spf=pass smtp.mailfrom=vaisala.com; dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b=bkCFhOjh; arc=fail smtp.client-ip=52.101.84.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="bkCFhOjh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FmYuWRpvuIfZvF/l3G+AO1/aeLzITv7tnSENHuZpa9EhgDl9vcdekzUj4Iznj0AB+XJy/orsN6M+SAhSoORwQ7gwHJYOaWFSOq3pxXGmKAodj3fcCm1DubKIZ+Ppmst+AerqGyvO38KrcWJPCUtt2wE4o7W2VHc6tzSTOmtr9nUgpKJLtP4b6ncgHGefzVcsuINoYuLfZ3NbA8VFYcYb53uIse9GwbvoOVfq+Ig9oL009nT6tAhtWwt+2iw2p4cWGu+equFReJ9Bi5bXUhTUee9V/GQhr/bRLqZTNv9RWBVe6GFnR+C5Sdk+RCJFRF2dXfCy04qKVk8GFxVVR0pRnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uXCrMhagYj8vyOrt2VbSh4nhm0s0bevrrkko+Afj8R8=;
 b=xz0Dx155YYhBXh1IDCqiW9LHFVQaXkssVwoZxZCFD/S5KHKWDGDziVGPz1gPAKkhqvOsYjQAgtjbvhlAiBZQ084bJhGjyM9qQUG/j9WXz/cs/IGadlIaJmPYn1/VKlS0dJlm9RSmCkhrb6O/wQ1PSXmxKoPByDwZVIJaqUcTNpUBhBww20wt1M1KNfUty6xmMiPXiuVgU5Zl8kiQyDQFwmZIWap6pyrQ0Sb/26S4YE1zI6i1uQpNwywlv7G4thEi2L+AYwAM8bcbW397IPgNOGaqvr8mAEGjnfmuVksf5axggiUo1c/otp/uW3Orhy+kQGsVA1ifE/jMOcSFcIWSOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uXCrMhagYj8vyOrt2VbSh4nhm0s0bevrrkko+Afj8R8=;
 b=bkCFhOjh8WWndk72HhSPJFF5yUBe/gBuMYwdEoywR6n3RNiovDGI+DD2jodofHLYlcAgK6NZhtsiOyinJ3PmEDdqtxuIxHh4gdgb9Qcp0yfk3yto9GhX4JM4dfLZ0oSs2gqYeo0sgpcxf46/saKZoxdK923gZp7r51Cm3BeXjxxmD04ABuPPcDiem5pi8FXAz0SnRXFWW8DDbe1jKaB50+BFbJvr+EJyUUPaHxqZBjA2VFD5sKCa8W+iYWEHQh6XWLoEOiT+MeAOKrAPwQ8X/wNbW+UUNCCnLLhyB07BsIVkAKZL/iY+1L+6BU5kd40xIaL9y1/XWhnkOK6n6p9mmA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from AMBPR06MB10365.eurprd06.prod.outlook.com (2603:10a6:20b:6f0::7)
 by VI0PR06MB9745.eurprd06.prod.outlook.com (2603:10a6:800:213::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.13; Thu, 5 Feb
 2026 12:24:14 +0000
Received: from AMBPR06MB10365.eurprd06.prod.outlook.com
 ([fe80::addd:5e9b:7273:8049]) by AMBPR06MB10365.eurprd06.prod.outlook.com
 ([fe80::addd:5e9b:7273:8049%6]) with mapi id 15.20.9587.010; Thu, 5 Feb 2026
 12:24:14 +0000
From: Tomas Melin <tomas.melin@vaisala.com>
Date: Thu, 05 Feb 2026 12:24:08 +0000
Subject: [PATCH v6 2/5] iio: adc: adi-axi-adc: define supported iio-backend
 capabilities
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260205-b4-ad9467-optional-backend-v6-2-7ca20c40c59a@vaisala.com>
References: <20260205-b4-ad9467-optional-backend-v6-0-7ca20c40c59a@vaisala.com>
In-Reply-To: <20260205-b4-ad9467-optional-backend-v6-0-7ca20c40c59a@vaisala.com>
To: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Nuno Sa <nuno.sa@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Olivier Moysan <olivier.moysan@foss.st.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Tomas Melin <tomas.melin@vaisala.com>
X-Mailer: b4 0.15-dev-c6abb
X-Developer-Signature: v=1; a=ed25519-sha256; t=1770294252; l=1511;
 i=tomas.melin@vaisala.com; s=20251125; h=from:subject:message-id;
 bh=w0qhn0Kl9Vuh0Itcc/jtn3JaLNWxkN03BOzdiI4tPYg=;
 b=39s3Q8ONkTXGUL9wEL0KjQpYmugu7WGDFK15LeN3IQ/9l7YqL+Ei7Oi8L71qYx2z0F2eRjHlF
 1bWzJVp513mCvuUXOrS+/I4cpZcXRtTiww1lhGpmU6JS0FEd7+OZmK9
X-Developer-Key: i=tomas.melin@vaisala.com; a=ed25519;
 pk=6lMiecjZ+OeyZuxYsDm/ADy9D1JKvYrKdsYv58PMepU=
X-ClientProxiedBy: GV3PEPF0001DBC0.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::6b2) To AMBPR06MB10365.eurprd06.prod.outlook.com
 (2603:10a6:20b:6f0::7)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMBPR06MB10365:EE_|VI0PR06MB9745:EE_
X-MS-Office365-Filtering-Correlation-Id: e299cc65-1f9d-41ce-d429-08de64b1796c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SnhCVlYvbUZSYUorVlZCNitpbjRaa2hLdzJaRW90dEduVE82TDAwUW45aUdm?=
 =?utf-8?B?RXh6U2ZyS2pNWUtMb2RBK2prNy9lTjg4Ri8yckJtdWFoVDBqaEV6dW9wYmMy?=
 =?utf-8?B?UWU1em1OZUtKRFZzMXhZS0IvVm1sYURiRE80RWIvSjV5MzNiSVRBL2Fya1Nw?=
 =?utf-8?B?blF6Umk2Z3RlMUNOaWxRcUZheXFVd2F4U0Q1L0tvUFNzTy9pc0daUXpSN2NS?=
 =?utf-8?B?WlFwR3IvcFBnSkJJajFDWHZaV1hKbU5YYTlDZFUzUk1VanhDQ0kxVmNKa1VX?=
 =?utf-8?B?cEwxOEg4YWZYcklaZStoQjRUZ1RVckMrVHd5M1JMOVFTWkRtK2lmNTA0Yks1?=
 =?utf-8?B?VTFkNEcxZmg1dEU0Q2pnSnpWR2x1VWNpNGFrRGtkWkU1U2c2U0RCWmNTdUUy?=
 =?utf-8?B?Y1JNQkpqTHFFZUtMaU1Ma2NwcUtEMXdWR3VpbDYyNkMzN09BazRzM09PNk9D?=
 =?utf-8?B?eHl6UE8rK0hDNmZSNHE5SW1LVFpBbGNTRVhYWVRvcTdscGdGbCtmRDFNb0VF?=
 =?utf-8?B?cnA3cFY5RjhzMUhkakxjdHlOeldnVmhUQUkzcVJCQTU1ZWJPekp3NlNsTjha?=
 =?utf-8?B?R3NOMFVwNFIwampkUW0yd0l3RTN5czZ6ZjgzT3E3NlVGQWNWbWFhQlhvTkxt?=
 =?utf-8?B?aWMwY0lsQmY2ZzNuNDhyclVObDFZNHB0RTFUNHltV3M3aTRQdHhyMDdQRjh5?=
 =?utf-8?B?Z3I3WSs2aGcxV0VKYVdheVQrczVCblFqaUZKcUp5UzVocWhITU1DSm04dTN0?=
 =?utf-8?B?SW91SThycThhZ0pJNHgvNEhxY0JkZTRRZ2VxQnFSbXNaZnlkSG5Ma1RrRFB0?=
 =?utf-8?B?US9qSm1LejhUU2RNYzcyNG1tZE9Hb1grUmZBYzlnV3RXSGNHV01ob21lUVR5?=
 =?utf-8?B?bWkwMG8yUE5QVGIyQlZLU2pQRGNIeVhzVWdLRE1TcFRFOTB2NW5Wc1lIdXBV?=
 =?utf-8?B?YzQxSW1pV3VWV0VIOUNBOE1SQXIvTFdZQTF4Q2ZZb2w1MmI3TUVTMEhnYzFN?=
 =?utf-8?B?OTErWFgvdDd4QnhCcHFYdnhQdldtUFpBYXdjNFR2NTVqeWxyZFE3Z25CTFAv?=
 =?utf-8?B?YnVIanVEekxHcm5WcEhzbjZlU09QQTJZU1NlMlJXSXVIdFpxS043U3JDM3Zv?=
 =?utf-8?B?K2tOc1NibzVKVlpkNU1vQ1U0d1pJaEdIcnIzTW5yV3RFQTJSVm5pYnBERU9a?=
 =?utf-8?B?Wi9MdU5pSkQyOTB3MGhJblRaK3Z4bDNzNkVKRjBraGZjaGtaVXJqRy9yVTh5?=
 =?utf-8?B?TGdSdjlxNElIWVN1MnRLeEQ1UTVyR05ySDBmZmFDbDhqNTlNemdCRUttZlhi?=
 =?utf-8?B?YWVKZ1NFK3A4L0ozSEoydy9wV2VhT0hIL0lrNkd6VndpeDJvZ0tsTU8rd3cx?=
 =?utf-8?B?R21xNHVWN0l4WHBnT0cwanZpcDFIODJOWklSRHlVRkhNNng2UXZGOEcwRlRk?=
 =?utf-8?B?T003UUlzOE1lekM5UHJpZVRLNVMvWnhQakdBTFUrWElsSUNTSXIwa0gyb3BQ?=
 =?utf-8?B?YTRhbE1hODFUblhlUWdOTHpGU2VaakNNVk84dTVqbDB1QjZEQm0vTmNURE9I?=
 =?utf-8?B?ZXdBYytqQUJzbFUyN0xMZld5UW0xWGEyUFdJWm0xdEV6MFh3VmJWOGsybUY4?=
 =?utf-8?B?T3lqRHFRU3ZnbDg3Q3F4SkxKeTlEU0U3aW5md01DR3drYnI2N3pJcVo5cDFZ?=
 =?utf-8?B?cnBGMlVnamR0SmtORWJBaGVraVpmd3B1YTZ2SlBwUlQzbmNwWVRUNndCV2N4?=
 =?utf-8?B?K3Y3Mkl2ajEva1ZSbTV4TDdLaHN2Vndlb24zNmlRL1hReERBV1g4ZzJZWVdj?=
 =?utf-8?B?Z0k1QTVtODVGTHRZL0k4ODlrbUpMOVdDTEE5OStTTVNCUHp0alVmSDhjL1Qx?=
 =?utf-8?B?UHU1U0xkcHdnZTl0U0Fqd1hCYkJzUjdPMFRkSmFxcHNVSytDOVAwRjE4L29V?=
 =?utf-8?B?UUVjKzBKK3k4ZEtzdzQ1enNISGI0bERuck5QSFcyYXJZZ2VINnFmRjlwV0dm?=
 =?utf-8?B?YlNjd1BXNG4vcDJ0YUVUbE43NVN0NWRSYjY0WmJkSFRiaTQ0MjZrcDhoSGJ4?=
 =?utf-8?B?YWJjN0RvcUNINE9SWno5RVc2WXoydE4xUWtYenN1aW9TVytOeVBqd3JLRWQx?=
 =?utf-8?Q?j0l4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMBPR06MB10365.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MFhKbWozejYrMTZRUVJvdFpxWThHbkp4blRRMWJLYmRoQi9DU2MzMnkwYWl4?=
 =?utf-8?B?UHF3ZEdvaEJtSzhCOUREN3JDNVBWWUM0c3BOSStCM0VzYnUwSVkwOUt3QnBV?=
 =?utf-8?B?S1I1SGVUbEdNWUNVOElTNTNQQytxRUg5U3RPdzRQb1V5Y0lBVVovNTg4SzVo?=
 =?utf-8?B?N0cwSU1FVjBpWkhsSWJHVHpDaXNWaWdnRXN2cnZBbFJzeXdERVkwZ1NmdnEr?=
 =?utf-8?B?dXhxZTNFMk9xRHVwamY3NURXaWVBQ2tSbTRTZjNpVWY4WUtNbHpxbzU1SUtL?=
 =?utf-8?B?SUJxeHV0MGF3MnhIYU5adVBVbytmN2ZKY0drZlNsNHNDSllhNzQvM3pZYWc4?=
 =?utf-8?B?QjdwSjlPVFlvTTdCdGRGRmRSY3plcnVnYVhXNHgrd1VBYkJLVmhlbUJXbGlL?=
 =?utf-8?B?NGZHcDV2OEh0ei9hNDZGdjdsSlJXS1AwRitaUzZvVkVyMjlkSHdxUGl3YS9v?=
 =?utf-8?B?VTZVT2lOTW51Z0IwNUpjYWl4ODV0dnB3cmpYUUFCdHJzaDNRaDd0eTB0V0Fx?=
 =?utf-8?B?YVVjWHF4MkxSNTFsRjdqK29IN0JTM2lPNXV2TW9vSWE4Q0w0dk1Cb1ZtZWIr?=
 =?utf-8?B?RE1mUGZYQWVrVmlwRER5dWxqVHJsczN2bFJUdGt1UTBzaVZJNFplcnVUYTdH?=
 =?utf-8?B?MmxON29wZlEvM0VEUDBkVzQvL3VvNU5aNXIwQWJXQ1p0ZEYyWWJTSDdTQks2?=
 =?utf-8?B?bUxmT09oVHgwQUJwc3JNSEVFYlpURGFiUktWSm1zTFpEZHNMM3p0SmliT2dC?=
 =?utf-8?B?L3Z3RVh6SytRcWFkcTdoWm5oY0NyZGg5WEhqOFA3amtnL3FvaXkzeVF6ZER4?=
 =?utf-8?B?TmlqSGFzSG9SV3F5WDljWW5IT2dLVzdhQmdoUmdIY3VVK2ZzQ3Q5dldiR0lK?=
 =?utf-8?B?RHZMVFFZNENHcE9KK29NMG5nK2E1VmNGa0hObXNHNVRLZVhnRDlJQnBieFM2?=
 =?utf-8?B?UDdEWU1oUVAyTEFJd2lYQkFITVZJUDIrd3VIaTVwQTZyd0oyMVBLTXdvZGJD?=
 =?utf-8?B?M3R5dGh0c3RBdVE5aGNhQkJleVBiZWlJcXBFMzN3NTZPZkoyeWlMNE1JcjI2?=
 =?utf-8?B?VSs3U1lBMmtDRDFaaXRtQXFqNjVBWFNwcWRSZEY3REVSVmlCRkkxQldmelFu?=
 =?utf-8?B?ZXIwRG1teUx0dlY2SHIyUWZnKytyRnFKSW1DY2NucFIzUmdDSmtOT08yN3pY?=
 =?utf-8?B?S0RNMWlISmQzT3FmK2NJRlltV1M4eFd2aWFua2tZazhrd0Z4emo4bWpmVkl6?=
 =?utf-8?B?dmlqeldUakRHa3Rid3lpVU5TWFZGRndudTh2dm12TXNCNUtKbmhCNkY1N0R4?=
 =?utf-8?B?WHVUVmwyOFFhdW9FUDdHZTF6aVh5cERNeUhKSzVwK3k3SkNPa2VTd2hPdUow?=
 =?utf-8?B?eXlSYURMUmVUcDUxUExPWXl0NWZzMGEwMTJ4RVM1WnJCelRucG5HajM4amZi?=
 =?utf-8?B?VHdMU3pZd05wU3k4cG5ZbExBbitHZWJlemtBb3dzd2NjK2NsT282QVgwSFZX?=
 =?utf-8?B?MDRSTXFxUlhLcFNSVDM4NWJ4dWhYUElnTmRnYVBXcHczejlMa3phT2lMUnFH?=
 =?utf-8?B?Z1QvUkdEc3BiZDVoQzFLd1YxNytGemRqUlRvamRTeG5PMjVYTkk1Y3JPRlVD?=
 =?utf-8?B?VU5PQmhGRTRMekRQOXpoL1FzNThWQm5ydnRmcWZGbkEvdWR5TVNWOUF2N0tQ?=
 =?utf-8?B?UGNvZElQWjlTYXVmSUpYY3lSYjVlc2ZhMEhIcjAzZUo4UENYK01IRXlVMkNP?=
 =?utf-8?B?SHVtNjlwZy83S280bEF4UjNKdU9hcEdQc01TVHhuM3F0ZU9Ua25Ya000OXUx?=
 =?utf-8?B?U0syVUltY0JPRVVYNEpSaDVqN2dWWEcwWXZVWHVNUUFQZUg2dVJnUHBKeHFJ?=
 =?utf-8?B?bGNYTWlQREVWY0diS0JPS0Z0dGhacUpQSmhXb2l2cU1UU1RMKzRWSVZnWFEw?=
 =?utf-8?B?U2NXWHR6c05FMHVzR2J3U1F5OUMyVVNaUjRhZXR1S0N4VzRKeVB0T1pnUDJ4?=
 =?utf-8?B?KzBrSmZuRDU4L2lPWlBjSnFZeFl3TFB1TWpRcEFMcGtYdTVXWlZSQlNvUHB4?=
 =?utf-8?B?b3V2cUVtV21uRVBNUkRIRWZkNjFFcFBqcU56SUF6WEgvVG80RVBibWJ5a09U?=
 =?utf-8?B?ME5ISVQ0MXl6MHA0Y3VsZHhnWWZJa3RvcVBBdzFmNVlIYVlOdko2YTlCUmY5?=
 =?utf-8?B?QXdYWEI5bU4vRGpkYnBZTlBWOXdJZmJkYU4zNWRPUHlNZ1BpbkdFWmlYVVd4?=
 =?utf-8?B?eWlqbzhNU0dxNmkxMWNlYjhpeUhSUk5WQm4wZE12ekJyVm5KSzFWTVpPdkVC?=
 =?utf-8?B?bEFTbXJnNmhFTDFqLy9KM3c2NGxPOVdIdEhnVW02UkVuMlBIcmw5bWFENzM5?=
 =?utf-8?Q?iKvMjUqwEXoPtp2A=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e299cc65-1f9d-41ce-d429-08de64b1796c
X-MS-Exchange-CrossTenant-AuthSource: AMBPR06MB10365.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 12:24:14.4141
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +JE+v+KrwZHOUFWXrQ/tmB8ff3ju0wSgyTUuUV702mRpvADFbe+/5KsqXsHFB0WbattSW2HeHyLqbcnHEkO7MA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR06MB9745

axi-adc and axi-ad485x backend variants provide calibration support,
whereas the axi-ad408x does not. Set accordingly.

Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Signed-off-by: Tomas Melin <tomas.melin@vaisala.com>
---
 drivers/iio/adc/adi-axi-adc.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/iio/adc/adi-axi-adc.c b/drivers/iio/adc/adi-axi-adc.c
index 14fa4238c2b9..a27745695b7f 100644
--- a/drivers/iio/adc/adi-axi-adc.c
+++ b/drivers/iio/adc/adi-axi-adc.c
@@ -626,6 +626,8 @@ static const struct iio_backend_ops adi_axi_adc_ops = {
 static const struct iio_backend_info adi_axi_adc_generic = {
 	.name = "axi-adc",
 	.ops = &adi_axi_adc_ops,
+	.caps = IIO_BACKEND_CAP_CALIBRATION | IIO_BACKEND_CAP_BUFFER |
+		IIO_BACKEND_CAP_ENABLE,
 };
 
 static const struct iio_backend_ops adi_ad485x_ops = {
@@ -650,6 +652,8 @@ static const struct iio_backend_ops adi_ad485x_ops = {
 static const struct iio_backend_info axi_ad485x = {
 	.name = "axi-ad485x",
 	.ops = &adi_ad485x_ops,
+	.caps = IIO_BACKEND_CAP_CALIBRATION | IIO_BACKEND_CAP_BUFFER |
+		IIO_BACKEND_CAP_ENABLE,
 };
 
 static const struct iio_backend_ops adi_ad408x_ops = {
@@ -670,6 +674,7 @@ static const struct iio_backend_ops adi_ad408x_ops = {
 static const struct iio_backend_info axi_ad408x = {
 	.name = "axi-ad408x",
 	.ops = &adi_ad408x_ops,
+	.caps = IIO_BACKEND_CAP_BUFFER | IIO_BACKEND_CAP_ENABLE,
 };
 
 static int adi_axi_adc_probe(struct platform_device *pdev)

-- 
2.47.3

