Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11020076.outbound.protection.outlook.com [52.101.69.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73A93360757;
	Tue, 10 Feb 2026 10:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770720854; cv=fail; b=NFB9phjZCUK53TfQKUxpaeT8BpltALuEq/ETt6k9ZdE/LFl626yR1hEhfUx9y9MjOL/dXy3OxfV3fAG6b4SbvLUeZBoEx788ZTIkTrvi7mjGbA7jBT4DB6cFiSZDVwWY/cFU1Skdj9vk5Jj3BEZxydslqE19r4jScI+oIwcvZsY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770720854; c=relaxed/simple;
	bh=eDKLrKHCJym4jxzElhhPzmOpuem6V4NzXdvoGftWNjg=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=rz3nIQrWuzmmoemxgdi2slV55mjigCCPTr60Dt3DhVD0hSee6PkIEPXpMeCfy5dwqoJOa7A8IvyFkZmS2ERJeU7t5+pOmMiL/+o1wC/K2fqg7ZXAJWhDcx3YVxvbL6Pm5O0Lpefobr3w4tJgjDGQgkAMz2xsCNusA6ye6n1XX0k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com; spf=pass smtp.mailfrom=vaisala.com; dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b=wjHOd1qO; arc=fail smtp.client-ip=52.101.69.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="wjHOd1qO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YeEC28t6Cbu8wqU1Pk49ikaiFBD5L2WAYhM+DUNwjpvMSRdtgSkLXZX+g+nXyjJKnFxhBfs+8LHI45PzlaVQCMVfmlGP62mBrT0vPFzDPGClPWGJR/Zh6U4EDItY/kSD6p9ptkm4fPI3jRg8lUT8YBbq23O7sb/VpeVK5x7HzpujsiZD+iv0lmmDY+9qgDfwJSYMPICK7SCDpiqeNBvg4il8Ikl8cwz8D4GilrqO3rN9z6nBKa8udxdBGLYgh+fH/L3C+yUVIlBDSvGFHwWwE0KA1iyB97K5vOT9UejNmnHMWSDk3eWjWnFTlGVONSbjl30n1LuZ4MEYprkj/4XBaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qxO5j41oRU5i1qfGhrbviI4aXxtPrZCzQoHMYnMRdCE=;
 b=A+wLxubmKDmCJ4xObzdnWBQA43bE8vwutFfcNtsFuqqGmt/BcLaq7TYb6c2ZXR3MRggKRFOKAaZMyd+UXoitZ8BkyKAomygBHZecOp8RZQv46h6KrOLpYRggCBfsLpVz3SPSX3BiFIAiEJD8ALIkgY7YfgnFr9zPXwTatYQzhG27zWQ6gEUUGttQVTPE55gKIjQ3Rq/HNtraNKESMJywUOoIXj11iC1D5qAGkhDjWHosE1N8NO7A3IUO3PGMoZCjS1efqGsWBEE2W5CWgVYOvbcXM0OYN/3eDuU+JQkxVt8OInI2Gn5m45v9QXiLBe5C8tRsKMCCnsxMAKU/Pamjdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qxO5j41oRU5i1qfGhrbviI4aXxtPrZCzQoHMYnMRdCE=;
 b=wjHOd1qOQ8jmG+rTs7ePlOtTGcf6wNlQYRB3i6iHtkkNEGhcinfeb6enW9JnokDdWGFLf2T9WAoUAMZs/jVXHdyAc8ToW1268BM+7oM2zEPsu4qutXpOaW69wgXuXOLDOw9PdHP1z/QvqNqh0zljNjJcqRgXNol0SNHCYRvSDYfiLS9y/yMFcEWvSeLdbO4DCXfQAzzr+F5nZkH5SC2fmszQ+Ls45qT4w8kblyeEbkUSCuRA1FfJQaUYsZU86XgzqftkSTgxChQttVONIL8RXsQIa72F1T+wFIOD1r2NOVxlr554o6comHYNX4DN2lwXMF3TX5k9A2iRmZtXRN9htQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from VI0PR06MB10639.eurprd06.prod.outlook.com
 (2603:10a6:800:2f4::10) by DU4PR06MB10173.eurprd06.prod.outlook.com
 (2603:10a6:10:621::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.13; Tue, 10 Feb
 2026 10:54:01 +0000
Received: from VI0PR06MB10639.eurprd06.prod.outlook.com
 ([fe80::3a41:90d:2091:bfee]) by VI0PR06MB10639.eurprd06.prod.outlook.com
 ([fe80::3a41:90d:2091:bfee%7]) with mapi id 15.20.9587.017; Tue, 10 Feb 2026
 10:54:00 +0000
From: Tomas Melin <tomas.melin@vaisala.com>
Date: Tue, 10 Feb 2026 10:53:36 +0000
Subject: [PATCH v7 3/6] iio: dac: adi-axi-dac: define supported iio-backend
 capabilities
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260210-b4-ad9467-optional-backend-v7-3-7a590ffe02df@vaisala.com>
References: <20260210-b4-ad9467-optional-backend-v7-0-7a590ffe02df@vaisala.com>
In-Reply-To: <20260210-b4-ad9467-optional-backend-v7-0-7a590ffe02df@vaisala.com>
To: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Nuno Sa <nuno.sa@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Olivier Moysan <olivier.moysan@foss.st.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Tomas Melin <tomas.melin@vaisala.com>
X-Mailer: b4 0.15-dev-c6abb
X-Developer-Signature: v=1; a=ed25519-sha256; t=1770720837; l=1061;
 i=tomas.melin@vaisala.com; s=20251125; h=from:subject:message-id;
 bh=eDKLrKHCJym4jxzElhhPzmOpuem6V4NzXdvoGftWNjg=;
 b=rNhX8gl+fqI15l7JWcl8dvvB0v3J00wi7t3kOchj/zmgywsLdie/4Wtt7QLkbsaYOXw+FZLh4
 QbCTImA/j4VD7gqiZqAf05nJqtVxxJGRdHD32L8cg8SCLG8/AQVFqAo
X-Developer-Key: i=tomas.melin@vaisala.com; a=ed25519;
 pk=6lMiecjZ+OeyZuxYsDm/ADy9D1JKvYrKdsYv58PMepU=
X-ClientProxiedBy: GV3P280CA0003.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:b::28) To VI0PR06MB10639.eurprd06.prod.outlook.com
 (2603:10a6:800:2f4::10)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR06MB10639:EE_|DU4PR06MB10173:EE_
X-MS-Office365-Filtering-Correlation-Id: 7de24072-92ae-4e27-8fc8-08de6892b2c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VW50cmpsQk12R1o1bDh1QmRhVXFPUUVadWRFK2o5U2hpYUswa2ttbjUwcWE1?=
 =?utf-8?B?THk3STdEVCtpckdzZDBlRmdpcGtIU3dncGd4Qkh6QWVxWkVIOUw1VVgrY2Nz?=
 =?utf-8?B?Zy91K3dBWGZ4Y2VPSWR6SEU4Q0dMbXlDWDZ0dDljS2xnT1lmdjVDMnZ5Y1hY?=
 =?utf-8?B?WnJhUUo2ZXI2UVI2dGVDeko0Ym9jSDdveE9aV091RWc1RnZiQTQra3VFbkRO?=
 =?utf-8?B?dGpnRUtsbHZZZ0VVc1dacDdPRVU0ODlkV1VKaUpJVFZVL3JEM293M2JCV0Jj?=
 =?utf-8?B?UElTMk8yVG1tRzZoMGQ3ejU3KzBZeFF1cE5obDlFYXF3U1A4NDBwZ1U4Q3V1?=
 =?utf-8?B?SzRieFNwQ1BJdHpENmc0TGs3R2lSVVpOUWFyMEdzK1pVQjhTamIrWnJ0eERL?=
 =?utf-8?B?Tlh0WjlvSk5mcWlENHJNWEVqdUJvRHlsZ2t4a3ZmVU1qZFVaQkViZ29tUlpJ?=
 =?utf-8?B?cHBIcmxoMHZLdzlEY095UXBpTzl6ekVUQlhIS3kydkswajdsNUdzOVBqck55?=
 =?utf-8?B?cUtGQjJPMG5jNnV1bS9WTWVHMU51RTRpbUdmdkFzdE5lTXBHRm4wZ3BPbUEy?=
 =?utf-8?B?VnBxZDZmdTNwNlhXOVBBckMxekFmTDJWUVhCN1RzQW5SdTgyN09vZ3RnbWNk?=
 =?utf-8?B?WU9reXJxWFM1b2VEOXExTzNsc1lTTmZDdGEzOU95V0h1RlJrM0pXYWNKMkI3?=
 =?utf-8?B?Rjltc2hpQ2k2Y21vZ0FkcHNCVzZUUnNROHNuRU9MY2ZzMFFGUVg5YUFnNGtJ?=
 =?utf-8?B?ekU1aHV4N00yc3M4dzkwNktUeFl6VGdjZk56N2REUlU3YkYzU0Z4Q2VobXFV?=
 =?utf-8?B?ZHFSZWpzVmk3clhwQWZIaTM4czB3cWV2TFpaSHhmdDB2N1Z2Qnp3Q0dzWjFW?=
 =?utf-8?B?S0dXcnVSMHN3ZmhGSnhtWGlORzVlMDdBc0dZeWVFa09PQXFqMFJhUWlDL1R4?=
 =?utf-8?B?STdNUXJpRXRaT0ZqUy9QQ3BoMVNzQU54MEdUV0FJQjcwWmNhMGRCdThTak10?=
 =?utf-8?B?RmQ0TlhiNmpSUTlmcjJlWjlLVVJBcWQ1ajhWa3l3OXI3Ykd1SlJreDlBOHcw?=
 =?utf-8?B?akxEUHNBUTdIZ3o2Nkh5c0Z3VVdRRm5WMzhXT2EydzJML3djcGw4UzRQdnl5?=
 =?utf-8?B?c05UNlJBbGlaNUg1eVlkMTNGaEhHTllNbjVSaWdZZkJNTXRSaEIrYWV4Tk0y?=
 =?utf-8?B?eTF2YThVQjM5Nnh1bTVHUk02eklzOE9pZjR0ODM1VHVwc2dYLzU4cXk2RGdV?=
 =?utf-8?B?bGx4L2IvVkJSU04yR2JtdGhLUVFIbDE0eTI2dFd1SVNjbkJMNnlCcU1HWXcr?=
 =?utf-8?B?UG9SVmNGdHFqaEVTSm9Ib29MZm8zbWEyV3hSQ0luWnE4VmYvWkRLUGdMb1RL?=
 =?utf-8?B?OGdrSnpMS3JNNkFPbmZMeUpyUjBMMG51dTZVdWYvWjQvYzVmSjRGMWZkNVAv?=
 =?utf-8?B?VENHMERMalVaYnVibGpqelhkdUcycXhpMXRJYlRTZk1xQUZYNk50TUlxZVJ6?=
 =?utf-8?B?MTJmb0RsVS81OUdZa0l4bFpZdWpOYkpRTVhhbTB4dytrS1RIeWtFK3hYOVcz?=
 =?utf-8?B?c2ZOUFNoeTA1UitNcUsyTG5yaU45d0poMjc4b3lKUjg3eUZKY2l6RzV6cHFi?=
 =?utf-8?B?Y2drWHJnV2hrdnpHZUR4OEpETG56bUpZRFZIcW0weG1XM0VUclBYL0REaEZM?=
 =?utf-8?B?eG1oUkZMSDMxc0hwdTk2SHpFMkMzNnlDSk5RcVR1NmRWcmlIZ3gvM1hlaEE5?=
 =?utf-8?B?WVhvRFpjREhyS01IdXRZR01xYklkN2xnNC9mTC90a2pqRWJBSERscE83Qjh6?=
 =?utf-8?B?anFDNGZjMm5Pb3dpYWRtc2tlZzBKN1Y1NHVDK3pwLzUrU3paZzNhRFZjYTdE?=
 =?utf-8?B?QjBWeldYZVBSdFB2VWxiWXJQaFJjUWZ1emxLWURHbkwwUnExL3h0dGlIclV2?=
 =?utf-8?B?MGdCdS9XNXZCSWxMYjlZbVdiQjIwbUNNa3V2QUZvdFgxQWpmQVl1UTNVamNR?=
 =?utf-8?B?QUl3OUl1TWVZUlIzdVdKK2d6UmVVaGZwVXlOOWxCU3JlNjZldmdQQlRnWkE0?=
 =?utf-8?B?OFJYUjdxL2ZtOUxmR0doVjFEZVc1V3IzNVRFNFgxOTRkZlJyQUpySStSNjlp?=
 =?utf-8?Q?Iy8U=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR06MB10639.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SkJMV2kycnVrZzQzMnJ1d3Fpd3BHeVQ4WEJoNm5vTytUbGhLUjBFQVJKVGFZ?=
 =?utf-8?B?em5KaXhNcGx5U1NpSkVKMHVFWmtCMkZPWWd2c0RPL3ZnVTRxL2kyQlZFZjc1?=
 =?utf-8?B?aFdoMFRtSi9rTlRUSnBpRDNVOXNwalZ4MnlsaVBOMXZENHFIN1J1YUx3UXdC?=
 =?utf-8?B?UWw2Z01zL1pCNFNvQjZ3dUVmMnVNaWJmbWdEWkVJc3UxdjNOSXY0ejJ2YkNv?=
 =?utf-8?B?L1lBeDltd2ZNMldFcDlUQkVzUjB1TGVibFNBY01DVFdyVW96M0xVakRYbTFr?=
 =?utf-8?B?ZEIvUi9aZm5HeEpjcXNGNzNDUEJvWFNGNFZUcjd0YnFsV3U3ZHBsbFFuaVJN?=
 =?utf-8?B?d21TL2lIQnMxZjlmVG05SE1hc2FhWVd3bXpxemJ5WWErSkxsNW9VV2hIUGky?=
 =?utf-8?B?SWdqNzVmSk1qVGMvWlFTVFNrcm44SllKbnVtR3FvRjU3QWVrV3hsdTNHVmR0?=
 =?utf-8?B?S1U5R1RhenNzMWR4S3dnVnB4dG95VFpOL1FhenNMUFpKM0NuOUdYV3diSVBm?=
 =?utf-8?B?V1pKSXVLVktIY2dpTkZ5dFk5Lzk0eFdBNXZSa2NtcDhMbFJRZUtvZEVaaWFy?=
 =?utf-8?B?T2h0Q2Y5SzRHekVvRU9OSkROVy95MjMrbzVoOXk4Z2xwMy9PbU5CY2hReFBl?=
 =?utf-8?B?Zlh1QmlqSnMzYU4vbEZ3YnVtZjFYQXFad09rNExFckVWYlFTT0lUbXVRNDRn?=
 =?utf-8?B?amYxcHFaUGpVL3I4bzZPNVRWMFgvd3VYai96L3RZSjhBV28wODc2eTdDTmM4?=
 =?utf-8?B?bkR3eXVjVkt1TStVazRCOW16VkVEY2x3SUl0Sk1GdzY2aEFjSFlJSjk3SDF5?=
 =?utf-8?B?UG50azZreVZPaEl0VHFXbnlNd09HR2ZzSXNBUmN0TG9wUTZoMEZIT20rZEMx?=
 =?utf-8?B?a0RQMTFNZk1RR0hCbHJ0b2dXcHdzeHdXMkR3cnd6dmtFSS85R1RvNWVSMzh3?=
 =?utf-8?B?Nm0zdGZHT2lYcDFjUGJCUDRmNm80U05Rd05SVjQveGJzY2ppMWNsZFBBcWpP?=
 =?utf-8?B?ZFB5L3Y2Z2hTellRdWhRS0RRVnZ5RUQ4SmhaQ2J4UmJMV1JsTW9hQ3owdkJm?=
 =?utf-8?B?ODhMcDdDMFJGbEpOOEE0ZGVKL1hUeXJlUDNoTlRaM3JIY3VWY1lPSHk2d2FG?=
 =?utf-8?B?Yi8rU1hpdG5xOGVmeTZSZEJ2N0lnWk5VdExTOHBCb0tFdUQ1UHNPdnpIZitj?=
 =?utf-8?B?OURGVDN3Z0lQczUxUE56djlQQmk2R0J5QTBMbnFpTE5wa09INUdBMXFsQ3NP?=
 =?utf-8?B?SFhPN29vSy9YWFBlR0RwM2dOTy9CMEZsSGI3MnJxaUlYNTNHc05ZR1d5UVcy?=
 =?utf-8?B?dCtpV2t5T0toVHVmaGxFeTFrSkFMUUVjcUI5L0NEN25Rci9NSlVlK0tKN1Uw?=
 =?utf-8?B?My9VekRZY3drUjJOWm9WOVFLZGlYY01hQ1FXN0JJS25qOWJQd0hSUWZHSUxP?=
 =?utf-8?B?eFhIdjFrcndhK1M0KzZTRk5oU0ozYXI5SU1xWHZlVTgzYkVTYU1LaVNOUi93?=
 =?utf-8?B?dWNvT0ZYS3RiSk9TdXA0VXNqcGVDTkNSU1FWM1BKNG1BRXU3Q1NSVU8wSE1W?=
 =?utf-8?B?NEZpUkdiSGNRQXVWV0FiTFEwOTRyL2J1Y3FJSDVxTmd0dmRlYnpOVEZaeGFj?=
 =?utf-8?B?by9TeDF4OURWZW1TTThNZFhmZTAzdHhJOEw2OTFyb1pKMnp3VTU4dWhpUGdZ?=
 =?utf-8?B?c21kaGh3VUNwNDZNaFVzYzVGeFR0bVNldnl0c21MZXBldXRUZmwwbm1zaGpR?=
 =?utf-8?B?WXFZck0wUXF0ckdhTWQyRGFZZ1lQdklFS2RiMUozaEh6RlpEVENpcC9sMVhx?=
 =?utf-8?B?ODVnVzU2OVhHOXAvOWZQNFdlYUtPSWtPUWoyaFFXNHR3aVI4Rkg0UDhNdEl5?=
 =?utf-8?B?TTl3am9UQjdqY0JZV2xTRGU5STdETnZyOXFLdi9acldIMjhlYmw4bzNjTEFY?=
 =?utf-8?B?R241Zi8wKzYzVk50RGZqelZreituTHlYRWcvdGc3WWU5K0pjQ1FybFJpOVBx?=
 =?utf-8?B?TFRiLzBGdkFjZmhPb09FVG8xcnMxQ2RQaFREWEJqUUg3Z3BvTzhwR0Z4OU55?=
 =?utf-8?B?NG1Qc0FxdStiaEl5cUNQN05Nem40VkYya3NoVmJlYk1CYmpYcFdZb2w2VG55?=
 =?utf-8?B?SENaTVkvQ3diN1AwNVlyTUx2UWZKN08zRUR2QnZsSGR3VjV1Y1g1clFaL0pk?=
 =?utf-8?B?U2I0TWxMVXF6eWVzNEgrRVVuUnU4aHRLYXgvOVJvYjZ2ZzJqTXhnZ3lDZVVi?=
 =?utf-8?B?SHhndFR3aWRKS3FBMEdmQ1ZhRDFFVy9OSTA4Z0V6ZHJleWNCQVl3VXdTeXQ4?=
 =?utf-8?B?OVF3SGNnUUNnSUJzVTByd09ubXd6U3VVMmJGQTduR0xBTFdTcnJnNTYvUEFF?=
 =?utf-8?Q?1v+196b7jQwSiKb8=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7de24072-92ae-4e27-8fc8-08de6892b2c7
X-MS-Exchange-CrossTenant-AuthSource: VI0PR06MB10639.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2026 10:54:00.8641
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aKRx7xqalR4od2Q1T2eh6RQ5CdKNag2lxwfcDr+WxqKZNoBd/kYi1tiBAmWEKp49BO4yK9c8PSinubueeC6uwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR06MB10173

Backends support the buffer/enable capabilities so advertise it
while registering in case a frontend makes checks for it.

Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Reviewed-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Tomas Melin <tomas.melin@vaisala.com>
---
 drivers/iio/dac/adi-axi-dac.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/dac/adi-axi-dac.c b/drivers/iio/dac/adi-axi-dac.c
index 0d525272a8a8..b02498aed43e 100644
--- a/drivers/iio/dac/adi-axi-dac.c
+++ b/drivers/iio/dac/adi-axi-dac.c
@@ -869,11 +869,13 @@ static const struct iio_backend_ops axi_ad3552r_ops = {
 static const struct iio_backend_info axi_dac_generic = {
 	.name = "axi-dac",
 	.ops = &axi_dac_generic_ops,
+	.caps = IIO_BACKEND_CAP_BUFFER | IIO_BACKEND_CAP_ENABLE,
 };
 
 static const struct iio_backend_info axi_ad3552r = {
 	.name = "axi-ad3552r",
 	.ops = &axi_ad3552r_ops,
+	.caps = IIO_BACKEND_CAP_BUFFER | IIO_BACKEND_CAP_ENABLE,
 };
 
 static const struct regmap_config axi_dac_regmap_config = {

-- 
2.47.3

