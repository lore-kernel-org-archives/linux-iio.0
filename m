Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 023312DECD3;
	Sat, 15 Aug 2026 04:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786767267; cv=none; b=SRxP+tIisTrlwFNfBpbHokc0E5dLXZV6C7AtDEPRhBCJkJFln1E141XQGYDqCtgTVo/kZCf1DyPkCWEFCdfremn322k+Tneb5cmsm2YwC6HCDXneAHDpaQyddIq1vYTHhPHPF/oUuN9zGN291jJp3nxG2WhJtha7aouSozqtks4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786767267; c=relaxed/simple;
	bh=qYurkZ0zU5P8ELgxTS6Q/4LJZSYpEhSHw7HK1p2ZvIo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RNmOwdWEvfV7mD3P6gQ+s6atxO5WwcDAfM/1Tod/iWn4reIS/vP3lkZvOHQ1ZGE1VxsvbUK6mYNhRk443Fc22LonsuuXT6G01WRiFVTtO9f0MSy21VtnlxO4eJcK2V9mLkCLzu1Z7Wa4R0JqgmtEzomxrWHq1s/35aTBoAo37oM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WgL+kRO5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WgL+kRO5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61D871F000E9;
	Sat, 15 Aug 2026 04:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786767265;
	bh=aNIiry1IuRswXdr8ZGqWPqPMO5dZSKvJ3MsNJpxG1F0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=WgL+kRO5p9kHS6vyoq1Z8MQq008qyT79u65cWZ6HceHZ1xMv2gBYKNYOAd4/4lHXU
	 bEDCmNlSZWT59Zs2mD6SfIi89UKYqYn2wTdNTI9uDABgAL4N7mNhBmzGR31krie7DU
	 Tbvw5izsakztszkB+CsJXGlXqA1baj5JQXjwXnkTymsyRFZ1e673wAyWcM7CX9qG7t
	 hor8gC8looII7A3pBcZXPLQTFd/P3iim6rHejW0XCPuAKfXSJfJ6gXOct+lvJHpErX
	 G0QIW1Bi0JOMW2ji7DyIPhgzD5OROTA6tjghaygacngLoMMyZZ/uKmHY5gzzwrNlsO
	 dqb9kb35GPQUA==
Date: Sat, 15 Aug 2026 05:13:56 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Esben Haabendal <esben@geanix.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Martin Kepplinger <martink@posteo.de>, Sean Nyekjaer
 <sean@geanix.com>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Martin Kepplinger <martin.kepplinger@theobroma-systems.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Joshua Crofts <joshua.crofts1@gmail.com>,
 Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: Re: [PATCH v4 2/6] iio: accel: mma8452: Optimize struct mm8452_data
 member orders
Message-ID: <20260815051356.4dac350e@jic23-huawei>
In-Reply-To: <20260812-mma8452-open-drain-v4-2-bfca15d02b59@geanix.com>
References: <20260812-mma8452-open-drain-v4-0-bfca15d02b59@geanix.com>
	<20260812-mma8452-open-drain-v4-2-bfca15d02b59@geanix.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 12 Aug 2026 16:30:33 +0200
Esben Haabendal <esben@geanix.com> wrote:

> Reorder struct mma8452_data members to avoid holes.
Trivial but sashiko pointed out mm[a]_8452 in the title.
I'll tidy that up if nothing significant comes up.

Interestingly Sashiko also thinks it found a deadlock.
Given you are working with this driver if you have time could
you take a look at that. 

https://sashiko.dev/#/patchset/20260812-mma8452-open-drain-v4-0-bfca15d02b59%40geanix.com

I'm rather surprised to see the lock taken in the runtime
pm suspend callback. It is probably there to close a race
where the device is being suspended and the sampling
frequency is being written.  I'm not immediately sure what
the best way to fix it is. One thing that would work is to
do pm_runtime_get* to raise the reference counter and stop
there being any chance of an autosuspend. 

Jonathan

> 
> Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> Signed-off-by: Esben Haabendal <esben@geanix.com>
> ---
>  drivers/iio/accel/mma8452.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
> index 7d683686dd9d..f645a5c6fd1c 100644
> --- a/drivers/iio/accel/mma8452.c
> +++ b/drivers/iio/accel/mma8452.c
> @@ -106,10 +106,7 @@ struct mma8452_data {
>  	struct i2c_client *client;
>  	struct mutex lock;
>  	struct iio_mount_matrix orientation;
> -	u8 ctrl_reg1;
> -	u8 data_cfg;
>  	const struct mma_chip_info *chip_info;
> -	int sleep_val;
>  	struct regulator *vdd_reg;
>  	struct regulator *vddio_reg;
>  
> @@ -118,6 +115,10 @@ struct mma8452_data {
>  		__be16 channels[3];
>  		aligned_s64 ts;
>  	} buffer;
> +
> +	int sleep_val;
> +	u8 ctrl_reg1;
> +	u8 data_cfg;
>  };
>  
>   /**
> 

