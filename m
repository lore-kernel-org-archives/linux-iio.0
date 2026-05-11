Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C4B229BD87
	for <linux-iio@vger.kernel.org>; Mon, 11 May 2026 12:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778502492; cv=none; b=tSQMHzaO7tz2OChgBXedaBUbvi/8cw9dz17rim5vhYtusUjQTIUirm4NC3/q+mXv/vtMtX1zokYylobfIWqM+OLmp5OwGSljDiNii6V0i+sUlI1QnD2nKIs1e9MCCrKLCTgxqh+hW+bmDStD2Gb+YyP2PB/jNq/UsRgsR4hkqzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778502492; c=relaxed/simple;
	bh=6Bly+kmXe+Z2JQPk9/VD/90enPYqp/0BQ2eTNAgV/r4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LLe8m+9esBUwqXFhcv0b6XeIJEoOCFu9ZunYKvyuFWPGMhWGuBWlqttfAbTnJRaj3fm7+TBtRoPBtUVOC0cJLAWAyM7WWWL14LU8AsTu9ywcjZlyUnPh0e1l6fhgxNZ7dCP5gIJrx3PSjWYJJeT1IjxR9+a9xnpfUJMkxZn7kWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iUQK4QHv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iUQK4QHv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D361CC2BCB0;
	Mon, 11 May 2026 12:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778502491;
	bh=6Bly+kmXe+Z2JQPk9/VD/90enPYqp/0BQ2eTNAgV/r4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iUQK4QHvsrb6Okgih3s2XTs8PFK7SRA3zbtb4G77PiK7ziq+kCI8XIbgnbzzX3vf9
	 hJyothOhvg3bqzCq2AiX8QdhQ8BNVCYGPLsUw5dfT5SefpDRt7SpGHCn5wTSqc3LW6
	 2irPYP6TtzzaPoo4JyxTxe9b9na33s6Z6sl4+O/Lb6gj57UZ98B05SUT5l+ckwzhRX
	 Racu4eO7LZEPLw4SwMZfCQ3pXLo8hOy2ySe4HdtBCtn4n0Mzx0hi0/7mqKZ0ZIVJzR
	 Kvwn9j8vxp7icMTdZKpAQO14Wt6UNuDDazcFyHgRh9Ei7j3Y98v2c3CNc5GjfegpGl
	 jwiwuRgyyrN3Q==
Date: Mon, 11 May 2026 13:28:04 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "Jose A. Perez de Azpillaga" <azpijr@gmail.com>
Cc: linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>
Subject: Re: [RFC 3/4] iio: light: add build support for APDS9999
Message-ID: <20260511132804.2d2c54b5@jic23-huawei>
In-Reply-To: <4bffb49a6b8a47037a08e728caab539fea6a88b8.1778491503.git.azpijr@gmail.com>
References: <cover.1778491503.git.azpijr@gmail.com>
	<4bffb49a6b8a47037a08e728caab539fea6a88b8.1778491503.git.azpijr@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 11 May 2026 12:14:50 +0200
"Jose A. Perez de Azpillaga" <azpijr@gmail.com> wrote:

> Add Kconfig entry and Makefile rule for the APDS9999 driver.
> 
> Signed-off-by: Jose A. Perez de Azpillaga <azpijr@gmail.com>
Squash with previous patch.   There are some corners of the kernel
where they have a pattern of building up particularly complex drivers
in multiple patches that won't compile then adding build support.

We never do that in IIO each patch must build whatever was added
(slightly exception for complex multi module drivers where it can
 be tricky to do).

Anyhow, short story is merge with previous.

> ---
>  drivers/iio/light/Kconfig  | 10 ++++++++++
>  drivers/iio/light/Makefile |  1 +
>  2 files changed, 11 insertions(+)
> 
> diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
> index eff33e456c70..c7256ffb972d 100644
> --- a/drivers/iio/light/Kconfig
> +++ b/drivers/iio/light/Kconfig
> @@ -119,6 +119,16 @@ config APDS9960
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called apds9960
>  
> +config APDS9999
> +	tristate "APDS9999 ambient light sensor"
> +	depends on I2C
> +	help
> +	  Say Y here if you want to build support for the Broadcom APDS9999
> +	  ambient light sensor (ALS/Lux).
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called apds9999.
> +
>  config AS73211
>  	tristate "AMS AS73211 XYZ color sensor and AMS AS7331 UV sensor"
>  	depends on I2C
> diff --git a/drivers/iio/light/Makefile b/drivers/iio/light/Makefile
> index c0048e0d5ca8..39e62dfc10c7 100644
> --- a/drivers/iio/light/Makefile
> +++ b/drivers/iio/light/Makefile
> @@ -14,6 +14,7 @@ obj-$(CONFIG_APDS9160)		+= apds9160.o
>  obj-$(CONFIG_APDS9300)		+= apds9300.o
>  obj-$(CONFIG_APDS9306)		+= apds9306.o
>  obj-$(CONFIG_APDS9960)		+= apds9960.o
> +obj-$(CONFIG_APDS9999)		+= apds9999.o
>  obj-$(CONFIG_AS73211)		+= as73211.o
>  obj-$(CONFIG_BH1745)		+= bh1745.o
>  obj-$(CONFIG_BH1750)		+= bh1750.o

