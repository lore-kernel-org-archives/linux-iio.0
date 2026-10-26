Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792980483;
	b=HWomdi6KyFUsL9EDCZbSNNMTNgGMSgrusjcI+0tD9qfqtZVff0bxADIpjWoLMW6vUHV8
	 f9atf1AACdYjRzJfstY9WTcXAdDZ6Kyl1MIQ4ovgyqHyAfYlhiND0EQd4soSYLHnTw24e
	 4urXh0eZc4zLf5MV6wkv7eySyBxi/EkYwSr/pmptQfRYlAUE0vXkddKGIABgDWZilcNNL
	 g83OaJpuriz0YeKhU20NrtRYM1RjEklLTVaZ8k1o42qzECPl/OPFbpMg3ZntV/OEY9Tbn
	 DvjaNec4E0qr4+vGhn7BxTeYae8b/jWkJHDAhWWo12q9lgpc5PP0IwFqwPhoETdpI+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792980483;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=udB4WUSLlHOnrdElRJG30Kpsih4XHIuaSZ4K7+ARFTE=;
	b=a+DYoSabMiJXFkzzRFy8FJZE4R5ELbD/Ch8+2k/ZCHrzCtQPp/+ZoYENTXGBoIzuGL+x
	 DarrTHin8/b5cPw0stQ47comNWrw63U5zWKkyZ34kcvQSAfXXNOx5sGMAOy4AOUlG1V40
	 5+3ZhQ3TBU7d4mAhUxVBHPf+4P20Yy4AegWYeEYci3/efgm5452OW7LXPz5iuluIvBasG
	 oaGk7t4HpF9mIxXoGRWSX26FlQy41oRI2jfY4+QxkLLpOfFBx3856okNPMKCtq0eU6wfH
	 kRD3VP61VJkggmYZKUdzPqye/VD9OpehIREMoqlUZhWwfca/YlT1fmFVmghA+NdnpPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CTPmLSCJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46FC5606A321;
	Mon, 26 Oct 2026 02:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CTPmLSCJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C5671F01825;
	Mon, 26 Oct 2026 02:07:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792980483;
	bh=udB4WUSLlHOnrdElRJG30Kpsih4XHIuaSZ4K7+ARFTE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=CTPmLSCJM1QA7SCTBGKD108BjPTuQdxhvqO3XMkqDoVSn5QBgX157RUDcdCcsyqa+
	 4y8ZBV0GrotJ5Tgq71vRPCeOzjKi0J93VmbH48CpBETxmtrbereJQ+gSmlSbcbutnQ
	 rH2hHBr3wr3NO0iJXOdQSl/2MjYySXGQVZkfN3HD+X9e/sKdJRQF8oU9OlFhfG0LGl
	 SyeKCmkOBtFrZAVa8uBNfCe4lKGgg0qXQCer1PWaavDxZ5leo3p0njI00H0Ai6ZuvM
	 feaGCVReA/hYmRUWsrLNMyGRaT19h3gFqs/avYF3uD2lIkCeCvv8E6uvB5LuPc9ajf
	 /hWa5YrmW9N/g==
Date: Mon, 26 Oct 2026 02:07:53 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Jonathan Santos <Jonathan.Santos@analog.com>
Cc: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
 <linux@analog.com>, <broonie@kernel.org>, <robh@kernel.org>,
 <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
 <Michael.Hennerich@analog.com>, <nuno.sa@analog.com>,
 <dlechner@baylibre.com>, <andriy.shevchenko@intel.com>
Subject: Re: [PATCH v4 5/9] spi: expand device name to include enabled CS
 lines for multi-CS devices
Message-ID: <20261026020753.42426bc0@jic23-hlaptop>
In-Reply-To: <0bd7dfae5aa64066b8a3555cdcbd1b84de688f33.1792435248.git.Jonathan.Santos@analog.com>
References: <cover.1792435248.git.Jonathan.Santos@analog.com>
	<0bd7dfae5aa64066b8a3555cdcbd1b84de688f33.1792435248.git.Jonathan.Santos@analog.com>
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

On Tue, 20 Oct 2026 22:57:44 -0300
Jonathan Santos <Jonathan.Santos@analog.com> wrote:

> The device name for SPI devices was formatted as <controller>.<cs0>,
> always using only the first chip-select index, ignoring the remaining CS
> lines.
> 
> Change the naming format to <controller>.<cs0>-<csN> for multi-cs
> devices so that the range of active chip-selects is reflected in the
> device name. Since we are not expecting sparse values for logical CS
> values, adopt the range format.
change that to not supporting rather than expecting.

I'm not sure that's a good idea - and Andy's request to check for
existing ones is a good start.  However, if you do it, consistency
through the patch set is important.

> 
> Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
> ---
> Changes in v4:
> * Opted for the range format, since we decide to limit logical CS values
>   to a contiguous sequence.
> 
> Changes in v3:
> * replaced `int idx = 1` by `unsigned int idx = 1` in the for loop.
> 
> Changes in v2:
> * New patch.
> ---
>  drivers/spi/spi.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> index 2b2eeaa4c15d..53d6ab4ce8a3 100644
> --- a/drivers/spi/spi.c
> +++ b/drivers/spi/spi.c
> @@ -782,6 +782,7 @@ static void spi_dev_set_name(struct spi_device *spi)
>  {
>  	struct device *dev = &spi->dev;
>  	struct fwnode_handle *fwnode = dev_fwnode(dev);
> +	u8 num_enabled_cs = hweight32(spi->cs_index_mask);
>  
>  	if (is_acpi_device_node(fwnode)) {
>  		dev_set_name(dev, "spi-%s", acpi_dev_name(to_acpi_device_node(fwnode)));
> @@ -793,6 +794,19 @@ static void spi_dev_set_name(struct spi_device *spi)
>  		return;
>  	}
>  
> +	/*
> +	 * In multi-CS arrangements, use num_enabled_cs (derived from
> +	 * cs_index_mask) to determine which CS lines the device is actively
> +	 * using. num_chipselect only reflects how many CS lines are assigned
> +	 * to the device, not how many are actually enabled.
> +	 */
> +	if (num_enabled_cs > 1) {
> +		dev_set_name(&spi->dev, "%s.%u-%u", dev_name(&spi->controller->dev),
> +			     spi_get_chipselect(spi, 0),
> +			     spi_get_chipselect(spi, num_enabled_cs - 1));
> +		return;
> +	}
> +
>  	dev_set_name(&spi->dev, "%s.%u", dev_name(&spi->controller->dev),
>  		     spi_get_chipselect(spi, 0));
>  }

