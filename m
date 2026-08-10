Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 369353F9A1A;
	Mon, 10 Aug 2026 15:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786374394; cv=fail; b=gLNEJWCq7soDNyKyBtfI+lCT6Efl9UXNMiLyUV9h7RrEEdMTO4T6SigfoSXC4q7fGHFsPf6b4dms6uuOVCuU91S9LWKJoU9hwGO9mhjCXY4O/YgLSkry9L8Yl4QPM0Yo5ilWuzbwHW71sMjLhc4a8G5/I56Uk+eTGWJwpu7Baog=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786374394; c=relaxed/simple;
	bh=10WMqeNN4p8gDS+uXTcJmYAJF1D/SxIv26YrQdN0tKw=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=IaS9134ae4+wD8NLQWyob0G2ngXY4xNiImhKavPDVqcrDo0k0juzhgM4VuT6RnUxxBsb1Qs1YeQlG796t2/3gHjNQjuXZroMwUGeiOGc9g8Jw5y4Rp77wcSL4YpC1OxGs0NHArJepeIkp4da1tmJQQVyEs4CTGn2mnmgqSRBXew=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=FeiWosnR; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="FeiWosnR"
Received: from pps.filterd (m0516786.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67ACsHLB3474289;
	Mon, 10 Aug 2026 11:06:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=y55dc
	2QafncOp3yyeKUBCkZ42L/+vi5bqW9T+e84t+4=; b=FeiWosnRublFHokLhoy4u
	qsVT/BADvTtwTz+1+LW4eG1OPTXea0qzVLf72+atWsZoyM9zCg63ydPU9PeJDBt7
	4dmbPOMNwtAnB7x5vHceMjqoQt8ZrNHVdMWaPowYtS/8SiEnKZxFfoLb+Dkts3ji
	gh+pQ0G362YiLjvTS30bZrC+0AWxd7JsARnP5A8z0O6N20rmur+eTenETLUYgSBq
	uwYLuhBgibyvH4nr1zTqNMpuz+P6FjbQj+3OfToeACvTX7U4lWfZv70HS7ftzr/v
	xyhRD5oOIWpacvvnklN7aORbAP1F8DjQ2D0+27H1bxSbdhqu9XPE/85nbdtuVFqu
	w==
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11012040.outbound.protection.outlook.com [52.101.53.40])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4fxn2jbwfm-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 10 Aug 2026 11:06:01 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BLKxlI4RIwQvnzET8jq5K18VtMqVThx9Kfyn2VTKOcSSUVZp/z2ljl/C9jGFU+QLvYIwpSISBSnNDtvgMnf65GAL7pHvOJsqgj8K5DI1G7npzcBTofUX4xA48Ly/NpmVPefIGgm+2o/Z+BPbmIed++1wjtpaN4AIB9TlxE0VYJCaC6Vfsj6qeqIuQVAdngdnoBUh+K6shniAdv0nBD5GOJuesnf/ulADKUFF+gmnSfViwrjMK3/Vttn984ksgPxvvYAJKFpnsSiBimmdFnFBpa3aEWhrV30nWTblEupGh8btv8fwjBl4gRmi1TtZJhONF/Bj//xF7vCoxiOUKATTpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y55dc2QafncOp3yyeKUBCkZ42L/+vi5bqW9T+e84t+4=;
 b=uQmJrHU4mJeIs3W6WFqqi02TVBCuipep9ZD0TkvuI+5T8uwV9l29y2uxn2gUi4PhpkqsfprVO2dW5J04iVd2zYYw39T1gPHHojooHvr/kMKopNCHiNTViNegHysQ6GGlYPT8fn8WE7MrojvZKzifuW6DI4hrHRD9JsXW0b6feH+9ALtZD6H5sVDRSMCXJ6HNyGU7VZ3j/8gKXy8zIsSjARuCM0Vcr3u+Ni3SPJOe+6jNpeEXQgCzqQJwIGMhDEGnxdqqbL0uPpHTY8jdsDWhVHjW9g2zK0p3eFzn1TOTAiHGw9Jks1XO6JXrGQLNCrjL9zULV4VocBqpPxPqBOCn4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by DS7PR03MB8170.namprd03.prod.outlook.com (2603:10b6:8:266::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 15:05:54 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%6]) with mapi id 15.21.0292.024; Mon, 10 Aug 2026
 15:05:54 +0000
From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Date: Mon, 10 Aug 2026 16:06:46 +0100
Subject: [PATCH v2 5/9] dmaengine: stm32-dma3: Use bus width capability
 helpers
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260810-dmaengine-support-wider-dma-masks-v2-5-1f7b798d035f@analog.com>
References: <20260810-dmaengine-support-wider-dma-masks-v2-0-1f7b798d035f@analog.com>
In-Reply-To: <20260810-dmaengine-support-wider-dma-masks-v2-0-1f7b798d035f@analog.com>
To: dmaengine@vger.kernel.org, linux-iio@vger.kernel.org
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        Andy Shevchenko <andy@kernel.org>, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786374404; l=3084;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=10WMqeNN4p8gDS+uXTcJmYAJF1D/SxIv26YrQdN0tKw=;
 b=Lmrg0JoN+iOtAJtiTTZuZ2uu98U1ML6fAtyh+21N2ooSEXPy1R2m3zXjLTEc9SELSvbFCOwvn
 wMC9spXnWZ6CFH5t2w0H7RPiBDZb91KLqCzPEfTdC6UnHzxeFqCdVlx
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ClientProxiedBy: MR1P264CA0086.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:3f::31) To SJ0PR03MB5469.namprd03.prod.outlook.com
 (2603:10b6:a03:28a::17)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|DS7PR03MB8170:EE_
X-MS-Office365-Filtering-Correlation-Id: cddef810-6f68-4419-68aa-08def6f0dfcc
X-LD-Processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|6133799003|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
 bccTS+6EL22tPEUSRy1d4UBq3OBFpWlJGF9gAxnV26NsilLr4KXnnaixHLqfHGqPAssh4Xx/dpAgns031jm7001aXrdA3W4SDXGTe7J200MRmG0KgLwpUCJ3Ps7Dh6BqKosy/738XfPCBYOKoMKCKEvufY5bWG0lXdHvAUpnbx/z9D/jHWAnuZq7tGf8agmvSKHRCh2Z1zK51O4UkFQh9t0W69HKted5xKoCdJ9veeHJ7w9PJt7n/+6hLcPr36M153zcefMSKMuD/C7WR5kELILFV9U1XjPSqmVesuYD6LeQpcFouoq7dBCMwLMqdB5hC8obI/whoNuWJQzb41YcDtMD5KRFBDGBMf1oVyU7Ce8Agg5MDjQy125rDH1zZuprL+O3WscarmkQ7D6iqC0rT6off2ZMqST6BRmaZYtXsRunalRPg0yHN7tw4H+ltEH7etT13on2zSUubGRGrKmF1eKtFL0O4pclBYTS635oW1Nn84dpGOE5cXw44Ty/twgiM5+nQuUSGW9HaXwSeGl0zVk7cU0jGRmYEI+sZuoyaYs2mQcwOusXEg388QpV6iiBQWSH9lM5NJ4WclaTVlvDrtpRFHPzqnroH0O4AypBc4o8P7Of1PWt9KVDM2xjxaxZmeZMqjipHQ4GSPXrUPKmyYOryZQvy1JYIANCrcMpvpA=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(6133799003)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?TnZrelpOdDdjTy9MN2hoWDROOVFadnV0cVFDcW1EM1NlcDEwUWhHQ3JGLys3?=
 =?utf-8?B?NXFraTFLc21FeTlIVW9SZktrclpYM1ZQSCtJSURhVXY0UE4ya2FzMzJSNmkz?=
 =?utf-8?B?TUF6aitLSlVKWHNzbGRjNERETjRNNzNybmptNWFlRU8vVXAxc05UaGdYVVVz?=
 =?utf-8?B?QXBlVmlDd2o2RGJUWUVOT1ZBWmhDcS9SUzQ2cDZkR0FrMzRKQUVlYjlwUm0w?=
 =?utf-8?B?ejJiQ1c2RjRjRXp5VXIxRGV2UVErVC9YK0szZ2lBYWkzaEdCd2d3dnM2aUNJ?=
 =?utf-8?B?TWZXZHI2L2ZOK2VQMWVTQ2JpcStZSFBqL2d1eUlPTmlOWFhMNFRTTnJMTXFD?=
 =?utf-8?B?REdVQUdGY2o4MnZNbVFTcW9aeHJuaFR3Nlc2Sy9DWXFGQjZncEdyaGZtSHNF?=
 =?utf-8?B?Z25zUS9iUzFYTzFrcVNsNjZzeUIzMmViV2REc3lBZmNTTFZnUGJCeGoxS1VJ?=
 =?utf-8?B?TE5wUmNGNnRuSThkYUxsZXR4ZnFqQ2JpM2p0WFBqZ1Q2UFNPS0ZoRytiREtR?=
 =?utf-8?B?dlE3aU9YZldSd3NOR1pyRHhPOENZQk5ic1U1NGplc0RvWW9ZZW9OWGZlNUQy?=
 =?utf-8?B?Mm1Sc0xuRTgvN2xKcDVDaEJ6QWE1TERueXZMVHVCUFM2c3lHc2FsU0J3NllT?=
 =?utf-8?B?WWZibnYvNjF0aTUvemgzSVQvNXJRSUc0bklLTURrZmhjbkpTRGpRQ0hGMUYy?=
 =?utf-8?B?anZ4c2ZtdVU1TEJycXJMemJ6OWwwOXY0ejF4TGdMYjZkNm0vdmZ1V21qZVp0?=
 =?utf-8?B?OFRvSDAzSjhwOFpHcVNmRVBWdW9DcUFRZXlCUWpvMkRTM0lQWjB1Y2VBMFdk?=
 =?utf-8?B?eURsdGJrV2xmdmlMT0FmWkpWQkplT0R1NDZieG1uRWN5Qy9OTHhpZ2dUM0Jm?=
 =?utf-8?B?ZW5NWWxLcmh1WjRySDIyeDZaVWQvYW4zUDlaZGpRVHFaV0YrS2hEZk9vUnJv?=
 =?utf-8?B?UzJjOStiQmdoUnpDK0MwYTVWTW9lUlVQVm5CUENSOSs0bVZUVERGWWNWL245?=
 =?utf-8?B?UjRETWxJV0JvWFlMSXp4Rm4zL3NzTVcvS0dlV09GWFhsb2I2Mm1sSi9UNFl6?=
 =?utf-8?B?NjVoSTJyVThzTmtVS0Y0MzVOUm4zSlVGNHJKaUg3UC9uUjZ5RVNRTnhjaUE5?=
 =?utf-8?B?SEhmNkc1NERORG5vRkw5bHVRVk54VGdES05SVURsOGJHZGFENUhXSUlHZG9E?=
 =?utf-8?B?eFJHWFBBZ0M5bDhRWFZZUEJGeDJCZUcxMmtCdXNHNlo1M0Q2SVZ1K2o0VGdk?=
 =?utf-8?B?WDE0ZUpMaVNtUmtveUl4U250SXA5R3BYWEt2OGlTS0V1Z2c3RUE0QnU3TENr?=
 =?utf-8?B?Tzd5YzNVYkxHN3dzU1dDNU9KMlRBTVVKQ3ZqR1hXNEIwaTJ6NURqeXB3SkNa?=
 =?utf-8?B?OTBnaHc3TERjNXhZVS9iK1FRcklmQ3BaYTVzMTJKSDVpWWdtTXJTYlVNWjZF?=
 =?utf-8?B?T1hpZFliRVF3N0pZNitNVG9POER3Mm1vMExGMXYxN2U3bStWZUVGY0hlNTBE?=
 =?utf-8?B?S0hpN1V6Y1I5dzE2LytaMGhuYWJTbEVjVThCQmNWTmhLcjVab3VMV1NXTFJn?=
 =?utf-8?B?SFNWZFlNQzFRRURJV2tNQXFmNkowMkw3VDBSdVZCY1JiV3ZHNkZzd3A5OTRE?=
 =?utf-8?B?SUlaWDl6aUdjcUo2aC9HelAzQnk4Wml3THQ0ZkRnWXk5a2NlRHpBU1UyRzFa?=
 =?utf-8?B?bmdSeXBROXRXOHFucFVQQ08vRStVd2pWTzNUdUQvUWZKZUQ5SUViSG9yazZD?=
 =?utf-8?B?VDkyaEdlcVhtdXVNOTg5bjlzcXk5K25PcjdjVkRxeE4xN0FIMHowd21Cak1Y?=
 =?utf-8?B?Q21kM09HZjB6VlRVQkNFYkdLbWF5bm9kaS9UWis1a3MyeUQ0MlVxU2RRWGxI?=
 =?utf-8?B?MjRGUU5QcU5wS0loMkdhT21WQlpHQkxYYytSMG5RVFRKZFhhKzhSYnpVYXF6?=
 =?utf-8?B?aFUyRHljemJST0hmUU1LbXhOa1hHWU9hc3pSaVZmQzZVQVhzTnBpWXRPRnli?=
 =?utf-8?B?QSt6UFJLT3JPUmppdFUwajJ3N000N3ZIenp4MGtNUFZCUFA5ZW4zZ2RZNTlQ?=
 =?utf-8?B?N1gybWwzWFljQXhFVGk0UVpMZUJkb0xaQ0NTQXNVUmh6amU0cVdCeC9pZllF?=
 =?utf-8?B?SlVPYUJMbzJqTk80cWtMTGxnWUNMaXI5Vm9CWXZvYnA0c3Y1MGFmMVMxSksz?=
 =?utf-8?B?ZjFHdVg4alk3dXo3ZjNiZ0FTSzhyalplcU1kNEM5SXJHNEtlRUVRNERYR2Zt?=
 =?utf-8?B?c1JzSTlnMzJLVDI3YWJNcXVrczFpcDBsb0RKRkRheDc0QUxhb1BxdithSUlO?=
 =?utf-8?B?Y1NjTjQxRFZ0M0lacWx0VEJ5cHIvM3YwMWxnK3ZSeUJkeWVyMDZudz09?=
X-Exchange-RoutingPolicyChecked:
	gwzhPRo9p1dvVLLhcXsnZ6IdsCAcYTDxqg/5fe6RnID/2pnkcer2f+aSWdNUfOpQJDAoaIoSzz/+3rV10drCDNmnuEneSrkJ0cN0BEVgPoF+SGpZR0SjYOsZuPY2IyMN1lEttrdpuaZPZBRRozjz5bugSj5N1VYjCr6tYZYzrzrl3krcNYKntotjZDUiw5iVyk7rWTV9/veCvQaDQ+9AJ+hTFJZ7vRcyOrZQ4/N059/Yg/CBwuuPAIp3qtCM7qeQE7pd145E34LEcfdjgx1MRPUg7fUmqINipkEbdxWTe44YmIoH1Uzzp/+VBsmpOg6J+i11p9QkiZ7zcVzi/NjRvA==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cddef810-6f68-4419-68aa-08def6f0dfcc
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 15:05:54.1678
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kHXpWU/OK0+CSyUntCr79yg9JI+lzHfudp/GdjyP8rwoXACL/BKK7HDErODvKi3ULcvKo6K8XXHmXTrQH66qdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR03MB8170
X-Proofpoint-ORIG-GUID: ERSDpgubXkbZtTJoh5waT6GAB7HPj2xL
X-Authority-Analysis: v=2.4 cv=SJ1ykuvH c=1 sm=1 tr=0 ts=6a79e8d9 cx=c_pps
 a=94FLU6K3oGZrB1XHaeOsDA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=ZQxX5BWu6Z8IJBb2zLX7:22
 a=8AirrxEcAAAA:8 a=gAnH3GRIAAAA:8 a=uWxbdwEO5Pmi1fmNKGoA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=ST-jHhOKWsTCqRlWije3:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDEzMCBTYWx0ZWRfX/+fZNNnxMwOF
 i14z9xmEHHyx40elHr0xWltZwZdW9O/MSY3icGmJOTMCNsyWsbDM0HqGXXSlv47kd0Ta7JsoIIh
 HObS4EUK/RFLyBo8oXO4Eap74wusdYSXibDdRqte2vNRNrZrPCn3SSRDDGrXhF+60cDj/J0TRdp
 TQ3o/isMG2+6fchVTSqZ8C3xguyM+11YxFHIJAWAN+GavXkOlnRThKkCWYnxjnivO28aYm1hVeC
 PbSd9EDLUeWV2M4ByzD35utVkFw6g/qhT/obw0CTa+4NjzJmkOcGY9AeH915/TB8mbC0Gl5ywPO
 39jl3n3YpdkXUmOqPQ4MQKGCMxSkEPGI25BXF6NJWo5E/KxHCNISIQClNjPsD94OrylJptCzVbi
 j8cz1V1NKJ1msqehGCCkDbp595EriCyA2xoOz1sWXLZlMWZRViUWE0SEimoiPih/yMvqaP+Ua56
 r6+94PkATdrInXLYfPA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDEzMCBTYWx0ZWRfX9k/aSIqduNkp
 xAAd9Eiw0A5TXqHgWY+HDNtzvfZ6uwLO4Am4V4WAuqYlSzo4qhuoSfhJpKnbqRkIhY8Y3mV4MpY
 yTY8uowy5XbT7unHcawxRX0PLMmM7YwqzYL5NRYsdPVXjioucfyI
X-Proofpoint-GUID: ERSDpgubXkbZtTJoh5waT6GAB7HPj2xL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_03,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 spamscore=0 adultscore=0 priorityscore=1501
 suspectscore=0 clxscore=1011 bulkscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608100130

Advertise the controller-wide bus width capabilities through the new
dma_set_src_bus_widths() and dma_set_dst_bus_widths() helpers.

Also update the per-channel capability callback to clear unsupported
widths through the dma_slave_caps helpers so the bitmap and
transitional legacy fields stay in sync.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/dma/stm32/stm32-dma3.c | 32 ++++++++++++++++++++------------
 1 file changed, 20 insertions(+), 12 deletions(-)

diff --git a/drivers/dma/stm32/stm32-dma3.c b/drivers/dma/stm32/stm32-dma3.c
index 4724e7fa0008..f0781fb1b66f 100644
--- a/drivers/dma/stm32/stm32-dma3.c
+++ b/drivers/dma/stm32/stm32-dma3.c
@@ -1469,14 +1469,14 @@ static void stm32_dma3_caps(struct dma_chan *c, struct dma_slave_caps *caps)
 
 	if (!chan->fifo_size) {
 		caps->max_burst = 0;
-		caps->src_addr_widths &= ~BIT(DMA_SLAVE_BUSWIDTH_8_BYTES);
-		caps->dst_addr_widths &= ~BIT(DMA_SLAVE_BUSWIDTH_8_BYTES);
+		dma_slave_caps_clear_src_width(caps, DMA_SLAVE_BUSWIDTH_8_BYTES);
+		dma_slave_caps_clear_dst_width(caps, DMA_SLAVE_BUSWIDTH_8_BYTES);
 	} else {
 		/* Burst transfer should not exceed half of the fifo size */
 		caps->max_burst = chan->max_burst;
 		if (caps->max_burst < DMA_SLAVE_BUSWIDTH_8_BYTES) {
-			caps->src_addr_widths &= ~BIT(DMA_SLAVE_BUSWIDTH_8_BYTES);
-			caps->dst_addr_widths &= ~BIT(DMA_SLAVE_BUSWIDTH_8_BYTES);
+			dma_slave_caps_clear_src_width(caps, DMA_SLAVE_BUSWIDTH_8_BYTES);
+			dma_slave_caps_clear_dst_width(caps, DMA_SLAVE_BUSWIDTH_8_BYTES);
 		}
 	}
 }
@@ -1737,6 +1737,12 @@ static int stm32_dma3_probe(struct platform_device *pdev)
 	u32 master_ports, chan_reserved, i, verr;
 	u64 hwcfgr;
 	int ret;
+	enum dma_slave_buswidth stm32_dma3_buswidths[] = {
+		DMA_SLAVE_BUSWIDTH_1_BYTE,
+		DMA_SLAVE_BUSWIDTH_2_BYTES,
+		DMA_SLAVE_BUSWIDTH_4_BYTES,
+		DMA_SLAVE_BUSWIDTH_8_BYTES,
+	};
 
 	ddata = devm_kzalloc(&pdev->dev, sizeof(*ddata), GFP_KERNEL);
 	if (!ddata)
@@ -1775,14 +1781,16 @@ static int stm32_dma3_probe(struct platform_device *pdev)
 	 * channel, and can only access address at even boundaries, multiple of the buswidth.
 	 */
 	dma_dev->copy_align = DMAENGINE_ALIGN_8_BYTES;
-	dma_dev->src_addr_widths = BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) |
-				   BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) |
-				   BIT(DMA_SLAVE_BUSWIDTH_4_BYTES) |
-				   BIT(DMA_SLAVE_BUSWIDTH_8_BYTES);
-	dma_dev->dst_addr_widths = BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) |
-				   BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) |
-				   BIT(DMA_SLAVE_BUSWIDTH_4_BYTES) |
-				   BIT(DMA_SLAVE_BUSWIDTH_8_BYTES);
+	ret = dma_set_src_bus_widths(dma_dev, stm32_dma3_buswidths,
+				     ARRAY_SIZE(stm32_dma3_buswidths));
+	if (ret)
+		goto err_clk_disable;
+
+	ret = dma_set_dst_bus_widths(dma_dev, stm32_dma3_buswidths,
+				     ARRAY_SIZE(stm32_dma3_buswidths));
+	if (ret)
+		goto err_clk_disable;
+
 	dma_dev->directions = BIT(DMA_DEV_TO_MEM) | BIT(DMA_MEM_TO_DEV) | BIT(DMA_MEM_TO_MEM);
 
 	dma_dev->descriptor_reuse = true;

-- 
2.55.0

