Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.135.77
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793008343;
	b=m383P96OalSxQna5MoKO8/6pDwci0mZ3FmKM/tX6WQqmqSZbCtNrdFBQ2yRwfXZRXwHN
	 efwArB0i9i6LJyuxYkChen901Qy0PP3bmaL9CbfapO2NUXc/Xgec/z028ISVr35tJFT8e
	 omVJ1sT6XLsHhYp9RStWj5nnb3z1I2ApNUfVofi68D1WAjhycFzDyvKu4D5UF7BbkhkBO
	 EMzFCbaLX9+GBz2kZc9ZOhVWtDTuT+kakyDaLbBkTWdtxYMTXMsyABr50UvcGnJRnumS2
	 H1FC4Xtp7ri9zivM1CPehYhn3df9cNxPf9XDE38tabcGYqSdOYMYaF0mM48a5RqFv/w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793008343;
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
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=h7fEtudvHEudv575IBlYJMbvgFNC7plRW4uKXvBIq08=;
	b=O0eMdVsb4wQHLvcG5SzacCw0PEmh2ZCv72/aidCqz5lp7kTCPuQD5ew+2x+28+abvI7R
	 ps71IgZFnBmW3YGR4oXEPCGbPn0HOPfeMqmVQCUaMedX0V6ZyznQW1qYAgZXqafwwxxuk
	 stkRIMpcq2uk2zc7a4kq9UyIdDPTZdPpUeti8dzyRysqxQJxlbrS+OLr49ffbc/0Aa8Ob
	 Lq/yJM3T9fWxVxjrCpIWmru4p2QaMnCiq8q9TE4dZsVRWm/geYeGh4RQNNKzYlJE7Qmak
	 0NtgG9LYZzO2wb1m81j9ECUdFU5yNN2HCyRX0rlObe/ohfWYzVcR+IfUtkGP0T8AewA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=a6p4Fp1m;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=r+mxpwtP;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.135.77
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E607606A31A;
	Mon, 26 Oct 2026 09:52:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7E607606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=a6p4Fp1m;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=r+mxpwtP
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69Q9Wkks1289938;
	Mon, 26 Oct 2026 05:52:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=h7fEtudvHEudv575IBlYJMbvgFNC7plRW4uKXvBIq08=; b=a6p4Fp1
	mv08ZyEqrQJXvnGtQNq+pKxGjlUXeVL5oqKU3fwqYte2SEx8IibW03cIULIEEx05
	BKTRrBYWrXbJqou/3mgzgO+xnuyXlXUGiPSB0l1l6z1LavFwen9zEUzXVaD0Zhb8
	yNFESe73m08EGLUv5EuUvJRjnwntDK4tEBGsRm3vOqFDrhLcScbAobk/L1RnGRDi
	Imcf2W30pGsIaZ4p4mi9bz/dGZtjgYBHZnyDBvI/5Yyy5YZRI+4Nh9aim+ANENH6
	V5zk6qBY0IPIdZMOdjaEFQxdZI/c61uGaQdei63mdyyp/Rle/e6cuLickufws2YS
	IHzEPI2r/HIKrBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=h7fEt
	udvHEudv575IBlYJMbvgFNC7plRW4uKXvBIq08=; b=r+mxpwtPtpuymyviO/3Kk
	PY9GCjKD+waVRP8DB8KTLYTD8DsjDl988JoQ4NGaafxo2yUIFpRJ5d+SKpv+knz3
	sWYs2L/d3Dj68FLdz6+Z8VIxm0CHfhXG9N8UUqDQSThC5k9BJuicvPc2fC2GtTgE
	d8j9Byka9+JdDztbv8bj2ACo98HUlsJtvMAm6f3B2wNQ1G9nYSAoYRJYr/tymgVI
	Oez9QAZ0/91UWYI6dum3mz15cue1QMUe0Jd9Uh1Mguc52NpYR8hAAce5sqjtyuIY
	+f+BKtft2bYl5tciyf+/IknyCLWZJ4fGkepUkUQLIQ2d88v5igoEtJYlba8pavgW
	w==
Received: from bn8pr05cu002.outbound.protection.outlook.com (mail-eastus2azon11011029.outbound.protection.outlook.com [52.101.57.29])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4hj0pct853-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 26 Oct 2026 05:52:04 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LneS6z7YaKI2748Tz1pQVfJUEMIIkQLfXOYsvfo37RI4U/2u6VIpT4psvQWvSSGdW9BMNA6UJCTz3e7HkPvQd9AS+m856cO+NWKVN/dhJdBhJFlggqt0ykhZaXFIJXHOlLwBv69ksoi8VGItHtG3RfKDKNctsDqMc4L8TTxgJKodJdz6xDehfe+7skkJvTsZ+sifG3nwkxS96KG9KGWHUqwfMX39KOGnyfHrynDejt4K2L9Y2lYxC8j4qzu3QInu8aMOfIqciO0w2Sq78YF+fJncqjBExUuBWT3Zjy1GETl/Nu8BRdzRqG32qbnR5z+hsKctz6gAMRRqYfkj+3yrdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h7fEtudvHEudv575IBlYJMbvgFNC7plRW4uKXvBIq08=;
 b=mDe4qVBKdgPAOQv7RLN3XprOoX5xIryKQqE9+aMQtgFJHVOZ+f3Pt8kTNJHjiNTJNRlyr/BnVcShpciEvYgB0iL5zCDFnQslR+rxezEMMlcLoLEGwNVYc5dhXsihXP5d8wCc0evaOKQ4gZotSqMDjUVjIDV/RuZK8kjaOwJprVNgFSSH/tXOP2p3NbnsNZfIotAnbEPPHL9hBI0RMg5+0aLrKUTV4I2O7aLqHWST/gJ+eQfEqaI2DOEn75S7LVzvHoAH8TVDE7HSw//z6zJrRJWgG39jzNCDUAPl5JmUf1F8SU1hzVOuxvwmgmGFNEtXZLHRF062c5A29nXyBsgW2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from LV9PR03MB8414.namprd03.prod.outlook.com (2603:10b6:408:367::23)
 by IA1PR03MB8213.namprd03.prod.outlook.com (2603:10b6:208:5b0::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.20; Mon, 26 Oct
 2026 09:52:01 +0000
Received: from LV9PR03MB8414.namprd03.prod.outlook.com
 ([fe80::d661:7c16:d052:cc81]) by LV9PR03MB8414.namprd03.prod.outlook.com
 ([fe80::d661:7c16:d052:cc81%4]) with mapi id 15.21.0546.021; Mon, 26 Oct 2026
 09:52:01 +0000
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
Subject: RE: [PATCH v4 3/8] iio: imu: adis: Add optional post_reset_setup
 callback
Thread-Topic: [PATCH v4 3/8] iio: imu: adis: Add optional post_reset_setup
 callback
Thread-Index: AQHdYtEkW/4XzF2QVEKcmbnSpRC3ZrcO8iMAgACnUdA=
Date: Mon, 26 Oct 2026 09:52:01 +0000
Message-ID:
 <LV9PR03MB8414C217607B07CDB3164051F7612@LV9PR03MB8414.namprd03.prod.outlook.com>
References: <20261023-adis16607-v4-0-a4d541ebfd13@analog.com>
	<20261023-adis16607-v4-3-a4d541ebfd13@analog.com>
 <20261025235226.1f0fc87a@jic23-hlaptop>
In-Reply-To: <20261025235226.1f0fc87a@jic23-hlaptop>
Accept-Language: en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV9PR03MB8414:EE_|IA1PR03MB8213:EE_
x-ms-office365-filtering-correlation-id: 150812d0-df8a-4178-df0e-08df3346c8bc
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|23010399003|7416014|376014|10070799003|1800799024|6133799003|10067099003|22082099003|18002099003|3023799007|4143699003|11063799006|56012099006|261022105027099003|261021121427099003|261022075727099003|38070700021;
x-microsoft-antispam-message-info:
 upcaygt/IPnuW/JAK3Fr9zYgHB0vw6zBA10FmLc7j4IT7J2eSZLUgvSKEmQNN2lFNlt4ruZ8U1+t8nQKOZIANukrmliyvyC9OwUSznRo0nnJw3VLsfprGQ2sF/gB56rHJQJ3B7NsQFJ2P3jRJJZFkbWHcHJpNX+2RSrhIhcYlBpGxJC1uEK9+ZCrHTSlh1TNZbQ9Sup+Yrf/IBNzoAGKFF8YZBo1L14AP23Y3vt91rfDuWq5XO10MNuUmpXXsYG68ACGM6fTMqBZuX+2SiZC/hshxlKUa6m7hQz6BCDlB2AwFGko0ep2NMkpPpR4xbDFsZa2ItO9ZsXAyHuBwEV99rixM+PYZgxrvjcsSeZBXIlwxltCTpB9Xd0JfU6tDDE9sBHtu0tQZ5N4DG6iZCqPYlMC4DY4U+bG0Zjc3i7LFQq5MAjc6xpiFhoAzueCACrS4YAIQEMLE3LnR08k4AqAEmMFyP924dVlZcDjCacS5XGskG9SV6zCs0p/izZKmGsOWHtbFV6J6Ad7JZ7dNEuizXJjsQSZoXah9GqpOpqGix+lg/lw2o6vbhSYLt4mjsdazbn33C67CliREyD9B0hU67U4SrilT9TETIjPfN21ysk3MTcX9I6fefTBloPUizNlb2wXWCUExG6yLhbET/0z46AdQ6fF04T6N6aPmKB+g5whTj6pxpJu3EzmPFLnYA0J2vjLHTs7rlkn3OSj0P8G+lEphQa0hjADYjCrmFeCnu4=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV9PR03MB8414.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(7416014)(376014)(10070799003)(1800799024)(6133799003)(10067099003)(22082099003)(18002099003)(3023799007)(4143699003)(11063799006)(56012099006)(261022105027099003)(261021121427099003)(261022075727099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?1PrrS07DShqS1e532le9EwC5aSdqndEUQ1HpsJD+KD0msEZFy5o6kW98Du4o?=
 =?us-ascii?Q?mAc9vhsT+HH8yJicYED1sr+hO4SwRDl0PB4ReRfQvgHg80fOUYeenVWluezv?=
 =?us-ascii?Q?QXNE0GBMjk6M1T87oTpWwyDsEFOquHBzJUxA4E6CX1eQB9wq3bSP3FnmJ/ZM?=
 =?us-ascii?Q?ObVmqIzPUTz0ppGTPPz66LTkEBhh7kng3kksVR9GW7gURzoNQB3jDcZRDKoh?=
 =?us-ascii?Q?SuWsy5QojvsPLVWwMGQf5Fash6BjvYUXLQHwMIiG3mIseoQWqlKT0oZfX7GO?=
 =?us-ascii?Q?IWgApQVIk1bKSbdjQkgU+CeR0CAGxIvebFqtV+QxxlHIKMfhJh1U2XyAhn+E?=
 =?us-ascii?Q?o0Ry1TalPfdpTxsqXvmhuxXZaA0FGtdlg9Hi5qZd331WacV7CjWtX9x3bVws?=
 =?us-ascii?Q?a5HjV5m2DbJ7R79Ynfqe2X/nf9Yf5pNeLxz91g0liEcK25P+R4+VNQM6OGrg?=
 =?us-ascii?Q?Ps3O56h5fafra5Vk9aCR+0t+blv+a2MYvZsolSoHmjltOP+d7lRwmTSgg4mI?=
 =?us-ascii?Q?l/wWgFPkWSs13Cp61kQ6aUFbIMuDxfamWUaX72gu1kbylQ35IVfWelDpAtsZ?=
 =?us-ascii?Q?4it+mBhxenG8YG25d6AMfbrB/Hoob96MlsN3XdwVmruUIceHDB8Vefm0TG4P?=
 =?us-ascii?Q?yH6eEF8U8IXgXyYCDUBMC7mz1/H2tnJeQQzhTUThBwqHV9ySkr0PB3NAxRgP?=
 =?us-ascii?Q?H/GYf45aumW1E///sb3ezaG6P5qT9QClblhMaA83piusDziUyCWf0BjBwysx?=
 =?us-ascii?Q?Rst0m7IWNqE4ryJMXXAwkLXGtNXwARXj+ToIs+cN6asUR88xPxIM2lPUZpqS?=
 =?us-ascii?Q?Xml813as9To1/XbdW94cRcNPmbEZxtqwTaGGbTeJneSLKi9KT+IznKh/2hO5?=
 =?us-ascii?Q?1XA0FQnbKjYdVMQrAajdfMV85DU1juP/7aFDaup66znfUtrr73ybIsCs38sR?=
 =?us-ascii?Q?YiB8dTm99eYwO3PoZW+fAVpx84dikEiVSOH51wcaFKzN5B1w9Utx+sGGMXnq?=
 =?us-ascii?Q?lhKeFSh1BmdUGKYruYNUc8jepLsj8G9ObJ4dj8SNjLopAsShblDsJjhqp6Fl?=
 =?us-ascii?Q?wIUAr6s3iqYf2pV8bZV9USDBz+1EWI6hIE7Ws1A03VrbaLeM2agIKvA1ehCq?=
 =?us-ascii?Q?qLbqC1Sk3xAsAZ/n/q4cHaaqtuJh2B50MmE7ozgK8LrYqjvZnONupEDw/ZBH?=
 =?us-ascii?Q?MBChGb6ei+Wqhq3ZhvzKH1k3ak4SFCYbX4y4FHcndn2E3valljK8VrE6Fe8a?=
 =?us-ascii?Q?vMqhcWHMl8FsRS3nsvMTIExs59Zsy5nADh9fUbXFL5Ct24uuwyjIX48giFVX?=
 =?us-ascii?Q?j6EyEmqSb7P/apWCfjljRYFxgAEn7P/Yc9UuiUQ2Xlm4tgnTwieoxpXW1d9K?=
 =?us-ascii?Q?7GjI8dGdSLuq/v2L/Kf5yNnP0p0cBALHDFspk9FGFHD4D5hsz2+EkWORxUZD?=
 =?us-ascii?Q?3mfQUTURrrfET2g+91aPNnwCZve/f/IWiNr6b8vMDchUiX8+k4nczbiEwwAG?=
 =?us-ascii?Q?PEFcgX1oaa4eJmDoSqbMkoVY+NmnZJKSLG74mHx00bpxlguYnBRxu0tfdha4?=
 =?us-ascii?Q?j5sLFnqgz/7Gxyt/igMBVZHscSn0B/auKtfn242aQyDWC1e9XOdNbh1agbnx?=
 =?us-ascii?Q?M3uKUiMtBVptMVYv2QLIcG/nIgrNUFOsVdSYC8wm8lsEOG27w7vlbXNodjm8?=
 =?us-ascii?Q?JPnxkRmItDyVy0xHHRVZ3+hsGcI0xt4Z1IJV+0CCnkmlyd2g23G1xL45hHVB?=
 =?us-ascii?Q?6tyowRbtAAvb0yQqkvzGhWsFGtd2gZ5Y/lDiSg62TrfpiuActo/1Pk14tqI7?=
x-ms-exchange-antispam-messagedata-1: vnGcEMDSg3fr8g==
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
	J6ISLFzV+GRpuxG3n63MgDSHU2n9Qal3P+J+nShlxf3RvVE6sxNnWdWtgAGvlk+yvHFNmck8cC4dIJAPUEurhFlZcui78EdmkNsZ+US2GojhC9JU3Kp5TfgKDShL8nLY1DoX8pvhP05PXpeUtJnBZKGF1c9y7B4Q/PegTdYWzBYtmn3sP5KcF1x4zttzY430gOkWUcRhOwcbk6CXM0nb1xq/8eZm6qQMZTh+CAzv1m3M0DALLGkofcuacqZFY0vAy8UGEt7GqC45EMwrQ2OE8/9mGZRLB7TLJXHz7Iv1rCHd+QRlEN4eficQ2RqHg3Cs3fy3OAqekAe0W/ORzGYirg==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV9PR03MB8414.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 150812d0-df8a-4178-df0e-08df3346c8bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2026 09:52:01.8245
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dmb3Uoxcml/3uY2WO7GMDng7FDS38cWkZY2JLmGjUEuR87XV6HjkBLUOmn4IigHUN4evzB2BbVDHQMcQHmRV/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR03MB8213
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDAzOSBTYWx0ZWRfX6EyBb/eySnRh
 M/QhoSRhDp1OJ+ttUNKZWsz0MbB4h0hjTfyLhYBCZizge4Azw9RLFf9whgDF9vSroFAvbgQCrhk
 Z5d3socy+F1MXhJ24OMbccsQums/JzPYxw9REavkz0QMNwebT7cvoGWPKM50T7IxLgFmAP+qVxN
 Iw5eFVIbK3j2wH+kioSqqlDTsO3qZqQCPuqRdBa7ei5CscsW4gxYsJXz8KRMYgoa6vV39tGTEn2
 hGJzP4KZHbvzPzOZD06tmZpMT49dRg9dulfBaH+9Us9a+oWoU07qSg3KNjlalWgdZsSMDKaJnW1
 oTu0MUYiFL/FNEvw1T0pGkZPqg8BKlEc9iCwNF2adTwJahLfUX3X+gQVsFVEQrQNQ/u84QlL2Na
 M3591Dchf5kYC9pdo32L573Ir3qmZaP3r9z3XDJKLN+7ZPJI1+ZIdeUSw0WZDY0wwpigqDphNiF
 UOUy88FrRr5Q7iFaHYg==
X-Authority-Analysis: v=2.4 cv=WJjqzXsR c=1 sm=1 tr=0 ts=6adf22c4 cx=c_pps
 a=rDMf0xV6zgmXoNUq+bKLQg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=uXIjobp8t2wMuQ0fPvqm:22 a=VwQbUJbxAAAA:8 a=7_8_5t91qM0zuXyU7coA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDAzOSBTYWx0ZWRfX2CFxvvn0yGWj
 LThHuzBIkiYJyaoxCr95IPn177ySlR50GWiAwTJd73AZ+TRi5ehVsEV0u2tZdo+e078Y2jn2bda
 GGai//UjZ4x9/Ew1KAuplfmSXrsWXRDS0uR3m85BizuEszSARLu3
X-Proofpoint-ORIG-GUID: yVIgIjkP_zbY5oGnEYdWYibWOOb2nJHa
X-Proofpoint-GUID: yVIgIjkP_zbY5oGnEYdWYibWOOb2nJHa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015
 spamscore=0 priorityscore=1501 impostorscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610260039

> -----Original Message-----
> From: Jonathan Cameron <jic23@kernel.org>
> Sent: Monday, October 26, 2026 1:52 AM

...

> >   * @self_test_reg: Register address to request self test command
> >   * @self_test_no_autoclear: True if device's self-test needs clear of =
ctrl reg
> > + * @post_reset_setup: Optional device-specific hook called after reset=
,
> > + *		before self-test. Not all ADIS devices need extra bring-up
> > + *		between reset and self-test (SPI mode locking, status or
> > + *		bootloader checks, pin or burst-mode configuration, etc.) -
> > + *		only called when set. Must return 0 on success, a negative
> > + *		error code otherwise.
>=20
> Trivial but I wonder if this naming focuses unnecessarily on bit being
> after reset.  Maybe simply calling it init() would be enough with
> assumption that any intialization is always after reset if there
> is one done?
>=20

Totally agree - renaming it to init() for v5.

> >   * @self_test: Optional device-specific self-test override. When set,
> >   *		it is called instead of the generic mask-write/sleep/
> >   *		check-status sequence. The callback owns its own pass/fail
> > @@ -88,6 +94,7 @@ struct adis_data {
> >  	unsigned int self_test_mask;
> >  	unsigned int self_test_reg;
> >  	bool self_test_no_autoclear;
> > +	int (*post_reset_setup)(struct adis *adis);
> >  	int (*self_test)(struct adis *adis);
> >  	const struct adis_timeout *timeouts;
> >
> >

