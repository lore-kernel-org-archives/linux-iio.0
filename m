Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A77C0347C6;
	Sun, 30 Aug 2026 02:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788056563; cv=none; b=fKKW+epF+Md2sZcSY+lRWSTgNNwp9dl5R19qOWI1TrceC0FOrb1DwTQP5eX/03z3XDtYt5wac2lJRRLqSuefM15P6ZGyZSnXnSrwKl294VHbcVmvUI1vV3ofpARwTwd/AYmzlaweejEAJChHECWeR7uQDBrZBs20TdHx+cugEB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788056563; c=relaxed/simple;
	bh=yxwqhQAdUVqYqy04n3mzXJVvSvxT1PlW49KD3zvwKgE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Tmx+HoUo3kxlhh6Vpazua/Bp5CRcb1nqX/cQSvNcqfs++xpYkb9SuY5YjNSM4PgXceA51ecCosPc9tQC20VhGsTAHMw+F95R8UwKTFZdlrRum+X7X7rYuh89KoUsD2NetUr8vqPV39pPGTn6VwpG38fHGfjDeTzTwYhsdx57A5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CJggUDyk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CJggUDyk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 002291F000E9;
	Sun, 30 Aug 2026 02:22:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788056562;
	bh=I1L/7sQvlztnZ897e8JgOdSolBq6Qtbv2dmNzGNInv0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=CJggUDykoXyIoPV4Pi0ClJDYqYLuQGM+uobfq10Gh/soUK16YqCc9GqKqYLODZvcv
	 eXFcPsUUTytx5YdWzkECyClZ09MAOD1KXza2d2FKrb3+LBctA6GdAVfK4fIoVJcH/v
	 h/yFPE5pwMniEhzjMg12J0e6vXAaBHzit/eXX0UUkRmWa0USqfYGab9GZsRSEXzSzs
	 hcJ/idurUO/YHZeLPFUM01vly8P76z3OCVN43HkOqV1OB8TTdVs6ouuHHvc5v2rJR/
	 b1eaGmgb+8iP477ID1cDzeMWnWXSOoX3h3OwU4PgWN0cP6xdaLHq0Wc526QKiqKrXL
	 tJVnIJiHVXOrQ==
Date: Sun, 30 Aug 2026 03:22:37 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Kurt Borja <kuurtb@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 04/10] iio: adc: ti-ads1262: support per-channel
 sampling frequency
Message-ID: <20260830032237.6c143d59@jic23-huawei>
In-Reply-To: <20260828-ads126x-v4-4-1dc27e9c0260@gmail.com>
References: <20260828-ads126x-v4-0-1dc27e9c0260@gmail.com>
	<20260828-ads126x-v4-4-1dc27e9c0260@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 28 Aug 2026 01:38:19 -0500
Kurt Borja <kuurtb@gmail.com> wrote:

> Add per-channel sampling frequency support. The "available" attribute is
> assigned per-channel too, in order to eventually support per-filter
> availability.
> 
> Signed-off-by: Kurt Borja <kuurtb@gmail.com>

>  struct ads1262 {
>  	struct spi_device *spi;
>  	struct regmap *regmap;
>  	struct gpio_desc *start_gpiod;
> +	size_t num_channels;
> +	struct ads1262_channel *channels;

__counted_by_ptr() usable here?

>  	/* protects concurrent SPI transfers */
>  	struct mutex xfer_lock;
>  	/* protects channel state */
> @@ -185,6 +195,8 @@ struct ads1262 {
