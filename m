Return-Path: <gregkh@linuxfoundation.org>
Date: Fri, 24 Feb 2012 12:07:12 -0800
From: Greg KH <gregkh@linuxfoundation.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, guenter.roeck@ericsson.com,
	khali@linux-fr.org, dmitry.torokhov@gmail.com,
	broonie@opensource.wolfsonmicro.com, alan@lxorguk.ukuu.org.uk,
	arnd@arndb.de, linus.walleij@linaro.org,
	maxime.ripard@free-electrons.com,
	thomas.petazzoni@free-electrons.com, zdevai@gmail.com,
	w.sang@pengutronix.de, marek.vasut@gmail.com,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: Re: [PATCH 6/6] stargate2: example of map configuration for iio to
 hwmon example.
Message-ID: <20120224200712.GA24588@kroah.com>
References: <1329335285-31006-1-git-send-email-jic23@kernel.org>
 <1329335285-31006-7-git-send-email-jic23@kernel.org>
 <4F3C1EAC.9090809@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4F3C1EAC.9090809@kernel.org>
List-ID: <linux-iio@vger.kernel.org>

On Wed, Feb 15, 2012 at 09:07:56PM +0000, Jonathan Cameron wrote:
> On 02/15/2012 07:48 PM, Jonathan Cameron wrote:
> > From: Jonathan Cameron <jic23@cam.ac.uk>
> > 
> > Do not commit.
> Whilst this example was never meant to be committed, the obvious flaw
> is that max1363 doesn't actually support these interfaces because
> I left one patch out. Lets call it 5.5 and stick it before this one.

Huh?  I don't understand what you mean here, should I not apply this
one?

confused,

greg k-h
