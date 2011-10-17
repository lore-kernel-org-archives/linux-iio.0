Return-Path: <broonie@opensource.wolfsonmicro.com>
Date: Mon, 17 Oct 2011 14:55:08 +0100
From: Mark Brown <broonie@opensource.wolfsonmicro.com>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: Linus Walleij <linus.ml.walleij@gmail.com>,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	zdevai@gmail.com
Subject: Re: [PATCH] staging:iio:proof of concept in kernel interface.
Message-ID: <20111017135508.GE27266@opensource.wolfsonmicro.com>
References: <20111017101959.GC3042@opensource.wolfsonmicro.com>
 <4E9C0423.5010909@cam.ac.uk>
 <20111017104642.GD3042@opensource.wolfsonmicro.com>
 <4E9C0DD7.7080105@cam.ac.uk>
 <20111017111807.GA27266@opensource.wolfsonmicro.com>
 <4E9C1249.5020408@cam.ac.uk>
 <20111017120813.GB27266@opensource.wolfsonmicro.com>
 <4E9C201D.30905@cam.ac.uk>
 <20111017124807.GD27266@opensource.wolfsonmicro.com>
 <4E9C27B9.50504@cam.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4E9C27B9.50504@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

On Mon, Oct 17, 2011 at 02:03:53PM +0100, Jonathan Cameron wrote:
> On 10/17/11 13:48, Mark Brown wrote:

> >> 0...4
> >> 1...5
> >> AUXA....AUXD
> >> TEMP_EXT1...TEMP_EXT5 (all of which are just normal adc channels that some
> >> designer decided would be used only for connecting analog temperature sensors.)

> > None of those look at all unreasonable

> Fair enough though the temp one is at least stupid, but why should
> we match them?

So that the engineer sitting there with the schematics can figure out
how to tell software about the board hookup with minimal pain.

> Ok, so we could add to every channel a magic matching field called
> datasheet_name?  To my mind its silly overhead, but if there is a
> consensus on it then fine.  Note however that any remotely general
> purpose userspace will not read these values even if we make
> them available.

That depends, if the userspace is really general purpose I'd expect it'd
be exposing this information to let the user point and click (or
whatever) through the channels.  Otherwise they'll be scratching their
heads wondering what channel 0 on this particular system actually is.
