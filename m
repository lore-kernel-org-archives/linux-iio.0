Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DCEE403EB6;
	Thu,  4 Jun 2026 11:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780571028; cv=fail; b=rQg8Dlz+8NcqGS+4scIBcKVgVijUub5O+vl8o62kS6OTvbIDEq9ChIQI6KF9a32WfL1NRtTU7iZHmuAEFPVbRpyXYFP83hJda0szojnPXEeCJ/EqNDw4/0VN/VLFx8QvJHF/j3g0O/NAf3Tn/tj0F3ZWXgZR+ULJLhgKnEFEiYE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780571028; c=relaxed/simple;
	bh=00gKKzrU4tVava8pajqW9SVBgMNNpgutVJEiARAXcZk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZQOSlYLRSMokpcK9ZtqXOf43GyLq9X1nXwrlZ11P6k3tbuI60xG/LCkYjapmyZiZEiQLmHtSFiA6JCayJX29RKX7q3JpUsp3w512pxkVj6C/YorXXscnxIzFH+10pil1xOXlvdqWHMv+ujsK3e6rUvyx/VwNfOyD5twQV387MIY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=C/oZqx8f; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="C/oZqx8f"
Received: from pps.filterd (m0516786.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6548eJa01889381;
	Thu, 4 Jun 2026 06:29:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=00gKK
	zrU4tVava8pajqW9SVBgMNNpgutVJEiARAXcZk=; b=C/oZqx8fUFqDC3rpn3tbJ
	8EsRz9q7t9iNvQw13ZIQjnDam2EesiUTX77WVCLNcX4M/U6YEpJyKlzRT92Ckij4
	0k+M1s0zjEJ93QoHtx+IaIWJNndCwTYLPnjTDp/HFi0S0xceOaf9zZYR/ZYvKdnP
	DJZLrCPhhmMSxPs+iQCVv4SYK9FXAvQG9D9/IqZ+Y44R0HdCLxx7kO4U+y3EDRS7
	KVU68IP9fW+FjyfFZHJjuhcQqZl2BAXodhUaEngDadZzp5ol8elkBtfSWx0d1XzC
	/2golfZ/JPu6r6IO2bbsy/FOAJ4AtZ7vHewxYYoOop4kFdQGE6FRnJNBaN/VWekj
	g==
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012044.outbound.protection.outlook.com [40.107.200.44])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4ejem7d650-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 04 Jun 2026 06:29:42 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SZiWaAqkqAdp0dn7Wg3VNcAefms2Cwua0DNHPiRfT8g7uo5iV6zzZw8InqxDBoIdbPtYeOQYC7n+CN9TuHT85az9OShEZu4Eo/oSo01uCTfuzbcy87PtOjGT52fCFw1020GH6FuuQU4hpcwB1qMsNJaI+NKbVzitzJfeuMhutRI2IKd9XByTiFW8jy6dS/5KFj2sLXEbSet/XTjA8u11LIdSlRAaDXISU4q94hjHfd6rai2eF+a09I/g/6sauPDq94jTRjhoe55k76+E9KD6UzLVRAhO5ilVdhTTbZDFhGE6wmzPV38n9JJeBq122uIBeESUCB4LTuN+o/6iK2QJCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=00gKKzrU4tVava8pajqW9SVBgMNNpgutVJEiARAXcZk=;
 b=JUJG7H6ZA1I/Yl378lwIcIoPFyXEjiFBoN4eRJSqgwWFAd3e99Ds0LALtPCeQ/5FIBs/zdlMX6NiWSsb/mNeP58I3Xv0rqrIlGwRqH2efnKCNeacOfEd5gTc+gZnGadGPl7AcI2Nwja2qCHgcaKa7Sbywf9Rw32lOf1tlcMKfXlfrxocmj3HTKRiYF7rVTv2NwtNf2+W1CFKBgbwoSTbZc/mCyU2vb721A4IEYNYNOKTONQ84ZbEsapSiilDPUgXs4LvUbI6EHPiCnTyarKiE3zzloCJWD0kmtmqUObsX91XUT0/qa0Bb8diKWXDBq/kRkZZ1CXkpZEb0yyaneSjVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from SJ2PR03MB7139.namprd03.prod.outlook.com (2603:10b6:a03:4f4::15)
 by SJ0PR03MB6469.namprd03.prod.outlook.com (2603:10b6:a03:398::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Thu, 4 Jun 2026
 10:29:38 +0000
Received: from SJ2PR03MB7139.namprd03.prod.outlook.com
 ([fe80::dc59:11b7:6a0a:891d]) by SJ2PR03MB7139.namprd03.prod.outlook.com
 ([fe80::dc59:11b7:6a0a:891d%5]) with mapi id 15.21.0092.006; Thu, 4 Jun 2026
 10:29:37 +0000
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
Subject: RE: [PATCH 0/3] iio: dac: ad3530r: Add support for AD3532R/AD3532
Thread-Topic: [PATCH 0/3] iio: dac: ad3530r: Add support for AD3532R/AD3532
Thread-Index: AQHc8/HD25Rzq6dwYEORWtwB9U3UobYuI3wAgAANU+A=
Date: Thu, 4 Jun 2026 10:29:37 +0000
Message-ID:
 <SJ2PR03MB71398672F9EDF35F0DC3A1D2F9102@SJ2PR03MB7139.namprd03.prod.outlook.com>
References: <20260604-iio-ad3532r-support-v1-0-c3552f9031de@analog.com>
 <aiFHOj0dVv2fasD1@ashevche-desk.local>
In-Reply-To: <aiFHOj0dVv2fasD1@ashevche-desk.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR03MB7139:EE_|SJ0PR03MB6469:EE_
x-ms-office365-filtering-correlation-id: b5315cfe-d9fe-4727-dca2-08dec2242dd8
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|366016|376014|38070700021|11063799006|6133799003|56012099006|4143699003|3023799007|18002099003|22082099003;
x-microsoft-antispam-message-info:
 Peh/nL7ten7Ou904i0meSWPTFFtWNGeK9/Hg/VTa1vfSStFRzthahcRis8cz3DssjbMQh2AZe97sPeLBnEg0usDWyPCcmWWX9jbXLCzmh80LFqx+OEa2F3zB7bSLr5nJjp1u5DqBU7Va1vRPfcLeAZwmYTcd8ec2dElDuSulxn/7zBvqdn2b+jFbljPTq1MSWIZd95gA40Xny7hK8XEHJve1ZM2NW8Pk8hGUN8YI0egEm1123a+JDV06M7W7y4E4oigCDwTNPDQakXk8FpCDmpnMvtwI7I22GZC7LQzAVv2uCLyYLPnH3rYz1EbekiNiAZAHIo+r3OGhxVbjG3ebMngDY5WukgL8/NboimGLM3gYd4WRDgtP5xZGN+Or4ubKbshx5jVveQyXFXeWIG2XRjV3/CfNhPuq9Blr4MjoJk5VkH9BDpYsuclKQ1NHmi6bEE681i20jXWSt6On1JY4hplbYyp09hF5X0N4tsTbkLbaplMy0m8j1MtcHzvG46rpop55FzkrFrnr13pQZIjMu2JPy67eY8La90zjDkzaCuhtTFdupt2IZVBhINZfuImgj4k/W+zLZqiec7liDr5KKyG1VS6z2jBSz5/FvglA/wixi/4zgQWz2+D4CCxWKJUF9T/Mpi/+SOu+0jqAXR9Pjw4iMwSpK9pVIW8ftQ5kOFvPfQ6Uaw4+gbGXcpe1yHrtNrS+Ngo6+PXzXOQbGa0RSHRr/lTQbC/Pjm7tRo6UEBZivuDECxkLF6AiFyX6wOUs
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR03MB7139.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014)(38070700021)(11063799006)(6133799003)(56012099006)(4143699003)(3023799007)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?rR40AEso6oHonPT6Te9Q5RR0l96ySDOYgUFT027tvwyC5ozGBd9Wkt7MwnMO?=
 =?us-ascii?Q?TEGUG4T07esqv24v8z1WZ8KfQhkfbpd/IvL6zev9gRhnTeaBR8FiNNaVi0KE?=
 =?us-ascii?Q?WlFfTnUkQdnw5a/D8li0iin0ZB4HS/IPQZUR8at57Ym8eonyXwTllxNxFI/r?=
 =?us-ascii?Q?jAIeQMoucNcZjJOLWkg6NCNRrdVMqyrYOjpl9qDRzpDpONGXixNMF8AlVtnq?=
 =?us-ascii?Q?1cXXrnbNmV/RqnPILQdkkntkg1teFLspWidKhyLOVHg+K9FN5n7uxRUfv0NM?=
 =?us-ascii?Q?4fBcG11SGWqTwlwlbpTSNHTyVG17E3O2etpg5mjOvr/KiZcnh4LEX6FRV1i8?=
 =?us-ascii?Q?J6WZHPO4/4Bk5qSgbRBBytWvkRqTBpjS3XsZ067M+pe//2GDhy6qmlRFUnNu?=
 =?us-ascii?Q?4N8hhpcnk1RPgXdNuJWrtZzV7hlIJ/LYKoTitZaY6EhBHrlpG7C/TKcegqRB?=
 =?us-ascii?Q?ZLKVcqVoqhk/OvZTTLZaa05z032godCKRnAbYEYPjgqF3ii9XLxfo2S+BJF7?=
 =?us-ascii?Q?6GzeiYCCG2y9/PJEwNO2xNyeNws8ihnSGv/l2fudJOTv7zh7yelAcoeKdWtg?=
 =?us-ascii?Q?bg5Ynos9Qb7O8+o3KSITeo67Z0sujIXJrjQNReXnVsNISC5MAqcSa8x3HRnj?=
 =?us-ascii?Q?KThxnV6uDRLce6Hb45He+/C+4oYrvWJ2ikyHXWnV7nLXJ9Y3yQHDt1UDa9+T?=
 =?us-ascii?Q?9r6C60b13Lu3sLCpFc+6J7/3KWfJDCyc3SCLc7JaAonrRpzDyg5ryYnBlaP1?=
 =?us-ascii?Q?l2uTXrtxD6qjEpu7U2QRBdmF1f8wpaG44pvGe/Tyaahs1yl9EXfEgys4/mHc?=
 =?us-ascii?Q?Tri2nNjdYwLsHvStuaQ04BsYJ0mpfa383GNIXb79u74Wy8Xz/NA4RQt9cIOO?=
 =?us-ascii?Q?crpy3AAFgwesxoQYdHM03SteLW21FWM10dobNQ4iNWULxHWXN5Bs7rwTBkNK?=
 =?us-ascii?Q?NsMOFhrG1QBmLcT3V+O+ya4xCkcCx5DTOsOD5dNlXKq6DbvziHxFF4HeArUt?=
 =?us-ascii?Q?Lk8kBhzzKa6BwHHlxPUAQdNXKkVySeyEYyUcQapVivuQW36Y+nVSAsu4kfzM?=
 =?us-ascii?Q?p5CkBbQ9A48zxQQUjzkGcWbHWe61LJd4ZxaYCbZWpxxaU4b/VhxkiJRdfOC5?=
 =?us-ascii?Q?BCEIRJu6OJYbowdbF3FFEWmVxdYFVSIoC0qjtvFQ+uzwCYFGk+ynjHk1jtnJ?=
 =?us-ascii?Q?MUpv/il4CNu18euHrknW+hadr20L+aEBoL8yFp94641v8vTXEhjYWdr8TLrm?=
 =?us-ascii?Q?570f4eNGo6n4qBjnMTZUyIeb3sfLoTJovQ9CKJGtK3dDuTp+rwFSDxCgAEtm?=
 =?us-ascii?Q?3nbvhqlBuUiJ/vj535/UJSE4Pv64jZjn8ItHwGreUZAmpMu1JzrMpO2lH2nA?=
 =?us-ascii?Q?ROzS9km4R5My1R2WyOgz/x+mkRXP0mZBKZPMF5jfaKK5VyYOSie4GKZe/el2?=
 =?us-ascii?Q?EXM7I9bBSUOXnxVV8wamatK3KQktEgme+nkPnNR+nhnrAn6cxylyK4wRQs56?=
 =?us-ascii?Q?crSeWMiecqulJ2Kj0e5nYIx3zwG3UX67W7Ts5rnyR2yyxHoepPtQx1xzqy5L?=
 =?us-ascii?Q?idxS8WFd2KaxCwWtQ68vhi/3kcYOd83Volk0yGB8J0ttAqNruH8PnhfDoiiC?=
 =?us-ascii?Q?RHZi8x8Zxu1syjCwxTbiggF1tl/2tnrUE8yRTh05hO7qCJB7GTmBPJToVwlU?=
 =?us-ascii?Q?MXwwPJC7QdSGgBNi5o8pIEZ1SIhr5REGG39NE9z0T/T3yelFuRyHn4iWdpV0?=
 =?us-ascii?Q?PWL3ml0rdw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	oADkuLksANWs5v03FPBAiVkr9Q+3IUpRGHiMYlSrCMJEmvzdijsagTOJ1lHgq6nflGdqYBr5HiPzieXjsv0O/KqUSfBAof9ZHPcNoYJ1RTN0A9xEeFyHM7iJRfJYT8KBo5uNl1ski/I8sLvd1vxga9CLPOd8TMsVXK6kDbY7YMTevmHaJ1brEUJpdn5Y3jUnKGO+YzygVu4UfoG5zV1kEH8Zhc14/eIKNvmbqDVn+PETzzIsVHo8LLg7YqUg+X1MSxAmt7jZoiC/H3+tDIYGaFGL9DgDF9ShAxqJUuOPVRm//3xtpLVQg2xWeebOgN7b58BrKkDQo+unVw501UFLTQ==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR03MB7139.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5315cfe-d9fe-4727-dca2-08dec2242dd8
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2026 10:29:37.6775
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V9+JLIC4hEC+FHZzAtM6gE+DyfRlRz/I3/h1E08yaOsXx3c60ja2pyRDwvi3rbUeRbVV0FNpD16lqI2U6im+DfB5W/RuBwScdazJrPHamBc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB6469
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA0MDEwMSBTYWx0ZWRfX5Nj/HLRFXV8g
 4o42d1RchWTzjYwVyzvWF19dlF44H6Kf5SPJ9BQ9q62UXVnzEDJ9eqnWw9SogshAspo1zm5ucge
 xo7rmPjCeheZcEJIC3g97DJsRPNq7aB/hXmIttDm6tEZTc5QMOYGYOd2vtpEfmaTxWZs0qixB4R
 EY32MppkZ/7yIgR/t3ZPL6wk/9IJ6ba1qcRr10tvbTnhnCatSIsmYImUfVTLsXok3LeZDCvd1bz
 o3h3+1D1tg+tUSl0xg/xaGbp0guK7CtGUQIJWRbf0FQVua0BA6uihLKOJaBeo3rYiF4e/T4JFtI
 L7bRO7/MD5dA6qF2zJSXHmU/nlKAlrHWQ8R+jjPDzihfXt781VEMhz6TuTiKXey8b2wkTBmJ5mi
 gQcfEzLkw3PqKCpYdBrUqqMBuENfpYHo1wiE1nqIZ6mLRdkUaegycXlF3ynh7aVpa7l1N9ItL72
 Ezymh70lxz+nccrVTeQ==
X-Proofpoint-ORIG-GUID: GC00b0BSwhrAczsrWgqOxpkJbuFd6bNz
X-Authority-Analysis: v=2.4 cv=drDrzVg4 c=1 sm=1 tr=0 ts=6a215396 cx=c_pps
 a=DLgJpnoc0/49jVUGH+L3OQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=ZQxX5BWu6Z8IJBb2zLX7:22 a=gAnH3GRIAAAA:8 a=QyXUC8HyAAAA:8 a=VwQbUJbxAAAA:8
 a=IpJZQVW2AAAA:8 a=8lqG2qo90j1MoHrYzXgA:9 a=CjuIK1q_8ugA:10
 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-GUID: GC00b0BSwhrAczsrWgqOxpkJbuFd6bNz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-04_03,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1011 bulkscore=0 adultscore=0 priorityscore=1501
 spamscore=0 phishscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606040101

> From: Andy Shevchenko <andriy.shevchenko@intel.com>
> Sent: Thursday, June 4, 2026 5:37 PM
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
> Subject: Re: [PATCH 0/3] iio: dac: ad3530r: Add support for AD3532R/AD353=
2
>=20
> On Thu, Jun 04, 2026 at 03:13:42PM +0800, Kim Seer Paller wrote:
> > This series adds support for the AD3532R/AD3532, a 16-channel, 16-bit
> > voltage output DAC, to the existing ad3530r driver.
> >
> > The AD3532R uses a dual-bank register architecture (bank 0 at 0x1000
> > for channels 0-7, bank 1 at 0x3000 for channels 8-15), which required
> > refactoring the register access paths. A table-driven register bank
> > approach is introduced where per-chip register address arrays in
> > chip_info are iterated by helper functions, replacing the
> > single-register setup calls for existing variants and scaling
> > naturally to the AD3532R's dual-bank layout.
> >
> > The series also adds AD3532R-specific powerdown modes (1kohm_to_gnd,
> > 10kohm_to_gnd, three_state) and a new ABI entry for the 10kohm_to_gnd
> > powerdown mode.
>=20
> This cover letter misses two required things:
> - why do we need a brand new driver (provide an explanation)?
> - where to get the datasheet (provide a link)?

Hi,

The AD3532R is part of the AD3530R family and shares similar
functionality (channel configuration, LDAC triggering, powerdown
control). It extends the existing ad3530r driver as the underlying
workflow remains the same. The main difference being the register
address map due to the dual-bank architecture, which is handled
by table-driven helpers introduced in this series.

Here's the datasheet: https://www.analog.com/media/en/technical-documentati=
on/data-sheets/ad3532r.pdf

>=20
> Just reply to this email and if new version is required do not forget to =
add it to
> the cover letter.
>=20
> --
> With Best Regards,
> Andy Shevchenko
>=20

