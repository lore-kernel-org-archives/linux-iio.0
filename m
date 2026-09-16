Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3317D3BBFC8
	for <linux-iio@vger.kernel.org>; Wed, 16 Sep 2026 17:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789580052; cv=none; b=dbqFI5V53obsIQhiktAilquTr+aY3Kw88qdw703KZHTwqgR9XkaKhHdDIuLhXOOFT9IfaGV6hc/JYVZctKiWE7mGnuBSQpx+mRrRFJ2AsU5Mhjz29/3/9PjD8S6XGjI7S03BFY4zP5PH7dYzAevAWFExLasnuJPKDOGaY+oqMyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789580052; c=relaxed/simple;
	bh=LN2LspITv3xkE1/NS/TeXztMqaceG3gtSU2N5tESJyQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IkAQsARKEmXk4xl9zPFrXaPMb5O2wwzkmP7cREJvPiDRsBiQ85FJd+SbKQDld76zPkMCHHBM6m59uZzJxnoxD0YPKn9dtPjPmWWqY4F6afvbe4chbNIKwI+rdKMAEjwEvpreT5eEIgyp+pqAjLzQRK9F0wyzmdhH0IfbjP64Hbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dHnLngYv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dHnLngYv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEA601F0089B
	for <linux-iio@vger.kernel.org>; Wed, 16 Sep 2026 17:34:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789580044;
	bh=LN2LspITv3xkE1/NS/TeXztMqaceG3gtSU2N5tESJyQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=dHnLngYvaCp5p9+qgK82CrZ0A44lBO9IRTLtvxWSl5WqQ2F9MED4KcWzhVDlbq6Ox
	 j+vcqD6QYQ5qMISrKz5aSx9nw7NufXBe7K+VbQjbZaa4LkMT/4cuozhMZA70Q3Iez9
	 IWKZFk7hV/RikVKBpHRUWAPI0fCPsaJRaHfl8vAz8N2O8STfc084sRQVvFKlvJJtFP
	 H1NpNLyvAX2ztE3Jkb1v80/PyB/dS9rwx/9HvvzK67buu7VFiwIOu2oQQbxZN/c+jx
	 jln2IOK80iYSHFn0y1YVRD1Jqxx38jD70vOViYvAP1G5H7yfi94kuj0+AbIm7fK9Ta
	 vddJKxgoRZQ8w==
Received: by mail-lf2-f13.google.com with SMTP id 2adb3069b0e04-5b5e4f16f15so1180899e87.3
        for <linux-iio@vger.kernel.org>; Wed, 16 Sep 2026 10:34:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBx/aHTbVKa10WiqQUQps4fUziGw7Sd322RXCPMkI8V6guczBXZ7ffJEJ/qxP/eV2jh0cjp1YMKt3Ow=@vger.kernel.org
X-Gm-Message-State: AFuF++k8d8SmfAAg1zFACYxcaNNjdunHfI1jFXUU+4emg6j/pUJeJLDJ
	dSltb5IxoPBm1Gj0AKBSXylnKidyD1pwDIeAuuy68ocvHNjm3iM/PuZ4rnldu2OMf47rgDJOKMU
	SWCAFhtXPObK0Zhg9c1URxInZuZBPGxk=
X-Received: by 2002:a05:6512:3f23:b0:5b6:423:7f10 with SMTP id
 2adb3069b0e04-5b8b667b01amr1882851e87.30.1789580041252; Wed, 16 Sep 2026
 10:34:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260916161205.2082579-1-vulab@iscas.ac.cn>
In-Reply-To: <20260916161205.2082579-1-vulab@iscas.ac.cn>
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 16 Sep 2026 19:33:47 +0200
X-Gmail-Original-Message-ID: <CAD++jLmD7jgAtwo7A01Ow0f=qYQGcE_XAPWJ1Hw+oyquGqEe_w@mail.gmail.com>
X-Gm-Features: AcwNN1Vcy7j5iBgknGpi0d42nIDdyyFFmeCq40y45IGsXBuWgzXJ25tbVP6kupQ
Message-ID: <CAD++jLmD7jgAtwo7A01Ow0f=qYQGcE_XAPWJ1Hw+oyquGqEe_w@mail.gmail.com>
Subject: Re: [PATCH] iio: accel: kxsd9: Fix runtime PM leak in kxsd9_write_raw()
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: andy@kernel.org, dlechner@baylibre.com, jic23@kernel.org, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, nuno.sa@analog.com, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 16, 2026 at 6:12=E2=80=AFPM Wentao Liang <vulab@iscas.ac.cn> wr=
ote:

> pm_runtime_get_sync() increments the usage counter even on failure, so
> every successful call must be paired with a put. Rejecting an invalid
> scale value returned early and skipped the paired
> pm_runtime_put_autosuspend(), permanently preventing runtime suspend.
>
> Fixes: 9a9a369d6178 ("iio: accel: kxsd9: Deploy system and runtime PM")
> Cc: stable@vger.kernel.org

It's NOT that important.

> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
