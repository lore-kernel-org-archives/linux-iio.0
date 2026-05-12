Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B549213E89;
	Tue, 12 May 2026 11:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778586942; cv=fail; b=T+5z2Jnv92Alr592EzcQBT+JZrPwtCT5RBmS8bi0ugTky8tlwQZLgVLiEW4keK66Okx/znaqF7TYHqIQrvupTPWj0rZXq80xV8MSryyWk+0dpnRhgM0h8BT2XPZz/kt73ipMZyKrIJKUNpZ/XRhssGxgSem7amrQBlWb75E5Dro=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778586942; c=relaxed/simple;
	bh=4t9zUV4m3MkI1MuhCuc26XPOKdL0JhQ6pB9zLIOCFCU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fZ4SQevK351/fpcQLdmN8sSEHl+WtZfHdWWM+pFET5Xm+CFkEcs9sbVvqZX6C1ZdGaWSl1nxpYDYDlO4myjTDOHg/DPBP+7o348XI+4aVdU/6m3FHMUpvs429R5yuHn7EI8K59bSKG8jAIBjJpwFMyyuCpzo0FHJyxcjfQb12dc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=Hej9/4jb; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="Hej9/4jb"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64C8xsFc883382;
	Tue, 12 May 2026 07:55:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=4t9zU
	V4m3MkI1MuhCuc26XPOKdL0JhQ6pB9zLIOCFCU=; b=Hej9/4jbmtVBbfFiGhR8j
	gO2KCkJfWzIGcMTRIar2kxn4x8kuhadIXvblHMlMqwEiOH1J1Aqil51T0KzBcEi9
	6R/c3ph2HUFJXaa6We9HKTYLGh1zsdetSiiY6pfl5NoohOihGZIsiiLbf2dkADHT
	O9Xj3caipqYVDbB9EFTvJv1p7BK3wqSjHABiQYNNCW8+cUAusiA4iv3E7sFMjFcB
	W+ZX/G4WsUAFOzqXdbMAqVJXqfY8CVyI9DRSpyz52jG4/YW+KhV2R22nHc9geufC
	uryRB2qyBw5EkWhGePZD+fGrEMz4jKfmsm0Uf+aGIBmHCmZ69+9+ZMOa8CUkyHzN
	A==
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013063.outbound.protection.outlook.com [40.93.196.63])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4e3nw6ar4p-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 12 May 2026 07:55:25 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UwlYKRoxDNQv0y8nwBPVCYHEpfM4NIBeRpb9E8s8G3s6lh/iyYWX+yP1t1FqueQPIa/AbNudqs8RZz3xGXYW3BzSW4UwNFLZgKPoYLXXU8eqQ9OvJ0ItIE57ppBK8SJxJ0rxP66xqroQnkSjoAwIVNTE6cfezlf4qXO0y8TMMczr3pxpUC+zWmwQTUGyw3oOj58Jh/Uu2SZcKku7vs7KEdWOLdOcF3LHQVjbIimiCXXTyVD6mLIiJjcZNozYKC8PM1eOwZY93IOQONs3TGBxZlxBFTfOlEd9nD1ehlgDa0dcAgThYM6kp56usfFuVgMsU8Y+CShl1JqWp31dHikuzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4t9zUV4m3MkI1MuhCuc26XPOKdL0JhQ6pB9zLIOCFCU=;
 b=F7Ve6vU+ItFk27z5n9dJTbtHEwyj0YGTca14uI/2RG5aFTwV0Q2bSIh8Y5pFT/+KP29e1ckM3BYEqd2iCvdxHhr6xwKIJXOJTkFxLRvnVT2loB2fUi53VdCRbyt1dzbGHSzXDh5aLPG77Sso97ZBH9nsX5wQNalCfjwypVZpfxqFOheNCVbpHBvk7oCgz42bIe3c07mJOyxIXDf0u69H4wLoai9iTseb+mnCouocBxp61bpytRh9aybAZCLdJPH6OUZP8vi87hft8PC8GtU4F0DflFk3hPrThGdr4nfP8EJRzG/iPnWWODuP4mirSM8HDk8GePsvz1irRurY7Birmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from SA5PR03MB8377.namprd03.prod.outlook.com (2603:10b6:806:47d::22)
 by CH0PR03MB6177.namprd03.prod.outlook.com (2603:10b6:610:d0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Tue, 12 May
 2026 11:55:21 +0000
Received: from SA5PR03MB8377.namprd03.prod.outlook.com
 ([fe80::9276:9909:1b4c:8438]) by SA5PR03MB8377.namprd03.prod.outlook.com
 ([fe80::9276:9909:1b4c:8438%6]) with mapi id 15.20.9891.008; Tue, 12 May 2026
 11:55:21 +0000
From: "Stan, Liviu" <Liviu.Stan@analog.com>
To: =?utf-8?B?TnVubyBTw6E=?= <noname.nuno@gmail.com>
CC: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "Sa, Nuno"
	<Nuno.Sa@analog.com>,
        David Lechner <dlechner@baylibre.com>,
        Andy Shevchenko
	<andy@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/2] iio: temperature: ltc2983: Add support for ADT7604
Thread-Topic: [PATCH 2/2] iio: temperature: ltc2983: Add support for ADT7604
Thread-Index:
 AQHc1kn/5d/Hh1H9DE+/jMXiSvhLvbX0U6uAgA5CZsCAAVTVgIAAIEGAgAAYMKCAABGiAIAADdZQgAAbwgCAAXn1AIACljLwgABUcgCAAArCQIABVv6AgAAduqA=
Date: Tue, 12 May 2026 11:55:21 +0000
Message-ID:
 <SA5PR03MB837758532C0007A97121F6CCF6392@SA5PR03MB8377.namprd03.prod.outlook.com>
References: <af2no3bJA9MSjXvV@nsa> <20260508121441.39ad9f65@jic23-huawei>
 <SA5PR03MB83778AB3C41E0AF56EC754F8F63D2@SA5PR03MB8377.namprd03.prod.outlook.com>
 <af3oezNmmBhI4Yu4@nsa>
 <SA5PR03MB837710AE7FD8B8FFF138B7C5F63D2@SA5PR03MB8377.namprd03.prod.outlook.com>
 <af4LCQiqNaiMzFkX@nsa> <20260509154600.02e2d11a@jic23-huawei>
 <SA5PR03MB83770D945E92C40A74D9C0DAF6382@SA5PR03MB8377.namprd03.prod.outlook.com>
 <20260511121820.3be9e635@jic23-huawei>
 <SA5PR03MB83772A1A57DC052CB21B9187F6382@SA5PR03MB8377.namprd03.prod.outlook.com>
 <agLhb-S2ISSjaopc@nsa>
In-Reply-To: <agLhb-S2ISSjaopc@nsa>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA5PR03MB8377:EE_|CH0PR03MB6177:EE_
x-ms-office365-filtering-correlation-id: 40a6bcdd-153b-4eba-f1e6-08deb01d5856
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|1800799024|376014|366016|11063799003|38070700021|18002099003|3023799003|22082099003|56012099003;
x-microsoft-antispam-message-info:
 ahS0HI2EVprb+58MhFVcN7r++SGPCBv4nlwUyQYU/IyNFHgrESrKBgCA5VwBKasiNCwHsZr0khAzoBEBqEzX7LonLTfPuFzbIBqaXfbCyymt13VY4DThUV6BkpZAd3epcwKNm8Fx9RpJOkGAylcaImRTIddbB52vzwYpy5zrPG2h3QjvJsrw7/u56H79RLu1wnmcXjuNQg1YK8W7TBcbLrtjUyBq2u/vahpx+FaGaNPQWhZPUAAMZcD1jUyNbq6mHrhWZPeW/KYelNzYLWVYeJ2ky2rne/2Z1tLKlsEH8OJhururhwjY14Bf5tTQnX56YE/WYM7hhxJVQS/6mPfKTFdmVk+7NiLpHjHFppQRyOVkU2FusZdsJVWQ2zmrdqh2ZudcsDTSxDcm/D8DqhcVOKDJzOHeWxgsr6ZqFJVKMQDikgodUyTWOJW1TQBpTpTCAUKsHbVvZXONE9XmIsk2KmVfsBRfFLKTM5ALpnKS15zYR19tj4Ps+/TDGFmLrR/bEcb9hFiNhqW87YXQV/uvo6I1Udw1YaRzrlG/DTRxLH4uSWImFy9cIb1PeSpvx7ZCEsMSpZGkpdi4OjKUx4pXQExbzho56yoXbsWLyVTKcIa02c///mmzh+rOU5WnZrHDlOo7rsA8z6vj8Cdi187cql8IyW9pOjWxfnXP7GDH8Y85naveohSLEbKnsDFWV665Wvp0RdxjExU3/TOnhTZaKvgpW+HB++yaQxqxHs+2HbDnPZGGwEjR5gUVMUVFbtD3
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA5PR03MB8377.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(11063799003)(38070700021)(18002099003)(3023799003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SjAwZUkwVWs0YWovZkZqejFMSWtYYmFpSEwxT21WcW1odGZFeGNPeWtBNEY4?=
 =?utf-8?B?Zkw3MGRRbXRvc3V5U2lSZkdWaGQxeU90ajhRN3phcWhJa2ZoMnd5OG5IbmRl?=
 =?utf-8?B?ZkNVbW5uRGQydkVJd2N4aGwwdWsyU1F3eEltZktWS1dYa1pJMDNtRVhKWHFK?=
 =?utf-8?B?emVobUxkMHZWb1JWYXMxNDdvNkt5YzM0THNjV3VJRXRicjh4UFZ6Q0lobTBT?=
 =?utf-8?B?UWs3dGx0MnNLNmxaWTN5amhEVGF1UTd5a3hlcFZ2Q1ZyeTg3eFI2QkxjY2tP?=
 =?utf-8?B?bm5pK2JZeTZGazk1U0ZhYUxuRUxoQWp4WnNabEtwWVpJRndtUWZxOFpNSDJz?=
 =?utf-8?B?S3FCS1FFanVXa3E3WEZCNW9QSWw5YkVYVGxlY0lZZVFFSThpOStKZ3grdDVL?=
 =?utf-8?B?TytYZGw5RjlSbGhJS1BBaGxjQXMweFc4Sjl1SDh4VTV0SkZ4ZjlvV3h2TUY3?=
 =?utf-8?B?aGdjUXJTZHZ4ZWlZL1RRSllveThKaWMreElGT21HQXRFRVUvM2hRbGY3WjV6?=
 =?utf-8?B?eW1CcFlKWTdCRVZkZllJQWZ1NE5xa0h4aDc4cW9iMlpURFdWdGUxMkR2MEtE?=
 =?utf-8?B?aXYyWG9QSXRObDhxM2huVTMrelAxMlh1VEpFNC9CWmQvRVhEbXJmTGFYWmR3?=
 =?utf-8?B?TllMZk54aU4yQ0ViS2I0bW5zNnlaMDZFTHUvY2Z5VVQrR0w0b1U0ZnlmL1dE?=
 =?utf-8?B?RFMzTWZwQ1hxMDkzcFhXdnFCWlBhMkpkbU9XL25TbDkxOSswODdHS3l5VFhP?=
 =?utf-8?B?THpKbVlORXl3bWRhakFXVzlGWXFDbEsvdTRaSExTZkt5UnBSblNtaTlhSEpC?=
 =?utf-8?B?UDNnWXpuM2tzdjBJa0l4RUFDd2kvcStTWjhUaW5HRlRycmJQWk5rc0NKT2Jp?=
 =?utf-8?B?eVJKV0xDK1l1RXI5bEM1dVJiekhCcGw3eklTcHJSV1ZTaEtPRFlhdUtpWHBn?=
 =?utf-8?B?R05Ccy9iVkNyT0JFSDhxMzJZMzlhSGpyTDVab0pKSXRIU3kveEEzNmo3UTlP?=
 =?utf-8?B?dWMrY2RjbWszWThOakFWNzVKR2lEdUF5b2xYbFRsUzRTZFdycklibHdCZ0tG?=
 =?utf-8?B?aCtvTC9OaHM2VnVaYlhVbVUvUTYwZ0N0WWpRZEl5VU4yeDY0RWh3V0pCUFQz?=
 =?utf-8?B?MlRKcWxBcGczQTFFQXhMU2Y0RzdDa1IwZUY5TjczVU5ybUF0dzV1WHVJeDdM?=
 =?utf-8?B?QXhFQnByNkswKzhxcnIzQ2NBT1Z4cDJZZCtHbmNQUW8yKy9UQnlCRS9wUlBY?=
 =?utf-8?B?QmpxdWNjVTN6enNJOGw2am9lbnRTUmlMMmxKQ0tGRVgvQUdyeGw4N21qRDd0?=
 =?utf-8?B?OEU4OUc4ampDTkk5NkZrSitRb2xWaXExM25xd2FBREI2M05UVmlDVTVhTmNv?=
 =?utf-8?B?dVFyTnJ5V2JZUTFYaWw4dGlFRlRvRkRBWGZ6dkg1WHR4ODJnYlFxL1k3VmF2?=
 =?utf-8?B?aFVxNlMwQUFBeXQzbVBpQU9CVFNQdVdDMjFaY3pWaVVjV2lKSlJlMEdURHhY?=
 =?utf-8?B?ZlFGSWVKekYwUVprYUFXcmdtQUx1NGZnRzlRQWlCVWRDZFpKSGlsL2hGaFh1?=
 =?utf-8?B?eWZIZ3Q1dU0xUm9SWFQvU0p3LzBZc0U2OVBVejdqSFhSNWw3SzlZdlhHUFFE?=
 =?utf-8?B?RG1mWVNNNXVSSnM2ck5nand1dEd5SW1FdXlZYnB5OEI1ZWI5VUxaTnJIUjBF?=
 =?utf-8?B?N0dTVkExVUxjekJYL3ZRZGY4N1FCOEVUdnBTc21KVVR4SGVZdS9KaWx2aVpL?=
 =?utf-8?B?Tnpka04wRGlNeEp4MVF1QTZWSE1VVWpRMXpvSjZSQVI1NDJ4RHpBU2VqZzRB?=
 =?utf-8?B?RVl5NHovS0hVRXVNNnF1a09zdzRDbUZZeWxuV1Q3dkp2VEZpMnB5TkJlWkxN?=
 =?utf-8?B?NmhJTUhYWVFvbFBhVFBST2NhcHJjVHduRE01Vm9IN1BwaVIxTTFFK3B4L0py?=
 =?utf-8?B?ZGhObGhsK3B5R3lySWp2WlZNL3c2b3lVS28wMzRSRWY0cjJ5K0FtWUVyT01x?=
 =?utf-8?B?MXlURUZzYU9KNmcxT3Q0dVVyZTFwNVNRUnR1V2sxdU4yQitXWkRyU1VVWmFm?=
 =?utf-8?B?SzdITU1lUldhZFhXVFV1TWxCdnBGd0Q4OVM1cmdkLy9OMHJDOWZVM3MxUzBG?=
 =?utf-8?B?UUtGYWhOcjg3ZDE3d0dMQzcvOFRhWjBKR1EzVGNjTFlGY1BhR1dPcWRlWlR4?=
 =?utf-8?B?eFNpaDhwcDVNWFhuMnAwTzlNRTJsYkh3S1haUUNGdyt1MS85MWdDZnNyZ2tV?=
 =?utf-8?B?Y3A2SUNKMUJXTWRmNjBTbklvTjNDYzRQU2hnZVVYWlA5ajNNUFRDb3RxdHR2?=
 =?utf-8?Q?BmQfBE1+u4fEEB5l6I?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	ONEHEHdQjrvYNvA/gcHRzj7foEBsHHGbMh0ObbuGbRAy6kwSmQgDA2nnvGgd+yyWhw+vZI85waA+eSEU9U4u8q+jh/4vzNtkIGp/VaVshQ79+YZdnqtOTPz2GS6fbZodOuQPXexQFUJQxTlsRqr8TWQNaOoZJJ8to93fb63RnCbevxtYrItt/xbC8xamzW2jdOguLaQ5+nx2XgRNAdXSQzzVsVNhNKkwj7k2GM0S/u8E+7UTVep189h1fUYvU4g6ltSFTFe0jFi3xzpgGHVH0vMtsCnEXm5igXSsT4K+Lt7ScpUf0l0VKC7POtZbTWrhs6zRK0lMjCTVgpxh3kmrHg==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA5PR03MB8377.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40a6bcdd-153b-4eba-f1e6-08deb01d5856
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2026 11:55:21.5578
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LAk1W8YuKIdvSA7k9N0x1J4OzhTt8ErIuq6ziIw6pI6+kubnD7baqJEUKkUaFvGEpXOQm71uX3OwOP//CVoQiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR03MB6177
X-Authority-Analysis: v=2.4 cv=VIbtWdPX c=1 sm=1 tr=0 ts=6a03152d cx=c_pps
 a=VUNJaWZlx74G+l0QYBOIDQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=Z0pTeXoby7EwIRygza74:22 a=G6SaHyqcNN2AYENkPeQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDEyMyBTYWx0ZWRfXzK1vxRRi9W/v
 92KyO3FvUFYBncZ5vEQxH5ydyje5FJhz72nzk6sPyawgBNr450iTc/jVlom8Htp5yy7/fCIAHPY
 VtkAkRkAIuoOXNsZojAf1XRJeXV6SBWrt/LX0fPZ452lpmoTkrZ93gAXTN3fyPTuHiLAaK53pX9
 t6ZdEtkBW90Z76PmPABh4rdbLutUv5erGzrOq+0XjLDbIl7zt5a+aQXw5ayeTSyxweFYoervot6
 w6y54Z3B/zYa2uskX7wfMJ4GtrjwUW4ZplzTy5E+s7Q+Zj8ecCyReXdN+WdDt2Fyn0fV89Q7X65
 Dz6uBRnYPIPzb/vHtas2F0oOI5ueododtCHkZ+OeUzPdipkUC0kVvapUoYExaSeFvt4gXXWC6hD
 9VZcWNTHyNWyHfQ2hLKalcQ7alVOZoGf0QPpxF2Sy1XvlL/zoOh4ZkzK4qenO68zvcDpgi8cSBW
 h+hZyV8bPFrcgyvILuA==
X-Proofpoint-ORIG-GUID: bFuSAijrgEs3JqNMcqm9_VEl_cdeV6yo
X-Proofpoint-GUID: bFuSAijrgEs3JqNMcqm9_VEl_cdeV6yo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 adultscore=0 clxscore=1015 malwarescore=0
 bulkscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605050000
 definitions=main-2605120123

T24gVHVlLCBNYXkgMTIsIDIwMjYsIE51bm8gU8OhIHdyb3RlOg0KPiA+ID4gPiBUaGUgY3VycmVu
dCBhcHByb2FjaCBwcmVzZW50cyBpdCBhcyBJSU9fVEVNUCBzaW5jZSB0aGUgY2hpcCBvdXRwdXRz
DQo+ID4gPiA+IGNvdmVyYWdlICh1c2luZyB0aGUgY3VzdG9tIHRhYmxlIGludGVycG9sYXRpb24p
IHZpYSB0aGUgdGVtcGVyYXR1cmUgDQo+ID4gPiA+IHJlc3VsdCBiYW5rLCBub3QgdGhlIHJlc2lz
dGFuY2UgYmFuaywgYnV0IEkgYWdyZWUgYSBuZXcgY2hhbm5lbCB0eXBlDQo+ID4gPiA+IG1ha2Vz
IHNlbnNlLiBTaG91bGQgSSBjcmVhdGUgYSBzcGVjaWZpYyB0eXBlIGxpa2UNCj4gPiA+ID4gSUlP
X0NPVkVSQUdFX1BFUkNFTlQgb3Igd291bGQgYSBnZW5lcmFsIElJT19QRVJDRU5UQUdFIA0KPiA+
ID4gPiBiZSBiZXR0ZXI/DQo+ID4gPg0KPiA+ID4gRm9yIEFCSSBwdXJwb3NlcyB3ZSBkb24ndCBj
YXJlIHdoZXJlIGl0IGNvbWVzIGZyb20uDQo+ID4gPg0KPiA+ID4gV2UgYWxyZWFkeSBoYXZlIHNv
bWUgJ3JhdGlvJyB0eXBlIG1lYXN1cmVtZW50cyBsaWtlIGNvbmNlbnRyYXRpb24gd2hpY2gNCj4g
PiA+IGFyZSBwZXJjZW50YWdlcyBhbmQgc2ltaWxhciB0byB0aG9zZSBJIHRoaW5rIHdlIG5lZWQg
c29tZSBpbmRpY2F0aW9uIG9mICd3aGF0Jw0KPiA+ID4gaXMgYmVpbmcgbWVhc3VyZWQgZ2l2ZW4g
aXQncyB1bml0IGZyZWUuICBIZW5jZSBJSU9fQ09WRVJBR0VfUEVSQ0VOVA0KPiA+ID4gc2VlbXMg
dGhlIGJldHRlciBjaG9pY2UgdG8gbWUuDQo+ID4NCj4gPiBVbmRlcnN0b29kLiBXaWxsIGRvIHRo
YXQgaW4gdjIuDQo+IA0KPiBJIGRvIHdvbmRlciBpZiBhIGNvbXBsZXRlIHR5cGUgaXMgd2hhdCB3
ZSB3YW50PyBIb3cgd2lsbCB3ZSBwcmVzZW50IGl0Pw0KPiANCj4gaW5fY292ZXJhZ2VfcmF0aW8/
DQo+IA0KPiBXaGF0IEknbSBub3QgdG9vIGNvbnZpbmNlZCBpcyB0aGF0IGNvdmVyYWdlIGlzIHJl
bGF0aXZlIHRvIHdoYXQ/IFdlbGwNCj4gaXQncyBhIHBlcmNlbnRhZ2Ugc28gSSBndWVzcyB3ZSBj
b3VsZCBub3QgY2FyZSBhbmQgbGVhdmUgaW50ZXJwcmV0YXRpb24gdG8NCj4gdXNlcnNwYWNlICh0
byBrbm93IHdoaWNoIGRldmljZSBpcyBkZWFsaW5nIHdpdGgpLiBTdGlsbCBJIHdvbmRlciBpZiBh
DQo+IG5ldyBpaW9fY2hhbl9pbmZvIHdvdWxkbid0IGJlIG1vcmUgYXBwcm9wcmlhdGU/IEluIHRo
aXMgY2FzZSBhcHBsaWVkIHRvDQo+IGlpb19yZXNpc3RhbmNlLiBTbyBzb21ldGhpbmcgbGlrZToN
Cj4gDQo+IGluX3Jlc2lzdGFuY2VfY292ZXJhZ2VfcmF0aW8NCj4gDQo+IFNvIGl0J3MgY2xlYXIg
d2hhdCBwaHlzaWNhbCBxdWFudGl0eSBjb3ZlcmFnZSByYXRpbyBpcyBhZmZlY3RpbmcuDQoNCkkg
c3RpbGwgdGhpbmsgYSBuZXcgY2hhbm5lbCB0eXBlIGlzIHRoZSByaWdodCBhcHByb2FjaC4gQ29u
c2lkZXIgY29wcGVyIA0KdHJhY2Ugc2Vuc29ycyAtIHRoZXkgYWxzbyBzdXBwb3J0IGEgY3VzdG9t
IHRhYmxlLCBhbmQgd2hlbiBvbmUgaXMgDQpwcm92aWRlZCB0aGUgY2hpcCBvdXRwdXRzIGJvdGgg
YSByZXNpc3RhbmNlIHJlc3VsdCBhbmQgYSB0ZW1wZXJhdHVyZSANCnJlc3VsdCAodGhlIGludGVy
cG9sYXRpb24gb3V0cHV0KSwgZWFjaCBpbiB0aGVpciBvd24gcmVnaXN0ZXIgYmFuay4gVGhlIA0K
Y3VycmVudCBhcHByb2FjaCBoYW5kbGVzIHRoYXQgd2l0aCBzZXBhcmF0ZSBJSU9fUkVTSVNUQU5D
RSBhbmQgDQpJSU9fVEVNUCBjaGFubmVscy4gU28sIGZvciBjb25zaXN0ZW5jeSwgaWYgd2UgdXNl
IGEgY2hhbl9pbmZvIA0KYXR0cmlidXRlIGZvciB0aGUgbGVhayBkZXRlY3RvciBjb3ZlcmFnZSBv
dXRwdXQsIHdlIHdvdWxkIG5lZWQgdG8gZG8NCnRoZSBzYW1lIGZvciB0aGUgY29wcGVyIHRyYWNl
IHRlbXBlcmF0dXJlIG91dHB1dC4gU2luY2UgSUlPX1RFTVANCm1ha2VzIHNlbnNlIGZvciB0aGUg
aW50ZXJwb2xhdGlvbiByZXN1bHQgZm9yIGNvcHBlciB0cmFjZXMgYW5kDQpiZWNhdXNlIGl0IGlz
IGEgZGlzdGluY3QgcGh5c2ljYWwgcXVhbnRpdHkgb3V0cHV0IGJ5IHRoZSBjaGlwLCBJIHRoaW5r
IGl0DQp3b3VsZCBtYWtlIHRoZSBtb3N0IHNlbnNlIHRoYXQgbGVhayBkZXRlY3RvcnMgZm9sbG93
IHRoZSBzYW1lDQpwYXR0ZXJuIGFuZCBjcmVhdGUgYSBzZXBhcmF0ZSBJSU8gY2hhbm5lbC4NCg0K
V2hhdCBkbyB5b3UgdGhpbms/DQoNClRoYW5rcywNCkxpdml1DQo=
