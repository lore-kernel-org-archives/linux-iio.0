Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4EF633E7;
	Wed, 25 Mar 2026 00:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774396933; cv=fail; b=EmGPmab42PXTe3ysIq9Pjo5LNeqqNrb4TB3QXMZlHASi4yy0r1Bl7B6zoe9jPrpNnjmrYGr1xGnT4+prl03WQkyLn3H5DR6eKkXwIKs2bgPOoMO0YSEYrxs3Dwnzb1DuJ3EkJCHvnrGr64dXmK8M0RUghPilPjlXajLbu3oxf3A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774396933; c=relaxed/simple;
	bh=OYJY2OEEaMJPkjv84HnF1fOyWY7zsHQM7rrGfr+JiS8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=b9Z72X7KviRQ+LjsfW53Vr6Sm328si4U37EAo/jLyUAzmu4e+3/NUtcwlWeoFcos2IOKTlRGaJZuqLrEVe5KGtTRDHB02OZwxLi8eBaaP1lCNGVgkBZywl9bhCSctu3fpA5xcLilKYtQIHjjDLyAzP9UKQIN1f2zOH7mRx4lc90=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=a2AYpm3X; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="a2AYpm3X"
Received: from pps.filterd (m0516786.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62OHkAf72430414;
	Tue, 24 Mar 2026 20:01:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=tY1ot
	sXL3ca50oj/VrQX8GTXXJH4PYaHr5rvYh/6SaY=; b=a2AYpm3X4ZK4lwxedpEt1
	heY9rZX4+4G/BhaH11i3lj73j9KhL2gcku5aIoFufxw1w9CkbMQN6CQRDQb+cZHR
	5KPQsCM8urIf2vS/sN1LnplgUj7v4OnQPPOa71Qk7+WsWcDEmZFoNxgKTJw9eh4O
	jB0mc2f8/jx2Qy7l/KqhMVYUVeMDaZzpFWi2gnaK3rYil/9mFaDf2tQUS26Fs8Qd
	skpi7MJBZEwxSa6HLkEx+FT42QzH3g9sx8V7ZL4OyciHsRLhhkUI8iUniIKxOfhU
	25G5+iJ4q4JjtFLZsb8noPnmTQMT7M4ZlmAj3he0+TFi/VhLpH2AwGHwGc3XM+FK
	g==
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011045.outbound.protection.outlook.com [52.101.62.45])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4d2bxejavp-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 24 Mar 2026 20:01:39 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JLaDpUAk0yv++hQ9yDD3Hy3H23EXpwfGxWjK+834Uke5u7wNm9QrcxXtyN/86TqC0UnCpe6SY4KozrTotP4y3ox7YwhxScKkBJpJT7zYETO9wwKNzD9o2T/eEiYZ/NTv/GKD+cl/IRdEx6Ig2SG4V73yzjwHaxcCbb7ALkXm8pqVPJ2B3NJnSOHldhoZtGGry2LMqzGR1iq7Qm6rPsXQ5btfFvMAf38iIqRsbculrF8fWEXAjE6MU9vzU0RB5oG2ahPctKugmHkdXwoDOD7qqUReNKM6+XbWd1Uaw3Z+zbC/fIHCUMBNSpbnoAZWVVWxNhkEDqlTc/jv2kGesORzPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tY1otsXL3ca50oj/VrQX8GTXXJH4PYaHr5rvYh/6SaY=;
 b=FrWp1LV37D5EtYKrdI/iWWA6yYJtnF8Y+uB5N/8Oylkb4gnqyCWJyn4dOREhlbUz53fPerxEJxmshoYBDHh4ON79rT4K9LYvVJgdfcVCJ5yO2a715fisAw6dClpRAcSIGIjc0EInj/bpIA2BFC+gCco/hJoZl5T2GIQq/TOARf0ESVCsEaxktVgmusUTWnBtrjwbBgLdj4KKRY4maGQfTo6ymm20A+3VKg3wxJOtG/4153hgT7lql1c++g4g8ffiQJPgVpcPQUjBss8oomW1i9CQU7xMe6FlgUdQP0Bfnh/t6qGF+tMmcHfNNYOW0M/cW/pcKcY/y+0tjS00z0s3BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from SJ0PR03MB5854.namprd03.prod.outlook.com (2603:10b6:a03:2d3::19)
 by DS7PR03MB5496.namprd03.prod.outlook.com (2603:10b6:5:2c8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Wed, 25 Mar
 2026 00:01:35 +0000
Received: from SJ0PR03MB5854.namprd03.prod.outlook.com
 ([fe80::d56:f47e:e473:97b0]) by SJ0PR03MB5854.namprd03.prod.outlook.com
 ([fe80::d56:f47e:e473:97b0%5]) with mapi id 15.20.9745.019; Wed, 25 Mar 2026
 00:01:35 +0000
From: "Jones, Carlos jr" <Carlosjr.Jones@analog.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
CC: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Liam Beguin
	<liambeguin@gmail.com>, "Sa, Nuno" <Nuno.Sa@analog.com>,
        Andy Shevchenko
	<andy@kernel.org>,
        Tobias Sperling <tobias.sperling@softing.com>,
        "Marques,
 Jorge" <Jorge.Marques@analog.com>,
        "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 1/4] iio: adc: ltc2309: Introduce chip_info structure
Thread-Topic: [PATCH v2 1/4] iio: adc: ltc2309: Introduce chip_info structure
Thread-Index: AQHcu4k4LGeIhVq1y0Wg5tAglcZHgrW+WlDA
Date: Wed, 25 Mar 2026 00:01:34 +0000
Message-ID:
 <SJ0PR03MB5854F612414BD4AAA428BD35F449A@SJ0PR03MB5854.namprd03.prod.outlook.com>
References: <20260324071331.842-1-carlosjr.jones@analog.com>
 <20260324071331.842-2-carlosjr.jones@analog.com>
 <acKChrd_0cRXu7-k@ashevche-desk.local>
In-Reply-To: <acKChrd_0cRXu7-k@ashevche-desk.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR03MB5854:EE_|DS7PR03MB5496:EE_
x-ms-office365-filtering-correlation-id: 9d3816fa-7263-444f-3952-08de8a01ade8
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info:
 RFSGRLQJtJIQtJHKGZhpdGLbV5pX7izg3JmldFtkM/V/fbB+p59uTHal/PTEGTEK2QXgum5YfAc/hfJAWlZlfoMISdkJtXko9Tec8YYTAT6Znkq/YUig/JLZXkj38Hmfx3NtZyBBI2tnTSba48tWVlCCCn2K2bAK5EggETRzimfcqzpsBSl9/+UjwS4moLl/FyiHRgcl+TUxM+Hd8V7I0AOLvFo2Mr7KG2dmwQRQnZfqxhD/c+LxKQIfxyiDBy/cgyuKu7zctwHldnEsx01esa4btLAHfYX6Rvy7aH151cncAFKAZemOx/hmThSdXIX0SyiONEQrDIFMlui3VO11jQHL6gLApUcpxcMF5bJWZasaOdei++JfsTVNpgfouPzQj7KSA4WWdi4xfQpSBx400WaKhQ2GmJ34zFuxkUGt13mDCS8CDaTdpPb5iCikR0J+UUpIXwm4K2BAA1Ghd+fuys6q7VbjfzinIM2r6lAONOd3yIvJR8nWABwKNimZrqwH96r7qKS27mVKdEPahsCWrDXguHEAuziYz+iDyrDqs8HZ4onGfKEtbEAZm5/nFNdcXsVn5sdosg1nES9NdPOrBkzy/pKy5KfVgaxN6aVlf0mfL3y5/+pT3b8Kje5jNiL9nB1Bu5ovkFwDx6tAdqvkdoUzYmmRhvAHmCkKNtCVOQ6ngVocnY5o5JwexkBa6zCvez5wQKPOwhBSaw75tvtUsgm1Mm1c7PpDXj+fKEz9W0S/oKB41NIxGyNKdpwRqSxt0QNjGx0RgGxywmfaDALqMajG9AyyoftNzTuo5TcfWEg=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5854.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700021)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?GTVi7k/wMCGBEJVzVrrCdSeCRtMykD+M9Jr5PKuHaAZDxLctTN8rP+a3n96T?=
 =?us-ascii?Q?Qn4jINbx6I8BA1yOOBTZVV+mbl2kyyZuhQ9CcXO4AxYsq9h/5HnsnmsrUHUX?=
 =?us-ascii?Q?bWysdMhhAVBbStP+TEMcRXeom7cJ29N6O5Zhh9P5jRyHNfFlB9MYxA0AbTwM?=
 =?us-ascii?Q?Cmh5cM3q5Qsd0y4fVMH/aZYfQi7NgbjwuTTg+muReV94XSAsIAWxRQt66Oac?=
 =?us-ascii?Q?SWSUrqe2erTT/wkxXidHJLoDy2vG95c/7aJWLhWCphPWGuCQ40G/H5yM0WD3?=
 =?us-ascii?Q?+0go8wSwFbFwBV096tFgZ3uB7mzitj3rLEBdID03vml02OqXY4pV/FNzZ1Ik?=
 =?us-ascii?Q?+PafHPIe9Gnz3md+q5WShHb9g3ASc8+EuKgawhzG/wcB32Ie0tLbsKTpSMpZ?=
 =?us-ascii?Q?CytGtxoVVuFht5IcPJP7rd9lQgbrzh9ljG0HRqCKX6T8pqBeYZrRE2hcuARy?=
 =?us-ascii?Q?JTZQZhIzbcselY8t/AS5AUCtnBqwXZa/yhRAUjd350nb5a913VwwUBM00oij?=
 =?us-ascii?Q?OAG8zcIVJNvBMdyZFYl4Fr7J02GKu82mFgBA+lCQ/5qtnCm6IqIYqBRaXPFc?=
 =?us-ascii?Q?xIKAZ85fgwJl6MYnu9mRB3P0iSu3uCWOgygD2KKh1bBIJntdrxd54T0YIjNN?=
 =?us-ascii?Q?Nvl+Q+S+C1vbtEzyfAgHbScIv8FD/mfmQsZyI1hrT5f2WTCqqnJg/vbg2V+Q?=
 =?us-ascii?Q?PsuW0dCWxCxWFJjg9FPpT3GCICgMxN8rmEG3lLsqC7f2F7zKRIKR/ZvEZedi?=
 =?us-ascii?Q?gsfP6mHGdieNAKX6+uxCijWdR40Gd3pYJgIpi4q0hHq0P5FuRlpN3CqLbqyU?=
 =?us-ascii?Q?GOaM2W5ydns+9KSPTUWjFyIJBdRKlukSC3j9YfQsCr+tk8YVWeahLpqg4ber?=
 =?us-ascii?Q?Pvh4chKYpdh+WAfcsWx6p6qBhp7eBmtobPhW6jCob/MW+f74MiXAdc7o7/Eh?=
 =?us-ascii?Q?yHTJVj8hfvwq+CD5+VsiMh6dW1auA1K8gqmZUxuBfD2jgqENpL5JNrlxQnsW?=
 =?us-ascii?Q?XaBBlJFa0eG7WyUVIMf5DOcqSck418aRghngNeCltr8uvXVyb6ZUgbmTIwFB?=
 =?us-ascii?Q?db1CGpcc90LtNXDPAW0Kx3ZyQj2lz5H0jivCFCam1CnhAGXtZXO6G8kMPfIt?=
 =?us-ascii?Q?6jHek8TAIBIVbOGcUBCaO+jwXiPDQ+qCpHLapoZL5Rbzc9auJimR97Ipvj4D?=
 =?us-ascii?Q?sEQ79p9n+RngmlItlxVQT8dTw0KqwQm2HpGbVYkvARXokLo+kKByub1wGKIl?=
 =?us-ascii?Q?967jeGczT7SZKKctU1Re89hZqQICPTlBkJIg86FnY245k9FUVHS5Xk37Um+Q?=
 =?us-ascii?Q?RmFd3mlzhewC4UXfHpxu3+GnYDg0+WqjAYi7JB3DgJ5Bg6aokOLdRzAj3/r3?=
 =?us-ascii?Q?NP9nFaTFBdy+C9V5CjjXy/meVRz3K9c9juFh1goiMGTLuFsf4I9WK5LERLeR?=
 =?us-ascii?Q?TQ4VQykjzYSKwU3idSNHVzr4CrUbwt6ZQQzcglkYOyCSvJslO9zAMoKtnhJQ?=
 =?us-ascii?Q?G8omsrJS/C71RpmvmYC9vFMhSIH1YqpOd6bbUEX8ALJpLHM4RiDTzojvuRbS?=
 =?us-ascii?Q?rGU24s2PtAtsIVIwpHHfR6Np1WGILCXOYD3JmqpJ3Hu+OYUWJqXQz3ONmax2?=
 =?us-ascii?Q?ktd18ze+85g8vbYvuT4HzpKC9DO7vNaH9AfvH9qhSVURBD0NLyKvLoVMZPAO?=
 =?us-ascii?Q?uVCHURleaioY3cHGVKVVX3HZWxSoxQU++8GgCfEya8iZj7VlRy+glhZ/nbRG?=
 =?us-ascii?Q?qXGTb2mB1A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	KS93QI3Q7Lq4Aq9CTS8fXQu18VoqkVceSFkFj8YxXT58eTBlW4iwUG3PlpCgLcEHy4uPhjeYd/MLO/UwJjzv0b4Qka8QAw/R3KS80+bw74qgJp8HDTK8kuIyEilczPYprwUQUuZudb/HoBppVIAP91+BARTscTJDbSukLQn+rz6dZ9kjHmg2fIdVRtnB6SXKOmwN9nYhXcEqmg7t1IRgzahasJAfKD6Pn2guFlOZZ26qZYK9Whk3nkb2Sj6zUyHjtqDoRzDVgQtgqj4Xcw3IeFXhtZK/u95tj6mmvlWGlWtIXVsVCJ/xkzG9wHzUs8CGBaiKCpyGFq+HzzHMP5OcDQ==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5854.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d3816fa-7263-444f-3952-08de8a01ade8
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2026 00:01:35.0301
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DM2tQlGfsjnh+Ttaf6zKhjFThofRV3MjHnXDudDtVsHZSMZRc/ZJXGu4H+VBECH4j6N0Ke/Lq5oyUF1joZXW9MEHccHzid1ShPycu0PqweU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR03MB5496
X-Authority-Analysis: v=2.4 cv=P+03RyAu c=1 sm=1 tr=0 ts=69c325e4 cx=c_pps
 a=6S8oBaZAy1iJ2l9u/b2bLA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=ZQxX5BWu6Z8IJBb2zLX7:22 a=Kk27YbD5bDl9Ix-LtKoA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: O5JiU1kgHF4SkYrnwkb8UMCSaaXXsAj8
X-Proofpoint-GUID: O5JiU1kgHF4SkYrnwkb8UMCSaaXXsAj8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDE4NSBTYWx0ZWRfX6sxRhAmR/ljC
 f/V0VYEiL4MTvUxhoCLOHY4oQ/VtSnMqt9YX0WrYpHaTP71RnXGTKTQ0iae1ynIe/CLFsgpDO5J
 xPrVnwh3UrPKVcvRAz8ixj26jkK/g9QVwJlbUHyR61cT9OxBJdCl3SV/GEGud0fE2TAuxu+Io3H
 /AYXmlHemcwoEsokCeIyoD8kgwDJMXmJi3YU5P7P2Kbx09LaM4Xn6+jBun/Pe93nabC7RtdLeQ6
 6f/48HXfMcN+1UeOXxjY4iCEaGsf1b7k2a4/bbtGxJTybtCZt24i0DptuYx1L5CMSHZllXDOaDR
 k5WGTqhBkOpuyQeig4NJ+hVUnFQLe1Ta6+ONR1lZGzPG/0C6Nrc9PWd/a2rMUWitk1MaZcwdxzj
 wS1Q8fyAR8Yg788XdjBX7a/tPHketQDl7sMLbku1eIta3NZh1Pq/v65YEetPfJUuCLXWWjSOFLs
 LIhINSgUzH+dvCeoigA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-24_04,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 phishscore=0 adultscore=0 clxscore=1015 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603240185

> On Tue, Mar 24, 2026 at 03:13:28PM +0800, Carlos Jones Jr wrote:
> > Introduce a chip_info structure to facilitate adding support for chip
> > variants with different channel configurations and timing
> > requirements.
> >
> > The chip_info structure contains:
> > - Device name for proper sysfs identification
> > - Channel specifications and count
> > - Read delay timing for variants requiring settling time
> >
> > The ltc2309 struct is modified to store only the read_delay_us value
> > rather than a pointer to the full chip_info, as this is the only
> > runtime-accessed field after probe.
> >
> > This preparatory refactoring does not modify existing LTC2309
> > functionality.
>=20
> ...
> > +struct ltc2309_chip_info {
> > +	const char *name;
> > +	unsigned int num_channels;
> > +	const struct iio_chan_spec *channels
> __counted_by_ptr(num_channels);
> > +	unsigned int read_delay_us;
>=20
> Now on some architectures this might have gaps. Have you run `pahole`?
> Even if it's fine, I would rather see
>=20
> 	const char *name;
> 	const struct iio_chan_spec *channels
> __counted_by_ptr(num_channels);
> 	unsigned int num_channels;
> 	unsigned int read_delay_us;
>=20
> OR (if there are limitations of __counted_by_ptr() attribute)
>=20
> 	const char *name;
> 	unsigned int read_delay_us;
> 	unsigned int num_channels;
> 	const struct iio_chan_spec *channels
> __counted_by_ptr(num_channels);
>=20
> > +};
> ...

Thanks, Andy. The previous arrangement has hole but the latter of the
two recommendations above have none (pahole output shown below).
I will update accordingly.

struct ltc2309_chip_info {
        const char  *              name;                 /*     0     8 */
        unsigned int               read_delay_us;        /*     8     4 */
        unsigned int               num_channels;         /*    12     4 */
        const struct iio_chan_spec  * channels;          /*    16     8 */

        /* size: 24, cachelines: 1, members: 4 */
        /* last cacheline: 24 bytes */
};

Will also revise the static declaration to align with the change.

static const struct ltc2309_chip_info ltc2305_chip_info =3D {
	.name =3D "ltc2305",
	.read_delay_us =3D 2,
	.num_channels =3D ARRAY_SIZE(ltc2305_channels),
	.channels =3D ltc2305_channels,
};

And noted on the comments about the alphabetical arrangement
of headers, extra space, and xmas tree order of local variables,
revised as shown below.

static int ltc2309_probe(struct i2c_client *client)
{
	const struct ltc2309_chip_info *chip_info;
	struct iio_dev *indio_dev;
	struct ltc2309 *ltc2309;
	int ret;

Kind regards.
