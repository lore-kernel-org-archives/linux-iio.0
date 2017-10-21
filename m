Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:39678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932179AbdJURpM (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 21 Oct 2017 13:45:12 -0400
Date: Sat, 21 Oct 2017 18:45:08 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Brian Masney <masneyb@onstation.org>
Cc: linux-iio@vger.kernel.org, gregkh@linuxfoundation.org,
        devel@driverdev.osuosl.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-kernel@vger.kernel.org,
        Jon.Brenner@ams.com
Subject: Re: [PATCH 12/13] staging: iio: tsl2x7x: put function definitions
 on a single line
Message-ID: <20171021184508.0fa4f3f6@archlinux>
In-Reply-To: <20171019200632.25820-13-masneyb@onstation.org>
References: <20171019200632.25820-1-masneyb@onstation.org>
        <20171019200632.25820-13-masneyb@onstation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, 19 Oct 2017 16:06:31 -0400
Brian Masney <masneyb@onstation.org> wrote:

> The functions tsl2x7x_invoke_change() and tsl2x7x_prox_calculate() are
> short enough that the return value and static declaration can be moved
> onto the same line with the function name. This patch makes that change
> to increase code readability.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
Applied.
> ---
>  drivers/staging/iio/light/tsl2x7x.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/staging/iio/light/tsl2x7x.c b/drivers/staging/iio/light/tsl2x7x.c
> index f12ab1239a46..42ed9c015aaf 100644
> --- a/drivers/staging/iio/light/tsl2x7x.c
> +++ b/drivers/staging/iio/light/tsl2x7x.c
> @@ -752,8 +752,7 @@ static int tsl2x7x_chip_off(struct iio_dev *indio_dev)
>   * put device back into proper state, and unlock
>   * resource.
>   */
> -static
> -int tsl2x7x_invoke_change(struct iio_dev *indio_dev)
> +static int tsl2x7x_invoke_change(struct iio_dev *indio_dev)
>  {
>  	struct tsl2X7X_chip *chip = iio_priv(indio_dev);
>  	int device_status = chip->tsl2x7x_chip_status;
> @@ -777,9 +776,8 @@ int tsl2x7x_invoke_change(struct iio_dev *indio_dev)
>  	return ret;
>  }
>  
> -static
> -void tsl2x7x_prox_calculate(int *data, int length,
> -			    struct tsl2x7x_prox_stat *statP)
> +static void tsl2x7x_prox_calculate(int *data, int length,
> +				   struct tsl2x7x_prox_stat *statP)
>  {
>  	int i;
>  	int sample_sum;

