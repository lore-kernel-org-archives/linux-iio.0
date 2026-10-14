Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E135632BF;
	Wed, 14 Oct 2026 16:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791996867; cv=fail; b=QTrfvghTOnD7tW9gQAlQYR5eGH+ZSjY0A3g281X/uDdM91P4CGKM+HNK36GQYKcdWMiAxMtMCJ2m8l9wARSTmPYWHkcQPDMHByNFUU5ELk0LyDz8S2rw84LxnUc4Xxfuz5dQ1Jd9F0yIcTPj0IIr0HCDx8ZRIhz/KbFc4LGnRGk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791996867; c=relaxed/simple;
	bh=oVgIMhpAtj90TGOaGTzd+jvrpC9E5g4vxxJwgzaDRGg=;
	h=Content-Type:Subject:From:To:Cc:In-Reply-To:References:Date:
	 Message-Id:MIME-Version; b=OoOEWtKhBMo5Jfpjv7d7W46elDzE+EwHIdccA3cqelTd/IE8KW4Hu3K9iYdpxTJyRCU7yThjeCWmY0uHDORe0oaHn8t5/UO6SSxepImgxNbmZfi15tcWjV9wHswJNZqdiGL6UeWy3/Pb9CyZF1tB23p0jJyfd6WvIt/Rk02R1IQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b=iPbPsxSm; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=M+7fkFGr; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b="iPbPsxSm";
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="M+7fkFGr"
Received: from pps.filterd (m0375854.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69EEkiEr4015611;
	Wed, 14 Oct 2026 12:54:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=5Lzkr/b9KWFtzyj2vqB5TR09OPaGKyTgV4aSX8/u7QY=; b=iPbPsxS
	mBy8/EBM/WIWlgw5Bxwvz/gf/iFpZs2dQuD9dncVX43Lr4RVARp/xsJuHKWozKN8
	Ot1QzkuyZeTJ5y4IVluUPKlgFObgAhy1ZjEq9hMw7BTUnkXF9QLfbHgIWUcZWsXY
	/ay5s3YqgyI4SOHuHWp2WRcIi7bRdRgAY9XeaW+tMC3LbFkfdkOtWUcmSgtlu9Wf
	AMBJ2HN6SPQJJ/WHGG/e33/BBvvHhG6wZDfAfzvcMN88DTH5YEY/OzFmZu3IJUi3
	dagvyf+ufTvm3HL1QSMk35LKXqwIOUc8nVR/8WWvDnmP1b/ZR8It+/xi1MfDgwVw
	2MwcrdpVoZGEHtA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=5Lzkr
	/b9KWFtzyj2vqB5TR09OPaGKyTgV4aSX8/u7QY=; b=M+7fkFGr0g/jSj7OdHO4U
	K813T64f1tJWueIHljhngO841YPgHZpWtNRjZ6RA7wVKES2KC3ZWKoswnVdh8Ep6
	wOa3vzABAkSsun2rvIcdKaU2l9M55sDpu0HpyBQNZ1u32JqdnUWRRfOy9Pr8atVu
	+Wx46YHFe0d5ZMU79GhBeXAXT+8wHopb7O00tskz1t3U3yatdwR8lCRxqEfIt0aX
	msQQQr0yEWQXVUG1jEFkSiOxYIN4NApRYHbEy/tCJbicj+ocspb0qE+nlgVxWaFb
	gbczP+jOQRmOUi+191gONvYpCncQldodoBmbrtBK782IwfMxssRTt7xli8eqWd3q
	Q==
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011024.outbound.protection.outlook.com [40.107.208.24])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4habt3gmw9-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 14 Oct 2026 12:54:19 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YGgbCCNa+gkvxHs4Zdg7jGUjdNHmv4Y6JFeSCaQqBB2GS0WDt3UbqbCbnulkH2SHZ4DkrkOHfP82t7ckgzEI+jvUQyh4QRjCO5XsC2AmpHLnzpn2Vyuhf1hp2PKTNqAremp5afcShrxJdah7ouRKpk85S0DffZApBrdFv3GWdJkexFeUHN+liVeoCWhRx1NpIhReIi5GxcFR8cxs3o9ba6XxKdGgzwFz90uXQQvOlrotAxbV4K0FopKlnWOqgJAxSGJvx7PrRLSd/zLOL4oUbqlnB6TO2yONcJDrKepLNyjCDs3mAQFQavw6lYWD63hSuNXFvskYRx3XnQSyM1hsyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Lzkr/b9KWFtzyj2vqB5TR09OPaGKyTgV4aSX8/u7QY=;
 b=VkBlaOQ1Y9EYZ4OrMnirrWgzGZcQUGd9o772+H0Gm5dbxvFStOuTMxLAycy+jKjy4sfeYGQyn+pyUMZkQrwsGvkuJEhOu2JFTM2yI303falDA8kPQNIq2W3v8cWDf6uxzvdZcVBetoU+TjCBKRgaUInsXrkAhtcCvLlzNn1chwWkj+mfz5Y6kg0fTEyi6REh1VcSPpCKHf87D5rBMnk/VG1lvoH59j2nYWou8N21vY/XiC2EO17M4RsUOoZJZ/63/MXhRXZO0oNUxkV7hiF8TFzRfkQgefMRQ9ll6mbgCqJo1dCpIhoMn44CiRsa/Oz20VquTEP3attRrjS9/8mwfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by SA3PR03MB8350.namprd03.prod.outlook.com (2603:10b6:806:45d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Wed, 14 Oct
 2026 16:54:17 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%6]) with mapi id 15.21.0496.021; Wed, 14 Oct 2026
 16:54:17 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 03/13] iio: adc: ad4134: Update include list to
 comply with IWYU principles
From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux@analog.com, jic23@kernel.org,
        nuno.sa@analog.com, dlechner@baylibre.com, andy@kernel.org,
        Michael.Hennerich@analog.com, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, corbet@lwn.net, skhan@linuxfoundation.org,
        marcelo.schmitt1@gmail.com,
        Andy Shevchenko <andriy.shevchenko@intel.com>
In-Reply-To: <fe182b812315d23ed3d889cca08aa44ab36bb6ef.1791309733.git.marcelo.schmitt@analog.com>
References: <cover.1791309733.git.marcelo.schmitt@analog.com>
 <fe182b812315d23ed3d889cca08aa44ab36bb6ef.1791309733.git.marcelo.schmitt@analog.com>
Date: Wed, 14 Oct 2026 17:55:28 +0100
Message-Id: <179199692814.658576.11891445447097689531.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791996931; l=454;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=oVgIMhpAtj90TGOaGTzd+jvrpC9E5g4vxxJwgzaDRGg=;
 b=8J4190fLuZDUsGAZeA9IT7t/ApvB9Op1ZTJ9m1Ue7QoSbRPjgtzXKrNDIlPH0+44pIywsU8gt
 vFJ6HoZl2+jCqOooJS74dhrh39bGaEvoVB+7nZdqEjUvWAWTmW/k0nq
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ClientProxiedBy: MA3P292CA0040.ESPP292.PROD.OUTLOOK.COM
 (2603:10a6:250:46::12) To SJ0PR03MB5469.namprd03.prod.outlook.com
 (2603:10b6:a03:28a::17)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|SA3PR03MB8350:EE_
X-MS-Office365-Filtering-Correlation-Id: 59808fd1-2400-40c0-8e50-08df2a13c89f
X-LD-Processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|7416014|10067099003|18002099003|22082099003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
 DsbIp/E00VO0lgBMoyb7cjghmQOCBuU1w6E1I5Q6JoOwaozYCgLmwFbRPBL0xd1SPDm/v+W3CtsehPR5RFmFb+j5jTr5vQE2NAOUFWxh99cM9W3+SZdjF899egOb+3qCiM6plpFmEI4SLfWithh1UG+KBKerKbxp7dALoGXpeSsrqnElB1/NOUq8107x/FyAQOk6uZVFlivZT1/UqRziHsaT+dDV7BT4P7bhRJ5TJKBHDldHddR0JBAAP0YB/1PxTSepaZghvbnQzII1w/zKM2WHgRcMImOtzgc1/4IYqnClmZuI7frv5UGANp9zb1cycQD4ZdeZWWKvtxJMg0GhYwVcVf2zldwRuaQTjwLBgtHS51GkFpF6PMcCsW56Lsq7ufzvFbc4g4+gHU4t+sxYV+9PuaD10pNv4lAOLbmqAhvTUfmrgfxsR/kYx8LN5Fw44xgHo+RbYfKVjVwGASL/qwfA4ZPsJwwcbybLE/MYUhga1SWjS9ZeIXT+kJxWxB4M8Tqagw0rq3xXJaBdLKahuZagbhnjyk9sAbQ1HBnRXAXgiLbU8b2akrHbIzIx8dIa2x7sapCZoyOk3NcH309fRw+3EfSLJTzlMvJ82x2NwYWzVlavDp6ayyE2dvk+Tw/sqQxRegNdMyt/u8J2/5oD2KYoSz4e8Dh8+J1qnj6IGmg=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(7416014)(10067099003)(18002099003)(22082099003)(11063799006)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?emhFaTl4a243YTZINUJFd2tJTVZDTWJYM3JEZURlOXkzTXJXZk10QXFSOVVi?=
 =?utf-8?B?TlllSk0vKzRiUEVHMURhbERzQ0F6TnIwdzNNSUJRR1pjWWh1VWFJbFNPZXlQ?=
 =?utf-8?B?dmljei9adlZWZ2M5dmRxcXJOaHMrdWd3eElZbysxbzdmNTU1UlBqdzRDYzRM?=
 =?utf-8?B?Q0FTOFdscEQ5S0wyMUlYSE0remwxdEhhVnVUUHVtNW9XV1dWNUlZUEdoNVds?=
 =?utf-8?B?OG1FUFZlTkVPY01qNTU2UTdlZzFnanFJMER2WnV3S0RGTDIwa0c4c0RXejdV?=
 =?utf-8?B?dURRNnAwVVhVdmFDUzRuWmJESHYvWElrZGNjNlVMWjVnYVIrd0JiQ2dYaVNQ?=
 =?utf-8?B?RWZCZWlSZ3E2WEZSMjhocnFCNW93RTRjdW5pejRLa2VtZTVYZ0VNc2E0R092?=
 =?utf-8?B?Q1JKRTVJbHhPZ0lsdWRxamEzVmpTQVgyQktkYnlqWjh0K0ZPSHdkUy84dzRW?=
 =?utf-8?B?VU5IZndCUlJWNGNySSsraFR1WTNJZ3YwYzhBM1pMNHVZL2NqYTNjSDBTdld1?=
 =?utf-8?B?UmlMMGd4UDQyb2xUZzNsY3VaS2Q2RXVzTzVnamdyOE51TWxBeHN6LzByWUtD?=
 =?utf-8?B?a1BiSFovdGkwQ3RFQnZTMWVWYThxUk8wSDFkQlBsVlp1K0FCNHhCb0E4amJh?=
 =?utf-8?B?U3AydDgzeDhCWXVONE1xUWNGcHFWT2luSG56UTEzcDZjWmZtZ3hqdkNqT0VL?=
 =?utf-8?B?ZjBzUjdVQ1NLU2g0SXB2VzB3VUZEUU53YStaV2NTM3UxeWVKOWxEbHhLaDZn?=
 =?utf-8?B?cHFOZ0F5M1BhV1krZzhNeXpGYk9rd1lTaDlsVjdnaWFnSlFJMjMya0VuaTBP?=
 =?utf-8?B?QmloR2dXdVJIQTYwTDgzUEhQckZteWlwb1VMUUtOTks1TjJkOEl0Wk9CK093?=
 =?utf-8?B?MFVGWnpVdlVaV1hOZkxmNjVGTFBISTYvQXdRbXdGb2MxUWl0dGZzbnBuV3BS?=
 =?utf-8?B?ck96bEhNTTlIWWIvaWZGQ05WNkZrNzN1dXZLTXE2b25scGdhdkVJT0xYWmZC?=
 =?utf-8?B?My9XeWdSZndGd01iM2FyWTRlSkJjYkNCbGo1TUxOMmpRUzJHRzh6MS9VcUlz?=
 =?utf-8?B?VWZMQ3RIS2U3SDZXbENHcThLNGMrYTVDMksySXduUnYzTzhlVUI0eWxrMHpE?=
 =?utf-8?B?ai9uRmNZRDBobG1uaEkzZUVaYmo2azBZQzNiTUx5S29yak9nL2k3cDJ4eldB?=
 =?utf-8?B?aW83NmtySHBQMGREZktlTlF6WXFZbkFwSmpjSGo1ZG0zalNJMld5cjBKT3dr?=
 =?utf-8?B?cVlYR0owWWpNVXJkR1lWMjI2N2lGNjVJK1FkMW0rd0FtNXJhenBzZGZmd2xG?=
 =?utf-8?B?MlRJMExyS1EzRzk2TUVWd3VPUXc3d3hYSC8zT2xTNWFVL1ZWb1pvNWxYc2JP?=
 =?utf-8?B?VXhjcnVZNk4yczBQeTZvVGdadTV6YjlhMTZEQ1kyRG9XQUo5UlhMQldRU0lq?=
 =?utf-8?B?L2p1WEphdG1sTHgvc1VCUmFwcXFKaXhDRXVIdlFmZGFMLy9VbzhYMlc5Q3Rt?=
 =?utf-8?B?dmhUZWRZeGhXZnRTMnd4Mm5LL0dlcUZPc0dlanhQUTBaQzI5NDJpUUg5SlJ1?=
 =?utf-8?B?RGJHSU5NeDZzQ0Z3WDVHeFAwZjc1bDdubzA5dGE5RE14ZStnNnN5Q1Mwdkdj?=
 =?utf-8?B?aWoxbzFqNW8rNWR1RHFCZnNDdWdzbzcxQWg3clliRHNZM2EwS1ZOdjlFUWJj?=
 =?utf-8?B?NDdPa01WZzFtMXhFd1c5d2xHMlJSMjI5bGZ2emF6cytJUnM3ODVSUit6MUdG?=
 =?utf-8?B?aW5zcFNpY0VLdWRRUllVcWN1VEdwOUJQR21XMHZyTWM4YlBSOXRVSmF1Z2ZY?=
 =?utf-8?B?MkRabklOMyt3QlhLMFR1WmE5ckdwM0VxQlg2cTJvcTJyVkh1TU5tYWlReTNo?=
 =?utf-8?B?M0NzM3RzRkNrLzhjUUVmVFdIaUYwNjhwWmQyOU9lWjZ4bHhrTk5XejNsY2U1?=
 =?utf-8?B?bmppQVAyVnRaRkgrSWNERno2aVdwVXozd1BVYU9uVSt1OGNSa2V5cnYxT3Zh?=
 =?utf-8?B?YURUOUlKOVl0VzFpM2VJL3BOa1Bjb0VseU1uQTRVMjFBS3VDNnM4NlJsMEJU?=
 =?utf-8?B?Y1U5OE1ndmpZWDEzS1M3TGV5R1kzOXZXallYcU1Od1hzcFN5N3NEQjQ0b0lN?=
 =?utf-8?B?OWZwcklpTXhCREM0UkRqaDQ3OFBtOWJXMWhZZElOQWJBVFJCWEZLNXB1dzFK?=
 =?utf-8?B?blFMbVhBdGxMQ1p4MDNESllEaWduQ1VhOW1JVndWWnFsQ0k5aU00RlpWNWdl?=
 =?utf-8?B?am5EVlk2eEtzb2JBSWpPL0Q0eTZhTWNvNVlzSUllbVFZOG1oSkZGS0ZqQXNK?=
 =?utf-8?B?dlliWnVyQWtBMHFtQkNvYjI3NDloamt3OEE0L3pNM0tVY0ZPSVYwUT09?=
X-Exchange-RoutingPolicyChecked:
	jeWtjG+cOSoSBzmIxpGbYJHYBZacNBF9PazJOt88NyAoMAbklhnkCWBGP/o37zizqdyWhjl3aZ6PwDSbFBPScFC9SIaBA+R4zR24mu9kJXrZWBo4yHD2gexLmTOh6b0QVg+ozmazGWJS+6y/rcVzbNsiaMd3oLFTwy55rdaFpIDtM16qO1ajWKGmS+Iv+N2oEZ1ZKGhm0MA9/n1jUrnVzmaykESTaqxMxR7YVnfGe7a66iKjWAPS/+spHwlx3FBwP6agkFQCaHzN5AI4IxJAJgdW4Dks4w5cOqnG50FOb26mzrcKbz+l9K1Iwc+NrRQY+xlOw5FsxYmlvPVGgxeYWg==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59808fd1-2400-40c0-8e50-08df2a13c89f
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 16:54:16.9651
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6sn7LqkV0dn7JQf6BVJc0gQJnqwGCxXi/fGVFp5gPGKJ0kkOar3Q+r8PgnhofQt4L691hZKRM3jcq4GnLwm5CA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR03MB8350
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA2NyBTYWx0ZWRfX0ZbLff9LrCkw
 dnlvjkUyrTOOms2s1KPSPbOvjcGn7jcXGLqJD10g1FZ6em4a0fdgKZR8rCyT1f8XLVURZWr3bUJ
 xS7v5JgjJsp/R5U/8O8HSyZyp75kGJal9FMrhRur4sngDipazSArcOqVbQXWbEEYGKsqUdyin+d
 q/PCk2ABYa0BPxGnLR/5fXNnDobLPS0S4ZemkxoFBZAi8P4mw1uiBZeZTj/QGwTIUttzrCg8cb1
 n3u6dvb8RYesoql0wUtE4tvGFR2CNzsuoGVXVnyH5ae3y+gBqM5CA45O02YSafjzqBLQkBvdlKA
 53PXKnTKDkSXUYkaSiZ4OPld2CUI+lnILIkUNJMeGf6LUUHrEYe3NzKNIIe2mOy3DVUG5H3i0om
 ihXYX6QfJXiyuWWZIihHeynfjyhb9D7iRTly5UK2DYQY0Al2+T6N0rh/dVIgyFoBFy0Yqvc/ev9
 7G0yb/vqW7BYc50UdtA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA2NyBTYWx0ZWRfXxBDkkpi4KXYO
 sxv/BGmW5ChI7Pib76c1MjWKtLgGOpydSDclxkvcva/EmLO9AAMg9DBlK53DWxUZ9JIXDCZmtGF
 Erhlpr51nONlcs9iustcSy8orq/3TIBbEpK4WfzWv9mAhcy+ZqaR
X-Proofpoint-GUID: wtOpcSe5yJfAJIjgFAdzw_QHUo9MWiRz
X-Authority-Analysis: v=2.4 cv=IsCL47/g c=1 sm=1 tr=0 ts=6acfb3bb cx=c_pps
 a=DvLgf67dpzRpeCMgcWG2JQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=iZSIUCweCk2Oy3QsdGPA:22
 a=gAnH3GRIAAAA:8 a=uMPiamY9ZQ4LA9Q17kQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: wtOpcSe5yJfAJIjgFAdzw_QHUo9MWiRz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 adultscore=0 priorityscore=1501 spamscore=0
 impostorscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610140067

On Tue, 06 Oct 2026 15:16:42 -0300, Marcelo Schmitt <marcelo.schmitt@analog.com> wrote:
> Add includes that were missing (according to include-what-you-use tool)
> to comply with include what is used principles. Namely, add time64.h for
> USEC_PER_SEC.
> 
> Remove time.h which is covered by time64.h and iio/types.h which is
> covered by iio/iio.h.
> 
> [...]

Reviewed-by: Nuno Sá <nuno.sa@analog.com>

-- 
Nuno Sá <nuno.sa@analog.com>
