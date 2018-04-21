Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:45694 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752907AbeDUR0O (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 21 Apr 2018 13:26:14 -0400
Date: Sat, 21 Apr 2018 18:26:08 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        John Syne <john3909@gmail.com>, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] stagging:iio:meter: Add ade7854_write_raw function
Message-ID: <20180421182608.3371a50b@archlinux>
In-Reply-To: <82a36a0f4ee84d8ff53be2055bad22be4b75634a.1524311298.git.rodrigosiqueiramelo@gmail.com>
References: <cover.1524311298.git.rodrigosiqueiramelo@gmail.com>
        <82a36a0f4ee84d8ff53be2055bad22be4b75634a.1524311298.git.rodrigosiqueiramelo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, 21 Apr 2018 08:56:19 -0300
Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com> wrote:

> This patch adds the ade7854_write_raw() function which is responsible
> for handling the write operation for registers: AIGAIN, BIGAIN, CIGAIN,
> NIGAIN, AVGAIN, BVGAIN, and CVGAIN. Finally, this patch completely
> removes the old ABI used for handling the registers mentioned above.
> 
> Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
The baby steps approach here is good, but with all 3 patches as one it
would have been a lot easier to follow.

This is almost fine except for the issue I had with how the channels
were defined in the first place.

Also a question about scales inline...

> ---
>  drivers/staging/iio/meter/ade7854.c | 60 ++++++++++++-----------------
>  1 file changed, 25 insertions(+), 35 deletions(-)
> 
> diff --git a/drivers/staging/iio/meter/ade7854.c b/drivers/staging/iio/meter/ade7854.c
> index 242ecde75900..df19c8b4b5d7 100644
> --- a/drivers/staging/iio/meter/ade7854.c
> +++ b/drivers/staging/iio/meter/ade7854.c
> @@ -228,34 +228,6 @@ static int ade7854_reset(struct device *dev)
>  	return st->write_reg(dev, ADE7854_CONFIG, val, 16);
>  }
>  
> -static IIO_DEV_ATTR_AIGAIN(0644,
> -		NULL,
> -		ade7854_write_24bit,
> -		ADE7854_AIGAIN);
> -static IIO_DEV_ATTR_BIGAIN(0644,
> -		NULL,
> -		ade7854_write_24bit,
> -		ADE7854_BIGAIN);
> -static IIO_DEV_ATTR_CIGAIN(0644,
> -		NULL,
> -		ade7854_write_24bit,
> -		ADE7854_CIGAIN);
> -static IIO_DEV_ATTR_NIGAIN(0644,
> -		NULL,
> -		ade7854_write_24bit,
> -		ADE7854_NIGAIN);
> -static IIO_DEV_ATTR_AVGAIN(0644,
> -		NULL,
> -		ade7854_write_24bit,
> -		ADE7854_AVGAIN);
> -static IIO_DEV_ATTR_BVGAIN(0644,
> -		NULL,
> -		ade7854_write_24bit,
> -		ADE7854_BVGAIN);
> -static IIO_DEV_ATTR_CVGAIN(0644,
> -		NULL,
> -		ade7854_write_24bit,
> -		ADE7854_CVGAIN);
>  static IIO_DEV_ATTR_APPARENT_POWER_A_GAIN(0644,
>  		ade7854_read_24bit,
>  		ade7854_write_24bit,
> @@ -497,6 +469,30 @@ static int ade7854_read_raw(struct iio_dev *indio_dev,
>  	return -EINVAL;
>  }
>  
> +static int ade7854_write_raw(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan,
> +			     int val, int val2, long mask)
> +{
> +	struct ade7854_state *st = iio_priv(indio_dev);
> +	int ret;
> +
> +	if (mask != IIO_CHAN_INFO_SCALE)
> +		return -EINVAL;
> +
> +	switch (chan->type) {
> +	case IIO_CURRENT:
> +	case IIO_VOLTAGE:
Probably need some range checking to make sure we have a sane value.

Also, I'm curious about units here.

you are using CHAN_INFO_SCALE which would mean this is linked to
the _RAW value (the actual reading of the channel) by _RAW*_SCALE = value in
defined base units for the channel type.  So I'd expect to see some
code here doing a conversion to the internal format for the device.

I wouldn't expect to see a value from userspace written unconverted
into the register.

(I missed this in the previous patch - sorry).

Jonathan

> +		ret = st->write_reg(&indio_dev->dev, chan->address, val, 24);
> +		if (ret < 0)
> +			return ret;
> +		return 0;
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
> @@ -521,13 +517,6 @@ static IIO_CONST_ATTR_SAMP_FREQ_AVAIL("8000");
>  static IIO_CONST_ATTR(name, "ade7854");
>  
>  static struct attribute *ade7854_attributes[] = {
> -	&iio_dev_attr_aigain.dev_attr.attr,
> -	&iio_dev_attr_bigain.dev_attr.attr,
> -	&iio_dev_attr_cigain.dev_attr.attr,
> -	&iio_dev_attr_nigain.dev_attr.attr,
> -	&iio_dev_attr_avgain.dev_attr.attr,
> -	&iio_dev_attr_bvgain.dev_attr.attr,
> -	&iio_dev_attr_cvgain.dev_attr.attr,
>  	&iio_dev_attr_linecyc.dev_attr.attr,
>  	&iio_dev_attr_sagcyc.dev_attr.attr,
>  	&iio_dev_attr_cfcyc.dev_attr.attr,
> @@ -599,6 +588,7 @@ static const struct attribute_group ade7854_attribute_group = {
>  static const struct iio_info ade7854_info = {
>  	.attrs = &ade7854_attribute_group,
>  	.read_raw = &ade7854_read_raw,
> +	.write_raw = &ade7854_write_raw,
>  };
>  
>  int ade7854_probe(struct iio_dev *indio_dev, struct device *dev)

