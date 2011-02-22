Return-Path: <broonie@sirena.org.uk>
Date: Tue, 22 Feb 2011 21:55:55 +0000
From: Mark Brown <broonie@opensource.wolfsonmicro.com>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: Jean Delvare <khali@linux-fr.org>, Andrew Chew <AChew@nvidia.com>,
	chinyeow.sim.xt@renesas.com, gregkh@suse.de,
	devel@driverdev.osuosl.org, linux-iio@vger.kernel.org
Subject: Re: [RFC PATCH] staging: ak8975: add platform data.
Message-ID: <20110222215552.GA28740@sirena.org.uk>
References: <1297764627-21077-1-git-send-email-chinyeow.sim.xt@renesas.com> <643E69AA4436674C8F39DCC2C05F763816BD96CFB5@HQMAIL03.nvidia.com> <4D628E66.5090900@cam.ac.uk> <20110222102955.52be2b94@endymion.delvare> <4D63AD81.5080903@cam.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4D63AD81.5080903@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

On Tue, Feb 22, 2011 at 12:35:13PM +0000, Jonathan Cameron wrote:

> I thought this actually allowed for gpio's but right now can't figure out how
> to handle them.  What it definitely does handle cleanly is devices with multiple
> irq's.

> You basically get to query for resources by name so can pass lots of 'platform data'
> type stuff without having to define a specific structure for passing it in.

There's no standard support for GPIOs as resources - this is always done
using platform data these days.
