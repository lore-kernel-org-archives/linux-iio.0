Return-Path: <SRS0=iua/=RX=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C98CC43381
	for <linux-iio@archiver.kernel.org>; Wed, 20 Mar 2019 07:43:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6941A2146E
	for <linux-iio@archiver.kernel.org>; Wed, 20 Mar 2019 07:43:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="S6gbB+Ne"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbfCTHnE (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Wed, 20 Mar 2019 03:43:04 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:49506 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726303AbfCTHnD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 20 Mar 2019 03:43:03 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x2K7dTQa111187;
        Wed, 20 Mar 2019 07:42:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=ioBlqRWDKJIvY+NVYukHn0j7IxGrvjMjkLrRUqvwhGQ=;
 b=S6gbB+NeVrFMSHiok13OTmFFFg+MgDQWCftp9c2Fd53QWiVxR07KkrtzKXDi8+7pMdI6
 pADi/8c4zaSQlbPXml0wKXJnf7C9/tHUGjH5+P4wck+pbBUILC3NkbB+p7bBlhuq0thw
 xcSsaqHrU+jny2/wqtcDYQpC5+MLJm8FGTxWfaQuCXjsvi9YIs+nRxcEbMl2d0L2pHDA
 v6TZV5NIQwdlJEJ07oMj7zEKAgTjxNQLx8DUg1Znk6XLeqFS29/9cxp6C0WD1gj2H/65
 OE8KMzK/v3A0kXjPFM7AJyT9jqSPWQmT/zEjeIv7yUh0TVlPUZKlOVUWozNPlU/yXnNB 0w== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2130.oracle.com with ESMTP id 2r8pnes982-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Mar 2019 07:42:30 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x2K7gO8s016429
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Mar 2019 07:42:24 GMT
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x2K7gNir009964;
        Wed, 20 Mar 2019 07:42:23 GMT
Received: from kadam (/10.175.25.169)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 20 Mar 2019 00:42:22 -0700
Date:   Wed, 20 Mar 2019 10:42:17 +0300
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
Subject: Re: [PATCH 3/3] staging: iio: ad7780: Add parentheses to macros
Message-ID: <20190320074217.GE2202@kadam>
References: <1552855992-27653-1-git-send-email-vladimir.petrigo@gmail.com>
 <1552855992-27653-4-git-send-email-vladimir.petrigo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1552855992-27653-4-git-send-email-vladimir.petrigo@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9200 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903200065
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Mar 17, 2019 at 11:53:12PM +0300, Vladimir Petrigo wrote:
> - Fix CHECK Macro argument 'wordsize' may be better as '(wordsize)' to avoid precedence issues
> - Fix CHECK Macro argument reuse 'bits' - possible side-effects?
> 
> Signed-off-by: Vladimir Petrigo <vladimir.petrigo@gmail.com>
> ---
>  drivers/staging/iio/adc/ad7780.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/iio/adc/ad7780.c b/drivers/staging/iio/adc/ad7780.c
> index c4a8578..2dfd6f8 100644
> --- a/drivers/staging/iio/adc/ad7780.c
> +++ b/drivers/staging/iio/adc/ad7780.c
> @@ -142,7 +142,7 @@ static const struct ad_sigma_delta_info ad7780_sigma_delta_info = {
>  };
>  
>  #define AD7780_CHANNEL(bits, wordsize) \
> -	AD_SD_CHANNEL_NO_SAMP_FREQ(1, 0, 0, bits, 32, wordsize - bits)
> +	AD_SD_CHANNEL_NO_SAMP_FREQ(1, 0, 0, (bits), 32, ((wordsize) - (bits)))
                                            ^^^^^^
These parentheses are not required.

This doesn't fix the "argument reuse" issue...  It's not a reall issue
though, and it isn't like this a core macro so it doesn't really matter
too much.

regards,
dan carpenter

