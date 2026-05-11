Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E4AD3E95BD
	for <linux-iio@vger.kernel.org>; Mon, 11 May 2026 13:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778507148; cv=pass; b=SjLu6+MjgTl4AtiZhhy9FUUvpX4Rutqk/g+sBp28UtYxrIfKQIqmn7z+lQLLM5qrQE/8eWNwJ+7S40YuhZkBju9mHoHrZfoK4Zr9KmgjVGbf6k0cWxccIhBcY5LqDqtZFtK9FI9f80iZN+N/DD3/AbOFAKTc0euYkCnt5tvCcV4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778507148; c=relaxed/simple;
	bh=3KnvTe9/cN+WWCSEbW1BSjd4/x3h8ZRmgkqV9achZb4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tnnRQ08ClLbAE+3clohjmcz91FrtoHTaBB8UG4/pZV6Z1ckUPS5imeSaURy7zSj274xotMreTAv09YWJha4ALUTNbPAjHMVPfnYe8ekjuww8fKQ5PEyU0DWiLuz1pYRRUUVHObkQtnws7H/xFEmXj6jyzNPJqyjiu2cHunw8YJs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fFAWGcC5; arc=pass smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fFAWGcC5"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5a40502e63bso3868308e87.0
        for <linux-iio@vger.kernel.org>; Mon, 11 May 2026 06:45:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778507145; cv=none;
        d=google.com; s=arc-20240605;
        b=TldAW3hdKm0LIie2MF61KXzR0pBtD/2wMkpIoVM2yGjEU1/XORchlcuuIdQkpL8fSG
         0hUhSD6oou67v4PRYiF2QofUAk66BteKkA67FLdwt2yeEvzAwOlQDaN17nudpJ2JUSuS
         sfxhootPM9pcGqXGIhIHOVNl090L2uonw1ZoooG+eOFHNKpiwLR3mPYu/c/HEv5j/jT0
         3jgmzPshUkxrM1llElf/cmqYJ+u0kBUelcfHVGuWmZ/m0ta0TWJto/oKss2hhLKWC8tt
         Zzskr+b/KsSCLy67X0AEF4SJZVDuQTfdP73GPXQeTMdQbDvl60Gb15Zgk+ZV8fkbWy/B
         8xtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=h/8qSIlDWL3NvkqtCpX9JKQ0XkALQkfPhFL0geiOC4M=;
        fh=Cl4gjkDRFCtDf254jiYLGOXm1R3l1BADPHC3tsuNSd4=;
        b=KEg+lb2f+cJHcUbAhtEBj2lx6JKbM62dkg58RxMreyLuOVq68j8jokcbPG9PtVpTo4
         cO97c6czVJMml6Nk8+Vd4KoGzOx7z+oRe4gVpnjw/GoSlgYdsxMRUpxUKBm3YcEUPPW0
         CNvp4QV3o22UYoWgqaX8ztfD4ycv5qoOFAPZmUN3tR5ziaCtagyKdSH7NvuVL1ZWYDJH
         Tlr7oBtWfyxFkUbb5W1WtCnoLbgQ3F1iKYloEtBUzB7yhooWAlGxhqDalR57+GqawPL4
         ykSptKdSHC0N0nspmFe66o60QLXDz4PGj41N7HLqT/SsBpLtmCl7yPLbMW8/HTMbTORS
         be8A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778507145; x=1779111945; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h/8qSIlDWL3NvkqtCpX9JKQ0XkALQkfPhFL0geiOC4M=;
        b=fFAWGcC5IWiAJDEYO2VSVlTIbJZU2ZKTt5f5azxZriJO5a6y6k5Sjxpj8OEq5jCR6L
         UzbnyEsjY1hwZKpwgfdmfhC7MeIoZHWWC3U6NsQoqFhSa69azxgQo/U1D00w7yOvZ1mZ
         xK9utN0iTvOv6Kxo/hgocrj5SWsPK7hHmrXj7765E6IkcybrkS/caBIF4HLKx51j/4Z3
         gzM12B6n0vqJN8UlWUpzEAFxpu72tnift+MsHuSqk0ROxRGXcBEppVKpzWYgFSk/FjSl
         BmndeLW/nkBxZ/VXKwteH4buUUocpoV/Fd5x4ZDeeBaLls7cPJ+xWUCY4bWyqVQL583n
         rX6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778507145; x=1779111945;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=h/8qSIlDWL3NvkqtCpX9JKQ0XkALQkfPhFL0geiOC4M=;
        b=a0fWx0QLftZC8hPef4U+IxUw/Z/wGx7+rWvSjWnBa6ar3PdNPyb+ypThkPUfayY3Up
         OhxALv3KL6fmGWbj+NaniwzmAN6uJOKMPy/X+zgMC3Bk2/zjtZx+vQs6KPKdF8f8nYot
         rm9/TJh6NNKpgUiRtx4ovB8dDmT6akgpTm7Y5YcOyZvr158NzMThY8+4Hr6CX+6wQ0F7
         s44eciRPZV3+k4ULXwLlBcoX9dquyMNA+HcRCIGiSfxVFv5adwRDfeP7C2adsLXVsQB0
         RnJWU840LgxKIZ5rQaPVxY9v3q/4Cod0FoQ6ByVm9NdWTMfz1C0dMRYG8GNGrY/M6WOr
         /b0g==
X-Forwarded-Encrypted: i=1; AFNElJ8BK/YkqhxN/KElLfhXGVS38VJ747Lo3vzLtZr3Pp9UIK1fz9ill6RLAG1BMPe1PIfRHZbiVbrZbBk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw39FhKBfu81g5/8zGFJB6j2sE1DMtDpswrFcNBhiDa5x6l5ScL
	Otbcu+RvmAe7gUsUvR+yxjYARa3DTHCm+vYVBD/Lka30yKpCTpDb3SkL4RV4V6VZ5sDIBLmh1jp
	/JLLIWQKBw80gzv2IZmom/o6uLhISbrA=
X-Gm-Gg: Acq92OEokORhNwtkPFrWRl//Dxm798EpFaP0ta1XYvCDgxkDGkLj3aAbtOe3c9JlNaa
	vOOpoWyo290706wtTjozpnFGYDJXbLfy0c36soOEVaxw0fcfI4rKFfHfbFm7oXeL5pePntHkBbt
	lanSqmQqoVLg5WV/7jEd6e/vN4tZC5jMIvkf/H2ZbyyEbmZjvkIahs3GrMGLBjJwcuEu3/Z9Hwg
	NlJy5HTi9P4+xxQtlPmoLBDC0utEH0DWw6wgCfvLqShSoxlArXngPS+OzvXozCpmTFxEY/mnMCV
	UwgVN4Z3jeMkA7okMImh6N8J0PAdBJYlEWGKSdpq4cTbQNjt5Q==
X-Received: by 2002:a05:6512:3ca5:b0:5a3:fd0e:ce6f with SMTP id
 2adb3069b0e04-5a8bf22c902mr2267374e87.23.1778507144944; Mon, 11 May 2026
 06:45:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260510194947.31997-1-piyushpatle228@gmail.com>
 <20260510194947.31997-6-piyushpatle228@gmail.com> <agG7SvqOB8fRM0mA@ashevche-desk.local>
In-Reply-To: <agG7SvqOB8fRM0mA@ashevche-desk.local>
From: Piyush Patle <piyushpatle228@gmail.com>
Date: Mon, 11 May 2026 19:15:08 +0530
X-Gm-Features: AVHnY4JoGVbPKk9EZbOVpHOWfLQGYkmhL8suLnmfD3S81pXSQX8RZpXfSIDNsjw
Message-ID: <CAMB+xkZ65L=McOcwJ-WprTqpuBYnZRSZwO43ReVjbhKQ6TnjrA@mail.gmail.com>
Subject: Re: [PATCH v7 05/11] iio: adc: hx711: move scale computation to
 per-device storage
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: ak@it-klinger.de, jic23@kernel.org, dlechner@baylibre.com, 
	nuno.sa@analog.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 11, 2026 at 4:49=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Mon, May 11, 2026 at 01:19:27AM +0530, Piyush Patle wrote:
> > The gain-to-scale table is global today, so probe-time scale updates fo=
r
> > one device overwrite the values used by any earlier device instance.
> >
> > Fix this by making the gain table const and storing the computed scale
> > values per device in hx711_data.
> >
> > No functional change for single-sensor configurations.
>
> ...
>
> >       for (i =3D 0; i < HX711_GAIN_MAX; i++)
> >               if (hx711_gain_to_scale[i].channel =3D=3D channel)
> >                       len +=3D sprintf(buf + len, "0.%09d ",
> > -                                     hx711_gain_to_scale[i].scale);
> > +                                     hx711_data->gain_scale[i]);
>
> Since you touch the only line of continuation, fix indentation at the sam=
e
> time. No need to resend for this only, hopefully Jonathan tweaks this.

Ack, will fix it if a v8 is needed.
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
