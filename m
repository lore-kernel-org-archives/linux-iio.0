Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D6CE316905
	for <linux-iio@vger.kernel.org>; Sun,  7 Jun 2026 22:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780873119; cv=none; b=hkcTD7Kn1vRNFAkMW8KeFL4MAt+17WGt4l55l55DuvQ38TwWuWRoSKS3XJIpN1fPhcAW4TY2kbtekrfVWcPEjKYLFm6sKqx89pcfjtI6osDWCg1hpWtQh1Uokek4nYEyvsHMXUc8iPG4MXhGAROrxkG6eCzFYzt5BcGz0arrybw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780873119; c=relaxed/simple;
	bh=o5SAsGCh9P++jQurkOAC7TsiZOpjVa2bBzeB5K6diW4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p+h6smwh6SY6W5YC8TvUvAXv2ONBzFeVOP20ilyowdbJb8yHd2FMtYZYS89/MHAix8F0wwvdcvdSq4hw5N1lAXySEN76iff+g62EFFBaqRJ2BXpV006gMm0VsVm56y2GHTUFnsZuawijnMoNHNGbgUxaFQYM/HRhzpShHnV7OSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YtjqTRl3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YtjqTRl3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC51C1F00898
	for <linux-iio@vger.kernel.org>; Sun,  7 Jun 2026 22:58:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780873117;
	bh=o5SAsGCh9P++jQurkOAC7TsiZOpjVa2bBzeB5K6diW4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=YtjqTRl3zOI9t3WS4oeg/3xmw07uOu2GQo24ktzNn6bDAAqtHyWnW9cOUCTeRVxBo
	 48/y7+6bR48OBnNqv2jthW1MqeAWYipZvQYGsGhSiHeKsekSq0sgrGbJ8jBLGLXM1y
	 wOAp7f+WKgBgIEQ3W1jf+xLD0pkmOTB4rF0/DxSJYXZPl9AltRfdv6OGd1r6fZgOnw
	 JeWElpXbuXRtZ82cU5eimvZbF7q5NNi488g2vnAlMid4RY3S3ApbeX6VPFPW2WXDYx
	 6+TorrBV0jQ0MtvsLytqWsVst4kw/9kMGLqf5RuKM/UWxDNmMhU3qU/Y1UF+9dto+9
	 CnFLTb7tysuCA==
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5aa7a7c9711so4141172e87.0
        for <linux-iio@vger.kernel.org>; Sun, 07 Jun 2026 15:58:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8TcYTT12irV6wSuq7vBe0v0HQ0nlqlmVeKkKJRvLTSrvx+iD1UUv+D8oAvJOSAEw/w6B6vMUuVNec=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNhSxjsvafcnsdr5bvYlzm6PZNZwgGKMdr+2SrA8pqvtmQ1niC
	YJOsvVoXgPyR5/6v+cKg4E1qIxS0rLW6HtHa6l2foeCMLEoweXKzXEGoV4+lr6w9RYbcJPF9x5r
	OsRrlHEpp19Q4DOm7RJRo6g0g1V5Un50=
X-Received: by 2002:a05:6512:6817:b0:5aa:75fa:95a7 with SMTP id
 2adb3069b0e04-5aa8866d344mr2510638e87.9.1780873116514; Sun, 07 Jun 2026
 15:58:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4622fa440f1686e06d0828a6abdbda3181fa385b.1780649212.git.github.com@herrie.org>
In-Reply-To: <4622fa440f1686e06d0828a6abdbda3181fa385b.1780649212.git.github.com@herrie.org>
From: Linus Walleij <linusw@kernel.org>
Date: Mon, 8 Jun 2026 00:58:22 +0200
X-Gmail-Original-Message-ID: <CAD++jL=NnqF3qTi=rQgf+e33VrjxnC39bMjWspj10V6JAri9mQ@mail.gmail.com>
X-Gm-Features: AVVi8Cd0PLvukpXzxeLyWCliJDQ8Iv2HBFTSWyqe6Gxgu0S1kVzXF1xH1nrNBLM
Message-ID: <CAD++jL=NnqF3qTi=rQgf+e33VrjxnC39bMjWspj10V6JAri9mQ@mail.gmail.com>
Subject: Re: [PATCH] iio: gyro: mpu3050: restore cached sample rate on runtime resume
To: Herman van Hazendonk <github.com@herrie.org>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, 
	andy@kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 5, 2026 at 10:47=E2=80=AFAM Herman van Hazendonk
<github.com@herrie.org> wrote:

> mpu3050_runtime_resume() only calls mpu3050_power_up(), which clears
> the SLEEP bit and waits 200 ms for the chip's register file to come
> back. It does not reprogram the full-scale, low-pass filter or sample
> rate divisor, all of which return to the chip's power-on defaults
> across a power cycle.
>
> The driver's cached state (mpu3050->fullscale, mpu3050->lpf,
> mpu3050->divisor) is the source of truth for what userspace observes
> through the IIO ABI: in_anglvel_sampling_frequency goes through
> mpu3050_get_freq() which reads the cached lpf and divisor, and
> in_anglvel_scale similarly reads cached fullscale. After the first
> autosuspend cycle the chip's actual sample rate diverges from what
> sysfs reports, until the next IIO_CHAN_INFO_RAW read incidentally
> reprograms the chip via mpu3050_set_8khz_samplerate() and the cached
> state restoration paths in mpu3050_fifo_read_one().
>
> That incidental restoration is only triggered by direct sysfs raw
> reads, not by buffered/triggered mode. A user who configures the
> sample rate, starts buffered capture and then leaves the device idle
> long enough to autosuspend will see chip-default-rate samples after
> resume rather than the configured rate.
>
> Reprogram the chip from the cached state in mpu3050_runtime_resume()
> by calling mpu3050_start_sampling() after mpu3050_power_up() succeeds.
> On failure power the chip back down to keep regulator and pm_runtime
> reference counts in sync with the error path.
>
> Fixes: 3904b28efb2c ("iio: gyro: Add driver for the MPU-3050 gyroscope")
> Signed-off-by: Herman van Hazendonk <github.com@herrie.org>

Overall looks good to me, consider Andy's suggestion.
Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
