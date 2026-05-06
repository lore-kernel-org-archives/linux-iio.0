Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0BE244D039;
	Wed,  6 May 2026 16:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778085684; cv=none; b=YAzq0TKUx+r8eCKVvdt1a92Q0iusUqszy33p4Xr3ByZ5a+TZ+xrgL2U7flPzedFLH+6p5Z/M6cg0Rkx3d6osOxXwxkOyRBCnZZdWGSIWeO2WzAvSGgXBvGgcY+XYRyzHZzCM+nC1hJfCGxJS1VbYQN2LO9Y6LZ2yHrnuy5YQIdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778085684; c=relaxed/simple;
	bh=CwQYG395E5hxLcLxjLq12wsc6+XUwFOo2gC3ua/E8pY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fiVNgKLlRoP/WkcMJp28O+Eo4YUOaxenW76phlQoaq7onHNigk9pZlQxmUfFgOY70fzo9P+72KmT0dOqUanUQ1SMfBwdjncS08HSkl+9HDbxpZDtp5Q68ALA46Q/au3OIbtKShnin6hxphEEwWnCYwHxbmfpaxq/ExEvTJHWi2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CBf2ahDX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CBf2ahDX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16C1FC2BCB0;
	Wed,  6 May 2026 16:41:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778085684;
	bh=CwQYG395E5hxLcLxjLq12wsc6+XUwFOo2gC3ua/E8pY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CBf2ahDXBLDic2RS0YhZPbhyXJ5S7gI1/3sd99klKD/bdRtDKlO9esw1Z2PiXroWi
	 0MPkk3EJIj0pEwWmpA2QHCIDgoA+mGYIymAdyabLCo6KVl/GdWtcygKuPEBT2q3k4x
	 NqhL4IVD7yPWCXnSWHX40SL18VBP9VXyJ8wQMoEyugOe7AqVu8CuhGW4ltm/uZsQbm
	 LRkkh+jyYd7qHs02tRHJ3PG1SrPpzgeZ3R4Fs7sk8SWytRdtesvOGpvSFMoHXPrEwG
	 y0LrLLb0kbJy1w6t0qIg9FqbhsAnwgReK57LN2gXRNhIeqUl5BYqU9jCdKsUJQ538k
	 CVVc2u9UjB9WQ==
Date: Wed, 6 May 2026 17:41:15 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org>
Cc: joshua.crofts1@gmail.com, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v5 05/18] iio: magnetometer: ak8975: fix wrong errno on
 return
Message-ID: <20260506174115.42bc56d9@jic23-huawei>
In-Reply-To: <20260505-magnetometer-fixes-v5-5-831b9b5550fc@gmail.com>
References: <20260505-magnetometer-fixes-v5-0-831b9b5550fc@gmail.com>
	<20260505-magnetometer-fixes-v5-5-831b9b5550fc@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 05 May 2026 13:46:01 +0200
Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org> wrote:

> From: Joshua Crofts <joshua.crofts1@gmail.com>
> 
> The driver currently returns -EINVAL on polling timeout instead of
> -ETIMEDOUT.
> 
> Replace return code for -ETIMEDOUT and remove unnecessary error
> message as -ETIMEDOUT is a standard POSIX error. Also replace
> instances of -EINVAL in comments.
> 
> Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
Applied.

Tah
