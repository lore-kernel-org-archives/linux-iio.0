Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28D8B282F05;
	Tue,  3 Mar 2026 12:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772539324; cv=fail; b=raaTFTJT/ns6Tp7Y3PnWT7HPPD7YZhRz5P4DH2tjgTXJql4VmqC+D6nfTfI/TNzUAxHjbBvOYEoQUYdu59BSmEe34nV0HmdFI8+pJNdNGNODr/3dCgsrYnSRP3YYUm9xWBUkNDgx5WAuiF6pEusDjGl2WgHsuBgnZIwOVLLcBpI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772539324; c=relaxed/simple;
	bh=mSyfLywYXZEZfRHwT/RNYz8b+xbTLRZrG4FYpb7xcx4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=flK30R01Ji7XM/v2LCHa+o+DB9yWz0AcnKO0/H8zxj1w/yuk9gmO3STdGgp5blPAzNVA0lqTrxM4C4h+x5/j2JpIHG9ZKunLFPn35luTVBR4zOLLTEJzGypXYjPFdUoWLEmxRR+UilKcWYnsNg16Ww+5X2VVNnw2SLv8wz1Z2+0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=z5OiYME+; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="z5OiYME+"
Received: from pps.filterd (m0375854.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 623ABDFA1385313;
	Tue, 3 Mar 2026 07:01:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=pivWx
	WDIxJwkkjjBajYwCIVSSPvroiNqdAEPyNREfh0=; b=z5OiYME+iVwStxnvbe17D
	z7LnGra6qa5R44kDodDrfTfDeIDeymT3OPZZJ80xz48p1gJ3Isr2cjMbRZWSMVq3
	t5Cw+91P9HCO6iKIdoxyjWm0cSBrG74YlZx+ijhqlFfHAS6xgK70uP6GOcqs2zt/
	G8S/xEjHYctf6dCC0H0eSOVuqnmslxCORSIec0vmcSrwFKW+NF+y7I9H1ONOE1xP
	idXkTmn0lCE/2ADvoL1zQxBMkXcB5hOVaIKZRrl8kQ11iX1aahgixsDR5MJBmqX1
	1tNuRNW5xVAiSxXNo7YM7u9sF6v+dvyCj7/CgQgevsegg9VtRKZ3I610CJ/1ka2R
	A==
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011019.outbound.protection.outlook.com [40.93.194.19])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4cmk9jqprj-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 03 Mar 2026 07:01:35 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w3fVXSQUmAJjCWh9nXNlHWvjdW9CcdTV4sUaOabkyiykyKLVN3x5Y2BLGUNfoui3MFoDWJDJTiICqwNSw7OZdOXwRxqCiF/2ArNPjttdP4GVzYU2K6FcFS45MNU97ML9m7EwosZ42tDgfIoF/lNFe7+qkxxAgwSgQ5vrQogs7juC67yllcis/FCHB4wwPNkPVDkTiLfIqCHSnAEHC4I9FKiMCPXhRl0XE+Kn+ONNr4eGwPRdaRZUbP7Pr83TlD3pBn0i2WAM/Ma7MYMszqiExaUJt3499NI0+t3kBLDZLe06SL+DI0mCEtKGphpNL3i0j2Ctj6q4/HK5wFgwpHGEUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pivWxWDIxJwkkjjBajYwCIVSSPvroiNqdAEPyNREfh0=;
 b=jVwksg8NipRhGIVAbrUb+hN/veB443ryYwx+k2rp1UByhghvqoGtFtZxDqoxyoAv7DSGjWZAxF6AyJ0zuxEpyxgDKu5CEjHYCBqdbGKwxjmLErT0Ozc3mGdAjdiz9sDdn1Bcr5yLvmdGJ58R8Gsvv1wHx30CRTJZfowNrlTs4SFLooXpcaispqQVd1Lq0nkGP3UggZtQAqdUyZ6DhKvsQm8+qOLWs+Upr2+VA8eUBoCySpFE/QrjFk6wi4sIuvNF905lmVHoKw2DdFwCplkOSjDFDGIl4PrfheOA0jw0BsHohLTHgy59WXMiL04zpkzBlKFXEzWoWiCS9aMr2bE6OA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from CY4PR03MB3399.namprd03.prod.outlook.com (2603:10b6:910:57::13)
 by CO6PR03MB6210.namprd03.prod.outlook.com (2603:10b6:5:356::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Tue, 3 Mar
 2026 12:01:32 +0000
Received: from CY4PR03MB3399.namprd03.prod.outlook.com
 ([fe80::1527:d313:16d4:2376]) by CY4PR03MB3399.namprd03.prod.outlook.com
 ([fe80::1527:d313:16d4:2376%5]) with mapi id 15.20.9542.010; Tue, 3 Mar 2026
 12:01:32 +0000
From: "Miclaus, Antoniu" <Antoniu.Miclaus@analog.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
CC: Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael"
	<Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David
 Lechner <dlechner@baylibre.com>,
        "Sa, Nuno" <Nuno.Sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>,
        "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] iio: frequency: admv1013: fix NULL pointer dereference
 on str
Thread-Topic: [PATCH v2] iio: frequency: admv1013: fix NULL pointer
 dereference on str
Thread-Index: AQHcqvN9Caq1mMNH50OvhHMs1NzZ37WcrUUAgAADkiA=
Date: Tue, 3 Mar 2026 12:01:31 +0000
Message-ID:
 <CY4PR03MB33997EEE3782905E1362AB279B7FA@CY4PR03MB3399.namprd03.prod.outlook.com>
References: <20260303095228.7494-1-antoniu.miclaus@analog.com>
 <aabHFq2PZssgpK2G@ashevche-desk.local>
In-Reply-To: <aabHFq2PZssgpK2G@ashevche-desk.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY4PR03MB3399:EE_|CO6PR03MB6210:EE_
x-ms-office365-filtering-correlation-id: bf5cf655-f9a1-48d8-5ab9-08de791c9c4b
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 00DiwbULRyV6aAcOJtH9uXmCoBerRuT5zKX0fTxkfmTvZaTVERquiMrOzF8yaXACKq2LZDlma88kMSDBNsZw0EyxlAN+R7fniLIQsjdMVIDkjZKBaik0/f/bdD3n1+8tmkXiOCSVtl0FOWJGro64Jt6wSFxFOwKF/nQPpNEWI1QIabn89CntLOgUudJwrh77KGCYVyKpNdybnfVjydu+/G3kQ6e4l1hpYxyITi/HHkG53C6EUm1hUXJI/B9aSu89qWWxOR2IDhIKjglVKCLuHrAdqkB8vJy79qeWw7d8brLRIAJslxLyWvX40pOv1lnlGK7+lrczinPqVIdPieWUtw9VQRqb05GXPOuBf5s/XRSFb4y2msoLWm0R4xXi0hPxZVjupe8OrYTQ9a0iUtV/cJTspioliotgu88l0koxvTkVQHMgo28nzwdtjgHmzyrV8Ol5zSk3tQvlhlAq7JmJesME4GPoRCj33EKEoOANKpBNSz+OChQPN6VdQqHa8Rs4UQ9k0tdpSbxArffX9S11VqW7q76YfbYP+2y+ciYz3bKeE/Jhw+AJzdBgr7kHk4XYX+zpWI73ytrBThbN5g43q6NgL34YfGhFFnrmVrphQhKngseytXcIxVt2cHIZuNXpJbZLZ4RzVnga+beKKkwQrucWPs8sYPcuRSGREsjavEa3C70BbldnFsDdgXJiR4HEC7gsCB8bl7pXJ7yrwPiU0uIs/9PBoFLBdcSSrbSNoKPI0N1g7Fl790EcLUn9uuIKBcZLPq0gXbAZD+IgTF4+tlBrJfcIifM5O4ZwXNg4YPM=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR03MB3399.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?78bgKkcbWCGJeOS5dhsWM7EXQWw5oT5FYIfw99RGj2jqf/XCV6xzrriyS5xf?=
 =?us-ascii?Q?wJ1fN+VFWK0zxloqYl7SyxWcCcI/ontU3s+biSRTrGG7GmflLSLqiNGp2U9t?=
 =?us-ascii?Q?hD9ZeNqfsJJgxbI26rndZvAjHGi0OQxU5Orr0Mw6k/KviSDSH7I0ExepU//C?=
 =?us-ascii?Q?7I8QmAbqab+fqQJfNKbt++KwTGiyyWveqsc9mSM5tFP9BwNDAIBPE5W8UcbS?=
 =?us-ascii?Q?jxMZt/Ng+FTPvBJoiNPr0XANBLAozZUIovqFnZ+kB75+Cnt3d0mJkqXd8z2y?=
 =?us-ascii?Q?7EjBzPIvcHFbZh07hI3B9kNkYSLxNo/Yymela3vM7jBOXuDcCejUR07G28UF?=
 =?us-ascii?Q?mbpAqouTMH7V6LNt3AX31WW9R6/89W8/icPARW3nK7lZYnvYJOZCD1lmY3uR?=
 =?us-ascii?Q?Ua0T3fQNEl8z3rNePtcComYXabSYLlisXCf/R3Ftpeu1L696dSOoz1FwcqIx?=
 =?us-ascii?Q?WUyPAWqshFBoQ/DO+EUNagpoxfcfoy/0YnwWHISVFk/FXom9N1isR+30EPqI?=
 =?us-ascii?Q?lqGUehVCl6vYfiRRYlqYWIqWIfsDQMLXuczNMKBqTgjrsXrIoWUNwBpQ+1sE?=
 =?us-ascii?Q?eYQkLNpmPzfnFQQ8YCqBd66jpZ1JNh0qzrqYE7lD+TjkTybxY7Z0q+p86Rbm?=
 =?us-ascii?Q?ePxa2tHMaYT3Wn2Dljn52kImhMgftsLNWSY6wx9wAXSE0wkooyhzYUTvOzOe?=
 =?us-ascii?Q?PPycalEwR2mSjVU4JmlAOx82oByxdvYu0InjyiMhOmyjlHIiRhT04JF4+HdM?=
 =?us-ascii?Q?l469eJINsz2vsN6d97P8vRvEloZp3VPEvQOdZCOYOszzVxDUUEjAzhZye393?=
 =?us-ascii?Q?76xUORsXBDycxeFKDGWG/1FFW+bkfN4liUUhjg03kV8ua/j5T7+44XjnUNwX?=
 =?us-ascii?Q?gQrWNhAoiWx0VRBmiG7qJ5+jtj7mvI6tHeeuZXVFlCuVnKCftuatIUys7uQl?=
 =?us-ascii?Q?VRUp21BTTVi9V9RfRelpyGCnfe8Ap6yK/fYQsBJDZYeAk1baLxl3Wiax8vMg?=
 =?us-ascii?Q?K2ckW5JDT1o+B+dqixW5TJnHYHBfC9Rjox/ECtBunKcTPM6cb01kx1cr4bmo?=
 =?us-ascii?Q?72o7gHgzuW3SsS/MKk4QIFOEDrk1c+6W5tHPG208Blx1m6oM5oXwnHE7EvO1?=
 =?us-ascii?Q?/8psL3MGtpOeq6Eerh3RksQMI5DX9Gj14kf2MX3zeZLL6Cpbn8xzvsHsheKC?=
 =?us-ascii?Q?Ll0IaiYQB+kL2yzGfmajSZE3gJhaZxFFdHw7Jh+1TaWpeaV49vRYpLV8Aufc?=
 =?us-ascii?Q?UqqwJZh/ZgnMgtXa54DsK23LBmW5WDNFveLhPJF2NxPVDN/9VD5ZLg3REYob?=
 =?us-ascii?Q?woS1jFrO5rDtleSH+7y1NmA3aDoRsBUR/49zAUZ75wOcLziQpmV3pk6fWYmN?=
 =?us-ascii?Q?kcjdi91m4MQp9qowjlV/fKuxuEavjuZodPDmy8rkLsZj/Su9+8U7Kpo5Mj+l?=
 =?us-ascii?Q?OdDq80cM8i1m/xSDUQ6PLxr+80fN6krbEMITAv4bCzoQ8I410ev+ClixW0bg?=
 =?us-ascii?Q?k8EAGnRQi08gcsbBoP6AxIORBJAvFEasf+ky0RzqLl6CZLxnu4qQyb8U4yl4?=
 =?us-ascii?Q?npEXEMd/d3L801NyYd4tXGFfK7I4b+9WGd12TzIhEwfJJ9Cyz6dMxNN7XGQj?=
 =?us-ascii?Q?Cs1ffM3jduMJeBIU0bZ8E1XMxVsS27xyS4bxd/Td+PRPlVNlJPy45mjXhUlX?=
 =?us-ascii?Q?R3dTfkAy+II2xsE/6oe9595ocEHsz8AJlYYHkSjk8i/m9C+U15Nsm+4NnaSc?=
 =?us-ascii?Q?ehqeCnVKHw=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: bf5cf655-f9a1-48d8-5ab9-08de791c9c4b
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2026 12:01:32.1372
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 00K0ko1HS8AxlFxjeRbeYlGmT8xpt11rTKhetSjOEVKPcJRl4yDyrMuF+wOfszvwqyExmX8Qjo3jA+jyLKWfHw7SCG4evThxt0VhQmwGmM4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR03MB6210
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAzMDA5MyBTYWx0ZWRfXxfB8rj4RsCnL
 OocuRYBNcVRH0kaeE+/CTZkgCY4wrrgWw9L+dHILBzihmSdTuJipn+n5AxpMpXWn/IRTUUO0nHZ
 pEcGReRyJkpph1O7qXWSnfcGyNibOvkJHlDxGj/DiVK3xgZQP43M1/hGyuk+k7gz2EVZW2oRfw3
 MHO7rkmmRz7iRdVcEr4uHdJ8CwxY0Ps6Ma6DAQMKYDb2KsvITz7DIeTaDswt57uO3pZEidiqoQx
 sUlozdrMNzQon3onliPVNJBlu1/oa/h1slNXhI8vWhG9bVwCfdckBf4KJNS7DmJOc8HOU1AiOkK
 SC+/Q2Qk56QzmfJSZLwSUL7c1AobLHf9uNqfMEsrmmXjDuibKgXu8+L+BbGavEvwW6+Fe9s0iyZ
 4i+gV4xZmCVtAAPWo3O28tJsZmEg1bY2gcIVl8+pIrm69mEsnvhf0ykIgI+LA+sDM07F6dskhC3
 gPaT/vJdvARYglAtP9w==
X-Authority-Analysis: v=2.4 cv=VITQXtPX c=1 sm=1 tr=0 ts=69a6cd9f cx=c_pps
 a=FOw1GTnNYXmOwZ/eduxC4w==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=iZSIUCweCk2Oy3QsdGPA:22 a=QyXUC8HyAAAA:8 a=gAnH3GRIAAAA:8 a=VwQbUJbxAAAA:8
 a=IpJZQVW2AAAA:8 a=wz7NwHw05CwQdstCFp0A:9 a=CjuIK1q_8ugA:10
 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-ORIG-GUID: N0dJeYwMuTsnzhqGPatqINEMjfvGDh4O
X-Proofpoint-GUID: N0dJeYwMuTsnzhqGPatqINEMjfvGDh4O
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_05,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 impostorscore=0 malwarescore=0 adultscore=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603030093

> -----Original Message-----
> From: Andy Shevchenko <andriy.shevchenko@intel.com>
> Sent: Tuesday, March 3, 2026 1:34 PM
> To: Miclaus, Antoniu <Antoniu.Miclaus@analog.com>
> Cc: Lars-Peter Clausen <lars@metafoo.de>; Hennerich, Michael
> <Michael.Hennerich@analog.com>; Jonathan Cameron <jic23@kernel.org>;
> David Lechner <dlechner@baylibre.com>; Sa, Nuno <Nuno.Sa@analog.com>;
> Andy Shevchenko <andy@kernel.org>; linux-iio@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Subject: Re: [PATCH v2] iio: frequency: admv1013: fix NULL pointer
> dereference on str
>=20
> [External]
>=20
> On Tue, Mar 03, 2026 at 11:52:28AM +0200, Antoniu Miclaus wrote:
> > When device_property_read_string() fails, str is left uninitialized
> > but the code falls through to strcmp(str, ...), dereferencing a garbage
> > pointer. Replace manual read/strcmp with
> > device_property_match_property_string() which reads the property as a
> > single string value and matches it against an array of known valid
> > strings, handling the missing property case internally.
>=20
> ...
>=20
> > +static const char * const admv1013_input_modes[] =3D { "iq", "if" };
>=20
> This array has to be indexed.
>=20
> static const char * const admv1013_input_modes[] =3D {
> 	[ADMV1013_IQ_MODE] =3D "iq",
>         [ADMV1013_IF_MODE] =3D "if",
> };
>=20
> ...
>=20
> > +static const char * const admv1013_quad_se_modes[] =3D { "diff", "se-p=
os",
> "se-neg" };
>=20
> Also this one.
> Taking into account the indices are not sequential, this may require anot=
her
> enumerator.
>=20
> Ideally you need to list all possible modes and choose only supported by
> assigning an empty string to unsupported ones.
>=20
> I haven't checked datasheet to understand why only 6, 9, 12 are in use.
> Maybe they can be simply 1, 2, 3 with a formula like 3 + x * 3 ? Dunno.
>=20

static const char * const admv1013_input_modes[] =3D {
       [ADMV1013_IQ_MODE] =3D "iq",
       [ADMV1013_IF_MODE] =3D "if",
};

static const char * const admv1013_quad_se_modes[] =3D {
       [ADMV1013_QUAD_SE_DIFF] =3D "diff",
       [ADMV1013_QUAD_SE_POS] =3D "se-pos",
       [ADMV1013_QUAD_SE_NEG] =3D "se-neg",
};

static const unsigned int admv1013_quad_se_regvals[] =3D {
       [ADMV1013_QUAD_SE_DIFF] =3D ADMV1013_SE_MODE_DIFF,
       [ADMV1013_QUAD_SE_POS] =3D ADMV1013_SE_MODE_POS,
       [ADMV1013_QUAD_SE_NEG] =3D ADMV1013_SE_MODE_NEG,
};

Does this make sense?

> ...
>=20
> > +	switch (ret) {
> > +	case 1:
> >  		st->quad_se_mode =3D ADMV1013_SE_MODE_POS;
> > -	else if (!strcmp(str, "se-neg"))
> > +		break;
> > +	case 2:
> >  		st->quad_se_mode =3D ADMV1013_SE_MODE_NEG;
> > +		break;
>=20
> This (the default) should take
>=20
> 	case 0:
>=20
> as well
>=20
> > +	default:
> > +		st->quad_se_mode =3D ADMV1013_SE_MODE_DIFF;
> > +		break;
> > +	}
>=20
> --
> With Best Regards,
> Andy Shevchenko
>=20

