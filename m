Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A28CF39FCD8;
	Sat,  1 Aug 2026 02:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785550995; cv=none; b=aiujNfc2QO3duiFRuv99XCM3BRwO4/kycqNK8a/oSjxLc+t9U6hCUPh1rC0e9cxGZ9xSV0C+qcRx7OB+7i5KGPx3m3MdgXmmKWP+ukeK6d+aLIFt4NK7/8dcmv0pMCAwFXuGfh5YAgampsHod8V4k2k3iDIIXN+uIdbcs2j46tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785550995; c=relaxed/simple;
	bh=Ecj/sJazMAj33PzevHVbq+Q5SwROqgT8oFHWW8hI3fA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=erjh9aeEXlWvm6px7vRHSTYmf5D/QyzKwydXg86CPNi45IXvJamgt+qKywnhcF8QLBdJJHq5/tHY9nGHnYXs/xmxEqRTN3ZbBrbRC6wO2a4DphcRa+xZ7OJuSKB8LM3h0MRbiwZxaade7DiFbzFgImrDqt8A7uOGKWQ3hmqZF28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OjcTNZ+Y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OjcTNZ+Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13AFA1F00AC4;
	Sat,  1 Aug 2026 02:23:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785550994;
	bh=Q50/0/WaF6VAgNYzVu440qfXBHMRaW0aCg0T/iFu6ZQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=OjcTNZ+YKIU00MJJeQrNIsjtFdwO7ReQe0zK4XmyM/OZQswhT4jMRpm/h6Yg0YPw6
	 nacNFHNouhkJ0Yw4i+OTbo3qrLVJ8uHLfjPIyL8VjobNhlyF5RDLO/ywmVBQNJPD5y
	 qalsG48jd2JEtDEi3j0Htc33Z2wVw9lvXizuBT1jtXwnBFExyOOMNxvA/gSBTSUp2z
	 S4227qGg4jxewdWNVlm9fnFH3PHyFqk8q7lOywV6HVLUIpvYHueRH47psqw+BnoKPe
	 kRzBkv7BdyW9FJp+lga+faxm061aIYkicnsvEh3wM1RRa1QZpsjET9im3yQxQAzj0w
	 W3JbwXKctuGdw==
Date: Sat, 1 Aug 2026 03:23:10 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>
Cc: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Chris
 Morgan <macromorgan@hotmail.com>, Luca Weiss <luca.weiss@fairphone.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Conor Dooley <conor@kernel.org>
Subject: Re: [PATCH v3 2/3] iio: imu: inv_icm42600: drop the whoami check
Message-ID: <20260801032310.18f5f16d@jic23-huawei>
In-Reply-To: <20260728184351.75015-3-jorijnvdgraaf@catcrafts.net>
References: <20260728184351.75015-1-jorijnvdgraaf@catcrafts.net>
	<20260728184351.75015-3-jorijnvdgraaf@catcrafts.net>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 28 Jul 2026 20:43:50 +0200
Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net> wrote:

> A WHOAMI value differing from the one the compatible implies aborts
> probe with -ENODEV, preventing a register-compatible part described
> with a fallback compatible from probing at all.
> 
> The devicetree compatible is authoritative for which part is fitted:
> drop the check, and with it the now-unused whoami definitions. No
> warning replaces it, since probing via a fallback compatible is
> legitimate use, not a condition to report. This changes the probe
> outcome on mismatch for all parts the driver supports.
> 
> Tested via a backport to a Fairphone 6 running a 7.1-based kernel: its
> ICM-42630 (WHOAMI 0x0C), described with an icm42631 fallback compatible
> and matched as icm42631, probes silently, and accelerometer, gyroscope
> and temperature reads work.
> 
> Suggested-by: Conor Dooley <conor@kernel.org>
> Link: https://lore.kernel.org/all/20260722-creature-volley-0f083b904c1d@spud/
> Link: https://lore.kernel.org/all/20260728-extradite-yanking-42d918637f61@spud/
> Assisted-by: Claude:claude-fable-5
> Signed-off-by: Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>

Hi Jorijn,

I'm open to other opinions, particularly from those who are using
this driver but I think dropping any form of hint that the device isn't
the one we expect is too far when previous we just failed to probe.

We have a lot of drivers that issue such a print and my understanding
is that has been useful.  If we want to make it non threatening we could
phrase it as something like "Device ID XX is not the YY associate with the
FW specified device, probably using a valid fallback compatible".  That
would still provide the breadcrumb for anyone seeing an unexpected
part change on their device vs the DT.

Jonathan

 
> ---
> v3: drop the check and the now-unused whoami definitions instead of
> demoting the mismatch error to a warning (Conor); retested on the
> device.
> New in v2, as a demotion of the error to a warning.
>  drivers/iio/imu/inv_icm42600/inv_icm42600.h     |  9 ---------
>  .../iio/imu/inv_icm42600/inv_icm42600_core.c    | 17 -----------------
>  2 files changed, 26 deletions(-)
> 
> diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600.h b/drivers/iio/imu/inv_icm42600/inv_icm42600.h
> index b55d993f0264..88acdbab14c3 100644
> --- a/drivers/iio/imu/inv_icm42600/inv_icm42600.h
> +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600.h
> @@ -378,15 +378,6 @@ struct inv_icm42600_sensor_state {
>  #define INV_ICM42600_INT_SOURCE1_SMD_INT1_EN		BIT(3)
>  #define INV_ICM42600_INT_SOURCE1_WOM_INT1_EN		GENMASK(2, 0)
>  
> -#define INV_ICM42600_REG_WHOAMI				0x0075
> -#define INV_ICM42600_WHOAMI_ICM42600			0x40
> -#define INV_ICM42600_WHOAMI_ICM42602			0x41
> -#define INV_ICM42600_WHOAMI_ICM42605			0x42
> -#define INV_ICM42600_WHOAMI_ICM42686			0x44
> -#define INV_ICM42600_WHOAMI_ICM42622			0x46
> -#define INV_ICM42600_WHOAMI_ICM42688			0x47
> -#define INV_ICM42600_WHOAMI_ICM42631			0x5C
> -
>  /* User bank 1 (MSB 0x10) */
>  #define INV_ICM42600_REG_SENSOR_CONFIG0			0x1003
>  #define INV_ICM42600_SENSOR_CONFIG0_ZG_DISABLE		BIT(5)
> diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
> index dc97d8a274e3..963c9425e31a 100644
> --- a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
> +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
> @@ -103,7 +103,6 @@ const struct regmap_config inv_icm42600_spi_regmap_config = {
>  EXPORT_SYMBOL_NS_GPL(inv_icm42600_spi_regmap_config, "IIO_ICM42600");
>  
>  struct inv_icm42600_hw {
> -	u8 whoami;
>  	const char *name;
>  	const struct inv_icm42600_conf *conf;
>  };
> @@ -143,37 +142,30 @@ static const struct inv_icm42600_conf inv_icm42686_default_conf = {
>  
>  static const struct inv_icm42600_hw inv_icm42600_hw[INV_CHIP_NB] = {
>  	[INV_CHIP_ICM42600] = {
> -		.whoami = INV_ICM42600_WHOAMI_ICM42600,
>  		.name = "icm42600",
>  		.conf = &inv_icm42600_default_conf,
>  	},
>  	[INV_CHIP_ICM42602] = {
> -		.whoami = INV_ICM42600_WHOAMI_ICM42602,
>  		.name = "icm42602",
>  		.conf = &inv_icm42600_default_conf,
>  	},
>  	[INV_CHIP_ICM42605] = {
> -		.whoami = INV_ICM42600_WHOAMI_ICM42605,
>  		.name = "icm42605",
>  		.conf = &inv_icm42600_default_conf,
>  	},
>  	[INV_CHIP_ICM42686] = {
> -		.whoami = INV_ICM42600_WHOAMI_ICM42686,
>  		.name = "icm42686",
>  		.conf = &inv_icm42686_default_conf,
>  	},
>  	[INV_CHIP_ICM42622] = {
> -		.whoami = INV_ICM42600_WHOAMI_ICM42622,
>  		.name = "icm42622",
>  		.conf = &inv_icm42600_default_conf,
>  	},
>  	[INV_CHIP_ICM42688] = {
> -		.whoami = INV_ICM42600_WHOAMI_ICM42688,
>  		.name = "icm42688",
>  		.conf = &inv_icm42600_default_conf,
>  	},
>  	[INV_CHIP_ICM42631] = {
> -		.whoami = INV_ICM42600_WHOAMI_ICM42631,
>  		.name = "icm42631",
>  		.conf = &inv_icm42600_default_conf,
>  	},
> @@ -505,15 +497,6 @@ static int inv_icm42600_setup(struct inv_icm42600_state *st,
>  	unsigned int val;
>  	int ret;
>  
> -	/* check chip self-identification value */
> -	ret = regmap_read(st->map, INV_ICM42600_REG_WHOAMI, &val);
> -	if (ret)
> -		return ret;
> -	if (val != hw->whoami) {
> -		dev_err(dev, "invalid whoami %#02x expected %#02x (%s)\n",
> -			val, hw->whoami, hw->name);
> -		return -ENODEV;
> -	}
>  	st->name = hw->name;
>  
>  	/* reset to make sure previous state are not there */

