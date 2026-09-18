Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DBC352CCC9;
	Fri, 18 Sep 2026 21:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789765980; cv=none; b=W6KpUxhJmSojXQhX+5jqu0ZLKoQcns//Q6EdU3V1EM0ghy70qW2ZjYMcQFKmm3nLjyfs7zNAlNcSjuAYKwk9PiNKeCFFpOf7JYIWR0GS8EwvId/rwTuGvgeNXHQOWP1Xsi1gvIgVMIPBlHrHjH5r58V+gT5kDwgq27jqobT+cpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789765980; c=relaxed/simple;
	bh=XUcoR4k25seLQt7yXrs3cnd4bgp4UVAXOg74+TQ6XTg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=cq5JZ8UnfHrTgPdKSPp2+xExPJo73QuDTGCyWNveveseFHLG286Ze+BVEroujAtucPXUGIVcQmMsclhkRYasxgWtwV5GePNGgFpJJS5W6jxc9HNaL/zLHck+uXpU0/DjjF+6qbio5BxR8yIOMaEkuHUgYkXkGBQ8PowyyPD7uhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y3iVVvtR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y3iVVvtR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C810B1F00898;
	Fri, 18 Sep 2026 21:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789765978;
	bh=y0SzIkkSBKfu/AxHDR83Lgh1/qGoUsppxH+ZJjLMZNc=;
	h=Date:Subject:To:References:From:In-Reply-To;
	b=Y3iVVvtRPvtkHKUcFB+YOvt3WWnI5ExAUHksCFjRykPYrqJgJgJ8uvDKDGwSRgerY
	 AEORAydSUlVvfh54jXzbO2SpFApUeTFDdpwFtM5sGtwjkD21sP/ZQWNnSHDM2BdeM3
	 dxBA6lUlsILstz81senwCuL2ULNwP6/XARl7vahZtHBiwbmXG7neC2JtoTXwZd0AzU
	 G5m1l+4+uJb0PtBqeV2IMp7ql9/ikQHPbhNpum2rfCgwbTGsQRsBWzS+yFTwUASE2L
	 bkt6+yicW6LwWSTt/h3Iw58CPVMiglc5DsNQWgfvQsMc5UfMYcdTUdV5ToxK4wdk7l
	 DJmUAT5tovvPA==
Message-ID: <602a9221-1939-420d-8305-53454269d398@kernel.org>
Date: Fri, 18 Sep 2026 22:12:51 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 02/17] nvmem: add DEFINE_FREE for nvmem_cell_put
 cleanup
To: Varshini Rajendran <varshini.rajendran@microchip.com>,
 ehristev@kernel.org, jic23@kernel.org, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, nicolas.ferre@microchip.com,
 alexandre.belloni@bootlin.com, claudiu.beznea@tuxon.dev, srini@kernel.org,
 marcelo.schmitt@analog.com, radu.sabau@analog.com, joshua.crofts1@gmail.com,
 jorge.marques@analog.com, Jonathan.Santos@analog.com,
 jishnu.prakash@oss.qualcomm.com, antoniu.miclaus@analog.com,
 duje@dujemihanovic.xyz, mazziesaccount@gmail.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20260806074024.531259-1-varshini.rajendran@microchip.com>
 <20260806074024.531259-3-varshini.rajendran@microchip.com>
Content-Language: en-US
From: Srinivas Kandagatla <srini@kernel.org>
In-Reply-To: <20260806074024.531259-3-varshini.rajendran@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/6/26 8:40 AM, Varshini Rajendran wrote:
> Add cleanup.h helper for nvmem_cell_put() to enable automatic resource
> cleanup using __free(nvmem_cell_put) annotation.
> 
> Use IS_ERR_OR_NULL() since nvmem_cell_get() can return error pointers,
> and passing an ERR_PTR to nvmem_cell_put() would cause issues.
> 
> Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
> ---

lgtm,

Acked-by: Srinivas Kandagatla <srini@kernel.org>


This series has multiple sub-system patches, who do you want to proceed
with this?

--srini

>  include/linux/nvmem-consumer.h | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/include/linux/nvmem-consumer.h b/include/linux/nvmem-consumer.h
> index 34c0e58dfa26..5315bd862f5f 100644
> --- a/include/linux/nvmem-consumer.h
> +++ b/include/linux/nvmem-consumer.h
> @@ -9,6 +9,7 @@
>  #ifndef _LINUX_NVMEM_CONSUMER_H
>  #define _LINUX_NVMEM_CONSUMER_H
>  
> +#include <linux/cleanup.h>
>  #include <linux/err.h>
>  #include <linux/errno.h>
>  #include <linux/notifier.h>
> @@ -243,6 +244,8 @@ static inline struct nvmem_device *nvmem_device_find(void *data,
>  
>  #endif /* CONFIG_NVMEM */
>  
> +DEFINE_FREE(nvmem_cell_put, struct nvmem_cell *, if (!IS_ERR_OR_NULL(_T)) nvmem_cell_put(_T))
> +
>  #if IS_ENABLED(CONFIG_NVMEM) && IS_ENABLED(CONFIG_OF)
>  struct nvmem_cell *of_nvmem_cell_get(struct device_node *np,
>  				     const char *id);

