Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC96244C667;
	Mon, 19 Oct 2026 09:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792400949; cv=fail; b=QasI2FvvdhwF1tG782bqAba69PyrjGbVAyTFwg/uYiQ7LmHI2xjsNOlJH4i4sWouolAkwhm4f13nIBdYV2pKX/+s/HDwhttIoPKF+BaMosLdwFSudKxvdmSA2bm7ZP81qFjNQgykgaQy0Dgw96fWzF6hlzuBb/2CMEPhw9BF5LI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792400949; c=relaxed/simple;
	bh=NsmOS4/gKkJDd0+8hDmMe/3emqypsTDip9gwxjB6ht4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pyulEUV9YkPQCZCyD2I3cAkkaW/WelXp8UJZ794gEg/i7ISDr4pYYkduLTCa5S84m+2vexP6ErbhJIWYB5STVQfYKRTNaM9yUSyxPs0lsTb/AifSLqlhsGB5CemYMRgNvROutmdzev4gNjUi35ZpmIi8qnhCyg76gqTi37zELag=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b=GtmR8OXr; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=dS0C8+Og; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b="GtmR8OXr";
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="dS0C8+Og"
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69J8Mh2R2171109;
	Mon, 19 Oct 2026 05:08:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=J+pj0AkPPNGISkJcsSBngyoPrmpNivLE3V5kXK1Ij+Q=; b=GtmR8OX
	rAIHZMNNpfjZUGzX03+sdAIJkJG3CXcYCxtDV/GTzVcZ+FEgJlvLRob7x1I6/kcA
	wjmUXhmstae+0wCmuetQRaIxVaoqoFlgpkpRio2XR8JQwfW6W/HBgM+/hRkvaJQC
	mQEFnzF0+L7nXJs599/4dy5b1WsC2DQYGIM4jd/+sUSvxS6T87GlajhxUJejbo3L
	Gc2P5OecbHi5aAlwNnXG5rlwzpHa8PrGnsOGFGcy+2scB9Jc2lQ5xGZ6BzSlerKc
	4Ys9aUcTRuXzD9coRYsgXtSoYPkERNpyxMPjVtjGqRV98YiawL5voqoWIUTzZg9L
	x7yGk7jSp0SaOxA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=J+pj0
	AkPPNGISkJcsSBngyoPrmpNivLE3V5kXK1Ij+Q=; b=dS0C8+OgOyPJ5QVQpCTN+
	Yrjeevtq+3WhgdLBYuRXFFSCgbjM8+JMWq2L0O5teLva1Py8wsHZsKqEiMS5yjer
	hHv4cV30WtC+VGN4KVFk7yFk79xknoJIMRfPNkh50FTRj2qoZ6j3bq3vmQB0D4Wq
	Ozhv2AqoIlpuPBGLX/UtyoBmLheaXG1Jg5SipiBrE45fh4D3J375J9m0cWIlhXHE
	vUeufWwKkP38fvUSjtdKBh5oKYn+68kM9viw9NAj3THLMoDHVYHCV05eV8ca42vL
	+d1pw6CvrtfKf9By18+/mbTSKs+Mki8mb1LOtt1eRnzVr04En31qwe6THo57cbP+
	g==
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11012056.outbound.protection.outlook.com [52.101.53.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4hd97d2665-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 19 Oct 2026 05:08:38 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o6tyNgqkr4IjK0hQRwEyQkK7YLxD2cZA6l7/jTjcGqoyz35deCQtHBRgz+CDMkTks8KcLN7r5yYVzN0IpokSeghiiJ60X3bMX3dbUCypTJDc19Ap2FTjf+hDHFcIRjgJMBhtHJh7HwzLAwmuNw2sbMF+Td4b77pO2lI4rEe0WEh2AT5arX37cndRY3DCB90w2QXDW1kHosp1+Ily8aJiUHI5vTvXUywixgsAs1OCBW0h+ScsjG29pSOMykxhe8yBVEn3BqD3b/knZXZBKa+mYpWHMIZfKT50y1nrmG7GuLC5DhpYfUCUgD4KI9C3d+SY44Ja42oo3KdfypbprkKMSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J+pj0AkPPNGISkJcsSBngyoPrmpNivLE3V5kXK1Ij+Q=;
 b=ChrDnJlAv/9u3JU0qYw0Mb/T0ju7SK14C0S/IfGzLdofCS0v+SIkjKwD/y2OsUgBchmm79u7fu934f2j0zCWAw4F/0e0xdEdNAkpdte7XsTdYgEtmjWj2niphXfTlcbIp0MICfE5miVxNPMjYwy4WOXdtNHylB3FO3q6uwb9wW03x6Y9f6iH4bARKKviBIREaXI3RP47Knm1gCpLO1O653WvKmApjcYwoCQmNE3ISf5/4tkfF8IMf8luribpvkLJjZpLj2qZPS/uhaqXpzaJh1pB8D5rODTQ5a2gYwrgyxcZ5pZI+Ljz1lCGAVJyPgcB13ewsuml4aCN5vLor7Xyvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from LV9PR03MB8414.namprd03.prod.outlook.com (2603:10b6:408:367::23)
 by PH0PR03MB6367.namprd03.prod.outlook.com (2603:10b6:510:a9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 09:08:33 +0000
Received: from LV9PR03MB8414.namprd03.prod.outlook.com
 ([fe80::d661:7c16:d052:cc81]) by LV9PR03MB8414.namprd03.prod.outlook.com
 ([fe80::d661:7c16:d052:cc81%4]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 09:08:33 +0000
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
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH v3 5/6] iio: imu: adis16607: Add external clock sync
 support
Thread-Topic: [PATCH v3 5/6] iio: imu: adis16607: Add external clock sync
 support
Thread-Index: AQHdXIhZUhJh7Ixz2Eugg51Q6TSRd7cA/jIAgAObMcA=
Date: Mon, 19 Oct 2026 09:08:33 +0000
Message-ID:
 <LV9PR03MB84145BA319F60183C1801B89F7982@LV9PR03MB8414.namprd03.prod.outlook.com>
References: <20261015-adis16607-v3-0-f972d4efee85@analog.com>
	<20261015-adis16607-v3-5-f972d4efee85@analog.com>
 <20261017030258.0157e651@jic23-hlaptop>
In-Reply-To: <20261017030258.0157e651@jic23-hlaptop>
Accept-Language: en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV9PR03MB8414:EE_|PH0PR03MB6367:EE_
x-ms-office365-filtering-correlation-id: fff7a012-bb3a-4971-1241-08df2dc08d37
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|1800799024|376014|23010399003|38070700021|56012099006|4143699003|11063799006|10067099003|18002099003|22082099003;
x-microsoft-antispam-message-info:
 7lskjOMxSg6SUw4iACU37ofgQrOZAxjGO7wxV6YwTHabFON96+ac+yNI1aBKDwrxrroj3kQh40YYsNtLILaL0eAUSZh0ocNttPLjvhtZhvsU57aRgGlAl0NNmud/KoPWLmzAgXIhwAJHux8jO10pfUeCRo1rHYLAkS52gbtAmf4L+b9M2nuIo4Tke97Z5Y8jw9uZau4uIQaWT1BYlZi3Qzlo4dNEHDB9haaXCzCj7tfFcUtEgpuaXOLsW4lBPoUsqHr81wVou/zRXZdS1E5P4uCiYVoX1lEoAjUqU1u1vGuFaFo5CIwkKOn6PiyxlSXpmY25bXPhWrMUNENmasjNaaBRVcLN7Cbl/LF1DodDgrw4RNu2721lqaLk/4cIsjnAsfZl81klKIqTWfUDMaaIb5BKUgIoTupE74dlumO+9QrxieGetBQs7LsypNSiCZqVEA/he/nFbF0cUMzahrM0V93gjNs0KSED/QJAxmJNmI293rJkFO/e2UoLzKZgDDzU8DpjrzfqwPTeXJ7V/EHevG49b5yq+pufmxs4mYq9ZHiUstDlIsDmVC0kf9Hq7DciXQhHwRM+WACq2q6EGy1USoK8WuDqjQhAlw48JL5lMtzAUHdYua4lKkKTL21WUIGjOWI/zb7c6MLjbNDud9ofvLTuMhO5GADkIQSEDNG0vSk6rJV6k3/kvskq1PhGbdUlVavp10UWY6akMQ+ONoskMK10fLDLsns0sPx9hDV0qDQ=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV9PR03MB8414.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014)(23010399003)(38070700021)(56012099006)(4143699003)(11063799006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?BreUwuo2crYff39HYTq1qJcA8Ti8MDh/+l+9GEBMqwymThhJhdD7w+7lhHJD?=
 =?us-ascii?Q?YsGV2jlZONdD1AYjJtkSO2A9Sf/2H/apziVh06yISWbbMr6TZ61lKdAJoX7C?=
 =?us-ascii?Q?UMJADOq+1/aHdI9JerB4DZgsuql6wg0Sd/NiOSdi51CWF3L2eK1sRDekTM4k?=
 =?us-ascii?Q?hAAMpnFGqI0aTeoXw5Wfv8xNp4hzwBSAf9JSw6OWwMjCPAnG8vipgzpw7STr?=
 =?us-ascii?Q?tEarGLU5Gz274AbIz9YtEo+uu0OgVQEK7jtdI4rMB4DPlCXxCUVur7lONEww?=
 =?us-ascii?Q?XbiPLWr0ruUbVjYvyVeqmUdHkA9rra6UOd4Tz0RDHzJzF846wbSiH9+EbC3e?=
 =?us-ascii?Q?s5HCHSlbQEoZE7Fq9JYJRFCkWrxaLxIqmUQd6DIBPTLjGLZnBSaYFNYSEXCl?=
 =?us-ascii?Q?eWaUBossCcar3jwYf8moQTC5XusPsQJOQ4wtwEmw+zQifczv2wb3vN59Edct?=
 =?us-ascii?Q?KFLvDFV3gYkrjwIHux+ZA0n7fZZaiXKDz10sslIRrwiNVa4zFT37KJ90ilPd?=
 =?us-ascii?Q?bkGfbijq36LLwKJ3QwE9NEKRCqEHCBi8MlyNsMFU0HWcuxYVhUOk0tvQ32Ug?=
 =?us-ascii?Q?PsXfnfOr/5aW+TTKyrNHOw1OcSju/f6dLs1pV4prjItDSHF1jtH5XwcsS+f6?=
 =?us-ascii?Q?0XfpHtZWwOosa2eLol20adb7fNyQ1fTtXYyrJksBiNW0KuUROC1rEdDZC9A7?=
 =?us-ascii?Q?cNRGNYc4zlhWFgIYuL+fu+xvHfsPESkBqes55rksU6Pt3qtuq3bjuqlZAriN?=
 =?us-ascii?Q?7SaO1pNNKfQwONmXFtlhfT1j7RiWAnz0Tz+TBBjI7fPZM06KWTNJysFYxqTj?=
 =?us-ascii?Q?3Ta+GOvUc5TWqjKH7aEwtGzPdj/lLLvsSOlQ4ILI0kRAoN28ZgJWlr8c7FEA?=
 =?us-ascii?Q?gzGDKEOOeQStvi/H7reIM6rrHYDbMUs/pXVbuWpc8EezKofw0WoqZAhvUJ96?=
 =?us-ascii?Q?cSsPt3IiskvpQhsa1p7+9+5HkhAr3WmqL44DwnX6Lv6EGdI4qGglZpVLMsJy?=
 =?us-ascii?Q?2e3kn+ayOjoemWR+HUQvnX/rGa+T+mEYMcMe/MSik9xD4lDdFohqNfJ9rTei?=
 =?us-ascii?Q?9zoXwiijKIiGin0biib2xUg7GayVjk3+wQA7DnbGKNxIBCXCZK/nFfO3Pe9Z?=
 =?us-ascii?Q?b7aHDk1HSTcbm/L95UyGrn9SmI4LlcJD/Gy35Kq3D2z0W7Lr4xlTMNUj9si1?=
 =?us-ascii?Q?uAlQ4ZdlsopQs36UGGctjjD2V1MzF/j6pqsjTygRlKX1kxQBsKRo8+/QGrU3?=
 =?us-ascii?Q?vX1LhFHSQu6aMMSHQEEbAvoX1oczclld9hBrirOLUwps4l8YCAJZ6nXtb6m3?=
 =?us-ascii?Q?1bKw+/kPx6TUvxg/bGMu/NiEh3l8Ufx21PJF1JOApcf0L8hBs0b3CpG8E1uY?=
 =?us-ascii?Q?jTIPK59gRhaQx41uwlAtW8T2VXu346qhK0zbBWKBwqBPSgWvQAxhDpxrxfvq?=
 =?us-ascii?Q?ar76m6+fvQ2+P0cdsVEu7N7330wHMJ1Q6ZrCe/rbNxSmr3VJjg/hu+meevaN?=
 =?us-ascii?Q?fYwk01EGBBYyMS0bse71Dwd2DAUAyWflOhKfEpkVxGIU+31zhjujZ3JuSPzb?=
 =?us-ascii?Q?nBGJ79hYxuPde1/8GssrpvUfqKVubE0Cs9BcgXqy2hRo3W0PB6k4awJTXMxe?=
 =?us-ascii?Q?wZBeSO0jGYQBchb9OaZpOCrKSVwzIGnqzOjsr7sY5z6vdJMe/WJg0nae8zNK?=
 =?us-ascii?Q?kuANg+Kx2iHMwEwqDpNwVdgzKOqq4xpAO/c8uMpdjESYK4vG?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	VAdunxIVZBVR7OACQHFCyKkM6OPnSeNj1AnDaukJAmaiXiyef+xs9AA5ca61UjZxzCnjcFRMDWuYH3lVYSbgu5bAM/8YNaZzyMz7yrw0cigKa02V0UxUlVpakwC7ShmByPOKwf7yfuAYaD2RjVoXHABuh018qNRfl2wGBC2+oXIsBCPXDA3HtKG2JhZCSfcaBwlochBWBBdatryNcsEN8VlnfbNFhlcysD18GiKkA1PDM6Sf0ScXqmVCLXWGQr0/z1twZ7PSxohjmQ5UMWHGZh39AH8vfm2sDa/SQyqTp9J2LLKXfP1InD3b/X6k67sk5Bl/8WEj7JCjP9/bsGBOJw==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV9PR03MB8414.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fff7a012-bb3a-4971-1241-08df2dc08d37
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2026 09:08:33.5975
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U+fm8H6wU7nqNNk9CU4EPaRUPiuokgpLpdfVLDMVI+bE3aHfmsmhPnVHFHNE2mK5o48SjlEvs/8bmjgR1LL1cQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB6367
X-Proofpoint-GUID: Sdu7Spc7_GhqtBcLlKDECWhXv_8wkhSW
X-Proofpoint-ORIG-GUID: Sdu7Spc7_GhqtBcLlKDECWhXv_8wkhSW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDAzNiBTYWx0ZWRfX9M0JZI0cMhE1
 0nbhTDC+zWgefiXVbhriKQveG47B1oFlUSbtFnZ3q/5xguxpS8cAqWt73MenviadiCTrdvKXdzO
 oX/Rw5zviSldugerLGJYc4zzvO/d30EyYLmn/EUWaX4Q8DO9K1+jOpNxm5OLfdLXy65qAQ2z1on
 cQEpWGR1AfbEMCPnfQ70OfieucQDncgaG5JwWHj+duNr3fGt67Eoj7t6tgoJsN5lkOMJ898FQ/3
 6OGFDO+nJPg63zQkb5xcS5won9Xi/LR1MFegVY/MUyHU5FAIj+LfpFAqkJ09UPi73MMQdsS2GZf
 8ma3Rxb1ffxTwq+97zBZVYxUE40hEaIRNF8R9dmc+IuDGSuni7EKpd4f2zVD4fNIpzX+GFFe6UZ
 OWiCO01+NjYhf0F0LUUw8RXYenK5Mn5OHSliDfVDlLqRLwX1dT29MRNqp0TFgAC/hCx0CyvUE8i
 3RIVHf32M3ENit0Lv8g==
X-Authority-Analysis: v=2.4 cv=E7tYNqdl c=1 sm=1 tr=0 ts=6ad5de16 cx=c_pps
 a=68eZn42HhoOzQwLNwT8gAw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=uXIjobp8t2wMuQ0fPvqm:22 a=VwQbUJbxAAAA:8 a=gAnH3GRIAAAA:8
 a=i1WeTDtiQ2mZrwD8FjwA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDAzNiBTYWx0ZWRfXwcrqUrqsbiV6
 chCI4UW/ULuBFWmHy2RTopV5AJJqpw+2p/KbEgUU7sKzFmB2Cmy7ICy+rugPKNZ243eANCTlJC9
 wPTI7KPFiheCfziBTQa0IH71K+uyEOiFGLzJvrF3lE4S2MUAXMOF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_03,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0
 malwarescore=0 priorityscore=1501 suspectscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610190036



> -----Original Message-----
> From: Jonathan Cameron <jic23@kernel.org>
> Sent: Saturday, October 17, 2026 5:03 AM

...

> > Add support for an optional external clock (clocks property),
> > selecting between SYNC_DIRECT and SYNC_SCALED modes depending on the
> > supplied frequency, with the internal 8 kHz clock used as the default
> > when no clock is provided.
> >
> > Signed-off-by: Radu Sabau <radu.sabau@analog.com>
>=20
> Just a very quick look as I'm out of time for today.
>=20
> > +
> > +	/* Default dec=3D0 after reset: period =3D 1 / clk_freq */
>=20
> Why does the comment make sense now but didn't before?

Yep, this is a double standard... For USER_SYNC I chose to
write the full state explicitly regardless of its reset default,
specifically so the code doesn't depend on that default holding..
Dropping the comment and the assumption: I'll read DEC_RATE
here instead, same as adis16607_get_freq() already does, so it's
consistent either way rather than picking and choosing.

