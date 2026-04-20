Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADFB83AC0FF;
	Mon, 20 Apr 2026 14:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776695760; cv=fail; b=aTl0PSA9XtPJVlgW9sbRwjFzM5AF0o/IZ4g5ax7mJ99KcvHLdCHUyHY2+u84XJmj1HvDhWIu55zIpExD6S95KF1L+jjABwDgOjjD1dhZjuxyXO1c/j19y/3snMWqGVbj5iLA11IaNrK+GYxI8PLwO1B/R5QGZYmgMH+STOImx3Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776695760; c=relaxed/simple;
	bh=4psryIZQ7RzxDqSUVyNQleb+uMi1moAwvDMNq3z5Fnw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=C2pIXhvNP9uGiFYE1DMnW4lXSLzj1W9HWh4r7t3jzK3YJ1xz8pc2Rn+wpijlyevPfOMfREdAt6gC63ZTD0msH+TGworPB6r0K5SQAFfAQ13GtzLJyix5t46mhoBAFzeCoWiczbm8syVMUfeqo6L55W3+lu2kNsrFssgATFDqDMg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=YQtvKxMk; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="YQtvKxMk"
Received: from pps.filterd (m0375854.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63K9CEj1918324;
	Mon, 20 Apr 2026 10:35:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=4psry
	IZQ7RzxDqSUVyNQleb+uMi1moAwvDMNq3z5Fnw=; b=YQtvKxMkfeIHSOZL4fm3n
	oIkQZl6j1jeJlcavgXIxMPDhRhj9JkcTw48r+xeBRRrscJggB1R2QIFdXxC66aC3
	Bt5sRrVa1JLdl2dA4s7sVGSHdP3yS0cjunSVys1LiQ0dxIZqhAzybERXMVY0e+aO
	Vgpt52FTXQOa2MrEOsYV6duQuC6huEiDfO+ED2HjGwoOe5au4eb/4FjW1JJhhNyT
	VHKybquMyfNA89dnr7v+npwz0Zhjt84n1uxAK79rHUd6iKEzvVuNXzaf5lRQqT2I
	fbwII/O4P60WKQ4Iiq/5eibgWIehcg1SxWI9ncDYFFOySEcOw57CbuPtTk8nPETf
	Q==
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011024.outbound.protection.outlook.com [40.107.208.24])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4dmv0dk94q-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 20 Apr 2026 10:35:34 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IRz9IYKeJQ9lD99xzXG/dn5+ivwgNiEwgehsNTFN1ZTsdEBGfdR1fBh/xQMKbfKbdNq7CaL3IIGxet3FKL2JyKHXWOlsZWoxzmMtiqv7fV4pSMe/mjmRzJAOEZnqyfi2X2kY4iXccwNA887foSF4LY5bOJ7aEKMiFswnwN5QZJfybFXSq/yx2xhQbptkaxYcB0fr4FCq00eygDT61j9RPof294EZIazOgu7u5qCQxaEVAIIHks1JkCIIe80Hj5jZgH6FfGIgMN8BilD/XQLxrp2sLkpKxqaT60R5ID/B9EWFnoCea7Cub56BSywj4u7AtlPovbTrqgJol++kEphfag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4psryIZQ7RzxDqSUVyNQleb+uMi1moAwvDMNq3z5Fnw=;
 b=TZBsVOfT1jeY2/J+A/AbyRwxdWWVpe0wfYOQsPlIxGefxcLBd0ZTRNonz3iabz4uFYwtfBxvAFNES1O7XC5h2XreQ8KzngUgI1g3nCjvg/cDbW9nAEB2kadMr3rZmjSIqLbvfxe0htfZQrJED/lBwVMFcyKX+ocfEIQyz+Zn8xg/640afgn3+ni17ECIDkmO5//ED8DwfvealaxauWBCJ2Wv0Qnhj/OV4ty3R9PqfLzdy7FnPy1hlETF5BM8GOB3+lntIsE1wC9NX5oWlQkRoi7o+Cy5u9faczIv18pQE6AEJGZ9OkrDa6HgVNVCxbk3E7jf3t72iIAizRvJJUcITA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from CY4PR03MB3399.namprd03.prod.outlook.com (2603:10b6:910:57::13)
 by DM4PR03MB7015.namprd03.prod.outlook.com (2603:10b6:8:42::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9818.33; Mon, 20 Apr 2026 14:35:31 +0000
Received: from CY4PR03MB3399.namprd03.prod.outlook.com
 ([fe80::1527:d313:16d4:2376]) by CY4PR03MB3399.namprd03.prod.outlook.com
 ([fe80::1527:d313:16d4:2376%2]) with mapi id 15.20.9818.028; Mon, 20 Apr 2026
 14:35:31 +0000
From: "Miclaus, Antoniu" <Antoniu.Miclaus@analog.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael"
	<Michael.Hennerich@analog.com>,
        David Lechner <dlechner@baylibre.com>,
        "Sa,
 Nuno" <Nuno.Sa@analog.com>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Olivier
 Moysan <olivier.moysan@foss.st.com>,
        "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v8 0/3] iio: adc: ad4080: add support for AD4880
 dual-channel ADC
Thread-Topic: [PATCH v8 0/3] iio: adc: ad4080: add support for AD4880
 dual-channel ADC
Thread-Index: AQHcvqgQBtxoLIQOlU65MwD2yCgcMrXb2H6AgAWmUKCABqgBAIAAALLQ
Date: Mon, 20 Apr 2026 14:35:31 +0000
Message-ID:
 <CY4PR03MB339910A3108F11182FC88FA69B2F2@CY4PR03MB3399.namprd03.prod.outlook.com>
References: <20260328114050.46848-1-antoniu.miclaus@analog.com>
	<20260412193349.6a3fea03@jic23-huawei>
	<SN6SPR01MB0090FF0C73500BB51F63D7FB9B232@SN6SPR01MB0090.namprd03.prod.outlook.com>
 <20260420152914.323238fe@jic23-huawei>
In-Reply-To: <20260420152914.323238fe@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY4PR03MB3399:EE_|DM4PR03MB7015:EE_
x-ms-office365-filtering-correlation-id: 9fb11971-e0ef-432e-a30a-08de9eea130a
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info:
 q8dKTpADPTXcA35VDRrS8MHUUmn9s7asLCQ5h508DiPzCpYUWagqyEHI1+d+koH3Uc5LkQcs94vjQjYSLcFeFZEn+ecfQXfPozRvobERs7Z4/4SRU2dC49zvBGpryDncLzltdx0ZiMEkVL9CaFtnfDiDeBUjDXKek0GgcSHTvI2d+Dpe+P6+8htB7HZUXdbM0DsgmBoihygOTidpjRkRUj4iYPK6a/ljVvhuwf8UGG1RQUgLRorOAp57Wig5uVo8gnoO6gKKcul4nhWFiCvapFY/e41Lmf+ApnFHORhVwLMeTHMcUySWgDsccJpGjuj+PlOyuvywa7Wl5hmeF7lchsZnJqZQn00ltMxCMIMhqvnhUqMng8cDAuZFJesShHhQ+HFJ7G/GUd17y3fnZUZmTevrnRBmNlnz8X12/em+gG9bSO9LvDYEyfg0aSynRxDh39c7LmrTKkPmvd0TFwK1SBEFTg5S0kCCS3pKzqs2J0EDChxdgZuTFrEvqafgHZOOMcosaeWYqLjBiccP3yhqX899wuBiB/mwhUNXWCJUWH1fzbuMOUfUg9y7IhIazVvvztix7Y7L2Le8nRU2y+YwrkdPhYCn8jvo7x2KbhdsOTeOQ6ntvhohD1xg6rwVfiUWYWhiUlPA0AdsnNyymaptTAR2C30oJxplmLa654ZdrQfOFAch6EExwSQqy6I2mkuHYYGzEni5wYmFIpoBNIPCnNZGS2YIoildDHYl0aC71aCF2ZEMnKmppzP9vKmE7In8zCbA7SBKNgqWIZJiQR+We1cKb8UhprJNaQ9SqimO0qs=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR03MB3399.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700021)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?T1g5K0NFUUlhUDhFM2tUVzJzcFBqSHZxUEZCL054c0VtNzB1clBRajd3VFpN?=
 =?utf-8?B?Y2pwL2NxY2JiTVFrZkJ6U1BRNkRobUI2eHIyZDk1dWVkdnNwbVhxNXhVOFZv?=
 =?utf-8?B?SkVzb3QyVGdzL2c3azFRSkxPdjhCeERiZmxDU3Y4NkIzZnByUkhKeHpQZ3k2?=
 =?utf-8?B?MDdFTHdrczNtdWhadWJaQUtQQVdDVHc5RzR1YW9vamhaMEpLVWNyOGQ0d0xo?=
 =?utf-8?B?cWhXc0QxMGY4MlJqcFAwcVZBOFgvenpoRmtOMkM3NUhtYUc0SFQxb1FWQzFD?=
 =?utf-8?B?UjFYVzcybDZnL3Q0NTZtK2c1ZDBvZjNBYlFrc3hPb0tqd0grZ0lhZUR0ejln?=
 =?utf-8?B?eEZUMWZBeHZjbTkvRnZnRDNhWTg0QXltd3J5YjFrUnAwajU2ODloOHZ6MXFP?=
 =?utf-8?B?MDJtZjhMcTRmNEsvdmZ3K2NXbVVNZlV1YllrVGE0U2twV2kvOTZWNTNtNjBV?=
 =?utf-8?B?OTN5NGtld1hIY0dlblJZNGZhMTNSOWV2SUdxVUM2SHEyT2l0UzhyMVNCcndt?=
 =?utf-8?B?WmVuTXdIQ3V1amd3NGVTNzBnUUhVTUJxbzBiWHlHazlmREQ5KzJGUDNTWjdx?=
 =?utf-8?B?QkJvQ0M0RWhqKzF6U0xSTndzMlZodmxkVzRYV0pQUm1oY3RRU3pzUWNYZlBY?=
 =?utf-8?B?TklXaW1EYUYrdWs4djAzR1dreUloWkZOajB5Mko3b2haWldWSXpjZXo3bTRB?=
 =?utf-8?B?SGVjcFdFcmVQSXhrcUZueWlsRm1iYmxJL295WFRkdTMwQS92RzNjV0U5L29t?=
 =?utf-8?B?RkpJUlhySlA3S0F4YXNGZDNjZllGaEp6bDlEdVlQUGdzcERqNUFZeFRwbS8y?=
 =?utf-8?B?VDRtbEpJVy9rWU9MdDIwZzBRckFkK01qREhBK1U1N05wcGhaaGdxdkdWSVRF?=
 =?utf-8?B?YTVVR2ZzZC9US3lTRUpzbE9hSmNxUTdwUnBnUkZmUC9tYWlSNWlta3hyVy9Y?=
 =?utf-8?B?c1ozdGU1RVpldkI2eTJiZlJpZHFKVkMrWXlMMWZOK0RUNk5sdkkwZ05HbmFJ?=
 =?utf-8?B?U1U4U2JpcDRnTEIzbGlTM3pNM3Btc2xycXRoVnREODFnb25zY1BxdkpkSDBN?=
 =?utf-8?B?T1NaczZ5T3hONFRra1dsTC9CT1NBaWN0NDJtOHUwckZUZGpXSUZyWFl3TEZp?=
 =?utf-8?B?Y1RhK05ONzY4WndMS1BSSVFUTGN0WDVhampIY045dlE5VVRQV2tVdjVWWlYx?=
 =?utf-8?B?bTRacko0Z1pHRnFuOWRkci9Nd1ZIM1RNKzN5dVkxY0lpTXk2eDlmTTFDZTZy?=
 =?utf-8?B?UzN3dTQra1Z2SVRndS9NMUozR2d6SVl2akVoZG1CWCtNZ1VJNm9xSUtxN0Z2?=
 =?utf-8?B?K3dsZDcvbEpTQ0R2cTB1K3RUb1R3d2lzT1ROQkJSUXhKUzVIVnFwUFNhQzRJ?=
 =?utf-8?B?TkhVeVgyODBQd2x1b3E2Tit0bzFQQlJTbE5nWXNwWnBlS20yWU5xSWJEMHVC?=
 =?utf-8?B?anhRVzJpcDM4OHlDRWtuWlNkTXFFOW51T3l1L3VVK2pZczhqOC8vbFc1azNH?=
 =?utf-8?B?NzdheWpVVjR4OTFSQnlEclFwTitJc0RGSDR4TTFtbWRNZ243RVdEaWdxK1Vh?=
 =?utf-8?B?a2g0WVZUVGtDTW16OXFHUWxTM0swa3dmTW5sVkhrQXdhc2xLOVNHT2wvSE9x?=
 =?utf-8?B?VDZGbGROUUVuRjViWlZlSktvNkd6UXBrMHRleTd4TlYwbkZic3krRDMrZlVE?=
 =?utf-8?B?RjhLclU3L1NHMkRLWDFRVUlBekg4QW9SbWZlYzRFTkIvUTR4cEpnaU83bDJu?=
 =?utf-8?B?L3gvVk56bmJLYk1jZXdiZkNFc1RJUXNOK3hRSXBxUEpHdnhnNXN6bkJiRWdh?=
 =?utf-8?B?MnVJN3NPeHYvSnNjUG5ZTGR5bEE2bDlXZjQydGtKeWJ5NGR4My9PRGtmTWVw?=
 =?utf-8?B?dlBubmRWc09ISlFxY1pEeWhDd1RDVU1KemtYTy9XUmp3YWdocTF6V2lUbUw3?=
 =?utf-8?B?cUtzV2IyVld4a0ZkbHJEdHdwLzNtY3d0REtEWWhFZkZwWGdXcm8yWDBzR0N2?=
 =?utf-8?B?dEdBeEVWK0pPNkdJZjBHbVdleko0bHhOcDdUVUgwaUd6OUpyaHBxdndBRVo5?=
 =?utf-8?B?U2xXaTAyY2NzMlQ3K1hsZ1YwM1FDMyttVmxyeGhyU0lMTUJldlE1aHk5UGla?=
 =?utf-8?B?ZzZjUU03M1J5em90QWE3RFVjSlJteHpvL2dRbko0Z2FVNFZ0RTdtcVJYbkJ3?=
 =?utf-8?B?ZXJtUzBIajNJWUh4eVc3SHRUaVlZNXpvR1dLcVUrQVNRK0c5Q25XSFJsYnhv?=
 =?utf-8?B?aW5IN1RGZm0vV1lEOTdEeE8vYjNnS1ZYOGptRTZtb2xtdWh2NXpaOGVaYUlS?=
 =?utf-8?B?TWhJT0FEaHhsM2tERlBhS0xocE0yaW9icmxJaVhQY0E4bWlSdnJGZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	OjsF5dDPN/71Y+cq0qtvNiSc4NyD5uvd20OAFS4/uUn2DURAt99ELWOr38zDrW2GtpRMmcfcEbVQep+KjTyQXLAPrmbvKuKoQ4IlDie/K0YOWZ7EpgJIQWN07w9s1H9RCLZ1p8GZ0hWk+BevgTwv6Rj/LbrNIE0qki7xN1tWNoefcajNlG+39CCNuyIIg3ybEnZj+f4z1bGfYyaSzXjCp0pL1wgobXIRke/MkG4PQY8PQz8nE9ZOdl6cM7XsgIOV/SqZalJ/YFSGsXvCImFLtjvaQkbH2iFf/Rb8bV45Qj0IXBtKQCGy902XYQe6zBvTFObquXoeeyr9zO1IyuzLfw==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR03MB3399.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fb11971-e0ef-432e-a30a-08de9eea130a
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2026 14:35:31.2094
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I1GcUXjIaBPe49tJOPqqhGdFpqNH0OvEEBrlaNPo0J3fBaxrsiUVUXVlt5CG9pJn010twpELNGJx8Vz4tlv17GsRnRZhvazUSN+7ewnajXA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR03MB7015
X-Authority-Analysis: v=2.4 cv=Ar7eGu9P c=1 sm=1 tr=0 ts=69e639b6 cx=c_pps
 a=DvLgf67dpzRpeCMgcWG2JQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=iZSIUCweCk2Oy3QsdGPA:22 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=gAnH3GRIAAAA:8
 a=IpJZQVW2AAAA:8 a=8b9GpE9nAAAA:8 a=s3G-wEaURhbW86X-jEMA:9 a=QEXdDO2ut3YA:10
 a=IawgGOuG5U0WyFbmm1f5:22 a=T3LWEMljR5ZiDmsYVIUa:22
X-Proofpoint-GUID: TKC8YpgBd47Helt5E_NK-EMwNB3j4Qft
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIwMDE0MCBTYWx0ZWRfX8TC3k9/nbi9L
 IJaqLBp4UJI+AroOUw2O2O4HrKRf9vov/lU8ZGJeSXFN45SdPhoREyQhngrvD7/NHJ+G+xAIdV/
 Z4jO9VhKZu14ZtKr4gM+cB2AU5Bqr2WkZojgsZBNeQtkTyv+bWzbfWbwEFxmM0gJbxkPe1XsV5p
 mL97sXG2AknhfR9D4xlK2p9/UbVicp+ThSIAYeidNTyL9pQHUFsG3AD5q2rLmiSEKsMxAzLdo04
 sUFkg92AJdoHLUCzEiCvx8DiyCI9PAbhkuHJ5UQcnXWFnQcr7t6OCC6OxMg2b3SiUHAyPJR9cc6
 ZB/H32NiYngc8qUdm9P19KSQo5ZT3FDcegC8sLm106ZLPAaZeuq00UGQvC4m4t3pzxab88/pmFY
 4kQql0m3dpvExQ8xYyLAs/TWT1y7A0mKlD8qK9LCBynt5qvgXIUlkfyikfnnTW3ydhDPtYeakDN
 KX85bFmW5gs/4I7N5lw==
X-Proofpoint-ORIG-GUID: TKC8YpgBd47Helt5E_NK-EMwNB3j4Qft
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-20_03,2026-04-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0 impostorscore=0
 clxscore=1015 suspectscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604200140

DQoNCi0tDQpBbnRvbml1IE1pY2zEg3XFnw0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0t
DQo+IEZyb206IEpvbmF0aGFuIENhbWVyb24gPGppYzIzQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IE1v
bmRheSwgQXByaWwgMjAsIDIwMjYgNToyOSBQTQ0KPiBUbzogTWljbGF1cywgQW50b25pdSA8QW50
b25pdS5NaWNsYXVzQGFuYWxvZy5jb20+DQo+IENjOiBMYXJzLVBldGVyIENsYXVzZW4gPGxhcnNA
bWV0YWZvby5kZT47IEhlbm5lcmljaCwgTWljaGFlbA0KPiA8TWljaGFlbC5IZW5uZXJpY2hAYW5h
bG9nLmNvbT47IERhdmlkIExlY2huZXIgPGRsZWNobmVyQGJheWxpYnJlLmNvbT47DQo+IFNhLCBO
dW5vIDxOdW5vLlNhQGFuYWxvZy5jb20+OyBSb2IgSGVycmluZyA8cm9iaEBrZXJuZWwub3JnPjsg
S3J6eXN6dG9mDQo+IEtvemxvd3NraSA8a3J6aytkdEBrZXJuZWwub3JnPjsgQ29ub3IgRG9vbGV5
IDxjb25vcitkdEBrZXJuZWwub3JnPjsNCj4gT2xpdmllciBNb3lzYW4gPG9saXZpZXIubW95c2Fu
QGZvc3Muc3QuY29tPjsgbGludXgtaWlvQHZnZXIua2VybmVsLm9yZzsNCj4gZGV2aWNldHJlZUB2
Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDog
UmU6IFtQQVRDSCB2OCAwLzNdIGlpbzogYWRjOiBhZDQwODA6IGFkZCBzdXBwb3J0IGZvciBBRDQ4
ODAgZHVhbC0NCj4gY2hhbm5lbCBBREMNCj4gDQo+IE9uIFRodSwgMTYgQXByIDIwMjYgMDg6NTE6
NDYgKzAwMDANCj4gIk1pY2xhdXMsIEFudG9uaXUiIDxBbnRvbml1Lk1pY2xhdXNAYW5hbG9nLmNv
bT4gd3JvdGU6DQo+IA0KPiA+IC0tDQo+ID4gQW50b25pdSBNaWNsxIN1xZ8NCj4gPg0KPiA+ID4g
LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiA+IEZyb206IEpvbmF0aGFuIENhbWVyb24g
PGppYzIzQGtlcm5lbC5vcmc+DQo+ID4gPiBTZW50OiBTdW5kYXksIEFwcmlsIDEyLCAyMDI2IDk6
MzQgUE0NCj4gPiA+IFRvOiBNaWNsYXVzLCBBbnRvbml1IDxBbnRvbml1Lk1pY2xhdXNAYW5hbG9n
LmNvbT4NCj4gPiA+IENjOiBMYXJzLVBldGVyIENsYXVzZW4gPGxhcnNAbWV0YWZvby5kZT47IEhl
bm5lcmljaCwgTWljaGFlbA0KPiA+ID4gPE1pY2hhZWwuSGVubmVyaWNoQGFuYWxvZy5jb20+OyBE
YXZpZCBMZWNobmVyDQo+IDxkbGVjaG5lckBiYXlsaWJyZS5jb20+Ow0KPiA+ID4gU2EsIE51bm8g
PE51bm8uU2FAYW5hbG9nLmNvbT47IFJvYiBIZXJyaW5nIDxyb2JoQGtlcm5lbC5vcmc+Ow0KPiBL
cnp5c3p0b2YNCj4gPiA+IEtvemxvd3NraSA8a3J6aytkdEBrZXJuZWwub3JnPjsgQ29ub3IgRG9v
bGV5IDxjb25vcitkdEBrZXJuZWwub3JnPjsNCj4gPiA+IE9saXZpZXIgTW95c2FuIDxvbGl2aWVy
Lm1veXNhbkBmb3NzLnN0LmNvbT47IGxpbnV4LWlpb0B2Z2VyLmtlcm5lbC5vcmc7DQo+ID4gPiBk
ZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0K
PiA+ID4gU3ViamVjdDogUmU6IFtQQVRDSCB2OCAwLzNdIGlpbzogYWRjOiBhZDQwODA6IGFkZCBz
dXBwb3J0IGZvciBBRDQ4ODANCj4gZHVhbC0NCj4gPiA+IGNoYW5uZWwgQURDDQo+ID4gPg0KPiA+
ID4gW0V4dGVybmFsXQ0KPiA+ID4NCj4gPiA+IE9uIFNhdCwgMjggTWFyIDIwMjYgMTM6NDA6NDcg
KzAyMDANCj4gPiA+IEFudG9uaXUgTWljbGF1cyA8YW50b25pdS5taWNsYXVzQGFuYWxvZy5jb20+
IHdyb3RlOg0KPiA+ID4NCj4gPiA+ID4gQWRkIHN1cHBvcnQgZm9yIHRoZSBBRDQ4ODAsIGEgZHVh
bC1jaGFubmVsIDIwLWJpdCA0ME1TUFMgU0FSIEFEQw0KPiB3aXRoDQo+ID4gPiA+IGludGVncmF0
ZWQgZnVsbHkgZGlmZmVyZW50aWFsIGFtcGxpZmllcnMgKEZEQSkuDQo+ID4gPiA+DQo+ID4gPiA+
IEFyY2hpdGVjdHVyZSBub3RlczoNCj4gPiA+ID4NCj4gPiA+ID4gVGhlIEFENDg4MCBpcyBtb2Rl
bGVkIGFzIGEgc2luZ2xlIElJTyBkZXZpY2UgcmF0aGVyIHRoYW4gdHdvDQo+IGluZGVwZW5kZW50
DQo+ID4gPiA+IGRldmljZXMgYmVjYXVzZSB0aGUgY2hhbm5lbHMgc2hhcmUgcG93ZXIgc3VwcGxp
ZXMsIGEgdm9sdGFnZSByZWZlcmVuY2UsDQo+ID4gPiA+IHRoZSBDTlYgY29udmVyc2lvbiBjbG9j
aywgYW5kIGEgc2luZ2xlIGludGVybGVhdmVkIGRhdGEgb3V0cHV0IHN0cmVhbS4NCj4gPiA+ID4g
U3BsaXR0aW5nIHRoZW0gaW50byBzZXBhcmF0ZSBJSU8gZGV2aWNlcyB3b3VsZCBtYWtlIHN5bmNo
cm9uaXplZA0KPiA+ID4gPiBkdWFsLWNoYW5uZWwgY2FwdHVyZSBpbXBvc3NpYmxlIGZyb20gdXNl
cnNwYWNlLg0KPiA+ID4gPg0KPiA+ID4gPiBBbiBNRkQgYXBwcm9hY2ggZG9lcyBub3QgYXBwbHkg
aGVyZSBlaXRoZXIgLSB0aGUgY2hhbm5lbHMgYXJlIG5vdA0KPiA+ID4gPiBmdW5jdGlvbmFsbHkg
ZGlzdGluY3Qgc3ViLWRldmljZXMgYnV0IGlkZW50aWNhbCBBREMgcGF0aHMgc2hhcmluZyBhDQo+
ID4gPiA+IGNvbW1vbiBkYXRhIGludGVyZmFjZS4NCj4gPiA+ID4NCj4gPiA+ID4gRWFjaCBjaGFu
bmVsIGhhcyBmdWxseSBpbmRlcGVuZGVudCBjb25maWd1cmF0aW9uIHJlZ2lzdGVycyBhY2Nlc3Np
YmxlDQo+ID4gPiA+IHRocm91Z2ggc2VwYXJhdGUgU1BJIGNoaXAgc2VsZWN0cywgc28gcGVyLWNo
YW5uZWwgcmVnbWFwcyBhcmUgdXNlZCB3aXRoDQo+ID4gPiA+IG5vIGxvY2tpbmcgYmV0d2VlbiB0
aGVtLiBUaGUgZGF0YSBwYXRoIGhhcyBubyBzb2Z0d2FyZSBpbnZvbHZlbWVudCBhdA0KPiA+ID4g
PiBydW50aW1lOiB0aGUgQ05WIGNsb2NrIHRyaWdnZXJzIHNpbXVsdGFuZW91cyBjb252ZXJzaW9u
cyBhbmQgdGhlIGRldmljZQ0KPiA+ID4gPiBvdXRwdXRzIGFuIGludGVybGVhdmVkIGJpdHN0cmVh
bSBjYXB0dXJlZCBkaXJlY3RseSBieSB0aGUgSUlPIGJhY2tlbmQNCj4gPiA+ID4gKEZQR0EpLiBz
cGlfbmV3X2FuY2lsbGFyeV9kZXZpY2UoKSBoYW5kbGVzIHRoZSBjb25maWd1cmF0aW9uIHBhdGg7
DQo+ID4gPiA+IHRoZSBJSU8gYmFja2VuZCBoYW5kbGVzIHRoZSBkYXRhIHBhdGguDQo+ID4gPiA+
DQo+ID4gPiA+IFRoZSBkZWJ1Z2ZzX3JlZ19hY2Nlc3MgY2FsbGJhY2sgaXMgbm90IGV4cG9zZWQg
Zm9yIHRoZSBkdWFsLWNoYW5uZWwNCj4gPiA+ID4gdmFyaWFudCBzaW5jZSB0aGUgSUlPIGZyYW1l
d29yayBwcm92aWRlcyBhIHNpbmdsZSAocmVnLCB2YWwpIGludGVyZmFjZQ0KPiA+ID4gPiB3aXRo
IG5vIGNoYW5uZWwgcGFyYW1ldGVyLCBhbmQgZXhwb3Npbmcgb25seSBvbmUgY2hhbm5lbCB3b3Vs
ZCBiZQ0KPiA+ID4gPiBtaXNsZWFkaW5nLg0KPiA+ID4gPg0KPiA+ID4gPiBUaGUgQUQ0ODgwIGlz
IGEgZmFpcmx5IHVuaXF1ZSBwYXJ0IC0gaGF2aW5nIHNlcGFyYXRlIFNQSSBjb25maWcNCj4gPiA+
ID4gaW50ZXJmYWNlcyBwZXIgY2hhbm5lbCB3aXRoIGEgc2hhcmVkIGludGVybGVhdmVkIGRhdGEg
b3V0cHV0IGlzIG5vdA0KPiA+ID4gPiBhIGNvbW1vbiBwYXR0ZXJuLg0KPiA+ID4gSSB0cmllZCBh
cHBseWluZyB0aGlzIGFuZCBpdCdzIG5vdCBnb2luZyBpbiBjbGVhbmx5IChJIGRpZG4ndCBjaGVj
aw0KPiA+ID4gZXhhY3RseSB3aHkpLiAgUGxlYXNlIGNvdWxkIHlvdSBzZW5kIGEgcmViYXNlZCB2
ZXJzaW9uLiAgVGhlIHRvZ3JlZw0KPiA+ID4gYnJhbmNoIHNob3VsZCBiZSBmaW5lIEkgdGhpbmss
IGJ1dCBtYXliZSBzYW5pdHkgY2hlY2sgaXQgYWdhaW5zdA0KPiA+ID4gbXkgY3VycmVudCB0ZXN0
aW5nIGJyYW5jaCBhcyB3ZWxsLg0KPiA+DQo+ID4gVGhlIEFENDg4MCBkcml2ZXIgaGFzIGEgY3Jv
c3MtdHJlZSBkZXBlbmRlbmN5IG9uIHR3byBTUEkgcGF0Y2hlcyB0aGF0IGFyZQ0KPiBxdWV1ZWQg
aW4gc3BpL2Zvci03LjE6DQo+ID4NCj4gPiAtIGZmZWY0MTIzMDQzYyAoInNwaTogYWxsb3cgYW5j
aWxsYXJ5IGRldmljZXMgdG8gc2hhcmUgcGFyZW50J3MgY2hpcCBzZWxlY3RzIikNCj4gPiAtIDQ2
MzI3OWU1ODgxMSAoInNwaTogYWRkIGRldm1fc3BpX25ld19hbmNpbGxhcnlfZGV2aWNlKCkiKQ0K
PiA+DQo+ID4gVGhlIGRyaXZlciB1c2VzIGRldm1fc3BpX25ld19hbmNpbGxhcnlfZGV2aWNlKCkg
d2l0aCBtdWx0aS1DUyB0byBjcmVhdGUgYW4NCj4gYW5jaWxsYXJ5IFNQSSBkZXZpY2UgZm9yIHRo
ZSBzZWNvbmQgY2hhbm5lbCdzIGNvbmZpZ3VyYXRpb24gaW50ZXJmYWNlLCBzbyBpdCB3b24ndA0K
PiBidWlsZCBhZ2FpbnN0IHRvZ3JlZyBhbG9uZS4NCj4gPg0KPiA+IFdoYXQgYXBwcm9hY2ggZG8g
eW91IHN1Z2dlc3QgaW4gdGhpcyBzaXR1YXRpb24/DQo+IEFoLiAgTWFrZXMgc2Vuc2UuDQo+IA0K
PiBHaXZlbiB0aW1pbmcsIHdhaXQgYW5kIGlmIEkgbG9vayB0byBoYXZlIGZvcmdvdHRlbiB0aGlz
IHBpbmcgbWUgYXJvdW5kDQo+IHJjMiB3aGVuIEkgc2hvdWxkIGhhdmUgdGhhdCA3LjEgbWF0ZXJp
YWwgaW4gbXkgYmFzZSB0cmVlIGFueXdheS4NCj4gDQoNClNlZW1zIGxpa2UgdGhlIHBhdGNoZXMg
YXJlIGFscmVhZHkgb24gdGhlIG1hc3RlciBicmFuY2g6DQpodHRwczovL2dpdGh1Yi5jb20vdG9y
dmFsZHMvbGludXgvY29tbWl0LzQwNWY2NTg0ZDdkMGZjNDY1MzRmZDM3MGUzNzQ2MzAyODNkZmZl
NjANCg0KVGhlcmUgd2VyZSBzb21lIGNvbmZsaWN0cyBhbnl3YXlzIHdpdGggdGhlIGFkNDA4OCBz
dXBwb3J0IHRoYXQgd2FzIG5vdCBvbiBteSBsb2NhbCBicmFuY2guIEkgYWRkZWQgdjkgaW4gdGhl
IG1lYW50aW1lIHdoaWNoIHNvbHZlcyB0aG9zZSBjb25mbGljdHMgdG9vLg0KDQpSZWdhcmRzLA0K
DQo+IHRoYW5rcywNCj4gDQo+IEpvbmF0aGFuDQo+ID4NCj4gPiA+DQo+ID4gPiBXaGlsc3QgdGhp
cyBkcml2ZXIgaXMgbWFraW5nIGEgZmV3IG1vcmUgYXNzdW1wdGlvbnMgYWJvdXQgdGhlIGJhY2tl
bmQNCj4gPiA+IHRoYW4gSSdkIGlkZWFsbHkgbGlrZSwgSSB0aGluayBpdCBpcyByZWFzb25hYmxl
IHRvIHBvc3Rwb25lIGFueSBoYW5kbGluZw0KPiA+ID4gZm9yIHRydWVseSBzZXBhcmF0ZSBiYWNr
ZW5kcyB1bnRpbCAobWF5YmUpIHNvbWVvbmUgbmVlZHMgaXQuDQo+ID4gPg0KPiA+ID4gVGhhbmtz
LA0KPiA+ID4NCj4gPiA+IEpvbmF0aGFuDQo+ID4gPg0KPiA+ID4gPg0KPiA+ID4gPiBDaGFuZ2Vz
IGluIHY4Og0KPiA+ID4gPiAgIC0gRHJvcCBmd25vZGVfaGFuZGxlIGNsZWFudXAgcGF0Y2ggKG5v
dyBpbiBqaWMyMy90ZXN0aW5nKQ0KPiA+ID4gPiAgIC0gQ2xhcmlmeSBiYWNrZW5kIGJ1ZmZlciBj
b21tZW50IHRvIGRlc2NyaWJlIEZQR0EgYXJjaGl0ZWN0dXJlDQo+ID4gPiA+ICAgICAodHdvIGF4
aV9hZDQwOHggSVAgaW5zdGFuY2VzIHdpdGggYSBwYWNrZXIgYmxvY2spDQo+ID4gPiA+ICAgLSBN
YWtlIGZpbHRlcl90eXBlIGEgcGVyLWNoYW5uZWwgYXJyYXkgaW5zdGVhZCBvZiBhIHNpbmdsZSB2
YXJpYWJsZQ0KPiA+ID4gPiAgIC0gUmVzdG9yZSBkZWJ1Z2ZzX3JlZ19hY2Nlc3MgZm9yIEFENDg4
MCAodXNlcyBjaGFubmVsIDAgcmVnbWFwKSwNCj4gPiA+ID4gICAgIGJhc2VkIG9uIHNhc2hpa28n
cyByZXZpZXcNCj4gPiA+ID4NCj4gPiA+ID4gQW50b25pdSBNaWNsYXVzICgzKToNCj4gPiA+ID4g
ICBpaW86IGJhY2tlbmQ6IGFkZCBkZXZtX2lpb19iYWNrZW5kX2dldF9ieV9pbmRleCgpDQo+ID4g
PiA+ICAgZHQtYmluZGluZ3M6IGlpbzogYWRjOiBhZDQwODA6IGFkZCBBRDQ4ODAgc3VwcG9ydA0K
PiA+ID4gPiAgIGlpbzogYWRjOiBhZDQwODA6IGFkZCBzdXBwb3J0IGZvciBBRDQ4ODAgZHVhbC1j
aGFubmVsIEFEQw0KPiA+ID4gPg0KPiA+ID4gPiAgLi4uL2JpbmRpbmdzL2lpby9hZGMvYWRpLGFk
NDA4MC55YW1sICAgICAgICAgIHwgIDUzICsrKy0NCj4gPiA+ID4gIGRyaXZlcnMvaWlvL2FkYy9h
ZDQwODAuYyAgICAgICAgICAgICAgICAgICAgICB8IDI1MSArKysrKysrKysrKysrKy0tLS0NCj4g
PiA+ID4gIGRyaXZlcnMvaWlvL2luZHVzdHJpYWxpby1iYWNrZW5kLmMgICAgICAgICAgICB8ICA1
MyArKy0tDQo+ID4gPiA+ICBpbmNsdWRlL2xpbnV4L2lpby9iYWNrZW5kLmggICAgICAgICAgICAg
ICAgICAgfCAgIDEgKw0KPiA+ID4gPiAgNCBmaWxlcyBjaGFuZ2VkLCAyODIgaW5zZXJ0aW9ucygr
KSwgNzYgZGVsZXRpb25zKC0pDQo+ID4gPiA+DQo+ID4NCg0K
