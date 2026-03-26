Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E9C3A6414;
	Thu, 26 Mar 2026 20:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774556983; cv=none; b=Iz0nLDYxFdPS31HofxFe3ZxwUXk5Ei/ddKfomHDCWE5+qvR2M8BpkLbREOdC9KB35DuTfnjA87dATgGZAGioFPPqwr6kHFzxq9V/v/8GRtM2jV9CALyetab+OrYQ4BwunGkZLxq0LVHPjUVn0QkSOxpLGu33z6JMdUnwIF1sbzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774556983; c=relaxed/simple;
	bh=+5HtaPXgncHoPTKPpgQX0ebqh9DlexC5Jm5bZcnIwdE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EZuw+UHeqoqIu1R70jmctAsUzSuppqXdKHKAxSxBvJHZZ1GkhB2Io0+FIXWh4EerQ9PbaYSxequDp2ErHn3ywKsQEykMwHpBXUq9mI1HAQpxOFTSCPMOlNCKqwsEBxjMx1JReR83/MXIRV9uYv7V2jG1i/qo7/iQ92eYi9MW4bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RyVTygID; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RyVTygID"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29F6AC2BCB4;
	Thu, 26 Mar 2026 20:29:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774556983;
	bh=+5HtaPXgncHoPTKPpgQX0ebqh9DlexC5Jm5bZcnIwdE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RyVTygIDK54P2hJpBfRMI5qBvcBhRkHY8L1XvEFIk9p9BDq4mF1rbWYI3lAJJpP5F
	 5t36REGOx3Y5199Vdb67smxmXQ8ZBNxmpi3AzIedWoYNIqYSys2qQgdqc7OhmXzYzc
	 vOVzmlOQPzl4pQXkwiLnkU6BLaBQijnhSd7WKzu/S0wHOAMAvsFbmetgJlyzv6rVfU
	 MmJYt0E6xBsuu9YVEOOaojAgghKl03PUieJG038kw03ZBflMFclPLkR/LvdhxYxSSW
	 pOwGTGoKC83lnYhqRlkYMOx5mYky2l169ebPzceikJHXGJwc3NkxJu603gbIlj+63f
	 SFUTOBlP0Pvqg==
Date: Thu, 26 Mar 2026 20:29:36 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Aldo Conte <aldocontelk@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Javier Carrasco
 <javier.carrasco.cruz@gmail.com>
Subject: Re: [PATCH v2] iio: light: veml6070: fix veml6070_read() return
 value
Message-ID: <20260326202936.0bd34713@jic23-huawei>
In-Reply-To: <20260326163808.21404-1-aldocontelk@gmail.com>
References: <20260326163808.21404-1-aldocontelk@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 26 Mar 2026 17:38:08 +0100
Aldo Conte <aldocontelk@gmail.com> wrote:

> veml6070_read() computes the sensor value in ret but
> returns 0 instead of the actual result. This causes
> veml6070_read_raw() to always report 0.
> 
> Return the computed value instead of 0.
> 
> Running make W=1 returns no errors. I was unable
> to test the patch because I do not have the hardware.
> Found by code inspection.
> 
> Fixes: fc38525135dd ("iio: light: veml6070: use guard to handle mutex")
> Signed-off-by: Aldo Conte <aldocontelk@gmail.com>
> 
Thanks for resend but as I replied (late) to your question its
already queued with the tag fixed:
https://web.git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/commit/?h=fixes-togreg

> ---
> 
> v2:
> - Fix correct commit in Fixes tag
> ---
>  drivers/iio/light/veml6070.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/light/veml6070.c b/drivers/iio/light/veml6070.c
> index 6d4483c85f30..74d7246e5225 100644
> --- a/drivers/iio/light/veml6070.c
> +++ b/drivers/iio/light/veml6070.c
> @@ -134,9 +134,7 @@ static int veml6070_read(struct veml6070_data *data)
>  	if (ret < 0)
>  		return ret;
>  
> -	ret = (msb << 8) | lsb;
> -
> -	return 0;
> +	return (msb << 8) | lsb;
>  }
>  
>  static const struct iio_chan_spec veml6070_channels[] = {

