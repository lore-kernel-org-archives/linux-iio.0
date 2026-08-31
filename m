Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F0B323416;
	Mon, 31 Aug 2026 11:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788175885; cv=fail; b=OF3adDr+e3i5A/XGMCtDXUgZzuif/BBXQMuwrFTPss2DzmnXO8fFTVVU3Fc83W/LX/kHjcp2u++BO4V8lTqAL1JZNYUwG2ZY35AJxLkCIm+4o2gACIwojZZJymKqSNlItJbhyRgJoxeM95z2LH9+U9HvrF3oVhqHzgoKJx8bxmA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788175885; c=relaxed/simple;
	bh=8AG8Szz5G95vlPjK2ch9576Ee5VbDU3OwdfkyE8EjIE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rA+tse3pNh2XGN8azuChHeY9yHIEUddQ9k7WeuS6G8bp838JIE2By1T9PVyZc19KKPs4X+17Axu+3TclIDSVsn7AOLcSWn6MfT8sX8K1O2/Js2dNOr9UJjBrE+bI+XUoSmCaz0qM+1Yu5cfvpWFtTzdBA349VETAltyMLOhwmr4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=HvDXFZ0N; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="HvDXFZ0N"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67VBD4cG995848;
	Mon, 31 Aug 2026 07:30:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=uVWiQ
	793fCTmJ0gVaq2MxGPQry++faVxg1MboxKp5zQ=; b=HvDXFZ0N07WsQORZnbjmZ
	CpodvMFVzkrptBbZ9CSypLYvD0gDQuQ72djehYFYckH+ACukaTVj9jP55ULKzPzR
	Bi0kw8KJ4jAUjvOVIbnTvl3ddHcTRGnOQ/3Sjjmb5nrPRL2TCEVfEg45X8Lm1rlf
	h0CnwZI+89NZ3zJgX3cMZAhpnPDBUGldyQdIwZMxgoiH2XLgPGyu/Qgrp0rQyJmh
	HM1u9bts4gnsTHl4iON+uEL+ekZNsx7v9v7f8kweyzrual6j8WRZQMPPZ7qjgq2L
	GtAdLhJM+ZLsgxj/GZI3NhnOYUEuLGyUN59jq8B1rrahUTpL2hyiLiKU9Kw9SfaF
	Q==
Received: from bn8pr05cu002.outbound.protection.outlook.com (mail-eastus2azon11011056.outbound.protection.outlook.com [52.101.57.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4gbvb2q76h-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 07:30:57 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s9ZnGK1EDzjfcKsLa+AnqtX2wNiaIYnJ3PkFu5IKm2B7WThdFzkfjzJEGIVWHs27ptaXJG8yBWYMzB2C72DFUtNMg4R5hFX7cKwh9eoTvZP3Y8CXlqXzwJgzkvYdhQoEjn+FT07UDNmaUGF1lDNI2PN/zCg3sVOQomKHr7bdn5gX4CZPhZKgpB9SOs34FKkn4gEc4kb33KBIGwWYF+MgjSGu8wn8/8URIei/dx6fEWEDL1IF1Sw5ilyrOkt/qkLDmNWWP4NlCH39O2v+MBz/NsoUCmnW9ceRQmfZ/aSG1pwiQ73CwKA3iIQV4x2gYoOBhpbqKJv9rgnOhOPM/oGBrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uVWiQ793fCTmJ0gVaq2MxGPQry++faVxg1MboxKp5zQ=;
 b=bR7p2BYvjbXzBGjNu4qzlnnX1tF1hHkGFsmgOqk6rD19JEE/QzIHOOaj4DCc4iJ1YuLMoOR9nvVYUYX4y3t7v/3GphA/E6JgeUs4B08jdBMiVDrvo081XlfXoJ1VxUnb4q3+lm4V4JqBcToGCBYvOCw5NaOXm+VqGC4QyPNFLpGEMACrO7hsH7GChTkv8Pb/WnPnmGHRwKLUU/8BAOEBtmv3nzQawRy2XgEujmnfiZmqcBmmbZs7rnmUDaCrrTeg3dsOd6zfkSL2IpUuI0VKbyJT/X9hcTQa6bZqYOfiWMX59LLQ+6barI5Wjrb405PTM/fAbPfJ+q0g1JiHCVMB4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by MN6PR03MB7624.namprd03.prod.outlook.com (2603:10b6:208:4fb::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 11:30:53 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%6]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 11:30:53 +0000
Date: Mon, 31 Aug 2026 12:31:58 +0100
From: Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>
To: Amelie Delaunay <amelie.delaunay@foss.st.com>
Cc: dmaengine@vger.kernel.org, linux-iio@vger.kernel.org,
        Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        Andy Shevchenko <andy@kernel.org>, Frank Li <Frank.Li@nxp.com>,
        "moderated list:ARM/STM32 ARCHITECTURE" <linux-stm32@st-md-mailman.stormreply.com>
Subject: Re: [PATCH v2 5/9] dmaengine: stm32-dma3: Use bus width capability
 helpers
Message-ID: <apVlhybgKEtunY2c@nsa>
References: <20260810-dmaengine-support-wider-dma-masks-v2-0-1f7b798d035f@analog.com>
 <20260810-dmaengine-support-wider-dma-masks-v2-5-1f7b798d035f@analog.com>
 <286d173b-4fd4-475c-bc49-eb0c9047ca2f@foss.st.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <286d173b-4fd4-475c-bc49-eb0c9047ca2f@foss.st.com>
X-ClientProxiedBy: MR1P264CA0049.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:3e::15) To SJ0PR03MB5469.namprd03.prod.outlook.com
 (2603:10b6:a03:28a::17)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|MN6PR03MB7624:EE_
X-MS-Office365-Filtering-Correlation-Id: 8cd94c6f-0612-4e91-bfd5-08df075350c1
X-LD-Processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|23010399003|376014|6133799003|22082099003|18002099003|56012099006|11063799006|5023799004|10067099003|4143699003;
X-Microsoft-Antispam-Message-Info:
 iCRCkQ1ALJY2XA8uJha6KBvBzI/RJKzOohG3bytnDyFnWQaIKnadNhIYXHzCdzaUBGp4J+l9h4l4ItmSlYGyd+LfCd4Obpr1Uvd//MJFmUkuLpde+hDhGGJXh5XYs4JmEvyo+ALuClKWVxeqz1uzLrbhw2HH/rC1knpE+2LY8vIil8TAhcERau8ZsaOqhsEqYaYHg7EYcj2zLBlLIY5ekpgxBPP8WHyyLNnC5zymh/WKFBsVa52gO+H14mlN8qZhygjz4rUbBLFxO4yS2FbG4XlYMnsMui4QaH/e81ysjlUW/e2KHjgSmXxLGTS97HwDt2GKZWB2ot1cM4dWSayzrB2wpAU2PO4Mh1fkH5ZM4LhuZAJe9mrtn8maOk6n8Zl+yUYDJ0mQWINvNE/EfA/wbKk9MHl8danoPgqiiGQOEPgez4H/wGPiQ+RM5pn7g0F9zh7SyME8QrndMDhEejPAJOhOm9kB82u5vKdg0Ey+CNjLfRc89vKWEDgOet3kuX0lFW6YFCb7kq6OHoxKqdGclxVRfr5LrpdYv60v4YuGSp50G6Dl7r3r+WVBSDvcPxH5PVkBuWmY2R3odTmunNJa7KsC3fagXOjAecsNPlZUXOh2mCRBrPmCXmillVCaZ6H+HSA4nVGaFdc7bY+u6aHkHIva3cODdICUcTQ46azfxSc=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(23010399003)(376014)(6133799003)(22082099003)(18002099003)(56012099006)(11063799006)(5023799004)(10067099003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?Qy84NVg5cm1tbGtCK00xZktiY1dZVlVGRXMxTHRsRmZxTHVNdE1XbWdoTElr?=
 =?utf-8?B?Q3Y1THpYOFlVWEliNERsREFnMktuOFVjdzQ5RFpqZi9VTjUzNjJUOGFmSDZh?=
 =?utf-8?B?dTdJa1ljbmhFUW5rOWR4bEZSNlVEZEdWT3IwTHJMSk51N3VLV1JLbndndzJZ?=
 =?utf-8?B?bGk2Vk90a3NYTDdTWVp0aFJzTS9ZdVRnTXVKY0dlUjhlVjByQWlKZjJGcXF5?=
 =?utf-8?B?WUprZHc4c3RiM0xNbVowYTNwRTFONkMrOWMzTU1UUmZhR3JHa0xuaWgvbTN0?=
 =?utf-8?B?SGd6V3dCNXNZSWEza2RqYlJ6bXVZcUY5RXkybmdZcWhZMFQ3ZXJJME9sWDUz?=
 =?utf-8?B?M2wzVEV6WXQ1UEVXY1dBNE45cklXQ0tUdkowU21JUFhwdkNCREZQcHBNKzJL?=
 =?utf-8?B?N2d2MURvMHhTNzNwWWVWejQ5SzFvVUNYTnlqQkRzTk5UZmt2NXRkNXJ4UWQ4?=
 =?utf-8?B?ODF4bk1qOG9Td1I2Z1ZNTm15OVFPUmVUQzJ1enE3V0ovSVhTNFVtT0k3cTE4?=
 =?utf-8?B?aTF1SkVXeGFOUkRXWHJzUkhyb0oxMERJRzhFTUhvTGEwMVVITHBXb2dsZ2hM?=
 =?utf-8?B?WlhnWWE4Mzl6ZW1hdmk5M0tFSytIem5TN2JhaSszblI0WFNrS21GWi9Na1Ex?=
 =?utf-8?B?NHRUaGpvUDNnTjB0RW1rUlVlbzNGbFN5NDZqYy9vS3oxalkyWnhkVjFuU3k5?=
 =?utf-8?B?WWtrc3YvZHpQYVJFb09yTFZTMG5jZXlCK0IxekJiSS85MFQ3aWlmR1R3WmZU?=
 =?utf-8?B?cHplTG5QRnFzUGc0RW53QW9BN05PWlBiaUNPTVZmaUdkOGNKbThPcUVMYzFS?=
 =?utf-8?B?WWJnZThoR2tNVXpNUVhMUVpDTEl2bE1yd0lxMDlZQkRoUVpSRE9GNjBYM3Fs?=
 =?utf-8?B?aEF4MEI4eUlZcE5iNW5OYklNSm1oOTVPYlptcnlLY2hOUGNBNkh2SlAybnlP?=
 =?utf-8?B?a1ZYa3FFbXl1enl1a2U4UFduVEdYZTJwMmtsVmJONUdnOWFycEE5Tjd1cmpQ?=
 =?utf-8?B?QnpPcE5CSnpxcm54eFk5MXlUQVNGYldML3lwc3NCNEFHTW41ZXRhUUxGb1N2?=
 =?utf-8?B?dXhTcStsTXVmVlJ1d3JLWVZjNm40OFFsMUpqTkprM2NWYjlTSGtid1Y4U1BF?=
 =?utf-8?B?YkF6RlUrSWNTRWp5UGtvMjR5eGNuME9tR0xBa3pZR05PbzRkMUJrSkpmMjZR?=
 =?utf-8?B?LzArYUtEeDhiWVlVTkF3U3B0bVZZdnlvNWQrWnpwUGxEa1JLeFoyWDZKZTJr?=
 =?utf-8?B?Ukw1R3RwNDhDZXBVM3dwdjhXdkl3Ly9NNTFBci9SN2xZK1hBQW13aW0vMlpY?=
 =?utf-8?B?U0ROVFBtdDRUVTVqMCtaQzlCcldBeVZ2aTg0K2FrZ1dFT29pdmp3N2xYTHRn?=
 =?utf-8?B?Q0NEMXQvVnlqL2s4ZW9GNG14NU4vYThSc2ZTenk1MDZWNXdYSDJUbCtoRWZV?=
 =?utf-8?B?dktwUUxKZXgwenlOZEZORGdaaXpCUVdUNEhydGZvT0I4T29LRE84T0dRb05I?=
 =?utf-8?B?d1M1V3FXQ09ib3Q3dFBLeVVpREthbldsUHpaMmdnRlF2c1VML0RJVncvbUFX?=
 =?utf-8?B?MVBZSGRYS05UbEwwY1A5dlAzMmdtTlFmSXo3eTNkQzZtQnoxa010blpEbGNR?=
 =?utf-8?B?czkrL3ZuTXFDeTF1cHlVY284d1hIUk5ERlBud1FWaGpjVm4vUjUvWElTNGFn?=
 =?utf-8?B?cE1pcGkzaG5qNHJYdEMyYk1HWlRDcWtPREgxTmxXQ1Y0V1lYK1lTYjhwdUlV?=
 =?utf-8?B?YkpHQSt3aUpBYTNHaW0ya1BGYkdLdTZhRCtwSStLQ3FENEczTUlVVlVBKzND?=
 =?utf-8?B?RWllakltOTd6ZUthd0tQcEpUMDdrYWhYKzV3bXF2TEpMSGZIb2hTV1JYUTNF?=
 =?utf-8?B?ZUtmQmlFai9xd25mS0ZXQURNZEpsZ2xza28zSW4yMGRnMWV1YlNtSmNCODhP?=
 =?utf-8?B?VStwSnJuM3RJUDN6eVBEdHBBVGduTmRCL1d6WGFKcFBOaEE5aWhrb2g2a1RT?=
 =?utf-8?B?dGs1N2tUeTJJb3BZNUc4ZERjL05GU0JtR1Y3WS9sWm91c2FSaURyMnlSMTkz?=
 =?utf-8?B?VmFvK2dpcmRSNlVBUk9mZm1NNzBOZjVaSXNPRUJ1RlJ3Uy9LR2VXMERyK2Rq?=
 =?utf-8?B?WnVpN04xZTBLZzhYSVpoSEp5M3V5VzJVRTBacEovUG1hK09Qc21ZNXlZS05l?=
 =?utf-8?B?VkxRYU1xMjlqZitKZFpvM3hUTlZKTTFwcFdsZFpydHh4T1d6Vk53VWwvaU02?=
 =?utf-8?B?WkVzT1ZzQnV0ZmZuaG1EdGhhc0IrenZXWjMybWt3RjAzS1VIbVV4SUo4NUJX?=
 =?utf-8?B?OFRScGNDRFZZZGRqK0xZOTBRcC9WRHprOUxCaHV1dFIxVmN3Mm0wUT09?=
X-Exchange-RoutingPolicyChecked:
	SfIwXUU193GKPHQFqSKKF9dmRsCxObNPiYi8lfkMCvm2dK3DBY0Dusop2AGjM3dtbGro+zkbwsIphrcibfAzDyWim5FjFOB/AAEIBqpvXp7FM86D5BLfGpzpsZ58MG5tHWJkMTifGXXiImSYQ8mpWlLM8V9PcnoIf+bhUE1f+PXdV96up3f1i1q/sFebsQN/U9bLMnOjFMn5xesF851PYa0CU9tgeujNg8fiYqXiAyftLL2LcgxXfa4e5G6h3LWvpRuCe/Ue4epX/xeNeSYwWZqa66Nrraet2fncdQlAFV5BITfdH6Dqd4todbOOKV50NjfIi9NMDBiCV85h3Sao2w==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cd94c6f-0612-4e91-bfd5-08df075350c1
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 11:30:53.1703
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uqCEGGgvRlDSbjQ3rOXSWWTRB6/a3MKGwsFvD/o4SURSz+fwBcLZne4JFE6ifB3WUUc9hA9wvSCMFGvdhwPrWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR03MB7624
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDA5OSBTYWx0ZWRfX5C5EHYaPUAC+
 /J7qxhGlBNz7FoYBajUSph7VQdtQnXuj+QNW58gxoTZp3jrtAzdMGs8Jbm4pD5NpqOC/jwpQaD6
 4kuv6JptyUBkxcUXQjVYEe7na6MJHhiUP5AZTp1+evgdo9ixA+48
X-Authority-Analysis: v=2.4 cv=QopuG1yd c=1 sm=1 tr=0 ts=6a9565f1 cx=c_pps
 a=P8hJoqhRnqo/cwUvmyxmUw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=Z0pTeXoby7EwIRygza74:22
 a=8AirrxEcAAAA:8 a=gAnH3GRIAAAA:8 a=Kpp3qBR0_koB4_fKtRYA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=ST-jHhOKWsTCqRlWije3:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDA5OSBTYWx0ZWRfX13eZJp7+qB5O
 QJ2JSPnxHYm/dgLQ4DTsxRmWZU5xbflDzp9opzGGf23vAinb7YKYX5Lu3PJC85LdQB/QIL99mgm
 0gxOmUeaS4ee61UnF3n+Y2s2VRPHh154oTQaTF8jZk/AL1Jjsr+MDl1ssSceXiImVR8hdH3mvpd
 73SZWovs8Tt17NxfxLG/gaz0tpg+/rlR3VPdXTUMl6YG1n04qSC6Ohic0uOe3GaMM0Krto0bA0p
 pekNLtPy+pIUeOxQlC8ZiOSk7xWjqQOK7l49BWovIoGjsnFuTbeJP6/eptkqmP4C9j3GXlUjDZy
 GPg1EO8Z39e0TBzx7fDi3nKw33SuHB1j8+AH6RVw+2J2KJbRL7tVLtQd3Od1EI03M5o6itE/7UX
 gWM0VwtXpTlVxlV1KG5Hbs3EsvMIIO0lU7y30FqUJoEhc1Zfq7TB8kLJOpq2XI9CSTqOU4ZJk8+
 wqVe7Aeo4HJSeIVOhbQ==
X-Proofpoint-GUID: 8zaO-9viDAaOHABznV1S1S4KqycvoQuQ
X-Proofpoint-ORIG-GUID: 8zaO-9viDAaOHABznV1S1S4KqycvoQuQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_04,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 bulkscore=0 adultscore=0 priorityscore=1501
 malwarescore=0 spamscore=0 clxscore=1011 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310099

On Fri, Aug 28, 2026 at 02:40:05PM +0200, Amelie Delaunay wrote:
> Hi Nuno,
> 
> Thanks for the update to the stm32-dma3 driver. It's good to see that it
> helps demonstrate the dma_slave_caps_clear_xxx API.
> 
> For future patches touching STM32-related drivers, please CC the linux-stm32
> mailing list, as this one went unnoticed on our side.
> 

Yes! You're right, sorry for that! The problem was that this started as
RFC as I just wanted to get opinions from the DMA folks on the way to go!
Then I forgot to include other reviewers (I missed more that ST folks)
on the following iterations.
Also found out an issue with my b4 workflow because of this :)

- Nuno Sá

> On 8/10/26 17:06, Nuno Sá wrote:
> > Advertise the controller-wide bus width capabilities through the new
> > dma_set_src_bus_widths() and dma_set_dst_bus_widths() helpers.
> > 
> > Also update the per-channel capability callback to clear unsupported
> > widths through the dma_slave_caps helpers so the bitmap and
> > transitional legacy fields stay in sync.
> > 
> > Reviewed-by: Frank Li <Frank.Li@nxp.com>
> > Signed-off-by: Nuno Sá <nuno.sa@analog.com>
> > ---
> >   drivers/dma/stm32/stm32-dma3.c | 32 ++++++++++++++++++++------------
> >   1 file changed, 20 insertions(+), 12 deletions(-)
> > 
> > diff --git a/drivers/dma/stm32/stm32-dma3.c b/drivers/dma/stm32/stm32-dma3.c
> > index 4724e7fa0008..f0781fb1b66f 100644
> > --- a/drivers/dma/stm32/stm32-dma3.c
> > +++ b/drivers/dma/stm32/stm32-dma3.c
> > @@ -1469,14 +1469,14 @@ static void stm32_dma3_caps(struct dma_chan *c, struct dma_slave_caps *caps)
> >   	if (!chan->fifo_size) {
> >   		caps->max_burst = 0;
> > -		caps->src_addr_widths &= ~BIT(DMA_SLAVE_BUSWIDTH_8_BYTES);
> > -		caps->dst_addr_widths &= ~BIT(DMA_SLAVE_BUSWIDTH_8_BYTES);
> > +		dma_slave_caps_clear_src_width(caps, DMA_SLAVE_BUSWIDTH_8_BYTES);
> > +		dma_slave_caps_clear_dst_width(caps, DMA_SLAVE_BUSWIDTH_8_BYTES);
> >   	} else {
> >   		/* Burst transfer should not exceed half of the fifo size */
> >   		caps->max_burst = chan->max_burst;
> >   		if (caps->max_burst < DMA_SLAVE_BUSWIDTH_8_BYTES) {
> > -			caps->src_addr_widths &= ~BIT(DMA_SLAVE_BUSWIDTH_8_BYTES);
> > -			caps->dst_addr_widths &= ~BIT(DMA_SLAVE_BUSWIDTH_8_BYTES);
> > +			dma_slave_caps_clear_src_width(caps, DMA_SLAVE_BUSWIDTH_8_BYTES);
> > +			dma_slave_caps_clear_dst_width(caps, DMA_SLAVE_BUSWIDTH_8_BYTES);
> >   		}
> >   	}
> >   }
> > @@ -1737,6 +1737,12 @@ static int stm32_dma3_probe(struct platform_device *pdev)
> >   	u32 master_ports, chan_reserved, i, verr;
> >   	u64 hwcfgr;
> >   	int ret;
> > +	enum dma_slave_buswidth stm32_dma3_buswidths[] = {
> > +		DMA_SLAVE_BUSWIDTH_1_BYTE,
> > +		DMA_SLAVE_BUSWIDTH_2_BYTES,
> > +		DMA_SLAVE_BUSWIDTH_4_BYTES,
> > +		DMA_SLAVE_BUSWIDTH_8_BYTES,
> > +	};
> 
> I'm not fond of having this large block after the "shortest" declaration
> (reversed christmas tree order), and since it is not a global variable, I
> think you can remove the `stm32_dma3` prefix.
> 
> By removing the `stm32_dma3` prefix, you could place it after the struct
> declarations, below struct dma_device *dma_dev;
> 
> >   	ddata = devm_kzalloc(&pdev->dev, sizeof(*ddata), GFP_KERNEL);
> >   	if (!ddata)
> > @@ -1775,14 +1781,16 @@ static int stm32_dma3_probe(struct platform_device *pdev)
> >   	 * channel, and can only access address at even boundaries, multiple of the buswidth.
> >   	 */
> >   	dma_dev->copy_align = DMAENGINE_ALIGN_8_BYTES;
> > -	dma_dev->src_addr_widths = BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) |
> > -				   BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) |
> > -				   BIT(DMA_SLAVE_BUSWIDTH_4_BYTES) |
> > -				   BIT(DMA_SLAVE_BUSWIDTH_8_BYTES);
> > -	dma_dev->dst_addr_widths = BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) |
> > -				   BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) |
> > -				   BIT(DMA_SLAVE_BUSWIDTH_4_BYTES) |
> > -				   BIT(DMA_SLAVE_BUSWIDTH_8_BYTES);
> > +	ret = dma_set_src_bus_widths(dma_dev, stm32_dma3_buswidths,
> > +				     ARRAY_SIZE(stm32_dma3_buswidths));
> 
> By using `buswidths` instead of `stm32_dma3_buswidths`, this can fit on a
> single line.
> 
> > +	if (ret)
> > +		goto err_clk_disable;
> > +
> > +	ret = dma_set_dst_bus_widths(dma_dev, stm32_dma3_buswidths,
> > +				     ARRAY_SIZE(stm32_dma3_buswidths));
> 
> Ditto
> 
> > +	if (ret)
> > +		goto err_clk_disable;
> > +
> >   	dma_dev->directions = BIT(DMA_DEV_TO_MEM) | BIT(DMA_MEM_TO_DEV) | BIT(DMA_MEM_TO_MEM);
> >   	dma_dev->descriptor_reuse = true;
> > 
> 
> Regards,
> Amelie
