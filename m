Return-Path: <SRS0=+BiV=RV=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1322BC43381
	for <linux-iio@archiver.kernel.org>; Mon, 18 Mar 2019 02:34:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAD9A20872
	for <linux-iio@archiver.kernel.org>; Mon, 18 Mar 2019 02:34:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726972AbfCRCeo (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 17 Mar 2019 22:34:44 -0400
Received: from anchovy3.45ru.net.au ([203.30.46.155]:33969 "EHLO
        anchovy3.45ru.net.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727201AbfCRCeo (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 17 Mar 2019 22:34:44 -0400
X-Greylist: delayed 399 seconds by postgrey-1.27 at vger.kernel.org; Sun, 17 Mar 2019 22:34:43 EDT
Received: (qmail 11426 invoked by uid 5089); 18 Mar 2019 02:28:02 -0000
Received: by simscan 1.2.0 ppid: 11296, pid: 11297, t: 0.0392s
         scanners: regex: 1.2.0 attach: 1.2.0 clamav: 0.88.3/m:40/d:1950
Received: from unknown (HELO ?192.168.0.122?) (preid@electromag.com.au@203.59.235.95)
  by anchovy2.45ru.net.au with ESMTPA; 18 Mar 2019 02:28:02 -0000
Subject: Re: [PATCH 1/3] staging: iio: ad7192: Fix style issue
To:     Vladimir Petrigo <vladimir.petrigo@gmail.com>,
        linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stefan Popa <stefan.popa@analog.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Slawomir Stepien <sst@poczta.fm>,
        Nishad Kamdar <nishadkamdar@gmail.com>,
        Renato Lui Geh <renatogeh@gmail.com>,
        devel@driverdev.osuosl.org
References: <1552855992-27653-1-git-send-email-vladimir.petrigo@gmail.com>
 <1552855992-27653-2-git-send-email-vladimir.petrigo@gmail.com>
From:   Phil Reid <preid@electromag.com.au>
Message-ID: <b486e164-7231-728e-6788-c787ed96bb57@electromag.com.au>
Date:   Mon, 18 Mar 2019 10:27:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <1552855992-27653-2-git-send-email-vladimir.petrigo@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-AU
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 18/03/2019 4:53 am, Vladimir Petrigo wrote:
> Signed-off-by: Vladimir Petrigo <vladimir.petrigo@gmail.com>
> ---
>   drivers/staging/iio/adc/ad7192.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/iio/adc/ad7192.c b/drivers/staging/iio/adc/ad7192.c
> index acdbc07..7c632cf 100644
> --- a/drivers/staging/iio/adc/ad7192.c
> +++ b/drivers/staging/iio/adc/ad7192.c
> @@ -355,7 +355,7 @@ ad7192_show_scale_available(struct device *dev,
>   }
>   
>   static IIO_DEVICE_ATTR_NAMED(in_v_m_v_scale_available,
> -			     in_voltage-voltage_scale_available,
> +			     in_voltage - voltage_scale_available,
>   			     0444, ad7192_show_scale_available, NULL, 0);
>   
>   static IIO_DEVICE_ATTR(in_voltage_scale_available, 0444,
> 
G'day Vladimir ,

This is not a mathematical op.
It gets passed to __ATTR() macro and converted to a string.


-- 
Regards
Phil
