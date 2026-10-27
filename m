Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.12.27
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793090184;
	b=kg3sm2SbuXjzFbeoapzbyifc300HvHQBkrRh+txgy8u/Q1JeJUEzgUA4YBWBonQVyC6r
	 b2cYE7LrSLLScxKH2sZanjvA2BNUw4BjVR+nbg0p59gLIyUCuHixMSCoXZ5SBNMC7Rded
	 hcXu9Ke3LHqVbpQjpI1qDDO61qFHcIY/b658dYxu2peUpnW4tJvDAdb/F+sU1wE/xUQnt
	 tk6QnNuZVHYjtKYf8jtswGBeWO1oAcMnX9sCeLtHTX2TxnMaDtogodz/ZysOoJX2ltWyw
	 aBoV/itP2RKs7gX1JfEPyrWeLu6h/4DIBHK/vZ6ZzuJ/GL4Uxmd5e3Xq5lw8ZySFnnw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793090184;
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
	bh=jUI4BtyV7oqAwEaaq55PFcGweuLEG1yZ0pnVCT0TpzI=;
	b=KzfXj1peK51e9ird8fnJjJj7SLCvDr2iB5gNo7X8y82pUoR9Ak2SRT++THrJjXANeJpa
	 k/pPe1GCRKnabywsphFMH3texS0yLaVlPXD68w/iNkucrG71llz8qRnUgwSIxQKlenFDc
	 0EE6PBBIMC/iFKJzBTpXMGG7QmW5ysZg7uP2o8yEuFCl6mlnZYiW3hcapyWWDQvmEjqVe
	 ZHBcGny8xscF5CA9zbGMNGwCW5p9LuytsXNUpU651IzuUD1tUk6IW5uJ67Fc2K4M7D83B
	 CaJ0byO9Af2BTXaCku3iCFligxyE/as4RiWHPwo7aQ6/zPHJnq+QweZ330upz7omenw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=outlook.com;
	spf=pass smtp.mailfrom=outlook.com;
	dkim=pass header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=KEuzxuIU;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.12.27
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azolkn19011027.outbound.protection.outlook.com [52.103.12.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A04F606A33C;
	Tue, 27 Oct 2026 08:36:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5A04F606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=KEuzxuIU
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jaUUWeKf3UVWhN9mbMiqH3FFMtuBcr9+sEO2XMjn5rIAP+gzU7NzkKbpo0BjbI7qlYPeq98h/2vf40QMJWjpeHHoScZJHb/zeD9jr7z5iVcL34mVcZSJpCxW6AD4wVqYw9MNFNH+3tR3Gp5ApnncK4b7vIa1EnEgLsKWCkyIKkLDdkCMli2wZpuxQt3JD7HjO8fEARKK/oD8JZ+XFDLW1pLY3WuU2c3/75p3TR8XHjGL3yNE2J/XpAtogVIlP5xVR6GZW4tvtX24QrggMlnE/IeC7aFQ01O/vBpLus+gwvoljajruMfP8yqnaygWUyvB0+PMTDBm3sUK7faWx8xQhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jUI4BtyV7oqAwEaaq55PFcGweuLEG1yZ0pnVCT0TpzI=;
 b=O/srgBlAuxPCail/yr2vfD3N/ly+kdUsLuopLUc67cdi4WoJMoHiEDaMCgnFlnfoRcOARG4x7nbYk2BxLCV6IYBh8jmNWxS0W9yHAPrMXQqty92TLCXDku36RsWpMvkAtJ8E/SoWkJxlohU3sMhRAmdTkJiRlrvDCPfPlqeEKikiPJ9NVcx41fOomx/nVgnQkFcpisQI+Y7oh/+HqaZh+89+knXgjpnspQZ21x85HyuiOD3g6sSh27BCN/DX0sia5XWkts06BpxuwJcGcs6Nly6oBsaDIEVQv2/Rw7hIApHLgOtMN2H+XQNj+9SAgPt9wR5dgVfKleeEmOzg+gdagQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jUI4BtyV7oqAwEaaq55PFcGweuLEG1yZ0pnVCT0TpzI=;
 b=KEuzxuIU8qmB0/p2FcYPT0dVF81IpqRDmpVNg1yzXa7cjdQqiRV9Wzo78RvzDJxzKAsUW8n6btat5ffMj3ENXOIAfXudt1030DEH2RVjwCbll4R286K+sg1Isvpl4kRLymQZL8G23ZflqHjBKkhFT3bHc9Ad91sKOtFa8qeDdRuAO/8kMGNZRPzpGXME3KV17OMcHmHBKw35LVFKQOugza9GJhCLlzTQEY47qs7L8evgtlCWB+OOHDEFlwuA5n+fNdZ2pJM45toRFYIyVmiEDCiXMBKpYczrTG0m5Mtp5iw5ZyYy0SN3j6yznSic8OKC9lFr/a4JB2rri1V5T536ZQ==
Received: from SN1PR12MB2528.namprd12.prod.outlook.com (2603:10b6:802:28::33)
 by SACPR12MB439974.namprd12.prod.outlook.com (2603:10b6:806:540::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 08:36:21 +0000
Received: from SN1PR12MB2528.namprd12.prod.outlook.com
 ([fe80::9875:58c0:928e:cf0a]) by SN1PR12MB2528.namprd12.prod.outlook.com
 ([fe80::9875:58c0:928e:cf0a%6]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 08:36:21 +0000
From: Victor Chernyakin <chernyakin.victor.j@outlook.com>
To: andriy.shevchenko@intel.com
Cc: andy@kernel.org,
	chernyakin.victor.j@outlook.com,
	dlechner@baylibre.com,
	jic23@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	nuno.sa@analog.com
Subject: Re: [PATCH v3 1/4] iio: prepare iio_format_value to handle higher-precision IIO_VAL_DECIMAL64_* formats
Date: Tue, 27 Oct 2026 03:36:12 -0500
Message-ID:
 <SN1PR12MB252856059BA9F5CBBB7DED5AA5602@SN1PR12MB2528.namprd12.prod.outlook.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <auBSyu-G98vfAi8H@ashevche-desk.local>
References: <auBSyu-G98vfAi8H@ashevche-desk.local>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR04CA0097.namprd04.prod.outlook.com
 (2603:10b6:610:75::12) To SN1PR12MB2528.namprd12.prod.outlook.com
 (2603:10b6:802:28::33)
X-Microsoft-Original-Message-ID:
 <20261027083612.167169-1-chernyakin.victor.j@outlook.com>
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
X-MS-TrafficTypeDiagnostic: SN1PR12MB2528:EE_|SACPR12MB439974:EE_
X-MS-Office365-Filtering-Correlation-Id: e8e8a098-b23b-473a-0518-08df34056073
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|20031999006|4140399003|25010399006|260925184616899003|8060799015|19110799012|22091999003|23021999003|24121999003|24071999003|15080799012|5072599009|24021099003|39105399006|40105399003|26121999007|261007181701699018|261005200801699003|11120399003|440099028|3412199025|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NmtHzdUUr2W1r0ekhoOVcYGeK5GCfH/yv9Ld0nV79FzBN0z5E3kgM1wIgQoB?=
 =?us-ascii?Q?/+zxuuKhDtkzipqQ967WAsxwkjLaa/uTHkfEDLb/c80UjmKOsM1DCQvSEtaE?=
 =?us-ascii?Q?7uN4MJM5bTcAm6b7p4CkWpwVdfeYfWcc8vEkmGASOqQUVlfu7ZSIxwVPUEbE?=
 =?us-ascii?Q?HqxIaM1fnS3XaK0F2HWPUUH/y7rqnHvG+fzJqNnLdrX2HBm4ENtnvBEazr7a?=
 =?us-ascii?Q?FDCEQKwhwVwHsgfdA+2qiHsvWlSt5fiD3TpC7c7GNSl7GB20jX6SIQGk7AUY?=
 =?us-ascii?Q?CrZyq7cSKGZIeAgiA4ZsBkXp5e71fzuwuXFhw1LzG91v0BCg3Nvhx+heByZ5?=
 =?us-ascii?Q?oz/nrCUAV6Xx1YKGgX9ONqRzZvmBsopqAZW0yyWRs+/5JdYWbzwVV/YXG0Od?=
 =?us-ascii?Q?bZfEqZSfgMvBBTstA5treMwf50SIeTpJ24MDoVBh4JjO2P/sxVnQ+BSWk9l2?=
 =?us-ascii?Q?zbukVtSOBZNiEWP9jJ4NZCMRyBrLZ3n/DRch8Km4rCQ4VKV+c1SLnfuj2AUg?=
 =?us-ascii?Q?D1vhjRimfg6EaEoU95GQv1lSzZqrslBlDxwj4dGPKRAZ3LtJdPgf2xp0CCsp?=
 =?us-ascii?Q?yf5iuU4bxZdwTM9Il/RjMQeRB0lQaULoFwiiZgCIivIy3AAHXMj1mNSBL6FE?=
 =?us-ascii?Q?QxDC6+fsi2SQbb6yY7nOItxndViVI1k/D94L6fGIapBXa8Pg53+W+KDr/pDm?=
 =?us-ascii?Q?vdGt90IxEhQmSDH4lNi45rq4Tc0jqd76rYtAG/WLmIyjdeE1fzn3fu/Eghwm?=
 =?us-ascii?Q?Md7kCjUxWyf0VV90pEEBvW+h3U3bcWO1LmtSnDl2OPtukRvWlFjUT1cQEIaC?=
 =?us-ascii?Q?Rl5Ne9fufJEfbEaFUjrKd02V9ZJpkAF8+6dYfMIUtfdOWOmUNhLKoA1Wtinc?=
 =?us-ascii?Q?9m4Sg1KRRN6UJefG+2AFuCWTPsYkwgRgegIthRHcR+6L2X1Q/IQsos14nWyY?=
 =?us-ascii?Q?yfzwfDrMhUh9XxPyhjMnEuxXnA1tPezbhMVo6e4m+2UPaGstzfwnIDLjjTD5?=
 =?us-ascii?Q?yb4hLSekNpdZzivhx6NZihHlXcU8lPCKw08CrU38yWqvsdtfnOyD1uu0JleN?=
 =?us-ascii?Q?6qRHKE9+zA/nAGjRsXzE9KwQca7EymOSv14I6TrFcQE32AbWTzWdLEBmBmI6?=
 =?us-ascii?Q?RRCjjJ0WZE8RPIKYCEXgdpcgq/8Mdg2pa/iyfL/CDuYgoaTJZEzZTyM=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hIVmOhNBryyCEfXAg6ncJ+6zCps9oXs3U1j5kxKrraxDmKU5RO3VhN+zL6wm?=
 =?us-ascii?Q?eL6QJjLqdPwMLAtcjBAVGNMOI8eBONgZyV/W/v5SruZdZiTpGpCSr1UiB6I+?=
 =?us-ascii?Q?NVASZ/6mWuj3NA4OXMMVac6J5jaIJUXNZCg+QrR7PJl3xgcctyUvaYhy0wWI?=
 =?us-ascii?Q?q0lVjjLiXXMNUwTlk00lcPllN/5fhDb/1bSTl/AFeEEmKJAAwYmt5xyw79CI?=
 =?us-ascii?Q?Tek4rRxpLHENbXnI2jAtr74Mqxum1YP28kNoseXWqVNdhokd6CuifibcPaXv?=
 =?us-ascii?Q?eIoBacQ4QLQAVBacCZ47m8CtTOVp0OjlFXeYfLBJgTk6xOLnVHeywrdFangE?=
 =?us-ascii?Q?JK1xGK3cBBeHKtxU0GqxTJ/NpUpjOb/6aEXBXqaZfbvPeTGRxsjK1SfqBx9+?=
 =?us-ascii?Q?Zx9Ewsl62dvLc5jbJoLrz7/kHme7bEe8pfhkzr/Ndzp9Pe9ljyUjWx2ecNNg?=
 =?us-ascii?Q?Sqz1dZc7DCu2KvUcuL9BPae5/5LPYCPpFaHytFuVWJPjNhjIgOFq8BELjNKS?=
 =?us-ascii?Q?wttgS1OcjvJz05lzy8+MTjmsiqkkFMjT3WmUXRQLja1Av11zpiTz2gHCkGD/?=
 =?us-ascii?Q?ZiDtESQtKpPAv+stRY2spfEZ7SB5VfzrbGZo8s4MaT33IFG/je1pzEflZer/?=
 =?us-ascii?Q?bJLYaX0rv/+Y4WHtoJgSPij+ELWeQluNKDBgqSCBjZNbFKqAOIZzCQa8opqh?=
 =?us-ascii?Q?KDzSL84QLgQl9QXoY9jPH0HNOwbVJlAK6fbpw3aQl5mJOJpI2f78FuLVJf0x?=
 =?us-ascii?Q?GTI61wFTxdxzgdixzoF9Zq+Rc2erwbcFyyi9gbQtzJoWqcEPP3AmYHoPGWmc?=
 =?us-ascii?Q?FvS8gpuO0mdjOdk98FKlWpnekdWXIAI+CZ8pD6LYyE+8ewfxpbQa646q9ouL?=
 =?us-ascii?Q?OOm4tY6VtDsR+x4r1ZNYmrbOw4pjcshF5+J7Mf0Y0DDfPrhmAYK9AIKfD+TG?=
 =?us-ascii?Q?bC9Aa37ekQsB8nMUwkJVSWDjTEdsVfM5BiDy+3Nyd0srVUH5NJxy95PtY+v6?=
 =?us-ascii?Q?4wahiqEZEVYzfuQp4nPFH9033GMQY7C2yaT9ye+PK76JN6j03nCl0wWghdT+?=
 =?us-ascii?Q?/okAUIP/fh7RGa5MtaxaIOG8rTsz3pamhviEMOD1g3xjfojszu2iiFnOgkxa?=
 =?us-ascii?Q?9eGwY/xZkkznXeSUYhPTPM+ftavTVhMmcICrN9SxI4FDqe9v2nKas61yHdWj?=
 =?us-ascii?Q?U76VPfYB7cVhx6mx4CG1jecqB5dMTebbvA9KMhTFYqrP7pqZ8vuwI2xAw0Gq?=
 =?us-ascii?Q?Q2MT/shZWPpQeAQ38asCw60yeYEmbdAhw0vZoGgbWymt19bPo9Ogx1IyUyi9?=
 =?us-ascii?Q?zid051CcogQDdK/L5fs8FNFgbt0uPrfSLsD695xHcR+9yYy/XXj/XPyofEu/?=
 =?us-ascii?Q?c8AGlrqlYRT/hx7RCC1vWx9xg+rPArjDiA5kXjmejdu4wjGUpg=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8e8a098-b23b-473a-0518-08df34056073
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2528.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 08:36:21.2800
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SACPR12MB439974

> > > > +#define GREATEST_POWER_OF_10_THAT_FITS_IN_S64 18
> > > 
> > > It's an interesting name for log10(2^63).
> > > 
> > > This, along with log10(2^64 - 1) should be added as definitions at least
> > > IIO-wide. There is a series that wanted similar for u64.
> > 
> > In that case, might as well go all the way and add them to linux/limits.h?
> 
> Only if you have existing users outside (which has to be shown
> by the respective patch and then it makes the series cross the
> subsystem boundaries, much harder to get in :-).

Yeah I'll keep it within IIO then ;p
