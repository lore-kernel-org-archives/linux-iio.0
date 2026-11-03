Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.139.77
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793700400;
	b=h6cPpk6QhpekINVLJFQEZ1NKmqAuG5hGNafMyzG/FUMjNvX4muu31a9sovBavz2abzUv
	 RD9G4YLe95sX/uHWg6ecawIQuxSQWq9gC3ZUotB998p7CE1zdSiMfNI3HfBSU95fCARRu
	 hb3F6I0k5ttlLULVyuAg9hQnSHMis1+6pf5tqEir+iegxuUjqjABHqQlSBd8vvXPC3tlk
	 nZgbqXonAuDjXza739VRsfS/cCZH6B5GMLT/qDqPuWVM8q77/OA+BiQyXyFGVwscDykRy
	 r8AMJA/KiteyJbHY1mOYgjyDOqlyCHzXSf/xDAOxxIDBv0QcqXtam5shQPxA6SOy3qw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793700400;
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
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=LAtfizMN2HYYfFqJR+wyUqmby66AfqP2AgkcB31OibI=;
	b=cAL35lOYWyEiV9S7CPxv/MCPda6VcWrS5ySCyGV33Lk4qH1M35qdMnr+vxLtcwjn4Jtw
	 5fS39t0Wgcm8INecpm4dMcyobTBVndDjxYbTZLeB+x7NVJ5sC/MQX0dc+52iYsjBuif9y
	 oRLs9HeFCytjxHcNmRGme58G05FNgBZvtQHutC5miudln4mp7yaa77jz18g0e4frql2Vf
	 H3ay3FtkpdIl4u3yBJGirtnWD4lzqrcCFt3Dwx+IyEMIrF0C0UE+pkDdy9CzWZTjOhHeK
	 gRuQMMWE5XHg82ENPCR83yIgreOI0riZvi5Knr6NAZBQdxGJL3OjFPHXGDRNrL2lFTQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=jAH9v9u1;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b="xd/LsiCN";
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.139.77
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FABA606A80C;
	Tue,  3 Nov 2026 10:06:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3FABA606A80C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=jAH9v9u1;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=xd/LsiCN
Received: from pps.filterd (m0375854.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A38xCaD594574;
	Tue, 3 Nov 2026 05:06:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=LAtfizMN2HYYfFqJR+wyUqmby66AfqP2AgkcB31OibI=; b=jAH9v9u
	1KGMZXNi6YNZ9IC6qGW5d/JL4YonNyH/iowB4G6IiV57AO8Xbnn7mC1bHIOrlPIj
	+3f//4Jxx1z6GWumup3OPkhq37FpQloEJTVkFuvqFNzYDgtil100lyZmaUSR46fd
	N4YpmqwKdvDG8KBi7mn5SjWbifl03lHdvw+d9MK1C2VLNYZ64h8nvd86bxLvd/4t
	l3f4O2MlqukdSBcj1MJ2RU3rNcvzTI0TXJMlNi33ruoNDGYc87zlltxXNLarTp4e
	TbTcVSMcHGRmJS6bIMdOGrUBcdGvFu9p0quNBqEnNdePMULfKQdL/ZdgW/a9SXB8
	zDUCOdl9yCmdpTg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=LAtfi
	zMN2HYYfFqJR+wyUqmby66AfqP2AgkcB31OibI=; b=xd/LsiCNsLG/LqjmWE9AZ
	Npsn0347hlvZ4Lo86H7frquxfV++XpdRtSli2wQNvYlWrU6TWj9ME2skOcFixcS4
	d9VHkP2Nhr0xJIONR7y3U5/gkadSlNhhx5Rr8lBgvWtjkcRjHRvnTx/xztjnIEV0
	/NxI1GgVjryeThokvAWziGaKgzh20kXyapRe29kiuuq76CzBHovUYkogHVymsdBJ
	u7Va3iRkhxe3Tx9rgRCOzJYw1tr7JKn/We6zTu3cKfQNFNspf8vdbVyriUJttqc1
	m1+lc0aNpGoPh/rzRPeGncCOwC09JHCougqlZx4N+nx6l6IYUa4lEleOa2mRGyqb
	Q==
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010063.outbound.protection.outlook.com [52.101.193.63])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4hq0wykn58-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 03 Nov 2026 05:06:16 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DSfxxZN/E5k0SivuINhJTkP7DKlUD25b4ty7jlNjmpBY00PeG4+HF764CpAtiac4AzbrCjN1HJnBgTVdkEPcI+sIrqcyi60EzudZiBjxZRY2R7b+Lv2DP5X1H5eqHcX6+NRgm6Gx6rmI6Rzj0zmOCcTwUhU0dwtMG17Q23VPn+6U/XD8545JaP59uwznW2IVuCLESn7fMVuHBxTRzx6o+vmZfHv2vw6KpjmJlQhSJXAVMuTfpn1jmZb+Eh8DLsomSy5dGXSReok8Bg3KUZXfRKMfhRPcZ4r6cuYQWdIFiquC6GVCVEfU5BpSp09n0Pif4VKPJgJpelFwzmRMqNvFCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LAtfizMN2HYYfFqJR+wyUqmby66AfqP2AgkcB31OibI=;
 b=PDtuoqKnC6AvjLGQ+fH6OrO7kUee1NGB9M4R3L+PHtGOyEt4n6R39y+IGYfLlYxY195Nqt2YhWaK0i30Ha4GFjkW7aNcLWkPQ2W2PIqqPyYn/BHZRexnTrdqJEp6MFXo+yGYWvrpmHaQoCHf7BLuijazlnRNTMeiSYW0ioykFDOFiy2culq8wa7DAp1Kq5IjAjuhpostJj4OycQww7PirbT3PpjykAgHj1yBJeuwZfJHeWuiGKiRz/7LIMfxVy65ZMDEhUdt/2dr/Jeevk4kNi1dlEyXQQFbT6fITNeMA7SzZ+iCiZKvdCAp3FAPallb0vmKwMXY7nOkPUyqVMQYKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from DS2PR03MB8418.namprd03.prod.outlook.com (2603:10b6:8:32c::19)
 by CO1PR03MB7916.namprd03.prod.outlook.com (2603:10b6:303:276::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Tue, 3 Nov
 2026 10:06:08 +0000
Received: from DS2PR03MB8418.namprd03.prod.outlook.com
 ([fe80::4669:571:4347:1b1b]) by DS2PR03MB8418.namprd03.prod.outlook.com
 ([fe80::4669:571:4347:1b1b%6]) with mapi id 15.21.0592.007; Tue, 3 Nov 2026
 10:06:08 +0000
From: "Tsao, Bruce" <bruce.tsao@analog.com>
To: "Sa, Nuno" <Nuno.Sa@analog.com>,
        Andy Shevchenko
	<andriy.shevchenko@intel.com>
CC: Jonathan Cameron <jic23@kernel.org>,
        "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Tsao, Bruce"
	<Bruce.Tsao@analog.com>
Subject: RE: [PATCH 0/2] iio: dac: add support for AD5413
Thread-Topic: [PATCH 0/2] iio: dac: add support for AD5413
Thread-Index: AQHdXaP8M+1ukguSuk6GgnmGOadjObcEkV4AgAG4jzCAAULsAIATKFgAgAGEbLA=
Date: Tue, 3 Nov 2026 10:06:08 +0000
Message-ID:
 <DS2PR03MB84187FC75752460484048798FB692@DS2PR03MB8418.namprd03.prod.outlook.com>
References: <20261017-ad5413-upstream-v1-0-61f40c8fef25@analog.com>
 <atXY4kLEXxmG-tnk@ashevche-desk.local>
 <DS2PR03MB84188FD41F8847EEB34759D9FB672@DS2PR03MB8418.namprd03.prod.outlook.com>
 <athZVjaGYmCyuNrW@ashevche-desk.local> <auhqSGR84LUTjBS7@nsa>
In-Reply-To: <auhqSGR84LUTjBS7@nsa>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS2PR03MB8418:EE_|CO1PR03MB7916:EE_
x-ms-office365-filtering-correlation-id: 097b534b-05b1-436c-f000-08df399214dc
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|23010399003|1800799024|376014|366016|38070700021|261021123027099003|261021130227099003|261021121427099003|261021135927099003|11063799006|4143699003|56012099006|261028144727099003|261026130827099003|261026121527099003|261022075727099003|261022105027099003|261022115727099003|261026140227099003|261009223027099003|261022113327099003|10067099003|18002099003|22082099003|261102123227099003|6133799003|3023799007;
x-microsoft-antispam-message-info:
 PZF0yb42gMtsoU1O2zqMwERVy2/5KVl5LRXeIsCo8J8ZGYs88WEYmIpTaPebrfiF1o8Mzc8EBlIJSytxn3KHb0/dlf47u4LyBFylBFvY8Mu5TfmL00Vlio+g2ZZAnk8Gu5Wnau6k1fpW+Bigs8SPx8570EIitxcz0GVeaMLXcAKN2Ng+avbBNQuZqiNrqwA3Bk1Z0dmKahUMCgx2AgEFImrvWabHP3QQn3KKx0gk7w0mOYsEaM1MJQqmP4j5KnRTYJp3Xci7cfBGOqiJD5jUKU1z/QuxK/SLiEZwBwNXMnThNLVywhUTHnmojIFZwk7Qr7kNGNd7y7MARFlD+7cgr+4/stXUigpt9341imnMvZM6JQ3y8lMDzabsNH/4groxzHpIYMMXfD9lTflT6cbLIT+zfPCPXusdWKQPgx3hAFdOMCODMh3rxJp0cKsSl5W7Iz94TGV12ByydFaUDleAH61p0ehoTZgxl0K3ZfFiyTKwD27OdXqyltjKGwzIwns74g0u8SlJGblvurvncj9Dd5r1kjVPm1eTK9Y9FQt2UsqDILzBxYfDrdWaTiPCpsGpB3m/EEAfY5ZzTUcRsKVk9q9IvO0/RsB5hwgpUsEEE84jUfopr4XYB25Z3tzmutpGJukFv6dR/Ro/3z9QOt+mtvaAUWgXks6eVEnlB55IWSwBIdtzQqiZWK3oclvr4EQP620lxSRU8b6gwxBIhS2WD6R9M0qfme3jxxaHZM9TBBw=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS2PR03MB8418.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(1800799024)(376014)(366016)(38070700021)(261021123027099003)(261021130227099003)(261021121427099003)(261021135927099003)(11063799006)(4143699003)(56012099006)(261028144727099003)(261026130827099003)(261026121527099003)(261022075727099003)(261022105027099003)(261022115727099003)(261026140227099003)(261009223027099003)(261022113327099003)(10067099003)(18002099003)(22082099003)(261102123227099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZVhyaE1NclpPbmg4SHhTTTNSNFhoRUp2VnpUbW9vajBWMUprbXNMWlZ6S056?=
 =?utf-8?B?K20ydVJzaWd5TTY1RnhmaEFCMG1hTDRSRWpMQ0w2SFV2WlR0LzAzNkF1ZUhO?=
 =?utf-8?B?YXJrSkE4bVEwclRnWXA0M1JERlF3WTdVVDZOUzNLRDJobnlXZ0grU2g1TXlW?=
 =?utf-8?B?WEpzN3pZd2tpRGFmUlFxNDVIcmJxTE91c2szaEFCT0NFdzFrOXY5RkdaREJQ?=
 =?utf-8?B?QjE4TnZQOVdSUXhuME40ZDFHb3JObFFRV1BpS3FRWmRJRjgwZkx1c1VZT2hK?=
 =?utf-8?B?TG9XOGJ0aGJ4eDhQVjNtaEM2bEFtQzZmeHAveUhjS3lTSitDSVpNOEJKYlMx?=
 =?utf-8?B?WnM1dFBLdmNlMWVNZzduRGlVU2VCMncwb0JRay9menpUQW9Fa3dTOG5vZDV3?=
 =?utf-8?B?K0tQSWxydTE1WFJjQ1h6V3V4NnVDT0QyRzdHMlZuREVEc1F0ek9uMTlNbTFk?=
 =?utf-8?B?ZTc5WW1ya1ROYnkrZFI4UGpXaGs4ZkQ1eVZYbytMankzaEJuYzU5VXNvRnhO?=
 =?utf-8?B?MHpFTmtWbUVuM0FsanZIbk1mMS96MjRkZFdkb0Q0UjkxcEFRSkFKZTJGZ3px?=
 =?utf-8?B?VFgvc0NkQkpOVE1DYWdzMjJNZ05CSUthUFhVc3VZRVNVamtqdmtQbWo1bUZj?=
 =?utf-8?B?ZnlTcG8rNjk0ZEpXdG4zVFV4eDVObU9MUjJHWGxEb2Ftb1FPVUNtQXdRVWVM?=
 =?utf-8?B?SzFGT2ZMclpia09vekc2Ylh0dHpGaE9wRzlFdjVCcFBlRFNWcWExblQ4WHM3?=
 =?utf-8?B?RVBCZWRJWHRRWTBHeDBJUHFrTTRBTTdFSGFrK3l3bXdOTDRncDdFWkE2WmRQ?=
 =?utf-8?B?dEtMQVVGU2lGR3RUcUZ3L2VUVFV4ZXBIekFZSG53RXJRa1ZUWmx4eG1yWjdE?=
 =?utf-8?B?dkxmUlkwZk9MRUpaZ1hzZHYyWlZtZklKcFF0U01GS2lYMEVTRE9SRHd6QjdS?=
 =?utf-8?B?Y2ZVYmRRQWxmV25GREVla0JUOFBrdEo0WnFWcXFxaytjVlFpa0F0RkhpMlFr?=
 =?utf-8?B?SHUrM2xXY0E4YnVWQjRhNkdCMTRyUWgzN3htekhxcGpXYm9qcWNBUFQ5WlQw?=
 =?utf-8?B?Z2JhMmowQkR0QjFPZWdCem9oWlAxTWFUVEZnT2pCVHBZZjZ3Z1Jpak15cWY3?=
 =?utf-8?B?dUZNc3dqT040WWw0b0RsMkxzK2tmNUI2dkNUNkNjTy83SHVIZkJEQlV6MHRT?=
 =?utf-8?B?VnJhUVFyUVYwM21LTm1FMm9wS0NGbW9RMk8rbTBkOUlRVDE3WFYwWjU3S3Fa?=
 =?utf-8?B?MUx5YXQwOEJ3Njd3ZDFCSDVJaFMvY1dWTko5S3ZLVlY4SHZ6ODRrZXYvSFFK?=
 =?utf-8?B?U1plZXU0WjZWaUJwTHUzSFB0RWd4cmppaDVoSmFlZlhrZkFMTmVDdTg2OStI?=
 =?utf-8?B?M3c3aDQrNGo1SmR4MHZaU1hCUmU0TXZpKytxeFVzTzBsS3Y1K2lrUDNOQTk2?=
 =?utf-8?B?eVcwRGZkYTlBVlczeFFaaG5zK2MwajAyeVN3V3IyM001NmdDQWMzRk1rSUV4?=
 =?utf-8?B?Q2Y4QlMyMjBtMmt5eHRkb3J5YW5mTkNjUFN4SndZRHM4MS9KQzdaRWVGODVS?=
 =?utf-8?B?eUQ5cWF0Y29HMEFvaG1VN2tqcTFyZmRnTng4Zms2R0s0MTArb0dTNTJDNnRS?=
 =?utf-8?B?V2t1SmVwM0gvMCtJMjMzNmJwMWpmQXV4NVBOTVZONFlzNUdRWWNTQTlDVnQv?=
 =?utf-8?B?WkpXT1QxUlZYaUFDVHAvaHB3ajYyZm8xRWY4TldjWGZVVWg1dDlsMk9tcW85?=
 =?utf-8?B?aDhqZDBsbThSWEc3MzhRVDk2Z3R5L0tTOUt6RjY4cE5IRWlCbnZTVjNnMWph?=
 =?utf-8?B?R3ZUYk1ReW0xdzk0cXNWNGo4RlVUUjA2VmJPa1ZYTk4zd3N2Mkc2V0Q1Qnhs?=
 =?utf-8?B?TlFiTEord3VrNzBDK1ZGTkVsd1ZmcDZycWRkRkpWTVhIY0NBaFdVODA4WFBn?=
 =?utf-8?B?dUJmbWdndHQ2WjVBMXZpaFpaeFpYWjI0akRKelNDYUoySVR0emQwY25UbWpl?=
 =?utf-8?B?TERHekxzNEM2c051RlA2THBrL0xmV3NlRVpOUWt2NkxTcDk4YnZTY0luTmJ3?=
 =?utf-8?B?OGRzZWhsZHBYbDNYaldFQ3Q5b1RsUForcFVINXBzS3RGNmV0cHB0VzdlSFV0?=
 =?utf-8?B?dEMzK2dXc3RsWUsyVFF5ZndNaFZlQm0rcTNWbkorYUxZRU5XTGNudCsvOEI5?=
 =?utf-8?B?QnViNVFpUnBLd2R3ODlKUHRROHNrc1NjcC84SHFzOFhtd2x2U3MxYXlyc3JZ?=
 =?utf-8?B?eno1NUFrRlQ1MUV3VVYycWo2eFVSVWUxcHQxVCtobGVJTDRPdjdyd0pTb2lO?=
 =?utf-8?B?Y0drWmpIWmsyVmlQcVVJZmpqN0E3NEhVSUFlaG9HZmcrR2hTd0Z6UT09?=
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
	S57pu8GAmZgOsn06h0YkkAtlgFCvOs7dU5Yd3Tw5QiwH6mFMuluDA4Uyud5puftNW0tI3ZLRBRC1JrC72wThkwMAgp6oDOlKNHBI+0S89rmEthywiToRGG9q/KEeht7MlbscVRsmNOHIOATHo1IX7lU2VD3eqBIh5UrNt4e2280WT8CPMx/DMnppeTEMEvve/kWcGkv3ohVBxfhUi36+mU4zXO6dg7Ot2Y/EBDFZDCfJpapCGR8kRf/TcTO417X3rTj+qnItQAzbHIjpqT26ObMP+sTYelyBGfzhfh1KgtwTG/Peo3aFIwIbpzrkCNbiCrdJ7NZbcibf9VEovxsgOA==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS2PR03MB8418.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 097b534b-05b1-436c-f000-08df399214dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2026 10:06:08.7560
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: InNb/VG9Z5ytJdDlXcP8+dm+3afW85GcFjZVRyXHnyNmNIVioKdnjNu25zQb//whcZRbht0/1HH4qT7OgvoWpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR03MB7916
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDAzOSBTYWx0ZWRfX8kruthdHclp4
 1nKuipmIrCh1PTO12Y0boJQYykpCl4t1ybTd1j/wko18weJEDgy0r0+VUYOwx0ZC4BdbrLPnX5W
 DTqF0cioJ8ADybXLJw6mMw3LFqKUrg1SDiWYYZd/WgqW9SCPzHO0LVzLPdzY0JCAEvz9WlTWdDI
 lQV0skvb6sidSIyWSXlFM5+AFNqg1E3yb4jvCFMOJbOXOg2VrxmeBGunoMt6hlayUX+JoHtWnVz
 PZMd0uUS1xmGeH2VghBp0eN5UN1DD7aEJOS6f3iB+8sUyJTsfEsBmwNO2PdKJuoIwiBYY+Xy5mq
 1eYX/CA1U5wmAghim9s6NaO/VbPE+pTUwg1s7luwGhZSiUT/L8ssh85zh+z/p6jUUyWXr/XpWvl
 TuRLQ+qUEta6DlplBy/vnKUcDyL9AEwnohPZzWmSNUMhxzZqMN84qFo6evfXm9wYQuxzYk5JbzB
 HyMrLCTgFX/ue96uw1A==
X-Authority-Analysis: v=2.4 cv=MqbHeGae c=1 sm=1 tr=0 ts=6ae9b218 cx=c_pps
 a=FmVrivm6CVS+kYk2MGmjxQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=iZSIUCweCk2Oy3QsdGPA:22 a=gAnH3GRIAAAA:8 a=QyXUC8HyAAAA:8 a=VwQbUJbxAAAA:8
 a=IpJZQVW2AAAA:8 a=HXV2p9v48i9gL48ICIkA:9 a=QEXdDO2ut3YA:10
 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-GUID: qjxefrGblevGOu4JAhM4icSofph5c_fp
X-Proofpoint-ORIG-GUID: qjxefrGblevGOu4JAhM4icSofph5c_fp
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDAzOSBTYWx0ZWRfX6aSSDZBSFIPD
 Ovx8jvmB34t5wZaoC9f7geCeFkEx34kRzoTl03i2rlHPPh/vWYMJWnvxVXllLgk7hTnncc2yoMR
 brY3jYKhpxR/UludsHMV4ho8OF++zAdhvkB7KF+8jlc0rfc4E+uo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_01,2026-11-02_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 impostorscore=0 suspectscore=0 spamscore=0
 malwarescore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611030039

T24gTW9uLCBOb3YgMDIsIDIwMjYgYXQgMTA6NTI6MjJBTSArMDAwMCwgTnVubyBTw6Egd3JvdGU6
DQo+IElmIHRoZSBkaWZmZXJlbmNlcyBib2lsIGRvd24gdG8gd2hhdCB3YXMgc3RhdGVkIGluIGhl
cmUsIHNlZW1zIHRvIG1lIHRvDQo+IG1lcmdpbmcgdGhlIGRldmljZSBpbiB0aGUgZXhpc3Rpbmcg
ZHJpdmVyIGlzIHZlcnkgbXVjaCBkb2FibGUgYW5kIHJpZ2h0Lg0KDQpUaGFua3MsIGJvdGggLS0g
dGhhdCdzIGEgZmFpciBjYWxsLiBJJ2xsIHJlc3BpbiB2MiB3aXRoIHRoZSBBRDU0MTMgYWRkZWQg
YXMgYQ0KdmFyaWFudCBvZiBhZDU3NTggcmF0aGVyIHRoYW4gYXMgYSBuZXcgZHJpdmVyLg0KDQpN
eSBwbGFuIGlzIHRvIGZpcnN0IHJlZmFjdG9yIGFkNTc1OCBpbnRvIGEgY2hpcF9pbmZvLWJhc2Vk
IGZvcm0gd2l0aCBubw0KZnVuY3Rpb25hbCBjaGFuZ2UgZm9yIHRoZSBBRDU3NTgsIHRoZW4gYWRk
IHRoZSBBRDU0MTMgb24gdG9wLiBUaGUgcGVyLWRldmljZQ0KZGlmZmVyZW5jZXMgKDE0LSB2cyAx
Ni1iaXQsIHRoZSBvdXRwdXQgcmFuZ2VzLCBhbmQgdGhlIGFic2VuY2Ugb2YgdGhlIERDLURDDQpi
bG9jaykgZml0IG5hdHVyYWxseSBpbnRvIGNoaXBfaW5mby4NCg0KRm9yIHRoZSBDUkMgSSdkIGhh
bmRsZSBpdCBwZXItdmFyaWFudCBiZWhpbmQgYSBmbGFnOiB0aGUgQUQ1NzU4IGtlZXBzIGl0cw0K
Y3VycmVudCBiZWhhdmlvdXIgKENSQyBkaXNhYmxlZCBhdCBwcm9iZSwgbm8gQ1JDIGJ5dGUpIHNv
IGV4aXN0aW5nIHVzZXJzIGFyZQ0KdW5hZmZlY3RlZCwgd2hpbGUgdGhlIEFENTQxMyBrZWVwcyBD
UkMgZW5hYmxlZCBhbmQgYXBwZW5kcyBhIENSQy04IHRvIGVhY2gNCmZyYW1lLg0KDQpEYXZpZCAt
LSBzaW5jZSB5b3UgaGF2ZSB0aGUgYmFja2dyb3VuZCBoZXJlOiBhZDU3NTggY3VycmVudGx5IGNh
cnJpZXMgQ1JDIGFzIGENClRPRE8gYW5kIGRpc2FibGVzIGl0IGF0IHByb2JlLCB3aGVyZWFzIHRo
ZSBBRDU0MTMgaW1wbGVtZW50cyBwZXItZnJhbWUgQ1JDLiBGb3INCnRoZSBtZXJnZWQgZHJpdmVy
LCB3b3VsZCB5b3UgcHJlZmVyIChhKSBrZWVwaW5nIHRoZSBBRDU3NTggQ1JDLW9mZiB2aWEgdGhl
IGZsYWcNCihubyBiZWhhdmlvdXIgY2hhbmdlKSwgb3IgKGIpIGFsc28gZW5hYmxpbmcgQ1JDIG9u
IHRoZSBBRDU3NTggdG8gZmluaXNoIHRoYXQNClRPRE8/DQoNCkknbGwgZ2V0IHN0YXJ0ZWQgb24g
dGhlIG5vLWZ1bmN0aW9uYWwtY2hhbmdlIHJlZmFjdG9yIGluIHRoZSBtZWFudGltZS4NCg0KVGhh
bmtzLA0KQnJ1Y2UNCsKgDQrCoA0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IFNh
LCBOdW5vIDxudW5vLnNhQGFuYWxvZy5jb20+IA0KU2VudDogTW9uZGF5LCBOb3ZlbWJlciAyLCAy
MDI2IDY6NTIgUE0NClRvOiBBbmR5IFNoZXZjaGVua28gPGFuZHJpeS5zaGV2Y2hlbmtvQGludGVs
LmNvbT4NCkNjOiBUc2FvLCBCcnVjZSA8YnJ1Y2UudHNhb0BhbmFsb2cuY29tPjsgSm9uYXRoYW4g
Q2FtZXJvbiA8amljMjNAa2VybmVsLm9yZz47IGxpbnV4LWlpb0B2Z2VyLmtlcm5lbC5vcmc7IERh
dmlkIExlY2huZXIgPGRsZWNobmVyQGJheWxpYnJlLmNvbT47IEFuZHkgU2hldmNoZW5rbyA8YW5k
eUBrZXJuZWwub3JnPjsgUm9iIEhlcnJpbmcgPHJvYmhAa2VybmVsLm9yZz47IEtyenlzenRvZiBL
b3psb3dza2kgPGtyemsrZHRAa2VybmVsLm9yZz47IENvbm9yIERvb2xleSA8Y29ub3IrZHRAa2Vy
bmVsLm9yZz47IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5r
ZXJuZWwub3JnDQpTdWJqZWN0OiBSZTogW1BBVENIIDAvMl0gaWlvOiBkYWM6IGFkZCBzdXBwb3J0
IGZvciBBRDU0MTMNCg0KT24gV2VkLCBPY3QgMjEsIDIwMjYgYXQgMDk6MTk6MDJBTSArMDMwMCwg
QW5keSBTaGV2Y2hlbmtvIHdyb3RlOg0KPiBPbiBUdWUsIE9jdCAyMCwgMjAyNiBhdCAxMTo1Mzo1
M0FNICswMDAwLCBUc2FvLCBCcnVjZSB3cm90ZToNCj4gPiBPbiBNb24sIE9jdCAxOSwgMjAyNiBh
dCAxMTo0NjoyNkFNICswMzAwLCBBbmR5IFNoZXZjaGVua28gd3JvdGU6DQo+ID4gPiBXaHkgaW4g
YSBicmFuZCBuZXcgZHJpdmVyPw0KPiA+IA0KPiA+IFRoYW5rcyBmb3IgdGFraW5nIGEgbG9vay4N
Cj4gPiANCj4gPiBUaGUgbmVhcmVzdCBleGlzdGluZyBkcml2ZXIgaXMgYWQ1NzU4LCBhbmQgdGhl
IHR3byBwYXJ0cyBhcmUgY2xvc2VseSANCj4gPiByZWxhdGVkIGF0IHRoZSByZWdpc3RlciBsZXZl
bCAodGhlIERBQ19DT05GSUcgUkFOR0UgZmllbGQsIA0KPiA+IERJR0lUQUxfRElBRywgdGhlIHNs
ZXctcmF0ZSBibG9jaywgdGhlIHJlc2V0IGFuZCBjYWxpYnJhdGlvbi1yZWZyZXNoIA0KPiA+IGtl
eXMpLCBzbyBhbg0KPiA+IGFkNTc1OCB2YXJpYW50IGlzIGNlcnRhaW5seSBmZWFzaWJsZSAtLSB0
aGF0IHdhcyB0aGUgZmlyc3Qgb3B0aW9uIEkgDQo+ID4gY29uc2lkZXJlZC4NCj4gPiANCj4gPiBU
aGUgZGlmZmVyZW5jZXMgYXJlIGEgbWl4IG9mIGhhcmR3YXJlIGFuZCBjdXJyZW50IGltcGxlbWVu
dGF0aW9uOg0KPiA+IA0KPiA+IC0gSGFyZHdhcmU6IHRoZSBBRDU3NTggaW50ZWdyYXRlcyBhIERD
LURDIGNvbnZlcnRlciAoYWRpLGRjLWRjLW1vZGUgaXMNCj4gPiAgIG1hbmRhdG9yeSBpbiBpdHMg
RFQgcGFyc2UgYW5kIGN1cnJlbnRseSBkcml2ZXMgY2hhbm5lbCBzZWxlY3Rpb24pIHRoYXQNCj4g
PiAgIHRoZSBBRDU0MTMgZG9lcyBub3QgaGF2ZTsgdGhlIEFENTQxMyBpcyBhbHNvIDE0LWJpdCBy
YXRoZXIgdGhhbiAxNi1iaXQNCj4gPiAgIGFuZCBzdXBwb3J0cyBhIGRpZmZlcmVudCBzZXQgb2Yg
cmFuZ2VzLg0KPiA+IA0KPiA+IC0gQ3VycmVudCBpbXBsZW1lbnRhdGlvbjogYWQ1NzU4IGRpc2Fi
bGVzIHRoZSBTUEkgQ1JDIGF0IHByb2JlLCB3aGVyZWFzDQo+ID4gICB0aGUgQUQ1NDEzIGRyaXZl
ciBrZWVwcyBpdCBvbiBhbmQgY29tcHV0ZXMgYSBDUkMtOCBwZXIgb3V0Z29pbmcgZnJhbWUNCj4g
PiAgIChDUkMgaXMgb3B0aW9uYWwgb24gdGhlIEFENTQxMyB0b28pOyB0aGUgdHdvIGFsc28gdXNl
IGRpZmZlcmVudCByZXNldA0KPiA+ICAgQVBJcy4NCj4gPiANCj4gPiBOb25lIG9mIHRoaXMgbWFr
ZXMgYSBzaGFyZWQgZHJpdmVyIGltcG9zc2libGUgLS0gdGhlcmUncyBhIGdlbnVpbmUgDQo+ID4g
Y29tbW9uIGxheWVyICh0d28tc3RhZ2UgcmVhZGJhY2ssIHJlYWQtbW9kaWZ5LXdyaXRlLCB0aGUg
DQo+ID4gcmVzZXQvY2FsaWJyYXRpb24vc2xldy9vdXRwdXQtZW5hYmxlIHNlcXVlbmNlcykuIEkg
d2VudCB3aXRoIGEgDQo+ID4gc2VsZi1jb250YWluZWQgZHJpdmVyIG1haW5seSB0byBrZWVwIHRo
ZSBjaGFuZ2Ugb2ZmIGV4aXN0aW5nIGFkNTc1OCANCj4gPiB1c2VycyBhbmQga2VlcCB0aGUgYmxh
c3QgcmFkaXVzIHNtYWxsLCBhdCB0aGUgY29zdCBvZiBzb21lIGR1cGxpY2F0aW9uLg0KPiA+IFRo
YXQncyBhIHRyYWRlb2ZmIHJhdGhlciB0aGFuIGEgaGFyZCBsaW5lLCBzbyBpZiB5b3Ugb3IgSm9u
YXRoYW4gDQo+ID4gd291bGQgcHJlZmVyIEFENTQxMyBhcyBhbiBhZDU3NTggdmFyaWFudCwgSSdt
IGhhcHB5IHRvIHByb3RvdHlwZSBpdDsgDQo+ID4gSSdkIGp1c3QgbGlrZSB0byBhZ3JlZSB0aGUg
ZGlyZWN0aW9uIGJlZm9yZSBzcGlubmluZyBhIHYyLg0KPiANCj4gSSBhbHNvIHdvdWxkIGxldCBE
YXZpZCB0byBjb21tZW50IGFzIGhlIGhhcyBhbiBleHBlcnRpc2UgaW4gdGhlIA0KPiBjb21iaW5p
bmcgZHJpdmVycyAoaWYgSSdtIG5vdCBtaXN0YWtlbikuIEluIGFueSBjYXNlIGhlIGlzIGFsc28g
YW4gDQo+IG9mZmljaWFsIHJldmlld2VyIG9mIElJTyBhbmQgbWlnaHQgaGF2ZSBzb21lIGdvb2Qg
aWRlYXMuDQo+IA0KPiBGcm9tIG15IHBlcnNwZWN0aXZlIHNvdW5kcyBsaWtlIHRoZXJlIGlzIG5v
dCBlbm91Z2gganVzdGlmaWNhdGlvbiBmb3IgDQo+IGEgYnJhbmQgbmV3IGRyaXZlci4gSSByZW1l
bWJlciBzZWVpbmcgc3VjaCBhIGNvbmZpZ3VyYXRpb25zIChhcyBwZXIgDQo+IHlvdXIgaXRlbSAx
KSBqdXN0IGJlIHByb3ZpZGVkIHZpYSBkcml2ZXIgZGF0YSBkZXBlbmRpbmcgb24gdGhlIGNvbXBh
dGlibGUgbGluZS4NCj4gQXMgZm9yIHlvdXIgaXRlbSAyLCBJIHNhdyBzb21lIGRldmVsb3BtZW50
IGZvciBDUkMgY2FzZSBpbiBhbm90aGVyIA0KPiBkcml2ZXIgYW5kIElJUkMgRGF2aWQgZHJpdmVu
IHRoYXQgYWN0aXZpdHkgYW5kIGhlIG1pZ2h0IGdpdmUgYSBiZXR0ZXIgdmlldy4NCj4gDQoNClll
YWgsIHRiaCBJIGRpZCBub3QgZXZlbiBxdWVzdGlvbmVkIHVzaW5nIGFuIGV4aXN0aW5nIGRyaXZl
ciAoaW50ZXJuYWxseSkuIE5vcm1hbGx5IEkganVzdCBhc3N1bWUgdGhhdCB3b3JrIHdhcyBhbHJl
YWR5IGRvbmUgYnV0IG5lZWQgdG8gYXNrIHRoZSBxdWVzdGlvbiB5b3UgZGlkIG1vcmUgdGltZXMg
OikuDQoNCklmIHRoZSBkaWZmZXJlbmNlcyBib2lsIGRvd24gdG8gd2hhdCB3YXMgc3RhdGVkIGlu
IGhlcmUsIHNlZW1zIHRvIG1lIHRvIG1lcmdpbmcgdGhlIGRldmljZSBpbiB0aGUgZXhpc3Rpbmcg
ZHJpdmVyIGlzIHZlcnkgbXVjaCBkb2FibGUgYW5kIHJpZ2h0Lg0KTm9ybWFsbHksIGlmIHRoZSBy
ZWdpc3RlciBtYXArIGZpdHMsIHRoYXQncyBhIGdvb2QgaW5kaWNhdGlvbiB3ZSBjYW4gaW50ZWdy
YXRlIHRoZSBkZXZpY2UgaW4gYW4gZXhpc3RpbmcgZHJpdmVyLg0KDQotIE51bm8gU8OhDQoNCj4g
LS0NCj4gV2l0aCBCZXN0IFJlZ2FyZHMsDQo+IEFuZHkgU2hldmNoZW5rbw0KPiANCj4gDQo=
