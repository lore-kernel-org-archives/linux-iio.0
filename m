Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A3113E835B;
	Mon, 18 May 2026 09:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779097073; cv=fail; b=sKOH/uP8LRhPCf87YvpmYGKMwTE6BokiAdgnGqTXqF+6RvLbfHOeP3MJdn8h6/4EhBeqvSOr5chRQuPc6Hcax1XZBkJPeoPKJ3eLIVujemjGms7yULAt/A6tVLvNdKjZiXbW6v2hOanjFun++eyk0NClL5DAolsvStTYwBibSVs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779097073; c=relaxed/simple;
	bh=3wzSK1QZjYy+xxqWGDHwuC/vtjQ8Y9P+iDZQHC9F9es=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hc5+NBsgBRbxg+bPAq93Ce9OHdzabhWoSUQQBBJn+tL0PVNz2EJ8xlxbIWAGrcraqkETZkqHXHK3c6/z4ZO0sVNHBUWsEsamK9cJge8mnbFxViMh43lgF/uqUgaEvzVmRCGYajZ42F2LNsWG4eQUyloRVYLAlGce+0WBYsy7kmI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=WnHnjnvZ; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="WnHnjnvZ"
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64I8CrAm3481940;
	Mon, 18 May 2026 05:37:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=3wzSK
	1QZjYy+xxqWGDHwuC/vtjQ8Y9P+iDZQHC9F9es=; b=WnHnjnvZ71Y8JWNfQSKFK
	K96OZghjnkdAY85bgZwDSfxCXUS2wWAhDrhy3mnDa9zbnRkjB36nP6XfqRmrgMqz
	abz9ZN1gV32c3yW6+yAA2HkXtczm4KUO839/QTk4j5VGoWsF7lkjM2l9BCesOeg7
	xmxRyU37WlnShi69t5ScW5LcEbR0CW6H8QtpV3KHe204+zIcjQHpjxG7x45aDf71
	wsZPPTXvzaN3RT9tlAdC62bNi7Ci0KqHr9TY5YYtcfXg1Jjt/FH0RVmLrT+PpId0
	xbV3kJ5fobjjdNXHcNqcjDq8Sz9PSMMhgb1sVcpM1dJQMJxQAYLIp1kuWqDighZW
	g==
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010006.outbound.protection.outlook.com [52.101.56.6])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4e6jdxnth5-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 18 May 2026 05:37:37 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ic3RXnM+NtC4zr6R+97yNJXMTvzuORD8voBKks9Ao+2wEgmMQlgrEiULzqF78lpoItVrIqniAnboodCp/CPwrmK0zVsnaPRHYIr6Oqa2W6eJSjdFpz8IjQ7FbTTc5euVBYe+PIMtvmMppdoTih7y9iPzrqOEpJkTwolYnKjVUuUmxE3LuLVxi8TeX9xHNZkkmrFaVKT5sXmw2IJ2lFm2Di0AWwOQ90FV7DpoN1APlttzAqJP9uka3NmEDFsb/Fkd1/Sw9+uBquA9jhJ0D1kWjJzpYVv0RcHR/u718n/z6Vg6JnIPjpjn0aDCG//GKml4CoVQ0Sz3sG/sV+mTn8lCqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3wzSK1QZjYy+xxqWGDHwuC/vtjQ8Y9P+iDZQHC9F9es=;
 b=SGN/csENWhqXE7o8D18/iZ9cLhGUORjDEP4AgFQDDQzX3lqO96/OkS9uc6ECdSLIU7hCNWQMS2RlzGnjyqTFTP8+qLdHpe5wRfN9GMZnuVzv6EKxIqUUo2ifAiCVMSKsJ4S2++aXJdLPvZW8uvuSajp6G2DskZWB2ULvS7ISR3I6uIvA6oCm8SvqE7BKP8Evry4G3F4qfgCWVLDyCQRPk8HLqcON+3FoViJomVQUTosMYlmNBUddlwD+3AdVu/OMbFkCzBhIXyAFheiiElgFfo9PDCDHMN+ArFD72lZJxcuL0muHre6ufTB9xzh3sN2vJZHQ8EI4MPreHEBqMgs1AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from SA5PR03MB8425.namprd03.prod.outlook.com (2603:10b6:806:47b::8)
 by CH0PR03MB6146.namprd03.prod.outlook.com (2603:10b6:610:d1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Mon, 18 May
 2026 09:37:33 +0000
Received: from SA5PR03MB8425.namprd03.prod.outlook.com
 ([fe80::ad3e:e026:f2fa:bf5f]) by SA5PR03MB8425.namprd03.prod.outlook.com
 ([fe80::ad3e:e026:f2fa:bf5f%6]) with mapi id 15.21.0025.020; Mon, 18 May 2026
 09:37:33 +0000
From: "Sabau, Radu bogdan" <Radu.Sabau@analog.com>
To: David Lechner <dlechner@baylibre.com>,
        Jonathan Cameron
	<jic23@kernel.org>,
        Radu Sabau via B4 Relay
	<devnull+radu.sabau.analog.com@kernel.org>
CC: Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael"
	<Michael.Hennerich@analog.com>,
        "Sa, Nuno" <Nuno.Sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>,
        =?utf-8?B?VXdlIEtsZWluZSBLw7ZuaWc=?=
	<u.kleine-koenig@baylibre.com>,
        "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] iio: adc: ad_sigma_delta: fix CS held asserted after
 single conversion
Thread-Topic: [PATCH v2] iio: adc: ad_sigma_delta: fix CS held asserted after
 single conversion
Thread-Index:
 AQHc3inmJrOqLx0RyUyaZwFfTl+ZmrYKRGEAgAL6q1CAAGhWAIABLIPAgABM6YCABHWiIA==
Date: Mon, 18 May 2026 09:37:33 +0000
Message-ID:
 <SA5PR03MB84259E631D5CFA53920E6650F7032@SA5PR03MB8425.namprd03.prod.outlook.com>
References: <20260507-ad_sigma_delta-fix-v2-1-ec86eb0463bd@analog.com>
 <20260512121326.189817b8@jic23-huawei>
 <LV9PR03MB84148EC966F80CB723325B46F7072@LV9PR03MB8414.namprd03.prod.outlook.com>
 <e17532c6-3568-4c9a-9d6f-64af7e4736ba@baylibre.com>
 <LV9PR03MB8414852B21F8B66AF821055CF7042@LV9PR03MB8414.namprd03.prod.outlook.com>
 <4b9fbf8d-6dec-4e18-a3c5-a4b87d34af08@baylibre.com>
In-Reply-To: <4b9fbf8d-6dec-4e18-a3c5-a4b87d34af08@baylibre.com>
Accept-Language: en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA5PR03MB8425:EE_|CH0PR03MB6146:EE_
x-ms-office365-filtering-correlation-id: aeaf7aee-476e-4033-86b7-08deb4c11696
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|38070700021|4143699003|56012099003|22082099003|18002099003|11063799003;
x-microsoft-antispam-message-info:
 WH0zCmvMfKbU1LV6iV0NuCjYrr/M0DJt0i/HmD+uLkyiYf1ONSw0rKf8o9tel0ZeZpJyYGbzGbQ7QVXdvFprT709cvLlqJghQr5Jvz2PyOR1X5jXQowhKjxezK9eQ0bSJQz0kF0NcQLS+qVmdGr9EYi+2ZViKUPcnlzQU3SsW5mzrAy3bpESBqCrDoYSuRDpvaH368AAT8HWBsv+Amx+t2FCZdjVhFSNxpP5DfblE6O6eZfmb0p3lHUj8N/1iQqrlk71bMzPSiGuKUxpPqtv8y9d0S7xvw8Pq6NfEZEdfF4L8EXuK2SoCMapEDQ4QeOC8QP1t+ZD6Kn9Lgn8J82zxKRo9gYKjqe5kwvxSd7EGnLvqSJbYojQ+CTabwkkkLefusoZwjxTnYYro8qCNkt9HwhAfOX7kGEqegv8ESutcZD+Vp2hyWzcgaQJtEyrqStJ052yFfsINcQzX3klTP/vM37nz/FfGNPfrLuE+HITNRBzi28UURhRl2IxX7MpWJmZ20UoOqXjjxceyl2MFWkgkXc95SF4s4vFpAqmfwE3+If///Km6xLrB5b3hMPu/bCEJ2m7Ds8NRhaIIYwAykL9B3k/v+uF/2xZR1caeerxDOSYxcWpZTgLkE84y+/u1zOEoLZwCbqilFxicKi8DAvcad+9TtgVdSATc/6m3GpjJh5mYT1neJGhmqln6lxa40oKZIvjjd4Fv0Swp6+sQFRXl7LGc+od1dsgSCEX0XTWjJPlEcS5gvQ29YgJBL7wrOaM
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA5PR03MB8425.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(4143699003)(56012099003)(22082099003)(18002099003)(11063799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YzJRRkVuM2crYm1wU004MDFiRHNod3hiRGVXTTB0UHltU1cwbnhoeWd4SE9D?=
 =?utf-8?B?Zk5Bd1hJSnd5eVArb2h2UEtyYUJSN1pWMHJvZlU2cjlmMTl5YktueEZhQlBR?=
 =?utf-8?B?T1oxOXloa1hsNzljT0J0d1A0azdHNVYwK1V5UXpjVDR0NzEzMmhpKy9tZ0Ry?=
 =?utf-8?B?T1lqNWhNQ2lWdythSXovMm8yRStrR2pobCs0cG42WEM2Q1FiSU9KbmNiWEFr?=
 =?utf-8?B?Qno0eFdTU3B4NEQvTFBWa3gvS1psN01JSkN5U3UrR3k5ZDh2c1FPeUU0WGpa?=
 =?utf-8?B?V05OY1dTbS9QSGZ5LzFxZ1h3WEJwdkt1cDczNWd1NWRUN0I1U3pDS0JCcVNy?=
 =?utf-8?B?ZkNMU0xIeS8xbW5MLy9ZdjE4b2EyTlFiN0hNVFBGdEQ1bk1BWmFhRXVDcmg5?=
 =?utf-8?B?V2ErK0VpNXEwTHkyejVOMDZjcXluUzhqb3pySjl2SVlqRkVhWlAyb1FnbFh3?=
 =?utf-8?B?dlI4bzVKQ2J0aURuQjZ5ZWFDUnZpU0FUdzFGTUF5MzlSc0I2RnE5RmUrYTJK?=
 =?utf-8?B?ZVZFOHVMd3ZkR1I1cUlhZGh3THhTQkcwdkdzVFI3VlV3bW9wUUUvT3BTUW5y?=
 =?utf-8?B?MEtoUlJTT2NWb0F3T2xtYjBWeEdMQ3FXQlhucDhncXRFUThUOUE0VnJoTXpG?=
 =?utf-8?B?dzdQZkF5YVNkQk4zNDNYWUI5ZFhlOTN6YTg3Tmg1R1hLR2V4K2lhcGlZWThz?=
 =?utf-8?B?ams4dFFRTHp5L2w3ckVhRGV4c0JEVER5UXBXRjdjOUlremxnQ1kyZTBsZkNk?=
 =?utf-8?B?OTdEalhGSDFWdDhyMjhPL1lhaFFOUjRVOHRPa09saFJ6azAxb3I4dStiV1Q0?=
 =?utf-8?B?MTQ2SjNVS1Zkc2t5S0RTcW55TkNodGJ4R3R1MHV1OEZOMFBwVHFwbzFOMTd2?=
 =?utf-8?B?Z2hqYnFWTWFBVzQ0VFcvcEw5L3VnTmpHTTJSNWRuK1R3SHZ4M3JqeDd0L09K?=
 =?utf-8?B?SEs0a2lEQ2hnSmdSTUt2dnlNNUJ0QUFRK1VFeDFqdFBxTmFFRHZ4RmUvVFhy?=
 =?utf-8?B?ZGIxTVF6Z1JBSEJoSGlDbDRyOTA1TEI3Sm54RXRjelV3VTlmeCt2dnBzamJQ?=
 =?utf-8?B?N1F2bjUwWStURjdsWWs0QlI5NitJai9ZQkcxeUNJMXRnNzd1L2RmakdlV2Zn?=
 =?utf-8?B?TUM1RkRueklNTVpCV25xcnpPamtQS2lpcGhzN2NzdXNvbzJjZCtlUDRjbitL?=
 =?utf-8?B?WU1GeVluWHAvN1FYNjNQc2hWaUswcVA5RnQwQjZCdHFnVGNoSVp2VGxiWVBm?=
 =?utf-8?B?Qmo1TUxmSWUwcmNidFpzR1BqVFB3UnE5Sk15QUQyS2FCNnprYW1RVjd5K1B2?=
 =?utf-8?B?bExZSjZITEVtTC9aUTh4WnBFTGpoSHgyTHhlbGFHd01FWFVhZ2hZcGg2bWVW?=
 =?utf-8?B?ckFKWWNUZE9ldFNoQjUxZEJYWEdVaTBwa1cyM2JvMFF3ZDlqckNDekUrcW9I?=
 =?utf-8?B?cFdvZXhjckJpSStDT0d4UEVnL2JCcE54NUVpWHlYVkNMaHcvdEEyb2JGNEt4?=
 =?utf-8?B?dnRZdTlKdGVKUWtMS1N4QmtPQWFJZjFYNzNBd1grVXJaN1I5ZWhXaTdYa2My?=
 =?utf-8?B?SkgyM1dkdGpxWEJiZkJXd3pzenByM3YyUzYybWlsb05iRERaTU1xQS9RRVdO?=
 =?utf-8?B?aHYwakZsRG1mNjBWZW1RL1BvV0Ewd3MvWWpRcmZYTlFwR3ZNYzI1VFFmRDFt?=
 =?utf-8?B?eFhIT0gxZWcrRDg4RGZxdDhXQyt0OG5xZHJ0WWE4by9rd05xU3VDMlUvUnRW?=
 =?utf-8?B?aUxtR0tsY1RBK3dMYmk1ZG00K2YxUXoxaks5dTNxcEFNMGpHS3BUeVkyQVYr?=
 =?utf-8?B?NVNOQW5BNzZ4VjN6SGR6by93UzZNSkdqc2lXMFRxK3RKcGlneWtIYnVEbzNr?=
 =?utf-8?B?V3lDcWQ5OStFbXNFb2xHNVlCV2dmWlJVRnRZeXU2Y2xubEsyYUNEY0hsaEk5?=
 =?utf-8?B?ZEVJUThaL1JPVWN3MVlaRHpWb3VZK0xjZTBoaWxNbkNBVCsvR2V4OXd4NnZx?=
 =?utf-8?B?SjJMYy9mOVRqUm9KOU53clgrMmRGUFUwaTlDUW1HTG1mSExXR3JGeVRhRjJq?=
 =?utf-8?B?RmNHVHJzTGdlTlNsNkF5eFVHOFo0QnBlMm9CYXkyWmI4TUpxQWNhMjJqQnpx?=
 =?utf-8?B?SjBnSjM3WUZFa1NLR2lJSjhTd3l3YXRiNHgwOE0wOUkvc1dCbml1OFZXRFp0?=
 =?utf-8?B?NHhwVFBUUGx2NENPcjVwSkIwazNKczZaZkVxMlNtY0JTVzV3Y0dVS0Q4VzBo?=
 =?utf-8?B?R0V5UlZCRjIzV0RBcnRvd05aTnduRGZXY2t0SXFEMXRDeWxCRlZYMW9SVzMx?=
 =?utf-8?B?RjFWRHQ2R2lKN0NpUkpCSGVDNTV5Q3B4bUlURUhXcjljTWVja0JQQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	T1e1mKN+6xX9uAEVR32g5Uz2L5B6DTIHMt8pdbizQxo5lWiBYIxvMb65RwJ4Ha1SMyqaQoyoObiqTj0hCnvxktSKwp6c3QZ9jsmah71HKxdzdNDomjZylaFrZK6W2T4q2cwA4Nv0zcgGFLu9WL/atlmrdufv2DK1aZvNSdgGkS1b95Pc5u460F+qRdavrIRibUzDk/hYb5Pj/DXmVuJgzNq3rZSSZwyfKVanvBf38XCS2a82LaGj5SV6s/UNumJsfuODFMoojQX3h4Tmop/PrtotkMnjZB52IQdJkzLKY+F36soNc+wjZ4GZQnrijSl4Vr2Ek2NMLX32T/REQ/TVYA==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA5PR03MB8425.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aeaf7aee-476e-4033-86b7-08deb4c11696
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2026 09:37:33.3645
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4zD50c1kq5iuIpSklrE4ouYDvDKjNi2w+6XFf74vfJ+AAg2BxUOPPMSvuyKZzAXTiTDjrl2iReLPfMlXVgWOqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR03MB6146
X-Proofpoint-GUID: O9SC6sUH1sKIdE0zFrLWIzl3jxgDUH4N
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE4MDA5MiBTYWx0ZWRfXyibb5qY+Tsu3
 zeMBgu+n4t9oreDG75skhtcdWEPDHtEUOw3DbPA53Tg+PRLo6020q0C2c7ONbUfd6O7phAS+3WM
 VeOerw7M0dKYyU5BUaQXIoBXxp+rrB4nR9jjG1dYC6iYmcmMKJtHnrr3IBo0H+XYyeoVx6MzfAa
 6umZa1CAXJWuIG0Q1x69AEns61khN+Il5Ao49P8Nxg0f475UwL3C97rNLxZOSH3b6dHSp6O/KWF
 rsthnzbDGOxJKNVv8XKjd0Jv10zeI6o7TC/aa+vxcRPUpNxdLrBLy9243o4Hvm+8qakBEeROfQU
 HL0KAJ1FdsuugIvza+s7ccALC5JgddSnnCQ5EDzHy8Qcu6akICmpKCJVrkX2PbVok9TQQ/8UqEY
 qe2DjhmPArAWIWPur7oPlGfMBZ0ETTkDSzYJd9k0rbDHd940187ABPgRF9Ux1tu5AYrxK/8VK1D
 wu9jnZWfne5qyhuDxFQ==
X-Proofpoint-ORIG-GUID: O9SC6sUH1sKIdE0zFrLWIzl3jxgDUH4N
X-Authority-Analysis: v=2.4 cv=FfwHAp+6 c=1 sm=1 tr=0 ts=6a0adde1 cx=c_pps
 a=AaT4FrH4hTNSk8p5YcQWtA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=uXIjobp8t2wMuQ0fPvqm:22 a=IpJZQVW2AAAA:8 a=gAnH3GRIAAAA:8 a=VwQbUJbxAAAA:8
 a=uUSIdnEfDJoptULanVEA:9 a=QEXdDO2ut3YA:10 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-18_02,2026-05-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0
 adultscore=0 spamscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605180092

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBEYXZpZCBMZWNobmVyIDxkbGVj
aG5lckBiYXlsaWJyZS5jb20+DQo+IFNlbnQ6IEZyaWRheSwgTWF5IDE1LCAyMDI2IDQ6MjcgUE0N
Cj4gVG86IFNhYmF1LCBSYWR1IGJvZ2RhbiA8UmFkdS5TYWJhdUBhbmFsb2cuY29tPjsgSm9uYXRo
YW4gQ2FtZXJvbg0KPiA8amljMjNAa2VybmVsLm9yZz47IFJhZHUgU2FiYXUgdmlhIEI0IFJlbGF5
DQo+IDxkZXZudWxsK3JhZHUuc2FiYXUuYW5hbG9nLmNvbUBrZXJuZWwub3JnPg0KPiBDYzogTGFy
cy1QZXRlciBDbGF1c2VuIDxsYXJzQG1ldGFmb28uZGU+OyBIZW5uZXJpY2gsIE1pY2hhZWwNCj4g
PE1pY2hhZWwuSGVubmVyaWNoQGFuYWxvZy5jb20+OyBTYSwgTnVubyA8TnVuby5TYUBhbmFsb2cu
Y29tPjsgQW5keQ0KPiBTaGV2Y2hlbmtvIDxhbmR5QGtlcm5lbC5vcmc+OyBVd2UgS2xlaW5lIEvD
tm5pZyA8dS5rbGVpbmUtDQo+IGtvZW5pZ0BiYXlsaWJyZS5jb20+OyBsaW51eC1paW9Admdlci5r
ZXJuZWwub3JnOyBsaW51eC0NCj4ga2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBS
ZTogW1BBVENIIHYyXSBpaW86IGFkYzogYWRfc2lnbWFfZGVsdGE6IGZpeCBDUyBoZWxkIGFzc2Vy
dGVkIGFmdGVyDQo+IHNpbmdsZSBjb252ZXJzaW9uDQo+IA0KPiBbRXh0ZXJuYWxdDQo+IA0KPiBP
biA1LzE1LzI2IDQ6MjAgQU0sIFNhYmF1LCBSYWR1IGJvZ2RhbiB3cm90ZToNCj4gPj4gLS0tLS1P
cmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPj4gRnJvbTogRGF2aWQgTGVjaG5lciA8ZGxlY2huZXJA
YmF5bGlicmUuY29tPg0KPiA+PiBTZW50OiBUaHVyc2RheSwgTWF5IDE0LCAyMDI2IDU6NTcgUE0N
Cj4gPg0KPiA+IC4uLg0KPiA+DQo+ID4+Pj4gSSdtIHN0cnVnZ2xpbmcgYSBiaXQgb24gaG93IHRo
ZSBtYXgxMTIwNSB3b3JrcyBhdCBhbGwgYXMgdGhlcmUgc2VlbXMNCj4gPj4+PiB0byBiZSBhIHN0
YXR1cyByZWdpc3RlciByZWFkIG9uIGEgZGV2aWNlIHdoaWNoIGNsYWltcyB0byBoYXZlIG5vIHJl
Z2lzdGVycy4NCj4gPj4+PiBhZF9zaWdtYV9kZWx0YV9jbGVhcl9wZW5kaW5nX2V2ZW50KCkgYXMg
dGhlIGJpbmRpbmcgc3VnZ2VzdHMgdGhpcw0KPiBkZXZpY2UNCj4gPj4+PiBkb2Vzbid0IGhhdmUg
YSBkcmR5X2dwaW8NCj4gPj4+Pg0KPiA+Pj4+IEFueWhvdywgcGxlYXNlIHRha2UgYSBsb29rIGF0
IHRoZSBmZWVkYmFjayBhbmQgaWYgaXQncyB3cm9uZyBwbGVhc2UNCj4gcHJvdmlkZQ0KPiA+Pj4+
IGFuIGV4cGxhbmF0aW9uIG9mIHdoeSBpbiB0aGlzIHRocmVhZC4NCj4gPj4+Pg0KPiA+Pj4NCj4g
Pj4+IEhpIEpvbmF0aGFuLA0KPiA+Pj4NCj4gPj4+IEZpcnN0IG9mIGFsbCBzb3JyeSBmb3IgZm9y
Z2V0dGluZyBhYm91dCBTYXNoaWtvLiBJIGhhZCBhIGxvb2sgYXQgbWF4MTEyMDUgYW5kDQo+IGl0
DQo+ID4+PiBzZWVtcyBsaWtlIHRoZSBkZXZpY2UgZG9lc24ndCBoYXZlIGEgQ1Mgc28gdGhlcmVm
b3JlIHRoZSBjb25jZXJuIFNhc2hpa28NCj4gPj4+IHJhaXNlcyByZWdhcmRpbmcgQ1MgbWF5IG5v
dCBiZSB2YWxpZCwgSSB3aWxsIG1ha2Ugc3VyZSB0byBtZW50aW9uDQo+ID4+PiB0aGF0IGluIHRo
ZSBjb21taXQgbWVzc2FnZS4NCj4gPj4+DQo+ID4+PiBPbiB0aGUgb3RoZXIgaGFuZCwgSSBzZWUg
dGhlIElDIGhhcyBhIHNoYXJlZCBwaW4gZm9yIERSRFkgYW5kIERPVVQgYW5kDQo+ID4+PiB0aGUg
YmluZGluZ3Mgc3BlY2lmeSBzb21lIGludGVycnVwdCB0aG91Z2ggbm8gc3BlY2lmaWMgcmR5LWdw
aW9zIGFyZQ0KPiA+Pj4gbWVudGlvbmVkIHRoZXJlLiBUaGUgZGV2aWNlIHJlYWRzIGEgcmVnaXN0
ZXIgdGhhdCBkb2Vzbid0IGV4aXN0IHdoaWNoDQo+ID4+PiBpbiB0aGlzIGNhc2UgbWVhbnMgaXQg
YmxpbmRseSBjbG9ja3Mgb3V0IHdoYXRldmVyIGNvbWVzIG9uIE1JU08uLi4NCj4gPj4+DQo+ID4+
PiBIb3dldmVyIEkgbWF5IGhhdmUgYSBmaXggZm9yIHRoaXMgYW5kIHdvdWxkIGFwcGVhciBpbiBh
IHNlY29uZCBjb21taXQuDQo+ID4+PiBJbiBjbGVhcl9wZW5kaW5nX2V2ZW50IHdoZXJlIHJkeV9n
cGlvZCBpcyBjaGVja2VkIHRoZXJlIGNvdWxkIGJlIHlldA0KPiA+Pj4gYW5vdGhlciBlbHNlIGJy
YW5jaCB0aGF0IGNvdWxkIHNpbXBseSByZXR1cm4gMCBhbmQgaGVyZSBpcyB3aHkgSSB0aGluayB0
aGlzDQo+ID4+IHdvdWxkIHdvcms6DQo+ID4+Pg0KPiA+Pj4gU2luY2UgdGhlIElSUSBpcyByZXF1
ZXN0ZWQgd2l0aCBJUlFGX05PX0FVVE9FTiBhbmQNCj4gSVJRX0RJU0FCTEVfVU5MQVpZLA0KPiA+
PiB0aGUgbGF0dGVyDQo+ID4+PiBrZWVwcyB0aGUgSVJRIGhhcmR3YXJlLXVubWFza2VkIGV2ZW4g
d2hpbGUgc29mdHdhcmUtZGlzYWJsZWQsIHNvIGFueQ0KPiA+PiBmYWxsaW5nIGVkZ2UNCj4gPj4N
Cj4gPj4gVGhpcyBzaG91bGQgZGVwZW5kIG9uIHRoZSBJUlEgY29udHJvbGxlci4gVGhlcmUgYXJl
IHNvbWUgcGFzdCBkaXNjdXNzaW9ucw0KPiA+PiBvbiB0aGlzIG9uIHRoZSBtYWlsaW5nIGxpc3Qu
IFRoZSBpZGVhbCBiZWhhdmlvciBzaG91bGQgYmUgdGhhdCBpZiB0aGUNCj4gPj4gSVJRIGNvbnRy
b2xsZXIgY2FuIGZ1bGx5IGRpc2FibGUgdGhlIGludGVycnVwdCBzbyB0aGF0IHdlIGRvbid0IGdl
dCB0aGUNCj4gPj4gc3B1cmlvdXMgaW50ZXJydXB0IG9uIGVuYWJsZSAoZnJvbSB0aGUgbm9ybWFs
IFNQSSBkYXRhLCBub3QgRFJEWSkuIElmDQo+ID4+IHRoZSBpbnRlcnJ1cHQgY29udHJvbGxlciBj
YW4ndCBkbyB0aGlzLCB0aGVuIGl0IHJlcXVpcmVzIHRoZSByZHktZ3Bpb3MNCj4gPj4gdG8gYmUg
YWJsZSB0byBkaXN0aW5ndWlzaCBEUkRZIGZyb20gU1BJIGRhdGEuDQo+ID4+DQo+ID4NCj4gPiBy
ZHktZ3Bpb3MgYWRkZWQgdG8geWFtbCBvZiBkZXZpY2VzIHRoYXQgZG9u4oCZdCBoYXZlIHRoZW0g
YW5kIGFsc28gZG9uJ3QgaGF2ZQ0KPiA+IHJlZ2lzdGVycyBpcyBhIHNvbHV0aW9uIHRvby4gVGhv
dWdoIEkgdGhpbmsgd2hhdCB5b3UgbWVhbiBieSB0aGlzIGlzIHRoYXQgdGhlDQo+ID4gcmR5LWdw
aW9zIHNob3VsZCBiZSBzb21ldGhpbmcgb3B0aW9uYWwgdG8gYmUgYWRkZWQgYnkgdGhlIHVzZXIg
ZGVwZW5kaW5nDQo+ID4gb24gaGlzIElSUSBjb250cm9sbGVyIGNhcGFiaWxpdGllcywgcmlnaHQ/
IFBlcmhhcHMgdGhpcyBpcyB0aGUgY2FzZSBoZXJlIGFscmVhZHkuDQo+ID4NCj4gPj4gSSBoYXZl
IHVzZWQgdGhpcyBvbiBhZDcxNzMgb24gYSBaZWRCb2FyZCB3aXRob3V0IHJkeS1ncGlvcyBhbmQg
dGhlDQo+ID4+IGludGVycnVwdCB3YXMgd29ya2luZyBjb3JyZWN0bHkuIFNvIHVubGVzcyBzb21l
dGhpbmcgY2hhbmdlZCB3aXRoDQo+ID4+IHRoZSBpbnRlcnJ1cHQgY29uZmlnIGluIHRoaXMgY29k
ZSBzaW5jZSB0aGUgbGFzdCB0aW1lIEkgd2FzIHVzaW5nLA0KPiA+PiBJIHdvdWxkIG5vdCBleHBl
Y3QgdG8gc2VlIHRoaXMgcHJvYmxlbSBvbiBfYWxsXyBpbnRlcnJ1cHQgY29udHJvbGxlcnMuDQo+
ID4+DQo+ID4NCj4gPiBZZXMgYnV0IGFkNzE3MyBoYXMgcmVnaXN0ZXJzLCBtYXgxMTIwNSBhbmQg
ZmV3IG90aGVycyBkb24ndC4NCj4gPiBJbiB0aGUgY2FzZXMgd2hlcmUgbm8gcmR5LWdwaW9zLCBh
bHRob3VnaCByZWdpc3RlcnMgYXJlIHByZXNlbnQgb3Igbm90LA0KPiA+IGl0ICJyZWFkcyIgdGhl
IHN0YXR1cyByZWdpc3RlciB3aGljaCBpbiB0aGVzZSBjYXNlcyBtZWFucyBjbG9ja2luZyAxIGJ5
dGUNCj4gDQo+IFRoZXJlIGlzIGFscmVhZHkgc2lnbWFfZGVsdGEtPmluZm8tPmhhc19yZWdpc3Rl
cnMuIFdoeSBpcyB0aGlzIG5vdA0KPiB1c2VkIHRvIHByZXZlbnQgcmVhZGluZyB0aGUgc3RhdHVz
IHJlZ2lzdGVyIHdoZW4gdGhlcmUgYXJlIG5vDQo+IHJlZ2lzdGVycz8NCg0KVGhhdCdzIHByZXR0
eSBtdWNoIHdoYXQgdGhhdCBuZXcgJ2Vsc2UnIHdvdWxkIGJlIGRvaW5nLCBoYW5kbGluZyBkZXZp
Y2VzDQp3aXRob3V0IHJlZ2lzdGVycy4NCg0KPiANCj4gPiBmcm9tIHRoZSBET1VUIGxpbmUsIGFu
ZCBoZXJlIDIgY2FzZXMgYXBwZWFyOg0KPiA+DQo+ID4gMS4gRE9VVC9SRFkgaXMgc3RpbGwgaGln
aCB3aGljaCBtZWFucyBET1VUIHJlYWRzIDB4RkYNCj4gPg0KPiA+IC0gInN0YXR1cyByZWciID0g
MHhGRg0KPiA+IC0gcGVuZGluZ19ldmVudCA9ICEoMHhGRiAmIDB4ODApID0gISgweDgwKSA9IGZh
bHNlDQo+ID4gLSByZXR1cm5zIDAsIG5vdGhpbmcgYmFkIGhhcHBlbnMgLT4gV29ya3MgYnkgYWNj
aWRlbnQNCj4gPg0KPiA+IDIuIERPVVQgcmVhZHMgMHgwMCAobGluZSBMT1cpICwgcGVyaGFwcyBS
RFkgZHJvcHBlZCBhbHJlYWR5Lg0KPiA+DQo+ID4gLSBUaGUgMSBieXRlIHJlYWQgYWxyZWFkeSBj
b25zdW1lZCA4IGJpdHMgb2YgdGhlIGFjdHVhbCBjb252ZXJzaW9uIHJlc3VsdCBhbmQNCj4gPiBk
YXRhIHN0cmVhbSBpcyBhbHJlYWR5IGNvcnJ1cHRlZC4NCj4gPiAtICJzdGF0dXMgcmVnIiA9IDB4
MDANCj4gPiAtIHBlbmRpbmdfZXZlbnQgPSAhKDB4MDAgJiAweDgwKSA9ICEoMCkgPSB0cnVlDQo+
ID4gLSBDb250aW51ZXMgaW50byB0aGUgZHJhaW4gcGF0aA0KPiA+IC0ga3phbGxvYygwICsgMSkg
LT4gYWxsb2NhdGVzIDEgYnl0ZQ0KPiA+IC0gbWVtc2V0KGRhdGEgKyAyLCAweGZmLCAwIC0gMSkg
LT4gZGF0YV9yZWFkX2xlbiBpcyB1bnNpZ25lZCBpbnQsIHNvIDAgLSAxID0NCj4gU0laRV9NQVgN
Cj4gPiAtIG1lbWVzZXQgb2YgU0laRV9NQVggYnl0ZXMgLT4gaGVhcCBjb3JydXB0aW9uLCBrZXJu
ZWwgY3Jhc2ggLT4gV29yc3QNCj4gY2FzZSwgYnV0DQo+ID4gc3RpbGwgcG9zc2libGUNCj4gPg0K
PiA+IEkgd291bGQgdGhlbiBzYXkgdGhhdCB0aGUgc29sdXRpb25zIGFyZSAxIG9mIDoNCj4gPiAt
IGFkZCByZHktZ3Bpb3MgYXMgd2VsbCB3aGVyZSBoYXNfcmVnaXN0ZXJzIGFyZSBmYWxzZS4NCj4g
PiAtIGFkZCBhbm90aGVyIGVsc2Ugd2l0aCByZXR1cm4gMCwgc2luY2UgaWYgdGhlIERSRFkgaXMg
bm90IGxvdywgaXQgd2lsbCBiZSBhZnRlcg0KPiBlbmFibGVfaXJxLA0KPiA+IGFuZCBpZiBpdCBp
cyBsb3csIGl0IHdpbGwgYmUgdHJpZ2dlcmVkIGFmdGVyd2FyZHMgYW5kIGNsb2NrIGRhdGEgY29y
cmVjdGx5LiBGb3INCj4gdGhlc2UgZGV2aWNlcw0KPiA+IGFzIGZhciBhcyBJIGNhbiB0ZWxsLCB0
aGVyZSBzaG91bGQgYmUgbm8gc3B1cmlvdXMgc2lnbmFscywgb25seSB0aGUgRFJEWQ0KPiBpbnRl
cnJ1cHQgdW5sZXNzDQo+ID4gY2xvY2tpbmcgZGF0YS4gSSBtYXkgYmUgd3JvbmcgdGhvdWdoLCBh
bmQgcGVyaGFwcyB0aGUgcmR5LWdwaW9zIGlzIHRoZSBzYWZlcg0KPiBtb3ZlLA0KPiA+IHRob3Vn
aCB0aGlzIHdvdWxkIG1lYW4gbGVzcyBjaHVybi4NCj4gDQo+IEkgd291bGQgZXhwZWN0IHRoZSBu
ZWVkIGZvciByZHktZ3Bpb3MgdG8gYmUgdGhlIHNhbWUgd2hldGhlciBub3Qgbm90DQo+IHRoZSBj
aGlwIGhhcyByZWdpc3RlcnMgKG9ubHkgZGVwZW5kcyBvbiB0aGUgaW50ZXJydXB0IGNvbnRyb2xs
ZXIpLg0KDQpJIHdvdWxkIHRvbywgd291bGQgdGhlbiBhZGQgcmR5LWdwaW9zIHdoZXJlIG5lZWRl
ZCBpbnN0ZWFkLg0KDQo+IA0KPiA+DQo+ID4gV2hhdCBkbyB5b3UgZ3V5cyB0aGluaz8NCj4gPg0K
PiA+IFRoYW5rcywNCj4gPiBSYWR1DQo+ID4NCg0K
