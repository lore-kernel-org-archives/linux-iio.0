Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF92381B07
	for <linux-iio@vger.kernel.org>; Tue, 14 Jul 2026 13:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784035723; cv=pass; b=Kg3cK7tPBTOB1bUR/nJbeF76gR7MbZnzAOsqWeNYcDyo9aCEduVsP1+688yp0ujQwVCNBv98dTN1MctWKTZo2AltyscKijHqzpQO1KJkQvHBuAqlKyYwdIfzUS8ULIsGPbxt4nqlXvP1i8+VKbpU3nVqrGsfTvhve7ZYLDAqWrA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784035723; c=relaxed/simple;
	bh=ue6jFvPPvjqPgIpHsXNu6T7RM+b3RNh8Y6zW7p+85hQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QJxGrYEeAhUhYLAZ5YTfvyWO+iyOttk/TWgpr56M54fMo5jTyKrwF7YGF5wdNxyyaQNSWwiuJZJh3CAapI6Z7Ej9xhM5aL+ZZKzAn9bdfPku25EvpIC4JnFIfgofwLeqkSTZ/D5B9qksJwn/6P+7htFhXSvKwa+6d/0/Kgc9Sy4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HAMoLggN; arc=pass smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HAMoLggN"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2cc73e322dbso50019805ad.1
        for <linux-iio@vger.kernel.org>; Tue, 14 Jul 2026 06:28:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784035717; cv=none;
        d=google.com; s=arc-20260327;
        b=IwoByb2CUYqznqaQYVPjyrBBZk2McCTHXV5YarTf90F6C2HqeXpprQbEGg+aw54qMq
         Vy6zMIjg+TOX/hUVrJa21fieVcIRNBnS6yjcXpW22udfX/IW4YMfcV6CUcgv89CE22CP
         WUCIIs8c33hzt/AN+HC+tF9akeMxRvfwTMhP7sV2ZamnWEe1bFK1QirAd+M6I3OYa1Qg
         9hFPNqKWNm4YEb6Q6/01bQijMdt2RLxBmdUx530uyMD/lkfarB7/GXjIWB6IHCyOW1De
         dzUcrGUs6migfNza3eYsqBACcgFoyZ4ChGpmuOcC9rmwZ3wE2NeLnPIuHefQ9W4ZWXOB
         JHLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ue6jFvPPvjqPgIpHsXNu6T7RM+b3RNh8Y6zW7p+85hQ=;
        fh=COtUybJ0bRpofvnpUPa1ohA3ldbf11/ldB74JMYPJPc=;
        b=iwfMJlv6Nm9IX9UcVs0TLwiGHx19QXFmQSd6fzplHRlIzRnWnHLakH/tqVuMxpTI7K
         6Mp/cR8wscG3cQF/7NE0ESQXVmMjH4yOWFl3ROuST+36rfdc/wJlGlpHl6xu9hMMgQ7P
         vftWy/IRvFCx7ByL35CjA0OunXkKwddj5OG/gYzpKdTekswVTSKyEJl+tySABoGJGM7J
         nk78zQs9nscD/jJqJtqeVG6hcgsrLy6DlM1gtCNYCWeeXIxnCi6zxpkf11E+rs99biYg
         R+6PT7XydZ6ykN4ByE7hBJ5VcDdMpCW7yn5T+OoPjfPdfhrR0fTgO+ic6bf118oD8I2x
         XatQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784035717; x=1784640517; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ue6jFvPPvjqPgIpHsXNu6T7RM+b3RNh8Y6zW7p+85hQ=;
        b=HAMoLggNikNfjMaUSjRVs0LKsdZLYv3PPjXr/y1n/bgfeuEWuMbtBEeSeu3Mo4dpnb
         xBWJuI9zz+8g/MpuGUW6WoFposV5HBQV4iEtgMSAkhvsuNGWlsSPZJ+Fq4weUHTdF1ht
         XldyK/rSwsiVV3E4u9TlNCjlt3Ou2fkoLA8RZMEXYqBzcpAXQghG1Qs88zaAroZ2yqX1
         KfYl0+I7ARIkLrHU0obMlW/vLijtNhknmn+ZjZif4tfwcvWHHaYWf5/HzYpfEvh+Ad63
         +uKJ5fbN33gdlEzUd3aolfkrLr4UALNV4xPZv1zsgyrd7pe6vjxEn/lPRxc7yPMrnTkh
         cEsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784035717; x=1784640517;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ue6jFvPPvjqPgIpHsXNu6T7RM+b3RNh8Y6zW7p+85hQ=;
        b=cvbNs+unhSWY1mZ8xTQEs2EVBz/CQ2tvkaPH7CwPeaa9+tafbD33Q51BcRFfw/tSsK
         FoRPwxAHUImKp27vQZrzOedL6IYI7UzbcSrxVrKR5c6yWi0SDRRLNQZ9Ibi/c6ohpU8F
         c5pRqp5GX+QvDNG3X8192YCuC9TpVtDPAzjORfFkpjHraIX6msca+YRKEK61t4uDdbJw
         bGC3EHo7x6NP/k7Rjk6IU3ZYjRl1QHOGDMPoe4QEm86MXyExBb2TjwVeyrnnPmi3wmNf
         pt95zxP3OXIbkU7VNSWjwnEv15xbRs8T4g9kPEssdbYMKPOAoypoRpGUIt1jXJTBxRR/
         4VDw==
X-Forwarded-Encrypted: i=1; AHgh+RrJ4wvsLqjkHnZjv8CdVof+uxDun9AtGVehP1j6hPe7IluDqFHpNIR+bIaog3tzWDHO1vRwiU7m+Ro=@vger.kernel.org
X-Gm-Message-State: AOJu0YzO3hYEbyryOLH28G3bjWxPXkBmcio6rdIIlV/ecNsfg1OSLGAF
	wFBbBJ2STjwoW4GaJ2iBjKKhLpeq7LSESYmCIDI6FF5kaAMDri57kfg0fYK+uJIdEGIaizWWPs1
	HOlH0Qlw+1Na7blgHkNgcqFcnvZMVv7c=
X-Gm-Gg: AfdE7cmB8PU/q27V/n9xahwNZf8i3BfoCjJ6wt6BSBzcgjZicaT9nrTjWL/yAOVo5yh
	GFjJwMk4qxv7TEp7cWNrr2Bawh5BQY+v3VfEkVR4HztIkl/bzS4P9U5R4xPR0gXc9ODP7xyjOHS
	nXFc+BvEzci8WlgVRv4w0ZQuwFVgTQ9dqIigmXsiCKg2AZEOXQJ+djlnej6GjDmtZGfDQeI6MHb
	pobkyo2bB1ywQL7hmuz/SmKeENPomveA6CNF6T7Ht6fZwPNjxaWmHwqMipjIC0RZeEiCFF2WwkH
	qGb8deoV5YHrivEZvCSc8kTtBZ29tg==
X-Received: by 2002:a05:6a21:7486:b0:3b4:b6d7:a992 with SMTP id
 adf61e73a8af0-3c11062f70cmr15032381637.8.1784035717203; Tue, 14 Jul 2026
 06:28:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260617080031.99156-1-clamor95@gmail.com> <20260617080031.99156-5-clamor95@gmail.com>
 <akeF_VrijPbebz3I@hovoldconsulting.com>
In-Reply-To: <akeF_VrijPbebz3I@hovoldconsulting.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Tue, 14 Jul 2026 16:28:24 +0300
X-Gm-Features: AUfX_mzREZozvqJIpCZw-bv1kiFlmVezGQdepbPdfuQMwUIt-LOogON_yq372Iw
Message-ID: <CAPVz0n1+wrq+g3p3UTc3hzHcsz8k02=QsvmseBD45d+SoSFsBw@mail.gmail.com>
Subject: Re: [PATCH v5 04/14] mfd: lm3533: Pass only regmap and light sensor
 presence to child devices
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

=D0=BF=D1=82, 3 =D0=BB=D0=B8=D0=BF. 2026=E2=80=AF=D1=80. =D0=BE 12:50 Johan=
 Hovold <johan@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Wed, Jun 17, 2026 at 11:00:21AM +0300, Svyatoslav Ryhel wrote:
> > Instead of passing the entire lm3533 core data structure, only pass the
> > regmap and the light sensor presence flag to child devices.
>
> Again, why?
>

Because none of the child cells needs entire parents private
structure, regmap is all that is used.

> Johan
