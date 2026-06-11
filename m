Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 028FF341068;
	Thu, 11 Jun 2026 07:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781161495; cv=fail; b=ZMPRNTs21A4jlGPFb766QLFh2a8gTI/MWlnv6/p4dm+vQ9g2UiW1y6cm2tK44PwijoTtnb9Yi5I1QYxOSyu1XjmBC2xYXGNgptKp79O44mS78K/1Dc49Fn7+hbBMHcC40Va2Uc4WvRn7XlicEhItH9kJQSz7UR4JO6zppxXEEjA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781161495; c=relaxed/simple;
	bh=sEedd50zc3u8ln6mZ6dgGy+UvxngLNGXEsFHrV1K+jk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hXdIHmg8pYFeZNereSd8dITlavimsY0j3NOlJwWZ5Q6T9bdOk+Z+Ym1r6SGXkly3Ibfrt4iA0IIXESql/BJ8Duf/+KjnIRCUKkcCcLMr70yIAezpOSFnIWfTDsehEbwRVWNA7bfmf8Qw6xruKQxxgsnv0mXuv+BKY47PIt4c//0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=jLAG3DIa; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="jLAG3DIa"
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65B0R0kF795496;
	Thu, 11 Jun 2026 03:04:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=lg2sg
	kS2bbEFgC+XPnMYIYUzIoY2DdWGN4kGzPgHUJ4=; b=jLAG3DIaQLKLmLBhcMoic
	eqIhrmd47Py1H1m1Fb2niIzph7irJElJMiuo2tYH8D8m4BxpJwYZEJn0xaVvDlI7
	FK9OqvqKCRPpNSBlvIpyiWyX0Fo9LykaL0HoFqukKg4wqSVunoW0+9XV0gEs9LaF
	AI9gFHsHI0oTkLFWJdFMGVUD0FacyVL6c3rn0dqLzpYljWv9LmBS0BSDdux+mbqr
	fDH5C+FgJ8AiaEJm1LLK1Hz9hg528mgGETy8xifr5+Rj+gRK9j7Q3IyqBdlsgn5p
	apFQHrbTMLn+ZKVmeq87mRWBdG8WFBhpoZ9zor7HepzK/6t0DczL/hn7MXOOQBtj
	A==
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010045.outbound.protection.outlook.com [52.101.85.45])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4eqe64hsjb-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 11 Jun 2026 03:04:40 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fAEDFAqSD2witLXQTaGU4DWjZVkfCG0TCJRCK4HZmYg1Lpe2TDyKnNwESIuO4W/rsS8j0VDF+8PgRDB9MnEnP6rE7A+dc8I1JO6/fpiqtcb337LwbHpUZF0St8XVuoCPj3HRNGwHJ1fwDvTRRCs+DcCb2ARG9LcoSpSIf2ie+oRw2SpJkStpvnHxzeARlFCxszRxSHva5Bx2c8vbOynN+Lzz+W32EadyKN3e5FroUl2EpQv2sSWz7+9kSEqd6mn8hDuqHTFpnhuljAuCoTCILH2PG7aTTNHKm7UaWX0M6FbUdGcVH4jSC1/7VxbUmxK44O5MlqCTZ7LOI0wshyHdIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lg2sgkS2bbEFgC+XPnMYIYUzIoY2DdWGN4kGzPgHUJ4=;
 b=IeujFdoM2q/RAtHcRO3N/l5QI9YyBAMW7uuPEda3L6Kuhsj+3HNgwA5WIOICU77/xJ66l5i0x14wbhdeUGZlsRFhU4m7kxNxxGXBjG2XkXixZ6GV0IsSHBNoptNBjbXCf3EeZjXQ3YAFBEYNH4pFJlsfDTVDdsjifX9Qv0pjMZyphM1vLAQDcdW06KwpjVFh/FvWLSUVZblupf8HHX9JasWcn7ZEIIiVkqeUJVvcJ9XELP4SulUQ6ZoGY9WCtzQf6+D+dlOB4GF2PoR4ArKxQTSLie8PrtIl/6Q6xb7vQe8S+LC6VPnM1StWOUGpfZGJaMB8Hc8v2dO0/eoMzvTHFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from SJ2PR03MB7139.namprd03.prod.outlook.com (2603:10b6:a03:4f4::15)
 by CH2PR03MB5334.namprd03.prod.outlook.com (2603:10b6:610:92::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.13; Thu, 11 Jun
 2026 07:04:37 +0000
Received: from SJ2PR03MB7139.namprd03.prod.outlook.com
 ([fe80::dc59:11b7:6a0a:891d]) by SJ2PR03MB7139.namprd03.prod.outlook.com
 ([fe80::dc59:11b7:6a0a:891d%5]) with mapi id 15.21.0113.011; Thu, 11 Jun 2026
 07:04:37 +0000
From: "Paller, Kim Seer" <KimSeer.Paller@analog.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: David Lechner <dlechner@baylibre.com>, "Sa, Nuno" <Nuno.Sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>,
        "Hennerich, Michael"
	<Michael.Hennerich@analog.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux
	<linux@analog.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH 3/3] iio: dac: ad3530r: Add support for AD3532R/AD3532
Thread-Topic: [PATCH 3/3] iio: dac: ad3530r: Add support for AD3532R/AD3532
Thread-Index: AQHc8/HbpJMT0HDwz0SWh/UxVduFV7Yv9WEAgAkB2eA=
Date: Thu, 11 Jun 2026 07:04:37 +0000
Message-ID:
 <SJ2PR03MB71394BC5D4E680A96F950732F91B2@SJ2PR03MB7139.namprd03.prod.outlook.com>
References: <20260604-iio-ad3532r-support-v1-0-c3552f9031de@analog.com>
	<20260604-iio-ad3532r-support-v1-3-c3552f9031de@analog.com>
 <20260605142428.5cd21b26@jic23-huawei>
In-Reply-To: <20260605142428.5cd21b26@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR03MB7139:EE_|CH2PR03MB5334:EE_
x-ms-office365-filtering-correlation-id: c98e3e22-f4a4-4186-6ba3-08dec787b32c
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|38070700021|6133799003|18002099003|22082099003|11063799006|4143699003|56012099006;
x-microsoft-antispam-message-info:
 NMAn0HeegM4HZc/QC8/l5ZLRdm3ZkDYpc/4/LUGsXXIjLyS6TN8qK0MebArC4G5vvJtfUYBQd2z8hMfcLDLnT4L+8yLNZeN8xWYBZ5eFVO5aYgXvG/x6SDM+xfo2e3uPX8fxlBHYxDSv3b+UM7uYpL7wp2kW3FrTq7S0+s1+B7dBCKxgPr2UOGowXUjBX5FiSpiALXM9ehjgmxacAHKm7j6SSeHHlQNJfsNd2AmSFwrM+YdRZkJUz2qcKpSpRF5DjR1NRexMNoGXPN+KmfjGPdAewE/jqzct9Yqnr1JUkEwy9Ujq/YUxqW5P6NMtbKeYd4Mu5yLIkDs67hGrCOr8tvR3yqSvK64LoTvLwnkQ7AgrXMIIRKAXhB+TUBe8oOe/agqa9FgImTVm3V9crEH0YV/8DodsMi9ncJ8QhqnZ6IlyAR8WdHjieAj6otUYWlOV7N7BkISzBO+DuszQ2QUkKhPwsdG8VAZUBVQVJf+cIWNYJCBq+wZL+3LM1hNw6U/neR8aRGBYAwbOctpUK2cgDAzgQ/b0oOpbQZhLWHJYvHHmOUgIJs7sdB/zsH01b3S/MnolVThMZDkcrf1ONn5DUD7l4t8cOE4XfsnzIfV1Vpzi0B7GNiORuP+fQySsc1sSfDghR3QZ5hKKMW21GKp5yqbxBhTCte6iRPZgr3Cht3Em5MqcptAR2mRm1uYC5RJd0K3Cp53dTE12sth8pPtKUrl1XNTbFcaHMOYW4QWb6U0iny+b6/ILR1CawRizFeWL
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR03MB7139.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(38070700021)(6133799003)(18002099003)(22082099003)(11063799006)(4143699003)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?DnSrPeGhDLD5x19H3EphM0AySHtbS2jl7LE25av7TISGB7LNfqVIWW/rN1Fq?=
 =?us-ascii?Q?U2d6V89+4lSEJtU0QKiI2K09MnKHKl6x/tQPj2UVRatss/pro1gtPz7EoeDJ?=
 =?us-ascii?Q?W7VOt/ghlLalj9Wbo7Srx8sYNsN69uc3/Y/RThB30GR0Kyo0zUZBsVbqJpoz?=
 =?us-ascii?Q?SOwBDWmGqSM3k0w5KXualHM9YNmYug0mIqi4fZT5bVJiNuY7x3hdyWBA66Z5?=
 =?us-ascii?Q?VEBWhBnlBgpSz095jl8AXlY+BrBormFeeyS0cCd0aotOMLUIrMSYEMhoZ5kK?=
 =?us-ascii?Q?3pm5dYIwE+gxLuJn6eCeeUteQ13FqUfSytwKgTPOa9DfTNcvpzLaJyaTXrWN?=
 =?us-ascii?Q?2DmaEt9D1P5TBc6QfTnLPwo0SILNjPdfGec7Nuu5oczuu7cHRUB47V1iGj5X?=
 =?us-ascii?Q?aexf6QY3GK2/7uUMxlsahSHAcYcf6FcCE/8f+aUASDHt8eMJEz59v7uPe+MS?=
 =?us-ascii?Q?S+6h2ukGpCYpEU4246UOu5jDHOEoIC01+L6srDpwY92qG48hJSsPH9IAVCyK?=
 =?us-ascii?Q?HO+BpuejeqkXxJNGZgg6DTdbICqBdDwOeiVqiQX97WcClxJsLbEGKYxBKQkt?=
 =?us-ascii?Q?wchM3+nqe929TA5JVo07ixxY8dDHGntmcpyq/cdaH/0TLcvZABzb+TBM7kON?=
 =?us-ascii?Q?NV40QulWma40btSfhzyzEgSUQ4cJSerRvasxT2dwoXnxeNsUYUuGlUv8l//0?=
 =?us-ascii?Q?8x3u5I0NELiBlq7QyjbA6At4SH4w1Hg29Rl61CxehKvzNwM9GDv3WH6Al4IT?=
 =?us-ascii?Q?zAjwWN+3/YE3EI1hf2UswY6mO+VYY2WKGrajyW8OmeJJUo77bmzSv29yiqxo?=
 =?us-ascii?Q?ML3iFTc7fkhjW5MzJxccWuehJIeZWjef6Qtg6G/K4NhNvYE+FSvImOzXJywN?=
 =?us-ascii?Q?6rQ54yn2AIp9W7SC+uw9I5qinbcdhk1kDwwkBeUNAvig1w6HsRxkATQ/Ah7D?=
 =?us-ascii?Q?VZzA6/9eW2rWFYdywf4EKTPQw7YVdTuRBQ4oiwHY0peN7G17yhPHDCiBywxC?=
 =?us-ascii?Q?M9d8iM8VgdTZ4wrVwErbhwpaXylHiNqbV1vrSTtMUPXc8vTQbqFeF8hWQv8/?=
 =?us-ascii?Q?lo1/1neHSKj39/+7VTJE/Z5BnOLoWkYZUNHKuOlyJ1AdMex7//7TMy/n9a0E?=
 =?us-ascii?Q?y+ahdElQK67KEbwyBYWA2b3+BT6jdSuIVVR+0I3YE09/UBpUkKI9AuBDjrwt?=
 =?us-ascii?Q?TmF5E4aKbDs2XcUNcoXDGgwCVwTBU1KP6+XvAEMHCnIQI4uuZMeAxd6EG8b1?=
 =?us-ascii?Q?WiO/lYsOU/FPLNi9J1azK0Es7O3q36y6WSzVpWrKzL1IJxZzRoyu+zLxqg4H?=
 =?us-ascii?Q?DrcdugoPQWwdx5VqNDdppLMs8cBqN5aULnsPFc4dyed9KtV5jcy6F/sN773I?=
 =?us-ascii?Q?7G6ThJiT2CFeHVFUVhUOA48ewcz6T2qNRe8ohIEWSsnRH5dRAGCttOcyoDKP?=
 =?us-ascii?Q?S2hTHAHcL3/8MltacbetMPB/ygGlaxFx4kkM1deomBcPQyM8qkgfedESkHd6?=
 =?us-ascii?Q?/wPubkvL/qU4zGnRgZN4XRQ+zfb5TcoTSNh+JSaqbZAodhoQ+TajhsHsxxX+?=
 =?us-ascii?Q?euxzZrMCS6VKv+TS236PWSrj1eUIA0YBQd44UAvrxdhfu+exbkwtBQJFPsRh?=
 =?us-ascii?Q?u30ww/TJW6hz7JBhFE2aoFhVC9ZpVSXwxMj4OLjbTsskvbrWFrrbo2/C3/UY?=
 =?us-ascii?Q?VYOFw/kz2c0LwjyWsMVuAZ8SYdEPkJKU2tKAe5CAeMwL2hcVTMw4RokE/11z?=
 =?us-ascii?Q?bgXmcP1NDg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	fq5aZWtov2acHrqiu7JLN6LYaEhugICaLKXX8+WdADL0PN/jtsBxeNCu1Vgm+HLZj0rbd0M8fpvFwzeittYL03NGOyJxcZDVSagwWDft5YdJyf1heIHoXDHFVHusRzR340apulCN0GYhU5S4zcYqfJFtQvVKomuItVcKhXBJAMA82rWtxK5Bw8PeXmEaw5vBWm/t+AUCKanv86CUdN2mFviyViah+wXxM8D9WXnhQvXqKnn14neSh0QxS3nLI3YIaEUN0ri53e/aZdfxJ5XJt/XXvCZoy/16A0o9PTbCScbp2dPHe6NYaiqtQH/PUsTcBo6NiL1Bjjt03Yt152Y6uQ==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR03MB7139.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c98e3e22-f4a4-4186-6ba3-08dec787b32c
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2026 07:04:37.3119
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zeTWW4dXUzClkm4Xv5AsGaf2PyYohteSBJtTeFy6Sa6Z+917iL0am1hPw7a140rRVyL5TVVxY421Wv86nGk/NG9RCo5l3EURRF3vd/TYK3M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB5334
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDA2OCBTYWx0ZWRfX5isMmmVfJ6zG
 RGVqXoU6veM9OuyYGWoY3YOJqpUtQSD/YPylz4Aj2NAMvbZrI61YjJCAtA6F4whyqsvQt85KyK4
 JD3NWVZBgn+8XxG1ClwdaHJ7K2cGRtyBAfNzE0IsptlCN/IehVJRyYQk3bsw5marKWTYtnS7FeU
 GoFqdz7QGVY2RHtF31hfJwyWeo3T5+RsvhZB8zUV+0EKi0UztOb4Kw1hWPxFGb7a0YwjkzoA2bJ
 WpzlL1Xor7J44De+tGgXhqZwWm47xOChu2IxJEBOiMMvAyU4th5gb0p46pogC2MRVwtGAu8YqE/
 0aMgdjRxhcp6KI4H6E1wn0q4Dn1WytcqZJwqUE2xyxK9dWilnS1uaUdRpntVV4YGCIMK+/qkUhf
 q06s9TIZWbCLixdsVasZ1wSM4WVJamam3NpXt9hM+jsTz1rxocOIaidwJ6XMj+q4jrQkqUIGelw
 i25QqopFcFAztlofPfA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDA2OCBTYWx0ZWRfXyy9d1FSHjBEQ
 DTGdMQczeG0jpK7gPNymdF/8JDZ4vBbmCNqyHUdGBJOOeGaB7X+JeqKJN/YQOCmSmz5ObRWDOds
 cSrr82rKMazo3JCokhzXP/maK759r8mSPrvUfF+OgYCuOIT90F/E
X-Proofpoint-ORIG-GUID: UtAuM1yNAI00qYESVbbAsfH_-VadMNMY
X-Authority-Analysis: v=2.4 cv=P6UKQCAu c=1 sm=1 tr=0 ts=6a2a5e08 cx=c_pps
 a=n4Rd88MCvJemCXT3WVAnXw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=_jAD5XSDOtq9-5Nde2OG:22 a=qR7S5-ih6UruxHqsH4YA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: UtAuM1yNAI00qYESVbbAsfH_-VadMNMY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_01,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 spamscore=0 adultscore=0
 lowpriorityscore=0 phishscore=0 malwarescore=0 suspectscore=0 clxscore=1015
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606110068

> > @@ -445,7 +704,7 @@ static int ad3530r_setup(struct ad3530r_state *st,
> > int external_vref_uV)  static const struct regmap_config
> ad3530r_regmap_config =3D {
> >  	.reg_bits =3D 16,
> >  	.val_bits =3D 8,
> > -	.max_register =3D AD3530R_MAX_REG_ADDR,
> > +	.max_register =3D AD3532R_MAX_REG_ADDR,
>=20
> What happens if we read off the end (via debugfs) for the smaller parts?

I tested reading registers at 0x1000 and above on AD3531R it just
returns 0xFF and no crash. Should I add a per-chip regmap_config to limit
the exposed register space?

> >  };
> >
> >  static const struct iio_info ad3530r_info =3D { @@ -514,6 +773,8 @@
> > static const struct spi_device_id ad3530r_id[] =3D {
> >  	{ "ad3530r", (kernel_ulong_t)&ad3530r_chip },
> >  	{ "ad3531", (kernel_ulong_t)&ad3531_chip },
> >  	{ "ad3531r", (kernel_ulong_t)&ad3531r_chip },
> > +	{ "ad3532", (kernel_ulong_t)&ad3532_chip },
> > +	{ "ad3532r", (kernel_ulong_t)&ad3532r_chip },
>=20
> Add a precursor patch to switch this to named initializers. Otherwise thi=
s will
> clash with the work Uwe is doing to ensure these are all done that way.
>=20
> >  	{ }
> >  };
> >  MODULE_DEVICE_TABLE(spi, ad3530r_id); @@ -523,6 +784,8 @@ static
> > const struct of_device_id ad3530r_of_match[] =3D {
> >  	{ .compatible =3D "adi,ad3530r", .data =3D &ad3530r_chip },
> >  	{ .compatible =3D "adi,ad3531", .data =3D &ad3531_chip },
> >  	{ .compatible =3D "adi,ad3531r", .data =3D &ad3531r_chip },
> > +	{ .compatible =3D "adi,ad3532", .data =3D &ad3532_chip },
> > +	{ .compatible =3D "adi,ad3532r", .data =3D &ad3532r_chip },
> >  	{ }
> >  };
> >  MODULE_DEVICE_TABLE(of, ad3530r_of_match);
> >

