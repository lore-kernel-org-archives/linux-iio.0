Return-Path: <linux-iio-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0E70C6FD1C
	for <linux-iio@archiver.kernel.org>; Sun, 26 Mar 2023 15:10:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232440AbjCZPKr (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 26 Mar 2023 11:10:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232395AbjCZPKo (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 26 Mar 2023 11:10:44 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF11D5FC9
        for <linux-iio@vger.kernel.org>; Sun, 26 Mar 2023 08:10:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 5C4CFCE0EAF
        for <linux-iio@vger.kernel.org>; Sun, 26 Mar 2023 15:10:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7551CC433D2;
        Sun, 26 Mar 2023 15:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679843436;
        bh=IifahI5/uQWsiJGMfGiiC8fC5QDCIarshQbiaFhAnCM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=YyViMBpHFa1GEoIiZqGVDN3TiCiGx40CvChwXmVlCQMYeXgY9nvRgfTTdR+q9xgKx
         0yTB5WhCvIiM1OgUOU0+bw1ZaQvrXpeXasX1QvVOfY94/WZEUNyJ5h0eyajid8EAgz
         iZpOx7aVLjH9FdjkTaUXtC319CtHFPaT26VyxPY+jrl3pQMMza3np1GC+Lra5XKn4b
         rFwUwnAS/t1a3iMWh1FUOOllK1ToQZIMA4/0dDwZkEDi8E79ByGB5ZrccwfDuKYP1+
         e87U/N6QYWMpeqbEF0YbEcjUZjOs9OWa/b0jMCFsvRphT1gW99sOWx9Jr9Bb9T6eOG
         oI9uGd6RG3yLg==
Date:   Sun, 26 Mar 2023 16:25:39 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
        Cosmin Tanislav <cosmin.tanislav@analog.com>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: ad4310: Replace devm_clk_register() with
 devm_clk_hw_register()
Message-ID: <20230326162539.3e291184@jic23-huawei>
In-Reply-To: <20230326142046.422314-1-lars@metafoo.de>
References: <20230326142046.422314-1-lars@metafoo.de>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 26 Mar 2023 07:20:46 -0700
Lars-Peter Clausen <lars@metafoo.de> wrote:

> The devm_clk_register() is deprecated and devm_clk_hw_register() should be
> used as a replacement.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Applied

Thanks,

Jonathan

> ---
>  drivers/iio/adc/ad4130.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad4130.c b/drivers/iio/adc/ad4130.c
> index 38394341fd6e..f23b7808e996 100644
> --- a/drivers/iio/adc/ad4130.c
> +++ b/drivers/iio/adc/ad4130.c
> @@ -1823,7 +1823,7 @@ static int ad4130_setup_int_clk(struct ad4130_state *st)
>  	struct device_node *of_node = dev_of_node(dev);
>  	struct clk_init_data init;
>  	const char *clk_name;
> -	struct clk *clk;
> +	int ret;
>  
>  	if (st->int_pin_sel == AD4130_INT_PIN_CLK ||
>  	    st->mclk_sel != AD4130_MCLK_76_8KHZ)
> @@ -1839,11 +1839,12 @@ static int ad4130_setup_int_clk(struct ad4130_state *st)
>  	init.ops = &ad4130_int_clk_ops;
>  
>  	st->int_clk_hw.init = &init;
> -	clk = devm_clk_register(dev, &st->int_clk_hw);
> -	if (IS_ERR(clk))
> -		return PTR_ERR(clk);
> +	ret = devm_clk_hw_register(dev, &st->int_clk_hw);
> +	if (ret)
> +		return ret;
>  
> -	return of_clk_add_provider(of_node, of_clk_src_simple_get, clk);
> +	return of_clk_add_hw_provider(of_node, of_clk_hw_simple_get,
> +				      &st->int_clk_hw);
>  }
>  
>  static int ad4130_setup(struct iio_dev *indio_dev)

