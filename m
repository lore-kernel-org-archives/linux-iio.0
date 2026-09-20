Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FAB62C21D8
	for <linux-iio@vger.kernel.org>; Sun, 20 Sep 2026 00:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789864207; cv=none; b=HgRdEYz6P3iWmsSn+8rVkreBHEhUmP3GKxIFpRK02cZxZYi1SWtKZRgHeybv2Ryxuhtl6icdFz/qCQ9Hc0NVTzxqHe7K/OsE8Y1AcgY9KVwRXkvjyN/HyoMCnTzTugM5WUOi24D+J9+BcGREPpsQ+LgYNyI18Yq2AYrLfpd5Gos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789864207; c=relaxed/simple;
	bh=O1ALBM13iEX1wzEjmJ9CPWZKzzSIcHlm8EazGLsTFmE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iUIUtJ9JCwFr6sxxXqNqH2f6SNOZWDWiJKBOWsHWSXvW6aNn44WYdbKZvf+gF3SgngiXOaUtfJPfUo285b094nxLC/3gkTCyhng8JfnSqW1zuWpE3Xsl+Azedcs4NGcVu/WWhawv0As6qFeg94vsNfA0nCTp/AJYZqJ+Ltpx7Lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cYt5t7sr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cYt5t7sr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBA8E1F000FF;
	Sun, 20 Sep 2026 00:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789864206;
	bh=bLO+3Ab9qBjg0IS2eKd8BtxrLrpQO95LPqnZGFo/2gU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=cYt5t7srStg0wM79dBWDTJ3+3QCsxBS2b1OyiridK9iSi9nFE5HWM+GT5itKogs+1
	 R3LHhLFRjTagZaAxGjaYTHnXZaVb6yG1YuEBYahEIYF+HSJ1LkLZPbMzFZLhzEBXjY
	 Qv/1njVS4l/Z3eL7vfFhtnNiKAzbCeAzEEzUuHSxRZ4xjI5cJWhM3jqcZCMnlWYy/V
	 0liMohcMRKYlX5kf0kmUORcpjqXZw9X34+Hc7HmUYJ2/xlIyMxjV+XuvoE2Jfb9TYp
	 1GwjYSEIqMUPb01kDBXUAjVZm5tHs0FDQjNZpGL3pc3Y8rs04/mizgnGL7OMLzuFaq
	 R8HWvF06gDZoQ==
Date: Sun, 20 Sep 2026 01:30:00 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Angel2Eyes <thefireking@gmail.com>
Cc: linux-iio@vger.kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org
Subject: Re: [PATCH] iio: adc: mcp3422: use sysfs_emit() in show functions
Message-ID: <20260920013000.7ed606c5@jic23-hlaptop>
In-Reply-To: <20260919195507.94130-1-thefireking@gmail.com>
References: <20260919195507.94130-1-thefireking@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 19 Sep 2026 22:55:07 +0300
Angel2Eyes <thefireking@gmail.com> wrote:

> sysfs_emit() is preferred over sprintf() for sysfs show() callbacks
> since it is aware of the PAGE_SIZE buffer and has built-in size and
> alignment checks.
> 
> Convert the remaining sprintf() calls in mcp3422_show_samp_freqs() and
> mcp3422_show_scales(). The formatted output is unchanged.
> 
> Assisted-by: LLM
> Signed-off-by: Angel2Eyes <thefireking@gmail.com>
Hi.  

In the ideal case you would go further here and make us of the
read_avail() callback and appropriate _avail bitmap elements
for the channels.  Given simple nature of these two functions that
should be easy to convert.  The reason to do this is to make the
ranges etc available to in kernel users.

If you want to just make this simpler change I don't mind, but
we do need that 'well known identity' for the Sign off that
Maxwell has raised.

Jonathan

> ---
>  drivers/iio/adc/mcp3422.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/adc/mcp3422.c b/drivers/iio/adc/mcp3422.c
> index 36ba00edf..fd9e72265 100644
> --- a/drivers/iio/adc/mcp3422.c
> +++ b/drivers/iio/adc/mcp3422.c
> @@ -262,9 +262,9 @@ static ssize_t mcp3422_show_samp_freqs(struct device *dev,
>  	struct mcp3422 *adc = iio_priv(dev_to_iio_dev(dev));
>  
>  	if (adc->id > 4)
> -		return sprintf(buf, "240 60 15\n");
> +		return sysfs_emit(buf, "240 60 15\n");
>  
> -	return sprintf(buf, "240 60 15 3\n");
> +	return sysfs_emit(buf, "240 60 15 3\n");
>  }
>  
>  static ssize_t mcp3422_show_scales(struct device *dev,
> @@ -273,7 +273,7 @@ static ssize_t mcp3422_show_scales(struct device *dev,
>  	struct mcp3422 *adc = iio_priv(dev_to_iio_dev(dev));
>  	u8 sample_rate = FIELD_GET(MCP3422_SRATE_MASK, adc->config);
>  
> -	return sprintf(buf, "0.%09u 0.%09u 0.%09u 0.%09u\n",
> +	return sysfs_emit(buf, "0.%09u 0.%09u 0.%09u 0.%09u\n",
>  		mcp3422_scales[sample_rate][0],
>  		mcp3422_scales[sample_rate][1],
>  		mcp3422_scales[sample_rate][2],
> 
> base-commit: 69fa76f0af3414cc189c3b0b807cb59e327ecc00

