Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B0B87E0FF;
	Sun, 19 Apr 2026 16:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776617212; cv=none; b=MPT9uQHF3xHK/rAThpdOlGQdfYwIh0CzkJsBZGu7gyqKRytnKBY5nhWVNluxcIq4CavhApl3gufA8nah4l9FBRzPuzMUUDfGPQb4pqsyiAZC9hBRW+H8+OcYox/OOEi0Xhz1wCo1SSQyphgDxLJ2LNbZVBpT88keFe5RThG79Q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776617212; c=relaxed/simple;
	bh=VCKifiPj273LlFLa9Rtjgye6NeGfObDMmbhV/IVLeUM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S6VHcTqrg3iSuaFmzbNxnXZdkNM4xWkTCN6vLP7I9hDAXI/mQHDInsrOaJgUDaCMX5zmtEHoG2a28mxv03nTn0EU7BdED6TiTokVzbsRosZVgNfLqRXZGac1XWi1xzjmoVD7BBBzKzeNf6bAHLDZSk9JSQGmIiDl3+41+ZRpbCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BIVGY6Kh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BIVGY6Kh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15390C2BCAF;
	Sun, 19 Apr 2026 16:46:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776617212;
	bh=VCKifiPj273LlFLa9Rtjgye6NeGfObDMmbhV/IVLeUM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BIVGY6KhoyscaZp7mwFpdbXJtvtJIQ1AH74uNoNchsF0Wc3ALnBt+W6LRF/XybXnq
	 NppnvucETjOpq8sZBjU3A1pPz/+7aZHxxcOdl6CNvrP3clvut/o/tAoKV7m+BN7XA4
	 JTRKgmHM78oNtCo6ukg2R4TB+ILBO2qm5NRu4Xmya0cDDwcPHlDKnvmnS+lcHUtV6P
	 YrKnnQdPiD/JvT31LMkJRr99ALOOmIkT9Y/tg7OljmxKPKPuP+EuBt8wJAonrTeQqC
	 Gxi0ZXpAHZhaFWetMiV58hEeE+4377wEnLALCQ4H2JbMY9hdFk5Otn0afnuEU8tb7x
	 bj3Kw523gpgRg==
Date: Sun, 19 Apr 2026 17:46:45 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Alexis Czezar Torreno <alexisczezar.torreno@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Andy
 Shevchenko <andriy.shevchenko@intel.com>
Subject: Re: [PATCH v8 2/2] iio: dac: ad5706r: Add support for AD5706R DAC
Message-ID: <20260419174645.22f6b012@jic23-huawei>
In-Reply-To: <20260417-dev_ad5706r-v8-2-ef87dff62b57@analog.com>
References: <20260417-dev_ad5706r-v8-0-ef87dff62b57@analog.com>
	<20260417-dev_ad5706r-v8-2-ef87dff62b57@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 17 Apr 2026 16:27:16 +0800
Alexis Czezar Torreno <alexisczezar.torreno@analog.com> wrote:

> Add support for the Analog Devices AD5706R, a 4-channel 16-bit
> current output digital-to-analog converter with SPI interface.
> 
> Features:
>   - 4 independent DAC channels
>   - Hardware and software LDAC trigger
>   - Configurable output range
>   - PWM-based LDAC control
>   - Dither and toggle modes
>   - Dynamically configurable SPI speed
https://sashiko.dev/#/patchset/20260417-dev_ad5706r-v8-0-ef87dff62b57%40analog.com

Sashiko correctly points out that the driver in v8 at least doesn't
do a bunch of things in this list.  It's a bit odd to list device features
in a 1st driver patch if you haven't implemented them yet.  So this
needs a rewrite to say what is implemented.


>  MAINTAINERS               |   1 +
>  drivers/iio/dac/Kconfig   |  11 ++
>  drivers/iio/dac/Makefile  |   1 +
>  drivers/iio/dac/ad5706r.c | 253 ++++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 266 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 17a3d2d45fccb9cd3c93fd35666fb85d17d53cde..3d7bd98b4d1b55836e40687a9a3ac9f4935a8acb 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1502,6 +1502,7 @@ L:	linux-iio@vger.kernel.org
>  S:	Supported
>  W:	https://ez.analog.com/linux-software-drivers
>  F:	Documentation/devicetree/bindings/iio/dac/adi,ad5706r.yaml
> +F:	drivers/iio/dac/ad5706r.c
>  
>  ANALOG DEVICES INC AD7091R DRIVER
>  M:	Marcelo Schmitt <marcelo.schmitt@analog.com>
> diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
> index db9f5c711b3df90641f017652fbbef594cc1627d..a5a328818233e3d019cddaee369dd5b7b1529031 100644
> --- a/drivers/iio/dac/Kconfig
> +++ b/drivers/iio/dac/Kconfig
> @@ -178,6 +178,17 @@ config AD5624R_SPI
>  	  Say yes here to build support for Analog Devices AD5624R, AD5644R and
>  	  AD5664R converters (DAC). This driver uses the common SPI interface.
>  
> +config AD5706R
> +	tristate "Analog Devices AD5706R DAC driver"
> +	depends on SPI
> +	select REGMAP_SPI

Another catch for Sashiko.  REGMAP_SPI isn't used as this now uses a custom regmap
instead.

> +	help
> +	  Say yes here to build support for Analog Devices AD5706R 4-channel,
> +	  16-bit current output DAC.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called ad5706r.
I think the other things it raised are either features still to come
(like turning on the power) or wrong.  My understanding of the use of
buffers for SPI transfers is you can even use the same one for rx and tx
and it shouldn't be a problem.  More than possible I'm wrong on that however! :(

Jonathan
