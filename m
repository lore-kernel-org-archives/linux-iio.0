Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.139.77
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795772229;
	b=CyS0dKsq2sGKBrTo7mpu+jpNifwfSMk7v6ROkaXCnepLvJFZuga59VQnFIzCZLoyT9ZI
	 2bL2TXxJKGg0Up3P5kK1EWYKioA2yMDomKmx+rSJCKg+C7SvhJttR+x5hp0LcD3WCYbG4
	 gRAVWovnMxIBhl1gx24Rs4MSNcrwAf3HVAi0O7y/ONp6mWovkiatkdeynfO1+103moSnx
	 /LACdTcCGm/S62cl1RMYTrlA6/FgMrihgIN6MW2QfNLUQ6Bd7uWo9B9kI+pmy5uzrR/TA
	 vnS3hqVKijBZZQIH5NsrkuSThhAI12iG21NYcsrXKxFseIk+ahw0OnBxxVHZAA+kOng==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795772229;
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
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=0+PDl/G+CwKHGB4W6kMk0XYPspG9tDTBr4hbfZ/KntY=;
	b=B/BoEvPDdifSLmo+8USOf9PX4SyS9pjPPBckq9BRUTBn3DqWU1DNE7T5Ab7i8gBcKl4O
	 WmOpBKDAIho9sFuG52HHrx/a6tUcXaJZLiYo8En1QNExdhmHLIFXh3U279Pw9An/Eog5q
	 0+/rHXZzARj1DFmJLIgLQg8c/jrNM9QEGzPk/ZUp/kMtGG4d4ipLs0ktjOd0QCKsVzxdt
	 Uy4uBwHpbX0IiEf9dK7u0RIaAZpdDJzu0ulf0Xdl+aarWDIaKEghgKy4w81ZKP3uYA517
	 rsdASIVcfpsfR19iy/3xQT/hVptSQ91gKIME4gsBuKy022QXtict/Pr2d1eEbQcctbg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b="RpiJb/xq";
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b="Q8E/i3xE";
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.139.77
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F9E606A31C
	for <linux-iio@vger.kernel.org>; Fri, 27 Nov 2026 09:37:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 61F9E606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=RpiJb/xq;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=Q8E/i3xE
Received: from pps.filterd (m0516786.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AR7Lo5X3127450;
	Fri, 27 Nov 2026 04:36:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=0+PDl/G+CwKHGB4W6kMk0XYPspG9tDTBr4hbfZ/KntY=; b=RpiJb/x
	qDSc7JHq6yrHC4f11hIpCvAWzCdBqXDrStvxeN7t9NlloYSZT/hoehZ7K32vT6e5
	uN5uaQ86lZShvqIQJ+jnFhE1X1Ids9UAvGauxtcZ7RBbVDAoCjyoE1wVn9WpsiSy
	IR6K5YBneB+3iCupozGhz6cTwCFG5p9EV3NwD0JmScMfZ2Ee6hZHhlojzaijQLrX
	DMBV6FaKkTNmQBQwYgmowgkP1t58MJbqAl/BqmcTG8xiZLc3/v5nQzXMBedsfWQD
	axmXcV6/E/jTeTWJuZAlhxu1FGfouoC4nEITG/gDcwRLkp3Vk4YAgCHjaYGp3POy
	sSYC3R/U1wlB2Cg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=0+PDl
	/G+CwKHGB4W6kMk0XYPspG9tDTBr4hbfZ/KntY=; b=Q8E/i3xEPoj5tfXXCgGVZ
	KX7zl7fSBNXHEeashB9p8qj0iCVf2BeGJi/7GjhyHMKxYsdLYP/5hyVWWId4bMSK
	YjlgAeW8oBA9YH7uyzjMD1r4cv7yoD+y7fMwJC7ilM6fv6wa9OJkAuZ/rZnTiBQ3
	T9fzz9hLXnOC3UgF8EISOJ/ilgP/dgN/wg9cds5oUsvGPKyLAGecUrqmybf6rzZQ
	S2+e0miTstEONwYH0lqcqOwg0BSKwRYiYoRNL/8vawEyHZtfVVKVeZGiQvLh0XQe
	9N/b6PEOsLTVUV20P5FoMTWPaW6+tAmi0qxXpuLcZ84pAD4+wL2Qq/HKm+YRdu9s
	Q==
Received: from bn8pr05cu002.outbound.protection.outlook.com (mail-eastus2azon11011062.outbound.protection.outlook.com [52.101.57.62])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4j6xbpt6g7-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 27 Nov 2026 04:36:58 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ezuG0L5gOwRJIlK1WEg2nwH1pBmHLa4sQeiXfLWRj6Gho9A1yCx2ZgEhWCIbhxo788BEYPIkaC3fBjWIInnudllbIoxZ/kybUydm3lbECfvQHKUvtoMyq2v+UKiCRMyp75LGA1+OZ+EypuNCD9C0MwOjZR7m75H15kaWZn7BSdqdA130yheDagQ68vZcTYFDmTwRelIR+fHM5c9b8346iGDXpQEXw34JNGpEL5vGB6xvMKvw/dL07UN8AsI3Ep4F2/xV+DQ1964Ow7v9K8f31FHzjuILvTykwaFmr5010lOe9qgtQqSDaCr6+ZbVs/+uw0J8uytwTaU0b5+BnYY1mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0+PDl/G+CwKHGB4W6kMk0XYPspG9tDTBr4hbfZ/KntY=;
 b=KmvvdJjMtuIIZeQUi4vnge7y6cQnYQRIlrK/0I8GuwhdAo5Mw0mLAAZiI9EBbesOAJIZF9HZ6TZDZx2NHHHBfmYuInFkmwIP1WkoY+NQyO8ZvsJQS9NngsAfCSB8n2k5DBGl/QRHlFtK6XKJsP4VTqbyTKSXPzlzAXoucQihkJ9C8GlTrGwwrzvV/W9MezUWBkMb6PJRrNwz0kNnSSSO9VoM0Ryk3WbIqn93PrBFzzHMCMSzbb5QgImiXCBdz68EJeX30mbq5PUfMln9T10oPOLZcc2rCxfnk18s7ih9jDP1BOcPt5P15vLQ0Pwg7UqE2A4Kp29FahhO1UsmjcEBSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by LV5PR03MB8433.namprd03.prod.outlook.com (2603:10b6:408:361::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.7; Fri, 27 Nov
 2026 09:36:56 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%5]) with mapi id 15.21.0662.004; Fri, 27 Nov 2026
 09:36:56 +0000
Date: Fri, 27 Nov 2026 09:36:52 +0000
From: Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
        linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v1 1/1] iio: core: Use an API instead of relying on a
 specific error code
Message-ID: <awlPJU524BnRWbDU@nsa>
References: <20261124103842.600399-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261124103842.600399-1-andriy.shevchenko@linux.intel.com>
X-ClientProxiedBy: MR1P264CA0034.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:2f::21) To SJ0PR03MB5469.namprd03.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|LV5PR03MB8433:EE_
X-MS-Office365-Filtering-Correlation-Id: 0832cd63-1d7a-4953-7512-08df4c69fa6b
X-LD-Processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|261009223027099003|18002099003|22082099003|10067099003|56012099006|261022075727099003|11063799006|261026121527099003|261102130727099003|261102123227099003|261021121427099003|261021123027099003;
X-Microsoft-Antispam-Message-Info:
 Awwkyza74wDIwigsLEqQx917CwrcOafVZRJCWAYBfFTTYEu4eeCg19skWE+5Bd3Hd+r2FphVzjeycsfSfHg6TMkhPIvChQwmtSEGzdZlr3pPj9zCL4V89mlyKxq7qGBuYzL1pkrf4vwMm0EKoSuMV225p/XA6ees9pbDRF9MlC10wpW/HEEzQUp13T74Gn4brPEGfkzy3Y4w+9AyOjEfMxPNm9TB5K9/n05yGcq/Dzcm5z82a2H4EpLeKO23gDs8QsJX4GbnQj02JN811DwSWPOmBgwo444rcMJYPv1CParv6N9mwnAppNMeVPZFOrBEkPGTKqwRl+uEsAciYFpCpkUYbRabgkwidFjKPssyJ4CJ0rc7brPKWs6a9J8CFjcFkLVKIjCfMRUgrFWtUlF6nTp1RGZtZYATwftggg/pSLKra0NPFjx9V08pe4ii1r0opctdcb6RuSsIVGkg3fqy9066TU614zBtMDO9nrG6/F48Fvldatm5O40VGy6Vc0tY/rTYA6Ez7oLMWXUPASfVSS5diVCU0mU0X00kOzj9NmO4gQbi0eVf9K9siXeVDQs6rnV/6KRwXtkjz9xgX5OF57hNJSbAhI+Ku3Bt7uEF3lkq9QFpTwN7V8c9ubKGW3mp+cONApdP48LjBx75xNt1/UHcnGLL9eQmL+wSN/jaI5g=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(261009223027099003)(18002099003)(22082099003)(10067099003)(56012099006)(261022075727099003)(11063799006)(261026121527099003)(261102130727099003)(261102123227099003)(261021121427099003)(261021123027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?YVJ6MjU1Y3NUYitLTEpCbGc0cnNDRjBCNVM3SUh0TS96clJzaWJYRWxJeEVy?=
 =?utf-8?B?TDVZS25CNk90RUxUbmJHMkV1WWN5YTYvc3V2U1R2MGxFdzV6VFY1YUNQNVRS?=
 =?utf-8?B?Uzh2YlNJMW9MdUxyZzRZWkNtZ1hxVzR4RFo4eklFeXkyUTkyL0VYSFhlSEhF?=
 =?utf-8?B?Wk40TzNLZzJlV1NVT2pqMkR3dTFaeVluZU1BZ0hZcEU1R2hYK2c1YmpYSVRn?=
 =?utf-8?B?TUs0eUVZbklGZ1lqZktnQ0YrTW44dkZDZ1RQcTNpYlU0alJHQ3V6N0NyT0sr?=
 =?utf-8?B?VzVVcUxDV25NUURJQVVNa0hYQlhlcVZwSEtFWkJuYXFRc2RzYjdJWmZ2WFdo?=
 =?utf-8?B?dlBKSmhyVkhzMC95MGlIaHdUekpvOXpzR2UxN0xhN29JWUFpcGdhN0NOWktN?=
 =?utf-8?B?QXplVlBMUE5nYUt2eE5FTFA2c2hnNENCam1QejdlVktYRnlaZ21tZ0U0dGd4?=
 =?utf-8?B?bVh3bVlNOWgxTmdmZU9qcFliR2Y0U3lkUXEwbHVCTmlzSG1EeFQ0aDEzbWQr?=
 =?utf-8?B?c0FmeWpiMFlqUlk1azFBSGpRdGdEalpoNUVDRmNoL3VtNHRaZ05tbjl5Wi9K?=
 =?utf-8?B?S3lFY1hnM1FGMVBQNkVUNHdHdWs1bU1BRnZxMXQ4MFFOK3VMVWV5SnZZVzJO?=
 =?utf-8?B?TWUrY0wzUzdBNndTaGNobWJFa3NKYnhJeGFqeE16VFpRQ05NSFZaYUlRUWNF?=
 =?utf-8?B?dy80YnZMVTkvSlI4K28vNE85dldRcVhudUNyeVZ1TzNyMWNKdk14b0pueFlV?=
 =?utf-8?B?VDk3N0JqeUxOSU8yNk8yV1BtWHZxMjU1dFFRMnh3Wm1xazBabm9BY1NMb1VY?=
 =?utf-8?B?djdlRGVOYlU2TTl0WCt2QVA2LzRMNXR0a0ZrQ0szdVZBdzkyKzB3YXIvZG41?=
 =?utf-8?B?aC90K0pVeTlUcGNrbmFsVmdXSUQ4VGpzR1NORjBXYzBsOGREZzZkenVBWVNJ?=
 =?utf-8?B?NVhlUHVlMTM2bmNnV24rOFNoWkNudDRkb2x6SDdYVEZLbllZQStNUkwrdEVV?=
 =?utf-8?B?eTRNV1dhUm9kZW9VS3FvRGlXZmgyREFlUjVKZVZBcVF2bmNoUmlacXJwQ2ND?=
 =?utf-8?B?NmxlZ2s4aEZtMDZIVjJOUXlsSUJvK25lcXRjbHZMaE42UmdCRS9lZm1yNHBX?=
 =?utf-8?B?Nkk0Z1RBR1Y2MmlIdFpSdUZBNXJwWGw2Vy9ZanVyY05EV1oxNmFMUVR0TkJN?=
 =?utf-8?B?TjFkdXNMR2JUdUNJb3J0cHk1SFk3dytCb012Y1YrOW0xQzd6NVRrREVyRGxu?=
 =?utf-8?B?LzdoRTNsUlMvT2lyOXpoTGVjR05xY0Q5UzhmL3Uydjg2MWJKMDByT1BsZEJa?=
 =?utf-8?B?UUZnU2F2WGZDRWVDVS9WcExIN2c0RG9FZmdwK3ovRndMZ2hOVjhMb3BGbTZW?=
 =?utf-8?B?Wm54TGt0SDE2ZEdYY0czL2ltZEJ4eXV0R28rQWYvemt0TmN0ejQra1YrcTc0?=
 =?utf-8?B?VlV1a2hOSzBIN1hyNUNMajhjR0lwa1BLK3BuRU1ieHRkSXJSZTZoSnJRblJp?=
 =?utf-8?B?ZzI4dWpyTG5Pc25DUEQ2TEplVGk3empicGhDVlZmQjNDeFRXOTdQL1MvNzI2?=
 =?utf-8?B?UExkNjRQci9BcWtDeTZtOCtIT3NXVHdSOS85c1laYVJLaGM4YUpJMzEvcEZs?=
 =?utf-8?B?UlM0K3QzQUJ4TlZSK21MVjUrVm1nekdiK0ZHWHJvSFJhSVFza1JMeTFtV3gw?=
 =?utf-8?B?b2t3Um5CRXh6RWN1dis5VTFRNmtNZExRdXA1Zi8wYjJlRkM4emNNTXlwNTZn?=
 =?utf-8?B?TlRESzFDZEl3a3VuMzVYRUwwTFJsaUVMUWVVQXAxN0NuL1llWlk1aGx6ejl0?=
 =?utf-8?B?QU1SLy9pTVAwWEtaZG41YVFWaVdZTFRWYmxIOUFLaUpDbldoTXFtNldtRWMv?=
 =?utf-8?B?RW9rWnNzK3dwSjJ1SnFPelVkdkRoQWx1NU9Eekt2OWZhaXBWdWROWERpc0lP?=
 =?utf-8?B?MWlEb0k4ck9xTTVvTmM1UzJieUtVd2N4eEU2Sm9FSGF1VE9OTmdXQ09yaFpa?=
 =?utf-8?B?cGZHZ0dVL3RJNVI1NlU4YVVnYXZta2JzVVFmM3BEdzdKb0RSNmlheTRFTU92?=
 =?utf-8?B?YkRReUN2VWxkMUNKR0ZKZ1VUeGJTS0l3SU9XMDN5a2drRGhuVTd6NVNvM0s1?=
 =?utf-8?B?Y2Rra1YxYUNXWE04b0prbzFXTW9Wa1V4WFc0a25LYlhzbUdML3FCZUUrUEw4?=
 =?utf-8?B?T0NqeHd6ZERKQ0l1MkhTOVZ6c3FZM05nTmV3UkFDMEhxL1JGeUpvQmhwbnJo?=
 =?utf-8?B?cEUrTEFTc2gvWUYxOW1wRVRnclRDYXU0Q0RVWFo2N0tXU29uK1FnRXJWWlJF?=
 =?utf-8?B?VXZUb092UlFsYVNPQW5rMUczNkE4WTQ1OXlGSmVkU00yZURxd0J3dz09?=
X-Exchange-RoutingPolicyChecked:
	F97Ui370Ugvs4AU8CnABvSgIPumAyB8X1/WDCVB351F4Hq21s7w8e01jNho/dNINFKZ32u/W1z1vwthW0yc8shLjU1foYr7dpCWFMh5CrUE9TG4V+xpi6i1K5DEHspJoBWB98OdasLtrh980U6gAkt+2Jm9r6oWltegCpldLs+OKOkKrG2DKaZd2jk1+LC11igAmtaKlQfDZNsK2ddHmRgJbZcVL1tKLxfsFrJupz9sjjzvIinc0GC74lJvzyWfgxrISGzjejJWa7r2fDgkermFwZrO3P4xmFbUjr10Zf088O0sieGdbKP2VUpYJVMFvdipzoV4RbN10/Y/hvUwLtA==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0832cd63-1d7a-4953-7512-08df4c69fa6b
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 09:36:56.8099
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eSijJCl04mXcxiyITv1WmIFQ5vS/LaukeOkUUDfJ8FVuE27gtZJwt9BPcHu6jJ2Fba88xBGp7HOlGgM7At9qLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR03MB8433
X-Authority-Analysis: v=2.4 cv=NZ1zRGD4 c=1 sm=1 tr=0 ts=6b094f3a cx=c_pps
 a=YV/sJQ11QjtKmCmeYosiFQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=_tY7G28Eir0w4imU:21 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=M51BFTxLslgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=ZQxX5BWu6Z8IJBb2zLX7:22 a=QyXUC8HyAAAA:8 a=gAnH3GRIAAAA:8
 a=Nw0fjjxLB2wjriRmcgwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDAzOCBTYWx0ZWRfXzCXY6QQm3Skb
 lMk6esVKwS7wbr4qeuMxYQngh8TgP7BS1jd2HL3+llGcSVimx86qsYqk8ZTLiH6BP6ROJC4W23d
 MtwX3HtChzh3e2w99hflR3TD8PzozjZfG60RH3EbA7K/GL7RbJoeO1QOdNEaw/k0fGQBOWJnPQA
 /FJIf/bXIO5NtV0AVo09ux41ZEG+db8qK4Fcjot7zqWms4+s9WzvSNauVSJXzKe0iwoj2phVUh/
 TsosRtRJojTVY6bCoDUeyL+tilWRskOE4ifu617G2Jg4DAn3B8ZEXPHK5KHquIS1+AbLOjDAbHr
 L/vi5bnhP9dQyw5AbetlFtK2SSKeLJvNKs/1Sgx43ppURzlQAfF+g5m9J2VEX4qwPlnfzMaPEjC
 5Ww49amgy333fTBTfj/Cn0bYxptVzemmnzzQj/ueebaAUbCXeMWNmCRez31vM1BkKhrdbWImhRZ
 FiEhXIYNCJ+tgbcW5Mg==
X-Proofpoint-ORIG-GUID: 3wIrS-CwTGdW8rK3bm4BdW_bipNKE-Rj
X-Proofpoint-GUID: 3wIrS-CwTGdW8rK3bm4BdW_bipNKE-Rj
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDAzOCBTYWx0ZWRfX0cHIA/mvuH6+
 bJzqyxe1v1lGGiThPtgaF5q38IO8Vkek/VlpcyPraIvQUILpgpEcZsEfCcDbpD5k6gJnW64UPAm
 CXkSZ8NtfommZ+Eyg+huPx03Ww67fi/an6QOzSl5464gvLkd6dfB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-27_01,2026-11-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 bulkscore=0 malwarescore=0 spamscore=0
 priorityscore=1501 adultscore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611270038

On Tue, Nov 24, 2026 at 11:38:41AM +0100, Andy Shevchenko wrote:
> Use device_property_present() instead of relying on a specific error code
> when parsing mount matrix to reliably detect absence of a property.
> 
> No functional changes intended.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---

Reviewed-by: Nuno Sá <nuno.sa@analog.com>

>  drivers/iio/industrialio-core.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index 3b66d7b765d5..5f9d6e852286 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -567,6 +567,10 @@ int iio_read_mount_matrix(struct device *dev, struct iio_mount_matrix *matrix)
>  	size_t len = ARRAY_SIZE(iio_mount_idmatrix.rotation);
>  	int err;
>  
> +	if (!device_property_present(dev, "mount-matrix"))
> +		/* Matrix was not declared at all: fallback to identity. */
> +		return iio_setup_mount_idmatrix(dev, matrix);
> +
>  	err = device_property_read_string_array(dev, "mount-matrix", matrix->rotation, len);
>  	if (err == len)
>  		return 0;
> @@ -575,12 +579,8 @@ int iio_read_mount_matrix(struct device *dev, struct iio_mount_matrix *matrix)
>  		/* Invalid number of matrix entries. */
>  		return -EINVAL;
>  
> -	if (err != -EINVAL)
> -		/* Invalid matrix declaration format. */
> -		return err;
> -
> -	/* Matrix was not declared at all: fallback to identity. */
> -	return iio_setup_mount_idmatrix(dev, matrix);
> +	/* Invalid matrix declaration format. */
> +	return err;
>  }
>  EXPORT_SYMBOL(iio_read_mount_matrix);
>  
> -- 
> 2.50.1
> 
