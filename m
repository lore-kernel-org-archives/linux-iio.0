Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B230223185D;
	Sat, 31 Jan 2026 19:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769887734; cv=fail; b=EibGxo9+0KZ6Qf96xOa8SCBw8jrZq3+dz38EryYM8tsTX61hf1mx8pmh7IJ8XuHrjGWWQL6mxlXIa+A+NDaUF9+OjPJoIbAYgdrmYFsIhvcbQy/r70LuEtWHT20fCB0evU5taoeBG3PCTUmdCte6SgCNm4ATTvD6FufTc4nl+gU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769887734; c=relaxed/simple;
	bh=WrsvLlq2S90kSWpteAhk7Wd31HOqyofMtHAbNTeDehM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lZzFpzuRl610J+0WN2RFYAJMgaLYSQmEWuLmNn3VivyvJESd1n5WaD0esnJtVBL53N/P5NkH7RQ+qZrm58vF0LzW+HtqgT35l2bjp1aHoyEgPB/PR+cqWZ9LjVq7j7/tCtcUR9I7T/Xsxftz4DkvISk+j2FKz6hUr2l3RBJYxyk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=o4dfvqHe; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=fxlvkr8h; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="o4dfvqHe";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="fxlvkr8h"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60VJRMu41541944;
	Sat, 31 Jan 2026 19:28:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=qDXKG0ZpSjkOPt5/Ql8WQAywg1jNmsUh7pL78TJbf28=; b=
	o4dfvqHeDy6rU8eofVxWSJA7hOXugrZ7LjNmKtA+Jj1U5HWNffO+OHuUOwzWqlqO
	d/GCNrneJfQC2A3ghTn3OPN7okEpd2SVAdSlIdbCG6d+z4wJ2CLFVF0NDCppvQ5C
	P7M+WxF44OX8QqxaZsGSEejp5i4fw0rSJ8zbWgNHQtW878BGrqt+kkYBYJi0I4xO
	YTLbp42AQR2G4rMwoQ74aeRhcr2qOHQzJSIrtpiPksyoKwEjXDaFLZsDA2VQPFvG
	pOw668b4AbtBheiKr4/L0fAhWQ5I59nAhkMlj7HrgPrjQu7p6gNgANYii4RiPEZ/
	KmoBtASzC31UpYl2OhQLbQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4c1arkrbas-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 31 Jan 2026 19:28:46 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60VJCghG026351;
	Sat, 31 Jan 2026 19:28:45 GMT
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010044.outbound.protection.outlook.com [40.93.198.44])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4c1866yv7t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 31 Jan 2026 19:28:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZfMe4GnR009lLBy+UPJFsucv5rJDsmgBxxDu5bpcSBmH1hsW9sloqwmHYNiN2IsP3jBIZyTAqXzvlRAjExuuJcau3uqFj5TeBA5vf0qD5Wk5F9e7YhwQUlMp8UdFFv73WSRVu4dfR4fvp9ajP1L+wgHYwZIEKtDfuy5waC/1rBpqB7o6fdVU5oIwCRA/nn40g33EmVb++kRGWyl59v/mWTdQF648TF4WN09lACn5aJLw2OisclDJaQh3n3fOVQymAsKqXMXKo1eTLCw+0nkoU+vnxAyVB/N589OEn4W1PcRyFpQBad0ENJfjA4Bf7jFaplqVzp0+XOMcH6Kb2Uv/Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qDXKG0ZpSjkOPt5/Ql8WQAywg1jNmsUh7pL78TJbf28=;
 b=IfIo8tvNPlhGl16TrqCGDjegY98u0bVtgtX2oB5vU6NMYHCsVZ1vLWSVrdSYX5A1ssXpPHu8UJvtSW+taxUBDBGxz3Y+4ghn53sZaZIl3KDgQ0JvD60VLE/el3VtQdx27v75AbhFUZba8AwKzGMASGACcBIlejjvzleIAgrnhmotbCBBFUt//S2zIuMccSTE/motuCEoVDFnUAV5CNhtuSMi+88RO4NDgg/dmgmh+Js9B0ZlNHksjjShei0RSPM/sBgcwdhHOP3ufhXH7L1Y9BDqlQ6ypXuuETXb+MEIP7ofSqPRHF9+hXr+rFGGvv2Pa+BcIz313qT3SP8V8mf8HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qDXKG0ZpSjkOPt5/Ql8WQAywg1jNmsUh7pL78TJbf28=;
 b=fxlvkr8hp6HMQwk24FH2VIA3PnxyO6twY+CHOiyF1z+mXloq51q7PdQM3iEszgyrf3mWsyJHW5o8h4ATocaknb9FVx0k3+sGfjz5n5upk887eaalH1I3VcH7/iJtC02HHCFlWAnoQxLGmOH06Fu+FWdTsVKR0l00wHcl5c3nlkk=
Received: from DS3PR10MB997700.namprd10.prod.outlook.com (2603:10b6:8:347::19)
 by DM6PR10MB4220.namprd10.prod.outlook.com (2603:10b6:5:221::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.14; Sat, 31 Jan
 2026 19:28:41 +0000
Received: from DS3PR10MB997700.namprd10.prod.outlook.com
 ([fe80::4c1c:3bb:c4c9:8e7a]) by DS3PR10MB997700.namprd10.prod.outlook.com
 ([fe80::4c1c:3bb:c4c9:8e7a%6]) with mapi id 15.20.9564.014; Sat, 31 Jan 2026
 19:28:41 +0000
Message-ID: <b2abb2bb-d972-4ac9-9237-26f44c597170@oracle.com>
Date: Sun, 1 Feb 2026 00:58:34 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH next 2/4] iio: sca3000: switch IRQ handling to devm
 helpers
To: David Lechner <dlechner@baylibre.com>,
        Jonathan Cameron
 <jic23@kernel.org>,
        =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>,
        Andrew Ijano <andrew.ijano@gmail.com>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Cc: kernel-janitors@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@intel.com>
References: <20260130214323.236389-1-harshit.m.mogalapalli@oracle.com>
 <20260130214323.236389-3-harshit.m.mogalapalli@oracle.com>
 <298d1c61-e6c9-4aa8-8f94-82f218ac37b5@baylibre.com>
Content-Language: en-US
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <298d1c61-e6c9-4aa8-8f94-82f218ac37b5@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0028.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:151::15) To DS3PR10MB997700.namprd10.prod.outlook.com
 (2603:10b6:8:347::19)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PR10MB997700:EE_|DM6PR10MB4220:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e67c631-0bb0-486d-02b1-08de60fef101
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YXFWak9oNmIvRloyVUZDN2NXWnpDR3hnTU9TZzZwRmhsZktZQ3luYmw0ZkJw?=
 =?utf-8?B?aWZTSEJHY2R5dTlvQlFoM3NSN1EyNWMwNnp0WU5yYlg2ZzIzUExNT3JHSVRu?=
 =?utf-8?B?QmJDcUczZHJreTRZbHFwbGFOaTZKWnEvMFJ0aEN3RUpVK3ZuTjFyZGI5dkky?=
 =?utf-8?B?UXpUUVJXZUIzc3VpczRPbW54YStLaVpXZUZ0Q3VJSEJleTRCdWZBSVpaWnIy?=
 =?utf-8?B?SUVZMHcwQmY5ampiTk43TWlIV3ZZZGtMbTcwd09sczdxMmU1dFNwcENGM09T?=
 =?utf-8?B?WFd5NVhOa3pwS0dEZmRJSXlBV0tPelE5NEFGTU8yUlNocVlYeGRoWEVnREFJ?=
 =?utf-8?B?WkZaenUxNU5GYjFTcjk5L2ltQ3RtaG5uNW1MbXROYW5YU3FDNzBEOUNRZGpy?=
 =?utf-8?B?RWVGWlVERk1iRks5eExZazR1MU0yTlhLMUlTalViSEphaW5yaDM5bGxwTVht?=
 =?utf-8?B?VXQyeTVOS1RjM2JnbFBIenBrRmIvc1o2L0o5WG1CVjdqbFRidzQ4RGRHMlpN?=
 =?utf-8?B?TFR2dlByMzRxUmgwN1Qyd0U1WEUvcDFNYTJ0RjdRb1RFdFd1MkI1a1MwT2pu?=
 =?utf-8?B?YytscENEQzhjd1pSK083RDFXZ1grZG9ucG96enFxU3E2VWpCWHZTTTB6ODY1?=
 =?utf-8?B?OU13NUQ3ZFVUQ0ZiVTkxSXU1QnNVNnoxNStGQVVNbWVPOFowZ0hobnUxL1di?=
 =?utf-8?B?YldKY1BvbjdGRTlIY0ZSVWJVRDkzTExJRCtkdlAxaVRYSjZVWkxtYTA3ZVZ4?=
 =?utf-8?B?ZGl6dzNaZkk2VGE0dFV0YXJDdFgyalhHWnp1YlJsMFFjL2djdjg0WDNFV3Ix?=
 =?utf-8?B?ODRDd21JSDBSWjh0LzA2cGd3R3YxSkgxU3BnVWJPZUovZ3c5Z2pZZ2VhOXJt?=
 =?utf-8?B?VVR1bU0rdVZMbkllbXJVbTdDZHJMbmU3MUc3RDNuYW5INzFuRFhMdmU1SFZX?=
 =?utf-8?B?SmRCMjF6b3BERXN4cm9QQ2ljZWJJaVBVQTBteHB4cXpUQkNFZGpnYjg0T2l5?=
 =?utf-8?B?SjlLK3k0eDNiRlgwa0o0V1JnSXhTT2NySnVpVnd2SWlkMWc4YmtzUnpiRHh1?=
 =?utf-8?B?SXkyVWdkbkV1TmRLN09wMHdGWHFBNlVKdkwyRG5kVWlOcWJVeGlSeWlDd1FM?=
 =?utf-8?B?ZW5wOEdxR2JyN045eFdjcFVNS2xaOXJlR20xNlExbzgyOGQvRkdhOXdNMk5M?=
 =?utf-8?B?NW1MRkQ5U3hoVnJuaHBlY0lnMTk0azhkY0FrSkJhUVpjaEV1aU9ETDQwVjg0?=
 =?utf-8?B?S3gyYTM0MHRGa3QvbzQyRHJrVm92dldCRlZnRHAxLzlhSWZjeFJubEkvbHkv?=
 =?utf-8?B?TGRZUjJPMlI2TE1SSEtpWndmeEpMQ2VqS3JscitCQXJ3N3phbUc0bS9nQWNS?=
 =?utf-8?B?T1ZDTmlTbDM1eGNLV2c2UEhtbkhTWm1Lcy9pQWcvdHZ4Y1MyL2hjeEpQdDBm?=
 =?utf-8?B?cW9pcGpXMDlvSDNwOTEwUDgvUVFhYWR6VGZlU0xNa0ozT2VzVnkwZmx2Rm9J?=
 =?utf-8?B?UVp0bkU4Z3pIdU9wcUlwTUFXS2k5dDY5MFBHcVdzSTh0SC9BSTB6L0UzdUUx?=
 =?utf-8?B?Mzk1ZW9mQnBybEhvNWZiUHkvNmk2Z1pYYW1HL3IvWHNmOXlsU1RWVERqZUhN?=
 =?utf-8?B?bjlnR2VNMm02NkVsN1lSQUdWdGJVNHJuL05JZTBXdUN3QjRpSmJMLzYybDJv?=
 =?utf-8?B?amJqRURzbHlLOGJjdldoemV3YlAvOHNqSHFYWE5EZ2piZjZtSDVhU2dudXFa?=
 =?utf-8?B?QThQK1V5ekwxOEgrcXZnOXUwcVZuZS90ZCtoT1J4RDZBTXVNWTBJZVlabG1y?=
 =?utf-8?B?TEpzTmZwRWh3eCtheWxJZ1BlZHowKzBkTElFVEQ1RVpEQ3dTcVBNSFU2T0h5?=
 =?utf-8?B?Vi8wamswbUJ1LzJIaGJuQ3VBUnl3ZXJKb1lXRC9Zdi9ZUFh4b1pPNnAyR3pH?=
 =?utf-8?B?bUZ3dmtEWm8xV3FWSllJbG9CeVR0Qk53bkVrY3o4QTFWcUZ0Lzdac0ZRM1No?=
 =?utf-8?B?WklEdU42UHZVRXUzQXQyZTZyQURiL3Q1MmNUYks3ckM4di9aZmQyckRBY0RQ?=
 =?utf-8?B?dDY3RTlWVG1QckZqKzFrcnRiYWlZNDkycVEvaXRJK3gwOGNLV2o0RXUvTExZ?=
 =?utf-8?Q?UIws=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS3PR10MB997700.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TFpVOUFDQjdHWDd0eXVBQnZDL2dQUk5UMGlhWm10aldHdkZ0YVdxcXpyL2Rl?=
 =?utf-8?B?dFdVdGsxWkQ2T3QwYloyNm14M3ljdnY5UWRSRSt4Q0hwL3N1ejNWME4rMVB4?=
 =?utf-8?B?YWdWVU1VUVFKVmR0QjZuWFRhQzFQMWhjekp0MHoyRnoyOTN4UUxFQlYvdnFk?=
 =?utf-8?B?M3R5SDhRbVkwT1VEYlJVSU1RS3F5eFg5cXkvZGhxaUJOaGtuYUo3aE9rM1F6?=
 =?utf-8?B?OGdGaEN1NkYzUWxZanRHcVVRQWJlVW1TM05DZFJhU0tNMHMzYnRIY0d0NU5i?=
 =?utf-8?B?YkFzSmpuK2REbzUxMzhadSs1ekJuSzkya1A5Z1BFQkVaMXM1NEVOV2dsL3B1?=
 =?utf-8?B?ZHdKTVZ6Q2toK3hxbUpoMjZwV3JTaDBQOXBYa0RpbU9JQTJ3RU04eE5zeGF2?=
 =?utf-8?B?K2lZWC9JZXl2dEh5aENYQzdaKzQ5SEU5dUplNE5vaG5qL2VmMjZzNlg5bjN3?=
 =?utf-8?B?WDN1bEVTQ1lKVFM4NVN4T0d2SlovRUJRQzJuQ2dVdmdRdnF1MFIzU3RnQk1G?=
 =?utf-8?B?L1BzRUpEUVRJZVFXcUptdmZGOVhWcDRXNmVpQ29Wd2lURjB6Z1N6L3pIR1JK?=
 =?utf-8?B?Uld6Z3pvQlJzYzRjbDVBNzJnSTRHdzFrNituUnJwSHExR0Y5VStxMnJkZ0x5?=
 =?utf-8?B?VDBjbERNUFRnVFB0Nm90aHFLUjduSXVxclFsT3ZuV0pCUDk2M3hnTGVUeDFp?=
 =?utf-8?B?Z1VpK1oyWk5ScDZjRG5FZXBGQTNHNTdEQTFLZ0xic3JzNkZaczdvTE1hSUtD?=
 =?utf-8?B?K09YbzJIdUtQZUc1eTJmOGxLR0dhSkpaZk9yZ05PSGJ2dFExVWV3RVF2QURv?=
 =?utf-8?B?QlgzYk5EWGxFUlVVWWU5b0xHcVQ4dGYyLzJBOFU1Yjllb29YNXVzeENJVkt2?=
 =?utf-8?B?anhmME5yOVFMVlN5aXJyNmxQMUFTaTBFRy9nMDlRUEl4alFxWmVVSGpTTG9H?=
 =?utf-8?B?bmdhTTFKc3JKOExIbXUveUxCbGlLUlN1Q2pLalI2enduU1lkbVoya21PV1FT?=
 =?utf-8?B?ZGNzZ1V2SlREdjRtb1pjQWd1SEszazJuRFB4WS93bHRmQ3A4QTkvUTNyV3pW?=
 =?utf-8?B?S0ZhbllCbTFPaVJCbTZPdVdsZWFKeWRURzRseHUvYUYrYTQ2d2Y0RVM3NE80?=
 =?utf-8?B?eXhEN1BoMFpRb014bHV0eXBSYkE1c0hqTlF4a0tEMkgya2JCVGZTczVtbE9K?=
 =?utf-8?B?RDVnUDU0N2IzNGIzb2xvcmJXZDZLWFUxUW1VRFdpRFJKOTBOSXJEVEp5azk3?=
 =?utf-8?B?S3VwL0djbTZqOVV2UnlRQVBqNVB4S0dNMnRtbWVBbFhlQnBvMGwwNmJVYklH?=
 =?utf-8?B?SHA4VXNaRnQrVDNEam5qaWRpbTgrKzljdEJOMWFBL29xSzJIWjlpd2xJUWZ6?=
 =?utf-8?B?VU9DWWdpTnZoaWphOTFkYXg0R1AycEZYSEJIbnVuZndodmhTUVdQN3A4dFh0?=
 =?utf-8?B?VFpKL2ZxVG8waGgyYStZRjAyemVsV25FZEQ2eXlkaC9FUkNBaUJSQ01UN2lF?=
 =?utf-8?B?eEoxbmtSNm5paHNmY2Y5Zy9MYU5WdXg0VlFzRFZRSWo4cUlTbktGaVcrWmlC?=
 =?utf-8?B?eU9nTnNhdUJGY21iWnhMcExYemFzNm90Wi9SajhzTllZc3RvUDVPYm53cFBq?=
 =?utf-8?B?V2hmL0RBS3IyVjU1UGJrenpNWjlyNmVOMHAwbnVSeGd0RWhlNk10dUUxeU9y?=
 =?utf-8?B?ZytIYldFMmtYdjdjZStKU2hUSDJhUzdtK2RteG51bUtHQlBKRUsxUE80ejJV?=
 =?utf-8?B?U0kxQWRMRkZFNDA1V3BDbEZVR2E2cERlODFQQzRqa0RmcE10RkwvR3E4aVRo?=
 =?utf-8?B?UVdsQzVFL3k0Q3BLdUtTVDRUNW1JUnh6MzFZWVE1a3ByZ2xXQktKOWNDaUJt?=
 =?utf-8?B?R1VUR2dWRHVveXBqL25nSk9ZQ3J1dVN2MDliZHZNd3J1cytjcWFNYnpkckR4?=
 =?utf-8?B?MitVNnpON2NhcWhOSnN2Q3BrY09odllwZUk5b2JBNTRMQ0FhcjNKVXBhejNQ?=
 =?utf-8?B?eWlDc2x6cVpoSjRpWm9JNmRlRCtoTURGd1g2bVliT0s3MXpIbDhOOGtsT29p?=
 =?utf-8?B?ZUxMSWtPU1EwQVFtYk1XYWMya1RRVnN0aSt0UXFLUzV5SDBaU1BRWEZNcFZ1?=
 =?utf-8?B?VzNTNlJWOTk2NXY0d3JpdWlaNDZHRnkzNWV0SFdMaUlvQ21oSTU2NTM4OFcw?=
 =?utf-8?B?NnJjTE4xRXh2eGlHb1VpSzQyRTFDMWVYbFA3TERpb3U5aDcyVjZ0MTU2MjZj?=
 =?utf-8?B?N0dRNjRXYUZuaWZlYWJTaCtjTVpKV0t1NDhBSmkwTFBBM0Rqd3h6UnhXN0ZN?=
 =?utf-8?B?VFVNUzFjMW40M21sRUNQekRtYW1UNVdQbGYwbUQ5eUpjZ3FpY3VCYWowRzg0?=
 =?utf-8?Q?+g/dVAnN7rb4NPf93oE3znN5c1y26wfA+iMaw?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	M0FNdaNddJhS4bw14WvWgtuyRSty2O6ENGTJKyn7vngK7go18iSiPI6cmRYFeSZXHtP9ediOP9iojcTl7JkX/Uy2ureL2Zgt/chS1ADrMA709+ssQ7Lz5iO4Fv62OtBoo22hlKDpW3hm+eaxqlwqfDLkOpgl5ZJ4a7pJ2DhvJK8MK6LxylifNeYB/V4svWotASbGwfeH9Dh5ZXepnFFI+3bg4HEOhXZqlI2MchFlqMU2RgnZz1pp706IWTp9u7i/87WLOm9wEaM25QAUva0uqISc6sjuXu0uUaTndvicdkrQkxO2MAh22QJxDsnw0/oeql8hz4eQiCsIZAHF64DsaQEI7NZ3alSg0unYsc5feu9Pk93rb8dJhHXunk4YzwfgKs63ScWfC7RFnFYNF5FdX1zwzk7yjwV3+J8N1+C5AZnNF2d4t82v5pc6Uu5lsGhFv4tNl6mJb85VzOWU3eziYo/X3+0N+mCJqI9fXMqa04qiKhAF/Whsy/Yuj+mS9s6hGm4E0G4g4VQfa5z8TyOlpKNC2Z7E2cXi/TF/LkO0sFveR3VBCZ6GR30Tj/5dGbp7KlQexXpoRFC6bFRstu4RmVezGH2RG03yedBxMPOP8Gs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e67c631-0bb0-486d-02b1-08de60fef101
X-MS-Exchange-CrossTenant-AuthSource: DS3PR10MB997700.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2026 19:28:41.6338
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JccapRPlc+rpEu/DlY16eUSBwlnsIkLxOTrcADewhsxpEO4wApsgBR2PqU4X5aezv8nCyqySmsqDJg4fguT+N3yBaQ2Q14fQaoZkYiLTkFnQIFjNRzTzMM37VzA59Baw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4220
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-31_04,2026-01-30_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=922
 adultscore=0 suspectscore=0 mlxscore=0 phishscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2601150000 definitions=main-2601310165
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTMxMDE2NCBTYWx0ZWRfX9HlILGMxT02/
 Q3cq3Au5ua4mCnRDIsLpI5+rousWbngeD8rbO2hz2yDLzCTYKa8OV6aQrPsPVXJByX34Y+OYDWX
 pIaAOzYCHuFvIG4wjPbx2D2Tof6tDSTBZYOc8Fh9lH5xdpRi1kI8qpDxIkHG/A78QX7L0ilLVVh
 FNFYu9+5DlXw8DE5njr1NCUscJ4mclAKQg0cPWFVBmV2DZ2Ffh0akaATCP/CPUNiuxdNgMDpBb2
 Ja9aA/qPIaphv7KEDayXzwxyEW2lgQ3+98BLMUWKFCMymLbgQVs2tcgFhg7DOLJMkkSsZX11yyE
 s8cys19UghewE1AXLkpMwz3ToeRzmdNhQLE99atUW7rTmr87uLaqSuR+/q7EavcPbzxCaT9n9tv
 GmA8CfR0gINUtc7z7UYMYCw73bAKqi+kJtWX0FOnkVVXhBbUwRaZtdcCHRRC71w0TFOiTaHrmgq
 bY9WsG2ukwUIw0zYz2w==
X-Proofpoint-ORIG-GUID: ZdCKbrQv7S6t7L7L6-xiEywhXXy4zNHI
X-Proofpoint-GUID: ZdCKbrQv7S6t7L7L6-xiEywhXXy4zNHI
X-Authority-Analysis: v=2.4 cv=VfL6/Vp9 c=1 sm=1 tr=0 ts=697e57ee cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=CN1PFhL6E_MT_iie6hcA:9 a=QEXdDO2ut3YA:10

Hi David,



On 01/02/26 00:51, David Lechner wrote:
> On 1/30/26 3:43 PM, Harshit Mogalapalli wrote:
>> Convert the threaded IRQ registration to devm_request_threaded_irq() so
>> that the probe and remove paths can drop manual freeing of irqs.
>>
>> No functionality change.
>>
> 
> 
> ...
> 
>> @@ -1484,23 +1483,17 @@ static int sca3000_probe(struct spi_device *spi)
>>   	}
>>   	ret = sca3000_clean_setup(st);
>>   	if (ret)
>> -		goto error_free_irq;
>> +		return ret;
>>   
>>   	ret = sca3000_print_rev(indio_dev);
>>   	if (ret)
>> -		goto error_free_irq;
>> +		return ret;
>>   
>>   	ret = iio_device_register(indio_dev);
>>   	if (ret)
>> -		goto error_free_irq;
>> +		return ret;
>>   
>>   	return 0;
> This can `return iio_device_register();` directly now.

Thanks for the review and comments! I agree, it could have been simplified.

I am working on a v2 now. Will address it, in v2 basically the 
iio_device_register() --> devm_iio_device_register() conversion is done 
in last patch so we don't have this problem, so it kind of gets 
auto-resolved in v2.

Thanks,
Harshit
