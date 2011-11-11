Return-Path: <linus.walleij@linaro.org>
MIME-Version: 1.0
In-Reply-To: <1320680681-5635-4-git-send-email-jic23@kernel.org>
References: <1320680681-5635-1-git-send-email-jic23@kernel.org>
	<1320680681-5635-4-git-send-email-jic23@kernel.org>
Date: Fri, 11 Nov 2011 16:42:04 +0100
Message-ID: <CACRpkdbKPL6=t-YGSNZdb2aGXERvk6zPkb40ytOMbYXLQ7H2Vg@mail.gmail.com>
Subject: Re: [PATCH 3/5] IIO:CORE add in kernel interface mapping and getting
 IIO channels.
From: Linus Walleij <linus.walleij@linaro.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	guenter.roeck@ericsson.com, khali@linux-fr.org, dmitry.torokhov@gmail.com,
	broonie@opensource.wolfsonmicro.com, gregkh@suse.de, alan@lxorguk.ukuu.org.uk,
	arnd@arndb.de, lars@metafoo.de, maxime.ripard@free-electrons.com,
	lm-sensors@lm-sensors.org, thomas.petazzoni@free-electrons.com,
	zdevai@gmail.com, Jonathan Cameron <jic23@cam.ac.uk>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On Mon, Nov 7, 2011 at 4:44 PM, Jonathan Cameron <jic23@kernel.org> wrote:

> From: Jonathan Cameron <jic23@cam.ac.uk>
>
> Two elements here:
> * Map as defined in include/linux/iio/inkern.h
> * Matching code to actually get the iio_dev and channel
> that we want from the global list of IIO devices.
>
> Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>

Overall this is what we want:
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Thanks,
Linus Walleij
