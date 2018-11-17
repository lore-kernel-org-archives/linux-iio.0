Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:43178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726311AbeKRDQi (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 17 Nov 2018 22:16:38 -0500
Date: Sat, 17 Nov 2018 16:59:16 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Shreeya Patel <shreeya.patel23498@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, knaack.h@gmx.de,
        pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/7] Staging: iio: adt7316: Set the data field
Message-ID: <20181117165916.1ceac301@archlinux>
In-Reply-To: <20181116224907.24376-1-shreeya.patel23498@gmail.com>
References: <20181116224907.24376-1-shreeya.patel23498@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, 17 Nov 2018 04:19:07 +0530
Shreeya Patel <shreeya.patel23498@gmail.com> wrote:

> adt7316_i2c_read function nowhere sets the data field.
> It is necessary to have an appropriate value for it.
> Hence, assign the value stored in 'ret' variable to data field.
> 
> Signed-off-by: Shreeya Patel <shreeya.patel23498@gmail.com>
I have amended the description slightly to make it clear this
is a fix and that it has been broken so long we aren't that
bothered about it going into stable!

Applied to the togreg branch of iio.git and pushed out as
testing for the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/staging/iio/addac/adt7316-i2c.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/staging/iio/addac/adt7316-i2c.c b/drivers/staging/iio/addac/adt7316-i2c.c
> index f66dd3ebbab1..856bcfa60c6c 100644
> --- a/drivers/staging/iio/addac/adt7316-i2c.c
> +++ b/drivers/staging/iio/addac/adt7316-i2c.c
> @@ -35,6 +35,8 @@ static int adt7316_i2c_read(void *client, u8 reg, u8 *data)
>  		return ret;
>  	}
>  
> +	*data = ret;
> +
>  	return 0;
>  }
>  
