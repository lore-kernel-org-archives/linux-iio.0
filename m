Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9AEF18C2C;
	Mon, 27 Jul 2026 01:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785114821; cv=none; b=QqcyGTTwuqG9wOGbSnDlORAs0en6nsEuPtTd89sHUmhF0k01sWNhB6UdMKz3z2cnwq/jllnxB5WEhOK51Z06g1/2J5VcfPkaC3SKF84j09jtGUcyE/Sdx53ZRtHcczP1/6GnXduik7wMu4ixoU1+ROcSQ1W3qZzN8iOcEFlDVBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785114821; c=relaxed/simple;
	bh=mq8VXnLsTk+/cCqhfToOa/y0g5wrHRihUv7ARK47Arw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qQgVv2BtNzwBiBNEbEvPVI55DM0RSBxgiOHVOX+YUhdboGvJ01r4qB09sNpE+VWgwVKkpQPGy5EPaDkPywlCxsv/clYRxeOqzDyJnIEOjDnv3JqH3FARIu8fuqvv8IR8UWkh0QmGtBlGCooLmbL4TaRztNF/nXkU/wdeSG+D67w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YUM4WSai; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YUM4WSai"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F9E31F000E9;
	Mon, 27 Jul 2026 01:13:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785114820;
	bh=NrTzxwIMvZx+vaIOBmrEfadLiZcNJrDuKz4iKWR3yH4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=YUM4WSaig+b6Cg90Tg2qtYVd6TvgqLLWH0Tms5hL3d808NTuCbv5rjB8W7VEo4uVN
	 ZHOle7f5lwn1U9cmyRUB5Xw/nmBfbu40Pnpt0qoC7fNHHlmrP+k2lOE905WN14firq
	 Z25mTrF8Nlrzbt5TglX0TeunMceWYfKQ1QSPiKcUoRD9k7y1WKAhGnwQAlCNorjbAo
	 9FW/s/SlguRPhwK5OrKx3WCoVcXXn+lyfH1KCo9/fbJSU184sU0u9OFFjkBepjlP+V
	 3kXggmUtyqRLl0bGVMkQT5kgMpUa3MJLUjxF7La31aroeBztaUGrKCLIHSpD4f+Em7
	 QevpOqjyXqWug==
Date: Mon, 27 Jul 2026 02:13:35 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Rodrigo Alencar via B4 Relay
 <devnull+rodrigo.alencar.analog.com@kernel.org>
Cc: rodrigo.alencar@analog.com, Michael Auchter <michael.auchter@ni.com>,
 linux@analog.com, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Michael Hennerich
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Conor
 Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v2 0/6] iio: dac: ad5686: extend device support
Message-ID: <20260727021335.09c3287a@jic23-huawei>
In-Reply-To: <20260724-ad5686-extend-dev-support-v2-0-cfc2b30ce988@analog.com>
References: <20260724-ad5686-extend-dev-support-v2-0-cfc2b30ce988@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 24 Jul 2026 13:03:10 +0100
Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:

> This is the third series of three on updating the AD5686 driver.
> 
> Initially, a big patch series was sent:
> https://lore.kernel.org/r/20260422-ad5313r-iio-support-v1-0-ed7dca001d1b@analog.com
> 
> Then, the first patch series added fixes and cleanups:
> https://lore.kernel.org/all/20260524-ad5686-fixes-v7-0-b6bf395d08bd@analog.com/
> 
> The second series introduced new features:
> https://lore.kernel.org/all/20260716-ad5686-new-features-v8-0-ebb0051af5e5@analog.com/
> 
> This series adds support for:
> - SPI: AD5313R, AD5317R, AD5674, AD5679, AD5687, AD5687R, AD5689, AD5689R;
> - I2C: AD5316R, AD5675, AD5697R
> 
> Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
> ---
Nice set.  Applied to the testing branch of iio.git

Thanks,

Jonathan

> Changes in v2:
> - Missing devices in I2C drivers as cleanup patches.
> - Refactor of Kconfig device list as a cleanup patch.
> - Link to v1: https://lore.kernel.org/r/20260719-ad5686-extend-dev-support-v1-0-841ec75cf5d8@analog.com
> 
> ---
> Rodrigo Alencar (6):
>       dt-bindings: iio: dac: ad5696: add AD5673R/AD5677R support
>       iio: dac: ad5696: add AD5673R/AD5677R entries to of_match table
>       iio: dac: ad5686: refactor device list and file header comments
>       dt-bindings: iio: dac: ad5696: extend device support
>       dt-bindings: iio: dac: ad5686: extend device support
>       iio: dac: ad5686: extend device support with new parts
> 
>  .../devicetree/bindings/iio/dac/adi,ad5686.yaml    | 14 +++++-
>  .../devicetree/bindings/iio/dac/adi,ad5696.yaml    |  6 +++
>  drivers/iio/dac/Kconfig                            | 31 +++++++++---
>  drivers/iio/dac/ad5686-spi.c                       | 21 ++++++--
>  drivers/iio/dac/ad5686.c                           | 57 +++++++++++++++++++++-
>  drivers/iio/dac/ad5686.h                           |  7 +++
>  drivers/iio/dac/ad5696-i2c.c                       | 12 +++--
>  7 files changed, 132 insertions(+), 16 deletions(-)
> ---
> base-commit: 1258e8ca13866b1a60895abf0ab8a4dd77bf4bfd
> change-id: 20260719-ad5686-extend-dev-support-e0ddd119f19c
> 
> Best regards,

