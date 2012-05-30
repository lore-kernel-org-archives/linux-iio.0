Return-Path: <Robin.Getz@analog.com>
From: "Getz, Robin" <robin.getz@analog.com>
To: Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH 0/8] IIO: Cleanups and complicated channel modifiers.
Date: Wed, 30 May 2012 15:33:33 -0400
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
References: <1338406866-3833-1-git-send-email-jic23@kernel.org>
In-Reply-To: <1338406866-3833-1-git-send-email-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Message-ID: <201205301533.33508.robin.getz@analog.com>
List-ID: <linux-iio@vger.kernel.org>

On Wed 30 May 2012 15:40, Jonathan Cameron pondered:
> Hi All,
>
> Dropping the reset attributes was discussed a while back and no
> one could come up with a reason for having them. Unless anyone
> does have a good reason, lets drop these before we move the
> relevant drivers out of staging.

This is the only way that userspace can re-initialise the device (if someone 
modified the calibration settings, and wants to get back to the factory 
setting).

That doesn't mean it's necessary - it just means that is what it was there 
for.

-Robin
