Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:45410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753122AbeDURWi (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 21 Apr 2018 13:22:38 -0400
Date: Sat, 21 Apr 2018 18:22:32 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        John Syne <john3909@gmail.com>, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] stagging:iio:meter: Add ade7854_read_raw function
Message-ID: <20180421182232.7a573a40@archlinux>
In-Reply-To: <9900ff3d492dbca4dc39cdd8ca6490af05a4f09a.1524311298.git.rodrigosiqueiramelo@gmail.com>
References: <cover.1524311298.git.rodrigosiqueiramelo@gmail.com>
        <9900ff3d492dbca4dc39cdd8ca6490af05a4f09a.1524311298.git.rodrigosiqueiramelo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, 21 Apr 2018 08:55:52 -0300
Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com> wrote:

> This patch adds the ade7854_read_raw() function which is responsible for
> handling the read operation for registers: AIGAIN, BIGAIN, CIGAIN,
> NIGAIN, AVGAIN, BVGAIN, and CVGAIN. For the sake of simplicity, this
> patch only adds basic manipulation for current and voltage channels.
> Finally, this patch disables the old approach for reading data.
> 
> Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>

Other than the previous mentioned issue with the way the channels are
defined, this is nearly fine.

See inline.

> ---
>  drivers/staging/iio/meter/ade7854.c | 41 ++++++++++++++++++++++++-----
>  1 file changed, 34 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/staging/iio/meter/ade7854.c b/drivers/staging/iio/meter/ade7854.c
> index 2fbb2570ba54..242ecde75900 100644
> --- a/drivers/staging/iio/meter/ade7854.c
> +++ b/drivers/staging/iio/meter/ade7854.c
> @@ -229,31 +229,31 @@ static int ade7854_reset(struct device *dev)
>  }
>  
>  static IIO_DEV_ATTR_AIGAIN(0644,
> -		ade7854_read_24bit,
> +		NULL,
>  		ade7854_write_24bit,
>  		ADE7854_AIGAIN);
>  static IIO_DEV_ATTR_BIGAIN(0644,
> -		ade7854_read_24bit,
> +		NULL,
>  		ade7854_write_24bit,
>  		ADE7854_BIGAIN);
>  static IIO_DEV_ATTR_CIGAIN(0644,
> -		ade7854_read_24bit,
> +		NULL,
>  		ade7854_write_24bit,
>  		ADE7854_CIGAIN);
>  static IIO_DEV_ATTR_NIGAIN(0644,
> -		ade7854_read_24bit,
> +		NULL,
>  		ade7854_write_24bit,
>  		ADE7854_NIGAIN);
>  static IIO_DEV_ATTR_AVGAIN(0644,
> -		ade7854_read_24bit,
> +		NULL,
>  		ade7854_write_24bit,
>  		ADE7854_AVGAIN);
>  static IIO_DEV_ATTR_BVGAIN(0644,
> -		ade7854_read_24bit,
> +		NULL,
>  		ade7854_write_24bit,
>  		ADE7854_BVGAIN);
>  static IIO_DEV_ATTR_CVGAIN(0644,
> -		ade7854_read_24bit,
> +		NULL,
>  		ade7854_write_24bit,
>  		ADE7854_CVGAIN);
>  static IIO_DEV_ATTR_APPARENT_POWER_A_GAIN(0644,
> @@ -471,6 +471,32 @@ static int ade7854_set_irq(struct device *dev, bool enable)
>  	return st->write_reg(dev, ADE7854_MASK0, irqen, 32);
>  }
>  
> +static int ade7854_read_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan,
> +			    int *val,
> +			    int *val2,
> +			    long mask)
> +{
> +	struct ade7854_state *st = iio_priv(indio_dev);
> +	int ret;
> +
> +	if (mask != IIO_CHAN_INFO_SCALE)
> +		return -EINVAL;
Given you specified sampling frequency for the channels in the previous
patch this is a little odd!

> +
> +	switch (chan->type) {
> +	case IIO_CURRENT:
> +	case IIO_VOLTAGE:
> +		ret = st->read_reg(&indio_dev->dev, chan->address, val, 24);
> +		if (ret < 0)
> +			return ret;
> +		return IIO_VAL_INT;
> +	default:
> +		break;
> +	}
> +
> +	return -EINVAL;
> +}
> +
>  static int ade7854_initial_setup(struct iio_dev *indio_dev)
>  {
>  	int ret;
> @@ -572,6 +598,7 @@ static const struct attribute_group ade7854_attribute_group = {
>  
>  static const struct iio_info ade7854_info = {
>  	.attrs = &ade7854_attribute_group,
> +	.read_raw = &ade7854_read_raw,
>  };
>  
>  int ade7854_probe(struct iio_dev *indio_dev, struct device *dev)

