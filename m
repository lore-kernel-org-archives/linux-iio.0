Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.139.77
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794831531;
	b=nCbHZ0nnNxQieVqrsu+goUmxhohC+xEPk0iMvxRemfIzrrU7Drh90pO+imP7cGSohyQx
	 em8hAkLpje4zX8VwE9ctzFredaqJuvCFvaRJFTUZGNwj1bZO6olEPKcCIAjwX4NAh24Sa
	 dkezgXE/3AGiIrtVdsfycgwioNk3N2Q6+3CPKNxAbroEFZ2Vn46Yfh+ZKlma7of+MwgJA
	 x/M1y8+EQu1ize/Zjuk5D4zyiId3yqZn7AkSjiGIK76j1ZKoh0MaJDq5lQnYQxsP0QzW7
	 Z5++z4s9NVyrP8HxlDZIjBGAjE98gZWlAhCBO4IkBUjaYn8HlGXs2joiKNT6GqOSPdQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794831531;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:Received:From:To:CC:Subject:Thread-Topic:Thread-Index:Date:
	 Message-ID:References:In-Reply-To:Accept-Language:Content-Language:
	 X-MS-Has-Attach:X-MS-TNEF-Correlator:x-ms-publictraffictype:
	 x-ms-traffictypediagnostic:x-ms-office365-filtering-correlation-id:
	 x-ld-processed:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:
	 x-ms-exchange-antispam-messagedata-1:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:
	 X-Exchange-RoutingPolicyChecked:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=Q102HdOr1bjq+z5hzVHQBppbK3mYmpKCbrogOIOtKmE=;
	b=Dj5+E1VPHQw9mHgiIYgWQOhBhyuwtf2+qvcMHju1Vr/TvTq4XXqstptrYyNrf87IK/xW
	 O9YE6hVy5IZt7GoCcbJBnBUwevaMyNrvjRr+cfDuIlpdNj+e53NZ9tuWjk2s0WU568wp7
	 ljuIINh2+C66FIEbMqxwosgrvzbsMYMwXAfcX6W0YOZScSFQCRrqHJaqcVM2ho6FKHKlh
	 fYRF9Jt5PmLcZdXtsntBRq1hYgL8gmDnIPXxX/9Sh2e+QhDsTwf5leETbzpRbPYKURryw
	 ZFgefkkXiSdArt1xx8MDBamE+Ay5IQ7cgIALHXLv0O672sSjOhfPyJKwcb2F1YtVUAQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=rQkrsl77;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=VJMFNmkC;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.139.77
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC059606A323;
	Mon, 16 Nov 2026 12:18:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EC059606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=rQkrsl77;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=VJMFNmkC
Received: from pps.filterd (m0516786.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AGBxSsL1596304;
	Mon, 16 Nov 2026 07:18:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=Q102HdOr1bjq+z5hzVHQBppbK3mYmpKCbrogOIOtKmE=; b=rQkrsl7
	7d4bilTqaF8ZR48MWJmpyXrlMO1sGq6Vdig2FIFksRGhFs++3FDp4VtKkN1QfJsD
	KNoKVa2XB29UztZ4Dkq6i157rLFEnJhrQZThYV9qSF4kc5oaoTD3mj5lzTOBxfzM
	hv3JrRG3MnVD+FohEBgTQnovozXEDQvlhae6LHIskK9blUFozg02xoUZBTJ3++OJ
	GmzrvdC75gPhAXuAd9kYyizmMiuwg9v4qFJycD+ECuV3ZnUYBPsXAsy0JoNMD3fM
	lhkYGcDiDVAfB+3jC3D2T9H3o6PSYfrmypc6EO02zebvD2abMKlXBjH55/PxDBiF
	pbmy7wG853DMa4Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=Q102H
	dOr1bjq+z5hzVHQBppbK3mYmpKCbrogOIOtKmE=; b=VJMFNmkCgM6bsQ9LiZz1E
	u0BPVSc5JbfkvYnNap63Vt5WoU4jyzqybccGPL+raABFpgNrF5WHRiSw+F9ox0gC
	Vw/7VNqXSB84gv6uXnjz/QxlRVcFFrLYPi+U+WOudzChVUe4GNwu1etyfcyBftII
	1sXibhP9rip1fYD3MY8GzbFCELEE9ZNjFGTpQZevUNqQSfD+b5XW4cSzOeA7GMCc
	Wl3z5R/K3rzso7k5gXKOSQND1pAmut67pjEOALJbUqekObLRGaJspyikhGYhC3b2
	WcDHjwX0r+KN6j06f24269m0mo3xkKi7BQHFpl0SzZ1V9oOTNyHapGEQ7n6+R0HK
	g==
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011051.outbound.protection.outlook.com [40.107.208.51])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4hy94n58xy-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 16 Nov 2026 07:18:31 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VnJaLAJ4Q+kThYlqrsYUK4Q7gAMKCixv+fhF/hjaYGchrvhTusJqh9A/ijGshmBgIr98d7BaedPNtBwvWO/X17DIgM1inm9NGJTf76tQbY4kYXwGvFw2nc7RYy33cCQIu1MxQO/6h/WYU5aQrfOIB82+ttulyqpkWK8DFV72cx9x7XLWdxifGl5KZ6gT8/WmH17VlsFcjAPobfEGahDfCBgV5sbPN/RhVUdsddehy+zJHUjSIcpslTnDDLLYr4Y9meoZJvAISlQU+bE3hVSiGl4LQOIEO++1eMqHdl04ib6TzBk6BCmLm97chpq095fqxW8MSTRwYdpFxxYldf3MWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q102HdOr1bjq+z5hzVHQBppbK3mYmpKCbrogOIOtKmE=;
 b=p2u2QXcc8loKKPp0iosq31ZE0UGGiefgtuuIfSRYR1WRYocIM7+yV8Ro+LDyL0b/l3WAnQjBp8IVJC3UPU0Sc9XMjAvhvu2uhMTAW+xy7QHuJvl3jIjfOGXw8VububTJI3qJGgty0HMXGdCxHGrgrF3jMvr/hQAczmUS/2O6KsjucWkOXHaeHcO0e6EGpk6pM78A6pIf5XquONP6i5F4ZSC372E/9CK2z36/qbezW5y8MQSoKEX3uTDBAswGyDubxLKimEnbVNPsrbBX4mohZ27tCXCbxvgM5YozkidVQ9mDeg+mJUvgIcFU+CnAuImVVQyR4UMtykZ51HQcJ6EzJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from LV9PR03MB8414.namprd03.prod.outlook.com (2603:10b6:408:367::23)
 by SJ2PR03MB7069.namprd03.prod.outlook.com (2603:10b6:a03:4fe::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Mon, 16 Nov
 2026 12:18:27 +0000
Received: from LV9PR03MB8414.namprd03.prod.outlook.com
 ([fe80::d661:7c16:d052:cc81]) by LV9PR03MB8414.namprd03.prod.outlook.com
 ([fe80::d661:7c16:d052:cc81%2]) with mapi id 15.21.0615.013; Mon, 16 Nov 2026
 12:18:27 +0000
From: "Sabau, Radu bogdan" <Radu.Sabau@analog.com>
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
        "Miclaus, Antoniu" <Antoniu.Miclaus@analog.com>,
        "Budai, Robert"
	<Robert.Budai@analog.com>,
        "Gradinariu, Ramona"
	<Ramona.Gradinariu@analog.com>,
        "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>,
        linux <linux@analog.com>, Conor Dooley
	<conor.dooley@microchip.com>
Subject: RE: [PATCH v6 0/8] iio: imu: Add support for the ADI ADIS16607
Thread-Topic: [PATCH v6 0/8] iio: imu: Add support for the ADI ADIS16607
Thread-Index: AQHdc2s9Qg3RNVIBC0mRongyWaIGSbcstm4AgAAG3ICAA6tY4IAAOXUA
Date: Mon, 16 Nov 2026 12:18:27 +0000
Message-ID:
 <LV9PR03MB84141F84CA155F8CDD2587FAF77C2@LV9PR03MB8414.namprd03.prod.outlook.com>
References: <20261113-adis16607-v6-0-3f678719942a@analog.com>
	<20261114002522.34f8aeff@jic23-hlaptop>
 <20261114004955.71c7ed7f@jic23-hlaptop>
 <LV9PR03MB8414D877E31EFC41535C9FF0F77C2@LV9PR03MB8414.namprd03.prod.outlook.com>
In-Reply-To:
 <LV9PR03MB8414D877E31EFC41535C9FF0F77C2@LV9PR03MB8414.namprd03.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV9PR03MB8414:EE_|SJ2PR03MB7069:EE_
x-ms-office365-filtering-correlation-id: 920eaf9e-9f2f-49d9-7f5b-08df43dbb806
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|10070799003|23010399003|38070700021|10067099003|11063799006|4143699003|56012099006|261021121427099003|261022075727099003|261021135927099003|261026140227099003|261026121527099003|261022105027099003|261028144727099003|261102123227099003|18002099003|22082099003|6133799003|3023799007;
x-microsoft-antispam-message-info:
 EGk95j20eQRp7PwiCttEoLdnw7hMJ6EBV3r74qq9YewOQBwqzP+2/mh4qy1jNrbudMXOqPR50GryqwLiZdJOQjLkX4ZIGE0kT9dE8Yo6Zgcxt8HSTRw3m79YCzGGcf4PMZ/jTpVw33h9cozz4Q59J5k7vrx83WW101/dlt2MdzRaRPT/aspwUAH8DrvFozjSyK675uiQSqSeFF/Lc4wb+wAa6U5dm52ooMFW/9iK2uaylKd1rnQFZP4vZjitwZRi7yFxFCrF1EewElcNs3amYMskjRnoQBa5i8sB1wFiWjpuvA8zwa1u2F18uvDJW+rt0fo9t/fTC1/Iz0kmmdIFsEnSFxXgfmRxY4WY/++tLh/M5YJc2yHXd8odc+1pwK8vwSWmunGzKnIn6prJfIE/U82C4YoTKKzd6wRbOSZ2IX1+oOq7EQNQFFDj4UwjuXTJoNZCH44nnhOGs7stjiGiW8LJxnjebIn3xAovLgyQWNUVZ2RIwyv5eokxfPUuxggCyLCAikCzQa5uM4zzMN/ckBJuHKh7Z9BfLhmiTuyDdT6oLLKWr790SXIx6quSRtSkyEC6tZTSXpCqzG04bjC2IxqGPSIOzXYb8UjGepUrXtxByCwJ1sADTFHa57jF2Bc8838KOTxFz87OAOMisY9CvQNy/vOzXXtLL5PeQRT8SgvXgfOvpVKz/l5KFyOrqAZ9BY0VWn/sql/KRe7eIufL+Rt4SlWWmohn2kwLsKgs4SI=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV9PR03MB8414.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(10070799003)(23010399003)(38070700021)(10067099003)(11063799006)(4143699003)(56012099006)(261021121427099003)(261022075727099003)(261021135927099003)(261026140227099003)(261026121527099003)(261022105027099003)(261028144727099003)(261102123227099003)(18002099003)(22082099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?AipFY8rjGkek0dOIwX4nG7WiowTuXkJW0wJUiLDpxgEM0i7x3ttlqDPPNb7l?=
 =?us-ascii?Q?i0jHga2sVdfXaQAWUMjQkiMVVxwdrrOs9wLtIJfpiYWBVKYNkPPPAXqQ+YMJ?=
 =?us-ascii?Q?BnPf91qTWfgTAiuLPI3lYMWBnrqTOzGhwk6skjICgiW1OcY2BGwH9qWzpZuF?=
 =?us-ascii?Q?6PssmqBA98Q0sRDBzxa8YhNmW1hACIwTKErK5TMOCF/JeDerjR4Lb+BnQ/a0?=
 =?us-ascii?Q?dXNzzak7p80Z+5hV4KZmfohTo2/sDykvhTswxlWaUI68gSXikWKa/4svT3wC?=
 =?us-ascii?Q?bvqf5tLnKGqPhTlImiyrLpK6Jj2YvCq5WWbJP7KYWloRpBa8Y6kZKCc6F12V?=
 =?us-ascii?Q?c9DsJMHuwb8q4PjEHB9FItnwhZH8bbVFZtiGJRPuq2TkO2VmkNy/M0FWXCMH?=
 =?us-ascii?Q?Fn07nBGYk+9ZGMCM1xarnd0eONHRP/FCnm03fknUYVlluhfbKQUdb75TY4OM?=
 =?us-ascii?Q?BBGbD1iRNyXW0p+rceyUKNuzedjMsX6RegAnskvK5EpusvkmGb6RVncElsoe?=
 =?us-ascii?Q?HmCNnat3x8isqVDbbj31tJe0hL0p26An+dNAUocPPB0LpqMlRwCwNirVZHMw?=
 =?us-ascii?Q?Ay8/bjreO7pyq442aU/Rwn1cldM2gOvsmqgUdzw0v9iq1WG23YQWbrVYslO9?=
 =?us-ascii?Q?LFkOdvcDnqHqT9k4hvZvjyBWCUdnw97VUlGB6zaJ6vxTKIjWYkxK9KXRVsyN?=
 =?us-ascii?Q?MU78cSb68uYcbI3kFfdxGrCNrNKQPW6O++amloPna7PwQ5rCAa79wYennswo?=
 =?us-ascii?Q?E1NPydAJNM5bhkw0ExZZ/GTkbakjFbgQSXU5CQ5hlo9JEWYS0Psbqc1tDEs9?=
 =?us-ascii?Q?CG1T0KLlBpVDfsOQWDRCek89mXmthuSLHbeukuaowrxx7QO3J2oGKgWKRcwj?=
 =?us-ascii?Q?DzK6uC5Pekau/boGeHHP2ZWn+/A/42MkME75sATwAYHq6jKwKf/o0hxj01HR?=
 =?us-ascii?Q?HXQ8Iy0Y95vWy/34I9pcym5a/IfTfZ4RIZ2NUMcM4i+AM4p/RBu8fsnRxqYX?=
 =?us-ascii?Q?8dBmyZQ4P7TRJ5lagUT+pVSMOK2Y5CA1Tp8QaXp2o9nxqmIGpSDXBRSzIW+K?=
 =?us-ascii?Q?B3g/9aYTr/NLw6NaD05scTZXShxN0s+DMKRhKBPA+90sIdQwgWUkivQk0ZN8?=
 =?us-ascii?Q?DL41vcLu4gTVs0jfzbwLDlNl4hbInfab+pymv32mYlRIwGhNKfy8vNx9Kh0/?=
 =?us-ascii?Q?gL4wRw+Zth2H9Oz+GKpUYsAgNyVSPbKwIDeXY+k6UqBPkX8JfT1TasjQpuns?=
 =?us-ascii?Q?40N/IYw2W6AU/cri0/GbpA28sjmCWSRJ7TMjglXym0W3qscJF53CYtM7USoO?=
 =?us-ascii?Q?7vlT82swguTT7tkQEDqo3ip9C5m8aX3S9Fi1GfoXUZ/g/mvuseZsoxwG8fSp?=
 =?us-ascii?Q?jWy2cvRrbnavM40Wko0AwtqM7509MUYkZ3lDW8SHlCR71brisXoK3pxILs00?=
 =?us-ascii?Q?r2DOFqwrx3of2ieqWDtDlwAzukekmnl+OMstNHNGmcD+uLKtdBwWBTawExnN?=
 =?us-ascii?Q?aJX3fvE0IxYFME2QqM3TYqT5n7H59SciJWe6di5UqcAEaHP4j77Z5f4uhnwF?=
 =?us-ascii?Q?WI+aSYaiol3mDDOY5Yy7ijcUgeQan+0TwLbC90T+4+oCKSU1NbPnlekDzY/x?=
 =?us-ascii?Q?68N7Ge4MyJbHze97Wmxu4K5FGmaB1Ahin3Dky/OLIP4PrZe7Qmq1AWVdH+rk?=
 =?us-ascii?Q?2UfWDMTK4oNidYocXI5bJnD2c/QuwRPPhGME3tGKYk6ISCnL5WHQgZ0bCsAw?=
 =?us-ascii?Q?h5ln54tXoEW9BUZ0em2stODvKQwEIEZ8Avbp96scuq7g4i+dMMunr2F0ImED?=
x-ms-exchange-antispam-messagedata-1: aqpxktLzPpGkEw==
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
	dR+MOWOXzYtc9zvN3mB3vdLy2+7Z0kZhM8hV9CcUCfFRT6DM0h6XZS3qklnqv3VAS31FAAvrBgMdVyMTqoY3UF9WphKQXBXOeS32x8JEF1vcbbJPuIXp7U0LU5N7rg/XWiEXRs9FkfCEh9V7mOw1RQwr7SXx2Xda2z8W699FNWlpm74YKO2ds1TQyBYNePSLTz3bOYxjzozm4lrO+tjojrur+BJedmhrJxG4jPaYtVBngcR0xouG5IRG+cWh4QoXaUBFfP5nca5Z04tNZfZartxKjnZNda8lJaJJ1N1GyChcI6PLGyTteUPLCoySRjn3GD7JJ35nSn7NC3QmZn+8Sg==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV9PR03MB8414.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 920eaf9e-9f2f-49d9-7f5b-08df43dbb806
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2026 12:18:27.3812
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1LTu/kvIro+0+Fo7rCxvhAozQZSUspD0JOBWQNKzSu5EbVRD6Nqih6nadQa3V5zmZGRFfW8Vnj/A6Kh+T8NB1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR03MB7069
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA0OCBTYWx0ZWRfX2vWAUX3gTWJF
 IMIy1pS3Bd198FDIdkHHFHmL75KUY7ZYuj4RJL6Gib441trjWAFnXjUc3qkewciZjejHfQUv8TF
 3lOA5VPYXWBQADktrLhCa3PU8h5qfmii8NshmMmKoh8h2cG+cMvRQntXmWMXpg9P/By6zP9rblW
 oaqURoU/RBsofpZz6Wi0fSZpSW3+bmXuPIQKo4x8uiQbRufcoz1PBfzIJ29LIeu5H3zieJ0vYjC
 SPmmOxtnfP/IWO86V8HpU7W5AAa7J8TAUvap5l1wA/+iDr7uuqAMLqoV+XVZL/blwLmvEI7L5Ve
 /iGXY6Wbq9DYSW+Pl6VwnLmcKptxVB7Gq07asOiEwnSA0ysW9q8RsZoN4kYz2Gli83xJ4jZVaZe
 62LoaZSxhVPq7KMdn87iiF8glPiUbDNmjJMtbivz9pTNQFO1H4kqdACypJ3/6yPKWIr7lKsVoke
 PQLzaxrxx2wT8OF5TaQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA0OCBTYWx0ZWRfX0CNIESxxoLXQ
 5pTuaVnKJEwdGan0sVyit3mAn9l1GUQ0qz1zeMCLYgaxIbeXPWZ7mijhIG0qalD9gxT3F7kNFhZ
 FV5nfvhcEFvDYNUkkV2hpiR9kw/sWI42qDM2uPxlcuvUH9PuTVIK
X-Authority-Analysis: v=2.4 cv=WvK+otfv c=1 sm=1 tr=0 ts=6afaf497 cx=c_pps
 a=4ayr6ClP8xx6lw6zA/3NoQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=ZQxX5BWu6Z8IJBb2zLX7:22 a=q_CrZHE8tHj81X5FTsMA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: hbvqKm0sBKNN2DUEXEacM8c6DKJWoioc
X-Proofpoint-ORIG-GUID: hbvqKm0sBKNN2DUEXEacM8c6DKJWoioc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_04,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 adultscore=0 lowpriorityscore=0
 impostorscore=0 bulkscore=0 suspectscore=0 malwarescore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611160048



> -----Original Message-----
> From: Sabau, Radu bogdan
> Sent: Monday, November 16, 2026 10:55 AM

...

> > >
> > > > This series adds support for the Analog Devices ADIS16607, a precis=
ion
> > > > MEMS IMU with triaxial gyroscope, triaxial accelerometer, and
> > > > temperature sensor, communicating over a non-standard SPI Half-Dupl=
ex
> > > > protocol.
> > >
> > > Applied 1-5 to the testing branch of iio.git.
> > >
> > > I 'think' the proposed changes for the fifo handling shouldn't affect
> > > those and I don't fancy reviewing a mega series with library changes
> > > and the new device support.  So build on the base of these first 5 pa=
tches.
> > >
> > > You will need to provide a base commit for dependency list though
> > > or sashiko may get confused.
> > >
> > Change of plan. Dropped it over channel type issues in patch 5.
>=20
> Thank you guys again for the review, and sorry about patch 5. I'll move t=
he
> scan_index/scan_type and the timestamp channel into the FIFO patch and
> resend.
>=20
> On the FIFO side: adis16475's has_fifo variants register an IIO trigger
> today and are used through trigger/current_trigger. Converting them to a
> trigger-less kfifo buffer, as discussed for the library, would remove
> that attribute on the six ADIS1657x variants, so it is an ABI change on
> existing devices. Is that acceptable to you?
>=20
> If not, the alternative is a smaller fix in adislib: iio_trigger_poll_nes=
ted()
> for the has_fifo path, plus a prep patch taking the sample timestamp in
> the handlers instead of pf->timestamp (the nested path does not run the
> pollfunc top half). That keeps the ABI as is, and the adis16607 would
> then use the adislib trigger path again.

Thinking about how to split this: sync and calibration bias do not depend
on the FIFO, so I could resend the series as the adislib patches, the
binding, the base driver (raw reads only), external clock sync and
calibration bias, with no FIFO. Then a follow-up series with the FIFO.
Would that work for you?

For that follow-up I would still like to know which way you prefer to
go for the adislib FIFO handling:

 - kfifo helper: a trigger-less kfifo buffer with its own threaded IRQ,
   used by the adis16607 and the adis16475 FIFO variants. It removes the
   trigger/current_trigger attribute on those variants, so it is an ABI
   change.
 - iio_trigger_poll_nested(): a smaller fix in adislib for the has_fifo
   path, plus a prep patch taking the sample timestamp in the handlers.
   It keeps the ABI, and the adis16607 would use the trigger path again.
   It is only two or three patches, so if you think it is the better
   alternative it could also be done in this series.

