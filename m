Return-Path: <greg@kroah.com>
Date: Wed, 2 Feb 2011 12:26:41 -0800
From: Greg KH <greg@kroah.com>
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: michael.hennerich@analog.com, jic23@cam.ac.uk,
	linux-iio@vger.kernel.org, drivers@analog.com,
	device-drivers-devel@blackfin.uclinux.org
Subject: Re: [PATCH] IIO: TRIGGER: New sysfs based trigger
Message-ID: <20110202202641.GA28479@kroah.com>
References: <1296674468-24251-1-git-send-email-michael.hennerich@analog.com>
 <20110202194318.GB27065@kroah.com>
 <20110202195001.GH9810@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20110202195001.GH9810@sirena.org.uk>
List-ID: <linux-iio@vger.kernel.org>

On Wed, Feb 02, 2011 at 07:50:01PM +0000, Mark Brown wrote:
> On Wed, Feb 02, 2011 at 11:43:18AM -0800, Greg KH wrote:
> > On Wed, Feb 02, 2011 at 08:21:08PM +0100, michael.hennerich@analog.com wrote:
> 
> > > +static struct platform_driver iio_sysfs_trigger_driver = {
> > > +	.driver = {
> > > +		.name = "iio_sysfs_trigger",
> > > +		.owner = THIS_MODULE,
> > > +	},
> > > +	.probe = iio_sysfs_trigger_probe,
> > > +	.remove = __devexit_p(iio_sysfs_trigger_remove),
> > > +};
> 
> > Why is this a platform device?  It doesn't seem to be platform specific
> > at all, does it?
> 
> Platform devices are used throughout the embedded kernel for virtual
> devices

Yes, but that doesn't mean they should be.

> - the MFD subsystem is one of the most obvious examples here.

Don't make a device a "platform" device unless it really is one.  This
one isn't one, it's a "virtual" device, right?

thanks,

greg k-h
