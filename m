Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC513D7D69;
	Tue, 21 Apr 2026 14:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776783530; cv=none; b=kFWV5BrB34R+XRNrOw2TImXgME2I57CaiV3kCYTXcl46EkIhWEnauyXjxg3aFsnBm1AC1xz6mnC4XiiCp9PjwLoiTfJSHtA4l0hjcv+sIJaaZkDl5feYIHHvGZZMpofuwOOzpnZ3ABvHtZBOKY3JrerwrIexUjyfiHp/N5NxgWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776783530; c=relaxed/simple;
	bh=Q38MBGztVRwnNdKOP2TFjz+u2YNSwlJ+xfAwL4e0qq4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eHHVzv6ps8Bbb5O2ZF7n31+I3Pa9BUuzk0VwBlQAtpFOelnSZ7sysQEoab8z0q3TOLmAoagQi8yCI1+IIeUyGVxZIm8tL++v27SEUP5A32zl5k8QZ55XY8RXm6IzluARTPkJDKc5/B1p4P/4wR10VEhZiDRziRRwHnLuGeAeTYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pv6WPmST; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pv6WPmST"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EF9EC2BCB0;
	Tue, 21 Apr 2026 14:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776783530;
	bh=Q38MBGztVRwnNdKOP2TFjz+u2YNSwlJ+xfAwL4e0qq4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pv6WPmSTnPAbAYJrBNiQvGridL+eTD4dGhYFsmBviXVKPCjw/Xy9fibNi8poeHnm+
	 dWIitajSP80AM7+H9GYrRDDL4wLbf+s6AUG0KaNiuUJp+MkA80Dmp2tYSbg9GY2UpN
	 1vpqVKTYv+3rDYmKIWgCNWB0u63eirT8KZh3swf2w1qpz8tXx+Ko6ch7eaNFRpoqFQ
	 ssjbEsIj5+VxjwHzb/dbHZHymX7tCYyUGSe9l+EgrvKcCDRfeUa/1iaYX99d1aMj16
	 wAnzunfh8aAkd1/c0hIZLtd9zKuxU0n1Fe1Y4tFqV+Pp1ZhroX1DZi78hRR3oV6KaY
	 p71PNDM9f3xcA==
Date: Tue, 21 Apr 2026 15:58:41 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
Cc: antoniu.miclaus@analog.com, lars@metafoo.de,
 Michael.Hennerich@analog.com, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: adc: ti-ads7924: Use guard(mutex) in ADC read
 helper
Message-ID: <20260421155841.5774fbf2@jic23-huawei>
In-Reply-To: <20260420113445.126516-2-giorgitchankvetadze1997@gmail.com>
References: <20260420113445.126516-2-giorgitchankvetadze1997@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 20 Apr 2026 15:34:45 +0400
Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com> wrote:

> Replace mutex_lock()/mutex_unlock() pair with guard(mutex)()
> and move the lock into ads7924_get_adc_result(). Keeping the guard
> in the helper makes the locking scope match the operation being protected.
> 
> Suggested-by: Jonathan Cameron <jic23@kernel.org>
> Signed-off-by: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
Applied.

Thanks,

Jonathan
