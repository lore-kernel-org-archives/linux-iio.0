Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF4622FF22;
	Wed,  5 Aug 2026 00:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785891513; cv=none; b=ehtEd6nrZAQmIBZV9syWwBxIQZUygROEtExlR/Iz73qHNF0Aly/CEjcGbFHcVHUez9JMnHUOsVcgHHH0xHNajTARj5jD3mX6m/plWbaoE6Odr1Cq2elHVHmVmcEQ+75Gl138mqQ6agRqgD9Q9N2rmbhMX/IB9Y5J8pefsUhsX1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785891513; c=relaxed/simple;
	bh=hWyChJABBkhTlUa6artjGpM1ETJdzYr2MzRGS+SrzHI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GFVUjJGCih6JzNrVWwVrrQUGOraJs/O5YULxyJXPDtmvEnqY4L+vnPiW+BwnhFi6VewWVFCIBd9Ee2Pi+qYwcC/A1lojiL4ENFCCetpCF8SRk3gGD60K3tRQzazOEwl7FYunjRp2vDwA93tAZ4ewehV0Es/zViVYp5jq9ZTH89Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L4sjZVTt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L4sjZVTt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49A131F000E9;
	Wed,  5 Aug 2026 00:58:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785891511;
	bh=Vjdmnus1IzbejsucN4Zyptuq987Jx0hfcGjeuV+7TL8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=L4sjZVTtSJB6ZrkVrcxvs2XYs3cR1wGImRz65Nfr+8H9xyk1cNHo3grV9ti2R0S8i
	 vKzXTilv92WTjja8dWhMSSGe48/ZHG/bpQd2LYSBrsdE6RnDwhYrO6EgtERSVU22j4
	 Y7C3yO3n7xvqCtGBoFsdetdH4Yf2T7hnHWVqRLQxcy3bqLzfttQZDK55vVf/Hw2OiS
	 3uL1VQTV/s9nw+fT8fI/RHDxHPRjDyIrIEYSD8JAezqjCtZavZCXnmL1RkLCqVTrq1
	 6eW8dO0DyNbitlKdg6UxzvdetvmTtD//wuaM+bDmdk5IiwjCHQmCfJmqZcKIMrNmws
	 zTaSXHCMsg/rg==
Date: Wed, 5 Aug 2026 01:58:26 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Marco Chen <marcochen.dev@gmail.com>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 pmeerw@pmeerw.net, matt@ranostay.sg, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
 linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH v2] iio: health: max30102: fix NULL dereference in
 interrupt handler
Message-ID: <20260805015826.2b558119@jic23-huawei>
In-Reply-To: <20260804234355.65319-1-marcochen.dev@gmail.com>
References: <20260804234355.65319-1-marcochen.dev@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  4 Aug 2026 19:43:55 -0400
Marco Chen <marcochen.dev@gmail.com> wrote:

> The interrupt is requested in max30102_probe() and stays enabled
> for the lifetime of the device, but indio_dev->active_scan_mask is only
> valid while a buffer is enabled. When an interrupt arrives while no
> buffer is enabled, the handler dereferences the NULL active_scan_mask:
> 
>   Unable to handle kernel NULL pointer dereference at virtual address
> 0000000000000000
>   pc : __bitmap_weight+0x64/0x98
>   lr : max30102_interrupt_handler+0x48/0x160 [max30102]
>   Call trace:
>    __bitmap_weight+0x64/0x98 (P)
>    max30102_interrupt_handler+0x48/0x160 [max30102]
>    irq_thread_fn+0x28/0xa8
>    irq_thread+0x184/0x30c
>    kthread+0x118/0x124
>    ret_from_fork+0x10/0x20
> 
> Read the interrupt status register at the top of the handler. If
> FIFO_RDY is not set, return early because it isn't our interrupt.
> Because FIFO_RDY is the only interrupt source enabled by this driver in
> max30102_chip_init(), an invocation of max30102_interrupt_handler()
> without FIFO_RDY set carries no data to read and can return early before
> ever accessing active_scan_mask. This status read also deasserts the
> MAX30102's active-low interrupt pin.
> 
> Since the interrupt status register is now read at the top of the
> handler, pass the status value into max30102_fifo_count() instead of
> having it read the register a second time.
> 
> Fixes: 90579b69e94b ("iio: health: max30102: Add MAX30105 support")
> Signed-off-by: Marco Chen <marcochen.dev@gmail.com>
> ---
> Changes in v2:
> - Check FIFO_RDY bit in the interrupt status register instead of 
>   active_scan_mask, because that was racy in v1, as pointed out by 
>   Jonathan and David.
> - Read interrupt status once and pass it into max30102_fifo_count().
> - Check the regmap_read() return value and log on failure.
> 
> Tested with a MAX30102 on a Raspberry Pi 4 over I2C.
> v1: https://lore.kernel.org/linux-iio/20260731184124.112124-1-marcochen.dev@gmail.com/
> 
>  drivers/iio/health/max30102.c | 37 +++++++++++++++++++++++------------
>  1 file changed, 25 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/iio/health/max30102.c b/drivers/iio/health/max30102.c
> index c37316c86f14..b949ce36c248 100644
> --- a/drivers/iio/health/max30102.c
> +++ b/drivers/iio/health/max30102.c
> @@ -235,17 +235,10 @@ static const struct iio_buffer_setup_ops max30102_buffer_setup_ops = {
>  	.predisable = max30102_buffer_predisable,
>  };
>  
> -static inline int max30102_fifo_count(struct max30102_data *data)
> +static inline int max30102_fifo_count(unsigned int status)

Not as such related to this patch, but would be nice if this
was renamed to something that reflected it doesn't really provide
any form of counting and only returns 0 or 1.
Would be nicer as a bool.


>  {
> -	unsigned int val;
> -	int ret;
> -
> -	ret = regmap_read(data->regmap, MAX30102_REG_INT_STATUS, &val);
> -	if (ret)
> -		return ret;
> -
>  	/* FIFO has one sample slot left */
> -	if (val & MAX30102_REG_INT_STATUS_FIFO_RDY)
> +	if (status & MAX30102_REG_INT_STATUS_FIFO_RDY)
>  		return 1;
>  
>  	return 0;
> @@ -290,19 +283,39 @@ static irqreturn_t max30102_interrupt_handler(int irq, void *private)
>  {
>  	struct iio_dev *indio_dev = private;
>  	struct max30102_data *data = iio_priv(indio_dev);
> -	unsigned int measurements = bitmap_weight(indio_dev->active_scan_mask,
> -						  iio_get_masklength(indio_dev));
> +	unsigned int measurements, status;
>  	int ret, cnt = 0;
>  
> +	ret = regmap_read(data->regmap, MAX30102_REG_INT_STATUS, &status);
> +	if (ret) {
> +		dev_err_ratelimited(&data->client->dev,
> +				    "Failed to read IRQ status: %d\n", ret);
> +		return IRQ_HANDLED;
> +	}
> +	if (!(status & MAX30102_REG_INT_STATUS_FIFO_RDY))
> +		return IRQ_HANDLED;

This chunk above is replicating the oddly named max30102_fifo_count() more
or less. I'd leave that functon as it stood before and do

	cnt = max30102_fifo_count();
	if (cnt == 0)
		return IRQ_HANDLED;

	measurements = bitmap_weight(indio_dev->active_scan_mask,
				     iio_get_masklength(indio_dev));

	mutex_lock()
	while (cnt || (cnt = max30102_fifo_count(data)) > 0) {

as the second part of that won't be evaluated on first entry as
we know cnt is set.

> +
> +	measurements = bitmap_weight(indio_dev->active_scan_mask,
> +				     iio_get_masklength(indio_dev));
> +
>  	mutex_lock(&data->lock);
>  
> -	while (cnt || (cnt = max30102_fifo_count(data)) > 0) {
> +	while (cnt || (cnt = max30102_fifo_count(status)) > 0) {
>  		ret = max30102_read_measurement(data, measurements);
>  		if (ret)
>  			break;
>  
>  		iio_push_to_buffers(data->indio_dev, data->processed_buffer);
>  		cnt--;
> +
> +		ret = regmap_read(data->regmap, MAX30102_REG_INT_STATUS,
> +				  &status);
> +		if (ret) {
> +			dev_err_ratelimited(&data->client->dev,
> +					    "Failed to read IRQ status: %d\n",
> +					    ret);
> +			break;
> +		}
With the above, I don't think this part is needed.

Jonathan

>  	}
>  
>  	mutex_unlock(&data->lock);

