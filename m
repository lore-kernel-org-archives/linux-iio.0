Return-Path: <linus.walleij@linaro.org>
MIME-Version: 1.0
In-Reply-To: <20120130212253.GC9672@opensource.wolfsonmicro.com>
References: <1327837614-24176-1-git-send-email-jic23@kernel.org>
	<1327837614-24176-6-git-send-email-jic23@kernel.org>
	<20120130193350.GA9672@opensource.wolfsonmicro.com>
	<4F26FCE2.1030705@kernel.org>
	<20120130212253.GC9672@opensource.wolfsonmicro.com>
Date: Tue, 31 Jan 2012 09:39:31 +0100
Message-ID: <CACRpkdbeMWRwJtUVT5xS7FrsvPZg4tSCVQq6eh9JAjq6_3QYQg@mail.gmail.com>
Subject: Re: [PATCH 5/5] stargate2: example of map configuration for iio to
 hwmon example.
From: Linus Walleij <linus.walleij@linaro.org>
To: Mark Brown <broonie@opensource.wolfsonmicro.com>,
	Russell King - ARM Linux <linux@arm.linux.org.uk>, Sascha Hauer <s.hauer@pengutronix.de>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org, greg@kroah.com,
	guenter.roeck@ericsson.com, khali@linux-fr.org, dmitry.torokhov@gmail.com,
	alan@lxorguk.ukuu.org.uk, arnd@arndb.de, maxime.ripard@free-electrons.com,
	thomas.petazzoni@free-electrons.com, zdevai@gmail.com, w.sang@pengutronix.de,
	marek.vasut@gmail.com, Jonathan Cameron <jic23@cam.ac.uk>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On Mon, Jan 30, 2012 at 10:22 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Mon, Jan 30, 2012 at 08:26:10PM +0000, Jonathan Cameron wrote:
>> On 01/30/2012 07:33 PM, Mark Brown wrote:
>> > On Sun, Jan 29, 2012 at 11:46:54AM +0000, Jonathan Cameron wrote:
>
>> >> +static struct iio_map max1363_consumer_map[] =3D { + =A0 =A0 =A0 =A0=
{ +
>> >> .adc_channel_label =3D "AIN1", + =A0 =A0 =A0 =A0 =A0 =A0 .consumer_de=
v =3D
>> >> &iio_hwmon_test.dev, + =A0 =A0 =A0 =A0 =A0 =A0 .consumer_channel =3D =
"testchan1",
>
>> > I do think it's better to use dev_name here rather than a struct
>> > device pointer - for several of the buses it's not actually
>> > possible to get a struct device until a device has been
>> > instantiated which isn't helpful for setting up the mappings.
>
>> We allow both. =A0In cases like this where the dev pointer is explicitly
>> available what gain do we get from not using it?
>
> You avoid user confusion from having two ways of doing the same thing
> and you save a little complexity in the implementation. =A0The user
> confusion does happen in practice.

The clockdev API is stricter and only allows for names I noticed.

So I guess this pattern comes from the regulator framework
struct regulator_consumer_supply design pattern initially.

We allow both struct device * in regulators and pin muxes.
So, not having it for ADCs could be confusing as well.

But we should then try to rid it from the kernel at large, no big deal,
I have only one in-kernel user of this ATM I think so I can kill it off fro=
m
the pin control API if you think you can kill it from regulators.

I just want to make sure that this is the direction we want to go...

Yours,
Linus Walleij
