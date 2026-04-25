Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA50137CD35;
	Sat, 25 Apr 2026 18:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777142663; cv=none; b=ja7jEfb7xNgG7ZI//aFGOKADEnxCktmimNjizBbdX02A8XiviMbCRaShkp2G7ZeaWQeK6agsm/COLrvdNUhDdxPaVAJ93E6Dox8JNgkTpdGSAaKx00G7GrEYccAdNjlBHFfctzFODCvH5rsfqoBOd5f4Fue9kRibsOz5YdOeOLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777142663; c=relaxed/simple;
	bh=hn1z0b4zV4WFbjbMYJCntmVWjUXd67V4CvRoUKBAu0E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZRfdorW4kLR9WydgoFLSF6kvmYH2KW5GauyGHOzNr/cDSgmtsR4xu2E6CCEr+0xYrV8ZyCY3dGXhHjVx9mg1lNt1Xtciy8NkAbwV9w7KVNMGLNpLYKZ3acuZqL0NWFG49Fu1NWuReheSUNPtJYkMCbjAANamiEN3IhDTzBAL4aQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tJQo1X9q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tJQo1X9q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BE0DC2BCB0;
	Sat, 25 Apr 2026 18:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777142663;
	bh=hn1z0b4zV4WFbjbMYJCntmVWjUXd67V4CvRoUKBAu0E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tJQo1X9qgCqTDOi7MqNayuOZ9xsm5pwykysVI8u9GxrhhKgvaoTyKRG4mDnTWynaI
	 VXAJN4KYYtQxQwxoBTrvmCCQNf7mCreJ4e9IufGej2Ny3P+oLoc2rwxa5LirQvpwHK
	 htQfPPy6cuqnMygg/gDzEHE5fNzFPO7ZKdgeYPaFCdSIjoD8lughcd0uZNLKbw1vWn
	 s+9jlG4xocgsoRlEdcnf00kj9MyH+Yy3m/VMHLj3kdGYpM8qJ5rvyqsZja7dIEybW9
	 J+0RChqDl/GbDqYQF/F7pb4X5kw0Sv8lvBCacWlf+cxo8/IS2YAtZ7OFhO+freqBS1
	 kZV/4tSoj3F5Q==
Date: Sat, 25 Apr 2026 19:44:12 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Felix Gu <ustc.gu@gmail.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Neil Armstrong
 <neil.armstrong@linaro.org>, Kevin Hilman <khilman@baylibre.com>, Jerome
 Brunet <jbrunet@baylibre.com>, Martin Blumenstingl
 <martin.blumenstingl@googlemail.com>, Rosen Penev <rosenp@gmail.com>,
 linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: meson-saradc: fix calibration buffer leak on
 error
Message-ID: <20260425194412.1872eff8@jic23-huawei>
In-Reply-To: <84cae83c-2d67-4927-aa40-6c416d4f862d@baylibre.com>
References: <20260426-meson_saradc-v1-1-6e96b2982c43@gmail.com>
	<84cae83c-2d67-4927-aa40-6c416d4f862d@baylibre.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 25 Apr 2026 11:17:18 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 4/25/26 11:07 AM, Felix Gu wrote:
> > meson_sar_adc_temp_sensor_init() allocates a buffer with
> > nvmem_cell_read(), but the old code leaked it if
> > syscon_regmap_lookup_by_phandle() failed.
> > 
> > Switch buf to __free(kfree) so all return paths release it.
> > 
> > Fixes: d6f2eac64403 ("iio: adc: meson: no devm for nvmem_cell_get")
> > Signed-off-by: Felix Gu <ustc.gu@gmail.com>
> > ---
> >  drivers/iio/adc/meson_saradc.c | 10 +++-------
> >  1 file changed, 3 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/iio/adc/meson_saradc.c b/drivers/iio/adc/meson_saradc.c
> > index 23991a3612bd..9708ddcc4919 100644
> > --- a/drivers/iio/adc/meson_saradc.c
> > +++ b/drivers/iio/adc/meson_saradc.c
> > @@ -786,7 +786,7 @@ static int meson_sar_adc_clk_init(struct iio_dev *indio_dev,
> >  static int meson_sar_adc_temp_sensor_init(struct iio_dev *indio_dev)
> >  {  
> 
> Nice to see one of these cleanup.h patches that is actually fixing a bug.

It's not fixing anything as far as I can see.
The syscon_regmap_lookup_by_handle() is earlier in the function and
nvmem_cell_read() isn't called if that fails.

So this is just a code simplification and so small benefit if anything.

Maybe there is an old version that does things in a different order?


> 
> Should `#include <linux/cleanup.h>` though rather that relying on it being
> included through another header.
> 
> With that fixed...
> 
> Reviewed-by: David Lechner <dlechner@baylibre.com>
> 

