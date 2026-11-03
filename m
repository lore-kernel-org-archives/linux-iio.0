Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.135.77
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793708173;
	b=Vm5GvD9B6v4TfXYc4EXAXjFe8neA23wef7JKnTGCd6bUBzX6I8oyz25ZQ6GsQAZc5dH+
	 69HJ3IDvVrdFXne3kX43RkjzpexQPkKXnl3NWa9T68361LDHYnF5erNi6ACh19dBohcZL
	 TP4cUhk38Ww+bVZlS6BTCvF3QN3SQSp1w2hHM+hRhkukFJPDNHDfSw+xQiu0U+oVWkBW0
	 dlI1xqJ6gmQlSqPUnKuPs8UjLBWCaq2nQ4DoYd2UgM8V52jAn/1WjKbonF76Q5gAmbQMX
	 fqnEwR5a55I1Vs4rDiNNAUcGplWg4+H0FMl1yHvwSP/FV6dW24oSxb8NuKJlTsn0LTA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793708173;
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
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=tD+SaoHId54mVSr5GfGftznJYyjkNcI0JM34do1wzYI=;
	b=EcGQ6nwRGAju/lP8MiXsl6VZUwkhVsQ5gkBTqhqDXZp4JGXtvXuRQRjX1eq5slcpigfv
	 7tvTYrEaUgl/ATqBQm5ssaNF5+3Kwab0uIMZ3DSLQfzm62dQOxRG3nNghBP3r2QWBNSqV
	 2b00FwfgKtaPI8gdT3e8El4yvUvM+cz0zmBTbd7f+/UnHMjAeo4Eg1d0jFE1zgCYk5+/b
	 XpF9clhJA0JnteiwIUH2RdiyEaz0X5KYhpoSa3oxI2/Xvs480FCh//2YvRCqXZBfpe8PU
	 PFwNp9JHJbbuv1dPfkClYsygvEH8YjA3KkbINIPpTRCZ7HVhHOppY0gk1oZNvTyIRYg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=s3jRWYv9;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=1kq7C0fT;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.135.77
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CBB7606A327;
	Tue,  3 Nov 2026 12:16:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7CBB7606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=s3jRWYv9;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=1kq7C0fT
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A3A72aQ3938829;
	Tue, 3 Nov 2026 07:15:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=tD+SaoHId54mVSr5GfGftznJYyjkNcI0JM34do1wzYI=; b=s3jRWYv
	9QrwkmuwEmjlNzu4UvKARWs6TDSkyML+N7qeTyk/QEnQgLvTbvWEHd5kA/yNTaFm
	ytfmENBKZgXSZze0aP2ciDh/xd3UYb0eQDRYNFMT7mULVy0RXkuRv00/KTctwh1E
	Y7+N69nYLJuKSGvjHY0gX47mpQPA5XqErA3rMfZQ5y6XC6GKI+oH1M/1ilB2gn/T
	XfRotsBf9GXAOiMw+916JeqbjyqWEmlntoeAk0x3KGqFQZkl0i8qYiKepfQn9D8l
	AwQ8b+3rAn5sF3kGD9tPq2wUhPhixhVtKnZgSOUsIa6Co2NKOw3cMRZcbLc+Tytg
	ZVorCtVylKffPig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=tD+Sa
	oHId54mVSr5GfGftznJYyjkNcI0JM34do1wzYI=; b=1kq7C0fTklV0o53Wj+QwR
	ug09ib0kYtsB2//gSNmKmyuQyTMjJwxzPbyhae03+TxHPpow5AbJhcEgZYSDSCGE
	SBI4y8oP2nnuAWvRQIg6fa02zTZT5HetpJJkzkemRbh6epVrcYpDh2kO8pXXiwst
	75e+hCu4seUJ36ON0cvwzEPlLJbcjebpxhCls//wCIJAIozcUt0bvMTtJv0URMUd
	9wFSi7bnbXAGfNZ71K3qZnYygC7gGyhwEOrmunPv7a0Z/qlV3Rpp/wAkDDwkZu7U
	1zSCAnOiavt/9TPcHNXXb9UYx3paQjz3HU+WwQykOUp6v8pTqZaC7w3Z2p2Kdyd0
	Q==
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010051.outbound.protection.outlook.com [40.93.198.51])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4hq0nnmreb-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 03 Nov 2026 07:15:54 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wt56UnmlJL0CMhuZhOs0u30AKmBNqWLl3MzmWUCuNYzgzdfdhyMeDEqyc/IyosELtc2xhN3oz4GoCZPX6Q4YczN2HS9U34QXN2q7vVmgi3PO3ks1an8idn5bRZU6X4WQXlWzp5K1Iha/27DiT4a7wjdUrtF9yZ7mRHyu7ZiQTmC7kPYmDMx5H9zAurmbfTDUqhwn/2B/u2E+Q+DTu1OLQdR4VYSjlXtkYHChL4bUzXbV5Z5rzmwCj0uUtitkNOZWCZXwavGR+1adt8kPoU2TYAqFlvjjC+t1e37Lc80SpSWMhW1OOimLAGbpqfFe5yXtV0tNEkwoYxVlkMYhQiHxPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tD+SaoHId54mVSr5GfGftznJYyjkNcI0JM34do1wzYI=;
 b=smaA5KpssZGjJyUtZM6Cqb55b62rxhx11draZT5PPHoIUzFdH1akFS2EHPSrWUFaMsXtobV5oNutmvHoenfhjiWFR9CyR0XarWJta9q6eiz+qUqHd/+g9JbVRYKJPueVtbr9/YLLm5inzt8+HjioXS+sKfI/nODYygYTeHf0zf2o805O2SU7EjAoN+cNp3Q8rbJOzqClBkdVshaMcnh1AlYb0gPpX4fYVmWKFiVckn35QUvxNZkSIk5tCROpbrINKk/MzCpPOU32Z8+eSjOWetql/LbHgaThaZeCqc6NZOm36pnEfl/bvqv37m7iG/xm8XYyRfxog5LU+snqJt1skg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from LV9PR03MB8414.namprd03.prod.outlook.com (2603:10b6:408:367::23)
 by DS0PR03MB7202.namprd03.prod.outlook.com (2603:10b6:8:121::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Tue, 3 Nov
 2026 12:15:51 +0000
Received: from LV9PR03MB8414.namprd03.prod.outlook.com
 ([fe80::d661:7c16:d052:cc81]) by LV9PR03MB8414.namprd03.prod.outlook.com
 ([fe80::d661:7c16:d052:cc81%2]) with mapi id 15.21.0592.007; Tue, 3 Nov 2026
 12:15:51 +0000
From: "Sabau, Radu bogdan" <radu.sabau@analog.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Conor Dooley <conor@kernel.org>
CC: Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael"
	<Michael.Hennerich@analog.com>,
        "Sa, Nuno" <Nuno.Sa@analog.com>, Jonathan
 Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        Andy
 Shevchenko <andy@kernel.org>,
        Alexandru Ardelean
	<alexandru.ardelean@analog.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        linux
	<linux@analog.com>
Subject: RE: [PATCH v5 4/8] dt-bindings: iio: imu: Add bindings for ADI
 ADIS16607
Thread-Topic: [PATCH v5 4/8] dt-bindings: iio: imu: Add bindings for ADI
 ADIS16607
Thread-Index: AQHdaqwlndNRarIkc0eYScmG5r/MobcbLW4AgAEAyoCAABUvEA==
Date: Tue, 3 Nov 2026 12:15:50 +0000
Message-ID:
 <LV9PR03MB841498F9B9889C8F1908EF01F7692@LV9PR03MB8414.namprd03.prod.outlook.com>
References: <20261102-adis16607-v5-0-4f98b0d271ac@analog.com>
 <20261102-adis16607-v5-4-4f98b0d271ac@analog.com>
 <20261102-barista-haste-6f219aa98c81@spud>
 <20261103-accomplished-real-cuttlefish-b6efdc@quoll>
In-Reply-To: <20261103-accomplished-real-cuttlefish-b6efdc@quoll>
Accept-Language: en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV9PR03MB8414:EE_|DS0PR03MB7202:EE_
x-ms-office365-filtering-correlation-id: 7db4c104-834e-4372-7630-08df39a4336f
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|23010399003|7416014|376014|1800799024|366016|38070700021|11063799006|4143699003|56012099006|261102123227099003|261022075727099003|261021121427099003|10067099003|18002099003|22082099003|6133799003;
x-microsoft-antispam-message-info:
 k20Pvcn3CWMTilxR1LGCUVz7t1dV888uiCxebN/b3/DJqb8M0tDIKf9yIk6UuQiO734g9aCOYj544oOVJzm8rPEvKS6nOoDfQfWWAI2LVGBgg9Zbyuq54UjS7TC1/Kte2H3WyGra1oLfeCFe4aDaHHKeFeWRJGKX/Lr/h53WATmWIue6uxMV0jtT3JeVCTnPFkzVP/VTOvoeePR3uuYnkw+OK9VWAT0AgQKgNCp1DnoA2yBoGehV6iKPIS1At3nHxl2uOIiDj8LOEpwOBGrSPI6YH0CTP3W4K9rcq/7HINvKqKUt5DDZJQS39liJKmdPgQDIOAJrd+FCM21bC4g/OKvYreT24APnAzRNofTMAoIun6cP+p+5oWHWOEuBjVcmg3Uo1pBY6u9XhnhwiCLPRg3COvJki1rI91iX/oYFbvPaW9Via0H9uZ9GUteUtmSMQYqB0T866i8JfXJmGXE8d4L4DgetL8jRNNJHjP5L9pk8uBjitI52ce7LiZw8adyHZMNdMyuj9lQTh5YQ3YGFUbqoYDVfaV8CXlgJoJJ7TBt2axbVj8oLF7lNBRheGO6wmbT/SJdIXcKabiewXak6bVu2LpnWW4AjQmg4azY2hlGTU5iRTJfVxqAcXAi0m13yodOnzh7aJFNSHunm7lO1uZ2oGBSKJpbLrsVobO5yaNzohEqDIZVQ3yQAFfPR+r6OCEKZbJA2TLW7KIU8p95Y4Q==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV9PR03MB8414.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(23010399003)(7416014)(376014)(1800799024)(366016)(38070700021)(11063799006)(4143699003)(56012099006)(261102123227099003)(261022075727099003)(261021121427099003)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dlVMYzlNVTVOVGpXd0dhT3Zjci90aVpXck9WdWlycFY4ekR4azJBcEcwUkJC?=
 =?utf-8?B?bXV0SW40QnVFbzhDUEFNeU5rc01vNWZHRDB4UUxCb21hWjhGdHNFcVhoN0xw?=
 =?utf-8?B?Vk10T3laVDZSWDYwU0JUbHR3SzVybmt5SlFyN2pTSWxQcXVrUnB4NDBqbitz?=
 =?utf-8?B?bWdHYlB5ZlRnM01mQjJPdWlmVllMNURKazU4b1ljdGNRMjQzNldPZmxnWG9D?=
 =?utf-8?B?V0NHY2tUdllQQkY1bmdrN3RPZkVJZTBCNUp4MGlOSEZGRTd2M2lnRTg0MzVR?=
 =?utf-8?B?NWhNN0YyQ3Zja01seUU2U1F0RlRsTUJjUnRFWHNKcGlYZWFFczdySGlKeDQ0?=
 =?utf-8?B?N0tPS2Q2RnVjVzk3NXBPTTZkVXpjMTJGVjljaEZEMjRnSWpGMFNNbWpvNXJP?=
 =?utf-8?B?dmZVeGl6M1R1dlFWUHNhUlh4VHVvdFZEZnRvbnVERko1dlNiM1BHVFVnY0hn?=
 =?utf-8?B?c1V0Ujh2WlFDNDdXWDNqUXQ2T3docUJhN0tQdlhXVDhVZVZwb25hbkpNS1lL?=
 =?utf-8?B?dVg0ODV4UEFjVjJWV1MyUVVEUHM1NjJ3N3YzelI4WE84elpTY2tuakthN3lI?=
 =?utf-8?B?a3BRYlZZeDNtSzUvMDFuT3pKWkFvbllxaTY2LzdpdVd5WnZqdFVNKys0Tk9t?=
 =?utf-8?B?Y1RjSEZvcWg1NTVzbDZoRFhwbEZ3eHBJRkpXL04yeVlPR3haR1RINlRPTU1u?=
 =?utf-8?B?WkYweDFTOUw4KzRuZ2ROWmhQdkVRd3Evb3dOUWQ0Nm1uT1hOOGRPV1VMTlFD?=
 =?utf-8?B?MW95emhHWjJEZDZCczVLaml2OUJMbkpHTFV1Q0dsREFtaUErTjUzTE53a05a?=
 =?utf-8?B?dnhYWlYrL3g1VGJjN0w0dXlZa041SEg2dTBkUjVqS292a0FRRlhuVzU1RmEy?=
 =?utf-8?B?dVJNNnBEVmhQM2hsR2x5bzZ3N29VSTVFRnRJY3gydlc1WElpdG9kdXM1RzJi?=
 =?utf-8?B?WEoyU2dpMHdHMTJyL2RTZzlTS25Oa1V4czFOaWhTTXlaaEZLVWJ1SDB1ZWtD?=
 =?utf-8?B?Vy9pSGpzY2xkMEs1eGJyNGFVenBPc3poOWFldFpTNkpadjNKYVEyN20zNkZz?=
 =?utf-8?B?MjJQU1UxVFQxR0ZvZFQ3bHNja2d4OUJiRmQ2Q1NQcWYzWndRUys5ampIcHpH?=
 =?utf-8?B?N1lvMDIvYzgzVVBHdUs2Q2w3QkpyeDZKcW44ZHptRjJoeENuRjFtMjZHQnh4?=
 =?utf-8?B?L1BvNDQ3STdCUUkvSTRqbXFrbTdwRDZmSENCanFrc2F6dEg4ckVYV3VBTTJU?=
 =?utf-8?B?NWc5aG5UTEdjUG9DTmtoTkRYZU9yS1FjUE5zcU5QSHdqNVVRWFJHT21QUnRl?=
 =?utf-8?B?SFMrY3pHdUV3SDdyYmtFcTJSMm9WeUpic3ZLd1dKM3NGc0xBaU80OFhubjlj?=
 =?utf-8?B?NXdOOUNad1N3Z1FwREtqai9qU25CRVNaQjFCOVVSVW93WENTNC9qVjQvWmt0?=
 =?utf-8?B?RzlDelp1UGtIZnFLTkk0M3MyeE9PT20zMHR2WHZNaVYzVWlFK2llbzRsMTlt?=
 =?utf-8?B?V293RWdMRWFCMFRlQjdudmJ5eXg3dmd4VllUSWgyN01CZ3o5WnNwNzZaTmJU?=
 =?utf-8?B?c2JxY1Y2bDBBdEhEcTZXaWYxVlhvKzNTTmZ3MG15RWdJMFdlZlRqZUxnOHFP?=
 =?utf-8?B?L1pOd1JFSkI0ZmhSSm1SMWJKRDBmR2FvOGh3K25oTFhDTko3RUtLSTRmS1Mz?=
 =?utf-8?B?VGxxbHBCdFZuc1BLUTlBS2drVExTMEFJN2VPdDU1YjRBR040c081RDFTSGI4?=
 =?utf-8?B?c0NibkRGcXJuQUd4ZU1wYVkybjhZK0pIU0dMRm9Cak9TdTd1Wk1YZ1NKdEx4?=
 =?utf-8?B?T1hwVU9FNXVtVlA5ZWgwUXdGVEd1bndLQzRuRmJVR0J1Wm01TDNUcFkxTmtJ?=
 =?utf-8?B?bnNvODNOTzlQaXNmbEJNU1dWT0dCVEM4aG1DQ1pHVWxGTmdqZ3lOMDNabEtj?=
 =?utf-8?B?Sjgwa1kvOVhMQllNbTRsTFdiYVNvVFlJMTY1WExJbGNMVGFWUUNpYnFSNjhk?=
 =?utf-8?B?dGw0UW0wdWk0akNNK09WWGpmSklHcDFJOFVvZWR1Tml1bUZwNEtYTE14dTl2?=
 =?utf-8?B?MkZzQ3p6MTVnTlJrQndJTXQzRGJCb2luRWtmTXRoUE8rYmlMcFVmQk5rWGll?=
 =?utf-8?B?d2M1TnZ3cVByQ2E0Q3ozU1M5dWZvbFNNMCsvRTFRZnM4Z0c2QXlMYWlyOHQx?=
 =?utf-8?B?NEovWFI5UGZtRGVCWXJXQU9ndWJHZFZnaXBDbUNUL1hwa2xUMzhUUjdPVVlk?=
 =?utf-8?B?YmltbmU1SE41ZVRVUGd0WXpsbFhyOHdYQldUUW52TzRmd1dRcFdRZU5naUZY?=
 =?utf-8?B?cUtMSUxrWW9MWkYxREN5cmovdDFRRmJVRFppT3I1cFUzalVnbC9kTHRPcTBl?=
 =?utf-8?Q?jct+CGZFy2AX84EZ91hMLE4SwnC8rJyt1FugU5Z5EKZam?=
x-ms-exchange-antispam-messagedata-1: j4YfVyMI6tPWTQ==
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
	5KyKrsH4a5SrxerYJm48NeU3ANluwDFU4t/5mEIVU3bZpX6az0gRAYzPK4GiSe8qw6VfJB4HvRk7+2xqWtzySFDt7ArxQSTwoSUnfj5mx6W2T+X26D3EljBPfvGWpPT2aEe+NEaNuixbClpBcTa/DZDTqyhxhZ67My5uuER2Dnrz2UqZelurxCzHFgbEcLwM+G4ZCdQ0gmlge5eJUA06ZpBqo+q28iIjiRm1L+Tk5Zdh/UGrwMh034wSHkyqsWMQGVFI/IdNz0JuUd0k5FFgD1QjwNrKoYhbmyqZq74PoQIK0NBxbf2SEn45KIQBpERNsAs7oiztEu8SyHMulJ5YDA==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV9PR03MB8414.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7db4c104-834e-4372-7630-08df39a4336f
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2026 12:15:50.9342
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n/JYKMAckBCP94FCiA2Dix6PsKH8ekQ9Rjfb30sVk6GjPZKttghnek5ZNcfEAIWprAAY1rpOitnwwevLovL3qg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR03MB7202
X-Authority-Analysis: v=2.4 cv=XIOl2ghE c=1 sm=1 tr=0 ts=6ae9d07a cx=c_pps
 a=PojWdYBvulneKNx6glcDcw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=OmVn7CZJonkx5R5zMQLL:22 a=VwQbUJbxAAAA:8 a=gAnH3GRIAAAA:8
 a=UR1ONWkXqg0YbhLzrPcA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDA0OCBTYWx0ZWRfX1579Hdq9SU9f
 4ZtLQxcvvtYkBUi70HO6CGMZhBs9w9D1+imyYVvUsCKYqwxXcGPqMWfvGNhAT8G4C6bALaJmOHT
 /NE1GkhU+F89yWmYStw3POpculMGe/jFSlk86aSqvlMlPq6XPoWr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDA0OCBTYWx0ZWRfX16NcxferUI0P
 PkbnQF6XDnihRhn3Fbu+VPp4xQSV88+Wgnc/g+zFX/fLk3wgadWTFdAyfhGH7tBEkQQqJO+syno
 gnXUJzSjVrND73vi5xbzdeW7MqAm3sdez5ZWx5fV+/xXwC2ebTmYZTzvcSvlG6i1ifHulf8rczo
 VtwXWj+O88badmtOx8tYrxf2emFNSsZqBUHpWe8zLXEU/ldMDYju+/svM8rpXYK5G4VrmlAqECW
 H0RoWX0XmcFRg9QzHf6R5FzSYJu1BUkCeXuz28D7xNL4Gjdk2e8SZdusaerxEMct/SniKT/BsCX
 L2L8AaTfRgKgoVuDqeTTw9mmP8SdD/IjJnK50hus/VTXC8d5Gdpu1qSiTZFPbROASDyUi9i82Gb
 sklpkjw33YmukHpEs+4wsxVHfoSXCa1xF8600EU+VCBbQVy9VKoST6uAdIqVmsCX5Fq0Sm6ahqr
 aV2J88yZLZTPY10qtHA==
X-Proofpoint-ORIG-GUID: Lp-Z6QV6C-_GDtLFTdRloMcowMZ9bARL
X-Proofpoint-GUID: Lp-Z6QV6C-_GDtLFTdRloMcowMZ9bARL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_02,2026-11-02_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0 malwarescore=0
 impostorscore=0 clxscore=1011 suspectscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611030048

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBLcnp5c3p0b2YgS296bG93c2tp
IDxrcnprQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IFR1ZXNkYXksIE5vdmVtYmVyIDMsIDIwMjYgMTI6
NTUgUE0NCg0KLi4uDQoNCj4gPiA+IFRoZSBiaW5kaW5nIGV4cG9zZXMgb3B0aW9uYWwgcHJvcGVy
dGllcyBmb3I6DQo+ID4gPiAgIC0gQW4gZXh0ZXJuYWwgY2xvY2sgZm9yIHN5bmMgbW9kZSAoZmFs
bGluZyBiYWNrIHRvIHRoZSBpbnRlcm5hbCA4IGtIeg0KPiA+ID4gICAgIGNsb2NrIHdoZW4gYWJz
ZW50KQ0KPiA+ID4gICAtIEEgaGFyZHdhcmUgcmVzZXQgR1BJTyAoYWN0aXZlIGxvdykNCj4gPiA+
DQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBSYWR1IFNhYmF1IDxyYWR1LnNhYmF1QGFuYWxvZy5jb20+
DQo+ID4NCj4gPiBXaHkgZGlkIHlvdSBkcm9wIFJvYidzIHRhZz8NCj4gDQo+IEV4cGxhbmF0aW9u
IGluIGNvdmVyIGxldHRlciBpcyBjb25mdXNpbmcuIFRoZXJlIGlzIG5vIGRpZmZlcmVuY2UgYmV0
d2Vlbg0KPiB2NCBhbmQgdjUuIFRoZXJlIGlzIHNvbWUgZGVzY3JpcHRpb24gY2hhbmdlIGJldHdl
ZWIgdjMgYW5kIHY1LiBTbyB3YXMNCj4gdGhlIGRlc2NyaXB0aW9uIGNoYW5nZSBzb21ldGhpbmcg
Zm9yY2luZyB0byByZS1yZXZpZXc/DQo+IA0KDQpQZXJoYXBzIHRoZSBleHBsYW5hdGlvbiBjYW4g
Z2V0IGEgYml0IGNvbmZ1c2luZyBhcm91bmQgdGhhdCAic2luY2UgdjMiLg0KVGhlIHF1aWNrIGhp
c3Rvcnkgb2YgaXQgaXMgdGhhdCB2MyB0byB2NCBzYXcgYSBjaGFuZ2UgaW4gdGhlIEdQSU8gZGVz
Y3JpcHRpb24NCmFuZCBzbyBKb25hdGhhbiBzdWdnZXN0ZWQgSSBzaG91bGQndmUgZHJvcHBlZCB0
aGUgdGFnIGluIHY0LCB0aGVyZWZvcmUNCkkgZGlkIHNvIGluIHY1Lg0KDQpXaXRoIEJlc3QgUmVn
YXJkcywNClJhZHUNCg==
