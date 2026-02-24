Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8489E39B48E;
	Tue, 24 Feb 2026 13:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771939862; cv=fail; b=EzPPH763wDi23sy08xLq64pIljfGFPZ4CElNvAkoutHwO3KZzeJEXUAg/6wRSf9K2TyoSFo/9T0dFBJKVBtGe7GzS6rMkbXO297bUYu2dqskoMromcHYhYnmgMvFqITAks8LTGWubXblc+cr+wUOJIvZlu967gD6WyzA8XgpCAk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771939862; c=relaxed/simple;
	bh=RBervgY3GmMi86C77aAeDfpOQfn2pVqr5yJY7T0TA2I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LQ5TSyrQp3fI6I085KJS1UTccyywekhB5wUiK6q4gvZklIqGL7jI4ZOy7OOy0DsV182vzf5tM3vxRWmXdV9vpgi42WIxFzbAiEp/nTQqAPmcpvYAFfH9zhyp7EPa4zFVuMsHVJGBsqVmuJBiKxo4+vBzhK32xVPO/uIZUjuUXc0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=PV+98Ldr; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="PV+98Ldr"
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61OAJDQi708861;
	Tue, 24 Feb 2026 08:30:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=pVo0b
	l/Qc2HrkZJD6vwLYN97Ez+FE2YzBHFIn8N9zTI=; b=PV+98LdrAHt6WIGi7C2rG
	iRSloHYmc5kgk88ymXHBY16vsaL95+wH8V9feJFp+gZEdg11tiOh6nEMvc/I2MOs
	vv+x1jyitDFyOFU8ZqDjpx1sWhkkVCvlTRa3HBNSYaDuGo8CL7rV8+r/hUIqbhDz
	E2WBxx53SFdtX+Nhq9lKm1HDzBACleOz0lcwBSv98tRxZnIC2EcfWAG/+cBr7wfj
	lxsOO1luD83zFy8kQ63loz3zvKIaY6CDqKEy6KsyDfFRq5+3DljIJFUkdGy9n/Qi
	LNDA9Jx84dkHyvzE0eZnxwcEhGjYQyLPx2WMJ8VC/ULunfZZ40ssEgdaKh4mNvbU
	w==
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011055.outbound.protection.outlook.com [40.107.208.55])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4cfa77hkhr-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 24 Feb 2026 08:30:44 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OyIcTu/HztEssa/uyyCel8VRbYsCwQ5JZ0HbFV2RTIMkml4lICfyNonO55cTF/FBJPdBr/0st0r9GIjt/05KiSQfjHrNygB1XeHHhNvh0vNV+9I2Pfckv96YXgLW8WePQkz7aBE2H1SKiwSN6pVtuV6b+O+wASh2GvDffSTg3+Z5oxTlwhqDoePFzC3rQJ1pWx0TyMD4BycvvQqqddI9nn9s60JzkivEpB04q4dP6nC9pmI+v5x4b3EDDcAtVohD9NBWFHIJNHrg4+QV13TA58RPr2APojojjYrCVoSWO7hgPwt+PeeHhiKD+0KzOw2LdYIbW3U7BSDLrnLcEyQ2oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pVo0bl/Qc2HrkZJD6vwLYN97Ez+FE2YzBHFIn8N9zTI=;
 b=KINrJ6vG7dZzPUcWDSeQhRNZ08L3PGuTPxMxBtNipZ9xiT9b+Nn/BbztfVo2o5xGVmaO+NQSd7KeGAEB6m+wJ2uUlk+NsOKSdOIrJmeovGzGvuacc6RYrQCkEXSMfYsW0hkP1IBmT8LPjOxCIjBpgj7bs4jz18gfKnZvOSNzgGBlIPjte5Zzh7MaRa2g/VvHs89CMRX5JMFl32KaU/QB/ZrGwKnrSzMCHt11dehKBX4ULsUhPVjxDeYLPe2E3SF+4jz1h5w5USLcRZO1Tm5j1lha0USZD/Se9dvINOdHm08Htpj9Mr/31sSVxgq0+MXDAXKBQTlpaDege8ChJzZERA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from CY4PR03MB3399.namprd03.prod.outlook.com (2603:10b6:910:57::13)
 by DS7PR03MB5495.namprd03.prod.outlook.com (2603:10b6:5:2c5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Tue, 24 Feb
 2026 13:30:41 +0000
Received: from CY4PR03MB3399.namprd03.prod.outlook.com
 ([fe80::1527:d313:16d4:2376]) by CY4PR03MB3399.namprd03.prod.outlook.com
 ([fe80::1527:d313:16d4:2376%5]) with mapi id 15.20.9542.010; Tue, 24 Feb 2026
 13:30:41 +0000
From: "Miclaus, Antoniu" <Antoniu.Miclaus@analog.com>
To: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
CC: "Sa, Nuno" <Nuno.Sa@analog.com>, "lars@metafoo.de" <lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "jic23@kernel.org"
	<jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        "andy@kernel.org"
	<andy@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] iio: adc: ade9000: fix wrong return type in streaming
 push
Thread-Topic: [PATCH v2] iio: adc: ade9000: fix wrong return type in streaming
 push
Thread-Index: AQHcpZFQc2H59UH3dUSu4eQKI1QCs7WR1/PQ
Date: Tue, 24 Feb 2026 13:30:40 +0000
Message-ID:
 <CY4PR03MB3399CB636A1351B78442D0679B74A@CY4PR03MB3399.namprd03.prod.outlook.com>
References: <20260224125921.70946-2-giorgitchankvetadze1997@gmail.com>
 <20260224132354.76672-2-giorgitchankvetadze1997@gmail.com>
In-Reply-To: <20260224132354.76672-2-giorgitchankvetadze1997@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY4PR03MB3399:EE_|DS7PR03MB5495:EE_
x-ms-office365-filtering-correlation-id: c061c837-42d1-4526-a535-08de73a8e78e
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?XeOZG6/3imz0sl4cDGdsxhl4fiMq9pUT9sGwHT5uOp5GlaAwfaBHFdaaxxPo?=
 =?us-ascii?Q?GoiSguJ2v6LDwTzKeTG7S2/V1lFKMN7hiyM3yJ31rZ30jSalk4+9XatZtzN2?=
 =?us-ascii?Q?K+1dh+OOJJMYWuLmXitpq1bndKoXf1KAIJbZVhcK7OHUXHzwVHCiRYtMVECZ?=
 =?us-ascii?Q?6HzKfl0C4WoZAc7h4dVMmaHxCaJfYkWrb6Cj3y4WTBcJEaFq2p3ZRBeDMchF?=
 =?us-ascii?Q?PsSOlcOMr3zz83CZ1Cz7YRAbkgDC4G6lQR/MSI/oM7sGhnDN5Y0erquG08dz?=
 =?us-ascii?Q?SExxWqAmzqGnFySdyAvuL/v0LNZi4y3gMmmMluM8pYSJ7ScgPN2wE/1ercL5?=
 =?us-ascii?Q?EL4q6ZRKK8vEIBdy+fStiKBTD4sGuqP3HqlOtmdTzytMwltHuwZAa6Vbb/be?=
 =?us-ascii?Q?DN6HIDEdsL4F1gGQ4yp2AE0agLidvhYk7LoIwGzkRya39GWei4Fgd8r3HR19?=
 =?us-ascii?Q?SXQ/KqbsPnqTABeCU2l28eY4gVVr8+CqIs9r3cKk0rxgy1c+ydMnXawHNrux?=
 =?us-ascii?Q?XFyL3SjyRphK5c7Cqn/mxfzoLMrf9JsLaw1jGAU54Z4LyBMFdRQWMCKhr93V?=
 =?us-ascii?Q?mRJc3LZoqsmgxELZoz/JCqiVPoLe1baYqzji6XRQZ4FiRGRh7SY10vB3H5z/?=
 =?us-ascii?Q?05OVciX/KcTN0hzwXqvEENJ/+U/LAKzc3AjySNFv9VJqVx3BJv7qxxsk+Ft9?=
 =?us-ascii?Q?VL7icQwgyqwJFG4uYc/64DyI+5Y+njLiH3z8m2m/LrEb5kfEQE/gpUzYQF2l?=
 =?us-ascii?Q?0qtveEsOnAaxuI19Fdqnb4o7rYXQgNrx+DOdIPYERJQwVRjxxsoJmMSne3ji?=
 =?us-ascii?Q?31kckM7ZXIgflnztK/7taFxHUNvbjxOloyyOGZUXg/dMhNgKUiQr99PAVlic?=
 =?us-ascii?Q?jKWN89AraXq11jHE0ZSlW1Zq/DGLmCpm5MBtMICmENVtY9il5PT8FrAPKdvN?=
 =?us-ascii?Q?d+/rCaaj4hhBrg3yEQYXlHaQ4/fQe1BNmuj9xewVm8vBVtO7gt6wmm+JB8Ww?=
 =?us-ascii?Q?JPaltxQfOr8lJQOKomrrpEf138KkSmfCyqz5zdc3zaAmP2g0YXCPUndJ4KGF?=
 =?us-ascii?Q?j86ERImykRODjEdEO1T+tNdku7NTEuY5YHqqwjtisFsIo/ZV+8lbSdujepjf?=
 =?us-ascii?Q?WNEUzDEMKbIQsti1jGMHOWieceLHRL4yV+k6a7Dd5IB8E8XvF2+tkM3dfRRS?=
 =?us-ascii?Q?fLNvAzwhDNWoq1xtyzvnbfqn3eerPCXc6shwr/oMEdwRT9GRW4KpsHgZbjgQ?=
 =?us-ascii?Q?XDmAAwQ8BiXcqDu70/tAwvIns8EosV5b/ViIJmYmwiUadqDchSJ3MMJqSPkZ?=
 =?us-ascii?Q?W2+RlozKcW/wgvbcaBoJ6iU1RWygR2bo1uc0RkbrjHTg3dP9XPdsAaHuEOqd?=
 =?us-ascii?Q?h8IwtOxHVrgn4ydFXaYA6iLCYZ7vnxYb6+itX+1+Y/iW10Ri899nQvU8yBv+?=
 =?us-ascii?Q?IACMRKDKdzNyZBpw1ai/TDaUZbrefkgDKBURBIWMInd9Z9IOHMUNinbhmC/K?=
 =?us-ascii?Q?hOpbgoGOj2IYVR4d6Tg8Wx0/tQlFzs5KbBa1u6z0dIKcXLyY+CoD4PZWwHpN?=
 =?us-ascii?Q?ov8Gi3v9qg9H5A7jUIaZtfCMxXhB23dfIUfFW0nZtOtg7JfuWRsQKI72JKVQ?=
 =?us-ascii?Q?0BQzgCxLUUEFWRXXX0TcEOE=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR03MB3399.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?dvx1tSInzswPnVQd0KQ8zW2aKQawXtcIZcH+hdI3zp7WxqbdH+vEHY5bXCw/?=
 =?us-ascii?Q?2DxB6mfRXZUgdpv7q5iUC0H7o3ODfaQhQBR0kZoYr4Gk21jnRh1OyHcqfhT9?=
 =?us-ascii?Q?pDO+VuFCJRHFs7pDnyPK1DVVeDFEgvfrTxC+w2O/sKSBMtKFdB8N9zhVDEJV?=
 =?us-ascii?Q?DYtUOQtapq1QJ/mSXcrtw8sFTedIC/nVvwncVjI9b0tVXI6EK82Yyuh1ygu9?=
 =?us-ascii?Q?wPL+o7Fw8AGx5oagratPiWt98RKz+7HlO1aqhZFAXhNrhpA+qtXqFhcHWvGW?=
 =?us-ascii?Q?XblYphNDyuQF+uFT+wCK6TKZnPcap6JdWmmOM7HMoOconpucmDCUJAKoMiBX?=
 =?us-ascii?Q?NEJ5U104YFcL16uGNFWp+X1kNm9BwppNgJnMNDIhRxSRrxi6tRbQayjpv+aT?=
 =?us-ascii?Q?yZPV97g4epdq+aFl8ZUFCZvfBXTOlGNcBa5gxhyxG3TdGjwzMWh+9Tb2c+Yc?=
 =?us-ascii?Q?ujpqRqdEQBdSRZ2Gk/zg7KqodUzmYZu8d3FDhJcWQWpU2sGAkD0WbMffIITe?=
 =?us-ascii?Q?lgCUyGXzgtjvKlN4KNx4LBbOUK+tmo56jhLuxy7ZQ5gWuF/tSGuzMGpEVTQI?=
 =?us-ascii?Q?qmdWdES0s5ERjbNqLptwrc6CP2fLacYnXJmK9/GXPQ3AyXNuO4HSX0rXiG/5?=
 =?us-ascii?Q?N8pzgcIPgr6asoKlc0V7NdKwcgImAg+/dz4W9EkCCi3x6YKJuTp6f2XaSIrR?=
 =?us-ascii?Q?u9ZdpqI4Ufo0NGKhCA1eIMnJhfoIiGlv2G/67IpYWWHCO4vYo/VlBdDvSq/O?=
 =?us-ascii?Q?rQCCCHeEMCcggHK857z6pvi0BVtFPTD/0Nwg/kkw/GqDxSYrZKdQlxSNgACi?=
 =?us-ascii?Q?eFaY/bHkhvSPliKrboT7VuGPVYEx3IyBHs5X5zLk9D2pB2Va9urmzbC5One9?=
 =?us-ascii?Q?jmGfy5VT3Y7skDTXzJ1pNJMi6/aT1jhDuTHHWw8o87fGHDsNeva4LBbTOeOK?=
 =?us-ascii?Q?SLpyKEwWmqluR6O9XFYvPxU9HOvQOPa6L+7oPKTgszihDKbUh+z5jXiEeQ7I?=
 =?us-ascii?Q?2le3n9G0wnM7Tz1H9+4dN2f+nqBERXzjKDaJDDJspcjXogaWR3AHY9xjwTTs?=
 =?us-ascii?Q?PoqRSmHW58YL08aBKPZOL4tukziqxfxHQtzmQOWIOSOL2hwZPnrnFEj+9lbj?=
 =?us-ascii?Q?5yFoZ3dXaRf5Dld4nloi51xKXhzoAPseOxtHQQ/pS7p3nxt2j7NRxLUPjQI+?=
 =?us-ascii?Q?YgSVZQsWaNaFQch9kGFzABW9hY1HMn7mX5xXHxjXRE3MVJDHD+KH854HATAr?=
 =?us-ascii?Q?UdZR9nKM8F5cQ8tMbwNit3bizk2GAuENlmEKnXh9zPc0wXgvq7sYM5OeuT6I?=
 =?us-ascii?Q?trmLBwCjEOuZgHvQWbGtgFZMoccChZKEoUmL4CErwUamwi02Nx6aXQwMGBWN?=
 =?us-ascii?Q?9F0Eqq599KWFm+hYlN/seP6NLi38wyDg18L1oEg4O2rHaW/DPfXSNMKYroc/?=
 =?us-ascii?Q?G22tpHMxu18JwwWEUJjZPj++Tm7Xfmrkb5xff9RnpNh0RBFgymiqawSrT3NA?=
 =?us-ascii?Q?WrVuHQBMUV+JkFRTnjyJ4cLFmejp9avgWrh1JC8DX4KgYE5YW7a6fSLW8T17?=
 =?us-ascii?Q?Yz+kNEECIebpQqKxwG6ZvZb/Gb5AoIVyW11/KQb7rYp/51WxbHfwO2AI0wjb?=
 =?us-ascii?Q?TAA60DjaSeQ/7DmJucmielMd6bxUb+EJywbOnWrrT46zVEfrLI6LjCNQt12H?=
 =?us-ascii?Q?MKdIW22qESmZp3bVCh4xzebe0wKzpasn1/gaBW3w9P+TCd2LiZi18GrgDrrk?=
 =?us-ascii?Q?Ve982ngZ5A=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c061c837-42d1-4526-a535-08de73a8e78e
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2026 13:30:40.9376
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qrzrnAwkUQuJ9jBnv0uk8SJZq1CL/E6zu3WE5Msjy6A5YlJJ/0B8lbVOHWh/15JtpNzSxcXYryLsI04EFm2IHrm5FdSHS9H2ur90QFRIuZM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR03MB5495
X-Authority-Analysis: v=2.4 cv=ZZMQ98VA c=1 sm=1 tr=0 ts=699da804 cx=c_pps
 a=MB7q27p+LIGhC+3RxemCqA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=_jAD5XSDOtq9-5Nde2OG:22 a=pGLkceISAAAA:8 a=gAnH3GRIAAAA:8 a=VwQbUJbxAAAA:8
 a=IpJZQVW2AAAA:8 a=HYa3HKi0pKmH0PVf4JkA:9 a=CjuIK1q_8ugA:10
 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-GUID: fMRisfDRqcxIOzhvsmyRy7myvDLJ-sl_
X-Proofpoint-ORIG-GUID: fMRisfDRqcxIOzhvsmyRy7myvDLJ-sl_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI0MDExMCBTYWx0ZWRfX3ktB+k+1oEK3
 /KN28Rif42CIS0/ceTMHFZfWaR0yHx6ZLe9TMi/9Wjr1FgjP+aec1Zqn1RzrRbW3GUWVPohqmDR
 dsiaPyXLUH4at9CX3mV0wOeeapjBSelPNSN51Cbd6AVNT35+YOgwltYGosc8lpQPa4+gzTyx7ua
 DsOBD+RYBqDpfz6Q0+BCpF5yQwkoGQVx1crjjXmgJFsU3mjGKtJn1l+5R041YXHuhwtp9+nYo0Y
 aqa7MA5iJQLxMcE4ArcH9jaVeh4B4OPHLsPyxmG8tuEsn/3e0IDBVUfgzwXmz7eEzA6Z92GKTzE
 zG26ddAn8lve/5iRsHPbkFro9TB3ub8Tj6xIBVweoDciIvWSS5Q7qDYAUJims4HdnmG0dV3U3OS
 YWFk13i6j6rPwcqd13bP3xyacstCRl8jQlHIQCSfKPTLKPjzLsD1RZkKLe5OzocR03lOFDWeW2l
 gyQXzdF11JFqj4EFXEQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-24_02,2026-02-23_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 bulkscore=0 spamscore=0 impostorscore=0
 adultscore=0 clxscore=1015 phishscore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602240110

> -----Original Message-----
> From: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
> Sent: Tuesday, February 24, 2026 3:24 PM
> To: Miclaus, Antoniu <Antoniu.Miclaus@analog.com>
> Cc: Sa, Nuno <Nuno.Sa@analog.com>; lars@metafoo.de; Hennerich, Michael
> <Michael.Hennerich@analog.com>; jic23@kernel.org; David Lechner
> <dlechner@baylibre.com>; andy@kernel.org; linux-iio@vger.kernel.org; linu=
x-
> kernel@vger.kernel.org; Giorgi Tchankvetadze
> <giorgitchankvetadze1997@gmail.com>
> Subject: [PATCH v2] iio: adc: ade9000: fix wrong return type in streaming=
 push
>=20
> [External]
>=20
> The else branch of ade9000_iio_push_streaming() incorrectly returns
> IRQ_HANDLED on regmap_write failure. This function returns int (0 on
> success, negative errno on failure), so IRQ_HANDLED (1) would be
> misinterpreted as a non-error by callers.
>=20
> Return ret instead, consistent with every other error path in the
> function.
>=20
> Fixes: 81de7b4619fc ("iio: adc: add ade9000 support")
> Signed-off-by: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
> ---

Reviewed-by: Antoniu Miclaus <antoniu.miclaus@analog.com>

> Changes in v2 (Antoniu Miclaus):
>  - Drop unrelated newline fix
>  - Add Fixes tag
>=20
>  drivers/iio/adc/ade9000.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/iio/adc/ade9000.c b/drivers/iio/adc/ade9000.c
> index 5dcc26a08970..5d659f1bd3f7 100644
> --- a/drivers/iio/adc/ade9000.c
> +++ b/drivers/iio/adc/ade9000.c
> @@ -787,7 +787,7 @@ static int ade9000_iio_push_streaming(struct iio_dev
> *indio_dev)
>  				   ADE9000_MIDDLE_PAGE_BIT);
>  		if (ret) {
>  			dev_err_ratelimited(dev, "IRQ0 WFB write fail");
> -			return IRQ_HANDLED;
> +			return ret;
>  		}
>=20
>  		ade9000_configure_scan(indio_dev,
> ADE9000_REG_WF_BUFF);
> --
> 2.52.0

