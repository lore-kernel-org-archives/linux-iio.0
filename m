Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:60673 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750787AbcFCKgR (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 3 Jun 2016 06:36:17 -0400
Subject: Re: [PATCH 1/2] iio: light: al3320a: support illuminance0_input
 function
To: Rocky Hsiao <rocky.hsiao@dyna-image.com>, linux-iio@vger.kernel.org
References: <1464948016-49062-1-git-send-email-rocky.hsiao@dyna-image.com>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	linux-kernel@vger.kernel.org,
	John Huang <john.huang@dyna-image.com>,
	Thomas Lin <thomas.lin@dyna-image.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <7545ee3c-4b82-3d42-bc40-5a28d293e76b@kernel.org>
Date: Fri, 3 Jun 2016 11:36:13 +0100
MIME-Version: 1.0
In-Reply-To: <1464948016-49062-1-git-send-email-rocky.hsiao@dyna-image.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 03/06/16 11:00, Rocky Hsiao wrote:
> Add few functions to show lux.
> 
> Signed-off-by: Rocky Hsiao <rocky.hsiao@dyna-image.com>
Hi Rocky,

Thanks for such a quick response - easier to see what is going on in
these broken out patches.  Well presented patches are always
much nicer to review.

Quick process email - this is V2 of the series. I'd give it a cover letter
to summarise changes and that should be titled [PATCH V2 0/2] WHATEVER.
to make ti clear this is version 2.  The list gets really confusing if
like me you tend to do all your reviews once a week and drivers may
have been through 4 revisions in between!

Fundamental question here is why provide this new interface?  The relevant
details have already been made available to userspace.  Convention is that
we only use _input types if:
* The device happens to output in the right units so scale would be 1.
* The conversion is horrible and non linear and we have no way of exporting
it to userspace. 

Producing the illuminance processed value is a job for the userspace
library not the kernel driver.

Various other comments inline.

Jonathan

> ---
>  drivers/iio/light/al3320a.c | 50 +++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 48 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/light/al3320a.c b/drivers/iio/light/al3320a.c
> index 6aac651..f32b5d1 100644
> --- a/drivers/iio/light/al3320a.c
> +++ b/drivers/iio/light/al3320a.c
> @@ -11,6 +11,13 @@
>   *
>   * TODO: interrupt support, thresholds
>   *
> + * last change: 2016/06/03
> + *
> + * change list:
> + * - add few function to supprt illuminance0_input
support
> + *
> + * editor: Rocky Hsiao <rocky.hsiao@dyna-image>
Traditional option is to add an entry to the copyright list if you
want to have a contribution explicitly noted. Otherwise, it's all
in the git history anyway so this adds little info.
(copyright obvious has legal meanings as well).

> + *
No blank commented line at end of block.
>   */
>  
>  #include <linux/module.h>
> @@ -72,9 +79,47 @@ static const struct iio_chan_spec al3320a_channels[] = {
>  	}
>  };
>  
> +static int al3320a_get_adc_value(struct al3320a_data *data)
> +{
> +	int val;
> +
> +	val = i2c_smbus_read_word_data(data->client, AL3320A_REG_DATA_LOW);
> +
> +	return val;
return i2c_smbus_read_word_data(data->client, AL3320A_REG_DATA_lOW);
> +}
This wrapper adds little benefit. I wouldn't bother having it,
just call the i2c cal directly at the relevant locations.
> +
> +static int al3320a_get_lux(struct al3320a_data *data)
> +{
> +	int ret;
> +	long ret64;
I'd guess you expect this to be 64 bit?  It's unlikely
to be so (though in theory c does allow it to be).
Which is a good thing as 64 bit division in kernel is
a little interesting.
> +
> +	ret = al3320a_get_adc_value(data);
> +	ret64 = ret;
> +	ret64 = (ret64 * 32000) / 1000000;
> +	ret = ret64;
> +
> +	return  ret;
> +}
> +
> +static ssize_t al3320a_lux_show(struct device *dev,
> +		struct device_attribute *attr,
> +		char *buf)
> +{
> +	struct al3320a_data *data = iio_priv(dev_to_iio_dev(dev));
> +	int val;
> +
> +	val = al3320a_get_lux(data);
> +
> +	return sprintf(buf, "%d\n", val);
> +}
> +
> +static IIO_DEVICE_ATTR(illuminance0_input, S_IRUGO,
> +		al3320a_lux_show, NULL, 0);
> +
>  static IIO_CONST_ATTR(in_illuminance_scale_available, AL3320A_SCALE_AVAILABLE);
>  
>  static struct attribute *al3320a_attributes[] = {
> +	&iio_dev_attr_illuminance0_input.dev_attr.attr,
Please use standard channel spec for doing this rather than a custom
attribute.   That will mean the read_raw callback i used and
all the naming etc will be automatic. + becomes available for
in kernel consumers unlike custom attributes.
>  	&iio_const_attr_in_illuminance_scale_available.dev_attr.attr,
>  	NULL,
>  };
> @@ -125,8 +170,8 @@ static int al3320a_read_raw(struct iio_dev *indio_dev,
>  		 * - low byte of output is stored at AL3320A_REG_DATA_LOW
>  		 * - high byte of output is stored at AL3320A_REG_DATA_LOW + 1
>  		 */
> -		ret = i2c_smbus_read_word_data(data->client,
> -					       AL3320A_REG_DATA_LOW);
> +		ret = al3320a_get_adc_value(data);
> +
No extra line here.
>  		if (ret < 0)
>  			return ret;
>  		*val = ret;
> @@ -201,6 +246,7 @@ static int al3320a_probe(struct i2c_client *client,
>  		dev_err(&client->dev, "al3320a chip init failed\n");
>  		return ret;
>  	}
> +
Please avoid unconnected white space changes.  It's a valid change for
readability, but should not be combined with a patch doing 'real' stuff
as it adds noise and slows down review.
>  	return devm_iio_device_register(&client->dev, indio_dev);
>  }
>  
> 

