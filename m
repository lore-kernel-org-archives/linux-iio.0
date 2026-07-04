Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80E3833F59E;
	Sat,  4 Jul 2026 23:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783208916; cv=none; b=SRy+kWvfY/7Bo9VWn/EN9rBG8pGLpb7ra7ci0tfug38e6ps6zM6Wlcg0yT6zlUU2tCx4rXumKfYedNcKvOiqULKjIAL8fiyL5wsG1qNmZIhOIKtfdL3QNEFtjHy+OZ0j8+Nm2HBi2WE3okArcd5M2g3RaCfsPFDRq8vtugGN0OE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783208916; c=relaxed/simple;
	bh=Nc8GtcpQDANqdQMg662dOMSXMS/QcG1iFiw/XjMOiXg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nEoVCVmCEZZdQ5AZ/BSJw1BY5foPNxoMmC5IdbWNRcfhNxOE6xF3eV/yGb06WMmTqpnamjVlK3DNc4iKJ4qJa5mXymuK7kpemTqvcHvzObcpMgyiuJNdWbE2u++b8by0DYPrKk2z71zI4nKXsXKPRRd7rdl19jYZzCjDZP94ilQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hB63EwOa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hB63EwOa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADA9D1F000E9;
	Sat,  4 Jul 2026 23:48:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783208915;
	bh=O0iLzdEV4qnu4OqqfS+8ihWlYCwjBEzvuv+WkZgE8oU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=hB63EwOa3jVrLolQtEP3Dg9WOgt4YdmiLTaNgDdbG5a3oQQ7AV2trjBMOZiVaJmO/
	 4Fd8ZzLhh6mgHo7LLKN0axxHzdsRLSCz6XkV2zwv7f5BXfv6dmxRz77xfEJpFzLFYc
	 FosJeb3T9SUFTwnntEK9crN8uc7pzipHHgY79+cjnx3RBcWl6Z30s8LppIRAheIn0E
	 OP1/BQPN81BuTKxkHs+AjbdMSydvTT/p5ZZnI8pei24YAcQDeH2fk7WpDfndqdBLTR
	 Tcczu9mhj94V0iSS8jgfDw5EmgW5cK5LOhRTLSU8jaeuxIpMQGwukvnSXiR/csE//6
	 RCGCGgqLkjteQ==
Date: Sun, 5 Jul 2026 00:48:32 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <nuno.sa@analog.com>,
 <Michael.Hennerich@analog.com>, <dlechner@baylibre.com>, <andy@kernel.org>,
 <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
 <julianbraha@gmail.com>, <marcelo.schmitt1@gmail.com>
Subject: Re: [PATCH v5 3/4] iio: adc: ltc2378: Enable high-speed data
 capture
Message-ID: <20260705004832.60661c48@jic23-huawei>
In-Reply-To: <e285c16edf2e5483effad96a852a2ae110a27899.1783028033.git.marcelo.schmitt@analog.com>
References: <cover.1783028033.git.marcelo.schmitt@analog.com>
	<e285c16edf2e5483effad96a852a2ae110a27899.1783028033.git.marcelo.schmitt@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 2 Jul 2026 18:45:49 -0300
Marcelo Schmitt <marcelo.schmitt@analog.com> wrote:

> Make use of SPI transfer offloading to speed up data capture, enabling data
> acquisition at faster sample rates (up to 2 MSPS).
> 
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>

> diff --git a/drivers/iio/adc/ltc2378.c b/drivers/iio/adc/ltc2378.c
> index b5cf2e974dac..b25602d91bbe 100644
> --- a/drivers/iio/adc/ltc2378.c
> +++ b/drivers/iio/adc/ltc2378.c
> @@ -12,16 +12,28 @@
>  #include <linux/delay.h>
>  #include <linux/err.h>
>  #include <linux/gpio/consumer.h>
> +#include <linux/math64.h>
>  #include <linux/mod_devicetable.h>
>  #include <linux/module.h>
>  #include <linux/regulator/consumer.h>
> +#include <linux/pwm.h>
>  #include <linux/spi/spi.h>
> +#include <linux/spi/offload/consumer.h>
> +#include <linux/spi/offload/types.h>
> +#include <linux/time64.h>
>  #include <linux/types.h>
>  #include <linux/units.h>
>  
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/buffer-dmaengine.h>
>  #include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
I'm probably missing something. Why this include?

Jonathan

