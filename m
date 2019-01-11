Return-Path: <SRS0=UtJi=PT=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8494C43387
	for <linux-iio@archiver.kernel.org>; Fri, 11 Jan 2019 23:04:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98FFD2084C
	for <linux-iio@archiver.kernel.org>; Fri, 11 Jan 2019 23:04:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=uievolution.onmicrosoft.com header.i=@uievolution.onmicrosoft.com header.b="Vj05d+95"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726227AbfAKXEA (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Fri, 11 Jan 2019 18:04:00 -0500
Received: from mail-eopbgr730059.outbound.protection.outlook.com ([40.107.73.59]:26404
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725536AbfAKXEA (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 11 Jan 2019 18:04:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=uievolution.onmicrosoft.com; s=selector1-xevo-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r4RmQ4dIjx989G7alAYZeTIyooPeQbrlkNS0CbEqzbI=;
 b=Vj05d+95sXeTzSIFbT0r+/mJdpOS8dkzR8MGECrI80szLoxH4t7bBgg1yW1csv/lQOkYclQ7bppnai54z3KJfSFMkNAkUVz3bpB77mjZHhwemOeoeUzHHwedjMjXQaGKM9dUP4kj1ZUUf7DHHs4s3rudwfmJhg2qUMhEJXT3Xyo=
Received: from DM5PR18MB1452.namprd18.prod.outlook.com (10.173.214.17) by
 DM5PR18MB1594.namprd18.prod.outlook.com (10.175.224.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.15; Fri, 11 Jan 2019 23:03:56 +0000
Received: from DM5PR18MB1452.namprd18.prod.outlook.com
 ([fe80::51ee:5442:1dca:d8fa]) by DM5PR18MB1452.namprd18.prod.outlook.com
 ([fe80::51ee:5442:1dca:d8fa%8]) with mapi id 15.20.1516.010; Fri, 11 Jan 2019
 23:03:56 +0000
From:   Martin Kelly <mkelly@xevo.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [bug report] tools: iio: iio_generic_buffer: allow continuous
 looping
Thread-Topic: [bug report] tools: iio: iio_generic_buffer: allow continuous
 looping
Thread-Index: AQHUp5Ic3YtSJg7IJ0uMiUctezryxKWla3wAgAENJACABDwSAA==
Date:   Fri, 11 Jan 2019 23:03:56 +0000
Message-ID: <abcfd370-218b-8118-0cd2-80a54bae9924@xevo.com>
References: <20190108203809.GA27223@kadam>
 <45679eeb-c078-0253-4131-1cafaf648050@xevo.com> <20190109062350.GI3253@kadam>
In-Reply-To: <20190109062350.GI3253@kadam>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR11CA0033.namprd11.prod.outlook.com
 (2603:10b6:300:115::19) To DM5PR18MB1452.namprd18.prod.outlook.com
 (2603:10b6:3:bc::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mkelly@xevo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [174.21.177.9]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR18MB1594;6:kULUc1fPrZKsHARTFZXcvv9fNDVlEHyv3E0WiQD0EKC9W4814e/z2c14xwVNJqehh76yfu2VlHJv5tjKPxhhxNuk/A05Y6nd/B/pA1V72rRRWVsfYVmM/1yZC27kA68c2jus9tczp5WO2E5MrFJsaa72OcXpVHpxaC49971QnD1G8Y7mX549GnPZaUs3eynK0OvZavY3RqU5rrwi384qdIOzcLjfLKWkWV0mFTnIi41+/KK5673PCwY5fYzcp9Y1c4915ZDzY4EvjMddeAcDKfPh1l748Q/EZpSWvK6iYksaZEQ5UZqI0UfbrtRk8he2mJXYOEyxSwsHC2BOvqCzUTUP/Zjr62ZX7FYd1qYPtk375Ya9Wv0FKXoPIngS6ToKxDDIyDlAg9Aaqch0Jvinpo6cFvEYna1NpZBjh7fJo4yZ1MFJhXl4Q46MupdgL5lsDrDxoyGYqKrc4OV9FxaKaQ==;5:p8/Hnx3hHUkTEFqSt+5nh3yo1/OiqS9/P9QWe+6GtMgPEFBNv8hYDx6fA50LIX5NDkPgzD+6p0cYepdLaadbYn6ozj7GP4f2cbmCHwvs4UB86z76xsKKJkB1yMRmDuqj0FtueJ9jU8akLLEHZmUEBu14i93Mf8827grzhiNVkTUdANM5XFsuYkqwCXMjYSQb1YiM0gxFx+mSWl1mr6edDg==;7:34Mz8qyW6n/X2MnKgomDK5Pp4erbGXiuq/gkDKq5+Dx0Vfq0te5Vc84jCZsEOvk82U7k6l1MfeQ7/xWlcN7b2BSiw1ZiBuqwDL0hADmlB65qauD1tDWbGPGxdy5kf3utpNSCMueaV5/60eSM7/p6HQ==
x-ms-office365-filtering-correlation-id: f92f73f0-777d-4feb-c7e8-08d678191061
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060)(7193020);SRVR:DM5PR18MB1594;
x-ms-traffictypediagnostic: DM5PR18MB1594:
x-microsoft-antispam-prvs: <DM5PR18MB15949DE128F1557F42B48806AB850@DM5PR18MB1594.namprd18.prod.outlook.com>
x-forefront-prvs: 09144DB0F7
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(376002)(366004)(346002)(39840400004)(136003)(199004)(189003)(316002)(52116002)(6916009)(105586002)(31696002)(6246003)(2906002)(446003)(186003)(99286004)(86362001)(106356001)(256004)(14444005)(36756003)(2616005)(476003)(11346002)(53936002)(31686004)(97736004)(486006)(3846002)(6116002)(5660300001)(76176011)(6512007)(81166006)(4326008)(6486002)(6436002)(66066001)(68736007)(478600001)(81156014)(8936002)(558084003)(14454004)(7736002)(8676002)(25786009)(386003)(6506007)(102836004)(229853002)(71200400001)(305945005)(71190400001)(26005)(41533002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR18MB1594;H:DM5PR18MB1452.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: xevo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Lrg1+t4mk1WX/jjdR7wPSFM/OjAHr047dL5EVDoLKJLMwW/zwNOPGBWzG+ObW0YQn9AItac0ZjSZc5TtROf6z3KSp2+nAT/177cfD6NYBy8vwU11cR7Nx7KkKi3Q8ZYrxMoynarura77cnnfin2TS38cXSGwJr3JTv39lWEYiW9ro+gyVGy3J9jrfmqZWvsw2fo95g3G3CXvrhHgXA2RGDWXJrbcesqAt4wr2h8sSrEUmJDgkHoEAeN5oDbrAx1+Z5kbto+ZIn7JTyhOMhli4vOvY8v9xzF6VKqLZ51f0rCxbTtLfVO+W0vBLkQODscrcBq/ouMZ33Q6v4u96qX39KzlfuDjSo21MnLkOiKT9pjNlDieATGLx81Q4lJgQmvuHeHI6u/lET8M4DJHg/cbaIVUUkOj+zQQDpGqz/LryjU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <F83ED66E9A6F184AADB777A5ED71EA79@namprd18.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xevo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f92f73f0-777d-4feb-c7e8-08d678191061
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2019 23:03:56.7769
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e0a7ca1f-2458-4cd6-a7c7-d733c07495ab
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR18MB1594
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gMS84LzE5IDEwOjIzIFBNLCBEYW4gQ2FycGVudGVyIHdyb3RlPg0KPiBJdCdzIGEgU21hdGNo
IHdhcm5pbmcuICBJbiB0aGlzIGNhc2UgeW91IHdvdWxkIGp1c3QgZG86DQo+IA0KPiB+L3BhdGgv
dG8vc21hdGNoL3NtYXRjaCB0b29scy9paW8vaWlvX2dlbmVyaWNfYnVmZmVyLmMNCj4gDQoNClRo
YW5rcywgSSBzZW50IGEgcGF0Y2ggdG8gZml4IHRoZSBpc3N1ZS4NCg==
