Return-Path: <SRS0=dRc7=6J=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40BE3C54FCB
	for <linux-iio@archiver.kernel.org>; Sat, 25 Apr 2020 16:41:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB642206B6
	for <linux-iio@archiver.kernel.org>; Sat, 25 Apr 2020 16:41:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587832893;
	bh=9JN7f1OZn5WLyo7soH79zcym8sqdntW8g1JsFCt2Vo0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=KgG3gG38X/isd1XDHM2aQ1E3slrBy5bk3V1T+8R2l1E1goCIbBAJLaJH3B9JIBP5s
	 VyZYVPSImZYCSUX9DbClW4GOjixDY+YAP4tnMBJGPR3/kgBc3JZ0UQnjApbLMUDm8u
	 LQO/CWqRg0NK7lOHVPSqqu1KkdaeuiUJTUFd5SHE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726126AbgDYQlc (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 25 Apr 2020 12:41:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:60360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726076AbgDYQlc (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 25 Apr 2020 12:41:32 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 59E4A206A2;
        Sat, 25 Apr 2020 16:41:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587832892;
        bh=9JN7f1OZn5WLyo7soH79zcym8sqdntW8g1JsFCt2Vo0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=KFGnBPGAHyrT9+UB49CgdjH3kqG+EbhXrb+8R0Z6wTNrdvp25rdcYfKNG/O19f9Eq
         MeqwvdD32IqZGx2e7pQvi6ajZBLg+fXvkKTKSdZFoWI1xpSiitopImPWAhynfQffYW
         U+F7JamLsEWgESosAwF1Wj1HENzvSorArBWEocDM=
Date:   Sat, 25 Apr 2020 17:41:28 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH v1 08/16] iio: health: afe4403: Use get_unaligned_be24()
Message-ID: <20200425174128.1eda1654@archlinux>
In-Reply-To: <20200421003135.23060-8-andriy.shevchenko@linux.intel.com>
References: <20200421003135.23060-1-andriy.shevchenko@linux.intel.com>
        <20200421003135.23060-8-andriy.shevchenko@linux.intel.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 21 Apr 2020 03:31:27 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> This makes the driver code slightly easier to read.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Applied with header include added.

J
> ---
>  drivers/iio/health/afe4403.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iio/health/afe4403.c b/drivers/iio/health/afe4403.c
> index dc22dc363a99..db44b53e9330 100644
> --- a/drivers/iio/health/afe4403.c
> +++ b/drivers/iio/health/afe4403.c
> @@ -220,13 +220,11 @@ static int afe4403_read(struct afe4403_data *afe, unsigned int reg, u32 *val)
>  	if (ret)
>  		return ret;
>  
> -	ret = spi_write_then_read(afe->spi, &reg, 1, rx, 3);
> +	ret = spi_write_then_read(afe->spi, &reg, 1, rx, sizeof(rx));
>  	if (ret)
>  		return ret;
>  
> -	*val = (rx[0] << 16) |
> -		(rx[1] << 8) |
> -		(rx[2]);
> +	*val = get_unaligned_be24(&rx[0]);
>  
>  	/* Disable reading from the device */
>  	tx[3] = AFE440X_CONTROL0_WRITE;
> @@ -322,13 +320,11 @@ static irqreturn_t afe4403_trigger_handler(int irq, void *private)
>  			 indio_dev->masklength) {
>  		ret = spi_write_then_read(afe->spi,
>  					  &afe4403_channel_values[bit], 1,
> -					  rx, 3);
> +					  rx, sizeof(rx));
>  		if (ret)
>  			goto err;
>  
> -		buffer[i++] = (rx[0] << 16) |
> -				(rx[1] << 8) |
> -				(rx[2]);
> +		buffer[i++] = get_unaligned_be24(&rx[0]);
>  	}
>  
>  	/* Disable reading from the device */

