Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C51843905EB;
	Fri, 22 May 2026 09:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779443877; cv=fail; b=t5RB45MbeLfAr2XyY/YX6AhA1S+5ToUe3KZ5GeDxIdgE+zAkjeZfWKWLhzPN9GVYE3jqyg4LQ5PqfxZYcxGQCy8XeK4kEiExbvwoKruWplX1GKPXs9D2nlGzPvgFndm53sbxRlxj8xNLgq+XzrE1xvioUY6/AFGsgAxwReHEBZM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779443877; c=relaxed/simple;
	bh=FsYfr3b3chKHlL53MJTiiJvpnMfjLbuCZODO4eT/QZM=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AcrKj52YeG5m2i8lMCbpeM2xS8kdYQX8z9u05Fe0BN8exPUukjFYd4Jn9EJldNrwT4BlDYalT6Fj9eP4gQH9d3VkhBV4RIwAuV4Q7Fqw/SXr56s+gMiu6Fu1h3WUnwv34HDlDePgYdAW5P6Ias5CvFlMn2vN+R52hFYtmMh7vtc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=l2KcBE34; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="l2KcBE34"
Received: from pps.filterd (m0516786.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64M7FiLn1511118;
	Fri, 22 May 2026 05:57:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=GCq4w
	pKM6agOPELTO/BjYsDrDkYXyVpLrj+zYlyhUxo=; b=l2KcBE34XdMgWKJ0I52MS
	Vjy3GjlNjsS9mb8GUA/DTNoaXEWvBshzBZhAEw1VrS5A4w2PW/g50zlj9AvBN476
	ahntg1s+q7Hr7VUr3u0fCAS45y4Sqf+ccAXy3KXY6IRK+bwwLLmpeFErwqMrFlIs
	UgTWd1GB1yQ5Ti7jlfzQRPTUveq+E91h1EJs9XNvrqUUNaaxLFbkAZJdmqHcNJbI
	I6Kbfett+LtVoFUB0VqytTYi+KL6WJhZ+q8ICchLfK74KGLKxU4KGzxHhJGslOhl
	W5QjIHD9P9Y8HfkA4CyOAS0O4aCgcAQ7INMrrdHklf1M/3/aPeK7XoEX+w0M7js3
	g==
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11012069.outbound.protection.outlook.com [52.101.53.69])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4e9a2f8rbx-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 22 May 2026 05:57:39 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P9P73YMXdROPYIuipFMjGNpbu5gDTCIw7CFCQg7Ljo6cVWM2yTLJEXrSLm/sgYol8gvb3aYG9Up37MLzAKgxQbO1n97nAi+EUlsrk9kWh0AmWnGaNKJ6D45K+Sv898sHQmwxbmboOYL7FSpwIoLTYnqMsS5UvWLX3LNxfJQSRcACr7AeSHZRDBtfyOFMEbcE82DLHF4JCaOxfYgVdNbagU5bRGRLNyxgV91daISAiIyFGwVJUmsJl/CPsojHQGFrffjrjSeHdli61NCpC7KQtxG95mKIZQu3vRa12TmOFss6g8FLkkwC5vRPi9HLSMeP8ni4h5mn2PlvpKPQUT85nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GCq4wpKM6agOPELTO/BjYsDrDkYXyVpLrj+zYlyhUxo=;
 b=RGKQtQ6gz2zCUe2ySXPSq1S0lf3/QZL/gJ8HtzPdTE5DMd2sBadZ/oJk8ZsFN+46wci5UwV8r4vuGx+gD/IEEQZDrKuIlpRIuBXRek6jxxd/tMS14rDZ7Qh4Gg+EhAHmtJKW8gqc2i2tuoDMv+4AUyKxVaq/P5RYMAo10DCUroItDfkMjWtAUGFa/xorzsBjdcrc7vB605K2kUQouHKdr5+4zwesOveuJOveyy73d1Mi0kNZieCk6v1HWqrqubdiW/USIebUfi5EtuTUQ1edQVWwG6+gF5iIeytwxhXZakZL0M71RgIh2GT0eDjP5wr085xE+v8GzziyY3s36XIeoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from LV9PR03MB8366.namprd03.prod.outlook.com (2603:10b6:408:368::16)
 by LV9PR03MB8390.namprd03.prod.outlook.com (2603:10b6:408:368::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Fri, 22 May
 2026 09:57:37 +0000
Received: from LV9PR03MB8366.namprd03.prod.outlook.com
 ([fe80::b6c5:a618:15f2:c6eb]) by LV9PR03MB8366.namprd03.prod.outlook.com
 ([fe80::b6c5:a618:15f2:c6eb%6]) with mapi id 15.21.0048.013; Fri, 22 May 2026
 09:57:37 +0000
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
Subject: RE: [PATCH v3 6/8] iio: core: Add IIO_COVERAGE channel type
Thread-Topic: [PATCH v3 6/8] iio: core: Add IIO_COVERAGE channel type
Thread-Index: AQHc6UFZoJz8rUV8Akys6gv6C3wpo7YZzpgw
Date: Fri, 22 May 2026 09:57:37 +0000
Message-ID:
 <LV9PR03MB836651F17C370CA9D277A8C3F60F2@LV9PR03MB8366.namprd03.prod.outlook.com>
References: <20260521164323.770626-1-liviu.stan@analog.com>
 <20260521164323.770626-7-liviu.stan@analog.com>
In-Reply-To: <20260521164323.770626-7-liviu.stan@analog.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV9PR03MB8366:EE_|LV9PR03MB8390:EE_
x-ms-office365-filtering-correlation-id: 9a6e41b8-eea2-4799-fffa-08deb7e88e2e
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700021|921020|18002099003|56012099003|22082099003|11063799006|4143699003;
x-microsoft-antispam-message-info:
 GZKnoAy1R8Lk/YKZ0jbuegnACGDQStuvYiDI81LDKwJsljvUgl+l28aYnZSdg7q1skJppN+fSozW8HMwqiTyx1GUk5fopChgs1NxaPhA7fQl2D72gBk9m0tJEexgR2HUqMQtlZh164cfydFuFlMDIWeRePjpQnYFq0XCyedy0iIBf9YC16KZ0iCxRlUEhC+PkoKj1SRS76tpitiQqwP2/WlkYkU601wLArkdWls9tLng+eOIT+gQl6BI3Q5I+QLMMtBkx6I7M0MbK69OXfzevZHxmPNVzB5hjhQHHcM2EmkCcV9wvmFEQPBr26ZOC0yg5eKzQDq7S0MaZUD3TiGHFS+Z0FK5Q4BiBeKiNY0U9KVGB7QvcUM6v4UA5twYn5EJIR+ccU7I6xwjXpmhc8UOXKRM+X3O/lo94mGIXtNTXzHPOlSqkVe3gV1igrV6tycrGm8zSqZbSK/ot4ixJNjh25JTSWNux1mzBMEcRQ7+vmgHfth5WQH3uHhsZKl7BzzXlitGcvJwLV2P0fMTuMNccmBEkneIsMwzS1SsmxCzNBnDFyB0oXzSys+9G5MX18z7vL2C/eCjN3/RcTu8j1RU5jgomat8wpWL0ixRo6fKPp5XqL3lRBHtAhncxZm61K/e0RfJTEQRspWjHmmuhO1B8ykPqy1He/w0CgZksEHuXC9Iwr0NOmMc2S3LW2pssMXCGfa/rpgXF+WPBFCgBI9XUw==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV9PR03MB8366.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700021)(921020)(18002099003)(56012099003)(22082099003)(11063799006)(4143699003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?b3XVoqSL6YqmZqSCsmfssr78acmLV3Q/Xr6joieZCoVFQFoOS8ikslezP3Z7?=
 =?us-ascii?Q?VkeyMShTTAAF8syUzDGjKjaxlw6VfPTpynAx72f3NMWJPe3YmfboTF5ZgLJA?=
 =?us-ascii?Q?1N41v1T0gP/LT1Dq8w2xfviWHQNx6I8i5SBVWxyBrpcQ5C58pYLjKOX+PQol?=
 =?us-ascii?Q?lLAAxUUbmDHl8ntSd8nObuhv/UKdl+1qKwq0y0cNQhUKRrUHUuVlM4LVOHQA?=
 =?us-ascii?Q?CeUs1mGTlFw1T5SWYj3P0FD45MEjoULPMY5MDlnpUVIlt94/n+0wTkIN/rvc?=
 =?us-ascii?Q?MprGDNHCr5wRGR4FKKVK69nJr0r9ENyKrL/FYkHLzunphqA91J8GL1Fcf21e?=
 =?us-ascii?Q?Eo2a5neldje17nDBkaqF9WYLabh9Lh21NZEpWpQXpMZZNAzj8iphsobzjQTv?=
 =?us-ascii?Q?r+RHx5dU0AGrfOdFhfHUkYJk9SSsrbR4c9bigUsdpdUHXRNhj7olOs7YO1rr?=
 =?us-ascii?Q?M9oGQQTvbo1W0ruMJ9Wk/hPOHaK8SPuqMMLlGgh0Lk9i80GbaGDPzoR768Fe?=
 =?us-ascii?Q?Sh4XFVMJY7fZdoMHxZ7eyZPl7yxYccjGxFsD2g/ENuYYvSp1i4G/RFXoNySe?=
 =?us-ascii?Q?kWLoCk4+or4bK5FmKd9CsaUrC/gMQR59jw6KxdqmJFCKssetATuXHAd0keIK?=
 =?us-ascii?Q?0qdZu65DP0opSGLoUP/4BHrN4H1D4r1OjTPSh4hVP4OsNydGhrmyGMFMTaAH?=
 =?us-ascii?Q?qlaYFI2T7yUlcu29ohmvPLbmd+JbRiT+Nbs+zD3J6TRoUF37FF+THOZyrtbP?=
 =?us-ascii?Q?qfXAOpPIMjK0BguC5datHDpaNuCE1jFwtOZaVYFK3Qaxds0WnL/OcEv0serc?=
 =?us-ascii?Q?U63NC/1CvRVEAVgdGJ/gTccNa1UKiGPpSU4BcCymkXfTQ4A8so15uEZ7xvoq?=
 =?us-ascii?Q?rvwUkfeO/CF+varZOUnZafOovBGVs2g/1MxLVMOSGZoW5lfvrwh/TI1kkXjO?=
 =?us-ascii?Q?kt4hh4cNyME4s9HlbaD7G+8ldBl/9nWMRnWKaiiAp9szVNXGPmffjyN2s7gC?=
 =?us-ascii?Q?S5o8coRZ+/iwQ0jaMgXZPvTAfSInIXLieiF1nCiIME1XRKTLiKM1xA2p9f9D?=
 =?us-ascii?Q?2SWnWRnQprvNeNLwXqi0B+psYSDqKnorfdPvDWj/0wo4HdL/2ExpSfGygOoX?=
 =?us-ascii?Q?sEyWOwKRSdOW98ZSrcJr68unfiKL5aTHc6P3CY8mrytPhh6eSZKc906MaJtm?=
 =?us-ascii?Q?65jS/+eHmMv70pu9vITbrhkrBvMrknyf/+QtiHQ/ocSpkdDXa3QxwFdEL0O8?=
 =?us-ascii?Q?2iYeW9vjmglOsZlYFYkDgqOFLBaSf3QKThCw6xfqslehSyGeTqSU0ZbXWam3?=
 =?us-ascii?Q?sYszJDOagYckvHOBOBoI7XIymehtEPDn+ALBXnDfbdMks2S0babf9PubYEQs?=
 =?us-ascii?Q?stAo7E7wCm1JX+ImJchnYbUn0FLmWqcioTBXzsuz3gEFek4I1xs2lVS4RhaK?=
 =?us-ascii?Q?+lFKpuCNhkpvhlCqjq6MX/yMhhqMc3Zx9hZUIHSRKVO3OVhISnUQ4k+BFau9?=
 =?us-ascii?Q?JuRjdvZYFM+7GLpUcienv2tnRMQnYHmxSl358IyNJdQAsqaRmjhjG0/pn0QJ?=
 =?us-ascii?Q?B4KqqlYdkI6kKtPg60zSc+vGhyBvnsz1qiERejhqKqCcSZ5Ebgm+cgkAoSsE?=
 =?us-ascii?Q?HG3eXa4BTHCgr+m4ILZ0FJHhpGcmYJNBjp6MlF3o7f1EGC/byec90Re8p6DE?=
 =?us-ascii?Q?W3v63RmxdKlgLfz/l0eDcO8Vhv6B9OUF5H3YeyMvqHfKmqTQ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	YUcTpPfu9XK8/LowKOmcssBZi0ULYqwhefflx5uBMBPkKpHo22DcdZoT1l3kDvr3jXdWJw1J+Nhug83vpTOVe0AVEZkKJI4rQEabnTEtLAg7DqmLVAOlizxKIZ8pGLuTRPFi+RDTRj6PfpujHDMnxJGOetxr/ioh8sTXP4E5jlycGoakz97KtVBVCajC2EeygAlJ1aDeOZnBV3V1yaR564+0xwx3hXirsU+Q1rJnGKrU4jf691PuetLlMFuQ1eq8fE8LG7T1Y/8gveHEx1i5fgx1tWLptekaSuEo2Iehg/EGI3vGezC1ZBZq5No7ZydDyVGWIJpIz/4MygCmevwFBw==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV9PR03MB8366.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a6e41b8-eea2-4799-fffa-08deb7e88e2e
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2026 09:57:37.8651
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fb94nFgKwzjDDnejIsCAW5B3C92a5dnIUvvPstOpBl4gb+GY7qXiHar3fqUkRHJ5uM2vAXyNMRXGeia7UAX3hw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR03MB8390
X-Authority-Analysis: v=2.4 cv=L5ktheT8 c=1 sm=1 tr=0 ts=6a102894 cx=c_pps
 a=XnoXs6g8SJkBXVwgXvPJGw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=ZQxX5BWu6Z8IJBb2zLX7:22 a=c92rfblmAAAA:8 a=gAnH3GRIAAAA:8 a=VwQbUJbxAAAA:8
 a=t5fpEBxWSnkB2Cg41NsA:9 a=CjuIK1q_8ugA:10 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-ORIG-GUID: HY7JWIdnQb8n_Vh_MVzBXTTMAuOd4ELG
X-Proofpoint-GUID: HY7JWIdnQb8n_Vh_MVzBXTTMAuOd4ELG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDA5OCBTYWx0ZWRfX3blyjsmF9yhC
 hwlkjRVayvSeNqDEheq3gD/Q0fRBsymOqCWabqwO5opeo3u89Fcbi3FPfs6v9EMHTa3vZ3Nbl7X
 f6qUcO+K1c1vb8Tzex4IhzvDHvqUzwYUmoqECMkXRAbLNhcW7doQoB4dBybFguDtZcBnUM8bNSi
 75Rw/F5Mqx03sL17ArDdRWd+pc36CZboIzakdiirMdd+IFyec7JZ6dxSXl8v4dQXNFbKg6LXnl8
 lRIcMmm2Msj+eTkYHYagfuDPIgVZeIm19zG/L3gdmm0zrcKBjW/mbkkBXO4e8lt71Nd9X9TfCXy
 akuwbet04/VwibdnV/EWil+drQXnNYUxsd+KuXgzTREo9NGSw1bhBvdCy4fK765zaIXdGdCBf1H
 yw9Qe+cPLxqcT9Ezfnokv8fSENB4OOwUQhZPQO90ijA18xrAo+5Gy7InCOtuWjxUuZI1//ZU4Ps
 +KxeQUYs8UNbqj2yMfw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 phishscore=0 suspectscore=0 lowpriorityscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605220098

Hello everyone, I'll reply to sashiko's review here:

On Thu, 21 May 2026 18:10:28 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Low] The sysfs ABI documentation for IIO_COVERAGE incorrectly uses 'X'=
 instead of 'Y' as the channel index wildcard.
> --
>
> commit 6217a0a065fdaa7ef3fffa525f2928d59a323a05
> Author: Liviu Stan <liviu.stan@analog.com>
> iio: core: Add IIO_COVERAGE channel type
>
> This commit introduces a new channel type for sensors that report fractio=
nal
> coverage as a percentage. It updates the core IIO structures and provides
> the necessary sysfs ABI documentation for the new attributes.
>
> > diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/AB=
I/testing/sysfs-bus-iio
> > index 4fc9f6bd42812..90fb8ef26de0e 100644
> > --- a/Documentation/ABI/testing/sysfs-bus-iio
> > +++ b/Documentation/ABI/testing/sysfs-bus-iio
> > @@ -1959,6 +1959,23 @@ Description:
> >             Raw (unscaled no offset etc.) resistance reading.
> >             Units after application of scale and offset are ohms.
> >
> > +What:              /sys/bus/iio/devices/iio:deviceX/in_coverageX_raw
>
> [Severity: Low]
> Should this use Y for the channel index wildcard instead of X? The IIO sy=
sfs
> ABI documentation typically uses X strictly for the device index and Y fo=
r the
> channel index, which would make this in_coverageY_raw.
>
> > +KernelVersion:     7.2
> > +Contact:   linux-iio@vger.kernel.org
> > +Description:
> > +           Raw (unscaled no offset etc.) coverage reading. Used for se=
nsors
> > +           that report fractional coverage as a percentage, such as le=
ak
> > +           detectors where the value represents what portion of the se=
nsing
> > +           element is wetted. Units after application of scale and off=
set are
> > +           percent.
> > +
> > +What:              /sys/bus/iio/devices/iio:deviceX/in_coverageX_scale
>
> [Severity: Low]
> Does this attribute have the same naming consistency issue? Following the
> standard convention, this would be in_coverageY_scale.
>
> --
> Sashiko AI review * https://sashiko.dev/#/patchset/20260521164323.770626-=
1-liviu.stan@analog.com?part=3D6
>

I see now that other attributes have Y as the channel index wildcard.
Will change

Thanks,
Liviu
