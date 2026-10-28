Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.139.77
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793179769;
	b=lkEpzteBp+hRy8hcoYcQJLJ7btJ+UiVWDFRNs+XUSfQEuGoj02fW2RQVowxOoEYtJn6O
	 Zasj6W+eYZbGyW4q7lpBAm2nS5iFSa1dl/NLmRpS4+LAGfpNsPd1Lp5NIHT8z+IQxE8g7
	 Pf5dFLD8YLHbNG/ONjc5NzUSTGtrHdRSfOJsmV6qQluPPUEELvwVGW9BpS3MC6ypibe5/
	 k1nhIbXPMaxw8IRkxExMJuBSKiJ7k8qr472Ia7XS2PyqNo8PyDj7+QxP71FcNzzuollEy
	 3LgtxDO+zzegE7XFTETaY6UeADgerv1t6kqpWFtIAngBNGNVPFOUVnAlaEnNPfDn7qQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793179769;
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=+znpDiQgn6IGzxS+RM7Unk+UR/F3REEOLnk7jJq0kvg=;
	b=i70d6ulngmCYbnP+zqql0JBiTCPHgzewXz5ZrUFbDXHRzwk3IF09eUAVcWE9kzA7cT2E
	 x71CU8FSKIt9eCL1K/DFKm//IXW3BzsAmQdQNYOEmScAD/uKaxWn1oWYq11wYdLL2gks1
	 W4fPW0o6dSPhaYDAktCTBkyCaJ3PnHk4CkFqWvllsLpEVBQn2btwT1ixEvEMQb8WDOHFj
	 pzuVQikmXw5xAkTZHgrTgs0wdKpxDNOmKBeC3JZWLWqiefhTdnJb9oqrDLFeBkrrDbJg9
	 osqNva5PLyRaij2vhtCL9RuEczqMJUVdq00H7QPe+loxLNmkD88nCDbrn0643PjnE2w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=kqSjklGa;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b="AVn/oBOk";
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.139.77
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B21606A31A;
	Wed, 28 Oct 2026 09:29:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 99B21606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=kqSjklGa;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=AVn/oBOk
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69S8GgrG1531647;
	Wed, 28 Oct 2026 05:29:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=+znpDiQgn6IGzxS+RM7Unk+UR/F3REEOLnk7jJq0kvg=; b=kqSjklG
	a21bER041ZjvTtx8hGD3z9+yRUIK6gY9gfOllYIi24pB82S7sj+B1jyYJMp/O212
	NXOLTuMgcofofM1yOiRVSKL8rn34KsaUxsiIh40jrzjoNMCCB7HsQEHLHoMt0/mM
	BN4XKsgglJ54zlOHeYoxzVPOFwoXSexyd4eAUywx70ExkuGev559BcDp4QA0KC+a
	3WN3nRR5eKFiuNLh1SeHoxMBA/fIiod18R3JEvfAwHsOdkJ4asw5s+nHIlEX4oZk
	+eYii0qbelaDEAJZRDSwxpsZTEXCU4dzc6Di4AANanmnB01vRlzcI5rJWquczSHt
	OAmvvk6Lo1/STmg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=+znpD
	iQgn6IGzxS+RM7Unk+UR/F3REEOLnk7jJq0kvg=; b=AVn/oBOkdlhlFpWu8suRC
	u6pYjR/swJ3L/yENfyt4pH6UXtE9poO/zGmRji0Sgq6l/U/vyKr6DHtJFp+iGhiS
	YJegkS8atF7sNoi/uB4bw9A3J04O9iYcX4g2YpKadr6ao9DItEkp9k9FhhtB15YK
	I9JFSEZW6US9Cz1KFuRme9irYzmJDafTOdOek/75pwjWTefPjzCX/43lWLBkURlZ
	ebuVoWII7jM2AruvWEUg3h2fbX6cfUje7yThuroQLxM5KIthE5fr8Ne4DUjKL+SF
	JRUG6u6Xgomib1hmZLOgwPhTg8STVujfw8fLDj5mzBxBZkeYOQPz1v+RVJfVZYSC
	A==
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012010.outbound.protection.outlook.com [40.93.195.10])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4hkbu0grxf-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 28 Oct 2026 05:29:08 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cBdj8RtX1CVmjkBHx9CgmIOimdQcDKKHXoPudBMBGHif/qUm16eSDla15yK7Bzp4V1lbxK7TzSYwdFsbrbpOYtEi17HB0m7U+9yxaSYMXZYouR6kQzcr4S4rYcuWDBv9hGdMu93HmtwBdJdUI8+OzRAINn0L7+Aig2apgs7JunNjxp60f6ex7bCAODhdSERq5E4RU2c9yITchVGjtuWM5HgRjZG8A2vVQiBaic2BDVO9IWRzQa8Ih1HfH1ILhhGJB3Azy2MxVtsW2kLc4saguaTp7e+NRRLcrBqr2ULRH8Tn/wehciF5xV7R/BgSgAc210DpGSLZKvQz1mwyDNDwTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+znpDiQgn6IGzxS+RM7Unk+UR/F3REEOLnk7jJq0kvg=;
 b=KFC3ju7xmgsAt1601eJ5cwIZGECKUuKjlzRhkTJcQVd0pHGXckkfmW9N6/M3UG3zVRMawmIiSQBiSAVZnOUaYY8hDwVSNaFg4NLcP0TCRQuoiaQErZfcJprDQJxKeV/5DSamV1uqLXTSJKfb0h2twduYQytFVjy7iDBPyNwk6ss+wHHH8F/OlaeqOF+S+Wgogp2xCoMgMjJLY+BNTC0ocOwV/DgA5eQ97gQLObXy14EBDfdeoVfvGS9MwLWosGIpuje91HGZXdhsZyfmWnhfeFQ1QEMJvlII53o4+g4IHU4dxitlkQNHPCYdtRTbDuE1qkkXR9rWIJfOjjU7NoJc6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by PH0PR03MB5798.namprd03.prod.outlook.com (2603:10b6:510:35::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Wed, 28 Oct
 2026 09:29:05 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%6]) with mapi id 15.21.0546.021; Wed, 28 Oct 2026
 09:29:04 +0000
Date: Wed, 28 Oct 2026 09:30:19 +0000
From: Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jonathan Cameron <jic23@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable <stable@kernel.org>, David Lechner <dlechner@baylibre.com>,
        Andy Shevchenko <andy@kernel.org>,
        =?utf-8?Q?Beno=C3=AEt?= Monin <benoit.monin@bootlin.com>,
        Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH 01/15] iio: buffer: let the block keep its DMA fence
Message-ID: <auHAbRpnapYDWF4N@nsa>
References: <20261027-llm-char-misc-iio-v1-0-0d818334f6c7@linuxfoundation.org>
 <20261027-llm-char-misc-iio-v1-1-0d818334f6c7@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261027-llm-char-misc-iio-v1-1-0d818334f6c7@linuxfoundation.org>
X-ClientProxiedBy: ZR0P278CA0060.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:21::11) To SJ0PR03MB5469.namprd03.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|PH0PR03MB5798:EE_
X-MS-Office365-Filtering-Correlation-Id: f3f241b7-3c9e-4f38-496a-08df34d5e8b5
X-LD-Processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|23010399003|7416014|1800799024|366016|261022105027099003|18002099003|6133799003|261026121527099003|22082099003|3023799007|261021123027099003|56012099006|4143699003|11063799006|10067099003|261021121427099003|261022075727099003|261009223027099003|261009221227099003|261026140227099003|260925022911599003|260925021311599003|260925021911599003;
X-Microsoft-Antispam-Message-Info:
 RL8S2WQ8P5GP3Q/PJWaHg2AjFJ6RXTtdTzmwrfTmxCVxxSuuyJfzzB8L+eRrc95/XE5Bx7E7/o4OTnExNwABxTE3fMmi2omNR3a1w7r2BoRlO4TlSbkLE0H6Vrl1yXdYVq0dy5qWvvsb8ia5td3gmOSHA9X8d8JvcB42vr8pszeBxCu8n+e2oC+mixek1a0b4XMGFsedOOxaaeT0S3f9E8sL5QiECqCo1YPlzPuphJo5Gten9n63LqUFaWCSaTX3yP/xlI9HA8sfLVhzszsop3aAdJQQWZJrJf7nq/GcnzW3H2lQAJCX1sFkNUoXVMCPLX1au5TjT4nB2cHTMkUerzmg4CBB/S6y9TXxtmFbLZR+JZNrG4qyd893pnCDaiGFLmyp5rlrIoTeD2pMt7IhUJ9QO9gl6MSCC85rfdKVOtOX7uLc0JDxtJKzgdZ5UNFqovYkVlBVPLTU3Utz0ecG7yRxSyacoSDNOPac1GDmHIPbatipfYNexPWRtCHNEj8xSNUK3Q9z43UoL5Ywd+jwqlYJ2gHe2Kx+2XJ5YktGCGb9fTlL04NND0o9VzFF6rFgDYE4m1O5V17mX0ub26IgeXR4irHW7lCsc2WDdkKG1WcQ6uvfHOFRuMSchlhwAYIW9K0GDeLqg+t9eYuNHSCBictnbLz0/0GdjIn90q/piAk=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(7416014)(1800799024)(366016)(261022105027099003)(18002099003)(6133799003)(261026121527099003)(22082099003)(3023799007)(261021123027099003)(56012099006)(4143699003)(11063799006)(10067099003)(261021121427099003)(261022075727099003)(261009223027099003)(261009221227099003)(261026140227099003)(260925022911599003)(260925021311599003)(260925021911599003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?YTBTR2gyTVNMbGdRSkVUbnA2R0lUYmUvd1Nwd2N1SlNJUCtTaFMyRm1vc1pD?=
 =?utf-8?B?R3R5NzcxNXNLUktiZWN2eGhnUVY1WHFQYWJRYWtqa3FJcE9OTDRHdEtLOHpM?=
 =?utf-8?B?a09wM0lLaGpCSUNvQncySXhFM2doc3NaeUc3clNxYk1pQmwrZC9BZEZuNWpI?=
 =?utf-8?B?cFRDZ3B1SUlvNy9wZ052WU41NTZmdWhSRlh5TUZVak9hNElRMlp2WElTRU91?=
 =?utf-8?B?VjVTTG1tdDZ4OEhwYUhOeU5KNytMMzRubTJBbjF1bEFCQ2NGZTdpOFgxVVli?=
 =?utf-8?B?QzVOMGxXRXVja2RvZDNJRmRiM2xyL245c2JaWEVSU3kwY1hDd3JWZVJVejVq?=
 =?utf-8?B?MUlBZGVGMjNlc1JPZHF3cCtLanJhTU5uVzk5YXdidGZlSWh4U3Fkc3JUcGhU?=
 =?utf-8?B?aFB1blJsNHRQRkpZRXdIMmkyQStxMC8rY29UVTh5UnpqUlNNay9nTUNPUHUx?=
 =?utf-8?B?RTVJbzZMemdCMS9WWmMxN3QyaGJ2V1NnQk9scGtWc1ZGVG5vbUZHRjA0NkFt?=
 =?utf-8?B?SDgyd2JhbmJSZ3ZCTmt0Tzg1K3ArZXVCZ0h5SW4rN3VXblNzTlVpTVkyZ2dE?=
 =?utf-8?B?MzRhYmNFbGRKb0dBbG5SdmlINURNaEpLTStvQm1XN01lZ1JLbHJQam9qZVky?=
 =?utf-8?B?TDhLZFlGUmVqSEc1aFprTzBGb3VjVUVNeXNHalZTUEE3Z2docktsRW9HUU9j?=
 =?utf-8?B?bXVhTm1NQVlOdXl5Y3ByME11MWR4TURkUjV1NUpOc2tVYk1vQml6WmFJSVlU?=
 =?utf-8?B?Zm5QS2F5WkJzTXd1dlR5NDBpdFFkaHdNMVlPMzFOM3FUWUwzbDRxS2dGbGZO?=
 =?utf-8?B?NXptSXFiVzFxS2NLeEhLTU43NC9BcEh4ZHBidDRtc2dITFVYbDUyV2RXNU13?=
 =?utf-8?B?MkJWZ3ZaM2ZEYzAyOFptM2ZWa2xvckV2TzlLQ1lKKzlwY2NFc0M3VzVJVkVj?=
 =?utf-8?B?OURJM0dhODViVzIrZzhCalo2bjhaWkE4OFNOZFBlTlZ3emRNRGZsNExzZHZO?=
 =?utf-8?B?SkI2VU03RkttVzd5WVo0ZHQyTkt0VFB0aXFFdVpndzRCaHdmeEVMV0ZUUElv?=
 =?utf-8?B?TmVBZHYyU3RVR1BOamRNWExIeUJuV2FUTXBFOGZRdWJEUVRJN0I4VEx5a0Js?=
 =?utf-8?B?KytzZDcySENuTCtYQmFwK0F0NllPRzdVR2JuVnZvbGpzRTBXL1orVGpWRkZ2?=
 =?utf-8?B?QityRU1XU2ZQcitwOEpOR0dmUE1wTWVnbGtOcldjUklHaWdKSjhreUdBS3BK?=
 =?utf-8?B?bm1rUDl3ckgrNW1oQnVXQnQrU0VMYzR6aDFlb1N0Y25hczdTbXVleHZrT0lV?=
 =?utf-8?B?Yml6RWVUS2Uzd0hJVUM5cllpTmV2Vk1tbGtDN3hrRWxqNU5MVWR2UmJUNWdP?=
 =?utf-8?B?NHlPMDYxZG1VdDg4VUU1cCszclVTMWc1TkJhNlNwVmFrT2JMb1U2R2d2ckpm?=
 =?utf-8?B?cTB6aWp0MGQxVDByNWJSdVNjeGlZQzAzSStsVy83Q0RsM0ZGcERFM2N0dEV5?=
 =?utf-8?B?ODl1V05FRjBSQ0RkYjZJSFAyajFWMmJ0L0htUmNzMkw1WDd5K2xndTNCNWtZ?=
 =?utf-8?B?aGRnWWVJVDNLdkZiMWJoSUZ3aFlvb1c1eUZLUm9VOWd1TlNITjdFc3BWUHpq?=
 =?utf-8?B?OVorbWVycXF2aDZFYXRuL3lnOTk5bDlHQ3VKMnlkZW5XMGlPT3NFNE5mOFZO?=
 =?utf-8?B?M0ZFc2RoK3o0SjJuMkJuQkZvWG1PL1UySDQvalNYTW5QZDhmZnY4VXhreTR2?=
 =?utf-8?B?bk1YQTEvbDkxR1FIa0hFcGZWaUJXbDVkZUpFeDBZL2ZJQXdrOVcxVG02OGY0?=
 =?utf-8?B?MVJTTFZaMCtwMzdEZXAxZUlUOVBYMVl5eFJObmZuYlpUSVZOdUl6RmJXUGpP?=
 =?utf-8?B?anNhTFBRbzRTd01BMitBeGc2ZkNqSjE4R1pzaytJZE5DTGVNK2hqU0RpSHRj?=
 =?utf-8?B?YmJEZWVodUZHcWtoQkxTRU02SkNHM2htWkpqN2dwTkhqRmdNZjVULzBVOE1q?=
 =?utf-8?B?Um5jT29CTjJrVTRkZkxRb0NuQ3lOa093VGw2K2tmUnA4aHBwVFZBZnI0Tzlr?=
 =?utf-8?B?cm9ZNzYyc284cGJOTy80VTk4ZWZOZ2Uyc1VkcGpidS9PcHU2MCtPMEdrL1RP?=
 =?utf-8?B?UHRjOGxaY1RERDNySVhlNHp2NUVjbUcvclFUR2RsSkJPRGx2MGtSMHBrS1I5?=
 =?utf-8?B?Qm5HaUd4aUoyUUI3by8wODcrWGk2ejhYaXNXckhmNXpFQ0RhTE4zYlRjd3dp?=
 =?utf-8?B?bVJrVzRmbk12UEJpMmZIQXp6bTdGZXBIbm55MDk0bjd2TDJQbEJQTFRmZEEw?=
 =?utf-8?B?dUxMYXc0ckkvcEhwWS9XZ1BYcmVmbTA0UlEvWjZZVWY3Zk1jWDlldz09?=
X-Exchange-RoutingPolicyChecked:
	e9ZXqhN6p68IwDxcOk3/s0wd3tFkm0uCbrhCFsvyzBGn7KOBy6IYxIvaLBnN4nGxR50U+Jf14kRZSnDYhYL2To+t5z2HfCc9HlfTeFLPQOlCieue8wXSDp95+YKdlHxFl09PlxhrUphin4maDoFh1cgG51Ja88wZ5nXCXWYt2N/kGIf6nGqqVA4Y20HmrVDcZD+T+mBVornlyIx4uDBgpondswGDuRNk9teI9/n8ulEf6pIm9hIZv8xlJXDYWDmptUFpo/Kc0m8tbDe5nLiKMOa9ffz6HpfzFnzuf0YAkcCOCrxErzC12VrTZmacRoXgGHy6Tl+eu7HfPzbOi9XJMQ==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3f241b7-3c9e-4f38-496a-08df34d5e8b5
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 09:29:04.8426
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hbanuNIhISg6JiavrnwztJbo+ZwJu/cZQgGbyQlElxcaFjOdlDk1zNfV1iI5vQHUTaUzwOIays00+wrF+jKLpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB5798
X-Proofpoint-GUID: zWuFB8s2kPVijEh2D0lE-DS6WxD5tPPx
X-Proofpoint-ORIG-GUID: zWuFB8s2kPVijEh2D0lE-DS6WxD5tPPx
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI4MDAzNyBTYWx0ZWRfX1kw3PMec1l3e
 KU+FlKYRyRV3w+SwmvPKfh+lKMQGlE89yxRc53frdr6Q72G8HOIlx5TNVZJeXXoNFrny3F13ms+
 BwHUPfyVLsfg07KLQowLFhyDdMGHrOrPBHy/x7TaFIFRAfFgHwpz
X-Authority-Analysis: v=2.4 cv=JdYpPkKV c=1 sm=1 tr=0 ts=6ae1c064 cx=c_pps
 a=78/F3YNzMekUCeQDO2i9lQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=_jAD5XSDOtq9-5Nde2OG:22
 a=maIFttP_AAAA:8 a=VwQbUJbxAAAA:8 a=IpJZQVW2AAAA:8 a=gAnH3GRIAAAA:8
 a=P-IC7800AAAA:8 a=ER_8r6IbAAAA:8 a=ag1SF4gXAAAA:8 a=Rg_XJ63LEOPMlOdrqSQA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=qR24C9TJY6iBuJVj_x8Y:22
 a=IawgGOuG5U0WyFbmm1f5:22 a=d3PnA9EDa4IxuAV0gXij:22 a=9LHmKk7ezEChjTCyhBa9:22
 a=Yupwre4RP9_Eg_Bd0iYG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI4MDAzNyBTYWx0ZWRfX8hgMamWIdkU0
 bIXyuSsrc6DQ1vXAKaF8Pe7lGbzSVXsGWTwi/wGqsRC9lIXepVM6FY4OqCuu1fnwkYu9GQrKbdw
 2vkj6nJCdm8QPp2zJt8yshP1NfSpb9M/NsI9Kf9XMTqyAr2W/D6pV2jXWvbHbhkd6Klr3Qxzdxg
 KKlek6AfSi57Wj7kCW7RXbGeVJOMnEGhVrZceXmzntPZpT7+VkMqDASxjzk86BI+lhClj5AuzAY
 QjWRLAQCfOnGpTMmeZ7Z1pzqNSmIB8iDp9SsyAPstW4NC7fIQvFuRbPudhCpc2bTmqOkAnCIJo+
 AiYkOzPNrXjfjwTekJ1qi8FvPfKGmnQiOb5uGVZGc6tfsHuxtoka50SHap2YAnurmch4ctynCCx
 ZYtMjWfkTIOaDH/wfc0C9mUQuXptQKLn5UPlwV+wLORdPaKpY4kUYuLQiBtwjKB9JB5JrVmCh5s
 ZaKhJCvZeFL9ugUtrYQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-28_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 adultscore=0 impostorscore=0
 malwarescore=0 priorityscore=1501 clxscore=1011 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610280037

On Tue, Oct 27, 2026 at 05:19:05PM +0100, Greg Kroah-Hartman wrote:
> From: Josef Bacik <josef@toxicpanda.com>
> 
> iio_buffer_enqueue_dmabuf() hands a plain pointer to the fence to the
> buffer implementation, which keeps it in block->fence, and since the fix
> for the fence leak it drops the initial reference right after
> dma_resv_add_fence(). The only reference left is the one of the
> reservation object.
> 
> That one does not last until the fence is signalled. dma_resv_add_fence()
> replaces and puts a fence as soon as a later fence of the same context and
> the same usage is added. All the fences of an attachment share a context,
> and an enqueue on an output buffer only waits for the writers, not for the
> read fence of the enqueue before it. A second IIO_BUFFER_DMABUF_ENQUEUE of
> a buffer which is still queued is refused by iio_dma_can_enqueue_block(),
> but by then its fence has taken the place of the first one. When the DMA
> is done, iio_buffer_signal_dmabuf_done() signals a fence which has been
> freed and schedules the work item in it.
> 
> The leak came from the reference which iio_buffer_signal_dmabuf_done()
> takes and iio_buffer_cleanup() drops: with it nobody dropped the initial
> one. Do not take it, and leave the initial reference to the block until
> the cleanup.
> 
> Fixes: a09399935508 ("iio: buffer: Fix DMA fence leak in iio_buffer_enqueue_dmabuf()")
> Cc: stable <stable@kernel.org>
> Cc: David Lechner <dlechner@baylibre.com>
> Cc: "Nuno Sá" <nuno.sa@analog.com>
> Cc: Andy Shevchenko <andy@kernel.org>
> Cc: "Benoît Monin" <benoit.monin@bootlin.com>
> Cc: Paul Cercueil <paul@crapouillou.net>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---

Patch looks good to me! Maybe Paul remembers why all of that refcouting
dance was needed. Like this, it feels more natural:

Reviewed-by: Nuno Sá <nuno.sa@analog.com>

>  drivers/iio/industrialio-buffer.c | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
> index 4294101810fd..a2386dba497c 100644
> --- a/drivers/iio/industrialio-buffer.c
> +++ b/drivers/iio/industrialio-buffer.c
> @@ -1931,9 +1931,14 @@ static int iio_buffer_enqueue_dmabuf(struct iio_dev_buffer_pair *ib,
>  	if (ret)
>  		goto err_queue_unlock;
>  
> +	/*
> +	 * The reservation object takes a reference of its own, and drops it as
> +	 * soon as a later fence of this attachment takes the place of this
> +	 * one. The initial reference stays with the block, which points to the
> +	 * fence until iio_buffer_cleanup() has run.
> +	 */
>  	dma_resv_add_fence(dmabuf->resv, &fence->base,
>  			   dma_to_ram ? DMA_RESV_USAGE_WRITE : DMA_RESV_USAGE_READ);
> -	dma_fence_put(&fence->base);
>  	dma_resv_unlock(dmabuf->resv);
>  
>  	cookie = dma_fence_begin_signalling();
> @@ -1989,18 +1994,12 @@ void iio_buffer_signal_dmabuf_done(struct dma_fence *fence, int ret)
>  		container_of(fence, struct iio_dma_fence, base);
>  	bool cookie = dma_fence_begin_signalling();
>  
> -	/*
> -	 * Get a reference to the fence, so that it's not freed as soon as
> -	 * it's signaled.
> -	 */
> -	dma_fence_get(fence);
> -
>  	fence->error = ret;
>  	dma_fence_signal(fence);
>  	dma_fence_end_signalling(cookie);
>  
>  	/*
> -	 * The fence will be unref'd in iio_buffer_cleanup.
> +	 * The reference of the block will be dropped in iio_buffer_cleanup.
>  	 * It can't be done here, as the unref functions might try to lock the
>  	 * resv object, which can deadlock.
>  	 */
> 
> -- 
> 2.56.0
> 
