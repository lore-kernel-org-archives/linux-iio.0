Return-Path: <broonie@sirena.org.uk>
Date: Thu, 7 Apr 2011 02:23:34 +0100
From: Mark Brown <broonie@opensource.wolfsonmicro.com>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: Re: gpio.h interaction with other headers issue on pxa (maybe arm
	in general?)
Message-ID: <20110407012334.GB21071@sirena.org.uk>
References: <4D9C7475.6080900@cam.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4D9C7475.6080900@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

On Wed, Apr 06, 2011 at 03:11:01PM +0100, Jonathan Cameron wrote:

Reflowed into 80 columns for legibility:

> Simply reorder the header includes to have kernel.h before gpio.h
> fixes this, but is it an indication of an underlying problem that
> should have a more general fix?

Seems like a standard missing include issue.  If the GPIO headers need
kernel.h they should include it directly rather than relying on the
other files pulling it in.
