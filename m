Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11F7B39098C;
	Mon, 23 Mar 2026 11:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774264056; cv=fail; b=dvoCL+Ar0eIVuXpqFwUbSgoiE+GfgApxkczGEJ21WPUmTFcu2X81aONk0uEENuTbkgMC3ZYN4BU4um6+7UYMvvYETNfkr8qSMeuTQhLCwr1mhicR3mZWI+SI3M5t6zXTNowwirV79fAGTEH0OIPVG/8WuKi055M1rSdKDhYkT6I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774264056; c=relaxed/simple;
	bh=Phx6v6u75c/lYbgdQRgGOE/sUkGOLcgQzj2IgbfbowI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AUeo1aDNcSnb4oRLeWrnbYHh6p6JDvPO36Eg2acUviHOv3Uar1HUAnK7wNdLnXel2QVuRbajHKFNyo+W/q+PSn/f0bzViQEkYqpjdyAN0xTcDLFtHWxKMTOrLz6dSngVdtYMetP/IE0G1D8E/ReaX0jjylT0bwlg8jdLn1Wmbnk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=b+Iw3Pqh; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="b+Iw3Pqh"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62N7C9UV4072668;
	Mon, 23 Mar 2026 07:07:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=8IMLd
	RAvnuWZiExzuHuqGg02M8j2L6cQNHf+wR2biK4=; b=b+Iw3PqhiOebAuKE5Oj4g
	QrNbW4OkKevTTcBNOpTeECFglj+5lBJABbgR7NWn5FRahiHEHSfC+nVMFpH+E8Ja
	50OdR+YpYP9+F0nLdrw7GhPR0zbUvDenMruByw9xIP86m6+UHy5metSopO2GSJ73
	EZNHe49LNYvX6o4d3AMITHG59PQeIwYQbVlP81Z8yAI0KLw/Bt9+AbwDM67RjibT
	K6VUvLZwKiM3DmOrwl1XQsQ5ibjrDvTky9vFwAxoocnbHBW9fFmEpkqh8LW4w2/a
	xusSAZYvtnsMslocbzqh04Ach58oA/7YUPmCOkXJViIeEVYb4RSuUzYbV1QBhlGD
	w==
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013039.outbound.protection.outlook.com [40.93.201.39])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4d2pxqasr0-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 23 Mar 2026 07:07:11 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Uilm1ErQ6xco1PRxpcFksc3Je7Vvj2rg84B3foUL0b90IdcuXytMFKCyfX1oyATp6HBXdyZtHTZgRIyng2LTq4HveAZseVLGy/8XwlflaruPqftbjN56lIK39CVZGLzffiQy7ZW8l5Ah97NvjqxqLn6VgNT/nSihEa5DpRb+h1gdg2RPkmcZ4X8sIkt+9+Gahite+qIRqJZm9aATfaxLKuLv6sSftJeiwpHa73KA3goItB6YbKAPVKTnbV53WIUquBmQZeqYn5iIpID0rJjBrEhHz7ZSZALk/vaPCTNm2xNndUw+M+rJFTO8NakULzvHy89Dn/GJOCFUAZotmIzTyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8IMLdRAvnuWZiExzuHuqGg02M8j2L6cQNHf+wR2biK4=;
 b=pQH7YzNG7+7lFWVlxQZev6AaRMELdhZN7+vAjPXQMT8VxCmnUR3NGPrTAuMFr3ZA1bd7tCAIZAocKdmq3FK8lNYPGTyrwo7q3CqWBjc/o2HugNGlRt77x1JAmiK0404EgQBjzjeVBw/k3qjUsSFxNIxHjCJlIYz0lMYn6DV4A5OvAyOOg3XpkEzx0UWr4636sjvoU96hERks9DxdVvO3NPpXhn4Ya+q5g8bgoyeu4o4hP3PaOjwTb9xYIq4/V9TmG8YKMzdbPAgZZjuJzFXS8MSmWmymg7mt/qPFz1FLHU1+VYa50iCAmFuQkVoJV6dAJxu5pg39MQz0gMoLxs1h/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from SJ0PR03MB5854.namprd03.prod.outlook.com (2603:10b6:a03:2d3::19)
 by LV5PR03MB8435.namprd03.prod.outlook.com (2603:10b6:408:363::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Mon, 23 Mar
 2026 11:06:59 +0000
Received: from SJ0PR03MB5854.namprd03.prod.outlook.com
 ([fe80::d56:f47e:e473:97b0]) by SJ0PR03MB5854.namprd03.prod.outlook.com
 ([fe80::d56:f47e:e473:97b0%5]) with mapi id 15.20.9723.030; Mon, 23 Mar 2026
 11:06:53 +0000
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
Subject: RE: [PATCH 1/3] iio: adc: ltc2309: introduce chip_info structure
Thread-Topic: [PATCH 1/3] iio: adc: ltc2309: introduce chip_info structure
Thread-Index: AQHcuHgEe3H03sR5VE+cKMaBgU+vfrW761FQgAAMsHA=
Date: Mon, 23 Mar 2026 11:06:53 +0000
Message-ID:
 <SJ0PR03MB585443ED5C0F75330A1EC5C4F44BA@SJ0PR03MB5854.namprd03.prod.outlook.com>
References: <20260320140819.191700-1-carlosjr.jones@analog.com>
 <20260320140819.191700-2-carlosjr.jones@analog.com>
 <ab1dNoC6dg4X-Yml@ashevche-desk.local>
 <SJ0PR03MB5854895433AA7E5F31819234F44BA@SJ0PR03MB5854.namprd03.prod.outlook.com>
In-Reply-To:
 <SJ0PR03MB5854895433AA7E5F31819234F44BA@SJ0PR03MB5854.namprd03.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR03MB5854:EE_|LV5PR03MB8435:EE_
x-ms-office365-filtering-correlation-id: a33214d7-3e38-498c-6b19-08de88cc4a5e
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info:
 niU9SN2flB/kZsKXGPGz9Tq6yzxzWyrnba2M1pRhcgBnGjz3VTvqYP65WJ3HuL7zbnSDK+ZJy7vhoCC8ihm4Tp42M8XxIKaoHyEjNySAInbEPHzJRHaB42ChzC+UIeJ6ukQi7xMn/h07wNdkDbtcxHRNg2Dza8lUrlQpPXb8VThXnHYT0zosj9W6dxamAZczfM12Uwk/wJP85tWq2ipe2QAgh9xILCDOvcPZTxE7vlDYgbUNJ/+7iYAYhaUa8SexLHb8U81+q2V2ZJUXCvm0xKiKApK7UgdbRrGr0WajRfjpsrhbdf2WvilX1NjfBqg4y8OFmI8158cvLD2pYm4JbonS8J0EuI4Af5ZiQkUdchtsnUpy3oCQk1ZVG7s4DLmJsewXOrkB8OmqzNHwyvGzvGUBYzRDfORKtnlw8XhTUftezuDdckx0KAx9vp89kHyuQ92NFhmbqsgd4Ht8QwD5uO04FUPZ8o62b2KBedIB0Rgdbk+9shcFYWiXGCrBR5Q0XXfK8E75ufuMwO23GJpGBXUI93RHIdYx46iJzFGubArDFZkYOA/y3qZgBYmMxlvS8hCqtewPeBXweaxRIn3OnwFZeTj5RVCjxD2eVyEkjDX/aywo2m6kEyRhtBw60nbCLkNBCY7FTosLKUv3LJl/vLySKoWSM5TQkNWaG8UkCN2J8jAbTZHd9JKRcRa5UPQMA6jHbAYzFMUV1ZjZOzEEEJoj6eIuCAqYQhA9+dSDhHF+NVy1nVp75QFgUQ2wLcGjsCzQf8dhoqYfqtBM0Tp5AeJ47iMoQNzDo8znrcrlWIw=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5854.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700021)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?wJLh4mQ/sTv2gPNo3brWzPQWv21tltbip+2FdODo5TR2wV76y+g3eZ10dV/f?=
 =?us-ascii?Q?H9FmxTX2B+GtbEMfckBpRjEa2RXD5Z7nQK8pTLWHW+Wo0k1h/vXw8I+ZcV/I?=
 =?us-ascii?Q?jowMCA3Qq3M4o/IcBAEYyCyd0s29hOTNzRvo4JMHGxMR1STXXFNgNAh148SE?=
 =?us-ascii?Q?eQeWV2rVH5d4mHn+VE1/z26bBZ7D8Wv2OhCe/GRym2s3uyyR7vAitSKBFCQV?=
 =?us-ascii?Q?MpWbZOY4cZGNeHqQEbdtziOTVAS8RSh8HQ2N58kc32czb1CL2vUQlqCt/mb4?=
 =?us-ascii?Q?Ea4xXHLpm20J0j6gpviCmuSXtGF7se4wEuyKvVXAeMmujHl8YwOPTynqdl5A?=
 =?us-ascii?Q?gUZDUEEpPpfQudj04FD/4HLTXoJmDxp++m0M0jVVqv7n5YiBJN2LJSpVog/7?=
 =?us-ascii?Q?tnp8363jgYWDkSXz2hC+5LroBWndaZUQtwO37tkBVtGn6D6jsI7UQWjTAI09?=
 =?us-ascii?Q?crqthahw8JJ0vWrbIfNQQ/3YbyrQIB52iixmyKjLLPGafzoD6mMGduoNMg2P?=
 =?us-ascii?Q?caVij4e1MaAmRoSaGSGF0K9ym2rnsoHA8rXgIBFXW/owHdP1n8BThEVYmM4s?=
 =?us-ascii?Q?HSCEwOi56exoMxCM/QAVWY2/l6WKlq2SVkYqBe8b0IwMBTm33p9EIKkXuif7?=
 =?us-ascii?Q?eNncTVng5C+cvcI4VhRT0Ypgid215UaitlcV4VZUjXg9gblbPGIqv9A0lOWP?=
 =?us-ascii?Q?qt6r4uqpwanQrXbGZKBVB7YD2gIeAfAgTtJFsUyMe6BxCfrl5JreNAhUQ9c7?=
 =?us-ascii?Q?O8puGFZDDD9DNU6Kfg14rX6HljCcsZXHo/WVtFD3+V+YjowSVFaVrsyEPqGj?=
 =?us-ascii?Q?sINgLPPQJdCclz/7WOi2oL7gyzvSqHphYjSOC8meSSa2Yzmoud8iGeSLeAJU?=
 =?us-ascii?Q?Dq7iteyF54jU8JeBv+S8K5dPFrVLXnlrosZYx0mXPYHloPzYGTaIPDAbyGSy?=
 =?us-ascii?Q?WZ7NDNn5wswTNNtD7w7zevu5x3vzuIxGTJf1gHAsJlftdKDk7B3bcULQaJl0?=
 =?us-ascii?Q?tY1XeNs0otQG8ZTjnUTPybGtXof+Bx4atNOzAJU1gFRybgZ4bJKygyhhH1MX?=
 =?us-ascii?Q?e65XZgc6Lf59m60Sryr/jVSSz9wH/t34LJ6edHVziIAY2EDVq3vljzqf4Met?=
 =?us-ascii?Q?336bKtR1n2r8c1SxER3uycIp+OSIQsxGeVisW3QQjDsY/D3OIwwtS6L+pfyb?=
 =?us-ascii?Q?Qo5iDoAmTq5bgxBAZ2KlcStMKo5oIP0OKo9mjzpK1hdVK9Iz8dGBTwi+44eZ?=
 =?us-ascii?Q?uZlZ5F9nM+WPMgH4DTGEmbYL79yiDY00T5G/ZBA1zW2XmhWxEsVoAgGCc8+Z?=
 =?us-ascii?Q?hw5ePXzu8sIy9fOdA3WbRLnFOlkd0PtIV6JXX6N5fyjA0G7kTGqWqSgXpHV5?=
 =?us-ascii?Q?fZo7yKFno3qgdaanN8Is/XjYTOV019aVL9VlO1nSFTlgH0poeoDrp0uyBdiQ?=
 =?us-ascii?Q?8WpUFeCeqqGPNAJHX/6jKW3cb+t4YVeo87bl64h3AGrFWtE1SFyTno7kGGWb?=
 =?us-ascii?Q?+T9gaTW0AwefQXhhALZDKN0yqOtkPz/JcoYA6KdPmes7jcTnRHdZeYTMvLOZ?=
 =?us-ascii?Q?vH0SwU3Zoj3jQUjIEj1OfVqVS3ceBvzQ/ZBkk8QjXsk9XsTJZ5DLcRIq+oeJ?=
 =?us-ascii?Q?bGhkTqC+LI56NZtglK738niNSzvyoH1Uu79h9O+nRPdrAwQqJqsuzIkrsfys?=
 =?us-ascii?Q?SkPbuBScg1PqPdGtkTLkvwNWRvT0N8CIGrIYBXn0um6Rf6RCTK++APsaBqXF?=
 =?us-ascii?Q?zva5O9BzaA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	LJ/Y0HD9Wp3ZzWRDLiQzWrK3LMp8eF9tcOsWcbWRwP+HLPBJMTX80I354Sw1Sv1E9rqlx/mrpCU4Sm25K63k12VG+ruYxC5deY8SJjD5ldNUSH0WVW0JEFPiYktAnpnCZw+LQK+GFZbdai02NXGERV4Tsa9XVrz0dea0aHhd7+mDDyuQTaf5PUpM6Q9iUqFWFZme//xTyHOpNPYGQo2x3MCXNmd+lTZQdwEti0RW+O58cpkvjKqYV/UMuFD9wMX2EHCmct/iJakC7dzKDjQy4EO2rTHzHRsAWImx2dm14lsPCs5km231BIdDav6TThT5tmBkHM4aht5FPKJDej1Ekw==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5854.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a33214d7-3e38-498c-6b19-08de88cc4a5e
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2026 11:06:53.5254
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 36Ex1VSjKfjJ2tnGgsRiXHa9vKC1Ho9cdFVQSia0LRNZ3Wb+106ZZ54q97vW9O1iaEt0QX0alZCZUMIzxNEWNmxDDRXIKlr9Dbyk/jbyOkU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR03MB8435
X-Authority-Analysis: v=2.4 cv=ALPFdfBd c=1 sm=1 tr=0 ts=69c11edf cx=c_pps
 a=OPuTCcLOD/60NKbq+Taa8g==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=N--XFCr6TIEc_64PeIT2:22 a=_IWGJ9p3pV4CS4nGOgQA:9 a=CjuIK1q_8ugA:10
 a=QYH75iMubAgA:10
X-Proofpoint-ORIG-GUID: NUUPRqYGf9TSdVpDwgJxZLMmpuDsxnOX
X-Proofpoint-GUID: NUUPRqYGf9TSdVpDwgJxZLMmpuDsxnOX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDA4NiBTYWx0ZWRfX8/y3gwwgz+Y2
 /c1iYq3C4AZDjwaoghDw6ntQhcC5yiDOUSLxWLDZJnpPMUk53tLYuHD+gtsbfrDoO+wTtMQcPi4
 ggzi+BsFA0CGwQRIIJsKV6yoZN0EukV+616K9BYN3BV5/1q7SjYUM/SPxbcfxbwUoxMLSRYSTR1
 7FpIC8YFw4ejQ0+ApBWROSCnz10bPMRbNtW/ThqCY+5Eud8IIHXycnzjEbjcMKf+QKmkN6OcFPn
 xu0oPjwXC8hniSnU1r3cOM4SfCPPsX/frOw91KmbzkU3Hk7Eyqdak/W+SSc1upksZRgBlSq4CPt
 xeQh1SSqBaUzym//O10XAxoYQolB8/Q99yn86YyIuvMBr5n7p9QCkbSJ1R5h0i12BnBlcq9pJJk
 OAKPyrRG6eGxnlg2UAESKm8zhufeCp9AEemswqepLAEUE76RmRYmPtkg2CMwiAfLRcmZ0RgEBAM
 IWwCJ81WeXQHFJOGs5g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_03,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 clxscore=1015 spamscore=0 impostorscore=0
 bulkscore=0 phishscore=0 suspectscore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603230086

>=20
> Will revert addition of const struct ltc2309_chip_info *chip_info since i=
t is
> indeed, wasteful to carry the pointer to the full structure when only the=
 read
> delay is used after probe.
>=20
> > > +	.read_delay_us =3D 0,
> >
> > Unneeded.
> >
>=20
> Will convert to variable to copy this value over instead. Thanks.
>=20

Sorry, I meant, I will remove this unneeded setting since it is redundant.
(global struct members are zero-initialized already)
