Return-Path: <jic23@kernel.org>
Message-ID: <4F30466C.8070101@kernel.org>
Date: Mon, 06 Feb 2012 21:30:20 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Linus Walleij <linus.walleij@linaro.org>
CC: Mark Brown <broonie@opensource.wolfsonmicro.com>,
 linux-iio@vger.kernel.org, greg@kroah.com, guenter.roeck@ericsson.com,
 khali@linux-fr.org, dmitry.torokhov@gmail.com, alan@lxorguk.ukuu.org.uk,
 arnd@arndb.de, maxime.ripard@free-electrons.com,
 thomas.petazzoni@free-electrons.com, zdevai@gmail.com,
 w.sang@pengutronix.de, marek.vasut@gmail.com,
 Jonathan Cameron <jic23@cam.ac.uk>
Subject: Re: [PATCH 1/5] staging:iio:core add in kernel interface mapping
 and getting IIO channels.
References: <1327837614-24176-1-git-send-email-jic23@kernel.org> <1327837614-24176-2-git-send-email-jic23@kernel.org> <20120130202226.GB9672@opensource.wolfsonmicro.com> <4F26FD82.0@kernel.org> <CACRpkdYRTHH4wLw7RWJEY5zpG7rt9mQKs7rXmjuuA9Ww07JT-w@mail.gmail.com>
In-Reply-To: <CACRpkdYRTHH4wLw7RWJEY5zpG7rt9mQKs7rXmjuuA9Ww07JT-w@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 02/01/2012 07:58 PM, Linus Walleij wrote:
> On Mon, Jan 30, 2012 at 9:28 PM, Jonathan Cameron <jic23@kernel.org> wrote:
>> On 01/30/2012 08:22 PM, Mark Brown wrote:
>>> On Sun, Jan 29, 2012 at 11:46:50AM +0000, Jonathan Cameron wrote:
>>>
>>>> +    mutex_lock(&iio_map_list_lock); +       while ((maps[i].consumer_dev
>>>> != NULL) || +               (maps[i].consumer_dev_name != NULL)) {
>>>
>>> I'd suggest just dropping the struct device - the reason we support
>>> the struct device directly in the regulator API is that we
>>> originally had only a struct device and kept the code around as a
>>> transition measure (though now it's so old we should be able to
>>> kill it off).  This would simplify the code and the interface a
>>> bit.
>>
>> Ah, that explains your comment on the 5th patch.  Alright, I'll let this
>> sit for a few days and if no one comes up with a good reason not to
>> we'll go with just the dev_name option.
> 
> I've just deleted the yse of struct device * from the pin control
> subsystem and I bet ark will have it deleted from regulator_consumer
> before long, so just let it go :-)
> 
struct device * use removed from IIO, but I won't be posting just yet
as something has borked my i2c that'll need tracking down before I can
test an updated version.

For reference in the meantime, the other change is that the
iio_device_unregister sets the info pointer to NULL, thus providing
a convenient way of knowing the parent device has gone away without
i think allowing for any raceconditions (this will happen before the
bus unregister which was what was causing me trouble).

Jonathan
