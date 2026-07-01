Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE51282F1B;
	Wed,  1 Jul 2026 17:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782928033; cv=none; b=dqRspNXuaIRVDu/o2AWVSJXmSSrR9Dukx4zdidrDQDgyEnip28+x1ppUB2zmGTp8scuiPQLzKtUA78oue8+kWzYQntwHE+0eK0vlnkcLlc0lyxT/bJFUerdRNKWJY4h0pkmoj81EUruUA6y+P8M6EXpg3Uxjp+frKFGS6NYCgBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782928033; c=relaxed/simple;
	bh=nRJ6wFVGu8evfZO5Qw0aSC2gfKyuLka0pftifeFfEBU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mT+2jzBebVZ58pxN+vFPZpUETDSOgFuPR+By2YcRf4cJTnPi0H2T3Jlh7c8ALj9Wksj5ix4tmo0r2tzYjFcQ9eBr8sWkLr6rK6nju/avGooShI/rT5BvWKfqVxdaAsjQX9ffHUPKSMAikW4Y3cCm4XVHqZggTrZYi1dIs+3OqT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fjvDmXqR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fjvDmXqR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F35D1F00A3A;
	Wed,  1 Jul 2026 17:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782928032;
	bh=VE25bPizR6jDv/JQZhqv38g1d+XUKqzI8L73KeJuKUA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=fjvDmXqRXHsr52XDjhHzlmoUQ4nI5lOr2GMGzwjud51FFVm/7ERB4LPtb7e43A8rN
	 IBSTZkmJtcsKRywa3yRdoCjTfagSon1T8AX8MQQH0OOmLF4mwBi+0IF956Pcy93qn4
	 MwGlv5DpFT/36FfN2ey1XIeCReM3UtYPxlhzXg6IJqLZHXAix8SVf+hbH2OC0G/T9H
	 NQWy9TXclDCZ0QH8DjU2PrMH3go9iHo5e4RGEFccAsALrTPZYfWikgI3xryhZbSCiU
	 ZrKnLfCi0HLGqV6ol18E2R7zE2gdiwsydc5cvij1ZVJnEr5JXHDbCAEleUaXJ85hi0
	 Y+G5QpbbdZI/Q==
Date: Wed, 1 Jul 2026 18:47:07 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Kittisak Boonmapa <goorock.goopop@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 srinivas.pandruvada@linux.intel.com, sakari.ailus@linux.intel.com,
 joshua.crofts1@gmail.com
Subject: Re: [PATCH] iio: hid-sensors: Fix poll_value sign check before
 msleep_interruptible
Message-ID: <20260701184707.5165a903@jic23-huawei>
In-Reply-To: <20260701154319.23497-1-goorock.goopop@gmail.com>
References: <20260701154319.23497-1-goorock.goopop@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  1 Jul 2026 22:43:19 +0700
Kittisak Boonmapa <goorock.goopop@gmail.com> wrote:

> hid_sensor_read_poll_value() returns -EINVAL when the HID descriptor
> does not contain a Report Interval feature field.
> 
> _hid_sensor_power_state() currently treats any non-zero value as a
> valid delay and passes it to msleep_interruptible(). Since
> msleep_interruptible() takes an unsigned int, negative values are
> converted into very large delays.
> 
> Only sleep when poll_value is positive.
> 
> Fixes: 5d9854eaea77 ("iio: hid-sensor: Store restore poll and hysteresis on S3")
> Closes: https://lore.kernel.org/linux-iio/CAPr6G1qLDrgHvCNsVxj7xHxYUKkAkyo87Hq3Lfyoj3RaZ2v4dg@mail.gmail.com/
> Reported-by: Kittisak Boonmapa <goorock.goopop@gmail.com>
> Assisted-by: Anthropic:Claude Sonnet 4.6
> Signed-off-by: Kittisak Boonmapa <goorock.goopop@gmail.com>
> 
Bug looks to be correct, but fix it by returning much earlier.
If that function is returning an error something is very wrong and
we should fail at that point, not just skip a sleep later.

> ---
> The bug was discovered while implementing a custom USB HID Sensor
> (Accelerometer 3D, HID Usage 0x200073) on a Seeed XIAO nRF52840 Sense
> for use with the Linux IIO subsystem and iio-sensor-proxy.
> 
> The device intentionally omitted the Report Interval feature from its
> HID descriptor. This causes hid_sensor_read_poll_value() to return
> -EINVAL, which is then treated as a non-zero delay by
> _hid_sensor_power_state() and passed directly to
> msleep_interruptible(). Since msleep_interruptible() takes an
> unsigned int, the negative value is converted into an unintended
> sleep of approximately 49.7 days.
> 

For this non implemented feature, we need to explicitly handle the
error and if seen put an appropriate replacement value in place.
That may well be zero. I'm not sure!  Setting such a 'default'
value provides a place to add a comment on why we are doing so.

Jonathan

> The issue was reproduced consistently on a Steam Deck LCD running
> Bazzite (Linux 6.17.x), and disappeared completely after adding the
> Report Interval feature to the HID descriptor, confirming the root
> cause.
> 
> This patch changes the condition to sleep only when poll_value is
> strictly positive, avoiding unintended delays while preserving the
> existing behavior for valid poll intervals.
> 
>  drivers/iio/common/hid-sensors/hid-sensor-trigger.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
> index 417c4ab8c1b2..20099614bb27 100644
> --- a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
> +++ b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
> @@ -143,7 +143,7 @@ static int _hid_sensor_power_state(struct hid_sensor_common *st, bool state)
>  	sensor_hub_get_feature(st->hsdev, st->power_state.report_id,
>  			       st->power_state.index,
>  			       sizeof(state_val), &state_val);
> -	if (state && poll_value)
> +	if (state && poll_value > 0)
>  		msleep_interruptible(poll_value * 2);
>  
>  	return 0;

