Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.135.77
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792679807;
	b=j8tyccUSE7V8lCYkmszaZ2EOvtSaPQGo3OxjFwhmIzNdImtgPn010yunP38k4xZmdXg7
	 q4Y03jr1ravRGwkxgU2mbIUkUDQw4/4x00EbRGYw7Caio/SWQ4IEEnZKKW306kukXRNes
	 dCWnNs1QCi7KCRSzNd4Ask5tTkF/+MVlDH9q64vCu7BA0ZRprRioltvtYj1A+k7SD3xIp
	 Aucj7k8FOE2eSmjLOjsFAB6d0R1zJ/cx67bHfyQemeLFFgb1KdmBJGBfgvWqzD8uEeWN9
	 ywA5Ohwi9Np6M1REBhhIgkNfwU+DCSmeEoLTGMVbI0yLjrWNxYiLSttJWa/HrRq+wKw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792679807;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:Received:Content-Type:Content-Transfer-Encoding:Subject:From:
	 To:Cc:In-Reply-To:References:Date:Message-Id:X-Mailer:
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
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=kQh7tdtJGf+jHEUQ123EofxTWBcPMaZTCBNL/H2KpIc=;
	b=ylkeLLLib+Vn/Hq5mjqmqWCCPDysHQeaL3297oVbwgPQfqzDymBFjsDcxeyVyuUOMXM0
	 7WXwVzJGpJY0pHiuWTxW2TdImQbR1vrGyR6M5jC0pEpJSRKqoUpfmA8QoAc7/+kN/U3K6
	 UgiCA0bvUxc8T1+XBhrvWzB11yPCObpMAZvZYQQ3dvGKZG1XzAmO0qcjNczvZE3FOUaxs
	 bDsqmcHrqitfHyiCESgV1C0PrLH0xl+HSIk8YLubTvrDWhW71+2jkzBLRqH2RxBidm+ZG
	 ZLoFeJcF413irsBdlpHshrciLtNQ0AnsJHeuqJJtfMWat+AUI0C4mxzbvCgFlCmpi3w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=J9AB9ntc;
	dkim=temperror header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=dd2hAB2S;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.135.77
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6EB606A320;
	Thu, 22 Oct 2026 14:36:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DC6EB606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=J9AB9ntc;
	dkim=temperror header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=dd2hAB2S
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69MECu4v2115162;
	Thu, 22 Oct 2026 10:36:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=kQh7tdtJGf+jHEUQ123EofxTWBcPMaZTCBNL/H2KpIc=; b=J9AB9nt
	crY3D3JoMra0YTA8UoVmEv0jKquHntTl/M7YR3tNOw+QYGfdh64Oss9sZbIPNRG5
	PTZ5vUxTmQSGNrDf7kqXlMGMh30iVPctvA2ZEognlox5m9IYf19ZTKhcjJElVlct
	S+oW1Wug046whcRDap5AVmEOYa0m13kH0rZbmTTbnXFZmJBXaxsEaOSkSY0i3KmY
	VtnDHDyLHxd7E/PJiBSK9UKubAzgtDzqNRLG/7UH9cjhYN4EEpyDOgW90Ch7JOlv
	xsYZzPlA6jFhAuNIrgf3f22MBw4D+eiFirDQCCVh8xxY1a6nOcyBj01jkWSicj0s
	SnVtoSAO1+0eyjg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=kQh7t
	dtJGf+jHEUQ123EofxTWBcPMaZTCBNL/H2KpIc=; b=dd2hAB2Sbw57tmK7HM+g6
	K+xJHI2hUxVtrZs7MmgIk8q9BQLhdMq3+UQKkExW+2oe3gmfpK/VYJL3k3wxtH4R
	w6jRnPHMiKj84bjV++zacKn0PF+xKkbTE3t8H1uc1Wotk2Xf5FHTbG93/qX6gFb/
	Iv9pzLDaY2rK2wqxcBXW658u7XNND05NVHHpEeSYPOEy3voBe/jNdl63CEAWXhdK
	yJegieN0sYednP45UYUlQiMeLu1DQO6w6WF3TEzumiaL6Ym1CapRW8u+2iAg2Pwm
	6LuwjZUOBcGv9M3zZEZZaCdIW5Bg6l2AloTUP5C2DJlLKitt1wKWMxXJ1+K+tDnI
	w==
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012014.outbound.protection.outlook.com [40.93.195.14])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4hf927uuu6-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 22 Oct 2026 10:36:25 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JXxi0fQ/LvVkMN8I1QtxaUc67iUKft1aibczunAVfZsQFyIKX2FPJFjE78BlRTysPw4FsNgWxuwatmMLFnsMWGRFLBy0pRtidgca+lyc6p08Vy0C2iPzjWqjppdTeA+ZFEFXg9RXz9uNiVFEA/Iy275vUKfdX6MlzFaAx3/Xhplf45IjIdJ5F3KfM9tC9OAXCH2Hv+mFKA80Z7DhM2DsMBB6QVHpdMMe+Jdsn3VU0TxFDeNcqFfQdqmFFwgYeA77b6oQYt8BI96iBr/lp4bkKQQ/59ohakaiBCJoSICXa548zIpcllyaA4Tg5ULtgtxm6lB6f2XLKCj9poA6/qdBnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kQh7tdtJGf+jHEUQ123EofxTWBcPMaZTCBNL/H2KpIc=;
 b=Oq4lWAxbWqpWWU37slYlxRbU2xIlol8REsv0JkpbzBso+ZjWkUqQ7HxVsUjWY85AXgnHloOGRYt7OFTyuQrTNLNUeukSUnG/WIbbOPEsQaVxfa+lkJa4LsYf49hyg1M6+Ynq+CvsxPMWw23f0uXDDLD/Ed5jJcP2QqQPCgqO+vChI4xNwjb21t3jUgfi4Db0G0v3PsPsSoGULl6SMTLvzpXLl05rsLLM61q/rakuAIPdAKPmjpqqgX/76ledKfbQDtLt879s/gDBNbgA39Mej7XazFQ54Vm/U8noYERdGbPIg5xoMEIHPuN5PS0t8SucVeYExanCYE338kTt+WFAhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by CH5PR03MB7982.namprd03.prod.outlook.com (2603:10b6:610:214::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.16; Thu, 22 Oct
 2026 14:36:16 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%6]) with mapi id 15.21.0546.016; Thu, 22 Oct 2026
 14:36:16 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 4/6] iio: imu: adis16607: Add FIFO-based
 buffered/triggered capture
From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
To: Radu Sabau <radu.sabau@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Nuno Sa <nuno.sa@analog.com>, Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        Andy Shevchenko <andy@kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20261015-adis16607-v3-4-f972d4efee85@analog.com>
References: <20261015-adis16607-v3-0-f972d4efee85@analog.com>
 <20261015-adis16607-v3-4-f972d4efee85@analog.com>
Date: Thu, 22 Oct 2026 15:37:18 +0100
Message-Id: <179267983879.3584.6208111187400356290.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792679840; l=627;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=DtN+ornrsltWmcBaTQipMZUPDxF9yrr4jv9of/L/faI=;
 b=UmFJhXLirYJJZtdvnUHFT2OY4W97xyY2KFBuNGSQgQvH9ivs/oGKXQ+kdxfBo3psxM9mtH8e7
 d268/uNjopuDIgjnG+hPqgi9rsz9f3bvzqfuKwPko7lSEXC2KrMMJQ5
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ClientProxiedBy: MR1P264CA0151.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:54::8) To SJ0PR03MB5469.namprd03.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|CH5PR03MB7982:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e73c360-9af3-45fb-37cb-08df3049d416
X-LD-Processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|23010399003|11063799006|4143699003|56012099006|261009223027099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
 GmJaiitPQFRUZn07dYELmPt02Gszdmp8lVhYzTajkCZoP48q3EdXo3TDPhWjB0P/36G/VcP+IeHTU/WqZeEKADrItNqcvp2jRuS2tDr+8QG0zPg0o/iqmHAr38mipksywotUazdBpT2avI7K57GRmChkzOA6YU+qhXILUFc16gixDXSDaCQ6Dx2KDQuOlSCAE07ceWkpt2qZsAaXIOsNe81QO63JxP3SlRS/5lFs19szgyrXTwjqOxsxnxScUl2GH4kyEcLDrZFHzMTe7Hdd9dl7N+pmJFYDiu23q/Txq03wW/6LN3dU0GfXxHAjojzV9EtyUAVrJw+Zs5Rj3DkeVnc35gza3z1hAKNiJe3rO+mhixDoxIaNnjYbvmQ6yMbDfdeZeKS1jICLnlBj1KAMlHFFnt3HfZ5W/Vt1KSOtDEhcmrHiFSCwFVZM4jydaiJ2xgAQ3PCAe630qll9RLPleYx1jB9LNY9GIszDn4ostJ6Sp9Ni39qylxjYjma5MmDACpNGN+yJO9ClVivSzh9lWcNObAQxVUaDTtuGg9qM822xwEsnnq2lP2bynOMIt0TcvpkjcQ/UGuKBYoSVnbk3rRcR65nMfpZ0XaZfwkWorYw8YSxwmCjqJemNd5rjum1ujbxVkysJrPn7eFdQ1Y66Z48U8KT29GsbE7dDmcmOtIY=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(23010399003)(11063799006)(4143699003)(56012099006)(261009223027099003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?UFU0K3UvVko1VXMzNTVVQXJZUytERVptSXo1ZHRHRUZHZHR3b2trL3A0SDIx?=
 =?utf-8?B?dDYrREZyRWl0dkl6MEZqNHp0Q2RKSzRBNGtIUTIzU1pkV3hnS0RyQTA0SG05?=
 =?utf-8?B?Rmd1MVBJQlA3WUUzbkZXbzZGSkYwS28rNlR4WlU0SEYwdWlhWGdKTjNmYWI4?=
 =?utf-8?B?NVhDKzZOL3h2VWMxSkZUaTVYdFRTdVRHQTVhZkZNL2QxRmhvWU9WWk5XSlZ5?=
 =?utf-8?B?c09WMGlVQmpEUE11emtvZ1h2RFFURjliS01TK3ZycmdKOElyamsxSmV2MkRZ?=
 =?utf-8?B?UkRxMmJKOXBBRGI1cVdldVpZajVPQXRabmp4TGNnUnkzK1ZoeW5iN0daQlVU?=
 =?utf-8?B?VUFPZ1ZSU1NWYWVRejU1TUxhdHRWVVJZbHFOYXZHK1lDNUtQdG1LVENYdW1q?=
 =?utf-8?B?UllORjNwMTA4Z2J2MXdWS2dieFdTOGZsRFNWSDY1MVJLQW1vZDB3c2FQRVFy?=
 =?utf-8?B?dG4xWE13UEwvd0lNV3FXRXQvTWxkLzJYVHM2MkRvNG5Md3MzR250S0o0T0FP?=
 =?utf-8?B?WjNaa0xLaEs2cVh2anJ6NTN5bXZ4NmZIMmZPc01YRWMrOWlqQzZjMGFrSHBj?=
 =?utf-8?B?WnJzeXp0UUlicjh6cExSWXc0Mmt6bEJtZ29CZmFEeDhCRS85SUtPNFRyTVFE?=
 =?utf-8?B?WHNHMSsycC91OGQvSVBObThDd1lPcG93c1lJT2xGTWxHczhRSlMxRDN5WC9m?=
 =?utf-8?B?Nm9KWE1HdGk2OGpqaTZFSDA0ZWtWOXBwUUxnNWFDZ1RlUTc4RGI0UEVJclBY?=
 =?utf-8?B?VnNSVmwyeFB0TlFxczZvcEZmY2xJY0tLZWh5bXdiV1VESU5oM3VTdWNIYU13?=
 =?utf-8?B?T0puaDBNNFRnL1V3ZmtTZGp3dWdGLzhHSE9oQlNhcllTZndsSUFQaEVXVXli?=
 =?utf-8?B?dGhWbzB2a21sYTk1bFdXcjN4d2ZKVittVk1OdGNZS2t3VGlyOTBSLytjVjdu?=
 =?utf-8?B?MWJ4UWdTQ1JGK2lybkhUWk93MDR0Y0RTaldXcDFENWZJZndzRy9vUEhIOGF6?=
 =?utf-8?B?VWZyU2J5Tkl3bi9DTzJtbWpZRVBDbmZVZHBjV0tHVWtQck1jb3RINkpuM3p1?=
 =?utf-8?B?NnJtNU9OOVpqTkd2VWlKa3B1MEt0Y0pkM1pSNW9hZG05RHFwTFVxekZDQ1hJ?=
 =?utf-8?B?TnB4UTBvSnNZQnZpWWxoU3lGeHFtbE05SlRPYm1ZSXNhZW1qL2ZLMXAzcnVZ?=
 =?utf-8?B?bGhvR0cxSWpOVUI1RjJaSVUxdUtlTWkrYXdsbUxnVkdlYy8wMnBkaTJ5b0dI?=
 =?utf-8?B?Y1pmVGhSd3VBT2tZdXE1aXBVeVpqQ3Y1TU9JckZaR2RuU3VDbDhtczVvcEFP?=
 =?utf-8?B?a280MUQxTDF6UzlEem5oSGE5ZVB4MzhuR1BEYjlnWFlZeFhiaGlhOWF4ZFI4?=
 =?utf-8?B?TlBlQXM3SFRlOEtZWDRSYnJHOUFIKzFpSnBXSSs3L3lITkt2M09vZU9maUV1?=
 =?utf-8?B?cW9Rc2tjV01OTnBqTEdVekpzd0VsSmhkN2pKY28weVdRSGtXek1BK2RXSGM2?=
 =?utf-8?B?TGF2c01zOWhRb2Yza1VUU0ZzYXVtOUJ5d29lSzkybGJwMGtYOHpSTUY4S0Q2?=
 =?utf-8?B?enA4LzgyQUdlSWxkZ1FHTnBVRi9NQkpjdjVMd0ZSY3g0bnd0TmMyZkJKQ2Nt?=
 =?utf-8?B?enh6Si9MS291MFc4aitDMjlkekg1VzByWGhwV2d5cWZKUnZQMy9Pd2dlWHdz?=
 =?utf-8?B?M3N5VDVtMGtobzJxb2hpZjNMOXJVNFpuR1hvWjNQR0ZabS8vT3VtUU5acFp0?=
 =?utf-8?B?cFNxbjErNkZ2c05qaW93WElZaGxKOVdRb0hmdEFaYkNSSnNEUXBsN2xxV2pX?=
 =?utf-8?B?M3pIdzN2K2hBYVUxVlFwRmFVcXJFSWkwcllVOTRsYUZXcU04T3hqVTFjd3V5?=
 =?utf-8?B?cVp2TDFwdDI2bUhxNi9hWFpGTHNkUU5TV3RQYVd4L3hEWDRMRUUxNHZ6d29O?=
 =?utf-8?B?TkdjRUg4ZEdTbmcwWko1citaY0tIaDVEZnROSEJpOWs1TEUrSEpHNXQ5WVpm?=
 =?utf-8?B?SjJLeGJrYzllU0xyZ2Y0RjJyUWsvQWhnUklTTFVOMkdWQkErTHpITERlNDJQ?=
 =?utf-8?B?Mml0KzdKS2loMnBFenZlYjJXVmI2dTRQdERMUnZBdnhON3F1VmRBa1N3YXI0?=
 =?utf-8?B?Q2NxRVBoYk1NK2s3UWhnVXVZTkVOeENtRlFuTXFDSDJQZ2M5eTl4bkRLMlZF?=
 =?utf-8?B?azRtc04xckRXRW5KaUF0RFlxYlJzeFR3dmMzL1I3bTZHVzlNV0NFWEN0a2xS?=
 =?utf-8?B?MVR6SS9ZWUZla3BnMEZKekNkWHIxTmxibFZIZDdsQW5ITGdwUXlvaitTQU1U?=
 =?utf-8?B?V1FiQTI4d083dk82OXY2b1NGS3ZvRUVQQ2pab3pQNVBnOWpYSVJUQT09?=
X-Exchange-RoutingPolicyChecked:
	4rvLc7vXBmssQCrCEYxKnECqZJ8jhRjwGERTmSJtryVRBmZ1qPmhUnU3+N9u3fFRoqIwbX1eA0MQZwUI7davi0K+rp7nosp+GTuPoVoLUIH2AVcIObvTFtndwfteFxaBft7BQtDCmZazDkQdd82JK6ukDP1FiZwjgWiB0JfaBLa1dE+6vIF9LyXHyFc0rHKMLebalExBdZyuWswSLU0p8lcwM4K0SQ3I0JaGRiW2hECTft0yFiQ8SaUvJdEzihNoruBtdX6iimUYulu86OgiwmIEPNh1wIq1MiQ1/S2hZiIvjVZZF5Zf1XsfREXD/Qi1nzH39u/hhaLWI2S4EVWRlQ==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e73c360-9af3-45fb-37cb-08df3049d416
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 14:36:16.1981
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 63O9s0Z0gRYdBtYtHFU/RHrbgKQOebEitkcVfpzsB+0klmts6WjxRiIe1HMzqQ8DtgYR+LXDtJcUSHQvvCmyBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH5PR03MB7982
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA1OCBTYWx0ZWRfXwmT3MfkV8aSb
 ZTU9kf6QrAnmp56DMjSQg/iAu00ZIhu1/K2/EdD/dJiN8XF84X5wKSrKmKadrX4Y1gN9VhPq59x
 A+BCmMgNXByBlWOl4FIc9sG3tzabZZgoRnlev9TA/fMAWMpqPiuR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA1OCBTYWx0ZWRfX2Zr9izfgaBOq
 eQJBlTLht1/osHHc8Ag58xCVue8KNKj1fwbQ204DFkDf+pmaMUEkzIMD3Yp2jgs+FhG9mMqkVgs
 VnjBBgk4e/ACrk/GEB99LeeKet/vc54jdHFckyekPKRKMnOByLsm8b9mTfqJq3kJVVzBNSfukKB
 YEpuss7vMyrPfXT/C4c8g4mzjjMjUMEuCpjOSQ8qUPfrMZqxx/o1D4hDlJ/6Pnkpi5NGZaPF9BO
 WJ+/jmGmiPvhpN63SFVjkGr83wVJgFw97u3fJh1FDfTnTIGYe9cT96J0mvYgqrhXDnr+E8xfv89
 51xcYZjxrol81+8EL/oVXKHyBJxzm6se4hIRV0TybMDM2012Hp48OZKjp3gOXXsGjcHmDxNpBPK
 Zq5ttKFrQ0sP3No4zqIlAGxxWP3f5Ak7IOgIJYsk/toY1SQ7P9OGY6pXr+UEdF+FUOL/1n1oPbK
 01/1hm81kAwNa90OnFQ==
X-Proofpoint-GUID: 3pp62U37oqj5rdQFYyxr18EWM_9zh49k
X-Authority-Analysis: v=2.4 cv=U/cHnuru c=1 sm=1 tr=0 ts=6ada1f69 cx=c_pps
 a=C5q/T6pJLpFJxMBEEzTjbA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=Z0pTeXoby7EwIRygza74:22
 a=gAnH3GRIAAAA:8 a=q3gMZk7u7SkVHuEQnqcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 3pp62U37oqj5rdQFYyxr18EWM_9zh49k
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 spamscore=0 adultscore=0 lowpriorityscore=0
 malwarescore=0 suspectscore=0 phishscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610220058

On Thu, 15 Oct 2026 12:33:01 +0300, Radu Sabau <radu.sabau@analog.com> wrote:
> diff --git a/drivers/iio/imu/adis16607.c b/drivers/iio/imu/adis16607.c
> index 1d471f59f043..dac146645415 100644
> --- a/drivers/iio/imu/adis16607.c
> +++ b/drivers/iio/imu/adis16607.c
> @@ -224,6 +251,352 @@ static const struct adis_ops adis16607_ops = {
> [ ... skip 129 lines ... ]
> +	s32 val24;
> +	int bit, offset = 0;
> +
> +	memset(st->data, 0, sizeof(st->data));
> +
> +	for_each_set_bit(bit, indio_dev->active_scan_mask, indio_dev->masklength) {

Use the proper helper for the above.

-- 
Nuno Sá <nuno.sa@analog.com>
