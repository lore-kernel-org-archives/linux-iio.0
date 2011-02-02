Return-Path: <greg@kroah.com>
Date: Wed, 2 Feb 2011 11:43:18 -0800
From: Greg KH <greg@kroah.com>
To: michael.hennerich@analog.com
Cc: jic23@cam.ac.uk, linux-iio@vger.kernel.org, drivers@analog.com,
	device-drivers-devel@blackfin.uclinux.org
Subject: Re: [PATCH] IIO: TRIGGER: New sysfs based trigger
Message-ID: <20110202194318.GB27065@kroah.com>
References: <1296674468-24251-1-git-send-email-michael.hennerich@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1296674468-24251-1-git-send-email-michael.hennerich@analog.com>
List-ID: <linux-iio@vger.kernel.org>

On Wed, Feb 02, 2011 at 08:21:08PM +0100, michael.hennerich@analog.com wrote:
> +static struct platform_driver iio_sysfs_trigger_driver = {
> +	.driver = {
> +		.name = "iio_sysfs_trigger",
> +		.owner = THIS_MODULE,
> +	},
> +	.probe = iio_sysfs_trigger_probe,
> +	.remove = __devexit_p(iio_sysfs_trigger_remove),
> +};

Why is this a platform device?  It doesn't seem to be platform specific
at all, does it?

thanks,

greg k-h
