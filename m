Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 037FA16A395;
	Mon, 16 Mar 2026 09:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773653775; cv=fail; b=crS75OaCyrTjx95Ya6/W93XYXD8lSSWljSGmP06ErHDhGwdymIlxi5dMgTTfAQ9dxiEDl5DdhodoH6HH8NakD/qH0A9TIabWzHAwWKa9J9rgRyoudN0VXx4Tbwn5WQ9wSFtbYE8ZoJ0CBrcsdUnlv96HtEm44yMls2CzdNP3vEM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773653775; c=relaxed/simple;
	bh=JzxiecODBnHt+QyUeb6rjUAZk8n6q+g8C0adYtr+fEM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RHuyBCYVNocBUevsGpHZmiGgIprNuRO/7c8Dql+PCAI0Tj2xIFKXbFVXQnyxCq3P46ACNKy7ehvP6xsL7gYkdW0UHZ0hVh0FSqSPz+zz7c2mVXfHbRsYq6wQ9lSrZaLJrte6nQf5vOVsKi2s9wxtmtC7F/YjecLhtne3WxermeY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=xw1nA3JP; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="xw1nA3JP"
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62G53diV609669;
	Mon, 16 Mar 2026 05:35:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=Jzxie
	cODBnHt+QyUeb6rjUAZk8n6q+g8C0adYtr+fEM=; b=xw1nA3JPFGV7XgZ5VagPt
	CaDlX/TCKDcWFCO1kFWZLxsohnvF//HID0gqYyZRBc/RFmwI5L2M5xh64BuksrfL
	ZYAMU1Zo0UsUcXMy5Tr1chilOlCag8NyVz7R+Z4kVWnV/agJhS/T+PQvgghod9vD
	g5vTuWATH6ZCky/xpE935I4cLS3D0oKfNeK9GA0kYUP6pBJFHluhJDE0+87mT6KN
	wF6MibmSB17USbtRswwZBQ7hzt/ipOvc8FRkB7KDf1XUP/b1SkatHIl/yZMadAEX
	qUjIGbKjptUL1CL2Suexq8Q8Hcj6UewE8GJCdedKzP9NjRUBdTQlGoLsbcNBTRoG
	Q==
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011056.outbound.protection.outlook.com [40.107.208.56])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4cx2em1uhp-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 16 Mar 2026 05:35:44 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EvkmwWwehn+3gZ8APfVsAZD/XAPDV4g29fq92ehj87cXxQDSbMVNSCIzuD14SsXJEeJbv/77/1vpfnOTzseZoMyAy+QYMute2OUm/jYFnAy2e/2N2UGKdn+4XOiocKzFlSfa3RbcOGk5tq64xqQTcnbr6GYNRi9fROKZXm2BJzPmbLn2B07cUHe3TKJxRyoRMt+ZUAr/iTdRMBmkryiFGrvO4PQNAISK9bFjCnSNEXYsUVBdO2KTSHLwMDyYeGvOOlbTbZFu5KadZO9sLfgofY1VY7YYakWLDgCxDainy9WOZ4XX6zn80nc9XI/7TnJdd4dWMTVYlRFXzNwHpV6Q9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JzxiecODBnHt+QyUeb6rjUAZk8n6q+g8C0adYtr+fEM=;
 b=r/su7tuKz6LX+Y2Yzc/ua/vCCe+4EHnQel4ODBO/pdulG4oncHoj5lr/MJrFoiluoT3suqM0ce5/xyTpRrNp0u7Jil5DWyxlbW3S/94DlPdG5mxvxODwYupsBxjpLHAV+lXJFw1QIqQxOJ5aIMEhJGWaeZAtTSI1tWKCPY5Hx5p9xjGrJX3HZPWdE/lpsxDlY5Zm7mkzBKh6zbFZXozd/tEFGi7nqqzWbLeC2LuZAsW7QQuLzwN9dL8DA+AkDwBFGAnwepsjRWleoyZLNkDvz3OAecxSHZMSCCW3E1geO7hBZV7r6JTFhPx+EgTSvegMfAT/r6O5eU/JBG6m01U8Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from SN6SPR01MB0090.namprd03.prod.outlook.com (2603:10b6:805:d::23)
 by CO1PR03MB5857.namprd03.prod.outlook.com (2603:10b6:303:90::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.18; Mon, 16 Mar
 2026 09:35:38 +0000
Received: from SN6SPR01MB0090.namprd03.prod.outlook.com
 ([fe80::8b7e:c42f:998c:10ef]) by SN6SPR01MB0090.namprd03.prod.outlook.com
 ([fe80::8b7e:c42f:998c:10ef%4]) with mapi id 15.20.9654.022; Mon, 16 Mar 2026
 09:35:40 +0000
From: "Miclaus, Antoniu" <Antoniu.Miclaus@analog.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael"
	<Michael.Hennerich@analog.com>,
        David Lechner <dlechner@baylibre.com>,
        "Sa,
 Nuno" <Nuno.Sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Olivier Moysan <olivier.moysan@foss.st.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v6 0/4] iio: adc: ad4080: add support for AD4880
 dual-channel ADC
Thread-Topic: [PATCH v6 0/4] iio: adc: ad4080: add support for AD4880
 dual-channel ADC
Thread-Index: AQHcsuDUaubwjyo6XkqBEFSnv0rHfbWt6RcAgAL/9gA=
Date: Mon, 16 Mar 2026 09:35:40 +0000
Message-ID:
 <SN6SPR01MB00909BCF397D6DBCDA9D0D0E9B40A@SN6SPR01MB0090.namprd03.prod.outlook.com>
References: <20260313115856.87763-1-antoniu.miclaus@analog.com>
 <20260314114058.246bcfc5@jic23-huawei>
In-Reply-To: <20260314114058.246bcfc5@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6SPR01MB0090:EE_|CO1PR03MB5857:EE_
x-ms-office365-filtering-correlation-id: 40aa5f35-6e35-43c7-3ff6-08de833f6338
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700021|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info:
 pbmV021ebFEQ+GJ4fqJgoL+KVOWTk6E0lEkj/DBtBR8dgwwUOcMZJEmAWSfj2jQCbZi2yZXq9kmTvoKdYKCzLRIZFH4Jj7YjkjxvqWlf09yVd5roWzlx80/pLhnMxAwynIFhfXpu4jlUiRKXOONJ3iobiBmi/FGE75KJgDh6HMwFJIN4qU+homKVjb/ggmj60R+x4mkR2JrJ8u0oJyTkgh6bIisq0Itp4Qzby0rOekSWzaEJG6GbDS+8nuAsjMakM21+JZK77AObXM4b/V7t+1vBGQx6RT+eEqLOOaWFyZUBZpQV1czCq2VQkiZw34RWh3wzXAzFSof9DTQ7yPqGUGCmM+TVlECzXxL8FqFzerwPbq1QtzxcQPt7SDl8QAPSSpLA9/j8CElV7n+U2GNHlLpcMIWuZp5PWn4L23uDHOt8t9Lhf9rJsuMTloIJV1BeGBHGJ2j2J8Ia4LMDzU8s60lgFSspGPuXJc3jumjiuZUjfN1yIHrBs/HWYjhgbzNZNHyYhDCPCOCHpN1AUAf4cjbipxv/LoxY+uw/ZhQ0IM4lqXltaGuFCLRXjALJs4FNYrzGdLFPfGRD2UUSDu0iWGJSAykvIMyhuatlqqYZr5bMTJNOXVRAfPUUBs/LjSTum4NiWyOa9HlxCP8SvrXkXEyEg/VYEU4riVS2pWqUE/+X7/1h99xoFKQBxv1Y0SU4h00C0TuyxjOlVp0x+FUWomjdTpkT4dcNaHO13lXOzF2N8ihRgEtQJ7h8HzMes/B3
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6SPR01MB0090.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700021)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OVQ5NmduZzRMdVI2cWZEbzcyQ3kya0ZBUlhoTXA5UlZ5K2hUdHp6bnJ1SE5V?=
 =?utf-8?B?UmdxTHZ3YlVqZTNFMjQ5eDNqS3VvNlQ3TWdwTythdzQ1THNPOTlRWDh1MW9v?=
 =?utf-8?B?VWNaK2VXeXZSWUlBeHExMmNBdkxNL0JvSm5YODVhNEZzSDRrTllacmFHWWtZ?=
 =?utf-8?B?dHFpWWZWdkxhSjBSVi85TEVDSUEzRXU0bi8xVGpITUdKUktiZEoyS1Fud0o3?=
 =?utf-8?B?Vklmc3Q5cU1ZOWVlME1UOG0rNXNwa2pCMmxBRGpzTG85SElQdGtqNUhUMXJy?=
 =?utf-8?B?SWJXcEdXWmxLa29tZFpTVUFUcXhkcHpHTGRBQko0K1NueWpZbDJ1OVdJRERZ?=
 =?utf-8?B?aVRLaWNvYXZQQzZsTzllakZ3N25BYmw0T1RCQ2hhZkRpcThEUWlLWDVpWkJX?=
 =?utf-8?B?eDdsZWZqQnZtM1pZcm40Q0xaSkcvRGVxeWhYUEtEeFN2bzBFZlN3R3kzZzlz?=
 =?utf-8?B?L0JFUGp6OXhPT3VHWFFYZ0ZGZjlZTURXdFJhQ1RTSjFRYTZMb3BIWGJyK1Uw?=
 =?utf-8?B?N1RUT2l5VXlhNHViWXN4MVlNNlRwYlBTTVpRdW1nQ2FNQnlUUEFMbkQwM2Zp?=
 =?utf-8?B?VnlzYVMzd3ZYMXNxckxMbUV2T084RERFb2hiUFAvd1dXOEdjT2YxZVIxMmpn?=
 =?utf-8?B?azJ6VUlBVzM4UllDTG8zZktsUDNERXljeFdkbU9jV0Y1bW5tVmEvUXhsSnZL?=
 =?utf-8?B?T3JNQ2ZpN3ZHd290V1pvU1RPZFFlRmZDblFaR3BTYnM5T2FxclpaVjM4SjR2?=
 =?utf-8?B?UFRYUm1pSEhLWnR4SUJJODhxaVhLQThXSTU2R0lGbjN0QmtUMlZZVWJYcEo0?=
 =?utf-8?B?cHhPUit5R21kOHRvVERBOElCcG1na3Z6VXNsYTJqMXlmTXczY0I0c3FBVUlm?=
 =?utf-8?B?QmpJVVAvSXl2TCt6eTFqeEkyeDNCYkR6dXFMY3NzcHQ4Y1c4V2xFU01FMVBt?=
 =?utf-8?B?aWttOFZxUG5US1dMSWNZbkNvT0E1RVpIR2ZBNldSR3VDeURvMGpZUml6a1VY?=
 =?utf-8?B?aHB3SzBhM0RybWVIZlJuWThxNnhJdEJ4MXhjUlJlZDQxN0FCYkVraUFubnhM?=
 =?utf-8?B?eHhnQTJaYWtLR3R6ZSs4SzhhcDJGc0xMSjFnT1RtQ3laUWQ0SWJXUUhLc2JD?=
 =?utf-8?B?dytSclZYWG5oSUh6R2psdDZQOWgxSHVzSUdRb01QYytKaWw3REx6WTdCMGY2?=
 =?utf-8?B?UDBXUzdqcVNvNjJVT3BRRm00bVdOZktaSTJ3V2R1V1pxL3o2ek5kd3FnRGRZ?=
 =?utf-8?B?bGNFSVNYSUdNbnQ4bUY4NGJVNXdNYzBMSkVTUG5CRUd4NFFHQk1KYnlLYnln?=
 =?utf-8?B?RDhZVjJwMSt2TkZqRVY3L29IMTFTdGZOM0xGWWRnSHdndEpmeGVlMFhFMHBh?=
 =?utf-8?B?S25Mc0MwNmUzNlRPT1Y2bWxmMWVzWGQ1aEpBeW9iQWdzK2dPaXNsY0dDSTlu?=
 =?utf-8?B?dXlHTC9PL1dWUDliR080RDFtMnNXcksraFcvUkhscVlBVHhQWVkxdmJ1cXdr?=
 =?utf-8?B?ODdselM4MjZJOXZwTGFhRWpTN0R2dUVWK1U4cExGOWZrWkdtTGdIQ1BZZStN?=
 =?utf-8?B?eTkxUUVya2UyeWFBSXlVM1N1TXFiakYvd3FNakNVUDc5QzY5UVpjU3lRNXFX?=
 =?utf-8?B?VXYyMWhPM01lVGxHbHRmYklnTU8yM0RJRzNFWjVBdmJlUit0OWlNVFlYdDN0?=
 =?utf-8?B?OEhraVRPZzl5RWI2S09jWml2ZmZHVkNTK2g2RTJDNTJNRzNzVVBQNlcwRG5N?=
 =?utf-8?B?UkZ2bDYvRjlqb0h4WTZoVGN0OTVLYmZaUGZhOTBYQTdLNlJaSmp0YndpY1Jx?=
 =?utf-8?B?bzVVY3lYU2EzUE5mRHhBUWFpWHQ1UDdaSlJ6cGxCN1kzY2dOS2wzam9WMWlT?=
 =?utf-8?B?UC95aU5aNHgzbUZ4QlZsY0oyRTZ1d0NkeWpJN24wM09mcTRhMDJXb3FhdWJi?=
 =?utf-8?B?bG50bWxnUUtseUtrZ2trV1JPeXcrd05oYWdzWWZKd3lha3FhSVRQZFZvbytL?=
 =?utf-8?B?MVRMaUgwdzhMVnJCNE4vRjNIWUJQTXkwdVJYaytLVitaMXpEbDFSL2plbDQ1?=
 =?utf-8?B?MHIrSXZDaU9KZ1FhdkpKWXo5MUNEa1c1eEplNS84ZkIvNzIwZ2gvU3IwVTA5?=
 =?utf-8?B?RjNVSnMraUtaWVNFRUYyVzFlQ0FQYndHUXlJQnRGU0V1RnlidmRrdFVtY1I3?=
 =?utf-8?B?Ti9wcHlnVWFWWExGbjFNWUwrbHpxTlkycEdHSk91VENpOGYyRGFsSnhIekRX?=
 =?utf-8?B?VzlXenVjS1RZTGZlUExCNkZCTDFZYWR6NWplOTYvcnNLcC9pNHZJTHZqVTE0?=
 =?utf-8?B?MWhiczZpaEpUSjg4REthVUdmSHV2Zms0NlRqS3BieVIrVEV1THZMUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	WyypeFU2jvBaRNIv8oWZ1rCLXK1BRi3oFvRLcAh8lNWhNrAcQCLKSDqtK5DY/4v2kJmgSXFgkT6Oe6cYfk5RpAkBf12Qs0YUsdy4mkd+G5MXnQkpnzHpgR/Z8gkDBkiBgK5n/vFs2wcDu6ek2Lfh7sOpHnVkwiObtv/UijrynJxAcRNmVXdpgfU9H+E2RcZB52KjHZ2oZP0gApsPw0VBVfuaR4GFHRFZs42rVw1DQIDhkaR8v3UaKjjTdws6gyWSFHPHbIn1z/IbDdILn29W8EO+JmSvbPu9EivauIcEfndF7m4D7gL0zR8/pn8yRY/NhCdW1kYE1ozRg8EbGi4Feg==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6SPR01MB0090.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40aa5f35-6e35-43c7-3ff6-08de833f6338
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2026 09:35:40.3789
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SzYBVGp44rTFq6+xvPmgXdp40U/kZEK9D0Tw75pEoI6bj98oPw8WVK8GIRo8Hn16GsN/Bkdnqi4uvBd/j5JqyoHyPl6AKz8tQ09o6M73LWU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR03MB5857
X-Authority-Analysis: v=2.4 cv=etTSD4pX c=1 sm=1 tr=0 ts=69b7cef0 cx=c_pps
 a=k0sZSnccHBAUCD1Alv6C+w==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=_jAD5XSDOtq9-5Nde2OG:22 a=uherdBYGAAAA:8 a=VwQbUJbxAAAA:8 a=gAnH3GRIAAAA:8
 a=IpJZQVW2AAAA:8 a=8b9GpE9nAAAA:8 a=XftZAXiPTpM5TKSzaKcA:9 a=QEXdDO2ut3YA:10
 a=IawgGOuG5U0WyFbmm1f5:22 a=T3LWEMljR5ZiDmsYVIUa:22
X-Proofpoint-GUID: J3vkU2g-BNq8UChGr3wlt8QxoV15u_dL
X-Proofpoint-ORIG-GUID: J3vkU2g-BNq8UChGr3wlt8QxoV15u_dL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDA3MyBTYWx0ZWRfX6S6A04F7G2rD
 APRhuL9JuOTHEkY/nCDfn/1y0bvpK7nXZiMu4XR9ybvgb0bzBnC7mMUtJWa60L9fzsedefW7ylt
 i0uGe7gl2cd6kluVwpHvq7tdztCLYOi6pQwvB0cAPWfuf7gHZ6T/ElA6t8gsxi9qjJar43B3ngZ
 eYY0GKQtPZNndzQZJCGpzRTq5jiGAbdLmr04VPvb3GuP9NOXAWnrIRgtB5DQ2qyukDAo8S/kAMH
 R+d2TEdoJMfiEWXOIXq/xhc0h47l/lIxvEtzRUlZ82MC9ed0MOa5LRGR0/zvrjL3JS+9pVLHJQJ
 SAdbxHE94bqUB35zk9kkLraqYOCjxRsCWE4+0lqJHb+T69Kzp3XOjeLwX97dTuXlUupRJa2o/9L
 Zhzp5uph8OhJSETrnvbG/OotWIDS409D8Md64Ohp727I4FEyAfSg1sYu69CrdswniurqK/Wgmyy
 QbC7FO5N2UxqzbHW7AQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_03,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 clxscore=1015 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 impostorscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603160073

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBKb25hdGhhbiBDYW1lcm9uIDxq
aWMyM0BrZXJuZWwub3JnPg0KPiBTZW50OiBTYXR1cmRheSwgTWFyY2ggMTQsIDIwMjYgMTo0MSBQ
TQ0KPiBUbzogTWljbGF1cywgQW50b25pdSA8QW50b25pdS5NaWNsYXVzQGFuYWxvZy5jb20+DQo+
IENjOiBMYXJzLVBldGVyIENsYXVzZW4gPGxhcnNAbWV0YWZvby5kZT47IEhlbm5lcmljaCwgTWlj
aGFlbA0KPiA8TWljaGFlbC5IZW5uZXJpY2hAYW5hbG9nLmNvbT47IERhdmlkIExlY2huZXIgPGRs
ZWNobmVyQGJheWxpYnJlLmNvbT47DQo+IFNhLCBOdW5vIDxOdW5vLlNhQGFuYWxvZy5jb20+OyBB
bmR5IFNoZXZjaGVua28gPGFuZHlAa2VybmVsLm9yZz47DQo+IFJvYiBIZXJyaW5nIDxyb2JoQGtl
cm5lbC5vcmc+OyBLcnp5c3p0b2YgS296bG93c2tpIDxrcnprK2R0QGtlcm5lbC5vcmc+Ow0KPiBD
b25vciBEb29sZXkgPGNvbm9yK2R0QGtlcm5lbC5vcmc+OyBPbGl2aWVyIE1veXNhbg0KPiA8b2xp
dmllci5tb3lzYW5AZm9zcy5zdC5jb20+OyBsaW51eC1paW9Admdlci5rZXJuZWwub3JnOw0KPiBk
ZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0K
PiBTdWJqZWN0OiBSZTogW1BBVENIIHY2IDAvNF0gaWlvOiBhZGM6IGFkNDA4MDogYWRkIHN1cHBv
cnQgZm9yIEFENDg4MCBkdWFsLQ0KPiBjaGFubmVsIEFEQw0KPiANCj4gW0V4dGVybmFsXQ0KPiAN
Cj4gT24gRnJpLCAxMyBNYXIgMjAyNiAxMzo1ODo0OSArMDIwMA0KPiBBbnRvbml1IE1pY2xhdXMg
PGFudG9uaXUubWljbGF1c0BhbmFsb2cuY29tPiB3cm90ZToNCj4gDQo+ID4gQWRkIHN1cHBvcnQg
Zm9yIHRoZSBBRDQ4ODAsIGEgZHVhbC1jaGFubmVsIDIwLWJpdCA0ME1TUFMgU0FSIEFEQyBmcm9t
DQo+ID4gdGhlIHNhbWUgZmFtaWx5IGFzIEFENDA4MC4NCj4gPg0KPiA+IFRoZSBBRDQ4ODAgaGFz
IHR3byBpbmRlcGVuZGVudCBBREMgY2hhbm5lbHMsIGVhY2ggd2l0aCBpdHMgb3duIFNQSQ0KPiA+
IGNvbmZpZ3VyYXRpb24gaW50ZXJmYWNlIGFuZCBMVkRTIGRhdGEgb3V0cHV0LiBUaGUgZHJpdmVy
IHVzZXMNCj4gPiBzcGlfbmV3X2FuY2lsbGFyeV9kZXZpY2UoKSBmb3IgdGhlIHNlY29uZCBjaGFu
bmVsJ3MgU1BJIGFuZCByZXF1aXJlcw0KPiA+IHR3byBpby1iYWNrZW5kIGluc3RhbmNlcyBmb3Ig
dGhlIGRhdGEgaW50ZXJmYWNlcy4NCj4gPg0KPiA+IFRoaXMgc2VyaWVzIGluY2x1ZGVzOg0KPiA+
ICAgLSBVc2UgX19mcmVlKGZ3bm9kZV9oYW5kbGUpIGZvciBhdXRvbWF0aWMgY2xlYW51cCBpbiBp
aW8gYmFja2VuZA0KPiA+ICAgLSBSZWZhY3RvcmVkIGRldm1faWlvX2JhY2tlbmRfZ2V0X2J5X2lu
ZGV4KCkgZm9yIG11bHRpLWNoYW5uZWwgYmFja2VuZA0KPiBsb29rdXANCj4gPiAgIC0gRFQgYmlu
ZGluZ3MgdXBkYXRlIGZvciBBRDQ4ODANCj4gPiAgIC0gRHJpdmVyIHN1cHBvcnQgZm9yIEFENDg4
MA0KPiA+DQo+ID4gVGhpcyBzZXJpZXMgZGVwZW5kcyBvbiB0aGUgU1BJIGFuY2lsbGFyeSBkZXZp
Y2UgcGF0Y2hlcyBhbHJlYWR5IHBpY2tlZA0KPiA+IHVwIGluIE1hcmsgQnJvd24ncyBTUEkgdHJl
ZQ0KPiAoaHR0cHM6Ly91cmxkZWZlbnNlLmNvbS92My9fX2h0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcv
cHViL3NjbS9saW51eC9rZXJuZWwvZ2kNCj4gdC9icm9vbmllL3NwaS5naXRfXzshIUEzTmk4Q1Mw
eTJZITROZzZKUzNjaUJQR3dIalYtDQo+IEthaDBrVTlhZk9MTE5QdVV5RUhrZzg5NjN2UVY5eE4z
Q0ZabGZ6T1hoRExFVGIwb2gtLQ0KPiBPTDVhcDlWdllnYzJNUSQgKS4NCj4gPiBBZGRlZCBiYXNl
LWNvbW1pdCBpbiB0aGUgY292ZXIgbGV0dGVyIGJlbG93Lg0KPiA+DQo+ID4gRGF0YXNoZWV0OiBo
dHRwczovL3d3dy5hbmFsb2cuY29tL21lZGlhL2VuL3RlY2huaWNhbC0NCj4gZG9jdW1lbnRhdGlv
bi9kYXRhLXNoZWV0cy9hZDQ4ODAucGRmDQo+ID4NCj4gPiBDaGFuZ2VzIGluIHY2Og0KPiA+ICAg
LSBNb3ZlIGZ3bm9kZV9iYWNrIGRlY2xhcmF0aW9uIGJhY2sgdG8gaW5saW5lIHBvc2l0aW9uIGFi
b3ZlDQo+ID4gICAgIElTX0VSUigpIGNoZWNrIChwYXRjaCAyKQ0KPiA+ICAgLSBSZWJhc2Ugb24g
dG9wIG9mIGJyb29uaWUvc3BpIGZvci1uZXh0IGFuZCB1c2UgLS1iYXNlIHRvIGRlY2xhcmUNCj4g
PiAgICAgdGhlIFNQSSBkZXBlbmRlbmN5IChjb3ZlciBsZXR0ZXIpDQo+IA0KPiBPay4gR2l2ZW4g
dGhlcmUgd2FzIG5vdGhpbmcgaW4gdjUgdG8gaW5kaWNhdGUgYSBuZWVkIHRvIGRvIGEgdjYNCj4g
eW91IHNob3VsZCBoYXZlIHJlcGxpZWQgdG8gdGhhdCB0aHJlYWQgdG8gc2F5IHlvdSB3ZXJlIGRv
aW5nIHNvLg0KPiBUaGUgZndub2RlIHRoaW5nIHdhcyBzb21ldGhpbmcgSSBzYWlkIEknZCBmaXgg
dXAgd2hpbHN0IGFwcGx5aW5nLg0KPiBUaGUgU1BJIGRlcGVuZGVuY3kgd2FzIGEgJ2RvIGl0IGJl
dHRlciBuZXh0IHRpbWUnIGNvbW1lbnQuDQo+IA0KPiBJJ3ZlIGRyb3BwZWQgdGhlIHY1IHZlcnNp
b24gSSBhcHBsaWVkLiAgTm93IHlvdSBoYXZlIHF1ZXN0aW9ucw0KPiB0byBhbnN3ZXIgZnJvbSBB
bmR5IG9uIHRoaXMgb25lLg0KDQpJIHNhdyB5b3UgYW5zd2VyZWQgYWxyZWFkeSBzb21lIG9mIHRo
ZW0uIFRoZSByZXN0IGFyZSBzb21lIG1pbm9yIGZvcm1hdCBzdHVmZi4NCg0KU2hvdWxkIEkgd2Fp
dCBmb3IgdGhlIHY2IHBhdGNoc2VyaWVzIHRvIGdvIGZyb20gIk5ldyIgc3RhdGUgdG8gIkNoYW5n
ZXMgUmVxdWVzdGVkIiBiZWZvcmUgc2VuZGluZyBhIG5ldyB2Nz8NCg0KSSBkb24ndCB3YW50IHRv
IG1ha2UgdGhlIHNhbWUgbWlzdGFrZSBhcyBJIGRpZCBmb3IgdjUtPnY2IPCfmIouDQoNClJlZ2Fy
ZHMsDQo+IA0KPiA+DQo+ID4gQW50b25pdSBNaWNsYXVzICg0KToNCj4gPiAgIGlpbzogYmFja2Vu
ZDogdXNlIF9fZnJlZShmd25vZGVfaGFuZGxlKSBmb3IgYXV0b21hdGljIGNsZWFudXANCj4gPiAg
IGlpbzogYmFja2VuZDogYWRkIGRldm1faWlvX2JhY2tlbmRfZ2V0X2J5X2luZGV4KCkNCj4gPiAg
IGR0LWJpbmRpbmdzOiBpaW86IGFkYzogYWQ0MDgwOiBhZGQgQUQ0ODgwIHN1cHBvcnQNCj4gPiAg
IGlpbzogYWRjOiBhZDQwODA6IGFkZCBzdXBwb3J0IGZvciBBRDQ4ODAgZHVhbC1jaGFubmVsIEFE
Qw0KPiA+DQo+ID4gIC4uLi9iaW5kaW5ncy9paW8vYWRjL2FkaSxhZDQwODAueWFtbCAgICAgICAg
ICB8ICA1MyArKystDQo+ID4gIGRyaXZlcnMvaWlvL2FkYy9hZDQwODAuYyAgICAgICAgICAgICAg
ICAgICAgICB8IDIzMCArKysrKysrKysrKysrKy0tLS0NCj4gPiAgZHJpdmVycy9paW8vaW5kdXN0
cmlhbGlvLWJhY2tlbmQuYyAgICAgICAgICAgIHwgIDYyICsrKy0tDQo+ID4gIGluY2x1ZGUvbGlu
dXgvaWlvL2JhY2tlbmQuaCAgICAgICAgICAgICAgICAgICB8ICAgMiArDQo+ID4gIDQgZmlsZXMg
Y2hhbmdlZCwgMjc4IGluc2VydGlvbnMoKyksIDY5IGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4NCj4g
PiBiYXNlLWNvbW1pdDogMmNkMzk3NGI5YWU1OWFjNzMxYTQ3OTJlMTYwOGJlMzI2MjFiNmU5OA0K
PiA+IC0tDQo+ID4gMi40My4wDQo+ID4NCg0K
