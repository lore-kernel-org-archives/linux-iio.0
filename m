Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.135.77
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792497240;
	b=gclRso/gy5G47gvctIlT3hvteU2PbtXpk8COm+AHeT76phFGX3mixaEfcYzBSTwp0v4q
	 +mUwnQJ9PfpshaH243UMA6q0AtZTijnf6HsmsnF4duXHDFXwW6VyGyqEK49cc9Gs5iiq6
	 w6WR4muXzl/UgonrTDlqyl+c0HzJZsrZo5o6fn/xCQmAGa8N2RVBnhLTve2sN7LeknKQY
	 XLy4f1sdT+3kjxcLPoUzEfu+WicSfRE7TiG+fOQdCHHt4ar+MSenZpR1zpzBmvWPxRFlf
	 d8I1DcwNzsjL7YxxeWQ9wLAjKMWzkr+S2DoY0o+16ULdWyIJS3gtusbXhzev+mgm12w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792497240;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:Received:From:To:CC:Subject:Thread-Topic:Thread-Index:Date:
	 Message-ID:References:In-Reply-To:Accept-Language:Content-Language:
	 X-MS-Has-Attach:X-MS-TNEF-Correlator:x-ms-publictraffictype:
	 x-ms-traffictypediagnostic:x-ms-office365-filtering-correlation-id:
	 x-ld-processed:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:
	 X-Exchange-RoutingPolicyChecked:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=HKwjRnityWAdzAqOBw0iShDYv3EG4dT2ZhAGYC/4CN8=;
	b=mhfXKpRgka/KmoWfwFPAk3ysjaFlwX8yhEO0nGK0fI5O3UlC0HvQKZp8+u046VmqKDPL
	 kcNcxMsSM4dloFhBzNMSzS8zy1x+reXm/e9mAwXHP0bF6LhneR+EuNcpKKuAEDRQo5riu
	 ilw5NoCPI1W4SjL37ROaLFdgZ6LHwHneNbXDd6KRqTrCh0saJeHoYFf5g4MLlV7nFO+cx
	 w3C3oz4yQTfVNm690VZQV+q0TbOV5/IOdO3Lemhy+RwAq4DAkpMnioim932evFVhayszo
	 /VsOIIzYDP2ya++fXMr90h7Xh26c/xZTTyIQPPkHcS35uSmsaY+EKVivuo7V0aWQ/dg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b="QLhgypy/";
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=dlq2Jc6S;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.135.77
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E508606A31C;
	Tue, 20 Oct 2026 11:54:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4E508606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=QLhgypy/;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=dlq2Jc6S
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69KAF8fw2341370;
	Tue, 20 Oct 2026 07:53:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=HKwjRnityWAdzAqOBw0iShDYv3EG4dT2ZhAGYC/4CN8=; b=QLhgypy
	/kYr59+wtebk3js+19BF6AuL4q/lvHUoX8L9gsFGUDbotjaY+6fV0HCSnlzenj3r
	jarMp4dDmwA71iJD/FBWCXtP5vmsWO+FF2RKRqH4UcDZevJMN2NH4WWahSjCLUZ4
	8f9jgQkk80+vu64isgKym6gIusmk5jSU2Gb1gLrhJGwo8+xNWJyc3ao7DG8hh/DV
	jpNVSDi96d6uud1xU7oCmD5qi7NQGJ2pMP6D0hgH2p+v6KOBs5KBqlcu2B3ljdMP
	Z3K2Epe+DYSgr5OYhktHzLZtt3BnJKlqXbE9ZxoZrJ5Jm3T6IfRe6ekQAnuv2D42
	HPD2voynsRMDmSg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=HKwjR
	nityWAdzAqOBw0iShDYv3EG4dT2ZhAGYC/4CN8=; b=dlq2Jc6SPl0Zf8z1IUAqD
	R+bmjQ8oZnlZKOacx/41f4Abut8f7byDMPrwWZiRSQRHAHWGfjYPE7K8e+7Cz6XS
	JIy7w+IPvx9Owu7ErPqXPzYh9rs0Rd4IfBVazA462OzbFEU53wkSFoWCKgqywNYy
	u78Cz+VSoWG796GLV247JhWDJQvjYWlospIL4amFjkZR888y4mTSGRrtai1HDYJg
	zPd/C5Q0pJHiQhzvAhbtdYyurG3Pp/YbYZijdDpmp53x/z2Ah1x1rV6TLQ7rR41K
	Js0HNHxJB5yiBAnekTXzsyUFugAegfmMAU0QhzApqW4MNleCGVHoVTWdp2T+0M5D
	g==
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013047.outbound.protection.outlook.com [40.93.196.47])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4hdw68ua93-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 20 Oct 2026 07:53:55 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jof9acb4YN0vLFz9AGRXwbJEhZMt1DKuhAFndJ1D39tF42KwWNrjMW7aRBmGCUIlklrfqeHqf3k76yRqTU1OLTTTauChk+UB5TCoVLY6qBvgIKioSRnDS+1LrwrNzTYx68gEbxprxqw+RylO/pdPDg7exjShbvuarMN/7oMqXgs1Dl/G6Wo7s0K6rU7ztcdwvZkAIqoa6ED9i6dqrbVQbj9lpgeNB8wzUI1C8vg+wb2skMBNhiyNPnMyyR2N6saye7l/7iooWN1JEexFMScCTdiDbez6wi56VjXMztq6jHFDUS56AjScOY+bXKzLe1EXwv8J8vs41MeiQmt6m+VCyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HKwjRnityWAdzAqOBw0iShDYv3EG4dT2ZhAGYC/4CN8=;
 b=hUBQ/6BUdyMPJ8n8LbkYRRJVs4xpqw/lb9kqxJ4SbaK9nQUFp97qVeZBg5CnSXoKmtcYXSXU1ZVTLaDaN/F/rth1Ng7Wod5nfnutczl0iud7CNREduV8AmLfFW7e2G40zZhRIMftGYIzEYdk8jOMnCgUAOdkzjhzByb7rlY0K1p6GRIou+EM3RzP+iSHezalJ9p/KO+QRhaS6LpMP+QBXuXXuO+v5SZW64POrwNI14cuh9FVfl5xdI/9ttCNOjUdISG/jyWqZ21c6G1oBOeVwTY25YcC+FQXkE6rAVp5D5NEwZyDzh2LNr836F2pDiohE4WfBv5XlDwHjIN8r8gutg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from DS2PR03MB8418.namprd03.prod.outlook.com (2603:10b6:8:32c::19)
 by DS7PR03MB8268.namprd03.prod.outlook.com (2603:10b6:8:258::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Tue, 20 Oct
 2026 11:53:53 +0000
Received: from DS2PR03MB8418.namprd03.prod.outlook.com
 ([fe80::4669:571:4347:1b1b]) by DS2PR03MB8418.namprd03.prod.outlook.com
 ([fe80::4669:571:4347:1b1b%6]) with mapi id 15.21.0546.012; Tue, 20 Oct 2026
 11:53:53 +0000
From: "Tsao, Bruce" <bruce.tsao@analog.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
CC: Jonathan Cameron <jic23@kernel.org>,
        "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        "Sa,
 Nuno" <Nuno.Sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "Tsao, Bruce" <Bruce.Tsao@analog.com>
Subject: RE: [PATCH 0/2] iio: dac: add support for AD5413
Thread-Topic: [PATCH 0/2] iio: dac: add support for AD5413
Thread-Index: AQHdXaP8M+1ukguSuk6GgnmGOadjObcEkV4AgAG4jzA=
Date: Tue, 20 Oct 2026 11:53:53 +0000
Message-ID:
 <DS2PR03MB84188FD41F8847EEB34759D9FB672@DS2PR03MB8418.namprd03.prod.outlook.com>
References: <20261017-ad5413-upstream-v1-0-61f40c8fef25@analog.com>
 <atXY4kLEXxmG-tnk@ashevche-desk.local>
In-Reply-To: <atXY4kLEXxmG-tnk@ashevche-desk.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS2PR03MB8418:EE_|DS7PR03MB8268:EE_
x-ms-office365-filtering-correlation-id: 7f099a2c-695b-4c9e-d471-08df2ea0d051
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|23010399003|38070700021|56012099006|11063799006|4143699003|261009223027099003|10067099003|18002099003|22082099003|6133799003|3023799007;
x-microsoft-antispam-message-info:
 sWZ6DY8ikCfkFqIJJ+J9PKA1nhroAbiTwkqCq47IKJDFFED1tDxlsGuj4OX4OVVw5rsIyMNMQCkPndH1Ef/w/wRMaYHRKIMRGQKFw/ywT3wXgytMTLUg8oZvTeoKSplc3WmDkQvWCsuCysWjk5i4aotKLcS8SE9rSLy4HdWzNk23MFhfLoUp/Hmv6gqNnMKGZzmpoGfOS7w+9ZkUzAgJAnfSvDX6W4/7s3ZpAjW+Y2IcUdEztQ31WmYe9kceWTSXUXR+10/jbb53d8btrm6Qmi6FhfzHlFcgOnqfpWvyB9aXep8hifsW8YokoY0qAfspr+czOnBVwL2iZktHdCXPcpr4M8V8P7mGFcD8Lrpbh18TZrZFdvKoy4mcFeytbEJELsiPLe51nwjNJn1LW1IdOyWzEHEn60be8mrVupTlwbfTUzrM2W3KwAlkgVEIBaD9Ea9M+Vrqb5b8BaZKjKOZQ5Ez+iuuhD6d2HyCt5GTx4UlIuIj/3HzCHyWPeNEI6MXGKbvPkhGY3OYnq784FOxvhXLb7O5zH8W0UQe3OKfQupK1/O1XRKJW32lJlXcJJggn6W2XfOIZPZ/K1yllipjfYeJS80SnsNDhtMajPzclEpLOrXVfL1rbF7ediXu/CB0ON9S4SnZWnjKrHyg7tFTmqNbyRUeStcIJjlsV4CzPzEv8HQsLXgjfzkKsw3cVHWUdv6ZlcgAcUATFgncUyR+6T5mMOusxWSIj5uArGljpsk=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS2PR03MB8418.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(23010399003)(38070700021)(56012099006)(11063799006)(4143699003)(261009223027099003)(10067099003)(18002099003)(22082099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?YSEtYi60G+7V8Dg1L6CTOzULDrKbQAq++IaU2Mo4pSOYwB0fuKKRv58EJGaV?=
 =?us-ascii?Q?f8BfFiIWR7beVkQtd7PTHwvcRi3F53/BNzbbEnjfcGSyby5B3tir2bTHB6Ip?=
 =?us-ascii?Q?kq2aVMF/r5h085DMZ1jHWHp+tkc25M+Yusc2ZJ6iPG6zEblBXeskzi5qHJg5?=
 =?us-ascii?Q?11ZiDwSXHXq8+sxUVK+EUTT9IIbekyDaiMM55mGc1xDG5mklgoN7BIAV5DqE?=
 =?us-ascii?Q?/sNN9XXUPj5CuT7WBcZve/OQZUeEW02oNbLZakv7e0swFXLJCmDE9RL8a6GQ?=
 =?us-ascii?Q?bfONcZxq12WbIykuelO/4MDF1MDS4zHcgiL4KabYcq86jNV1oXRNfLkHkaAo?=
 =?us-ascii?Q?h4aCCj/HUxwT66eTfMNmTD7iGKXBtACj1uuxXHIA7lFmI+EF80NMjeG/MtZE?=
 =?us-ascii?Q?msigTe7clKeejidaIRDLCcYO5JBAokiPTDs/Yr15Zr+LvlTgteLH1gkKATgc?=
 =?us-ascii?Q?QbW5dmgtIJGD272ySiXfM2gcM+1cVe8sdohiLCkXitctvl1om2BY4YnHsYn5?=
 =?us-ascii?Q?CEiJfvone8fCxKIXaEaAh+bak0Kz1NnV7v+rUMg0ME6Yqmu6ZOpimI5v6rDO?=
 =?us-ascii?Q?vzJOLD0OSNuzIVEPRVCnDwx5T++r5Uv0R0Cfc09XhUDc/HaI3MqVvLXa851k?=
 =?us-ascii?Q?VlY0sCWY0HvJS9Ztv1S6VeaJPSXZAfBPl//vdvf4gOHlS1SSHjg+IzbbsSiM?=
 =?us-ascii?Q?9efWEeAD/IgNVwarXPcuDzHeVf+4QZ+2Jzmizi3eqgQ2HFLLMitURvMWtMi1?=
 =?us-ascii?Q?2AgB9e84Ow4DUzIlKsrju7BF6ehHnR9wbFNAR1HXeiqEJE0tjiET+TB1nc5r?=
 =?us-ascii?Q?6DRGYcoPErdZXCZZT/6zEIbfbsBX8ZI4PgPnBeGO+GY4wYbCG8tvUKuwW3gf?=
 =?us-ascii?Q?tizfX0v6fpv1zu0yxpM5VdnoARu7KbRPLpdMEt4DcZZrqc3MiMRVLks6UzGM?=
 =?us-ascii?Q?QfzB1LjWCa+t21XooRbscOgpisyt4OsnKxi0e0Xrs7kY/4UMffB6yCOfoYq2?=
 =?us-ascii?Q?sF0otavPpdIIuqJ8WEbnQHCdNWc9VeUbkJ9/RMEB4iL/dUYuSg9mKIWT65Aw?=
 =?us-ascii?Q?nm957G8KKLjQUZV/1A9b0OYzuJP/pn0DeMTbzBBFKwjGnBCIrnTwxY2Hg9By?=
 =?us-ascii?Q?di9oHspwEVPzTLrjBzGC6gA6UoVoG/fUMEiOXDKILTi0P+dv6HjXjBZ9HT/v?=
 =?us-ascii?Q?EzOOkEufYU9xRuZvU1qgc3QsLyExP9/ZDW8J7R9acPMglsV8NoNJ0NX9g9wf?=
 =?us-ascii?Q?rLiGcDeAAKQ2suazUzD++bsHro8hNcXjF2IxE4X9g6RFrfTjMimbqMDsuYZz?=
 =?us-ascii?Q?n7MsJm4QrgZCg9YtfVpMoG3XH+NulY1tqW8dG/dXG9oekT0nXBp3qaUuwykM?=
 =?us-ascii?Q?6O5+uLC3TAsI1aRacjiC/3hncmb1qNbMyclo3XT4dAukaI7RSSod40sdMK50?=
 =?us-ascii?Q?4LyIb78R8ZsstcsmCjSd21BsmdcqFOZEeBBgnpiSIkoCfcTmYKYu7/3I5BCj?=
 =?us-ascii?Q?zIUXGdz0U8i76OzaMv9/IzNqgz2GkAJpkPyDDkRkL5Um2oXAS10WNVdDuMKM?=
 =?us-ascii?Q?4r6GBppTUZ/YQCDuGjuMSJbL18uV22Q6k2sXT2cFbtCpN0dxcFcvEXvKpEBS?=
 =?us-ascii?Q?NLRzyJ1O7lv16jXW7hwVh8z/dYRSmlDc9NjnV3PMrgxNHPs3D1/zy7x0XvOT?=
 =?us-ascii?Q?jwQhx8m2aCd6lwmhj6U9ZAbBUsu9qLwAUCwQ2RrNAG7joz3vCnayXdoPzJ//?=
 =?us-ascii?Q?OnY0JofJZg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	xqmaZybgK6K1/IPjxM90GuOd34+zwT3sWEPijX8Yu1zCGkQqasx3qKzGStSVq76caqyz69IIy7iYpzicSEcRYnI9vLB8yiSPDPoA2kSarCuq6/TWnjRBKLjLAXz+JOI5NJIn0kZ+os3RSB7AZCL92gMK5W6wxHlb9sKnwoE8A2AmAKMLOQBpC1BW9A+dd9eq/RiHOjQjzH+WHqR5fRck9lyfk2c7bRNSMGNj3+6w/FZU8bgeSIjapSWjPqN4YqveFKb1eRcpj9HuqTn5CQlAKlGj7v6eVQa8CWlhKoxAOlwm8eMTFb3tH8u7Hq4T4klDRYi2mlNEGBJ+LvmvEqcFMw==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS2PR03MB8418.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f099a2c-695b-4c9e-d471-08df2ea0d051
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2026 11:53:53.4172
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BuEJBEI3W6oWSjAfZb8+UZg9aWgtUWyJcPYWHE8noZCgeYH7U2xKIwQdoCmoCA650YUGflNL4GasnKc/ktSwnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR03MB8268
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIwMDA0NyBTYWx0ZWRfX5KXidmQs/zsI
 4TZVa+IZOtDyqxDR2/t4y47EtKQIPmtyPQpp4VIBcPmOCaI5yqbqVP1NSA+Tqcb+ynFtEj/FLXg
 2lr3onLG6R/YwqBPTrA3aDYk2FK8lxZw3t1Txc+2gK9A95rPdDvB
X-Authority-Analysis: v=2.4 cv=aJ9lOr9m c=1 sm=1 tr=0 ts=6ad75654 cx=c_pps
 a=AE2032bzocsdReLOztW59A==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=N--XFCr6TIEc_64PeIT2:22 a=fKl9o0UsCw6Qo2hU2eQA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: Lfyiyl0EOIS9R2ODJywSB4qXDcTkSdTT
X-Proofpoint-GUID: Lfyiyl0EOIS9R2ODJywSB4qXDcTkSdTT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIwMDA0NyBTYWx0ZWRfX4d1+LEIGSXMv
 89NpfISrN1nxGB2CfYqlZovLShqQlK7WdISjAabBLDzV41eKMIpGwT+Ew5NSgWwc34f4WYfDDgw
 wyWrmQd7m9j1a/NlZ6NXwcESMTOk/NtlM9ifrrwHcTKrkEkDEhc1gUsMpxehx2uuwGbxiu4wx1q
 x+ZY3olDr4T8n/wKWVDTKRMvB8+GcAb9iwBYQEAmdALgJziVO1HXWjtR7u5HA1SyjYn4tlOTKlX
 9Sj0wfIxm/xxCImUygH0XGy8VxTj3jwxDMvVT5LIvR8+KJAHj75MeCLmIIFns4aGRcwKt7+4mPp
 87GYrEC1aI/M94+mXcp7mSaRfiKGibbojBYL1f1pMOd5TQj/lLbcZKJmrCjLMt+AUPl9ZYNM3R5
 7Qa2UramP4vEtwLBgHzWpvTZWvr6ZmdCJtviH4zzedSwQkdlL1cJF0hEiLLSQeh1I6lKc7o+V8L
 W1eU9WykBC4Prahx4Og==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_01,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 suspectscore=0 spamscore=0 impostorscore=0
 lowpriorityscore=0 clxscore=1011 bulkscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610200047

On Mon, Oct 19, 2026 at 11:46:26AM +0300, Andy Shevchenko wrote:
> Why in a brand new driver?

Thanks for taking a look.

The nearest existing driver is ad5758, and the two parts are closely
related at the register level (the DAC_CONFIG RANGE field, DIGITAL_DIAG,
the slew-rate block, the reset and calibration-refresh keys), so an
ad5758 variant is certainly feasible -- that was the first option I
considered.

The differences are a mix of hardware and current implementation:

- Hardware: the AD5758 integrates a DC-DC converter (adi,dc-dc-mode is
  mandatory in its DT parse and currently drives channel selection) that
  the AD5413 does not have; the AD5413 is also 14-bit rather than 16-bit
  and supports a different set of ranges.

- Current implementation: ad5758 disables the SPI CRC at probe, whereas
  the AD5413 driver keeps it on and computes a CRC-8 per outgoing frame
  (CRC is optional on the AD5413 too); the two also use different reset
  APIs.

None of this makes a shared driver impossible -- there's a genuine
common layer (two-stage readback, read-modify-write, the
reset/calibration/slew/output-enable sequences). I went with a
self-contained driver mainly to keep the change off existing ad5758
users and keep the blast radius small, at the cost of some duplication.
That's a tradeoff rather than a hard line, so if you or Jonathan would
prefer AD5413 as an ad5758 variant, I'm happy to prototype it; I'd just
like to agree the direction before spinning a v2.

Thanks,
Bruce
