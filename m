Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96ABD33C526
	for <linux-iio@vger.kernel.org>; Sat,  7 Feb 2026 21:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770500487; cv=none; b=ivEMyVea5tjVQd1jsboBQ/YpmNKdD2wHQPgedD25NvNkUQ7maEfpm+qJ34R1joMwMEhH3hnc2E2BRxnK6r4uYLW6Mb2r7+KfaOBCkEnyN0STNa/57kGLxmMYjBjNZuR71+jsqzRtey+8R5HQJqFfTT7IRSAzsD4+R04+M8A1P0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770500487; c=relaxed/simple;
	bh=bu7sc6fm8R3ogR5RmPOZUc2BmaR7LgDj+vCm3snNvok=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ddRVVHfEnn8i2cDjlzcLcfBYLUZfynW5lbtTPEHgITwmE+/K9+QGssPcTZSB6U3CZEAvby0SkDAhGggVSNm9um1HWCGrh0D7HsaAXSPS1AvhupUPSvVpvDmRrSnHLB+jM10WdZ0DTHWPiSSD1IyPsaqH64n9YnCZXdFV0HEaTD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PADG2YQr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PADG2YQr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A8DAC2BC9E
	for <linux-iio@vger.kernel.org>; Sat,  7 Feb 2026 21:41:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770500487;
	bh=bu7sc6fm8R3ogR5RmPOZUc2BmaR7LgDj+vCm3snNvok=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=PADG2YQriX2d1jZtVnYKoqO8C61eyVj16Mf+0LMCs1hm5pkB/MzxzHwF41RWk+Xae
	 2QQSmy8I0/mw208VM4VMharZOdIwjJVfHppqu8m/BcY7kWfxLy90oEVqSgOtEaWy8U
	 vAE4vksJfObhxZInp6We8CnHXKysMP1pdORz66/mlhfMv4OtqvEFjr6NIPF+elfTFB
	 dDNpBfwtbRaykCKM5kmJM3f5ameU39ZUUvqqQXfRQQfua3+OhxdHwaYAWiy4lktGWr
	 V1jsC2Us1Vu3c0ImyJEQjuugUdCOhhYuuLrafN0CJNCYc1wQ6nclj8kkCaPu0rOYg+
	 8XvygYiPl49qw==
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-64ad79df972so684700d50.1
        for <linux-iio@vger.kernel.org>; Sat, 07 Feb 2026 13:41:27 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUUU3/4sMIa6e5rCKKG7s59DDXsgn+xcDG+XOmoNWbAd/3B0O8etO/ZltwvDKs0d6g1w3iOxt/dp5c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTQSigmHlm6sJ4TnX8o+5fqtgBJQVA0mWNjQ4p18AcHYW7Rst0
	4DQ9G8DunWXhbSqpnF9+bFYpPVdZinGqtVyhjoJF+KxmoUZWbdNVqgR0dzsUeJ+7pN8cgQm7A1c
	8uXRenClsucEsWVAHy2p9+13gVFuiWh4=
X-Received: by 2002:a05:690e:c4c:b0:64a:cee0:fa9 with SMTP id
 956f58d0204a3-64acee0115fmr4746840d50.17.1770500486519; Sat, 07 Feb 2026
 13:41:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <tencent_326708D02875274DF25B10B91402B3828606@qq.com> <20260207134950.0f064905@jic23-huawei>
In-Reply-To: <20260207134950.0f064905@jic23-huawei>
From: Linus Walleij <linusw@kernel.org>
Date: Sat, 7 Feb 2026 22:41:15 +0100
X-Gmail-Original-Message-ID: <CAD++jLmTJBct_+HW3S7D6mSFeXE_ma5gj8HRakDgy9PWre0rLw@mail.gmail.com>
X-Gm-Features: AZwV_QgRuQJn1GJ5TzWCm4YZTt_ZCj02-KSODdHSjrSbfw-XPmoRYjwL7CB846A
Message-ID: <CAD++jLmTJBct_+HW3S7D6mSFeXE_ma5gj8HRakDgy9PWre0rLw@mail.gmail.com>
Subject: Re: [PATCH] tof: Add VL53L4CX TOF drivers
To: Jonathan Cameron <jic23@kernel.org>
Cc: 434779359@qq.com, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, liufulin <frank.liu@faiot.com>, 
	Waqar Hameed <waqar.hameed@axis.com>, linux-kernel@vger.kernel.org, 
	linux-iio@vger.kernel.org, linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 7, 2026 at 2:50=E2=80=AFPM Jonathan Cameron <jic23@kernel.org> =
wrote:
> 434779359@qq.com wrote:

> > +#include <linux/of_gpio.h>
>
> Whilst I haven't checked yet it would be very usual to need
> to include of_gpio.h in an IIO driver. That may imply using wrong
> level of interfaces or just a stray include.

This is a legacy header that should not be used in new
code.

<linux/gpio/consumer.h> should suffice for consumers,
<linux/gpio/driver.h> should suffice for producers.

Yours,
Linus Walleij
