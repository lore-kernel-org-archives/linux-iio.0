Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794101352;
	b=zYlv1AwCjKEZ+9ZePsk8OkiUNonDI85kx/3qjfSLQgLXXLwGzrFVHAHQ91dDs4+VxDfr
	 BcB6ZFsnr2e7YRq2BkTtjQZdALA+kQXX2RlXCjv/63aknqjWn5WHIuvUv8x77u59G7p55
	 +ptBLKKYe0QympgPTW9JkED7nl6anlK0g5xpDz32V42MeohnMtJBE/6gElupqJemi5x8/
	 Bs57EWf/dCg++4V87vR20/pmc5InrKAqzng5Itt4rJJ7xpSlZxyhCm/AKp3kk4InjhQjC
	 ymtxOQ7n/zvhD6IdAR/dg0K7cz2sr37F/rga0AFHgZuA3dh/Uk0JLz4mMkePGpDhDYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794101352;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=x2cfPYkeTIhQOJBkbx7qFVMAeRGd0MqXKIpv3aH2spY=;
	b=qqLdzOykFbKN9koVIDyi+6T1mh4VEdw1Y5PgVUSPn6+tUT73b9IwtKqGu9nSq/0Fhm/b
	 12u2dHYrsV2cIlKDuD47Q21kZgeHHXTQffmtYhfzub5ITF36xHAlcnlP5bIGKXRugTvtN
	 p3aMU5gkZymjL4WprBiuiOL1rBNtYeTJCEdPpEiAwnyqbTNY62DJ+vJbVbILYj+GuJRGs
	 C0eofOkvQfzUEGaembyhwYrwyimCx3QfpWM3MjV44WG99aPEi8rq3yvP8WycyRHirD95Z
	 mrIX68XYLpviOJR4p7ZTuGIijBffuqD0UyOCm2EFkO4rMgfJi1EZmiEf8nyZmRtUcFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B2Dxg2xJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF8F5606A326;
	Sun,  8 Nov 2026 01:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B2Dxg2xJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90D091F0089F;
	Sun,  8 Nov 2026 01:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794101351;
	bh=x2cfPYkeTIhQOJBkbx7qFVMAeRGd0MqXKIpv3aH2spY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=B2Dxg2xJZkSYE6/K7n+/zY15/3ATJHNeZf5quVAvbr/6d7aYbfFoXfWp1Kw8w844p
	 FWzOblv9oUO7qsOddeWg2f1Hk0/qBvI1B2Co2Y28Q5PCp04Fe8BAwE9s4AYbtnZTTs
	 x66yvgtHB0vW41CDW7ksJFzjSaLldMqtJQ6r+1kKPY0tgB2LjHKSlOkwOJozkshJ6E
	 9ZiaO+W1gqKfSZnhzSHc2pBsd9MWf3k5tZMFKJPbcTql3/b6XLVFXHRNTMZJqKx5pa
	 SWQ1bRqRSyFoGEW9wzNNdCijpIjGuoPyZspOdNovW9NZE1hRwrd9ECL88u1hEPd+ba
	 carjVIIEy9q0w==
Date: Sun, 8 Nov 2026 01:29:04 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Arnav Kapoor <kapoorarnav43@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Andy Shevchenko
 <andriy.shevchenko@intel.com>, Gwendal Grignou <gwendal@chromium.org>,
 Joshua Crofts <joshua.crofts1@gmail.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/3] iio: proximity: sx93xx: keep the IRQ balanced
 across suspend and resume
Message-ID: <20261108012904.4555e72b@jic23-hlaptop>
In-Reply-To: <20261101102518.22757-1-kapoorarnav43@gmail.com>
References: <20261101102518.22757-1-kapoorarnav43@gmail.com>
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

On Sun,  1 Nov 2026 15:55:01 +0530
Arnav Kapoor <kapoorarnav43@gmail.com> wrote:

> sx9310, sx9324 and sx9360 disable the interrupt in suspend before
> anything that can fail, and don't enable it again when suspend or resume
> fails. One patch per driver, as the Fixes tags differ.
> 
> Changes in v4:
> - Enable the interrupt first in resume, so resume mirrors suspend
>   (Jonathan). This also drops the sx9310_wake_up() helper from v3.
> - Drop the IRQ 0 wording from the commit messages (Jonathan)
> - Drop Joshua's Reviewed-by, as resume changed

All 3 of these look fine to me, but given they aren't totally trivial
I'm going to leave them for a while in the hope someone will test at least
one of them!  If it looks like that's not happening I may pick them
up in a week or two.

Thanks,

Jonathan

> 
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
>  drivers/iio/proximity/sx9310.c | 32 ++++++++++++++++++--------------
>  drivers/iio/proximity/sx9324.c | 28 ++++++++++++++++------------
>  drivers/iio/proximity/sx9360.c | 30 +++++++++++++++++-------------
>  3 files changed, 51 insertions(+), 39 deletions(-)
> 
> 
> base-commit: 2ef6f5c4ee56e90c237c5f7687f09e635f7d30a9

