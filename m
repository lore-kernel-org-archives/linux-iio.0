Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C3E030B51F;
	Fri, 30 Jan 2026 07:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769758402; cv=fail; b=HgofirlZNcUJBgQyldClxA/wmNb6yE6c+yD88L6McA7O7AAr46/zPTw692im6R2yRVN/tIF7l3Tz/7G89ZeUsK2yks1rOEI7SulYT7+ByArAWLNoPD2s3Oa/VQyCshMtMkSFjxenMa60RIBOfon4mgM7Rxy3+wj082I9pI935s4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769758402; c=relaxed/simple;
	bh=0o44RHQ2noWvEXbhbUlDos5yCt5QQ/v9XKi07ZOa40k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gkOl+DpVSGdIV1kChz5Ykxd9SpID8+21tGNdIoAYKpwdW/7HkEE/f1l+3AktqHluEujZaqD2dqwffYukuBHJ0TDez0mn+4E4cfA2Oy4qpDIARD9e+Sm5D28fG7D5Yrc8gTO7xxsHdfLHjObrli7tX6NDA7hw9+fy9wxjbMQgaP8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=hhSgQ8YK; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="hhSgQ8YK"
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60U3uvtK2649123;
	Fri, 30 Jan 2026 02:33:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=0o44R
	HQ2noWvEXbhbUlDos5yCt5QQ/v9XKi07ZOa40k=; b=hhSgQ8YKtNJ3Os3kAqk2V
	2ncH1oimGqGNglxRerbsPcSqpt9bwtu/sWloRStAnOaev/F6vZQdwhfIFwQIR4p1
	S3Oxa8loi5U16yDymXhje2KZ9JUcHWRtdAaGbuMXAvTbucMez6HOZZjQk0eol/41
	koubbZpQdXMWvGJim3ux+UE/ZNCPt+g8+eX98ugkjUB660raLAWI+1nDotn7Bv/4
	G6J22U7dlg4hYtkbj531EjejtQ2ul8WiUyTXyaayvqMSvvhHxajgApTKRKsYSTc8
	wW/5chyrIJYvHvObe3laY9VSkfM01YNl1iqi4wzPnzkkozykirL8w877eocN8hON
	g==
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013064.outbound.protection.outlook.com [40.93.196.64])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4c04894p7m-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 30 Jan 2026 02:33:01 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xRlIiT7Ep52giYQVVOb9ekEPb2KLBw/pe6Fg3B18XSTktyCeVZHWl98tk5yOsE5pAvhD5PpoAki105He0/GKhTFy0wOqgZNpBvWZcP+Ztk9iYG5jpD0xkGjclSWUPb4qw5sjQSGxeTsF84I+HVOEJcL2B76dAemIyunSI9AD4TINhNA8fjFU5+Hanez+rlK/3My9V2HvBVCPd4Yfz1uh3fXX6dA7/3A/XqLpxHhXxSho3TTD4zRiEIEtpTi8a2ngr71BSDe+0DFlP64+AyNe7Qbnj3XUkliihYby+5WDXoKS6NPDjPvEyY+BQWJnv4PtZDJNj8q4o5Lm9oyrYgdCtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0o44RHQ2noWvEXbhbUlDos5yCt5QQ/v9XKi07ZOa40k=;
 b=ElMPkntFeEvRkssGXhf1tjrl+pTL9lIRMO82XAJbaWm415gbZ/I5Skq3plDEoYST3KXEtUTZu1X94SwbLx3+rO8w/JhkNHFvgutbyJpQDIs6nRDsIyGdV6T1uyT9NjBRnQ86csyQ9p+RrATmcDJ9o045SIgwVRaGR80FZSDpAN1AU/zUSl/cC79TXoemRKdDtjVSRL5uaHARwH6erLk03GM3JG50BxzuI4ZWcJuYDAJQYe3QdHgNM04yhyyrDEKWRyprbh58rrb41fK+MQqIUeXHODaDlAbqzeMQFTEKyEqhnYAHkOy7axN1aJJ1LYo5rE31JoX8TeOoEfFIbgWTEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from CY4PR03MB3399.namprd03.prod.outlook.com (2603:10b6:910:57::13)
 by SN7PR03MB7295.namprd03.prod.outlook.com (2603:10b6:806:2e2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Fri, 30 Jan
 2026 07:32:58 +0000
Received: from CY4PR03MB3399.namprd03.prod.outlook.com
 ([fe80::1527:d313:16d4:2376]) by CY4PR03MB3399.namprd03.prod.outlook.com
 ([fe80::1527:d313:16d4:2376%5]) with mapi id 15.20.9542.010; Fri, 30 Jan 2026
 07:32:58 +0000
From: "Miclaus, Antoniu" <Antoniu.Miclaus@analog.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
CC: Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael"
	<Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David
 Lechner <dlechner@baylibre.com>,
        "Sa, Nuno" <Nuno.Sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Fabio Estevam <festevam@denx.de>,
        Sakari Ailus
	<sakari.ailus@linux.intel.com>,
        Chen-Yu Tsai <wens@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] iio: adc: ad4080: remove unused dec_rate field
Thread-Topic: [PATCH] iio: adc: ad4080: remove unused dec_rate field
Thread-Index: AQHckUQrHk22pdZjdE+QnfbmrAnOm7VqLhoAgAAjhAA=
Date: Fri, 30 Jan 2026 07:32:58 +0000
Message-ID:
 <CY4PR03MB33992FFE27A9A7DB4D7BF9069B9FA@CY4PR03MB3399.namprd03.prod.outlook.com>
References: <20260129172340.34216-1-antoniu.miclaus@analog.com>
 <aXw_5nryp4dKHVfm@smile.fi.intel.com>
In-Reply-To: <aXw_5nryp4dKHVfm@smile.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY4PR03MB3399:EE_|SN7PR03MB7295:EE_
x-ms-office365-filtering-correlation-id: 821d2711-58d5-4393-4c84-08de5fd1cabc
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?LweepArGRBWPj8uwnApdnbg7zpun3xkNXyj+qF6cFK8D0OdIB3Pf1/t7zxtx?=
 =?us-ascii?Q?WsTFWF2F4vEyTqrbSWRfKK0X5X86AHHhmZNCPI1F+uEdhI7olgIfUPDYlGKR?=
 =?us-ascii?Q?U1Hu46LR+BrYw2me0CjCHo/xoLkVhlHwf7pn41QBQS8G4/qAcU6Pgl17EZUf?=
 =?us-ascii?Q?CHlMBQ3LIb0jNLt2sJoMMCaaR0L4+9bYZB8ySz4yzuTSFKVvVFhhDb+MmyXu?=
 =?us-ascii?Q?KgV15RMCb//12ijmHRxmEMd7LtQrEumMWNml41k15EnDcptF9fBBynox6WN3?=
 =?us-ascii?Q?ULmt28rzPt+pADqCpjR0F/0j8tdfcgye5Thh3/IntlndL6PVDTbVqwB4geg2?=
 =?us-ascii?Q?E5Ifn7Py5xJGYKTkOg/tfGsRtE6aZafue68VWpdBt6mGQnfF86+pG6nhsGbm?=
 =?us-ascii?Q?1QtxROrxDjQUQZLGeUSKxpBXSrbw4mt9rhgt41I0k4Zsmh5alBxnfs8nbMvL?=
 =?us-ascii?Q?td3dWfKmRqB6kt2b/KAi7rahBqoWpkT2/aOA/PoLVQuRiJRsmF1fZBoRS0Qu?=
 =?us-ascii?Q?eo2E4MCH1b7Xw4PNPbuLGfsUNEqFNikIhHz/h1D5HodmXZqAaVipVzrbqd3R?=
 =?us-ascii?Q?vEfkbo9STQXGHIhSzibxAmX39/zstCIeAE/e1kotDgJwrq8falyqC2fev7ER?=
 =?us-ascii?Q?yoYKbqQeg6BtLjML+VsNJWsPsak/u08nGqC60qevCcK5+y1PHz/hdFmfx0+j?=
 =?us-ascii?Q?/gYHJWOzl7zoJRyshYh1cGsMtOk1VWLFpAdxQ3pgzKz5O8gksfHPkU4F+YC/?=
 =?us-ascii?Q?og80j256uP3h87xbuaWuEp9BzflHVyG+IZmYF3xSKz6pYxGhJlYwmxrO9Uuj?=
 =?us-ascii?Q?L7EPoP5bsFOTR5a8Ug83OvX1E9SlMkJLLJS3TJS8gTYPpm0m93JeyOMWpCeF?=
 =?us-ascii?Q?co97KNPvrgXiQ0C7vC7ZJAhkPPL3BA5NkQRL4rtiOEZfpT8UfqZeJTXbHIPN?=
 =?us-ascii?Q?GKMkQ1phcpt+RLtIgvLeq4sKmi7scLsCtSFcPFkhxbjEKCd1xl6bCe5SqAkQ?=
 =?us-ascii?Q?D1tAZJfqstHp5MwgwvxUBXnSPnwnA4lllwRJEMMI+sProSZ5WWN6/LSoqv20?=
 =?us-ascii?Q?g/dFdcHpqF+2xguhQ39bgrX2/QSa4CxywUqBNyl6zLJuCk0pN8qM03Jnzppv?=
 =?us-ascii?Q?96br2PPZtqkoxTSiUJiLBOozbqfYAYCL68dUB2AuUrsbRzWY3tm2mypekWpQ?=
 =?us-ascii?Q?kLLRRXM2UVa9/5IF2ik5VkiYyEJ9pRCd2ktXnR71d+CGOEueGFKsrZZc1H+o?=
 =?us-ascii?Q?0DP7ENmZeV1XIMJETiJwT9j2uKnS9tEZL2iM3vB4O1KwZD0A2UomPAV8EVXH?=
 =?us-ascii?Q?GueKE1jngaup1I5EwTVwknyDeBfMPG7f0sjW2J0H0EmeujAC7guaeB3czEgo?=
 =?us-ascii?Q?p/CmPNmtWp/SQafBvqmFztFMbss7YoijgN959SucYNxI6dj4kCw+CctbM58D?=
 =?us-ascii?Q?pQvYRBHPK82WQ499rqux65M3eC4Rg3IcBbKZZ26vZ8F7vfG2/UaCp2vzwTpk?=
 =?us-ascii?Q?hwkOtzdxOTGEfTAv1fNaJzHRtenbzR4DkDt/Y2/+w9vGUBTIkmayj7woARQD?=
 =?us-ascii?Q?hoVZC2Cfym1icF8axG7ZNv1mI1nl6IBhgTaVf0ghF5A06odDN7ws5ztUd4qe?=
 =?us-ascii?Q?ee7ZNzKQ6OqU/uTV2ljH+d0=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR03MB3399.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?ct5omS+4NuXEj/cxzzQUc+jmsAYMpUgtjyKprJXAPTP+c6aH3snHWI00J3yF?=
 =?us-ascii?Q?+aLlZEGtvqzvk0utuPAWvtW1i2HmK23jKzaZ42m5xXkwuq+Boiwmb+GSRMiR?=
 =?us-ascii?Q?rqn7oPJuI6eoCULwJvHwK0770CEgwvhxtTvBaCBzUB9WX8MDGKUGImU4G0ce?=
 =?us-ascii?Q?oY2jBUTahExFbTd9JXZRDBSTbAMAOFgZQ/3KbYt45RdkgHy58e97QXu06pl/?=
 =?us-ascii?Q?ZJl9XBgCDrjhGWvTRiZcrRWR6SXfKQUoVz2l1kKILMHqrPHK7PooNDxve994?=
 =?us-ascii?Q?8Q1ZD7qfwB11WLlfoTLZfQmcvB+VAyEPVT5UTrM45nnpP8UcydsmiPkHzRUU?=
 =?us-ascii?Q?iIp1zxPIQcuYSnPWXdn60rWZ6KTwXWSMMUhFZXR2ArIKe+bJcMWTceCBH6qo?=
 =?us-ascii?Q?W5TxN61ILGOrZfGraq1pWCLu+jkRmU+phEX7Ig4a6QgzsajSvALAgAeGc12P?=
 =?us-ascii?Q?+sgi9wTool1rh9/Sz8wlx96rNJZExH3qRQC863MtJi7LpVzcbC8G+4iXGcAT?=
 =?us-ascii?Q?WMv4sgz/gCS2MeAuLjh6D1SWGgF0ZYxQD1N3m9EaHpkmPj0gNJiL5HI9WVzY?=
 =?us-ascii?Q?M+POjOy+CfCG74ZYRbW4urvHNKt6NE/ttl96zuhznU/eodnrOgheqLiRLvJa?=
 =?us-ascii?Q?g6YaPJueLKbQ5f0PfAtMqzT29GFi13DXVbk3Bzpd6sYm2Ly3tP3CGEJFn6VW?=
 =?us-ascii?Q?SsaEryacx28TppfPWKly/n/oQ08maIXVDNygZZvaGq5y+mBWBSRegl5syy1J?=
 =?us-ascii?Q?/i9IPPby3HI1geQ7eoyP+yfaL5P21FDt3HORDCIuRSFnYZljRNYu1Y7FQZRk?=
 =?us-ascii?Q?4/baO16tIX+7V2EzXDAWzo9HXjvSaliX6IeUWEmJu8EHWwtPZ0xSmrQCON2d?=
 =?us-ascii?Q?I8B1OI3EEUT59feRv1RU0LJ0Y8SHMZAjyTfepIahQwLtUsa/L2dhSIwOa4bq?=
 =?us-ascii?Q?l9JONLSHFufUlL4Zjqi9HBBNYOpCdRs4DR2uyZyFVD0pZ/bXksnqpIY/cfO8?=
 =?us-ascii?Q?YYSHNd6KE/DeB4NhGbV7K0ATsggbdXkVJkGYBQEjSN8iyM7C84N0G1ljVSLW?=
 =?us-ascii?Q?RIX1vryVEzaLLj4483TgKqwfaIvl7pV0McIofMAZ1wh5xxs7n/eE1j6mVbOF?=
 =?us-ascii?Q?qyuP5DkW7ydGL9oPuDuGlz+JKYHOUTtZL+9Fpo45ZhhFUJo4bPWUnIg3a9gG?=
 =?us-ascii?Q?npTOkl4VR3L3k0lkgNVRF7HRB4qgjk7CR2XdM3hf3o6UpsChgfSJwKJqeujN?=
 =?us-ascii?Q?WZcxvjRXi1VDrk71MEWxu0YYKdLa4GGzf4HS33KgNL7lbjagcwjayC7L+iuY?=
 =?us-ascii?Q?suWasuagB6KGwrehCHaG47Th/AnRHk+HYrUZzwd9qpFdBIJQk0mIjEzyMUma?=
 =?us-ascii?Q?yQw0WIF94xjk9QPZDZPm7BeZu6bY0fW3A+k+OYWkaAV9bkx4oj5jFXvNDcDh?=
 =?us-ascii?Q?SDV9NUJTMvJ/GRiip3N3FH/k2lZYqdFnPpCutz0lGEVXaUhDRqHLcGXnhKOx?=
 =?us-ascii?Q?bRNFxdBxN+m0ARDuyXZA8A+qJ7au+sZ6SjyZ63YUiT2I4qCZ2rrNdGTD1vlh?=
 =?us-ascii?Q?NFLR5Gu1qlJNwuMSv+FHLpAfeyS1+pH3Ju4FFeg4N/BS7w2j/a06o1hCpB0T?=
 =?us-ascii?Q?DemZmTOLeexVBu0Wkb7J4ha2IWEXfP1/JkhGzkwXbidWlzCWc06W8noBrrDW?=
 =?us-ascii?Q?rEHPVRlxKbcPcxkMwjHUdtigjqT1cOJGGV3uHX3vgDxWgRfCfZZwRMtdNgT9?=
 =?us-ascii?Q?+gGulltisg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR03MB3399.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 821d2711-58d5-4393-4c84-08de5fd1cabc
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2026 07:32:58.6126
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5VlOcXwSVi6LLXdGthkPmYaIMtibitO95WSqe4QupLT/L4Lf/c4anZgkNdziR9sYM/fhSMBZMKig0rgLWUkDhsO3tdO4RhSUAyEffe3vCko=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR03MB7295
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTMwMDA1OCBTYWx0ZWRfX4bXc8Wmdra56
 Gcmj0kS3vems7QetDZrEBBzszNy3Yn5ZHIlX3E6NS+awzYisUdRfwq6MuFQwsjNsCIX41++cTE3
 EsKV9c8IsVUu0ev/g0ZVNn4Uw9Nh0YSFVGmPulCT839BxmKxnhoabrIqwSB1UDngNNoUfM3jp3k
 ZtQOZe1sV0bEY0tqZnnHsaW23LJy5eX/KrBuWB6wTiHfGQ2vEg/iU+91IqpqBHolwM03+k1BssR
 y/45XFP6plbWtOpy67QNKIAqikKNnmwLR+G1WzmDos8WaEBmyVLRcsCqKTuwTQSGuBSugQs6y8t
 Gk5msRM+Elu/ZDQwlHom++pv1P2vSjFBzWjSsKbqz0Kb5aJ4fF1fA/2g4pOYUZL5n10P086sEyP
 98yuY0uI9YIDchdQvCyUaFJ8+I8HC0HYHNV/JosF/ueGMkcj7kFBkpHSGzD0biPnYFZMSHl0LSq
 auuqPGT0LY1Go9DNGWQ==
X-Proofpoint-GUID: L1jyCo4JSNDo8ZIAnYSmjy8XcGa1reGl
X-Proofpoint-ORIG-GUID: L1jyCo4JSNDo8ZIAnYSmjy8XcGa1reGl
X-Authority-Analysis: v=2.4 cv=dq/Wylg4 c=1 sm=1 tr=0 ts=697c5eae cx=c_pps
 a=Kac4Oh/pgoirBk7HbaAweA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=QyXUC8HyAAAA:8 a=gAnH3GRIAAAA:8
 a=VwQbUJbxAAAA:8 a=IpJZQVW2AAAA:8 a=pGLkceISAAAA:8 a=fUYR0MbB1XhaIy1QtVsA:9
 a=CjuIK1q_8ugA:10 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-29_03,2026-01-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 spamscore=0 priorityscore=1501 adultscore=0
 impostorscore=0 suspectscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601300058

> -----Original Message-----
> From: Andy Shevchenko <andriy.shevchenko@intel.com>
> Sent: Friday, January 30, 2026 7:22 AM
> To: Miclaus, Antoniu <Antoniu.Miclaus@analog.com>
> Cc: Lars-Peter Clausen <lars@metafoo.de>; Hennerich, Michael
> <Michael.Hennerich@analog.com>; Jonathan Cameron <jic23@kernel.org>;
> David Lechner <dlechner@baylibre.com>; Sa, Nuno <Nuno.Sa@analog.com>;
> Andy Shevchenko <andy@kernel.org>; Matti Vaittinen
> <mazziesaccount@gmail.com>; Fabio Estevam <festevam@denx.de>; Sakari
> Ailus <sakari.ailus@linux.intel.com>; Chen-Yu Tsai <wens@kernel.org>; lin=
ux-
> iio@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH] iio: adc: ad4080: remove unused dec_rate field
>=20
> [External]
>=20
> On Thu, Jan 29, 2026 at 07:21:58PM +0200, Antoniu Miclaus wrote:
> > Remove unused dec_rate field from ad4080_state struct.
> > The driver reads/writes decimation rate directly from
> > hardware registers via ad4080_get_dec_rate() and
> > ad4080_set_dec_rate() functions.
>=20
> It seems you missed my reply to one of your previous series.
> Do *not* thread emails which are independent!

Hi,

I didn't miss your previous email. I checked now the command used for sendi=
ng the patches and it didn't include the --thread option

From terminal history:
`git send-email --to-cmd=3D'./scripts/get_maintainer.pl --norolestats iio-u=
nused/000*' iio-unused/000*`

Thanks,=20

> Really, you should have something internally at the AD to explain the pro=
cess
> and the simple things like this.
>=20
> --
> With Best Regards,
> Andy Shevchenko
>=20

