Return-Path: <linux-iio-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4528C77B73
	for <linux-iio@archiver.kernel.org>; Sat,  3 Jun 2023 12:09:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231298AbjFCMJW (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 3 Jun 2023 08:09:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbjFCMJV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 3 Jun 2023 08:09:21 -0400
Received: from fgw20-7.mail.saunalahti.fi (fgw20-7.mail.saunalahti.fi [62.142.5.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6C38CE
        for <linux-iio@vger.kernel.org>; Sat,  3 Jun 2023 05:09:20 -0700 (PDT)
Received: from localhost (88-113-26-95.elisa-laajakaista.fi [88.113.26.95])
        by fgw20.mail.saunalahti.fi (Halon) with ESMTP
        id 773e062a-0207-11ee-b3cf-005056bd6ce9;
        Sat, 03 Jun 2023 15:09:18 +0300 (EEST)
From:   andy.shevchenko@gmail.com
Date:   Sat, 3 Jun 2023 15:09:18 +0300
To:     Astrid Rost <astrid.rost@axis.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@axis.com,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Mathieu Othacehe <m.othacehe@gmail.com>
Subject: Re: [PATCH v5 2/7] iio: light: vcnl4000: Add proximity ps_it for
 vcnl4200
Message-ID: <ZHstbg71QRzkC-Ar@surfacebook>
References: <20230530142405.1679146-1-astrid.rost@axis.com>
 <20230530142405.1679146-3-astrid.rost@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230530142405.1679146-3-astrid.rost@axis.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Tue, May 30, 2023 at 04:24:00PM +0200, Astrid Rost kirjoitti:
> Add ps_it attributes for vcnl4200 (similar to vcnl4040).
> Add read/write attribute for proximity integration time.
> Read attribute for available proximity integration times.
> Change sampling rate depending on integration time.

...

>  	irqreturn_t (*irq_thread)(int irq, void *priv);
>  	irqreturn_t (*trig_buffer_func)(int irq, void *priv);
>  	u8 int_reg;

+ Blank line?

> +	const int(*ps_it_times)[][2];
> +	const int num_ps_it_times;


-- 
With Best Regards,
Andy Shevchenko


