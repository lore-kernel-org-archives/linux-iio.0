Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5565046AF0E
	for <linux-iio@vger.kernel.org>; Tue, 14 Jul 2026 13:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784035975; cv=pass; b=D9yx7EhvQ0WbiRE2Kb57kr9ZBDN0MO9asn6018yTsh+lZSF935C/jnKtnrDfGFG8+CJuqJYG3TzudefWZMQHtUr7nlEc8a4/Z/yumaQsPuHNkF+PU2+TD1kM6AXgQVo8hDJ5DSywMxgdlaI5yKQ8/PHIFpFoAXP5TNblfSmhJac=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784035975; c=relaxed/simple;
	bh=xMYgbeZWEkYZKWpJP/1b9kbmlPmh5Bba+PqXdvA1L9g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sA4NFSpDQufnod8EFqeLlUk71vPatVA6u4agXlBzZHxxgmGnOkHhA5HIsKaeEEoECUHBFjtvnaFvhEMGsFYp9ya2EFpwrCXvoKjVGakqQH1bqATYZmxbjKoUOSo16Vg1E8mWEi6brIkIc6tr1i9OJsrTgXIslLd2+vkNfrOe4A8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O1KybUSF; arc=pass smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O1KybUSF"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-c9b373d5af0so3048418a12.2
        for <linux-iio@vger.kernel.org>; Tue, 14 Jul 2026 06:32:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784035972; cv=none;
        d=google.com; s=arc-20260327;
        b=ciraBEzFz99gjAbrlS6qpzBATm/l94eRVY3c51GQZJFhxysQek/sgR2tPi3K/cmGbr
         JpADdquGbuY3jikqh7ULLJrjkhgW7AuoTVei0dBUjdu/jRlp5jH1TBxhKZTPXxx2DAaf
         ZFyk11rVxyr5VI5fe9El05BGCXTZ3G3zPxXLpK3/fMgF/z81a6/lv8CGc2hf/W+m+Rnb
         de1AO2Fgn6iEn+6PbbzpJounNoUOxqSAN+qU2I1hM0xClZ54vWOMw8RUWFOQCCKwey9q
         53+CcoYjsx0RBRTkmtlXnWKS484xLnY/ZURAWWdsSG+1E/M127Oq9X2vQUeeqpxE6w+Y
         6MeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xMYgbeZWEkYZKWpJP/1b9kbmlPmh5Bba+PqXdvA1L9g=;
        fh=ZIsF31ZnEj0XT3D9n0kr7amQ/ZGQtftYfZIooC37CwE=;
        b=fJzrPTVBwrDNOcc5YLLQTSMvh95LOZiI7GquZxrXuaj6mP0v23Y+J42EzFS1ZAXsst
         Z9GM/wsNODzjYPEaU3afO7XcU8X5n125G5bCawycxL4lwF2F8w5YiTsvdftNN10zkuzb
         xvjv4R4SikUrLA7F5XRr8faVkgKTdy5bRX8IHjXYfGJnS4jnVNTTuNqhLDHbJD1C19Ry
         tBlll11QLuFgn83Qxgs2YRnCbCVmwkVRQLyW7xikItnWPetzha9EhpZ0zoLshb+q6N0F
         oYdSn6wFB1mNOxws/K9wksNiRtdamlWzclj9OUx19l8Xa4ykeKBt9Xq4fhxiS1OCW8jG
         fWcw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784035972; x=1784640772; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xMYgbeZWEkYZKWpJP/1b9kbmlPmh5Bba+PqXdvA1L9g=;
        b=O1KybUSFHz0QdVul2k4o9VEGyKBL6uHP//tdT0Mdcmjy4tIEXxbFxE7c2P00asfBky
         TsnK2HZDQKGxxWs5geoIR9LboD6ul49LJsuU/H9Nf6Y2gVnXejBUBylq14ZHO3g1LNM+
         qCPApxKO1IGmye51vZWYLuoY4PLjFvA/xxcf0N36UoWRCmo/Tk2UwHa8EOcIXENrY132
         Ko1C1T11oYkzeIOg2//cJYwGAA0agX6SGKP9l44NvPtFCO37sS38zYusILJd2w+Aa1aw
         bt8Fs8AZ1FceZqcRsxIrLbmSJEFY4jxT+KU49vyaO9p1MxuEQyJUf4Lioew2GIMLcuef
         s8FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784035972; x=1784640772;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xMYgbeZWEkYZKWpJP/1b9kbmlPmh5Bba+PqXdvA1L9g=;
        b=FQQVrL8jWhWJtvzmqHZ5Z1T1cLWLJh19FJeDhuqvglHnbUReWM7hXR0+S0GlUW5qzW
         QfSOXgJt0GskeTrxf7fRTFZQmAI0GrR236W3W+TLGLYhWYx0xg/quC2DMk6Hx1nYsk1p
         AA9mTTLVVerOZuU6D+oKuNOG+C0PETSY9zYdqrGp0kZdJ8UuZCUB6dgQP9ew0BoKjKu7
         1xmPME5d0aYu4IQBs+pggJ/N17gavYX1DFky2ykcYbaMVS8vq4fV/E3+4UIWEPoDnMky
         mFXms1/5e8Ad7Je+oYLmz0ecpL4I0rPw7oorTopAFeca0bGFo+n444H5Ov+9e43R4825
         2Ylw==
X-Forwarded-Encrypted: i=1; AHgh+RrVYdjY/peudU48orBSTMLh/1NuPGg5Ypgq/s9XPY9tPb2bs/YQ71DUNEozvIori905iKxKLnviY7w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMwTl/8hY4Cftm8SPXypFHT+5x5arfHZq5lhpgDt51Sam/zub8
	pVzCkP+m8Ql0Cthp+jVOesh/3PkGqMamGwRweSZJs8E6VnwUeJ0fmBnB7S2M+HERkkBsSNvBtl5
	1vgSVlmcTP+UFY/Ek3kCnY298A7lYphM=
X-Gm-Gg: AfdE7cmWi9UhC+D1m1+raOOjdQ2QEqsdeogkR4XHNgbNlRxR+V9ZDNa12UlNl+EdqtB
	mGa9dkWwlq704xZZbHTG9M3m7yZP/fSViXyroo+yVtsti3j4L5baC7AQ4PW//W4ZM8GxwX+ltIK
	VaoKWpAC9e6eM0L6WvQXmR6WSc1su32GNDu/C4ubPGnGKt7M9ev3NQGikOTGfty4ej1ClPvwDv8
	19EhrD9MEpgr9g2KQePDoru3qIqj5wEi6uyK8KNXcrsuV/hLQ0naiNLFCz5QasfMOW21EqL2Zh3
	bssCEbKRh6qSGL4keHiPNbEPji/efg==
X-Received: by 2002:a05:6a21:398d:b0:3c0:9c19:65c2 with SMTP id
 adf61e73a8af0-3c110a7780amr14294440637.74.1784035971780; Tue, 14 Jul 2026
 06:32:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260617080031.99156-1-clamor95@gmail.com> <20260617080031.99156-7-clamor95@gmail.com>
 <akeHfV45fs_wabFl@hovoldconsulting.com>
In-Reply-To: <akeHfV45fs_wabFl@hovoldconsulting.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Tue, 14 Jul 2026 16:32:40 +0300
X-Gm-Features: AUfX_mybrBIYYttKuc4kdlGjodzpsKD3b6Tkn0zZS6Q6ac4kDrP0-C3ai8FD94Q
Message-ID: <CAPVz0n1groC-4MxU-sjyPEDHYWqAweyBmVNC+iX4mVa_D3SnDA@mail.gmail.com>
Subject: Re: [PATCH v5 06/14] mfd: lm3533-core: Remove redundant pdata helpers
To: Johan Hovold <johan@kernel.org>
Cc: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>, 
	Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Helge Deller <deller@gmx.de>, dri-devel@lists.freedesktop.org, 
	linux-leds@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
	linux-fbdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=BF=D1=82, 3 =D0=BB=D0=B8=D0=BF. 2026=E2=80=AF=D1=80. =D0=BE 12:57 Johan=
 Hovold <johan@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Wed, Jun 17, 2026 at 11:00:23AM +0300, Svyatoslav Ryhel wrote:
> > The lm3533_set_boost_freq() and lm3533_set_boost_ovp() functions are us=
ed
> > only in lm3533_device_setup(), which in turn is only called by
> > lm3533_device_init(). Incorporate their code directly into
> > lm3533_device_init() to simplify driver readability.
>
> Again, this isn't needed. Why are you removing abstraction that improve
> readability?
>

Adding helpers to wrap custom regmap wrappers seems redundant. Regmap
operations are pretty self explanatory without need in one-time-use
helpers.

> Johan
