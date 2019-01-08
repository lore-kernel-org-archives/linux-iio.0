Return-Path: <SRS0=0K8c=PQ=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=BIGNUM_EMAILS,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78E0CC43387
	for <linux-iio@archiver.kernel.org>; Tue,  8 Jan 2019 22:20:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DE2420883
	for <linux-iio@archiver.kernel.org>; Tue,  8 Jan 2019 22:20:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=uievolution.onmicrosoft.com header.i=@uievolution.onmicrosoft.com header.b="qZz6Olx+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729680AbfAHWUo (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Tue, 8 Jan 2019 17:20:44 -0500
Received: from mail-eopbgr730064.outbound.protection.outlook.com ([40.107.73.64]:60339
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729288AbfAHWUo (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 8 Jan 2019 17:20:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=uievolution.onmicrosoft.com; s=selector1-xevo-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dSdXE/c+i1Cg+jFqd5iDg0r/hksKjPmceaZiQ070Mx8=;
 b=qZz6Olx+22dbguaEBKlpu1LuSYga5hB8/P+BdNNIpNZlAYRGoRSztOLJ0eex4v2I5adwPzeMOlf6uk2etSDx5qY+l5MPtZND+0OHMmGDjumSKXUPE0UuB8dyfN9PKTdzE3DIREPCcVS5LXopMtoOWk78YKuLzSxp7+B+amVcHbw=
Received: from CY4PR18MB1447.namprd18.prod.outlook.com (10.172.176.23) by
 CY4PR18MB1494.namprd18.prod.outlook.com (10.173.61.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1495.9; Tue, 8 Jan 2019 22:20:38 +0000
Received: from CY4PR18MB1447.namprd18.prod.outlook.com
 ([fe80::a04b:e796:f83a:4a64]) by CY4PR18MB1447.namprd18.prod.outlook.com
 ([fe80::a04b:e796:f83a:4a64%6]) with mapi id 15.20.1495.011; Tue, 8 Jan 2019
 22:20:38 +0000
From:   Martin Kelly <mkelly@xevo.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [bug report] tools: iio: iio_generic_buffer: allow continuous
 looping
Thread-Topic: [bug report] tools: iio: iio_generic_buffer: allow continuous
 looping
Thread-Index: AQHUp5Ic3YtSJg7IJ0uMiUctezryxKWl8ZgA
Date:   Tue, 8 Jan 2019 22:20:38 +0000
Message-ID: <45679eeb-c078-0253-4131-1cafaf648050@xevo.com>
References: <20190108203809.GA27223@kadam>
In-Reply-To: <20190108203809.GA27223@kadam>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR07CA0074.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::15) To CY4PR18MB1447.namprd18.prod.outlook.com
 (2603:10b6:903:108::23)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mkelly@xevo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [4.14.243.50]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR18MB1494;6:nxRiKKOF3ERRAm183AdI9Hj3mKvhCJ8gMc5Zi+IZ7L87Dk153Afpp3KnxnMIX/D1pYQZCACinxZJ0W8k1GLaY7e/T44Ztmjf3C9L6pcaBXAIwoFhiCJ2uJ1pFTosT7JWKIIBdWgSp/lqbrofYT+JfECR0hNoGuycHofuehLJ/QOvKg6qsG/x1XfuHkfNxpG01KPeXcmxQB7cU+N0h1oY+V1DLV0aASK/5BLL3tRfqPeczZPGXeWTqmUex9tBYuKI5GchCy9asmttvczB5IjL13U89VdebfF6Gu+TxT7LRGPM/3B/97ozaJKcAoEJY8FQEMxf6jzZiGAmZg0fTuDQYQBN4kfG7vr1PEzAM2hNGbT4E60gvwPKDceai+DnRP78qDEI25JdZxWz7Kbeg00bUlwpuW8IFguu4Aw/1hH4c6RQcLnHeeaAOfkOx/ZWWJbRSLSnMVwFoFFVDHOlTooOvQ==;5:etKj2HPFwl10w6XGnj+MWOJ3k8tR0oLiQ0sXGxzrGw6A/SbytprBBMEyrEfSoagqNFUA062jc6l7TlVN+Kv5QhitJqXaSCqh6eVpXN1uGWzVmgpLFVVpDZqHDj/FNZVGgYXov1VSKLBA2mPhjPt//kv7a0xGQfN+31tW5UvoMzU8PzbGzeGbKYtWedCCdwcA50034ub63kW4VeKGoXsJJg==;7:MB8oHNnZDBbsQa1fwa0aBDvRHua6325UheAWrllDU3A7gM3Me2FF7h35JMa82XL4jjBGGLceWfNNfX0ZbPEIWAQYuhquREWegJiX4N2k6sRUYDTVSTwiA/kwVSFt53Fi5ouoar6IGu892/YFZ10fhg==
x-ms-office365-filtering-correlation-id: db31d5b9-41d0-4c56-729b-08d675b78455
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060)(7193020);SRVR:CY4PR18MB1494;
x-ms-traffictypediagnostic: CY4PR18MB1494:
x-microsoft-antispam-prvs: <CY4PR18MB1494B100457A0B80F6FAD10CAB8A0@CY4PR18MB1494.namprd18.prod.outlook.com>
x-forefront-prvs: 0911D5CE78
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(366004)(39840400004)(396003)(136003)(189003)(199004)(99286004)(486006)(6486002)(5660300001)(229853002)(6506007)(97736004)(102836004)(52116002)(186003)(53546011)(31696002)(386003)(6916009)(6436002)(316002)(71190400001)(71200400001)(3846002)(76176011)(86362001)(575784001)(8936002)(476003)(66066001)(81166006)(14454004)(8676002)(256004)(81156014)(14444005)(68736007)(7736002)(2616005)(6116002)(478600001)(446003)(11346002)(6246003)(105586002)(106356001)(305945005)(26005)(6512007)(25786009)(31686004)(53936002)(2906002)(4326008)(36756003)(41533002);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR18MB1494;H:CY4PR18MB1447.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: xevo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: O/88/gWgOvOb5/lsau/IU6vV23Y4kQr+7xAolTd0t7vyJQdTZa6UQL0vws61YO1A0IcX03lUlrSlXkGjOdhxfE5fFMC8AjHqZuXYQnXvzIOuYL5PQcb990FRtflSZFSfAOhcrWLeFMpliX4/lMTxsI21tRi501W0Th/OQtxxaHKU9mMdBRDxctLcpYY4UVhMJsaWh+rrgG2U1EfQug3qwEWzM9nBix7YSd9JuL/KISYxTiKV90ho4LMM9srbC7wkC/kuxFn4bMrGqu94dstN/Pxq3OhfqInnBWQS8uu5SXNTfEvCZuA6F4fzOb8ydIRB
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <BFCBD8C5E5F0534DB8743479E9797A8E@namprd18.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xevo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db31d5b9-41d0-4c56-729b-08d675b78455
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2019 22:20:38.1823
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e0a7ca1f-2458-4cd6-a7c7-d733c07495ab
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR18MB1494
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gMS84LzE5IDEyOjM4IFBNLCBEYW4gQ2FycGVudGVyIHdyb3RlOg0KPiBIZWxsbyBNYXJ0aW4g
S2VsbHksDQo+IA0KPiBUaGUgcGF0Y2ggNTVkZGEwYWJjZjlkOiAidG9vbHM6IGlpbzogaWlvX2dl
bmVyaWNfYnVmZmVyOiBhbGxvdw0KPiBjb250aW51b3VzIGxvb3BpbmciIGZyb20gTWF5IDE3LCAy
MDE4LCBsZWFkcyB0byB0aGUgZm9sbG93aW5nIHN0YXRpYw0KPiBjaGVja2VyIHdhcm5pbmc6DQo+
IA0KPiAJLi90b29scy9paW8vaWlvX2dlbmVyaWNfYnVmZmVyLmM6NjQwIG1haW4oKQ0KPiAJd2Fy
bjogdW5zaWduZWQgJ251bV9sb29wcycgaXMgbmV2ZXIgbGVzcyB0aGFuIHplcm8uDQo+IA0KDQpU
aGFua3MgZm9yIGNhdGNoaW5nIHRoaXMuIEhvdyBjYW4gSSByZXBybyB0aGlzIHNvIHRoYXQgSSBj
YW4gbWFrZSBzdXJlIA0KdGhlIHN0YXRpYyBhbmFseXplciBpcyBoYXBweSBvbmNlIEkgZml4IGl0
Pw0KDQo+IC4vdG9vbHMvaWlvL2lpb19nZW5lcmljX2J1ZmZlci5jDQo+ICAgICAgMzMxIGludCBt
YWluKGludCBhcmdjLCBjaGFyICoqYXJndikNCj4gICAgICAzMzIgew0KPiAgICAgIDMzMyAJdW5z
aWduZWQgbG9uZyBsb25nIG51bV9sb29wcyA9IDI7DQo+ICAgICAgICAgICAgICAgICAgXl5eXl5e
Xl4NCj4gDQo+ICAgICAgMzM0IAl1bnNpZ25lZCBsb25nIHRpbWVkZWxheSA9IDEwMDAwMDA7DQo+
ICAgICAgMzM1IAl1bnNpZ25lZCBsb25nIGJ1Zl9sZW4gPSAxMjg7DQo+ICAgICAgMzM2DQo+ICAg
ICAgMzM3IAlzc2l6ZV90IGk7DQo+ICAgICAgMzM4IAl1bnNpZ25lZCBsb25nIGxvbmcgajsNCj4g
ICAgICAzMzkgCXVuc2lnbmVkIGxvbmcgdG9yZWFkOw0KPiAgICAgIDM0MCAJaW50IHJldCwgYzsN
Cj4gICAgICAzNDEgCWludCBmcCA9IC0xOw0KPiAgICAgIDM0Mg0KPiAgICAgIDM0MyAJaW50IG51
bV9jaGFubmVscyA9IDA7DQo+ICAgICAgMzQ0IAljaGFyICp0cmlnZ2VyX25hbWUgPSBOVUxMLCAq
ZGV2aWNlX25hbWUgPSBOVUxMOw0KPiAgICAgIDM0NQ0KPiAgICAgIDM0NiAJY2hhciAqZGF0YSA9
IE5VTEw7DQo+ICAgICAgMzQ3IAlzc2l6ZV90IHJlYWRfc2l6ZTsNCj4gICAgICAzNDggCWludCBk
ZXZfbnVtID0gLTEsIHRyaWdfbnVtID0gLTE7DQo+ICAgICAgMzQ5IAljaGFyICpidWZmZXJfYWNj
ZXNzID0gTlVMTDsNCj4gICAgICAzNTAgCWludCBzY2FuX3NpemU7DQo+ICAgICAgMzUxIAlpbnQg
bm9ldmVudHMgPSAwOw0KPiAgICAgIDM1MiAJaW50IG5vdHJpZ2dlciA9IDA7DQo+ICAgICAgMzUz
IAljaGFyICpkdW1teTsNCj4gICAgICAzNTQgCWJvb2wgZm9yY2VfYXV0b2NoYW5uZWxzID0gZmFs
c2U7DQo+ICAgICAgMzU1DQo+ICAgICAgMzU2IAlzdHJ1Y3QgaWlvX2NoYW5uZWxfaW5mbyAqY2hh
bm5lbHMgPSBOVUxMOw0KPiAgICAgIDM1Nw0KPiANCj4gWyBzbmlwIF0NCj4gDQo+ICAgICAgNjMy
IAkvKiBBdHRlbXB0IHRvIG9wZW4gbm9uIGJsb2NraW5nIHRoZSBhY2Nlc3MgZGV2ICovDQo+ICAg
ICAgNjMzIAlmcCA9IG9wZW4oYnVmZmVyX2FjY2VzcywgT19SRE9OTFkgfCBPX05PTkJMT0NLKTsN
Cj4gICAgICA2MzQgCWlmIChmcCA9PSAtMSkgeyAvKiBUT0RPOiBJZiBpdCBpc24ndCB0aGVyZSBt
YWtlIHRoZSBub2RlICovDQo+ICAgICAgNjM1IAkJcmV0ID0gLWVycm5vOw0KPiAgICAgIDYzNiAJ
CWZwcmludGYoc3RkZXJyLCAiRmFpbGVkIHRvIG9wZW4gJXNcbiIsIGJ1ZmZlcl9hY2Nlc3MpOw0K
PiAgICAgIDYzNyAJCWdvdG8gZXJyb3I7DQo+ICAgICAgNjM4IAl9DQo+ICAgICAgNjM5DQo+IC0t
PiA2NDAgCWZvciAoaiA9IDA7IGogPCBudW1fbG9vcHMgfHwgbnVtX2xvb3BzIDwgMDsgaisrKSB7
DQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBeXl5eXl5e
Xl5eXl5eDQo+IElmIG51bV9sb29wcyBpcyAtMSB0aGVuIGl0J3Mgc3VwcG9zZWQgdG8gbG9vcCBm
b3JldmVyLiAgSXQgYmFzaWNhbGx5DQo+IGRvZXMsIGV4Y2VwdCBmb3IgdGhlIHN0YXRpYyBjaGVj
a2VyIHdhcm5pbmcuDQo+IA0KDQpZZXAsIGxvb2tzIGxpa2UgLTEgZ2V0cyBjb252ZXJ0ZWQgdG8g
VUxPTkdfTE9OR19NQVggYW5kIGl0IGxvb3BzIGZvciBhIA0KdmVyeSBsb25nIHRpbWUgYnV0IG5v
dCBmb3JldmVyLiBJIHdpbGwgZml4IGl0IHNvb24uDQoNCj4gICAgICA2NDEgCQlpZiAoIW5vZXZl
bnRzKSB7DQo+ICAgICAgNjQyIAkJCXN0cnVjdCBwb2xsZmQgcGZkID0gew0KPiAgICAgIDY0MyAJ
CQkJLmZkID0gZnAsDQo+ICAgICAgNjQ0IAkJCQkuZXZlbnRzID0gUE9MTElOLA0KPiAgICAgIDY0
NSAJCQl9Ow0KPiAgICAgIDY0Ng0KPiAgICAgIDY0NyAJCQlyZXQgPSBwb2xsKCZwZmQsIDEsIC0x
KTsNCj4gICAgICA2NDggCQkJaWYgKHJldCA8IDApIHsNCj4gICAgICA2NDkgCQkJCXJldCA9IC1l
cnJubzsNCj4gICAgICA2NTAgCQkJCWdvdG8gZXJyb3I7DQo+ICAgICAgNjUxIAkJCX0gZWxzZSBp
ZiAocmV0ID09IDApIHsNCj4gICAgICA2NTIgCQkJCWNvbnRpbnVlOw0KPiAgICAgIDY1MyAJCQl9
DQo+ICAgICAgNjU0DQo+ICAgICAgNjU1IAkJCXRvcmVhZCA9IGJ1Zl9sZW47DQo+ICAgICAgNjU2
IAkJfSBlbHNlIHsNCj4gICAgICA2NTcgCQkJdXNsZWVwKHRpbWVkZWxheSk7DQo+ICAgICAgNjU4
IAkJCXRvcmVhZCA9IDY0Ow0KPiAgICAgIDY1OSAJCX0NCj4gDQo+IHJlZ2FyZHMsDQo+IGRhbiBj
YXJwZW50ZXINCj4gDQo=
