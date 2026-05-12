Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D7B3ADB94
	for <linux-iio@vger.kernel.org>; Tue, 12 May 2026 15:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778598846; cv=pass; b=m0qyV92KT3ha73OShAmO6V7/4M2LK2UayqqNVfHvlvY9/pB7ppSQxOLDCiNma9Ts2o4NET5aFNbqGIrhWGlcQChdq5flErZtkMn5VNsgUprEVhtBLEMxXHAWqYgTwwRMn9jgvFj9V4z81DvLuFxg9bq/iE7TVE4wxPST4WlxOH0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778598846; c=relaxed/simple;
	bh=RlnD02Ckc5yXw9Yc0x4TvRkLD4aoHnYNmd4TPpOTJIc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DPmj80H/E6hxoyatzEmQ9jNNh9lbJNXhNXQu7ASfYvp63hxqrVkkazuPdM9OYtfR7sxqzohQ1PzOHBiMlxc1X0B9AUt/7yHfJCCfHSg5ngdXBddU1lVBTPtWjjFR29PeHaUC2Xp6l3/B6sVX2snGF/apY82oexOTr/epQw0QfG0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rRU+/8PW; arc=pass smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rRU+/8PW"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-44ccbd3290aso4512659f8f.2
        for <linux-iio@vger.kernel.org>; Tue, 12 May 2026 08:14:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778598844; cv=none;
        d=google.com; s=arc-20240605;
        b=Tw/xe/GjAmW0iDIKq0RdZdFnGaAj2O1dH8kTyjYShvOnX8vI89TqztyD8RSSU1RyNn
         XeCNhXpBMHjQmOajC+XkNoFDoPYYMatPTeW32xQFLDm2BQL4/AloNIvvXlIOj4bsYp8p
         e95adZfMxBNRmtm1qkRv1mM/ZHXbyOgPoRpl3lMkd5/DMOkh7q7fhOLa95a1XIYdJ/gP
         xwS4eIUA1EMEZ332ez7YCwXxYp7NmN/w4v4M4WNSzFdm5U+lisAB/jxOvOTo67hTqL/D
         hNhzBoyW9j81eyBzTUL39OPdFVBlBo4mqH5ahrUzt5NvNARKsjyoCgdzJDx0ewGk2ipl
         XbAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=02uzcGUDE7/45LZYMo1Mq9uyKmDbGuvM5rUwN6O92xc=;
        fh=U8VhFXPfKN3B6DH16txn4dzWfGMofUi23QcFYxl0PeI=;
        b=jfKr6P9PmtzNibMteP8ldl9z/5Ouk4GfDAaw/RcWN8tyji00hrPnyECFmvKp4rgUBW
         GhAzoe0cWIAex5K+Ey3UKDQPvyeaqK2gEZYnPtKEHHabGi6KPhNaVfowi2xE2EC9cAjF
         N98QxfDltQkrhguVBJD751uUuia2w9GFzA5lJLfckl50NNzVDRx/wFctuZL/6iCc4Ksy
         NtKwxNOrKP7dKy7YeOazxV8O4jmqYOqbz2ecB/gsngzL88BqMdyt7CVunBGinW30S9Cj
         r4MRVv+ERRs+aENpZHc0UfKIl45LuKnkb9uPF0FitwdeuljMqPHMJ4EfBBemV6alINXI
         SdUw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778598844; x=1779203644; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=02uzcGUDE7/45LZYMo1Mq9uyKmDbGuvM5rUwN6O92xc=;
        b=rRU+/8PWqA+x+2ZQuLyw2zTEYleseFyakYoaXxOnen8SRaxxdV7wgD4v4dDUWkyK2V
         KQdc5/xZBWDeNMgmwcELCEwwyFMaOGVOcVWv671UWk1S3aXyLf9T/T/XL1f1CmhpQfTb
         x4TKlLQAv9o003JZPvHhZJyZBRdLjFj5dThWqL/0Acc/Ru6folWk4IV7uxcKlEyWIcCP
         NFL/LPcGisagb3X2Sv23MFnRAO2w6cXk70RsMKYKW5AAkUH4qCBrWwg4LKtkorlEsB4o
         LRvhLG8Yt9/dzGXR8pNt11pB/5SgsTU+nh2YdVkh3j1Xgt4W05o6lOnRmOEA6+PzZ+ie
         ILTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778598844; x=1779203644;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=02uzcGUDE7/45LZYMo1Mq9uyKmDbGuvM5rUwN6O92xc=;
        b=EEhkghRoxTxMGCC5NIHhkDlurF0mq9Uqm8m5dJzTSicIat/gPIgRO2qvwm9ymDkk9q
         /s4KWDfFSAEkkXEhGw5PpBrXaZ/KIBaJvZx/PgTmz3Pm7TeuV2gvR4sh8kfG8apVFpu/
         o8Qf/hQByFpIIauTJ3peYYcRiRmysW8rbK58HqDNvdY1lLkmti2bBqMhQCbxhtQy+/f7
         xAwvXGI5ELn9NEcLbrrPfXC37E9x+aKzE/0P47/XDkD3LDD0dfcOvSeVjOs47A9REhTb
         DCYmgskueh/MJsPHp0rWyl+rF74XAGfleaUIyiUeaFHHCe/6PTjwrGoHt6Pw/Vn5Rb+/
         7ZOA==
X-Forwarded-Encrypted: i=1; AFNElJ+vK1TlcqF+CB2hqAYIu3EdN4Iew1g4kumta49EPCIhw3519K4LPdW5a+YxxTB8bB/K9CMYJUsASo0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiiWJqgiQC/SZMiIF0ofl/CmvruUmFDOD7eUdBCX2cYL8Fjtfg
	uQXp89WihmIueu/v1sLKpf77ndZdfLixGbwxcN8M1Rlud7wusB2io3IUvEapelfLIsivCiDFCcM
	ioA2shCco8Of5YsGzbX0gGiR49pKyDys=
X-Gm-Gg: Acq92OHqFCFvjVR3eDsoY5fgQsfexn99KYmlAXlFj6m/r6VkTier9ge/FdXZrbMAMNQ
	fB8P9HsPJBaANixC7qaeb6SSpHf7LsH23X37CPrkM0W/+iMS/pYi7tXFTXh8fIJGDcQSzh4LzZE
	HPwVT4D6GWYapQDGImkrfeYZANaMAtF+WxVmSyaSt/ZlUFXtDEE2lOg19wTfjQNJdGc46tGlUJj
	Ut1sqLpPqDrqOacGYelmGqz6+2xsS+P4elAh2bldsydvPKuSFqi7w/S8EweEY5OqyyjDC+vBWeg
	HCMONYlKtyPwpA2zfTXyOUkdtIH7MaJGq1GzUGIdyuLMEgvM4ceIbVicFYErjBIyH54g7UNusZk
	jHSHUviMCco7pBPkf3oqL223TxZp8uOW9Qu719YlAiYu+0QTNzlujNmUXnSGRN9eK+ivLjV9htd
	kQYhiRQTQxeApguvdP
X-Received: by 2002:a05:6000:144f:b0:43c:f1a5:56f6 with SMTP id
 ffacd0b85a97d-45b1547c783mr5193943f8f.43.1778598843671; Tue, 12 May 2026
 08:14:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260511-magnetometer-fixes-post-pickup-v7-0-9d910faa28b6@gmail.com>
 <20260511-magnetometer-fixes-post-pickup-v7-4-9d910faa28b6@gmail.com> <20260512160305.0be0be39@jic23-huawei>
In-Reply-To: <20260512160305.0be0be39@jic23-huawei>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Tue, 12 May 2026 17:13:53 +0200
X-Gm-Features: AVHnY4K_Wpb3S0Wsl1OrW6ag4ONfYJYQpyFz2Ffnmf3u7sa5lzgihiLJhGGYlPI
Message-ID: <CALoEA-zL76rvM7JFoGgGMk8CsFmDRcQ9SG4TKHhEUrxX9hk-dQ@mail.gmail.com>
Subject: Re: [PATCH v7 4/8] iio: magnetometer: ak8975: consistently use 'data' parameter
To: Jonathan Cameron <jic23@kernel.org>
Cc: Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 12 May 2026 at 17:03, Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Mon, 11 May 2026 13:26:13 +0200
> Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org> =
wrote:
>
> > From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> >
> > Some of the functions use 'client', some use 'data', and some use both.
> > Refactor the driver to consistently use 'data' in all cases.
> >
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> > Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
> Note that whilst I've applied this sashiko pointed out some more
> while I was here issues.
>
> The one about not ensuring the power is on for buffered captures
> is a pretty major bug :(
>
> https://sashiko.dev/#/patchset/20260511-magnetometer-fixes-post-pickup-v7=
-0-9d910faa28b6%40gmail.com
>
> Which is a pain because we have lots of cleanup on this driver already
> and I don't want to rip it out.  The fix is pretty simple though
> (add a preenable, postdissable pair of opts and pm_runtime_get_sync()
> / put_autosuspend() as appropriate.
>
> So if you don't mind please put together that patch and I'll apply it
> via the testing/togreg tree and we'll do a manual backport later.

Oh well, at least Sashiko caught it. Thanks for the heads up.

--
Kind regards

CJD
