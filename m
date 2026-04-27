Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E90530B50F
	for <linux-iio@vger.kernel.org>; Mon, 27 Apr 2026 10:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777284661; cv=none; b=LY6Oa3sDGeZMRHVvkJoFyDzfkdUPiEVd5kMoguUAv7KVB7T87nmWeAX4dtbF5Cf5aQmyB+Mt1tdL0djP5KTKjNosaCDUL2iyMukddvNYi62N0IVHIIdsacUdbHf/Xtgqea35cGo/XMZaPlJJgnRx+zX1M23ZFTgR0gGVgZTca9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777284661; c=relaxed/simple;
	bh=hTQ+Nm3408VfTS6qIZ7SJIR7a4UET8p2wzXRUI2N2Uc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KOP0cwCNjtvnKqwq+/FPfRhQjAo/l1zD4lJA/x3VgJ23rsggL9M3Gm9RVWaktKppbuS10rvGJGbqWO4T6a31ODQM26ZM9NR8eRket9Tv9jjVO++7o1hYqejQm1KSzjN90JsC604iLen86fvwseeou6yYJvzp51BwgBFCEBE0Z1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=myRy1y0S; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="myRy1y0S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 083B9C2BCB6;
	Mon, 27 Apr 2026 10:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777284660;
	bh=hTQ+Nm3408VfTS6qIZ7SJIR7a4UET8p2wzXRUI2N2Uc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=myRy1y0SwFinU1uPzxc1hL5qGx1+kLTlJ9Dlp5AB5O4+KIxoDbo1saHPgDTJNHcra
	 Kt1aGX7djF+l3UnKvV+YBGpJ3Hxk3zcMM5rk+wC+m+gfyOUD9FndV8kj1Vzg5Y6wh3
	 SrQnIBPxJnX6tAUyrZ23tl1yiCsvmKbUquVj71chriRHUamvvcXPn7Nq/blq4Ouez1
	 yG8DTcO0bOQ21Z5/lzqhgLe1FtAQLDpRFpkfwhCnbWI1ITOo7xLRXMWFBkvQP4IqNH
	 UH4Z46PdddCXiZQwpSky/4rg9Xi2JOTk3/iXrXyY8KJu2cXlLaFA1MUAzi68g0cFdS
	 JgENA8/LjAC9Q==
Date: Mon, 27 Apr 2026 11:10:50 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Caio Morais <caiomorais@usp.br>
Cc: andy@kernel.org, dlechner@baylibre.com, michal.simek@amd.com,
 nuno.sa@analog.com, linux-arm-kernel@lists.infradead.org,
 linux-iio@vger.kernel.org
Subject: Re: [PATCH 3/3] iio: common: st_sensors: fix includes with IWYU
Message-ID: <20260427111050.7fbf88a1@jic23-huawei>
In-Reply-To: <20260426211834.3318306-4-caiomorais@usp.br>
References: <20260426211834.3318306-1-caiomorais@usp.br>
	<20260426211834.3318306-4-caiomorais@usp.br>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 26 Apr 2026 18:18:02 -0300
Caio Morais <caiomorais@usp.br> wrote:

> From: Caio Morais <caiomorais@usp.br>
> 
> Signed-off-by: Caio Morais <caiomorais@usp.br>
> ---
>  drivers/iio/common/st_sensors/st_sensors_i2c.c | 7 +++++--
>  drivers/iio/common/st_sensors/st_sensors_spi.c | 9 +++++++--
>  2 files changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/common/st_sensors/st_sensors_i2c.c b/drivers/iio/common/st_sensors/st_sensors_i2c.c
> index 7156302fe..04d106def 100644
> --- a/drivers/iio/common/st_sensors/st_sensors_i2c.c
> +++ b/drivers/iio/common/st_sensors/st_sensors_i2c.c
> @@ -7,12 +7,15 @@
>   * Denis Ciocca <denis.ciocca@st.com>
>   */
>  
> +#include <linux/device.h>
> +#include <linux/err.h>
>  #include <linux/i2c.h>
> -#include <linux/kernel.h>
> +#include <linux/linkage.h>
>  #include <linux/module.h>
> -#include <linux/iio/iio.h>
>  #include <linux/regmap.h>
>  
> +#include <linux/iio/iio.h>
> +
>  #include <linux/iio/common/st_sensors_i2c.h>
>  
>  #define ST_SENSORS_I2C_MULTIREAD	0x80
> diff --git a/drivers/iio/common/st_sensors/st_sensors_spi.c b/drivers/iio/common/st_sensors/st_sensors_spi.c
> index 0da270139..884077d51 100644
> --- a/drivers/iio/common/st_sensors/st_sensors_spi.c
> +++ b/drivers/iio/common/st_sensors/st_sensors_spi.c
> @@ -7,12 +7,17 @@
>   * Denis Ciocca <denis.ciocca@st.com>
>   */
>  
> -#include <linux/kernel.h>
> +#include <linux/device.h>
This one is similar to kernel.h in that it's mostly a catch all header
that we prefer to replace if possible with more specific ones.

Now the driver might directly dereference a struct device, but if
so that normally indicates something we should clean up.
Maybe it's something else.  As mentioned in previous review
providing that info under the --- in the patch can save time on
questions like this.

> +#include <linux/err.h>
> +#include <linux/linkage.h>
>  #include <linux/module.h>
> -#include <linux/iio/iio.h>
>  #include <linux/property.h>
>  #include <linux/regmap.h>
>  #include <linux/spi/spi.h>
> +#include <linux/stddef.h>
> +#include <linux/types.h>
> +
> +#include <linux/iio/iio.h>
>  
>  #include <linux/iio/common/st_sensors_spi.h>
>  

