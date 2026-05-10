Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2972734EF0C
	for <linux-iio@vger.kernel.org>; Sun, 10 May 2026 06:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778396290; cv=pass; b=ppeHb9EDiCyZegBOHm0QXEhLczo4XdKpf3QZqtmWHS9It96PaAaar2WeHiU2prwJjInhX9zZvJGccYPli89zrNhc6C01TaSmxb87OtE8Wzn46UjYJZcFOgAICug7TCsrEyRznl5Liai9eNyY0RniH583IEaficXokVYDSCYOPBo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778396290; c=relaxed/simple;
	bh=piUilFf4VMYYYXBbid82t4Ma3FMwGs3rg5q+XAJ/S/g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TvP4GtsD7enGjk189QvKjIvNOqKP9A3plQ0pWSw8ml0XNHJ3Rkpl31MFSpnwUGUsMZHBtGvZh7pwWuCra8YYJVcfvOHTI4MyqH03+07uKIPuei/vNPjJ4eF4Rpf1GHuJ2S0omeubOntDBIy6VZc5bwfZ+IDXqhYFPgcazZbibnw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DeJ+W777; arc=pass smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DeJ+W777"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-7b37d84a6b3so31532467b3.2
        for <linux-iio@vger.kernel.org>; Sat, 09 May 2026 23:58:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778396288; cv=none;
        d=google.com; s=arc-20240605;
        b=LiLWLTNdSd3yT9BYegQY7YiBesTCAdulE58xgKYIFb/5JmNlBBv2LhCYZwc3FneCkE
         keejfBeqIaGx/plMZ43i8mdsLUlBGLZs1YZifiRVVTu6/I7ZGLWIVgyvTkCgwJligJdq
         m5AvWd5U+nKA/tnb0DB6tOFqU6/qtg9/BbmgKyzU8pic0CcYdtrBITTv1GlinJhXizrq
         b6DcKVkavqtm0ltfVY9GTH9xHxD5X9vUDXiEgKmWPvtfGNf12JRI0zaUM8/BoZ2FZ4fJ
         l5LQNZFkLW1qM4JYpaIDLF0xZSVnf6c+g0QWAcckGpvunP1gUPFRf56Jj20vypnDk0cd
         Z8HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RbaGmPkB/uVp5z0DPvQ1IUqc8iqVsuTXUP+9XXj3zeE=;
        fh=yY9+FL/XfcC1vH/mZZ98cnCNu2eYAMqXtd+u0eUvqiA=;
        b=SYqhD7mni6QvzfoGKmLflHhXU7mdJs6RidFd4RLo7oeKgPNOdAKTucY9udiFYF9WuD
         cGrb16fkbIowzGZ6DMfWvWAKZaQNz7vd4jFxSlM7ZjXCSEfwr0634ZrpuoqYcnoDf6b7
         uOWMec98aoFN7QTd1bXBZ07F7869UA+GdjdsFk+1kxnbRByPXoWnMw6PyxlSwtVE+e40
         iiy6HjD0A+KwKgsuKUXALEq6h3SULVn5auXGAcBm3gKXQBxatAO+oReTkHUYSUjAAIdQ
         vksRuzTrhZGkkdmlKqk7hjDv3m01anmY1MvH4Lsg/U3DjczUegRP1ejt81JOiHAR87Q9
         RGQQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778396288; x=1779001088; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RbaGmPkB/uVp5z0DPvQ1IUqc8iqVsuTXUP+9XXj3zeE=;
        b=DeJ+W777V7j5B8tx+8JZBVMSxpCRn/PYaOV41r+M7fhCL6lt1n6XOuvzMrzRiMJIm4
         hhFdJpgo6DFbiuCwnuJzZW2n3fhk4ZxMCdJFJoFB5IzGGkbmfyN8CUD9Q3Rnv/Cn4RGu
         kLRGvRRtaA7dVau+fcTBGK66ex4y14Am/2CdYhhU7nYe5lNvj8dQfuMoAJyKqlzUKBO4
         giprXnwNgkuJEqNtArvJYbBvwhKYJOJrAAJQTXT1it5zkk3elXso4YiHLc//HHkzlzip
         dJmLnQz75gqI4Yen8qr8zrLZK7WmClYRF21pUqWWP03xjaa4omX9cwWbyCyMXDIDF3fz
         ePuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778396288; x=1779001088;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RbaGmPkB/uVp5z0DPvQ1IUqc8iqVsuTXUP+9XXj3zeE=;
        b=r9w7U1BM/mZPAwi/BuJ0mEsnVtM4QPez1XVCFxqsxrB8Q8tC9nnuMB3exb9soMuufc
         VWmBrs/wf8WhtkygW+SPd7rZ2nlXrRz7iXOf+wpU8AYMRJsDA3W0urBpaMwqmESaeRYh
         gC5P3iDr4FFhwqvUzSnHw/ilVx/URAlxcO/nbLFjvNMSxH0hYq3TjRz1oWd7rdiaBkbJ
         AoX8LziAjphWCFnLqsnlTD+Rw3gXo17ICDkMeyVOk3IJWQ5mh21eGM6NHALoqKFqx7TQ
         DSsr3sUHsUdXuGqHjEoff0jQBFD3DBW7ryETnY9O6tNBC497Ufmqh+x850MYTEG2nZCA
         IwyA==
X-Forwarded-Encrypted: i=1; AFNElJ/KNuIjStSOnEE9J9JxRnyaYTK5Ib2gVOO4u3RedbO2rs5sAmTWDf7BcNSE+EuQKLaV0avMzYLPNas=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVWxteq+1G3BECk3u+egvNQktIvpM2Nmt06/CE4znayZjaAmGw
	7V3HIfG4hkDxMlXJ++nRI3X3byFyFgFojBPumRHCWhm3VYu8HEzOJ8c0exG/TY5P3cTkkN/iJ3E
	kx/TEzlMA1LHhtPc4cio2Vh1pQq206T0=
X-Gm-Gg: Acq92OF177A6AEggheu0i+vQX916FTb/KlhYxvCu3tCYI0b8d9MlDpB7abxt+EJ2AGn
	7dCu51Mc1Xq7KRa51jXcAvpciMkZsJ+U6y28IPkSQnfZCzTpW/ck1a1VYiP3ShRwsvPXQuCEpv8
	/cIU4tZ1rA5At4hEsTKhXz+mvxFQy2XpeLgXzsTO3PU9n7ty5OxYDCqz6gqU76uv3tAZ/MJ3MxK
	szNWuASu2tapkFPWQ78mO1jEOpnz6McyhkjfDq2FCV++swxBYGg6SQZ8a6RgKo5oKSa75gGmbz+
	e33u
X-Received: by 2002:a05:690c:f06:b0:7b2:dad2:5dee with SMTP id
 00721157ae682-7c10275fbe0mr47813597b3.2.1778396288198; Sat, 09 May 2026
 23:58:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260509125201.29872-1-m32285159@gmail.com> <agArgcwufi288K2l@ashevche-desk.local>
In-Reply-To: <agArgcwufi288K2l@ashevche-desk.local>
From: Maxwell Doose <m32285159@gmail.com>
Date: Sun, 10 May 2026 01:57:57 -0500
X-Gm-Features: AVHnY4Jq2gnf0cZ2rKTlXCKngeoBbtcXbVuY834KxhoeaP3QO5c7fJ1FIhSJhao
Message-ID: <CAKqfh0FWig8mRR-xhvnfcFeSinR6RySyPaf9Gbpb6WU+diiiUQ@mail.gmail.com>
Subject: Re: [PATCH] iio: chemical: sps30: Replace manual locking with RAII locking
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: tduszyns@gmail.com, jic23@kernel.org, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, 
	"open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 10, 2026 at 1:54=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Sat, May 09, 2026 at 07:52:00AM -0500, Maxwell Doose wrote:
> > Replace manual mutex_lock() and mutex_unlock() calls with the much newe=
r
> > guard(mutex)() and scoped_guard() macros to enable RAII patterns,
> > modernize the driver, and to increase readability.
>
> ...
>
> > -     mutex_lock(&state->lock);
> > -     ret =3D sps30_do_meas(state, scan.data, ARRAY_SIZE(scan.data));
> > -     mutex_unlock(&state->lock);
> > +     scoped_guard(mutex, &state->lock)
> > +             ret =3D sps30_do_meas(state, scan.data, ARRAY_SIZE(scan.d=
ata));
>
> > +
>
> It's the same mistake already had been told many times, do not add blank =
line
> to the coupled statements (usually assignment followed by a check).
>

Sorry! I tend to use that style for some of my other things. Will fix
for v2 (I have to send that anyways).

>
> >       if (ret)
> >               goto err;
>
> And looking at the code, it's rather better to have this lock inside
> sps30_do_meas() (it might require to create a locked wrapper as
> sps30_do_meas() while renaming the current one to __sps30_do_meas()
> to clarify locking rules).
>

Sounds good, can also add for v2.

best regards,
max



>
> --
> With Best Regards,
> Andy Shevchenko
>
>
