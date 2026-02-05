Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11020122.outbound.protection.outlook.com [52.101.84.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E3C3D3488;
	Thu,  5 Feb 2026 12:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.122
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770294262; cv=fail; b=KyODRm3KhdmI9kiECIH7t7ApsZ+dD78QphQ3dx3sObCIVOYZTPN+wFfIaS7w6SeEQDCezxiv+IMYRkWdhUyNof/uCSOPMm0LmYb5v8CzWSlBKItx9kQsiBBBvDE9DCm5vjCBK58MNEigcS+EfGwsVrZZG29qpwPMGbmUDvSxM70=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770294262; c=relaxed/simple;
	bh=mxfzByvWTqKf1vS27qUdV/KAsfTBDZ7YIWcbiOjB+vU=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=OZ+FKBsZeSiGWpbKcWTPoATCqMUWZNrbCt09Ze71LbTP9SVyBLKxzdDoE8c+kznuIeolbAXn5tMNsWZY/o4M3cLjXXH73yOxKFVrByfSWGtXoj/ol0807NixZfTT0RgPnKdu5hN6MJKHsDAmFbKG63wFIADRUMpS9q0C8ImuyeA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com; spf=pass smtp.mailfrom=vaisala.com; dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b=Us82lOkd; arc=fail smtp.client-ip=52.101.84.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="Us82lOkd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kKywjo+nzlrSgNqPHssBsht3ush7DDiKXwIDN0COcjlOjkaL7AGtFJxlt5di5NpQqtSG6uX+jxIfU70xU0EQSY3FNOcu+fWNKQpJKZp9DHpcRfTAlSV6eq5baAMpeHmJLOWdnzht7gqlTyPsoHN5Unog/muNgRmKl1dIQF3VpOS9mr0kPYCAPa16aR49rWFp4UVKFVSpaz3y9gkiFNTFniqf2T2AXEAObqMvZ+kj2fgPzn66PKBSQn4dOslz0USJ0tL3MWAvWsQ5xR/dxYJ3LPOQzUGYWe0zuWsMHurRy0YkyJGpsazi/BgYimVWgx8p93JGw0k9Gdp6/bxedxwUSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MQArJXZYP22Rhs/gDr6K7OxYMJGbsWaxv8Yn6a8FlVU=;
 b=nzheaPsY1GfVTovr1yJ1UhI2JoKefDJySCZoMUqdIz+eU3yVcP5ALEwV7lGjpbz367z/kYZhA83qPtfUsSF9Zqnt8yoAx2NuF4HTW0U6T5GmhL/ZQPKs8oBcjMl/PTl4B18hKhrI41QWyiKbxHlJC+9+TgjL/GULqtz7DlE5MwYH0iNiZqeS+GwkOrKRCyVw7Goi/6KQxfefo77ypkJIQ1G4oZe4APgKNKdNz10LwifTfV81EPw0NlgX0RXsyFuS3YEf6HU1cL1eLXVKQuuYAfy/uXo7CaxiE7leXkH3USU7ZLHmyyyDEcya+UBTFJMo6dxHLZ38mcRHKTeWtNhgyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MQArJXZYP22Rhs/gDr6K7OxYMJGbsWaxv8Yn6a8FlVU=;
 b=Us82lOkdz1+KSfXm0IT/rFLsRkYP0Rzovymrb/mMR074T2cJI6FqNHMm0WySPUpEpGM+cSsaOuKVeXMm94NPnKujRqUo5PXw8eOWK1Lz29+RHCfFhkFafN4P/s81DoQUyOt0jAIaQcDqXFunb2+Kk6GIB07wXlWUMUHHiJ1O3m4v3dtfaAI0C346cn/gJjPknZAtzdMtXWa75bCi1pPWijy+9yXtOZLzH1pKin9pkcebebdoSNnteZaBsGDhzEjFQN9uMnpepRV2Ax04cN+Qosq0cheOlcwKS+ke1QAZ/4zj1aegoeIjR/0hgyI5kngbxCrKQR5b3n/bRpT8TydlfQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from AMBPR06MB10365.eurprd06.prod.outlook.com (2603:10a6:20b:6f0::7)
 by VI0PR06MB9745.eurprd06.prod.outlook.com (2603:10a6:800:213::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.13; Thu, 5 Feb
 2026 12:24:13 +0000
Received: from AMBPR06MB10365.eurprd06.prod.outlook.com
 ([fe80::addd:5e9b:7273:8049]) by AMBPR06MB10365.eurprd06.prod.outlook.com
 ([fe80::addd:5e9b:7273:8049%6]) with mapi id 15.20.9587.010; Thu, 5 Feb 2026
 12:24:13 +0000
From: Tomas Melin <tomas.melin@vaisala.com>
Date: Thu, 05 Feb 2026 12:24:07 +0000
Subject: [PATCH v6 1/5] iio: industrialio-backend: support backend
 capabilities
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260205-b4-ad9467-optional-backend-v6-1-7ca20c40c59a@vaisala.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1770294251; l=4202;
 i=tomas.melin@vaisala.com; s=20251125; h=from:subject:message-id;
 bh=mxfzByvWTqKf1vS27qUdV/KAsfTBDZ7YIWcbiOjB+vU=;
 b=WOrdD76KHRfpnpmgSgwxZAkKsbaxE0zeObd7IvoHHB5HiSCYYMOfNo6egPM6PLekvQcf1LlG0
 CYft2QuuP6BD2GKD597BrSoenClnflK9ennclc5xq2Q91tuYD+MITsG
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
X-MS-Office365-Filtering-Correlation-Id: 62e9468a-ff1d-4900-d42f-08de64b178d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?clc5dXJ0aFAxNmlIUWdRcmphbkVubDZnTENDRHpMR2VMRGRQa1E4elhqSHg3?=
 =?utf-8?B?RTh4cU15cnNWaVF3REM1a0FQQmorVEJNV1pscmlFN1IzTjEvNGRIOHp5U3h6?=
 =?utf-8?B?VFR2VjltaTFWUkpYSWhZeENiY2RqT0ErMFRoNmpHeE44L0dxa28yS3VGNDZw?=
 =?utf-8?B?aWt2QXpWc240Zi9xTHA5bGRjK0dTc2hUazBQbzdId1lsTFdNL1RyamhkZlJL?=
 =?utf-8?B?eDUvQ2w1bmNFREFqMXROREEzU0RSbmZXemhyYk91MVVZbXo5SnVDVGM0Rkty?=
 =?utf-8?B?QitjU3MzTWVma1ZsQ3F6WTBCdmU5b3IvTXc1cTQvY1Z3cE5yUGFXRTZSdzM2?=
 =?utf-8?B?TnE3WDZSS3JXVXVlc1YzajRURlYvaTNNNjdOczB3dk1lMExmTC9qeXZEaVhm?=
 =?utf-8?B?ZEk3aVVCakk4U3R6T0pQNEZ3S3JWcHIxclIvRkMyT3RrcURHbmJzRHJuSUJR?=
 =?utf-8?B?eWxBRmJvcFF6WGVDMnJkQkZFa3NrVHp1ZGtwWUdhVFNqL1Bja2VZQTFYT1Q5?=
 =?utf-8?B?aUZRWkVQQ2Fjd2tFVERTN3d6SlBoZWVpWDI2b2dtVEN2Vys4eS8yUWl2U25W?=
 =?utf-8?B?ekxKUzQ4bmxDU0hLSFdRNXhEQzQwMTFIaHIyclJSM2ZicDRhU0hFUmNwdVp5?=
 =?utf-8?B?L3lNcy9CTldQazhuczkzTWRPWFJVclV2cllsdXhlWjlXZTdIR1ZEdWFxY2JG?=
 =?utf-8?B?SEdkaEd6RXRxRDY5T1ZKNWVvcmQ3OUo3NFFNYUFodmdhNVREdlIxa3pRbEJT?=
 =?utf-8?B?YUJ1VG5qUjZPbU4xVkFoUkIrVXVUUUMxNHdaQklkeDYxYjJVWnBLbTNNclBF?=
 =?utf-8?B?cFJOYzlHcXBNTktpa20wcnlxZnlEUElFazZzT2pYSm9DZHBLNjYzNTRLbjZt?=
 =?utf-8?B?ZjRLalVyYm1TYnRnSFVmQ3dqSXdzRG5DYjM5cGkvYmdRVHhYaUM1OENYc25j?=
 =?utf-8?B?Sld4OUN5N29meGpqZWwwVEFmUFNjWWhaUE04UlBFUGxlQ2VYTW9oY1B4dmVx?=
 =?utf-8?B?YU84WFZRMmtUY3NrT1B4QWQ2Z01kT1Q0N0RnbC9CQWtFeWs1bTd2dEdOUzdr?=
 =?utf-8?B?ejMzdU5uMm5tenFLMVltWFp4NlBtbm53MUVCSFVCanhqVUFrOTIxS2VJZGhM?=
 =?utf-8?B?WjNrejQ1Nlg2bU5keG16WTdrMFNpaDVJaTNDZXhDR2RHN0lOaE5SWSt6SGNN?=
 =?utf-8?B?L2FOVENBZDFNMFVTcURJbzFvcmYvZnVXaE9uaWlrMmJhVyt0bUJLV0RyNnI5?=
 =?utf-8?B?UThmZDkzSzRSZ1NWQnd4cjFBVStUTis5NmcvV2wwbWRYblo1c1FFRmI4TlNl?=
 =?utf-8?B?Yi9GcmNESGwxRkgrV1NkY1ZqYktHUytxb3VpOWdscFhKNWF2WWdoWmM0Z00v?=
 =?utf-8?B?NTNnN0FVR0hHdHlJaUlWbTlrc2JqWCt6amJNQzlPMVo2Y3E5eVBNbXJabEw0?=
 =?utf-8?B?WUFxNkptYnFROW9NN1lPb3ZqQ2E4R01UbmYwS01tcXl1S2dDTmE2eUhxdktL?=
 =?utf-8?B?bmNWUjc3dm9UTS92L0xpd2ZqQlU4ckIxTlVpZ3Z1azZmWG5JOEZ5MnB0cXJi?=
 =?utf-8?B?SUtQN2hHc2lTQ3crSjlOK2JMOExkWHU3UDJLenBBQklDTzc2UzA3WmJhVEJH?=
 =?utf-8?B?aWxWRDd5VkRBMDFWamNDQnJCOTE3UU9aNk9aaHYrb21xTjBSQWtRWkhmdWRw?=
 =?utf-8?B?eDVjemhud0ZnaHh5WjdxRXJ2R2dTcmsycFYzVFJlWGVFb1pwNUtqaHNnMW5S?=
 =?utf-8?B?YnVDeFE0Rm5pTHIyTnpQRUFWM3NGUTgxZ2w0NFFXVXc2c3ZyWGVEVGxvS0dS?=
 =?utf-8?B?aW82Ym45V3pUa3ZuSUx6RXZDT2UvRk56ZkUvOVFvQ0x2cGlvV2JvUzRxcXhR?=
 =?utf-8?B?ckNrU3Q0OTJHSEVaOE42aU0rb1lKcnh2dklOVVhwY3BINGR3TE9zelRNZGV5?=
 =?utf-8?B?QnY2RU1WYzdGK2p4UzNZdjBVMTA2OFBwMUxsaWRoKzkvQnJQT0ppbVNWRXkz?=
 =?utf-8?B?eXNrK3Y4ZFA0cG1NaENNcFk1WUtoWXM5T2Vsbk9WNDh3SGNkZ3RRYm1tVHFG?=
 =?utf-8?B?Qk1MSTE4a09CSWhrUXhFazluV21pOC94aFBaNmdsMm50MVIyWTRkYkFPWGdM?=
 =?utf-8?Q?8axQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMBPR06MB10365.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UmFoc241bFZNa2dHaFRJbVFiY0lxK1grU2FodnhrSkkxOHJ1REgvekVXcytm?=
 =?utf-8?B?WFhGM0FZWFM3Z29YVUtiMUNuZGp6RXRjd2RFaW8wY3FyWVI3d0JYQ2NHTEx3?=
 =?utf-8?B?QlFJOTRPdG9PRi82VHIrSVowYnE2b1pvNDhPTDY1QzMycG1BeWlFcXpxd3B3?=
 =?utf-8?B?d25YQ0wwRUlsTXhrZ08xcGM2dHp3aUl1a1ZSMW9xSU9yZlJwQjhWQ3V2OWJP?=
 =?utf-8?B?eDhhbE43NUQxQzZBOExyRkttK2pDeWUvVDZ4RW5RbVJPTFRRMTQ4MnJEWk5E?=
 =?utf-8?B?azd2T3U3NW1ZK3p4cUdNempock9HMmVJMVpuNGhYTk00M0d3MzZxeEFtNFF1?=
 =?utf-8?B?enhvNG42VnQ4bElxdHJCRzVxTlVDZk1SYklZQm1mZmJZSnp2ZjEzQXBoVHNZ?=
 =?utf-8?B?Nmc5WEJZSURyNGx5YSs3dHNuOFZIYm9nYStOQVpJWGVhQUorOGdzcHJQcExO?=
 =?utf-8?B?NVc3c1VLcDdOOHgxZ0N0eTVUMm8xbWpLT2tYdU5jMFJzT3NoaFY1R3ZDY3Rv?=
 =?utf-8?B?RUZrdVdBQ2NaQXp2bjVFMG9pRTVVdFlQTDRvTlYrZE5vYUQ3OEV4NVVVYVJP?=
 =?utf-8?B?djkvUE53ZThidlFQYVNZQy80MGRzQW9HYm93ckwzRy9hbksxZGtaaTlGZEdu?=
 =?utf-8?B?TllhcnhrN0plbEpSRGFPZ1RUUDg2ZmJJem9vQmZSV3I1TURGY04wVWZrS1d0?=
 =?utf-8?B?OU5IMTAwMWI5Y09HUERTc3U1ZDlsYS9mR1E2Rk0vczVsNHYxS29lRDNrRmdF?=
 =?utf-8?B?SG8rNHlJVzhNV0RUKzdTNWR6SlF5Z2F1SlJkNVJKUnhHZ2tWZVlod3dQekZX?=
 =?utf-8?B?eFBKZ3dTamU4QUkyaVlRUjNib0syOGF5VFJVc1o1SmF5ck81OEdnWk5JcG0z?=
 =?utf-8?B?NFRDbHlWTEF1MkduT0ZkQzRZYldGV0E3OHhUcjU5Zkc4VnArQTFkSmY5RG5m?=
 =?utf-8?B?cGJETEFDZHR5VmFsaDBvSDBXVUlOTXhyTit1RmJLeDluOEI2V0N4dzRKOVNj?=
 =?utf-8?B?b0RWZjZYVW9VUW5iaUhYR21BQkhGTndkdzNvZVI2NG9uQUtaVDl3a0ZTRDBS?=
 =?utf-8?B?OG81RjRtM3Q3YTJndHFJOGNLL3Z2VzA4VDhPK0F0S01ZS3ZPRVRyVUM1enph?=
 =?utf-8?B?OVo2a0NYelJJYlE5ZXhiTlpOUWRhRW5YMlZsS1JwUG5hNlM4MENYQ0FseG5Z?=
 =?utf-8?B?OElIaGpvOE05YkFROVg2WFBpSG9SQVpndlcxd0xKSUd6YVpHQ2hkclY2UjdF?=
 =?utf-8?B?US8wQktGaGoxS0FKbTRHTnhVaWNuQmh3UjhPSGJNWHRoL2V2T041Q0duMmxu?=
 =?utf-8?B?VkRVN3huTlNSWG1iTzZIeUtRVFl5V04razlqY0RBVjUzZWZ4Uzl6dEJRRmlP?=
 =?utf-8?B?L3ltcDVQMDE4T1dEU3ZNc3JHRzdGRysvdFA3Z0FWQ0d6cXUvNzA4QmlZUXg1?=
 =?utf-8?B?STlJdGtPTGF4ODRvL3FIbm05bytUa2NzUzhYVkZjdDJjamZCWGFBK3l2ZGJP?=
 =?utf-8?B?MXZxMEg0UjFFSWJJTDJkVXpMUFVISkhYY3k5K1dxK0dmNEJxdEtpSC9ET0hv?=
 =?utf-8?B?Lzg0ZU1KVjNvMFJKRzdCbXVISEpCUUJSTDlWbXB4SCtMM284L1RpSVlUbzZv?=
 =?utf-8?B?YW9oZzJhenY5aVBSWFFBeDd1cVdCeDhQNDMxN2d5OEhaRGxhYlhPMHo3ek0v?=
 =?utf-8?B?NWtGOW00a0M4bWErVi9wRFhoMk9QeCt6T0o3MGhiZEgzNWlHeWozNUExTUcw?=
 =?utf-8?B?S0Z5Zzh5bUt1cmZlVGdEeThNVVlmL0RLemF3Nzh5ZEREWW9CVWZoT3k0aDhn?=
 =?utf-8?B?a0NaNkZpVWs3NDlZT01ZandjWlVJMURWbEdLaXdwbExRQi83Umg1QWg3anZu?=
 =?utf-8?B?OUxCVXZGdytjMVJacjRrRTQwd0Jsa3VhZktWWE41eXVPUVF5QXdWZkJPOEZa?=
 =?utf-8?B?U1ViUFQ0VnhDRDdEcjJvNDFCRUlXWkFnSHJoNGF0Tks1Nk9zVEd0VmNESFRG?=
 =?utf-8?B?dllkcU9ySVQrZDZsYWZtTkU3UC8xSnQzZmVLYUtaVmc1eGQvQm1uSWpuUXdv?=
 =?utf-8?B?UEQyZkZLK3BLY0hwSk1DMFVCYXpzWGIvUmlUY0E2aFRaTEgvcDRheFNNS1U0?=
 =?utf-8?B?akV2UUR1SjNSOTluRDJ5MjRSTG1aSUNsZTJ4dlpuMEVEc0l3SDEyRVJvSnlF?=
 =?utf-8?B?L3VmenphaHBhb1J5dWg2SlN4NFFHNm5mbFhySUUzc3FFRlFnRm1HMExlYmhN?=
 =?utf-8?B?M2d2MFRPYkJaQjN3c0JubEFnY2J6MVJyMVZnWDg2b3Z4emdYQTE4UWFpd3Y0?=
 =?utf-8?B?T1hhQmFhU1NiTWU5c2JmWmhPYW1VY3ZicmVSTjlNbGNSNVJyNjViME5tODJh?=
 =?utf-8?Q?2g9cyWhLnr9AkZVc=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62e9468a-ff1d-4900-d42f-08de64b178d8
X-MS-Exchange-CrossTenant-AuthSource: AMBPR06MB10365.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 12:24:13.4025
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OmDWfwCofujoFB/4fJSnWXfwSnFEILDe/E7jX3fkD8gvh37e6W8na8kgi7Ryrpn5C4s/1Chcz+2jjIO/MedAAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR06MB9745

Not all backends support the full set of capabilities provided by the
industrialio-backend framework. Capability bits can be used in frontends
and backends for checking for a certain feature set, or if using
related functions can be expected to fail.

Capability bits should be set by a compatible backend and provided when
registering the backend.

Signed-off-by: Tomas Melin <tomas.melin@vaisala.com>
---
 drivers/iio/industrialio-backend.c | 16 ++++++++++++++++
 include/linux/iio/backend.h        | 24 ++++++++++++++++++++++++
 2 files changed, 40 insertions(+)

diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industrialio-backend.c
index 447b694d6d5f..1afd00763da9 100644
--- a/drivers/iio/industrialio-backend.c
+++ b/drivers/iio/industrialio-backend.c
@@ -56,6 +56,7 @@ struct iio_backend {
 	void *priv;
 	const char *name;
 	unsigned int cached_reg_addr;
+	u32 caps;
 	/*
 	 * This index is relative to the frontend. Meaning that for
 	 * frontends with multiple backends, this will be the index of this
@@ -774,6 +775,20 @@ int iio_backend_extend_chan_spec(struct iio_backend *back,
 }
 EXPORT_SYMBOL_NS_GPL(iio_backend_extend_chan_spec, "IIO_BACKEND");
 
+/**
+ * iio_backend_has_caps - Check if backend has specific capabilities
+ * @back: Backend device
+ * @caps: Capabilities to check
+ *
+ * RETURNS:
+ * True if backend has all the requested capabilities, false otherwise.
+ */
+bool iio_backend_has_caps(struct iio_backend *back, u32 caps)
+{
+	return (back->caps & caps) == caps;
+}
+EXPORT_SYMBOL_NS_GPL(iio_backend_has_caps, "IIO_BACKEND");
+
 static void iio_backend_release(void *arg)
 {
 	struct iio_backend *back = arg;
@@ -1114,6 +1129,7 @@ int devm_iio_backend_register(struct device *dev,
 
 	back->ops = info->ops;
 	back->name = info->name;
+	back->caps = info->caps;
 	back->owner = dev->driver->owner;
 	back->dev = dev;
 	back->priv = priv;
diff --git a/include/linux/iio/backend.h b/include/linux/iio/backend.h
index 7f815f3fed6a..4d15c2a9802c 100644
--- a/include/linux/iio/backend.h
+++ b/include/linux/iio/backend.h
@@ -84,6 +84,27 @@ enum iio_backend_filter_type {
 	IIO_BACKEND_FILTER_TYPE_MAX
 };
 
+/**
+ * enum iio_backend_capabilities - Backend capabilities
+ * Backend capabilities can be used by frontends to check if a given
+ * functionality is supported by the backend. This is useful for frontend
+ * devices which are expected to work with alternative backend
+ * implementations. Capabilities are loosely coupled with operations,
+ * meaning that a capability requires certain operations to be implemented
+ * by the backend. A capability might be mapped to a single operation or
+ * multiple operations.
+ *
+ * @IIO_BACKEND_CAP_CALIBRATION: Backend supports digital interface
+ * calibration. Calibration procedure is device specific.
+ * @IIO_BACKEND_CAP_BUFFER: Support for IIO buffer interface.
+ * @IIO_BACKEND_CAP_ENABLE: Backend can be explicitly enabled/disabled.
+ */
+enum iio_backend_capabilities {
+	IIO_BACKEND_CAP_CALIBRATION = BIT(0),
+	IIO_BACKEND_CAP_BUFFER = BIT(1),
+	IIO_BACKEND_CAP_ENABLE = BIT(2),
+};
+
 /**
  * struct iio_backend_ops - operations structure for an iio_backend
  * @enable: Enable backend.
@@ -179,10 +200,12 @@ struct iio_backend_ops {
  * struct iio_backend_info - info structure for an iio_backend
  * @name: Backend name.
  * @ops: Backend operations.
+ * @caps: Backend capabilities. (bitmask of enum iio_backend_capabilities).
  */
 struct iio_backend_info {
 	const char *name;
 	const struct iio_backend_ops *ops;
+	u32 caps;
 };
 
 int iio_backend_chan_enable(struct iio_backend *back, unsigned int chan);
@@ -235,6 +258,7 @@ int iio_backend_read_raw(struct iio_backend *back,
 			 long mask);
 int iio_backend_extend_chan_spec(struct iio_backend *back,
 				 struct iio_chan_spec *chan);
+bool iio_backend_has_caps(struct iio_backend *back, u32 caps);
 void *iio_backend_get_priv(const struct iio_backend *conv);
 struct iio_backend *devm_iio_backend_get(struct device *dev, const char *name);
 struct iio_backend *devm_iio_backend_fwnode_get(struct device *dev,

-- 
2.47.3

