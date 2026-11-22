Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795380577;
	b=TaNVlA5zFYI2dv2LNpPG8keFk53+wpPC+8uCx26HwOSJKb+WiPa9I3K4yfe6ytWY4nl+
	 SkYoCr+IQutqAnJGVRHnnQW4d8m/h3bLhyP6phbzO1Kxzb0VQygK14SglAtcKdTou5OJq
	 dToVBua8jyQs/Ye+z3XKe8s4Sc/pbFvq+B4N4UFsmHYIZ2vcXIrx2EzY3bA6D3QDmCRwm
	 38QRPZcAKE/fHXfb0qZLFOmyqQ1maWgBkLD9hAwL2yap9kAwN3m0BIP4vhLYXlpFNfcW4
	 SLvhHT5nF2aMT9y24JXKmTHFHRPygCLJJH9m9WrGPhvHNBxcjqj36auD5q1TK/nl4Lg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795380577;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=zdqMHZJu/xkr58nOw2kits8fBQn+bxgBmrmWFfh5cGM=;
	b=wNzi5GBoNM0sDYIi1JiUtdQv+cQNX0QmQnhcPKK+l5zTk+uzdoZxbFFtPIeOXNy4g5Ou
	 xLiVifiCe3Vz2B0TgWhBhyzbI2Q6b8Xyol2dXGyPg3ptUUh+Nd32Yne0Wd5kesme4IXol
	 PgYrWQWlSa6Yo5rUMxn3kjpViSpNP/+IvehT4ovULPn4LVkmRQk1kEiH27a0Ce5ghfgi+
	 LZY23nSvmf4UGrQModXWzqI4dQtHkKHE4GeuxwOPz5ZBoC99sH+P2+Z2a9BeK9zYPQsYI
	 NBI6Yh96jaUy0eUGXsJUDGaclpRM0P9xBtHDqHvBl2yz+ZCCsfddVau1fmn3vyIbALw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iQxarP0b;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A06C0606A31A;
	Sun, 22 Nov 2026 20:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iQxarP0b
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFEB31F000C4;
	Sun, 22 Nov 2026 20:49:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795380576;
	bh=zdqMHZJu/xkr58nOw2kits8fBQn+bxgBmrmWFfh5cGM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=iQxarP0btcWbQATk4TSl34vEyppel98cM1VTk1mM/wuF+Vgfy0hfbZBccINg/lJLG
	 pT8JM/8QNAw771PapCeU2RWxnb6XxC6hQzAc+fMjW+HLFzP+1kI6ba0EhDLDXGQw4Q
	 kJC7rSwwVtEQXGFnFxKcB+0n9/qbUYnVyTiQdQohCD/4yxEaXUJs2zozv726DMQHm9
	 Skg2n36QGyjRCwyr867x9hvVytxltpRzOinBvJOGdDT/ABRYta0hUvXcMeWCReMAXU
	 gfTQcCjsrLrEv3XLWG6nrwdKEpS2w3ZgZf0GeFfM7zkq2fcY5Le04yu7+kz8phrkj1
	 8FOJHfs9a7e0w==
Date: Sun, 22 Nov 2026 20:49:29 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Arnav Kapoor <kapoorarnav43@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Andy Shevchenko
 <andriy.shevchenko@intel.com>, Gwendal Grignou <gwendal@chromium.org>,
 Joshua Crofts <joshua.crofts1@gmail.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/3] iio: proximity: sx93xx: keep the IRQ balanced
 across suspend and resume
Message-ID: <20261122204929.326a730a@jic23-hlaptop>
In-Reply-To: <20261114073601.23404-1-kapoorarnav43@gmail.com>
References: <20261114073601.23404-1-kapoorarnav43@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 14 Nov 2026 13:05:54 +0530
Arnav Kapoor <kapoorarnav43@gmail.com> wrote:

> sx9310, sx9324 and sx9360 disable the interrupt in suspend before
> anything that can fail, and don't enable it again when suspend or resume
> fails. One patch per driver, as the Fixes tags differ.
Applied to the testing branch of iio.git and marked for stable.

Given we hope that failure in suspend and resume is incredibly rare
and we are now someway into this cycle I'm not going to rush these in.

> 
> Changes in v5:
> - Disable the interrupt with disable_irq() before taking the mutex,
>   and enable it again if suspend fails. v4 called disable_irq_nosync()
>   at the end of suspend, so a threaded handler woken during the
>   register writes could run after suspend returned. Found by Sashiko.
> - Move the register accesses into a *_sleep() helper per driver so the
>   mutex is released before the interrupt is re-enabled on failure
> - Rebase on fixes-togreg

> 
> v4: https://lore.kernel.org/all/20261101102518.22757-1-kapoorarnav43@gmail.com/
> v3: https://lore.kernel.org/all/20261028220444.70121-1-kapoorarnav43@gmail.com/
> v2: https://lore.kernel.org/all/20261026112342.65917-1-kapoorarnav43@gmail.com/
> v1:
> https://lore.kernel.org/all/20261026100322.16720-1-kapoorarnav43@gmail.com/
> https://lore.kernel.org/all/20261026100408.16874-1-kapoorarnav43@gmail.com/
> https://lore.kernel.org/all/20261026100450.17023-1-kapoorarnav43@gmail.com/
> 
> Compile-tested only (W=1); I don't have the hardware and haven't
> reproduced a failing suspend.
> 
> Arnav Kapoor (3):
>   iio: proximity: sx9310: keep the IRQ balanced across suspend and
>     resume
>   iio: proximity: sx9324: keep the IRQ balanced across suspend and
>     resume
>   iio: proximity: sx9360: keep the IRQ balanced across suspend and
>     resume
> 
>  drivers/iio/proximity/sx9310.c | 54 ++++++++++++++++++++++------------
>  drivers/iio/proximity/sx9324.c | 43 ++++++++++++++++++---------
>  drivers/iio/proximity/sx9360.c | 45 ++++++++++++++++++----------
>  3 files changed, 94 insertions(+), 48 deletions(-)
> 
> 
> base-commit: a6d9114f68c4b5507b2d945bd6d1e37415f913c5

