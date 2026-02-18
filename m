Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC41341060
	for <linux-iio@vger.kernel.org>; Wed, 18 Feb 2026 18:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771439808; cv=pass; b=Z3GpbBWSNJSeHYrCvF4PnDaH/pEL7ASH3oEoTGY4YSRGj+9mKoBvg21uvtkovk5Az4B5qNbl3thdvb/1uZQBgPdGnBHci3MQaejLG/VKsvR7QFugpQX/1sDdHm1ofZfmWdFtR0lko7IJWnJa9rwc1eBuo3l7InPne4eLI5QSfTw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771439808; c=relaxed/simple;
	bh=qJRMUf86+NOgYgCCQFrRHcXWIEKIxMuDM8i/3pCwCL0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eC87Gr6T6Llwoz847jP3pjKeVtoQrWaN7z05ylJuBe8zzzm3y3mnKMm1jy09j78UQGnRmU2krgTTMCp46xiXVQC54ZfZv/gmXa3RgFeREV2rHqzHc8suhq1sBK/6xLO8tAC+8PrIlvXAi+DZv1KNv1PS9tHIdZoWyNGrwjxXtLs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SRUl5KiF; arc=pass smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SRUl5KiF"
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-64ae222d978so64945d50.1
        for <linux-iio@vger.kernel.org>; Wed, 18 Feb 2026 10:36:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771439807; cv=none;
        d=google.com; s=arc-20240605;
        b=dkALqdD2WQzkYICHZ5W9r57zkjNCWT72LjEo8ykSmi+eeWHhtp7EKLN96panoba/vG
         Tzm6s5SIF+NiUT/1Hi44lP2rppS8wbk9C3KG+XSFXhVNN/wQp5CdoWHTS7yILdOiOJ8J
         16ItBWziBiteSHCqMBUEhQvqOjpcwj8r6ZHA2JIJ811PGXw89MXFDq1e17Rjq1zjI14P
         aiy689sdBhBANTIwL3/ZymXRrKn/8YpT+JH8Tu960SjttKxCJwQ43wCLE/iU53Re3sad
         N5RNLEYqXlLskmwQzGAODUCoWrzDMDlKAWutVU/EZtftf40P0gjlvm2/jyPzcPhY0lXW
         KyaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=T14iRY2Y74KYwPv5eSSsu4CRHshEldQbD4XUo8Y2gto=;
        fh=QkCOa9qpJzDQ8jnZo4L2BNa+MMGIabJuhZu1+Cteb6k=;
        b=S/Xgj2NUsvGd9QfshK6btG8+CEFwLIwt8KDXdO9JYl9+cQeQpOUDI+6nPLvOIFhx0y
         +xR9vKWop9B4gk0cs0AKfc0LDQY/F85KnrfLzOBwKW15Ev6RmgJlW2ptap/jD+HN7D6V
         hEhyyI2UpHjGloRPKklhiP6zIkeXvH0Gcp9t3VYs5w59OoZ8wN298DRz+iE6QtDYgtZq
         h1RCHCj2qNJs8piucLpcmIZoDxsw53vdW1a7RLawd1xlPkWKgrhl2ez+IRxq1A7Hsym+
         HfDY4zbAbebnuyM5rVL/SaaZnq8HcQ/3fPeppThajJaPRda5HICXGOh5Z4qhJ5AmZLHU
         +maA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771439807; x=1772044607; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T14iRY2Y74KYwPv5eSSsu4CRHshEldQbD4XUo8Y2gto=;
        b=SRUl5KiFOjS+vOJ4fNT8rE0aT5JFnY7xLpPHS4my68ClSVqJ2nOyCeFM4VIFiPt86k
         3za42ls+hJu3oMm+twfmIVjRMH73DcQaRUtfwifwg3dFpvmzdvwA5EOrprCz2XjxHq4t
         GrWOmY8AzXKK6Yb7UD4QeBU5/CZ6lR/IE3EFH4k99zuutO4F/8HcS/MgvjInYdewowon
         xx3tM/QBRF0He4hBl3wPlYgIGpEqS1vv68uJ+mi7MnuciVkr2nzhgnqMER6y+5D9yfaM
         NKO2LhiPr5p5ZXHA+7zsuCA+xFWyb9honSBqsjt+Pc3Q1jR87C0NQiakeAFxFWUsCKKL
         /eCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771439807; x=1772044607;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=T14iRY2Y74KYwPv5eSSsu4CRHshEldQbD4XUo8Y2gto=;
        b=nTJYcWeZyhyPlmLbhy/FaIgOD6guK7fWndzLa66qC6mAWJDfR9pCTuVnk9nBZ4/gkC
         U7X4gas3VVgzJuzNa/tuyAnSVXUIEyAcjMkvcBB9eRLcgvL5U8XZHAkO8YATi6eAezaU
         mskAva77d4PFKIbKMF1fWtMtxwnOM8XCrZcNKuPsHHrGs3OC9/yGo84t/+WwlRkAAINC
         bbIKL2r4s4sVI5GO7s64v22raFv/9Mc9hhlfSwUD5GRLf0REJ2lDBibRLMyQIOUjurpO
         DVgb8OpZMuQQLNO95YHTelTlUM11mDKUy0itEpqV9Ln9ID4K8zumcGPvy4iQYg/6rCzu
         YOaQ==
X-Forwarded-Encrypted: i=1; AJvYcCWbNgW4b4enfXnJFVZAI5mp+Z3prmPKyITfJnLnaqg5IagyQhl9ZzPZn5AzbMlT86kWXC2ReYLh0Nc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRe9ZCwj0XKDYDoquwZWGWP8JTZ035HN5oYmmq3bGOu1sipGeG
	vvWJSvLDJkFZzuxBo9tGW/wjvJz7Oqr/xOHleTfuD5dZ2T10cWE+GhTCI1PaUVKdQpwH01FUFiU
	92xMFBbLRIBnO99LkNYyRKrOqr77op2I=
X-Gm-Gg: AZuq6aKiLTNR8YaeRLFsh9//EnDnznfXmIyIhcM2rFp24IxKmX5JiBhC84HS1sP7ch4
	P6dSN49yevvd2bjKnNGTy9i2JP8BZRnBYaP/sW0KXM5C8d/Ns8D6J8nhtlWffjqiMlu8azYaVxI
	5fPTXRyUiI7GVvsAHdzb4zJYosnJRwYRQ/syqb7pL79wFUojIqyfvPW1DCDRdJr3VL31XVdMJ49
	BI+Hl68/YqEQedIxZt6kWtd4/PL+2uh6KYpYxQ/N/65W9JN5PEZtZI3N2YfzVHYjVxPh7yHKmDX
	o4cTsqJtMTEK3AiPt/NHfPsB/fksL+/aTPvtLjv45U8GoRf/+g==
X-Received: by 2002:a05:690e:d51:b0:649:e501:21b2 with SMTP id
 956f58d0204a3-64c6136c98cmr122071d50.12.1771439806745; Wed, 18 Feb 2026
 10:36:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260122145633.14938-1-architanant5@gmail.com>
 <aXI-ZV4uAd5GyFLz@smile.fi.intel.com> <aXI_HnvDNbX68-lq@smile.fi.intel.com>
 <CADJHxWB3b+bH2+HBP+SG0jxhGNcozstBeWeDH_3dgS-4c2G-6g@mail.gmail.com>
 <aXJmYAZ-8KkXCFI9@smile.fi.intel.com> <CADJHxWDCer97pMNHV-69B9AEVY0NfimTcxo8k8yFBbstg0wMQw@mail.gmail.com>
 <b27c638e-f0fb-42af-978f-89e38dea2b23@baylibre.com> <ca488ef9-f4f1-4f7e-9656-8c5d132d0d1c@baylibre.com>
 <CADJHxWDXqgpbK1+cffhPeTEz95L0zeCGGWb96_QwuxjEofBNKg@mail.gmail.com> <20260218181851.46b339a7@jic23-huawei>
In-Reply-To: <20260218181851.46b339a7@jic23-huawei>
From: Archit Anant <architanant5@gmail.com>
Date: Thu, 19 Feb 2026 00:06:34 +0530
X-Gm-Features: AZwV_QjQfcP7XaukHvAMxMCU8-hwa45RdEVjgcEe3tgBYP7REDOOEU7aNAJJ5tI
Message-ID: <CADJHxWARFsyFR3jHXzFjcOsTYN1HwSDzWwXGRNO2yg1z0i77nQ@mail.gmail.com>
Subject: Re: [PATCH] staging: iio: impedance-analyzer: ad5933: use div64_ul()
 instead of do_div()
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andriy.shevchenko@intel.com>, lars@metafoo.de, 
	Michael.Hennerich@analog.com, gregkh@linuxfoundation.org, nuno.sa@analog.com, 
	andy@kernel.org, linux-iio@vger.kernel.org, linux-staging@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Gabriel Shahrouzi <gshahrouzi@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 18, 2026 at 11:49=E2=80=AFPM Jonathan Cameron <jic23@kernel.org=
> wrote:
>
> On Tue, 17 Feb 2026 22:16:19 +0530
> Archit Anant <architanant5@gmail.com> wrote:
>
> > On Tue, Feb 17, 2026 at 12:34=E2=80=AFAM David Lechner <dlechner@baylib=
re.com> wrote:
> > > Actually, I just saw this was in staging, so I guess not breaking use=
rspace
> > > isn't the top priority if there the other way is objectively better. =
I would
> > > assume that testing/measurement could show which is actually correct.
> >
> > Since I don't have the hardware to perform those measurements and confi=
rm
> > if the precision improvement is valid or a regression, I will take the
> > conservative
> > approach for v2.
> >
> > I will send a v2 that only replaces do_div() with div64_ul() and uses
> > BIT_ULL(27), preserving the original (mclk / 4) logic to guarantee no
> > behavioral change.
> >
>
> I started writing that I didn't care either way and given the chances of
> not having to fix some ABI up on the way out of staging is near zero
> (which would break any userspace anyway) but then I took at look at the
> log.  We've had a fixes for this fairly recently!
>
> Might imply Gabriel has hardware? (or a 'healthy' interest in
> reading data sheets! :)
>
> So +CC Gabriel who might have some insight.
>
> Thanks,
>
> Jonathan

Hi Jonathan,

Thanks for the lead.

Hi Gabriel,

I sent out a v2 of this patch earlier today [1] using BIT_ULL(27)
while preserving the original (mclk / 4) logic for safety.

If you have access to the hardware or documentation, I would
appreciate any insight into whether Andy's suggested simplification
to (mclk) instead of (mclk / 4) would be a valid precision improvement
or if the original truncation was intentional.

[1] https://lore.kernel.org/all/20260218125327.21467-1-architanant5@gmail.c=
om/

--=20
Sincerely,
Archit Anant
