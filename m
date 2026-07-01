Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0381C4B8DF7;
	Wed,  1 Jul 2026 17:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782928742; cv=none; b=q0F+02R5JTNyeMfT9PwvM4lT8PbmJ2SsPGsJEAxVnosSPwHZSWmt+TjnG84hMtIP/F4Xz7YCdcRBkqHJNLYOBUglTIKsQCtrC2GfHeqGua4V/sPQkweDXogegZw2aNmmAZukItPGzWva/3H+C5NnGDHycgadbJes3pWIwbDnac0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782928742; c=relaxed/simple;
	bh=Mn96WGnSLjgkRT0LWMUqcMD+lgdtTvkymO0sOvaymv8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tjlp3atVmn+ud12q89NXn8knutm5FN0ERuw9OnJ4o/s42fj5k5G8z5yIMIW/26rC1Ys/NgYlcJFSiD/zbaS2sC+XR4jASaQ95zbIA2V1GCx3vD9fKfar6KUkMKZsxXy9LYMVFagzXqSBAO3wRv+FpepeAkqfjQi0nQpp428GyOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WVXinvls; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WVXinvls"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782928741; x=1814464741;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=Mn96WGnSLjgkRT0LWMUqcMD+lgdtTvkymO0sOvaymv8=;
  b=WVXinvls92HstCqvX+pOKEEiODK3V7SRJy7eGS8IluhZJhqedyYi2YsB
   EIE6XPPWWuhbG20OyCsU6oCP+ikseH9+fKk31p1BVff3Z/Qy27Sg+t+oF
   59w+suoJX8EEouG/2AyQHMeVWGQGllySgkjk87NNg4yWmX3kbsUJ1gVOM
   NgXmKpOIWPVOj4w9LJENbv22nic+EjYagpmMQmzdhOX2s0smTVxFD1E6R
   yqGZXZVSmwWjxLn+AAaU7tMKg7FCPXwdWcS9aSkja4uYuwhho1lqr6Zwk
   HMpI5JkgvF68ULLNyhzWEEpUSyr/xRYTzOHmSRSyYPig4PQa5qyLXGOgI
   w==;
X-CSE-ConnectionGUID: FRp+W7JeTuejqA9quV0GNQ==
X-CSE-MsgGUID: E+jvXr8uSsm7ijZPDlPWiw==
X-IronPort-AV: E=McAfee;i="6800,10657,11834"; a="83662906"
X-IronPort-AV: E=Sophos;i="6.25,142,1779174000"; 
   d="scan'208";a="83662906"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2026 10:59:01 -0700
X-CSE-ConnectionGUID: LQhHK8UwSr+vSWFxwgBDFQ==
X-CSE-MsgGUID: VWFpc8aITE2aLwsCLOSYvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,142,1779174000"; 
   d="scan'208";a="256970829"
Received: from spandruv-desk2.jf.intel.com ([10.88.27.176])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2026 10:59:01 -0700
Message-ID: <9975d6ea1a0afb3dd0cdebc050512c368a2b9c05.camel@linux.intel.com>
Subject: Re: [PATCH] iio: hid-sensors: Fix poll_value sign check before
 msleep_interruptible
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: Jonathan Cameron <jic23@kernel.org>, Kittisak Boonmapa
	 <goorock.goopop@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, 
	sakari.ailus@linux.intel.com, joshua.crofts1@gmail.com
Date: Wed, 01 Jul 2026 10:59:00 -0700
In-Reply-To: <20260701184707.5165a903@jic23-huawei>
References: <20260701154319.23497-1-goorock.goopop@gmail.com>
	 <20260701184707.5165a903@jic23-huawei>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-07-01 at 18:47 +0100, Jonathan Cameron wrote:
> On Wed,=C2=A0 1 Jul 2026 22:43:19 +0700
> Kittisak Boonmapa <goorock.goopop@gmail.com> wrote:
>=20
> > hid_sensor_read_poll_value() returns -EINVAL when the HID
> > descriptor
> > does not contain a Report Interval feature field.
> >=20
> > _hid_sensor_power_state() currently treats any non-zero value as a
> > valid delay and passes it to msleep_interruptible(). Since
> > msleep_interruptible() takes an unsigned int, negative values are
> > converted into very large delays.
> >=20
> > Only sleep when poll_value is positive.
> >=20
> > Fixes: 5d9854eaea77 ("iio: hid-sensor: Store restore poll and
> > hysteresis on S3")
> > Closes:
> > https://lore.kernel.org/linux-iio/CAPr6G1qLDrgHvCNsVxj7xHxYUKkAkyo87Hq3=
Lfyoj3RaZ2v4dg@mail.gmail.com/
> > Reported-by: Kittisak Boonmapa <goorock.goopop@gmail.com>
> > Assisted-by: Anthropic:Claude Sonnet 4.6
> > Signed-off-by: Kittisak Boonmapa <goorock.goopop@gmail.com>
> >=20
> Bug looks to be correct, but fix it by returning much earlier.
> If that function is returning an error something is very wrong and
> we should fail at that point, not just skip a sleep later.
>=20
Even if the report interval is not specified, but it has power state,
so returning early will fail to set power state.


Thanks,
Srinivas


> > ---
> > The bug was discovered while implementing a custom USB HID Sensor
> > (Accelerometer 3D, HID Usage 0x200073) on a Seeed XIAO nRF52840
> > Sense
> > for use with the Linux IIO subsystem and iio-sensor-proxy.
> >=20
> > The device intentionally omitted the Report Interval feature from
> > its
> > HID descriptor. This causes hid_sensor_read_poll_value() to return
> > -EINVAL, which is then treated as a non-zero delay by
> > _hid_sensor_power_state() and passed directly to
> > msleep_interruptible(). Since msleep_interruptible() takes an
> > unsigned int, the negative value is converted into an unintended
> > sleep of approximately 49.7 days.
> >=20
>=20
> For this non implemented feature, we need to explicitly handle the
> error and if seen put an appropriate replacement value in place.
> That may well be zero. I'm not sure!=C2=A0 Setting such a 'default'
> value provides a place to add a comment on why we are doing so.
>=20
> Jonathan
>=20
> > The issue was reproduced consistently on a Steam Deck LCD running
> > Bazzite (Linux 6.17.x), and disappeared completely after adding the
> > Report Interval feature to the HID descriptor, confirming the root
> > cause.
> >=20
> > This patch changes the condition to sleep only when poll_value is
> > strictly positive, avoiding unintended delays while preserving the
> > existing behavior for valid poll intervals.
> >=20
> > =C2=A0drivers/iio/common/hid-sensors/hid-sensor-trigger.c | 2 +-
> > =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
> > b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
> > index 417c4ab8c1b2..20099614bb27 100644
> > --- a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
> > +++ b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
> > @@ -143,7 +143,7 @@ static int _hid_sensor_power_state(struct
> > hid_sensor_common *st, bool state)
> > =C2=A0	sensor_hub_get_feature(st->hsdev, st-
> > >power_state.report_id,
> > =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 st->power_state.index,
> > =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sizeof(state_val), &state=
_val);
> > -	if (state && poll_value)
> > +	if (state && poll_value > 0)
> > =C2=A0		msleep_interruptible(poll_value * 2);
> > =C2=A0
> > =C2=A0	return 0;
