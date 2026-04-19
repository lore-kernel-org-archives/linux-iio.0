Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D33D244661;
	Sun, 19 Apr 2026 13:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776605881; cv=none; b=f2V480DDgXkUQMqfnlfr2b4iHs/+EDaYCYqbX10aqraRur4yC1YtP2ApX9jFHpcsPN6NUOMMaC30nw6Dl9gFFavCGjri1qkn18kY1ouEEXPYgA8aZ1XQRKrmbLXifMXLGLcFWsOSw6vXb1Lf1iHx6420Z2sWiSQC01n7SKFTuwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776605881; c=relaxed/simple;
	bh=6WY595BorbNWnGnJ/EDvEz8w+H+97ZbIq0Q2Gf00ZGE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gInONJzT4xe9JZon3esFHvKvj9zm0eQaLX2zkD55rgMO7y7k6GEC3yKFH4yBX1SoO4j3r1aFqLLkGr7gflhvj1LrBWWNiU0OoixtTOz/cIXB5B/avtvzsJTiNlvTbGSmFlErbTkJl47Hz6dDSF6OyHq2lgYRrIy+eIXUc8dnJrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=onyzH2b1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="onyzH2b1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B086BC2BCAF;
	Sun, 19 Apr 2026 13:37:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776605881;
	bh=6WY595BorbNWnGnJ/EDvEz8w+H+97ZbIq0Q2Gf00ZGE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=onyzH2b10RsdQQo0RQ9VXTWosVZynAK1s3DXlO7TMz/4WZoXj7QgUVE0UwqpMJEwP
	 SFehCsCc+xgE7MOqArqdXbrl2U8PEtDTrxc9I8qM2e8USsZLmjxIq36nV/RtdlJg/s
	 xEFRT7QjTs1gnz5J/XA78XGt2MUYTAXJXnRSzx4sBxVlQ3m8dMj2wbeOrZK1r8UaDy
	 SDAGclHdy4hbikShrLOBCNOU6IK5tJI31hxK73e1WeqPZzl9hrDCv3FW4Egw2KDJal
	 AVVObspcarz6so0QpcG7zjFXxGkk8zFDVyDBqg1nBUIJSEj41moZ9yg5xUerT1aUXU
	 I1Od5V6AgR8vg==
Date: Sun, 19 Apr 2026 14:37:51 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
 <skhan@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Randy Dunlap
 <rdunlap@infradead.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 2/3] iio: tsl2772: add support for Avago
 APDS9900/9901 ALS/Proximity sensor
Message-ID: <20260419143751.11ec0b69@jic23-huawei>
In-Reply-To: <20260419083125.35572-3-clamor95@gmail.com>
References: <20260419083125.35572-1-clamor95@gmail.com>
	<20260419083125.35572-3-clamor95@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 19 Apr 2026 11:31:23 +0300
Svyatoslav Ryhel <clamor95@gmail.com> wrote:

> The Avago APDS990x has the same register set as the TAOS/AMS TSL2772 so

A Sashiko review comment makes me wonder about one thing below if the
register set does match.  Maybe it's a bit more subtle than this
patch description suggests?

> just add the correct bindings and the appropriate LUX table derived from
> the values in the datasheet. Driver was tested on the LG Optimus Vu P895.
> 
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  drivers/iio/light/tsl2772.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/iio/light/tsl2772.c b/drivers/iio/light/tsl2772.c
> index c8f15ba95267..8dab34bf00ca 100644
> --- a/drivers/iio/light/tsl2772.c
> +++ b/drivers/iio/light/tsl2772.c
> @@ -127,6 +127,7 @@ enum {
>  	tmd2672,
>  	tsl2772,
>  	tmd2772,
> +	apds990x,
>  	apds9930,
>  };
>  
> @@ -221,6 +222,12 @@ static const struct tsl2772_lux tmd2x72_lux_table[TSL2772_DEF_LUX_TABLE_SZ] = {
>  	{     0,      0 },
>  };
>  
> +static const struct tsl2772_lux apds990x_lux_table[TSL2772_DEF_LUX_TABLE_SZ] = {
> +	{ 52000,  115960 },
> +	{ 36400,   73840 },
> +	{     0,       0 },
> +};
> +
>  static const struct tsl2772_lux apds9930_lux_table[TSL2772_DEF_LUX_TABLE_SZ] = {
>  	{ 52000,  96824 },
>  	{ 38792,  67132 },
> @@ -238,6 +245,7 @@ static const struct tsl2772_lux *tsl2772_default_lux_table_group[] = {
>  	[tmd2672] = tmd2x72_lux_table,
>  	[tsl2772] = tsl2x72_lux_table,
>  	[tmd2772] = tmd2x72_lux_table,
> +	[apds990x] = apds990x_lux_table,
>  	[apds9930] = apds9930_lux_table,
>  };
>  
> @@ -289,6 +297,7 @@ static const int tsl2772_int_time_avail[][6] = {
>  	[tmd2672] = { 0, 2730, 0, 2730, 0, 699000 },
>  	[tsl2772] = { 0, 2730, 0, 2730, 0, 699000 },
>  	[tmd2772] = { 0, 2730, 0, 2730, 0, 699000 },
> +	[apds990x] = { 0, 2720, 0, 2720, 0, 696000 },
>  	[apds9930] = { 0, 2730, 0, 2730, 0, 699000 },
>  };
>  
> @@ -316,6 +325,7 @@ static const u8 device_channel_config[] = {
>  	[tmd2672] = PRX2,
>  	[tsl2772] = ALSPRX2,
>  	[tmd2772] = ALSPRX2,
> +	[apds990x] = ALSPRX,

This is different from tsl2772?

>  	[apds9930] = ALSPRX2,
>  };

