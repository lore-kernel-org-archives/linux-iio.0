Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8C573B52E0;
	Mon,  9 Mar 2026 13:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773061734; cv=fail; b=c66QW90kvTGDy1+bGFlkV6Z44GoEgm19Bnd1535uFdFJNDv+ouximLgLT6aPE1YxZ2F3V180gX49lhRW1pkS3Opt0DfM6JJksdjbyE/h0cezTK5sSqVfD8/gqi7t1V+0hbp9iUbnplAOUasKTnqW1QPsgmO+80tofNMUHcXDIEE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773061734; c=relaxed/simple;
	bh=iedvHrKOdRKyJ0p4AHgS5uSsY2RqBAzQbR19F+/cROA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eU+3FOznauzZOM6l6iYAsNQ2q49nutFu0Bf4O3LTQFyg9pTVioybQV68sIUDAVd9czQQy2n4FpVp+eL5F8c8JmJvYltp2AF0UM2D07UDgKR60YKuXxZR6xlT4U07lxw5xKfooWOHZPuz0ZDEr/X69xkl2bNj9JDTGFSA+tADV4o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=l9bEBfSZ; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="l9bEBfSZ"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6298Zire2800060;
	Mon, 9 Mar 2026 09:08:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=x4txh
	T74SfC7K1+/KNGWlFSaiovK+ziSQsjQP+fuZgw=; b=l9bEBfSZ2oUAsznraRpbt
	7nipzNQ15f3hdmRQa56UnuqnNQwH8rO1nnIE38g6iSmMYnYYzUNF8BHRohtmvDA9
	mLG+XJ/DL9nV4Fn58qSjLNOwiNqJt3aDT0NfOwahNZDMxSKNQNJix2gd+AZWlK8n
	dIttm+cwZBk7Z6wZguvWXi7f7qPnjsAQgUCngolRt9qt5Z+HMTLYtZ3jT9olBjuM
	1B5JpK0zn+GAqj9gNzwt6UkObpfWWYC3rFZZYH5GWMCgc/UoQB+nymHkM3sTO9Xh
	cti7pLNvPncjCMS1eRmyfzFrxSvTRCRsgnTbcpviDO2z9Iwu6K4Q6cc6ziAJVDfR
	Q==
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012003.outbound.protection.outlook.com [40.107.200.3])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4crht6xjrg-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 09 Mar 2026 09:08:31 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hw9fLrt2GQj0GLd6XtXE6EM41HzbzhX0YdqbUeKY00wtPS47bvJjZKqX1o8wfDAj2rOlruNKIpd9I1BdLPzNBMGJLxKVrage32OwehvO8x7Kp10INLa3Nn0w9akDRHSM0/MVPdE/bsXKsgrszli2uy4MgJBeA1HF7kZ4AdXsEd8UeBVjkns5oVPizsCnfVtlBvLQU6GGPCoRvfzj+j3Nj3WUDN1kc2PXcSkcCUvSwFvsRI1o3wRRyyFdZclu/00fExkJutRBBmAPWLyz6sQB69j0osqrHLsv/XklW+5uPZV6bhmh96wp0ZiY7lmTdJ11YOJtamzkKAJH1qPYLAW6pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x4txhT74SfC7K1+/KNGWlFSaiovK+ziSQsjQP+fuZgw=;
 b=QZrWLRWV5fbILKGmnpnlW7MiOlK6T/c+3PZel+DVxgkTTsXRKTqcr5iMK7jDL3Lzfbl+DwC7Byy0VDZoicYIJLPOmxs70rAMRyYwVAKbcs5+aQGxtk4VHPDPPdUa6zPWAnPKvBaulajHNHcL8nXb2MAPD6VTU60IkAIYtvF2Hx+pEGjoDiNv5ouAdbBYFt6BoA+QpKSchyKgeRRUZwxGgFHUsBNWqQRD4LrzDIezUo/Usr7MVI1fQbVr5MZzWGHTrJIriCOUkU5BhvvAkWrVvwKzvXIZOxCUHUYfrEkJvEUotcjb4tGifkry4oitjAuq2/GNcx35KF264rVEU4ZaGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from CY4PR03MB3399.namprd03.prod.outlook.com (2603:10b6:910:57::13)
 by BN9PR03MB5962.namprd03.prod.outlook.com (2603:10b6:408:133::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.25; Mon, 9 Mar
 2026 13:08:26 +0000
Received: from CY4PR03MB3399.namprd03.prod.outlook.com
 ([fe80::1527:d313:16d4:2376]) by CY4PR03MB3399.namprd03.prod.outlook.com
 ([fe80::1527:d313:16d4:2376%5]) with mapi id 15.20.9542.010; Mon, 9 Mar 2026
 13:08:26 +0000
From: "Miclaus, Antoniu" <Antoniu.Miclaus@analog.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael"
	<Michael.Hennerich@analog.com>,
        "Schmitt, Marcelo"
	<Marcelo.Schmitt@analog.com>,
        "Sa, Nuno" <Nuno.Sa@analog.com>,
        David Lechner
	<dlechner@baylibre.com>,
        Andy Shevchenko <andy@kernel.org>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Petre Rodan <petre.rodan@subdimension.ro>,
        "Marques,
 Jorge" <Jorge.Marques@analog.com>,
        "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 4/4] iio: accel: adxl372: add support for ADXL371
Thread-Topic: [PATCH v2 4/4] iio: accel: adxl372: add support for ADXL371
Thread-Index: AQHcrX+CxLMnKizSyEqxE/DuUJfIMrWi6WyAgANGjWA=
Date: Mon, 9 Mar 2026 13:08:26 +0000
Message-ID:
 <CY4PR03MB3399158C9C0984048B8EF7189B79A@CY4PR03MB3399.namprd03.prod.outlook.com>
References: <20260306151859.131934-1-antoniu.miclaus@analog.com>
	<20260306151859.131934-5-antoniu.miclaus@analog.com>
 <20260307110447.189b98c0@jic23-huawei>
In-Reply-To: <20260307110447.189b98c0@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY4PR03MB3399:EE_|BN9PR03MB5962:EE_
x-ms-office365-filtering-correlation-id: 6385d8d6-c25b-4f4c-eb4e-08de7ddcf365
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 ZK4yM17gSvf5D/tEWj417egHs+hGeP9kTi1+0ncYlh+fPDbKZgeH323aGL8B4PPjx4gcWFxEralIZ/9faaGOqeIEuIPn+MCbBGf1pjqvP/G9PgwmCRGElSzDPzrSG2ln4FpZJGTWasAVgr3Sjf7dIONJlDqJ6DpFgx6jAUBBhnodD78cRl17BodAbZARmg3DP08nmKwk3pd0JDyjxVZWnkqEnMTrDRul5vA3QjfaKMxW+pqrRHp+HkEjkLCg7YP7/C19+SQCNmolq1+DGH8oxffWFcZ8nllZiHzx49dwj/xnp0ru4x/C5+qy6xmaRMwh2RKSbUTeOENzIxq/cxhvK1QzKJ6POr/Ly82MoJctcg5lAgapTRZjH9IN8X1eO/Nc0rHdweqnXg8biW6yhOhc+1zMpKG/QG8aRnW3WjxlKu9uysRExky6eGz8uSUb1jDio0Hvy2fDk+Dg5AEVKqLJzWYmzZY9x+16ElQEizBJbrnKX4v6la5+i+dl5/54m6rElFOy9csBxobVaLj6cvLEdmU8ELJ8O0y8ayI17vWHCgx9mirb//qN9L+DQBMEKcPBRmduf62PEjqRb15TD0db8OX/B0DP2kUgOGR/b3q8ta5987ALGhFBtE6zT7EwWEVMti56nwmAlCnm7PyR0wWJ5H6/jHLT7vnG6T4/79vhnLqgHDZRH0BC8q4mrFsnhJc4P7Uo9KgxviFLQdhfb501rkpokMa7qfFgJPdy8w5PZ2ppdugyh4Ts1v+0TIV2OG25TNRmYcZ4BXjbK5BeeVpMtyMGpXVmAQw4YlFm4uCQuJE=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR03MB3399.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?wYxvlxFVApaMR/UTPwYCkvcN86IvP5ZA/cATWb8+s9JUeb7gfaAH+sfRAbTy?=
 =?us-ascii?Q?0+735qjBVvQa7oh2Ib7/OQdHf9ir1c6U27kkdz86EQXCUJ1lY9vCcQsu/oHL?=
 =?us-ascii?Q?cLcKHSWXApmad/m2te4b9AReaKeuaqrh+/Ee7UeoKmf/r8it9sT2VXOZMaPT?=
 =?us-ascii?Q?BXOYi6fmpgFtYY7K/f6KTLEA2eF8nZrjOZR9u+R82YDl+l3K6PuAvaSF72/o?=
 =?us-ascii?Q?ktQAxFHmWl9OQxZ8i5Uiyh6Li+rpzQVP1KgK3lhSvkdjsm1G+zKfFBbhHVhh?=
 =?us-ascii?Q?le9oSrixQ79eKPARXdHEQqzg5qE2FbvZz2DAE65IEQH1tpy9W7DUwN7rG7eS?=
 =?us-ascii?Q?iF4DvPT+plNClrLacPlvlrkeu6S9lrrUouKwl0SB3pjWQuUI4lfuAykGTgvN?=
 =?us-ascii?Q?nCKkyPtsZ4LluHhCXiXItkx5+lwh3BJHf7lxjE6XzL5L1dUdEbYTrGh34Wjv?=
 =?us-ascii?Q?ne6bsMZ8IN+M6sYoUhCTFmV91yVpVw0lS8Tt3GfkRzo5uj9+kE7y1mbEg56e?=
 =?us-ascii?Q?8gtAV1OdmbxnKCpHJtHOBaoFMQHtojCW1xMBDUvc99okboa4HE17ui/zEfb3?=
 =?us-ascii?Q?Q+3g3VDYnEltL1Q9JX32pz7oxpUdK4XGO0WvtlqLEQziZgUODyVqIFe5Kiuh?=
 =?us-ascii?Q?4TaqJ8CIPXVgYWX8GcRTBennReNZTxV7EVYZRQGk+7KE4Zea+ZUPB93Sk9NP?=
 =?us-ascii?Q?ZFdJQw0Fm3vL5w8x+WmDv+GSiM40m2AQEka7K4mL0Ip5J2NOzlqKPh6zq/gR?=
 =?us-ascii?Q?3B+eeYrVWALWcMSbcxVQyLDzjfLbS54nozPmYM9O0Rr/ghxrS11mtzuiiHJT?=
 =?us-ascii?Q?Pxf1SVB2YG3uC2lM6Rf7NC7py62OxzxEcQYx4lOlpD3cSQG3NTsKst9BZhmf?=
 =?us-ascii?Q?q1goJgxJiK95QjRqSNEbp++5+Dc7JeYdOMGvxEoGJDV1Dr4ITprgq3f2Q8mB?=
 =?us-ascii?Q?mY4hksMOIVpPCd3sCdtKeiGAOOo84vTv6VCWzGdZUxmnVUeiwrXDFo3Fs4RP?=
 =?us-ascii?Q?4ERRcoYDtP5dY/lUAF3PVUSIxKmDcUioJ6VHo2lRbTuwGisQdWoaCap3JY7W?=
 =?us-ascii?Q?Zfq7U8srDLIHY+P72z1+MzVAOAQJV+WqmYTUTpTxZo8PLSscvdx968/ZzXhz?=
 =?us-ascii?Q?0AAnqmNixVDS1BjSxNfdVrA2wO/bG20EyPXa0ax4XZi3w1T0FIV/p1t0IL0V?=
 =?us-ascii?Q?ru8+Nu7HLVT6vlpfTFWh8y9JfkSKbFqQI/pk/eG852KO7GsY9+ByTWBRgTMY?=
 =?us-ascii?Q?9hjW31IRmvcJrBdb5uZioaydLh2+KvmF83JTyp6lWcRXW54HdzZR04ueYddU?=
 =?us-ascii?Q?w7ZzxqqkFXEiAVTv87pAioSQbHOPKTqnlR/Xc693kO7XvvgBgn2cULGHmX01?=
 =?us-ascii?Q?17v3kCHYd63UPY/zCXvsYetZBDeLlGiDU8xn+Oay3yV3k8aJJdgL27x49/ty?=
 =?us-ascii?Q?v96voPwBs5EptjgYIdqo7GPSz6gcSNswEAREcwxL8VpuwZ5J8MLI+byf8kVC?=
 =?us-ascii?Q?49QQkWl97+xW3c25u0MUuWJ1i/X+onLWRPVVBQzdYq7K7TFQUS7tv+zaopCk?=
 =?us-ascii?Q?9z5PwFSseg3p/YS/ovZBbaAAjHpYi5sre0FNPraXTgNqgZzPFO/L13ctdfr9?=
 =?us-ascii?Q?lQWHlBsGbCdmZrL/8XeEDLg+wl13qOzppTl9d0ifEm2WtbpTLVcElkVWaJpK?=
 =?us-ascii?Q?69gE3wDiGbkcmtaVufdB+MXXpVtvh3wqfUNkYRnfdmu0EJb+Qt7CdP3nwTj/?=
 =?us-ascii?Q?wX4nxK5Cww=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	jiAn+KsVXT1cvqnRcSSqMXcmhsX/awrX1gykIl86tAROD/kRmfbZsNqux2DvhEIof9RrT7Kjk6vvbjBX6vGjhu3BFNUfrK3wGOl9K4axCqIhrc3ElbVG6/HF607cdokoSGrjjBDxVEuJQIScPImXEY0NQ+3Df1lyoMxqxvtv6z4tXDkhXEhffElm/UphtiBILrmJp8Gg7FFpQpvhlQ2fd+9Zw2Vmtt0/lcC10nLodU4iBPSS/vE93IFUOau40ZVkUnQHCFEbhIhkQQw7Nzzj4NNZxYCxm7isDVVVpPkF0awoLpqWjWOkVjSGkqaX52tNzJjkL4fhiLRccAKDQHR8VQ==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR03MB3399.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6385d8d6-c25b-4f4c-eb4e-08de7ddcf365
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2026 13:08:26.2500
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YFI107n2bOPskLcEpcefdcot6eo7H1JWDi/XWFfX812fSPKXYq/WbHFgtoFEehv8v2O7O+xAzU51t/T2y8TRa/SLz+s7Dr1qRs7CX4tusBk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR03MB5962
X-Authority-Analysis: v=2.4 cv=f5RFxeyM c=1 sm=1 tr=0 ts=69aec64f cx=c_pps
 a=QsHTWkejXhsF4jLr7vu2uQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=Z0pTeXoby7EwIRygza74:22 a=VwQbUJbxAAAA:8 a=gAnH3GRIAAAA:8 a=IpJZQVW2AAAA:8
 a=0IrIa_ooGUS6r_URlPwA:9 a=CjuIK1q_8ugA:10 a=IawgGOuG5U0WyFbmm1f5:22
 a=mpv_7z2a4kGo0ltCk4E8:22
X-Proofpoint-ORIG-GUID: nnGq5e2Zp4cqd05hG8j2eNTLbakAY3aL
X-Proofpoint-GUID: nnGq5e2Zp4cqd05hG8j2eNTLbakAY3aL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA5MDExOSBTYWx0ZWRfX7D1wINPyAtot
 u302kqk4/AhW9851XDUiCRRZcheckGIa9w07B+HKYS0cg5TuH5IEdWyG8duus4qHVfx4sUV4AxV
 FiJINoO/I9t8TCoUkaJexh588tKnvQUaTPnrcWcWDYSk/HJUQgWX8tOn1GyfE1mZo+/HWipdjvQ
 +RoQDW1gWbLEKT3ZxOPNFMQJPpT14jM9FPJc9fPBQ/aOV+RmcvkizsKiUpmrep/U/LQA2FDir89
 z/sDwJHF+6iY1uv4ZujkwVlEcQcMSrSiOP+TpS6RZXGGDw8SM9QCWc5Z2SX6Byy1rHTj/Tv80OD
 dMuqtL/lPHbgTVciM7N2dD8SeyZ97dj2Q33pN27dFbIJ91ufCGbTyjjv2iytBDjPVcgGZChpw2A
 SSEghzNkM1rX4JDc0QYdN5eBpUCkwg57y3H/vqX8gM50R+mR+t0dVR1qqRQLTrC7EtH4pAl8gAn
 DJGbpgh3SiHGpUYp5CQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-09_03,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 phishscore=0 adultscore=0 priorityscore=1501
 spamscore=0 suspectscore=0 impostorscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603090119

> -----Original Message-----
> From: Jonathan Cameron <jic23@kernel.org>
> Sent: Saturday, March 7, 2026 1:05 PM
> To: Miclaus, Antoniu <Antoniu.Miclaus@analog.com>
> Cc: Lars-Peter Clausen <lars@metafoo.de>; Hennerich, Michael
> <Michael.Hennerich@analog.com>; Schmitt, Marcelo
> <Marcelo.Schmitt@analog.com>; Sa, Nuno <Nuno.Sa@analog.com>; David
> Lechner <dlechner@baylibre.com>; Andy Shevchenko <andy@kernel.org>;
> Rob Herring <robh@kernel.org>; Krzysztof Kozlowski <krzk+dt@kernel.org>;
> Conor Dooley <conor+dt@kernel.org>; Petre Rodan
> <petre.rodan@subdimension.ro>; Marques, Jorge
> <Jorge.Marques@analog.com>; linux-iio@vger.kernel.org;
> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH v2 4/4] iio: accel: adxl372: add support for ADXL371
>=20
> [External]
>=20
> On Fri, 6 Mar 2026 17:18:24 +0200
> Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:
>=20
> > Add support for the Analog Devices ADXL371, a +-200g 3-axis MEMS
> > accelerometer sharing the same register map as the ADXL372 but with
> > different ODR values (320/640/1280/2560/5120 Hz vs
> 400/800/1600/3200/
> > 6400 Hz), different bandwidth values, and different timer scale
> > factors for activity/inactivity detection.
> >
> > Due to a silicon anomaly (er001) causing FIFO data misalignment on
> > all current ADXL371 silicon, FIFO and triggered buffer support is
> > disabled for the ADXL371 - only direct mode reads are supported.
> >
> > Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> A couple of small formatting things. Otherwise looks good to me.
>=20
> Thanks,
>=20
> Jonathan
>=20
> >
> > diff --git a/drivers/iio/accel/adxl372.c b/drivers/iio/accel/adxl372.c
> > index adb9e42653f1..7a1ee2fef618 100644
> > --- a/drivers/iio/accel/adxl372.c
> > +++ b/drivers/iio/accel/adxl372.c
> > @@ -1,6 +1,6 @@
> >  // SPDX-License-Identifier: GPL-2.0+
> >  /*
> > - * ADXL372 3-Axis Digital Accelerometer core driver
> > + * ADXL371/ADXL372 3-Axis Digital Accelerometer core driver
> >   *
> >   * Copyright 2018 Analog Devices Inc.
> >   */
> > @@ -182,6 +182,14 @@ enum adxl372_odr {
> >  	ADXL372_ODR_6400HZ,
> >  };
> >
> > +enum adxl371_odr {
> > +	ADXL371_ODR_320HZ,
> > +	ADXL371_ODR_640HZ,
> > +	ADXL371_ODR_1280HZ,
> > +	ADXL371_ODR_2560HZ,
> > +	ADXL371_ODR_5120HZ,
> Might be worth a
> 	ADXL371_ODR_NUM
> entry so you can size the array from it below.
>=20
> > +};
> > +
> >  enum adxl372_bandwidth {
> >  	ADXL372_BW_200HZ,
> >  	ADXL372_BW_400HZ,
> > @@ -222,6 +230,37 @@ static const int adxl372_bw_freq_tbl[5] =3D {
> >  	200, 400, 800, 1600, 3200,
> >  };
> >
> > +static const int adxl371_samp_freq_tbl[5] =3D {
> > +	[ADXL371_ODR_320HZ] =3D 320,
> > +	[ADXL371_ODR_640HZ] =3D 640,
> > +	[ADXL371_ODR_1280HZ] =3D 1280,
> > +	[ADXL371_ODR_2560HZ] =3D 2560,
> > +	[ADXL371_ODR_5120HZ] =3D 5120,
> > +};
> > +
> > +static const int adxl371_bw_freq_tbl[5] =3D {
> > +	[ADXL371_ODR_320HZ] =3D 160,
> > +	[ADXL371_ODR_640HZ] =3D 320,
> > +	[ADXL371_ODR_1280HZ] =3D 640,
> > +	[ADXL371_ODR_2560HZ] =3D 1280,
> > +	[ADXL371_ODR_5120HZ] =3D 2560,
> > +};
> Style wise, why not do the same for adxl372_bw_freq_tbl[] as here?
> I slightly prefer this style, but key is consistency so if you'd
> gone the other way for both that would have been fine as well.


I will do the same for adxl372_bw_freq_tbl[] as here.
Where do you think is the best place to put that, in patch 1? (introduce ch=
ip_info structure)

Thanks

