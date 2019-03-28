Return-Path: <SRS0=6xQ+=R7=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CFBBC43381
	for <linux-iio@archiver.kernel.org>; Thu, 28 Mar 2019 18:38:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F217E20700
	for <linux-iio@archiver.kernel.org>; Thu, 28 Mar 2019 18:38:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="YsiHorLZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725948AbfC1Si1 (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Thu, 28 Mar 2019 14:38:27 -0400
Received: from mail-eopbgr820053.outbound.protection.outlook.com ([40.107.82.53]:44553
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726088AbfC1Si1 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 28 Mar 2019 14:38:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qfb0BBFNYoiCRcoU/ijwoMLMKxhCydmIBFWB1u4wE0g=;
 b=YsiHorLZ4sDD38LtmT6o2jei8sDJw2ImT3qJamq9MOhmzCe+W+q3Ob5cdVB4Iy0qLTyx4S1ElgUJ9bl6asXkleVvySQHTbJQW/Y7u1Bjew3zzTdIgdIsRBtV4EmwyGd5pxFGukXi18bEfh4o8712l+QLbohKfsnE0ELW+ZuJrqg=
Received: from DM5PR03CA0058.namprd03.prod.outlook.com (2603:10b6:4:3b::47) by
 CY1PR03MB2268.namprd03.prod.outlook.com (2a01:111:e400:c614::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1750.17; Thu, 28 Mar
 2019 18:38:23 +0000
Received: from BL2NAM02FT042.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::202) by DM5PR03CA0058.outlook.office365.com
 (2603:10b6:4:3b::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1750.16 via Frontend
 Transport; Thu, 28 Mar 2019 18:38:23 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.57)
 smtp.mailfrom=analog.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 BL2NAM02FT042.mail.protection.outlook.com (10.152.76.193) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1750.16
 via Frontend Transport; Thu, 28 Mar 2019 18:38:23 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id x2SIcMqf024524
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Thu, 28 Mar 2019 11:38:22 -0700
Received: from NWD2MBX5.ad.analog.com ([fe80::49e:7a9f:284e:1a49]) by
 NWD2HUBCAS7.ad.analog.com ([fe80::595b:ced1:cc03:539d%12]) with mapi id
 14.03.0415.000; Thu, 28 Mar 2019 14:38:22 -0400
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
Thread-Index: AQHU3yy6U4ZOFSV/8kGchvXXyG7r0KYbW56AgAZT6oA=
Date:   Thu, 28 Mar 2019 18:38:21 +0000
Message-ID: <1553798299.13791.47.camel@analog.com>
References: <1553093626.13791.37.camel@analog.com>
         <20190324180025.77aa8426@archlinux>
In-Reply-To: <20190324180025.77aa8426@archlinux>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.50.1.179]
x-adiroutedonprem: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <2D601B1AB51A314E97F074D6D6E00C55@analog.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(376002)(346002)(39860400002)(396003)(2980300002)(199004)(189003)(476003)(126002)(23676004)(2486003)(305945005)(106002)(8676002)(107886003)(6246003)(246002)(47776003)(4326008)(7736002)(103116003)(7636002)(5660300002)(110136005)(54906003)(316002)(478600001)(72206003)(966005)(86362001)(36756003)(14454004)(50466002)(106466001)(2501003)(229853002)(2906002)(6306002)(7696005)(3846002)(6116002)(26005)(8936002)(356004)(14444005)(102836004)(436003)(446003)(486006)(11346002)(76176011)(186003)(2616005)(336012)(426003);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR03MB2268;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c4c75449-e9a5-4c79-9adb-08d6b3ac8f0f
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4709054)(2017052603328)(7153060)(7193020);SRVR:CY1PR03MB2268;
X-MS-TrafficTypeDiagnostic: CY1PR03MB2268:
X-MS-Exchange-PUrlCount: 1
X-Microsoft-Antispam-PRVS: <CY1PR03MB22680B28CDB4F5B5994619129D590@CY1PR03MB2268.namprd03.prod.outlook.com>
X-Forefront-PRVS: 0990C54589
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: VS+Pq1EZn2Q92qrotYF5JYoa5qGkBv4cWpsPIejwFCS5vcZkuYySUCsZmBexcOUjGKR3gqUUivmv1cL84nOBmxpTbFMcuoX/lJFG469dlb5vd5KvOCgPyyKwp4VCRIC2S3T6LIl5K96Svm42db7cMEu9aGJysRqIgtZaomZuybfwToFkqqBJupbAfOSpwRRn+bAhiUUFLCjPlBHKS8VdA8ABzNUlG9GmMAGqV30VPHLI0fPr0u2xB16ScMohniHwVK9K3uKdrtEuAx/S/ar+DZ0lA3KbvoALnKM7296EILA1NnxtDL1hGb5lXVLYCwvOJaaLKX2m0IAWtx1pE9/hE1UujhpXYINArpsDoFG2uO4VYgYDZX3a30VLsDWw3zeZmkkl0lM9iKUmgzvfD/wFoSIrW9luZ08vWGufdqNj4Bg=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2019 18:38:23.4244
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c4c75449-e9a5-4c79-9adb-08d6b3ac8f0f
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR03MB2268
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

SGkgSm9uYXRoYW4sDQoNClRoYW5rIHlvdSBmb3IgdGFraW5nIHRoZSB0aW1lIHRvIGFuc3dlci4N
Cg0KVGhlc2UgZGV2aWNlcyBhcmUgbW9zdGx5IHVzZWQgaW4gYXV0b21vdGl2ZS9hZXJvc3BhY2Ug
aW5kdXN0cmllcyB3aGVyZSB0aGV5DQp1c3VhbGx5IHJlcXVpcmUgYSBjb250aW51b3VzIHN0cmVh
bSBvZiBkYXRhIGV2ZW4gaWYgYW4gZXJyb3Igb2NjdXJzLiBUaGlzDQppcyB3aHkgd2UgY2Fubm90
IGp1c3QgImRyb3AgdGhlIHJlY29yZCIgOikuDQpTbywgc2hvdWxkIHdlIG1heWJlIHRoaW5rIG9m
IGEgd2F5IG9mIGNvdmVyaW5nIGZsYWdzIGNoYW5uZWwgdHlwZXM/DQoNClJlZ2FyZHMsDQotU3Rl
ZmFuwqANCg0KT24gRHUsIDIwMTktMDMtMjQgYXQgMTg6MDAgKzAwMDAsIEpvbmF0aGFuIENhbWVy
b24gd3JvdGU6DQo+IA0KPiANCj4gT24gV2VkLCAyMCBNYXIgMjAxOSAxNDo1Mzo1MCArMDAwMA0K
PiAiUG9wYSwgU3RlZmFuIFNlcmJhbiIgPFN0ZWZhblNlcmJhbi5Qb3BhQGFuYWxvZy5jb20+IHdy
b3RlOg0KPiANCj4gPiANCj4gPiBIZWxsbywNCj4gPiANCj4gPiBXZSBhcmUgY3VycmVudGx5IHdv
cmtpbmcgb24gYSBuZXcgYWRpczE2NDk1IElNVSBkcml2ZXIgd2hpY2ggaXMgYW4NCj4gPiB1cGdy
YWRlDQo+ID4gZnJvbSB0aGUgYWRpczE2NDgwIGZhbWlseTogaHR0cHM6Ly93d3cuYW5hbG9nLmNv
bS9tZWRpYS9lbi90ZWNobmljYWwtZG8NCj4gPiBjdW1lDQo+ID4gbnRhdGlvbi9kYXRhLXNoZWV0
cy9BRElTMTY0OTUucGRmLg0KPiA+IA0KPiA+IFRoaXMgbmV3IGNoaXAgc3VwcG9ydHMgYSBmZWF0
dXJlIGNhbGxlZCAiQnVyc3QgUmVhZCBGdW5jdGlvbiIgKHBhZ2UgMTMNCj4gPiBpbg0KPiA+IHRo
ZSBkYXRhc2hlZXQpLiBUaGUgYnVyc3QgcmVhZCBmdW5jdGlvbiAoQlJGKSBwcm92aWRlcyBhIG1l
dGhvZCBmb3INCj4gPiByZWFkaW5nDQo+ID4gYSBiYXRjaCBvZiBkYXRhIChzdGF0dXMsIHRlbXBl
cmF0dXJlLCBneXJvc2NvcGVzLCBhY2NlbGVyb21ldGVycywgdGltZQ0KPiA+IHN0YW1wL2RhdGEg
Y291bnRlciwgYW5kIENSQyBjb2RlKSwgd2hpY2ggZG9lcyBub3QgcmVxdWlyZSBhIHN0YWxsDQo+
ID4gdGltZSBiZXR3ZWVuIGVhY2ggMTYtYml0IHNlZ21lbnQgYW5kIG9ubHkgcmVxdWlyZXMgb25l
IGNvbW1hbmQNCj4gPiBvbiB0aGUgRElOIGxpbmUgdG8gaW5pdGlhdGUuDQo+ID4gDQo+ID4gTW9z
dCBvZiB0aGUgZGF0YSByZWFkIGluIHRoaXMgd2F5IGNhbiBiZSBhdHRyaWJ1dGVkIHRvIGEgdHlw
ZSBvZg0KPiA+IGNoYW5uZWw6DQo+ID4gSUlPX1RFTVAsIElJT19BTkdMX1ZFTCwgSUlPX0FDQ0VM
LCBldGMuIEhvd2V2ZXIsIHRoZXJlIGlzIG5vIGVxdWl2YWxlbnQNCj4gPiBmb3INCj4gPiB0aGUg
c3RhdHVzIGFuZCBDUkMuIFRoZSBzdGF0dXMgcmVnaXN0ZXIgcHJvdmlkZXMgdmFyaW91cyBlcnJv
ciBmbGFncw0KPiA+IHN1Y2gNCj4gPiBhcyBzcGkgY29tbXVuaWNhdGlvbiBlcnJvciwgc2Vuc29y
IGZhaWx1cmUsIHN5bmMgZXJyb3IsIGV0YyAoVGFibGUgMTgNCj4gPiBpbg0KPiA+IHRoZSBkYXRh
c2hlZXQpLiBUaGlzIGluZm9ybWF0aW9uIHRvZ2V0aGVyIHdpdGggdGhlIENSQyBlcnJvciBzaG91
bGQgYmUNCj4gPiBleHBvc2VkIHRvIHRoZSB1c2VyIHNwYWNlLiBXaGF0IGlzIHRoZSBiZXN0IHdh
eSB0byBkbyBpdD8NCj4gT2ssIFNvIHRoaXMgaXMgbm90IGV4YWN0bHkgdW51c3VhbC7CoMKgVGhl
IGlzc3VlIGhhcyBhbHdheXMgYmVlbiBkZWZpbmluZw0KPiBhIHJlbW90ZWx5IGdlbmVyaWMgdXNl
cnNwYWNlIEFCSS4NCj4gDQo+ID4gDQo+ID4gDQo+ID4gVGhlIG1vc3Qgb2J2aW91cyB3YXksIGJ1
dCBub3QgbmVjZXNzYXJpbHkgdGhlIGNvcnJlY3Qgb25lLCB3b3VsZCBiZSB0bw0KPiA+IGFkZA0K
PiA+IGEgbmV3IGNoYW5uZWwgdHlwZSBjYWxsZWQgc29tZXRoaW5nIGxpa2UgSUlPX1NUQVRVUyBv
ciBJSU9fRkxBRy4gSXMNCj4gPiB0aGlzDQo+ID4gYWNjZXB0YWJsZT8NCj4gTm8gdW5mb3J0dW5h
dGVseS4gV2hhdCBkb2VzIGdlbmVyaWMgdXNlcnNwYWNlIGRvIHdpdGggaXQ/DQo+IA0KPiBQYXJ0
IG9mIHRoZSBwcm9ibGVtIGlzIHdlIGRvbid0IGhhdmUgYSBjaGFubmVsIHR5cGUgdG8gY292ZXIg
ZmxhZ3MgaW4NCj4gZ2VuZXJhbCAoaWYgd2UgaGFkIGRpZ2l0YWwgaW5wdXRzIHBhY2tlZCBpbnRv
IGJ5dGVzIHdlIHdvdWxkIGF0IGxlYXN0DQo+IGJlIHNsaWdodGx5IGJldHRlciBvZmYpLg0KPiAN
Cj4gPiANCj4gPiANCj4gPiBBIG1vcmUgb3IgbGVzcyBzaW1pbGFyIGJ1cnN0IHJlYWQgZnVuY3Rp
b24gaGFzIGJlZW4gcHJldmlvdXNseQ0KPiA+IGltcGxlbWVudGVkDQo+ID4gYXMgcGFydCBvZiB0
aGUgYWRpczE2NDAwIGRyaXZlci4gQWx0aG91Z2ggYSBidXJzdCByZWFkIHdpbGwgYWxzbw0KPiA+
IHByb2R1Y2UNCj4gPiBkaWFnbm9zdGljIHN0YXR1cyBkYXRhLCBpdCB3YXMgaWdub3JlZCBpbiB0
aGUgZHJpdmVyIGltcGxlbWVudGF0aW9uLg0KPiBZdXAgOinCoMKgQ291bGRuJ3QgZmlndXJlIG91
dCBob3cgdG8gZG8gaXQgYXQgdGhlIHRpbWUuDQo+IA0KPiBOb3JtYWxseSB0aGVzZSBmbGFncyBy
ZXByZXNlbnQgZXJyb3IgY29uZGl0aW9ucyAoaWYgdGhleSBtYXAgdG8gZXZlbnRzDQo+IGluIElJ
TyB0aGVuIHB1dCB0aGVtIG91dCBsaWtlIHRoYXQpLsKgwqBUaGUgcHJvYmxlbSBoYXMgYWx3YXlz
IGJlZW4gdGhhdA0KPiBMaW51eCBkb2Vzbid0IGFjdHVhbGx5IGhhdmUgZ2VuZXJpYyBzaW1wbGUg
ZXJyb3IgZXZlbnQgaGFuZGxpbmcuDQo+IFRoZXJlIGlzIFJBUyBoYW5kbGluZyBmb3Igc2VydmVy
cywgYnV0IHdobyBydW5zIGl0IG9uIGVtYmVkZGVkIGJvYXJkcw0KPiBleGNlcHQgcG9zc2libHkg
Zm9yIHNvbWUgZm9ybSBvZiBFREFDLg0KPiANCj4gPiANCj4gPiANCj4gPiBMb29raW5nIGZvcndh
cmQgdG8gYW55IHN1Z2dlc3Rpb24uDQo+IEknbSBub3QgYWdhaW5zdCB1cyBoYXZpbmcgbWV0YSBk
YXRhIGNoYW5uZWxzLCBidXQgdGhleSBwcmV0dHkgbXVjaCBuZWVkDQo+IHRvIGJlIGFzIHRpZ2h0
bHkgZGVmaW5lZCBhcyBhbnkgb3RoZXIgY2hhbm5lbC7CoMKgVGhlIG90aGVyIHNpZGUgaXNzdWUN
Cj4gaGVyZSBpcyBpdCdzIGEgbmV3ICdodWdlJyBzcGFjZS7CoMKgSG93ZXZlciwgSSdtIG5vdCBz
dXJlIHlvdSBhcmUgaW4NCj4gdGhhdCB0ZXJyaXRvcnkgaGVyZS7CoMKgTG9va3MgdG8gbWUgbGlr
ZSBzdGF0dXMgcmVhbGx5IG1lYW5zIGVycm9yLg0KPiBJZiB5b3UgZ2V0IGFuIGVycm9yLCBtb3N0
bHkgaXQncyBnYW1lIG92ZXIuwqDCoElmIHlvdSBnZXQgYSBDUkMgZXJyb3INCj4gYW5kIHdhbnQg
dG8gY2hlY2sgaXQsIHRoZW4gZHJvcCB0aGUgcmVjb3JkIGFuZCBzcGl0IG91dCBhIG1lc3NhZ2Uu
DQo+IA0KPiBTbyBJJ20gYSBsaXR0bGUgdW5jb252aW5jZWQgYXMgeWV0IHRoYXQgdGhlcmUgaXMg
YW55dGhpbmcgd2UgYWN0dWFsbHkNCj4gY2FuIHVzZSBpbiB0aGlzIHN0YXR1cyBtZXNzYWdlLg0K
PiANCj4gSm9uYXRoYW4NCj4gDQo+IA0KPiA+IA0KPiA+IA0KPiA+IC1TdGVmYW4=
