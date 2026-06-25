Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0203769E4;
	Thu, 25 Jun 2026 10:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782382057; cv=fail; b=S1e7LGRH+4h4ioub75WRrU6nu9ySFZvJcJ8J2t78DaM+EWf1hYq6Jrwj3OTaZUtIjXovdehdO2G8xjj7094hP8ghRaqQd4Zb+FHFA8dhMaUcykQMCbvauO9IjA2WzxSkhcyViPFKLx2NpvEFH66koWDSXtSOUb1VJplYEBgXjeU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782382057; c=relaxed/simple;
	bh=MMJxm4rbCLWeoa6WBKVNmkLXVUgK/XGFf2BJdGyLRnE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=L+IPrW3520nfnK4CmpA1/kiKNu+Rq9TxbwiYe7lT5a62wMyRSYV7cA8DNQim973u3GtfWTXsyYC1CYFcNFLNyeXN6Di/wsUzAKCUyWv5hHOtSI5aDoB3UA06fCTx9lWdpn2Z+mY/QHOagXXNiQn7jpalL6M3yU1m1Do/8BFVygQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=FkXbmPou; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="FkXbmPou"
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65P9UhsE2471251;
	Thu, 25 Jun 2026 06:07:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=Or2Ne
	mAlSP1gPkNQSA5naQQolBxr0OfgRt73c5Qq+0Y=; b=FkXbmPouVGjeVZiybpgIo
	WLwVI317JXBxYdUDpOq3XgJPu3z1AGCG+nvupSWzFZqenGSjOaxj0H5cHipp1Xzr
	LWLk+dIEmC7tFX4mt0j/gf6xm3npNtixmilsv/tNKfgzsAfbhFOtZCTR7Uw1o99Y
	6eNSeQuIqWgM92RggtgNxlMQxBNpDKgOeQnwHgmFfIppPsWmo4q03XO+AqFMcmFT
	Ni40e74yrmW4s/iTimYEWfnq11KSU9YlFkPkxFm2eqQL+A379HMLtRAozKdiMAOF
	Au7nYteW+iExkuON0d69hGYDiRBxFNsLZ+2zBEj0hDA+0uRYPkiDnMQDlywN9kdd
	A==
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011026.outbound.protection.outlook.com [40.107.208.26])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4f11rwr57w-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 25 Jun 2026 06:07:23 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rYpIabu/+qWi1lCkOrkZbEIzmdX6prIbiNpQR8+wXc3TkZZazYLuSakUQOzXOLqSR3DluN785aRi2lY1B/adHoEqCLgDbHBHvBNsN7GUINExzkK0ML2pIjyWuxQYKcCoOBMulDWqYRrlPNtqSMRzgVyX/bygv0SK/IIMZ2rpztmYp8Zcyi91UaK5LjS/EEaNE9ggQXaAxwmTsDwjQLOtaAUraTDuXk7qHmiKWhR0yFUZMHdOUjtqwmxsjICzqeIOp28+pCTH+rb9Hq2uUf2+OqJUmRUF4vfnbmvwcyFnEMAytyLNSGRPAvec9cFbhzhRtZUkIr6MeneQiDB2emTIbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Or2NemAlSP1gPkNQSA5naQQolBxr0OfgRt73c5Qq+0Y=;
 b=Dwl+7PZeGwtRzsrHx5Pn4/5mY6vt7eRSiHPF8qVfgTqw2jUtTJ8BaqCx2WORQkNOpSfGu9sCpikn8l/9yInuEl4xkpBDq9S77KiNDMoC+6INPi42wVeRrSCu3e+q3eOFBJq+xUkdFpocEFgDvGE/zqcg5a6cPgEK26X/tFlMEmaezVk116Ayohz+JBtL2LE+AF507ch0B58ooclsZtnjkSJ1901gpt2MR5XK2jst+bTdorIsvQ5cPLIqzxbOxuzqetZUs/RbfQkTgxUp+PI/OUnmAA9vQnCzTmCWJQYEMVR7hF+SX5U+Yu66PMrO/T11wXKfn7IK9hOXDAnu3M1GIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from PH0PR03MB7141.namprd03.prod.outlook.com (2603:10b6:510:296::20)
 by MN2PR03MB5325.namprd03.prod.outlook.com (2603:10b6:208:1e4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.17; Thu, 25 Jun
 2026 10:06:27 +0000
Received: from PH0PR03MB7141.namprd03.prod.outlook.com
 ([fe80::72cd:8b8b:cf3c:8376]) by PH0PR03MB7141.namprd03.prod.outlook.com
 ([fe80::72cd:8b8b:cf3c:8376%5]) with mapi id 15.21.0159.012; Thu, 25 Jun 2026
 10:06:26 +0000
From: "Paller, Kim Seer" <KimSeer.Paller@analog.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
CC: Jonathan Cameron <jic23@kernel.org>,
        David Lechner
	<dlechner@baylibre.com>,
        "Sa, Nuno" <Nuno.Sa@analog.com>, Andy Shevchenko
	<andy@kernel.org>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Rob
 Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor
 Dooley <conor+dt@kernel.org>,
        "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        linux <linux@analog.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH v2 4/4] iio: dac: ad3530r: Add support for AD3532R/AD3532
Thread-Topic: [PATCH v2 4/4] iio: dac: ad3530r: Add support for AD3532R/AD3532
Thread-Index: AQHc/I8+DQOesUXe2k2hx3mE8//lLbY/Y/AAgA+xn7A=
Date: Thu, 25 Jun 2026 10:06:26 +0000
Message-ID:
 <PH0PR03MB7141482F87D8416DBDB90136F9EC2@PH0PR03MB7141.namprd03.prod.outlook.com>
References: <20260615-iio-ad3532r-support-v2-0-84a0af8b83fa@analog.com>
 <20260615-iio-ad3532r-support-v2-4-84a0af8b83fa@analog.com>
 <ai_OeEegWavHcNF1@ashevche-desk.local>
In-Reply-To: <ai_OeEegWavHcNF1@ashevche-desk.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR03MB7141:EE_|MN2PR03MB5325:EE_
x-ms-office365-filtering-correlation-id: 96f23ca9-130d-457f-17e1-08ded2a16b57
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|23010399003|376014|7416014|1800799024|18002099003|22082099003|38070700021|6133799003|3023799007|4143699003|11063799006|56012099006;
x-microsoft-antispam-message-info:
 KGQtEodEvXu9YbbAGRKvsp3dWk2KIl4UVsUVhtQ7Q27PfdhH8CegCrJcpnL4GdSkXcmGnYkZ+wiAV560/ChaZdm+fSDMb7Z8kU8JZkY3EVFthQ/e5kDQWQz6JCnXsT10v35K4B4RZCA7KVeyx6k1wapboBFeyRWgGe1df7OBaHdjrCxmSZ5E4d4BA0B1HrGp6AmPSruIYom6/FFlM8pQcfXvErCuRkKN5wlWuy0xMjsUL1wujMNcOhJeRUT+5ZcbVzuAfd/YOR8BOBPfz/K9vwaiBiNun8OIR9pL4xwcggG4YrcF9ubd01XkSFbO6mOYu1qM0JqsxUl0PgMdc7zQiV2AU2azzYPQjm7T9TvK6zJY1qvjpOUsXXKtWvQ3YgQmsbm/wHEPGEeNnFIS2EKu3Nk0flH5qeN5Ph9LFvBVebDw/LxHizVQCQvofBwRQRXrPzN7imP3+RGhjSrPi5KhQK25Psyss5F+BJ/7kwe/Bioi+YAsxP67fxt7Reaed1xochDEwdr2ufQ4MXA6yDnG2d4uK8meZage5WfuqUXS6iH2XLnMvS7dY1/2E5UDP67at36z1M7MZ+cpGyCmbk8iVKvoetaBEUfIbn4PijRs3rX9YDdiMUmV9yn9n8Z7GnoxJgSVikh7sMcyCKcBBpfzYOeQ9g1u3Ia0DyTjvAw/+gTYyUpKUhr9QtR2wVxo1ivGl7Rqh58iMMBN0ArQ6T53ZIGzLAH41oZaua5BNSxq6a4=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB7141.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(7416014)(1800799024)(18002099003)(22082099003)(38070700021)(6133799003)(3023799007)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?uwlpHni0grL3Y9gMJOLmzvYplDgyTziZQC5yulCzQ+qbqMNeONnec2KrUDok?=
 =?us-ascii?Q?BaptdXh9lziEOi8wtu1bMZowXvpl+tnrLa99sx73yK7jnjDq4SVzxe0AxufM?=
 =?us-ascii?Q?JBSl51pNmQCSLI9kQ+VUiyYvaJ2/ZCfpADtJ47hhp7ysH6GqFFA4jnylI30h?=
 =?us-ascii?Q?7hWKRcrhWqEGcsQh0Q80oofpD+5MubVHbg2e8H84rz3SzX9hF3n6OWTXIUM9?=
 =?us-ascii?Q?iuZlWPZv4cmFrsKuIfPrRdk5NNqM5BHxOTBDyeYROxCtiJan5m2nOm/xeKEM?=
 =?us-ascii?Q?OfClJBzLZ3U16tHSZPtCOWWSVUtb5bI08fegxjZoh2zdqUQkqoGcEFGcyw0N?=
 =?us-ascii?Q?iB2f03iAaVjnTgx87qxTqt5sV5FiNPi/zmRxiJ+jkCgmGcgHUtXg5/8xaihB?=
 =?us-ascii?Q?DvS0MG2qjeyq6B3AoaxJaf7urAbOWnOsFfWI6yaEHQO3tf5CcJtsZStyZOQH?=
 =?us-ascii?Q?Pn9KjP8WmXRUolbEisuPSLonNAd3YIYW0endbnuqhBbiCmsYSI2pd6LbTfbX?=
 =?us-ascii?Q?XD1HOZKfAXn6QvqJboOUQkicVGKC65dzKCWCsDpQkhgr/s3MYHcawRJLPIIx?=
 =?us-ascii?Q?7flDV4/EQrxYWQfaHY8SC9LhKI2gK3GweH4V/xJRr61LKW1yKIzG30FEZH8o?=
 =?us-ascii?Q?ozdvbkCrFuWm8rOhzPUH4A5h75tnmJlUBHAiqIqFFmIKclNth5hZ7OKiv4Ms?=
 =?us-ascii?Q?2TPW3p4G1cIihgKUA9GuHgjb8VmaSRaRHnMJiQ1xEgsJ4Tn67fafOFrGNHv9?=
 =?us-ascii?Q?8vIARgyGB85q2QXbgYTZmd8z7mBUJPIJJKXshc70m9ZiHk3KctM8+yBz0bdl?=
 =?us-ascii?Q?/wu8ZfR5KVABrMdBYkM6vWaDe2kfYjqTfqkzSdBG5V46oM0QfK/Ug8mdXDai?=
 =?us-ascii?Q?xIBNmmMUQ/bwy2/sTKcni3waJ/bk50e+SraMjy9hux11Yk/Z0C9TSmzSJ/k7?=
 =?us-ascii?Q?DkPT5z26vntkHtzuC0D9GsBNE9mxjtQaS+keiTP0w6xhHtJ71ZNAWoA1zI3J?=
 =?us-ascii?Q?ZOEEEK9K9idsL8XZ5F7mjFORZraFCaYf8s6Y+vb6/0FfCJCLwpx2BCbE4X/X?=
 =?us-ascii?Q?E+WtyOJ7EuTNeaMnT5Sk+4VtliwZDVmqT8xQ2qK8MLkwfqEXY7I6r8PxSWQr?=
 =?us-ascii?Q?LGfDoWdXZ3SLklu81KLfMuMG8Qt59MYLdA8VWlAJZTpmdr6BOu0d1DDrt5nQ?=
 =?us-ascii?Q?CUTNNnrhBZjak1Udb+0ast4LZ7cLfTU96bohHhePHs8DxyMbpFsEF6fXYPQT?=
 =?us-ascii?Q?/F0kTqyM53USKyXBR9odXCmhEOgGv7ffE4+XP33vyHdCYWXSwKANtQu+RnEl?=
 =?us-ascii?Q?u9vdk2TFf95Mg37duAPLJdd55KIfEGfH/P/5JcnGyGVItk1NuJe5AX/6WvqQ?=
 =?us-ascii?Q?0PHBxQdGif5+6fuudAJ5jrAgKhegLg+jdrmAdZhCg5fhm+BwfJXPLVqj4QlH?=
 =?us-ascii?Q?BP3xNBuMzStfTQtKy90ZnJyok+FreKGflV2IO1cbw6LW2ucVLom4nJmG+baQ?=
 =?us-ascii?Q?KQFRRbuWpppgfySBdh/r3FMLE+yr8J2IXtbcK64HwlnyeRHGgiIG5z4JfEAl?=
 =?us-ascii?Q?i5WlKfjYwoDRXUgwT9asg6BbTkLJ2c/tCZUeK/5UCHldHUCl/izWrk71EYpp?=
 =?us-ascii?Q?ROXF2xrFVc92kkSSnJRTLKXmcCskZP1qdVakBG1ifBz9ouufuarn8Kxx0Cod?=
 =?us-ascii?Q?dvxELgx0qESi76uJuxLFVNHSIh88frrDZ2Heid0yjcvg4aZ46S7eAm2Vvdsq?=
 =?us-ascii?Q?o4nuOuRVCQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	nLrqPD1tivA/vfXHVWZLozbbyaugP4OZYjXs44oQefZiPfb36S+iuyx/w6LT6xix2V3i9ZYDpFDuJJnh9lnQTb2j33558ZOePQQDOnvcWNjawB9wZB9jtahTdCzpXS0kAgs99H7pGXVusl0aB6KC/GUY4YQeCwlEAlOcx5oReU0ebVmyezu+y0L2ua0+7V0Jsq5FsphmUAtRVmE+6JZMEMxw9xI5Vf1mqcPmnqg78VjXTZcJVw82DHVkDGqqqK+Lbid7Cf6mnrRQFFyFgZ11Xqnl/tsMrgUr6kjTPAR3dph5zlWEBgTMdufvgJZ3jDDDnygKVGlvGftE1leuTiQAMA==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR03MB7141.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96f23ca9-130d-457f-17e1-08ded2a16b57
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2026 10:06:26.5009
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7dNl8z4BF56tVfiW6aAoy6yg+kcgGa6laHNT+4ls0oV9RkE36ZTZaHupx/exJ70Tt2nnaGmDjJsBRD1kQ0bvFK/A1Qcf2POwctzxT5JnqqQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR03MB5325
X-Proofpoint-GUID: jbA7nrSp6esm3VxDAM7WhFl8Kv-Htge6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI1MDA4NyBTYWx0ZWRfXy7mEAhXxc+XP
 lj6J9jg+P6aCNlknNgP4fBJYEGBEgjxl8Uh7/meZ+CzzxqCuUlOIVL0/fNDebyePxNF5VtOpcxr
 xAgsnE15dx8ktQslPMw9GTWkF8NaoRHSqFCqL6/sZEYWsE2Xj/7rCJe0QlAfQwiFvSEBZouAhFT
 vxZVEuQX5V91r4SC7qBdrd7Xhi8nZf3vgCoHpVbnJv2vGfEPdhRNFzPLnSdJSdXWBtRRXRydx92
 0YW+W3udJjmDGtVf7KuYYK92V+2bLsfQUPjCw1TjS6GLQIf0wZ706qqvNQicRPVjNng+yUm4GjP
 2zPEFz6Q6XOxHdJqP2UJCXQimYJqnOnrVBNYD9Ax6FRDHViBTov/1EVtfUG4wEpz7YO2CN6ck/N
 UDRbsjvr5v9i9XYf6N7KIMGTg3+qoxhm8uWRVyZ41HXqGe28e0R1Untp1ggwf2LfeoEkqHLRdqS
 BYnoesNBOyGiziBt6Ow==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI1MDA4NyBTYWx0ZWRfX9nm7AfbNg9vl
 AXXHM2HHi98XPKg47U09vquZUsiG3wqBJkyPCXS9KRESUeebyNzRL+62YXvfkVwlmflHiRrvl5B
 wvqqWVyYyF8VsjlBOZnCpYSigXtdI6SQqiSKVEtUDulVVHbmUBNn
X-Authority-Analysis: v=2.4 cv=C9HZDwP+ c=1 sm=1 tr=0 ts=6a3cfddb cx=c_pps
 a=uRIsUzfalb69z9iYDTnHFQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=_jAD5XSDOtq9-5Nde2OG:22 a=QyXUC8HyAAAA:8 a=gAnH3GRIAAAA:8 a=VwQbUJbxAAAA:8
 a=IpJZQVW2AAAA:8 a=vbsb8IK7QUyUcTZbUngA:9 a=CjuIK1q_8ugA:10
 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-ORIG-GUID: jbA7nrSp6esm3VxDAM7WhFl8Kv-Htge6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-25_01,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 clxscore=1015 adultscore=0 impostorscore=0 suspectscore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606250087

> From: Andy Shevchenko <andriy.shevchenko@intel.com>
> Sent: Monday, June 15, 2026 6:06 PM
> To: Paller, Kim Seer <KimSeer.Paller@analog.com>
> Cc: Jonathan Cameron <jic23@kernel.org>; David Lechner
> <dlechner@baylibre.com>; Sa, Nuno <Nuno.Sa@analog.com>; Andy
> Shevchenko <andy@kernel.org>; Hennerich, Michael
> <Michael.Hennerich@analog.com>; Rob Herring <robh@kernel.org>; Krzysztof
> Kozlowski <krzk+dt@kernel.org>; Conor Dooley <conor+dt@kernel.org>; linux=
-
> iio@vger.kernel.org; linux-kernel@vger.kernel.org; linux <linux@analog.co=
m>;
> devicetree@vger.kernel.org
> Subject: Re: [PATCH v2 4/4] iio: dac: ad3530r: Add support for
> AD3532R/AD3532
>=20
> [External]
>=20
> On Mon, Jun 15, 2026 at 02:20:18PM +0800, Kim Seer Paller wrote:
> > The AD3532R/AD3532 is a 16-channel, 16-bit voltage output DAC with a
> > dual-bank register architecture (bank 0 at 0x1000 for channels 0-7,
> > bank 1 at 0x3000 for channels 8-15). It shares similar functionality
> > with AD3530R (channel configuration, LDAC triggering, powerdown
> > control), the main difference being the register address map due to
> > the dual-bank architecture, handled by table-driven helpers.
> >
> > Add AD3532R-specific register definitions, channel specs, per-bank
> > register arrays, a dedicated ad3532r_set_dac_powerdown(), and per-chip
> > regmap_config to limit debugfs-exposed register space to each
> > variant's actual address range.
>=20
> ...
>=20
>=20
> >  	help
> > -	  Say yes here to build support for Analog Devices AD3530R, AD3531R
> > -	  Digital to Analog Converter.
> > +	  Say yes here to build support for Analog Devices AD3530/AD3530R,
> > +	  AD3531/AD3531R, and AD3532/AD3532R Digital to Analog
> Converters.
>=20
> This just shows how unscalable the above text is. That's why we usually
> recommend to make the list explicit and separated.
>=20
> 	  Say yes here to build support for the following Analog Devices
> 	  Digital to Analog Converters:
> 	  - AD3530/AD3530R (8-channel)
> 	  - AD3531/AD3531R (4-channel)
> 	  - AD3532/AD3532R (16-channel)
>=20
> (and looking into the C-file change, perhaps add here as well distinctive
> information, such as number of channels, in the parentheses).
>=20
> >  	  To compile this driver as a module, choose M here: the
> >  	  module will be called ad3530r.
>=20
> ...
>=20
> > +#define AD3532R_INTERFACE_CONFIG_A_0		0x1000
> > +#define AD3532R_INTERFACE_CONFIG_A_1		0x3000
> > +#define AD3532R_OUTPUT_OPERATING_MODE_0		0x1020
> > +#define AD3532R_OUTPUT_OPERATING_MODE_1		0x1021
> > +#define AD3532R_OUTPUT_OPERATING_MODE_2		0x3020
> > +#define AD3532R_OUTPUT_OPERATING_MODE_3		0x3021
> > +#define AD3532R_OUTPUT_CONTROL_0		0x102A
> > +#define AD3532R_OUTPUT_CONTROL_1		0x302A
> > +#define AD3532R_REFERENCE_CONTROL_0		0x103C
> > +#define AD3532R_REFERENCE_CONTROL_1		0x303C
> > +#define AD3532R_SW_LDAC_TRIG_0			0x10E5
> > +#define AD3532R_SW_LDAC_TRIG_1			0x30E5
> > +#define AD3532R_INPUT_CH_0			0x10EB
> > +#define AD3532R_INPUT_CH_1			0x30EB
> > +#define AD3532R_MAX_REG_ADDR			0x30F9
>=20
> Hmm... I dunno if it's better to sort by values (so the "bank" 0 goes tog=
ether
> followed by "bank" 1). Jonathan, what's your preference here? Nuno, David=
?
>=20
> ...
>=20
> > +static ssize_t ad3532r_set_dac_powerdown(struct iio_dev *indio_dev,
> > +					 uintptr_t private,
> > +					 const struct iio_chan_spec *chan,
> > +					 const char *buf, size_t len)
> > +{
> > +	struct ad3530r_state *st =3D iio_priv(indio_dev);
> > +	unsigned int reg, pdmode, mask, val, local_ch;
> > +	bool powerdown;
> > +	int ret;
> > +
> > +	ret =3D kstrtobool(buf, &powerdown);
>=20
> Do you need to include kstrtox.h?

Yes, kstrtobool() is declared in <linux/kstrtox.h>. I also ran IWYU and
it confirms <linux/kstrtox.h> belongs in the include list.

>=20
> > +	if (ret)
> > +		return ret;
> > +
> > +	guard(mutex)(&st->lock);
>=20
> + blank line here.
>=20
> > +	local_ch =3D chan->channel % AD3530R_CH_PER_BANK;
>=20
> > +	reg =3D (chan->channel < AD3530R_CH_PER_BANK ?
> AD3532R_OUTPUT_OPERATING_MODE_0 :
> > +	       AD3532R_OUTPUT_OPERATING_MODE_2) +
> > +	       local_ch / AD3530R_CH_PER_REG;
>=20
> This is unreadable. Can you refactor it?

Would this be clearer?

unsigned int bank_base;

local_ch =3D chan->channel % AD3530R_CH_PER_BANK;
bank_base =3D chan->channel < AD3530R_CH_PER_BANK ?
	    AD3532R_OUTPUT_OPERATING_MODE_0 : AD3532R_OUTPUT_OPERATING_MODE_2;
reg =3D bank_base + local_ch / AD3530R_CH_PER_REG;

>=20
> > +	mask =3D AD3530R_OP_MODE_CHAN_MSK(local_ch %
> AD3530R_CH_PER_REG);
> > +
> > +	pdmode =3D powerdown ? st->chan[chan->channel].powerdown_mode :
> 0;
> > +	val =3D field_prep(mask, pdmode);
> > +
> > +	ret =3D regmap_update_bits(st->regmap, reg, mask, val);
> > +	if (ret)
> > +		return ret;
> > +
> > +	st->chan[chan->channel].powerdown =3D powerdown;
> > +
> > +	return len;
> > +}
>=20
> ...
>=20
> > +	.num_banks =3D ARRAY_SIZE(ad3532r_if_config),
>=20
> Also check if array_size.h is included.
>=20
> --
> With Best Regards,
> Andy Shevchenko
>=20

