Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF2B2AEE4;
	Mon, 23 Mar 2026 10:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774262408; cv=fail; b=vCVPOFFhV1tmu8o4f6OgIs89SW/AjWU0g2LEZgg8bE2h4BH4qrxLSm+Mgb1TmGRjldVDsxHid7hqbiF/vsHskeGFXUEratkHUpUZrx8kcbT+PauRWQIcVOkVE4H51qAHA5kzKGkjAtCu7WbMurLq757czMho3SKsdPz3hvljzSs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774262408; c=relaxed/simple;
	bh=hoZ6HdBHkBlpa586A5Hk7t3R7QNnJ9OHf54pOJvwvBY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QeMDcSaDM64mbxLtZG0FeVtWQNG+HYOq1RN6TYmBXJyszk5r/dINUV8MNRtN7FkXCRUJaJM52ZZlEyEgnz0VZMH2GwNL8Ur0tFBiTNsMc/+3fp5vGOE9MT1JBvRKehAYFFidhs0SsFn73xZEgLurevfA4Es1TW3iaWNt0oJkigk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=Jq8lDANK; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="Jq8lDANK"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62N7ehlO2959663;
	Mon, 23 Mar 2026 06:39:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=aJFVn
	r9CfnLGmeAcAtYjR/lQ4nahcLYuDvinlq3AyHA=; b=Jq8lDANKiqw1Iou3a9/d1
	IcIgIt1xXrfXX/zlXXK+PMLWOrHHzFb+TVlZlSjbWMnLfU68ZfO0EFfrpTSGVrIw
	UiG8F9cUaG12qPHUlIb/4ZKm9Sfdji4Awb6CSEHZ9sFCDjJDxvIxiGYmD9cE1+fG
	c1YSR9eyfodd7gQn6RXsscuHBRzyucusp1eYUIFFDoUlttdjlysXOX//OLFqdIx0
	WwLdA8WtPxnGf/02n3Yj8pIL6qDuYqJyoj1lWLtjACnk3JtL7c2tx7He5eFvMvIF
	tOdcywzicRDPD0u1N2Ax/EzHhnlnHNGAPDreezu36d5Ik5D4v3u1AeXRpT/FPzru
	Q==
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012047.outbound.protection.outlook.com [40.93.195.47])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4d1r81xh0s-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 23 Mar 2026 06:39:47 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G6oOeWKR//OLVBlHyOYwDsgq+DUqbHncI85u93H9UEQ/xYxTx9hyHvYic+rLMGvursZlkzYAJhMqb6zTQfhoTeskKuzi+CHOWQXdjebixIZRN1uAyMObR9fTIH+k32pzu2dqJwy5h5DU4QnMeQshME7vvmLRvqUwSXOFKwEJ3Azpd/thXz/KwlMR2n1qIDT3XB9bhVy1ML79hg4Lp56qTeGjHh/nVuC8RsO2zvMv27WAn2ATRlGIYtq/HKl4KrMhM5MYMCjYQoSMlpg2/mOdqLn4Sc9t+uA6IDfLmr7suRv0gkoTY5uNrXBdxgdHtXUZPP0o2ObgTvuc1mfmCk1k9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aJFVnr9CfnLGmeAcAtYjR/lQ4nahcLYuDvinlq3AyHA=;
 b=N6ektftcql8gxUwH4lpq4yOvlYyhfKkrZNerfipXnVW3vFjqm10jL5o73QJ/BaEsNp/mmvNBFxZKyBkXCycE+0pQ03/nxLAex8dMGUBCs3XWbyztbquoTrpBDQDGt+Zg1pC+6cD+ocTqk4Q/62MAnuRkV9e+ORGmmW7g36bXpOCIYgY8iWOra3Hv2JyxdbwqCrW48NSqVxnHiIPXUmOsl5Z8cD2K4hEsEI1QGODUCmgKoxpWtvUY+SMRNn4EEUTHCYSuv+dRHuP6RgTiiDs+OG3zztQz+1FQwE7zfiXl+6gJxOcIOcvfoFIZSmrp0CEwI5nTV4xE3ZSaNUnqoNMUYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from SJ0PR03MB5854.namprd03.prod.outlook.com (2603:10b6:a03:2d3::19)
 by SJ0PR03MB5568.namprd03.prod.outlook.com (2603:10b6:a03:288::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Mon, 23 Mar
 2026 10:39:26 +0000
Received: from SJ0PR03MB5854.namprd03.prod.outlook.com
 ([fe80::d56:f47e:e473:97b0]) by SJ0PR03MB5854.namprd03.prod.outlook.com
 ([fe80::d56:f47e:e473:97b0%5]) with mapi id 15.20.9723.030; Mon, 23 Mar 2026
 10:39:30 +0000
From: "Jones, Carlos jr" <Carlosjr.Jones@analog.com>
To: Jonathan Cameron <jic23@kernel.org>,
        Andy Shevchenko
	<andriy.shevchenko@intel.com>
CC: Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        "Hennerich, Michael"
	<Michael.Hennerich@analog.com>,
        Liam Beguin <liambeguin@gmail.com>, "Sa,
 Nuno" <Nuno.Sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>,
        Tobias
 Sperling <tobias.sperling@softing.com>,
        "Marques, Jorge"
	<Jorge.Marques@analog.com>,
        "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 3/3] iio: adc: ltc2309: add support for LTC2305
Thread-Topic: [PATCH 3/3] iio: adc: ltc2309: add support for LTC2305
Thread-Index: AQHcuHilvt8kxDQYyUO6A5PZ8QUKj7W48raAgALz9pA=
Date: Mon, 23 Mar 2026 10:39:30 +0000
Message-ID:
 <SJ0PR03MB5854B6F86E441F18E85A9BF3F44BA@SJ0PR03MB5854.namprd03.prod.outlook.com>
References: <20260320140819.191700-1-carlosjr.jones@analog.com>
	<20260320140819.191700-4-carlosjr.jones@analog.com>
	<ab1eQ55b_8JiyAGA@ashevche-desk.local> <20260321125417.5ad7622d@jic23-huawei>
In-Reply-To: <20260321125417.5ad7622d@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR03MB5854:EE_|SJ0PR03MB5568:EE_
x-ms-office365-filtering-correlation-id: 45a62235-6f75-45be-ce00-08de88c8770c
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info:
 D4AVkYtC0wA6Vod2jvSiPZwv3QVmMi2awftEhLlbKq3neLlDNIob6AMCvERhCEWUOZls0XxcICH6tvEDYgEF8Fl8AKet40zJO89ZjainJnj5CKfIasVfOMRb4Jup9++9oiNBk+NQnJNHtNA6qFFq6Qx47nzxatiaszwvlpzMFgFls0BG8dujzybiAB4YyHzNN6VIEFbgFGkLbYgspQ0UQB27HUyHj+zqT06mfZpVJJ8BiSWFXCyVWcjHtUmT93+9FCn/NLMGBxAdm5wahrM77YY1vZ5aUmns4X4fY5qt2hPv2YovUHC6mvq4WikkNkOUgQvoA+QbnZAPwaPMODrHyp3YDDOPr/gmUrEeVQbYlE5KfwGEFN67OG4QqWqMF/xFpKxVl5BtN3chqxDsYQKZ8GRHweR0/VCHgU+sUAB6tJSmycaIljgljFhMfN/cajMPsm0MP0DTBJT7+qfBA5B9lVnhbJ8zvhWiwZveTaJI6t1UKiPbVX5PgkSJAcjEH8N0ethHYBX2Pg2tiwuiAGgIgYNrlzJU2pb64HNXnoDrbURredEIXwLYZeSbEN1mO7AYi+q5Zn40HqOsQvURn2SBRmCKctgXv627caQUe6LoHWBlMOfdNuSNhAD4mO1KB2vu4IXi92NTaE287fNk3tbxx8DX5UFrBWnNAFvSj3SkyFWdS04wpa5IyKbsA9PL7YahKRL5trmcScIq2j1u0BlToRrLoHJvoeZpY35gJfBwF4CtKl05DJ55BF8DPHkqr1FL4qixxlmMj8r6egg2+bQj48FloIKuC4aUXjJf7vEK2Ck=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5854.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700021)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-7?Q?cijCsCF/XeBudIbgMVd74lSFuc3ARV/2pnsZhroIF5pX4ttvwLJdmNlA4h?=
 =?iso-8859-7?Q?FIhNzdP7xlUEguBCBoZAFFmUO9JBCiJLcmobx+syvxNZB2cWtfGO0q2Tj7?=
 =?iso-8859-7?Q?eD/57QgjO9jN9dAc82XygLZwMd/jjhhyNj9DuXulKqbtWIwAbvQ0F5tAaV?=
 =?iso-8859-7?Q?IkrCVi2lwhcg8H+TDXPzE8oXhXQNjJCY7gBhDIsHM9BFQ9mnE9vi5vTyVx?=
 =?iso-8859-7?Q?Kzx/NzDKO6+aUys8mTLiQMoIyfVrGKvTy0P/GNxSydroIQwD0L40MadN3T?=
 =?iso-8859-7?Q?ubauqBEHfHe4ZpfMwjkNSHEcCk9YKVOpNco52uVk3F8z0v1hNj1navrKcI?=
 =?iso-8859-7?Q?FtgyYyIo4jEr+jOMmIIsC2xf8AqLsWKNB0WxxeVPN7XEKmr1eIWwxJ9rqG?=
 =?iso-8859-7?Q?9kbY+V+DTSDJNS1BlbqmmtlnhPydQge2NuXkjpPnTf95+GLS53zRWbzdUA?=
 =?iso-8859-7?Q?gmDlgWwahI9pX1Co+dQfMcAsCdESbTogSZP+aclJ6zl4k2I0LqVTx46Q1S?=
 =?iso-8859-7?Q?8ZIdtYN2cS2JnygqzWbkxl15dAcnHsIYrgd+WX9g3EVVUxpWXS/c2a80XT?=
 =?iso-8859-7?Q?7vOM8yHXj93ahHPQ0zox7hnVDfRLDnpNh/5nKoPJWD8lGHnN0ImeQwTK5g?=
 =?iso-8859-7?Q?TF/tem+T56+hDNT6sQ9vaUA8aR5cDT55R6BklgtE6WoKTFa8kb9Is+iXFM?=
 =?iso-8859-7?Q?lAkXVnEPVLl94P+VB1G3yfjci7lWKvDouWpdrN/imJQMQI2AYJ4a/mSLZs?=
 =?iso-8859-7?Q?6eJD00slMCmNNT7b5ibPUcHOjFzMu73F/SFG72FBitBgTexA5Kje14N3bc?=
 =?iso-8859-7?Q?u4xpFOdI1aWvAvnKfz1L9PqwMk77dHpNfVd9HzrazFKkylVk9OrgLq3vly?=
 =?iso-8859-7?Q?2nqKlDmZoHejNDSS7/DL2JunKsQS/DWMcwauiwaGg53ru5+cQrVf6gTstC?=
 =?iso-8859-7?Q?cX5k0HyUZMLJuRV5UvN0zoJzfclSgjX4ozXGn9kOjea6QaDTbJMDEe8rZx?=
 =?iso-8859-7?Q?O1funW0xU4uwh7JzItUdI1ZDqyc1wl4DgoTRA+79ryNoAyIUoifuwqPpxs?=
 =?iso-8859-7?Q?4y+/5i9ocXgDKbzYNw/Kckukk/vyHG5CxbCs4Gs5ztyIvX4ISHo0g11sse?=
 =?iso-8859-7?Q?C1u46Hg5rDa8yPt2dnnf4NKhSO9kfcJxZ+bVfjQOBmkFdW//v4AvC1hj90?=
 =?iso-8859-7?Q?4XDbyWNff5jP+V4MgRM7fEIB3tS4DNEwFh2gNVTiHwCU83Yg6sJj1/Wms8?=
 =?iso-8859-7?Q?OZK7S58X35qbZ8ip9SVC3EO+0BLK3U6HcxxJVIbgVf9H0X+2nyxtGVX1b7?=
 =?iso-8859-7?Q?p740ccqRHomCK99gDn8Pdww7/A7IZ3+7lJhXCFSO4KWoPkCXk8Og04FHiz?=
 =?iso-8859-7?Q?oxFV093fuuZH4ddQphCZtC7LrJHonqwb+rd7EtgG+hrQnSOAcbjDfMapf4?=
 =?iso-8859-7?Q?xTE5CR6hRNTolT/fdNJSuR8YA933SKHjkSQcvjEUlv63g7wV6AeGFGWFnS?=
 =?iso-8859-7?Q?mT8mbvjQbhwqBVclqlPpKGk3G1MvySdJdf3FHwbAIChXliZQkn0dKseuNj?=
 =?iso-8859-7?Q?nlimz5MUE1aXhZoXbzdZa2/M8GCc0YtVKC0vAsqt8i5q2mKkrhwGep4eBe?=
 =?iso-8859-7?Q?G0+k0bHRfuPESobDn/OK2bfR5XkD5gLrwnHzKay6DDdYzmtvR5S6p8vhxK?=
 =?iso-8859-7?Q?FVnQ5quh0J6/n6Oy99OpoQQLtWEH7dh8fFPTfKvlnjM0rAAQYuA4L4NybX?=
 =?iso-8859-7?Q?yHWgbyDs3Lk53jxHPTTgqiqKPbtiZwhvwQewfKtuUxgBXsXmyoHLtRF4SX?=
 =?iso-8859-7?Q?sIVrkv5AVw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-7"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	rcLMq5VHtDqzvdAcjwms6xugmpxCdLO+I98e4MXKJsGwKU4B/L4A7Yj1Rw1JQQfcH6encwAPfR7t4P1StBy46pug7dkjdZ6FIXr7eGDJj3qGXH5Cz45QijgA5WQkCTZ5ryIxSuXNG353u6gdgdTq768sYuiVJOt4TdgHZOHIaUFwC6Xkm5y2E+lTw04hbUBaUg/voAg2mYm+ZtNRrsgYsXOygRbv3EBMPs70Mkqi+nebp4ogOcc2/WqB3GECuIRsDWF9DRI5+hfgSvoVAhd/519bpkKYSvULehxMFlySpMont72idCLM4r+jGR2O2jcZ+mtYWR9WnP3g2wHkS15qWg==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5854.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45a62235-6f75-45be-ce00-08de88c8770c
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2026 10:39:30.4760
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mm95JV1d9E7MLookJXtkp59aSFDWxaNhuWFp1O481OtHOHYZq/ZzgFKih7GyKnYnyOVqZ+ew3zTQDIAZikPpjkxAKBQwk6lAKcokUeywPLU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB5568
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDA4MiBTYWx0ZWRfX5eywMC+4x9E4
 TNRMXv1h1VnuKnLliluX6A7VlJAR4VZwYeSoLw+obchJ+BBPxaaG/KoltLV/HymcaHaxw5Wqzzu
 MG9qqA7RzvOmv4jPZAUjQTbwsPxZ9BtpsYoPILSbzgNNqODT/++wi5B6ZEE5SRvN9YaSftqJjCg
 wuP+3cm0bvt67O0vVVKy76LDGrOywEyuotoEs5rcfGXU1oF0RKR7SzA/wewPQTTThfqbyv6DmMk
 kqYEED6xudfEdmsrVRz9gznIKpHD/UVodl7TAu6veXL9oiK1HsR+t5wzDZ/4dfsJ6Yx/b+by8fq
 bAYZcMLibS/jc06Nj5dOdXPmsPwhkuEr5+5gF0/9Pw+46NBvk8a5Y0zwVxkglzRpBT7+VLewtI/
 /4iYDm/YjtiwCuXb7kmvKCkmBjbG+/qBVUxhF3UUvnu7MQJ3g3y5DZZQNjTpdsATKJ8DTNoc6GN
 xRskYFp2wi29+b2Q9dw==
X-Authority-Analysis: v=2.4 cv=edIwvrEH c=1 sm=1 tr=0 ts=69c11873 cx=c_pps
 a=9cGrGZFDAlRO1ZcMJRSO2Q==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=E_FQspuQcigA:10
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=Z0pTeXoby7EwIRygza74:22 a=QyXUC8HyAAAA:8 a=zqRKxkC9yqYbu9RhneYA:9
 a=o3X3QV6JOaEA:10
X-Proofpoint-ORIG-GUID: Vue1luwmzLvf7j-sFVSmesfYDIM1j94h
X-Proofpoint-GUID: Vue1luwmzLvf7j-sFVSmesfYDIM1j94h
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_03,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 adultscore=0 clxscore=1011 phishscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603230082

> On Fri, 20 Mar 2026 16:48:35 +0200
> Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
>=20
> > On Fri, Mar 20, 2026 at 10:08:19PM +0800, Carlos Jones Jr wrote:
> > > The LTC2305 is a 2-channel, 12-bit, fast ADC with an I2C interface,
> > > compatible with the LTC2309 (which has 8 channels).
> > >
> > > This patch adds support for the LTC2305 by using the chip_info
> > > structure to handle the different channel configurations between the
> > > two variants. The LTC2305 exposes 2 single-ended channels and 2
> > > differential combinations.
> > >
> > > The LTC2305 requires a 1.6=ECs delay between I2C write and read
> > > operations, which is implemented using chip-specific timing to avoid
> > > affecting existing LTC2309 functionality.
> >
> > ...
> >
> > >  config LTC2309
> > > -	tristate "Linear Technology LTC2309 ADC driver"
> > > +	tristate "Linear Technology LTC2309 and similar ADC driver"
> > >  	depends on I2C
> > >  	help
> > > -	  Say yes here to build support for Linear Technology LTC2309, a lo=
w
> > > -	  noise, low power, 8-channel, 12-bit SAR ADC
> > > +	  Say yes here to build support for Linear Technology LTC2309 and
> > > +	  similar low noise, low power SAR ADCs.
> >
> > No, in Kconfig help text (and possibly title above) we have to be
> > crystal clear for user what IPs (chips, SoCs, et cetera) are being
> > supported by the driver. There is no go for 'and similar'.
>=20
> One follow up comment is format the resulting description as a list as it
> reduces churn in the long run.  e.g. how AD7173 does it.
>=20

I was informed about the 'and similar' context in the Kconfig to scale
the driver smoothly but I mistakenly applied it to the help text as well
instead of the title only. Will revise accordingly. BTW, keeping the 'and
similar' context in the title since there were 9 instances of it in Kconfig=
.
Thank you.
