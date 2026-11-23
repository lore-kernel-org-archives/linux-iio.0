Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795420945;
	b=ab51vdNFQqnyOmWgXJYT0i9s/+vHox/tdyj8dctuw5KxJ35asMS2iI6nPhvpXc/PLbDt
	 y+wteLhJ1rPdkZT4FFTdG2k8C3fd521cMOxK7Imbml4UboGa1uHf1kCweLP5av7rOQQ6H
	 MAk6ixrGNMeP7luPK7fYLgpvzYdHl8SbpSYvSMrxKohhB0kO2x6S+rMtctRNRhc8IIhy2
	 eqI/x4j7LI7hK8dQOSz+3kj1aacx5ssvyTK1ebGHrnLcLxC6sGLML3xpn20utaDU0cBLn
	 A8bOq06R+2ij95RBlKdoEZldA4ctQEFhg+kYill8mO4iYc+JcPPMggJD/8OxKQEd2fQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795420945;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=9MO+FscP0oLuSA6HQ1IcEy1QVZX1vKoTYNCXPCvUOQw=;
	b=Y5cMbh5kwb7T2aF3xs+feYEMJlqZLCRHfjH+1vKKbZuhQUFjNyv8YHYP9QNLYC1dDMFe
	 13H2q34VVWp5ljFXYoqKmloVfmzywlJcXqmyBnXJ7IdHEhtl22xZwKZixfBMTffSGS+uA
	 72cCdkrGQEJM4oWnT+W6888+ewX1BLxhtg+X8SDQHlzLKcEVxfWpuQk+KI/0karTyuxpg
	 RFSNXBucuZ/iC2afFsbQQ0Azp1JhL71l8S+BTeqIecsUAe5DvPK8wCUuVH25qYnUZlWTi
	 GwUl7sxUHPX8HSpFReA2IfP7R8fXIMsCxHFOODobEZhj0eWf17fFxJpYU/vBChUSB4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c0eJ0Gge;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29857606A68D;
	Mon, 23 Nov 2026 08:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c0eJ0Gge
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D37F01F000D0;
	Mon, 23 Nov 2026 08:02:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795420944;
	bh=9MO+FscP0oLuSA6HQ1IcEy1QVZX1vKoTYNCXPCvUOQw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=c0eJ0GgezLjfSBiuvX+K/2pdMbAnzKg7QxaZcK8XLFDDRu19ri0tLhDrzQyDl1g73
	 On690aa1xcMhTJifi+zykOBWdp440jat40bkrqD94/djB2t87EPBTkPDQjhjuws50V
	 iYut90gqtgBh+mB5/isPqw/KLsMRL5XCreGaQJit9nyn0CfbOXa/uiP0VUyqGss0Yd
	 gUxD9BFRICQHpvE14uipfccpBBkSsKoWyrGamSYiY2rsk2oZK9cn8ioBZcz5avJbBr
	 yNcdNefKr3Bd/pzfzRwNJw+ibY/WuVWLdofOOOPoBvhvDjEGVarm1roz8a0BTnk81/
	 4SqkW6XKlVg8A==
Message-ID: <ec05443a-a61a-4eb1-947a-c044faf9206c@kernel.org>
Date: Mon, 23 Nov 2026 09:02:21 +0100
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Subject: Re: [PATCH v5 4/8] iio: adc: at91_adc: convert to device_property_*()
 APIs
To: Abdelnasser Hussein <abdelnasserhussein11@gmail.com>, jic23@kernel.org,
 linux-iio@vger.kernel.org
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
 claudiu.beznea@tuxon.dev, giorgitchankvetadze1997@gmail.com,
 amin.gattout@gmail.com, antoniu.miclaus@analog.com,
 gregkh@linuxfoundation.org, mripard@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20261123070101.53868-1-abdelnasserhussein11@gmail.com>
 <20261123070101.53868-5-abdelnasserhussein11@gmail.com>
Content-Language: en-US
From: Joshua Crofts <crofts@kernel.org>
In-Reply-To: <20261123070101.53868-5-abdelnasserhussein11@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 23-Nov-26 8:00, Abdelnasser Hussein wrote:
> Use the firmware-agnostic device_property_*() helpers instead of the
> OF-specific property readers, so the driver does not depend on a device
> node being available in probe.
> 
> Update at91_adc_probe_dt_ts() to take a struct device and read its
> properties through device_property_read_u32() as well.  Since the helper
> no longer uses DT-specific APIs, rename it from at91_adc_probe_dt_ts() to
> at91_adc_probe_ts().  This removes the need for a struct device_node
> pointer in at91_adc_probe(); as a result, at91_adc_probe_ts() now logs
> against dev (&pdev->dev) instead of &idev->dev.
> 
> Drop the " in the DT" suffix from the missing property messages to match
> the firmware-agnostic property APIs.
> 
> With no OF APIs or struct device_node left in the file, drop the
> <linux/of.h> include and add <linux/mod_devicetable.h> for struct
> of_device_id.
> 
> Signed-off-by: Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
> ---
>  drivers/iio/adc/at91_adc.c | 34 +++++++++++++++++-----------------
>  1 file changed, 17 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
> index 2a378540837d..b6e6fa77c782 100644
> --- a/drivers/iio/adc/at91_adc.c
> +++ b/drivers/iio/adc/at91_adc.c
> @@ -15,8 +15,8 @@
>  #include <linux/interrupt.h>
>  #include <linux/jiffies.h>
>  #include <linux/kernel.h>
> +#include <linux/mod_devicetable.h>

Remove this, The corresponding device table is pulled from platform_device.h.

-- 
Kind regards,
Joshua Crofts

