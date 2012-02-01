Return-Path: <linus.walleij@linaro.org>
MIME-Version: 1.0
In-Reply-To: <4F26FD82.0@kernel.org>
References: <1327837614-24176-1-git-send-email-jic23@kernel.org>
	<1327837614-24176-2-git-send-email-jic23@kernel.org>
	<20120130202226.GB9672@opensource.wolfsonmicro.com>
	<4F26FD82.0@kernel.org>
Date: Wed, 1 Feb 2012 20:58:48 +0100
Message-ID: <CACRpkdYRTHH4wLw7RWJEY5zpG7rt9mQKs7rXmjuuA9Ww07JT-w@mail.gmail.com>
Subject: Re: [PATCH 1/5] staging:iio:core add in kernel interface mapping and
 getting IIO channels.
From: Linus Walleij <linus.walleij@linaro.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-iio@vger.kernel.org,
	greg@kroah.com, guenter.roeck@ericsson.com, khali@linux-fr.org,
	dmitry.torokhov@gmail.com, alan@lxorguk.ukuu.org.uk, arnd@arndb.de,
	maxime.ripard@free-electrons.com, thomas.petazzoni@free-electrons.com,
	zdevai@gmail.com, w.sang@pengutronix.de, marek.vasut@gmail.com,
	Jonathan Cameron <jic23@cam.ac.uk>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On Mon, Jan 30, 2012 at 9:28 PM, Jonathan Cameron <jic23@kernel.org> wrote:
> On 01/30/2012 08:22 PM, Mark Brown wrote:
>> On Sun, Jan 29, 2012 at 11:46:50AM +0000, Jonathan Cameron wrote:
>>
>>> + =A0 =A0mutex_lock(&iio_map_list_lock); + =A0 =A0 =A0 while ((maps[i].=
consumer_dev
>>> !=3D NULL) || + =A0 =A0 =A0 =A0 =A0 =A0 =A0 (maps[i].consumer_dev_name =
!=3D NULL)) {
>>
>> I'd suggest just dropping the struct device - the reason we support
>> the struct device directly in the regulator API is that we
>> originally had only a struct device and kept the code around as a
>> transition measure (though now it's so old we should be able to
>> kill it off). =A0This would simplify the code and the interface a
>> bit.
>
> Ah, that explains your comment on the 5th patch. =A0Alright, I'll let thi=
s
> sit for a few days and if no one comes up with a good reason not to
> we'll go with just the dev_name option.

I've just deleted the yse of struct device * from the pin control
subsystem and I bet ark will have it deleted from regulator_consumer
before long, so just let it go :-)

Thanks,
Linus Walleij
