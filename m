Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA91379EF0;
	Mon, 11 May 2026 12:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778501164; cv=none; b=u/zLlVXfe6W4Vpqp4r51AjOIkW3clEkl84saxymeO8WH4Aro3q4fRge34fd1lD3fQeJjL+kAJmpNyg2/LvnLOsMFmVm5HVZvTro8Gcn9HIYN58Igmt+nHtKroVrk4aXFDWpXGIVba8Eu+wtUUuG1EBpr8XqGOh5iXQW2+G2qp3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778501164; c=relaxed/simple;
	bh=ZO5R05G6rcDIHFBYYB9LzKVwdsRdJedyJ8AxFS0LzHk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LI6lQQ9jMly7XJHgTe1wiPf6Gwz41IuCJtZIaaZXfKavm7iS8BPGHKhlRhM0VnoQ5vWqYUbkPjOHrGwHFbF3NA3iQ8NincwzKYduYSJO1vnALmJd2i8WuydnZEpkuCedyWMkUE7VH9Y3eLRPb8RIxjSVfYdRLAGtdRMex42/yfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i8SC24ql; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i8SC24ql"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 791D6C2BCB0;
	Mon, 11 May 2026 12:06:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778501164;
	bh=ZO5R05G6rcDIHFBYYB9LzKVwdsRdJedyJ8AxFS0LzHk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=i8SC24qleFkI4allKcqttX4IhpU+6+UueqG3x6nOKVeUPsI8wJGWwhtj6bpji3pkK
	 1KfSKawrBkEoHIt5R9unfr072E12g2srmu5IQd9ekT0iDS7wrZGGQ0JDLtd9XdK/zO
	 k52Cw0HP76DGA7gCuh7Kh5Yl08xPqkZeVm1dW/peFCi2UQyfmiB1clVGuYbPHUwDrs
	 CYkXQgTWFZaSz4sxgYUnQukH985nTK79O2SZr9UaTUqb8PLMIpjY7o4wNYOoiHEjj8
	 1QxYYOSl9RUXwMg/U6tSTfKSG/qH934nhsC9cioBR8zLjoCL2fstVbWG/ax13bEHiU
	 FFFC6L0zDz6Nw==
Date: Mon, 11 May 2026 13:05:55 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Maxwell Doose <m32285159@gmail.com>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: chemical: scd30: Prevent potential
 divide-by-zero errors
Message-ID: <20260511130555.2eec64a3@jic23-huawei>
In-Reply-To: <20260510202154.319585-3-m32285159@gmail.com>
References: <20260510202154.319585-3-m32285159@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 10 May 2026 15:21:56 -0500
Maxwell Doose <m32285159@gmail.com> wrote:

> In scd30_read_raw, the current value of tmp in the
> IIO_CHAN_INFO_SAMP_FREQ case is unchecked. Add checking to see if the
> value we got was 0 to prevent a divide-by-zero error.
> 
> A similar case has also been found in scd30_write_raw(), also in the
> IIO_CHAN_INFO_SAMP_FREQ case, where the value of val2 was unchecked.
> Add checking for that variable as well and return -EINVAL if it's 0.
> 
> Fixes: 64b3d8b1b0f5 ("iio: chemical: scd30: add core driver")
To me this one is a hardening change not a bug fix (unless we have
reports of this hardware failure on a real product - not a devboard
with dodgy wiring ;)

So no fixes tag needed.

Also there is already a fix for the write_raw one in my fixes-togreg
branch. Antoniu got there a few weeks back.

Jonathan



> Signed-off-by: Maxwell Doose <m32285159@gmail.com>
> ---
>  v2:
>  - Switch to dev_err_ratelimited() per sashiko.
>  - Fix another potential divide-by-zero error per sashiko (see commit
>    message).
> 
>  drivers/iio/chemical/scd30_core.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/chemical/scd30_core.c b/drivers/iio/chemical/scd30_core.c
> index be8c055be184..3851c9334c8b 100644
> --- a/drivers/iio/chemical/scd30_core.c
> +++ b/drivers/iio/chemical/scd30_core.c
> @@ -237,6 +237,16 @@ static int scd30_read_raw(struct iio_dev *indio_dev, struct iio_chan_spec const
>  		if (ret)
>  			return ret;
>  
> +		/*
> +		 * Value of 0 is unexpected but possible if hardware is failing
> +		 * or noise on data bus
> +		 */
> +		if (!tmp) {
> +			dev_err_ratelimited(&indio_dev->dev,
> +					    "Invalid measurement interval 0 received\n");
> +			return -EIO;
> +		}
> +
>  		*val = 0;
>  		*val2 = 1000000000 / tmp;
>  		return IIO_VAL_INT_PLUS_NANO;
> @@ -261,7 +271,7 @@ static int scd30_write_raw(struct iio_dev *indio_dev, struct iio_chan_spec const
>  	guard(mutex)(&state->lock);
>  	switch (mask) {
>  	case IIO_CHAN_INFO_SAMP_FREQ:
> -		if (val)
> +		if (val || !val2)
>  			return -EINVAL;
>  
>  		val = 1000000000 / val2;

