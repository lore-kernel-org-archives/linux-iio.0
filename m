Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11021136.outbound.protection.outlook.com [52.101.65.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF30B35F8AC;
	Tue, 10 Feb 2026 10:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770720856; cv=fail; b=FhPoYtgBB89VMFrUEisOXZ+JJVdAAZqWLehTfd/3/fcsF+xI69DRj4a3zTLeXNpvo/IQKe0NsJpt+GVGeWeRtgTHamN6CXdNc04oIlTXExIj41p6yh/Q/d81VFjpS0ewsIcpe1mlxZwFkje1nGBvnBa52c7SOpw1F3OT7uMU5Rc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770720856; c=relaxed/simple;
	bh=3WFrquwOoMj9G5kKc1PIzdBYe9pQBr3LyD0YzR3mOPs=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=ICs8aR9I51xqnfpE9vOhJcDILV12y+sAxEXXu1y5iuC7NMpGYtnUYhE+LCxArat/isPCdq4gy47n95oNnGijPBoDdRQe3moKeMjAKuRQlOS762L++wmtcPuNln+0oZD0A0rw1pcxUDhLRJ4UbYPexyniGlOoQVFjPX/CHQY3Xh0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com; spf=pass smtp.mailfrom=vaisala.com; dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b=2NiK4FyQ; arc=fail smtp.client-ip=52.101.65.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="2NiK4FyQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yzf2rMFgNkE7VifN148uy3i9iSEtrp1iJ8yh7RuM0Lws+ZtNlpOhaj17gmHlwEdY+STe7bEtnbm5JrQtSNj6gevNeoPu9PMUbic80XKpr2kiXvx/jut1Wbx74Of/gQ8MQHd8A+s9FPhdrskTS9HZ23RNqUM5NdFNvu723vhaxbKelA2egiN+Dun/XtiCCVmhH8xOwLxoK1+lHN9I4oWtcUXko+I+tBvl3rr0R8AGzO3eE9OVy0Y8o0oE2pptIyvaDAQ/KhXC6r6DRJpndrezykawrpg7q8/nU14WnZt5bZAlVB8nCdKZLGY52zX3G74iMv93AxaIS3MtIGCbBcDU+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MfS/cXj/xBxkAKAKr/D+8kWXWX54BUC9EqxVk2gMNXs=;
 b=wUaVSG8K/HENCVzc4xAKKCQxjzADz0RnL1C2pR20Avk0kpEV0I2Q1Bh+E3CLVsvwN2L3CTfk3KZF3mWYEQ3gqz77ZVBeNC/q/ogUdnETPuWtNTQvlBRSvEliECsrVvGZVH0VQIYLbDnvG5YrBS6QyqZ8EMfkJ3wkfWC7haiY+QFJpBP5CG+rc/g1WvIFmWeBU8xBzub9aDCjOqF7C6kK4YLycGwp+eJW6KQB0gB6ULBBBTiE0tMvuenXVH9yyCELFiULKTl3UocEYr2InL0nMGnpxKNIUuFSjV6aQxeUjb0nBdDGIavCg26mx0a2M0Nbe/CH0rWi4LbPIy9chIv5CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MfS/cXj/xBxkAKAKr/D+8kWXWX54BUC9EqxVk2gMNXs=;
 b=2NiK4FyQdAmkzOA3acpjCd9KcH87vz18dK8bD6zt37QpYDISpUE3VZHtgG+Xmk8utIiNkhMs2LU4K1G/4UgraZXEoK4zNxHwV4eIW0/oyRTpc8FnhPYTI/43Jd+TUoqAaCMPZ/tVe4xf3YzG/zGgTnif+ALR69BGZJUReDkEOB+RM1rWzzNatFHLIMFa856Yv01jIMP+INMdqY0r0GNs1MQy0MCy3VkrIkHKZRbzVD2dpADTeErDTiPAcdoF/k5/2l2NsuYXiuT6NR7V5aGlM2nGNA2rVTSvEmZ4FO7274+ANYFMnNDk+Pf84AX3QKE5brM3+D8yw52MzrEMxvD5wg==
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
 10:54:01 +0000
From: Tomas Melin <tomas.melin@vaisala.com>
Date: Tue, 10 Feb 2026 10:53:37 +0000
Subject: [PATCH v7 4/6] iio: adc: sd_adc_modulator: define supported
 iio-backend capabilities
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260210-b4-ad9467-optional-backend-v7-4-7a590ffe02df@vaisala.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1770720837; l=810;
 i=tomas.melin@vaisala.com; s=20251125; h=from:subject:message-id;
 bh=3WFrquwOoMj9G5kKc1PIzdBYe9pQBr3LyD0YzR3mOPs=;
 b=g34c4ogRfK/ZQaXhcp6vjTRkjfzoKGCP0HyuatAn0IkSnAPj/mRpJ07lXRJkJYp0bITbRpPqj
 IBkHYJtwCz9DkmhoXSKEzv1yDRf7MAkYqI3cZX1LE3bGnU7O5YXzVzg
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
X-MS-Office365-Filtering-Correlation-Id: 2da5a9ab-e8d1-407c-6ddf-08de6892b344
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aDk2L09EQTdaUjRjbGR0TTduRUtlK2ZPUFZudnMvRm15eEFxRlNBaFVsUktE?=
 =?utf-8?B?Z3BmV2R1azZDdXFhVVFad1JzYTVpeWdsRHQ3ODgycFlaTnZhZVExMTZBT3N1?=
 =?utf-8?B?d2RBZTdxYXJiMjNub0ZBQlhZQzh4algyRXlGaDRMaEsyaVdEVTZ1eWJiUS9x?=
 =?utf-8?B?K1V3dTB3VDJrcXR0RCs5dVVqd2kzNVJuSWExazlDVDRMLzQ2d1pTakVuQXgy?=
 =?utf-8?B?bU9pMVlsNTNHQUExZFZmazZkNmJaNmxHV2ZnZ3lCYXFMNmNTVmFuZEtON09z?=
 =?utf-8?B?Z2pyeUkveis0OHFyNjJUYnl3K0I5ZlRFS3cwUlc3TjA0cjdNSk5uNmt0NExx?=
 =?utf-8?B?VklyclBVY3kxbE1BeTVnMHRDVnZVV292RWdod0R1WHZDd21INnk2emNVSzRD?=
 =?utf-8?B?em90MHVwMk5lWkxDMFgwbEVaYTdXZ2E1UlpsdVRuUzRISFREc25ueDNldkJv?=
 =?utf-8?B?VFo0a3VHU1FCNjNZTGY1bmFxOW14RUtHcjdPZ3l6bEtJakNPcVZDNm84MExM?=
 =?utf-8?B?bm45eVgvWlVKZW1HeGNSUm15eFpZaEk4Y1FKYThvQWY0a29rLzhEY2tLR0lp?=
 =?utf-8?B?T3F0SEo5dUtEd0dsZ1c2UEtDbGp2eklkcTladlBibUU2TU1FU3lHQjF2R3dV?=
 =?utf-8?B?VGljL1c1Zi9VSFBVNWRxQUd6VFpoby9jUk1XYUh3QUFZeVZBWUZaK3I4Ri9I?=
 =?utf-8?B?RmZyWFg5ekx5Z25UV1ZwQ2ZTOG85WGwrMWZkOFVVRUFjMmx5TXVwYkN6cUM3?=
 =?utf-8?B?a20rQWhYZlFqYmlXWkYwWDB0TWhoMDAxbWdnak90MGZlR2FlaEpJNFcrZmVl?=
 =?utf-8?B?RDUxSXVrK2lET2hTeGh5OGg5TlAyWXhneWFNVWs3aU4zZVN2MXAwQmc5Q0s3?=
 =?utf-8?B?aCtBVWdZdVVTVzdWSGN6bkFjdGJ5TzcrSy9tUnpqWHllakNxbE0wZWF0UnMz?=
 =?utf-8?B?dVdwMGlEWVZMQzhNN1dyd01wdUk2MXFVRjdmL3ZuQ25TS1M4djRjbTV3RVR0?=
 =?utf-8?B?UVRwTUJqQkVrZFJmN1RlcFUrUGNSbC9SaHdqaXZpTDREeXVZYXYzKzlzVTF1?=
 =?utf-8?B?ZzVIM2k5MFRNSkNtMGxmUHNUeitZR3MwSzloY3NSYmU1eHRvY2MvUE9NbFdo?=
 =?utf-8?B?bHhwK01LSlk2RUNpY1d3VnN2S3lkWS9XK2ZrUytHMERlRWlvV2lGcHh3RTlD?=
 =?utf-8?B?bE1LbFpnSXJVNEpXZG5UTHRpNlZIMTQ4cFFYaUZEY3RyQmZpVGM3UWRHK29R?=
 =?utf-8?B?dWd4c2J2bWgvblUvbXJvZFY5OHVGL0dmbFZwdmo3aStOelZnRE5XQTYybWY1?=
 =?utf-8?B?amg1cUtmMmVldGczNVhjM2NIbi8vM004a2lzb1o2bld5SFhoWkRsYlB5Z0ph?=
 =?utf-8?B?TmJuVHc4Q1VWNVlVSmdvdGE4M1RDL0NJc25HRVBiVTlMU3pJRUVNcTAwQldl?=
 =?utf-8?B?RWVSaXd5NFRyUitJL1dYNGtaUjRPNk9JT3lkNFlSd0Z6anB0T3EyeklpeTVx?=
 =?utf-8?B?TDZIcThneHdBaEdJZkRpeUFkQ2srSC83b0hDK0M3aXN5ZVIrWVdaVXg2OTZk?=
 =?utf-8?B?ekJyRmVMb0k5TUZjcWxqRkdUWFJlUWRRUkFudXJLTzc5cXYvL04yYURxS2Fl?=
 =?utf-8?B?QmNrazdCZzRxNi9ETTFGemxxSmcwakVtVzVGaGREVzA4Vk4wd1lWRGZ1WTNU?=
 =?utf-8?B?L0lLK3JUVGJuVFJnNmJMQ3hrbW9UVWtkM0hZRndxM3hVYWlacmMzUlAwc3pR?=
 =?utf-8?B?RkJib2RwRTFXdUJvZ1duWkJDdmZYUG0yMDJJUVphQVpuM0tUd1p6VlA5cXpo?=
 =?utf-8?B?Wkx3emMyUjFMRlY2dnhTT0liMERxZkxBbVViRE82MmtiMm5rYUFBTWt3dTN1?=
 =?utf-8?B?RTBJY3FhWW4reGorcFJ0ZUF0b1R3R0JSSlQ3d3U5VjFEU2pEaHRFN09jSkVj?=
 =?utf-8?B?aFZkV3JadXJtSUhjczBNUit6SVBIQVFhNmxTcTFGcy8wK2pWc1J1cTQ3SFgr?=
 =?utf-8?B?NnJZbStFYm9uTmxqbUlCajJFY1grd2pLTkY1b3FYam0zbnRHQlg2QURQVWMz?=
 =?utf-8?B?M29jdTBjTFFMbkxDVTBsdkQvYXRVU21IaExRcWVWWGZGcXYrckIwc2E0NjBu?=
 =?utf-8?Q?EjjY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR06MB10639.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S2lES2xmYUV3KzhteWVUemkxQSsvVVVNRkN6dVkwUzdSTk9mS2lqZkI1d0Vq?=
 =?utf-8?B?WVBqVDVuUUVzVGlZenFndDcxdmF6U0crR1hmK2dMV3FVRzhxWktSbDRDaGhM?=
 =?utf-8?B?UmRVMVdqQVRQbmdEU3F0aHhqSHNoS21iaDlpYUs3KzZCWi9BaU82bm12eUE3?=
 =?utf-8?B?ak9DVUxVdzROYVhNQ255TGkwZW5SeStGZkQ5Tmg2cFgrRUVpWVJVWkJBeDN0?=
 =?utf-8?B?QlRnN3IxUkIwQVZEdUpsSUJPOTJXdkNEU3EzQkc0VTlteUNiR3lVemdGK2NN?=
 =?utf-8?B?dlgzbW04K1JqaDVNR2Fwd2lJdENXdFYyOEdyZWlmVFpCN25MdC94emtLVUZv?=
 =?utf-8?B?aXp3YlUxbHRZNUd0TS9IdHFhSUR2R1pMQWhuaXFmNUNYMzNHRGRmMGNwekpQ?=
 =?utf-8?B?Z0FpYzY1NWhiUkFxeWlxU0RVZ3RCbEVWTWJKTnp3eUZsQVFmdHkwOUpmQXR1?=
 =?utf-8?B?SmJibHJRcVBtTlN0Qy9xNUR6UDZURm5NWlpQY1R3c0ZpN0JWOUovMHUrZ2hn?=
 =?utf-8?B?a1h3Y2JiNnBQcnB4V2djNG0zWVgvZ2o3U3NjdlJxclZiQkdHNzhJc1NrVDUw?=
 =?utf-8?B?c3p2SjBpdEZXSFZqWXJ2bWJiRmtQWUdRblNYT3FsMEExQzJpYW92R054a2Va?=
 =?utf-8?B?NFJ0NjNiUjMxbUxVZlE0U3ZRNTZTU3ZXZGFOZ1dDYnc0WDNFYzRyV3lsdmJ6?=
 =?utf-8?B?QXlZWGFVbG9MamlSbysrZmxZQzM3blU3NCt6MjFhaWhqYTdzUEh2dlRYd25E?=
 =?utf-8?B?WW5tNXlNeHI1elU2citBdlhmVTBtUnlNSXpSTzBWYmEvOXdSdEVpSjZ5Q3ZC?=
 =?utf-8?B?c1ptazhhZjNuY0Qxc1Q3dkloMHBLN3VBenFja2N5RkYxRnJoNjNNVDJ1UExv?=
 =?utf-8?B?NWdlZ2hmcXBNdmo0R3N6cG9uZ1ZkcXozZ3g0dE1PZzdzY1JtSzBZdGFvWTVO?=
 =?utf-8?B?MzA1dTZMYTZib3ZncXFtcUpIb0ZxbHpaZGtaSVY0ZXBncHlwRXBMa1htZHJt?=
 =?utf-8?B?ZFpZdkNMVjdZL1dtcmw5SVpkanJyaE4yejc3Z0FrVXJLUUhOUEVVNlpqV1p6?=
 =?utf-8?B?VnpCaVJYaHdMM0lQVXRXTWNKblVqNERhblQ4eE5xOHRJa2tZcDFmRGVBZXR3?=
 =?utf-8?B?T24ycUhpcm8zaFBtY1VMTXBlcW54UkJsdVBXa1FrZTV0ZWg1Wm81UnlyVWNX?=
 =?utf-8?B?eitSS1BBKzRsZlo3b29BSEN5bER2NWtEVWxnWXR1VTMzNXo4Vk9mS2E5WFps?=
 =?utf-8?B?aWp2S2RJNEdWME90Y2d2b2QyZHZkNWJQREZqcXhJQ1VZWFY3R1o5elRUR1ZC?=
 =?utf-8?B?ajk1eUV1emRXUnpuSDJJNXZOYitBeXlSMUVhenhCemtZK0s3VTZzTkFTL0tB?=
 =?utf-8?B?ZFVSdWg0R1Vlb3A1MGFtcTFjUm1uNVB2bko5N0NHalhFVHVqbTdOY25DQWxK?=
 =?utf-8?B?QmlUV0dJelNROUh3c294Smg2azdabEh2dUtWTHBlaG9DeHJIcTV2MHd2QzVB?=
 =?utf-8?B?K3UydGlaQTQ0SHAyOE1kck93M3lDdk12NVpoSENpbGJmb043ZmM5ZUxXL1FL?=
 =?utf-8?B?amlVckhRb05wMUtpRFFlU1BKdi9oVEwzZ3NZMWNWejlaYnJVeXU0M09YYzVv?=
 =?utf-8?B?UnI5QjhUalYrL0MxMDJoQS9ucnhJVUI2NERESkdSS3NYTEMrbHFYMVNUbits?=
 =?utf-8?B?WHZPRFJ1Qlhzb2dqeU5pU1Y0M0M1a2EwekdnYUJ4TjZNRkFOQkZEM1kxb2FQ?=
 =?utf-8?B?WGlyQkV3Q2dsWlVIN3VoL01sTG5mZ3VNYkFWNmFxR2RPdUM4RS8zV2tCRVhI?=
 =?utf-8?B?NEE1RWxOb2Z3YlE5T2p1bG1FMXZyMEw5Z20yOCsxdnF6YTZKNkNzYlprWVAz?=
 =?utf-8?B?OGZDM3JXWThZWmxVZGpJalAvZ1k1SklqY3MrVTVCOU4vU0FFZE9OQStGOVFS?=
 =?utf-8?B?Q2tjM2txNDRDaWFud3h1dEd5MUpkMDZqbWdmVWV2ZzVqL0JDMkZUeGRybXB6?=
 =?utf-8?B?MjFDOFJFTFhLYmU3Mk1PcDN1WXpIZ0JVMjd1alczdDlIU3Y1a2pkNEpuZWFU?=
 =?utf-8?B?b3o4SlZNYjEwK2liemNuNWU5TVYrdTJZZmFuUlBoeDlYQ3ZOL1FxUEh0dzBX?=
 =?utf-8?B?SkN6RmVFcTM3c3NjMjhReE9CeS95V1ZUTGhRK1NyMGlZNnNxbWNMWmRzM0VH?=
 =?utf-8?B?SzdIYXh4cWFoWXdzblRacXdOUmhqTktpbFcwVFk0aWlja1VkRk0wR1h6Sk5w?=
 =?utf-8?B?eGdONnhtV09MSHU3VlBwZE9lMG92dnlWNjlJRkhRNFZpOVFPakVCU1hRMVky?=
 =?utf-8?B?azRDc2hvb21hbGxMRkhTRmpETDN2SG1OT2RsOExSYmZ5MnJHK25EMUkwSmtR?=
 =?utf-8?Q?+FN6c+9HlRO1214I=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2da5a9ab-e8d1-407c-6ddf-08de6892b344
X-MS-Exchange-CrossTenant-AuthSource: VI0PR06MB10639.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2026 10:54:01.6319
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OATNvj6hFzc6uIOztUdYjlFhnAMaGdhsEgOo+Mgy5YDcOvfPJBkBamJRaJ/g/HyFg5Cw4OzmM1nud0eHKaIfGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR06MB10173

This backend supports the added CAP_ENABLE capability.

Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Reviewed-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Tomas Melin <tomas.melin@vaisala.com>
---
 drivers/iio/adc/sd_adc_modulator.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/adc/sd_adc_modulator.c b/drivers/iio/adc/sd_adc_modulator.c
index 9f7a75168aac..218117c45ec8 100644
--- a/drivers/iio/adc/sd_adc_modulator.c
+++ b/drivers/iio/adc/sd_adc_modulator.c
@@ -77,6 +77,7 @@ static const struct iio_backend_ops sd_backend_ops = {
 static const struct iio_backend_info sd_backend_info = {
 	.name = "sd-modulator",
 	.ops = &sd_backend_ops,
+	.caps = IIO_BACKEND_CAP_ENABLE,
 };
 
 static int iio_sd_mod_register(struct platform_device *pdev)

-- 
2.47.3

