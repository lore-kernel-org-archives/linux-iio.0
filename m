Return-Path: <greg@kroah.com>
Date: Thu, 22 Apr 2010 16:37:41 -0700
From: Greg KH <greg@kroah.com>
To: "Hennerich, Michael" <Michael.Hennerich@analog.com>
Cc: "gregkh@suse.de" <gregkh@suse.de>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	"uclinux-dist-devel@blackfin.uclinux.org" <uclinux-dist-devel@blackfin.uclinux.org>,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: Re: [PATCH] iio-trig-gpio:Remove redundant gpio_request
Message-ID: <20100422233741.GA4414@kroah.com>
References: <544AC56F16B56944AEC3BD4E3D5917712D6B1D9767@LIMKCMBX1.ad.analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <544AC56F16B56944AEC3BD4E3D5917712D6B1D9767@LIMKCMBX1.ad.analog.com>
List-ID: <linux-iio@vger.kernel.org>

On Tue, Mar 09, 2010 at 12:58:29PM +0000, Hennerich, Michael wrote:
> 
> Remove redundant gpio_request:
> The GPIO used as trigger IRQ, is also requested as gpio, but actually never read.
> 
> Use platform resource facility to get IRQs numbers and flags.
> Make sure this driver can be used with any system IRQ, not necessarily limited to GPIO-IRQs.
> Use dev_err(dev...) and friends instead of printk(KERN_ERR...)
> 
> 
> Signed-off-by: Michael Hennerich <Michael.Hennerich@analog.com>
> Acked-by: Jonathan Cameron <jic23@cam.ac.uk>
> 
> 
> Index: drivers/staging/iio/trigger/iio-trig-gpio.c
> ===================================================================
> --- drivers/staging/iio/trigger/iio-trig-gpio.c (revision 7916)
> +++ drivers/staging/iio/trigger/iio-trig-gpio.c (working copy)
> @@ -13,7 +13,6 @@
>   * TODO:
>   *
>   * Add board config elements to allow specification of startup settings.
> - * Add configuration settings (irq type etc)
>   */
> 
>  #include <linux/kernel.h>
> @@ -30,7 +29,7 @@
> 
>  struct iio_gpio_trigger_info {
>         struct mutex in_use;
> -       int gpio;
> +       unsigned int irq;

Your email client turned the tabs into spaces, and made this patch
unappliable.  Can you fix this and resend your other patches as well
(they also had the same problem.)

Take a look at Documentation/SubmittingPatches for how to do this
correctly (you also need to make the diff one level down).

thanks,

greg k-h
