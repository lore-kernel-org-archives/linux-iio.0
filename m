Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52FE3B14B7;
	Tue,  1 Sep 2026 14:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788273421; cv=fail; b=ng/OGVK0gUDvWKfjCZy9n9qGTZD0yu2uiq/CasoMej9ggGDD+/JJOSme2CWepUSnroDxjRfAuLUKz9I8WE4DPg3yYIXBmDXHGaHqcFcJHh0EFjaAJfhintaH/dQpQbW6h/m4l5NjZ3jSJ8CnSnz35QxNduq9KNCle+i98Qsj6S0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788273421; c=relaxed/simple;
	bh=XbNKVtoVLQwtYu2rkWM5Zru3Gj0lNWNVXveX05ZFfRI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Gh9OaPolyJ4Test7b8e4Nihz8gQY+sfmT8L9IsFBNTD0JGAsNQG4xHWnLfdtUtxwk2P7vJ3tmw84akqd7l4JUHM1fnzITg4O+yAl5zbgo2SwvXNQNGwswqD6Mo9R7wkwKdK8v73KmRm8QtAVyXH124SaMuOIbJ4bIbGItTu7TFk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=Tke3wnmS; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="Tke3wnmS"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 681EE3bT4128552;
	Tue, 1 Sep 2026 10:36:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=O0HJb
	Q2xiWjnvj/1hXi0qR52HiHNsP77dSr4LyyqtFU=; b=Tke3wnmSQlytDKkBC9tiT
	V2p2Kw8dJ2uyRXoEBgeAhXLXztmF+2v/pef2ZVpFpOekTIHDvgOP9UcbuH32nqd7
	AJwD/O1T9tw7qPP9molLkQSa3Xazv4cRNJyUOBEri1vO9/J7rdWGcz+uuXyd61ju
	aeGut2GNiRF6BRgeGfhlrdGRdlGSY4RlLdEB084IMboxr04q/hZrccwNdF6UvIJv
	zFXKyCUfv9t6VkZG0biqvYPZ3biF0ID4gtW2yio8fh2PFtpxDnDJdrnSJBGQazJM
	vNT19XqQk7f1jCdQpBRw16HlhaWlz/bB3c4D4ieiLHGsK4ZENsIUevIjBPkW0su2
	w==
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011065.outbound.protection.outlook.com [40.93.194.65])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4gbvb2w8as-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 01 Sep 2026 10:36:55 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=abxvdVDMzAzrcje7m52E96ME5GhjhePtVW8NCn7moAqWlBolUvTnoFgYfTJscGb/nHxMuUOTiU8QHFy4sUzQhSPO7TYsv8QqpUo2Hsyx8I2hXgpMRRpFfA2+ZZI2AVduqsDrG6NbQe48bIoWwnMeqiTHZVy/QF6/b2XMr1+3gxKUWPNnavF9z63xxtiGhoMNkIgcgkj9HJTGc1KBLak+HGe0/WMtDOSG8+J9aNF7YMR+T7QX6FZ6+zoUL8TQTeAik5Iv/8K59vlmIMA7VpH64Iu9zTspogCoQhQnG+wSaDVt7p/MVkWjjzk7o0U0Kxt0QWE1N2icquaZYgLBiAF2lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O0HJbQ2xiWjnvj/1hXi0qR52HiHNsP77dSr4LyyqtFU=;
 b=aB9w404oujtY+j2UJmILqXX5K32Ss4JHooNP2+FS+hEHRwspiHUFn3cuOQwA4WqmDHvolnRQFvSqdpyXyo/ITLm39o7taKbmQ7+AGPbCq3ngWwwiGIjEL/FAF9jYL3UinVhnyc62Hizt1FT4Bl880Osx8hhYnsHeZrB8MPxw3cXaL1dQtg20wkV4pJQQVbkjzxmpwUUmjBeHiL+6o+CixYqumtDYxXsP3Kk/aIoAd+q4jChM0eL4pBvmrBeOQaaa1na9kW3uL4aNreCW9V+uMbc2cqbTNsuSOALjwnMvFXL2v9zEpHrlsJiVPHaP86t9uOVGBsBlLTVMcs/TpgHDHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by PH7PR03MB6943.namprd03.prod.outlook.com (2603:10b6:510:15b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 14:36:53 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%6]) with mapi id 15.21.0360.008; Tue, 1 Sep 2026
 14:36:52 +0000
Date: Tue, 1 Sep 2026 15:38:05 +0100
From: Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Salah Triki <salah.triki@gmail.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Esteban Blanc <eblanc@baylibre.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        Andy Shevchenko <andy@kernel.org>, linux@analog.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] iio: adc: ad4030: fix invalid oversampling_ratio
 validation
Message-ID: <apbhxUo6LTHH278l@nsa>
References: <20260901104243.48732-1-salah.triki@gmail.com>
 <apayPCk4ln_Hh_Bb@ashevche-desk.local>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <apayPCk4ln_Hh_Bb@ashevche-desk.local>
X-ClientProxiedBy: MA3P292CA0023.ESPP292.PROD.OUTLOOK.COM
 (2603:10a6:250:47::7) To SJ0PR03MB5469.namprd03.prod.outlook.com
 (2603:10b6:a03:28a::17)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|PH7PR03MB6943:EE_
X-MS-Office365-Filtering-Correlation-Id: 6bfeb411-9da8-4f68-a6ba-08df083676b3
X-LD-Processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|10067099003|4143699003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
 wYo7OmgMdi3cUmTNYAcBYRSryT/4ru5SPe5BePdxzCMjviabu7uaucQSk9kxy5zs2OO7WngmzC6me77JYlNTguex/p2hTNHvo71Xh2bAy4aIcUWTXMWnNxJ9gNk58WOO8IAqYDPxkNL43aYpdh60xblYjcnd26Crf1HlerisYd6SzOG9B/pdDS46gJHT1Q1dElw0j/pUuU5w/d5NW33NHz1SM68f+SEMQD4T6Ck28uhXmxTyaJmu3iLpUel3LwVVrq8OOVtwCLc/7nuQ1ujWjmizvNPQEslE318NSkLKaLjNqMZbAwHcIRXBcL2e5WY08lO8DQhMoiKtxn0sLBhxjpDkqW5rguLnjCaS4EufdMNpFaZWZiiVXD4fEO5jwG2qFu6ZqKVPxapOK44iFgZPWs7FXNrxiIkORcAtuGBuMHxXHcKWToM1tYAqCoRFL/umAzZ437vdHec1iOwH77WEP9hdR19X0Jvo54duoWC/OEKj1Nv2+C0/KPofUzh+vLZUnKeR07C83i0hoZANwayyK3J1jJxtyxCp6LYTaWjajW6OOSeLksNLX8MVN5A41wxF4Zd5xkkTGzSdDEj9yd8vDAWFwCaq2I/s7xBcjmSgc5duOtqEHf6xli6QNa7cZmWlkLH9LqUJGg1lpjnNJuqVvoRRfgEoKK3hIF410zmauCs=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(10067099003)(4143699003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?VEtNdEk2VHMwazk1WVhjRmNEZWJlUVRoZThra3haVEdwZko0T3NnNUpYQVJ2?=
 =?utf-8?B?dG1aN09rLzZkbDc2UHhzQ2ZJOGZtVFMwVVI4UmNMT1Y2UUZPNmFLdDRZZ1Rk?=
 =?utf-8?B?K1JiQmxaZ0RwZXNVRkN6TUV2YmRSUjNKMjVKcGNrUWllMjU5eVJZK0RHRmc5?=
 =?utf-8?B?aVJJM1ZPa1VURWFHQ3J2TEJFeXRPNlN0TklpdGl6dVd2TTJmaWljdSsyUzdN?=
 =?utf-8?B?QTd0WWpvNTBjMXptQ0E3cm1aWm5Tc1JXbmNUZzJrMWNqK3RjS2s4YlMzSUwx?=
 =?utf-8?B?VTdZMzluY3ZzYVhReGJiZmtJWmlXdHRtQzljQVFLYmcyVkNMN2NWUk5nVFQ1?=
 =?utf-8?B?YXZacjZFZlRwNUU5c3hVQmtzVzFKZ1FaejJtSWJJOUYxdlJiZVJZaCs4NGhw?=
 =?utf-8?B?UnFmZHJzZW9TTFc0WkE1NnlSdWxhNFVoZUcwbDdHcjA3bHE2Y0FEQml4Ty9L?=
 =?utf-8?B?R21zSWR3TE5lbFRCQzQ3WWozc0J0UDI5WmtLK3o3bEhEUmZSQjUyYlpCSmxE?=
 =?utf-8?B?eHN4QzkyNVVuVmk4SkkzVjIzSUQyRzdyb0hhK3VxQ0VtTXdkYmltSDFjd2Uy?=
 =?utf-8?B?K0Q5cTY4dXZHNWdwbGdacGFEaUxJdGUvMjVCTHJxUGk0QnZucStKWi9EUjhu?=
 =?utf-8?B?TStFZHJmSWpRSlR2cFlEOXNYSEVzeFpUdER6WUtRUENoam5SaEk1SGtEdktq?=
 =?utf-8?B?SlorbXhPQTNTRUtuZlFDUm84NkczaTgxbVk2T0ZldEdjcjBVVGVKLy9NenJo?=
 =?utf-8?B?RmJhQXZ3K1BEZm5sRUpybzZFM28wc1ZlTmhTdWhqcE5FZmk1clpmalZZTE90?=
 =?utf-8?B?NTh4Nk0wNWdHRmlLRER3V002c3dmYlZrNFRwaVJvWHhLK1FNMnpYd1I1SW5D?=
 =?utf-8?B?SkdxYnY4bFY4ZjVvZHdiSjd0YTVHQU1MSWZzMjJoZVZTTUtsQ01CR1FkeFpZ?=
 =?utf-8?B?QUYxWXFqQW5Qc29RUnk4NUhRdDdyZyt5VnBESjFkUGJxRy9ZbEFGdm9MVzBW?=
 =?utf-8?B?QUNvZG15Y3Q2cUdzd3lnRnY2Q0JLWVdXdHN2cis3Q3NTZjBaYkZvNlFaT3Zw?=
 =?utf-8?B?NXJzNUVHbGZNSWVpRGFpZ2Rvck5ZQ3NvWkpCZEdaUWRNcVh1QitlZHlQbUFw?=
 =?utf-8?B?NGdIRFhCVC8yR3RSSWtrQm1XR0dTMTlTWGhHQkQzVUlXODFjNkZRL2RxT2F2?=
 =?utf-8?B?c2g0Z0JqUzRMblowUktPb0Y2U05HUEtJaCtwcC8zWktEd2dkWUpDai9MNmU0?=
 =?utf-8?B?QkVyUXZVSlFMeXFwdjVnS0QzYW9LVFcxcTcxTlp1ZXBMbXFOay9kRzUzU0pU?=
 =?utf-8?B?cTJpVDd0VitXOUNCclJabGxSb25ZeHltQkdCOTFGMVlRV1hYRXorV2dXSFdw?=
 =?utf-8?B?K0NnWjNuMC9VR3ZsamtIRnl5cHRiQ0NtbnJrRktGVFJYQjRXeU9PSHA1Y0RO?=
 =?utf-8?B?Zy81RmhOdllMSFJZZTUyektpeUp2T2ZvYVRBMGNXNWJTbFNqRFF0N1NtZytL?=
 =?utf-8?B?eDNmYm1wNGxCdFUyMTl4ZHFkd3lpWGVodnFGVkZmSjJaeW1INDIzVVU0NCsv?=
 =?utf-8?B?NFRFQ2d5bU1OaGlsNmxCNm0vOGRUOXlsbG55Ty9CZlp1ckpaQVJGSDU2L0pJ?=
 =?utf-8?B?SUVvWFVWWXlYTnNRa1lXcXEwUEtnZUJXeW9oVXNhVlg0NzltUFphUFJuVTF2?=
 =?utf-8?B?Q212SUljV2tqQUhqbGF2VGxKVG9lM2V5d1BzSTJHdWxCMWFrZ3hIb3BmaTZh?=
 =?utf-8?B?b3ZET3hlRzNOTEVqZjE2enhpZGlxRWVrMzJ1MUZ2VWtJaFd4QlJXa3FkejBr?=
 =?utf-8?B?MGFqL24yQlJrZ0N4a1pobjV6NUNtQ0hWNHRYUVAxNi8yMXRSNzJjNldrdmVx?=
 =?utf-8?B?WDBQaXJ6cTd2ZWUyWWpMNnNzQyswZVhZUSs5ekg5bGhzb2t2MXUwZmJITzFD?=
 =?utf-8?B?eWhUUC9aVjI1SDBzU1pKeERvUU13Q0RVZWdocWFkRXF1NWFmMGw3cG9KQktV?=
 =?utf-8?B?TG90S2FRMmc3WUVYVzB2ZWRNeThoaCs2emFCS3NPQ0lhMXI5Zklmbk1GM3ll?=
 =?utf-8?B?OGlDTk42eWRhc1ZIc2ozTHo4T2g1dVhvT0Q5eWVQTHE3bEUrSGkzNytDK0Nl?=
 =?utf-8?B?OGJIdFZEenV6S2xjaVFNVTd6RHZZbnlGc2d0T0huaGVsMmpnZFZncVZHa253?=
 =?utf-8?B?aEVDWUlPWEtVOXRBOHUwSE5qenM3cjBUbUNPempMMUNKLzN2bDdXS0FJMnlY?=
 =?utf-8?B?ekI4TFhGUlVYdVY2WERCU3JGQkhLWXJMdVZadEdqVUVBVUpRWnp3ckNtZXdQ?=
 =?utf-8?B?SE44Q21UdTE4cTVSbzN3bnhQdTZrTlhIOHJoa1VaK3hMSDRXNnhHUT09?=
X-Exchange-RoutingPolicyChecked:
	xSJOpjSWGs1xm+zr788kcvSCGlVnFI3iHpCU42HoOMUwANi5td+A8J3dt8vHs0JitpVyUm2qnAUDHd+92CzDeykLVauZf/uxUi57zmhAkA7wwUIYZcjTcPPYsdNLtcG/FdhrqoZQ0HtNH8z8tlzOBiUObgmRa3KW1jyHRkwKmwPYD2Lf5ynCG0IVB54jdPkqXunaLZZaho1jVN4jYuWuaWDbKhwl+2+GNcgZCHsl0rm8IJb2m6h8dJ71xkZdyM264evNt1M8EkJtCszTPH5wbTz7NsZws2K7xusieT1279AMTAoQS1XbpouLuJ5bVSSn4A+OSv6qpH5ihXga0af4uQ==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bfeb411-9da8-4f68-a6ba-08df083676b3
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 14:36:52.8972
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xSPf2oS82o+GHucbGAsX20SEzfAvgl9NFm44+dh30ELYYpb9CJlUzMc7MrIkQ7eaPpjATtNHXZNnyg1OmEiyXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR03MB6943
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAxMDEyOSBTYWx0ZWRfX3WUsi1001Ij1
 sIDUHwxHeDPpQ5b/EvHRlun/haE9FyXDJtckmET4UAkBg2CBP0vxZQlibuBReoHdq6paL0CjBvN
 Esd5uR0M9dah8um3+wPHyoiDu76ZAG2u3FmXkVlVC5EdD3Stubhh
X-Authority-Analysis: v=2.4 cv=QopuG1yd c=1 sm=1 tr=0 ts=6a96e307 cx=c_pps
 a=JPuSXJPnATmcGobPKBfcew==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=Z0pTeXoby7EwIRygza74:22
 a=pnJFehDEzG3iGMA_AA8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAxMDEyOSBTYWx0ZWRfX++LMRrN6pJNr
 EN8/eVK60GCf3pgWsruUUBkki24MBmU/ZU8r2S7YMkPbMiTZdbE6d+c/ajslkBi/I0nvjBMagos
 VbyNoPHDWLTrWiv2Y9rdlmrMQSsR3l3D85Q2AfhuZwKWGc3w0u2jsR8H/kOd/OyWgB6AfIcdE6N
 wLn5MC/2rhsCtDpqsTVeviUA5OQGgLasmN4VXwn3SEP4i5vyV1Bv/54kG/69YFnB8pcOQOWIWvE
 hX9ZLbps2h62YjekvFmDjD4lI6VN8ex+odYQUzaV0Dzagzk2wn666SBoV7xkzrlp4hLrNGx0ECN
 9oEoZznDRcIgOKXZX5LraAaVUrVDcUJRtpA85iovryOA8R+Lt2BYYbklIhUbaxruQl5NABGq+q9
 Jq9j/s99fDs6ZHEe72Q4apuBa08PQTyM7j0mRQnake7w7sDKBxHBwFU7qzbAmCBHnkes3Xjm+f3
 Gyv2YgXAniHHasYB2QA==
X-Proofpoint-GUID: L-kyGWJsentaHiga518HgBHQJR_4DAk1
X-Proofpoint-ORIG-GUID: L-kyGWJsentaHiga518HgBHQJR_4DAk1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_04,2026-09-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 bulkscore=0 adultscore=0 priorityscore=1501
 malwarescore=0 spamscore=0 clxscore=1011 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609010129

On Tue, Sep 01, 2026 at 02:08:44PM +0300, Andy Shevchenko wrote:
> On Tue, Sep 01, 2026 at 11:42:43AM +0100, Salah Triki wrote:
> > In ad4030_set_avg_frame_len(), the logarithm is calculated before input
> > validation. Passing zero or negative values leads to an undefined result
> > from ilog2().
> > 
> > Validate that the input is strictly positive prior to computing its
> > logarithm to ensure only valid values are processed.
> 
> ...
> 
> > -	if (avg_val < 0 || avg_val > ad4030_average_modes[last_avg_idx])
> > +	if (avg_val <= 0 || avg_val > ad4030_average_modes[last_avg_idx])
> >  		return -EINVAL;
> 
> I still find '<= 0' confusing. Why not check against 1?
> And I would rather see an additional comment.

I realize here it does not matter much but I tend to agree that the correct
check is against 1

> 
> What about
> 
> 	/* Reject unsupported modes */
> 	if (avg_val > ad4030_average_modes[last_avg_idx])
> 		return -EINVAL;
> 
> 	/* Avoid invalid values for logarithm since it's undefined */
> 	if (avg_val < 1)
> // In this case, when condition is split, if (avg_val <= 0) is also possible
> 		return -EINVAL;
> 

Also tend to agree with the above but no strong feeling.

- Nuno Sá

> > +	avg_log2 = ilog2(avg_val);
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 
