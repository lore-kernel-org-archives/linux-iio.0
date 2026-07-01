Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF584BCAA2;
	Wed,  1 Jul 2026 17:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782927740; cv=none; b=ev8OTEc3Dy0nD3vP6gkz+K2vmColMHY8TR536oaU2fG2tcJNLTzf2sy7xjoqRni7jQQSBcrpfM85bOgVbFC+3VnaJIK3Lpzqq7tIC3yD1wRf1HL3cDZu+oLHboV0DT0KWnHzqJduhX5y/82ytKtDZk1JMftQt+tpMWIROXglSok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782927740; c=relaxed/simple;
	bh=uDFFsSDTgmidlxgD4ENqJoQFvgSF7sVkfrqv62v00aI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bXp6pA43l3RbBgV0R06y/9BMhvOGCivWaOLYwYCGAkwvJLr8S1Vk/DIp9k6mMESL8YTv6xBgjjm7mWwL6ObblkfV/p3uYchDRlg0GuCwPT7F7mFRZEvb/1vFDWZIxknuSWtJPkakAdqnIqPDWr0v16vqMRKvTdF9MYxDLB29Jdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c+1x8mhi; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c+1x8mhi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782927738; x=1814463738;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=uDFFsSDTgmidlxgD4ENqJoQFvgSF7sVkfrqv62v00aI=;
  b=c+1x8mhiPzAAhBijTA6+OFADyIUsZM6YRWy9JWkTpiPVdbMQNeZp2QA1
   H1i1OgXB9y9m6hfLapS7V8cIXGqVEs1KzczVkdKT3j2m+bDYzct/g5Ro/
   rU86qnJbnheVXYOquiabI+rtg6aMpia44jk11MyBEdNQ8+D61PuJSFJRJ
   G2MzGprNfL0BKU0mGIiDoOt1QUilP3Gx/V3TIoWMpGgYS5X0nvgHUfq/I
   DbM5UrNlnY7LqHf64YkVX5HT0QA+cGPve7sQnCaiCpmA11JchxNuQRrYT
   ErOQzpd9cHFzeo9QGGLTMIixf4a8AsnYUowKAEs6DU0XNZ+VhRxhxTb+f
   g==;
X-CSE-ConnectionGUID: k9e48tlESqeP5ixuNcw/gw==
X-CSE-MsgGUID: 6qnSTaouQMaJjaRM6qxO5A==
X-IronPort-AV: E=McAfee;i="6800,10657,11834"; a="83660960"
X-IronPort-AV: E=Sophos;i="6.25,142,1779174000"; 
   d="scan'208";a="83660960"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2026 10:42:12 -0700
X-CSE-ConnectionGUID: u/sfoyPHTx6NnSH3k4m4Xw==
X-CSE-MsgGUID: ZHeB8icjSL6546RxCUuhKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,142,1779174000"; 
   d="scan'208";a="256211739"
Received: from spandruv-desk2.jf.intel.com ([10.88.27.176])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2026 10:42:13 -0700
Message-ID: <2543d1a196bb97f2e4ddeb8e6902392e8e1c9324.camel@linux.intel.com>
Subject: Re: [PATCH] iio: hid-sensors: Fix poll_value sign check before
 msleep_interruptible
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: Kittisak Boonmapa <goorock.goopop@gmail.com>, jic23@kernel.org
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, 
	sakari.ailus@linux.intel.com, joshua.crofts1@gmail.com
Date: Wed, 01 Jul 2026 10:42:12 -0700
In-Reply-To: <20260701154319.23497-1-goorock.goopop@gmail.com>
References: <20260701154319.23497-1-goorock.goopop@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-07-01 at 22:43 +0700, Kittisak Boonmapa wrote:
> hid_sensor_read_poll_value() returns -EINVAL when the HID descriptor
> does not contain a Report Interval feature field.
>=20
> _hid_sensor_power_state() currently treats any non-zero value as a
> valid delay and passes it to msleep_interruptible(). Since
> msleep_interruptible() takes an unsigned int, negative values are
> converted into very large delays.
>=20
> Only sleep when poll_value is positive.
>=20
> Fixes: 5d9854eaea77 ("iio: hid-sensor: Store restore poll and
> hysteresis on S3")
> Closes:
> https://lore.kernel.org/linux-iio/CAPr6G1qLDrgHvCNsVxj7xHxYUKkAkyo87Hq3Lf=
yoj3RaZ2v4dg@mail.gmail.com/
> Reported-by: Kittisak Boonmapa <goorock.goopop@gmail.com>
> Assisted-by: Anthropic:Claude Sonnet 4.6
> Signed-off-by: Kittisak Boonmapa <goorock.goopop@gmail.com>
>=20
Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

> ---
> The bug was discovered while implementing a custom USB HID Sensor
> (Accelerometer 3D, HID Usage 0x200073) on a Seeed XIAO nRF52840 Sense
> for use with the Linux IIO subsystem and iio-sensor-proxy.
>=20
> The device intentionally omitted the Report Interval feature from its
> HID descriptor. This causes hid_sensor_read_poll_value() to return
> -EINVAL, which is then treated as a non-zero delay by
> _hid_sensor_power_state() and passed directly to
> msleep_interruptible(). Since msleep_interruptible() takes an
> unsigned int, the negative value is converted into an unintended
> sleep of approximately 49.7 days.
>=20
> The issue was reproduced consistently on a Steam Deck LCD running
> Bazzite (Linux 6.17.x), and disappeared completely after adding the
> Report Interval feature to the HID descriptor, confirming the root
> cause.

Although Report interval is an optional field, every hub had it from
the beginning.=C2=A0
But this change is good.

Thanks,
Srinivas



>=20
> This patch changes the condition to sleep only when poll_value is
> strictly positive, avoiding unintended delays while preserving the
> existing behavior for valid poll intervals.
>=20
> =C2=A0drivers/iio/common/hid-sensors/hid-sensor-trigger.c | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
> b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
> index 417c4ab8c1b2..20099614bb27 100644
> --- a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
> +++ b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
> @@ -143,7 +143,7 @@ static int _hid_sensor_power_state(struct
> hid_sensor_common *st, bool state)
> =C2=A0	sensor_hub_get_feature(st->hsdev, st->power_state.report_id,
> =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 st->power_state.index,
> =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sizeof(state_val), &state_v=
al);
> -	if (state && poll_value)
> +	if (state && poll_value > 0)
> =C2=A0		msleep_interruptible(poll_value * 2);
> =C2=A0
> =C2=A0	return 0;
