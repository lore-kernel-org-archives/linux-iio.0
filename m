Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA411EBA19;
	Sun, 15 Feb 2026 18:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771180608; cv=none; b=o0udqaDm2tttZbPx4dZpARaC9u07g3fmbfoz1jGnbsoW8ujpqQsH6SN85/xkrrkhJKeyDMGIxZ8/KpBT0sNiAmiPu1CUYxzI+XptlzeIgfMVRD4v9MzrsqXTYXK5Mlnj2CQt6fOyAWV7RyHxSWBU9gonmK03KNBe/uTee1TW+UA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771180608; c=relaxed/simple;
	bh=+/Rc5maKjLy08h0wpdN6G+DutwWQ8aqa6L6Vi3lZq4s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WZqVpVtTF81KC8Wp1NISM8fC43PtIL4rAIM0CGWxgI6LyvlYoqACpj6QqCH/xUvu0NffNkrVcnLcFs5WFon+h93E6xwK8mtu0K/K3niRKuzfMldKFJO5H9iAkoKH0HrWnk7j14pOndB1WB04MyPRLqK7dL8W+UJ4QzA7EJOxu2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jFiWwVeo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jFiWwVeo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F4B0C4CEF7;
	Sun, 15 Feb 2026 18:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771180608;
	bh=+/Rc5maKjLy08h0wpdN6G+DutwWQ8aqa6L6Vi3lZq4s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jFiWwVeoHgzGQywO3ax9cQndCX6cSeW/4Iz03RCTRBVEc8OnNpMG7oL9PFkQULy2a
	 iUqcPzi+8uO62JwM9i3I8IPQpFhXDV9Bng2ng/aVptbRAUaHJcwJrAGy6mU4YRIv9+
	 PbawkcfUkoOcMQo90E+oLtWAPCWfYNzzXBVLvJas+91Lgy7Og4wEYP2BPd4hFRf2ji
	 8Z3UnnlmXQURkQmc747cvKkGNjqhyDHKQDOQnF4LAeAndE/kF1ODtueCn4Y2twdOj/
	 Kz7VkHNRjEzrxkEiH/BllCXwxwF2hbVhWzicqjnIaK9mpQO9/Bg4w/E8vb1il07l0l
	 8XujFfiJJ0bvQ==
Date: Sun, 15 Feb 2026 18:36:37 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Olivier Moysan
 <olivier.moysan@foss.st.com>, Mark Brown <broonie@kernel.org>,
 <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>
Subject: Re: [PATCH v3 1/5] spi: allow ancillary devices to share parent's
 chip selects
Message-ID: <20260215183637.315365ce@jic23-huawei>
In-Reply-To: <20260213144742.16394-2-antoniu.miclaus@analog.com>
References: <20260213144742.16394-1-antoniu.miclaus@analog.com>
	<20260213144742.16394-2-antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 13 Feb 2026 16:47:33 +0200
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> When registering an ancillary SPI device, the current code flags a chip
> select conflict with the parent device. This happens because the
> ancillary device intentionally uses one of the parent's chip selects,
> but __spi_add_device() checks against all existing devices including
> the parent.
> 
> Allow this by passing the parent device pointer to __spi_add_device()
> and skipping the conflict check when the existing device is the parent.

Smells like a fix. If so why don't we have a fixes tag?

This will need review from Mark. I haven't really understood how this
is intended to work.

Jonathan


> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> Reviewed-by: David Lechner <dlechner@baylibre.com>
> ---
> Changes in v3:
>   - Drop redundant NULL check for info->parent in spi_dev_check()
> 
>  drivers/spi/spi.c | 29 +++++++++++++++++++++++------
>  1 file changed, 23 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> index e25df9990f82..693bdcc5a12a 100644
> --- a/drivers/spi/spi.c
> +++ b/drivers/spi/spi.c
> @@ -641,12 +641,26 @@ static inline int spi_dev_check_cs(struct device *dev,
>  	return 0;
>  }
>  
> +struct spi_dev_check_info {
> +	struct spi_device *new_spi;
> +	struct spi_device *parent;	/* set for ancillary devices */
> +};
> +
>  static int spi_dev_check(struct device *dev, void *data)
>  {
>  	struct spi_device *spi = to_spi_device(dev);
> -	struct spi_device *new_spi = data;
> +	struct spi_dev_check_info *info = data;
> +	struct spi_device *new_spi = info->new_spi;
>  	int status, idx;
>  
> +	/*
> +	 * When registering an ancillary device, skip checking against the
> +	 * parent device since the ancillary is intentionally using one of
> +	 * the parent's chip selects.
> +	 */
> +	if (spi == info->parent)
> +		return 0;
> +
>  	if (spi->controller == new_spi->controller) {
>  		for (idx = 0; idx < spi->num_chipselect; idx++) {
>  			status = spi_dev_check_cs(dev, spi, idx, new_spi, 0);
> @@ -663,10 +677,11 @@ static void spi_cleanup(struct spi_device *spi)
>  		spi->controller->cleanup(spi);
>  }
>  
> -static int __spi_add_device(struct spi_device *spi)
> +static int __spi_add_device(struct spi_device *spi, struct spi_device *parent)
>  {
>  	struct spi_controller *ctlr = spi->controller;
>  	struct device *dev = ctlr->dev.parent;
> +	struct spi_dev_check_info check_info;
>  	int status, idx;
>  	u8 cs;
>  
> @@ -710,7 +725,9 @@ static int __spi_add_device(struct spi_device *spi)
>  	 * chipselect **BEFORE** we call setup(), else we'll trash
>  	 * its configuration.
>  	 */
> -	status = bus_for_each_dev(&spi_bus_type, NULL, spi, spi_dev_check);
> +	check_info.new_spi = spi;
> +	check_info.parent = parent;
> +	status = bus_for_each_dev(&spi_bus_type, NULL, &check_info, spi_dev_check);
>  	if (status)
>  		return status;
>  
> @@ -772,7 +789,7 @@ int spi_add_device(struct spi_device *spi)
>  	spi_dev_set_name(spi);
>  
>  	mutex_lock(&ctlr->add_lock);
> -	status = __spi_add_device(spi);
> +	status = __spi_add_device(spi, NULL);
>  	mutex_unlock(&ctlr->add_lock);
>  	return status;
>  }
> @@ -2580,8 +2597,8 @@ struct spi_device *spi_new_ancillary_device(struct spi_device *spi,
>  
>  	WARN_ON(!mutex_is_locked(&ctlr->add_lock));
>  
> -	/* Register the new device */
> -	rc = __spi_add_device(ancillary);
> +	/* Register the new device, passing the parent to skip CS conflict check */
> +	rc = __spi_add_device(ancillary, spi);
>  	if (rc) {
>  		dev_err(&spi->dev, "failed to register ancillary device\n");
>  		goto err_out;

