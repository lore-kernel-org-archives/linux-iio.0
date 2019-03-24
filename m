Return-Path: <SRS0=NPK8=R3=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 769B8C43381
	for <linux-iio@archiver.kernel.org>; Sun, 24 Mar 2019 16:11:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F91C213F2
	for <linux-iio@archiver.kernel.org>; Sun, 24 Mar 2019 16:11:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553443885;
	bh=bjXZRWpHs1UQTFeXCEc+0Z4sbd96bGuGGV8/6jLBr7w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=YZTkeeEKWbJYc65p+dRMwtcDucYcUhDZ1RtYFJ0rYJNRi24POK+tesvz3Y8KfxmkU
	 TVK1p8O2JqB2AxZ8a7uCv7Jx34MPTa5yl9e1PUAkhWfeOwqktDR/3DsWPMbO+1eNlM
	 1aUt47FMLfvWW8Fo/WxB6ph/KkfM3w5qQEIXsCls=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727960AbfCXQLY (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 24 Mar 2019 12:11:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:40832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726743AbfCXQLY (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 24 Mar 2019 12:11:24 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D8A442133F;
        Sun, 24 Mar 2019 16:11:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553443883;
        bh=bjXZRWpHs1UQTFeXCEc+0Z4sbd96bGuGGV8/6jLBr7w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=UvgPuLgxEYeAiFBdp3raNbUY8CiiVZ0J2oGbNuDj2pPbWk+cK6pXLJfkmtGft/Wv+
         +0JUSzlF6IXvtLIlP6eLYUuNnCLhXwVa9IyGycxIJFwoQHA6eiPmnr1K/bJlG9BXuZ
         +yaxQf4czwxbjXalpRXMH2okldXK54baueukW6Jg=
Date:   Sun, 24 Mar 2019 16:11:18 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Vladimir Petrigo <vladimir.petrigo@gmail.com>
Cc:     linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org
Subject: Re: [PATCH v2 2/2] staging: iio: ad7780: Add parentheses to macros
Message-ID: <20190324161118.6fc4614d@archlinux>
In-Reply-To: <1553202928-34824-3-git-send-email-vladimir.petrigo@gmail.com>
References: <1553202928-34824-1-git-send-email-vladimir.petrigo@gmail.com>
        <1553202928-34824-3-git-send-email-vladimir.petrigo@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 22 Mar 2019 00:15:28 +0300
Vladimir Petrigo <vladimir.petrigo@gmail.com> wrote:

> - Fix CHECK Macro argument 'wordsize' may be better as '(wordsize)' to avoid precedence issues
> 
> Signed-off-by: Vladimir Petrigo <vladimir.petrigo@gmail.com>

Hi Vladimir,

This particular driver has recently moved out of staging and gained support
for some additional parts.  Still the particular issue was there still.

I applied your patch by hand to the moved driver and the additional case
of the same thing that was write next to this.

Applied to the togreg branch of iio.git and pushed out as testing for the
autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/staging/iio/adc/ad7780.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/iio/adc/ad7780.c b/drivers/staging/iio/adc/ad7780.c
> index c4a8578..010fb47 100644
> --- a/drivers/staging/iio/adc/ad7780.c
> +++ b/drivers/staging/iio/adc/ad7780.c
> @@ -142,7 +142,7 @@ static const struct ad_sigma_delta_info ad7780_sigma_delta_info = {
>  };
>  
>  #define AD7780_CHANNEL(bits, wordsize) \
> -	AD_SD_CHANNEL_NO_SAMP_FREQ(1, 0, 0, bits, 32, wordsize - bits)
> +	AD_SD_CHANNEL_NO_SAMP_FREQ(1, 0, 0, bits, 32, (wordsize) - (bits))
>  
>  static const struct ad7780_chip_info ad7780_chip_info_tbl[] = {
>  	[ID_AD7170] = {

