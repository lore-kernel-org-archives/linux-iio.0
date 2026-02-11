Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C260A325716
	for <linux-iio@vger.kernel.org>; Wed, 11 Feb 2026 06:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770792258; cv=pass; b=drV0WsjFRL77oTG4yqSSrL8y+VihKyrHOTFn0fIyh6HJd2JBZNm1qAmeDawqwZ+P6EYUSGJythLjyUkTeDUhjaVoHoUiuFSuWNm/r1VpjOVnEban06Kq8mzPFofg6zfr79Mxv4jZw4CbZSl1tNvsPXmGDGVhlFAR/pVcWbuJxGg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770792258; c=relaxed/simple;
	bh=VgJF+Kg3vwW+bEStkfTJ7tw8D3X5eP5It/SJf1PDS74=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gu+9M7BG9uPvBxtTCxkrMKZwg4R/eR11YOB6vKnI/ltiTF+nWDPzn54kEBUcDej7Khdbrts9eckEnDI/uwOhKPZAs47LrNbGhomrmTplTKPEznS8guPm0ra+SJvYILpUO0GpyKuB2RZlZ9PpoH2LOQF7fzCsD6FrtxoYZmsZH3Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aMQpEA1Y; arc=pass smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aMQpEA1Y"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-8946d9872ebso11563586d6.1
        for <linux-iio@vger.kernel.org>; Tue, 10 Feb 2026 22:44:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770792256; cv=none;
        d=google.com; s=arc-20240605;
        b=cB1wDzN9VXiDJdfJQc1ZgiTlmttFW2g/RP6DOXDVY8nttIHdH6xCVkeQDAD8dU+tTg
         jTHXX6Vz7O8CTo/wSYVBlfTGBW7Imy0PBZzD54f9AGdWQq3+gZPfsw2XaCZIRv7NYArW
         4qUV/9Bh6jB8pFO7K0Ur+ZuRPnVaJrMWm68K2rjseP8nhjrH/4DEOJOPtFKGQ3BqVK8e
         Nc4f8yi4DDLElNnR/7l8JOOHfDdIs5ulO0ipxiG8ra3q+cZFiAFvyoEHl36DzfvCO3F/
         iYt+bWM6Nz9N0OU0eE2bv9xN1TRuqBI2izlVUFn+mqpRREOQoBhQz8pgZPZcLHg/Nw6j
         L/gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eLreIYfnvJ87jvw+CSoCIEz9jlwWvkw50GfPsZngcE8=;
        fh=A+UIZkGg62LO+VKfc67XxLM8wt4o0bYuSsIx7ZwQq6k=;
        b=aQT8bCfn+V3nrdJ7hU5LTN1esNiza1THYlqSyEIq4VSBaE0vG9AF4RbPqFGUZ8ryNB
         qUs7S3uFwCVrOuxrQPvJ/faOkV56pmjXH4nJwMZeW78NVkjxJuuqYiL5+L/drtXW5EtS
         ScyoBpDEI5Ty74q/Tklf/0y/T1sJu7q2IGrha5EI/y31Fc56xY2HIQkbehirMXqqn5f4
         OIRHIso6hzYgX4jpHQ0UOpqEayTdIkbqThuq2/ySyWn7dHorIoXIYu44nzHn0uHGVGG9
         gvPEqojmWX2geqKNH8LP1qfbqTk1pZIKA6RupOBAdEprCWXsFeBYHJv0oTchSCepk3SH
         dkwQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770792256; x=1771397056; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eLreIYfnvJ87jvw+CSoCIEz9jlwWvkw50GfPsZngcE8=;
        b=aMQpEA1YFsjccnlRwXMz+wkJ1ATxYdgi502dnptWKIEhmtjxbN+N5+b6UqufOl0rhh
         yVVwflS/xV9NHcrjqg7nrnFF//YA37fVuTH9IQQyjG/6oSSkEcxPViNA3equEcDAo4K/
         0OfnQMwbk1cOo97iNqDc/KlD9e7WBWKXqC7ZSTEk0tWV1A+fQw+S68PzqpWI+pC/atrQ
         twZx6GTaf3E5mwHMjVpobsQcZOBHV90Skp17WNmhRwY53+MUoOT1PhhAIpyLzHmWPZmB
         kEwhwlZKiZbIW1uCp2QRHor/3cOOL4yKN2d2Ai9+3EEgQQjZ3M2n46RKO+cXEwY+d2em
         e6CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770792256; x=1771397056;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eLreIYfnvJ87jvw+CSoCIEz9jlwWvkw50GfPsZngcE8=;
        b=DGpSDYeXxAh7Rrizfvd8cP/Hve2RJV4GLBmXEaBsrJ2pQhrsHbjpMctUp2SJHQNWgR
         jB5GxZUg+UzwB2tmRrP3cbG0JrncdxyvtWI5Jb69+vTjDjJf7ib3ZonWjlx4xfbKv0Sx
         fEAlUUbQ7L4fiaU/NUz0Jtl4QmWykTUmjcpzC/Jeqn4SKFXvtO+wFYWs3PSeyJFMc87j
         XEBNg5J64aEpfxaZBdsM958JYAZcWsvYwW8W+LaLzJW44Yzmqke6pN6HdHPcfYY+c7vA
         aseybWqXGmQlCPgI+aF14GtPjtdqxoDGsymptMXlRnCha/R6klh9wj272/50vQONLwLq
         mP8Q==
X-Forwarded-Encrypted: i=1; AJvYcCWyCPwq2QB5kfWNp0gKXaqabzfkeiF4fkGLgpKFVy+dpgpa//PaeQ0TFIUWG1wzWt51t5W8iCMoISk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmZMBEvj6hLHB1fR5+kMvHe9lsSqEE6EEiV1uxrTbqV76mSkoY
	qLfRORnIZsm7spZ3vRVEbt4fgkT/l0dmED76T3eyXISG9YPM9PLLljcafVjQvaCAX7Qp7VamHxu
	NFKRXmZaOJv86uYW1cgjYrZBPrLeEY8b4T8UtGXt4hYfE
X-Gm-Gg: AZuq6aKFm30foNlMwaWdufvQfvgqKTfjEHw2OJqLeKDWa2mIK3feSNMo+/SnnrershD
	ZkwB1wQK/F1nKOIKxjg5xFmG9iqy3Y0pbhj+YjPv2oaJEk4DygYE0ykR6kPJT3tdY6J9u25mhPC
	lDSfMBHQjR+Q3cuKouRYrn+HggDz0ML+6dXBoGSkQ6uxk82IQjszueQBeItfXRjrmJs+zB24E0U
	3iLxFJzSNhiA7v2lZiXMY0SlLpoeBgF6QjN22o94DdaaZ/9ug50OVoytY/7Q5vVTTYgvwp9i/Os
	WXzEfkcvymLEzw57RO/G9mrEDVwUKD/o7zm+pSOGIdT2XW/TSfjWXlhuKJRat0mdoqlzwna4
X-Received: by 2002:a05:6214:4d08:b0:894:f706:a5f2 with SMTP id
 6a1803df08f44-8971dbab2cemr5997196d6.3.1770792255772; Tue, 10 Feb 2026
 22:44:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260209-upstream-20260219-v1-0-2b4d74e309d1@gmail.com>
 <20260209-upstream-20260219-v1-4-2b4d74e309d1@gmail.com> <20260209-active-quetzal-of-prowess-47a4ae@quoll>
In-Reply-To: <20260209-active-quetzal-of-prowess-47a4ae@quoll>
From: Yasin Lee <yasin.lee.x@gmail.com>
Date: Wed, 11 Feb 2026 14:44:03 +0800
X-Gm-Features: AZwV_QhlMxU8w85uidx-EcDi69OZd3J1_IrmSRDNDsR5ouwCrnGYIFmlGKaQ6JY
Message-ID: <CA+NOmzKaJPHpUZgUVWVKC72m=fCf5wBEsSErq+JmYNWHobax-g@mail.gmail.com>
Subject: Re: [PATCH 4/5] dt-bindings: iio: proximity: hx9023s: support
 firmware-name property
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, yasin.lee.x@outlook.com, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 9, 2026 at 4:01=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel.org=
> wrote:
>
> On Mon, Feb 09, 2026 at 11:37:05AM +0800, Yasin Lee wrote:
> > Allow specifying the firmware file name via device tree.
>
> For what purpose? What's in the firmware?
>

Hi Krzysztof,

Thanks for the review.

The firmware contains device-specific configuration data required to
properly initialize the internal sensing engine of the hx9023s.

Although the silicon is identical, different board designs use different
electrode layouts and mechanical structures, which require different
calibration and register configuration tables for correct operation.
Without the appropriate configuration data, the sensor does not function
as intended on a given hardware design.

The default firmware name remains unchanged for existing platforms.
The firmware-name property is intended only to allow selecting the
correct hardware-specific configuration when the physical design differs.

Best regards,
Yasin Lee

> >
> > Signed-off-by: Yasin Lee <yasin.lee.x@gmail.com>
> > ---
> >  Documentation/devicetree/bindings/iio/proximity/tyhx,hx9023s.yaml | 7 =
+++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/iio/proximity/tyhx,hx902=
3s.yaml b/Documentation/devicetree/bindings/iio/proximity/tyhx,hx9023s.yaml
> > index 64ce8bc8bd36..7e516fc011c6 100644
> > --- a/Documentation/devicetree/bindings/iio/proximity/tyhx,hx9023s.yaml
> > +++ b/Documentation/devicetree/bindings/iio/proximity/tyhx,hx9023s.yaml
> > @@ -28,6 +28,12 @@ properties:
> >
> >    vdd-supply: true
> >
> > +  firmware-name:
> > +    description:
> > +      Name of the firmware file to be requested by the driver using
> > +      the firmware loader interface.
>
> Drop description, obvious. It cannot be anything else.
>

Agreed. Thanks.

> Best regards,
> Krzysztof
>
