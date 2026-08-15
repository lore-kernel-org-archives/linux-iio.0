Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5608230BE9;
	Sat, 15 Aug 2026 19:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786823565; cv=none; b=oFHcYDJhbV8jsztsk14h9/+7TwJPnrPRcLTqA3T6HiXjgPlyEuQHz1vGezBZAxB+gX8adZFeTkTSww0R9Oy36o4D/WlpFM+GtyG78uX3YOW/c3TME5famjCf1UJ9sqT9YZVF8eUIiTkDfpz+WvZg41OsNYXJJgmAYnzvw4kA03w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786823565; c=relaxed/simple;
	bh=xVk9crjRUCRyfGxlAmhNWg7FcxM5txoOpJmdHmb0STU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=me44Sljf0gvdL53Q9LzdtwKq5Uf+SbtmLAQiiVRei1SX8ycIAW2eu5VEP8ObKqij36FkKOCcS1OcQi5Q3sFzeCzITDrJNsIvvDry3UJ4/P2RmWtS81z4I5E7E+s/97btmZ7Cvi3EmKlwaVG42feEcZAjWnhDZuvvIX+Qjj7Asls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EYVc7dIk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EYVc7dIk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B38E71F000E9;
	Sat, 15 Aug 2026 19:52:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786823564;
	bh=Eq2RtujxGrJTIGd3DVkk78kzCYiIFx37waJS5UewyY4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=EYVc7dIkz8sAGGnIifOr7xcYSgycnMye4jiiP11Hr7c1BQBb3L07YlIzSFIt0D8Sh
	 LleR6bQftlhHsbF0iBXN+WAAKwOVt0nIBddZo74lSopOf1tMeh3oX73IKsm3Wrsn7G
	 JX4RvkdUAU8S1s3bZ2DX7Jbo1nl1Rp41kZQY7nnLH5SxmEjm3/1cYGWogWpRCx8Jk7
	 KnU9mfFSXAic3PLY1/I5h8Fm4cHGVt0MLLMvCqqj/dZAYxAqjQY5seTx+txR4UKrXt
	 cD+1nOpQItDhVsC8bXS0YQOUxp0zue/ukMunnWD5RSCz4+WzFgAdyMvE2M0vyjQcb9
	 wfY1XMXfm+1aw==
Date: Sat, 15 Aug 2026 20:52:38 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Varshini Rajendran <varshini.rajendran@microchip.com>
Cc: <ehristev@kernel.org>, <dlechner@baylibre.com>, <nuno.sa@analog.com>,
 <andy@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
 <conor+dt@kernel.org>, <nicolas.ferre@microchip.com>,
 <alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>,
 <srini@kernel.org>, <marcelo.schmitt@analog.com>, <radu.sabau@analog.com>,
 <joshua.crofts1@gmail.com>, <jorge.marques@analog.com>,
 <Jonathan.Santos@analog.com>, <jishnu.prakash@oss.qualcomm.com>,
 <antoniu.miclaus@analog.com>, <duje@dujemihanovic.xyz>,
 <mazziesaccount@gmail.com>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 02/17] nvmem: add DEFINE_FREE for nvmem_cell_put
 cleanup
Message-ID: <20260815205238.6fbfb2f8@jic23-huawei>
In-Reply-To: <20260806074024.531259-3-varshini.rajendran@microchip.com>
References: <20260806074024.531259-1-varshini.rajendran@microchip.com>
	<20260806074024.531259-3-varshini.rajendran@microchip.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 6 Aug 2026 13:10:09 +0530
Varshini Rajendran <varshini.rajendran@microchip.com> wrote:

> Add cleanup.h helper for nvmem_cell_put() to enable automatic resource
> cleanup using __free(nvmem_cell_put) annotation.
> 
> Use IS_ERR_OR_NULL() since nvmem_cell_get() can return error pointers,
> and passing an ERR_PTR to nvmem_cell_put() would cause issues.
> 
> Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
> ---

Srinivas, if you are happy with this header addition please could
I have an Ack to take this through the IIO tree?  If it's useful
for other series, I can provide an immutable branch that you can
pull into the nvmem tree.  I'll probably spin one of those on rc1
once available anyway just in case someone else needs it later
in the cycle.

No huge rush - just good to keep this moving!

Jonathan


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

