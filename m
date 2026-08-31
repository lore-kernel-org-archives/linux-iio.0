Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 927A31C5D72;
	Mon, 31 Aug 2026 11:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788176774; cv=fail; b=foYTo333Koq6kGYNK6Hvatj81WFqcKeRY9/7v1e0a9OeRTqRBLXoq0vVCiRGQk/nqJdnY5+X8y6lxiLAovhTHJARrTfFCB2/0pYZnjcMQkEfZjKxITbfja5dwIGZg8RoPqv0gSqJhojUn4VfnShfpU8sPrBtCQTP9+/+TdFhEm4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788176774; c=relaxed/simple;
	bh=yjzyhSMXBffTRGl7bXQ3k/5z64JFWQnZTOYUvVgmgmY=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=KPyrLM1WbBQeei2CvRHCIYR92NnG28IVoG5dhKbLZh3Y+mZo6YuvQPPgVHyQfwymzqiwuILNPZ33RlLuF5JxHZJk+t34WroENbS6+rgu4Elcb47R/oDNfncbTvqRGtDxTV47Faz5IjxkEBdz8lkUxrjaXDGXeCxucDe7tDuHw2U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=k8u4fHE1; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="k8u4fHE1"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67VBDGjv513316;
	Mon, 31 Aug 2026 07:45:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=BryT/5XU0Qq0Xxe8U8c24kWTMu/
	ZOY26KSC8h14Nglc=; b=k8u4fHE18LZoRJiG36IZcSQQdsrSnjZaShoLAXfiGhg
	uPd+qB30ZZmcoX8/+quJtlmCzuvpPo8yVcjFqvJ4ogXcx49nnbxz9Z49hPnmyK/f
	0599eI+pyaaXHmHayzC28WfouAtF1awaaw2rTMShuNGqFZMexI3hsbCRKMdSHi7U
	VaolPbs+G22O2OriEYuEWri83buiiXxrHjd0Ma5srDqCueVyQDa8cnpYzfXmBalg
	MTvpPk3VwTIhkC8WZF+G2dBS78ZHpJLOrI7k44MksvVaoyg4yVG0Cx9WXQzdbMJi
	pV3qQZDze4mEyuBROi0ToMKrqUlF2YXhF57XV+M1Oyg==
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012044.outbound.protection.outlook.com [40.107.209.44])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4gcdrdmhbp-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 07:45:28 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bmvLvuWH74hHyHQF5P2eN2AsnTKtp2oDzidUkPQV0ideTr918KiyTkxS1HwhucnmmV4pJFzukqfkCBrnJEP1hDYtS0Zn1v1cAUwmchd1GDLiqMD4bx0N33K1tND7o+PTsNCZLdxH2Z8YIevB+Jpw/gt1OT/lyOfTKQu9Tc3NFhC2ReVk+qj1RgZWC+bbPJv+nDMqR5iY0AiVJ1WXRNjC3gT/s1b0t1lAQ93jttjnAj/UEgjb6rjXqsSnswgZUOO/u4/ARgw5f6pLZ5TjL9DFJjTaxqwKjgu0EBi9cs3Dm+76Cu9me8zNVsCY540Ux8/+LaCBc2q6mSGU7NKClDBXEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BryT/5XU0Qq0Xxe8U8c24kWTMu/ZOY26KSC8h14Nglc=;
 b=LVlSTY/Gm3T1HZPnMRbBm/v6rcHIju4IziJHkCs41peRiG5h58FyxXY7DRkTRxeFvHVGUyQBReOCmKSVGfGzsk+ovdZVZwiuEf7rBayZfQrk5U8zK9h1k0LqFHwqAR4maOHeGMW2V4zSN60AW5gZf8lTRRNRzzj/GLF62UE9XhZoYNxwGjkcJrcu6oDaBOEbuPFn1FmAga7y+w7d1kGMCB/QTrPUyddiO6EZyWMo4IFtvjT1SYPEOghoWqbLj1dxWQY74l+SErQFIRwNC/v30hXVMRuZzSskKuK7VqV82P5sHk4lMpLrGaH/+JiMF+gCMttTRV1u8wdZ3KhBjQbmPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by EA8PPFB3C90C3D5.namprd03.prod.outlook.com (2603:10b6:30f:fff5::855) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 11:45:26 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%6]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 11:45:26 +0000
From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Subject: [PATCH v3 0/9] dmaengine: Support bus widths of 32 bytes and above
Date: Mon, 31 Aug 2026 12:46:37 +0100
Message-Id: <20260831-dmaengine-support-wider-dma-masks-v3-0-507d97496f2d@analog.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/43OTW6DMBAF4KtEXteRfwKGrHKPqIvBHhO3xUY20
 FYRdw8mipLsWL7R6HvvShJGh4kcd1cScXLJBb8E+bEj+gK+RerMkolgomQlL6jpAH3rPNI09n2
 IA/11BmO+0w7Sd6IFgObiUCsUiixOH9G6v7Xj/HnPaWy+UA8Zzh8Xl4YQ/9cRE89/j75yQ9/EK
 aMGhITK6EYV5Qk8/IR2r0OX9ZVSkm2lpJLCclubWsMrlbdP4rmu4ptIsZDcqkbVlWGysG/kPM8
 3a3ZXcIMBAAA=
X-Change-ID: 20260615-dmaengine-support-wider-dma-masks-5aac12497e27
To: linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
        linux-sound@vger.kernel.org, linux-spi@vger.kernel.org
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        =?utf-8?q?Am=C3=A9lie_Delaunay?= <amelie.delaunay@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        Andy Shevchenko <andy@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Frank Li <Frank.Li@nxp.com>,
        Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788176799; l=4922;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=yjzyhSMXBffTRGl7bXQ3k/5z64JFWQnZTOYUvVgmgmY=;
 b=FH1yiL+jyTKASTi4m61jzzdtgu/WygqyF1E8+NVszLLMzdUHTwyHwL8lDlsemXC8P3kCZGDFm
 wz3QaVjxm8NAitTGk+kGzYyx2ZD0mJAFYSA6wB3omBg9yT0odh0Ql4q
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ClientProxiedBy: MR1P264CA0093.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:3f::21) To SJ0PR03MB5469.namprd03.prod.outlook.com
 (2603:10b6:a03:28a::17)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|EA8PPFB3C90C3D5:EE_
X-MS-Office365-Filtering-Correlation-Id: 19cddeaa-e08e-4f47-e020-08df07555969
X-LD-Processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|7416014|10067099003|6133799003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
 AunR/RLfKQVNpqUFpb81vOUVWxpCBb/55g18IT0g7WmjY2F50bRXEGDLPv5b4KWtffhu6RzdNHp6Iv7+mzaC9USHt/+PY1I51S0s/XLc/WShPpzGlaFJfuzNDtIp8orIJmMlQxFKPGqddMCyCEot9rHEk76mL2hRXllZNhByed7tUZg0SuR+IT+I29dpBGWysy3auRVP9BI9uhgrO5Pi51X8697KM3jGOHjv3dJQJyiuHclCiKNjKEyCIMnj636ZRlWGVC7/woDsCrtZmGUBaplTgiMEGSfVyLQRJKtG953uvCc5Em7i+dvT2fm6B6ABE3Mm5FMNSNDRWhpS6eeBx17ktee78c7Hs9wt689vlivpBZW0sx7ArlNlMFheisrRVpY/zA8RUXYC3vJDe6iC21wicdQZ82pXcucMC0Vq9O+MkVWyI2MdLdlYi/m1Xgcx9E0UZiaBrXioePG8mhhQT0jYkQv64SN4mvzZEEtrLdckrx9GNs7NbMPlzSXPiZCtSpr8oJ2FgvvZPNKnH3N2uwAkd5Qum4FChsmUFca2kNURlIgacVw4fWFjTbyYmts7A0tpVZL2Lasf8Kj+49f28+ERA84xy/MlqttldNEdlxwHwc7ni72sH+NyDP98o+o7
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(7416014)(10067099003)(6133799003)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?NjdOTk9kYWRUeStGbXEzYUhQSU43eXgrd2R1b1BESlV1ektSR1FSQTNGUDB6?=
 =?utf-8?B?Q3pmWGh5UkdBSUpuZkRJQTR4Yk40M3lRTHZ4SThxdEtnekIzQUlGdGVOa3JC?=
 =?utf-8?B?SVY2YUJUdkpWeDEySEk2VTNJZmxXS1JMaXZxeDFyYnNITnJpVmxMaWlnVFBI?=
 =?utf-8?B?citzYTNRUStqZlJ2STZMaTRMaTJvSVpwRWphS1FPUUlwSGdDNG1Dak02bDZM?=
 =?utf-8?B?WGwvL04rZVo4UEk1SFJGdnhCeCs2eDI2SHJJRXVvVGRGTTJ1Q04vVElxL0FW?=
 =?utf-8?B?UzV3OTdrSkhIRllBZmhNUUJ4RHZQek05RzhNTWJ3SHY2WDU1U3FpY1lZZFlM?=
 =?utf-8?B?TkxxV0Z5V1U2cXZneTFTOEdpU3ZPSFppMm93OGRSam1tc1Q4ekovVzFTdDdN?=
 =?utf-8?B?UDI5bGd4Umt4OWhuWFJEOUdOQWVQK2g4MTI4OWRQQXZUa3lYL1UyTGY4SFVJ?=
 =?utf-8?B?VlE2MGpPeWJQZ25hTXZ0eVZqTnQvL0hQbGFOWHVHTXd0aVlBWDZFWVhEbVgv?=
 =?utf-8?B?WUpXNXllejFBSVk0YmQyZG12L2FWZHBWcmJNcUE4RU42OVRxRDhqSFBDVnZs?=
 =?utf-8?B?ck00cTJ3eVdZVHU0MDhIUTlXVHB3U0pzeWRRTSs2Z2VsbGZCcDNZdDM4WU03?=
 =?utf-8?B?NkZLZE9meit5Mlo5a1g3NUxjbDdNOENNQUVHTTZOeGlQOWFkSDYvVzA1N2NG?=
 =?utf-8?B?eVpEbnRpMnQ4SU1wRG8veUdKT3MyNjN1WG5zcEVLb2hIQlFmN3J4UTMyUS9a?=
 =?utf-8?B?WTBST1NFOUpJd3Z6aTRpSFpDa0RUazc4NTBzYjhLdVRRUHlDWkZILy8wWXpa?=
 =?utf-8?B?aWllQmFYNm9ING5GVkpGdUMyM1hiSWhlcGc1Sm1EakhnSWdnc2EvYXY2MDRS?=
 =?utf-8?B?SkE3M1pFUkxQZFVRUkJxa2k3V3gzblJhaFlCemlYWHFsdzlzTDk1VlBEVkQ0?=
 =?utf-8?B?cWMwZmJURnJNNHRLb09INE5SVUk0S2dBQ3RzblVaYmFPV3Z6LzlGMHcvQ3g2?=
 =?utf-8?B?cWdGMkVQbUwvOGZ4WmcvWlE4WWdrRklScm9xVVJPNUlZTWllUVFnM2IwNFpM?=
 =?utf-8?B?MmhNU01XWU44Q1k5RkVrWjRGaUJoRFlKTmJYd1FtaHRNMWxGK09wdHN1eHFD?=
 =?utf-8?B?dy9PeWY3ZENHRXhzblJpZEZDeUVFQlMwT0Zxai8zbFVRRjVCRDFidlNjMm1V?=
 =?utf-8?B?bDMxTjlZaUFFbUphejJVenNySWRqNzh1SEQ3MTJJWWIvYUxTZDB3YlV4YS9V?=
 =?utf-8?B?Vm9adlE0TFB2cE9jL3dxMThaczJzeGswVTkyQ1ovQWJQZlQvcEprVmxKTVU5?=
 =?utf-8?B?OGV0U09qU1I2YlFjMTBuUkYvVW85TjVrejFQTTlMTGVvYzgzUGRsQ2FmL09p?=
 =?utf-8?B?bTkvY25YRFBkMlFIMVdLblRaUEo1cU9qOVJ0b2o3c2VGMTZDNk9rV0RjSFBJ?=
 =?utf-8?B?R3VhWE8rS0N0MVdISHJDWlhzQUNBMTFqL255aSsveUVuU3NBaStmRG1YOUl6?=
 =?utf-8?B?OG5kVVlzQ2hHbFBpVlYzclFHQVJSVW1tQ0dQYmRPdXFlcktpMStEaVhkSFZy?=
 =?utf-8?B?YVUyTEhuMndCN002RjZ3aEFENXJIbEVUNDVGYUxCemVRY0QrNHM0a2N4VVJ6?=
 =?utf-8?B?VGxTeVJrem5ObkczWHdydmF1UTVNWjBYNnNsL0hmb3lmR1RyQWNrMU1MQ2xp?=
 =?utf-8?B?OVJneWhqNHBXWE1RUmRNNWJYSmkzendkTEtTaUNBSEkzcWVBUWpmWFEyZU9H?=
 =?utf-8?B?cjFjWkNnNmVBTVlNNHkzQVJmQndqWXNhMVpRallMMEpBTE9IVEJuY25QNmJD?=
 =?utf-8?B?am5TUDVpWlBFUVZxU240VFVqQ0FMbTRPM1Rhc2U2Nmt2aG56RS91TENobUMx?=
 =?utf-8?B?TjBVNlFqeHcxbVAzemdRa0RRcjM3TnluYzd1Wmx3S3VKWDVRUC9XQzEvR0pj?=
 =?utf-8?B?dmwrNHEyNlhQWXBYdnRObC9odHJGRWdwQ094VzlrLy8wNEpuMUk1VERPNWdG?=
 =?utf-8?B?a3pkODN6VW4weXNOOGVUWE1KaGhFRmFNSkUwbmFHNHo4ZDd4eURuQmVsdlEv?=
 =?utf-8?B?Ylh0TVhRL1E4aFE1aHNjL1RPR0dOK1pnQTFkL25DK2R6bi9jNjJYd21IenVX?=
 =?utf-8?B?aVhnZEdWck81QnA0eEUydEdVMTZpUmZCRXZYOERmMjJ4V3dwWFRXcVRqZmt5?=
 =?utf-8?B?SityV0g0Tzd2RTkrcGRjOGREaDNKMnpaZy90MCtKWElaOEdSeTZ6OVBNMWd3?=
 =?utf-8?B?SElFbjhuejU0T21MUDE0N1h2RVlLeTVBVllMNzB2SkwrSDUxQlErMXFKYnVn?=
 =?utf-8?B?V0ZlYzBhem9VMFcrNGtyRmIrWjBUNDR5UERPcnUxZ2pQRW85bE1UZz09?=
X-Exchange-RoutingPolicyChecked:
	1oKPhXZbsTWjxQlPDYzGCcKOVRsvlEsJrYHHOoN8FzecPb6kEKxnfsEnwy1WxRRajplUKjO0wlimQikZt4IO/x9DRuKk5A2OazAA6sy4f3+XEZE4hn9rVMjMU3XuC0cdvDDlsuU7IFZeua447hkJlZdOzWpwmgiKDMQl7G1AwJlgBoeQRLLaRI68KkqfXNOnGVDma5VvwABXuLfA16KhQPsNz8CoTMMQAAFWujrW7mqrKUkMGLJUtnbb18vKYsAZI6wSP0Nf4j+vALTInRRVHCSNJo8zVCRE+zt5sm3q9HBM8VeNsb0nVYYBxOZJmq5QGck1iEieNACLBHgFJkvWmA==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19cddeaa-e08e-4f47-e020-08df07555969
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 11:45:26.4635
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OtffQB07ua4FHNOF3MrwzqQhXPAzr3JrEWlRa+asadrZbN/yPNFrKPtLKDz7n32I/qAHZ1BvkBvt9F9x8jARyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: EA8PPFB3C90C3D5
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDEwMSBTYWx0ZWRfX4Xx/voBl1OEF
 70DIdJGCvKIrvbVjRUXA6LVZt8axmzjtEBH6YcFQOmDtfzSRyEm/07vaDJNkWI8P3I961NBtK9Q
 PgLjVKVDL2/jSx2Txx4n+HTLhEtW0FgyyAJJ1mX+DiJeas+STdeU
X-Authority-Analysis: v=2.4 cv=feSdDUQF c=1 sm=1 tr=0 ts=6a956958 cx=c_pps
 a=rlKp08D5gBKtwCtLUzcdEg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=N--XFCr6TIEc_64PeIT2:22
 a=VwQbUJbxAAAA:8 a=bC-a23v3AAAA:8 a=gAnH3GRIAAAA:8 a=flkV3W--dmkDsEx6GCEA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-ORIG-GUID: wYPXhrzP90KeEOv3v8PqXwYevWjDffmi
X-Proofpoint-GUID: wYPXhrzP90KeEOv3v8PqXwYevWjDffmi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDEwMSBTYWx0ZWRfXyZqPKCBV6J1M
 8i9hQnECMsAgc+bGhqhi6ynH0Jt0boPUFJzcAWYyx7Q0ILGgcL5i7MYICc4dHEQUiMyGo4XiWmd
 mWYxbvgkhCcLHwFG2NcIChmACrojU3sn9ppq3Jqy3kHXMh5Du1IkNn8VTHbm4jdi4/HZnchhIZW
 1zehCxdayq/aSpgJnzhz7tfifUzqKFaF4sPFw/RWwV0rhBuIyJNRVa5ASOltr7aobQvCV9wYX9g
 FpiBaL8ifagTTWsInd9+vkekenna+o5vHqfDdAGEi/aRSHT4aXjX05GeCYbzPZNY/IGPq3oIrow
 P0fIRe/XQdN5sOui7g/MLU6rpav/DfDiCHw2hsq5hFJVLfniWfkfsiYde3arNQknjeOkGH6tlKW
 q7ASBXSusGm0mgwyaflV0RwDxx7WLiZCq/HlGimr5UJPjIiXBZfO0UWlcNGulnjmsX4fpjmWKH5
 FWLsXv722ihBlDDPUUw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_04,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0 spamscore=0
 adultscore=0 bulkscore=0 clxscore=1011 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310101

The DMA engine slave capabilities advertise the supported source and
destination bus widths through src_addr_widths / dst_addr_widths. These
are plain u32 bitmasks where a set bit's position equals the
corresponding enum dma_slave_buswidth value, e.g.
DMA_SLAVE_BUSWIDTH_4_BYTES sets bit 4.

The consequence is that widths of 32 bytes and above cannot be
represented at all: DMA_SLAVE_BUSWIDTH_32/64/128_BYTES would need bits
32, 64 and 128, which do not fit in a u32. Hardware with wider data
paths is becoming common, so add a representation that can express these
widths while still using enum dma_slave_buswidth.

This series switches consumers and a small set of producers to the new
bus width capabilities, represented by a dma_buswidth_mask_t modeled
after dma_cap_mask_t. The legacy dma_device u32 fields are kept for now
so the remaining DMA controller drivers can be converted incrementally:
dma_async_device_register() folds a legacy-only producer's u32 into the
mask, so consumers only ever have to look at the mask.

The new interface lives in include/linux/dma/engine/{types,widthmask}.h
rather than in linux/dmaengine.h, so that only its users pay for the
linux/bitmap.h include. Every accessor takes a dma_buswidth_mask_t,
which means the interface will not change when the legacy fields are
eventually dropped.

Once the remaining producers are converted, the legacy dma_device
src/dst_addr_widths fields can be removed as a final cleanup.

This issue was discussed before here:

https://lore.kernel.org/dmaengine/abkoXXbaxaiqbBuX@vaman/

Changes in v3:
- Patch 1:
  - Move the new interface out of linux/dmaengine.h into two new headers,
    include/linux/dma/engine/types.h (enum dma_slave_buswidth and the new
    dma_buswidth_mask_t) and include/linux/dma/engine/widthmask.h (the
    accessors). Only the latter includes linux/bitmap.h and it is not
    included back into linux/dmaengine.h (Andy).
  - Replace the raw bitmap with a dma_buswidth_mask_t type modeled after
    dma_cap_mask_t, so linux/dmaengine.h does not need linux/bitmap.h for
    the struct members.
  - Every accessor now takes a dma_buswidth_mask_t instead of a
    struct dma_device / struct dma_slave_caps, so the interface stays the
    same once the legacy fields are dropped. Consequently
    dma_slave_caps_{get,copy,intersect,clear}_*_width() are gone.
  - Fold the legacy producer masks once in dma_async_device_register()
    instead of on every dma_get_slave_caps() call. On top of that, only
    when a device_caps() callback adjusted the masks, derive the legacy
    dma_slave_caps masks from them, so that a converted controller driver
    is also seen by the consumers not converted yet, while a driver still
    adjusting the legacy masks directly keeps working.
- Patch 5:
  - Also convert the driver's own read of the legacy capabilities in
    stm32_dma3_chan_prep_hw(); besides completing the conversion this
    stops BIT() from being fed an unvalidated device tree bus width.
  - Drop the stm32_dma3 prefix from the local buswidths[] array and move
    it below the struct declarations (Amelie).
- Link to v2: https://patch.msgid.link/20260810-dmaengine-support-wider-dma-masks-v2-0-1f7b798d035f@analog.com

---
Nuno Sá (9):
      dmaengine: Support bus widths of 32 bytes and above
      dmaengine: dma-axi-dmac: Use bus width capability helpers
      dmaengine: dw-axi-dmac: Use bus width capability helpers
      dmaengine: qcom: gpi: Use bus width capability helpers
      dmaengine: stm32-dma3: Use bus width capability helpers
      iio: buffer-dmaengine: Use dma_slave_caps bus width accessors
      ALSA: pcm_dmaengine: Use dma_slave_caps bus width helpers
      spi: dw: Use dma_slave_caps bus width helpers
      dmaengine: Drop legacy bus width fields from dma_slave_caps

 MAINTAINERS                                        |   1 +
 drivers/dma/dma-axi-dmac.c                         |  14 +-
 drivers/dma/dmaengine.c                            |  27 +++-
 drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c     |  38 +++--
 drivers/dma/qcom/gpi.c                             |  12 +-
 drivers/dma/stm32/stm32-dma3.c                     |  34 +++--
 drivers/iio/buffer/industrialio-buffer-dmaengine.c |  16 +-
 drivers/spi/spi-dw-dma.c                           |   8 +-
 drivers/spi/spi-dw.h                               |   3 +-
 include/linux/dma/engine/types.h                   |  41 ++++++
 include/linux/dma/engine/widthmask.h               | 164 +++++++++++++++++++++
 include/linux/dmaengine.h                          |  47 +++---
 sound/core/pcm_dmaengine.c                         |  21 ++-
 13 files changed, 342 insertions(+), 84 deletions(-)
---
base-commit: 0613e7934ee233d726af8d8c89f251a1c4df738d
change-id: 20260615-dmaengine-support-wider-dma-masks-5aac12497e27
--

Thanks!
- Nuno Sá

