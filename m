Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A57429D26E;
	Sat, 28 Feb 2026 16:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772295309; cv=none; b=JuNsV7Bg3zsQhFy7eaHCJLxDgG+ZekifzwLuewRd3muaHBpFr0mM48FdIBqfbsSsbQZDf/k6FNKDne+FJGJ7y+pmo0ZMHMOys8yw1ZCRCMn0TQMy+e/ZnMMf+WjbXHkpYA8N55Q2lD77ebBtu2TGqpWzR7JNbF2DOw6pQID0+D8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772295309; c=relaxed/simple;
	bh=HLLi1WVYPw0+iXMZSoXqfnTTY5WAhrtAzgTkqknp/SE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pJgI7vXSvNg3ZrOtFhLGXH8leL3r6xuLA2WA1NuqO9YXjIPdc6e49mJYn66QXeJT9KQCUb+XMg2+iO2Z/XlUrgY+upvONy3luk5w4vtpZrLSNqOgevtLFU221YHnEwwN/bGg4hjLfctJuXCVysqmDUzVAH1oThFJFPbAliqLnss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bBUjdm57; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bBUjdm57"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FD7AC116D0;
	Sat, 28 Feb 2026 16:15:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772295309;
	bh=HLLi1WVYPw0+iXMZSoXqfnTTY5WAhrtAzgTkqknp/SE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bBUjdm57QBfIvO7LwqQ2tKrSYdpHm9RoAm1oMxqlv/XWJ1vgHGp9lNw1CxUAWoKGR
	 InSaAW+/nNa8CfK6eXuIwOe5jyObrE22bSO0IqrUXrBGrJDmNzkuLLw1FrHbvbEus3
	 DqnhWIdLwiREpRO8kwCG+mCUjPaq9RsUS54cQ1fpkeAYhB9jZXiFDjnYzlHnFmhjiY
	 EApW9E3IRu4nLfIUleGhlTT+7pLivVHoXqw34t6vaQhNL27gYy5YZ7yR+AdqQSK4xH
	 CthocDfTa/FdU8JnQwe59DKUIrX14m0ieOjNLYiIn6Usb3PVT4gyBanqlL9lekU9Oj
	 dhvq8hfGmnhKg==
Date: Sat, 28 Feb 2026 16:14:58 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Taha Ed-Dafili <0rayn.dev@gmail.com>
Cc: linux-iio@vger.kernel.org, dlechner@baylibre.com, rdunlap@infradead.org,
 skhan@linuxfoundation.org, nuno.sa@analog.com, andy@kernel.org,
 corbet@lwn.net, lars@metafoo.de, Michael.Hennerich@analog.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 0/5] iio: accel: adxl345: Implement event scaling and
 ABI compliance
Message-ID: <20260228161458.3daa4638@jic23-huawei>
In-Reply-To: <20260226151108.22383-1-0rayn.dev@gmail.com>
References: <20260226151108.22383-1-0rayn.dev@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 26 Feb 2026 15:11:01 +0000
Taha Ed-Dafili <0rayn.dev@gmail.com> wrote:

> This series addresses ADXL345 driver non-compliance with the IIO ABI.
> 
> Currently, the driver exposes raw threshold values without a scale factor
> to convert them to SI units (m/s^2). It also hides the double tap
> threshold value because it shares a hardware register with single tap,
> which violates ABI expectations.
> 
> This series implements `IIO_EV_INFO_SCALE` in the IIO core and applies it
> to the ADXL345 driver. It also exposes the missing `IIO_EV_INFO_VALUE` for
> double tap, ensuring userspace can correctly interpret all events, and
> cleans up related documentation.
Series applied to the testing branch of iio.git. After that's had a few days
being poked at by the bots, I'll push it out as togreg which is the branch
linux-next picks up.

Thanks,

Jonathan
