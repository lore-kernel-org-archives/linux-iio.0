Return-Path: <SRS0=UtJi=PT=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55052C43387
	for <linux-iio@archiver.kernel.org>; Fri, 11 Jan 2019 23:03:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E6962084C
	for <linux-iio@archiver.kernel.org>; Fri, 11 Jan 2019 23:03:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=uievolution.onmicrosoft.com header.i=@uievolution.onmicrosoft.com header.b="JqpWFCQJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725779AbfAKXDI (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Fri, 11 Jan 2019 18:03:08 -0500
Received: from mail-eopbgr740080.outbound.protection.outlook.com ([40.107.74.80]:37424
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725829AbfAKXDI (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 11 Jan 2019 18:03:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=uievolution.onmicrosoft.com; s=selector1-xevo-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CQPoi3IGnYwKKFqONYpmhDfJc2jc02uzIoZx22XYsH4=;
 b=JqpWFCQJWjvrdO77bTg6r4OgUXRNrexK5r2Mo65arlb0vnbU5eZXyrVUQ2WfQ2iW3UcRNk9T6Rm7f6PZWi06/nNtJrcb49/9R9xS9MFJbxlx+e7TiGDHgghqku9VTd9MxkXMT5De/aJ9g99UYPcUP5AiKIvQ+MgAOAq2XbvwICg=
Received: from DM5PR18MB1452.namprd18.prod.outlook.com (10.173.214.17) by
 DM5PR18MB2229.namprd18.prod.outlook.com (52.132.143.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.14; Fri, 11 Jan 2019 23:03:02 +0000
Received: from DM5PR18MB1452.namprd18.prod.outlook.com
 ([fe80::51ee:5442:1dca:d8fa]) by DM5PR18MB1452.namprd18.prod.outlook.com
 ([fe80::51ee:5442:1dca:d8fa%8]) with mapi id 15.20.1516.010; Fri, 11 Jan 2019
 23:03:02 +0000
From:   Martin Kelly <mkelly@xevo.com>
To:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Martin Kelly <mkelly@xevo.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH] tools: iio: iio_generic_buffer: make num_loops signed
Thread-Topic: [PATCH] tools: iio: iio_generic_buffer: make num_loops signed
Thread-Index: AQHUqgHNb2YAUuSTzES9dJehFoXdUA==
Date:   Fri, 11 Jan 2019 23:03:02 +0000
Message-ID: <20190111230224.20410-1-mkelly@xevo.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR22CA0039.namprd22.prod.outlook.com
 (2603:10b6:300:69::25) To DM5PR18MB1452.namprd18.prod.outlook.com
 (2603:10b6:3:bc::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mkelly@xevo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [174.21.177.9]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR18MB2229;6:as1VCOL95rEqBsAf7Bas9LjSGHCfWdQ9c86On0+V4pPcdmxQcdsSVI0ozL4DdgtnO42nDiweI/2Kbr8Xx3KZQpfeHJSnWBua8zFCg+Z0rGKzPlzqdcEbdtJfmPrnYcRbNU/yRfEU3w/zhaxZt6m7Jm9hTbRiOuMvjDRKps0twsBkpGEDRqKWazQod4m9RXqa1KPwDv0FQlF99Jn2NFwSsH1bH6rMb6WQjJppHIMfjNIMpap1hISehmcMZk5Shx93rc/kp6cp4WT/+zsM6RBaZkEztASEJp76Mm7VN4Wp2/g8iwakzjOln1kHBhVUHAz0U6OO94rbtnHaz0GHmhgOwNsTSEBqafnHNRc9JVwK9Q+7Df1mqDyl1JUqfvhpSK0X8pXs20GzfY6YsFb3TxQjwzekXUGYPKNuO5rgoy55LVy5r/7XhD0VXYkIKZdT2FIyI6OOsH7AAwrpTmVZNfb32w==;5:NndMVLQTiEq2I1vXLL/RfcCbK9K8ODcq3BJU7Xne/4jo7EVBkxTVF4PCMInBYGYIchtbyw2E5aCkiHLubbtz5r84iMFLZlSezKsjvpBuK4VtVkNk6nss2wtXphzuBILWmdek6RDrMaVjbQUFsQCZIMrBVt3drJ1Jw9Xlv+plf1Gr2N5OcwKQh3MBFm7xfr//oQd05+qtLPnXHmGSNLoRWw==;7:clDNk0J+nAV3pm6iCg4qMu65zkXtBbQIy2UH09hUZdJIDiuwsSkhN6H0zyyMclgoE+Fjbv6I7CVbcTqBeixZ+AQLLw8wECIQ/EWwbrbk+Q2HzDFdV+pH7gHKsajNmCe5WDtpDfjzZ/QSK9c7Dg/bgg==
x-ms-office365-filtering-correlation-id: 2226f492-9f17-4eb5-7c6c-08d67818efe3
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060)(7193020);SRVR:DM5PR18MB2229;
x-ms-traffictypediagnostic: DM5PR18MB2229:
x-microsoft-antispam-prvs: <DM5PR18MB222931FC35BE1339ECC5F0A2AB850@DM5PR18MB2229.namprd18.prod.outlook.com>
x-forefront-prvs: 09144DB0F7
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(376002)(136003)(39840400004)(346002)(199004)(189003)(2351001)(316002)(486006)(105586002)(106356001)(53936002)(5660300001)(6512007)(25786009)(2616005)(6916009)(476003)(2906002)(6116002)(4326008)(36756003)(7736002)(3846002)(99286004)(54906003)(8676002)(81166006)(81156014)(102836004)(68736007)(386003)(6506007)(8936002)(52116002)(305945005)(26005)(14444005)(14454004)(256004)(186003)(5640700003)(6486002)(6436002)(86362001)(97736004)(71190400001)(71200400001)(478600001)(2501003)(66066001)(1076003)(41533002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR18MB2229;H:DM5PR18MB1452.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: xevo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Q1CQInKMSg52WqM2zqPYu7unA3wY2fTv1Ft2cBTmcKf3pTgZwYocS2kpBmvj3F7o5ZM5wCYLd1h0mNtUJp9wpnqmbZ+/DwTI248iKrRCOu71+itJbVm7MYwqzZaePfPzewS6qwhRCevEf0cGRQ/8/4gsmMAg2dOvmoKDTw2vQh0JIURvknOwS60JR1LzJry2hz+oFAlSqezM8vzXoZa+ZDDQ6QbJf2c0CS/s/IUyztADGY1zrFNeIlG0nVLyuRVdm2ygAcWb4Rt4jEdxiMLW1VLIhUm10aIYJkQtDQBQ5KIY391lGhJkJsIoKdg1uU3rB75fLANLaWil1cmmavZLF1MRfyiQ5uaj3VmyugpFKv8dQFZsdU8UwxAnZwRpFZ17WSZ9FN6tdB1+2T+z6MyXwL+ALm5Rcj8HqU6ZMEWQocU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xevo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2226f492-9f17-4eb5-7c6c-08d67818efe3
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2019 23:03:02.2465
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e0a7ca1f-2458-4cd6-a7c7-d733c07495ab
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR18MB2229
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Currently, num_loops is unsigned, but it's set by strtoll, which returns a
(signed) long long int. This could lead to overflow, and it also makes the
check "num_loops < 0" always be false, since num_loops is unsigned.
Setting num_loops to -1 to loop forever is almost working because num_loops
is getting set to a very high number, but it's technically still incorrect.

Fix this issue by making num_loops signed. This also fixes an error found
by Smatch.

Signed-off-by: Martin Kelly <mkelly@xevo.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 tools/iio/iio_generic_buffer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/iio/iio_generic_buffer.c b/tools/iio/iio_generic_buffer.=
c
index 3040830d7797..84545666a09c 100644
--- a/tools/iio/iio_generic_buffer.c
+++ b/tools/iio/iio_generic_buffer.c
@@ -330,7 +330,7 @@ static const struct option longopts[] =3D {
=20
 int main(int argc, char **argv)
 {
-	unsigned long long num_loops =3D 2;
+	long long num_loops =3D 2;
 	unsigned long timedelay =3D 1000000;
 	unsigned long buf_len =3D 128;
=20
--=20
2.20.1

