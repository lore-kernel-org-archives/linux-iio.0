Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBAE3396593;
	Wed,  4 Mar 2026 09:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772617987; cv=fail; b=kNTsW3wym4C/y1QYhcZN3TiqN21zooZnDc6E/j78lZumWD9PX9Hy4Oz7q6o2pu4arju8FMT9+5ANQ+lw9QlGAGywf/HUb1nY9xvxMHaLillgjYFLvGMcbzs+2bCsSyeMR7hND0Ra1nP7TbDBWVv43dwXHfqLNH+ON0ADjj7hLKU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772617987; c=relaxed/simple;
	bh=IsWirFFOPBH6ZTla0PgnaV3DiG7e3PBzchcLTvc99AI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CIVEBHLNY3piGN46FZUTsDtScFXPJM8Tp2L9G1FMeQRFXakm5aFfg4ztTnk5uJVdyiENfoDE8Vi43syjuF7QtqRYQcnGT0fXYgf5GhUoGNPqaGLag9bETSn6psf6+97GUvZAj2zGy3xtJ3eYBo16DaBEMqwvZIhcEJbogi3iXic=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=yVcrM6bH; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="yVcrM6bH"
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6244UKsg2140217;
	Wed, 4 Mar 2026 04:52:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=SlKLz
	DEYkO2mJ9NUlA56e5+PLkwdwAva5hn1R0zZ4xc=; b=yVcrM6bHZBvv1mRAC09J7
	DJeQB2AMGarLo51SM3S/CSpsoTUdiTYemfLX+0XirWfn7uiaPCgshZ6CSxb/hZQQ
	GyPJmma9QxxhPdRYR1UnhKLqtLG0uPTYN5OMnaP+09azD1dRxLPwG2YVNZqtk1Ha
	wUbQTA1O/DOIp2+JhypJ4eEwfucBgdFRqUqB8LRet37zIWzrWtY1ueWajMGXTKT+
	8t5xYW9sbezq5THwUiIpNh7cU9t/bUBQnWoMqdYwew0L7rUIbeHGp7njSmYAMF/L
	mn9j3AJobdlnR7DpyBaMtYPhgdW+ml1Bd019450QzqHko0W5veIqwW5TH7VHq6zV
	Q==
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012023.outbound.protection.outlook.com [52.101.43.23])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4cpd6h947f-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 04 Mar 2026 04:52:50 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uvfrgsq7yYVRMlBKWVUK2bQbUcSvRWlAX53islugOlJ2kF3+LqJao/mVrXT3rsQgPJygO8WmLrRsLN2ZccbId84QQfjBPMPdSs3BLrMgLRCRRF4yq4jniWkWudTV1NrjnshBW9Q1JbOpYo07Qu9CJ+oogzZVDWM+Y97rIDXCC4UGbOwbCy2Mc9j8IDTupye00yY8HJOs6qiuJnmPnHpPvfKgttTUeXJKEtwUJW72LI8jWtXLhxe9To726l+uNqOa72NRx6rh8W84Vo3Gu+n4athTvC6NZVWtHMQM4xBCxW5tpF+4eoJrvXoyDH9897h7kVTZAnX1O2ybb1m/goODMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SlKLzDEYkO2mJ9NUlA56e5+PLkwdwAva5hn1R0zZ4xc=;
 b=R6XNPCi6X3Az1Ej/fDGO/y6ioH9+Nd33P7emP4SCGX6+Z4xMf5qSYsaxOMxkpvAeSUI6PTfWem2ycopVoqjM5YUtHlzfH37Hp2z4PmY7ao1EqHVpV/W8ls9oKPF5c2gpKYii6PMAjM8uEUOC0bjdvlGE67XYJgKuHQs4RGqwdYRVGYoGWJpsKI2KB73sWS7ohN3BJtDG5ggceqa50JlVq9x8De+Z4gEZaJ369Tqx0if2n+Mgc7BbVIF358nG56vHbCvEq4Y3ppT1UgqfpiBgkX/Zxk6S7iZiAEr3TmW/Rb7vBIEDFq2daf8UsgvbIo5skK1B7IsTHWQrdExJ0tiufA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from CY4PR03MB3399.namprd03.prod.outlook.com (2603:10b6:910:57::13)
 by SN7PR03MB7274.namprd03.prod.outlook.com (2603:10b6:806:2de::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Wed, 4 Mar
 2026 09:52:47 +0000
Received: from CY4PR03MB3399.namprd03.prod.outlook.com
 ([fe80::1527:d313:16d4:2376]) by CY4PR03MB3399.namprd03.prod.outlook.com
 ([fe80::1527:d313:16d4:2376%5]) with mapi id 15.20.9542.010; Wed, 4 Mar 2026
 09:52:47 +0000
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
        "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] iio: frequency: admv1013: fix NULL pointer dereference
 on str
Thread-Topic: [PATCH v2] iio: frequency: admv1013: fix NULL pointer
 dereference on str
Thread-Index: AQHcqvN9Caq1mMNH50OvhHMs1NzZ37WcrUUAgAADkiCAACPPAIABTiTA
Date: Wed, 4 Mar 2026 09:52:46 +0000
Message-ID:
 <CY4PR03MB33992767510003C39CA7E7959B7CA@CY4PR03MB3399.namprd03.prod.outlook.com>
References: <20260303095228.7494-1-antoniu.miclaus@analog.com>
 <aabHFq2PZssgpK2G@ashevche-desk.local>
 <CY4PR03MB33997EEE3782905E1362AB279B7FA@CY4PR03MB3399.namprd03.prod.outlook.com>
 <aaboHofKArsITTqt@ashevche-desk.local>
In-Reply-To: <aaboHofKArsITTqt@ashevche-desk.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY4PR03MB3399:EE_|SN7PR03MB7274:EE_
x-ms-office365-filtering-correlation-id: d84bb1f5-e164-4534-10ea-08de79d3ca3a
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info:
 HVRN3i+79dwAI7dwtF0PzJ9NlQQ0I2xNy89vZCYjkR0m5nagF81uZpLLNlC3AureNuR93t03NMBtoWOHVREA1ik1eI0Qw5zJPM5B1y3pApCmfMPVrLbFJ2HgaR0M0e3tQIeKuaXKnjKWQqmFFW6yiAug4uLPUZoUYjEUq4Sxl3AkNqrSIU7r/fH3NVR9loUHs5dd0pweZrJzur15hWg4XMEGgC58ds8JuOKHAS2VG0jPRttpt3LpoMO3SCY8lK6xGP5Rq2aKZ5GyF8sHG6c/gZyS+TlpXLQiZVOji2et5yvS+4A22nGLDThKs8DXjOoRvOGJ6I1v+pl3R6ptnUshLNQE7LlNvzw1Uo4kNdcXN7Uvoe0SXKTY/IluGJizVpDOtK49RSshLKRsPIvRXAe7xxs13IDQPf5D8e2HStIGFNZUtt1L1+mLkV+yeXJMuE8NKKe1H5eyVrPr8XiZF0TRPsYiDJmD7Iop3iP/M6Go+eGIecQ1GQ9CDXPQT8lqAch8SJids64ugqewaM3UefnSx0mLTWT3ek8CQYWF5MKmT4U6RHDzVKYk//oEfNBmbPNX/u4GJ7suPLl7ub3alzoQ+GCuBbdahyv4/v/6EXZ1i6tseckJBn+pkRQBKm+TPBXXNyzzEYqPH7wcOJbZFRR636Fi0+llJoo2do3eEoFAqfQXBcRZSzTZEc4DjUijk4Kh3Y/FIQB535q/noendbEMwFQmXuWA4gwu+SKwgPFKmLs2gEKdFo4RdzlULTttBL1B1BfBYrrXWDV0EonPKQR+/TqMUflr26UBBCcRSF06z40=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR03MB3399.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?tyd18rWxmr7jXlos8O4MqgpuMtvTxHiiKv8b8tgB3xO+WPTdW9nyFSw3PtBY?=
 =?us-ascii?Q?6MG1auzwwee6jNdYocIxQz6inma/vIE3c+gyt1brsmfvLFxklU9q7vrNaq0W?=
 =?us-ascii?Q?YaoAbWOlef6vyG2cx2KJOOW687bDZ72knBXhwmL/tagKryh5RF3oU2dGm2cX?=
 =?us-ascii?Q?q7klQi94guQe1m4kLedtJkuV7Cg/57ebZ5qt4ph8/lD3jN+R2twZmqWbdSeE?=
 =?us-ascii?Q?BZyi5Ue05NrN9KhdFYSGgkD+UKa57RCgMqAGX9NSTxQGPI3gnMcQyJtUtkvU?=
 =?us-ascii?Q?ijnPJC4aa3y560tkY8aw/VPxWGsDGRyeI0PoZwvq3BJrXtSdJKkoQWaTUPxf?=
 =?us-ascii?Q?e00gfwYbi6lPTbxuwjrZNdWoWOPKo95AzSpp2pxWlUFpxnSh4ryz3ajlpJpV?=
 =?us-ascii?Q?/iVMdoVxloUsCCdbFZTi/iXNLVy6hNJpDdjfvZ142Wr8nrRa9qMNdrYFfEHl?=
 =?us-ascii?Q?R4gvzsc6UHusQqvcMPiYWrMn+qHm0Y+A4vggCyE533Y1ITWnR5wE7Bkss0QA?=
 =?us-ascii?Q?BTjkTZ+4exD1/vvOWK5ShFL288GHsGMaKsFe3TDDNDRz/WK5tHtBHTp8JRtn?=
 =?us-ascii?Q?ElpcTqSx7P1QPfv97CFZk0D4CAoMrxZapuxs+Uu/4bDqaH7hPqw6vF2oOxaI?=
 =?us-ascii?Q?YmHmR5DIcgrDSr6ejc+mRYacjBnIHQ0fB2co4Q4IR5Xb+TyDv3U6Rx4VZBAk?=
 =?us-ascii?Q?XsdMTTw2N1HzUqU4ynVSGK1WfS4h7rM+Z3BRScoSp8ojeHBu75iXYgXM4zQ2?=
 =?us-ascii?Q?eePASzHzBG0QYNcZQLxkIrpMXbaUTghW4vqvwObMQ6faZPpKw57kRthXCps+?=
 =?us-ascii?Q?VUNttcBl7e7/7+JNYVdira4HTDdILuJKi4I0O6RDCTEH0nruahUPw9+9kKxe?=
 =?us-ascii?Q?f4hGjA6FhodvpJPuUmP/UTeyJ3wXhC0E6xVY/ClB+TRVoAEK4mZ3HZRpxNei?=
 =?us-ascii?Q?DaiNCRmLqGrxqTPCXKbzu+QeaMEqD22WZUR8ObUTpxSKheEswa7UYx3t60ql?=
 =?us-ascii?Q?AdX7iNKOnZ9WhVBzX666QFxGWxqStkuX2osV9//PHtDNCPUHaTWGBaluZ0d+?=
 =?us-ascii?Q?D7yI8HAv7ahVaqulEQIfYSumaWMvpeWt7lQJNVqKt2UJakW+iKI4WNGnm7Nx?=
 =?us-ascii?Q?bSiDpwRdE50VsZYWY0bJkIIKi1qS/YYGLd8FZr90UlP4eolKoMVn8GtvFbxz?=
 =?us-ascii?Q?0n5w3awF+LHFY167THd0oXJdbDdjJ5PMV8mluUenGjgWNfBkIDuhtb58gNkI?=
 =?us-ascii?Q?yT4Zp6XP664mdofcMmQrLS3ATcZgwFkjvu5yFT957bzttgb/pI8vK6gsiIHT?=
 =?us-ascii?Q?N85pCf9XAaxYUYi3KWotGNzlaG5zlr8Cl7w/wiBHiDZcKVjgJK7rB+ivTmEB?=
 =?us-ascii?Q?EO3sMl39TapQ11/VPNubxspQ1kQUfxTeI3LaBoUb02fCElGqylcUEEiPlF72?=
 =?us-ascii?Q?DifMqBWGxbOhkG04fPhc82GypwY5Wp9aw3CYy1uWW7JkUAGQD3wxD7DkBvwh?=
 =?us-ascii?Q?70LQSr7Rc42mFtfvhtg4JpW0+/RxDGmsrqAynjc0aYr1fr+XZSx8GxLnt2PX?=
 =?us-ascii?Q?yhiyZbWEWx5F8y+C7grAY3IN/YjGRxsh4szGlfjt+maC8+Vq6aJTc1NIAmIX?=
 =?us-ascii?Q?rASO6MBE9JR1bPq923OP/JbC7QyMtqkmdW2HkNoClX59hnL7pRh2hC+LBKgA?=
 =?us-ascii?Q?tFvDa4FH2r7CsXo2iUOzSTbYQ58Uca/Ho/Oh0e8UqQAhko6vELTUnozd/76Z?=
 =?us-ascii?Q?vRiaycYoMg=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d84bb1f5-e164-4534-10ea-08de79d3ca3a
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2026 09:52:47.0715
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: alAq4Ue6k/6qJHWuVcPEI+NcPJIuGEyGQ5xzGKlcBtEXs73uBIwH42WjJ+13nGtvJhruic8diNw1lLEH+lOzv6xxA3dQ3kQsfAr940CiXGo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR03MB7274
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA0MDA3NSBTYWx0ZWRfX8JK8QrPQSgoU
 3tqiTRSasvWKOcvO9r1w8DlWMbkgdoHAcsn/0Xu9MAR4CYr8dPRZq/GAu60tESEtX1ny+Uy4VNC
 TuKNh+8IEgqUlvAxhJVr5QQvY9Mfb/gL418InECd+5zO8uSIDMAGU5AhCDeKnbGDVk0h6SQcwxw
 O9ttxJRty2W0DtbY7q5ER4fDKFpUhEQKuAomeNPlcOB340Fao44fV5Z72Ew0KLVPrYz0PyKbcJc
 nX7ZJXMOcywu4mJRtavJMv3FUBsp/g5PCgV+SJlNmzV24ClPr+dy+Zq6dZ4nSAX+7irreEXsIil
 UhBxw6clno9o0yBdgyr1Ut+27E3JxASft0jvK+Ps+NmQEq/+cQI+JBP6LEhT7w4cfgNa02fAkUy
 FW9JLltufv7mAkuYoUwv/dWpolU4i7/FVt1LGkHit59llaXvXYy7/inZO0TSl1j1mimWoDgARpw
 caZnyLdFzcR9XxXbmNA==
X-Proofpoint-ORIG-GUID: A4ZGfN8xL-55cDhqSmd0ne1QoEJriVLY
X-Proofpoint-GUID: A4ZGfN8xL-55cDhqSmd0ne1QoEJriVLY
X-Authority-Analysis: v=2.4 cv=Jtz8bc4C c=1 sm=1 tr=0 ts=69a800f2 cx=c_pps
 a=5dagRegx5OoopB5Oy6OMtA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=OmVn7CZJonkx5R5zMQLL:22 a=gAnH3GRIAAAA:8 a=QyXUC8HyAAAA:8 a=VwQbUJbxAAAA:8
 a=IpJZQVW2AAAA:8 a=1hsogBy_WJP0_qf0gwsA:9 a=CjuIK1q_8ugA:10
 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-04_05,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 adultscore=0 suspectscore=0 phishscore=0
 malwarescore=0 priorityscore=1501 bulkscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603040075

> -----Original Message-----
> From: Andy Shevchenko <andriy.shevchenko@intel.com>
> Sent: Tuesday, March 3, 2026 3:55 PM
> To: Miclaus, Antoniu <Antoniu.Miclaus@analog.com>
> Cc: Lars-Peter Clausen <lars@metafoo.de>; Hennerich, Michael
> <Michael.Hennerich@analog.com>; Jonathan Cameron <jic23@kernel.org>;
> David Lechner <dlechner@baylibre.com>; Sa, Nuno <Nuno.Sa@analog.com>;
> Andy Shevchenko <andy@kernel.org>; linux-iio@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Subject: Re: [PATCH v2] iio: frequency: admv1013: fix NULL pointer
> dereference on str
>=20
> [External]
>=20
> On Tue, Mar 03, 2026 at 12:01:31PM +0000, Miclaus, Antoniu wrote:
> > > -----Original Message-----
> > > From: Andy Shevchenko <andriy.shevchenko@intel.com>
> > > Sent: Tuesday, March 3, 2026 1:34 PM
> > > On Tue, Mar 03, 2026 at 11:52:28AM +0200, Antoniu Miclaus wrote:
>=20
> ...
>=20
> > > > +static const char * const admv1013_quad_se_modes[] =3D { "diff", "=
se-
> pos",
> > > "se-neg" };
> > >
> > > Taking into account the indices are not sequential, this may require =
another
> > > enumerator.
> > >
> > > Ideally you need to list all possible modes and choose only supported=
 by
> > > assigning an empty string to unsupported ones.
> > >
> > > I haven't checked datasheet to understand why only 6, 9, 12 are in us=
e.
> > > Maybe they can be simply 1, 2, 3 with a formula like 3 + x * 3 ? Dunn=
o.
> > >
> >
> > static const char * const admv1013_input_modes[] =3D {
> >        [ADMV1013_IQ_MODE] =3D "iq",
> >        [ADMV1013_IF_MODE] =3D "if",
> > };
> >
> > static const char * const admv1013_quad_se_modes[] =3D {
> >        [ADMV1013_QUAD_SE_DIFF] =3D "diff",
> >        [ADMV1013_QUAD_SE_POS] =3D "se-pos",
> >        [ADMV1013_QUAD_SE_NEG] =3D "se-neg",
> > };
> >
> > static const unsigned int admv1013_quad_se_regvals[] =3D {
> >        [ADMV1013_QUAD_SE_DIFF] =3D ADMV1013_SE_MODE_DIFF,
> >        [ADMV1013_QUAD_SE_POS] =3D ADMV1013_SE_MODE_POS,
> >        [ADMV1013_QUAD_SE_NEG] =3D ADMV1013_SE_MODE_NEG,
> > };
> >
> > Does this make sense?
>=20
> Yes, if there is an explanation why we have 6,9,12 to begin with. Can
> somebody
> study the available datasheets and come up with the explanations?

There are the values accepted by the QUAD_SE_MODE bitfield.

https://www.analog.com/media/en/technical-documentation/data-sheets/admv101=
3.pdf
Page 37 of 39, Table 15. =20

>=20
> --
> With Best Regards,
> Andy Shevchenko
>=20

