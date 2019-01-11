Return-Path: <SRS0=UtJi=PT=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4DF7C43387
	for <linux-iio@archiver.kernel.org>; Fri, 11 Jan 2019 23:13:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E51E206B6
	for <linux-iio@archiver.kernel.org>; Fri, 11 Jan 2019 23:13:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=uievolution.onmicrosoft.com header.i=@uievolution.onmicrosoft.com header.b="yNzEx4HO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726090AbfAKXNM (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Fri, 11 Jan 2019 18:13:12 -0500
Received: from mail-eopbgr810051.outbound.protection.outlook.com ([40.107.81.51]:13184
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725794AbfAKXNL (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 11 Jan 2019 18:13:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=uievolution.onmicrosoft.com; s=selector1-xevo-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OGyRmZP3QZZNNlCT3Wbx8UDP+f5yAWht2UgjLrLSxSU=;
 b=yNzEx4HOi57feetZ6MZAmLKLkGxl0+KllqThg8ZbyLfZgW0+GGBlodQPo6ipIei5rnCJD6ItBZSq4LS0Aa8cYu3KW/K0C1oclKfOq7fKw+mUOZtGpGqSdr6H7/3mS6GClCDJi6JoHR/PoEq9r7HP+wWzazJwWsvBF58Doxs947A=
Received: from DM5PR18MB1452.namprd18.prod.outlook.com (10.173.214.17) by
 DM5PR18MB2278.namprd18.prod.outlook.com (52.132.143.165) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.13; Fri, 11 Jan 2019 23:13:09 +0000
Received: from DM5PR18MB1452.namprd18.prod.outlook.com
 ([fe80::51ee:5442:1dca:d8fa]) by DM5PR18MB1452.namprd18.prod.outlook.com
 ([fe80::51ee:5442:1dca:d8fa%8]) with mapi id 15.20.1516.010; Fri, 11 Jan 2019
 23:13:09 +0000
From:   Martin Kelly <mkelly@xevo.com>
To:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Martin Kelly <mkelly@xevo.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH v2] tools: iio: iio_generic_buffer: make num_loops signed
Thread-Topic: [PATCH v2] tools: iio: iio_generic_buffer: make num_loops signed
Thread-Index: AQHUqgM3d3tbG7RCl0CXPXChaor2fw==
Date:   Fri, 11 Jan 2019 23:13:09 +0000
Message-ID: <20190111231236.21048-1-mkelly@xevo.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR19CA0023.namprd19.prod.outlook.com
 (2603:10b6:300:d4::33) To DM5PR18MB1452.namprd18.prod.outlook.com
 (2603:10b6:3:bc::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mkelly@xevo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [174.21.177.9]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR18MB2278;6:tudRiwD4rpKW4x6HVoljUJ9sv0Asgn/m3W9tHidc2DLZdf2kJ5jt54tnIQAbsjM9AXdefQF9ApC3nXflg2akoCvQn8/7MfmWxNx8gTi2O02V4Hjj+8Huvj6nEWFvea/jEbmgs49MDg7lw1OkMsyzWUarP/P/BYD3fQKUFtO+p/UWnve2dn2O0ikULkfl4lI+sy4qJ2JvYXSYtr/+tpvPdUNRXiXP3pCN52r9GQFGM88QjutUq7hizxGYBWBr/wZx9PQqLn7zDDYA29rnnE+2CHka5nF21MRT1voiVtLNDAZhHfYLOgv5FNaxaSmzTK38urr4AEnlRnWMSKevr4iNv8YUEeDQF/Ziwv7ByixMlywSuK8Ep+JxFzWgm0clURLG/H6T0Bug3uyAkYIdGR56q9fa/vFUeKbXgHrgdIaBqeVktGcwh3kZfwKl2Tco3fqX1u2Rifa4nDt3l56us9iUbw==;5:UTb39Ks+FzVFjHfwdxaNTMyFYaJRdnxGxcEAPkueLjytOhAv7BvFrWga1RAnRESNxjGh2GLna6RXSiF45BDLh/VUX2GeLqCVFP7x0MXXlg1+6XqFcBmkTgAwevvMuhcCr9o0trgA7jv0Mme5ggsGf08ee+a86ZcDHV5k6gDisAnxo2AM3ioNhCjDqruFG5BwX+fMIoDjQzTZ/FRShYvBxw==;7:o67WBmVYSVrPcJjBPSfawt2LyKwOg21miPUIbU5tTF1Ua0IPriU9L3oNnm8mGcComzDdH4EDFROXsLMwCA+HPrDYy5s/x8XJJjii+U4vPTmGfKd73Bx8QZXRa/YAGYKGLQ5vV2w3jebH3e5Ad5Rjjg==
x-ms-office365-filtering-correlation-id: 793f6c8e-dc3a-4011-328b-08d6781a59a9
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060)(7193020);SRVR:DM5PR18MB2278;
x-ms-traffictypediagnostic: DM5PR18MB2278:
x-microsoft-antispam-prvs: <DM5PR18MB2278579CB5BB149BCA824645AB850@DM5PR18MB2278.namprd18.prod.outlook.com>
x-forefront-prvs: 09144DB0F7
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39840400004)(136003)(396003)(346002)(366004)(376002)(189003)(199004)(6116002)(5660300001)(478600001)(53936002)(256004)(3846002)(14444005)(14454004)(4326008)(575784001)(186003)(386003)(476003)(6506007)(86362001)(66066001)(36756003)(25786009)(102836004)(97736004)(52116002)(6512007)(2906002)(486006)(2501003)(26005)(106356001)(316002)(105586002)(6486002)(8936002)(71190400001)(99286004)(81156014)(6916009)(71200400001)(8676002)(81166006)(54906003)(2351001)(1076003)(5640700003)(305945005)(6436002)(7736002)(2616005)(68736007)(41533002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR18MB2278;H:DM5PR18MB1452.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: xevo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: zP9EhgxhRZB81rocyAO+HZ4wzrSVMbuWsVANxbKSJGRWGpKR52W9LVqG4aXakoOMa0cUSSlSVY3NWWtTpPImLoeGunjqgZyObY1uTWCsOiALivghxTvEcCWz/HbmcCgAXpWqg9dyZwZC3udANTUsE5MivfTW08hefq8S9RIFc8V7aDkFkcjrXxPC58mVKsXy7w395w5MK/Emy8p5ENqx+cmLfVeg6OtOWpxqMLvjiJjiiKf4FWWl3K0FhTccOCXe6hxa5Js11wgBpKkOhcA2dJEwbaP+J/v2CrmZpeuqcKQpY5S28jXhP7GNKk/TBcEYHn/r9tvf8thz4HUuNATgYewvMZbHhuQJ92cN6eQOIwNlN2Iu0YcJ1SDfedyp0t6J8YJajG7SXOcLvRn9KNCNbuLZqDDEsDgXkhpFoYFkIJA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xevo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 793f6c8e-dc3a-4011-328b-08d6781a59a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2019 23:13:09.2153
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e0a7ca1f-2458-4cd6-a7c7-d733c07495ab
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR18MB2278
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
Fixes: 55dda0abcf9d ("tools: iio: iio_generic_buffer: allow continuous loop=
ing")
---
v2:
- No content change; added a Fixes tag.

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

