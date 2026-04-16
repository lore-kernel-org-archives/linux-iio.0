Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD7F246BBA;
	Thu, 16 Apr 2026 08:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776329531; cv=fail; b=ScLX+eR/+jNvMEosA7gAU9er/hMxU3/l/7d9nPzgHSihdJs2ZDrswXHpAS/HOBuPjMrlHMtYo2njg9LEPL/GsgpAuHC1nJtdi1jcoqu8/WW/CKilCKncWTT9CtLEJbwfx1bLDTLKgGOpcA/CiVayTSDkmAaO8P1RtOP4n3jlh1M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776329531; c=relaxed/simple;
	bh=1mEsdlQAC50k+COjSskzNdDXaE6eVU0m6agHL4Sma3M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GFAPW5DAKOk5yBt64QomNnwMIT5750FKRe4T/yprbXuGqedYQsmZid2zveDXseRisUAleNsyBGxkWDGRUlBgo07cSBoOYwDW9fQHHjMRDfSynV4BsBdR6BGU7SW4473+D3TZBs82BABR5mnnMETN1FfWnEJl97ljq/Q6+cuI+Kw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=GmWrjqDN; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="GmWrjqDN"
Received: from pps.filterd (m0516786.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63G7qYMK1736690;
	Thu, 16 Apr 2026 04:51:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=ONUKt
	rAZVRbXW84q5BpvWjO2RmQh3q+0gjn2ByGU778=; b=GmWrjqDN2qk4zSIiao3ti
	XRvAmTGEnqA9tZsoPqrVhaWKWVFIwrJ2CkTR1FouergluDyvpsKkdCL7R6PpZfde
	Cc/ImVgkmc719Q4b4Q26YEHinCQhu1uSqoijhPWEyFsvZr9C21dYcTsaW993hPT5
	6nNVLJvA3MNicG1jym7JNnhf+zBazmaZEc0mC6gp6QY0Q4mmE3pN14mys1RFd7aN
	82Uq8rXnE3RT9Fk6+eKKQC1YSfVqxhnL4rdLK3dTqC2EXkyc6Kz3459HSess1xoG
	nnrVTq5j5PqeFLtXQnrl33WoJCNVE8jpN1npE4sK47k4ppBFhXjaXGdvGRo5g4z7
	Q==
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010066.outbound.protection.outlook.com [52.101.61.66])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4dh84nmayn-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 16 Apr 2026 04:51:49 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PXf9g3+WoCEU5REgUVq1u371lw5GMzLRX4KSynFO5cHfiuTrUaAagJWKw/dUPzR++4CPubRGm65TKsn5P2hvHqvpCmLxcusCq2/m9mHndGmmM6Xg5G8T3X4hHyMEP0XeMZovrslK7jYurIlgoGZ0oOzWsL0ReJbgSKXH/QZORlqd/qZYqJcUUuWGdZini0XCMD5d614oteehAlpvwXG1IbPXdCb4otnbXI43u7BalLaLG5JirkbXb3NSbh3UPbeKTZptGl6MzGomtDF4+LowUT97YeM0hNEXyUXDZa8So1g3NRNHOBwq3FRyFh9yb4WQQNGUl15IsURIonkKZQtaDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ONUKtrAZVRbXW84q5BpvWjO2RmQh3q+0gjn2ByGU778=;
 b=oEDFeL1bhP8vaF7lMB8WS7xXgrII6G37VlS6W7f+X3DisDk/cbi0BOWYGW9WVakJbFvx4HJhnS1qLOIENJdPhzhmNCtul52EMYB1HLi+87DZQ+iQ4uDjX7xbMl7cI2PyC0XMwBOxZHn2YFwHMHfhACUjxrZeMdF+b5CIC6uHl94uqmuh3ChiCk3q2dG13oS/aMVH2t6qO6LiMaliKoDI3w3pVeuMBOpvOr3BupjyI9tTD6RpLK6MCEgWdTi6IYmGDSem5LByBJHcXr+xcmodFejMumOi9WaNoFXcLwk2tXSMsNRfRagkyVb9UNwHsUG5PxJBiOBobTSTp+LQStAuBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from SN6SPR01MB0090.namprd03.prod.outlook.com (2603:10b6:805:d::23)
 by SA6PR03MB7928.namprd03.prod.outlook.com (2603:10b6:806:42d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Thu, 16 Apr
 2026 08:51:46 +0000
Received: from SN6SPR01MB0090.namprd03.prod.outlook.com
 ([fe80::8b7e:c42f:998c:10ef]) by SN6SPR01MB0090.namprd03.prod.outlook.com
 ([fe80::8b7e:c42f:998c:10ef%6]) with mapi id 15.20.9769.046; Thu, 16 Apr 2026
 08:51:46 +0000
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
Thread-Index: AQHcvqgQBtxoLIQOlU65MwD2yCgcMrXb2H6AgAWmUKA=
Date: Thu, 16 Apr 2026 08:51:46 +0000
Message-ID:
 <SN6SPR01MB0090FF0C73500BB51F63D7FB9B232@SN6SPR01MB0090.namprd03.prod.outlook.com>
References: <20260328114050.46848-1-antoniu.miclaus@analog.com>
 <20260412193349.6a3fea03@jic23-huawei>
In-Reply-To: <20260412193349.6a3fea03@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6SPR01MB0090:EE_|SA6PR03MB7928:EE_
x-ms-office365-filtering-correlation-id: a2fccd05-41de-483b-2c25-08de9b95642a
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700021|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info:
 t05wDVbmUZwq4ZGTcI3B5QhkDxpDehxKESN9JFbxFJGM/Yq7S1KLxEPMTtPvPpFAlguSDjk1M24WN/RErPHSKw2WYZbH3Yhtd407zKGsAgcCvIePz7mMEi0/3a+LXi/4CkK6tv2eeoHyfgcg7W1MpFh9ApU3aUf1xlxOZpE95KY8arb07HunYLsCAcZOQWxeTKmkrCygBh+8JarZCNA1zLWQWCucS30lDT/KpNftmaZrIbxT00VUjeLfy17jA5nCKicxtmqSU43iQdrNQaOQDRSpKoEYls87dEROc1ugIfa4oFEbUAlXbpvQpoKVpYWAGhoa9f7YmOuRW7iuPFRm5GF+XZtZXmkv+3rbKNnLDd1OXhpGXnHarGITx86kAyQ25rS9wtx6cyXKzHgCjGaOgL+3+NGpTkLlqx0vdu7aw7fW6s217E4S4WCHKQtiDSfwi2Gf++3zy/Sf77BbqdlpNVNiG4o4brEdHt6L0hWd2UAQhhus69sf4btnV2uKZpcjyqkmicn4Sy0ZBsEbDGgVswmUqIxFjiWdux9BRGY1L/9G4JVTjHlQ6YAgZCxGMDM3G5mEFO3L1p5fNbmVasdE5QTo1H1cPwzvIeI6tz1LeUte+kskmmxcPFeJn0nXiB65gE81ytPao0+e+dFA4hnpS30MH2o/+Pnyoj00R6+UYrVq2RG0EKmrUIGQoJEMQwyxEJvXisNnKLBwULlvUxauxO60xs1Y+1ShSDsSaacaYRC/kwCsHaopaaYznYJzcCkPUf6GIHze/r63lcPdNNoSnQ3mF2OwC7qfz4c6OLgPucY=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6SPR01MB0090.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700021)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-2?Q?ln7qpVhcC7WMOc7NmbGAyrwEjHXcZcO+PlLoZDbaxmtC1A/DYdAyymj9bd?=
 =?iso-8859-2?Q?VYfQB1hRnm3O1ivMwfOLHtRw46GWEpiR+5WoK3Y4CIBpF3lD2WPlG/W5+X?=
 =?iso-8859-2?Q?YsRYhxnYvl5rgJKWJoJA4/cxbQGJuCAdF3hh5FkcUdjSmrtfJXU1uA+ppd?=
 =?iso-8859-2?Q?Sk3AGEOODiJwpxSpQXHcS+7CK0UeFuL0MPudYHBUe+8FrBO0t+BjUSV+/Q?=
 =?iso-8859-2?Q?PmxIcEyQbUQIYPRLRswCjTEp5LtKpF934VKhiVDgRKi1fE+cQI9xa8ZjHD?=
 =?iso-8859-2?Q?wllVnckU9KHf8GEnBDH3m4MoMDSpphcnYPw/Yu6+ZtzTc2tDCfZa5LrMvg?=
 =?iso-8859-2?Q?0wxGtG8zTFNjCA9fQUr8RvTqVZwCMkkBm0BR6uwB7pV+uaeyyWi3hmhYSr?=
 =?iso-8859-2?Q?5mn2s6mqYTg0cQyxxSCT/boaASw+mbvEl84fYfU2oTrLnFtlqC4XbxQv2a?=
 =?iso-8859-2?Q?9dAJUBfnHxrStb0ddz8W9dYT0WjdltylSmkro+gd6ieLd2cRk2An9I59tr?=
 =?iso-8859-2?Q?pbq9NY2z0Wyz6X0dnmeuQQU6GZOZmGstRTUr0B0p8zNH0Zo0ddDPSNecAx?=
 =?iso-8859-2?Q?O04JW98LtuzoJMJGvVpppze8NPB8k14mEz68tCRiLP4nWQWTEXiGE9D7B7?=
 =?iso-8859-2?Q?3mkvM8j9RtOuFkJwTZ4e1WZBEKvh72i5QT1ORofVv2e29nY46N6Z0WaW5s?=
 =?iso-8859-2?Q?4Hn4V8KYdGj6dAtu22MliS9wL5aDc9d8v4kWKMzm5nf4TwJQWs5LjkZgr7?=
 =?iso-8859-2?Q?/+4vGSFOyV0wAxi8gJF7aE64WGaQ1cOHiTsZ9efE/fJgiJKnwB0mhTh3MH?=
 =?iso-8859-2?Q?zgHdt4RYfaucyTBiX1hb1e3U4N8m2NxekhWzcfuRqQtG3CPiMygMGwJi9A?=
 =?iso-8859-2?Q?p+MjhHqpQzYctsrrTZhwo6nHirOJfKqcu/AxsM8FUtyf0ykMy9GRS44Tcn?=
 =?iso-8859-2?Q?ZZQlDSz0B5EI+5eXfXo/bXp9ZP1h8vAYbZY0JfDmyuwLcphMSgYmjZXoqi?=
 =?iso-8859-2?Q?oLrq8IpQACAW2sl127cvVtUM3bX+IL40BqZ39jvFNhF5NwMApKF8m+oUCw?=
 =?iso-8859-2?Q?Kr+RDL7fn8gQqb6c1EarkIZqScoXX0bXwGQz9Er16xY+RqScD365I/Zj/q?=
 =?iso-8859-2?Q?rZOEgxKDMrbXCl5edmDaQ1T0JBg9kHdxbx2MvvszzoJtg6Vsp3SHgZYj2H?=
 =?iso-8859-2?Q?eDI5e6eGRl2wXAvGUS+tdqY5t2YLNyCTjkm0lazsmDnTcWnlua2Hvd+6Ky?=
 =?iso-8859-2?Q?noP5R8Zg+XlRxbk6MyN3oK4yr6eAGxAkqwXR5sGvs9D+EitkvNbPyi6pTL?=
 =?iso-8859-2?Q?yqpClU5JcqyGn6HIlNo+OEbDJ6uBjP1S03IRkl6LJVgB+i1sOxtATI12g/?=
 =?iso-8859-2?Q?CzRIXIsGLQsWZNYUriu2+U7zXx7lsW0N6p8/K++MA7SeBqZuFQ0PcbZX5q?=
 =?iso-8859-2?Q?0x00FL05t/JULYsIdfS0QtioPF2Az5LdFwn61a2nIvtx88fa6ND41vTWL8?=
 =?iso-8859-2?Q?/zCwrbp5PrPIso9znNlfoiLZMW8PrBqpw0ZqlX9QP+ZDasfBguZF7G5P9m?=
 =?iso-8859-2?Q?yD4ooe33DSEJ70jA+C5+zCHEGwhPPwDdWiL8c7+/A/FPmvJNMnn8bDVe59?=
 =?iso-8859-2?Q?l89KkCdX6evuHSixFQSu9nhjv16b1JPe1u3HuZFc0KL2uFjMH2P3oBeSnF?=
 =?iso-8859-2?Q?pdyZrt8vLbJCQ4usRMOJ1/HyTmxphUzFa9kQj4NjdgZ95859gtpvbN3/uD?=
 =?iso-8859-2?Q?mMhwHp4VdHaWWAyM9rfx7XsDbdIqp192n91XcdwTlBtYVHaX2tIOrqjrSl?=
 =?iso-8859-2?Q?Pck6Kg6ldQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	u1z8MOfh1GEbqADwFzejSGDzWzMcFcqjYFfvAe2Pv3uvxT9yZznqV7sbDfcmRVpbe8iPzkQ3ysqeGt0+hVK5Tn6UUuHUwc70aQEk5+GnJMGxmlPV0j3P5JWLttOBFrewszvP3QWkevDYzD6f7Atoxcjbf01VYtfoV9dJvjG4JGw1P0FDrVkiOPE1F/8SKk8/e7Hl9blJf8IFm7KpYk51e1S8ujXg56Lh3LL/wZBr6uUbn2opvWCRoK7SldZRzq/mZm2P+9k8RIVCTKM4wYC4Gf5jLZuMJFhbczxHrRx006+o5q7Z5u7ruB2PBySkTS2UKYBlf2erdsni9apBRmPxJg==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6SPR01MB0090.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2fccd05-41de-483b-2c25-08de9b95642a
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2026 08:51:46.6026
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zEbVedbHEEVFFqHfWnNMWZrM3jPyobQCoDzEiBMsAAjC5hYBqLIoaFsfZSWlgCVSuBEbn9NGyv6Ss1ed+bEs4K751RYa4XaYisvyjZFbkD8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR03MB7928
X-Authority-Analysis: v=2.4 cv=IMQyzAvG c=1 sm=1 tr=0 ts=69e0a325 cx=c_pps
 a=3Q3Nz7QybYLir9TwqGRfQw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=-CRmgG0JhlAA:10
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=ZQxX5BWu6Z8IJBb2zLX7:22 a=VwQbUJbxAAAA:8 a=gAnH3GRIAAAA:8 a=IpJZQVW2AAAA:8
 a=8b9GpE9nAAAA:8 a=wGrDeZif_7shLOwJJtEA:9 a=jiObf9B0YAUA:10
 a=IawgGOuG5U0WyFbmm1f5:22 a=T3LWEMljR5ZiDmsYVIUa:22
X-Proofpoint-ORIG-GUID: S-wvY4UhKls1xGqOWg7WdXR7xcaQ1bS4
X-Proofpoint-GUID: S-wvY4UhKls1xGqOWg7WdXR7xcaQ1bS4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE2MDA4MiBTYWx0ZWRfX8TeywjKA4rhg
 n8GKXOL09zYD9rIXOiYjT450YJjKPyDgNkb+/Dz+SyR3VCDGpW22FTfkIDwqPX09Q6F6Z1goZDP
 /aBZ2a50p5RyGm9pNdXxFGT5BCdYKCvFHPVrum4gKIm8D2vkS1AdzVdoo4XdydKd5+3u9Sd+/Cm
 Gh/+0c1KOHkmDaSxo49s2uVqCR9pQBFwkgpaD6f00uPKe4DnOeteac+oIKpvqb9S5X4ZetunBQp
 zlB6F9FV/HNo4Bk+Ihze8PX/ADlwLo3jzUCEXRuCDTR1qarzCUOBbXv2gWQPv9ErAmbgBdfhCf7
 7Bk0LaD6jWDUCitzkp2iwU7Nl5d+E1floI5W1Np5eeDKXRTNrdQ+N3xBiBSEAEXVbRY0gyxbjz4
 5nxcUOJQKRcDYEPN5A0zwuodVsDdlwHOHBjzh7EyLp+dlmxD5qLuJS6u8IAd8YPWR5Dkl16Smul
 qHvvlNZts38ppJJK4vg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-16_02,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 lowpriorityscore=0 adultscore=0 suspectscore=0
 phishscore=0 spamscore=0 malwarescore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604160082



--
Antoniu Micl=E3u=BA

> -----Original Message-----
> From: Jonathan Cameron <jic23@kernel.org>
> Sent: Sunday, April 12, 2026 9:34 PM
> To: Miclaus, Antoniu <Antoniu.Miclaus@analog.com>
> Cc: Lars-Peter Clausen <lars@metafoo.de>; Hennerich, Michael
> <Michael.Hennerich@analog.com>; David Lechner <dlechner@baylibre.com>;
> Sa, Nuno <Nuno.Sa@analog.com>; Rob Herring <robh@kernel.org>; Krzysztof
> Kozlowski <krzk+dt@kernel.org>; Conor Dooley <conor+dt@kernel.org>;
> Olivier Moysan <olivier.moysan@foss.st.com>; linux-iio@vger.kernel.org;
> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH v8 0/3] iio: adc: ad4080: add support for AD4880 dual=
-
> channel ADC
>=20
> [External]
>=20
> On Sat, 28 Mar 2026 13:40:47 +0200
> Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:
>=20
> > Add support for the AD4880, a dual-channel 20-bit 40MSPS SAR ADC with
> > integrated fully differential amplifiers (FDA).
> >
> > Architecture notes:
> >
> > The AD4880 is modeled as a single IIO device rather than two independen=
t
> > devices because the channels share power supplies, a voltage reference,
> > the CNV conversion clock, and a single interleaved data output stream.
> > Splitting them into separate IIO devices would make synchronized
> > dual-channel capture impossible from userspace.
> >
> > An MFD approach does not apply here either - the channels are not
> > functionally distinct sub-devices but identical ADC paths sharing a
> > common data interface.
> >
> > Each channel has fully independent configuration registers accessible
> > through separate SPI chip selects, so per-channel regmaps are used with
> > no locking between them. The data path has no software involvement at
> > runtime: the CNV clock triggers simultaneous conversions and the device
> > outputs an interleaved bitstream captured directly by the IIO backend
> > (FPGA). spi_new_ancillary_device() handles the configuration path;
> > the IIO backend handles the data path.
> >
> > The debugfs_reg_access callback is not exposed for the dual-channel
> > variant since the IIO framework provides a single (reg, val) interface
> > with no channel parameter, and exposing only one channel would be
> > misleading.
> >
> > The AD4880 is a fairly unique part - having separate SPI config
> > interfaces per channel with a shared interleaved data output is not
> > a common pattern.
> I tried applying this and it's not going in cleanly (I didn't check
> exactly why).  Please could you send a rebased version.  The togreg
> branch should be fine I think, but maybe sanity check it against
> my current testing branch as well.

The AD4880 driver has a cross-tree dependency on two SPI patches that are q=
ueued in spi/for-7.1:

- ffef4123043c ("spi: allow ancillary devices to share parent's chip select=
s")
- 463279e58811 ("spi: add devm_spi_new_ancillary_device()")

The driver uses devm_spi_new_ancillary_device() with multi-CS to create an =
ancillary SPI device for the second channel's configuration interface, so i=
t won't build against togreg alone.

What approach do you suggest in this situation?

>=20
> Whilst this driver is making a few more assumptions about the backend
> than I'd ideally like, I think it is reasonable to postpone any handling
> for truely separate backends until (maybe) someone needs it.
>=20
> Thanks,
>=20
> Jonathan
>=20
> >
> > Changes in v8:
> >   - Drop fwnode_handle cleanup patch (now in jic23/testing)
> >   - Clarify backend buffer comment to describe FPGA architecture
> >     (two axi_ad408x IP instances with a packer block)
> >   - Make filter_type a per-channel array instead of a single variable
> >   - Restore debugfs_reg_access for AD4880 (uses channel 0 regmap),
> >     based on sashiko's review
> >
> > Antoniu Miclaus (3):
> >   iio: backend: add devm_iio_backend_get_by_index()
> >   dt-bindings: iio: adc: ad4080: add AD4880 support
> >   iio: adc: ad4080: add support for AD4880 dual-channel ADC
> >
> >  .../bindings/iio/adc/adi,ad4080.yaml          |  53 +++-
> >  drivers/iio/adc/ad4080.c                      | 251 ++++++++++++++----
> >  drivers/iio/industrialio-backend.c            |  53 ++--
> >  include/linux/iio/backend.h                   |   1 +
> >  4 files changed, 282 insertions(+), 76 deletions(-)
> >

