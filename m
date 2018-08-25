Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:39214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725815AbeHYMmr (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 25 Aug 2018 08:42:47 -0400
Date: Sat, 25 Aug 2018 10:04:23 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Marcus Folkesson <marcus.folkesson@gmail.com>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: dac: ti-dac5571: provide of_match_table to driver
Message-ID: <20180825100423.779386be@archlinux>
In-Reply-To: <20180824202459.21855-1-marcus.folkesson@gmail.com>
References: <20180824202459.21855-1-marcus.folkesson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, 24 Aug 2018 22:24:59 +0200
Marcus Folkesson <marcus.folkesson@gmail.com> wrote:

> Use the created list of of_device_id's as a match table.
> 
> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
Applied to the togreg branch of iio.git and pushed out as testing for the
autobuilders to play with it.

Technically this isn't a regression as it will fall back to the oldschool
i2c matching (which hasn't gone away yet).  Hence I don't plan to send it
as a fix during the cycle.

Jonathan

> ---
>  drivers/iio/dac/ti-dac5571.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iio/dac/ti-dac5571.c b/drivers/iio/dac/ti-dac5571.c
> index e39d1e901353..f6dcd8bce2b0 100644
> --- a/drivers/iio/dac/ti-dac5571.c
> +++ b/drivers/iio/dac/ti-dac5571.c
> @@ -421,6 +421,7 @@ MODULE_DEVICE_TABLE(i2c, dac5571_id);
>  static struct i2c_driver dac5571_driver = {
>  	.driver = {
>  		   .name = "ti-dac5571",
> +		   .of_match_table = of_match_ptr(dac5571_of_id),
>  	},
>  	.probe	  = dac5571_probe,
>  	.remove   = dac5571_remove,
