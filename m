Return-Path: <SRS0=dGO3=GE=huawei.com=jonathan.cameron@kernel.org>
Date: Wed, 14 Mar 2018 17:06:33 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Arnd Bergmann <arnd@arndb.de>, <linux-kernel@vger.kernel.org>,
	<devel@driverdev.osuosl.org>, Lars-Peter Clausen <lars@metafoo.de>,
	<linux-iio@vger.kernel.org>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Hartmut Knaack <knaack.h@gmx.de>, Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH 47/47] staging: iio: remove iio-trig-bfin-timer driver
Message-ID: <20180314180633.000067dd@huawei.com>
In-Reply-To: <20180314163207.GA4279@kroah.com>
References: <20180314153603.3127932-1-arnd@arndb.de>
	<20180314153603.3127932-48-arnd@arndb.de>
	<20180314163207.GA4279@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
List-ID: <linux-iio@vger.kernel.org>

On Wed, 14 Mar 2018 17:32:07 +0100
Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> On Wed, Mar 14, 2018 at 04:36:00PM +0100, Arnd Bergmann wrote:
> > The blackfin architecture is getting removed, so the timer trigger
> > driver is now obsolete. Since this is the last remaining iio trigger
> > driver in staging, I'm removing the entire directory.
Great.

> > 
> > I'm not sure about the other staging iio drivers though: almost
> > all of them are for Analog Devices devices like this one. They
> > are likely used along with blackfin SoCs, but could easily be
> > used on any others as well.
> > 
> > It might be time to consider whether they should be removed, but
> > it doesn't feel like a decision that I should be making.  
> 
> The IIO driver maintainer/developers are talking about that currently, I
> think they have a plan for those other drivers.

Some of the drivers are under consideration for removal (particularly most
of the meter drivers) but it is unconnected to the blackfin removal.
They are simply other obsolete parts that we don't have test hardware
for and need sufficient 'surgery' that we wouldn't feel comfortable
cleaning them up without.  One has been reprieved as a user, who was
happy to test, came forward when I announced the intent to remove them.

> 
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>  
> 
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Acked-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
