Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3144DAF92
	for <linux-iio@vger.kernel.org>; Wed, 16 Sep 2026 17:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789580124; cv=none; b=JJi0HaWEeXUb47ZaTEaJMfs9TRs11Tw604+6DJdpiEdwWjfWdmDBThsjHPhwmyJnL56O8nSgK9lsq02mUArI0wr2TJ4Wj/oG3jg48v76sF9IXhdkYG1b7rj4DKGCze6l30zkskdzJXem+vc5ylh6D9YQohoLDjcv5+q0i303V5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789580124; c=relaxed/simple;
	bh=N7/VEIjgndUyqBDVO40aU7cqvnPepfWlnv91dKj0m/I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NAK+3iYOKkejSlsML4wx1fmhKkFNMsrAiqmJZ+bV5/Y650W4n2TcfODmvMtKTbv64l4PncSykrnd/w42LcW3zGPTk23mHcyOGqAemiVodyDe115Xzoqo0UPTq03gBOdYk0hXQ0kyFss8r4SujTnayPhTZiSFY20lKoJDqmj/3/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kDriWnEq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kDriWnEq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 993C31F0089C
	for <linux-iio@vger.kernel.org>; Wed, 16 Sep 2026 17:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789580110;
	bh=N7/VEIjgndUyqBDVO40aU7cqvnPepfWlnv91dKj0m/I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=kDriWnEqD6+yfiIJi0v4uFjHkwdoBRJ6Ap9TZn1rQkG1VYFbeG3BbxA0UDfD33UVj
	 XeaH3d4rOniVOrXxh7d9xVgcW29o3Zrhgok+rF3/h4M/K6/bDoo+trz0rZisQHvfn5
	 bbbW6tmJN21l7vhj36rNXb40f61ipkg4MrV/WnwFBxQiO7Esf8BDtDS3JVvLYQGuz6
	 U4Iy6VXIvLmxqjezvLc+XQQGwyVcqXvwTUrekY23/JWg8aOF5V553eJDkSk3RyDDVj
	 zbABjTvueMjPsPHrc0HVbrWHZ7dpzchkFKQ8XCTzv47D9w4xFsBJnhc2im9JfLWejn
	 ogIk0c9BeyYNw==
Received: by mail-lf2-f12.google.com with SMTP id 2adb3069b0e04-5b5e4f1651cso1190882e87.0
        for <linux-iio@vger.kernel.org>; Wed, 16 Sep 2026 10:35:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvByA9WDG44P2ps8co5b0Gg25icRrcbg2UByd0N6+M3am9A4+8ZKISxD6nG/bFeWvIXsSNQ56ysI+aiw=@vger.kernel.org
X-Gm-Message-State: AFuF++mhNIyfrHcUFha7t2hLO22sNxb78HtCs4B6vWOJZ1L9WfGswWj7
	Me2vw+WdR+KhNQfqRWLofx0wu96rWLL/hQVoGbY8xd4xdRt36MXE02oJlwqQoUQnTWNZlN2F2fw
	tn/4s5A5LG5RIdcuH80lw6Raf54UkYfY=
X-Received: by 2002:a05:6512:1089:b0:5b6:186e:b79d with SMTP id
 2adb3069b0e04-5b8b6664ed4mr983208e87.57.1789580109346; Wed, 16 Sep 2026
 10:35:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260916163646.2084234-1-vulab@iscas.ac.cn>
In-Reply-To: <20260916163646.2084234-1-vulab@iscas.ac.cn>
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 16 Sep 2026 19:34:56 +0200
X-Gmail-Original-Message-ID: <CAD++jLmJ_t1DVkDfRwbTQ23w9AJ9wpB3yqcCCTXqe6H8A_-D9g@mail.gmail.com>
X-Gm-Features: AcwNN1WWyvCAlUuXsylbp30V6rpjRIwZU0ilKLYM1MPAZf8OJdK-TPSZPz3xV6A
Message-ID: <CAD++jLmJ_t1DVkDfRwbTQ23w9AJ9wpB3yqcCCTXqe6H8A_-D9g@mail.gmail.com>
Subject: Re: [PATCH] iio: light: gp2ap002: Fix runtime PM leak in gp2ap002_read_raw()
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: andy@kernel.org, dlechner@baylibre.com, jic23@kernel.org, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, nuno.sa@analog.com, 
	xc-racer2@live.ca, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 16, 2026 at 6:37=E2=80=AFPM Wentao Liang <vulab@iscas.ac.cn> wr=
ote:

> pm_runtime_get_sync() increments the usage counter even on failure,
> so every successful call must be paired with a put. A failure of
> gp2ap002_get_lux() returned early and skipped the paired
> pm_runtime_put_autosuspend(), permanently preventing runtime
> suspend. Jump to the common exit that releases the reference.
>
> Fixes: f6dbf83c17cb ("iio: light: gp2ap002: Take runtime PM reference on =
light read")
> Cc: stable@vger.kernel.org

IMO not stable material.

> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
