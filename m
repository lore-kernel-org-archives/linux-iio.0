Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.139.77
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793093835;
	b=X8+/3aE4FgMTXIqzkd8EMSb8NWskrROu/W4aBXtzKhEO1cIWJsKG/QQH+djm85w2gWTV
	 uZeeyd/5d1UfMx9pOz7M3bSPm+h7Fu3GMujkexDS03h14+N6JU2I4SbK9jcQ5xHa5u9Tu
	 nJhZVgvmeGnHSFSI0S1fLECRN7zG//syM5YR6NE3nwx2ngBZIpEIjS2X0Pj8JfSMZjre6
	 WYEZSbTiwbefczQy1N7yuhEJgbiQybVWZIE0MZ+4qLllivZ2BfS8Jei79sKVtrACCgU9l
	 4MeMyp7XeotZV+z4nfmIvvs7XdE6KPNyKOQfottI5ntCR6GukkaMELdwETCNFtARL1g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793093835;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:Received:From:To:CC:Subject:Thread-Topic:Thread-Index:Date:
	 Message-ID:References:In-Reply-To:Accept-Language:Content-Language:
	 X-MS-Has-Attach:X-MS-TNEF-Correlator:x-ms-publictraffictype:
	 x-ms-traffictypediagnostic:x-ms-office365-filtering-correlation-id:
	 x-ld-processed:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:
	 X-Exchange-RoutingPolicyChecked:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=zxxYPUPZxX8Yh50FvqwhZYjRK2rUEheMiDcyKlv1g40=;
	b=rbRe6oMHwp9+Nen3/xhC0RUxsbhHEXW6aMsV9sU72msBXjrxLZkc5AknmSGMNMPTOEmb
	 Dbl9I+3JKD4svPT41ZWpEur6vchanE3x/ubZFlJ0Bxk2VhVCk05M9/zLCBOZQkj04+fIC
	 OHZYXW4bfuthxDBur1h/A4YgNYw6x+bbnqRkWW67RMrRs1ZHbsL8C4lJYuvelW4Jgt8eX
	 cx74uV7XGLqlbU6hhExWV+TkJhuVBxIBXvuWJ7oyo9MgvjBvjnUBacXdzOPR1/KWmx4k9
	 RDr4+HgqZY3+RNrf7vsvSX23ujwxKuOnSo1osBhmFLh498uz1JC/v14YqmHvhB9Jdew==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=bnyM3MAn;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=gMT8RJQ5;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.139.77
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D606C606A31A;
	Tue, 27 Oct 2026 09:37:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D606C606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=bnyM3MAn;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=gMT8RJQ5
Received: from pps.filterd (m0375854.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69R8poI12145756;
	Tue, 27 Oct 2026 05:36:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=zxxYPUPZxX8Yh50FvqwhZYjRK2rUEheMiDcyKlv1g40=; b=bnyM3MA
	nFDO51nJRse54He8syFLFKN85AxkuXOF0GAyYgg1j5p7khaYj+yMrnfZ1eNCb21A
	hhZsmC7i2N3oALby8uCxa2g3DtWvlbSB2cL4ngPXiyS6TSvQnjuQANtnWmvA8btv
	9g7TxfNuSEUcsL0iBpJ2v/sdIbYFhWJj0XsJYzmyxFxsE902HGqW4Zp/mR0yCbko
	YF6RSFcsANvPkNink1DNi2irXZ7mkgH02jpPtUFzowQn6q43+V1+2QfsoiWuk5pX
	vEl6qvH3F8528XIkhPYqEJUG683qJT4slGCK+FSZjXEAYay4LtZ6DXEZ3lVWr2KX
	0ctLrrZQ440xuaw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=zxxYP
	UPZxX8Yh50FvqwhZYjRK2rUEheMiDcyKlv1g40=; b=gMT8RJQ5FMJvQAMv1c+ZZ
	ZvOU1ayi20+PXIWZqVEpjng6SCuFtJt1nyVlnWt83Y3R7K6Ijrs/rRTHUKtiBemL
	vF3tUriR8+Ziq2nyOaOv/Uc5rO3P0e0VzrFoJPMXO2uDgyuwTTaY61+af5rJYjGE
	bgUsEKFlKYDDrnYuxFQVQZn1BSwnoVbP+A8Kv7jTVh7qee2rEMuxcJZR05RxWe+J
	L5twydqos4gxELrs7yXmn4GCkrP4dD5mlRfgikbUSv8nrm6J5bUTR91Wx+gtr5nm
	wa2Lz/jGDDbIhGCdLAQ7MuSZrnGX+uDGHjmP+mi+AfBlDLFn5sFIy0NPC2uh66Bj
	g==
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011041.outbound.protection.outlook.com [52.101.52.41])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4hjjb5t62j-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 27 Oct 2026 05:36:49 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mn605lOSShKsF9iyVLYhrgFWOOZf4mwfYSoF8lzmrxI9i+m6AzoPE6lae2H4EAKjMYKeaU7jGuMMPmAnG9tHPfW/faX5hr/IdX8FUT/i7y/0ilWk62gxLP4Tb9yi82qguvAR7+nM+gllRk2gWrKKles+socmUlSw0QJPFEGDSdl1UA7+UyZ2EWaRQtD064G/Fpa4fCczpnlbVG0BBu/OYVuCh6HMIgFUk7meoROctwnq5tJx+cVy+IN0TgLSXNJ3RTBYr5YZYSniJYIDx9RGSKjWhhR9wd/FnY6Wyv3AhXLxulWoP8CDki4coQCI93JvS02vp2Df4mu29eid9FG7Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zxxYPUPZxX8Yh50FvqwhZYjRK2rUEheMiDcyKlv1g40=;
 b=ur9t/37bMEN7x9z3BD81vkJwHW4Q4sfz6rXov4gIWZ5+GP2jp1Qpgd4hcVZltXWdlVHyKHTbGlEbrfIoRajA+kCYmpJwDc+D4UTpmRjf6/dKkTD88TksdKVfXZLme7Nw7FxFA4oWbPJOg8DLXbAW8Uti6OJuOJ116dXDs7NMYCFvYlHYEIPf4/umwRLU5m4iqgCQjiset232AqtSJgqJxIgkbQApC7rGw7mzMJWcbGfrtopoEUx4WIYoYLUcw3r2CwDlnZ1Vdkl0WGLlFVbcKkuvZP0zOSxZe7utJ+L4JMjPb8qIAx2biRSLn2MsJgMmWof/kaM0VSkw6OWxj2yqYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from LV9PR03MB8414.namprd03.prod.outlook.com (2603:10b6:408:367::23)
 by LV3PR03MB7335.namprd03.prod.outlook.com (2603:10b6:408:198::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 09:36:47 +0000
Received: from LV9PR03MB8414.namprd03.prod.outlook.com
 ([fe80::d661:7c16:d052:cc81]) by LV9PR03MB8414.namprd03.prod.outlook.com
 ([fe80::d661:7c16:d052:cc81%4]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 09:36:47 +0000
From: "Sabau, Radu bogdan" <radu.sabau@analog.com>
To: Jonathan Cameron <jic23@kernel.org>,
        Radu Sabau via B4 Relay
	<devnull+radu.sabau.analog.com@kernel.org>
CC: Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael"
	<Michael.Hennerich@analog.com>,
        "Sa, Nuno" <Nuno.Sa@analog.com>,
        David
 Lechner <dlechner@baylibre.com>,
        Andy Shevchenko <andy@kernel.org>,
        Alexandru
 Ardelean <alexandru.ardelean@analog.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        linux
	<linux@analog.com>
Subject: RE: [PATCH v4 6/8] iio: imu: adis16607: Add FIFO-based
 buffered/triggered capture
Thread-Topic: [PATCH v4 6/8] iio: imu: adis16607: Add FIFO-based
 buffered/triggered capture
Thread-Index: AQHdYtEldoriJAPt/kCdLx93Gi7oJrcO9tAAgAIqHCA=
Date: Tue, 27 Oct 2026 09:36:47 +0000
Message-ID:
 <LV9PR03MB8414024B4B8A88109DE96B29F7602@LV9PR03MB8414.namprd03.prod.outlook.com>
References: <20261023-adis16607-v4-0-a4d541ebfd13@analog.com>
	<20261023-adis16607-v4-6-a4d541ebfd13@analog.com>
 <20261026000910.328f6cd8@jic23-hlaptop>
In-Reply-To: <20261026000910.328f6cd8@jic23-hlaptop>
Accept-Language: en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV9PR03MB8414:EE_|LV3PR03MB7335:EE_
x-ms-office365-filtering-correlation-id: 478b2482-f0c3-404c-3715-08df340dd240
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|366016|23010399003|376014|1800799024|6133799003|261026121527099003|18002099003|22082099003|11063799006|261026135527099003|56012099006|261022113327099003|4143699003|261021121427099003|10067099003|261022115727099003|261021123027099003|261021135927099003|261021133027099003|261022105027099003|261022075727099003|261021130227099003|261009223027099003|261026140227099003|38070700021|261026130827099003;
x-microsoft-antispam-message-info:
 yQEsb59BNfoXM1aLkw02gW615o9GXcKYRqIQNPIjgdsq8YwZQx49oM6tRjmF0sGSN4VeYQfVMMb8QIHCszYTMc6NT34ZroFSevDUBC57R73/FqKhLyV00WcmDTR8U7SrQinmDmG08+MmCqYR3vAPBqbPw1N5nzc1OM1FMy1XCaymjUdhOmdaRorqUO0bZyoAB2qtZ8j8mGw5u3FKunk5q0h0veAuaHLqek68zGq5x3R46+pGNLfC1oUUyc74raXBLj0w3BdI7dd9wH//PmUfoYpltcajYGl941lIZtsPLM53EZhDuVAmRBAS2wbR4uSq8oyW4bvxI39LYKN/fT7XuqqqcTNpgfIg6wLrW0RMPc9v1S1AlbONaAN/lA+vdHH8xgbnBhMwzGJYuQQb/Hx9067F9+Y5FzBZqrQpjwLK347myFuBHxfkDPyhj6QQCQj6AyJP4KsWjfcP4ftBwjF/hGgQftKxaHd0ZwCtVNPH/3Dymc0Nknto1CVhyq1WkwWQe8NiYHymSIuWkSxdxgBta1yobYnIiUbC14FGHfXTDkrxYxtWSz1bC5Ohy+j8w8Om6SkB1bKu8lOHeS9qzoZ3SPXnLGI5kxzAO3lPEjqhXnY1shOZsTLXpvEETyQPdxhHbnJ3u/EwxfQG9uSQl5Lh1OvFLu6pcwc0cq4GAv5HyFE=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV9PR03MB8414.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(23010399003)(376014)(1800799024)(6133799003)(261026121527099003)(18002099003)(22082099003)(11063799006)(261026135527099003)(56012099006)(261022113327099003)(4143699003)(261021121427099003)(10067099003)(261022115727099003)(261021123027099003)(261021135927099003)(261021133027099003)(261022105027099003)(261022075727099003)(261021130227099003)(261009223027099003)(261026140227099003)(38070700021)(261026130827099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?uyiSSwHEiBi+WrtjeBOxtXm00MXLnQb4ZinyvXgGJzYvTwB6E/h1p5sr0876?=
 =?us-ascii?Q?ZbmV5c4OXgtLKuaCXbhiZ/ESasEG/ZNWhNA5XgE94tqARuvidFFOQz2pcdRo?=
 =?us-ascii?Q?LrevZGzo+EO8KoxVyH9p14k68CBW0seF4hCyGA3hv3358690946d6qmkZjvZ?=
 =?us-ascii?Q?rnBfncxAEdQix4LxqZ17U7zzEP3tWb3loKbePbIVljjWX7ZctHZl0CXrk1zw?=
 =?us-ascii?Q?3NZtkdTJ8Bm7SgVIZlW4g68RJxUBVx+2gBn5/G2ddEa3U/I1FwvqhvtU1u5T?=
 =?us-ascii?Q?5GoT9kqvoqmhQw/rASp50uFozxml9aYFNpXRJu7YKqZMiL4rK9MJkFXQHyT2?=
 =?us-ascii?Q?Lhl6Xp+2Z8x2tzXDqMIB72TlsIClf7EF22lOkykv8DaFIB1tRx68qCdZqVcR?=
 =?us-ascii?Q?kjK8yVK/cP2hr2IIM60Ron5RVjXTX53W1fQC6t7xTYlS4u1Ci5x5RhBQcpxP?=
 =?us-ascii?Q?ny5ZcZE3gogz/+ZBADyEmdvYld6ew7auebBWmQagk7LW284g/AkWbOpOdiHS?=
 =?us-ascii?Q?0vQY+TvOoAUJ7feJsMi134ZHbMNDJo4Pf0Bs4uLpEh8AQTCe+OXzLm4bpeEx?=
 =?us-ascii?Q?bGBhnGBbwcr5OYpcDwnJMz9MfG/8uhxzJIdFn5wqIDLRf9xY6rusrgPsGQeZ?=
 =?us-ascii?Q?EYii3Suv9w1gqsu7vQVRZknPKnr2qBb4JygvhkNExI3Ydmt9Hm8dCg+fq3bj?=
 =?us-ascii?Q?xyeZI9XVappZqA7fBQAjKPhuhIBElcd0P5sHUYZ6hhqOkORvKgcWnKUEMJSx?=
 =?us-ascii?Q?T/dY2UOX3j34I1V/EimvtwvLMaZb7XLBjXVekgDpOmfJJpxHpzZczpaynWEE?=
 =?us-ascii?Q?Db9WGBPmZ0/7AS8zHYBypZKtGTWsSF1d1CQt/mS9VACo0l1k3yFbkPoLXDBz?=
 =?us-ascii?Q?i/PU5NOFfxoP/QKooUX3GmSdNRkTY66uxzmQpEd9kNXy3JhrZRPQfmKRgwLQ?=
 =?us-ascii?Q?Moeuv2UrI8OEUXcltZ8ljw60XJePtb1R3Q8T0pBsQMst42BIoPrL9+NGCVu6?=
 =?us-ascii?Q?lLvn2jXRKpPdbc03dv8UmznyH9t0Ch3rN8tmmihEK4m7ZZERtKraG+EZ3o2S?=
 =?us-ascii?Q?/5gTSEOfxGLfE8HD6mY2QxEKnVepUkxblKHn9fquGWYHw9eELB+MRGyjGP61?=
 =?us-ascii?Q?w17BPQynxpXMQ1yB/jsTTOAybahnNvKJls3vK+44djzTuMr5a9zIqnkeMSuD?=
 =?us-ascii?Q?F8Gu2QS9U0ep7ceX9KnfQevrCd1nqvnraOeS9qj3MW6oVRnvZh1UiKvatk23?=
 =?us-ascii?Q?fJBvMR5yBMPivNqysgMQQoVYyCyFwklzCa2mpugEcgnFBdqGsExCvCzZTqZa?=
 =?us-ascii?Q?NEz3gt532pfObb7I3OuAflOG9qbLZNMXrZ45/dm74CsbUjeCHAZ1M+TBfFo/?=
 =?us-ascii?Q?ib9g8LMrsrTogrBdKEt+Qty7RTLLbeFDCF/L6xgLz6OPlpo9IASnirQjqNPB?=
 =?us-ascii?Q?73CN7qjxHfG1sWaKPIhX2oaaUa3rO05RjYLSv3XFqoQL5KFjQi+cltvW5IS2?=
 =?us-ascii?Q?2fPRgnNLVCODSmHxxPM+4BdZSG/edU9a9/goNdrO/3RMPS4eYNwSl3mBbYK3?=
 =?us-ascii?Q?U5kchR/QZKzKbdUddZQ0/OdvnXp+G0Lwkc9i/CxbDrCIJJIVvKJ0D8XCE5gz?=
 =?us-ascii?Q?1HPMGMsUW4Eo2es6I1gRl2rBnTelxBHclGWPsbst1Ws3OwGu4aEBAXDeGc+Y?=
 =?us-ascii?Q?mratC0TfneMH5lNtURZ72UF+oytN8uyLpucOBFa9O7Q2LrnL?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	X59O+JiKPomjGf0B5QsI3c7mNKDrFOD74MtwTHOlfgSB94+hpayQzin1DDnlgDVd0loYjcYBm+5Vct29beJgsdBKyqmWRFC09/OtmivIspTxmh4Q564ABYlWTA2euqLzsaZYCMiUBHcthF5edhcKEVQFK3Q1EeGU946xYCT/rCpy+Kz2L6lYZG6mHw2fmln9kGrlJmnT022aH7cc/m08p1RkHGi/2IepBZ/xDc0W8FGaVtssoLGXJl4J4hmgJo5TcqSX+ODOeDwQHLR1gtb97gx1yXuEI+qni7HNTilTS/jk0mQ4F+b/WxM1ELPhmiU5j3+TU3EEzVztf4bdKGBn6w==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV9PR03MB8414.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 478b2482-f0c3-404c-3715-08df340dd240
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2026 09:36:47.6354
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KBzyxOxPH2vJIwTw+rYyZUasHwKE2hIunUcqC7aovgP5TUSjizNSWdiWyBnxspbVvP6NU/emhafG1DfZfOrfUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR03MB7335
X-Proofpoint-ORIG-GUID: y_y02hYBJ-Mo_l4i8Mu4YGH-tfVJGD7H
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDAzOCBTYWx0ZWRfXyoe3/+ZDlFuN
 9imJwoB3bLqcwLkYa6Hymxump+ASliPEfyWlyqM1kb8zRC5b9AwGer8UySrpzhetwF7+ilEeR07
 ewRceBl2WwpdMq7FXpAMIBSoLhUORHqOoKYyv3CEKRXrRBni8I0m
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDAzOCBTYWx0ZWRfX3JCMYH5PSgy/
 BvcUFoPOxztz9Q4gAoluevRegS+Z/a1VW9dX4aFeHsccWF3zbOF7ukScOEQ5X/cV5heWYEXtXlC
 24VYDKz6IELyV3JeBrhwYLxaoDU+83lpOUe1CcE7FAZQTck9HtPTwQ3HW77pwpPkr+fCilTQWgD
 QO5QWVaUO+tdOom0+m2kWkWdFLI7tn5LVDTVLFuk7YbH3DHhFMkmql7aFyaXiDpzYZuYh5fhY6H
 JE5pZzEnDkiwJobL405cYYCJv1AZnHa03o/LPbSZQTANCPygtd3CyzAfoVZihSK9ITsscMVrcfE
 5um65B28GPkC4qLILR9/95Oe7vaQoc5eGB+BPGCa9TQaRgX+NdTA3X9w7WwxuBA/YQI8K2qEN9Z
 OuiG36m07UoXoq52sjt/SIkbWt+5MCtqPSZXgI2J9UadJZwDWJ7PxJAjzrmCtU1EVn5MM+I3BYs
 N7AkgtQR0Hi9lAeq5UA==
X-Authority-Analysis: v=2.4 cv=Vqu2kO2n c=1 sm=1 tr=0 ts=6ae070b1 cx=c_pps
 a=0/xasGIuH+87ciDr1HSmcQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=iZSIUCweCk2Oy3QsdGPA:22 a=uherdBYGAAAA:8 a=c92rfblmAAAA:8 a=VwQbUJbxAAAA:8
 a=pUIHVlswj0nfBI9awL0A:9 a=CjuIK1q_8ugA:10 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-GUID: y_y02hYBJ-Mo_l4i8Mu4YGH-tfVJGD7H
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0
 clxscore=1015 bulkscore=0 spamscore=0 suspectscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610270038

> -----Original Message-----
> From: Jonathan Cameron <jic23@kernel.org>
> Sent: Monday, October 26, 2026 2:09 AM

...

> > +static void adis16607_fifo_push_sample(struct iio_dev *indio_dev,
> > +				       u8 *fifo_data, s64 timestamp)
> > +{
> > +	struct adis16607 *st =3D iio_priv(indio_dev);
> > +	u16 msw, lsw;
> > +	s32 val24;
> > +	int bit, offset =3D 0;
> > +
> > +	memset(st->data, 0, sizeof(st->data));
> > +
> > +	for_each_set_bit(bit, indio_dev->active_scan_mask, indio_dev-
> >masklength) {
> iio_for_each_active_channel()
>=20
> As sashiko notes, masklength is private.
>=20
> There are a load of places we need to update to stop accessing these
> directly but please don't add another one.
>=20
> It's on my list to throw some LLM tokens ago once I get out from
> under review backlog.
>=20
> https://urldefense.com/v3/__https://sashiko.dev/*/patchset/20261023-
> adis16607-v4-0-
> a4d541ebfd13*40analog.com__;IyU!!A3Ni8CS0y2Y!9cguUuIwYMdnmBcoNR
> ye0_U99KUnJt04T6XlSnvS-9rxh5-8Y2fQXC39Mxsw3erc_JwvyFp3ssecZg$
> Check everything else reported.
>=20
> FWIW there are also some nasty race conditions around active_scan_mask
> being available when the buffer is being torn down. You might
> want to close those off by claiming buffered mode to prevent
> such a transition.
>=20

Agreed, I'll switch to iio_for_each_active_channel() and I'll go through th=
e
rest of the Sashiko findings for v5.

On the active_scan_mask races, I'd like to check which path you mean.
In this driver the only reader of the mask is the trigger handler
(fifo_push_sample()), which runs as the pollfunc.
As far as I can tell, iio_trigger_detach_poll_func()'s free_irq() waits for=
 it
to finish before iio_disable_buffers() frees the mask, so I couldn't find a
window where the handler sees a stale or NULL mask today.
Even so, I'd like to close this off for good, so that a later change to the
driver or to adislib can't introduce the race.

Claiming buffer mode inside the handler looks like it would deadlock
against iio_disable_buffers(), which holds mlock while waiting for the
handler in free_irq().

Would snapshotting the active-channel layout in update_scan_mode()
(called before the pollfunc is attached) and having the handler read
only that copy be an acceptable way to close it?

