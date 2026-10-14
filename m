Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC96553A892;
	Wed, 14 Oct 2026 14:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791987592; cv=fail; b=UzOejztxbduqMgTaLOMH+BplA10rs9J3Rj17h9ByXamSQ283VZG+YI7LRnc/kcXTwDB5UKKYqIAmgQ29YTm4XwUSIw3IK19ABHg2O7YCYk5tGD65AQlW8WomOj/JRD9V+TZchDlh7KSXf49mLb6tAuF5hJPZb3RFKkGqQgpwjt0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791987592; c=relaxed/simple;
	bh=jr4DZ54l0vDzM/m4XxQ+PSZgySEjAXDSxZ/NcIHDDnA=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=ovQMb5Wx7DuMX2J3qAgUc/lFPhEz0u65rCdwbEhQ+CiOazFnoZgHfMjGQhJDPK039hWxuXOeJp7MJ/yc/9UeEhNjU1to7Tlau1OpSvOVGe5DRCZ31jm1Qd1+JInQU8+HkNlxGvnIwd7novH7vc19pYntmgNcme+mqdVzBiPQdA8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b=f2MN3JLx; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=b0zkufn2; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b="f2MN3JLx";
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="b0zkufn2"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69EE2nXC2737287;
	Wed, 14 Oct 2026 10:18:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=D8kib0zoMFvmbAXUHNzEmEX+Oh4zlsmcbgG3hRo1EpM=; b=f2MN3JL
	xBbF55JKlclzV8N5+hXwGOS5dObPSHdlgDuVySlJsGZSbcQiMRCeKqK7Pe/KWKhs
	VdAQLfSVXBU3kfW9B6Th6vH3BVKHfW7X1rVbF984PVVjdf1DQjSekqItn8WwtLXW
	TH96NVLRf9jysYoZHK3p+agw9cLs8lRYdvHv0nNvj28kXrQLNTMJGyKbBVlpbzgY
	/6+koJ/uD+aNDW9yVm9WPuSQFA9ROmeRDTQLcLR1XKvoEOzNONS+d5qv72UaDhen
	cxNVrJEn80spjCf2MFpKKX26DyE5ugT5ia7GlqB0R8+L6Uta+X3UQv9lJ6LqbKRB
	7+LlVwFPNaWvSqQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=D8kib
	0zoMFvmbAXUHNzEmEX+Oh4zlsmcbgG3hRo1EpM=; b=b0zkufn23pZ38kzoGI9Rl
	qWXYiWLhpMZkCV2PWGk3VhQvH7WGhMNU4j8K/8CvBLFCmygvSWCEm5lBTc5dWDFM
	p5PLBVa0iHCjn3XGebYn832E8aZ43qwsbUpGY3I1DotZCFpPJ2n/NCQaCndGUWwu
	f90E9jojPEBb6nAjP68LvMymMyVp2czPgEWTgpjkm0sD+7A1VMwRwW9Y/aAZd86R
	izjHeCfGQiXhfNfNyovdxlv4eb14l8eC7lT4rxpwokdZE2PlZVbaK0Dypsq7otlT
	zv1/g6KeXyJmueRiCISgTrgZQ8bJq7+7+zC1mxKX928A1fxkE4AGk9EWLWfIY7wE
	g==
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012021.outbound.protection.outlook.com [40.107.200.21])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4h9xnsccyu-3
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 14 Oct 2026 10:18:00 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nTXSOx1cipSNcPFQSelLw8o+tsSTNTpBP89bfFNnwN2aGG961N1Mq6Dg5ak/GEEuzrySrifPkLIJ72EGWKA/QWRfK2h4zy8t3Wg+1IhcJgE8oCZQuUPY6FZGzgTD3uaIdKSCbR3kxGpOd5JNkSk3LA0YAkz17kx1SyZEYoKmibJKnRgyMW1GVqdz1GbTogqtnRrWwlnIAgKEPGLQDN5B2wx3jWVDI2hytCwKIftbACe4VFlb6ENhvS50frJpKhClf+jlI19PiZVeza/DEGIR5DkJk7aKIgqC2L5vIanjL2Ji4emTAVKJ9lt2G0kA8LKLE/LGHSSvg0R2QkGFUemkpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D8kib0zoMFvmbAXUHNzEmEX+Oh4zlsmcbgG3hRo1EpM=;
 b=sK3VhkOtTCzSTcip09fv0yDeUVIdsLzQkSsSEsY/dxNQOy4NOZeuDKa7fJ29oU2eKyRLW1/nxUAc9LGGpiW3AJ4cj8BVQ+ufaIh6mFZNBOrEAoJ36lDPHgojJtW1FLrzF9VI7A9lp8XKwMi8dkxpdawAvaPtE+H03v+IQnlJKnfqWGNS5CIseNy/DAfXa9M+9JsSLbtRdjjke14avn9yxjUwAyqjDrrmnI8SscSTYGpI54KPYmaGo1DmJxHjoefSwRsXa72Xrm5KizoWcBSx7ChPenl1YWFI8W08MeHDjKaLi7OTyM4HaE53jRIaU9H+yONYaM0JQKSSRMdRluXMHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by DM4PR03MB6857.namprd03.prod.outlook.com (2603:10b6:8:40::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Wed, 14 Oct
 2026 14:17:56 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%6]) with mapi id 15.21.0496.021; Wed, 14 Oct 2026
 14:17:56 +0000
From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Date: Wed, 14 Oct 2026 15:19:11 +0100
Subject: [PATCH v6 1/9] dmaengine: Support bus widths of 32 bytes and above
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261014-dmaengine-support-wider-dma-masks-v6-1-5b3ffdef8191@analog.com>
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
        Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791987554; l=13445;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=jr4DZ54l0vDzM/m4XxQ+PSZgySEjAXDSxZ/NcIHDDnA=;
 b=o9mEcfR07aB/KS4WdBqGwb2ZWU16qj9eUx5H4fb6qCuiy9hQDSK9INjHYFada7a8uxHC4slX5
 kjXFvIYOhCvDjgNCgLKDBtKg5fkZc1HzNhgroUFsHlc3+345zCdelJ5
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ClientProxiedBy: MR1P264CA0075.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:3f::17) To SJ0PR03MB5469.namprd03.prod.outlook.com
 (2603:10b6:a03:28a::17)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|DM4PR03MB6857:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d75c291-2a13-4865-3840-08df29fdf152
X-LD-Processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|366016|23010399003|7416014|376014|1800799024|6133799003|22082099003|18002099003|10067099003|3023799007|11063799006|5023799004|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
 CEn4yCalulWPty/4awF0d/psUN8HuuolcbEeTOAidBTerOjcB4SerzBNh5HQgwt4CWU9303FAJMqByvV8ZD4GD0FrGGyv9a6DPGg1hG4/pYs9bpFLCe8NqWyWCFDhaLDcNO+BbFnOHx/5ROitQ+X1EMPIx4Pzw8MTRS1wiiaJDwJq9bPuU7g7yjr9n0IrL5q3x8eAibr4s8DX5uwgA7H3kUVQBOYwdUm2bd3Zd2tvjbmIu3tGVnNVWLApNF6e+WNdu6bXzBjCr9kaizns4tgE1nebFlz4fb99FzXd+aNm4ca3O1PrizohP3UtTj90ctr6N1BVkMXCY+yi8RvxBsLUAOtOQOARBcFKJQh8FO2WY9JohkbZpudmUvKk0/UkCeKCJgVzvZVeAlHjz11L6g1M39HxV6RyQw7/XKJysqnQ9e4wRd7s8nCPlyJCDCStOI+/oCh1ZaStlYSGs/fd2JBrzpfOnrmWRYICPWst3UVZSsX5F+RqIJNh8rTWSzUx8eA0Wj1or5ICTv8TR5e/cmS02HVCAnlrsZqD+au7VOXfnRaVu69FK3B0S0lv5oDdTrUO1jylDWsPPhvrllX9jZQgxgmj4PGYocY1/nxZmNYG99+pGRNC1HYwA+5oVgLk1+w6fQyqD9m2okUY+FDnyjLQI1OBW/6hoE786j821axdrg=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(7416014)(376014)(1800799024)(6133799003)(22082099003)(18002099003)(10067099003)(3023799007)(11063799006)(5023799004)(261009223027099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?Y2d2a0dvK3NFVmVpUDZVaXB2YlpHazlhSTZhbEMzMTRhVC9OSGhHdnBRL0Uz?=
 =?utf-8?B?aUxYU1FEdnJCeDlxWUcvekkvUm94cmtDTVd2VFRHTm9uQ0tIUkU4cnNkUFlW?=
 =?utf-8?B?SnlwbnNJcHc3TGtSZHNMVGZjOXE4bitCNVJ0RmlMWHcyZUNGQzI1c2dXaG9E?=
 =?utf-8?B?L2x2Y24vUHFNQ3U4M3hvRW5ERThDQ08xSzFKYzFWbW50NEl2aTEzWEtpTFZR?=
 =?utf-8?B?RTJxb1JValRLcm9JMjNZNHltdUN3ZDJHUnpISDJOQzlCUGMyL2JsWlZ5dFJC?=
 =?utf-8?B?dG83UEFQRmtiV0NxZ0pXZm91YWRTSjNnbU5HK1JQTmpFVU1sRitlbTIzZ1Ux?=
 =?utf-8?B?MzVROEI1Q1J4eXU1WmJreXZybndJZXVkRUh4dGF0bmRyQTNvbmMwQ2xQeCs5?=
 =?utf-8?B?cnBXYzRtSkU3Y3pLdEM2NVcycVBWWFNEQ3hyU2dIaHJuMkR6RWY2YlFYUkxQ?=
 =?utf-8?B?Ym1rUjFnQ2lQNkhDM1FCSGlCa3RzQ1B2RlByMytrVGlvaGxId3FkcmExQ2pC?=
 =?utf-8?B?R0swRnlGckNiQlpPdlk1cDNyY0owUThLN2t3RVZHeVNaQ0hKNG16WHl3alRJ?=
 =?utf-8?B?TTgwK2JsUEI0bVcvcktNbGRXN2hYNngyNU44RFJzQU1TOElqa3R3R1JxQUdO?=
 =?utf-8?B?ZEh2WHptUFpXUDdtVUpjMGVsTUdYQWZSMzg0QWlQeUVlOTRWZTh2d1VHUGQx?=
 =?utf-8?B?c3J5ZGU1WlY0NThmQ3g3WEUxdWRKZ1JmbzdVTTQwWjVOWnVWS1AzN0FhY3FB?=
 =?utf-8?B?RkpyTXVmVWhvWDkwUTB5dGMxWXNJNy8wQzZCY0RWS2czdlZibHpXUG9Gc1BX?=
 =?utf-8?B?eWhOcDJxSVRnMTF6M0NFQTdJazVibS9Dcm11Mm1hOXZKZVJBbUFBeEhOc3h1?=
 =?utf-8?B?WnovTGlhaWp0dzROcDJEQXkrdE1EanZ5U2VzVU1qNDc5bFdEU2hObjlaOXdZ?=
 =?utf-8?B?ZXowWkNHbitJeUZVMzh2V2tMNWM3bDZrZ2d0ZHVPMFRaTit1YStyR3MzaGdJ?=
 =?utf-8?B?d1JuWE5SL3IxdUx0U21mY3gweURTdGlzUjE4M2RxUCt4ZndXVVo5RWxIL3pM?=
 =?utf-8?B?M3NhS0tPQjY5UXlGN01lZGdLT1lwL002Sm1MTVZuQWZ3ZHBodExuVzNKNWJn?=
 =?utf-8?B?M1UvSWNKYTkxaGRpaHhpNVV3N2cwMmpiVlhwVUQ1Q0RyQUZUcWlJVVk2cUpT?=
 =?utf-8?B?M0xYY2R4azJQZEwyT1JWWmxpRWFJcnV4a05HcThkODNzNzBnQmR0YnBjL3BD?=
 =?utf-8?B?UElyd2pzeExFTDlCbTVMc3k5dGJ5UkExT2RGaVM1YmxuQ291dGpkbmlUL0kv?=
 =?utf-8?B?ZkFUeXg4SXVTOTEyN1dOU01CTXQ2aVVJQlIyeTF1aFFoWk9BRlVWVTE5VWhP?=
 =?utf-8?B?ZnFVWnhleEl3WnprYVA0b0VTQzhieTZQOXFUcDllWmNKVVRIZlo3UEx2NEc5?=
 =?utf-8?B?bmNNejN5T08vT3VGYmM2MmM1OHlDQWIzZTB5NHBQdTZ2QkhFdVpMZWJlMkhn?=
 =?utf-8?B?V0lMd3h5YkdTVWVJOG9MYjR0Y1RKSzM5dDg0MnR0enZlcGdsREZHVm9xTGpO?=
 =?utf-8?B?SlBGRUloWWxaemhJWUNBUVFDNHFDc0YzVXVLL2cvSUhWOFJnbjJQTUUzL3Jq?=
 =?utf-8?B?cFI2ZFMyM2RWQ3ZZdXM5VVh1M0l6L2hoWVZydkdlaHdVSkNsWEI3cEovdENB?=
 =?utf-8?B?TGI2b3JmYW04RFJPUk92TC8xbjZRcGgvN2dKYUM5ejlIcDJrTkhrN0o3NzBD?=
 =?utf-8?B?VXVpR1VEd1kySnlRSUkrOWV5VG5SOHkxRG9HamQ3WU5WMVJnZ3MxMmNXMWRP?=
 =?utf-8?B?U2pGL20zVDE3dWZ6SnR0MzNKcnZRMGI5OFpUak52WlJFK0RFd3VzTlVVczZU?=
 =?utf-8?B?eFI4aWE4ZXhIbjQyTGxwZ0RKd2Y5bGRtZzJKVER4eG1ZcFl4RGpNMWl3YU16?=
 =?utf-8?B?Q2RDdm41M3IrQU5hSWRTWGlXUzRDdTc5V3Z1c2djZEdFeThmL0FoSGdZQlZn?=
 =?utf-8?B?RlkyYTZHVE9rZ0hBTFhyVC8vZWc5dTZyZEtkQ3BaZG13ZndLMXhjZkgveU4x?=
 =?utf-8?B?bmduOXpwYUFIekZnNFhZRjZ4ZkpEc2NySml2cGo4VU9nOVRPN2lUaEZDSkNJ?=
 =?utf-8?B?SHloS0d5TGZhS0xyUnd6OHJuUzNHTlhiQVFwRENkTkI2K29zSGhaWXkwZWFS?=
 =?utf-8?B?b2ZXUGc2UGdPMjJmQUhUYTFpbC9ZUlJBR0c3OWVyUUdWTk9MSllkaDRlV3FQ?=
 =?utf-8?B?L2V3VUhoNFdMM3RDZGMrbGcxcnFIb3BtR3ZkUWJNQlhXeGlRVUhLMlNlSWVY?=
 =?utf-8?B?MldVc2NXUFRuRlVEMkZoTGVENWNSbElvTFRkUXk0VU51RllhRE1FQT09?=
X-Exchange-RoutingPolicyChecked:
	AiYLOQ/5Xq16+Xi90vwb1xU+9o81Dk9RxEWOWpmAdYXsmS09/JM44tQXnnfYxRlBQiNi48HHPYY6sVVhWO+Ddw8QsYLghFEXW3Azk8YLChgUhSanMRqOjcPbqMzeoL0yPH/98sjwMr/ymewHOQoro/w/V31RV2xmpw9sepx+nuGLwuEnFcAO1blAhHyWOG9Ts/MmylCMCkAeVGXDfDZUgrbvB0hsHrWj6m8JEQcrI1+FZ9amL7NwEEGq89cenD2kKnozBE3NlaKyK37UI8pHzZirvDZuWyxOy5J9NMiZlMblVK1EBR4sALf9ga7e0TMUb29N8RG0jR4vHrQ+Rny75Q==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d75c291-2a13-4865-3840-08df29fdf152
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 14:17:56.3616
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7jCSQLe4z5KEEHqEIIBuBBzvbP7rzFWK8Y38wmy40G5XzWVBFi/cTC01NbeA6yIA/JsRLhg6sIsolu+hoh8bUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR03MB6857
X-Proofpoint-GUID: mzrMrBoAu5Nrszy3SJgD0Q7HdGl72gn9
X-Authority-Analysis: v=2.4 cv=MIr1C8Zl c=1 sm=1 tr=0 ts=6acf8f18 cx=c_pps
 a=qCFiEXCgs887QpJba4awmw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=N--XFCr6TIEc_64PeIT2:22
 a=gAnH3GRIAAAA:8 a=bbKM_mjVB8olCydZLLoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA1NiBTYWx0ZWRfX8+pQi29o9uoG
 c6R9iCOk0uyE6teaDiAbF2QoTi4jWKe7cH5XkGBvSHbodkxcNL1qxFgbCXt6yDJ4eKtqz8QUXcd
 W6tsrECFY2oNcrTs+T/AUkEZqLfEdu0gYcjCguim7cqAxXKbIjvx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA1NiBTYWx0ZWRfX3NUxd/MCS7HC
 UpJ+h3lC/71JvtIl1Bu11/zdLMnH2UaKCBx+1bJDpAs5TJFSIq7wtJbkCfSvXfxnKyYFO8W/tYX
 ABASFmDm0E2OetEQprTVkkjEL2KcHdeZ9CB11a5BGV9tB3qcOlIJZCBE5aUJLrH78IqhESG+HkS
 V7EPSYjcg+48pdDjojPboxvtm6kn6fH2972hrR7BRjXuAXRrDyvlQoU8Zo4V0+6Y40BbOwCbQZ0
 ah+TboQOSlu5+2xdaw523VUIB6jj7NRuzOcQXOwqNl51ucF8o2rIg6TUtqmCvPTcDGMjAQLrpzA
 qbPsChFgOdx8v0lSndhXlwBSRTNCPw9An8MXiuwuZtHglXwHe7FBnFUoBUk+DTrBpqFmKHFSkbd
 ksuywzBPfKIQS3o7n7iJgTKblTuROxmEERG5Sua+SJi4/o426p+qPWsCiuCpNQHCtgm8VkmjKoG
 cN1Ner97Z9izrIFBAlg==
X-Proofpoint-ORIG-GUID: mzrMrBoAu5Nrszy3SJgD0Q7HdGl72gn9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 spamscore=0 suspectscore=0 clxscore=1015 bulkscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610140056

The src_addr_widths and dst_addr_widths capability masks encode each
supported width as a bit whose position equals the corresponding
enum dma_slave_buswidth value (e.g. DMA_SLAVE_BUSWIDTH_4_BYTES sets bit
4). As these masks are plain u32, widths of 32 bytes and above
(DMA_SLAVE_BUSWIDTH_32/64/128_BYTES map to bits 32, 64 and 128) cannot
be represented at all.

Introduce bitmap-based bus width capabilities that span the full enum
range, through a new dma_buswidth_mask_t type modeled after
dma_cap_mask_t. To allow DMA controller drivers to be converted
incrementally, the legacy dma_device u32 fields are kept alongside the
new masks and the core folds a legacy-only driver's u32 into the mask
when the device is registered, so consumers only ever have to look at
the mask.

The fold is bidirectional while both representations coexist. A driver
that only fills in the legacy u32 gets its mask derived from it, so the
consumers already converted see it. A driver that only fills in the mask
gets its legacy u32 derived from the mask, so the consumers not
converted yet, which read the legacy dma_slave_caps fields, keep working.

On top of that, dma_get_slave_caps() derives the legacy dma_slave_caps
masks from the new ones when a device_caps() callback adjusted them, so
that a converted controller narrowing its per-channel capabilities is
still seen by the consumers not converted yet, while a driver adjusting
the legacy masks directly keeps working.

Signed-off-by: Nuno Sá <nuno.sa@analog.com>

---

Andy, did not take your tag given that you're the one asking for the
split and since we ended up not doing it, not sure if the tag is
to be kept :)
---
 drivers/dma/dmaengine.c   |  50 +++++++++++-
 include/linux/dmaengine.h | 197 +++++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 234 insertions(+), 13 deletions(-)

diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
index c5fef57b5adf..b47008595332 100644
--- a/drivers/dma/dmaengine.c
+++ b/drivers/dma/dmaengine.c
@@ -33,6 +33,7 @@
 
 #include <linux/acpi.h>
 #include <linux/acpi_dma.h>
+#include <linux/bitmap.h>
 #include <linux/device.h>
 #include <linux/dma-mapping.h>
 #include <linux/dmaengine.h>
@@ -592,6 +593,8 @@ int dma_get_slave_caps(struct dma_chan *chan, struct dma_slave_caps *caps)
 	if (!device->directions)
 		return -ENXIO;
 
+	dmaengine_bus_width_copy(&caps->src_bus_widths, &device->src_bus_widths);
+	dmaengine_bus_width_copy(&caps->dst_bus_widths, &device->dst_bus_widths);
 	caps->src_addr_widths = device->src_addr_widths;
 	caps->dst_addr_widths = device->dst_addr_widths;
 	caps->directions = device->directions;
@@ -611,9 +614,31 @@ int dma_get_slave_caps(struct dma_chan *chan, struct dma_slave_caps *caps)
 	 * callback to override the generic capabilities with
 	 * channel-specific ones.
 	 */
-	if (device->device_caps)
+	if (device->device_caps) {
 		device->device_caps(chan, caps);
 
+		/*
+		 * A driver already converted to the bus width interface
+		 * adjusts the masks, so derive the legacy capabilities from
+		 * them for the consumers not converted yet. Drivers not
+		 * converted adjust the legacy capabilities directly, in which
+		 * case there is nothing to do.
+		 *
+		 * Goes away with the legacy dma_slave_caps fields.
+		 */
+		if (!bitmap_equal(caps->src_bus_widths.bits,
+				  device->src_bus_widths.bits,
+				  DMA_SLAVE_BUSWIDTH_MAX))
+			caps->src_addr_widths = bitmap_read(caps->src_bus_widths.bits,
+							    0, 32);
+
+		if (!bitmap_equal(caps->dst_bus_widths.bits,
+				  device->dst_bus_widths.bits,
+				  DMA_SLAVE_BUSWIDTH_MAX))
+			caps->dst_addr_widths = bitmap_read(caps->dst_bus_widths.bits,
+							    0, 32);
+	}
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(dma_get_slave_caps);
@@ -1173,6 +1198,27 @@ void dma_async_device_channel_unregister(struct dma_device *device,
 }
 EXPORT_SYMBOL_GPL(dma_async_device_channel_unregister);
 
+/*
+ * DMA controller drivers not converted to the bus width helpers only fill in
+ * the legacy u32 masks, which cannot hold widths of 32 bytes and above. Fold
+ * them into the mask so that consumers only ever have to look at the mask.
+ *
+ * Goes away with the legacy dma_device fields.
+ */
+static void dma_device_fold_legacy_bus_widths(struct dma_device *device)
+{
+	if (bitmap_empty(device->src_bus_widths.bits, DMA_SLAVE_BUSWIDTH_MAX))
+		bitmap_from_arr32(device->src_bus_widths.bits, &device->src_addr_widths, 32);
+	/* consumers not converted yet still read the legacy caps */
+	else if (!device->src_addr_widths)
+		device->src_addr_widths = bitmap_read(device->src_bus_widths.bits, 0, 32);
+
+	if (bitmap_empty(device->dst_bus_widths.bits, DMA_SLAVE_BUSWIDTH_MAX))
+		bitmap_from_arr32(device->dst_bus_widths.bits, &device->dst_addr_widths, 32);
+	else if (!device->dst_addr_widths)
+		device->dst_addr_widths = bitmap_read(device->dst_bus_widths.bits, 0, 32);
+}
+
 /**
  * dma_async_device_register - registers DMA devices found
  * @device:	pointer to &struct dma_device
@@ -1234,6 +1280,8 @@ int dma_async_device_register(struct dma_device *device)
 		dev_dbg(device->dev,
 			 "WARN: Device release is not defined so it is not safe to unbind this driver while in use\n");
 
+	dma_device_fold_legacy_bus_widths(device);
+
 	kref_init(&device->ref);
 
 	/* note: this only matters in the
diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index 71cde09ff240..b190bfb42df3 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -427,8 +427,168 @@ enum dma_slave_buswidth {
 	DMA_SLAVE_BUSWIDTH_32_BYTES = 32,
 	DMA_SLAVE_BUSWIDTH_64_BYTES = 64,
 	DMA_SLAVE_BUSWIDTH_128_BYTES = 128,
+	DMA_SLAVE_BUSWIDTH_MAX
 };
 
+/**
+ * typedef dma_buswidth_mask_t - bus width capabilities bitmap modeled after
+ * dma_cap_mask_t.
+ *
+ * Each supported bus width is represented by the bit whose position equals the
+ * corresponding enum dma_slave_buswidth value, e.g. a device supporting a bus
+ * width of 4 bytes has bit 4 set.
+ */
+typedef struct {
+	DECLARE_BITMAP(bits, DMA_SLAVE_BUSWIDTH_MAX);
+} dma_buswidth_mask_t;
+
+/**
+ * dmaengine_bus_width_valid - test if a bus width is a valid one
+ * @width: bus width to validate
+ *
+ * Return: true if @width is a valid &enum dma_slave_buswidth, false otherwise.
+ */
+static inline bool dmaengine_bus_width_valid(enum dma_slave_buswidth width)
+{
+	switch (width) {
+	case DMA_SLAVE_BUSWIDTH_UNDEFINED:
+	case DMA_SLAVE_BUSWIDTH_1_BYTE:
+	case DMA_SLAVE_BUSWIDTH_2_BYTES:
+	case DMA_SLAVE_BUSWIDTH_3_BYTES:
+	case DMA_SLAVE_BUSWIDTH_4_BYTES:
+	case DMA_SLAVE_BUSWIDTH_8_BYTES:
+	case DMA_SLAVE_BUSWIDTH_16_BYTES:
+	case DMA_SLAVE_BUSWIDTH_32_BYTES:
+	case DMA_SLAVE_BUSWIDTH_64_BYTES:
+	case DMA_SLAVE_BUSWIDTH_128_BYTES:
+		return true;
+	default:
+		return false;
+	}
+}
+
+/**
+ * dmaengine_bus_width_set_many - set the supported bus widths
+ * @mask: bus width mask
+ * @widths: array of supported bus widths
+ * @n_widths: number of entries in @widths
+ *
+ * Like __set_bit(), the widths are added to @mask and the bits already set in it
+ * are left untouched, so @mask must be initialized by the caller.
+ *
+ * Return: 0 on success, -EINVAL if @widths contains an invalid bus width. Note
+ * that the bus widths validated before the failing one are still set.
+ */
+static inline int dmaengine_bus_width_set_many(dma_buswidth_mask_t *mask,
+					       const enum dma_slave_buswidth *widths,
+					       unsigned int n_widths)
+{
+	for (unsigned int i = 0; i < n_widths; i++) {
+		if (!dmaengine_bus_width_valid(widths[i]))
+			return -EINVAL;
+
+		__set_bit(widths[i], mask->bits);
+	}
+
+	return 0;
+}
+
+/**
+ * dmaengine_bus_width_set - set a single supported bus width
+ * @mask: bus width mask
+ * @width: supported bus width
+ *
+ * Like __set_bit(), @width is added to @mask and the bits already set in it are
+ * left untouched, so @mask must be initialized by the caller.
+ *
+ * Return: 0 on success, -EINVAL if @width is invalid.
+ */
+static inline int dmaengine_bus_width_set(dma_buswidth_mask_t *mask,
+					  enum dma_slave_buswidth width)
+{
+	return dmaengine_bus_width_set_many(mask, &width, 1);
+}
+
+/**
+ * dmaengine_bus_width_clear - remove a bus width from a bus width mask
+ * @mask: bus width mask
+ * @width: bus width to clear
+ *
+ * Return: 0 on success, -EINVAL if @width is invalid.
+ */
+static inline int dmaengine_bus_width_clear(dma_buswidth_mask_t *mask,
+					    enum dma_slave_buswidth width)
+{
+	if (!dmaengine_bus_width_valid(width))
+		return -EINVAL;
+
+	__clear_bit(width, mask->bits);
+
+	return 0;
+}
+
+/**
+ * dmaengine_bus_width_test - test if a bus width is part of a bus width mask
+ * @mask: bus width mask
+ * @width: bus width to test
+ *
+ * Return: true if @width is set in @mask, false otherwise.
+ */
+static inline bool dmaengine_bus_width_test(const dma_buswidth_mask_t *mask,
+					    enum dma_slave_buswidth width)
+{
+	if (!dmaengine_bus_width_valid(width))
+		return false;
+
+	return test_bit(width, mask->bits);
+}
+
+/**
+ * dmaengine_bus_width_min - get the smallest bus width of a bus width mask
+ * @mask: bus width mask
+ *
+ * Return: the smallest bus width set in @mask, or
+ * %DMA_SLAVE_BUSWIDTH_UNDEFINED if @mask is empty.
+ */
+static inline enum dma_slave_buswidth
+dmaengine_bus_width_min(const dma_buswidth_mask_t *mask)
+{
+	enum dma_slave_buswidth width;
+
+	width = find_first_bit(mask->bits, DMA_SLAVE_BUSWIDTH_MAX);
+	if (width == DMA_SLAVE_BUSWIDTH_MAX)
+		return DMA_SLAVE_BUSWIDTH_UNDEFINED;
+
+	return width;
+}
+
+/**
+ * dmaengine_bus_width_copy - copy a bus width mask
+ * @dst: bus width mask to copy to
+ * @src: bus width mask to copy from
+ */
+static inline void dmaengine_bus_width_copy(dma_buswidth_mask_t *dst,
+					    const dma_buswidth_mask_t *src)
+{
+	bitmap_copy(dst->bits, src->bits, DMA_SLAVE_BUSWIDTH_MAX);
+}
+
+/**
+ * dmaengine_bus_width_and - intersect two bus width masks
+ * @dst: bus width mask to store the result in
+ * @src1: first bus width mask
+ * @src2: second bus width mask
+ *
+ * Return: true if @dst has at least one bus width set, false otherwise.
+ */
+static inline bool dmaengine_bus_width_and(dma_buswidth_mask_t *dst,
+					   const dma_buswidth_mask_t *src1,
+					   const dma_buswidth_mask_t *src2)
+{
+	return bitmap_and(dst->bits, src1->bits, src2->bits,
+			  DMA_SLAVE_BUSWIDTH_MAX);
+}
+
 /**
  * struct dma_slave_config - dma slave channel runtime config
  * @direction: whether the data shall go in or out on this slave
@@ -523,10 +683,11 @@ enum dma_residue_granularity {
 
 /**
  * struct dma_slave_caps - expose capabilities of a slave channel only
- * @src_addr_widths: bit mask of src addr widths the channel supports.
- *	Width is specified in bytes, e.g. for a channel supporting
- *	a width of 4 the mask should have BIT(4) set.
- * @dst_addr_widths: bit mask of dst addr widths the channel supports
+ * @src_bus_widths: mask of source bus widths the channel supports.
+ * @src_addr_widths: legacy bit mask of source bus widths the channel supports.
+ * @dst_bus_widths: mask of destination bus widths the channel supports.
+ * @dst_addr_widths: legacy bit mask of destination bus widths the channel
+ *	supports.
  * @directions: bit mask of slave directions the channel supports.
  *	Since the enum dma_transfer_direction is not defined as bit flag for
  *	each type, the dma controller should set BIT(<TYPE>) and same
@@ -545,8 +706,14 @@ enum dma_residue_granularity {
  * resubmitted multiple times
  */
 struct dma_slave_caps {
-	u32 src_addr_widths;
-	u32 dst_addr_widths;
+	struct {
+		dma_buswidth_mask_t src_bus_widths;
+		u32 src_addr_widths;
+	};
+	struct {
+		dma_buswidth_mask_t dst_bus_widths;
+		u32 dst_addr_widths;
+	};
 	u32 directions;
 	u32 min_burst;
 	u32 max_burst;
@@ -839,10 +1006,10 @@ struct dma_filter {
  * @dev: struct device reference for dma mapping api
  * @owner: owner module (automatically set based on the provided dev)
  * @chan_ida: unique channel ID
- * @src_addr_widths: bit mask of src addr widths the device supports
- *	Width is specified in bytes, e.g. for a device supporting
- *	a width of 4 the mask should have BIT(4) set.
- * @dst_addr_widths: bit mask of dst addr widths the device supports
+ * @src_bus_widths: mask of source bus widths the device supports.
+ * @src_addr_widths: legacy bit mask of source bus widths the device supports.
+ * @dst_bus_widths: mask of destination bus widths the device supports.
+ * @dst_addr_widths: legacy bit mask of destination bus widths the device supports.
  * @directions: bit mask of slave directions the device supports.
  *	Since the enum dma_transfer_direction is not defined as bit flag for
  *	each type, the dma controller should set BIT(<TYPE>) and same
@@ -924,8 +1091,14 @@ struct dma_device {
 	struct module *owner;
 	struct ida chan_ida;
 
-	u32 src_addr_widths;
-	u32 dst_addr_widths;
+	struct {
+		dma_buswidth_mask_t src_bus_widths;
+		u32 src_addr_widths;
+	};
+	struct {
+		dma_buswidth_mask_t dst_bus_widths;
+		u32 dst_addr_widths;
+	};
 	u32 directions;
 	u32 min_burst;
 	u32 max_burst;

-- 
2.56.0

