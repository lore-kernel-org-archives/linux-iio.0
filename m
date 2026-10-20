Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792500203;
	b=WBKlAPLDTJDZe5VH2DryQXV0OBsN7UAek5HjmzECJgf20q0m2OkCyfM8uup4Yp7dgCZh
	 5fPD5KgHlXg4aooHQ5g2EDtMUtd3DwXULvxL02W3KS/iAEAg8NnvmSrydheN1s3Q3ZUUP
	 I4kfDi7PGhQv1l6e+U3/FAS8hDOifd+Emqk4bruGGCBfJnTtQXRildjr3EiaXe6d4ScDj
	 vPAGnVTIxyc8sntB4+6QsaYGtw6QbrIsgRoIY9MiOEBR+I7zEtL7Ul/7cBZRMEH5ljHUX
	 nWMYGWbWgIdB/mwTv+lsTgfK7eiolf4vjMpBUxI/2VBDeoW3Wpx+Uz0+SBobm4rzXOA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792500203;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:
	 X-Google-Original-From:Date:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=ADOCDelITMEX4p4h4TfmU1ayoJRVyWEUw/EIxGZkeis=;
	b=PtOlHapIhZkXuzhO3PjJ4kDsp+LutjzFCJ4T5WsCgFTI7NnAyDenUPd7ojE38XjEwyvc
	 UuVCotzMEcs4TwIaBdkeCInDTDwmpkqwI0KF2ibw1LwX+jpbZGHb+qJz4tE9hXi86VbGM
	 FE7zfPRZJ3o8l9jbsHQWgsV1k3NoekLSUbKZ3NvLIi7uuzMcdWMagOOfAybMoAsC+Eh1W
	 Bn1iMnsL4eIcuNk9l15l4ccuN+kTuEdGdtuEMiMshSEh8Z3odo1iSMzrqP5uIJHBpltzS
	 YAq0OZUSVMg85AJ0lDArTdr6gi7fulzSBsfFbZPE23QPeUwpym1O0B6ZwjUL6UcC0Ng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=iBE7MP4L;
	arc=none smtp.remote-ip=74.125.82.173
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D38660A2636
	for <linux-iio@vger.kernel.org>; Tue, 20 Oct 2026 12:43:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1D38660A2636
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=iBE7MP4L
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-36681e85e87so589133eec.1
        for <linux-iio@vger.kernel.org>; Tue, 20 Oct 2026 05:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792500202; x=1793105002; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:date
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ADOCDelITMEX4p4h4TfmU1ayoJRVyWEUw/EIxGZkeis=;
        b=iBE7MP4LiiXqwWMF8SJq2RfYIZ2T7MJv8zOoaiOFkLAV1WuVTpqMVKlupysFYR9agD
         JoIUmQsM2Wd+Jr1zPqhHEqXgvd8LIP0lBJOxxr0v3fo3flQ7529Ib/Xi4OR89hlo8lqf
         Dxd3GUFj1P5Ej+lsMC82WQKoc+HsZxvIpghogS7SsPkwm06fuPr5T8/Gm/N7/u4H8qCu
         qahCwD73SDmXZB+GPZ2IKk2ROTHCQL0k+Pyw+T3Mwnb3VB1aVYDmNAH1yAE2PBU7au5L
         ywiezeq5X35K+GTEhYn4Q+rUR8qPttM0Gogem86PxNmwgMQksM51g2JBijd5II/rMhB0
         edxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792500202; x=1793105002;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:date
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ADOCDelITMEX4p4h4TfmU1ayoJRVyWEUw/EIxGZkeis=;
        b=BFKLhybRdtDDBfBxUue3quNtOzYxkgkgslwr5oLs75tKTrTYFDVF5t9ZeUmh6rXSwj
         tuNHTSwcccZiVcOdLo7Mvdzs7ekpl+bPWdI+v1v1TFVnqV/Au2+F9+05qiDaQaDj8EJX
         C8Kgf80wQofZoSrMUirSAyXW3VDaDu0ZQqFEmUg1D1fZFsRnHmOVEmURxwtIbsoET8TL
         o2Kck0hgetsViEjEKhmR7RBN8pgeTtmydBM68MFT+eLhYzrkVfDhMEJeF8UTweHFQGaO
         vHclcV0GLLuOfDRg+BZopYXm3t986hk17NDIfT0eedL587F9kjGUPD0TTBqWJft2FaYb
         lxvg==
X-Gm-Message-State: AFq9FYKJpj4u+QtzadiKZe55FCTGOXvvTEiWNDZ02QhP6SbUcLTe7qGn
	c7/igWce6tC5WZZYooL8w3ZK6+YsfQj9MmUzxY8tGP6MrTehaPA7pmCr
X-Gm-Gg: AYBFou3BQEPqt9dxb2SCvWtlEx/xnLlGLLgWqw187kxMZAZ8hrJAoi3uv6KhAWXDArx
	1PGu0mRF+CWQ2eBLrqt8SufD6a8c8oyAWw2bFAgnOyCMgBgW2QWosY4SZuR4Cla7qSAYzPJuVV9
	rfKlHqLkywjbaR2eitVbv+02x8/mzdnwOLYZLgvj0JD8LnDvhtkADqaAFEND6/yHwif1VIjbPOw
	WStO0c5WVyxBNfXFaqkz7uqXDekvB+n04FkKyGwwGskUuGvbXu1MpBTCAgaTCczKTCt3Utl87YW
	aOgSNUtl68Hhb3VIyrW4CexULG+SCR6D/O3zI9pAFO73mMiNMUdO+a9TumgdHoYRJ8Cvi4oPPoH
	SycZiHeRy+Kdo4PFsRHtCC+BwVI5c790GEazWQv298hGQzI2wGFV60AM/AolHdKMIO2RqEPD6+q
	vnLNtDb+7s9i6+7opwYxf8AqXilFweCvwlZqoqwr/SWuILzTOT6o6yYo4uW9FAkMt+FyDOmeqMj
	1SF0ruR3B6VtrohdXD84h2CLy8dOzE491THZPaB1BQUas6N0nHToq4wDpM70IACQnJk30H3zwpC
	V6da
X-Received: by 2002:a05:7300:de49:b0:35a:7020:c08a with SMTP id 5a478bee46e88-361a186094cmr14849051eec.19.1792500202072;
        Tue, 20 Oct 2026 05:43:22 -0700 (PDT)
Received: from RDEALENC-L01.ad.analog.com (158.95.44.31.netskope-rdns.com. [158.95.44.31])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-360820a79c7sm40204577eec.18.2026.10.20.05.43.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 05:43:21 -0700 (PDT)
From: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
X-Google-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Date: Tue, 20 Oct 2026 09:43:07 -0300
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux@analog.com, devicetree@vger.kernel.org, linux-pwm@vger.kernel.org, 
	linux-doc@vger.kernel.org, Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>, 
	Olivier Moysan <olivier.moysan@foss.st.com>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH 07/10] iio: frequency: ad9910: support drctl control
Message-ID: <v5meo6y3jn6vcmv7kqtbqqv3bq36xb6pk2kysdwpwkfvixtqzl@rojpaxrte4sw>
References: <20261015-ad9910-backend-support-v1-0-3c21648c8e26@analog.com>
 <20261015-ad9910-backend-support-v1-7-3c21648c8e26@analog.com>
 <atdcOsaDbtaQJd-9@monoceros>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <atdcOsaDbtaQJd-9@monoceros>

On 20/10/26 14:23, Uwe Kleine-König wrote:
> On Thu, Oct 15, 2026 at 01:49:47PM -0300, Rodrigo Alencar via B4 Relay wrote:
> > +static int ad9910_drctl_sync(struct ad9910_state *st)
> > +{
> > +	struct pwm_state state;
> > +	bool ndh, ndl;
> > +	int ret;
> > +
> > +	if (!st->drctl_pwm)
> > +		return 0;
> > +
> > +	ndh = FIELD_GET(AD9910_CFR2_DRG_NO_DWELL_HIGH_MSK,
> > +			st->reg[AD9910_REG_CFR2].val32);
> > +	ndl = FIELD_GET(AD9910_CFR2_DRG_NO_DWELL_LOW_MSK,
> > +			st->reg[AD9910_REG_CFR2].val32);
> > +
> > +	pwm_init_state(st->drctl_pwm, &state);
> > +
> > +	if (!ndh && ndl) {
> > +		state.duty_cycle = st->ramp_down_time_ns / 2;
> > +		state.period = st->ramp_down_time_ns;
> > +		state.polarity = PWM_POLARITY_INVERSED;
> > +	} else if (ndh && !ndl) {
> > +		state.duty_cycle = st->ramp_up_time_ns / 2;
> > +		state.period = st->ramp_up_time_ns;
> > +		state.polarity = PWM_POLARITY_NORMAL;
> > +	} else if (!ndh && !ndl) {
> > +		state.duty_cycle = st->ramp_up_time_ns;
> > +		state.period = st->ramp_up_time_ns + st->ramp_down_time_ns;
> > +		state.polarity = PWM_POLARITY_NORMAL;
> > +	} else {
> > +		state.duty_cycle = 0;
> > +		state.period = st->ramp_up_time_ns + st->ramp_down_time_ns;
> > +		state.polarity = PWM_POLARITY_NORMAL;
> > +	}
> > +
> > +	if (!state.period) {
> > +		pwm_disable(st->drctl_pwm);
> > +		return 0;
> > +	}
> > +
> > +	state.enabled = true;
> > +	ret = pwm_apply_might_sleep(st->drctl_pwm, &state);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = pwm_get_state_hw(st->drctl_pwm, &state);
> > +	if (ret)
> > +		return ret;
> 
> Does enabling the PWM have any side effects? Are you doing that only to
> be able to call pwm_get_state_hw() and thus find out what the resulting
> output looks like? In that case, pwm_round_waveform_might_sleep() might
> be your friend.

Thanks for pointing this out, will look into that.

> 
> > +
> > +	if (!ndh && ndl) {
> > +		st->ramp_down_time_ns = state.period;
> > +	} else if (ndh && !ndl) {
> > +		st->ramp_up_time_ns = state.period;
> > +	} else if (!ndh && !ndl) {
> > +		st->ramp_up_time_ns = state.duty_cycle;
> > +		st->ramp_down_time_ns = state.period - st->ramp_up_time_ns;
> > +	}
> 
> So the configuration depends on the previous state of the
> AD9910_REG_CFR2 register? That's a recipe for surprises?!

Expect not surprises. It depends on the current state of the
no-dwell modes, which defines bidirectional, ramp-up or
ramp-down behavior.

That is documented in a later patch. ad9910_drctl_sync() is
called when dwell_en or integration_time attributes are changed.

-- 
Kind regards,

Rodrigo Alencar
