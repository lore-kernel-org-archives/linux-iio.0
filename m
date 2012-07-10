Return-Path: <anish198519851985@gmail.com>
MIME-Version: 1.0
In-Reply-To: <4FF72C00.3070300@metafoo.de>
References: <CAK7N6voPsDGJLoh71Kgcz=bnWDE4QYmXjOrMv0x+bN7RTCHF3g@mail.gmail.com>
	<4FF6E766.7000503@cam.ac.uk>
	<1341593155.1533.24.camel@anish-Inspiron-N5050>
	<4FF72C00.3070300@metafoo.de>
Date: Tue, 10 Jul 2012 13:59:07 +0530
Message-ID: <CAK7N6vpwgHcNF7wj=eXMdKZUcX9anY7oCvPeZdG1ePEREaCDcg@mail.gmail.com>
Subject: Re: adc-jack-driver opinion related to IIO
From: anish singh <anish198519851985@gmail.com>
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Jonathan Cameron <jic23@cam.ac.uk>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Fri, Jul 6, 2012 at 11:48 PM, Lars-Peter Clausen <lars@metafoo.de> wrote:
> On 07/06/2012 06:45 PM, anish kumar wrote:
>> On Fri, 2012-07-06 at 14:25 +0100, Jonathan Cameron wrote:
>>> On 7/6/2012 1:00 PM, anish singh wrote:
>>>> Hello Jonathan,
>>>>
>>>> I would be extremely happy if I can get your opinion on this.
>>>>
>>>> Recently Myungjoo Ham had posted Extcon: adc-jack driver patch.
>>>>
>>>> Description of this driver:
>>>> This is basically a Headset(jack) driver.Once the headset is inserted
>>>> a irq_handler is called and in this handler we have a callback(this
>>>> callback calls into pmic driver to get the adc value) to get
>>>> the adc value to determine the kind of headset: This headset could
>>>> be headset with mic, headset without mic or headset with
>>>> keys(volume-up/down) attached to it.One we have found out the kind
>>>> of headset we use extcon framework to notify the other interested drivers or
>>>> userspace that a headset with so and so capabilities has been inserted.
>>>>
>>>> Question:
>>>> Does this driver fall into IIO as pointed by Mark Brown in his review comments?
>>> The driver itself probably doesn't, but the adc part does in that IIO
>>> provides a means of talking to the relevant adc.
>>>>
>>>> Why do we need to use IIO to get the adc value?As for different boards the
>>>> method of getting adc is different.How does IIO help in this?
>>> Ultimately, IIO in this case is acting as an infrastructure for ALL
>>> adcs. E.g. for different boards you'll need a mapping to tell it which
>>> adc channel is connected but that is it.  Hence you don't need a
>>> specific callback for each pmic as you will be using generic interfaces
>>> to query it.
>> After having a brief glance at IIO below is my understanding:
>> IIO is used to provide standard interfaces in the form of sysfs to
>> userspace _ONLY_.
>>
>> My requirement:
>> ADC-JACK-Driver should get the adc value from other driver i.e. PMIC
>> driver.Here the requirement is communication between two drivers in
>> kernel.Can IIO be used here?
>>
>> I had a look at drivers/staging/iio/Documentation/Overview.txt and some
>> ADC drivers.
>
> Hi,
>
> There is a new experimental in kernel API, which lets you write IIO clients
> in the kernel.
>
> See: drivers/iio/inkern.h
> and drivers/staging/iio/iio_hwmon.c
Thanks for this.So below is my understanding:
1.The driver which will provide adc value should first register itself with IIO
core by specifiying it channels(struct iio_map should be used) and what
values we can expect from it.
2.The driver which is interested in reading the adc values should call
iio_channel_get
to get the channel.
3.Once the channel is obtained we can call iio_st_read_channel_raw function to
read the values.

Is my understanding right or I am completely lost here?
>
> - Lars
>
