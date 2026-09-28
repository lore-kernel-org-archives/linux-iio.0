Received: from mail-43170.protonmail.ch (mail-43170.protonmail.ch [185.70.43.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AAA449159C
	for <linux-iio@vger.kernel.org>; Mon, 28 Sep 2026 10:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790590568; cv=none; b=KwG3S/bIcsWcFKZJJMMDAxGICkeTUwZRv3Q33XuXUXbK7X4PR/OTJilsuseOXa3bzO80DFpKYdhwQDAvgh/drMkINz4Cktfx+UgOMH0t0la/Q9ZwHiQtwMORoJczjBRroLgLsCOpEVaGL+hHJty0VwqydZVvpoOE5udQoVA2sDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790590568; c=relaxed/simple;
	bh=JOEouGEyUwIUSQ+6E8KbBz+7jLfmhZ7J6dyROOQfk78=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YbetcoN/e+WApW0vbEf3+I8PAE1lSalB5nvO7qH9Jw2CgKrP8TTuEr/mF8Aj4ROWu68bjP9PA30RJkV1t3O8V4HJNF3LJDCVDnSdtqlCSDIL58l9dOCWLOWbVB3Kmhtb17aIsLC9XT8ro6syIMhNeCLokW9pzc3GeaA05EOuXyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=Ss4FoEt/; arc=none smtp.client-ip=185.70.43.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="Ss4FoEt/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail; t=1790590560; x=1790849760;
	bh=VrZvQ2kXf4DgXVeEHK3zh5ari2yV1djBu4RKuh3f2Ko=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=Ss4FoEt/kcSeZuD4FVj2BFCiBGZoS59cQVCnBUyLX9QjGBvwv0MwrhyR7cObAwYrU
	 HVV233QCnA6kExyXccjEN4ITIdlWdxKfOOqO6BzbEW1oB/t9/nHoB2Qbe52B6CQDNE
	 hvCCwE8B9LTEz8s+AvfciAwl0SCjowpUjPKv6IvVPgEHTiNbnEiJc/GLXqaA+do1ex
	 DPk3YgtzxwN0AYVYmQBmvoLkE7dICuXN7yil7dYst0jG5iuYjmRC0WdsuAjg/XO8kA
	 j9uDDh/nGaa0g7AgqBDAqC7Mf7DHrL/GAIjrfSKLy2HHjraw5nhGGlhdFKvOrYmD6q
	 /LzwX/duBjhxA==
X-Pm-Submission-Id: 4htcdp0jlZz2ScWP
From: Esben Haabendal <esben@geanix.com>
To: "Andy Shevchenko" <andriy.shevchenko@intel.com>
Cc: "Jonathan Cameron" <jic23@kernel.org>,  "Lars-Peter Clausen"
 <lars@metafoo.de>,  "Rob Herring" <robh@kernel.org>,  "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>,  "Conor Dooley" <conor+dt@kernel.org>,
  "Martin Kepplinger" <martink@posteo.de>,  "Sean Nyekjaer"
 <sean@geanix.com>,  "David Lechner" <dlechner@baylibre.com>,  Nuno
 =?utf-8?Q?S=C3=A1?=
 <nuno.sa@analog.com>,  "Andy Shevchenko" <andy@kernel.org>,  "Martin
 Kepplinger" <martin.kepplinger@theobroma-systems.com>,  "Christoph
 Muellner" <christoph.muellner@theobroma-systems.com>,
  <linux-iio@vger.kernel.org>,  <devicetree@vger.kernel.org>,
  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v10 10/10] iio: accel: mma8452: Support interrupt sharing
In-Reply-To: <aroytGH8u-gGFYvq@ashevche-desk.local>
References: <20260928-mma8452-open-drain-v10-0-b906fb408386@geanix.com>
	<20260928-mma8452-open-drain-v10-10-b906fb408386@geanix.com>
	<CNQ6_DVFGgC82FTU2GwM8v4KY2d4DUOo_b1XhhyOnysR6eWGJEsgFHlNLylYvkM6dWR3mhcGGFNDuN7qwCO1YA==@protonmail.internalid>
	<aroytGH8u-gGFYvq@ashevche-desk.local>
Date: Mon, 28 Sep 2026 12:15:57 +0200
Message-ID: <87mrt1vfz6.fsf@geanix.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Andy Shevchenko" <andriy.shevchenko@intel.com> writes:

> On Mon, Sep 28, 2026 at 10:26:26AM +0200, Esben Haabendal wrote:
>> Adding support for sharing interrupt line with other device requires the
>> interrupt handler to handle runtime PM suspension properly, ignoring the
>> irq if the device is suspended (maybe even off). And while at it, we use
>> the PM reference to ensure we do not get suspended while processing an irq.
>>
>> In order to prevent the chip from raising irq while suspended (that is when
>> using fixed regulator, where suspend just means setting the device in
>> STANDBY mode), we disable all interrupt sources by clearing CTRL_REG4, and
>> then restores the value again when resuming.
>>
>> The scoped_guard in mma8452_runtime_suspend() is changed to a plain
>> mutex_lock() instead, both to prevent mixing guards and goto, but also to
>> ensure that we stay in STANDBY mode while writing to CTRL_REG4 and all the
>> way up to disabling the device as much as possible.
>>
>> With that in place, it is safe to add the IRQF_SHARED flag.
>>
>> Keep in mind that the device by default is using push-pull for the irq pin,
>> which might require additional hardware design to allow interrupt sharing.
>
> ...
>
>> +	pm_status = pm_runtime_get_if_active(dev);
>> +	if (pm_status == 0)
>> +		/* device is powered down */
>> +		return IRQ_NONE;
>
>> +	if (IS_ENABLED(CONFIG_PM) && pm_status < 0)
>> +		/* runtime PM was disabled, possibly suspending */
>> +		return IRQ_HANDLED;
>
> This is very interesting part. I bet this will be the first driver using this.
> A big question "why?"

Because as I understood it, I needed to add this for the patch to be
accepted [1]. It is definitely possible that I have misunderstood that.

The technical reason I believe is that during system suspend,
pm_runtime_force_suspend() disabled runtime PM, and if a shared
interrupt durings this, pm_runtime_get_if_active returns -EINVAL, and we
could therefore end up doing I2C reads on unpowered hardware.

Per that reasoning, we probably should be doing this in other drivers as
well.

>> +	/*
>> +	 * pm_status is now 1 or -EINVAL (with CONFIG_PM not enabled). If
>> +	 * pm_status==1, runtime PM is enabled and device is RPM_ACTIVE. If
>> +	 * pm_status==-EINVAL, runtime PM is build-time disabled (i.e. CONFIG_PM
>> +	 * not enabled), and we can/must assume device is active.
>> +	 */
>> +
>>  	src = i2c_smbus_read_byte_data(data->client, MMA8452_INT_SRC);
>>  	if (src < 0)
>> -		return IRQ_NONE;
>> +		goto out_runtime_put;
>>
>>  	if (!(src & (data->chip_info->enabled_events | MMA8452_INT_DRDY)))
>> -		return IRQ_NONE;
>> +		goto out_runtime_put;
>>
>>  	if (src & MMA8452_INT_DRDY) {
>>  		iio_trigger_poll_nested(indio_dev->trig);
>> @@ -1120,6 +1139,10 @@ static irqreturn_t mma8452_interrupt(int irq, void *p)
>>  		ret = IRQ_HANDLED;
>>  	}
>>
>> +out_runtime_put:
>> +	if (pm_status > 0)
>> +		pm_runtime_put_autosuspend(dev);
>> +
>>  	return ret;
>>  }
>
> ...
>
>> +	pm_runtime_enable(dev);
>> +	pm_runtime_set_autosuspend_delay(dev, MMA8452_AUTO_SUSPEND_DELAY_MS);
>> +	pm_runtime_use_autosuspend(dev);
>
> I don't see the respective _dont_use_autosuspend() call anywhere.

Ah. I was not aware it was attached to a usage counter as well. I will
add a pm_runtime_dont_use_autosuspend() to the runtime_suspend: error handling.

> ...
>
> I am wondering how many of the above possible scenarios you were able
> to test.

Not enough. I haven't done any additional instrumentation to cause all
the various error conditions that is handled here in _probe().

> ...
>
> P.S.  I bet you can now make a presentation "PM runtime in Linux and
> why it is so hard."

LOL. I am getting there, yes. I have definitely learned a lot about how
runtime PM works. Especially since I was mostly starting from scratch on
that.

But i fear it would easily end up being quite a chaotic presentation :)

/Esben
