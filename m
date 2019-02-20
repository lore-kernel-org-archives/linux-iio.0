Return-Path: <SRS0=QBqV=Q3=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33F9AC43381
	for <linux-iio@archiver.kernel.org>; Wed, 20 Feb 2019 15:09:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC4F52086D
	for <linux-iio@archiver.kernel.org>; Wed, 20 Feb 2019 15:09:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="nFlY0J/f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726345AbfBTPJh (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Wed, 20 Feb 2019 10:09:37 -0500
Received: from mail-eopbgr740049.outbound.protection.outlook.com ([40.107.74.49]:41600
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726060AbfBTPJh (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 20 Feb 2019 10:09:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/ya1EoT22aJMmp9QzNnx7zY93y/1ywD62iJmj8WIKek=;
 b=nFlY0J/fxqrSbVKyjlpox5TQBgqVH+jN/2uUoGSFGtr+sfrtx3XdWdv0GXtpspDJ+AAw1huqCqdb0f1msw9hI+pVg4yAQwbRP0dmRYDEnZ4xrn3g6gFx63ZwJ2TCl6cy78x0KW/txuhzTmzdF1KxDiuC/1MNyICJdCNoIMmeUI0=
Received: from BYAPR03CA0001.namprd03.prod.outlook.com (2603:10b6:a02:a8::14)
 by BN6PR03MB3057.namprd03.prod.outlook.com (2603:10b6:405:3c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1622.16; Wed, 20 Feb
 2019 15:09:19 +0000
Received: from CY1NAM02FT031.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::208) by BYAPR03CA0001.outlook.office365.com
 (2603:10b6:a02:a8::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1643.15 via Frontend
 Transport; Wed, 20 Feb 2019 15:09:19 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.55)
 smtp.mailfrom=analog.com; metafoo.de; dkim=none (message not signed)
 header.d=none;metafoo.de; dmarc=bestguesspass action=none
 header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 CY1NAM02FT031.mail.protection.outlook.com (10.152.75.180) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1643.11
 via Frontend Transport; Wed, 20 Feb 2019 15:09:18 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id x1KF9HGT013767
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Wed, 20 Feb 2019 07:09:17 -0800
Received: from NWD2MBX7.ad.analog.com ([fe80::190e:f9c1:9a22:9663]) by
 NWD2HUBCAS7.ad.analog.com ([fe80::595b:ced1:cc03:539d%12]) with mapi id
 14.03.0415.000; Wed, 20 Feb 2019 10:09:17 -0500
From:   "Ardelean, Alexandru" <Alex.Ardelean@analog.com>
To:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "jic23@kernel.org" <jic23@kernel.org>
CC:     "lars@metafoo.de" <lars@metafoo.de>
Subject: Re: [PATCH] iio: Fix scan mask selection
Thread-Topic: [PATCH] iio: Fix scan mask selection
Thread-Index: AQHUySaWYdAOLuAwuku8IBObrwsAMKXpHgCA
Date:   Wed, 20 Feb 2019 15:09:16 +0000
Message-ID: <6180b059e9539efad985895483beae5eb67c20d5.camel@analog.com>
References: <20190220141403.11571-1-alexandru.ardelean@analog.com>
In-Reply-To: <20190220141403.11571-1-alexandru.ardelean@analog.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.50.1.244]
x-adiroutedonprem: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <E3EFE93B7386E642B43D48ED01603090@analog.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(39860400002)(376002)(136003)(396003)(2980300002)(199004)(189003)(110136005)(8936002)(2501003)(86362001)(106002)(6246003)(246002)(50466002)(7636002)(486006)(305945005)(36756003)(8676002)(2906002)(7696005)(7736002)(356004)(2486003)(47776003)(23676004)(76176011)(478600001)(5660300002)(118296001)(102836004)(436003)(126002)(426003)(26005)(476003)(72206003)(11346002)(446003)(4326008)(186003)(2616005)(3846002)(6116002)(316002)(14454004)(229853002)(106466001)(336012);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR03MB3057;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 03b118fb-6ade-4b50-4603-08d6974562bf
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(4608103)(4709054)(2017052603328)(7153060)(7193020);SRVR:BN6PR03MB3057;
X-MS-TrafficTypeDiagnostic: BN6PR03MB3057:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB3057;20:VzffPhhKq3hbPZ6g3x1jg6YB2QfsWsWPDZvigUtPrnqei6MgZJAl9XMuXKG1Vugnc1L35BihQAaX4fNCdbzkEoUHj9r/4x9NGeyf++tzXgckdXx5Hsq7d11Zw+Gcn1LWCj7DVb2x7v+4A0XQTfquPaV/pmBCWMXOdgYcFtl9BVsL1Wu8AvhGTP/FIcpnvRFgj9znCQGAeN+hdHhlbOOylotneL/4ADGV/6iwnW+8iS9BpPIlSgsL+sX0sejIAEh78Qr54cuPu2JC2lcy1kIVwLhfAeq2/a866L09RNm7sczGrJIF14MjxSpEflE9EsHmDD/SOKd2f+ULZk24u0VH6BzvoyYaQezfLfkPVZfdsNEsPfib7SCUZZR9Xmi5oP9LKt+jGtGu7JzOGrJDs0JbUX1Comn5q/rFsgMejGTmtwgzmrq2qbqtXmvLlOJQy+inWjzgMKrbcb8Tb9FhILQ2I4mMIDHdvKJ7ZBJ1xo/KB3cKh/RHS68V29ssSjyEKYN9
X-Microsoft-Antispam-PRVS: <BN6PR03MB3057C2977E757EE3D641305A957D0@BN6PR03MB3057.namprd03.prod.outlook.com>
X-Forefront-PRVS: 0954EE4910
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTjZQUjAzTUIzMDU3OzIzOjdLNjRGWlE3THFiMTJKTFcreEpEZFgvYU8w?=
 =?utf-8?B?NUV0RzVoUmpSN0lSV1V2eTExcXpwQ0NNVEprYUczNVlOMFV3SndmLzV5ZWlZ?=
 =?utf-8?B?NUpEbGZVMEY0blVkMDJvZVdzSm1iUFpyS0toazdYblRyb0NzR3N1d1pOT05W?=
 =?utf-8?B?eWl2c3A4Q3hnYkFZWTRwODRUVWpUN3p5dFloU3RCYXpRemxpMHZvMmVpWDRW?=
 =?utf-8?B?ZEsvcmRxZ2doNWtKd3h2djlMVytyTXVyTnNmYy9RNkx0Nk53UWpWdjNwV2xU?=
 =?utf-8?B?OExucENMeG82Q0Vzbk5JLzMzRWsvd1FOUG1wZ1lJVmlzQ2cwQXRIWDd3OFhE?=
 =?utf-8?B?M1Q1LzR6UGpKOU9FNHZmNlh0VG9JNGtsZGNJd1crcnV4Q0w1dmJXOGI0eWRM?=
 =?utf-8?B?eDU0dTViNGdES1ZEbU9lOGxyOUFnd0FOQ3dJaktXUzRKWXVnK2Z6THJEMkdQ?=
 =?utf-8?B?U3VVb21USkc2TmhyaWJMS2ZXN0tzQmRyeVpSVmNRVlRseFpYMWU3MEgyS0ti?=
 =?utf-8?B?bVp4NGZZOHRZcFl1aUVSVC9tTitqcHIxa0tLeXhEWjYzK0ZwalBGSjlqdUxx?=
 =?utf-8?B?dENHM09NcXpQNVJoU0EvaGR3aFFEdUY1L2lVVTcvZHdLVTQ2RE1JcXpZdGVY?=
 =?utf-8?B?Z0R3WDVFQlpSdHlsSUQ4d3BJNFhHLzErb2t5MUNzU3pNdnpTQzdIbTFGczlv?=
 =?utf-8?B?T1dJa1ZkTjFrQVZyOFFwMDB0djRFamllSzArWDV0a0M1SUVlY05yVmhldDhm?=
 =?utf-8?B?OUx0dU9YVElWUHI5V2N2c2Q0WjFmc1g5ck1JZzEwUUJNVVhMK0FuSFFEK2pV?=
 =?utf-8?B?YUJJdFdLUkJVcklnbFFla1RkcTk4c3F1dmpFbHdJVW05QkJyMFVVR01JZWlT?=
 =?utf-8?B?VUdsRlZRL2FGWktKbHdVWlp6NllaWWZrUVhlREZ5eFRjRUpYWFpidnNieW9L?=
 =?utf-8?B?MGZRV1JYVk0rZlZxTUczN080NWxQQTI4L2NPZmZqRU9LRy9UZWpSNEp4dUxn?=
 =?utf-8?B?RlRoRHc1RDVmZ2h0R3F6NDlMb1N3cHlKMzBIcXV1SldESE5IamRxR2JYblY1?=
 =?utf-8?B?RGowRVd2NVVTK2toSDFxdWYxNUljU0FSTWVTUTV2NXY0WHdKNkZUQVlJeWp0?=
 =?utf-8?B?ZXZrdXFpeHZHSHhMaXBPM0p4SjFIY2pCT0NTVnFSeDIyOGJuS3M0Ym13dlAw?=
 =?utf-8?B?NG8ya2FJWFBjZTZjV2U2TnB5RWp5amc1MVJYSXIvdXFnMXVWckQwdE1PR0xk?=
 =?utf-8?B?L1oxSHRIS2QvU3BoMGZ4QzQydHpkNFByTkMwck5kQ2RXbnorNVhXY2lVdjhr?=
 =?utf-8?B?YlJSdVViVWhLaUlNTThhbWlYaHhISmljNTdPWE5LVi9FVmhaUmJVQTVVTEw2?=
 =?utf-8?B?VlhmdUMrZUhMY3V6bDQrQk5CUTdxQnAyaklXWjd1TUdMWFg3QjdDMk5EcDBT?=
 =?utf-8?B?V09qWUc1SUpmUC9kak96QnFvMnRDK2dpZGFYWlV6Wm9oN2UwZHVYaVFiRXY4?=
 =?utf-8?B?SWlhdz09?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: 725o9r3+EKuHXqGTHSX2b1+vNEacVLsrG9a9SeJWw1+YVj3eG8G6Uc3NWYSVdizPDPPcfasS21ghpMWCayeSTbrUI8jlk2dTbVNgVx3U3G83lnsroYUVZoU+Ev8k6T8X6S04HKIYDHtnR7P45GkTJytLoSQOG778Fu0ykzLcJLCEZ8VB4IDKmZpCB0RawTQo6AAloxKhXog3joSg/XxpIBPr59nmsL6SgHttJiBUU//6g7irtZpEYtYwxZOSGyti2U/FchMeMgwL9ge3rx1sEXHDpdoUCm/z3ZEgJ8wtehELvfGKbr+RIGjqUzerN8qPunJLKo31i1EErzRxhAK9MtQhPDVr6WBDkncVb5Q0qgmiBcbWHvkg5ctABU8Lge1lmo/FQQoFgMW7WHEpPioiJNzr4mw/iCmPAWQI7EHpzQo=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2019 15:09:18.2061
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 03b118fb-6ade-4b50-4603-08d6974562bf
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR03MB3057
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gV2VkLCAyMDE5LTAyLTIwIGF0IDE2OjE0ICswMjAwLCBBbGV4YW5kcnUgQXJkZWxlYW4gd3Jv
dGU6DQo+IEZyb206IExhcnMtUGV0ZXIgQ2xhdXNlbiA8bGFyc0BtZXRhZm9vLmRlPg0KDQpJJ2xs
IHNlbmQgYSBWMiB3aXRoIHRoZSBGaXhlcyB0YWcuDQoNCj4gDQo+IFRoZSB0cmlhbG1hc2sgaXMg
ZXhwZWN0ZWQgdG8gaGF2ZSBhbGwgYml0cyBzZXQgdG8gMCBhZnRlciBhbGxvY2F0aW9uLg0KPiBD
dXJyZW50bHkga21hbGxvY19hcnJheSgpIGlzIHVzZWQgd2hpY2ggZG9lcyBub3QgemVybyB0aGUg
bWVtb3J5IGFuZCBzbw0KPiByYW5kb20gYml0cyBhcmUgc2V0LiBUaGlzIHJlc3VsdHMgaW4gcmFu
ZG9tIGNoYW5uZWxzIGJlaW5nIGVuYWJsZWQgd2hlbg0KPiB0aGV5IHNob3VsZG4ndC4gUmVwbGFj
ZSBrbWFsbG9jX2FycmF5KCkgd2l0aCBrY2FsbG9jKCkgd2hpY2ggaGFzIHRoZSBzYW1lDQo+IGlu
dGVyZmFjZSBidXQgemVyb3MgdGhlIG1lbW9yeS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IExhcnMt
UGV0ZXIgQ2xhdXNlbiA8bGFyc0BtZXRhZm9vLmRlPg0KPiBTaWduZWQtb2ZmLWJ5OiBBbGV4YW5k
cnUgQXJkZWxlYW4gPGFsZXhhbmRydS5hcmRlbGVhbkBhbmFsb2cuY29tPg0KPiAtLS0NCj4gIGRy
aXZlcnMvaWlvL2luZHVzdHJpYWxpby1idWZmZXIuYyB8IDUgKystLS0NCj4gIDEgZmlsZSBjaGFu
Z2VkLCAyIGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9paW8vaW5kdXN0cmlhbGlvLWJ1ZmZlci5jDQo+IGIvZHJpdmVycy9paW8vaW5kdXN0
cmlhbGlvLWJ1ZmZlci5jDQo+IGluZGV4IGNkNWJmZTM5NTkxYi4uZGFkZDkyMWE0YTMwIDEwMDY0
NA0KPiAtLS0gYS9kcml2ZXJzL2lpby9pbmR1c3RyaWFsaW8tYnVmZmVyLmMNCj4gKysrIGIvZHJp
dmVycy9paW8vaW5kdXN0cmlhbGlvLWJ1ZmZlci5jDQo+IEBAIC0zMjAsOSArMzIwLDggQEAgc3Rh
dGljIGludCBpaW9fc2Nhbl9tYXNrX3NldChzdHJ1Y3QgaWlvX2Rldg0KPiAqaW5kaW9fZGV2LA0K
PiAgCWNvbnN0IHVuc2lnbmVkIGxvbmcgKm1hc2s7DQo+ICAJdW5zaWduZWQgbG9uZyAqdHJpYWxt
YXNrOw0KPiAgDQo+IC0JdHJpYWxtYXNrID0ga21hbGxvY19hcnJheShCSVRTX1RPX0xPTkdTKGlu
ZGlvX2Rldi0+bWFza2xlbmd0aCksDQo+IC0JCQkJICBzaXplb2YoKnRyaWFsbWFzayksDQo+IC0J
CQkJICBHRlBfS0VSTkVMKTsNCj4gKwl0cmlhbG1hc2sgPSBrY2FsbG9jKEJJVFNfVE9fTE9OR1Mo
aW5kaW9fZGV2LT5tYXNrbGVuZ3RoKSwNCj4gKwkJCSAgICBzaXplb2YoKnRyaWFsbWFzayksIEdG
UF9LRVJORUwpOw0KPiAgCWlmICh0cmlhbG1hc2sgPT0gTlVMTCkNCj4gIAkJcmV0dXJuIC1FTk9N
RU07DQo+ICAJaWYgKCFpbmRpb19kZXYtPm1hc2tsZW5ndGgpIHsNCg==
