Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3E635504D;
	Fri, 22 May 2026 15:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779463036; cv=none; b=U78qp34MNWseYoCNYnLIFJhm6gd+uZl0M5fFp5fjkScoMICoPPw2L7DeYgpz/SxtkgapYZXKmbVGzLKx5xBSdQ6QQMTUNp7NRMYAhvolDpAEgQrKlfB0UBC+9N9TwipgOIyi+lLkoAkP6D4DmO/r62S5g15SnEaca8J9rLi6U74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779463036; c=relaxed/simple;
	bh=xFErot9MuC0Beo4FE1fjTafhNzDBCOrgi1VqQlY56ds=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rTpz17zbfK733qQdn/9rsEJpSCzWeOwVRBZ3/965u32HF4X3CKY5XmmRaJXNMQi/uwxKFpinhPgUO1Wl9ch1xkQXHS3X65mBTnyFLJnhyM4iuprbd95xcLHemYouIVf+uYyqKd0UthxK1Xm+Ejut1HsoFQNho3z9FnkJtLTGIq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fFDJjUNW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fFDJjUNW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 434A61F00A3D;
	Fri, 22 May 2026 15:17:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779463024;
	bh=6e5k5Tewn48ms5gmW1BHQPKXS79ZUvoDF36RqZ5Eoyg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=fFDJjUNWYMkY2usmxy9VuKo0fosl5NGQVA3lrMUtGUFoTH1aZkHJFIbpNkRPs5Fz0
	 WZkdu7vtcGlExrJn8PQcNBsvfi5UlYnE13xg0oK6ojTWgKLYX1qpQ048JzlHigFRAU
	 fP4tItkj8HtX1y/hORDHZohBQB+SA7kTZp67bazMUus6cUn4USVJqmn/AhARDJ5n0g
	 zsKppbzSvNdErngLdtQHj/iWL5WONgh4LxGGvo1aBV/xEJiSft5QX5psa9p/EJYQvz
	 ODr2HOqLFLl8RJzJWH1OWCVhn04uub7u3HXPk9pBgO6BrKGOyJtGV2AdQNTs4LdFjj
	 7jRF+T7FDuZdA==
Date: Fri, 22 May 2026 16:16:55 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Gabriel Rondon <grondon@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 andy@kernel.org, nuno.sa@analog.com, dlechner@baylibre.com
Subject: Re: [PATCH v2] iio: accel: bmc150: use guard(mutex) for mutex
 handling
Message-ID: <20260522161655.77d40513@jic23-huawei>
In-Reply-To: <20260520101247.64458-1-grondon@gmail.com>
References: <20260520101247.64458-1-grondon@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 20 May 2026 11:12:47 +0100
Gabriel Rondon <grondon@gmail.com> wrote:

> Replace manual mutex_lock()/mutex_unlock() pairs with guard(mutex)
> and scoped_guard() from cleanup.h. This simplifies error paths by
> removing the need for explicit unlock calls before returning.
> 
> Most converted functions hold the lock for their entire body, so
> guard(mutex) applies directly. bmc150_accel_trigger_handler() only
> holds the lock around a single register read, so scoped_guard() is
> used there to keep the lock scope unchanged.
> 
> Signed-off-by: Gabriel Rondon <grondon@gmail.com>
So sashiko reports a load of preexisting issues (I haven't checked them
but it tends to be right most of the time). It spotted one issue in your
changes that i missed.

The only other 'this patch' thing was scoped_guard() + gotos. The particular
case you have is fine so don't worry about that.


>  static ssize_t bmc150_accel_get_fifo_state(struct device *dev,
> @@ -860,13 +848,10 @@ static ssize_t bmc150_accel_get_fifo_state(struct device *dev,
>  {
>  	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>  	struct bmc150_accel_data *data = iio_priv(indio_dev);
> -	bool state;
>  
> -	mutex_lock(&data->mutex);
> -	state = data->fifo_mode;
This cast an integer to a bool.   So 0x40 -> true.
> -	mutex_unlock(&data->mutex);
> +	guard(mutex)(&data->mutex);
>  
> -	return sysfs_emit(buf, "%d\n", state);
> +	return sysfs_emit(buf, "%d\n", data->fifo_mode);
This will just print that 0x40 (in decimal) whereas should be 0 or 1.
I'd suggest data->fifo_mode ? 1 : 0 in this call.

>  }
>  

