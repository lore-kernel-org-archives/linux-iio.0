Return-Path: <SRS0=jBoM=QI=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42124C282D8
	for <linux-iio@archiver.kernel.org>; Fri,  1 Feb 2019 12:25:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E881021872
	for <linux-iio@archiver.kernel.org>; Fri,  1 Feb 2019 12:25:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="TNbYxYC1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727283AbfBAMZf (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Fri, 1 Feb 2019 07:25:35 -0500
Received: from mail-eopbgr730059.outbound.protection.outlook.com ([40.107.73.59]:39760
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726172AbfBAMZf (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 1 Feb 2019 07:25:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7fY0MOyLwLf/48sPXxjhAogHzLuqOGP3RnS+nARLf0g=;
 b=TNbYxYC1u+6daeQHgdBFKv2vucTOTfGponKFSVgWzkW0vyI2qkWhX+b94Rb3+y2WIgLHZvCfwoGiShSpfJOjirImXZ0rz7i0hafhRFa49nqy2I+OuKZ8E2A3DAEDUuXzW9WrUD/9HfRJuMAC+K2PwfrFd8nrC7Kh45TjQMFFB9I=
Received: from BN6PR03CA0021.namprd03.prod.outlook.com (2603:10b6:404:23::31)
 by BN7PR03MB3745.namprd03.prod.outlook.com (2603:10b6:408:23::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1580.16; Fri, 1 Feb
 2019 12:25:31 +0000
Received: from SN1NAM02FT026.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::206) by BN6PR03CA0021.outlook.office365.com
 (2603:10b6:404:23::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1580.16 via Frontend
 Transport; Fri, 1 Feb 2019 12:25:31 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.55)
 smtp.mailfrom=analog.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 SN1NAM02FT026.mail.protection.outlook.com (10.152.72.97) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1580.10
 via Frontend Transport; Fri, 1 Feb 2019 12:25:30 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id x11CPUsw030642
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Fri, 1 Feb 2019 04:25:30 -0800
Received: from NWD2MBX7.ad.analog.com ([fe80::190e:f9c1:9a22:9663]) by
 NWD2HUBCAS7.ad.analog.com ([fe80::595b:ced1:cc03:539d%12]) with mapi id
 14.03.0415.000; Fri, 1 Feb 2019 07:25:30 -0500
From:   "Bia, Beniamin" <Beniamin.Bia@analog.com>
To:     Jonathan Cameron <jonathan.cameron@huawei.com>,
        Beniamin Bia <biabeniamin@gmail.com>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: RE: [PATCH 1/2] staging: iio: frequency: ad9833: Get frequency
 value statically
Thread-Topic: [PATCH 1/2] staging: iio: frequency: ad9833: Get frequency
 value statically
Thread-Index: AQHUuhGooTPX08fLgkK5738TOPFxzKXLIPGA//+9QSw=
Date:   Fri, 1 Feb 2019 12:25:29 +0000
Message-ID: <24EEBB4A0151D9478A8841F4BAF525137824F7@NWD2MBX7.ad.analog.com>
References: <20190201093638.26068-1-biabeniamin@gmail.com>,<20190201112401.00005d16@huawei.com>
In-Reply-To: <20190201112401.00005d16@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.50.1.129]
x-adiroutedonprem: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(346002)(136003)(396003)(39860400002)(2980300002)(199004)(189003)(102836004)(8676002)(53546011)(55846006)(8936002)(55016002)(4326008)(26005)(97756001)(186003)(106002)(33656002)(246002)(8746002)(86362001)(426003)(50466002)(336012)(46406003)(106466001)(7736002)(7636002)(305945005)(316002)(110136005)(7696005)(76176011)(6246003)(39060400002)(23726003)(6116002)(3846002)(47776003)(2906002)(126002)(476003)(446003)(72206003)(11346002)(356004)(14454004)(478600001)(229853002)(486006);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR03MB3745;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT026;1:TaUJX0wbZ4NebZGsleIzP53hueSd440R0ktLNCRMoInvJD0Ot29FZ5h52ny9mtjT/4MJ8O6ZWBvIXVPBO6wGJr2HY4VLXx/5v4fJb1AKMjVUmO9smkkXBYhc+n7Nhg917fIhJ4fnLo0LEvHKtLUDzv/yKHdhaOv50UnjYTjGDAc=
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6abaaf9a-0372-46cf-a0a7-08d688405b5e
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4608076)(4709027)(2017052603328)(7153060)(7193020);SRVR:BN7PR03MB3745;
X-Microsoft-Exchange-Diagnostics: 1;BN7PR03MB3745;3:VMeluGPPqVpVIuyEPHFzIwwiXm8jDjBzd0cfZQIQ2UzV2NDt0yDVlieWNKhMs8byuyaG9LP/8APb9R+sqI4S2MFeeBZONQxxU+HuHPrgokRGxZVHE+J8GoTCbg/v/vMoAJIzOpA8zKuC9UPpnId/um6i5ZFBOeJoymcihn7hJJCsKaxeudwJ7WXdKEJSA9VmjKDbZ2Lx8ZJvTzlMT8mbz/mfqnoA+6bwBhBeDMKyojfH53S7VQuxLHRpmLLx+58MAdz6gC3PskvzbGW5ku46Hl42jEXjrfJwwmNnGHgpOCYE403Al74zm6LS/1KeyATCbwqkPyL3yX+Gh63GEctNQiF2uUa1OjoqP3XZt7TtRjU4rIQfCh0kUyhJ+l7cpyBS;25:PCapcEWTzMSzHaiqbCElk5+Axic0TJoO6C25HaPGoIzUQdqHZVtqepI1CRA0nqQCXxIa/j6WK+nC/ErCuGBmXA+V//dGh8RMCHPn4atjluSYjSzTzTyzUKbT0Ke/1YRiKmuXWBKupmHvO1lTlQ3mqmzip3FcpTevl3mlwJHAY1a8IVyJaJMa7Eb3krsYOuduApvZ2l44yN8eBnl48mKQpoTnbrozLcP0DQTAaMSjI1hbI+FWoB9CchTO7wWn6Mv4gpS/wEMLmb1++hS9KNVf4lDqckOT5Sblms+qe/uGveskF6nKqQpXKSTS7KIbcGj+NXoWBQBv5ogWnbgJ2hfWdg==
X-MS-TrafficTypeDiagnostic: BN7PR03MB3745:
X-Microsoft-Exchange-Diagnostics: 1;BN7PR03MB3745;31:hB8lIpCGgMa6HLWZXTo94Zyz8mD9a0+/oz0PBZgbPCXMCRwBTXb0g/d4Po8U5XajQGn3NMPRuhfdSsE5kC8GMo12Ku3pUJE4RBsY42lWndyeUglh0+pV6d8fmH0onOSzmKW+doM7jxPHbrcOtmnSivmFNwN/pXNMx2dk1LmJyQK1Y9bIvN9cs23RweRVmFk6658CkujNB0PM7IDqGVDyijJlVCiLZUK/dBUrY9+/fPw=;20:ZHP6/02cbBNvpzqK1d1hR4uNoZAkyB7fmG/FXUfDDpMXS4pW/fmlfYwLVnw7AEJiZPkDpHBe7tNs4YE94lpBk16iRsFny9xslqZF8iZ1cvfp/kwIHDxQIFwwI+wnonVqZ2hUtBGUHU5nh+wTbieQ75gZ4/EZ7GxHZy9qIzV7evMIiS5h8uZgnQiSmrLtDlF7kit56S623QWCQ3DdxpTBcy9RQ7n8djO18/562ZXA3VA+YvB15zcZL7JUKZU8edknpo/XfhpvjhGLUPguWgtu4411W88o9u8Si0hhtR1l642TQumu/yOWSnSbqPjfUPS1+8HCx7oog76pvjC1cwXvpLSBoimZTzbUem16eqBhNPN/DnOW3OJd53efzYDSZgjGFwCuOUCFtgzG9k9k1o5ZmZb3qCVk2xJRjYarUHeQlnVmrQ17e5k+DIrdxDWmV8piPQHUHwZAg3J/JkV13O2y2oB+TFKy2UKvSMhoqZWp2Bm1zOQQyR3GSfi5aGNsmeQt
X-Microsoft-Antispam-PRVS: <BN7PR03MB3745E086109908B0703B0A80F0920@BN7PR03MB3745.namprd03.prod.outlook.com>
X-Microsoft-Exchange-Diagnostics: 1;BN7PR03MB3745;4:F3VuD8I9klGmEl/71nVewH4RoG4+pIC3Dg0ZG7unlmqu3ybUdrey6kf4Tk9uhSGoWucld6TFa+0JHUddt0Lxp/HLCwksIZiKIDNgiD8OVQBCnIGr2fFc3u6SuK34fkgX/hEjWKuctpVCwyPJA+00jD0oj9NtEQMqgWqKv82Rqd4FORaJt/R+psf36mDtZymJfx07GkfTlwG4QQQxk/lq5sqaFwj9ie8VgupTJyretNR9c9puJXy5Xm1H0kDI+LsnRwsTrXZMq4i032ym80yrStjiSTw2adYN418L1azirBAtRd7Jig9/4fdHjdaMkrA0
X-Forefront-PRVS: 09352FD734
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN7PR03MB3745;23:Vb//ACwXive89nckyu3N/FUW6iMxyJMHN8kCXaqNV?=
 =?us-ascii?Q?AX2uEzliRtEZF1V93x6PkB63MhqKPjiBL3Eg22UMAQZXM+NIXI7pDOtALb0N?=
 =?us-ascii?Q?X3ISgbDjECx614+UR+BggdBPUJWA/YXna6084l0Qw79i3Ni6XfHObQz5HJc3?=
 =?us-ascii?Q?DYGD30RS5RiAGM1HhPQKfaZU4wxmEgdSVsGP7xlxDK9g+TFKyn4lmsBPhE03?=
 =?us-ascii?Q?q7jewaF/rfCulnAMYm96D3mOkym0YD4kEnRyz/5riBZgM6Mqqi2/MRIPig/S?=
 =?us-ascii?Q?aJbgVp2Kav1vncDDYfymHvf9o8dLir1AFmXQCkzz0Ga+PRTS8ypYegjyE03b?=
 =?us-ascii?Q?YMaVwqbpxKdNvqSrIX393kLg0Eyblp3LE16idVU1E0b1EEqSBu2Ig1YisxK4?=
 =?us-ascii?Q?amhhEUkuObXir862qxRESLvNNimcJwTQebY/+YOXLDWTVtsb5JF73m9y2pI6?=
 =?us-ascii?Q?xLyjXpRp13anysjcWXLz34/VhE4WOB7B9gB3BZ1zUztp7KKkdmv8r6+tMdap?=
 =?us-ascii?Q?eZeltNAx7UkJ/p3+NlI6FqS+ZL3hsPBG2jhENYzi31U41mfwG3uNjZvTVXCt?=
 =?us-ascii?Q?IRFiLi88v6GFpuP3Ap5tupBH7dArnwmg7jlmC0Uv8bro7zauLg6E9CWX3zrI?=
 =?us-ascii?Q?nGsKKNZQpboBtBhmn7ohRxbqm4BLCe2KnqqRR7ubcsK8+VJPh9TSaFv2JaNY?=
 =?us-ascii?Q?ak7DlvkvUb/aktfveA1yUwNmXQ2wqHeAC39n4j+1cnyYXdw0c79YUQ6nHKj9?=
 =?us-ascii?Q?XjVNvpNC+4IPyQR/L9TnD34jQW0NHfGu1YtqxbvZDeev+1INOI9vaX39Twwi?=
 =?us-ascii?Q?SOB/AZh9TSLaTXEZDA7jx1OyRn1Gj+rwIwulPTq+yJAZYehMU1sHUZ2MMsLA?=
 =?us-ascii?Q?4QK3eLFAo35zNbd0vaOVSn3TVTQIpwujzvQFFQD4r7bo6oeUp/A/MWg6Z37W?=
 =?us-ascii?Q?Q8xk5Giu5Mk+fnIgxRcdn2/VB2UGAkYouTMJ6Z/+cF73E5HOuGDppnBWMXwX?=
 =?us-ascii?Q?riJGjZpSdK3W/9pLESXAlc/gGqsJ0BWtke7T9suk0IZ3UDA091d9f0wnv005?=
 =?us-ascii?Q?YJNF1OWPdqkELqAawXg98lOoQ4WvDGSHOgftrGK9IWQ0FSUoQ47JX2Dfk8VH?=
 =?us-ascii?Q?jfMqnMLXeajAlOMPq53hT7Z9F9xytuF?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: ZtLO5gSRj08ICtqmQhPS2v1Pci5gwTW/C/Lp1e5IIDVibsLC7NxdEWrw7PoslIr7IU1n67QPCdpqFsA5N0HoBAraKpC/0NNixgnGG5+gzQLOHDRie7KcASDMdQf3558+iPSNob88IXoBiU1nctXpe6+rQnPzXKr8xXb3JN9eCF6fGxcOiKUr5e6bEnspzgW3119HK8uCPR81wW+ngURzjfOfSk7bIMcfwErVunSuuwm9sgezaTX7q7XkYzi9IR7S+jqzFhy1jfFrkRotibxl48GRS0QTyUtr9qirmZWc/pAS8AXGvz/Hyc1ywm2KIsewpYazGFSDEQSz6hiKG8fgZjCNc/BVhOP49a9CN6/8nzOwEJGelWeMOvYNzqYJqQ11yaJ+8JqwVF3qfkKfKucQ1IueVGUGVEHXyMFbI72NWbc=
X-Microsoft-Exchange-Diagnostics: 1;BN7PR03MB3745;6:feOjCiX0yWcbHoQO4hijJmF6qAg5gCGM0cgJno4JQrHDj4PJWSMsBj6HG2Qv8H3bzcFTQ0qQuc0e0aUsAjhOUP8oJ3jJzGbGmTMx+tGc66gAC3Em8RA2hmQA42IP3oY7K4GZY/vMP3HTDo6CDBViVEl71e4ETR1z3fdpTwRaP+veevCAc37n6hkjvfDjc83zc+Pll+m5Vwkqs9jYe8zF/L1XvDS/NVnB86iab3EmtqEOPEMxnbMfzhqxmZcmePb9799wDbKc0wszyjYIBxIB/SEUsI00GDOIVd7ReiKjIBFXSnBrdV0LXx24VHWaFtzvf+vsqdunmLa9gmWSVJ5cLWrPZ4r135S7aboaiUZDmaH1ZUmRb9NMiYb4hUPgW7QWgD7J1UUF7yvAtls1YXMNOuD8QkoyniVLQ50Ro9BMYjcKRM31sNJPW8FoWfMAgjY00J5I1TiNWfLPI2T+RJCG5g==;5:RMIFDMjaqgC35WJMzctdrAXNhUMVy+AWQOlq4j6wi0Yrvn3SqRAfY0vHA8f2SzcWMsVOf5VWkBgdiw+y5qZNh9tYvL4rnfZC+FLO/ui9rxIHLTYYEn3qPPPCp8jd34AD/Rhmnw0dXnhAGqDa2LXTSTy7E9EXpUlBi1z7QOhGnB6uqUEUrAYTPLoX7Z3Yz+TvykdaofxXcvoQba+oFkh8Uw==;7:LRXr2JFZFBtvFCvdFDBU9v+n4aaCX91KobcV0swlkaiR+U8GQrEcPtTStxbqnTcaRnvsS0puXcj/warhGrHoT77w/pDGQBgLzbeH4Qniee9sYYXhTPUbAGeV2feTSoIo+GPIqN25M6kFIQX3Fk2RAQ==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2019 12:25:30.8704
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6abaaf9a-0372-46cf-a0a7-08d688405b5e
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR03MB3745
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The mclk is loaded from device tree in the next patch. This was just a inte=
rmediate step.=0A=
But what should i do with the rest of the fields?=0A=
Frequency and phase are the default configuration of the device and they do=
n't belong in device tree.=0A=
They could also be modified from sysfs.=0A=
Should i remove the struct and write directly the value in probe function?=
=0A=
=0A=
Ben=0A=
________________________________________=0A=
From: Jonathan Cameron [jonathan.cameron@huawei.com]=0A=
Sent: Friday, February 01, 2019 1:24 PM=0A=
To: Beniamin Bia=0A=
Cc: linux-iio@vger.kernel.org; Bia, Beniamin=0A=
Subject: Re: [PATCH 1/2] staging: iio: frequency: ad9833: Get frequency val=
ue statically=0A=
=0A=
[External]=0A=
=0A=
=0A=
On Fri, 1 Feb 2019 11:36:37 +0200=0A=
Beniamin Bia <biabeniamin@gmail.com> wrote:=0A=
=0A=
> The value of frequency is taken from ad9834.c instead of platform data=0A=
=0A=
Why?  I would rather see this move over to DT than take aways the flexibili=
ty=0A=
that was previously there.=0A=
=0A=
Jonathan=0A=
=0A=
>=0A=
> Signed-off-by: Beniamin Bia <beniamin.bia@analog.com>=0A=
> ---=0A=
>  drivers/staging/iio/frequency/ad9834.c | 17 ++++++++++++-----=0A=
>  1 file changed, 12 insertions(+), 5 deletions(-)=0A=
>=0A=
> diff --git a/drivers/staging/iio/frequency/ad9834.c b/drivers/staging/iio=
/frequency/ad9834.c=0A=
> index 995acdd7c942..d92d4bf71261 100644=0A=
> --- a/drivers/staging/iio/frequency/ad9834.c=0A=
> +++ b/drivers/staging/iio/frequency/ad9834.c=0A=
> @@ -99,6 +99,16 @@ enum ad9834_supported_device_ids {=0A=
>       ID_AD9838,=0A=
>  };=0A=
>=0A=
> +static struct ad9834_platform_data default_config =3D {=0A=
> +     .mclk =3D 25000000,=0A=
> +     .freq0 =3D 1000000,=0A=
> +     .freq1 =3D 5000000,=0A=
> +     .phase0 =3D 512,=0A=
> +     .phase1 =3D 1024,=0A=
> +     .en_div2 =3D false,=0A=
> +     .en_signbit_msb_out =3D false,=0A=
> +};=0A=
> +=0A=
>  static unsigned int ad9834_calc_freqreg(unsigned long mclk, unsigned lon=
g fout)=0A=
>  {=0A=
>       unsigned long long freqreg =3D (u64)fout * (u64)BIT(AD9834_FREQ_BIT=
S);=0A=
> @@ -391,16 +401,13 @@ static const struct iio_info ad9833_info =3D {=0A=
>=0A=
>  static int ad9834_probe(struct spi_device *spi)=0A=
>  {=0A=
> -     struct ad9834_platform_data *pdata =3D dev_get_platdata(&spi->dev);=
=0A=
> +     struct ad9834_platform_data *pdata;=0A=
>       struct ad9834_state *st;=0A=
>       struct iio_dev *indio_dev;=0A=
>       struct regulator *reg;=0A=
>       int ret;=0A=
>=0A=
> -     if (!pdata) {=0A=
> -             dev_dbg(&spi->dev, "no platform data?\n");=0A=
> -             return -ENODEV;=0A=
> -     }=0A=
> +     pdata =3D &default_config;=0A=
>=0A=
>       reg =3D devm_regulator_get(&spi->dev, "avdd");=0A=
>       if (IS_ERR(reg))=0A=
=0A=
=0A=
