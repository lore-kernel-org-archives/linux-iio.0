Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E897E4C4F48;
	Thu, 17 Sep 2026 10:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789642179; cv=fail; b=RogzwBSenEG+RCCnLUR6Baq9wAeGOobRDKHJgGLjcBXo6Jq+Frl0uMmdDqc1we147aDrIM8SCtSLvKX77Lqche+nnMnjKDPlVk4rbjI6kphB9KHG3x3K6D653op/zNxbxbeGAh/82m6biH/MBgk1Ato7+0APjTTKsmr0iBjW4JA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789642179; c=relaxed/simple;
	bh=Ip6B/rsY6T0bkWIWvQjn8aDoevK2LpzunHJOdsbOyp4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nxTEk+smHndbup1K34gF0d5u5ajost/LsRyjjyPNJn4N6heuxnLWWiGsAVCLWJAweeeKqK59AWR1+14NCzdm4fYTkT4aBUDG0eIS+llrgLG8roDsUPGmh2juHpSafLLzGDGDhN+9f5tnolNjJ0i068bgNSPLH0gx0toAztVYs68=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=gG/gMBtv; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="gG/gMBtv"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68H9dAcW1007528;
	Thu, 17 Sep 2026 06:48:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=D8X2g
	FFFAFAXAEvOL30d2pYSgGt6B0I5NslDSLWYuko=; b=gG/gMBtvJPqfxpXEKr34I
	T8gliqt8k5AkYui//7i54zElQZjMBwWbo7IbzIn1EVME0cjR5jjcR1suyMW2A/IQ
	Lvv+3z6Omi/9Zc09drXuD3RH/j6EtZAXTFDneCbLURETgBTtLeom+Y0kjUN0cPDf
	ge+NPNcPApv/clxUisCYVV+yoW/bhl7jzJZJYjfkhbfgwin0ZAveyrqOxaSeTZkI
	792HkZjlWjjDMD1P49Yj4V9Ql6B0i1dkObj2zDSH68qIKkI4q3RxhQpjN/prfAnY
	1UuzZjuTOrN5KzcgWmMagwZo9uXqWIC5FjnrdeARLG6vHk2mU52ffYsJGTXRNpad
	Q==
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010056.outbound.protection.outlook.com [52.101.46.56])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4gqj57qftd-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 17 Sep 2026 06:48:36 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h1BPwIlcd87fGlutjFoMbgB+ncG6sCDmQlZgIo8Oode1kCJixtM9+UAw00MBukpi1HqA8gJ0+gqyOW58Y4feOygFPswEQerabIEp9EBQ6IVOHpy2nSZjNr5lSkBHZTpfWmIbla4x8QfL3p4QNtTPYcCXWP2/yL41A0lTm4PtFvKqGceisYiNDctUKwFhPv2qTfmM96/g0BY6HaU2ENCLGvrS02MMeqgvk+qbTkfyiiQUJEDgHw4uYWTrae1HWCJUbKcx8DM7ExupRHiX7nOjsNHLEE+iOpmbwliJtj1FxmnGjg3g5tLOoHB1yCc+tg+2kk92uyVlXaMvWsn2bipK8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D8X2gFFFAFAXAEvOL30d2pYSgGt6B0I5NslDSLWYuko=;
 b=o2uf2sdWnTdFDkhi0KcMMmMezdZMBYdFJRYYTIgIfgT5pdUEc/45CA89ONLlIH/vgxSMPrBSpTnlOmWD/pCctlmqFXN9E2wp7WX7M3VNHVcDQes3L1gEQeOONdyJWd5sErBtLxxj/kBcQtB6Jsj2O4HKwnJuGDvQleJjn3WU8b/0cbJnE1koHoa6HXJg9GNTG/3DioD2Cx+KG8bsviiOQaLTqNdhhp35tWm6+vaywXiSLqj3P1I9GK9VNPhdRKERfTL2/zGp1Usymv1ioSVE+vcV1cYxTTrkve0YYNaRxEdJXhvaaFhpFXuyJP9jZVEHeriZHJx/LUVIJUSmt6V5gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by SA3PR03MB7371.namprd03.prod.outlook.com (2603:10b6:806:381::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Thu, 17 Sep
 2026 10:48:32 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%6]) with mapi id 15.21.0406.007; Thu, 17 Sep 2026
 10:48:31 +0000
Date: Thu, 17 Sep 2026 11:49:46 +0100
From: Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>
To: Frank Li <Frank.li@oss.nxp.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
        linux-sound@vger.kernel.org, linux-spi@vger.kernel.org,
        Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        =?utf-8?Q?Am=C3=A9lie?= Delaunay <amelie.delaunay@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        Andy Shevchenko <andy@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v4 01/10] dmaengine: Move enum dma_slave_buswidth to a
 new header
Message-ID: <aqvFFg5Uh1cXln0y@nsa>
References: <20260911-dmaengine-support-wider-dma-masks-v4-0-72b8fd4cc78e@analog.com>
 <20260911-dmaengine-support-wider-dma-masks-v4-1-72b8fd4cc78e@analog.com>
 <aqgCQvRw9fns__0d@SMW015318>
 <aqjzvxI4ecoFvRLT@ashevche-desk.local>
 <aqlYOHIFU_dB72I3@SMW015318>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aqlYOHIFU_dB72I3@SMW015318>
X-ClientProxiedBy: PA7P264CA0174.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:36f::19) To SJ0PR03MB5469.namprd03.prod.outlook.com
 (2603:10b6:a03:28a::17)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|SA3PR03MB7371:EE_
X-MS-Office365-Filtering-Correlation-Id: d7f20dfb-5eb2-4441-948d-08df14a9372d
X-LD-Processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|23010399003|7416014|366016|376014|1800799024|4143699003|56012099006|5023799004|10067099003|11063799006|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
 1bQEdSzsnfeV7eRNrdJTR3OpgJJC4cPgiuQbYlcYSyR41JYVI+L7eRxN5lMQBkVfSODJ2b/A2vUSOHNijIebVEq68Qa9UBC/z9XBvSKZVqrbcaGtbg6NaaNUHywLVzh9/91Lm08z8l2R/IpeaWeE/hA+fAL8BIaiOuiPTjifqcX1rBcmdzRIhkVPWW/tOwbvaVPmp8vsCIJo/UAj0Ktcxe5NtW4ALxZg+MbDe3+A9X8+GLimWYC+Evhn7Sfmfj0/C32I+/bz59yssXlBv+K76mLYl2ZEXd+1OUbAtclOb+z9P9v2XKOV9+ClBU1FKygsYhdNq4AFxwNMfyzM9sH4wVKHcs4z4VthH2Gk1qiNl8+Li0VX/79VVx0hvoiO30ln2Om63DhCzWrqMPH8/TJKYqYcLZ4iECMBtMvSS2ynBexITeIzBfDiTcXx65ObvFHmY9hpS11Ryu9M9CMP9F3mjg+F7YEYoUVKLk5vxLrLqAG38W3EYFAg9E19/vMxFT0N+DAQnStEYLhC43B+6KG4iA7Y1ZavAbvwU9Lj++ooUiIvUYxzEkYUTIYuf3LC3EaPQr9xSsejTp+m9P330UjKHjVgP7a+w0BjbEnmhIoCQgnDSF2Pk7cUz1G7bTQn6l08eXrM0cLLwbGQvTRmZTXP3wsQTFbmziXxR9jD9Z4sRVo=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(366016)(376014)(1800799024)(4143699003)(56012099006)(5023799004)(10067099003)(11063799006)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?UGhJbDlJWUptMHdWMWRuektzK1NKUEZCUmdlQjh4V2FtRS9lbFZpMUVqd1ZX?=
 =?utf-8?B?aWNvdEV1VkhkcWVyVmpMUWJxdmJ5Wk9vb3oxOUNpOHVqaGYwSmJVeXU3ZFh4?=
 =?utf-8?B?cGVKWWhmQUJJalJVejd2T3JhdTl2bGx0ZzZvMVh5dWxlN1NiYlFsQTVVWnAx?=
 =?utf-8?B?ZkwxL1FJaHZIYUdldW9IZ0g5NmxTZThlQzJGU3ppSVZkTXVhMHpDOHN3UkhH?=
 =?utf-8?B?Y2twNVhZY1pwQTFldkVkbmlaZHlEbHVFdjVxc0xJVmNnMmtKeDRqaitKVnE5?=
 =?utf-8?B?TXFJaGtwQ1Q4L1h2ZUVXa0xCdFJwVWpsYk5SWmJaVkd6THZzdVBMT25BaWxB?=
 =?utf-8?B?TWgxamxTN3kwWEd4MGFydFYyMndjOWp1cFY5Q0dpVFFNQmF3NjN3VERwSUNh?=
 =?utf-8?B?SWFSWWdBZ2w5WjJvc3lmOUcrc3Q2cXRHblR2dXdUOTkrWS9NUlpGWjdIRENH?=
 =?utf-8?B?Rlg3SUpZOWYvR2tLdjRDRzVOYjloNGRiSlBMQk94OFlrdFlKZFRjSFVuT0ZQ?=
 =?utf-8?B?NFg1WHlDdCtubW5IdGpTaTJlQVlFRzZocGJQR05PTjlqMGNRaXNLdUpOZHE3?=
 =?utf-8?B?TW5mNUVidnlnTGF1N2FCOHlrNkxNYXV0S0RJdDJGNWFuOWxPNVhRM2d5WFFv?=
 =?utf-8?B?ZnNNZDQ5dE5ubTBqY2ZRbHRCSFJKZDZsYW41S3FxeFoya3UyYnNEb1ZucldW?=
 =?utf-8?B?Qk53bEJ0ZllqWE1JUzk0Nk1QK3NtK3g3cmhER2hHdnBhNkdnVnd0cGt0Slpv?=
 =?utf-8?B?ckFXZ1Q4RzluN0pOWlYxYjFwTk03OUhmUWlzVFk3SVAxOU5YQ2NvYVJzd0ha?=
 =?utf-8?B?V3o1dVlsdUdvRGNMWEhMOHhGRHFMbDVHbHNqSFJ0OExRY2RuRUMyd2l0OGl5?=
 =?utf-8?B?MklDSWxIOXpPajFMa1hKVndjUm1pZXpOcjBOQjN2SXA3MnpRT2M1VWsxTllQ?=
 =?utf-8?B?ZjVKVWNBVkxKUXBJWWRXdk9hSUpkbHBUdTcvUU9zMW1GUStyRDZlWkNnL3J6?=
 =?utf-8?B?VFlMZnRFQVlQRU1kcFExZHFCbU83cTVYdGsvYklxM210K3dUNTJ0MkNoRmZt?=
 =?utf-8?B?TWxvSXJidVBDaFJCRGpQc1I2Y1NERnlDSk0wVjNvN1RjRCs4azFBTndMR0Nj?=
 =?utf-8?B?bExTZENnUENzZXlGZjgwczRuS0pkSVRRYUNGdCtRMmNFN3F1RGgreGhRNGZU?=
 =?utf-8?B?R0NUbzJTUEdkWEg1cTNDTmpHL3VKRG0xdUg5R0ZxNnJGaGd1YUFSOG1rVVVT?=
 =?utf-8?B?RWxGb0Q4STVWNVVuRTBta1A1d01jRFd3eWozYWh3VFRqS3JvTGdjenFIM2xO?=
 =?utf-8?B?QnoyZlNFZzdDZHJVOE9LWlp5OFJ4UlowSkhBZXJoTElFcVNLYmRlUUd1YWE1?=
 =?utf-8?B?emY4YjNkWm4wSThiMFZUUGtEQlAzengwZ2N2UkJURXNoa0x3Z3d1STZvQVFL?=
 =?utf-8?B?SXFKQVp0UHZHVXRIK3RlMDhlcGxVQ211SzF0aFBJUUcwc3ZmVDN1Vit4a2R0?=
 =?utf-8?B?RUZvZ1B6ZTNEUmdyb0g2Wk9zbzNPV3hhZ1pXUEU0VDVLSjdlWFdFSWtnb1Jj?=
 =?utf-8?B?K0xOSThSakltemFuZGRodVdYaGJuTS8xTVozWWpJd0NzNk9icXdid04vZFZz?=
 =?utf-8?B?bnlpalNBUGNTSjlYMXcwL09PT3kwRUthcUloUVQ5L0NST3o2OU5Td3pWZ1lP?=
 =?utf-8?B?bVE4cFpKeWJFZlRRYnpyWjJSd29HendwNFpDYlIyNTJwclo0ZDYzeGtoSC9T?=
 =?utf-8?B?K09KRldoVkpNRnVQVW1NV1JDY2o3aHdXM0NiUk5yTzJ2T25kOWRHSDBsQzdO?=
 =?utf-8?B?dGhaT2RZU1dkTG53eHM0RnZFYTl3a1dGQjB5eTZuTHB1UzNpdmlPZ05ZZDE5?=
 =?utf-8?B?dk1GRDdwOWZNQXBVV2lKVnlCb0F2ajFhOFRuWmdsM2IwdUkxZHNYUUt4UVZC?=
 =?utf-8?B?RG1LV3ovZUUxZXdpdExYTUQ4TjFXMFhVYXh5NkVuOXNYNVQ5K2VBcjdBUS9p?=
 =?utf-8?B?TnNSSHQ2eXZDZjk1d1RPbWpFWlNSY0NuaDhHTVpQSU9KNE9xNHNaMTk5M29B?=
 =?utf-8?B?K1lHcGcwOW9WK004dmtZU055Wm9IMkZlRUt0ZC9aS2xKSGhNV2tqQ2l1UFF0?=
 =?utf-8?B?NkkwS0Z1YWh4dHdGemtQazVGSHZCUXpDbVB6K21TZVl6ZzQ2SGtXS2U3RjRq?=
 =?utf-8?B?NkxoSGw1YnZPeGhKOS8xWnMvSkpGM3JRUnBzZlp0Sk9DNVNDV3g2SDc5TmhG?=
 =?utf-8?B?d1NwNE9yZ2d0OEVrUll4Y1hXMlV2STVCNHhQTXJyZDg2S3hISlVsb3hSQ0Jn?=
 =?utf-8?B?V1NiUWtjVmNUVWQ0WlBOUnpRd25GTHdXbCtWSXRJUmp0R1RHSFNkdz09?=
X-Exchange-RoutingPolicyChecked:
	CP+biRXUxrMNtOeABh734c5VJwm+y4W76Y6XyZTTzegznIrUyr3mVQjQQEiYJ/d2qV1e/v4UUfrwNwDplL50nD+XXrKQlx1dn5mHHfkOdRLba12PBYLvqArMCexGTPydKo0IGOCu7kDZf8QJT6ZSMZFUhfArgUP7WFSdB0cCsGG5gIIj0JmdBQPBgSW449lERrcgPzhmZRKCFCD6BWHCP0B2SRDfq0R/AvuN8lZSW7fB9JQYE5yYKGslbB0+U/KKAfDgqRJ1DSpY+TbdYHAjByF5gjnamnNkNc/D+8Ffe0R4ZVoMMrmzCbVVRhVp3/midcRWszQ2Q9q0qZdR7BfRyw==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7f20dfb-5eb2-4441-948d-08df14a9372d
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 10:48:31.9218
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1yfsERTLS92iTuHNHpIpBzXVqNuRI0zHAfGvDwedZU9FVIKRxXq2Ndlk6K2O/eJCy9sZoqXaSj3zw41oSMGLeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR03MB7371
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDE0OSBTYWx0ZWRfX2/wKP2VWx2kq
 Sf1S2itB01nj005JU/FjwmHwspAdboq3oVXhrthaF8znQTpQmgezBO7V+UGj5dulICX76dMoh2L
 Flp4zdjzpW4U5WZYgvPcpUs+UjS5ErFSzuSvqhMjzMZrp6mBFvIP
X-Authority-Analysis: v=2.4 cv=HfuB3SE8 c=1 sm=1 tr=0 ts=6aabc584 cx=c_pps
 a=0PDhd3HO6khzWhHQYbQRQA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=N--XFCr6TIEc_64PeIT2:22
 a=-FiQAyX2zloPSlR5Y5kA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: ZiUA48QYJtR8R8qm5HwompJTvxhT4xGr
X-Proofpoint-GUID: ZiUA48QYJtR8R8qm5HwompJTvxhT4xGr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDE0OSBTYWx0ZWRfX8PCdoN6oIZHV
 ys+jSiv/gr9YNZUQvHQaU2pYBBG/q1VOaX9/PInqfpk2bWUyOKakb2NfbzDiV4+LH98GOzTfkon
 QcVwvxvKGQpF2zrHokR2Bl+SepY5J+udOj9PtRPwFbe2Z6chkephuAChUPuKkItkYGCOQRLPCHw
 rxZklobzA3BHSvfxHlB1EYaj8FG0putW3EGaZbM4MbxGYZ+eKxl+JoZ6hpvB+4z8G0USeAWv1c9
 1qiNxlL35Oy4UeZnDtylRQrm/dv2gIPcfjnQFfw/6OYwBu3lmqQ8EC/DTFYgcJQdHMDysLd0TBM
 8P4OAGCHJtF01MarXKilOQIL5m6bpyvyPdYpCex7WcgHHr0V+2yt+3G2bfLcg1/gR5lEoA0gMih
 3A/KDdbdUqwyqelduR/hicPHPkNQ/GNvhH1grx5K32fJEm0qKEffSZu6ikB1W7gRiuiaTmG2rHv
 0AAQA8h32ohbkycGcrw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-17_02,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 priorityscore=1501 suspectscore=0 phishscore=0
 bulkscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609170149

On Tue, Sep 15, 2026 at 09:37:44AM -0500, Frank Li wrote:
> On Tue, Sep 15, 2026 at 10:29:03AM +0300, Andy Shevchenko wrote:
> > On Mon, Sep 14, 2026 at 09:18:42AM -0500, Frank Li wrote:
> > > On Fri, Sep 11, 2026 at 06:25:36PM +0100, Nuno Sá wrote:
> > > > In preparation for the bitmap based bus width capabilities, move
> > > > enum dma_slave_buswidth out of linux/dmaengine.h into a new
> > > > include/linux/dma/engine/types.h.
> > > >
> > > > linux/dmaengine.h is included nearly everywhere, so growing it with the
> > > > new interface would make every one of its users pay for it. Keeping the
> > > > basic types in a separate header lets the new interface live next to it
> > > > without that cost. linux/dmaengine.h includes the new header, so its
> > > > users are unaffected.
> > > >
> > > > While at it, add the missing kernel-doc for the enum members. The block
> > > > already opened with /**, so kernel-doc expected every member to be
> > > > described and warned about each one of them. Describe the UNDEFINED case
> > > > in particular, as its meaning depends on where the value is used.
> >
> > ...
> >
> > > >  include/linux/dmaengine.h        | 20 +++-----------------
> > >
> > > I think it is good to split dmengine consumer and provider header files to
> > > hidden dmaengine's detail.
> >
> > It's indeed desirable change. but isn't it a bit out of scope of the series?
> > I suggest to do one step at a time. Would it work for you?
> 
> Yes, but I hope the file name is finial expected file name. it is okay
> just move enum dma_slave_buswidth to there now.

Hi Frank, if I understood you, you mean to have an engine.h as kind of a
consumer and have enum dma_slave_buswidth on it?

If so, note that enum is used both by consumers and providers so having
them in types kind of header makes sense to me. Kind of the same as with
the new widthmask header. It's used by both.

- Nuno Sá

> 
> Frank
> 
> >
> > > suggest name
> > > 	dma/engine.h
> > >
> > > so we can start move more API to this files.
> > >
> > > after all user include this consumer header file,  old
> > > include/linux/dmaengine.h rename to include/linux/dmaengine-provider.h,
> > > which only include by dmaengine drivers.
> >
> > Traditional naming would be
> > dma/engine/provider.h
> > dma/engine/consumer.h
> >
> > --
> > With Best Regards,
> > Andy Shevchenko
> >
> >
