Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from kroah.org ([198.145.64.141]:38408 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752283Ab1BBU30 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Wed, 2 Feb 2011 15:29:26 -0500
Date: Wed, 2 Feb 2011 12:29:16 -0800
From: Greg KH <greg@kroah.com>
To: "Hennerich, Michael" <Michael.Hennerich@analog.com>
Cc: "jic23@cam.ac.uk" <jic23@cam.ac.uk>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Drivers <Drivers@analog.com>,
	"device-drivers-devel@blackfin.uclinux.org"
	<device-drivers-devel@blackfin.uclinux.org>,
	"broonie@opensource.wolfsonmicro.com"
	<broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] IIO: TRIGGER: New sysfs based trigger
Message-ID: <20110202202916.GC28479@kroah.com>
References: <1296674468-24251-1-git-send-email-michael.hennerich@analog.com>
 <20110202194318.GB27065@kroah.com>
 <544AC56F16B56944AEC3BD4E3D591771324C1659CB@LIMKCMBX1.ad.analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <544AC56F16B56944AEC3BD4E3D591771324C1659CB@LIMKCMBX1.ad.analog.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, Feb 02, 2011 at 08:13:56PM +0000, Hennerich, Michael wrote:
> Greg KH wrote on 2011-02-02:
> > On Wed, Feb 02, 2011 at 08:21:08PM +0100, michael.hennerich@analog.com
> > wrote:
> >> +static struct platform_driver iio_sysfs_trigger_driver = {
> >> +    .driver = {
> >> +            .name = "iio_sysfs_trigger",
> >> +            .owner = THIS_MODULE,
> >> +    },
> >> +    .probe = iio_sysfs_trigger_probe,
> >> +    .remove = __devexit_p(iio_sysfs_trigger_remove),
> >> +};
> >
> > Why is this a platform device?  It doesn't seem to be platform
> > specific at all, does it?
> 
> What else do you think it should be?

Not a platform one, as it really isn't assigned to a "platform", right?

> Construct driver on initcall, and use module parameters?
> IMHO it is platform specific, since platform device bus allows me to
> register and run multiple instances.
> Depending on the use case, which may vary from board/platform -
> multiple instances are required.
> 
> Like Mark indicated - in EMBEDDED if it doesn't belong to any other
> bus - it's likely a platform bus driver.

CONFIG_EMBEDDED is gone :)

But, I guess there's not really a way to create a simple "virtual"
device in any other manner, is there.  Maybe I need to fix that one of
these days...

Anyway, I guess it's ok, I just don't like it.

thanks,

greg k-h

> 
> Greetings,
> Michael
> 
> --
> Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
> Sitz der Gesellschaft: Muenchen; Registergericht: Muenchen HRB 40368; Geschaeftsfuehrer:Dr.Carsten Suckrow, Thomas Wessel, William A. Martin, Margaret Seif
> 
