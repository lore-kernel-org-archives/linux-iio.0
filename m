Return-Path: <SRS0=iua/=RX=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B4F4C43381
	for <linux-iio@archiver.kernel.org>; Wed, 20 Mar 2019 07:38:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E71872184D
	for <linux-iio@archiver.kernel.org>; Wed, 20 Mar 2019 07:38:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="I7InYCrV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbfCTHiy (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Wed, 20 Mar 2019 03:38:54 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:52708 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726303AbfCTHiy (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 20 Mar 2019 03:38:54 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x2K7Xc6d077616;
        Wed, 20 Mar 2019 07:38:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=NIzDeIKH6ELKBgqSCVyVJqAznx7FTsXsPA+i2qEd6PI=;
 b=I7InYCrVmnoyCIeZ09h8vCkGlbRo8bKi/HXOPxTZHXCkc+8Gn1j4njpikrgRl14/h6BS
 1kW+jTU33KYLAPxjSlY6RL3Tul+f5LvNy46hxytYV+9VHdXEiDHkWJRg3NOYL48h95ar
 UT7VFHTroELIiWUd1jHKF5GxVZgyZBrfn3GgzhHwqTy7VIQnICn3u6uCr2Y/qdP6onws
 VjBbvrcqb4Fs21SHyApIyVJHS1b3aAE250FgFDwmOtoibmEW1vQL6wKfFZ4tUVjuaTpg
 OzMKgosElVgbgXPBuYTijUzhSAP9M/zQa0yF2sXNQo/fMONxW7UcHu9djB/qnqPlMHWW nw== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2120.oracle.com with ESMTP id 2r8ssrgx5d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Mar 2019 07:38:14 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x2K7cE22030190
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Mar 2019 07:38:14 GMT
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x2K7cC5k020325;
        Wed, 20 Mar 2019 07:38:12 GMT
Received: from kadam (/10.175.25.169)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 20 Mar 2019 00:38:11 -0700
Date:   Wed, 20 Mar 2019 10:38:06 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Vladimir Petrigo <vladimir.petrigo@gmail.com>
Cc:     linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Nishad Kamdar <nishadkamdar@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stefan Popa <stefan.popa@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Renato Lui Geh <renatogeh@gmail.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Slawomir Stepien <sst@poczta.fm>,
        Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH 2/3] staging: iio: ad7280a: Add parentheses to macros
Message-ID: <20190320073805.GD2202@kadam>
References: <1552855992-27653-1-git-send-email-vladimir.petrigo@gmail.com>
 <1552855992-27653-3-git-send-email-vladimir.petrigo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1552855992-27653-3-git-send-email-vladimir.petrigo@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9200 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903200064
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Mar 17, 2019 at 11:53:11PM +0300, Vladimir Petrigo wrote:
> Fix CHECK Macro argument 'c' may be better as '(c)' to
> avoid precedence issues
> 
> Signed-off-by: Vladimir Petrigo <vladimir.petrigo@gmail.com>
> 
> diff --git a/drivers/staging/iio/adc/ad7280a.c
> b/drivers/staging/iio/adc/ad7280a.c index d9df126..98cf876
> 100644 --- a/drivers/staging/iio/adc/ad7280a.c +++
> b/drivers/staging/iio/adc/ad7280a.c @@ -97,9 +97,9 @@
>  #define AD7280A_NUM_CH (AD7280A_AUX_ADC_6 - \
>  					AD7280A_CELL_VOLTAGE_1
> + 1)
> 
> -#define AD7280A_CALC_VOLTAGE_CHAN_NUM(d, c) ((d *
> AD7280A_CELLS_PER_DEV) + c) -#define
> AD7280A_CALC_TEMP_CHAN_NUM(d, c) ((d *
> AD7280A_CELLS_PER_DEV) + \ - c - AD7280A_CELLS_PER_DEV)
> +#define AD7280A_CALC_VOLTAGE_CHAN_NUM(d, c) (((d) *
> AD7280A_CELLS_PER_DEV) + (c)) +#define
> AD7280A_CALC_TEMP_CHAN_NUM(d, c) (((d) *
> AD7280A_CELLS_PER_DEV) + \ + (c) - AD7280A_CELLS_PER_DEV)
> 
>  #define AD7280A_DEVADDR_MASTER 0 define
>  #AD7280A_DEVADDR_ALL 0x1F

I don't know how this diff got added to the commit message, but
obviously we don't want that.

regards,
dan carpenter

> ---
>  drivers/staging/iio/adc/ad7280a.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/ad7280a.c b/drivers/staging/iio/adc/ad7280a.c
> index d9df126..98cf876 100644
> --- a/drivers/staging/iio/adc/ad7280a.c
> +++ b/drivers/staging/iio/adc/ad7280a.c
> @@ -97,9 +97,9 @@
>  #define AD7280A_NUM_CH			(AD7280A_AUX_ADC_6 - \
>  					AD7280A_CELL_VOLTAGE_1 + 1)
>  
> -#define AD7280A_CALC_VOLTAGE_CHAN_NUM(d, c) ((d * AD7280A_CELLS_PER_DEV) + c)
> -#define AD7280A_CALC_TEMP_CHAN_NUM(d, c)    ((d * AD7280A_CELLS_PER_DEV) + \
> -					     c - AD7280A_CELLS_PER_DEV)
> +#define AD7280A_CALC_VOLTAGE_CHAN_NUM(d, c) (((d) * AD7280A_CELLS_PER_DEV) + (c))
> +#define AD7280A_CALC_TEMP_CHAN_NUM(d, c)    (((d) * AD7280A_CELLS_PER_DEV) + \
> +					     (c) - AD7280A_CELLS_PER_DEV)
>  
>  #define AD7280A_DEVADDR_MASTER		0
>  #define AD7280A_DEVADDR_ALL		0x1F
> -- 
> 2.7.4
> 
> _______________________________________________
> devel mailing list
> devel@linuxdriverproject.org
> http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
