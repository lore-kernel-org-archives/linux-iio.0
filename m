Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A5226AE5
	for <linux-iio@vger.kernel.org>; Sun,  7 Jun 2026 22:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780872890; cv=none; b=Eki4wBZkgyeaYLeE5IkgDxhdcx41Bg7ATvyKrlFZXndXPMmUQTv3ZRNIfKp1fpzrtIfFZxtTULAkhtfL838DPiz5gC4xwwgK+ulRp1gyYmtOw3zPTSIosg7+O7fWXLy1NUPIBMAG+0H0A0xSvQBJuOymMbtD+LqaOupCHR0c6ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780872890; c=relaxed/simple;
	bh=Xb6YZr5P4SpdNG1BfAW9UCOTDTAg1bbB2MWp6fZ13tY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GTH/vIZDBLsobDylMUu8DenmpO7PVlPn47sJsF1tpXT8bvSGg4WY+cZA75kcD9oK/Iggo4hCIdHZcn4VGCZD4zrqWUuzaSkZbKt3ZHMGCHZiD61ynhKCEjdK7ASypbJUq7MidcouVLHB9FDtWQD5PBvSzpAUMVIDFxCfDyM4gzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B+Fr2a7B; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B+Fr2a7B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B81F1F0089D
	for <linux-iio@vger.kernel.org>; Sun,  7 Jun 2026 22:54:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780872889;
	bh=Xb6YZr5P4SpdNG1BfAW9UCOTDTAg1bbB2MWp6fZ13tY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=B+Fr2a7BnxVpZt7hKXSV7edObZO7V/fYEZV2Sa7J2mxv4R4CIyIBIYrDBJvNf6gwm
	 Vy5oXR1qSdjTQcRUzYCU0Z71c13g/b83ksUsSJw/F/7StU2wiRU6Hn1YCV+Hu3GngT
	 xQLgiG13ix+uI4DNPLbHuSxcTNQ8bADQaoCVMscJUz9Gw4jn3B1Q7uIJLgQPtAwWv5
	 KWIMZDa3Eovs5Mc103+lUNl5TayAxRTCETJgQ/ZXmch+ZKxKvaNrsi+otYfhFPmCpd
	 9oELmcumSp74R0t5YVxNJKfAinxtFjpPtof8PRbWFw3wG1vtm20cU5AfxLGY/0e88X
	 zFGx7hrWjA9tA==
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-396753f343aso36775771fa.2
        for <linux-iio@vger.kernel.org>; Sun, 07 Jun 2026 15:54:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+dZWRcqSGGnKmt3VYd+D+8KzDFOop1L2DMlaEE8f01e6IDNwQpC8hKdTXMz2E0QNK52bpeAjhg+Rw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5C3H2nZ691FMqCqD2KLnZChP8pN/uJFi1t3ttvZxl7EVzTt9k
	BHxEPOpumZrNOq236jpuzojHsZX1Azb37sBu6qwGEPhrtGVpkZaCa0kfICxUBm46Kjnh5wnzmdF
	C7MZapgsf0mylfOeBntAWXtMmg6tkDQU=
X-Received: by 2002:a2e:be12:0:b0:396:668f:b7f9 with SMTP id
 38308e7fff4ca-396d097b35cmr34288001fa.24.1780872888238; Sun, 07 Jun 2026
 15:54:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1780652883.git.github.com@herrie.org> <e49aba850b1f48ea00089e7142c00584541001eb.1780652883.git.github.com@herrie.org>
In-Reply-To: <e49aba850b1f48ea00089e7142c00584541001eb.1780652883.git.github.com@herrie.org>
From: Linus Walleij <linusw@kernel.org>
Date: Mon, 8 Jun 2026 00:54:36 +0200
X-Gmail-Original-Message-ID: <CAD++jLm-GGocy0oX=ZJUCTzUnyQFUL-kEf45UE6v0A7h+6b+vA@mail.gmail.com>
X-Gm-Features: AVVi8CfshfqyBj4K_uz2ane6IflcZIJ2ilG382ED3RLq3ijeVS3X5S2Bwjv2MfQ
Message-ID: <CAD++jLm-GGocy0oX=ZJUCTzUnyQFUL-kEf45UE6v0A7h+6b+vA@mail.gmail.com>
Subject: Re: [PATCH 2/3] dt-bindings: iio: st,st-sensors: add st,fullscale-mg
To: Herman van Hazendonk <github.com@herrie.org>
Cc: jic23@kernel.org, denis.ciocca@st.com, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, 
	andy@kernel.org, sanjayembeddedse@gmail.com, maudspierings@gocontroll.com, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 5, 2026 at 12:08=E2=80=AFPM Herman van Hazendonk
<github.com@herrie.org> wrote:

> Add an optional st,fullscale-mg property that selects the initial
> full-scale range of an ST MEMS sensor at probe time, expressed in
> milligauss for magnetometers (and analogous engineering units for
> other ST sensor families that may grow this property in the future).
>
> The property is purely additive: if absent, drivers fall back to
> their existing chip default, and if present but unsupported by the
> specific sensor the driver warns and falls back. No existing in-tree
> DTS is affected.
>
> The motivating case is the LSM303DLH magnetometer on the HP TouchPad
> (apq8060 / tenderloin) where the kernel's chip-default +/-1.3 G range
> saturates the X axis to the chip's 0xF000 overflow sentinel out of
> probe, because the chip is mounted close to surrounding power planes
> and picks up enough DC bias to exceed the smallest range. The driver
> core hardcodes fs_avl[0] as the starting range, so userspace cannot
> recover without racing the driver to write the in_magn_x_scale sysfs
> attribute after probe. st,fullscale-mg lets the device tree declare
> a wider initial range up-front and avoids the race entirely.
>
> Signed-off-by: Herman van Hazendonk <github.com@herrie.org>

Makes sense to me.
Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
