Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0317D36E46E
	for <linux-iio@vger.kernel.org>; Wed,  6 May 2026 07:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778051488; cv=pass; b=pwyjII1zmyv4VnixApdAYX/9oA1nlveE+ADtC4fU+kNu0NT1HcMOqvRc77nMvsug3m6EnsR8/RhTmJehRbek7HZUGWaOL01DL05yVyXsA0IRRueGyFh7+mTtUK4K6+Vo3tdS0UPuaXJFAj3Q/HicO4XDCZuXzLd7SVfkAAd2ng0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778051488; c=relaxed/simple;
	bh=oXjv6VCJWZ3+1gD5dq76TutYyKIvpi+kzRLBivG79zc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aCmz2hToxc5rHzBAllHtMptMF51kI4YiYrWiEM3KRhcyA2y8FtiScimtl8hzAJ/lmvV8lBF++ytyJWZ/dbaE+WxyXJuvFeAQxVfUtojpjaz9PETerZlGgi4rsfJ9pjYvL/txQSvaBeps7yNDX3I02nuUsSyl12yBKP7DKnidE1E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pyh/dRxL; arc=pass smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pyh/dRxL"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-79a2ee65171so63797877b3.2
        for <linux-iio@vger.kernel.org>; Wed, 06 May 2026 00:11:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778051486; cv=none;
        d=google.com; s=arc-20240605;
        b=OEMzjyZuaqBzQq+rWfmSHIKkbcKktJQrRHj52DNNVyOM1HqmfS5K139EHxUfg6ft5U
         AKHOMRFQ1EX3dcUzn4+RFqnUI7AMuyZ8+pcYaPSfuIu3HcZhJ/vBsdp1z/RhnLuZnoLy
         bdIZRXSdsv+i/GxvXoPGQqjNEed4XLPf+f6nUb/NE4eFIqB58MnvBc+N2KFJZonieokP
         4K2QpyhoRAnXfiLFEVeRsOjD04/GNoIUwMJtLDCCNtPIzsqZudkqMQ1iAZW4DGDyOVWV
         1bfHLcOeqr53dNvteeOg82sDHrfXF8iepAgkTT2Cll2aUE/SvW0OIb55EnPnDA10Enlw
         Gv/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IyCipUcU6UGlr4DuNakFRi4EFB/HQjysb539u/tQC3c=;
        fh=7etVWdn5k6Fc+nj8pHoM5u07qUAgpH3LabQ5V3fkU2g=;
        b=cEjHI+7j64orLHK/UswSPBRBW9LRvMqOhJBHAX/fU3Av3COoFqDeb2KQAdVkEWE553
         0r6Gs8pVtxxMWR75AWAiEMlUvXN4NfWdK5isu22BXJ2ffYP054mKqebv2qUSLxwnnxeW
         neUstkGUNxMyNH62rwchS/vCvjBANHK0YhuZnfUafsm0arxB4IcDpBz2N5h7C5lHT3io
         SMpyTO3ZnjDlmXyQzg5rCkhHiZrDSqr0911WQS7UWXhpRb3pVRuewHIv/XoRcZR5qpWZ
         /dQ9hOD3/fDG2znRAZmjPuDRWoUkf2+84nGX91DldG4xcx/Osfnqj972uFlVTMdFB7nF
         lr3w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778051486; x=1778656286; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IyCipUcU6UGlr4DuNakFRi4EFB/HQjysb539u/tQC3c=;
        b=pyh/dRxLm9IVmHD22NM8H3EdKbLllY6Cu4GbCn4fiNpyTZbzA1mkvcrzysrIjP5s8F
         AHa57n+AQfamlZmmpxzGIkkEQssSJx7KgNidUSGbg/Gwf26NWTaY8M9sf0ur8k+MNLBQ
         9sBqhQqAzrEaSbE8fEehOOM7xp29VJD3pbSonwLNXiRryam4iDbqUJWh9PkNuFxApRat
         BFpDrncshvWKvPWcesWUr1/TVAsjx1yb93qXqPgX0V0rha4uSiYKWjByKUPMtHhnQ/nB
         ZwRM8xMklv0TCbqFybrPcPZUBKt/tLGV4yoG9E2Z2F+h8Zm69dTxS7bfsp/2O5wUnbxh
         8xKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778051486; x=1778656286;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IyCipUcU6UGlr4DuNakFRi4EFB/HQjysb539u/tQC3c=;
        b=qENsUEKY+wmsSLM0Y6Yhee0kFes8hCe+du7KzuOxk4s0Q8HNNp7AwMpzszJiwscl6d
         L+6CFRkJJ6E+eTa8ypnFsKYfvkU7pHhqXM9v71wlz5IApAIANBLXKXeDOFzgHmKL1TPN
         zIf1Sns8bpHP7qfWP4mzUIQPpyyFXy+jJBlE67/dIfR/fhqmn2pgG/X7kE0Sum9tflll
         G4uSSCAnIlRXhmfdYwTh1AelQXeEMc2x7TnVwm/Xi24auuBb/OH6yCCEHwEvdwImeZC3
         es1trdWPwQZzs4o3t7XvJyZ3OK+M6mChEWH7fansuFBKLXgoVtAQZHKQqS5s0aJiAnp0
         t7dw==
X-Forwarded-Encrypted: i=1; AFNElJ95rizS42ANHtQHsIa2rA9u5fBDg+R/gNVLVhB+i35yOSErx/MgbZqmcpC5Pc7fk+ByKLLrkSW/JpA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFsnleq9mqrKSrNQlTZVQ5XoqXxtv06VHZyYGT6xYr6X6nnfMr
	wrk5Hmq17/5FUgyAPzj7sTxCUmxEFt4lBcsUi4dUJTt5JEk5s/FwjD0387hM4Dm3BJINE73SQtk
	A1W9ZtVP5jWP8CUU1buMJLF9l3+vyXaw=
X-Gm-Gg: AeBDieuDMaxayAG/eW9KEuxyNMTmXuDnRezA42OsTSkxtb+UuhkOhpb7ZiP8qHFpQpa
	3Y7skcwHmBfFHEL8Pj4EDtDT1YPMCaiyv7YcEvhu6B1iim3ah1n4TPtWVNfbBCJohU6Pj5bZwQ3
	KWFIcrA8UnNfCy2yHa9epgCnIWRkQofVKk/1c5qkg0NM8aUdGG4A8D20EN62wMQGmPEpxNHzrNW
	T04DNQ0niXuofuTZC1XvVIP0x+2p4q61mC9dtw5ecoGNY5dX5jwSgtTyIwaZY82w+c78mCbWcYx
	rWyUZ9GE+CcHbiI=
X-Received: by 2002:a05:690c:891:b0:7ba:fdc5:17e4 with SMTP id
 00721157ae682-7bdf5dfb114mr28351797b3.22.1778051486009; Wed, 06 May 2026
 00:11:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260505-magnetometer-fixes-v5-0-831b9b5550fc@gmail.com>
 <20260505-magnetometer-fixes-v5-8-831b9b5550fc@gmail.com> <DIB6Y4HLH5R6.XIP49B2XPVNC@gmail.com>
 <afroyRauK7IJrl8w@ashevche-desk.local>
In-Reply-To: <afroyRauK7IJrl8w@ashevche-desk.local>
From: Maxwell Doose <m32285159@gmail.com>
Date: Wed, 6 May 2026 02:11:15 -0500
X-Gm-Features: AVHnY4IraNFs9vpK2FZQE-7umr5fbWxgRuPR1XP2nim_q51tw7xjy4vQvinhhfg
Message-ID: <CAKqfh0Hy0y0yJOwz2EDR+b9wwuHpZdKfBsCCKZu6_nDNtL3=ww@mail.gmail.com>
Subject: Re: [PATCH v5 08/18] iio: magnetometer: ak8975: check if gpiod read
 was successful
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: joshua.crofts1@gmail.com, 
	Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 6, 2026 at 2:08=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Tue, May 05, 2026 at 08:09:22PM -0500, Maxwell Doose wrote:
> > On Tue May 5, 2026 at 6:46 AM CDT, Joshua Crofts via B4 Relay wrote:
>
> ...
>
> > Small nit but I wonder if we can change:
> >
> >       if (val < 0) {
> >               dev_err(&client->dev, "Error in reading GPIOD\n");
> >               return val;
> >       }
> >
> > to something like:
> >
> >       if (val < 0)
> >               return dev_err_probe(&client->dev, val, "Error in reading=
 GPIOD\n");
> >
> > Would be good for code density.
>
> Not in this patch. IIRC we have a dedicated change for dev_err_probe()
> conversion. Also note, dev_err_probe() is only applicable to the function=
s
> that are part of the probe stage and probe stage only. If the function sh=
ared
> between probe and run-time, the dev_err_probe() has not to be used.
>

Understood; I'll take that into account for the future, thanks for that tip=
.

best regards,
max



> --
> With Best Regards,
> Andy Shevchenko
>
>
