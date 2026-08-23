Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4721D1F1932;
	Sun, 23 Aug 2026 17:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787507911; cv=none; b=pc1GnGNgyNFzQsLjgn7tltlkIumS4B8QErdqkP40J1qspuAutOlnp8bZyLQdTQ1yVkcIq581nLDMKG7uWqEA1nXC0+pes0u8OkJuZXQNlZvPbjmOwcynbkVIyNd+1fw326dLWqB4PWath5B5XNY22rYbXw3x6IPbcG/PmM61qZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787507911; c=relaxed/simple;
	bh=xbUMC9DurvLU/H/nccaFDbW5AlD1Jt4wmcCNlGkSLOE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ngExSFh9w3hfGpiRvBRJ6Ii5puiG0DxJRmV+g4MQ20+kY/ez2iRZfV87t+Vb1xD6YqNewEKVbZoJIR1Df0JCb/lqOl+KtwpPLR5yr+UWc8Gi0Umn0lq13xhtWx7M3zvUWVUbuOP0gsakQsVapKj2742Ap8MBQqHr0ja47r4pt2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RuCd37jj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RuCd37jj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F31F1F000E9;
	Sun, 23 Aug 2026 17:58:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787507910;
	bh=x29Aym3z/QtGvj0v65MX/7pm6y7TLBWCzg94wk20wz4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=RuCd37jjxUeuDsscPZkmtfjTUXthrC3XGDNaut17BI0CzhXEgvVShK69dtBq4CBex
	 DQ5JYHHGLrmhYuBdKLd5iOHtxOjfdz+XfEdk0xNS+CGCTXXwpgzMblxa+uuhS6mPYs
	 e8r4Syto6CraNkTgNSwDURQyByfkFTtjlgAqFGCPGMnWcXSPz3R4MfUZ3s5/VRTbtY
	 qsRF5SX8pEMVhRNyVfEnRRPVvr/iMMTSGxOTZhPTUplRMdMpt4m7xAyAwgGYbfF0S8
	 1175+/eTUA0Yt5C72boBUQYO5VALN8lpAagXu8qeVNcdDlIetusqQZVZf14ZOrOzd4
	 Qao59IdxSGkrA==
Date: Sun, 23 Aug 2026 18:58:25 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Crt Mori
 <cmo@melexis.com>, Puranjay Mohan <puranjay@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/14] iio: temperature: tsys01: reorder headers
Message-ID: <20260823185825.292eb144@jic23-huawei>
In-Reply-To: <20260822-kernel-header-removal-v1-11-ee31b124be11@gmail.com>
References: <20260822-kernel-header-removal-v1-0-ee31b124be11@gmail.com>
	<20260822-kernel-header-removal-v1-11-ee31b124be11@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 22 Aug 2026 10:02:38 +0200
Joshua Crofts <joshua.crofts1@gmail.com> wrote:

> Sort the headers alphabetically and group the IIO headers and vendor
> specific header separately.
> 
> No functional change.
> 
> Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
Just as a reference - this level of reorder definitely wants to
be on its own as a separate patch as you have it here!

Jonathan

> ---
>  drivers/iio/temperature/tsys01.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/temperature/tsys01.c b/drivers/iio/temperature/tsys01.c
> index 28b3ce022ce7..14de67ee8be7 100644
> --- a/drivers/iio/temperature/tsys01.c
> +++ b/drivers/iio/temperature/tsys01.c
> @@ -8,14 +8,16 @@
>   *  http://www.meas-spec.com/downloads/TSYS01_Digital_Temperature_Sensor.pdf
>   */
>  
> -#include <linux/iio/iio.h>
> -#include <linux/iio/sysfs.h>
>  #include <linux/device.h>
> -#include <linux/mutex.h>
> -#include <linux/module.h>
>  #include <linux/init.h>
>  #include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
>  #include <linux/stat.h>
> +
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +
>  #include "../common/ms_sensors/ms_sensors_i2c.h"
>  
>  /* TSYS01 Commands */
> 

