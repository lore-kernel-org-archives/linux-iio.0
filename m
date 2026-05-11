Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50BCA401A07;
	Mon, 11 May 2026 14:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778510833; cv=none; b=FjPf7j5/2kBGpTnrJU0cefgbFMjzVHNUzi0OHbWK4vLe9VerWh6hye67B/78s2vkgctdAvZWc2iUTxEZqe8UVKv+Q/x08LljH4N/oqRZHOh8qd65remGRJQITwkT/aNtlzz1Moyt4+h0HQalp2NkL6mo+poDe1i23ixVNe+BHXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778510833; c=relaxed/simple;
	bh=w97rHHXzCgZlCHZdDSnXzl1BQWICrWTzliY+FhIyrgY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WntShBJxPn1WB7UUPfFcqzIH+wt+WqfsL0goDV/4gVUSEllJt4hi13A/RuvagrEqea9N33rXyDUMYKnSCpYVhGdFVmvjuXpaSBO36K1XTrZj+y6h310AVdAlUy/f+rDgkXL0lULnvndDkg2lrSNsJuSyPRm95SKAO0VK/g/2hyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uF+hKFVz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uF+hKFVz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D835BC2BCB0;
	Mon, 11 May 2026 14:47:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778510832;
	bh=w97rHHXzCgZlCHZdDSnXzl1BQWICrWTzliY+FhIyrgY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uF+hKFVzmqycVAoxjIxqw/OAB6CD8ag9a+qSTJ9n4X6Ow13C1s+CQUNwwldvtXF/Y
	 mc/WXwbE7Gp83ndRdkiUPBfbznGA4us9/1xRWD8z7C3rTm38gbMwIK4r8XJrVULgdV
	 cMMUbnlcKYehmp5nNi0vxMRWVy9UKkno7NgSGYT/P/3tisdhA3CdCxabVQZ63AjRrx
	 YCsAcQqgpTyG0tNFTr6YIJUe1ZGkH4v5JeVN4gQB7CNYcvVqgdKJA4mw37DCPJorvJ
	 B7H9Ja6y8eT+2WhuVZ4BOFsrXuEI9Bx69vLqqw/isV1EUlzSCrMkr55eEBwY20YD6w
	 wvC+kgsIalYTA==
Date: Mon, 11 May 2026 15:47:04 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Stepan Ionichev <sozdayvek@gmail.com>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 gregkh@linuxfoundation.org, hcazarim@yahoo.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: gyro: bmg160: wait full startup time after mode
 change at probe
Message-ID: <20260511154704.76967b74@jic23-huawei>
In-Reply-To: <20260511064020.362-1-sozdayvek@gmail.com>
References: <20260511062755.30-1-sozdayvek@gmail.com>
	<20260511064020.362-1-sozdayvek@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 11 May 2026 11:40:20 +0500
Stepan Ionichev <sozdayvek@gmail.com> wrote:

> bmg160_chip_init() calls bmg160_set_mode(BMG160_MODE_NORMAL) and
> then waits only 500-1000 us. Per the BMG160 datasheet
> (BST-BMG160-DS000-07 Rev. 1.0, May 2013), the start-up and wake-up
> times (tsu, twusm) are 30 ms.
> 
> The same file already waits BMG160_MAX_STARTUP_TIME_MS (80 ms)
> in bmg160_runtime_resume() after the same set_mode(NORMAL)
> operation. The 500 us value at probe was likely a unit mix-up;
> the old comment said "500 ms" while the code used microseconds.
> 
> Reuse the same constant via msleep() and add a code comment
> explaining the datasheet basis for the wait. Without this,
> register writes that follow the mode change can hit the chip
> before it is ready.
> 
> Fixes: 22b46c45fb9b ("iio:gyro:bmg160 Gyro Sensor driver")
> Signed-off-by: Stepan Ionichev <sozdayvek@gmail.com>
Some process stuff.

Never send a new version in reply to the older one.  Always
a fresh thread - the reason is mainly that the threads become unreadable
if you got to more than one or two versions.

Also, don't send a new version for a reasonable period of time.
Something small like this maybe a few days, a bigger patch 1 week.

That lets multiple reviewers have time to take a look.
If you have a lot on list already then slow down in general and
spend some time helping to review patches coming from others.
The biggest bottleneck in IIO is reviewer time.

Anyhow, I'm going ignore this for a little while at least...

Jonathan

> ---
> v2:
> - Use msleep() instead of msleep_interruptible() so the wait is not
>   cut short by signals during probe (per Andy)
> - Add a code comment with the datasheet basis for the 80 ms wait
>   (per Andy)
> 
>  drivers/iio/gyro/bmg160_core.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/gyro/bmg160_core.c b/drivers/iio/gyro/bmg160_core.c
> index 38394b5f3..6d9019451 100644
> --- a/drivers/iio/gyro/bmg160_core.c
> +++ b/drivers/iio/gyro/bmg160_core.c
> @@ -258,8 +258,14 @@ static int bmg160_chip_init(struct bmg160_data *data)
>  	if (ret < 0)
>  		return ret;
>  
> -	/* Wait upto 500 ms to be ready after changing mode */
> -	usleep_range(500, 1000);
> +	/*
> +	 * Wait for the chip to be ready after switching to normal mode.
> +	 * The BMG160 datasheet (BST-BMG160-DS000-07 Rev. 1.0, May 2013)
> +	 * specifies a start-up / wake-up time (tsu, twusm) of 30 ms; use
> +	 * BMG160_MAX_STARTUP_TIME_MS (80 ms) as a safety margin, matching
> +	 * what bmg160_runtime_resume() already does.
> +	 */
> +	msleep(BMG160_MAX_STARTUP_TIME_MS);
>  
>  	/* Set Bandwidth */
>  	ret = bmg160_set_bw(data, BMG160_DEF_BW);

