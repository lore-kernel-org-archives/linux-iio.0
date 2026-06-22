Received: from mx0a-00549402.pphosted.com (mx0a-00549402.pphosted.com [205.220.166.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F27003A5430;
	Mon, 22 Jun 2026 10:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782123860; cv=fail; b=sYD7CWsSWFN85CUtdGUa+2QLnBXjqTkZEiVToPluz2Xj58Af87itWeXfIFMS0IzihronJJU9edKP8vYV78524tR6V3WvUejEIctMAG5BaO+X1OH+SUDSlpN5YzSngi0qTJUjcXSwSt7UlDh8N+5JXGRi4eTd8bj6y1s/uYTWewg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782123860; c=relaxed/simple;
	bh=ExQNSKNwlVEQMeZsaYA/IBhyw2uzMCI2XaZHoDgCHaw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YRDH+k7owKjODH4mi7poYPbzDN2Ujrx2vPVs0ic8V46Ud/ZPu4mmikBvnvu7oJXjbjMxvhaLue2jfb8ERa5w8T8m8CkxBqMTgXuyY6dfTn5qvFsGr7psFVDDHXF0FK52KSGq/CCnT2VuZWRVh+nZFN6/qRHv4ybvcWRufKeXTtI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com; spf=pass smtp.mailfrom=tdk.com; dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b=QBZRHgwA; arc=fail smtp.client-ip=205.220.166.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tdk.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b="QBZRHgwA"
Received: from pps.filterd (m0233778.ppops.net [127.0.0.1])
	by mx0b-00549402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65M5DCeZ125196;
	Mon, 22 Jun 2026 09:23:42 GMT
Received: from fr6p281cu001.outbound.protection.outlook.com (mail-germanywestcentralazon11010058.outbound.protection.outlook.com [52.101.171.58])
	by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 4ewh7ws9ra-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 22 Jun 2026 09:23:42 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B4VM+ORCExmVlGyuK0eVRNKNkAkP8fImCUo7vrMTe8idPBq6e05vy5Kro1tKBAlRGWjtVM/XdZTuEwh88gOwAa1M8VFtG8yj+HEyzRHocMld2Kp16tqJWw6sq/i0+0/0ze1g2QY25smaGy8u2Pr/X+5NDLepbmlfiuIp1ywCICD34CJHOuGEzQwbAoKesJtcEcron4sYN6rhUgeKiYlEqOZTYpyM9/33sQMUcIDsKW6OfHbCDICxZmUIpHEJrwCSEJQnuXXgT3Nfs/ogXRObOg32Ll/JI+ymb/5Xp4F/iqIJrPOIwhWoutMzLzF7SWgHdFCEHAGmhvKjqu+jf/+QMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PqpbEoDZpcaYoFdj3+LdFT5sC1Y5blVpjB6X2rXeQ6M=;
 b=qvPApaSMBlqDcGznsw0lBmCb/SRtJrsfYqen1wKwXJfbpQMGIY1/ZrvA38Fe5Q7qMwhBbzL4uAUDRpbsvwN4jBUE24Pl/sytRunu0/vPU9k77U+w56z+7y+jgK7PwyHjNSeeVQ9JojfHp5abuQUzcCvM5uQyIVKL8+r4dEP94H+rMfRWFxWbNAb0VN8sj/CJGjZpeX5WKiUKxU3h/urattbzmeIjWqtNykUluwGyvOkiou680LwNyO4KqyGn9NblIEKalBg+BksUt4gu2e0p2z65ZraNFIH7ntecg5Rn8yN0LnPCrQGaN8JyEsqA/zesbz3WPS3S1N1Ck2CzHzDTNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PqpbEoDZpcaYoFdj3+LdFT5sC1Y5blVpjB6X2rXeQ6M=;
 b=QBZRHgwAt2amL+RY3myjZMv2ggafZ1FzXoes8NYtasTLQmlHs8hvrpQDWzuQMHFIalhgHNHT1w8kZzUVrzQaJylGiv2wIB1wwm8gBpxuswB4fv9ShDMuap8Db5DLoVQJuMKF0dpppz1VZexQMRoCmQj9kJn8eiSTF7FYuGdJ1BY9EEWWlucuCT9KysBykA6rEs0vQ27ibdY0yYx4l4Ph2ALrGbBYvaYRBxO+NsfNbyTTX1IJV/lfRHUpEWsLxEd0dCliwQq3pnrqdODWsDI5zFKSgFy6Py9sq1ZDdCbyhD5/rI1F/DdK13bbQoPQFDGIFB7Hxu2TcfUJpKs4oHVsBA==
Received: from BE1P281MB1426.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:19::10)
 by FR3PPF203888B8A.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d18:2::11b) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.19; Mon, 22 Jun
 2026 09:23:29 +0000
Received: from BE1P281MB1426.DEUP281.PROD.OUTLOOK.COM
 ([fe80::9d4c:26bd:ea0d:b04b]) by BE1P281MB1426.DEUP281.PROD.OUTLOOK.COM
 ([fe80::9d4c:26bd:ea0d:b04b%5]) with mapi id 15.21.0139.018; Mon, 22 Jun 2026
 09:23:28 +0000
From: Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
To: Jonathan Cameron <jic23@kernel.org>, Chris Morgan <macroalpha82@gmail.com>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "andy@kernel.org"
	<andy@kernel.org>,
        "nuno.sa@analog.com" <nuno.sa@analog.com>,
        "dlechner@baylibre.com" <dlechner@baylibre.com>,
        "linux-rockchip@lists.infradead.org" <linux-rockchip@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "heiko@sntech.de"
	<heiko@sntech.de>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
        "robh@kernel.org"
	<robh@kernel.org>,
        "andriy.shevchenko@intel.com"
	<andriy.shevchenko@intel.com>,
        Chris Morgan <macromorgan@hotmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: Re: [PATCH V13 2/9] dt-bindings: iio: imu: icm42600: Add icm42607
Thread-Topic: [PATCH V13 2/9] dt-bindings: iio: imu: icm42600: Add icm42607
Thread-Index: AQHc/Oxf104utO5+mUGAWwxezB0RarZJSf0AgAD17A4=
Date: Mon, 22 Jun 2026 09:23:28 +0000
Message-ID:
 <BE1P281MB1426C557A66945951D382EDDCEEF2@BE1P281MB1426.DEUP281.PROD.OUTLOOK.COM>
References: <20260615172554.160910-1-macroalpha82@gmail.com>
	<20260615172554.160910-3-macroalpha82@gmail.com>
 <20260621181804.27b44942@jic23-huawei>
In-Reply-To: <20260621181804.27b44942@jic23-huawei>
Accept-Language: en-US, fr-FR
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BE1P281MB1426:EE_|FR3PPF203888B8A:EE_
x-ms-office365-filtering-correlation-id: d5ed6eaa-8c87-42c2-f3dc-08ded03febaa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|19092799006|1800799024|376014|366016|7416014|38070700021|18002099003|22082099003|4143699003|11063799006|3023799007|56012099006;
x-microsoft-antispam-message-info:
 YmKs0gk+Xju6kPioShJqRCuQ+9Tu3zd5vYDp0zjuEQINg+S+i9ebFu5k7zdyZZIPYHEUzX0OSn0iZGkhhdLpodkg8gdzJ7dXBwGOtpuxJ/x/2NMoihP55GxrbREmF5DaMGpfAHobWNvp+wMG0+PYBBX+3hWfA71EBQ/Kw+s+k2x8Dx1I7YaFfOpd6zmghtBZdsImlVewI1scVgjpVna7Z7eFyeh1ifzxujoBso1HDcwGS26zYwXBqJBSYDJKY4h1pfjWJBHxAelA58bDR7o54TsjO4jYlIh7LyXc3osyL+WySsgWmqj3PJaNluJcvQ9hme1lR2rRnkZ62Ke9i9qeRUG3q0r1OIX7obfo5CeaYkLalNsjWVTMWNHUEfvVRMfclDZRC4yI7vPaFlGswIEwEdgFBNzqGPzdixbTRQzYdn+dMkn3xCy4h1cOXUSbpq+5YQssUYFpuFI3C+dOgpu3Xy1NSBNXibXCUDu3s7TggtH/R5PnUTZ3/gls/aQO/19g30j3oOp9a0syxh+QmUVBlXCsbNHV0HiskrObA9eLXz/ENhvc20g6snipWQqC190HHO1uaSj3mGC3vaFQL/a7ocUvMAYsyuC9c43v8/+1gf3SAIvPlZt5xq5tWBBzDHZnhso2S+axX5ByrhXoebB7KS+t9br4BcCXoirk5+lfUgztf3BykpqaZgw9amez/3k6aI5C6ygLnZqbOSCyqZLriNROpa2Ff0f9to322mF/uLg=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BE1P281MB1426.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(19092799006)(1800799024)(376014)(366016)(7416014)(38070700021)(18002099003)(22082099003)(4143699003)(11063799006)(3023799007)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?nMmuIljNGv8Cw7Oz8wU+KYp09VAWYUpVWJT+03i3LC3M6ycFvVkLNxiNS4?=
 =?iso-8859-1?Q?uJVY/vj6CEVnh/+f8OM3AN34/9dgQ8Kj1R8mJlsbbzDp7J+abn+H+KEuG3?=
 =?iso-8859-1?Q?xo/k6HsWv5gyecitFQisOa5ypGNpNnp88QvPn/buKAwgsYtBH+V0RHqT2f?=
 =?iso-8859-1?Q?SQfEST4mMg6xuze254npy1wvRPb4dwF99QFDcmkViSMO4Plx9Sh6NjN65O?=
 =?iso-8859-1?Q?cBbtqM7Kxw59xv78i26wgmE++DaWkIOpk7lE+854ZWYy6ZuV1u2o2goR1f?=
 =?iso-8859-1?Q?tUkFmZY8SpQRBJh234VvKDR2NbescDPKIM/qg1oOzNp9F6XL+/+h124eCR?=
 =?iso-8859-1?Q?+nSoTXHcs9XC2BkZ9/9E8asTEKzeY4hsowfYbu3GaLNRvorzUSGja787kg?=
 =?iso-8859-1?Q?r9EegxECVmPVDNgsqxO2/k28q328hfCFPyBKUeJTLow+8QBGekW1Sq3lTQ?=
 =?iso-8859-1?Q?OH4eZovHaOpz4I9qQXRQBBr+dD/doShXtyJ4IRX6RRsNTkd0iynQc/Ke8x?=
 =?iso-8859-1?Q?KJr/e3FWqa5LTdsWwxHD2xBPHKXC5HOzmYKpWlje+ek22cK7YzcsD64ZOC?=
 =?iso-8859-1?Q?msOAhL088iHs8VjSaMuFGLe47ZeI3SH7/pbkzPcQM4ztojReUtYwBNTE0c?=
 =?iso-8859-1?Q?2C0p8oHFOW4D2vcTA4b6N88scbbVBTNvHVqsayQsgAZKm1Z9jlX7NNJKWx?=
 =?iso-8859-1?Q?qmU6z4T9ScwL+HdgjrI0In9IEGGBxO0aQEGSGH2Gmp+c2VhE6KVZ2HvDLG?=
 =?iso-8859-1?Q?OM4krLihmqLNviT3fg/yBhVCN6ry+LgILWD3uxMwTJvF8+GBr2g/5GZ8FY?=
 =?iso-8859-1?Q?s5S8RBKAL0ESAGTkQoVfFkj95PyK/zcEbI0i9b2oGyWJSSMIBj/XSAZIKK?=
 =?iso-8859-1?Q?FKfcad0aoW9hfK/d6dIeyzREU7lqDWUhPV8YhL4+VUsGaauni6dS0/vU2d?=
 =?iso-8859-1?Q?ewioBjMdsGlqBiHP/bh6RbJoAFQV7MGNHDt6+nvVolPWi+PY6T+avyKgdt?=
 =?iso-8859-1?Q?tjq97XdpssP5R1xn885Tu4Ew0pfQLn/5bbY6wX3A2xDV8Fbd0ojtqVOAJL?=
 =?iso-8859-1?Q?S7mHSJ0oUcvML+T9dvcRbnX9JORrAVNsF2n78NSx5e+QHJL7WxaGrlMiT1?=
 =?iso-8859-1?Q?fxhRBWe9hazvmYIy1Nwuh6EeZxCE0E1LIajIZriu7sldnwAbV4Pg2QT5Gr?=
 =?iso-8859-1?Q?ry61nFlJ9rv/+QgejjQb8XUOzcasD0m5E2Sqx2uRJ5rQmVz8zzQBHV9hOq?=
 =?iso-8859-1?Q?C3qeLu0eWJRK+UmdZt1BIB8entTK160LjNMno8lCkKLJoQAUMo9GA0rUnJ?=
 =?iso-8859-1?Q?58h71yx6VJaC79dS1P56P7eSlUVh+1sanMoNmsOykodu7SwcyBVZTGqln4?=
 =?iso-8859-1?Q?Sc7RdGeOrd20H/0C6fzfAO8M3GO87IhLeyrkdapfWYUJsmJwyeBBu6z0KK?=
 =?iso-8859-1?Q?sSDhaGfvgyKNXoSaQP2LsH4dSH1pAvGc3tJJbCWv3Sk5cFlOvGQRHltdRH?=
 =?iso-8859-1?Q?0wHFT/OdltYnBZUdyGNf3QTUfnBj/0dRPYvpcTxI4yzF2DhON960vAoKB7?=
 =?iso-8859-1?Q?GH+i4EkmtKVSGMWc8CAmpe4t+G+DzToX4Jfvqf7IROUS3Q+XW6PSdfai8I?=
 =?iso-8859-1?Q?0fEDwfHdfnpmTSEhSyNQXFX9dbjGgVbH5dKfK8KwX+Pv6sUeYVJGN4NCgq?=
 =?iso-8859-1?Q?MR6txLlmKve7EvgLBmDFAqC3RPB9vFoQEDLBlzIBpvrbiO2NkMAwO7D4y9?=
 =?iso-8859-1?Q?B8PHjsac8wbkw064Z5rxFiLhlexb9kgNvnQYIhDpSOkO/oZfJKY8d1hNTs?=
 =?iso-8859-1?Q?dUpBiwdD44IWg9A8cJQ0UCpvuyZagDY=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	HPFg9yuDNmBuD0PEBVaXN6CW8YGBzzOebb9iqeq5QUwAB+HcAeQuzt9iXxLT/vb2DIhdierLEtSQvQBHnRS1h8wumD1xpqdW7wD0uA0z3x7k1z8XYdoaHcT1fcsn8aleL/wKEvQa14obHTGqDsO19lV7eMqTVf11CPATSOYxUBG6DXKuohxEf8NP1vcxgNBGJHQt/8eaatVNCQt+gAfbFmnwwk5fOUFXkLtjUe3fwwAkg+6WOBhZakZFNiZmh/tRe5rGO1W28aWvE9eww9JS71fLjHhNNZYCrcIa7Ccs/GFfECdn+p9Uz8tLIafaJCSinOQba0e/Ny8IWrbnQ9xf3w==
X-OriginatorOrg: tdk.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BE1P281MB1426.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: d5ed6eaa-8c87-42c2-f3dc-08ded03febaa
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2026 09:23:28.7922
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G9vG/kGgWo1KGO6khjivHhKXrKJlpD+B/LcuOxM3TeOsMQiyUMyW940ZOl4D6IK/3u5RPZv6GT2fCMt2hnKD4H0bG6wAzCR4IsDnxL5c8xM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR3PPF203888B8A
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=U4uiy+ru c=1 sm=1 tr=0 ts=6a38ff1e cx=c_pps
 a=mPQVJ9RghnNfTVSdtVDH3g==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=FelO9ux0wxsA:10 a=Uwzcpa5oeQwA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=W6z64dnQKVPvYeLC5f8l:22 a=vGRfEVypjB2sPmOVjkt7:22 a=69EAbJreAAAA:8
 a=EUspDBNiAAAA:8 a=wjaA5wqwrxzpPmQJeu0A:9 a=wPNLvfGTeEIA:10
X-Proofpoint-GUID: hx7P3HBrwgX_wvTicKI-GPxeM72Tt_G2
X-Proofpoint-ORIG-GUID: BBqsRZKKd0eOgn58Iq8cuMkej76kRwrG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDA5MSBTYWx0ZWRfX5cLbBiEWnQML
 cYZO3jjuy/PrUDx1bvhO8qv0sWL52dpnwH+7hxMkgjzEEVaiAFMgdoCfQfJgFADCvQVrssnX9AB
 W/hIdK5IqDCpf1nzfXe/QXI+B7vY1ZW7mpHN13JgTxdPTazYIgnHhjVl0qvSzrDkvLkMB4UIvBU
 EIY546uL+Ng0jlnCnE4Fhd4VG4Hrz0dpA+r0HLfVyqyPYdA/KfpAEhZTa9IL7pHwdlZCFCfxCIo
 vswPNAhq6r3dFhI/+UpJkFfD47tdglN7mYQcKlkpmnaukLJvUvPTgmZz+exAMYz12EO3/R1uoZW
 quC5KxELwa2oQnDorwpOgWUgsYKJdf92lpdjyA1R5aSYJJ5OkK5ohKbUmnsde6NZyl7JneWm6SO
 t9oPQhqTeeeFM8B7gcjrgdpXTZniYlET4UknjyO6hrnQ/9n/gQ/qTXkeZrbWz6SYRDLtqHk4CG2
 6cD14ooqwm5Sg6B4v/Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDA5MSBTYWx0ZWRfXzKTha5mO02Oj
 UJleoTIxcyGcbRdCt6Et8ZRP2nEnyZm9HMGXxq1sv3gCvCaqUDnbbSDuAsT/ZC7x+Y/peBqBSGf
 2pMJqZSC0IE8FouWaTOD0eCPK3ujP8zJ1KTExiXr7XZiR5TMo5+i
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_01,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 spamscore=0 impostorscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 bulkscore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606220091

Hello Chris and Jonathan,=0A=
=0A=
concerning dt bindings, my initial understanding was that we had a file per=
=0A=
driver. But here, Chris is doing a new driver for icm42607 while adding new=
=0A=
bindings here.=0A=
=0A=
Does it means we don't have 1 binding file per driver, and there is no need=
=0A=
to create a new binding file for inv_icm42607 driver?=0A=
=0A=
Despite the naming, icm42607 chips are a complete new design very different=
=0A=
than all other icm42600 chips. It using similar IPs for things like the FIF=
O,=0A=
but all other parts are different. Especially, it doesn't use banks for=0A=
registers access but indirect access delegated to the chip internals for=0A=
accessing certain registers.=0A=
=0A=
Thanks,=0A=
JB=0A=
=0A=
>From: Chris Morgan <macromorgan@hotmail.com>=0A=
>=0A=
>Add the ICM42607 and ICM42607P inertial measurement unit.=0A=
>=0A=
>This device is functionally very similar to the icm42600 series with a=0A=
>very different register layout. The driver does not require an=0A=
>interrupt for these specific chip revisions.=0A=
>=0A=
>Signed-off-by: Chris Morgan <macromorgan@hotmail.com>=0A=
>Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>=0A=
>---=0A=
> .../bindings/iio/imu/invensense,icm42600.yaml  | 18 +++++++++++++++++-=0A=
> 1 file changed, 17 insertions(+), 1 deletion(-)=0A=
>=0A=
>diff --git a/Documentation/devicetree/bindings/iio/imu/invensense,icm42600=
.yaml b/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml=
=0A=
>index 9b2af104f186..81b6e85decd5 100644=0A=
>--- a/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml=
=0A=
>+++ b/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml=
=0A=
>@@ -30,6 +30,8 @@ properties:=0A=
>       - invensense,icm42600=0A=
>       - invensense,icm42602=0A=
>       - invensense,icm42605=0A=
>+      - invensense,icm42607=0A=
>+      - invensense,icm42607p=0A=
>       - invensense,icm42622=0A=
>       - invensense,icm42631=0A=
>       - invensense,icm42686=0A=
>@@ -67,10 +69,24 @@ properties:=0A=
> required:=0A=
>   - compatible=0A=
>   - reg=0A=
>-  - interrupts=0A=
> =0A=
> allOf:=0A=
>   - $ref: /schemas/spi/spi-peripheral-props.yaml#=0A=
>+  - if:=0A=
>+      properties:=0A=
>+        compatible:=0A=
>+          contains:=0A=
>+            enum:=0A=
>+              - invensense,icm42600=0A=
>+              - invensense,icm42602=0A=
>+              - invensense,icm42605=0A=
>+              - invensense,icm42622=0A=
>+              - invensense,icm42631=0A=
>+              - invensense,icm42686=0A=
>+              - invensense,icm42688=0A=
>+    then:=0A=
>+      required:=0A=
>+        - interrupts=0A=
> =0A=
> unevaluatedProperties: false=0A=
> =0A=
>-- =0A=
>2.43.0=
