Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.139.77
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794213192;
	b=jvTlt/rBmaBd6wgr7qG0lxEqBdMqUQ/JiprK3I8SBQDSrqgfo07KPCEsQO6XSh+n5Jzf
	 iWa2yafhQJiAcP8gmgYOsG7wiD3yX8Hcv63ZkLWXvfxAUj6qbCFBBjZ29kIvCuC0QvCTe
	 SHqcXUUpkRFFkp9bVahsL+R4h+KVO4cLIQyx2zcEOcrs6Zm3acEj68uWRuzvUPVkz9q4L
	 WPAJXk2qORv85GgrNEgzrqbkJ7x5ywJRPFSNWKndtAliKIy/HgHuEN8y/zo64W4hus1YO
	 lsywr0dLzwOMUjxtgdzqOBt2Id9iJ9q2Pjty1zaq4EHX2m2+igV7rLaT4c6gC1rMsrA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794213192;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:Received:From:To:CC:Subject:Thread-Topic:Thread-Index:Date:
	 Message-ID:References:In-Reply-To:Accept-Language:Content-Language:
	 X-MS-Has-Attach:X-MS-TNEF-Correlator:x-ms-publictraffictype:
	 x-ms-traffictypediagnostic:x-ms-office365-filtering-correlation-id:
	 x-ld-processed:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:
	 x-ms-exchange-antispam-messagedata-1:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:
	 X-Exchange-RoutingPolicyChecked:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=V3XxVT4mCFWKJDpe/zdH1wk4zNxbGEKgf0N2tYVIdF4=;
	b=F6DMOtqWoImmeE0LMXVOq+3SQzOt+5LoF/9EtQVdjIhwW5Wl+B2AxBuPORpO0Kuax1yz
	 UiBzxpwHg7oB+FTXwMvRxSrTTeX4vvR+Q+28EIUVfTjUeFGZSMnkOjL02JooBtOma58z2
	 3VHKuYGlZ7BvmWEodgjj12HAffqBTbcZK9AtmBXJUOZFjyg2/0ciRvODogm91D1SxUwuV
	 eYgrU0CMYhAs8N6eFX/bit3oaWGCZehZaKwMHfW9NCyJsrM4fVVv1hI3NqlOziCHFHC1c
	 lmW5rrV5mfPxCNyX/1xJlbG3URUKZ78HmK46XRN8vsO2kzGCextAldFSiNNN38EBPqw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b="Ziln6/Uw";
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=k4gvEbz0;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.139.77
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 803CF606D824;
	Mon,  9 Nov 2026 08:33:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 803CF606D824
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=Ziln6/Uw;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=k4gvEbz0
Received: from pps.filterd (m0516786.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A96BOD02481642;
	Mon, 9 Nov 2026 03:32:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=V3XxVT4mCFWKJDpe/zdH1wk4zNxbGEKgf0N2tYVIdF4=; b=Ziln6/U
	wKTKYuE6HaYzeCGAbdd9j83Qd5KGRF1wKZi93TVsuuVIG2fzuIASsbJ6Rk1n69MA
	lE9BkoJVEdmLwCIfRVtR07Jcs0Rw8RbTnNGE0nF9AIs/t9E5GxWCWsH368l3rfkm
	cBPzfadRaVIIrk5CtGFo9lwygbH9EiF+LAxOzG0S/ZqblbPBmqfkRJ9xgQiVn6io
	IY/a7fRp/QgRIKuz3HidKecAhZ56NsyXm5J5/wBpY7MZGdXolIojzWzHgrs/GXtc
	aCuV5SwwcPA5ijqJ2B6yGzjZCXKAWmoKUaxRHNWEeJh4OZBZwrTk4P7vwAE3Nani
	cwJPqjBnnHFS97w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=V3XxV
	T4mCFWKJDpe/zdH1wk4zNxbGEKgf0N2tYVIdF4=; b=k4gvEbz0inijc1nKw+GOv
	LYzwpAuLSpiDcFT/FsAXFCCU6B+tWdlayMqfx34uDmROWopUcZt9n4Pl9lf8X2tY
	mF0ygq81UnF53xwv7Iy5GR1Bw+OXppYzMDRxIeBjyLLDoPvXpLt9PqDzKU/nSz89
	TiDZjk117J4u/EhudVdqEgrdsCeWGKxAm22h4brqZKqTnNWzjTWrYdlG8nzzp33A
	jiRqyhHdtOu3weqqmbnvqZsY0E+SBbWZGiEM0HHrX/ne/C9LmsgzcA149iGAT0rP
	v/2Ul3RZipFmpoSnx/0yEcBix5OHTnGHnsm0mBZ5l8M3OHZ1KbH29LTC4xVaEmjC
	w==
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010028.outbound.protection.outlook.com [52.101.85.28])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4htnfmmxbu-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 09 Nov 2026 03:32:52 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=boEpsUEZlKE7obnMsErOgm8CR++n2KY/+3v40rO9S2liFn9B3uniIcHZ0aNAWvDrKWiu+rPrNUUoiSG0E4cHkbNMC7XL+2JWC20kmB4ILPqPR0iKMhkqzdWj5BpQ2J+LnkkENEVlil1UBvsDqqnImfKnQutlNLORvbUgefImRT0VoiI4VJSp+0Fa3CrbSTuLf9xYrvIXNnredjI743FSc2qVLRajRnefgbUd+IuSSmYPWDepRxwrz5BZi0BUPlFbUMP2WXmIMvahK7g7wbJvOiX6kTtBRSO9PIjYe+sk+FwDv1nuG9l32/YXOZWJcnbfyipvAgaCKztAZwb11EPDMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V3XxVT4mCFWKJDpe/zdH1wk4zNxbGEKgf0N2tYVIdF4=;
 b=nEKi1UGkVdRsCjp9rpSVWDC1/4GnL9jUaA3OWGVs6SVPUmfW+cd8t9Iz7iRtzvYltljNzADo76+QCGftpAV9DYU67fR/bbchlmMYCyl2i1xLMgHNuQnu+VukU5XnGTWFyBfrA+OQjOp9pIy/c3sbrcj9x61Flj4Krw6Qsybgfn1OoRF4DdtYo1QXTSpc1RBP0vOnMx+4vSrrDsoBpEL3YmNJC2gTIFyBuJr37lDfKXroDr5pZ5AN+qbRNxIajxNX6eEvZJ0zo1oOmRwDhadEdJk/DFE+U4P+uKom1bW5rNjJKy04HTw03UcpHbju7R7T9GRSuRH84tZ1Ir5+M1Ltag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from SA5PR03MB8425.namprd03.prod.outlook.com (2603:10b6:806:47b::8)
 by SA3PR03MB8327.namprd03.prod.outlook.com (2603:10b6:806:462::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Mon, 9 Nov
 2026 08:32:50 +0000
Received: from SA5PR03MB8425.namprd03.prod.outlook.com
 ([fe80::ad3e:e026:f2fa:bf5f]) by SA5PR03MB8425.namprd03.prod.outlook.com
 ([fe80::ad3e:e026:f2fa:bf5f%3]) with mapi id 15.21.0592.010; Mon, 9 Nov 2026
 08:32:50 +0000
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
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        linux
	<linux@analog.com>
Subject: RE: [PATCH v5 6/8] iio: imu: adis16607: Add FIFO-based
 buffered/triggered capture
Thread-Topic: [PATCH v5 6/8] iio: imu: adis16607: Add FIFO-based
 buffered/triggered capture
Thread-Index: AQHdaqwobZM8Xy+3TUGsGHhJAu+T07cjYYGAgAIPzyA=
Date: Mon, 9 Nov 2026 08:32:50 +0000
Message-ID:
 <SA5PR03MB84259F6CAE356BD09F82B3E3F7732@SA5PR03MB8425.namprd03.prod.outlook.com>
References: <20261102-adis16607-v5-0-4f98b0d271ac@analog.com>
	<20261102-adis16607-v5-6-4f98b0d271ac@analog.com>
 <20261108005227.2dcd4697@jic23-hlaptop>
In-Reply-To: <20261108005227.2dcd4697@jic23-hlaptop>
Accept-Language: en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA5PR03MB8425:EE_|SA3PR03MB8327:EE_
x-ms-office365-filtering-correlation-id: 2eccca5f-2e2f-406b-e0b1-08df3e3c0a43
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|10070799003|23010399003|38070700021|11063799006|4143699003|56012099006|261021135927099003|261021130227099003|261021121427099003|261021133027099003|261021123027099003|261022115727099003|261022113327099003|261022075727099003|261022105027099003|261026130827099003|261009223027099003|261026135527099003|261026140227099003|261026121527099003|261028144727099003|261102123227099003|10067099003|18002099003|22082099003|6133799003;
x-microsoft-antispam-message-info:
 00Nk0Hv6CC6PhPfQZg6WNZ7jAVPZkTYSkToJKwnWsC2cFzDT+PQ6rxt2QzOmATTJKOr35ih2LeY1t0f/OAmiU9qR7YzfT9dHSWyLzKOv8EXFJvxk/evUkAmLlIM9quXfGcqnocqvrGOKyu0OCFEBSNfpOvqDlMjdhshbFydL8xhZmmw3w2tf2uI9cHQ81E41onVsLmofx+UYR+uHlWrDaWLM9m6tXpAh7I2CHqqBcqE5acgtMm6vGcbCQaqgG0zNLK19ydYcJzfC3EqGmF48mWb68TfLUbyK1CYR5GwiE3iHQtbQ53k0C6yICVE1BiWlN+hB7Tzxd1bqE1A4jjTmHCpx6b0kGPEHO5lqhBs4Wb93YARkt7GbcC5f0FZT0mWkupBmyuEsW5s7m+3UN1hc6XjurqUxvaTcFrc9p54Dux6K47WW0dDwXtRacesIXqk5lmIW3FB2s2weFQQvX7eOJR2zrm9vHDlJeopxTvQfZxgutZul7JKxda0NzjvGOZmW35WMSnoxh8JHCT5SniBnkxvWfoqyTzMV1xy92j5Qnlzv4yehVTYj7KxE7kRE4X7Ld8ckGwLMuw/rYfO0l2ha+WpnbXLWbZ80d+OR81pJhQNtAuAlAbF7fiY4Z/PX9twkCPuikJ7Fvpf94qxD2nu3y1kwPdQwKqvfchGxPIGM0cw=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA5PR03MB8425.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(10070799003)(23010399003)(38070700021)(11063799006)(4143699003)(56012099006)(261021135927099003)(261021130227099003)(261021121427099003)(261021133027099003)(261021123027099003)(261022115727099003)(261022113327099003)(261022075727099003)(261022105027099003)(261026130827099003)(261009223027099003)(261026135527099003)(261026140227099003)(261026121527099003)(261028144727099003)(261102123227099003)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?YAWUc+pEl+za9tX0sY9aveLAvpQvTd3dX5NGa5BSAm1LXFwtXgJhJ+MX88bE?=
 =?us-ascii?Q?SW3GbDm4AX2ik0PHkqbuhfpmuFxAsou/35bYs/865yjIqNUxz6Csk/q27jad?=
 =?us-ascii?Q?0s1wcFsWCoHxnqn/VNQK4Bqy0nPf9fQuswaPeBSxIkyfBluKOaQapCrMkRIj?=
 =?us-ascii?Q?UfrkSq9BQPovGYesQZ+rMOtD1tR9rGKLQg+8AGAnVRynbnUBNKBzfPbwTBd3?=
 =?us-ascii?Q?JTZg/5z8CdNuuvd7oYKiCTnV85QQu2VBSyEL+J8mhn/1Cfz1CClHigoVYa3e?=
 =?us-ascii?Q?mQYz0D9GjXRNSdOwjxxdoENr/1NyRCmeUOJxEFqPNWwLGY7yUrEFp92fLxKS?=
 =?us-ascii?Q?6mGuA/J4oCbWjKvkvTmOC4D+96qxrb8HlCn6OL1MU+tfpgTZ4a6kArxQbyiU?=
 =?us-ascii?Q?fTIWr2HNscdxEBQohHpRgwy3c8pnNlzOJa4v3Hf396KG9pekB2pC9bAU0Er3?=
 =?us-ascii?Q?/6+vQkTSKHSHmJlhxPv8QSZjBde+rkDV2KktBAoPycKfvuoqKO0pDA/shZEE?=
 =?us-ascii?Q?gGykzXKnVDZh3cUYcgdKburZC+8cCkiyeV6fzlgaSfb2rfDmCu9R/Aiy25tm?=
 =?us-ascii?Q?bpxmj2XhG3wpmSC6AG21JnXsx0m/4YY7i1HCGrmE5zyQPcaUDaeAOSlzUdAn?=
 =?us-ascii?Q?VehCLJctgzbcGCS8BQT4XcVUlaoFtDvWC3zWnka3lsY5w9fX3AGLo5CkoFoi?=
 =?us-ascii?Q?thjS00GO42HgvUzfJPcHRtku+7YGTvySgar1uVCgWsllpBoTiU3LCfirJt1O?=
 =?us-ascii?Q?6tIoTS3maOpPbOzEWTaTYYsrscVXt1pnwmMGWB9LYfXLrPswgeUYnpWAeqbV?=
 =?us-ascii?Q?21VJd5Zk13zGkf64U1Ntxzo4kWxzPjxIFqu0LnK+CNZN3vZ96ONMfQgIPRjp?=
 =?us-ascii?Q?g0LXKNlpJrwzfshuJbBsP/5MH3WZxGqoas1E0KnBzHcaxzAqDPISNltga328?=
 =?us-ascii?Q?ENPEGZECq1Uz7p9l9kyKr3fKPBvd6a8rO9SDnvmjBA04eLwKR1wVPby++Hu7?=
 =?us-ascii?Q?sk37UJ0ELgqPSLl1x64XD6KzSwue6nii7czsajHk5xpu7VWoAo55jAjNlB47?=
 =?us-ascii?Q?Brz+XVNUfKeYf8/xFCyhKAmUZgrrCWpxPHUd2DHnq/vj8IG4khSIjdubH8VS?=
 =?us-ascii?Q?nP8qPT8xQqAYYTqcJ1ct5WQqp41cjPiP8DTnJGobQcPcIXcdtFZ5oKgroJi2?=
 =?us-ascii?Q?2DCvvreq2aBHZ2uw55E+sQkTeKtHkpuHZAUbChAx7f6DgIh16UUTUhpR/Nm8?=
 =?us-ascii?Q?dJoBxTuwS7rf3EC6LbVxTOchDz35ffc8afCiUFelGT+wIfGSsh46SKjFoQZh?=
 =?us-ascii?Q?mSowYblLFAxw8waGgh1o9V15TN7GZkYnNgWgGgGUHciF2a0jp5vFje9t4LkA?=
 =?us-ascii?Q?wXAT9aY0nyFdrl6MN2SRsByIbm0qww8L+3+R7Tfa75NynKFtK8Ge3c1SWnDq?=
 =?us-ascii?Q?Pv0eRlrekZ9FyMMf1/4EfHoUCjcHN6OH6+Bom+f8uOd/3zMQ9E0MgiJRquDF?=
 =?us-ascii?Q?B+b5n2odc17SUgP1P0kGWv6+q4PK9l28enhNNjL1VCyliDygOk4NMDyn9a0h?=
 =?us-ascii?Q?cbmV/++cJzTGoRSX3w8rRqd22k6RXrZ3im2/GSev0WaTdAeyHWot2jWuBOvi?=
 =?us-ascii?Q?hivdomg4yXJWRPGmdTCMP8GVUTuC88rNfjvqw1kXRPH2Jg8/ohpDVTHUwUmz?=
 =?us-ascii?Q?Ay/W5FbK4x7OhQMDmE4H/lw2Uvu7JtGwP38ckK1vvDbltWZsuUDwSVlvRw0c?=
 =?us-ascii?Q?mP7u/T0qxdULN+YSQX8LKCgioR/8DX4bgLQD7QZFgKnrd22glBGv/1oL4oDL?=
x-ms-exchange-antispam-messagedata-1: 9E3sDM3J1J/xfw==
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
	W/AYeqPMvoWbVv2b54MQUJPAKZaFoybelssh0kqKlJmQvsOCc/OaO7ki7xL9P+/uAX7Num0hc1d4hkGKOIfXqzu2EDN2gQh6PH1L8rks31WGfmAuIliseT96msFUkKkHtPLZjl+5U3EveJX3Km8PADZ6LWRJbmt8zhfT2QaMo8i2tbgnzexUwH2Q8igeuw6lozJhau+ezPDYpWBiNJw4n5k0s2SuV+MqWAUG4msbeSNBMDSp29eFM8Ryb3D527ctSHjuJ6Fb989+7nEVvdBDUSdEiytbiPicMGgoh93cAqs/mMcFwUcVqnWjLo94hNQcJ6pXGxhvlYDyR9oRpRFgzQ==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA5PR03MB8425.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2eccca5f-2e2f-406b-e0b1-08df3e3c0a43
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2026 08:32:50.0965
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B4OXjQhsycfFOMBpIbZ7+u9jYc3gtKGhOF4ApI2LnmKRxrBzaHUVIIZmdUnbhsYvlJLQH7j+Ch64ntycOH5Tdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR03MB8327
X-Proofpoint-GUID: 4OSQmWtRN85G4AmCk1E_5TBwZo5SSoEC
X-Authority-Analysis: v=2.4 cv=YOgKWhGx c=1 sm=1 tr=0 ts=6af18534 cx=c_pps
 a=mniIB+Hk/8HPdz+5sH7poA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=ZQxX5BWu6Z8IJBb2zLX7:22 a=uherdBYGAAAA:8 a=c92rfblmAAAA:8 a=P-IC7800AAAA:8
 a=VwQbUJbxAAAA:8 a=gAnH3GRIAAAA:8 a=DYVhjryELUpsOPflbsQA:9 a=CjuIK1q_8ugA:10
 a=GvGzcOZaWPEFPQC_NcjD:22 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDAzMyBTYWx0ZWRfX33YesY6SZXyP
 1GB6Rdpgo+mQe8NZEpo2ZDcNeB1xV1PmjCpPZuxsijVx+kQXV93fL+YEywZQPZy5LSI4+iKq0Hn
 8cfa43KGSBJWODts4dNQbamvv9xBS49hOHhMfIr/1KnIpzUEAHKn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDAzMyBTYWx0ZWRfX61cdSfEMiA9m
 kuVXrAJmtex8pXlAMZ5lIGMcHWUw/Ba1e2B8Dlc07zZpnFao7qalCM/+Iig7RNr0DfnLn62eo4L
 jmcVq0wBYqJjARv2iSwv3mIjFNFEh+bqPxgec2cQvU+nlimjkx8Pv2nK3Z40an3FuHJwQh9pFb2
 x9o2io1szOEhVXfrnD1THpxfZ35saTV4yD02QP4beqyWLTIXkBUWX6nkNPsnE3eoJINVoEffJ3/
 1FSXx5z7lnxld2I7iUlUgR67J+oSQtjIKyvO7/wG+iuIH+BNTL7mFe6ugWVkfFdUNDPAwK41DUw
 iveO3C6Tpc/ONE7KOPNaICJGNGfU6Tt0RGPSI7m1npAnZ0ckExHonmMgX76cgg8MU5P63ns7lKp
 ZyYXsSTuw8njg4bAA0ltIZfcZ4ZqwSHhuPPMjasjA1q0mGq1NFoi+YN6Ru9tvF1WJDErU71ZEkH
 bx9SFJm+OVRQCSnPLKA==
X-Proofpoint-ORIG-GUID: 4OSQmWtRN85G4AmCk1E_5TBwZo5SSoEC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_03,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 impostorscore=0
 phishscore=0 adultscore=0 suspectscore=0 spamscore=0 malwarescore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611090033

> -----Original Message-----
> From: Jonathan Cameron <jic23@kernel.org>
> Sent: Sunday, November 8, 2026 2:52 AM

...

> > Watermark is configurable via the standard hwfifo_set_watermark
> > callback and the usual hwfifo_* sysfs attributes.
> >
> > Signed-off-by: Radu Sabau <radu.sabau@analog.com>
> https://urldefense.com/v3/__https://sashiko.dev/*/patchset/20261102-
> adis16607-v5-0-
> 4f98b0d271ac*40analog.com__;IyU!!A3Ni8CS0y2Y!8C9P7exAoBKoTmce13D
> t5nL3mUvpzcX-kaoE9HgOFqmFiDBX3IxbPETNVz_T_1Zb3mJk7YAfzi7H9g$
> Has some feedback on this and later patches.
>=20
> If you want to increase chance of me pickup up a patch I'd
> suggest watching for any feedback from sashiko and
> commenting on whether and why it is wrong before I get
> to catching up on reviews.  If it is repeatedly saying stuff
> you disagree with add a comment under the --- for the relevant patch.
> If you have looked at it and plan to make changes but haven't
> yet, please save reviewers time by replying to the thread to say
> that.  If you've just had a busy week and not gotten back to this
> then fair enough!
>=20
> Following what sashiko came up with, I'm not sure how the adis
> fifo handling works today.
>=20
> https://urldefense.com/v3/__https://elixir.bootlin.com/linux/v7.3.1/sourc=
e/
> drivers/iio/imu/adis_trigger.c*L90__;Iw!!A3Ni8CS0y2Y!8C9P7exAoBKoTmce1
> 3Dt5nL3mUvpzcX-
> kaoE9HgOFqmFiDBX3IxbPETNVz_T_1Zb3mJk7YCJFlWadw$
>=20
>=20
> 	if (adis->data->has_fifo)
> 		ret =3D devm_request_threaded_irq(&adis->spi->dev, adis->spi-
> >irq,
> 						NULL,
>=20
> 	&iio_trigger_generic_data_rdy_poll,
> 						adis->irq_flag |
> IRQF_ONESHOT,
> 						indio_dev->name,
> 						adis->trig);
>=20
> uses a thread of:
> irqreturn_t iio_trigger_generic_data_rdy_poll(int irq, void *private)
> {
> 	iio_trigger_poll(private);
> 	return IRQ_HANDLED;
> }
>=20
> Which is calling iio_trigger_poll() not valid from a thread which
> should be using iio_trigger_poll_nested()
>=20
> If it were using nested form then the sashiko thing about interrupt
> storm would be fine as handle_nested_irq() calls in the same thread
> so it would wait for the fifo code to run before returning and IRQF_ONESH=
OT
> would be sufficient.
>=20
> Sashiko's final point about ideal being no trigger for a device that only
> does fifo based buffer capture is correct as well.
>=20
>=20
>=20
> Jonathan

Sorry, my earlier replies went to the Sashiko report instead of the patch
threads, my bad.

Agreed on both points: iio_trigger_poll() called from the IRQ thread in the
has_fifo path is wrong (iio_trigger_poll_nested() is the right helper), and
a FIFO-only part is better served by a kfifo buffer than by a trigger.

Since has_fifo is shared with the adis16475 FIFO variants, a proper kfifo
conversion belongs in adislib and needs testing on those parts.

I see three ways forward and would like your preference:

1. Fix the dispatch in this series, kfifo conversion in a following one.
This series gets a fix before the driver patches that moves the has_fifo pa=
th
to iio_trigger_poll_nested(), together with a small adis16475 change to tak=
e
its sample timestamp in the handler, since the nested path no longer runs
the pollfunc top half.  The ADIS16607 driver then keeps using adislib's tri=
gger
path as it is, and this series is complete and working on its own. A later
series then implements the kfifo buffer in adislib, converts the adis16475 =
FIFO
variants and moves the ADIS16607 to it. As that one needs testing on the
other devices, keeping it separate means both series are functional by them=
selves.
This one would mean one extra fix patch before the adis16607 ones so a tota=
l
of 9 patches for this patch series.

2. kfifo in this driver only. The ADIS16607 gets its own kfifo buffer and i=
nterrupt
handling in this series, with no adislib change. A later series adds the kf=
ifo buffer
to adislib, converts the adis16475 and switches the ADIS16607 over to the a=
dislib
code. This one would mean the same number of patches (8)

3. Everything in this series (about 12 patches).

I'm happy with whichever you prefer. I lean towards 2 personally for now, s=
ince
1 implies one extra patch which would see its changes removed/changed by a =
later
series anyway.

You're also right about the comment in probe: DEV_NOK staying asserted does=
n't by
itself imply a level interrupt. It is the OR of the DIAG_STAT flags, so a f=
lag raised while
the line is already high would not produce a new edge. I'll reword the comm=
ent.

For the other Sashiko findings, I will also have the reply here real quick =
:
- patch 1's Fixes tag and message - he is right, the fixes tag should be ch=
anged
- patch 7's get_freq() locking and sample period handling - he is also, rig=
ht, I also plan to fix them in v6.

Thanks,
Radu

