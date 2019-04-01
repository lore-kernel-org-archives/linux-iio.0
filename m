Return-Path: <SRS0=cU5P=SD=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AF3CC43381
	for <linux-iio@archiver.kernel.org>; Mon,  1 Apr 2019 12:39:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB41820870
	for <linux-iio@archiver.kernel.org>; Mon,  1 Apr 2019 12:39:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="JqjRRV9o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725897AbfDAMjv (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Mon, 1 Apr 2019 08:39:51 -0400
Received: from mail-eopbgr730081.outbound.protection.outlook.com ([40.107.73.81]:64240
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725882AbfDAMju (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 1 Apr 2019 08:39:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E7aUHFmYoYumuJbfDSaXNDGD6GdkAF5lU5/S41Tnxe4=;
 b=JqjRRV9ocMUdpMXAIcX3dbwjEA9YrpDOiuYn6Z4pESdccNp+X4Td4zuh4zkYE3feB12wAPxnzA0ST4NMZJcPCBu56MQM0n47Lj/iELvfvsCeYQp6QGSIY02yyizGmXt02ye6o3gzTtPO0QWTy+aTTUB8KWBaGSXXs3Fnxe4slwc=
Received: from BN6PR03CA0065.namprd03.prod.outlook.com (2603:10b6:404:4c::27)
 by CY1PR03MB2267.namprd03.prod.outlook.com (2a01:111:e400:c614::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1750.15; Mon, 1 Apr
 2019 12:38:08 +0000
Received: from SN1NAM02FT047.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::207) by BN6PR03CA0065.outlook.office365.com
 (2603:10b6:404:4c::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1750.17 via Frontend
 Transport; Mon, 1 Apr 2019 12:38:07 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.57)
 smtp.mailfrom=analog.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 SN1NAM02FT047.mail.protection.outlook.com (10.152.72.201) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1750.16
 via Frontend Transport; Mon, 1 Apr 2019 12:38:07 +0000
Received: from NWD2HUBCAS9.ad.analog.com (nwd2hubcas9.ad.analog.com [10.64.69.109])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id x31Cc6hB032461
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Mon, 1 Apr 2019 05:38:06 -0700
Received: from NWD2MBX5.ad.analog.com ([fe80::49e:7a9f:284e:1a49]) by
 NWD2HUBCAS9.ad.analog.com ([fe80::44a2:871b:49ab:ea47%12]) with mapi id
 14.03.0415.000; Mon, 1 Apr 2019 08:38:06 -0400
From:   "Popa, Stefan Serban" <StefanSerban.Popa@analog.com>
To:     "jic23@kernel.org" <jic23@kernel.org>,
        "Popa, Stefan Serban" <StefanSerban.Popa@analog.com>
CC:     "lars@metafoo.de" <lars@metafoo.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>,
        "Bogdan, Dragos" <Dragos.Bogdan@analog.com>
Subject: Re: IIO channel type for status/error flag indicators
Thread-Topic: IIO channel type for status/error flag indicators
Thread-Index: AQHU3yy6U4ZOFSV/8kGchvXXyG7r0KYbW56AgAZT6oCABDogAIABqowA
Date:   Mon, 1 Apr 2019 12:38:06 +0000
Message-ID: <1554122284.13791.51.camel@analog.com>
References: <1553093626.13791.37.camel@analog.com>
         <20190324180025.77aa8426@archlinux> <1553798299.13791.47.camel@analog.com>
         <20190331121124.06596c1e@archlinux>
In-Reply-To: <20190331121124.06596c1e@archlinux>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.32.224.122]
x-adiroutedonprem: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <786D17FA8A55EE45908D74FCF560BF8F@analog.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(39860400002)(136003)(346002)(376002)(2980300002)(189003)(199004)(5660300002)(106466001)(72206003)(50466002)(47776003)(356004)(126002)(23676004)(6116002)(103116003)(2501003)(26005)(36756003)(7736002)(966005)(76176011)(93886005)(316002)(86362001)(3846002)(14444005)(7636002)(561944003)(336012)(436003)(14454004)(2616005)(426003)(11346002)(2906002)(106002)(486006)(4326008)(478600001)(186003)(6306002)(7696005)(476003)(305945005)(2486003)(102836004)(6246003)(8676002)(110136005)(54906003)(446003)(246002)(229853002)(107886003)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR03MB2267;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9bd8e170-7567-493c-5eaf-08d6b69ee4b5
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600139)(711020)(4605104)(4709054)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:CY1PR03MB2267;
X-MS-TrafficTypeDiagnostic: CY1PR03MB2267:
X-MS-Exchange-PUrlCount: 1
X-Microsoft-Antispam-PRVS: <CY1PR03MB22671CD7DEF4B5F03DE8DAFD9D550@CY1PR03MB2267.namprd03.prod.outlook.com>
X-Forefront-PRVS: 0994F5E0C5
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: UJEhG6EUsFeHeV960sqbI2z3QhJFZtBTdvPDt8jHL2NR1lqs3iWU45w22o+lLmeW724RrPLu5tLUKJqOU9FaxBePQo3Jor3rdeRxoFSumEZAcMaUSDNxF0VYpc3BA2e7ijPqAfUb8ZHBQTGBc62dfA5FRoVVO5laTwmrYZIzILthQMmA03Ye+SkjeLvyUXOpP9vLct7kTmW2LzR8bHhj9ZCS8f1+DhtbmB+zqz2sJNJUrz+UDu2n1xFPfD0+U9ckR/kM3MeqlWISvlOHKv7q8b2TsmMu8IJLV1hWb3DCcRb8OoPghfb2W6BN5w7eKazV2VsgSeA9/YcNX/iwG9l4JBVHyaQD2Q9FL36aj2CdzZCOdReCcHNPE6AlqYzvwKztQkzBLZdE2RMGokqo4gxvqhJPMXVZqb2cB3Hcg+aa/jg=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2019 12:38:07.5021
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bd8e170-7567-493c-5eaf-08d6b69ee4b5
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR03MB2267
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

SGkgSm9uYXRoYW4sDQoNCldlJ2xsIGNvbWUgYmFjayB3aXRoIGFuIGludGVyZmFjZSBwcm9wb3Nh
bC4NClRoYW5rIHlvdSENCg0KLVN0ZWZhbg0KDQpPbiBEdSwgMjAxOS0wMy0zMSBhdCAxMjoxMSAr
MDEwMCwgSm9uYXRoYW4gQ2FtZXJvbiB3cm90ZToNCj4gT24gVGh1LCAyOCBNYXIgMjAxOSAxODoz
ODoyMSArMDAwMA0KPiAiUG9wYSwgU3RlZmFuIFNlcmJhbiIgPFN0ZWZhblNlcmJhbi5Qb3BhQGFu
YWxvZy5jb20+IHdyb3RlOg0KPiANCj4gPiANCj4gPiBIaSBKb25hdGhhbiwNCj4gPiANCj4gPiBU
aGFuayB5b3UgZm9yIHRha2luZyB0aGUgdGltZSB0byBhbnN3ZXIuDQo+ID4gDQo+ID4gVGhlc2Ug
ZGV2aWNlcyBhcmUgbW9zdGx5IHVzZWQgaW4gYXV0b21vdGl2ZS9hZXJvc3BhY2UgaW5kdXN0cmll
cyB3aGVyZQ0KPiA+IHRoZXkNCj4gPiB1c3VhbGx5IHJlcXVpcmUgYSBjb250aW51b3VzIHN0cmVh
bSBvZiBkYXRhIGV2ZW4gaWYgYW4gZXJyb3Igb2NjdXJzLg0KPiA+IFRoaXMNCj4gPiBpcyB3aHkg
d2UgY2Fubm90IGp1c3QgImRyb3AgdGhlIHJlY29yZCIgOikuDQo+ID4gU28sIHNob3VsZCB3ZSBt
YXliZSB0aGluayBvZiBhIHdheSBvZiBjb3ZlcmluZyBmbGFncyBjaGFubmVsIHR5cGVzPw0KPiBQ
cm9wb3NlIGFuIGludGVyZmFjZSBhbmQgd2UgY2FuIGNlcnRhaW5seSB0YWxrIGFib3V0IGl0IDop
wqDCoEtlZXAgaW4gbWluZA0KPiB0aGF0IGl0IG5lZWRzIHRvIGJlIGxpZ2h0d2VpZ2h0IGZvciBh
bnl0aGluZyBub3QgbWFraW5nIHVzZSBvZiBpdCBhbmQNCj4gdGhhdCBJIGNhbiBzZWUgdGhpcyBh
YnNvcmJpbmcgYSBsb3Qgb2YgbmFtZXNwYWNlIC8gaWQgc3BhY2UgKHBhcnRpY3VsYXJseQ0KPiBp
biBwb3RlbnRpYWwgZXZlbnQgY29kZXMpIHNvIGtlZXAgdGhhdCBpbiBtaW5kIGFzIHdlbGwuDQo+
IA0KPiBJJ2QgYXJndWUgdGhhdCB0aG9zZSBhdXRvbW90aXZlIC8gYWVyb3NwYWNlIGRldmljZXMg
c2hvdWxkIGNlcnRhaW5seQ0KPiBjb3BlIHdpdGggbWlzc2luZyBkYXRhLCBidXQgcGVyaGFwcyB0
aGF0J3Mgd2lzaGZ1bCB0aGlua2luZy4NCj4gDQo+IEFueWhvdywgSSdtIG5vdCBhZ2FpbnN0IHRo
aXMgaW4gcHJpbmNpcGxlIGJ1dCB0aGluayBpdCdzIGEgbm9uIHRyaXZpYWwNCj4gZXhlcmNpc2Ug
c28gcHJlcGFyZSB5b3Vyc2VsZiBmb3IgYSBiaWcgam9iIGFuZCBxdWl0ZSBhIGZldyByb3VuZHMg
b2YNCj4gaW50ZXJmYWNlIGRlc2NyaXB0aW9ucyENCj4gDQo+IEpvbmF0aGFuDQo+IA0KPiA+IA0K
PiA+IA0KPiA+IFJlZ2FyZHMsDQo+ID4gLVN0ZWZhbg0KPiA+IA0KPiA+IE9uIER1LCAyMDE5LTAz
LTI0IGF0IDE4OjAwICswMDAwLCBKb25hdGhhbiBDYW1lcm9uIHdyb3RlOg0KPiA+ID4gDQo+ID4g
PiANCj4gPiA+IA0KPiA+ID4gT24gV2VkLCAyMCBNYXIgMjAxOSAxNDo1Mzo1MCArMDAwMA0KPiA+
ID4gIlBvcGEsIFN0ZWZhbiBTZXJiYW4iIDxTdGVmYW5TZXJiYW4uUG9wYUBhbmFsb2cuY29tPiB3
cm90ZToNCj4gPiA+IA0KPiA+ID4gPiANCj4gPiA+ID4gDQo+ID4gPiA+IEhlbGxvLA0KPiA+ID4g
PiANCj4gPiA+ID4gV2UgYXJlIGN1cnJlbnRseSB3b3JraW5nIG9uIGEgbmV3IGFkaXMxNjQ5NSBJ
TVUgZHJpdmVyIHdoaWNoIGlzIGFuDQo+ID4gPiA+IHVwZ3JhZGUNCj4gPiA+ID4gZnJvbSB0aGUg
YWRpczE2NDgwIGZhbWlseTogaHR0cHM6Ly93d3cuYW5hbG9nLmNvbS9tZWRpYS9lbi90ZWNobmlj
YQ0KPiA+ID4gPiBsLWRvDQo+ID4gPiA+IGN1bWUNCj4gPiA+ID4gbnRhdGlvbi9kYXRhLXNoZWV0
cy9BRElTMTY0OTUucGRmLg0KPiA+ID4gPiANCj4gPiA+ID4gVGhpcyBuZXcgY2hpcCBzdXBwb3J0
cyBhIGZlYXR1cmUgY2FsbGVkICJCdXJzdCBSZWFkIEZ1bmN0aW9uIiAocGFnZQ0KPiA+ID4gPiAx
Mw0KPiA+ID4gPiBpbg0KPiA+ID4gPiB0aGUgZGF0YXNoZWV0KS4gVGhlIGJ1cnN0IHJlYWQgZnVu
Y3Rpb24gKEJSRikgcHJvdmlkZXMgYSBtZXRob2QgZm9yDQo+ID4gPiA+IHJlYWRpbmcNCj4gPiA+
ID4gYSBiYXRjaCBvZiBkYXRhIChzdGF0dXMsIHRlbXBlcmF0dXJlLCBneXJvc2NvcGVzLCBhY2Nl
bGVyb21ldGVycywNCj4gPiA+ID4gdGltZQ0KPiA+ID4gPiBzdGFtcC9kYXRhIGNvdW50ZXIsIGFu
ZCBDUkMgY29kZSksIHdoaWNoIGRvZXMgbm90IHJlcXVpcmUgYSBzdGFsbA0KPiA+ID4gPiB0aW1l
IGJldHdlZW4gZWFjaCAxNi1iaXQgc2VnbWVudCBhbmQgb25seSByZXF1aXJlcyBvbmUgY29tbWFu
ZA0KPiA+ID4gPiBvbiB0aGUgRElOIGxpbmUgdG8gaW5pdGlhdGUuDQo+ID4gPiA+IA0KPiA+ID4g
PiBNb3N0IG9mIHRoZSBkYXRhIHJlYWQgaW4gdGhpcyB3YXkgY2FuIGJlIGF0dHJpYnV0ZWQgdG8g
YSB0eXBlIG9mDQo+ID4gPiA+IGNoYW5uZWw6DQo+ID4gPiA+IElJT19URU1QLCBJSU9fQU5HTF9W
RUwsIElJT19BQ0NFTCwgZXRjLiBIb3dldmVyLCB0aGVyZSBpcyBubw0KPiA+ID4gPiBlcXVpdmFs
ZW50DQo+ID4gPiA+IGZvcg0KPiA+ID4gPiB0aGUgc3RhdHVzIGFuZCBDUkMuIFRoZSBzdGF0dXMg
cmVnaXN0ZXIgcHJvdmlkZXMgdmFyaW91cyBlcnJvcg0KPiA+ID4gPiBmbGFncw0KPiA+ID4gPiBz
dWNoDQo+ID4gPiA+IGFzIHNwaSBjb21tdW5pY2F0aW9uIGVycm9yLCBzZW5zb3IgZmFpbHVyZSwg
c3luYyBlcnJvciwgZXRjIChUYWJsZQ0KPiA+ID4gPiAxOA0KPiA+ID4gPiBpbg0KPiA+ID4gPiB0
aGUgZGF0YXNoZWV0KS4gVGhpcyBpbmZvcm1hdGlvbiB0b2dldGhlciB3aXRoIHRoZSBDUkMgZXJy
b3Igc2hvdWxkDQo+ID4gPiA+IGJlDQo+ID4gPiA+IGV4cG9zZWQgdG8gdGhlIHVzZXIgc3BhY2Uu
IFdoYXQgaXMgdGhlIGJlc3Qgd2F5IHRvIGRvIGl0Pw0KPiA+ID4gT2ssIFNvIHRoaXMgaXMgbm90
IGV4YWN0bHkgdW51c3VhbC7CoMKgVGhlIGlzc3VlIGhhcyBhbHdheXMgYmVlbg0KPiA+ID4gZGVm
aW5pbmcNCj4gPiA+IGEgcmVtb3RlbHkgZ2VuZXJpYyB1c2Vyc3BhY2UgQUJJLg0KPiA+ID4gDQo+
ID4gPiA+IA0KPiA+ID4gPiANCj4gPiA+ID4gDQo+ID4gPiA+IFRoZSBtb3N0IG9idmlvdXMgd2F5
LCBidXQgbm90IG5lY2Vzc2FyaWx5IHRoZSBjb3JyZWN0IG9uZSwgd291bGQgYmUNCj4gPiA+ID4g
dG8NCj4gPiA+ID4gYWRkDQo+ID4gPiA+IGEgbmV3IGNoYW5uZWwgdHlwZSBjYWxsZWQgc29tZXRo
aW5nIGxpa2UgSUlPX1NUQVRVUyBvciBJSU9fRkxBRy4gSXMNCj4gPiA+ID4gdGhpcw0KPiA+ID4g
PiBhY2NlcHRhYmxlPw0KPiA+ID4gTm8gdW5mb3J0dW5hdGVseS4gV2hhdCBkb2VzIGdlbmVyaWMg
dXNlcnNwYWNlIGRvIHdpdGggaXQ/DQo+ID4gPiANCj4gPiA+IFBhcnQgb2YgdGhlIHByb2JsZW0g
aXMgd2UgZG9uJ3QgaGF2ZSBhIGNoYW5uZWwgdHlwZSB0byBjb3ZlciBmbGFncyBpbg0KPiA+ID4g
Z2VuZXJhbCAoaWYgd2UgaGFkIGRpZ2l0YWwgaW5wdXRzIHBhY2tlZCBpbnRvIGJ5dGVzIHdlIHdv
dWxkIGF0IGxlYXN0DQo+ID4gPiBiZSBzbGlnaHRseSBiZXR0ZXIgb2ZmKS4NCj4gPiA+IA0KPiA+
ID4gPiANCj4gPiA+ID4gDQo+ID4gPiA+IA0KPiA+ID4gPiBBIG1vcmUgb3IgbGVzcyBzaW1pbGFy
IGJ1cnN0IHJlYWQgZnVuY3Rpb24gaGFzIGJlZW4gcHJldmlvdXNseQ0KPiA+ID4gPiBpbXBsZW1l
bnRlZA0KPiA+ID4gPiBhcyBwYXJ0IG9mIHRoZSBhZGlzMTY0MDAgZHJpdmVyLiBBbHRob3VnaCBh
IGJ1cnN0IHJlYWQgd2lsbCBhbHNvDQo+ID4gPiA+IHByb2R1Y2UNCj4gPiA+ID4gZGlhZ25vc3Rp
YyBzdGF0dXMgZGF0YSwgaXQgd2FzIGlnbm9yZWQgaW4gdGhlIGRyaXZlcg0KPiA+ID4gPiBpbXBs
ZW1lbnRhdGlvbi4NCj4gPiA+IFl1cCA6KcKgwqBDb3VsZG4ndCBmaWd1cmUgb3V0IGhvdyB0byBk
byBpdCBhdCB0aGUgdGltZS4NCj4gPiA+IA0KPiA+ID4gTm9ybWFsbHkgdGhlc2UgZmxhZ3MgcmVw
cmVzZW50IGVycm9yIGNvbmRpdGlvbnMgKGlmIHRoZXkgbWFwIHRvDQo+ID4gPiBldmVudHMNCj4g
PiA+IGluIElJTyB0aGVuIHB1dCB0aGVtIG91dCBsaWtlIHRoYXQpLsKgwqBUaGUgcHJvYmxlbSBo
YXMgYWx3YXlzIGJlZW4NCj4gPiA+IHRoYXQNCj4gPiA+IExpbnV4IGRvZXNuJ3QgYWN0dWFsbHkg
aGF2ZSBnZW5lcmljIHNpbXBsZSBlcnJvciBldmVudCBoYW5kbGluZy4NCj4gPiA+IFRoZXJlIGlz
IFJBUyBoYW5kbGluZyBmb3Igc2VydmVycywgYnV0IHdobyBydW5zIGl0IG9uIGVtYmVkZGVkIGJv
YXJkcw0KPiA+ID4gZXhjZXB0IHBvc3NpYmx5IGZvciBzb21lIGZvcm0gb2YgRURBQy4NCj4gPiA+
IA0KPiA+ID4gPiANCj4gPiA+ID4gDQo+ID4gPiA+IA0KPiA+ID4gPiBMb29raW5nIGZvcndhcmQg
dG8gYW55IHN1Z2dlc3Rpb24uDQo+ID4gPiBJJ20gbm90IGFnYWluc3QgdXMgaGF2aW5nIG1ldGEg
ZGF0YSBjaGFubmVscywgYnV0IHRoZXkgcHJldHR5IG11Y2gNCj4gPiA+IG5lZWQNCj4gPiA+IHRv
IGJlIGFzIHRpZ2h0bHkgZGVmaW5lZCBhcyBhbnkgb3RoZXIgY2hhbm5lbC7CoMKgVGhlIG90aGVy
IHNpZGUgaXNzdWUNCj4gPiA+IGhlcmUgaXMgaXQncyBhIG5ldyAnaHVnZScgc3BhY2UuwqDCoEhv
d2V2ZXIsIEknbSBub3Qgc3VyZSB5b3UgYXJlIGluDQo+ID4gPiB0aGF0IHRlcnJpdG9yeSBoZXJl
LsKgwqBMb29rcyB0byBtZSBsaWtlIHN0YXR1cyByZWFsbHkgbWVhbnMgZXJyb3IuDQo+ID4gPiBJ
ZiB5b3UgZ2V0IGFuIGVycm9yLCBtb3N0bHkgaXQncyBnYW1lIG92ZXIuwqDCoElmIHlvdSBnZXQg
YSBDUkMgZXJyb3INCj4gPiA+IGFuZCB3YW50IHRvIGNoZWNrIGl0LCB0aGVuIGRyb3AgdGhlIHJl
Y29yZCBhbmQgc3BpdCBvdXQgYSBtZXNzYWdlLg0KPiA+ID4gDQo+ID4gPiBTbyBJJ20gYSBsaXR0
bGUgdW5jb252aW5jZWQgYXMgeWV0IHRoYXQgdGhlcmUgaXMgYW55dGhpbmcgd2UgYWN0dWFsbHkN
Cj4gPiA+IGNhbiB1c2UgaW4gdGhpcyBzdGF0dXMgbWVzc2FnZS4NCj4gPiA+IA0KPiA+ID4gSm9u
YXRoYW4NCj4gPiA+IA0KPiA+ID4gDQo+ID4gPiA+IA0KPiA+ID4gPiANCj4gPiA+ID4gDQo+ID4g
PiA+IC1TdGVmYQ==
