Return-Path: <SRS0=cU5P=SD=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4815EC43381
	for <linux-iio@archiver.kernel.org>; Mon,  1 Apr 2019 06:05:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 033922084B
	for <linux-iio@archiver.kernel.org>; Mon,  1 Apr 2019 06:05:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="kTalr5Bt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731593AbfDAGFs (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Mon, 1 Apr 2019 02:05:48 -0400
Received: from mail-eopbgr730041.outbound.protection.outlook.com ([40.107.73.41]:28860
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726610AbfDAGFs (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 1 Apr 2019 02:05:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zzR+T6GznmJ6w5ymmzGM9ZcH3tqq7PcotUleCueBTVw=;
 b=kTalr5BtjRcMTVv5wMaw8H46K72kjyAbUro0vFTy3KegIBzvGbCAaPBhpufp/mGA522zTM51h0fsufOgNg+Lv0TIogkF+LR+k60D1dMK1tu86w9QH/fNypYID2h5MEBN2TW3ZcWrklSSs37DYYFjYnDxpYMyIdyRytZFT3sv56M=
Received: from CY4PR03CA0095.namprd03.prod.outlook.com (2603:10b6:910:4d::36)
 by CY4PR03MB3125.namprd03.prod.outlook.com (2603:10b6:910:53::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1750.19; Mon, 1 Apr
 2019 06:05:44 +0000
Received: from BL2NAM02FT022.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::201) by CY4PR03CA0095.outlook.office365.com
 (2603:10b6:910:4d::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1750.15 via Frontend
 Transport; Mon, 1 Apr 2019 06:05:44 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.55)
 smtp.mailfrom=analog.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 BL2NAM02FT022.mail.protection.outlook.com (10.152.77.153) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1750.16
 via Frontend Transport; Mon, 1 Apr 2019 06:05:44 +0000
Received: from NWD2HUBCAS8.ad.analog.com (nwd2hubcas8.ad.analog.com [10.64.69.108])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id x3165hF2015412
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Sun, 31 Mar 2019 23:05:43 -0700
Received: from NWD2MBX7.ad.analog.com ([fe80::190e:f9c1:9a22:9663]) by
 NWD2HUBCAS8.ad.analog.com ([fe80::90a0:b93e:53c6:afee%12]) with mapi id
 14.03.0415.000; Mon, 1 Apr 2019 02:05:43 -0400
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "jic23@jic23.retrosnub.co.uk" <jic23@jic23.retrosnub.co.uk>
CC:     "lars@metafoo.de" <lars@metafoo.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH V2] iio: frequency: ad9523: Fix typo in
 ad9523_platform_data
Thread-Topic: [PATCH V2] iio: frequency: ad9523: Fix typo in
 ad9523_platform_data
Thread-Index: AQHU49lsLTLRH61qEUS7SnqlzhPtAaYkn7sAgAJ9gAA=
Date:   Mon, 1 Apr 2019 06:05:43 +0000
Message-ID: <b8ea8e94a1a9df15f4479429752ea4349d898062.camel@analog.com>
References: <20190326134003.18371-1-alexandru.ardelean@analog.com>
         <20190330160400.5c70ec5e@archlinux>
In-Reply-To: <20190330160400.5c70ec5e@archlinux>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.50.1.244]
x-adiroutedonprem: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <8F1F48463A20E74D85CDF8296AAB9118@analog.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(396003)(376002)(39860400002)(136003)(2980300002)(189003)(199004)(54534003)(6246003)(4326008)(102836004)(36756003)(5660300002)(106002)(6916009)(2351001)(26005)(7696005)(2501003)(356004)(23676004)(7636002)(2486003)(305945005)(106466001)(50466002)(186003)(14454004)(118296001)(11346002)(8676002)(316002)(486006)(54906003)(126002)(8936002)(86362001)(229853002)(336012)(2616005)(446003)(2906002)(426003)(7736002)(5640700003)(246002)(6116002)(478600001)(3846002)(436003)(47776003)(476003)(76176011);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR03MB3125;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b024b442-a99d-4adb-2e91-08d6b66813ca
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600139)(711020)(4605104)(4709054)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:CY4PR03MB3125;
X-MS-TrafficTypeDiagnostic: CY4PR03MB3125:
X-Microsoft-Antispam-PRVS: <CY4PR03MB3125D3409B22A75D0CD688F1F9550@CY4PR03MB3125.namprd03.prod.outlook.com>
X-Forefront-PRVS: 0994F5E0C5
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: XGC46uATJsp45HnZNysi5DPvgVga985xGc0t127A3Xz0x0lj5XjkCqPxPTzScXpnuHau9k5BEF18k3CjH81T7RdoRXow/CfS74CDocPWSjROofKie/OJzGDN2+nd/RNHcwvqsPs5Z/TFAeaBdoUcB/Mx8oDQB0FoTkaYKXLuCMpIaj+09UMnJR/qk6hG7aIzsQ+NQpjf85wl6vRFqiQIaGHRmCO2SLd2nO1KQ9VbByClVCc9w1kjuNua+wquhKWG+AJHG3zEu7HUqeN1P1NehzXM6X1Tn0F2JYzcMl2EJ8iN9qcEEnnj1/GpUh8Sdr4bU3MT6+6v1ByVB7YdRhGXAwfDSH+wOCbqjZ7OBP5iOE40foNeIN3rMQhSlmJNVW6LdxfGLaZk4hKnZ7BKQWszPkHvVfffjahuMTQm/OM1i1I=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2019 06:05:44.3284
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b024b442-a99d-4adb-2e91-08d6b66813ca
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR03MB3125
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gU2F0LCAyMDE5LTAzLTMwIGF0IDE2OjA0ICswMDAwLCBKb25hdGhhbiBDYW1lcm9uIHdyb3Rl
Og0KPiBbRXh0ZXJuYWxdDQo+IA0KPiANCj4gT24gVHVlLCAyNiBNYXIgMjAxOSAxNTo0MDowMyAr
MDIwMA0KPiBBbGV4YW5kcnUgQXJkZWxlYW4gPGFsZXhhbmRydS5hcmRlbGVhbkBhbmFsb2cuY29t
PiB3cm90ZToNCj4gDQo+ID4gRnJvbTogTGFycy1QZXRlciBDbGF1c2VuIDxsYXJzQG1ldGFmb28u
ZGU+DQo+ID4gDQo+ID4gUmVwbGFjZSBkaWZmX3ttMSxtMn0gd2l0aCBkaXZfe20xLG0yfSBzaW5j
ZSB0aGV5IGFyZSBkaXZpZGVycyBhbmQgbm90IGENCj4gPiBkaWZmZXJlbnRpYWwgc2V0dGluZ3Mu
DQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogTGFycy1QZXRlciBDbGF1c2VuIDxsYXJzQG1ldGFm
b28uZGU+DQo+ID4gU2lnbmVkLW9mZi1ieTogQWxleGFuZHJ1IEFyZGVsZWFuIDxhbGV4YW5kcnUu
YXJkZWxlYW5AYW5hbG9nLmNvbT4NCj4gDQo+IEFwcGxpZWQgdG8gdGhlIHRvZ3JlZyBicmFuY2gg
b2YgaWlvLmdpdCBhbmQgcHVzaGVkIG91dCBhcyB0ZXN0aW5nDQo+IGZvciBubyBwYXJ0aWN1bGFy
IHJlYXNvbi4NCj4gDQo+IE5vdGUgdGhhdCBpdCB3b3VsZCBiZSBoZWxwZnVsIGlmLCB3aGVuIHlv
dSBwb3N0IGEgbmV3IHZlcnNpb24gb2YgYQ0KPiBwYXRjaCBkZXNwaXRlIChJIHRoaW5rKSBubyBy
ZXBsaWVzIHRvIHRoZSBwcmV2aW91cywgdGhhdCB5b3UgYWxzbw0KPiByZXBseSB0byB0aGF0IHRo
cmVhZCB0byBzYXkgdGhlcmUgaXMgYSB2Mi4gIFNvbWV0aW1lcyBJIHJ1biBmb3J3YXJkcw0KPiB0
aHJvdWdoIG15IGVtYWlscyBhbmQgd291bGQgaGF2ZSBhcHBsaWVkIHRoYXQgYmVmb3JlIHNlZWlu
ZyB0aGlzLg0KPiANCg0KQWNrLg0KV2lsbCB0cnkgdG8gcmVtZW1iZXIgdGhpcy4NCg0KVGhhbmtz
DQpBbGV4DQoNCj4gVGhhbmtzLA0KPiANCj4gSm9uYXRoYW4NCj4gDQo+ID4gLS0tDQo+ID4gDQo+
ID4gQ2hhbmdlbG9nIHYxLT52MjoNCj4gPiAqIGFkZGVkIGBmcmVxdWVuY3k6YCB0byBwcmVmaXgg
Zm9yIGNvbnNpc3RlbmN5DQo+ID4gDQo+ID4gIGRyaXZlcnMvaWlvL2ZyZXF1ZW5jeS9hZDk1MjMu
YyAgICAgICB8IDE2ICsrKysrKysrLS0tLS0tLS0NCj4gPiAgaW5jbHVkZS9saW51eC9paW8vZnJl
cXVlbmN5L2FkOTUyMy5oIHwgIDggKysrKy0tLS0NCj4gPiAgMiBmaWxlcyBjaGFuZ2VkLCAxMiBp
bnNlcnRpb25zKCspLCAxMiBkZWxldGlvbnMoLSkNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9paW8vZnJlcXVlbmN5L2FkOTUyMy5jDQo+ID4gYi9kcml2ZXJzL2lpby9mcmVxdWVuY3kv
YWQ5NTIzLmMNCj4gPiBpbmRleCAzZjliZTY5NDk5ZWMuLjliOWVlZTI3MTc2YyAxMDA2NDQNCj4g
PiAtLS0gYS9kcml2ZXJzL2lpby9mcmVxdWVuY3kvYWQ5NTIzLmMNCj4gPiArKysgYi9kcml2ZXJz
L2lpby9mcmVxdWVuY3kvYWQ5NTIzLmMNCj4gPiBAQCAtODcyLDIyICs4NzIsMjIgQEAgc3RhdGlj
IGludCBhZDk1MjNfc2V0dXAoc3RydWN0IGlpb19kZXYNCj4gPiAqaW5kaW9fZGV2KQ0KPiA+ICAg
ICAgICAgICAgICAgcmV0dXJuIHJldDsNCj4gPiANCj4gPiAgICAgICByZXQgPSBhZDk1MjNfd3Jp
dGUoaW5kaW9fZGV2LCBBRDk1MjNfUExMMl9WQ09fRElWSURFUiwNCj4gPiAtICAgICAgICAgICAg
IEFEOTUyM19QTEwyX1ZDT19ESVZfTTEocGRhdGEtPnBsbDJfdmNvX2RpZmZfbTEpIHwNCj4gPiAt
ICAgICAgICAgICAgIEFEOTUyM19QTEwyX1ZDT19ESVZfTTIocGRhdGEtPnBsbDJfdmNvX2RpZmZf
bTIpIHwNCj4gPiAtICAgICAgICAgICAgIEFEX0lGRShwbGwyX3Zjb19kaWZmX20xLCAwLA0KPiA+
ICsgICAgICAgICAgICAgQUQ5NTIzX1BMTDJfVkNPX0RJVl9NMShwZGF0YS0+cGxsMl92Y29fZGl2
X20xKSB8DQo+ID4gKyAgICAgICAgICAgICBBRDk1MjNfUExMMl9WQ09fRElWX00yKHBkYXRhLT5w
bGwyX3Zjb19kaXZfbTIpIHwNCj4gPiArICAgICAgICAgICAgIEFEX0lGRShwbGwyX3Zjb19kaXZf
bTEsIDAsDQo+ID4gICAgICAgICAgICAgICAgICAgICAgQUQ5NTIzX1BMTDJfVkNPX0RJVl9NMV9Q
V1JfRE9XTl9FTikgfA0KPiA+IC0gICAgICAgICAgICAgQURfSUZFKHBsbDJfdmNvX2RpZmZfbTIs
IDAsDQo+ID4gKyAgICAgICAgICAgICBBRF9JRkUocGxsMl92Y29fZGl2X20yLCAwLA0KPiA+ICAg
ICAgICAgICAgICAgICAgICAgIEFEOTUyM19QTEwyX1ZDT19ESVZfTTJfUFdSX0RPV05fRU4pKTsN
Cj4gPiAgICAgICBpZiAocmV0IDwgMCkNCj4gPiAgICAgICAgICAgICAgIHJldHVybiByZXQ7DQo+
ID4gDQo+ID4gLSAgICAgaWYgKHBkYXRhLT5wbGwyX3Zjb19kaWZmX20xKQ0KPiA+ICsgICAgIGlm
IChwZGF0YS0+cGxsMl92Y29fZGl2X20xKQ0KPiA+ICAgICAgICAgICAgICAgc3QtPnZjb19vdXRf
ZnJlcVtBRDk1MjNfVkNPMV0gPQ0KPiA+IC0gICAgICAgICAgICAgICAgICAgICBzdC0+dmNvX2Zy
ZXEgLyBwZGF0YS0+cGxsMl92Y29fZGlmZl9tMTsNCj4gPiArICAgICAgICAgICAgICAgICAgICAg
c3QtPnZjb19mcmVxIC8gcGRhdGEtPnBsbDJfdmNvX2Rpdl9tMTsNCj4gPiANCj4gPiAtICAgICBp
ZiAocGRhdGEtPnBsbDJfdmNvX2RpZmZfbTIpDQo+ID4gKyAgICAgaWYgKHBkYXRhLT5wbGwyX3Zj
b19kaXZfbTIpDQo+ID4gICAgICAgICAgICAgICBzdC0+dmNvX291dF9mcmVxW0FEOTUyM19WQ08y
XSA9DQo+ID4gLSAgICAgICAgICAgICAgICAgICAgIHN0LT52Y29fZnJlcSAvIHBkYXRhLT5wbGwy
X3Zjb19kaWZmX20yOw0KPiA+ICsgICAgICAgICAgICAgICAgICAgICBzdC0+dmNvX2ZyZXEgLyBw
ZGF0YS0+cGxsMl92Y29fZGl2X20yOw0KPiA+IA0KPiA+ICAgICAgIHN0LT52Y29fb3V0X2ZyZXFb
QUQ5NTIzX1ZDWE9dID0gcGRhdGEtPnZjeG9fZnJlcTsNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEv
aW5jbHVkZS9saW51eC9paW8vZnJlcXVlbmN5L2FkOTUyMy5oDQo+ID4gYi9pbmNsdWRlL2xpbnV4
L2lpby9mcmVxdWVuY3kvYWQ5NTIzLmgNCj4gPiBpbmRleCAxMmNlM2VlNDI3ZmQuLjYyMWI5M2Mw
YmNmOSAxMDA2NDQNCj4gPiAtLS0gYS9pbmNsdWRlL2xpbnV4L2lpby9mcmVxdWVuY3kvYWQ5NTIz
LmgNCj4gPiArKysgYi9pbmNsdWRlL2xpbnV4L2lpby9mcmVxdWVuY3kvYWQ5NTIzLmgNCj4gPiBA
QCAtMTI5LDggKzEyOSw4IEBAIGVudW0gY3BvbGUxX2NhcGFjaXRvciB7DQo+ID4gICAqIEBwbGwy
X25kaXZfYl9jbnQ6IFBMTDIgRmVlZGJhY2sgTi1kaXZpZGVyLCBCIENvdW50ZXIsIHJhbmdlIDAu
LjYzLg0KPiA+ICAgKiBAcGxsMl9mcmVxX2RvdWJsZXJfZW46IFBMTDIgZnJlcXVlbmN5IGRvdWJs
ZXIgZW5hYmxlLg0KPiA+ICAgKiBAcGxsMl9yMl9kaXY6IFBMTDIgUjIgZGl2aWRlciwgcmFuZ2Ug
MC4uMzEuDQo+ID4gLSAqIEBwbGwyX3Zjb19kaWZmX20xOiBWQ08xIGRpdmlkZXIsIHJhbmdlIDMu
LjUuDQo+ID4gLSAqIEBwbGwyX3Zjb19kaWZmX20yOiBWQ08yIGRpdmlkZXIsIHJhbmdlIDMuLjUu
DQo+ID4gKyAqIEBwbGwyX3Zjb19kaXZfbTE6IFZDTzEgZGl2aWRlciwgcmFuZ2UgMy4uNS4NCj4g
PiArICogQHBsbDJfdmNvX2Rpdl9tMjogVkNPMiBkaXZpZGVyLCByYW5nZSAzLi41Lg0KPiA+ICAg
KiBAcnBvbGUyOiBQTEwyIGxvb3AgZmlsdGVyIFJwb2xlIHJlc2lzdG9yIHZhbHVlLg0KPiA+ICAg
KiBAcnplcm86IFBMTDIgbG9vcCBmaWx0ZXIgUnplcm8gcmVzaXN0b3IgdmFsdWUuDQo+ID4gICAq
IEBjcG9sZTE6IFBMTDIgbG9vcCBmaWx0ZXIgQ3BvbGUgY2FwYWNpdG9yIHZhbHVlLg0KPiA+IEBA
IC0xNzYsOCArMTc2LDggQEAgc3RydWN0IGFkOTUyM19wbGF0Zm9ybV9kYXRhIHsNCj4gPiAgICAg
ICB1bnNpZ25lZCBjaGFyICAgICAgICAgICAgICAgICAgIHBsbDJfbmRpdl9iX2NudDsNCj4gPiAg
ICAgICBib29sICAgICAgICAgICAgICAgICAgICAgICAgICAgIHBsbDJfZnJlcV9kb3VibGVyX2Vu
Ow0KPiA+ICAgICAgIHVuc2lnbmVkIGNoYXIgICAgICAgICAgICAgICAgICAgcGxsMl9yMl9kaXY7
DQo+ID4gLSAgICAgdW5zaWduZWQgY2hhciAgICAgICAgICAgICAgICAgICBwbGwyX3Zjb19kaWZm
X20xOyAvKiAzLi41ICovDQo+ID4gLSAgICAgdW5zaWduZWQgY2hhciAgICAgICAgICAgICAgICAg
ICBwbGwyX3Zjb19kaWZmX20yOyAvKiAzLi41ICovDQo+ID4gKyAgICAgdW5zaWduZWQgY2hhciAg
ICAgICAgICAgICAgICAgICBwbGwyX3Zjb19kaXZfbTE7IC8qIDMuLjUgKi8NCj4gPiArICAgICB1
bnNpZ25lZCBjaGFyICAgICAgICAgICAgICAgICAgIHBsbDJfdmNvX2Rpdl9tMjsgLyogMy4uNSAq
Lw0KPiA+IA0KPiA+ICAgICAgIC8qIExvb3AgRmlsdGVyIFBMTDIgKi8NCj4gPiAgICAgICBlbnVt
IHJwb2xlMl9yZXNpc3RvciAgICAgICAgICAgIHJwb2xlMjsNCj4gDQo+IA0K
