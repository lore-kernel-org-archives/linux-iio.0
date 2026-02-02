Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11023104.outbound.protection.outlook.com [52.101.72.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBAA7364E97;
	Mon,  2 Feb 2026 12:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770034169; cv=fail; b=E4VXdbefMcSQ0bjWburAzDFcdndAddn8Z2s5TjlcpoNU6zIbjQj/jBwMCeJUeVcyYWlgMd+8QujLP6IF1UuMiNdlSo+3LBkxujFFMxbO4SZfkxZxFWg6pJDjY5irMYDaosioxfIyVJzaP2tpF6NRTHx0l/N/nmKcUQsfMUbk++I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770034169; c=relaxed/simple;
	bh=fjAl3sGoT2GBzXYmaYD8luLA9TuvQJeWvYhRuWLIjxs=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=maxm96W68NpfHIUKAiCDcvxkKPjfcQm0GH9N2kQs4CDTytNxDKY9qAH7GYyo7EJ21lnziih70d6r6vfyzXTyRd7a8ZxN1pmEkSOlfBIoaIrVLN8L9rZgWu2DLfX07rVNAnwn3rzDqWxVsHeDauBPXfN/iuuNkQVA8xsLRz/2Vfw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com; spf=pass smtp.mailfrom=vaisala.com; dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b=rqeZEUeP; arc=fail smtp.client-ip=52.101.72.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="rqeZEUeP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GhMYyKorMpRxKYCoY1pa6GppwC2iYYBcVM0evumCIB+lmnIWx+9leAFSSJOMBYXuBkEBHGC6Tf7XFkPhfycq5e3oRD1IOGc+hA/SCJ6k4SM6JoTyuXWoylPIhw3s9D3Bnkji8ANNLRHT68s7sGZ+XgKY2lRMiYg44tyfSAWU3gpTNVdB5u23PxOP7W74Wzf0jzSWgr+Wv4MP2Vy0lcn7UEIcq+J1+zpFLvp2vBQRAqmFMr20vNhdM19A24KtYOOupFYsBPYuLZOa/yAGVRIPpg63gou5tzdXUyY6a26XL331PID0L3BRwOhX7yn1kDRTq/p2o0oX4InvOey2pUi8ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VExK7uw2aTNbrhobYjX3i/bUlG6frP8aFjv39ckER4I=;
 b=SqXJHmlnXKoPuXsaYGoRdmzNRNgt6L3ZpRWyP155HLQxzbvzH91MpVV9D8sUSyQxNkFWJUnTqeOAgvsfJ6Hgsb8hqXsNP2UKxUtAUjwhadktWxCry3Ekrq7qO60v4s6t4h2de3zfjhz9euL6WjuJA1XbUnWUcYHaq/MSTPXUTwAxI+wlnfXRJFMReVABi/aJxlqVjK6Q8YJTekV+g+Mm8cWJcCjtW4VByECpODXWk1DhQ8kBOfQv9gPM4NtOh2kRLJdEypjlmxMcWbpWAF+izkvQuUxt0Tu7093hDnf3edssBZxxHUlX1MtSFGI+sObqv2guSO1wBkF/rZJwlaE0LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VExK7uw2aTNbrhobYjX3i/bUlG6frP8aFjv39ckER4I=;
 b=rqeZEUeP6Cmpg24woFlVHzD2wLWby1UGR7+BPyj6w2aJ/414l67D69jU6bJDp2LXtUOuk8fBLJcpLaFDNUtxGxk/44Fe2pw9vpN8EFwUXHvnF606ODOW+ifOSkGyDK8/fOpkbk5y3YFv4TrJBqHBMoIXBdcPEDPkm1/FiUQJ9noQCh0Ry32QRt3sX5z2ZFtNu2ZBWKqz9uvzeNGgL28uHy0N+AWGpEKHNMdIa54S3tGlrK9MK0oDSUMVaeYeJCqszF19bKhZcNwNvsfvVkpXAHN1zlnS4FqgPueHDDm80LAAoYZ7+YrhXKeoBxAr96pynGdE8wu4sozMQ5RH95QkKQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from AMBPR06MB10365.eurprd06.prod.outlook.com (2603:10a6:20b:6f0::7)
 by DU4PR06MB10586.eurprd06.prod.outlook.com (2603:10a6:10:641::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Mon, 2 Feb
 2026 12:09:22 +0000
Received: from AMBPR06MB10365.eurprd06.prod.outlook.com
 ([fe80::addd:5e9b:7273:8049]) by AMBPR06MB10365.eurprd06.prod.outlook.com
 ([fe80::addd:5e9b:7273:8049%6]) with mapi id 15.20.9564.016; Mon, 2 Feb 2026
 12:09:22 +0000
Message-ID: <35065f3c-2865-406d-b2d4-d87f6976fcd7@vaisala.com>
Date: Mon, 2 Feb 2026 14:08:52 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/13] iio: adc: ad9467: remove unused output_mode
 field
To: Antoniu Miclaus <antoniu.miclaus@analog.com>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Jagath Jog J <jagathjog1996@gmail.com>,
 Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>,
 Fabio Estevam <festevam@denx.de>, Matti Vaittinen
 <mazziesaccount@gmail.com>, Linus Walleij <linus.walleij@linaro.org>,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
 Eugene Zaikonnikov <ez@norphonic.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <cover.1770030812.git.antoniu.miclaus@analog.com>
 <4303fac3a1cdbe7e94c7c8c5f8a4601cb2d3526a.1770030812.git.antoniu.miclaus@analog.com>
Content-Language: en-US
From: Tomas Melin <tomas.melin@vaisala.com>
In-Reply-To: <4303fac3a1cdbe7e94c7c8c5f8a4601cb2d3526a.1770030812.git.antoniu.miclaus@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV2PEPF0002397E.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:400::36f) To AMBPR06MB10365.eurprd06.prod.outlook.com
 (2603:10a6:20b:6f0::7)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMBPR06MB10365:EE_|DU4PR06MB10586:EE_
X-MS-Office365-Filtering-Correlation-Id: 1dfe0464-893a-479b-8851-08de6253e639
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|366016|376014|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QUZHQTZTbUc1RHU4bHR5Y01wRkNZdnl5MXdXRGVKazhMeWxHUEYvYWpjcUI5?=
 =?utf-8?B?em9seTIvcVJybHVzK2hOblVVTXZSZERHRWZscXkzcmgyVk5zWGxzKzV1RnNr?=
 =?utf-8?B?NFJ1MFVxUngrZUNmanB0Z0I5dGpPNGxXZmNJNnlGelp2c2l1elRXNGREdDdK?=
 =?utf-8?B?akpaMTJjTy82Zy9RM2RaK3pQdDM1bjZVaXdmZTJmbDU0aFREaTM5ckwrYnBW?=
 =?utf-8?B?VkdacytuWkNtVEE0bGw4U3V5MXk1UnI2Z0lkQnphU3JUVkloSHBCSFd5NVlE?=
 =?utf-8?B?M1dUOEhNUXNKZXZJWjdFbTVPS1I3TDc0REdJNDJxSDF2YjRiTGdKSVA0REhZ?=
 =?utf-8?B?ZnNNRXBub21OaXFaWndQWDJtbjl5K3N5V1FQazQ4aEh1aUZ5cnpiM0MyVytY?=
 =?utf-8?B?YURFcXVVUVh6NUNsS3BGVk94QjhkaDZ6ckNwbmlQYjdaL1JubmhxbHZYZDJm?=
 =?utf-8?B?VFlsWVBjNDB2K0dtNEFwLzFCbytUcWluem5jcTVBMnZ5TjVQaitTamtWa3Z4?=
 =?utf-8?B?ejF3OUZwK3d4ZmIxS3ZmcExkQjFNamRhTU4zNzc2Y3c2emd5KzJuekxDWGtk?=
 =?utf-8?B?UzdqOTk2T0pvUWVKZVNIaVREbnZmdmcybzZJZjdMUWtHSEF0SmpuS3dZMEdz?=
 =?utf-8?B?c0VvYStVZitCdEtjTnFScHhqajExczVZY3hxYVpqa1hjeW16N1BJRTJsMUov?=
 =?utf-8?B?RzMzaWRQTUEvcUJFVWZQQ2dqOG5uUnFCTFZoNGVHTjNiWFFaazBoV3FsT2I4?=
 =?utf-8?B?Z3BZQmFSdjZkV0d3Nk5RZEJWVEsxVXJrZ2NrTkVXUWU1WCt4UXFnUEc4RnNp?=
 =?utf-8?B?MldUdVJ1Tzd4VGZmZUVFdTR3TWgwbmh5eGxBWlRVN1B4Y0lsOGUzaVR6Q2Jl?=
 =?utf-8?B?UTJTeG1yenkwWmZqMGp6WkZvNWFqaE9CcEc5NTlhTkwwY3JsNjF0U2RrbGZF?=
 =?utf-8?B?YUVjV1dRUWZ6WERhRWZBcnFDVzlIVjMyb2hpaS92MWpFRC93NlJxR0kyVEhX?=
 =?utf-8?B?ZmVKTk8xQjNpcFNQTHczdCsrVzh0aHkvL2J4dDVURWd4Q0ZNdi81WmZNZ1ZK?=
 =?utf-8?B?Skh1SE5Ec1ZBNGdPTjFiRkV1MGhzbmVVKzgzRnRmeGh3MHRSeW5jVGdrMEYv?=
 =?utf-8?B?aDRJc2djMFVTWE9tTHAyTTdBRnpqVUlGUUtQYk1xVUxnSE1zRW9wOXE5WkZC?=
 =?utf-8?B?c2RSTmwwSHNrM0ptS3QwaFlQb3RiYTJWWnZjVHFTTG40UFFkUnlxRG5hSTRP?=
 =?utf-8?B?ckJnQ1NGWnB1bHJtTkJqOTlhb2JpWU5nTTk2dHExK2ZKNzdmdGM2QnNDaGxh?=
 =?utf-8?B?SENHaytaQXhrZmtnU3FMc09Zd2lIc1hpWVc2QW8rYVdmRWtNUkpBNWZQSDAr?=
 =?utf-8?B?QmcxWVFDUjBQbjhraFRLUk5WbTJXMExEMWJRdEMzR3h3WGVtRENsWlFoOUV6?=
 =?utf-8?B?Q2hOQUNmN3Z4K1NqdUJTR1FBV3lrWjdCSHVmaW54bjFucDAxNVZMU251cVZx?=
 =?utf-8?B?U21YQTZNeTVpMk9VcU9QdXR0SE5qbStRQVc5dzYrSFFIQkh6anFWZmp4U2dX?=
 =?utf-8?B?VFBEa1hjbmQ3YjU1V3VuWkNEQWxZaHJVQ1hSa2pVeDJJWHRsREw5MW0wWE54?=
 =?utf-8?B?SU9ISU1LUjZEOGo0Y215VkVaMXJ6aHdONzIxQWRjOG9FNGRoRFBWNS9TcjV4?=
 =?utf-8?B?dlUxd21wUnBhN2NtNXZLUTFkTklOcHY2b2FIT052NW9NaysxVDFBRW1tczh4?=
 =?utf-8?B?ckV4ZHcvVmpONUxnR1ZjcHdyRzRFL1U3Y0JlS3c0L2g2NWtCZmN6ZkdHajRY?=
 =?utf-8?B?Z29vQ3c5R1hMSFQ2aXlBSDlJMzFWMmtpNnh5SDN3T2RGNTN6aXhlemRuUjB6?=
 =?utf-8?B?RVpuNS8rSVZEeVBkU1VnYlMzKzhBSGZPZy9GNnI1TlhsNGZNck5oSzQzZ1lv?=
 =?utf-8?B?ZDhZeUxaK1U2NTFnREtnOGdQUVlST0hXaDhwTlRaMktsQmFSNEdVZTd1cE9z?=
 =?utf-8?B?MGJjWHBNaktKSkZNbUJFNW54blkxdThuQTVFVnl0cWttaDlkUEVwN0JHbW5S?=
 =?utf-8?B?ZkVTOENSYXlsTzRsS3VjdHVRYjZVQUc4dmgvaE45L1VCbTd6Y0xKdUdZQ0Fm?=
 =?utf-8?B?U1ZjOFU0aUNXT0hObi8waWFpTUtFanJNYVJzR0h1Mm1hRkdYQitpdTA3d3Mx?=
 =?utf-8?B?S2c9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMBPR06MB10365.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014)(921020)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VFpFSkk2TzRTT1BuVjJiRllyRkJUV3I1MHY5S2xTMVpjU1BqM0ExTFJQK1Vx?=
 =?utf-8?B?ODROUXJ2NjZ6QXVza3pPS05BWFN3UVdrQmo5WUF6RVFDbDdrenJWY2crLzZZ?=
 =?utf-8?B?NElkRlZMVzQ1TzFWaUN1d2dLLzI2NGMzaUc4QUJWMTVKMnRBM3FFSXkxT0pF?=
 =?utf-8?B?Ti8vYWVVczdiZnBaMnB3bkV1Ri9jRWNTZDJWRzRCUnRFWHNmaVJ1dTVGVlI5?=
 =?utf-8?B?S2ozUkRadmtScXVFVENWbkJDKzZ6bExEZUZKa25YOCs2d3BHRm90TVB2Qm91?=
 =?utf-8?B?SVhlLzRhc0pvb3FvelRUdkJtUFJHa3JBQmFQRS9OVDJ1ZGRxY1B5eURreHkw?=
 =?utf-8?B?cGQxbjNacENmSkg1QWJBcWxzZ04wa1hOb2htclkwRk5oU0pSWEVmUW1YbFha?=
 =?utf-8?B?c1V3L1ZZQXJncnlRZjF4VlJCbFRBWk03UXN0dGx5eXlGMXpYa3RiSVJLNDZy?=
 =?utf-8?B?N1BGNlYxSyt5eStIb3RsZzlTbVptbi9OcnI5aWNOcFpIanhLbFJtNElXaUtm?=
 =?utf-8?B?VHZESjdMdGRSdHphdjBYNTFRQm9QaXRLMDg1TW1JY1NTSE9WcnlhZGFFUHpz?=
 =?utf-8?B?R2V2NUlSWmZtdFVST2dKSWZhWnRobUNuRVlQRThvcFE3UGd6Q0hlSUZtR2tB?=
 =?utf-8?B?TUlPWFpPMDdtbTV0aWh4d1RoTmltZnQxVUhsRTFlaUViY1BlVDFsTndtcndL?=
 =?utf-8?B?bzFWbFZaT0poVnFKMGhGZ1JVNFhhZHZTUkFCTk1EdHdQRUt5c0wwZDBNV2RX?=
 =?utf-8?B?bjFKQnoxSUdLVDEzT3F1eVAzV2xwTVk0TVJDRVdxbGp2cWtvam1TS29peVpJ?=
 =?utf-8?B?NmovaHFzMmJ5bnM3b2JabENNbUZpR2hnL2VDNFJHQ0hISU9mTk1KNnp0NEpD?=
 =?utf-8?B?ZjMvc09VUWt0RE1xVUIzd0xiR0d4Vmh6SUVZeDcxWUFRMGhRWFVscGdUZmtF?=
 =?utf-8?B?QUYrRldOTmtqa3B3VStPRlkvNHo0SFZZVk1leld4OERuZVRaLzVERWlVMnZC?=
 =?utf-8?B?UEhORld4U2VrendRMUVRNGg0TU5HR1hxOVRhY1drcmVmalc0SVhYQTNld0wz?=
 =?utf-8?B?bUx4eUlzZmdoTUQ4N3ZMdjBqdGcrbC9leEsvL2R1d3QvN3dIbnJ5UkQ3bnpC?=
 =?utf-8?B?UFlza29ESmpPbElQSVhoREJpdnVCQnRvUkIxYmZMR1RUNGxZWWZMUVcrYnNl?=
 =?utf-8?B?WXJ5eWYxRWlHSTZjdmxZc09GRkZ5djhubEZJbDhmNTdaWWgvRDNxSVg4TVBJ?=
 =?utf-8?B?OW4ydDY1L0NrUGlLUVkwR2ZNYytiQlpSc3NWYzBtSUh5R1BIWGRQYWU2Uy9W?=
 =?utf-8?B?TWpZOTBjSFk1MlMrajk4VWtwa1h1elFiM3NRNVRiQStRelZTS1YvdGdGNFJF?=
 =?utf-8?B?SFNLNno3TEcxU1dXL1pXTkd1Nmo0a3BLeVpNR05qNm5yZTVMdDFjWTBGRmtz?=
 =?utf-8?B?MHh6bkJ3THorOGQyRTlOb29NTHgxeXVpa0FHQmNxN1ZqK3htNnIxUFlZVFFV?=
 =?utf-8?B?c2pmREVkSU8zN2ltVERidHlleTAyb3g1ckJQT1laelN4aUxja284ZEsrcEFU?=
 =?utf-8?B?MzB3aUpkd3lrRk9VNzkyUVZ3eXhxVkZmbnFFTFgrU05CYXBRNDN4NVYyYTRy?=
 =?utf-8?B?NjJHMEtkVXBEQmVOTnh3SXhtMUlYS2xaV3ppQ09UbjhIa3NNMDE5enl6UXd3?=
 =?utf-8?B?N3k2dGJOZkVzWEk3MEswdisyQ0x3MnFUdys0YzJaUmx3dTdOdEdEeW1YMk1G?=
 =?utf-8?B?ZS9Kam1XTUdKSnBZbzFFNFl6cjlUMG9nbU1yWnRsWTBycUdiY3ZlK0RJSitq?=
 =?utf-8?B?bjk2TEVsL3pnM2xaZzRGNFFPRjdyZDUydFYrYnZkVy90dGlZcjZUeVY1YVFM?=
 =?utf-8?B?cGhKYy92TUQyS0FxTHJYYmVxNXh4OE1FeW9IZW95SlI1bnhtdmc0YW9XY3V2?=
 =?utf-8?B?UW5Nam10ajNUMUdtQUZzUGRPMUxZeHpwY2lSRitBazlOQ2dBc2F3TitnSEdl?=
 =?utf-8?B?ZDZlQnFWYVBwZFhsNEV4TVdyOFBkNFVvR0YrR0llNnVrRVpCVnQwdEM4RGpj?=
 =?utf-8?B?ejl0TUNsWXBTOFhxQTZiOEQrNHRhU2NkMFNjUjlmVzQyRXhocFlLYldTcjlz?=
 =?utf-8?B?RmF4WllqUzBIcC9ERVJJQUszSm9yUFVtMGZWdE9aekhUQ3BxWmk3ZkhnRStq?=
 =?utf-8?B?S1V3MzdPVXhKUzZKRm8vTGxnQ3FCLzhPMmZPWGVNbFM5RXFqUTVFZy95TCti?=
 =?utf-8?B?OVgxbFpQaGFqVnMwWVJVTHNvTmVVN0xyREU5dVN1ZmFIK3VkNHJMd2xGOURN?=
 =?utf-8?B?WHdZMTJpcG5hVjBDVXoyL3duMjRtQVJTbisxZi9OeUFJckJMQjlud1lHZmV2?=
 =?utf-8?Q?I0/od4ccah+acnvg=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dfe0464-893a-479b-8851-08de6253e639
X-MS-Exchange-CrossTenant-AuthSource: AMBPR06MB10365.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2026 12:09:21.8315
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aFkpDvewi9A7qq72hFMvanRJuQL6SmmjJyuM0T+LF0RRp7xD7qIShq1411Ub/6sA7de1OKXXveiRCEQECYPNlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR06MB10586



On 02/02/2026 13:25, Antoniu Miclaus wrote:
> Remove unused output_mode field from ad9467_state struct.
> The field is declared but never accessed in the driver.
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>

Reviewed-by: Tomas Melin <tomas.melin@vaisala.com>
> ---
>  drivers/iio/adc/ad9467.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/ad9467.c b/drivers/iio/adc/ad9467.c
> index 9cfe66425d4e..df0c05e7c60f 100644
> --- a/drivers/iio/adc/ad9467.c
> +++ b/drivers/iio/adc/ad9467.c
> @@ -176,7 +176,6 @@ struct ad9467_state {
>  	struct clk *clk;
>  	/* used for debugfs */
>  	struct ad9467_chan_test_mode *chan_test;
> -	unsigned int output_mode;
>  	unsigned int (*scales)[2];
>  	/*
>  	 * Times 2 because we may also invert the signal polarity and run the

