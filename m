Return-Path: <SRS0=pjyC=RR=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C5FBC4360F
	for <linux-iio@archiver.kernel.org>; Thu, 14 Mar 2019 13:44:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C65322184C
	for <linux-iio@archiver.kernel.org>; Thu, 14 Mar 2019 13:44:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="KnuBaYi6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727562AbfCNNo6 (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Thu, 14 Mar 2019 09:44:58 -0400
Received: from mail-eopbgr810044.outbound.protection.outlook.com ([40.107.81.44]:28016
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727533AbfCNNo5 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 14 Mar 2019 09:44:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/W0Tenp+8bM/idfCLdwOIe7Q628Q4drw7wiBQbX03Xc=;
 b=KnuBaYi6M4QRxv0Q8KJFNDZ/kNubGUyhusd9DkdgMYDfF6fXD5a+rb1lHUubZgAO7HSjEdsTbI30r3yVDv/Ie2qmwV0BMxB6JUUrIzr7t9YHwKYOI79tAlh0VvdlNObSMc9/517b6YLvDH9tGMQeOryq2mMFOyGuzGQ6ZifYbSA=
Received: from BYAPR03CA0030.namprd03.prod.outlook.com (2603:10b6:a02:a8::43)
 by BLUPR03MB551.namprd03.prod.outlook.com (2a01:111:e400:882::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1709.14; Thu, 14 Mar
 2019 13:44:54 +0000
Received: from SN1NAM02FT057.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::206) by BYAPR03CA0030.outlook.office365.com
 (2603:10b6:a02:a8::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1709.13 via Frontend
 Transport; Thu, 14 Mar 2019 13:44:53 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.55)
 smtp.mailfrom=analog.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 SN1NAM02FT057.mail.protection.outlook.com (10.152.73.105) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1709.13
 via Frontend Transport; Thu, 14 Mar 2019 13:44:51 +0000
Received: from NWD2HUBCAS8.ad.analog.com (nwd2hubcas8.ad.analog.com [10.64.69.108])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id x2EDio16028786
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Thu, 14 Mar 2019 06:44:50 -0700
Received: from NWD2MBX7.ad.analog.com ([fe80::190e:f9c1:9a22:9663]) by
 NWD2HUBCAS8.ad.analog.com ([fe80::90a0:b93e:53c6:afee%12]) with mapi id
 14.03.0415.000; Thu, 14 Mar 2019 09:44:50 -0400
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "ardeleanalex@gmail.com" <ardeleanalex@gmail.com>,
        "gascoar@gmail.com" <gascoar@gmail.com>
CC:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: Testing ad9833 with Diolan DLN2 adapter
Thread-Topic: Testing ad9833 with Diolan DLN2 adapter
Thread-Index: AQHU2mtdIJ/HRiqJRUecu9kIz9RmsaYLZmaA
Date:   Thu, 14 Mar 2019 13:44:50 +0000
Message-ID: <0e0834534fb79e0d20033b5ca29cfe5c611fd960.camel@analog.com>
References: <20190313193523.k6vipjv33uoiqx25@localhost.localdomain>
         <CA+U=Dsry=kmJdr+BwfULTRaU=YF9KMeYd6jxwj8+5Q8bZRt4=g@mail.gmail.com>
In-Reply-To: <CA+U=Dsry=kmJdr+BwfULTRaU=YF9KMeYd6jxwj8+5Q8bZRt4=g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.50.1.244]
x-adiroutedonprem: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <93F083D32A3A854E90A3D9D71430CDC2@analog.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(396003)(376002)(39860400002)(136003)(2980300002)(199004)(189003)(54906003)(106002)(486006)(110136005)(7696005)(2616005)(23676004)(2486003)(47776003)(126002)(446003)(118296001)(476003)(316002)(436003)(426003)(356004)(36756003)(6116002)(8936002)(3846002)(106466001)(11346002)(966005)(7736002)(478600001)(2501003)(2906002)(4326008)(246002)(6306002)(8676002)(50466002)(53546011)(102836004)(76176011)(14454004)(305945005)(6246003)(229853002)(7636002)(186003)(86362001)(26005)(5660300002)(336012);DIR:OUT;SFP:1101;SCL:1;SRVR:BLUPR03MB551;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0f36ecc8-ceda-48e9-dcbe-08d6a8833c77
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4608103)(4709054)(2017052603328)(7153060)(7193020);SRVR:BLUPR03MB551;
X-MS-TrafficTypeDiagnostic: BLUPR03MB551:
X-MS-Exchange-PUrlCount: 3
X-Microsoft-Antispam-PRVS: <BLUPR03MB551D02C2629B402DFE991DAF94B0@BLUPR03MB551.namprd03.prod.outlook.com>
X-Forefront-PRVS: 09760A0505
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: UjxF1mhG4OOfg+YHcLI49epjleqqZSpJce8Mj+WLEMM3+mwYD5KSRNDJXEHqIW/+EgmqhxEmCEogprbN4iV/KXy+pdd0gf/69UjbKE4YTc7XTZL3UVq0ESQ9MVNtjvNF1pHOwdhSOv+6ZxDKF+PvCUcxE1aQ3uqGs0UMCixsYDCzRg4dEgWRgdONh++WeIVFBpdUMNRnKkxoWfs9D52ehlc9rL54awsJRmUwNRuGcjxgchzuV1IhE20C3dsU8CjsDbONZEXK7dn2G1iHKDaunpogM2Bso+esSHTfGkr6i2pqF+/yo/s0mWDUnaKjwB06HFI/CZaL89xytF87tt/ISaFwiLSOPCLtrRWeIGrJnHmoHGUALFd6uYR78z5jv6+YnlOhBV8PVCy9eeoevJe19pJMyBcZ/bHuVu203P75iD0=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2019 13:44:51.2171
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f36ecc8-ceda-48e9-dcbe-08d6a8833c77
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR03MB551
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gVGh1LCAyMDE5LTAzLTE0IGF0IDE1OjM5ICswMjAwLCBBbGV4YW5kcnUgQXJkZWxlYW4gd3Jv
dGU6DQo+IFtFeHRlcm5hbF0NCj4gDQo+IA0KPiBPbiBXZWQsIE1hciAxMywgMjAxOSBhdCA5OjM2
IFBNIEdhc3RvbiBHb256YWxleiA8Z2FzY29hckBnbWFpbC5jb20+DQo+IHdyb3RlOg0KPiA+IA0K
PiA+IEhpLA0KPiA+IA0KPiA+IEkgYW0gdHJ5aW5nIHRvIHRlc3QgYW4gYWQ5ODMzIG1vZHVsZSBs
aWtlIHRoZSBvbmUgaW4gWzFdIHVzaW5nIERpb2xhbg0KPiA+IERMTjINCj4gPiBhZGFwdGVyIGFu
ZCB0aGUgZHJpdmVyIGFkOTgzNC5jDQo+ID4gDQo+ID4gU28gZmFyIEkgZ2V0IHRoZSBETE4yIGFk
YXB0ZXIgY29ycmVjdGx5IHJlZ2lzdGVyZWQgYXMgbWFzdGVyIGRldmljZQ0KPiA+IChiZWxvdyB0
aGUgc3BpIGRlYnVnIG91dHB1dCkgYnV0IHRoZSBhZDk4MzMgZHJpdmVyIGRvZXNuJ3QgZXZlbiBw
cm9iZS4NCj4gPiANCj4gPiBCZWxvdyB0aGUgc3BpIGxvZyBvdXRwdXQgYW5kIHBpbiBjb25uZWN0
aW9ucy4gSSdtIHVzaW5nIHRoZSB0ZXN0aW5nDQo+ID4gYnJhbmNoIG9mIHRoZSBpaW8gcmVwby4g
VGhlIGFkOTgzNCBhbmQgZGxuMiBkcml2ZXJzIHdlcmUgY29tcGlsZWQgYXMNCj4gPiBtb2R1bGVz
Lg0KPiA+IA0KPiA+IFRoZSBxdWVzdGlvbiBpczogc2hvdWxkIHRoaXMgc2V0dXAgcHJvYmUgb3Ig
ZXh0cmEgc3RlcHMgYXJlIG5lZWRlZD8NCj4gDQo+IEhleSwNCj4gDQo+IEknbSBhc3N1bWluZyB5
b3UgZW5hYmxlZCB0aGUgZHJpdmVyIGluIHRoZSBrZXJuZWwgPw0KPiBIb3cgZG9lcyB5b3VyIGRl
dmljZS10cmVlIGxvb2sgPw0KPiANCj4gVGhlcmUgaXMgc29tZSBkb2N1bWVudGF0aW9uIGFib3V0
IHRoaXMgY2hpcC9kcml2ZXI6DQo+IA0KaHR0cHM6Ly93aWtpLmFuYWxvZy5jb20vcmVzb3VyY2Vz
L3Rvb2xzLXNvZnR3YXJlL2xpbnV4LWRyaXZlcnMvaWlvLWRkcy9hZDk4MzQNCj4gDQo+IFRoZSBv
bGQgZG9jIHN0aWxsIGFzc3VtZXMgdGhhdCB0aGUgZHJpdmVyIGlzIHVzaW5nIHRoZSBvbGQNCj4g
cGxhdGZvcm0tZGF0YSBtZWNoYW5pc20uDQo+IEl0IG5lZWRzIGEgYml0IG9mIHVwZGF0aW5nLCBi
dXQgc29tZSBpbmZvIHNob3VsZCBzdGlsbCBiZSB1c2VmdWwuDQoNClRoZXJlJ3MgdGhpcyBkZXZp
Y2UtdHJlZSBvdmVybGF5IGV4YW1wbGUvcmVmZXJlbmNlIGZvciB0aGUgUmFzcGJlcnJ5IFBJOg0K
DQpodHRwczovL2dpdGh1Yi5jb20vYW5hbG9nZGV2aWNlc2luYy9saW51eC9jb21taXQvN2UwYjY2
MzM2ZWQwNWRhYjk3YzU2NjNmN2JjNDM4MjJjNzkxOTlkZA0KDQpBIGxvdCBvZiBvdXIgY2hpcHMv
ZXZhbC1ib2FyZHMgYXJlIGludGVyZmFjZSB3aXRoIHRoZSBQSS4NCg0KPiANCj4gVGhhbmtzDQo+
IEFsZXgNCj4gDQo+ID4gDQo+ID4gQW55IGhlbHAgYXBwcmVjaWF0ZWQuDQo+ID4gDQo+ID4gVGhh
bmtzLA0KPiA+IA0KPiA+IEdhc3Rvbg0KPiA+IA0KPiA+IEhhcmR3YXJlIGRldmljZQ0KPiA+IC0t
LS0tLS0tLS0tLS0tLQ0KPiA+IA0KPiA+IFsxXSANCj4gPiBodHRwczovL3d3dy5hbWF6b24uY29t
L0FsbG9ldC1BRDk4MzMtR2VuZXJhdG9yLVByb2dyYW1tYWJsZS1UcmlhbmdsZS9kcC9CMDdHUzFD
RFhaL3JlZj1zcl8xXzE/a2V5d29yZHM9YWQ5ODMzJnFpZD0xNTUwNzUyNzk5JnM9Z2F0ZXdheSZz
cj04LTENCj4gPiANCj4gPiBLZXJuZWwgdHJlZTogSUlPLCB0ZXN0aW5nIGJyYW5jaC4NCj4gPiAN
Cj4gPiBETE4yIC0gQUQ5ODMgY29ubmVjdGlvbnMNCj4gPiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0NCj4gPiANCj4gPiAgLSBTUyAtPiBGU1kNCj4gPiAgLSBTQ0sgLT4gQ0xLDQo+ID4gIC0gTU9T
SSAtPiBEQVQNCj4gPiAgLSBHTkQgLT4gR05EDQo+ID4gIC0gVkNDX09VVCAtPiBWQ0MNCj4gPiAN
Cj4gPiBTUEkgZGVidWcgb3V0cHV0DQo+ID4gLS0tLS0tLS0tLS0tLS0tLQ0KPiA+IA0KPiA+IFs2
NTQ2NS41NzIxNDldIHVzYiAxLTEuMjogTmV3IFVTQiBkZXZpY2UgZm91bmQsIGlkVmVuZG9yPWEy
NTcsDQo+ID4gaWRQcm9kdWN0PTIwMTMsIGJjZERldmljZT0gMS4wMA0KPiA+IFs2NTQ2NS41NzIx
NTVdIHVzYiAxLTEuMjogTmV3IFVTQiBkZXZpY2Ugc3RyaW5nczogTWZyPTEsIFByb2R1Y3Q9MiwN
Cj4gPiBTZXJpYWxOdW1iZXI9MA0KPiA+IFs2NTQ2NS41NzIxNThdIHVzYiAxLTEuMjogUHJvZHVj
dDogRGlvbGFuIERMTjINCj4gPiBbNjU0NjUuNTcyMTYwXSB1c2IgMS0xLjI6IE1hbnVmYWN0dXJl
cjogRGlvbGFuDQo+ID4gWzY1NDY2LjU1Mzk3MF0gZGxuMiAxLTEuMjoxLjA6IERpb2xhbiBETE4y
IHNlcmlhbCAzMzYyOTE2Ng0KPiA+IFs2NTQ2Ni41NTQ5MjVdIHVzYmNvcmU6IHJlZ2lzdGVyZWQg
bmV3IGludGVyZmFjZSBkcml2ZXIgZGxuMg0KPiA+IFs2NTQ2Ni43MzM3MTZdIGRsbjItc3BpIGRs
bjItc3BpLjMuYXV0bzogY3NfbnVtID0gNQ0KPiA+IFs2NTQ2Ni43MzQxOThdIGRsbjItc3BpIGRs
bjItc3BpLjMuYXV0bzogZnJlcV9taW4gPSAyMDAwLCBmcmVxX21heCA9DQo+ID4gMTgwMDAwMDAN
Cj4gPiBbNjU0NjYuNzM0NDUzXSBkbG4yLXNwaSBkbG4yLXNwaS4zLmF1dG86IGJwd19tYXNrID0g
MHhGRjgwDQo+ID4gWzY1NDY2LjczNTA0NF0gZGxuMi1zcGkgZGxuMi1zcGkuMy5hdXRvOiByZWdp
c3RlcmVkIG1hc3RlciBzcGkwDQo=
