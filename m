Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2E04C433C1
	for <linux-iio@archiver.kernel.org>; Sat, 20 Mar 2021 11:37:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 973896193E
	for <linux-iio@archiver.kernel.org>; Sat, 20 Mar 2021 11:37:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbhCTLgq (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 20 Mar 2021 07:36:46 -0400
Received: from smtprelay0014.hostedemail.com ([216.40.44.14]:41106 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229445AbhCTLgT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 20 Mar 2021 07:36:19 -0400
X-Greylist: delayed 900 seconds by postgrey-1.27 at vger.kernel.org; Sat, 20 Mar 2021 07:36:19 EDT
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave04.hostedemail.com (Postfix) with ESMTP id 646C71802EC79
        for <linux-iio@vger.kernel.org>; Sat, 20 Mar 2021 11:06:53 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 2E5C71801FC5B;
        Sat, 20 Mar 2021 11:01:53 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: stove97_440bd9227757
X-Filterd-Recvd-Size: 2673
Received: from [192.168.1.159] (unknown [47.151.137.21])
        (Authenticated sender: joe@perches.com)
        by omf01.hostedemail.com (Postfix) with ESMTPA;
        Sat, 20 Mar 2021 11:01:52 +0000 (UTC)
Message-ID: <733be1879f059f87fc03df79b33cf5560f3dfcaf.camel@perches.com>
Subject: Re: [PATCH 4/4] iio: dac: Convert powerdown read callbacks to
 sysfs_emit()
From:   Joe Perches <joe@perches.com>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org
Date:   Sat, 20 Mar 2021 04:01:50 -0700
In-Reply-To: <20210320071405.9347-5-lars@metafoo.de>
References: <20210320071405.9347-1-lars@metafoo.de>
         <20210320071405.9347-5-lars@metafoo.de>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 2021-03-20 at 08:14 +0100, Lars-Peter Clausen wrote:
> Update DAC drivers powerdown attribute show callback to use the new
> sysfs_emit() function.
> 
> sysfs_emit() is preferred over raw s*printf() for sysfs attributes since it
> knows about the sysfs buffer specifics and has some built-in sanity checks.

Thanks.

unrelated trivia:

> diff --git a/drivers/iio/dac/ad5360.c b/drivers/iio/dac/ad5360.c
[]
> @@ -255,7 +255,7 @@ static ssize_t ad5360_read_dac_powerdown(struct device *dev,
>  	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>  	struct ad5360_state *st = iio_priv(indio_dev);
>  
> -	return sprintf(buf, "%d\n", (bool)(st->ctrl & AD5360_SF_CTRL_PWR_DOWN));
> +	return sysfs_emit(buf, "%d\n", (bool)(st->ctrl & AD5360_SF_CTRL_PWR_DOWN));

rather than cast to bool, perhaps standardize to use !!(val & test)

> diff --git a/drivers/iio/dac/ad5624r_spi.c b/drivers/iio/dac/ad5624r_spi.c
[]
> @@ -117,8 +117,8 @@ static ssize_t ad5624r_read_dac_powerdown(struct iio_dev *indio_dev,
>  {
>  	struct ad5624r_state *st = iio_priv(indio_dev);
>  
> -	return sprintf(buf, "%d\n",
> -			!!(st->pwr_down_mask & (1 << chan->channel)));
> +	return sysfs_emit(buf, "%d\n",
> +			  !!(st->pwr_down_mask & (1 << chan->channel)));

like this and below...

> diff --git a/drivers/iio/dac/ad5686.c b/drivers/iio/dac/ad5686.c
[]
> @@ -57,7 +57,7 @@ static ssize_t ad5686_read_dac_powerdown(struct iio_dev *indio_dev,
>  {
>  	struct ad5686_state *st = iio_priv(indio_dev);
> 
> -	return sprintf(buf, "%d\n", !!(st->pwr_down_mask &
> +	return sysfs_emit(buf, "%d\n", !!(st->pwr_down_mask &
>  				       (0x3 << (chan->channel * 2))));
>  }

etc...

and it might be nicer to rewrap alignments like

	return sysfs_emit(buf, "%d\n",
			  !!(st->pwr_down_mask & (0x3 << (chan->channel * 2))));


