Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C9C400E1B;
	Wed, 20 May 2026 18:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779301422; cv=none; b=pWvTlTQHnr+YRKx+04OpYIIZH/9a+9Ja16hrYQoZvP7FozULeInoNpIpIk32nMJQVeU6sI2QLv1a8A4sR9RZW0xfCCcjWtQjdKnECzSD7lwDiFimVS5QiYM38YQYoaB6dxF//EW3lXH4GobIqyoJ4GJ69wEV1arxWBfBrE8vMhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779301422; c=relaxed/simple;
	bh=eAkv6m8d2IGxCDoHFSMJxyF7C7uv/eqLlLgxLxLoXZg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K/YmB/4LP2wr3EZHO9zk8uFQg6YCLjq5awkbnvKCRx+T0EelbvHJbTb5ekBck89elQgEipixar1UtL/Bap1SoZ+EXawAhN3NhKxG9Zw77LPCbrod6Muu2irdCvmbmPai/D4xstaWRnwVdGJ1D0U+lOUA6PRWE2Euqb4/wvd3ayc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hbZNqBCT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hbZNqBCT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBB741F00894;
	Wed, 20 May 2026 18:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779301420;
	bh=gubjDCCRfPt2+6a28Rol+A7fNFT/WfoM0ypzk3iynrc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=hbZNqBCTk9VklHOkhdFu1srZYDdlDJYno2S5h9z9YVHa37+QyX8AqCbbaDGDO+c/c
	 ggC90hJGA+Tm8l+awiLV7PenKB0wzxsH+KswNgCj6trUXI8KVawvuHBnOS2fOmfyjy
	 ulbZiCmpNeQ8eaL4trHy0UDFwsd2t/t5/tNE0Gqy+mTPj2ZnNBEZ5WbNQ4njMuYMmR
	 93tztnIpD+y4w8iI31NlyYaYCBmVJXSUmWM/03ew/riPdJc6+L0o7ERhpgwQmx2I8M
	 +exATMvMXDzn50Fxp8VMFVeSZkk+xX9LS/Zs7kb9cknjGZZfKcg4unrXmLtBwPHNvZ
	 agX+0MXp93E6g==
Date: Wed, 20 May 2026 19:23:30 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Chris Morgan <macroalpha82@gmail.com>
Cc: linux-iio@vger.kernel.org, andy@kernel.org, nuno.sa@analog.com,
 dlechner@baylibre.com, jean-baptiste.maneyrol@tdk.com,
 linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
 heiko@sntech.de, conor+dt@kernel.org, krzk+dt@kernel.org, robh@kernel.org,
 andriy.shevchenko@intel.com, Chris Morgan <macromorgan@hotmail.com>
Subject: Re: [PATCH V8 03/10] iio: imu: inv_icm42607: Add inv_icm42607 Core
 Driver
Message-ID: <20260520192330.36dfb573@jic23-huawei>
In-Reply-To: <20260518200526.458421-4-macroalpha82@gmail.com>
References: <20260518200526.458421-1-macroalpha82@gmail.com>
	<20260518200526.458421-4-macroalpha82@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 18 May 2026 15:05:18 -0500
Chris Morgan <macroalpha82@gmail.com> wrote:

> From: Chris Morgan <macromorgan@hotmail.com>
> 
> Add the core component of a new inv_icm42607 driver. This includes
> a few setup functions and the full register definition in the
> header file.
> 
How are you driving the fifo capture? There isn't a trigger
and the irq isn't wired up that I can find.

I'm struggling to see how this works.
I would expect to see something like:
inv_icm42600_irq_handler()

Ah. This was previously in the wake up patch.  That bit we still need
for this driver to work.


> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> ---

> +int inv_icm42607_core_probe(struct regmap *regmap, const struct inv_icm42607_hw *hw,
> +			    inv_icm42607_bus_setup bus_setup)
> +{
> +	struct device *dev = regmap_get_device(regmap);
> +	struct inv_icm42607_state *st;
> +	int irq;
> +	int ret;
> +
> +	irq = fwnode_irq_get_byname(dev_fwnode(dev), "INT1");
> +	if (irq < 0)
> +		return dev_err_probe(dev, irq, "Unable to get INT1 interrupt\n");
This doesn't seem to be used?

> +
