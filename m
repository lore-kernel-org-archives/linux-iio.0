Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.139.77
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793606704;
	b=qIjBKXCC1FLbebkrAm3kvvfW1b/v3qECY6TJUOUTZG8OhHqoJQH82w0IZ6qhKcA7sIxe
	 lLiEFcdcqs7O+11a7UH2w2k/1o1YHF2QUg6wwX8BTyv6m6uja4lfC8B/Mbz4XsDOu80fg
	 HBkvEccSLcUrwfd5UfboMFygwSuL0PezeLzekqOvjEIC1Q4tE1V+yyMOWuilc+5kO7IrH
	 v8ScUHOteA53vXYMSWeu75j0lZsIqfg5+9IrZtIzY44YOaBB+ni6J/qx0sTJJwmMSlL/x
	 CMbhvEj11uBBJIUWkE+WNvgC5uj6+EANgHP9AlXY05812ddfAy2fwlH04GVDVz/ndPQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793606704;
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
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=Y8iKv3bf+R8wAxRb2NWTmbcVpl2JbbRQcjJnoscl17g=;
	b=g0hbNwEI/qzfDxajm9VPmetgWaplO0hrjgt1s8ncf7sCYBaiC5/NkXcihY6Rp3u12ddz
	 cxoppIDIbp+/Qfcmi4XVlvLnYMtZ6Wy4akhk8hP9hthKIIwRkK7bJcfz0w9IbizjYdn1I
	 eAinbGLAfg8aaksVMGtcB3f8FxHSU/0XJ7xRPIc43ZwuTPBfjIKocYbMn+1ZuJbF1fE/w
	 bAVZwqMmpdJVTbrbU0AhE1EoWhkRZX31zEyXr16BHOC3oiP8p3P1MBYO7HrQlycvLqh+h
	 sGP4h0UvSf7y/fNRdhfUimMoa+xQZr6JNlWd/BIPyJ5BGxP5u0Z7mqfMSDdP4hUYlbQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=e4nefjb6;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=PbgDEtGh;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.139.77
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B991E606A334;
	Mon,  2 Nov 2026 08:05:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B991E606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=e4nefjb6;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=PbgDEtGh
Received: from pps.filterd (m0375854.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A23uxDg2200366;
	Mon, 2 Nov 2026 03:04:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=Y8iKv3bf+R8wAxRb2NWTmbcVpl2JbbRQcjJnoscl17g=; b=e4nefjb
	6t9WEVWAqPRJ4vvFVL/Kh6cyWXS8pd49BVC/cHYG4dbUdTORRnRX0MMnbHWR2qH4
	kuEUlF/YEfwKunYvmidNyvKvk+LGYXx+fzwoPqtigFFe91X4Xd++ObIdbKr/QteM
	kTUbtHUBPYRoErC0Te1fzl1sW+4Dh01kOhyfTqDDABFnNLJbYkd/GvK0uRsBBkP8
	O14HdGsF6Y2XW3dgvQ3gEDp4stG/dPl7RjWAtc8U/1Q19CWVZePN9C9htTlBrgAI
	AqN2xDus04HqTCyYGU8Yc6uB7GkXwP5NDklOZSeUvFFBIS3FzbtjIkE2Uy7pXINa
	6eSb1NSd8ZukUHw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=Y8iKv
	3bf+R8wAxRb2NWTmbcVpl2JbbRQcjJnoscl17g=; b=PbgDEtGh2E7G8H46UX9Pi
	cc0d7fZ/4WAOtaQ+zznJeAv+Eek8ZfuYqLo0rQub3ZkDqjee8LbNIdynG378G7fz
	veImopkZGAb5eKd0GNwDe3VIOE07IABo5nI/hXf1RxnII+HEkbx4DoYDCZ51qPDs
	ItTI/7OunfIR9YWcoAumqX3veZWnl4JSqNXHjMng8IzG77StWknBsz5/9kr0bkl5
	s24o6Cz5MIm8YLhSAuyCiGghRZc3sdXVvaaMI7m8bPvOKPffL4F9bB/0geRsDHqh
	AzNmvrNw4Lvvnmc7PjKQJ3t3DiV6bpnoSvu0nE0vBMDmwLqhgqPSXVeU7o2uXtRR
	Q==
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010035.outbound.protection.outlook.com [52.101.201.35])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4hp38m40nj-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 02 Nov 2026 03:04:33 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eEOOjfKO7vVLa29Laq4HHPwcrpS2uOI0yM0OR5sNq+ZBRuBOCVDDJF0vzOmxsFhhIrX16SipqD7BQBJIek2bsuX8qY/lv2mwRoiG8lWxIO4XyBi7Qh8uj6sAXUc5YNbRmMmtIaBUzVhFtw/76ztnyjNsWUtrT4c6zWuj/rMEpWJEZDic6aEwUrAm1rHYRzCraZc7GcUpvAbGQaR/MuwobkpMK8hDsBC7+yxKIxC/Gy/3UQkAFayiqFwjU7woSk2PBlbBxYzvXa2DZHs7S5cbEXd7BUyC48zUyPtediRwvT1bfTAlz4iQvJ2CdonKHqovMF0u6qRTP/ITHKOHoVxzLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y8iKv3bf+R8wAxRb2NWTmbcVpl2JbbRQcjJnoscl17g=;
 b=rC05gACHtv0SBKyj7zwhjlvTOJu9rLaaSQIUAQtyxSAZ6gBEjo3UT28I+Qqdy5fN/jp6KIOM8xhTtLOZXzJ1847flk8X8qZx87l7MZKinxNdJ6egSMCCXDlz3vtfYQnIj4ze348v+eY4VsMSI9cAAv/QgNz9z0Fv7oKSYQukvTNGgFKuOBxdhGAwGJOz5UF+zIbhxafcg4zIiYK2bCaNqxgr1gi5XGqItNz0yiSQy3Q6U1m94DKi1oTFKXOFQ3dz2AU69qeXRKRUA2VfhRn3F5VEr/YEO7R5JQuCykNetIEDTBZn+mWgokxAnPVRhRQ1gn02hzSH3xfowkFXrV/jiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from LV9PR03MB8414.namprd03.prod.outlook.com (2603:10b6:408:367::23)
 by DS7PR03MB5382.namprd03.prod.outlook.com (2603:10b6:5:2c7::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 08:04:31 +0000
Received: from LV9PR03MB8414.namprd03.prod.outlook.com
 ([fe80::d661:7c16:d052:cc81]) by LV9PR03MB8414.namprd03.prod.outlook.com
 ([fe80::d661:7c16:d052:cc81%2]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 08:04:30 +0000
From: "Sabau, Radu bogdan" <radu.sabau@analog.com>
To: "Sa, Nuno" <Nuno.Sa@analog.com>
CC: Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael"
	<Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
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
Subject: RE: [PATCH v4 5/8] iio: imu: Add driver for the ADI ADIS16607
Thread-Topic: [PATCH v4 5/8] iio: imu: Add driver for the ADI ADIS16607
Thread-Index: AQHdYtEn04020ce4Nk2KyUqjY7F1HrcWKjcAgARRb1A=
Date: Mon, 2 Nov 2026 08:04:30 +0000
Message-ID:
 <LV9PR03MB8414DE36182E88D75B008E6BF76A2@LV9PR03MB8414.namprd03.prod.outlook.com>
References: <20261023-adis16607-v4-0-a4d541ebfd13@analog.com>
 <20261023-adis16607-v4-5-a4d541ebfd13@analog.com>
 <179336921875.155032.7577697183114088168.b4-review@b4>
In-Reply-To: <179336921875.155032.7577697183114088168.b4-review@b4>
Accept-Language: en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV9PR03MB8414:EE_|DS7PR03MB5382:EE_
x-ms-office365-filtering-correlation-id: 99a2ba16-83bf-4bdd-9613-08df38b7ec44
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|23010399003|376014|10070799003|1800799024|10067099003|22082099003|18002099003|38070700021|56012099006|5023799004|11063799006|4143699003|261026121527099003|261022075727099003|261022105027099003|261026140227099003|261028144727099003|261021121427099003;
x-microsoft-antispam-message-info:
 Tnja6TZjzTpG3aDhlzjPh1JMBSC+ZMsV7IHV5welj+/TToIPXXAVu9Fa+iXKPLBnR2iss80xVuB76DGC+PPvqGI5AjB4oP9GrwpFhcGmbUmjUlT3qmTKijrsJBBOK8LqSYbaThET5QIjb7cfobPquGqw2IAMuIaGtXmPpnFDHXGNkd68H5QJ6So74a/pczSXTAGopY1Z/53Fh+dlXCdHoZiPMhSp8nN6LeHZCvOh40dqSBxRVCe0qgCkfSjEJ0gD5TJ9MdKiVMBMne0VmW2cEYn2XZTUeenARQXVSLa1wsV95OOV7cLW+Ui2XjVxirg2CEQQ+W69Nduq2ZfRk922GMVJu05oMzbM7FJfKy2x1+ClzWqjGBLjYjqIRCDehJN39AxJOvu/4MJCq7zc88gUKDVWPUEn1nTrS1nqeCb722iMFHehA6b6Hi0Uo7mIWmkn3MTGVhNnIOqaIKuTRKwczkQR9WqpWlskCx9W/scplx3Jsh+F5NL15zSUaK/bPkhu4ed2fcvfboi1oJSiFMluIG3bbkbrfWx4nbLTTzhCmcLNOg7mbs21lAxLG5UjqEcZg1LSgwbtmYxZzjWABqlzo7xv/pzJj2TTV1BPN26zFCZxJUveNMTsvVTlu7mQBQdXktsQDsXnonYcXvjzkLQ9/OtCevDQFEDnsNv0WVXZwh/uqN86KEdfC1IVas8iF1CxRxvxHfd5jPh4h5iW4Q+QvJ06VtHA2c/mzeTJI6Eusfo=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV9PR03MB8414.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(23010399003)(376014)(10070799003)(1800799024)(10067099003)(22082099003)(18002099003)(38070700021)(56012099006)(5023799004)(11063799006)(4143699003)(261026121527099003)(261022075727099003)(261022105027099003)(261026140227099003)(261028144727099003)(261021121427099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NjNIbVY0dEhSNlhVdFBqa05iYXZQR0F1L0FCUGZwdFRySUxJZm9BWmFWY2RP?=
 =?utf-8?B?L1ZPaEx0Si9SQ000Y0Q4c2lLNXZQZlpqdi9tRmlkWkFrZEhTQ21YYVBSdStK?=
 =?utf-8?B?RGhMbHlqdGwxd2lDOHNIWE5tQTdCVldxRDNYWDlQMXpBQmE3d1d5djFDSlBq?=
 =?utf-8?B?akJXd2pyMGhSUG1LbjIxZ2lmM1lmVlkwcGdWOUdpbURhWS9NM3p4aStmcDNK?=
 =?utf-8?B?UTVta3pNVHM4RmkrRDVVTnZxaFJzMXFQeUVVam1XUE9meDhkcjZjYTljQ0tM?=
 =?utf-8?B?NXBBTHc5V1J6Y3NQbWloc3BWR2ErMy8vNStkV2paL0h5cEEwR3c0a2ExL3RC?=
 =?utf-8?B?NGhvM0ZWVkxrM1k0ZjRzNGxIaGxjVFZPQiswUXlMa095YW5TOCtIbFhIWGtZ?=
 =?utf-8?B?Y0I5VTQybnhIOVorVEVUNUU3N09GbU1ZMmxGa3pvZ3h0M1JtNDFkU3Y2elIv?=
 =?utf-8?B?emFOVmxFb0pYMmh4eDNTWlpiRG1xVHZZWDc3aVZHK0pmU25ZSDV6VEFIeEMx?=
 =?utf-8?B?UzZ3cENGR0tMU3lrbWJVc09hUXMvWlA2L2F5MENBK1ZqL2tPbW1RWGVFZ0dG?=
 =?utf-8?B?R0o5bEFvck5OOEFZcm1iMlplOURnNVRDeHgvVjdtbERxdFd3cTJzTHJQa2Fa?=
 =?utf-8?B?YzBCUTBPY1FzL3IvdzVPZG5qN0V4R2UrRlhkcUhYcTVaNkRPYURiKzlISUVl?=
 =?utf-8?B?d2JOQ0ovWlhWaWJ2YzNkYkQyVVBackc2aWJtR21ZR1pjUlJZS3VWYytrVDA4?=
 =?utf-8?B?YjJwTW5saFo4MnJQdnlYSG5tVXlJNnlmT0xraWd2dU95d01Pcmx2QWxwNDdH?=
 =?utf-8?B?T2piWUNGNmFOK2g4ZWwreGRZVDQrSm9vY1ZFaEgrV0RTT3g4cE5DckE2TEpk?=
 =?utf-8?B?ejVMbzY2WnpqYmJBYktNU0l0cHhJSnRnS2tzV21kV0N2NlNzclczSUhWMnlu?=
 =?utf-8?B?UEYxUWJ6MHVMN3JzVG1OVnRIemtTVjNQbmFnYjNYL3lMQUJlOEM3eTRnbFZJ?=
 =?utf-8?B?TGo5RUJQYkJjcjIwWWpTMTAzMUZJbExVamp6LzJZYi9Va1JZK2JTVnJYQ05R?=
 =?utf-8?B?blB2RmxPc2lNalJtVDltQXc5ZHlXT0o0ODBEaFJrVEo1T3E4SjFSUWIydVdk?=
 =?utf-8?B?a2Z4bjJ1NDhWd1p4aVB5enlvek9WcVpyMHNYZk5Lb3gxaEYyVWNTTWJnZUx2?=
 =?utf-8?B?TjVSNzdOKzkvcGpPRHU2dGo4d2swWlJQRUVvckRyei9IeFF3NkNoQm1SY3F2?=
 =?utf-8?B?cUcva0lkSkJGTHZXNzdBK0llby9PQkFRdHlWNnZMUHNUMVRlZG9Da2cxdTBF?=
 =?utf-8?B?aXN4Y3g3VkxqU0Y3TmdYdDZhK2pHNlk0N0V0b3hobFdZN3ZpUVNCRk5KTnVV?=
 =?utf-8?B?UUhhN3NGcGcvNGFIUXNDMXRaQmpHSVpETTZFbVVrUnovYUk0TUYrbEU4bUcv?=
 =?utf-8?B?MFNzd2twV21LOHVpRmQ0RllVY3BwenNVeXdvMDZubENuYjYvTjhqMjVUOW5V?=
 =?utf-8?B?a0o4bHJvTnFTUTdrWmMyK2taM1g1MDY0bXlLWlhmelVNWXQwN0MxemdBSzlO?=
 =?utf-8?B?OHFxcVdZd2xka0lXTDZHajNJYW1DcnlheDNZa3VkYlV2dnpvbTVxbGlkd3o4?=
 =?utf-8?B?ZCtPeWFVM3lmbTFyUkZzWHY2L0lkMFdVYnoydTBSRGUvdzlqd2RycFBpcUdu?=
 =?utf-8?B?S1VUbi9VYTBPcGw1QmdtYzliTUpkSEg2R0VHVlFLOE9yV0JJTjMrNHNDcnRw?=
 =?utf-8?B?cEd5QmxwWUJkU1llc3lwRHJNZnVKbWlZZHhSalQyVVgvV0Q4b1ByTW1TMEM3?=
 =?utf-8?B?bzZmOUxvcUJpZytyejV4UHprbXhwRVVQcWZ4dGxZdkJTTW5mOGdLTnc3ZEdu?=
 =?utf-8?B?L2FhU2gzd3hvRUVaY1gvVXY3b2tONXY3VXZ5SXdWV0dkKzR4Sk1ublVnVGRr?=
 =?utf-8?B?cFNERm5ta2hmQzlTQW51QmFWRFJkTTdjamh2dm83TFFoZ2ZJV2xGSlE2Y3BT?=
 =?utf-8?B?dGJ4dkwwY2srd2x1S1RtZHNDTTBRQVQrbldWYS9maERMdHZ1RE0xM3JONEFY?=
 =?utf-8?B?WE5UY3FiVW5Ld0FBb0NwWjl3dTllZThWRG55YndyQjJvakRiV2lYdTNEMGJt?=
 =?utf-8?B?V3AxaS9MZG5qV1BBV0hvdDRrZHZ0SFNUYXV2bjQ4cEpyUCtheFJiOXNnYWlK?=
 =?utf-8?B?UU5oZ1ZqTUJJMFFVQ2FtNk9uVXE2SjZzVTFpRXMvM2s4QUlNTWVreTVRMVF5?=
 =?utf-8?B?bjFtRzhGTG9KMWRjTGQ3alhYYWEzWGVGY3AvUnBVSW5xL0R3QVR3TTB3MUJR?=
 =?utf-8?B?UUZ0amQ1clpoL2p2aWNZNEtWVytOMXp3ZmRCUjBsYUt1UW5KeU5lTU96UDBt?=
 =?utf-8?Q?eu9/2NDSq8QgOZ8A4sIuZCjWaqToHW2FlwF85Wswk6Zr4?=
x-ms-exchange-antispam-messagedata-1: maB3Mungy16+jA==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
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
	WgRP16WcyZyCq1t3Hu8c2UfosGuSg0qzv6maqiEr8aFATGXDlvrTQ7WiAwKPhqAoj5b2t78+4AjEQpWgyJHb3lTdz0ZiGSRvALpuCXsB3nkU/xPIh2tLnbnziCA5eBfLTnhNWO6fjJKWlzsORL3W7heMSN2A3N8qx4onyZJvb5qxSVVHtKgEW1Nhn0zPVZMUC6s5ESYxJZImYjQFLoeQ4PkHE4C/kWS+nBgkBCCMnFOpZrX8EZyp5CNVp6H6RJktlzyqOAcZRwdi7MW529oXks0960mfgHz+BlewKe6pfczKuUmsVtjx7k6UZY1Q+WBl2479S6FnBZ90yH5hnerOLQ==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV9PR03MB8414.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99a2ba16-83bf-4bdd-9613-08df38b7ec44
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2026 08:04:30.3622
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EwsDdmUZxSNv/ZCrdHGxUyYlh94ehzZm7mDvFiceQ+Zf8U4RZ82p9KuWiIaEc+847eFGTOyM1UarxakTh42F4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR03MB5382
X-Authority-Analysis: v=2.4 cv=GZKCDgXL c=1 sm=1 tr=0 ts=6ae84411 cx=c_pps
 a=gTn3qzDU66SAkKtIq75K5w==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=iZSIUCweCk2Oy3QsdGPA:22 a=gAnH3GRIAAAA:8 a=O3Xxk-7qk82cUH-gYgAA:9
 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10 a=zZCYzV9kfG8A:10
X-Proofpoint-GUID: jF47xPGhMLuF8OoK3bQ5bitcPZas6RRe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDAzMSBTYWx0ZWRfX0VdULHWgYQMb
 0GdFaIhmfyjVHuyPST1UxrcLKpm8B5tvCtjdjJuxNTk0zGBilRnrrZqP7CMhgEKAh7LgXrgboCn
 JMqq7fqC7OSVrYzX1HJrvNmLjZCA7/5VlDFobYzsvLKk7whcAcQsM7G7GFlonsKugarPyHXsN6l
 9T5We7j63aHJV/ShZsih5+7rj0vJbOshzy1cfHq1A3qEsF74HliFutVbl0rgQ6vYwFHfdSB2bcW
 oUR2Y2LYZbFDe3Bkdzn1CdkGMdz5ilZb3m/kccInDJEaNzeG3K1ZXPT6VTiaZpB3uycXznZGosu
 gQeTSRXqXSi5gn0VIXFa8yUF0aC80CfqeJvS0LPS7Zdvj6VszwMwNrZz2Fgax2+6LuX5aBrKKEJ
 t6eObOTFfrt5Ab/672s5epQex9c52vb32dXnUt5lrcHwXsJxAWhQzJiz2t3tnqie0EQJcrFOo+4
 68WGn2je/vik7QuEmyw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDAzMSBTYWx0ZWRfX5FVTDPHks+va
 nmcYhBYuvdBUqkCS8UaEeBxswb9FjajpeTtTtUN4G9sOUfpKvlKg43YVzHdWpm9wiL5riwZlFFS
 JD8B9wBxbp6q5i2fuZiWeRkwkV1tHJCq8LZsJkEJdCiLshi3BMQn
X-Proofpoint-ORIG-GUID: jF47xPGhMLuF8OoK3bQ5bitcPZas6RRe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 impostorscore=0 clxscore=1015 phishscore=0
 spamscore=0 priorityscore=1501 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611020031

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBTYSwgTnVubyA8bnVuby5zYUBh
bmFsb2cuY29tPg0KPiBTZW50OiBGcmlkYXksIE9jdG9iZXIgMzAsIDIwMjYgNDowNyBQTQ0KDQou
Li4NCg0KPiA+ICsvKg0KPiA+ICsgKiBTUEkgSGFsZi1EdXBsZXggcmVhZCBvcGVyYXRpb24gZm9y
IEFESVMxNjYwNy4NCj4gDQo+IEkgYXNzdW1lIHlvdSB1c2UgaGFsZiBkdXBsZXggYmVjYXVzZSBi
dXJzdCBtb2RlIGlzIG5vdCBhdmFpbGFibGUgaW4gZnVsbA0KPiBkdXBsZXg/DQoNClllcyAtIGhh
bGYtZHVwbGV4IGlzIHdoYXQgZ2l2ZXMgYWNjZXNzIHRvIHRoZSBidXJzdCByZWFkIGZ1bmN0aW9u
LCB3aGljaCByZWFkcw0KYSB3aG9sZSBzZXQgb2Ygc2FtcGxlcyBpbiBhIHNpbmdsZSBDUy1oZWxk
IHRyYW5zZmVyLiBGdWxsIGR1cGxleCBkb2Vzbid0Lg0KDQo=
