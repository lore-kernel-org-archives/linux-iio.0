Return-Path: <SRS0=lja0=QU=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5707C282C2
	for <linux-iio@archiver.kernel.org>; Wed, 13 Feb 2019 10:25:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D11E20842
	for <linux-iio@archiver.kernel.org>; Wed, 13 Feb 2019 10:25:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="OoenMr00"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389457AbfBMKZX (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Wed, 13 Feb 2019 05:25:23 -0500
Received: from mail-eopbgr810044.outbound.protection.outlook.com ([40.107.81.44]:11593
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732488AbfBMKZW (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 13 Feb 2019 05:25:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9LNSUSak2jpMG/M45aGW6/K7jwCHDa0VYL0yvT/nmr8=;
 b=OoenMr00+HytPVSQ0RgdCm8EqjLmoTLY5AjxvqxO1sQjyIbRKSvrlf5kk671hy8zqmGYm7WmZwxo9tVeATUF6iSLthaIORr4cNRuGHvjDHDKi5r1j2USHb1uTzMPM+Ps7R+xYuHUhkmVGskf1P8fMa3tMj3w9nPr2Y9b+MVQ0zw=
Received: from BY1PR0301MB0901.namprd03.prod.outlook.com (10.160.195.140) by
 BY1PR0301MB0902.namprd03.prod.outlook.com (10.160.195.141) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.22; Wed, 13 Feb 2019 10:25:18 +0000
Received: from BY1PR0301MB0901.namprd03.prod.outlook.com
 ([fe80::d0a8:9544:4532:8fee]) by BY1PR0301MB0901.namprd03.prod.outlook.com
 ([fe80::d0a8:9544:4532:8fee%5]) with mapi id 15.20.1601.023; Wed, 13 Feb 2019
 10:25:18 +0000
From:   "Hennerich, Michael" <Michael.Hennerich@analog.com>
To:     Leonard Pollak <leonardp@tr-host.de>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: RE: [PATCH] Staging: iio: meter: fixed typo
Thread-Topic: [PATCH] Staging: iio: meter: fixed typo
Thread-Index: AQHUw4W4BqV8xsXe0U2KxSHgOXbPQKXdhY0w
Date:   Wed, 13 Feb 2019 10:25:18 +0000
Message-ID: <BY1PR0301MB090177F0A5F558A90D7A87088E660@BY1PR0301MB0901.namprd03.prod.outlook.com>
References: <20190213101952.29816-1-leonardp@tr-host.de>
In-Reply-To: <20190213101952.29816-1-leonardp@tr-host.de>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Michael.Hennerich@analog.com; 
x-originating-ip: [137.71.226.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 88b9a988-6410-4be3-fe90-08d6919d8d3c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:BY1PR0301MB0902;
x-ms-traffictypediagnostic: BY1PR0301MB0902:
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1;BY1PR0301MB0902;23:Y+1y+Vhe5/AVNY+NUXAxcU1jneK2Jj8hSNGPk16?=
 =?us-ascii?Q?QjLqOBB2fr/S04Q7xraKlcd4n+TF42E6L6WVIePjU/xPiMvf85TeevCtRGxa?=
 =?us-ascii?Q?bqZNPXqf4157IxBaoNVXQubFwJ9F1YarizTpZjgQLOTbtPDjE+9TTBUSlMxa?=
 =?us-ascii?Q?S4awKX5jra8ISAsc5H5Vge/OkaDXUP0EWQoe0NbaD27qI8W1uEZ4lPljAIOX?=
 =?us-ascii?Q?hcFooIVFRLdgagmubts2BWnvyDHGjdROLDYrhgJ/hf24kRMBoEtT6YVrZ800?=
 =?us-ascii?Q?q2tphNGLRcbiMjp53T4gv6+CRTsOAjsGA1rJ/+hBPF6gQw/CjvjTuDQQLeaD?=
 =?us-ascii?Q?Xo+k6AeHBOs4kOcNSxf4El4XKYAtANAjURZNsqb5lK8tM9A0omEakW6//uK6?=
 =?us-ascii?Q?RLAs3evPLp2dH3PZsq6V1PII/Gj4stvGZZcj6s/Lw4Zaw8JG854dQz76j/Nf?=
 =?us-ascii?Q?PHL9aL866VeIb0z1SKSdMFwv55LDqCOTSPak4/MvFX3BX8r8pLTsGfgpPB+F?=
 =?us-ascii?Q?bVtm3v6Q3I5CIdK1VSP0XQAGqoeXkXEJX/yZz+kItouqovUzFaOqh4yw0xIe?=
 =?us-ascii?Q?B08chrplHB6VybSnB3XFVLTPtJAa63BK4yqwhi4bYtZ6N3R/rq18T2AyXThy?=
 =?us-ascii?Q?YVrBTTIMSoLm0T82e1aQn1sv9YMQsF0q3Jl6JWirYDMK2N+RKQJOY6HOtGg7?=
 =?us-ascii?Q?/d0lBR1X3bEp6q4vKMldQOvCeyqtpx3IyMYBkzgAVf9kYp1zy5MJJCn2wpqD?=
 =?us-ascii?Q?hvDKBfg09nvZkl+VNcajRxLh8wNfioPLi3JtfkFbX7SMDFeSGCflY222pftY?=
 =?us-ascii?Q?0s4xMx0ilI0e0oqGiy6tqT6VvgIhaJ/13qPQyQWmb5vun5VxPZHHDqj6uBbS?=
 =?us-ascii?Q?ZFrgtW7NYtcJq8AyDCB9W34Sjqo7AHt2j9He+UhElc4WAlaaAVMSFX+ppDPf?=
 =?us-ascii?Q?u3xrtmONkgeOQzpdN03QYGq+YvbJLC5GPP4ih/51v6ZLBPDMxsmDf8gCB8wP?=
 =?us-ascii?Q?QtPb/y8Ai06Ua9lGU5wszRpwx//U/Aigedfr7rkgxT3uTDPQPVOrGPjECQfK?=
 =?us-ascii?Q?IsktJNxGyGzOS4iGE9XRVd4P8KOmB2hnRcbahi4BhdWEXw8UWgnUpD7zim2B?=
 =?us-ascii?Q?Cn98SFdM7M6OtjcNaJ9ujHagUrPBTjnSxnQPPl7PMJcvLm0gcOE2RdBVl5+P?=
 =?us-ascii?Q?f/o16kERkrAtm/wcMG8FNBNt3OtrkKUApdOWbzx+G55aDgJrk0SohYITpoDm?=
 =?us-ascii?Q?JFEtlqXlo/aqriZcblgawKIh0LjLVfQPYIKiUHg/h?=
x-microsoft-antispam-prvs: <BY1PR0301MB09027C413B011C16F7796BA28E660@BY1PR0301MB0902.namprd03.prod.outlook.com>
x-forefront-prvs: 094700CA91
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(366004)(396003)(39860400002)(136003)(13464003)(189003)(199004)(66066001)(6436002)(3846002)(26005)(186003)(9686003)(14454004)(72206003)(55016002)(53936002)(33656002)(478600001)(446003)(6506007)(53546011)(476003)(6116002)(229853002)(11346002)(25786009)(2906002)(4326008)(305945005)(7736002)(74316002)(68736007)(105586002)(102836004)(486006)(106356001)(6246003)(7696005)(8676002)(71200400001)(86362001)(71190400001)(99286004)(76176011)(8936002)(110136005)(2501003)(256004)(14444005)(2201001)(316002)(97736004)(81156014)(81166006);DIR:OUT;SFP:1101;SCL:1;SRVR:BY1PR0301MB0902;H:BY1PR0301MB0901.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 5NOpRB0JqeQ2uSHGUZY50ZV6fj7kw1EMLcaiyKNG7m8cHBN2pR/kka4ycutHByQ9UVTLSkfvDi8KVFTs7ZoeFSBzf6lhAT1fT15SV88IYb6zsufhHxmGiQrgKvMIhRW5c0+OUY6tKLYWNOExBRoNws2mMevVW34GL+Xpi7TG0ma3KpAYANxyv+IA/XsxHPZdQfI0QrqDe9QVsBwl3PolPeqAjdKsSP0cg9Fig1vat0EK/CqziFH5CaUcZCI6QyvUY+txPUZbruSXYPGlruyISz+RqPsPT6tayHflvsrFlJa4BlrGzpokLUXTfrK5L+XTn6dOUo7U/f7Ueh1xjRPfNANnHSYrVPAWyuLKBPDhtDJYSI2Lq4chA6Rti9aHiqb66cXANhSirTsdEZmaosNgvWAfA1TNcADWStwq+iRs7vc=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88b9a988-6410-4be3-fe90-08d6919d8d3c
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2019 10:25:18.2940
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR0301MB0902
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

> -----Original Message-----
> From: leonard.pollak@tr-host.de [mailto:leonard.pollak@tr-host.de] On Beh=
alf Of Leonard Pollak
> Sent: Mittwoch, 13. Februar 2019 11:20
> To: jic23@kernel.org; lars@metafoo.de; pmeerw@pmeerw.net; Hennerich, Mich=
ael <Michael.Hennerich@analog.com>
> Cc: linux-iio@vger.kernel.org; Leonard Pollak <leonardp@tr-host.de>
> Subject: [PATCH] Staging: iio: meter: fixed typo
>=20
> This patch fixes an obvious typo, which will cause erroneously returning =
the Peak
> Voltage instead of the Peak Current.
>=20
> Signed-off-by: Leonard Pollak <leonardp@tr-host.de>

Acked-by: Michael Hennerich <michael.hennerich@analog.com>

> ---
>  drivers/staging/iio/meter/ade7854.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/staging/iio/meter/ade7854.c b/drivers/staging/iio/me=
ter/ade7854.c
> index 029c3bf42d4d..07774c000c5a 100644
> --- a/drivers/staging/iio/meter/ade7854.c
> +++ b/drivers/staging/iio/meter/ade7854.c
> @@ -269,7 +269,7 @@ static IIO_DEV_ATTR_VPEAK(0644,
>  static IIO_DEV_ATTR_IPEAK(0644,
>                 ade7854_read_32bit,
>                 ade7854_write_32bit,
> -               ADE7854_VPEAK);
> +               ADE7854_IPEAK);
>  static IIO_DEV_ATTR_APHCAL(0644,
>                 ade7854_read_16bit,
>                 ade7854_write_16bit,
> --
> 2.17.1

