Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.135.77
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793700620;
	b=xsiRdI3M0HDqQa+Z79cVQYa36QER8K86rKg+JpvPnmsq9+gS2l7qOeZdiKjJb6ZKaAfp
	 LNUljvFAFD1lV98O3eA7+l6m/4Yd9iHTkAzmekvmzjj5yK69ddj7WiekLmyN80R9irmEa
	 RMqL9UO8JNx1qIKW5ptfS0F7m4ikU1w/rNEbSOyi8l+aY6j1C9NYMk691dOlOT/JMn+NB
	 BHkJRilElbjhgDNFumI4sSTF0CN+8CvMebn8tGG+SjF5emxoM/JPypKzLYPY6jcUZlrsW
	 dAtJ1qEskY2BYBvzhmurpfTNbZFnPlIDd8EdyXVXxFDaMXXBlGALr2yFYOu+PektVGQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793700620;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-LD-Processed:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-OriginatorOrg:X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=Qtg6Q4uFj6Pfb9Et0IVYMwfMicmCxLy8Rt4YE6W8UGg=;
	b=4Xl3D7UeO7DAZLFRTiMXzKZqhZX382DKNpI3vzw1lyTrliAvFc61JoR0/8Hnpi7GmuoI
	 KU9f5fp+NDFQRTnd5rU4jPqFkrY+jvc2twV51Quy30/BU8wyk4EIZbUDPoVof1bKVz3wr
	 Dxgb/2A6NGhhdtHpstzwn/zGEYMtI4MeAm2wifXXh40X0O9bSZrMYIBknzdQtzlVBhDz+
	 Rn1ZVja9iQzjCDhbHFyOPMCa/jtJjvFcxwfwM1aqEkR8z4ZCrEfXsYVPBciEhfvXAJzw9
	 iOnkaV3UZSnmsbP3r/OEwi9Aibt2mix7eG/oAJpOCmvEiAyE/ipKuAZBv9dbG/14bfQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=EgohvfWo;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b="YOIJ/l4X";
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.135.77
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED9360A2618;
	Tue,  3 Nov 2026 10:10:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0ED9360A2618
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=EgohvfWo;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=YOIJ/l4X
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A3A77HO3035599;
	Tue, 3 Nov 2026 05:08:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=Qtg6Q4uFj6Pfb9Et0IVYMwfMicmCxLy8Rt4YE6W8UGg=; b=EgohvfW
	oVqdbLCz1ePsFTi9txbdLUUc2BoE2qkrFhgy1TG1dNTYma7SWbMDGrwjBNkiCi0j
	Z8NiyIifdb7+fbnk4MeY91udBMhM164prQl/+fQ2MVevYOTZFFtzIsXdgmqdJ21S
	NOmptjvs9kCz8A/Ep9FTiaNtG3ktD5ugq+ZwH4PJDomIrZaHd2t0jpRopZ+VRzcY
	TkI5Zm/aMMBwmCGXTTRlcFkEWNxqGbRhZSxYdxScQh1ByuVul7lPBZvDoOnAsJAR
	QjzJir3r4mobzPKfATzUrmihXlYZNGr5ulDoce0XszIGpE9f/KEcCRprLGfR7gtF
	bZiv26JUZnlYRhA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=Qtg6Q
	4uFj6Pfb9Et0IVYMwfMicmCxLy8Rt4YE6W8UGg=; b=YOIJ/l4XqUt61OvDpz4Jd
	n1HlbSbcmGCz/OUE4hEsEdNHIECMJPSN9080gPh4nk66Ynr09Sz3h/G+It7PwYMi
	laCyVimxxT6jtY+MP7Wr70cZ4Hjvrc+9wr55rOnkJPMlFNDry1X+6WNbhufx9wnX
	6r19KYD1hh2Am4W5Qjz7at4CxXHXTzgFKjEX++qrRrSS+jdUIZd9MGwhCDbfC93Z
	VUdIou95yIgEyykTZluj2/VUz6teo7YgTqEmM7l6PSQBaTOantD5CjXmVm5OpNgH
	3MZs0HPCFMRneoj4vwKVSARChGGgGtmB9wVrxXT55jDU/D+szvoHtO21ptJfPEOd
	g==
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010022.outbound.protection.outlook.com [52.101.201.22])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4hpjhb0h7x-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 03 Nov 2026 05:08:47 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YtbvCN2Yq3ZE86zRfss1N+CwdjkGOhWFGenjQ0GTu4ADXjAp8xQW+5AE6LU0SCO3odxOnHN58Kxd8zQ8lofzFMkANETcwTvexIQLHXobbq4mCJpZmuyrRPi4sLVwC6YTY7vV1m1l5A7yO7qPXBy0OpMb7JwG1dD278FbbYgSv9s48HwuLkj2kEKRYGGQ+9dd1G1Ty8DLB+rpFT+vvmzIPYbIGdm3Kffq0kQA/Z25HNX0epMwkvwsbNRR0Aq+kkRGI4Oik/hx3A7LPBRF7jq3DRiDAVjWpLDstR5ksjdyn8Hpp+mQsYniIhZqYRu7zOn/cd/VxMsKqKoFjVEN/XSbzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qtg6Q4uFj6Pfb9Et0IVYMwfMicmCxLy8Rt4YE6W8UGg=;
 b=fooS2hqRE93gpvlnTNHp4yfVuPe6B+y0EElR/wSfpxPh9App9lxs8eg2RVZJ1lHaF+rQi3U+kNYhg2nSjXGNfn4nZpaUfsxyW1Y5aIMngzQW6Sh1p5vLY/bUHbDxaQhiTLXUwoOx3/mL2DhtxpNjh/RdhaXmEJQQcJF+X52IR5wySamgtRog4o9/cklc2Y/Sat5NXNlxgTdMSeEEBpX79ZtMK4lDy+KO4xQ8YczQ1N/W7N+zurq+58jvk3EjHnb1BmByGfT8zAxNFjrehsdps9gGDiaPhT6KyBBKy1XD6ThHA1AU00rPRqDrqJr+C0ZXB644EnxFeTt57ZzvUkFXCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by SJ0PR03MB6928.namprd03.prod.outlook.com (2603:10b6:a03:43e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Tue, 3 Nov
 2026 10:08:43 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%6]) with mapi id 15.21.0569.011; Tue, 3 Nov 2026
 10:08:43 +0000
Date: Tue, 3 Nov 2026 10:10:00 +0000
From: Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>
To: Frank.Li@oss.nxp.com
Cc: Eugen Hristev <ehristev@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        Andy Shevchenko <andy@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>,
        Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Stepan Ionichev <sozdayvek@gmail.com>, Felix Gu <ustc.gu@gmail.com>,
        Frank Li <Frank.Li@nxp.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>,
        Shuvam Pandey <shuvampandey1@gmail.com>,
        Piyush Patle <piyushpatle228@gmail.com>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Cheick Traore <cheick.traore-ext@st.com>,
        Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>,
        Vinod Koul <vkoul@kernel.org>, "Rob Herring (Arm)" <robh@kernel.org>,
        Shi Hao <i.shihao.999@gmail.com>, Kees Cook <kees+treewide@kernel.org>,
        Michael Hennerich <michael.hennerich@analog.com>,
        "open list:MICROCHIP SAMA5D2-COMPATIBLE ADC DRIVER" <linux-iio@vger.kernel.org>,
        "moderated list:ARM/Microchip (AT91) SoC support" <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:RENESAS RZ/T2H / RZ/N2H A/D DRIVER" <linux-renesas-soc@vger.kernel.org>,
        "moderated list:ARM/STM32 ARCHITECTURE" <linux-stm32@st-md-mailman.stormreply.com>,
        imx@lists.linux.dev
Subject: Re: [PATCH 1/1] iio: use dmaengine_desc_set_callback()
Message-ID: <aumy54xlBDsIEnoN@nsa>
References: <20261102170911.3867389-1-Frank.Li@oss.nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261102170911.3867389-1-Frank.Li@oss.nxp.com>
X-ClientProxiedBy: MR1P264CA0136.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:51::9) To SJ0PR03MB5469.namprd03.prod.outlook.com
 (2603:10b6:a03:28a::17)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|SJ0PR03MB6928:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b7ea956-cf01-429b-38a1-08df399270dd
X-LD-Processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|7416014|366016|1800799024|376014|23010399003|18002099003|22082099003|10067099003|56012099006|261102123227099003|261009223027099003|261009221227099003|261009220027099003|261009221727099003|261009223327099003|261021121427099003|261021123027099003|261022075727099003|11063799006|261026121527099003;
X-Microsoft-Antispam-Message-Info:
 V2u+ItOj3n0za6q0gPhAd30YST01s6u2g+tBM+NR5s3mtNiMEESiML5ck3epMAbRHxULusjXgU9rZ4GqvGQ/jtJ4SYw1p9fQkcXfhsNuK89BuYEL72tkariwEkF4ZYqTusD5XoXQGR5vSSMQ0Gr5CDxi/+Wsled38mDQZkThUc6h5KNhQU51xcRjCQ933I2FXF1gy+fK2I4AdAhrrbPMMndOZDNqu1uqH3cGe2MLqnRUAqA5Vt15BGz9dEVhJVn/a5S8jQmZNb4Wz3jWPt2JGX6vLJKsp0iyoxLPKHKT997lIBhBaJFyoY+xePhXqQedCTwcmkegM2pAcPoosYRhUGg5HEuQCJH1JhFreW6ZpVCsfSM0NJj5Uu5zF2UcPfvdYwM6MxRTWkgPHuRQHrIlMh1BAX9GRryuZ2hIj5wifUmES4o7m5cdqPTQS30yZW3fG10WjdPXbn3kEzLc+fPM4V+npIy0ZtRQZ7sRGa099GesfaCpmXxe7wj8ChA9jjC2xxw1lwhOXE7d2xOl5MNPBxMxPfcvtZ/sdpRrq7jZffC7kr8PVxJKh+PfBUOQM+x9GKKUJ6tIchO86UsooqF8pfEfTnrAAFgrWI+vSfrVZBnRtrxMT49tNYckU1ETNICgLETE9ZNJ1dzzw4ER1KG8S4ZeRgwEPLwzS8xhY+mTgdE=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014)(23010399003)(18002099003)(22082099003)(10067099003)(56012099006)(261102123227099003)(261009223027099003)(261009221227099003)(261009220027099003)(261009221727099003)(261009223327099003)(261021121427099003)(261021123027099003)(261022075727099003)(11063799006)(261026121527099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?Mmo5U3JKd0kzNitDRFA1MDY3WGZpK214bUdXUUFjTG5tYmFTQVlYUVlhaXNn?=
 =?utf-8?B?dTR2WXNFdWRldjFDTFRkaWJzTkRFbWJ4d0ZpYlFZdHBHaERNZ2Q1a2FVb21E?=
 =?utf-8?B?ZmRycDFiVGRsQnRUclZqalJFNE5uOTRpVUp3T2RpakRsbFk2Y0RNMll2ZDNk?=
 =?utf-8?B?UDc3dU5NVGFWK0R1a0MvTy9XdVBiNVhxSDFrcGJFeFQxazNIdXhaZGZpckYz?=
 =?utf-8?B?bm9PSDEzeVM2ZUJDdVVMSmhKZi9rRVN4UWUvd2JTYXRNdUl2RUpERHBjdXpM?=
 =?utf-8?B?ZXYySEQ1UThDakxUUjJzRGprSmt4OStOS3NlQk9GMzkrZDVPakxZUkcyNXFK?=
 =?utf-8?B?dWdpc2dNbFdYZUczS1FIWjdWU21XRGFBSEd6emVFT0xGcEdVTlVXUG8zRm1K?=
 =?utf-8?B?WFhCOHk3Z0ZwWFJJUmFwMURZMy9iUHdYUFhQRzhXOCtFeXNQTU9ZU3hwdEp5?=
 =?utf-8?B?eEc0TzJjemU0cU1UMUg3QWJFSGRVRnJET1g2VGZjTU9yQ3V2akdEYURoTXJH?=
 =?utf-8?B?UXpkTE91ZkZ5aC9BL0U1b0NnNzdhUEZGVDI1OHpUWjdpbVpiUEU3MW1UTzVq?=
 =?utf-8?B?WXdJTjJlMGFMR2ZIVWlPMW9WMVVxa3c2V0VZZ3F6WEd6ekpuTU15S3QwbzJY?=
 =?utf-8?B?TXpZZXI0V1Ywd2NtT3ZqNzBpVlcrRmkrVldJdTVQeDRwY3picXYvVys3Ulhy?=
 =?utf-8?B?cmZYT055S21paFM3ZlpjRHlkMlVaSEFjbXZDK001OEhPdU4ybHdBcVI5MnVV?=
 =?utf-8?B?RmVVZGlHMEc1Vmk5NEhjSVF0Uk5ORktFc1hTSWJCQWVxcFYwUlU2aTJCRmlJ?=
 =?utf-8?B?TGU0aGtTRVJlU3hiajhYdFIyK3d3Nkpkc1diMnYzdTUxNVRiYUZ6UEwyZ3Ev?=
 =?utf-8?B?SUxPeE9rKzRpRml0czRiUzFORHZxaWpxeWtYSGFXK2tlSUN3RmRKTjZIc21s?=
 =?utf-8?B?WExBR3ByNlRJT1BjWFZSUUxUWjFRcHNoMjFPeVBsRHJVK0EwRmlVek0yeTc2?=
 =?utf-8?B?UDJVRjVQSGJ3alJzcWd3SDlXR003bnhmajQ5R3NJOURnWTVDOHBvTVVyS1lo?=
 =?utf-8?B?a3pZWWpjT2lTdXNzUkFGeElHQlN6VEJDVGhsajdHbEU2ckFSeStBa2h5blJU?=
 =?utf-8?B?MGtRckxiZE9DMDUycGFHU0NUaG5KNVFtU3dKblpYR1VDQ1ZoRmY2YklQSjRs?=
 =?utf-8?B?d2pkc3U5WFRBOHZBTlZnSUVtKzBERDFFOU1yRmVCMjBoaEt1SFFVSmxudE0y?=
 =?utf-8?B?MUI0aGkxbjZRZDdkVWdVd1dZRW03L0FMQkZDSG1FTGxkTHRpVWg4cHJ3bTM4?=
 =?utf-8?B?TWhEQ1pjdnRwVExVQWlyNUpkVnV4clZkVk1PMlJvcUpRU2d2czUzTUhGZFNS?=
 =?utf-8?B?d2VjeVk0dDBSSm91aDdhbWFJOGZicFNkSkpPN2Z0Y2Vwa1BYRFBOc1RhWmtQ?=
 =?utf-8?B?UFNWRm03cjkyUHd1cllWSTRFQVAxblN0Uy9NMWtMMkNVNWdMQjgxOUdjTzdw?=
 =?utf-8?B?akhYS3M4SmU0MlFGVzFDYk1JdjRDZ2ZsZzM5bGNMMjJvRDhwVUU3OFhHNEFm?=
 =?utf-8?B?cG5EWU1abUJEU1dVclN1Qy8zZTBoL1Y0dm1sYlBsNE1PcU9HTzUrc3B4WWVy?=
 =?utf-8?B?dFpod3FQY2x2QjZvSXliVlRybmxQb2Fla0pHTzkzVGRvRXQzdGQ3ZzBRYmlD?=
 =?utf-8?B?dWRRdEYwaUNya2VjWkljZWNQS3lxNGZ4UkVFMEszUTFjdFMvTDROQkJYOXpp?=
 =?utf-8?B?a2cyL05wejRhdUo2M212MkloOXpVWUtNbWdnYjJCQWl0UlBHZFl6UW85Ym5w?=
 =?utf-8?B?aStIai81UlVuaC9qcDVoRWtMazY1TVl1citFR1ZXVEdXTGVEMzBTMDJ6Njht?=
 =?utf-8?B?R0Q5ZkZqSDRCQytndCtTMGVFT2NrUGhaZEdZL1p2ZWFkTEVqemJWTXJCUE5Z?=
 =?utf-8?B?bE5YSDJaTzU0V3ZjemtIeHpyTW9rOXc4TGlYMlVUbVRDUlN6TEpQNWdWQ1pR?=
 =?utf-8?B?dWJnOGNSUXJLSzlRTk5FN0IxUHQ1Q2w5SjZDYWhhcUd5ZWFOdVQyMGpPcmtm?=
 =?utf-8?B?blVuYjllT0NKZEtJVHpWbVJUNUlSQlIvK0IvQ2VyUVRCUEhnaHo4SWJ6TEgr?=
 =?utf-8?B?TG5YbGxkbHk3bUVjaGVEQUF1OU0xMXQrVnlPK3pGcHd5YlRzVEVkeFluMXVE?=
 =?utf-8?B?S2lPY3djaXVIUkFIelpMSjhOWTZTenJpWHUzRzMrWkZVNmViMVIxbDV0dmJr?=
 =?utf-8?B?Q3VHVXZYY3JLWmxuK3FLWjZQcGhzY3BLN0VzQnd5YkhCQkF4WWNCUmgvVC9I?=
 =?utf-8?B?c3hQNE5ybFYrUXFuaUxNOE5Cc2xtZUdUdzVyL3d2SFlXcHB1UWhJdz09?=
X-Exchange-RoutingPolicyChecked:
	pY8UisV7DKheHBWr8LuN5qwnPTedOUyp9EQgyTu3Lo8o75FhLgqRlM/+P1tOqnAc0HX1vxb9/JaiutncgjSWiUsVXSsH5ns8zc0HkeyOTaBDDm5Uvr0xqTyFlzTsL+HcvtKu7uCctOydlqzqjT9mPupnC+ooH6h3X+TrDWPTeg5vrCgR6iygofdxhO8VAHTG7asmpUiRE1ZNnT1NjRIivWRuUNbqdekb4ahVjmL3S/vAB7/itbS+rsT03nne6qlp59IEozrqdkmjITqwpyP0c6dAD21kWEO5znGsuBREmQLWooRykbh8vqhCtQr56WKMqFJ11NjxrIlWNlPVfAiN2g==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b7ea956-cf01-429b-38a1-08df399270dd
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 10:08:43.2890
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NpJACCmqN9GrHw7EH6pt9r4VaEzW5qr2QicApuoIsLJUxc4R1zzI3knnc49cICj/rSHy+809ijvgeC5XVh0GIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB6928
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDA0MCBTYWx0ZWRfX38vqQejusvQs
 ORmorYYUG1ouR65FTAQtADOyuyPmzKQV7npIgyhfu6cEItVWXdm/xzRNb5ASYBaaqxG9Oa1O4r6
 k7SqDeT1Gy4E3DftpH2ac4yK8wCFeuwdCaEn3VzEQcReFDfWvAgL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDA0MCBTYWx0ZWRfX9HtpuVwoZJ6y
 t/MrgyA0yxD+vxt+NOSLOhWV1CeIw3XaGxeZgLv3ee7dFu3p+iYL2NIprarqQX6FrJT5qXMvs6+
 1pgJ2czb4hWT/kBqSacGqrbgRzrXQxk9XA72ZkQKXUZhclSlcb+rYLJtv0wDD+1dTVZhHJtSLxT
 kliAV84Qv8RMzcPFK7H93qgmpHcfPinxMREOM3fWYggOyTlO5EBFqRbAAQ6Erv9i5SOxj6Wr4xT
 YcqO72qQF5a4Fpg/uSx+LuW/f8ONsPrrWqZR55yF8bes600TZvsRi8qnR2TlQbma+7JJiq8+M8U
 hyBmzjrNPIdlARB24hKo/n8WyasrZscJX+vbiv9r49V3OedCde85RR4TXYHGyMNELkTSpl3VB2i
 AiM2eUyG+CRUQXT2xr+LrUbkpb8zz3SZyB8qx/YNIilBAyXXp+d+K7tWc+GM/wDrQz2Pw8mKlB9
 +AtXDMGvfxlU4Vhhyww==
X-Proofpoint-GUID: 4ql0WW4GpfndlRdRmIGOotx9BSn9RKN7
X-Proofpoint-ORIG-GUID: 4ql0WW4GpfndlRdRmIGOotx9BSn9RKN7
X-Authority-Analysis: v=2.4 cv=cbtHPXDM c=1 sm=1 tr=0 ts=6ae9b2af cx=c_pps
 a=e6472ZuTPXVkOcUbIheXHA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=Z0pTeXoby7EwIRygza74:22
 a=8AirrxEcAAAA:8 a=gAnH3GRIAAAA:8 a=IEC2Qzn63R3Si0Y1CYIA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=ST-jHhOKWsTCqRlWije3:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_02,2026-11-02_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 clxscore=1011 malwarescore=0 bulkscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611030040

On Mon, Nov 02, 2026 at 12:08:47PM -0500, Frank.Li@oss.nxp.com wrote:
> From: Frank Li <Frank.Li@nxp.com>
> 
> Replace open-coded assignments to callback and callback_param fields
> of struct dma_async_tx_descriptor with calls to the
> dmaengine_desc_set_callback() helper.
> 
> No functional change intended. Prepare make to struct
> dma_async_tx_descriptor private to the DMA engine.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---

Reviewed-by: Nuno Sá <nuno.sa@analog.com>

>  drivers/iio/adc/at91-sama5d2_adc.c                 | 3 +--
>  drivers/iio/adc/nxp-sar-adc.c                      | 3 +--
>  drivers/iio/adc/rzt2h_adc.c                        | 3 +--
>  drivers/iio/adc/stm32-adc.c                        | 3 +--
>  drivers/iio/adc/stm32-dfsdm-adc.c                  | 3 +--
>  drivers/iio/adc/ti_am335x_adc.c                    | 3 +--
>  drivers/iio/buffer/industrialio-buffer-dmaengine.c | 3 +--
>  7 files changed, 7 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
> index 78081cbfde5e8..d479c9bc9b3e8 100644
> --- a/drivers/iio/adc/at91-sama5d2_adc.c
> +++ b/drivers/iio/adc/at91-sama5d2_adc.c
> @@ -1240,8 +1240,7 @@ static int at91_adc_dma_start(struct iio_dev *indio_dev)
>  		return -EBUSY;
>  	}
>  
> -	desc->callback = at91_dma_buffer_done;
> -	desc->callback_param = indio_dev;
> +	dmaengine_desc_set_callback(desc, at91_dma_buffer_done, NULL, indio_dev);
>  
>  	cookie = dmaengine_submit(desc);
>  	ret = dma_submit_error(cookie);
> diff --git a/drivers/iio/adc/nxp-sar-adc.c b/drivers/iio/adc/nxp-sar-adc.c
> index 2f716a2f97b80..82d8d921b0293 100644
> --- a/drivers/iio/adc/nxp-sar-adc.c
> +++ b/drivers/iio/adc/nxp-sar-adc.c
> @@ -696,8 +696,7 @@ static int nxp_sar_adc_start_cyclic_dma(struct iio_dev *indio_dev)
>  	if (!desc)
>  		return -EINVAL;
>  
> -	desc->callback = nxp_sar_adc_dma_cb;
> -	desc->callback_param = indio_dev;
> +	dmaengine_desc_set_callback(desc, nxp_sar_adc_dma_cb, NULL, indio_dev);
>  	info->cookie = dmaengine_submit(desc);
>  	ret = dma_submit_error(info->cookie);
>  	if (ret) {
> diff --git a/drivers/iio/adc/rzt2h_adc.c b/drivers/iio/adc/rzt2h_adc.c
> index 8ba7b0fde8a19..3e52b7d660dd3 100644
> --- a/drivers/iio/adc/rzt2h_adc.c
> +++ b/drivers/iio/adc/rzt2h_adc.c
> @@ -394,8 +394,7 @@ static int rzt2h_adc_start_dma(struct iio_dev *indio_dev)
>  	if (!desc)
>  		return -EBUSY;
>  
> -	desc->callback = rzt2h_adc_dma_callback;
> -	desc->callback_param = indio_dev;
> +	dmaengine_desc_set_callback(desc, rzt2h_adc_dma_callback, NULL, indio_dev);
>  
>  	cookie = dmaengine_submit(desc);
>  	ret = dma_submit_error(cookie);
> diff --git a/drivers/iio/adc/stm32-adc.c b/drivers/iio/adc/stm32-adc.c
> index 600f975f1d7b5..fa2a781e37777 100644
> --- a/drivers/iio/adc/stm32-adc.c
> +++ b/drivers/iio/adc/stm32-adc.c
> @@ -1901,8 +1901,7 @@ static int stm32_adc_dma_start(struct iio_dev *indio_dev)
>  	if (!desc)
>  		return -EBUSY;
>  
> -	desc->callback = stm32_adc_dma_buffer_done;
> -	desc->callback_param = indio_dev;
> +	dmaengine_desc_set_callback(desc, stm32_adc_dma_buffer_done, NULL, indio_dev);
>  
>  	cookie = dmaengine_submit(desc);
>  	ret = dma_submit_error(cookie);
> diff --git a/drivers/iio/adc/stm32-dfsdm-adc.c b/drivers/iio/adc/stm32-dfsdm-adc.c
> index 674767da3ac37..f0239f5f30afe 100644
> --- a/drivers/iio/adc/stm32-dfsdm-adc.c
> +++ b/drivers/iio/adc/stm32-dfsdm-adc.c
> @@ -1006,8 +1006,7 @@ static int stm32_dfsdm_adc_dma_start(struct iio_dev *indio_dev)
>  	if (!desc)
>  		return -EBUSY;
>  
> -	desc->callback = stm32_dfsdm_dma_buffer_done;
> -	desc->callback_param = indio_dev;
> +	dmaengine_desc_set_callback(desc, stm32_dfsdm_dma_buffer_done, NULL, indio_dev);
>  
>  	cookie = dmaengine_submit(desc);
>  	ret = dma_submit_error(cookie);
> diff --git a/drivers/iio/adc/ti_am335x_adc.c b/drivers/iio/adc/ti_am335x_adc.c
> index e53c839e87ef3..230f1c990317a 100644
> --- a/drivers/iio/adc/ti_am335x_adc.c
> +++ b/drivers/iio/adc/ti_am335x_adc.c
> @@ -259,8 +259,7 @@ static int tiadc_start_dma(struct iio_dev *indio_dev)
>  	if (!desc)
>  		return -EBUSY;
>  
> -	desc->callback = tiadc_dma_rx_complete;
> -	desc->callback_param = indio_dev;
> +	dmaengine_desc_set_callback(desc, tiadc_dma_rx_complete, NULL, indio_dev);
>  
>  	dma->cookie = dmaengine_submit(desc);
>  
> diff --git a/drivers/iio/buffer/industrialio-buffer-dmaengine.c b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
> index b9f8b5b3aa6b6..7ecb9d875b8e8 100644
> --- a/drivers/iio/buffer/industrialio-buffer-dmaengine.c
> +++ b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
> @@ -160,8 +160,7 @@ static int iio_dmaengine_buffer_submit_block(struct iio_dma_buffer_queue *queue,
>  		return -ENOMEM;
>  
>  	if (!block->cyclic) {
> -		desc->callback_result = iio_dmaengine_buffer_block_done;
> -		desc->callback_param = block;
> +		dmaengine_desc_set_callback(desc, NULL, iio_dmaengine_buffer_block_done, block);
>  	}
>  
>  	cookie = dmaengine_submit(desc);
> -- 
> 2.43.0
> 
