Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:53404 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750779AbcEaVKQ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 31 May 2016 17:10:16 -0400
Message-ID: <574DFDB2.4070503@osg.samsung.com>
Date: Tue, 31 May 2016 22:10:10 +0100
From: Luis de Bethencourt <luisbg@osg.samsung.com>
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: gregkh@linuxfoundation.org, knaack.h@gmx.de, lars@metafoo.de,
	jic23@kernel.org, ciorneiioana@gmail.com,
	janani.rvchndrn@gmail.com, afd@ti.com, linux-iio@vger.kernel.org,
	devel@driverdev.osuosl.org
Subject: Re: [PATCH 1/2] staging: iio: accel: fix error check
References: <1464728884-29686-1-git-send-email-luisbg@osg.samsung.com>
In-Reply-To: <1464728884-29686-1-git-send-email-luisbg@osg.samsung.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 31/05/16 22:08, Luis de Bethencourt wrote:
> sca3000_read_ctrl_reg() returns a negative number on failure, check for
> this instead of zero.
> 
> Signed-off-by: Luis de Bethencourt <luisbg@osg.samsung.com>
> Reviewed-by: Andrew F. Davis <afd@ti.com>
> Reviewed-by: Jonathan Cameron <jic23@kernel.org>
> ---
> 
> Patch corrected thanks to comments from Andrew F. Davis and Jonathan Cameron.
> https://lkml.org/lkml/2016/5/31/862
> 
> Thanks,
> Luis
> 
>  drivers/staging/iio/accel/sca3000_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/iio/accel/sca3000_core.c b/drivers/staging/iio/accel/sca3000_core.c
> index a8f533a..ec12181 100644
> --- a/drivers/staging/iio/accel/sca3000_core.c
> +++ b/drivers/staging/iio/accel/sca3000_core.c
> @@ -594,7 +594,7 @@ static ssize_t sca3000_read_frequency(struct device *dev,
>  		goto error_ret_mut;
>  	ret = sca3000_read_ctrl_reg(st, SCA3000_REG_CTRL_SEL_OUT_CTRL);
>  	mutex_unlock(&st->lock);
> -	if (ret)
> +	if (ret < 0)
>  		goto error_ret;
>  	val = ret;
>  	if (base_freq > 0)
> 

I sent this with git send-email using --subject-prefix="PATCH v2", no idea why the version wasn't
added.

Apologies,
Luis
