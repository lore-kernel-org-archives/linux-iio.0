Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.139.77
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794581309;
	b=4fHcSoy7lHmc4kLiwcAlAroq7Q8w5SFN7GTEtTBcotBTdkKqs+/Gh7vU58C/iNfdsT84
	 EZl76iOw+xS/L8xdDaADv18VyEemSkEh+Amnqhd23IPfo0Tt9wzO50DU63fY6/p4WtKLa
	 AI8VJHvO+lZ7wJ8+WGMdJBPvQcaIt/HUJCpZRRt2HnzOw7miqP6SSgvtyhfUFrCivJXhL
	 60X4idI3+HJP6N5q+n7x5pGuwElYgPE/M9l6C/LvYV8xpZG3HSvX+9ILsWi61Ub9YoUqD
	 YqJa7YVPX+n+aH0/JuaOewVzae2OxDPwTxo4OFOded1tNfnvGKayKTr35SMuAziBuPQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794581309;
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=UP9M6479T5Jlvu58zM6ClwYp6AuAn0nGxCPjYi6Z9NU=;
	b=5sUXV4p6UvjyF1CknUbzPzdld0S10NaZ0sF19yEUfVHrDomtf77Q+tDuUqqHdWa3RkqQ
	 7/5DFB5fSHtowGZQLj2USOsJhv0WnFORXxBT2jvTDvz/n4Ub2mQzLXggpRW1ifSM7BSTf
	 7A9hK7hUOgoD5bygz05foAcQvDXT0JiGjrvRF0tbDCm0Srgymlij111qsHvVAjbJLJAuh
	 Z/qKrMb2EPQoj6hnEK1Ycs3wiNtyzM/fN/Jb6MBDCoa/B4BFuA8JxK1jzG7GrzNV4OtZ9
	 oAUmvFN2wVK/R3R1nJwEDrHZ7+qZ2dPTVlUUaIhJMdy2Yl7S1W72bRhdiB+xp1Ol4LA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=ppFtFUd0;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=WNADgvNA;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.139.77
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E07ED606A33D;
	Fri, 13 Nov 2026 14:48:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E07ED606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=ppFtFUd0;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=WNADgvNA
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ADDStoq1972280;
	Fri, 13 Nov 2026 09:48:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=UP9M6479T5Jlvu58zM6ClwYp6AuAn0nGxCPjYi6Z9NU=; b=ppFtFUd
	0C/mQEYFtFN2pZ2Pc83QAbx6FEULdZ2R4OfuPOzlGX3jJIeEQoJQa+J/L56nNaQK
	ta8FC9FEXdjtH7cn2SjW00IVN/YiwwpCaPS4seUjC9fwIR3Qr3jwBpMQW5sn+ngs
	gBfjDaEv2rRxoUe5zDCnP3Q2JMA5/60jIsyTMR+RZFewjT4VgzVBvVt5pjLgj3PR
	7SkWGHM+9z1xiuQjaw/c7o4KoORIVsANoqZG7LoczBID1kmkL9J7IXxDiabfXaPc
	Vy+wCejcMuzeuepd6npDPwtQfti0qooZhsQVH8DSP3SoULuEIZSHVLtLzSczE3Wo
	sJUbq5Exv9Gz+oQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=UP9M6
	479T5Jlvu58zM6ClwYp6AuAn0nGxCPjYi6Z9NU=; b=WNADgvNA9X0REf6e8J7yo
	OQxk5vNoAv4jJiYqvZKc2d2GSCSppn5KerlOqkvcg86XCQPy7JpFGu+L96fhsXqg
	3xjBnRPJGy9KtkR1Qzxr9HOtIYf0YVMQZ95aP4QB9RtLqD2t+OwVosR+jEEAETzh
	GbBHx0KLspkAoCZ7eqkwqw7S8stP8S97KKETTIX3jmZg1jz8bvXDJJde8qJ2ebCq
	p+Bq1hjIULs6YGy7g7TGGUV+VaEVVCslHBYNnvTY9/5LGrkfVJ4LKA3LbW9E+nuN
	C/OyPTl0yqJ1VfXEGm0H1bhdcEy44tf5J4QJcKkzPuxrltoPYJK6lWzXnyVlIU0H
	w==
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012042.outbound.protection.outlook.com [52.101.48.42])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4hwme1m4n2-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 13 Nov 2026 09:48:11 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A3c9oAEM/tjwOyRBSZ01Ua0OSXmnFxWSSWWKlvNy59w7Lm4B55esm/8Q5gpalqbQa5HI9okR2hnAnPfUCxGGy0Bjk5kwhNguVUEG7vV58ELFc2Dhb9tHUQ//zEQFK48KqjugbbBcwoaGtvtTlohME7/vJrATec9Lx3Cu0ye8sv5AXmJX335qqwYd9k0SoFPJ8SoEBC4RxRTRv7TtNh1g44WL7Z98J6ALRSNdTLcJUsnOK1l85WJe4jv6/jL5runwANy/L3V2a6u+W09tUzUiJyX6QNlqDoChj4bmdpvVrP/B/zyoYFKWNKU3B/A8HCuJvRZI9Tf6j7QmdYIBAWB5kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UP9M6479T5Jlvu58zM6ClwYp6AuAn0nGxCPjYi6Z9NU=;
 b=hxuBjXfla+3WgsL8SaYRQejd9sQquCH68FS2Na9UXOM3aQhiCEqbQH25JRHSG02zWnA9unonQXvQOBWPPl4La09JTpHW+NiQzvPOTWl5oPwh7yB8OHJ9FFZ0FNumeliNN1PVQJlQIgX+4KL71Au4Eyz2RvUJsDKoViN09Vpc7UVo4O53LDHehhynU755XtlAqwpHVc3UUXVKXbTNK6kT+Jj/CEx3bjBZzip4P1CMfv1abzk10OKY+zP0j1VvkN9r38ik9KLY7Ay1xe3k+MrdLPVZeib491i1OlW9Ttuww/F+U2eVVlYTZcv2LLorLb364QA+/vvNtOU1We6/q+7euA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from LV9PR03MB8414.namprd03.prod.outlook.com (2603:10b6:408:367::23)
 by SA3PR03MB7418.namprd03.prod.outlook.com (2603:10b6:806:396::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Fri, 13 Nov
 2026 14:48:04 +0000
Received: from LV9PR03MB8414.namprd03.prod.outlook.com
 ([fe80::d661:7c16:d052:cc81]) by LV9PR03MB8414.namprd03.prod.outlook.com
 ([fe80::d661:7c16:d052:cc81%2]) with mapi id 15.21.0615.009; Fri, 13 Nov 2026
 14:48:04 +0000
From: "Sabau, Radu bogdan" <radu.sabau@analog.com>
To: "Sabau, Radu bogdan" <Radu.Sabau@analog.com>,
        Lars-Peter Clausen
	<lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "Sa,
 Nuno" <Nuno.Sa@analog.com>, Jonathan Cameron <jic23@kernel.org>,
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
	<Ramona.Gradinariu@analog.com>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        linux
	<linux@analog.com>
Subject: RE: [PATCH v6 6/8] iio: imu: adis16607: Add FIFO-based buffered
 capture
Thread-Topic: [PATCH v6 6/8] iio: imu: adis16607: Add FIFO-based buffered
 capture
Thread-Index: AQHdc2s6XGJN+OA9U0uL4QKhgc3JR7csFKew
Date: Fri, 13 Nov 2026 14:48:04 +0000
Message-ID:
 <LV9PR03MB84143A27E4BC271D70ED05BAF77F2@LV9PR03MB8414.namprd03.prod.outlook.com>
References: <20261113-adis16607-v6-0-3f678719942a@analog.com>
 <20261113-adis16607-v6-6-3f678719942a@analog.com>
In-Reply-To: <20261113-adis16607-v6-6-3f678719942a@analog.com>
Accept-Language: en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV9PR03MB8414:EE_|SA3PR03MB7418:EE_
x-ms-office365-filtering-correlation-id: 7cfd267e-c386-4a65-0519-08df41951f54
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|23010399003|7416014|1800799024|366016|22082099003|18002099003|6133799003|4143699003|921020|11063799006|261022075727099003|261021121427099003|261102123227099003|56012099006|38070700021|10067099003;
x-microsoft-antispam-message-info:
 LdpiRyRg/u0E1ESOoYTM8NNIMOOVD7QJuoLC/Ry8EkRF1CvCKRRBqqpXqoHjgKFwxi+R79vqyr7siQtWM4ZWthiipJ92mqTmHfTOakHovW4BzudyggpRvANFeTX+Iy0F2yRdN22H+nxgN0wHQsTdJeYQS9IlzNF1QDFmf1tFR4l2XT0bcYSUG8GtMS/mDvH2QY3KqkKTnbmLWk+bETJUaddRG7rPhYnvcFv2A13mLdHcGxv2pMDDD/bNwKj+LVMPvSG09VI0W6VyqDE++T0T7wwX4B1hCwQ3KOcjXooJZlYZNnNknEWR1vbU/KVje+XrA4nKkGTnmFK3wV2j6t0a58aV/6T7rvoENKYiNWzek/VuZpofMdzsURPbSmWKddYTscVZVMkMshvgmgQPpq65Xy9aCmWohEuNt7+mXrwd8yy+fGAqMTYLRs8SkWBhh3tF0mWPQ77v+Rnohc/Ec3Txh+IA7Bd74XF7b8n/3JKzS2g+1Qn4SFAScr4jZuejcf+WeTsOo0hDwm0IpKmIVbvTUpP+0dhfjQPG7MuYtD3d80dRvHtZVFx/bpKEOwBT+QRxJx0kDxyBpXIVf3WZuoY3DcvKXY/V4AkcHeglv7anitH+54SiiNXjUepZL6Bd5HV7cRJGPzNghbwdxsYNDJ7E+SuCsUb5580ljC35hpHi5AB6x8bTwGEKE1r64anCJ5G3iSwT3NV/OYFVsCea/mReNqgEyoaTSWWDAKfRo+FPt+Kd/z22wTTeg+qMI7V+pfR+
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV9PR03MB8414.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(7416014)(1800799024)(366016)(22082099003)(18002099003)(6133799003)(4143699003)(921020)(11063799006)(261022075727099003)(261021121427099003)(261102123227099003)(56012099006)(38070700021)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZUNibkpRSUUyVncyKzUwVUhOR0JaQkUyZ3RCaitFcWhQaUNQbE1tVmdTOXRH?=
 =?utf-8?B?Z29TOGhIRElUUTRmOFMxVDRwdENqWU5ucDVSQ2Y4L0FCRUdPOXFxYTBoa3hO?=
 =?utf-8?B?TktrbHJRUHNKTW9sRFBDdFd3L1ZzWk1zRW9jdVpLcW9rTWh3SkV6RmUwZzdV?=
 =?utf-8?B?WXl3Q0tOUmM1b3RxcStYajl0VTcreVZxb0Z1VUJJaW1hNUpuUEJYd2xxazUx?=
 =?utf-8?B?bDkzamk5d09lNkNKejd4RWRsb3FFc0ZyMzRYQXpXYStWOGF3ZkQyNjNjbjhu?=
 =?utf-8?B?VXE3cmlPc3hSdEN6OG9qZkI4R05rclNjSXBacUpHQ3JYbVp3SFhWTThDcGI3?=
 =?utf-8?B?MFZuSHdDeVg4TytZSEI0STQ0SFNNc09MN3NoQlhsVnYzMlJUR1djUWZmL1E5?=
 =?utf-8?B?QWtUL1dGNmc1YXF0WWVaWVRtZFMrYlRXb2RTQXJYZ2lYNnNKK3hHWm1sRklR?=
 =?utf-8?B?ZHM4b1NrS0RBd2d1K2VJRVc2eTVlZlR4V2JFeENPNnJxb1BNUXMwazVzM0VP?=
 =?utf-8?B?ZGhVZStrb1dzOHpPNmNOdXBBak1waVVCWVMvUUZiby9xRTRHTnFoU1hCeE9j?=
 =?utf-8?B?N1lRYmJjRjFpbUNpUHYyTE41RXUvRzFVYWtTZzQ0TzRCUk5FM0dBeFRXUFRI?=
 =?utf-8?B?RithTkQ5ZkJZWGljN0ZCa0E4OHhiMXUzNWxkaE8ycFdnTkRrR1lSbWVsKzJW?=
 =?utf-8?B?WGFVNlJRQXFIUHlEUlVtaW5TQk01MnQ4d2tNaDYyWVpsblF3ZlcwcUFWV1ht?=
 =?utf-8?B?M1Zzc013QUVrbStXWDROeDFRZ3h5MzhTWGh5R1d6UXhpeDRDQ3ZpcTh3VkRj?=
 =?utf-8?B?a20ycU9wcGYwY3RMZkM2NkpTQzNNeWhFYWFENHVFR0hyME5OYUpoYVY5ZWM2?=
 =?utf-8?B?c096c2hBdE9vVlQxSnNobzRhdk9aMjA1VERiRjJISjlGVlRvSzkrZ1IzMEx0?=
 =?utf-8?B?b2R2c2p0bytYSTlSUVhLenFpQlFvUEg4V0srMkxDNHhZRG9VVHRXWGhxSkg5?=
 =?utf-8?B?V1d3dXNuQXcyTXFJU1A2NFp3S2hVQllZUGJmYXNPTDlOamdSdmhJUWFzbUh1?=
 =?utf-8?B?WURPNEJ5K0NjTWYxZGNnWVJSdnhjRXJHV0c4U2dyekRWUlpvWjZKR2p5WTZm?=
 =?utf-8?B?NzVXQndCS0JqWm5PSlp0RWFSWDlHUmlMcFNTTWhvU1d2ZWh2K2NncU5GZlEw?=
 =?utf-8?B?Zk1tUWY0b24xOWVXNzIwS2FRTmhiUWFRaG93ZGFtOHpESXpKRkpMVC9DZGF1?=
 =?utf-8?B?UzR6SG5sbmxjai96SklQT2pBLzRwZDBpM1JpbXRSZXRZZDEvNnVkVWRTdDVj?=
 =?utf-8?B?NVlpa0l3ZHp3WjJPUFkvV1BNSWY3M0xBNjIxTWVncU9zOUFNYjc5NEZjc1Bi?=
 =?utf-8?B?dmFDRVI4Um4rbnNLbDlyKzViSm9KQ1YzRnFvUEdtbDM0ZUM1TGdUQ21tbVlM?=
 =?utf-8?B?VlZEdnRlRnViSmtpSjRqQUtNaTk4MGhycEg5WUx0NVY4N0o2dmcxL0Vac2Qy?=
 =?utf-8?B?UGpzaDhsUk0zOHZqZ2F2L2NpQXpkVk5sc3lzUFlvbkdocWwvcjhyY1E0cUFF?=
 =?utf-8?B?OWJuTEhuQUIyVFZISkNYNEVzQTB5bElueGUyZEFxWlFZT0xadkN4eXQ2OHhY?=
 =?utf-8?B?NkN6akp3STZkd1VycHZYUUtaRllMcXpzbm00OGJDSmNCbDZXOGVzUlVmalB1?=
 =?utf-8?B?NXgrQ2FpNGVLTUwrcTBscGNiUHRjUnVPZVRGQ09kcTN4U1Z1MzRpZGUrVDcx?=
 =?utf-8?B?b1phYkRCTWF4ZmVRYnpCQjBLb2xyQWJVTXdsS3BpeTR2YXhabTBVUGFFTCsv?=
 =?utf-8?B?VVFZVkNwOGdEWk4xajNXSjBUQi9SR2poVWMvV2thRWRZUFRQSGZ2MHVuYWRH?=
 =?utf-8?B?QlpTTW5ubmZEbXc0ak1iNndtaWoxQ1l4eFpjdnlvZWVjNjd0MHhFSnNYL3hT?=
 =?utf-8?B?Vk15cFFkQVdmejk4UXl6bEQ5b0Jlc0taVDhza3J0QXg1dXp0ZWZDYWFnL3FZ?=
 =?utf-8?B?UVdXRzlUcGV0ZmlubTViYk0xZ1ZhbG9CQ3lvb1QvaUhmZ3FEdUFzZDBCTDRW?=
 =?utf-8?B?YmNGSHk0M09QRTYxUEZERjNTS1c2a2tobTZGdUFZZDRxcmlWVk5oWUlKYzM0?=
 =?utf-8?B?dVlPd002eVNEMVVHMTZpbXQ2RTlKa1NSSWkybXhVSm0yRGd6dGRkTTlrL2xJ?=
 =?utf-8?B?M3piQUlIUlZkdUNPbG5KQ01TTGpNZEptU3A2NXZsQjRzbDVId1hvSU43ZGhM?=
 =?utf-8?B?UUJCRjN4V28rYjVzTk9zK29ndFI5SXdVZDgvMHB5M1ZqODVVbzBEdXp6WVpZ?=
 =?utf-8?Q?0SRawm4mA8hexBxdqe?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
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
	425aP5Ou46zvoV56LNnrd3qnCUmqccw6i5yrIgq2d7AsDTSmnlmBO2b6j1bbtNpoR6K8IKyoyl5sjHur/NNeGN1aoCbiF6eFzPo/6q3Wndw89HWHeMiK1tW7J/qWRbZmI1ySOrrHyxAm1EMsR/vvMAK56z41e7MFV0ige9aSbMO5IFGOOF2etZAY/Fg6UeTy4zugVcAtK6141WTwjakEwKetbPA2UAjuK+ImSuEWojIz3ETKVKYvlWLMw6Y8fVYExq6TMr7+TlnhcweVx3hWr/FcBUI7VYP7P5WV70QVskg1KoKOnBqi8yqYVY26yMyVE7A4Sz+8RU42/lY37nEwxw==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV9PR03MB8414.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cfd267e-c386-4a65-0519-08df41951f54
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2026 14:48:04.1324
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ag0dRNjZcz3QRZVelOHVt4IeynBWFEBBOm+u2oZqWwaVJh8aYZ17gtcY9WtLdbsiUBGvPlHr4u3NnVUgt0ytxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR03MB7418
X-Proofpoint-GUID: h980G4YZ6Pvz7_4sJm58WF96h72hpAP5
X-Proofpoint-ORIG-GUID: h980G4YZ6Pvz7_4sJm58WF96h72hpAP5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEzMDA1OCBTYWx0ZWRfX/mbMR6XMH0m7
 zY9O6edRBO1fN6ZFqcO+bXtpujSIUdoArqgf5lVJZK1eGY9ajH/9Zz393itLAvncf7RF37b/184
 ImwwxbzttVHWyJDWb2cmVig3xl/TQVQpho/+KcIB8DPlhIg6fnnygoz2sjjzddTmjMGuFXPjJ0d
 JkZMo22k9MPpQQgmR8LlEsoR/C/S17F0MZijciDB/LWvDM1mqKwEixEndg8vYrkKW15UIiayX/3
 mUnenX9cL1FZKkz5kfxkpMSPQiimg7AOSi9gn4ANMt0ZWznSOYJCt2dbVu8xpOjUltSNwqG5ubr
 whq6cnYL64dw8AhTcPVUu3MwKGVVh87LMUayy7O1I2N6jubO5hwCvb6oeS2+GQtUENgd/M2ry2d
 2FQsQvCKBQV8a3mATwjv36nwY4nD9CF8ppyqfilthRgAPeHm4CQBV9o09+hK0omsfQiyhBWFiC0
 6S1rSF4fLNcTuoIOyMg==
X-Authority-Analysis: v=2.4 cv=IIGXmQvG c=1 sm=1 tr=0 ts=6af7232b cx=c_pps
 a=jJ4xAez9KAo77aFOr1Lg9A==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=_jAD5XSDOtq9-5Nde2OG:22 a=VwQbUJbxAAAA:8 a=svoZNddurw8F6GhTniUA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEzMDA1OCBTYWx0ZWRfX2Fng3Uu+E+kj
 orfcjDh1kwuIj1cZznpdZpfssqJjxAB4TWv9j5ldnETUQaNpoDsma7zSJKQHpHLWmm5MvKujkJl
 jpVn9GxnYeGxy6zwcZpDEI7OdIR0wgt4bd+TTeGVbhxUrr4wQbYo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-13_04,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 adultscore=0 clxscore=1015 spamscore=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611130058

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBSYWR1IFNhYmF1IHZpYSBCNCBS
ZWxheSA8ZGV2bnVsbCtyYWR1LnNhYmF1LmFuYWxvZy5jb21Aa2VybmVsLm9yZz4NCj4gU2VudDog
RnJpZGF5LCBOb3ZlbWJlciAxMywgMjAyNiAyOjM0IFBNDQoNCi4uLg0KDQo+ICtzdGF0aWMgaW50
IGFkaXMxNjYwN19zZXRfd2F0ZXJtYXJrKHN0cnVjdCBpaW9fZGV2ICppbmRpb19kZXYsIHVuc2ln
bmVkIGludA0KPiB2YWwpDQo+ICt7DQo+ICsJc3RydWN0IGFkaXMxNjYwNyAqc3QgPSBpaW9fcHJp
dihpbmRpb19kZXYpOw0KPiArDQo+ICsJdmFsID0gY2xhbXAodmFsLCAxLCBBRElTMTY2MDdfTUFY
X0ZJRk9fV00pOw0KPiArCXN0LT5maWZvX3dhdGVybWFyayA9IHZhbDsNCj4gKw0KPiArCXJldHVy
biAwOw0KPiArfQ0KPiArDQoNClNhc2hpa28gcmVwb3J0ZWQgdGhhdCB0aGUgaW5pdGlhbCBmaWZv
X3dhdGVybWFyayBzZXQgaW4gcHJvYmUoKSBpcw0Kb3ZlcndyaXR0ZW4gd2hlbiB0aGUgYnVmZmVy
IGlzIGVuYWJsZWQ6IHRoZSBrZmlmbyBidWZmZXIncyB3YXRlcm1hcmsNCmRlZmF1bHRzIHRvIDEg
YW5kIGlpb19lbmFibGVfYnVmZmVycygpIHBhc3NlcyBpdCB0bw0KaHdmaWZvX3NldF93YXRlcm1h
cmsoKSBiZWZvcmUgcG9zdGVuYWJsZSgpLg0KDQpUaGF0J3MgY29ycmVjdC4gVGhlIGRldmljZSB3
YXRlcm1hcmsgYWx3YXlzIGZvbGxvd3MgYnVmZmVyL3dhdGVybWFyazsNCnRoZSB2YWx1ZSBmcm9t
IHByb2JlKCkgb25seSBhZmZlY3RzIHdoYXQgaHdmaWZvX3dhdGVybWFyayBzaG93cyBiZWZvcmUN
CnRoZSBmaXJzdCBlbmFibGUuIEknbGwgaW5pdGlhbGl6ZSBpdCB0byAxIGluIHY3IHNvIGl0IGlz
IGNvbnNpc3RlbnQuIA0KDQo=
