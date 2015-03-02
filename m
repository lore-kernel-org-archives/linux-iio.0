Return-Path: <ukl@pengutronix.de>
Date: Mon, 2 Mar 2015 17:15:03 +0100
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
To: Daniel Baluta <daniel.baluta@intel.com>
Cc: Roberta Dobrescu <roberta.dobrescu@gmail.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"octavian.purdila@intel.com" <octavian.purdila@intel.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Vlad Dogaru <vlad.dogaru@intel.com>, kernel@pengutronix.de
Subject: Re: [PATCH] iio: accel: mma9551: Check gpiod_to_irq return value
Message-ID: <20150302161503.GE7865@pengutronix.de>
References: <1425292752-7768-1-git-send-email-roberta.dobrescu@gmail.com>
 <CAEnQRZCBt++Ebjd6uwu6mpVCrsZyDxX53mOf4c17T1RUGAsQMA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <CAEnQRZCBt++Ebjd6uwu6mpVCrsZyDxX53mOf4c17T1RUGAsQMA@mail.gmail.com>
List-ID: <linux-iio@vger.kernel.org>

Hello,

On Mon, Mar 02, 2015 at 04:09:52PM +0200, Daniel Baluta wrote:
> On Mon, Mar 2, 2015 at 12:39 PM, Roberta Dobrescu
> <roberta.dobrescu@gmail.com> wrote:
> > The return value of gpiod_to_irq should be checked before giving
> > it to devm_request_threaded_irq in order to not pass an error
> > code in case it fails.
nothing really bad should happen because request_irq with a negative irq
parameter just returns an error I think. So it's not urgent, but still a
good idea to fix.

> > Signed-off-by: Roberta Dobrescu <roberta.dobrescu@gmail.com>
> > Reviewed-by: Vlad Dogaru <vlad.dogaru@intel.com>
It's good habit to point out the commit that introduced the problem. In
this case this would be:

Fixes: c78b91716340 ("iio: add driver for Freescale MMA9551L")

> > ---
> > gpiod_to_irq also appears in the following drivers:
> >         * drivers/iio/accel/bmc150-accel.c
> >         * drivers/iio/accel/kxcjk-1013.c
> >         * drivers/iio/accel/mma9553.c
> >         * drivers/iio/gyro/bmg160.c
> >         * drivers/iio/imu/kmx61.c
> >         * drivers/iio/proximity/sx9500.c,
> >
> > something like this:
> >
> > <code>
> >         ret = gpiod_to_irq(gpio);
> >
> >         dev_dbg(dev, "GPIO resource, no:%d irq:%d\n", desc_to_gpio(gpio), ret);
> >
> >         return ret;
> > </code>
> >
> > The return value of the functions containing the above code is checked,
> > so the only problem would be that the debug message would contain a wrong
> > value for irq in case gpiod_to_irq fails. So it doesn't affects much.
Still worth fixing, isn't it? Also the error isn't handled, but ignored,
like:

	if (client->irq <= 0)
		client->irq = sx9500_gpio_probe(client, data);

	if (client->irq > 0) {
		ret = devm_request_threaded_irq(....

but if an irq is specified (be it by means of a "normal" irq or by
specifying a gpio in the device tree/acpi tables) I expect the driver to
fail probing instead of just behaving as if no irq would be available.
I don't know how this was tested, but I wonder further about

	#define SX9500_GPIO_NAME                "sx9500_gpio"
	...
	devm_gpiod_get_index(dev, SX9500_GPIO_NAME, 0, GPIOD_IN);

If I understand the code correctly that is supposed to look for
"sx9500_gpio-gpio" in the ACPI data. Is this really correct?

> >  drivers/iio/accel/mma9551.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/iio/accel/mma9551.c b/drivers/iio/accel/mma9551.c
> > index 46c3835..b6f3041 100644
> > --- a/drivers/iio/accel/mma9551.c
> > +++ b/drivers/iio/accel/mma9551.c
> > @@ -428,7 +428,11 @@ static int mma9551_gpio_probe(struct iio_dev *indio_dev)
> >                 if (ret)
> >                         return ret;
> >
> > -               data->irqs[i] = gpiod_to_irq(gpio);
> > +               ret = gpiod_to_irq(gpio);
> > +               if (ret < 0)
> > +                       return ret;
I wonder if you should handle 0 as error, too. But even as is:

	Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Thanks
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
