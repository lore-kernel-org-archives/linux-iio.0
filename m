Return-Path: <SRS0=ZeA0=SR=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03D84C10F0E
	for <linux-iio@archiver.kernel.org>; Mon, 15 Apr 2019 06:52:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A737D20693
	for <linux-iio@archiver.kernel.org>; Mon, 15 Apr 2019 06:52:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="Yiq97yjQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725796AbfDOGwn (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Mon, 15 Apr 2019 02:52:43 -0400
Received: from mail-eopbgr800044.outbound.protection.outlook.com ([40.107.80.44]:58496
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725794AbfDOGwm (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 15 Apr 2019 02:52:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E5xC+7PIBh3bBgPDouTQlxCJNf1HxNikmAPpPAPsjGc=;
 b=Yiq97yjQTG9KQfY9StVDCTu/XEfJXzxl0OzmPKcOIEGFi38uXQVfUPZ8Z/dUUb2577OKZvFmLt5qvIc5cQ/tU6lCMlJWJkxj9PxpR3D4syZ61JPHQZWzOShVqmKWZLCSKn9DxO7q1KklNXhD/LkKk16kPKX9aMG9UYmE12vnVDo=
Received: from DM3PR03CA0011.namprd03.prod.outlook.com (2603:10b6:0:50::21) by
 BL2PR03MB545.namprd03.prod.outlook.com (2a01:111:e400:c23::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1792.19; Mon, 15 Apr 2019 06:52:27 +0000
Received: from BL2NAM02FT050.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::208) by DM3PR03CA0011.outlook.office365.com
 (2603:10b6:0:50::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1792.14 via Frontend
 Transport; Mon, 15 Apr 2019 06:52:26 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.57)
 smtp.mailfrom=analog.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 BL2NAM02FT050.mail.protection.outlook.com (10.152.77.101) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1771.16
 via Frontend Transport; Mon, 15 Apr 2019 06:52:26 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id x3F6qPNk025310
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Sun, 14 Apr 2019 23:52:25 -0700
Received: from NWD2MBX7.ad.analog.com ([fe80::190e:f9c1:9a22:9663]) by
 NWD2HUBCAS7.ad.analog.com ([fe80::595b:ced1:cc03:539d%12]) with mapi id
 14.03.0415.000; Mon, 15 Apr 2019 02:52:25 -0400
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "jic23@jic23.retrosnub.co.uk" <jic23@jic23.retrosnub.co.uk>
CC:     "lars@metafoo.de" <lars@metafoo.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH] iio: ad_sigma_delta: Don't put SPI transfer buffer on
 the stack
Thread-Topic: [PATCH] iio: ad_sigma_delta: Don't put SPI transfer buffer on
 the stack
Thread-Index: AQHU7qoCGCr7DVXr3EO10B191NLx3qY75a8AgAEvmAA=
Date:   Mon, 15 Apr 2019 06:52:24 +0000
Message-ID: <516c63ea3a7190d4b45500faa9603c0ad74c1288.camel@analog.com>
References: <20190409075821.26104-1-alexandru.ardelean@analog.com>
         <20190414134546.1e9a3907@archlinux>
In-Reply-To: <20190414134546.1e9a3907@archlinux>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.50.1.244]
x-adiroutedonprem: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <6AB8B1CF51880740879A68B28542E932@analog.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(396003)(136003)(346002)(376002)(2980300002)(189003)(199004)(54906003)(316002)(106002)(14444005)(336012)(106466001)(6246003)(36756003)(102836004)(8936002)(8676002)(47776003)(5640700003)(476003)(246002)(2616005)(305945005)(5660300002)(2351001)(7696005)(2486003)(486006)(23676004)(2501003)(446003)(229853002)(436003)(426003)(86362001)(4326008)(7636002)(14454004)(76176011)(6916009)(7736002)(356004)(118296001)(50466002)(11346002)(478600001)(26005)(3846002)(6116002)(2906002)(126002)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:BL2PR03MB545;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d0dd7092-5b5a-48da-285d-08d6c16eebdf
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600140)(711020)(4605104)(4709054)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:BL2PR03MB545;
X-MS-TrafficTypeDiagnostic: BL2PR03MB545:
X-Microsoft-Antispam-PRVS: <BL2PR03MB54567D1FB9C390F9DD6F7C5F92B0@BL2PR03MB545.namprd03.prod.outlook.com>
X-Forefront-PRVS: 000800954F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: CHhgK45inl04UzdkqfalhwCNExtXd2v156KyCS7b2nvN93/N22yFNvBcDhH5HSO9GN+GbOKuneml62mPROzwIAmXnnB89Upwdrc9O536nqHAkh3ZDXlKLxnAXj2iAzuSjtQo6pv7M4Ai3AfH3qcgPlYQFGKsQarPPweiSQYLqYirp4jhRhdOf32bLFO73GgYYzqXpXoi/9H4RTFCXOxmWNGKhtnIKe0CihZwY7juQDxE5HKbc6Kd/UNcGL7tIb5hfdopDajCXfmJK7Gjwk3rE4W07B4d/6S1fXpjhgqgdKhFXhkbsMaMiLLAYig6DVNd2QULGY20V0C/Ww5ZZ2Kmh1/0v7YJvKmd8QuUj345a6oD2+QyMRF+l8n96eWB6Hnf2pjYc2MvNls/WuelOdLhGJb/fSiiK/xr4saDApbQlXg=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2019 06:52:26.6387
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d0dd7092-5b5a-48da-285d-08d6c16eebdf
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL2PR03MB545
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gU3VuLCAyMDE5LTA0LTE0IGF0IDEzOjQ1ICswMTAwLCBKb25hdGhhbiBDYW1lcm9uIHdyb3Rl
Og0KPiBbRXh0ZXJuYWxdDQo+IA0KPiANCj4gT24gVHVlLCA5IEFwciAyMDE5IDEwOjU4OjIxICsw
MzAwDQo+IEFsZXhhbmRydSBBcmRlbGVhbiA8YWxleGFuZHJ1LmFyZGVsZWFuQGFuYWxvZy5jb20+
IHdyb3RlOg0KPiANCj4gPiBGcm9tOiBMYXJzLVBldGVyIENsYXVzZW4gPGxhcnNAbWV0YWZvby5k
ZT4NCj4gPiANCj4gPiBVc2UgYSBoZWFwIGFsbG9jYXRlZCBtZW1vcnkgZm9yIHRoZSBTUEkgdHJh
bnNmZXIgYnVmZmVyLiBVc2luZyBzdGFjaw0KPiA+IG1lbW9yeQ0KPiA+IHdpbGwgbm90IHdvcmsg
b24gc29tZSBhcmNoaXRlY3R1cmVzIHdoZW4gdXNpbmcgRE1BLg0KPiA+IA0KPiA+IFNpZ25lZC1v
ZmYtYnk6IExhcnMtUGV0ZXIgQ2xhdXNlbiA8bGFyc0BtZXRhZm9vLmRlPg0KPiA+IFNpZ25lZC1v
ZmYtYnk6IEFsZXhhbmRydSBBcmRlbGVhbiA8YWxleGFuZHJ1LmFyZGVsZWFuQGFuYWxvZy5jb20+
DQo+IA0KPiBZaWtlcywgc3VycHJpc2VkIHRoaXMgb25lIHNudWNrIGluIGhlcmUuDQo+ID4gLS0t
DQo+ID4gDQo+ID4gTm90ZTogdGhpcyBkb2Vzbid0IG5lZWQgYSBzdGFibGUvZml4ZXMgdGFnLiBJ
dCdzIG1vcmUgb2YgYW4NCj4gPiBlbmhhbmNlbWVudC4NCj4gDQo+IFRhbGsgbWUgdGhyb3VnaCB0
aGlzLi4uICBSaWdodCBub3cgSSB0aGluayB0aGlzIGlzIGEgYnVnIHRoYXQgaXMgZ29pbmcNCj4g
dG8gY2F1c2UgcmFuZG9tIGFuZCBleHRyZW1lbHkgaGFyZCB0byBkZWJ1ZyBwcm9ibGVtcy4gIEkn
dmUgaGFkIHRoZXNlDQo+IGluIHRoZSBwYXN0IGFuZCB0aGV5IGFyZSByZWFsbHkgcmVhbGx5IG5h
c3R5IGFzIGl0J3MgcmFuZG9tIHN0YWNrDQo+IGNvcnJ1cHRpb24uDQo+IFRoZSBuYXN0eSBpcyBu
b3QgdGhlIGZhY3QgaXQncyBvbiB0aGUgc3RhY2ssIGJ1dCB0aGUgZmFjdCB0aGF0IGl0IGlzbid0
DQo+IGluIGl0J3Mgb3duIGNhY2hlbGluZS4NCj4gDQo+IFNvIG15IGluY2xpbmF0aW9uIGlzIHRo
aXMgZGVmaW5pdGVseSBuZWVkcyBzdGFibGUgYW5kIGZpeGVzIHRhZy4NCj4gV2hhdCBhbSBJIG1p
c3Npbmc/DQoNCkkgZ3Vlc3MgSSdtIG5vdCB0aGF0IGdyZWF0IHdpdGggZGlzY2VybmluZyBzdHVm
ZiAoYWJvdXQgd2hldGhlciBpdCBuZWVkcyBhDQpzdGFibGUgJiBmaXhlcyB0YWcpLg0KSSBndWVz
cyBJJ20gc3RpbGwgaW4gYW4gZWFybHkgcGhhc2Ugd2l0aCB0aGlzIG9uZS4NCg0KTXkgc2VudGlt
ZW50LCBpcyB0aGF0IHRoZXJlIGhhdmVuJ3QgYmVlbiBlbm91Z2ggc3VwcG9ydCBxdWVzdGlvbnMg
YWJvdXQNCndlaXJkIGlzc3VlcyB3aXRoIHNpZ21hLWRlbHRhIHRvIGhhdmUgY2F0ZWdvcml6ZWQg
dGhpcyBlYXJsaWVyLg0KDQpCdXQsIEkgZ3Vlc3MgeW91J3JlIHJpZ2h0LiBUaGlzIGNvdWxkIGRv
IHdpdGggYSBGaXhlcy9zdGFibGUgdGFnLg0KDQpUaGFua3MNCkFsZXgNCg0KPiANCj4gSm9uYXRo
YW4NCj4gDQo+ID4gDQo+ID4gIGRyaXZlcnMvaWlvL2FkYy9hZF9zaWdtYV9kZWx0YS5jICAgICAg
IHwgMjIgKysrKysrKysrKystLS0tLS0tLS0tLQ0KPiA+ICBpbmNsdWRlL2xpbnV4L2lpby9hZGMv
YWRfc2lnbWFfZGVsdGEuaCB8ICAzICsrLQ0KPiA+ICAyIGZpbGVzIGNoYW5nZWQsIDEzIGluc2Vy
dGlvbnMoKyksIDEyIGRlbGV0aW9ucygtKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L2lpby9hZGMvYWRfc2lnbWFfZGVsdGEuYw0KPiA+IGIvZHJpdmVycy9paW8vYWRjL2FkX3NpZ21h
X2RlbHRhLmMNCj4gPiBpbmRleCBhZjZjYmM2ODMyMTQuLjAyZDkwNDliOTIxOCAxMDA2NDQNCj4g
PiAtLS0gYS9kcml2ZXJzL2lpby9hZGMvYWRfc2lnbWFfZGVsdGEuYw0KPiA+ICsrKyBiL2RyaXZl
cnMvaWlvL2FkYy9hZF9zaWdtYV9kZWx0YS5jDQo+ID4gQEAgLTU4LDcgKzU4LDcgQEAgRVhQT1JU
X1NZTUJPTF9HUEwoYWRfc2Rfc2V0X2NvbW0pOw0KPiA+ICBpbnQgYWRfc2Rfd3JpdGVfcmVnKHN0
cnVjdCBhZF9zaWdtYV9kZWx0YSAqc2lnbWFfZGVsdGEsIHVuc2lnbmVkIGludA0KPiA+IHJlZywN
Cj4gPiAgICAgICB1bnNpZ25lZCBpbnQgc2l6ZSwgdW5zaWduZWQgaW50IHZhbCkNCj4gPiAgew0K
PiA+IC0gICAgIHVpbnQ4X3QgKmRhdGEgPSBzaWdtYV9kZWx0YS0+ZGF0YTsNCj4gPiArICAgICB1
aW50OF90ICpkYXRhID0gc2lnbWFfZGVsdGEtPnJlZ19kYXRhOw0KPiA+ICAgICAgIHN0cnVjdCBz
cGlfdHJhbnNmZXIgdCA9IHsNCj4gPiAgICAgICAgICAgICAgIC50eF9idWYgICAgICAgICA9IGRh
dGEsDQo+ID4gICAgICAgICAgICAgICAubGVuICAgICAgICAgICAgPSBzaXplICsgMSwNCj4gPiBA
QCAtMTAyLDcgKzEwMiw3IEBAIEVYUE9SVF9TWU1CT0xfR1BMKGFkX3NkX3dyaXRlX3JlZyk7DQo+
ID4gIHN0YXRpYyBpbnQgYWRfc2RfcmVhZF9yZWdfcmF3KHN0cnVjdCBhZF9zaWdtYV9kZWx0YSAq
c2lnbWFfZGVsdGEsDQo+ID4gICAgICAgdW5zaWduZWQgaW50IHJlZywgdW5zaWduZWQgaW50IHNp
emUsIHVpbnQ4X3QgKnZhbCkNCj4gPiAgew0KPiA+IC0gICAgIHVpbnQ4X3QgKmRhdGEgPSBzaWdt
YV9kZWx0YS0+ZGF0YTsNCj4gPiArICAgICB1aW50OF90ICpkYXRhID0gc2lnbWFfZGVsdGEtPnJl
Z19kYXRhOw0KPiA+ICAgICAgIGludCByZXQ7DQo+ID4gICAgICAgc3RydWN0IHNwaV90cmFuc2Zl
ciB0W10gPSB7DQo+ID4gICAgICAgICAgICAgICB7DQo+ID4gQEAgLTE0OCwyNCArMTQ4LDI0IEBA
IGludCBhZF9zZF9yZWFkX3JlZyhzdHJ1Y3QgYWRfc2lnbWFfZGVsdGENCj4gPiAqc2lnbWFfZGVs
dGEsDQo+ID4gIHsNCj4gPiAgICAgICBpbnQgcmV0Ow0KPiA+IA0KPiA+IC0gICAgIHJldCA9IGFk
X3NkX3JlYWRfcmVnX3JhdyhzaWdtYV9kZWx0YSwgcmVnLCBzaXplLCBzaWdtYV9kZWx0YS0NCj4g
PiA+ZGF0YSk7DQo+ID4gKyAgICAgcmV0ID0gYWRfc2RfcmVhZF9yZWdfcmF3KHNpZ21hX2RlbHRh
LCByZWcsIHNpemUsIHNpZ21hX2RlbHRhLQ0KPiA+ID5yZWdfZGF0YSk7DQo+ID4gICAgICAgaWYg
KHJldCA8IDApDQo+ID4gICAgICAgICAgICAgICBnb3RvIG91dDsNCj4gPiANCj4gPiAgICAgICBz
d2l0Y2ggKHNpemUpIHsNCj4gPiAgICAgICBjYXNlIDQ6DQo+ID4gLSAgICAgICAgICAgICAqdmFs
ID0gZ2V0X3VuYWxpZ25lZF9iZTMyKHNpZ21hX2RlbHRhLT5kYXRhKTsNCj4gPiArICAgICAgICAg
ICAgICp2YWwgPSBnZXRfdW5hbGlnbmVkX2JlMzIoc2lnbWFfZGVsdGEtPnJlZ19kYXRhKTsNCj4g
PiAgICAgICAgICAgICAgIGJyZWFrOw0KPiA+ICAgICAgIGNhc2UgMzoNCj4gPiAtICAgICAgICAg
ICAgICp2YWwgPSAoc2lnbWFfZGVsdGEtPmRhdGFbMF0gPDwgMTYpIHwNCj4gPiAtICAgICAgICAg
ICAgICAgICAgICAgKHNpZ21hX2RlbHRhLT5kYXRhWzFdIDw8IDgpIHwNCj4gPiAtICAgICAgICAg
ICAgICAgICAgICAgc2lnbWFfZGVsdGEtPmRhdGFbMl07DQo+ID4gKyAgICAgICAgICAgICAqdmFs
ID0gKHNpZ21hX2RlbHRhLT5yZWdfZGF0YVswXSA8PCAxNikgfA0KPiA+ICsgICAgICAgICAgICAg
ICAgICAgICAoc2lnbWFfZGVsdGEtPnJlZ19kYXRhWzFdIDw8IDgpIHwNCj4gPiArICAgICAgICAg
ICAgICAgICAgICAgc2lnbWFfZGVsdGEtPnJlZ19kYXRhWzJdOw0KPiA+ICAgICAgICAgICAgICAg
YnJlYWs7DQo+ID4gICAgICAgY2FzZSAyOg0KPiA+IC0gICAgICAgICAgICAgKnZhbCA9IGdldF91
bmFsaWduZWRfYmUxNihzaWdtYV9kZWx0YS0+ZGF0YSk7DQo+ID4gKyAgICAgICAgICAgICAqdmFs
ID0gZ2V0X3VuYWxpZ25lZF9iZTE2KHNpZ21hX2RlbHRhLT5yZWdfZGF0YSk7DQo+ID4gICAgICAg
ICAgICAgICBicmVhazsNCj4gPiAgICAgICBjYXNlIDE6DQo+ID4gLSAgICAgICAgICAgICAqdmFs
ID0gc2lnbWFfZGVsdGEtPmRhdGFbMF07DQo+ID4gKyAgICAgICAgICAgICAqdmFsID0gc2lnbWFf
ZGVsdGEtPnJlZ19kYXRhWzBdOw0KPiA+ICAgICAgICAgICAgICAgYnJlYWs7DQo+ID4gICAgICAg
ZGVmYXVsdDoNCj4gPiAgICAgICAgICAgICAgIHJldCA9IC1FSU5WQUw7DQo+ID4gQEAgLTQwMywx
MiArNDAzLDEyIEBAIHN0YXRpYyBpcnFyZXR1cm5fdCBhZF9zZF90cmlnZ2VyX2hhbmRsZXIoaW50
IGlycSwNCj4gPiB2b2lkICpwKQ0KPiA+ICAgICAgIHN0cnVjdCBpaW9fcG9sbF9mdW5jICpwZiA9
IHA7DQo+ID4gICAgICAgc3RydWN0IGlpb19kZXYgKmluZGlvX2RldiA9IHBmLT5pbmRpb19kZXY7
DQo+ID4gICAgICAgc3RydWN0IGFkX3NpZ21hX2RlbHRhICpzaWdtYV9kZWx0YSA9DQo+ID4gaWlv
X2RldmljZV9nZXRfZHJ2ZGF0YShpbmRpb19kZXYpOw0KPiA+ICsgICAgIHVpbnQ4X3QgKmRhdGEg
PSBzaWdtYV9kZWx0YS0+YnVmX2RhdGE7DQo+ID4gICAgICAgdW5zaWduZWQgaW50IHJlZ19zaXpl
Ow0KPiA+ICAgICAgIHVuc2lnbmVkIGludCBkYXRhX3JlZzsNCj4gPiAtICAgICB1aW50OF90IGRh
dGFbMTZdOw0KPiA+ICAgICAgIGludCByZXQ7DQo+ID4gDQo+ID4gLSAgICAgbWVtc2V0KGRhdGEs
IDB4MDAsIDE2KTsNCj4gPiArICAgICBtZW1zZXQoc2lnbWFfZGVsdGEtPmJ1Zl9kYXRhLCAweDAw
LCBzaXplb2Yoc2lnbWFfZGVsdGEtDQo+ID4gPmJ1Zl9kYXRhKSk7DQo+ID4gDQo+ID4gICAgICAg
cmVnX3NpemUgPSBpbmRpb19kZXYtPmNoYW5uZWxzWzBdLnNjYW5fdHlwZS5yZWFsYml0cyArDQo+
ID4gICAgICAgICAgICAgICAgICAgICAgIGluZGlvX2Rldi0+Y2hhbm5lbHNbMF0uc2Nhbl90eXBl
LnNoaWZ0Ow0KPiA+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L2lpby9hZGMvYWRfc2lnbWFf
ZGVsdGEuaA0KPiA+IGIvaW5jbHVkZS9saW51eC9paW8vYWRjL2FkX3NpZ21hX2RlbHRhLmgNCj4g
PiBpbmRleCA2ZTlmYjE5MzJkZGUuLmZiNzdiMmViZTQ5OCAxMDA2NDQNCj4gPiAtLS0gYS9pbmNs
dWRlL2xpbnV4L2lpby9hZGMvYWRfc2lnbWFfZGVsdGEuaA0KPiA+ICsrKyBiL2luY2x1ZGUvbGlu
dXgvaWlvL2FkYy9hZF9zaWdtYV9kZWx0YS5oDQo+ID4gQEAgLTc5LDcgKzc5LDggQEAgc3RydWN0
IGFkX3NpZ21hX2RlbHRhIHsNCj4gPiAgICAgICAgKiBETUEgKHRodXMgY2FjaGUgY29oZXJlbmN5
IG1haW50ZW5hbmNlKSByZXF1aXJlcyB0aGUNCj4gPiAgICAgICAgKiB0cmFuc2ZlciBidWZmZXJz
IHRvIGxpdmUgaW4gdGhlaXIgb3duIGNhY2hlIGxpbmVzLg0KPiA+ICAgICAgICAqLw0KPiA+IC0g
ICAgIHVpbnQ4X3QgICAgICAgICAgICAgICAgICAgICAgICAgZGF0YVs0XSBfX19fY2FjaGVsaW5l
X2FsaWduZWQ7DQo+ID4gKyAgICAgdWludDhfdCAgICAgICAgICAgICAgICAgICAgICAgICByZWdf
ZGF0YVs0XQ0KPiA+IF9fX19jYWNoZWxpbmVfYWxpZ25lZDsNCj4gPiArICAgICB1aW50OF90ICAg
ICAgICAgICAgICAgICAgICAgICAgIGJ1Zl9kYXRhWzE2XTsNCj4gPiAgfTsNCj4gPiANCj4gPiAg
c3RhdGljIGlubGluZSBpbnQgYWRfc2lnbWFfZGVsdGFfc2V0X2NoYW5uZWwoc3RydWN0IGFkX3Np
Z21hX2RlbHRhDQo+ID4gKnNkLA0KPiANCj4gDQo=
