Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB2C3161AD;
	Tue, 28 Apr 2026 15:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777389643; cv=none; b=sRHeq3gUTbq/IQDXykLekadeDMd45Iah+nNeuGu9NTgcsRzp/4Rr+khKiFI/xoXFfV6OQy8c7ZwvaXf4eMkmX/NLxhkqQeqyoBlzZjSaqP8Je9gMXG4ZqNfiVs+1nT7Ws1VdHoaNNjP81VsQW7D8iDKZcVS/gakmmfQf4Sg/dbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777389643; c=relaxed/simple;
	bh=CggzMjIeA+e8hXjEZmkODa52qYaAgk5qtENMsLM96hI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kB93YJ7wSrUuFH8M2XjB59MrD9kx/CUV4r2AXpegJD1TYTpuq5IQijpB8QI4XpzAa14Qdd4greUWjkk5B4QxlX89znDR8sBBkBmo0gsgBvvfVsfIy+05nAVljwJ6W5hTv9cwiic42/6Cme3oFWW7z6eI8U1fqBNEkIwsBZJ7ojM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OGRH/kZI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OGRH/kZI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F152C2BCB7;
	Tue, 28 Apr 2026 15:20:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777389643;
	bh=CggzMjIeA+e8hXjEZmkODa52qYaAgk5qtENMsLM96hI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OGRH/kZI02G62TtFEeySVXtVSCw22/Jei10DYnf5AuE42KDVlkdpu8L5g9TlMKkyZ
	 gO2uxjA4hebRXQSvu8IMP9xHRU9bUZGfz8IEwyE79cp9fnDxUCj0/h1+IeFxGwqLwS
	 6rzwsZwaBliopPWNrC5cH3SjXXlyOfqeHGtsMYX8LQQrvMxmgjzh0DtRUte07NaSBk
	 TntnWKDetScgaEvWH1K4aLLTukWcDCGCO5ZeeNVl//6sElRAo2NmsGikx5YhwDSR1d
	 nqafvMJyc9Wvd8gFQpVtdbY2YupgcL+y7fqK+Ki24mIFCeMVPRjwBw1dr41C1W/uju
	 /ndirG2/4SBng==
Date: Tue, 28 Apr 2026 16:20:34 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org>
Cc: joshua.crofts1@gmail.com, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/5] iio: light: si1133: use guard(mutex)() macro
Message-ID: <20260428162034.108fe4d1@jic23-huawei>
In-Reply-To: <20260428-si1133-checkup-v2-5-70ad14bfefe2@gmail.com>
References: <20260428-si1133-checkup-v2-0-70ad14bfefe2@gmail.com>
	<20260428-si1133-checkup-v2-5-70ad14bfefe2@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 28 Apr 2026 15:18:37 +0200
Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org> wrote:

> From: Joshua Crofts <joshua.crofts1@gmail.com>
> 
> Remove mutex_lock()/mutex_unlock() and goto instances and add
> guard(mutex)() macro to modernize driver and improve mutex handling.
> 
> Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
One comment that is more about the existing code than the changes here, but
as you are touching it nice to clean that bit up!

Nice series,

Jonathan

> ---
>  drivers/iio/light/si1133.c | 18 +++++++-----------
>  1 file changed, 7 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/iio/light/si1133.c b/drivers/iio/light/si1133.c
> index f2a79675c026c86bb56d85a65cd035d7540d0ef8..3b40defda383bcbe731dc0b413903e0267f03b01 100644
> --- a/drivers/iio/light/si1133.c
> +++ b/drivers/iio/light/si1133.c
> @@ -8,6 +8,7 @@
>  
>  #include <linux/array_size.h>
>  #include <linux/bitops.h>
> +#include <linux/cleanup.h>
>  #include <linux/completion.h>
>  #include <linux/delay.h>
>  #include <linux/dev_printk.h>
> @@ -392,7 +393,7 @@ static int si1133_command(struct si1133_data *data, u8 cmd)
>  	int err;
>  	int expected_seq;
>  
> -	mutex_lock(&data->mutex);
> +	guard(mutex)(&data->mutex);
>  
>  	expected_seq = (data->rsp_seq + 1) & SI1133_MAX_CMD_CTR;
>  
> @@ -403,19 +404,17 @@ static int si1133_command(struct si1133_data *data, u8 cmd)
>  	if (err) {
>  		dev_warn(dev, "Failed to write command 0x%02x, ret=%d\n", cmd,
>  			 err);
> -		goto out;
> +		return err;
>  	}
>  
>  	if (cmd == SI1133_CMD_FORCE) {
>  		/* wait for irq */
>  		if (!wait_for_completion_timeout(&data->completion,
> -			msecs_to_jiffies(SI1133_COMPLETION_TIMEOUT_MS))) {
> -			err = -ETIMEDOUT;
> -			goto out;
> -		}
> +			msecs_to_jiffies(SI1133_COMPLETION_TIMEOUT_MS)))
> +			return -ETIMEDOUT;
This is some unfortunate indentation from readability point of view.
I'd reindent and not worry about the long line - it's very long but still under 100 so
tools won't complain and I think it is worth the pain here!

>  		if (!wait_for_completion_timeout(&data->completion,
						 msecs_to_jiffies(SI1133_COMPLETION_TIMEOUT_MS)))
			return -ETIMEDOUT;

or perhaps better yet, use a local variable for that timeout.


>  		err = regmap_read(data->regmap, SI1133_REG_RESPONSE0, &resp);
>  		if (err)
> -			goto out;
> +			return err;
>  	} else {
>  		err = regmap_read_poll_timeout(data->regmap,
>  					       SI1133_REG_RESPONSE0, resp,
> @@ -428,7 +427,7 @@ static int si1133_command(struct si1133_data *data, u8 cmd)
>  			dev_warn(dev,
>  				 "Failed to read command 0x%02x, ret=%d\n",
>  				 cmd, err);
> -			goto out;
> +			return err;
>  		}
>  	}
>  
> @@ -439,9 +438,6 @@ static int si1133_command(struct si1133_data *data, u8 cmd)
>  		data->rsp_seq = expected_seq;
>  	}
>  
> -out:
> -	mutex_unlock(&data->mutex);
> -
>  	return err;
>  }
>  
> 

