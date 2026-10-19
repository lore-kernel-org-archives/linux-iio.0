Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F00848E0E9;
	Mon, 19 Oct 2026 08:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792397770; cv=fail; b=uhb+d3Yx6sq80717e8iPxIfF12JLhhBr29xN7Bk7ZeCLpSgR3vzvLucViqAAIVaFgDOeh9F2RCqKZziswCgNH1wab9b52KHywaw0JStAP3QfFrkff3YcAuMiiWyBmID6hgvHOITYO/QZR+SHauEhccWEgxkV02OrgU6PtnUqzxs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792397770; c=relaxed/simple;
	bh=22Z4yI6HVKg2ohPecqqtIKNdSdK/CkcbqE44vQZCuA0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TVnzKlEiJFr5fDmYA4V3+qes2MkHSAAJJZYsIgrbPsmBfEMcKgyr6TOA8A0EPfI+uGqE1zrlxHdV2urAKUTtSNaaaYT/kK0BMqgmzeZ4Q3WaqOuV/Ia3ORcwZ8YsPrKJ2rLlDwEdjpwg/vKxOTrbPR22w4SqJbqFv+egrhO7HCw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b=kC4A4tso; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=YwWzPg8/; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b="kC4A4tso";
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="YwWzPg8/"
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69J4hG9V208355;
	Mon, 19 Oct 2026 04:15:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=6MPdR9WdDn4teephhclgly09uUIvcirnhcy/LK3Yr0A=; b=kC4A4ts
	oSD9nYI1DfUNep+/7lc2+95iFqn3Ef9I4hwgg2tIg6CqPXTCmRd7oh64n3889yk9
	1HcedxgZUA971wAofVYLsNj2UvlsOsagQzx6Xc26KyN0tEbtUz5hFK1UFAfJ0ese
	NoEj+b1spaNUhin/9U1AX6cAE5+nBe9bYrp7iZqagO/e+t3m4xPfuJzF6adAqeDJ
	97Zn7jNDI8peDlm49Not5Tn9IQO2TounOvfDNpV0MtL2m3KmvSolMmo+IT2bfjhD
	NnPR3Ks2Bq5h1XPGVF6X1gKT0fswQO7+BYdSXwvjcAQ6wYhzk1XSRemabQl94lED
	QfeTsLrjr/5Uy6Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=6MPdR
	9WdDn4teephhclgly09uUIvcirnhcy/LK3Yr0A=; b=YwWzPg8/lOpV31EJ19bbd
	E3NkzmqKS49FumeQfVVzg6aquicvtRb+IxUP977JvkIkg4B4zcXGgMzAY3/v7CLr
	KqSJvTl7t6vW0VeBkzIMe+FUiahTMJoh/k9ApdpWJQ/5/oGZI7uh0bMMpXvynlX+
	Dz9ECWKvRCfYCZr5wN8MY4cMHbiWI8wwsdpzs7FxhAEgLuI+mlZgAZLi4E6MERaj
	1P0hsCq6xhCd1uGmONyP7swWRgTKFdCDM+NzBQqZsg8MnF9HdGHcM8o/nW/QbX7O
	W0L0AgZFDjaZqjCy+p99rkyb7gB3vw6LSwHVMflk8W08JpmEVUsG+5HIasIy7v9Q
	w==
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012035.outbound.protection.outlook.com [40.107.200.35])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4hd67mafu3-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 19 Oct 2026 04:15:44 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CxjY+N0zGAz9GukXizC924Mjpmx9Xiw+CZdVg9+mvTF3XC3P7USJeBY+JQAl4yVyhBE0JXoyT2G40DjdIrmORlhvDs4Kjg6whIgp5ZuoVuDb1wWtHJf49w9SJwQ4NzJioKhFbqzKwCvr1WwX71QkggTuACPfO5DH9qnqFVBC9jSdogRKAisq3vrvvq0woKwR+j/jB0pvwAQON8jG+MQ5mpxqWu5T+cxBEA1QuR/SXI3IHH/PAyAST1ANAkA2f10Qy3GTMzW71A6WQH/lWyag+BqGvAr8kFOpmSm6g8NM2W2Qz4234pGwSYN36LoR50s8AI+fVmabj3CHNAaZSSCmrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6MPdR9WdDn4teephhclgly09uUIvcirnhcy/LK3Yr0A=;
 b=nXhG66SyZRgwmZ5ch3b6tBtgQ9VuYCOatvIQbu1zOwgsjw6xUQByBT0vq/iIAIWuDwbr9YJncMwZndPqxqL61IfAZBVaIM7MdpLm1Y4kF+Ye8JrbUhgLZFPsYE2Kt5E0ck0kLqYOikphItVo4A3u/EM7YrRwDvJQ26AWUBbFTdiiuzlv2xZxugk5tTYtxI/q5zKrp1DfCbCqgUuW9xj+3Sl9OPVYUw2Jj9vSApmgOdDcuKHutSBcRPN+2cVwaz7U28b8rV/qnvKuCWgpSHDUnoP7KPG3woCgZbTrXBh7B55Z6eOI6NHRt+1jVZ3Xxk/eeFcNjtgmi77BQNzJ5vb8Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from LV9PR03MB8414.namprd03.prod.outlook.com (2603:10b6:408:367::23)
 by SA1PR03MB7056.namprd03.prod.outlook.com (2603:10b6:806:325::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.19; Mon, 19 Oct
 2026 08:15:41 +0000
Received: from LV9PR03MB8414.namprd03.prod.outlook.com
 ([fe80::d661:7c16:d052:cc81]) by LV9PR03MB8414.namprd03.prod.outlook.com
 ([fe80::d661:7c16:d052:cc81%4]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 08:15:41 +0000
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
Subject: RE: [PATCH v3 2/6] dt-bindings: iio: imu: Add bindings for ADI
 ADIS16607
Thread-Topic: [PATCH v3 2/6] dt-bindings: iio: imu: Add bindings for ADI
 ADIS16607
Thread-Index: AQHdXIgymkXDNMtiNkKlGjFz+g/bbLcA796AgAOJIhA=
Date: Mon, 19 Oct 2026 08:15:41 +0000
Message-ID:
 <LV9PR03MB841470F3A6677BA505411546F7982@LV9PR03MB8414.namprd03.prod.outlook.com>
References: <20261015-adis16607-v3-0-f972d4efee85@analog.com>
	<20261015-adis16607-v3-2-f972d4efee85@analog.com>
 <20261017021141.5b023e60@jic23-hlaptop>
In-Reply-To: <20261017021141.5b023e60@jic23-hlaptop>
Accept-Language: en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV9PR03MB8414:EE_|SA1PR03MB7056:EE_
x-ms-office365-filtering-correlation-id: 9a082f8b-f3b4-4d7f-b94e-08df2db92a93
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|23010399003|376014|10067099003|6133799003|4143699003|38070700021|11063799006|56012099006|18002099003|22082099003;
x-microsoft-antispam-message-info:
 er6TMrL7ZnoUlljKrvC9V9zeCwxgGzNJRVyURGSmtIoaF3gvN3IVP2WH5s3a/BHx72mgyKB7RqS0TES9VwIJP6B4K8LzieMVvwOzmz/ahb1DCdA4sVjNnCjPpc2nZ7J2Kd6JUxdtup9A3tUxNChnRRzqIJXrGbqnEJVYPqlr4J0I3jDGyOeKwIs9xC9bMUduZV29ZQ0FY2ZCznCgQS1wPozEdnfxkmrzSQaO+BA/56mp2vf6uh+zPjobdDc6/I4XRU/xMnXxoH8/gX3DNzjgwYJZ1h3SB7xs/8apTgonovx947TL1hE4qUCvTqkckZOej4Vjca5GOET7iwQx1NDIOrWbg+5hE0qHhfTU25wJ8WlCc7u0Jhhb1Gv/aQH+C48+c2pk6hEBAnv4krrz2yvrS2elhjYYhQJPNc4wUKi7UHfn5jcWh1fyFTofGNWs4Lnf9kc/7VVjzHbeVaUuMkbWDJpe3mCj/qcPnsdvecV90J529V3BSYOLQhNHF1ea2GTCkDiSgO8xQKnfZpzmiAkq0NRT78i+PWXPGCM0b3H6fskO33gCKLR2I4gk/xEjZIGlXURoLA4/+n1QgF1HdJAWfPsJPa7ljkLN4Vyu0Z69yreAKolCiUsp7RYx6PWannuNd5NuZQ+ov7gZwhIkiesb6aRXYubm9WmYwclnMDcuFdHBY63oo8H9RlWskFwDKjr9Sz1G6niWhVg+3/Jt4sPBbvHP0CVnkuZq9BOVNw+9vgU=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV9PR03MB8414.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(23010399003)(376014)(10067099003)(6133799003)(4143699003)(38070700021)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?RL8JNe3WyEMHMeSOd3TP/FhmErQ2kxpnZk9AFBKjI6c0fRHqQqbxPFcaey?=
 =?iso-8859-1?Q?S8ul5P6HuHaS0dlwaCR4hSu/q2BpKh6P1JJkv2tC/1ntmv1tba3eIfe325?=
 =?iso-8859-1?Q?4JvIpFtAUC5DTYlJmw0CPYUE1/2dMkZ7a3gVDAG9+BdKtAfvsEHln5T9cM?=
 =?iso-8859-1?Q?hRZDvw9CjNThF0zu3eKj60j1PPVZEIqm57tMZMtnAibqY0CggZ53Xd8d4c?=
 =?iso-8859-1?Q?xzGs9p29Q+lYfhfIsM1HQNTvCH24tZW/efzdU4nvCRb8pQhecIl5dF3hLS?=
 =?iso-8859-1?Q?H0+d4km0ijB8CW8LJ6AZ/QFgOtqx+Rhf6OR7RJthsXWLsDNfIukvg9mvZr?=
 =?iso-8859-1?Q?vrkKFr8MZHgx87XWbLVam4gjKu2UYD3pTNS6lQPZygqOcB1JjPblLnLn4b?=
 =?iso-8859-1?Q?p4ZveeXYi3adGTsVgAZOa7jQP/s5NsncoYD/0H8SvEDcvk7MkY8VCH5abK?=
 =?iso-8859-1?Q?TilNaHcJHEHf93mcntKxL3MLSwJkJDjLx/ZcVh6pMF1fnV6paFRXBTC/F6?=
 =?iso-8859-1?Q?kUh3ibSxhxkXty93PnoUNmuqs+MQ/20RsPh7NbDfoTw+tCifSvaR+2xzGT?=
 =?iso-8859-1?Q?l2Ije3v+Tl90l4doAQvb+Txna4nbLWMZN7eEkb6aLlTrprsj4ZfaiYYQDJ?=
 =?iso-8859-1?Q?4FrA9ug4ftcf7snnq8lSqDgEb3vXoUuskLVptmXPHRo8Qt5B0d5k8830hi?=
 =?iso-8859-1?Q?BhtaVwkf0oMMKFIyzlTWHOSSoGI01EoW58qOHj2CSkkP87WpvsRWat6r+4?=
 =?iso-8859-1?Q?7OkUQmI6+NfgQtDk3WfgQTuTsuq4RLEnH0n6g3aEXSNy2r9cWOcJx9A2pz?=
 =?iso-8859-1?Q?OhnK4KUzAB2WpQW3Y6Ra3sGjk19ypVJ3X2k2VzYSlV2m4aHWpAC5r1FHDj?=
 =?iso-8859-1?Q?drOH2LEvtQLge2NguqTvwPxwT8rArt15FWwmzEWejZaAmAdXuyhnnUpGfc?=
 =?iso-8859-1?Q?GJiYVYul8aldCMqp0XBB2P8YgGImaz2LLYhyuisOGOBbSJ/DaWico0P489?=
 =?iso-8859-1?Q?5mwO6VjQakYWoZGx+dfvod4EE4iPJKwVvaigSQ6+5Z/+36Ab9TghiIYhpw?=
 =?iso-8859-1?Q?9WnNDQ6araKXXEX83CSpKjI0HqZ5ZJFIKm2pBt/AjDfPq+CjwKyyz+ZHtr?=
 =?iso-8859-1?Q?lsG+656xjA5uRDMAWniFFFTCGfLZnDb5687XI4BonvDkpG4ZQfg+VsTGFZ?=
 =?iso-8859-1?Q?u2SHDDMyMZNsy1+7n+u48BKREIRuyNNs8MTSLGmqxMVHGRsg4M6ieLyKUZ?=
 =?iso-8859-1?Q?82sCB5fY/Iyhc+XSv2TDWeByQPMmsnIh6v+0vFwVMD9ZJPYAhu7oLZJLIw?=
 =?iso-8859-1?Q?DlKvXTvyCe2O1KDKKfngpK+fRYDUxhMxlcMTY1qnMw8xWTT/0i2Z6bxcKQ?=
 =?iso-8859-1?Q?6bOp9/Mpa/XtqdA9x/7aPUY3zjCOLFMD2rwQB7EF0tCP6THEOR3NFCJeMX?=
 =?iso-8859-1?Q?BuDqVu98/P7jQ/iMs548haKsb+vDhIga11IvIuij78pjbMTv+CAVlb994e?=
 =?iso-8859-1?Q?k/WMRKQ6Yd3TVH4+ABJoZtR1I5vkWVKsvKinQWvm3BZQMQWYCbjbdovaYC?=
 =?iso-8859-1?Q?XcKo/FFgPPzq5PZ4SdUeVdyUCdll1LEIZLm64/EY/nn/vkolXX6PBd/HVT?=
 =?iso-8859-1?Q?OY5+klEh95K64CLPcx0ZcZoHbsmr5b9fNWNm2Zhq45ZoDnRQyByHoF4pLH?=
 =?iso-8859-1?Q?Z9euxq848H/+I14jZu5pHUbLYiqIV62URIC5Gn+ft1L64dhZ5IrwaLB1C3?=
 =?iso-8859-1?Q?JUWngJYIiPGSso9J2+Iw6M/3b6EHhU12yqdJT7m9amZOfR?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	xKRkKde39xn8i22Ki5RQiblirIZZ9MwCGlMiu2ZTkyXccTV88gQzrp/hEHWv44IM3zbqn3S091yT0TyLYh0QQfMelhMy+3d9YBY/qqXlA6Xlc37D52USAl+fiMqevprokgInOoQ1p3QX9B8RbGLhVxT9yn+kKbR3zps2Gt6Txn4qm/8KUXCrGp9+ANnHx168LNuXho6RlUw90168HjFaFXC1Wh/A1Pp9NC+T2tXRKB27o0qdGBv9KUjy7EnRma/JlKgkrMctBcALtaS94x6yaH0Q+E8FjExHwk/iBGNrx3O9RyUesmTp41NFvJ+ebgc0uBMrATmL7gTka6OHbHWamg==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV9PR03MB8414.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a082f8b-f3b4-4d7f-b94e-08df2db92a93
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2026 08:15:41.6095
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BjicxpqiJRBVzAruXEavuQQBCdLJdI4uRJes+cRwMVsKX8j9YspxrmYWSidhqTRZWwi2CAAr9qJCydfQvKKcBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR03MB7056
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDAzMiBTYWx0ZWRfX+kNcTAeKC4kU
 jsfijoUB9szhAoXEYjUQbQdhmlEyO6/ULyMw3NonzQXTyotkR/hyt6IW3TwXCZqI821Py9rxJ6g
 F90J+hdPEQwRtudg7UxiiuUDQ7yN0HnhSvYz6uyCKkoDvokraXYMs0PL6Le+tbFjdxQlCYqFJ0Z
 WV+M2GLtvK3Rlk0TywctREZxgC87/oKpI0PMLjL3Newa287rq066/yJTxgVh0SS2mA3hxoWYJrc
 vc2KT1UDB9BC34ptvH72Gb+IhPMgSHdC82c9MEz4co4C41TETStM+B5Zn8giHwD6LbvBB2poKqS
 b/Q3mlLYFQ0easYncOVMHfuHln8bqBvGJFfAmb6GLKTrJnSjvHW9LCSoDlXRA/CC/E046XrkqVP
 Vz47ztGs5cXvUOJ9YvOE8bBuHMsgaabfw8SnRvwVC3HjrRQiMfyVISVmJeLDi9NAKh9PjGvgusy
 Nayjig78xiseDPRwprg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDAzMiBTYWx0ZWRfXzNxYdIHWbfxA
 x8vT6haJHi7gYyFNGw+cX9vU26TskqCxqTIO8MCC+yvG8mu91Td5ecZBkJOq5Xcn46Pspd68//s
 erkO5lFteMuwQkjGnDCIZgkKdD7paKdXK607TO2/g8CWW2T/3VTF
X-Proofpoint-ORIG-GUID: FEUES1vRTSGuzSjqVmHRXF-xFo_ch50O
X-Proofpoint-GUID: FEUES1vRTSGuzSjqVmHRXF-xFo_ch50O
X-Authority-Analysis: v=2.4 cv=Rt1QvymK c=1 sm=1 tr=0 ts=6ad5d1b0 cx=c_pps
 a=3Rvb9JmgCdrss5EpqVD9LA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=ugNRTJOwpmtT476g4l8T:22 a=VwQbUJbxAAAA:8 a=NaQ2NR9K_fn2bdKD5r8A:9
 a=wPNLvfGTeEIA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_02,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 clxscore=1011 lowpriorityscore=0 impostorscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610190032

> -----Original Message-----
> From: Jonathan Cameron <jic23@kernel.org>
> Sent: Saturday, October 17, 2026 4:12 AM

...

> >
> > Add device tree bindings for the Analog Devices ADIS16607 Precision
> > MEMS Inertial Measurement Unit. The ADIS16607 integrates a triaxial
> > gyroscope, triaxial accelerometer, and temperature sensor, and
> > communicates over SPI Half-Duplex.
> >
> > Two variants are supported: adis16607-2 and adis16607-3.
>=20
> Say briefly how they are different and hence require their
> own compatibles.

Hi Jonathan, thank you for looking at this, as well.

The only difference between them is the gyroscope's fixed full-scale
range: =B1450=B0/s for adis16607-2, =B12000=B0/s for adis16607-3. Everythin=
g
else (accelerometer range, decimation, internal clock, sync modes) is
identical, and both report the same device ID over SPI, so the driver
has no way to tell which gyro range is populated at runtime - the
compatible string is the only source of that information. I'll make
the commit message say this explicitly.

>=20
> The hardware rest being a configurable pin is an unusual
> bit of hardware design given how do we reset the reset pin
> to issue a reset if the device is hung?
>=20

I agree the hardware reset being configurable is unusual. GPIO0 is configur=
ed
as reset by default at power-up, so the driver probing at power-up is ok.
However, to answer your question if the USER_GPIO_CFG register is altered
by debugfs read or a bug or something else and the device is hung, the true
answer is you can't use hardware reset anymore and the only way out of this
would be a power-cycle.

Perhaps a force write of the RESET_GPIO_MASK before the initial_startup
would help in case the SPI communication would still be alive, and I guess
if the SPI communication is broken we would then get an errno code anyway,
right? I am not sure this is the best solution so I would like to know your=
=20
thoughts on this.

> >
> > The binding exposes optional properties for:
> >   - An external clock for sync mode (falling back to the internal 8 kHz
> >     clock when absent)
> >   - A hardware reset GPIO (active low)
> >

...

> > +  reset-gpios:
> > +    description:
> > +      Optional GPIO for hardware reset. The line is active low.
> > +    maxItems: 1
>=20
> The datasheet I looked at has 4 gpio pins. You are calling out one
> as reset.  What happens if we don't have controllable supplies
> and someone else (firmware for instance) configured GPIO0 to not
> be reset?
>=20
> Anyhow, feels like this isn't a full description.
>=20

Indeed, this is not a full description. There are a total of 5 gpio pins to
this device and each one has a fixed function, the USER_GPIO_CFG is
more like an enable/disable register I would say. So RESET is either
GPIO0 or idle to say so.

Would you say that a description like this would be more suitable? :

reset-gpios:
    description:
      Optional GPIO for hardware reset, active low. Of the device's
      five GPIO pins, this one is dedicated to the reset function,
      which can be independently enabled or idled via an on-chip
      register.
    maxItems: 1

