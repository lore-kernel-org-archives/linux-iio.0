Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D5B238C0A;
	Thu, 29 Jan 2026 16:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769704727; cv=fail; b=BBBuOV3JZMcNMhjQSxMnTa7rQ2suFPy8tBWIsNO/T5Xi+NAvQeet411qAi9gbuKqMhPTgP+m1gvgUauJXuVRiPJl+GVF5Gwo4ixKgKNa7U7w2lHikx2jw/W75woBJyxyh9ZgmXwHBq+aWC5PiBwzjCmFR6Pk3Hyjw181sD4ptWA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769704727; c=relaxed/simple;
	bh=KGkBRvJcBDK5+1KBo7q0Xd11hlcbRnZ0zRP3w+nhHW0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fwthpixreK6ALmbCXLI0Nm6i5nkRvJOFlaQjETvD7GaveC6itBCThfx8l32/hap9sBHzthsdn6pJ2t7RNY4lFnnpPdlxFaSYlVJ8lO4ak5SFEKcQn2GeAvPh+C3sRYIBgXYWR0UKLT6AdCFl5iu4XdlWsis9TY/o3hZcVnkka9E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=TUKDSpi2; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="TUKDSpi2"
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60TDoqCr009211;
	Thu, 29 Jan 2026 11:38:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=lvvdZ
	lJZtgQW3W3W2oSVfBfBwS4htSOjY/YPgZLV05c=; b=TUKDSpi2yqwXBMRI64B9M
	seIkfPLra8Fcx/KTiPMSHyiyUKnL5MNF6d33pYGjgPZ2qnN9paFwtJSJCXkdAErR
	3dqGNEuqO22aVtytBNic3ATJvhV1hKqi7zXjMgFLq2Bi1qUV0xy5UNrtr8Rf6j+Z
	L1vq+XatSBsh1pSzFUaHF0gaLGs1hFqh81Msm+gxdSH7DEfCzAhLcyI+qDz3aAiN
	92BFc6tQAZ2ZyFR08y2dsMSxvHyO58XkN69vwi2sZXaKPkc3Qh0czV07w0crW3zs
	r06JmamzqUlPsc3uCa7Dln+LbhpJKzT/Oyl7uretXSTz0WaIkZYRjdJMaQMcaPQV
	Q==
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012012.outbound.protection.outlook.com [40.107.200.12])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4c08su8q2q-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 29 Jan 2026 11:38:24 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w+e0v3iY/0lEIPRKzJeAx/JOUVeh/y3MFPyvguK+sF+3XIAObFzWZ4aQmf3lzkfR85tUWPMEgJ0vcAAlgcHIAcolpAeXRS+FqFC1++rDUrNqtBmh2fAxc7iCbpdb/86jx7OyEc+TaklZIV8+pK2/mPictxUJorW10vRTwf6ajbNQgcWOVFuMvp2k3vlAGNeD8/kcLB7wY8SWP13WAKhgmRa7fgOnzG+Qo2iG8oLgg6oKhtPnAD4jkP94CSFnZX+W76fqJyCKkU+JB4B5WodDaKNVLWieV0ETOG0lMGZVawym++8OLJ7WZ32OoaPwelfuuqnVk4xOcI37gd1Q4NSwOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lvvdZlJZtgQW3W3W2oSVfBfBwS4htSOjY/YPgZLV05c=;
 b=MCe4/M0GMWEXng4el5AzW61u52NoigdopCtcm/bBWVom3gZDZO5dXQh0Bn5CB7xWkefiGTVpZge5N14cQtu6txPVzkqqc44CoYhIiPlkAsUYg0MjC/4DzXI23doHs1fLjp1oJ8Pi0Eo71eBmcVBmknxwiP5OfoVTgJlNXCmc5DWlFBeuYmLzkS5FB97kYumtuKs4D8pDWJadnHGL0rwmFkC7WRSsrrpXZ1AqgVHxfzMSwR0GR/rJZ3FurQ+o6AGmwYxGjzV8VuYM/1pOTD8DhdCS4qsw3wV7uLE56ShpXJfI1ouC343OR8fuFPLU2joskv20Ys4fhxTCyNu+Q4zt+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from CY4PR03MB3399.namprd03.prod.outlook.com (2603:10b6:910:57::13)
 by SJ0PR03MB5631.namprd03.prod.outlook.com (2603:10b6:a03:28d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Thu, 29 Jan
 2026 16:38:21 +0000
Received: from CY4PR03MB3399.namprd03.prod.outlook.com
 ([fe80::1527:d313:16d4:2376]) by CY4PR03MB3399.namprd03.prod.outlook.com
 ([fe80::1527:d313:16d4:2376%5]) with mapi id 15.20.9542.010; Thu, 29 Jan 2026
 16:38:20 +0000
From: "Miclaus, Antoniu" <Antoniu.Miclaus@analog.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Lars-Peter Clausen
	<lars@metafoo.de>,
        David Lechner <dlechner@baylibre.com>,
        "Sa, Nuno"
	<Nuno.Sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
        "Gradinariu, Ramona"
	<Ramona.Gradinariu@analog.com>,
        Andrew Ijano <andrew.ijano@gmail.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/3] iio: accel: adxl380: remove unused odr field
Thread-Topic: [PATCH 2/3] iio: accel: adxl380: remove unused odr field
Thread-Index: AQHckSlaESMCUHgTBkepgpvQqXB347VpVT0AgAAAq0A=
Date: Thu, 29 Jan 2026 16:38:20 +0000
Message-ID:
 <CY4PR03MB3399E08665C3AF443A634A7A9B9EA@CY4PR03MB3399.namprd03.prod.outlook.com>
References: <20260129141205.106285-1-antoniu.miclaus@analog.com>
	<20260129141205.106285-2-antoniu.miclaus@analog.com>
 <20260129162446.39e7adf4@jic23-huawei>
In-Reply-To: <20260129162446.39e7adf4@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY4PR03MB3399:EE_|SJ0PR03MB5631:EE_
x-ms-office365-filtering-correlation-id: 33d49162-41c8-4023-50d7-08de5f54cfeb
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?aukLBo6FvGlkR0L+xb0Xuv+UZ2KMAY1Tjj67WOXnHFRj1h/FVnmqBBUAk/63?=
 =?us-ascii?Q?+yWuUjg2aNyqzNq0y/GDoqWoyWejTFV1PdYoagSRaa0u+PWupiOY2+lybCkP?=
 =?us-ascii?Q?pBRtAHMWeduZvG7HG8y6StYysoBp9QGjx5hgy7Lx7GLgOxnj4XQG3oe6syeh?=
 =?us-ascii?Q?Kdk5jWhyyQ73CWE16CiGcHZ1SEWSq2ivlenVaO51zKjUACmCuj/CDbEl/eSP?=
 =?us-ascii?Q?E/EfECK7vZm+BpsAo4TGk+d/hPsHgY2A/wyNtPyK4ifTb2FpWCoTBV8aQV63?=
 =?us-ascii?Q?n3kgSQqdepXO76+DYd8dgXBdOQ3h/B/ZoMzL5IfA37UTvBj/igNJrg2At6kc?=
 =?us-ascii?Q?HDaBiCaynl3Bj/sx8FFccOM/MG/jugH6JMpap8WZpYVo8QfiTYQRKJvzQuJG?=
 =?us-ascii?Q?Cv5aJRH993Eene41ktFE+mBZ7FNvAt6zhAPVhEz43IuexyoGH3ydneks/2T+?=
 =?us-ascii?Q?Pt0eXisdufVchqpTdqbv4qr48ezjhzOzm23dgnjmBm9/cb1znfwmbPBK7HPU?=
 =?us-ascii?Q?glBGhTlQnKegdqzv4o8rY46Sk/Px2982BjH89ioT5iJ4KT08+tiMvCkjup18?=
 =?us-ascii?Q?ok9yz57BxZHEF+UTezWH5Vrt+VHvy9pswyiu3kUNbD5bPCPtqaL7e/pzU8ra?=
 =?us-ascii?Q?rNGnT2e1UkuDfbyfkb0m98UI5uuiK7/OKuBU7bP1nifci3GZz3jdct1DLyRI?=
 =?us-ascii?Q?3kYCxGWod+OM3FWO26VyX2TZB8xwkQwT2q4wFZw9dhp2T1KIIRabdMxbV1Ax?=
 =?us-ascii?Q?UlboRvgJN5ojAQoF/pjBqGwdeYrPk2H5HxQL6U0RcHB11ovkDC5h8dW1NX6w?=
 =?us-ascii?Q?lPbQLj+nGW8lu0h4e0g7WaABIM9H/PASHqESKYeWX8MCKmul2j2fWNbBP4iN?=
 =?us-ascii?Q?NUNSggT19tNyPlg7YQj2bLGDxflikFrEcVZP2jkrzjzlLap8+9CkA5t5kuJp?=
 =?us-ascii?Q?wZtp35bCh8cN+9V1ZHFCUslKPrngoQGytZhZHMvtMgWXIW6adT9q+/2cjmSl?=
 =?us-ascii?Q?J8wETnVws0Y73soiba8E3WR2WG+leXEtFcXzhlje9k65oUkThuKtvMyonDZB?=
 =?us-ascii?Q?K84fCM31mmtAO1bk6u0VvuOR1m+5ceuxqNYgXvrtbPrUv2v5gbpkE+pYF8YJ?=
 =?us-ascii?Q?knz13CcYHUHQLyWBKZFBe8bMEYVf/2N2dD60MsutBgv5muC7RVDRuF1I/gwX?=
 =?us-ascii?Q?hruW6/z8ZXOPB0okZApOEIKQ9GU0xGAwk7+8bup2EY73Y9nPIDc7HZGSNT9I?=
 =?us-ascii?Q?UhTupk2ewM0McGiwzWzsBCzdHeVbY1plYj8y2deMGGKK5kt2LZhQoNFQAIXX?=
 =?us-ascii?Q?m+OSdmyc4o9OWCShn4t+9/to1fJ1+EaEk4ur1L1Mfw7nMiRrCWIBDPWrvoLv?=
 =?us-ascii?Q?18HEygrrXYNLbVX+lP2lV03k9wrxTbHP1pEyfgperFWE8PxLujheyeqRSQXD?=
 =?us-ascii?Q?VGoMwLex+3F8wAeaBAMZdMaFyzIbxOfhxyuLOuc1ioa+U1iLrNThfTWFdehB?=
 =?us-ascii?Q?lsppcaHphczuQSOkQj8wWvrbWpyAm33tGvWXY8ezBTw+Z1FgzbMW/Jn8nTFq?=
 =?us-ascii?Q?VihP2sX1BG8wyqR238CUevYKfwTK5X60fpoV7Tl9+lU7D76DKBhBwJLy4Rjp?=
 =?us-ascii?Q?mGZDAmNYHBfoDFWJLkMRkrU=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR03MB3399.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?iUsYU6U+2+jPT0QqUE9hueXwyZsBynIRQ+zAMbGfqjgK/J9Sw86kevPU4E3C?=
 =?us-ascii?Q?Y7OdKHeeBblxEM+fjppkUDgTCGghu8UCI24k8TbVdTkryyH1i3SwTwBl1wnH?=
 =?us-ascii?Q?peObVg/V3cSscL/t/DiQDfal0eg+Oz8INH1ChqbYN0WIFbczheJW+s3nPwqT?=
 =?us-ascii?Q?Np7aCaT+Wtv0CooI0upVp8vIankag0BWqh/fZO/qKWlyzMVPQ1WthbKDSM54?=
 =?us-ascii?Q?LLC7Mf447GjcpFRNgq3qf4+gXAbuRT0pEaJ0TQDFWJGHFJTXXQgdRdU7XCN9?=
 =?us-ascii?Q?tuqsKUwEgNfb0ROMsuDpakCkvPYe9JjQXitAp8Nwmyoq0S62F3eZoESgt/ex?=
 =?us-ascii?Q?ULaxMbwL9pMMeIH8MaL1OrfJ9jp4iZHgxrcnzsrmB1k34F4/ETfOB7f+S5TU?=
 =?us-ascii?Q?uNAOqKLARV9jnRGVS/VN9dIO+mQYQ51iJF6MgmZW+wQRdnKDbfltiF8LvUEp?=
 =?us-ascii?Q?2hSe5eTiszfFE3VxHH60uiqi5BelLEdndQ8IEtieYMzaF4wA7cMefZXpY3zZ?=
 =?us-ascii?Q?/Ovdavio7LvrF5D0bdeewyiy/0FjxQpLQeGP/4m1cvsYrAciS5vudiyUroHZ?=
 =?us-ascii?Q?tt96JWzgagE9RWYS92iJVE/EhZOmg00IOy0DDgx3AjX4aQw4T95KD9B5ciEq?=
 =?us-ascii?Q?F3jiir7axUu4e3vWuDUpwF8D4TKjKxxElpYMs6r+sMHCCmIgrQD1+LU1+oTd?=
 =?us-ascii?Q?ekdTnyAQAFGVFI6CHkECNj3+/IFmwozPAEbLTvEs00GpQ6EHytaQGThTgDq2?=
 =?us-ascii?Q?z57WjXRa+04uECeLzwxgmEZDDz0qOS3rRK5sMTBuy0YmCk2nxWEEQVe39FQw?=
 =?us-ascii?Q?eWu2EbI5TRs+DqNhbDJ5BPxLyYaB8cgCrfdPtmm0rNiDII0M/dsbSY++UiGq?=
 =?us-ascii?Q?760w/VzddGlIO56uauTwepFmJilJHkPuprgQAAgqhTOKtrpFKiiaDqWWwBDU?=
 =?us-ascii?Q?vWzKvJNr0pJ7MRVNk8AyxZhe/kTez7zd32qcJPbI8TgMWQ5rRVXS5bjyWG9Q?=
 =?us-ascii?Q?q2NZ/WxL+PBMEtVQjwcYCu1+8hIj6hGJTUp7OPpLoOiYjLK42S7tLIorFGY2?=
 =?us-ascii?Q?AJaKH9RrAD9yf6qvobn2ONp3xGdexEE+k6YHKBUxU8pKsTpirPPI81xxNVPA?=
 =?us-ascii?Q?fySV+ZwHC+RxRqf3W27LKBA1Mw0RWkGG8PYiYTIs55zFbEHEQs2e65rzBk0R?=
 =?us-ascii?Q?oWrItotAenEOLC4AAebHJSZ5AuwkPxHr7y3f/dWVBOoZgjtrakibOSj5vWbt?=
 =?us-ascii?Q?E5iOcjEwdp16Akzg+xHlhE5ezAeCTlIcFF4+hqHjxRMGQ1RFRpewVVinvAS+?=
 =?us-ascii?Q?ivy+OfkwunQzuW80f9KuGmuZAKTIdrDjIUAyb/CSFmRKImOQ5mzA1k4vrrx4?=
 =?us-ascii?Q?CBiexTQgwPLEzY9V/Hlr3WFn7Zi7T6PnKwUbrjtO/vCXJLBL5Nk6R0I97zzC?=
 =?us-ascii?Q?bSABwz/xIkZfbIz4A+F+ktuHN1fgqSHNOHu8voLP8YIx/wuSvketYJFeyaje?=
 =?us-ascii?Q?WpYdZKBrB86c4w9s/FL9HpRVdYwmbG4r04gEb0KGnqn3DMaTmaGTtCn1x0Ek?=
 =?us-ascii?Q?rHNLdGZDAaii3m2dji+Wanh9adU8152HLwMFwZ11he62h56Q2vMrAtW4xfTv?=
 =?us-ascii?Q?+EDhT+w7emX2MdM/eKAuj03DMD5q1s/IIbThtSQ6gDplQqytS/RcvXJVi7Aw?=
 =?us-ascii?Q?DebK4SZnaEkFPsz1aG9cglOvjK4lnneC7p4DVJxUP1Vd6gwkAq+XGfcFe4qp?=
 =?us-ascii?Q?HIQTIz41sg=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 33d49162-41c8-4023-50d7-08de5f54cfeb
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2026 16:38:20.3323
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S40AEVV/vJ5cIlMZvHIhpcyki3VKLJlC5KIMYNrJVeyF2baz5l/yZQ7b1XKohC7VJIe1N6Q0p/CUORS+m4JPE3JwlAcWIxRP8vINQwHQfRM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB5631
X-Proofpoint-ORIG-GUID: 7WqlKFd4fGBtgU2ojOjEe6uRU0uqozW7
X-Proofpoint-GUID: 7WqlKFd4fGBtgU2ojOjEe6uRU0uqozW7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI5MDExNiBTYWx0ZWRfX/HzCe8gBUXDx
 EofgDQ2kuns4afi2pFBIwkJsIf0XJBAYj2i3HNaHbrSmRQ9NEfiF++qoNtEP5xDYIhykKKwRPhz
 JVLeoRDVnl0l29LO8mLwbhxhi8ldofMpmlcIVnoiQ/8gYlV1L5uU/3gCr7VspbpoPHd/q4nokxF
 UfPwG5wBYV2aZlZfgadAbPKpsEyNpiYH6OTWO55Js0aUu6RbqTVm9EjXOA+YP0Xq7SxFUVewjC4
 tdwJvnyZkrd339s7CAM898iBQV8EfhGRoh24CTSqnRhCyVUY9FGN75SfF4e4bhc4kD21XYLa0Sd
 WDSTvNzLyA9Uh+N4gXx2OPB0umb24WW+a4AnaDhSg+MSBdqTiUWZXxGTCBLByLIA1R3TQP0rhLV
 EtACoOTC/W5s1IrFKsxUZuX7GwRV6uWv4AFI7t0cPNXYqw+KB7EJrMLgGkLwZfmf0Z+v4t75g1W
 ww6PbbcNWBfqQ3t29/w==
X-Authority-Analysis: v=2.4 cv=IsgTsb/g c=1 sm=1 tr=0 ts=697b8d00 cx=c_pps
 a=dctP2Ni10a9Sh7weZd+SyQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=gAnH3GRIAAAA:8
 a=IpJZQVW2AAAA:8 a=pGLkceISAAAA:8 a=76Sag7VJjJ0zmdUs_7QA:9 a=CjuIK1q_8ugA:10
 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-29_02,2026-01-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 spamscore=0 adultscore=0 impostorscore=0
 phishscore=0 clxscore=1015 malwarescore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601290116

> -----Original Message-----
> From: Jonathan Cameron <jic23@kernel.org>
> Sent: Thursday, January 29, 2026 6:25 PM
> To: Miclaus, Antoniu <Antoniu.Miclaus@analog.com>
> Cc: Hennerich, Michael <Michael.Hennerich@analog.com>; Lars-Peter Clausen
> <lars@metafoo.de>; David Lechner <dlechner@baylibre.com>; Sa, Nuno
> <Nuno.Sa@analog.com>; Andy Shevchenko <andy@kernel.org>; Gradinariu,
> Ramona <Ramona.Gradinariu@analog.com>; Andrew Ijano
> <andrew.ijano@gmail.com>; linux-iio@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Subject: Re: [PATCH 2/3] iio: accel: adxl380: remove unused odr field
>=20
> [External]
>=20
> On Thu, 29 Jan 2026 16:11:58 +0200
> Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:
>=20
> > Remove unused odr field from adxl380_state struct.
> > The field is declared but never accessed in the driver.
> It is used in my tree...
>=20
> I blindly applied this on assumption a build test was quicker than
> checking if you were right :)
>=20

Oh, I applied this against latest master branch where it was valid. Saw now=
 the new patches that make use of it.

> drivers/iio/accel/adxl380.c:271:8: error: no member named 'odr' in 'struc=
t
> adxl380_state'
>   271 |                         st->odr =3D ADXL380_ODR_VLP;
>       |                         ~~  ^
> drivers/iio/accel/adxl380.c:273:11: error: no member named 'odr' in 'stru=
ct
> adxl380_state'
>   273 |                 if (st->odr =3D=3D ADXL380_ODR_VLP)
>       |                     ~~  ^
> drivers/iio/accel/adxl380.c:440:42: error: no member named 'odr' in 'stru=
ct
> adxl380_state'
>   440 |         *odr =3D st->chip_info->samp_freq_tbl[st->odr];
>       |                                             ~~  ^
> drivers/iio/accel/adxl380.c:518:6: error: no member named 'odr' in 'struc=
t
> adxl380_state'
>   518 |         st->odr =3D odr;
>       |         ~~  ^
> drivers/iio/accel/adxl380.c:1967:6: error: no member named 'odr' in 'stru=
ct
> adxl380_state'
>  1967 |         st->odr =3D ADXL380_ODR_DSM;
>       |         ~~  ^
> 5 errors generated

>=20
> >
> > Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> > ---
> >  drivers/iio/accel/adxl380.c | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/drivers/iio/accel/adxl380.c b/drivers/iio/accel/adxl380.c
> > index aef5109c1ddd..4c584f6ec902 100644
> > --- a/drivers/iio/accel/adxl380.c
> > +++ b/drivers/iio/accel/adxl380.c
> > @@ -206,7 +206,6 @@ struct adxl380_state {
> >  	struct mutex lock;
> >  	enum adxl380_axis tap_axis_en;
> >  	u8 range;
> > -	u8 odr;
> >  	u8 fifo_set_size;
> >  	u8 transf_buf[3];
> >  	u16 watermark;

