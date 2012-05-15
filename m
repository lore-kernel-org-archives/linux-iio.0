Return-Path: <akpm@linux-foundation.org>
Date: Tue, 15 May 2012 12:27:05 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Johan Hovold <jhovold@gmail.com>
Cc: Jonathan Cameron <jic23@cam.ac.uk>, Rob Landley <rob@landley.net>,
 Richard Purdie <rpurdie@rpsys.net>, Samuel Ortiz <sameo@linux.intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Florian Tobias Schandinat
 <FlorianSchandinat@gmx.de>, Arnd Bergmann <arnd@arndb.de>, Mark Brown
 <broonie@opensource.wolfsonmicro.com>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 devel@driverdev.osuosl.org
Subject: Re: [PATCH v3] iio: add LM3533 ambient-light-sensor driver
Message-Id: <20120515122705.42461e7e.akpm@linux-foundation.org>
In-Reply-To: <1337100396-29024-1-git-send-email-jhovold@gmail.com>
References: <1336040799-18433-3-git-send-email-jhovold@gmail.com>
	<1337100396-29024-1-git-send-email-jhovold@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-iio@vger.kernel.org>

On Tue, 15 May 2012 18:46:36 +0200
Johan Hovold <jhovold@gmail.com> wrote:

> Add sub-driver for the ambient-light-sensor interface on National
> Semiconductor / TI LM3533 lighting power chips.
> 
> The sensor interface can be used to control the LEDs and backlights of
> the chip through defining five light zones and three sets of
> corresponding brightness target levels.
> 
> The driver provides raw and mean adc readings along with the current
> light zone through sysfs. A threshold event can be generated on zone
> changes.
>
> ...
>
>  drivers/staging/iio/light/Kconfig                  |   16 +
>  drivers/staging/iio/light/Makefile                 |    1 +
>  drivers/staging/iio/light/lm3533-als.c             |  726 ++++++++++++++++++++

Why is this aimed at drivers/staging/, rather than directly into
drivers/iio/?
