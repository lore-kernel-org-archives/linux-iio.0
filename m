Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 811583AFCE9;
	Mon, 19 Oct 2026 08:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792399762; cv=fail; b=XGShFbFWT3vsfo5Ff1sKg/yZ9XbFCLIuTNISxclvS5rqtQ9eHuufRzx+xOBxCJtB7kvG/PeV015jvBLSt3RYNgtVBihAPBC2ZjklqFhi4LQw/ApgKAEGS8IqjhOYc17G3098N+r8ooWWherogYoNYekEKRh7SwCCNmSRmm4sxLE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792399762; c=relaxed/simple;
	bh=CdZ6BrE8NVed17W+N4brscI6asON60eYJJ58gKlrlJY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fWiF2MMHemgoaS3rsbwGd8Y+betQ8zomsgHtKUz1AzYaHQsvcJ2yBpfYZtxtwjMy+XKPa7d1ONZC/zAJWq8S5aDQF/UHAvPpg7VNwSZrr6R4WaBuTrG4ZdsfoLptURE/IvrDsZhjxejZgmtWci/fgQIl9NSi64CtXDh+4SZl4k4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b=edqdvVTx; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=DThnUDuJ; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b="edqdvVTx";
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="DThnUDuJ"
Received: from pps.filterd (m0375854.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69J8Mgjq534070;
	Mon, 19 Oct 2026 04:49:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=737TbJFFLjIlJwbwTVBK6glEDo2pDBtBJW2GIw3UoJM=; b=edqdvVT
	xcGQyyPmVpR6KjIEW+B2Jg55OdPXVt9mwiv7bRdJ1D+tBS3xGN+fQEKFGNKn2MkK
	d6pKfz52BUcURojRU3qNI0cZ+Qqp5YdKTB5fZebUT4DX1uaHPtWYL4sCkt4Impak
	ozTz/RPGEqq96ptHmgdEefJqCp525qFNW5WWs5KaDURJwhSSYFfgDz0fwJZ3ojHK
	p8BTVDXsRo7QlUtU64sUbnQwev2QRLxAeMpiITaHQtSf2BZKbzzDIUXA0zzZ4Oi3
	Nv6X7UiimjtBrBt6HbK43V1e5Bcoi6SCrhlIQFJJ0dGksPasEb6wY6cj7p0jNNqp
	0RH+aXHpvXa9uvA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=737Tb
	JFFLjIlJwbwTVBK6glEDo2pDBtBJW2GIw3UoJM=; b=DThnUDuJ7VOn/DWaOdiSG
	QNj7dKEv2rf4ko4IA+7KwN13ukO3Fo7QXvx8Q+a1rqERlZIP4Dyu8No92DU7ZjmQ
	VR4xJMSI8WEvpqgX/7wy0y1dxkNGqIw0cHhqUSV1F28jr218noAIdLRZLm+Lmp3u
	9hZLmehfwd+agyw6HZXyP/Y/CXX0eKmjiiY3tfapJCl8ZMU0AhjJzD8v9ooSgswV
	6jeM+OppixsDtRZB8+XmnBaWstuuh6JMvhORRJWTnnHmXiRoflra/Y7fy4ADId5G
	av8FuK21X4WsmGn+4MCVWkMUZ9CrBCuw74MMuY++GCrrPp8JN49QEL7QZAE8zN1g
	w==
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012024.outbound.protection.outlook.com [40.93.195.24])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4hcu2f4mgu-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 19 Oct 2026 04:49:01 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sju3Rj5zsOO49ZQ/+XCdGq30bw3wRURF1G5I8oA/B31vjnHXdZA5pVp/+7ACHvgIT1M5LqdWGH4Cw2H7tpdZjHYKMiucDA2XpxgvkAJyVrlVYcA5mCLq1psjm9oXxBOuINoCd2Ppo84dTdg6bv0KorAc7kE1oXFzetuZ93ohCdlW8DfCohLOoDvmVhrSC5r1cpEKGFe/9XKL9eFDniVmaX64X84unrZ6+WWQtOvGEkYzN0rNtrPmGCXcCRIw+Qk341NYKfVW6a06S103Fs0YmwipACqnpVFpVHTJvLMEwF7ATzUJlP+4VPUgmiEAXtGLqYZQrhbY7FGglEcMdDxxcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=737TbJFFLjIlJwbwTVBK6glEDo2pDBtBJW2GIw3UoJM=;
 b=bnBTyFIhgbTxTfBB+iK8Vm8WIMSPEaF6kZymy76FZgBg9ELJz93ouXeZSxYtPo4Dp9HRXLbSBmqnt6Url1wAx5QcJ+QkmZ/s4zlo1Lp36UmvTuFSfJxdcegDODfUpk7P9wzb1u9jSyor8cbZwU6yt3vd3Chm8Babr1sUCAAjWXosK3CwBogjhVWda7zAcySZIsGIN6hrZyEgvj/UjR/4LkWCx1YlJYxgsGTSizgRjdSYRIm7vwDJd634P5xdn1PiOwzur+YefM/3vQF6QG7Xjrr3iL2s6wyEtdoVB/a5Sn7z6Dvp+cq0w0kBkQy2O0Ixb480ze4x4g4NFCclAiKPLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from LV9PR03MB8414.namprd03.prod.outlook.com (2603:10b6:408:367::23)
 by SA3PR03MB8350.namprd03.prod.outlook.com (2603:10b6:806:45d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 08:48:59 +0000
Received: from LV9PR03MB8414.namprd03.prod.outlook.com
 ([fe80::d661:7c16:d052:cc81]) by LV9PR03MB8414.namprd03.prod.outlook.com
 ([fe80::d661:7c16:d052:cc81%4]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 08:48:59 +0000
From: "Sabau, Radu bogdan" <radu.sabau@analog.com>
To: Jonathan Cameron <jic23@kernel.org>,
        Radu Sabau via B4 Relay
	<devnull+radu.sabau.analog.com@kernel.org>
CC: Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael"
	<Michael.Hennerich@analog.com>,
        "Sa, Nuno" <Nuno.Sa@analog.com>,
        David
 Lechner <dlechner@baylibre.com>,
        Andy Shevchenko <andy@kernel.org>,
        Alexandru
 Ardelean <alexandru.ardelean@analog.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH v3 4/6] iio: imu: adis16607: Add FIFO-based
 buffered/triggered capture
Thread-Topic: [PATCH v3 4/6] iio: imu: adis16607: Add FIFO-based
 buffered/triggered capture
Thread-Index: AQHdXIgyGviSW3Pz70emTsNHhZon2rcA+BsAgAOHXYA=
Date: Mon, 19 Oct 2026 08:48:59 +0000
Message-ID:
 <LV9PR03MB8414F2245D9201025D52136CF7982@LV9PR03MB8414.namprd03.prod.outlook.com>
References: <20261015-adis16607-v3-0-f972d4efee85@analog.com>
	<20261015-adis16607-v3-4-f972d4efee85@analog.com>
 <20261017024110.601d9b6c@jic23-hlaptop>
In-Reply-To: <20261017024110.601d9b6c@jic23-hlaptop>
Accept-Language: en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV9PR03MB8414:EE_|SA3PR03MB8350:EE_
x-ms-office365-filtering-correlation-id: a02c6d2b-7b5b-413d-b5d5-08df2dbdd17f
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|7416014|38070700021|4143699003|11063799006|5023799004|56012099006|261009223027099003|10067099003|22082099003|18002099003|6133799003;
x-microsoft-antispam-message-info:
 TAJmQK8trgPjrJARU1g7oEGWaGJYwZdfSd6FA1G2TdYqoGpvVnemeatawezap97CuptPgaqCUoiZE8+4FkJ5n4mL06yjmT6ZBB6oeg+uPm2ms6WKVsm+afQHSI//cEY9dzoARx8/+RQnCrKaamFq7V+D6ZSqUfPcObK5u+3+KTTjyYxZQkYF0CztvasyzFY4AXERwTyBYdi4X7Jm5AUsO5wBh/1ER7yZ/OX+1tJQjIYsZQTYtnLo6ieYFZbfi5mJfKG4HkRJoMakxU7yoDk9nlbzPNpCV63ukG0o9nyc53TcV/AH5lolSmK/9MiaYYtNKslOzqWSq04VEP+Nlg0lNA3nfUl7SB1O6qkzkjhzz8L+5s7obHdK3yajgcMF48GOn+4iXD5P3gA6Rpxfn7uxwPjgcqLz6XrBfdmVh6VsH5reWjvEc2WHmnhsFlKuf63cax1jFc3wzFx5ID3fbOH2Rr6/6VFFZYpcC4V2jzvuOB81UWaAF+3H2JezXInDErl3PmSYvQNH+WJOGg++EMefCRtuI3B4zaK5fSvgFQgZAoqK/pt/8FPJtAHdj3PZj65bWEki/agLAHUsFgJSr6Qz2Dd/Q99+Ewhu9xiQp8uCacJGYCo+282eYziMdhvZ1/Tpvpg5c5VHliYLKvdqv3kOVp5RJSrVyCHNCNMjUpojrRdT3TQeRNrVRvS9U9Ul6dVwmlbSD1eTmlqWuWsX0jfL0t1oybDZSk8160qBP1kTXv4=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV9PR03MB8414.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(7416014)(38070700021)(4143699003)(11063799006)(5023799004)(56012099006)(261009223027099003)(10067099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?G29VxDxwFCqJu4QFU/POK5lgw9wbMVhco9HVQcD7zFfrlPCGnNDDESN1JHjS?=
 =?us-ascii?Q?ktRvOGZ8dP9ebPIp6R2KZJVsOLk5kyFLSCPnqUi1E7b16/Pr+s5tOupU73U5?=
 =?us-ascii?Q?IqKgSkhJJLK+xXyCDkxPtAnbO3K/lh5IBFCnTKoAfv7mA8N1rFXEM8orDt/S?=
 =?us-ascii?Q?e9hOHbz73QXLt9i5ZESJc6D8VfsgDo/CDpnYGIlDEIklUxp8JE8EJvZhO7jt?=
 =?us-ascii?Q?WR1oOsuzTGG42tp65c/3KKVkwzLFfbnPfcubcIuVScoPQeb3cYnGOLMw33I7?=
 =?us-ascii?Q?jzGVdNecBZ7iE7sYfl0T5onDeAw6OR2gl4vE7seRsOynuBObYPTAewunee8J?=
 =?us-ascii?Q?VuBRst6BwRTYbG1krIuuXR1xGdHdek7+jaS78DS6gm6rF1BUHZQlt5rYmsdu?=
 =?us-ascii?Q?9aTkhrGlwCR+s1prFm5EMB9L3fL1mdMQtgzTtxZfMM+DxETNrltSZHQBeqlr?=
 =?us-ascii?Q?9tAcVrGgjdWBlbhUGfEwru3gWFdZzG3ctl9O4BKYhFqqO7l2zmwHfmVqOlfd?=
 =?us-ascii?Q?rWtdXoidvjTDfy/uNr1ExNwxblQNuuQ6/CPkIQgd+XNkk1zrwpIss+1GSXrZ?=
 =?us-ascii?Q?wniJnTnNnTzC+4CPfraEQfOAouPnnmCVGgpWaV/+OKDuJYcQoUbHJNAih4y7?=
 =?us-ascii?Q?3lzlSycJlpHdQ1GDzjhlw5KAtlMjqWKRLPIV/68gNTwrqZGNfpPlpsqmeNsV?=
 =?us-ascii?Q?Dj9ADml/kE3YoBjaRTSxeGhfXqrQcguQ8pEUbTSTrSqD/WAv9VxsW7k1xdWh?=
 =?us-ascii?Q?wco5LuOunZrAcTWaH5wVLW+T0XG+0K1X6QrnZze+JSmmEpPFgC5T9TmYZJno?=
 =?us-ascii?Q?cd8G/yghdQMrTBW8De6VOVMo04ya6ZeJkWGoD0e5bOn+So4IXmDZAmikmcKu?=
 =?us-ascii?Q?1FUuWOE+lXDkzRBrcsvZKbQ5G72eBFq426NdOEAqyt7JdMBkr4CL4gKmULv1?=
 =?us-ascii?Q?d6RZb6mPSwsqZaw2rr6burEui0/YsQV6SFbF47VRT380N9tPQkSQJc1Vb9J/?=
 =?us-ascii?Q?PH/XzO9MhiuS+6UPPsk9XAtyQi8UvrqVJjplh/f6OBXTlRwfInGGk/zlfxHh?=
 =?us-ascii?Q?tcRpovaYSDf06nDcFl1nZ6cYQIMlKKHweNbBMb5BjsN+9vH7MeJFPBtJd0cx?=
 =?us-ascii?Q?D6qx3xOQ8PZgav47rEMGsko4X8Aiojb7eN+By1yz5NHpIUmi/fKD9eG/cvOg?=
 =?us-ascii?Q?lSkHnd/0LdLLVHoF5soDeNir5LMRtdhYvGyjMsC3HNn9tfA+t7C//zl9pCyK?=
 =?us-ascii?Q?RxOM141Ge039VDDkBfIoZxI1rw2cqsvXEee/lnrGxrMFl26rBOrGrhUsBqdw?=
 =?us-ascii?Q?T/v5J4f7l91NtC7z/2qzEFYjp8Tp07aocvo2RkVKoq0qPlBhnMIXRfufUdk4?=
 =?us-ascii?Q?LkwvOMXK1nBYu1QTFF0h7D82No6BUV/FU6SxnWrHtDb5AZ7xCWX8CY2Fu6r9?=
 =?us-ascii?Q?G/gcvzUXf5iF7LNlyGcPvPvBO8XyH0F3KPNXgyAeMcMyR7I+cEjoUNif3KB/?=
 =?us-ascii?Q?CZyAIdOoOxhPejAkXAmkWmkk+ucQ/XYOryuf2XAQUzHF9Tt0b/rSkQ19Tm4+?=
 =?us-ascii?Q?42RRjTD1F+UDTt9nYE8xJ6e+e2U8fANVxA9da7bd4jvB9aT5lTvuaFARiXzr?=
 =?us-ascii?Q?kYqdixnoAIGFPgRXp2Pk9UcBka8JMmWv4MKhw8rQJRadhGJGZVi4+7XWLG0y?=
 =?us-ascii?Q?6D/DzY7oGe82GkYCRFe8CDcYAHjwS/AnHaHoueu46n4Tk7X4?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	lEkox3EhD4j8HNtn+Y3aoo5VreiBftyhM6l8QWCU60UHZVZ8x31MHrmctl7KIKci8S4sYJvFGTrC9u5Z5vmHOV9bpzXUPsO/5mDQeBQP7Ru99c+liHZRFu94+dfRRs9xWb89zLf3Nl0F9kq1fRpljVzUt6KPTSa5OxjAxaM+gPO2IMJMGeH+QsrlZKG1JJtoZZDRt/rV76N/AP6tgI0ud9+zKTpgBCz4D4dzPB2Dc7V8/EGOYmviv2yaK0YAW0mpgTxhJYTw3EbWz2NhOWuk/DM8RCHQf3nU7vj6lMIVULtE7jE6quXZb3SEitWrXDu0vcNkVt9TngRWIGCNDIY4SA==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV9PR03MB8414.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a02c6d2b-7b5b-413d-b5d5-08df2dbdd17f
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2026 08:48:59.6714
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v5aFVSlyRU2c5TBJXdsDvCeSkjZSA4KnRCzWv0/UTJDl8msdSWQV+eO2hqxfjyzNqH45ImmDnzDKMYTVEtHeig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR03MB8350
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDAzNCBTYWx0ZWRfX895XhCXyipLE
 ijAtObsSpjwxfs0LxRmEW3Qxs7E7a3Fg2//qfqOKM7eYN7fkkmNLpsoMSLh11hmN35wMxXF9alF
 x8I64Ti/zbPkaVYUAZkuQM4Z50vfe22nx3ujTreGxm38zHCAgO9F6qJcpKngyIyp/MmBjyxmmIE
 K27XXHUB/n2+8Ta9IjFmvjJewXM/UKIh5f0h2stO77WwQyorFDIOT7fJmdasEq89KYkE76OZJ6x
 +rVriP5rDnleLA9lyeKitPbFeH9/s7suIge7YJft4sNWzhbtdLKJXHVQ7usGNNtMBxA8N+AYxGt
 7ATGl3kjKaxrVrb28JMgthUulKcTs67g/umbHmpGSglorBEhHAtwGiNqjlRAZNCX48Iu8N3E+1J
 gaylqE5ha4JsOKKq13N1dc2C+HmCsZbfGfd44W7NWZuZUeRVL1kPtwcXdizW/9Kd7ttey+pvqot
 SwXK5bQZor4pYsDlaZA==
X-Proofpoint-ORIG-GUID: o6KysCqspcgYgzIB-iWQPlnUVU_9PCF9
X-Authority-Analysis: v=2.4 cv=N+68hG9B c=1 sm=1 tr=0 ts=6ad5d97e cx=c_pps
 a=j0vpRZT92jK8pnwqK8unXQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=iZSIUCweCk2Oy3QsdGPA:22 a=VwQbUJbxAAAA:8 a=gAnH3GRIAAAA:8
 a=Ntb9ulj9Lp2q08HC72sA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: o6KysCqspcgYgzIB-iWQPlnUVU_9PCF9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDAzNCBTYWx0ZWRfX+pKiDEQKfyaX
 9HromPLkttY5coEqSA04OlDplwh0Ry5Fqc/lmPoZovPFW4VqgAcIcWO7OITH+Bv8YQUG+/jT/vr
 o0MN0XvEI8v4BEk6A+T+AsuLhezxBbKuZGWh8pS9H5bwI8Dn7z9L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_03,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 priorityscore=1501 clxscore=1015 bulkscore=0
 malwarescore=0 phishscore=0 spamscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610190034

> -----Original Message-----
> From: Jonathan Cameron <jic23@kernel.org>
> Sent: Saturday, October 17, 2026 4:41 AM

...

> > DR_GPIO_MASK stays enabled unconditionally: DR pulses drive the FIFO
> > controller's internal sample enqueue, independent of pin routing.
> >
> > Watermark is configurable via the standard hwfifo_set_watermark
> > callback and the usual hwfifo_* sysfs attributes.
> >
> > Signed-off-by: Radu Sabau <radu.sabau@analog.com>
> Various comments inline.  Biggest one is I don't follow why we
> need to stop the fifo (which is a ring buffer given overwrite can't
> happen in a fifo!)
>=20
> Jonathan
>=20
> >  /* Self-test registers and masks */
> >  #define ADIS16607_REG_SELF_TEST_DATA(x)	((x) + 0x23)
> >  #define ADIS16607_SNSR_SELF_TEST_MASK	BIT(6)

...

> > +
> > +/*
> > + * Trigger handler - reads samples from the device FIFO. Triggered by =
the
> > + * DEV_NOK interrupt, which fires on any DIAG_STAT flag, not just
> > + * FIFO_THRESH_MET - the DIAG_STAT read below both checks which
> flag(s)
> > + * raised the interrupt and clears the latched status, and must happen
> > + * before any FIFO pop, or we'd pop for nothing on an unrelated flag.
> > + */
> > +static irqreturn_t adis16607_trigger_handler(int irq, void *p)
>=20
> A trigger handler that is associated with a fifo is usually a bad
> idea.  We often only use fifos if there is no trigger associated
> because the meaning of one trigger ever scan is lost so they
> become just a pointless intermediate layer.  Not sure if we can
> do that here.

Fair concern. I was looking at adis16475.c and noticed it already
does the same thing for its FIFO variants (adis1657x family) -
has_fifo =3D true, with a trigger handler that pops a variable sample
count per IRQ instead of exactly one. adis_trigger.c backs this up
too: it already special-cases FIFO devices with a level-triggered,
threaded IRQ instead of the edge-triggered one used for non-FIFO
devices, specifically because the watermark condition needs clearing
over SPI before the line deasserts.

So I thought that since this pattern is already established in the
shared library for exactly this kind of device, it made sense to
follow it here, too.=20

>=20
> > +{
> > +	struct iio_poll_func *pf =3D p;
> > +	struct iio_dev *indio_dev =3D pf->indio_dev;
> > +	struct adis16607 *st =3D iio_priv(indio_dev);
> > +	u8 fifo_sample[ADIS16607_FIFO_DATA_LEN];
> > +	u16 diag_stat, word_cnt, sample_cnt, threshold;
> > +	s64 timestamp;
> > +	int ret, i;
> > +
> > +	mutex_lock(&st->adis.state_lock);
> > +
> > +	/* Check if FIFO threshold is met */
> > +	ret =3D __adis_read_reg_16(&st->adis, ADIS16607_REG_DIAG_STAT,
> &diag_stat);
> > +	if (ret)
> > +		goto unlock;
> > +
> > +	if (!(diag_stat & ADIS16607_FIFO_THR_MET_MASK))
> > +		goto unlock;
> > +
> > +	/*
> > +	 * Disable the FIFO before draining: FIFO_THR_MET means it's at the
> > +	 * configured threshold, and leaving it enabled while we pop would
> > +	 * let incoming samples overwrite ones not yet read. No new samples
> It will overwrite without overflowing?  That's odd if true. If it's the
> overflow case that was true before you started popping so no reason to
> care about it more in this case.  We generally don't disable fifos for
> this reason. The description in the datasheet suggests this is a ring buf=
fer
> rather than a fifo as a fifo never overwrites of you'd not be getting
> the 'first in' but such is the world of datasheets.
>=20

I re-read the datasheet and I agree. I got it all wrong in the first place,=
 as there
was a passage in the FIFO section saying new entries overwrite old ones, bu=
t
that is only if the capacity is insufficient. So it's exactly the overflow-=
only
overwrite you'd expect from a normal ring buffer - not something that happe=
ns
just because a pop is in progress.=20

> Does it at least guarantee no value tearing so worst that happens is we
> get skips of old data if we read to slow?

As per datasheet, "The memory is implemented as 1024 words using a dual-por=
t
architecture so that new data writes and host FIFO reads proceed without
contention."

So no, no tearing - reads and writes are architected not to interfere with =
each other,
which is also exactly what makes draining without disabling safe.

>=20
> Overall other than the overwrite not being controllable, this sounds
> like most other fifos.  We get an overflow if we don't read fast enough.
> In that case and only that case we should flush (though I'm not sure
> we do it even then when we have overwriting as only option).
>=20

On point with the flush, too. The flush is completely optional and makes no=
 sense
to exist here anyway. Will be removing this.

> In short, I'm not seeing the special bit of this implementation that make=
s
> data loss inevitable. Perhaps some spec pointers and quotes would convinc=
e
> me?
>=20

To close the loop: there isn't one. Once FIFO_THR_MET's clear-on-read
behaviour and FIFO_DATA's pointer-advancing pop are accounted for,
this is a standard watermark-triggered ring buffer like any other -
nothing here actually needed the disable step. Dropping it in v4,
along with the flush-and-re-enable that followed it.
