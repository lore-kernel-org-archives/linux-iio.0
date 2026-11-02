Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.139.77
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793616676;
	b=KmahBoB6dIfhn320r6XGJbaacUVCKBz+PCuLBe21yLxatzukRhk0+IGYAN/A/MeMaaW8
	 JY0GrTfjjlEoQBHqXS6c9zTK9ierjwACW8fiUAN2NOqfiSFjANDFwpZqQUNiCaQMQCc+e
	 w8+3uX31KYM2hNYsEYx3JjS+I8/4LX9rj4Dk/d1BReIvllphDQlUVNh70gl4QYFRkPB4T
	 Rtqt7jWyWpZG6Szz6fDYgopQPSYhNsHkofPNITVty1pcLCKVhgl26IJdDOqFraaQqM2HQ
	 hlJocl6b/PLVUXr/uYSWWzN+odShEsnsGfTXjLbzZWorkTFEJ8kvdd280F5+PkmqxqQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793616676;
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
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=/cxLqJ530uJ2cgaKffL/awV1/KKaeRKquoYhla2SwjA=;
	b=4Y4PW1Sdg9f8SRS6Xv9HOI/5RVFuYYasdhxnsX8z5y97s61foejNykz6lG2ukvnTVa0y
	 o6frrsPcIIx4oBFDwiX27BeUj2aqFsI/imMLaqNYROEAik0o5TSg/Ol0VyyGj33ikKuIt
	 q0+eGZjQKp0Am15lcM3ko/0SY3nhx0jDse1D04Zp3UUHT0UNLbkJGMu8Ci+rZeZX1iG3d
	 5RwsB5ugeib2a4BGzPDhqTo3zinMn12o+/oByxtqmHMNrbbfISOlJK6Tzg0jQ7QlsLHua
	 rlvX7UXIcFE3jrAhHMUXtl0YW0oEvlxwHgkSWNA3iwyfbs5Le5KSrUxbTT8ZLjLmESg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=kaMf3hH6;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=no8hQhA0;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.139.77
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF12C606A324;
	Mon,  2 Nov 2026 10:51:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AF12C606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=kaMf3hH6;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=no8hQhA0
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A29BVEu3170605;
	Mon, 2 Nov 2026 05:51:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=/cxLqJ530uJ2cgaKffL/awV1/KKaeRKquoYhla2SwjA=; b=kaMf3hH
	6aabiG4DGIK6XAo8KyXm8vr/QUrhD/JBPRj6ptXUaLMRn0Ln8ujARjXKCzm8Nvj1
	pQnicUY/Q17Dlu7Rt5Tb227SAzOUGQ+yoe/ZyNgHNzVGwMLddgy+4EJiVFyPzeeK
	lOAcn1WQ+LX5DYq2g2xoiHLkEvnMMqJojd/guCzYxfR0iWvElpQquMKnolFfi5gQ
	6Yu4GLIu2Bkqt8QkWcSFX3c4dXJtGF9j/ZtonGHJH+qFeQA4kAn2ZoSSlja63H1S
	ZsQcPxpC2W2acK9xkO9CEjlb9B/SgUY/KQoPKLdZuI8GqvkJ/cB5nCkm4epvSnJQ
	t3oR6oAOq7Y7NWQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=/cxLq
	J530uJ2cgaKffL/awV1/KKaeRKquoYhla2SwjA=; b=no8hQhA0e4HFo+Ac7ZBiJ
	HHCIW+ZoyzPvgijnig5rWErMe3rHH84RyJLksb6Wfp1Eu3m7OoSmglS+a7tr8uFj
	o5pP39M5kp93vbc5kQ435O2h1jI6n+QMvnz0up14TRjQ873CJa0eJuHmNtKF/z/u
	4ffUNVKM7n0yr6U9pkTRaB09oR3RAzFkxNhzsYCZViG4SgdUS+74DslygGnfXE82
	igJO51p8Z2mK2bO8+devyYBh6tdY5QO8/LRZhy3hkzqdq5mxd8Wz29OSHTp+BNrB
	PLDv06fqyFN3gosEBnh3ek1XBwiOOqEOV7ZIYt9TpZErn7ouJFTA+1nrz9ZK7uiu
	w==
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013012.outbound.protection.outlook.com [40.93.201.12])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4hph4c9yd1-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 02 Nov 2026 05:51:10 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xplPkY09GMIJDiBSRm2KiY1wl1w/KukC2Wj0gqaDfjSy+FMNkwFgClcaJaa0ZzkYb2aOK7h2LhNHv1ofTSuS3Y9vlTpVoJ+kXrDZNDxWOA83cbwmh+DMTfVb4qSK0gR4/uREo255VYg+v8tg/PefG2usupcawZuGEEAgnf3K7io7l+TB53YUqzylWZOTWAY88jWQAdQiqZwmI+QDRuW8p5z0SZHyuPirmM4mSfFeO5z4y1o29dQgf8y0eamr13X5D+QjvwAjCQk+q3wv1MhsagetIrTUYbMDe26Kzjc9XT0PmsQK+rvC9PjkAPtpvi1Bvgk/5F1Gxeh6icqwTfoMYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/cxLqJ530uJ2cgaKffL/awV1/KKaeRKquoYhla2SwjA=;
 b=O9oTeLD3dy/U7l9iOBOnAJsM5p5mcJB++YBA+e01VZzxIQ9ijwzpnnqNW1v93G3KYOuQ0LKG7Ubj6xx/Xw+O+t/Z2W1r2RRyw5atfhYnE5+WFWpSC5OCSEcgugJTM+3MYp4qeFUSsNChsBSM5piIv7dvpLLE06cukmwDmePTUDfW9nihWywOMkhOcZLI0G1GquOMS6KZzZUwfhADPxNcrZ1MoUruWpHplw70Ht19yNx7z7uegk+vuIPTYrIu69DfRA9IBCzDFBPMiBvBXxjA5g7JlzyO7Jmpsfo47LoxAxOC6o/Yw5suoMqEEGEJAqZOrKJYcMzy5Ta057SYkEjHzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by BY1PR03MB7924.namprd03.prod.outlook.com (2603:10b6:a03:5b7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 10:51:08 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%6]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 10:51:07 +0000
Date: Mon, 2 Nov 2026 10:52:22 +0000
From: Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: "Tsao, Bruce" <bruce.tsao@analog.com>, Jonathan Cameron <jic23@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/2] iio: dac: add support for AD5413
Message-ID: <auhqSGR84LUTjBS7@nsa>
References: <20261017-ad5413-upstream-v1-0-61f40c8fef25@analog.com>
 <atXY4kLEXxmG-tnk@ashevche-desk.local>
 <DS2PR03MB84188FD41F8847EEB34759D9FB672@DS2PR03MB8418.namprd03.prod.outlook.com>
 <athZVjaGYmCyuNrW@ashevche-desk.local>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <athZVjaGYmCyuNrW@ashevche-desk.local>
X-ClientProxiedBy: MA4P292CA0009.ESPP292.PROD.OUTLOOK.COM
 (2603:10a6:250:2d::6) To SJ0PR03MB5469.namprd03.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|BY1PR03MB7924:EE_
X-MS-Office365-Filtering-Correlation-Id: 32039b26-c8da-4f7b-f318-08df38cf32a3
X-LD-Processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|23010399003|366016|4143699003|11063799006|56012099006|261009223027099003|261028144727099003|261021123027099003|261021121427099003|261021130227099003|261021135927099003|261026121527099003|261022115727099003|261022075727099003|261022105027099003|261026130827099003|261022113327099003|261026140227099003|10067099003|18002099003|22082099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
 iYi7rM1R8aPksLYfoHiGIEq1yl2nB4fiBb4/9nPZ4Pfo89COXTeU3OZOt/nP5h3TlzbopKXoBqO3EVcUZeB0CENpnmx5gG2MpA0KSwVOQTZ5n55t36LzaR/sja7hUBZTLkXr7mGTnYSyhhJwnJ3mOOyoFMAcKgfxCAcYdCF/3BzW+H5sl2ziRqYvDGBQXcVZS6ULhXrJ8sP45C+/mJuZxt8yIORLhlXreRijf2dBX5MPpQwuvfNJ+SZQOasScJFzC3aj3wdk9JCzblncca8xa5A4bk4N864G1cEZAX9w50qya/YS82D/rhtkcSKrcM+4XIPf8YD0vSC0vR8TxQV+M4SbSMgSGY1lflmOnhch9giglHd+AHsB4V8qEUJwKAcvA3TLE2ykc7u9m4x1FCakDm6DzxtkeNUTTknVbDWA1D6OSieXpbCN517NHvJ5uhG8XiXa1MXTxUoI8oTmU3mknLPRPMlUTvyMIC+sZ+YLl99Jh97kreJB92YOGiMBADyKQitablJh2zvORHaXxXAS5ELdbWTCEm0eWgjAUM9cuqeTEs09/rhpVmYA1a+LHfaCXSTcG3qAd/7y0wGlNk/cupqRB9BKUPyn5siEzGEQBriKrooFYTlBzZBPaFy1s7BH9R9gKLcm/ItgBsI3Y+YbgvzhzRyOfMCkArRrokej8lY=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(23010399003)(366016)(4143699003)(11063799006)(56012099006)(261009223027099003)(261028144727099003)(261021123027099003)(261021121427099003)(261021130227099003)(261021135927099003)(261026121527099003)(261022115727099003)(261022075727099003)(261022105027099003)(261026130827099003)(261022113327099003)(261026140227099003)(10067099003)(18002099003)(22082099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?MXBMK0VWTXdyT3MxWUFnaUF1R3RpSkJudjhYMXEwUDlDSlNXMmhpeW9Ob25q?=
 =?utf-8?B?WmowRzl6VGtQMTdNcEhSRktUaDRvUTFMZ2ZldFJ3WnJPWGJCS1lUekZjcDBy?=
 =?utf-8?B?Nk5PcXk0ZjlXN1VRZFBValJQTmxPK1JSQnkySjcvYnI5Siswc3MzMU0yVzFu?=
 =?utf-8?B?enlFamRYVFhZMktjeW1oS0VETE4vQlZJNDBXMC9qcWZxbnJJZTJIRHZkc25r?=
 =?utf-8?B?a0psRWUvaWhyMlp4MGVGemFLenNjUHdHMUEyZXpzb053bVlzQUVjYi9odENF?=
 =?utf-8?B?ZnNCeG8wVWttbWNZVHBCQ1hqQkRpYkxKVHFBd3VtT3NrSjlqUW1SSlpERkQ3?=
 =?utf-8?B?dmZWczh0KzJraisvQm5CRUVpOWRPYklxNyttUUdCWTlsZXRKSzFvOExuQVA1?=
 =?utf-8?B?ekRyZzZub05pdU5pb2JlbklnUUg1bExyQWNaMXAyMlY1L2NseGc5UkRQWHNu?=
 =?utf-8?B?WUpEOXQvZitkWlJNTlFjQUpiOHgyNkFQQ3pESEhQTEpRNmhEb0xFS2NucEpj?=
 =?utf-8?B?WkJHdldoQUJScktPeDRNWlN0YU8wRHlSZ1ppYnV5OW5sVVprQjJ5cG9GVjJo?=
 =?utf-8?B?OXlwaGZjQmRqL3JMSXc4OFRKYk1BdGlsdm5GeDVPLzZZL2RYb3lWNlE0Ty94?=
 =?utf-8?B?bjFRTnBrSk9UQk4xZEk5Q3NvZ1Voa3RIQWN1a3BLbFUzUVpaaU5IcS82VmdK?=
 =?utf-8?B?OUl3dnprU2pXWmZQZDZRRjJmUWRjM2paRXhYSTd1QyszeXdwTzdEOEZYKzZt?=
 =?utf-8?B?ZUJUWVMreTcrUXo1cVBzQjJGaElCMHJsQmF4aXVVSndlTk80TytMYUxFdlJq?=
 =?utf-8?B?OGdpZVFUNDEySitUL0hvYnFRams2YnZkbjBYY2RURUlBcUxrTzFwcmx3aC9H?=
 =?utf-8?B?RWNrVEVyMUp3SVFCYUs3eEZsQlpJcDMzZWtMWGlEMHhVY2xONnk5VDI4Y1Fi?=
 =?utf-8?B?WTk2bjhDaUpzdjNGV08yM2w3MVlPLy9xa21LMk5iWEp1OEZzMHNYOGV2NkFm?=
 =?utf-8?B?WkZRVE42NncxZ1FKbEpYMG1VaWJTZkIrZW9acGh1b0pjQk5lUEk1ZnlSQUFj?=
 =?utf-8?B?MzVjWG1LdDBDeHFhbU56TzhiSVlnU0hDTVltRjZXZmprVy9jUkF0RGlneXoz?=
 =?utf-8?B?Ti8rZFp4WU9Fa0F3TVlUSmdUYXpPZlN2NmxNZUg4V1ZXVCtCVTA3a09NQ1li?=
 =?utf-8?B?Y25jV0tqZ1NGU3U2K3RIQ25RcGpEaWVpdTAzZkg4OFZEdXRTSG1BTGZNVTRZ?=
 =?utf-8?B?K0NUalVDSTRrdVU1L2c2d3JBWHdtWE9uMVkxY2ZRQWl1YjhhMTlNTWFYV2JI?=
 =?utf-8?B?Y3NNd1YrQkc3cllObVRtZEpRbXNCdGxaQm1qNTB5ZmZSR0RMS0liRk5qMDFt?=
 =?utf-8?B?TmlTYXo3d3JTKzU3UFBBaFZNaFY1K0JDSTdOVmpEY29HRlNudFBLVlVuN3NS?=
 =?utf-8?B?UHNCazlHSW4vY1I5dVhnQVBwMmU1WGsvUVBuMHo0VU5obHBodEt4cWVrTVhR?=
 =?utf-8?B?bU42R1FrQjFQNGRPY05mVWxkU21QY09GOGhMdzNZUUJlaEd3Qno1TmZwcUh0?=
 =?utf-8?B?eUhqa1pFNzRTWDhDYkpEUHdsSHR6VWplUGhGSWxyWnNGZmxFRldzNGsvWldT?=
 =?utf-8?B?Vi9BSXVZcXBPdEZGcUs1TXg5TXFYMmZKL1NxNVB5QU5FMWY0Y2VHeDkvRFMx?=
 =?utf-8?B?YU04MWVZQWQ2T1FxbWsvTmVyS1k0cEV2b1M0SmpxNE9vRG40dFRCcDVpcmFB?=
 =?utf-8?B?cUtNYU45WkpxVFNrL3hkeXRjNVJjQzJEZW1FNFdqckUwTm9FaVBIMDgvRzUr?=
 =?utf-8?B?UjlyNVRvQzA4b2x1Z0dLY2F0REJBcHMxeWovNUNoMG5HOWJVUmNJSzMvUnVz?=
 =?utf-8?B?WGNweVNUdWV2NnQyaDdYaWg0TjlOZWh0WjFsandYeHVDVURuZkQ5aEo5Qm5F?=
 =?utf-8?B?Z3VhMGNHOWc1MERRVUdoMFlXQWIxS2pBbHlEV2l1UXd2V1kvNjBEc0J0K0RF?=
 =?utf-8?B?N2RXaTdBZjNraytSN1VzcHRma2xjcnc3WVRXSkgrY3dIM1dkdFFTbHRBODVV?=
 =?utf-8?B?bkNwRms1QU5FejFFZ0xKRzdSTWl3WHFkcU42c3BHV0Y2K2RiTzZTUE1RdlVj?=
 =?utf-8?B?bWtVQ2NOVlhtMTAxVmJxQmRMbXdoaTdIOVRvV3loMXJCdWo0eFoyMWEvK1A1?=
 =?utf-8?B?TEoxQm5Fd0lrTktBUzh6eGhpZHk1Rmk0UDJwWDk3T3BGekZCSG1ZMHZRODlM?=
 =?utf-8?B?bVk5VDltdEhGV2dFZ1A0ckFTR0dUTmdabUQvK2JaVWdSMHRBanZQYWpnVjJH?=
 =?utf-8?B?OFpNajNiUVN1MnQ1ODZYYjRNTk9QVEFqUkFEZ29tT1RSZFh3VGxPZz09?=
X-Exchange-RoutingPolicyChecked:
	EnyYG/bHZlbYyuInpGxxqASKePSNSaBLD4OsyrCQAiosnAmnstkSaTd/hBW+2eq8nc7JX3EsIfaiQA3bSnPFHVniRlLC4z+Y7ZojAxPV33PjKNosFfC8Z0gAUIQejEnUjPPBmaHpxV3bbc3mYH4KkhjWgSyrwO+lHaIOMlUIbcNSmpPOgBjOCMp0HjXILN6tRQ92FmTkugnlpFUOb5vOca1xIsgp6I1Fxtu1wcGju9qWzomQQ+bQ+hK0ZTgbE4AsYXWlPQgyCWRrekbRzTfJ25vTv5LQz0PJQ/AkGgnvl3SIHtDx3ZebXIEXiFQd3p904ZlsJ0Sd4ItbmwRKuT9Dbw==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32039b26-c8da-4f7b-f318-08df38cf32a3
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 10:51:07.2199
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3V2gF+DthCg1Uj5V3qtLtFIBhzaZ6z61j4c6kvZbuH8i6I0fjc8JRhANSyEmcSEepZaPs3zFFPl+r+Hwm6Pepw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR03MB7924
X-Authority-Analysis: v=2.4 cv=VMdIDNPX c=1 sm=1 tr=0 ts=6ae86b1e cx=c_pps
 a=4PCWzz9QFLYZoRw/GV/NtA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=ugNRTJOwpmtT476g4l8T:22
 a=O7QQmKj4bXYSVth_h9wA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: _Hff0Ys-RB3xkJ9PBt4We7PAryH0kNAD
X-Proofpoint-ORIG-GUID: _Hff0Ys-RB3xkJ9PBt4We7PAryH0kNAD
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDA0MyBTYWx0ZWRfXygj71zIJJAtc
 ETlJdNYsh8zzc5OiUSq0npe8tUqPkd3ssXqpcUbEyi46o+DfEaJ//k+eYM68sfJEFhILcFgEGA4
 QKHFc8OHfesu+2ccDt5PSIlpwSsvy1kIkmHKJgf1mH+54DW88Uzu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA0MyBTYWx0ZWRfX7K2tZ3vAXqM8
 0W5ZpK+5m2ltPvjo+Cxg2uwwK2w89GQlOyUn6j/AaJZwG7RNwmnR3a5CogHIGTI+lgA6lCVeI/E
 SaMp7SsRqsahUb5UOy5k/OMLpcOHJs54EzMTgLUvoNlQNxiYZNGETY6/izzUHWtwt1G2avGMhOu
 fQplA0R8qye/QKmxWq/aXeqkzJM6t8a/17v+N22OUq+pTAmRN3Oy0EwzYAL4Mko7RO0f+MiNfEF
 KxnVGqEZbCJKPAcwAAJVpbI9NrP4ls3klXCbmZ9AgYd9iyNctLAkjBh14fIuwOkMJCIfT0Jtigt
 SAurVKtHdqMegHi7JCjmSao4SfAo0Gap7a9puLlu42q/TceEwk+fWydjmkqMNK9NYMQnuTQtyCL
 /50PA2A9aXYRiEwXBp/PIqOVtXb+kq2GfTa9f+MDTLKsf5/SkkPUHdxrwiAEnp5PGkQzbYFIuZB
 cf5YWv0J38vrimIOoxg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 impostorscore=0 phishscore=0 clxscore=1015
 bulkscore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611020043

On Wed, Oct 21, 2026 at 09:19:02AM +0300, Andy Shevchenko wrote:
> On Tue, Oct 20, 2026 at 11:53:53AM +0000, Tsao, Bruce wrote:
> > On Mon, Oct 19, 2026 at 11:46:26AM +0300, Andy Shevchenko wrote:
> > > Why in a brand new driver?
> > 
> > Thanks for taking a look.
> > 
> > The nearest existing driver is ad5758, and the two parts are closely
> > related at the register level (the DAC_CONFIG RANGE field, DIGITAL_DIAG,
> > the slew-rate block, the reset and calibration-refresh keys), so an
> > ad5758 variant is certainly feasible -- that was the first option I
> > considered.
> > 
> > The differences are a mix of hardware and current implementation:
> > 
> > - Hardware: the AD5758 integrates a DC-DC converter (adi,dc-dc-mode is
> >   mandatory in its DT parse and currently drives channel selection) that
> >   the AD5413 does not have; the AD5413 is also 14-bit rather than 16-bit
> >   and supports a different set of ranges.
> > 
> > - Current implementation: ad5758 disables the SPI CRC at probe, whereas
> >   the AD5413 driver keeps it on and computes a CRC-8 per outgoing frame
> >   (CRC is optional on the AD5413 too); the two also use different reset
> >   APIs.
> > 
> > None of this makes a shared driver impossible -- there's a genuine
> > common layer (two-stage readback, read-modify-write, the
> > reset/calibration/slew/output-enable sequences). I went with a
> > self-contained driver mainly to keep the change off existing ad5758
> > users and keep the blast radius small, at the cost of some duplication.
> > That's a tradeoff rather than a hard line, so if you or Jonathan would
> > prefer AD5413 as an ad5758 variant, I'm happy to prototype it; I'd just
> > like to agree the direction before spinning a v2.
> 
> I also would let David to comment as he has an expertise in the combining
> drivers (if I'm not mistaken). In any case he is also an official reviewer
> of IIO and might have some good ideas.
> 
> From my perspective sounds like there is not enough justification for
> a brand new driver. I remember seeing such a configurations (as per your
> item 1) just be provided via driver data depending on the compatible line.
> As for your item 2, I saw some development for CRC case in another driver
> and IIRC David driven that activity and he might give a better view.
> 

Yeah, tbh I did not even questioned using an existing driver
(internally). Normally I just assume that work was already done but need
to ask the question you did more times :).

If the differences boil down to what was stated in here, seems to me to
merging the device in the existing driver is very much doable and right.
Normally, if the register map+ fits, that's a good indication we can
integrate the device in an existing driver.

- Nuno Sá

> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 
