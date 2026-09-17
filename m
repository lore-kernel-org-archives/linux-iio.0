Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0994F49504B;
	Thu, 17 Sep 2026 08:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789634747; cv=fail; b=k/JpvjE5iP00MT+ea/Txgp0lrmvp6it3VIjoB9Uyj7kx2sv1dJ4PuhAwB+qiatncsT9NLudr8fgTNoTEffsV8A2VGo5fxxkTqeOJliXNU7wQq/+9VnLzfq4/DuZdMZOELYTCCzzCN5py3ZR1TgM4NJc246pzabJh2k5d9WDjeJ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789634747; c=relaxed/simple;
	bh=u8VPJMFn3oDwJjdhd/FcxY6JPIY/15Fmyi8TMhwEmlo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dyf5JVE3PLQbVvAlN0odiCrfKk4UEN3JHjXN8HJTd/ADAWbpZDxA+OQ50U0D/5836qJSXSPwg6vqUbzp3jMpy4AuxbF5WMXscooK9Or0Ku8sMTVmPx2yq6zPjfxDrz7tj0b5A5g5Q/bM5KeHHm3xkUD1+0VCUgTMHzBBgsm5aMY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=Paa716ju; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="Paa716ju"
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68H7PGji2130737;
	Thu, 17 Sep 2026 04:45:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=Y/kdi
	0ycuBhcL5R1wHXRyazNIn7SDWw81kkagmEowVI=; b=Paa716ju4Am95Xi2iP1Zo
	KfkRbm/MIDBnBqA5un3gPyhIskfXUsc5XEDhqVAAvN529SFzy4DuXBnzajgHCCsL
	FcdDyIHbT3QrS0Hg9ML5+ne9GJMiRz3wl0CBjlmIUKtoD4ttZTf1iisT5VGvu5lT
	UNM53IdaxyX8HVLJkxHKNFMFkeYAbZZ/jFgyytNZkb8/Df1eHjUBwf7gOumnVvMl
	Y38mo4Bg8VIqNz8PYLogU5kZN6KN67UffkIXcFmyLpVcXVn5JsChbsTtsNioK956
	guiHrEB955W5K+VgCWU0c8oddf3CTR+4VvyQSkRcgDOTwYSGeAt2TcKaw/iT/DDj
	g==
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010007.outbound.protection.outlook.com [40.93.198.7])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4gq57ek5f0-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 17 Sep 2026 04:45:13 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jo/bw9p4VFo0+K4QvYlq4QmdwenEM4aamC5w+6mjhybLdvQNnkHwBkUSGVpRGQuJuhAYX4mSOSFZwzbOW+6V6JZYsvSp17bUB49KOFoxo6dMGjbR4xq9NJyexEwVcbJS3XHKf740dKGeZBBrJftNpanK7EMrmp+40gy9QfJ7lY/LEJTg48MwqSRvwSlNwf8H0SMUnyjjoGts0MEP5Qj7v1LTFvWU0S47xtwGjihp8I/Vk/6+KQueHr3zOWi1JlSPWqNrFuFGEIunA7FhcwS3YyflEa8DJbWNMjY2WevCl+F+JMrsmS5Z+J2SR1LQry+CStAZixBGRLsEjwDfMABSyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y/kdi0ycuBhcL5R1wHXRyazNIn7SDWw81kkagmEowVI=;
 b=DH4/elHUnDWbcS7zxf5K72a9NusLcnyPXLEaNxRqQk+ceuAqdeM94dwyDl3JW1RtxhM4jwZlnXbf5PVN7lkz0HnhhOPB6I61KHzBtTa/2OjI/+OXCImj8QXzRJ7hXkehqVFRxwBn/1Hx0DMMlhES5eAS7bfAc877H4nlVuQ3W5MN3r9pYojP7SQNEOAfZPnarUBADoA6IQUTFEqOViDn2YDm+2KF4JVe7HwnwQr7cHapt743oUrslYJsZ9yrU4LIoFDI1/LuKOg7WgqZasJynJM7y1o84OvWfMQ/bMlElFEvgShm55tbmU3YLZ3B5HkcfMg0lYeZYc1EK88mEobazA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by SA0PR03MB5451.namprd03.prod.outlook.com (2603:10b6:806:b0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Thu, 17 Sep
 2026 08:45:09 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%6]) with mapi id 15.21.0406.007; Thu, 17 Sep 2026
 08:45:09 +0000
Date: Thu, 17 Sep 2026 09:46:17 +0100
From: Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, Olivier Moysan <olivier.moysan@foss.st.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>, linux-doc@vger.kernel.org
Subject: Re: [PATCH v2] docs: iio: backend: use literal block for commands
Message-ID: <aquoqnyKi8BAVyZX@nsa>
References: <20260916180739.2296401-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260916180739.2296401-1-rdunlap@infradead.org>
X-ClientProxiedBy: MA2P292CA0011.ESPP292.PROD.OUTLOOK.COM
 (2603:10a6:250:1::15) To SJ0PR03MB5469.namprd03.prod.outlook.com
 (2603:10b6:a03:28a::17)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|SA0PR03MB5451:EE_
X-MS-Office365-Filtering-Correlation-Id: 33081087-71c4-45e6-56e3-08df1497faff
X-LD-Processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|23010399003|366016|376014|7416014|5023799004|11063799006|56012099006|3023799007|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
 BVUQ3HvoMgcZVGZjJbIsYr5gETAcQzpwM/WOJSQa1vVf6uXqrHXYS8lqznh+CMl0US1yuxRWSkJVRMI5z8ecOKiNS9aMoR8L3le+7d55c6EUPlI9SFicmdqG3bAyrUvfzI1XceafhIhmFZClWqgLNqPL9LQcN5iEcQFuN1UanFXKu256WESXu+QTppV8uzQVLLiVfHtTF4DJqAoTccbBH+6JNTqqGkU1NMhdhgq5rays7J51To834DxbELf/L26nqKdgPgiYikKVB6BLiVJEN1JvBpD7+vqEfZYIbbGaOOMWbVFf2Brnlb08VH2yyB4+Cs6sNClxEMGOsPaUQ8ULEpily1TKF7rrpNGT+u4Ghy5UEfKi0QmT2e6kfr3Pd7ewacC/pjgm1ImDnowLrrbA0FMa+F1jJLfPvLGph98QuN9z7F2blf34wqTgymP3MI/ldbVoVOGVj0Y8zmcS+kuzzPmxYu4LEP5dHnzIkKzQKbD6JSL57XT/pf6IRZk6IlJYJfQ9e2/8WWECsqFdKnJAqbV8NjY0oEgHDOIpDHp6FMu8vibokAyCrtjT3B66OS9V758a1IiJNRmh6nLavmJXiYChwH9jfHsJooxtzmHhAuAunKmukfKKyBRE7vn+U2HO
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(7416014)(5023799004)(11063799006)(56012099006)(3023799007)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?aDlCTGF5UVExTzdKcHllZGdLV25oRjVCVHVtY1FraGt5RWM1NTNINHNkS0ZY?=
 =?utf-8?B?VkRWY3JKck53UzdCcEUwUEdwWEhiZzJtL3hQKzdmZDJuS3lBb2ljNTlGRHo3?=
 =?utf-8?B?WVpkelZ6ZVJhWFU1SCtHRjVZbVJFUVVwUVQvcGs1VWhHZ1dSTjA5TE1WYU1p?=
 =?utf-8?B?aDEzSXlLRlFaeG1STE4rNHNIYktUN20vdm0vYjJDdWNlTWZzam9JWkdzN3Ix?=
 =?utf-8?B?WVlYbkxDeWE1T1lPcU40a1JMNkllR1BTdmxpYmFpN211ZzVZWUE3OHFBdHla?=
 =?utf-8?B?aDJibEw4aFR6NkgyOExWUFppZldVZzdRbWtqMkp1ZmE3R05HQ21HeTJSMDQw?=
 =?utf-8?B?bEp4RE1VajI2V21nTlByNVdmbURkMlRsQm9kSkNOS1AwcXFIcGpkeGgzcjk2?=
 =?utf-8?B?dXFvRmtBMFdGY09vQ0FneHhNck1KdTJuS2R4cjlBcC9EOHk2eGp3RHdXY1VK?=
 =?utf-8?B?djBSVDdNblN6MkRTSEI0WDUzVW1qZXlndE5jUkhiaXhMYTAzbnRDWk9RNnpr?=
 =?utf-8?B?VGl6YzAzVnZVSUE4c0czbldpVDJ2d3poeHVENTgvWHdTQ3ZVSmI5Ynd0OXc0?=
 =?utf-8?B?Y2RzSjFXbkZJaDJiRTRGcmJMNmlFMkIxV2hrWE5oL0gvZjJ6OXZBaWYwa3M4?=
 =?utf-8?B?cXdGSzBIZ3ExLzhvY0d6L2JpZ0p0NUMzLzR4bXd0NVU0SWFnN0VuVGVPbXRm?=
 =?utf-8?B?K29kZFl6Wmt6cTdQenNjV1loc2lhWC9qMXpCd0ZpbnBjdFNKM21LdFdkdDA3?=
 =?utf-8?B?Wkw0UmxzRDBUY1ZjL0ViUDZNV2FiVlZhTS9VR3Ayb3BWbktZMEJnTmN2REFT?=
 =?utf-8?B?YVEvNms0Yk1rVWhuN2FqUlpNS2dKR0l3bWRQVTgyVVNrVEFwR2czRElQMDlO?=
 =?utf-8?B?L1VRNGk4N09SbHc4ZXhUV2tlek80aU9uWG5wN2oxMGc4akN5WW9laTZES0lD?=
 =?utf-8?B?cHV3OVA2ampLeDNxaWZ4RlNGSFNOUWQrbkd4QWtqMXV4OENWaGFvSWFxWTFy?=
 =?utf-8?B?clp5VkJKVXdxQXlGbEN4U2ZQY3lMOUNCMm9jWDllemhONWh3bnNVNGhKQ0RQ?=
 =?utf-8?B?cjA1NmhTQlVBTXNYeHplelZldVJtM1djbkhVNGtsUHFPeHBnalJuWXFMeWY2?=
 =?utf-8?B?VmNqa0RCeUZSdEhENWdhUDlWaTl3cXFqdXVsNHp3RmFBTjFZVFMxRFBpeHVG?=
 =?utf-8?B?ZUZDTTdCZE1xcHlWWHJjSFdPZk1vYm01UXpzVGhjUVpWR1hjTWpjaC9uTlNZ?=
 =?utf-8?B?dUtmNllLc0JVUFhGRVpxSkw1Z3RQUHk4SzZDZElPUnpQSzVQak0yTVRpbHJY?=
 =?utf-8?B?a1VGWHdEaFUwenJUNlFQdmkwTmdabUd3MjlJMzlsYUZVQzd1TWFsNXU0N1FS?=
 =?utf-8?B?cHdFRUhXTWhkY2xQaFhzbjBDVStlQnpSM0VYZVgyU0N2L3BaTzhiR0xxdjBM?=
 =?utf-8?B?cE55S0ZQNG9ONklVWkRFUjhLUVVlVGNjSXArR2orSGl1UjNJbGFnajJ1a0xJ?=
 =?utf-8?B?Vk5UaDU1bGMwOThjT0N0R3NsM0hOV25pZ3VvcXFkMmZuVmVkSHkxNlZIMnhI?=
 =?utf-8?B?WkNmM1NIbHI0N0dvZURiUjhYcGFpbi9KN1BpdzJ5Yk1VTWMzRVJudlVoM1h0?=
 =?utf-8?B?R2UzS3hsa0JtQnl1b2IrVTJYWlg0RHRFNUJoUjZ4b05GL2ZsSUxNOVJ1WEdQ?=
 =?utf-8?B?cnJQcmxyV1lYTDgzbUlpS25ZNkhSdUhEZm9LTndJTXNHcXBDV29IK1JMS3dk?=
 =?utf-8?B?SnllWktITWhPY09nMkpyOWo0SGc5MGV5UTdEOUxyZE1Pb2tXVEFva2tXblI4?=
 =?utf-8?B?c1lRMGJJeVBlTnFDRXVKRjl0UnVCN0Z0NUpKVWpKQjBhOTU3UGtjUmFrb3dD?=
 =?utf-8?B?clJDSEJEODd0ZWc0dWp3d01sTlhBL3dNZ1I5cE5ka01CUlJWdWpKQUhOcHBx?=
 =?utf-8?B?YjZEaDR5NXJBWGdpeU5tcGk4QUdaLzJVa3NrTDN5anpWT3B0MU1rZjVyRXBs?=
 =?utf-8?B?Z3h2NGRDR1JLaXphZnpQWjdJbU1XTEVXeGlraGZuWHUrUTkzczA2U0l0RzNS?=
 =?utf-8?B?K05PWmpOTmFCLzBZb3BsTkwxSXVvbWs1NEhhR244NHByUkdMU0MycVZhN09B?=
 =?utf-8?B?TVdUWm5DZU92NHpZLzdLTTNxak1CNk5ianV2MTNVTlFZME5id04ranAybGxk?=
 =?utf-8?B?eGJ4UFcxbWVHaGF3dDN3M1FibzE4cjFYckhVaDJhZWc0TE0vakNFWk5HMnly?=
 =?utf-8?B?Z0lIcE5jbkNJZmN0SlRtK0M3SXZaWjNXcWVWZnhGTVY0N2tSb0NyV3ZIR2dt?=
 =?utf-8?B?VXB2STZWa2NuNks5ZHRhVFVqUjUxd1ovamROaW1RQXU3UHk5L1dYUT09?=
X-Exchange-RoutingPolicyChecked:
	M+LKaY4UrKYLuTLNHgiWvTThpfbITzAHUHTTqbzu5B/GRgoJBe1AVtb9iY22xqxX9ISnqt4Gtem0f5ra5MRKD2glWd+DzVBB5qIlT4bcxCjm/loQUHqp7ze/3jzk7SQ5Ck8hqAMvFY7vf4nBIjeRdG8Qp/hEcyFlGHcdD3JYfS63oFe7+iye+U8jfB657YCmstUXKmOLvs83tymlQFCHPZsZHzQTkpqGbrHZAisI2LxZYAIbIEbyA0hOjHiVBGhIGpLgs8xPFpjytyADSDv73ydcLFPqM4GLG3qviGnrK1mQ3f7hcdEZ2AuxgqTdIR/4LBJNZP/GrfV+XvLLF464nQ==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33081087-71c4-45e6-56e3-08df1497faff
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 08:45:09.5569
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PV7ch4PdKZXWb85lNtGT7LuWv/kUlgjl6tW29wp6CFrWtcRkfYf3htDcimZ/oYCFAMEmquIzXvu3ul05ksf2HA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR03MB5451
X-Proofpoint-GUID: JEYk6E-B3j2thsZN7100KcK1rAPnkY78
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDExOCBTYWx0ZWRfX5b5nl5Lgpr4l
 40zg3xefro3pj6KtVyMA8vU+CSwixeRoHQdBok15cjNfB7x923QSzumTf/JGdYFwkN6NU1Co1af
 aiDpKEM6iD8K+KJn4gbZ1NhVWs0dVDy5oo4Ent9gupZihH3N6SoHr+0Sc9KIOB49XG2nPb4z8qT
 SMAEqoPEwed4ojT9ZU+LlRr76kX9HTBoMqgXdXau37mgK7hmDd7eQDUTkuh79rwXyaAzlbFaSpx
 mWGdgJcmN1MTYtsyVbCbhYRSUlT/+V2xww69PLvDE1bf702KrjygfnpboGHWZ6Vx/UXE8AC/e3P
 wASExEmUvegBos98QTAxj1biVAkHm/IC8IhOq+ZW9+q8UYf7Ht//wnHSpUNTu/arY4En/6tttY+
 MBvy8Tp37FxbITHRz1fvqnT/j12MS34FVU68H3P/1nzqNGqoX6rMBT/jFrsDS5hvVVbTst/GEkr
 Bej1UQbxVcfIpNiqeCw==
X-Authority-Analysis: v=2.4 cv=V9HoQuni c=1 sm=1 tr=0 ts=6aaba899 cx=c_pps
 a=r+591f3cnXeovruRxJw0Jg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=uXIjobp8t2wMuQ0fPvqm:22
 a=JfrnYn6hAAAA:8 a=gAnH3GRIAAAA:8 a=8b9GpE9nAAAA:8 a=VwQbUJbxAAAA:8
 a=IpJZQVW2AAAA:8 a=07d9gI8wAAAA:8 a=ag1SF4gXAAAA:8 a=9bDXC2dJq8cOI24_CSsA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=1CNFftbPRP8L7MoqJWF3:22
 a=T3LWEMljR5ZiDmsYVIUa:22 a=IawgGOuG5U0WyFbmm1f5:22 a=e2CUPOnPG4QKp8I52DXD:22
 a=Yupwre4RP9_Eg_Bd0iYG:22
X-Proofpoint-ORIG-GUID: JEYk6E-B3j2thsZN7100KcK1rAPnkY78
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDExOCBTYWx0ZWRfX8s2lcS80/Z2m
 LabRFA416wQDMgOl9idvCs7ULayP0UtR6cmU72M4Cxpk1bHlzcYoScSERmZEmCfDQOnb4S9aM5g
 tyDpuTPP1RtTMFUY3dG+41QewdsuxDUjKMPfPrWc9Eruzm5Nwhat
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-17_01,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1011 adultscore=0 priorityscore=1501 suspectscore=0
 malwarescore=0 phishscore=0 impostorscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609170118

On Wed, Sep 16, 2026 at 11:07:39AM -0700, Randy Dunlap wrote:
> Use literal blocks for 'cat' and 'echo' commands to separate them from
> the surrounding text. Otherwise the lines run together, without any
> clear break before or after the commands.
> 
> Use shell comment style to go along with the shell commands.
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> ---

Reviewed-by: Nuno Sá <nuno.sa@analog.com>

> v2: use shell comment style (Andy)
> 
> Cc: Nuno Sa <nuno.sa@analog.com>
> Cc: Olivier Moysan <olivier.moysan@foss.st.com>
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: David Lechner <dlechner@baylibre.com>
> Cc: Andy Shevchenko <andy@kernel.org>
> Cc: linux-iio@vger.kernel.org
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Shuah Khan <skhan@linuxfoundation.org>
> Cc: linux-doc@vger.kernel.org
> 
>  Documentation/ABI/testing/debugfs-iio-backend |   16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> --- linux-next-20260914.orig/Documentation/ABI/testing/debugfs-iio-backend
> +++ linux-next-20260914/Documentation/ABI/testing/debugfs-iio-backend
> @@ -8,13 +8,13 @@ What:		/sys/kernel/debug/iio/iio:deviceX
>  KernelVersion:	6.11
>  Contact:	linux-iio@vger.kernel.org
>  Description:
> -		Directly access the registers of backend Y. Typical usage is:
> +		Directly access the registers of backend Y. Typical usage is::
>  
> -		Reading address 0x50
> -		echo 0x50 > direct_reg_access
> -		cat direct_reg_access
> +		  # Reading address 0x50
> +		  echo 0x50 > direct_reg_access
> +		  cat direct_reg_access
>  
> -		Writing address 0x50
> -		echo 0x50 0x3 > direct_reg_access
> -		//readback address 0x50
> -		cat direct_reg_access
> +		  # Writing address 0x50
> +		  echo 0x50 0x3 > direct_reg_access
> +		  # readback address 0x50
> +		  cat direct_reg_access
