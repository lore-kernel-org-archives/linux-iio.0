Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:43498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726311AbeKRDRo (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 17 Nov 2018 22:17:44 -0500
Date: Sat, 17 Nov 2018 17:00:23 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Shreeya Patel <shreeya.patel23498@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, knaack.h@gmx.de,
        pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/7] Staging: iio: adt7316: Add an extra check for 'ret'
 equals to 0
Message-ID: <20181117170023.54892898@archlinux>
In-Reply-To: <20181116225132.24459-1-shreeya.patel23498@gmail.com>
References: <20181116225132.24459-1-shreeya.patel23498@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, 17 Nov 2018 04:21:32 +0530
Shreeya Patel <shreeya.patel23498@gmail.com> wrote:

> ret = 0 indicates a case of no error but no data read from
> the bus which is an invalid case. This case doesn't ever happen
> in reality. It should perhaps be handled for correctness though.
> 
> Signed-off-by: Shreeya Patel <shreeya.patel23498@gmail.com>
Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/staging/iio/addac/adt7316-i2c.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/staging/iio/addac/adt7316-i2c.c b/drivers/staging/iio/addac/adt7316-i2c.c
> index 856bcfa60c6c..473e5e34ec00 100644
> --- a/drivers/staging/iio/addac/adt7316-i2c.c
> +++ b/drivers/staging/iio/addac/adt7316-i2c.c
> @@ -30,6 +30,10 @@ static int adt7316_i2c_read(void *client, u8 reg, u8 *data)
>  	}
>  
>  	ret = i2c_smbus_read_byte(client);
> +
> +	if (!ret)
> +		return -EIO;
> +
>  	if (ret < 0) {
>  		dev_err(&cl->dev, "I2C read error\n");
>  		return ret;
