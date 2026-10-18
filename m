Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048FD13D8BD;
	Sun, 18 Oct 2026 22:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792362861; cv=none; b=SZ6fne3nkOXR6dIPpEO8ic4eV3lG1V9JemdEWvMvTvH4qeNbmOY1XYC4jSuA3K6torcCIGbt9+6EY/sVlkgrcW54Tqj32TgMh/2O82tBVy34pcFpTXQOwSzAQQsA/J6ow65opG8PpbVkttFIrUWgc6X/7niOFi/dC5zGvPjPKys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792362861; c=relaxed/simple;
	bh=sROvDVJ/5HdmqI6LCh2k/R7gJlvfB5jNMuOgipMHrPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wa9175yJfFVXvUAcZTUkRQ6fX3fvPpHSUwizP09C1pKTSk7bFrmSCcv8CeZVL7+e5W4hVSo4MXazDs4MYbrBs/Yc2ndMO7d2Vw9aRcPSxq9AVhy6kGHNWrunU4HTqD9/GJKWWADA15Dpi6MuDTyiLTsm1VlX+7M9jGgGQ73xWmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bpnwcdIJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bpnwcdIJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75F2F1F000C4;
	Sun, 18 Oct 2026 22:34:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792362860;
	bh=wNMvtaeNogKpfQrytqvvbaLOlr19nHijax0++efnMV8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=bpnwcdIJ4V3mbTDUCzSl1a2GjmcOe1wrdAU1d93mIPpvkGAQjEv1GEqAMxzFQIn2I
	 5QlCDwfrjMBpbYiDoPZUgm9jlNtzpQzkg9Ffp0FD+6lPiH+nxqI2UJ+aaBzRwSqKe+
	 gXh39Tg//hWWa4FZ75ytZQil0gkNp8IK2GsHykYfuHtwSB6VvB35yf1i73u3aioEwN
	 hpQYDyq45CNQ8uVpq/tj0CzSl+S0Wk4W/2onh57udOmQExBCPXzTROv3AES/jNIuP2
	 EkTyw6yyQi7DLjXP1V2rkSTrVTmq3kl/A0mPJi0smuoUi8Vi+n9e0U77+D4Zrtp5px
	 PvNfJPaJ0rdfw==
Date: Sun, 18 Oct 2026 23:34:11 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, "Andy Shevchenko" <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, "Maxime Coquelin" <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, Joshua Crofts
 <joshua.crofts1@gmail.com>, Marek Vasut <marex@nabladev.com>,
 <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-stm32@st-md-mailman.stormreply.com>,
 <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 Conor Dooley <conor.dooley@microchip.com>, Cheick Traore
 <cheick.traore-ext@st.com>, Olivier Moysan <olivier.moysan@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Cheick Traore
 <cheick.traore@foss.st.com>
Subject: Re: [PATCH v4 00/15] iio: adc: stm32: add support for stm32mp23 and
 stm32mp25
Message-ID: <20261018233411.31d4e6a0@jic23-hlaptop>
In-Reply-To: <20261006-adc-stm32mp25-v1-v4-0-d31ec75aecf3@foss.st.com>
References: <20261006-adc-stm32mp25-v1-v4-0-d31ec75aecf3@foss.st.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 6 Oct 2026 09:57:31 +0200
Fabrice Gasnier <fabrice.gasnier@foss.st.com> wrote:

> Add support for STM32MP23 and STM32MP25 Analog to Digital Converter.
> It's a variant of other supported STM32MP ADCs. Add the DT bindings,
> driver, SOC DTS and an example on stm32mp257f-ev1 board.
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Applied patches 1-10 to the testing branch of iio.git.

Thanks,

Jonathan
