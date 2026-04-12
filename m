Received: from mail-10631.protonmail.ch (mail-10631.protonmail.ch [79.135.106.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769B0375ACB
	for <linux-iio@vger.kernel.org>; Sun, 12 Apr 2026 09:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775987668; cv=none; b=TKIBMLSBqdhS86eQWxvDEl5e+UMwOExZfF5OKYpA9QZSk0ka9uTzQ3t5hMCh0Oimmr70Dbl50EQeK5NnQ5SjzquEGhYACpBFDHd8GpKmYl6f+Ehz6bhEjSrVji4m8cHD/wSR9GlYbl1Nw02YUtXbSu1PYCsDe7clhZ+6Pxms6vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775987668; c=relaxed/simple;
	bh=iXA+hI/Efvr0jnAb4U1G+XY4odCQ7UR4/pCLV7jSlWQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e0tTIbKi0SOQ+0Ytq+jISu1eXlLa2qDOK0W3CylAtywsPjWnL0BFpBUqDr53KcJo+3VSuoKbfTmp9tCq9rqY3sKEGrWKYfQ/dqYZYQtNQSt1lVD+lyKhrpj22to9yIYOS/yPKlx4dLWjUM+MYu95AOx86lsHPpiWqoy/oWtQHN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=minvURCS; arc=none smtp.client-ip=79.135.106.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="minvURCS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1775987658; x=1776246858;
	bh=dJttnkqYgp1JUqhsR0KFuNpwYldDjOyoJeaymBvYBdY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=minvURCSKSJC6sGObre815pZm2CkhejwLOGYxRuZdnk0jygOpJxkOKvwJtVWCtKI0
	 0qDUdM8+dqZ/DykHvfvKR8SKqyK2lvdiWpLGc9zg2w3DGBEXIe39Tme0typ9h+JEO9
	 iY/J4GldVCIPeMVkuZrbKw1PSgXmR05NYtXYMn/7zCqxPa4oUNa5dnlFliInG13MZB
	 Z7D9HD37D5ZEE94m9p7XZ1lbnofxta9yX88p8HMvRQbxVaoth0avHbVGq0Y87xiLPF
	 Gj7qJ5j5gP9I/RRboKn7rcoyQWlNcbar5CX1ZCD8sXOiHfoOoL3d+e5bF7lbya/gxU
	 aPT+VeDW7NYTQ==
Date: Sun, 12 Apr 2026 09:54:12 +0000
To: David Lechner <dlechner@baylibre.com>, Hardik Phalet <hardik.phalet@pm.me>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
From: Hardik Phalet <hardik.phalet@pm.me>
Cc: Jonathan Cameron <jic23@kernel.org>, =?utf-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Brigham Campbell <me@brighamcampbell.com>, Shuah Khan <skhan@linuxfoundation.org>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH v2 3/4] staging: iio: magnetometer: Add QST QMC5883P driver
Message-ID: <DHR32TA81G99.14OO5FKEDU8CB@pm.me>
In-Reply-To: <736964f9-1e93-47e7-80ca-1a89f239a353@baylibre.com>
References: <20260409210639.3197576-1-hardik.phalet@pm.me> <20260409210639.3197576-4-hardik.phalet@pm.me> <736964f9-1e93-47e7-80ca-1a89f239a353@baylibre.com>
Feedback-ID: 166659585:user:proton
X-Pm-Message-ID: f945d8a8660e08a8b18a72b33cd71943d441fff6
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sat Apr 11, 2026 at 1:32 AM IST, David Lechner wrote:
> On 4/9/26 4:07 PM, Hardik Phalet wrote:
>
> This is a little bit much to review all in one patch. Could be nice
> to split out power management to a separate patch.
>
> Oversampling/downsampling could be split to a separate patch or two
> as well.
>
Noted David. I will handle it in v3. I think downsampling can be another
patch.

>> +#define QMC5883P_REG_Y_MSB 0x04
>> +#define QMC58
>> 83P_REG_Z_LSB 0x05
>
> Were you manually editing the patch?
No. Maybe it's my email client (AERC). I will make sure the next version
is tight.

>
>> +#define QMC5883P_RSTCTRL_SET_RESET \
>> +=090x00 /* Set and reset on, i.e. the offset of device is renewed */
>> +#define QMC5883P_RSTCTRL_SET_ONLY 0x01 /* Set only on */
>> +#define QMC5883P_RSTCTRL_OFF 0x02 /* Set
>> and reset off */
>
> Or maybe you mail client mangled the patch? These wraps are
> happening in many places.
>
Yes. Exactly this.

>> +=09if (regval !=3D QMC5883P_CHIP_ID)
>> +=09=09return dev_err_probe(data->dev, -ENODEV,
>
> We don't consider ID match an error. It has happened too many times
> that there is a compatible part with a different ID. This can just
> be dev_info() and return success.
>
Noted. Will handle in v3.

>> +static int qmc5883p_chip_init(struct qmc5883p_data *data)
>> +{
>> +=09int ret;
>> +
>> +=09ret =3D regmap_field_write(data->rf.sftrst, 1);
>> +=09if (ret)
>> +=09=09return ret;
>> +
>> +=09usleep_range(1000, 2000);
>
> Use fsleep() instead and add a comment explaining why this specific durat=
ion
> was selected.
>
Noted, will handle in v3.

>> +=09ret =3D regmap_field_write(data->rf.odr, QMC5883P_DEFAULT_ODR);
>> +=09if (ret)
>> +=09=09return ret;
>
> Since we just reset the chip, why do we need to set everything to a
> new default instead of using the chip's default? If there is a good
> reason, add a comment, otherwise we can leave this out.
>
These were simply more aligned with my usecase, so more of a development
artifact. Chip defaults are sufficient. I will leave this out.=20

>> +
>> +=09return regmap_field_write(data->rf.mode, QMC5883P_MODE_NORMAL);
>
> Does this start sampling? Seems like it could be out of place here.
>
Yes, normal mode starts sampling data. Your point makes sense, I will
remove it in the next version. Incorrect mental model, I apologise.

>> +=09ret =3D regmap_read_poll_timeout(data->regmap, QMC5883P_REG_STATUS,
>> +=09=09=09=09       status, status & QMC5883P_STATUS_DRDY,
>> +=09=09=09=09       QMC5883P_DRDY_POLL_US, 150000);
>
> Numbers with lots of 0s are easier to read as 150 * (MICRO / MILLI).
>
My bad, will handle in v3.

>> +static IIO_DEVICE_ATTR(downsampling_ratio, 0644, downsampling_ratio_sho=
w,
>> +=09=09       downsampling_ratio_store, 0);
>> +static IIO_CONST_ATTR(downsampling_ratio_available, "1 2 4 8");
>
> As mentioned in the cover letter, we'd like to know more about what
> this actually does. If there is a good reason it doesn't fit with
> any existing filter attribute, then we'll need a patch to document
> the sysfs ABI as well.
>
In the device datasheet, OSR2("Down sampling ratio") is mentioned like this=
:
"Another filter is added for better noise performance; the depth can be
adjusted through OSR2". OSR2's defintion is called "down sampling ratio"
in a table. Nowhere else. I didn't know what attribute to map it to in
this case.

> Could save some dupilcation by making a macro that takes X/Y/Z
> as parameter. e.g.
>
> #define QMC5883P_CHAN(ch) \
> =09...=09=09=09=09\
> =09.channel2 =3D IIO_MOD_##ch,=09\
> =09...=09=09=09=09\
> =09.address =3D AXIS_##ch,=09=09\
> =09...
>
Noted. Will do this in v3.

>> +=09ret =3D devm_regulator_get_enable_optional(dev, "vdd");
>> +=09if (ret && ret !=3D -ENODEV)
>> +=09=09return dev_err_probe(dev, ret,
>> +=09=09=09=09"failed to get vdd regulator\n");
>> +
>> +=09/* Datasheet specifies up to 50 ms supply ramp + 250 us POR time. */
>> +=09fsleep(50000);
>> +
>> +=09i2c_set_clientdata(client, indio_dev);
>> +
>> +=09ret =3D qmc5883p_rf_init(data);
>
> Would be more logical to move this up right after regmap is declared.
>
Makes sense, I will move it up in v3.

>> +=09ret =3D devm_iio_device_register(dev, indio_dev);
>
> Usually, we just return directly here. This pretty much doesn't ever fail=
.
>
Okay. Will remove the dev_err_probe() in v3.=20

>> +=09ret =3D regmap_field_write(data->rf.mode, QMC5883P_MODE_NORMAL);
>> +=09if (ret)
>> +=09=09return ret;
>> +
>> +=09usleep_range(10000, 11000);
>
> Again, fsleep() and comment.
>
Noted.


>> +static const struct i2c_device_id qmc5883p_id[] =3D {
>> +=09{ "qmc5883p", 0 },
>> +=09{},
>
> IIO style for this is:
>
> =09{ }
>
> space between braces and no trailing comma.
>
Noted. Will take it up in v3.

Thanks for the in-depth review David. I really appreciate it.

Regards,
Hardik

