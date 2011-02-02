Return-Path: <broonie@sirena.org.uk>
Date: Wed, 2 Feb 2011 20:47:16 +0000
From: Mark Brown <broonie@opensource.wolfsonmicro.com>
To: "Hennerich, Michael" <Michael.Hennerich@analog.com>
Cc: Greg KH <greg@kroah.com>, "jic23@cam.ac.uk" <jic23@cam.ac.uk>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Drivers <Drivers@analog.com>,
	"device-drivers-devel@blackfin.uclinux.org" <device-drivers-devel@blackfin.uclinux.org>
Subject: Re: [PATCH] IIO: TRIGGER: New sysfs based trigger
Message-ID: <20110202204716.GI9810@sirena.org.uk>
References: <1296674468-24251-1-git-send-email-michael.hennerich@analog.com> <20110202194242.GA27065@kroah.com> <544AC56F16B56944AEC3BD4E3D591771324C1659DD@LIMKCMBX1.ad.analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <544AC56F16B56944AEC3BD4E3D591771324C1659DD@LIMKCMBX1.ad.analog.com>
List-ID: <linux-iio@vger.kernel.org>

On Wed, Feb 02, 2011 at 08:36:27PM +0000, Hennerich, Michael wrote:
> Greg KH wrote on 2011-02-02:

> >> +MODULE_AUTHOR("Michael Hennerich
> >> +<hennerich@blackfin.uclinux.org>");
> >> +MODULE_DESCRIPTION("Sysfs based trigger for the iio subsystem");
> >> +MODULE_LICENSE("GPL v2");

> > What is going to cause this module to be loaded in the system?  Are
> > you relying on userspace to load it if it "knows" it is needed?
> > That's really not nice, we should trigger off of some type of hardware.

> Well again - I don't understand what you mean here - you can load this
> driver as module or more likely build into the kernel - which both
> works fine.

You need a MODULE_ALIAS so udev/modprobe can figure out how to load the
right driver when the device appears on the bus.
