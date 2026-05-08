Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C47FA1EB1AA;
	Fri,  8 May 2026 12:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778244433; cv=fail; b=SqC2ImxLgzotVUKaYkqFOiotxBo8qHz2wVqnIZW4r0EZBsKsG2OEjMmamNXWn/dk6/g+9PiaAIw/RsPs4jJh3ZQcLSc15iHrw/BC33XzaX/xCa1zfkdahHvHYDnshZtiRbQB456nBcmWE5i6hc+isCj0RyIfquCWN1Y8lj+4t6U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778244433; c=relaxed/simple;
	bh=ikP385GPIsw/Mkz4LmHX79l5c+YRzUTfD0Oq5D+lHLM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IJ6tciBZpPRFNaO52hw/JtOCi0KedUK/sFP+Amfcqxi2Ua1jK2nYTRk9P8/el7bWZinWCXBtGoig94qz2wOHaYoaa0at9ojn4UK9EyXD3Lx/8B2127+OZe9OhREu5gkZOMGdLWgVQH60hmXaggRwKKg91Mm8Hvh5rz1eFRppvu4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=gNnLs+Zz; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="gNnLs+Zz"
Received: from pps.filterd (m0516786.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6488eBZq1044589;
	Fri, 8 May 2026 08:46:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=ikP38
	5GPIsw/Mkz4LmHX79l5c+YRzUTfD0Oq5D+lHLM=; b=gNnLs+ZzMYMP80e01Glga
	UTnDuwot1d7xkYQ2EpJWeCMLhtQ8ElxCUoLbXxgUe9I+62Qhx0i9LYSARijhpbcq
	dQ7FYy8AXGU0QIbcZn13BQkpRZje4yOFB/k8Mz+1xAFV1qhkiH41pkzVtpCAWzbf
	cPbOE4dlUgKUD1AXYhnEWkW551g6f45BZ73XQnWv33kIkw8RtqHOHpspbV6K7RnQ
	xzGZqcJZK6yYoFIR9i2ztxVepeF+0TYktjgamas2mxcn9rMXee9SLSacm74oh8NB
	FwND4Cijxfti5gm1bsCZYCc++cHag14/BNR0PPnkNFgAjs8Qnvt9//TeaSZq8Hvn
	Q==
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010033.outbound.protection.outlook.com [52.101.56.33])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4e122ajx5b-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 08 May 2026 08:46:55 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TQGIX5DHslIoDmdvrzFwtG9jFz7zrRCInDWdCC4m0XrvmLJiOhs0O8W9ZzR8aFj6WI+G6gsjz/ve133fwaRpEUl7E31tZ8Q4dSDHgGO8Z7VPVBddtW8jacjAcp6K++OR1MlxvIV+HxUyKFGgUvJ01kAaj3WcHvzvVIwhtMq10sXYfUcbNmfTnMdMrQ00vd9Yc4jScriA1+n17AyvvD2fDKo/439uyyXh8GhxZH+qFAjYJjtSJjTo5oE0WbtmHHe3iHCNali0wow5m8a1bLiIZhxa4Zch9b9esQMrb0j8Z9aWEu7ofRdRIE6j1n6gbzlTsKgZrB9FbLxsrQXD2BAiXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ikP385GPIsw/Mkz4LmHX79l5c+YRzUTfD0Oq5D+lHLM=;
 b=n/Z+lBxmkyAR60sgZk/O0YEEYRhfNLp8V8xWGMiSTWFa9RtGue2mpQNe3PAq5sbJ3hXHlr0zTDONnS/Seb+bzL6MwFffYfQhOmLA22b/P6HhoNxWdYIbtadfZrCqpKjq9CbGMRypnkSZYKpL9ngLBTo6nKUMKzL7U+BN9V++4i+OiaQEdT+Oe6LBNd+BgbfPSV6z5HmayXeExVpGYeY75nynsUpfte7CShJSdZN9uYk5gL9xjeKyMYfEo8g8xPQvU4PwaJizRrXr5HbUXFVKeUaVs/cJh53PN3qj1JSF9fxtP0dX6Gwj532O5QxlqBUgEPbt8cRMYpJkMiGaMWdxaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from SA5PR03MB8377.namprd03.prod.outlook.com (2603:10b6:806:47d::22)
 by SJ0PR03MB5805.namprd03.prod.outlook.com (2603:10b6:a03:2df::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.19; Fri, 8 May
 2026 12:46:51 +0000
Received: from SA5PR03MB8377.namprd03.prod.outlook.com
 ([fe80::9276:9909:1b4c:8438]) by SA5PR03MB8377.namprd03.prod.outlook.com
 ([fe80::9276:9909:1b4c:8438%6]) with mapi id 15.20.9891.008; Fri, 8 May 2026
 12:46:50 +0000
From: "Stan, Liviu" <Liviu.Stan@analog.com>
To: Jonathan Cameron <jic23@kernel.org>,
        =?utf-8?B?TnVubyBTw6E=?=
	<noname.nuno@gmail.com>
CC: Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael"
	<Michael.Hennerich@analog.com>,
        "Sa, Nuno" <Nuno.Sa@analog.com>,
        David
 Lechner <dlechner@baylibre.com>,
        Andy Shevchenko <andy@kernel.org>, Rob
 Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor
 Dooley <conor+dt@kernel.org>,
        "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/2] iio: temperature: ltc2983: Add support for ADT7604
Thread-Topic: [PATCH 2/2] iio: temperature: ltc2983: Add support for ADT7604
Thread-Index: AQHc1kn/5d/Hh1H9DE+/jMXiSvhLvbX0U6uAgA5CZsCAAVTVgIAAIEGAgAAYMKA=
Date: Fri, 8 May 2026 12:46:50 +0000
Message-ID:
 <SA5PR03MB83778AB3C41E0AF56EC754F8F63D2@SA5PR03MB8377.namprd03.prod.outlook.com>
References: <20260427132526.272716-1-liviu.stan@analog.com>
	<20260427132526.272716-3-liviu.stan@analog.com>	<afCVtXBHIIoLlsRo@nsa>
	<SA5PR03MB83772D8F6A3CC39094DE5241F63C2@SA5PR03MB8377.namprd03.prod.outlook.com>
	<af2no3bJA9MSjXvV@nsa> <20260508121441.39ad9f65@jic23-huawei>
In-Reply-To: <20260508121441.39ad9f65@jic23-huawei>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA5PR03MB8377:EE_|SJ0PR03MB5805:EE_
x-ms-office365-filtering-correlation-id: 9f9487ce-a196-40b7-0c72-08deacffe001
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|7416014|1800799024|3023799003|56012099003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info:
 KCVm99hDy8AIOTTVreZRC3H8kz5TG1MOIN+G6meNU8MQXQsTAFUfufKV8CML3TKMzuMupLv+upOFZUhyy2QAZ3dJ7JmJcuKOfUgqBcwZdqpwRbFXxXzQY/GRkqyQchLJCwqqkfcbFEm1pQT8HLvQrqGijueAe94+D+gOXTFtdRAkWbibkxgsnXQIBUnr9yz4lJuZV0sgFRr4k08fsi31PBDSHR3rNjmRypQJngLEgW0HpawqlbXRsgORRjAplEFEb6A3ymnaIMwmgmvVz2A6XjGrsY48XJfbkn5UTq7TcEpk16m4YK39sAZm2hA5/P5Fw82AAWOlIK8r69PMOZVgaCzEzdZ3jKpN7F73RU4c6pt5Wf8cEFc82VWEZNyiExd7CXoI5rIYlFdP2DzeCRJVP78dYtB65IkvrFAaATxprkrWSo1PtmmGy/oSRwBWNHW5EzudFcFstbSMrGE6CE9OC35HFuOQww4MPfonmRJAch7yUTRrsJ2xVXb1gZU5eo/I8bhD9Ol9fTO3cWfj1ToPyJXn5ZByXLSN8/iLmPPUQMdNoiRfy1hDouPJOSwfPytxB4mxCd3JOVRlyAiV+Frr4SX7cmYTH4yCEj1FAGLGZCijYo+LSg9No/OvwZtMAJDIcfVQ109Er+mfmYGFL06utPMD8zi1oAmguXsWnE4rU7tE2f3nRy2Mr1dpFnvDCJfGVkpr7mDqZddSyrcyqHZH7iAjgcoBd1XrwB9UnJPx2bLbJR83Fq+WkGte41kRxbQf
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA5PR03MB8377.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(3023799003)(56012099003)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UEJMOStmcEx5d3VUWUc4UE9kNEs1U0RxV2pQQnVsMndxTkpnandTOXk5Q2JZ?=
 =?utf-8?B?SkE2MFp3ODZLTitTWlhsdm4yZ0h0bWliTENNOE05eFBVamw5Ly83WWR0dWM4?=
 =?utf-8?B?bnJsd1B6OTNPbGY3cU1BckZuemFXU01MTWVYeE9NRFZtRUZ1bnpQVitYeHo2?=
 =?utf-8?B?Z0RaMnRWWnlvMXJQRlUzeFc2UGJjZUZHQmd4ak1VVEF0dVBnaUg4OTRGdzNi?=
 =?utf-8?B?dFRyZzM0VlBwN0VWREovVTh1WXFzc2psaVdBN1U1Sk4rZUlJNzlJdWFhNCt2?=
 =?utf-8?B?NUlDcWw3c2JDSWR5YktZY09ZVmdiQ1FqcGZpaW85UDN0U2lHTVNnbGFvWkl0?=
 =?utf-8?B?QjlaTFplRGFheFl5NmQ4OXlUYklXbW5OdUhsQjhkb0ZvOUpJUlJhUlJydU1x?=
 =?utf-8?B?dkdrNDgxdzZoWTV3L0JveXB0andOQmNmNVAxUXR0ekRWS3ZGeGIyQlkzOHpW?=
 =?utf-8?B?MHptS1BYblFYYTJna3hDT2JDak9KSm4ydGJXZlYydVkva1lNZE9XZ2dlemJC?=
 =?utf-8?B?a1hYV0huNkxnY2ZnYUpjSjJOUDJVN0tvdmJFTEZac3pTVU0xdGFvZG94Vlpk?=
 =?utf-8?B?RHdXMkttMmtubmRxOEI2a0dOZnd6MXpNVFdNSFN0ZGk2TFJZazlWajFlK3pz?=
 =?utf-8?B?UHJDTTUwOTNRVnkxbFRrSFVGbnBYUldMWHN2emdwMmN5V3RVV1I4eGYyS2Qz?=
 =?utf-8?B?VFFvS1l5TCsvNjVTaEIvQ1FXUGVhcVJTUHVwS3hBQ0dZVTlmOHd1a1Ayc0E1?=
 =?utf-8?B?Um5WZmV1cHRub3pObDJPMVhWeGxkWlA2dnNiR1Q0NDVFQ1lmVFVIeEtoK1FP?=
 =?utf-8?B?QnFyZmgvQXMvaVNDd3NNMWFrcWs2T21aNVhtcDd4blNMN0F0dDZCVzVEWHVz?=
 =?utf-8?B?SUZhT1JzYmliWGEweTJ4TWJUOVNKeHgxSVBmN243OGtmWDZoUjZ0V3VxMjZy?=
 =?utf-8?B?VXRPbSthNm1zVjVKb25HSVFwaW04aVJyWUhMWTFKL1BNRHllcHF1R2hWbmRM?=
 =?utf-8?B?bjhHZ0ZES2ErUG5GN0l4QVl0RmU5QTNTeDZvUmF2YWF5bDh4eFFsNC92YStQ?=
 =?utf-8?B?WjM0NzZvR1oyb3Zjd1hCa2Z5enNZVzJLTFA0TnZ2aFNIdW95dHpLeUtqaWhR?=
 =?utf-8?B?eXVkTnlaVmxiZFNyclFsbE1HSHM0YTNHVFZTQ0NkZmJiT25DOWdWVmw3dkRp?=
 =?utf-8?B?cXEzNWJuUi9iTmw2VkZGKzliUVhPSEZYWWR2SmRkU0dpbWRzYVJrVXZYMVA1?=
 =?utf-8?B?V2dXSU4vWUw1RkREcmhobCtsN3N6dzBRZU90MHhBMkNuR1p0NFd5WDRlLzJR?=
 =?utf-8?B?SGhlRk1rRE9QZnM3UW05WVVLRUJiTWRGSEYxajh5WlhSVGhzTVUvVFZPdG13?=
 =?utf-8?B?NEEvTzJFcGQyTVB0UlptM09OVTk3d0thWkVLTWtLZGFHejgwbWlPNVhuMnkz?=
 =?utf-8?B?azFYQmlRUVVHb0U4SkFtNEhOVkwxM2JNeWNpMUtzLy9QVHpacXZEWnY0QVlx?=
 =?utf-8?B?enNicDlrVy9hSEtNbFpWTTdPeFIwR3I3bDBKbWZVUFMwME5ObjVJT2ZMQVdR?=
 =?utf-8?B?TjFZVldKcGg4WUZ6ZmxwdENuV3ZLVEJNUWgzY0RodGdqQ0tyRjFHSHM3K1hv?=
 =?utf-8?B?dEFlUm5zRUVFKzEzK000YlVUY2I1ZzVTSUs0bmlwSjJyaXQxNkhVbmN6Yk5a?=
 =?utf-8?B?b1B5Q2c2YzRPMDh4aGY4QkdBckxOWW5aU0VCanVpSDd4dnNYaW1KZGVGSWt0?=
 =?utf-8?B?VnZPeFY1SkRRMmNJSzJFRHBnNmFFWFIwNTd5c1poRFdEcW5SOURJRDZYNUVS?=
 =?utf-8?B?YVR2OGVFck44TEg3YVJxWm5ycHl1dmNYN3lFdXVPK25vcUtCMk5XbUxXQTJx?=
 =?utf-8?B?STljYWF3djhKRWtVMFF1ekFKNVBFeHVmRHhnYVRqQWZKdE1pYjUrU2JIczFq?=
 =?utf-8?B?UVF6dnR3eGNjRlNLdVRsN3ErTXhXVlh4SGl0MFVZSDhlc3dXRkFWZnpCWFo4?=
 =?utf-8?B?MUdHZ1psbjJOZm96akhrbkxsa0JMbFF0OVpWdmMzK2hmckwxMXJrZUJTVHh3?=
 =?utf-8?B?K3kxT3ptQ09aclk4YXc2ZU84ZWJPV2FoOUEzTEZjVU9DMXB0cjZSYVRGV09Q?=
 =?utf-8?B?TGVHeTZuUWRFV1FQcnYvWHg2b2k2YmxkK2taVWgyUHU3RkxKeTVQL2VKVGhI?=
 =?utf-8?B?d2k4WklyaGlPbmIvWmErMHRMUEJha2VOYVBlMGtQUTdYQUtSUmthaWJDYzdt?=
 =?utf-8?B?K1VqU0tEam5sRFBmWlF0cyt5TmhpMG5QemFrMmQyQzlRT1Q1UVoxOFgwdE10?=
 =?utf-8?B?VHgrelI4YjZmTkVlR091YklBU3JWcWs0MFpBaE5pTVNsSjRXaTV2Zz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	FoTRU+9KOYhIsqMVoWz6AO+yBRAfqFaHCfzmSB4qd1Pu3N8UEAuxv4r7SXlwl+u7fKL8hyi3DIYa5QSxv02XfyA8VvEYqioA7eiYErJteXe3kkvA/m8kAObipT2fGZaT2KvMChNiwog7zkY9QjcS/3FK64gHGgdx/in7AnjfeTdUQ5w4FDcYHR2nduh6312meVOjsXz134WFadS2vkWzpdBnvARJdrYTRgEUtAuJBGXwX5HeeIjld9FgcemCGMQnSqdKhj1rvPYjgtOQRWAjysUIZRY84kjwt96ZXBjwfbrot1Lc+U8mBybcxV0Z0vgo00HRwuC5JcrRrPqG9VmJuA==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA5PR03MB8377.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f9487ce-a196-40b7-0c72-08deacffe001
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2026 12:46:50.4264
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gZJ034z9tdC/Pz9zSRLBCiWgpKjPOQGZ/z5XOu52sNSeetYDomF5+f+x3z88diKRsyRmO5JtuYqqarFETnS6Jw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB5805
X-Authority-Analysis: v=2.4 cv=demwG3Xe c=1 sm=1 tr=0 ts=69fddb3f cx=c_pps
 a=3IxC/HLiWPPRhiYFHlIRMw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=ZQxX5BWu6Z8IJBb2zLX7:22 a=GxRgrcBMVBoNmmuTR8wA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA4MDEzMiBTYWx0ZWRfX/NSbKRftUJzl
 1EqeMFivQIyvSVB4FnZTBWhZ+bpBI6J6tN0Q1QQg3bWgUaEYZB48BoInBbNu+DY4I5oTj2sUEx7
 sIj5J/C5Ypi2o2JNMMEZsErrtpYNU7JnesxQujcFYkrisV0kWEBiroMclyRVqQhpi1mM+/b4ZNf
 83kdSf7F0KCbwv5RHtaUXJQdWQza34XR3M8tbNZwNnL9yA3V3Gzoox0TgJXWZ32DigwkFj+mYfS
 Y/PJz6x2bH48JwBazbN3cWR3O+T2cKfHLLVu9qVGtoyqsDUfH5SjvvYZwverbd3AByX8RPP9cby
 j8Pj7RagXeq2Ylk8dXNlfdpwFHhQ4T4/G0aCFlM78PFXgIV1b/nc28v7FLHhIId2fUxDBwFl6nJ
 UC/hR1EO520AE+cPRURciyX7aLCgwiVzB190kDOA79/hUmaBs6vFa3kltYpJltEkrLxYBNdsT84
 u9LOWTCKAM+FxkbbaAA==
X-Proofpoint-GUID: OrFz4zHM9zD4ZVQ9g1lYufythIwoJvHw
X-Proofpoint-ORIG-GUID: OrFz4zHM9zD4ZVQ9g1lYufythIwoJvHw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_02,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015
 bulkscore=0 suspectscore=0 phishscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605080132

T24gRnJpLCA4IE1heSAyMDI2IEpvbmF0aGFuIENhbWVyb24gd3JvdGU6DQo+ID4gPiBBcyBmb3Ig
dGhlIElJT19URU1QIHF1ZXN0aW9uLCB0aGUgY2hpcCdzIGN1c3RvbSBzZW5zb3IgdGFibGUgc3Rv
cmVzDQo+ID4gPiB0ZW1wZXJhdHVyZSBpbiBLZWx2aW4gKHNhbWUgYXMgdGhlIExUQzI5ODQgY3Vz
dG9tIFJURCB0YWJsZSkuIEZvciB0aGUNCj4gPiA+IGxlYWsgZGV0ZWN0b3IsIGNvdmVyYWdlIGRh
dGEgaXMgZW5jb2RlZCBhcyAoUCArIDI3My4xNSkgSywgc28gd2hlbiB0aGUNCj4gPiA+IGNoaXAg
Y29udmVydHMgS2VsdmluIHRvIENlbHNpdXMgb24gb3V0cHV0LCBhZnRlciB0aGUgZHJpdmVyIGFw
cGxpZXMgdGhlDQo+ID4gPiAxMDAwLzEwMjQgc2NhbGUsIHRoZSBJSU8gb3V0cHV0IGlzIFAgKiAx
MDAwIG1pbGxpZGVncmVlcyBDIC0gMCUgcmVhZHMNCj4gPiA+IGFzIH4wIG1pbGxpZGVncmVlcywg
MTAwJSByZWFkcyBhcyB+MTAwMDAwIG1pbGxpZGVncmVlcy4gQnV0IHllcywgdGhlDQo+ID4gPiBh
Y3R1YWwgdXNlYWJsZSBxdWFudGl0eSBpcyBjb3ZlcmFnZSBwZXJjZW50YWdlLCBub3QgdGVtcGVy
YXR1cmUuIElzIHRoZXJlDQo+ID4gPiBhIG1vcmUgc3VpdGFibGUgZXhpc3RpbmcgSUlPIGNoYW5u
ZWwgdHlwZSBmb3IgY292ZXJhZ2UgcGVyY2VudGFnZT8NCj4gPiA+DQo+ID4NCj4gPiBXaWxsIGRl
ZmVyIHRoaXMgdG8gSm9uYXRoYW4gYnV0IGlmIHdlIGNhbiBoYXZlIGEgcmVhbCBvZiB0aGUgY292
ZXJhZ2UNCj4gPiBnaXZlbiB0aGUgdGVtcGVyYXR1cmUsIEkgZ3Vlc3MgdGhpcyBpcyBvay4gR2l2
ZW4gdGhhdCBJIHRoaW5rIHdlIGRvbid0IGhhdmUNCj4gPiBhIGJldHRlciBjaGFubmVsICh1bmxl
c3Mgd2UgYWRkIG9uZT8pIGZvciB0aGlzLiBPciBqdXN0IGV4dGVuZGVkX2luZm8uLi4NCj4gPg0K
PiANCj4gSSBoYXZlIG5vIGlkZWEgd2hhdCBjb3ZlcmFnZSBwZXJjZW50YWdlIG1lYW5zIGluIHRo
aXMgY2FzZS4NCj4gQ2FuIHlvdSBwcm92aWRlIHNvbWUgbW9yZSBkZXRhaWxzIG9yIGEgcmVmZXJl
bmNlPyAgR29vZ2xlIGlzbid0IGdpdmluZyBtZQ0KPiBhbnl0aGluZyB1c2VmdWwuDQoNCkEgbGVh
ayBkZXRlY3RvciBpcyBhIHNlbnNvciBsaWtlIHRoZSByYWluZHJvcCBkZXRlY3Rpb24gbW9kdWxl
cywgd2hvc2UgDQpyZXNpc3RhbmNlIGRlY3JlYXNlcyBhcyBtb3JlIG9mIGl0cyBzdXJmYWNlIGlz
IGNvbnRhY3RlZCBieSBsaXF1aWQuIEluIHRoaXMgY2FzZSwgDQpmb3IgZXhhbXBsZSwgaWYgaGFs
ZiBvZiB0aGUgc2Vuc29yJ3Mgc3VyZmFjZSBpcyBpbiBjb250YWN0IHdpdGggYSBsaXF1aWQsIHRo
ZSANCkFEVDc2MDQgc2hvdWxkLCB3aXRoIGFuIGFwcHJvcGlhdGUgdXNlci1wcm92aWRlZCByZXNp
c3RhbmNlLXZzLWNvdmVyYWdlIA0KdGFibGUsIHJlcG9ydCA1MCUgY292ZXJhZ2UgaW4gdGhlIElJ
TyBjaGFubmVsLg0KDQpUaGFua3MsDQpMaXZpdQ0K
