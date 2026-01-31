Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E4A22BE03C;
	Sat, 31 Jan 2026 17:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769879146; cv=none; b=MrKCx0OFy7DhKCzp+VqC6Q25xJslGi0ZGg3aruVhKg2f2bJvxl9kkH9CWW5M6/txpwz6p+NuzKuAIRRGXBPYHE2ppEm/RaiGqZVWmj10I/W5VhZcZVLut1yFob5DOIaNi2car9P4jGSp924p9WLdGd3OEmd1BeRfIVJn/7YWTLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769879146; c=relaxed/simple;
	bh=Qj775lzDao1AN9msfXxaXkp23DOOzabHXOVekmxza+g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CVNz5n2MNn/a5DBkzVYI28FrTZAFe9EsI7MfS9p/E6VIXxy6faeq5figcx+O3qwoQy2nLzgzFLmwMRpDnhQaRQfISHdadCjStSRXiTwaTGyKZi/rRHKBGHKGRTSgsvor3cn8N0fpJpAoODybh9QsjxbayJS1OCV85pP6hfY4Ljo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nls0n2uh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nls0n2uh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10435C4CEF1;
	Sat, 31 Jan 2026 17:05:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769879146;
	bh=Qj775lzDao1AN9msfXxaXkp23DOOzabHXOVekmxza+g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Nls0n2uhllZ0odV9w/6w9scNO5bx9uBDxkX4cBleHQ8T4CCS+X6r7+BRWCMK0M1Tm
	 JMlzOYIHD/GNsv1EVr0Ztwimkm1y7jhx4GT2TWAXSfXrFko/GKOXtgVRC91Ft7LbTT
	 FJbwfXZCV/DPmgF/h1OvOgLOWHLktKsCH6M5RM68Z1eUD6IXhytm8VWgx/mYEFa5B4
	 6jn+r1cqiqtKvFjjnw5Z0ZlFkmc6xT2AWWv/Z7AAJ67V6qMN0HrJp5dTwymwv+v3jC
	 SBUk0PBUCdKCocE7hOr3OMr8Hsl9YRp5GfUw9tJQyBPo0pXa0ecCiPW7lQEn9OphKD
	 FihFlTIlTy3Wg==
Date: Sat, 31 Jan 2026 17:05:36 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Linus Walleij <linusw@kernel.org>
Cc: Antoniu Miclaus <antoniu.miclaus@analog.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Linus Walleij <linus.walleij@linaro.org>,
 Sakari Ailus <sakari.ailus@linux.intel.com>, Ulf Hansson
 <ulf.hansson@linaro.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: light: bh1780: fix PM runtime leak on error path
Message-ID: <20260131170536.48a16474@jic23-huawei>
In-Reply-To: <CAD++jLnL6f0Jg0rcgqzkR=GE12JmbbJVcTzVyHYsr9r6d02fXg@mail.gmail.com>
References: <20260130113041.50978-1-antoniu.miclaus@analog.com>
	<CAD++jLnL6f0Jg0rcgqzkR=GE12JmbbJVcTzVyHYsr9r6d02fXg@mail.gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 30 Jan 2026 14:16:36 +0100
Linus Walleij <linusw@kernel.org> wrote:

> On Fri, Jan 30, 2026 at 12:31=E2=80=AFPM Antoniu Miclaus
> <antoniu.miclaus@analog.com> wrote:
>=20
> > Move pm_runtime_put_autosuspend() before the error check to ensure
> > the PM runtime reference count is always decremented after
> > pm_runtime_get_sync(), regardless of whether the read operation
> > succeeds or fails.
> >
> > Fixes: 1f0477f18306 ("iio: light: new driver for the ROHM BH1780")
> > Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com> =20
>=20
> This looks right!
> Reviewed-by: Linus Walleij <linusw@kernel.org>
I've applied this to my local tree for now.  Given where we are in the
cycle this likely won't go out until after the merge window when
I have rebased on rc1.

Thanks,

Jonathan

>=20
> Yours,
> Linus Walleij

