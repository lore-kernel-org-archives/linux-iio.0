Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C39A231355C;
	Fri, 25 Sep 2026 01:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790301119; cv=none; b=O2mbWNnqzX9NKHfYTSq80cchx6Lx5JNeZsYp8bg3QB11/cEsarGLyfmfLKe2T0/COXi6jqkerA0pHICTxB53XTphW/n4kaPDA6ZjIjUZqb4L6PL8TkzaDfqstvhoZvT478qnqRxYflHmKHYHipkmuxlvJwwvAimrKKy0fIuHhK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790301119; c=relaxed/simple;
	bh=CC4xt5GiBlwbRUw7wQ9WjWfl5sgxtf7DH1Tkfa5r5As=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F41jwl57ukFreLrJ7FYIUvgxCgb6iAsd52Zf17N7lLIajJhcYURb8i9UvweF0PTLHxpxmwBAEHSeYmhM32c7pI2NRozyie5lkU8Bm/GhgEkg1T/9ZqAZfOuM7pv9dXjkDiysDaM8xAdBnBM/vHWRjSpo4Z1zPJ1EvjgcJd54pes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WHq4/t+B; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WHq4/t+B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDF9A1F000FF;
	Fri, 25 Sep 2026 01:51:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790301118;
	bh=M4vMavJkMrkIoZqEbnmJ3voS7dppi1avHmqq3XLmlYY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=WHq4/t+BWQ9jjmrpPNpTa/o6N6oWQUuGzaUN5DfW5QM4p0lTvnh7B2ZxXRxMYH4st
	 CUn5Qt9zCNacx8dFaxpN760fjp4iuu1or9H47RB/9LarBkAkrO8WGj2Ld8NyJRDOUj
	 QXHoCZeJPotdlFK8wsUZiHxPZR9glG/XZxgZpIuFIX8+KluKC+8ITfWvDfjXfy0vo6
	 HQ3wWGjiwzWECzirMXcXLjo3rl8oL2MyeuTXhFwtG5nrjvVzbPL8qwfwCEcO+mkr57
	 VTSkmUKGukpjGiLrsnT9KKx+ecD3lab30+bDBNALn+IFt8VzDSljP1zM0z4k8euLxF
	 XE1xjFiZXTwwA==
Date: Fri, 25 Sep 2026 02:51:54 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Pengpeng Hou <hppiscas@163.com>
Cc: petre.rodan@subdimension.ro, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 tiberiu.a.breana@intel.com, andriy.shevchenko@intel.com
Subject: Re: [PATCH v2] iio: accel: bma220: publish the SPI driver ACPI
 alias
Message-ID: <20260925025154.3a477b43@jic23-hlaptop>
In-Reply-To: <20260920033358.12345-1-hppiscas@163.com>
References: <20260920033358.12345-1-hppiscas@163.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 20 Sep 2026 11:33:58 +0800
Pengpeng Hou <hppiscas@163.com> wrote:

> The SPI driver advertises an ACPI match for BMA0220 but does not export
> that table. A modular build therefore lacks the ACPI alias used to load
> the driver when the device is enumerated through ACPI.
> 
> Export the ACPI table. Move the existing SPI export next to its SPI ID
> table so each export is adjacent to the table it describes.
> 
> The issue was found by our static-analysis tool.
> 
> Fixes: bf2a5600a3eb ("iio: accel: Add support for Bosch BMA220")
> Assisted-by: gpt 5
Updated to LLM and patch applied.

> Signed-off-by: Pengpeng Hou <hppiscas@163.com>
> ---
> Changes since v1:
> https://lore.kernel.org/all/20260905133901.66016-1-hppiscas@163.com/
> Place the SPI export immediately after the SPI table as Jonathan and
> Andy requested; use the full author name.
> 
>  drivers/iio/accel/bma220_spi.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/accel/bma220_spi.c b/drivers/iio/accel/bma220_spi.c
> index d6c1087cc3c0..d7a95289df48 100644
> --- a/drivers/iio/accel/bma220_spi.c
> +++ b/drivers/iio/accel/bma220_spi.c
> @@ -28,12 +28,13 @@ static const struct spi_device_id bma220_spi_id[] = {
>  	{ .name = "bma220" },
>  	{ }
>  };
> +MODULE_DEVICE_TABLE(spi, bma220_spi_id);
>  
>  static const struct acpi_device_id bma220_acpi_id[] = {
>  	{ "BMA0220", 0 },
>  	{ }
>  };
> -MODULE_DEVICE_TABLE(spi, bma220_spi_id);
> +MODULE_DEVICE_TABLE(acpi, bma220_acpi_id);
>  
>  static const struct of_device_id bma220_of_spi_match[] = {
>  	{ .compatible = "bosch,bma220" },
> 
> base-commit: 518e5b794c06c0f0eb40df3e202274a66202c137

