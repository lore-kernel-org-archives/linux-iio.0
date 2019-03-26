Return-Path: <SRS0=TPgR=R5=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D116C43381
	for <linux-iio@archiver.kernel.org>; Tue, 26 Mar 2019 06:54:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CAD32070B
	for <linux-iio@archiver.kernel.org>; Tue, 26 Mar 2019 06:54:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="W60yWBm4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731487AbfCZGyA (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Tue, 26 Mar 2019 02:54:00 -0400
Received: from mail-eopbgr760054.outbound.protection.outlook.com ([40.107.76.54]:36928
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730829AbfCZGyA (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 26 Mar 2019 02:54:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fa44W8lusuyTZlgFJ2JyD7thSXN3RKhCVorDhkc3BN4=;
 b=W60yWBm4tJnogMbTT0vTXqFuHigzQgarRRioMyocaARpJHBEjkxA9OMK2sDpBDuaNQmC2vkQHbGshcR19nrnP2wnWlGzHTe+0m6pwEp98dKRx2on0VZBLdAxSqXl1VPnbSzRIRlneGyXmxF4JeqA66BPSpYcKhZm/kzEjpSfjHc=
Received: from MWHPR03CA0023.namprd03.prod.outlook.com (2603:10b6:300:117::33)
 by BL2PR03MB546.namprd03.prod.outlook.com (2a01:111:e400:c24::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1730.15; Tue, 26 Mar
 2019 06:53:55 +0000
Received: from BL2NAM02FT011.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::201) by MWHPR03CA0023.outlook.office365.com
 (2603:10b6:300:117::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1730.19 via Frontend
 Transport; Tue, 26 Mar 2019 06:53:54 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 BL2NAM02FT011.mail.protection.outlook.com (10.152.77.5) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1750.11
 via Frontend Transport; Tue, 26 Mar 2019 06:53:54 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id x2Q6rsHi022242
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Mon, 25 Mar 2019 23:53:54 -0700
Received: from NWD2MBX7.ad.analog.com ([fe80::190e:f9c1:9a22:9663]) by
 NWD2HUBCAS7.ad.analog.com ([fe80::595b:ced1:cc03:539d%12]) with mapi id
 14.03.0415.000; Tue, 26 Mar 2019 02:53:54 -0400
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "jic23@jic23.retrosnub.co.uk" <jic23@jic23.retrosnub.co.uk>
CC:     "lars@metafoo.de" <lars@metafoo.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH] iio: ad_sigma_delta: Introduce prepare_channel callback
Thread-Topic: [PATCH] iio: ad_sigma_delta: Introduce prepare_channel callback
Thread-Index: AQHU3jmX4bWtHP/G6EaWDQUxT4MYyqYbWleAgAJtmwA=
Date:   Tue, 26 Mar 2019 06:53:52 +0000
Message-ID: <0c1d334e9369a64a2f7a5c563a82c21455cc2719.camel@analog.com>
References: <20190319095306.16010-1-alexandru.ardelean@analog.com>
         <20190324174903.77158070@archlinux>
In-Reply-To: <20190324174903.77158070@archlinux>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.50.1.244]
x-adiroutedonprem: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <2DFD226891770E459C8E1C4B4C6C2D75@analog.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(396003)(346002)(376002)(39860400002)(2980300002)(199004)(189003)(118296001)(76176011)(246002)(3846002)(14454004)(86362001)(5660300002)(2906002)(6116002)(4326008)(106002)(305945005)(2486003)(2616005)(7696005)(446003)(26005)(6346003)(426003)(5640700003)(2501003)(23676004)(8676002)(54906003)(102836004)(436003)(316002)(186003)(8936002)(106466001)(50466002)(6916009)(478600001)(36756003)(11346002)(14444005)(6246003)(7636002)(7736002)(486006)(229853002)(47776003)(2351001)(336012)(476003)(126002)(356004);DIR:OUT;SFP:1101;SCL:1;SRVR:BL2PR03MB546;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1e1425b4-3aa8-4cb7-1edb-08d6b1b7d014
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4709054)(2017052603328)(7153060)(7193020);SRVR:BL2PR03MB546;
X-MS-TrafficTypeDiagnostic: BL2PR03MB546:
X-Microsoft-Antispam-PRVS: <BL2PR03MB5460036430E0A0219839F18F95F0@BL2PR03MB546.namprd03.prod.outlook.com>
X-Forefront-PRVS: 09888BC01D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: ut1dZXWi62Fba0SejTcvNuJh8tXYOuDe2sXXos1JVYHimlidsv2E8BhDPZzCF8iTpNoCQ1eqmBEziE0t6uqnjLpBiJ8a7cZhHLplCgubOqPWUQ0+Me/3/P5rbOdjIXG0ZwflPm62edn4SqYXTyllT28w02fNF+JX7R5nrk3pGJ07W7FQZTP/nAKm9J/gdbMiX+HgKARn1/eyb878j8FVfFG9AL683zYQKPAeoo/EzaqOw8TpYXQdVHYbA+cii2YtNJ78lXHGSsQ2lBue8kQlnTOpe6+7e5TN5dUn2ibFa0F9HVNlekwUfmIODY5sB9N7QtfGvHPhShydgRmV4Vhwnrhit2zUnlWbUwihVCWHEjhIFhx7rIsxbmrfYzYvKiNMcI4U2UO6EVP41wJjA7A8Lfn4XhXQrKgyqJX0LK13d1k=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2019 06:53:54.6654
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e1425b4-3aa8-4cb7-1edb-08d6b1b7d014
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL2PR03MB546
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gU3VuLCAyMDE5LTAzLTI0IGF0IDE3OjQ5ICswMDAwLCBKb25hdGhhbiBDYW1lcm9uIHdyb3Rl
Og0KPiBbRXh0ZXJuYWxdDQo+IA0KPiANCj4gT24gVHVlLCAxOSBNYXIgMjAxOSAxMTo1MzowNiAr
MDIwMA0KPiBBbGV4YW5kcnUgQXJkZWxlYW4gPGFsZXhhbmRydS5hcmRlbGVhbkBhbmFsb2cuY29t
PiB3cm90ZToNCj4gDQo+ID4gRnJvbTogTGFycy1QZXRlciBDbGF1c2VuIDxsYXJzQG1ldGFmb28u
ZGU+DQo+ID4gDQo+ID4gVGhlIHByZXBhcmUgY2hhbm5lbCBjYWxsYmFjayB3aWxsIGJlIGNhbGxl
ZCBiZWZvcmUgc3RhcnRpbmcgYQ0KPiA+IGNvbnZlcnNpb24gYW5kDQo+ID4gY2FuIGJlIHVzZWQg
YnkgdGhlIGRyaXZlciB0byBjb25maWd1cmUgdGhlIGNoaXAgYWNjb3JkaW5nIHRvIHRoZQ0KPiA+
IHNlbGVjdGVkDQo+ID4gY2hhbm5lbC4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBMYXJzLVBl
dGVyIENsYXVzZW4gPGxhcnNAbWV0YWZvby5kZT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBBbGV4YW5k
cnUgQXJkZWxlYW4gPGFsZXhhbmRydS5hcmRlbGVhbkBhbmFsb2cuY29tPg0KPiANCj4gSGkgQWxl
eGFuZHJ1LA0KPiANCj4gTm90IHdpdGhvdXQgYSB1c2VyLi4uLiAgSS5lLiBJIHdhbnQgdG8gc2Vl
IGEgZHJpdmVyIHVzaW5nIHRoaXMgYmVmb3JlDQo+IEkgYXBwbHkgaXQuIEluIG9mIGl0c2VsZiwg
aXQgaXMgZmluZSBidXQgcmlnaHQgbm93IEkgY2FuJ3QgYW5zd2VyIHRoZQ0KPiAnd2h5PycgcXVl
c3Rpb24hDQoNCkFjay4NCldpbGwgcHV0IHRoaXMgaW50byBhIHNlcmllcyB0aGF0IGFkZHMgYSB1
c2VyIGZvciB0aGlzIHRvIG1ha2UgaXQgY2xlYXJlci4NCg0KQXQgdGhlIG1vbWVudCBJIHdhcyBq
dXN0IGNoZXJyeS1waWNraW5nIHBhdGNoZXMgZnJvbSBvdXIgdHJlZSwgc2VuZGluZyBiaXRzDQp0
aGF0IHdlcmUgZWFzaWVyIHRvIGFwcGx5LCBhbmQgZGVmZXJyaW5nIGJpdHMgdGhhdCBhcmUgbW9y
ZSBjb21wbGljYXRlZCB0bw0KcmUtYXBwbHkuDQoNClRoYW5rcw0KQWxleA0KDQo+IA0KPiBKb25h
dGhhbg0KPiANCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9paW8vYWRjL2FkX3NpZ21hX2RlbHRhLmMg
ICAgICAgfCAgNSArKysrKw0KPiA+ICBpbmNsdWRlL2xpbnV4L2lpby9hZGMvYWRfc2lnbWFfZGVs
dGEuaCB8IDEzICsrKysrKysrKysrKysNCj4gPiAgMiBmaWxlcyBjaGFuZ2VkLCAxOCBpbnNlcnRp
b25zKCspDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaWlvL2FkYy9hZF9zaWdtYV9k
ZWx0YS5jDQo+ID4gYi9kcml2ZXJzL2lpby9hZGMvYWRfc2lnbWFfZGVsdGEuYw0KPiA+IGluZGV4
IGZmNWYyZGEyZTFiMS4uMDA4MDg4MzhlZGQ4IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvaWlv
L2FkYy9hZF9zaWdtYV9kZWx0YS5jDQo+ID4gKysrIGIvZHJpdmVycy9paW8vYWRjL2FkX3NpZ21h
X2RlbHRhLmMNCj4gPiBAQCAtMjg1LDYgKzI4NSw3IEBAIGludCBhZF9zaWdtYV9kZWx0YV9zaW5n
bGVfY29udmVyc2lvbihzdHJ1Y3QgaWlvX2Rldg0KPiA+ICppbmRpb19kZXYsDQo+ID4gICAgICAg
ICAgICAgICByZXR1cm4gLUVCVVNZOw0KPiA+IA0KPiA+ICAgICAgIG11dGV4X2xvY2soJmluZGlv
X2Rldi0+bWxvY2spOw0KPiA+ICsgICAgIGFkX3NpZ21hX2RlbHRhX3ByZXBhcmVfY2hhbm5lbChz
aWdtYV9kZWx0YSwgY2hhbik7DQo+ID4gICAgICAgYWRfc2lnbWFfZGVsdGFfc2V0X2NoYW5uZWwo
c2lnbWFfZGVsdGEsIGNoYW4tPmFkZHJlc3MpOw0KPiA+IA0KPiA+ICAgICAgIHNwaV9idXNfbG9j
ayhzaWdtYV9kZWx0YS0+c3BpLT5tYXN0ZXIpOw0KPiA+IEBAIC0zNTEsNiArMzUyLDEwIEBAIHN0
YXRpYyBpbnQgYWRfc2RfYnVmZmVyX3Bvc3RlbmFibGUoc3RydWN0IGlpb19kZXYNCj4gPiAqaW5k
aW9fZGV2KQ0KPiA+IA0KPiA+ICAgICAgIGNoYW5uZWwgPSBmaW5kX2ZpcnN0X2JpdChpbmRpb19k
ZXYtPmFjdGl2ZV9zY2FuX21hc2ssDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IGluZGlvX2Rldi0+bWFza2xlbmd0aCk7DQo+ID4gKyAgICAgcmV0ID0gYWRfc2lnbWFfZGVsdGFf
cHJlcGFyZV9jaGFubmVsKHNpZ21hX2RlbHRhLA0KPiA+ICsgICAgICAgICAgICAgJmluZGlvX2Rl
di0+Y2hhbm5lbHNbY2hhbm5lbF0pOw0KPiA+ICsgICAgIGlmIChyZXQpDQo+ID4gKyAgICAgICAg
ICAgICBnb3RvIGVycl9wcmVkaXNhYmxlOw0KPiA+ICAgICAgIHJldCA9IGFkX3NpZ21hX2RlbHRh
X3NldF9jaGFubmVsKHNpZ21hX2RlbHRhLA0KPiA+ICAgICAgICAgICAgICAgaW5kaW9fZGV2LT5j
aGFubmVsc1tjaGFubmVsXS5hZGRyZXNzKTsNCj4gPiAgICAgICBpZiAocmV0KQ0KPiA+IGRpZmYg
LS1naXQgYS9pbmNsdWRlL2xpbnV4L2lpby9hZGMvYWRfc2lnbWFfZGVsdGEuaA0KPiA+IGIvaW5j
bHVkZS9saW51eC9paW8vYWRjL2FkX3NpZ21hX2RlbHRhLmgNCj4gPiBpbmRleCA3ZTg0MzUxZmEy
YzAuLjIxZWUxMjU0M2JkZCAxMDA2NDQNCj4gPiAtLS0gYS9pbmNsdWRlL2xpbnV4L2lpby9hZGMv
YWRfc2lnbWFfZGVsdGEuaA0KPiA+ICsrKyBiL2luY2x1ZGUvbGludXgvaWlvL2FkYy9hZF9zaWdt
YV9kZWx0YS5oDQo+ID4gQEAgLTMxLDYgKzMxLDggQEAgc3RydWN0IGlpb19kZXY7DQo+ID4gDQo+
ID4gIC8qKg0KPiA+ICAgKiBzdHJ1Y3QgYWRfc2lnbWFfZGVsdGFfaW5mbyAtIFNpZ21hIERlbHRh
IGRyaXZlciBzcGVjaWZpYyBjYWxsYmFja3MNCj4gPiBhbmQgb3B0aW9ucw0KPiA+ICsgKiBAcHJl
cGFyZV9jaGFubmVsOiBXaWxsIGJlIGNhbGxlZCB0byBwcmVwYXJlIGFuZCBjb25maWd1cmUgYQ0K
PiA+IGNoYW5uZWwsIG1heSBiZQ0KPiA+ICsgKiAgICAgICAgICAgICAgICAgICBOVUxMLg0KPiA+
ICAgKiBAc2V0X2NoYW5uZWw6IFdpbGwgYmUgY2FsbGVkIHRvIHNlbGVjdCB0aGUgY3VycmVudCBj
aGFubmVsLCBtYXkgYmUNCj4gPiBOVUxMLg0KPiA+ICAgKiBAc2V0X21vZGU6IFdpbGwgYmUgY2Fs
bGVkIHRvIHNlbGVjdCB0aGUgY3VycmVudCBtb2RlLCBtYXkgYmUgTlVMTC4NCj4gPiAgICogQHBv
c3Rwcm9jZXNzX3NhbXBsZTogSXMgY2FsbGVkIGZvciBlYWNoIHNhbXBsZWQgZGF0YSB3b3JkLCBj
YW4gYmUNCj4gPiB1c2VkIHRvDQo+ID4gQEAgLTQzLDYgKzQ1LDggQEAgc3RydWN0IGlpb19kZXY7
DQo+ID4gICAqICAgYmUgdXNlZC4NCj4gPiAgICovDQo+ID4gIHN0cnVjdCBhZF9zaWdtYV9kZWx0
YV9pbmZvIHsNCj4gPiArICAgICBpbnQgKCpwcmVwYXJlX2NoYW5uZWwpKHN0cnVjdCBhZF9zaWdt
YV9kZWx0YSAqLA0KPiA+ICsgICAgICAgICAgICAgY29uc3Qgc3RydWN0IGlpb19jaGFuX3NwZWMg
Kik7DQo+ID4gICAgICAgaW50ICgqc2V0X2NoYW5uZWwpKHN0cnVjdCBhZF9zaWdtYV9kZWx0YSAq
LCB1bnNpZ25lZCBpbnQNCj4gPiBjaGFubmVsKTsNCj4gPiAgICAgICBpbnQgKCpzZXRfbW9kZSko
c3RydWN0IGFkX3NpZ21hX2RlbHRhICosIGVudW0gYWRfc2lnbWFfZGVsdGFfbW9kZQ0KPiA+IG1v
ZGUpOw0KPiA+ICAgICAgIGludCAoKnBvc3Rwcm9jZXNzX3NhbXBsZSkoc3RydWN0IGFkX3NpZ21h
X2RlbHRhICosIHVuc2lnbmVkIGludA0KPiA+IHJhd19zYW1wbGUpOw0KPiA+IEBAIC04MSw2ICs4
NSwxNSBAQCBzdHJ1Y3QgYWRfc2lnbWFfZGVsdGEgew0KPiA+ICAgICAgIHVpbnQ4X3QgICAgICAg
ICAgICAgICAgICAgICAgICAgZGF0YVs0XSBfX19fY2FjaGVsaW5lX2FsaWduZWQ7DQo+ID4gIH07
DQo+ID4gDQo+ID4gK3N0YXRpYyBpbmxpbmUgaW50IGFkX3NpZ21hX2RlbHRhX3ByZXBhcmVfY2hh
bm5lbChzdHJ1Y3QgYWRfc2lnbWFfZGVsdGENCj4gPiAqc2QsDQo+ID4gKyAgICAgY29uc3Qgc3Ry
dWN0IGlpb19jaGFuX3NwZWMgKmNoYW4pDQo+ID4gK3sNCj4gPiArICAgICBpZiAoc2QtPmluZm8t
PnByZXBhcmVfY2hhbm5lbCkNCj4gPiArICAgICAgICAgICAgIHJldHVybiBzZC0+aW5mby0+cHJl
cGFyZV9jaGFubmVsKHNkLCBjaGFuKTsNCj4gPiArDQo+ID4gKyAgICAgcmV0dXJuIDA7DQo+ID4g
K30NCj4gPiArDQo+ID4gIHN0YXRpYyBpbmxpbmUgaW50IGFkX3NpZ21hX2RlbHRhX3NldF9jaGFu
bmVsKHN0cnVjdCBhZF9zaWdtYV9kZWx0YQ0KPiA+ICpzZCwNCj4gPiAgICAgICB1bnNpZ25lZCBp
bnQgY2hhbm5lbCkNCj4gPiAgew0KPiANCj4gDQo=
