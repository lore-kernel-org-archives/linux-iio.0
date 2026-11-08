Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794099379;
	b=KbO+gL8iICCDYTcDlTkqS3cNAH66XiTYn+z6O8E5OirF7fm6STIj6RF9ehdo9cvgDQXE
	 Wygl2LQ+p9+sl46RHGbFo72Nayjfq67pmnVcfgTVUZ67SxfstBHixN3K5nT+XAJJI24NU
	 cV4/zPcjeLF0qu4USo0FksmOsxw5WnhMq/WIJgVbkSWIGBulNvbGS0iGRWCAjrYpUi4ac
	 UNJGrkIIdzOtiIlCn22lHEmt5qqb/b2o+36T7P6kX4meEu1xZg6+pgMLQuXEehET9uRVY
	 jltCZAbusZ0p1DKeHsEJQdatWXMPdTNCQgs0LRBoHH0rj9Ixm8vC+Ov9AiqRK9XT7Aw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794099379;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=SI3q7E7jEhFxFVdYMt07AMqwaHWirFgexnffniyxwmY=;
	b=o9tS6s/GUJ1hBVK3nx+g+NGj+NYWiXhDkOhIoAy5haWy0X0lyBN7AC7RdTA6kzTaA8MX
	 HYhLIbFlPcHSttY4S+JVervDxdbBL1RJoLGIPn2OH5x1RCYmzXc2WOic23u/1nQUNyIIH
	 zwEmb+MturhqiYBePiIe9vXOwBm3kTEBE81JwLITEh1hnl9i4AalSasnlKOlLwbnEwwct
	 q8ghirUOmkwbApOeCSsaDvcRd5JWJXdKt9mjFFWrgbxRakGSJpT22nB1zqfwmDtoQ2Nm+
	 cmsUUFHwRnjV+RSMlJqPWAE7/Ugc3AvBWmAU7aRIwoXWEn6mVMUPrcZC08rYKNK/QGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lPd+u5qx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 923A4606A326;
	Sun,  8 Nov 2026 00:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lPd+u5qx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C87501F0089F;
	Sun,  8 Nov 2026 00:56:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794099379;
	bh=SI3q7E7jEhFxFVdYMt07AMqwaHWirFgexnffniyxwmY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=lPd+u5qx+8E92fTTLeeKEH4arVT5m7zeLeSvu8ww8+oHMO2yVJOn2lrVHHLjQMonE
	 dyXAuoUyacT9Z2U+WPfg/UgZOvmrDKFtJOq4IwzKbNe5blvfz6SayumyBrVs4DrD8+
	 CNQuahZJk/50xaFrwmxJECXxR6eLcD8L8vk7o3XJDLnUgEtzPjJYHclKGo9VYmDRvx
	 RVvenCVGDTHBLnAGroo3qXrkyupw7i+7xjDNvFJYWV5z49IQGYSplo6mZ7cwK82eMd
	 xGcrx3W1ldxnzDGUMZUy4pdwq83JWy7wHEffEwi8XG60q1oDKP313uTMNelnv2NurL
	 iEp1jKoQ2YSig==
Date: Sun, 8 Nov 2026 00:56:09 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Radu Sabau via B4 Relay <devnull+radu.sabau.analog.com@kernel.org>
Cc: radu.sabau@analog.com, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Nuno Sa <nuno.sa@analog.com>,
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>,
 Alexandru Ardelean <alexandru.ardelean@analog.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux@analog.com
Subject: Re: [PATCH v5 7/8] iio: imu: adis16607: Add external clock sync
 support
Message-ID: <20261108005609.7e8823f1@jic23-hlaptop>
In-Reply-To: <20261102-adis16607-v5-7-4f98b0d271ac@analog.com>
References: <20261102-adis16607-v5-0-4f98b0d271ac@analog.com>
	<20261102-adis16607-v5-7-4f98b0d271ac@analog.com>
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

On Mon, 02 Nov 2026 11:25:43 +0200
Radu Sabau via B4 Relay <devnull+radu.sabau.analog.com@kernel.org> wrote:

> From: Radu Sabau <radu.sabau@analog.com>
> 
> Add support for an optional external clock (clocks property),
> selecting between SYNC_DIRECT (1 kHz to 8 kHz) and SYNC_SCALED (1 Hz
> to 400 Hz) depending on the supplied frequency, with the internal
> 8 kHz clock used as the default when no clock is provided.
> 
> The clock rate is requested as exclusive since the sample period and
> the sync scale are derived from it. In scaled mode the sync scale is
> chosen when the sampling frequency is set, so that the requested rate
> is matched as closely as possible while keeping the clock multiplied
> at or below the internal rate. Loss of sync or of the PLL lock is
> reported from the trigger handler, as the device keeps sampling
> without it.
> 
> Signed-off-by: Radu Sabau <radu.sabau@analog.com>
Hi,

Mostly a few stray changes that belong in earlier patches.

Make sure to check series for this stuff. It is easy to clean up
and patch tidiness issues like this can just slow down getting
your code merged.

Jonathan

>  
>  struct adis16607 {
> @@ -115,6 +138,9 @@ struct adis16607 {
>  	const struct adis16607_chip_info *info;
>  	unsigned long clk_freq_mHz;
>  	u64 sample_period_ns;
> +	unsigned long ext_clk_Hz;
> +	u32 sync_mode;
> +	u16 sync_scale;
>  	u16 fifo_watermark;
>  	/* IIO buffer for reordered data - sized for max channels */
>  	IIO_DECLARE_BUFFER_WITH_TS(u8, data, ADIS16607_SCAN_DATA_SIZE);
> @@ -407,11 +433,18 @@ static void adis16607_fifo_drain(struct iio_dev *indio_dev, s64 irq_timestamp)
>  
>  	adis_dev_auto_lock(&st->adis);
>  
> -	/* Check if FIFO threshold is met */

Move the comment in the earlier patch, not here. It is perfect
valid in its new location back in that patch, so why add to
the code churn here?

>  	ret = __adis_read_reg_16(&st->adis, ADIS16607_REG_DIAG_STAT, &diag_stat);
>  	if (ret)
>  		return;
>  
> +	/* The device keeps sampling without sync, so only warn about it */
> +	if (diag_stat & ADIS16607_DIAG_SYNC_LOST)
> +		dev_warn_ratelimited(&st->adis.spi->dev, "external sync lost\n");
> +
> +	if (diag_stat & ADIS16607_DIAG_DPLL_UNLOCKED)
> +		dev_warn_ratelimited(&st->adis.spi->dev, "sync PLL unlocked\n");
> +
> +	/* Check if FIFO threshold is met */
>  	if (!(diag_stat & ADIS16607_FIFO_THR_MET_MASK))
>  		return;

>  static int adis16607_config_clk(struct adis16607 *st)
>  {

> +	ret = adis_read_reg_16(&st->adis, ADIS16607_REG_DEC_RATE, &dec);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * Sample period is (dec + 1) / clk_freq, with clk_freq_mHz in
> +	 * millihertz. Same u64-first scheme as adis16607_set_freq().
> +	 */
> +	period_ns = NSEC_PER_SEC;

Move this in earlier patch to avoid churn here.

>  	period_ns *= MILLIHZ_PER_HZ;
> +	period_ns *= dec + 1;
>  	st->sample_period_ns = DIV_ROUND_CLOSEST_ULL(period_ns,
>  						     st->clk_freq_mHz);
> +

Unrelated change. Check for these and move to the correct patch.

>  	return 0;
>  }
>  
> 

