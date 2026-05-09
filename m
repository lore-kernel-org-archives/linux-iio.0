Received: from mail-lf1-f66.google.com (mail-lf1-f66.google.com [209.85.167.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 466A717A2FC
	for <linux-iio@vger.kernel.org>; Sat,  9 May 2026 07:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778311506; cv=pass; b=kIr0WPY/2I4zQxfEZjHXt+iNRD6GoqWPNezkjjTOoHdsjcAkFK198baLkDWWOvRKCA9dpOF75IbuPcf1OHAQ8Qqd6VI2PDFVGIuTKGBsLu+Qcd7G+H2u5bxJ7W4fe/G9aCPyTLr2gzK7hWxchRTtRKAktQJJi+C8116074SHz/Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778311506; c=relaxed/simple;
	bh=3IlHdIKrxoF2X0/gAC7sJMPSLQvrfJIIpzD5NQSukIY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ej8jtORj3qSpIrYlHkSxP47XGTXmzDXLfDhqWX/UYdeuS63P5SDIcC/BuxlRpsc60d7EXmjRoOIDcHb2xiAkmLZTsEitMzdoVxwq18SNEREyfQXp9CeESJNrYbEEX3QCOJrByFNqiQOnfVQ2RWYzRFzTX1cPxAW1mXRDt5t8fW8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LWv5BMyB; arc=pass smtp.client-ip=209.85.167.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LWv5BMyB"
Received: by mail-lf1-f66.google.com with SMTP id 2adb3069b0e04-5a10d130b37so2384078e87.0
        for <linux-iio@vger.kernel.org>; Sat, 09 May 2026 00:25:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778311503; cv=none;
        d=google.com; s=arc-20240605;
        b=LH8RGQNI9GGilAdPTBZbr/LuAiIhM6DPAAE5/PDjocRWN0x02zkzwmJiR9JCh/I0wo
         vx9+3uvmKGYYZasdLJ/ct1vY6224qufVS6DTZ8SE0qdE9dO/Q0L433njysHQtJP56nx4
         2cNkhzsWXZJqzWgXsrm6rIroi6PlLm2R08fpUJ/phmkFwuqMcda89UsDtq+eix36NlAm
         hrrrOk0MA0jnMxrYbOwu3/WagYkdKgmv2pu+DoklNyIo6J4DhElvZ3gHDqxmD4V/F8xH
         dhEEdoJV/N9iwKvoHK8Nz5Fup1QLP+UOBImr52eT7n6BKdb+6bXZLCraCV9nLzfzf60L
         zbHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uj5G1zpXz8URXkLKbWZSkB6rGldzCniXuy/i0RUhoEY=;
        fh=TEnkplUn2pqIxqUomF2HjmZdFVPAaA75f3NVaMfX7Z8=;
        b=ekR9NpYCKKZ3bBh7C0bOksffQ/vDAPhnHRihE/iymw/mnSL1AxBiGDsDa8hRdVyAoS
         R9ahVXFDB5RHy14BVpWY/3/J2dq/3/vKW93zIikUcLSSih+2E/SCnvhkKeuRIK33SdfJ
         c9Ip3VUM7N62CP4sJFvw+K5OVRhCbBNY6VpW7Tp32fLZHGVJPUDMpQA4g3PusOJrZ05o
         klys+tYe/6UBTZ7lHufY1NyiuowyYBCrbFwdIphobL0x8/pEBwFIu3y5lOoS9xO5kyM7
         8tlzY1oEq4O8PgKplOWuqZL97lmM9BTAlxyyNJqq6RnFQvEwRNOTxCDBfuL6/vA5paK3
         0EQA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778311503; x=1778916303; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uj5G1zpXz8URXkLKbWZSkB6rGldzCniXuy/i0RUhoEY=;
        b=LWv5BMyB8xnYCbo2Aa/XGgMZr/qihGdjtqvinLzbZMwe/C7VGViRn4Maj3bvnltgZW
         ir+aCWmJcYSc+gEhJNOtmebiM2i6fIK8nt9lLhjzz8GwBqcLINS4a2E4izuqLzbYtZQn
         xjbs9QuDdbteYrBGYCOgkMbY18unuaoS89BWXoWw1DykvxEyf5nJdi6m62AHJ3K1q68Y
         YDvF8xTv1iHcF+Idjrrk7wGklUIGbq1VyBOLUcem9PjnznvbC6CzRkdiwAqTlfk8F+Ow
         rjElXcsNI36Gte0wGnU0j9l8iJyX4BdNs5ASqLqsFl2TM2dOIEA3zbrx3Y+SNGvk8nOb
         oMxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778311503; x=1778916303;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uj5G1zpXz8URXkLKbWZSkB6rGldzCniXuy/i0RUhoEY=;
        b=nEqzqw4n50RIFtWfUZFrZuW6wJ0Bd/MMbpQ8VAfqXimLM0zse1/6BBRuBMa4kmblhm
         IBi3W9AqZKb1Jr1E/G7h6udFPPbgOINgndMcJpMPfRDkXAsuaZPT1iKTU8nGPA19k4nE
         A16S0Z7jq3jrw5D69hBT8fY4LgzceBQxZusZlVZVMOCQyZJYN9vKq5OVB+L1rBGYA9zd
         +C/wa4/EhcS742Uk6l287f5nrvo42KXMM5iaHcqabZy4vVeLZSfeOApnemlClN3uHFGV
         h7RxwBQDTqDwMZ7q6rr7b7CmEonx8WdLEICSkzNllS6IxTMhq+xf5bVIa9R/4jSVtido
         XN6g==
X-Forwarded-Encrypted: i=1; AFNElJ+CMNQBCeJySiuuG184vFB8o38HE9H6wLRQx6iMUrDX3nl7Y+/kNhxs7BKuqmfeMLyBBb6jtBdQimo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1Hi/F3D0U59OmNKsMpxMEEga78gzMUJBzC1IOPZkBxJMHXWQ5
	VaOfWRyQKYtfdIgN4/8eAH1+fBC0mntOtde1GJcyvGIKTo+/FHfMouZZ/j+qiPY6jkkGaqvWoGW
	606LGP53frJld5+vLhOO3L6rEHf8Z150=
X-Gm-Gg: Acq92OEZi/iyqP1dhiI4S1j6gSxHfm75WEPDRDCxepzbVt+yFW97sWm8LHCesKeKj+4
	vpVW8fL2oJyHrvMQ7hib8NzGQoTd60yz+Bj13jXNqw66zWvT8Exg3QYAmhI6AzAQAWHexMN5klf
	xkzQBjsO/IiFxbvsYfDNH488W+qlHCqNARkkahz3AOp+L8ecNgQlquj43FKSyqP0PQOR6B2Z6FA
	GtM6vPO3s/b9gjFMUY7A/VVS8bpdFaKbBCZYTYlEtC6oFPSsVSsRBgrx+AQhQG02mLlFu1WSAkP
	dKari+3cMHKHt22vjTTaGWdA+E3hngL8C4TxGFULRg==
X-Received: by 2002:a05:6512:3c97:b0:5a4:505:f63c with SMTP id
 2adb3069b0e04-5a899b9fa9bmr3363525e87.11.1778311502972; Sat, 09 May 2026
 00:25:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260509020646.82778-1-dennylin0707@gmail.com> <af7a0OV-3GLH490W@ashevche-desk.local>
In-Reply-To: <af7a0OV-3GLH490W@ashevche-desk.local>
From: Denny Lin <dennylin0707@gmail.com>
Date: Sat, 9 May 2026 00:24:51 -0700
X-Gm-Features: AVHnY4KdRrbbReAhl_lX5vMSOUZ9tiMyenRCgloh353F-edhYhGfKBnVv-HGyFI
Message-ID: <CAGEkeHeS1uYyC95yba2o9Ahs3GhPFubjC_i6gj9Kp6M8WG0F=A@mail.gmail.com>
Subject: Re: [PATCH] iio: adc: ad7816: propagate SPI error codes
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: jic23@kernel.org, lars@metafoo.de, Michael.Hennerich@analog.com, 
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, 
	gregkh@linuxfoundation.org, linux-iio@vger.kernel.org, 
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andy,

Thanks for pointing this out.

You're right that this changes the userspace-visible error codes and
can be considered an ABI change. I don't think this is worth the risk,
so I'll drop this change.

Thanks,
Hungyu

On Fri, May 8, 2026 at 11:57=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Sat, May 09, 2026 at 02:06:46AM +0000, Hungyu Lin wrote:
> > The driver currently returns -EIO for SPI read/write failures,
> > which hides the actual error code returned by the SPI subsystem.
> >
> > Return the original error code instead to allow better diagnostics
> > and error handling by callers.
>
> ...
>
> > static ssize_t ad7816_show_value(struct device *dev,
>
> >       ret =3D ad7816_spi_read(chip, &data);
> >       if (ret)
> > -             return -EIO;
> > +             return ret;
>
> At least this is an ABI change and should have been mentioned in the comm=
it
> message and justified.
>
> Yes, error code is an ABI and infamous case is already known when similar
> change badly broke user space.
>
> https://lkml.org/lkml/2012/12/23/75
>
> ...
>
> > static inline ssize_t ad7816_set_oti(struct device *dev,
>
> >       ret =3D ad7816_spi_write(chip, data);
> >       if (ret)
> > -             return -EIO;
> > +             return ret;
>
> Haven't checked this one, though.
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
