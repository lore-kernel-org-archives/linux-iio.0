Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3367B44D039;
	Wed,  6 May 2026 16:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778086505; cv=none; b=jvUR6ly37mMxfDM07Ykv+BV+aBPmHFyIky6hedBOIDVjCgQYuPi76I9eUXJhf07rdA/xrP+u5NNvKufPBC/sNc62X5GxVkj13LK3Z/P0KWVAziFsgfTDmUnmQofTWOjEsqQf8q9VHEBUrejP8k/Sz045iepyRbPT28TsXVc4oc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778086505; c=relaxed/simple;
	bh=kMNc++Utvd/Gb37biFPiBpQWt2YET4lbAN/riUH9gYs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aqnjTqqCxKIKDasR2yQxmslx0r01OAvESjNHAZp9qcWENOWCYl8fIL4f+SjpKKHX7deAeBCfz7ymEtCzEGhFgFsp81mVX3DHXzzUrxv7dstSFwq796yN+n4Aq4/145TW5cjhuYj2laYDR9ltizAhIYW2CMnYvG9oj1hR9w6+raI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZjW2jR+h; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZjW2jR+h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AB31C2BCB0;
	Wed,  6 May 2026 16:55:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778086504;
	bh=kMNc++Utvd/Gb37biFPiBpQWt2YET4lbAN/riUH9gYs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZjW2jR+h0tKT4Tl3nVpdoNZvVebd5MVObuZJVek20h5MPgX/uMnunzOAwAT3512qP
	 YQwyUq8LLq4rPeTKWOxjswzKijRVkhf10kNko7Ybv5CR8h2/sQzN7webkhZ34F+B1s
	 TvPfVFpMnfVjXzHMNakAgZoOUawnP7eI05VQfXdoFizoU/zMvYFfk/QtjaHh7P1WvA
	 joQpeeco29tDWop1+vBA8qebM7CmD5oipH2UCsVCWSJuhGrgriylj+ZuoZdYtXPTlq
	 WBe2c4yNnEu9Ic9N/sXnKN/cFElaPFtwx44e7SytFc8nHWZLmfWypBNhmPOSNyiwu1
	 JFNCORS/HDCGQ==
Date: Wed, 6 May 2026 17:54:55 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org>
Cc: joshua.crofts1@gmail.com, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v5 09/18] iio: magnetometer: ak8975: avoid using
 temporary variable
Message-ID: <20260506175455.780d605a@jic23-huawei>
In-Reply-To: <20260505-magnetometer-fixes-v5-9-831b9b5550fc@gmail.com>
References: <20260505-magnetometer-fixes-v5-0-831b9b5550fc@gmail.com>
	<20260505-magnetometer-fixes-v5-9-831b9b5550fc@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 05 May 2026 13:46:05 +0200
Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org> wrote:

> From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> Avoid using temporary variable in ak8975_read_axis(). With that being done,
> the clamp_t() call becomes idiomatic in the driver and can be factored out
> to a helper later on (and if needed).
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
Independent of the last two patches (which I've left for now)
so applied this one to the testing branch of iio.git.

Jonathan

> ---
>  drivers/iio/magnetometer/ak8975.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
> index b3caf5f3ebf29bf701bb214aa480fa7afb2651c6..c36d068081066ef6b42cc2f9c3c2e8978ec51623 100644
> --- a/drivers/iio/magnetometer/ak8975.c
> +++ b/drivers/iio/magnetometer/ak8975.c
> @@ -741,7 +741,6 @@ static int ak8975_read_axis(struct iio_dev *indio_dev, int index, int *val)
>  	const struct i2c_client *client = data->client;
>  	const struct ak_def *def = data->def;
>  	__le16 rval;
> -	u16 buff;
>  	int ret;
>  
>  	pm_runtime_get_sync(&data->client->dev);
> @@ -778,8 +777,8 @@ static int ak8975_read_axis(struct iio_dev *indio_dev, int index, int *val)
>  	pm_runtime_put_autosuspend(&data->client->dev);
>  
>  	/* Swap bytes and convert to valid range. */
> -	buff = le16_to_cpu(rval);
> -	*val = clamp_t(s16, buff, -def->range, def->range);
> +	*val = clamp_t(s16, le16_to_cpu(rval), -def->range, def->range);
> +
>  	return IIO_VAL_INT;
>  
>  exit:
> 

