Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE86F31352A;
	Tue, 31 Mar 2026 17:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774977049; cv=fail; b=ONCbT62+2SnX6dKbcdyjeyVLbWDbBUfSbyNfWibxbvtF4RwVz1+8ewjeK3EGVnLQvpoRaDE+NZvg/gVIUFuSBaXYbxwSDdwCMheyPWUJXAtlHHA/f6ITaqnagpEUxtZ/tYgqGEoIt0/WzukYf2X9LCPWYy0sQuG0WCw39fub4wQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774977049; c=relaxed/simple;
	bh=dcxzePs6xZnE/G9f9qQRm/YI6LueC4Mcqc8j+QjJFHw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mSdr3U9OyGFggeUacFaui9s3eRVX16PjdlT+gCXj4sU7fY1y6kaEXIQ27jDzrcBbwu7NPx+CldCVB6d1UQUBB1tA7U3cMMXiOgxozLU/NDpvqYUPOPtJk+Vnj4vO8mfh7XIVGCbjAY/F8G4hgczBn8MrxuTGBB3KBCSw7WvKtoA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=GnKNz86c; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="GnKNz86c"
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62VCG81Y1052049;
	Tue, 31 Mar 2026 13:10:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=dcxze
	Ps6xZnE/G9f9qQRm/YI6LueC4Mcqc8j+QjJFHw=; b=GnKNz86ckRpl+4nluCFZK
	0/mecTexhNpI94gqzZGHLupxinLmX6b6wTvW7iPFeiJGfOs7gz1IbFLN4tb75C5J
	LAKzeeHIcW5avWrTv82U5KE5AFcXuobiLXs0fq70PJOXYiypNS/i45EmTbzYvvLJ
	mAlOkfT1tSsMJzEsWtJT+VgxwROOEdBD/9PPUp+BuyEoSZizGa/K1EFyoOi4Jq22
	jguIFn2TlAJnRbSRequ6e7cTZ/LhD0epKFf6C/acHo4whOtt0obvuhTBkGY4ON9D
	9IrBaSL3wRB7W9crACn5gknNuC1DSnaaR2li1Gytcdv9ZyxRYVC1diQXw9ShJAZb
	Q==
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013049.outbound.protection.outlook.com [40.93.201.49])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4d7gmkqjbf-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 31 Mar 2026 13:10:30 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yIil9oj9mcdIajFk6YGD0q1ipbgEEN7w1xhqELV/hgeJ0muxJktXnffKNwwk9Tc7mBZ5yKgUMLVcTK3SizC2X554zHppAu6bV2lG3DzzsFNNJ+yDYInh/bQErCvjIIvuVhHxOcRKfeQ/Rkh6me3rFM+R57MOBuw+NeBHAjCS/uVyxXErtZOsBMdMDZBgPB903mT4Fih4bewLN9TXcR4V6Z3yKN9fkklWyZfooICi1HO4yw+keX8uiu1PGWCXoU6NfsKgQ9m5v7tTKEnTICwOkwlgCwiF552DjrcvIU3RNjyBSTGzupZ3bXcLrAYoi+KCyfG5xfUJ37jmxi1AY7i7tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dcxzePs6xZnE/G9f9qQRm/YI6LueC4Mcqc8j+QjJFHw=;
 b=QLr3EMl8OSKxfrAyemZ3074uuqHpWCVJ/MIwQIPM/qs+Ze8WkEypJOBkqJ++7bBL+CGYynmvBkuY6VIqd/G7LOnY/Z3Fmv9qHmAv+ZGgNX7eWn5pKWtaHYIc+vEqMo9ewcEOygaUKpsB9wS0dMUKgFliWDaAZBAF0YPH60Xs6bGslUrWGINbxxblEs8rA7xLtsVzFc5op7wtzhXge0qcYcC2ectkQfvQOG9hGfKOwVuOm0KICdRhYGskkg+oXJzSmFCujEpW10nkthiTXXNqDQjsepZ5Sf1b7FQnXtoi89kSiVjwMQPWxWfhFSSy0A16PaZmHFnPePAIGzoz+qEsBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from LV9PR03MB8414.namprd03.prod.outlook.com (2603:10b6:408:367::23)
 by CH4PR03MB7747.namprd03.prod.outlook.com (2603:10b6:610:23a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Tue, 31 Mar
 2026 17:10:22 +0000
Received: from LV9PR03MB8414.namprd03.prod.outlook.com
 ([fe80::d661:7c16:d052:cc81]) by LV9PR03MB8414.namprd03.prod.outlook.com
 ([fe80::d661:7c16:d052:cc81%6]) with mapi id 15.20.9769.014; Tue, 31 Mar 2026
 17:10:22 +0000
From: "Sabau, Radu bogdan" <Radu.Sabau@analog.com>
To: David Lechner <dlechner@baylibre.com>,
        Lars-Peter Clausen
	<lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "Sa,
 Nuno" <Nuno.Sa@analog.com>, Jonathan Cameron <jic23@kernel.org>,
        Andy
 Shevchenko <andy@kernel.org>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] iio: adc: ad4695: Fix call ordering in offload buffer
 postenable
Thread-Topic: [PATCH] iio: adc: ad4695: Fix call ordering in offload buffer
 postenable
Thread-Index: AQHcwEn8Qxc6HLDZw0mwofc8cAcz8rXIrTQAgAAzopA=
Date: Tue, 31 Mar 2026 17:10:22 +0000
Message-ID:
 <LV9PR03MB8414524034227C408FAE21ABF753A@LV9PR03MB8414.namprd03.prod.outlook.com>
References: <20260330-ad4696-fix-v1-1-e841e96451b2@analog.com>
 <cbd9f136-d10f-4a64-b155-2beb7f1aaefe@baylibre.com>
In-Reply-To: <cbd9f136-d10f-4a64-b155-2beb7f1aaefe@baylibre.com>
Accept-Language: en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV9PR03MB8414:EE_|CH4PR03MB7747:EE_
x-ms-office365-filtering-correlation-id: b3f7032a-55ed-4880-2d18-08de8f4864e7
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|1800799024|376014|366016|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info:
 e4MfFlamjDewvnwv/k2B+2nb41XckMAFiKcoOSCFva8XJzzIhaUwXBHRDlFopRI/aTqi3tPA0EJMzb4owJQi7+jpuyUSpV4WUraclXRoRfpGkuyIL4o1388gfh/8ElkyRP6kFpAGvo1oleOvPbRu6TwbCtATidGamgSPpzFdFJ6AkD8tw1MxsRlncacpqRULfoDgTOm0Vty+FdyuYKcldTVEuzXA59VnJpR95wqzA4Z41ZGqwAUcPAOXyDut1mDGbBnv3SdBAOTfFXe/8ueikO/D5aObwEd3MVtxavFyJ9d5PmYPQ0q1wW1OBpeUCDZAb3fs8SSTzrz0QzjR+5LRRxDd6ijWW/ri2wAd9buodW3SXQCzu3QVHo6YgaheaYv7kmrTqG3F4kOj6sX2dbRDCMdbA2q33aGPXFv5kleVsbS736TxC1N1wNR6DVs+ZEc1+YkNYkC88r0Q0RDIPU+K8PAKb9CKQQzO9DBnBLLb839+zlU7pSFTm+sR7q7+NbSaG5aHzOknpKRcxdAtGtQNutnBbwsteY5VogSVLlNQ7aVz7AO17y6wpno/tzFMkYZB70ngnGtrDVip2Jzx/FYbnjXvzl/oE5zCYkAHJLjq0H0hfuRoxgxG0X3oWDYGv5jmlSRtr9j+3XUfN3hFCJMMWK0B57F0Uwllbguoj9Hn/uHNMDnAFenaIOUjIsPxT/0dTR6CR+oZEJd1UtGlxDPmsf+4sImnl7Xi/56I/XgHr/JU92Vxsfqx20+nVfMQ4Wo+iiUHeuavFdRHo75icW5DXmmufmy/b9LdWAa3mU3rFG8=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV9PR03MB8414.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(376014)(366016)(38070700021)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SVRXa05rSTdXTW5rTDBWb0RsT3FCaXZ4UjArbm1LT1VRSi9jeXoxNVpubHp3?=
 =?utf-8?B?RG5WWlhmVTV6VWdPSUNMYUptclJEd0lacGN6aHg1OE5WcGwveFBrNXJxMmwy?=
 =?utf-8?B?dm9SK2hGc3VFR0FtZ3dnVk1vRlVBVVYrTG9TYy8yR0xUZWI3R1ZuTVF4S1Jj?=
 =?utf-8?B?WGhBcUNaWkVXU0I3b3ppZWo4NEtRSFhCclBLTi9ycFNjb28yY3I2L1Q1T3hU?=
 =?utf-8?B?bmtWS3NzM21XUkp3REM3Y1BRQ1M4dUdiNVpJNFNIV3pMZzhiSEM2TW90Z3Iz?=
 =?utf-8?B?cXNCeVZBWW4rMGx0S0J0dWNUbWNINTlUZDd2R29sZDFPQ0V1OFlrbmhJQW1S?=
 =?utf-8?B?cE9KVytiTU91RUcwbHgyaFBOZC96eWtPYVM3bHljM2NGaW5FL01MTXlMd3Rz?=
 =?utf-8?B?cEkyOEo3Q0VGd3g0eXF5TFNESG90K2JaVk1yc0diam5WSlVzYnV6M1dNOXVH?=
 =?utf-8?B?dCtaeTYraG5UcWtQZ0xwMTZKdUNnMUl4bGFFaG5xcUVOQmtsR0tpQkRacnBY?=
 =?utf-8?B?blV3TW53Vk84NXJnTkwyYmpPN0w4N2JDaEhSaE4xQ2NxOWZSdGpwU0ZmWWVw?=
 =?utf-8?B?TmVteUtWU3QyV0IxcTFqUmRiOS9XMGZnT2U0Z0dhZmdXOXpYWTF4eWhhQWFt?=
 =?utf-8?B?b3dSSGhoczVFL001dHBYMTJFUTR3VFNPNW9BQk1PR1FOU2pyeU9aRERadmdz?=
 =?utf-8?B?NVdIZzU4RHVsM241N2JHdDRoUHlCNDgzRGZrNHVRY2Y2UU5xczA4eW1ESWNE?=
 =?utf-8?B?QXVpcFpCbnZKbHpOemc0cmJGOE9OQWFIQUNNWU1kVjY1SGxEdm0vZ1V3ZFg3?=
 =?utf-8?B?alFsYjRnRjdCdDVHYUpxTGpzOTBEOUZyRkRCWUJKd1F1Z3FiODBZTmNjblJG?=
 =?utf-8?B?bElnZ3dVd3VhUlhTTVNPRkx0T3d1RVJhakppNGZ6RDBBN3ZCV2xvMFVhdFdq?=
 =?utf-8?B?R3pCVS8yMHlVMWs1TUpDT1EvMjJIV1p5Vm1makQ5MUlsbVNRdkJYb09VNXN5?=
 =?utf-8?B?MDBobUtXVmhiSkplMVNhMjA2bE5GdExjVGdVMGdYOWp3ZWE0Vi9wUUxBUXNK?=
 =?utf-8?B?cDhQTGNDdFBmbFRSekl6LzF2VFVrYUIvd1dGdCtNNlJnRytEMU1DRjBuTEVi?=
 =?utf-8?B?N1JQOGlYYXlhVitKY0Z1YnJncmd4TE9SQ1I4UzhRTzlRNXQwS1l1a3k5d3Fk?=
 =?utf-8?B?NXVnRDNyVUpIbE9mOFhyTjBRdWpHWldpRnFGTEhSUENQMG0xeVlGajZ1TENK?=
 =?utf-8?B?UExrN1VNaCs4WjF2dCsxRkZjYzk4T1FMb3pOaDB5L3VCUXhuK3ZEbW4xL2hz?=
 =?utf-8?B?RTQxR0U2bjlDTXZnL2ZnUjFpY2xwNmo0eTFtY3ZjVjZrTDI1RmdQVklSR2Qr?=
 =?utf-8?B?NFRpK1FnVFVWTmlxOVZ1MUZEQkxYWU9tYmc2WktYUTZrN0R4eTZYUEU2NU13?=
 =?utf-8?B?d3NNR0tpSkR5TW5vY2JPNHdjT1daNER5SldpMjgydWZqY1FKeXJZUTJkMGV0?=
 =?utf-8?B?Z212QnJrTXBJOGg5VG1haUVNOEFJQWRXQlgvbDl3Zzk1cFN3cmhJZTJOZ1F3?=
 =?utf-8?B?OTNwNWpDYi9EaUhtYlJXdjM0QXVSQVRzc3FYTDBya1MvOGpvVlRZeC9Rb2hH?=
 =?utf-8?B?Z3kyeGE2d2xjVzVzU0krbVk3TGpQRWJ1VmdYdUVwVEViQ2V1T3N2Q3VlSE5m?=
 =?utf-8?B?WHRlN2JUd213S3Rhd0VqdWRoS2MrSzEwTEY2Sk1FK3dHcFRlTE15SUJNcUU5?=
 =?utf-8?B?Z0sxamRjYnI3a2tXaHhRS0ZVNHVCRTNBK0dXWVpoTnV0cGlQMHhHN1R1Y2pQ?=
 =?utf-8?B?eXpWVlJySXIwREt1ZHBhQ2JkcUZjTStlTktRRU1POTNrUEpVMzJVRE1YekQv?=
 =?utf-8?B?K21IOFZGVUtsWmozdWhqZUNIN3VYR0d1bEpMeiszMVhHaG5Jc3VGSktnSm4y?=
 =?utf-8?B?NWRRVDNRdGpDV1BBYW90Y0E4S1greXcxVGJKT28ydUpkdjBLbnNEWHh5bTVt?=
 =?utf-8?B?MXdZZk95SnBxWU41VnB0UWZtWGFDSVBrWk54UVRVSWVVTDFiMHMvVXZWTjhD?=
 =?utf-8?B?Uk5OMkhGWXhlbDUvZlJKMXFVbU84TkFwZ0g3cTFZeWtJcnhtU2VmOXE5VWlm?=
 =?utf-8?B?bkJEM0ZRNXdvZU53b1gxNmZNSVVOOW14bmp4dmZJRmkxbFBudVQwTUM4T2Qw?=
 =?utf-8?B?VHlBZkVPNkF5Rzd2TGlBa0JBTGV3a2QyakJDSXF1ZFFoeWtiZitralpTV3Ey?=
 =?utf-8?B?RjZ4MFl0VHd1SjdaOUhtb2Qwc0YxbkVvWGRpTGF6YmNoZlI3SFBzT1dLSmg3?=
 =?utf-8?B?dUFBbUd4Uk5LT3VMbVM5NXJraTEzNno3N3NIS2pGaGFDNTBrbUxDbHJDWnBI?=
 =?utf-8?Q?wpltaul6laZbbuxpz6Oxg299v0QAarwo8t0Yr62Kvx30R?=
x-ms-exchange-antispam-messagedata-1: 9cuTOGs8kMqmmQ==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	u/Bw6rOPzH6WTHEJlhRe31/zTggS7hfsSxeDllGzXEXZPY2D0tbHv3ra2ztXigOGwpCKINPtOxd8+XVjweGYIK+iTq8aYMIO7vu7Fkhx5tmGvH97BToAcqWG/ZrxBVSZHxyesqWO3KI0pUqJ2NafQoLti/CXSWK3kwEZx2pmfeqNb33tBgBHXU67LRjNiqONwnUPQp1iJsbSSvZVwoD20W2y1SWbtL/uPXAdUvfyBGA5IKk7iuxPvj/3XPGflzViXxSmXx0L8xDiY/PovlgHF9jqny4b8wZ0T0ChmxJsjAv8WqqDafrYRH6J+gRN9gng9jCbSdUxmC4ywon04/Csow==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV9PR03MB8414.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3f7032a-55ed-4880-2d18-08de8f4864e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2026 17:10:22.6323
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DDBaiiPZ++CSsiYpoXeL/OeNmyBG9WSpJZNCcFF9x+XPsFDbs2Vn6gCL0GJOt+uJRGyeDb32br1ztlMHKG4cRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR03MB7747
X-Proofpoint-GUID: 2sAUDSD39-8BLv_JhGyftrGAJHjEuZ9j
X-Proofpoint-ORIG-GUID: 2sAUDSD39-8BLv_JhGyftrGAJHjEuZ9j
X-Authority-Analysis: v=2.4 cv=Jur8bc4C c=1 sm=1 tr=0 ts=69cc0006 cx=c_pps
 a=onUmW/TBZy4T/WhMO3N4DQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=ugNRTJOwpmtT476g4l8T:22 a=IpJZQVW2AAAA:8 a=9gNKKvX3TdaREW8P3kUA:9
 a=QEXdDO2ut3YA:10 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMxMDE2NCBTYWx0ZWRfX4cxcSblLrXPJ
 nY6Nfr0cWr4Xuy61vNRcdSAkdhRZBwQ09ans0dLBepk3T+MLLXGQmRvsze7GwE3/pnQ65aCbnXV
 orbkTVePVOoMW6x2jNsFTscgef6h/ApYKx8bu1sP0pEPsteU0el8sQU/jGSBmHZyhe02W0aKrAH
 CAZgRDRy2FHXzQmdxn7RYJZ1WH7+4re1GyWwbkgHdKIdP27KcZFR9zC3hbMyDcNjhfXIe98iRa2
 qGn8Ws1rlR+icchjkJntSnkI/4EGSsG0yXxavLFZD10BO4fgEDIwrWb7meAVsxMwr0QbVWcvEwq
 pEKqomTQc8lrdYgzR6FIYVqgQIEqwQyhg+wgURSHyS0jinO+FeraZNPAPoZHvGzKzq3CvQiIDMT
 9ysa7gv1RfYnzTJQmG1PU1wO8/v0XkpHNxizaB2dBgt1O8qtHuxV8EKgl7wOhykJp9xz0JjwpmW
 37QeXaa4LMAq+ukWg5A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-31_03,2026-03-31_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 phishscore=0
 suspectscore=0 spamscore=0 adultscore=0 impostorscore=0 bulkscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603310164

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRGF2aWQgTGVjaG5lciA8
ZGxlY2huZXJAYmF5bGlicmUuY29tPg0KPiBTZW50OiBUdWVzZGF5LCBNYXJjaCAzMSwgMjAyNiA1
OjAyIFBNDQoNCi4uLg0KDQo+ID4NCj4gPiAgCS8qDQo+ID4gLQkgKiBOQjogdGVjaG5pY2FsbHks
IHRoaXMgaXMgcGFydCB0aGUgU1BJIG9mZmxvYWQgdHJpZ2dlciBlbmFibGUsIGJ1dCBpdA0KPiA+
IC0JICogZG9lc24ndCB3b3JrIHRvIGNhbGwgaXQgZnJvbSB0aGUgb2ZmbG9hZCB0cmlnZ2VyIGVu
YWJsZSBjYWxsYmFjaw0KPiA+IC0JICogYmVjYXVzZSBpdCByZXF1aXJlcyBhY2Nlc3NpbmcgdGhl
IFNQSSBidXMuIENhbGxpbmcgaXQgZnJvbSB0aGUNCj4gPiAtCSAqIHRyaWdnZXIgZW5hYmxlIGNh
bGxiYWNrIGNvdWxkIGNhdXNlIGEgZGVhZGxvY2suDQo+ID4gKwkgKiBOQjogdGhlc2UgYXJlIHRl
Y2huaWNhbGx5IHBhcnQgb2YgdGhlIFNQSSBvZmZsb2FkIHRyaWdnZXIgZW5hYmxlLCBidXQNCj4g
PiArCSAqIHRoZXkgY2FuJ3QgYmUgY2FsbGVkIGZyb20gdGhlIG9mZmxvYWQgdHJpZ2dlciBlbmFi
bGUgY2FsbGJhY2sgYmVjYXVzZQ0KPiA+ICsJICogdGhleSByZXF1aXJlIGFjY2Vzc2luZyB0aGUg
U1BJIGJ1cy4gQ2FsbGluZyB0aGVtIGZyb20gdGhlIHRyaWdnZXINCj4gPiArCSAqIGVuYWJsZSBj
YWxsYmFjayBjb3VsZCBjYXVzZSBhIGRlYWRsb2NrLg0KPiANCj4gSSBkaWRuJ3Qgc2VlIGEgZXhw
bGFuYXRpb24gZm9yIGNoYW5naW5nIHRoZSBjb21tZW50IGhlcmUuIEkgdGhpbmsgInRoaXMiIGlz
DQo+IHN0aWxsIGNvcnJlY3QgaW5zdGVhZCBvZiAidGhlc2UiIGJlY2F1c2Ugb25seSB0aGUgQlVT
WSBwaW4gaXMgdGhlIHRyaWdnZXIsDQo+IHNvIG9ubHkgdGhlIG9uZSByZWdtYXBfc2V0X2JpdHMo
KSBiZWxvdyB3b3VsZCBiZSBpbiB0aGUgdHJpZ2dlciBjYWxsYmFjaw0KPiBpZiBpdCB3YXMgcG9z
c2libGUuDQoNCkkgd2FzIHRoaW5raW5nIHRoaXMgY29tbWVudCBjb3VsZCBiZSBsZWZ0IHVudG91
Y2hlZCBhcyB3ZWxsLCBidXQgY291bGRuJ3QNCmRlY2lkZSBvbiB3aGV0aGVyIHRvIG1vZGlmeSBp
dCBvciBub3QgYW5kIHRob3VnaHQgaXMgYmV0dGVyIHRvIHdhaXQgZm9yIGENCnNlY29uZCBvcGlu
aW9uIG9uIGl0LiBUaGFua3MgZm9yIGNsYXJpZnlpbmcgdGhpcyENCg0KPiANCj4gSWYgd2Ugd2Fu
dCB0byBpbXByb3ZlIHRoZSBjb21tZW50IHRvIG1ha2UgaXQgbW9yZSBjbGVhciwgSSB3b3VsZCBz
YXZlIHRoYXQNCj4gZm9yIGEgc2VwYXJhdGUgcGF0Y2ggYW5kIHNwZWNpZmljYWxseSBtZW50aW9u
IHRoZSBCVVNZIG91dHB1dC4NCj4gDQo+ID4gIAkgKi8NCj4gPiAgCXJldCA9IHJlZ21hcF9zZXRf
Yml0cyhzdC0+cmVnbWFwLCBBRDQ2OTVfUkVHX0dQX01PREUsDQo+ID4gIAkJCSAgICAgIEFENDY5
NV9SRUdfR1BfTU9ERV9CVVNZX0dQX0VOKTsNCj4gPiAgCWlmIChyZXQpDQo+ID4gIAkJZ290byBl
cnJfdW5vcHRpbWl6ZV9tZXNzYWdlOw0KDQouLi4NCg0KPiA+DQo+ID4gLWVycl9vZmZsb2FkX2V4
aXRfY29udmVyc2lvbl9tb2RlOg0KPiA+ICtlcnJfdHJpZ2dlcl9kaXNhYmxlOg0KPiA+ICAJLyoN
Cj4gPiAtCSAqIFdlIGhhdmUgdG8gdW53aW5kIGluIGEgZGlmZmVyZW50IG9yZGVyIHRvIGF2b2lk
IHRyaWdnZXJpbmcgb2ZmbG9hZC4NCj4gPiAtCSAqIGFkNDY5NV9leGl0X2NvbnZlcnNpb25fbW9k
ZSgpIHRyaWdnZXJzIGEgY29udmVyc2lvbiwgc28gaXQgaGFzIHRvDQo+IGJlDQo+ID4gLQkgKiBk
b25lIGFmdGVyIHNwaV9vZmZsb2FkX3RyaWdnZXJfZGlzYWJsZSgpLg0KPiA+ICsJICogYWQ0Njk1
X2V4aXRfY29udmVyc2lvbl9tb2RlKCkgdHJpZ2dlcnMgYSBjb252ZXJzaW9uLCBzbyB0aGUNCj4g
b2ZmbG9hZA0KPiA+ICsJICogbXVzdCBiZSBkaXNhYmxlZCBmaXJzdCB0byBhdm9pZCBjYXB0dXJp
bmcgYSBzcHVyaW91cyBzYW1wbGUuDQo+IA0KPiBTaW5jZSB0aGlzIGJlY29tZXMgdGhlIG5hdHVy
YWwgdW53aW5kaW5nIG9yZGVyLCBJIGRvbid0IHRoaW5rIHdlIG5lZWQNCj4gdGhlIGNvbW1lbnQg
YXQgYWxsIGFueSBtb3JlLg0KPiANCj4gVGhlcmUgaXMgc3RpbGwgYSBzaW1pbGFyIGNvbW1lbnQg
aW4gYWQ0Njk1X29mZmxvYWRfYnVmZmVyX3ByZWRpc2FibGUoKQ0KPiBzbyB3ZSBhcmVuJ3QgbG9z
aW5nIHRoaXMgaW5mb3JtYXRpb24gaWYgd2UgcmVtb3ZlIGl0IGhlcmUuDQo+IA0KDQpZZXAsIEkg
YWdyZWUgb24gdGhpcywgdG9vLiBUaGUgY29tbWVudCBpbiBwb3N0ZW5hYmxlIGNvdWxkIGJlIHJl
bW92ZWQuDQoNCg==
