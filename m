Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E2A828466F
	for <linux-iio@vger.kernel.org>; Fri, 30 Jan 2026 13:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769779008; cv=none; b=cYAhf6PpFa3tIz5XlrHgA2X4PRGG3FKFJ7n6R18VSqKHyP9hgOuxi5LbpPDuV9jjCSitz7orMiEKvn1uxq403fTQOR24pfTtcHmYA4FxjJB09mcGZJSqoUrWYdaRE6N5sQRHgNymXhGzU6KLy/YA712Yij/qISect2mJiVpZus0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769779008; c=relaxed/simple;
	bh=asoQbzPvw8IEKj/yH1M7KoX2DwkvwWTyayHEl9FMuXo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sAgujEARSSEei726yKsoZSaISWMuR2X5Hq7mkXHdzvQEjZnoICgsnYvKEYwNybvSd2GTNfJhCB5OARjMyZy/hLB4DHYhpcWTFKQwEPpi4/Cd+SLyytDvoUWvjXsJxFQPNnxH9KHO8+c49+gLHACDCtaq9y4cFhEWSskz2s4nd2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qf9JHRJa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qf9JHRJa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3ADDC4CEF7
	for <linux-iio@vger.kernel.org>; Fri, 30 Jan 2026 13:16:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769779007;
	bh=asoQbzPvw8IEKj/yH1M7KoX2DwkvwWTyayHEl9FMuXo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=qf9JHRJa20Fil84gykxeaz4WWBx4wwUJqOFbCxBhvOzeNSU3xSGz1gedudU2GpEog
	 iNTLNnh3/hWgT33TzSZiRvDKaqk5w/Qz7oqqXs0goM8NvMzC9w9Ojfzd1bnxnq8Bmn
	 CK6Kghx1wfubnhsvXj0oxxEDiAhfCUC+Z0rCHOtG8yxUmDm0/FiAsLnWH0YBQf5aXS
	 UFMZ2Unrn3MCiWxTdytbXJnP4E5myHHAprV8qZpsW5jBny5EJhmucseAfxmHhzh0If
	 i+QR3marml0lwkzIoyPfHtrqwvYCVTjZLTTGzlxLD+5Mi260DQbOrwcXKh/+9o950B
	 ax6SrCbbth/NA==
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-7947be0850cso21139507b3.0
        for <linux-iio@vger.kernel.org>; Fri, 30 Jan 2026 05:16:47 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXKGGBirG/3VOaJikZlb8NqJQfrSjLj39nR+nzNIebjmBrhtA1h3x7ktkzeRbwmGzo4wWqSoMKqgIY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiahD886R2uf+O/M6jX/OxSBo5jfHokrQtIBPufTZYfXZIhOnd
	zJoffnRQLUWuupueB7q7wEtreQeDtDz+U15wb0xjp3SiL1/oUT4hdXZCaV9s1mhf4fd8Uvsq3VX
	P+OwR0+5HYabOrAkusO2IpKyC1sAx3E0=
X-Received: by 2002:a05:690e:d05:b0:649:af55:4582 with SMTP id
 956f58d0204a3-649af554694mr499153d50.32.1769779007026; Fri, 30 Jan 2026
 05:16:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260130113041.50978-1-antoniu.miclaus@analog.com>
In-Reply-To: <20260130113041.50978-1-antoniu.miclaus@analog.com>
From: Linus Walleij <linusw@kernel.org>
Date: Fri, 30 Jan 2026 14:16:36 +0100
X-Gmail-Original-Message-ID: <CAD++jLnL6f0Jg0rcgqzkR=GE12JmbbJVcTzVyHYsr9r6d02fXg@mail.gmail.com>
X-Gm-Features: AZwV_Qi-Ey3FEMuP1xwoA3ZgZW954bam9yPuHWijaeLaPZ36zMntir4df1Iqkwo
Message-ID: <CAD++jLnL6f0Jg0rcgqzkR=GE12JmbbJVcTzVyHYsr9r6d02fXg@mail.gmail.com>
Subject: Re: [PATCH] iio: light: bh1780: fix PM runtime leak on error path
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 30, 2026 at 12:31=E2=80=AFPM Antoniu Miclaus
<antoniu.miclaus@analog.com> wrote:

> Move pm_runtime_put_autosuspend() before the error check to ensure
> the PM runtime reference count is always decremented after
> pm_runtime_get_sync(), regardless of whether the read operation
> succeeds or fails.
>
> Fixes: 1f0477f18306 ("iio: light: new driver for the ROHM BH1780")
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>

This looks right!
Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
