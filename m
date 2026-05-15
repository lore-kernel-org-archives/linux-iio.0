Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEFC83016F7;
	Fri, 15 May 2026 06:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778827360; cv=fail; b=MkO2Zxg/uFSyzYGmyPJ6aYdpfu5wodlHJLiXEiESJToYhX/jvZVTDrEPv5TQGSrcCMkEYj/UV+lUgoebTe01/V1YH38nhOlgBwjpTwc8Hhbaov/vyZ0dTqFFJvi7oZPD1+zNmbi7JuHr0tQOdTw0VQ3aNzu2MRb5ad4614NkTZk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778827360; c=relaxed/simple;
	bh=JYX5DmVUj5YFN1+yCeA12ZoF0x/4LHulz3Qz9oRlS4k=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cxardRuKTafqx7joxA+2083aaVtw2PyKUCDKUGIC9/ZGgrWHaBu5nqqEC0z+iKtn6//neFw7W8ICUKE9njf4PUN/nIZyCeC2X/XVlNUcVk/gO5u1897vBiGST2XnUC6YzFeYVB0cGKbjkEd4MKdZlK+gGuHLqhgSajGHJhfouw8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=LkRlsVJw; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="LkRlsVJw"
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64F2AkWi2142600;
	Fri, 15 May 2026 02:42:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=JYX5D
	mVUj5YFN1+yCeA12ZoF0x/4LHulz3Qz9oRlS4k=; b=LkRlsVJwn0ThvcqovwlHw
	ICH3l5GgCwCCoiOQZaIIN9HQnIfnf60Dz4kA66rLbV3nCJaf9ytBVPRTi3xabnEF
	u+O04suxo/N3xvr49Z6OawZy+rd8LFAFPdYJV25++DcxRLM70msp80o5ndoqCHrv
	G3rSYhEMZZhh0x/l/EakyJlXpJAyS0XhUqbBHpLmL+gTVO6m33AO3gZA52r8ALnN
	OTOmCzQNRFh/suu7H5nrLmjaI48s8KClCrdu387TPUR68h7JXk0MZ90JF1EzvUjc
	egxCllZgebR3NEg+lBQ/Fag+kp3NBcpNOv+Yp43c1stRymU7QZqjEUX+NTGuzBi6
	Q==
Received: from bn8pr05cu002.outbound.protection.outlook.com (mail-eastus2azon11011044.outbound.protection.outlook.com [52.101.57.44])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4e5m30sr7t-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 15 May 2026 02:42:34 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KI4x1AiOGeTce2QEj96UJQnXBPSL1c2bySdQ+1eOu54MhUIVqygz0EuOTfHW/TFUqowLuvASDpHUoqYb+i0uDzPcgDXrOtKMGDD7UYStKD7FvLMDuR7FOW5ELzHXAi+tg+/rB9fPzZ0WtjxZuxI8M0WRsyojQgkzgXh7f3Zx5M6epcuhXGYTqNaT/uuz41131SRi/vxppXB/0cuEVanD7q1ZJ9LjWts3Gkh5HEQQrL0GGmog8X9xYOFITaHUQy2SYPtafBFmpS59Bw7jT0N0MYPe6nYbWbp0GjXtBAQPvgC6pphEQ2ck/M25EPV/ZMPg/QRCINNmN+2Ko9kbgrZgeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JYX5DmVUj5YFN1+yCeA12ZoF0x/4LHulz3Qz9oRlS4k=;
 b=YVq0ZfKaqtMsboVCTSjzHZgwCmKX5BCsQDiPG3nJI9KQovGtscXQHQ8So8nXkJlw5S0eLjzumQGiz+t1xqhsqpfgWtf6z9vF2fclDWmEjI/k+b5v6OsuUur22kslskrctUqtSrcH1G9ozFg/tnJfr+OoVIlyUhaFZKAy9o0k82gm/PjiPVEVY1vyn5V+wojqDiVLqrVHCAxv+swL8FJz+7a4d3G7DQbQeIWu/yEr8tI2xK/2Hz0dZ3TBYqGjmGmt0E2d2R6gCtpogxfl531uCRuwNOHVdnsYXrXaJs9NmaBad1DMTn/KmzxwnMtKt6awJY4gQvguHUfAaUO7+HXzMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from SA5PR03MB8377.namprd03.prod.outlook.com (2603:10b6:806:47d::22)
 by BN9PR03MB6140.namprd03.prod.outlook.com (2603:10b6:408:11d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Fri, 15 May
 2026 06:42:32 +0000
Received: from SA5PR03MB8377.namprd03.prod.outlook.com
 ([fe80::9276:9909:1b4c:8438]) by SA5PR03MB8377.namprd03.prod.outlook.com
 ([fe80::9276:9909:1b4c:8438%4]) with mapi id 15.20.9913.012; Fri, 15 May 2026
 06:42:31 +0000
From: "Stan, Liviu" <Liviu.Stan@analog.com>
To: "Stan, Liviu" <Liviu.Stan@analog.com>,
        Jonathan Cameron
	<jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        "Sa, Nuno"
	<Nuno.Sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
        "Hennerich, Michael"
	<Michael.Hennerich@analog.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Miclaus,
 Antoniu" <Antoniu.Miclaus@analog.com>,
        Francesco Lavra <flavra@baylibre.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux
	<linux@analog.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH v2 0/7] iio: temperature: ltc2983: Add support for ADT7604
Thread-Topic: [PATCH v2 0/7] iio: temperature: ltc2983: Add support for
 ADT7604
Thread-Index: AQHc47DSAvSmMMQNREqMjLTaf4uNQ7YOoGAg
Date: Fri, 15 May 2026 06:42:31 +0000
Message-ID:
 <SA5PR03MB837749F07B89C28B273CD64CF6042@SA5PR03MB8377.namprd03.prod.outlook.com>
References: <20260514144712.64374-1-liviu.stan@analog.com>
In-Reply-To: <20260514144712.64374-1-liviu.stan@analog.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA5PR03MB8377:EE_|BN9PR03MB6140:EE_
x-ms-office365-filtering-correlation-id: 30cdd610-066f-4aee-2462-08deb24d238c
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|366016|1800799024|376014|38070700021|921020|56012099003|18002099003|22082099003|11063799003;
x-microsoft-antispam-message-info:
 ibp/aZ2KSKll4uq1Nz8VhxMvOVYsMzeI3eKvISg1X4IhTx6kwxLMEwxde1gkXZoatwyLBSN+E/yAyiacBcmhjhRLwN+OQO2uZuc2rmZYrrtvEQBpBe50iO1O4+IBcWwivh+33fHbKSnIB/EaxK1MZC5dKi+7ID7DrbOmqiqk0wE88BDFR1O21rKfq5MMGkw9Nr++jMzHpGQ4pECUyAwCNGlVRmG4MmqxF98BsjMSfVCvv6OcRDJD+gqDENmkYEbzoTVAt9E9K1knSlUOm1S1gRYI6CP+GzQqSVFNlCVDATmH9CZ4EgUlwEAFGv/oJyoG1KfAVpkcyGjKh1+Wq0klfvMjpAX9+CwzpT/YdHqRrmWPHM9hBjNA7UkJmAnv+anGB+02g2d//5CwMnyRgQRj9jXMUScNyfluVOAImymfZ2ZErFjYZEsn0+Zj1xU13Oop2rAQEePV0+9QQP+bd4bvvWOWcl0jCkXmzZyP+XySu5OfxXQrF9mLFfT99iIiXwyQ39puHtTaiICOu7YnS2WguROx+0gqeazGSzGrv8/+6XmtQejD2U0xWCL3qqgkDnmVNB8v0ReLi7lUVHBzaapuly4aRqK75nW7uP2AP+X87DrPKSnt2XhWTr7PwTLMLDgpoYxsHaVCSMhW7aSflJu445sd/xaF7n51YbcjSRYIs2TTLth4rY5A7IgcWjMATslszUNuvTVhpRg+2dac4XiMIlicpWowKcY5M7Ag0qgKwL7md0T5Fqw+h/sNNUjLDAJjGSLQWIJI/JEIIJkl5BNztA==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA5PR03MB8377.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014)(38070700021)(921020)(56012099003)(18002099003)(22082099003)(11063799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?VIwXygWhhG5GiWDCmhINTEJzQGjJChnuoPLrP4oBsrEroalZVBPewME+GqwD?=
 =?us-ascii?Q?Ju4rT/l7oI6HbyWyBieeoaUtIdJmOFkdeojuQnCEH/J7jdhPOrAK6rQs3+da?=
 =?us-ascii?Q?LF36/tTtmCYn6uEeWom3d0q8gZlOQxgLgZMvBkoms9IfRNrnRq79UQrUdL1D?=
 =?us-ascii?Q?lziod1OY7fi7t5/FlO1If004HMAmnV1Z0eWASFGoHh6CCG8nTWkFlwt730ws?=
 =?us-ascii?Q?VKFHRNPyg4Txy9EXsiAy/DNjCqSu/RnDLM7FIFFz2e8Obk265aPkMkN2xwY1?=
 =?us-ascii?Q?n8ACeFn7I/3FDEeVml/VuAVknZ3R3zBEbr1vYGD+8pfrVU/sB2gRTQ7OxQ36?=
 =?us-ascii?Q?4yMpzWTr36hunKsO6fH2l8bYsHcFF141kBVWait+m6O+chXhvND3+HBafVjg?=
 =?us-ascii?Q?m5l4tRY2UUxCNmHDdMKqMp6ZuTYJH59IeEudX8deF+bEf1joxl3s0O1dLpRX?=
 =?us-ascii?Q?zWUJmK8YBtTDTvn3J4c51qAPCLN3KP/JzWppmwL3tgwSfqenoRX1yjx0WWYz?=
 =?us-ascii?Q?rJaRY79TaHHuTM3rdJ1f8mXspkBlFbACVA/pVbDMqwhNhQ4qJZljdTsTjpiT?=
 =?us-ascii?Q?ndrFAoLm/fa9VWuhoOHp2yUy+U/kioy4O2hFgtDhNzrx+Boo3D8fJcEhkHkg?=
 =?us-ascii?Q?apFjsNd/1O48KDvIvn0BPupQcUDINC8pUCmDJcu+KG0WhRi+eU4FhMyAbLtJ?=
 =?us-ascii?Q?AeI5mE5Q4tMUhOwAJkASi1kbyRbWjVHqkMu+DWVZhLdd/t3dEWE2pXBI898c?=
 =?us-ascii?Q?7j3RstQfQ6Y7rg4M02BTPGLDCfP4rQeZHuP7mq4Nl0mRoAozojMM+J799MzT?=
 =?us-ascii?Q?ftwiWaApsXuZ782dVPH9BBoaG5RaTuWvl+ljOoovAdz+h8/lfW+eyl1z7tUA?=
 =?us-ascii?Q?tsalD/xiwZskIS+PdFTVZkUue3/khs8u2w/+PRazLwJWrGS3R0a7cUrr2Mju?=
 =?us-ascii?Q?+/Bpr5rsDJe5l2vXJfN5W8F+Ag/i0+kUB9ng9UAlQBArojnIAPciSVNrol3a?=
 =?us-ascii?Q?GxJvn85y5FbCXreDq7wJCQENOtReWF5Fsv9Crlyi5uZ0Q66Q8f4n60rSV03k?=
 =?us-ascii?Q?zxxuMCHIbM9GjO6XmuosD6mC4/CsoXwgrwI5iVxPc59K6JU/nvURKoRi4o2W?=
 =?us-ascii?Q?q/GMl1Nbk9P1kPN5H4ElulAeYyufNaUwL6Y8PPsJ9SsjslzynYaBsLaqPvAM?=
 =?us-ascii?Q?0Lszt0Rfsnn/oA1Qahjgi4bW0Kq7urkdyczPg20iUWJNeY/+vEsL1DtUIIj7?=
 =?us-ascii?Q?YA/iGr49y9eUSyWXOBpvB3kz2fg5/sZnrJGO8PxQBP3JSY1H+CENvZHslkAy?=
 =?us-ascii?Q?uzsKSFvTVSqwVHP0oK+didJacSyQ0JmIsAdHI5+I2TgNGUFjByiDKeGa/GMr?=
 =?us-ascii?Q?n5wT2manhqZ+Or8g9MJLtg+BQZYHK5QumJqm1ByOeguB1KXVUn00TMudIjDC?=
 =?us-ascii?Q?5uIZrD3jDqpeqD/49ypYvr+XytigKyJnFQGps7e8JIh5q7Bg9HhMePFRTCww?=
 =?us-ascii?Q?G9ymZsCd3KBokZrtsHXTUXALkvx2xA+ajH/519bDvVWSeEluGOZa4gLdXP1x?=
 =?us-ascii?Q?G6nyLnTJaioJyhIks3r+/GXIifzRnJKE3Sniw8phfPitnyExzKQfsbHfs4Xz?=
 =?us-ascii?Q?Rs2NXJYfhxdQJiq7l+wa+6+Hsu9nW6JRoL/efEzXZnCDg771EgwKU4S0Cdjr?=
 =?us-ascii?Q?Qk9sWQmgdqT9u2b1ic6rkovjNk3AEdlCmvtIpVQX4JEC2miRTWJfUkNxzATj?=
 =?us-ascii?Q?+YV3hQZtpw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	mH0WedarftjrRsKbNIDqsstNdiJPVSEFswAlKBSXtjvGbMzWhWcaEjQmuMtUMlrvrZi1K6sk1uwfstLp6AZYhnKFiXcWb8QJWScd593U9v0w+gvT0AUV36bOhvZBe+54Xf37XxLk81gR47HhBhRcKSjjqV1xDAMOfE7iQy6nrWdJJ8Kiym6WngbM0zV0So0HK3wMxNOFFVhj4ry3AziJ3qQwMiLojeXDd3r/VCpP132ruiwQ0KC33Yf3/5s9r/oRB8xgDlr3NtyB+lwmB5EYhPH5wwdSBzZ8SSHs0pbAlWgZphOeitirWSQL/x9csxURw6R7LFIG/veAZSaYs4cnyA==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA5PR03MB8377.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30cdd610-066f-4aee-2462-08deb24d238c
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2026 06:42:31.1194
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DNkpTIbI3nnPW8Qegrf+Cdiv7cezfpJ7ywbdZ8hXINWkprPU7r9WqRwliyf4KBi2FQiIJ2V1tpO9LtOeaDyIkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR03MB6140
X-Proofpoint-ORIG-GUID: klUhCJbYpcpMR5ovtoMla094eqDdV985
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE1MDA2NCBTYWx0ZWRfX/5esTrvAz+G2
 YDcVf3IrPVhgXHRbnddhN6AuNIl2aYnhYs6yLAeb7cUA3kCF+YSYzrhfz8NEPq/ztjsM0EKlKSX
 qSVveezvGsz58RKoHtndbk48JCgq1TtNVdtjnExCdgv9Js5wOrj96rWikIQE2jyc5t3OwB63pB4
 QXf8TC5zWc3ej9y4C428WrI+GYYIPVlSbi3+P49Vmyq8xyxrI7aU6tt7pdj+TCyKil2O1qrCLSE
 c6gE6sZRknbgJZhLIvAlbM5FC/eZHg54Yq+Py9HQUhm8TehHMRyjusSBcKi6wHIjr6r23lqexsP
 WcpROhTgeAuNI0UO8Bcci/4tyqcH1jO4kKnrGKrtcC1ox37sqwbt0u6yjQM68a0PrEgF+EcIfRD
 +gmC2KwCNGqhG3pk1XQ2RxC6xm7aU/uupTeSYtWsvc+cjNvYbdocwrNG5fyFLFjYhpl0DjFd27S
 AhCCr/1J3/nvqEUtIwg==
X-Authority-Analysis: v=2.4 cv=F+hnsKhN c=1 sm=1 tr=0 ts=6a06c05a cx=c_pps
 a=gloqVtDXM1sObRb+4R+w3g==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=_jAD5XSDOtq9-5Nde2OG:22 a=A4q408E_6uStS4D_o-oA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: klUhCJbYpcpMR5ovtoMla094eqDdV985
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-15_01,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0
 bulkscore=0 impostorscore=0 priorityscore=1501 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605150064

After taking a look at the sashiko review I have seen some mistakes:
- in patch 1, the base_reg identifier declaration is missing, this is
added in patch 7 but should be here
- in patch 2, in __ltc2983_chan_assign_common, the dev pointer
is initialized but the modification of the dev_dbg() call is missing.
Same as before, this is added in patch 7 but should be here
- in patch 3, some "chan" and "chann" occurrences were missed
- in patch 5, IIO_COVERAGE_PERCENT should also be added to
the event_is_known() switch statement

These will be fixed in v3, but I will wait for other reviews before
I send it.

Thanks,
Liviu
