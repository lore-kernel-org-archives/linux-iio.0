Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 125D235AC24;
	Sun,  5 Jul 2026 23:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783294191; cv=none; b=Trkzg8w83D83S71dj68j7ssmzmuN3tVcxbMPg/AaZQE4H/BsMWgt87+H59Zc/Sn+HQX76rv2bwWyyau7cj3kl0Xi9TjYwQspYKTvyI35Rdbr6f+C0cA2XdYjRkilk+knegGlQOvrNzCC8P2bNrQe//w+B2yJHr/Lmr1Hn5XqBs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783294191; c=relaxed/simple;
	bh=6CaOgtCa0bVBrCb5tH2NCsttvaZOsCEOw1/yPW2MF/s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q1N/JuthDWOml/YZ3rZ5q4pKPb95Mnl+Bo/L5z6lGJJKNLi1OKZnGCPCKjU2WViWNAib0a8QN9bAsqvDskVZ0KRdmoA0orrCZgBDQmD/Q6Vvj50LQsE2hflCpqF8a9+J5T/lIKmDJ9pq91CGO3URNS6hsTawq5V4N2craCkf4aM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ad9jmPbN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ad9jmPbN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31EB31F000E9;
	Sun,  5 Jul 2026 23:29:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783294189;
	bh=N1vndsL4eLHtNuyiHBc8bLtj/Izwg2+csEiShhcB7Xo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Ad9jmPbNg2BC7+lhvSABu7HBBHLZfC+zxR1lw7nnwWdQ82LyejftXPcnU5apNtV6i
	 78LCHHh7PkMpJrjdDvilZPcyZyjs/5g/xDCswky0WyUyBp2Jq6VTvhiLdvd8C0cjei
	 qye3Tq5WFxSuT497kmPjByoTz2MiUcGnV3mpsMAbzVVAGGslSjrvUJ/oybl5H58bkl
	 TyGcZgg5avC9FlNkprBXnQSoCdWViIONOzKL1CFTMx6A27GZVAhlOp2e9Drr7C00pG
	 SNufUNnCEt28P2yMtRMvL8PvnlUUUhBiDAo4BafoNo5UcPM/RzuXS7z1xnSi5i6nZ+
	 JC7flvtASDGEQ==
Date: Mon, 6 Jul 2026 00:29:40 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Rodrigo Alencar via B4 Relay
 <devnull+rodrigo.alencar.analog.com@kernel.org>
Cc: rodrigo.alencar@analog.com, Michael Auchter <michael.auchter@ni.com>,
 linux@analog.com, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, Michael
 Hennerich <Michael.Hennerich@analog.com>, David Lechner
 <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, Kees Cook
 <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: Re: [PATCH v6 1/6] iio: dac: ad5686: refactor command/data macros
Message-ID: <20260706002940.4cb95cbb@jic23-huawei>
In-Reply-To: <20260705-ad5686-new-features-v6-1-269594c7aae5@analog.com>
References: <20260705-ad5686-new-features-v6-0-269594c7aae5@analog.com>
	<20260705-ad5686-new-features-v6-1-269594c7aae5@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 05 Jul 2026 12:38:56 +0100
Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:

> From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> 
> Replace usage of bit shifting macros for FIELD_PREP(), which would not
> ignore bit masking when preparing SPI/I2C commands.
> 
> Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>

...

> diff --git a/drivers/iio/dac/ad5686.h b/drivers/iio/dac/ad5686.h
> index c424720f8f72..0d1bbf110926 100644
> --- a/drivers/iio/dac/ad5686.h
> +++ b/drivers/iio/dac/ad5686.h
> @@ -14,13 +14,6 @@
>  
>  #include <linux/iio/iio.h>
>  
> -#define AD5310_CMD(x)				((x) << 12)
> -
> -#define AD5683_DATA(x)				((x) << 4)
> -
> -#define AD5686_ADDR(x)				((x) << 16)
> -#define AD5686_CMD(x)				((x) << 20)
> -
>  #define AD5686_ADDR_DAC(chan)			(0x1 << (chan))
>  #define AD5686_ADDR_ALL_DAC			0xF
>  
> @@ -38,12 +31,18 @@
>  #define AD5686_CMD_CONTROL_REG			0x4
>  #define AD5686_CMD_READBACK_ENABLE_V2		0x5
>  
> +#define AD5310_CMD_MSK				GENMASK(15, 12)
> +#define AD5310_DATA_MSK				GENMASK(11, 0)

There is a sashiko bug report on the final patch that got me looking at
these - it's a false positive but took some time to figure out why
it was getting confused.  I think we need to do something to make it
more obvious what is going on..

>  #define AD5310_REF_BIT_MSK			BIT(8)

This is bit 8 of DATA - here DATA is 0 aligned so no mismatch.

>  #define AD5310_PD_MSK				GENMASK(10, 9)
>  
> +#define AD5683_DATA_MSK				GENMASK(19, 4)
>  #define AD5683_REF_BIT_MSK			BIT(12)

and this is bit 12 of AD5683_DATA rather than BIT(12) of the the whole thing
(given the 4 don't care bits.)  

Could either rename things to
#define AD5683_DATA_REF_BIT_MSK() or add a comment on the bit positions
in the overall message - which will then align with the ones of the datasheet.
where ref is DB16.

>  #define AD5683_PD_MSK				GENMASK(14, 13)
>  
> +#define AD5686_CMD_MSK				GENMASK(23, 20)
> +#define AD5686_ADDR_MSK				GENMASK(19, 16)
> +#define AD5686_DATA_MSK				GENMASK(15, 0)
>  #define AD5686_REF_BIT_MSK			BIT(0)
>  #define AD5686_PD_MSK				GENMASK(1, 0)
>  
