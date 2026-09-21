Received: from mail-43172.protonmail.ch (mail-43172.protonmail.ch [185.70.43.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0AD3353A8E;
	Mon, 21 Sep 2026 05:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789968919; cv=none; b=kmtGv2/oqMDW+sDNf6c7Ioj+yO/fBRsIiixpH+e6RFMTa+CA438+3/JU050AYSqb2gdmzjL6xBGTB9V10sQOsamvFxZfRWsd5LEbbN1DZi/QJ4gT+fOCtFH3+Vd9qSeUANB1NTeF+plYnMpSMFaGhblpeQG1Lyxep2gNU6jzfyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789968919; c=relaxed/simple;
	bh=zh83OoNBxSi4NwznNu3yqEEjAZC/P1eMVO44h6RQlTg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=j3otfDAr5dmfYiMUS2W9ZpOcmpr4Yv97a037+k8Jei4ueJtgTl9bdCun/LyL3YfDwOYENwf/5+uETL6PT1kHqabkclto4IBPqRdvEWcW2Vq/eRKqTX1ZXZOEkj6T1B2IHnY5FON91x9fuWGIIk7PQcO+kXc8oZ9XE53Klu0Ag5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=iscnauc2; arc=none smtp.client-ip=185.70.43.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="iscnauc2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail; t=1789968914; x=1790228114;
	bh=8crlbQymdmkrzwA9LemJUmjDmHSjnoUEJlDLbHUk1gc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=iscnauc2HhOCHZ1pcxj3rwdTLqsrliFnA9fiJq0QzITbhdNFvFtJvjzmNEbJjAhfX
	 lVBhJpSSbIzWOlHJSYbVXYD7tYq7eQQzZc3T9TwctFR92X5qxN9K2a/QvmDehR4H6x
	 ewu/vid5hjB3zSGxHGKSzi+AVOIkauuspH8W2yXzrXTp3KzsnKggBL5IMSFut82vAZ
	 N7y0cfTcqMNu9aLEb5t0U4AgMUt+fdTRRLy72qPVkSMWVnnuUuSsbzC0h8zpmD8PZC
	 Gen8nJdrbMNqSDgX8JdovnmwREEYC5r4AcxIBN36+LiQXv7/3/5zO/ym2Sh8oIWZ4W
	 hOcQPqjCHHMKw==
X-Pm-Submission-Id: 4hpBl447pPz1DDWh
From: Esben Haabendal <esben@geanix.com>
To: "Jonathan Cameron" <jic23@kernel.org>
Cc: <sashiko-reviews@lists.linux.dev>,  <robh@kernel.org>,
  <conor+dt@kernel.org>,  <devicetree@vger.kernel.org>,
  <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v9 10/10] iio: accel: mma8452: Support interrupt sharing
In-Reply-To: <20260921015115.4c7d79f3@jic23-hlaptop>
References: <20260916-mma8452-open-drain-v9-0-0dd24fa2f3d7@geanix.com>
	<20260916-mma8452-open-drain-v9-10-0dd24fa2f3d7@geanix.com>
	<l9LG3al0xmawstyXcDwD8OhOBMwn13q6oz0NvCPy4kL0lA4DX5biMlUWcvt9Wwu1AiyugOvUZgQfnFJ4dvuvbA==@protonmail.internalid>
	<20260916083119.03A8F1F000FF@smtp.kernel.org>
	<87se38754p.fsf@geanix.com>
	<DCSg94lOVof3xt7nVMHqUJ4g_0LHFg9-B1_SPzr6YW6Q76JvKW9Wi7VQHgO2chZTHzFjCa--kqtVp7lZLsx5Qw==@protonmail.internalid>
	<20260921015115.4c7d79f3@jic23-hlaptop>
Date: Mon, 21 Sep 2026 07:35:11 +0200
Message-ID: <87bj9r9ng0.fsf@geanix.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Jonathan Cameron" <jic23@kernel.org> writes:

> On Thu, 17 Sep 2026 08:40:06 +0200
> Esben Haabendal <esben@geanix.com> wrote:
>
>> <sashiko-bot@kernel.org> writes:
>>
>> > Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
>> > - [Critical] iio: accel: mma8452: Interrupt storm livelock when IRQ fires during RPM_SUSPENDING
>> > - [High] iio: accel: mma8452: Invalid I2C access during system suspend due to mishandled -EINVAL
>> > - [Medium] iio: accel: mma8452: Race condition in probe error path due to pm_runtime_disable() before free_irq()
>> > --
>> >
> So far we haven't enabled sashiko emails to the linux-iio list
> (will probably move to that fairly soon) so fun side effect is this
> reply was shouting into the void - except that b4 picks it up.
>
> +CC linux-iio. I'm too lazy to add everyone by hand who was on original thread.
>
> Key here is looks like you already plan a v10.

Yes, sashiko-bot clearly catches a lot of valid problems. Also flags
some things that is not valid. And for a patch series with many
versions, like this one, these invalid findings keeps getting repeated.

Are there some guidelines how to handle this? Is it enough to write a
reply to the list(s) explaining why the finding is invalid on the first
report by sashiko-bot, or do we have to repeat every time that
sashiko-bot repeats the rebuted finding?

>> > commit bf19c63685f6fff116a3a5358196fd66dff6090a
>> > Author: Esben Haabendal <esben@geanix.com>
>> >
>> > iio: accel: mma8452: Support interrupt sharing
>> >
>> > This commit adds support for shared interrupts to the mma8452 driver. It
>> > modifies the interrupt handler to check the runtime PM status and ignores
>> > the interrupt if the device is suspended. It also updates the runtime
>> > suspend and resume paths to properly disable and restore interrupt sources.
>> >
>> >> diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
>> >> index 5aea6bf3312af..2a980c0c2e03a 100644
>> >> --- a/drivers/iio/accel/mma8452.c
>> >> +++ b/drivers/iio/accel/mma8452.c
>> >
>> > [ ... ]
>> >
>> >> @@ -1086,15 +1088,28 @@ static irqreturn_t mma8452_interrupt(int irq, void *p)
>> >>  {
>> >>  	struct iio_dev *indio_dev = p;
>> >>  	struct mma8452_data *data = iio_priv(indio_dev);
>> >> +	struct device *dev = &data->client->dev;
>> >>  	irqreturn_t ret = IRQ_NONE;
>> >> +	int pm_status;
>> >>  	int src;
>> >>
>> >> +	pm_status = pm_runtime_get_if_active(dev);
>> >> +	if (pm_status == 0)
>> >> +		return IRQ_NONE; /* device is powered down */
>> >
>> > [Severity: Critical]
>> > If the device asserts its level-triggered interrupt when the PM core is
>> > transitioning the device to RPM_SUSPENDING (e.g., when the autosuspend
>> > timer expires), pm_runtime_get_if_active() will return 0.
>> >
>> > Does returning IRQ_NONE without clearing the hardware interrupt here cause
>> > a permanent interrupt storm? Since the IRQ line is shared and unmasked upon
>> > return, the still-asserted hardware interrupt might immediately re-trigger
>> > the handler, potentially starving the worker thread that executes
>> > mma8452_runtime_suspend() and hard-locking the system.
>>
>> This should be handled by the disable of all interrupt sources (clearing
>> CTRL_REG4) in mma8452_runtime_suspend().
>>
>> > [Severity: High]
>> > During system suspend, pm_runtime_force_suspend() disables runtime PM,
>> > which increments the disable depth. If a shared interrupt fires during this
>> > window, pm_runtime_get_if_active() returns -EINVAL.
>> >
>> > Since this check only catches pm_status == 0, does this allow the handler
>> > to proceed and perform I2C reads on unpowered hardware? Per subsystem
>> > guidelines, should this check for pm_status <= 0 instead?
>>
>> If we bail out on pm_status <= 0, the driver would not work on systems
>> with CONFIG_PM not enabled.
>>
>> In order to handle the difference betwen the different reasons for
>> -EINVAL, it would seem like we would need some #ifdef CONFIG_PM in here.
>> Do we really want to do that?
>
> That if_enabled() function is a pain.  Definitely not ifdef but
> how about
>
>  if (IS_ENABLED(CONFIG_PM) && ret < 0) or something like that?

That should work. Now, in this case, do we want to report IRQ_HANDLED or
IRQ_NONE? We obviosly did not really handle it, but we also don't know
if the irq was for this device.

>> >> +
>> >> +	/*
>> >> +	 * pm_status is now 1 or -EINVAL. If pm_status==1, runtime PM is enabled
>> >> +	 * and device is RPM_ACTIVE. If pm_status==-EINVAL, runtime PM is
>> >> +	 * disabled (e.g. CONFIG_PM not enabled), and we can/must assume device
>> >> +	 * is active.
>> >> +	 */
>> >> +
>> >>  	src = i2c_smbus_read_byte_data(data->client, MMA8452_INT_SRC);
>> >
>> > [ ... ]
>> >
>> >> @@ -1771,11 +1790,12 @@ static void mma8452_remove(struct i2c_client *client)
>> >>
>> >>  	iio_device_unregister(indio_dev);
>> >>
>> >> -	pm_runtime_disable(dev);
>> >> -	pm_runtime_set_suspended(dev);
>> >> -
>> >>  	if (client->irq)
>> >>  		free_irq(client->irq, indio_dev);
>> >> +	/* No irq will fire beyond this point */
>> >> +
>> >> +	pm_runtime_disable(dev);
>> >> +	pm_runtime_set_suspended(dev);
>> >
>> > [Severity: Medium]
>> > This correctly fixes the race in mma8452_remove() by moving free_irq()
>> > before pm_runtime_disable(), but does the same race still exist in the
>> > mma8452_probe() error path?
>> >
>> > If mma8452_probe() fails after pm_runtime_enable(), it jumps to the
>> > runtime_suspend label:
>> >
>> >   mma8452_probe() {
>> >       /* ... */
>> >   runtime_suspend:
>> >       pm_runtime_disable(dev);
>> >       pm_runtime_set_suspended(dev);
>> >
>> >   free_irq:
>> >       if (client->irq)
>> >           free_irq(client->irq, indio_dev);
>> >       /* ... */
>> >   }
>> >
>> > If a shared interrupt fires between pm_runtime_disable() and free_irq(),
>> > could the handler attempt to access unpowered hardware?
>>
>> I will apply the same reordering in mma8452_probe().
>
> Sounds good to me

I will send it when I have the above question resolved.

/Esben
