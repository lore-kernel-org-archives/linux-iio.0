Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A86847DD40;
	Thu, 13 Aug 2026 13:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786627017; cv=fail; b=k3ND6Pn1L/GmhELmmTec+XR93kcjOTghjX42H9En9fR6zZkWlAxraCHqeyrOgZU+a2PcEFvHOoxwxkQz0Kqzmxh53a8BjxFOyPUkC50dHrKHfguJTqhfvUm2SuMuxR9dTgseCi92pE8h4FrBCuMzueue/Wo00W31M/IgVTIETqY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786627017; c=relaxed/simple;
	bh=YYVYS8QwinY62j0VZ6oqwnl0AMCeqvKhrL/hXysggSY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UVCLEVinaKvfe1QehEyF0IcfSk4794pgMCx6UezdjxJZuqmrgZl9DpIX1gOPRFAjXYO2AcFwyFKOOmcuM5BgD2Umk8Uj3mGIxd2qdeOhAMA5JN56CPaAi3nmBTzNFpgVbBT2i4zCiyLbQRS7dnbDHLmoc23LBf7T/3+zrQmyN9E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=vhZ6gY6I; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="vhZ6gY6I"
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67DCaDTa2129164;
	Thu, 13 Aug 2026 09:16:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=iAqeN
	dyUX8jNVS+nPMU/m2q7lsWmoNkMgLayGiDwKbA=; b=vhZ6gY6I0t8W6EoA2A9HS
	4xeIAfMNkGn8yWXY4EK27AZBoRzE30rlOIlTGu87QSuP64QS0WwjcK3W/c+b9Wzg
	Mk3afSvjjt2/zdFYxr1l8BLch5fPcBrqkHrIAC8KyPIR7oGEAw4xv0z5RnS+rjgp
	4k81FV84J1wJUav6WMfqSIaVPwB8RRgfO9EkVeBPKc3Y0Uy+dkatwW4sXaa9RoyG
	8ling4vewr9+TvVNzoS9Zs3m3sClYYyZVM4KgsE2CI9FNvkMtJa4LRiKa1rGGfPs
	GZcaircdyYKbTPQMdvPULH8Kb9cj92QKYVqIr2m6yIamxwh6PPkXu7rhieEv216t
	g==
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010069.outbound.protection.outlook.com [52.101.201.69])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4g1e2wg760-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 13 Aug 2026 09:16:25 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LU5NFjCbv+QUX/9rojp5oUJmD/sOPZjEb/s7w3eS/wLvraybmpgDukOpf7L6yRyb9kDo/pdvb5SIn4f/kVACAaI+izG5+fSjYodRPbc5gqg5blXMdS1sdrgGsNWsExpOIIDtF9QDr7Q/4YJtc8/yfGz+J1fWg/QZeiEIkWsOMqHlkKe/kDNoSNj8b9OrS55NT6eQlVKd7qS5BGjcPKHSbFvaNjs8Be585ppDZlijuVOofe9O9LsWF0HvaUKyvAUDqq4R6DAYBksv3ALAZBujo4kvOCOK+tUHnXlocLvLKmDboCOqyxwko74vxwxAieuqHM4JPuwXR5ZKAoHF9DYhEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iAqeNdyUX8jNVS+nPMU/m2q7lsWmoNkMgLayGiDwKbA=;
 b=tKMdgfvTVIGCOefIUL4+lcoAJAkVJDdpBU3WhnWoqsYDm5Pj7CeVDwyzCsaal3py0PxF5dOTp5bQa0a3ZZVFQ2h0H/7PUxBDIBdGmedADY+sDA100bAQqhLon3Fkx6b6RKiin0l3Y12OvtqRBW7va9bCF3QMxRRvjQ/e5YPnnGi/qak0EAUj36VaZfKNCTAWHez9/hmAEBJfr7kdul3mRzNn/QFHEA25s3xV40tPg56X1F9qr/25dWh8cW6cS9emPIJM130Enrie/FJEyRX45f9c48pFy2Pf8oVg+5d8UYyG35NBp0ER8jyzrn+hFlvgoHinJIqM0p4QAmHINX5FsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by LV4PR03MB8235.namprd03.prod.outlook.com (2603:10b6:408:2d8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.14; Thu, 13 Aug
 2026 13:16:22 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%6]) with mapi id 15.21.0315.011; Thu, 13 Aug 2026
 13:16:22 +0000
Date: Thu, 13 Aug 2026 14:17:32 +0100
From: Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Vinod Koul <vkoul@kernel.org>,
        dmaengine@vger.kernel.org, linux-iio@vger.kernel.org,
        Frank Li <Frank.Li@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        Andy Shevchenko <andy@kernel.org>, Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH v2 1/9] dmaengine: Support bus widths of 32 bytes and
 above
Message-ID: <an3DWksPdKSZ_fOK@nsa>
References: <20260810-dmaengine-support-wider-dma-masks-v2-0-1f7b798d035f@analog.com>
 <20260810-dmaengine-support-wider-dma-masks-v2-1-1f7b798d035f@analog.com>
 <anoHMANpRU744hPp@ashevche-desk.local>
 <anrgDskNdV7PG-T-@nsa>
 <antirKIhG8iaMqNv@vaman>
 <anwwrvNLP2OujnWd@nsa>
 <anxBgJZH57acnOZr@ashevche-desk.local>
 <anxasgXZsSKzvxG9@nsa>
 <anxt4HO1V7HPg4Z1@nsa>
 <an1ko4Dj_fCZuGB6@ashevche-desk.local>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <an1ko4Dj_fCZuGB6@ashevche-desk.local>
X-ClientProxiedBy: MA2P292CA0028.ESPP292.PROD.OUTLOOK.COM (2603:10a6:250::15)
 To SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|LV4PR03MB8235:EE_
X-MS-Office365-Filtering-Correlation-Id: 781a95ec-c37e-4053-7c90-08def93d11e9
X-LD-Processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|7416014|4143699003|11063799006|10067099003|56012099006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
 be3bnxpQvr5TA99j+zkNi2jS7VXf/KSHXE1KnqEKUu14sJZNXDc8vbYDrWfKtrFr61KxCRUhWRh97/gCihk2ieBhJT9WFeqBXf1Nf2tIvMf5inpzQbMFVCm9eaxVgU+21emtHpwthx0oSXVZsSplXnr3Qg2xThWi3YU4wer8zJLQjN67uk5AVSzY0NyoDD4ux19Wy8n+hZueOsejSMl/J4TdhcILHDy7MHNdsv42c2IO/5SLlO8DVT4mDvlU65Gz2w+Nh+QHFxK81iWAUDl82y3UwEQKcAwrWpchNa141Dx4w9kqBWIhu2aYCu6a9+bXVow1zg5rQZOpIvKIY1qdY3NzM106m6hQv3rZr3v5BOzcgHIAXbWO/WldZI1wFCowXuFwYllP1b05gBPIfDwPfqdZdGD0quyk9nVDiffA9wQMt44X6417zJK209zbA2RnIiVyO9IJSCc+bdd46bDrhSMo5DCUNqujLF0nv8FWiH5suytA7KofIr7QjWMTV1eno3cGLEhRJL6C2YBFzvRE5yAMnv0hk8egnj6XFQqdSkFUm5ly3Jax+hTolxa+whWv1N2l4r8MuRimWjLscIUz/qQbGgkC3vOFQ/QLQjVORNOmw11RDcOd39nPG8v0P0e6obzWb5buFhR0FyQ0mRBOq6wWMFXnZ3MSsTGQ9YhsjtM=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(7416014)(4143699003)(11063799006)(10067099003)(56012099006)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?V3dFajBMbFdicEJlQzZkUEU5VlJnTU5yd1FwTC9YdWlnSTQ3OWR1TllnUlMx?=
 =?utf-8?B?K3hGeE5iVVcvTjNhZjkrb1VIOTU4WDBOM1hEQzdGSjRHTjZZUTMwd1RMN2Ny?=
 =?utf-8?B?bS9xeFo3SWZqOFF4Z3BVVmxqS0c3aWhMbU02VmE2RUcweE5rKzVPRUVuQnIx?=
 =?utf-8?B?TnQ0bVBQSWZZVmljWm5IS0h5UEd2dnhwdlA1amIrd2tXMzA2NVNwejZLNHNW?=
 =?utf-8?B?dm5XYXJuSUNqZnZzTkllQURTbHJQd25WbGdYdnBpWTNyVGR3eUxHWnpKUHZz?=
 =?utf-8?B?MWFIcFNOblBZdmdraHpxQWNiUUVHNkxhZzlSZTBzcFZWUE9weDJwNnVoTndy?=
 =?utf-8?B?NEVRZExJOEJBK29jVTFaZHR2ZWhZM2VmMGc1UTMvUGwrNXV6K085RGlwdVhz?=
 =?utf-8?B?bmxrTEE0bGNMRlFGRGlHSTNQS29ER05IOVlrbENpd2loV1JISXBWQVdpbGFt?=
 =?utf-8?B?UmRURXdvcTk5ZWltZHNhUUpjMytCc2NWTDB3Z1QrWGlrVncxejJSblp2czY2?=
 =?utf-8?B?azhQVStYeXNoK0NSdXNXYkc4dERSYTR2U1E1MUNPVklvbzFWVG9sdHpTN0ZR?=
 =?utf-8?B?MisyWFNXUDlmb0hRQXc4MHlKRlU4N2JKQVo0ZjEvR1hTMVhNd0tSUktwbFQz?=
 =?utf-8?B?cXhuenVuWERBL3RjRVdMeE5HRW5ZNm5MbkthRUZPNEt5TGhLQkxjNTJuQ0NF?=
 =?utf-8?B?YnBwaE5aaFQrRFZRT280bDNScEFhY1FnR0lnZklNa3BsUmZzTi9JdGNYWjFH?=
 =?utf-8?B?aFNjM09iQUpXdXJCMXlQMm5meS9lSkl1VkJHVjk3MVk4a0JiaTN5SFpzMlJJ?=
 =?utf-8?B?SzRSZm9heUZ5d1o1NSt1cXE2Z0Jsek16TnZ0OVlnckxCSXpXeHlRUjNvNnFT?=
 =?utf-8?B?VlRYVXhNYUhZbEhYQjRwMUlwN0w1alVwdFp3WGwzcnNQdDN2N1ViUEI2SVlR?=
 =?utf-8?B?YTBBcUNZdjBGRzI3ekNHMmMvclRNRGh3NktGWEdCVi9Nb1Z5MjBHdjJFNzIz?=
 =?utf-8?B?aVZYQUJ5aktmZFJuZVpqK0xyZzVvUENVR2wwa3h2eWp1dURpb3BzR1dKWU1C?=
 =?utf-8?B?ZU1LclkyVUxEZU5xVktjMVNMdkdrMjRCcmtNSlAyellTeXQ2cEhOa1ZSY1RE?=
 =?utf-8?B?czBmU1lLbkJBbTEvd3AzelR4cVlJbGErMTJsODBPeXZzNXhCRVFleHhsUlRi?=
 =?utf-8?B?ck1rNWRCbXlHbkU1ekxYY044ZDdJeFJGUzJ3M0czSlBFYnUwMWtBaFQ1Q0Rq?=
 =?utf-8?B?N1hzZ2JPalphMzB4c2pIbFRiL0JmYnFJZks4ZVdacUZIMnNrK0UxRGFWelp2?=
 =?utf-8?B?djltWWdzbXR6MGhKZDJzTVR4VlZVcDlGeVAzcmdPS3JRSzdlTGlrMlhnNndN?=
 =?utf-8?B?VDZRbXM3Q2o0MHllY0FkUUk5TTJkcXRRR1c0SDd3d1lKU3dPTGs2YTZGSWZZ?=
 =?utf-8?B?SElmQ1FrbzRYaU12T0tGN2VtaFhkYW5mQlEyZWR5ODJzL2xreStISUdFM1hZ?=
 =?utf-8?B?OExpOVZZY0h6NGpMaUdzcDNybkF3U2ZzQVdNMEJNNGlGejVCSkVjSG03dDdY?=
 =?utf-8?B?bE5lQ3J2bzFIOWFkdHRtODgzNzdjSHl1NDVVdTk3Yy96REt4c2NyQ2RvZTdw?=
 =?utf-8?B?M2Q4eTNlaWQvNXF3K1R1UlNxSk5aOWJ3Ty9sTHc1MDE1T0RyOEFKeUFoNCt6?=
 =?utf-8?B?TThqSVdjL0ViYTUrQUxFdXFPMlZOeWxtWHJWb2NJbkd3aHBLSjg4cThNMUZF?=
 =?utf-8?B?eDdhcmVDU2Vnb0xSN0VsaVJDUkx1VzE2eDFNM0VZdTZVb1c1Tk5Xak5qTVVN?=
 =?utf-8?B?VndqdHZZM3piTlVmK01zK2FOVS80UGJ4U1lpTUd3L2h5eU9CTXJxQVZmNzJC?=
 =?utf-8?B?dEc5ZFZmZWdYa2JWYVFXQThIR2FkWkh2MFZVUExEMThrRkh6N3cxdzRINHV5?=
 =?utf-8?B?UXp0Rm1pWDRLS0syUU9QQ3JXWFpVS3N4RTJMWUovQ3ZVTmh4ZjBwdmlCcGQz?=
 =?utf-8?B?aWFiTzArSlUxTkhkZGhGL0hiK3poUkRUTmJGVE9LeEplYjJjUFljR0w5TEZZ?=
 =?utf-8?B?S2NWRU1FVDYxcGc4bGsvQ2lROUJmWkZjUUNnZkFzY1NRUW52REthTTVuU3dE?=
 =?utf-8?B?M2dxNHRuWFlFUnM4dUErUFN5eWVudjlWMUxqcHYxQ3ZqbjU4VmpCcGtmdXMv?=
 =?utf-8?B?Q2lCbTQ1ZHBwWDBtZ1NHQUlPanhIWkhMRnV3WHlyMXhXMTRuRFFRclU4MGF1?=
 =?utf-8?B?Rnc1dFJCMytJSlNmakN5TG9qeURJOS91SzVhNEh4VXhYMWtqekFOUmhiWmRG?=
 =?utf-8?B?bGtpci9yK0dQeVN1T0loZkNEbGlDRlNVa0pZQ1hXTGRVK0hrSW80Zz09?=
X-Exchange-RoutingPolicyChecked:
	lPZvbgCEOwYv1w9/QR5mORtXVY5MXSQ7Rqm/uuhRtW6JnLBm75xe+OyBisqPwgovWd5yYXo7iKXy9otwxdJJgifL1ly6PL7wTofRCnU8Y7DHnCwfioSKFryTQQls1cpzhgOC0KYVz95/Jxbkt7HD6EAgib6sAZKFWP2q6BQg4ZaZ6REbJNDf448Bxx+nWO+xd3qvS+A7Z7DYHumnfGAXXcjZ/B3OXZPX+g9u2Q2Uee1Ug/kGkYEPHIG/DJ1XY9yZEXbuozSEJYH+nujKc43y97JSUxY2gnV3pC/QPcW8aB5dQ/fdvsXUCvBzGdcLRe5X6zYBzKic34rFZ+OAsh9udg==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 781a95ec-c37e-4053-7c90-08def93d11e9
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 13:16:22.6977
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sf4W0JHVWrJjNXCUOYCfC3GXZgCjLY77Eqe8xS+SLu3BHwCZTnNOCGvmJmrnV3judmVe85bTexj8D9gGAoA/pQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV4PR03MB8235
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEzMDA5NCBTYWx0ZWRfX7h0jJv2933Ms
 6a1xapVj/XjA74AND5vDoZNvyrSbb1tyiHLHdQvH/f8gUYumpUKVd0CCk6V4ON7wGYkHBXQArJs
 zIzGoQfF6JhmahTXhRKJIEaoMYcB9rtnHUwyBG75DGmtIYcGAmf5
X-Proofpoint-GUID: RQTwnVZFJVQqFmGuyNC_OGU3ulotKku5
X-Authority-Analysis: v=2.4 cv=UJzt2ify c=1 sm=1 tr=0 ts=6a7dc3a9 cx=c_pps
 a=Q5I7zFPfgszDbE/a6V3qwA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=OmVn7CZJonkx5R5zMQLL:22
 a=CCQMKARhb9AJvbY0-FoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEzMDA5NCBTYWx0ZWRfXz5qVl11zGRQk
 KWhSC4WqwS+8u3hDhvPtbLrSkoeVxwMen3PVYyYhBRVv6EfCTMCo8d41ZCeKKJc/TiXlHDvKwE6
 24ekt2pYSju8Sh66rVJHpcmS0zzShjsUEQbSbJbcZ5ubSxt7hJ7Vdez3qELU2VwNH4DXwcrVElJ
 UHw4KWceSmzl6JKFpz8DjgdTopHWt+tDMeY6/3Ca2sE89EzcfuyMWj9+g3Swdk6JXgicWYAK25h
 DzX7R65HS0mKof5iRu8ysei4LnVeI4MAElSt3dO5KW9+aaxC4HQ4v+jJhjUNJNnqNQKgV3uIwKu
 c70DPc+9D6+JVfi+mlSslVZRM7ya43xhw4EvFwXxZnazLdzDGISfSZwbM2to6pKip3ttSnz1CyU
 W/9tXsK8jQV/tFVUaO3beq9vkeMF9KQF4a64Ra+ftaG2NctkkMpk34KsoR+x4Fj3CXlMkSbdTHm
 6U8SBsvA4JNFmbRG7KQ==
X-Proofpoint-ORIG-GUID: RQTwnVZFJVQqFmGuyNC_OGU3ulotKku5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-13_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0
 clxscore=1011 priorityscore=1501 phishscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608130094

On Thu, Aug 13, 2026 at 09:30:59AM +0300, Andy Shevchenko wrote:
> +Cc: Arnd — what's your opinion about dmaengine.h case (see below for the details)?
> 
> On Wed, Aug 12, 2026 at 01:59:59PM +0100, Nuno Sá wrote:
> > On Wed, Aug 12, 2026 at 01:18:41PM +0100, Nuno Sá wrote:
> > > On Wed, Aug 12, 2026 at 12:48:48PM +0300, Andy Shevchenko wrote:
> > > > On Wed, Aug 12, 2026 at 10:08:34AM +0100, Nuno Sá wrote:
> > > > > On Tue, Aug 11, 2026 at 11:28:04PM +0530, Vinod Koul wrote:
> 
> ...
> 
> > > > > Just remembered that bitmap.h is already included in dmaengine.h anyways. bitops.h
> > > > > is because of __set/clear_bit().
> > > > 
> > > > Oh my gosh, true! bitmap.h implies all bit ops, so no need then a new header.
> > > > Indeed the whole hell is due to dma_cap_zero(). So, while your patch won't
> > > > change the current state, in lieu of the said previously I would like to have
> > > > a split, but since dma_cap_zero() is used almost everywhere, perhaps make
> > > > __dma_cap_zero() an exported function then? This, of course, can be done later
> > > > but if we start from the more mess, it will be harder to untangle, so I still
> > > > think the separate header is a way to go. And perhaps these capabilities also
> > > > can be split to dmaengine-capmask.h (with a fallback inclusion in dmaengine.h)
> > > > so in the future we can only include it when it's needed.
> > > 
> > > Yeps dmaengine-capmask.h would make sense to me but as I said, I really
> > > don't have the bandwidth for that!
> > > 
> > > > Looking into the structure of the include/linux/dma* I even would think of
> > > > something like include/linux/dma/engine/*.h with include/linux/dmaengine.h
> > > > to collect (for backward compatibility), where the first citizen may be
> > > > your API, followed by split capmask.h.
> > > 
> > > Ok. So what you have in mind is something like?
> > > 
> > > <include/linux/dma/engine/buswidth.h>
> > > 	#include <linux/bitmap.h>
> 
> > > 	#include <linux/dmaengine.h>
> 
> Not really this one,
> 
> For a bare start to have something like

For my series I need dmaengine.h because the API relies on stuct dma_dev
and the slave_config which do belong to dmaengine.h. Solution is to have
the buswidth API depend on it's own type as suggested below. That way we
should be fine.

> 
> dmaengine.h:
>   include dma/engine/capmask.h
>   include dma/engine/types.h
> 
> so the latter (types.h) will have the basic minimum that is necessary
> for capmask.h and (future) widthmask.h.
> 
> > I mean, one way I can see to avoid the above include is to come up with
> > a new type like dma_cap_mask_t. Something dma_buswidth_mask_t...
> 
> Works for me as well, and we can put it in
> 
>   include dma/engine/widthmask.h
> 
> but this time without back include into linux/dmaengine.h.
> 
> > > And have all the inline helpers in there.
> > > 
> > > I can go with the above for v3, yes! But note one thing:
> > > 
> > > enum dma_slave_buswidth
> > > DECLARE_DMA_BUS_WIDTHS()
> > > 
> > > will still be part of dmaengine.h and what I could do as follow up is to
> > > move the above to something like
> > > 
> > > <include/linux/dma/engine/buswidth-types.h> or maybe just have a generic
> > > <include/linux/dma/engine/types.h>
> 
> Yes, the second one.
> 
> > > Generic might make more sense given that we move around 7 typedefs in
> > > dmaengine.h but I'm not so sure about the enums.
> 
> If enums are coupled with types, then they should be there, otherwise we also
> have a concept of defs.h (but not as distributed as types.h).
> 
> > > Then, we can also do the split for capmask.h as you said. I can do the
> > > dma part of things I can't just commit to change all users in the kernel
> > > for the new headers :)
> 
> But it's not needed, everything except brand new APIs will be back included
> into dmaengine.h. Old users will work, new users will be encouraged to use
> exactly what they need.

Good then! I somehow thought the expectation would be to convert
existing users!

- Nuno Sá

> 
> > > (Ok, moving the buswidth types into a new header might make sense in
> > > this series - if we agree with that direction).
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 
