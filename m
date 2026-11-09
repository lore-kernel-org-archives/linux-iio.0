Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.135.77
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794240371;
	b=0PTZK5AS2zcRtaCzyrP40Go3lWMYUb7z7Vt0Jmvv8IKXT9+WvQiwVWH67y7QqW+fT8dt
	 bs9S7QMIoElIQn0+Eb0J9xNFCeQ9rGNIvcZcozhKP7JBmH7sIl1Yatm/Dno69UCThDKrN
	 CD2f4WQoWCHvHRzIwc8eDVAh2RKt1fx6vkJBorREaI6JvD0tYRG3EkkKGGwgRl7yL0W+F
	 1uo/E+4eSsKyrhGDS/BBgzAFIKrOS3Lc9mqV7JkfFczYgR5i5RuQhl+NlU24gYpIl0Mkt
	 W1CaOs9LKjwoFEL8DWPdyYJv0bq058GzJ+YfL4H4LA0q1uLUyH9ghTMflLesfkNmZww==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794240371;
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
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=tygyCDqw78qv1857ZCa59KyEm3Vs97z5dtupd/gwzNU=;
	b=kBeT9TjMBvdfAT1KCos0quBgKsHc14beYwG9/bowix8leXfqcS9vlf+9rKBcN+iXcvMs
	 VC/eoCwAZDTCPWnlvc38v2ufAwDF8tCNxexvkHlok0acfJwmk2AsK553n/afu8YUG9n9Y
	 52N5nvWR9y765URisjMLo/v4NKFoS/hUI2jJ+f3Zvkj7ShQLz9ODdJCqHusVqM7vJsKiw
	 Gg0xR4v1S/K5CMuUu8o2hKVkNHUrhqFPYGAe9OlWzTohlcLOnE1FeACEVvyzc08JsdsaY
	 /EGuAjgEoEA1BMUvd1nS66MF0nwgMIg6IDanklCmY5S834tJ/sPXDL1xlXRq+Ld6U/g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=tLucM4sy;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=P4wDx5jU;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.135.77
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53CAF606A332;
	Mon,  9 Nov 2026 16:06:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 53CAF606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=tLucM4sy;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=P4wDx5jU
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A9G0roL226504;
	Mon, 9 Nov 2026 11:06:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=tygyCDqw78qv1857ZCa59KyEm3Vs97z5dtupd/gwzNU=; b=tLucM4s
	ymABdHTFd08SClM1yIwM0fKPCJe2gqMkOTOzsqR3YAyLPkP3gmQeJzehi5LPM4V5
	IXxYgMyprRqhvuYlbfxtdaQ//Jm5/S4fNPKzd9lzilpOHZieFuYGdvcy84EU8Gvy
	/mHiulLbz6LEJ4kr8Gfcg25qWvkov4BMocrM4BjXoM4cBzA8OhYL4jFcFWwJczhW
	19vrIls0obXKT9iwdaoccQ2GQZzpgP2UhddIYwAHXMNP862JARqPFaRc8XdNAcTQ
	PTmHFqJSaHiBU7qvgFQznVzyccsFD6m5ElIIvfg4jxwVmh4q3M389qjEnKnNmax1
	8+5v5nLvfPzh7zA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=tygyC
	Dqw78qv1857ZCa59KyEm3Vs97z5dtupd/gwzNU=; b=P4wDx5jUwixg8mofnOO6q
	RQe8DPdzMFj2lTlLjpxugVHHZj5SWMfjvmo7/9kpFp+pcj7RrSKh7RrX/TrWOKjK
	alRbz89iHEFV5ap0QrAdxA0uso4bwghM6PtS71oYzOy3xFH7OR9g0mWfjfE3dLwF
	TVtOhb1UBwMdfKnE3+iBKmUIR3b4LFKHl18mcHm7qUto4aeRU/adEMxGkL1Jv1vp
	CxIRitOP+91B/CoJwrX36g2bDx1qcYtoirVt91eDbojz8Nv9CcwFBgUJxy9NM/C8
	0tu00REDXC9rcCi6gwOD5YMPtoOuceTEwKKdR5RFZzXOsKlNVFjVmp7qGrAYqAsO
	Q==
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010064.outbound.protection.outlook.com [52.101.85.64])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4huhau816c-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 09 Nov 2026 11:06:06 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U33UdbiieF6v5mEoouzaqNlBbXFC0uYX7YQ+Rd9AWQ71TvN2aqbtspI8ADDZ8d4jccLRGbCn3tBmBG8rGa6Of55uxMHvOgyMelNacxYIfGFi0gPHDtgpxDhwSrDEVMM+lPXDZOGKfmztfMT/Bvg4AWt+KBxs4pGhHtaPGkLi5IAngoRrHLPoQ5Aw6ed7plwmd/g4sg0RBs6+BR20aKTpR3ap0crLeCTCIMF5HWl3zmRC66303p2Inx/Lzom7IDFeGPeZ78BYvDbtKry0ppAFQRs3k4dToZq3G9uNwO8drwqXUthLdeEJOQIaub4OFGtccSFFhJ5MvY8U2g5GN2gzWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tygyCDqw78qv1857ZCa59KyEm3Vs97z5dtupd/gwzNU=;
 b=gum20EIS9GEh3MO9Y/GnQIj/jmlPNFGaHRWcjr5zdqXYJSofNw4hAFYSwH963WCWqgGIJcOgCGl3FliJhUy+NE6g9rk9ayfk9fGxVRYA0TEfIrkitdCu9Y7rIuLhOTRtrr5BY4SxGPaQn0CcNotUf68bjrCMivsmimfrlkgFu8wRoHxZc3r34SZSUWNdTfMbu+CmNJBopQfAiUPQToGv9TJd18Q/gKsCP5zfvTaQuTvbcn5YGqjjGiDYdGfUkstwFxwg1oe1vN5udyWW1ZXJTwlp5w4sL0hnedOPCoNzoqcDl3KfmE1TAFXLkEWONYG+OQf3GoyRbskBNMqN4tAtUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by DS0PR03MB989665.namprd03.prod.outlook.com (2603:10b6:8:425::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Mon, 9 Nov
 2026 16:06:03 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%6]) with mapi id 15.21.0592.012; Mon, 9 Nov 2026
 16:06:03 +0000
Date: Mon, 9 Nov 2026 16:07:29 +0000
From: Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>
To: Adi =?utf-8?B?S2FkdcWhacSH?= <kadusicadi1@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        David Lechner <dlechner@baylibre.com>,
        Andy Shevchenko <andy@kernel.org>, linux@analog.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: adc: ad_sigma_delta: use __free(kfree) for
 temporary buffers
Message-ID: <avHvqEZHAswT77tA@nsa>
References: <20261108201522.249539-1-kadusicadi1@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261108201522.249539-1-kadusicadi1@gmail.com>
X-ClientProxiedBy: MA4P292CA0011.ESPP292.PROD.OUTLOOK.COM
 (2603:10a6:250:2d::17) To SJ0PR03MB5469.namprd03.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|DS0PR03MB989665:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b1952e7-dfff-46c2-ece5-08df3e7b5a4e
X-LD-Processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|22082099003|18002099003|10067099003|11063799006|261028144727099003|261102130727099003|261102123227099003|261022075727099003|261022105027099003|56012099006|261021123027099003|261021121427099003|261026121527099003|261026140227099003|261009223027099003;
X-Microsoft-Antispam-Message-Info:
 bqkw8LBIRYtd7yahc/bQVDM6lfKA0sdLliH/wXxQDOyBzMtfBf/YPMFpW1DH06A0XYWGEW7pGtxFKgYLubepMwyYp10j+2i6gWUQdroeUOn2qB0x6tjCC3xAspb8qIA+aDA6ZCVUwSW0SsYGq/tY3tl0ZSqGbqp5sWKV74U0pmr+BWGf0DnE0LQb7BF67jRaeZomkvzIcg59K90vmas18bf43mVsjGYJhyCLF8YorUM/vC0up4jg5SgwOl/F8vRFZXrPmryor5GYXU9ME8C+qLQxfs8FZVp3eB1+cT78kwHGqAz6ZTOWP1mlu6pRURsY85XO3Zlxv7kYeicf8eA3kD9j55HAzIziiLztnjMwmtUWf7ctuZffRftvPyVJAlL3Sz5BQPWPG+46SInQLxF7iiEO3agMjc+3iQIkYRRKd09KKUHC5nwXlMRBEN/A4xmQGJX4iPFS/jj9Y9zBnSE4Q9luCjrdWaCJJ8lBAQUbn+Lbuo/06HQsa3Md1Hwpe82Lh6Szk+LAt2HR5qX3f455i8lg6FcmveHo1XQ97a7SwGYoVxMDeBzbSANfAPcVoi2WuOxhzrOgX7NDuYwEYUZO0YemySLspVI/x6op5BQITKdBpKt/1NEIKH3ZBnOfTb6L
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(22082099003)(18002099003)(10067099003)(11063799006)(261028144727099003)(261102130727099003)(261102123227099003)(261022075727099003)(261022105027099003)(56012099006)(261021123027099003)(261021121427099003)(261026121527099003)(261026140227099003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?L1NLQ3p6U2hHNFVYTU5FMDRWeGZaRUhhbnNCNWJna1VvNm96V1d6R3hhNzFj?=
 =?utf-8?B?RUJCTm45OEJtaXo3RVpnY0lNRzlzR0lIWVk0eFFZSldzYnc3bitad0s4TjZG?=
 =?utf-8?B?ME1yZSs5Z1RvWW5CYmpkdXI2eWNDYWtJaFAxQkt6Z1NVS3l5R2VkVlJKYS9V?=
 =?utf-8?B?eHFwTU5yMFF2d05WL3ZsUkZ0TTV1RjVDcEJDNXEzR0RJVlB0dndXOUdVUjJy?=
 =?utf-8?B?M1RFZW4vTHkvS3h3NEpVNUNRbWpLRzQwb1JnWGdTR0VlM1F3MlBvLzlBZWRR?=
 =?utf-8?B?bjhTRmhzVEI0b0dlellwalFyZVNLQlZUTU1QN2FWSzFNVmYyME1kWU1QcERn?=
 =?utf-8?B?d3BpTUNZc0lrbUh4MUMrdUpNenk5OVBZVlRsb2hHL01vOEZpR1FmK0drb3ov?=
 =?utf-8?B?OHZVTzIyUG83WjdBZHIzRmhHWHVVWEYzMWlZNGV6VTZQN2oweG1FYzZ4Vkhv?=
 =?utf-8?B?TWNXenhCTEllV0Vab2szR3dMTmFUYngwYlFLQ3pnanFuUE1OR1REWWlwTlN1?=
 =?utf-8?B?MDRMZlBkNGY3V2xsU0R3SUZyVzNGUDhRTmZienlRckxxZjdlQ1pHd0txMk5v?=
 =?utf-8?B?NzdKWmpWWmhlOEdrTEJhNzU4VVJIUmRRN09hK29kYXpYb1BlNTI0WGhPVEt1?=
 =?utf-8?B?T0VBeGxMMzVYcUhid1BNZGMxTzFaTWZ6RENKQzNmQmE3OGhaYmdlYy9zc2ls?=
 =?utf-8?B?c0FGUnA0WnluOVBtbXFMK0FZTndqSExpNWdaTkh3cUJXaHhvVFpIeGZoblhs?=
 =?utf-8?B?VkxwYkRuRlFldnpHVzRqTzJJM1R5S2FETDhLRk52dmRFcS95b2lEeTBZNVdE?=
 =?utf-8?B?K0tuU1ZEaGphZTIwNk5rZ0lTeU5ZWmxOYU9hdFZzdGRHY0ZDcld3ZDVjOEJS?=
 =?utf-8?B?R1JMYUViNWs4L3hCSEVRZXR1bDIxekZWK2pmaGFIdFJPR1E0eURZemUwc1RM?=
 =?utf-8?B?RDhwQzhXb0padWkyNzhEb2o1bWhsMWhEWGdra0dIdkFLc1VOc0h0WDZtNjFo?=
 =?utf-8?B?M3Q4cFBFR0lvNGxhcVA3QjYycGF3eXlQeXJYbEY2K1FkdFh6K0I2Ujh1T3E1?=
 =?utf-8?B?dXBDOThRQjJsUkcwYkt5Z1ZoQk5DTEp4enF2eXBRRnRFalZuSm5hbVdOR2xC?=
 =?utf-8?B?MmVDKyt3Rk9JT3EraGFvVHBTVGIxWG50eGpDTTZ6dkFQenVXRjhWbW81SDZr?=
 =?utf-8?B?aTkxbksxekwzaHFkSWMvVkREbU1MY0o4cGFRQzQrUm9XSDQ1c0R3alJmenYr?=
 =?utf-8?B?WkVyOE9rSXFCbXhGK2ovaW1YcGlwL3BJcFZ1NjcyRVVxVDNISStuTVpHU0Jz?=
 =?utf-8?B?RFh2M0dadXVlZXgwbEM1MVQrR2F2c3M3c0tsUmdSMW1xeGpRc3g1RVk0UzR0?=
 =?utf-8?B?WTVSVHBJdHJoM2FiMDA0dUFuRFExTlRTMEZCQ3VMWE5Rd2E1ZlZvRS9NS1Nm?=
 =?utf-8?B?SUYvZXI5bmRPL3RoR3h0emdJSkZYT29nZTI5NlBrQUx6aFpLRjRna0lISnZM?=
 =?utf-8?B?SjVQQmkyQXN6TGJMczF1dFN6RUYrbkRpOXp2emMrSXN4MDdKc2ExWVIxR3pa?=
 =?utf-8?B?MFdhaGhpTGYxbUFxaExNTTRDMnQrcGhjdHczdk05NklPaGRpVHJtZGpmSFNG?=
 =?utf-8?B?NUU5ayt6V1p3aDkvU08xVDBDN0RVTmZENlJCdnpVWE1tcWZaQ2Y0QnpwWG0r?=
 =?utf-8?B?dTZSdEd4UGowblpxZHlmditaNmxBVkVUWjZwT2tGUTkzeG55QStTaWFEUzlO?=
 =?utf-8?B?Q0VtcFU3WVJjN0xPTGUxTTVPMXFCREhCYWtTeFVDYTIwL1ZvbC9IRUNwSEp6?=
 =?utf-8?B?UEtjbjQvdy9WUHlOQ2c5d05XWnRoRzE0NlQxdmdaZjl0SlJXRVB0Ulhmb1Bz?=
 =?utf-8?B?M1p2a2VKT1N5bDRkS2lXYW9RYmRpalV1MUUvQVEwZ0pQbUZlcUZQTENSa3Zm?=
 =?utf-8?B?aThrRmpMVExzRXp0Vk1ZVmY2SXhrSXlyMGhXNWRrcHVUTVIxZmc4ZVVGbGJF?=
 =?utf-8?B?WlN3bVArU25vdnYvWFlUMnY0VCt1R09CcVQraCtTMHQyV0NJMHlNS3dmUlBu?=
 =?utf-8?B?clVha2kycDA5YnJMMW1McXFVOWVHcit3VnFlL2Z4SHBPU2dUVmtYbFl1aXR3?=
 =?utf-8?B?cDhhTW5lUXpKUndiMUNMQnBvMFh5UjBkNUwrZXhCNmV4UTJSVk5qM1Y5b2Y5?=
 =?utf-8?B?MFZNN0RKa2ErZVo3NUpDN0V5NlgrU1I5N0xQOTNYdkZ1elhzbDduZm1RMU5Q?=
 =?utf-8?B?U0Yxd2ZIRkZ3eHQ1eExCeElxd1MxZmpCa1NPeG5GbnFaV3E3V1haZDNRNlpl?=
 =?utf-8?B?TXZFVDROdGhjTVFJMjE3YkRTOVc2QWNiWUpndXlHRkNmS2xyVnRCZz09?=
X-Exchange-RoutingPolicyChecked:
	5witTBROJJ72tHJWE2sezYT7U9NaL0jFizTG5R0aL7uDZUXap2pyOF6TDjvIQ4vuoLJwPS5aPjqwS/atJP+1PZnuzDHX3/9gG4GzZl5XKMazZMqrulEmBAWiGzDOoO8UtntEV+aT9ATZXFts6i55azVmGhGMNUOepzW1IVxfm8AqGsxGE6VaJJYJaBTvyRabnK+JNB2sOZ5jNr4cPlaabGuRpcoscqrVLOo/5wIHI0HR2NTi6eO3lTMBidH49D/n1CG1SmnQQxnybShf3utMfTGFwO2Hnrr7IW5OcTtyTr8Rt2iidfjIhGPCF2t2RVPpPzjtnLxwvSsrYCCAMlRZjA==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b1952e7-dfff-46c2-ece5-08df3e7b5a4e
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 16:06:03.0262
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QumFcpJq9KxSsbv7V2XTZKoxVie9kxFBGKwktdw5EZllLh15UwuO+0mq6Z8SCIBqkvrbIvyzWhS0MJ3vIMfuGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR03MB989665
X-Proofpoint-GUID: YImM7Ryz89GMVHoneYFGPm3Eb9ummZIQ
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDA2NCBTYWx0ZWRfXwo8c+PuQqHlT
 6D1WPSDQGd8aHEnvVefFHbTxHAcEIV1N0CpuTNXaM3M22oYVK8cA/NUIWkGxiZeGc0TYdsDEajb
 PlN93LPUKFyqLGof1mGxGPi35NQK7gdMxCrDnIM2YCzV834TkDKa
X-Proofpoint-ORIG-GUID: YImM7Ryz89GMVHoneYFGPm3Eb9ummZIQ
X-Authority-Analysis: v=2.4 cv=abT0Dhot c=1 sm=1 tr=0 ts=6af1ef6e cx=c_pps
 a=Et1EcG/LeKhR1br1BBFfMA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=Z0pTeXoby7EwIRygza74:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=gAnH3GRIAAAA:8 a=7YdiRr2NDpRPbVO2Ap4A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA2NCBTYWx0ZWRfX0vftNPqFJl1W
 EShKt1gYtTm8tFJMckKbvFxU9TQAd5LDr40ptj1RVYopOoiH96WYiM5SHvsdDWA0rFcnjVR3Go3
 HdGYV0KEmdTSE9QjKU7q+g897Wewgcc99CYdMSX1lZbIZR112MoiWJAL/2pe6zrE+y3Thi6RE8T
 9lfeLEDytdPcs+cV5wYiJrgwywkX44PSAfVNA1SMIVnHZOjCy73Enh8Uz1egV+mhr9XGl9FKbMc
 7T/Y9VZlhhV/e0KDF1HgNm/FmUdGn9hbIQDwNkwdQHx1tBsu/aeWNMVbdfrqi5gvVww4qHN7E3q
 KOjcaAhWbYbLiFD3S1fJVPuG0LQqrBZHo0hh3VrMElZu1UIttixT+VlDS6UcV3mDTok0CMBgaqo
 bScohVL0OK0VHZk/z4DJ0SZBOZhxPkGX1Tht4nNq+2KklY7NuFfH2hQT5isoXskaRFMLY0QCzcs
 0vyCjZ2BA/EkHrFgHjQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_05,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1011 adultscore=0 suspectscore=0 phishscore=0
 lowpriorityscore=0 malwarescore=0 priorityscore=1501 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611090064

On Sun, Nov 08, 2026 at 09:15:22PM +0100, Adi Kadušić wrote:
> Replace manual kfree() calls with the __free(kfree) cleanup attribute.
> No functional change.
> 
> Signed-off-by: Adi Kadušić <kadusicadi1@gmail.com>
> ---

Yeps, like the change

Reviewed-by: Nuno Sá <nuno.sa@analog.com>

> Changes in v2:
> - Keep reset_length/size declarations in ad_sd_reset() as they were,
>   only declare buf with __free(kfree) at its allocation (Andy)
> 
> v1: https://lore.kernel.org/linux-iio/20261108013328.125069-1-kadusicadi1@gmail.com/T/#u
> 
>  drivers/iio/adc/ad_sigma_delta.c | 17 ++++-------------
>  1 file changed, 4 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigma_delta.c
> index 119ddc5a13e2..934c9965c69b 100644
> --- a/drivers/iio/adc/ad_sigma_delta.c
> +++ b/drivers/iio/adc/ad_sigma_delta.c
> @@ -205,19 +205,15 @@ int ad_sd_reset(struct ad_sigma_delta *sigma_delta)
>  {
>  	unsigned int reset_length = sigma_delta->info->num_resetclks;
>  	unsigned int size;
> -	u8 *buf;
> -	int ret;
>  
>  	size = BITS_TO_BYTES(reset_length);
> -	buf = kcalloc(size, sizeof(*buf), GFP_KERNEL);
> +	u8 *buf __free(kfree) = kcalloc(size, sizeof(*buf), GFP_KERNEL);
>  	if (!buf)
>  		return -ENOMEM;
>  
>  	memset(buf, 0xff, size);
> -	ret = spi_write(sigma_delta->spi, buf, size);
> -	kfree(buf);
>  
> -	return ret;
> +	return spi_write(sigma_delta->spi, buf, size);
>  }
>  EXPORT_SYMBOL_NS_GPL(ad_sd_reset, "IIO_AD_SIGMA_DELTA");
>  
> @@ -249,7 +245,6 @@ static int ad_sigma_delta_clear_pending_event(struct ad_sigma_delta *sigma_delta
>  {
>  	bool pending_event;
>  	unsigned int data_read_len = BITS_TO_BYTES(sigma_delta->info->num_resetclks);
> -	u8 *data;
>  	struct spi_transfer t[] = {
>  		{
>  			.len = 1,
> @@ -317,7 +312,7 @@ static int ad_sigma_delta_clear_pending_event(struct ad_sigma_delta *sigma_delta
>  	 * shorter than the reset procedure.
>  	 */
>  
> -	data = kzalloc(data_read_len + 1, GFP_KERNEL);
> +	u8 *data __free(kfree) = kzalloc(data_read_len + 1, GFP_KERNEL);
>  	if (!data)
>  		return -ENOMEM;
>  
> @@ -340,11 +335,7 @@ static int ad_sigma_delta_clear_pending_event(struct ad_sigma_delta *sigma_delta
>  	memset(data + 2, 0xff, data_read_len - 1);
>  	spi_message_add_tail(&t[1], &m);
>  
> -	ret = spi_sync_locked(sigma_delta->spi, &m);
> -
> -	kfree(data);
> -
> -	return ret;
> +	return spi_sync_locked(sigma_delta->spi, &m);
>  }
>  
>  int ad_sd_calibrate(struct ad_sigma_delta *sigma_delta,
> -- 
> 2.43.0
> 
