Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792752045;
	b=fgxqwJbaHwzTEixX8oOYFi0pzHp/Jmm/8Dj28NBjJoXNJUW4OqTUhdAS/wHIr4dEPdgq
	 5kr/4FFTMd0kFmIslml+V3FjJGp02FCOcFnOx+KTV5Z+zePyQatjXrlpTZ3FLjlydYSpy
	 GO2hhap3br3ohgIYQX8GmbyCIvtwlrpopjMFIShVyF6O3nybz//T9CL5vKwUVeozC8bjj
	 IvYJ31SuF8hzKTF38+9MP+7iTlnz53KcKokoDo4BosMAvXjgwnmqEbTEKS0Jyo0v3f88+
	 +ZJ+MG4T+acI4ahzTVLSLNmQIw4GjXRt1VeZX5wyAFlY178P5peyb6npJDfnCKqya9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792752045;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:
	 X-Google-Original-From:Date:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=PU3pthY8C33I9auXpGTnmiUI6trGGQ/gwWp/L1g0V2U=;
	b=P9eA4mryGsqNHfpuc0bBfwGp+CUgTgJTbMqwgIiJ3L7jeVhWdd67/pN0XV0z9il6UZM1
	 bMv1ECua/NPBSv909MAFj/VGtiWUHqAoG6fjPo1NnUPZcKiDaaJRq7RdGm1PAnLiDFjyM
	 Zu8QlzfqUsrFTBgu9XqN4A20Lgwed7RuGEB2XpC43gTezcyfrfRx0Srczl/x3LRYwIKvi
	 jBhqLqfFBz/OWRyvBWIiJOPPzT6HHdl3jjrL/1zI74z8V34XAUaRPRqK/UlQsT2NcMqRt
	 +fT51w8YcGzpO1i5xfgktQAK3PXJfNsBMv+NrJpBQ7K0EO3cilcWsmTSaVuWDyMojZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=qDHUhalw;
	arc=none smtp.remote-ip=209.85.222.54
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B85E2606A328
	for <linux-iio@vger.kernel.org>; Fri, 23 Oct 2026 10:40:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B85E2606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=qDHUhalw
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-98febe968deso560902241.0
        for <linux-iio@vger.kernel.org>; Fri, 23 Oct 2026 03:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792752044; x=1793356844; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PU3pthY8C33I9auXpGTnmiUI6trGGQ/gwWp/L1g0V2U=;
        b=qDHUhalwvENGkYicXhp/819z0Cb38eGLFlBd2GcJ+kd+woA2F1L8l9kYdTAygGzV41
         jjsjJKPrcmEv5ryCEEnITghJ9icCuEe79uAC2TIerrCYohBBHBLTZiMIiSOnL7RgoXOc
         q6Gpso+ZmXyHzx5yBUnX/tlI6/9r0A95XfDV3X7yX3MMwNrPcA9L+Z8BuguX0OIOAqlt
         JHwbigQt7F23Hncc/dEgAZqZdYcICFBMwluD4DA7c4nwdtfDwE9g22DxGn7k0FaCEkPY
         uTBI9O6EHgKlpntPbaAxkPlFVAJrawT3KfULj/F4BGcIPiZqEfUbhbaRfaayJgz0OljI
         ukyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792752044; x=1793356844;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PU3pthY8C33I9auXpGTnmiUI6trGGQ/gwWp/L1g0V2U=;
        b=f+DEaREplvrJtJj5L3EfaYm0C+Kx1KARmiDEtcxdQGQJLa/HwprAmx8SM2z6SvWzgy
         uUn9sN97eCZkX+IUHFlPw1t9f9Vizi3Ps2sDISL+AzRtS/tHc+xhGZ5+dERwXrIJ9JNA
         tBTPqSmSkVM5clzuU8bvfXkeCfa2CjFM88KEYMzyYjbPT4+ufqsVppp8iQFurNxajm47
         taJyYwDbtqv9NhMyFpiQFD3/FIbsVy3OLbaVg4P+kiFqZR/cTPOFU1lckoaEfc4S0DXc
         KxcaSKTU5WilJbUkgaWuYlpwwHWfjnMqvYop+UoDoZBFnS0qVevjoLIpS4KeK7VcT0NE
         zrQg==
X-Gm-Message-State: AFq9FYLriQZEQWrkJNhfcBCFmjcwnOgCDE0/xvtzr6hE5QqVvOzkZ1i6
	TNmEROJpDHfkMsZHyDTxJrzVAb1joCkUBxtVmdyCdgvfg1s7cR4himP9rA1WcGkN
X-Gm-Gg: AYBFou2G0cDVS4sNhBJgPPtz7WuAAtfBancj3EFPVv/Pvaror1Twju9J/1kF6XVJDEy
	1u6aR2NKbGF7dJvX3CmvatsyAZ47AbtKZFuih35wxuXrQVk7d5HrAgJOAHfgdmvSs1fjAwvr616
	3YcgujARphdFKLzIndfJVw3Iu+QdFej9dyajsxFYq2kMVO2KTqYD3QtU02QD2KtdoNFo5CT1Ct0
	HMzUeuwrqaCzz8ymLvPqFhU5PQlBkaCYfetm6u11Onr7FAPTwxYFVfJslGd2PAQYwkYXmg5wRW9
	hF/GpmJKssiMoYCx5LS2mvm6n41SjEE+HnwRbLVWk7T9/VS5sXWkU2ooYKmK6vLDIep9AET7Ou4
	DudcUQDEm0HjTBf69OvNt0yvJ+KqupnuoCrXctPYZF7CF3H9+u1BDxqpdTj52Pae7oho+6IIWPM
	iBeavDSECiZHcJ9hTKR0eu7G0Ng6Mn+lBDhjkf9RsoZOhk+M6o08HzuDFBw2PqgZVA4N4/0Y1TH
	2yW1QDrYQ+xaRfrkKKJ9EFFssIOBP1a6hhCriIAjT3YzQersdc3d1+XoRaOTOxngKzzsZDsu7LN
	ijcwoAzggjvUsyoWC6MB6j9dLZ8jOGfZWq20J7mAAgQmVgjOtVg=
X-Received: by 2002:a05:6102:41a1:b0:7cb:bda3:27ab with SMTP id ada2fe7eead31-7ccc32eac6amr858728137.13.1792752043685;
        Fri, 23 Oct 2026 03:40:43 -0700 (PDT)
Received: from RDEALENC-L01.ad.analog.com (158.95.44.30.netskope-rdns.com. [158.95.44.30])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ec13deaba5sm1974736e0c.1.2026.10.23.03.40.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 03:40:42 -0700 (PDT)
From: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
X-Google-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Date: Fri, 23 Oct 2026 07:40:32 -0300
To: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux@analog.com, devicetree@vger.kernel.org, linux-pwm@vger.kernel.org, 
	linux-doc@vger.kernel.org, Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Cc: Olivier Moysan <olivier.moysan@foss.st.com>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	Andy Shevchenko <andy@kernel.org>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v2 07/10] iio: frequency: ad9910: support drctl control
Message-ID: <pg7pcjaaxuu6vmi4qowgaefyo3mynrvmiu6iazzormyvc5kiat@4hiqrtwbw2gg>
References: <20261022-ad9910-backend-support-v2-0-0ff7f0bff326@analog.com>
 <20261022-ad9910-backend-support-v2-7-0ff7f0bff326@analog.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261022-ad9910-backend-support-v2-7-0ff7f0bff326@analog.com>

On 22/10/26 12:19, Rodrigo Alencar wrote:
> The DRCTL pin controls the slope direction of the AD9910 digital ramp
> generator (DRG). When dwell is enabled at a ramp limit, the DRG holds
> that limit until the next DRCTL transition, so the sweep pattern is
> defined by the waveform applied to that pin, which can be generated by
> a PWM.
> 
> Get the optional "drctl" PWM and expose the integration_time attribute
> in the DRG ramp up and ramp down channels, which sets the time interval
> assigned to each ramp direction while the sweep parameter is accumulating.

...

> +	st->drctl_pwm = devm_pwm_get(dev, "drctl");
> +	if (IS_ERR(st->drctl_pwm)) {
> +		ret = PTR_ERR(st->drctl_pwm);
> +		if (ret != -ENOENT && ret != -ENODEV)

Sashiko points out the problem with passing a non-nul con_id to devm_pwm_get(),
which would get us EINVAL or ENODATA from of_property_match_string(), and that
would break the intent here for an optional pwm. Similar to what we tried to
achieve with an optional IIO backend. I wonder what is the best strategy here
(ascending order of complexity):

* Use con_id = NULL as DRCTL is the only pwm signal being considered at this point.
* Local workaround by checking for EINVAL and ENODATA too
* Convert error codes from of_property_match_string() in of_pwm_get()
  implementation and create a devm_pwm_get_optional(), which would only check
  for ENODEV and ENOENT.

The pwm is optional as the digital ramp generator is one of the possible modes
to be used.

> +			return dev_err_probe(dev, PTR_ERR(st->drctl_pwm),
> +					     "failed to get drctl pwm\n");
> +		st->drctl_pwm = NULL;
> +	} else {
> +		ret = devm_add_action_or_reset(dev, ad9910_drctl_disable_action,
> +					       st->drctl_pwm);
> +		if (ret)
> +			return dev_err_probe(dev, ret,
> +					     "failed to add drctl disable action\n");
> +	}

-- 
Kind regards,

Rodrigo Alencar
