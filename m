Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13B7E3B8944
	for <linux-iio@vger.kernel.org>; Sun, 17 May 2026 14:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779027488; cv=none; b=VYQ5L1higb36eduqG/rskjUMEsaVICu9fgSnv6FBWMuUcpI1TDsmsXYZOLUlZCoYDUPMsJyYIOXYCilkiF0UVl7UnRh2XPfLAhEEasRBQQ7Vku69Bl4avFMt8KuPQFebocJnCtayQRwCZUHveUytD6kk4z36g8fj+wlT+bS2vwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779027488; c=relaxed/simple;
	bh=JJa+ENaWZVT8aQdKDqWsr9b/4j33LYF0jQBcRipU3Sk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R3Hvo408+/4QGvubd9J9JOtnqKBt4hq4abXmxf5o15Kt8P+oh90xlvJht9fCDdFBgaSAo0hiWBYKOs8y0XcyiJqyEu1QKnyxcRotDsg7tw/mB53RQiHtqr6ik0Eo+SCSTSbEROS5pZccbjAzdaVBPdCb8HQ9chh6Z96+w6HkLkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uSI0iHaY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uSI0iHaY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EC9BC2BCB0;
	Sun, 17 May 2026 14:18:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779027486;
	bh=JJa+ENaWZVT8aQdKDqWsr9b/4j33LYF0jQBcRipU3Sk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uSI0iHaY12rSW6yy66mVcLsRYZc0yHcbcO/P+V9+eWXT3Hb4OF0OKL30os3xVeEG9
	 l8uMWtgNX9/8Wdpg8glQs7oJUy1T1/RzkyXOUsdpNk41LC2RuaAS7Ms2TvGYn/rnH/
	 aADesFPJSZIT9+ASm2lrdlJfCeSl4D8vIdSmWGO7unoBR+pkZoVeXBYtJpxU62kLjF
	 xRTCUnuAjL0bVrFlXdCHYBwt4nWHj4BIJci3HEbsTQtvcd+eNhLjch0sWO+28DxX6k
	 cEKH76be46qBYRGo+5VuwPxa/K2OwS1LfK0qm4hCOeoumvuWwqXWwTlS5M7GOgvIvX
	 8HDhNhl5Yolrw==
Date: Sun, 17 May 2026 15:18:00 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nikhil Gautam <nikhilgtr@gmail.com>
Cc: linux-iio@vger.kernel.org, dlechner@baylibre.com
Subject: Re: [PATCH v2 1/1] iio: chemical: bme680: use BME680_NUM_CHANNELS
 for scan buffer
Message-ID: <20260517151800.540f61d3@jic23-huawei>
In-Reply-To: <20260420082436.7223-2-nikhilgtr@gmail.com>
References: <20260420082436.7223-1-nikhilgtr@gmail.com>
	<20260420082436.7223-2-nikhilgtr@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 20 Apr 2026 13:54:36 +0530
Nikhil Gautam <nikhilgtr@gmail.com> wrote:

> Use BME680_NUM_CHANNELS instead of the hardcoded channel count
> in the scan buffer.
> 
> This avoids use of a magic number and improves code readability
> and maintainability.
> 
> Suggested-by: Jonathan Cameron <jic23@kernel.org>
> Signed-off-by: Nikhil Gautam <nikhilgtr@gmail.com>
I think I sat on this to see if anyone else wanted to review then
lost it (patchwork kept track though!)

Anyhow, applied to the testing branch of iio.git.

Thanks,

Jonathan

> ---
>  drivers/iio/chemical/bme680_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/chemical/bme680_core.c b/drivers/iio/chemical/bme680_core.c
> index 3e850562ab00..42c1a9de175a 100644
> --- a/drivers/iio/chemical/bme680_core.c
> +++ b/drivers/iio/chemical/bme680_core.c
> @@ -128,7 +128,7 @@ struct bme680_data {
>  	u16 heater_temp;
>  
>  	struct {
> -		s32 chan[4];
> +		s32 chan[BME680_NUM_CHANNELS];
>  		aligned_s64 ts;
>  	} scan;
>  

