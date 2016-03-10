Return-Path: <ludovic.desroches@atmel.com>
Date: Thu, 10 Mar 2016 14:23:51 +0100
From: Ludovic Desroches <ludovic.desroches@atmel.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: Lars-Peter Clausen <lars@metafoo.de>, Ludovic Desroches
	<ludovic.desroches@atmel.com>, <linux-iio@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<nicolas.ferre@atmel.com>
Subject: Re: [PATCH v2 1/2] iio: core: introduce IIO_CHAN_INFO_SIGNED
Message-ID: <20160310132351.GO2690@odux.rfo.atmel.com>
References: <1457360997-29179-1-git-send-email-ludovic.desroches@atmel.com>
 <1457360997-29179-2-git-send-email-ludovic.desroches@atmel.com>
 <56DDDFFC.5010100@metafoo.de>
 <56E08FD5.4060701@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <56E08FD5.4060701@kernel.org>
List-ID: <linux-iio@vger.kernel.org>

On Wed, Mar 09, 2016 at 09:04:21PM +0000, Jonathan Cameron wrote:
> On 07/03/16 20:09, Lars-Peter Clausen wrote:
> > On 03/07/2016 03:29 PM, Ludovic Desroches wrote:
> >> The same channel can be used to perform a signed or an unsigned
> >> conversion. Add a new infomask element to be able to select the type of
> >> conversion wanted: a raw one or a signed raw one.
> > 
> > If this is the difference between offset binary and two's complement then it
> > makes no sense to expose this at this level. Both are the same number just
> > in a different representation and converting between them is cheap. A few
> > magnitudes cheaper than reading the result over sysfs. So, if your device
> > supports both, just pick one.
> > 
> > For the buffered interface it may make sense to expose this, since the per
> > sample overhead is a lot lower. But still doing the conversion should be
> > cheap enough that it does not really matter. Before this is implemented I'd
> > like to see hard performance numbers that this actually makes a difference.
> > 
> > - Lars
> > 
> Definitely looking for more detail on this.  I'd missed we were talking simply
> about representation (which is also how I read 62.6.6 Conversion Results Format
> in the datasheet). Not entirely sure what I imagined the difference between
> signed and unsigned output would be!

You are both right, it is only about representation. I have asked hardware guys
why they add this feature. They told me it is for convenience and because some
librairies need signed results.

Regards

Ludovic
