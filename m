Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.139.77
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794819311;
	b=dFRg/HDpqK/kiGLKxiRh/ytBZeMC5/YF8i3NGfELuJ0HZ1RiLDszBicYl12XfaCJt43g
	 1Z013YDp6DOrzRTz1wVjLTR/1xFMzOxiuX/X7iYNrXY6EdM/TaNYelCzqJbRTP9HflcOy
	 dCaEvuQaQurN+2w9Yi+np5rdZAOKrA711lifedoI4rIbRD761yYDeKytibRIlnjwlKpMs
	 52lK0zEuaDcdSj8g89xjDqUjTFCnPeLr04+h2G9VB1f4mOZaO608MJL8m2Cnyf99aPo4N
	 YaQfS+e5vV5KNfM18tIZmR+pgpvFbjIbNlDLqnZ8QuYptCTvVD419VKDwKC1wq9Xl2w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794819311;
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=JKUdXk/Fqx+HpvxnP/WcvJ2H/6jv+NLzicVIgME+Ux8=;
	b=CSiXKzsgbfLwnRpdNTJ9SXXVVuleiTvEAb0jx6dZjp2JBktkpbpQn+a2wnDSjZJ2h80a
	 4sgPV5IOVFVr2Kd+ZEIHn0WsijGAKUCTr1KtzlHN5ridX8zIgfwTXVgweJpR9qcmHsV+v
	 ogCa5w79J2HmjTbcl5vRI/g1h5zUXfPfPW8E8ITQpyo1BowhXLQQrr75cBA4BuqdRGDbX
	 vb4YtfOPE2EYL4HZQ2EPCPwD6nvfwhhCsl6BRxrZhnHhUxMRLpgWz7JWD8EEtFNHw6OgW
	 /zgMx8FDlcbmVqBECK5EyJcliO4NpiTkMQTeRTfnbLEREPhNfoY6MhPCE4ERd1mBIvw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b="nV/Ze289";
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=hyEKw0eb;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.139.77
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AFC7606A31C;
	Mon, 16 Nov 2026 08:55:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8AFC7606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=nV/Ze289;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=hyEKw0eb
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AG7deMN1187906;
	Mon, 16 Nov 2026 03:54:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=JKUdXk/Fqx+HpvxnP/WcvJ2H/6jv+NLzicVIgME+Ux8=; b=nV/Ze28
	9zmGRi8TMS/bnptNOo9cBt0wXto3puDU2skQN/FxQZOjGw0taPcpruHwNPPsNmmY
	5PUiTF5iLIvd1ecEut36cltPNqGgC8EIUA5z9Dp0Lt3YUZjNe29atXmu7KbVLT/o
	a2MgXTxvpe1iTGdIphhpW1dlqyaCGU6o+uzEazAYxqmRR3d0nR7lnf3zidvnDT26
	U9l9edwJa6fyHNd93R3A5Md2vBu+7Hoc+wrnzKu+AA4c1rKb3vXyvWCpskwvLqy6
	u8fvF4P+IO0jsPOulL6Rgh+O/ifqdMGFtN2wC9zPY8D0rsbFdBSCak8wfsKcvX8b
	47L5XLegxWuWOVA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=JKUdX
	k/Fqx+HpvxnP/WcvJ2H/6jv+NLzicVIgME+Ux8=; b=hyEKw0ebVb2k2pLQB6uhn
	c6bb6/J4Dpc0a57yzLXaqfUIkjsvlAtpZilXMz4QfjUy7EkLMlUTWaeKgnnWaank
	E03r8mEgFyxzwJcvjoOjsg3sRFIJ9t+JgfkjOh0ybPb1nfZ9XqYE11JLutp4nUHP
	dIOi2aWUwwFo8IZ31XKKDkdCi+6FpGTs/mKng3DwcbvtwrhofWfHg686SfUzki2q
	bDGrbncSmclpawDMH3cAmGdDoZBnMyCG6feneOt8NmyKLQc47B1/r16anK9TtdqG
	IAY/kYgi1PI4IijEOi77M5Ry15nzT0x5lOIUI8LVqoESbqh13Txk/WXC7yIh0qk9
	Q==
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012012.outbound.protection.outlook.com [40.93.195.12])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4hxj9h9my0-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 16 Nov 2026 03:54:46 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AO5itRKf3miVInApMT+KzKjV6i8yMUNmuMM/5fgrYjo2FX5UMByImgRU8GOez3zrAtu7P0Jpat7yCcQkXcWwJlQY6Eek5zZ2fV93KL2dEPD38SbMCvIPJ0wBnuu5E8IZ1o+xor8IQQCGFHPgbpprAFiifwrtbZp58AMGjeaeTjT+GhfLF3i98wbrO7gQpDPAHY367LibSNTiyqJrVOmMUn4wzsUxxc86COxYoFRjO1MNm2KM9zi+1xZW/ry3vkjIFeSb9j7ui5jJREEc1Ym952sZxF+5XXHfbxvD08lEzvsbPTBxh6XFR/F15Cf72faVP8HPkmHB8Tn8spaeujNw3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JKUdXk/Fqx+HpvxnP/WcvJ2H/6jv+NLzicVIgME+Ux8=;
 b=i5PEPtbNiFzL99zus2x1kwr7CZ79xoHIkRra/apKY4CFibWGqjP8YtjAXRmftTHwZrBw8J0q2m2ttN46hbsVGPGoxPIqSWi7CljRIKgNHr0OmdGFxTuAfMqb6gj51XbMEcTfg4CX9Si6JZua4U9cq1fV4NkSz/7e0z9Hiu3Nz2FRhFz+pehFnvcDXgGHwRSO8gWHl9Jp6nolI6fgnJw6BrRoBAzSGLhR3X0KgwN2V3/ShwRQFQ2Ow5XmdTThfh/FBPoFLYI6fcqH/aWOBezZ0WGUG4C3XLIO2EFNaJ8StnylhLUUNxXSUit5KcNy7X/5mxKGJkA7NmHUrZWbCRoejg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from LV9PR03MB8414.namprd03.prod.outlook.com (2603:10b6:408:367::23)
 by DS6PR03MB906310.namprd03.prod.outlook.com (2603:10b6:8:4f7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 08:54:43 +0000
Received: from LV9PR03MB8414.namprd03.prod.outlook.com
 ([fe80::d661:7c16:d052:cc81]) by LV9PR03MB8414.namprd03.prod.outlook.com
 ([fe80::d661:7c16:d052:cc81%2]) with mapi id 15.21.0615.013; Mon, 16 Nov 2026
 08:54:43 +0000
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
        "Miclaus, Antoniu" <Antoniu.Miclaus@analog.com>,
        "Budai, Robert"
	<Robert.Budai@analog.com>,
        "Gradinariu, Ramona"
	<Ramona.Gradinariu@analog.com>,
        "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>,
        linux <linux@analog.com>, Conor Dooley
	<conor.dooley@microchip.com>
Subject: RE: [PATCH v6 0/8] iio: imu: Add support for the ADI ADIS16607
Thread-Topic: [PATCH v6 0/8] iio: imu: Add support for the ADI ADIS16607
Thread-Index: AQHdc2s9Qg3RNVIBC0mRongyWaIGSbcstm4AgAAG3ICAA6tY4A==
Date: Mon, 16 Nov 2026 08:54:43 +0000
Message-ID:
 <LV9PR03MB8414D877E31EFC41535C9FF0F77C2@LV9PR03MB8414.namprd03.prod.outlook.com>
References: <20261113-adis16607-v6-0-3f678719942a@analog.com>
	<20261114002522.34f8aeff@jic23-hlaptop>
 <20261114004955.71c7ed7f@jic23-hlaptop>
In-Reply-To: <20261114004955.71c7ed7f@jic23-hlaptop>
Accept-Language: en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV9PR03MB8414:EE_|DS6PR03MB906310:EE_
x-ms-office365-filtering-correlation-id: 27277d6e-1d27-48b5-2eb1-08df43bf41fa
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|23010399003|10070799003|366016|22082099003|18002099003|6133799003|3023799007|4143699003|56012099006|11063799006|261102123227099003|261028144727099003|261026121527099003|261026140227099003|261022105027099003|261021121427099003|261022075727099003|261021135927099003|38070700021|10067099003;
x-microsoft-antispam-message-info:
 RqRc/dNQxCReXpoPZ2ODJClcspCCTiDeuUWGVA3hxKI0QZf1PqcIanDk9X7FK8rAQjyYAsGwscMn8+LhRMjfRaq1acjtfyVvvYh8MLmjclyLi3qen8jTpUZZPvO8HAu45BKY9X2ZXO8vRXE70LsIcPb/671u6KPOOqlihXJ8eDXohSf9Fdqy1D8Dl+h27M/JSHMqKqCqim2UL9HsPBde9yP2zJ1m5xeGE4NGzXA6aet59paG+4vp5pSgJA8i14RxSu1rp8lSAg8YfQq3FRbEck5tSmgWECnMyPZ/dW0kT0fPluxwEtdkmHdR+dWHkWPZRXQ88ossp5YyGYOesNRV6aIX3rTCqEZ7gSfdahFNQ0fj7vW0pA07LgcHel64hJKH4QxeRVmLutC/WQzyO1HLnr2F/IS1y5XZ+mG+rOFFxY+U7IjpECt1F2F6u8OTwP+uNDe7ZZX8IgFz8XzoyxCY2lSMbxJuZo2TsqWcIbfZW9zIV5nH+SiWmWWydn8OO/4AzkX4GK805TkQswdiJKc7AERVrvC4Uh9wl4xQ9stvilx7KjNs+HZLbpOYyAVLHoWxgN0jqxQFy95hz8C7yrepfPj+Ik8Zs2B4VLTOmZokTI7tMkcRChC2p7nG1MnzVXJB+/5D4xa3FavMmU51G9PoiWPg/zCLGH4KuhffrbIm8zHuCfNw8RpsRGBpy0WJr+VfzOyHDx9NVchtZvp8ABWyYE/BfSEcWu6SV9fG/CdPj90=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV9PR03MB8414.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(23010399003)(10070799003)(366016)(22082099003)(18002099003)(6133799003)(3023799007)(4143699003)(56012099006)(11063799006)(261102123227099003)(261028144727099003)(261026121527099003)(261026140227099003)(261022105027099003)(261021121427099003)(261022075727099003)(261021135927099003)(38070700021)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?BHWc92j8Kd4kE18WCA2ED1dLet2b1BGvRqJR3fgWf3Vko3sBG+nzBnIb1JMe?=
 =?us-ascii?Q?2INw/fppQ4C7Mm0whIOYRiLPUGBEPawDMpteaYwzLVkk3R/c9p0oh17XLDDf?=
 =?us-ascii?Q?VGhEnR5VO1wsGgfwldvDJ7VtG2eUh1fuQYrTjE2D1UhloXKKaa5TOlDb6rWM?=
 =?us-ascii?Q?EzErUlb1QL1w4AUhAZeHmZSZz7sYJJBmLbg4T4fwgyKskgxV0Uh5UtHY8fk/?=
 =?us-ascii?Q?yCKK8dAwlHANtqfNtUQHjErBzG3ZoqSIzdtONWAV/wHIGCLEjgHQbdA976Eh?=
 =?us-ascii?Q?giDI3ZKbUTaRhoOpyu0bThdTepAF7Nq3xde4Hu0evVM6FNY5XMicUDtPkBxy?=
 =?us-ascii?Q?HIEli4tvc8GqwqfOFiWUkVuUN01hkCzHqZyKXLuuCLQU/t4iLIwkEYswucnW?=
 =?us-ascii?Q?QAT4YCeQjQTeG/n9vhcg92rvb5BAsDv33xkaE+zVlp1XPq+tkxnwY/d3ugp7?=
 =?us-ascii?Q?+p8G9ntpuSQ2CdbNn7r9KiStIvJuZLanrWhBBfgNfBAxk2/pG/FRQION7GaZ?=
 =?us-ascii?Q?bbxyaki4qysr+vgWfu8X6D4qF+m4G5tv5tnew+ab8KUOzXVqjG3fse3muJDi?=
 =?us-ascii?Q?91Czgoz63zggGfmlJh2dN+04PY8NdKZenE6w8USVfF/4qkADZdE8wBOxAgGz?=
 =?us-ascii?Q?4vlNHjNXkU4f8FcH+plN8b70G2rD4ayob3QOC2hfg3nbqWJpw2vSN2MJIX0e?=
 =?us-ascii?Q?0SO1v4qKC3oLq/Nqm9MXVFp+X28rgY2IQ0HuOlFwoeYbJ9Q4DYQShqBKAtCM?=
 =?us-ascii?Q?Whr3fy6fMwR36bPPmtLrqYubst7VhHy1wew6ysb/iS09B33fc7VV3zw88oLg?=
 =?us-ascii?Q?cgQksAUe+hoHzb6PwxNkYFtog6QezGPGnupMNXscr2X65ju/r9T1bfGqhW7z?=
 =?us-ascii?Q?YTGBkD7jvbHVu/4ysSB9XRNxZ3yZ2muH1XhIA9FlHJC5DecOt6kWSOhQUX4r?=
 =?us-ascii?Q?as7CFBpEdjQNTU052STmAttHEHm7GiwSxi1MTDBX04a5ZXuy2ntDRrJooYMH?=
 =?us-ascii?Q?XW1GSpRtXz90/P+lGMor0rKCfi+yNKDgZFxTtQoN9OINLx67cLIxyGNwoSIX?=
 =?us-ascii?Q?sjUFE/AQm1Qv4MdIeJrJFIWffxqko68nHfKGQeHp+U8AFv/GRVeyCgyXu5JA?=
 =?us-ascii?Q?aaMa8z7+5HKiZc3VSvDRtSnRg0tUbgzkCqrJGU4ju0c84vtyETg8I9VFDvSL?=
 =?us-ascii?Q?yruKjXs78dCLipxQGJp5C2gmthiZKhmRtVc3MgcWG/6zhYl1I2layynGr8Mj?=
 =?us-ascii?Q?gz4NxpB0vIBTvBa1tT/eXemeUmUiTwHGaWI2ImOkzARNaQYmqXEa76Zh5O4g?=
 =?us-ascii?Q?7gFFxxG0Mx7bWKN6rTELkxIu+AVtCxUFMbH1DoIq8/x3nCZD3iksqYxFcYN/?=
 =?us-ascii?Q?gnzJBKr4EbM78u2bY74p1IvD130loN3sSZAuWPYo2LJciAkGA7CrrudERLOT?=
 =?us-ascii?Q?Y7eIO2qU9MPha8zpnhRDae5wMf8elwhef3UbvkomKljRNwdIMre01bdGUUVz?=
 =?us-ascii?Q?3WPhQfXoNJu6yhYcyrq/4inQ22No613DPfD/+63mZtB7MMp+fVonY/w9UstM?=
 =?us-ascii?Q?g5/mudC6dr5nYswjYkIOjhkGBpsfWEth0rVMdvmG1m/E5jsvuiuNCcs9ltS1?=
 =?us-ascii?Q?Vp3kReoEWxwlIaUvoLrN9oWcaLXsMvmvfPZXwxBh6bC2gcxbPWZJRmELzi4Y?=
 =?us-ascii?Q?qX+SYORfZO1V6l9dzKXoCCjD4VuXBm2XV5TaDiZLe7fDH7vU/LZgRtkgi9eV?=
 =?us-ascii?Q?OM1FQY/EHXSO8QqPAzDQUbBY3qGCKEgUwZj2flfKUtnOImtHao0R2vz/0Uua?=
x-ms-exchange-antispam-messagedata-1: 6LMcAaa/m7LkDQ==
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
	IC1cxNRLNEEZE/5R2LW34JqvSzKtxCYY+jaIlorycaqeGaj0jkZwvv7OOQsgZeSnvq0XYrSShGjonokGtY3YmHwYrJUwewMA1Ns3Rgi+IzOF+w7yV6WVKQS7AlcqALvNOkcb5f9I5LG5vdDmIMplM/1eAhABvTE6pz8xjAfULoR0avicQTRE2Doe9ogLWso5lrjdIK7f+uAqvcG84R8duoTOlp4fA6hCbvdAjBQAT2mvO8KiyTmi1CyyJwgXoIaqqk5uy74gtyiEKZHCCn3OCVszzL3oQ0zNA/OAIuBpm5AhDNThsLHcAxVY2ZeuhqVWF7nIk/HU6LQWS0RKfQpNgw==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV9PR03MB8414.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27277d6e-1d27-48b5-2eb1-08df43bf41fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2026 08:54:43.4596
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uNDU54DN1rBllN2mCPYZFsr05aUm3tyBStDI6UfVrkjuh/OkNDjqq3IQNN/2YjEohVw0HCMU/xyj2lxnQ8H5kQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS6PR03MB906310
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDAzNSBTYWx0ZWRfX2zSyL45xhtRf
 gZqVVHruuP3QnWFAS7KFL1bT2seyIj3Ew/pXaczQPY+sF3TGWFymC6pV63qDMfqmGUylTmJt6Pi
 dX8p+SRXwp9VWn0QwfIUYO1Q73lWLW3VUj7RHQ5yOBu7SFM3rqj8AyU1jEW0YrEX0+e4DIYpq54
 JZG9esOKlD8tXvWGaC6zAs1y29PSSgh4j5TaVkZguQJ0KEApn/+vhw5u8FgVLI4hxotk7hHiBZQ
 QiD26JrcDtEHUecLCju4wihWxl7d9cn93Am1XvmhGNV1Utyef9RoSG3UGSGRThGqKWXs+2A2Qok
 1ZdF0tLrpCJo8n1nlKh+yX6j0rmWqSIobYArEN96Bt4bZu4iHiTA1JbLEj5MqqiYZZM3U1e3yFu
 NrUoCbQ9pykDbZq6NAt0azqJ4pSWIEj5kbnRoq4rxNm6yttB1xSUd8/F2ihhMBmJYCy8m1C+MS3
 OFCHEAXH29XKfNrg9uw==
X-Proofpoint-GUID: upIflvQQkdwa6558FtIRQM5Nxb08kQ78
X-Proofpoint-ORIG-GUID: upIflvQQkdwa6558FtIRQM5Nxb08kQ78
X-Authority-Analysis: v=2.4 cv=KsnYSmWN c=1 sm=1 tr=0 ts=6afac4d6 cx=c_pps
 a=AUi/O1gD07nBRLizZNiypw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=ugNRTJOwpmtT476g4l8T:22 a=VwQbUJbxAAAA:8 a=AMzXtCdumo6R4V6CgXEA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDAzNSBTYWx0ZWRfX0nq4AVY0M+Tn
 czz7oa2z0AjRXOQPr2eKPRFFdW9ZGQLJwRdGZOpSoxbRFSIvSGxVlh2w//+8Qnmu5zbtQHPKwt+
 uhYG8i//B9D1AEDDoSVz1UcQUa5dJwgwZ+SUVT6dOq8UzWmy3tfc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_03,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 clxscore=1015 spamscore=0 phishscore=0
 bulkscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611160035



> -----Original Message-----
> From: Jonathan Cameron <jic23@kernel.org>
> Sent: Saturday, November 14, 2026 2:50 AM

...

> >
> > > This series adds support for the Analog Devices ADIS16607, a precisio=
n
> > > MEMS IMU with triaxial gyroscope, triaxial accelerometer, and
> > > temperature sensor, communicating over a non-standard SPI Half-Duplex
> > > protocol.
> >
> > Applied 1-5 to the testing branch of iio.git.
> >
> > I 'think' the proposed changes for the fifo handling shouldn't affect
> > those and I don't fancy reviewing a mega series with library changes
> > and the new device support.  So build on the base of these first 5 patc=
hes.
> >
> > You will need to provide a base commit for dependency list though
> > or sashiko may get confused.
> >
> Change of plan. Dropped it over channel type issues in patch 5.

Thank you guys again for the review, and sorry about patch 5. I'll move the
scan_index/scan_type and the timestamp channel into the FIFO patch and
resend.

On the FIFO side: adis16475's has_fifo variants register an IIO trigger
today and are used through trigger/current_trigger. Converting them to a
trigger-less kfifo buffer, as discussed for the library, would remove
that attribute on the six ADIS1657x variants, so it is an ABI change on
existing devices. Is that acceptable to you?

If not, the alternative is a smaller fix in adislib: iio_trigger_poll_neste=
d()
for the has_fifo path, plus a prep patch taking the sample timestamp in
the handlers instead of pf->timestamp (the nested path does not run the
pollfunc top half). That keeps the ABI as is, and the adis16607 would
then use the adislib trigger path again.

