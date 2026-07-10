Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD79E374E57
	for <linux-iio@vger.kernel.org>; Fri, 10 Jul 2026 17:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783705265; cv=none; b=q5WMOiuHupmsSIROUkmWZFDl0GseArUh0d+AnkA/oeDIqKboDk+NqhAPQK4NR43fw7b56/0D0383EIfcSr1bObO6PapjQoKIT4JavIiFJkFcB6Ql2GQ1XlJottnD3jF/Qhxrcfn76qBjVf9KXXWS/4nRqLvtPrtIjErUz5vuRro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783705265; c=relaxed/simple;
	bh=aBk6IhQ1IK2fUCJkr4nbGuPnVeeCQJHeeoWmV/eJ4/U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dku6ojGG/4y7YtXOMyFGTo2GLion4c2ZLxi7pO19p/BzMiy42zLxTiNSkRIJS0THSsda3/Bg6PiZCl/khyOwMvHUCr0OoZYZ0cdUzYSgAjN6pU1Vb0R/OtuF6QT/GcBXI43s3uJ9jQ321RcIPQeXMk5IHBPWeHobeivnni9XqsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i0Ap5km4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i0Ap5km4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B50A31F00ACF
	for <linux-iio@vger.kernel.org>; Fri, 10 Jul 2026 17:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783705264;
	bh=aBk6IhQ1IK2fUCJkr4nbGuPnVeeCQJHeeoWmV/eJ4/U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=i0Ap5km4zmRukj/9vPI6OIMJjbyhl5Gesi329yn8Wrbl3fTae0W46g4rphglk9duI
	 /JgPGsvM8JeV/sQAmWWZR1DK7hQOsa8DCDwFxMBqtwO2SXvopdgL7nl1F/xEth4HAf
	 OxlIooOdW2Mr2XGBKIdtPU60y1zTH+kdd0lQbeHarnSaIYVhVS44lUtl9wFXTUUtfK
	 3LkHh2b9K/cPv8FgtUzVt9jyKU9VcmIaOVgAoDANMrjVfF3HbosVGOSGUI6r2M0o7t
	 S+W/xgYOM3mi2Wy1EQKwmTDAUNPhv9QkXC5Jdq2PKbtvhln5AJoV/XhJcWWBKJnYdA
	 AKGI9VphatRpA==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5aebd52488cso1254955e87.2
        for <linux-iio@vger.kernel.org>; Fri, 10 Jul 2026 10:41:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RpWupSJe7l/KLS//ntfALUSoOUVLvfo67oBLAz1imDnrYgjo8E1vd8bBg5aXVa0XY3H/2qyvnIqOxQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOliICedIyrrDXpY5SeFUlUWGpiK63vGpLf6NEAAxDDatp/x1+
	YhVW0+YrR/9XE/1LWzfKLCUCvNinTy1gd5mJCWDz8nhoZQjtKdU8Lkb0BLQgzj0VPiD4QU5/S0W
	Hcs3Uz/jvmZZPFoMvjXBb9w+rQ5XIzgA=
X-Received: by 2002:ac2:51c6:0:b0:5ae:af9c:c064 with SMTP id
 2adb3069b0e04-5b0236c6446mr26732e87.60.1783705263432; Fri, 10 Jul 2026
 10:41:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260704083412.43145-1-acharyalaxman8848@gmail.com>
In-Reply-To: <20260704083412.43145-1-acharyalaxman8848@gmail.com>
From: Linus Walleij <linusw@kernel.org>
Date: Fri, 10 Jul 2026 19:40:50 +0200
X-Gmail-Original-Message-ID: <CAD++jL=WW1tVFOd=0UE0JxJPgwYTye-oGgTjAw3RuWxYWmykSg@mail.gmail.com>
X-Gm-Features: AUfX_mwPkvWOaR6vPKS9R0WFz7jdLkjqhk7N88Wz38rFU7Ld9VBg94U6yIjIhEg
Message-ID: <CAD++jL=WW1tVFOd=0UE0JxJPgwYTye-oGgTjAw3RuWxYWmykSg@mail.gmail.com>
Subject: Re: [PATCH] iio: light: gp2ap002: Disable regulators on resume failure
To: Laxman Acharya Padhya <acharyalaxman8848@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 4, 2026 at 10:34=E2=80=AFAM Laxman Acharya Padhya
<acharyalaxman8848@gmail.com> wrote:

> If enabling VIO fails after VDD has been enabled, runtime resume
> returns without disabling VDD. Likewise, if device reinitialization
> fails, both supplies remain enabled. The runtime PM core keeps the
> device suspended when its resume callback fails, so the supplies must
> be restored to the suspended state.
>
> Disable the supplies enabled by the callback before returning an error.
>
> Fixes: 97d642e23037 ("iio: light: Add a driver for Sharp GP2AP002x00F")
> Assisted-by: Codex:gpt-5
> Signed-off-by: Laxman Acharya Padhya <acharyalaxman8848@gmail.com>

Looks right.
Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
