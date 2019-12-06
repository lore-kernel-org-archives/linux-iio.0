Return-Path: <SRS0=Jt3Z=Z4=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E9FCC43603
	for <linux-iio@archiver.kernel.org>; Fri,  6 Dec 2019 17:46:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0954A24673
	for <linux-iio@archiver.kernel.org>; Fri,  6 Dec 2019 17:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575654414;
	bh=AWvBmXEb/1CdPbn3BpTF6ilLDCmEDOHfqgnpuyJYXUQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=wtggeiuGBtPEtdVfEkvseybFPH/4tWE+pqIklI2LAe8KKa+SlDMhGwCG9bpZHOLi+
	 LJG/ECVgS8+n1Rze27tdi3Tqyhs91QG/oLbdemC02DzYOP1FI1gag+NsKeHzbS4A3O
	 CWmKANmkKnYRd+yjO72oZkGIK1fYfFznzoKKO6Rw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726298AbfLFRqx (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Fri, 6 Dec 2019 12:46:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:37154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726287AbfLFRqx (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 6 Dec 2019 12:46:53 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EECB524670;
        Fri,  6 Dec 2019 17:46:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575654413;
        bh=AWvBmXEb/1CdPbn3BpTF6ilLDCmEDOHfqgnpuyJYXUQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=V8g7B+uGhX/xIRV69Br3VQUHbDeztvRqQbIcFc65Gp2lXC/N+25/eBMmQVZstNM0V
         HPyZkxUBqUn0R6ZQvNtDqfZ18m7FRJ6YM/QP2WXkB7HBtiEaxOncI4RWmqbV+nF/RC
         N607h8A9FOO4waEZDa81L1Kg5qzokS7nSKC/VvcA=
Date:   Fri, 6 Dec 2019 17:46:49 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: Re: [PATCH] iio: as3935: Drop GPIO includes
Message-ID: <20191206174649.55c0cac8@archlinux>
In-Reply-To: <20191202081943.62073-1-linus.walleij@linaro.org>
References: <20191202081943.62073-1-linus.walleij@linaro.org>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon,  2 Dec 2019 09:19:43 +0100
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
>  drivers/iio/proximity/as3935.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/iio/proximity/as3935.c b/drivers/iio/proximity/as3935.c
> index b591c63bd6c4..bac9a433dd19 100644
> --- a/drivers/iio/proximity/as3935.c
> +++ b/drivers/iio/proximity/as3935.c
> @@ -14,7 +14,6 @@
>  #include <linux/mutex.h>
>  #include <linux/err.h>
>  #include <linux/irq.h>
> -#include <linux/gpio.h>
>  #include <linux/spi/spi.h>
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
> @@ -22,8 +21,6 @@
>  #include <linux/iio/trigger_consumer.h>
>  #include <linux/iio/buffer.h>
>  #include <linux/iio/triggered_buffer.h>
> -#include <linux/of_gpio.h>
> -
>  
>  #define AS3935_AFE_GAIN		0x00
>  #define AS3935_AFE_MASK		0x3F

