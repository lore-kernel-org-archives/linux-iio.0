Received: from mx0b-00549402.pphosted.com (mx0b-00549402.pphosted.com [205.220.178.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86DCD432BD8;
	Tue, 21 Jul 2026 07:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784617980; cv=fail; b=uS9sWy1eqGC0RSPDUyhvmFYT82nypFjV/RrKL4QsN2xzaZ5RezhCxD3yIR045hXYyF6WoJ8KeDouNVZqPoO5IeEEQOKNi/xILKRtMrQNLwFgcunmsIaJgFNBwSIYqEzcTPT62RgEKwAUYKEWUpzVB9sNHm9dLo2NjDsHZdzG3T8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784617980; c=relaxed/simple;
	bh=ySPr+UQ0aoYyJNIJLx5yKweljFyxoHqIB14SAtxkvfc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sxBuShMQ4k9pZv8ULmUTojX+aRihkY+B9H9b0o5y2G11ZOgP+Xy/6qwNHyF5MYGQRzxTqmpKUXzZQ+yF2dlQmv03JM8eW9pv/Fhp+bi+SDTNrHbWNovDRB9MKGmsied4DAn2u8HuDlrxRj8ODe/mKpatAyPao4pVPK39rSXfTi0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com; spf=pass smtp.mailfrom=tdk.com; dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b=ehfdc0Wj; arc=fail smtp.client-ip=205.220.178.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tdk.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b="ehfdc0Wj"
Received: from pps.filterd (m0233779.ppops.net [127.0.0.1])
	by mx0b-00549402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66KNDiWp2727438;
	Tue, 21 Jul 2026 07:12:40 GMT
Received: from fr4p281cu032.outbound.protection.outlook.com (mail-germanywestcentralazon11012063.outbound.protection.outlook.com [40.107.149.63])
	by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 4fg2uh2215-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 21 Jul 2026 07:12:39 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=inHq1YHCE9utBDY4FHvZ8HNHj+2nPmHZlXJJlV9CwNOUHYb0q3l8JUvzd4jW/WJ4/As4ef6h958KO+4mT8wu/WDavBlLwHKrTxyPF1ZGOYiwlBKfb7ThcCYXRCcy+/QBFiIKsYrJvTpB4Svsz1yNDcHUwi6aIeOnavLoP1hXhOQhjzPnUbIjrfJYXW50G+TP1XtMHCe2v8e4eTVlujlYwjYraBcT5ezfYyAAGxe5H5nMNuG/2lACIjEVV1cDsgHFqJuScaR1h5oT5hCpI4hb+ZjSs4dYP2ULixJ40rVVFB6xSwoIM5/qdkMxUj6dNjhnx/99z8UVyvX/BoVKl+RNrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZYfQalH6+VZILPxtzyVGpeWR1cLGo4V6zLBXQzkmRVQ=;
 b=VulAnp4Ekd9XnuPmfwa/nmOOAJpxJO4VkJ0pUUgbpZwwepkfod2qYwEsjCMYWbPGENBPIx0hAI5/2qmee+YQAxgr7byfxqVgV8CwMqFdOdhQVnPwUxVEejYe4vzQFouad9n54s8YZ8upy3ykKEgRGB/dZfLeDVPmrDNY7u4Tg8u9l9B1wdVlt9HdH2zPVY0Y/fzz/tLLrZBLDvVh1xZxnIl19hVAY2htekZOOxtPwmi49roPusr/wbeIwG8kNJ6vk8AV+BBMBe/lJWyQm5zUQOOzIFW3xeUfyac/1OY8XPSqVPZz9uf77xhs7PJ8oXUJnZeQ6xYcH8t6d2hq62cXwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZYfQalH6+VZILPxtzyVGpeWR1cLGo4V6zLBXQzkmRVQ=;
 b=ehfdc0Wjc9b5pAbt5e55dpFIN4KtD/d3wvotInmai1vW20q2bRg00a3D1pDS9b+4ACUp9urY9MdrT0a70HpJBotAVPIfYkuaUTYB1ecKhDgVlvHa6BRtccur9nFLQxs6tnITuRNYyhv/Wcfd4PEnwjNqjfaz156C2Y6+3FdXempwoOg5eWaacIwusvLT8x+rTJUDJuDxwYkzUwcoprYTNGl+OKpxKQ0QwhIpy94i/pLyEz0ipWGTIMdgSVhJLFo5J3YKfYG/K/Cfe2vSyFplO+cc9XIK2qiW+bF9ThT0+0zvfe/kWlFg3KFTJcl+tWkv7zY2mdkMtD5kXiehRBkjLg==
Received: from BE1P281MB1426.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:19::10)
 by FR2PPF5FEF8EFC0.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d18:2::42) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Tue, 21 Jul
 2026 07:12:30 +0000
Received: from BE1P281MB1426.DEUP281.PROD.OUTLOOK.COM
 ([fe80::9d4c:26bd:ea0d:b04b]) by BE1P281MB1426.DEUP281.PROD.OUTLOOK.COM
 ([fe80::9d4c:26bd:ea0d:b04b%5]) with mapi id 15.21.0245.009; Tue, 21 Jul 2026
 07:12:29 +0000
From: Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
To: Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>,
        Jonathan Cameron
	<jic23@kernel.org>
CC: David Lechner <dlechner@baylibre.com>,
        =?iso-8859-1?Q?Nuno_S=E1?=
	<nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Chris Morgan <macromorgan@hotmail.com>,
        Luca Weiss
	<luca.weiss@fairphone.com>,
        "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/2] iio: imu: inv_icm42600: add support for icm42630
Thread-Topic: [PATCH 0/2] iio: imu: inv_icm42600: add support for icm42630
Thread-Index: AQHdGG4Peqsrzf2zNE6pfG/Ckw1cFbZ3inHE
Date: Tue, 21 Jul 2026 07:12:29 +0000
Message-ID:
 <BE1P281MB1426D6579C0E2709574549B6CEC22@BE1P281MB1426.DEUP281.PROD.OUTLOOK.COM>
References: <20260720173411.82979-1-jorijnvdgraaf@catcrafts.net>
In-Reply-To: <20260720173411.82979-1-jorijnvdgraaf@catcrafts.net>
Accept-Language: en-US, fr-FR
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BE1P281MB1426:EE_|FR2PPF5FEF8EFC0:EE_
x-ms-office365-filtering-correlation-id: 28d34aaa-3460-4c31-4617-08dee6f76ce8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|19092799006|366016|7416014|376014|1800799024|3613699012|4133799003|3023799007|38070700021|56012099006|11063799006|5023799004|10067099003|18002099003|22082099003;
x-microsoft-antispam-message-info:
 oN9pyInvrMYEN8h4Haom69J6qZtHIKKILPkSIWnbgtXByu5zV9FFW/vzKhwPUgmL+7lxs2yKHPCuUeZDJ/rZQ4/2VZLU14ltxcE44ayuU4VN+VyiMXL8FRRiwiN1f00+jxkk2ce1Suw5tLRWys4A0Fl7rRCgvX6vo4s96dOAdzfD7SnfxSFKjNCHaVFSkz9q1H3RKlfSr1OksxvSF9IxOsTmVkazxlSFXtWdlh22r0kYRuFWgpQSIHdwxQUUIOPMmeN0lkvXKPovcJOdkgfFaFqzc/nl3dF2aKRnRCsooxXqPAUnRDHGLSRfNjN1FeLKbLNwAtHriPl8w/QypMhgQ+uH8+H+RXxbN07LNIwMlLHZ7psNjyQ33Qnbff6CdTPsTZIMj93O93f909Esk4Hkyzm32Kb2d0ycL6jwkRDqF1UncRonElsfHdr+rkg567HsTUEBddg0mLKV2DcUanCV5N0ae+ONhknkk+8MjCaVPrRzXBwiJi7WhN3T3iJYRLG1R0B67xRNU0UPYnlv0MwqJkGNdaC4m7uxQ+kjKkPppfbHTDfH7hUatjYSeBwW0Z5B9GahEi3deNS/a8dwPu19wCkCrQQ9wD/gOb4jhV1rNCCVYT3gmp450mXUIPpgxv7RhaTaii8ZUjPNRtIk+k3gIBayb1CLgmf2sZ9oPxXBogFkMeMdNxzY8RZyJUNxRwyUE7ERRq6aWXx2JOYWIh0ZXUP8/uRQgPbCAkTBQcP2sWvp8xhLuF2vHZSC1QtI2Ukc
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BE1P281MB1426.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(19092799006)(366016)(7416014)(376014)(1800799024)(3613699012)(4133799003)(3023799007)(38070700021)(56012099006)(11063799006)(5023799004)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?d3xTUog+FB5CljC+z4ZZeufnS/WRdAHTeyANlEeJA2sBPKPHUI1ZeUdZwQ?=
 =?iso-8859-1?Q?fBMCdkRyt3uyWBElKWgEk5LmsaXzyM95X5IOSGZFqKehNTferR87p5WnQi?=
 =?iso-8859-1?Q?DD4QlVoRrNeIrk5QCpU5Zil5Gtspef+hdG9tlwxXuxgAtBxz53J6ZSpcP4?=
 =?iso-8859-1?Q?kNsK55VPweNZQ88npvVwDRDJaG2IDDW61zp6tnHGdGL6hCGl4DFRyCNVs7?=
 =?iso-8859-1?Q?wRYe5t8mHzEZwxE34tehJ6OAemqeVJKwTcDJBcVyPUTDBLGc+Q72REVhaC?=
 =?iso-8859-1?Q?xixPAvsHI4E+cZVFLBwBEgSgDDIiNDbX7kf18xHH+4VX2WstkeciWjQcgY?=
 =?iso-8859-1?Q?nZizlO5e257N04/zVKEfoJBTCuhPmYwCNoVrJqq6Gb31J4kkPr3fGhHOkL?=
 =?iso-8859-1?Q?GhkttsSQLNJXbb2PZFEEHAlCu3xyHsxSTfBwYZBiWs3pBShclakQTCzz7o?=
 =?iso-8859-1?Q?bZxby9nnndiIw4q1XfHKznCdJTntzXr09U42AqGmKB3jebIaHkj+qdwey0?=
 =?iso-8859-1?Q?jln/jiVcyvpPW6IZLCfJh9As3yLA5O1zIo5YVjxtGEP4En0xwXZOptrUXY?=
 =?iso-8859-1?Q?jUCCrdVs8e1VwMCcsXCYcYXdCQ5rYxzv4vtxass9DvzHy5U/27d8neqkUj?=
 =?iso-8859-1?Q?2H9p3mhKRDYctqybqn8Ncqoof/6LVa4LEvbemA9SW6k2e8JeigAKSuUqZB?=
 =?iso-8859-1?Q?5BVWaZi0YE219xaJkj4lYu1QTUFTbyOSmlbezeo9pt+WuLPp5rpFMJGhE3?=
 =?iso-8859-1?Q?KHVE42u07LKY64Lrd5dBCpRKS1x4Oo2y6MRshqU1bmkQQ2oyZBNJGRsNrz?=
 =?iso-8859-1?Q?tEBU/nQgOr1dGpAGW2pYxHVXyePMvJ+UE+62EmY83KYX7EHJ6dVZYVDCen?=
 =?iso-8859-1?Q?pyyY/Xb4wZqvmhrCPoP+Ict9+iNmFnUXuvbtmnoMNZj7S5XzRW8heCRWMg?=
 =?iso-8859-1?Q?eJjohvXdwgn11w66kG24kWn4P7PSHIzDDkWb3HL7lV5uaoAjWjyQKXsh+C?=
 =?iso-8859-1?Q?vVDkdgq1fLAYFq1BE+3Q9z7+DY5pxcWXoZUVdebOoSCp3PJI33U23YuhSb?=
 =?iso-8859-1?Q?RjaYeooLb3FajfQEat+ERhPmBPK241hlbZ8dznKwXm2D+JN8SuRHa4PJiR?=
 =?iso-8859-1?Q?nlalRPjVlslngGCUoJvmgp7jQyGIEQE6J77RBqLvMf9/DP/i/k/oECLegE?=
 =?iso-8859-1?Q?6f7Dtrm+tsZYnDXjXkUaqA7RAxtASnhlF96Ln+IEe7169pqsxEUXEU9B00?=
 =?iso-8859-1?Q?eQgeI5hze13YO4l0BUbtw284CYG7Iaj5K0kILr4cPLhcOfADi8qr/R+h4Q?=
 =?iso-8859-1?Q?mKP7iZ4Id6e6RbN+vfevQxv1tmQaqqeI+H+A3d5uR9wKnUsQgY9/lkM+rz?=
 =?iso-8859-1?Q?tJwa+sFHZnSSE22cQSVzN6uow8uiBlK9f3zWpIdp8UnI9xyMNKoycBHDPI?=
 =?iso-8859-1?Q?1nurMncRGk0DuBTg4kSduo0VvzJWWunQl1GGr7Iwin1J/jQ4ctyLBwClrM?=
 =?iso-8859-1?Q?Y/yW1ororKuapfZMY64u426NquvOoOCYerS+8jAJtAEI/adyuYIlmFtjgX?=
 =?iso-8859-1?Q?Fsvsw7IvRpMGgcX1lKMN0iJya1OYTBvn8sxNPKS/mpd2H5Oa4Wne6HkxMz?=
 =?iso-8859-1?Q?svmdPX29XKOcSYgZhwpQtDRRcbS5YpZAgSI39a5XxlVssQKmwxvx+S6E6+?=
 =?iso-8859-1?Q?LTR0xb2vGYulStLnPoWY8gYHjo/Amm9AgzzX3Nm6rW0FKTfHBaGW2CsOZD?=
 =?iso-8859-1?Q?ztHi0xmoJhS50e/qxyS90sT46cd61SJWZ8YhyZmzMxkAWHL+ZDVN6DF+I+?=
 =?iso-8859-1?Q?ZkFvR3gB1T43c4kAbf676L/tQO3Ae/U=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	mpEpwicSL9c73fHFqH/O9jvchSGCZkfJSYL6n3MvW8ra4g2eAapfYhOKHvT+GUf/NbBuZyb0bRvd5VB16r+sl+oBxXmZMeHRUIZWbp4O4qjIlHuMxS+CEt0N57tH7zKZjQe2x+RTkunr9NvauPG6dCkO09no6vVWsYCYnhiZwxql80jnboQHGKJQzNJUQkuE86lFmGSXN3x3YAahR0lx0UrZ5jW8qc2MWmJYF7oM7iZ3ARHpkSS7Qhhqatc+xzdDZDXGdjlw5QCn9bUT2UHuHpSym/N7gGRB1+HMdK9xGFY0cXS1ZXOwSOSqrJdXAIA7pCzLQct0PjogAi5karyIjg==
X-OriginatorOrg: tdk.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BE1P281MB1426.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 28d34aaa-3460-4c31-4617-08dee6f76ce8
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2026 07:12:29.1301
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p9zdqD5HC8X/PSLUiOpQtFDG/T8dDz31uZnTrx0s+1zPRby3DKqmOb9A1/XQuKb39eO1iwxcbkXqVafKTl1Lr4rwf+m5qrNamhjqXPcLLhw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR2PPF5FEF8EFC0
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDA3MiBTYWx0ZWRfXxK6kY8bIikBa
 nqj4XEdNE1DKFQl1WoaI/ZsYDmaDAY5LGcfHWxmPrD3ndE3G1CAD3CqBiZrlWVgD8hvwFS67zNJ
 XrKwgE8Cq4oUrym/IROep6jSxeN1AbNEvGhXnEExsREkwhjMTrAZbQrUnwj1XB4T+7pXCJKvv4U
 UbfjGKMP16S3DVQeroN+8hRdM0gRnsMKBECDYMVhkPmUFGMLYWDH7cfH0bLWOu75biF+C6NjuO1
 YWq4sUBsdWNTJxFjQ6vEdZoQ7/czh7qiuxpdqfHvsDM44f2WloAv45DY4IYxtmEJMMY/aMJCjbD
 bfP/tOEI61hMOxTE7/vwFg1/FLGHSlhdGpSHJvOT9w4O4ECS+EdJmU+aCCVgk4UGr6epnitqhBb
 psyXNJxHBWMwaS7GigJN6Mqv0WoMBBsXzh8Tf0D5hvCLm/5B0RrVxT9suCg8WROapVYAoEHr+9+
 yE7M6NV19y9yms6eXqw==
X-Authority-Analysis: v=2.4 cv=Zr7d7d7G c=1 sm=1 tr=0 ts=6a5f1be7 cx=c_pps
 a=d8sME9E3Ij9yFzms60kPTg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=RAioF0-LDSMA:10 a=Uwzcpa5oeQwA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=W6z64dnQKVPvYeLC5f8l:22 a=NpUDEC63da1vOGE9rZHW:22 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=GYSh3LzNAAAA:8 a=O0CJQudldPd8atX-c0QA:9 a=wPNLvfGTeEIA:10
 a=lWcdFasyL5yHfcDTNXXo:22
X-Proofpoint-ORIG-GUID: iQRmO5KPGmJvroMbLUggxpQQGk4h84zx
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDA3MiBTYWx0ZWRfX1nim1XAqjMXQ
 x7ZRooktmCAfyb2QDlEQA8Pc7E8ZBHm/NfrPQFFIsl+oECaACl4ZhHWzWG462JS4wwvEcv5tYzC
 9JlXWXUlRC6Y1DHJATPQ3KQQKUiYla7LZU4GlnV5k7kQR+e0DUlv
X-Proofpoint-GUID: dy2AuAn8JaWLyQegT9sx4dnBTGSsEIAt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_06,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0 impostorscore=0 bulkscore=0 adultscore=0
 lowpriorityscore=0 spamscore=0 clxscore=1011 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607210072

>________________________________________=0A=
>From: Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>=0A=
>Sent: Monday, July 20, 2026 19:34=0A=
>To: Jonathan Cameron; Jean-Baptiste Maneyrol=0A=
>Cc: Jorijn van der Graaf; David Lechner; Nuno S=E1; Andy Shevchenko; Rob H=
erring; Krzysztof Kozlowski; Conor Dooley; Chris Morgan; Luca Weiss; linux-=
iio@vger.kernel.org; devicetree@vger.kernel.org; linux-kernel@vger.kernel.o=
rg=0A=
>Subject: [PATCH 0/2] iio: imu: inv_icm42600: add support for icm42630=0A=
>=0A=
>The TDK InvenSense ICM-42630 is a 6-axis IMU of the ICM-42600 family, used=
 in the Fairphone 6. The existing inv_icm42600 driver drives it unmodified =
once its WHOAMI value is known, so this is just the compatible plus the chi=
p id / WHOAMI table=0A=
>ZjQcmQRYFpfptBannerStart=0A=
>This Message Is From an External Sender=0A=
>This message came from outside your organization.=0A=
>=0A=
>ZjQcmQRYFpfptBannerEnd=0A=
>=0A=
>The TDK InvenSense ICM-42630 is a 6-axis IMU of the ICM-42600 family,=0A=
>used in the Fairphone 6. The existing inv_icm42600 driver drives it=0A=
>unmodified once its WHOAMI value is known, so this is just the=0A=
>compatible plus the chip id / WHOAMI table entries.=0A=
>=0A=
>The part appears to be a mobile SKU and has no public datasheet. The=0A=
>name comes from the Fairphone 6 schematics and platform documentation;=0A=
>the WHOAMI value 0x0C was read from the hardware over both SPI and=0A=
>I2C, and the chip's bank 0 register defaults match the ICM-42600=0A=
>family layout. Jean-Baptiste, if you are able to confirm the part name=0A=
>and WHOAMI value from the TDK side, that would be very welcome.=0A=
>=0A=
=0A=
Hello Jorijn,=0A=
=0A=
I can confirm ICM-42630 is the correct name and is a chip similar to ICM-42=
631.=0A=
It can be supported by inv_icm42600 driver without any modification.=0A=
WHOAMI value is 0x0C, that's correct.=0A=
=0A=
Thanks for your series,=0A=
JB=0A=
=0A=
>Tested on the Fairphone 6: patch 2 applied to the device's 7.1-based=0A=
>kernel (with the id-table hunks adjusted to that base's style) drives=0A=
>the chip over a bit-banged SPI bus with INT1 wired to the SoC - probe,=0A=
>accelerometer, gyroscope and temperature raw reads, all full-scale=0A=
>ranges, multiple sampling frequencies, and watermark-paced FIFO reads=0A=
>through the INT1 interrupt. The accelerometer full scale was cross-checked=
 against=0A=
>gravity (~2048 LSB/g at the default range, matching +-16g); the=0A=
>+-2000 dps gyroscope full scale is inferred from family membership,=0A=
>pending confirmation from TDK.=0A=
>=0A=
>The series is based on iio/togreg (base-commit below); on that base it=0A=
>builds (arm64 defconfig with the driver as modules, W=3D1 clean on the=0A=
>driver directory) and dt_binding_check passes.=0A=
>=0A=
>Note: Chris Morgan's in-flight ICM-42607 series [1] adds entries to=0A=
>the same binding enum; the overlap is context-only (different lines)=0A=
>and trivial for whichever lands second.=0A=
>=0A=
>[1] https://urldefense.com/v3/__https://lore.kernel.org/all/20260716182637=
.24310-1-macroalpha82@gmail.com/__;!!FtrhtPsWDhZ6tw!EMkKQset9Yby2oKxW0kPzUU=
w-xO1e0Se0_ponfx9sVFHe3ZpNkToWE9hCbKcOrvaXMEPxCQChCML3qSGp08krxDg7tbXgqqw_Z=
FV$[lore[.]kernel[.]org]=0A=
>=0A=
>The Fairphone 6 board DTS nodes will follow separately via the qcom=0A=
>tree once this lands.=0A=
>=0A=
>Jorijn van der Graaf (2):=0A=
>  dt-bindings: iio: imu: icm42600: add icm42630=0A=
>  iio: imu: inv_icm42600: add support for icm42630=0A=
>=0A=
> .../devicetree/bindings/iio/imu/invensense,icm42600.yaml     | 1 +=0A=
> drivers/iio/imu/inv_icm42600/inv_icm42600.h                  | 2 ++=0A=
> drivers/iio/imu/inv_icm42600/inv_icm42600_core.c             | 5 +++++=0A=
> drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c              | 4 ++++=0A=
> drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c              | 4 ++++=0A=
> 5 files changed, 16 insertions(+)=0A=
>=0A=
>=0A=
>base-commit: 036d96ceec6d966339aea34d034420991e24cfac=0A=
>--=0A=
>2.55.0=0A=
>=0A=
>=0A=
>=
