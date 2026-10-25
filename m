Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.11.20
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792907772;
	b=od0FxXHPBYqABGWg/gZjXKdDKszUmkAn2IoOay9uBosDUQlq9/je5WjWyrpCrGNdagpz
	 pCn6hvBxsNtkfIXBHs0VdsPrZocHX03ZSr1qx1mekRZJMofqm3+QkKYp5MJwRiuL0YIFA
	 htIPpanOzzz5Sotr7GWTPaeF1iA+VOrj6+gEu/qPnjbfb2mrW14Cf5mrxA9zX35z26caP
	 dg4N9uvpquOhz5VBQhywCwQwB16yCCpmXPlNbmQhrYSt1wthc86UXrFodKZIyocJN6lzq
	 8ZioE0MpbLE2OXi1kXYLF9EWhybQ8JjGyhMeMGtHFRKP9YCubJPqPBrHpbnqbrg4Ezw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792907772;
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
	bh=1lUlBFNrf2X7m1R+2vg1/7Tysy+T33s/5x7/yxD+7+c=;
	b=LdHKPxdxMqqC6p6SYPf55axfiu24EQ691l/tVi5tBGYoZ6p/FA+0KIa4vbvm8ohG7/3G
	 4KRl9fMv+58bIMgs+cXAb1w0oUdk0QmNkIJ5h0y65jd0ZohUo+fPVldyGECSP1Sg/E/rh
	 gW4AzbePOvifCoTxZrlkLbu7lIigggQ2AK+mP3I59b62Qc62EM/xZfj/PhBv7rBXrDDi9
	 injX4/kqHfAvIUlQ/t3VSLOdqDSi6q397gmS73EFHIaaRnogqxPmTtmY0sosxnKDtsSw2
	 WW836qpZVo5WDpMHHOymxqVZiwrlzM/FmZ7cOs2+HCRxzT3hjLEHyC6CguMwp4/rXkw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=outlook.com;
	spf=pass smtp.mailfrom=outlook.com;
	dkim=pass header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=Rh9R9yC2;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.11.20
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazolkn19012020.outbound.protection.outlook.com [52.103.11.20])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EFC3606A31B;
	Sun, 25 Oct 2026 05:56:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7EFC3606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=Rh9R9yC2
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=omt0WKn8FU7ZBA0Zk/4SP6q/4KqRzD7hkR4OEPkxGc8Ta2LUmKMqoucI9t8S+mSqz6vgJS5lMaqhaERD3PVTJOEI7NzvgLVohN7ctHj3UXgM21ykKb7hbJCrx+C5OQEaiji4xFH+6epQWKaA1CXeOlW/3l9o3ovJxOb2UnXWSiVhUam8ly4+21qkzV9gyzRYPgqp/R9XGfAvpRepdL5yvOeY2tuGLVcYdluZhcnJP+NOhhCsfRYop5cu4m75cPDIX47oihpulaI2PW45REulZFksAXl8BuhxhknL+QYip+K/b6bVzQQKNlAhUefK1uhoOoaJRMueEzv0tlFZRk4fAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1lUlBFNrf2X7m1R+2vg1/7Tysy+T33s/5x7/yxD+7+c=;
 b=KdbqfI5nIlqy5vbIuttRZrQrpRHiwE67gvojOEg0ZC0OEKOM5+XJ/xhIFuIpooQ/0sizdIems8hFT1CIRjZ6ZLaBhVzt75pFWN3KVxEjj63pbHFsiIbe40o3d6kDvAojmZ523UJMJ4cmMCuh9VU8xjJKMJoUT6VDfvrWg+LrAzbzbH2e5KEEqULdONOQQ+wKfmokmIcUAohbBK5qa+JZILIOH0FxQwLoQni0YQpcn4yPW+32PMyrZwQ7BQCE3DTPZ79XgXv2e66cBG+ProLEARrqoB7F4sPdsPx+Cyxtsf0K1b2kQYMobGtJKl6yNfMUDJbp1vVheaehak7oDMwxeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1lUlBFNrf2X7m1R+2vg1/7Tysy+T33s/5x7/yxD+7+c=;
 b=Rh9R9yC2q33eC8hMFNeOEtVbMpsC4GyZWTaLLUwmi4cJn611IyfAyc71io8NrdqYfBvxWzH1FT5MwWVa0MY4LByoVV+4a+OyQ1gllz+ZXKkWPdbCITtulkx3EeJac00W2bA/sDCAusO6TUzNlnysWVNPNN6sZA/APH3X0ypbC8mHo0W7xwczm2qr/rTIjx5ZGCrvlizodh/dQk9lFiqFnNFo0HOcbxzP29HQHKTkX+eDzQSh5GEqjRgcQeNmDRmIT7CVqaNSQoPhQPn1Xc/cVHbRMlleJQcMlDP5+m1n75AXf43Pyf5x1D9/zd0ySLs7lNKnWdMu/JnDqqiAkteggg==
Received: from SN1PR12MB2528.namprd12.prod.outlook.com (2603:10b6:802:28::33)
 by PH7PR12MB7915.namprd12.prod.outlook.com (2603:10b6:510:27c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.20; Sun, 25 Oct
 2026 05:56:08 +0000
Received: from SN1PR12MB2528.namprd12.prod.outlook.com
 ([fe80::9875:58c0:928e:cf0a]) by SN1PR12MB2528.namprd12.prod.outlook.com
 ([fe80::9875:58c0:928e:cf0a%6]) with mapi id 15.21.0546.021; Sun, 25 Oct 2026
 05:56:08 +0000
From: Victor Chernyakin <chernyakin.victor.j@outlook.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Victor Chernyakin <chernyakin.victor.j@outlook.com>,
	"Jonathan Cameron" <jic23@kernel.org>,
	"David Lechner" <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	"Andy Shevchenko" <andy@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] iio: cdc: add Texas Instruments FDC1004 driver
Date: Sun, 25 Oct 2026 00:55:25 -0500
Message-ID:
 <SN1PR12MB2528B54E68524DC62C378CD7A5622@SN1PR12MB2528.namprd12.prod.outlook.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <atyGxFmgv85JUTls@ashevche-desk.local>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR03CA0079.namprd03.prod.outlook.com
 (2603:10b6:610:cc::24) To SN1PR12MB2528.namprd12.prod.outlook.com
 (2603:10b6:802:28::33)
X-Microsoft-Original-Message-ID:
 <20261025055545.35153-1-chernyakin.victor.j@outlook.com>
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
X-MS-TrafficTypeDiagnostic: SN1PR12MB2528:EE_|PH7PR12MB7915:EE_
X-MS-Office365-Filtering-Correlation-Id: 55f59266-c9f4-47d4-7f3f-08df325ca9c5
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|15080799012|5072599009|51005399006|24021099003|24121999003|22091999003|23021999003|25010399006|19110799012|12121999013|8060799015|260925184616899003|440099028|3412199025|12091999003|40105399003|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IME9obIjM7+TnpaDKy5tJED7prINfXEVLlQuXm4T5ZILqOUi6twajV8Lx6ji?=
 =?us-ascii?Q?Syh5s9rk8r1t3J9hvYeZ4rJ/keQgy/+8ZaI0BLpv7Kabsi7wGkkaMLEe+6Xi?=
 =?us-ascii?Q?olqGyJd6Fc8qNSOFugVgRyHpXdCoWDcVoic15CDAKecpK+m/9RVFQJv4SgzD?=
 =?us-ascii?Q?YgJ+fKZ+3QoKghPCfMGIx6FqKzglZOxG0Vysd8k522XPkrPo4XjBTMt+lwBD?=
 =?us-ascii?Q?QYcyhJC7hPTae1V9vsCtvbf192Imhn7dXqbwU/Hh/HhuX4Ce644QYhdYdIO2?=
 =?us-ascii?Q?r9IrldZxtO2Ee+TNa83rfVpHT3l3SrXWafoXtqkbqWKOo+1VSt+BFa69zFjd?=
 =?us-ascii?Q?hWiFncYPRkZfpVf1UdEk6Q2soksAtd6Ub6cy0Anqvetr3M2J4ZOgJXbdw1PS?=
 =?us-ascii?Q?BQJs6W/lXGNqakrH1IVYy3I8Pz/Xk8zRdCi+x8NWRkKWapR4uu0Cab7sGylH?=
 =?us-ascii?Q?9y6s3OY59C6pd4RVrmZ3ktYrMIvu3v6blta/DiinfWHdY+5XH14iVFFVvZfk?=
 =?us-ascii?Q?/3yH6rcv/TTSRzaOiA1JhOptY2sJueqB0WJPNNeH2vgdGszTuuCme3ErFQAD?=
 =?us-ascii?Q?npOsTou/LKGtTmuocMXGJmlpQYbqE4M4xeIn4xof5cHTTA2XOGO69SOGh8Wy?=
 =?us-ascii?Q?75YYa6iE/iws2JvEc7bb9Uwikz0YIBZbxBUEvrwBQltg2RWr92y2Hc8xNtKi?=
 =?us-ascii?Q?YkfKkGMeQ3ESqV0Fgo6m9mHAdoyT9QcmEV636RRDzvyypGS/BrvPBTdx9eal?=
 =?us-ascii?Q?9kb4iF0Ialo40Ph5nxIU7txzafMznLVFgStI+wIXry+2EmKNati3TDJc/Rwk?=
 =?us-ascii?Q?cn5Vw+gRkdgGqaSrBWWk8HkFJEin+//jMYa1LvOnQjmeYxkf2H6gNfdd5ZAW?=
 =?us-ascii?Q?dpoyA5STqaGlzu7NLy5WCUVn12uN966lkF41VcxDtoq6WxLR/k6ZAD0SWlFP?=
 =?us-ascii?Q?dHxcjl+esaJjnP5eOU93B8yBu/PS2kD7+/Xp3owsTO/7FM4DEWomliyoM2ud?=
 =?us-ascii?Q?exfBXhz9yoHM1bU4oAgXdMWC18xMzQDLnOWwicxUnv1+3WNrQYaljwHJXfXT?=
 =?us-ascii?Q?9cbDyuvfKQeBADd35Z8ajtcWw8fBkg=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WFiXiiS5feBayTCptBLQj0EjXW77R0DvY1sWnb8avdNPq7uvywVp2+NzkffB?=
 =?us-ascii?Q?vmuBL/1dNYbuUHlGi2SioIbZsVSmULzbJ92neE5O4IaaguTV1a6cPiUyyuWC?=
 =?us-ascii?Q?YDj7wU/ZoguhbwyznxZ61GlOQWkqC93gSkXC6KzuYd0xEbQBzu96aFBX8Pvd?=
 =?us-ascii?Q?oujZQO/1JspX3bY9cG78zebg//PtQtQAkR+acEEvys84AKNSMpAS+Xk+WESY?=
 =?us-ascii?Q?ZHVUlbsEDbQ52Wv72oq6jH8purtF+mDqYzUgkCUvmwTKZs+FXNbHj8KNro59?=
 =?us-ascii?Q?nkDE396HgCsGhPgVAI2ansV/80s9jlAAVsPA0J6oUp0GOCFoobhC7cGxxn/a?=
 =?us-ascii?Q?BwbLlV7r5EXwTruValxr91T6zpqF+TiK+VCdak/29rI57YuN62sUJ5lL6RbL?=
 =?us-ascii?Q?nPEtWXIvtlsyx7M8qactOrjWuWWUqiKUHA3/lgKgHozgniwKOUKpYWIWsQxG?=
 =?us-ascii?Q?64ZmQlGp91NmkfCuKDMbrzCPYE5nsSz9SkPd0JZKrZiFs8jIrJ6PbEPQmsKZ?=
 =?us-ascii?Q?uS8QTYHO034uoB+WXgZQZHtgsNunu6dK7tkd1owqxWvs0k6bxAJQzVoNZzT3?=
 =?us-ascii?Q?wljRBL/rgf1O931kfW1f9zCjOKI3xtCUncjwqTa6Ic90golghMysqDaAzlOO?=
 =?us-ascii?Q?ZdfhUfgyhEtD+5We7+W9oWFon+Wpm68TNdvq0jMGs8FzllU/AjyIfGZjzYpF?=
 =?us-ascii?Q?QkLYhz/PZZSN0FJHkGzMYKTJolpgVXwuWqp5RujyU0gnXjGxLFki44a9oehZ?=
 =?us-ascii?Q?rA46f1QvIQm+Z6PmgiICGeL/d9PLsIHdeORJ7QDx6ZPfXxSY/nIT4m6Ujptl?=
 =?us-ascii?Q?ZHX01sgHDaMD3Je9QiluQuy4HezKRMLtw2p04KkkzHWIi9pULEBf5px4E1Ln?=
 =?us-ascii?Q?Ad47baD28jqHd+pGyIh+ajQCdpoDmdo6YyNMkpbi7VBLWaPqNzcsGrsM5D0F?=
 =?us-ascii?Q?PNChWRuqGM0I3Jf1lXtY/ON1asCo2TlskV8vcnUz2XFKJsELfe66jGrRjzxJ?=
 =?us-ascii?Q?/DPSTjMVEewS5odrUucWfWEl5fBYiYXB1IkR331Azi3yp9auRrr7sjeAtUZl?=
 =?us-ascii?Q?3tvBEIHmjIRMsWe2GPvy/dnEaG/LKY92kWAyCPUi7sEGZvDsL+fXMStZZIsT?=
 =?us-ascii?Q?G8nZsaS/RiODTqLF8FKAC0VNvtdndxKBSVX5h8bkRZEiGA7f0lGWrpIa7mbz?=
 =?us-ascii?Q?GsN3EzP5ac+7UOI3UBlig4tMQ6VfAdRJ5yzg58F+Bz0w5lFW4SzSz8JRQuK1?=
 =?us-ascii?Q?VVC8+xYq3vhHoaNw1RO+kWrhqNsvX/oaAV8RSP9vsdpJJKa08S3BBe1kphuB?=
 =?us-ascii?Q?F1IHKlwjGv61kyFPgwm5S9wLqJn52gpS+7i8Ng4cN9RqsIbIaGZbjNi48x75?=
 =?us-ascii?Q?hww9oQvxA8Ux+8nucjbVXRYZpL1exsPA4WCuYG4PA+m47+Cpcg=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55f59266-c9f4-47d4-7f3f-08df325ca9c5
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2528.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2026 05:56:07.9544
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7915

> > > I'd look at using regmap even though you only have a single bus. It provides
> > > a rich set of helpers and the caching functionality that will save a bunch
> > > of bus traffic.
> > 
> > Ah... is that a strong preference in new drivers? That would be quite
> > a bit of rewrite work...
> 
> Yes, usually drivers start being looked cleaner. On top you got a few benefits
> of regmap for free (cache, debugfs, tracing, maybe even more).

Alright, v2 is now regmap-based!

> > > Looking at these data types, can you check if linear_range.h APIs
> > > can be applied instead?
> > 
> > Doesn't look like they can, since they only work with unsigned int, but
> > these values are s64.
> 
> The types in the software is a result, but what is the cause? Do you have
> ranges with a sign?

Yes, fdc1004_calibbias needs a sign.
