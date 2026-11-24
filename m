Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.139.77
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795519270;
	b=rF375xMYYKZyJ2Ae4Oi1Igbo3pz9kt73t6EkJa/N59Wbo1D7auz06mKlZ3RAeTL//ac9
	 E6IXrnwIiMBqQJDv2lqOutZuBO6VCjriBk47sANwnoDggBsXdLdXGe6o2AxP1sKw1IUAl
	 oSGTZaSHopylRJSolbLGCHfvLk9k3KW3SVr/1hOjjN1bE9a/uIruieEl4WxemN3BMWJBu
	 42koSuYiDK4lsuRWMAkTU8qReCSaFHzXkY2KaC2s/tomQQmFogXNwAuBCaOM2eGURKr+b
	 mqiSOj+6SVPfQ7vrgvAYdxPSeMwxKqBq6lStC+Noi1LTWf2H1Tx341S2V+MAdRv9IwQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795519270;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:Received:From:Subject:Date:Message-Id:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
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
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=6/ukFRL02XC6NyIPEPilbvfdZ+q7HEtDp+YcSWSDX8E=;
	b=pxtDfhLqOtnKextkqf2BuydFU0giaMWcyTU/yKBDJUmXEH6nFRPAN7MP3O07LfVrAslw
	 4GAznmTkFb0WSw+UXfCGj3vxTrp1tEBrEIHJubZjr53d7sI/9IDe/OF+tfk64awjEMMA2
	 aR2xj8PFBCa3vS1zfBd9Ct9IOK64o9CKT/Mw9dOaakdDIMGNUec/+HlaN7yoCo+0Ef509
	 dcBkolkvmm95yia2MlcNhjrVw452/cfXpGe5Zh2o+3dFzjZQp2FE4gIIh0xpFgkRpNN4B
	 o+Q78iQW4sev1jc49wooKxaju73METkoyuQy97NUct4ic4RZdaQJj/OqCuM8uwrom0g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=gnhUBEf3;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b="LP/uTBsV";
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.139.77
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F13606A322;
	Tue, 24 Nov 2026 11:21:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A8F13606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=gnhUBEf3;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=LP/uTBsV
Received: from pps.filterd (m0516786.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AOAuLRC3436967;
	Tue, 24 Nov 2026 06:20:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=DKIM; bh=6/ukFRL02XC6NyIP
	EPilbvfdZ+q7HEtDp+YcSWSDX8E=; b=gnhUBEf3PpjrBv/gMEZU1j2B1gCCZLrx
	SyvfxLmqpSuunpoTzSB6rfQZYiGJUzE6NBhsbjxuYSyaDtYN1IKhKcKjrZ5MC7HA
	H1nUoTudpoi9hBc7eUYve998638zIhFi+9gN3lMGlidFf6Ma7GsWvKhjETcuMYP4
	xHlbxoh6QhEE1F7UYTajYoie4jmKprQaq1OqPUcgvhfOeDjU52QSZsa/JBvKRRsZ
	nzfmqhgwlZSNJba2awmlK/udl5vXVJ1A2DmcYjSnVa887XvQkxHIhnL1HF6XBUCL
	ucgDawNtCfNelbHoX63IyN5zEG9+VXLHYmHrcUkaD+Y6qyZDD9cFKw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=6/ukFRL02XC6NyIPEPilbvfdZ+q
	7HEtDp+YcSWSDX8E=; b=LP/uTBsVD1mzXjnDtN1eRluZzE+rasKw/CmeI/lUOiy
	RHjJ6BIq7z2vcobDlFkUHPsrBNJkcDt1EVsWLeVEz3zQ/f0RFS/tpZoFyiVQjrUF
	rxywxRugAs3F+lLOW8wlESUpnaHvq6blqWR3ybdLiXRwW7vskRXSAQ7GtxKFr6Te
	N6DmBH9iefFqa9P19jEDtUHXcKsy//d1Kd3WQ1BtPZo63I0qP4b2nk0cprbGT8C3
	tNQGtSB5ppE71D8+N3SJu+DOXPqU+/uQWdYPXOdTbMJfw9GwLkTaR/+1D7YdueI+
	Dbc7exLPJIt36mFStydu39dxogtPcq7aagShyj/xFNQ==
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011021.outbound.protection.outlook.com [40.107.208.21])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4j4jc866mu-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 24 Nov 2026 06:20:06 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zr7kohJyjcgSumsNKb4E1qeGhttnQ0zIKokXxX84m/yOjG3/kAQI3uGfFeba3GQMKXlWw1Dz/ts9Y5ORyCVeohGDxM3rV/xEV5ekLOk0WuusoFnsODIsBp1Qyst7CSNf7ZyWfHp2TwGqZKA++j8Os1aOQKYewIG9qg6OF4P5QdZ9AE6n5mE4TMQeOHZHccUm+VUupLL3kMDXTX3Hj4Z6E9LjN4fAT30S2xGfyRKUXsxVkP6QQxv3Ukn7AxBfTkU1u6RomZhSCsu72HQeeWqb/bVMs4nZGjbFFupjrVO/2owQamvAY3jkB9ESWiL1KncVktjvM4zXzlQMROR5A+3JPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6/ukFRL02XC6NyIPEPilbvfdZ+q7HEtDp+YcSWSDX8E=;
 b=WFLelSx9NZXQMEiZ7TuaRC8WNCf1O++4hyNq6UIRq+ejCTpbJaxZsONl44g2WurtY6eFjkx+0aVVrcWJHSmUyIA/y8ArVUXgLuMbqJ3mFbTtwjWiTwcgujMblhnUqrHK88V2MZ2asQZLCMVCaffKWnXGlGKqCe5vyjUTOMftDImGlBJnD59sGy9hCSy0MBokuSKithgX8dqilVNAxsm9EN9UC7hlBptzkR6ZKC5GhpVcv8Ee070xvYdzeIGzBINK8WGzpnNuIYpdCA2JUycPYXJpN+wGdIQNzNZvfrVHTo1UfdkCJ6Ezo9K3FJbMAbBEwB9p7B2g/79VBj3Djivcpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by SA0PR03MB5545.namprd03.prod.outlook.com (2603:10b6:806:c0::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Tue, 24 Nov
 2026 11:20:03 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%5]) with mapi id 15.21.0639.011; Tue, 24 Nov 2026
 11:20:02 +0000
From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Subject: [PATCH v7 0/9] dmaengine: Support bus widths of 32 bytes and above
Date: Tue, 24 Nov 2026 11:19:40 +0000
Message-Id: <20261124-dmaengine-support-wider-dma-masks-v7-0-5d57df2c3ebd@analog.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/43Py07DMBAF0F9BWWPk8WtiVvwHYjHxozXQpIrbA
 Kr679hF0KJsvLyj0bkzpy6HOYXcPd6dujksKadpLAHv7zq3pXETWPIld4ILww1o5ncUxk0aA8v
 H/X6aD+wj+TDXOdtRfstMEzkQymIQ2BVnP4eYPi8dzy8/OR+H1+AOFa4b25QP0/x1OWKBuvfbZ
 xr6FmCceRKSeu8G1OaJRnqfNg9u2lX9QqHkrZREKSJE662jW6revojrdT00kaKQEHFA23sudVy
 R8oaU0ELKQmqO3qKyJgq/ItWVtNBEqkKiGProlXPYhxWp/0jg3LaQupDKqWAkIQGtHzc3JKgW0
 tTHBxmjD7EHC//I8/n8DTVLx9DPAgAA
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
        Frank Li <Frank.Li@nxp.com>,
        Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795519198; l=3043;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=xKmU1V1z6Gr7lcK5usQYn8nuw38xF2aTZQuu5tQDweY=;
 b=lwoIDsU3siDVHHNM4pgrYLp2dBVksPTseFMtMCUfN47jsZUt/PBrJoR8FahDFYbwdHeqIw38U
 /lAg5ndrVL2B9/P03rErJhRQbj74qG7kfyPk93wbcDzA/yWgZoCnm+g
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ClientProxiedBy: MR1P264CA0194.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:57::9) To SJ0PR03MB5469.namprd03.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|SA0PR03MB5545:EE_
X-MS-Office365-Filtering-Correlation-Id: 320b2e7c-0fbf-4ffa-724c-08df4a1ce241
X-LD-Processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|23010399003|7416014|366016|1800799024|11063799006|261022075727099003|261026121527099003|10067099003|261009223027099003|56012099006|261022105027099003|261021121427099003|261021123027099003|261102123227099003|261009223327099003|261009221227099003|261026140227099003|261009220027099003|261028144727099003|261009221727099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
 msTtmwjdUUf+d5DVZyAc25x/EgYQhV65CyshHpdz72TVrrk+BSrnh4oNfDPpWYx6r/fEl8IZ/7SuWZ2ozrGbYZHgXd2+XSU23nbpX/xZNdUnUmg5jMIXR0FFO82f0ZpA5/GqfguHQ2FyVueaxkHEHwtMHLr3bMytS70A8jOD30BDAbURMW7quGsvL2aS/ZoH/ujGkEfFDJ0C465NqvQthEYn6OqfcJxggbA1AoJr1DYL0LqfgmaPWJTxiodv3x1WlO2nJL/sLlXwXFt+ktDxCRnffVpSsvwENP08kUOMpVbFAbDZamlYMrMX3c+t0q1uPfrT+L0V80vzDdcABU+PBiVyERafR1zaum2+bV/f9AJfEDVys84CxKBEj4zdHQiQtSBKKcXHLh8K+wwugWxmhh1SNwZtQXnKnxxP9ulahVQ3q6TNslxOsHazS7cEDYzFl8geYFVPfIqRDrfo5DgbI7xHq6anksNUJOpWlExvtOfCb7P2lboQpyDS3HoYkAEc2gb4smljuHP6XM1h63atuMVRvHZ54yYr1AEqSPQ7tDPTOdOjxVjTKBJ6HGgP6T5ncEosR48PIzOaSssGEP4xk8yLanJKl7mvcJIYeqfFRq0=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(7416014)(366016)(1800799024)(11063799006)(261022075727099003)(261026121527099003)(10067099003)(261009223027099003)(56012099006)(261022105027099003)(261021121427099003)(261021123027099003)(261102123227099003)(261009223327099003)(261009221227099003)(261026140227099003)(261009220027099003)(261028144727099003)(261009221727099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?OWVlRXBGUVdlRjhmc014eFJabWJJU0hqbE14Vlp4aTkvcEJSdjZxU3QzWXRO?=
 =?utf-8?B?WDZIMVpRYlZiWlk0SmxZdWZYU1A4R1Q4RnRmTHRQbE85YlZWQ3hydE9sdkM5?=
 =?utf-8?B?REQvSFZjN2JWM3pEbmsydllxSzJpdkJnbEZJU2JDTXdYR21OeVpCWDdFN1JI?=
 =?utf-8?B?SGlwTDZ0RzIwQXVuZnZCRnRlTUd0SWdkclczQXFrK09aNmx4eXllbk9BNFpT?=
 =?utf-8?B?QnJHT0JEcU91TVNRY2Rsd1BGa1luRkJJVU5JYVdMazRtWEdQSXJLNUlBU29t?=
 =?utf-8?B?MnVxWTNDNGFVZWJ6bVU4emlkdzBDQWcxZktKQU4yKzFMR3lFT3ErVzJuQkho?=
 =?utf-8?B?d2EveFY2dDNSSWpDL216TXdITGgrdzUvUGR5bHpVdmk5QW5PYkNtRnRJd2lW?=
 =?utf-8?B?NGF5UmZtbFMwd3pZSzNML2I5eEticVpOYTRVU0c1alVCTkh3VGpMRnBBUWFF?=
 =?utf-8?B?a3JsU2N4dmMvT2NrSnJWeS9JMTdOYzVGZEprK0ZQQjNTOHNhUDlmaEF3TjAw?=
 =?utf-8?B?elhJSlEwanRmWlhvcXFHRGFrY1RZVmE0SUQ1MktVdUpPMzNZak9lVlh2R0cz?=
 =?utf-8?B?ZDU0N2I2cktjamFzT2lNTk4zQitpazBubGFCN1BNTEU0RG1XRjlFa0RrQTBt?=
 =?utf-8?B?WEViOU5jUkNNL3V0K0lGeXA0WFdoS1VnOWtaa2JRRUJMNzdjYXdPOFNOMWhI?=
 =?utf-8?B?eDhFdVZGVHdhNThrcXJMNjZhMUhjaFVBbmN3OTIwbEJIT0RGb2pQTUE2Zjg1?=
 =?utf-8?B?THdwNlZTN2F2bFFTUFVUbmZLakhudXpvd3UvSmFyNnRxa090NkhscGFmbkNm?=
 =?utf-8?B?Y1BzZkkybDVCZ0IreXJ6bG1nd0l5YzBVWUc0UHRheTgxOVlYaW5OdTVVeVI5?=
 =?utf-8?B?Sm5iMk9kQ0NDakVEZ3krSTRvaEJscXorN3llTFJtSzBpOHVna3BYcjZhaHha?=
 =?utf-8?B?MkRtalJhMzdqbVRwMlVMN0JYMzdqV2VpdCt0ZjRUL1p5QnppT0tTNEpKM2Fl?=
 =?utf-8?B?S2YzTzJxS3pUa0tHWmFyNG1KMWhFaVNNU3BEUjVucFBRQTFDQmMyazFuMnVo?=
 =?utf-8?B?d2kvSlNHZkF6U2pKZ0JGa1JRa1U0VUtzMlZnWHFMM2R2YjMzR1E4VldDeDVO?=
 =?utf-8?B?RWxqaWRPaURrQ0J1NUJWb1NHbFRhVW5qZEFnVGtaQjA2aGI3NGY3aVduc1R0?=
 =?utf-8?B?T2IwY3QzR3BvUzBSSk12cTZ1dHp4SGhLcXcwU05tejZJOTFSamYyZlpnS2JO?=
 =?utf-8?B?K1VOa1N2OUFQRWNyU0JjSTIxR2IxcEZuMzRxRGhkU0V6cEsyZkFXRmwzWkpU?=
 =?utf-8?B?KzJETDJCeGVJSFhoQUkvcnlRWnUzeGN5Ujc3WG1WU0ZGS0QvNUNlTWVoN0RB?=
 =?utf-8?B?NHdKNS9VZG81ZVdSY0tMeXJwV1dBQzlnZGhJRVhJV1BDQWJEdXU4TWt1Tm95?=
 =?utf-8?B?TWN1RkhBbjFudTBwYmMydThTTm9ObXRlSy9KRjNIaitwKzN0TGRYWXdHZ2k5?=
 =?utf-8?B?SElCT3l2TzVsOTNjMHR1dDFCQnZsTU56czlsMnFqTHNCMVdVUTlXM1ZENDZL?=
 =?utf-8?B?SndRUEV3alQwZ3pBenArMU51WXZkV0pHcG5xTDFWQkxHVkRONGVsYWZ5aEVx?=
 =?utf-8?B?dEJvUU0vQlJrSjhCVGpzNGI0QkRZV1BKS2VtSWVRL1ZXR1NZTk9LYnJ1czFZ?=
 =?utf-8?B?RXpVR3lqaUxTNG51Sld0dWtZaVIzRGZxYTZPa3lmblJ1MVlsRUdCSEROVkh1?=
 =?utf-8?B?Z2VsZU9pQm5hdmZpUHhxbTV0UGw1dVB3cDExeVAxQmZCb0tRanE1RWRyMkxJ?=
 =?utf-8?B?QnN1Tm9ILzNrTnJzM0ZYclVqNXR2amJlV3F4eG05K05vRnQralJsVXNXdkFz?=
 =?utf-8?B?WmYyS3JEL3g2YUpkRzNxeVNMcmU4NVFwdTE3c2tTeS9JTGZjOG1DZjdGTVlK?=
 =?utf-8?B?TURoaVpIMW50MEQ5Nk11MXFHUGxWZTJONldKVDg1TklTa1l0SlRUZDVSakJM?=
 =?utf-8?B?OFd4VkREUHVGekx4WVpJQkxNeHlubkc5aUhWU3JsdmtvUVRhNFN5cGRCZDd4?=
 =?utf-8?B?R2pMN21wMkNFQXpLeFFvbVdxekVxRm0yT1I0Qy9pdGxRbUp4TDNoTDJYVHFY?=
 =?utf-8?B?NkZJMWVJemxMcDRBQ0tmam5wclFoc1I4YXVNV1Rpa3FPdTBRUkduQi9qaVRa?=
 =?utf-8?B?anNJQjdGSWdGZFRHVXIrZnVsVVBaL25SVkVteTh4QmxTVmZWb0daV29KYmhu?=
 =?utf-8?B?Nno2S1VQUk5lZ1phaU52eUZWMFpMUG5pQUV6bDVSdWsrNTlIZWF0QU11TW5T?=
 =?utf-8?B?d0FydjYrZkRsMTZ2MEs0bFBqT1NETVBtbjJxRnBVVk1aNGJ0Umx5QT09?=
X-Exchange-RoutingPolicyChecked:
	UiA5tEuac5Acoq8/fEgCZR+8yI0yqrt70I2XhIk53VxHPp/JXi1AOGQxjda5uAQn2S90I0zA261VM7VdXYeSOlw47SWHEfB8ggLBnblbRX7Lh+hntJSNz07hYq5f1VYRxpkKodZ/sYSWcvgIFnZuIyQl8C5VTFDQh1EM3i4TyGsqGva5tU55kqziOc7PaTn2lmtGbFWwMEaQ05z64j+ED+23L7Gf0J0v5S+/2v3cD4+tvXDfc9MzI9ptzA3sGuQdqYsjMeX7cQVVCrQvgKqTxrOu40NfLbxRRsLHp1E/W5W0AD+Mo1txJ5M++xR+S2V0/RmxZODWZuSwURid7TGYEA==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 320b2e7c-0fbf-4ffa-724c-08df4a1ce241
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 11:20:02.7193
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P4pknIJn7BD/gY1h0zpJ3Ong/rCZyKf+mIAMPUfQ3P+XptEBr8+CDbIk7kZSl2wFSOzQnWGMHjmvqiGiX7c9SA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR03MB5545
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDA0NCBTYWx0ZWRfX9Q3I1rlG5UH6
 YnQxhni5BNIjoWaSwx4CqG11BG9+30OREx+EAsduzVtxdINHNJg4GecEsUSLDhwHDT29F1ee4jO
 jff3Zgy4iz1XCOxeUS7qgK+mC9VQcTLzspmzCEjLeIMhyE6zufEP
X-Proofpoint-ORIG-GUID: Ptx4xfruooyGKvffw0rMX05leLRDnYL2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDA0NCBTYWx0ZWRfXyO1jtneuPx5W
 /sUoKD6+8GtCErrkKIlRqlNLmSA18TkqSX31+yeywQ+WvgEOUeb4ObJs0odg9pLJonka3Qtj4IZ
 C9FNlWPiMGrEw75bTqCBENyjgBejW0KzwfhxA85KiPpifWo5MsdeKRDSU3QM5pKSFBqfbHBbR7u
 tUflB4COF2A+OVPZW75ShvZlcRjE/QfH0SHiSC/D2FC7bKX2KcNzoSxC1seLj0mTE3RTWdcn8A9
 vj9oESaO1ZJsVeX4hs7POcA751iVrzCIZW9kTQeEuvI4oZNYFOgFeNNoUURrxWavUGT5tq8FxPI
 rKVXzWjel11w7wSzsbpYjOHUJlzQGp0oniIzJEWWGyPDZd6m+SMZpkUuPzcfiTdUHTQA+H+nNsy
 dbs9fyO2j9LY42orfhCKYx4X9OCCGlBMmXcIBVQF2Ugk3Z//bnBufGfaNACSvPdZCViCmXStCBf
 czzoRsQHMxUjG8QMzfQ==
X-Authority-Analysis: v=2.4 cv=GJ+dgeNK c=1 sm=1 tr=0 ts=6b0572e6 cx=c_pps
 a=6VX5YHTAOo6o8GlK2BM1ww==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=ZQxX5BWu6Z8IJBb2zLX7:22
 a=VwQbUJbxAAAA:8 a=bC-a23v3AAAA:8 a=gAnH3GRIAAAA:8 a=DwB-ub1qf2YoVHXZDOcA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-GUID: Ptx4xfruooyGKvffw0rMX05leLRDnYL2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_02,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 clxscore=1015 spamscore=0 impostorscore=0
 phishscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611240044

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

Once the remaining producers are converted, the legacy dma_device
src/dst_addr_widths fields can be removed as a final cleanup.

This issue was discussed before here:

https://lore.kernel.org/dmaengine/abkoXXbaxaiqbBuX@vaman/

Changes in v7:
 - Rebased on top of dma/next
 - Patch 8:
   * Given recent changes on the driver, needed a couple of more straight
     forward conversions (no new API was needed for dmaengine).
 - Link to v6: https://patch.msgid.link/20261014-dmaengine-support-wider-dma-masks-v6-0-5b3ffdef8191@analog.com

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

 drivers/dma/dma-axi-dmac.c                         |  13 +-
 drivers/dma/dmaengine.c                            |  23 ++-
 drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c     |  39 +++--
 drivers/dma/qcom/gpi.c                             |  11 +-
 drivers/dma/stm32/stm32-dma3.c                     |  37 ++--
 drivers/iio/buffer/industrialio-buffer-dmaengine.c |  15 +-
 drivers/spi/spi-dw-dma.c                           |  13 +-
 drivers/spi/spi-dw.h                               |   3 +-
 include/linux/dmaengine.h                          | 188 +++++++++++++++++++--
 sound/core/pcm_dmaengine.c                         |  20 ++-
 10 files changed, 292 insertions(+), 70 deletions(-)
---
base-commit: 2e02fb103be058cf8b2fb24112a74a2715e090f0
change-id: 20260615-dmaengine-support-wider-dma-masks-5aac12497e27
--

Thanks!
- Nuno Sá

