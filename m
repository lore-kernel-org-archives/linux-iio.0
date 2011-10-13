Return-Path: <broonie@sirena.org.uk>
Date: Thu, 13 Oct 2011 15:32:24 +0100
From: Mark Brown <broonie@opensource.wolfsonmicro.com>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	zdevai@gmail.com, linus.walleij@linaro.org
Subject: Re: [PATCH] staging:iio:proof of concept in kernel interface.
Message-ID: <20111013143224.GO1098@sirena.org.uk>
References: <1318333383-17663-1-git-send-email-jic23@cam.ac.uk>
 <1318333383-17663-2-git-send-email-jic23@cam.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1318333383-17663-2-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

On Tue, Oct 11, 2011 at 12:43:03PM +0100, Jonathan Cameron wrote:

> +struct iio_dev *iio_find_dev(const char *name);
> +void iio_release_dev(struct iio_dev *indio_dev);

This looks like it should really be clk style with a struct device and a
back end interface that deals with mapping the provider to consumers at
runtime.

> +	/* read from channel 1 and exit */
> +	ret = indio_dev->info->read_raw(indio_dev, &indio_dev->channels[0], &val, &val2, 0);

I guess an actual implementation would have wrappers for doing the
indirections rather than having users peer into the ops table directly?
