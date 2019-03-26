Return-Path: <SRS0=TPgR=R5=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABA3EC43381
	for <linux-iio@archiver.kernel.org>; Tue, 26 Mar 2019 12:43:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A7B62075D
	for <linux-iio@archiver.kernel.org>; Tue, 26 Mar 2019 12:43:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="u0ces3jW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731489AbfCZMnm (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Tue, 26 Mar 2019 08:43:42 -0400
Received: from mail-eopbgr700079.outbound.protection.outlook.com ([40.107.70.79]:40033
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731374AbfCZMnl (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 26 Mar 2019 08:43:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IsNTHqmyQHp0gD+7VJmDNbsTfKq9Jd4HLYyO3L7ZgR8=;
 b=u0ces3jWxHM8W1NHhoGuFT8SIxK0zwWGLMgzWnUOcQQ4DbIaS1jnfjpAhA2VT0Ou61DmL29sJOZ68b8UIbpL3ZCSSeXbFFfhDieWjuwvOfltc30hlG9I+eqlrTai2lmnGOj86jOzTFOSUKsP/J/wsLfI2c8Sw0WFlvtAwMA/cgo=
Received: from DM6PR03CA0049.namprd03.prod.outlook.com (2603:10b6:5:100::26)
 by CY4PR03MB3127.namprd03.prod.outlook.com (2603:10b6:910:53::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1730.18; Tue, 26 Mar
 2019 12:43:34 +0000
Received: from BL2NAM02FT010.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::206) by DM6PR03CA0049.outlook.office365.com
 (2603:10b6:5:100::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1730.18 via Frontend
 Transport; Tue, 26 Mar 2019 12:43:34 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.57)
 smtp.mailfrom=analog.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 BL2NAM02FT010.mail.protection.outlook.com (10.152.77.53) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1730.9
 via Frontend Transport; Tue, 26 Mar 2019 12:43:34 +0000
Received: from NWD2HUBCAS8.ad.analog.com (nwd2hubcas8.ad.analog.com [10.64.69.108])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id x2QChX7g029806
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Tue, 26 Mar 2019 05:43:33 -0700
Received: from NWD2MBX7.ad.analog.com ([fe80::190e:f9c1:9a22:9663]) by
 NWD2HUBCAS8.ad.analog.com ([fe80::90a0:b93e:53c6:afee%12]) with mapi id
 14.03.0415.000; Tue, 26 Mar 2019 08:43:33 -0400
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "jic23@jic23.retrosnub.co.uk" <jic23@jic23.retrosnub.co.uk>
CC:     "lars@metafoo.de" <lars@metafoo.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH V2] iio: ad_sigma_delta: Properly handle SPI bus locking
 vs CS assertion
Thread-Topic: [PATCH V2] iio: ad_sigma_delta: Properly handle SPI bus
 locking vs CS assertion
Thread-Index: AQHU3kg2VGdadXsAa0aByC/QsT4INqYbWdiAgALProA=
Date:   Tue, 26 Mar 2019 12:43:32 +0000
Message-ID: <547665b579684b09246670e7df9b60cde730c1e9.camel@analog.com>
References: <20190319113755.8982-1-alexandru.ardelean@analog.com>
         <20190324174741.39c23b0d@archlinux>
In-Reply-To: <20190324174741.39c23b0d@archlinux>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.50.1.244]
x-adiroutedonprem: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <3BD7437E6456B944A717CECFD130455A@analog.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(39860400002)(396003)(346002)(376002)(2980300002)(189003)(199004)(54534003)(229853002)(106002)(54906003)(3846002)(2906002)(6116002)(2351001)(316002)(50466002)(6916009)(118296001)(186003)(36756003)(486006)(2501003)(2486003)(47776003)(106466001)(7696005)(76176011)(446003)(246002)(11346002)(26005)(4326008)(7736002)(8676002)(305945005)(14444005)(14454004)(5660300002)(7636002)(478600001)(426003)(336012)(356004)(436003)(102836004)(86362001)(5640700003)(23676004)(8936002)(126002)(2616005)(6246003)(476003);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR03MB3127;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dfec5afc-a2b5-45e6-42cd-08d6b1e8a8cd
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4709054)(2017052603328)(7153060)(7193020);SRVR:CY4PR03MB3127;
X-MS-TrafficTypeDiagnostic: CY4PR03MB3127:
X-Microsoft-Antispam-PRVS: <CY4PR03MB31271E7DDDC0E339183C0388F95F0@CY4PR03MB3127.namprd03.prod.outlook.com>
X-Forefront-PRVS: 09888BC01D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: FI2izpGwhTmKIhKio2wixW4E6CGv4/XYraIPo62QN7M2S2xX6u5PzywMaqUsEsqFbO5KBpHdhig+KhHmxqvcu0QBix4zkMZr3PAo8J6kY+sIYr5bTA1pV0P3facxHj6vV4HlW4Kn1orf3q+G01i0X/5YGXxg38xI9MFuekjGic1F++NhJGpCDEurohXidIXp0y6ZrSPKRjunKclsB/YY2Z0/1eEinMPOkT2icznzvLkomjTnkUd7v6cEu9qg5TkGmUiktFIQhPYu0aBsYuDQdb3jCuyRcUxv4rFqf6/dt2PxxVJjAdN3+5X0ui2ei+a4r5tW5HwtIuV2VvOUnyMsQpd9kiPjNzlCmxsEXgWPMHOiNA2asb3/sk0tsDrI7coy/11zpc/BfE0iH2UlQ7gdv3+4kxYLhV5Tx+8DBS5/JvU=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2019 12:43:34.1136
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dfec5afc-a2b5-45e6-42cd-08d6b1e8a8cd
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR03MB3127
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gU3VuLCAyMDE5LTAzLTI0IGF0IDE3OjQ3ICswMDAwLCBKb25hdGhhbiBDYW1lcm9uIHdyb3Rl
Og0KPiBbRXh0ZXJuYWxdDQo+IA0KPiANCj4gT24gVHVlLCAxOSBNYXIgMjAxOSAxMzozNzo1NSAr
MDIwMA0KPiBBbGV4YW5kcnUgQXJkZWxlYW4gPGFsZXhhbmRydS5hcmRlbGVhbkBhbmFsb2cuY29t
PiB3cm90ZToNCj4gDQo+ID4gRnJvbTogTGFycy1QZXRlciBDbGF1c2VuIDxsYXJzQG1ldGFmb28u
ZGU+DQo+ID4gDQo+ID4gRm9yIGRldmljZXMgZnJvbSB0aGUgU2lnbWFEZWx0YSBmYW1pbHkgd2Ug
bmVlZCB0byBrZWVwIENTIGxvdyB3aGVuDQo+ID4gZG9pbmcgYQ0KPiA+IGNvbnZlcnNpb24sIHNp
bmNlIHRoZSBkZXZpY2Ugd2lsbCB1c2UgdGhlIE1JU08gbGluZSBhcyBhIGludGVycnVwdCB0bw0K
PiA+IGluZGljYXRlIHRoYXQgdGhlIGNvbnZlcnNpb24gaXMgY29tcGxldGUuDQo+ID4gDQo+ID4g
VGhpcyBpcyB3aHkgdGhlIGRyaXZlciBsb2NrcyB0aGUgU1BJIGJ1cyBhbmQgd2hlbiB0aGUgU1BJ
IGJ1cyBpcyBsb2NrZWQNCj4gPiBrZWVwcyBhcyBsb25nIGFzIGEgY29udmVyc2lvbiBpcyBnb2lu
ZyBvbi4gVGhlIGN1cnJlbnQgaW1wbGVtZW50YXRpb24NCj4gPiBnZXRzDQo+ID4gb25lIHNtYWxs
IGRldGFpbCB3cm9uZyB0aG91Z2guIENTIGlzIG9ubHkgZGUtYXNzZXJ0ZWQgYWZ0ZXIgdGhlIFNQ
SSBidXMNCj4gPiBpcw0KPiA+IHVubG9ja2VkLiBUaGlzIG1lYW5zIGl0IGlzIHBvc3NpYmxlIGZv
ciBhIGRpZmZlcmVudCBTUEkgZGV2aWNlIG9uIHRoZQ0KPiA+IHNhbWUNCj4gPiBidXMgdG8gc2Vu
ZCBhIG1lc3NhZ2Ugd2hpY2ggd291bGQgYmUgd3JvbmdmdWxseSBiZSBhZGRyZXNzZWQgdG8gdGhl
DQo+ID4gU2lnbWFEZWx0YSBkZXZpY2UgYXMgd2VsbC4gTWFrZSBzdXJlIHRoYXQgdGhlIGxhc3Qg
U1BJIHRyYW5zZmVyIHRoYXQgaXMNCj4gPiBkb25lIHdoaWxlIGhvbGRpbmcgdGhlIFNQSSBidXMg
bG9jayBkZS1hc3NlcnRzIHRoZSBDUyBzaWduYWwuDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTog
TGFycy1QZXRlciBDbGF1c2VuIDxsYXJzQG1ldGFmb28uZGU+DQo+ID4gU2lnbmVkLW9mZi1ieTog
QWxleGFuZHJ1IEFyZGVsZWFuIDxBbGV4YW5kcnUuQXJkZWxlYW5AYW5hbG9nLmNvbT4NCj4gDQo+
IEhpIEFsZXgsDQo+IA0KPiBTbywgaXQncyBhIGZpeCBmb3IgYSBsb25nIGV4aXN0aW5nIHByb2Js
ZW0uICBEbyB3ZSBoYXZlIGFueW9uZSB3aG8NCj4gaGFzIGV4cGVyaWVuY2VkIGl0PyAgSSdtIHRy
eWluZyB0byBqdWRnZSB3aGV0aGVyIHRoaXMgaXMgc3RhYmxlIG1hdGVyaWFsDQo+IG9yIG5vdC4g
IElmIGl0IGlzIHN0YWJsZSBtYXRlcmlhbCwgZG8geW91IHdhbnQgdG8gaGF2ZSBhIGdvIGF0DQo+
IGlkZW50aWZ5aW5nDQo+IGEgcGF0Y2ggZm9yIHRoZSBGaXhlcyB0YWc/DQoNClNvIEkgYWN0dWFs
bHkgZm9yZ290IHRvIGRvIHRoZSBwcmVwYXJhdGlvbiBiZWZvcmUgY2hlcnJ5LXBpY2tpbmcgdGhp
cyBvbmUNCltpLmUuIHdoZXRoZXIgaXQgc2hvdWxkIGhhdmUgYSBGaXhlcyB0YWcgb3Igbm90XS4N
ClNvcnJ5IGFib3UgdGhhdC4NCg0KVGhpcyBjaGFuZ2UgaXMgbW9yZSBpbiB0aGUgY29udGV4dCBv
ZiBzb21lIG5vbi11cHN0cmVhbSBmdW5jdGlvbmFsaXR5IGZvcg0KdGhlIFNpZ21hRGVsdGEuIGku
ZS4gaXQncyBhIGZpeCwgYnV0IGl0J3MgbW9yZSBpbXBvcnRhbnQgZm9yIGENCmZ1bmN0aW9uYWxp
dHkgdGhhdCB3aWxsIGJlIGFkZGVkIGxhdGVyLg0KDQpUaGVyZSBhcmVuJ3QgYW55IHBlb3BsZSB0
aGF0IGhhdmUgZXhwZXJpZW5jZWQgaXNzdWVzIHdpdGggdGhlIG1haW5saW5lDQp2ZXJzaW9uIG9m
IHRoZSBhZF9zaWdtYV9kZWx0YSBkcml2ZXJzIHRoYXQgSSBrbm93IG9mLg0KDQpCb3R0b20gbGlu
ZSBpcywgd2UgY2FuIHNraXAgYWRkaW5nIHRoaXMgb25lIHRvIHN0YWJsZS4NCg0KVGhhbmtzDQpB
bGV4DQoNCg0KPiBQYXRjaCBsb29rcyBnb29kLg0KPiANCj4gSm9uYXRoYW4NCj4gDQo+ID4gLS0t
DQo+ID4gDQo+ID4gQ2hhbmdlbG9nIHYxIC0+IHYyOg0KPiA+ICogYWRkZWQgbXkgUy1vLUIgbGlu
ZQ0KPiA+IA0KPiA+ICBkcml2ZXJzL2lpby9hZGMvYWRfc2lnbWFfZGVsdGEuYyAgICAgICB8IDE2
ICsrKysrKysrKysrLS0tLS0NCj4gPiAgaW5jbHVkZS9saW51eC9paW8vYWRjL2FkX3NpZ21hX2Rl
bHRhLmggfCAgMSArDQo+ID4gIDIgZmlsZXMgY2hhbmdlZCwgMTIgaW5zZXJ0aW9ucygrKSwgNSBk
ZWxldGlvbnMoLSkNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9paW8vYWRjL2FkX3Np
Z21hX2RlbHRhLmMNCj4gPiBiL2RyaXZlcnMvaWlvL2FkYy9hZF9zaWdtYV9kZWx0YS5jDQo+ID4g
aW5kZXggZmY1ZjJkYTJlMWIxLi5hZjZjYmM2ODMyMTQgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVy
cy9paW8vYWRjL2FkX3NpZ21hX2RlbHRhLmMNCj4gPiArKysgYi9kcml2ZXJzL2lpby9hZGMvYWRf
c2lnbWFfZGVsdGEuYw0KPiA+IEBAIC02Miw3ICs2Miw3IEBAIGludCBhZF9zZF93cml0ZV9yZWco
c3RydWN0IGFkX3NpZ21hX2RlbHRhDQo+ID4gKnNpZ21hX2RlbHRhLCB1bnNpZ25lZCBpbnQgcmVn
LA0KPiA+ICAgICAgIHN0cnVjdCBzcGlfdHJhbnNmZXIgdCA9IHsNCj4gPiAgICAgICAgICAgICAg
IC50eF9idWYgICAgICAgICA9IGRhdGEsDQo+ID4gICAgICAgICAgICAgICAubGVuICAgICAgICAg
ICAgPSBzaXplICsgMSwNCj4gPiAtICAgICAgICAgICAgIC5jc19jaGFuZ2UgICAgICA9IHNpZ21h
X2RlbHRhLT5idXNfbG9ja2VkLA0KPiA+ICsgICAgICAgICAgICAgLmNzX2NoYW5nZSAgICAgID0g
c2lnbWFfZGVsdGEtPmtlZXBfY3NfYXNzZXJ0ZWQsDQo+ID4gICAgICAgfTsNCj4gPiAgICAgICBz
dHJ1Y3Qgc3BpX21lc3NhZ2UgbTsNCj4gPiAgICAgICBpbnQgcmV0Ow0KPiA+IEBAIC0yMTcsNiAr
MjE3LDcgQEAgc3RhdGljIGludCBhZF9zZF9jYWxpYnJhdGUoc3RydWN0IGFkX3NpZ21hX2RlbHRh
DQo+ID4gKnNpZ21hX2RlbHRhLA0KPiA+IA0KPiA+ICAgICAgIHNwaV9idXNfbG9jayhzaWdtYV9k
ZWx0YS0+c3BpLT5tYXN0ZXIpOw0KPiA+ICAgICAgIHNpZ21hX2RlbHRhLT5idXNfbG9ja2VkID0g
dHJ1ZTsNCj4gPiArICAgICBzaWdtYV9kZWx0YS0+a2VlcF9jc19hc3NlcnRlZCA9IHRydWU7DQo+
ID4gICAgICAgcmVpbml0X2NvbXBsZXRpb24oJnNpZ21hX2RlbHRhLT5jb21wbGV0aW9uKTsNCj4g
PiANCj4gPiAgICAgICByZXQgPSBhZF9zaWdtYV9kZWx0YV9zZXRfbW9kZShzaWdtYV9kZWx0YSwg
bW9kZSk7DQo+ID4gQEAgLTIzNCw5ICsyMzUsMTAgQEAgc3RhdGljIGludCBhZF9zZF9jYWxpYnJh
dGUoc3RydWN0IGFkX3NpZ21hX2RlbHRhDQo+ID4gKnNpZ21hX2RlbHRhLA0KPiA+ICAgICAgICAg
ICAgICAgcmV0ID0gMDsNCj4gPiAgICAgICB9DQo+ID4gIG91dDoNCj4gPiArICAgICBzaWdtYV9k
ZWx0YS0+a2VlcF9jc19hc3NlcnRlZCA9IGZhbHNlOw0KPiA+ICsgICAgIGFkX3NpZ21hX2RlbHRh
X3NldF9tb2RlKHNpZ21hX2RlbHRhLCBBRF9TRF9NT0RFX0lETEUpOw0KPiA+ICAgICAgIHNpZ21h
X2RlbHRhLT5idXNfbG9ja2VkID0gZmFsc2U7DQo+ID4gICAgICAgc3BpX2J1c191bmxvY2soc2ln
bWFfZGVsdGEtPnNwaS0+bWFzdGVyKTsNCj4gPiAtICAgICBhZF9zaWdtYV9kZWx0YV9zZXRfbW9k
ZShzaWdtYV9kZWx0YSwgQURfU0RfTU9ERV9JRExFKTsNCj4gPiANCj4gPiAgICAgICByZXR1cm4g
cmV0Ow0KPiA+ICB9DQo+ID4gQEAgLTI4OSw2ICsyOTEsNyBAQCBpbnQgYWRfc2lnbWFfZGVsdGFf
c2luZ2xlX2NvbnZlcnNpb24oc3RydWN0IGlpb19kZXYNCj4gPiAqaW5kaW9fZGV2LA0KPiA+IA0K
PiA+ICAgICAgIHNwaV9idXNfbG9jayhzaWdtYV9kZWx0YS0+c3BpLT5tYXN0ZXIpOw0KPiA+ICAg
ICAgIHNpZ21hX2RlbHRhLT5idXNfbG9ja2VkID0gdHJ1ZTsNCj4gPiArICAgICBzaWdtYV9kZWx0
YS0+a2VlcF9jc19hc3NlcnRlZCA9IHRydWU7DQo+ID4gICAgICAgcmVpbml0X2NvbXBsZXRpb24o
JnNpZ21hX2RlbHRhLT5jb21wbGV0aW9uKTsNCj4gPiANCj4gPiAgICAgICBhZF9zaWdtYV9kZWx0
YV9zZXRfbW9kZShzaWdtYV9kZWx0YSwgQURfU0RfTU9ERV9TSU5HTEUpOw0KPiA+IEBAIC0yOTgs
OSArMzAxLDYgQEAgaW50IGFkX3NpZ21hX2RlbHRhX3NpbmdsZV9jb252ZXJzaW9uKHN0cnVjdCBp
aW9fZGV2DQo+ID4gKmluZGlvX2RldiwNCj4gPiAgICAgICByZXQgPSB3YWl0X2Zvcl9jb21wbGV0
aW9uX2ludGVycnVwdGlibGVfdGltZW91dCgNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgJnNp
Z21hX2RlbHRhLT5jb21wbGV0aW9uLCBIWik7DQo+ID4gDQo+ID4gLSAgICAgc2lnbWFfZGVsdGEt
PmJ1c19sb2NrZWQgPSBmYWxzZTsNCj4gPiAtICAgICBzcGlfYnVzX3VubG9jayhzaWdtYV9kZWx0
YS0+c3BpLT5tYXN0ZXIpOw0KPiA+IC0NCj4gPiAgICAgICBpZiAocmV0ID09IDApDQo+ID4gICAg
ICAgICAgICAgICByZXQgPSAtRUlPOw0KPiA+ICAgICAgIGlmIChyZXQgPCAwKQ0KPiA+IEBAIC0z
MjEsNyArMzIxLDEwIEBAIGludCBhZF9zaWdtYV9kZWx0YV9zaW5nbGVfY29udmVyc2lvbihzdHJ1
Y3QNCj4gPiBpaW9fZGV2ICppbmRpb19kZXYsDQo+ID4gICAgICAgICAgICAgICBzaWdtYV9kZWx0
YS0+aXJxX2RpcyA9IHRydWU7DQo+ID4gICAgICAgfQ0KPiA+IA0KPiA+ICsgICAgIHNpZ21hX2Rl
bHRhLT5rZWVwX2NzX2Fzc2VydGVkID0gZmFsc2U7DQo+ID4gICAgICAgYWRfc2lnbWFfZGVsdGFf
c2V0X21vZGUoc2lnbWFfZGVsdGEsIEFEX1NEX01PREVfSURMRSk7DQo+ID4gKyAgICAgc2lnbWFf
ZGVsdGEtPmJ1c19sb2NrZWQgPSBmYWxzZTsNCj4gPiArICAgICBzcGlfYnVzX3VubG9jayhzaWdt
YV9kZWx0YS0+c3BpLT5tYXN0ZXIpOw0KPiA+ICAgICAgIG11dGV4X3VubG9jaygmaW5kaW9fZGV2
LT5tbG9jayk7DQo+ID4gDQo+ID4gICAgICAgaWYgKHJldCkNCj4gPiBAQCAtMzU4LDYgKzM2MSw4
IEBAIHN0YXRpYyBpbnQgYWRfc2RfYnVmZmVyX3Bvc3RlbmFibGUoc3RydWN0IGlpb19kZXYNCj4g
PiAqaW5kaW9fZGV2KQ0KPiA+IA0KPiA+ICAgICAgIHNwaV9idXNfbG9jayhzaWdtYV9kZWx0YS0+
c3BpLT5tYXN0ZXIpOw0KPiA+ICAgICAgIHNpZ21hX2RlbHRhLT5idXNfbG9ja2VkID0gdHJ1ZTsN
Cj4gPiArICAgICBzaWdtYV9kZWx0YS0+a2VlcF9jc19hc3NlcnRlZCA9IHRydWU7DQo+ID4gKw0K
PiA+ICAgICAgIHJldCA9IGFkX3NpZ21hX2RlbHRhX3NldF9tb2RlKHNpZ21hX2RlbHRhLA0KPiA+
IEFEX1NEX01PREVfQ09OVElOVU9VUyk7DQo+ID4gICAgICAgaWYgKHJldCkNCj4gPiAgICAgICAg
ICAgICAgIGdvdG8gZXJyX3VubG9jazsNCj4gPiBAQCAtMzg2LDYgKzM5MSw3IEBAIHN0YXRpYyBp
bnQgYWRfc2RfYnVmZmVyX3Bvc3RkaXNhYmxlKHN0cnVjdCBpaW9fZGV2DQo+ID4gKmluZGlvX2Rl
dikNCj4gPiAgICAgICAgICAgICAgIHNpZ21hX2RlbHRhLT5pcnFfZGlzID0gdHJ1ZTsNCj4gPiAg
ICAgICB9DQo+ID4gDQo+ID4gKyAgICAgc2lnbWFfZGVsdGEtPmtlZXBfY3NfYXNzZXJ0ZWQgPSBm
YWxzZTsNCj4gPiAgICAgICBhZF9zaWdtYV9kZWx0YV9zZXRfbW9kZShzaWdtYV9kZWx0YSwgQURf
U0RfTU9ERV9JRExFKTsNCj4gPiANCj4gPiAgICAgICBzaWdtYV9kZWx0YS0+YnVzX2xvY2tlZCA9
IGZhbHNlOw0KPiA+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L2lpby9hZGMvYWRfc2lnbWFf
ZGVsdGEuaA0KPiA+IGIvaW5jbHVkZS9saW51eC9paW8vYWRjL2FkX3NpZ21hX2RlbHRhLmgNCj4g
PiBpbmRleCA3ZTg0MzUxZmEyYzAuLjZlOWZiMTkzMmRkZSAxMDA2NDQNCj4gPiAtLS0gYS9pbmNs
dWRlL2xpbnV4L2lpby9hZGMvYWRfc2lnbWFfZGVsdGEuaA0KPiA+ICsrKyBiL2luY2x1ZGUvbGlu
dXgvaWlvL2FkYy9hZF9zaWdtYV9kZWx0YS5oDQo+ID4gQEAgLTY5LDYgKzY5LDcgQEAgc3RydWN0
IGFkX3NpZ21hX2RlbHRhIHsNCj4gPiAgICAgICBib29sICAgICAgICAgICAgICAgICAgICBpcnFf
ZGlzOw0KPiA+IA0KPiA+ICAgICAgIGJvb2wgICAgICAgICAgICAgICAgICAgIGJ1c19sb2NrZWQ7
DQo+ID4gKyAgICAgYm9vbCAgICAgICAgICAgICAgICAgICAga2VlcF9jc19hc3NlcnRlZDsNCj4g
PiANCj4gPiAgICAgICB1aW50OF90ICAgICAgICAgICAgICAgICBjb21tOw0KPiA+IA0KPiANCj4g
DQo=
