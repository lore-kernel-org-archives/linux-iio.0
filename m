Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6DA922578D
	for <linux-iio@vger.kernel.org>; Sun, 19 Apr 2026 13:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776605054; cv=none; b=WEAT08cgrELQqL9JHb2BjCvw3d/uOCbIWUJNo0BTHs4xITyBAvBtOUQ11t7AylfzZtIT15bdGu3OIhBnosCridHhwGamlKXODaiszKYyVlNcCTrsOXRzUnIeE4B6BUkrD3t52V4D4V+nGZ0D8dYcZjzmJ+43HXExA28KuyEItns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776605054; c=relaxed/simple;
	bh=uXTDstJSty11+g36yLq/lXxd/aTol4U8lS5n/z1Ykwc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kYuuckcg+6QCirAUG282H/4aI463OBbkIZ5AinYG59GivmLY6Fwh8HWbwJHB2LWnbHztsKgYj+gfdO5OhsJK5zstGKABDZImtIRJesvhVRhnZJ695TRKBI04liQC+KWJ3Jh+8wsyxeGBAYRe2Oj+ROXhuYnCPmapUf6+GwI7fhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C61h2oP8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C61h2oP8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 361E5C2BCAF;
	Sun, 19 Apr 2026 13:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776605054;
	bh=uXTDstJSty11+g36yLq/lXxd/aTol4U8lS5n/z1Ykwc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=C61h2oP8Gt/xdS4I7FEbJvsL4cE6q1bhD4XtC/RSflRXJG9VrKjFcYcIzec+uhtbi
	 MU1uVYFQLr+yF1Qvqk7ZnoN87mKp81Rin8pLJfYU6lH+OJ7v3PxksoVqr1q3EY4dtb
	 85492hBKe8xieC8XC3dhmcptvUm7tIzShZW6xzWV0Yo7IvxK7XvJTdkhXoRiDCsYGV
	 r9dk0YAcs33AlZPkchFFYx/GBLdCvjMqzSSwJRVr4Bn6DRmErvwwCjSqb3dvtiKh+i
	 LMmmHE4Cui/MPn7l52J5cV2eKBd8yko7mcUu5L8yKngrzLmVZos+ZavV6wXkfrQYQF
	 N5l0W5d5ZyESw==
Date: Sun, 19 Apr 2026 14:24:07 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Marcelo Machado Lage <marcelomlage@usp.br>
Cc: andy@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, Vinicius
 Lira <vinilira@usp.br>, linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 1/2] iio: adc: mcp3422: rewrite mask macros using
 bitfield macros
Message-ID: <20260419142407.4a8b7dec@jic23-huawei>
In-Reply-To: <20260417165747.507487-2-marcelomlage@usp.br>
References: <20260417165747.507487-1-marcelomlage@usp.br>
	<20260417165747.507487-2-marcelomlage@usp.br>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 17 Apr 2026 13:57:46 -0300
Marcelo Machado Lage <marcelomlage@usp.br> wrote:

> Rewrite MCP3422_CHANNEL_MASK, MCP3422_PGA_MASK, MCP3422_PGA_MASK
> and MCP3422_CONT_SAMPLING using GENMASK() and BIT() macros from
> bitfield.h.
> 
> The other macros MCP3422_SRATE_{240, 60, 15, 3} were not changed
> because they are also used as array indices.
> 
> Signed-off-by: Marcelo Machado Lage <marcelomlage@usp.br>
> Co-developed-by: Vinicius Lira <vinilira@usp.br>
> Signed-off-by: Vinicius Lira <vinilira@usp.br>
> ---
>  drivers/iio/adc/mcp3422.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/adc/mcp3422.c b/drivers/iio/adc/mcp3422.c
> index 50834fdcf738..59bf73304588 100644
> --- a/drivers/iio/adc/mcp3422.c
> +++ b/drivers/iio/adc/mcp3422.c
> @@ -13,6 +13,7 @@
>   * voltage unit is nV.
>   */
>  
> +#include <linux/bits.h>
>  #include <linux/err.h>
>  #include <linux/i2c.h>
>  #include <linux/module.h>
> @@ -25,9 +26,9 @@
>  #include <linux/iio/sysfs.h>
>  
>  /* Masks */

This comment covers the first few defines, but not the reset.
Delete it whilst you are here to avoid future confusion.

> -#define MCP3422_CHANNEL_MASK	0x60
> -#define MCP3422_PGA_MASK	0x03
> -#define MCP3422_SRATE_MASK	0x0C
> +#define MCP3422_CHANNEL_MASK	GENMASK(6, 5)
> +#define MCP3422_PGA_MASK	GENMASK(1, 0)
> +#define MCP3422_SRATE_MASK	GENMASK(3, 2)
>  #define MCP3422_SRATE_240	0x0
>  #define MCP3422_SRATE_60	0x1
>  #define MCP3422_SRATE_15	0x2
> @@ -36,7 +37,7 @@
>  #define MCP3422_PGA_2	1
>  #define MCP3422_PGA_4	2
>  #define MCP3422_PGA_8	3
> -#define MCP3422_CONT_SAMPLING	0x10
> +#define MCP3422_CONT_SAMPLING	BIT(4)
>  
>  #define MCP3422_CHANNEL(config)	(((config) & MCP3422_CHANNEL_MASK) >> 5)
>  #define MCP3422_PGA(config)	((config) & MCP3422_PGA_MASK)

