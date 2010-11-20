Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from kroah.org ([198.145.64.141]:34186 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753694Ab0KTBmP (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Fri, 19 Nov 2010 20:42:15 -0500
Date: Fri, 19 Nov 2010 17:12:05 -0800
From: Greg KH <greg@kroah.com>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: Matthias Brugger <matthias.bgg@gmail.com>,
	Greg Kroah-Hartman <gregkh@suse.de>,
	devel@driverdev.osuosl.org, linux-iio@vger.kernel.org,
	Matthias Brugger <mensch0815@gmail.com>,
	"Datta, Shubhrajyoti" <shubhrajyoti@ti.com>,
	Christoph Mair <christoph.mair@gmail.com>
Subject: Re: [PATCH] iio - add support for bmp085 barometer
Message-ID: <20101120011205.GA29633@kroah.com>
References: <4CCADE59.9070702@gmail.com>
 <4CE6D125.7050801@cam.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4CE6D125.7050801@cam.ac.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, Nov 19, 2010 at 07:33:57PM +0000, Jonathan Cameron wrote:
> On 10/29/10 15:46, Matthias Brugger wrote:
> > This patch adds support for the Bosch Sensortec bmp085 digital
> > barometer to the iio subsystem.
> Hi Matthias,
> 
> Pretty clean driver.  Various minor comments inline.
> 
> The controversial thing about this driver is that it is (I think)
> the first time we are going to have a driver in iio for a device
> that already has a driver elsewhere in the kernel tree.  (in misc).
> This makes me rather uncomfortable...

Ick, that's not good.  What's the future of the misc driver if this one
goes in as well?

> One crucial thing is that we need a todo file listing anything that
> driver does that this one does not. I would also like to get some
> feedback on this from the author of the existing driver. I have
> cc'd him.  At a very quick glance, the key thing that driver does
> that isn't present here is that it ensures there is a recent enough
> temperature measurement in driver.  Otherwise they are in many ways
> pretty similar. Obviously I'm happy to have barometric pressure sensors
> in IIO but I don't want to step on anyones toes and things will get
> 'interesting' when we move out of staging. The existing driver
> almost certainly has a userspace so any changes are going to cause
> pain and will need to be done slowly and carefully.

Yeah, Matthias, why did you write a new driver for this in the first
place?  What is missing from the in-kernel driver that you needed?  Why
not just add that to the existing driver?

thanks,

greg k-h
