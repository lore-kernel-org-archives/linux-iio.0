Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C46A0478E38
	for <linux-iio@vger.kernel.org>; Thu, 13 Aug 2026 12:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786625023; cv=none; b=BOW9lEggg4KdmFKJqeQBIiOkIKK9QuUI0qTRo9tiYwbm9nFZoBKRo2vJDtLrKPbYKobx1G7QUg9KyDkFw/rJA1PmPkqgvRs3KcuEq4QraiMU1xOounMexEcyqjIQYZjJ1I4ZsM3iU07ZJnj4vs8Hklo+vBySNaVV6pEDJ/lhnz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786625023; c=relaxed/simple;
	bh=XCRyYa9Cj2cBnzNJz+uLg9K78+0Q04t78FS8jSLyM8k=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=KalweMY7INDdT2sVxIt68dBkA3AH+dE19Ium4kvGp6zMtg5b7Jye1QIrfJLbWRazkTK5oaujNHxGX/K5ANSjbG0ww6RzzeNQxqCX+9DrKR+KM3Ytr48KkFF6GnW1uRIYhP5R5UMyEFDyvZB0z4ql+1HD9cSfvk/uzjme4HQPSzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q9+Uzqur; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q9+Uzqur"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-47de008b020so548782f8f.1
        for <linux-iio@vger.kernel.org>; Thu, 13 Aug 2026 05:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786625010; x=1787229810; darn=vger.kernel.org;
        h=in-reply-to:references:subject:from:to:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Wrg2VIt6trGfNzd/hwCmmeNh9EVzBuveLNTMhpJY8Qc=;
        b=Q9+Uzqur1Gz03gxp1I1gre5k12YPLSRHlWLBKEUk76UnkrMbPTv7tQM6HxziLCYfpb
         9Uor95fHj1ZHVs4yeOe0mC02MxyXSWdJ8pcRZdyCphMRYmhSNoEvfU/2Qzh4Rus+69O5
         vtilB0zUZJS1eArtrDXezoZ7vG51dYjXeniUG8sjUsrhMDCCW5WxOLXKDhIohHFp85ir
         iQKWQVHYgc38/omb0NEfyrp29noBtVHrWKeybbCJb9tIskN7sr2yvj9OEVHtD09Qc+Lk
         O+NiYbPNghVOxu401jV6CkKCObGpj6q4+TyaNR/iX8WQ2nM8AI8UtpAMClw3S8pKf1PP
         oGYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786625010; x=1787229810;
        h=in-reply-to:references:subject:from:to:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Wrg2VIt6trGfNzd/hwCmmeNh9EVzBuveLNTMhpJY8Qc=;
        b=EGo254oMb0HIsTnSB5Y5f+lRhuivswQci7g7c0jesS+6h8FsGVeL7Dz4/9ttPHNchy
         5Im1GKL2gmr93U7xRfYVw1Q4Ig+m9Mw+O7Ppk/cxhmg4YGAvVXYBM87tTdgC2AZVMDjr
         ySv6T0KF9zEW4XAQQy16xgz3Mpx+QE+HOwT0PL6AKn5yXEef5INsxTFwDZMg3s+Ih0iE
         MxQsfM3ZxeYj/jIIqo8A/Lx+pa2Lj8VKCoXcSLtWTQtxO8w2ZVqn96rQgs10TYSIrJv1
         WHT7lPsPL3kYA00pwYh2RLR63wFFetp6lU4OtLJnygBqvmO4RiUm2hjNW7Ejd3YD5JR8
         y/NA==
X-Forwarded-Encrypted: i=1; AHgh+Rr03hpI/fUk/f6h0bwQ6E9jhU08U00HbCQiKOKzr7tWhCded1fEnGu+xJkpd0Z0KFYsvmiGXka7Qe4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxA9sZD7pxktp7P0rzI+Z7KcYARAMof4FJh+6S4oFwjKphTIGai
	rMiVlHegq7FxdNPai1mZsP/nwqESSDERY5zHIy7AW3/hJG7tk8V582xI
X-Gm-Gg: AR+sD12wV92JNplQdBigrIkawEXcolc69cZYh7MWecURA1lqfPsvI3zEmzGnXU8te1O
	9lku8pxXFPAM6wWAqu7U8A3tw6/wRcBZBXlYCCdxkfrclfeJC53JG0WgWWO6+FRmxsdnV6ssZob
	Nk+ytAQCvWdfROIUWaYMn1g92BmiftdA1erHrzc4raDWgyGbjHbvVkR0U1Qqyg+bIuiCOAL2Z8K
	Hr/XsiEmumfTE75mSUPj1951BE5lzOVq/jP/Q5t4KbOGxYY81V/pMiPop3sq5TxXPCNXnjmG4DH
	EGYkT9WnrnoRmYx8emFojeVVbo8y7Gy0eksG3Ececi9zrLdc9P7uoTpwbpEjYCeXnrOjJlgEtWa
	XwLXrSm8d95Fy+NhR4lIw3XoOCz8r0+rb8PKhKZUkN8FRRujp2cGbprEw/yGROL50pygBzaDB75
	eYPpDBhpm9njOWKFSKszJIpsi0piZKmd65cJdvjoeEVhO+jWBGw3VoGVUBqBbTOS55JDCuE82xF
	i2r2LPCPH+pmqxOtWg=
X-Received: by 2002:adf:e189:0:b0:47f:ec53:1d2d with SMTP id ffacd0b85a97d-4815a4f981fmr7957694f8f.7.1786625009500;
        Thu, 13 Aug 2026 05:43:29 -0700 (PDT)
Received: from localhost ([2001:4bb8:16f:15e0:beeb:f51b:da5e:3a64])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4815a5c2842sm6423824f8f.35.2026.08.13.05.43.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Aug 2026 05:43:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 13 Aug 2026 14:43:26 +0200
Message-Id: <DKNTPHF7K5G7.AJEIRCWO8FAM@gmail.com>
Cc: "Lars-Peter Clausen" <lars@metafoo.de>, "Rob Herring" <robh@kernel.org>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley"
 <conor+dt@kernel.org>, "David Lechner" <dlechner@baylibre.com>,
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy Shevchenko"
 <andy@kernel.org>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
To: "Jonathan Cameron" <jic23@kernel.org>, "Javier Carrasco"
 <javier.carrasco.cruz@gmail.com>
From: "Javier Carrasco" <javier.carrasco.cruz@gmail.com>
Subject: Re: [PATCH v6 4/4] iio: light: veml6031x00: add support for events
 and trigger
X-Mailer: aerc 0.21.0-143-g2f3a2e260c09
References: <20260812-veml6031x00-v6-0-7eef6e4ce290@gmail.com>
 <20260812-veml6031x00-v6-4-7eef6e4ce290@gmail.com>
 <20260813022436.41a28d64@jic23-huawei>
In-Reply-To: <20260813022436.41a28d64@jic23-huawei>

Hi Jonathan, thank you for your review to the series.

On Thu Aug 13, 2026 at 3:24 AM CEST, Jonathan Cameron wrote:
> On Wed, 12 Aug 2026 22:27:43 +0200
> Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:
>
>> The device provides a shared interrupt line for to notify events and
>> data ready, which can be used as a trigger. The interrupt line is not a
>> requirement for the device to work. Implement variants for the cases
>> whether the interrupt line is provided or not.
>>
>> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
>> @@ -549,11 +948,78 @@ static int veml6031x00_buffer_postdisable(struct i=
io_dev *iio)
>>  	return 0;
>>  }
>>
>> +static int veml6031x00_set_trigger_state(struct iio_trigger *trig, bool=
 state)
>> +{
>> +	struct iio_dev *iio =3D iio_trigger_get_drvdata(trig);
>> +	struct veml6031x00_data *data =3D iio_priv(iio);
>> +	int ret;
>> +
>> +	guard(mutex)(&data->irq_lock);
>> +
>> +	if (state =3D=3D data->trig_en)
>> +		return 0;
>> +
>> +	ret =3D veml6031x00_set_interrupt(data, state);
>> +	if (ret)
>> +		return ret;
>> +
>> +	/* The AF bit must be updated before updating AF_TRIG */
>> +	ret =3D regmap_update_bits(data->regmap, VEML6031X00_REG_CONF0,
>> +				 VEML6031X00_CONF0_AF,
>> +				 FIELD_PREP(VEML6031X00_CONF0_AF, state));
>> +	if (ret) {
>> +		veml6031x00_set_interrupt(data, !state);
>> +
>> +		return ret;
>> +	}
>> +
>> +	ret =3D regmap_update_bits(data->regmap, VEML6031X00_REG_CONF0,
>> +				 VEML6031X00_CONF0_AF_TRIG,
>> +				 FIELD_PREP(VEML6031X00_CONF0_AF_TRIG, state));
>> +	if (ret) {
>> +		regmap_update_bits(data->regmap, VEML6031X00_REG_CONF0,
>> +				   VEML6031X00_CONF0_AF,
>> +				   FIELD_PREP(VEML6031X00_CONF0_AF, !state));
>> +		veml6031x00_set_interrupt(data, !state);
>
> This dance vs a goto is I guess due to the mutex.  I'd clean it up
> by using a helper function for the stuff done under the guard(). The
> helper can do goto based cleanup and avoid repetition plus reduce chance
> of missing cleaning something up on error.  The outer function can
> still use guard().
>

Yes, that was the reason why some code was duplicated. I will add a
helper function with the __must_hold() annotation and
lockdep_assert_held().

>> +
>> +		return ret;
>> +	}
>> +
>> +	data->trig_en =3D state;
>> +
>> +	return 0;
>> +}
>
>>
>> +static int veml6031x00_setup_irq(struct i2c_client *i2c, struct iio_dev=
 *iio)
>> +{
>> +	struct veml6031x00_data *data =3D iio_priv(iio);
>> +	struct device *dev =3D regmap_get_device(data->regmap);
>> +	int ret;
>> +
>> +	data->trig =3D devm_iio_trigger_alloc(dev, "%s-drdy%d",
>> +					    iio->name, iio_device_id(iio));
>> +	if (!data->trig)
>> +		return -ENOMEM;
>> +
>> +	data->trig->ops =3D &veml6031x00_trigger_ops;
>> +	iio_trigger_set_drvdata(data->trig, iio);
>> +
>> +	ret =3D devm_iio_trigger_register(dev, data->trig);
>> +	if (ret)
>> +		return ret;
>> +
>> +	iio->trig =3D iio_trigger_get(data->trig);
>
> Sashiko is correct that we loose a reference here on error and right now
> there is no IIO core infrastructure to solve this
>
> Why are we setting a default trigger?   Userspace tools should be
> fine looking for a data ready trigger, or choosing a different one if the=
y
> would prefer. Added advantage of not setting it here is the reference cou=
nt
> issue goes away :)
>

I will drop iio->trig =3D iio_trigger_get(data->trig) for v7.

I added it because it is (or at least, it was) a common practice in many II=
O
drivers to assign their own trigger, and in the end it is by far the most
common use case. Of course, we're not going to touch existing drivers to
remove that, but is it then something to be advised against in the future
unless there is a good reason for it?

Thanks and best regards,
Javier
