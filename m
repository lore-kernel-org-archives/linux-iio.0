Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC9E236A033;
	Fri, 11 Sep 2026 15:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789139647; cv=fail; b=OrEC00sSBdmA3sKLxZrfvoRpvC8//rk3zKgGa0ud1ub64v8uYMt9iw+/S9jmEiuouw6qKbC+UEPeK+gajjNp6HG1B/tz2PdlbuaS3roxzNHXznHZ1SW6+iZo+Zo16FlNvd+OkaFYxWyKA46/324cdDU/v/FPlDFJU0WhIHU85rM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789139647; c=relaxed/simple;
	bh=MRC/mbpRBGRT516UV6XN/jlv02HOHc+//yeqN5LHRXA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cBzlUoHsdcOO35EEE5BOAU6KfpwLLyModfup7v/SVA5s5At+sVTiXy1Vyh0MUO5+M8F4CBG24ogOmeGgLV95dXxryXFkntHdvr2eJ1ouR2ce9XG6tkBqxj4CXLbv9MXcLC7qrbxIP4JTv8Lhqluw1lSqVv9yF29qA4FYaJMzLiw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=bQh9pOGi; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="bQh9pOGi"
Received: from pps.filterd (m0516786.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68BEisJt1169661;
	Fri, 11 Sep 2026 11:13:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=WESwz
	suQOk2oYr2bvcUCNFFgqhnPEpZo2MR9yL4K3Y0=; b=bQh9pOGi2hsgBA9xoY65Y
	Q/F3XBYRtlJHCeAF1ZSd70lWbv5qJAF1ewqd1Nmkl+MYBuH00rBobvncPVkdiHCX
	2mY+GphysBVGCX2c6278CGbRlORqdj2AIWCqIVgR+g0KNo3H2vmmhMlNDnAcSAAC
	41YXZw/z2POyF7tX2T0xjac7Bl0acKV0GxJpYDLPVKEGhcJcjLd06YT5UoCGPpAn
	wwmYpHBNb0G2pOcUHpUQ7nL365JkDWfFXRTeQxfHd+8GV7byOf8Lh3C3y3OetNP8
	pBPKupdmt55pmgD65nVBpHyHFxpDW1IFiFOHJ0LQyFsfpi7Zkb3v0N7PFp1nzja0
	g==
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010056.outbound.protection.outlook.com [52.101.46.56])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4gkcxayuhd-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 11 Sep 2026 11:13:08 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tHR1rdC6DiJBy0V4LedJOZdvgtqr6s7mThJM3WMhlzuzwHNWv+nahbcKqOqffoRI0o5J3v8E4e/M++EjotdD++TuyWOxPLjH2MvW5Ywfi9DUWe0Lb/lH2BfAltzHF7THbbcFMJcs36VmoCIsKWAB3zQRgiKIZYuuepvqQN4A5EakyDUjb4bFPArN4NbbCtkX2TzPgyC1p71iekXLIpavCKXBPBubnrREiq0zrbHt8fdQfVTegdPjMYGcWO2oJ+8W3aZ9G6U/I5kE8IzCkEk9I5ZNRfjRY7uRCyP3+vRL/tc6zuy3J0QeRc9/udjB/Ul0lFTQLaarwCVb4Curc1WjSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WESwzsuQOk2oYr2bvcUCNFFgqhnPEpZo2MR9yL4K3Y0=;
 b=Yv8LujEzyT2hDowBjYDzDzcjL/Zs0FnAH03DfzrRzUXXk7Y/ljcJxNUDFz9bknjCtDxWUOLcXnEuhQhSdonMxyOFtbK4xOlvjxjXJfojDpwSP8HgN4qQIzqec08AR1pRWAX8+nCyAUfDKWqRIMWBwCaE0w27GvJx8g6t0t18mvLLTU7rafcMhsUq49qhQ6+c/Rsk6gN73TdLBwR9TSYzbPm98WLub8hKAPJb74GKO8ZwKZ+n/kAJe5tFN/YIP2hTh99YEnIWf42jYi22pFhKujNzAmWKQkA3wLITWetA/7/+TQW6b47A32emBe2yYscoM151BO9EX/qMHdZ+Hzzd+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by MWHPR03MB998607.namprd03.prod.outlook.com (2603:10b6:303:2a3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Fri, 11 Sep
 2026 15:13:05 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%6]) with mapi id 15.21.0406.007; Fri, 11 Sep 2026
 15:13:05 +0000
Date: Fri, 11 Sep 2026 16:14:20 +0100
From: Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
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
Subject: Re: [PATCH v3 1/9] dmaengine: Support bus widths of 32 bytes and
 above
Message-ID: <aqQaUx5Ok8uesHu5@nsa>
References: <20260831-dmaengine-support-wider-dma-masks-v3-0-507d97496f2d@analog.com>
 <20260831-dmaengine-support-wider-dma-masks-v3-1-507d97496f2d@analog.com>
 <apWFa4BFoAL2AhG3@ashevche-desk.local>
 <apWjMBvGA6yo_nCZ@nsa>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <apWjMBvGA6yo_nCZ@nsa>
X-ClientProxiedBy: MR1P264CA0167.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:55::8) To SJ0PR03MB5469.namprd03.prod.outlook.com
 (2603:10b6:a03:28a::17)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|MWHPR03MB998607:EE_
X-MS-Office365-Filtering-Correlation-Id: fd7574cc-11b3-45e8-ddbf-08df10172e18
X-LD-Processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|23010399003|366016|6133799003|10067099003|4143699003|11063799006|5023799004|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
 uGSBJRdoNzbSu8CO5AaxjNEBnvTUFxe7GPxxr5bPs92EKzX1OGFiLc+KJtIZNezPyYzxFRtm/bHDv4S68eZ+hDThEOPg5UJ61PaI14ivMDhp34hyPXnhDaF6do/jqKXoMDXafKd7NoTkCI+a5LnAc1uQvyjgFGvej2g3lQtPW1TOpf9ILFTcWMfRiDof/6tky+0cdHEme1rgXIUIlAcZqxi4DFVI4Ss12m47SE5INN2CghF+EjNOECLHbp1C5QS+NE6zB1Q9q6L/rjwwMTrUrnUMUzPujngWAJaDx7Scc7ANDEsbCGsSgJMio4giaF/LGuEyZQTvYDdTdfe3nVlbKas+xl9g0jV1h1D9Ka4BxUAclXM0jo1x6NHnLiCU2JfO9CPWed5VnojLvS/g03ihk6ZU8EnLu8/VkzZlcVF4IGMNtTaNqoe3Hi/w0+IBC8+Ws68MB5pHcIWaSPgvfQksaU8Ps8j4maL/EVlC7fzdrepipHxqLYVeK2/HlXiVTV4S0fJeC/gMecgzWCd59d3KY9MU700OtSNiqqSIjXpVpZRBqTiHit7NhIj3VrgYWHzrjh+yvwUMVgm/iJWLOeXhYtPCiIlKsuvq4nZaEQE51/fn/AJ9FcUklVTHDEEuNoC4kdKZNP3iLuOwFLLvCUcGod7PRzAmGnwyoM+TiuZpQps=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(366016)(6133799003)(10067099003)(4143699003)(11063799006)(5023799004)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?WkFDYmlTbHpxSEhZcmxrcUxEM2p6cjZRVE8yRkxhSUhnOGpxQ3phSlMwVklL?=
 =?utf-8?B?TW9wUENMSm93aGloSTRQcks5bm1aRDdseGF2T2grakdpVEs0dENiVGJaZnY2?=
 =?utf-8?B?Z1hoUGhta0hERDBvL3ZpWXhCemFqN0FIK21MekRsNmxqY0hscnJETmw2K3VB?=
 =?utf-8?B?Vk5GeEJTNGVaQ2hsRGx5c3dFR0xOOE9PVVdPM0xNRVA5MTBGNStWTlo2Wm5R?=
 =?utf-8?B?UEJOTnZSMUFuUzM0L09XN0tQbGJHckRIclFOSGg0THp6bGwramYxd2JQWDZO?=
 =?utf-8?B?d3R6LzFKSWxwSFIyRm9qbkY0alJjZVl2NmFSWHBRbjZaQzR4ajNJTDdPRk1K?=
 =?utf-8?B?K0RPY2pwaitkMXZGajI0VDlPcFZtK2M3SWVPdWIvRkd6b3FrcURKQU5uejFy?=
 =?utf-8?B?TnFSMjlyMExNSlF4cVFBemt5R2JZSU14ZkVjcXVGZ2ptbUJKbFlVcFB1Tk5i?=
 =?utf-8?B?K0lTMGNLMU10N1kweWxpckt6TXVkWXZVajZLV0ladE9lb3lDVjc5VFdjUENU?=
 =?utf-8?B?UEZPejdZZ2RyMlA4WHpvSjBwaERiblN1R2tqcWF1dGQwVXlneEoxeU1PZU1V?=
 =?utf-8?B?cHpLa3hVU0wyV2pqRVRxNVlIVVFyTjJhZzIxNWVZMmZWQXlwc0hDYld3NFdh?=
 =?utf-8?B?RDJBaW1MVUZ2UjJ1bTVUU0gxK0dJRmhHOG00UTJHVmlaL0V3T3Z2QzJCYWxY?=
 =?utf-8?B?emtCQmQ4Q0h4aHVVMzlPRHVCT1pzQm5MOUdhdXpvSWU5N3Vac0FsUkdFQ0Nr?=
 =?utf-8?B?R003OHoyenlZczRBcXhGRzBLKzA5TE5DUFVDZEhWb1EwUlZKWnlFM3NDclhw?=
 =?utf-8?B?OENnR3o4d0JQYkYwaEpDUEZCTlJIMVlTWGw0TkJnclVKbUMyWldkM0lVT0xv?=
 =?utf-8?B?a1pWMld4WTBwUFhmTXdVeUlKNHdpRmF3Smh3Qnd2WDUvb0xKVFIxWEc5dldO?=
 =?utf-8?B?RTZNWG9ETzZ2bVY3K1FjY1gxUk56UTdwWUY3NXJlVG01dC81cGFwcElwZXI1?=
 =?utf-8?B?NjRrekRsQ0FzbjQ2SkxqUmw2eTIxV240UXVORkdQdXdXM3I0b3VCRStha2Vm?=
 =?utf-8?B?eW44UGtua1V4UnJSU0VrMUJUVklmR3hKMjQxZHJhUENjOGdNTGtMVWRuTHpp?=
 =?utf-8?B?d0tvWmtINVBXYXFsODI4YVBIdmg5MDJqVUgvNkM2S1pZZWVkU3o3TSsyMXRL?=
 =?utf-8?B?WE9Ca25oUDdWUHJaZDVlUFRxcVVia2xRYnJXN2ptN1NvTEdmc0lnVXJRQmRB?=
 =?utf-8?B?MFpEOGlmaU4rNFduYlB3ZTJna0M0WVNqVlJ6Z1VCRkNSZGUvZnhyVkwySXAw?=
 =?utf-8?B?Vm0wYlFsTk00Z3RDbjJ1RDNuZWhQdGxaZnFMMXdsQ2VJTlRjakRCOUErK0Zo?=
 =?utf-8?B?eWFPenI5WVFjRzNiak00WFBSWVJQcVdXY2xaSGtFZCt6eHY0WEpRek9YUTMw?=
 =?utf-8?B?Szdaa01VSXV4WFBGVFgyTUUxZzdGUzhpRTk3NlNBK3ZXcm1sS2tNd1dwZmQw?=
 =?utf-8?B?Lzd0eWdMZVVRU1VOZG1qR3RCUElEMWdpRzE2SjZ5QUNVWkEySkZHRVdteG1L?=
 =?utf-8?B?QktQbFVsb20wUzBsUmZXTFZnVFZTUlBPdEVUL1hEK255U1RaK2ZwSXAraHlE?=
 =?utf-8?B?UTcrWVlUbVFRdU0yVko3Z2wxMVo1TURuRFYzMzEvN2pyZXdMQWZWYnp0V3l3?=
 =?utf-8?B?NmhIMVQ0dGMwYkwrQ0VnRG9IL09vbXJwa21zWjBYUnhST2NibHRrQUNQRFl5?=
 =?utf-8?B?VUZveHoxbkJsdXBmUjdqdE1BY1lBc3NUV3RZS01nNDJZWFE1QzllMlFOZ2d3?=
 =?utf-8?B?YnVBUXFOb0QxeHFjQ1pobktGWHFGVG96U0tQdm1JcStkREtxcUdRYWJWcTZT?=
 =?utf-8?B?OWVBUElxREtPU3ZCQ2VRbWJtdi9BaUNWaEU2NXhFbXptREpwc2dRMzBmc1FV?=
 =?utf-8?B?WHIxTDhzdDVDSGp2ekMrWkVYenphVWNneWF2Tk02Tlhhanl5bmIzMHNOVzJR?=
 =?utf-8?B?OCs1ZisveUxYb01XOTdPcklZenFNUkM0dGVCU1NwQ3NMZGQ1eTdjTE9wK2J5?=
 =?utf-8?B?UURQcnZXSUFpRmlSSktva0dxUGtPMzNXY1hCUEg5K0FyYlBmZFlTRDY2ajlm?=
 =?utf-8?B?ei9MekxkMnhrRlFzYnJxeXBhY3RkMnlMbzJKdEl1WnpwOHAzVXgxclRqQ0NB?=
 =?utf-8?B?OE9qUmJGaDhEUXlhMTlQQjJocXFYNnBWOTBweDFqRSt5d2JJRkpwY3RLVldR?=
 =?utf-8?B?VXloUS9wSjVkcFZzakhhN3RyZTNlaTVEQmdmK3cvNjRieG9Jdnhzem5JYitj?=
 =?utf-8?B?SXE2SXhYTyttY202aXpvUXI5YlZMUWk1WVZyWUlhZjlYbjhwMGc3dz09?=
X-Exchange-RoutingPolicyChecked:
	XV/yhVvQp2ClhPgg8CmYKfFK9UevL6PU8nTXJTxK19pQKl5BzBkVbanOY0RN5hcBvf7UJhiT5MIBgZccucXMuB94VZw1rTtXKHXs6ybX9UiOCDKPhOBTYfbplJW41U7QymOladki43xMaHHEKIcKH/QZLelry7eLnERe5c5ExGs+7/OSHuag5shx71Txc0L5/h7ijt2jsVWf+cFgueYTKIcyLBRlajLlHNKbhwbHvXL1H5hDLNCN6jfl5Sh+D1oi73XNyrylLBKFTJV4Kf9FGixRWvp0OQEBfLYOuOvxVKt15gVKIYfp9x6ELwh2FD8VUn61CP2BnxHludZKtsxyxw==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd7574cc-11b3-45e8-ddbf-08df10172e18
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 15:13:05.5819
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lJUx9AlU/H6E9+7/PsQA7wx6l3vAFwK/ak7+jt+iW9jg8HmVgTiqQ6cU3M399kDPuoyNpoOF/603zHLkXj3/TQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR03MB998607
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTExMDIxMCBTYWx0ZWRfX6x64Nso7rPvx
 CY024XVZKRmDLZfHx7v0NFU27OtJ6b52NDIBf8XieB4hZS4uWVM6yQ1zdu6jp+xOOLh02fMPAAW
 S3QZL/7dLgrH3JZykAezTm+o7tG6ek7wFxrRPzca7yZ9WoVr2w6+uCljmKQcbxibbjRaSu+eSpF
 o7GnrIA4atcuS3BZq94l2zgMLcvtx4iP5L5FmkVkmY/Astd5tOxnczk6PhJsEhyiTo0cRzbscZc
 PNR+yPU0GvZMh4npIO+hi5sgfEcQPzjBsIagqC8ZVGPYA9btSONgoDolf+ldq53d9iv9Gwq5LzR
 5Tvvw2dJ9Cr8HXFzTL0Qxc0YCDB7QiAVeHji3ZNXSOPNtH0AY5Z9z4P5O9QJD1Sx+UvpMqgbOKP
 CB2Iucmo+GvZyRca2a0WXiKxuqJG++O9b3Qy8PqLh3DlYJqrrF6loJeNMb8uEAqIw8VcLga//pw
 YSSeaWvGBNXvYd2dyxA==
X-Authority-Analysis: v=2.4 cv=R6yWitRX c=1 sm=1 tr=0 ts=6aa41a84 cx=c_pps
 a=0PDhd3HO6khzWhHQYbQRQA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=ZQxX5BWu6Z8IJBb2zLX7:22
 a=_CrwtvP5CxvIquhW4fAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTExMDIxMCBTYWx0ZWRfX8D56yaTL0lTM
 bcRZvsTXNwP6+LvRcp/rbFGHajQg0XfJHRvgAZ1i2YN18lpwvWJ/VzJPR1YIvswEhxUXXNvNc0b
 h1OsomRHGwP1isw/ZWUhhJTD1hHRnnAGC3tI5CNpq45mKpYOG9QK
X-Proofpoint-ORIG-GUID: oQDcaZDPEHF8zjofl21qBsLvVUbDG0If
X-Proofpoint-GUID: oQDcaZDPEHF8zjofl21qBsLvVUbDG0If
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-11_05,2026-09-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 impostorscore=0 phishscore=0 bulkscore=0
 spamscore=0 adultscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609110210

On Mon, Aug 31, 2026 at 04:56:18PM +0100, Nuno Sá wrote:
> On Mon, Aug 31, 2026 at 04:45:15PM +0300, Andy Shevchenko wrote:
> > On Mon, Aug 31, 2026 at 12:46:38PM +0100, Nuno Sá wrote:
> > > The src_addr_widths and dst_addr_widths capability masks encode each
> > > supported width as a bit whose position equals the corresponding
> > > enum dma_slave_buswidth value (e.g. DMA_SLAVE_BUSWIDTH_4_BYTES sets bit
> > > 4). As these masks are plain u32, widths of 32 bytes and above
> > > (DMA_SLAVE_BUSWIDTH_32/64/128_BYTES map to bits 32, 64 and 128) cannot
> > > be represented at all.
> > > 
> > > Introduce bitmap-based bus width capabilities that span the full enum
> > > range, through a new dma_buswidth_mask_t type modeled after
> > > dma_cap_mask_t. To allow DMA controller drivers to be converted
> > > incrementally, the legacy dma_device u32 fields are kept alongside the
> > > new masks and the core folds a legacy-only driver's u32 into the mask
> > > when the device is registered, so consumers only ever have to look at
> > > the mask.
> > > 
> > > The new interface lives in two new headers under a new
> > > include/linux/dma/engine/ directory instead of growing
> > > linux/dmaengine.h, which is included nearly everywhere:
> > > 
> > >  - dma/engine/types.h holds enum dma_slave_buswidth and the new
> > >    dma_buswidth_mask_t type. Like dma_cap_mask_t, the type only needs
> > >    DECLARE_BITMAP();
> > > 
> > >  - dma/engine/widthmask.h holds the accessors which are based on the new
> > >    dma_buswidth_mask_t type. This gives us freedom to change the core
> > >    without affecting consumers as they only see (and should only use) the
> > >    new type.
> > > 
> > > Note the fold only has to happen in one direction on the producer side:
> > > nothing outside a controller driver reads the legacy dma_device fields,
> > > so a converted driver's mask is not mirrored back into them. The legacy
> > > dma_slave_caps fields are different, as consumers not converted yet
> > > still read them: dma_get_slave_caps() derives them from the mask when a
> > > device_caps() callback adjusted it. Both go away with the legacy fields.
> > 
> > ...
> > 
> > >  F:	drivers/dma/
> > >  F:	include/dt-bindings/dma/
> > >  F:	include/linux/dma/
> > > +F:	include/linux/dma/engine/
> > >  F:	include/linux/dmaengine.h
> > >  F:	include/linux/of_dma.h
> > 
> > Unneeded, previous entry includes recursively.
> > 
> 
> Checkpatch complains so I guess we assume it's a tool issue?
> 
> > ...
> > 
> > > +/*
> > > + * Basic types shared by the DMA engine interfaces.
> > > + */
> > > +#ifndef LINUX_DMA_ENGINE_TYPES_H
> > > +#define LINUX_DMA_ENGINE_TYPES_H
> > > +
> > > +#include <linux/bitops.h>
> > 
> > Not yet? Perhaps next changes will use it, then they can add it.
> 
> Should be dropped!

In fact, I'll keep the above! DECLARE_BITMAP() needs BITS_TO_LONGS().
Yeah, not great...

- Nuno Sá

> 
> > 
> > > +#include <linux/types.h>
> > > +
> > > +/**
> > > + * enum dma_slave_buswidth - defines bus width of the DMA slave
> > > + * device, source or target buses
> > 
> > I would describe the _UNDEFINED case, it might require some clarification on
> > what behaviour is to expect with this one.
> 
> Yeah, here I can of just copy pasted what we had. Also not completely
> sure what's the undefined case is about. I can do some search though.
> 
> > 
> > > + */
> > 
> > > +enum dma_slave_buswidth {
> > > +	DMA_SLAVE_BUSWIDTH_UNDEFINED = 0,
> > > +	DMA_SLAVE_BUSWIDTH_1_BYTE = 1,
> > > +	DMA_SLAVE_BUSWIDTH_2_BYTES = 2,
> > > +	DMA_SLAVE_BUSWIDTH_3_BYTES = 3,
> > > +	DMA_SLAVE_BUSWIDTH_4_BYTES = 4,
> > > +	DMA_SLAVE_BUSWIDTH_8_BYTES = 8,
> > > +	DMA_SLAVE_BUSWIDTH_16_BYTES = 16,
> > > +	DMA_SLAVE_BUSWIDTH_32_BYTES = 32,
> > > +	DMA_SLAVE_BUSWIDTH_64_BYTES = 64,
> > > +	DMA_SLAVE_BUSWIDTH_128_BYTES = 128,
> > > +	DMA_SLAVE_BUSWIDTH_MAX
> > > +};
> > 
> > > +/**
> > > + * typedef dma_buswidth_mask_t - bus width capabilities bitmap modeled after
> > > + * dma_cap_mask_t.
> > > + *
> > > + * Each supported bus width is represented by the bit whose position equals the
> > > + * corresponding enum dma_slave_buswidth value, e.g. a device supporting a bus
> > > + * width of 4 bytes has bit 4 set.
> > > + */
> > > +typedef struct {
> > > +	DECLARE_BITMAP(bits, DMA_SLAVE_BUSWIDTH_MAX);
> > > +} dma_buswidth_mask_t;
> > > +
> > > +#endif /* LINUX_DMA_ENGINE_TYPES_H */
> > 
> > ...
> > 
> > > +/*
> > > + * Bus width capabilities of DMA engine devices and channels.
> > > + */
> > > +#ifndef LINUX_DMA_ENGINE_WIDTHMASK_H
> > > +#define LINUX_DMA_ENGINE_WIDTHMASK_H
> > > +
> > > +#include <linux/bitmap.h>
> > > +#include <linux/dma/engine/types.h>
> > 
> > + errno.h
> 
> ack
> 
> > 
> > > +#include <linux/types.h>
> > 
> > I would group subsystem ones.
> > 
> > #include <linux/bitmap.h>
> > #include <linux/errno.h>
> > #include <linux/types.h>
> > 
> > #include <linux/dma/engine/types.h>
> 
> Can do that, yes.
> 
> > 
> > ...
> > 
> > > +static inline enum dma_slave_buswidth
> > > +__dma_bus_width_min(const dma_buswidth_mask_t *mask)
> > > +{
> > > +	enum dma_slave_buswidth width = find_first_bit(mask->bits,
> > > +						       DMA_SLAVE_BUSWIDTH_MAX);
> > > +
> > 
> > For easier maintenance better to split the assignment.
> > 
> > 	enum dma_slave_buswidth width;
> > 
> > 	width = find_first_bit(mask->bits, DMA_SLAVE_BUSWIDTH_MAX);
> > 
> 
> No strong feelings so sure.
> 
> > > +	if (width == DMA_SLAVE_BUSWIDTH_MAX)
> > > +		return DMA_SLAVE_BUSWIDTH_UNDEFINED;
> > > +
> > > +	return width;
> > > +}
> > 
> > ...
> > 
> > >  #ifndef LINUX_DMAENGINE_H
> > >  #define LINUX_DMAENGINE_H
> > >  
> > > +#include <linux/bitops.h>
> > >  #include <linux/device.h>
> > 
> > > +#include <linux/dma/engine/types.h>
> > 
> > Same, group them after generic linux/*.h.
> > 
> > >  #include <linux/err.h>
> > >  #include <linux/uio.h>
> > >  #include <linux/bug.h>
> > 
> > ...
> > 
> > It's possible to split this patch to two:
> > - move the existing type into a new types.h header
> > - add support for the new API
> 
> Yeah I thought about that but this still looked simple enough to go
> together but I can split in the next version.
> 
> - Nuno Sá
> > 
> > -- 
> > With Best Regards,
> > Andy Shevchenko
> > 
> > 
