Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.2.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793033851;
	b=P9gFYEdwjcnw9t5yD88FQHA+dhR9m3hYPIHd6wSp4SV6oUw7i6bTWmadRX0LWRIBmmNL
	 LDWmMy79NxVItqLFoWVmtJy7zwrYsyBQ74joE74gmS/kNAcvXUc6KpsgdqKpH6yALSIgp
	 rBekQ+J9BL7kbPvLsjH6JTv2kue+TQdOmfWWGz2mE7mBIPieu/wFxlogXkDIYZhCkKwVK
	 zIx1Ov64fWkLi8BG71xupygwPLYi3yU98Uq5+hN9gEuJyenfgFRY9e4UF3VzwzSjZqIVs
	 NEIjE1ZIk8Td/nBOy5dn1w0qy5q25Y2yWDgvWO6fsyAij9tcMTSiaseGt+mEgatQprg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793033851;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:
	 X-Microsoft-Original-Message-ID:MIME-Version:
	 X-MS-Exchange-MessageSentRepresentingType:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=eCrqIJbPWfy+8HQX56wOSy6vCCBZ1HuxsUB6wzktAaQ=;
	b=5X/yb+9RrvywqHrw+RqfEBu1TbdhhaAw/iiCxDhurf/GazijQxNaJTaxw/+KsbBndeU2
	 pS3JdVhWxj/6D24S+WUee6J7acQonsnkjSfS2VXeSG2Ju4Z8RWTo9PIsZuVHI5ptf7EnD
	 ZmT/WfAvu93Nmi2yLSnj5GMLrmCC3CQnpCbHrvdixrODkfWGAPDx5C/0+p+F5/0CJdAHj
	 J2w0lkkcBT4B4WzG7SBbwZK3eyXjoWE0vk1AY09EVgjWY+B6gT3XWDcuieg6GJOdpDI9p
	 jblZ0hIkyn2hp4Vpw8jwR0/Y2stj+pgOFhddAd95Mt1eYUPQIy8bZT/y66xW1vc2+jg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=outlook.com;
	spf=pass smtp.mailfrom=outlook.com;
	dkim=pass header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=ODwWq0SC;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.2.49
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazolkn19012049.outbound.protection.outlook.com [52.103.2.49])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49410606A328;
	Mon, 26 Oct 2026 16:57:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 49410606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=ODwWq0SC
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UokyDRY4Sho2wloj2Kapx7jaHXamf6t7a09LVT6dSzBOQp+4qwNsjlR4xQatRotNTncuJN1YpetQiBtEJPD3ngD739YVuwaI3+EKSaGP8qn8WVpOBuPyYAC2PmjPOrY65eKlPbwd8Oi24hKRewO5FMkEOuu1PMPNzSn6e+8yxFqAbMEKNYZMZm/51Z2b6hK1An6QXoDOwa7/cneuQA/bjxLG6Qsw85O1LJDc31pRrDV/Akf3/CCPbFnm4gv8DgXQqr+wx0F8+5f7bU/Fu1H6HrcyLJlzAoTri7sFOD/yZhpmnMMIV2cxcY5cMPBDQ03xpyMuS60sgFm8eUN1qnnvcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eCrqIJbPWfy+8HQX56wOSy6vCCBZ1HuxsUB6wzktAaQ=;
 b=wco1YCms6FD52Luihx3dpCe0mG/6RgLdMprol706tfjFoJ3FFlc8AiL+6w0+ycNp8xfwXV30Wwrp9apPFXQmbV/iVzV8NcGl2SnGYG2eKTuuO0WqOct3BEWYNhyrwke49wB2uZBhC6N7iZnkZqvHYiU3fEmw/og4AG+3vik6l/w3XjfqDyPtN6WHL4+ScCXgpQ9TgqZHvJ12R6KFC6U+jSRwK3u6LvFc1X/rVrvyOKcIA2IiAk4rGYdE8IkS7eOqMSMRtDabVVZKFYj/4dPNNSJw2Kp2Cr3SM0OAJnSa011L5yLZ4CkyWNR5UO63qOBEKagKwVo/Dy7mm0uzfGHXjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eCrqIJbPWfy+8HQX56wOSy6vCCBZ1HuxsUB6wzktAaQ=;
 b=ODwWq0SC0AGlhFwbAn7q+LaxJHCAPuPNQItkAclLUoVk6u2xjWK+Q/wHnoEqn1ET/l+stsey5zYEoeTsBrPIU7pf2GRRKSZMZxmIjN2+vzDFKwH04AXyGPIdRIRKO4a2Ymw9hKV4FM7eaxgYTv3YIBRKYm8Nuk2ncPdzUjrcR0S4F/H2THtcvuZcCgaUNz0GW15qRnYr2cLCFKnWXK8tQFjCeFR1efKXtK6e9npIoam3ILIiWROmuH5T0CjmitK6E35v1qiII3v+jfUlnXk2OwbOfFRpFVCOEgQwC3tynk5JdDCXuGe0V2k59IrkHxcOGTt7pocxMKntei+32RQcnQ==
Received: from SN1PR12MB2528.namprd12.prod.outlook.com (2603:10b6:802:28::33)
 by LV2PR12MB5726.namprd12.prod.outlook.com (2603:10b6:408:17e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 16:57:26 +0000
Received: from SN1PR12MB2528.namprd12.prod.outlook.com
 ([fe80::9875:58c0:928e:cf0a]) by SN1PR12MB2528.namprd12.prod.outlook.com
 ([fe80::9875:58c0:928e:cf0a%6]) with mapi id 15.21.0546.021; Mon, 26 Oct 2026
 16:57:25 +0000
From: Victor Chernyakin <chernyakin.victor.j@outlook.com>
To: andriy.shevchenko@intel.com
Cc: andy@kernel.org,
	chernyakin.victor.j@outlook.com,
	dlechner@baylibre.com,
	jic23@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	nuno.sa@analog.com
Subject: Re: [PATCH v2 0/3] iio: cdc: add Texas Instruments FDC1004 driver
Date: Mon, 26 Oct 2026 11:57:16 -0500
Message-ID:
 <SN1PR12MB25286FBEE01AF6D772B1A544A5612@SN1PR12MB2528.namprd12.prod.outlook.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <at8e77xcrCAxDiWu@ashevche-desk.local>
References: <at8e77xcrCAxDiWu@ashevche-desk.local>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DM6PR07CA0084.namprd07.prod.outlook.com
 (2603:10b6:5:337::17) To SN1PR12MB2528.namprd12.prod.outlook.com
 (2603:10b6:802:28::33)
X-Microsoft-Original-Message-ID:
 <20261026165716.121161-1-chernyakin.victor.j@outlook.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PR12MB2528:EE_|LV2PR12MB5726:EE_
X-MS-Office365-Filtering-Correlation-Id: 70232f5d-b5a8-415b-6baa-08df338235f3
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799015|12121999013|19110799012|260925184616899003|4140399003|25010399006|24021099003|15080799012|5072599009|24071999003|39105399006|22091999003|24121999003|20031999006|23021999003|40105399003|26121999007|261007181701699018|261005200801699003|11120399003|56899033|3412199025|440099028|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+lJWfh6argfRADXiQxT4vB9CQiSljVEoOQut0nkU2giqrH0T7m6G/EtkO4FN?=
 =?us-ascii?Q?oRzekTUVBM0EIfQ8Itj7gRXq7ru8N8AklzDYQdikbvuGulga6eI7qiqGD1f7?=
 =?us-ascii?Q?rY4bb25gwN2Zk/s8xdjF2xpxRjn0w+iDOuhuxmK3Lb1LFXBu0bI2GcljSkrd?=
 =?us-ascii?Q?GMttpOKmcKo5KxWg62BLNU5jQLioG4Er5Q/zaafeK4exyTxxHlt1nFkmLDaR?=
 =?us-ascii?Q?DXAbS1XbxFnn6UgxZ+6bDI0rUOf13RDIoOWVtu5J/J0kaXGfA/PCumIeF7VD?=
 =?us-ascii?Q?oqeNeGuhm448kolbm7ckNcDf3HCECWsK+hIk+XtCcRj8EC+TXn9/SbZWDJSY?=
 =?us-ascii?Q?lVkE29ezJrU1dWA2TnKdUrOG38YB4YIN20NnN4/xUonk/yNvV3qX2pb2Wag2?=
 =?us-ascii?Q?sLKRvRDGZ72cC8yABeMJFlQQAkCpozKBiJu5Qe5QzvA9AsQEKcS2EgoPVa97?=
 =?us-ascii?Q?gDFaGDgQ7HZyNwrPMLylDLfz3tsdTa7AIWOoWQ2MQzt/xLjugrfzXoSQQldI?=
 =?us-ascii?Q?IN6vXSfAFp8vqKHWGbEEpGe0yqIX33/UkO9i61N7AEGjwXTr62vtVwKWF0Lk?=
 =?us-ascii?Q?I8cFdx0wNb0ckbkkpdUhbfkYs013IpI/72oJdVS2jgREcAnMwKuYd7gkSK1T?=
 =?us-ascii?Q?nzOJA3wF5ILaBvUqWUIa68xRfiDximlwpXXgmk5SwQLy2YIRQU7b3j8+OIIt?=
 =?us-ascii?Q?tK0QlNsf8X9MJJSPDuyCaio1BhwQbPUyMAr3JTYBLlwfXZNcXfoIjMNJZn2M?=
 =?us-ascii?Q?1xdFkRmQY7bHR9qplF8/Zsalv5lHFmV17/mD3tycB9fmFXsWDLh+zFmdo98t?=
 =?us-ascii?Q?Da81yA3Q+WZoNTB0AFsReSy0vm2SOmO8j/kW3Wwg0KT8a2KW+S1IlpyAD2tO?=
 =?us-ascii?Q?7ReGJ5F+jQFa4BjmWkGqMSbgaat1yz0XWBRZfrNfZbTQxYUsWKsqyXvcI0Wi?=
 =?us-ascii?Q?k72coVq1hUbaS6zsluiVDbF87Z9HGNthcNKp/ZEl2rxSsUmhKqUFkFzjlbV4?=
 =?us-ascii?Q?3wdIl9qt/0Fu9F1xjOvkAGk4aiMgp9CP+TyRs6IYwJuRTEweYtu90aQSy78N?=
 =?us-ascii?Q?zaPA4rOAdf1+mskNeaG/oKO43kaXf8RXYzHQ5YcbcJF9NrF93mplOCt+Esim?=
 =?us-ascii?Q?q32XSqDhxpaCNtDUzM/uex/5UEM6DXMtYg4gOt9zZhD7tjxXdGZN3fN6QNcr?=
 =?us-ascii?Q?/JfXPJYRryfX4GP7vDNBv5ugKZDMVYxd4bAAxA=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?55J0Mn7CTkEuwK7Bgmr+/7K82td3fA8Htvl+d9T2PTbPuTO8ZCvvWeTCNFaW?=
 =?us-ascii?Q?FHkGb4/yepf0yzzJAwnTYrak0gHOC3WaOBCjvtnoCBSWvfyPlbwcHv/JLFJc?=
 =?us-ascii?Q?dzJkAz1erIkCS8R+YjJ9EKTMc5hu7DyLYCgmFxCJOxNsEXuBmSQh683NsspH?=
 =?us-ascii?Q?Bi8+KS0epfoLXICTATZrfo9gn8Zq0vPXTELte57iCz7hTvSOzE+XH/5zOsNR?=
 =?us-ascii?Q?PlkizlsKxThYPrsjb9EKkJGncxzc6LJ4ky/3h/jr9nZNFpPeaSV24Vfdl9qL?=
 =?us-ascii?Q?6mpuOSsc+rnNN2odaNhXSSkYOQ2/+ZhSrvk4k3DP/pmB0RgGLLnpFtIC7Wtt?=
 =?us-ascii?Q?d+kTABy5H5gPzQXJ0zosCsOxTL8eALmXRCYGFudINr+juOOf4yKp8tr5xWYI?=
 =?us-ascii?Q?JSiymzHZdEUXNXl3tgS0naMGNrf+X5bFt1o8OEPOWL9rKddYP6chhI9iUALN?=
 =?us-ascii?Q?zDbIScty7Phfwv2weLZHGkY2GgBAku2l8MRhxDx7fe2IgHEqJMBaQBkw3fCz?=
 =?us-ascii?Q?/PeL/thzDWKmWCSxMeQPBFJGGpqkeYKu0dKcQzRNsZD0N4PFrNPHpKP9WOeO?=
 =?us-ascii?Q?NRi+6RCuYq2bmjq8BOK1TgzrZzcxQA1DcFQUNOFU2bVJa0q7VV76XsYaKz08?=
 =?us-ascii?Q?JYg29l4Xhhcr45V1Ce67pQtENWwaonpNlK1ilAwPCJxVyvZXtAkXvbiMmc9N?=
 =?us-ascii?Q?S3+vHiIv1PIMYQiNwJd+Vi7qzUwy6EQ8mDnHF+/MtZ/hMkowU6Posn8qkmPe?=
 =?us-ascii?Q?10zWXaRXWcx4+xNJoEhae2NOa8IGW9pg1XDXWWN1TBYCyKjF0WzE8yUEpHTs?=
 =?us-ascii?Q?pn+uJN0jglPIXHNDngwXNJYBCLTCdokEVauuOO2l+ONQT3rU5ukSrrdpF0MH?=
 =?us-ascii?Q?sigziW9O4QFUbmTwnDKs2eicwZpGWlKarSpA+re0pUtxvmYuwsv580x66X33?=
 =?us-ascii?Q?1rHGaQAFiApBIa+h/cCWscPd/VI0avMXni6gkvyBXprMrSjR+3nRKIKgce5I?=
 =?us-ascii?Q?+eZzS0qPH94t1D0dU/magDQ90h4YDq0A3tDrjxgLwTaZrE+7IvBG8pirgcnv?=
 =?us-ascii?Q?Udd6t5mACxnGWXMqKpaQS17jHQ8DhfXwf/pvpfBwIsWxtPIuDqXWqsQ+ZQsO?=
 =?us-ascii?Q?rA90NS4mFNVPMYyxNByP65vVJa1P5X0KmszlnWCF4KrdTHmHAu0HGH9+hkkv?=
 =?us-ascii?Q?UjZz3IJ3wBJhhGFs/55mnzBChPx7E9Pfx2SiRKej41CyYVb3NeAgaaoe97V8?=
 =?us-ascii?Q?GHKCFneEsG3FA8+tnHiQGyvw+oECTEzqmlbELgOA5ruvFahCVClUMqehbD4z?=
 =?us-ascii?Q?SG88qTV98dUE1jg4E7TdvmK1qg5UOJ24V/sRmkUWMD0O79OgKc7ydNkj/iZQ?=
 =?us-ascii?Q?4NddCmoP0XGTXYM3VLdLp04elRci1Utxs9ttFMvFaWKUVHtU3A=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70232f5d-b5a8-415b-6baa-08df338235f3
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2528.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 16:57:25.6859
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5726

> > > > Changes in v2:
> > > > - Patch 1
> > > >   - Added tests
> > > 
> > > >   - Added a fix in iio_format_value
> > > 
> > > If it's about abs(), it should go  in a separate patch.
> > 
> > This is about both abs() and working around overflow when
> > computing 10^scale. To be clear, neither of these were problems before,
> > they're directly caused by the new units. You're saying they should still
> > go in a separate patch?
> 
> For a starter I'm saying that changelog should be more elaborative.

Now that I read it again, "Added a fix in iio_format_value" really is
quite vague, isn't it? Added more detail in v3.

> But conduct a small research and check if it's possible to split. One fix per
> problem is what we want ideally. However, there are other aspects are being
> involved (in all steps), such as code readability and additional churn made.

I think it makes sense to keep both iio_format_value changes in one patch
since they're so closely related, but I've split them out into a separate
patch from adding the new units.
