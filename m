Return-Path: <SRS0=RKAC=RS=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99B60C43381
	for <linux-iio@archiver.kernel.org>; Fri, 15 Mar 2019 07:19:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42BA6218A5
	for <linux-iio@archiver.kernel.org>; Fri, 15 Mar 2019 07:19:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="M/Gq7n+A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727262AbfCOHTc (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Fri, 15 Mar 2019 03:19:32 -0400
Received: from mail-eopbgr730045.outbound.protection.outlook.com ([40.107.73.45]:59392
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725778AbfCOHTc (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 15 Mar 2019 03:19:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1uN3gqTJdidETeeyvlzlJDqdfILRc2OmiE9toYd3UNI=;
 b=M/Gq7n+AQNHwFaBp/xyY5ZlrbXz6AohyASjSdjXnhoJEZEZLxfRinUQ8AobL2oyAKTPvoep1xhF+FOyyRajpGLkuJlgOmydCAun6MGqsAdDiQK3516i1RJjmlIwA6fcC2oMIIGiLER07rWxIWEtzTpboaRTfIOcAhpkqdzzUJnw=
Received: from CY4PR03CA0011.namprd03.prod.outlook.com (2603:10b6:903:33::21)
 by BL2PR03MB545.namprd03.prod.outlook.com (2a01:111:e400:c23::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1686.22; Fri, 15 Mar
 2019 07:19:26 +0000
Received: from SN1NAM02FT003.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::204) by CY4PR03CA0011.outlook.office365.com
 (2603:10b6:903:33::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1709.13 via Frontend
 Transport; Fri, 15 Mar 2019 07:19:25 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.55)
 smtp.mailfrom=analog.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 SN1NAM02FT003.mail.protection.outlook.com (10.152.73.29) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1709.13
 via Frontend Transport; Fri, 15 Mar 2019 07:19:23 +0000
Received: from NWD2HUBCAS9.ad.analog.com (nwd2hubcas9.ad.analog.com [10.64.69.109])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id x2F7JMdU010745
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Fri, 15 Mar 2019 00:19:22 -0700
Received: from NWD2MBX7.ad.analog.com ([fe80::190e:f9c1:9a22:9663]) by
 NWD2HUBCAS9.ad.analog.com ([fe80::44a2:871b:49ab:ea47%12]) with mapi id
 14.03.0415.000; Fri, 15 Mar 2019 03:19:22 -0400
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "gascoar@gmail.com" <gascoar@gmail.com>
CC:     "ardeleanalex@gmail.com" <ardeleanalex@gmail.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: Testing ad9833 with Diolan DLN2 adapter
Thread-Topic: Testing ad9833 with Diolan DLN2 adapter
Thread-Index: AQHU2mtdIJ/HRiqJRUecu9kIz9RmsaYLZmaAgAButACAALfsgA==
Date:   Fri, 15 Mar 2019 07:19:22 +0000
Message-ID: <ec6489650b98e7eafa39c72bdbbff36981dbc940.camel@analog.com>
References: <20190313193523.k6vipjv33uoiqx25@localhost.localdomain>
         <CA+U=Dsry=kmJdr+BwfULTRaU=YF9KMeYd6jxwj8+5Q8bZRt4=g@mail.gmail.com>
         <0e0834534fb79e0d20033b5ca29cfe5c611fd960.camel@analog.com>
         <20190314202102.qcn43e67xgcmzuhv@localhost.localdomain>
In-Reply-To: <20190314202102.qcn43e67xgcmzuhv@localhost.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.50.1.244]
x-adiroutedonprem: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <C8026E70945ED1428DD328D24E136CBC@analog.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(396003)(376002)(136003)(39860400002)(2980300002)(189003)(199004)(476003)(6116002)(2616005)(11346002)(6306002)(486006)(126002)(336012)(7696005)(426003)(8936002)(436003)(2486003)(23676004)(3846002)(5640700003)(446003)(2906002)(2501003)(246002)(7736002)(305945005)(14454004)(1730700003)(478600001)(966005)(86362001)(8676002)(6246003)(53546011)(76176011)(7636002)(26005)(186003)(106466001)(47776003)(2351001)(102836004)(1411001)(36756003)(93886005)(6916009)(356004)(118296001)(106002)(1361003)(316002)(5660300002)(4326008)(229853002)(50466002)(54906003);DIR:OUT;SFP:1101;SCL:1;SRVR:BL2PR03MB545;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f9dbe29e-94d5-42fc-9b95-08d6a9168dcf
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4608103)(4709054)(2017052603328)(7153060)(7193020);SRVR:BL2PR03MB545;
X-MS-TrafficTypeDiagnostic: BL2PR03MB545:
X-MS-Exchange-PUrlCount: 3
X-Microsoft-Exchange-Diagnostics: 1;BL2PR03MB545;20:HVmr6tYwrNbSJCaT/Ypq11sDmyQRtziT8crg75aenOyEIkTSuFQ8ZQELHtokeGn3u61pvzE9hDNyI10YVydqMLft6DTE+mMyZiIXKrfbwu9S/tvHRYh1AP13OL8rQCQUXvYqY0MP7o+goQJ0zQptAc/eL/iRUOjROgM9P+JyF2QY16W2ofASX0rwsju2PpQByQcPLjBbSvLZ/EYZw+pUmqrwvmxaXcCbmNDK4WHpEzFZNqNwvMGDtku3onVM1rLNpjmI2XXbspWr+h9/ECxH14XN2gQNar+nEOVtnptzd5BHz2icY55hunwv93OgJmw1lvpCUj888C7vvsByZP02BqgdgNwwSRwTvyd78jElD+2hWM6Y1k6soOMQK0fSXcZpGizpJykbib3UwtCw3xTmbOWHOCNaXxTQ6BFy/IHoihAQH1yzfRIduXNScsoKuhf5mUJ9zQGmP87w18DA4XbstiOdexRGI6F/hXpfxau9MBcMEmO8Fsf5pTcvnELBeI5v
X-Microsoft-Antispam-PRVS: <BL2PR03MB545989C3647151767373850F9440@BL2PR03MB545.namprd03.prod.outlook.com>
X-Forefront-PRVS: 09778E995A
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTDJQUjAzTUI1NDU7MjM6cEgvWHFGQ2llVitnZkM1L1E5MUJ1cVlwcGI1?=
 =?utf-8?B?Sjl2VnhGWjhWTCtGYUFFNy9WNGJZKzJFTGhNQ3JHbmEyL2tWZ1dpMFBoVlhp?=
 =?utf-8?B?T0szaC9LZ1pueUJmTnRUVVZZYmc0bEN5S0J4YWRHZjNZMDhZUnErcTdkbmhr?=
 =?utf-8?B?WnVMbmdnSDUrZEhSL3lYcGpwNkhyMHMyU0xsYW1ybjFBYmdtaWJkM2JnRUEw?=
 =?utf-8?B?QTdRQzY4V2pPNko0TWVoRmk2TUFuNzNMNkVTeVl3Zjk1K0w4c0hYRXF6c01u?=
 =?utf-8?B?dkZyNTRTbUNzM0tmdFJDNmk3U0ZEdHZPK1dnbERTdmR3ZnVOVHJEN2hSYXpv?=
 =?utf-8?B?UjFZcUh4UWJPTldPeHM3NVIrMEZ4N2ZPeWMyVTR0TE92TTBKdTkyU0F5TWtR?=
 =?utf-8?B?L2V5K29rRHpoOWM2bndQQUlmQjhrcEJ5dVEvdXVLbXJmREVwanRWM2JISHdB?=
 =?utf-8?B?ZUNsYitOSkdVT3R2djNDamR3bzRzVFVLSTMxdUhWL3JFaUNsTEcyTkJDWDFu?=
 =?utf-8?B?TzlVOGljdmFxN2wwUVhBc2c0eDEzNVVwUVZ5WEZFanJRV0hSd2o2SmhBRDV6?=
 =?utf-8?B?T0F6eGJ0blBTUHA3elZNRHNZaGlZRFBEVE9TYkxnaVNYa0pKVEovRkUxK3dn?=
 =?utf-8?B?aEE2UkZoelIrN1NnelNQWFQvcXVRLzFYK2swS0ZCYjFMd002YUFFQjBXTkt4?=
 =?utf-8?B?SmVySkVJSWJkcW1jUDltdUpudWtWSVp6UmR6ZE9UZmp0clBkODVoWm1HMWVv?=
 =?utf-8?B?LzBzbnY2bUt2TTY3ZnpnbkdQbkZxaitkYWdmVTJBYmMrSW9yK3pIT3JRYlFX?=
 =?utf-8?B?a2o4bGlKK3B3V3RzVmdiNEV1dzdvMVFZcmljM3Bmdmp2clN5ZG9ybHNMczdN?=
 =?utf-8?B?MGpOeVJSSlp1KzlRZGRmMXJzaFpYd0hzV0FDSFNUYld6dFp1VUtWbllIek5o?=
 =?utf-8?B?WVJaMGFRcGVsb05zM1gzN1U4dmI0ay8ySXBUczBIbFRlMWZFTS8zRUJuR2RU?=
 =?utf-8?B?ZXRRdmsxWGJyZFZOaDNiYkkzb2Zmc1RpRmt4Wi9HOVlRYWw0WDdwdVpGQjJZ?=
 =?utf-8?B?MXdpZmoxaVVVL1U2NXEwRUIwbkNCVTV3eTEwM29ZMmJiaTNkaEhXVS9SR0Yx?=
 =?utf-8?B?bFNLYjVWVDZqY3pCOW5aTENBUFl3YkFlZG91ZFQ3SEh5UkJsQkJZMkVHb0hV?=
 =?utf-8?B?ZjJXYjU2MlR4V0tIbE5LSWdWSlg1Y0VjemNVSm1qT3RkMldud0M0a0x4WG9l?=
 =?utf-8?B?NGJZcjlnQlNlcDhFTXJZUE5kdUNrVi9KMjMvN3ZSKzB3TEZMNmpHanBSZmlZ?=
 =?utf-8?B?ZGVoYXNhcVFUb1EralljQ1k3ODRrRi9Fejh3bTBXVjJXRnRDYkR1OXlxa1BY?=
 =?utf-8?B?cHFVNituc0VYaUcxcEJhUzAyb216emRxdGtaZnJJbjRqa3FubURDTnA0VkFu?=
 =?utf-8?B?QjVDNStoRmpjUDRzZHhoemRGM013OXU5c3JXdHFIVnF1MW9aOGpqcDdSVUFm?=
 =?utf-8?B?NVZGSUl2Sm1oQVVkTTBEMWJ5NkY4RnRCSHFqcEFseFVFVG9XdG9MMmYrTytI?=
 =?utf-8?B?MjRqY3NlcUFCWEJvOFhhajB4VU1DMldjUTc1WFRXNkFnSzNJT2VVR09YeEFj?=
 =?utf-8?B?Unp4YzhUMzkzdUZYMklIbllhbE85a0VIRXRnNzB5NUhDeHVQSHREU0J6LzVs?=
 =?utf-8?B?V28rSTNuU2hHeDB3STBsb1FUSGdiREFOOXg3aXFKL1V0UitHbFhCbTc3dzlx?=
 =?utf-8?B?QUxOYTBBRTQ0dDhTNUh3PT0=?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: zGRyNHiBVmVXhswYeeeYyDCuqb9tQd1OFxbf4tFKLCkl+2dwU8sCVX6+5u36GdQ617uOavUlFF3lsXvqCMaSpRJSXNpkFrK3yUn1H0lQbEyFt0sUetIMDDzlmttJg4G+Q5AV+4PCsJyqIxRj85XEw5s26bb7jXlTRe3asOCkqjT9c3o+Ra5E3PngzPSrMgxYcPNiEnpE8+p2giyk5aBbYe0WnPipRGs22wFc0w8PHKZnWezfBFgnY0b/RJyekCpT+P5KT0uTlvO5LwYE/P/iRjzpLFmsbhTOJMEulVZQQVlRbXeEnh51ju6ZRVblAe1fzQfy/eaDFrFlh+BlYsUGyyBlZpVPc1kEET3quJHFtP00ipmrhZ3O3Wf463lh4eeWPiHU1aVLl2Ez9pMiLO2v7PhSmlJXBHc96WTQFaA/+QY=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2019 07:19:23.5917
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f9dbe29e-94d5-42fc-9b95-08d6a9168dcf
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL2PR03MB545
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gVGh1LCAyMDE5LTAzLTE0IGF0IDE3OjIxIC0wMzAwLCBHYXN0b24gR29uemFsZXogd3JvdGU6
DQo+IFtFeHRlcm5hbF0NCj4gDQo+IA0KPiBPbiBUaHUsIE1hciAxNCwgMjAxOSBhdCAwMTo0NDo1
MFBNICswMDAwLCBBcmRlbGVhbiwgQWxleGFuZHJ1IHdyb3RlOg0KPiA+IE9uIFRodSwgMjAxOS0w
My0xNCBhdCAxNTozOSArMDIwMCwgQWxleGFuZHJ1IEFyZGVsZWFuIHdyb3RlOg0KPiA+ID4gW0V4
dGVybmFsXQ0KPiA+ID4gDQo+ID4gPiANCj4gPiA+IE9uIFdlZCwgTWFyIDEzLCAyMDE5IGF0IDk6
MzYgUE0gR2FzdG9uIEdvbnphbGV6IDxnYXNjb2FyQGdtYWlsLmNvbT4NCj4gPiA+IHdyb3RlOg0K
PiA+ID4gPiANCj4gPiA+ID4gSGksDQo+ID4gPiA+IA0KPiA+ID4gPiBJIGFtIHRyeWluZyB0byB0
ZXN0IGFuIGFkOTgzMyBtb2R1bGUgbGlrZSB0aGUgb25lIGluIFsxXSB1c2luZw0KPiA+ID4gPiBE
aW9sYW4NCj4gPiA+ID4gRExOMg0KPiA+ID4gPiBhZGFwdGVyIGFuZCB0aGUgZHJpdmVyIGFkOTgz
NC5jDQo+ID4gPiA+IA0KPiA+ID4gPiBTbyBmYXIgSSBnZXQgdGhlIERMTjIgYWRhcHRlciBjb3Jy
ZWN0bHkgcmVnaXN0ZXJlZCBhcyBtYXN0ZXIgZGV2aWNlDQo+ID4gPiA+IChiZWxvdyB0aGUgc3Bp
IGRlYnVnIG91dHB1dCkgYnV0IHRoZSBhZDk4MzMgZHJpdmVyIGRvZXNuJ3QgZXZlbg0KPiA+ID4g
PiBwcm9iZS4NCj4gPiA+ID4gDQo+ID4gPiA+IEJlbG93IHRoZSBzcGkgbG9nIG91dHB1dCBhbmQg
cGluIGNvbm5lY3Rpb25zLiBJJ20gdXNpbmcgdGhlIHRlc3RpbmcNCj4gPiA+ID4gYnJhbmNoIG9m
IHRoZSBpaW8gcmVwby4gVGhlIGFkOTgzNCBhbmQgZGxuMiBkcml2ZXJzIHdlcmUgY29tcGlsZWQN
Cj4gPiA+ID4gYXMNCj4gPiA+ID4gbW9kdWxlcy4NCj4gPiA+ID4gDQo+ID4gPiA+IFRoZSBxdWVz
dGlvbiBpczogc2hvdWxkIHRoaXMgc2V0dXAgcHJvYmUgb3IgZXh0cmEgc3RlcHMgYXJlIG5lZWRl
ZD8NCj4gPiA+IA0KPiA+ID4gSGV5LA0KPiA+ID4gDQo+ID4gPiBJJ20gYXNzdW1pbmcgeW91IGVu
YWJsZWQgdGhlIGRyaXZlciBpbiB0aGUga2VybmVsID8NCj4gPiA+IEhvdyBkb2VzIHlvdXIgZGV2
aWNlLXRyZWUgbG9vayA/DQo+ID4gPiANCj4gPiA+IFRoZXJlIGlzIHNvbWUgZG9jdW1lbnRhdGlv
biBhYm91dCB0aGlzIGNoaXAvZHJpdmVyOg0KPiA+ID4gDQo+ID4gDQo+ID4gDQpodHRwczovL3dp
a2kuYW5hbG9nLmNvbS9yZXNvdXJjZXMvdG9vbHMtc29mdHdhcmUvbGludXgtZHJpdmVycy9paW8t
ZGRzL2FkOTgzNA0KPiA+ID4gDQo+ID4gPiBUaGUgb2xkIGRvYyBzdGlsbCBhc3N1bWVzIHRoYXQg
dGhlIGRyaXZlciBpcyB1c2luZyB0aGUgb2xkDQo+ID4gPiBwbGF0Zm9ybS1kYXRhIG1lY2hhbmlz
bS4NCj4gPiA+IEl0IG5lZWRzIGEgYml0IG9mIHVwZGF0aW5nLCBidXQgc29tZSBpbmZvIHNob3Vs
ZCBzdGlsbCBiZSB1c2VmdWwuDQo+ID4gDQo+ID4gVGhlcmUncyB0aGlzIGRldmljZS10cmVlIG92
ZXJsYXkgZXhhbXBsZS9yZWZlcmVuY2UgZm9yIHRoZSBSYXNwYmVycnkNCj4gPiBQSToNCj4gPiAN
Cj4gPiANCmh0dHBzOi8vZ2l0aHViLmNvbS9hbmFsb2dkZXZpY2VzaW5jL2xpbnV4L2NvbW1pdC83
ZTBiNjYzMzZlZDA1ZGFiOTdjNTY2M2Y3YmM0MzgyMmM3OTE5OWRkDQo+ID4gDQo+ID4gQSBsb3Qg
b2Ygb3VyIGNoaXBzL2V2YWwtYm9hcmRzIGFyZSBpbnRlcmZhY2Ugd2l0aCB0aGUgUEkuDQo+ID4g
DQo+IA0KPiBIaSBBbGV4YW5kcnUsDQo+IA0KPiBUaGFuayB5b3UgZm9yIHlvdXIgcmVwbHkuDQo+
IA0KPiBZZXMsIEkgaW5zZXJ0ZWQgdGhlIGRyaXZlciwgYnV0IEkgZGlkbid0IHVzZSBhbnkgZGV2
aWNlLXRyZWUgZm9yIHRoaXMNCj4gZGV2aWNlLg0KPiANCj4gVG8gYmUgY29tcGxldGVseSBob25l
c3QgSSByZWFkIHRoZSBBRDk4MzQgQW5hbG9nIHdpa2kgcGFnZSwgSSB0aG91Z2h0DQo+IGFib3V0
DQo+IGFkZGluZyB0aGUgYWQ5ODM0X3BsYXRmb3JtX2RhdGEgYW5kIHNwaV9ib2FyZF9pbmZvIGJ1
dCB0aGVuIEkgc2F3IHRoYXQNCj4gdGhlDQo+IGFkOTgzNF9wbGF0Zm9ybV9kYXRhIHN0cnVjdHVy
ZSB3YXMgcmVtb3ZlZCBpbiBjb21taXQgODAxMDljMzIsIHNvIEkNCj4gdGhvdWdodA0KPiAnSSdt
IG1pc3Npbmcgc29tZXRoaW5nLi4uJyB0aGF0J3Mgd2h5IEkgYXNrZWQuDQo+IA0KPiBJIHdpbGwg
dHJ5IHVzaW5nIHRoZSBmaWxlcyBpbiB0aGUgQW5hbG9nIHRyZWUgeW91IHBvaW50ZWQgdG8uDQoN
CkkgdXBkYXRlZCB0aGUgd2lraSBwYWdlLg0KSWYgeW91IHNlZSBpc3N1ZXMgd2l0aCBpdCwgZmVl
bCBmcmVlIHRvIHBvaW50IHRoZW0gb3V0Lg0KDQpXZSBrZWVwIHdhbnRpbmcgdG8gZG8gYSByZWZy
ZXNoIG9mIHRoZSBlbnRpcmUgd2lraSwgYnV0IHRoYXQncyBhIGJpZyBlZmZvcnQNCnJpZ2h0IG5v
dyAoZ2l2ZW4gbmV3IHRoaW5ncyB3ZSBoYXZlIHRvIGRvKS4gQnV0LCBpZiB3ZSBkbyBpdCBvbi1k
ZW1hbmQNCihsaWtlIHRoaXMpIGl0IGFsc28gaGVscHMgdXMgZ2V0IGEgZmVlbCBmb3Igd2hhdCdz
IGJlaW5nIHVzZWQuDQoNClRoYW5rcw0KQWxleA0KDQo+IA0KPiBUaGFua3MgYSBsb3QhDQo+IA0K
PiBHYXN0b24NCj4gDQo+ID4gPiANCj4gPiA+IFRoYW5rcw0KPiA+ID4gQWxleA0KPiA+ID4gDQo+
ID4gPiA+IA0KPiA+ID4gPiBBbnkgaGVscCBhcHByZWNpYXRlZC4NCj4gPiA+ID4gDQo+ID4gPiA+
IFRoYW5rcywNCj4gPiA+ID4gDQo+ID4gPiA+IEdhc3Rvbg0KPiA+ID4gPiANCj4gPiA+ID4gSGFy
ZHdhcmUgZGV2aWNlDQo+ID4gPiA+IC0tLS0tLS0tLS0tLS0tLQ0KPiA+ID4gPiANCj4gPiA+ID4g
WzFdDQo+ID4gPiA+IA0KaHR0cHM6Ly93d3cuYW1hem9uLmNvbS9BbGxvZXQtQUQ5ODMzLUdlbmVy
YXRvci1Qcm9ncmFtbWFibGUtVHJpYW5nbGUvZHAvQjA3R1MxQ0RYWi9yZWY9c3JfMV8xP2tleXdv
cmRzPWFkOTgzMyZxaWQ9MTU1MDc1Mjc5OSZzPWdhdGV3YXkmc3I9OC0xDQo+ID4gPiA+IA0KPiA+
ID4gPiBLZXJuZWwgdHJlZTogSUlPLCB0ZXN0aW5nIGJyYW5jaC4NCj4gPiA+ID4gDQo+ID4gPiA+
IERMTjIgLSBBRDk4MyBjb25uZWN0aW9ucw0KPiA+ID4gPiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0NCj4gPiA+ID4gDQo+ID4gPiA+ICAtIFNTIC0+IEZTWQ0KPiA+ID4gPiAgLSBTQ0sgLT4gQ0xL
DQo+ID4gPiA+ICAtIE1PU0kgLT4gREFUDQo+ID4gPiA+ICAtIEdORCAtPiBHTkQNCj4gPiA+ID4g
IC0gVkNDX09VVCAtPiBWQ0MNCj4gPiA+ID4gDQo+ID4gPiA+IFNQSSBkZWJ1ZyBvdXRwdXQNCj4g
PiA+ID4gLS0tLS0tLS0tLS0tLS0tLQ0KPiA+ID4gPiANCj4gPiA+ID4gWzY1NDY1LjU3MjE0OV0g
dXNiIDEtMS4yOiBOZXcgVVNCIGRldmljZSBmb3VuZCwgaWRWZW5kb3I9YTI1NywNCj4gPiA+ID4g
aWRQcm9kdWN0PTIwMTMsIGJjZERldmljZT0gMS4wMA0KPiA+ID4gPiBbNjU0NjUuNTcyMTU1XSB1
c2IgMS0xLjI6IE5ldyBVU0IgZGV2aWNlIHN0cmluZ3M6IE1mcj0xLCBQcm9kdWN0PTIsDQo+ID4g
PiA+IFNlcmlhbE51bWJlcj0wDQo+ID4gPiA+IFs2NTQ2NS41NzIxNThdIHVzYiAxLTEuMjogUHJv
ZHVjdDogRGlvbGFuIERMTjINCj4gPiA+ID4gWzY1NDY1LjU3MjE2MF0gdXNiIDEtMS4yOiBNYW51
ZmFjdHVyZXI6IERpb2xhbg0KPiA+ID4gPiBbNjU0NjYuNTUzOTcwXSBkbG4yIDEtMS4yOjEuMDog
RGlvbGFuIERMTjIgc2VyaWFsIDMzNjI5MTY2DQo+ID4gPiA+IFs2NTQ2Ni41NTQ5MjVdIHVzYmNv
cmU6IHJlZ2lzdGVyZWQgbmV3IGludGVyZmFjZSBkcml2ZXIgZGxuMg0KPiA+ID4gPiBbNjU0NjYu
NzMzNzE2XSBkbG4yLXNwaSBkbG4yLXNwaS4zLmF1dG86IGNzX251bSA9IDUNCj4gPiA+ID4gWzY1
NDY2LjczNDE5OF0gZGxuMi1zcGkgZGxuMi1zcGkuMy5hdXRvOiBmcmVxX21pbiA9IDIwMDAsIGZy
ZXFfbWF4DQo+ID4gPiA+ID0NCj4gPiA+ID4gMTgwMDAwMDANCj4gPiA+ID4gWzY1NDY2LjczNDQ1
M10gZGxuMi1zcGkgZGxuMi1zcGkuMy5hdXRvOiBicHdfbWFzayA9IDB4RkY4MA0KPiA+ID4gPiBb
NjU0NjYuNzM1MDQ0XSBkbG4yLXNwaSBkbG4yLXNwaS4zLmF1dG86IHJlZ2lzdGVyZWQgbWFzdGVy
IHNwaTANCg==
