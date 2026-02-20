Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6052280A51;
	Fri, 20 Feb 2026 14:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771598523; cv=fail; b=BUrV9PmM2a7tJH5oKNnvIMvYX57gCgjIOhBDQBIzTF81aOZAP+CoO81mnPgpyNqr/GjwVx8eSs1msEJoEVg0V2+iQ1QRMlcAYxfkTOE3J50k41CSnraFJTMRUxjj4ZcvyT9I42npodi2XDO+0wf+mwtDf38PEEELMfRrfCjFADI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771598523; c=relaxed/simple;
	bh=Uenep7ezeNrElFA/ru1c02KXEBFGzu2Sd5s+zPRwvrs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Tiaix7c0RZrMEHXp6HsV4U1whINb75JAQJ73lwNSDhuzQhxMYboiUfwPlFqLex92TonRFHmCbG85oyIfvcjFVcZiGRx9wVPm4a0pphhqNcKT2w+AbpUG7nLsuTYBdTJSPU0mo+fLC8601xB6uwWSt8+9L9vQxRRpi5osKIJtLvM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=salFu5ma; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="salFu5ma"
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61K87YwH570047;
	Fri, 20 Feb 2026 09:41:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=Gc8fA
	zCydJNUl1NHarlBS8gqmLbOeSUhwE7/lfzt+fA=; b=salFu5majf/PSZRxR+4gT
	Yq/TIinP6YVOjRwAYXNoELXtt6omRX3Y+TL1WQ56ey/yKR/uzarGxTwrfGkjqWc/
	QtjVp/0QjqnthF2E12eCwG4YAZF9QnxMmAGLdeEueFCcew354XKpr41k4qS+GcuF
	i6YAT0Lu8i0ULVwJcEARYy2aET/94/4Jg18pd2+OC/jDFMhCk4ipmJsc9C+Rnv5M
	Sj9pB5RZgxLtYcSYv+LPdVxNMkUFdKcBOtjebM1x0eCjwPJqsQd45espXcMIh+5c
	rQNHGY0Z59k+OCns/db/RqWq/TJhujx/HrcDRGxRulA1qhBzfzQOKyNk+oLW9em3
	A==
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010052.outbound.protection.outlook.com [52.101.56.52])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4cd33vtm0y-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 20 Feb 2026 09:41:45 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Iiwq6ub+ys9UKeDEXwkbZ//xe0cT86uEifLGmX7ZS+pEGm5pKNwmqaPeUp53DWgA5t7IB+ctHjmJLn5THlQtcsML2HICQLGQE1sbqqBk7m8uVtt5JCuSGIb9DcFzKkBcP+IO2+3BDjvaaNrR0KOOV5u8BQfbramuqbXWnvhUcgpdkTtC8LWwtXlfiLKInuRyfXGFVDG+eFfKh+9SPqx1bEBF/6chJ9ZTbUI4dV0y0kLdCZSKHSy7p1XyhTX4LvsgiPFxbJUoNIR19uAcskxXpGTllmkcmUfNlPyjg0Q3B5hIhZscjgfo3KINhiP8t2Ioox+cY6tUFCnPzjunvgxukg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gc8fAzCydJNUl1NHarlBS8gqmLbOeSUhwE7/lfzt+fA=;
 b=q3IRoeR3aLfGATHsI36eQyIwMHSnvJN9lEQMtJb5mkrsfs/U9kd5Vxcdtq0pl6aVDdQ1a2pLcL1ohmYcd9vvriKB29UlZnMB74pfaHQCSQT/tUgZxoUruI9zOAzDEB1g7MmAS5vlXwuBFANSkcAN1HvuFk8tKFUwSXRainRoKkrYiTQHn0/VxJDMILZWirBRFktadgY3jGaK3S+qBdGyAbYDgtnLKydqcd3PmDAmxvibINM3U1wpjN9/Kj42S6fH5+c7IF6siBTQ9rnvsDPd/bP/KKLipL5QCn3I7u+t9eCUj6UKl6kfEwYCkmB+dZ/mk2Wpb6Bz44DwDOx3njV6KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from CY4PR03MB3399.namprd03.prod.outlook.com (2603:10b6:910:57::13)
 by SJ0PR03MB6238.namprd03.prod.outlook.com (2603:10b6:a03:3bb::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.17; Fri, 20 Feb
 2026 14:41:43 +0000
Received: from CY4PR03MB3399.namprd03.prod.outlook.com
 ([fe80::1527:d313:16d4:2376]) by CY4PR03MB3399.namprd03.prod.outlook.com
 ([fe80::1527:d313:16d4:2376%5]) with mapi id 15.20.9542.010; Fri, 20 Feb 2026
 14:41:41 +0000
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
Subject: RE: [PATCH 1/7] iio: frequency: adrf6780: use dev_err_probe in probe
 path
Thread-Topic: [PATCH 1/7] iio: frequency: adrf6780: use dev_err_probe in probe
 path
Thread-Index: AQHcomqraMlCg9t6FU6THyQNPFaKDbWLnLQAgAAAegCAAAdlwA==
Date: Fri, 20 Feb 2026 14:41:41 +0000
Message-ID:
 <CY4PR03MB3399D11BD9FC75E3A71CDD999B68A@CY4PR03MB3399.namprd03.prod.outlook.com>
References: <20260220131151.74329-1-antoniu.miclaus@analog.com>
 <20260220131151.74329-2-antoniu.miclaus@analog.com>
 <aZhoJlYUzuHXSGXL@smile.fi.intel.com> <aZhojCK9R_iPFcLi@smile.fi.intel.com>
In-Reply-To: <aZhojCK9R_iPFcLi@smile.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY4PR03MB3399:EE_|SJ0PR03MB6238:EE_
x-ms-office365-filtering-correlation-id: 4cc47429-a204-4cdb-cb1b-08de708e293f
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?SQggWCpahDTl/pbxd4r+ThdASogZUrteX8YE+MZLN0WaLsbdRC7CN5ktCt/F?=
 =?us-ascii?Q?HfCwQ7PZGni7aFWZo8wNDy1EMucGuXrXQCT/6Oogsxj4EKt06YFcPjP8I3UT?=
 =?us-ascii?Q?uLBvgnAHNlHfabvnSUtUTUq+qziuVBZNUe/Uysl0edI7Va+jZA1pcOHAq87w?=
 =?us-ascii?Q?T1+gMUZmO0gmZdYO9V+6Ap4qGWF9D957grAtn97MwFj9YYtGGy45mFUHW7lZ?=
 =?us-ascii?Q?IBlnHuj0bS+6SABHi22Y8xJErU7+IAWJ+7t6s3H5Ap2D7EXLDolhoGt8j/tf?=
 =?us-ascii?Q?eQunQ7K5LDIp8aFe/eJTvm71cz07qCnVwYoD6FZgqTj2eQzepq8+ayeeln7k?=
 =?us-ascii?Q?+lTI1aiQAdQNRDnopJn818vqsbhqn1ntwudtgSVZlACKHn4zXHXrx0QFE2bS?=
 =?us-ascii?Q?Xd4nLY7/GHWNaVPIbfCB6Xe6ldNxWiJ+haT/j7oCguAoVT7BbAvqTc4/kgXv?=
 =?us-ascii?Q?p0GMn3xG3KVpYesBF+7CikCmbHWTgN2NbhTDtGIviDcqBJ12seL+2b5duZRh?=
 =?us-ascii?Q?cUPbe1w2GFfFuuSijs7+04Nh7t0XxUfDegPjfvi9yx/QHvvQnAv4CqqJdCYN?=
 =?us-ascii?Q?Dqu6JavgQMnOgE6gJPz00F2pY0Qbo4dOYa/Bccepm+eSEHoPZ29YjdAEg9qe?=
 =?us-ascii?Q?vXzKJLpOPZPmbXO1/5S3wDRcocEQL3+sg1OiOdoQwhPBvLguJrOF/d2hMt83?=
 =?us-ascii?Q?Zt+hKonHbbPcR0vH6spSX2qb3O7dZEFCQjQ8M3k52FOEUdgfQ4IJ63L25Emw?=
 =?us-ascii?Q?ojhmPY6fRDuFcsqJl/tqlFs3tcUj0CyUsHMPoZkGO2LJp5+xltwdf9doIxIK?=
 =?us-ascii?Q?S1EjuLcq4p5HxYX3q3SO2HGmQuYFimiWrF1oSFCt6jtXE5/2+YiAbkOD5dZn?=
 =?us-ascii?Q?utGCDJ7maz3iMUCfUCc9r3o7lm1xbM7cfEEinykU8yDGP/EFE0jlOTnue/TF?=
 =?us-ascii?Q?vvLKT+6i3vK+0oHHF+XvYOlW0Xy1sU8BX/yIO4sxIOJw7ExUVtRYwYOxb1oT?=
 =?us-ascii?Q?p1D6UJvihxpxfhOnwm8DbYMG96649urN+XSnU5zdD1Jz72tYRUf9Ma2j+8ND?=
 =?us-ascii?Q?lAZA13/AKxWV7TvOhhZhAaimcBXr0H2Rv86zxNHtsobn2ORzj8jU0o1vzCwW?=
 =?us-ascii?Q?W1G7bRHEw7VheEErmYZOgtO/+DoZFRZdKZSNe8aNy5g4lXV4n4daeZzfv5qx?=
 =?us-ascii?Q?PxdOdFdo9yt5N5hPskzUxJCMr3DOn5F8tvRn56P93GePEgAIAbJmVhUiIpvQ?=
 =?us-ascii?Q?5LJk8nmRp8VSZYqxY50djPLKFU/y7jJbKC5volw8Bo0wSZzlSVHgPyPPxzHO?=
 =?us-ascii?Q?1jhBpssy1zq81JbfEsSD1sGTLDstEo9g1TUsb1F+jeBI8YSx09JvLMUlljwj?=
 =?us-ascii?Q?pxCh9XCF/mkixJ0sZo3RXCRyCq+zmBPTRJLJZqkRCpjZBNaHSQjd/iBdAEAT?=
 =?us-ascii?Q?NfJVZP9Pz+sCOM8lG9+7a5RbWehneLZp+RRw/MyYnqgS9/ZpTtC+Q8sRIhf3?=
 =?us-ascii?Q?Fl0H6btZfGhyAFSFkTSjQT1mPUgqgBn4QUCu2rOMU7Zxzv97PkQ9eWv7G2Wn?=
 =?us-ascii?Q?40nUJhjD1LZ0Bd/vmL3XkXoMhZcJPab2GBQt5G/NNNim6XUVdSetkFiLv1rD?=
 =?us-ascii?Q?ZrdQPc0ZAP6290Uy6yb4GoQ=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR03MB3399.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?URK5HS82hdY92w6dPpT+ffigubp9dH/fhx7RJHQcRIjlr27hhEncb9WJaCk+?=
 =?us-ascii?Q?ajD9VxeSDrSmlokihnhtWMefvLxFu3jVCo++oMWNtdRhJSB5C9QxprqAIH4K?=
 =?us-ascii?Q?J97OoMhkJglQQ5fHP4ov3Yq9oTiUNYuhJ1H2zTMI6nlduuwWrNu6Op/fWVFB?=
 =?us-ascii?Q?AHZt5Rs7rP2YdMfB9cu5R2Zi9Z6n0Q90OY3O2l/N7EMuD9WA+Iqc09YCXjcL?=
 =?us-ascii?Q?YEQ2+g7cTPjTvHOqiBeHBOAXBJ60qhF6L7rzI801Kw8cw3CWByHNKMc98s0U?=
 =?us-ascii?Q?/bbzcnwNA3fYdxtjEFW8fBvsCvpfGg4s4rE9sDWqQAHAlwqlMcoW99vT3IDN?=
 =?us-ascii?Q?+7egmLs2B14f2T1yGtkrgBr23KCXiBS4o2qlxmUMQ/0SxG3bRBcCxRxqaJkY?=
 =?us-ascii?Q?kDUzmi4aokjnfZ6klfJjVgPL7ZBPEkHkccw4XpaISV2I6lo1vUp5k6NmHuI4?=
 =?us-ascii?Q?zNga6T96CLpe7+e4vBlV+9mgM/q2k4PlzEtC3Sdx4LurBebYwpUeXONK9ZN2?=
 =?us-ascii?Q?W0l2D64og+jq7GRZDEVq6kapb2qgS5sF37GB0kEpsN92oEK0Xswg5+842OVJ?=
 =?us-ascii?Q?dv6yN/jvKLD5t6JXwkUO0p/b8dnC9AgwkYLGezHmkve5RZbM8q/jwTp13P2I?=
 =?us-ascii?Q?qXsuDFDkGowpqk8Z3/iSriiT2zCouSUtLmdU6l+9sAn/kvRqq64t0gHXYYj+?=
 =?us-ascii?Q?oen97fOkFQHHDLPazMbuCwxQRhkEOeqTNKhsv97jCReRWoZ5ltUs0ZQ/TdDg?=
 =?us-ascii?Q?FfpG3YyDAX9+CeplBkk5gtIP4l+zcjbjxHMMEcSto2epZ28FjvewmKx9tIu9?=
 =?us-ascii?Q?tKPI3vPMfHNRiME6HsaARUvlegDoyWgUnBiKsDSFr9JhaqyCzr65XshemJ3n?=
 =?us-ascii?Q?4wGYHVttmTAa4JBPdwtGWfsCybhYv76v+k1cCN/CrJMR7e/JBufU2f0Lu6ok?=
 =?us-ascii?Q?J7C7BSdfc+YTOxi8Pak6e54iHZ3LFyIn8dzX4KOaYL0aFLd7IYyHnOYeptxP?=
 =?us-ascii?Q?DCoBtnZpWay1mQFTj8+IqVWBdl1+Myn7D359zheK9WHhFjAsVqAxH0Lg6wG3?=
 =?us-ascii?Q?HEOmvuIaBMYDfssyn32mbxePn2DIwwU61yfnK4YSRgeVL7e3xJk1NW8JSiv9?=
 =?us-ascii?Q?YD8fK3IoGoRa0JNp3FRrR7AXsQUHVDQPgiboV0yV8E/KIgoKOhOoIhljOy85?=
 =?us-ascii?Q?LO2NPiHZTxO/FHeVCI3ZtJ3qDjFL18RFcSrj5BV4B9p0dzRY9UK+X5WEbqCD?=
 =?us-ascii?Q?ZBclmfTu3HYeaYTdwu6ldqLK8TWvad7W5smnT0W41TlpxS1TtsTI3C/O4iL9?=
 =?us-ascii?Q?WJXwr26Y8Q54qg224EB9O1Q72rm8jBI/Ybv6FxUS+omEQfK4RDmWaQ5pTKV8?=
 =?us-ascii?Q?B3pjwj36QmGH/dFswdyWODdJr3evmOShz3g5k0UDPyb/rxulc6sMQdfJ1GU9?=
 =?us-ascii?Q?T7sJEVBmHINMrYi5D8tymR6XOKk8G8/GqlLRiHNBt0sWEyzslTtLG02EeyPK?=
 =?us-ascii?Q?EqmLlWS9+7X2v9CalP3SkMCxt24TtI2Zq1WivMbN9/atk3bXuRUU70Y2n5HJ?=
 =?us-ascii?Q?0VEaM4PQPZI9KCOaG6JGjn17gau1UlSPG1RBqnFpWzvQvXdTU3E0dWkaVLW0?=
 =?us-ascii?Q?CorBFB+RgwBQjsQhpwOzlyUW0Wxs4edqmhlCO+lf/aG08eZXoMeMBYy4pne7?=
 =?us-ascii?Q?/MBxUw1NumL+uSlXDWYlp6VEvSbG8HhBXkI7U20mq4Krv7g5MsBwxVFOBGco?=
 =?us-ascii?Q?HWh47uhZ4w=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cc47429-a204-4cdb-cb1b-08de708e293f
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2026 14:41:41.2589
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C2B3UGJuZnNtrXPpwZXrScqRVq2lweJujK4FXLnu5NErXlkqjtZX9QgvGI9/QhOUoc1XgsXcSd9qJGs3vr4nd2DUwRUwNZmUUiLNzFzfjOM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB6238
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIwMDEyOCBTYWx0ZWRfX8N1r7pZsFBoq
 uKqpmp2qHuHi2HaghXVpndfgEXqTzndS6jYC+7lWzwy4NIp6h9tf4n/6LbNjLYLfnB4eXNXQhfh
 WaTvcBbpEyPSbCN5VZfXqLbfIQppeLBG6Wc1qwd8gA730nnAtLbakBXsoSxXhZUhM5pA9j6oE86
 7U9Fqznxnw+Gz1qf5lo8WGDVLAENQdWErmovuPgAtl2AkceW9UPCr8oJjorJG2uGm8H76A2nZqh
 5ZDAD8HhysdwKA5wDX2ITtsLg0aqxlaQGrDQKc74kkaXxDVUHxhp7lYGfIqMtbkZZv0ibkDGsYC
 FIjW+SBwrxSFivW5dwuJQHYc2OecCsJWyt5b6tWsbhXn1eYuaQis8ak/Zvji/cl+5Dfv2IP7YwM
 ThQGoDNBHFs+4/VwKxjOSHsltwh+//XBQC0P9umUwbbEzfCS4bp3P+JglSyZdKoES662bjFlURZ
 OmDFYjASAFdbXvSKyzQ==
X-Proofpoint-GUID: By--vpq1BdipAgrfaJCoGJ1sImJDNHbF
X-Authority-Analysis: v=2.4 cv=Q8PfIo2a c=1 sm=1 tr=0 ts=699872a9 cx=c_pps
 a=eLvx4Fye0krSvKD/jKlmuw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=QyXUC8HyAAAA:8 a=gAnH3GRIAAAA:8 a=VwQbUJbxAAAA:8
 a=IpJZQVW2AAAA:8 a=_UVAdgG6tuFbAEvGDOMA:9 a=CjuIK1q_8ugA:10
 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-ORIG-GUID: By--vpq1BdipAgrfaJCoGJ1sImJDNHbF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-20_01,2026-02-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 malwarescore=0 suspectscore=0 bulkscore=0
 lowpriorityscore=0 impostorscore=0 spamscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602200128

> -----Original Message-----
> From: Andy Shevchenko <andriy.shevchenko@intel.com>
> Sent: Friday, February 20, 2026 3:59 PM
> To: Miclaus, Antoniu <Antoniu.Miclaus@analog.com>
> Cc: Lars-Peter Clausen <lars@metafoo.de>; Hennerich, Michael
> <Michael.Hennerich@analog.com>; Jonathan Cameron <jic23@kernel.org>;
> David Lechner <dlechner@baylibre.com>; Sa, Nuno <Nuno.Sa@analog.com>;
> Andy Shevchenko <andy@kernel.org>; linux-iio@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Subject: Re: [PATCH 1/7] iio: frequency: adrf6780: use dev_err_probe in p=
robe
> path
>=20
> [External]
>=20
> On Fri, Feb 20, 2026 at 03:56:58PM +0200, Andy Shevchenko wrote:
> > On Fri, Feb 20, 2026 at 03:11:39PM +0200, Antoniu Miclaus wrote:
>=20
> ...
>=20
> > >  	ret =3D __adrf6780_spi_update_bits(st, ADRF6780_REG_CONTROL,
> > >  					 ADRF6780_SOFT_RESET_MSK,
> > >
> FIELD_PREP(ADRF6780_SOFT_RESET_MSK, 1));
> > > -	if (ret) {
> > > -		dev_err(&spi->dev, "ADRF6780 SPI software reset failed.\n");
> > > -		return ret;
> > > -	}
> > > +	if (ret)
> > > +		return dev_err_probe(&spi->dev, ret,
> > > +				     "ADRF6780 SPI software reset failed.\n");
> >
> > Consider adding
> >
> > 	struct device *dev =3D &spi->dev;

Definitely makes sense, but for me feels a bit out of the scope of this ser=
ies.=20
Want me to add the *dev =3D &spi->dev; here or in a separate patchseries?


> > at the top, so this line becomes
> >
> > 		return dev_err_probe(dev, ret, "ADRF6780 SPI software reset
> failed.\n");
> >
> > (while at it, I would dare to drop 'SPI' from the message as is easy to=
 derive
> that
> >  the device in question is connected to SPI bus.)
> >
> > 		return dev_err_probe(dev, ret, "ADRF6780 software reset
> failed.\n");
>=20
> ...
>=20
> > Ditto for the rest.
>=20
> And also for the entire series (except patch 5 where it seems already
> the case).
>=20
> --
> With Best Regards,
> Andy Shevchenko
>=20

