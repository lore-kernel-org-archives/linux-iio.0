Return-Path: <broonie@opensource.wolfsonmicro.com>
Date: Thu, 22 Dec 2011 17:41:53 +0000
From: Mark Brown <broonie@opensource.wolfsonmicro.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Greg KH <greg@kroah.com>, Jonathan Cameron <jic23@cam.ac.uk>,
	archive@jic23.retrosnub.co.uk, linux-iio@vger.kernel.org,
	lars@metafoo.de, Linus Walleij <linus.walleij@linaro.org>,
	"arnd@arndb.de" <arnd@arndb.de>,
	Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH 3/5] staging:iio:core add in kernel interface mapping and
 getting IIO channels.
Message-ID: <20111222174153.GD29622@opensource.wolfsonmicro.com>
References: <1323122164-32314-1-git-send-email-jic23@kernel.org>
 <1323122164-32314-4-git-send-email-jic23@kernel.org>
 <20111208194057.GA28532@kroah.com>
 <4EE39205.6030109@kernel.org>
 <20111210191524.GA17929@kroah.com>
 <20111216085057.3DE4240390@saturn.retrosnub.co.uk>
 <20111216162457.GA5403@kroah.com>
 <4EEB9ED8.8060704@cam.ac.uk>
 <20111216222332.GA6610@kroah.com>
 <4EECBB29.8070102@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4EECBB29.8070102@kernel.org>
List-ID: <linux-iio@vger.kernel.org>

On Sat, Dec 17, 2011 at 03:54:17PM +0000, Jonathan Cameron wrote:
> On 12/16/2011 10:23 PM, Greg KH wrote:

> > Rewriting all probe functions really shouldn't be hard as you have to
> > just change from manipulating this list by-hand, to making a function
> > call.  That sounds like an easy thing to do, and something that should
> > be done, right?

> That plus add a level of indirection to every driver that currently
> has any platform data (which covers the vast majority).  Either
> the array of consumers has to be added to their existing pd which is
> clunky and driver specific or we have another structure with optional
> consumer data and another level of platform data to pass in what the
> driver actually cares about.  Note throughout that we are passing data
> that is completely irrelevant to the driver.  We are doing all this
> to support a usecase that isn't even relevant to many IIO drivers.

FWIW the generic platform data embed thing is what the regulator API is
currently doing, though of course we've got a bunch more data going in
there in the constraints.  This is actually a bit limiting as it means
we need to know how things are glued together at registeration time,
it'd be nice if we were able to add links in separately.
