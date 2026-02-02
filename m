Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3083333A6ED
	for <linux-iio@vger.kernel.org>; Mon,  2 Feb 2026 10:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770028900; cv=none; b=dkzkEYgBN2cOdPetpE/SoHKU+TwdramzoLmOYviaK4ejQu1Mr6xzLaHlEE+hkXVuoQOq0RJ23cXAPjY2n2QFY+XKAcmdidvoRrKm8i7empGmTda5jry5oEsXBmuEhZPKshC4yTC510DWXhDQvpPDcQeR1OPTMk8sc0SyduTsVkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770028900; c=relaxed/simple;
	bh=ViRGWuuvDrl90eV5/nE8carTQSedywy+qxymWha/vyQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=POnci8Ht5QPXMLFe7uny6kelRsE07BS8CwYPSfK94zX3Bz+D8bqcBGVP5HBU34PD3pmAJriJGXkaI1fV3RepcazzgpkCXuu4xfgtdvmvWxPO1j8isgRBsH2MnqD0o55cIaZr+zJDaOmz8TVDuUyFMBHFfxsnYPjCpeksIwxFj5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QMlG4qoE; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QMlG4qoE"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-480706554beso46532235e9.1
        for <linux-iio@vger.kernel.org>; Mon, 02 Feb 2026 02:41:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770028897; x=1770633697; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UYl2pUzvvp9t2N/Y2K82g77GjaXLm/CxD6ybNLYvRS8=;
        b=QMlG4qoETXs5KqJ4kfr1JoqUSWdE8RH3pWZscBYcvVRj2ZZuAxjdx9net2QMfp6qbx
         x2O9N92fw3lx4mre8yR6p7NB/n2h8Sto4GnlaVvXiekZMfHY/PhRBz7UJKWXghQFLKtB
         RYMvJf/vmlhYKjMGcEOSFX5achLxmsgIrsBvjwxBSeXPGsQgBR06CHTiZdncyMpMG6F0
         lcZhYsaoOkr9UFFTfp5naK90v58SWPUOsUFCCQxSXkI4O4lg26e7SAqc37UZI/9QmxBb
         2PGeEyjiwmLr452oBlKZnq9Mj6Q05FjJfcefF5JPsYV9ceBKrR3pJuzb7foepuSjWMCX
         9aXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770028897; x=1770633697;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UYl2pUzvvp9t2N/Y2K82g77GjaXLm/CxD6ybNLYvRS8=;
        b=Mg6bSC4PmzhBB3t8ukdNJue3vJ7efuwZ3lsFYBpXZjxukNCPa8fbd4KuPMNqzKz2Du
         juO87kDmEU5q89r/tCguGoFufcVQllt+GYjWF2Lr5lLB/re4FCFZORsPlRQSTJkmioD6
         Th/dMf2dJww3YIei4gkMicASRBStTUGnurGENq6c8Wu7OBFrWD8VYtFHoofjVjzS+tZD
         CcuwUg5x1jak6FQGqXUcMPt9ZPdP9C6ykNYhLLBrVXeyZe+4IYJGkdyHK+fkq2g0RwtN
         dx60TAwsKd3Sr/ygUlkPTC3lJemjq9FY8uCWna3WewS/RukW5cpiOoKY16qmuatohJI2
         CTcg==
X-Gm-Message-State: AOJu0YxYMj6np7XbrGgd34l0LK4XqCTPiCy30AaHj7hH4H55dc2SRc+B
	vNkxK25StUUXfkEkVJONmZvdhucU0r0VE0Su0wLTa9E/TxRmBXKtntE0
X-Gm-Gg: AZuq6aJWCv8bOu08Zvcz+VDslg9cwx4L16H2xcOOEgC+VxLZgho/NQsqJntLJZsJ79k
	XWWxJ/c5SLWCbNdUotx0emeRZd9OEFOJtt+w+PiOBgAYSS6pFwXEK7TXxuvfvmHw5TfMeMurPoj
	kcPGKrZ0WtKWcQqrjUdglSSaoHHPBnMyDwVmC2abxcb3GLIm+LgX9bieFudiYpu8ezP4BgRRxYA
	CLdlDaF5NPuBRNLbWpE6ad21UWbO5HDSAF39OL5ey4Nc69daJojMikwpOuPjVdDhSngA0pgwuIq
	o62iuug2OXd2e6JRZ8LdK8Efbnsv8uaPQuNDUiXum9f7re1Tnbe7H5lE8NXR2OBABY+4X2HWtok
	kqNcbF0qf1+V1emHQW6d+0qIenLPe3f6Y91ZlQCb6DZQ2M9SuES0T3cl0jE3/q2pM57j0S0asN5
	50MLlE1OBT/2ozgieYhGA=
X-Received: by 2002:a05:600c:3f0d:b0:480:1e9e:f9d with SMTP id 5b1f17b1804b1-482db45deccmr133700485e9.8.1770028897450;
        Mon, 02 Feb 2026 02:41:37 -0800 (PST)
Received: from [192.168.1.187] ([148.63.225.166])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e10e483asm41296782f8f.3.2026.02.02.02.41.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 02:41:37 -0800 (PST)
Message-ID: <12b0fbc2f4c3a6be86089d9cab73cce1c3face0d.camel@gmail.com>
Subject: Re: [PATCH v5 4/4] iio: adc: ad9467: check for backend capabilities
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Tomas Melin <tomas.melin@vaisala.com>, Michael Hennerich	
 <Michael.Hennerich@analog.com>, Nuno Sa <nuno.sa@analog.com>, Lars-Peter
 Clausen <lars@metafoo.de>, Jonathan Cameron <jic23@kernel.org>, David
 Lechner	 <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>,
 Olivier Moysan	 <olivier.moysan@foss.st.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 02 Feb 2026 10:42:19 +0000
In-Reply-To: <20260130-b4-ad9467-optional-backend-v5-4-7da803ba7326@vaisala.com>
References: 
	<20260130-b4-ad9467-optional-backend-v5-0-7da803ba7326@vaisala.com>
	 <20260130-b4-ad9467-optional-backend-v5-4-7da803ba7326@vaisala.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-01-30 at 09:17 +0000, Tomas Melin wrote:
> Add capability checks for operation with backends that do not necessarily
> support full set of features, but are otherwise compatible with the devic=
e.
> This ensures a fully functional device, but with limited capabilities.
>=20
> Signed-off-by: Tomas Melin <tomas.melin@vaisala.com>
> ---
> =C2=A0drivers/iio/adc/ad9467.c | 69 ++++++++++++++++++++++++++++++-------=
-----------
> =C2=A01 file changed, 43 insertions(+), 26 deletions(-)
>=20
> diff --git a/drivers/iio/adc/ad9467.c b/drivers/iio/adc/ad9467.c
> index 59c3fa3bcc9b..d768f7bf2a1c 100644
> --- a/drivers/iio/adc/ad9467.c
> +++ b/drivers/iio/adc/ad9467.c
> @@ -913,7 +913,9 @@ static int __ad9467_update_clock(struct ad9467_state =
*st, long r_clk)
> =C2=A0		return ret;
> =C2=A0
> =C2=A0	guard(mutex)(&st->lock);
> -	return ad9467_calibrate(st);
> +	if (iio_backend_has_caps(st->back, IIO_BACKEND_CAP_CALIBRATION))
> +		return ad9467_calibrate(st);
> +	return 0;
> =C2=A0}
> =C2=A0
> =C2=A0static int ad9467_write_raw(struct iio_dev *indio_dev,
> @@ -1119,12 +1121,15 @@ static ssize_t ad9467_chan_test_mode_read(struct =
file *file,
> =C2=A0		len =3D scnprintf(buf, sizeof(buf), "Running \"%s\" Test:\n\t",
> =C2=A0				ad9467_test_modes[chan->mode]);
> =C2=A0
> -		ret =3D iio_backend_debugfs_print_chan_status(st->back, chan->idx,
> -							=C2=A0=C2=A0=C2=A0 buf + len,
> -							=C2=A0=C2=A0=C2=A0 sizeof(buf) - len);
> -		if (ret < 0)
> -			return ret;
> -		len +=3D ret;
> +		if (iio_backend_has_caps(st->back, IIO_BACKEND_CAP_CALIBRATION)) {
> +			ret =3D iio_backend_debugfs_print_chan_status(st->back,
> +								=C2=A0=C2=A0=C2=A0 chan->idx,
> +								=C2=A0=C2=A0=C2=A0 buf + len,
> +								=C2=A0=C2=A0=C2=A0 sizeof(buf) - len);
> +			if (ret < 0)
> +				return ret;
> +			len +=3D ret;

Given that we can't really check the status we could maybe do this in a bet=
ter way. See
below...
> +		}
> =C2=A0	} else if (chan->mode =3D=3D AN877_ADC_TESTMODE_OFF) {
> =C2=A0		len =3D scnprintf(buf, sizeof(buf), "No test Running...\n");
> =C2=A0	} else {
> @@ -1188,16 +1193,19 @@ static ssize_t ad9467_chan_test_mode_write(struct=
 file *file,
> =C2=A0			return ret;
> =C2=A0
> =C2=A0		/*=C2=A0 some patterns have a backend matching monitoring block *=
/
> -		if (mode =3D=3D AN877_ADC_TESTMODE_PN9_SEQ) {
> -			ret =3D ad9467_backend_testmode_on(st, chan->idx,
> +		if (iio_backend_has_caps(st->back,
> +					 IIO_BACKEND_CAP_CALIBRATION)) {
> +			if (mode =3D=3D AN877_ADC_TESTMODE_PN9_SEQ) {
> +				ret =3D ad9467_backend_testmode_on(st, chan->idx,
> =C2=A0							 IIO_BACKEND_ADI_PRBS_9A);
> -			if (ret)
> -				return ret;
> -		} else if (mode =3D=3D AN877_ADC_TESTMODE_PN23_SEQ) {
> -			ret =3D ad9467_backend_testmode_on(st, chan->idx,
> +				if (ret)
> +					return ret;
> +			} else if (mode =3D=3D AN877_ADC_TESTMODE_PN23_SEQ) {
> +				ret =3D ad9467_backend_testmode_on(st, chan->idx,
> =C2=A0							 IIO_BACKEND_ADI_PRBS_23A);
> -			if (ret)
> -				return ret;
> +				if (ret)
> +					return ret;
> +			}
> =C2=A0		}
> =C2=A0	}
> =C2=A0
> @@ -1263,8 +1271,10 @@ static void ad9467_debugfs_init(struct iio_dev *in=
dio_dev)
> =C2=A0	if (!st->chan_test)
> =C2=A0		return;
> =C2=A0
> -	debugfs_create_file("calibration_table_dump", 0400, d, st,
> -			=C2=A0=C2=A0=C2=A0 &ad9467_calib_table_fops);
> +	if (iio_backend_has_caps(st->back, IIO_BACKEND_CAP_CALIBRATION)) {
> +		debugfs_create_file("calibration_table_dump", 0400, d, st,
> +				=C2=A0=C2=A0=C2=A0 &ad9467_calib_table_fops);
> +	}
> =C2=A0
> =C2=A0	for (chan =3D 0; chan < st->info->num_channels; chan++) {
> =C2=A0		snprintf(attr_name, sizeof(attr_name), "in_voltage%u_test_mode",

Change the permissions for in_voltage%u_test_mode so that is WO in case we =
can't
IIO_BACKEND_CAP_CALIBRATION. You can even reuse the above check to tweak th=
e permissions
accordingly. Then no need to check for the capability in ad9467_chan_test_m=
ode_read()

- Nuno S=C3=A1
