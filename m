Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794099151;
	b=zz8QgSiro6FXdx3rlFFOXG0Ir6yBo4E9h1325JrA+BHN9lQk01++pz2T5MtZU8KF0Onv
	 sQHBtVO3Tsr7N+8nw4kfnFMwKWDcIUruhM4Aljv/ZyO+lVVXo0EVsmi2fhfCNxZgAU9eJ
	 gjUew3JWXdT/7+gDS2YDTpQJaUs+8pkhVhzkk75RDdzeKRA/TlRbButhKQSE/Jz7iSwKv
	 zFoirSYU+e2LEhRC69QBazeHGtnz+9v4uXksKQrGyDQ7EoZGsFT4UmNwuHMscGjW0M7oG
	 CktFgfQM+1BOWl4nyi8oMwHwg3b3O+ijfvZF71tgtQEh3fgutQ95tBuqYXq9FpEpqYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794099151;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=maLB02cvNBbVMYlAfoB1uYt8bE13NZpelqMOahax1vM=;
	b=jxY3mb46qA6CYALZX8SApPphhdpO7uUBiOM4XeT/8loLC3k+Hyq6H+wyGjc0Op+h3PqC
	 uWzX10CfEMGqK1oVqKvvEOXgGarcdMDGoaZXQu3SUf00V2D9DsBk5cWfN1lVTnj+Ybool
	 nrarXmBiEmn5Q8wm2TkNUcHdKxAgZlfYPMcyvIhrGUAqM71LRlw9V+fKVIS1R0d3TJEXj
	 83bLmUS30WPeKO2suTR4kish7DFVRqSIisujGDXs4TgNLS9OcBUFYm8KTMMG9RRAZwLpr
	 jZ7SfSoJUkPkR6Su4EjpQXewIq5QavqotdlaCxkFnC60tIz9tKHV2a5ngdlxjpbRe8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CjUf9tif;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A335C606A326;
	Sun,  8 Nov 2026 00:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CjUf9tif
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7A6E1F0089F;
	Sun,  8 Nov 2026 00:52:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794099150;
	bh=maLB02cvNBbVMYlAfoB1uYt8bE13NZpelqMOahax1vM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=CjUf9tifq0mqK9YdTPRQ4tY0/DMvibcf8Aoym94yLei9H4M2C2eXxQICHbm+4k45d
	 RHtxhBQ6AJMh35qd6/RD1fHqmBjCLKm2U52F68eEclymLP+gS3KRGELm+JVlT0/IgX
	 8KUadiS2hgWYkCX/zeHxlPYyQayYXGd7pooh7sxC+1x46S5wULi2T58QU0/+Sa2ybH
	 etNnHtLkudqXulSTx+xf7xjQTUorrYEfDcNOVWYSaxyJT3N/4JuwTZwr08ptQM5cJ1
	 FeAAaCMsMSTOGMB6aV4vRJjQuXHV85lgeJ9Y1Ccm14Y0iwJZA8Gp1ApZ6WDTsqL/xD
	 KKqrtDWWiv38A==
Date: Sun, 8 Nov 2026 00:52:27 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Radu Sabau via B4 Relay <devnull+radu.sabau.analog.com@kernel.org>
Cc: radu.sabau@analog.com, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Nuno Sa <nuno.sa@analog.com>,
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>,
 Alexandru Ardelean <alexandru.ardelean@analog.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux@analog.com
Subject: Re: [PATCH v5 6/8] iio: imu: adis16607: Add FIFO-based
 buffered/triggered capture
Message-ID: <20261108005227.2dcd4697@jic23-hlaptop>
In-Reply-To: <20261102-adis16607-v5-6-4f98b0d271ac@analog.com>
References: <20261102-adis16607-v5-0-4f98b0d271ac@analog.com>
	<20261102-adis16607-v5-6-4f98b0d271ac@analog.com>
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

On Mon, 02 Nov 2026 11:25:42 +0200
Radu Sabau via B4 Relay <devnull+radu.sabau.analog.com@kernel.org> wrote:

> From: Radu Sabau <radu.sabau@analog.com>
> 
> Add buffered capture via the device's hardware FIFO - the only
> capture mode this driver supports. Popping the FIFO uses a dedicated
> command and payload format (FIFO_DATA_CMD, 52 bytes, no checksum),
> handled directly rather than through adislib's generic burst-read
> helpers, which assume one fixed-shape read per trigger rather than a
> variable-count drain loop.
> 
> The watermark-met condition is signaled via DEV_NOK on the device's
> one interrupt pin, which stays asserted (level-triggered) until
> DIAG_STAT is read and cleared - matching adislib's has_fifo contract.
> DEV_NOK fires on any DIAG_STAT flag, not just FIFO_THRESH_MET, so the
> trigger handler checks that specific bit before popping anything.
> DR_GPIO_MASK stays enabled unconditionally: DR pulses drive the FIFO
> controller's internal sample enqueue, independent of pin routing.
> 
> Watermark is configurable via the standard hwfifo_set_watermark
> callback and the usual hwfifo_* sysfs attributes.
> 
> Signed-off-by: Radu Sabau <radu.sabau@analog.com>
https://sashiko.dev/#/patchset/20261102-adis16607-v5-0-4f98b0d271ac%40analog.com
Has some feedback on this and later patches.

If you want to increase chance of me pickup up a patch I'd
suggest watching for any feedback from sashiko and
commenting on whether and why it is wrong before I get
to catching up on reviews.  If it is repeatedly saying stuff
you disagree with add a comment under the --- for the relevant patch.
If you have looked at it and plan to make changes but haven't
yet, please save reviewers time by replying to the thread to say
that.  If you've just had a busy week and not gotten back to this
then fair enough!

Following what sashiko came up with, I'm not sure how the adis
fifo handling works today.

https://elixir.bootlin.com/linux/v7.3.1/source/drivers/iio/imu/adis_trigger.c#L90


	if (adis->data->has_fifo)
		ret = devm_request_threaded_irq(&adis->spi->dev, adis->spi->irq,
						NULL,
						&iio_trigger_generic_data_rdy_poll,
						adis->irq_flag | IRQF_ONESHOT,
						indio_dev->name,
						adis->trig);

uses a thread of:
irqreturn_t iio_trigger_generic_data_rdy_poll(int irq, void *private)
{
	iio_trigger_poll(private);
	return IRQ_HANDLED;
}

Which is calling iio_trigger_poll() not valid from a thread which
should be using iio_trigger_poll_nested()

If it were using nested form then the sashiko thing about interrupt
storm would be fine as handle_nested_irq() calls in the same thread
so it would wait for the fifo code to run before returning and IRQF_ONESHOT
would be sufficient.

Sashiko's final point about ideal being no trigger for a device that only
does fifo based buffer capture is correct as well.



Jonathan



> ---
>  drivers/iio/imu/adis16607.c | 392 +++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 388 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/imu/adis16607.c b/drivers/iio/imu/adis16607.c
> index 5e2c999e68ac..bd7752f7a1ec 100644
> --- a/drivers/iio/imu/adis16607.c
> +++ b/drivers/iio/imu/adis16607.c





> @@ -817,6 +1180,8 @@ static int adis16607_probe(struct spi_device *spi)
>  	indio_dev->info = &adis16607_info;
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  
> +	st->fifo_watermark = ADIS16607_MAX_FIFO_WM;
> +
>  	st->adis.ops = &adis16607_ops;
>  
>  	ret = devm_regulator_get_enable(dev, "vdd");
> @@ -855,6 +1220,25 @@ static int adis16607_probe(struct spi_device *spi)
>  	if (ret)
>  		return ret;
>  
> +	/*
> +	 * DEV_NOK stays asserted until DIAG_STAT is read, so the interrupt
> +	 * must be level-triggered, active high.

I'm missing something in this comment.  Why does DEV_NOK staying asserted
have anything to do with level triggered?

> +	 */
> +	irq_type = irq_get_trigger_type(spi->irq);
> +	if (irq_type != IRQ_TYPE_LEVEL_HIGH)
> +		return dev_err_probe(dev, -EINVAL,
> +				     "Invalid interrupt type 0x%x specified\n",
> +				     irq_type);
> +
> +	st->adis.irq_flag = IRQF_TRIGGER_HIGH;
> +
> +	ret = devm_adis_setup_buffer_and_trigger_with_attrs(&st->adis, indio_dev,
> +							    adis16607_trigger_handler,
> +							    &adis16607_buffer_ops,
> +							    adis16607_fifo_attributes);
> +	if (ret)
> +		return ret;
> +
>  	ret = devm_iio_device_register(dev, indio_dev);
>  	if (ret)
>  		return ret;
> 

