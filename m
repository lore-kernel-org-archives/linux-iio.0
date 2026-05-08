Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57BA332C923
	for <linux-iio@vger.kernel.org>; Fri,  8 May 2026 13:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778245438; cv=pass; b=Kaqkfw7Zot/ojILUxYD+0f706OI9aK9TXXRJUkpxgHQtBcV20kQgWQAK5zPAxL0cu+Qgu8/irmQLz9fylyjVvE+SgzxJJV/rJBaeoYsxtR/Ba5u4w/UzVlYZt5mQfOwVpQ7yHj1vVDtTvgj+6JhXGt8wg7zxF0lwvzm+aelbFE0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778245438; c=relaxed/simple;
	bh=DcziYu8sSHNVUrdT6VaAASn9AeNJDxXWdJ8eSpZxTyo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AruQcQroWYS6iPNDfq+DgEiaSrVhrNLVPqwCMnb+HQlynFV0osdlcpAHABcAHbfOP//4fj9/mHY3Pk/3YWrTCxcn8b+wZBs7AdvbFkiJCo0R5DjEYqicnY4HncTSNahC2N9GScAVpNXsK/cmI/n84qEyhhCilm0RIGTYv5kZ7wg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=knFx8rJV; arc=pass smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="knFx8rJV"
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-65c2cd216c9so1944910d50.3
        for <linux-iio@vger.kernel.org>; Fri, 08 May 2026 06:03:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778245436; cv=none;
        d=google.com; s=arc-20240605;
        b=j1yhG6uTL++0SQEWCtVlvsIrLcDav5IsiRQPWkUT36K5q19RZapD4Dq0OuhxsrKyxt
         T9Z1wbqBfpesmyHuFLcGM6e74iR+tr5esJmv4pBc8Tt8kWPiNl8THdwb231dLHyUfHRr
         E5d11H4lOk1jVRo6GUkAx6JAkxouTxt5GoSUNamu+wKI9fNWeJZ6hR4hCdY6oENBwuuc
         0Dx6PbCJrlNq4ceaGpy81AfZLTd4kr5Eok8oYp9SFMJ7xs5ymF9T03uNIAuiiKYkcgqI
         bTsAvKkPWaelMmqrNE4L7TFlSRycC2W+/2Ndw6RWKryusfaNt06rTWiNp20rRl2h+6Pp
         s0Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cLox9PCUrBH1Cc7Ey5UPJTwMhmLRQJXm/SnY+3HC/fc=;
        fh=kBKDxTT1hv/srHPd839M7UxQfSejUE8F3SzATuDvOe8=;
        b=ShhVxwnnYTlaczsKilUXskET1U7PaPl/G/K3G8Fshwo+EFYfjW/H8mFa9+Kr87ckgk
         /ZqjnRGdhdkXyOAIYX24ELY/wE4hVP4ShGeuocYKAgc6gT4pFaZCRiSc6wPQniEMp6o9
         imdVjeESEDShNSQd2VVibgWYETXmomkdV/UNhveJQECJoS/eZzZQaGw5prZNENaIzS7O
         aAa7iX8YREYtCi7Oi/tx9nShVC0axCI7RnqhAsoL/bNweIfn12kGFXUaF9wEmiICmGhU
         UesWefUQmlb5tPrrmUmIXdWQvTrALxbr/0StjNeuHnoM1D6w65KZa8ZTvYlUOnTuQlPU
         Er5w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778245436; x=1778850236; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cLox9PCUrBH1Cc7Ey5UPJTwMhmLRQJXm/SnY+3HC/fc=;
        b=knFx8rJVIbG7I+rsMI8qFUkgQsuzZ0X6U7GuuTubGFsGoCU4Lwpr3R2RHKE7Iz+zNR
         6QdROGT+WJpAG6ZGHOVUJeve+xggTNbWzi0yC1/j1oyr0tsx+14QsjMwDLpsSBlDy+RF
         vblcebonPiEbIk4U64gOpG+FxPl8T+f16ci7Mvjva9ZxS1WNHeUqPyLF3dZGjnSupwoU
         MuSniwMg5IZy4PvTJiG01l4vtNjAH7x7/MlspCJ+I5/ZnEf8Z5H9gnsrzT5+alGpZJr2
         fuRJXT4bvqJb6rpKDtYmM0zVOdL4zR246vZfO1QMTADhkOj4J8LtotecvZUY6FM2099P
         qH2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778245436; x=1778850236;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cLox9PCUrBH1Cc7Ey5UPJTwMhmLRQJXm/SnY+3HC/fc=;
        b=gLk2rDpHy/npjEGnqJVNaWlKYwKjv/HYuzXpm9xrtx3YW2gqaKtnjbiFc22aP1X4/L
         U9EE4poLSreWXHrmhLL5ZUTkpDFXIzaJ/M729bmdSBDU3kQnZDDwH7wDc29wCxmt9XOq
         1kW+BeIigt26Z0LaAgt6wX7ub7Yz5a0I0URmcbx8cxN9YyTk5vl4gGsSh86EOsAviLNt
         7gTQ/LFmExO7SboArUPRaGqPE8Fn/RDv5rAe21I3+LbPAYoA9VE5cpvNVrlNuYzt5tj/
         TyRJMEdGemY3EoEGc7lwteLgMwzhe0ubKxEilb9K+AOB60Dz0Y+eXLFf6qNhfz2IwVLf
         olYg==
X-Forwarded-Encrypted: i=1; AFNElJ8htT24jb3QmPcgmfVNAvnWvPmndRCxFZtrc28YWa4G6+sLMuOUhJ5VFzE55LuPljsqcIo+PrqR3uI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNzSiGYtc/MN+BuODDTBSUYjGKl6kDssDNWDmGbLCDko5zUj9H
	/Gjw86O5f+2HP2DKPPMnN+5J/+FkjrmxqiTV9UHc6ARfnggrEyXf1zfXmdwW5SDDHFLwYI/pSY9
	QtC8Ive+ESPAjqIjIT7bjLFm/8KYEcFQ=
X-Gm-Gg: Acq92OGA0ML6pWz9/4i/LumsICXpPh8A+wHwxYBm5Ud21auT0oqGgu1CuMj9qPTqmNI
	f1w3jA9CohUpOXETNUUPWTlAUzcUohTezavfFgaVNK3B4GsYnWEwInlLXuCCOe5shdWqkmbklVL
	wncYUkF3TZkTvptV3pywtAfOTSyk9+WE8tqjfgp0g6N6Fd/OlD2QgbQ52TIBdGk0RvBi2Aqouju
	PoCXQqpbKG7wl7eVSZqfA9IvEsNbJGUkoXibT4uGurFIKRFuZOuET5sTALtsW/KA5RKrBnn3Iq8
	W81H/ErOtMl02y/0e0eC1KssYGmUw+wyl+E2mBNCEg==
X-Received: by 2002:a05:690e:204b:b0:65c:25e7:bffa with SMTP id
 956f58d0204a3-65c7989b694mr9872520d50.7.1778245436174; Fri, 08 May 2026
 06:03:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260507223337.48437-1-m32285159@gmail.com>
In-Reply-To: <20260507223337.48437-1-m32285159@gmail.com>
From: Maxwell Doose <m32285159@gmail.com>
Date: Fri, 8 May 2026 08:03:45 -0500
X-Gm-Features: AVHnY4I35THMS-H5T08A7rB41xfKQUA7OnOgMvabAQcfCxRe_EOb2g4C2KnTdnk
Message-ID: <CAKqfh0ELaB7ifXNT3EkuC-K9s=V-mNgQ9WZt0ufVgmSD3xGQeQ@mail.gmail.com>
Subject: Re: [PATCH v5] iio: imu: kmx61: Use guard(mutex)() over manual locking
To: jic23@kernel.org
Cc: David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, 
	"open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jonathan,

On Thu, May 7, 2026 at 5:33=E2=80=AFPM Maxwell Doose <m32285159@gmail.com> =
wrote:
>
[snip]
> @@ -945,29 +942,26 @@ static int kmx61_write_event_config(struct iio_dev =
*indio_dev,
>         if (state && data->ev_enable_state)
>                 return 0;
>
> -       mutex_lock(&data->lock);
> +       guard(mutex)(&data->lock);
>

Correct me if I'm wrong but this looks like a TOCTOU race, was
reported by sashiko at
https://sashiko.dev/#/patchset/20260507223337.48437-1-m32285159%40gmail.com=
.
If this is a confirmed race I'll get a fix out this evening.

best regards,
max
