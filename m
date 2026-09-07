Received: from mail-244108.protonmail.ch (mail-244108.protonmail.ch [109.224.244.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 085D5470445;
	Mon,  7 Sep 2026 16:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788799022; cv=none; b=dbeVoaOSVePRoyEuAf+6+JA2/aDOZjrfNDeOA1K+GP+1XCA6Ro6ORpFYrs2Ruhv+LUHD2TgZsvkoi+YwWin+sVpdQsMPnT8bMiYJ1aoJZLVh1+d5P8cG2IF2mRO7K2FqGGBSVqTTfJ/0eL3horZQi05vr/woZEeE/z5t0LhX6js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788799022; c=relaxed/simple;
	bh=T+cZQoxjvvdKvEz4jWQUjvixBBJodZHlypMocmDmZKA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VzUfiv0gJk405G4rnb6a9vhMAjDUEksZi4fVuJ7VoRdNDtDrJ0sEopN37/lLylT7HEUS87X1+RaH4H7yVN+ITe1F/vKE0m4OnfGKO9DnRzlfGipn+RoP8KzkYElahVH/2yb5c+7z6ao1AN+m5OlA90qMiOmXbzwk4aARz0Zc9es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=EZQ0J6LB; arc=none smtp.client-ip=109.224.244.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="EZQ0J6LB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail; t=1788799018; x=1789058218;
	bh=qXaUM0YuwV9bgSLoOldbbvDAXx7PzgYVmcb6b0j/A0M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=EZQ0J6LB4ApWRXOrKL02IRjf0z55a9PdevcBQZQjLcihPtmh4Q4xGM/33aS6bHtpu
	 X5GiCP/DIuBlXDHS1JuSo+affe1h7qUOCFnG0pSmGAnSHJ4dMYV8WHVb2KDmeXWT2L
	 ig10w3RKvpdFSZEbyQKINhhBK/ZZjseMbp6X1C1vvXCNdgoOIuqvapamDZ1JHtnpX0
	 oBlYLYrpU6tWHQ7S/ri99dICDIbNQt5nxEm6bdAxNBWiLuJdsLOEF6YYp15oG1mDWk
	 ewQyzbqBmu8iNCDTmf5RIy9CsSDLeWqDY3NTywcRuVKUAVacSQPg15AeZ7rk35uKP9
	 qaZ8PUHoPmqNg==
X-Pm-Submission-Id: 4hdt5511wbz2ScWg
From: Esben Haabendal <esben@geanix.com>
To: "Joshua Crofts" <joshua.crofts1@gmail.com>
Cc: "Jonathan Cameron" <jic23@kernel.org>,  "Lars-Peter Clausen"
 <lars@metafoo.de>,  "Rob Herring" <robh@kernel.org>,  "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>,  "Conor Dooley" <conor+dt@kernel.org>,
  "Martin Kepplinger" <martink@posteo.de>,  "Sean Nyekjaer"
 <sean@geanix.com>,  "David Lechner" <dlechner@baylibre.com>,  Nuno
 =?utf-8?Q?S=C3=A1?=
 <nuno.sa@analog.com>,  "Andy Shevchenko" <andy@kernel.org>,  "Martin
 Kepplinger" <martin.kepplinger@theobroma-systems.com>,
  <linux-iio@vger.kernel.org>,  <devicetree@vger.kernel.org>,
  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8 9/9] iio: accel: mma8452: Support interrupt sharing
In-Reply-To: <20260907171022.00007100@gmail.com>
References: <20260907-mma8452-open-drain-v8-0-c17407e22118@geanix.com>
	<20260907-mma8452-open-drain-v8-9-c17407e22118@geanix.com>
	<MzPTxQYymt0hmx-TacfSh_fIDYxz6pFiDnu5MTWC5w7AsH0QPasKb40V8t01ggjLJlDF7yzQ4E_7o_kqDvMG6w==@protonmail.internalid>
	<20260907171022.00007100@gmail.com>
Date: Mon, 07 Sep 2026 18:36:56 +0200
Message-ID: <87ecf581cn.fsf@geanix.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Joshua Crofts" <joshua.crofts1@gmail.com> writes:

> On Mon, 07 Sep 2026 16:51:04 +0200
> Esben Haabendal <esben@geanix.com> wrote:
>
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
>> With that in place, it is safe to add the IRQF_SHARED flag.
>>
>> Keep in mind that the device by default is using push-pull for the irq pin,
>> which might require additional hardware design to allow interrupt sharing.
>>
>> Signed-off-by: Esben Haabendal <esben@geanix.com>
>> ---
>
> ...
>
>> @@ -1784,29 +1796,62 @@ static void mma8452_remove(struct i2c_client *client)
>>  #ifdef CONFIG_PM
>>  static int mma8452_runtime_suspend(struct device *dev)
>>  {
>> -	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
>> +	struct i2c_client *client = to_i2c_client(dev);
>> +	struct iio_dev *indio_dev = i2c_get_clientdata(client);
>>  	struct mma8452_data *data = iio_priv(indio_dev);
>>  	int ret;
>>
>> -	scoped_guard(mutex, &data->lock)
>> -		ret = mma8452_standby(data);
>> +	guard(mutex)(&data->lock);
>> +
>
> Hmm, this patch might benefit from breaking it into multiple patches
> (the change from scoped_guard to guard, the local pointers etc. along
> the fact that these aren't mentioned in the commit message), but
> that's up to Jonathan.

I will try and improve the commit message. I don't think that breaking
it up makes a lot of sense.

The change from guard() to scoped_guard() is closely tied to the rest of
the changes. At least I am not sure if it is even sane to make that
change without the rest of this commit. It might be fine. Probably is,
but is it worth to risk causing trouble for older kernels?

Regarding the local pointers, I assume you mean the added struct
i2c_client and struct device pointers. They are only used in the added
code, so I don't see how I can split that out in a meaningful way.

I don't mind making such changes, I just don't see what I am expected to
do.

/Esben
