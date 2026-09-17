Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0EBF4CA796;
	Thu, 17 Sep 2026 10:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789642444; cv=fail; b=eGMXi1Ho9F0iQ5G2bwnLsOhZudGycgX15AB87I+YAse2hZknm3I+6alXQF0axONXk46c96qnrwSRskP4dyknec8P2x7UlJrCMupSQ6UWKXM0mA4+2aioDH0hhqAywS+otAcqNEdompt9uhDEdy9ldnirM8/UYTYu+wqUAQLUR5k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789642444; c=relaxed/simple;
	bh=XyMPe9afKmLCAFBAhWREIzMpznNaybOAMBrKQ9EZ3QU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gphr5eBq00wRdHtLL9S7vc6Vqqqe6OQIM5ShZwAr0QPMWfO3V6eFbZ1cBahX/QAZp3o42UvUOQJLMjaireN4TfgESulRq/IUZG7c3KHU4ys9RNeawYxh+MastViZZnccFmM3jKJOEv7i2gs/WIZnEz3LskpMxkwPj4B0ccjfP8I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=p3D9zhil; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="p3D9zhil"
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68H9bjeN3448285;
	Thu, 17 Sep 2026 06:52:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=945N3
	ROTKKyt5n+GZ2APYWFrqNecStUiymmioN1UcSg=; b=p3D9zhilnL1CzbAlWKz7R
	jqxFFEkZST1aGbdz66T8rRFZJPqXll5SXIcsOi757/GtFJK2jToHo4NfAJ6aZRen
	6zCNZZBl+YgrGMenbp+fMzQ8DXsDaTLhUJYc1Y+4hAZnICH8hU0l4oM/J5pPi3/5
	Z3RH0n26PFGm+AjNgOnLT+/hnBAZdUIH1cQKCGcfN4LTXKBEthnB3sE8LdOsn0+a
	WMCvmMOpgOBlppBOMVyD1lgYl4IdJ6PFJPQlrwHJxJ8lKCy945Z7G+oROLqeqc9w
	l+D3RJBE1UAourjJsMEmZvJQqe4SKWwdG0jKd9ApsDXzskMCFqLLbziE/Bmw3KDd
	A==
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012053.outbound.protection.outlook.com [40.107.209.53])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4gr7mssgqq-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 17 Sep 2026 06:52:48 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t+BVn7Fq8jlrzE05Y6Lyi4A28O1kYLs1e1gUQTjrHKzYA4cJTkbOXTdTa5g2KLjpdkwcXD5f25qLKrCUMfMaIhlyEfTXynFuRLQ/8ejCQTQp/+s3RIWbc7OGfLoei+lMZvkPOMY7rPl+S+hBfy74+p3h+1K1bYEpuJwdU8BThCnu7Nh73QsfHj+J5xmZpCIT7qAst/OS/qkbQE1Boklml88QpGbIFY0PA/DKKuRoIaKV21KijydT17Wbz2+HVAt3frHxpdLHflHc9lhfoOpdmwr5b9iCIBwlJoifm+/ISyG4Bpqgv+IclBF3Y0ocQZHFbLb/ul57ZfEAaJ7Hbg7WKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=945N3ROTKKyt5n+GZ2APYWFrqNecStUiymmioN1UcSg=;
 b=BeDatjsDW87m5g2fhERvUKPGR4cODBDXw/jC8IPfoQiWUlRvSuFcK1giNcqxtdmRHS3b88k4hNUJ0+MGQWUa6mOR7b/zWthZYtrYfSciCnAwygRJwtxOXHV4J9wychk12AwVCSe+GY0mE0q2S6Mh9orsJBea1pDKs8MuEvQpDzwgFaEh0FZAsnScXj0HkMDF+JkRK0vhUeWkIDIZTGSeJjVZTwX5ktG/oY7XxTR1SqmQ0o9mkGek/WN/JpX1U30GK9av0xRV3+ejyWaHtIcNQvgiBmH+ZsqIjdBlReMEYqXSKcyQXugVX/fPFSUAplvl0Y79w/Flax3/YJhP0WILTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by SA3PR03MB7394.namprd03.prod.outlook.com (2603:10b6:806:3a1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Thu, 17 Sep
 2026 10:52:45 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%6]) with mapi id 15.21.0406.007; Thu, 17 Sep 2026
 10:52:45 +0000
Date: Thu, 17 Sep 2026 11:54:00 +0100
From: Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Frank Li <Frank.li@oss.nxp.com>, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-arm-msm@vger.kernel.org,
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
Message-ID: <aqvF1aOtAiDrC_MW@nsa>
References: <20260911-dmaengine-support-wider-dma-masks-v4-0-72b8fd4cc78e@analog.com>
 <20260911-dmaengine-support-wider-dma-masks-v4-1-72b8fd4cc78e@analog.com>
 <aqgCQvRw9fns__0d@SMW015318>
 <aqjzvxI4ecoFvRLT@ashevche-desk.local>
 <aqlYOHIFU_dB72I3@SMW015318>
 <aqlb5iZQ07Xicq0m@ashevche-desk.local>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aqlb5iZQ07Xicq0m@ashevche-desk.local>
X-ClientProxiedBy: PA7P264CA0142.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:377::10) To SJ0PR03MB5469.namprd03.prod.outlook.com
 (2603:10b6:a03:28a::17)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|SA3PR03MB7394:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f0bcfcd-1f68-40c1-316c-08df14a9cdea
X-LD-Processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|23010399003|7416014|366016|1800799024|376014|56012099006|5023799004|4143699003|11063799006|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
 nA/kvOHXrZsHdUOMeArqVpv9O9p16GrbXXIdqgVAHJK1vHFl+Q1J4lxkesgWtIRpfjD8J+Y7A2MlTy/bnSgp9zRBO+QDAxS8tS1o4nE/cJ7tWWy/tqfF9uBfwO0rJBseUFrZDuuKBcSU4l8OiXglWeQXKIR6FAUXf90Cz+RLWlbqIH3FOQhMktTRA4IKSIjovfizfes9mAEAkE4EyCkyKRmLxGIbXujsP/mnIzeWuMJPKa6t7c7bPNkSn5s8CeQUn5AkFUilDwoysMXFStgJwi0Yrcy92xKMQU7XPWIcyjKvOyA1YqF3aC1yEjTtCak6kGEgvmNmQqfCNeuiEK/LJoMQiPomvCoSaVzpuNEdlZzcN1CCp3RN6fxqVBM2O1nDgLqCziuMBImcy0sbiFwmYKGjjyz0SkoEJ3HdX1iMAM9in5Qd0mOmueGu9hTWiHRZhxL3por/rHJASFX4NTOzHeeC1Ntw/jeN9FOBQa/Uex8eaxh6spSPJ2mGT8rlQtLpPYfMMKfMY8LScLGRr3zIVogJPoYtLNIzSdvCBwXB4+Us0NXkN8sIOOvpyn0tTPStpe/oTfdwF0Q8AOHDpm5vzEihhKvP/0ITmI/RrIbwZUrcynPKcFkjGzkiRFBTULY4Pt5JAdMay4O7WqqG8aAYiFsDSLlk+2DI86Tul87Z2gQ=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(366016)(1800799024)(376014)(56012099006)(5023799004)(4143699003)(11063799006)(10067099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?aVdCeW9kb2RUekZpMUlKNUVOZERxd2tWdWpySkNBdkRReDNacU9XdlByTmdN?=
 =?utf-8?B?QThhZXFpeHN4YWRQMFZUdjU0ck1FYlBHTllPSkdQL3dGN0tLVjUxS09JNkJQ?=
 =?utf-8?B?UVBheEZoVVUzTTVNQ2RkS3FZTHN1Zk40MU44NTE0OXBNSEJwVGkzNkpZb0po?=
 =?utf-8?B?NGJyMGhCaHJHVXJFek8rMDJpNlJUNnFPVHZYVGVaYzJhLy9NV2w4SnU3dDRr?=
 =?utf-8?B?eXhXTUs0NWs1RlJYTGVTVXhTZjZjZ0pqdjBKcThVRzF2ZWFUbkpRZExvZy9K?=
 =?utf-8?B?bzlFL3FzV0RYSm0vMm9HTE96bk1MNWRDazl5SEFrdkNzOHdXM3ZNYVAzeTJr?=
 =?utf-8?B?S29QOGxMbFY0RlVtQVRHQnBWeU5TRk13eDgyUXFLUWVwK3NMZmlpU1BGM1Jm?=
 =?utf-8?B?c003UDBaWi9aNjNXUHRGL2d3NUt3U29QRkt4VEVFRmt5cGlobzA4RVVDckdk?=
 =?utf-8?B?c042aFJJMndpaHh1OGpCaW1ReS8zcnlvSTkzY1V5SkUxMm1IY09hMFFhY1NE?=
 =?utf-8?B?MStWeXRhRy9oR3BwaitPZmRtcVBKZmlOclJBMVlCdnVhZlNCWTJkRE1IT0NK?=
 =?utf-8?B?VFE1TGhvZjNBUkVDNjVFZjlUZ2xnSDFDamxDLzJVN2oyU1kxUTl5TjBHV2RM?=
 =?utf-8?B?ZkdtT0JsSng1cUJuYUpKOXdFazJuYjJkT0JWdWhYZDhncTVCV3NmZmFBT0Jq?=
 =?utf-8?B?eEhMcVdBcG5xMWY0MjVESzZJZWZvZ2lWbVgxakdFNzUyL3JZcm9qV1l2Ny8y?=
 =?utf-8?B?QlhhNTM2QmgwMk04YWgxcEttRW9ESmIyQ1BmUTZ6cEI3M1JFdUR1Wkw5MVFV?=
 =?utf-8?B?Q0ozREdzQ1dOK1lGaXNLdUlFRmQxTWlIOEtjdTc3SWtKODVia0pKbnVncXRF?=
 =?utf-8?B?S28vek13dU1HdG1QbFFlYnl5dmRzUllDdUZXb09oYXpZWkh1T0ttOUY0aDRW?=
 =?utf-8?B?OTJiZEZockxTWklubmh5V1p4MmNrNnEybk1Cb0hGVWlDQ0NJejFXRVk3bElF?=
 =?utf-8?B?QTl2Mi9xekZrN3ozUXR3Q0E3UGY2K1RUYzRkSmZqczFPRTZFRTVxWWEwcVdu?=
 =?utf-8?B?K2o2NXlIQ2czaEJwK0xFVDY5UmpJaXh6UkZRc1RaVWZzUWZwU00xUmtvRGVr?=
 =?utf-8?B?ZzNDc0ttbmlnVGdhVWhuS0h4RVk1VWg0eGdodHBzdjdBM2lLWWppcFFNVkQ4?=
 =?utf-8?B?aEtkRVltdmlsQ3dlYitoK0dpNjQ3YmZFRFJGRFMzTDBLeFNqOStvQWEyV0Rm?=
 =?utf-8?B?TXJhV2JVbzREMmlVNVJQQUljZWpBVVFoUm5GK1hZaDZ3NjdYS0FUZUd4Umpk?=
 =?utf-8?B?cjdWWUJ6dzlsSVdFUWlmVTZpR3FhV2sxM2RxYjBsT0Q3dG9paTFnVlRSdTJJ?=
 =?utf-8?B?T2RIbk1SNXRTZzBrSVluY0V1N3hjN2tkaXRtS2duSXdkazVrOEJxaGJFZHRP?=
 =?utf-8?B?bTBPdjI1RGJ4YWVsWWpkUS9LV0x2Y1hIaktDRFI4QUZTTDExVUdWdHFNTTVB?=
 =?utf-8?B?Q0NCM25YL0Via0h2cmR5dHFLb1M0T1d5aVl0akxudS93RmZWbzlOcmE4eXky?=
 =?utf-8?B?MUhxS0Q5QmN5azF4WExCNE5GTjR1TWdwVFFiUHZkK0QyNldFWTBULzE1bFJ2?=
 =?utf-8?B?YklFWmI4SVVhVnlycnljeWt2b2ZXZENha1M1YVVoMVBIR0xyQjJLZzhsWkUx?=
 =?utf-8?B?WnIxdDc5WW1CdVJBay9Ja0NqeEVtK0xET0FEWHhTdDFIT3VrQXl6ekd5Y2tI?=
 =?utf-8?B?QzMzWnlITDdXSlYzQVdOcGhYZDdwVm51OU9VK0ZsYWtNSkJ0Tzh5bERzUnJY?=
 =?utf-8?B?SElxS0tHbzNJdjVCeTlQcWE5MVhpanRpK1FCS2kvOWI0ZUhlRHFZSDBzSWVC?=
 =?utf-8?B?MzVFY1NYamVBbHRxYURFdVpyQWlIdjBZKzdYYVB2ck91cnFNOWxnNWJRUSt6?=
 =?utf-8?B?akQvUlIwMGcxZmJMYkJmaG5zcGtUZDI0Tm9JZHhtS2wwVm5qYnVPTXZqWGZq?=
 =?utf-8?B?MWxGOG9FaTVPWENjejgrMjR3NTNhNkgxa3A2bnpxdUVmTXRJMmQ2NDI5S1A2?=
 =?utf-8?B?K2JUS3owUzNmT2lrdUZQeFVYN3d6N0xETm1YWVplOFovMVFTYmJMR1BnUTQ4?=
 =?utf-8?B?T1VxbDA4eWlhek9qYjBIUEM5UmVybFh1Y2dNNmRFVGd2TUJUdk1hNHdmR0Vr?=
 =?utf-8?B?WDhacHFlS2pXeWVXRE12ZWdpNTJTR2hvc0VEOXNMMzh0UzgvZXV5YlhvYXV0?=
 =?utf-8?B?VEt6blZubHduZlhTQXM2cndWNnd0aXFIZk1ZbnFSQTlzeklwUHRGYktKTVRK?=
 =?utf-8?B?a1JpNzljS080SU9meFk1N2NlVTU2WCtOdXFNUmNMRk9acFFhbnNiUT09?=
X-Exchange-RoutingPolicyChecked:
	Ozt2vMsaPiMnTfCagdztP4xftNKj6VqZsB0DmkmVkSacZHab448RXoC6lsAzMN+bSsxTLLPeIJM2d7xgFSKMFPaw0oWnjG64Vdr8+GBLDqhMIuIfZWRypO/DuoIW6gRTH8jATmoc79tZwsHrBarcfO9qKashWeBtJlTEi/Sy/JcEuFkroxTqRZxRbCXQp71IV2JaONe+TNCt6tcpc/tn0llKSVczxc7PF9O0kSAKS6qdONNt4Jm1uFflFXi2ocfTee4bdMyUVjQ8fU0bamy+PqX1Giz3VywlxULUcvqUNK4PZvgNV7mnne3WHx/WvlOrvfm+iaEX7G7eflhil8WPAA==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f0bcfcd-1f68-40c1-316c-08df14a9cdea
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 10:52:45.3790
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UBxKTODpJ0g1wkn5h2oGxpt/mrqbivOR8gYQNHHWXaTpFrzdGb40SabuiGFHhWFSCdy/5bUzU6umI/OD5rncqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR03MB7394
X-Proofpoint-ORIG-GUID: wDhmLOXkbuqfh76rHl4ISmJ8PGVHuCpm
X-Proofpoint-GUID: wDhmLOXkbuqfh76rHl4ISmJ8PGVHuCpm
X-Authority-Analysis: v=2.4 cv=HbSB3SE8 c=1 sm=1 tr=0 ts=6aabc680 cx=c_pps
 a=5XdDR3/zV2dQAmk0xmzXVw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=ugNRTJOwpmtT476g4l8T:22
 a=x3-Y6h-ff87WvRF2luMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDE1MSBTYWx0ZWRfX/S9bj5RSTk+r
 BCrXLs8kDU8AYmVyUpcFjqivxlidecppP/H7yGObYFgfM1kNQgF4vImFax93mUIzc9iUgAUuMTR
 J8TXIxZsK570pOrtHdyOYnzOXmF2ABOKtVakxcK3TEL1fBtgMgxmYrOj7aMb//rBE2C1f/F3teo
 ldyu9umk1NREOCinnpTGo8FgqackV75a/T0FyvNvRTFBHDoyEpG7euJHjEKCpUOt5k1JmBsgSP0
 3fcNwgdlx/qu/wAblRvIkWdFzewLpO+u8IXKQ9z+LDi5Gt1bR9YFZru6DJqM0IqNZqt+teFkFQ/
 UoGTTj6Wzfy4ar4aH708Z0J3lhn4wLA49xRajxRqTcsa0l7U8yPSi20EMqOkLGg+KWkjUT7ftoH
 2fEnx4tPQumfKo/Ve34jUQ1ynWBb/Tkd071wH5dX5HK85ZP0MyAdjf6pA9WD20vTdKPxwfpgk8I
 ryBln6Z7BYve+PYGjrg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDE1MSBTYWx0ZWRfX8lCaXeboios/
 JLJFBQSa3dE54xo7cDB+Ar0ogdguaFpHuFXZP79VvG/rGDnIfrAKO+2W1ktH/crlglz2iAqm+Vf
 FyXQRV+KFPv6RLB/G0h57q7pqqLJe9IyDTW7Gum+TrogNPo/6F24
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-17_02,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 adultscore=0 priorityscore=1501 spamscore=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609170151

On Tue, Sep 15, 2026 at 05:53:26PM +0300, Andy Shevchenko wrote:
> On Tue, Sep 15, 2026 at 09:37:44AM -0500, Frank Li wrote:
> > On Tue, Sep 15, 2026 at 10:29:03AM +0300, Andy Shevchenko wrote:
> > > On Mon, Sep 14, 2026 at 09:18:42AM -0500, Frank Li wrote:
> > > > On Fri, Sep 11, 2026 at 06:25:36PM +0100, Nuno Sá wrote:
> > > > > In preparation for the bitmap based bus width capabilities, move
> > > > > enum dma_slave_buswidth out of linux/dmaengine.h into a new
> > > > > include/linux/dma/engine/types.h.
> > > > >
> > > > > linux/dmaengine.h is included nearly everywhere, so growing it with the
> > > > > new interface would make every one of its users pay for it. Keeping the
> > > > > basic types in a separate header lets the new interface live next to it
> > > > > without that cost. linux/dmaengine.h includes the new header, so its
> > > > > users are unaffected.
> > > > >
> > > > > While at it, add the missing kernel-doc for the enum members. The block
> > > > > already opened with /**, so kernel-doc expected every member to be
> > > > > described and warned about each one of them. Describe the UNDEFINED case
> > > > > in particular, as its meaning depends on where the value is used.
> 
> ...
> 
> > > > >  include/linux/dmaengine.h        | 20 +++-----------------
> > > >
> > > > I think it is good to split dmengine consumer and provider header files to
> > > > hidden dmaengine's detail.
> > >
> > > It's indeed desirable change. but isn't it a bit out of scope of the series?
> > > I suggest to do one step at a time. Would it work for you?
> > 
> > Yes, but I hope the file name is finial expected file name. it is okay
> > just move enum dma_slave_buswidth to there now.
> 
> Hmm... The whole split as is in this series is due to bitmap.h and the whole
> train wreck with headers we have. I haven't checked that particular enum, but
> if it's possible to gather it in one of provider.h/consumer.h at the end, then
> yes, we may name file accordingly from day 1.

Yeah, as I said to Frank that enum is used by both providers and
consumers so leaving it in types.h makes sense to me. I also realized
that the current series is relying on widthmask.h (or dmaengine.h to include
types.h - for the enum). Might be acceptable (and needed for legacy code
just including dmaengine.h) but I wonder if we should not explicitly include
types.h for new (or converted) code.

- Nuno Sá

> 
> > > > suggest name
> > > > 	dma/engine.h
> > > >
> > > > so we can start move more API to this files.
> > > >
> > > > after all user include this consumer header file,  old
> > > > include/linux/dmaengine.h rename to include/linux/dmaengine-provider.h,
> > > > which only include by dmaengine drivers.
> > >
> > > Traditional naming would be
> > > dma/engine/provider.h
> > > dma/engine/consumer.h
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 
