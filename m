Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5116735A3A6;
	Fri, 27 Feb 2026 10:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772186529; cv=fail; b=tnZbK0HzrlPwy0svophE4lvDQeZ/u6gvyUYkDaN9B7avZe+ztUDUz5CPu6vj/Xv23Rlh0fklIGMgDijU7umzuNF3L2s9Dva6ErJUGerqG8YSytL8aM2DkBOxWefCbESOnt7A2iWa9qFE7s7Sl0PbgPpnXCAHgSMg5v0zocJ0rYo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772186529; c=relaxed/simple;
	bh=zozyrChyWCpq8cWGfcEaMtd15LmnXWzuT81kzQToSS8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=q/N8OJEAQdw1HltL+XrC4Vraiv9zDSfX0Pvhlq0gLjsMSKQwcYWssVuEWOBhfYV36zYpKNhqq+6y8jU4osN4BUl1souHhIPIlOvQTmZLLGG1SpfqkbGiTjO/aP7+8Yeo9QRUQoe0ZzkPTLEPsmsw0YSr8ON8V6BWePZ024qq0Fc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=qT24y9ru; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="qT24y9ru"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61R4JBU13025415;
	Fri, 27 Feb 2026 05:01:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=+kPAm
	s1E7ukGszGA2A1JnjAZ9IXu7/idIry2HY9G6uI=; b=qT24y9ruJm7NNknPKrb9z
	9+Eqmimg5JsGdNsrPBMYq34Gt6UjSgEZJ9Wvgvn7IMASy0bFjzHeb2zOmkkgJ1mk
	zqoascEDpo2EhonjGzUFliuW10eRqMwNbSG7KNRFCWLcKVCE7amsQvp2c2D+cPCc
	IYWz9VD2BIyaBwUYzYaaI85YhW2Amwk65m/0tIM35xB/ra/IBrqhMg8ihxLa5F/s
	jHQWRtZGJo5K8jEAkZ59figxN1f+ELcBaSsnzYmvMbM7PWuwufDBqrgzgAJjJ80G
	m5MjhFxKWsgvfKRTrjlVkt4hPnKjL3LAw8isQt6G1NWP6XKPZ8+1VbUk9+0SJ0ME
	w==
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010061.outbound.protection.outlook.com [52.101.61.61])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4cj8tdfmfw-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 27 Feb 2026 05:01:44 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jK8Q8yGwC+K6wZ2EARF5ykWenFRIvEp810eYyKbHFcOLOB29EjnZSQe51LveTZ4qcrmG2r4kjHuAYwNzQjYI8+lxwQgf8TkU81y8QWeDFMneOfwDH78qy853qzL381z5DfyibbrY4hefKL/cRPQMDAt27qfIQ0CK99juL4yjFf0QzCTd1YyHVbKTTQPa5a8sDrwvfahwowpM1OuZaa5cwjUw34c5/aRiL3+CFyQVjMJfZyiUSpqpwBo9CmPu2nL2MK9JzJu6kdwUGbV2yn4Cb/uVkv93ZZuZDmSLyc45c397lrRfUXyOz6SIo++kztdHzmU0HB7hcyrDrfheDIrfpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+kPAms1E7ukGszGA2A1JnjAZ9IXu7/idIry2HY9G6uI=;
 b=Ao9it7AEMxGuZARjGLknk5OcvD9BtqdiTAiwR6FHFAEIZ5mqrV3L9xfqjd5nNltWCJpusM96PezxWBEk5g/nsQx6urEz3U6ryaC+RmLFlfXlnNi3qXKA4t3i011SrzDTtKKOiyNeIdjKei2Vr4E8+mq8lvjY0O5JxQAxO2i6I47dq2uBS4lo62NEfP13EthByCT4HdkP8knjydHrxkumMFdsVK9crIXUq4HW6kdDeaGdKAu1dRqKKYKcbeuN6uhTzqpZ3uZweoGQeCwSFKw/LSit1ik1EIhEO4AFItlddE6ZKXzNV0gAsa7Y05xtzE0iaynTaEuWW8VQ3hKbpMen8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from CY4PR03MB3399.namprd03.prod.outlook.com (2603:10b6:910:57::13)
 by BY1PR03MB7971.namprd03.prod.outlook.com (2603:10b6:a03:5b3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.11; Fri, 27 Feb
 2026 10:01:42 +0000
Received: from CY4PR03MB3399.namprd03.prod.outlook.com
 ([fe80::1527:d313:16d4:2376]) by CY4PR03MB3399.namprd03.prod.outlook.com
 ([fe80::1527:d313:16d4:2376%5]) with mapi id 15.20.9542.010; Fri, 27 Feb 2026
 10:01:41 +0000
From: "Miclaus, Antoniu" <Antoniu.Miclaus@analog.com>
To: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
CC: "lars@metafoo.de" <lars@metafoo.de>,
        "Hennerich, Michael"
	<Michael.Hennerich@analog.com>,
        "jic23@kernel.org" <jic23@kernel.org>,
        David
 Lechner <dlechner@baylibre.com>,
        "Sa, Nuno" <Nuno.Sa@analog.com>, "andy@kernel.org" <andy@kernel.org>,
        "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] iio: adc: ade9000: fix wrong register in CALIBBIAS
 case for active power
Thread-Topic: [PATCH v2] iio: adc: ade9000: fix wrong register in CALIBBIAS
 case for active power
Thread-Index: AQHcpyl1rFXnHir+NECb7REj0cX/57WWUGAg
Date: Fri, 27 Feb 2026 10:01:41 +0000
Message-ID:
 <CY4PR03MB33993FA37361E61ADD3522B89B73A@CY4PR03MB3399.namprd03.prod.outlook.com>
References: <20260226140700.481317-3-giorgitchankvetadze1997@gmail.com>
In-Reply-To: <20260226140700.481317-3-giorgitchankvetadze1997@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY4PR03MB3399:EE_|BY1PR03MB7971:EE_
x-ms-office365-filtering-correlation-id: 1742e3aa-727e-480f-527e-08de75e734dc
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info:
 ZQ3X27462eBdWdkXEvlYSA6n12aiGlRBIrQqBhqa1sTLS2g0089e9JKBWrDs/9b8AFJvoNtmxI7GCrdYX/mNZXlV+TA0Gky3qd//fwblTR4vXVjJV/+iXowrAoPuKez2inBzDi/laxgMduZOfl662nIEaulp5nFab+lZL3+cN9uU3PhJRcOPl3xNoteXaJOtrxEOl6VIrNlKZMhZgOE6Ck+VZQRoSYe0W2fXOssGE5sGRg7SVafO64H4lbWQbLNBeW/TxysRd4VOS1HSrBso7qmRvPhO4qJbP4KAaGJ38E6MD5ADw6+6IsK4NEPJLf3v6VL5iNwEbr8SMS5YCS8K4FDnIbdQn6eEyl7yceyr+PMVZHmyDhprA+AG75K15YXjJ0DYAImJrdl50w308E0WDOxi7+MKQIXWDc7thovg0si5SbyLzrk7Ejs429KjQ2fA9H90z8SyTejJ7Pz9y6zZguBDpb8Fxf0BN7wn3odalo/awSVkBX92pX+TboR/CfEoZp4t/nZa2s4UoMTQvK0R1TW7s4OEV39bVXS4TqL1/MlX01r5c1fEgkVxoL4jOHJRRDxrEvnxMliHSPc+LOySLekoQ0xPssJe4yGvpZIR8rdX+Bgf9/id2ftwpH/IAp135LzpqgnCgbebFYNLj2mRTu6ewcVeuOFrhhQKBB2IPQ4EkQsfgJk0lzP4PqMzePLhc+rPtQn/UHQH65ec6lag6qYD6AvPLdgovJZDYrXhWJUIy9LJNddbxvizJ4UAkvNkJEPTaalDSXZDLlPTFvixBlq/5RYGizj3wyQ8Gy3vHVU=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR03MB3399.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?lquNWBACmF8KeGR28iebOm/wppUtUplIFVXIpik+hsahNS3uHPE50yso+voL?=
 =?us-ascii?Q?pj4+fEnWkLyKyyAi/kLeic5h8Gjb60sDvDC1TNxCtMe7oieY5Vd3zKfVzN2e?=
 =?us-ascii?Q?U+NLF5PXEMb6RI4ucK5zu+ohdlRjCH0ck037bsk9Dxx4D9nO3lvH8FGzY8HZ?=
 =?us-ascii?Q?xFoOA7caneRT6Y+bZn/E8lTRa2XSedN5FDAj4kwdqUL+G4A0Uc8j3IGUeqdg?=
 =?us-ascii?Q?zlwWOz4mhl3ajG3cu2/V+L438OVNhn8lUzfeuRjOsbab3mBG8ianK+N/6Kdy?=
 =?us-ascii?Q?GhxG5nnJTt7NYOzilNmflJM1RWe8Rhj6h0dT0D1mv9tSnoZm+hn5nXhtzfR5?=
 =?us-ascii?Q?8cpH/Qf6sRehbfMR6mJWZXykunxosCBjVAxIJCPBlxRltetDA1BOL5aGTaR9?=
 =?us-ascii?Q?JkcF9e/iHo2Nsprok/r9D9U5rsskeXVsUZg7gn3DsL8qF3LD17KEHtvMhlNF?=
 =?us-ascii?Q?XScHCfuskQrYnCcR+AMNlI4bFPNXaihvnCmuE1lmt1Fb/kpn3D7EYmKI0QF/?=
 =?us-ascii?Q?aPqEjrX4Pc45mI2kEKBGNCS0ywMi/W0tUcrppGqjJnjuRgDVBM7cT7bTHEx8?=
 =?us-ascii?Q?03AfqHDI0POk9GeMfVgd3pYc1CLcxc/NCmFaMEV8gGioY8YkWU0UprPepZen?=
 =?us-ascii?Q?O0W2xm+XxIInuPGYu3vwBgb0ohl6OBeG/D0SAHBB1gbW8UQIxFPHcHbLv1aM?=
 =?us-ascii?Q?RzjnAfYcsZYcIDGp4hoFyyIxzitvBQUUtc9Tt3iyHAZ4rmRRR2W101ySLuE5?=
 =?us-ascii?Q?qxUQmZVcCy5dB9x0j/zBH+wb+WBaSZT29Uu1nkcDMtBTgsuxNJf1DjcC081X?=
 =?us-ascii?Q?Fh2gfG4OyuqaF5ftGgsJBfSXIPT7eGextoCnj++A3ktyvS+NR72NQoxHdQiS?=
 =?us-ascii?Q?9Cw7graq2bzG+eZvbH6Dl8Q5jWIPwBL5IawFVhGqrlTIRSLD6LP1TSNgwQCh?=
 =?us-ascii?Q?NLvjFCm9WBlIscCA2lWuXN3M0ToUfFgSK8uvqg8iwHLncUgLenLOuUq4Prp1?=
 =?us-ascii?Q?EHm9kF+PvaSWW/t725+2uNOKPgizGWfQaiahtHcTxNCawryE8tIAlXb5OI4w?=
 =?us-ascii?Q?m0nIVfJibRXf+7r8ZjMiSw7U0gGvk/dX8oWh7nQYqxJU73g94lk+G+xLcxF0?=
 =?us-ascii?Q?W/ZNBYcr4vyGXfkbLJAkoghGIWqypgDw9ezmRBJDCfLAe218a35Ata6mt0IU?=
 =?us-ascii?Q?Fg99vmwe3c/890/Szv7E06/k1fY0iHCL05gJTN1q34/vW7Nwg7TZnV+qj/OK?=
 =?us-ascii?Q?hWFqAIvVGpXFgqlEq6dPeR5HmS2UNe7Ass9pubRiF8C7SE85Kg/gDCoJDgPS?=
 =?us-ascii?Q?L+Ab50pEPfXp0ZkD7L9e8HPKkIP7GlU6MeusYWApDKU48xvkT1EJEK1b9SWm?=
 =?us-ascii?Q?fGlIZJkeCmXQ9nbLRV2DWdtcsJ30XU/nM03uV6vv4WY1MsnorUB51vy2lAG0?=
 =?us-ascii?Q?mBfkv+1EQBAN4un9YDtXloat0g/dJlmSRvdmKdVz4JKAn5emXBSI+4kdfeHb?=
 =?us-ascii?Q?11NB3RgxLGqfo1QEk0m2ymDVqb4g8EZySsluI/hpp35C5zNi1yqrvsf3Ss6a?=
 =?us-ascii?Q?fkcmke2niskl3DOQQwL2QAhGxt8fim2jQ58v8Xush9/4zCKOxIgm8SXHaWRb?=
 =?us-ascii?Q?cFCY7V4e8ZRq02hQjZdv6XmI0R+Aq60Ta6evVzABVMBFJ699XG/69PMwnOS2?=
 =?us-ascii?Q?eccJIC7MegjQbctSdd7rTf/vdOt2ERsWVb+6BiODv0nGVuBIB4qlc2uqvTAg?=
 =?us-ascii?Q?EnXEMPQIQw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR03MB3399.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1742e3aa-727e-480f-527e-08de75e734dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2026 10:01:41.7714
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2GxHC483ogTZtpObIHkWWRurxVVJaWvOJDKeAhRzEgauKxDiNdFRgglPRh0vrCNsbK8AZOqvZV/IZILXW+DzuQ8uQ56u8RKPACvIDrazDN0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR03MB7971
X-Authority-Analysis: v=2.4 cv=NubcssdJ c=1 sm=1 tr=0 ts=69a16b88 cx=c_pps
 a=AIGQXw1SJcVyoLDzoYNqyg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=N--XFCr6TIEc_64PeIT2:22 a=pGLkceISAAAA:8 a=gAnH3GRIAAAA:8 a=VwQbUJbxAAAA:8
 a=IpJZQVW2AAAA:8 a=s0Yi1eRNgKLqwNC45HoA:9 a=CjuIK1q_8ugA:10
 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-GUID: lnzwmGQ8lZFjkn8bNMM6u5JYzSEDm7Bl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI3MDA4NiBTYWx0ZWRfX7r7/QbPny0P9
 pYtsE4dSvF1kiL26BZ9I9W+dmQPxaRjAsBgLulUbda0bS6tklrobTjpnG1Mdm48gS17SkTsYE/1
 j5KQscWEpURbDHFq65pAACkwDoLckQG9xmTGQxJjuMrMNE8CGs1rSd0fSPZNAUguHR5Qjtv4WAv
 ov9ppp6YljtG1sTbadctCJjtflHyng6DXX17vGJRLlK5o/3KGtI8gDrCNMLeSgMtDB/gFk1tWWb
 aGQm7byDJwCcyBcFGkY5P8ZbR7swrvtY+yeGEVtSdHPnrqF1wHuL/mEL3GT5Me5dXoarWEMmLlH
 EhzUPHykq3vwwFpXFFyhcsEpDX2uxn+6/6RrhWhmdMz6AzmtPatCVP+bx73cmA0LsJ5ePwKr2dn
 JkBFyzXSlWf+xci/z7DMqeI+NaS0TiAPhcc6vB8BnzPKMM6dhkv3jJnWMlRTfC8FE7SuOhMquCR
 uLRLDdYwlyApwe8THeA==
X-Proofpoint-ORIG-GUID: lnzwmGQ8lZFjkn8bNMM6u5JYzSEDm7Bl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-27_01,2026-02-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 bulkscore=0 adultscore=0 lowpriorityscore=0
 suspectscore=0 impostorscore=0 malwarescore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602270086

> -----Original Message-----
> From: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
> Sent: Thursday, February 26, 2026 4:07 PM
> To: Miclaus, Antoniu <Antoniu.Miclaus@analog.com>
> Cc: lars@metafoo.de; Hennerich, Michael <Michael.Hennerich@analog.com>;
> jic23@kernel.org; David Lechner <dlechner@baylibre.com>; Sa, Nuno
> <Nuno.Sa@analog.com>; andy@kernel.org; linux-iio@vger.kernel.org; linux-
> kernel@vger.kernel.org; Giorgi Tchankvetadze
> <giorgitchankvetadze1997@gmail.com>
> Subject: [PATCH v2] iio: adc: ade9000: fix wrong register in CALIBBIAS ca=
se for
> active power
>=20
> [External]
>=20
> The switch statement in ade9000_write_raw() attempts to match
> chan->address against ADE9000_REG_AWATTOS (0x00F) to dispatch
> the calibration offset write for active power channels. However,
> chan->address is set via ADE9000_ADDR_ADJUST(ADE9000_REG_AWATT,
> num), so after masking the phase bits, tmp holds
> ADE9000_REG_AWATT (0x210), which never matches 0x00F.
>=20
> As a result, writing IIO_CHAN_INFO_CALIBBIAS for IIO_POWER always
> falls through to the default case and returns -EINVAL, making
> active power offset calibration silently broken.
>=20
> Fix this by matching against ADE9000_REG_AWATT instead, which is
> the actual base address stored in chan->address for watt channels.
>=20
> Reference:ADE9000 datasheet (Rev. B), AWATTOS is the offset correction
> register at 0x00F (p. 44), while AWATT is the total active power
> register at 0x210 (p. 48).
>=20
> Fixes: 81de7b4619fc ("iio: adc: add ade9000 support")
> Signed-off-by: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
> ---

Reviewed-by: Antoniu Miclaus <antoniu.miclaus@analog.com>

> v2:
>  - Added Fixes tag (Andy)
>  - Added datasheet reference (Rev. B, p. 44 and p. 48) (Andy)
>=20
>  drivers/iio/adc/ade9000.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/iio/adc/ade9000.c b/drivers/iio/adc/ade9000.c
> index 5dcc26a08970..1499fb1c718a 100644
> --- a/drivers/iio/adc/ade9000.c
> +++ b/drivers/iio/adc/ade9000.c
> @@ -1123,7 +1123,7 @@ static int ade9000_write_raw(struct iio_dev
> *indio_dev,
>  			tmp &=3D ~ADE9000_PHASE_C_POS_BIT;
>=20
>  			switch (tmp) {
> -			case ADE9000_REG_AWATTOS:
> +			case ADE9000_REG_AWATT:
>  				return regmap_write(st->regmap,
>=20
> ADE9000_ADDR_ADJUST(ADE9000_REG_AWATTOS,
>  									chan-
> >channel), val);
> --
> 2.52.0

