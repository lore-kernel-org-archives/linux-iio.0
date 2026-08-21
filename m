Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20105303A0D
	for <linux-iio@vger.kernel.org>; Fri, 21 Aug 2026 03:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787283295; cv=pass; b=NPO1jQev47twiKKY7UFuHJ4JdU/d7ml6LH0oddl5bXUVIB5KBIZgoXjJvO3cx2BMn7QpjG8Yhjoj8JvgYq7U08wMX+TqBqi4ShO0S+1I4AnFxVLx7X/kIatNyQQ3lTubEibplU/pOj5rMDiYvAfpmi4UDPSHze9CqxpcfO38RLM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787283295; c=relaxed/simple;
	bh=R6zTZuf9kfoU7qSR3weAndpd4l5VqXSimXgA67uEyLc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qjqgF1OvgwzIfeuwCar+NV3qxPhgk3+Az/9bBbt6fPHcuhqR/W7JuC5HG3CISDaiTh28MQhMMBGtyan99TZYRlFYhxNALjOmwKId0yNXXSa2tIcu82k8DK6yVcWh37kNZROZLsfsTUq9h6z+AE2N5Szj4oD6Zq6/YYJDJNWqUQ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AA+wdo1Y; arc=pass smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AA+wdo1Y"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-3a1585728b5so5358211fa.0
        for <linux-iio@vger.kernel.org>; Thu, 20 Aug 2026 20:34:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787283292; cv=none;
        d=google.com; s=arc-20260327;
        b=o1kP56TXkIgN5PM1kNV2V9ZKLbRFo+tH1dG6tjWKaalelfG3+c2E2Qj8oTtiR3X3XK
         xj4skO3XR0ZGif/C2hX9XEC7GlOkr9yFFmbxnvSgJbmkbaIecJN0weAYk3Z1HYV+m++h
         p0nIYVgUDHqm9z8XoDSUqH2lyOppQZnOw0QE8a3S7fLs4kzaGbkNtUHF/yRj7bC/Ulyw
         P61v6biNttNfDrThPoECuqaa1wHCZfkKmFu6JKaW9rgNVqpUIWRYhEUrYlkEinoMUXz5
         M0xPEC/ch1HJ9PZuiIIuczECrzkCWvzv7k69H6HiNogWPfrDVD7eWUzMIZFS3eUFK6Jx
         CNpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=R6zTZuf9kfoU7qSR3weAndpd4l5VqXSimXgA67uEyLc=;
        fh=iioq2Hl9LtQ2abIjA0DMvapzz5bQ803ZOEYjvnSNrqQ=;
        b=ZCJsdkTZ7eFz3iWnnQIBgnK7zxOQSU/jYvvih1vrpCAE8Ebu90z/I03VPW8yTwQedF
         5Np4Zpj10RRNJDP/JhB/Fa6KqvJYdOeFB4M9JSZz/UYMpH3adJdmlaJegjX4vZ68N7JL
         tTBCxSbLGmUWxHLDO2ypmxFDwR4/MO9oLRwrlmINhlT90yOV82a266Wan3hKZic4bxy5
         18Bq6IE3HZih/6MJ4Wj2aa1Ofbso+ZzhwJ3Ho64x3yBRDpUiPucJL6/nfG0cVDC7gHIo
         Iy0yLOyEggThT7wh45dHuf7j/ZlJ6jsoRIn2bKyenk3usSm6AGaWdZocs4GnkEd1kVfi
         fNQA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787283292; x=1787888092; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=R6zTZuf9kfoU7qSR3weAndpd4l5VqXSimXgA67uEyLc=;
        b=AA+wdo1YJo+ySQ7xUcBNyBe67CFI+PJherWEH/dkCBREh17063qCIi6uTOMycn9hTs
         KURNsj6/gCU5633qBW6g8cXLFJAGJqTFTWPBBxa89wdiUT77PgykCCJoBIiiB0zrAKCq
         qjcNzfMNXk9HrwUlVSES6LKGrMUOGvvJFtsJybFHw41d1t8QhRCLOFaQFv69LeeGu1Qc
         AUD9Kyy5yAiwU8faVPTTkLA+87RAEt0I2hN8dq9XAlHXNU8N9JzCUpmT+rYTbMZ+8cf9
         4st54hKpEjfCMQvwYpCl2RB/NekGIYxod0DgCgwkMB+H/AZgGAgPccVV7fsLnTMN+dWG
         PyrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787283292; x=1787888092;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=R6zTZuf9kfoU7qSR3weAndpd4l5VqXSimXgA67uEyLc=;
        b=F4t49Du0TxmZ7iVe/y5A5uRa+/b77r9cPAeQTov0iSh4FUt4U7Y4XIG4ybFYtOoPC2
         5he5Z3WYrF/bERgHjOSNX+Ius2WBs44Zv42aNG0gczvNq2c9vk/g7iOIYS0sjgCzXqXN
         fcWN1FFG04vCLUecFZCUAFbBCOOa2FySDLdx4L7f+BTIJG8GTkP+byhXdXcYPHkwQjWA
         dlrSEa6DjboNfJIpiJNLGMuIdHnkvpa1CM57fsoE0le2x8p7JZS7XL3JC3aDUinohcT+
         7ybDHVqKJX7RTLPXXogkBqdKsQ8BjPGAngt4Bo3nEAL5ELnHgsiNTyAi418JDJZjnVkx
         X8aw==
X-Forwarded-Encrypted: i=1; AHgh+RrS5uHWwY6OrcJVkFYTtaZwZTciZOPD3jGiVDnHv9P64MfQQkQ4JqS9mlL/zadZiBtxhpRjOTQOFjE=@vger.kernel.org
X-Gm-Message-State: AFuF++mfSXwwM9e8R/5svEY+LrkqXZt21xNlkAYfFhrTATL3hs4mlscd
	ByfW2YD6LOppbRGziMWs76+zBmmW1zE9eV8A1D3B6ptTk36itHXLk+Mb/94rUJZdC+3V1eztXvx
	b0wSa+CiGVfGOM+0tY76xbQTNxAYZUlg=
X-Gm-Gg: AR+sD10iUVzG8TY1VJr/7xo8iQ3jrk//y0OGfMnGADz5dE528ZlB7G3utFOOax0rL6M
	5xqtyF4eiQ2W0L/RYl9XV2JGSHiRwT9Yqt4tymNAfY+FOZmWuhX/BRJBJHrhsl/hIfXW/Smljne
	v7ERbsgq1H5jk2aPaW+QI7T25FGaiqw9zFxprtpUvLGv24sYXusnZTa18Tkct1TVt3EYdfz2D6G
	uapSuPZgfDg9qlRu7vD0n2iPCMjd+zsEtHIs7q6ipqy40RJDSpHNoHJ21Wg27X4e+H4Vht5ehWx
	RDQvadR7h77KFbovRlQyHVqr0/mM/f0Vwlyr2mAkKTSEhg==
X-Received: by 2002:a05:651c:b29:b0:39b:2757:c1d3 with SMTP id
 38308e7fff4ca-3a1aec08881mr7351981fa.9.1787283291995; Thu, 20 Aug 2026
 20:34:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260820-ti-ads112c04-driver-v6-0-0e8f0aacce9b@gmail.com> <20260821022554.5382aa7b@jic23-huawei>
In-Reply-To: <20260821022554.5382aa7b@jic23-huawei>
From: Kyle Hsieh <kylehsieh1995@gmail.com>
Date: Fri, 21 Aug 2026 11:37:57 +0800
X-Gm-Features: AcwNN1UVNIit8ce4OqAMK9uy7buk3YHHYSF3ZQJ_6XiKomuXk4JwNTyOvMAkDPw
Message-ID: <CAF7HswO-K3-g9ki366BTEY1pkf-Vvb4ohQCEM7oS3XhWXG00aw@mail.gmail.com>
Subject: Re: [PATCH v6 0/2] iio: adc: Add support for Texas Instruments ADS112C04
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Conor Dooley <conor.dooley@microchip.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 21, 2026 at 9:25=E2=80=AFAM Jonathan Cameron <jic23@kernel.org>=
 wrote:
>
> On Thu, 20 Aug 2026 15:51:50 +0800
> Kyle Hsieh <kylehsieh1995@gmail.com> wrote:
>
> > This patch series introduces support for the Texas Instruments ADS112C0=
4
> > Analog-to-Digital Converters.
> >
> > The ADS112C04 (16-bit) is precision, low-power, delta-sigma ADCs with
> > an I2C interface. They feature a flexible input multiplexer supporting
> > single-ended and differential measurements, a programmable gain amplifi=
er,
> > and an internal voltage reference.
> >
> > Note: While this chip shares similarities with the ADS112C14 (currently
> > being upstreamed by David Lechner), the register maps and feature sets
> > are sufficiently different to warrant a separate driver. However, the
> > DT bindings and channel parsing logic have been aligned with the
> > ADS112C14 conventions.
> >
> > This initial submission provides a minimal feature set (single-shot
> > conversions and basic DRDY interrupt) covering current use cases.
> >
> > Signed-off-by: Kyle Hsieh <kylehsieh1995@gmail.com>
>
> Sashiko had some feedback on the interrupt - if you are respinning for
> other reasons it might be good to add a comment in the dt-binding about
> it being an edge interrupt. From a quick look at the datasheet a level
> interrupt would not make much sense.
>
Makes sense. Since DRDY is a pulse, an edge trigger is indeed the right
choice. I'll add the note to the binding if I respin, or send it as a
follow-up patch.

Thanks for the review.

Kyle Hsieh
