Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1141D37FF6F;
	Tue, 24 Feb 2026 11:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771933326; cv=fail; b=evgmCsUOfYCqjrggeXrbJutfDovpINJL8HqZHTUQf3d6v1sRVbU5nPK+JvraBcesvq64IZP+TFrV2LJ7uG8EsKv93yuB341S2iqFn2VnhPwUge269ZFmggaAKJ+QJgkBlR7sQG9wvTd51OedgKBppU4EtRbb4SM2hMb4DMlIxW8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771933326; c=relaxed/simple;
	bh=WKkl3Z8r7SBLm1z7X130QeDONTsY5Z1tq8XlCleejHo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XE08r6EWHD/qKQxR3nDyPYlK4iYoT3dYyAbp5NcP1saxbrdIoQ5O/Jch+NT60WkdunCwTGXGy7jw3oMfKJVwDZboKtA45lU7KfWmKdunOQZvrMlhlxNeB0QyN0vvzaNxC5C3T++9ZXYAsFP1hQAryLGohOO5kq3Sf5YWCt3pAnY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=Jlx9wH1A; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="Jlx9wH1A"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61O9apLL2668516;
	Tue, 24 Feb 2026 06:41:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=WKkl3
	Z8r7SBLm1z7X130QeDONTsY5Z1tq8XlCleejHo=; b=Jlx9wH1AMw9BKGVYIR0H/
	fgPcdKcjmFDX/vfoaR/DHV6hgTAM/5aVLtYwqVK9JHEp6VOwfMhPiSqY6cZ6o0EF
	BfDmr6yFYmIQfWuc1JcIXpmSq7IXR/vSsRsuuD3SJ1whYa9AOKRORYSBWao6L1Ak
	ANRtPsQmNp1m8/CTQ/H8OvoR87M3xpWgSMZLfR/nIxmhRWM+lj/Fa6rD4XRMalZH
	wXnlspGI8XR4+hHNT0qn77Sc+iUBMQLY16Gn3elsVX9E8Z6znkMw+9kt3bhZB1BL
	glriQX6Im/FPsmVH+QAj3tBlLD+Vpq0ANS6hjM3bgN3lcebI/Ryz/moU77ES3LGy
	A==
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012053.outbound.protection.outlook.com [40.107.200.53])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4cg7pbffdn-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 24 Feb 2026 06:41:45 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dSF9rohEg5GSLjiNiFrtlqhVr0IuVUu9Di6Dl0XAM4XcZON8nl/Y5R+Y1em8aqpxUAQc5JEjbUtTIzQ1NKMCFcw94B3HAYzrYfPZhe3QtLCJAze9F2UcdHQ9oUmRmbjJj2WsMKUErdCuEUzhWeQ2QoQAuN6o4WKNvz3YVD/nb+AWM6vX7fLQxtLs1wWItjnrp7K4jHK3iI53tm6ovWHLkaxZBqSZF9KnREZPnGfftZVyfddRClkv0e61Kv/Mcq9OrlsoFgDtrMVewLH0q+lzmbptSzwG7QruLr/rOVDdEttgRoxGXAIvZR4EjOCThnUK18UN0C6L4LQHmsBKAV7Yhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WKkl3Z8r7SBLm1z7X130QeDONTsY5Z1tq8XlCleejHo=;
 b=a0XaDpqaMvayoD63uEBZnA7XN2/bWktAM48jYSr/nMt8f+UTrhAb1ezVDfEJXdOYuAnvcHfu996D5ilqa9unw3G7hOdjqy2m0+fRwUWUHqgmVDZlS07TPOtxUQcGZ5VyN2wPjiMMprNJvWUHvXquTdleRMiaH0f1O+vr8dPZ5GGvGT00dWYkymPvoRPXM0h0kcIhHO9o/ocJ9hnkTTuc7O/t+P0zlowK8M3TT2+XrPwIUDczElFD7ZIvJW37dgCwBMwTG+v973MxD0yesK7wqH2mQW2pT46xpAfbNjFV4/WF9VzNX7V033eNi1EjV5s0uSrK69+vHktmAMywqvY67w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from CY4PR03MB3399.namprd03.prod.outlook.com (2603:10b6:910:57::13)
 by PH0PR03MB5895.namprd03.prod.outlook.com (2603:10b6:510:35::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Tue, 24 Feb
 2026 11:41:41 +0000
Received: from CY4PR03MB3399.namprd03.prod.outlook.com
 ([fe80::1527:d313:16d4:2376]) by CY4PR03MB3399.namprd03.prod.outlook.com
 ([fe80::1527:d313:16d4:2376%5]) with mapi id 15.20.9542.010; Tue, 24 Feb 2026
 11:41:41 +0000
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
        Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Olivier
 Moysan <olivier.moysan@foss.st.com>,
        Mark Brown <broonie@kernel.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>
Subject: RE: [PATCH v4 1/5] spi: allow ancillary devices to share parent's
 chip selects
Thread-Topic: [PATCH v4 1/5] spi: allow ancillary devices to share parent's
 chip selects
Thread-Index: AQHcpOCmJb84+vMLtk+IrvyXF9SSi7WRoZAAgAARdwCAAANsgIAAAD+w
Date: Tue, 24 Feb 2026 11:41:41 +0000
Message-ID:
 <CY4PR03MB339987DFB0BC85F913C3B0A39B74A@CY4PR03MB3399.namprd03.prod.outlook.com>
References: <20260223162110.156746-1-antoniu.miclaus@analog.com>
 <20260223162110.156746-2-antoniu.miclaus@analog.com>
 <aZ142CVjMQ8Dypnb@smile.fi.intel.com>
 <CY4PR03MB33992FF58E620DCE44FE0B419B74A@CY4PR03MB3399.namprd03.prod.outlook.com>
 <aZ2KXVpH9LVl0BdE@smile.fi.intel.com>
In-Reply-To: <aZ2KXVpH9LVl0BdE@smile.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY4PR03MB3399:EE_|PH0PR03MB5895:EE_
x-ms-office365-filtering-correlation-id: 2a271645-c863-445b-bdbe-08de7399addc
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|13003099007|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?LJuQ2+Kfwtr+jxvHEr1QPeLIDF2aKAvgiwtuZAHnMykuFedwyMR9ZlOVL9HC?=
 =?us-ascii?Q?JI5Y/hKqTjlmSBWe3FjbAb9q8tk78zHqiKSJOTaKQ7RVUx3DzXPCgkuM6/rP?=
 =?us-ascii?Q?bKI7K1y+DlkCqaXTBib6tD1Sf4kCSYq7d5T9b0GovkEW2Aapy70rUIltz368?=
 =?us-ascii?Q?PHFKjN5cRplF3imQsHi9TeTXFXXKeTnN7Ao4pCvCVPoHYPpw1Rnz60eZvUtq?=
 =?us-ascii?Q?NNRi6M1rYtWm76KdtGSPfo50HhjFLNyzRXPoqPzZlakFyzEDuK4SYzOt1MLg?=
 =?us-ascii?Q?JPUjZg7B0wkwTnza9R/3lo0MoDmo+0HwCbC70MZ8q1ha3FLGyJZNJ8nF6qSN?=
 =?us-ascii?Q?yGslllsygUypljJ6KUq2o7jWuglv52woXvM5VH904MKDPBw6SnlGg/veyMTv?=
 =?us-ascii?Q?Wx3i9ue7ncCkxw283CgXH3yQp6aSsgRlsbdZc+wWOtjXWPVCDFkGtXphGs0j?=
 =?us-ascii?Q?cc8hQZUJ79mfy46f51rxU4BhD4hXWzr1qTPwyXwCUh4YRJxLfwFSB69tgIYn?=
 =?us-ascii?Q?5DyynAAy6v4R5jJST8IHChdwwZKI0kNA+7UUVDRGWuUJzw3zHADf8wnBjb/+?=
 =?us-ascii?Q?wZyktmFdTMEq/sJFUTx+rDccSv1biBFTQpbzBkKlWhg9n27/pn3kxITolNDu?=
 =?us-ascii?Q?/Je1HS19I5AFMeg3uayxTY4X/+ILtOl4CCCHV9T0wEEdy5XZFtxHpsNMbL8T?=
 =?us-ascii?Q?bib+K31UyPgvm+4b4t6n5VJL2OtsolHAHBMk1ze2runPi457upZgLWmY+ffJ?=
 =?us-ascii?Q?zevedFBRNlVp+8xzEf/tqqbwT+JJeDQ7U674dXYt1nXwgejFuB4AH4PSNPQG?=
 =?us-ascii?Q?3kVICYmpnraOxHqEGV+05CEpS4O+Vd0GdQBPxq1+aGlC+nL53V0+kGLcnznu?=
 =?us-ascii?Q?xZABPhKyp1GStkl7i0xqPUTXv3YQfvRqnKoXTWswiQ7R7FfzRnPHGeJJHmi/?=
 =?us-ascii?Q?JjHd8LbRHVANzfRMmYyGhO5GGeb+5M4OcncDZxYCH8fpyDBwQ9oVeFWywGUD?=
 =?us-ascii?Q?HMKeAtqFJkxoDZ2O8SN1/6slV7vttqsJaBdzA/yc7wfLd75l7RZ8ITpf/Hf9?=
 =?us-ascii?Q?+caTIEgPTkMq3x9r8lxLu9OJWlX9KkbdsvAOwI1C5irll3fenO6OOn0a9IaF?=
 =?us-ascii?Q?qZpDmQGOeyppGuzsODbvo7EUqLvi/H/XlGHeA0wwkzvHb2V9DhhP6cUc9Zed?=
 =?us-ascii?Q?a0GovdFq+cnpDoQNphxFbq1EKh+3VF6k4xBaaLpKr3WOtWmav69MRa6KFZZA?=
 =?us-ascii?Q?Ue9JdiacWlzYslk3ifbgOQmIHpobRgC1ZafE821TIblfcfMQDCLGiQFsZvnz?=
 =?us-ascii?Q?bb6qh4WLh8+XF5wELNU5JNaTatJN6QLFdBomOYysPFmeY5A/OhpqHDtYj69B?=
 =?us-ascii?Q?8mIcXQ5lGqTeBoIqkR+UfZupMlgMJnTzk5Vub8vSuLtcBl4S5lGYAmCQqxfF?=
 =?us-ascii?Q?xtx5PqU0F25fdJCJs7d7PRCdmJeLVmkiAbHz9ipkovuoTcQfa0X+fGypuWsN?=
 =?us-ascii?Q?fLYp52Upg9upI8IwnODHBTkiS7TojyYCWh5bsAwE8Y8HU6v3IqYfCuqf7/b6?=
 =?us-ascii?Q?tg7j0qS+FNRyyJ3PYdojc30CbIj9HaDgRsC+ZXXK?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR03MB3399.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(13003099007)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?rHqc1FpyZvXoiOW0iE6ADBRWHzW2H8FPV9MXp7IorkdlCUW8gn7jQMkjYQcQ?=
 =?us-ascii?Q?7/hpfXh0jMxeTfX0hXsAtCzWmI6+AidLew2RvlVLlS9BPUo8como3vnzrR0g?=
 =?us-ascii?Q?ar9qFQ/Eu5oEAKllnHrt9aAMxPlrAjSFqLmJNpqrIT0qr27MhrJg+Ya3UY27?=
 =?us-ascii?Q?iMnJ0zYON5mZiyzzs2yckvkIhe2JOzZZco9Av5ix/qJJbO4Yp7exg8a9rSw2?=
 =?us-ascii?Q?z8+3oGkNjuUTyHofqjbUpaVgN/0hkoZHX7W38GU+m/KVoT0qr00j7vSMVgAI?=
 =?us-ascii?Q?0gSVo2CsK3bBISQlE3HIOo0EPADq7420CJt96A5IvE1mGuD7fY81cNPxuqk+?=
 =?us-ascii?Q?n35gl/yIfQwjuLZ4lh8nimmDFOqpFDBZtiHz2sidZYOVGNxnxsmya9a/sr/y?=
 =?us-ascii?Q?9qOL0feYR2IbeeGMldR6wQFcg7N066BvHOyFNL+Lu+xfEXo/Vitz/FGH05D6?=
 =?us-ascii?Q?l7/sobpAAnIldgYNcqU3WV8bMO8XVOxsuNFF7PylgbVkU5Hfm6JRS2eAFrPo?=
 =?us-ascii?Q?0QHBDdWL1zMHfJRPp+g7Ey9++r0QR6ihpHh6HiL5LiBThY4BWzERd1/86Ebi?=
 =?us-ascii?Q?4DFUgKpt55kwlac4R6GR/ovSqmKEpfsflkf+CMfoLxWW8j0ZP8V0H+BH719V?=
 =?us-ascii?Q?LJT4iqa+ar1qR8QfUDH2nqG8fvrRYwm4e4438ipURXwvuAjgcXzizeDCTjiW?=
 =?us-ascii?Q?IYXjCExGVJgJDeXjaqcPVgtgMcggdGX9R5MYyNR1rw2p3V5kCoEEjbxIlH1O?=
 =?us-ascii?Q?6Dxk/OC/IrWZenCAsNoZ1KQrGvO+e89iZubJQR8rZ6Y8ME5foULVNBcEDeCi?=
 =?us-ascii?Q?QQcUnuYdX7n79hgQ7C08Va1PpQ9lED56RhkyJiryKdE0nyMNg/ob46n22ivy?=
 =?us-ascii?Q?iicfSz1Hln7lkiECGAKSOsw1jXzWp5j9PPlVHBMlLqjVdpF3LWQLarIxphyz?=
 =?us-ascii?Q?EHF7lRadnhMkKE7K+NFPIGA73DyjO92RHio1CTCOQLEy3bTyBR0KDfCioXjk?=
 =?us-ascii?Q?JWKCt/Y/baX/4ZmvWnMCwfeoSm1ZVkZvgbw3vCk/+0LQGnTLioBoRI7pA7l/?=
 =?us-ascii?Q?m1N3MOuD0gR2gYKsn9nlF4SbwwjQrTWCr/FltP799yY28OSmwWUxZXs5XfVB?=
 =?us-ascii?Q?tSVtn1D/gpw6LmBjlf4awBXQmDoxJxrko4+wQtV45Zu2d63Hrp6Em2YnfDjp?=
 =?us-ascii?Q?52T3YfchTyjDpMfbder+HX2Xv4StMb7eq8+1Zpub3ZQga5eAbTk1YqDUKoZs?=
 =?us-ascii?Q?kyPKZko2WeGi32FXa6sQPc09vSgeeNsu21gDODb7OhT4/pJuxiR45OOGE4zB?=
 =?us-ascii?Q?D6+unjqjFud4I2ZTMMa+yY+wQSAG7rD7R4i96kfwCnIiHAUngWH7qdqqQUyn?=
 =?us-ascii?Q?6JgIisGfr8D8RfD6/tNwU6/Vb+8Hc0uo+yKFO81iPK2Y1XG4tOZ7bYVnjqvr?=
 =?us-ascii?Q?ltMNRqh+ta14DTR7aOdDMwhiWwz/IqitWlWCPz0pnbBV5EOKWSFlrmCl/PQI?=
 =?us-ascii?Q?eA3wcbWV7WdVsJudtdBqckMtlKizeYY2TE1t9iqbeX+t2YhedkupJ6CVcRzX?=
 =?us-ascii?Q?3X9fLMm5KWfxk2+hboyF4AB6hegaVd9MZ8z5xaCzrnqt+Q2iK1e/ow06cLBT?=
 =?us-ascii?Q?TTGsN2vmqjFYDL6xGEgwzMaAxBhr8n00dYHzMTOA/bkpb5e+31sgJnXycis8?=
 =?us-ascii?Q?e3SJ8kcSQDUqPkswt1W0NN2l/gYQ/1rDnRzERpP5+sVXO3azZk2GRZfzS0ev?=
 =?us-ascii?Q?1C5JC4j+EQ=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a271645-c863-445b-bdbe-08de7399addc
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2026 11:41:41.6780
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6Eol6xgFsyQumsCvXVc6mcvoDTzT+z3k7G6iBfY+tTe/jFmW8hS7I992Ncj79R9Duo/mDE8cd/a8XQVxpbBhLay/RRHgdjRdOldZ10vLmaA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB5895
X-Proofpoint-GUID: u9qjiDmY8T6tLlAT_6_CzENTWZF9BlxQ
X-Authority-Analysis: v=2.4 cv=RPK+3oi+ c=1 sm=1 tr=0 ts=699d8e79 cx=c_pps
 a=EGpQrqTzv4Kwq1gVXkqNKQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=N--XFCr6TIEc_64PeIT2:22 a=uherdBYGAAAA:8 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8
 a=gAnH3GRIAAAA:8 a=IpJZQVW2AAAA:8 a=8b9GpE9nAAAA:8 a=QX4gbG5DAAAA:8
 a=aswPhix_XPEOyb-ErbkA:9 a=CjuIK1q_8ugA:10 a=IawgGOuG5U0WyFbmm1f5:22
 a=T3LWEMljR5ZiDmsYVIUa:22 a=AbAUZ8qAyYyZVLSsDulk:22
X-Proofpoint-ORIG-GUID: u9qjiDmY8T6tLlAT_6_CzENTWZF9BlxQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI0MDA5NCBTYWx0ZWRfX/KjS9+ndNUhq
 xCuQJajcjJLqucjFnr0fUC325MMlkkG+sqs/lDwihDzh9Pq4aYiE5a9iML0TqycKzpcMBBdDROG
 10kvBKm+28K09LM77O8TvGMg1oKHfGiG6FMvMKcKde6dUD8uIhhIwLdcr5KR/VBYa4Sso3SKPDs
 4YCQ+clk7kJvSgSFZJ3ReYK7DumucsCbm/eMkQkFp1JAyVa4axDXXXU7CiZOAPd84kGJGEMbXN9
 1NCgx44w4QYANZ+S2xTpsnCnbk8uQl25JCrgVRD7CON6tgT/AeeimHWcwB6lJWdonE84PMhoK2F
 WzrEoNgQJtl5Ab//LxNBoFFZx0wDvD56bSFIWVMPCtwDIajN3pFhWAJ2feJf67YeT2Mr+E6m7IN
 3YJLFiPzUXOvXWZ92yB9D519Pj81CcTuoanHSoKzlS7zYIsU2nc4ktGmUUVGRh8QiIC6boDvE9Y
 4mBmHFX3+McWkgKBpHw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-24_01,2026-02-23_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 adultscore=0 priorityscore=1501 spamscore=0
 malwarescore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602240094

> -----Original Message-----
> From: Andy Shevchenko <andriy.shevchenko@intel.com>
> Sent: Tuesday, February 24, 2026 1:24 PM
> To: Miclaus, Antoniu <Antoniu.Miclaus@analog.com>
> Cc: Lars-Peter Clausen <lars@metafoo.de>; Hennerich, Michael
> <Michael.Hennerich@analog.com>; Jonathan Cameron <jic23@kernel.org>;
> David Lechner <dlechner@baylibre.com>; Sa, Nuno <Nuno.Sa@analog.com>;
> Andy Shevchenko <andy@kernel.org>; Rob Herring <robh@kernel.org>;
> Krzysztof Kozlowski <krzk+dt@kernel.org>; Conor Dooley
> <conor+dt@kernel.org>; Olivier Moysan <olivier.moysan@foss.st.com>; Mark
> Brown <broonie@kernel.org>; Sebastian Reichel
> <sebastian.reichel@collabora.com>; linux-iio@vger.kernel.org;
> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; linux-
> spi@vger.kernel.org
> Subject: Re: [PATCH v4 1/5] spi: allow ancillary devices to share parent'=
s chip
> selects
>=20
> [External]
>=20
> On Tue, Feb 24, 2026 at 11:12:57AM +0000, Miclaus, Antoniu wrote:
> > > -----Original Message-----
> > > From: Andy Shevchenko <andriy.shevchenko@intel.com>
> > > Sent: Tuesday, February 24, 2026 12:09 PM
> > > On Mon, Feb 23, 2026 at 06:21:00PM +0200, Antoniu Miclaus wrote:
> > > > When registering an ancillary SPI device, the current code flags a =
chip
> > > > select conflict with the parent device. This happens because the
> > > > ancillary device intentionally uses one of the parent's chip select=
s,
> > > > but __spi_add_device() checks against all existing devices includin=
g
> > > > the parent.
> > > >
> > > > Allow this by passing the parent device pointer to __spi_add_device=
()
> > > > and skipping the conflict check when the existing device is the par=
ent.
> > >
> > > Isn't this already applied?
> > Don't think so.
> > V2:
> https://urldefense.com/v3/__https://patchwork.kernel.org/project/linux-
> iio/patch/bcb1eb34fc5e86fd5dbb4472ad1d3ea3cf3e9779.1770393792.git.
> antoniu.miclaus@analog.com/__;!!A3Ni8CS0y2Y!_3N9p4aNfQTLDj_PhmYtKj
> tvDUb_XuD11NL_A9Q_MXJ-
> oIMK_bwwRFi8Cc_RFNuRKMFw48sWYPfFKfzH_mLYVjz4Rtk9HYs$
> > V3:
> https://urldefense.com/v3/__https://patchwork.kernel.org/project/linux-
> iio/patch/20260213144742.16394-2-
> antoniu.miclaus@analog.com/__;!!A3Ni8CS0y2Y!_3N9p4aNfQTLDj_PhmYtKj
> tvDUb_XuD11NL_A9Q_MXJ-
> oIMK_bwwRFi8Cc_RFNuRKMFw48sWYPfFKfzH_mLYVjz4Y3O1A3U$
>=20
> https://urldefense.com/v3/__https://git.kernel.org/pub/scm/linux/kernel/g=
it
> /broonie/spi.git/commit/?h=3Dfor-
> 7.1&id=3Dffef4123043c5bb29e61052a41e577ae1ee6837a__;!!A3Ni8CS0y2Y!_
> 3N9p4aNfQTLDj_PhmYtKjtvDUb_XuD11NL_A9Q_MXJ-
> oIMK_bwwRFi8Cc_RFNuRKMFw48sWYPfFKfzH_mLYVjz4-hW_q-o$
>=20
> Will be part of today's Linux Next IIUC.

Oh, thanks! Was tracking it on patchwork and saw it was not accepted.

> --
> With Best Regards,
> Andy Shevchenko
>=20

