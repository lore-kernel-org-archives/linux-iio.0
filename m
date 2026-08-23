Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A752F6562;
	Sun, 23 Aug 2026 18:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787509133; cv=none; b=taCARvTYtXmhBNoi3l0r9b7ovBzL/ojvNjDDQ1K2oW1U1bdHDTo70pUlBPsYoEkjyXDTsGSoAvCleOqmBZYWfMs53DKA9uMtPJxfuIAyCp4KRa8TJJK7WEvAFkktCQXw4lJB+uPkMy40N31y5I9MOhz3qvhPB49G5JfrGglQpio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787509133; c=relaxed/simple;
	bh=bTFEClWjwDQYYEvSkclFwJOS28tMqQJltTIQTJGESRY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nTz9ge8apuJ90UlusflKAQcPqrwyPJH8QzzC2Nho/d1W9HIbBn4IYuL6mPwBetQaHl1DyNxQ9IaYM++FwG0nwRg6brceYUv07tExjadBPOjLKGNWwVMhLgEN9FcA4ojpMJ6OTq4emMh2TuKJQSO8N1RGnRc4/W6HErzdA2IVhH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XT/Zz65H; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XT/Zz65H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86D0A1F000E9;
	Sun, 23 Aug 2026 18:18:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787509132;
	bh=VxbdHeqUiI3OU+NpNWCMnbLrFYWlMzVeYgIo0KVGA7g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=XT/Zz65HLYRtnPlSyaDkjI6jSXJlF042A3SGCeImgsUEn94qNiBctQ5tvudlrLykj
	 ZTeyH9wKfczu7r+a/ZfJL9iGFlemRlKrlOVzGss2xzUF5K8nzJls+c9eY4H0wEKa/5
	 0XRCFeIMo7FW4U2hlocTuPwHG3h8UiEoMV4ymMOEcgTSYTIF+AQD1vtP+3/1dnKh0d
	 1KC1j1lPcC7PxeD4tQ4W5k77zc0XS44CnMSfvTxgTix0Beoe5wfc7BW9lgazwJ0qF1
	 aoEjEXWe6F3mAG/l2MPaDN0Ug7gb5zY3EtZ+w43WUM26TFsTh+Ti0RQwT0Ba/GHJjZ
	 wgzmQTiMU/z6g==
Date: Sun, 23 Aug 2026 19:18:48 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Salah Triki <salah.triki@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Wang Shuaijie
 <wangshuaijie@awinic.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: proximity: aw96103: Fix early return in IRQ
 handler loop
Message-ID: <20260823191848.272c910f@jic23-huawei>
In-Reply-To: <20260823040926.23860-1-salah.triki@gmail.com>
References: <20260823040926.23860-1-salah.triki@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 23 Aug 2026 05:09:25 +0100
Salah Triki <salah.triki@gmail.com> wrote:

> When an unrecognized proximity status is encountered in aw96103_irq(),
> the default case executes a return IRQ_HANDLED. Because this happens
> inside the loop over the device's channels, any remaining channels are
> left unhandled, causing missed events and stale IRQ status.
> 
> Replace the return IRQ_HANDLED statement in the default case with
> continue to ensure all channels are processed even if one has an
> unexpected status value.
> 
> This issue was found via code inspection.
> 
> Signed-off-by: Salah Triki <salah.triki@gmail.com>
Applied to the testing branch of iio.git.

Another one I forgot for reasons I apply quicker than average (see
reply the tmp117)

- Low risk changes - either because of code (true here) or because of timing
  the tree is getting rebased anyway (also true)

Jonathan

> ---
> Changes since v1:
> -Remove Fixes tag as this is hardening rather than a fix for a real-world bug.
> -Mention in commit message that the issue was identified through code reading.
> 
>  drivers/iio/proximity/aw96103.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/proximity/aw96103.c b/drivers/iio/proximity/aw96103.c
> index 8fbb755dcae0..b1f36a51d56f 100644
> --- a/drivers/iio/proximity/aw96103.c
> +++ b/drivers/iio/proximity/aw96103.c
> @@ -669,7 +669,7 @@ static irqreturn_t aw96103_irq(int irq, void *data)
>  				       iio_get_time_ns(indio_dev));
>  			break;
>  		default:
> -			return IRQ_HANDLED;
> +			continue;
>  		}
>  		aw96103->channels_arr[i].old_irq_status = curr_status;
>  	}

