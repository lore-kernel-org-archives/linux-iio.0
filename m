Return-Path: <linus.walleij@linaro.org>
MIME-Version: 1.0
In-Reply-To: <4F3438A5.6050003@kernel.org>
References: <1327837614-24176-1-git-send-email-jic23@kernel.org>
	<1327837614-24176-2-git-send-email-jic23@kernel.org>
	<20120209181056.GA957@kroah.com>
	<4F3411BA.5070401@kernel.org>
	<20120209185754.GA10284@kroah.com>
	<20120209191509.GM3058@opensource.wolfsonmicro.com>
	<20120209191718.GA10999@kroah.com>
	<20120209192054.GN3058@opensource.wolfsonmicro.com>
	<4F3438A5.6050003@kernel.org>
Date: Fri, 10 Feb 2012 02:03:31 +0100
Message-ID: <CACRpkdZMOn2cccGzY+DuT0oscrrN_hC0qGZo3msiMMDs-=76VA@mail.gmail.com>
Subject: Re: [PATCH 1/5] staging:iio:core add in kernel interface mapping and
 getting IIO channels.
From: Linus Walleij <linus.walleij@linaro.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>,
	Greg KH <gregkh@linuxfoundation.org>, linux-iio@vger.kernel.org,
	guenter.roeck@ericsson.com, khali@linux-fr.org, dmitry.torokhov@gmail.com,
	alan@lxorguk.ukuu.org.uk, arnd@arndb.de, maxime.ripard@free-electrons.com,
	thomas.petazzoni@free-electrons.com, zdevai@gmail.com, w.sang@pengutronix.de,
	marek.vasut@gmail.com, Jonathan Cameron <jic23@cam.ac.uk>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On Thu, Feb 9, 2012 at 10:20 PM, Jonathan Cameron <jic23@kernel.org> wrote:
> [Mark]
>> the original use case for IIO was purely for userspace users and
>> what the patch series is doing is adding the ability to use IIO
>> devices from within the kernel.
>
> That was my thinking. =A0Happy to take suggestions for clearer naming!

I would suggest not adding a config option at all but default-enable
the in-kernel interface. To me that part is certainly the key component,
userspace IIO to me is just some obscurity ...

Yours,
Linus Walleij
