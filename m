Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51F7238CFFA;
	Mon, 23 Mar 2026 10:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774262381; cv=fail; b=DQUG25kDekggwFqrvWZ3Z6vsmOSdJi+ou3/KQzBM6SfGavtUitPkUxh3WMwAWwZg9I65o0NfeooUljePKftRoYpTJ/dfxIYW09gvqwUXP3EGqUJoEaJ3Gz2nAJJcxprtCDpvP3Gaj1cWvx3wU9KGCa79gdrCa1h9/pP0aq8hpiE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774262381; c=relaxed/simple;
	bh=VJ9dbAiTCA16peEWlexU7E2VNQlU/+6179vfZHXpelw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RRxUNXfmICDEQYFf5A0sNqzgTArKffe27Oy7aFheCGBanZKaUMpAWTUDoXKB8/T6ick2ZyUR2ry2ewuNHN4a4bu9qbrJOE0jdDMBVpyycGJx9sL9mmnTOZUOuj3PnUr0TXAnI+2PV5PmjCmYD1NklFo0ar1ZaqKpnZLpGTdjndk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=0GpvntbI; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="0GpvntbI"
Received: from pps.filterd (m0516786.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62N8471I2430418;
	Mon, 23 Mar 2026 06:39:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=xCrNR
	2hDi0ma3u6FVoMvzy/kNzASy7x5ZGlIbVFJ7pg=; b=0GpvntbIoEarOqO45QU1M
	l3qAZ495Gwa9a8JXIgBM6xFEI1hMPXqtmF+KQC0mjqae8DyWP+AUqefUW6KJv4vh
	Mnfh5AVnNpkgoI7jovonl2OrpmXJsFWrlkYyfwN4L1g46yBjObxd6rPtPYsS7lPO
	2CaaHnbNgp7ySrN6A7C/47dRybiETKZR+YVfa1LRw/rAOSz+JcT5AMEi6CUMitd0
	064Ei3r6KLGlJTyjk3Y/I7zlUydVLUx69ob1BROJNj2IZZ9+Zl+w4uY8rGs7GeE4
	jG7a+irX5ceYOECaEWKnjvXMVhtxJdkJhswmfDFOvP0q+HzOphCuQMYvKKx9e9HE
	A==
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012044.outbound.protection.outlook.com [40.93.195.44])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4d2bxeavw0-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 23 Mar 2026 06:39:17 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PtuGH5yzP1WKVS78V/21NQ6FTk1fePMDykEu5n1asK8+r7KowJdJXu4REyQsvAyits8cl87C6yQBHd7BUnkKRhKhMPcLWP++FEJ7IVwv8eE0u5G3OLWUqJUNadyj/7yrWLtyTNR3MGTUspCqXmmpOmGNsbeUBZfSW87uvPuo9E2QUz6IzspADdprGuSwEmwJT3I8lBBmFyEhP8N7mIGkYsdAfz3ui92KoKm9FqanwoV0BKeWVqElAOacO0qK9bkNfW5NyitdAkcQgqguEFTrovchvt45wh0GTaCGWrgH4Y8e6pxPXjwEuCHz++944FnbBj3nWHppI/TCoeq+6Z5Ydg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xCrNR2hDi0ma3u6FVoMvzy/kNzASy7x5ZGlIbVFJ7pg=;
 b=i9omwPCbWkY5zcsYzgVimA8Nzb4FYsOB75LqhhI6m+zc1JlUFds30IlOr2SRGtKAOAqg4l6p0jPc2BDVIFreaMMBz6h/QfYgtORxRN261eqIe+EkmD31KDFrGyY0+9LeX4J79cUj69WlZeso3mc5HLo2YdXxSfygsjpQRT72d56t17Yay9cxxyJeS8NaTLTv4m6jXm6SCoii8cqqDdzxbQ3L0lNLn1cN1WUtAKJFTRNn+3LDRuQkKV0qv2Z1YKppEAWMzvNVT2oforBt0ir0UALfatsvFisLgHxg0SVN5OW8cgMbGCOsLmOvSoBJqhhgJoSERS7g55CPBEJVjLyHrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from SJ0PR03MB5854.namprd03.prod.outlook.com (2603:10b6:a03:2d3::19)
 by SJ0PR03MB5568.namprd03.prod.outlook.com (2603:10b6:a03:288::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Mon, 23 Mar
 2026 10:38:57 +0000
Received: from SJ0PR03MB5854.namprd03.prod.outlook.com
 ([fe80::d56:f47e:e473:97b0]) by SJ0PR03MB5854.namprd03.prod.outlook.com
 ([fe80::d56:f47e:e473:97b0%5]) with mapi id 15.20.9723.030; Mon, 23 Mar 2026
 10:39:01 +0000
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
Subject: RE: [PATCH 3/3] iio: adc: ltc2309: add support for LTC2305
Thread-Topic: [PATCH 3/3] iio: adc: ltc2309: add support for LTC2305
Thread-Index: AQHcuHilvt8kxDQYyUO6A5PZ8QUKj7W77wkQ
Date: Mon, 23 Mar 2026 10:39:01 +0000
Message-ID:
 <SJ0PR03MB585417B6079142321F8E3C98F44BA@SJ0PR03MB5854.namprd03.prod.outlook.com>
References: <20260320140819.191700-1-carlosjr.jones@analog.com>
 <20260320140819.191700-4-carlosjr.jones@analog.com>
 <ab1eQ55b_8JiyAGA@ashevche-desk.local>
In-Reply-To: <ab1eQ55b_8JiyAGA@ashevche-desk.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR03MB5854:EE_|SJ0PR03MB5568:EE_
x-ms-office365-filtering-correlation-id: b0a1b25a-1d03-413a-6267-08de88c86600
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info:
 yMK/Gj0kWEQUO/ggdFypNx1bvMAM9UCz97Hpm09M3eobEexeeiyo76J0XFRC10CLgLKnizifU6je+pL0ZyrFW/SVyk1zTWuDc5ADNfr+4iNVPzwrJBwBf7whVRO+S95FOjrBYsCfonJg6A5YwJf1mdCGKj6Y35stf9XJ+JKHO3rkuJT6QavgqoL6tu4YIZMuOB7BLRgSqianNXq1wcntuz+gt8KgiOTDOLicYOpuhRBZbsiP2qVbW8wJ2epDBXg3Y7ZDQ7bCbE+dzcBCs6BSEW5rjpZuFe0TjUpP/G/XTDylAstIZbmL53P85Ad0sxpHO+nhNRrcz+51xbM304MEBWVD05O+AET22lQseSVUFL96Tm8bJvxO/Z8Rvg3xZ5mq74NDPk5JUI4T+kDlQsss8nZGoXyQC1009513a/BozcS/3bPN0PhwsHWv8pbFEPmqh72ObKkmbsQxOcx2HJYJNm3CwVHvil5WAls0+zNptw3AMOkKs7ZROuk/iLHngYkhVKHxtzdujTKMLqzxnt02YAKrcxev2dZ/FqV3Gr39MF9UJzs+P39VHlqId876OAisQXapOfEZjUNBlYfrParjFyQeDj/IojC6bw0EmP0RECEJ44SxVbZ21N9OkmE+IIELtjdShuAklxSutmUr5f331d1q/5qbaZG9NEcko+MQ7Sc7Y7RQLVXuTv5sUtndmM1bU5MrtFPWU3nAwv07yj4Tn9jSb+xqb0FuWtawCzWmpNM7P8JE14YeeaddoV25SeeTFHDy16k6Ks22fDHf2ATOCt0Wmy1VkVKtbqLQMlmbvgM=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5854.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700021)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?8l7wVpRhfQzYRHnmg+Da+9nQvHHHSysq/EEAPqpy2vP/lWsJRYVk1Gi+Pt1F?=
 =?us-ascii?Q?dVNh2mmudM5s9Y/qTQoEInArxqDGQmRRtpT6q2i7RFyERskBqk3XH2k2QRue?=
 =?us-ascii?Q?ZqCFWdaoRT6FtjiQoAddw4+u4ZCkW0k8ptXxNNCFImC9KZozfPNTHo766cYU?=
 =?us-ascii?Q?FuT+SXS6RgjOq+E0yFUSvwz1XHnhErg+0GPcGMGppj1gXrt9uKZU/EwpIPvk?=
 =?us-ascii?Q?0xjYmo88YjG0lv1l3q1r1B9uQQ0iD6qOmRUw9/BhoAB6d3XS4uNl/xSqmRxj?=
 =?us-ascii?Q?rR4CmbnYuDblIelLv4N62Blope41R8csdBfXiLoP8Rsge98QI/y/15x3ckRi?=
 =?us-ascii?Q?iVJnolEGkL4Dx2zFxZjau5VjB+v/bK1n/8E7XT/ekuF+JAtaoDmgeMVHWO7G?=
 =?us-ascii?Q?uj57A/F8CidzRatlRyvOSPPlxED8lrW+WVduQJzx0wgyoxhf0h9D3Zg0qc/u?=
 =?us-ascii?Q?hx8lxVqk5krfMaWJezOGmqxChkesQUhuCTfIaSXGwZ4psnp1geTAKwcmAuGx?=
 =?us-ascii?Q?hkpdEBrqZDRTeCvrOYL/B1EZltxtwvNtGbMnAUACQT5r9njeV6p930bUNZUn?=
 =?us-ascii?Q?V3RUp3n5Seeg7McnP4QPiA62fvxZCbh3lwWzKV1XvHU3kc1w3SRn4W2sQtkm?=
 =?us-ascii?Q?C/iGzj1d+WtIqAqvW4L+AnUyRzzNtBhr0riGv5Xqvl4tIf8miw2e3IxSpXEg?=
 =?us-ascii?Q?iWsWV8LoZV5vr8DoU5TAQCE+9SDK+015nEfbIRIiOSWaoR2gNlv/x35KidEu?=
 =?us-ascii?Q?kPfYyt76Fz+r5Luv8i7WbiI8OjHpu+rVxoK8dLBEhvtpNpAA3rBwu8VRyKbZ?=
 =?us-ascii?Q?8JpUo7d3rkfbCb3Dq29UvSAk6W3AR9OoBVPLV2srJR/IyWWe3u3pg1BR6FWe?=
 =?us-ascii?Q?1G3RGuhLS7MVwGIKJDshdX0FwxvSCR2rNssVK4bcmuTHDk3cAo93vOlwNDBM?=
 =?us-ascii?Q?NZb1C9a3SMFlRoRQtDc+zDO6mwaCM60RfHJBi0YvE1XAmKKxyTjKkgLwnx6b?=
 =?us-ascii?Q?PrhH9ZVchJQ7cZOORE7APjuW6V+vjWAfJjbPzYnxd0Dex14hJddx2CajmVY3?=
 =?us-ascii?Q?V7vYMRyjvYP7tbnBdrER47FaIoPJLVQQz29rNTHF8H4VURk0BDjwninI74yr?=
 =?us-ascii?Q?WEvqIblSZfIRov/zDtwpqv/DVffhYO0ntxK8LnJIXqsqOSrydWfHPcI6Qw5U?=
 =?us-ascii?Q?XSeyGRyJpYXAsGegsgeB+iSF5tPx8fpGBF873Sc8qC4fS5NDe4snjZUXJ9Xc?=
 =?us-ascii?Q?t87p2ss4WTJf1g9LNRhF3Ik/sxwfm+r1bP9c3SO5JcZc2CJn0zGnojY8Tqs4?=
 =?us-ascii?Q?nvj242nszh8oRiB199mzWIUNdeet790COWLho3Zwjfz2x01kRhDtqf6tRVx4?=
 =?us-ascii?Q?6wUcySqGZOKm+BrWMMxUzgB1mbSIuVITPNR83RvblKPTzljrp7Bm+CnVJ4wk?=
 =?us-ascii?Q?idSxpnNTtOUl0AynTS8EqgJfO5v1Q4r9wGd4jb0VNfcMUxYZ/xMeqTIF3448?=
 =?us-ascii?Q?Jz8EjChyK05kdNaWfrRttD1Qaj3hF4/xNpDHyWRpQvGQhkh2b2VlRdYy5v8W?=
 =?us-ascii?Q?WE2yj26T/M8rAROgwfKrwoJG5zjNtgKOurVKqpBwSi/xbVVGJBJkgapHklLo?=
 =?us-ascii?Q?PBt2lv/Ei/lWYOMeX4zycurSfJUj6g2rNvFEQjxmpUyIp38EgyAPf8vF9E09?=
 =?us-ascii?Q?7veOnvZ/mNvngsquHcu78tWGdl2i+jUDzjDFZ4cycaRFZDBYHdB+79HzECjq?=
 =?us-ascii?Q?MOU5X/LOhA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	Wx/92oLCQzUTkRHOC1b06n2nXL1t88rWi61L2IHmaBpRlNH/oSuTvMaYqs/FTZhwNrFvd5OJXt4bsY8xHAs20w8EYX3O39sPg1s1+k/MwyPGrhBfzMK/Cbb4ZJg0GF+yozPOfRAesFzwOoOejpJ7Hk6p+nDNnxNIS4aJRTe0CQfvTjBdgn3gEd6Jd2GtH0ndt6O2jZGJym/T1dUsgoejyozm2JxPQeOBxLbBp6KkzjpuJ3xTLAGpx1IG9Tfs1wfKdZFBWBI/hqnsc+3onM87QIrZiavBDJBdzun6VpYmJN+DnbJfZ8vmsEjw59f7sG4Br1r5AMV+HwmqQklwZ7wnbg==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5854.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0a1b25a-1d03-413a-6267-08de88c86600
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2026 10:39:01.8852
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UpL9gHr5mpIvvYAPh0fIXWj1ggcmh2jwlGZizeoJCA3MuqC8+bwDYAefrPNacgeJk/3ZLLbTYsxRcqKGWmJsuOyxqgbENFA2aGvwJAQB4Ec=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB5568
X-Authority-Analysis: v=2.4 cv=P+03RyAu c=1 sm=1 tr=0 ts=69c11855 cx=c_pps
 a=QCcpiOQK2QUg/MYG9+G9Tg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=ZQxX5BWu6Z8IJBb2zLX7:22 a=MYF1zNubbFY5ky_KxWkA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: JGKrUd_JcS8KgQCZnBofa3_TdMkloCIz
X-Proofpoint-GUID: JGKrUd_JcS8KgQCZnBofa3_TdMkloCIz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDA4MiBTYWx0ZWRfXyv89e1VOa1BR
 phOv0Ij95eyzqOyqPktQ3uKtWDEaYf+VSjbFkoT8tpDkNYDpOk7bwQq0yFZ3sniTvH4sVqGjix2
 B82T17S1zwnXVw1M/0vS7/dA9ueErNVqwfbY4B9oQSoIrIclF5+f6LWksYzwegFLFQkWOWGqPf4
 9Rft0q/WWb9fWeBgnHfXvryA2X5W8W3/Hxlc/pDIhyETwsISVUblE0LG4l9xcY1XAhGGa8MNh19
 ZFE3HUyJgSfKsZ2HJjKBa2ELIgneYR6gUTlmONE46fmnHOKu1+WSDnx7gih0MeyBJ3GrvI1ayIa
 QEQebaylVrwLPSdl4C5Ly5+0hFrSCEg2bdyea1mriILfh3jpNQBjDHZ2wb94phKMjDWDDBmYAjm
 w+u/XGxZxMwLeEfk5RWMNCecS7ieWUNhDrWs6gmZOHY6mSo4F3OGOHUZBlQv/bvm12/FDZO7xV1
 ++z1RMcjFzdPwQPiB3A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_03,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 phishscore=0 adultscore=0 clxscore=1015 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603230082

> > -	ltc2309->chip_info =3D &ltc2309_chip_info;
> > +	ltc2309->chip_info =3D i2c_get_match_data(client);
>=20
> Strictly speaking this change with the associated ID table changes should=
 go in
> a separate patch.
>=20
> ...
>=20

Will do. Thanks.

> >  static const struct of_device_id ltc2309_of_match[] =3D {
> > -	{ .compatible =3D "lltc,ltc2309" },
> > +	{ .compatible =3D "lltc,ltc2309", .data =3D &ltc2309_chip_info },
>=20
>=20
> > +	{ .compatible =3D "lltc,ltc2305", .data =3D &ltc2305_chip_info },
>=20
> Keep it ordered by the value of compatible string.
>=20
> >  	{ }
> >  };
>=20
> ...
>=20
> >  static const struct i2c_device_id ltc2309_id[] =3D {
> > -	{ "ltc2309" },
> > +	{ "ltc2309", (kernel_ulong_t)&ltc2309_chip_info },
> > +	{ "ltc2305", (kernel_ulong_t)&ltc2305_chip_info },
> >  	{ }
>=20
> In the similar way as above.
>=20
> >  };
>=20
> --
> With Best Regards,
> Andy Shevchenko
>=20

Noted and thanks on the value order.
