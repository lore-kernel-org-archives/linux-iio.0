Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B4063016FB
	for <linux-iio@vger.kernel.org>; Mon, 20 Apr 2026 12:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776689348; cv=pass; b=Yx7r8xMCB4MMA8Qctz0hFv/eTR7TFwofuD855RAH65vsQzk9oklPKrvqb5N5lN3/fNU1Miy5wRwe/Ea8QJzVg3g8kHVGWs1yDYW3L8oNtEMo/GqTGvukGaVN5T1B4PMvlVMIClk112sDjt0KriHSM2xh9swXKyfJOjaf5+RIlbs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776689348; c=relaxed/simple;
	bh=zTZlpVuIlwvGXH6j/Ky8Ry8XsadXepvkvwY8B/4P4GE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N9CpXV8xzwPguscq8y+Ytle//qTowAU6RxlrJQi85pduqisNEBd5NAX9R8tfnf9PcCHmnqYpFwfTVEjiKti/AddJvBzuvwNHtUfmRn9xxiC33YuBAjU49C/XN1qXwpwvLhRULQ8C+qtpjCPXbVywNJDGYtu/k/3ZvRnKp5+sK0o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bcSbrjZa; arc=pass smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bcSbrjZa"
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-651cfaa21e6so2748958d50.0
        for <linux-iio@vger.kernel.org>; Mon, 20 Apr 2026 05:49:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776689346; cv=none;
        d=google.com; s=arc-20240605;
        b=WwPgRzpz9YbrySnEydiARwl57WVrfbXFgEX9VQXFBUW2VholgIZ9P2scFQoNbnT0rc
         pL248KSU6u0+6OTnBftxDsXwk2/yKvR0TwW3/3mjTdxemlCbUrpJFLXftBqBFxEWRDjR
         +RScc9DxY1e94U1nrP6pP1RB/lUhPcVFASZTRFg4pke2Z4drfAwPSZSn4Q+nrKlaF1NE
         9PiZ47lZaocSH3fn/h6SALsqJuH6rQ/MBO39gj8vFKOMDvmrKWEcbl3RW/dnkpqFtm43
         S4hlw//GJqquydXT1Qnm3+KoA38YWYeB9x6IrauT0I6usISJufcv9PSC1sDiGvji/Pni
         77tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zTZlpVuIlwvGXH6j/Ky8Ry8XsadXepvkvwY8B/4P4GE=;
        fh=bjPqEVJktM4lt+ZkiYDyUGE8cQQpwuQTKOlOaqZ7/ZY=;
        b=Uwvpgt0O/Hr+N9pq16qnyX5nhcUhVuF+NHcuIVVdbehrpMk6226w2a+474/TtBha+z
         1T9/9tYe99PRq53E4m465B2au3stUhjtLvwgRAXwh0/F8tjiNnGa1zZrKZbLnkv567s8
         GsneoFvy8KNrW/M+G904FHkg/iX6lsAJdb3Rq10/t1EuL9ahC6H0oXbA2i4wZhTWMYIN
         WMpo3Ra2PN+d6a0fQpcc2gyCDV+7muH6qZNDjB7xDx/9ng1RV5irZ9PDq7r8RbjqhRWD
         w06H6kL1fMBJt5PHscUiR+c4omYvsMrtEtSCuEkaDpzirOLX8wGx4GDg5B5mTs6njtrI
         pulQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776689346; x=1777294146; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zTZlpVuIlwvGXH6j/Ky8Ry8XsadXepvkvwY8B/4P4GE=;
        b=bcSbrjZaNRaTRShKlCY7rpkOjHIdjc1Ef1dW0yg8CW65lcwbNYoTTKieY9nHbosy8D
         rC+PhzXUKJBAidtub+0R2t383k/g/xqw1pdWMlFpQp/lnyBSex5gufVNM9WcMq8/8Gai
         MUF+glZ3Wc7sflA1+uXMu5JBz2mC0ghCTdOucUxGB3BGl5V6dmb5RM9ZDBZJM1CApZ7F
         grf6pgkTWRaAur5OQc+9DUkwOlHkD1j7CIFmM3bxVMEbF2QPlexig6LrVtpm5R1VBH5w
         jRTW9cU0ZlAodY7FOEl0N+BWp2gyeuHSyc2Ng7mlB6ixDT0+JpWztk2+yXGEa3FJ3Vgx
         gxAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776689346; x=1777294146;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zTZlpVuIlwvGXH6j/Ky8Ry8XsadXepvkvwY8B/4P4GE=;
        b=dyp3dr9697r3782+8sLo2SfL3PKDNVyTrKhn3A/ILXstqLv8gNeHXCLQSzb6ZaFjRd
         dlaL940JT9gu7DMLbItBger4LD/EFht71flQcWGh/XKn+buKdW6lzPcqoJMTKXDk1+fU
         hbk9FGLaIBuFGRcsP/bjcxCbTeqDzkRF9O+E005yh6EbnISobm3Z9avDL2RNKFxUHrkE
         Q0dXiu3i1P2WOxhbfzwcfS6pfvDvTo9yFE2GhO0yeRs2b/pNS1rioOp8f/dc2uA8dhGu
         bHweL01WuOmjRc7fj/FsV4wBMbnT5puwCxOFIPAEbu4ur2nhaFzL/xPSaM/QIPr0R4pe
         HnMg==
X-Forwarded-Encrypted: i=1; AFNElJ9GkWfB9f29r0oSXvX3lcUKKdW4KuIwSYT/fsk7IaicZAfssyVoAf62lGCDIEd71Lk1ZSvlQBQhYIU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQ67BzHFHSne4fJYO4ZSBYPu+rDEqJfM0Mx1yJ4fNS8PpzkPAP
	YbzvWHZA45P05M89CYpzEz9rnCY1lH9Lkd0ZMWA7GohFqr3BF6kkHCKtmG/gKGhLuami8/gRMxL
	Ro/HM7Uxd5vpuVKSGu17d6NU38DA/ijs=
X-Gm-Gg: AeBDiev532mhWk1n5qhIzMsBF18jC9GWzHbdhQvTFYh0Psh0uMK38yZYxhWE3E+Y5Ew
	KBGX07z+p1jVWV+X71NuiIVUpt0vRE+Yu69buuLneY/REAh53ACOtRIj//7JoM2e3WWv3E/O+EA
	Dxn5VHgAhgHeLUqvbJLEuzjFQphRYIgmXpO9HT/ZrDrIzwH5VaeCh8FmtkWsYgquKIEAHoMY3yi
	IswnckyFxegcMu7FftHXMXA1Crm5ydDyflxurItTDr1Nje+k722UXlFdA6yfbGPE3N9Jqw+EpWH
	O19pkAlk83xNtYQ=
X-Received: by 2002:a05:690e:144c:b0:651:b73f:203f with SMTP id
 956f58d0204a3-65311bbf4ecmr9605644d50.32.1776689346162; Mon, 20 Apr 2026
 05:49:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260419155806.208741-1-m32285159@gmail.com> <aeXsOU8H_lSKHgB-@ashevche-desk.local>
In-Reply-To: <aeXsOU8H_lSKHgB-@ashevche-desk.local>
From: Maxwell Doose <m32285159@gmail.com>
Date: Mon, 20 Apr 2026 07:48:53 -0500
X-Gm-Features: AQROBzDNe45Tdx1ZWSlx67yO3WXHOgpQaiXYEIIu5FLOZe4I65gb4WNkps921_w
Message-ID: <CAKqfh0Fq+dvXomDaJOGQ9ZSaN-6Tr1mudwXEuDFOA9U0myp+7Q@mail.gmail.com>
Subject: Re: [PATCH v2] iio: proximity: srf08: replace sprintf with sysfs_emit
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: ak@it-klinger.de, jic23@kernel.org, dlechner@baylibre.com, 
	nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 20, 2026 at 4:05=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> Have you read my other reply?

Yes, but I sent this v2 before you replied with your comments on the origin=
al.

> Please, follow the comments I gave there and update the commit message,
> Subject, and the code accordingly.

I'll get straight to that once I have time.

best regards,
maxwell
