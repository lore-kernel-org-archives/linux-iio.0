Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11021108.outbound.protection.outlook.com [52.101.70.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B23C2DC350;
	Mon,  2 Feb 2026 11:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.108
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770030530; cv=fail; b=Ogh06tYFR18PCR8qNeAQbXiPb5B75Kx+DI8SzpuK7o9xsIYQC48TRTFfhaTxYeOug1IjVT7QMCjJDgOzQkG7FOYeW+8CYmYWpkUcpuWdayO4I05fTDIQSunD/fvbIVRKFJQzuqmVpOPFFUfYgwg2FXovcRHDbJk8iLUSN8Z5mZk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770030530; c=relaxed/simple;
	bh=TMvxxCHtAqqejO5Jkut5tzVnUwUR4UxlVLk8CtMKRg4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pQh8yqWQevm0ZlPYnWXVRnde7uqnQPz6MRMtQbFVsPMlC4MDbAHeUTzXdd1GzetJ1yCfsIVMTt/WeyWThxoJ9yspR2mf1xyB6bT66qhyJ72+HwHnu6cwthmKveISv+Y4pmoeGZ4ilJRgcNvwH5TtX3MnCEbcAcJ0FO/J71dYS8c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com; spf=pass smtp.mailfrom=vaisala.com; dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b=AcXOXDcA; arc=fail smtp.client-ip=52.101.70.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="AcXOXDcA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C2SnouhfIFpgWSFXuzytIyK5p4Y4vqC26xETTRLB+UT6tinSNzqCii5mvJPsxXO75fSghQ36OJry6P0ydmPp0womjxse14govg5t+SWoKgX0jU5CzwlcqAIlacgyO4hImKBRjz/dRWbi8YAOVhzwI+wKJtelZj7n6BnIECZBsa2ba20dqtZ69crNGaWocTuVJt8LF3kLAG+Jr6oYFBV5csvrgAY4MCpiyjTQm361Nr/XM+kH1owbXjyBWMS2DKymLJkXGtX2U9relto0HHIKYYpKWmwMhEs8lh5RKpkt9LkU+VzDW2GR9AtUtB8/AnvRC28o6KyIrryzKg5wPU5/Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HTQkwgsOBwblJfsJ1QDpjIvNo/6DenYDVZRWEVg4lHU=;
 b=Ih7Z0Mwx1Rv5X3t4y/rvREgmNhXcjpJ/OBS4HCGIzhkEqAdwQxQsPEsq5F+eW6dPdMW/kqPdx0D9ot3OaTUkyGwAGWu0Gfk6yRIm6l64JINUck1j02Fv2nJOq2/O76BlO5PjOfchD1jLeEm1Y0BRTPwOyQwkheMwIztuaUVFm1yqB+ZrBZl/6NtB/6IrMv09kzBWN4ERwjLzA5OId1tBKSb6W68d1/vtFYRKCBcus5CGW3CFKQFeLAhUy5quVvzbOHytFmobnjOdu2GowttSrxoA39+9IdHywwkwyzPgee88zwshx5EfcyyFY6at8pMn/8wEvCu4oKeONLHohOmvRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HTQkwgsOBwblJfsJ1QDpjIvNo/6DenYDVZRWEVg4lHU=;
 b=AcXOXDcAThq6CqoT36xggq+hjzMEQbNDiHK531NRh1ag8vkytBS4JDxOOkRB4CjSHxgjx6UoTn4F64FO7Tt/4fS1OUoDCiwBHRdqVG38/Wl1XVHxT/Q9cFWCrinFI28uJIjKOWlP5Cxj/OqL69ECG5P86XDbPK7H7PtND/e5QEmaV2mC5cyb9iRWuRwLSTwELIwJ1mAZPWxPcZMcaiZIncbG7TxS8iy45h1XRH+zGHk6pU5YB821ZF2YSSSMw8E3Zg6NYEt+/5KgL4gIc8AzrC6y8ZwRgkRjgCu6QgNtkK5mnIBInab7wlvYqWLn5EBMWXsf83DgZ8SGbHgpE2yZiw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from AMBPR06MB10365.eurprd06.prod.outlook.com (2603:10a6:20b:6f0::7)
 by DBAPR06MB6791.eurprd06.prod.outlook.com (2603:10a6:10:186::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.15; Mon, 2 Feb
 2026 11:08:44 +0000
Received: from AMBPR06MB10365.eurprd06.prod.outlook.com
 ([fe80::addd:5e9b:7273:8049]) by AMBPR06MB10365.eurprd06.prod.outlook.com
 ([fe80::addd:5e9b:7273:8049%6]) with mapi id 15.20.9564.016; Mon, 2 Feb 2026
 11:08:44 +0000
Message-ID: <30cf63eb-50ba-445d-a78b-d6532aacdc8e@vaisala.com>
Date: Mon, 2 Feb 2026 13:08:25 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/4] iio: industrialio-backend: support backend
 capabilities
To: =?UTF-8?Q?Nuno_S=C3=A1?= <noname.nuno@gmail.com>,
 David Lechner <dlechner@baylibre.com>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Nuno Sa <nuno.sa@analog.com>, Lars-Peter Clausen <lars@metafoo.de>,
 Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko <andy@kernel.org>,
 Olivier Moysan <olivier.moysan@foss.st.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260130-b4-ad9467-optional-backend-v5-0-7da803ba7326@vaisala.com>
 <20260130-b4-ad9467-optional-backend-v5-1-7da803ba7326@vaisala.com>
 <688cbfb1-0944-492a-929d-91ebb9ab22fb@baylibre.com>
 <812a8c408c2e3a87ebe1ddc983acdc2cebe3b36b.camel@gmail.com>
Content-Language: en-US
From: Tomas Melin <tomas.melin@vaisala.com>
In-Reply-To: <812a8c408c2e3a87ebe1ddc983acdc2cebe3b36b.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: GV2PEPF00003855.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:144:1:0:9:0:15) To AMBPR06MB10365.eurprd06.prod.outlook.com
 (2603:10a6:20b:6f0::7)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMBPR06MB10365:EE_|DBAPR06MB6791:EE_
X-MS-Office365-Filtering-Correlation-Id: dab240d2-f5a0-4451-b4ab-08de624b6ddc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b3VYenBEY0RzcGtZbS96Z2d6Tk44WHYrSXBNSGwxekJFODFieGZEdlBoQU5C?=
 =?utf-8?B?WmFHR1pLK3NGRkVtOXd3OCs3U29ndlRHR1p2amFjZWdtTHArblJwSkhVcGZy?=
 =?utf-8?B?T3gxdXdNb3VFUFRDb04rOTVmZENaZUZPRHlCaU9rZmNzeWoxaUhlMTltYXhx?=
 =?utf-8?B?NnI4QkczZ3pLd2RjMXlSdk5zU1lMcUVodmI2dEVmZEN6c3RwaFlFdUpYdTJE?=
 =?utf-8?B?bXVxbkZPSTBMVzk3eU1yZzJBUXlaZGRPVVcrTnpSaG84di8xMG42UTUybXpL?=
 =?utf-8?B?TXZLQnRvRkNzdEpUMGxyZlJnL1Vvc1lIVlhYeWpGNkJkUDM5VUpib0gyOG11?=
 =?utf-8?B?WXlrY3k5dXlMUGc2d2ZDNjFLZmxNcHJ1S1BzdGlnY0tXbkZRTlBHalZJWFZ0?=
 =?utf-8?B?QnJHYlpIb2lLK1QrWTdUa3VuTTdSRWVkUHpJdVY2ZkdzeHBFdkJNNk9CdlM1?=
 =?utf-8?B?VDVRKy95cVlFdWFQSWY4QlZudW9ZTnFISWZya3RWQzhSRTdkbm92OEdQczRD?=
 =?utf-8?B?d1pNMkI3WDYzUnN1MnJYTmFhQUNUc1hMbHI2L2VFRC80azlmbzRqeTBtWEp6?=
 =?utf-8?B?dGsvWXEwWVNMdSt1ZlgvMXpwUVJwSExBNEJlaUc5U01ITGsyOWJTN2xObHg0?=
 =?utf-8?B?N3JrSG1tbkh2UG9zREQwVk1PTURyV3FRRUFqMjgvL0FpajdLUUZ0dE5RcVp2?=
 =?utf-8?B?UWR5T1JteDRNNHBSSDNUdnowMWd3dFRyMjVCSWhKdjVldzBPcGZwbnJJeWt1?=
 =?utf-8?B?VlRScHJQMUNjdlN3Y0pkeUlzQmxWci9zajhFTThLQkxDKzBrVlZnVUdPUUpL?=
 =?utf-8?B?MjRjb0RCQTNmWHVmM0NGc2paYktSdWpoWWwvcUY5RituNndodjBlWXRCYndi?=
 =?utf-8?B?VTl0Q1IxbUdETFViUjJOSWhuTkhpZnpZdWZwUnRlZGswa3RuNnl5YWYzcHBB?=
 =?utf-8?B?U3pQUTFodnhNR0h5VTZmUzlTUHZxSVFEQ2cxRUR6c1AyT0VLdWY1Mjl0RDBM?=
 =?utf-8?B?MW40cFdtaEppVFdGaXlLaGwrcnQ5SGFiT2xQRm9BVzNVVUNPSy9Rc0haK0Ja?=
 =?utf-8?B?cnpvajBvekp0WHM2Y3RCR090cUxrUFpxbmZuSkg2UGtwcHQ2VjA1eXdBb2Z1?=
 =?utf-8?B?cDFmKzJtVUxVMENuRjRLdE5pbnF2SklXT1luZXJHaWFVa2paa3NrT21KMEdV?=
 =?utf-8?B?TE9rb04rK1NwMGVqSHRlU0JXdFhJV01xNm1JK0plWkpZSVljNFhKZWVEVWV5?=
 =?utf-8?B?bXVNRU5KWkh1RHY0QmdPd3BiekVyRXRIMWFORElyWjEvWWo1MW5Pei9pQzRz?=
 =?utf-8?B?MFB5MUpqU0hMQ1BZTkgybXU4aVB4Z2syNnJyT1lOcW5xb0Nac3BFMUZwaDg2?=
 =?utf-8?B?bjlpVWtZWjRzQTMzbEJWMGIrc2FzZ21UM0RzdEVxZVhvWE5BYmhxYzlDblVK?=
 =?utf-8?B?UFRhVWV5WU5oVVBzZGJuMXBucUtDUEFHQ1kwRnpnKzh1TjQ5UUdjQ2lEM0l1?=
 =?utf-8?B?WDE4N3lZMzJPeWt3eUJ6dTZ3SzBrNUlUQUR0Z0N2UHF3Q1BySjVRUThyMDNR?=
 =?utf-8?B?Q3FsRkNSRVNsVzlmVUlCanNzUmc0V1d4OFNoUjl0WGN2elFZN2M0UUZjbG1u?=
 =?utf-8?B?N2h0blliUC81aytESUsrWDVvVGVvdERmd3RsMkhSRHZyWGdVYmo2SnR0M0k2?=
 =?utf-8?B?YXBJQlpoTHZxcGFLb0FFbmg1dHZ0NnNRWlc3WkZxQzV2bTU2MXc4YldJcEV4?=
 =?utf-8?B?T2tqUXF3cUtZc3psWjVwYzNsKzdtL2VHMlNtOXMyMWs5enVQM3hldDdWS3NU?=
 =?utf-8?B?bWw5N0RUQXkxd01BSDdNVlNGWERHUHZHQ2hZdzF2b0hLN2hXMlVOVC9lQkRn?=
 =?utf-8?B?aDlqd3VlT2xLdlkrakp1VVBPbDBiaHR3K052aDNrRThETSsrcFBoc3VSY0lG?=
 =?utf-8?B?enN2ei9qek5ma2cvMkRFZzZwTnptd2hSYURZTnU0eHNERy9DQmpDYkdzTllE?=
 =?utf-8?B?QVpZaVlSUjhWTi8wMWNRa012cjZzZXZNWkExc3NRcTZWYjR1ZFEyRURIRzRh?=
 =?utf-8?B?SXNYbEttbVl4dUczZm41WHhSTkxHM2VvVnRsV3pvUWVDSENuZ0xEeVRZTlJv?=
 =?utf-8?Q?W800=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMBPR06MB10365.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OWVtTThSM3V6cGNtakRHenR5Z0F5ZTBEaER5aGlSNHpkb3FNU2VnL1JxT3dq?=
 =?utf-8?B?Y2dVSHZXNUVWZ1ZkOHlBRDkycmRodDRidWlOZWJwSUgzZFQ5bkowTnFkY2Mx?=
 =?utf-8?B?ZVF1L1R3dlFWNFgxMFBPTHJFb2VSMnBSYkNSM0ltWkRpbGFTM3diY3F3UDdr?=
 =?utf-8?B?aEl2L3UrVHJ1dmc2K1RHekk5RnlpYURZMkNENUZJcHo1TDNsM2JpMjVZNXZQ?=
 =?utf-8?B?OG5qcFNIRE1Cd1QzZ0FVeGdWVzY3VU42Qkt0VmNDS3hkMG9wR3VWMDl6VitC?=
 =?utf-8?B?ZzdsdTMzSmdqVUtGSkZlVnU2aWFaeGZVSVlkWEtsM0t3bllVeVRyVWZEa0d4?=
 =?utf-8?B?QmI4S0FUdlM0N2E1Y1lQOW1STkwyNXFteXcwSnZaYzRtZXZ6Tk9tdXZId1h1?=
 =?utf-8?B?TWhacFJraFJOT2dLVG9JVFNqeDdGMytqanJNNmE5NzBzYnY4ZDBiNi80Ymx2?=
 =?utf-8?B?T09XKzc2dFc2bktLQjJ4REJLNFBkaDZ2M1RjOEVqOElieEJxbmlqQVoxcWl5?=
 =?utf-8?B?dng2V3FSbkdvSFJIWEd1RVF0Umpob2tZajJ5dUNVK2IrczBJUkdKSzUyUk1J?=
 =?utf-8?B?VGF0VUJwZEJ5S2tYVlhTa0V0bThJYUltSDZyQWl1cDd3aEpFZ1F2b096N0dY?=
 =?utf-8?B?R05BWWtNdVJjbnpsRnZOZkcxUmpaK01xelVwcmJpMXpORFloWC9wWVpxbkwy?=
 =?utf-8?B?Z0V2SWxFcVBHK2RXYzI0QkFkYVhvTW1aYUdSaUZ3Q2dSUjA1bVYzSUoxUDVi?=
 =?utf-8?B?cUNVbzAwNTNvRXozQWptWVg3dFN4eGEvZ0wyb1Y5akFoUFVrQkpGU2pWVVZz?=
 =?utf-8?B?RUNRRnhSbVJwMm9LY1Njd1VBTEtzMktNQjcwMVNRdThHMEJ0MDEwdUpEZnNn?=
 =?utf-8?B?VjdiU3pqeE1WMmk1My9xR2hDMVZoZ0ZpUUwwZzZxYjhRRmlQYUI1N2F4MFZB?=
 =?utf-8?B?SWxScmszVmtQN3ZzbVpTLzBtOXhaVU9mem0vdEpmNmRhc1dzR1RqYldvMVZi?=
 =?utf-8?B?L1RTR1REUU1abzE0eitaYTVucFkzTlYwekNOUFdqVFpTMm5MVXlVMktOT0ZM?=
 =?utf-8?B?QkxiMjEyc1FEYkwwMk1HUUdtclllWnBtOXZlcG0vOXBleEJyZkFMM21DUjRP?=
 =?utf-8?B?Zk1wa3hLUVNwZmM5bmVKc0tSUVkyTlFjeDllODAyaFhEdTUreUdreW9jaVRI?=
 =?utf-8?B?WXVNUktIaERaNXd2OTVRS1ltWU9qTWlpdDJ1RThHcWd2NU1wcTJxdmhCVnc3?=
 =?utf-8?B?QUEyQXBQT3hpZDZpUHY1My9hUi9kMGNrNVpRZmlBOUd6Vm52U0pvVjN3RVMr?=
 =?utf-8?B?NlNDby93c0tKcGt1SDFPUDFaVEEwaEVtZ3pseGE5a1UvUTBxM2FMVkdUNmVH?=
 =?utf-8?B?NFNnT0RpMzExSlJId0x4OG93bGF0UkNIMzR2QnU2THVnUVh2WGo2c09PenhM?=
 =?utf-8?B?NmJYa2pHaUxObWNPeVNKZFZhMW96T2s4RVp4SEw0aS9hUWJwSlh0dERlamVt?=
 =?utf-8?B?QzhIblB1emdpTHpna3gwTWM4SUpLOUtYcWc3dU4zRUVOWmVvNlJLQllBOWFW?=
 =?utf-8?B?YS8yNXZHMDYwYjZrcTFGYXdNZVdSM3A5anl2Y2o0WkVmN0Q4NWNweVdEREFF?=
 =?utf-8?B?azFWNWlSWmNMQ25nckVLMUJJbDB4ZEJtVEhOeFlIVGNHTzE4VUJPRzBpUy80?=
 =?utf-8?B?TmppRUo1ZWJQSnBXVForQ3Q4M2h5NHZYaEZRcGUvc1dwcWF3dGwxNEZzem5N?=
 =?utf-8?B?L0lDUzdPRUVlVlUyT3gzT2VCV1dkbk12R2J0S1NOZkROTmU5dnprWk56Y0tW?=
 =?utf-8?B?VmJ4c0Z2ZWk0dWUzRXBlV2VvNWtpQk03M3ZHRHQ4bEFmSGFHWFV6UzYwM252?=
 =?utf-8?B?TWc5TnAyN090V213SjU1RWZQSlFDRjg4NlB4am9QS3NEYlRoeE9CNEFhOFpw?=
 =?utf-8?B?K1c3Vy9BTnpLc2xQSXVnWG9FeERUSkMwS21UcGZrNGJTSUtEZ3p3UVA4VEk4?=
 =?utf-8?B?K3FrYlN6STZhVmhHbkM2Q2RSNmluNGdxRkVzOU5zUjZrS2oySlIyT1E5bWNC?=
 =?utf-8?B?R3NjSUtmSit4RUtUMGUyK3BlNHVudENJbXdnU1VEbnJBV1Y3aEhmbnd5YTFU?=
 =?utf-8?B?OWdSZncvZVd0aUtVd1FyU29RQ2FxOSthVzNZNGRUVDRmN1dpc1A4MDVIUVcw?=
 =?utf-8?B?WXcydnRsSzRNS0dvMUhkYUVMWWJTQzdmemJFRkd0WTd2Y0hJRGF6clNwZmxw?=
 =?utf-8?B?Wk9xVHN3VzdicXk1N3p2SUxGVlRMM2RMZW9pa0NFcGpPZy8xY1AwKzZmTnkr?=
 =?utf-8?B?blZ3eEcxZVJ0ZVdKZHpKUkxtc01ReC9pN2ZmSDRaV2FFUFd2Q2sxUHNTN0Mz?=
 =?utf-8?Q?jbAehD7MP2JFmSFU=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dab240d2-f5a0-4451-b4ab-08de624b6ddc
X-MS-Exchange-CrossTenant-AuthSource: AMBPR06MB10365.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2026 11:08:44.0306
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 99C+wQeorkIORCWjiNfYTehcJ8zyilNZVWA0RqJVSP7Si5g9Dzp1WPzJiYj2bA9OEHto/V9VobjlFvLRW4ResQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR06MB6791

Hi,

On 02/02/2026 12:28, Nuno Sá wrote:
> On Sat, 2026-01-31 at 14:30 -0600, David Lechner wrote:

>>
>> Do we actually need this one? Alternative could be, for example:
>>
>> int iio_backend_enable(struct iio_backend *back)
>> {
>> 	int ret;
>>
>> 	ret = iio_backend_op_call(back, enable);
>> 	
>> 	return ret == -EOPNOTSUPP ? 0 : ret;
>> }
> 
> I would prefer not to assume we can ignore the backend not supporting
> the call. It opens up the question for other operations.
> 
> My preferred way for this kind of fundamental operation (enabling/disabling)
> would be to check with DT maintainers if we could have some kind of fixed-backend
> (fixed in the sense the HW is present but not controlled by Linux) dummy device that
> with implement a no-OP enable/disable().

There is also use cases for the always_on cap with a configurable
non-dummy backend. Some applications are such that the driver should
leave the enabling/disabling up to the user space consuming the data.
For this case it's great to have the frontend leave the backend enable
alone using this capability.

thanks,
Tomas


> 
> - Nuno Sá

