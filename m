Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7FAF1D4606;
	Mon, 21 Sep 2026 01:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789955467; cv=none; b=iVJMnn4Fq3H/9YIjyt19xq7d8ljtaAI8UgX9yVMbV2R3BIZrD4NI00Ve9pX6lgdvdv+dAfKzLUD+uxFtTdAMoKJzsK+RucFgx68EeTHfuR2JPsvt1UR1/RhSltmXkBfbBQDzau6YLxupBOTeu+ScOVsdgDa/rs6T5omhQUPgFl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789955467; c=relaxed/simple;
	bh=alFjdedo6BI8fFm9aUO6g5778zUTplko+KyOa/SJkb8=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=V7s4rMROY13LgdnNqxpcwcv63GkkE1SOuB+4+ahO6qXD4pNdtem8eV2JgdEgrq5HTkYf56afkNSUDcyO4fHQDrLSLBCYD3AqflXLWAmCNUP1CWhURgqJ5bW+MeIZtKMRyBArMm7jqugW5OyCVu4cmQzDkxrsJsK9koHeaV7lu3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B3niNh+y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B3niNh+y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 933361F00898;
	Mon, 21 Sep 2026 01:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789955465;
	bh=L95vhrbWo2vNkQXF9t3WIlJl9leIde7M4gWt6WR53L4=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=B3niNh+y++y9vTEDcbIvjIWBrUmGkDzfNYqY473/xnDTq0TfPntZSS6lFa/qCBhla
	 8f8jkDh19GvoQRJFkp/Kb24DUUu4vu96h3wpeqdgWRikKekbWEJTBL1wP3PieQv7wp
	 IVl45NZ+uLA9GH66UomPNqeUen4WQqhMpoM0ZmL9yP6YlJj89PII6IgOGI1f+NFXGU
	 63IXwmEr5aEvyIEWIlQxxQ+IgTkpnoqvUdTZwc7HdGr6e5pnIpnR+RNfTdxLrFTWcQ
	 M6iZbsl6LaVNZKgQ0VXup83Sjh6dc5s/cWpiU9PM9g1p5sNioTe+Tohh56iKxvmhq+
	 0CEb1k+yjVhjA==
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 11/15] iio: adc: ad4134: Support SPI 4-wire mode
From: Jonathan Cameron <jic23@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux@analog.com, jic23@kernel.org, 
 nuno.sa@analog.com, dlechner@baylibre.com, andy@kernel.org, 
 Michael.Hennerich@analog.com, robh@kernel.org, krzk+dt@kernel.org, 
 conor+dt@kernel.org, corbet@lwn.net, skhan@linuxfoundation.org, 
 marcelo.schmitt1@gmail.com
In-Reply-To: <db5578ed11d5ad9f5abb9569d893065dbf79fb13.1789494473.git.marcelo.schmitt@analog.com>
References: <cover.1789494473.git.marcelo.schmitt@analog.com>
 <db5578ed11d5ad9f5abb9569d893065dbf79fb13.1789494473.git.marcelo.schmitt@analog.com>
Date: Mon, 21 Sep 2026 02:50:45 +0100
Message-Id: <178995544507.955708.8795648344873356535.b4-review@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2607;
 i=jonathan.cameron@oss.qualcomm.com; h=from:subject:message-id;
 bh=alFjdedo6BI8fFm9aUO6g5778zUTplko+KyOa/SJkb8=;
 b=kA0DAAoBVIU0mcT0FogByyZiAGqwjYSgSL9dhjvO50CC69J4LwcUfumJFdvhNObKSHEwv163N
 YkCRQQAAQoALxYhBG4pZrOHhAZSkSaBsVSFNJnE9BaIBQJqsI2EERxqaWMyM0BrZXJuZWwub3Jn
 AAoJEFSFNJnE9BaIVJ0P+wXNPE/v7fUqQ5EgAZeitcyK1+Xeg3fQLUVYijxNyrya/BFOotdZBef
 y9UNr0yOQyts6NwUujRJyUDElyiETNMWet4OAYtsRr7OputsKAy5k06UIF22N5LnrUR1qFTD6RA
 Y8dDDXUj+ikhIim24JrxCfh44uhjAer8Q9nhNxiZrGCQCS3TPWG5GaG+Iwr2mc7oSmVCElROUPw
 rULbmyvCofhoak0WvTAq0Z8XTIyI1/cNr6WZlPTZin03jObVDE4V/WtY0nmQmAcUf5CsMW9aBIj
 YzGohMkK/pMUdAsp0R0X6wD4E0asv4EhlrVBL1MOuWHIxTi2MhALuWvCf+rKtGPs6ND/U48zrcw
 yC/JvPlmT2pyFr9d9g0GEPAhZOmZ0ZiS+AsR1XiFYdCsAfMbCb4w6+KXHoWBpNDGxapmYuf8ODU
 uYDc1EvVKOqT37AGspx5UPNEMYX+MwKoVSwFLslTGbi/CG5l02bDL4doNkcDHKqFI10Z0iKYSBA
 z9PeCI9ZFYqpFNV8aBRrInKHPtht2MCG8JkW4qX3cLzmMQR7q4Fx7wpfw+2kZgVGkRGOL5P9tpx
 MlNoIKnnP1NhgXfXKsuxSmx3fO1yXfRCsNrQQSgwq4lPgExH8YIBYJhAPl5LtTB7Eb+w7GhAq5U
 V7xoA+OSnkONSNTGQKs8TSYkzsQ3j
X-Developer-Key: i=jonathan.cameron@oss.qualcomm.com; a=openpgp;
 fpr=6E2966B387840652912681B154853499C4F41688

> AD4134 devices can be wired in a few different ways. So far, only minimum
> I/O mode was supported. While minimum I/O mode allows interfacing with
> AD4134 with a reduced number of wires, that wiring configuration is not
> optimal for high-throughput data acquisition.
> 
> Extend AD4134 support to enable interfacing in SPI 4-wire configuration.
> 
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
There is a lot of sashiko feedback on this one. Make sure
to take a close look.
https://sashiko.dev/#/patchset/cover.1789494473.git.marcelo.schmitt%40analog.com

>

> diff --git a/drivers/iio/adc/ad4134.c b/drivers/iio/adc/ad4134.c
> index 0b6843bf8a9e..cc6bc325f6ee 100644
> --- a/drivers/iio/adc/ad4134.c

>  enum ad4134_filter_type {
>  	AD4134_WIDEBAND,
>  	AD4134_SINC6,
> @@ -155,6 +171,12 @@ struct ad4134_state {
>  	 * atomicity of consecutive register access operations.
>  	 */
>  	struct mutex lock;
> +	/*
> +	 * Ensure atomicity of access mode switch operations.
> +	 */

One line comment seems like enough.

> +	struct mutex access_mode_lock;
> +	struct mux_state *mux_st[2]; /* For external multiplexer control */
> +	enum ad4134_spi_mode spi_mode;
>  	int refin_mv;
>  	bool crc_en;
>  	/*
> @@ -230,6 +252,85 @@ static const struct regmap_access_table ad4134_regmap_wr_table = {
>  	.n_yes_ranges = ARRAY_SIZE(ad4134_regmap_wr_range),
>  };
>  
> +/*
> + * This function controls a multiplexer OUTSIDE OF AD4134 SILICON.
> + * When AD4134 SDO and DOUT0 pins are multiplexed, this function changes the
> + * multiplexer state to route SDO to the SPI controller. See AD4134 IIO
> + * documentation for details.
> + */
> +static int ad4134_set_register_access(struct ad4134_state *st)
> +{
> +	int ret;
> +
> +	guard(mutex)(&st->access_mode_lock);
> +
> +	st->spi->mode = SPI_MODE_0;

Oh goody we are flipping the spi bus type and that is not
describable in firmware.

> +	ret = spi_setup(st->spi);
> +	if (ret)
> +		return ret;
> +
> +	ret = mux_state_deselect(st->mux_st[AD4134_DOUT0_INPUT]);
> +	if (ret)
> +		dev_err(&st->spi->dev, "error on DOUT0 deselect: %d\n", ret);
> +
> +	/*
> +	 * Try to update the multiplexer state to route SDO to the SPI
> +	 * controller. If the SDO mux state is BUSY (i.e. locked), that means
> +	 * the desired state is already selected and we should not block here.
> +	 */

I'm confused whether this is an expected path or not. Is there
some race after the deselect above? If so call out how that
occurs.

-- 
Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
