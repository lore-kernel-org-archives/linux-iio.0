Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:47357 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752073AbcFZPAs (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 26 Jun 2016 11:00:48 -0400
Subject: Re: [RESEND PATCH v2 2/2] staging: iio: accel: add error check
To: Luis de Bethencourt <luisbg@osg.samsung.com>,
	linux-kernel@vger.kernel.org
References: <1466624611-4494-1-git-send-email-luisbg@osg.samsung.com>
 <1466624611-4494-2-git-send-email-luisbg@osg.samsung.com>
Cc: gregkh@linuxfoundation.org, knaack.h@gmx.de, lars@metafoo.de,
	pmeerw@pmeerw.net, ciorneiioana@gmail.com, afd@ti.com,
	janani.rvchndrn@gmail.com, linux-iio@vger.kernel.org,
	devel@driverdev.osuosl.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <f6d84119-9aa3-d9e6-2933-da8f47638b52@kernel.org>
Date: Sun, 26 Jun 2016 16:00:46 +0100
MIME-Version: 1.0
In-Reply-To: <1466624611-4494-2-git-send-email-luisbg@osg.samsung.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 22/06/16 20:43, Luis de Bethencourt wrote:
> Go to error_ret if sca3000_read_ctrl_reg() failed.
> 
> Signed-off-by: Luis de Bethencourt <luisbg@osg.samsung.com>
Applied to the togreg branch of iio.git - will be initially
pushed out as testing for the autobuilders to play with it.

Thanks,

Jonathan
> ---
>  drivers/staging/iio/accel/sca3000_core.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/staging/iio/accel/sca3000_core.c b/drivers/staging/iio/accel/sca3000_core.c
> index ec12181..b3f6dbf 100644
> --- a/drivers/staging/iio/accel/sca3000_core.c
> +++ b/drivers/staging/iio/accel/sca3000_core.c
> @@ -1046,6 +1046,8 @@ static int sca3000_clean_setup(struct sca3000_state *st)
>  
>  	/* Disable ring buffer */
>  	ret = sca3000_read_ctrl_reg(st, SCA3000_REG_CTRL_SEL_OUT_CTRL);
> +	if (ret < 0)
> +		goto error_ret;
>  	ret = sca3000_write_ctrl_reg(st, SCA3000_REG_CTRL_SEL_OUT_CTRL,
>  				     (ret & SCA3000_OUT_CTRL_PROT_MASK)
>  				     | SCA3000_OUT_CTRL_BUF_X_EN
> 

