Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:38458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751099AbdI3UB1 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 30 Sep 2017 16:01:27 -0400
Date: Sat, 30 Sep 2017 21:01:23 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: Re: [PATCH v3 2/8] iio: accel: kxcjk1013: fix INT_CTRL/INT_SRC1 bit
 names
Message-ID: <20170930210123.5804ac44@archlinux>
In-Reply-To: <e42aecf940e2f5acb5ed98dc13ea28af9eb74f2f.1505660069.git.mirq-linux@rere.qmqm.pl>
References: <cover.1505660069.git.mirq-linux@rere.qmqm.pl>
        <e42aecf940e2f5acb5ed98dc13ea28af9eb74f2f.1505660069.git.mirq-linux@rere.qmqm.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, 17 Sep 2017 17:01:02 +0200
Michał Mirosław <mirq-linux@rere.qmqm.pl> wrote:

> Fix INT_CTRL1 bit names to match register name and add names
> for INT_SRC1 bits.
> 
> Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>

Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan
> ---
>  drivers/iio/accel/kxcjk-1013.c | 23 ++++++++++++++---------
>  1 file changed, 14 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
> index 33e4b98f39fc..7828570d87d2 100644
> --- a/drivers/iio/accel/kxcjk-1013.c
> +++ b/drivers/iio/accel/kxcjk-1013.c
> @@ -67,14 +67,19 @@
>  #define KXCJK1013_REG_CTRL1_BIT_GSEL1	BIT(4)
>  #define KXCJK1013_REG_CTRL1_BIT_GSEL0	BIT(3)
>  #define KXCJK1013_REG_CTRL1_BIT_WUFE	BIT(1)
> -#define KXCJK1013_REG_INT_REG1_BIT_IEA	BIT(4)
> -#define KXCJK1013_REG_INT_REG1_BIT_IEN	BIT(5)
> +
> +#define KXCJK1013_REG_INT_CTRL1_BIT_IEL	BIT(3)
> +#define KXCJK1013_REG_INT_CTRL1_BIT_IEA	BIT(4)
> +#define KXCJK1013_REG_INT_CTRL1_BIT_IEN	BIT(5)
>  
>  #define KXCJK1013_DATA_MASK_12_BIT	0x0FFF
>  #define KXCJK1013_MAX_STARTUP_TIME_US	100000
>  
>  #define KXCJK1013_SLEEP_DELAY_MS	2000
>  
> +#define KXCJK1013_REG_INT_SRC1_BIT_WUFS	BIT(1)
> +#define KXCJK1013_REG_INT_SRC1_BIT_DRDY	BIT(4)
> +
>  #define KXCJK1013_REG_INT_SRC2_BIT_ZP	BIT(0)
>  #define KXCJK1013_REG_INT_SRC2_BIT_ZN	BIT(1)
>  #define KXCJK1013_REG_INT_SRC2_BIT_YP	BIT(2)
> @@ -336,9 +341,9 @@ static int kxcjk1013_chip_init(struct kxcjk1013_data *data)
>  	}
>  
>  	if (data->active_high_intr)
> -		ret |= KXCJK1013_REG_INT_REG1_BIT_IEA;
> +		ret |= KXCJK1013_REG_INT_CTRL1_BIT_IEA;
>  	else
> -		ret &= ~KXCJK1013_REG_INT_REG1_BIT_IEA;
> +		ret &= ~KXCJK1013_REG_INT_CTRL1_BIT_IEA;
>  
>  	ret = i2c_smbus_write_byte_data(data->client, KXCJK1013_REG_INT_CTRL1,
>  					ret);
> @@ -444,9 +449,9 @@ static int kxcjk1013_setup_any_motion_interrupt(struct kxcjk1013_data *data,
>  	}
>  
>  	if (status)
> -		ret |= KXCJK1013_REG_INT_REG1_BIT_IEN;
> +		ret |= KXCJK1013_REG_INT_CTRL1_BIT_IEN;
>  	else
> -		ret &= ~KXCJK1013_REG_INT_REG1_BIT_IEN;
> +		ret &= ~KXCJK1013_REG_INT_CTRL1_BIT_IEN;
>  
>  	ret = i2c_smbus_write_byte_data(data->client, KXCJK1013_REG_INT_CTRL1,
>  					ret);
> @@ -504,9 +509,9 @@ static int kxcjk1013_setup_new_data_interrupt(struct kxcjk1013_data *data,
>  	}
>  
>  	if (status)
> -		ret |= KXCJK1013_REG_INT_REG1_BIT_IEN;
> +		ret |= KXCJK1013_REG_INT_CTRL1_BIT_IEN;
>  	else
> -		ret &= ~KXCJK1013_REG_INT_REG1_BIT_IEN;
> +		ret &= ~KXCJK1013_REG_INT_CTRL1_BIT_IEN;
>  
>  	ret = i2c_smbus_write_byte_data(data->client, KXCJK1013_REG_INT_CTRL1,
>  					ret);
> @@ -1039,7 +1044,7 @@ static irqreturn_t kxcjk1013_event_handler(int irq, void *private)
>  		goto ack_intr;
>  	}
>  
> -	if (ret & 0x02) {
> +	if (ret & KXCJK1013_REG_INT_SRC1_BIT_WUFS) {
>  		ret = i2c_smbus_read_byte_data(data->client,
>  					       KXCJK1013_REG_INT_SRC2);
>  		if (ret < 0) {

