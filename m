Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDFAD391E5F
	for <linux-iio@vger.kernel.org>; Wed, 17 Jun 2026 07:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781681573; cv=pass; b=TYCBx5584k+0WU5UDImx7jHrx1CIpjmrbT+bFnbkOMMBFmSZz7BgtyAicYfiBI3dfxp9N3N7mj42Cc3Chg1nSWIXIt3HhKPMXNo6vYzOL1GVWmXhdlLQ03HoGbrSMRalngt2ie3EIvTWsE/eskN5TSVp4hJWJjzQmdNQFq4Lc88=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781681573; c=relaxed/simple;
	bh=Byom1zGxQPYVVK73amaOs55VFHXFRc523eogxv8WVRc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fat6DTzeYzOTwU6RU8UTOugEJATlTuLxO4dtWSng1YG8MSKOGjEnrMATWgF5x/8UiXL/V/wkhUIGjPMMIg/IHuqCippF99omKJ9S05xnM3FBEZWQA4+rBPHhvRMZd9jlg0mqOy8wLrkKEavrXGBeUlhbUMQ8rdZ5KDdxiFWG4d8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O6bTfk16; arc=pass smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O6bTfk16"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-7fd5346b5e2so5989467b3.0
        for <linux-iio@vger.kernel.org>; Wed, 17 Jun 2026 00:32:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781681571; cv=none;
        d=google.com; s=arc-20240605;
        b=Li3sjTTscXQKLHXFez9QYA2Zj3YD5cezFVfG/IW3Cps/+GpZ8OuxfkRldZaD1b8iM5
         VX7GliGdsiKhVvipn//fTeFYzRcyrKY0GlgGydgWpFUt2L3enhLoa4okqM7z9xKKbDwV
         UwegZiklUghzGYhVporMJ8k00rSJfo776y37vQUcjMkg6gSspciFUynGhFP43pd3o2ha
         VWR0I/wE/dshkaVLDpPBkLYlhpmFmjjOZk9kBmFacZiwvRd2SSRYrrbOKFlw/bVu28nm
         PZ1ab3/he/BNl3FbzuVeWK0GHuOFI4aZaTFPwLJOp6kkHY5eY1AHqHMYYiGlUKyreRlD
         yUkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JEZj+zhbe17quYQMCn/S6B5vd3nTrZeVnYFHhTTunWA=;
        fh=yv8m+2H4Nj5U4t+HodGxsU5IoEBE7hT3GjichcP++mg=;
        b=gXzj4R2vzv+wn64GQMre6BalpzwMzOlS10jHIBLHPUswap8qTOMMYKZKLKmsw/BlNo
         5w7mLfUTBR/Yf9HvWYILt1Z611VPNB0ZMX0e5zX38t5V5cRQGdxtz7JA5u39DebhO8I1
         2zgtH5UJtIzRVbWVqKjeMFM8Nvnw9CDu96k70fQNhkVpAeG6slqGpDBHmr2dFUqrGe4E
         5LmLX5RjmaVQYfAixnfHIJLo+fl4sgF86oNzyIeHvLaFS7ERFFDvbUBGivzKc6UOIp0C
         puWc8cMijk85Hm3+PQZDXC6FmoHjGm3Nie+R62ya9aQy7dv1/j+jJt5Qhnbnj6RzWV7y
         XzLQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781681571; x=1782286371; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JEZj+zhbe17quYQMCn/S6B5vd3nTrZeVnYFHhTTunWA=;
        b=O6bTfk16TVPSV7WwLHDGhb+ahhf6AJKJ/3YMRYkh5e3x+zIRKEKb2jBcXCZwwXk1wP
         OUk8tHG0tGqfnt6GGyHqe5meadPeGxTPH2NP8EjBUdgLr16577e26VBr85/MEvtQ79tF
         ZADPFZ0ClOIExanl1wmcfdTVVZc+PXiwvwaCImhfc3oQgag9zJdMd+MYZRWCvfYYdOZV
         JuV1+VRbx7IbWDyqbUSICc0BbCfoM0YBv4XsaPzttm6NMTSl84IH6ItCJD+AS5b0eNN6
         feJl8Se8tDErEMF197/VgiEkv9hNVpbSVQq8+lkwH2Sl4LLTCfrx3dgKI1YeoZqHq22p
         DfvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781681571; x=1782286371;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JEZj+zhbe17quYQMCn/S6B5vd3nTrZeVnYFHhTTunWA=;
        b=Pl1iX1hUwtfpxDydUEbS5eCUWjBBc+4BGTWHZ+a+MhINHDaOd4aEB5cUWueUSrzsoc
         I1e8gIGl8/mJapJADYp76g7qpeAdYbyMsrzEqT6wvkvwd4682x27lvGdJKobpGcnZzSg
         GtiGubhdQT+zqLHbJ4o4hclBLEv8u5TV0fQSk2mWyux+fuLQ+iRqZSci6HofvOrSIyxh
         QZgZNKs60EcQBiFFfQJ8/Ei0cVKFeGbyT9OotNXn05SGLyTbb1nBBqI3EFNUaPqZBof3
         fmkpdS/HefQbfKh0W3RVjBmrFMK2irwQcwSE/29+uATzZ8t+tZLZUHpIP+Fv4T0z9nnO
         snKw==
X-Forwarded-Encrypted: i=1; AFNElJ92f0mVT1rdODpbHfgatLDt0v32BOxkSJtmlN/Puw9eWvLJdbX1sPlJLGxYBGBOcEhfzjsrGgmJHQg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNV8v75tBglm2fe2oeIJA1yEx9UTcli5+VJSep9e3hY8XD8wD4
	mewI+dPvG7BM1HeT3I6hoGr+gK4BGCPSVvNr+ii2ERFiWSy8e3HQ+uz7yhe5nQW/5o1syVPwFTs
	LjTEhmYcjbX1Tx5hkf8EvJbxbHxgKBng=
X-Gm-Gg: AfdE7ckodDTCCnbptKn9YDLFKl25aCWKqIyzgKjcgCS9MSqBCDJcCyzVx3B8RGJmwMt
	G0WhqHwby0gU0OKs6nBnmrc9C1EjDwbId6lmOBpKuyRxLw5IcUXDEFBBeaH5hP5NoCJ/fj8/Bju
	EBifkgKXUZjtpV2K7uJu24dDXXv5O/V5IKp3bPFE9xpkEMa2nNhURo2lXUXMqXjAnH5n58/ufSE
	p8EpyFf3Y8sU6nvZlwC9gqIruUC1X2B38DzPKiIsNc7akQ4p/oksSI0V2FMZT7IbRgMwg==
X-Received: by 2002:a05:690c:11:b0:7c6:e377:1dc6 with SMTP id
 00721157ae682-7fe7051621cmr15709297b3.0.1781681570744; Wed, 17 Jun 2026
 00:32:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260616-15-jun-hid-iio-alignment-v1-0-0cd544286575@gmail.com>
In-Reply-To: <20260616-15-jun-hid-iio-alignment-v1-0-0cd544286575@gmail.com>
From: Maxwell Doose <m32285159@gmail.com>
Date: Wed, 17 Jun 2026 02:30:37 -0500
X-Gm-Features: AVVi8Cd_HvLMTsqngLzpvQafjQsoXhetBUbHiz4Sgi5h0vcMxswj93lMAZqNo9A
Message-ID: <CAKqfh0GEeyQ3UMuMupevgPfCon+zccAv302sV5YKCETWMua-xA@mail.gmail.com>
Subject: Re: [PATCH 00/11] HID: iio: warning clean up and prefer kernel coding style
To: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Jiri Kosina <jikos@kernel.org>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 
	Zhang Lixu <lixu.zhang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 16, 2026 at 5:26=E2=80=AFAM Sanjay Chitroda
<sanjayembeddedse@gmail.com> wrote:
>
> Hi all,
>
> This series updates HID IIO drivers to resolve checkpatch and
> kernel coding style issue.
>
> This improves readability and follow standard kernel coding style
> No functional changes are introduced.
>
> Testing:
>   - Compiled with W=3D1 for each patch in the series
>
> ---
> Sanjay Chitroda (11):
>       iio: hid-sensors: add missing blank line after declarations
>       iio: humidity: hid-sensor-humidity: align parenthesis for readabili=
ty
>       iio: gyro: hid-sensor-gyro-3d: align parenthesis for readability
>       iio: magnetometer: hid-sensor-magn-3d: align parenthesis for readab=
ility
>       iio: humidity: hid-sensor-humidity: use common device for devres
>       iio: position: hid-sensor-custom-intel-hinge: use common device for=
 devres
>       iio: temperature: hid-sensor-temperature: use common device for dev=
res
>       iio: hid-sensor-magn-3d: use ! instead of explicit NULL check
>       iio: hid-sensor-rotation: use ! instead of explicit NULL check
>       iio: hid-sensor-incl-3d: use ! instead of explicit NULL check
>       iio: hid-sensor-accel-3d: use ! instead of explicit NULL check
>
>  drivers/iio/accel/hid-sensor-accel-3d.c            |  2 +-
>  .../iio/common/hid-sensors/hid-sensor-trigger.c    |  3 +
>  drivers/iio/gyro/hid-sensor-gyro-3d.c              | 58 ++++++++--------
>  drivers/iio/humidity/hid-sensor-humidity.c         | 48 ++++++-------
>  drivers/iio/magnetometer/hid-sensor-magn-3d.c      | 80 +++++++++++-----=
------
>  drivers/iio/orientation/hid-sensor-incl-3d.c       |  2 +-
>  drivers/iio/orientation/hid-sensor-rotation.c      |  2 +-
>  .../iio/position/hid-sensor-custom-intel-hinge.c   |  2 +-
>  drivers/iio/temperature/hid-sensor-temperature.c   |  4 +-
>  9 files changed, 102 insertions(+), 99 deletions(-)

Firstly, for all of the style patches  (1-4, 8-11):

Reviewed-by: Maxwell Doose <m32285159@gmail.com>

with Andy's comments.

Secondly, the style fixes are all churn. It would honestly be much
much better if you were to squash those (even despite the
one-logical-change-per-patch rule).

--=20
best regards,
max
