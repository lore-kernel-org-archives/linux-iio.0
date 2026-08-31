Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C612F1C5D72;
	Mon, 31 Aug 2026 11:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788176791; cv=fail; b=EqP1t3NgzRbq02G5Rlvru+ej/2mXg6NlbYNzh1Ix0GwWPTU41FbvltCadmlVwli9fDtiu9MxzsU5aovY304/MRWClFr9wj3zJF1R0kVCfew7YL9SmAyyUb0oQ8nU+s16T73NjpXRBu3HY/rgGCY9ylIOUH6auKKVfMQeaG4iwv0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788176791; c=relaxed/simple;
	bh=L3zTWoXqw5a5O5elg45zji72d5Z+MGFOr1XPYeUs5sQ=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=YOlyeAdPa2Ief4pn5iLwURkallUXcroIMC+UOHoyZ5fdeQlV2D653ZeZh1L/Zu+2E0jjHfcN0EW1bCnXAj2q0qiI2lU9T0pq428jtzKF8jH85MOgDp3pziC30qa/8htLNXwpHStcF5Oz08LZGYUdZ9rvyiMm1YB5+/yZlrUvbPo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=VQ/2WL0X; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="VQ/2WL0X"
Received: from pps.filterd (m0516786.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67VB9pTR793236;
	Mon, 31 Aug 2026 07:45:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=KDDlD
	NpLMuKV4XAh2Dp6JCydXIqCfjFMue8NJHS97H0=; b=VQ/2WL0X3XByy2RPMm0Wc
	5SaJ6PD8fMJAx+0wzvVwi56r40hagWY6KVKA0oU835FBddmQTPVw/R3sVPLLWXoA
	g+c4UM5NN8xPEPrqnU5F4px3A18tRTzm963PRJY09UNC5DuD3OvAly2Om5ydDt6X
	WHJ3/VslXP2rlQEZN1B733eGYV6lUQmZpb7QLIStjEtBJEUBjoxOwpaEtUDIFnO7
	iwSFKHMe/LpgXP7ekExOJgoEtxPMtvBl0uzV0UB8vCx0KR7TZAHSNskbgEW5JLuv
	xhSru0sEIRZmdVa4jk++4xalvmAIGcP3xCn3xgg7YkNd1v3nIKSRubnl1opuYv0q
	A==
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012063.outbound.protection.outlook.com [40.93.195.63])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4gcg1hu8qf-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 07:45:56 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cAr4H+KR/DkLOlFEf6JkN4tWIEFz9MRW/VmKGk8IO7IotKUMebEc3O4Rv5rS9lWQU7kb/4DGMe52oxCIv45ifOWASJnoqHuJVjPxEVfbSTaYYFK/oAxZa1lyk7u8kAojMh4mJXCsxDi0AeLrGujt7adu/o+GtR5Q4jUcY0bJjAryJ9h5T85t0/x21pF8dJrWCqELNYLdtlX+EFU1VXE1fzE5/CEVymKKaEdizmdyGK9hM80InJolIZk7PSroA5KiTr7GKjLpVo8I1ynRrF/k9AucWWEpZQmuGbnVefxzzio/tY1y4AbGXfs+oeNHyKGySmzci1/B7491IXPANA5uBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KDDlDNpLMuKV4XAh2Dp6JCydXIqCfjFMue8NJHS97H0=;
 b=ADVu1fBrY0oUKx0TBL6Al5DjR9sAV6T8jSNCmBbhkI5DrxYHLr4x0uBbi5PDNTJU11kH2cN70lj2cNkNxro1r4Qq9eZeswuGW++AKpDcs9sYyWWPphDNHzrZ6FtWl48a6H6ho9JO/xlq3odnGXqJqTvqCnao9heikk27B0qdPGHo0u+bWj4WH1BhsPeCMM081Ctle/yBpalw0eCyhfTVUw6q7RDBcxBj+xUIK7Ig3K5AOo4aULEV+nfYilGm5jgTAtYfYW6oWpoEeh4P7psOpsZdQCRvZ8Bgi/oGwQe9c/qABN3KE5vcBCa6fJUcPda/pB/NHVdXjzPhxk2Xt50EJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by BY5PR03MB5077.namprd03.prod.outlook.com (2603:10b6:a03:1e2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 11:45:54 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%6]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 11:45:53 +0000
From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Date: Mon, 31 Aug 2026 12:46:44 +0100
Subject: [PATCH v3 7/9] ALSA: pcm_dmaengine: Use dma_slave_caps bus width
 helpers
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260831-dmaengine-support-wider-dma-masks-v3-7-507d97496f2d@analog.com>
References: <20260831-dmaengine-support-wider-dma-masks-v3-0-507d97496f2d@analog.com>
In-Reply-To: <20260831-dmaengine-support-wider-dma-masks-v3-0-507d97496f2d@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788176799; l=2367;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=L3zTWoXqw5a5O5elg45zji72d5Z+MGFOr1XPYeUs5sQ=;
 b=LhTSRo6RG4gjkpN0Yt6rXtoyMnbvaGHeuioXLqevn6Oap1MKYKrcjI2nHI0nBI0xgeCbOoaN0
 gi2jyTGPWClA+nVBliELT8SKye788wUX9zo8FsD09RtFkBbA1VjMlHC
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ClientProxiedBy: MR1P264CA0194.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:57::9) To SJ0PR03MB5469.namprd03.prod.outlook.com
 (2603:10b6:a03:28a::17)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|BY5PR03MB5077:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c8aae51-8ce5-4dc9-f89d-08df07556993
X-LD-Processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|7416014|376014|23010399003|366016|1800799024|6133799003|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
 F72vkqEm1tsWbDgFSzai9/SR7GbL5SkQQDLmQA3QSb2GwEQhA5OTi/LAidgoXnHOZC+Ilo4BIZUB14tNjIvBU6lS/0toaPhZo1i/syHTMN35e8fL1v/bYj8n4TMymZq/Fdsc9ZjD8HaclG8K7XvIA5oyGVcXd+uxIUbfQIS79GyqS2iMWYRq5FL4ylWbo9y8vbSLr0Ur3t4WpaNHA296Yim9jOe4T5RuXOGor5w0+Uga3CPkozXa17CD6lZEpqgT5TyQTGdHBwHfkBNWO3xQUYX20AbhjTGmAClPe6+WfMfMufFLeeAEF1NBt1XTW1qD+UTEU01TekCwK2SxCgchxzGNJooCIXpzmWfCteVnWCzjrQol4SadM3LvkwCndsPSghxml2+rMWpjSG5WW0jKozN0xbLmg3vHQGAtRPLeslSp4XEGEiJYswsKj4hrh3F7Jrx6BGWWEJJmzoVHoX2iIQOZD+F2v2oqVLOc0gsCwI8TpzvU5qUsOBI0mC8AyYSWM7XEb/VHOS/n3B1x9MTWIPO/ykLDKvEF1l+8gbzZbANRURrEzvwaiyUI/yABap5k3Wrzo5WtbpmkMTQFTDFiaSq/kvCgajWKu4Zh9Eie43gTyeeP7vHHfABPxDfIDlbDwDhmmGkWE2OwK5LXJq9eCzJnnnGFVtrGSIynHhicqaY=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(366016)(1800799024)(6133799003)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?VktnUUx2OEV6MTBuc0ZCVm5lMDlNSGJnRFowL3NTdEFPTlI2cmE5Q1htclVS?=
 =?utf-8?B?QnBtRDRKUEhtVnlIRXpXZjNQdURaTWt1dStmNHQvUnl3QkJIMU5uVXVVSGFD?=
 =?utf-8?B?Z3ZsTFU5UmM4NTJpK2dkLzYwZzd0b2JLVXErWDk0WkhlQ0dlVVNCVGJPd0w5?=
 =?utf-8?B?cUo2cHJoS1RCazczV2k2aVJySzNRWUYrNExhaW1EZWRHdzJncjZ4SFZsbWM4?=
 =?utf-8?B?VlN5d2RYejV5SS9qbXRSRmh4SnNFemlWTFZBeVhzZWlyTXBLeEptbWZQblZj?=
 =?utf-8?B?VnkwaEZoUktyKzFsT2k1M01EWVdPWVVkLytya0FNU09jSmk3eUE5b0hBWVFt?=
 =?utf-8?B?U0Y1alBsOTFVQ21lNVhUOXJ4WWoxZUZHOTE2Vm1rbDhqQWdtZTBpZmY4QnRy?=
 =?utf-8?B?MlhOb29odEI4Q2tPdUZyNEFRTURad1hxWjVvSmNjMmpGdlpzWmhKcFRKUzRW?=
 =?utf-8?B?clc3RUtSRC9CMU5CN0tvWEFoTUFmSng2MzdXbEpPeThjVFkvM3Z1Zkt4a2N6?=
 =?utf-8?B?L09DeFFDQWFkbjdoMnJjaUpQMEs5SkV0bElicHBVVDdHMzFXcUFjSFgwM0R0?=
 =?utf-8?B?eDlhNmpQUzh1NFhiUUk5am91SVZoL2lVNkxHZWFkOTc3QzVMNHBONExMOVB3?=
 =?utf-8?B?Zm00UjJSeHJlbzFyMVlidS96RzA1VnJlbWUvUjJYL2dNbENUZGV4MTFjTCsw?=
 =?utf-8?B?RzdJeWZWdGtpVDRFQmJnYW9mTlNmVVdIQkxLOHduQXRvaFhBNG5rYkRyWTB5?=
 =?utf-8?B?VExQU1BQNzR6M0JUVmpLR2MzVUZtZWx4SlcrdEN4K0ZWRUh2VzhEOWI3TVBq?=
 =?utf-8?B?clN0bnVxU01wMm55N1MzK3p0OVhydXFSOTZpVFFrdk1iSGxDWDM4ZzN1czNB?=
 =?utf-8?B?K1V6VmNSRllxVHE3VVo0QWF2YzZqY1RPNk5jYVJRRTVCQU9NZEw4WEYxYXBy?=
 =?utf-8?B?R3NOclByMGFTY0pzUThnb29wMmNmUzBaY3hPOE1sUDBZQ3cwT3RCaDZpWnM5?=
 =?utf-8?B?RzBMVEl2S3JlbEdMaXFMb2pMUWlIL3RCaExqK3Z5RmxWOSt6SCtDOGs3cktP?=
 =?utf-8?B?MzEwYTQzMUpTazFsSHYxUjdidkJJNHZ6U3libDM1V2xWUWpVbEV6dzhpclIw?=
 =?utf-8?B?dFhOK0NjN3VZN2FHbEVlWjlDRnluYll1a1RmZkNrNW9JbUpBT2pjSDllaEZM?=
 =?utf-8?B?RUVtVjFKWk40b2tQV09qUXZXNWkxSW5zeHp0Uit4S29rSWZhV2d4bTJQZFNl?=
 =?utf-8?B?Z2lkeTR3bUlvTTV1c3ZOWlZWcXNlNTFoYzc1OFdOTlhkNmY2VTFIam0xaTlx?=
 =?utf-8?B?Q3Zwd1Z5bTNYQ2dGZmNlSHdiVytvZTVsNkFITUErdldYZlRieFpROU9MVFJj?=
 =?utf-8?B?OEFMcUhiV1o1aDUrOXBRZWlSOVlzOHFWcHRabnpEYUFNVVF3a2RoaEZuMlll?=
 =?utf-8?B?cWU3WW5mKy9jM2hLRzBTM3I3OUM3OWsyQy8vNnlzbHdlRDNBSURGZWRudGJO?=
 =?utf-8?B?Y3NzR2EwaWhzanN1ZVB5Z3I1K1JsTmcvajVQSUFIQ25MN05LVmxLU0RrZjFF?=
 =?utf-8?B?M0tUS21lSWpNQ0lza2dYV0I1UnZwdVc4M0V3OWhKQ3U2UTY2VE15ZWUxcDhj?=
 =?utf-8?B?Rm1EWW9mM1JkMG1obkcwb1ppaHhhalJhUlFnU0lhMFo4cE5HVXFUOW96eEVG?=
 =?utf-8?B?Nk9oeUo1dmI3ckpadU1Zd0NkWnRSaDNpZG9YM0lha2g4ck5rdFc3aGVkbWEw?=
 =?utf-8?B?V01pSEY0UTcxTE9OSUp1U3RReVBvRFBRSGN5dzY2bzRNckgyL2lhdUg2U1k3?=
 =?utf-8?B?M2lYQVpWTXVOazFnZVhydGNTNDFFbDdtWVNUMjExYkNZVUIvb09GM25LWlJK?=
 =?utf-8?B?VzY3d1dOSjRIR2RpOFR2WWRWUmdTdUFXOU1PM3FOTzltQ3lPNEVrTlZ1TTRz?=
 =?utf-8?B?YnBpSDJPMHRLQVNPeGM5b3JiVFVudVlkSWhmVkZIS1JqWXBya0l6UURaNDN1?=
 =?utf-8?B?NVB5ZXE4c1RMcXUyQ0pxdGRJMktpcWR2U1c4UDZwL0ZpeUFsUlRra2t4VmE3?=
 =?utf-8?B?RXJoWUdyN3BEdUo1N0ZYcTlKb21TaENGQlNFSnFLNFpVb24vRUdEWDVhcVll?=
 =?utf-8?B?NEtKU0s4VytlZ1VYWDkvMkw0TldBTTZjNkRhQ3RmeFV2Nk52c3NlMEc2NWpH?=
 =?utf-8?B?WXRMTWVuUXZuUkJ0YkFuZzNnaHcxOGVqMk9KSTR5V0pYS2JWbkpXczI0ZXBx?=
 =?utf-8?B?Wml4MFBqaDA5SWhrZENGS2tsVHFSV2hPNjkwdnoxRzdOd1VWdGdiTDFXcnNJ?=
 =?utf-8?B?OEo4K09GcjNqeXppTVhpQXFyYnBnVWhTc0drOXpIWUxxakV0cVZrZz09?=
X-Exchange-RoutingPolicyChecked:
	UcZ0sTFdgJkio2BDJQF3mBOMd0qX13A9Iz9ivt5jVw2fQXi4/FszBPgyAb4ncuGDyQSfZeoeximz1WpHr1RnS0eoD7Ts84qXqWHBNzD03Unp6ggQrrfdz2P/SnEnazXjfEFZcD8PubhiUvxWWT97P33B/Vyq3xOYJJC6aUS+48K8q7qEskwInInGjWD/RsSYhLFsnOJs2VghFgJ00O+trvL8DQdhpDMggMbKUWYKmVM2wVKaGUAS3UekOObhqZvnbXHwHtvG/z9xa+0ZU8FdSuA+QDkU+odn+ZW9vaYloHJcc7kvHL298Sluafwb6v1F69ozjNi8ph/ZEMZOcnIotA==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c8aae51-8ce5-4dc9-f89d-08df07556993
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 11:45:53.6080
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s3dV9nO1OYd3VfmGn5dFcd6l/5TnSmj4Sjn7Uw2zrRW47URavqhaPu45kx0gGvvBrJQIX/Z7RqVJFiE2SsnjQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR03MB5077
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDEwMSBTYWx0ZWRfX6ZxDzlHIa+K3
 JaIN0UGVmVExLEQoEc05mmwu55J28HoUl6dx7bNWVamtrWJsABMvOiIGTIxW7etclT1lm4BUCQl
 nwzUmxyKp8yb3FYyUUa2kYOqS2/2+fewaGqc17um1LApV+8tNpy8fOB4A01hQlX0Yyd9dPJX25p
 Dc7LmscLMIaje4DWwfeO0rqFNOJu3r5oDfsQucI24qj+E6fGpUukxdDGQlhC0ShpLS/yKtCdrnt
 UMTkI8XTmsBqc3/kXAFITV3+4IBKoZxyCTKqM0cKt4pTQ1L/mH+jwE169l4U503/s4yV35TKHGe
 jbEhGaTAk01tx3n7iR1BL69F3kqtxIV0rNxWn0uaXa9hJGYd5i8ZPEklfM6HSiPEFSCwvAwQJvq
 zIHpIwI+qEBKA29hURPjzDk8bVOIpSdcA/V+XxpMoTalFIQ6L52yqbyv0Q6VFbMIufpqnzxjoq6
 vSSpQ/AafxlxatDrSPQ==
X-Proofpoint-ORIG-GUID: eoysnMgqMN60DCUAxeNZJPKF3u5FkPaC
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDEwMSBTYWx0ZWRfXyeiyb9vx01Ky
 KftMwCmw/Oln/smJVsbQBF5W53v0SojjFegutMvP4ZDfj9stj/nnDvd7VJ8SyYG8w7PGLbZykUT
 6yShjgnEQ1tkRQyYIC59moesJxGZUZkOfHrPyn5ATi3t1WK7GVB7
X-Proofpoint-GUID: eoysnMgqMN60DCUAxeNZJPKF3u5FkPaC
X-Authority-Analysis: v=2.4 cv=fLkJG5ae c=1 sm=1 tr=0 ts=6a956974 cx=c_pps
 a=LrO9QPEl2oM1zDNvT4V0vg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=ZQxX5BWu6Z8IJBb2zLX7:22
 a=8AirrxEcAAAA:8 a=gAnH3GRIAAAA:8 a=RbNyKOt0vjK77hBBhwsA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=ST-jHhOKWsTCqRlWije3:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_04,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 impostorscore=0 malwarescore=0 phishscore=0
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310101

Use the dma_slave_caps bus width helpers instead of reading the legacy
src_addr_widths and dst_addr_widths masks directly.

Keep the existing default assumption of 1, 2 and 4 byte widths when the
DMA channel does not report slave capabilities.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 sound/core/pcm_dmaengine.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/sound/core/pcm_dmaengine.c b/sound/core/pcm_dmaengine.c
index 1306b04be171..2dbbdeae6c4c 100644
--- a/sound/core/pcm_dmaengine.c
+++ b/sound/core/pcm_dmaengine.c
@@ -11,6 +11,7 @@
  */
 #include <linux/module.h>
 #include <linux/init.h>
+#include <linux/dma/engine/widthmask.h>
 #include <linux/dmaengine.h>
 #include <linux/slab.h>
 #include <sound/pcm.h>
@@ -408,16 +409,24 @@ int snd_dmaengine_pcm_refine_runtime_hwparams(
 	struct snd_pcm_hardware *hw,
 	struct dma_chan *chan)
 {
+	enum dma_slave_buswidth default_widths[] = {
+		DMA_SLAVE_BUSWIDTH_1_BYTE,
+		DMA_SLAVE_BUSWIDTH_2_BYTES,
+		DMA_SLAVE_BUSWIDTH_4_BYTES,
+	};
 	struct dma_slave_caps dma_caps;
-	u32 addr_widths = BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) |
-			  BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) |
-			  BIT(DMA_SLAVE_BUSWIDTH_4_BYTES);
+	dma_buswidth_mask_t bus_widths = {};
 	snd_pcm_format_t i;
 	int ret = 0;
 
 	if (!hw || !chan || !dma_data)
 		return -EINVAL;
 
+	ret = dma_bus_width_set_many(bus_widths, default_widths,
+				     ARRAY_SIZE(default_widths));
+	if (ret)
+		return ret;
+
 	ret = dma_get_slave_caps(chan, &dma_caps);
 	if (ret == 0) {
 		if (dma_caps.cmd_pause && dma_caps.cmd_resume)
@@ -426,9 +435,9 @@ int snd_dmaengine_pcm_refine_runtime_hwparams(
 			hw->info |= SNDRV_PCM_INFO_BATCH;
 
 		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
-			addr_widths = dma_caps.dst_addr_widths;
+			dma_bus_width_copy(bus_widths, dma_caps.dst_bus_widths);
 		else
-			addr_widths = dma_caps.src_addr_widths;
+			dma_bus_width_copy(bus_widths, dma_caps.src_bus_widths);
 	}
 
 	/*
@@ -460,7 +469,7 @@ int snd_dmaengine_pcm_refine_runtime_hwparams(
 			case 24:
 			case 32:
 			case 64:
-				if (addr_widths & (1 << (bits / 8)))
+				if (dma_bus_width_test(bus_widths, bits / 8))
 					hw->formats |= pcm_format_to_bits(i);
 				break;
 			default:

-- 
2.55.0

