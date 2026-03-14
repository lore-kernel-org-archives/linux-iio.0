Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE4F81DED63
	for <linux-iio@vger.kernel.org>; Sat, 14 Mar 2026 15:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773501959; cv=none; b=P1BXE38FjxAejDQpfdaxEjJ6eqsEVPbA8jBp/KNv3AGFTtF8RRvK6oDkiBaC4/g9BUWOe+uuu6VV2HhFJOECyokKjJlQ0Wckm0ZdFFSE+SGnEAuHYZxnTdrPRXLSqLnQeIfHFZ/4Kkok/fs1Tvg40cNolEOLtiwrU5A3jlt44sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773501959; c=relaxed/simple;
	bh=MtmnzLG5Bo63WRQMbvVrVIj5k9GpRoRJaxMkFlxTeV0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FeFG6NmZX6mwi+bP4AVhk0h/UfDb62cFlZ+YZDOjK2EhKHWuGuRY6NWBKWAM+F80Grl4fF5FcJ0J+04smphUkVeSqQlBNJPCgQtrADmmXMoIlYS9spxwIyqxmnajEBan5Y5sFUOnleRne9Up5B9dRHbIOshyC15UlK5O7O4G+zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sirat.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sirat.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-7987531082aso33237927b3.3
        for <linux-iio@vger.kernel.org>; Sat, 14 Mar 2026 08:25:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773501958; x=1774106758;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uPLN6zlYiIXlkEI//PrNAmzZ4tY8iJf1tdCwKSeMOdg=;
        b=fh7LEcc3v0SKJlP2P4AZKGZPTHsRIeYi5bBuVqEf8jDpec8b95syFFZpCmM8LD038z
         vWe5f10CTyCrOLWesWWPq4gs47qw4/GHkt6NII3ANuwCYNI63LxVjapuip45qhFelIM9
         2VcFhGsLQEY7RyFFUE69DbSLvMJC1DJEXRQdgt5sE6QJuNkf6vS+n1s7t6tcBufxDqeO
         eWdWHXN/DPN/wACFQibNMXXmwgYkf4kpX9PT5Q22ufQn8aGntbijmxt3+sgZFyVb+1lO
         5RseKL4WsJ84n79EkdwIT4+KsB+cJotV8qYOJQotm2vLRkmWAy1fNHdmQNegb4Ejhzdq
         D4+Q==
X-Forwarded-Encrypted: i=1; AJvYcCV4GijRQQGJZYDLFViE6vo2g1lJ+eHvZKpF4o9Suy6ARlfx+51mBrAnF5T+v6CxpzkRQCf1hj4Iu0Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoB0qT+wWJfEAdao78hyjy/MV5cNwAIk4oqRl2mc6OiMs2ezn6
	hkpgC1zhOFZxoFXLOIYzn/bYskJYh9V6+hnsTZJg7OJAkpbuOd1qHZLl24fu3zWH
X-Gm-Gg: ATEYQzxxe8TeH3X1NfIKX6vzIdn+Sg99lEZm4SQ+AWcTmFcZKXh0EXgbZdkZYBAojQi
	mi9kUksYbQ/EYWm6LKIzxkBEnEOmvffmqlQUhJc6gHgnh8OKjm6Q+lWccV7Dk1+5eojTay4t3l3
	DQn7LYLZTtCqrDFcbMpFi4D6lbRppAlemrlHMPoR1sbRsA45zRaBlctNZT6VPzqmKoL74z1bN4K
	4FYDqYEdDZC6FMunaoczY5ZMaUCfrZjjw/c6W2cuTJ4FvorcKnNcw4UwVuFc6d2GrMcAwERN5T1
	EOaTY453N0vHkwmibC1LeYxSOV1Ivx79nt9fdTV5PDyKWAiTq0wjcgdxk1lE6Uc3LQXfrZPB/bl
	BpP73zngO5khDWUZGqihGQIrypRUyoBSvqIs+MoVywE0l1ysPqb96fmJSnVjbtviHqbSu3ualqf
	G+mZ73djYLwrfQAJICaqrtqhx9qlLdEvulv2EybFq1t++8a/TR0cnWaDx1XrWT3VuaykTfX6JV7
	FOWWESdJbrbfWIWNXm2jTuthiQx+1j9LN6pAdMusQ==
X-Received: by 2002:a05:690c:c510:b0:796:3dce:d095 with SMTP id 00721157ae682-79a1c085dd0mr71238397b3.7.1773501957559;
        Sat, 14 Mar 2026 08:25:57 -0700 (PDT)
Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com. [74.125.224.46])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79a37c4f793sm4987087b3.16.2026.03.14.08.25.56
        for <linux-iio@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Mar 2026 08:25:56 -0700 (PDT)
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-64d5a7926cfso3179199d50.2
        for <linux-iio@vger.kernel.org>; Sat, 14 Mar 2026 08:25:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUjUa06GRjnEkLgzK/ZxmAllM1kNMfANXmtahC7zDQD+2ECjyZpc+HGzQnGo1LQIrQFipiwInJy4Dg=@vger.kernel.org
X-Received: by 2002:a05:690c:c50e:b0:798:1f8:3152 with SMTP id
 00721157ae682-79a1c085de0mr77708347b3.13.1773501956280; Sat, 14 Mar 2026
 08:25:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260311224044.21480-1-email@sirat.me> <abLNbGUmaA7K0s68@ashevche-desk.local>
 <CANn+LW+F2bVMAGwoF8q9yBpF3x5r_hWDqvE3_JYjcLd16A_cEA@mail.gmail.com> <a2486bc7-13be-4567-a53c-b37921df7bcd@baylibre.com>
In-Reply-To: <a2486bc7-13be-4567-a53c-b37921df7bcd@baylibre.com>
From: Sirat <email@sirat.me>
Date: Sat, 14 Mar 2026 21:25:44 +0600
X-Gmail-Original-Message-ID: <CANn+LWK2OZ1dm0TAstM2hr6O6h2nEPRrNfje0mC3a2uc0HEwVQ@mail.gmail.com>
X-Gm-Features: AaiRm50a0WB7oPrNpIM1ZzaRDqKuyHnT9tTRHdmvsogCGE-cmB_9gK4JmsK425k
Message-ID: <CANn+LWK2OZ1dm0TAstM2hr6O6h2nEPRrNfje0mC3a2uc0HEwVQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] iio: proximity: add driver for ST VL53L1X ToF sensor
To: David Lechner <dlechner@baylibre.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, jic23@kernel.org, nuno.sa@analog.com, 
	andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 14, 2026 at 8:39=E2=80=AFPM David Lechner <dlechner@baylibre.co=
m> wrote:
>
> On 3/12/26 10:12 AM, Sirat wrote:
> > On Thu, Mar 12, 2026 at 8:28=E2=80=AFPM Andy Shevchenko
> > <andriy.shevchenko@intel.com> wrote:
> >>
> >> On Thu, Mar 12, 2026 at 04:40:35AM +0600, Siratul Islam wrote:
> > ...
> >>> ---
> >>> Changes in v3:
> >>> - Merge DT binding into existing st,vl53l0x.yaml (per Krzysztof).
> >>> - Use "reset-gpios" in the binding but xshut_gpio in the driver since=
 that's the actual pin name.
> >>
>
> We can modify the existing binding to make the supply required based
> on the compatible.
>
> allOf:
>   # Technically supply is required to power device, but we keep it
>   # optional for "st,vl53l0x" for backwards compatibility.
>   - if:
>       not:
>         properties:
>           compatible:
>             const: "st,vl53l0x"
>     then:
>       required:
>         vdd-supply
>
>
> And we can add a description to reset-gpios to explain that it is actuall=
y the
> XSHUT pin.
>
This will solve the problem, but I'm concerned about someone not
following the commit history looking at the code.
Logically, it doesn't make sense as both the devices require the
supply. In fact it may give the impression that
the vl53l0x explicitly doesn't need power. We are having to deal with
too much just to save us from writing a new file.

That said, I can still implement this if it's still the prefered way
to solve our problem. Or leave it optional as it is.
>
