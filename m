Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B616340406;
	Mon, 12 Oct 2026 10:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791801259; cv=fail; b=BuJMQmnI2Rpd4rPksM3MJAKtEIFHXYBxGC5dvivnhWCpr22WPK8ZajeB+9RiBEVjME7OPz+wl04j+2tvHgFBCynbjDtc0U3Pgk+bkfFSzPOl/YSiWvkPgdjqZk16JvSeuZV73opeS7EZpsZc9LeQ3qkn2/Qly8meJJuPDYXIUC4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791801259; c=relaxed/simple;
	bh=6wp+nmi+yxfBC9GfEpz/UCH1BhUt856/6YdCBwlFP0c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=F03siPDh92PYG+6Rkcdh4QDeTtqlBJukyUQ5pHOrB7BAkySBCx7i9J2+SCwy9c84DjSE1aO+udgVlZVmYJd/XVslYkyBnkbWOVIcYaTz9Zn1Pju0kByjPjXork0F6bv2depA33wW82XLQ4oom2OWcKaoAE1+zfl5XKXKH1hcMC8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b=e/9DGzfA; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=1oBDmGMC; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b="e/9DGzfA";
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="1oBDmGMC"
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69C8angn1711698;
	Mon, 12 Oct 2026 06:32:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=bqxsWz+j/RlRHxrxQaM5c1vr7E7TSlRLFjZpXoJSNuY=; b=e/9DGzf
	AMYFVOS7f8lBuYfBlffGNhqkdmVnW75L8NUcFLHA+TNFkLSti9jN/17mped2ZjOj
	ezlykGF4feVtPLXQW1dCaoqA3HnnrQJr1IIgj4/w785W/wXe6MMSk6TMuoE7q1Xe
	rbHfFO5laB1ILDlcUHZQlJ5bKJg9gODIj4CuJ0qbaxgw4+407smS8sILy28TUXLy
	oKtZ5OclTlP1aGthwoldtK25VQTCS3uYmQTwXWWtX8zqT+KPLGIEwQMYJqWw1Xmq
	8TInXQkFpPjDZ6ZAFSB+cnBSdvTDyBk4KeacCL7/h10QeUOowC+L0I4DfFMO+QWk
	c2dW677vKH78eUA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=bqxsW
	z+j/RlRHxrxQaM5c1vr7E7TSlRLFjZpXoJSNuY=; b=1oBDmGMC9JsE3pXbsc7mQ
	lVlbb5RwZQ4gUk0mZnBJhV6HOc1/gAb23JTo8G5IfA+2E/Gh4gHOZtnr1DuVjJe8
	FB/HQxfDEYriLD12ZsT0b5DdVV+ARTMV+4NIj/0HK+bctfJyalzQVqBXKoRNTv4Y
	H/X18Qr2DN2ZvyUQgYXfHcmXl5VoZNmwF9GOozSXuPu7OQT41QKbBzTnTb0LhKyo
	W9mNviRBmb+vNwPl90VW1x4MaxqC5gyT6i8E7Qi4DenrqHOE3+tOLcdRy6vpNNXv
	bEdEJMGlkcO2HYQOangIpTAn/IBFwk09YsQDBFCytjmKon39oRW9p2pDP4gK1k5K
	w==
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010030.outbound.protection.outlook.com [52.101.85.30])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4h8peca1mv-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 06:32:28 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RfgD/J7q4r8jtD6iuM+LZXazJFOZlzlbCJPjAau5UOhtVC+FvWd126Yuj8AaSWLLS3iAQFR0E+ci3RBTaogE8HRFhgo4WwCV/UKPNvvbauIbvrzeKS/OGmG0f6zi35WO6Uk0EE3xf8vCA/VEDcnYOzF2Ra/Cn84TxlEU1iTeD4nwoxB1vZwI99WclHAdbB7L6ubJHx0qNHA0bdcNmbl3GDAU++rc43h5qD/S/K2/bfKld0anUfeMGy+eA3Wc8586RCWZMpoKzV9L33ilQbM9PsqVD6IdNCClBBBeueA53MNd0OQ8qZtGnBKc570KycRjFFIH5KmoylkgdlbZdwYa/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bqxsWz+j/RlRHxrxQaM5c1vr7E7TSlRLFjZpXoJSNuY=;
 b=ZlIXjzrVQ85y7J4GWwbbb0aPwrpWYaL5w48zM/FV3kx+neySTcYVWys4Qg1LCIWb47VLlqMzEyto3rzQQM0ujTZuOYGy0gbeVytbR14egcmsjdk7nYODQmxEkwEW9aXSkXbrzmQwsyniPlfhW6NlBxdfTTX3df4kt37dkExvt5NW3Ozc2vP7y3hGVdIp35LCqlH4t9O/dPWcuQoYZsdnyTBo1uAgpkEyS3GSC4X01QnHecjEF7Uqbhg4z1Z7bZFEN3vm5RwhsdiTC4r/AOC77zKaw+mMEmcLXKsSNgdS+ZvfphLifRTtpR1L4DZAyC8bD4TG74nCWDScCTlTjkSHdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by BL4PR03MB8040.namprd03.prod.outlook.com (2603:10b6:208:58e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.19; Mon, 12 Oct
 2026 10:32:24 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%6]) with mapi id 15.21.0496.015; Mon, 12 Oct 2026
 10:32:23 +0000
Date: Mon, 12 Oct 2026 11:33:45 +0100
From: Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>
To: Frank Li <Frank.li@oss.nxp.com>
Cc: linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
        linux-sound@vger.kernel.org, linux-spi@vger.kernel.org,
        Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        =?utf-8?Q?Am=C3=A9lie?= Delaunay <amelie.delaunay@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        Andy Shevchenko <andy@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v5 1/9] dmaengine: Support bus widths of 32 bytes and
 above
Message-ID: <asy3V8Y94kx0WDOK@nsa>
References: <20261009-dmaengine-support-wider-dma-masks-v5-0-4c4e63a7a1af@analog.com>
 <20261009-dmaengine-support-wider-dma-masks-v5-1-4c4e63a7a1af@analog.com>
 <aslBdT8XqNW3L_WO@SMW015318>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aslBdT8XqNW3L_WO@SMW015318>
X-ClientProxiedBy: MA3P292CA0030.ESPP292.PROD.OUTLOOK.COM
 (2603:10a6:250:46::13) To SJ0PR03MB5469.namprd03.prod.outlook.com
 (2603:10b6:a03:28a::17)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|BL4PR03MB8040:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fa9221b-fb94-47df-29bc-08df284c1a64
X-LD-Processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|23010399003|1800799024|376014|7416014|366016|6133799003|22082099003|10067099003|18002099003|3023799007|261009223027099003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
 0aj0M3nYmXLmM8y9Ifk8hEUsHgpd6CaMaYp+9mvE8GN2j4YMzLsd0Vkzb9uTITgVp6MaitAD/Xt4kDjKHypO35Gp7gtplZunPcse3hAwkka36tdN7asLj1p7iuMTSG561ODyBwUjXIhTGYpRT7rAmwnVVFR4ePwgFx9psPk62eXAxQJ9GiUMhTmMVcs2Zgsdr05SaGlbf0tiygfiS5NuzjcrjZjZFdqSJvtZE8CyX+Nf8TMQ4d662WVBHN7uU66B29lbE9Z0ME0PkAmO+25yUN/JRAl/vZQ7stsX1Hnm6ulpn0g+dVNAVp5BIfY/4MCuNB1oNMYYHN7RCly5WFrsdUI54+fwpkP2/ATNTbMxGfImm2HrmYpKA/WjXECv62ZB4I/onswbEna5QjgkfngTa/r51D2Qh3Y+hhl/gSDqW8Keo3BflLkAENa6NUkhyO+rQRE9wsQ1M1LhqCc3MratIwTkZWoeWOXA/pw8rWpnlORSU0baCY6vDMjpx5nu20i/4FSSjUnWafZhkn70b4QGVyD4sZB/uLuNCmV2ax6qNXAs429PtRsqq2XPKAflnp0H4Vv6/K1MBn6hyuc1MMel6qQrsIQOkDz7wKRAYyluISUOzRUu1KG1zHUCfDUbj/sWAaR2jK9YC8C5OGpSPbw6Uekgp9b6ndjEI6FK+7io/iw=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(7416014)(366016)(6133799003)(22082099003)(10067099003)(18002099003)(3023799007)(261009223027099003)(11063799006)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?NFpjZGFHUy82TjBMSFJER2hnVWFWbEdJMUlUeDBzaUhZNjJLdTFlc0JqOUx3?=
 =?utf-8?B?WjZ2QS96UGptZWZzMjl1Z2JOK3RXbW5qdkZDbTkwZkNza0xXZ3NDdE9DZ1N1?=
 =?utf-8?B?eTNLaFZ4T01zaUdpbzlPREZNaGdGVEt6b1FEM1V2bWZHNnJtNVVqdlVQaDkz?=
 =?utf-8?B?SHhoOWs0S2pFTzY0QUFvV2dZZG1XeXlxa2tmWmpZNi9JdHlmMG15cnJNejlU?=
 =?utf-8?B?emlyWlJUNXdyWHJBRXJhWEY2Z1N5WFdKdkx4WU5JV3RwUENpVnY3YWpacHU0?=
 =?utf-8?B?anBuMGJHL0tiSVpyTUVvaWx1VVdramdmWUlKL0tnSTNCODR0NFRaYU5Wdldh?=
 =?utf-8?B?QStRT2VidjJUSTdLQUIwczl2eTMzYUxYTVptTk9sRXhXUVNHSnpxdlhzNDhm?=
 =?utf-8?B?Z010ajVmQmRXanF5Y1psNXErVlJKMm9YbHlhWC9qU3RZQ1hVYjZKZFVYT0RQ?=
 =?utf-8?B?aktkYWVYaEUvNzhhVzdEdlFZbmVxZ3VlYlRuWFZjcWFSZW1JUUU5dWpBWGpI?=
 =?utf-8?B?ak5ITkVadVBlUnd0K0ZhaXpSVGl3cWRBWG1sNDFMTFc4b3F2Ly9wMXBtSVZL?=
 =?utf-8?B?NzNBclZ2OTdPcjNFcWF1dWVvenZaUFFnY0ZVcW1CU1E1RndSVi9jM0RSRlNl?=
 =?utf-8?B?ZG5JL3pMcnh1bzdRS2NoRXRCWHB1ai8yMWJ1eXNBKzMyS29ZK3hHM0UvNkhG?=
 =?utf-8?B?aGNkQmhaNlFCZG14NVVMSnljcVFGMnM4Yk1Qcy9iMkd4YnV6enJkVktRVWlq?=
 =?utf-8?B?UFNyUEVEOWJOK0hhYVpTUTdxN2ZJNmU5d0dEUzRGckY5L2I3WTM3Y3NPd0xl?=
 =?utf-8?B?RFlvTXJSdi9KUlN3ZnkzRURmNGRxK2RFanJMeFk2VDNLZFYveXVXMWxnZ3dR?=
 =?utf-8?B?b1NXMERCb3I2ZGM4MmlNU2tqb21YTnhGd2dPOVZBR0ZDWWcvQSs4bjVhSlkr?=
 =?utf-8?B?b1NnYU5CVUdsTzdLL283dTY2WHI5WU1hTm84TmhqU3NoZ05Yai9CTlNJOFZY?=
 =?utf-8?B?UG9PQlE2SFZQa05Hcm5iaktPOXFMdzlmM2RuR1V1dDRWc3hoczlQVEE3OHhz?=
 =?utf-8?B?M2xLUDdWdlh6dHFGUlU2RndLSG1nZHQrRFF1YVNHS25rSnl5aTJDelZoa2Jx?=
 =?utf-8?B?T2l3T0VpczEwTlNKN080UmR4bjBWbEVaRTB3SjBLS2kwRmpjc2RHWmZVaGxT?=
 =?utf-8?B?V3o4L1JZMDhkN0hpZlJ5dnFPV3VwWWEyaGduZnpveTB3NzFQeFM0VC9mTnZH?=
 =?utf-8?B?TXA2T1hoWUt1NUdpeGtiQXpHeithOWxYdzhOMDRRa1pVc04vbzhVS3EyNTNZ?=
 =?utf-8?B?YnVTVEpMSUNvQ0QyS0xYUGlFWEJkTHhHT1NrekExblZLNm1OMWhydDNGcEx3?=
 =?utf-8?B?WFozWTdQdm1IQ0tFcmhEOFYvSVlUYnZjV0d6VXlMNTNUUEFJUnlLZmw1cC9o?=
 =?utf-8?B?UEV4ellWYlVISDk5a2xwa2FTbVk5MUxhQnVZak1KVk5YbnlZZDRCVTYrZGl6?=
 =?utf-8?B?VUptSjhSU0FONnlzZ3RTOHBRU2dPN3VEL0lMY2dkYytnSndJamtqV0toTVdP?=
 =?utf-8?B?eHBweVFsZitEOEJWaWFOR2pFTStWbTRHa0VYa014K1hPVDhGZEgrUFRjbVZn?=
 =?utf-8?B?TUtLM0FoVG13QkVMSTBoT093Q1lUbG5QTEk1d2l2Nlp0WTJrZkhYc0c3b2RG?=
 =?utf-8?B?Y0JROEs5UDBDRUNUUUdUTVhSc1ptamxGK2sraDMzRmtmWDVWNU1zcnVZMFdq?=
 =?utf-8?B?ZmthYmVreUI1QjlIK0REZXdrOHZ5WWZCM3VDRktVVVM3SUlMeGtlT0YrVjhK?=
 =?utf-8?B?VUk1aTJLTHZwWU1oQ1kxcEI0NW9RMndMaUpjU3hNRXVHaGhjclZTNEVKSEJ2?=
 =?utf-8?B?OEFuYkZaR04zbGtXamtMQjBYRXhZaHFqNDVuTVRDbkJia3BYeHVMNGMzTS9m?=
 =?utf-8?B?L3AyRGRTNWZxcU0xSUlRcWdpamJrcXNGeEtKVWRLNnc3bVRCOWtyUmN5VW9E?=
 =?utf-8?B?dkVteXJ5eHVRZVpBTTRnT2syMTNGYnltUXhESVh1VlBIcE5pR0ZNMTdYL2E5?=
 =?utf-8?B?YWh1MTIwcUhSZmM0bDR2ckxjUEhkRWdTNStSaS91R1E2aFJYdmxnMml6WXRh?=
 =?utf-8?B?UDVSUHFJSGxPOE1tTWtwWDVyU293bHBhWXBPZnpoUzdkZ0NMNm41czV5V3Er?=
 =?utf-8?B?MnhUMjNLc1BXMCtFeFoxeG1HaDJtcmgzZXczajhzSjhxTWY1QWdpVEJIWDdQ?=
 =?utf-8?B?aGo1cU1qQThLNk5mTDFKNFlaeUdLREZoWTFBVWNqVGZEMUMrZ2ZWVitPY0Nx?=
 =?utf-8?B?OFI2d05jSEFxRDN1WFNPWGhQOS96NnN1OUJwSFJCK2xyby9LQllrdz09?=
X-Exchange-RoutingPolicyChecked:
	IclGVlnqpCuNzHC+gyCNlFbnvG4HDoOb0sTj4OKnt+11NgEIdDRHga/rHkA6gq76GVUQuyIAZ7cySgZaDSxDidqfV6geOZMyBKdWIFgDYzRIv+/h62aqIa/HgrNvnMm4o/iiiE3b81uvUplR/xDLzlf6U1eR3adAJ0qMhTuOnDCeAXma30oN4l6RepIBHk2myXPnR2eVPfr1CvQ/gJk6iZviPMzrNysk3UsJ1NZOAr/X1Dif9YXYjQKEXvTsKn8f+Sa7WhfKTzasWAlb7arsvNiiEKe/Uiqv40EDqSxI7LnMvlB5ghJho914yCIC5y+rXq+4hKj0sVwfUQpNb+3Lvg==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fa9221b-fb94-47df-29bc-08df284c1a64
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2026 10:32:23.6426
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LD4l60lZYSiGs0LNTBzr2C48FXe86DcrlgzYeX7t+IxnED1ugnId/f4mf5Z71CzvCkI4Mw3qZjx0V46YY1rpmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR03MB8040
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA0MSBTYWx0ZWRfXyIsgW7LZIPEk
 cAict3ovqSnRBDviPGSLRsEVTRsZ5kXM91gI49OqvGXKUIkqeFfhmhlLo7PSAf9WN8gqRgm8Tox
 B+KI6b67Tewm1LKEfG6v1hOCBOG+ymnBouSXx9eN6LJkKQbwedMs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA0MSBTYWx0ZWRfXwRD6jBmCnIsL
 olD6nZoS2tM09pwg/fM9dvK8tJrbUEu/G7u+SJ7rEYyQTgt37LkcKaSEphDH8uxacIbqO5ySsOI
 YTv5CRY+WZ2PoHCbRSgVqIBj4tC2BkeifKAGtf0j1VBplxHuXXFZaN8GWsZXtjabZ+3Gp5vYWFx
 9oVvZh4rCoL/9jB0tYYcyJj9ppiuzChFd2ni6J5g7kicA8uaLigrB+lDRojEq2FaefgpzRDfG67
 +8x+yq7iSZiYx9HQRumcQiUKd18ET7eVyFemE7p42GLLrtGfH8G2dJE+C2nvFkCuG6KhIKyp5k+
 0zQuvAM8LmQ332XipCdlwo92jWZ9UPQMj8+FcntYQ17eYBQx1CrWaWeJKmEbXffVTkp7OQyrZ4O
 MIm62GmXxt6PlhCBmnfrxJd1XSBqgM7BkwkxI1uHI3ZRr06wUfGDDRswVKCnsWbOOVNB1KZBge6
 jqX3BOj4uxQA4vyverw==
X-Authority-Analysis: v=2.4 cv=AMeVrcbb c=1 sm=1 tr=0 ts=6accb73c cx=c_pps
 a=jDwMdcx0fGNsu9pFyB9b3w==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=ugNRTJOwpmtT476g4l8T:22
 a=gAnH3GRIAAAA:8 a=QYabyLya7rksitipNSUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: _RsPAqeDpx1ToLTb2puBSqdMBvgJ-BGG
X-Proofpoint-ORIG-GUID: _RsPAqeDpx1ToLTb2puBSqdMBvgJ-BGG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_03,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 bulkscore=0 malwarescore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610120041

On Fri, Oct 09, 2026 at 02:33:09PM -0500, Frank Li wrote:
> On Fri, Oct 09, 2026 at 04:52:53PM +0100, Nuno Sá wrote:
> > The src_addr_widths and dst_addr_widths capability masks encode each
> > supported width as a bit whose position equals the corresponding
> > enum dma_slave_buswidth value (e.g. DMA_SLAVE_BUSWIDTH_4_BYTES sets bit
> > 4). As these masks are plain u32, widths of 32 bytes and above
> > (DMA_SLAVE_BUSWIDTH_32/64/128_BYTES map to bits 32, 64 and 128) cannot
> > be represented at all.
> >
> > Introduce bitmap-based bus width capabilities that span the full enum
> > range, through a new dma_buswidth_mask_t type modeled after
> > dma_cap_mask_t. To allow DMA controller drivers to be converted
> > incrementally, the legacy dma_device u32 fields are kept alongside the
> > new masks and the core folds a legacy-only driver's u32 into the mask
> > when the device is registered, so consumers only ever have to look at
> > the mask.
> >
> > The fold is bidirectional while both representations coexist. A driver
> > that only fills in the legacy u32 gets its mask derived from it, so the
> > consumers already converted see it. A driver that only fills in the mask
> > gets its legacy u32 derived from the mask, so the consumers not
> > converted yet, which read the legacy dma_slave_caps fields, keep working.
> >
> > On top of that, dma_get_slave_caps() derives the legacy dma_slave_caps
> > masks from the new ones when a device_caps() callback adjusted them, so
> > that a converted controller narrowing its per-channel capabilities is
> > still seen by the consumers not converted yet, while a driver adjusting
> > the legacy masks directly keeps working.
> >
> > Signed-off-by: Nuno Sá <nuno.sa@analog.com>
> >
> > ---
> >
> > Andy, did not take your tag given that you're the one asking for the
> > split and since we ended up not doing it, not sure if the tag is
> > to be kept :)
> > ---
> >  drivers/dma/dmaengine.c   |  51 +++++++++++-
> >  include/linux/dmaengine.h | 208 +++++++++++++++++++++++++++++++++++++++++++---
> >  2 files changed, 246 insertions(+), 13 deletions(-)
> >
> > diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
> > index c5fef57b5adf..4ba9d6c7448a 100644
> > --- a/drivers/dma/dmaengine.c
> > +++ b/drivers/dma/dmaengine.c
> > @@ -33,6 +33,7 @@
> >
> >  #include <linux/acpi.h>
> >  #include <linux/acpi_dma.h>
> > +#include <linux/bitmap.h>
> >  #include <linux/device.h>
> >  #include <linux/dma-mapping.h>
> >  #include <linux/dmaengine.h>
> > @@ -592,8 +593,11 @@ int dma_get_slave_caps(struct dma_chan *chan, struct dma_slave_caps *caps)
> >  	if (!device->directions)
> >  		return -ENXIO;
> >
> > +	dma_bus_width_copy(caps->src_bus_widths, device->src_bus_widths);
> > +	dma_bus_width_copy(caps->dst_bus_widths, device->dst_bus_widths);
> >  	caps->src_addr_widths = device->src_addr_widths;
> >  	caps->dst_addr_widths = device->dst_addr_widths;
> > +
> 
> Remove this empty change.

ack

> 
> >  	caps->directions = device->directions;
> >  	caps->min_burst = device->min_burst;
> >  	caps->max_burst = device->max_burst;
> > @@ -611,9 +615,31 @@ int dma_get_slave_caps(struct dma_chan *chan, struct dma_slave_caps *caps)
> >  	 * callback to override the generic capabilities with
> >  	 * channel-specific ones.
> >  	 */
> > -	if (device->device_caps)
> > +	if (device->device_caps) {
> >  		device->device_caps(chan, caps);
> ...
> > + * Return: 0 on success, -EINVAL if @widths contains an invalid bus width. Note
> > + * that the bus widths validated before the failing one are still set.
> > + */
> > +#define dma_bus_width_set_many(mask, widths, n_widths) \
> > +	__dma_bus_width_set_many(&(mask), (widths), (n_widths))
> 
> This is not good to get first argument pointer here, which will cause
> confused. check others.
> 
> #define dma_bus_width_set_many(mask, widths, n_widths) \
> 	 __dma_bus_width_set_many((mask), (widths), (n_widths))
>

Sure, but FWIW, I just followed the same style of the dma_caps macros.

- Nuno Sá

> Frank
