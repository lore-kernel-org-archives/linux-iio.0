Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.135.77
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793623257;
	b=MRMR5qMeGfaGIcO4m8NVptg1deszCBNM3dqHX1uGafc+QyFD0bmWnDes9cHB+xHhemGu
	 L3ub8ttjgHVbEWBIcrpkVuRoVQ1vW8lSpGElEDfMhhqRG8b5/MkGZ+Lzbt75IaowPMyOJ
	 vZxEzIphlhdSF/Ig5eQqKUX6pl2Lk5k52QgcwnIUlf9CGPP0+aLLrhrL3F+e2eFwh9eht
	 vIZ5R6mVmiGUAJLnZzrnSv5rajr3sR6w4KS4xvUge9Ud+IjkTHQKRoF0QfYX0Xh8aNpUj
	 AZLg/g3/3EmNk/8vmVRuMuODBTFtCGMhn/UdWOOR5sRpklv4hLnbigUjbhDUU2Aq3NQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793623257;
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
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=r8Zw3pDbzt2XtV/9KWLgShPzNZh93bL1kQ40A3VxQOE=;
	b=JeNTSJhoj7VGSkrRweuqKzkQ8DX3MEOQSXtbqnDLk5C+Sm18E/+lKhRrLab/DnHMh48u
	 rD6WvhCBH7zw5QDTVZ8g+XYUqnNn9dmftgDWU7sCzdjI8mkA5zMa3lUGM4Zipp1NamITo
	 fK4eyObR5kJwU/TLF58Fj/1tVVEmel5ogz2BAol+7ar86tAx4snU71u4BnYhafA9thbb5
	 Im5he33av8/99LAaPREBKk6SUNno7RU7DjSmhW1/i2Erxdplmq1BuK7Rsb/OfGfGZz5Yr
	 hvSnOhEKQ8gxqClLNeoFjXih/wXn1AWpHNpkcNFp9qU+ZzmO9vKSn+VwfUikshSdqrg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=IbY2Mi7u;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=ko2eZPdh;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.135.77
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 234F4606A327;
	Mon,  2 Nov 2026 12:40:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 234F4606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=IbY2Mi7u;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=ko2eZPdh
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A29CRaC4152226;
	Mon, 2 Nov 2026 07:35:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=r8Zw3pDbzt2XtV/9KWLgShPzNZh93bL1kQ40A3VxQOE=; b=IbY2Mi7
	u3Vi7oLKSXyE7YI3j+UsahWhU2YLR0/4AGEtNCNYpUawwPKs5c6MupBxxTCbwbU+
	+wJiU/m3jziZ9svaaoaxXWXpmxoDg8tbHA3YmssAEp1rc1+DqM7EFh75eRm6BDU3
	8K9YA+BJH8A/zQYeXnMujRcTusso4KRMpjKJ98qeqgM0Jxdow53e7h6V/sXlyuO2
	gjSTwAozPoNPJNOKq+rZDIhVhIiWItvIRvFXwDPEi+YZmjyxZEGD3W5gt/HX8Wtm
	V4+femIUYc9iBOWwFYeQzdRc+rBV4Am4O3xteSCND0kLpDrvgF4QTu23KwN8zk7e
	P88FksRlhoFlyGw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=r8Zw3
	pDbzt2XtV/9KWLgShPzNZh93bL1kQ40A3VxQOE=; b=ko2eZPdh60mAyziXV0Har
	UUxYYD9/oedyjjo0jDTcOPGxByUOWeHeZNWeDFOOoIPL0NTSOxD0f3LzDzZingZh
	cK2hxpHV8DHiVSem2JoA0RQGAp4ADuC4rAsHxNiLfpItyH8hsL9qupU3g8ADtHJZ
	cgpZelaUxSgtvHOi64G5Zp/BN4eNiVHFFbMNn51zmn7Cfn94I9v2bmjb/4h2Z7rw
	CxbNp6vl46S7UsFRxyoPj/Bev+pwB3XPPu3ul1AYm6ry3pc4agjrXj4I0XVuO7eA
	t0QFJfNYf+Y4s59aTZhdhnSwmFoF7pyHwX/9ZZwpO9N19+JWZD6NYn52B2tFEGWa
	g==
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010047.outbound.protection.outlook.com [52.101.46.47])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4hpjhat5dc-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 02 Nov 2026 07:35:09 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G4kQ37iPHGqADIsaZa4GtJuf/UO06thbHYmguwf/orcE2KOU55ZQrbplWYyC8b1fYGys/bVrz4UFkLirs8k03gDJsQX1Q2HS/VOGOvh9Q6urBDsXnozvtZxYxw8xDGI+v2xLOHlFk0INJNKsD1MEHQ+uBsTIgW87/RV0ubgThb2vOtXyOVBg8OqKDtbzAyoRWdEo9tUhW9WHRDKfv2SnY3tKEy0b355SMEPVKvO0P8Ot7pWeXavxWuP0V8MeeX5E7t81UOUYR8S4ltU1bkUv/WGmJ7g7/FdJQd/FxiMKjpDyf++HVVT1hPo56wtqxQwl4wB6CTXT26wJXN5z14hGKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r8Zw3pDbzt2XtV/9KWLgShPzNZh93bL1kQ40A3VxQOE=;
 b=h3Ngj4PsqIKhupS6GGEuyrIlX48BVfLL6WBCgEj535Se5zNoKip7kguhuS0Hi7JRWXS9O0KKiFIPxSsOIuyut0hHY2SjRm2Jsv7SHFmF+saNnDM5mwQdE801t9PCMd9SoovANUNFpIyX4l2R1li1IdPLyypUVg2jdngChhf08s1N/HXfVug7NRuQ+34kPBS3b26J6qaWCzGP+SBXuMfdsBPxp/NZmWPpNa04VqplpvHbSDX9RedJaS1rD01VDWWWYlVYu817ceTZx1WDt7KeZ/3tE/2vcvK7lf062pzaK7mMf8kDqt48qn862q08f07Xtn3044Jsit3tmc+uoQhLxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by SJ0PR03MB5789.namprd03.prod.outlook.com (2603:10b6:a03:2d6::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 12:35:06 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%6]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 12:35:06 +0000
Date: Mon, 2 Nov 2026 12:36:29 +0000
From: Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>
To: linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
        linux-sound@vger.kernel.org, linux-spi@vger.kernel.org
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        =?utf-8?Q?Am=C3=A9lie?= Delaunay <amelie.delaunay@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        Andy Shevchenko <andy@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>,
        Frank Li <Frank.Li@nxp.com>,
        Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: Re: [PATCH v6 0/9] dmaengine: Support bus widths of 32 bytes and
 above
Message-ID: <auiDhzNcif3LhPlq@nsa>
References: <20261014-dmaengine-support-wider-dma-masks-v6-0-5b3ffdef8191@analog.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261014-dmaengine-support-wider-dma-masks-v6-0-5b3ffdef8191@analog.com>
X-ClientProxiedBy: ZR0P278CA0008.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:16::18) To SJ0PR03MB5469.namprd03.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|SJ0PR03MB5789:EE_
X-MS-Office365-Filtering-Correlation-Id: d35f1c59-f0ff-479c-65fa-08df38ddb99b
X-LD-Processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|23010399003|6133799003|18002099003|22082099003|56012099006|261009221227099003|261009221727099003|261009220027099003|261009223027099003|261022105027099003|261021123027099003|261021121427099003|261009223327099003|261022075727099003|11063799006|10067099003|261026140227099003|261028144727099003|261026121527099003;
X-Microsoft-Antispam-Message-Info:
 0Vmm3f2Jx2VVrDuDTInSlhaRB42ZeKGpx7pvptwMR4bm10bR81D/kVeCQvLcevC3iGC7XGY2aNt2TBBtypX8qh3vMVFadER8QTAEow1ti+VZC4xdd4kwZjVNDmjtsGnqy2WqvlQKdAqesiU0mlvfNzuOAI/dH/zpOP/8yf7eLn4ZgdFgz9n8M4GzRM3pFUbQjMpu/RbwLUf0orM8R9KYUr5sOPSQ2FCDaVURlmMglMkVp1R2sy4R7sKWJcRZv7llfr4aS/hrG3p1pNauTyCffRn/eazEpPsPtLNTVHlhjGJlxXLcGm3x5lkA6GsOSz8db/lfIrSMnmKWC5LeatNEP66o5lTVPB5ZGLBLKlVPJjCIyUNi+njHc+BiREU3M83VXDwxTE0zlnwY0541U546JyC4ugLhyub6TQBQa6+ERHSQkP3ec1JPwNXEPEgxIxt2yOooe3F+S8YmBatYguw+wNDMe+HfY1momBczzIGSDUYxAmKWkz+HUXqOPcV1cUXdrbPZm7gqvntZS81iI3dbQhCIWRfZbGCQurhIe6KRDxCP0CemgBVt8uYtfs/RYP5egEkhrZJZ5G/j9LwrnFQItBJJFMVmKvxmkKQnuAtu/ug=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(23010399003)(6133799003)(18002099003)(22082099003)(56012099006)(261009221227099003)(261009221727099003)(261009220027099003)(261009223027099003)(261022105027099003)(261021123027099003)(261021121427099003)(261009223327099003)(261022075727099003)(11063799006)(10067099003)(261026140227099003)(261028144727099003)(261026121527099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?cnJDcTY5S2lwTEw0LzJBbW9teFpuMUEwWE9yTnhrMEdOUXJDT1laWUNVUG96?=
 =?utf-8?B?N3ZQY0lxWDZHdjNjcWNFSFV5OTh5Yi9TOENGS2lybnJsU2ZtQkVDeGFWQStH?=
 =?utf-8?B?ZnR1NjNjMDA2VThlSDVyclhldWpaUXM2V21BajAyRVF0WTBMU003dFJKL0xu?=
 =?utf-8?B?NVN5MThtNmFramZXZDBzUHAwYTNTOC9ibWI2a0hsL2J2YkpWZTcvSWMyYnln?=
 =?utf-8?B?QloybUllY25PMWFFTk90YWZiK3lsekpDT1JPNmp2d3JSSndwYmdHUUJ4Z0NM?=
 =?utf-8?B?WCtOQ05tMGJCeTREQjV5dUZuUXdZT2xqWDFPQlFCa2xNaG1WSkY1M3pzT1lV?=
 =?utf-8?B?ME8vLy9heEUzMHVLaTEzYlZKVEdMTjE4bzJhQXBmT0NiSDdrMk1xcndWTW13?=
 =?utf-8?B?VG5yRzY3Mzl6YUxJbnNqVWRtTndrZldxcDd6c3BIMUhnbDhXSXcrZE80UGwx?=
 =?utf-8?B?TWZlSWh3R2kvN0VoRkZDTkdwOGNYOG1NY1B3K1BvRzRqL1drOS91aWZabFY5?=
 =?utf-8?B?c200eE5xaFRDR2Vreld3akE0eDg2ZWxJdyt5MWZCYkVZUnBRa1N6RXdXSUgy?=
 =?utf-8?B?VEo3R3hYODE4YTRuQ0hlTlppbldEbUNZM3B5aEFqUWh6Vlk5dlY5UGE4REJG?=
 =?utf-8?B?MHBORWlrdzdwS21aUTZ5cmFKU2Rsd2ZuU3BYeGxWQmNDKy9GbDZPUTVaUHR4?=
 =?utf-8?B?N1dPQ0VtS0F0RnRmK25Ya3lLMzAvTVdVNlZJenZYTU93ZEZpNzQ1NjZqS0Ns?=
 =?utf-8?B?Mjg0ZVcrWERNV2pJM2VjNG9TZjF3OW8xR0RoMHZXWHBGMEVCcVFlNUdrelJj?=
 =?utf-8?B?QVpMTnFIV3lheDBIWU5UTytVbGR1elY3d28vUzE1UlpXaURKQmg2d3lQSHVw?=
 =?utf-8?B?RVpzWWR3ek92dTRxdWwzOXJnNVZibEFKS0xvenFGSTFGbElLUFYyZWJqNEx1?=
 =?utf-8?B?N1ZpUmhSVTdoMFlxbmNNU1ZOL0VVejM3WkQ2cjBEMEl3ckRqU1JvZjJMN1Qw?=
 =?utf-8?B?MkZGMUx1TjEySXV4emwzdzFtNU5GYmVzcUZ6NDRqdms2RkVpY0VvUFNRYW9R?=
 =?utf-8?B?T3JDb21yVHcyUTVMRFNXT1dMNktQRmw4RzlnaXkvTXB1N0kzZDZiM0xYVXNl?=
 =?utf-8?B?dFFlOXlFYlZBL2hBVG05cVc0TDZNN1duTGNwRldnWnhLRDlRcFZXSHpzOXlu?=
 =?utf-8?B?clRkUVNaUVBuSm0veWdRNU9xSHE5ZEljUTV4OG94ZDVVS1Rkd1EyN04vbFV2?=
 =?utf-8?B?Q3RiOEFuZmVHWGFRMUlMcDUzdlhNM3NLc2pBampBbVV5bnJWblJqa1hHeFl4?=
 =?utf-8?B?V2UyemlaSFhaWGhERlExR0I4WFR6SUhXNHhLU0N1Z3RSSkxydFgwZ1VScTJl?=
 =?utf-8?B?eHZIUkVRUzh5Q0NUZDgzUXdxYW5rWHFZQUs2dUhXRVYwNjFWb3daK0d5WlRO?=
 =?utf-8?B?ZkxqOTZDWW45d2xQSHAvY2UwTWhZanI2Wno3dklqWVY0aXpsREg5T1Q3TXpR?=
 =?utf-8?B?T3lnS1l3czdzbUZUUUtYL0dmTGx1Y3VaUU5yVm9QbFBPbCs1Q01xMjhTUS9U?=
 =?utf-8?B?Q0xSMFB1UmhMK016eElSRnZ5TkxQN2NwQTN4UVJpNVFOVTB0a0F2dHpONzVt?=
 =?utf-8?B?aVJXK01nYlpYUVo5bFhNSTZjTHZScVVQOGorRW02bDcvSmVKQXNpVFVWak9F?=
 =?utf-8?B?c3d4OFF2UWV4TkZrdEo3RXY4UTBaeWNyYitmUG1OcjNNc2l0ajNvdXg5dXp0?=
 =?utf-8?B?MS9SUDBiQWRhQ3AzV2prbmcvZkpEQVd2REtpYXh0WWI5azNoRVNLdUNvOGNB?=
 =?utf-8?B?enBWMGlnTkZ6RDI2cTZxQ0xVVTVxSmlTc0hIUVkwQ0FGY1pYeEhhZHBqdm9h?=
 =?utf-8?B?d3d1QlY4TXh3cE8yaU52cWY4eTFvdUFEN3pjdzc5K1ZzZEhoaDEwRy90cXl5?=
 =?utf-8?B?eTVtUFNoVDhBeTExUnVJcGRPZ0tHakdyLzdLTE0ybDVUNmY5Z1AxK3BLMDh2?=
 =?utf-8?B?QjREdnFoUFNYT3lxVHI4RWx2M0J6UGg4ZlU2Q1FnUXgzV1dYVyttMCtnM0t2?=
 =?utf-8?B?bm9CblZtWmxXSVBqOE1OaXdJUitEZzYwNkVrdWdwUlp1R0hONWVISGpJQTlW?=
 =?utf-8?B?SUVkRFVteFVKQ1dhMHVzdnplOEhDOTNBbUp2L0IxS3BQRThxbk8zWlFnY0JG?=
 =?utf-8?B?RzJobVdlanRDcVgzOHZGWllQSnJXMXJpbE1PRzcrRWpNWW5rcDN4VEh6SVZq?=
 =?utf-8?B?KzFoeFVua3JBMjNZcExjUERCaFRjbitWbjFPbjkyYmZOMGthd045N1kvOXc0?=
 =?utf-8?B?U0xBRFZSTVhqZWR0a2RQL1ZTdks2L0gwTnZ4dTdJdHVkUjcyLzRjZz09?=
X-Exchange-RoutingPolicyChecked:
	BJEqOHP5+yhDUYciZEhO7fuGVoM0pxEns8hxNxTAmq37WsCNcs69YW2IC73LGIVkY7kcKxa79voAxgvZN3fTKLtglCzXUX1J1NCGfVQG4MrsjZax6aRVimjldcx6Eo+v2m2SzfDjzt2Xp7p8iWKrAMobYOYz6yQ7Yo6yjbQItscwqWjXMnYCRTz9FTE9lzNoQLM773YB7ma3ztENDy2IDcrxawUCJrmstkSXtMEaPJy9eaw4qNVgIMkOyco5HqUKAx3tTdL/HpL/ohGMvR5zJ2M+LrG1mztouAM3d+mPSUON++iL7GeqI1zT6PMrdrJVUEsqgvEdly7NKp6sblpRgQ==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d35f1c59-f0ff-479c-65fa-08df38ddb99b
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 12:35:06.4021
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DKg+jzcrPLDG3r3F42bzqHuD3+MA8uSu8OYo6XSA9gWagjd5o42IUAAqnAAUfGgUXcsi5u1092RjsFbOYxcX/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB5789
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDA0OSBTYWx0ZWRfX6jWeVezjOQHE
 uMmmCorON0jgBPyoJpVTG9f+DWMuDvChYMebw3QDHWJVfAoNYCxxvFFE7EBlM3alBeKWMVpzcNZ
 5gpl42+mg/Xukl7Sep6h/5LmwI6Z80JXZ4qRkqpmM1lI3WBGNlQA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA0OSBTYWx0ZWRfX46kk3+P3j777
 pOwU6Y3t3UENt96Aq59fM61HMf0RWjsSHPtarNrrpm727XvWntZJtJyl2EaYHdl6LUxqZkChqez
 6+KAEF6yLVTg8ETgGS6gvzhYQHYGHTotF7ECjy7ghgzwbKPexcRoUKQMlwrP+RAkJKjuezYr80x
 +EWbLU82tTyEXD5+f8OzayVnXNv+Il8uAFM8lIxp6DgBxaQwV7KfOueeziWs0F5ZX8jBffG8Sqh
 hMk81lCOISVLBKqEhq9oRSZWrowMa4AqrJy211hKcF0phUpcHmkSgJpJTAUcBxYCNiOVWr5bqDU
 78LD+uWYYdaDgEbfwTjZldvCMDx8rcxk7+JkAGKVI4t+rUewyiGvplCQfhg8lErd0zfQM9UNby7
 GWtvLpazQ3Z3nTRe6ANpnQnwLcIE6i04/jd+lYbK0eveHxqOHCtgqYniaM64UtHE6P+6u9HFgc/
 tDlPusQIhkhPZR6cYKw==
X-Proofpoint-GUID: Y3NkQJ3EaZvmhMY88tHr8bOkpboJb3kl
X-Proofpoint-ORIG-GUID: Y3NkQJ3EaZvmhMY88tHr8bOkpboJb3kl
X-Authority-Analysis: v=2.4 cv=cbtHPXDM c=1 sm=1 tr=0 ts=6ae8837d cx=c_pps
 a=jlQ7B5VXLElZiQQO4hIw4A==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=Z0pTeXoby7EwIRygza74:22
 a=VwQbUJbxAAAA:8 a=bC-a23v3AAAA:8 a=gAnH3GRIAAAA:8 a=YzQNDb6hcuZkokZpYvcA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 malwarescore=0 bulkscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611020049

On Wed, Oct 14, 2026 at 03:19:10PM +0100, Nuno Sá wrote:
> The DMA engine slave capabilities advertise the supported source and
> destination bus widths through src_addr_widths / dst_addr_widths. These
> are plain u32 bitmasks where a set bit's position equals the
> corresponding enum dma_slave_buswidth value, e.g.
> DMA_SLAVE_BUSWIDTH_4_BYTES sets bit 4.
> 
> The consequence is that widths of 32 bytes and above cannot be
> represented at all: DMA_SLAVE_BUSWIDTH_32/64/128_BYTES would need bits
> 32, 64 and 128, which do not fit in a u32. Hardware with wider data
> paths is becoming common, so add a representation that can express these
> widths while still using enum dma_slave_buswidth.
> 
> This series switches consumers and a small set of producers to the new
> bus width capabilities, represented by a dma_buswidth_mask_t modeled
> after dma_cap_mask_t. The legacy dma_device u32 fields are kept for now
> so the remaining DMA controller drivers can be converted incrementally:
> dma_async_device_register() folds a legacy-only producer's u32 into the
> mask, so consumers only ever have to look at the mask.
> 
> Once the remaining producers are converted, the legacy dma_device
> src/dst_addr_widths fields can be removed as a final cleanup.
> 
> This issue was discussed before here:
> 
> https://lore.kernel.org/dmaengine/abkoXXbaxaiqbBuX@vaman/
> 
> Changes in v6:
> - Patch 1:
>   - Prefix the bus width helpers with dmaengine_ (Frank).
>   - Drop the wrapper macros taking the address of their mask arguments.
>     The helpers are now static inline functions taking a
>     dma_buswidth_mask_t pointer (Frank).
>   - Drop a stray blank line in dma_get_slave_caps() (Frank).
> - Patch 2-8:
>   - Use the renamed helpers, passing the masks by pointer.
> - Link to v5: https://patch.msgid.link/20261009-dmaengine-support-wider-dma-masks-v5-0-4c4e63a7a1af@analog.com
> 
> ---
> Nuno Sá (9):
>       dmaengine: Support bus widths of 32 bytes and above
>       dmaengine: dma-axi-dmac: Use bus width capability helpers
>       dmaengine: dw-axi-dmac: Use bus width capability helpers
>       dmaengine: qcom: gpi: Use bus width capability helpers
>       dmaengine: stm32-dma3: Use bus width capability helpers
>       iio: buffer-dmaengine: Use dma_slave_caps bus width accessors
>       ALSA: pcm_dmaengine: Use dma_slave_caps bus width helpers
>       spi: dw: Use dma_slave_caps bus width helpers
>       dmaengine: Drop legacy bus width fields from dma_slave_caps
> 
>  drivers/dma/dma-axi-dmac.c                         |  13 +-
>  drivers/dma/dmaengine.c                            |  23 ++-
>  drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c     |  39 +++--
>  drivers/dma/qcom/gpi.c                             |  11 +-
>  drivers/dma/stm32/stm32-dma3.c                     |  37 ++--
>  drivers/iio/buffer/industrialio-buffer-dmaengine.c |  15 +-
>  drivers/spi/spi-dw-dma.c                           |   7 +-
>  drivers/spi/spi-dw.h                               |   3 +-
>  include/linux/dmaengine.h                          | 188 +++++++++++++++++++--
>  sound/core/pcm_dmaengine.c                         |  20 ++-
>  10 files changed, 289 insertions(+), 67 deletions(-)
> ---
> base-commit: 42c31fec1ca76b8b5f7759def122d418dff2cd4b
> change-id: 20260615-dmaengine-support-wider-dma-masks-5aac12497e27
> --
> 
> Thanks!
> - Nuno Sá
> 

Hi Vinod, pinging this one before resend. Already got the rb  tag from Frank on the
first patch. If anything left to do, let me know please.

- Nuno Sá
