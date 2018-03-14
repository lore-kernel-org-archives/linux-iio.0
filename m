Return-Path: <SRS0=vXVw=GE=linuxfoundation.org=gregkh@kernel.org>
Date: Wed, 14 Mar 2018 17:32:07 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
	Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH 47/47] staging: iio: remove iio-trig-bfin-timer driver
Message-ID: <20180314163207.GA4279@kroah.com>
References: <20180314153603.3127932-1-arnd@arndb.de>
 <20180314153603.3127932-48-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180314153603.3127932-48-arnd@arndb.de>
List-ID: <linux-iio@vger.kernel.org>

On Wed, Mar 14, 2018 at 04:36:00PM +0100, Arnd Bergmann wrote:
> The blackfin architecture is getting removed, so the timer trigger
> driver is now obsolete. Since this is the last remaining iio trigger
> driver in staging, I'm removing the entire directory.
> 
> I'm not sure about the other staging iio drivers though: almost
> all of them are for Analog Devices devices like this one. They
> are likely used along with blackfin SoCs, but could easily be
> used on any others as well.
> 
> It might be time to consider whether they should be removed, but
> it doesn't feel like a decision that I should be making.

The IIO driver maintainer/developers are talking about that currently, I
think they have a plan for those other drivers.

> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
