Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:51502 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726001AbeHSTyD (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 19 Aug 2018 15:54:03 -0400
Date: Sun, 19 Aug 2018 17:41:55 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Marcus Folkesson <marcus.folkesson@gmail.com>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH] iio: dac: max5821: avoid using CONFIG_PM_SLEEP
Message-ID: <20180819174155.130eda69@archlinux>
In-Reply-To: <20180811084718.6697-1-marcus.folkesson@gmail.com>
References: <20180811084718.6697-1-marcus.folkesson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, 11 Aug 2018 10:47:18 +0200
Marcus Folkesson <marcus.folkesson@gmail.com> wrote:

> This is already handled by SIMPLE_DEV_PM_OPS().
> 
> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan

> ---
> Somehow git-send-email messed up (?!) the format for (at least) gmail, so resend it.
> Mutt still read the mail correct though.
> 
>  drivers/iio/dac/max5821.c | 11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iio/dac/max5821.c b/drivers/iio/dac/max5821.c
> index d0ecc1fdd8fc..f0cf6903dcd2 100644
> --- a/drivers/iio/dac/max5821.c
> +++ b/drivers/iio/dac/max5821.c
> @@ -270,8 +270,7 @@ static int max5821_write_raw(struct iio_dev *indio_dev,
>  	}
>  }
>  
> -#ifdef CONFIG_PM_SLEEP
> -static int max5821_suspend(struct device *dev)
> +static int __maybe_unused max5821_suspend(struct device *dev)
>  {
>  	u8 outbuf[2] = { MAX5821_EXTENDED_COMMAND_MODE,
>  			 MAX5821_EXTENDED_DAC_A |
> @@ -281,7 +280,7 @@ static int max5821_suspend(struct device *dev)
>  	return i2c_master_send(to_i2c_client(dev), outbuf, 2);
>  }
>  
> -static int max5821_resume(struct device *dev)
> +static int __maybe_unused max5821_resume(struct device *dev)
>  {
>  	u8 outbuf[2] = { MAX5821_EXTENDED_COMMAND_MODE,
>  			 MAX5821_EXTENDED_DAC_A |
> @@ -292,10 +291,6 @@ static int max5821_resume(struct device *dev)
>  }
>  
>  static SIMPLE_DEV_PM_OPS(max5821_pm_ops, max5821_suspend, max5821_resume);
> -#define MAX5821_PM_OPS (&max5821_pm_ops)
> -#else
> -#define MAX5821_PM_OPS NULL
> -#endif /* CONFIG_PM_SLEEP */
>  
>  static const struct iio_info max5821_info = {
>  	.read_raw = max5821_read_raw,
> @@ -392,7 +387,7 @@ static struct i2c_driver max5821_driver = {
>  	.driver = {
>  		.name	= "max5821",
>  		.of_match_table = max5821_of_match,
> -		.pm     = MAX5821_PM_OPS,
> +		.pm     = &max5821_pm_ops,
>  	},
>  	.probe		= max5821_probe,
>  	.remove		= max5821_remove,
