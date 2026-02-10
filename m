Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11020076.outbound.protection.outlook.com [52.101.69.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA713612C8;
	Tue, 10 Feb 2026 10:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770720857; cv=fail; b=r+KQBPvJ8cYF/XSRqTaesr/+oeSQujWHP+6aXqqaaUntu6XaimjfgKLYFmLpi6mKtuq9/xCwUX2Pf0OlcrqGpj4GABgApaEYMcxcUlDTCHybr8gdwf7bnGEwH5G1y1571BKb888TWrW93o4qBsL8mURGu3AyL6lPeVkOXkWRDTo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770720857; c=relaxed/simple;
	bh=LxCp+hmh8SFHaMRUBqBRWThy3osSnTiJdMgIyywyHsY=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=pW1+36b0rSretGeQzQsv2xIACFJr3aukHx7WMer9VuElsTGxWxqY0HTNP7Lu5d+FGhngqnpgSiCz7wnmcGklqyInL0g9PGCMZWkshy2vmQKwRNiey2adv2r21zlNQN9sq7CtHRDPwK87AZ3hkGw0GymSdOeaG2wI2BtysoUBXSk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com; spf=pass smtp.mailfrom=vaisala.com; dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b=ZDrZMTbN; arc=fail smtp.client-ip=52.101.69.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="ZDrZMTbN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wm9+e4m5wgLVwLonEKBpxBCyux+bC6tg1k0OW2y8+giS9+yoWXKAqDsB15VIB7RrzymDP7CWZV3JA/nlZY5yxCe2xJ5PHY4ilgR9t25SLkguJ5frkbRnoDP38EjI6vmE842L8Y/gV6gTbuK7Oh9kMaW6sqBRqFtSbyTW5k5/MMOCVOwX8MQU7nsa9gDG2vaphlkmkva5rSR+Q1lHeIky5KmPv5Vakb3RkRCxSe2TjjnB6DfqyXdx5sKxXPCjEgUveTJOkHr9CHW8KXFRbd+LPYYKEVXN3cXNKWv+MeMwhTrR7gUmnqSXQ1jG/FGwclS/oK3AeQfnF/Ne+S0zDlOcVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q8uqGjHUtb5310Ij6zWWTBPB2MFTZoOZ4JD8GBsWmJs=;
 b=ctrvjSFAdtrY4qOmJSQHsFzmOvTfJaIkrk9wMuDzVt4XJmClWe1cOKImw6x9qDg79JajH/FUpRaMqE2xfcggKa4K7jLQdPtoc8K911AFkgK1DYBbZm63xAW+zQpFowXHsVI2SLJD/6wxve1gYNHMR7dFc/ydcuWEfVoIARzvxHC9/YX/ytqCtVKpcnYQay48DU4ATAD5z7D80BeA5NdYVaBVokKiGxgMLBwIP5cX2uehG+J6EpPbbzJ+zh3o39KVyAwbRluyLU887aPzybv+mvTzEa49DxNX4IPyXY6bl/367lspyiWlEwHWUjJPRg7jWa2lKKyTH6AP9GQFcl9lOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q8uqGjHUtb5310Ij6zWWTBPB2MFTZoOZ4JD8GBsWmJs=;
 b=ZDrZMTbNtEnvnvw+dHlCagSiUV3Vc01u6o4Aj3beDeB+2liEU31mOA6xwmEmLbXmKCRWwf2MoDaDtwnkUnkPkR9tMGCiphkPqpTCMO4gYD9tjtrmsm/5QDZ/rRKOxZDLk/7AmRidwC5LXDp7ayO6WIXY1g8e/P6mPAm35ydufWxi/Nix7GNrYMSenScsV+BkTSSFlCnEMOk9G10LqM32C2VvKWs/jd583S3p8n+vLMCqvhhF0v7EeKcBSZ2QiLzhdGJUhi9DEfpdPiC8ATLqbDraqkwx3/86CZWdark1dFFj6RObP/6Lr7y+vk/jVthmXOvUnigoXNNY/0GwCpARbQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from VI0PR06MB10639.eurprd06.prod.outlook.com
 (2603:10a6:800:2f4::10) by DU4PR06MB10173.eurprd06.prod.outlook.com
 (2603:10a6:10:621::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.13; Tue, 10 Feb
 2026 10:54:02 +0000
Received: from VI0PR06MB10639.eurprd06.prod.outlook.com
 ([fe80::3a41:90d:2091:bfee]) by VI0PR06MB10639.eurprd06.prod.outlook.com
 ([fe80::3a41:90d:2091:bfee%7]) with mapi id 15.20.9587.017; Tue, 10 Feb 2026
 10:54:02 +0000
From: Tomas Melin <tomas.melin@vaisala.com>
Date: Tue, 10 Feb 2026 10:53:38 +0000
Subject: [PATCH v7 5/6] iio: adc: ad9467: simplify device pointer in probe
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260210-b4-ad9467-optional-backend-v7-5-7a590ffe02df@vaisala.com>
References: <20260210-b4-ad9467-optional-backend-v7-0-7a590ffe02df@vaisala.com>
In-Reply-To: <20260210-b4-ad9467-optional-backend-v7-0-7a590ffe02df@vaisala.com>
To: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Nuno Sa <nuno.sa@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Olivier Moysan <olivier.moysan@foss.st.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Tomas Melin <tomas.melin@vaisala.com>, 
 Andy Shevchenko <andriy.shevchenko@intel.com>
X-Mailer: b4 0.15-dev-c6abb
X-Developer-Signature: v=1; a=ed25519-sha256; t=1770720837; l=2594;
 i=tomas.melin@vaisala.com; s=20251125; h=from:subject:message-id;
 bh=LxCp+hmh8SFHaMRUBqBRWThy3osSnTiJdMgIyywyHsY=;
 b=6duVeCjnbdJn1TrVD2zxjZcoqGAPe99tG2JEh+u7/Mt+HtvAEwAk2OZ2F9GmRdzG748S5CqFZ
 lhRm5ZQfc7WCPOBvWzY/jmsDZdaGDmhf0i/As+tJMiT4kJSD4W/Tu0W
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
X-MS-Office365-Filtering-Correlation-Id: 05162038-7474-4993-5cec-08de6892b3c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TnNZU0IzbEtaMzNjUCtObWluZ3R1aHNwTzhoMUR1enlBcmJkWUFnZVV1bmRQ?=
 =?utf-8?B?ZHo2TFlLbm5DSzhmVXM1NzI3ZWhQWlUrMXBoQWViby93OWorTXhQZGFkUGZl?=
 =?utf-8?B?MXR2OHhjNGRQdVdlK1gvZWpndXlleFJyUVZnMkpraHQ2NFhLRzhCTGNsWXJD?=
 =?utf-8?B?cHdqWTVWaDliV0E1QTk5L0lRUit1VjIrT0hmQm8vcDZha2dtTGQ4M1BPdjcz?=
 =?utf-8?B?WFozWHNxbGdrQSt6L3lhTUVVT3B0V3dMWUdNU21yeGFHaXZob1N5cElRTlVI?=
 =?utf-8?B?QXpyREFleE42Y2ZkQzJUQUNqZFpPamZIUnBsWHl4UXhRbi9LSjFCU2ladjZu?=
 =?utf-8?B?UXFmYlFXQ2dxNklSUUs4TWdKNW9KdG1SbTl3WHNoTVFYNnF2TjlpamxQODFD?=
 =?utf-8?B?TXViKytTLzZQVThtRUk2c0w4V0p5Y1o0ZzJFQiswZHMySmJiM2QrSXN0Z01E?=
 =?utf-8?B?QW05TkVCU0k2bERlT0dLUFZ2V1BnSGZVQVpLd0VvQ3lNYVFhV1ZEdlpsZHB5?=
 =?utf-8?B?Y2s2T21zSzB0ZjVzVmpDTEl3VWk5UGg0MlpvTUV4cWJmUllxT1pzK0ZEWkV6?=
 =?utf-8?B?dlF5eWlrZ05nK0RDbzZ1bDYvYWwyV1k0SzRKS2lJV0djQVZxRDBwTDFIaWVX?=
 =?utf-8?B?Z0VURVM5ZS9kSldoQUdtRmZxcHVBcjZGTFZCZjFKZnVPWkk1ai81SnZReldm?=
 =?utf-8?B?QVBXUWIwNVR6bVpKNitKNEo5bkpCMlRqL09IZk1ObXdsRHlJcG1NQUVjWFZs?=
 =?utf-8?B?Y3BNZ0ptN2NOYThyRmppTzFvL0FkZzBGL0hKbVJRMVkyblIrYm91STBBUFI5?=
 =?utf-8?B?NVhGTkRSQnVmczdhRnEzZkpUSE9uVnZVaFBKN3lsVnFaenhoTW15TVgyM01B?=
 =?utf-8?B?Z2lzbzVQWlJ3bFFLVXUyWnJjeGtPK3VralA4a3VBcG1KUU1aVWVqbUk1dzNu?=
 =?utf-8?B?NDNEMXZueS9POHRHcjdRb0JlZGxvYUloUkpJSVRhSit3QkNNYU5aZlFEMDdU?=
 =?utf-8?B?RzQ3aFJmTFlIZ08rRkEzd3BIei9wVFBlNWJkNnZyVURPQWxsYTBRbXJ5dEV2?=
 =?utf-8?B?Z2ttL3NONHBKUVZGdnhabkhFdFRtUmxWSXZvVDd4KzA0Z1N5WThTV1FVYnh5?=
 =?utf-8?B?U3BOZDZtUGc2Q0Ewd3hlMFdNZVhWVTNDNWJ1SXkwZWhybExXcFZyeFNZRERO?=
 =?utf-8?B?cjNwejRoeUV0SjZIT09EeTNaQnRZSVNSQ1lGWmx5YVBIY3NJMHZuQUptYnJO?=
 =?utf-8?B?RzE3eHpscnFNcE5FQUVyV0txTzUrWmFxRm9acmk5bFk1UHcreVRnMTg1STFR?=
 =?utf-8?B?dVE4Nk1YNWNOS25Ibi84MC9KazViODNienNibkhtSy8zSWtVa2NTTThDT2ZU?=
 =?utf-8?B?bGJBcjd6aHNqTnhFejRJZXoxVTczQnNUWkFkWldMcjBDSjByaXlkK2ZmZW5u?=
 =?utf-8?B?TEpvQm5tSUFITXArU2dpV0ZNSy9PalBYS2pOd1oyRlBpSDY5RXptYUpSY3VT?=
 =?utf-8?B?QVl0cUNCR1o2NHJwNUtheVpxQzkzeUlKWUd4UzRaY0xsWmtzcVErRk90Nkt3?=
 =?utf-8?B?RHdJOGxpRDlsY2gvZnc1TFR0V3hINHFmSmxrbDdVM3NXOGozNnN2Tml2V3l4?=
 =?utf-8?B?UVQ3RzZjYkdDOTAzWVVEeWs4cThqdUJmQzc5THdMK2hZeGpqTG56SFpkUHJM?=
 =?utf-8?B?MUlFbHVST2hxS3FVcFgwSWVRQTBnTHF3a1ZzMUZndmtNV2NEZU1rNWNSNzl6?=
 =?utf-8?B?Ulp2d1RGemc2T2JKdm5xdWJZSDIybXZtbk0xRi85cVR6amg0YXR6Q1JkZXo5?=
 =?utf-8?B?QXllclRVc3V3b05aUHBGdHRyZkcwVzByOXhMK2JNSldlMktFZWhCeVEvQjgy?=
 =?utf-8?B?M21ZWjlPK1N4RG5Zb2VjY1I2MVFsUDhRV0NnRitaK3VudGFKeUdkVlgxLzlH?=
 =?utf-8?B?dDcwYTdGYTE1MjRYUTVMVTFYSGxXTXEzSXJOT1B5NGxvNlk1aGl4dFNJaEp5?=
 =?utf-8?B?TFhlaTh1YUpxdjdBd2RBY2hyU3ZuZTY5aEZpbVBjaWpIRTdGdmZENjl3b1Vm?=
 =?utf-8?B?bWFucGlaeWtkZEdDYzhoNHZkeWphVTBqM0tkejNMaDhaNllPVmNmSStYSlhu?=
 =?utf-8?Q?Lk4c=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR06MB10639.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bGxURjFDT0w0WXM3dER6aW0zWTFzc29Md3VWYjJOdkNTa1VCWFhMakRBUytX?=
 =?utf-8?B?dno0cUlvZ3hkUzRYSDJhZlJkSnJGRFRaVlZXUUNRbDlzMmpCMWRVNVRqLzUr?=
 =?utf-8?B?dTEvb1VkY0x1dmEybHN5U1MzajNVZTNodjNzY1V0eFc1c09iQWY1RFdOT1NF?=
 =?utf-8?B?QnlHcGlzcjkzTlQ5N1FQTDJYVERsTFJpSWtZNnNnazFGOEdOQU0vRExWeDRL?=
 =?utf-8?B?Y3pRQ3p5WXVGa0ZJdWZPM2lwRnVHY1Jod25KaDJzWlE0N3N6VGlaWVh3VU5V?=
 =?utf-8?B?aUdEemdBQUJnV1E1RXAwWU0zeHc5NVRUcDRnNG1PUUhvZ0Qyc3VKVmNubENm?=
 =?utf-8?B?aEJoaU5DVVcxUFo3cE5NdXFzc3NoR0ErQkY2bUVIOW1zalNGVVRKQnByOGhG?=
 =?utf-8?B?RW1CSk9aMXYzSW9uaXUyaE9KR1Bjc3JlcnExSXBpY3JCWlRkTGc5cDFkYTRs?=
 =?utf-8?B?V2dXKzY2eXM5UmI2VHcrd1pwUDkzWWtDc21SU1RLSnFXeTMrUGVTUG5VV2JO?=
 =?utf-8?B?cGhmUlJETmNhK3BxSmNqVnllVUVtUjc2VTNUNVJNTC85TVVPWGJaTi84cnNI?=
 =?utf-8?B?ZlF4ajZVUm5FR0VYZXorL005TzBUeHNSOU5XWHEySTNSN3VycW5sYW93bGlL?=
 =?utf-8?B?d3Yvb0hmQXkyd1E5MHZDYU02SEpOTnZNNllpZHJaWlFKaGRVa2cxWngzMzI2?=
 =?utf-8?B?dW1kWG5HcXVHU2xQUXNBeThIUFlVYnh4Q25iTTNQVThpckxzYlJFZEh3VWFi?=
 =?utf-8?B?akF1Z3pVKzUzQWF0Y1dzUkp1ZS9HUjZZNDhCTHk2b1pYYnFnUitZZkZIZktQ?=
 =?utf-8?B?LzZ2bTE3a3l6SnVZV0pvZ3NKSGszNHN0OWsvaURNamtBNFJiUVNqTTVIVEN2?=
 =?utf-8?B?QkF0QzNqYU90eUZubFYwdHJuNGltbC9ML0YzaTh1NS9RVUswaUN0MU9LUzFQ?=
 =?utf-8?B?V2Z3MnA2bngzWU5rN0RtcE9MTGd5K1FkSHlFMk91NnBjaEZNVC94YkZLQTd5?=
 =?utf-8?B?M1FpN2M1MXZZcUVEKzhqY1IrQ3FqaHdLZmhPVlFoSXN4YThKb01NcE5LMHNh?=
 =?utf-8?B?M05rejNjWnpUZEMxd0s3R1VDYTY3d3JsY3MxTXBFclpjbHRFZlVSbnJwYnVV?=
 =?utf-8?B?Z04vMWtQNmNIT3BmMllUYzFVNFBQajlzOEw1SlJRYXBScEgrVG1wOW0rYkFD?=
 =?utf-8?B?Y2VEVGVVNEJuNndTUi9ZUlhmRXM5RThhdGwzemUwbXMwTnFkUHA4ZVdQRmoz?=
 =?utf-8?B?RFRzUTdxSjNnU241eXJycUtYQTZGSWFISWw4TUt6STRGZzRFS0NkTHdHVUtM?=
 =?utf-8?B?UzV1ZmlwSUg3bk5YWHlYSE5pQURyTlhkdmZlS1o0OVpPVkpVcDBBcVhNUjhK?=
 =?utf-8?B?VVhJcGovcU5lMW0xRkxBRGEzVnRWQnhwaXgwQnIrVWFCV0ZRNWFycVlXRzE0?=
 =?utf-8?B?MEpBSEEvdmt1QkVyNHdqL05zbDc5N1UwTjJqeHJSWUdNa09EbjFiUmFlUXNI?=
 =?utf-8?B?VGxpcUNXdlRQcTlKT3VxNjkvc2Zud1NhVHdNYUg3NHBuc2hQSnhQNVlGbE1C?=
 =?utf-8?B?UE1EMERpY2dIUHZjY2J5YU9LeGkzZUZUWFlFY0FxQ3ZzMmtGRzFxMDdFUCsv?=
 =?utf-8?B?YjRxUDFiY251R0ZiSjI3MENWbFdzRGFRaXQvdS9UYzdOT1JzSHlQZWZ5MzEy?=
 =?utf-8?B?eFZpWEpUSytsVEgranJXVzBoRUg4TUZWaVg2TFhnaVFuRlBkZGZtK01RL0ZZ?=
 =?utf-8?B?cFFyY2VVeVRSU2xsSjJvdnh6WTFGUUliRllZV3J3K2xQOTh5UkFYQU85b1Vo?=
 =?utf-8?B?bENvam1XVE5ZeDhzK2NHdVIwMi9Mbi9Jd2xsYzJrb2I3ZHZqcnhZeG4xUUJQ?=
 =?utf-8?B?dTAxdXlnblp2UHhxeXNSZEFoTkJDeUpkUjlUL0ovcWlTRUk2L1lGeVZudXcx?=
 =?utf-8?B?MGIxMmVObVRiTUI5NmUwbTRiVmx2M2U1TC9UeG54WFJzSTkzb3l2Y0JDNkJi?=
 =?utf-8?B?TGJSR0cvYTJ1TmEzN3BwQ2JrcjF6VDJHMHFKUWwrS1J4RU1vVTdsN0hGeEgy?=
 =?utf-8?B?TUoyNENITlg2UGZzNmluTDhoTGFuZHUrTmhJb0tUVkpkMVBqbHJOQmFTTDFp?=
 =?utf-8?B?em5jcWFxRFIxL1l6Q25BRW9zZXBRVDFSQXNqQ0xFQk41ZlhLblNSTmhHNEty?=
 =?utf-8?B?clk4ZHdsWmhnYUdGbWhydXZGeldSSlB3RzIxb1JmU0xKY1BuY1UzcktLNkZn?=
 =?utf-8?B?TWV3VW5aanZINnMwdWFSaFFIb1ZhdzNYMVYxdkxleHRzbVluQU4zWERZb296?=
 =?utf-8?B?a0lEZlZjalU1aFp1Rk9xYzMzeFNRYUVkT3pleGI5Z2FGdG55TnJRUkJhbFh4?=
 =?utf-8?Q?OQQEj4zjbmWQazlo=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05162038-7474-4993-5cec-08de6892b3c0
X-MS-Exchange-CrossTenant-AuthSource: VI0PR06MB10639.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2026 10:54:02.4430
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DbDytZQFUzB/L7/0BUvUw7iorIa7R2J1bOkIekgESJ76mNy6MSpBKSRvG5bMfOQMljnmz/aoiPnTqPF3ekM/4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR06MB10173

Create alias for the device pointer to simplify referencing
and keeping syntax and column width shorter.

Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Tomas Melin <tomas.melin@vaisala.com>
---
 drivers/iio/adc/ad9467.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/adc/ad9467.c b/drivers/iio/adc/ad9467.c
index 59c3fa3bcc9b..ae9139290c22 100644
--- a/drivers/iio/adc/ad9467.c
+++ b/drivers/iio/adc/ad9467.c
@@ -1283,12 +1283,13 @@ static void ad9467_debugfs_init(struct iio_dev *indio_dev)
 
 static int ad9467_probe(struct spi_device *spi)
 {
+	struct device *dev = &spi->dev;
 	struct iio_dev *indio_dev;
 	struct ad9467_state *st;
 	unsigned int id;
 	int ret;
 
-	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
 	if (!indio_dev)
 		return -ENOMEM;
 
@@ -1303,16 +1304,16 @@ static int ad9467_probe(struct spi_device *spi)
 	if (AD9467_CAN_INVERT(st))
 		st->calib_map_size *= 2;
 
-	st->clk = devm_clk_get_enabled(&spi->dev, "adc-clk");
+	st->clk = devm_clk_get_enabled(dev, "adc-clk");
 	if (IS_ERR(st->clk))
 		return PTR_ERR(st->clk);
 
-	st->pwrdown_gpio = devm_gpiod_get_optional(&spi->dev, "powerdown",
+	st->pwrdown_gpio = devm_gpiod_get_optional(dev, "powerdown",
 						   GPIOD_OUT_LOW);
 	if (IS_ERR(st->pwrdown_gpio))
 		return PTR_ERR(st->pwrdown_gpio);
 
-	ret = ad9467_reset(&spi->dev);
+	ret = ad9467_reset(dev);
 	if (ret)
 		return ret;
 
@@ -1322,8 +1323,8 @@ static int ad9467_probe(struct spi_device *spi)
 
 	id = ad9467_spi_read(st, AN877_ADC_REG_CHIP_ID);
 	if (id != st->info->id) {
-		dev_err(&spi->dev, "Mismatch CHIP_ID, got 0x%X, expected 0x%X\n",
-			id, st->info->id);
+		dev_err(dev, "Mismatch CHIP_ID, got 0x%X, expected 0x%X\n", id,
+			st->info->id);
 		return -ENODEV;
 	}
 
@@ -1339,11 +1340,11 @@ static int ad9467_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
 
-	ret = devm_iio_backend_request_buffer(&spi->dev, st->back, indio_dev);
+	ret = devm_iio_backend_request_buffer(dev, st->back, indio_dev);
 	if (ret)
 		return ret;
 
-	ret = devm_iio_backend_enable(&spi->dev, st->back);
+	ret = devm_iio_backend_enable(dev, st->back);
 	if (ret)
 		return ret;
 
@@ -1351,7 +1352,7 @@ static int ad9467_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
 
-	ret = devm_iio_device_register(&spi->dev, indio_dev);
+	ret = devm_iio_device_register(dev, indio_dev);
 	if (ret)
 		return ret;
 

-- 
2.47.3

