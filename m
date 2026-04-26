Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DCFA3559CA;
	Sun, 26 Apr 2026 13:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777211401; cv=none; b=QPv5QQSTctQsQD7VMqhoJk33fFcksU+QtpOLnHYpftUBSOaDYR/RihzU3u+KVUsS3K7Ux8YvqQjUqR5OQqIq249FRrkfvS9Tv49qXi0B5CVfe/mWP92KVYXH8qjQV9p76jydgOIPgg3mr8MPJe1/vSClcSdreUhpGYQ3m/w3rko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777211401; c=relaxed/simple;
	bh=duRQVM0UxCply4DdkKMA2wJkrLYL++QOA2UmD6E7NLM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uYvk0SUvUmfLX/ApmS2YZBgvUo1cQ/H2tfWs4tjqBT/DapjygeKspE+FMmNM40BIdwdmDwdX4Z+hC7OiNKieeWHMDoxxyK1TPTktMHRGstJw1S2GeA5BTWr16vPDQvJqYXiTu0C2g10dmunY4NAV8GqNXmTHhIj0NCC6PsUlCmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PaaY39F9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PaaY39F9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B953BC2BCAF;
	Sun, 26 Apr 2026 13:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777211401;
	bh=duRQVM0UxCply4DdkKMA2wJkrLYL++QOA2UmD6E7NLM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PaaY39F9xK3Xf6xKKKCfeQIb4PH3AOpin7CReDMAb/lgKpN/XqGDe4HRuf+2jTfOx
	 GaYW6K5xCNxoEcrvleqgIqoU0Uo3K9YfVBgocbx4cFdHcYCHn/OnuUcwr5Ajb9kIqF
	 xFpaIwk0NHC9pxHUTxDjoru4NTXqYa+Es8wL8LrkS4UmRUkwPvXdJrfQUuEnBlOdiz
	 p4FGH8pTQ5GrWcMYnk8mytrxramxqXygWVdezEVq6bFkYN0V4V6KSfkM3CwZ8rYYi8
	 rV7u+Yr3MTfio+KaQffX3wKYdv7ALlDicYOV5I5KCSa1hEs7E5haSnZeeMMWAduIzX
	 VLU4L33kkmeTg==
Date: Sun, 26 Apr 2026 14:49:51 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Rodrigo Alencar via B4 Relay
 <devnull+rodrigo.alencar.analog.com@kernel.org>
Cc: rodrigo.alencar@analog.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Stefan Popa <stefan.popa@analog.com>,
 Jonathan Cameron <jic23@cam.ac.uk>, Greg Kroah-Hartman <gregkh@suse.de>,
 Michael Auchter <michael.auchter@ni.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, David
 Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH 08/10] iio: dac: ad5686: fix input raw value check
Message-ID: <20260426144951.5e258ecd@jic23-huawei>
In-Reply-To: <20260426-ad5686-fixes-v1-8-7c946a77794e@analog.com>
References: <20260426-ad5686-fixes-v1-0-7c946a77794e@analog.com>
	<20260426-ad5686-fixes-v1-8-7c946a77794e@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 26 Apr 2026 09:38:09 +0100
Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:

> From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> 
> Use in_range() to fix range check for input raw value, which is off by
> one, i.e., for a 10-bit DAC the max valid value is 1023, but 1 << 10
> equals 1024, which passes the previous check, allowing an out-of-range
> write. The issue exists since the ad5686 driver was first introduced.
> 
> Fixes: c2f37c8dcadc ("iio: dac: New driver for AD5686R, AD5685R, AD5684R Digital to analog converters")
> Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
> ---
>  drivers/iio/dac/ad5686.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/dac/ad5686.c b/drivers/iio/dac/ad5686.c
> index 040a24c62c9a..ab498ec2ed5c 100644
> --- a/drivers/iio/dac/ad5686.c
> +++ b/drivers/iio/dac/ad5686.c
> @@ -186,7 +186,7 @@ static int ad5686_write_raw(struct iio_dev *indio_dev,
>  
>  	switch (mask) {
>  	case IIO_CHAN_INFO_RAW:
> -		if (val > (1 << chan->scan_type.realbits) || val < 0)
> +		if (!in_range(val, 0, 1 << chan->scan_type.realbits))
>  			return -EINVAL;
Fix to >= rather than in_range()

Using in_range when we have a start of 0 is overly complex.

>  
>  		return st->write(st, AD5686_CMD_WRITE_INPUT_N_UPDATE_N,
> 

