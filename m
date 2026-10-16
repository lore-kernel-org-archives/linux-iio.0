Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C0546C821;
	Fri, 16 Oct 2026 09:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792142658; cv=fail; b=sbnxdquXXX96cfDG6AF73nx7woYxAc5bZaRQEgHmBHlzIseWXaKEIIg+uNM3mlRW8ZtskA6D8iJrRZvrISZ/05VxrEyZHjANyR6fLF51/bOsmjYVP/lAQKyOpab/zLIp5qZVe+lCHkaGg+SErJxky6pwCGCG5Mzq5OdcalFQCIc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792142658; c=relaxed/simple;
	bh=Hnoxjh5Jvz2aEUEaeXuawAsPsrsMxA0b6AC+BnrMcnc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HhNpsoGlhoCRk85oGmp540wSI0KvH6ciOID/ar5DrqJfu4aHnvArR/ArE63uvWPXDv2vG+eBeBD7hlWGZjDSEYlUutiRlzeetjjVlvpE8mMQlOVw29N6dBjaaQQDOAh82qM3P9wdPu3yr5jCcOn9rk2UwnDyB9vO3s34CcfX54M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b=h4pI4xrW; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=OijhBrek; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b="h4pI4xrW";
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="OijhBrek"
Received: from pps.filterd (m0516786.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69G7I8EV928936;
	Fri, 16 Oct 2026 05:24:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=VEbmIG55HBzNToHg2Zb4PEEbmXg8dOB/S8sM66h+HhI=; b=h4pI4xr
	W6MVziSR04UpFSSTLz+enyqU1jaejRBH/dNlcey4I/tUjaKMhE4G5Ge9A8oAd2X+
	QiO7PEnBfgm+z4mZT8I5NKpslI+IMmCYNMpjJQf3nTzpdRr4ggtca6fuR2dQWDom
	di3h0FpSdpQ3qrP2dBSgYe5rP+RDxyx1iY/XNRaF5vRv6iDZbuS/zhaPKuGzqTwt
	BACP9ZAVyUd+Xk/fvAVpTU3pByHyjRVK0QIopvB4vVAFCXfUy0/5YTgs5knYYdfQ
	n09POpseAsl17w4XAlSB2nXCKWIEeTgDb1uTEOugZliSdP6wkshR/k730Kakxa6k
	yZj1pX9ZUsTS/ZA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=VEbmI
	G55HBzNToHg2Zb4PEEbmXg8dOB/S8sM66h+HhI=; b=OijhBrek5qyj+L7hSxQ1+
	zn7AgfpXS5GIpajRi7LZFov5NlIN5fGkuKVE+gph7vZl4nnoyRN63LqkoLHlwrmy
	APk5DVrlgRVTOHeuClrkd/8GSPPn7Oblb/JSkhU3dLfWTQIsKqChGA1xHrtUirm4
	A5OeNlvI8XfjAkVPsTPbBFSxdXMcYMWMkNR130MCqL54dgABgsJ/AngXwXlcJdU4
	FU6Kut3mwXoHjcxywTfqCylgL6H1YAd8fw5xE1+miAESgoqmuR7BrfUbfPSgH3fG
	ddLBiizDzryJhYh4t5sm4EKliIyHckdt4FmOyBQxdNyOXhuYFwwDgo8GM7AazmtL
	g==
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013060.outbound.protection.outlook.com [40.93.201.60])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4hbfdu0hv2-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 16 Oct 2026 05:24:13 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t8qj9rkP26km9z38KlVvJiX7ggBzM7LIfIn57ZOz0R4QrbIGfdPGCgwev/6X4HlhYYBTPygzWbkkwnDTch+hCLKKjQaw5DLemWRojVYmrGKb08zMfVg/t/IcMbOpYu6o478rdMdV1AjBB1hQz4JCQYyg1ZXpN7iZePtwryTXw03w58WLxp3GuM9Wq3Ox5OincRdWMXM5E0AaZyAeI6/wCaQVdit3pWr3lUJ0ELj23Z3OCKo2+8rHaryGoOtxu/+pCU64wNfnAB72GN2jTf/inaz6jgwbb/lBmY2YYcj6U+GBUo1r29QklQbaQFXY6oE60OamkkOX7wmGBNJzYIz7Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VEbmIG55HBzNToHg2Zb4PEEbmXg8dOB/S8sM66h+HhI=;
 b=d6qLnhQAS4y4wlG2akU4tGitmTix78hqgFKBJZX6Omjq4dEfQfvBxj5d0lf9Hsy85PTOdkbdFy+f6+adgnInlfNsOIoBdwlTXfXDdhhfA6850obuewPLv0nUojdQvB3fQpLnZcn+K48UuFPSIAxHSe3BtIclvlxMsVjqKqcC4jQ3unYHQqrzSohk+m/OSdywFsKuCVaWCaYzsuOz6gcBqE4CTPHm1+s62ieT4cPG1IxB2FLZX/CpzZ/BGigwbC7vO8Pw9TDnnR/Il27wjhWHhMe+zVfr9/OVgzp/RlNnoQj5wl9qBSZqXiFL+nBNpnnhJRk1wj8XxYFlfGwd15lmHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by LV8PR03MB8138.namprd03.prod.outlook.com (2603:10b6:408:296::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Fri, 16 Oct
 2026 09:24:09 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%6]) with mapi id 15.21.0522.013; Fri, 16 Oct 2026
 09:24:09 +0000
Date: Fri, 16 Oct 2026 10:25:29 +0100
From: Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>
To: Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
Cc: jic23@kernel.org, linux-iio@vger.kernel.org, Michael.Hennerich@analog.com,
        dlechner@baylibre.com, andy@kernel.org, linux@analog.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ad7606: use EXPORT_NS_GPL_SIMPLE_DEV_PM_OPS()
 and pm_sleep_ptr()
Message-ID: <atHtenc-1IRYSRGU@nsa>
References: <20261015151903.13613-1-abdelnasserhussein11@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261015151903.13613-1-abdelnasserhussein11@gmail.com>
X-ClientProxiedBy: MR1P264CA0009.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:2e::14) To SJ0PR03MB5469.namprd03.prod.outlook.com
 (2603:10b6:a03:28a::17)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|LV8PR03MB8138:EE_
X-MS-Office365-Filtering-Correlation-Id: 42ba94cd-6ab3-4eca-ede5-08df2b673b60
X-LD-Processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|56012099006|11063799006|261009223027099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
 uzEKKiVEhGL4DSumEtvyytJYG+Ph/MhgG8L7BeAx4f3HwhXLVn26ozokkOCuqzN4dqWnNUczbWKqDwhzMr0zCN3QuYahnOYfwC7ZDFe2QIuIiuW34nb0ntA6p0vZNYEuBQOLLv8LTbN3RR+R90M3r03bjh+A43YBaR5KszmraISqC3nH3x4in3dQse8gsXLkNB/cx7w5R80aHJkLE7V+VskiN+lFm5ew0PHnQ2IIn48aFkSo9d+E2EJmoTGeuj+hz4fU7Z9vS9Aw9ERYx5ymsHtC0tRo+2UfB615/RDzdYIgjAiBV7Ivy3XltJ6FRw2eiSQnfZkcYyFJ2RG8RRvxoDx5wc3lhKhaYoCuNEKyWGmkXYlh9FNqOCSRuTLtVHYNjSGqhSLvxYxE8X1rC3jTpYvfxfDKOGl/yPfBDLvPIEVuxSzpymqUh4ufPyLwbEMbvNF5oBPflXNgi59uWGKlBhXa+x/ZeraxNdYOb6E4lTohulJhzm0DN47j5uwBbBHFtY29HoEbaIeJOAclYzfseyZ17i9ZwQSNo3kW/mNOVlaGMVSl0WFNiKr7NRsejY7Yb+rNtTxJnWCF01MxytEz36LYYfDpQXDRoqePCnY21XyZJ2SZKioiri8vj8iM3wmIf9/M4Qq3tgmED6aWT9+sQgr8JATcmfsMnhurxmPQJ4U=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(56012099006)(11063799006)(261009223027099003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?dk90MjJYZlFpQXlKdWNLamNSYmxSR1Y1TmV3dzh6U0FuczZxU2U2aTVJSjVz?=
 =?utf-8?B?S2t1eHlqZ08vUFFlbk4xbjYzajNQVWI3eHBNdnUxVDA5MENGcHZxZTdFUTZ6?=
 =?utf-8?B?SUkwR3djSXRTQ3Vvc0dMTlVhUmUrRWQwY2J4dm1nZXE0WDBIWjlVY0hQSEgr?=
 =?utf-8?B?b3Bad25CZEJzRE9GallPTlBkaVhsdDloOHY4a0lXY2R2bUJyTzNMU29hVkls?=
 =?utf-8?B?b2w2Wkl4R29ZTGVndkVLQ053QVdNZml0cmVsMnVoWVNUTU0rUDlIdURUTDds?=
 =?utf-8?B?bVV2cHFycFM0R2t4Ynp1NTd3enFlenVCNmNWenp0QjFtQmtQemoxSFg4K3Jr?=
 =?utf-8?B?bmg3cWF5QUtzTFgwUVc1YU81TGs4U2VKUmxrUEVBY3R1RmF0WUFLcENjVlVG?=
 =?utf-8?B?eTE4VTBiUmRtaDdtNEk4Q2hocHR0K25vRjFsWmJCVXJnRHNET3JQWnZRWWpD?=
 =?utf-8?B?ZTRLcVorSzhqaFBaNXZRV3h4OWN3MklOZnFwV01nWEF1VitsTVU0bmVJRU9I?=
 =?utf-8?B?RVhyc3daVEs2MC9iazZtcllkV1dVYXI5RGRlNXRhVExxbHVIQzdoRzEwQjhm?=
 =?utf-8?B?UDIvZ05WWWlOU1A2aHNGKzZjVlhwL3YxbTJQWG1HclJOaW01T2FWTTJzRjd6?=
 =?utf-8?B?Tk1SRkxNQjZPTDRqRTJOTXlDOHEySVRYZkdIT2xxOG84R1k4dGJxeEpGRjly?=
 =?utf-8?B?RWxJM0RQenNXTmt0SWsyd1E4cEQ1UE96WFBaTWlyOWNkOHVPaE5TN3FkTGFj?=
 =?utf-8?B?SU1XdnUxOVUvT3g2OFo3cDZ0R29vb0djSDVSUC9VUFJyK00xNlBqWDBSU2Fv?=
 =?utf-8?B?bWY2alBkQnUzRVFQMnpDUCtCVUdES3o1Q3pXY1UwKytzUUlNVExpNXJ4Yk9m?=
 =?utf-8?B?ekQzVlp4dlAzM0F1TXBReW5yaVN2aXUrT0l5b1Rnb3BBOEVYZTNDUEdyWXcz?=
 =?utf-8?B?R3pXZFM1TG4zejdPTGpEYmsybDlTZWlWWThJTGpvbWlEYVlTWWpYLytFekVo?=
 =?utf-8?B?bk42cng2eURud0U3bExKWmlKdjVRamNWWnNxSE93bkl1U2w3dk80MWVnRm1s?=
 =?utf-8?B?RlIvUUpOU29TeVNRaXkvNjQ0d2twOUxLd1VBUG9FNTJEeXplZnRmYUxHYmxI?=
 =?utf-8?B?QmlxV1MrSjlWRDZHWDVYTlFsbmUyZFJ6Uzh1dHA2cWc1dVhJT3owRWdKNVJ3?=
 =?utf-8?B?VUJ2bDhadDU4eWozRUdSckpIUk16Zmg1OHExM2FkM0s0WnVOZHhvRmVzYlJ1?=
 =?utf-8?B?anJFeHFDOXpkaUx4S201VmQ1WkNTbGJSbTQwU2pldDRwcG1iQ3VyWll6NlI0?=
 =?utf-8?B?M2RKR3VXTXZUTmhqd0UwejFMMjBySHVYeFRVbCt3bmdNNmxDaTBPcklYcmtF?=
 =?utf-8?B?NE1yQTZCQk5taTNJTnBtOEQySmhGb3I4bXFPQTVrNFlaV0d1K0dUaFV4UWRM?=
 =?utf-8?B?WElFY0trWmRmZjdlczduNlJ4WERZNHVYSDQrRWFrZlpKd1hkaTJpQ3FCb3Er?=
 =?utf-8?B?RnViOGtmUnVoVk1jTzk1cmxMMHVTM01xb1RhV3RDRVA5SWxqM2kzSXlqTDQ3?=
 =?utf-8?B?dXVPR1laN0Qrc05lNmxreE5xUVJmcmlrQXJvQkFkY0NsNkRGQ0dhWmt5Szl0?=
 =?utf-8?B?enlYVHljcWU0d1dUTC9ubFd0OThDaHp4TEN3SXdaL1FPOXorbURZRHNBVm1C?=
 =?utf-8?B?bXNIZXlseVFKRGpCRjNKa0FqT1J6MisyaFBFOW1jaytsU3BoZlVPdk9vY1ZV?=
 =?utf-8?B?c2dsYld3RW9wYktYQjAvQzFmQ3FpK0FZS2dxd043YTVNc1Roa2ZJV1hzQ3Fa?=
 =?utf-8?B?bXl2UVNscWRTSDljT0U3Nkg0M0ZoVFhTOTRtVlhMR1BGOWFiNFFGdUQvS0xY?=
 =?utf-8?B?Z3JrT3RZNTZ1M0RVbUVMS2tFOE9wZDRuYnozNk4xaWo5QVBiTWtaaTV4czAv?=
 =?utf-8?B?dlJEc3JQYWp4eFYxK2ZGdFlDZGFldmxLNy82NUppdnBYeEU3YUJBTWVjOFI4?=
 =?utf-8?B?Um9wQmtiNFJZZ280K09uRjVaNHUrd3E3cVd6aG8vdEhxR01mRnU4d1hCMXIy?=
 =?utf-8?B?OWFCSklGWWovbllmQ1B0OHNHd1c5NmI3aVFEb2l1U0JsdEtNT0FiYmtlemNo?=
 =?utf-8?B?SmYvcUUyek5SOHlMSkRiOVlIcTBYSTFLaWlvUHhteE5RdWtRNUlyNTQzTFh2?=
 =?utf-8?B?MzVWVThmcFFJTC9MYnFQcXZhd2JUVDcwZWtDRFdneWZ5amtvcjUrbllZTEo5?=
 =?utf-8?B?ZFlMNzI0ZFlUMEJvM3JzSHZiNVdFRlNPakpKNGtuV1pBNGhsUnZHR2Z5S1o0?=
 =?utf-8?B?VmJiNGtIYjA1OFQ4bDJjOG9XY3pLRzFtUkI0a3RlbHFBZWVjTGV5UT09?=
X-Exchange-RoutingPolicyChecked:
	pnhMl9B607/0p1Yh655qv++BaU9XN9dMLEX28KN2Lts9+AU33bWQYs03HDztGem1no2egij6I1WuYQBlLsM7oOydoU9nNKYM1wQFO6Ml9R6kkW+glTFyWtzYK3DwAqqqRHDIQlVgS14KGRNfmx5+v2Z+tvxkLwtUlnrjiLJ89Dt9BdFUOkAyStu55RQUU4J2lDYVth9wPBrifhL5zvIEakW3VoAjGiO3LSK1lETBgA+ZsH2BCMbXK61Ecc4hNvs8MFKLsUNA8TzDeddmHFtkCzzZD3XyFhCHmTkxsiGP5rrxwo0RCfEkbI2rrOrUM7Yq8+GizG93mu2ag7Koz395KQ==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42ba94cd-6ab3-4eca-ede5-08df2b673b60
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 09:24:09.2626
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4Vs9OXwDJlLMebTrVkaz13tOiFhV0Z47ufxxx8nsRzAoh/lyVNJsMOQxn1pqBiyqa6dRjQ9SvCGGa6bXfyjPRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR03MB8138
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDAzNyBTYWx0ZWRfX2tkqtD2BNSLa
 oY38SPAr18m328CJJBKu+AaA8PSBLqlvtTqd/jH5NVD06GYlywIVkG8GVIWazlXApziW60V7kyE
 sSI7dtQkoupvEDQDTNO47yXVoVrB9o7zxNoSEbSb0JGKoRPwOOm3xDJpusLKbO9jbjkJnvSytJk
 9HAu7uQQT7d5ZyN5LDLKMp7BL0EhvHT8TG2M/TJ15Pn30K/GaNSLXBlIClCik7G3q+fQKbHuOjx
 GMUbegk55UTw2wmmZECkLgrxKfmPlkTBobrhcuZUJkMBB+f0CSTq2g4BD369gQuPmBdN6g8s8zw
 VseK2jsdZCBvvz7xxvi+4H7mjX2edViNTFwlQLP3pjvqiPc6DHnqxmkhqt0jBJO4x8haehjYHbO
 +su9CWiKLpee8X8dj4CNp2zV1NojS4DyBSz2Rm7FmZRdtO3k/C7LMrFnPnkC6NmOI1xQFcDl7AA
 O87k6M8+uYjmCFuJ3Nw==
X-Proofpoint-ORIG-GUID: 3goiw0YjeCg9QxgCdaBS_8LBuBIghSiS
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDAzNyBTYWx0ZWRfXwvJb3enfZ8Rm
 bDQdetE3kDQcRezgbeahzXqbHGtxdOjizVgNJyJQQmjiFsInn0nb2sckl47dOKYPpN8w/dvjg3L
 xJZ11T/aF5PBnX/lvLPwPLNOvP38PINxJ+mF53YRlHBHk1k/dWJs
X-Proofpoint-GUID: 3goiw0YjeCg9QxgCdaBS_8LBuBIghSiS
X-Authority-Analysis: v=2.4 cv=PvAG/AM3 c=1 sm=1 tr=0 ts=6ad1ed3d cx=c_pps
 a=7wCTOXyfr6KSlQaUtw4X3A==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=ZQxX5BWu6Z8IJBb2zLX7:22
 a=pGLkceISAAAA:8 a=gAnH3GRIAAAA:8 a=kV4nuC8mnj45vidqhlYA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 spamscore=0 bulkscore=0 impostorscore=0
 adultscore=0 lowpriorityscore=0 clxscore=1011 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610160037

On Thu, Oct 15, 2026 at 06:19:03PM +0300, Abdelnasser Hussein wrote:
> Replace SIMPLE_DEV_PM_OPS() with EXPORT_NS_GPL_SIMPLE_DEV_PM_OPS()
> and use pm_sleep_ptr() to wire up the power management operations.
> 
> This allows dropping the #ifdef CONFIG_PM_SLEEP guards, simplifying the
> code and improving compile test coverage of the suspend/resume callbacks
> while still allowing the compiler to optimize them out when
> CONFIG_PM_SLEEP is disabled.
> 
> Signed-off-by: Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
> ---

Reviewed-by: Nuno Sá <nuno.sa@analog.com>

>  drivers/iio/adc/ad7606.c     | 9 +++------
>  drivers/iio/adc/ad7606.h     | 5 -----
>  drivers/iio/adc/ad7606_par.c | 3 ++-
>  drivers/iio/adc/ad7606_spi.c | 3 ++-
>  4 files changed, 7 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
> index cebb8ed8dcb1..e71ff8d38e4c 100644
> --- a/drivers/iio/adc/ad7606.c
> +++ b/drivers/iio/adc/ad7606.c
> @@ -14,6 +14,7 @@
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/mutex.h>
> +#include <linux/pm.h>
>  #include <linux/property.h>
>  #include <linux/pwm.h>
>  #include <linux/regulator/consumer.h>
> @@ -1673,8 +1674,6 @@ int ad7606_probe(struct device *dev, int irq, void __iomem *base_address,
>  }
>  EXPORT_SYMBOL_NS_GPL(ad7606_probe, "IIO_AD7606");
>  
> -#ifdef CONFIG_PM_SLEEP
> -
>  static int ad7606_suspend(struct device *dev)
>  {
>  	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> @@ -1702,10 +1701,8 @@ static int ad7606_resume(struct device *dev)
>  	return 0;
>  }
>  
> -SIMPLE_DEV_PM_OPS(ad7606_pm_ops, ad7606_suspend, ad7606_resume);
> -EXPORT_SYMBOL_NS_GPL(ad7606_pm_ops, "IIO_AD7606");
> -
> -#endif
> +EXPORT_NS_GPL_SIMPLE_DEV_PM_OPS(ad7606_pm_ops, ad7606_suspend, ad7606_resume,
> +				IIO_AD7606);
>  
>  MODULE_AUTHOR("Michael Hennerich <michael.hennerich@analog.com>");
>  MODULE_DESCRIPTION("Analog Devices AD7606 ADC");
> diff --git a/drivers/iio/adc/ad7606.h b/drivers/iio/adc/ad7606.h
> index 2951bb731354..c60f71a38883 100644
> --- a/drivers/iio/adc/ad7606.h
> +++ b/drivers/iio/adc/ad7606.h
> @@ -241,11 +241,6 @@ extern const struct ad7606_chip_info ad7608_info;
>  extern const struct ad7606_chip_info ad7609_info;
>  extern const struct ad7606_chip_info ad7616_info;
>  
> -#ifdef CONFIG_PM_SLEEP
>  extern const struct dev_pm_ops ad7606_pm_ops;
> -#define AD7606_PM_OPS (&ad7606_pm_ops)
> -#else
> -#define AD7606_PM_OPS NULL
> -#endif
>  
>  #endif /* IIO_ADC_AD7606_H_ */
> diff --git a/drivers/iio/adc/ad7606_par.c b/drivers/iio/adc/ad7606_par.c
> index 5b137e947f0b..986c15db90c7 100644
> --- a/drivers/iio/adc/ad7606_par.c
> +++ b/drivers/iio/adc/ad7606_par.c
> @@ -11,6 +11,7 @@
>  #include <linux/io.h>
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
> +#include <linux/pm.h>
>  #include <linux/property.h>
>  #include <linux/types.h>
>  
> @@ -251,7 +252,7 @@ static struct platform_driver ad7606_driver = {
>  	.id_table = ad7606_driver_ids,
>  	.driver = {
>  		.name = "ad7606",
> -		.pm = AD7606_PM_OPS,
> +		.pm = pm_sleep_ptr(&ad7606_pm_ops),
>  		.of_match_table = ad7606_of_match,
>  	},
>  };
> diff --git a/drivers/iio/adc/ad7606_spi.c b/drivers/iio/adc/ad7606_spi.c
> index 8c479fa50a23..10df12311561 100644
> --- a/drivers/iio/adc/ad7606_spi.c
> +++ b/drivers/iio/adc/ad7606_spi.c
> @@ -9,6 +9,7 @@
>  #include <linux/err.h>
>  #include <linux/math.h>
>  #include <linux/module.h>
> +#include <linux/pm.h>
>  #include <linux/pwm.h>
>  #include <linux/spi/offload/consumer.h>
>  #include <linux/spi/offload/provider.h>
> @@ -502,7 +503,7 @@ static struct spi_driver ad7606_driver = {
>  	.driver = {
>  		.name = "ad7606",
>  		.of_match_table = ad7606_of_match,
> -		.pm = AD7606_PM_OPS,
> +		.pm = pm_sleep_ptr(&ad7606_pm_ops),
>  	},
>  	.probe = ad7606_spi_probe,
>  	.id_table = ad7606_id_table,
> -- 
> 2.54.0
> 
