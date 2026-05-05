Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D55321F2D;
	Tue,  5 May 2026 11:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777979154; cv=none; b=q8ijKEgyHjQZI8Qztup0JyfcYt3wP3CUNzIS0FYCSg/o0ceSB22uv4R3SfTJebAGdzZ8HKEFCQEQPU+uSndOl+882aIuyDPvVC+gExM+96xOru9532ZnknSX2mO8rCKDj733aRGPr1jHvSFukF+Uys4B/X9ja74CqqsbuIdkFFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777979154; c=relaxed/simple;
	bh=zXaJ9Lj0riMPpWbtPEHDCJ3GTBuQKZAGsOzv5w1JElg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=usybYbtG5cAooSiECn0rr6sHvyCp1t7QznQ9gWtPa2VFeVu5WytMHIfOy4M2l0OFiMU5NIV2owMUs422ETuONL6V4M6xffnSUfrHdFztGwNdMKg9LtrNdkfMpHxrGcf+pbqxnq5hFt/Ra7joEF2x9Wz5k9VyEPq1UeErfVb4+lI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CgCl41xB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CgCl41xB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41BBAC2BCC7;
	Tue,  5 May 2026 11:05:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777979154;
	bh=zXaJ9Lj0riMPpWbtPEHDCJ3GTBuQKZAGsOzv5w1JElg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CgCl41xBJa4HkDzpc8hm94DD7IBkNkHx/5UCzAjcIW7O6feJ2tt4ZEsBtEABmZOe0
	 ZzHM7cdxta2K/DVE0mIcvnPlKCwwreho4E98G5NsfEtvA9tEOpEWdjfy90lk5ThQla
	 bnQCOGPoQydNwAvZ6xR5th17BIfpf6qKZRh7N8TeXjIlal0i/jlPdW4+Eh5XOtCIT5
	 SkoEDJSCvA2G796GdrSti2e5szzx7Xbq5MRmM8+I8rpcPoBr0dBOZkW7DtMQVmCcPn
	 MWn9Yi3bUKppmKMevHIokTMq6ZH6IlC5dG9GtUuxaSGdCg7gxzWDxMgZeb+3bbbAYU
	 BAiBw1JKTw+iw==
Date: Tue, 5 May 2026 12:05:44 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Rodrigo Alencar via B4 Relay
 <devnull+rodrigo.alencar.analog.com@kernel.org>
Cc: rodrigo.alencar@analog.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Stefan Popa <stefan.popa@analog.com>,
 Jonathan Cameron <jic23@cam.ac.uk>, Greg Kroah-Hartman <gregkh@suse.de>,
 Michael Auchter <michael.auchter@ni.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, David
 Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, Andy
 Shevchenko <andriy.shevchenko@intel.com>
Subject: Re: [PATCH v5 03/12] iio: dac: ad5686: acquire lock when doing
 powerdown control
Message-ID: <20260505120544.693cadf4@jic23-huawei>
In-Reply-To: <20260501-ad5686-fixes-v5-3-0b2f45488418@analog.com>
References: <20260501-ad5686-fixes-v5-0-0b2f45488418@analog.com>
	<20260501-ad5686-fixes-v5-3-0b2f45488418@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 01 May 2026 10:14:56 +0100
Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:

> From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> 
> Protect write access of pwr_down_mode and pwr_down_mask fields with
> existing mutex lock. Each channel exposes their own attributes for
> controlling powerdown modes and powerdown state. This fixes potential
> race conditions as those functions perform non-atomic read-modify-write
> operations to those pwr_down_* fields. This issue exists since the
> ad5686 driver was first introduced.
> 
> Fixes: c2f37c8dcadc ("iio: dac: New driver for AD5686R, AD5685R, AD5684R Digital to analog converters")
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
https://sashiko.dev/#/patchset/20260501-ad5686-fixes-v5-0-0b2f45488418%40analog.com

Reasonable concern about possible races in the read path leading to
-EPERM rather than simply the wrong value.

The other bit about not updating hardware is true but I think it's fine not to change
what powerdown mode we are in whilst powered down.
 
> ---
>  drivers/iio/dac/ad5686.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/iio/dac/ad5686.c b/drivers/iio/dac/ad5686.c
> index 076fe8b8bd85..69358dd66cbc 100644
> --- a/drivers/iio/dac/ad5686.c
> +++ b/drivers/iio/dac/ad5686.c
> @@ -39,6 +39,8 @@ static int ad5686_set_powerdown_mode(struct iio_dev *indio_dev,
>  {
>  	struct ad5686_state *st = iio_priv(indio_dev);
>  
> +	guard(mutex)(&st->lock);
> +
>  	st->pwr_down_mode &= ~(0x3 << (chan->channel * 2));
>  	st->pwr_down_mode |= ((mode + 1) << (chan->channel * 2));
>  
> @@ -77,6 +79,8 @@ static ssize_t ad5686_write_dac_powerdown(struct iio_dev *indio_dev,
>  	if (ret)
>  		return ret;
>  
> +	guard(mutex)(&st->lock);
> +
>  	if (readin)
>  		st->pwr_down_mask |= (0x3 << (chan->channel * 2));
>  	else
> 

