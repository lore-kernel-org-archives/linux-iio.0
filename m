Return-Path: <festevam@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20150305071252.GA8062@pengutronix.de>
References: <1425369498-25541-1-git-send-email-mpa@pengutronix.de>
	<1425369498-25541-2-git-send-email-mpa@pengutronix.de>
	<2620642.Qp1W4O8uh6@wuerfel>
	<20150305071252.GA8062@pengutronix.de>
Date: Fri, 6 Mar 2015 09:53:41 -0300
Message-ID: <CAOMZO5BJC3LuncjXcV5Gp5rzx-KAZEEk=cinX1y5zOomf_Le5w@mail.gmail.com>
Subject: Re: [PATCH v7 1/8] ARM: dt: Binding documentation for imx25 ADC/TSC
From: Fabio Estevam <festevam@gmail.com>
To: Markus Pargmann <mpa@pengutronix.de>
Cc: Arnd Bergmann <arnd@arndb.de>, Shawn Guo <shawn.guo@linaro.org>,
	Samuel Ortiz <sameo@linux.intel.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>, Peter Meerwald <pmeerw@pmeerw.net>, Hartmut Knaack <knaack.h@gmx.de>,
	Denis Carikli <denis@eukrea.com>, =?UTF-8?B?RXJpYyBCw6luYXJk?= <eric@eukrea.com>,
	Sascha Hauer <kernel@pengutronix.de>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Lee Jones <lee.jones@linaro.org>,
	linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Thu, Mar 5, 2015 at 4:12 AM, Markus Pargmann <mpa@pengutronix.de> wrote:

> There are no other registers in this range. The tcq and gcq devices can
> not be used outside of the tsadc. gcq and tcq are identical units so it
> may work to use both of them as gcq for example but nothing else.
>
> It may work to have this as single IIO device. However this would be a
> major rework of this series. There are a lot less users of imx25 than
> imx6 for example. And of these users barely anyone uses this unit at
> all. I really would like to get these drivers mainline so others can use
> it. But after 1 year and 7 versions of this series I don't want to put
> a lot of work into these drivers. I think there are other components in
> the kernel where the time is better used.

I agree with Markus here. It would be really nice to have touchscreen
support running in mainline kernel on mx25.
