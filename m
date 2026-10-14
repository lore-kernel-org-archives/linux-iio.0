Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7429F54528D;
	Wed, 14 Oct 2026 14:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791987595; cv=fail; b=QmG3AciUa66ujtu2fIYzho1OdYJpk+Iac6C2vW19o/sLOYMYdTEdtBxvvdOquFqUQjpHMonXq3ZC1Iw2oM4YCGN52n3yGZO16NggVxQ68pDgjEI83CrITp45TJ5IsRXGEwYWgiMBwCFFLpoTi0dQMFOXp5CWoxOdGSWUcQ+9dSU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791987595; c=relaxed/simple;
	bh=HwWZISiJEFGlZ4TfImjsDUS/cf0Y2y4TBCsBmfiJulQ=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=j+W2NnVxxQk0CFz6arxEfjexLiojBAFBtsP+bsjCsdSGa3DteoGVHfRUsdnP16SDhN5G2wBrklYO2Hj3ZZDlaE0M2m02q+cgwnsCOCGd0B3/nC5KgesfqGUHQ9O4MRcs627mMpnSFfMCeG7/PoVFl3Mz/+5H5Qnh0CWFU7LmQE8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b=JGqUcQ8G; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=QI8t/lEQ; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b="JGqUcQ8G";
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="QI8t/lEQ"
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69EDrhlF281458;
	Wed, 14 Oct 2026 10:18:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=axVmUSeOQRUXzObL6mTDF9rKvao8koFNo986jAYaims=; b=JGqUcQ8
	GYdt5d0T7ALxg2jw4+ZokalB7PhLpFhDJ5xkN7FtGWgVeRWEo1esslN9iaMJi2Y2
	hmHHhq9MQua5cun5oEJDNkVwvV2YF7X4bQdvDJ+sYapdrXCRlvDOik3HAOXwJuLY
	RbA+2Xnon3CmQLUs17SJWfT38fu7NVxQrgyL1YzPaby9WWL/620qi2tG5GNFPWql
	aE/GlajT9bztC9e3IVHHByG/ytpXruJRcwn1vcQV/RgHLX8pTP+0LosBuJfy8OsM
	LoZxtnRt+VlJv6LsMcGvOu2XHbqTowsw/poRBvHsRMkWwPqYwduotfNs6zeAeBRw
	kHP0BL+Mv8ipVaQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=axVmU
	SeOQRUXzObL6mTDF9rKvao8koFNo986jAYaims=; b=QI8t/lEQMPli9LOKagB7a
	yt/q5B1NeqOgdSyjHXb/SzlnQI5OF+zqp8/fIblilNBB06o1XCtW6/ouv8JBGByn
	c5x/sY5/cZKAeDfxwPvzL5tNFEsWSANcn4Bq3xI4u9bRNPza1K5sZE9F5/rHrk7b
	oORM3JJx4pg8cxc2baC35zynGsgnirXNElVgRNb7DP0n+rfMNHziHKAdG+aKQgz2
	DY2sE5n0KdArCEKRtf9kLnxjzGJYayg47Lg6MhxANBf4ujMo9b010oF052hF77Yq
	B+iNr1OeBlb9r+HyI4u1e3PK5AOxYZdMbgViUezKPWB9+RrAlHm76hOI+TmK329o
	A==
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011054.outbound.protection.outlook.com [52.101.52.54])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4ha0t3bp36-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 14 Oct 2026 10:18:12 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ancJA50Tx5qegfrVdhe3ObKYN9wn9T9VUEStemhr1qO28tIdU67P3PNS/djoRy1FQT1MCilSJjXqSqM8jfHWwavX1ClevDZmq954D3Z8cimNpefRP/4lU1wXYzrRioWMIEgAAVH1KVfE4r46WigyjwByo89EH+9hiR7iGCl1FAC/6Jif+4RY1i1cYxqinIx3XdEkAxaxlRpEmAnVBhjGsLg0FzNSFsWv2/VTNeSkryIuaawo211XPGvmTHiC6fXyCCzUoDRCv5xl4jVoyW0BC1GPBNL/MltdITJptOnzipdw2BSzbkqR/Zo19dvahER11rFUHOHVw/b2TjsRaLwfdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=axVmUSeOQRUXzObL6mTDF9rKvao8koFNo986jAYaims=;
 b=jXnK3jRvViW8aU4QPHyi0fxT8qrEzGCozB5jeHPY6cCBVIi65y4RUqBpN/ZJCvnqZyHjUJ/FcCpQB2Pe0WvuJHTnEZD7rwiLQB8htdDAGYMXnwfJGCRTHQITLzw01ys7CgYRdCBo1+PZPBVUI1n5Zh71KqpEtHRo0ZzyjSI8PzPxnr/yCj/V2T5wOFxFkh3ZT28cDEZLs3L1/VDuMG2jBJIkBdYL0Wk70N8ONDg3hz4az3Y1FfAQBCg8lTpgorgl95C+NrJiernY0/6St78IwK5O4rPHfQDnStmESwkxNCJTfpS3z+n2YDkuzBmlR1smHfHlEl3nUQmyFEuD5fUThg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by DM4PR03MB6857.namprd03.prod.outlook.com (2603:10b6:8:40::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Wed, 14 Oct
 2026 14:18:04 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%6]) with mapi id 15.21.0496.021; Wed, 14 Oct 2026
 14:18:04 +0000
From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Date: Wed, 14 Oct 2026 15:19:13 +0100
Subject: [PATCH v6 3/9] dmaengine: dw-axi-dmac: Use bus width capability
 helpers
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261014-dmaengine-support-wider-dma-masks-v6-3-5b3ffdef8191@analog.com>
References: <20261014-dmaengine-support-wider-dma-masks-v6-0-5b3ffdef8191@analog.com>
In-Reply-To: <20261014-dmaengine-support-wider-dma-masks-v6-0-5b3ffdef8191@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791987554; l=2831;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=HwWZISiJEFGlZ4TfImjsDUS/cf0Y2y4TBCsBmfiJulQ=;
 b=uEaSJ4t8wLZ9cV8NkqDpJ7B1jDD41fVyC43PHkaFRQpwfJDpDLJuMAINIvC/CLoc1aZfaGZjQ
 h2geALvPNFcD8oW/JBteFnCz95rCFgFaeLAnXJz9B47ZSc7wBu/u1U0
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ClientProxiedBy: MR1P264CA0026.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:2f::13) To SJ0PR03MB5469.namprd03.prod.outlook.com
 (2603:10b6:a03:28a::17)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|DM4PR03MB6857:EE_
X-MS-Office365-Filtering-Correlation-Id: e2555cfe-b70f-441b-b744-08df29fdf636
X-LD-Processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|366016|23010399003|7416014|376014|1800799024|6133799003|22082099003|18002099003|10067099003|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
 /v8sfJq3KczFGUwbeVwVY+zx3hoTbJ9scJ2nr6QkmBNI/XM1/eOJL5I1JLoIk59v11mO8NpiNn6X03GAxoGoUrWhXiRHOvWcCp9M9daM81877XHphIFIVi29/C26lmCBhZ23MFqmj2LNWwyKao2jtilUnEj1WG3X6BUvIq4Ace4Nax6/FipO0wnLUZYhuAiIc3b9zkyNvQd0RbRp8eOpaq8fKHL4KNTOOLLn8XECFc35G7jpOIP3cz3t6ljXAKyGn5PPG1ZjEJqgU+uJTx+zWvMm4twHVvLr+GQ2OvGfLT4XRjWtc+SED86+GDc1j9mBKIWEucjGjuhFh6tnAS/BzgESyRmVqR5jNl/Ia5R18bn5jYLxZDzObF0iyUujL93TkSqyMO7JWTf/OpJ1m5S88klx66s0OhQfomqxXyopOFdd8AuGwYaJ+4CJ32Vph3toZyIjB6YkrpITWg/CnBI2qR1z7nyhGycXmIdDJ2pfEHZx+7LiO3LUHvih3DUqDDpkK2YyrtMtTAxMqv9AjnsdOBaGFSeEst/si83+F8mC7zJXJBQH/Rk6bjriwuW77QDn//jYvTa1FvMnBAoi5Ux6TrXyDAJ6o+YQSNZt2OLdURhD6OowlhbqnLCUWpUItkpHpC671G0J/zJv4QOVFOdL1JhXxf3sbHkIs97jsNW0vTk=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(7416014)(376014)(1800799024)(6133799003)(22082099003)(18002099003)(10067099003)(11063799006)(261009223027099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?bStxUXpNRGp0ZXNJMXhOMUd4T2QxL1VsMkp4bllYNk1DS24vK3VoQVlDelZG?=
 =?utf-8?B?UGFUMFl2bE9wUlg2YXBHUTFvVUt6cHcvMUM4NU4zdlVIQnp6MDZDb0pwT3Zt?=
 =?utf-8?B?K1VkK3RJRm5LbTYxS3h6WDE5SFhhQkdWd2dTZ2VpS0JGWHpqZmNVUGhDcjVi?=
 =?utf-8?B?eHlKb0VoQXMzWjBWVnRLR2V1MlprY1BqK29CbzlhQWlZWjl0NFF3VHQrbUVV?=
 =?utf-8?B?MzNwRjdoZGUvU0dpOEpjbWFvRmFxZlVkaldGYlhsbHY2cE5TRy9UZWZZZUZm?=
 =?utf-8?B?aE9wNm01MGg3dmtsU3Y4Q2U0S2lEdFhlTzYvR1h4Skc2SG5PWkZOZ1NoVkhR?=
 =?utf-8?B?RWFUUEVrQ0dFTFk0eU0rYXVPeUZYYm5VU3NUaSt0RVdVb0xlelNrTElFS0xG?=
 =?utf-8?B?NVJxWFNxQVhQeGgxZ09hZXk0VGtrUkZ5QWg5ejN1Z2dKSDdZaEhtS3ZBdjh3?=
 =?utf-8?B?b3NiVUxnNyt1ZWZlSi93UUkza29Ld1RXQXFNNmdQcGVDT3ZDYmNqRzVtcVdG?=
 =?utf-8?B?L1lUU2ZIWFVuTkRDSmdFSXRQdk9nQlRROTZESVI0emhFc3BPM1ZLNFZucWZW?=
 =?utf-8?B?WUE3WnpZZ0JMMzAwZUlRQmRKOTQ4MG90dmpKNUJFKzVoYjlicmN2T3FOa1VO?=
 =?utf-8?B?MW8wbnJlS2NYWlVuS3JZL1JVdjRzYVVSZ2oyaStOSjdtV3E5K2tTcjRIcWEx?=
 =?utf-8?B?a1JJVkVZRVpEeDN2RFc2RnpMMDVYb04rODh0TmNLOGovOU9ETFdyMVFmTHN6?=
 =?utf-8?B?VFI2THpyNHQ5QXg2aW1icTRvckIvNWxZUXhqbXZTYzNxMHNoYi9KdlRxS0pY?=
 =?utf-8?B?a01Ma0QzSEh6eS9BMjlMaUEyNFRLVHQrMXNxR0lLdzVpTjNJUk1WQXJKd1k3?=
 =?utf-8?B?KzB2YURvS0plT1J2WnZ4UVpuUG8vaGRHZnR3bU13Z285bFp0bzhGOFJUSjZV?=
 =?utf-8?B?eWR5Ymd6WE1RUC9hM1hOVW9qRzh6d2ErOThkWkJ0dlViVjY1azNsVkJ0YU5T?=
 =?utf-8?B?UHRxSDU3czF5OEdMcTRDN1ZWZ1V5WFJMbUFiMUo3U3NRelNPMW1ZWnpKSGx3?=
 =?utf-8?B?YVNGbGI3S2hGbWNoMWxTNkJwNjcrUlJZcHZnZlNoenMvWm5oaXh1UzVlRWJX?=
 =?utf-8?B?a3hCZlhPVktocjdoMlFEMDFyVlpCWHd1ODlOeUdWZkdWVHJMTS9NN3VBWk5M?=
 =?utf-8?B?NjBDZy9WTmtvTHNtSCtiR0lBRTZYL1E3Y3J4c3RQUVF4enNNNXc5MGN1cmlh?=
 =?utf-8?B?Q2RhV1ZqMjFpUEdSRVMxUUhqYnM4bFplY0FTNTFncDlwdExYdXE0L2RiUnVz?=
 =?utf-8?B?eEJ1VGJiNzQyZ3EvNjRzRmZGYmc1dDRndlo4RUlTbjVZazg1SmtENTd3a1pD?=
 =?utf-8?B?UlBBVW9EMzRjZWhkbm9UNk92V0NhWlEzTkJJNGJKdlFoQ3U3Rnp5MmtxeXN3?=
 =?utf-8?B?R2oxRWtoY29ES2JkRWFOZklBZllhc09jbEhNZVFLUDJrRDdBUGxzSExnOTJN?=
 =?utf-8?B?MmFMQUdLbFZrZWFWUitaZnRkTUlGUjA1bjhPZkszMmUwQzdmL1FQeisvRTBB?=
 =?utf-8?B?dW9VcEpCcWVGdHN1RGhYK3ppeGZ1UC9tSHYybkFTWmVDWHBMNDBrOG53OUV1?=
 =?utf-8?B?Z3J0aGJhUTNITkFRY3ZOMFpwK0lzenRQTUlQUnROekozeXU2YndmVGFDc3RY?=
 =?utf-8?B?SjJFbW0ydzhTVVY5alZPMzB2WWR6amhaeWZwR3hjT0gzSTZJQk9URlBDeVNS?=
 =?utf-8?B?SXNzUitkei9UNzRoNisxZVNweUxYQjV5S1JUSlAvbmhxZ2VwUmF2Z3dWaytW?=
 =?utf-8?B?bElKOGdoZ0NQY3FaM0NzbnNsaWxvdTk2dzNnODlKNkg4Nitrd3hYMXR6ZUVH?=
 =?utf-8?B?a3NuWlU1MGU3SjBLc3EwSEQ1ZnU5QTJ0YXc5TXZWTnZNb1U1dk5YZC9ZOURv?=
 =?utf-8?B?VkcwZnFSODBTQk5DUjdJcnVjbFVERjJYRXhjeisrUnRYRjhJT2taVGlvb2pS?=
 =?utf-8?B?UXNmelpHdEV3MXRjZUx6SENjVE9aK2dYZ0tsSU4rc28vRnJkS3lTYzZsVVI1?=
 =?utf-8?B?UU1ZdEs5cEZ1RjFCK1laUWZZVmhWcFBDMFMzUlVybVNvdGVSWXBnQm5wV0Nm?=
 =?utf-8?B?dlBkb3VxcVg4VFQ2ekdCN2dFaU9nU1dJREY0cThub1NOTGRUazF6WWtsWk5Q?=
 =?utf-8?B?ZCt4RC9ZU1VmN0FDMlhDRWF4Ymk5MWZRUGx0Ni8vRnJRSjg4Tm4zVWd5b2JC?=
 =?utf-8?B?US9OOUZHRkJpeG12T2pxRTV3bEYvZ2JkbVA1U1BvVjM4VGdRNVc2WFg2TmRZ?=
 =?utf-8?B?eHhPQ2V4cTVrcXI3Z2t4emU5TitFdXZUQ0tiTllkeDFxUjdoNFNuQT09?=
X-Exchange-RoutingPolicyChecked:
	du99z8fy2+JtFlgi5nHo+QekfygVDwwQywiqm9FkHNDAJfoPg1V65dJ8eDJg39vGNbVEjkQ4GPEay6uAa19ri9DFKhiIWyhejGw+geCS+6qgaidseAX7YHVM+d+ilcAfCVdGfV5Lzz5YGCRKZMu2KiyRMvf3ptn6a4sAHXdQqw4jANp9J1+kWemfo9r+dui6xj0M7j/fLq9VDLzUVxOqM3PJGDTbDuyUP9HlwoveYPjIol3okRzZV/A4jR8QE9qEoJIz9FmFR0hd1b4+FDyjhBoufLwQSUAjdunD+8MBOQDx7p69hDDnAkI5CE9s325Wp8lfs4prAYF/boSSL548qw==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2555cfe-b70f-441b-b744-08df29fdf636
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 14:18:04.5204
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: razzvXsrhWXoJsfVXtwDl3ZWWHdqvOhNsoYe65q0IsCUcT4Af4+NLx+nQEypqc0MZ8GTnUB1RtJ3a+65TsT6rA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR03MB6857
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA1NiBTYWx0ZWRfX6WaxHycymKAZ
 A5uemaXxuEQ0t5jF2VMt6IoydGy8yukV8KD39rEVf2sYD8osEWAt4o5ImDj/CY2ud/oxB5J9jLL
 rNznKqF5yS74Ttoa7KIaqoQ+yw4YobQHl1UcueShFwISYERq7tHVAwcaDRCWIRVDuYHUEZiaLza
 r3JT9qAqp0IXi2jBhtmcBMV8FmXTw0D/wSbtiSsgbQL3tFTBBDmSW7dK8+ExsgQqfKs8PSJov/B
 k/0PlL3ACS6piLJZ6qqVtX6cl0NewWnqTrOAgmHcJV/Ee1poJrb52BKcH7QPxjU8/2midoIRxZM
 QWy9ZNh3oWKWQh1T9RShfon/60BDWINPHPcTz1FndzKHaxhJn0nSLjirL0AVwIkKP3eTxR6CQ+H
 exaeb4C5y5gbqsJpVN9SE+pkKRFETK+m9Zupo0V97FplDqoCNMUGrx11gQZDLz2PNXSn9W4GRG+
 LkVXCTdUynt7/JinSvg==
X-Proofpoint-GUID: 4wvkG5x4LnAUkt-7dYvU_VR_dRJQGN8t
X-Authority-Analysis: v=2.4 cv=S7RMU4sP c=1 sm=1 tr=0 ts=6acf8f24 cx=c_pps
 a=i69ZgmgbQZPDBD2C4G6j1A==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=uXIjobp8t2wMuQ0fPvqm:22
 a=8AirrxEcAAAA:8 a=gAnH3GRIAAAA:8 a=y_OmukUNvUlgtTeSwsgA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=ST-jHhOKWsTCqRlWije3:22
X-Proofpoint-ORIG-GUID: 4wvkG5x4LnAUkt-7dYvU_VR_dRJQGN8t
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA1NiBTYWx0ZWRfX0mGBI0l2aRTx
 0akigUdYk7518uucU59jNjwCjGEavUq8p8E7pnKe8SnDn0dt+8Bo8ESBGywLwxJmeuEbQmpMj2c
 tX4ewDNQu8eubaJVhHCeVDI8fIqLTmzdkN4FZ6yw5GqGp3X2e+6F
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 clxscore=1015 malwarescore=0 bulkscore=0
 adultscore=0 priorityscore=1501 suspectscore=0 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610140056

Advertise the supported bus widths through
dmaengine_bus_width_set_many() instead of assigning the legacy u32 masks
directly. This keeps the driver using the new bitmap representation
while preserving legacy fields during the transition.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c | 39 +++++++++++++++-----------
 1 file changed, 23 insertions(+), 16 deletions(-)

diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
index 7520c78f55cc..f7a0e926fdcb 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
@@ -34,20 +34,6 @@
 #include "../dmaengine.h"
 #include "../virt-dma.h"
 
-/*
- * The set of bus widths supported by the DMA controller. DW AXI DMAC supports
- * master data bus width up to 512 bits (for both AXI master interfaces), but
- * it depends on IP block configuration.
- */
-#define AXI_DMA_BUSWIDTHS		  \
-	(DMA_SLAVE_BUSWIDTH_1_BYTE	| \
-	DMA_SLAVE_BUSWIDTH_2_BYTES	| \
-	DMA_SLAVE_BUSWIDTH_4_BYTES	| \
-	DMA_SLAVE_BUSWIDTH_8_BYTES	| \
-	DMA_SLAVE_BUSWIDTH_16_BYTES	| \
-	DMA_SLAVE_BUSWIDTH_32_BYTES	| \
-	DMA_SLAVE_BUSWIDTH_64_BYTES)
-
 #define AXI_DMA_FLAG_HAS_APB_REGS	BIT(0)
 #define AXI_DMA_FLAG_HAS_RESETS		BIT(1)
 #define AXI_DMA_FLAG_USE_CFG2		BIT(2)
@@ -1476,6 +1462,20 @@ static int dw_probe(struct platform_device *pdev)
 	unsigned int flags;
 	u32 i;
 	int ret;
+	/*
+	 * The set of bus widths supported by the DMA controller. DW AXI DMAC
+	 * supports master data bus width up to 512 bits (for both AXI master
+	 * interfaces), but it depends on IP block configuration.
+	 */
+	enum dma_slave_buswidth buswidths[] = {
+		DMA_SLAVE_BUSWIDTH_1_BYTE,
+		DMA_SLAVE_BUSWIDTH_2_BYTES,
+		DMA_SLAVE_BUSWIDTH_4_BYTES,
+		DMA_SLAVE_BUSWIDTH_8_BYTES,
+		DMA_SLAVE_BUSWIDTH_16_BYTES,
+		DMA_SLAVE_BUSWIDTH_32_BYTES,
+		DMA_SLAVE_BUSWIDTH_64_BYTES,
+	};
 
 	chip = devm_kzalloc(&pdev->dev, sizeof(*chip), GFP_KERNEL);
 	if (!chip)
@@ -1557,8 +1557,15 @@ static int dw_probe(struct platform_device *pdev)
 
 	/* DMA capabilities */
 	dw->dma.max_burst = hdata->axi_rw_burst_len;
-	dw->dma.src_addr_widths = AXI_DMA_BUSWIDTHS;
-	dw->dma.dst_addr_widths = AXI_DMA_BUSWIDTHS;
+	ret = dmaengine_bus_width_set_many(&dw->dma.src_bus_widths, buswidths,
+					   ARRAY_SIZE(buswidths));
+	if (ret)
+		return ret;
+
+	ret = dmaengine_bus_width_set_many(&dw->dma.dst_bus_widths, buswidths,
+					   ARRAY_SIZE(buswidths));
+	if (ret)
+		return ret;
 	dw->dma.directions = BIT(DMA_MEM_TO_MEM);
 	dw->dma.directions |= BIT(DMA_MEM_TO_DEV) | BIT(DMA_DEV_TO_MEM);
 	dw->dma.residue_granularity = DMA_RESIDUE_GRANULARITY_BURST;

-- 
2.56.0

