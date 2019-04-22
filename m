Return-Path: <SRS0=i5D1=SY=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9FBDC10F11
	for <linux-iio@archiver.kernel.org>; Mon, 22 Apr 2019 10:28:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 951592075A
	for <linux-iio@archiver.kernel.org>; Mon, 22 Apr 2019 10:28:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="e2SctIhi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726835AbfDVK2i (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Mon, 22 Apr 2019 06:28:38 -0400
Received: from mail-eopbgr790071.outbound.protection.outlook.com ([40.107.79.71]:11680
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726057AbfDVK2i (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 22 Apr 2019 06:28:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rhr4A2mXLUus+QWKJnTvCZa8HTqbVGnw49dx63za73c=;
 b=e2SctIhiCJu9uavKS59XPjHreQsfYTevnMoYpcSHim8Aw/lNV2fclRvUqrWQq+KAsIO435kXmVHoNMiNXJ8IZ0MXXAVXVJmxTBRSFsHYoQ3knmzUfuiO1BylN3KZpXQCl+9/RbnQie/jnpD9PUgirZM1TN/hG34wD01LfR6f4X4=
Received: from DM6PR03CA0046.namprd03.prod.outlook.com (2603:10b6:5:100::23)
 by DM5PR03MB3131.namprd03.prod.outlook.com (2603:10b6:4:3c::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1813.12; Mon, 22 Apr
 2019 10:28:31 +0000
Received: from BL2NAM02FT026.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::209) by DM6PR03CA0046.outlook.office365.com
 (2603:10b6:5:100::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1813.11 via Frontend
 Transport; Mon, 22 Apr 2019 10:28:31 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.55)
 smtp.mailfrom=analog.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 BL2NAM02FT026.mail.protection.outlook.com (10.152.77.156) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1771.16
 via Frontend Transport; Mon, 22 Apr 2019 10:28:30 +0000
Received: from NWD2HUBCAS8.ad.analog.com (nwd2hubcas8.ad.analog.com [10.64.69.108])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id x3MASUHv020123
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Mon, 22 Apr 2019 03:28:30 -0700
Received: from NWD2MBX7.ad.analog.com ([fe80::190e:f9c1:9a22:9663]) by
 NWD2HUBCAS8.ad.analog.com ([fe80::90a0:b93e:53c6:afee%12]) with mapi id
 14.03.0415.000; Mon, 22 Apr 2019 06:28:30 -0400
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "jic23@jic23.retrosnub.co.uk" <jic23@jic23.retrosnub.co.uk>
CC:     "lars@metafoo.de" <lars@metafoo.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH V2] iio: ad_sigma_delta: Don't put SPI transfer buffer
 on the stack
Thread-Topic: [PATCH V2] iio: ad_sigma_delta: Don't put SPI transfer buffer
 on the stack
Thread-Index: AQHU9C0dE0Ffmb4RckesYLMpGv7LlaZILT2AgAAZtYA=
Date:   Mon, 22 Apr 2019 10:28:29 +0000
Message-ID: <8f7c3a073279a3fefc69ac6ddf37934613cc7008.camel@analog.com>
References: <20190409075821.26104-1-alexandru.ardelean@analog.com>
         <20190416081916.26287-1-alexandru.ardelean@analog.com>
         <20190422095627.4d115944@archlinux>
In-Reply-To: <20190422095627.4d115944@archlinux>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.50.1.244]
x-adiroutedonprem: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <4C0D9F5ED22AFA4A8D05EADB9C76C107@analog.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(136003)(346002)(376002)(39860400002)(2980300002)(51914003)(199004)(189003)(54534003)(3846002)(6116002)(14454004)(2486003)(6246003)(2906002)(118296001)(4326008)(186003)(102836004)(76176011)(246002)(316002)(2351001)(478600001)(8936002)(8676002)(23676004)(26005)(7696005)(5640700003)(54906003)(6916009)(5660300002)(50466002)(36756003)(70206006)(229853002)(7636002)(7736002)(2501003)(305945005)(70586007)(47776003)(426003)(436003)(356004)(336012)(14444005)(2616005)(126002)(106002)(476003)(11346002)(446003)(86362001)(486006);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR03MB3131;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3f1517ac-8c0f-4172-44a5-08d6c70d440f
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4709054)(2017052603328)(7193020);SRVR:DM5PR03MB3131;
X-MS-TrafficTypeDiagnostic: DM5PR03MB3131:
X-Microsoft-Antispam-PRVS: <DM5PR03MB31315C7F428EFD605D8EDE65F9220@DM5PR03MB3131.namprd03.prod.outlook.com>
X-Forefront-PRVS: 00159D1518
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: 0wQOlj4l+i2YR2pU5CjGESzQuJDXCYatuRU1QMphMDC7Twn+TM2bUgt+dTNHVxotrlIhkWZKqUwAAONQOdxdQbYP2YqtbOjZuFmM8EFJIJqib9CSTROnL2ovnSW8OdFuMzr/KXMAcZTzsDaBgMw+AwgSeznfRVk86RCXkzqpsqKmYtHjmUAhfwKHcC9Q5xsdLszN41HS6sKZyQdYe1RDbPeCCRtMM16OrmBAWBVkgDkaCgVbyvRBoOzNhDheIC1fsJMAC6EuxXeC772gMxzx8jDTXzlwlnnxtoTRoPkJBjQvTw2O7u7LvgXF+UpnRZQ3hi2fWVPZSj7Aj4VpLUjCQWJ5caijODU3+lOpVdLKW6XsblyxJhtOZp4MVhIcy/KqvYIksbalNnQKbeO8PDEZyHHjuNkmCti6A6sNKXru4jE=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2019 10:28:30.8876
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f1517ac-8c0f-4172-44a5-08d6c70d440f
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR03MB3131
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gTW9uLCAyMDE5LTA0LTIyIGF0IDA5OjU2ICswMTAwLCBKb25hdGhhbiBDYW1lcm9uIHdyb3Rl
Og0KPiBbRXh0ZXJuYWxdDQo+IA0KPiANCj4gT24gVHVlLCAxNiBBcHIgMjAxOSAxMToxOToxNiAr
MDMwMA0KPiBBbGV4YW5kcnUgQXJkZWxlYW4gPGFsZXhhbmRydS5hcmRlbGVhbkBhbmFsb2cuY29t
PiB3cm90ZToNCj4gDQo+ID4gRnJvbTogTGFycy1QZXRlciBDbGF1c2VuIDxsYXJzQG1ldGFmb28u
ZGU+DQo+ID4gDQo+ID4gVXNlIGEgaGVhcCBhbGxvY2F0ZWQgbWVtb3J5IGZvciB0aGUgU1BJIHRy
YW5zZmVyIGJ1ZmZlci4gVXNpbmcgc3RhY2sNCj4gPiBtZW1vcnkNCj4gPiB3aWxsIG5vdCB3b3Jr
IG9uIHNvbWUgYXJjaGl0ZWN0dXJlcyB3aGVuIHVzaW5nIERNQS4NCj4gPiANCj4gPiBUaGlzIGFs
c28gYXZvaWRzIHBvdGVudGlhbCBzdGFjayBjb3JydXB0aW9uLCBhcyBpdCBtYWtlcyBzdXJlIHRo
YXQgdGhlDQo+ID4gYnVmZmVyIGlzIGluIGl0J3Mgb3duIGNhY2hlbGluZSBhbmQgKG9idmlvdXNs
eSkgbm90IG9uIHRoZSBzdGFjay4NCj4gPiANCj4gPiBGaXhlczogYWYzMDA4NDg1ZWEwMyAoImlp
bzphZGM6IEFkZCBjb21tb24gY29kZSBmb3IgQURJIFNpZ21hIERlbHRhDQo+ID4gZGV2aWNlcyIp
DQo+ID4gU2lnbmVkLW9mZi1ieTogTGFycy1QZXRlciBDbGF1c2VuIDxsYXJzQG1ldGFmb28uZGU+
DQo+ID4gU2lnbmVkLW9mZi1ieTogQWxleGFuZHJ1IEFyZGVsZWFuIDxhbGV4YW5kcnUuYXJkZWxl
YW5AYW5hbG9nLmNvbT4NCj4gDQo+IEhpIEFsZXgsDQo+IA0KPiBUaGFua3MgZm9yIHRoZSB1cGRh
dGUuDQo+IA0KPiBJJ20gdW5jbGVhciB3aHkgd2UgY2FuJ3QganVzdCB1c2Ugb25lIGxhcmdlIGJ1
ZmZlciBmb3IgYm90aCBjYXNlcz8NCj4gaS5lIHB1dCB0aGUgcmVnX2RhdGEgdXNlY2FzZXMgaW4g
dGhlIGJ1Zl9kYXRhIGJ1ZmZlciAocmVuYW1lZCkuDQo+IA0KDQpUaGF0J3MgYSBnb29kIHBvaW50
Lg0KSSBkaWRuJ3QgdGhpbmsgbXVjaCBvZiBpdC4NCg0KDQpMb29raW5nIHRocm91Z2ggdGhlIGNv
ZGUsIHRoZSBvbmx5IGFyZ3VtZW50IGZvciBkb2luZyBpdCBsaWtlIHRoaXMNCihzZXBhcmF0ZSBi
dWZmZXIpIGlzIHRoYXQgdGhlIGNoYW5nZSBpcyBsZXNzIGNvbXBsaWNhdGVkIHRvIGxvb2sgYXQs
IHNpbmNlDQppdCBtYWtlcyBubyBhc3N1bXB0aW9ucyBhYm91dCBvZmZzZXQgaW4gdGhlIGJ1ZmZl
ci4NCg0KQXQgYSBsYXRlciBwb2ludCBpbiB0aW1lLCB0aGlzIGBidWZfZGF0YWAgd2lsbCBiZSBy
ZXBsYWNlZCB3aXRoIGEga3phbGxvYy0NCmVkIGJ1ZmZlciBbd2hlbiBhZGRpbmcgc2VxdWVuY2Vy
IHN1cHBvcnQgZm9yIFNpZ21hRGVsdGFdLg0KDQpJdCBtYXkgb25seSBtYWtlIHNlbnNlIHRvIGhh
dmUgdGhpcyBjaGFuZ2UgW3doZXRoZXIgMiBidWZmZXJzIG9yIGEgc2luZ2xlDQpidWZmZXJdIGZv
ciBzdGFibGUsIHRvIGZpeCB0aGUgY2FjaGVsaW5lIGlzc3VlLg0KDQpJJ2xsIHRha2UgYSBjbG9z
ZXIgbG9vayBhdCB0aGlzLg0KSXQgc2hvdWxkIHdvcmsgd2VsbCB0byBqdXN0IGluY3JlYXNlIHRo
ZSBleGlzdGluZyBidWZmZXIgYW5kIHJlLXVzZSB0aGF0Lg0KDQoNCj4gSm9uYXRoYW4NCj4gPiAt
LS0NCj4gPiBDaGFuZ2Vsb2cgdjEgLT4gdjI6DQo+ID4gKiBhZGRlZCBfX19fY2FjaGVsaW5lX2Fs
aWduZWQgdG8gYGJ1Zl9kYXRhYA0KPiA+ICogZXh0ZW5kZWQgY29tbWVudCBhYm91dCBjYWNoZWxp
bmUNCj4gPiAqIGFkZGVkIGZpeGVzIHRhZw0KPiA+IA0KPiA+ICBkcml2ZXJzL2lpby9hZGMvYWRf
c2lnbWFfZGVsdGEuYyAgICAgICB8IDIyICsrKysrKysrKysrLS0tLS0tLS0tLS0NCj4gPiAgaW5j
bHVkZS9saW51eC9paW8vYWRjL2FkX3NpZ21hX2RlbHRhLmggfCAgMyArKy0NCj4gPiAgMiBmaWxl
cyBjaGFuZ2VkLCAxMyBpbnNlcnRpb25zKCspLCAxMiBkZWxldGlvbnMoLSkNCj4gPiANCj4gPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9paW8vYWRjL2FkX3NpZ21hX2RlbHRhLmMNCj4gPiBiL2RyaXZl
cnMvaWlvL2FkYy9hZF9zaWdtYV9kZWx0YS5jDQo+ID4gaW5kZXggYWY2Y2JjNjgzMjE0Li4wMmQ5
MDQ5YjkyMTggMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9paW8vYWRjL2FkX3NpZ21hX2RlbHRh
LmMNCj4gPiArKysgYi9kcml2ZXJzL2lpby9hZGMvYWRfc2lnbWFfZGVsdGEuYw0KPiA+IEBAIC01
OCw3ICs1OCw3IEBAIEVYUE9SVF9TWU1CT0xfR1BMKGFkX3NkX3NldF9jb21tKTsNCj4gPiAgaW50
IGFkX3NkX3dyaXRlX3JlZyhzdHJ1Y3QgYWRfc2lnbWFfZGVsdGEgKnNpZ21hX2RlbHRhLCB1bnNp
Z25lZCBpbnQNCj4gPiByZWcsDQo+ID4gICAgICAgdW5zaWduZWQgaW50IHNpemUsIHVuc2lnbmVk
IGludCB2YWwpDQo+ID4gIHsNCj4gPiAtICAgICB1aW50OF90ICpkYXRhID0gc2lnbWFfZGVsdGEt
PmRhdGE7DQo+ID4gKyAgICAgdWludDhfdCAqZGF0YSA9IHNpZ21hX2RlbHRhLT5yZWdfZGF0YTsN
Cj4gPiAgICAgICBzdHJ1Y3Qgc3BpX3RyYW5zZmVyIHQgPSB7DQo+ID4gICAgICAgICAgICAgICAu
dHhfYnVmICAgICAgICAgPSBkYXRhLA0KPiA+ICAgICAgICAgICAgICAgLmxlbiAgICAgICAgICAg
ID0gc2l6ZSArIDEsDQo+ID4gQEAgLTEwMiw3ICsxMDIsNyBAQCBFWFBPUlRfU1lNQk9MX0dQTChh
ZF9zZF93cml0ZV9yZWcpOw0KPiA+ICBzdGF0aWMgaW50IGFkX3NkX3JlYWRfcmVnX3JhdyhzdHJ1
Y3QgYWRfc2lnbWFfZGVsdGEgKnNpZ21hX2RlbHRhLA0KPiA+ICAgICAgIHVuc2lnbmVkIGludCBy
ZWcsIHVuc2lnbmVkIGludCBzaXplLCB1aW50OF90ICp2YWwpDQo+ID4gIHsNCj4gPiAtICAgICB1
aW50OF90ICpkYXRhID0gc2lnbWFfZGVsdGEtPmRhdGE7DQo+ID4gKyAgICAgdWludDhfdCAqZGF0
YSA9IHNpZ21hX2RlbHRhLT5yZWdfZGF0YTsNCj4gPiAgICAgICBpbnQgcmV0Ow0KPiA+ICAgICAg
IHN0cnVjdCBzcGlfdHJhbnNmZXIgdFtdID0gew0KPiA+ICAgICAgICAgICAgICAgew0KPiA+IEBA
IC0xNDgsMjQgKzE0OCwyNCBAQCBpbnQgYWRfc2RfcmVhZF9yZWcoc3RydWN0IGFkX3NpZ21hX2Rl
bHRhDQo+ID4gKnNpZ21hX2RlbHRhLA0KPiA+ICB7DQo+ID4gICAgICAgaW50IHJldDsNCj4gPiAN
Cj4gPiAtICAgICByZXQgPSBhZF9zZF9yZWFkX3JlZ19yYXcoc2lnbWFfZGVsdGEsIHJlZywgc2l6
ZSwgc2lnbWFfZGVsdGEtDQo+ID4gPmRhdGEpOw0KPiA+ICsgICAgIHJldCA9IGFkX3NkX3JlYWRf
cmVnX3JhdyhzaWdtYV9kZWx0YSwgcmVnLCBzaXplLCBzaWdtYV9kZWx0YS0NCj4gPiA+cmVnX2Rh
dGEpOw0KPiA+ICAgICAgIGlmIChyZXQgPCAwKQ0KPiA+ICAgICAgICAgICAgICAgZ290byBvdXQ7
DQo+ID4gDQo+ID4gICAgICAgc3dpdGNoIChzaXplKSB7DQo+ID4gICAgICAgY2FzZSA0Og0KPiA+
IC0gICAgICAgICAgICAgKnZhbCA9IGdldF91bmFsaWduZWRfYmUzMihzaWdtYV9kZWx0YS0+ZGF0
YSk7DQo+ID4gKyAgICAgICAgICAgICAqdmFsID0gZ2V0X3VuYWxpZ25lZF9iZTMyKHNpZ21hX2Rl
bHRhLT5yZWdfZGF0YSk7DQo+ID4gICAgICAgICAgICAgICBicmVhazsNCj4gPiAgICAgICBjYXNl
IDM6DQo+ID4gLSAgICAgICAgICAgICAqdmFsID0gKHNpZ21hX2RlbHRhLT5kYXRhWzBdIDw8IDE2
KSB8DQo+ID4gLSAgICAgICAgICAgICAgICAgICAgIChzaWdtYV9kZWx0YS0+ZGF0YVsxXSA8PCA4
KSB8DQo+ID4gLSAgICAgICAgICAgICAgICAgICAgIHNpZ21hX2RlbHRhLT5kYXRhWzJdOw0KPiA+
ICsgICAgICAgICAgICAgKnZhbCA9IChzaWdtYV9kZWx0YS0+cmVnX2RhdGFbMF0gPDwgMTYpIHwN
Cj4gPiArICAgICAgICAgICAgICAgICAgICAgKHNpZ21hX2RlbHRhLT5yZWdfZGF0YVsxXSA8PCA4
KSB8DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgIHNpZ21hX2RlbHRhLT5yZWdfZGF0YVsyXTsN
Cj4gPiAgICAgICAgICAgICAgIGJyZWFrOw0KPiA+ICAgICAgIGNhc2UgMjoNCj4gPiAtICAgICAg
ICAgICAgICp2YWwgPSBnZXRfdW5hbGlnbmVkX2JlMTYoc2lnbWFfZGVsdGEtPmRhdGEpOw0KPiA+
ICsgICAgICAgICAgICAgKnZhbCA9IGdldF91bmFsaWduZWRfYmUxNihzaWdtYV9kZWx0YS0+cmVn
X2RhdGEpOw0KPiA+ICAgICAgICAgICAgICAgYnJlYWs7DQo+ID4gICAgICAgY2FzZSAxOg0KPiA+
IC0gICAgICAgICAgICAgKnZhbCA9IHNpZ21hX2RlbHRhLT5kYXRhWzBdOw0KPiA+ICsgICAgICAg
ICAgICAgKnZhbCA9IHNpZ21hX2RlbHRhLT5yZWdfZGF0YVswXTsNCj4gPiAgICAgICAgICAgICAg
IGJyZWFrOw0KPiA+ICAgICAgIGRlZmF1bHQ6DQo+ID4gICAgICAgICAgICAgICByZXQgPSAtRUlO
VkFMOw0KPiA+IEBAIC00MDMsMTIgKzQwMywxMiBAQCBzdGF0aWMgaXJxcmV0dXJuX3QgYWRfc2Rf
dHJpZ2dlcl9oYW5kbGVyKGludCBpcnEsDQo+ID4gdm9pZCAqcCkNCj4gPiAgICAgICBzdHJ1Y3Qg
aWlvX3BvbGxfZnVuYyAqcGYgPSBwOw0KPiA+ICAgICAgIHN0cnVjdCBpaW9fZGV2ICppbmRpb19k
ZXYgPSBwZi0+aW5kaW9fZGV2Ow0KPiA+ICAgICAgIHN0cnVjdCBhZF9zaWdtYV9kZWx0YSAqc2ln
bWFfZGVsdGEgPQ0KPiA+IGlpb19kZXZpY2VfZ2V0X2RydmRhdGEoaW5kaW9fZGV2KTsNCj4gPiAr
ICAgICB1aW50OF90ICpkYXRhID0gc2lnbWFfZGVsdGEtPmJ1Zl9kYXRhOw0KPiA+ICAgICAgIHVu
c2lnbmVkIGludCByZWdfc2l6ZTsNCj4gPiAgICAgICB1bnNpZ25lZCBpbnQgZGF0YV9yZWc7DQo+
ID4gLSAgICAgdWludDhfdCBkYXRhWzE2XTsNCj4gPiAgICAgICBpbnQgcmV0Ow0KPiA+IA0KPiA+
IC0gICAgIG1lbXNldChkYXRhLCAweDAwLCAxNik7DQo+ID4gKyAgICAgbWVtc2V0KHNpZ21hX2Rl
bHRhLT5idWZfZGF0YSwgMHgwMCwgc2l6ZW9mKHNpZ21hX2RlbHRhLQ0KPiA+ID5idWZfZGF0YSkp
Ow0KPiA+IA0KPiA+ICAgICAgIHJlZ19zaXplID0gaW5kaW9fZGV2LT5jaGFubmVsc1swXS5zY2Fu
X3R5cGUucmVhbGJpdHMgKw0KPiA+ICAgICAgICAgICAgICAgICAgICAgICBpbmRpb19kZXYtPmNo
YW5uZWxzWzBdLnNjYW5fdHlwZS5zaGlmdDsNCj4gPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51
eC9paW8vYWRjL2FkX3NpZ21hX2RlbHRhLmgNCj4gPiBiL2luY2x1ZGUvbGludXgvaWlvL2FkYy9h
ZF9zaWdtYV9kZWx0YS5oDQo+ID4gaW5kZXggNmU5ZmIxOTMyZGRlLi5kOTUyMTZjZThhOTQgMTAw
NjQ0DQo+ID4gLS0tIGEvaW5jbHVkZS9saW51eC9paW8vYWRjL2FkX3NpZ21hX2RlbHRhLmgNCj4g
PiArKysgYi9pbmNsdWRlL2xpbnV4L2lpby9hZGMvYWRfc2lnbWFfZGVsdGEuaA0KPiA+IEBAIC03
OSw3ICs3OSw4IEBAIHN0cnVjdCBhZF9zaWdtYV9kZWx0YSB7DQo+ID4gICAgICAgICogRE1BICh0
aHVzIGNhY2hlIGNvaGVyZW5jeSBtYWludGVuYW5jZSkgcmVxdWlyZXMgdGhlDQo+ID4gICAgICAg
ICogdHJhbnNmZXIgYnVmZmVycyB0byBsaXZlIGluIHRoZWlyIG93biBjYWNoZSBsaW5lcy4NCj4g
PiAgICAgICAgKi8NCj4gPiAtICAgICB1aW50OF90ICAgICAgICAgICAgICAgICAgICAgICAgIGRh
dGFbNF0gX19fX2NhY2hlbGluZV9hbGlnbmVkOw0KPiA+ICsgICAgIHVpbnQ4X3QgICAgICAgICAg
ICAgICAgICAgICAgICAgcmVnX2RhdGFbNF0NCj4gPiBfX19fY2FjaGVsaW5lX2FsaWduZWQ7DQo+
ID4gKyAgICAgdWludDhfdCAgICAgICAgICAgICAgICAgICAgICAgICBidWZfZGF0YVsxNl0NCj4g
PiBfX19fY2FjaGVsaW5lX2FsaWduZWQ7DQo+IA0KPiBUaGUgdXN1YWwgYXNzdW1wdGlvbiBpcyB0
aGF0IGEgZGV2aWNlIGlzIHNhZmUgYWdhaW5zdCBpdHNlbGYsIHNvIHdlIGNhbid0DQo+IGdldCBj
YWNoZWxpbmUgY29ycnVwdGlvbiBpbiBhIHNpbmdsZSBhY3Rpb24gZnJvbSB0aGUgZGV2aWNlIHRv
IGl0c2VsZi4NCj4gVGhpcyBkb2VzIG1ha2UgbWUgd29uZGVyIHdoeSB3ZSBoYXZlIHR3byBidWZm
ZXJzIGxpa2UgdGhpcyBhdCBhbGwgdGhvdWdoIQ0KPiA+ICB9Ow0KPiA+IA0KPiA+ICBzdGF0aWMg
aW5saW5lIGludCBhZF9zaWdtYV9kZWx0YV9zZXRfY2hhbm5lbChzdHJ1Y3QgYWRfc2lnbWFfZGVs
dGENCj4gPiAqc2QsDQo+IA0KPiANCg==
