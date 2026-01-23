Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11021084.outbound.protection.outlook.com [52.101.70.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CFDC2FD69F;
	Fri, 23 Jan 2026 05:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769146848; cv=fail; b=mVg/QGF9hWtOJW5+PxTfSR68InccxKsCp0NxaY9e+LZxMyXilnJGf7TvedtluwjOknc42NEQZyyGbcYYdf7R0kojeKmMMFaavNFv5bTxZ+XKSeOHd3/QCPgPRAGMh59t/+kIkp9W1x0pnrxbj6SDFdOYFmiW7sByPi/tXf/oU4o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769146848; c=relaxed/simple;
	bh=RKwbfYT7VT68Rjh3jgjI4nTV5K6y6PhajaNqmsT+lg8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PgnP4LRdkrOjLvsvqFlfoZ/QROMNgoybMQRZUuFOWWiY+hEwXSOcc3unwSV10m7nXi4+cEHH+2QMTxd6+R9XGCmKaLxaH8JHiwbJ8Rd7V62AcUm88DDz/etjMI0e51lYlVieLP8OPKgZ5zy0kYRGgTZ8zQuyML47z5BSvVAuGec=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com; spf=pass smtp.mailfrom=vaisala.com; dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b=hx9M6p/y; arc=fail smtp.client-ip=52.101.70.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="hx9M6p/y"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gRPxd2aZg4zyeSQDenisS8CPRijFxlufjxuFZ1pERsxadwfGIYvx3i15w6yRncIHoBjbOMF9R21GbkB01mCo3WVk9KwtPWoa721Y+HsgVE+ayb/qTdFKjiRVXRG81MhnOEGxqKcwPW72g8lF0V9aQs0oKMHTdebVyzmSnh0IFCOTv2uV4lgBf8lejZrBcNz8KehWVP89+iBwckSC3vkNGlmSe2T8OJTWoza2R4bFxLzE9MEWo50FsWQo+aiPJ3E3AMKgoZ4ddBVy4W64nDt7n7PHWZq2v6gfxXnu6sufKdmYat2sz9W0x0Tuwm3xILxuM1Fei3135A1pLbVVGeHGPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qcxllPVmxPp8H2sCNVIvFvSFFgRQaCGN7+tIKZfWTNI=;
 b=SKy4UuM+qF07K9mWk42KWv0DtrZOZ8TRAzPrObL3lo4EmueGM1brZBTDXGK5ILaICB3vXeoDlp8v7dCraj5xtmHGcHoMWwfrAeZDKbavaBE0Rcj5Ssz0ZU50OPx53nuByux5wCAmr2mYsArKdk5nmriRxi7KDtCxzNN5W4TNPoqzN2zTG1Nq27WR3bWcvT0AtRLWRln3Izm0l3VLwODMTaJnyOBTIqg1meMEJEKDgLQzdN2LeVPzGTyvpTmdfSnNV4u1SoPJ1bn/qmajruyxr8YnuHL1AGzY6Z/1GSedHHOe8xeahYzYC+B4mkVz/LSLvx3Yd4c3pp8SmC+koHwARQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qcxllPVmxPp8H2sCNVIvFvSFFgRQaCGN7+tIKZfWTNI=;
 b=hx9M6p/y057yeTjefLdTaLIxOBuyjqY4yEGgqWgwYBoIgYTboDjGdfq7614SJglSxAvVb2eHPMQ3xuNQ92i+gGlcct6U2KhLNw5VBScMSRLjreflhq9zyUxf3v/jmU2T1wwz4AY1/9NkcloWjfFG5S/HPLDinjXlVO4ixzOfc7AvsZ37ArWSChHhJZOKdNadrA4YizdabOD7SxnD0QmC6Sc+xhxubViEJjTeU0WeklW0XQw9qDyejtNOJJ52wiJG5HpLcAhhY4tgFA/UVTog/BBsNpgYAy6tw5HLh0u+HTQ1pZZaRcHgVGinuE3ay211CQK45oMiC9FaAB5hm8Ut0A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from AMBPR06MB10365.eurprd06.prod.outlook.com (2603:10a6:20b:6f0::7)
 by GV1PR06MB9194.eurprd06.prod.outlook.com (2603:10a6:150:1a2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Fri, 23 Jan
 2026 05:40:29 +0000
Received: from AMBPR06MB10365.eurprd06.prod.outlook.com
 ([fe80::4606:8e25:96e6:bede]) by AMBPR06MB10365.eurprd06.prod.outlook.com
 ([fe80::4606:8e25:96e6:bede%5]) with mapi id 15.20.9542.010; Fri, 23 Jan 2026
 05:40:28 +0000
Message-ID: <86840afc-b21d-4637-815b-65615610363c@vaisala.com>
Date: Fri, 23 Jan 2026 07:38:55 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/4] iio: industrialio-backend: support backend
 capabilities
To: Jonathan Cameron <jic23@kernel.org>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>,
 Nuno Sa <nuno.sa@analog.com>, Lars-Peter Clausen <lars@metafoo.de>,
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>,
 Olivier Moysan <olivier.moysan@foss.st.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260121-b4-ad9467-optional-backend-v4-0-18d2c0d450cc@vaisala.com>
 <20260121-b4-ad9467-optional-backend-v4-1-18d2c0d450cc@vaisala.com>
 <20260122204310.55446399@jic23-huawei>
Content-Language: en-US
From: Tomas Melin <tomas.melin@vaisala.com>
In-Reply-To: <20260122204310.55446399@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV3P280CA0020.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:b::32) To AMBPR06MB10365.eurprd06.prod.outlook.com
 (2603:10a6:20b:6f0::7)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMBPR06MB10365:EE_|GV1PR06MB9194:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f27e319-a16e-4152-472e-08de5a41ea90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cU1mbzNvRWpBbHZsOUdTcVR5SVhUbVVFNzNjdlBhRzVvRkNYdStVVDN2b2g3?=
 =?utf-8?B?OElrc1hKaVBMQzd6akx4QXFWVUZQWkdpUHNRTjZPRVIzNkZlaElmWnhGQnRC?=
 =?utf-8?B?U3YyZDl6YzRWN3l1akh0dzJVNjBteDRJZHdLM3lYemVwakQ0UTN0T052OERa?=
 =?utf-8?B?VU9IbHdRTnF1ZGphZGRHYmIrVDZSTGhHUE1CSDk4ak9BYUZveUszVjZJb3N3?=
 =?utf-8?B?aE1sYmNvUDBLNnY1dUpDNmswZUNSeCtaQmRGRTFQZTRka01sSmdVVkdrSWZC?=
 =?utf-8?B?SlJ1RmtCOHJnTzBMdEQ3VThlNHp3aGlUUjFNdzlWMnUvNFFOVktSdVVKZlU5?=
 =?utf-8?B?Tm5FSkhUdFlLR25yTGJocWhxdGV1Qmx2NjRHRUdTLzZsSzlMV0MrWmdzNmVx?=
 =?utf-8?B?RHFYV3NyVjh5Y0F2eXVxdVZOZVNhZDdDSEMzeHZkVVZJVmJkS1dLZzJGYlQr?=
 =?utf-8?B?K2JXc2VTSzlsTzlXZDVRZzV6STNUV0owaUxxaUp0dXhhL3I3aC9PaVBXRkxV?=
 =?utf-8?B?bEJLNXgyalo0bk4wNSthMGRkeEY4QUlENW9BNFpOUlQ5WFFTSkNqb3hVSTZY?=
 =?utf-8?B?akdiNUxrTHd2UlB2czd5OXl2R3o2MXYxOWNEY1IwOHlTbUZOOWNPR3ZDbU5N?=
 =?utf-8?B?TkFCdnVJSGVCY2FBSUZXRGhvWkIyQ2NsZ0VVNUVMc05Md3gvQmpOSWhEaWt6?=
 =?utf-8?B?ZlR4RzNQSWl2c3lFSThUdjdtM2xlOExobFl0a01mZ0IwdGsxOU9rc2VNOWtn?=
 =?utf-8?B?dnRrSjJCYk52L3dZU243NFJodTloTUdSTjVzNHpYK2hocG55NlBZa2llQ3gr?=
 =?utf-8?B?aXY2aGxqZk0zVUFnTGR6bDBNb05GNDROV1Y5WldUWWtUTFcxbEpQZDRTNmhH?=
 =?utf-8?B?WHYxbmx1Vy9OckwrbDR2UXlYTW4xR2lkb2tFdG45WWY5VEdqQlQ2TFdieC9S?=
 =?utf-8?B?eHF0dzY2NmdScU9WK0FHdHZseHdlcnAxQVlpMFhOU1BnUkZYZCtHRG1NOEQz?=
 =?utf-8?B?N2sxZDhsRURkVFBJU0JkbGQ1NE9HOWwwOUp1MUgwQ3g3V0RIMXNDTjEwUmJQ?=
 =?utf-8?B?am9QWW1hTFRNRHQ4aGFrREQvZk0xRFcxWTlsd1JEZ05WcTdZSC9JZ0hxY1hK?=
 =?utf-8?B?MmxEY1FGcE1FQVRsYzFISm45TEVIWUk0K29VNjBYYUFlU0dnd0hCRUFXNGtB?=
 =?utf-8?B?MlJFcUlWNmYzMnY1MGdpclVUNGtHR29DVjhxd0JNNkZYY2FDeENrbVZJaTlq?=
 =?utf-8?B?MlhoTjRsdFNudUd6d3hQditrYUlpUVIzeW4xbk9YOWs0QkFtblRhR2Q2Y0kx?=
 =?utf-8?B?WjFWMWQvYXBhU2FJWTFqbTBVNkVvV0hlclF5UUt3VGJvU2licVFZKyt1WWNR?=
 =?utf-8?B?NWx2VFYzbkpBL01NWitYVVB3ZkhlYkkzbTRpQXV2K2h3TUVHczYxL1V3dTQ1?=
 =?utf-8?B?TDZUMngxVVV4RWNnTm53eEt5dk0wczltNGxCRVF5dGUxWXIyeGJ1YnRGMm1T?=
 =?utf-8?B?K0VuTnBWZkhJT3hDQnlGNzVkd2ZTQ3ZGU01BNFg1dG1VYWZyWmxOVkUySSs5?=
 =?utf-8?B?eXIyOGlPMGlRNHVkSVhpMmhCK1h4SU1HS1QvazE5bW1qeE54YlRyYkxuYVJq?=
 =?utf-8?B?T0hNWGpiZnZWSjBQY0tOT3c1eWEzN1FUNmdvZUFUcjZZc0JvRjlySVVyeCs0?=
 =?utf-8?B?WmlpUE1zU29NUmdjVzVjL1hLM3h6MGdvdUt3M3dWb0NFVmRqaXh2Z3ZnYVhM?=
 =?utf-8?B?SnVhL0VRdlNwTWVjV0JpTThnRWo3Qm9FRkkvcElDOG9FdzhGRFlqWGwxV2lJ?=
 =?utf-8?B?ZFlCNkRRcFFoamZpbVhldlNmMlhqaHE5UFlKUmtObDUvRHcxSk9aa2t0Nno3?=
 =?utf-8?B?UDRESDFGNk5ETWZXRUY4cVhHVDMrcWhZemlmWmFlbnFwY2llR05IdmUrVnRF?=
 =?utf-8?B?NTZ6SmFQa1l6Y2JwZzhoNWlYWkZuVGgyMHVYMm8vc205bklUZmdxU25jckVk?=
 =?utf-8?B?OUpLK2hCVENrS0FFd1lVTUloTGlpakNSM2hWcGpCS0FtMThqb3dZTUpIdUxR?=
 =?utf-8?B?M3lhZ2VsV09wL04vQlVhMFFRdkRSemIza0NkaytGNlpWVmJSM3FFV2lyaWpr?=
 =?utf-8?Q?F5ac=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMBPR06MB10365.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ejV6RloyL0M4amgxT0FaRjdITFNtZEFVV0o1Qmc2WWs3eHAwd0RJbXc4SEY5?=
 =?utf-8?B?L2VjbzdQZHV5UFhBdEJaT2cycTVmYXJMd3lwV05QNFJkZlBNUVpqRmxVTDJU?=
 =?utf-8?B?dFczTW1QUXRFZTVVWVpDREpQZzAvOW5HbUJmTDN3WS9TTlNLYWNQWU1VMDNp?=
 =?utf-8?B?dEZoaEdJNzdUQmMrYkFGL2U5M29vMG82YjFkc2FlanFvZEZ2U0pRZ2daR3lR?=
 =?utf-8?B?ejF0Vy9MRWdtOGlDdXJVbDJHemVvTGNiaWdsNkhWT1hEK3lUd3BpRy9TYkNQ?=
 =?utf-8?B?clRUKzNNdEhLWmE5ejNFMlhreEZrTHo3b1U1cWc0L0JUS3V1SDdVUXBCMFJH?=
 =?utf-8?B?bWZxWGF1R2FBdmpnOTlwb0toZ2ZWYVlnUEJieXA0cEJkZnl0aTF1TndmLzhy?=
 =?utf-8?B?UlFRbjBKWFFzYUpLZzgwdHJLQVJTK0ozY05iMmROQUhNQmU0azczVTkzMVRQ?=
 =?utf-8?B?UDBUZ1RseVJtaWRINEcwKzBIMkdWMWNSdGpZYWRJRjBWLzF1QkN6V2FJZkc0?=
 =?utf-8?B?a0Q1RkRVWTF0KzRZRzJSdGxTTHl5T3FQZURmWDNra0Vha0wzN1dEUTI3L1NT?=
 =?utf-8?B?Y2RtbDdqbGFrb0UzdDFTSnpzcTBEdmltTU5PeHdxMEJiMU41SzBTbHpMNzhh?=
 =?utf-8?B?cjhLMmpqbEhabGcwb0FSemtZWUJHVnhzVURsRFhOQ1hjcUl2RDdMbnFpUGMx?=
 =?utf-8?B?UXN0cEdmbHhyQ3RhMVFibUZoeTRFU29yZ2xiaXhMakQwV2Q4QkYzaGpjUmtP?=
 =?utf-8?B?U1ZseEJYMjRwSXV5RDBKZkdCUTVmUGVINXhGN04zRFBNRXJJZ1FQcENtdm1Y?=
 =?utf-8?B?c090eHpMVHh3bktMN3U5bnl3bkdBRzJ6OUF1Uks5bHcyVGdYUVI5elpTVmhR?=
 =?utf-8?B?Uko1NUhsWlNhb3dubzVrWUE3VkZLSkZWU2R4ZTlUYTRlMktaajN5M3BVTGZa?=
 =?utf-8?B?TGRETFBBYkJ6MUlsYXE4eW1iVzZlUTloRFV6T2E0ZGpFVldqdllmZ2lWMWtN?=
 =?utf-8?B?V0ZpcEYwUU4xTGhqdDRBOUdzVG9YNW5HZTFuM3IvUkxQeFNZU3ZIY3pQcUpp?=
 =?utf-8?B?d1NsYXdZMS9jclEvTXN4U01JVm5wS3J3T3hrREt3eHdxdzhBUFIyandpb1lh?=
 =?utf-8?B?WlY4WW5uQmlJU0NZWVVER3dxaTdHcTVUQm9kNjJMTm5HV1JkTWQ4U2RRaHdP?=
 =?utf-8?B?ODRoV2tlQ2Vvbjc3TjZnZ1lhN1JiS3QrM0ZhZHcxYXl2cHBwSTRaOWNSMXAz?=
 =?utf-8?B?QTBkQWZBSm5IcDBsVkRURURhUFdpMG03YVFXRnpTRHpkSjJlVU51Um92NWZh?=
 =?utf-8?B?ZTVSbVdVOGR1VWFlaEVwRlJmQXh1N2l4NkNUb0c1VFJ6YlNJd05US3AzWXhS?=
 =?utf-8?B?d241UXpIRkJLbFkvaWRkdmtpNEFRZnM1U01oNTBvMTMreHl6Slp0V1M4Z1Ns?=
 =?utf-8?B?WkNET1F2TGRsNW9ITmdYaE5sNHQwdXRBMVkrU2RCYWZTazVRWEkzOEg5MC8w?=
 =?utf-8?B?TERUSUJvTjBVWTZDaEhLNWt6MGtmK3dseXhaTzNubllUMEtGYjQ4SWpuYjZ4?=
 =?utf-8?B?blRzaWVHelVtcHZ6UWk1RVlDV1picFNycUFOaWl4TzM0R1A2L0lOektVbFlY?=
 =?utf-8?B?NWI4RlhkOTZxblVvSW5CWWpDUExKaXJvRDJUeWxBZDRJem1EK3gvV3VwZHRR?=
 =?utf-8?B?NXR4WEE0MkYrSy9rOFBtaHQwRHJXcWxqenN4YTV5RXN0ZG5xbEJhZ1VTTWlO?=
 =?utf-8?B?SnFDRk5BMHZCVnlIcHJCYkVPZTdqM2JRT1BpNUZPNFIrMzgyeFFRN2NYRlZw?=
 =?utf-8?B?Z0wzenAvZ3lWWE1xdUVUS3c4MUpKMW9BUVZpKzRlMWkwWlQ4Wk1lNlBOT1k1?=
 =?utf-8?B?Zmhadk90VUkxZDRHTWpJbHk2bGhRTzA5RklxczRmamloQlZ2Q1RDQlBXc0Zz?=
 =?utf-8?B?Q01FenorRFl0NTM5cy9EVTNmV0x0T2dvbHoyUzJZOTcwUG03RXhhdlpwbUxl?=
 =?utf-8?B?UE5CZnV2U1pnaGo2VE4yQm1scG5kWUtRM0I1WmcxSXFJT3lrZytGYlRISytB?=
 =?utf-8?B?aDhJdHE1SE5EQk81SDZCSnBUN2VjT2RYOGN4dlYxbEprQ1hxT055MFpkYXpq?=
 =?utf-8?B?UEFSTGoyajcxS25sNnQzL0UxQmNHRzFyRXVzVWRwN1Q4ZCt6V2NOSlVNY0Zv?=
 =?utf-8?B?ZmZBM2RvUFVkSFgvMFkvN25xd2w0K0NyUEpLVTlJV29kaURQOUtWS1NOcGlW?=
 =?utf-8?B?aUpncUNDM3ZWMXAxYnMzbDNCWTJnQng3UmVBbVVBZVh5ODVIT0pjbEpIS212?=
 =?utf-8?B?Y3lnM0xHWDhMVHRGZmtCa0dQYjRpSG5WN1dldytpaWZBNm5tbEovMmVtRjhZ?=
 =?utf-8?Q?/KN6gYlCGsjirQkY=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f27e319-a16e-4152-472e-08de5a41ea90
X-MS-Exchange-CrossTenant-AuthSource: AMBPR06MB10365.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2026 05:40:28.9091
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WRIqi2LImjpb61PIL3RpluZZQpsIHmBprp5y6c/784h/OHN8MPzWSGzaphmL5Db9MSRITcK5Kepqs/83eTuKAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR06MB9194

Hi,

On 22/01/2026 22:43, Jonathan Cameron wrote:
> On Wed, 21 Jan 2026 12:08:30 +0000
> Tomas Melin <tomas.melin@vaisala.com> wrote:
> 
>> Not all backends support the full set of capabilities provided by the
>> industrialio-backend framework. Capability bits can be used in frontends
>> and backends for checking for a certain feature set, or if using
>> related functions can be expected to fail.
>>
>> Capability bits should be set by a compatible backend and provided when
>> registering the backend.
>>
>> Signed-off-by: Tomas Melin <tomas.melin@vaisala.com>
> 
> One question on the 'sense' of the cap that controls whether it's
> always on. It's the sort of question that I'm not sure has a perfect answer.
Agreed, it is not as clear as the other bits. I'll give my reasoning below.

> 
> 
>> diff --git a/include/linux/iio/backend.h b/include/linux/iio/backend.h
>> index 7f815f3fed6ae34c65ffc579d5101020fc9bd336..ac80abb71bbca88c3f6313d8d67b9c7ace076ceb 100644
>> --- a/include/linux/iio/backend.h
>> +++ b/include/linux/iio/backend.h
>> @@ -84,6 +84,28 @@ enum iio_backend_filter_type {
>>  	IIO_BACKEND_FILTER_TYPE_MAX
>>  };
>>  
>> +/**
>> + * enum iio_backend_capabilities - Backend capabilities
>> + * Backend capabilities can be used by frontends to check if a given
>> + * functionality is supported by the backend. This is useful for frontend
>> + * devices which are expected to work with alternative backend
>> + * implementations. Capabilities are loosely coupled with operations,
>> + * meaning that a capability requires certain operations to be implemented
>> + * by the backend. A capability might be mapped to a single operation or
>> + * multiple operations.
>> + *
>> + * @IIO_BACKEND_CAP_CALIBRATION: Backend supports digital interface
>> + * calibration. Calibration procedure is device specific.
>> + * @IIO_BACKEND_CAP_BUFFERING: Backend supports buffering.
>> + * @IIO_BACKEND_CAP_ALWAYS_ON: Backend does not need to be explicitly
>> + * enabled/disabled. It is always on.
> I'd like opinions on this one. To me it sound backwards though I can
> see why you'd go this way.
> Either the backend is capable of being enabled / disabled
> in which case we have to further assume at boot it is disabled
> (which is the dodgy bit!)
> 
> Or the backend is always on. To me that's not a capability,
> it's a limitation.
I pondered about this too, but ended up having the bit this way around.
The logic being that backend is capable of working even if not
explicitly enabled/disabled. So looking at it from that perspective it
would be a capability. And assumption being that typically the
enabling/disabling is required, checking if the capability to omit
enabling seemed logical to me.

Thanks,
Tomas

> 
> My slight preference is for a capability meaning we 'can'
> do something so the 1st option.
> 
>> + */
>> +enum iio_backend_capabilities {
>> +	IIO_BACKEND_CAP_CALIBRATION = BIT(0),
>> +	IIO_BACKEND_CAP_BUFFERING = BIT(1),
>> +	IIO_BACKEND_CAP_ALWAYS_ON = BIT(2),
>> +};
>> +
>>  /**
>>   * struct iio_backend_ops - operations structure for an iio_backend
>>   * @enable: Enable backend.
>> @@ -179,10 +201,12 @@ struct iio_backend_ops {
>>   * struct iio_backend_info - info structure for an iio_backend
>>   * @name: Backend name.
>>   * @ops: Backend operations.
>> + * @caps: Backend capabilities. @see iio_backend_capabilities
>>   */
>>  struct iio_backend_info {
>>  	const char *name;
>>  	const struct iio_backend_ops *ops;
>> +	u32 caps;
>>  };
>>  
>>  int iio_backend_chan_enable(struct iio_backend *back, unsigned int chan);
>> @@ -235,6 +259,7 @@ int iio_backend_read_raw(struct iio_backend *back,
>>  			 long mask);
>>  int iio_backend_extend_chan_spec(struct iio_backend *back,
>>  				 struct iio_chan_spec *chan);
>> +bool iio_backend_has_caps(struct iio_backend *back, u32 caps);
>>  void *iio_backend_get_priv(const struct iio_backend *conv);
>>  struct iio_backend *devm_iio_backend_get(struct device *dev, const char *name);
>>  struct iio_backend *devm_iio_backend_fwnode_get(struct device *dev,
>>
> 

