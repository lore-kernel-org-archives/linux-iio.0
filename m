Received: from mx0b-00549402.pphosted.com (mx0b-00549402.pphosted.com [205.220.178.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D3C32571D;
	Thu, 19 Mar 2026 19:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773950156; cv=fail; b=mP0mb8ZTIeTfsKvXYjbIyEujVSkgog+4GnRlJp5GERvcuysR9DCdd5Isd2Wdm2kYtNaNbj6NYUioeNo2YGRSHTURbxQA1Kto66rdvMu745Gof5uIpjP1PvV380kEFojlGJZuLWMZ0e4eHke3sUxuHaQDHOdSwxupwoPDY420OnA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773950156; c=relaxed/simple;
	bh=N19Zd6V+lLU9TgIEAbQnB7hzyygkBAdDF5RGtulQFSo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BDiJX3snhi+vNW3vzEAAg8Zw2w5Qud0G+T9rwVllufuhWyCSYx64EWcH91Uma41i57iLemvAmpWVIcvSNk1Fy4e81LajjbjLQGhpAxSp6Ig2RN3waTxC8RHpHk6KxS/A9sK0OSqDfXgX7fQzb5umN8bGlo0WEsPuRchvQc2ned0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com; spf=pass smtp.mailfrom=tdk.com; dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b=f4OWTkee; arc=fail smtp.client-ip=205.220.178.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tdk.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b="f4OWTkee"
Received: from pps.filterd (m0233779.ppops.net [127.0.0.1])
	by mx0b-00549402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62JJn14h1314937;
	Thu, 19 Mar 2026 19:55:28 GMT
Received: from beup281cu002.outbound.protection.outlook.com (mail-germanynorthazon11010048.outbound.protection.outlook.com [52.101.169.48])
	by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 4cw11gv8q7-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 19 Mar 2026 19:55:27 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=De6uaJp1tJX2okK3Z8us8O05c8D+vn4dY2wqS9w+hQAiiM82VS52o6/GfYqK8gO3UMOGjEZCdYcwdWnOw2dNZ93AFWQ1VCc4CKa7Hihf0aDpB1wVHu7pYluraq211xdYkYM5zCcnceBGnv0bB9fwVtoas9Ic5dFdoXAxgkPORSiMT0kfsp0t8w+xYA49Cm1pclXUmUeMz7Fu5ScHdqByTI8cyz5DRMGbZFdWObBLxZY1s6TXRtb719snLMYgMxf0PrV1VtcNoE6xxpQkNM3sy9cwosEre97J2B3k4NDp9DqnSfQ6vyTwzvCo2abEtR9DKEg+S621xqGfYr7gtfDnVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N19Zd6V+lLU9TgIEAbQnB7hzyygkBAdDF5RGtulQFSo=;
 b=IvKoej2XZCRq51f+UdU6E7o5x0UipymYV0e4OlDdoLW566Q/6qxGXRMb10ZqfNHux3LJtO3dbZXfvO4OxMkXhM/MJctGCx2tcSoVbKP3tvQ0+8tq3b1p3vL7yLfUPrDg2D8zMUgqnKutEA+sEqQ27GtvR1hSkAcu0vO2edcwFC1eTH73SiqOyX+NXu+vTVUq60S9Yp/T8EHrWChIQoHmCr4tmu2bEDfSUEqeAfxnvLsWr/n1vuR6MBkYe5rhUL4w6fMV+3eIxElxOmGjijCqdGHVzb2xHlPuZ89Is/eFDxpnZ2lyKIlVuvxbI3HudeyPAda4of1jZxVYoSTpU9gpWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N19Zd6V+lLU9TgIEAbQnB7hzyygkBAdDF5RGtulQFSo=;
 b=f4OWTkeeD1QFCeZFaPSLHq7mjzHMceb+KxNfjYCtopg75cPHrLx/UToDZzsvlmgqKx5GFvZjUBtj0fzS6aifaTEqb74Tgn4g0gZyhrQX9cFNGqPkOuXY5j7ToNQt2bstL4ioVdyNiQlkak2PHKSmIFF8+ouL5p1IEzaW+Rpk/+UTwALsCFyfiVguzBS0UG1AUOn/4DA21h6B6FEwqVUIduL8yip5MCKiDOsDW/+aNBG1h6EapYWvCOr2/bC5Fq9hdxyTBL9mB0Zps5nde9SGfl4JMnAuovJ2ZN4X1Sb0DxVC5Dos61Y+2UucK85tPF1mdQEhah5fiFY6n8lX0H/3FA==
Received: from FR3P281MB1437.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:6c::8) by
 FR5P281MB4112.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:106::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.20; Thu, 19 Mar 2026 19:55:21 +0000
Received: from FR3P281MB1437.DEUP281.PROD.OUTLOOK.COM
 ([fe80::5407:b7b5:1dbc:9b87]) by FR3P281MB1437.DEUP281.PROD.OUTLOOK.COM
 ([fe80::5407:b7b5:1dbc:9b87%3]) with mapi id 15.20.9723.018; Thu, 19 Mar 2026
 19:55:20 +0000
From: Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
To: Chris Morgan <macroalpha82@gmail.com>,
        "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>
CC: "andy@kernel.org" <andy@kernel.org>,
        "nuno.sa@analog.com"
	<nuno.sa@analog.com>,
        "dlechner@baylibre.com" <dlechner@baylibre.com>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "linux-rockchip@lists.infradead.org"
	<linux-rockchip@lists.infradead.org>,
        "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>,
        "heiko@sntech.de" <heiko@sntech.de>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "andriy.shevchenko@intel.com" <andriy.shevchenko@intel.com>,
        Chris Morgan
	<macromorgan@hotmail.com>
Subject: Re: [PATCH v2 0/5] Add Invensense ICM42607
Thread-Topic: [PATCH v2 0/5] Add Invensense ICM42607
Thread-Index: AQHct87A2IM7sFoqB0WnqvNWntoW6bW2RHm0
Date: Thu, 19 Mar 2026 19:55:19 +0000
Message-ID:
 <FR3P281MB1437798EE08EADF674E42526CE4FA@FR3P281MB1437.DEUP281.PROD.OUTLOOK.COM>
References: <20260319182956.146976-1-macroalpha82@gmail.com>
In-Reply-To: <20260319182956.146976-1-macroalpha82@gmail.com>
Accept-Language: en-US, fr-FR
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FR3P281MB1437:EE_|FR5P281MB4112:EE_
x-ms-office365-filtering-correlation-id: 6126e535-572c-4ef1-8e58-08de85f172e1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|7416014|376014|10070799003|1800799024|366016|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info:
 H4W9g6Tb19/sMwpxociL0aIeKhOTxkIXeYwqAxhKl6eOaPMAOWMRe3FRvzFBJd/tTdT31MM/fctULvH+I4G0oIG+ghVV2XVXp+WOvyrqEknsaROpSoECQUY2OoiTAsOjFVBdyJQqeD8i4y59kFA24sX0PD8T0LruliJMbZpZ8UO2/h0SEzPFn2A1wax+/512B+GmuadfTw4sYZeg9DfFUJQ46yDHGujptACqo1TuaR0wVGudvUvx0yqnTgYbnbDxOUxfd5kFk3IMFA+8Zw0EXwRLsWbbevgCS9jVQywM9mkePOd/VjVy1Ne9NxMH98wcn/cjD4Ilt7sLYGPq+pXwmKFAtmRJ3iiWYlRh8La9HpVMH0TKZwioCKiDw+IXrQ4xaYYqZswRzxPEs1e+4ZevHzpby7+OZF/3VeICg8/mI/Dq/2CgIBzMmFTez2tYKSF5Whri1K86L5d06cEfmkFaE0dTzFbh2tGh2wtURllVmSI35UUefRwL4CVNjXjaUD5z1R/5Puir+7OYRxwJSacviL/MvwNEqIbCbJAGAhOuupy6Idm76Wd2O8zg8gipUmpqdFCQX/FaIZjqcDAZUm77Jq3y3Wo1RMX68Buiqkl2Ba76Mflx4P8cFmpzJevw04YoMWTzSGZfP8tM5PwdvLY7fAbJ9q1MAwG29azYXBkktWeVOjlgf9dsU8sezy80NvPe6PRtfmmBAbObgf+bIdElIVV9f9lwikIoXeedx8SZfUQHYUR2e1ebdmCw+l60mdUkf9JlKuUjQszdWrOCfPCiETmf2uD/UPVd9tc9pF9/Nkw=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR3P281MB1437.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(7416014)(376014)(10070799003)(1800799024)(366016)(38070700021)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dGI5djhXa1Rvai9id1ZNRXpFMFcwSUdkblg2UUw5RThSUWxsaWVEQWRIb0Rq?=
 =?utf-8?B?Vmt3S3pwam1uWm9raTBmdGNoTmgyM2wva3FRQVNONXhuZDErL1dnWmVWUHFt?=
 =?utf-8?B?MzhrZnl4VXExR09TaUNQRXhmWG42RHlteVAyRkpvNGlwa3E0YWEwRmNzNzF3?=
 =?utf-8?B?YXgwU0RDQ1dnTFJUbzV3UE5BeGxueWtUa1g4M05uSFdSbWoxTVVuSVJXNGN6?=
 =?utf-8?B?eUtYRlNlb2oxbml6Q1QwRzlWMVRrVjBQNDY2Vk53cnB3V2RYZWFhcXgvRUFh?=
 =?utf-8?B?T3dkbHNtN2tCT2tBcnhqK3pYZnhsK2hJb1lKZ2dKQW9rVDBubFgybnJnWXB1?=
 =?utf-8?B?MTk2ZVQvNzFLUDFZNXlyM1Z6c1VjdlJmYXVJTWlmMjg2OGh2S1FLRE9HVkc3?=
 =?utf-8?B?elYwb0xaYndMZXNIZU9hbUs3WFF3ZElwQjNXN1pib2QvSklmRDhFaVFSUFR6?=
 =?utf-8?B?a09rTVZpYlh6eWlzTFdsdGRYTFVkcDA0eEhpdHMvTnNrY25BVlJIVEs0aEZV?=
 =?utf-8?B?dno1NDdVYnpEenkwRHZsdFY2Z3UxZUZrM3YyUEVHdEExMlBGb3J4Rks5NFE0?=
 =?utf-8?B?RXNnUWNoZ0RISzdUQWFRNnRUMHRZVGsyS1h2cllSVVBGQ0E4ZTRKbDFYUGtN?=
 =?utf-8?B?Q0djVDZrSlNnOGhxcDBhMUtCSWEzVFlMY29tZ3dLUjljK05CcVNzaHEwVDI4?=
 =?utf-8?B?amMrRHR3M3NIZGZjQ3gvenRUQ00zOWwzY3IreGduZGdHbVdGUWpoc09qcVNV?=
 =?utf-8?B?SWZ0dUt5dk01R0lva1dtR1laZ2tFMTFWNUppajdJQ3hSUFUwakFNVUg3KzJI?=
 =?utf-8?B?c3JPL0kwMXhkT2lRY2YxWHZHVTE3Y2o4V1BWSWpZV2M1NVFCdnFORFo4dnBk?=
 =?utf-8?B?VXNrQWZlUDZZaGp2MGhaZzVNeGF6cGcyV2VlNDlSWGdsNWNETnM2OEplYTVL?=
 =?utf-8?B?czVON3VzbDVndUZzZC96a3VKTUtsTm9JOFF3cjMrd2FYRW9xdml2ZThPSml6?=
 =?utf-8?B?YTlyRWZKejN0ejZ6YStmNXF1RFZCa1g3ZDd0T2JrRWlTb09JcEVjM2hJMVE4?=
 =?utf-8?B?WDZOMTFLSS81dm45aTNsTmlKTVMxcnY2VXdmcFJpNWdmMnR1SGFlaGNZQXRU?=
 =?utf-8?B?czA2V0JXSFByRUJZbE9sdjFyZnhSWnZvcG1NbGFzeE1mZTgwcVdTTU9WYjFM?=
 =?utf-8?B?UXY2TndjaHA5OGFtWHhpY3g2TkpUeXN3OWEvOUpyWUxVRnNWQ1lkb09lTUJ6?=
 =?utf-8?B?YWZ2S1R3VTNYTlVJdndHVk0zNEl2K0I2K3ExNEhPZmw5SlRhbkltZW9teHRN?=
 =?utf-8?B?NlZRdXNzWWxoTjFHdW9DWVU5NE5OK2JnM3hzN1V6a1hyc3U2TFdCWUhTM0hv?=
 =?utf-8?B?K1BhOExkdk04M2N6QmMycmdsREdFa0g0b291NW9NSzM1dXh6UndzS25YSXJ4?=
 =?utf-8?B?U05JRmNMMks0S2hJeGhKZFVTaFhjUDdZdlpCaTVnT3BKKzh4ZGZhVXZqc0xa?=
 =?utf-8?B?STdrWVhWS1NoNjlFd3piWnFCZWhKYzE4MUdYRG5FdTJqR0l1bEtrUmlJZVVZ?=
 =?utf-8?B?dy9hYzFuSUZxT2ZNNWs4S0dYaTNiY2N6azRFQW45eitLMnAwUUhveGhaQTZK?=
 =?utf-8?B?MklJZVNSWUg5MTJZLysyMkZkMjVTR1VqWFZjK2ZuTERVNzlIc1p2UDJ1d3B0?=
 =?utf-8?B?Q28xVDFlT3pyUzFtYy9sR2sxVjZMejgzRTZCZ1MxcW5OMXAzZ3ZIMDc1OXJr?=
 =?utf-8?B?V2RXR0dWUG9PMTl0Q3JSU2ZERHloZ0l3VDh1ZW5OK1RwS2FPcWFNQ2E0a000?=
 =?utf-8?B?TkZUbnQxRGR4N2R0QldJV21Yam0wWDdGMjJYTjhLM0NtZktqVVlFQ0NYV2VS?=
 =?utf-8?B?UnJkWEdqc0pBcnJrL1BrYlhURGFUY2NWcDBLSUNvMGFkV3d6YU1pYVFEWkNU?=
 =?utf-8?B?aEZBS21oamcxMzNPcDQ5Nmh4WGRQVUZpd0JmVVp3SkNScDdoS0hhZ0pPZ1d5?=
 =?utf-8?B?QkgxTVRMZDAwWWN3YVNyclZ2anhlWjZJRmVqQ2VNUVJKWTRzVmZSejFvT0xq?=
 =?utf-8?B?QmNWQllDMHlsMWcxN3F6aTVpL210UG1nanlNS2ZaR3NkNWpITXdUVUwwSHVy?=
 =?utf-8?B?emZvcm9DbjlrN01JdXpXWXY3RzB6cHZoUUJmVWtHVFFzSmtsNnhtd2pXOTQ1?=
 =?utf-8?B?RkpEaHN1SEhIMHhxWmJuWjJWcjBDTDhIT0hpYXVVWmFpNE9lWVczNEwwelhK?=
 =?utf-8?B?RjJhVUl6ZEl0MlVpQTgxTk5qQmEyNUk3QUdGYmY3a2tOQk5rV0wyZVJsS2xU?=
 =?utf-8?B?ZnVRczN4b1g5OGI1Q29xcjBYQ2swdS81b1greFcxK3JERlROTkRqa2hJdGFB?=
 =?utf-8?Q?QCf37fWQE1zRPe7RYZJinIgyAtS7LbYdwxdUThm9RzyNZ?=
x-ms-exchange-antispam-messagedata-1: uWS3ny+EOJlrxnNwKaf9U1pbFJZkCdE2mjk=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	MUGIg431sEq/3Wzgg3kFj2sX4cpGzOeGYtodeFfwCm9Xj9ZDT1NUe0NWyN/sSJIWyCFmXv4OpW7uh5JeqEHqC5yrOeGOPdRlIHK163DMgu/ESYuOO4acqBldmBLEHHelJ3qJOI4KlJl5FnYAG+RV8hF8r97Sm24gzW5vu2wJhpw/Xv+syeNRtbFJeP1q1yrVgOUwDY4+mBKhkvwh0+EYt2dxZEvLvsQlL1KMk48SQA9O5cQZotGigpmVxaKslihia2q4vFsVz71DNc4V/RxRLd8HnSJ55rjFmGyU9wAUe+2z0M9NN21uGJsiMKfJeXnmVbr7v67XxJg1tQrKNgGxrQ==
X-OriginatorOrg: tdk.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: FR3P281MB1437.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 6126e535-572c-4ef1-8e58-08de85f172e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2026 19:55:19.3769
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KHsnqkMZpgp7SZlaaDDihA6a0/MGANuven/CqXITAqxZQpUrLRhlsSVdZXt4CwVjBTkvSyPaMoms3ahQ9897XuvELUMXDmTlKcQI/r3Ug00=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR5P281MB4112
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=AIx+R2tb c=1 sm=1 tr=0 ts=69bc54b0 cx=c_pps
 a=vW0yxx0R3S/VTeG8hBLm9w==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=Uwzcpa5oeQwA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=W6z64dnQKVPvYeLC5f8l:22 a=NpUDEC63da1vOGE9rZHW:22 a=pGLkceISAAAA:8
 a=VwQbUJbxAAAA:8 a=gAnH3GRIAAAA:8 a=IpJZQVW2AAAA:8 a=In8RU02eAAAA:8
 a=JfrnYn6hAAAA:8 a=QyXUC8HyAAAA:8 a=69EAbJreAAAA:8 a=O84Bva3iYNzuhl-BF9EA:9
 a=QEXdDO2ut3YA:10 a=IawgGOuG5U0WyFbmm1f5:22 a=EFfWL0t1EGez1ldKSZgj:22
 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-GUID: wNa1rcJKrw3HQ0mMyA54_qQ1iQAmwlmE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE5MDE2MCBTYWx0ZWRfX6wfHRU5rYrie
 Hf4obTEsrk9ZsJYMd7da8a/vMIKd66HEr9wdIDku4Cri5VKIQknnBA1nDtNGuIGDzgMtJQOnwX7
 dKFfTETEhPihdHyrHUDD0HFIGt7P1eUktlumvfLVtEoRDvDpljqlgs5ltR1jrg3N9jJg+EGnbwf
 UDVPRT5hXGZxLsgPAnm+bXUoJRD8KULnDSxF5kSqP7xIuQsD++qmhjdEgmrJvZQJ6FsruNV7hKx
 M8JX2B8mfTcdM0qSiA0WNbeyWid2HxAzvYHyQNSGJyvkg63Vma3m1psgXWKlSa6XGVg4lb2Gvyi
 hy3BBVBsXn6MebUZFRmOiTH3ip8JihHyrW9fYHn4TvqEFkY9gXbRGvmAhB8BpfKjhlpIR2TOvI1
 yAersCz4J4+oerewi2KCycZmv2A74nYUYM7Q21kH8IIYGktiJQXHT/BGLXDZeQ9uPrttcxJuhDo
 Um/bfizjz4RqqrLtwSg==
X-Proofpoint-ORIG-GUID: WFLMRlXQIx0i8zGrOo9q1s_EOv_buMIi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-19_03,2026-03-19_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0
 spamscore=0 malwarescore=0 adultscore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 clxscore=1011 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603190160

Pgo+X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+RnJvbTrCoENocmlz
IE1vcmdhbiA8bWFjcm9hbHBoYTgyQGdtYWlsLmNvbT4KPlNlbnQ6wqBUaHVyc2RheSwgTWFyY2gg
MTksIDIwMjYgMTk6MjkKPlRvOsKgbGludXgtaWlvQHZnZXIua2VybmVsLm9yZyA8bGludXgtaWlv
QHZnZXIua2VybmVsLm9yZz4KPkNjOsKgYW5keUBrZXJuZWwub3JnIDxhbmR5QGtlcm5lbC5vcmc+
OyBudW5vLnNhQGFuYWxvZy5jb20gPG51bm8uc2FAYW5hbG9nLmNvbT47IGRsZWNobmVyQGJheWxp
YnJlLmNvbSA8ZGxlY2huZXJAYmF5bGlicmUuY29tPjsgamljMjNAa2VybmVsLm9yZyA8amljMjNA
a2VybmVsLm9yZz47IEplYW4tQmFwdGlzdGUgTWFuZXlyb2wgPEplYW4tQmFwdGlzdGUuTWFuZXly
b2xAdGRrLmNvbT47IGxpbnV4LXJvY2tjaGlwQGxpc3RzLmluZnJhZGVhZC5vcmcgPGxpbnV4LXJv
Y2tjaGlwQGxpc3RzLmluZnJhZGVhZC5vcmc+OyBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZyA8
ZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc+OyBoZWlrb0BzbnRlY2guZGUgPGhlaWtvQHNudGVj
aC5kZT47IGNvbm9yK2R0QGtlcm5lbC5vcmcgPGNvbm9yK2R0QGtlcm5lbC5vcmc+OyBrcnprK2R0
QGtlcm5lbC5vcmcgPGtyemsrZHRAa2VybmVsLm9yZz47IHJvYmhAa2VybmVsLm9yZyA8cm9iaEBr
ZXJuZWwub3JnPjsgYW5kcml5LnNoZXZjaGVua29AaW50ZWwuY29tIDxhbmRyaXkuc2hldmNoZW5r
b0BpbnRlbC5jb20+OyBDaHJpcyBNb3JnYW4gPG1hY3JvbW9yZ2FuQGhvdG1haWwuY29tPgo+U3Vi
amVjdDrCoFtQQVRDSCB2MiAwLzVdIEFkZCBJbnZlbnNlbnNlIElDTTQyNjA3Cj7CoAo+RnJvbTog
Q2hyaXMgTW9yZ2FuIDxtYWNyb21vcmdhbkDigIpob3RtYWlsLuKAimNvbT4gQWRkIHN1cHBvcnQg
Zm9yIHRoZSBJQ000MjYwNyBJTVUuIFRoaXMgc2Vuc29yIHNoYXJlcyB0aGUgc2FtZSBmdW5jdGlv
bmFsaXR5IGJ1dCBhIGRpZmZlcmVudCByZWdpc3RlciBsYXlvdXQgd2l0aCB0aGUgZXhpc3Rpbmcg
SUNNNDI2MDAuIFRoaXMgZHJpdmVyIHNob3VsZCB3b3JrIHdpdGggdGhlIElDTTQyNjA3IGFuZCBJ
Q000MjYwN1AKPlpqUWNtUVJZRnBmcHRCYW5uZXJTdGFydAo+VGhpcyBNZXNzYWdlIElzIEZyb20g
YW4gVW50cnVzdGVkIFNlbmRlcgo+WW91IGhhdmUgbm90IHByZXZpb3VzbHkgY29ycmVzcG9uZGVk
IHdpdGggdGhpcyBzZW5kZXIuCj7CoAo+WmpRY21RUllGcGZwdEJhbm5lckVuZAo+RnJvbTogQ2hy
aXMgTW9yZ2FuIDxtYWNyb21vcmdhbkBob3RtYWlsLmNvbT4KPgo+QWRkIHN1cHBvcnQgZm9yIHRo
ZSBJQ000MjYwNyBJTVUuIFRoaXMgc2Vuc29yIHNoYXJlcyB0aGUgc2FtZQo+ZnVuY3Rpb25hbGl0
eSBidXQgYSBkaWZmZXJlbnQgcmVnaXN0ZXIgbGF5b3V0IHdpdGggdGhlIGV4aXN0aW5nCj5JQ000
MjYwMC4KPgo+VGhpcyBkcml2ZXIgc2hvdWxkIHdvcmsgd2l0aCB0aGUgSUNNNDI2MDcgYW5kIElD
TTQyNjA3UCBvdmVyIGJvdGggSTJDCj5hbmQgU1BJLCBob3dldmVyIG9ubHkgdGhlIElDTTQyNjA3
UCBvdmVyIEkyQyBjb3VsZCBiZSB0ZXN0ZWQuCj4KPkNoYW5nZXMgU2luY2UgVjE6Cj4gLSBJbnN0
ZWFkIG9mIGNyZWF0aW5nIGEgbmV3IGRyaXZlciwgbWVyZ2VkIHdpdGggdGhlIGV4aXN0aW5nIGlu
dl9pY200MjYwMAo+IMKgIGRyaXZlci4gVGhpcyBuZWNlc3NpdGF0ZWQgYWRkaW5nIHNvbWUgY29k
ZSB0byB0aGUgZXhpc3RpbmcgZHJpdmVyIHRvCj4gwqAgcGVybWl0IHVzaW5nIGEgZGlmZmVyZW50
IHJlZ2lzdGVyIGxheW91dCBmb3IgdGhlIHNhbWUgZnVuY3Rpb25hbGl0eS4KPiAtIFNwbGl0IGNo
YW5nZXMgdXAgYSBiaXQgbW9yZSB0byBkZWNyZWFzZSB0aGUgc2l6ZSBvZiB0aGUgaW5kaXZpZHVh
bAo+IMKgIHBhdGNoZXMuIE5vdGUgdGhhdCBwYXRjaCAwMDA0IGlzIHN0aWxsIHByZXR0eSBoZWZ0
eTsgaWYgSSBuZWVkIHRvIHNwbGl0Cj4gwqAgZnVydGhlciBJIG1heSBuZWVkIHRvIGNyZWF0ZSBz
b21lIHRlbXBvcmFyeSBzdHViIGZ1bmN0aW9ucy4KPiAtIFVzZWQgZ3VhcmQoKSBhbmQgUE1fUlVO
VElNRV9BQ1FVSVJFX0FVVE9TVVNQRU5EKCkgb24gdGhlIG5ldyBmdW5jdGlvbnMKPiDCoCBwZXIg
Sm9uYXRoYW4ncyByZWNvbW1lbmRhdGlvbnMuCj4KPkNocmlzIE1vcmdhbiAoNSk6Cj4gwqBkdC1i
aW5kaW5nczogaWlvOiBpbXU6IGFkZCBpY200MjYwNwo+IMKgaWlvOiBpbXU6IGludl9pY200MjYw
MDogQWRkIHN1cHBvcnQgZm9yIHVzaW5nIGFsdGVybmF0ZSByZWdpc3RlcnMKPiDCoGlpbzogaW11
OiBpbnZfaWNtNDI2MDA6IEFkZCByZWdpc3RlcnMgZm9yIGljbTQyNjA3Cj4gwqBpaW86IGltdTog
aW52X2ljbTQyNjAwOiBBZGQgc3VwcG9ydCBmb3IgaWNtNDI2MDcKPiDCoGFybTY0OiBkdHM6IHJv
Y2tjaGlwOiBBZGQgaWNtNDI2MDdwIElNVSBmb3IgUkctRFMKPgo+IC4uLi9iaW5kaW5ncy9paW8v
aW11L2ludmVuc2Vuc2UsaWNtNDI2MDAueWFtbCB8IMKgIDQgKwo+IC4uLi9kdHMvcm9ja2NoaXAv
cmszNTY4LWFuYmVybmljLXJnLWRzLmR0cyDCoCDCoHwgwqAyMCArLQo+IGRyaXZlcnMvaWlvL2lt
dS9pbnZfaWNtNDI2MDAvaW52X2ljbTQyNjAwLmggwqAgfCAzMzMgKysrKysrKy0KPiAuLi4vaWlv
L2ltdS9pbnZfaWNtNDI2MDAvaW52X2ljbTQyNjAwX2FjY2VsLmMgfCA0OTcgKysrKysrKysrKy0K
PiAuLi4vaW11L2ludl9pY200MjYwMC9pbnZfaWNtNDI2MDBfYnVmZmVyLmMgwqAgwqB8IDI0MCAr
KysrKy0KPiAuLi4vaW11L2ludl9pY200MjYwMC9pbnZfaWNtNDI2MDBfYnVmZmVyLmggwqAgwqB8
IMKgIDUgKwo+IC4uLi9paW8vaW11L2ludl9pY200MjYwMC9pbnZfaWNtNDI2MDBfY29yZS5jIMKg
fCA3OTUgKysrKysrKysrKysrKysrLS0tCj4gLi4uL2lpby9pbXUvaW52X2ljbTQyNjAwL2ludl9p
Y200MjYwMF9neXJvLmMgwqB8IDM3OSArKysrKysrKy0KPiAuLi4vaWlvL2ltdS9pbnZfaWNtNDI2
MDAvaW52X2ljbTQyNjAwX2kyYy5jIMKgIHwgwqA1MyArLQo+IC4uLi9paW8vaW11L2ludl9pY200
MjYwMC9pbnZfaWNtNDI2MDBfc3BpLmMgwqAgfCDCoDU5ICstCj4gLi4uL2lpby9pbXUvaW52X2lj
bTQyNjAwL2ludl9pY200MjYwMF90ZW1wLmMgwqB8IMKgNjQgKysKPiAuLi4vaWlvL2ltdS9pbnZf
aWNtNDI2MDAvaW52X2ljbTQyNjAwX3RlbXAuaCDCoHwgwqAgNCArCj4gMTIgZmlsZXMgY2hhbmdl
ZCwgMjI4OSBpbnNlcnRpb25zKCspLCAxNjQgZGVsZXRpb25zKC0pCj4KPi0tIAo+Mi40My4wCj4K
PgoKSGVsbG8gQ2hyaXMsCgp0aGFua3MgZm9yIHRoZSBwYXRjaCwgYnV0IGJld2FyZSB0aGF0IHRo
ZXJlIGlzIGEgbWFqb3IgZGlmZmVyZW5jZSBiZXR3ZWVuIHRoaXMKY2hpcCBhbmQgaW52X2ljbTQy
NjAwIGNoaXBzIGZhbWlseSB0aGF0IGlzIHByZXZlbnRpbmcgdG8gaGF2ZSBhIGNvbW1vbiBkcml2
ZXIuCgppbnZfaWNtNDI2MDAgY2hpcHMgYXJlIHVzaW5nIGRpcmVjdCByZWdpc3RlciBhY2Nlc3Mg
d2l0aCBiYW5rIHdoaWxlIGljbTQyNjA3CmNoaXAgaXMgdXNpbmcgaW5kaXJlY3QgcmVnaXN0ZXIg
YWNjZXNzIHVzaW5nIElSRUcgc3BlY2lmaWMgcmVnaXN0ZXJzLiBTb21lCnJlZ2lzdGVycyBjYW5u
b3QgYmUgcmVhZC93cml0ZSBkaXJlY3RseSBhbmQgcmVxdWlyZXMgcHJvZ3JhbW1pbmcgc3BlY2lm
aWMKcmVnaXN0ZXJzLiBUaGUgbWVjaGFuaXNtIGlzIHNpbWlsYXIgdG8gdGhlIG9uZSBpbiBpbnZf
aWNtNDU2MDAgZHJpdmVyLCB5b3UgY2FuCmhhdmUgYSBsb29rIGluIHRoaXMgZHJpdmVyLgoKVXNp
bmcgdGhlIHNhbWUgZHJpdmVyIGlzIG5vdCBwb3NzaWJsZSBJIHRoaW5rLCBzaW5jZSByZWdpc3Rl
ciBhY2Nlc3MgaXMgZGlmZmVyZW50LgoKQW5kIHRoZXJlIGFyZSBhbHNvIG1vcmUgZGlmZmVyZW5j
ZXMgYmV0d2VlbiB0aGUgMiBjaGlwIGZhbWlsaWVzIHRoYXQgaXMgbWFraW5nCmEgY29tbW9uIGRy
aXZlciBxdWl0ZSBkaWZmaWN1bHQgdG8gZG8uCgpUaGFua3MsCkpC
