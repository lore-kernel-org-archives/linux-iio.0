Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:60106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932315AbdJZQXu (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 26 Oct 2017 12:23:50 -0400
Date: Thu, 26 Oct 2017 17:23:45 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: linux-iio@vger.kernel.org,
        Crestez Dan Leonard <leonard.crestez@intel.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] iio/pressure/hp206c: Use common error handling code in
 hp206c_conv_and_read()
Message-ID: <20171026172345.5a88cd73@archlinux>
In-Reply-To: <bbe04556-c62c-6074-d663-884a702614f4@users.sourceforge.net>
References: <bbe04556-c62c-6074-d663-884a702614f4@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, 26 Oct 2017 15:45:43 +0200
SF Markus Elfring <elfring@users.sourceforge.net> wrote:

> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Thu, 26 Oct 2017 15:34:46 +0200
> 
> Add a jump target so that a specific error message is stored only once
> at the end of this function implementation.
> Replace two calls of the function "dev_err" by goto statements.
> 
> This issue was detected by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

The advantages of this are very limited. Hence I am not going to
apply it.

There would be some argument (perhaps) for moving the error message
into the function being called but that would then make the driver
inconsistent on where it reports errors reducing overall readability.

Jonathan

> ---
>  drivers/iio/pressure/hp206c.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iio/pressure/hp206c.c b/drivers/iio/pressure/hp206c.c
> index c38c19678cf6..978338f2a6e5 100644
> --- a/drivers/iio/pressure/hp206c.c
> +++ b/drivers/iio/pressure/hp206c.c
> @@ -176,10 +176,8 @@ static int hp206c_conv_and_read(struct iio_dev *indio_dev,
>  	struct i2c_client *client = data->client;
>  
>  	ret = hp206c_wait_dev_rdy(indio_dev);
> -	if (ret < 0) {
> -		dev_err(&indio_dev->dev, "Device not ready: %d\n", ret);
> -		return ret;
> -	}
> +	if (ret < 0)
> +		goto report_failure;
>  
>  	ret = i2c_smbus_write_byte(client, conv_cmd);
>  	if (ret < 0) {
> @@ -190,16 +188,18 @@ static int hp206c_conv_and_read(struct iio_dev *indio_dev,
>  	usleep_range(sleep_us, sleep_us * 3 / 2);
>  
>  	ret = hp206c_wait_dev_rdy(indio_dev);
> -	if (ret < 0) {
> -		dev_err(&indio_dev->dev, "Device not ready: %d\n", ret);
> -		return ret;
> -	}
> +	if (ret < 0)
> +		goto report_failure;
>  
>  	ret = hp206c_read_20bit(client, read_cmd);
>  	if (ret < 0)
>  		dev_err(&indio_dev->dev, "Failed read: %d\n", ret);
>  
>  	return ret;
> +
> +report_failure:
> +	dev_err(&indio_dev->dev, "Device not ready: %d\n", ret);
> +	return ret;
>  }
>  
>  static int hp206c_read_raw(struct iio_dev *indio_dev,

