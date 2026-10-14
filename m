Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C79F560ADF;
	Wed, 14 Oct 2026 16:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791996872; cv=fail; b=kzWQqH5/q+K+BUQVa+jZyv0ATZwOBz8/Qbw8BYNhVE4ZNAyfSN+VnuN3Mc4p0qPL7Uz7lHpj5VGVQ4pDOn6vTloAlwQE588WsREomQiGOFENj9bjgMCwoGCVq2p9kFDv467uPE1A+xSoUJ+XfR2iCyr7mKE+n4RT7dterdhOXXI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791996872; c=relaxed/simple;
	bh=Ho/DuxfQsLKDYi/funlMcgauQEcTpgOa0/0ke7FB9Ag=;
	h=Content-Type:Subject:From:To:Cc:In-Reply-To:References:Date:
	 Message-Id:MIME-Version; b=iir5oDplsLw+O/TU8HSuAvERBuTD3xrYAqMYfthee8RxPO48nnhww2AwvWsjwnG4N9oZjoGOQZRIqQBdJJQh09LSOUYC325PxAc4Tho7p0w58zvTbCSVxljel+TQ6KGx2Km+D+USZDK9xoyrCJ6ronb5TKHBg1IqDgxF72CkPxk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b=Yno3rC+a; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=SvOoklyD; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b="Yno3rC+a";
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="SvOoklyD"
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69EEbCTL4092341;
	Wed, 14 Oct 2026 12:54:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=sEZrOuUyiw8eO0GTD3EgqBNSBOaO4SM7aAsOFP6kZDk=; b=Yno3rC+
	a7acs5ZetbW6YVMJ0cET01HWxXacSIR3yylKAG+3e9WYpWVHSCrswzAjvubUdSZq
	6B8jswc4TQwSyC7DB7rIFmn5uIs9lxml3k4j4fHVXNCunOR5b6tcDzThZOohl9hq
	6VON42MLZf2pU8cFHViBiDlHfJ613+K+QJJhcsQWCH/PcbR018Lyw+u07G//y1E/
	NHfB/ksNUCRToeB+OxpEKDmpYJJFLVY4InIAnwiWPPlDV0Jl6c89PJ726O0Ez6Mz
	rSKC4gdOzGX4Ot/b+7Kb7Px7hUHxG4HSADJfEwybmn4YGwW9ifD80xUC3goX9PpT
	x9YY4q/IkBIgz9Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=sEZrO
	uUyiw8eO0GTD3EgqBNSBOaO4SM7aAsOFP6kZDk=; b=SvOoklyD3jXVYBXUDWdOA
	2z2FsCMhQssf7XdoWDKqqSuKIcovibf9LkQFutfBy6/69Ry7h+rChS689hrmNeMb
	R6T0K7o9mGHGivXTWY0oKih8TqzSEiLYNiSzWv9DXp3RxDgGF0Gb5/a3SgL9r6Qp
	0I3qulrqFBevjQwjtZpI8/Onwy9sB7kIA0ENMcXSVijAAYIOfpCISPQlnmrDsGnh
	xRwv0eHP4YeX2FWyfz6RG5s5C3tqDS8GIvWNHWdewzug5M6fgeDubTQ33rm3g4pZ
	5DocD92W0p6Rrdnidd+paCcnuZ7XbgON4EL5QGQT9H47JTb70AQMCz/XDuY6GnMG
	A==
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011015.outbound.protection.outlook.com [40.107.208.15])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4h9y26mtjx-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 14 Oct 2026 12:54:26 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NUcegVluJwFa5yM6X4c93Bf6ctZj4MKjBl/nolW3h+CHddW2tP1co0VbMxPuDLxl+BX2frDWEvzIkqZf2pEXgeGWJ+NcMzX8KF1S/naXseecFIvGsNh61Ct+Xx45LCDzKlAxVE878H9WIwkKZcOMDSGJx5XGFyCfhRTuwd2LEnr01j/lsMsjfjAw1PN5exPs5gsV3AUC1VkuXbwIpGS8ZOVKoTHjvVctcrN95p/vsADH2AMQxLz1oF5BpJ5SCH+xI5NpiUWMy8zXSfyj8x7sC6t1sLIdcjgzEk+Sej0na2Be5CwKMD8A8/5IZ7Uix/EEwcQT2jaGclinokhoITB9kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sEZrOuUyiw8eO0GTD3EgqBNSBOaO4SM7aAsOFP6kZDk=;
 b=kh16I/i0tW352d9GRXG/a7vWXdJU/FyUk0huZKlWcyztVKdZN8aU34BJf2OmQNTd0qqmtnz5huob9SFFkQkECoaJB+7KJsqs+1vE/mZSDTLHrLcUF3TloGdweRYBhUov3mYonSY+nMeRj5m8fu3C8cvGfqOV7GtlsC3rYzpc6VOaVTUPmZEhyhtNDpswzbFM7x/X7azQIcb1sTCU9Bqc0bmDxa1yhcsMNG4PYupKhXCtiq2Knq5tlKFA3o6ovXVLkqyJdnkPHHOQK/NhsfqefcO9s6FKeM/OrmK0KSiSkMAI4N9hhRDxwlUaPjih49mIUQEVfQ0f8v/mJD807BFZRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by SA3PR03MB8350.namprd03.prod.outlook.com (2603:10b6:806:45d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Wed, 14 Oct
 2026 16:54:23 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%6]) with mapi id 15.21.0496.021; Wed, 14 Oct 2026
 16:54:23 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 05/13] iio: adc: ad4134: Run shorter transfers when
 CRC is disabled
From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux@analog.com, jic23@kernel.org,
        nuno.sa@analog.com, dlechner@baylibre.com, andy@kernel.org,
        Michael.Hennerich@analog.com, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, corbet@lwn.net, skhan@linuxfoundation.org,
        marcelo.schmitt1@gmail.com
In-Reply-To: <e46fd2f9b11ff2b690483bc2ea6489b6d145c773.1791309733.git.marcelo.schmitt@analog.com>
References: <cover.1791309733.git.marcelo.schmitt@analog.com>
 <e46fd2f9b11ff2b690483bc2ea6489b6d145c773.1791309733.git.marcelo.schmitt@analog.com>
Date: Wed, 14 Oct 2026 17:55:28 +0100
Message-Id: <179199692819.658576.13815084929122370813.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791996931; l=1088;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=Ho/DuxfQsLKDYi/funlMcgauQEcTpgOa0/0ke7FB9Ag=;
 b=cV8D0FGh9WsrHGU5/A9e5lbemey48rKzefNXADTJuUMb+LNrF9hLKc+4P297us8yfcd/NRyWY
 DxJHDnD665bBH3F0Ghwf8qUeo2MxshXXKVIopWvWAVOnR/YjVb3mSsJ
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ClientProxiedBy: MA2P292CA0023.ESPP292.PROD.OUTLOOK.COM (2603:10a6:250::18)
 To SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|SA3PR03MB8350:EE_
X-MS-Office365-Filtering-Correlation-Id: 6bb80fb1-a8b2-4428-8490-08df2a13ccb7
X-LD-Processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|7416014|10067099003|18002099003|22082099003|11063799006|4143699003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
 5sMshoHMcGuvW+R/CSeD4LaKALMDIUmsDNAgOUPKnjHbW2vqV69AGrxbT5sQvfsStmC3HxetESyfFb5kUmosK236DUaEiRrGhOGCONJbxws/rn5JGm7MYOpXHFvpJfCkpjDUw8YYkjCWTR4iYAKzqvPy8fH3MOLql2FdHXcCER6BEJ0t1/SIx6/gXURnCODWZCh8BN8/U03NYvPNuK2RLSTblZ9fIbp7UD5F+dEZDgFWmnd5POGPaX6IUjeQzZO7wNwAyPp8x92wx04H5yz3wqDYCXLDlAbhPhThc/KLPcjx+5QYIyDgM1eQm/pheWLNOQo55gjpPEacu4IkJlfyFu3Z4YqChbFpS3oj/v3OUMcHhBAlELvBgdcbHr946tevsFFHMbslvZ2HjnNnxEbDYP6rDudGdVU7SxaAgW+eBr/9vPe/8S9LN9TnCysuspc2uYO3oar3d7jpY6nJUvvx/SX7gG9S/UHBr+tBI5YkFGuZuZ9LaYwFeFC+38IuRLNdwt64gAbnvwSGRglc3mX58ku7gpaK/+CP7z5gfW5CK6u8h8+4mIQOIhhVqZrjZ2dzn4T9eaOn5LIy/L9fabCkMZDaCGqHaczvq/wZYdEeojIAk5r9e3HRngNObJZZWBnX
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(7416014)(10067099003)(18002099003)(22082099003)(11063799006)(4143699003)(261009223027099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?QzQxUUVTd2FVMVVSNElBSXpGcXg4ZjZ6bW9hV0xyS1U3TWlrdW05ZEZ5UU9C?=
 =?utf-8?B?ZE1kYVIvTTVmSlZLTHBLZUpHc3QyYUZBOTVNMEJCbm5tNlJaTXRpZVBwRzVE?=
 =?utf-8?B?NnVLWmR5WW9YaVRsWjRHVnduMlcreTZ0bzRLZTBjVSs2eVAzUE9RU0RCT2JU?=
 =?utf-8?B?NW94L1dEakNEOEoxV2RiMlExVzMvNHY4ZHhJcDZVdjh3RnFIbmxub1FubDZh?=
 =?utf-8?B?TTNvK1RVY1FCTS9CZFFyd3FjbCtEMi95Vks0SWp6SW9ocUxTcE9aSHdtUzNR?=
 =?utf-8?B?Q3FQRVIwcW9SYkFpNndBbDA0NE5BKzRrZjZhSXFPb3VnbzFHUENpOWl1VEhl?=
 =?utf-8?B?Q01nVXVpazYzeFhMYzM4c3ZmV2xTNjVnNFFpMzBrSVIxWUE3ZjhvRG91T0Vy?=
 =?utf-8?B?WW1IZ2tBYTluK2E0cWJpeklocGZ1OUU1MTg4VjlsYWMyVzhiTG1Ydk9jWFhE?=
 =?utf-8?B?TzJLUmJGS0ZteDZuRm5jbGtSeDVFUHQyNmxBV3o1d3I3c0w0VWlGNjAvdTk2?=
 =?utf-8?B?cURhQXV0MXZBMzNTYTJrRTRjcHh6aEY0U2FqMkZaODE4K015OVhySC9GdmRv?=
 =?utf-8?B?aEthWkQyamdWQ0hiT3REblhsWng4VjhNNVdTdXJxcVpRUm81YXJCa3VWbU5V?=
 =?utf-8?B?NjVTOFgyNm5OVVBEUEpwK1ZoZnpPWGQ0YUxTZU1TeHpuckVFY3gyM2RuczlU?=
 =?utf-8?B?NjJaTGtFclhqTnV0U3dpU2tVRXZwRVpEQ0NScjlBWE52d0x4cjdCK1Q0MlYy?=
 =?utf-8?B?d0VCRmhpUHltSGlQQm9kVHMzWlVzdUNTWXd0bSszTHZRUVMxTHp4VFliL0xw?=
 =?utf-8?B?U044QVpGMFBTUWsxWW1GRi94UFJtMmFFSVV5T2ZQVHQ1RVF2Vk9WM09URUVk?=
 =?utf-8?B?N3h0WDJ5RlZ1dWErdGZHSDBPVTYyRk15UXh0WngyQ1M4dGtHV2NxRHdpbDlx?=
 =?utf-8?B?V3JjYVdDcjBpayswbU5aOEJLRWhCRDN0dTJrdFIvdW9lczFHOE9ZSWtPR0hV?=
 =?utf-8?B?azIvdkR6VVArcmVLS1JpanhjSWVqaU1Ua3NRalBwTFlBTFFWL2lTaURlbUs0?=
 =?utf-8?B?cU5sSDJ3cll1RHpuMDVSVXp3aHYvTVdlNm5wYWRxN2p5alFaQmo3dFh2OVI5?=
 =?utf-8?B?SWdOTU1oajgxM3d4WUJKR0ZTSU93TzJFV1N1MGJ6ZHpDREJlT2JER3dHbG9T?=
 =?utf-8?B?UTBaVGJtWitrbDZPeHBYVGhDQSswYmJJNHdicHFpMzJIMlNiTGxkQndCM0lx?=
 =?utf-8?B?bm9majlyWlkxSDFlajZxbThsaDdHQW1FZ0ZZK2dZTDdSVXFmQnhQVDRhd3RC?=
 =?utf-8?B?bWRJWTg1MlF2OHRkbTFBOVU5UGJTQkprN09BWVhlVGYwOXFxY3RxTWZBTjdJ?=
 =?utf-8?B?VUxjTEVOei9BaUZRZjFndGhzbitzc04zYVVmK2JDY3FNZnNvMTI0RWJUNnQ5?=
 =?utf-8?B?V1hHaFphS1l5M2haVWdjanVmZkprckx6UnJUZUtYR2FPYUhIZTNTQ0FFcjZQ?=
 =?utf-8?B?S2V2VENqRlRzMVRDY0U5WUNnVHNwdFp5VE5kZGVFRUg0QzExRU1zYlFtOVd2?=
 =?utf-8?B?WjdQL2RlTFZtTDZ1aEhMbWVLYjRmQUxISFRCM2FSOXRueGlwYitPVFc1Um5z?=
 =?utf-8?B?cFBFVUNONU5pbEpVNTRIKzhxWVpEUG54T2puM0RLMkZtMkRSUnIxL0VQajhO?=
 =?utf-8?B?WnJNS2M4VEZKUnhDRm00WVhIWmdGWXlKWkdBVVFCQytFeDlIYXh3S1VrNUM3?=
 =?utf-8?B?TXlMOWVEcnc5bWpycG9kMktDZi9nQ0RwTkpNYWdaQmxnZW1TQmhvQm1UMVhT?=
 =?utf-8?B?WkJ3Sy9DTHZNZGJZb0FQclMrREdVRlpUNUlDMG1TeGlMckx3M3Uza0prME1n?=
 =?utf-8?B?MW1IdkVGQkFuMldFc2ZRdS9lbFphNFF1cXpscjQwNkhJcHlDekE3c09uTjVl?=
 =?utf-8?B?S1ZxaWtmMWp5Z084UkFVSFMrOFNQNm9HMzZheHA3K2J2c2tsSU00TzBXMmJa?=
 =?utf-8?B?T1pOSXV4VGxBUDh2SW1ZWGRRejd0d1NoOVI4U2tmN0lEaUFIU1JRWHhVYjEy?=
 =?utf-8?B?ams3d1ZxQkV1bGRXNytzamZiUlRTNDVab285THdxWEdwelcyRE8ybmJyeU9v?=
 =?utf-8?B?OUFNckZ4eUREanMxNnN1YXJDNm5oVHl4Q3JvTldVUy84Q1FzUGRvNkZMMmlE?=
 =?utf-8?B?T09wMEVqbWt1TzJsYnR2d0N6ZnVuQU12RkE1OExtNlZEUkYraWtVZHIxNzBp?=
 =?utf-8?B?VHdRS1E0TW5ZNGhZOUdvOHJRUExJRmRBdUJYQXNOd0xvUEtBTnZjcllPbS9k?=
 =?utf-8?B?L05pNFFIV3k1enM1NG5IS21LSnJUVEF5VUhHSzhLWk5TT05hY20wQT09?=
X-Exchange-RoutingPolicyChecked:
	HWxMUldcsoH9I/17ESt2GCTaHfpN9m8OPx7vojT02s0pD1VFVz8GnAWNCt/vdpP/Kvjz5ta+5XaGZg8y/9IqAZr/MTqcaKW9OC4ltv11z5uHHLDzxfF0ObNdp60Vwn5g4bJuKd2uA0tCi+muEppxBlWdmrLvF1R0RFsHy2W8smBMmJd3RRkdX4U7Z/DUV6ZMKxo6Ar/93PM/h4rFZKvMYbujXIbZN7DMGbIi24+OKWOjGsbwI45kfx+XCQqrchMXFptdyGYqE9/ctYnlJR3kDqNWptncAgyTaYsvaz2KM6j5QYdGzz5gwdBctUX6BJnXdlVw3U4EA3ZaN3ZDD0ySgw==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bb80fb1-a8b2-4428-8490-08df2a13ccb7
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 16:54:23.8267
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ygys8AGL2XeM6Y0/cQGFG1If4KWD9yOBso5RyiqYH/46zpcaAl9B9bS4iA1CPkd+T9f7HJJxK6wkMU7IiDgh9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR03MB8350
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA2NyBTYWx0ZWRfXx2pWFD1LxzCA
 jW5gH0hz4/I1ojuoE3iAn/zrELj8LcRmMa3zxxUeGu3fyFyfp/aeXMraEToW3N2E+sGH3UrakK7
 i8VzOgzNpz+3ByYCs1JHdYdZyElDxQTPW8GLMD8fxA1cZGpS9Ih3
X-Proofpoint-ORIG-GUID: LdGZla-parmT6yCt7778Q3zCQJ71rgE6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA2NyBTYWx0ZWRfX5+sz5uSNxwjZ
 I4FjGjnjnTUAlNv0yBupsyVUfugcKXREUUe5OuIk+H/kxJn1U7Kqm4QZw2VaFcbNUSqxB1PdhtN
 RRAuT53IYCbSexRgs4GkEEh4nDt7qSUuH+lbMhsE/Sp4bu5yoBUWhHQVLG3gsuRz/MzNGSN5Jd5
 gnxG5egOsoQbFuZ2RrbezYsyDwbtPivgspKXOLMauaWWJOfwsv1yDvdXCInwtHfvNoM9beXrasD
 aB26EJDgYhG41w4qp2wFWmMvUHAqLuCTeh3Qopdp7capTcvbwzJjztIcMJs4ndtQ/NFtG5ZsfRM
 NjZm2TjpGJyHX/JdeF8C06rD5p6p1mYyFOHOTZX/cFSENL4OWcP5fFnJcv/s1EewJvPg28sIcv6
 5f5IzchvhftoqXL5Ae48gRR4seTMqcR5nvcfIBXK+laCssNOCqRrfpypYVPhPkmr5GRd8b5T017
 MABlPc02pDqCfMHKoVQ==
X-Authority-Analysis: v=2.4 cv=T5cZ3PKQ c=1 sm=1 tr=0 ts=6acfb3c2 cx=c_pps
 a=+HTpKnCyMzx6Y2VIV8u7NA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=_jAD5XSDOtq9-5Nde2OG:22
 a=P-IC7800AAAA:8 a=gAnH3GRIAAAA:8 a=52GAypgwlith3z0GNqkA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-GUID: LdGZla-parmT6yCt7778Q3zCQJ71rgE6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 spamscore=0 impostorscore=0 priorityscore=1501
 malwarescore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610140067

On Tue, 06 Oct 2026 15:17:19 -0300, Marcelo Schmitt <marcelo.schmitt@analog.com> wrote:
> When AD4134 has its SPI CRC feature enabled, one extra byte (the CRC code)
> is sent through SPI for both ends to verify the integrity of data
> transfers. Though, when CRC is not enabled, SPI transfers can be shorter.
> 
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>

Hmm, still don't get the crc story... Are you saying crc just does not work as it
is? What's the point then :)? I think it should very much be fixed. And
It's indeed odd to compare the crc over different payloads. The normal
way is that on receive, you compute it again and compare it against what
you got from the device. Pretty sure that's what the device is doing (or
at least it should). Might be missing something but not sure why we
would need spi core changes. See this for example:

https://elixir.bootlin.com/linux/v7.2.10/source/drivers/iio/imu/adis16550.c#L193

Anyways not related to this patch so:

Reviewed-by: Nuno Sá <nuno.sa@analog.com>

-- 
Nuno Sá <nuno.sa@analog.com>
