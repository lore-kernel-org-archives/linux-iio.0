Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B60463126CD;
	Sun, 22 Mar 2026 15:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774193622; cv=fail; b=NHkQEm5xdGFSlq9/IxYOU0M5v7DS1Sl6u0Sn73+uNeCAwyj5slttqBfxzWHxLkxKFkNQjpZUKFy6ETo7YQGBfWyTg14CDEz/HUJ1MqnuobjfUdJ6Co3l/xv9Yvm98E22Qp0uK7sU7OkB+xkWgRMzk+18mGzQR5LBrY3X8pVlwhM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774193622; c=relaxed/simple;
	bh=Lgn7mgvh5M+CQEiA2aru+uEfpAShh8O6tfZlKRMSAJY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DhbffQolNl7mBuZlF1zPDbFmRwGKv3CS4KqngsEyFS4qbdecLPw9T1eNlKpKeprZuoLtpVQ7Enj2ZtcpLDcPI4dbzmSZRjw7Ver5VFVFvGLxD2lckYCuSZXTvxRIQJiCyEUSMnf363zMh3mJpBPm93MIUCRDk1nvwj0eOZ7lr44=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=qhhaQn44; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="qhhaQn44"
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62M1AEYD4025389;
	Sun, 22 Mar 2026 11:33:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=ZrLNA
	2F0C3LPW4x8Wdjno9M1FHpyi5gh8B4i19h7acI=; b=qhhaQn44fTSNpa6S9llaN
	O0NzN8gzcb7Bi+EBhLFrLmBfGm7mi/TIalnrUFiLOVZD62Qtpvay6Cony34UPv+W
	vzbUxgblkt1msHFqR2RdqDpMAkJKkCS7TahpFbChoJ0/ZTBaieU+GL9ZCIw8mjrk
	p74eaJ0ThKsYBjxuWfpvAQ1Y1C6JKK4ikAnfTPpv0yMO3VPL1040zqHDtQzQTO0v
	fzkRdgDYLsN4YHzpsqMGuQ+Y4frBXY2QG74bW/y1JQGm8phYpkuwsUDReoC7A4iW
	Tb/lIMHtN332oIsd71bxpcVXmY6TEoxVrZCsK5ZvhU6zvlnDIMBu6D7vy/Sp14KF
	Q==
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010041.outbound.protection.outlook.com [52.101.46.41])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4d1qy3b4h9-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sun, 22 Mar 2026 11:33:10 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vZ+UoyjoOnmSw80TGeT6Jj3aKUZvhhIIBX447G+FfFFZSvV2p3LOlcRHwGAMsM4CFeNGP2rnercN9UGAGnmg5vOjZaZ/vZKEXiIt5mpPQIdj/Z5oQcRFb6M6haEGNigePN3nxrkeQUknoHTEVMsTSDLfwOqzt3SQe0biRQcg0aZyUJrvyiqWDedqypXrbe40Fpg+DoxqunIlmESKCeoCEPtJjbuTYJk0jQnit5n9Q74twNh3kyq543+rSNTZkj9NGYnbhWu+smjDFpOxyUW7EKEdIr/MDCUuEv9ECAU5r4OzPjKe7xvCuhrlnJ4Vq+/TG5ymE+ed++OcUnZPygSPhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZrLNA2F0C3LPW4x8Wdjno9M1FHpyi5gh8B4i19h7acI=;
 b=sS2EGg1gJ1dHEFiAdNXQzOrc6neZNquVp6qxNQoxbBeoyw7UIPmDd+5w55OlrdLEqybKx1fEc0IQkJVQMeu0/SdCLjMPkXFH1UR6JWBZqYlsxvSuqYJ3SKDLmcuRb2OrkFDjVzE6WO6vxD5mCtqIt+q7tlRiz18o0jPIte17Lda7fth4q6gw/KmgOofWuxpIA/Mkjdnz1LL9IDezgyOw9E0pLjtxMiiDovclXVDavbXTGUlGPvlCTJieXBD6NftAtPDFOwEcM/vdaabBEfpO/dHdRu+OZK8UmjNHxmUkqbTPAHHehh87A7YCTEKcT6NKzjfxVsAb524UYfywGog6vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from CY4PR03MB3399.namprd03.prod.outlook.com (2603:10b6:910:57::13)
 by SA5PR03MB8449.namprd03.prod.outlook.com (2603:10b6:806:476::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.25; Sun, 22 Mar
 2026 15:32:58 +0000
Received: from CY4PR03MB3399.namprd03.prod.outlook.com
 ([fe80::1527:d313:16d4:2376]) by CY4PR03MB3399.namprd03.prod.outlook.com
 ([fe80::1527:d313:16d4:2376%4]) with mapi id 15.20.9700.025; Sun, 22 Mar 2026
 15:33:07 +0000
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
Subject: RE: [PATCH v7 3/4] dt-bindings: iio: adc: ad4080: add AD4880 support
Thread-Topic: [PATCH v7 3/4] dt-bindings: iio: adc: ad4080: add AD4880 support
Thread-Index: AQHcuRncsLtT3w3YpUeJ6Igj+u3lMbW45IcAgAG/JcA=
Date: Sun, 22 Mar 2026 15:33:07 +0000
Message-ID:
 <CY4PR03MB339944E105FADF6717B5088B9B4AA@CY4PR03MB3399.namprd03.prod.outlook.com>
References: <20260321100154.1258-1-antoniu.miclaus@analog.com>
	<20260321100154.1258-4-antoniu.miclaus@analog.com>
 <20260321120802.391cafd0@jic23-huawei>
In-Reply-To: <20260321120802.391cafd0@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY4PR03MB3399:EE_|SA5PR03MB8449:EE_
x-ms-office365-filtering-correlation-id: ae5e2b95-cc59-409a-773b-08de88285123
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700021|13003099007|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info:
 PfWTRgDSkj3KrVvEsQL1QrS6AejvF1joC9nnbmwgNj8sEyFdR1sTuxNgnKrxS6J3/YZnC7wDzRh4pnnEMUlqxXgdAg6iCT1UEh2rm4KkQJk/xaNzxdGFr6HPBKuXct2/lSMCAsnLUrd1ln8HPYmrY1sPLcuRceH3ZeNxhtzEjGit1BQklqy6galNNtbrAe2RNFPEhl+4Io1pHbS/TLui7tb8IpG77dGJsbR8UiJtkfCfkezrXy6BLLooEGo3yV7UgnsnLrvKyd+AU2i+/bc2tmuVmy7cLvyWvaxoYczItTVtVQkFeZFXAaUcgum57yjP+80l5MYv0uNDjkUuje59E7YgIhlIHyC7c0Xci4k+zGLBnwtXUPFAacrGjpfR5EZm4BOFMDqVUtRE5g5igdw0Pu0Z7g4JByo0JfriQVkZ8HKlzwhYHzpxycnw7kxesNLqDp+HDSVBN/fgvQYJ2KQyUJzmpZzyddJd7KtvyriVIO7KIrb70BttLdcW16IP3rucTwQvO79li3Z+l1V2fN4Ch+S4eoRXIFfeNjco4gOkgpGIa0pXpo4453aK5y9x8jY2Yz45I4nKhRK14OOR6WstPs7yKcyfpbn9CFg6CQWTIdAv+N7UJ3swtJrCzgmjBUqCjaTWDRFX3UvJYfqR4luHsaN9jClQid9Y9HKlcpyv5/Aw1VriEniBSQvpdf2pYi2BuxKV5fqRukD1JUAS/bP79SFww/Kwgb7WaPEdz6t+vTvJel9FtEh34fPjq/XsF1zoZrf/5NU6lzQoJTTC90iuMXGwqb0z6IXJZ7f8DI+0TbCNCCuG8vgR8p2a2Aj21z3g
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR03MB3399.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700021)(13003099007)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?iOmFUBYbPQ+yKayHP52Zyn34P8P94HIcvaH4FJblmEVIRA35UKt9FMA6A2Ea?=
 =?us-ascii?Q?Poa8SQwRERcgdKRsLFVhNUsaxAMcGbrprlIDrsCUHm5r3oSJNbSfYvArsvlS?=
 =?us-ascii?Q?JqzCS/lGiK9DwFYSElZ2aRJ3x/H/tLwppEA5uQNcIe49uRbK0BXYg7Jp94W7?=
 =?us-ascii?Q?ePlo4Nmlb9tQ4EjqQcrQv3NhyuEVDNSIpwQxOE9E7ulTci/7SG+kPqOj3/3F?=
 =?us-ascii?Q?rNoVMJ16Jo5mFTgSO31DrFRBXR/KPmBZk5QeO5eYek3orCeuMYI7yFekJCBf?=
 =?us-ascii?Q?h8wHrGUhLB7UIvO8grM/cOucTMq83KrKEup78yqt0/khTLHMradecFkdMHhi?=
 =?us-ascii?Q?u8utWLy0YanIp2vV4KpmN0WFqNRQsNVVh0MCaZZaiuHg1jrqCsbkc5yNMsNd?=
 =?us-ascii?Q?73V+UbRDiuMgtmZeAdDwM7Tv6pdshAOmuaRx4eDFmgi1d1tPVIkKw+menMFe?=
 =?us-ascii?Q?slqjV8djsxtSkG+Bcxl29Kwlu6x0BMBXxfIGNDnl0JUu86Hx1zClE3mNA28B?=
 =?us-ascii?Q?k4oI461ryge/NMLZSK+azf7isnYeBFH5dFuUKyChCZmTW7KojqWfW/bWD5FY?=
 =?us-ascii?Q?tBs/DwlUVqKz1AkEPtnDwVTzFm4z1bBax+z6akR0aognXtlgK3GU8A7u/smi?=
 =?us-ascii?Q?BKmtzTnzm1HJK7mUZ210c/iT/2m83n8voSmmNLxz5fLnX4vVqzPzP7TWVTrr?=
 =?us-ascii?Q?nOmheEFhxiMCE+MUML3jEmNWz31gtnTvsI7/HAfTC3UMQ6/OmbSjzrYTRnyY?=
 =?us-ascii?Q?hAZgNxf/TfWRi9zfect8EwqnH3rKCsbOGOwxEDscHv2R9E26LjrGFusveiUX?=
 =?us-ascii?Q?Mwy5b3j+0fq6ybkd/+7QDt4Y0V4d+F6zOr2BW8dqnFRdgspvvithSZXgQzhG?=
 =?us-ascii?Q?V3waZnrrGyJo254GQxxBXvP9w/ViQuqkkMVdP8YZEiuiiLoNREp4CI3RumTc?=
 =?us-ascii?Q?cQHu7uTEsd51PY4HFdjqNEeVBrLZul+9737OLfx8L0Og8duH4Ker/bprT4JA?=
 =?us-ascii?Q?ixXesDH3Vj5612ZESMFl+/E/u3NL2WR8uT4W+mL6f52kifkIOZB6/EfQ21bp?=
 =?us-ascii?Q?PfngwH5K65+W4e4HCHLJLz8EIMFbxaMjxmOWkEaEHqKnNDzEpSjP5LjNx11M?=
 =?us-ascii?Q?OL1F4QC+973LpQxgzoS828/NgxkXNalE8JT9jvlEjYdRHsphIgy4ochm/JUL?=
 =?us-ascii?Q?axE/KRpoC0zs2EPuf8KmiOqa1QtXH1ykx2FMT5dmxcSNgYzB3ZyGgbBZ4o3p?=
 =?us-ascii?Q?ZIPbhWO4Af1o5kuW9UVnj1QyDvtfcAL0XRzJDrpv67JOmyafyBZb5kZbLBnK?=
 =?us-ascii?Q?HBJ0NJzP3HCDnzpMP2IByZhvDyESNDrU0WT0uS8xy9hsz/bZPd/XwEkZd5XS?=
 =?us-ascii?Q?wbBIXHv3wE8NjB5Q8hXJa4aBVRCnm6xMli52GAi1XRF7oVTbLTnm4RcRV8Yi?=
 =?us-ascii?Q?k6Ab/vooVueJZPUDWbE5IBGMlBmfxa5+4otZlT1ZYq96qqYlcKbPlva95KIp?=
 =?us-ascii?Q?MSK8JnkhTxg/rdElycaPsKFQzHaBsUGgMBgdr7u09EMbuKnCG+UhZIXAmvqA?=
 =?us-ascii?Q?eNRwGJC0cGN+nLlv/VKxYTod8m5zuTUah/Bh0MMAStOVyVoxElfkmOTRL2/I?=
 =?us-ascii?Q?v60vtSOjM/gGVYlAJY/Ksat5nhnr2jGoqCQxSDeg44MHB3UBtK7RshXgp+bc?=
 =?us-ascii?Q?fVyQrPUXeYV0B6A0X7NM2SgEcPZpe1kQces5JVRisSa26v9jomVIpGCLMTwh?=
 =?us-ascii?Q?+LuYx2YKgQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	AMH+xsIwnhToKsRb4dY7bAVxWmEwANmNYBqiLeFwu7FzEWSUJODT7vcQ/BGL0V7YwoTnSzFiDeuTASqtkgc4+ZRLfEeGdcZBLIWbmXghh8kzN4LEE7Unla3me9KoBQnnc74ujDHdP/VWuAMv4BFCugnnICsb4GIuWr8HNT0wk9Q+Eif52yyLolTANQe0gM9XqAt1FgGeEvuVbS1Fx9I2jhVEMzybpiAVSkqbbmRI8UVzqKRAvWfSymum376p/79vjYebnRWKh/wSQFH4b3EEKRTVbFHX5aUiUnqepSjU2SUW0ToBIxYKFYE8s5vzB7RJ4DwnmBIJL5zTx/Y50COkgw==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR03MB3399.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae5e2b95-cc59-409a-773b-08de88285123
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2026 15:33:07.4429
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6kPHVNIvNNKu08kL5UAfME4d2aAP5tNOWn0A5IdKjvXKHLJ6fIQZr4qAQ3VynSEn3SvE5kYssDa695EvkIph8tR9poaWniAXwb4tIcURwT8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PR03MB8449
X-Authority-Analysis: v=2.4 cv=XqX3+FF9 c=1 sm=1 tr=0 ts=69c00bb6 cx=c_pps
 a=yJkyEzHMNmsTB3XYPV+H7A==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=_jAD5XSDOtq9-5Nde2OG:22 a=4tbZXvb0AAAA:20 a=gAnH3GRIAAAA:8 a=VwQbUJbxAAAA:8
 a=IpJZQVW2AAAA:8 a=8b9GpE9nAAAA:8 a=fedHlUbg0jdY9UwuWqsA:9 a=CjuIK1q_8ugA:10
 a=IawgGOuG5U0WyFbmm1f5:22 a=T3LWEMljR5ZiDmsYVIUa:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIyMDEzNSBTYWx0ZWRfX9j0oLLqSYq3v
 sIr7IQ+07tFJk/gkmNw/290CCrasrKnagP/+V8QsOgaPi//714sv8S60KVE6IZgDRuib9txM+pU
 n6DYFI9PgQljPZ4fhqfZTThaC6xaRBkAfzu3wdDJD4/aTZ4XtXVHJQ+MnWZvMmezPQtYoH3jL3I
 S5si6PugTOvfdpcaqTguPtPVr/7p+Tsu6PvLYppAr3I1YaefaKTdCSYByw1U7DK6ZtfaC8VAbY7
 4/4jmIMkrYU5mmzVqvq1KoVFjtLJSbw9tQI4kDtH9cAHNec2Tbsji3ndCOMZnkTV1xToitbfGDa
 lLWJXMVIJafKAadtpdAh+xiFIzUIxtqrmX+8SM4vx4c/Hc4mUaJp3U4K0wwq0NwHrR+34gP2+Nc
 FS48br6bpYItpXbeZFE67XZ2RGIZ/YoW997UtzS4SgYCUUyRFpiWuJdIB3ljIygRew78W+mrDLZ
 d83++1mJVxH9SpDmiwg==
X-Proofpoint-GUID: fmiRiJhTTrQvi2AZuExix_BFO01tf9os
X-Proofpoint-ORIG-GUID: fmiRiJhTTrQvi2AZuExix_BFO01tf9os
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-22_04,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 impostorscore=0 spamscore=0
 adultscore=0 clxscore=1015 priorityscore=1501 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603220135

> -----Original Message-----
> From: Jonathan Cameron <jic23@kernel.org>
> Sent: Saturday, March 21, 2026 2:08 PM
> To: Miclaus, Antoniu <Antoniu.Miclaus@analog.com>
> Cc: Lars-Peter Clausen <lars@metafoo.de>; Hennerich, Michael
> <Michael.Hennerich@analog.com>; David Lechner <dlechner@baylibre.com>;
> Sa, Nuno <Nuno.Sa@analog.com>; Rob Herring <robh@kernel.org>; Krzysztof
> Kozlowski <krzk+dt@kernel.org>; Conor Dooley <conor+dt@kernel.org>;
> Olivier Moysan <olivier.moysan@foss.st.com>; linux-iio@vger.kernel.org;
> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH v7 3/4] dt-bindings: iio: adc: ad4080: add AD4880
> support
>=20
> [External]
>=20
> On Sat, 21 Mar 2026 12:01:53 +0200
> Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:
>=20
> > Add support for the AD4880, a dual-channel 20-bit 40MSPS SAR ADC
> > with integrated fully differential amplifiers (FDA).
> >
> > The AD4880 has two independent ADC channels, each with its own SPI
> > configuration interface. This requires:
> > - Two entries in reg property for primary and secondary channel
> >   chip selects
> > - Two io-backends entries for the two data channels
> From the v6 discussion.  I'd just like to know a little more on this.
> Are they really separate backends?
>=20
Yes, they are separate backends. The FPGA reference design
instantiates two independent axi_ad408x IP cores
The AD4880 is essentially two AD4080 dies in one package.

The two data streams are merged by a util_cpack2 channel
packer before reaching a single DMA:

    axi_ad408x (ch A) --
                         --> util_cpack2 --> single DMA
    axi_ad408x (ch B) --/

Each backend needs independent LVDS alignment and lane
configuration, so a single-backend-with-channel-parameter
model wouldn't fit here.

https://github.com/analogdevicesinc/hdl/blob/main/projects/ad4880_fmc_evb/c=
ommon/ad4880_fmc_evb_bd.tcl

> Given discussion about interleaved data, I was kind of assuming they
> were different front end interfaces to a single backend IP.
>=20
> The freedom this binding is giving is for those two backends to be
> completely unrelated. I'm not sure if we want that.
>=20
> Jonathan
>=20
>=20
> >
> > Reviewed-by: David Lechner <dlechner@baylibre.com>
> > Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> > ---
> > Changes in v7:
> >   - No changes
> >
> >  .../bindings/iio/adc/adi,ad4080.yaml          | 53 ++++++++++++++++++-
> >  1 file changed, 51 insertions(+), 2 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4080.yaml
> b/Documentation/devicetree/bindings/iio/adc/adi,ad4080.yaml
> > index ccd6a0ac1539..0cf86c6f9925 100644
> > --- a/Documentation/devicetree/bindings/iio/adc/adi,ad4080.yaml
> > +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad4080.yaml
> > @@ -18,7 +18,11 @@ description: |
> >    service a wide variety of precision, wide bandwidth data acquisition
> >    applications.
> >
> > +  The AD4880 is a dual-channel variant with two independent ADC
> channels,
> > +  each with its own SPI configuration interface.
> > +
> >    https://www.analog.com/media/en/technical-documentation/data-
> sheets/ad4080.pdf
> > +  https://www.analog.com/media/en/technical-documentation/data-
> sheets/ad4880.pdf
> >
> >  $ref: /schemas/spi/spi-peripheral-props.yaml#
> >
> > @@ -31,9 +35,15 @@ properties:
> >        - adi,ad4084
> >        - adi,ad4086
> >        - adi,ad4087
> > +      - adi,ad4880
> >
> >    reg:
> > -    maxItems: 1
> > +    minItems: 1
> > +    maxItems: 2
> > +    description:
> > +      SPI chip select(s). For single-channel devices, one chip select.
> > +      For multi-channel devices like AD4880, two chip selects are requ=
ired
> > +      as each channel has its own SPI configuration interface.
> >
> >    spi-max-frequency:
> >      description: Configuration of the SPI bus.
> > @@ -57,7 +67,10 @@ properties:
> >    vrefin-supply: true
> >
> >    io-backends:
> > -    maxItems: 1
> > +    minItems: 1
> > +    items:
> > +      - description: Backend for channel A (primary)
> > +      - description: Backend for channel B (secondary)
> >
> >    adi,lvds-cnv-enable:
> >      description: Enable the LVDS signal type on the CNV pin. Default i=
s CMOS.
> > @@ -78,6 +91,25 @@ required:
> >    - vdd33-supply
> >    - vrefin-supply
> >
> > +allOf:
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            const: adi,ad4880
> > +    then:
> > +      properties:
> > +        reg:
> > +          minItems: 2
> > +        io-backends:
> > +          minItems: 2
> > +    else:
> > +      properties:
> > +        reg:
> > +          maxItems: 1
> > +        io-backends:
> > +          maxItems: 1
> > +
> >  additionalProperties: false
> >
> >  examples:
> > @@ -98,4 +130,21 @@ examples:
> >            io-backends =3D <&iio_backend>;
> >          };
> >      };
> > +  - |
> > +    spi {
> > +        #address-cells =3D <1>;
> > +        #size-cells =3D <0>;
> > +
> > +        adc@0 {
> > +          compatible =3D "adi,ad4880";
> > +          reg =3D <0>, <1>;
> > +          spi-max-frequency =3D <10000000>;
> > +          vdd33-supply =3D <&vdd33>;
> > +          vddldo-supply =3D <&vddldo>;
> > +          vrefin-supply =3D <&vrefin>;
> > +          clocks =3D <&cnv>;
> > +          clock-names =3D "cnv";
> > +          io-backends =3D <&iio_backend_cha>, <&iio_backend_chb>;
> > +        };
> > +    };
> >  ...

