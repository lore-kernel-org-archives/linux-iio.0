Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A489535AC3F
	for <linux-iio@vger.kernel.org>; Sun, 10 May 2026 07:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778399541; cv=pass; b=ueoRmoEntzv51tHcNEP54Osq/D2bkqAyrG2XnAC/4AIapO1TcJqOL21u3vX2jajDlpZjCGa3Y2z0MHD/vvxLe6R56lwLJLjbSeHkQxVB1Qd118PbOylSK+t4bqQkQZkb0BoaS2OF4DHI5UW0Iy3rBWu/i4cKUa/hNjgw+LCTJkA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778399541; c=relaxed/simple;
	bh=HDvqHyc0skVBxNmBYTld4Zvhk9DIp+L7vGke+f3ai24=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LF9TPw8Wmm6rrihZ8F8ZnE/vUAC+rxwqGFXGRgYPk2R+8k3Idp/c8tJJAUgJKK6fNOLrJ46fIl2otuZjDH04m3ATQDNyZzTqNE6SU7I2DccQ+u5Nd65LNp4E93ix/KrydelwYLzwjG9kJgSNuQ/4G8+9nkNW5k6PNWSPBklPCVk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s6CNl1fB; arc=pass smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s6CNl1fB"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-7bd87e5d8ffso47080267b3.1
        for <linux-iio@vger.kernel.org>; Sun, 10 May 2026 00:52:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778399540; cv=none;
        d=google.com; s=arc-20240605;
        b=Y+nm4xi2m308ENF3Re69gxhjjy6OXwRHKddh5oXu32E55sxRYdb3GVbSqdqMoB2Gf+
         z0BddRc6zDMKIsjli+Hp1ESxAb+w3WAeX5r8LQik5D4ePmWJZheaEFmNxSDrprDrF3Cx
         OaTnA8Lb5AhpzLt++/EuF0aFXXlZ0kbftn/b2FF4qX9YlfE0tnbPEn5CfvKAW4RP5B99
         nw7ZMAvHd03iH0K7yzKR3l9Z5QIFvAKAENUeHxafyQaZcsLiRhoannWJhNTpTkLhytPh
         8iLXHcCBXOkT4sT1CsRTSWSPi5x4dVm2hzAnR2J4oJ46jkRewxHPzcVQ3OjbncD5eXWC
         pZjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HDvqHyc0skVBxNmBYTld4Zvhk9DIp+L7vGke+f3ai24=;
        fh=faHedoAGy4t2uiGGbOBiatpCsls03P2NOX5SHI9cEGA=;
        b=X94OKxdLNJ0ujBYxc3CTzzH7pCl5ISUCHrF1WX6VgI2V1KYPdvCu46rTReA2B/XOlE
         ffCft3tqqgI3+nnM0OdeMMyrDenhm+9DLLjwqZKTNwVILXfhF9QdTmhC7LWgQFRXNz/h
         /lxdexd9yp9auPJBOfztqVFXXL0WrCCcfzrrlWGehmT5Np7z28LvL8eJuxz5xEocsLMw
         wFHk3lhWxCJVfr/54zSzvGO4N9sxeSr3/oKVmSDNuZ3nc090W4I7nDDs59MKpFlxiL2I
         ppNogtyqXRiAj7oV5/0k/o9ACpqEYYuEEkBUdyNow2QlMDhbGuF3VkUahKum4RtVXz9k
         qE3g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778399540; x=1779004340; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HDvqHyc0skVBxNmBYTld4Zvhk9DIp+L7vGke+f3ai24=;
        b=s6CNl1fBXrbfhJxQnsDqFbaJFVqBVA51ad2FMOc/f2mR900fNoRkOAzRXFAH9PYiFO
         SSq/ZbE51PNgROlCb9kAsYxd2tmCfAICzP9+8yODWvsYDB0gO1Vvda9pynr7a+wMTeEJ
         /JHZ3qq2HcNIUdL0RCmFnSu3UtnL3XADCMf40My8QVpYzmcodjcSznh1wFmMjaT9798C
         /vJ+g3UDVVAPr2TRWuKrr/ZkjzGS2qOxcbAV39MOzEg01osaAUaLTjmOVFUT484N440p
         JujvLriv+i9TJxIhgg/UAIlMPRNDuT+/7wrc1SdllXHmb+ZjviI9n6Fve4vO0AAynSCj
         tzgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778399540; x=1779004340;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HDvqHyc0skVBxNmBYTld4Zvhk9DIp+L7vGke+f3ai24=;
        b=kDy8H7IOSjm5Z+OFO1/dqBFpWca9zVbKCz0tOE67DD7hTzqOSJJ348uY8hUIQ7PdM3
         a7CJ6fDykel4ZjLeGk+Tq/2JAsattdh1C91QYvBZ0V5nyXY/g7NlnvAgl3GcZXB023fv
         wnqlYoFTbUmBAMNIW12svwq6mR+szeQPHw9K8+5uOgSq5mPHF+lMqEgUIZgbJLgUgfQW
         q4pPXDwXthJm2W3CpHcZwpBo7jggODn4ZVzNHnebcVgRJttREWedEXMLY0L1PjvuMk+d
         ruppS9Ul1hOnu7oYwjlEthEDfeg9RZHc5nxaKf1WmwYdcxDn3WR0YeXV7ltjQsTVOvbY
         vZSQ==
X-Forwarded-Encrypted: i=1; AFNElJ9IywTFP8iH1+ej3jC9AS06qfMUVLN28hdHX7Y0A2BBfbU5+5HxxwBkZ90QqGOt6oHLobgKXGrWnTg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5vcaQ7e9fd10etkcrFaBBSDNQfQelD7LJUBFZP+SgX9HE9SSE
	O/G3bBt4o8Hc1joUzPQpKbJNVKxZ3vUKbpH/1nJ9aSjMr1J5cX6gXT9Pbu4SHXStwiEIoA6NxJQ
	SjSbw1ib31jDIL0+Hh/ErG+KnY9ytuXY=
X-Gm-Gg: Acq92OHOlqexcO9QlXw3R2T/E3GLU7McPCqpQaLobuWx31sb/l897mR0P6arD/V/4O3
	D5slPezkY85+TOUrIEEDEys+4jodM99U1V5ENs12UyweNcuZQMa9whaWTQ9AkaT2FoxlmthdASE
	kT0OXk+LX3PR1s7oyOOV6q6Njeann+Ywoui63KJyn5PAsS4HD28o+Dvr+zLF4ZxbDzpPUafMEJk
	ZnUbDuTC81tU5PnjMm8tfcM3kxd4xopDdxJtpCj8cg7wYFxwbCzatlCjM0DJcy7w5uRTeMA7K+x
	Tibv
X-Received: by 2002:a05:690c:480b:b0:7bd:a94b:5df5 with SMTP id
 00721157ae682-7bf04b58626mr105620487b3.8.1778399539747; Sun, 10 May 2026
 00:52:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260509111634.21700-1-sozdayvek@gmail.com> <20260510003136.35026-1-sozdayvek@gmail.com>
In-Reply-To: <20260510003136.35026-1-sozdayvek@gmail.com>
From: Maxwell Doose <m32285159@gmail.com>
Date: Sun, 10 May 2026 02:52:09 -0500
X-Gm-Features: AVHnY4IoFqtGTM7LLHW3uTxmlChT01gTnZ56LhCET1JfITwyGVmyhUSitep-TbM
Message-ID: <CAKqfh0F66-Nh=YYmK6tgbu6F0TJ2O_jpub8j-rpnE-P-bA7EeQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] iio: chemical: scd30: make command lookup table const
To: Stepan Ionichev <sozdayvek@gmail.com>
Cc: andy@kernel.org, giorgitchankvetadze1997@gmail.com, jic23@kernel.org, 
	dlechner@baylibre.com, nuno.sa@analog.com, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 10, 2026 at 2:47=E2=80=AFAM Stepan Ionichev <sozdayvek@gmail.co=
m> wrote:
>
> On Sun, 10 May 2026, Andy Shevchenko wrote:
> > > scd30_i2c_cmd_lookup_tbl[] holds the fixed CMD_* opcodes and is only
> > > ever read in scd30_i2c_command() (via put_unaligned_be16 of the looke=
d
> > > up entry). Marking it const matches how it is used and lets the table
> > > land in .rodata.
> >
> > I believe the above is the suggestion on the correction of the commit m=
essage?
> > Please, make it clear!
>
> Sorry for the ambiguity -- that paragraph was just my own reasoning
> for the Reviewed-by tag (i.e. what I checked and why I think the
> change is correct), not a proposed rewording of the commit message.
> Giorgi's commit message already reads fine; no changes requested
> from me.
>

I'm curious, are you having AI do your reviews?

best regards,
max
