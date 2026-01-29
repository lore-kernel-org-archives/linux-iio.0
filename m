Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 597682EA75E;
	Thu, 29 Jan 2026 14:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769697502; cv=fail; b=JLpbUZovN3uK4umpLptzqvnnsKHu/hEl6tM/LRJkU80HoYBgTPqPxd4YH4hsl9lHcFabu5w8WWUPamQi70280P7uyfi9FQ2MqBgI32x81Vlf8I0QkKCIHXFfcrkfHjDiOZLsQnbZTsZavt8eHaPUI74n6t2pSZ7HY7roElC5p1M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769697502; c=relaxed/simple;
	bh=QeO76RoeOrO0Jps+WqP0I6g/O0qXxe9tsVj8eKQzmyo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Pdqru6tV/rHHDXkg1Ho99zTbQMHix5Y3ARWKdnCdkFhgFqE9uVg+hQiTnbqcLIye5zZJLMr3IaEFqgx2OdEReTeRMo5GJPp/wNkkx/2E5ymjRttMlBKPTxeNyRJqfCwFU7T/lKwmiPf8C9U7a5UiO74J9fSUdqGfhm3hAvZl0AI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=k/wjNruE; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="k/wjNruE"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60T9NQmV3441855;
	Thu, 29 Jan 2026 09:38:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=QeO76
	RoeOrO0Jps+WqP0I6g/O0qXxe9tsVj8eKQzmyo=; b=k/wjNruEEHecXJFG/JWLD
	kJ25iPp27A1cgVrb1FPe7ISaZaRvn80k3iynPoKK/O0PGflfBiAzmVL5TeZ5ux4p
	AK5lznNJWx7vS4hT4yok4JN2OplejqCWqmPOyMBmSMPMbZP2mBCr9SoKA82Kaeom
	sUrX8X8V4O5ldNWYrpVqbRx44XvnAjzojPQoyG4h5doYvbf5/VRtcQyK7sBn+LlM
	9j1o2LhzKgRluO1TvalfsNRgyxlSWq9rFjlBglZClDrHLgibdur18M7gEDUIMHIt
	+K0Zj4Th9rfdcPRQOGbXBYkWtfBRoCtCrDM599oaPuvNlL9+e/016SutAJYEW4Rp
	w==
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010043.outbound.protection.outlook.com [40.93.198.43])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4byfcdnxx0-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 29 Jan 2026 09:38:03 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z2WNWR2gH/bRWeJupNoBUFWw6SZXHIQd8pqty4QHtesnYxgIBHQpSaTgVIN3fHWAHSh/f0lZhr98/+YR1p9ZS/iJE4PHkQEabtbG3YNNa7kfMQ82c/pKxdYpieN8S5rt7VcZIEE6lFd9oxmcb5iPFQZjrLJcdaU47Rhj0eXcGSrAeg+g9kHDXG7e4sYEKBhhPjFMnIsPuOnjwKKO8+xjLd5GQTnacMT/EGvy7L2MrC84H9dci49NDi10uIbCCFs1zmvwgRq+Hy0wv4qIOiB3Nrmhe0m0hXtCtcCesdj2JCWRJ/CHB45Vfkld9jGYsWt80W9Yqod0Lc82Qb2PRh1JDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QeO76RoeOrO0Jps+WqP0I6g/O0qXxe9tsVj8eKQzmyo=;
 b=zMfWXbIKWuynBMocwoHuHXv2WpsOVn7nS9Kla5tWOSuRpmhfIDryhf+47IU2P3wcW0Zr46UhCPXLWEKhbS3aKYItnTUUME8Kh2xmy9kQ4It+pBE7AXo7cu5vu41Q5S2I1n35GdeBRrpfjW5xBWjahCgcbjZowgWbgUZcrv4xfu/hNDEW//u5NQ2xLacZJmqKQi/SbNlWbAgW97h6eUDaDr5DiD/j8Hq/1eZLNpczQw8xWm1lDVUGhg6JN3aTCBKnvrTJLFHwef48iJx5EhsFwd5dGt5IjNDtWy5LLT0s7VuoCU9MzIAkeFn8X0WjwkHZVFdJDkOPvOmYvuTM6wzOXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from CY4PR03MB3399.namprd03.prod.outlook.com (2603:10b6:910:57::13)
 by LV3PR03MB7659.namprd03.prod.outlook.com (2603:10b6:408:28f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.9; Thu, 29 Jan
 2026 14:38:00 +0000
Received: from CY4PR03MB3399.namprd03.prod.outlook.com
 ([fe80::1527:d313:16d4:2376]) by CY4PR03MB3399.namprd03.prod.outlook.com
 ([fe80::1527:d313:16d4:2376%5]) with mapi id 15.20.9542.010; Thu, 29 Jan 2026
 14:37:58 +0000
From: "Miclaus, Antoniu" <Antoniu.Miclaus@analog.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
CC: Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael"
	<Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David
 Lechner <dlechner@baylibre.com>,
        "Sa, Nuno" <Nuno.Sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>,
        "Gradinariu, Ramona"
	<Ramona.Gradinariu@analog.com>,
        Andrew Ijano <andrew.ijano@gmail.com>,
        Gustavo Bastos <gustavobastos@usp.br>,
        "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/3] iio: accel: adxl372: remove unused int2_bitmask field
Thread-Topic: [PATCH 1/3] iio: accel: adxl372: remove unused int2_bitmask
 field
Thread-Index: AQHckSlZ3jAfanZABE+mLd1ukpIFhrVpNKqAgAABSeA=
Date: Thu, 29 Jan 2026 14:37:58 +0000
Message-ID:
 <CY4PR03MB33996493A5C4921B8C8C3B899B9EA@CY4PR03MB3399.namprd03.prod.outlook.com>
References: <20260129141205.106285-1-antoniu.miclaus@analog.com>
 <aXtuexNdZhKvfAg6@smile.fi.intel.com>
In-Reply-To: <aXtuexNdZhKvfAg6@smile.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY4PR03MB3399:EE_|LV3PR03MB7659:EE_
x-ms-office365-filtering-correlation-id: b3b265b4-9f11-49ac-fcec-08de5f43ff95
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?u4JIV2BcvhO1cifm+TivkYMPTcGPm7pePzq7mGGBQxeYRXYerPPavIc5acw6?=
 =?us-ascii?Q?k5284kEjgnEEEPkP5ISQt8Hfitt9obqiuUpHClFEsdq4H0vcd8otu9dUeWP9?=
 =?us-ascii?Q?rzBSExiAdRZDCjbOAfnno0U8wD/nWA3PMgVATRWYS0/OSSJ6JsxlEOEHCqJV?=
 =?us-ascii?Q?KryG1Ozy2xKeeYHb+1piDD3BmSHXlVKouHAWCNC8R6J7+dCYGQaGLMmgFQ1X?=
 =?us-ascii?Q?ptbHx+WrB6BElB2M03Ckg+LOxRNybVAMNhIn5Yb51gdj0ToFhTKpNPJ4NxTv?=
 =?us-ascii?Q?sMOTJhiS/TBg1NzBsdRQTLwIgP9hmTR43kUI+SD5WSMD227oIxRJlZ1dxWc4?=
 =?us-ascii?Q?z/meffJohT+kHmTT/dtasz4h7/ngFie4/75vzGEUUgffzLGFKs/QjZpaUU5i?=
 =?us-ascii?Q?J8sPn0GllM4Xs5Fj17PT7NBq4G2EJ14GDkDiN6Pn8JZ9/EC/kyyPwQrvpky6?=
 =?us-ascii?Q?8Xw7+fRY6ORg502Qc/zVCKkrigFJTF4IGjtVRqzuyqC8+rTUJ45ud0yWHfKX?=
 =?us-ascii?Q?ZY5eg7TrsDujGwnZr3gf7GsfNFMPFEcAcdn1tqeWIVjyVG7lLzG40Opz6jH2?=
 =?us-ascii?Q?0kZR85g34g0vxdL36HVTF+HEltvEfSu3DqG9nnp1vousuLxxVsP2DUdjTkKT?=
 =?us-ascii?Q?BeYpDpASZDbBmuxXuU2Gqcjt+7tRZA/cUaHazi4MRZmHmKfHx4I0x9IjVY4H?=
 =?us-ascii?Q?Py9PG9BrhIA2yYblapbVV8cROSGD/rz7O8b00rNUcEcsO4UV4rZxafaDDQCw?=
 =?us-ascii?Q?ifawAyUUI9hu0i/C2JN64eocBul+RL2af6iywSw/DszdQXB+NhR3V87b8eR0?=
 =?us-ascii?Q?ygXASx5SmV+aywegb6V1PHtVdFxBFnFCRKefc6hV89WffJ3cWGSaC29TA2U6?=
 =?us-ascii?Q?3DncOPYZ/Z7Fz8SHQ7zkODOwvd/QnnlyyEn/TBpLhOnSO4I8CqKdjZjmONL0?=
 =?us-ascii?Q?iSaKYLWTjRWGh+H70MKwwT98NYyvOqF/fFQWK6pO7++P4tnAKoVwnvSf05l7?=
 =?us-ascii?Q?5Jz3R2Y5Ct4GwjOlL5nIIDV9E9mH17ggW+nBJaIYcLvHx0uGvnB+k6d1wTeL?=
 =?us-ascii?Q?nBJFQ7YJdbdrAqWp3QGJOb42pXddxfxo4EAII7xME/c0Bq6URgUjlbdJr6Iv?=
 =?us-ascii?Q?/PrjMQyX9kV5gFzCzpD71GuMLsaEjU0JgwuPcnKbVBAEuGb6xio50CYs582B?=
 =?us-ascii?Q?ysEkNuQ3cD+b4gAcO9h0IDRPVxU70k2o/53+xhq1xSJAtr4NtTy2AeZrr9yq?=
 =?us-ascii?Q?HUtJ2XwzBWXkoNJoX87404Yv6RxYx/abfbGV+KWwpnSm6tvPfChe5bCd1OFQ?=
 =?us-ascii?Q?yXggvThe1DPbsInOUCdthgDq6fS7g7ES9Ir21e+I0z9lNFx1+6JbP4NBmaml?=
 =?us-ascii?Q?yF6QnWae/rEG2pGzBWjh2HiD5LJaRa300Wq11WyMENoMHij+ZyrRKrU6QZZI?=
 =?us-ascii?Q?B6CRO45tqTaaSNMRPZf6Lh9E2pRTxLSKsnh00pmatjj3DSDUz6BWDWP6J5WS?=
 =?us-ascii?Q?k/yKN341D3fONxCjgjUPxquYyBgePlxyCA5KSnyCrDhzEzaGJ4M3buR9I052?=
 =?us-ascii?Q?p7Xt0piidJVoYX3SOnGR4pCvDLQKs/K0MMbVbt3i?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR03MB3399.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?8uGTZ3qCTeUX8sw3fxmEKnmN+1y9ntjCyW0X+5qAlRVwFbN+RGGiGZe6rZET?=
 =?us-ascii?Q?Yv36tuncbaznIdxPkZ/0bjRx0qbnqFsIcR8K4O35jF8+e7OVHpzlbMxOb/BK?=
 =?us-ascii?Q?knNruSONN2ygyXY4nrE38vxW9R3a7eWcICObZmdwctMow1SdpDQNmefYtQZe?=
 =?us-ascii?Q?EWK8la9BWsXDM3lfhMByrenV72l18oVGdj+EJuINAaijoL69u9wjiFPoUnXR?=
 =?us-ascii?Q?urrn3bjqcAah3GuUZY5sZoUcydAIKx1L9Bg+O6qToTfAQp0MJKpml+WWm144?=
 =?us-ascii?Q?fu/c9eh8Lp5iMYVPi85QieErqLed6XZfx4km4gTLQJkp31lEvbcFQmOy1tXQ?=
 =?us-ascii?Q?DYznWAqEy7kb1OdKogQPaFAH+qA0lx900TdAn8242A1lCcvtYPhE2mLrXE8c?=
 =?us-ascii?Q?sFaT1CAAI+RW2gBoAn9U8Ztdlf8+GkwgQ1BNxpkudU22E4IuNuJyXMtIxjY5?=
 =?us-ascii?Q?kzzof1GlnWJmXqj2lSZ/wQcZlNXy9hjGPdeWxHbtEghWvM8YcvnoVA/2+LyJ?=
 =?us-ascii?Q?v07l+EvwLimrsBwYmaVSXyd1UZeXRN8NVNqQ4Uiarop7KK384wppGVXIUFX0?=
 =?us-ascii?Q?gaqyxuAlylmpcw6Za0S3mQzL50Vd3NvuAfrUyR7bMNfLowcxpSKaDIbGDXxh?=
 =?us-ascii?Q?NmDsaqXFT4YOEsq+2gvLt7Sewdre67PNrO9u1kQL/0VcWoQWeabrWHh6+oeF?=
 =?us-ascii?Q?HsN+LNCAIj0XDlE61jkgofKY1yq9RSSpOc+30PJiYp4jD4TdP3URn8QRWIlT?=
 =?us-ascii?Q?AWRhexCUvAPwUy2s0DlwErSmVjOk8kv0ZNLsZVjATM54FjZxzDk27ZDZRsyJ?=
 =?us-ascii?Q?OuPpkL1gqvJ4rGsKlgBR61c1NaAyMJ7Zf2pl5IYbvsEFACWN1pYpzb/ILck8?=
 =?us-ascii?Q?P/ujnOBjFygAf1Vrgql2ma7SJjvVTEFAjbLpmG+D9xCnCIcAvd0IECzbO8A5?=
 =?us-ascii?Q?MWRLedJHPt+71Y5WBHiv6JWr7QywuUdGfLD0YORtGUG8+wAEOiH8y8nM/kls?=
 =?us-ascii?Q?c7dl2P3ibsZgz4Lw72x6/rNcsSPA15tkGkttrkKE6br3GnQ+p6v5OLjg784O?=
 =?us-ascii?Q?6PY+TPnsWysCwzowKK9SUesPLhX8aMVm1HChmufApuKOveJ+Q8BDb5LBNAQd?=
 =?us-ascii?Q?Rz+HQT/nTbjh0M5wtjdhQcndu76EO54R/ii/T4hDJDFynhozMZenkX8XGgGe?=
 =?us-ascii?Q?dzOew9QM76mBKax4u4MjKMB1SRO7pb1pGe/9k1MdiiBT8ynNwuSPBwnJzMbd?=
 =?us-ascii?Q?SKCwWA9AdiK/r4blfS1+NTUt04YkmBRCKATKp81f3f2M96n+yP/vLjq/u5m1?=
 =?us-ascii?Q?tfEds4+m49IHWOk/dq5X9Ah7O2ykeeTjxdYLTAvWlJ/j/rDTtWkHxld6kO46?=
 =?us-ascii?Q?5JA+GPvBcgbx6HOo9ZD474ObNSArBmNpxTPu5jIsWXlVO5iOKoBiMqG7QhiF?=
 =?us-ascii?Q?QdtLwGUJNAckCIWqZXLiljJEyFWpOBueT6ng6m4Keb20SMU3oivfuT32wx48?=
 =?us-ascii?Q?ioehOSXANQVbTFOW62/it3zR3P7T6kew1zSxDvLSHU+JYqTAiv6w3ILZKY0P?=
 =?us-ascii?Q?KGqU+XT6DXM6lvWaOYQo2kbjYdYPPjrdwwdoeYYrW2jR7qjcXlraZhE9GCkG?=
 =?us-ascii?Q?5/lXtwM4k3y3Xb1/JcpLg3hcCB2tnQQJK4LncuMx5gsR11LiqWByvWxH7cYS?=
 =?us-ascii?Q?pZyFSEJELPa9Pt6GYBdHqjaHUmEelEcH8PUh88k1zOLcwfIBVqkybz6AcXMs?=
 =?us-ascii?Q?R70jMpzwTQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR03MB3399.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3b265b4-9f11-49ac-fcec-08de5f43ff95
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2026 14:37:58.8429
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jLPosmgUwrzw5jRhW496dxBVHtuTM4iH8H1fHQ/LQqWFQCHKwwPjqQqXB8b1pxlSeZxKGQIYm71gku1asVC0uU4dGLKH8hDgbKE5i9F/+7E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR03MB7659
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI5MDEwMCBTYWx0ZWRfX6qWmvZEL1pYE
 R66COOcpNMarXte/Py8PJzJg9NKnOtujD8aSGQV1GNgNSHJCgZt6mTUzKzaNkF+nz+SRwzTFgnG
 LBkJzPU577s23UhFN9+WShE4DKemi7/GqHdP79XgGvBRRTxAt/2/OhUXeea/lPsD8N3MYUf6jjL
 fYRutUwpT7lLsQud6QJbpdw+wjl2bAGf7iWqAnAyh8pVYsDo7MAk1FV/CYYfMZZ9O7FTP12pAKH
 UqBGUR3nJaIIRx2e9oBMm+6h2zDBhdU8YY5fIAnjsnzma6Vir55FU47yqOoFZynyYnjoPljMTBb
 FZj+s4IxfyobRKW5905iWDY8y1797kBcYEXZR5IMHocHoEJ37mkVvFTaLsR54idT/NmzqOCWdVz
 Qa+pzoCNoYYeb8wF2W+mETCtV/Jski0BP/P1onKOlbdc+J7or/rU1IlQt6iF0DAU/nVifTwdNw4
 j7hjlSA85pz7deEqCPQ==
X-Authority-Analysis: v=2.4 cv=TqDrRTXh c=1 sm=1 tr=0 ts=697b70cb cx=c_pps
 a=CcIcsZDwO3wB2ho3dvPJ0Q==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=uherdBYGAAAA:8 a=NEAV23lmAAAA:8
 a=QyXUC8HyAAAA:8 a=gAnH3GRIAAAA:8 a=VwQbUJbxAAAA:8 a=IpJZQVW2AAAA:8
 a=pGLkceISAAAA:8 a=yXtChU5jXySruGja37UA:9 a=CjuIK1q_8ugA:10
 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-ORIG-GUID: wJ65IZKJILcU1_sbDnoIFanVCnN9GVPz
X-Proofpoint-GUID: wJ65IZKJILcU1_sbDnoIFanVCnN9GVPz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-29_02,2026-01-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501 bulkscore=0
 suspectscore=0 phishscore=0 clxscore=1015 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601290100

> -----Original Message-----
> From: Andy Shevchenko <andriy.shevchenko@intel.com>
> Sent: Thursday, January 29, 2026 4:28 PM
> To: Miclaus, Antoniu <Antoniu.Miclaus@analog.com>
> Cc: Lars-Peter Clausen <lars@metafoo.de>; Hennerich, Michael
> <Michael.Hennerich@analog.com>; Jonathan Cameron <jic23@kernel.org>;
> David Lechner <dlechner@baylibre.com>; Sa, Nuno <Nuno.Sa@analog.com>;
> Andy Shevchenko <andy@kernel.org>; Gradinariu, Ramona
> <Ramona.Gradinariu@analog.com>; Andrew Ijano
> <andrew.ijano@gmail.com>; Gustavo Bastos <gustavobastos@usp.br>; linux-
> iio@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH 1/3] iio: accel: adxl372: remove unused int2_bitmask =
field
>=20
> [External]
>=20
> On Thu, Jan 29, 2026 at 04:11:57PM +0200, Antoniu Miclaus wrote:
> > Remove unused int2_bitmask field from adxl372_state struct.
> > The field is declared but never accessed in the driver.
>=20
> While patches are okay, you have two issues with the series (or three):
> - the email thread is not a thread, missed --thread?

Thanks for pointing that out. I never used --thread before, is the first ti=
me I am=20
seeing it mentioned in a review.

> - the series lacks of a cover letter

True. Will do that in v2 (if changes requested). Btw, for these small chang=
es if they
aren't placed in a series but individually I guess I can skip the cover let=
ter?

> You can use my script [1] to make it not forgotten.
>=20
> [1]: https://urldefense.com/v3/__https://github.com/andy-shev/home-bin-
> tools/blob/master/ge2maintainer.sh__;!!A3Ni8CS0y2Y!48H-
> JjuYcJZ2OfRfcWweVwMeYt0ghmCKzi1zlIX6jeIA15T0zhb28_T2Zj1YrAL8ho-
> gPXrtsmWhbYh4wW8N1TrsINiFNkI$
>=20
> P.S. I hope that this simple thing can be caught during internal reviews.=
..
>=20
> --
> With Best Regards,
> Andy Shevchenko
>=20

