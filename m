Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01FD3279DC2;
	Sun, 23 Aug 2026 22:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787525312; cv=none; b=rCCpk9OEWjEIjBVOg3llyfoPl3X8ObjyVxJcjNcNYmdNaWp9hghX6ZbKnZHzzaN/Wn3li5d6R7MjPeYD7oqI3LDr/I9lvHUmF/tIL2jb6Xq+a9ilIvf007Y1N8S6QJicc4Hby6XeutjFyK6sM0z9p/VYTH72QTFir2bWoZM4eHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787525312; c=relaxed/simple;
	bh=aBy2YdENLEfC8k++/2mHGaQmZTc7h/Perlhm8nSmlzY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OOF2IMFzhNJ1tO+X9s2RT6UnlTbO6ulUCREWO0xy5T1P1hpoel4wCNZmA+hdL7bpp82pE0u6owFoOkKH/kViRVVuUAWaSj9FnWfc+STgh5Pozne81VYaNVtGDZSFuswo/REy999iPg0gG7fiR/7QDw0vz6u3ZSBoK5m68ek/zT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gk7aEEd4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gk7aEEd4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E3791F000E9;
	Sun, 23 Aug 2026 22:48:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787525310;
	bh=06UrUW0ZxWHyM6Kw190JC+te5jtEJc2BbLww5GLod6E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Gk7aEEd4LgfN/GOF/msALhTsdLjGd2ilf4LyErY7Qw87LGNmF15+zcfxnA1vuHFSB
	 k1KQrk4ycUumb0oVcP1JwJjGr66l0RzNTxqu81l0KebRdzwRRYQBueGKlF6a6jzRIh
	 1QBtOrozrnLS3z34s0WdpxrvniP/BlGY95ViQNz7v7JUoOUTvlx6gtRhpEKBXf831T
	 yyCm1CDzIF0E0bLURN3P8xRJfaPuIamKKQoLsDWfTeo8pajwedeaHpMBRZloossMtL
	 bKZz4JaW3G1+PcZitkIyP9Kf7wOOuDjtRAFsS0f/l8oV9fh4ba38Zwoy/OsY9cdNlj
	 kOZCDrw8Cd3ww==
Date: Sun, 23 Aug 2026 23:48:27 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Rishab Madhugiri <rishab.madhugiri@gmail.com>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: core: Avoid BUG() on invalid clock types
Message-ID: <20260823234827.13732ead@jic23-huawei>
In-Reply-To: <20260823222502.30764-1-rishab.madhugiri@gmail.com>
References: <20260823222502.30764-1-rishab.madhugiri@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 23 Aug 2026 22:25:02 +0000
Rishab Madhugiri <rishab.madhugiri@gmail.com> wrote:

> Replace deprecated use of BUG() in default switch cases of
> iio_get_time_ns() and current_timestamp_clock_show() with
> WARN_ONCE() and return correct fallback or error codes.

This is there just to stop compilers moaning that we didn't handle
all the possible values in the switch statement.  We can't actually
hit the BUG() unless we have a very unexpected bug or random memory
corruption.

So sure, lets move to the new way of handling these paths.

However, they aren't supposed to be possible. So
WARN_ON_ONCE() and no message is fine for these.

Jonathan

> 
> Signed-off-by: Rishab Madhugiri <rishab.madhugiri@gmail.com>
> ---
>  drivers/iio/industrialio-core.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index 767a7794624a..c0411a29fe3f 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -341,7 +341,8 @@ s64 iio_get_time_ns(const struct iio_dev *indio_dev)
>  	case CLOCK_TAI:
>  		return ktime_get_clocktai_ns();
>  	default:
> -		BUG();
> +		WARN_ONCE(1, "Invalid clock type selected for IIO device\n");
> +		return 0;
>  	}
>  }
>  EXPORT_SYMBOL(iio_get_time_ns);
> @@ -1518,7 +1519,8 @@ static ssize_t current_timestamp_clock_show(struct device *dev,
>  	case CLOCK_TAI:
>  		break;
>  	default:
> -		BUG();
> +		WARN_ONCE(1, "Invalid clock type selected for IIO device\n");
> +		return -EINVAL;
>  	}
>  
>  	return sysfs_emit(buf, "%s\n", clock_names[clk]);

