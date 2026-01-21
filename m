Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11021081.outbound.protection.outlook.com [52.101.70.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9276433D507;
	Wed, 21 Jan 2026 12:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768997340; cv=fail; b=eXOhlpKBZnc/ZX5NL2kiFDk+js8AoGUNPnSjPPwDw8ctGUD5LPt9XChQLpDH+Ylu/BLE9phlQBwJmfowb1t1i/piJIO9D3rFeZNpIMM6VAQxGmsv9thnAiVlFjBnuBsH6vvQVK2IHcNUcnB2orwxt7nPuIUA52fB5gR1xvIkwm4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768997340; c=relaxed/simple;
	bh=B11iQO5QrbQcopDCAI41rkWoppHyrapJ9bsrqd/mcVI=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=YOfKHm+MzS51fx/rR26FAzkU4c++BlRJz5FwQYOPwNc2hRSyzG9TWmScPoAJR/sxxkE66Rk0h+RL/2R5IHCUuqd5sS7ConKZbUXgFcW7scntq8RsKmbpoY8Hi/5eJG+xpnSqKW+mWKzi1CmxhF+Kg4cx9cT+3jYzzvVP0ELZ20o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com; spf=pass smtp.mailfrom=vaisala.com; dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b=OQgl6BuJ; arc=fail smtp.client-ip=52.101.70.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="OQgl6BuJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hrtaicyKM0RmKBZaqYuj2s5k/LNXjolk79rubbYwyt48radsOMRT7i1J9ABqhSAj5CeHEVEFj+SESSYYYuOPrbi1CN6DrBcIWTcNj1UUcPk0jjy2BNY5+7AwGNU457BKZ3PPVMNNwkfugdu4qpAH0af2gWYp6Gz298PU055LoQuVd+Vrk1tu4lvgy172ggCIF/GCYu/MHwzhVi8GV61yu1a9qf+USvE8D2/i7IWAqRnL1ZNFcXd2LI3uPRUsLalHyTseXXHO/LP72l+FAzsJ9efWTTp09fJuKeb1L4NK2Nx6QS/QC8QVfEfHbWNbxervrtIn93wBfz/XclqBDMgQcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IHJ0j1Q1Dr6wpOEUg9MRoBA4a17HNDEeTd8cnfJxJXs=;
 b=ErfC2NwLfXGdFEgJ09GybDMNMxPxxgB8pr5iY0iqXsNcRupv0phR0nzbsMPpePF7c8rekWaoKINcp4D+AZ8AQ0eVN7cDcx1aL/5Xdj2RT3DJ9FMuFN9YlOQ88Nd99/NjlpZDEzo3mGM9GAF42q9mnWmfw7g1ZtXBU1VedPuvRKQ/Qa/1y5ayqU2Jyy7Ih6ipJPuJb4bKQXIR/jGKfn4sSm+/8mrX7Jiw7y1izLE7UifJy8SL5zfZ6rGVL0NRkIFOq5B3eZijH96B+zvG6tam4jbITMOFqwurXq6cKvNAgog9GXv+8Q8R42XZEB1bMUDhZlp5WEX97zMVzxPKj3JEXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IHJ0j1Q1Dr6wpOEUg9MRoBA4a17HNDEeTd8cnfJxJXs=;
 b=OQgl6BuJ0fMOovQ9a/zW89nSoyc8JPb1GjIz2B54aSTe+3ASu0zEAL1iswMN3kAcwcE0MusxdUiH0iI5PxacEl74NY2fD5HviDP6dUoxu0xIgvsa7nInlUCV/cvL1hqVNv5LDu6YahUMp9jkBvC/PQbb28knq/EeOuEsOFkDVbTp2XR6vRrzDQkHcshNG2VPjRN0+fNYqq4xCht9oaUADKhHBqkem4ZwjrSwylWkrayx5M0Rp94J5e6xfrg1VUkVpFxJOivgZbk4n3WBIZnnR/24oAIZGbXihYPpwu0oA3Qj4Z1MkbvSLT6qmkh/fU2n3IUZR1RfDxihP31hFIYJnQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from AMBPR06MB10365.eurprd06.prod.outlook.com (2603:10a6:20b:6f0::7)
 by GV1PR06MB9495.eurprd06.prod.outlook.com (2603:10a6:150:1a6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 12:08:50 +0000
Received: from AMBPR06MB10365.eurprd06.prod.outlook.com
 ([fe80::4606:8e25:96e6:bede]) by AMBPR06MB10365.eurprd06.prod.outlook.com
 ([fe80::4606:8e25:96e6:bede%5]) with mapi id 15.20.9542.008; Wed, 21 Jan 2026
 12:08:50 +0000
From: Tomas Melin <tomas.melin@vaisala.com>
Date: Wed, 21 Jan 2026 12:08:30 +0000
Subject: [PATCH v4 1/4] iio: industrialio-backend: support backend
 capabilities
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260121-b4-ad9467-optional-backend-v4-1-18d2c0d450cc@vaisala.com>
References: <20260121-b4-ad9467-optional-backend-v4-0-18d2c0d450cc@vaisala.com>
In-Reply-To: <20260121-b4-ad9467-optional-backend-v4-0-18d2c0d450cc@vaisala.com>
To: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Nuno Sa <nuno.sa@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Olivier Moysan <olivier.moysan@foss.st.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Tomas Melin <tomas.melin@vaisala.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768997329; l=4342;
 i=tomas.melin@vaisala.com; s=20251125; h=from:subject:message-id;
 bh=B11iQO5QrbQcopDCAI41rkWoppHyrapJ9bsrqd/mcVI=;
 b=sbruVPrfEOEcfAlWpgx67WHrYGP68mu405b/6Nm4EInj+ARdGCG75tS3WCkJPirn1oMTY9iny
 1oASQuxwRn7Cqwgftue1C3MGROzoR1R+X0CMzUT6c5oM+hxog6ponyd
X-Developer-Key: i=tomas.melin@vaisala.com; a=ed25519;
 pk=6lMiecjZ+OeyZuxYsDm/ADy9D1JKvYrKdsYv58PMepU=
X-ClientProxiedBy: GV3PEPF00002E69.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::37) To AMBPR06MB10365.eurprd06.prod.outlook.com
 (2603:10a6:20b:6f0::7)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMBPR06MB10365:EE_|GV1PR06MB9495:EE_
X-MS-Office365-Filtering-Correlation-Id: e563480e-eb89-4356-831a-08de58e5d6af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QTNybUJpNHZYc0NOMk1HVjBJYWVqU0REeEtjQ3VyZ24xYkdNMEY3aHMzTmt3?=
 =?utf-8?B?Mzk3SEZXQnpIaHc3a2pxbTRvWmtEMFc4aWc0MU1aejBUbkJZeG1tM0Z2Zk9X?=
 =?utf-8?B?TjcrbjEzRFRGTTFkeTlMVitzekZQMVVrQUQwL2MxbHRJTW5ub0JScEwrc1pD?=
 =?utf-8?B?ZHNWUXZBQ0NIUWFvQS92cUpFUmh5aDJJcXU0MGdTakVXMVJxaUR0Mmw0RmJz?=
 =?utf-8?B?S1NpV2w5V3VlTlFaVjQzbzFOR2o2RlE1TnMvOWM2UTF5ZFpWTTVjeE5qSERr?=
 =?utf-8?B?LzJjcEErVmJ0Q05jQkVmUFRCQjNOVDFPeXNVQWxFb2VkOE5pTXUxK0NML05Z?=
 =?utf-8?B?QTVMVjlTL01IZEEvbkllQ0FlZTVGck1tNHRpSnZJdXVqM3FQeEdISkE5Tm81?=
 =?utf-8?B?Q0VrdjBKUjFpdksxKzIvbVdFWGdYZE5rems3YVd6ZmhVb1Irdk41bzVtRFZu?=
 =?utf-8?B?OVBpdE1lZ0o4VkpvK0RCWVYxbk1YNm9zTmJkK3ZER1FlUjBUMWZjUEg2NDFl?=
 =?utf-8?B?MzFmampEOTNvNDlRL1p0Z2Z3SEt6RnRUOVF0SUwwelFCSnJqLzZJRlpaNEp1?=
 =?utf-8?B?MTlzRzYwcnhvYW1nLzFVK0tIdHBlYWloOTlEV1JrWW9HZnRVYzg0OTJGcnFF?=
 =?utf-8?B?K2M5VDFLMTJtWG43T21JSnBvUEhlOEd2YzVCV0NpS2dCbUJnR2RMWEM4ck1z?=
 =?utf-8?B?SDVnZUpxdHpWMjkrSTdMNUZ6enhqNDVKZDNEUHBOZ0dDZFRjZ1hjZFJ3OGJj?=
 =?utf-8?B?amowUFhwcGEwTVpIQ0NtK2dwYTNNQ0NBUjZWYTVlTzhrSm9tMDZIeGJaRkNr?=
 =?utf-8?B?Z0N6LzlhSlFhcXR3M3ViekxrL3lvQ0JyTi9FVWxqTlhVUmFkVnlQdVoraEhO?=
 =?utf-8?B?R3hwS3REejM0WGNQaExzL0NDZFNXbnQwNEtPc3Avb0RkMXRremNoYTBSMW0r?=
 =?utf-8?B?T1NFWXhrcFgzc0Vzd3Q4d2xaakwrUFRGZ1BjZlVvSXJpTjZ4Ti8rUXBiMmpj?=
 =?utf-8?B?czlKaEhUZ3ppL0kwa2FNdzliUmJ0aWdBSzlGRTRHOXgwNFF4b3hFdWJnMUtu?=
 =?utf-8?B?aTNuTlozQnBWbnFWWjNJUlF0V1pLWmZVYU5sSjh2dERFS0Y2L1FYMU0vVThP?=
 =?utf-8?B?elVhVFgzWXlsWlFGYXBXNTkrajVZSlU2MG5XWjFIVUJZdTJmSndJL1NpRHdy?=
 =?utf-8?B?Y0FvVUx6ZmtXL2VzQ0RxUkZhdytkRDZxT09nRmdhR2JwNmk2R0RYcmczUmw1?=
 =?utf-8?B?ajBLbFduSlFYN0k3WTc2WDVKSDBqVTR5L0lUdUowNmppcWpjSzl0WG5UdnBl?=
 =?utf-8?B?d2tuaGF3ZlNkUnJFdXU5blNUcHRPYVZTNVNwb0FlTVhSRUcwdndqYzVuaWNa?=
 =?utf-8?B?a2RHbGoyMEVRQlN4c1N3ZUpRdGtiUTRWOEY1R0pBKy8wQnEvdHZkVHdpOEQ2?=
 =?utf-8?B?dlNNK0NkWUM1aHlKdzlQRVN2eWtGZWJJa0NVNVRIMEhIVEJiNkdxOXBaeGw2?=
 =?utf-8?B?ZkpsbFArWXpZcU51d3lpWnJISHpVblB4RkFVeE9nczAvbXJybytLK3JHdjZo?=
 =?utf-8?B?T1dFdjBQOHg4TkdsU0RZcnQzM1FlT1RJSUJlVTlZZFBNUWFNN2lxaklMZWdo?=
 =?utf-8?B?ZXFmdFg4K011Y042aitXWXpGQmhteWZnelMwdVNpR29obmhZSXA2V0dWbzdE?=
 =?utf-8?B?bW01MSs5eGI3Vy9GdTNreDlMZjlNVVVJVC9qa091RldCZjNjdjIzOTN5Rnh1?=
 =?utf-8?B?THRURGJFL2dZRGlOL3p2c1Ywd0FWM0JlL3Q0SWZzTTdsNldQOEdnN28wVkY2?=
 =?utf-8?B?M0hzZHI0SHk2YTdzTFpPMlJydXl3OHpHUnpENWhodGUyZ2QyZXhHOUpIOGEz?=
 =?utf-8?B?Ymg2QklwL0JyVCtnN3hWTkwzK3JmQ1dyd0VLeGE4Ym8yZWJiRTVBQnh2UjBR?=
 =?utf-8?B?M080U0xaQ3RNVXNEMk4wcXJia0d0QS92ZWpKUUJucVh0UGU4YkFXYURmNlBJ?=
 =?utf-8?B?UThHWE1oT0JRQWxQN01TMU9xcGU3N3NjR2w3WS9yNmV4YjBHQkRVUVpGZG54?=
 =?utf-8?B?YlBHK2UzbUU0RisvRlpJSzk1c0k0ckZZRCtENG5oTEJ2eWI2eUwwRm12TWIr?=
 =?utf-8?B?akh5dGx0VFRQWWhlNnBaWGQzdW01aFpKckhNTmZLMG12SzZyVGtuaTZBcUFl?=
 =?utf-8?Q?UVrYWpF8Ce/17+FZSnZtrgo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMBPR06MB10365.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YUJoVXNzRDloOEdVSktqNG1Vd1Q3RTFMUWFxSHZnRWtzRVUrZWIwV2MvRHN6?=
 =?utf-8?B?S2RUUTdSd0tremt6cW1KaUJOdzgra3NTam13enp2MEtFU1B6ZzNQTGJqdDFr?=
 =?utf-8?B?NmNhSzErRVplUXZDbUppdXVEUTZGME9yZFJVSjZ4cjJicElQWmg5cGtCQ0tG?=
 =?utf-8?B?cUE0T2E4MWNEK1FQVWJ5RDZ3NGc1bzVyR1FMVk5ib2hWZWFlcmE0OGc0aTlJ?=
 =?utf-8?B?MFA4dGdjdE5mSE5NR0N5LzBEOVNHRVNLUFJscmM4clUwdHRZT1phc0E2Ymxa?=
 =?utf-8?B?STk4YTZnajFoTFh2YkdsVlZCWGlYUUc3QWpFeTUrUXkxTUtxOGJiS2QzYWsr?=
 =?utf-8?B?SXQ0REcvR1B0WjJsL0VJcE9xUlh4cS9tS2txQlhhR0QzUWovZDdlRC9XcXRE?=
 =?utf-8?B?SFRMYk9keno3RklpVHo4MkttTTNvWmVacTIycXBtRlNrT1ptM0xnMVdyRGFn?=
 =?utf-8?B?dis2VW9ISjdXb0hVdFhORmt2NHdoYm41RXpDMFg5YmMrRm0ydW5zNkZhMTBY?=
 =?utf-8?B?VHJsUnEyVmJOSkFhVVIzcVR5b2Q3dUdoREpvUGRaaXBBaDhyVlYwNktrMEhD?=
 =?utf-8?B?cEFrZEFMK0RncVNOZXVGWTZaSHRXQTJIYlJkeklzekNKZzgvTVZlVHV4N1Vq?=
 =?utf-8?B?SzlmdHdHc1BIRitEOTdrWVQrRys0WFVpdUtBbGZ4QVJ1SjZURENoM3BCUXY1?=
 =?utf-8?B?S1hmUUMycHFPYUxIYzgzVFEyZXdka3lnOWtleVZ2QWVuSFhvVmtNaVdEY21N?=
 =?utf-8?B?cEVBdnNTb2ZUNWhqUEJ3TzJ6dHBjNjFtQktrSkxqaGlVZ052Q2x4S2kyTWhW?=
 =?utf-8?B?djM5OWhWeWZOMlNSTFcxQVlPUUZZTm9iamZuVUcvVm1CcFJuamdaaHlTREpB?=
 =?utf-8?B?cVhDeExsQ1VXQVMwNHpkMHhrRlcrU2RBQ2R2RGl4VlQwNzRtM2E5K0VMMVZO?=
 =?utf-8?B?U3kwanpRZmRXUXdPdUQraDdpRUxXYUg1RjA0UHBSSjB6bEFVWWtmUEUxaWpq?=
 =?utf-8?B?WE5ONmloRk1vVkowR3lJTXlEc1E2cXU4M0EwbEU0TWNnV3VEWTdlVlF6YjVB?=
 =?utf-8?B?SGRpRmliSEtWaFd0Vkw5VVp3ZXVXRGNmb252bmkzSXh2aWhZOXR3TndyMWFW?=
 =?utf-8?B?aTIrL2Z4Uy9ZRk1sTUFlT3plZVZRa2ZMWS9XbUZZcTZ6V3Y2T2N0dzFCak9q?=
 =?utf-8?B?d0FYOThEdFAvalY0QzNaZThJQzRhR0FINWVMa3pCNzJVMWJCZzROM0dTWHVO?=
 =?utf-8?B?cHZ3Y3plVHFDcHA3cjR0RlozTncrNzhScG5sUGNoWXVTV3MxQkpBZXZRQkEy?=
 =?utf-8?B?QkMyTVZxSW1VL0xtcUNlM1NWZnY4T1U5MGQxaWM2dDg1R0s1QjJsVWNCaGJN?=
 =?utf-8?B?SDdkdXlMNTdJQmUwbTN4NW9ZVlEyNFlWWU5KbW0rdjNlTEdadFlvclJOeExt?=
 =?utf-8?B?bU9ncTFDR1Q4YTV0TTBnYUUrL01WbDYvYnR3VEE3REZ6R3N4TFFTeHhQMWJp?=
 =?utf-8?B?Wi96aHp6YjBKSGwrNk5pb0dQZkZ5RU0zc0FUeWpsRDRCclQwOGpZS0F1bHlG?=
 =?utf-8?B?cjYxQTR1K0FqcUpOZG9QNGRxbGJoT25mVllERTdPTkZiYmN2Z1JmUWNvNFRY?=
 =?utf-8?B?Mm43MlBCVE9GVzNNaGxZa3VRVzhoRkd6SEVTUEtqVXNzdU5GQ3RhTXdnVk0w?=
 =?utf-8?B?WUd1MFBnVW0vQ2hISFk1bElaMG1LK3lnMUxhY2k0UG9HNkE3bU9KWkNRQ0Nz?=
 =?utf-8?B?MUk4UFNCcEJacWQ3b1h3ZUx3ZW15bzRYS3ExdGF2K3hhbTlNZ0VQVkI3RlNJ?=
 =?utf-8?B?bUJHemd2WkpYRXVnRU0zK1o5RmpPbWorSEJzM2hjTzJxNWgyajYvTFRVY21W?=
 =?utf-8?B?UFdNd1ZTVzdnUDhMeGR1eGt5Q1RCYlZGMXAzREFnMlNOeVY0MkVEMFZFSm5p?=
 =?utf-8?B?T2pyTE41TGh3a3JYbE14RXEybG1jMXVHNFkvM1p5MFlNeXZYeE11ZEdTRXcz?=
 =?utf-8?B?YTVpcDdyQVJhOHBTVytOYkNIdXpmeE8rMnhSUWlDdElXdmtUenJFcjdwRVlY?=
 =?utf-8?B?Z1V0MkV1dDlnOTNaUi9FcW9pa0ZlT3FKWWZGYi9ZQ0RKT2w5eGdHUWNpbDdL?=
 =?utf-8?B?U25IUnJCNGpZR1hOclBIMHA1SzhOcUtDMW11cUNkN3dOWVJweis4OUJmTFR2?=
 =?utf-8?B?QjFJNnZ2NXlnLzZWQi8rYnUzOWRFTG90RTEvMUdSR3VzNXpnZmNmS25kUnVx?=
 =?utf-8?B?SVAzUDdEL3pLL3o2RHJaUjFUcm40NENTWnczT010U2toUHorMGhGQmxPVWVl?=
 =?utf-8?B?dVBzeFpON0xPZVZQeDdqellVMGFDYXk1VUVlN1EzaldydzF2bTlpYjQ0SjAr?=
 =?utf-8?Q?G/AjgP/5C12//zDk=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e563480e-eb89-4356-831a-08de58e5d6af
X-MS-Exchange-CrossTenant-AuthSource: AMBPR06MB10365.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 12:08:50.6454
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ck78AKUYOmoXK7AUbca2fYofUNdyHlEpgmI0fFHQbbPGRWCCgy5QC+oS1X9NJ7DxMEqqSJJxrtJVhAUA6tAZqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR06MB9495

Not all backends support the full set of capabilities provided by the
industrialio-backend framework. Capability bits can be used in frontends
and backends for checking for a certain feature set, or if using
related functions can be expected to fail.

Capability bits should be set by a compatible backend and provided when
registering the backend.

Signed-off-by: Tomas Melin <tomas.melin@vaisala.com>
---
 drivers/iio/industrialio-backend.c | 16 ++++++++++++++++
 include/linux/iio/backend.h        | 25 +++++++++++++++++++++++++
 2 files changed, 41 insertions(+)

diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industrialio-backend.c
index 447b694d6d5f72dc6f018b1697fdb88e555bd61e..1afd00763da9e1f07160990fe3f729cbb7295d7f 100644
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
index 7f815f3fed6ae34c65ffc579d5101020fc9bd336..ac80abb71bbca88c3f6313d8d67b9c7ace076ceb 100644
--- a/include/linux/iio/backend.h
+++ b/include/linux/iio/backend.h
@@ -84,6 +84,28 @@ enum iio_backend_filter_type {
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
+ * @IIO_BACKEND_CAP_BUFFERING: Backend supports buffering.
+ * @IIO_BACKEND_CAP_ALWAYS_ON: Backend does not need to be explicitly
+ * enabled/disabled. It is always on.
+ */
+enum iio_backend_capabilities {
+	IIO_BACKEND_CAP_CALIBRATION = BIT(0),
+	IIO_BACKEND_CAP_BUFFERING = BIT(1),
+	IIO_BACKEND_CAP_ALWAYS_ON = BIT(2),
+};
+
 /**
  * struct iio_backend_ops - operations structure for an iio_backend
  * @enable: Enable backend.
@@ -179,10 +201,12 @@ struct iio_backend_ops {
  * struct iio_backend_info - info structure for an iio_backend
  * @name: Backend name.
  * @ops: Backend operations.
+ * @caps: Backend capabilities. @see iio_backend_capabilities
  */
 struct iio_backend_info {
 	const char *name;
 	const struct iio_backend_ops *ops;
+	u32 caps;
 };
 
 int iio_backend_chan_enable(struct iio_backend *back, unsigned int chan);
@@ -235,6 +259,7 @@ int iio_backend_read_raw(struct iio_backend *back,
 			 long mask);
 int iio_backend_extend_chan_spec(struct iio_backend *back,
 				 struct iio_chan_spec *chan);
+bool iio_backend_has_caps(struct iio_backend *back, u32 caps);
 void *iio_backend_get_priv(const struct iio_backend *conv);
 struct iio_backend *devm_iio_backend_get(struct device *dev, const char *name);
 struct iio_backend *devm_iio_backend_fwnode_get(struct device *dev,

-- 
2.47.3

