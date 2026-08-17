Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93FD53F86F9
	for <linux-iio@vger.kernel.org>; Mon, 17 Aug 2026 10:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786963304; cv=none; b=ZkB0uVygT3bkTx1uyNNHFr/KcOWJEWnvW2iByDSseWe4lwTKrtW9xK76QZ4xWnEosiFLCY2+xfJ766RddB9JflboqYjTx9bqqBaOvSZzP5TnRIijSI3Do5OVeun678NgQfm+3DCOZLZVPRi7M6ev4+42Hda4cNPWXDuKyMKR7z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786963304; c=relaxed/simple;
	bh=ZazWwUrFBUhjlb4NlAjCIWGNBnzA3hVzJbf8Yu+J00w=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=Oi3zIxMYLOdezZ7/xW0J09Kh/ybO5vNCRPkREqWt3e8V/2zaRdK+2orMtJ66tzVSIexNVwbMA5LY15ZImT5hQ+sXQhsCRaxQNikFdXsfsTUUyfYK0tbptyQhxt0RYmObaxJVWZ3x8PP2TXCWLhr4dRJlCGhy97Enb5+QasdbmH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qrND0tLY; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qrND0tLY"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6a386a34603so676004a12.1
        for <linux-iio@vger.kernel.org>; Mon, 17 Aug 2026 03:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786963301; x=1787568101; darn=vger.kernel.org;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=dH16vt+2IQEKgJpHamObd3SwlWsR3WLEkxxGzQ8Y+gI=;
        b=qrND0tLYP2OxAbui4NCwUM9vszRPpRgZ6J9ZFdLWbxfTP7vrEnQKDrapgcvnCkvcBC
         jOgkqshBwlor2uCijOO5wJVcGYq4u9egF96KPYbhFfwQ+ieDqDlY39eXrcyCXsxrJLf/
         i4fcT1bk7yh1ASxa5A9hZuDmzAFbYj6IvvcbOvv9+hetGGyexcZazxfflWJjWNPXFeck
         6v47LyggBWdK7eOqQDV+XxnfgLBH3cyGZua+G/ONLBGZ/QmwYXbA37laNBYen3742TdW
         Te6RvHZK/+odoi9uUX8OhCZcyUoGU5fTuTSbBFjcSgDg4XVapgDlDbpHwcOUYEJtZsf+
         38Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786963301; x=1787568101;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dH16vt+2IQEKgJpHamObd3SwlWsR3WLEkxxGzQ8Y+gI=;
        b=i4FSceE2aQN5Bd07OhpZ3p91wfz9Zm0npQUNLK9gY7uJtR+PhEzgfVp0xe29nLJISm
         sJr5KJQM6E07Yx/B6pR+KVTEAVMHWrykW3eRzfXfRdkZqjTOXbjA8u3N1kWmPzBNpDRS
         QFf9d49acwPuYUIoDaFTJaEuGbpvvYMxKF8oG/hPTPkvsE7chIpzpfnq6j88PdVvyuPg
         vhBn3ze8Wm/NqDqCpUwORXH7Tc3fI/lNQ6JnrFmXVCgXJy+OAo68S3uENYq1Fk7h8SWh
         KB1swhlkNcO+iw6+d/pdZS4hKodzlTmRjCIICjK5X8uyKynMJx/wRbPuNrm46GohTEm0
         bzQw==
X-Forwarded-Encrypted: i=1; AHgh+Rq06KmtgpVkgplNaBN0PhPioJ4xGU2fl/LXUpKxBf7e6InuYP9mBOe5ETPaOWoYOwdegA69ibx9a4E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyN+TsOY/4b3xjSVw2PuZVH5CHbV8kqaqpDUu9WneuMeTZEW68k
	DvmFPiFyjpfMfPRQYlxYi3pT77DVYgAf0ekjKqZ/vSg6A4DUFb5S2Rfk
X-Gm-Gg: AR+sD10wZcWbJgmaeZMt5RWeL5W9g3I6TDUfRm1DzC7MiQu13EqQcHmvhA2fLihhOzW
	8phBvVXjrp25v/VQ/CrU7cJCtdqxHHKT1K8SgjtyXHVF8XYg5M340GZOGBMeqwA4OKUEVTZK/KU
	fWwRDOo4Mpy/bLyY02nqsBh07EszGisRRmHl7TDYXJzyQqttGZC10QuYm8uWwe2UyOHTiYVZlO3
	I9TO7kYEZzXwFZ/y/lvwtGUIdYtUDcJqMOzRz3eTzvHkaBm7boeraBABFi4dV14P0aXwvvI+DaA
	1bQrhLseBpstnXn0rWx3UcgyYuB9Fi9ZvxcKQkqTQUfoMnYKSu8x2vdxnTvB6I/fHoCApJxYZ8/
	DuQSB0Ymt6pLoA7txmqfN0/t3yq5TJJebeR5p/ypK2JON+Q374XHG4rkurvL/pxO9DSHlRPR2Io
	V3fXck36Ovf/Ufmjqr202t8z6awkbezMoCUqfQ7lPJ5c+AC9YSXzKrjYib8cwHqcjYlklPz6xlP
	Lw=
X-Received: by 2002:a05:6402:1cc7:b0:698:4501:3a8e with SMTP id 4fb4d7f45d1cf-6a38af1daadmr7321978a12.9.1786963300493;
        Mon, 17 Aug 2026 03:41:40 -0700 (PDT)
Received: from localhost ([2001:4bb8:17a:e1ae:4021:4903:88de:847e])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a3d8588415sm462730a12.17.2026.08.17.03.41.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Aug 2026 03:41:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 17 Aug 2026 12:41:35 +0200
Message-Id: <DKR5MCXCOF3K.16LP34WC4HBLI@gmail.com>
Subject: Re: [PATCH v6 4/4] iio: light: veml6031x00: add support for events
 and trigger
Cc: "Lars-Peter Clausen" <lars@metafoo.de>, "Rob Herring" <robh@kernel.org>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley"
 <conor+dt@kernel.org>, "David Lechner" <dlechner@baylibre.com>,
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy Shevchenko"
 <andy@kernel.org>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
To: "Jonathan Cameron" <jic23@kernel.org>, "Javier Carrasco"
 <javier.carrasco.cruz@gmail.com>
From: "Javier Carrasco" <javier.carrasco.cruz@gmail.com>
X-Mailer: aerc 0.21.0-143-g2f3a2e260c09
References: <20260812-veml6031x00-v6-0-7eef6e4ce290@gmail.com>
 <20260812-veml6031x00-v6-4-7eef6e4ce290@gmail.com>
 <20260813022436.41a28d64@jic23-huawei>
 <DKNTPHF7K5G7.AJEIRCWO8FAM@gmail.com>
 <20260817033657.4767671f@jic23-huawei>
In-Reply-To: <20260817033657.4767671f@jic23-huawei>

On Mon Aug 17, 2026 at 4:36 AM CEST, Jonathan Cameron wrote:
> On Thu, 13 Aug 2026 14:43:26 +0200
> "Javier Carrasco" <javier.carrasco.cruz@gmail.com> wrote:
>
>> Hi Jonathan, thank you for your review to the series.
>>
>> On Thu Aug 13, 2026 at 3:24 AM CEST, Jonathan Cameron wrote:
>> > On Wed, 12 Aug 2026 22:27:43 +0200
>> > Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:
>> >
>> >> The device provides a shared interrupt line for to notify events and
>> >> data ready, which can be used as a trigger. The interrupt line is not=
 a
>> >> requirement for the device to work. Implement variants for the cases
>> >> whether the interrupt line is provided or not.
>> >>
>> >> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
>> >> @@ -549,11 +948,78 @@ static int veml6031x00_buffer_postdisable(struc=
t iio_dev *iio)
>> >>  	return 0;
>> >>  }
>> >>
>> >> +static int veml6031x00_set_trigger_state(struct iio_trigger *trig, b=
ool state)
>> >> +{
>> >> +	struct iio_dev *iio =3D iio_trigger_get_drvdata(trig);
>> >> +	struct veml6031x00_data *data =3D iio_priv(iio);
>> >> +	int ret;
>> >> +
>> >> +	guard(mutex)(&data->irq_lock);
>> >> +
>> >> +	if (state =3D=3D data->trig_en)
>> >> +		return 0;
>> >> +
>> >> +	ret =3D veml6031x00_set_interrupt(data, state);
>> >> +	if (ret)
>> >> +		return ret;
>> >> +
>> >> +	/* The AF bit must be updated before updating AF_TRIG */
>> >> +	ret =3D regmap_update_bits(data->regmap, VEML6031X00_REG_CONF0,
>> >> +				 VEML6031X00_CONF0_AF,
>> >> +				 FIELD_PREP(VEML6031X00_CONF0_AF, state));
>> >> +	if (ret) {
>> >> +		veml6031x00_set_interrupt(data, !state);
>> >> +
>> >> +		return ret;
>> >> +	}
>> >> +
>> >> +	ret =3D regmap_update_bits(data->regmap, VEML6031X00_REG_CONF0,
>> >> +				 VEML6031X00_CONF0_AF_TRIG,
>> >> +				 FIELD_PREP(VEML6031X00_CONF0_AF_TRIG, state));
>> >> +	if (ret) {
>> >> +		regmap_update_bits(data->regmap, VEML6031X00_REG_CONF0,
>> >> +				   VEML6031X00_CONF0_AF,
>> >> +				   FIELD_PREP(VEML6031X00_CONF0_AF, !state));
>> >> +		veml6031x00_set_interrupt(data, !state);
>> >
>> > This dance vs a goto is I guess due to the mutex.  I'd clean it up
>> > by using a helper function for the stuff done under the guard(). The
>> > helper can do goto based cleanup and avoid repetition plus reduce chan=
ce
>> > of missing cleaning something up on error.  The outer function can
>> > still use guard().
>> >
>>
>> Yes, that was the reason why some code was duplicated. I will add a
>> helper function with the __must_hold() annotation and
>> lockdep_assert_held().
>>
>> >> +
>> >> +		return ret;
>> >> +	}
>> >> +
>> >> +	data->trig_en =3D state;
>> >> +
>> >> +	return 0;
>> >> +}
>> >
>> >>
>> >> +static int veml6031x00_setup_irq(struct i2c_client *i2c, struct iio_=
dev *iio)
>> >> +{
>> >> +	struct veml6031x00_data *data =3D iio_priv(iio);
>> >> +	struct device *dev =3D regmap_get_device(data->regmap);
>> >> +	int ret;
>> >> +
>> >> +	data->trig =3D devm_iio_trigger_alloc(dev, "%s-drdy%d",
>> >> +					    iio->name, iio_device_id(iio));
>> >> +	if (!data->trig)
>> >> +		return -ENOMEM;
>> >> +
>> >> +	data->trig->ops =3D &veml6031x00_trigger_ops;
>> >> +	iio_trigger_set_drvdata(data->trig, iio);
>> >> +
>> >> +	ret =3D devm_iio_trigger_register(dev, data->trig);
>> >> +	if (ret)
>> >> +		return ret;
>> >> +
>> >> +	iio->trig =3D iio_trigger_get(data->trig);
>> >
>> > Sashiko is correct that we loose a reference here on error and right n=
ow
>> > there is no IIO core infrastructure to solve this
>> >
>> > Why are we setting a default trigger?   Userspace tools should be
>> > fine looking for a data ready trigger, or choosing a different one if =
they
>> > would prefer. Added advantage of not setting it here is the reference =
count
>> > issue goes away :)
>> >
>>
>> I will drop iio->trig =3D iio_trigger_get(data->trig) for v7.
>>
>> I added it because it is (or at least, it was) a common practice in many=
 IIO
>> drivers to assign their own trigger, and in the end it is by far the mos=
t
>> common use case. Of course, we're not going to touch existing drivers to
>> remove that, but is it then something to be advised against in the futur=
e
>> unless there is a good reason for it?
>
> It makes sense if they also 'require' that trigger - but generally if
> a driver has dealt with the potential extra complexity of allowing other
> triggers that is because they want to use them. As such a default has
> no particular benefit.
>
> I probably let a few defaults in over the years where this wasn't
> the case though :(

I bet there are way worse sins ;)

>
> Jonathan
>
>>
>> Thanks and best regards,
>> Javier


