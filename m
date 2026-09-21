Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 911B345A2A5;
	Mon, 21 Sep 2026 08:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789980820; cv=fail; b=fdz+sEpEI/g1IN0SzhCjO3492PSjkatCCFVjb7wBngiaw8fWsdlCzNmanlANW5j+9WJEh4JI/JKfSypiHISfQCneOtiEf/rO/zLP7PV10ImFykmSbwYJpf6GvzQnHUJ1il6fyKchE6i3aRNMpNbQpKOJTBSD9R/vJUKeFEAk2ao=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789980820; c=relaxed/simple;
	bh=BLgZ6nT3fYrrfP29yhgxHwj64f+9KxqWkUG/fHkTWxA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bVJNrKNg7RbDb/DLtg4cEl5T7tZUP5Dcp9qfO2URX2/Ryufds6G5Jdawyt5NeMYvleYn/ZcsPILpa7tR7jPsyAxRHqN3bgNnoOaRZMJLeMRmmDhVMh1dg5yxssXV2a6sR2tgWR8qUVc282F5fDVeK2B264ZQFpZZp/f2LDc0b3A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=1QLC0E4y; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="1QLC0E4y"
Received: from pps.filterd (m0375854.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68L79gEg1447113;
	Mon, 21 Sep 2026 04:52:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=7Skhu
	lWl6ImEe7JMRJjsMDuy8XF32BBhKaIPr4utRQM=; b=1QLC0E4yeg6tui+Olu+ZM
	qzUyNSU4KZTzalIUSwxfRhEC1iJyz4ytg72W865UbI8hBLf9lz0x7FsEGlDdDLI4
	PBEkXucvkyDjHmf7Pqzu7jDwzAI4i38Esm9g7AXD6YBbH2GPvugsRbT5kBUnzlbB
	2Ifv8ah1KATs5To0Kp8XPVOVcKEhTf6dA5qxFBY9ctP20itY5RbRBq/SDSKlkKex
	sghI2xz1k7y1gyHh30DUN/SzNFw3thgNwOrv5YF9d/fgJKlHfCEunct4O7FIqlLl
	Q3OOG46OXRpVT3kakuEgh9QkPvG5s82lTJFnwnYK7Y4DSBDHGLRjQiLnlFnwN8Q8
	Q==
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013044.outbound.protection.outlook.com [40.107.201.44])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4gtced2xhu-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 21 Sep 2026 04:52:43 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EXq4OcFmz0q2wqQi62cJunUanIHiLqKA/JZEY3GGbyKvu8mu6KCU87uIsMKg/nAi37woVr8MZUStpxa9JvFFR7v+x9YHV/YZCHb39OF4rEEzK2WIROcgUM6/Kz2VhYa3wc6OeIDObXk5vou1WYI6Ox2yLTG3hCRDsPjzoC6KDmknaosVXzpSXKuy2whTTKQjd6VfrVSvQ2UMiVH73DibFZ6sdz1v/qeO8NC+V4NDLa1jp/2GYPa8tutyFqkO/++hkatrIOeTC5Wq3s+WaipYPdssANlEUS3Vb0mJdipRn85dtsaPkEGGnnTAMgCwRkx77IC75hU2BZxTg5AlpZ0HvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7SkhulWl6ImEe7JMRJjsMDuy8XF32BBhKaIPr4utRQM=;
 b=TRa6dy8mpZ0kwQZV0TU53j5qM1rTJAobqGbrAsCTdpnSzrwctxhQnkxw4la2okOxK6NJAxKj6sr7ez0y8woMO1A+2EjuAnwubwwn6N6MNN8MwI34/f7yOYwew/tZ/3DUioHp6tW2U7Cwd+hqvQkL/KdWjLYmZoHAekiutoCg4jh2uobP009X5jYiSSbXJlvq5nKIXpCAqVPGk9LVh4C++bbocdgxMm7rXsLN+DH4LW/AuqFRojdnpkOsPshW5wq3dvUBuK2HjF6ejcxewzS+YVaqPzTv7ONdSNPmZhwKj+Rb69RKKy73d5kdGXZ4Fmz+TiWPMD6Nt6m/GX4IYNd3iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by DSVPR03MB989591.namprd03.prod.outlook.com (2603:10b6:8:423::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 08:52:40 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%6]) with mapi id 15.21.0428.015; Mon, 21 Sep 2026
 08:52:40 +0000
Date: Mon, 21 Sep 2026 09:53:49 +0100
From: Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>
To: Vinod Koul <vkoul@kernel.org>
Cc: Frank Li <Frank.li@oss.nxp.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
        linux-sound@vger.kernel.org, linux-spi@vger.kernel.org,
        Frank Li <Frank.Li@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
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
Message-ID: <arDtEB0na9DxDWAS@nsa>
References: <20260911-dmaengine-support-wider-dma-masks-v4-0-72b8fd4cc78e@analog.com>
 <20260911-dmaengine-support-wider-dma-masks-v4-1-72b8fd4cc78e@analog.com>
 <aqgCQvRw9fns__0d@SMW015318>
 <aqjzvxI4ecoFvRLT@ashevche-desk.local>
 <aqlpoBJJXfZgsMxT@parshuram>
 <aqlwRkNcs_UqKjWs@parshuram>
 <aql6u3T0nnSVr-FC@SMW015318>
 <aqws8pN2rfS9-dCC@parshuram>
 <aqz1-OzFobOROuBw@nsa>
 <aq18_TMNs4EJzgZO@parshuram>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aq18_TMNs4EJzgZO@parshuram>
X-ClientProxiedBy: MA2P292CA0016.ESPP292.PROD.OUTLOOK.COM (2603:10a6:250::14)
 To SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|DSVPR03MB989591:EE_
X-MS-Office365-Filtering-Correlation-Id: 2085a7b8-9053-4183-87aa-08df17bdb174
X-LD-Processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|23010399003|366016|10067099003|56012099006|11063799006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
 NwsDiOr4Klu18LaBGxl0bg5Ub0wvYDb7ilc2qQGD7pNlQQYaI5Z3KxwIRybZshm+m3GImlgMqRe14w1MCf0a+I9OJ4pmrvb9++4xUFVRb1o5U+N69FY2qoF3El9X+S8uOHyfIhDgBlWuBcwJ3HxLZMOFfzSjOT6jkx/Q1/2uEoHU5qEnU9hbXjPCv+UZuf69fTTTG/HhZvwiPyyhygDkPTW64fVyYFYTxjrdPnOYPIeJdbW9M/0HuMWZNfPpefQ92frqN0t3akM92kxuysLodVgoZmg02prm7kwCEeE35/zQgnTvVXU7uRhDLv8o9PNzsihR2kAsfN/CyxoNIOG22ZQcRlhEXPZ9nDgYSGTjthaq+OsIaWJeR0ZV3GGhDv/bgY2AKs/LJOX0kbwCHH9LP16pKuJFruZWMBOG8XmwP1dbom7t6CMoaVy0IVKHLYeDeK1j28KJ/pZfbcPraaOBSPSMpcq1v3lcOazyUlWmp2o2oP8JXEg4P5fhZ/m5OX7EWk+fWHbMd4uLcemzK8lJYj8BsmAqDarcyGtFpJsWQdm0o+l6KAC8dIp1GSTOX70FJXTFe5yWwWL3EaKhULtGLcwR0ggmH+0tyOQeusuHSFgwC299uFFZsC+ZxCQhbLMk2xwdc9wvzuxpARF7saEAyaLMgNdSx2q3sv5PRKwGuMw=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(23010399003)(366016)(10067099003)(56012099006)(11063799006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?dWVoQ3pPOUhGdHUvcXFFWVZTenVlKzNBV2ZTNHRmeUdPNnBUVmp6clJ0aVFz?=
 =?utf-8?B?NVlsUkJMRjFPSS9JN0JKTU4xQmVLdzdRNkNtZFhIS2F4TjZDeFFrNUpHMXlU?=
 =?utf-8?B?aTJsdUg3aGVkcTJCMzBjeWZiSk1xSDlySjFCMlNNRkIvK0VNZlU5VzhrZWJy?=
 =?utf-8?B?YmRCSDBJQ1I0VEEvMUZOejBKY1prRDNLU0JuVFFoVDl6R0dVWWtEZmJFM3pE?=
 =?utf-8?B?TTlmU3BSWlJObGZKY1NuVEY5MS9DdzBqTDFiV2JFWjdZMzMzbHNiUGl5V3d0?=
 =?utf-8?B?dmZPdWs3azBLVmUwYnFmdnl1R0o2Qjh1VERBOWdyOW5qNTdibkZjUnF6ck5X?=
 =?utf-8?B?dVduaUhsRHkrTlIybXV5N1VSTTM0MUNYTTNIWUhBa3ZwV2dvTVZFNzBMOVcz?=
 =?utf-8?B?VS9lZHVPc1hoRWNTSHpZM1Bwa1JzTTFCMCtWNmVLaXdlL1l1bWxnajh5dmhl?=
 =?utf-8?B?T1Nqd0hDVUZQMGU4UTNIOGNxYW5yZDl3RCtRNUd3Qit2U20zSHppTnVKbDVQ?=
 =?utf-8?B?cjY3UkVXeEFxcEFmWk5WKzdoa2poc1R1N3VGRFNOVHhWR1ZjNTkyMURCMXFm?=
 =?utf-8?B?cWlJcm9nZWx0VHFlYk9tbzVjY3VNdjdLaUxiSUorYUNFZUMrNXRYTDFETE5V?=
 =?utf-8?B?a1gvSmJyVFhJSUJFeTdMcFd5Rzg1MnpwNDFJaUQrSjhhd3lVRXlTTTA2T2xs?=
 =?utf-8?B?TkIzanM1QmtwUkJXaEo3U2ZiN3o0UVZTMWxxMTJrcDdyN3YzeEM0OEhGVTNx?=
 =?utf-8?B?UVNoU1VJWHFONExseEVmOUNrSzRZQlFSV3RhR3ovUkVLRnhsOXE2alVYU2dK?=
 =?utf-8?B?MzUrNlplVTVGOU16MGRnVEtuVDlQOEF6Tmo0bUpMWm83OE5qREthSzkyNm5R?=
 =?utf-8?B?RXJMWmpuSU5vTkVFRUlRYmJvdlpDU2E4YVc2M2VQMEdLT3VyS0wzRFRIQVlR?=
 =?utf-8?B?MWFkaWpVU3RSMnNIZHhOT1g4a0tqbnloQTVzZXZNdFh5SlpIZkN0ZFQzSEx5?=
 =?utf-8?B?elZVTndla2w5SWo4YmFhMnhBQ0JQMkNSTWw4Tm5rYnp2b0plSlUraXdyN0dJ?=
 =?utf-8?B?YmJSWmhqN2JkZjN5YTBMMFdPWG5MWWU5cjJhZkZYRGUxckVBNTZCWHZuRUtU?=
 =?utf-8?B?a1AyNi9zcml3eFNZRzRoMldqMWp6VExYdnRSZTVEd1hFRTQxbzRlK2ZNUlRS?=
 =?utf-8?B?WmtnVWVISDI4VzlhZnQrTjNhWDhsUWlpUDRCWkhXa0hScGFhUW51K1dtNUNG?=
 =?utf-8?B?Tmd3WVFaeXFZZWZyaUxmYk9ZWmEwbTFYS1ZjRVMydE1vb3ZLTkVHNkpZNmVQ?=
 =?utf-8?B?SStycTdrSUR5QU5SL2k4dTJTWjdmdnZPOWZZcEZScHlSNU8zaUVHdUFmbDR2?=
 =?utf-8?B?NzNpbWt3dW1Dd0ZtYndtSmN4Rm5LVjNzNTZFN28wcVZSS1FsRmQxTVdaOWFZ?=
 =?utf-8?B?MFhOZTI1RldYVy9GMU0yZnFaeW1vSDdXQkdLQVNXSVExeDdMWFkxazN1clVK?=
 =?utf-8?B?dkZWRENTVnMrWmI2YS9KZ1RIbDlXTm5RK2FjbHl3bm9GckpTaE9MNmhyeUg3?=
 =?utf-8?B?Yng4WGd5a2JyVzF6aEZQblYzRGgvMTJHVENNS05WVTBhdnlVcUNDVUJxT0xO?=
 =?utf-8?B?N1JFdWtSdnZ0S0JJNWV0Qi9hbitJMXpuSUkxclNBN3VGazNvd0k3d3VSb0VS?=
 =?utf-8?B?TlplOTFvTTU5d3g0bDZ4M1A2L3A1SnVjKzR3STdPNzVwZ2EzU0hLVjcrOUlj?=
 =?utf-8?B?UmsvbFR0Y29mRFJvc1BUeGQrNHhYRlI4YkxTS1htalNzcFAyVFpyWkU3bXFl?=
 =?utf-8?B?RHNjMnlNdm9pQ1pIM0lQdWxjTTBKUGovM1FwZktFVkNyWjA3OUxXckNYN203?=
 =?utf-8?B?L2dGUy9WYTd1c00rbkhJbUd0K2RxRGthQ2JKZ3FoOTg0WnRSOUkwd0R1SjV4?=
 =?utf-8?B?NCtuWCs5VytONFQ3RjVRaXZ2ZTNzM29rRWdMVFNkSm9ZN3Qzb2M0djI5ek1Z?=
 =?utf-8?B?N0tORnBvOWI4cmNHTTR1dHJ4VmhFOGZkbVpKbzhVYVJkZFRUL3kvWHZCcTgv?=
 =?utf-8?B?TUczRURkaHRzMWZud2Rjc1ViQWQxcElyWGdxZjZ5TmRwV3FJVlViNGhEV0pW?=
 =?utf-8?B?MnFjQXU1dnVoaGc0dG1sckxCVVhscGpWTC9PL1cvNy9sNnZka3dZdjZiNzhG?=
 =?utf-8?B?NGpBQkczN0xtY2Y1YWlNbVFNc2lRM09NR1ZTalM1VFVNdnI5RVN4YklzOGYy?=
 =?utf-8?B?Q1RnN3VUQysrM2JUa1BNc0RrVkZxMUpEWmtWUldwVzJuRzhRYWdmRmE3ektG?=
 =?utf-8?B?ckJWWVpEYVIyMkpRdW8xb3JEYTR2c0drUFhkc1hRRXdJWisvOXZTUT09?=
X-Exchange-RoutingPolicyChecked:
	ywj4gMA3Mq3DMlHNi7htjw1H2jp/T5jBDMyMoOPaKN3Cl2TpAJykG+Kmf3zzVIZ9Ew3f4f1WVJABttp/CnJBdwsuAAmKyneybKAjGiNRe22NVBZsIyRnrvN6SwRPcv77ZaeoKh/kxgB+hjEquVTR9heDmpFsdf17lBx8/TVJQAcdtIBeMuXL01M0EDxK/+VpGuv1+/nEqm1y7xz6UmnO2Rn1E/xNB8TSmSCUlzTHa6aAofb7gIrnqZW2bc3ZW3a8q24B6cUcjWKHGg1qGeITWDX7Ie49ziefhx1KMojlPia+kwIk5V06Lghm+7n+uyd2LPMKYDpDlddwAmig2L5P6w==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2085a7b8-9053-4183-87aa-08df17bdb174
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 08:52:40.4723
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pTLgsa1b5PJcta6Z/l6kiQLZZ/DpfPpmffXhIw/29eqp1lwiwR0KiDwzypogmOSdlddoZbS7qgU0GDsAgOfcsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR03MB989591
X-Authority-Analysis: v=2.4 cv=fcc4WEQF c=1 sm=1 tr=0 ts=6ab0f05b cx=c_pps
 a=skQXzUdJ1yZbsxdDph07EQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=iZSIUCweCk2Oy3QsdGPA:22
 a=5Sj_8R_vnXts98Rv-ZUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDEyNyBTYWx0ZWRfXz63+GdMSlspj
 xI8b2ukpEq5T74/Rj1BI0JSUyM0EZzQMdWDYX6fAVV2Rmu83hlYVHKt9o/VzTVfylQKC7vCgnbh
 27h5ghxhLPVCyMph6cgL/8PB0JNF4MmWcXBdXOp09jFYRXhJeGiV
X-Proofpoint-ORIG-GUID: LAdp7LD3sAlCuVL2JTOZ49O8T58NxAPI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDEyNyBTYWx0ZWRfX2D2dXQC1UT8P
 bkWRaTZfZwu7Ps/rczb0jBDNFNK6BpR8VaAw07HQDTEUYCuj97bI79inXEzwqp+axZBSNaEfwa3
 hWVn3zI4pW5/hyXs1OaDK3B1ElmHE/RPnIdLAHQRzIWSKvBwuOiBCPF/pAcrtZnIUCxlp+rHyuW
 EhV28JB7/i1MmPJ9/+KB9oMwcEksrFAibCgBq0nqQqcKA6gS850WSNpou2aSuc7DvwP+3DQbZs3
 sLMCaysYdcAcNFvM3gwc5b3u2ddEgdP2ketEwvVEY/uOFOe+AXaTUH/a4hPUT+9lbyZkryoFWjO
 Oe5/lTkPUM37pZab8MKWRq6jkSCUpQDEJJ3gIAhIZAVAJy0HfzsG4k2BMV5hY4IkOED3uKq6HhU
 nS63nVG8igAsvbBt3poheG8o2w1C4pL94vTdGEtmF44P9ji8SzmPQj8GaC0dEM7rbtQVWqvcBOF
 SLWJ7taDHoFND4fqmzQ==
X-Proofpoint-GUID: LAdp7LD3sAlCuVL2JTOZ49O8T58NxAPI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 priorityscore=1501 malwarescore=0 bulkscore=0
 impostorscore=0 clxscore=1015 spamscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609210127

On Fri, Sep 18, 2026 at 11:33:41PM +0530, Vinod Koul wrote:
> On 18-09-26, 09:39, Nuno Sá wrote:
> > On Thu, Sep 17, 2026 at 11:39:54PM +0530, Vinod Koul wrote:
> > > On 15-09-26, 12:04, Frank Li wrote:
> > > > On Tue, Sep 15, 2026 at 09:50:22PM +0530, Vinod Koul wrote:
> > > > > On 15-09-26, 21:22, Vinod Koul wrote:
> > > 
> > > > > > > Traditional naming would be
> > > > > > > dma/engine/provider.h
> > > > > > > dma/engine/consumer.h
> > > > > >
> > > > > > consumer and provider and good names.. I would retain the full dmaengine
> > > > > > everywhere please. dma causes confusion already!
> > > > >
> > > > > Thinking about it again, drivers/dma/dmaengine.h should be the provider
> > > > 
> > > > There some dmaengine code outside drivers/dma directory, like
> > > > drivers/crypto/ccp/ccp-dmaengine.c
> > > 
> > > They chose to be outside, their choice... They need to be updated as
> > > well to point to ../../dma/dmaengine.h :-)
> > 
> > I tend to agree with Andy but anyways. I feel this is going a bit out of
> > scope now. So what we have now in the series is:
> > 
> > 
> > - include/linux/dmaengine.h (without enum dma_slave_buswidth)
> > - include/linux/dma/types.h (with enum dma_slave_buswidth and new
> >   dma_buswidth_t type) - A future one would be dma_cap_mask_t and we could
> >   drop bitmap.h from dmaengine.h
> > - include/linux/dma/widthmask.h - The new bitmap based API for bus_width
> > 
> > I kind like the separation (and the whole point was to avoid bitmap.h in
> > the main dmaengine.h API) but tbh I'm not sure if a consumer driver
> > will ever use dma/widthmask.h without needing the consumer API. But
> > to sum things up, what do you suggest for vÛE?
> > 
> > * include/linux/dmaengine.h as the consumer API and includes the new
> > the widthmask API
> > * provider/private goes to drivers/dma/dmaengine.h and just includes
> > include/linux/dmaengine.h as the starting point?
> > 
> > Let me know how do you want things for v5
> 
> Yes lets talk about dma_slave_buswidth, it is client type. This is
> configured by users to set the width of peripheral.
> So this needs to be in the include/linux/dmaengine.h
> 

Agreed! But providers also need to set the allowed bus mask. And I'm
just not sure they need to include/consume all of the consumer API.
Also, it's common to allow the provider API to be widely used throughout
the kernel (but I agree that could be even harder to get done - if we
want to make some stuff really private - but I guess that could be done
in a second step or more incrementally). We do also have some subfolders
in `drivers/dma` which means we'll need the odd "../dmaengine.h" relative
include which I do not love tbh (on top of the crypto stuff).

I really think something like the below would be more appropriate (if we
just want the provider/consumer API without further splitting like the
types.h and widthmak.h in this version):

include/linux/dmaengine.h - provider API (as of today)
include/linux/dmaengine-consumer.h

But anyways, if you or Frank do not object in the next few days, I'll
take the above approach suggested by Vinod:

drivers/dma/dmaengine.h - provider
include/linux/dmaengine.h - consumer

- Nuno Sá

> -- 
> ~Vinod
