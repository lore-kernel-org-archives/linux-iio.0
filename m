Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:47332 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752238AbcFZO6s (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 26 Jun 2016 10:58:48 -0400
Subject: Re: [RESEND PATCH v2 1/2] staging: iio: accel: fix error check
To: Luis de Bethencourt <luisbg@osg.samsung.com>,
	linux-kernel@vger.kernel.org
References: <1466624611-4494-1-git-send-email-luisbg@osg.samsung.com>
Cc: gregkh@linuxfoundation.org, knaack.h@gmx.de, lars@metafoo.de,
	pmeerw@pmeerw.net, ciorneiioana@gmail.com, afd@ti.com,
	janani.rvchndrn@gmail.com, linux-iio@vger.kernel.org,
	devel@driverdev.osuosl.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <92672797-02a4-472a-241f-b3d437cc97f1@kernel.org>
Date: Sun, 26 Jun 2016 15:58:45 +0100
MIME-Version: 1.0
In-Reply-To: <1466624611-4494-1-git-send-email-luisbg@osg.samsung.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 22/06/16 20:43, Luis de Bethencourt wrote:
> sca3000_read_ctrl_reg() returns a negative number on failure, check for
> this instead of zero.
> 
> Signed-off-by: Luis de Bethencourt <luisbg@osg.samsung.com>
> Reviewed-by: Andrew F. Davis <afd@ti.com>
> Reviewed-by: Jonathan Cameron <jic23@kernel.org>

Note that, like any tag, reviewed-by tags must be provided by the person
who did the review.  It's nice to acknowledge reviewers, but there is
a certain "I'm happy with the result of my review" that is associated
with a reviewed-by tag.

Marked for stable and applied to the fixes-togreg branch of iio.git

Thanks,

Jonathan

> ---
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

