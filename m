Return-Path: <SRS0=8Qe3=XK=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56E6DC4CEC7
	for <linux-iio@archiver.kernel.org>; Sun, 15 Sep 2019 13:33:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F06F214DA
	for <linux-iio@archiver.kernel.org>; Sun, 15 Sep 2019 13:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568554424;
	bh=xDjZbTR43qjyChUY94InVKK0+hV7aPQ9u9XH0c6wwnw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=zuPtanFDPEHzRIwwBjI13l/zrP+Y9DJTbOVydUt6l6S3dUkzo4kixYA7kzZr7Yt1I
	 CyllM6pkKpJTvDU4FEnLzCyPRxyQxWSXEkMq3Baw3t9u3TidmH6PdJfhBLy3L1RcI6
	 q6V86Ix1nMR255XSzOcOuXFEUFK6sCAse70EZI88=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730917AbfIONdn (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 15 Sep 2019 09:33:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:56158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730908AbfIONdn (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 15 Sep 2019 09:33:43 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4EECF214AF;
        Sun, 15 Sep 2019 13:33:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568554422;
        bh=xDjZbTR43qjyChUY94InVKK0+hV7aPQ9u9XH0c6wwnw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GQQ2P6vBNrxen7mnOvqv58YXPLtQs4M2WcX/VhCi4ZCPYbrLgFokTOb1j6Nqf8qSA
         u01jbX/IqL2QfOyrH7HUFDzIgCtspqad/4hwlcc3eKhIHBD3H7Di0XZfUek1gu44jB
         iZ0+eqpvzGzVnx1ZmmlhCRECgBgBmvyky/NfYf04=
Date:   Sun, 15 Sep 2019 14:33:38 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Stefan Popa <stefan.popa@analog.com>
Cc:     <Michael.Hennerich@analog.com>, <knaack.h@gmx.de>,
        <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v2 3/3] iio: accel: adxl372: Perform a reset at start up
Message-ID: <20190915143338.6a064789@archlinux>
In-Reply-To: <1568126686-13436-1-git-send-email-stefan.popa@analog.com>
References: <1568126686-13436-1-git-send-email-stefan.popa@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 10 Sep 2019 17:44:46 +0300
Stefan Popa <stefan.popa@analog.com> wrote:

> We need to perform a reset a start up to make sure that the chip is in a
> consistent state. This reset also disables all the interrupts which
> should only be enabled together with the iio buffer. Not doing this, was
> sometimes causing unwanted interrupts to trigger.
> 
> Signed-off-by: Stefan Popa <stefan.popa@analog.com>
Added the same fixes tag, and cc for stable. We'll have to keep an eye
on this though as there are other patches after the one hightlighted so
they may not go on cleanly.

Thanks,

Jonathan

> ---
> Changes in v2:
> 	- Instead of disabling the interrupts, now this patch performs
> 	  a software reset.
> 
>  drivers/iio/accel/adxl372.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/iio/accel/adxl372.c b/drivers/iio/accel/adxl372.c
> index 33edca8..8a00528 100644
> --- a/drivers/iio/accel/adxl372.c
> +++ b/drivers/iio/accel/adxl372.c
> @@ -575,6 +575,14 @@ static int adxl372_setup(struct adxl372_state *st)
>  		return -ENODEV;
>  	}
>  
> +	/*
> +	 * Perform a software reset to make sure the device is in a consistent
> +	 * state after start up.
> +	 */
> +	ret = regmap_write(st->regmap, ADXL372_RESET, ADXL372_RESET_CODE);
> +	if (ret < 0)
> +		return ret;
> +
>  	ret = adxl372_set_op_mode(st, ADXL372_STANDBY);
>  	if (ret < 0)
>  		return ret;

