Return-Path: <SRS0=h9gr=Z5=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6E4AC43603
	for <linux-iio@archiver.kernel.org>; Sat,  7 Dec 2019 09:41:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FF30227BF
	for <linux-iio@archiver.kernel.org>; Sat,  7 Dec 2019 09:41:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575711672;
	bh=PVgg6GS/wTv+h1ke3Hn4S0SRBFIdDH/UUfEzuwXAkSg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=p00aunv6Pc7diw09tZRiLcWcZ6XA6CiQi7o5xL9CRzAPkW1fiz2z9pI761gsmMuIi
	 EsavShrxKkC51S87eQq6LG5OS8q3rqv0rOWemCy/rz3fsoz7EvT+Mf+e47Gfqscm+H
	 fNW0zTgXtdGF2rgErQhKegzIWFZ8E5PpO2k+5uTg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726025AbfLGJlL (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 7 Dec 2019 04:41:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:53144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725992AbfLGJlL (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 7 Dec 2019 04:41:11 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 343262173E;
        Sat,  7 Dec 2019 09:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575711671;
        bh=PVgg6GS/wTv+h1ke3Hn4S0SRBFIdDH/UUfEzuwXAkSg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GnFLj1s47lklMQFMw59GoYa2oZO2SRhdUyVF9l8IQ8iitDrP5uy3ehrV3mcXn5253
         RUySRmRrW3aFU9LDeXCSHHmiTL5PZEgQMknnVC2eLhZspwGRy4Y2BSu4Znf2Ncr1k9
         BR2PuFCSpWZ2PVGdI1sNrg5x77r6E6kjF8DGIwHU=
Date:   Sat, 7 Dec 2019 09:41:06 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: Re: [PATCH] iio: apds9960: Drop GPIO includes
Message-ID: <20191207094106.4e9d0c15@archlinux>
In-Reply-To: <20191202082452.62989-1-linus.walleij@linaro.org>
References: <20191202082452.62989-1-linus.walleij@linaro.org>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon,  2 Dec 2019 09:24:52 +0100
Linus Walleij <linus.walleij@linaro.org> wrote:

> The driver includes <linux/gpio.h> and <linux/of_gpio.h> yet
> fails to use symbols from any of the include files, so drop
> these includes.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Applied,

Thanks,

Jonathan

> ---
>  drivers/iio/light/apds9960.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/iio/light/apds9960.c b/drivers/iio/light/apds9960.c
> index c5dfb9a6b5a1..52f86bc777dd 100644
> --- a/drivers/iio/light/apds9960.c
> +++ b/drivers/iio/light/apds9960.c
> @@ -15,7 +15,6 @@
>  #include <linux/mutex.h>
>  #include <linux/err.h>
>  #include <linux/irq.h>
> -#include <linux/gpio.h>
>  #include <linux/i2c.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/regmap.h>
> @@ -24,7 +23,6 @@
>  #include <linux/iio/events.h>
>  #include <linux/iio/kfifo_buf.h>
>  #include <linux/iio/sysfs.h>
> -#include <linux/of_gpio.h>
>  
>  #define APDS9960_REGMAP_NAME	"apds9960_regmap"
>  #define APDS9960_DRV_NAME	"apds9960"

