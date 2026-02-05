Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11020122.outbound.protection.outlook.com [52.101.84.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB1F13A9628;
	Thu,  5 Feb 2026 12:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.122
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770294259; cv=fail; b=IhQev8y1jmaCfH9w+J32+nJwt6Bnv/LBWpCWTMJsOleAaGIoSAj+LyViOGVN8+EcuOnVVza6R/EsTtYKzh3wbqC3R4AAhaVtziP4/ZcyL/Pz7hd9iHfKp+iFGKU4enMcJu+Frde0WjBZHHhlpup3cZQm/lPVWml6ddcCUbFPTDs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770294259; c=relaxed/simple;
	bh=lkX5biPuh66n6eKNOhovBTYqTv8485t2Om9vlGUFgKY=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=m00tfiXp198Owkyfw9NvxFgtqn8FDJTR1djWwT022FfSlmrM+oCsioslOUCjJtYxCaXZYVvCx0H3aY8wOFLaG00h8/3DvLpAdRpP5LnMFYvSPIrOUCf7SY25RQ3yqw4bL/suN9QK2DICDaM3hD0vkGwme0vyd8hKszDNb6odkIU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com; spf=pass smtp.mailfrom=vaisala.com; dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b=IMJhEc22; arc=fail smtp.client-ip=52.101.84.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="IMJhEc22"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AmI3M6ku+gp2ptgq61SJLqWHUa2NaeOhfTXeRBRlJoM6gquvRRfIOTAd5F9P80xeVojBeDq0qMZuATmoGGRfBDRhCGApOeP2rwrseI8bmsruuki/xGdzHK2hc6eJEBGl35fouSCX+Kdo09AfcYzs5YC90kUuTd25k8GTFTqAZTXHbd8AUuo/IiFQFzsqvh18/k0nno4BabcXM5vDZxLgCJuMu9PAdtP/+ZD27rn8J3+lgfkhxz5q8d+DvWD/L2FS41eN8eZpww3whQ3N/iI/5BRri2ylyJHxaBZomrsZW+1E5Gc4GNQNRCeB+QwksI/Oh3yL2Yy2sKvvhquqjt8W6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dPc4KkgLOF3mSkwOAGBZpMAjStGhVVhR5cn8EmT1wlA=;
 b=PK0Sf97/78wDdho+w6kVeLXMG5YuLUaOp7SeXcIwhAjuvdaVwzkJJjm9y1JyLlZVsq3DsFBkGW5CxzjQIYlrFj3jtsZJWNfjDqGQbqy02H24VNBDt3P+LI6hqsulQNVUjhhTcINKPvRpkAd7sitrbDU4RcIPQIzg6W0b2YaLd6Cr3YcvwHaWku6Rz1O0fTPSnJVwPMH2HlQnM64Yw1dYvGN8sstaRGhQ6iIIH4QlWTTvz7/gPh/I6/GF3yjVubByYN7pTTpN3Mh1F63rVQrX7sOkOJrw7vBAFS0XVsSE5dqKnhwhOJBjzKEWdZN7Wx+csq+fzDbsSot1A35OuJ3aVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dPc4KkgLOF3mSkwOAGBZpMAjStGhVVhR5cn8EmT1wlA=;
 b=IMJhEc22qxxBTVt4SNwFLJ8ua8RnYFJRJZmulHJDSzZH+4FobC3269ecUZN0GJVXEiR0Htk4TlglZXA50VSs5+2sGcjKf041WNyiE85jhqjiKv5Smkph37/+23YFtV71u/U5HQXvszT1uMxjPXB8enxWNfqcn5oKAU4KzXmC1NKEEPZHmVxEOqdovf60rURAwNxS7NWlVXmxucvmi/09RK6GOC228p56bbSPVWscIrdQIVqEl7Yo368hcEQM18hbZd7O59T0zmeBbv9ad7knl+KnvaAFUc8FojUgqX+1SQffg2eKJhC7/qvw4doZsFqaOYlxHcsqrpY6TvH7+QkBhQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from AMBPR06MB10365.eurprd06.prod.outlook.com (2603:10a6:20b:6f0::7)
 by VI0PR06MB9745.eurprd06.prod.outlook.com (2603:10a6:800:213::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.13; Thu, 5 Feb
 2026 12:24:12 +0000
Received: from AMBPR06MB10365.eurprd06.prod.outlook.com
 ([fe80::addd:5e9b:7273:8049]) by AMBPR06MB10365.eurprd06.prod.outlook.com
 ([fe80::addd:5e9b:7273:8049%6]) with mapi id 15.20.9587.010; Thu, 5 Feb 2026
 12:24:12 +0000
From: Tomas Melin <tomas.melin@vaisala.com>
Subject: [PATCH v6 0/5] iio: adc: ad9467: Support alternative backends
Date: Thu, 05 Feb 2026 12:24:06 +0000
Message-Id: <20260205-b4-ad9467-optional-backend-v6-0-7ca20c40c59a@vaisala.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOaLhGkC/33NzWrDMAzA8VcpPs9Dkr+SnvYeYwfHVlazLilxC
 Rsl7z61UMgIBJ3+Qvx0U5WnwlUdDzc18VxqGQcJ/3JQ6RSHT9YlSysCckjodGd1zK31QY+Xqxz
 Hs+5i+uIhazI9Qtsy2xyUAJeJ+/LzwN8/pE+lXsfp9/Frxvv2yfo9dkYNujHs0Rnk3ua3OZYaz
 /E1jd/qDs/0xDwgml2MBINIgWWot7jFzBqzu5gRLFNqbBvaDAhbzK4wwl3MCoaNcJCtg5S2mFt
 hBnYxJ1jIsQHTxWDI/8eWZfkDFqueq/oBAAA=
X-Change-ID: 20251215-b4-ad9467-optional-backend-23f1099ee4d7
To: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Nuno Sa <nuno.sa@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Olivier Moysan <olivier.moysan@foss.st.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Tomas Melin <tomas.melin@vaisala.com>
X-Mailer: b4 0.15-dev-c6abb
X-Developer-Signature: v=1; a=ed25519-sha256; t=1770294251; l=3512;
 i=tomas.melin@vaisala.com; s=20251125; h=from:subject:message-id;
 bh=lkX5biPuh66n6eKNOhovBTYqTv8485t2Om9vlGUFgKY=;
 b=7OAjqNlfsYCAYJmnOLksLbybwZIQF1GFjWboK332knBNrxseq78I1QImOzc88nCYSChQYnt8W
 SyA4GE28wbfAhOtD8+QaV0M4PcZ5FW5wHfg+O8/79XX199AsfIZpv61
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
X-MS-Office365-Filtering-Correlation-Id: 8dd2bae0-4f3d-4407-a26d-08de64b17863
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cVhyMWY2NjBXVXE4aG9xL3djR2JMNy95WXpqWXU0TDZvY09QeVg2aWttL25B?=
 =?utf-8?B?WHBXOXRRbzBNTFBQM0JnT0NxMUxYWUYxNXpEN1FBckV6enkzdlk0d1BrbU5K?=
 =?utf-8?B?QitzUmV0RlRHUERnclZmY2J6dHE4TVBOMXpZdjEwQ3pwR0JrUE5OaDZOckh5?=
 =?utf-8?B?Ym5OUm1paHUweDZwUUt3NmJkUjBNNTJnOHB0Mm5BaFpEeUs1NW5SNDJndnJn?=
 =?utf-8?B?N1V5RVZlWlJ6NEJkV29wZDQ4WUwwVEJORE1XaEg0L0c1cHJmWnRKSVdzV1Ju?=
 =?utf-8?B?c0c3Wkl1UHFEeS9JZm9teWEzRThPT1JCRnJjRlRwbzQ4bW0zWG9JcVlsSitM?=
 =?utf-8?B?Mnp0Y0VyOXByME95MGhDM2NEcFlIcTBzbFZLVXdsd1ZxR2tXdituTEFNOURs?=
 =?utf-8?B?aEQ5K2ZnM1BRTlY5b1Rvc21Fb0pHMGJoVVBmSU5sVThpbUxOQURSUDBpa1J1?=
 =?utf-8?B?ZXloVFpmdHA2R1IrWkVud1VBdU5IYnYrR3pkajZac2RiVDNuR3V1bkhxSW5H?=
 =?utf-8?B?YzJKeXd6YmEydnV4aWQ0QTNHcmJuM3RhMjhEckh4QUpEY21SeUVCbWRidkZl?=
 =?utf-8?B?WmpzQmJ6TjRaSDIxanJtbzlIVnhFdjhETTk1RnlpdUNOYXk1b1UwWk04SG9N?=
 =?utf-8?B?d2VoWGRVeXVzU2tUZk9lRlFyVVRoNVJCWkJVSlZRampNeWxFNndDM2dGMmFi?=
 =?utf-8?B?SUVSOGc1QStOSlJlNHVodkFueHczTkhqdWdQU1k1R1RLRTZlU0xKMGxERXNo?=
 =?utf-8?B?UTFpeUlhUXYwNnRaTmhGeHVqM0hSc0x1VTZ6WE1yUTFPWEVzYkF4V2VHeHVU?=
 =?utf-8?B?U3d6VDVIYUhaSndUR3h3dWU5L21KV2hkODB4NURFVHdBdnlWSmhRVmhaZ3dU?=
 =?utf-8?B?NjFVVHVuZkgzOGwvRmFoZld2ZU5WOWJjbVRTWUpmakZHbUhhZEVjSXVnYUNY?=
 =?utf-8?B?eHlDZGM4ckFTaThrcGNyNVQxUWJ0ek1ldUNGUEcxNjNWd1JoQkpHellZWHpn?=
 =?utf-8?B?Si9PRVZCak8yOCtZM3Q5YWF5V2hHTWl0R0czQ2hOdUlMc3M3ZkIzai9SZ1NQ?=
 =?utf-8?B?SjVyYmwxSCtSNEV5ZlFvUU93MHM3ekJWR0I5K2ZreUNuYW93K3lvVWZtUnJM?=
 =?utf-8?B?bEZjN09uMmdrRjZPcU1KTWJoTjNBYzE1aDA0QUl4ZkYrbGFubjhLNnd6c25W?=
 =?utf-8?B?ejcrcXBEb0ttMHZnMjR3SFlRT2MwQ0ZIanJtNzBsVnV1TUJiem9nZGF0ZENK?=
 =?utf-8?B?MXlZYXZOUU9ud0NSRnhsM1VOWFVaSXFieXJUMURHYlB5U09RbDhaNkE1U2F1?=
 =?utf-8?B?TDdrLzk0V05kZUFHK0l1c0VjKzVPaDRpQjYyc2gxa2UzV3pQUWE2d281N1V5?=
 =?utf-8?B?dUxqSUNGN0VmOE9ESE5wMm1EVlhIamRrWldGRTNzUnhSUXdxWGtxYUYxR1VY?=
 =?utf-8?B?UVd3dXBJMG5KU1pQcEJXMEFldHUxL1hsdHIxZ28xbFh2bjZCU2JOdHpTejkr?=
 =?utf-8?B?NXdmVDFUYUFpZkh5cXJUdVR0R3FqOXVuSytSaUxrN2tzc0lFQWZCR3VCMGpV?=
 =?utf-8?B?a2J5NThRQUQ1TmtOTGQ2VnlhUkJqZGJYMk1Ld1B1aWxlbEhhampwajk4US9B?=
 =?utf-8?B?SC92WGl6aXY0MUgxZFpsdFEyS1REcG9xWm9SZ3lsODJBV0E4QVRrNlRlYWd0?=
 =?utf-8?B?NkxEcjZqdzdrTGE3aWl0T0NrNTk4eWFKYW9XMmM2QVN5YWVzQUZCRlBmK2cz?=
 =?utf-8?B?b04wTkd0dWtOUGxldUNQMHhlemtyeXBLcHdJMDViQndnWVdFaTdWQkdzZDJ4?=
 =?utf-8?B?aWhWeDRGSHBhRk85Sks1TVVnU3gxMU0weG1IRTdKZTRHM1RLK2xZMTVKNU40?=
 =?utf-8?B?SXY3OVkxd3hVaDZyT3EwazNuMk5iakY3dEpDS0N4QUdHbXZpRi8vbzZ3WUcv?=
 =?utf-8?B?ZXZMNnF3RTdYUVJUU3ZmWmE2Y3RsWTdYVUw4aWJNUG9XM0hLZnZWTS9Lc055?=
 =?utf-8?B?Y3k4Z3NzbkY5Tng2VXdRZDBYdThwUCtKTEJWUDBmNDlkSVNoUnBVYldkcmRE?=
 =?utf-8?Q?BF0LPy?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMBPR06MB10365.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MkFER3NqNm9GT3c3YTgwY1RoWXc3ZHZLenRLYk05Q2pxYTVaTUZxdG1CbWE0?=
 =?utf-8?B?SDlHZkFqYmZIZnFwQ1pWS1FHM2d3T05xSlhybmE0aE1zZWZ5ZG1uOVlKdTYw?=
 =?utf-8?B?NHFJMDNsVlkrT2RhYmlWNkZ2K2FoR1hSUE5jdGJTMS9jRDd1Skp1aTZ6b0JK?=
 =?utf-8?B?WmpPRDJWTFVNa1R2RzltSUpEYjY5T3dXNGhkc3JUeHZrN0ErZDRTdnZMTmgw?=
 =?utf-8?B?eDNOODQxalpLcUVyNy9hbTRuSkNzdE1NY3BHWnhIeXJGT2NBR1F6RFI2UjVD?=
 =?utf-8?B?V2hJODlraTVnVGcwQ3kvNHFDM0Z5QTRpYVB4aWNWaG1wVUJUMWV0QkVycmlN?=
 =?utf-8?B?UTlyb0Q0L0xHeFdaekMwdFVVYldyT1lrL1k4aTkzWndNVWYzUnhkcVRXRGhT?=
 =?utf-8?B?MmhXOTRoOFRkVGNaSnlQaUlOYzFsWHlTOUl6NjdkdFdVK1IvN2NkeUREQmdB?=
 =?utf-8?B?OUVNM05tc3k1c0ttTHFld2k1U1JvZTBzYUJpajQ1ZkIvQjF2SHhraG96bm4y?=
 =?utf-8?B?cEt0cWIxSkcwUXhMTVhiSUtLOWtHOEI2SXVPOWFobHB1dmZKcmdhelY4R1k5?=
 =?utf-8?B?NUJENHQzd2JJNWd6R05yYktLcjdLL2xlc2RybTRmUFNCOE5IQitHbWROU3Vs?=
 =?utf-8?B?U3lKdGZKZDdLVUQrOVJ6Y2tzTXdySzlPbVFuNENSNUlvREVLVER1dXBVL0xV?=
 =?utf-8?B?MGlJREFkTTg5cVY3ZUtxMnNmTml1bFpGeklBdDEyblErVU05Q2xOMFVuY0s4?=
 =?utf-8?B?K3crTHl5dVNwcUsraHdRUUVDZmc0ZEU5RWxkTmtSZXJ2N2w3TkhqV0o2Uk5Q?=
 =?utf-8?B?QW4wYkhvelB2WUdKK2VkQ1JaTFZZNDV6VEZmWlBITnVUYTZHYkRMUGRHZjIr?=
 =?utf-8?B?VU5MbnZ3OThmUDc4UVpHQVo0OXlsUXJHR3NnNkpoZjdaalhBNEtvL2NFdG4v?=
 =?utf-8?B?YUVpbkRUazZNQjZwR25JSi9LZGJrUy9LVVNhNzVsTk1ncVV4TEpuV0ZwTTV3?=
 =?utf-8?B?bFpRSlZIS0pQNUhtSFVEMEJxTmFKMVo3VUFQa0g0NXFCcldxeVBXYVkrTGZM?=
 =?utf-8?B?OU5QV1BaL3kyU1E2a2UvdzFCR3BVZm92bHAzQlN5UFFLdXNrMDBiWUpiZXdo?=
 =?utf-8?B?SlRsUjN5RXNJZjdEQ2c1YXBRY3hNVlpiSU90SjRTSGZXREJ0ZjdGenRDY2tu?=
 =?utf-8?B?Ly90V0M2RzFuRXBoaFVWdm94R2NIYWg3TTNTdWQxY203U3BBMnNiMDEyRERh?=
 =?utf-8?B?eURoR0hPdHIvUkxTLzl3MHlEZ0x4VlhBai9rbnc0aysyWXN6WitDTWdDWERp?=
 =?utf-8?B?VTdFL1Q0aEI1SndpVEd3Umh4d3VWN3F2T3Y1dGNrSzBkdVNiYnVFUXJER0N3?=
 =?utf-8?B?VDVhK0NIRUx6NEZWUWdTRHNxOG5uVGt4NnprUnA1Z3I3QjVQbHlwanVCT1RM?=
 =?utf-8?B?YXFkbWxQSGVKa0lhSWxqeU9Tak55My80SmpjeUxOWmsxZzVlOVArTXlvdkVN?=
 =?utf-8?B?REg2TUU2NUV5bnZYaFBvNlNxZzlSM0IrKy91Rm4zUFllbkxiQUhPay9XNUxF?=
 =?utf-8?B?L1p4aVJ2RWdoakRGeHRUY0RQSCt6U2orU1R2bW9OalZaTDZuajQyM1JNSnNL?=
 =?utf-8?B?ZWtRZy9HKzhKVE1GdHNpTzdhbUovSmNhVTNPVnQ1MEFCcTJtbUIwTlFyUmsw?=
 =?utf-8?B?SnZzOFN1ckpNU0dsTnQ1cEFwYjhoMDhGNGkrekpwRkE3MFN4SDdVVFdSODZG?=
 =?utf-8?B?WHduVnR6YzZ5amRiRm1qNnFTdG5iSXp3T050ZUtuM0NScWRzZkc1U0pNNWRh?=
 =?utf-8?B?TFBFL2dFdkFReWhTM1FaV0tKdFo5UFc3QWJodmFITGxPVTF4bDAxNlgwN2FV?=
 =?utf-8?B?YnFoalZCOWN5K0F0bXUzcFJEZzJyVmRRUlVqRE1ya0RNNFVOSTZWMWJWeTBq?=
 =?utf-8?B?LyttUk1qL1Q2YXN1ZGtjUGU1SUVoRWNDUldKZHBLcnVML0o2VkJTR3BYdk41?=
 =?utf-8?B?UTJBL0hHMHpMeFJUV2pqbGI3L1ljK0ovalhkeEpWYVJKb0VpYjArRzIwTHd1?=
 =?utf-8?B?U09sQ3AyNUNFUlVuK0haai9XSzd2bEplUEx3QlgyYk1KeUpMUTNaKzF6bUVD?=
 =?utf-8?B?ZE1GQlN5RE5PU2ZOVHBodk80M0kxZVF1NE5KajNUV1lqY0lnVE9XR0ZvL05N?=
 =?utf-8?B?NkhibU5vU0FPaDJiUDBHNmdkUm5Xc0o5Ty9CT1VLMTJ1bFRUa1UwM2lTamhr?=
 =?utf-8?B?c0ozWHVyVGxNZXptTTBrL3A5cHROOUo0N3NaUUttRjNDYm93T2pXaE5aL1d6?=
 =?utf-8?B?NEgvUEhjYUxMakJwdkZ1cU1vYW01TjJYbEVwMEU3UGFCQ1FDeEZZRlY1YzIx?=
 =?utf-8?Q?XUur8VXy3pRizzCI=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dd2bae0-4f3d-4407-a26d-08de64b17863
X-MS-Exchange-CrossTenant-AuthSource: AMBPR06MB10365.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 12:24:12.5846
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tWVp4eoWEjYNY4Fd3XUVazxY07F4jDIwOwXld+6L75Jl7pG1YtVEonTcsnC9gBigO6rW/Am0usI+jP86eFz4rQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR06MB9745

To facilitate backends with different set of features, add support
for defining capabilities provided by the backend. These capabilities
typically extend beyond a single operation and are therefore not
directly linked to if a single function call is implemented or not.
Furthermore, the capabilities determine if a certain set of operations
should be attempted, or skipped by the frontend. This way
the frontend driver can work with a minimalistic set of features and
still have the device in fully functional state.

Signed-off-by: Tomas Melin <tomas.melin@vaisala.com>
---
Changes in v6:
- Renamed CAP_ALWAYS_ON to CAP_ENABLE with inverted interpretation
- Renamed CAP_BUFFERING to CAP_BUFFER
- Added sd_adc_modulator capability commit (CAP_ENABLE)
- minor fixups in code and docs
- Link to v5: https://patch.msgid.link/20260130-b4-ad9467-optional-backend-v5-0-7da803ba7326@vaisala.com

Changes in v5:
- As per recommendation, use guard for whole block
- Typo fix in commit message and cover letter
- Link to v4: https://lore.kernel.org/r/20260121-b4-ad9467-optional-backend-v4-0-18d2c0d450cc@vaisala.com

Changes in v4:
- Readd CAP_BUFFERING and also add CAP_ALWAYS_ON to support backends
  that do not need explicit enable/disable
- Don't mix checks for eopnotsupp and caps. Prefer capability checking
  also for caps that map to single operation
- Move capability checking to top of call stack
- Revise iio_backend_has_caps to use bool signature and fixup semantics
- Amend documentation texts
- Add capability checks for axi-dac
- Drop two's complement patch from this series, already applied
- Link to v3: https://lore.kernel.org/r/20260114-b4-ad9467-optional-backend-v3-0-d2c84979d010@vaisala.com

Changes in v3:
- Reduce set of capabilities to only include calibration. The other
  ones propsed in V2 can be seen as subset of calibration, or single
  operation failing with opnotsupported
- Rename backends checking function
- Relocate caps field inside backend struct (pahole)
- Add kernel-docs
- Add capabilites for exisiting backend variants
- Link to v2: https://lore.kernel.org/r/20260113-b4-ad9467-optional-backend-v2-0-0a27e7e72f41@vaisala.com

Changes in v2:
- Added industrialio-backend capabilities feature
- Removed acceptance for fully optional backend, instead require atleast
  minimalistic backend to exist
- Switched to FIELD_MODIFY()
- Fixed kernel test robot reported failure for missing bitfield.h
- Link to v1: https://lore.kernel.org/r/20251216-b4-ad9467-optional-backend-v1-0-83e61531ef4d@vaisala.com

---
Tomas Melin (5):
      iio: industrialio-backend: support backend capabilities
      iio: adc: adi-axi-adc: define supported iio-backend capabilities
      iio: dac: adi-axi-dac: define supported iio-backend capabilities
      iio: adc: sd_adc_modulator: define supported iio-backend capabilities
      iio: adc: ad9467: check for backend capabilities

 drivers/iio/adc/ad9467.c           | 67 +++++++++++++++++++++++---------------
 drivers/iio/adc/adi-axi-adc.c      |  5 +++
 drivers/iio/adc/sd_adc_modulator.c |  1 +
 drivers/iio/dac/adi-axi-dac.c      |  2 ++
 drivers/iio/industrialio-backend.c | 16 +++++++++
 include/linux/iio/backend.h        | 24 ++++++++++++++
 6 files changed, 89 insertions(+), 26 deletions(-)
---
base-commit: a7b10f0963c651a6406d958a5f64b9c5594f84da
change-id: 20251215-b4-ad9467-optional-backend-23f1099ee4d7

Best regards,
--  
Tomas Melin <tomas.melin@vaisala.com>

