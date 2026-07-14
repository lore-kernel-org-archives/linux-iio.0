Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazolkn19011031.outbound.protection.outlook.com [52.103.43.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 686EF46AEE8;
	Tue, 14 Jul 2026 13:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.43.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784035969; cv=fail; b=l0nbCPZfhHxXfIwAY7UzRauwVBo3T6Gt51YWbUQyxJlpTKkNRvHRl8ckTiIxK8geOAR5lQDpgvg+7LYs+pDKb5kutBvS+DwB3zCQ9t+RdHh/9fhUDZICyv4jKBENV9UUZQjRXCcF2S9486kIS0Ti8RPSY8jTepplBk40UsrCjSI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784035969; c=relaxed/simple;
	bh=sNZp3IT2KTpjF7qVb7n4WCzreOHTr3W2UzucyBj7myE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YCG/v3vEqUz1ltjr4UjdsR9PF036TTlcH9TbeZoDK2WG4VLkOLW5lj0M2zOa+GGR7nF88cLoEWy5owpYslpju1HlTQUHDT/ch9Alpmvu6PhFQK/gMXARS02BAkb+aDqInAZGYYXsqK1+3DpK3q3EbUNlqxCw4cVPCv8GB9Fd4tw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=VKmXSEia; arc=fail smtp.client-ip=52.103.43.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="VKmXSEia"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=glxM0QJb19mUbd1dcvTbXpCbwt2XYbQzEep8oW7hDN7/iyvPhqbH17rcbHeKi1uJd1rsmtc2Piff0zcR9jKQznRUSxWVaid/sgu1ObtbfQmpHQDFAZk8fdHUt5pH4ka9ALN4jMyWyMjesP0v7qW8e3+EwJuTKlyK78/nyfCqyOgxC8fpgF1YTELqy/GVhsXvVhqEybMRLFMYMt1t2JBRr1zAbXlMs3kDbtkWJXBUG4/CHyKNg5aaooa4JoTYPt/n7t5j1fZB1ae4qG9Tf3Nhro7X5KJCXoN8amHi6kM4kJG2adCL6PLt0+ON7Bjxmx6HgasazMxIxZjBXd8ESb9O3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SAMeD3jPdFrCrLKlJjySJ651+cgbDQ2WM35dRK0Ka3M=;
 b=BYscnLNlbRSjZ0pNAUgf4R6Eg+K0qD0TNz0s40CZpd0mhy17i0B+pznY/4h8TmaiHrBHUABxYSYDrM6nMvNsBda+C0I5OieAWRfFHsU+SwgUoCe0U5wdxpGx/VwGraT+aE612wgKBBMrKSJ+3TueLneAmsSm7ptpfKbZOXvZ+4qCAC5dWnsAaclzwvn/Y8M7mdWR6skjY9FA6gfQXKg1kg/gMzEXhGWC2iX+MFbm1qUS5lAD0jh5aiI70hD06+mTxqWfBspt50we1C72JJ+ruC2nZew6+YcJhBLRod51Mh3ks8L22bUvhgq7CCDN7AAroGWRn67/BxkGXg6W7YUPAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SAMeD3jPdFrCrLKlJjySJ651+cgbDQ2WM35dRK0Ka3M=;
 b=VKmXSEiaO2MS8iGwSmh25gGw6eDI0cWhbTyv18uLjoJww+EpTeIDLOgKV6YBVn8ERIHSMkAa5EsBRNm4oqBi1LFHel3pSGuo9M8E2Ao/47riYo1mpjHXkm4mROZeNjc6+PaBovc0xUHw5Nu8ClZNecjRjlRFyOUt5TzTjmOj/lpQZKkDa8kByIZRkrtV70Y0FlnqcCW6C4G+6hLQNlJG8PDlGa+ZExvLlDNpnEZ0k49ItGuoNBKCAo2UU4v1aH7WNUjhZEfUk4mN6YJjceMI+lrnS4zpihwWuUU+o5SEAV9Psj6+dMRVo5qlrpIB3YrkbEiZjo+sZe7fpSJXkm3geg==
Received: from OSZPR01MB8235.jpnprd01.prod.outlook.com (2603:1096:604:1a6::10)
 by TYCPR01MB9876.jpnprd01.prod.outlook.com (2603:1096:400:208::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.9; Tue, 14 Jul
 2026 13:32:46 +0000
Received: from OSZPR01MB8235.jpnprd01.prod.outlook.com
 ([fe80::91ec:1d9c:731c:db2f]) by OSZPR01MB8235.jpnprd01.prod.outlook.com
 ([fe80::91ec:1d9c:731c:db2f%6]) with mapi id 15.21.0223.008; Tue, 14 Jul 2026
 13:32:46 +0000
From: OrangeBlack0765@outlook.com
To: Jonathan Cameron <jic23@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	OrangeBlack0765 <OrangeBlack0765@outlook.com>
Subject: Re: [PATCH] iio: light: tsl2583: migrate to sysfs_emit()
Date: Tue, 14 Jul 2026 21:32:26 +0800
Message-ID:
 <OSZPR01MB8235ED658413011861ED9173AFF92@OSZPR01MB8235.jpnprd01.prod.outlook.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <alX5FkSyqo6taYl9@ashevche-desk.local>
References: <alX5FkSyqo6taYl9@ashevche-desk.local>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TPYP295CA0056.TWNP295.PROD.OUTLOOK.COM (2603:1096:7d0:8::7)
 To OSZPR01MB8235.jpnprd01.prod.outlook.com (2603:1096:604:1a6::10)
X-Microsoft-Original-Message-ID:
 <20260714133226.10045-1-OrangeBlack0765@outlook.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSZPR01MB8235:EE_|TYCPR01MB9876:EE_
X-MS-Office365-Filtering-Correlation-Id: 295482e6-0bc8-454c-f40f-08dee1ac629d
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799015|19110799012|24021099003|23021999003|25031999004|25010399006|5072599009|15080799012|8022599003|3412199025|440099028|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4hOw1v/qmgLHnCrZBXkeqNvnnHokG71IRBZJroKRBpTr3TdC/wAKKXUE3QYS?=
 =?us-ascii?Q?Yv0YrDpyQ1c5iJoRAA0I5gZy0pg7/N4buw9W3/od75yTrXkjp1eyvR6WSmhP?=
 =?us-ascii?Q?D1jtcxRFhUdeiML3od7le0g/8sKj4GrXPN1N9bQALKixyW2TzBuubaFai13u?=
 =?us-ascii?Q?0MJGU3tbJ0Zc2BHpCPLu8bmvASDDzcJr8kY5q9mKwkLwU+9x/2joHMz6PCXO?=
 =?us-ascii?Q?DUgDckwWVwTCF5LVHOn00/FTl0KKRfCPaOowAYjeUA2dBfOUcea7x3PXA/W/?=
 =?us-ascii?Q?PrYuDcFKtDMxJMKtWsg6IcIPsLXN2guIYZa4gjNsF5zOyIkEx3wnuHPa/5Cy?=
 =?us-ascii?Q?bD9s2WHa0T3DLfZoyfafmfhVathsykQzkNIxCEqfOwgRgN9PdXpVGYJFCaU5?=
 =?us-ascii?Q?o4hDGHMXcVTNfinnrCRUC7atd5gYmGVsUAivu7UDolGTwvAyb0j9cp+4v9Ub?=
 =?us-ascii?Q?2uYvzZVzpLQt7ekMd7L4n5duqefvkX8xSQc0w8yXQ1lPXFrOArQeZUo4jIP2?=
 =?us-ascii?Q?SzqqbMhBMOyNVXjQDQ0zaaxRg73CKJLxTtzftQfNaXiJ5l9q9vDt6X3aglus?=
 =?us-ascii?Q?FSC1reDcH87YO7FCm4fz22BZuYERPvu+tIgdqkgQU7/nduzcnj6cX7aWghx7?=
 =?us-ascii?Q?HuitdCczSKtz7fV982tOYUIvP/mKh5GJd4BN0CUjb7BJgCIinWPuAhsf6tkE?=
 =?us-ascii?Q?5prN4mexx/ztKFVQ7WxKTeVAVmBMDCZqsF1njNfbL+6HZtdxg5chYBJjJpB3?=
 =?us-ascii?Q?1FPz4eRT+EmF5Q1oeXlBfzVvrZekZWamts+o6lcwRZPvHUEEU/FnI6UFfvBd?=
 =?us-ascii?Q?ASF2jyjv51QvQJZA9LBRFXYJRJtinfz2qQmQkA5K0AiQTAXr9WY/Ml72jhT7?=
 =?us-ascii?Q?Prrv2m36rplBD4083o+DRhWifEjK3GGkXNxOrg9GiH6n+yC3FMlXOlgG/oXD?=
 =?us-ascii?Q?cJAeXEuaJs9IQAI26VYiLQ=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WDfaXzNctBQJYpp23qU5M00JKyv0CsVO+yNl3Any8QSnc8+1wl4gMwgA9WDU?=
 =?us-ascii?Q?YqF3ESEg3l460RA6twQ00DtMT8LqdK2hhBgf52vMd/ASAoaKG9nFicLXllel?=
 =?us-ascii?Q?cDTZ7BV2XaNXny+bOUjpfleF8QVmBqiyPlA6B4cK/3heUsQdm7JHClki8n0d?=
 =?us-ascii?Q?CchPAkLhesDG1qrkhoTIeTe2kXgjM2/wzXW14U5WRnx5XsEXx5uDIUDcusrm?=
 =?us-ascii?Q?sdKsbWQ/R4sG1m2N8+9EXJVlrmtwLxB58bUviTYv9xwZc13fMBLc7h4M8zKC?=
 =?us-ascii?Q?0TBQNsZaZfzqTGIBCpXJnuYzqK6yO8iICZOAHqYiR+BGMpRIYL57UQQWMXXY?=
 =?us-ascii?Q?aoWL34cYeyv2z5mPbMmSOwhFBK8fB2JrcTTIVwiCyHxYtlpGvPyURV15UAZC?=
 =?us-ascii?Q?3W3qndGIt3Ub6iEyyHm3ginIxHTIOTJf9AQUBdFU16uFR+hrsXpqe24dz2jc?=
 =?us-ascii?Q?oQ5JcWE3hUWKBlFTILQmRzlwHFfQgb2lWVXf36hHVnICYirNLaMAmdlxJNZQ?=
 =?us-ascii?Q?SywLTRfuSLkTWKRbJc3n+Cs/mPte7WMy38t6a87NV78mnLMuJ+4baTDI8Rn0?=
 =?us-ascii?Q?SMRF+TEQGRhzO0VhDkIVpVr/BCjf4X6RDQFBOII9etpRuIec0xa3yDxn0S9T?=
 =?us-ascii?Q?HsC7w/Pn3BAh1O8U6pQqncwnM+Wr7KelXMUc1pdqzoON+NGdyGUYpDCT2Qyc?=
 =?us-ascii?Q?+fnx7Jcen5pctBfQzyj76TGwGukjUZ3FMwEbkHUHweRFmfsy6LEjig62PA99?=
 =?us-ascii?Q?Q1ssatxuyZhuNUmBzpy8a/j/2etEkXvwSQBSBbOkDqey+Ou8j5AoeWX6NNuh?=
 =?us-ascii?Q?x5FonWcn8OsPZ1YICQYpexdRK5Ev+mK3wQYtDqsm4mso7gewuNJcf+zdc9Jc?=
 =?us-ascii?Q?We65oY9gWKuHDKqYMVTI8RYfNaLnfFsOPnJGXQ9RKA+BcEH6agLchjII57tl?=
 =?us-ascii?Q?QFdptMCzq0F1ZNU+67cPYGaBLV2qMFCsGWnAb6LtD89GRb9m9HMEdx3ZsSvI?=
 =?us-ascii?Q?q3XAQDHJkhER3pT7vJc6vn/lB+ZNgA9PaRQerxwGvtIP97A1Q+/zNAgRXomT?=
 =?us-ascii?Q?JKmUdAtfjtQqeW1RxO5r/uXqiFWQJ5Q+EpcAGkquL5YoFgWiwf2PfwmLGVgc?=
 =?us-ascii?Q?Y5Ln9cPocmAeM43M7vDOdKJtGR0L/022kthGZ/oyrLgR1yU+48b4CB461Dos?=
 =?us-ascii?Q?GWdbvjOuMbH4Xa5hOlPDvKSgRVqzmeecNsgB6Zx8S6OecdsYeQvWWcBEvbHr?=
 =?us-ascii?Q?9jN0Rc03KKEUyc4jl47tC7YEc1ziSIB26+0LVdbX0+hhzSf3nGpWU0X6gPZG?=
 =?us-ascii?Q?74+HyIT3yJ4wZylTrWMy5dKcoBceFyIc8cEY72zNLvG4BIcd9+EVck6msFIX?=
 =?us-ascii?Q?P6Kh6BtRWB7AGMZnFM0maFkDvTufxzfM0RYcNtbkSMvVgpDGm2Aj3NitZeUp?=
 =?us-ascii?Q?5BJ1nH8pm3oeLcDmxNpo5hH/NVoyaU2GfEuQtFp5sDWm0yqLxSOkfw=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 295482e6-0bc8-454c-f40f-08dee1ac629d
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB8235.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 13:32:45.9108
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB9876

From: OrangeBlack0765 <OrangeBlack0765@outlook.com>

On Tue, Jul 14, 2026 at 11:53:42AM +0300, Andy Shevchenko wrote:
> >  	for (i = 0; i < ARRAY_SIZE(chip->als_settings.als_device_lux); i++) {
> > -		offset += sprintf(buf + offset, "%u,%u,%u,",
> > +		offset += sysfs_emit_at(buf, offset, "%u,%u,%u,",
> >  				  chip->als_settings.als_device_lux[i].ratio,
> >  				  chip->als_settings.als_device_lux[i].ch0,
> >  				  chip->als_settings.als_device_lux[i].ch1);
> 
> Now the indentation becomes broken.

Thanks for catching this. I will fix the indentation and send v2 shortly.
