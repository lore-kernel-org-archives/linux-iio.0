Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B45CA6F;
	Fri, 21 Aug 2026 01:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787277298; cv=none; b=cN1F4dOVL01w/dcABDJQFOQcZO3tNyGXmtMLpb3jtdxcBeshch7+qvzPagE412OHcJ8k/a0lOb0ilhh09LXgFRFTZYuHpCocl/OoJnuf7kxSrY0JsFJ6bjhyopWtISP8Wou1nonn5OggF7PBZ7hRjuUAsjKg/D+oMU0rxY8QleQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787277298; c=relaxed/simple;
	bh=VWAm2P5WmGmjRSETswS47ibGTz1jN/Z2kHGajtvlqE8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pWJRiSIChOPWwVMsQO+jEKLzSfeSRpc/egelowI8HtNgGMBn2fowhbt+0Uzyw4Td9/KtiOooVToesE2Em77SyKaRBKt9/7+H6EpLu99f0AUV2aFDzhFXQz97zo+Vjvotrd24RkeBDkURm01uBDc2ZaxEK3e4eHJHs0TSP/D1CcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DmXYIZ3d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DmXYIZ3d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03E7D1F00A3A;
	Fri, 21 Aug 2026 01:54:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787277297;
	bh=+fUxvta8M5vESV59WwpeeY36DRLhHARkkrbnBd5Wxpc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=DmXYIZ3dKxmdX89i6PGXcyAlxss+laC3MM+rwmpHg5IedFPba1haL7KeUYK4SMSlH
	 xui4cB3K1SuU/7IlRrwFLzmmxjgDDyzkDWOMA//2pkxQ+GKQ5oDKVLME5FowkIpyVq
	 Ii7BooFMtuwa1ktyQyEmdY8NmqXp7NhYT5Ijs/NypfaQBaEsMsD2e6xtSUWuIMlVUa
	 13kPbInlPHPr07qi9YzqoiJtfb7uL+1s6+djmyuiRIoLYdbE/VRtYi2qHC9vJyzyQa
	 LkRIdbZIj1Z5oV9tlSUmeaUb5dmner1cP9WsX1FXDcQvp/V4FeySdFa2lPSrZgdUI6
	 QYUQIyDB5TjNw==
Date: Fri, 21 Aug 2026 02:54:53 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Triet Hoang <triet.hoang.dev@gmail.com>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 bleung@chromium.org, groeck@chromium.org, linux-iio@vger.kernel.org,
 chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: cros_ec: Convert to DEFINE_SIMPLE_DEV_PM_OPS()
Message-ID: <20260821025453.5944eb9d@jic23-huawei>
In-Reply-To: <20260821014454.15960-1-triet.hoang.dev@gmail.com>
References: <20260821014454.15960-1-triet.hoang.dev@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 21 Aug 2026 08:44:54 +0700
Triet Hoang <triet.hoang.dev@gmail.com> wrote:

> Convert the deprecated SIMPLE_DEV_PM_OPS
> to DEFINE_SIMPLE_DEV_PM_OPS and pm_sleep_ptr().
Hi Triet,

Wrap to 75 ish chars for commit messages.

> 
> This lets us drop the __maybe_unused annotations
> from the resume callbacks, and reduces kernel size
> in case CONFIG_PM or CONFIG_PM_SLEEP is disabled.
> 
> Signed-off-by: Triet Hoang <triet.hoang.dev@gmail.com>

One more thing below.

> diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> index 5133755c2ea6..7d09f7c7d35c 100644
> --- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> +++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> @@ -862,7 +862,7 @@ int cros_ec_sensors_core_write(struct cros_ec_sensors_core_state *st,
>  }
>  EXPORT_SYMBOL_GPL(cros_ec_sensors_core_write);
>  
> -static int __maybe_unused cros_ec_sensors_resume(struct device *dev)
> +static int cros_ec_sensors_resume(struct device *dev)
>  {
>  	struct iio_dev *indio_dev = dev_get_drvdata(dev);
>  	struct cros_ec_sensors_core_state *st = iio_priv(indio_dev);
> @@ -879,7 +879,7 @@ static int __maybe_unused cros_ec_sensors_resume(struct device *dev)
>  	return ret;
>  }
>  
> -SIMPLE_DEV_PM_OPS(cros_ec_sensors_pm_ops, NULL, cros_ec_sensors_resume);
> +DEFINE_SIMPLE_DEV_PM_OPS(cros_ec_sensors_pm_ops, NULL, cros_ec_sensors_resume);

Take a look at where this macro and the comment right next to it...

>  EXPORT_SYMBOL_GPL(cros_ec_sensors_pm_ops);
relating to this circumstance.
