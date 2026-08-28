Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF483F1075
	for <linux-iio@vger.kernel.org>; Fri, 28 Aug 2026 10:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787913987; cv=fail; b=ZDc+EI4e72RWPp2prGwh8JfswRZkjOHwFY2YiFKuMkVLuGJgDnlAtrXTbadSmDmvWq4jfq83j8YZuAaecvkiKIs+2rwj0/OEi3cfg7ojSt1fw/W3tI7Yjq0Jquib5tZLPIKTaqNrRhdHlkpk8y9o+tkqSFw15xlNDVKp1R3/TwM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787913987; c=relaxed/simple;
	bh=ioaibFikTWdXXPIeRxDV8SA180kgzBHNKRxogwkHemU=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=aqWguWaInwP7vy/jwv13B0fZQstI7T218iN+BjB1Kf2OdUPh5sBwqP5bKYr6Bpl9VdUmdyhjoDK/6xEHVYLf+9y/3oXyKgzeX4xcfCTYOn8Zt2L7kTg3KDyUEfw+CdR0Xod9dE7n3guMCr/YKb3FXQWF7SOpOB+PuW1yQ2gKa2o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=HRiFqkPP; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="HRiFqkPP"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67SAAmg31173851;
	Fri, 28 Aug 2026 06:46:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=2ydBCbBZgslT0phMquDG5LuM4zz
	Cz6yOZmQMj3Kox7k=; b=HRiFqkPPDJ3XywJE5YPPuVNJ+673uWNU7A0dnGTGns8
	YTRjzHAdkHqIl0ItveWb2DtC/5pEJn/IVBWEeOXwVZSnJzDjHVjseCrEVFf2O0cE
	TBBaIW9zN5YMVxgBP0RkCQZZnyJ5cOFRAosKgVNuPHXXIQaUeNKM5k6QHHGDb4Oi
	nLMLYs/+zGoVNvmj/I3l3zSxolN1kUZsdx6X8jBdiwiqiWJOkbCicAfxPpFh/TI+
	7vaOE+BmgSp5Nih5ZEUfVGdlcCGLRgUmZxtR2JANnpZe34JYmlk/JAGaX1tCUjc2
	l2pdsoCXZgDwHVcWpap2GwmS8zRXMH2tWVr28kOp+ZA==
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011015.outbound.protection.outlook.com [40.93.194.15])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4gad897gcb-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 28 Aug 2026 06:46:21 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DgNdLGZ6rM8uMKAo3ZD8JERA+6C9hFNEmihq8fDGFtVjuV8AlFXvxJQUvn5AlI009N8YMFiBmkngr4o91EFMu7NfpHqEeM/VkU60PMqK0b3yfsIErX7eHefDrvPCWkJRwCQJ23CwuLKIyNtQSvgUUiyyO4LD0jhSqIz4CkkjCNuAwvFBqXP5EQVNsvz7RmJQJg2BfELHSY0CqnYwfsKJMf99Q48bDCQoO18CmvhRxxUT613p2OENZYUCm0mBQSxrPnFmqa5xhQbss87RaH9PepazSXzDt1DuRs6OJReFgGMuGqsMwZ0Az4QoGmOXNiMPP7dz945GpFvMhnvis+thBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2ydBCbBZgslT0phMquDG5LuM4zzCz6yOZmQMj3Kox7k=;
 b=JRWhjOWcqaRqnSa8zFYiKuEVXGPv4GtopUqSHPsULUIEewOXVJzVSpTzbh6yA85mqfg3jDaZJ853Epcg0KhvXL3M8Xqt+VHipV/cdUr4ynFKGBJN9y8VxT7rrwdVOx68ywRSiIAsAfkmoY8t99zjqeV8CDtDvvAnupgz8FgAR3ZUXo6oV9KYrt9m48fcgjKfYwiBZPyXlwEUSIQwx23vkZ5BQO61ze/rTNfIlUKb27W3sSa2lEtt4xhIYr8xmsbw38Oy5j5ls3ORykBRJwo2lfxocl3AS/BAEzRSsz4kwW0Xn/FQ4AvF2ZjkPrY6WLN7I0B8Qj34leQXqDJY1S3I7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from DS7PR03MB5464.namprd03.prod.outlook.com (2603:10b6:5:2cf::12)
 by PH7PR03MB7267.namprd03.prod.outlook.com (2603:10b6:510:24e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Fri, 28 Aug
 2026 10:46:18 +0000
Received: from DS7PR03MB5464.namprd03.prod.outlook.com
 ([fe80::61a6:72a5:5a14:4e4e]) by DS7PR03MB5464.namprd03.prod.outlook.com
 ([fe80::61a6:72a5:5a14:4e4e%4]) with mapi id 15.21.0339.007; Fri, 28 Aug 2026
 10:46:18 +0000
From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Subject: [PATCH v2 0/2] iio: buffer-dmaengine: fix dma_vec building for
 coalesced sg tables
Date: Fri, 28 Aug 2026 11:46:54 +0100
Message-Id: <20260828-iio-buffer-dmabuf-iommu-fic-v2-0-b4dd71827621@analog.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/42NQQ6CMBBFr0K6dgxTixJX3sOwKGUKYyw1LSUaw
 t0teAF3/yU/7y0iUmCK4losItDMkf2YQR4KYQY99gTcZRaylOeyxhqYPbTJWgrQOZ0XsHcugWU
 D2MoaLVZUaSWy4RXI8nu335sfx9Q+yEybcnsMHCcfPnt+xu33X2lGQFDWIimlq/JyuulRP31/N
 N6JZl3XL/3Es9nZAAAA
X-Change-ID: 20260818-iio-buffer-dmabuf-iommu-fic-1b281f15e5a4
To: linux-iio@vger.kernel.org
Cc: Paul Cercueil <paul@crapouillou.net>, Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        Andy Shevchenko <andy@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787914052; l=1637;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=ioaibFikTWdXXPIeRxDV8SA180kgzBHNKRxogwkHemU=;
 b=q29G2+1EdO7KcL4FHWNOvykWOo5GWPCx071HJVLOm5binKXTBx5B8BNSA4i0AnA9zbPnQddb2
 vahYXK3eRRfCV1siSU1iJlUY2KXRrd0E1H5enZHHfmtnzZzM7sMl5Lg
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ClientProxiedBy: MA4P292CA0001.ESPP292.PROD.OUTLOOK.COM
 (2603:10a6:250:2d::20) To DS7PR03MB5464.namprd03.prod.outlook.com
 (2603:10b6:5:2cf::12)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR03MB5464:EE_|PH7PR03MB7267:EE_
X-MS-Office365-Filtering-Correlation-Id: 305ede29-5b8d-4781-3557-08df04f19747
X-LD-Processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|10067099003|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info:
 0CzB77Kq19cuZeOVM9mwvLwAqvP5V3xAoalugiZ/FfE5tfgcrzxU/hHhDfx9k+WVzAWvfCsPvD2BKawM1ARryaSVYduzZy1DQCFUiail6ftaw/ftaagQxJcBesJfg0nWt09exYC9hJT1L7w9fnQs0kLNQARqURs2ogZGhqalwqNxj1tYV2/8VqqmkYVwLkR865wFJx491PVSQxZeNfbb2UFVlh/4CJ69O1k7MO77zYCbkBv4UlSJNx7lH2A83+Ar23uisBvYUlMo4u6hvIZBsLldhK1GE/6sIiUPrisq+4yjU5roNmowRV3Efd2erQFs6pZKOkH/Pd9N96dtCymuvaVO6lADP2aPNtbwF4ti7j8SazSeiZ9QYHHuagkS7VQ0uvGVm2+BSazyEdINPErZSvrYwtxhkJo7tnskUVh8PKrmyvduhZiWYKelYYIW0vvCeA80pHLtXI57QEFdMWT5X96vTtb3MKsupomB80Gou3B1CXcUE4gf9w9lDvcIW1YC1K8XsBXLvhYaShWoYp6XbSGgKmUStbu8nHk1d2phCHwR7HknDEIWX/MJGj4t/AFdgU3b11lq/4EOLDiwD72ZypDFCfarj35KjWjQEAFPBDCQUEFeaWcYffzrfv5FIoZO
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR03MB5464.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(10067099003)(56012099006)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?UDNKY2Rwa0dCbnllem03cG9PVzA5dDhTQlYzSHRoS3pIT212ZGFGMXJPa0Fw?=
 =?utf-8?B?N3p5MmF1QVBUUU0xVlFpSG14cU5tM2tJUVRxb0JPODNwWjJhZmZiV1R6NnhN?=
 =?utf-8?B?MStVZEhkOFFYV1docW5GOFdDRXNHMDlpdkY3ZlJsWVdTNkp6UHNIcGF0dWhZ?=
 =?utf-8?B?OHUzU3RxUWJMYjVVVEFOeDRDOEJyL3FKemtURFo3Y2QyTUpyYVlNYjVnU3hz?=
 =?utf-8?B?K0hXVEhHMUovOFMrcUcyZEhHQVh5S3R6YVdlZkZMQWo0eUFRbHVjeTB6TmNw?=
 =?utf-8?B?SnlHWEl1R3dUamlzMkxiTmdKcjVmVTVJOVpaamxTK2RBMnJiUXRhYmlhYVRG?=
 =?utf-8?B?STNPT00yTm9kd2dmQkZIOGVwNUVIb0djYVdTdndGRFVwYXVCUDhDdjMydzFm?=
 =?utf-8?B?cU1sZDhqYlZRUzQ0VW84L0R4cGdIcEN2WjlQN1Y5U1ZwM2JiaysweHlDT2l2?=
 =?utf-8?B?MHBpUDRtVUJDS3Q2c1huSUhhZk1IVjMvQ090UVN0ejE0N2EvNWxuekdldFBJ?=
 =?utf-8?B?QmE1SW5xYVIyejNDMS9UVitMUnV6UU5wK0NTMWJyeHNtK0M4NElkVWFIWm5N?=
 =?utf-8?B?MUlNa2RqcTd6QytVRGszdE9Pb3dQTkxTZSt6RklZL1pTT3RDdDBFMnpDNjBw?=
 =?utf-8?B?bXRWMDF1T1VzbCtBb1lUWFlGZm9OOU1BOXp6TWJ3emZvUjgzNGRLaEhUVDl2?=
 =?utf-8?B?ajRqZERlMjFaTTB6bEhOKzVzcXZibDdFWVpCNTBJdmRXNVVrRGFNL1d4akVH?=
 =?utf-8?B?L2wwcDM0dm5jU09DZ2t5RFRnOGdSOE8xNTZzTlp6NXh4SndyNWFIRk5vajQ0?=
 =?utf-8?B?eElJcm5FNXNpTk4rV243M002cFdCL2xqS3VpNzJNREhmSXdmMXlGNEJRQ1Zm?=
 =?utf-8?B?U3ZGeDJiNWJ2YytUTzNNRmhUc21LemRoVEs0eDZORFgrOEpQMHVvTm9rSFlk?=
 =?utf-8?B?K2dmZzNLM20wSUJTM2x3bFNhdHVlS2NRWWQvbnROSTZkUWlGV3F4MmwrTmlD?=
 =?utf-8?B?M1BhVTRGeFZTZ0pJdXBwUDkyTFBkVUdBbTJua21rSjJHNzhFaTNnUjdIbHZ1?=
 =?utf-8?B?YytBYWkra3doOVdKNFZqRHhSVzM1V1VpTW1ndmR2TjdzUWdlWHc4RDkwanRr?=
 =?utf-8?B?MU5HV3hpVDhpR2dPZ1h5ck1kelVBdzV3MlQ5RmJnNGoyQWd2eXl4SjZvRGU5?=
 =?utf-8?B?V1JuSCtEbzlwb0pwOHp1OEo4bTc1c0NiQUx2aWl4UWVodCtRajN5NkpraEZn?=
 =?utf-8?B?UVdWU2orMTNIU0czZng5OGwzUWwweDZZdzNJT1lHZmhpTWx1M2d3Sjg1Q2Ir?=
 =?utf-8?B?SkhycC90LzFGaDdsamJJcEhYQVAxcTdlTFVPRjZ3OEtTYUkzcTEwakRlMTJI?=
 =?utf-8?B?WEc0SmFZb3JQblVJeEo3bHV4WmIzTVBlTlIvb2IrUFBza2FsL0d3ekxYLzht?=
 =?utf-8?B?R29yVEZTUEc1VkFUQVp2SGswQkFYY2VhNzJUajJXdkgxZ1Vhb2FSWVZjanZC?=
 =?utf-8?B?NUdWZTFocXVDNzBqOGhwdFdkUmc5OVNMNUZkVEN4T0I1NEZjNms4Y2I4OVlJ?=
 =?utf-8?B?ZXRXZzhuZFhWbDd1Z216aWJiY1lPWm5vUnZJRGkxZkErZnAxMjExL2YxNU84?=
 =?utf-8?B?aGk2dXlxTnNReWFpSGpPenZiQ1FWd0xZOVlPd2liVTZpaGM5ZTlzdXByam5D?=
 =?utf-8?B?Wno3SVVtZFgybDIzdzBkUjlMMDVkdk9MZGI1ekhMYmYrem5EalY2NkdZSllN?=
 =?utf-8?B?WjhaK3RBNzg3U0NxQXhaMGQxejZycnVxaEhVcDNaa2ZQSnl4bXIvQytaZWhG?=
 =?utf-8?B?UlEwWHhPUDRMRXRrYlVxanVCZGxraWVaL0htencwOXRPQUVDNkxaRFBROHFM?=
 =?utf-8?B?RGFBMDZPdjlTZEJ3cUZ2azJvbTR6SGhldFhZRHgwcEZ5YTJvV3ErYWY4bzE5?=
 =?utf-8?B?S3R2U3hYSVBkM0N2YTVYWmdiUFBZNEpNb0RMWFpUN3lmOEIxNHFHYjA1RHhh?=
 =?utf-8?B?Z0Q4YVdpb0V5ajV3b3dzd0tzbXhScDRKT0dQZjU0S0tJRmF3czBFSGlSSW1H?=
 =?utf-8?B?dUNCWUdVTkdReFFNY1drVDdPYTBxYi9QQkRhSWdMWEJTWWRVL0xEQ0tIdDBw?=
 =?utf-8?B?UjBlSWRWWFBFVzJwcGdEamhQL0U0c1o1TW1oRFFGUWpwZUVUUVppcG0waE9h?=
 =?utf-8?B?ZUIwZ0gvMEhBV0NVUmRqelFiQ0NPVWF4ZUgzeDh2UXo3aWJ3RHYvTk1wcTlX?=
 =?utf-8?B?Wncvbk16TVpBMk9TZEMrOWk3ZEU2azVGUGVjR3ZPWnFrNFp1TmRqbEFyZExo?=
 =?utf-8?B?QWlKNHczc0xFTlRlcGlkL25iZzh4akZJa0RZRUpCNWFINDZqZHNNQT09?=
X-Exchange-RoutingPolicyChecked:
	qPSsYXvHGjKNO0U8wRzSo/DwzkcWyPLRf1Di88hKv/mdJfCUDGmN4kunK16vJlEi4XiqkjS+DXkd79kUoql9iQEX8fo5Ztk+MguxUplhjmRtID76aXRH0CcNAcvLKaxy7XNq/e2fR/LMh1MoWDwccf0JPbCJEXG2auyNg8idIIhOTZ68Osty/RXFgVu2arJXudV/J37iYIEK2xv6vmxEsguAH3oyhlM4CKSOxi5yvF2wCjex40LENw7e3XisyaPLcR9Y6RAROBBgais3DjwpariGWj1pC7F5TWRBV/UktcNZvGTZg5gET+ZgdST+3cOZqwD9xSdBVdWdHcL8ie21wg==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 305ede29-5b8d-4781-3557-08df04f19747
X-MS-Exchange-CrossTenant-AuthSource: DS7PR03MB5464.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 10:46:18.4721
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7OGaF82juD74jtvKdso8F5kN7HFHfsFBUbkzlDr7WdiB4EeMq0h+pqhYVYecu1TcvPVc7hhSqvuHlkE6LAVS4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR03MB7267
X-Authority-Analysis: v=2.4 cv=I4hVgtgg c=1 sm=1 tr=0 ts=6a9166fd cx=c_pps
 a=awRqKgK+okXhs1gjjWqUCg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=Z0pTeXoby7EwIRygza74:22
 a=bC-a23v3AAAA:8 a=gAnH3GRIAAAA:8 a=moSsU3aEHegJkcxoEycA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-GUID: E5DjR98HLrEs9jcXz4cReDkPlVOkzN82
X-Proofpoint-ORIG-GUID: E5DjR98HLrEs9jcXz4cReDkPlVOkzN82
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDA5MiBTYWx0ZWRfXx1aHs8nJz/e7
 qIlnqwTUpN0kkAKh04sDsngCqDOheLMmWtaKoBxgjioPqIdQQjNpBNK/rcScB998lYLOcDKYZ9z
 djBH+G4pU79mLgqB998x2/GsBmTvkkcdmwQuj5guyrOywBi0PNyW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDA5MiBTYWx0ZWRfX7NMvJ7Dq8C1J
 fsvZaUGsva7ENqS4/nmawRFCis6uWbZRQHvfXMf5d+j6LmlY8a+iota8+yvs/Bn+KNHkbqo6dLS
 tAGWr+uEd4dJbZJ7AK++lXDhwOx7EqP5HDjtHcZFF1x5rvjh9QV/eyi0ZdfUXJxZjG4z3C/Z3Xo
 a3LReniAI6Y9ce77MdBklc6SEVCWXCqywPIs2EWrHqap+YZQoYk2VLR5uqiIoz+7MVVQPkcFRmr
 hEOl/2UEIh0ncz4P9bRBkeHWZpcxn4odGOAoIhhYVNDf+YYodq1cBK0peO5xLtyTBODfLLJvITM
 KAa1iEdutZu9yhmTdlAfElaFwXQwvQrrsTC9yWscCh8KcEEKujwh0EsEUJ7Jgq/Yo6mkPXfb+QR
 z5qmTSoSp40/zcLmKh3ivD+VekbrQwaH1661ePUFD/xEOBa/TtA4Jv9ZzIKEuaYkWazqJpSXEsG
 VZ6us/Otq7HgCYsDEXg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-28_03,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 bulkscore=0 impostorscore=0
 malwarescore=0 suspectscore=0 adultscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608280092

Patch 1 fixes iio_dmaengine_buffer_submit_block() mixing up the CPU and the
DMA view of a DMABUF's scatterlist: it counted entries with
sg_nents_for_len() (CPU lengths) but consumed sg_dma_address()/sg_dma_len(),
which are only valid for the first sgt->nents entries. With an IOMMU
coalescing the mapping, the loop walks past the mapped set and hands a
garbage vec to the DMA engine, which wedges the buffer.

Patch 2 is the cleanup Jonathan spotted while reviewing v1: the max_size
computation at the top of the same function is dead, as only the fileio
branch consumes it and that branch computes it again where it is used.

---
Changes in v2:
- Patch 1:
  - Size the vec array with sgt->nents instead of sg_nents_for_dma().
  - Cut the new comment down to the invariant a reader needs.
  - Moved 'nents = i' up to right after the fill loop.
  - MOved `sgl = block->sg_table->sgl` to the place where we need sgl.
- Patch 2:
  - New patch dropping the dead max_size computation at the top of
    iio_dmaengine_buffer_submit_block() (Jonathan).
- Link to v1: https://patch.msgid.link/20260818-iio-buffer-dmabuf-iommu-fic-v1-1-4ff1e44a5073@analog.com

---
Michael Hennerich (1):
      iio: buffer-dmaengine: fix sg entry iteration when building dma_vecs

Nuno Sá (1):
      iio: buffer-dmaengine: drop dead max_size computation

 drivers/iio/buffer/industrialio-buffer-dmaengine.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)
---
base-commit: b756b143e5391151e577ae645b1378a43f93c2f5
change-id: 20260818-iio-buffer-dmabuf-iommu-fic-1b281f15e5a4
--

Thanks!
- Nuno Sá

