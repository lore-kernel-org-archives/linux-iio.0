Return-Path: <martink@posteo.de>
Message-ID: <55963A77.5040202@posteo.de>
Date: Fri, 03 Jul 2015 09:32:07 +0200
From: Martin Kepplinger <martink@posteo.de>
MIME-Version: 1.0
To: pmeerw@pmeerw.net, jic23@kernel.org,
 christoph.muellner@theobroma-systems.com
CC: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 0/8] iio: mma8452: support more devices and improve
 driver
References: <1435738922-12580-1-git-send-email-martink@posteo.de>
In-Reply-To: <1435738922-12580-1-git-send-email-martink@posteo.de>
Content-Type: text/plain; charset=iso-8859-15
List-ID: <linux-iio@vger.kernel.org>

Am 2015-07-01 um 10:21 schrieb Martin Kepplinger:
> This is the 2nd version that adds support for motion interrupts and 3 more
> accelerometer chips, two of which use them because they don't support the
> until now included transient interrupt sources:
> 
> MMA8453Q, MMA8652FC and MMA8653FC; datasheets are in the commit messages.
> 
> The driver and module name remains the same, seperating it from the device
> names it now supports.
> 
> On top of this, there are minor documentation additions, and more notably,
> the change of the existing iio event type from IIO_EV_TYPE_THRESH to
> IIO_EV_TYPE_MAG since it's the magnitude of the threshold that is relevant
> for these devices, not a signed value.
> 
> Please review and test if you can. For MMA8452Q, other than the event type,
> nothing should have changed.
> 

Any wishes, suggestions, objections about this change?

thanks,
                           martin
