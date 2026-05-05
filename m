Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33ECA31F987;
	Tue,  5 May 2026 11:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777979311; cv=none; b=Oe54MuEPInfZftJ8qIdnlO/I7XCkFJBLv8xVUG2lAMNt6T8zjDdEw1ppgXGhTUAIFpOBHNH3/+RWkfR2dZDNPfJkqj5zjS1SrRxeJzWT7w9HqSsEJiWHFhw/6n/U+BNW2fXcO2bF/ltd/IBD5rIia+GUOv79As1aINtkWt7qtI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777979311; c=relaxed/simple;
	bh=o0s0M585ngWapwzuF4EwGYZM5CO4qnlGb1y7qHJlrZo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AOMh8FqN5D6j2nMx6XbuY8ZT3WA/z4SH5ikHXiN46QO3nGMGu3jdu/8g5EhG3eQxAQbPuxKKSvqJoRM/V7QBzFSQ1qLATP5k6m99Ohy0WyngPtChuJbBDLMy7w3CzKRauHEdx9sqNUZ6Ifpa5wLFLYiurFiDAtnS/5tdTM5CA3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jIur0VWW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jIur0VWW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7221EC2BCB4;
	Tue,  5 May 2026 11:08:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777979310;
	bh=o0s0M585ngWapwzuF4EwGYZM5CO4qnlGb1y7qHJlrZo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jIur0VWWQpU9TmWZ5kKjGemgI6JOKP9457wb5j4arjt1u2U4odd+IBc0wWcV3D74o
	 hMrPgWUK3MJx0WhWSXqzp7ymkhbQ9jb4FSfMkdCIZWrvqWSAWnW0gDbG0KIPf5jS21
	 EAercRSSuxeb0gN6GCZcDwl0zQNqmo51qcbZi8RXNP4lIqsmghZ0l4WW8wCf144bnI
	 j4amm3WkAihBqq+J2NGbObe3R3xk1XCw7r3BMOjuvdcm7C6N9of+HmVPTUZ84iqQCh
	 41YWUqVB0RcnasmKUiErhLh/bNx76/tYf/wierRUbPANt1B3+GdXAkbi1ApeXvd9nB
	 TNFqvugZe/+dA==
Date: Tue, 5 May 2026 12:08:21 +0100
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
Subject: Re: [PATCH v5 02/12] iio: dac: ad5686: fix input raw value check
Message-ID: <20260505120821.28b6ee3f@jic23-huawei>
In-Reply-To: <20260501-ad5686-fixes-v5-2-0b2f45488418@analog.com>
References: <20260501-ad5686-fixes-v5-0-0b2f45488418@analog.com>
	<20260501-ad5686-fixes-v5-2-0b2f45488418@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 01 May 2026 10:14:55 +0100
Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:

> From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> 
> Fix range check for input raw value, which is off by one, i.e., for a
> 10-bit DAC the max valid value is 1023, but 1 << 10 equals 1024, which
> passes the previous check, allowing an out-of-range write. The issue
> exists since the ad5686 driver was first introduced.
> 
> Fixes: c2f37c8dcadc ("iio: dac: New driver for AD5686R, AD5685R, AD5684R Digital to analog converters")
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
Applied this patch to the fixes-togreg branch of iio.git and marked for
stable.

Thanks,

Jonathan

> ---
>  drivers/iio/dac/ad5686.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/dac/ad5686.c b/drivers/iio/dac/ad5686.c
> index 1fc54c38b629..076fe8b8bd85 100644
> --- a/drivers/iio/dac/ad5686.c
> +++ b/drivers/iio/dac/ad5686.c
> @@ -154,7 +154,7 @@ static int ad5686_write_raw(struct iio_dev *indio_dev,
>  
>  	switch (mask) {
>  	case IIO_CHAN_INFO_RAW:
> -		if (val > (1 << chan->scan_type.realbits) || val < 0)
> +		if (val >= (1 << chan->scan_type.realbits) || val < 0)
>  			return -EINVAL;
>  
>  		mutex_lock(&st->lock);
> 

