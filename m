Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D5B383C7B;
	Mon, 23 Mar 2026 10:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774262383; cv=fail; b=g6VyVgryXOuh781kASQkW5fJvM4oRknA/xfdAlKfvqWr6qg7ljfm1o77QaYjDyFBqaaXaPN+JgQ/xesSVD5tbIPKDDoxc13aY6y6KArK4hqUf2zED8/r8PSi9tMcyKFU8YQvnVzmlNgHofxoR1RKGX2p5or0bcaKVMmhUH6EST8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774262383; c=relaxed/simple;
	bh=1P8hHJ7s07Tf8/C6trL1wB1RBQLveszEtHWA6KgMMtw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FsvbeiLnwfdNfGXkUkWHmw0cgQAQKcFwfI+Lb2tPSfBSKXPlS91D9TBFWSwu0ljoT0jhesxpkgB3/5IaN0v8zevabzkHISOfDvDPkEJVltaBd4cZi8n/42TcM7jFjfNo1i6h6yOjqJEeNfHEIan4UGvVw6jDHGtEBEVlzHBVBxA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=dihQKqB/; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="dihQKqB/"
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62N3cKnC4025358;
	Mon, 23 Mar 2026 06:39:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=1P8hH
	J7s07Tf8/C6trL1wB1RBQLveszEtHWA6KgMMtw=; b=dihQKqB/bgYyfcCFc/k/i
	6ZdlCYv8ZMIxstNKCnAcIazyWyJ4VkfLySCOLELs+W2tjErZAYpofQ+5YdgrfsWr
	6lJb8I3wfp7zmMUYVw/hsW+mBIV2VIBdIsDC7li2htrAaBMmUl6GBvuJcHS1xNzL
	DQBqGlbI+a5eCJeKjQs+bC4YA0Lxo2Ya3YrtEHlHwi5Uq6ywXAdH42EOzm0S5HLz
	9qz4ZfoUBFC67kVj5Mg30vGBKcJTyPLEljU+V7/nGy55pSjnTFY77+hd/dkZ0DWl
	yB4IOph3eV/Q8bnXR+mKj4cV8hMw/vDsoFpd0KuhzQbj+ZmZ1tOFtR4PLH+wGtqj
	A==
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012023.outbound.protection.outlook.com [40.93.195.23])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4d1qy3dbxd-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 23 Mar 2026 06:39:24 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OpV2FuxyN6Kymzq/Mm7tOsyDa3BZ3JhWr0e3pgCn4Fahw3ahEbQymz+cX5hSZgWY8/MrsoBzrGR6ZZvRZADUALABKZY+NTY/wVOTih9nc3XYWwoQ3/odnHuOl2ldIoDWJnyu2TbOPHzGSHwtiU+uIMyIPMmb+wiiNc6oQyf3cINHsL6eP4S7an/eE+x5jU98gZQgdPEUAcv71hgwbwKx4ln5oXSyGMWox1C3og8G/AJWP5TmWZzZkiDUo/A4/UHXQxWKL5vPi06OrCHJtQuZfOScGFNEIZzQAPuWAjnbiDzzE9Lxo0DPqyi2XafMnjBe8luCRCYHmcn0HMHsM3VXCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1P8hHJ7s07Tf8/C6trL1wB1RBQLveszEtHWA6KgMMtw=;
 b=Lb9PSxURxkBN4ThTFrxEbSVq7Gx7xv6TTOzGmCnEjSu+xzr1YoKayit6H8Lx2hSZ5VHmqoQR8LHHys56NSxZ7B3Wo/VCcKgerwXb7RplZx/pudN8dUH8qrH1wM6EQJaWrSGp5l9yKBDL+PR3DnAB9w3ma846t0KG5hM6oZ/UFQ5HKSsEcc4OqDzuSqzdTUnrpdmICCOrgKOnupwbhIwiuv8YR+3++O9jG/oOgYzyI3zcseP2E2jYIKV0up6bHdmF89qonehzKpDih4WtFR+etBfJmHEevwVUisWxUQRQskQFh+vs72a0aorZEJ7Kc8Ydt5pRmt+JCL5KouMVwMFNnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from SJ0PR03MB5854.namprd03.prod.outlook.com (2603:10b6:a03:2d3::19)
 by SJ0PR03MB5568.namprd03.prod.outlook.com (2603:10b6:a03:288::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Mon, 23 Mar
 2026 10:39:04 +0000
Received: from SJ0PR03MB5854.namprd03.prod.outlook.com
 ([fe80::d56:f47e:e473:97b0]) by SJ0PR03MB5854.namprd03.prod.outlook.com
 ([fe80::d56:f47e:e473:97b0%5]) with mapi id 15.20.9723.030; Mon, 23 Mar 2026
 10:39:08 +0000
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
Subject: RE: [PATCH 0/3] Add support for LTC2305
Thread-Topic: [PATCH 0/3] Add support for LTC2305
Thread-Index: AQHcuHjdK9Ot/Q0At0+1x9O2j1Xn/bW78OZA
Date: Mon, 23 Mar 2026 10:39:08 +0000
Message-ID:
 <SJ0PR03MB5854F6A0BF548E0BBE8CAB5BF44BA@SJ0PR03MB5854.namprd03.prod.outlook.com>
References: <20260320140819.191700-1-carlosjr.jones@analog.com>
 <ab1eqIXaav4sVucJ@ashevche-desk.local>
In-Reply-To: <ab1eqIXaav4sVucJ@ashevche-desk.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR03MB5854:EE_|SJ0PR03MB5568:EE_
x-ms-office365-filtering-correlation-id: 3d87b267-188a-40b7-7cad-08de88c869db
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info:
 pVKEeuVWfAykea6spFlvPKNBOvOceyPMMEe2sOohTLiPbuIdF4sDIioYHuL/5gy0O26wvpafHscsf00uxt71NgtHlAEKo1a5lY8xIhHyOFuPN8YN3Hv2mIm+V9c7FA+kWXaKhc6FF25DSpm0RCFhG/3YdWWUb2h5CG78k2DpWpsyYn0nkohgQWtbsi8+ScObPlTPkqPLkFTG3OOHJFyMa19+nzya3EprAtS5fRHKfznVVFw+zczynGTJ521WjlroKEr0WXNZ4xPuIrQB6bhl3/ENEqLi31UqeumJqkJ/nWy7DHaAz37BuIr3yC8KfLFiYsTi7NzoSy3bOY/2Bym5JyU1qqMr+1wUUA/TTpVdPooqRqt6YD6Yz6dXcmStE68lPZuGpjb+07Ux8sYbosKpExVsIh59QVjYWkepN8ttIdHYAmI4F4yo/22GDILgdVp/efhwP0BjGFcSS1USXKckjpO+h8Vl8iTnlE11JkckN4APrh5iPpFr4KefYPYgI/68nkuchYIfmjD3E+y13ZoygdMmeAFCBLtnV7S9zLCk3TzqwDAoLufqDYeugDpk5d58ShEGPN8Ll6zCnLrssf7LTyQHVOUNEYql8d2EgxuHi7GVGggTM2uLtnaRXJ3WVwLVQzcOje+rNsHupHVM9rBcyW1j+PirDbN4cbyOAvZgbBN/XKh9D385UyiIyOn1sqiEW1MFS8bcjm84KboUyJdfPnmccTHNED3glCw+dzFozHKOcZPWUi8jWW3pRCG64AWRq4sk6EMz/FLF26dtaZaFSOHbfaIHCjCI5ZA7XfWOrW0=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5854.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700021)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?CdKUKJZCev9OUpz52R7Ss1mafO8PD+E1m/D8ycXoRKnNglO1kC/uKCwwzRje?=
 =?us-ascii?Q?HZ01m0DxkFCDahFjOJf94ce9HMUiNY/Qpn2RvMkC/q+rJBaRRvucFBsakN84?=
 =?us-ascii?Q?+/ly/FLYXzOGvDut3xej6nJJBtCtoM/XIlLXH84DNSs/Z7gHDlLQ3swbdaSb?=
 =?us-ascii?Q?4CXyl4HQD9wi2vn2T9OvkTBSbQ+G6VpAFcDqoiVbtioSi0+GxfeSR4ZR35Co?=
 =?us-ascii?Q?X6El26XGMHXjt3Aschcg8PPuu0VUt/EH9/p+5iaeVy4vzXs+ESVr9KGiRuPY?=
 =?us-ascii?Q?XHBFjcDMQMXMnNUJbpjh76/reNGvmUC85wihj54hkPn7Ksxn91qGGY3h2Ilp?=
 =?us-ascii?Q?VnzTRAlkCCyMJVVdBsQRG5ampcjuJYbR+TVDbufAGiWytazckqAuOqbHBBNU?=
 =?us-ascii?Q?62tRqqAGn4/lqX92GubyAm0/QueXu3YpNxU2eMfRq5ltEI1M5U8fczg+6AZa?=
 =?us-ascii?Q?pOWsnK/2hFfNq2WhpMQ3NG2XQ9StN6sIVmBS6Ncnj+QA+BT2e9tfwoQSBvCy?=
 =?us-ascii?Q?0wHgDj8vXO4X1S24OYdCabF6Hq3q+azIgohoPKKBr1rT4jdTU8JdPdLQNYga?=
 =?us-ascii?Q?mcdsjDyGYBC4+0o9bFijk42ZNN+COkOPZUPJjY9wZGOdBTPPdZnpR0eY3ouG?=
 =?us-ascii?Q?JL1Eel604kuUuXDsmy/gvIh+kHUMYn15HarV8PsdKDDiq46S6o+nzYRs+uWP?=
 =?us-ascii?Q?R8uog6nXrl9HmZKHWGm/ZHNenVcVzpUjqBw0f13YU6nUX/vD+et3nBQ3CSUL?=
 =?us-ascii?Q?K9mG4bwKS39s80/8jmqkiiMCF++sMjbTNpQ90XC1tZqAHcLv7nrCGrdo4Nof?=
 =?us-ascii?Q?WGcKnDCjWEKZHHshqiCrRwjY5CpcnwAINEYVQChfmyEg4q+rl2oTJ0BbokGb?=
 =?us-ascii?Q?bNkh65C8p3WU4YACnnM5LgG/Ye2/Cn4cKnBiKYqO+fz1BxtdFQltPbMy5qyq?=
 =?us-ascii?Q?6Inp/pZfDgUjzwVePQI/8SG+eiitRFolNIhmRAcce7m1fFwt4n04pjIxL+Or?=
 =?us-ascii?Q?uctWrrnV6PbYkwPbLTZnJPOYiMLwwlQIxmTwDnsmrpMNJW9Rzjf0NNO3oTVS?=
 =?us-ascii?Q?CFlFDAnhtsSrRh4ukWi3gFLfx6Q6p3JS5HBYYi5wT68u4v+CEDfXpedYFXLX?=
 =?us-ascii?Q?UD4gtCmQQ7ITQTXnWVz/j3J+WOaava5yvQcnk1Hro5YTevQh/SQvt6Katpf7?=
 =?us-ascii?Q?ndh5EBoFozUteSHemea9U6lcesUxeZGsoZA+K2xJjKcARI0JLaNJ/x6PBzh8?=
 =?us-ascii?Q?TkQDpeejJHyw/1FRnI6PqRTQw1RIV5rX4p9Pe/FAvPkaUPjVX4UysuaNbxdl?=
 =?us-ascii?Q?E36Q5UfTDBvInKcl0xaLsWyzn4f0rmBTOs5xrXKoxBTuuiuzs/gSha41zXrC?=
 =?us-ascii?Q?Kgbi2fpITacdtsoYR5aOjlVqTKevvWCcf9Wh0wVthsJAmLr7pI6kDf71eUjq?=
 =?us-ascii?Q?a+ZNS6pAZU7v+dBkc1Qn01fhi4D6FnPLiicqEY8lB3jpJQsSOch3r3086Xcr?=
 =?us-ascii?Q?hROHMHVLAwaKijEEaqurTXicygZl966CzmHwsOH01x8Vbhg9d5q8W8UE2Mjo?=
 =?us-ascii?Q?KIYH9p6p1U6fKfRi5NUTHLJSRvLu1b40UAo/2jvD9M6UhjQb3eagcPNBfxvO?=
 =?us-ascii?Q?uql4VRO5Y/sJIlTCxpG32XdPBh41Ye+dB2e92OXIBR0mEQhZDzbAsGjcjWYB?=
 =?us-ascii?Q?bebIN+UnLTbwNxH9w7TxnXvSOrKevV4huIOrHv5OUj77PWimeKhPmAt4I/uV?=
 =?us-ascii?Q?szA/e/tWrQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	lp/8BD6Z+hTUuoVUdvkHzDP5SdU72bKsGqOjSz/xsg0tQhN1hm0+TMI1L03TSJuaMu6DUGI3LkuaYMjrU+XaQVv6ryn/gm59TBhNCC2eYfRlKnM+grUVy9oxkZ4Dy9+uAFwJHcPVFQvCpr8mYhtWg3Q8ucgICGpEMv1QhLw0ZeweOgILFXk6bNkBMV15lD7dgQbNWMbGAgct5ysLi1Qwg9MRwQfhFvoFZrgei6jKhj2RW/3fJVnWkpiqyxBnDMMyluKAGhtZOHt4+IOn6xYGg1/M3nf0cUOakotGLC6B7uCq0HVK/eMjUkyeaQw+TkZzwg/9i8xkmzAa8BC+4BkwvA==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5854.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d87b267-188a-40b7-7cad-08de88c869db
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2026 10:39:08.3705
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1wcyLJ+/5ZeqmsSTfaai4UCSk//AfCc4AvE5IipyQmK0KnsJQR4F+VZ75W7p84vEee7u/EUZLKfgB7s9QyMzHWjeEBRLnFdUXOh+3W+Yik8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB5568
X-Authority-Analysis: v=2.4 cv=XqX3+FF9 c=1 sm=1 tr=0 ts=69c1185c cx=c_pps
 a=CfFGriBY15yWSKnMtEY+og==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=_jAD5XSDOtq9-5Nde2OG:22 a=G57G4Eb15F25mrw9zsYA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDA4MiBTYWx0ZWRfX63YucPmqgWEM
 KSJfPRuliLMEJZKCG13ILtuP6ZiQ+dc/I4zA9OPqSVrj5m1bvVxJqApLzFCSFLdNsXlPaDKj+39
 P1KIq5KcIbnwncNbw3NPb7QKvI8p3SsmOM7kt+iV6WZWeu2a5jcCnzQFs5tVgWrWi/AK/AINUel
 zK16EvcfxLAzTB3MRXPG4XmpSsZnxXbuNI0TWm7nSra0SUX8cLEjvJD5rovAgM2HYJAMN4mu+65
 MspWaMQYD+uIYczfnogvE+x7eOsYjudjXs6iFKOFM3GXXWXvpyxBjl3lHSi7NtV33qD0+La8vfn
 3peRqunniffVmSRSFiLsW2t8UYHhTEwCDgrKiRDTlFKnPoGmaojnrvLxNDBNh+2Gm5U8Vha37Wc
 8ZRYD1O9AgMsBEih9IJVlS7QMeMMseBfApMd3iVG5F35Oy1u5q/jY8oiRHJ7DZeUI5Nn6wx4KPf
 PqGew5YTXlJldusnf0A==
X-Proofpoint-GUID: n7X56noiVvjJWhQqnuxyqgCbH_nkvHpf
X-Proofpoint-ORIG-GUID: n7X56noiVvjJWhQqnuxyqgCbH_nkvHpf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_03,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 impostorscore=0 spamscore=0
 adultscore=0 clxscore=1011 priorityscore=1501 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603230082

> On Fri, Mar 20, 2026 at 10:08:16PM +0800, Carlos Jones Jr wrote:
> > The LTC2305 is a 2-channel, 12-bit, fast ADC with an I2C interface,
> > compatible with the LTC2309 (which has 8 channels).
> >
> > This patch adds support for the LTC2305 by introducing a chip_info
> > structure to handle the different channel configurations between the
> > two variants. The LTC2305 exposes 2 single-ended channels and 2
> > differential combinations.
> >
> > Also updates the device tree bindings to include the lltc,ltc2305
> > compatible string and documents it in the Kconfig.
>=20
> There is nothing bad with the series, but hey, ADI, again telling you, de=
ploy the
> internal Wiki and put there most of the typical problems with the code
> submitted by ADI! This series could be done just in one round, if you do =
this
> and prevent wasting reviewers' time!
>=20
>=20
> --
> With Best Regards,
> Andy Shevchenko
>=20

Thanks for your patience, Andy. We'll do better.

