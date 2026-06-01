Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394E32594B9
	for <linux-iio@vger.kernel.org>; Mon,  1 Jun 2026 20:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780344470; cv=none; b=pAU9A9Y2EvvE+4OKn/emQHu1Bn7h4wffQ0A/QL8/4H37FQ6NkP0iTnW48nmz8o/+Wg9m0FdIuNB3jLPHavPLEKOMXXQC+6ulqZVDlYWI9IAvNuXhAbcGswL6TT2GaoMu25JseIKOakM8C07PJMuHlmt6OPSCEIFP6W1q3HXjQNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780344470; c=relaxed/simple;
	bh=oUCgstZ8zCfnP4PRe5raGDzvXLICfUsc+ixmNQQV9KU=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Subject:Cc:To:
	 References:In-Reply-To; b=ZZEZzbhYKZ0rt9RFsKBUzk04V5WFQB5nM7Bg9imLDik7EeN2Dv+6HUwLq8LYQih41mJsEfflgockhhEQAcG99lhwKr7ZdIj6QGF+OXgTsayc82fo+7QHmp97dWbgdCJgoD1a95iU6PGxcivbiElj4h9XJyhusDvpO16kJYFum+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=No5dZJ46; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="No5dZJ46"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-45fe59255beso1016974f8f.1
        for <linux-iio@vger.kernel.org>; Mon, 01 Jun 2026 13:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780344466; x=1780949266; darn=vger.kernel.org;
        h=in-reply-to:references:to:cc:subject:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I8KTi/gy6XvJGr5oRI81A7XAgQpzQe+KpvHOKKQoJ8s=;
        b=No5dZJ465DIB5st5EPvsOCLC1vb1P13oi8D1nJsa8zkPek7NXTZCyBLAOUy2/gtxNN
         UvfplrpGjbpdFGQzkkO0IktpoG5K44yCYYocbKKhi+zE7pUk0Tl/Vhj5xHnpID+yiI6u
         Wx6GuOaaFPCngBD333WT2xrEy0DWFkQbmkrL1YGgv7+yyt8/yzgEDU7BMT50uk1rC4mQ
         OMy5vXtvB9BCzTUgRlbhS8qTcOb5TTkNiUC7ZGbiA4QXmtkvMUXhiyhg3IV/J5pQJxVk
         bikqg210ixofjbwfoEpQAKSYLuhhBJe9nJCbj4qAWeoEPq0rkBwFhADLLbgoyfNJGyTY
         kuHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780344466; x=1780949266;
        h=in-reply-to:references:to:cc:subject:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I8KTi/gy6XvJGr5oRI81A7XAgQpzQe+KpvHOKKQoJ8s=;
        b=e8WjK7tZ9RJgrcfgkYzPHctYABa2SKd9gkkaIudbsCkBoFRRRPwhlUFfdwvvF0H/wg
         9H3HdHYbL/HNsjeXvfQLOUqBieRI8maKWbQVx8sCwGyVh5xNV51ueVcORbuYPQtUCiFo
         ZWSZtlXc6tK53XmR+UeyntnAbhTPHOYpfkwqiJULQB+nii1IH5RSyNi6goLdb+kKn4y2
         nJUH5MZ+iYDtciY1QY1EUGXF/510+ickgqGlBYzbmSv8gU4I8yrNZBsqxfSlCCanbB0u
         qASZZCy6y1IK7C7XMdUR/xMK2K3vzLtmCFR5pchR7kSVPfp3siwsMjvZV/sLDY/CTOYK
         fTjg==
X-Forwarded-Encrypted: i=1; AFNElJ9BBjHFRipsQPTqkgUxn6jmoVJ3xNnzHTX8wCBRdIJkaYjKmorCkkdM6tF5WJcv7VQ/m+APlHjoN4k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFnhnM1k6kyfA2+4QHy3BRRTHLUp4J3zCPWerWMQ/P2QePDFrP
	FbmhxNR/gDeR2x5BvfIWw8RYM2+NiS7/yII+jPNfMmTpqTucxcn9Kb8C
X-Gm-Gg: Acq92OGoOJBZURkerBmfyPoo+ygjd18Kmt7jagLgAFuXiXpSmCalJP2XzKQErmK1/QI
	+DoA7ijyeVw0Yle03WWe1YAVroD9j+1vZyW80kYVkSnoyZJLoN9OTEtPD1yYCgKbqc7pLuMmlQp
	Ktf8EaBQyu+W6wXRj1+wEOsgLaPSgAW3I6f3Fse8OkXmwItVFIWCdSTUm+MZUqX93lNr5HSGCTY
	tYd6iWCh7HgDVZ6go122mAEgvPgd9m+mDVXCEGwN4wYEjZoZgAwpt7j7p50Mt2LTCmslh99LOt5
	xK9O/RI56uGXNoXuKrumH9BCrajCjkky7Rgi6exlM7YsI5vVmN65aN9etVovKzSJMnbGiYaLROH
	/tXbZuYu31TGYILfUxlmeyrHzGgoPLlDXFmK9N2J8I5cRom6mlNZln8E33YvedvQ010iGFX9s7T
	jTGen5e+lZbBK4i7Nlzz/q4oteczw8C+dtjmr6FPvTbmtLiTE=
X-Received: by 2002:a5d:49cb:0:b0:45e:ef2e:25a8 with SMTP id ffacd0b85a97d-45ef6b9a95bmr18082524f8f.32.1780344465234;
        Mon, 01 Jun 2026 13:07:45 -0700 (PDT)
Received: from localhost ([2001:4bb8:152:df59:90ee:310f:9ad4:9858])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef356b129sm34737190f8f.32.2026.06.01.13.07.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jun 2026 13:07:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 01 Jun 2026 22:07:42 +0200
Message-Id: <DIXZFV822HRI.2SBIT7ADW9LUK@gmail.com>
From: "Javier Carrasco" <javier.carrasco.cruz@gmail.com>
Subject: Re: [PATCH v4 2/4] iio: light: add support for veml6031x00 ALS
 series
Cc: "Lars-Peter Clausen" <lars@metafoo.de>, "Rob Herring" <robh@kernel.org>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley"
 <conor+dt@kernel.org>, "Rishi Gupta" <gupt21@gmail.com>, "David Lechner"
 <dlechner@baylibre.com>, =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 "Andy Shevchenko" <andy@kernel.org>, "Matti Vaittinen"
 <mazziesaccount@gmail.com>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
To: "Jonathan Cameron" <jic23@kernel.org>, "Javier Carrasco"
 <javier.carrasco.cruz@gmail.com>
X-Mailer: aerc 0.21.0-143-g2f3a2e260c09
References: <20260531-veml6031x00-v4-0-e64f7fdce38d@gmail.com>
 <20260531-veml6031x00-v4-2-e64f7fdce38d@gmail.com>
 <20260601112103.281387ee@jic23-huawei>
In-Reply-To: <20260601112103.281387ee@jic23-huawei>

Hi Jonathan, thanks again for your review.

On Mon Jun 1, 2026 at 12:21 PM CEST, Jonathan Cameron wrote:
> On Sun, 31 May 2026 21:58:22 +0200
> Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:
>
>> These sensors provide two light channels (ALS and IR), I2C communication
>> and a multiplexed interrupt line to signal data ready and configurable
>> threshold alarms.
>>
>> This first implementation provides basic functionality (measurement
>> configuration, raw reads and ID validation) and defines the different
>> register regions in preparation for extended features in the subsequent
>> patches of the series.
>>
>> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> A few comments from sashiko and a couple from me based on a fresh read.
>
>
>> diff --git a/drivers/iio/light/veml6031x00.c b/drivers/iio/light/veml603=
1x00.c
>> new file mode 100644
>> index 000000000000..6f9a7bad44d4
>> --- /dev/null
>> +++ b/drivers/iio/light/veml6031x00.c
>
>> +
>> +static const struct iio_chan_spec veml6031x00_channels[] =3D {
>> +	{
>> +		.type =3D IIO_LIGHT,
>> +		.address =3D VEML6031X00_REG_ALS_L,
>> +		.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) |
>> +				      BIT(IIO_CHAN_INFO_SCALE),
>> +		.info_mask_shared_by_all =3D BIT(IIO_CHAN_INFO_INT_TIME),
>> +		.info_mask_shared_by_all_available =3D BIT(IIO_CHAN_INFO_INT_TIME),
>> +		.info_mask_separate_available =3D BIT(IIO_CHAN_INFO_SCALE),
>> +	},
>> +	{
>> +		.type =3D IIO_INTENSITY,
>> +		.address =3D VEML6031X00_REG_IR_L,
>> +		.modified =3D 1,
>> +		.channel2 =3D IIO_MOD_LIGHT_IR,
>> +		.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) |
>> +				      BIT(IIO_CHAN_INFO_SCALE),
>
> Can we move scale to shared_by_type?
>
> Thinking on some of the others, they should probably be shared_by_type as=
 well
> rather than shared_by_all. If we ever add buffered support and a timestam=
p
> the integration_time doesn't apply to that.
>
> shared_by_all tends to only include things that are truely universal like
> sampling_frequency.
>

I am not sure if I get this point. This device has a single IIO_LIGHT
channel, and the scale only applies to it. Are info_mask_separate and
info_mask_shared_by_type not the same in that case? I have seen that
some drivers use both info_mask_separate for INFO_RAW, and
info_mask_shared_by_type for INFO_INT_TIME and/or INFO_SCALE, but that
could make more sense if there were multiple channels of the same type.
What am I missing here?

On the other hand, the integration time applies to both the IIO_LIGHT
and IIO_INTENSITY channels, so I guess you are suggesting to add it
to both channels as info_mask_shared_by_type because the timestamp
is a channel itself. Moving it form shared_by_all to shared_by_type is
alright, and I will add it to V5.

>> +		.info_mask_shared_by_all =3D BIT(IIO_CHAN_INFO_INT_TIME),
>> +		.info_mask_shared_by_all_available =3D BIT(IIO_CHAN_INFO_INT_TIME),
>> +	},
>> +};
>
>> +
>> +static int veml6031x00_get_it(struct veml6031x00_data *data, int *val2)
>> +{
>> +	int ret, it_idx;
>> +
>> +	scoped_guard(mutex, &data->scale_lock) {
>
> Given below I suggest you need an unlocked variant of this, maybe
> think about whether we care if the scope includes the table search.
>
> I'd just take the lock for the whole function.
>
>> +		ret =3D regmap_field_read(data->rf.it, &it_idx);
>> +		if (ret)
>> +			return ret;
>> +	}
>> +
>> +	ret =3D iio_gts_find_int_time_by_sel(&data->gts, it_idx);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	*val2 =3D ret;
>> +
>> +	return IIO_VAL_INT_PLUS_MICRO;
>> +}
>
>> +
>> +static int veml6031x00_single_read(struct iio_dev *iio, enum iio_chan_t=
ype type,
>> +				   int *val)
>> +{
>> +	struct veml6031x00_data *data =3D iio_priv(iio);
>> +	int addr, it_usec, ret;
>> +	__le16 reg;
>> +
>> +	switch (type) {
>> +	case IIO_LIGHT:
>> +		addr =3D VEML6031X00_REG_ALS_L;
>> +		break;
>> +	case IIO_INTENSITY:
>> +		addr =3D VEML6031X00_REG_IR_L;
>> +		break;
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +
>> +	PM_RUNTIME_ACQUIRE_AUTOSUSPEND(data->dev, pm);
>> +	ret =3D PM_RUNTIME_ACQUIRE_ERR(&pm);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret =3D veml6031x00_get_it(data, &it_usec);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	/* integration time + 10 % to ensure completion */
>> +	fsleep(it_usec + (it_usec / 10));
>> +
>> +	ret =3D regmap_bulk_read(data->regmap, addr, &reg, sizeof(reg));
>> +	if (ret)
>> +		return ret;
>
> https://sashiko.dev/#/patchset/20260531-veml6031x00-v4-0-e64f7fdce38d%40g=
mail.com
>
> Hmm. Sashiko shouts race here. It is kind of correct in that we don't kno=
w
> if we have a matching pair of integration time and reading. Thus we might
> have
> Thread 1                           Thread 2
> Power on.
> Get small integration time
>                                    Set large integration time
> read before new integration done.
>
> Whether this is bug kind of depends on the device when the integration ti=
me
> is updated.  Does it finish current integration with old one, or does it =
just
> update some register against which a comparator is running. So if we are
> already integrating, do we just integrate for longer before stopping?
>
> I haven't checked but this smells like kind of thing a datasheet won't te=
ll
> us.  Hence I'd be tempted to throw use of data->mutex to serialize single
> reads and integration time updates + anything related to that).  It's
> harmless at worst and makes it easier to reason about this code.
> You'll need an unlocked  __veml6031x00_get_it() variant to call though
> given that takes the same lock.
>

You are right assuming that the datasheet will not give us an answer
about that. I suspect by my measurements that the measurement is carried
out with the first integration time, which would make this issue
harmless. But as I am not 100% sure, I contacted the manufacturer to
have a reliable answer. I will wait for a few days while I fix all the
stuff for V5, and if I don't get an answer, or the new integration time
is used, I will use the mutexes as you suggested. I don't like using
mutexes to protect sections of code "just in case" without a real reason
behind, but if there is no way to know, then it will have to be that
way...

>> +
>> +	*val =3D le16_to_cpu(reg);
>> +	return IIO_VAL_INT;
>> +}
>
>> +
>> +static int veml6031x00_validate_part_id(struct veml6031x00_data *data)
>> +{
>> +	int part_id, ret;
>> +	__le16 reg;
>> +
>> +	ret =3D regmap_bulk_read(data->regmap, VEML6031X00_REG_ID_L, &reg,
>> +			       sizeof(reg));
>> +	if (ret)
>> +		return dev_err_probe(data->dev, ret, "Failed to read ID\n");
>> +
>> +	part_id =3D le16_to_cpu(reg);
>> +	if (part_id !=3D data->chip->part_id)
>> +		dev_warn(data->dev, "Unknown ID %04x\n", part_id);
>
> Maybe relax to dev_info() given we expect this to happen if fallback
> compatibles get used in future. Warn is a little strong.
>

Ack.

>> +
>> +	return 0;=C3=A4
>> +}
>
>> +static int veml6031x00_probe(struct i2c_client *i2c)
>> +{
>
>> +	pm_runtime_set_autosuspend_delay(dev, 2000);
>> +	pm_runtime_use_autosuspend(dev);
>> +	ret =3D devm_pm_runtime_set_active_enabled(dev);
>> +	if (ret)
>> +		return dev_err_probe(dev, ret, "Failed to enable runtime PM\n");
>> +
>> +	ret =3D devm_pm_runtime_get_noresume(dev);
>> +	if (ret)
>> +		return dev_err_probe(dev, ret, "Failed to get runtime PM\n");
>> +
>> +	ret =3D veml6031x00_validate_part_id(data);
>> +	if (ret)
>> +		return ret;
>> +
>> +	iio->name =3D data->chip->name;
>> +	iio->channels =3D veml6031x00_channels;
>> +	iio->num_channels =3D ARRAY_SIZE(veml6031x00_channels);
>> +	iio->modes =3D INDIO_DIRECT_MODE;
>> +	iio->info =3D &veml6031x00_info;
> This block doesn't need to happen in the runtime pm region.

Ack.

>> +
>> +	ret =3D veml6031x00_hw_init(iio);
>> +	if (ret)
>> +		return ret;
>> +
>> +	pm_runtime_put_autosuspend(dev);
>
> As sashiko shouts, this looks like runtime pm will underflow on remove.
> Check it by removing your driver.  It doesn't actually result in any
> problem, as the runtime pm subsystem just saturates at 0 on decrement.
> Given that's tear down anyway maybe we don't care.  However, it's easy
> enough to fix by using pm_runtime_get_no_resume() and a couple of
> explicit calls to put it in error paths.
>

I took some time to audit this in detail, because although my
expectations are that atomic_add_unless(usage_count, -1, 0) should make
this shout a false positive. Expectations don't always meet reality. My
expectations were based on the code, so I have added tracepoints to know
exactly what's going on.

Scenario 1: Successful probe -> unbind driver.

devm_pm_runtime_get_noresume() increases usage_count, and the call to
pm_runtime_put_autosuspend() decreases it. That is balanced, giving us
usage_count =3D 0 and putting the device in power down mode as desired. If
the device is then unbound, the devres action (a call to
pm_runtime_put_noidle_action, which only calls pm_runtime_put_noidle)
triggers a call to atomic_add_unless(&dev->power.usage_count, -1, 0).
Given that the usage count is 0, nothing happens and there is no
underflow. In fact, the underflow is not possible this way, and adding a
remove function to check if usage_count is 0 and calling
pm_runtime_put() is basically repeating what the devres action already
offers for free.

Scenario 2: write_event_config -> unbind driver.

Sashiko says that pm_runtime_resume_and_get() increases usage_count, and
there is no devres action associated to it. That is only partially
correct, because the devres action from devm_pm_runtime_get_noresume()
will be triggered when the driver is unbound. Actually, this is great
because then pm_runtime_resume_and_get() gets balanced, and there is no
need for a remove function to check again if usage_count is 0 or not. In
this case, usage_count =3D 1 before unbinding the driver, and then the
devres action is triggered when it gets unbound. Exactly what we want to
have usage_count =3D 0.

>> +
>> +	ret =3D devm_iio_device_register(dev, iio);
>> +	if (ret)
>> +		return dev_err_probe(dev, ret, "Failed to register iio device\n");
>> +
>> +	return 0;
>> +}
>
>>

Best regards,
Javier
