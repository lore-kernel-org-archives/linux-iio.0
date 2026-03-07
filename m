Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8807A328251;
	Sat,  7 Mar 2026 17:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772904251; cv=none; b=h1lhLQtJnNX+5z/AFOD5v3UHMXjzgcFfwV62JZW87HDJ5XxePm9d/zJNs/RlJAImafrdyApD2ovlITvgrdikHmsfP4YQQFb6i1fnb3WHzrrJ/RYasqxyHRRPNzwrWk0xtH/Jop+kho3NJ+Yy3J9PzCEEZTFT6s5BhfwWZ/GPzT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772904251; c=relaxed/simple;
	bh=JM5fYJ+rgmbAUPI4WjrxUH9fTXZHs8qFvKU6I5Y8PTk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S4E3kwcmly3Lt2g/qDhowaHKSV98BV2D8teuh2Z4Y/VO9jPcT0mS63zh6y3TV7UVZ1EeXC2jzPfQinqn8u+pXaqSjPssN3TNx2nOImh/nlwdvEOKoiJC1cF6owx/zF/wkv6Ff97MWc/JEoY60YChGqfZTtdWuu5zKVAmImUVNhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rEVUzuQG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rEVUzuQG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 194D5C19422;
	Sat,  7 Mar 2026 17:24:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772904251;
	bh=JM5fYJ+rgmbAUPI4WjrxUH9fTXZHs8qFvKU6I5Y8PTk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rEVUzuQGIBKyjxOR1OM3+nyBCu6qu/cbnjVl9sDFD6ynL8zQN7GMYzZPFpW/3P6Zz
	 left7aoU+ojcsrarfruTtijxLY7JoEulSOOoGwKvLshuV7XBcs4Fg42luGUsUQ9Nkc
	 MCjCeNos28JouoL4qjBgAjV48PFcj0jQ2mn7Yq0o1FsviSqj8IYJUfft3CxS+frBle
	 1V+FulZtb3xab/MLYLlODbgzXZcqYM4byQF0zunazQnwJelF8nJF44yephk6ahjO1H
	 yNBB9ElWXOk0tAMVdigEFlCBJDgOsp0px7dGWmPSyB/mx0IovJmIPXHwCe7D2vl/VM
	 Koe0ZMhE+LYmg==
Date: Sat, 7 Mar 2026 17:24:02 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Shi Hao <i.shihao.999@gmail.com>
Cc: andriy.shevchenko@intel.com, andy@kernel.org, dlechner@baylibre.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 marcelo.schmitt@analog.com, mazziesaccount@gmail.com, nuno.sa@analog.com
Subject: Re: [PATCH v2 1/6] iio: accel: fix spelling mistakes in comments
Message-ID: <20260307172402.69c0e96a@jic23-huawei>
In-Reply-To: <20260307104705.49129-2-i.shihao.999@gmail.com>
References: <20260307104705.49129-1-i.shihao.999@gmail.com>
	<20260307104705.49129-2-i.shihao.999@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat,  7 Mar 2026 16:17:00 +0530
Shi Hao <i.shihao.999@gmail.com> wrote:

Where it is just one spelling, good to say that in the patch title.

iio: accel: Fixing spelling and capitalisation of Celsius.


> Fix incorrect spelling in comments
> - celcius -> celsius

I'm going to put my fussy hat on give we are fixing this sort of thin.
Should be "degree Celsius"

Reflects that it is named after Anders Celsius

Thanks for tidying this up.

Jonathan


> 
> Signed-off-by: Shi Hao <i.shihao.999@gmail.com>
> ---
>  drivers/iio/accel/adis16201.c | 2 +-
>  drivers/iio/accel/adis16209.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/accel/adis16201.c b/drivers/iio/accel/adis16201.c
> index 5127e58eebc7..87ad843d1e49 100644
> --- a/drivers/iio/accel/adis16201.c
> +++ b/drivers/iio/accel/adis16201.c
> @@ -147,7 +147,7 @@ static int adis16201_read_raw(struct iio_dev *indio_dev,
> 		/*
> 		 * The raw ADC value is 1278 when the temperature
> 		 * is 25 degrees and the scale factor per milli
> -		 * degree celcius is -470.
> +		 * degree celsius is -470.
> 		 */
> 		*val = 25000 / -470 - 1278;
> 		return IIO_VAL_INT;
> diff --git a/drivers/iio/accel/adis16209.c b/drivers/iio/accel/adis16209.c
> index 41ffd92f27fd..c9f34e2824ab 100644
> --- a/drivers/iio/accel/adis16209.c
> +++ b/drivers/iio/accel/adis16209.c
> @@ -186,7 +186,7 @@ static int adis16209_read_raw(struct iio_dev *indio_dev,
> 		/*
> 		 * The raw ADC value is 0x4FE when the temperature
> 		 * is 45 degrees and the scale factor per milli
> -		 * degree celcius is -470.
> +		 * degree celsius is -470.
> 		 */
> 		*val = 25000 / -470 - 0x4FE;
> 		return IIO_VAL_INT;
> --
> 2.53.0

