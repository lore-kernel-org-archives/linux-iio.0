Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.139.77
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793361880;
	b=20vydiZTJ/i3Omhp2vsH1jslqfO9I/2feWKdY7EN5gzo7Iqq0PHZphXSOso4wKTtoUjU
	 kQeSrLhnkI3A2f+KSrcyAtIBci01l8dZXQm72NOyOKM7AZj/NUKdRpTtipiTKrB7Cy8H4
	 A+3uyjLFHWFtpNXTXBOEZURmWL1nX5G+4/HHPJh3sHVEdMA5iA7MKfAnkw1f74qcIW3L6
	 SXJCHj3ACClw1clMxU5V+yjVhS6ffH7ltfWC2CnpD1etZgrsYVD46Hxr7xP7fGsdqB0TE
	 Zi/8anRxxY/Tfeuyv+PTBxkreDLbJfgMgBCGmj1KQF7Lc68zowke4q3ExDPQVsNZIZg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793361880;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:Received:Content-Type:Content-Transfer-Encoding:Subject:From:
	 To:Cc:In-Reply-To:References:Date:Message-Id:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-LD-Processed:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-OriginatorOrg:X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=2xPXoKbl1jdbhuYHxZ7kB1ih1SpW5vHQlJZymdpglII=;
	b=ZrShX0tJ/I0kHOpJG6GC/LQ1Cusqm+G+yoVaMauo2KCWKxDF8B1hsxgP71cdYy+jAcU3
	 m9E8+Sd6CIIz/cjvV8gPTGWS9LhjLnWMZoEkMDUu9suSl1NahbjSuyKfBOdm/PBtR5heO
	 CtlxXagUS3ntI6BHRR2LnMChxdIUJuY+EluS5X0PFVLbqs+bEvzyfSMnULeUczNrVFCu2
	 g+ClHbAXo6xUWX8yVyxSMtZSEsgjmWUAYuCTG0HUfHgBeN0McssfvfjddE+E2jgkLrOa/
	 9p25l52wXcp6tBo4ZVIQSisU6NRMrMV2QoYJMvyMAAW+IaMdcau4y1QgZv0IGsNPKTA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=K+GzdDB2;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=IhDzj+Wl;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.139.77
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D1D9606A31A;
	Fri, 30 Oct 2026 12:04:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7D1D9606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=K+GzdDB2;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=IhDzj+Wl
Received: from pps.filterd (m0516786.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69UBGZFI3931413;
	Fri, 30 Oct 2026 08:04:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=2xPXoKbl1jdbhuYHxZ7kB1ih1SpW5vHQlJZymdpglII=; b=K+GzdDB
	2gwdQkovFWsB/kPL3qOrKkEez0I+ndBb0IO3ULcX8aa0RgOGn4OofLravzWy95BL
	x3xqnq9QskPtUW+CBkcAXN64rwwzXwZXrwVgp8llmj3qZn+LT5TfuomXY9e0u7dV
	c4AFGhAPoiBrutmuUgLgxJ53BBzPDkBGaklK7338Jz/OGGEbSEdhwdAhEAA43xap
	3pUI0h0/kodS2efjEeYMjlzgo3xil5caqNXt3ozFkyZm7UgeDo+cyl+wGkvSfhSL
	8Oj8vC4COzN9BD/1mHeBbXavtgeGPkZsCCvd/MatLA3SF5bznDhZiN7gPlVwZ/yh
	LiPwLOGOIzrM82g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=2xPXo
	Kbl1jdbhuYHxZ7kB1ih1SpW5vHQlJZymdpglII=; b=IhDzj+WlAl4S1VXiWvMn+
	qoO6ehF1q3CEiBU4RF1hsYaawbFN6uBLIuB1vy3fyX5nUUIZ36QgMm44xIpVMzDz
	P8MB4zeFUAGQqcCZ3wKzmVAnCdHHrNszXSPp54r7qlrMITHW98lfTuI/C28/tNut
	rCK3nvotyyelVV+FpGDsiewaZx++6xL1XpQg8RmFu9/A/VwYPyegcG7fKgWOMcgu
	EhYKcC0285BBJAoLdzaDv/1L9kCL6B00WlvP1a3vqM7OSZ/IGeSuww7d7GKxlYM7
	KyEN0LSa7zMN+KY0rGNPRl79C1BZfWjX34amGfuT0JrEA0WPzexdbOFyJtISnNqS
	A==
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010008.outbound.protection.outlook.com [52.101.193.8])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4hme7b3qs1-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 30 Oct 2026 08:04:23 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vnpmfE+J+BUtpKQb0DoPxlfrAFZr17LzpsdmbM+rghSo03oXXtZMTjHDeAfwkgn0k190de2tOy5FK5ZgLU34l+7OusiFSYUI71n/dJ+qzydaFZEkcuz0HenKnQ9mdLESS6NUlfDNmU5VWpPpemBNPgYvpvpANL85arnAIVzG5AfsGJmclPqjA9DhttDH0lyf7uy1Q0+aTQQPejmi1/rx48wLECmC35Uvrm2p8LMDE3cCdNTj0/3BgBgY/8k/r/uwP2Shu+WtUkIKfN9pmRGD026LVWlzGiJ42+3sAEVQ2055uuZXssLNlN/4TbFcQ/UA15Sfs7mO1O7PwmTwc/M9Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2xPXoKbl1jdbhuYHxZ7kB1ih1SpW5vHQlJZymdpglII=;
 b=DyPbbkB94HNIRaBzQognY86zjHwCMEQejAw1HC2mJz0lsgZQV4k9BgFxlC/hKvZMnSNI09ifJSv6cnCALYH9tidFpdUvzHihA5lO4TNEHnflFauukmxpkIZsvsPHN6gOcnx+QUQbxAQIJWGQVwkcAIah6FRySs3EB9xRCEWQGogb9HvcbHkiuztV107fO5Zi3W+qw+Mz5lfkOdKsiwNT5DHZo4m4m2ha2+xgmMlTxSr1UW73CvwIEh1zHD/s3/U0U8GOoBNzgindC85fWPaPHUAdtdNUgJiqeY2Ce8JNH6W/S02mPBNbrSgOIBMy4oJb8C5DVcsrY59v3Cx4I0QT/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by MN2PR03MB4974.namprd03.prod.outlook.com (2603:10b6:208:1a4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.10; Fri, 30 Oct
 2026 12:04:20 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%6]) with mapi id 15.21.0569.009; Fri, 30 Oct 2026
 12:04:20 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 06/10] iio: frequency: ad9910: add axi backend
 driver
From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
To: Rodrigo Alencar <rodrigo.alencar@analog.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, linux@analog.com,
        devicetree@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-doc@vger.kernel.org,
        Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
        Olivier Moysan <olivier.moysan@foss.st.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        Andy Shevchenko <andy@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20261022-ad9910-backend-support-v2-6-0ff7f0bff326@analog.com>
References: <20261022-ad9910-backend-support-v2-0-0ff7f0bff326@analog.com>
 <20261022-ad9910-backend-support-v2-6-0ff7f0bff326@analog.com>
Date: Fri, 30 Oct 2026 12:05:42 +0000
Message-Id: <179336194285.155032.7443598007974031472.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793361944; l=578;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=pgxIRXdWTHp51UfnIvLVwz8QuXPbnr7REU6n25TQO/U=;
 b=xyKXG29HY+ae8v72s1NsZXkp9dmrj0IizlG+SZqL3CEr+Jk0H4CsnFvArBdrBLO2gM+frF/U4
 g6mTBuxfPrsBm7IZT2N7UgR3m4/n7inTyRDB1fvM84fNbZRjf/vxVb4
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ClientProxiedBy: MA3P292CA0033.ESPP292.PROD.OUTLOOK.COM
 (2603:10a6:250:46::11) To SJ0PR03MB5469.namprd03.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|MN2PR03MB4974:EE_
X-MS-Office365-Filtering-Correlation-Id: e8805d14-22b9-40b5-912f-08df367dedf3
X-LD-Processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|23010399003|7416014|376014|366016|1800799024|22082099003|18002099003|3023799007|56012099006|11063799006|4143699003|261026121527099003|10067099003|261021123027099003|261021121427099003|261022075727099003;
X-Microsoft-Antispam-Message-Info:
 5tT26NCe7BkQHW5pRZ/O3mGDoBgKXPwK2VQdfiaBE2CVsOdMmk/xjPxoRoyIkC6oQTFlQdF6dXwR6oMUPBG03xxPEZ3ytU/Cv9Hytr2p3u/77nox4ZhzuQreeVlvwaRCFSz1mEPh7h7logQB5mtfh30a43Em20ugyJ/SHgt92o5C54usvZrjyTwUC33XxlBTrRHzBT8J7RRXN9CXtLa7NQGoT88g8tjWnxa+5oR0HpmE7lZDDvBoK4M9eIhkU8xNRwEEcUoikzAFReO5fDZyI5RbHYHQDzGKteapg2uja4RuiszPc1NDGG27OYhB2WnO297HQlUbU0PqRba4IsuJxULlJjUCkx9HfvVhEaH/sLxdnPzmR9uplXQe9jDlZqyUxbvqQjgtzu/v8IXh8XuNNIczpAHIK2OshNVEbUoiQiyAGkWzdpMa1LcyVVJIQiq5sT/PXZAMq4AtNZE0TZnQsR7/aJeAQ3uKVrkQAbA9kAOHeYmqndAOqDwq5Mxpj6uOx0MYbCSnhqcm5T0UpGRiYG+axIQtIx1ISZ7th6fiae1EB+eIfFR/VMRCBJtzKgSpKPY6aYX8kN6PKkCNLJaTXDf0+sAZbhlfAP9uTiWlDqI4scr+U7Xf+Faxl0SiQU5ysl/dYQjboIKQgKIfgmJ0mM+xwPJ1JpI+sUkKSn8JiLc=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(366016)(1800799024)(22082099003)(18002099003)(3023799007)(56012099006)(11063799006)(4143699003)(261026121527099003)(10067099003)(261021123027099003)(261021121427099003)(261022075727099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?K1NHWmdURlA4cWY1bk8vbDdCRzJZZzNoZjVYb2o3blU0NHM0SlorODBzUGdj?=
 =?utf-8?B?TVMwTWQyczF2NlRhT2dGNVZ1QU9NRTNIQUtkMDVNL21DN3FUeEgyaE8xeEVP?=
 =?utf-8?B?V213YnVtR2c5bVcyeWdXaGNXbHJleTlCM1NhbU1LNnhMSWdWdXk4Y1RuZkl2?=
 =?utf-8?B?NVkycVlQaWd6ZFBjQWQ0TEJQWkpvNkpOV2NLU3F1Qko5RzBMQjZKNzNtWFQ3?=
 =?utf-8?B?cWkwS0RienNEWEhwRVBEbHdhQjgvWERuUzlUR0x4WEN0bzFhdmM5M2NodkNk?=
 =?utf-8?B?K2Q5czZ1RitRcDF1elNBRURGZkVKZWUwVG9FL1VMWlJqYThoRXp5U0dXV1J1?=
 =?utf-8?B?VlVJRmlmSHpRWEF6QVEwaytDMkxKZFNMV2ZSY0h2M0FpYTBzM0w5akZvSVpy?=
 =?utf-8?B?bHlvcEpXNnpTb3pBMzdwNzcrZlFnWHM3TUk2MFlWcnpJOEo5Q3hQQXJqcUZR?=
 =?utf-8?B?bUpqS1dCWUw1RE5pWEs2S0EwTXpPaEVKMzIvSTVPalUraFN1bnRDamZmV3Rv?=
 =?utf-8?B?YWtEdVBzUjJFTkNqSFpFN0hJVUVlenNxUXNLT1pWeWpIVUJTZkR0Q09TL2Vl?=
 =?utf-8?B?V0NYeE9xWEJIdjgwS09veG5JemlZVGVLNGRPbnpLaHErOVZPekdKQ04yY2U2?=
 =?utf-8?B?S21tbmxKQVEvS0oxSFdFQ21HLzJYUGQrem94MXhxdUFlcWV4a2FYdndBL0lD?=
 =?utf-8?B?K2VRTmtaam9LMDlSQ0tNckZaUGRJdVVaaGt2N040SjhDZVVHaktTbFgyNzUv?=
 =?utf-8?B?aVhQSFlNYkFvUkczalM1WkViek9VblJvNGJzank1dkdQMzNQWURKc1JUdm5X?=
 =?utf-8?B?a1h1UkpIYXk2MDdVYVIzdG9FTlplQ1RKckJHUXZCM0JIUUZubFNPVFNIZ21n?=
 =?utf-8?B?Y20zaG5aWUN2QVg0L2UvemVCcVBMZTQxZWV6cVVtNVYxRk5EcmtGRHVJVnNG?=
 =?utf-8?B?QnpXL1YvOHh5dFlaS0Fzc0JBckdwYnZlTVBhTWNHaHB2aTRJY1QweWxqc1I5?=
 =?utf-8?B?TmIyOWxaV3k3d3g2bm1hRGZ6eFQ1WWlEcUFnTTJJVFR0aWIwaytSVkNiY2RX?=
 =?utf-8?B?OCtmRGluc05TcHdPaHQveDVjalNvQjlhUEpSTXVNU1JwdUsvRER1SllpUmN5?=
 =?utf-8?B?dXFSME0wMkYwTTQrY0UwL2NEbFB6QXNWckdLVDVzVEEvcjZXYVdFN05BWk9M?=
 =?utf-8?B?RDZmU0NBWmxKWitjSGRVVWlkbTN2ZXdBeW5iWXhSZlJZT2xYTGMwZUg3OEJZ?=
 =?utf-8?B?TVhOQVVHczhtQnk2UTdLaVlNNVUrUGhVSTZpcVNtOTJHNTN4QW5yM2o5dVdq?=
 =?utf-8?B?M0FkeS94WGN3UnNTN2xibWlTbm9FMTQ5V1BqaFZJVU1YU3VRcGRWYUEvYm5X?=
 =?utf-8?B?d3hHRng2OG15ZE1OdnA2UWlNMFhLTHNEZHNMMm1FV2pwSlBWMExFRksxamFq?=
 =?utf-8?B?NG9QOGQ0dUFWajY2YXExQWpvMzhSdzcxb3V4aGgrcHFsZ1NGWm1Kc2l0dy8y?=
 =?utf-8?B?Z2ZvbnBqSlowYXpDMElNTG9ycWc5d1Y4M0gwRFVrVUdCZ29iZmo3TmIrUjFF?=
 =?utf-8?B?MFMyWmxXeFhKNzIrd1lkQnlRYlBPM2FLSEFnYzFLRTdBUHdkL2pWNWd0OXlS?=
 =?utf-8?B?MHR6UkcxdzFsdkdpejVSNCt2cVNxdWNhQ2gydWhiMHFsejRDRDFpTkl1YThj?=
 =?utf-8?B?V1YxMkFxSnFaQnFubTNPeld1T3dIRzRLRFVJY2s4SjhCWXVxMmRYVDFQRWNk?=
 =?utf-8?B?b1hyZXRvbjlwVmNHT1lHRUk5Vk00Sys3WW1ibzQ0TFJVcCtnamlwbTMxSTd6?=
 =?utf-8?B?OXU3bEtZWEd4UGJoUW4wQ1dRZGkyeThKYklTblQxZ1d3cm1NQ3VmL3N4VEJy?=
 =?utf-8?B?WEJDYytPNjJiYXJ6TFlqSFV1a2pJS25YUlNaWG9oV1BnSE1GZWNaVmp1Y1Ew?=
 =?utf-8?B?Vit6dG9NYnd3UlFWOFdkSTdYWVV6TlIyTVRiYzhxMkxRbTJCUHkwZkxCNzIw?=
 =?utf-8?B?cFowODNJcnNWMThlSVlOY3pNbU5ndk4vbzFCSVQzUWs4N1NVYW5qcHg1eEFW?=
 =?utf-8?B?b2hEM2YvRlEvN3dpZHQzdTIrem1QUGVjc0V3djNNbGxKVkFIbkpvNnEzbG5m?=
 =?utf-8?B?ZmVDWTdYWmxyQTRBNmh0N2xLaVBzYmNsNEphSU1uWmVGS05obERjWGw1RWZE?=
 =?utf-8?B?bmRjWU9oUDZjYnBuQzZyRm01OC9mM3QwYzVMY0RWT0RIOGhIZFBUZFBWTTd3?=
 =?utf-8?B?dEEyTlVsRzRETUhGR2M1aEszUmQ0MG1KSE9wQVEwaWl4ejF3OEFMQzJCcURH?=
 =?utf-8?B?LzVWWjBMV1cvb2JFbVpra3d3VTV3blhHZHUyQUViZjRxTEJvT1Q0dz09?=
X-Exchange-RoutingPolicyChecked:
	OH4p3AKhR3CmMNZOpvmSMaVYVzCdThEfYQKpI2XeSi4qNlNE6UnfsbV2zmO+xyhuc4scYS3BJFKdpO7QxezhhfppkvHmWPnJnW4zt3DBRrHWnJz3b/OYYvI0j91hq4TVcsGyMilvleJI+1XeD1hWGorNI7Bw3rxHOn1vKWki+p06ZJl+ENb9XX9NOx7J4S8Ka0jBzkUKean1oqH9OmflXKabOQzpG6xrE7fDHO8sVt//0PwjPRl1Bd3hhoPFhYBE5A6dIYMllXR7XwVDhsqfbB2pesD8fiNk9PePFo8/xTBsGNd/MDaP5uPsr3Wn5vX01Lsj+NNagGeSGw5nuKfrCQ==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8805d14-22b9-40b5-912f-08df367dedf3
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 12:04:20.2786
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jPRhkyjjkNSHCjbyo/BKEmw8vjaJaEBCPEzmjHdxkk02T27RHlF2jxpBWxto7kREM27HXNCidrA4XyPbRfs7CA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR03MB4974
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA0NyBTYWx0ZWRfX5t9Phpbj4ys6
 l3gzIzFwXhW9Wb2KmRsy8B7EUpIp4hEhbcHrjLUO6jNNj2RvWkPFvOOziTU9/fW77PjmcdXMMoK
 t64Yhzf2XF8wVG2PAiR3zVfYnRjKYPmFfITOjRD5QXsRrSaIfBjHRLBjESm8NiOeXetTU/Lbqo3
 IRbUiWyQfs+Gh2uN+DZ4AMC7mWjHlS4CE7DfJx5uN7posOWoFHjhWQ0S4hpnyyOdXEeHe6uh9Cp
 JcDl0liO/9nxlaXb988EefFKuiPvdeOnpXZvibpkvGKyrZZI4OdZWYuU4owgbu1Gyo7dFAwYE2L
 e7e+TPjD0B5rnJSx0eTBNbpIzTnPf7n/ePyZjvCi3kzLoieYl+oo9mcKMFUVynwpoPisplwBpqu
 f4UGzTD1mO3jJsyvnNekn1w63S4Y3YbOJUTcCje1h9Vov7qccX1hW0do6PZM8qN7WsDVKeQ7znm
 /3QvcTmLO9mb5SqDU/w==
X-Authority-Analysis: v=2.4 cv=Od8NnRTY c=1 sm=1 tr=0 ts=6ae487c7 cx=c_pps
 a=97Y4xzKGYTGm8d2IOhb7pg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=ZQxX5BWu6Z8IJBb2zLX7:22
 a=gAnH3GRIAAAA:8 a=xopPSvWoGK4fo9ADZDoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: xD9CJLbwOiShLe5qvFDudpvbXL4MbFBj
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA0NyBTYWx0ZWRfX+dBjgb9Jc6+2
 jgLqpU6c0C1Z2snZYSTgyB4SJAD1ilADpEwaJTtdYqMqnOmNVhJzipWbB4x3J3L1xXwl3I90cS6
 7zkDYVlT2SQeWuvFNN++IkrMrBBi/cTQdcD0nCavIUuah+TufrsU
X-Proofpoint-GUID: xD9CJLbwOiShLe5qvFDudpvbXL4MbFBj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 spamscore=0 impostorscore=0 adultscore=0
 phishscore=0 suspectscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610300047

On Thu, 22 Oct 2026 12:19:04 -0300, Rodrigo Alencar <rodrigo.alencar@analog.com> wrote:
> [...]
> length and duty offset programmed in SYNC_CLK cycles. The duty offset
> is realized by a delay applied once, before DRCTL starts toggling. The
> waveform is reprogrammed when the SYNC_CLK rate changes, so that the PWM
> output keeps its timing.
> 
> Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>

Not more to add to Jonathan's feedback. But I do have a slight
preference for "FIELD_FIT() and reject it"

- Nuno Sá

-- 
Nuno Sá <nuno.sa@analog.com>
