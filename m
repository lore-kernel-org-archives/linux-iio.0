Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C9C346E43;
	Sun,  6 Sep 2026 21:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788730450; cv=none; b=U/DSUMtgPKo9bwqndfIMMB2eRE5yGFybeGV3zWIMX5kfjdfs1ZMYrFmbRnqiyOIJqkymD/QUYeToY4XWB0+qe9GZBCcAvB7uStswJtv7gpmII0jPNNay8gDcDv5LpfGbDkeHB5/Yk5rG5q4AV3Wz7fn9JGWhAVyvJd7EQNdHvLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788730450; c=relaxed/simple;
	bh=Sk8Q17ELiJpucZi9ZDVIG5zOYgZ232zRqd4Odykmvro=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m6WukNuk5dJE7MqbwqLRs93JEEGNpqe+aZZUTq1D8lGhJHlhmEdmOjmQ0/wlZnl8OAoGZnM+CdO6Rs7CyvMxKkls8QrVtbhb1udqLSisMnyYQeQ3PPFKuxTTZSCzGBNgIjCSFhrs/WSY8eLHd36Pn0wzDJPCXeONHpu7KgX/QPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h5ehgoBO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h5ehgoBO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D9BF1F00A3A;
	Sun,  6 Sep 2026 21:34:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788730449;
	bh=ThyyM4ViW5GdZRVuEEEMJPVu4OP5btVT31pkreJ6kDg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=h5ehgoBOXg9/NeyycMO1BFcoLAsU6HbyegGHOLjQMxUAtvBI2RLtkwF6gdEu8rflN
	 RlViQcMJI9ErU1xZyLzxHcokjHU48MXvLDAMy7VSzpc807Tc6x0PhtWMxmoxQ1bVrq
	 wJO3QJiLfoLfwdfMtGffA83S40wZtQDlZccYANDF4mo7BND0w1Xar1ADMbIUVfWNsm
	 kN8Urb/D8OW3Itj+6Py6jcqThFJC+RLGbir+Scw/ot5ElvMfU6oV8LD1Tmub1klgg5
	 shL/SLWKAaFyxrmKV8BFUqhn47dn/jo0AJhWhl+MnSxYWQ87NB90Od4kEtAPJWdRRN
	 Y594TbGyXpiRQ==
Date: Sun, 6 Sep 2026 22:34:04 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Matti Vaittinen <matti.vaittinen@linux.dev>
Cc: Matti Vaittinen <mazziesaccount@gmail.com>, Matti Vaittinen
 <matti.vaittinen@fi.rohmeurope.com>, David Lechner <dlechner@baylibre.com>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, Mehdi Djait <mehdi.djait.k@gmail.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] iio: light: rohm-bu27034: Fix infinite delay on
 error
Message-ID: <20260906223404.708e86a4@jic23-huawei>
In-Reply-To: <c8a41d775b7b83c87bd58cc7ea3e4a88160d2d2d.1788336588.git.mazziesaccount@gmail.com>
References: <cover.1788336588.git.mazziesaccount@gmail.com>
	<c8a41d775b7b83c87bd58cc7ea3e4a88160d2d2d.1788336588.git.mazziesaccount@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 2 Sep 2026 11:48:46 +0300
Matti Vaittinen <matti.vaittinen@linux.dev> wrote:

> From: Matti Vaittinen <mazziesaccount@gmail.com>
> 
> When reading an integration-time fails, the code will use error code to
> compute the sleep time.
> 
> Fix this by using the smallest integration time as a default if
> reading fails.
> 
> Fixes: e52afbd61039 ("iio: light: ROHM BU27034 Ambient Light Sensor")
> Suggested-by: Jonathan Cameron <jic23@kernel.org>
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> 
> ---
> 
> I am not happy how intrusive this patch is for a fix. I really believe
> what I suggested in discussion:
> 
> wait_ms = bu27034_get_int_time(data) / USEC_PER_MSEC;
> if (wait_ms < BU27034_INT_TIME_MIN_MS)
>                  wait_ms = BU27034_INT_TIME_MIN_MS;

I really dislike messing with error codes like that division is doing
so I do prefer this though I get that it is a bit noisy.

So applied to the fixes-togreg branch of iio.git and marked for stable.

Thanks,

Jonathan
