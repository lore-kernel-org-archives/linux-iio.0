Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:50492 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965468AbbHKRBc (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 11 Aug 2015 13:01:32 -0400
In-Reply-To: <55C9E8B4.2090605@metafoo.de>
References: <1438174469-19054-1-git-send-email-vladimir.barinov@cogentembedded.com> <1438174617-19143-1-git-send-email-vladimir.barinov@cogentembedded.com> <55C642C1.4070105@kernel.org> <55C9E8B4.2090605@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: [PATCH v3 1/7] iio: adc: hi8435: Holt HI-8435 threshold detector
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Date: Tue, 11 Aug 2015 18:01:02 +0100
To: Lars-Peter Clausen <lars@metafoo.de>,
	Jonathan Cameron <jic23@kernel.org>,
	Vladimir Barinov <vladimir.barinov@cogentembedded.com>
CC: Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, cory.tusar@pid1solutions.com
Message-ID: <A0C078FC-E1C5-42D1-A384-51F202E6BBFF@jic23.retrosnub.co.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



On 11 August 2015 13:21:08 BST, Lars-Peter Clausen <lars@metafoo.de> wrote:
>On 08/08/2015 07:56 PM, Jonathan Cameron wrote:
>> On 29/07/15 13:56, Vladimir Barinov wrote:
>>> Add Holt threshold detector driver for HI-8435 chip
>>>
>>> Signed-off-by: Vladimir Barinov
><vladimir.barinov@cogentembedded.com>
>> Because it usually reads better that way, I review from the bottom.
>> Might make more sense if you read the comments that way around ;)
>> 
>> I'm going to guess that the typical usecase for this device is in
>realtime
>> systems where polling gives a nice predictable timing (hence the lack
>of any
>> interrupt support).  These typically operate as 'scanning' devices
>> (e.g. you update all state at approximately the same time, by reading
>> one input after another in some predefined order).
>> 
>> Does the use of events actually map well to this use case?  You are
>taking
>> something that (other than the results being a bit different) is
>basically
>> a digital I/O interface and mapping it (sort of) to an interrupt chip
>> when it isn't nothing of the sort.
>> 
>> I'd like more opinions on this, but my gut reaction is that we would
>> be better making the normal buffered infrastructure handle this data
>> properly rather than pushing it through the events intrastructure.
>> 
>> Your solution is neat and tidy in someways but feels like it is
>mashing
>> data into a particular format.
>> 
>> To add to the complexity we could have debounce logic.  If we mapped
>to a
>> fill the buffer with a scan mode, how would we handle this?
>> My guess is that it would simply delay transistions.  Perhaps we even
>> support reading both the value right now and the debounced value if
>that
>> is possible?
>> 
>> However, here the debounce is all software.  To my mind, move this
>into
>> userspace entirely. We aren't dealing with big data here so it's
>hardly
>> going to be particularly challenging.
>> 
>> So my gut feeling is definitely we need to make the buffer
>infrastructure
>> handle 1 bit values (in groups) then push this data out that way.
>> 
>> Still I would like other opinions on this!
>
>Having thought about this a bit having support for event triggers seems
>like
>a nice addition to me. When you think about it it is not too different
>from
>buffer triggers. Some devices are able to generate their own trigger
>events
>using a IRQ, others might need a software controlled trigger. You could
>argue that the same is true for events. Having support for software
>based
>event triggers e.g. allows support for devices which have events and
>have an
>IRQ, but where the IRQ is simply not connected.
>
>Whether it makes sense for this device is a different question though I
>guess.
>
>Since this is a threshold detector events seem to be the right approach
>to
>me. You could have similar hardware which actually generates IRQs, so
>you'd
>have the same interface. Additionally if we expects changes only to
>occur at
>a much lower rate than the polling rate only sending something to
>userspace
>when it changes keeps the amount of data to transfer lower. On the
>other
>hand if changes happen a lot using the event based approach would
>certainly
>create a higher load. And another thing to consider is that some
>applications might be interested in getting the raw data. So in
>conclusion,
>I don't know ;). Both approaches seem sensible enough to me.

I am coming around to the view that events make some sense in this case.

Definitely also want 1 bit channel support in IIO though.
>
>[...]
>>> static void hi8435_debounce_work(struct work_struct *work)
>>> +{
>>> +	struct hi8435_priv *priv = container_of(work, struct hi8435_priv,
>>> +						work.work);
>>> +	struct iio_dev *idev = spi_get_drvdata(priv->spi);
>>> +	u32 val;
>>> +	int ret;
>>> +
>>> +	ret = hi8435_readl(priv, HI8435_SO31_0_REG, &val);
>>> +	if (ret < 0)
>>> +		return;
>>> +
>>> +	if (val == priv->debounce_val)
>>> +		hi8435_iio_push_event(idev, val);
>>> +	else
>>> +		dev_warn(&priv->spi->dev, "filtered by software debounce");
>> Definitely not.  Warning every time a standard event occurs?  Not
>> a good idea.  Use the debug stuff if you want a way of knowing this
>> happened, then it will silent under normal use.
>> 
>>> +}
>>> +
>>> +static irqreturn_t hi8435_trigger_handler(int irq, void *private)
>>> +{
>>> +	struct iio_poll_func *pf = private;
>>> +	struct iio_dev *idev = pf->indio_dev;
>>> +	struct hi8435_priv *priv = iio_priv(idev);
>>> +	u32 val;
>>> +	int ret;
>>> +
>>> +	ret = hi8435_readl(priv, HI8435_SO31_0_REG, &val);
>>> +	if (ret < 0)
>>> +		goto err_read;
>>> +
>>> +	if (priv->debounce_interval) {
>>> +		priv->debounce_val = val;
>>> +		schedule_delayed_work(&priv->work,
>>> +				msecs_to_jiffies(priv->debounce_interval));
>> This is another element that makes me doubt that the event interface
>> is the way to do this.  I'd much rather we pushed the debouncing out
>> to userspace where cleverer things can be done (and more adaptive
>things).
>> Here to keep the event flow low you have to do it in the kernel.
>
>Yes, debouncing should probably not be done in kernel space and the
>debounce
>interval should not be a devicetree property.
>
>> 
>>> +	} else {
>>> +		hi8435_iio_push_event(idev, val);
>>> +	}
>>> +
>>> +err_read:
>>> +	iio_trigger_notify_done(idev->trig);
>>> +
>>> +	return IRQ_HANDLED;
>>> +}
>>> +
>>> +static void hi8435_parse_dt(struct hi8435_priv *priv)
>>> +{
>>> +	struct device_node *np = priv->spi->dev.of_node;
>>> +	int ret;
>>> +
>>> +	ret = of_get_named_gpio(np, "holt,reset-gpios", 0);
>>> +	priv->reset_gpio = ret < 0 ? 0 : ret;
>> Silly question, but can gpio0 exist on a board?  I suspect you
>> may need an additional variable to hold that this request failed
>> rather than using the magic value of 0.
>
>It can, but new stuff should just use the GPIO descriptor API where
>NULL can
>be used to indicate a invalid GPIO.
>
>- Lars

-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
