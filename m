Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792981063;
	b=wZFX70ENGe5IWPY10EJRAnyTeRnqaDLo1Q2c0toOyiLC2NQSbtKiU8MusO6riUmo2SzT
	 1xHhZkQ/i4nMuXIEND3UYb3Hn8IeAbWbCyBZXRp7JsHPQG/1XTPC2RQhCZis3ZUIhqelO
	 rs6jPUpt/Y1sLAGJWVImxSv8t0bycxfXB+x3djF8rmwGxyZAJkvKJaJRqPZMgnanZwJAp
	 Q/dcXcbpJqbTr8OJOfdhakImzwoVvadQnXxvktwkuMPFMgSc40CLhHvcDhzmEIQi/0kpD
	 Y1kLlwODbd3hGrCj7TIn2lEK7gi84OJj6KBdVc45Q34zhXS4eSXYu6PR5zJDF2sBVzw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792981063;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=sj5VDmHeARycPVKAa2+uY840rbMDIPKBRKKT53IOukY=;
	b=cmVSptSow/RtsB7D8B5hF4A5C7hz0bSLtWRCI3Llpsw0kKKU4G4aWXBrmO4D9xEO4Xxo
	 PvU8WMEdQ4mOmSJgKZjbgy+Wepf+LaoERoobeMTBT8HNBtr9txkwKhVnSeoiRM+c4lMSq
	 c9YXMmeUVs4n0xSdLeplkUVX59cxpMp3VvAfSzVP2lmeZgpcWBV+HvX4aiyLPWhymZUwb
	 Cu+rqClX/a6gprPSvLtVlmNzoqvRz5rYKaZ/fNLziqq+amg57o/JTEy+QwC2HsLAyUBnZ
	 y1gEWVLYRw3lJ0HwOTD1AxaVv08zJHklykw3qgA4edfq2rQVPcxckRyB6W5/+JZF5xA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mkXApCO7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51D4A606A31A;
	Mon, 26 Oct 2026 02:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mkXApCO7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A93711F01825;
	Mon, 26 Oct 2026 02:17:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792981062;
	bh=sj5VDmHeARycPVKAa2+uY840rbMDIPKBRKKT53IOukY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=mkXApCO7UnufkYIsKM9EOU5PzB4B7eU5b1cdoS1PiQxXHWHQ0Fxp7zP2Qr689ioVk
	 RjlbNEhJHnACGURYWbjDjIK6aH1VPyY1s7iiy4AzwpJlQS4hTk3QbG/0LwzwneW3qX
	 n/u35mPzMNAy/ReY193Ub0GVDG1kJBkeMgnJXfmAQdtfVmdyVts53P4EXnv5nni6G6
	 1l6f9dEgO819DUR6hlYOV9dLP1viOUAh59oGzNJWYk+ngagxUASCz5jl51gZAPk0xi
	 5RYesp8Xx9+aqOKdkhpVZn3tfViGZie6ns/J5IFUa/+lVT9XpuYctRguVhKWn4TX6e
	 sGx+seDqa65lA==
Date: Mon, 26 Oct 2026 02:17:32 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Jonathan Santos <Jonathan.Santos@analog.com>
Cc: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
 <linux@analog.com>, <broonie@kernel.org>, <robh@kernel.org>,
 <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
 <Michael.Hennerich@analog.com>, <nuno.sa@analog.com>,
 <dlechner@baylibre.com>, <andriy.shevchenko@intel.com>
Subject: Re: [PATCH v4 6/9] spi: introduce SPI ancillary device with lanes
Message-ID: <20261026021732.31e510da@jic23-hlaptop>
In-Reply-To: <21fb26ff0337f493643167f8c9dfae92d1b3b9a7.1792435248.git.Jonathan.Santos@analog.com>
References: <cover.1792435248.git.Jonathan.Santos@analog.com>
	<21fb26ff0337f493643167f8c9dfae92d1b3b9a7.1792435248.git.Jonathan.Santos@analog.com>
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

On Tue, 20 Oct 2026 22:58:01 -0300
Jonathan Santos <Jonathan.Santos@analog.com> wrote:

> The existing spi_new_ancillary_device() creates an ancillary SPI device
> but does not consider the parent's lane map. In multi-device setups where
> each sub-device's chip-select is bound to a dedicated data lane, there is
> no way to bind an ancillary device to an arbitrary lane index.
> 
> Introduce spi_new_ancillary_device_with_lane() and
> devm_spi_new_ancillary_device_with_lane(), which accept rx_lane_idx and
> tx_lane_idx parameters to select a specific lane from the parent's
> rx_lane_map and tx_lane_map respectively. The resulting ancillary device
> is registered with a single RX and TX lane, keeping it independent from
> the other sub-devices sharing the same controller.

The multiple-data-lanes.rst doc doesn't me make it clear if for the 
lanes are all one wide, or if it is fine to have 2 lanes each
of width 4.  Either way I'd expect more parameters to be needed.
The AD7786 has diagrams of two devices, bus width 2 for each.

> 
> While at it, fix the spi_new_ancillary_device() documentation, which
> claimed it returns 0 on success instead of a pointer.
> 
> Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
> ---
> Changes in v4:
> * Don't use extern for the new declarations of the ancillary functions from
>   spi.h.
> 
> Changes in v3:
> * Refactored code using helper function to reduce duplicated code.
> 
> Changes in v2:
> * New patch.
> ---
>  drivers/spi/spi.c       | 116 +++++++++++++++++++++++++++++++++++-----
>  include/linux/spi/spi.h |   8 +++
>  2 files changed, 110 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> index 53d6ab4ce8a3..30103bffad33 100644
> --- a/drivers/spi/spi.c
> +++ b/drivers/spi/spi.c
> @@ -2918,20 +2918,12 @@ static void of_register_spi_devices(struct spi_controller *ctlr)
>  static void of_register_spi_devices(struct spi_controller *ctlr) { }
>  #endif
>  
> -/**
> - * spi_new_ancillary_device() - Register ancillary SPI device
> - * @spi:         Pointer to the main SPI device registering the ancillary device
> - * @chip_select: Chip Select of the ancillary device
> - *
> - * Register an ancillary SPI device; for example some chips have a chip-select
> - * for normal device usage and another one for setup/firmware upload.
> - *
> - * This may only be called from main SPI device's probe routine.
> - *
> - * Return: 0 on success; negative errno on failure
> - */
> -struct spi_device *spi_new_ancillary_device(struct spi_device *spi,
> -					     u8 chip_select)
> +#define SPI_UNDEFINED_LANE	-1
> +
> +static struct spi_device *__spi_new_ancillary_device(struct spi_device *spi,
> +						     u8 chip_select,
> +						     int rx_lane_idx,
> +						     int tx_lane_idx)
>  {
>  	struct spi_controller *ctlr = spi->controller;
>  	struct spi_device *ancillary;
> @@ -2958,6 +2950,21 @@ struct spi_device *spi_new_ancillary_device(struct spi_device *spi,
>  	 */
>  	ancillary->cs_index_mask = BIT(0);
>  
> +	if (rx_lane_idx >= spi->num_rx_lanes || tx_lane_idx >= spi->num_tx_lanes) {
> +		rc = -EINVAL;
> +		goto err_out;
> +	}
> +
> +	if (rx_lane_idx != SPI_UNDEFINED_LANE) {
> +		ancillary->rx_lane_map[0] = spi->rx_lane_map[rx_lane_idx];
> +		ancillary->num_rx_lanes = 1;
> +	}
> +
> +	if (tx_lane_idx != SPI_UNDEFINED_LANE) {
> +		ancillary->tx_lane_map[0] = spi->tx_lane_map[tx_lane_idx];
> +		ancillary->num_tx_lanes = 1;
> +	}
> +
>  	WARN_ON(!mutex_is_locked(&ctlr->add_lock));
>  
>  	/* Register the new device, passing the parent to skip CS conflict check */

