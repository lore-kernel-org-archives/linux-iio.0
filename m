Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:57666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751028AbdFUT3u (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 21 Jun 2017 15:29:50 -0400
Date: Wed, 21 Jun 2017 20:29:43 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Akinobu Mita <akinobu.mita@gmail.com>
Cc: linux-iio@vger.kernel.org, Peter Meerwald <pmeerw@pmeerw.net>
Subject: Re: [PATCH 1/2] iio: light: tcs3472: fix ATIME register write
Message-ID: <20170621202943.214986fd@kernel.org>
In-Reply-To: <1497279909-11197-2-git-send-email-akinobu.mita@gmail.com>
References: <1497279909-11197-1-git-send-email-akinobu.mita@gmail.com>
        <1497279909-11197-2-git-send-email-akinobu.mita@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, 13 Jun 2017 00:05:08 +0900
Akinobu Mita <akinobu.mita@gmail.com> wrote:

> The integration time is controlled by the ATIME register only.  However,
> this register is written by i2c_smbus_write_word_data() in write_raw().
> 
> We actually don't need to write a subsequent register.  So just use
> i2c_smbus_write_byte_data() instead.
> 
> Cc: Peter Meerwald <pmeerw@pmeerw.net>
> Cc: Jonathan Cameron <jic23@kernel.org>
> Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
As I read the datasheet, this looks like it won't cause any actual
harm (where the top byte is written is unused).

Hence I'm going to apply this as part of the normal merge path
rather than as a fix as such.

Well worth cleaning up though!

Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan
> ---
>  drivers/iio/light/tcs3472.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/light/tcs3472.c b/drivers/iio/light/tcs3472.c
> index 3aa71e3..a9e153b 100644
> --- a/drivers/iio/light/tcs3472.c
> +++ b/drivers/iio/light/tcs3472.c
> @@ -169,7 +169,7 @@ static int tcs3472_write_raw(struct iio_dev *indio_dev,
>  		for (i = 0; i < 256; i++) {
>  			if (val2 == (256 - i) * 2400) {
>  				data->atime = i;
> -				return i2c_smbus_write_word_data(
> +				return i2c_smbus_write_byte_data(
>  					data->client, TCS3472_ATIME,
>  					data->atime);
>  			}

