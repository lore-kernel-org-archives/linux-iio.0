Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8EA37482;
	Sun,  6 Oct 2024 13:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728221432; cv=none; b=DBjuA3L8DiAF6VfwhetFxd+Mf+w2GBaNX0cfZQ3bSBbx1jouRyQJ8gdxmgOfalHwBXxULMyXZBCOM6hRrcu6gnsgHmRgoHr9O54+rbXC9O7a1z8ZWEEo5CFvELrJEZyRjtchxyViWbVgQbxX5TgSD6X0M5/6dgwQmlnfd1Ws22M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728221432; c=relaxed/simple;
	bh=AU/u8WYP8Z5djRYy1IeTUs1S6bmspHZy9hiNRBcnotk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=it1mDYgnBVOPFGkTAlWamZPlvJVENtSmGEGbrzp6MHN3NQp+1pYFZN+vSGYGHZQrwK6kUwwnUHiPoVmlZ+0LOr2YeyeNr+mjvDMH+C4GJkpJkI/6xwgqKhtTy7tR33bwWzD3PaYCkipM9B3acln912CXPNkFFS77QqIcFU8EEO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WlNps7T0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WlNps7T0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF6BCC4CEC5;
	Sun,  6 Oct 2024 13:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728221432;
	bh=AU/u8WYP8Z5djRYy1IeTUs1S6bmspHZy9hiNRBcnotk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WlNps7T0FAQD72N7Ryj0/kh8WCh88KC9c/Y3SHvOVI5JQytFOPbqI599hqno+TETm
	 k9SU2Nvefs9KWOlM0lQgV1Gx5M5Ex2asa+NBgnvx13zRWmbI1pfH6Jku9beJQBcZAh
	 JJ8RiCyQ8buYrCMfEVvIdos0XMaCtAaz2VmZkj6Y4DvdMc3mqanc5ePJB+0BSb7v0F
	 8zCuQZeJyVioeA7bplzESrE4bd/x/C0lq9LBBBF1TaY1NyLDNnXSlXIkDJ6QRFrmjU
	 tllOnPeGI1nWbKGwf644f2y+emeKnv0cG1AQgUzE/ZXHkJ5xR3+GkjFssosrysNLnR
	 PQi9Q9aCajU9w==
Date: Sun, 6 Oct 2024 14:30:23 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, David Lechner
 <dlechner@baylibre.com>, Antoniu Miclaus <antoniu.miclaus@analog.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Cristian Pop
 <cristian.pop@analog.com>, Mircea Caprioru <mircea.caprioru@analog.com>,
 Alexandru Tachici <alexandru.tachici@analog.com>, Marcus Folkesson
 <marcus.folkesson@gmail.com>, Fabrice Gasnier <fabrice.gasnier@st.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/8] iio: dac: ltc1660: add missing select REGMAP_SPI in
 Kconfig
Message-ID: <20241006143023.620a8241@jic23-huawei>
In-Reply-To: <20241003-ad2s1210-select-v1-7-4019453f8c33@gmail.com>
References: <20241003-ad2s1210-select-v1-0-4019453f8c33@gmail.com>
	<20241003-ad2s1210-select-v1-7-4019453f8c33@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 03 Oct 2024 18:49:39 +0200
Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:

> This driver makes use of regmap_spi, but does not select the required
> module.
> Add the missing 'select REGMAP_SPI'.
> 
> Fixes: 8316cebd1e59 ("iio: dac: add support for ltc1660")
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Applied to the fixes-togreg branch of iio.git.

> ---
>  drivers/iio/dac/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
> index 3160b10f2752..f13daf0fd9f7 100644
> --- a/drivers/iio/dac/Kconfig
> +++ b/drivers/iio/dac/Kconfig
> @@ -354,6 +354,7 @@ config LPC18XX_DAC
>  config LTC1660
>  	tristate "Linear Technology LTC1660/LTC1665 DAC SPI driver"
>  	depends on SPI
> +	select REGMAP_SPI
>  	help
>  	  Say yes here to build support for Linear Technology
>  	  LTC1660 and LTC1665 Digital to Analog Converters.
> 

