Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC0542E22B5;
	Sun, 27 Sep 2026 17:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790531372; cv=none; b=IU0r38EI+Nd4IimaKSzLHQTbwR3JD2FRpGHNqYOJMc2241sc/UIGjPi+0/C6I6lX3Hy7CX8dpRYvWoI+P6gB0Hbtqzj/AuC1L8HAc1otwDboLLXP70o34ww/Ielf9HqDMXX4JagpLzs+MXjzod9RKQe/geRRGsB2SRHxWC/coo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790531372; c=relaxed/simple;
	bh=JmH6ynSVla384YYdBPmjN+u5U/j2CRGFnFL5O+k4U40=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cinyACQ800sC0YfusDdRp2uhLfNhQm9FIrLLJ+U84sIYuxOFukT7uTMb6hVfA5gBwsIGZ4EjhvzSwK/m0B2NViRu6gmKgHACG+z6BOUSVNaHrE43hD0iVVEPSZFyJBIubZvhUYOPU/tiUKUDcvS96VzK/ABzCeDv0l94DuJcZsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mYZG62gi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mYZG62gi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BAE21F000FF;
	Sun, 27 Sep 2026 17:49:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790531370;
	bh=vep0rxIRKoNxiLFQDPN+hgCPxdJunk6/QndDTJ30FU8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=mYZG62gi1MfOQjlEtabjcLxsCKlJIcb7RbmgT2+zjFK+BXH6zgV9pfl38PmGrQwWn
	 qHVgKBkIxWqyAHMxfinPzhMLEZLdtNmx5ZUROy2ss2l6fF1wPIau2XlaMyQaGN11no
	 AgcKvsLndaDRc+6rDrlkSGtBbiS5paXG+dmu5PGMty8B2SwStzpWyFrTJN3ASxUAT2
	 YQxkfqzhLnJzC+NRIWy6JSR9g60OOdBY7acEcbR5x5q3DUHkOthK7h3isyW98RehJm
	 de+CWyPIwhOP1YpWBdG1DKOCvhD/Nmo8iaKGw/v+78D9UmiAiTj7jR893zCv44EuWL
	 aBdvfXbC8oKjA==
Date: Sun, 27 Sep 2026 18:49:23 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Jiale Yao <yaojiale02@163.com>
Cc: Alisa-Dariana Roman <alisa.roman@analog.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Michael Hennerich <Michael.Hennerich@analog.com>,
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>,
 Ramona Bolboaca <ramona.bolboaca@analog.com>, Marcus Folkesson
 <marcus.folkesson@gmail.com>, Kent Gustavsson <kent@minoris.se>, Matti
 Vaittinen <mazziesaccount@gmail.com>, Kurt Borja <kuurtb@gmail.com>, "Uwe
 =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= (The Capable Hub)"
 <u.kleine-koenig@baylibre.com>, David Jander <david@protonic.nl>, Danilo
 Krummrich <dakr@kernel.org>, Linus Walleij <linusw@kernel.org>, Dmitry
 Torokhov <dmitry.torokhov@gmail.com>, Bartosz Golaszewski
 <bartosz.golaszewski@oss.qualcomm.com>, Guillaume Stols
 <gstols@baylibre.com>, Jonathan Santos <Jonathan.Santos@analog.com>,
 Krzysztof Kozlowski <krzk@kernel.org>, Oleksij Rempel
 <o.rempel@pengutronix.de>, linux-iio@vger.kernel.org, linux@analog.com,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/9] iio: adc: reject SPI devices without match data
Message-ID: <20260927184923.4362386e@jic23-hlaptop>
In-Reply-To: <20260925125754.2162337-1-yaojiale02@163.com>
References: <20260925125754.2162337-1-yaojiale02@163.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 25 Sep 2026 20:57:38 +0800
Jiale Yao <yaojiale02@163.com> wrote:

> SPI driver_override can bind a device to a driver without a matching
> firmware entry or SPI device ID. In that case,
> spi_get_device_match_data() returns NULL.
> 
> These nine ADC probe paths assume that the returned chip information is
> present and later dereference it. Reject devices without match data before
> the pointer is used, following the handling added to the AD5686 bus
> frontends by commit 572a00852635 ("iio: dac: ad5686: missing NULL check on
> match data").
> 
> The ADC128S052 and ADS7950 probes also dereference spi_get_device_id() to
> obtain the IIO device name. Use the always available SPI modalias instead,
> so the override path does not depend on a matching SPI ID.
> 
> Each patch fixes one driver and can be applied independently.

Whilst I'd have loved to just set the flag that the series Uwe
links to adds, that's not available yet so for now indeed
these are all valid fixes.  I'm not going to rush them in.
Applied to the testing branch of iio.git which means next merge
window most likely.

Thanks,

Jonathan

> 
> Jiale Yao (9):
>   iio: adc: ad7192: reject devices without match data
>   iio: adc: ad7606: reject devices without match data
>   iio: adc: ad7768-1: reject devices without match data
>   iio: adc: max11205: reject devices without match data
>   iio: adc: mcp3911: reject devices without match data
>   iio: adc: ti-adc128s052: validate SPI match data
>   iio: adc: ti-ads1018: reject devices without match data
>   iio: adc: ti-ads131m02: reject devices without match data
>   iio: adc: ti-ads7950: validate SPI match data
> 
>  drivers/iio/adc/ad7192.c        | 3 +++
>  drivers/iio/adc/ad7606_spi.c    | 6 +++++-
>  drivers/iio/adc/ad7768-1.c      | 3 +++
>  drivers/iio/adc/max11205.c      | 2 ++
>  drivers/iio/adc/mcp3911.c       | 2 ++
>  drivers/iio/adc/ti-adc128s052.c | 8 +++++---
>  drivers/iio/adc/ti-ads1018.c    | 3 +++
>  drivers/iio/adc/ti-ads131m02.c  | 2 ++
>  drivers/iio/adc/ti-ads7950.c    | 4 +++-
>  9 files changed, 28 insertions(+), 5 deletions(-)
> 
> base-commit: 93f51579e7df248780214094418f205253383cc5

