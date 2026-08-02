Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6AF228686;
	Sun,  2 Aug 2026 01:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785635055; cv=none; b=h+lE9eeRXReaZghhjbni87FA7lNSl21ERIZ8ASo2/hzWOLpicXr3uOqOBWnQaE3T5psE9rBmz5KMPJK6pFi4Be9CmndjP5pu+BdjZFPbzNCd2KanEsKGQguPpK6GbjRbs9hgGdEdM0Q0US/nkqNHPto4bIV7JIyVOKuH43BpJ1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785635055; c=relaxed/simple;
	bh=mdhh0j9f17YHsryDwKXiPEIWcHX7edR8lIqDa7uzH+I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oHUTQRPkSkoeaKjCiyZ/9sfv9qQKYyBVa59bbsHlgH52veYesDmqYxuxPS1VgnY6GR23/QjzWofw14XibeOehaWTbCjGWuDtJ4PFokqrztHjzlTCXDF/3bEwWvA9HjeJgd2D+SjcdauP8BpgTdIE/nGQaYYDCgSojAisN5M29bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FNpuRjyu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FNpuRjyu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 877B61F00AC4;
	Sun,  2 Aug 2026 01:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785635053;
	bh=mip0B/D0zbj+W8FY7Jr7m6LXBd0pDGkSWk8A82QP8So=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=FNpuRjyu1lAoIwK7i3W5Gl+YC7h8SCc/CK5xvSzpaVpFjqOnJGL3qbrRaM/i+d92U
	 BiAgyoBgPe/alFI2vQUBzWBRREVfo1Bka2usHt7UOj906ZYwqzU+cMoDgHumXeqViV
	 DPZE90VCDuWEJhu1OTz/vh6dXKB8yfY1um1cua2TaTAMfuL9ztlZPKQ8iAtmErXtYl
	 rtLzrZoTceuDirdfFQ/JaTD3ZWQto0nefBxgDiE9smn2YMTMkHey0JS8jiqqScYdP/
	 S5mNsqzHnH2swIY65W1UuBAhWF7Bxb2/GKKkvQBsmQbInWasbeC5teqqfPBTmx4Yii
	 8YXABlF9yXi2Q==
Date: Sun, 2 Aug 2026 02:44:06 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Michael Hennerich
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>, "Shuah
 Khan" <skhan@linuxfoundation.org>, Radu Sabau <radu.sabau@analog.com>,
 "Marcelo Schmitt" <marcelo.schmitt@analog.com>, Jorge Marques
 <jorge.marques@analog.com>, Salih Erim <salih.erim@amd.com>, Matti
 Vaittinen <mazziesaccount@gmail.com>, Jishnu Prakash
 <jishnu.prakash@oss.qualcomm.com>, <linux-iio@vger.kernel.org>,
 <linux@analog.com>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v2 0/4] iio: adc: ade9000: add support for ADE9078
Message-ID: <20260802024406.6147807e@jic23-huawei>
In-Reply-To: <20260731082951.1228-1-antoniu.miclaus@analog.com>
References: <20260731082951.1228-1-antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 31 Jul 2026 11:29:46 +0300
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> The ADE9078 is a polyphase energy metering device from the same family as
> the ADE9000 and is register compatible with it. The main differences
> relevant to the driver are the absence of the on-chip dip/swell detection,
> a lower maximum SPI clock (10 MHz), and slightly different full-scale ADC
> codes.

This looks fine to me, but will need to sit on list until the dt maintainers
have gotten to it.  Sashiko did call out some possible preexisting issues
in the driver.  I haven't looked at them, but if you have some time, it may
be worth a look the power vs interrupt registration one smells plausible.

https://sashiko.dev/#/patchset/20260731082951.1228-1-antoniu.miclaus%40analog.com
> 
> This series adds support for the ADE9078 to the existing ade9000 driver.
> It first refactors the driver to move the part-specific values (device
> name, channel table, and full-scale codes) into a chip_info structure
> retrieved via device match data, then adds the new device tree compatible
> and the ADE9078 support itself, and finally updates the documentation.
> 
> Changes in v2:
> - move the "respective datasheets" comment wording to avoid churn.
> - use a generic Kconfig title and list the supported parts.
> - duplicate the RMS voltage macro instead of a shared base macro.
> 
> v1: https://lore.kernel.org/linux-iio/<FILL-IN-v1-MESSAGE-ID>/
> 
> Antoniu Miclaus (4):
>   iio: adc: ade9000: introduce chip_info structure
>   dt-bindings: iio: adc: adi,ade9000: add adi,ade9078 compatible
>   iio: adc: ade9000: add support for ADE9078
>   docs: iio: ade9000: document ADE9078 support
> 
>  .../bindings/iio/adc/adi,ade9000.yaml         |  30 ++-
>  Documentation/iio/ade9000.rst                 |  28 +--
>  drivers/iio/adc/Kconfig                       |  16 +-
>  drivers/iio/adc/ade9000.c                     | 180 ++++++++++++------
>  4 files changed, 175 insertions(+), 79 deletions(-)
> 
> 
> base-commit: 0b5e142ced4bcf20532da051934bd694d1bbd470

