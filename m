Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA94B35AC2F;
	Fri, 27 Mar 2026 09:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774602098; cv=fail; b=Sepni1H9fEUMlvRSxAQtplPeaT0mQCuirikv4R3twb9i7uJZuEOpLDFTHGqMc5C7+ICVfVMEd/iPTKY5pIYrzqbIx6OtqBUwnio9PHVsHfaTFuWHq9jfS6PizrWxSbLdHAjtyD3RhtHYilnLdHCrufojgN7jx+bnIsGeNRyTbN8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774602098; c=relaxed/simple;
	bh=3xxNBSVYYxqRunkTEiy5MhKlta2blmJU/lP0hKqwm6c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sffbKrTsOUnoBcQ9iH0kBch2gN9ZITzKrChI8WhQpX1R37mDprqj6KnkYEG6gYJigaDgJ5Zdg37SrytyAXEZeoD1PRhNj0Sh+H8NoK19z2cAv4s/2QefPm/7afD+zAPIqj7sQpML7rJfaz3mZgRTrJTjg4gQZDxzSLIY3Dtwgm8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=iQODz6GO; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="iQODz6GO"
Received: from pps.filterd (m0375854.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62R576S84086532;
	Fri, 27 Mar 2026 05:01:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=3xxNB
	SVYYxqRunkTEiy5MhKlta2blmJU/lP0hKqwm6c=; b=iQODz6GOkKUxIwfaq4VIO
	knqs4rcwOdETEsdPcZM+XJtrRIUfu9TIyquf7ZLJ58o/ioV/NBzYNNLh28ducA90
	316FxPqjGgj7QSU+WnDc7ISabw12HlH/GatCV4qVJaIxIyapvJi+Wg96NHy4t6vj
	Gmp3YO7gtzWaF9GZmCNrlM/WhYmtN9EVGD1L1Dk377Y4pV+2mpk7hKdiVC5vrPsR
	RAObjIPeY1hQIrNQCgkMUgjLa7cULvT99ZK5UqMMH3LZu5XOsijURzRTJUMYbmkw
	TN1hYBpCE/exQfhlEfPPCv6hzEY8G9L7DXziS8Ta9rWRyZSdmnm/jvPZMhGBYbec
	Q==
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013054.outbound.protection.outlook.com [40.107.201.54])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4d5kfc0j4d-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 27 Mar 2026 05:01:06 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nTINJsA/YPPWX4tX0LhASdL0YZq7puzTPK7+6ZuqZsf1mQaoDALM5dBKdWFzAn4cclXw77GReRyDjGVFuOL74CYhMDyIiim5Xfq0dwQRiDRB5tU0g0oWfFKE0S6viNJRhOTFC1eGjiK5hrVvfQqZfhUZLzXps7Rt6l1nkE/tk1ZaX59xlV1GfxMlG5enzN8/2x2T5y1haT8i1e+6JjoHFummRQCQu0D+2GygbhbsT14EC7aMZvqFW7xP6I/tKCoIjRzg4CXBMW9krzKgIrbuVifUcM4eOf7MnVbMEY3QG//CynEho9ZH20MNaWR6vTgY33aaY6TPkCYeaVE3hpBi1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3xxNBSVYYxqRunkTEiy5MhKlta2blmJU/lP0hKqwm6c=;
 b=dOExrY9K3U0ADD3xEN4PVP/6QTkW947lu55zE9UYReWnDr+2GW4Kd/m9C6TKTQQ6xPD530eZhi4eWHrfC/okJwjZkw3jN0pwHU6Wzqxzfuf2u4JsTLS2Jcwb74WrbRtmZTQVex7X/2DY+xxz7osOtXfEPP+tHIgglYebrEjaHMq5rp+ukVDVkiE46eJuG33oDR66enm6GG0NKT9aCSRvSM1CHEloCXExsspuabefagWcCMP9e5LjhKJ+rChhE7V/3gHCzK56P/mQ8RrR3N+jviZBmfkZ1ah4GD+jmeTd6ywsyKqBX00xbS+qcug9wRkszciPeHsbIhtIxways5C89Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from PH0PR03MB6351.namprd03.prod.outlook.com (2603:10b6:510:ab::18)
 by BY5PR03MB4998.namprd03.prod.outlook.com (2603:10b6:a03:1e3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.20; Fri, 27 Mar
 2026 09:01:03 +0000
Received: from PH0PR03MB6351.namprd03.prod.outlook.com
 ([fe80::1578:4572:29b5:2442]) by PH0PR03MB6351.namprd03.prod.outlook.com
 ([fe80::1578:4572:29b5:2442%6]) with mapi id 15.20.9745.019; Fri, 27 Mar 2026
 09:01:03 +0000
From: "Torreno, Alexis Czezar" <AlexisCzezar.Torreno@analog.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
CC: Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael"
	<Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David
 Lechner <dlechner@baylibre.com>,
        "Sa, Nuno" <Nuno.Sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 2/2] iio: dac: ad5706r: Add support for AD5706R DAC
Thread-Topic: [PATCH v3 2/2] iio: dac: ad5706r: Add support for AD5706R DAC
Thread-Index:
 AQHctpdTMBKgFPb38UaDAUFZqVbS1rWz8fcAgAE3iOCAAEdXgIAI/mOwgADFCICAAu1LAA==
Date: Fri, 27 Mar 2026 09:01:03 +0000
Message-ID:
 <PH0PR03MB63514E4F27A653729B4E4B8CF157A@PH0PR03MB6351.namprd03.prod.outlook.com>
References: <20260318-dev_ad5706r-v3-0-5d078f41e988@analog.com>
 <20260318-dev_ad5706r-v3-2-5d078f41e988@analog.com>
 <abpfdELI33a0Ncl3@ashevche-desk.local>
 <PH0PR03MB6351A1A32896F5CFF05A4C10F14FA@PH0PR03MB6351.namprd03.prod.outlook.com>
 <abugoaMtEV75Fyk8@ashevche-desk.local>
 <PH0PR03MB63519301C13837DBD94535E2F149A@PH0PR03MB6351.namprd03.prod.outlook.com>
 <acPRSzrHUtSEx-J3@ashevche-desk.local>
In-Reply-To: <acPRSzrHUtSEx-J3@ashevche-desk.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR03MB6351:EE_|BY5PR03MB4998:EE_
x-ms-office365-filtering-correlation-id: 231d4e10-1f29-4aeb-7b92-08de8bdf5f9a
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|366016|1800799024|376014|22082099003|56012099003|18002099003|38070700021;
x-microsoft-antispam-message-info:
 uEcRi1ZnVcqWIjItW5d+YZeHOhmR4NBDIfVDqAFjXso3N2WH7NgGjMBFep0GYcUknpvAbZRDL+tPOdO0e3u77gg076FdRCeGKPW9gTKW+Ww/pndvEJjCex6/5KwkB3VaG61otv3ov6D2cMtkQJw2A0mgpd/VQ/nPeiH3DgxKQ0dbw9JePIdiGKDYNnLjjgdNskqqYVnnoHrITX2YzVN9tXA3rUBJPQap53zGliEaFieVIl4rYn3gmzTFJoyRVeafZG9xuDZecAYkU605n0thu6G/ROsnGU5pN2CRMI6w8GioekNNga+j0SoER7U7xJi+bwpZ95fXZEkrsL3U2CFJjIEzGfZkjlOvpCRoAise1EGK8Mqa9aKyIbiG9nALN72CnZdY4X0aqjMM3yLMB2jU/Q2MFXh7/D+Kn65Tvrc3x5FF11FhFhmBZ59ZuIUf6ChAgy4IH07iILVHJS2WQ/O/6aI7isnDNnnxz6mJJuPhZc10mqwOVa8tFjyMxjx2tZYK1gPFrZyGUmTrj0pmxpi3EBr0Qik4LNXvYjNc12JkK1t3jTA51RXTQOwhCGTfE8moJfecRG3c7o7aXKRto1FxHSFLSDe5id26X0C3pbwIBEvQYDvzD2PKg50FWYPLDkNY1FkVV5SBDzrcfH4E/UfZcm0XK1q7g8Q3bWWV/xRskZ2dJL3fLAvo4NeLBkCRMimx0sZLzY3DMnoG/uIA403OPh9aiCDEftHOa7CgK42yJlLccD/OJvt0UtC3JdMB3mgP14LICuXonbh/GK6HKDSVGFUablV7Xdte2PSdkTyfE2M=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB6351.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014)(22082099003)(56012099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?hlD/WV4knjVgB4bGZU+7NZv/TL2J47XBtNYQSf+kG42VuZnihZueWW4RJAPr?=
 =?us-ascii?Q?ycbIKtY6nCovMNgAIblzaziDhnu/zDwL4F4/2vDZFRh0piphZPVvnc2Sq5Fg?=
 =?us-ascii?Q?dMT5DXvuKctDUwyfLsdZRMG4F+lk6Wt+x9ir43kWqlSdIJ/h92kbEQTSxMkt?=
 =?us-ascii?Q?X4zlM3LUCwLNnGXhu/yymWey2xgNO9qFUxdXBMjJtjfKPJvCELRdE/7ppS31?=
 =?us-ascii?Q?2aaRx9gYI9XRyk7oc5/qJVI58aSzb1aa9fZ0TKTP6TeJbnVUvsU1Oha7Ko5m?=
 =?us-ascii?Q?qyJtirnLWvORjuDEAhtFSI37NwdLkmijHQMVzWlO17n2MMrfgln0LQqGPphs?=
 =?us-ascii?Q?Bg1LSq+mu/zjISQR9dD4/uHxki+cZNRacpj5EDrjTlM02qRHu3L1Ttq0RGoe?=
 =?us-ascii?Q?gS3Q3V7MTenkbpaYzGZKkljSddu5r6WZQ+90eItbQJHCclRuqeeCKt4Ao3c0?=
 =?us-ascii?Q?O6Ik3js+TJJfJw4EaOILCAwP/cqWQVgrev1tEMcoSGoszwyhr90BoN5om6a4?=
 =?us-ascii?Q?9yzpdWoxxw/Bt6vu0lj36+H2v7HbB8Md83Hk7iCqruVNEYyyR3qc8nZgp5iS?=
 =?us-ascii?Q?Wv4W/TbmS1D6/NMke+idD4JcsNc2kWfD1CNkxctgGFw7C7eyqgw+lO1kOyiJ?=
 =?us-ascii?Q?MB9eI4FZodaNJDvoP/4pkIfWMxWYFOyamOqlKlMywU+6g+NDSScMMPvNjcbr?=
 =?us-ascii?Q?O2rszKOoQ9l/alU1i3ovITX91DriuFkQwi7r79Dtn02BWoT/45ovgccOwnZ+?=
 =?us-ascii?Q?ZrY212bVTZD6265WQCpQjwHD3tDbFJICLnwyhYhthB30XAwmJ86KSIFWBKGj?=
 =?us-ascii?Q?oNLSq4aJk+99B+QY8wt5Qsu7FSYEYYtwC3v3Ri0U188J4T6giArm4QzVp4jB?=
 =?us-ascii?Q?+WzVYUYINhCESkqejL509X2r5pAMhOiHENqaW0+Vc1yyuwGdex8tBS/kiUjH?=
 =?us-ascii?Q?haa39774ZVxxL2fPDJAwxzoVa0ad736/roE6jZYD3X+gzfePo9r5vfO3cZxw?=
 =?us-ascii?Q?e5ejBeE8Yt87YFY0UdV+b4YJREwSW1XB1DArv5UVys7WPyjx7J7PIoaFeCDs?=
 =?us-ascii?Q?j7RL5lZStlgj50cwtyizenRS+HRSe37AdW92PtqG2UhBtVCRk77Fi+Xf+T69?=
 =?us-ascii?Q?gH8pCe42rT/MP0dcLPIkT/OZVRl29Di1m8OYjJBEVZcFVwnZCgHRioa002pN?=
 =?us-ascii?Q?nMNcaAbnY64M7ONuPI/RZhuVUHqUa0ia8uJmw+GJ8zUowP5mXHlteK06cdpk?=
 =?us-ascii?Q?Y61eZz35VDB4nFOraSfA3er013yh2BzdPbFVK/M4imzvT4NxTqHjX47aXjN2?=
 =?us-ascii?Q?kfAu3j/i1oEOXyQeweXM4Pdi/zb8zyNbz5QV5s0qzNSvvu8xGGN2O/QQpMtu?=
 =?us-ascii?Q?OAUB9qtTvLJyHKp3FHxCsAO/iYzx+XPxBRL4LVWibPfFTaaoff9iouZ/TvJD?=
 =?us-ascii?Q?9SuNeGhlMOwOwqD+Vv6YRHkGqmDAOgTWn70Xd/H+Ze1YiMjjmOM0DJmjCsuf?=
 =?us-ascii?Q?GVGK43STNferRgd1WW2WrK7Wx9UQqhsK7awBx0e4+GnCm91s5C2BqlWkMkBi?=
 =?us-ascii?Q?g7bIrLXYGKqVmljNBGTumr71b00w/PJKLb3mPExKAKlBOi/GTGPQVHPzYWHa?=
 =?us-ascii?Q?2Vl8h+btGrs4ZWget68UK0jEKvzYxzwkzQgHBL4vFBKHfdeb7UAa9PmBQfcw?=
 =?us-ascii?Q?tbTPF6KyUR+3XaWZlBY+OReBLWZkpujfssSx48L0mGjZxXBl6oQReud6aJ9+?=
 =?us-ascii?Q?++gR/rL8lo2yEo1zc1/Op8jPE6qm5QY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	qx+R9nMKa6nPAeLf0KyTmDTZj9sycrCogHflivUd1jkGBeRQIZx7n3K6jlOIg9YPqqgfgrn7CJqpQn1UJU5YQ98hqcNKg/DgpFVCLzjs/brPYgv/iUJ885n1YdS/k9gZ/H8O0351Qu6R3XNCsKcEBU2w1j169UfLfU0rly3e3qc7xZZ8Tei+PhC2XL06LMjkly06yg3Edjr8KrA8E6xJXoeWqfkGxfAvkZ/+cbg8DYVAa1HEVwCggv7hszL9lK/9OHS3KnYd6VbkFDlhlc0W1Ti+vGDpLmIQMYY0Mfl/o2G22BliZ5WNN9NBdQ6oR/QwtNvnz4J9DpLVM8PJF+dHDA==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR03MB6351.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 231d4e10-1f29-4aeb-7b92-08de8bdf5f9a
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2026 09:01:03.0659
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NpnGQ2mQgM6QHTEk+wIGV2lmlO9b6MaXXRXr63KW8NPuUGDGo0lwWuqwbBpLH2QgFX7yLSSS8d3uiUGWmMGQStbeCIy1nICULLl26245lZ4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR03MB4998
X-Proofpoint-ORIG-GUID: px8HTjNhPAudZB5u-XEcGmU_-fDb1zG3
X-Authority-Analysis: v=2.4 cv=arO/yCZV c=1 sm=1 tr=0 ts=69c64752 cx=c_pps
 a=ikWRpWbkSoEIfbFFe8At+Q==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=iZSIUCweCk2Oy3QsdGPA:22 a=EKjJd0-ChMHf7TOIcbEA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: px8HTjNhPAudZB5u-XEcGmU_-fDb1zG3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI3MDA2NSBTYWx0ZWRfXzbOfkZsS+A7l
 piyJSnNba38gTqgkmDpwtqN4DbPTlTwWqQkv7DwEe0lsWllvXoojic4t0qXN0flTSEdo9oZX+GB
 QpicjbilCW9dmIfbgl3IRe6Ma+PTV5dJRAqc8v3gicvK3FR7PDnAOUNQP2UZfRDWhWt2abMN969
 ZZujM/6z8AhwyC31sTuxPbOO7gWwJV71SrdNFowXNolDDvdH+DzLX2t+VH7Z3JNNVlmWFEsHyLB
 VfMII6GBuAVG/MmgEAXTqoHI4BtdQuTgvilueBWKtku04olg0gOE7LqA6I6cJnoNXx+Jblhz8p9
 sb1QmSns1mvAy9eHbjYO8CgPo9Dfj1jwjroD/X+T1Au9+r9/3tG296EkzbId/cInbbDUWUENWiR
 CxbmasmYHIU8dTbuYdpkkOkhxahvy7GsPhi1ArtojNbx6w1RAmYkoU4oDZA0/uae4Rydc/ajrMI
 k4Rdtn2We8aZQbc93ng==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_04,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 spamscore=0 malwarescore=0 suspectscore=0
 adultscore=0 priorityscore=1501 clxscore=1015 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603270065

> >
> > To neatly summarize, my needs are: (in future patches) 1. SPI
> > read/write can have different frequencies and runtime changeable
>=20
> How does it related to regmap? Is it dependent on the register?
>=20
> > 2. SPI data bits needs to be exactly 8bits or 16bits depending on
> > register width
>=20
> This is solved very easily with regmap, no problem at all (two regmaps wi=
th
> configuration for 8-bit and 16-bit registers), I believe we have even dri=
ver in
> kernel that does exactly this.
>=20
> > 3. DAC Device reads SPI command bits [14:12] for communication, not
> > just chip select
>=20
> Okay, but I'm not sure how this is a limitation...
>=20
> > For regmap to be used
> > 1. regmap_config would need new read_speed and write_speed entries.
> > 2. val_bits must now be changeable depending on the need.
> > 3. I think the read/write_flag_mask can do this.
> >
> > 1) is relatively easy I think, but am not sure with 2) as it might
> > break other regmap core code that already assumes it to be fixed.
> > Feels like a lot of work for a niche amount of devices, I may still
> > lean on the opinion of keeping regmap as is.
>=20
> Okay, I leave it to others, for the simplicity we can leave driver as is,=
 but make
> sure you put the summary of this into the cover letter, so we will be cry=
stal
> clear why regmap hasn't been chosen.
>=20

With some discussion with Nuno, I get now that I could still use regmap but=
 employ
a custom regmap_bus for my use case. Will do this on v4, I think I can stil=
l
satisfy my future requirements with it. Thanks!

Regards,
Alexis
