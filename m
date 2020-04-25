Return-Path: <SRS0=dRc7=6J=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B460C54FCB
	for <linux-iio@archiver.kernel.org>; Sat, 25 Apr 2020 16:42:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A01220714
	for <linux-iio@archiver.kernel.org>; Sat, 25 Apr 2020 16:42:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587832942;
	bh=Ny09nxm9CsLF/eMk/3GcZuMEEgXfBJh5XDSrD37FYL4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=DewHjm4o/tIWzkuAdT89dsNCQD6rT/xq9qheYJsUTZrYHKSyKfL0Sk34e8A0FB29s
	 z7wMbM5S1ZHV4SAyMxGmPOAtAnQMr2MQhJI23V6gwKzbvydrKHSy7ty8mVAHt4Go3/
	 uFiRuqIVCAy5lZ3QTKCba8u7zrUo5VlkBjWsNTBI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726147AbgDYQmW (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 25 Apr 2020 12:42:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:60822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726076AbgDYQmV (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 25 Apr 2020 12:42:21 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D2A7E206A2;
        Sat, 25 Apr 2020 16:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587832941;
        bh=Ny09nxm9CsLF/eMk/3GcZuMEEgXfBJh5XDSrD37FYL4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=PBGRAKirEMFWWrXeZjVBp2wKsSAgJxANreAGZtH5e+KY5PLL2MhCgSKwfgn+iTSf/
         Hhvy1twGOW6866nNoqu+a8sUrp6aepHX1Y8y1ty3OYJG1JKmjJimMM8T8KM+CSfRdR
         Ooe03m8OytrgMb+VPLkWzFI9XvYfaUdlIJ9S0iw8=
Date:   Sat, 25 Apr 2020 17:42:17 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH v1 10/16] iio: light: zopt2201: Use get_unaligned_le24()
Message-ID: <20200425174217.03fcbc11@archlinux>
In-Reply-To: <20200421003135.23060-10-andriy.shevchenko@linux.intel.com>
References: <20200421003135.23060-1-andriy.shevchenko@linux.intel.com>
        <20200421003135.23060-10-andriy.shevchenko@linux.intel.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 21 Apr 2020 03:31:29 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> This makes the driver code slightly easier to read.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Applied with asm/unaligned.h include added.

J
> ---
>  drivers/iio/light/zopt2201.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/light/zopt2201.c b/drivers/iio/light/zopt2201.c
> index 5f54f39e7a4c..0df45b42c091 100644
> --- a/drivers/iio/light/zopt2201.c
> +++ b/drivers/iio/light/zopt2201.c
> @@ -219,7 +219,7 @@ static int zopt2201_read(struct zopt2201_data *data, u8 reg)
>  		goto fail;
>  	mutex_unlock(&data->lock);
>  
> -	return (buf[2] << 16) | (buf[1] << 8) | buf[0];
> +	return get_unaligned_le24(&buf[0]);
>  
>  fail:
>  	mutex_unlock(&data->lock);

