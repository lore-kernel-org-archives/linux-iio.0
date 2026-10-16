Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF4F343C079;
	Fri, 16 Oct 2026 08:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792140310; cv=fail; b=VLXuE3J+6Av+UoxgSQSCD0+q6Xm7NFShU7Ip3xlfQA9uOcuwYmrIr40N3gUTcQORulI70qftvSc3b4A0uqwycKItzrBzCmYzURnaWG3Zq6FDtuNWB5P9yHwOcLK5ggq8tTiyEWL1sPYumbxeKBh3W5kHu08JO0HYknViEWqyOng=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792140310; c=relaxed/simple;
	bh=pDbZpNJ7t9SXDDahD5M4rOZ9rtm86twqM72vUtwVs14=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=T5nxCI3OO0Uy1pnQB7K3C6GhsjnKRrTECAh8rAzInHyOl4pyDfjfCmhrA05oPQRhkjRNs3fFvSEpv6012D8L/Hi8LJd4RDmHXQEq1or+NHn13IGzcxZTV4dYk0fOTno08/TqNtQ+M+sqZZ+M2g6eSMRfzWuo5dXUNWwyjPlxY7k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b=oQP/pkE7; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=eb90YaYc; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b="oQP/pkE7";
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="eb90YaYc"
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69G7JkpC2519977;
	Fri, 16 Oct 2026 04:44:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=aXL9S15zQ7KbwwYlRa/aQk4QHYbkK7vBYfsIZDEES5s=; b=oQP/pkE
	7JFeZZRAct5PK+zNu66LIrd8ig00FJJKIVG+icTam/zvXNHTEjBe/Fs7yoIlIilX
	Zza3CSbcJ6wJGOvQjNJTbRPuOrCMyYgTb4NK7YPnfzW/seKCJJeUMFFz18c1JdfE
	DS/30P/dAd7ntrMQWeGtAutaosodsbYGTdm7OWro6aw2AaYn0kBxYirV2NYl3o19
	OvWFMkTK+ii3RuCjzypKR1lB2J/aY1s2c8DNEJFz3lO6rJnHj+2T+jqlk+w7vlfU
	B9daepYannRjUr8ASqawJa4OEHBpfUSm/F8OEMPHy3AK89RYyTUq44FRhbkgVRx0
	C/zO5jiDasEZ/7A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=aXL9S
	15zQ7KbwwYlRa/aQk4QHYbkK7vBYfsIZDEES5s=; b=eb90YaYc9hjj7xH2XsiCU
	DgYJXNkURaz8SKj6y2uzFdCJk9loVg/Syobl1P1HvfC8vlg5a88WC+l/1uLtrQm3
	ox1F8EQajraY3kbUnXi9ve89nG2XcE0zejNOWFyD249k5pbRbDvagkxuRzN3qSEg
	m8OVK2c9ORde/CxaWpCC90AWxdoVH+dFs7Zmv0c3xPynx1johubS4nltqnaTZc9g
	pR0WMLknuGPp65A1Za91BHRdVqkvMTRcQh2/7NKsfIBllviGgnSXuNLWjxVnFG0T
	tqsEzSPP0PL17FTZYnlWDX/FJPc2P6T6kSdsdVqkFLRJU9yF6YUWZtGZcEuYHTBz
	A==
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011009.outbound.protection.outlook.com [40.93.194.9])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4haydtwfj3-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 16 Oct 2026 04:44:53 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FfpjZ9cPXe5M/GPOkwaOIrvyWi3kMx1MZ/aDTUOw91QY6mf2rxlsHgRjlC8c8khwWRlxSXp+wmDOeGTGay5zxc2fMkZB58mXvIGaQF924vunme5/pW0Fz0aHTeiOGHdKc+LzdvaSUlwP5/7aN787PxWEtUfC3Y8Be6IO0NYD1arSOxOVxY1AG39xzjpe7Fd8kXubBHWvtvWQxflrEq2SpoqGev2B6nrmohnsNXviTr3BQ1AQNxnTTMgJXrcYHyMePc03NKVwLrQWpNa81cMZM+MgfyxNbHkYEjpI7w/RuYmqUFtTxlb12J5k5dLBerzFj+qyYvgsgM6GgAlH+qTudQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aXL9S15zQ7KbwwYlRa/aQk4QHYbkK7vBYfsIZDEES5s=;
 b=k4DiRbOtFdDZks481ZFjmTCHJZ/I+RPPjMfAyWld8kLYXXxB2+wWMHheuUHvkq8dfYXe1Dpft9wSH5UJOEXb2yc96HNoiSR5bKjvDXDtiIszu76ZsFBFu4Nj5Vh6ihsGGH930cU+aphESFnpBq7rhXxb9AS6qCpFN3kJkUFAtwboIVa9tQgfx/gcosoSDnJxxxO004nGj2ylk/flHq6OjBVOSBvSlrsbe6JYBuxHZ2tMGGwSy10N5RDhmpyAMQPwyqOyheNSVjqK3dKTa+OgTMbUPonTZl5Ey43Byx+wmsv1TKEQVz1tyktCLaCb8BLA7MvfoP2UarH83epY0EVPgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by SA1PR03MB6564.namprd03.prod.outlook.com (2603:10b6:806:1cb::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.15; Fri, 16 Oct
 2026 08:44:50 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%6]) with mapi id 15.21.0522.013; Fri, 16 Oct 2026
 08:44:50 +0000
Date: Fri, 16 Oct 2026 09:46:11 +0100
From: Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>
To: rodrigo.alencar@analog.com
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, linux@analog.com,
        devicetree@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-doc@vger.kernel.org,
        Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
        Olivier Moysan <olivier.moysan@foss.st.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        Andy Shevchenko <andy@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH 02/10] iio: backend: add devm_iio_backend_get_optional()
Message-ID: <atHkFuU8XOSkkl3N@nsa>
References: <20261015-ad9910-backend-support-v1-0-3c21648c8e26@analog.com>
 <20261015-ad9910-backend-support-v1-2-3c21648c8e26@analog.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261015-ad9910-backend-support-v1-2-3c21648c8e26@analog.com>
X-ClientProxiedBy: ZR0P278CA0155.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:41::16) To SJ0PR03MB5469.namprd03.prod.outlook.com
 (2603:10b6:a03:28a::17)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|SA1PR03MB6564:EE_
X-MS-Office365-Filtering-Correlation-Id: d7889a3d-64b2-49e9-0e52-08df2b61bdd4
X-LD-Processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|23010399003|56012099006|4143699003|11063799006|261009223027099003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
 BewuhMP4eIIgdPdO9GQ0Xg/SEPk3BS7UPJXb+lpZ/B0M72+6KurHOJ2WJBV5Z8/zOHMkYlUB/dlkTymkYkwMSoxi96s+ARZ29/XL9P/nOfINfPweP+d6dRgwTgnFalKcaAFXG1uPxSo/cPGUWXcnXuH2OKU2ibCb8ht8vH6JyQ9tdMdFp2idJglQcpLmQ0+xjasMtBqM5llu6OaCcCJKuOhuOV7roIxeIG/ftiKHN8dcU4tijDWYf8USSJhSwLXFx1THOQVvmYtjmRfZExmG6OnwQ23dtAirRANRE42uKKSL8fmC5VcKkb5reAUJDxHKyDgDomuzkH6xH8mlveckxDA+kj3EyJZBPaEkhK9fxe2WgdC59j09YP9h+4UPxaFpCOOnH2aMihTTf9h+2bCZBKUmkL8xNqYyUYcV0d8ZinJ0Z9ULajYnF7CeHY6tyBY4YpxXf+iHg9A9EeXKMukKxLEE+Lmdel4G7g2pYR4O6I84PfbSB6jLgAdQ5wwwNzYsec7dYLo9i94TIWWaBV8nFIUSahE+X/SiuJsLQp4XluRk36wrJ0i2Vn/0JaPwp/enfinU8jHB8Df+63KOE0EBVF4MxrgVONx0zJsteXN8/3htKjCPEAxyAkjXjLwQbDkghKJsopEudI63uPa3ty8zzo3h0paKvwtFzZruwFap0rI=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(23010399003)(56012099006)(4143699003)(11063799006)(261009223027099003)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?QldxVUtCVWF6Q29ZdDlacXNQajZmK2tKMDkyQzN5Q1FKZGZtRHhTY3IwQzAy?=
 =?utf-8?B?dEdVL3RzZGdBSzhGNXNPS2pNb0FYK2d5aXFHenFKRjd0aVR4WjduczFqOUp3?=
 =?utf-8?B?K2RweXc3TXE5QW92c3FBWU9SL1JyZzRWczhSQ09EVVp5dnZZYjFGVWxhSDVj?=
 =?utf-8?B?a0xrQlJLQWNUMWhsQWtxTkdrWVcxUkhDVTRveWR2RTN0SmFaUVRrZEdLblll?=
 =?utf-8?B?cVNRU0ZIYldxbHFBMzZIQks2Mm91SkhtL0N6aC9QTVB3SVdmTDZuNmpyaS8r?=
 =?utf-8?B?NGlwQmVDeGRkQUJJOFVkVmRaN01TemFPdXUvdGJ5N2lETllRZjNMUlFQSHV3?=
 =?utf-8?B?MDBrbExkc1NBVnVYOTNnRUwrbm04bU9BV2E3VkVlcFNDZ3ZxNG1sanN1OE1p?=
 =?utf-8?B?RDJ5Q3ordUFTbkMrMTkyK1RJNFRreUFFUnp6VEg4U0FsSlRBK3JZR2o3R0VE?=
 =?utf-8?B?OFQxL1RvcmF1ZFBFV1BUUlY1ZVVYeXdDTFVHMjhvUkxIei9jb2xhSXlBclZy?=
 =?utf-8?B?THJTcGdUMi9yZkUxK3lNOU9Pb2FuS1pmM1RnMk1EMnQ1MS9PVEZBTFdqWTFy?=
 =?utf-8?B?TkJsbWROTWxhYmNheWdDNUFMbXpQZGJZRkdEWnNrVmdDalE0NDI0c1RRYm9J?=
 =?utf-8?B?U015djdERzlYZ295Q3lYYnJNM2d0MUNUUGJPWGlzdFRKVXZQSTQ3UlZSL0Nh?=
 =?utf-8?B?dy85SSt6RUZSaHpXbExrLzhlbnN1OVFNQVV1Ry93aC84RE5Cc3pyOGx6WHd4?=
 =?utf-8?B?OWdCdjB5cHdQUExieS9jMklQeVFDZEFhQno0YmN0NFZpZFJ1M3FrWk5YTXIz?=
 =?utf-8?B?Ni9OeTZQNEN6M28yMDYxa3FURjVCN2VWYUFTMFZhdGVOTVhWQ3ZPU3Bua3ha?=
 =?utf-8?B?NHpVbmRzSnM0SG5FemRVT3VZd1cxcmRybW9jV3BySGNBM1dEMit4TXh6WDVJ?=
 =?utf-8?B?TUNSZUhVdVZJRTZEdUgvYkRDcEJkR3VCVDVlTEVsTkxpRDZHWmZIeXdaLy91?=
 =?utf-8?B?eUhaNVc4Sm9TZnk0T3k1R1M3TStWK2Q1N0l2YzMzSk5TSlNDQVFZcXp0cENS?=
 =?utf-8?B?dnJVb3pWWmFKUUlHWWIxa1ptNEJkenhGWmhFWTNhanJZVHZQcU5IVGVqZC83?=
 =?utf-8?B?VGNTakdLODVISzFUVDkyZDFaYmdSaC9lSmpZbGIzeUcxOVgzeWRQWmRGL3RT?=
 =?utf-8?B?c1JocmVhUHUzTWdLd2hhbnhXSG00QUNURzlyQUxSWEJEOEtnc1A3Ry9xMkJD?=
 =?utf-8?B?cDZTZ2tsOFRpRDNKUkl2cjVyL1kvbmc5c0FRSTdHcjdueVB0K21mVjE0UG9K?=
 =?utf-8?B?MkNJZkk3QVgxM01HaDZXMThaWWtUanN4TGpJbHdnVldrYTNjL01ualZiVk9L?=
 =?utf-8?B?aEF0d1lqVEdMc2NhNWJmUTQvMjh5Nk9Bb0pOY0JjdzdNdlNCendqNUFEN1FZ?=
 =?utf-8?B?dDdzZUExYjd1T2NTSHNZaVEySDNScjZkaS8xZFJlNHBCYTgrUWVtQUhTVE9P?=
 =?utf-8?B?bHZ3TWZ4ZlNPVDJpQkdLa0dGR0lRS0lVTDdweklJVHpFb2JIdnFvdVhpTGF0?=
 =?utf-8?B?Z0lXSGVKMlI5N0lraURMMnlCaktORkRnWXRNNmI1RGZUcnJVbU52NGkyVHJn?=
 =?utf-8?B?VG55OUx5c0M5WGNPUklNV0drU0c1YnYvK0RNdEZkMUlFai95amhXNnEvSmk1?=
 =?utf-8?B?anlxSGlaWlJ5d1k2bld6YUkwNWIyUzgxb0tEYlU3emJTeUE3dUtvOTRLakh5?=
 =?utf-8?B?WStPYU9UWUE4aldUQ0ZjVWRVckpiMEVkNmFUdThReGk3MGxmZFRtaDZYNG1L?=
 =?utf-8?B?SzV4MUJ3clhnb29GOGNGYlhhVjYxbHBGL3ZSa3JaaTBvSk9QVTI0Qmp5VVgr?=
 =?utf-8?B?dDBsNmpIWWk5YjNNTmhQTFBwNStrdy9CUFRLYWtJaEpvWFJFSmxWMWw2QVg3?=
 =?utf-8?B?dGVRalBLSVVIMzBWekFDeEZKWjRnSnVFcENLdG96OWFtN2ZraVl5NzlzMzJl?=
 =?utf-8?B?dElQTTlpRUZWM1hNNHpMdktwa2l2QkdnZzhJOTRYQmRqVWRIaEdoRkc3R3RJ?=
 =?utf-8?B?TDlLTnBwQkRnVEdNRlNIMW95bFFtSHRVeWdSQVlrNy9vc0tVT1FrNVRWQVZ5?=
 =?utf-8?B?RHR5ZkJsemFXdjlVS1lNWGs1SEJzd0pHdnFZbWNNeHNyUjRvNHFFN2U3Q3Fw?=
 =?utf-8?B?UVg2SFBlTHAyd1c1Y1c3WXF2NkFYcnVyaHRQWDNoSDBJbmF3QVZxMGk2aVhW?=
 =?utf-8?B?Z0FrSnBwaWpib1gybVpvUXRuZVBaOHlYUm1GQW9QTnpNRUhDaTM5WkRjc3RO?=
 =?utf-8?B?ZkttRGJhTzVwVFd6Z3Bqa1ZrOEVwZ0JUaGtPcFV1RlhSeWEyMDg4UT09?=
X-Exchange-RoutingPolicyChecked:
	jmhDL/CNFrm0xBfzJW5FSp7jdyrJcPSvs0XhBxmOByb/EnrlU/i+cuEWNtr7ulDBLAvTcp+aDPY5RhvnXeTZn0njF1mgS5KBkvi2PryMwO1walKVH7xF3L1dvQXg07VLrNoKW3YVcEliryA6bN26q7ZAc6/AZ+1mhik6l5M8u4CKa981tQpNa9MJUncnCHeKaIy4b7g510yXabK6MYa5n2rp9R1k7a7pRbp0ShZhZs65Wsn1ZWLFhDqGMFrTF13K1fynMQYDUsLGWlXVawHUzJPtGEa+jDh/YMSVEYLpyfs9AqJ+4Hkxe3m0ua3PPDvTe3W/OyTXpEiLtHN/YAtoLg==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7889a3d-64b2-49e9-0e52-08df2b61bdd4
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 08:44:50.7800
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p8o3A/urzbSpxDqaGB/5EhJ1+CBKrsEBynCGfciUBDOT9XIoaMUBIDlYeHy2KINmpu3JfIoxiXCdyFouKo2StA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR03MB6564
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDAzNCBTYWx0ZWRfX5jnzzjPoAfkQ
 3jwZ6WLF9r7TjlnAxWavySkUbCgCQ4gEwfqLuUHQuE67nPiZZOd24JidMnZQ0scEhry5e7YABMf
 oOrM7oI5gkACq+dfGGkXGnBbT599AC30VgyVFXkUwOjEKhU6MWNEERbKdg538gfLARkNCqUe2lx
 L//VzAmdACZWvb3VjFbfAo8imbs+0/kWNTVbQaiQC5dGCWjrVEob/3Iu3fTe6taEQ6WAuYG4Zqr
 4Zb5qy2HZCcIuN1WsKMK0Mmos1GiAxCa8/+p5WjDOMVvncdcH8wuv6R1DdZUPm/dl0iMKpDriw+
 v/UuLAvbFdpcfQPCs1r5UkY1ZjADNt1flfOgYBFOQC20Nb43A6Dn2bX4189ULCw252iWnMRF4e4
 5szPzyejFdfW5Gp+/VDW42Wb4X+u3QmnxNxmr0NJmKIYO9sKk6gkDb6eM8ViFq09ZOPj0yq3k9j
 5lztWmiEBy/Db8nCDMQ==
X-Authority-Analysis: v=2.4 cv=S+VMU4sP c=1 sm=1 tr=0 ts=6ad1e405 cx=c_pps
 a=9d+VVJWglIGFt+56pYWlLw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=ugNRTJOwpmtT476g4l8T:22
 a=gAnH3GRIAAAA:8 a=2A9BBXgmvOcNshPfxpAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDAzNCBTYWx0ZWRfX56kEoUBLB4jq
 WP/8jsITPQJVpvL7rme8IsfWNSE3TMa0fL8DaIz4bpcJsMvKs3RSErDdxhis19CeJPOiI/hAjpc
 PZrNSEMPRH612xxH19JHGUe7lsChDLcNDPj53tBQCZdWTxO9mFf9
X-Proofpoint-GUID: 9rsa0oHAl2hEj-pQdUF2KhJJZKZwCJca
X-Proofpoint-ORIG-GUID: 9rsa0oHAl2hEj-pQdUF2KhJJZKZwCJca
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 suspectscore=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 spamscore=0 priorityscore=1501 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610160034

On Thu, Oct 15, 2026 at 01:49:42PM -0300, Rodrigo Alencar via B4 Relay wrote:
> From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> 
> Frontend devices might not need a backend driver to rely on. An IIO device
> that supports backends can behave differently when they are not available
> and that should be acceptable. Such parts may provide basic functionality
> solely using the control interface (SPI for instance), being able to have
> extended features when a backend is present.
> 
> Add devm_iio_backend_get_optional(), which returns NULL when the backend
> is not described in firmware, i.e., when the io-backends property is not
> present or, for a named lookup, when the name is not listed in the
> io-backend-names property. Other errors, such as probe deferral, are
> still returned.
> 
> To make that possible, a named lookup that does not match any entry of
> io-backend-names now fails with -ENOENT, the same error returned when the
> io-backends reference is missing. Also, the missing reference is no longer
> logged as an error, leaving that to the caller.
> 
> Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
> ---

With device_property_present() (not strong feelings about the other
comment from Andy):

Reviewed-by: Nuno Sá <nuno.sa@analog.com>

>  drivers/iio/industrialio-backend.c | 34 +++++++++++++++++++++++++++++++++-
>  include/linux/iio/backend.h        |  2 ++
>  2 files changed, 35 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industrialio-backend.c
> index fbf5c39d7655..7af41ba50a65 100644
> --- a/drivers/iio/industrialio-backend.c
> +++ b/drivers/iio/industrialio-backend.c
> @@ -1006,9 +1006,14 @@ static struct iio_backend *__devm_iio_backend_fwnode_get_by_index(struct device
>  
>  	struct fwnode_handle *fwnode_back __free(fwnode_handle) =
>  		fwnode_find_reference(fwnode, "io-backends", index);
> -	if (IS_ERR(fwnode_back))
> +	if (IS_ERR(fwnode_back)) {
> +		/* not described in firmware, let the caller decide what to do */
> +		if (PTR_ERR(fwnode_back) == -ENOENT)
> +			return ERR_CAST(fwnode_back);
> +
>  		return dev_err_cast_probe(dev, fwnode_back,
>  					  "Cannot get Firmware reference\n");
> +	}
>  
>  	guard(mutex)(&iio_back_lock);
>  	list_for_each_entry(back, &iio_back_list, entry) {
> @@ -1035,6 +1040,8 @@ static struct iio_backend *__devm_iio_backend_fwnode_get(struct device *dev, con
>  
>  	if (name) {
>  		ret = device_property_match_string(dev, "io-backend-names", name);
> +		if (ret == -EINVAL || ret == -ENODATA)
> +			return ERR_PTR(-ENOENT);
>  		if (ret < 0)
>  			return ERR_PTR(ret);
>  		index = ret;
> @@ -1061,6 +1068,31 @@ struct iio_backend *devm_iio_backend_get(struct device *dev, const char *name)
>  }
>  EXPORT_SYMBOL_NS_GPL(devm_iio_backend_get, "IIO_BACKEND");
>  
> +/**
> + * devm_iio_backend_get_optional - Optional device managed backend device get
> + * @dev: Consumer device for the backend
> + * @name: Backend name
> + *
> + * Gets the backend associated with @dev. A backend not described in firmware,
> + * i.e., the io-backends property is not present or @name is not listed in
> + * the io-backend-names property, is not treated as an error.
> + *
> + * RETURNS:
> + * A backend pointer, NULL if the backend is not described in firmware,
> + * negative error pointer otherwise.
> + */
> +struct iio_backend *devm_iio_backend_get_optional(struct device *dev,
> +						  const char *name)
> +{
> +	struct iio_backend *back = devm_iio_backend_get(dev, name);
> +
> +	if (IS_ERR(back) && PTR_ERR(back) == -ENOENT)
> +		return NULL;
> +
> +	return back;
> +}
> +EXPORT_SYMBOL_NS_GPL(devm_iio_backend_get_optional, "IIO_BACKEND");
> +
>  /**
>   * devm_iio_backend_get_by_index - Device managed backend device get by index
>   * @dev: Consumer device for the backend
> diff --git a/include/linux/iio/backend.h b/include/linux/iio/backend.h
> index 9c16b695a602..93d5f2073cc3 100644
> --- a/include/linux/iio/backend.h
> +++ b/include/linux/iio/backend.h
> @@ -267,6 +267,8 @@ int iio_backend_extend_chan_spec(struct iio_backend *back,
>  bool iio_backend_has_caps(struct iio_backend *back, u32 caps);
>  void *iio_backend_get_priv(const struct iio_backend *conv);
>  struct iio_backend *devm_iio_backend_get(struct device *dev, const char *name);
> +struct iio_backend *devm_iio_backend_get_optional(struct device *dev,
> +						  const char *name);
>  struct iio_backend *devm_iio_backend_get_by_index(struct device *dev, unsigned int index);
>  struct iio_backend *devm_iio_backend_fwnode_get(struct device *dev,
>  						const char *name,
> 
> -- 
> 2.43.0
> 
> 
