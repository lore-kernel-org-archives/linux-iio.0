Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6713A4A206A;
	Fri, 11 Sep 2026 17:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789147773; cv=fail; b=bHhNJXCxZwQrKCULrH9scpSbROIlCjk5PpMvkr0TOi7hWCkObSrN/PDmU3U1k6zDYtrVd2xaCJkAhQVb9rMi1eZMiNekVhgaaywNYAo54PFZJq5VEKwO7WOwAe9qMwLyaI9MFzvBt8d3pbf9eBuNX2JJR3dwcwiFrtWk/x2v2/U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789147773; c=relaxed/simple;
	bh=wst0ZIUBRODUkfrbgY/rvym6W5SBHIZCofay+FzSDa0=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=lMdJElTE3/oXRphOY3jia43GEeyvnDWv0ttfa156PD6UcAAweDYefwv2fw+d55n+0s3cH6kW8IzbpEhcEtqpBXYTZqBvQ4rbuTSnYUwU3H+72lyPfDV7jBogxi1dA1E1hTGJmDrE6KB++ZGx+ta262SzSrE0ivLdNrQMjdQvqKU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=e787kCFx; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="e787kCFx"
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68BEin2T685441;
	Fri, 11 Sep 2026 13:28:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=y99hB
	n7LKG+sZeM/8uW3+XnQwWBi33FWFw+hj8G/nJc=; b=e787kCFxfsCjLY2Erww9Y
	u4q2MgJ+xHXzZ8vPNEW5flPsVnJ0SvHFDrSyVVrHRP2MX4IkYho25Hf/UlYPcMdG
	lxjMoSONEG7h5is8dnYcAZjoC000Ys9P6raKuQP8FV4ghJLurIJtwDmEBgjR/2nO
	ATbBWFyDw2ofapAZAnnygI9sTtamgqMLd63oh0N26Bmua6GW09RHl7iKhfEH8vQO
	UAlfSUJ4lbMVyq10AMpEoa8ULPQzCsFFWde+iDsPBztVW99Ez4n9RzDUIjpsyil+
	TES99auGbu7me+zr5ekcETqgb+k6Hvuk7u+1sT7sNxH/EVxlUhKIGj3FOLzPeX5W
	g==
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010022.outbound.protection.outlook.com [52.101.46.22])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4gkcx8rfun-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 11 Sep 2026 13:28:58 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S2oGXykFxrqPDc6XLRMhW0fyzYUnB2sWiLnG5d2L8UhP+jdLveltPgkVmAPyvgUB7G34mulRRLocsMk/BcTVCe3P2IGXjBqMg47Z4xJf15X4GQumnAR4FDQUnv/qiqoVwisaUUAyl9kqYNkTPpSAriIIBz7twVSU/44y9UA3fI7cTdOinq0AxRdijUolLZ5Vv5pu7hkYqBwFArVW1bWavpkjE3NC8srFZ/5vTOxKsHEdglPVTyI/upzD9VOWwOmpIggSEo5f7/S8rQXIUeUSH5ah2MVf01X0kDf5AjhrnpSWHxfjZ5a0piqlQiPi05g0HE4IYS+Ht/tXHBhK3uLpug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y99hBn7LKG+sZeM/8uW3+XnQwWBi33FWFw+hj8G/nJc=;
 b=qLcNu1sGmdOhcE6niWF7RCL+XJmCBSdmjsdrkMmyF4hYkYMX4zgw6RJVWKyDiKYIomlPCc5ChWqBaCVuDuVFtyGATs0cMVDR0oi2ri5SE8COXwqSnLwolEud7E3rG6DqoVyZT46qaUsdA1UXfCS/+JBj6ZSxJ99cutO6ZMP/t8IagcAj7fY1r/Gk8lNS0eIvy+uUMFWsL5JdFXTyQ7R8+sc5SMu7mN5DumGAfRaJCKZcdB2jXp8G8sDkE/U3thvbKVN90Yttnphq76JvTTu6kzS5hWnz1W8tLpOc6aMlfTTHTCUpg76XhhVZ4ii6sX+sdkEdS7Qm+anZA3Atuv/CxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by LV2PR03MB293829.namprd03.prod.outlook.com (2603:10b6:408:3af::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.10; Fri, 11 Sep
 2026 17:28:54 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%6]) with mapi id 15.21.0406.007; Fri, 11 Sep 2026
 17:28:54 +0000
From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Date: Fri, 11 Sep 2026 18:25:38 +0100
Subject: [PATCH v4 03/10] dmaengine: dma-axi-dmac: Use bus width capability
 helpers
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260911-dmaengine-support-wider-dma-masks-v4-3-72b8fd4cc78e@analog.com>
References: <20260911-dmaengine-support-wider-dma-masks-v4-0-72b8fd4cc78e@analog.com>
In-Reply-To: <20260911-dmaengine-support-wider-dma-masks-v4-0-72b8fd4cc78e@analog.com>
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
        Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789147798; l=2064;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=wst0ZIUBRODUkfrbgY/rvym6W5SBHIZCofay+FzSDa0=;
 b=Gih9kjSWiO+Qw1NAf5MyxoNt5peSoh+OpHbBhmzEE7p5H3/JHgNUtCiwlCAAPwMGgCIQkt874
 0++vS7rgpQjBZrd+ZlpNeUN7AtNkRtQfaPYCIR+ctOpU/slaE4L5SVR
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ClientProxiedBy: MR1P264CA0163.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:55::10) To SJ0PR03MB5469.namprd03.prod.outlook.com
 (2603:10b6:a03:28a::17)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|LV2PR03MB293829:EE_
X-MS-Office365-Filtering-Correlation-Id: e570e9e4-30f2-4632-741f-08df102a2767
X-LD-Processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|7416014|10067099003|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
 9QNV00zYY8ZUolsQzMbC8eRsuLhupcv4Exls32F7uhD4JDQnb9V1xKzslwj84rgQKHEOm37h79MjGibSNofGhLgCPC5n+T7k19mKscVKD6X4LFxpToA0b5YiHG8rTM3pZ5rxRqtGKbvw8Ndy5XmhzQA2oFMomGoTuyUsj/7/yaAh9cdaDFShmb7Mt3oCCire6Ejlor2XY/vZW2ID1Zggzr7R7S5AzOd+dlxVKkTd8CVrv3lZpdoRBLZcl7skEhmCY8wrNIGz3DIB+4mzE2n/6GJnpl3ecpBQxccqDtQ/QYoMl2O9cQ8q0brzvlR8+Iqgip3imiY5ge07zWF10TT85ARnwFPa8dWUm2yg7rrAt0anEHLlzzohDsCxiJKIh0qDGee/evnNSOvxblu97kkGcwVMdm29huog/qst5874A08yggXEscyJtgH/gS/NmM0J0ITP5p+ZiIoTXBc9Gm9tLnQahb+FVlI9DlwwSSPro9NZWHTE0yCzfvG/HEU/r/hL7H0VpBaqFTMcyIKREpaZst+ActaAzqycnHVCVK+/6c+EtqoA0xQna/1qxUyS3xTnajLDOCMthSBCsLkG/GObChmzyq8GpogMjrcP792Sq3SEPLWN9ZjoVqjIvjme7o+asA8Q0YChOoDaAMsRDCrKKHpEp5lfcgZHZmXGkDdGFKs=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(7416014)(10067099003)(22082099003)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?aE1rQlFianVlclVTYlFVbGs5YlI2ZjFWODFTcytEVjZkN0dXUzUxZlZwUzZo?=
 =?utf-8?B?a2hxMU9CWEZUTmpraFV1S3hVeXlpOTB6SGhmNjRMQUNLVjEyYmY3a0NLYThO?=
 =?utf-8?B?ejViTVZ5SzhJaGplNlBWTk5WQjFpRVF5Q1dxQkhOWHNyZWpoRW1YdFlhTjhh?=
 =?utf-8?B?cUt6dVhZYWtFTkYyWlBrdU9sU0QxeDkyTUg0MGo2V0pOckdWZGxUbHAvb0JC?=
 =?utf-8?B?Yk1nMXJ5U2ZJZnhGbHZvdDJtS0VYRk9menVVK0Nxa0N6QUZCS04xSU1uUjNG?=
 =?utf-8?B?eDR3eGl5ZnoyVk9McWNQdm9YbldGRnE4Q0FJaGtmY2xFcWVrV3QxSEhYWHJB?=
 =?utf-8?B?ZWtNZkoxd0xSMXJkeWNCc0JXNXFIV2hxVUQ1cW1pK0hoTHZRdFJUQWRIZWFG?=
 =?utf-8?B?NXVCZ1NoMURUbW50aDAvYlU4eFh1R1hId3RGZEpHNHhjaHpkM1FMTnNrdW9m?=
 =?utf-8?B?Z25JVUFNMThjbUFqektnZkVrR2tENDZUOTNYSU01TVBROURKbXlYZG9uVC9P?=
 =?utf-8?B?bkgvMkZ5M0JoWDRZL25QMENZN2pEcFNxOGJ0WE1XOXdtcm5qdkRlc3Y1OVhM?=
 =?utf-8?B?bjVwUC9nQXB4RjJidjVzNFd1c2FWTVhaOUVWUlYxK1lWRldhcHVWS3lpZi9H?=
 =?utf-8?B?ZldmNFhrazRTRWNReGNVU1hTTUwxMmNRSWhUSFU0a1N2cWo5UWJWcEpGYlhl?=
 =?utf-8?B?czJxN2dkaW1JSDRJenBEcDIwQzVUL2dtNlBQeTc1cFZwOFFGbmp6azYxWWIw?=
 =?utf-8?B?NVlNWEZybDArVC9EN1NkMXdxRTcvNU5tZVhoNEh2azV5V2RVcGhrbS9vZmE0?=
 =?utf-8?B?M0h5SnlXKzhEcjh4Nkh4WXc4ZzlVaUxQb2QwSVgveEhsMVFiWGJabkhLaDhY?=
 =?utf-8?B?YnZLSEpOZUhZK1BMbndLa3NyR3BrZUs0TFJXbXkxRHdrZjJWOVRNaXdad3ZL?=
 =?utf-8?B?bmxFQS9QVjZ2NDRyejZFeFVaR0pQRmg1Rkd4U2Z2K0RzVFg0a3cyTFFKK0VX?=
 =?utf-8?B?enFhcXArMkNTa0RkcFUvVGlTRVpTL2hPaXNVQWF2Ylg3NlQyUlg0aGRsYUhB?=
 =?utf-8?B?aWxDdlVSMHgxUjAxOHltT3pBVEVhc0FjcEw2V0k2K1BMVVNZeFcwdEI3a1pS?=
 =?utf-8?B?czNUMFdFT2x1Y2trNjVkV0NZM2RQWDdxS2JRdnlVNVJhcndzT3VxZFI1QXgz?=
 =?utf-8?B?VlZMNVZDSXhlZEU3cmVxdC8wb1hEdTRDVGVSK0lNeEpxZ1YvMlkrMThLQVZF?=
 =?utf-8?B?QXIxdW01S01USGJKaERxVGIweXFaVlRONnhoaGt5Qi82eVdlbzV1U2NiNklW?=
 =?utf-8?B?QzErUzM3ZXo2RDR3OXVsTkNheU1JNW5iMmFTZUFJK0h6WjhOem9RUFljQTgr?=
 =?utf-8?B?b1RwempRaThiTUhaZHViMzR0TFJDaVYxM2ZrbEV3cUtVazRuMTNsTXFBV3VL?=
 =?utf-8?B?aXRQVVpweXl6cytEWFdCMW93cUhFVkhlU0hrOHVZdlU3YXRnUVpMMURWUmF4?=
 =?utf-8?B?V3Z3dndhWEMvQll4amFqbm9xWVJCVUpueVJhMmhUdzM3N0UrSGVBZEsydUhT?=
 =?utf-8?B?TmRRNHkwMHo4eTYrMEdYNUxKbUtIaldOYzU4R0orS1NaejNnZU9DSUc0TTlB?=
 =?utf-8?B?TFdjUDdWcUY2S1BJN1FxdCtDSEpVTlhTVFRsR3hpaDRsZ3cyWkFrUXZHaFpr?=
 =?utf-8?B?Vi8vM0lSamZ2cXhpaVVKSkdCbUZyN0paMk5oQ1IzV2g3c2lkTEZoNWhQR1VX?=
 =?utf-8?B?ZkJ2V0dLTG9PMWtPdVpTNW9nNnZvU2NkM21GK0VNbW9SWmxrVmRHdFRsY1NL?=
 =?utf-8?B?ZkNoTUVNT0wzcC9EbU14cUowNkcreEkvN2tkZStmcnBEYzliamVGRmo4enNi?=
 =?utf-8?B?b0hjbXBLem9pTTRJVVFpNWRWZ0R0WDFsODJsRkFDM1hTUjUxOERxd2pxNVpo?=
 =?utf-8?B?d1dqL1ZPVnJJbjZ3ZG1ITkhmc3lINU0veCtyMTdkYzBGQVl3cld4S1JqNVE4?=
 =?utf-8?B?dmFOdWdVSEFqeFp5ME5EVVlMVm0wZGJ2ZVUzY2JHd1FtTDZRTnNXdmd4dlR2?=
 =?utf-8?B?cVFDSUN1MlBWWmFxbndPQktXNUpjVVdBMktGZm1PTEhRcjYrODRSOGpZT3U0?=
 =?utf-8?B?eUo1T2tiSXVPSklYR1ZmeWFMbWpSQi9lc1oxWFBSYndadFNHckM4NjJoM2Nr?=
 =?utf-8?B?Y0IwN1ptRTZnZE5YUjVmU0F2b0d5b1dra3BKdEdUdzFCbFhjTFlhNmtqNGlO?=
 =?utf-8?B?MExkYW0vdmdUWXFjbXpQVGJZMjZsV1dXMndXMEZqS3Y3WnRDMHk5b3lzeGsr?=
 =?utf-8?B?TDFuQ21OSnNFOUdRNGQvMllZQUxEaTdPdTdVN3ErSTRId1hiZ01XUT09?=
X-Exchange-RoutingPolicyChecked:
	pwGP4WJslOFQYKVuPSaz2O/SmBvxY0R3Zq4EmXyxHbzrmVi3sAkMANY3SAdh6lBxYcFnfFzqindqVKKg++fppYbT+m2LZ2Oi4PAXQ4gmOV1i+iSRprmVhFb/wM7RkcxQQAnPX7pV1IXbAHmJJqEvW1BSo3tsf6u7PSIxXuDYtQEWLzUYgS7/O5NPhzjhmU1CwMqK4kGH9V6+8xeDJWF+If0ozBmmADD2GCvLigiI7sZJ9rB2TuYWTOqJT7/INdHmVPeB40OmEGzTLWRYR6KoIl/T9xMXt632zPUXyy1qZ+TaBFZaMBJSBgPPLq3swm9fn3JMU+Wi2ayV7MNhTYM3PA==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e570e9e4-30f2-4632-741f-08df102a2767
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 17:28:54.8286
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MwLJ8P3d0zYLYt8iULFEEP136Sbv/DGCbVhZ/Yzeqw4i12EIt+7q8q+85mSQtSt7uCWOmhGmqI7Jg/gsRNZz/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR03MB293829
X-Proofpoint-GUID: 39i4gTTndBgDnI2AFJgCaIHzDwptU49e
X-Authority-Analysis: v=2.4 cv=JaApPkKV c=1 sm=1 tr=0 ts=6aa43a5a cx=c_pps
 a=QRdqWuRaZ29IqTB7rU1R+Q==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=_jAD5XSDOtq9-5Nde2OG:22
 a=8AirrxEcAAAA:8 a=gAnH3GRIAAAA:8 a=Qd3EMPMlLGY8qSusABcA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=ST-jHhOKWsTCqRlWije3:22
X-Proofpoint-ORIG-GUID: 39i4gTTndBgDnI2AFJgCaIHzDwptU49e
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTExMDI0NCBTYWx0ZWRfX/3w4qXVph2rF
 uY2U0in5MhscenhTWyEUg1u5KVz96iI2gedkbiX42ZerBSqLm961ktUO5P+dnHhLlmWDKI0Ij2F
 rH3BJ/tT6sCTLSrFsxs/0Ek7tLgjt7C0zVPyNgm9IGA9LZcBTwdW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTExMDI0NCBTYWx0ZWRfX/72ylJXKE54U
 R6iBkIhLRnMRo6P7NMsKNQ8C1WI2DSm2zttVFyz4OFB0X8BZpkhTCExYYzHvht3wU9AzgUqS/io
 /YEPrCs9sk8iIJtpiIEJVFE2NqtnMUICnpU6t5QG1QaaU3Flmjxt9cpyK5c3Evi6MyY3KF5U0Q+
 n3MSUaFi4wEwNAWbJMrqyHf7FKxzeRPkdq5MjtKO2dSpqeBRFN0Yp5KL9rGTjA9OwneAZ+JIYU5
 VbRh4ds5vTN6M941tCSbTmkioGluDmJs+w9gobGcWZuft1/KXtAFEcc/nZf4czllUJ7FJ9SlU2S
 qAbAQjVvdaApEFiEvMvb91R5z4Lkh0CZ7ZK+XVS2D28n5Ax94x2mAPfyuEm9KJezcWv1YR3XkPD
 wbyU5qspwG0Ct+X2IowQK8jvL5qCESc7V3QzXKsm/sC9H+qYQVkifeB2YpJM4QewMTOHn+Budht
 x/w6IjVLLT3a+oZCIeA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-11_05,2026-09-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 malwarescore=0 suspectscore=0 priorityscore=1501
 phishscore=0 adultscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609110244

Advertise the source and destination bus widths through the new
dma_bus_width_set() helper instead of open-coding the legacy
BIT() mask. This moves the driver onto the representation that can
express widths of 32 bytes and above while keeping the legacy u32 fields
populated during the transition.

While at it, give the channel width members their proper
enum dma_slave_buswidth type.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/dma/dma-axi-dmac.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/dma-axi-dmac.c b/drivers/dma/dma-axi-dmac.c
index d47ff27e1408..dc56178cafe0 100644
--- a/drivers/dma/dma-axi-dmac.c
+++ b/drivers/dma/dma-axi-dmac.c
@@ -12,6 +12,7 @@
 #include <linux/clk.h>
 #include <linux/device.h>
 #include <linux/dma-mapping.h>
+#include <linux/dma/engine/widthmask.h>
 #include <linux/dmaengine.h>
 #include <linux/dmapool.h>
 #include <linux/err.h>
@@ -152,8 +153,8 @@ struct axi_dmac_chan {
 	struct list_head active_descs;
 	enum dma_transfer_direction direction;
 
-	unsigned int src_width;
-	unsigned int dest_width;
+	enum dma_slave_buswidth src_width;
+	enum dma_slave_buswidth dest_width;
 	unsigned int src_type;
 	unsigned int dest_type;
 
@@ -1262,8 +1263,13 @@ static int axi_dmac_probe(struct platform_device *pdev)
 	dma_dev->device_terminate_all = axi_dmac_terminate_all;
 	dma_dev->device_synchronize = axi_dmac_synchronize;
 	dma_dev->dev = &pdev->dev;
-	dma_dev->src_addr_widths = BIT(dmac->chan.src_width);
-	dma_dev->dst_addr_widths = BIT(dmac->chan.dest_width);
+	ret = dma_bus_width_set(dma_dev->src_bus_widths, dmac->chan.src_width);
+	if (ret)
+		return ret;
+
+	ret = dma_bus_width_set(dma_dev->dst_bus_widths, dmac->chan.dest_width);
+	if (ret)
+		return ret;
 	dma_dev->directions = BIT(dmac->chan.direction);
 	dma_dev->residue_granularity = DMA_RESIDUE_GRANULARITY_DESCRIPTOR;
 	dma_dev->max_sg_burst = 31; /* 31 SGs maximum in one burst */

-- 
2.55.0

