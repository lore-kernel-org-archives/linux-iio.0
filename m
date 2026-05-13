Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F50418E025;
	Wed, 13 May 2026 16:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778688528; cv=fail; b=R/NuSQh5Lzbf1NpB9Bjt/9CpBn6XqqH3gxriq7xWSVVWAi+e64jpwfajJWhFDuMIzWCmxVwfme2JSTIu4hsXuo0hKg+mfbx4pVMWH9PFGkJBLeaTF9EjjT91BjT4jCemSUSDn7CuieznBlZZoN8nZDBz+jZA5BQrNOEv9c74o5Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778688528; c=relaxed/simple;
	bh=VF8BjZfbdko7UWdmjmRvuLY6rql6hc9xSRN+pLmHcAo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZC+P+sE1A4y8fPisX2EJNL/zMiq+UrSNLvjBUac9G77bRMu78OSg/BajXGbfIOjoEKeVwndBKfXY4/gH9Cx+GUS1d6iUiDGmGnHTQp+Oe9TgTc8NZ5oXS4zhKkF19WrBofVsFwBNtuUukMmd6CWNvvUOvQE+S6SvBF0KW3M6d7o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=b4kEEi93; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="b4kEEi93"
Received: from pps.filterd (m0516786.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64DC7dBW2831767;
	Wed, 13 May 2026 12:08:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=VF8Bj
	Zfbdko7UWdmjmRvuLY6rql6hc9xSRN+pLmHcAo=; b=b4kEEi93T0K6Q1Xf3dXOr
	YDRf4ZelSt0q7/vzWLtuF8Mg7pWYnCB7OhhYPEbNJgnTUIyjjwLkvVsTM4VK8Xqc
	8XLvaJiWjr7GV1WqiUktMVzKVPw+pby4Xc68XVL/GrVduu8PMWjdl9W4iKYhLwKG
	XW46bV6Q/XChZCRrGdU4LYLaji3wVsQ7TX9I5b+hgDSQ0GgzVbH2ym745DnhOLpQ
	b65w2g90SsKSKoBjXENCMM2uolTo3v91NbJdVZZ+FuUgHvPMFVQWWOwyVpg5PvFi
	+NXtU/Qko33BNAZ7smsy9hMglwgy5TcH2LVh5OIQCDcHQCH6LIkUAlHjwLYu2p5c
	w==
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010014.outbound.protection.outlook.com [52.101.61.14])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4e4k3st0vg-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 13 May 2026 12:08:32 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sBKWkdnTxpAbEFFSHXO0kC+U7SN8PDOhjcXgiDS5opJzjkXx9Qh2HiDAOpayk0PoYtNuEnWhhzhDretQ5ZTi4fGFBSMLsr+LgDvxPg/B4gK5Z+J3w4FaDMuX3GkCuAIoaZPKritqjRtBXJKXxotGduaib2eMeRUHi7YdyB9vL/zQIolfMUWci/nhdIpgOpAmIlB2PEFYk43+gsOz/GuxRzU2I9M8842I4Cmlq3dE6N+EU+C502iyxGkXNLsOr5o3njOQ7qAWJyOZINpxnYXEGnsgyP9s1OxNA0EMBPzYroy5/fc5tO/ga7d5OMXmnHcJEW1nDQp0PKKPGGQuTi0A8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VF8BjZfbdko7UWdmjmRvuLY6rql6hc9xSRN+pLmHcAo=;
 b=Gb8qGCkMJeusUougkQMjVLEC4WNOfUzFTfaJ7Vdqb3vRNQvPpHq2AQ/gC6ixeG3vSLvppCpfeyOoTed+waGE0XLTbO1YH9wIeIMgH+EU87CDLv2ccp5GKL7N7dSEIfGlcflEu22650WAGOlBCwHOlUmMNbugJo4G+p6Q2H7zvmln02NJx3gE+WDjwOiJmKiKejr9Cnk/WscYy2tTNZ0peda8n0yY1AGDG+9i4HX5CGfLLMvn/A2bkIOKFIBhYkpU4pht34qxpCJitGFgFhWfNGCELjx6LrK2FsFd8wj7/F5E8FGI/5sSg/Qe3doHozFeLbmprlZ3kG5C1eNK3QGGjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from SA5PR03MB8377.namprd03.prod.outlook.com (2603:10b6:806:47d::22)
 by SA3PR03MB7419.namprd03.prod.outlook.com (2603:10b6:806:39c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 16:08:29 +0000
Received: from SA5PR03MB8377.namprd03.prod.outlook.com
 ([fe80::9276:9909:1b4c:8438]) by SA5PR03MB8377.namprd03.prod.outlook.com
 ([fe80::9276:9909:1b4c:8438%6]) with mapi id 15.20.9891.008; Wed, 13 May 2026
 16:08:28 +0000
From: "Stan, Liviu" <Liviu.Stan@analog.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: =?utf-8?B?TnVubyBTw6E=?= <noname.nuno@gmail.com>,
        Lars-Peter Clausen
	<lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "Sa,
 Nuno" <Nuno.Sa@analog.com>,
        David Lechner <dlechner@baylibre.com>,
        Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/2] iio: temperature: ltc2983: Add support for ADT7604
Thread-Topic: [PATCH 2/2] iio: temperature: ltc2983: Add support for ADT7604
Thread-Index:
 AQHc1kn/5d/Hh1H9DE+/jMXiSvhLvbX0U6uAgA5CZsCAAVTVgIAAIEGAgAAYMKCAABGiAIAADdZQgAAbwgCAAXn1AIACljLwgABUcgCAAArCQIABVv6AgAAduqCAACA9AIAAAqvAgAA9yACAAZQhUA==
Date: Wed, 13 May 2026 16:08:28 +0000
Message-ID:
 <SA5PR03MB83775D6BAB99A5BDB172E649F6062@SA5PR03MB8377.namprd03.prod.outlook.com>
References:
 <SA5PR03MB83778AB3C41E0AF56EC754F8F63D2@SA5PR03MB8377.namprd03.prod.outlook.com>
	<af3oezNmmBhI4Yu4@nsa>
	<SA5PR03MB837710AE7FD8B8FFF138B7C5F63D2@SA5PR03MB8377.namprd03.prod.outlook.com>
	<af4LCQiqNaiMzFkX@nsa>	<20260509154600.02e2d11a@jic23-huawei>
	<SA5PR03MB83770D945E92C40A74D9C0DAF6382@SA5PR03MB8377.namprd03.prod.outlook.com>
	<20260511121820.3be9e635@jic23-huawei>
	<SA5PR03MB83772A1A57DC052CB21B9187F6382@SA5PR03MB8377.namprd03.prod.outlook.com>
	<agLhb-S2ISSjaopc@nsa>
	<SA5PR03MB837758532C0007A97121F6CCF6392@SA5PR03MB8377.namprd03.prod.outlook.com>
	<agMXiWA39tW9mZ2O@nsa>
	<SA5PR03MB83776E4DF7B5542B40C3B925F6392@SA5PR03MB8377.namprd03.prod.outlook.com>
 <20260512165654.5adeba0f@jic23-huawei>
In-Reply-To: <20260512165654.5adeba0f@jic23-huawei>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA5PR03MB8377:EE_|SA3PR03MB7419:EE_
x-ms-office365-filtering-correlation-id: 2442426b-f18d-4e12-9cde-08deb109df1a
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|4143699003|38070700021|18002099003|56012099003|22082099003|11063799003;
x-microsoft-antispam-message-info:
 DBbqxejlSmdBKPos1KG6x1sTaNPKPzv7WSoBmGgONUBa/GnJ6AXQI8aIosDpw0olYbIi98+Axc7g/VRdAOGLXFcjFz0ausXDLyetF9P9zRktrnCsjn3QTCy8i9bGWyhsL1BTEcu5jCvxDffIO6tePRur5rdbe5Gpr6M6qcKxiTp2+zd0oRt8mJzlu5mQZCS9BxpJl6yMbkAYbEyFqvie66TDIFszz+TmWzT0pIZFX1kqN391PWs7IbCTlcZi/rnG2+4agbVpTyxux9Xn+OBlpZzNLQPJXAKFfe4K+VpTkWMtIJ8W1cP91vZj0Z3vcHLNB339TJgpBldAJq4ffbU3J3o8Fd7MnKz6WHwbSnO/U2iZsWSrUMJUGK6TJ7s9YzLgSUPpsIHayTAB9ATwUwvgKWrT/ECUyrvi0JWqGmzKUAVQ70u6thTAQRiVwGfxvqUHq/T9hySx+8VkgBSy7otHy6ZsBm0veWn+J03eQEdqEG3aeRdT7duFT6ZJmY7gRNJraAAeraO1lDA4K7Jqy0s7mjPwmCR357+rIRFjIdqQnCl5cfYCfB8PpVRxDZ8HW1kwmWtDExyFkGAOhZe50dSs6JoDW4pmBpQ9q/NdEqmc+yCorGzBhOPb7DAFYGVJEge5xLbJ/BhnuLw6KOp4+Bj+E4oTOzQ7RVwHIXaWugbxZTWckFEiNZjH+YHZJTynUx4jPiIPngUMLHzF091dMPt4krQWT427aLvsIm/DyvxDeEFJZKJ6NYvwXo8t4Szt9bJh
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA5PR03MB8377.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(4143699003)(38070700021)(18002099003)(56012099003)(22082099003)(11063799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VzFwNlJzMnp4RE44QVJGSFJBUGE2Z1RFZkNpeUlmODJBQ2RjTDNKTWlaRFdC?=
 =?utf-8?B?ditOWTdrUDhFbmdTUUtYajFjL0tpcWoxU1lWTWowVk1MZHpvVk1Ibzd0VGs2?=
 =?utf-8?B?Y3pZellXOFN1TzZCQ3hxSXM0VTkxN1F1Nlg1WDREMytITzRkWmw2TklpUUcx?=
 =?utf-8?B?dXp1dzV1STB4aWoyL29iVHc0Z1VpSjNtVUdiMFNZZUppVGVBSTNVVC9KdUFn?=
 =?utf-8?B?TTFMbjVSUEJGcGJvejUxTXpmbStSYXNpaW1VUHI4SGw3ZFptczVMVllzTy9h?=
 =?utf-8?B?WFp1NDFRdTNiQ2xCc2RnRDlTM0FhOE94bzYvU1Q0b3I5ZEVQRWNldDQ1ZWJr?=
 =?utf-8?B?cG9oMW5RNUxncXFkM0ZTU0w2VDFVYkVNa3k5eGRqUEpuL01aNmJUdVpXa2Nj?=
 =?utf-8?B?aTdENUJzd3lNaS9tZzhlbEtDcGpiQ01uZ2hGMXNJemFpOXZmcDNzd0tZTHRU?=
 =?utf-8?B?bDFyNFMyWitPMUQrZkRjaklkaHYvb3dUVlMyd3NrYTM4VWc1RDdYWXF4clJv?=
 =?utf-8?B?UWd3TUtsQnU5T0haakJyZ1hicVE5cDNuT05EZzA1VGpGU0U2eEdXMUJISTRZ?=
 =?utf-8?B?RXJTNlc2ZHU1M01vQUhCQ2JTSVhlVjZ0WjVhblhsT2EyL2hIMUMvYnBrWTdM?=
 =?utf-8?B?WEc0K3RDMFFjdkdTUSs0SEpqNGUwKyszcXV6K2d2Y05PbGJYZXl2VHkrVlU0?=
 =?utf-8?B?VzljSFo1SllYMXFEY1crRHJTZ1RjWDJ6b1J3clhMK29pUEV6STdOUWhaa0VT?=
 =?utf-8?B?Um94NWptVi9mR2dqbVB2S3gwekgvMUd0ait1My9oSCs1YjcxYTBVUnZQU3Jv?=
 =?utf-8?B?Vkl2NHRQL1RNVXBXS0g4bEdGalF0L3R2NWtJblRlLzJUZSs1aGVldTE3NVdM?=
 =?utf-8?B?RHh0WmVRUXlYV3MwU3BFSXlmSzZSM3d0ZTkxZ3VOVFhJb1FqcGdNeDVOWkFN?=
 =?utf-8?B?VllLZ2N2M09FdVlxTVhuRlFVTnordWNvQzdrR1VOMS84RnZDemFOZkMrNWY4?=
 =?utf-8?B?RTNjS2VhVkRRRlA3eUhaUGltSFVGOFVXSS9FUEpLNU1JNGhnbUp5MDl1SWM3?=
 =?utf-8?B?VFdGdTc2MWR1UGpMUmExakFYeWZPdzBYblF4eHRxOTg1K0hpUnpPWGJpYTFh?=
 =?utf-8?B?anhjUXdrV2hoZTZZTUVNU0tlalRPb0dkbFdKZktOb1pDOVFMRWMxR0JId2tY?=
 =?utf-8?B?TkN6V0VsVC9LSWRWWjI1bjlTYkZyR0tFR29jcitWSWt1Nmtsa3pydDlqcXVp?=
 =?utf-8?B?QlFTWWY3bjFKVWdBKytxZlB5ZUxMN0s1SjlPbUpFWjF5VXNOcnkvc1VJQmZC?=
 =?utf-8?B?NzRBOWxpNEZBVFZPREdqQnFDWW9aQlZ5UFV5L1NwYm04YkFrd0VlZ0xFaDI1?=
 =?utf-8?B?cXVYRmlkamZGbE9QMFRZeDlpMEZQMkJsNTFFUWlsc2ZaamNpYnRVS2JKUDVs?=
 =?utf-8?B?cER4cUVsMnJObWM0ZWozbDVuUVBrejhwN3g3QmZ0MCtPSjlqMjVid1IrbHRF?=
 =?utf-8?B?VUpaM0dPTGh4Qlc1R3hrOVNuTWU5ejZIbU9ocnZ0RzlidnpoR28zSmJpbGRu?=
 =?utf-8?B?eVhRaHRxVkhxU3luTnBOTEwwYkl0TVdjSWh6NFFEcEUyWWFFelpBd05LYkE2?=
 =?utf-8?B?Y2w3aXZ4VENWenNZM3FpYmc3bXZCTFA5THo4TTE4RUJXcVg1dFNudVVldXJa?=
 =?utf-8?B?YVNXMnltbWh3WTZkN1IyRzFPRTVTdGNTaHBsZlVvWUU5U1FiOGFmME4yNC9G?=
 =?utf-8?B?bmxTdm42YXk2UHM2cnljRmdsZTFJWUltVWhvRWtRL1JlZlhYWFprQnNLNTVC?=
 =?utf-8?B?YUFVcnB6Sk5HYjBWM1Z6Z1U2dHJ0djR5RkdwRW85ME93VlJKMm1JbVdMOWk5?=
 =?utf-8?B?Q3pBTzdOZmttSXdUYUlwc0ZTN3o5cFRSTTJ1UzVaMEpxdzVkRXozL01RWGlj?=
 =?utf-8?B?a0ZzQTVuQnFqV1FKSEx2SWxnUkx4QWRiUEQycm9Va2p5VTFKWUJ6dlIySTV3?=
 =?utf-8?B?QVJnYmtORkhRWlVSclplTHBlNTNHNDI1d3d0VmUvMFhpWFhFZzN0eklIRElx?=
 =?utf-8?B?NStyTCtBcitPdWpEdXUxOTZoazdYLzBYT05XWVU1UDRaZnVPSmxQMnV2MjNy?=
 =?utf-8?B?Mm5NUmRlTlk3RXF0TFRrRjVvWlJCdXdzNC9qUC9tMkUzUm5WTGFhM1BQZjRS?=
 =?utf-8?B?YnhLL3BaRkh0Z3MwaC9QOVF3MnJGTksrZFp1ZUtCU01PQ1I0SlQ5SnJPdHBK?=
 =?utf-8?B?MXExb3RZMlBvaXNnM1FaU3hXY2FQOXFWNnQ0bUxCL0kyYWhDUFFwVnltcHhw?=
 =?utf-8?B?QnNqZGNqR0UzVXR6R0EwdWowOXQvdlc4TVNuM3VUek1iVmZSRmxzdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	o2QLCtHz2AoDZIc79/otGdTf5L7ROJ+ghIS8ef/IH5JCCVMnEAvGQ+OX7YttNTcLdDnv94xjur9kAaGYQU1hHElP+3iOk22YDSUv7dGg/foCMB50wQLz1QaYyNiFUzDd80q1vOGZxzlBZkY2jSWm+ZJ9gGH7LgHl/O1yv/wAC0MBx11DtoCOcxFTx8kfoOLerejE4P/LmauuxtLFj+HJ0OBC6PjsvtWdMTAnS8WOtWuM79VlcSCaGY5B4+S7uEc1JrmqaeiNrgK26eAwzZFti8Bmnm1qH7M/zqvXWL49hDmefa0alETh9moX9WNIYL0GxbQXZYezQjgqx7sk1Df4dg==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA5PR03MB8377.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2442426b-f18d-4e12-9cde-08deb109df1a
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2026 16:08:28.8546
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I92Bm9f9O2HGrcF24KekdEeOVApjDag+eU5YjVUamkWiy0XOhGlN6YsmHC1KE4fpWgpyn6wHfTZhF2tmEGx/zw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR03MB7419
X-Proofpoint-GUID: rsEiEAYMmh6R29RMZk9wiccxfdkR6RUn
X-Proofpoint-ORIG-GUID: rsEiEAYMmh6R29RMZk9wiccxfdkR6RUn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEzMDE2NCBTYWx0ZWRfX78cShLUegfgv
 RQDomR9KOzrS31YBK0jmL9yuZlFXx3pMRiYIyNJkY7LAKAmf0rW343CRIr9xXcYhYrV7XCa+Ukh
 n3UemweqO6nU2Zcf3VfGIUhgiMUqa9fZTgyxBvmd7pvP0dHr34isVnhni9I8DQPY5/fqp/z/lYq
 8GBbsqqR56aypDJHBgtmAOswuxdT3xH5lHp2NBzY54TMMDiUt+ip5kSQNufVT/h1F20w8Sx4bt3
 JGu+XG41iLfyF8sBZcxt5OpWOwmR/usbLklEPpQIOyBTMWCcKXSqAT2fJXrkTOgsor8C8gYAlLv
 L56UG2CK+P95VY6NnzDd6aHiz23fuPRbRAdZpMWNmm9QtcpmfHtwyXW/oWl9+NXcVbidbtqmx3B
 3c3EEYeIPPYNh4l4td3+itZ1igZJ2P35iHYsgYdAiC6D8j/D3xbgqZ0y72xTg6T/hFHTyCL9Kv5
 fdM+5qvYAOLhuvCt1GQ==
X-Authority-Analysis: v=2.4 cv=T8G8ifKQ c=1 sm=1 tr=0 ts=6a04a200 cx=c_pps
 a=cMwMxZTj1NM3F6QoWJDe6Q==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=ZQxX5BWu6Z8IJBb2zLX7:22 a=QwMgCwS0PDCoJfnoxp0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-13_01,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 bulkscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605130164

T24gVHVlLCAxMiBNYXkgMjAyNiwgSm9uYXRoYW4gQ2FtZXJvbiB3cm90ZToNCj4gPiA+IEknbSBw
ZXJoYXBzIG1pc3Npbmcgc29tZXRoaW5nIC0gYXMgZmFyIGFzIEkgdW5kZXJzdGFuZCBpdCB0aGVy
ZSBpcyBubw0KPiA+ID4gbWVhbmluZ2Z1bCBjb25uZWN0aW9uIHRvIHJlc2lzdGFuY2UgaW4gd2hh
dCBpcyBiZWluZyBtZWFzdXJlZC4NCj4gPiA+IEkgdGhpbmsgd2hhdCB5b3UgYXJlIHByb3Bvc2lu
ZyBpcyBzaW1pbGFyIHRvIG1lYXN1cmluZyBjdXJyZW50IHZpYSB2b2x0YWdlDQo+ID4gPiBkcm9w
IG92ZXIgYSBzZW5zZSByZXNpc3Rvci4gV2UgZG9uJ3QgcHJlc2VudCB0aGF0IGFzIG1vZGlmaWVk
IHZvbHRhZ2UsIHdlDQo+ID4gPiBwcmVzZW50IGl0IGFzIGN1cnJlbnQuDQo+ID4gPg0KPiA+ID4g
SGVyZSB0aGUgdGhpbmcgYmVpbmcgbWVhc3VyZWQgaXMgY292ZXJhZ2UgcmF0aGVyIHRoYW4gcmVz
aXN0YW5jZQ0KPiA+ID4gc28ga2VlcGluZyByZXNpc3RhbmNlIGluIHRoZXJlIGlzIGNvbmZ1c2lu
ZyBmb3IgdGhlIHVzZXIuDQo+ID4gPg0KPiA+ID4gSWYgd2Ugd2FudGVkIGEgdHlwZSB0byBtb2Rp
ZnkgdGhlbiB3ZSBjb3VsZCBkbyB0aGlzIGFzIGEgbW9kaWZpZWQgYXJlYQ0KPiA+ID4gbWVhc3Vy
ZW1lbnQuIENoYW5uZWwgdHlwZSBJSU9fQVJFQSAod2hpY2ggaXMgbmV3KSBhbmQgbW9kaWZpZXIg
DQo+ID4gPiBJSU9fTU9EX1JBVElPIChhbHNvIG5ldykuDQo+ID4NCj4gPiBPbiB0aGUgaW1wbGVt
ZW50YXRpb246IHlvdSBvcmlnaW5hbGx5IHN1Z2dlc3RlZCBJSU9fQ09WRVJBR0VfUEVSQ0VOVCwN
Cj4gPiB3aGljaCB3b3VsZCBnaXZlIGluX2NvdmVyYWdlcGVyY2VudDBfcmF3IGluIHN5c2ZzLiBU
aGUgSUlPX0FSRUEgKw0KPiA+IElJT19NT0RfUkFUSU8gYWx0ZXJuYXRpdmUgd291bGQgZ2l2ZSBp
bl9hcmVhMF9yYXRpb19yYXcsIHdoaWNoIGlzDQo+ID4gbW9yZSBnZW5lcmljIGJ1dCBsZXNzIGlt
bWVkaWF0ZWx5IG9idmlvdXMgZm9yIGEgbGVhayBkZXRlY3Rvci4gRG8geW91DQo+ID4gaGF2ZSBh
IHByZWZlcmVuY2UgYmV0d2VlbiB0aGUgdHdvPw0KPiANCj4gSSB3b25kZXIgd2hhdCBvdGhlciBy
ZWFzb25hYmxlIGFyZWEgc2Vuc29ycyB3ZSdsbCBnZXQgaW4gZnV0dXJlPw0KPiBNYXliZSBtb3Jl
IHNwZWNpZmljIGlzIGJldHRlciBoZXJlIC0gbGlrZSBodW1pZGl0eXJlbGF0aXZlICh3ZSd2ZSBu
ZXZlciBoYWQNCj4gYW4gYWJzb2x1dGUgaHVtaWRpdHkgc2Vuc29yIGJlY2F1c2UgdGhleSBhcmUg
cmVhbGx5IGhhcmQgdG8gYnVpbGQhKQ0KDQpJIGFncmVlLiBUaGFua3MgZm9yIHRoZSBpbnB1dC4g
V2lsbCBnbyB3aXRoIElJT19DT1ZFUkFHRV9QRVJDRU5UIGluIHYyIHRoZW4uDQoNClRoYW5rcywN
Ckxpdml1DQo=
