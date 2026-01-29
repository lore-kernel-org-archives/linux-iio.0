Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8BB346AF9;
	Thu, 29 Jan 2026 17:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769709164; cv=none; b=akNU9Om7ZsEn5tpsVPTeRb1wyBT8p2RRNldc3IpUkfT0yQylA06s5G1DSut5ZVFRjz0i7bfgBU6qQLtRGgeFiNhprdTYNWRvgQsKb5OKll7KrT/BpnKyzaUV34KC5z1pMwYTjMI+CsdPhIH4LI6b1YoIHZi61caLveTzgHVuous=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769709164; c=relaxed/simple;
	bh=pHcGYpO+k3MjTmfnb63QfYJSY71FBNRD2cH08HND3fo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XrfdRblPGzIKiT7JDAKFaWLUi3utrC3zfg/aLdc9TgkjWDtqgY8FvQBr0+dRUOSl8pB2e6bxyFlnDOWCvAAYYV3lZK0BjtsZp/lb2kanr+7CftyOncPlYtPAZgsF5cKD4GJYJu5lx3m0MGRNWI8JwD8hVDdq/enwYcUOqfMGZgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aWa/oYtv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aWa/oYtv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDD73C4CEF7;
	Thu, 29 Jan 2026 17:52:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769709164;
	bh=pHcGYpO+k3MjTmfnb63QfYJSY71FBNRD2cH08HND3fo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aWa/oYtv0D+vtIDU5GxRGw/0v6YnrZ0myC8d1FgZl+Sj0R5VkjMHLu8HofUA+S7tE
	 M9pa2wmF60TjML3hAzw6UnyUQaFUdaiIyDeVkjWWGipVOoKuIZXmqTb2HzprTvrhVd
	 wL6nLPsRkETT2CEHh6g37KQPEZy3cFGRlEedRW0QKznddMnwC80Q+n+/cAtzMWq7in
	 BQDV7iVMBihJLU9wnGb9iMXBBLKfuDTi8uhBbLD6sw0OPXbVxWV1On/pl4YYaqnSIB
	 Uxn7wpZAdLNNcbI+rTeYyG4+IKaLz2iz3e0kT9MbDUhNrasRxy0LkSgpOZc/Wjmjal
	 Veo+QyfgBxuNQ==
Date: Thu, 29 Jan 2026 17:52:35 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Shrikant Raskar via B4 Relay
 <devnull+raskar.shree97.gmail.com@kernel.org>
Cc: raskar.shree97@gmail.com, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 skhan@linuxfoundation.org, david.hunter.linux@gmail.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Andy Shevchenko
 <andriy.shevchenko@intel.com>
Subject: Re: [PATCH v8 1/6] iio: proximity: rfd77402: Reorder header
 includes
Message-ID: <20260129175235.19f46f00@jic23-huawei>
In-Reply-To: <20260128-b4-rfd77402_v5-v8-1-36388fe7b95e@gmail.com>
References: <20260128-b4-rfd77402_v5-v8-0-36388fe7b95e@gmail.com>
	<20260128-b4-rfd77402_v5-v8-1-36388fe7b95e@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 28 Jan 2026 23:21:48 +0530
Shrikant Raskar via B4 Relay <devnull+raskar.shree97.gmail.com@kernel.org> wrote:

> From: Shrikant Raskar <raskar.shree97@gmail.com>
> 
> Reorder header includes to follow kernel include
> ordering conventions.
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> Signed-off-by: Shrikant Raskar <raskar.shree97@gmail.com>
As per earlier discussion I picked this already so it shouldn't
have been in this posting. Ah well, easily skipped.

J
> ---
>  drivers/iio/proximity/rfd77402.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/proximity/rfd77402.c b/drivers/iio/proximity/rfd77402.c
> index aff60a3c1a6f..69cc1505b964 100644
> --- a/drivers/iio/proximity/rfd77402.c
> +++ b/drivers/iio/proximity/rfd77402.c
> @@ -10,9 +10,9 @@
>   * https://media.digikey.com/pdf/Data%20Sheets/RF%20Digital%20PDFs/RFD77402.pdf
>   */
>  
> -#include <linux/module.h>
> -#include <linux/i2c.h>
>  #include <linux/delay.h>
> +#include <linux/i2c.h>
> +#include <linux/module.h>
>  
>  #include <linux/iio/iio.h>
>  
> 

