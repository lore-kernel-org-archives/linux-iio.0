Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:43307 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753546Ab3BBJwg (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 2 Feb 2013 04:52:36 -0500
Message-ID: <510CE1E2.5000704@kernel.org>
Date: Sat, 02 Feb 2013 09:52:34 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Guenter Roeck <linux@roeck-us.net>
CC: linux-iio@vger.kernel.org, devicetree-discuss@lists.ozlabs.org,
	Naveen Krishna Chatradhi <ch.naveen@samsung.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Doug Anderson <dianders@chromium.org>,
	Tomasz Figa <tomasz.figa@gmail.com>,
	Grant Likely <grant.likely@secretlab.ca>,
	Rob Herring <rob.herring@calxeda.com>
Subject: Re: [PATCH 02/11] staging/iio: (iio_hwmon) Add support for sysfs
 name attribute
References: <1359668588-13678-1-git-send-email-linux@roeck-us.net> <1359668588-13678-3-git-send-email-linux@roeck-us.net>
In-Reply-To: <1359668588-13678-3-git-send-email-linux@roeck-us.net>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 01/31/2013 09:42 PM, Guenter Roeck wrote:
> The 'name' attribute is mandatory for hwmon devices.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Wow, that one character patch these crossed with manages to effect
this one as well.  Applied with the obvious tiny fix.

Thanks,
> ---
>  drivers/staging/iio/iio_hwmon.c |   12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/iio/iio_hwmon.c b/drivers/staging/iio/iio_hwmon.c
> index 5456272..7f260ea 100644
> --- a/drivers/staging/iio/iio_hwmon.c
> +++ b/drivers/staging/iio/iio_hwmon.c
> @@ -55,6 +55,14 @@ static ssize_t iio_hwmon_read_val(struct device *dev,
>  	return sprintf(buf, "%d\n", result);
>  }
>  
> +static ssize_t show_name(struct device *dev, struct device_attribute *attr,
> +			 char *buf)
> +{
> +	return sprintf(buf, "iio_hwmon\n");
> +}
> +
> +static DEVICE_ATTR(name, S_IRUGO, show_name, NULL);
> +
>  static int iio_hwmon_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
> @@ -77,7 +85,7 @@ static int iio_hwmon_probe(struct platform_device *pdev)
>  		st->num_channels++;
>  
>  	st->attrs = devm_kzalloc(dev,
> -				 sizeof(st->attrs) * (st->num_channels + 1),
> +				 sizeof(st->attrs) * (st->num_channels + 2),
>  				 GFP_KERNEL);
>  	if (st->attrs == NULL) {
>  		ret = -ENOMEM;
> @@ -125,7 +133,7 @@ static int iio_hwmon_probe(struct platform_device *pdev)
>  		a->index = i;
>  		st->attrs[i] = &a->dev_attr.attr;
>  	}
> -
> +	st->attrs[st->num_channels] = &dev_attr_name.attr;
>  	st->attr_group.attrs = st->attrs;
>  	platform_set_drvdata(pdev, st);
>  	ret = sysfs_create_group(&dev->kobj, &st->attr_group);
> 
