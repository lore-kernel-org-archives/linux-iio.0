Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.19
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794773165;
	b=eyoiZf31hqEGhr6FJ+NJaLLTmkCzN/rfm6R5B4j4rPScUqbx32u90WwlSF+/MhKldAsx
	 BoplGa06IOtqkq1p09b9WOe9h+uoqvsz0+rfzNNAwgIyav33GLczfpvvbFO5vhqbX35nA
	 R49Z27HmlDjdP7Li8VjEN1JVmXpGCvJl5F/LzY+7nWMKmuia9wGQhCd5TP942DFf2fP2m
	 pBc32Pll7V1o6r3T/zfZJ1Vr9QX9b+w86vPhplbmoWHJM0wlrjCTDbgUJm+AgeBObPPfq
	 nhI5tRAu3HAoKvpQ7IM+WAIga7jGCqHSvrMjjKYI9oDV1UiCUUfcUCBYBRmL7nG8vgg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794773165;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Subject:
	 From:To:Cc:Date:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=V6f8F8LNy9YAU6rCYBHu+cFkP1DOJUinUgDyONhmTEU=;
	b=zBgjc+FKzF0yjU7gMNxf1yjXmBJTm9Tt7B/6wN+i7x0fwGRvCnOPoCFMwNuDMWX3Mx6S
	 RhqqNSLEM8GwLFRWESOm0WBkY6NN9BM0H40eld4EnrHnh54pfJYnaxYjcHcQqbtFlwybX
	 wv70eMatak4c6aJhQAB5ZIvm6LrUkPswQVronF/GNXd4zAgP29uXL5BriNarzWqluV3+3
	 x6F2gJmkQ02FO/tKkd3jDfGRIubyhZHXyPKu8Uo0g2zc1LQ1IDzb2ipGyiPE813R9Epq/
	 SMmzSHv42vQg11isxrv9u7Mw66AIe32zOLSIi9y13zqHD6oVsdssGNkMkl9QeHws5MA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Hpcq9d6Z;
	arc=none smtp.remote-ip=198.175.65.19
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1156606A31F
	for <linux-iio@vger.kernel.org>; Sun, 15 Nov 2026 20:06:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F1156606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Hpcq9d6Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794773165; x=1826309165;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=Q0jJChWGWJWoEKUUxOiITP+u33PYvHpoloeOqWhc1RA=;
  b=Hpcq9d6Zp2qy9UqMEF/5Qi2oYtIHMJQqiuWgvO1jYVp6qbpqhZ1Bs4hO
   Tu1kj8NpWIr6FWjhHGXZHXiYtUTMyFxVYU9w2E8rr9Mxp23pgxEZECZhr
   4efDXWEeCiG09tT3q7F0QKQkuQiVOwo5kK6rSYB/wAmFRa8tflolQKlVO
   ezCGcSgwqDWVTjiwx/rr5Fx6496UvKEVO1+pZlwUUgotbKVGmhAX8hyzk
   u3q2EU5FBKoskRX+/GT/kVNlIZNY+r8AcX0ynTQzd5I3aHcy3lV0DgHd6
   LJSSLEP+UVxnqk6UbNJHOzGD95D5tcR9rVNVoiPjuG3LzLQOkg6RTsrFg
   A==;
X-CSE-ConnectionGUID: BaKZXRMtT3ejE65wmenZzA==
X-CSE-MsgGUID: sUs34cHMQR+SOjpnzZzKqg==
X-IronPort-AV: E=McAfee;i="6800,10657,11967"; a="3550701"
X-IronPort-AV: E=Sophos;i="6.27,215,1787036400"; 
   d="scan'208";a="3550701"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2026 12:06:04 -0800
X-CSE-ConnectionGUID: h4/cUxGcQFOsKi7g0qJUUw==
X-CSE-MsgGUID: 5nIPvTXFQYKMsMq+L3h3/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,215,1787036400"; 
   d="scan'208";a="9302472"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO [10.125.108.92]) ([10.125.108.92])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2026 12:06:04 -0800
Message-ID: <a1fc89c153490fa0bf0e0f9e4f112831db90ec07.camel@linux.intel.com>
Subject: Re: [PATCH 05/39] iio: hid-sensors: use
 iio_push_to_buffers_with_ts()
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>, Nuno
 =?ISO-8859-1?Q?S=E1?=
	 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Jiri Kosina
	 <jikos@kernel.org>, Zhang Lixu <lixu.zhang@intel.com>
Date: Sun, 15 Nov 2026 12:06:03 -0800
In-Reply-To: <20261108203306.1599d000@jic23-hlaptop>
References: <20261026-iio-v1-0-8b136778eedf@oss.qualcomm.com>
		<20261026-iio-v1-5-8b136778eedf@oss.qualcomm.com>
		<60eab26805ad63d1b39d80fb9a47b0ba9bb5789d.camel@linux.intel.com>
	 <20261108203306.1599d000@jic23-hlaptop>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-2.fc44) 
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hi Jonathan,
On Sun, 2026-11-08 at 20:33 +0000, Jonathan Cameron wrote:
> On Mon, 26 Oct 2026 17:06:23 -0700
> srinivas pandruvada <srinivas.pandruvada@linux.intel.com> wrote:
>=20
> > On Mon, 2026-10-26 at 16:05 -0700, Jonathan Cameron wrote:
> > > Replace the deprecated iio_push_to_buffers_with_timestamp() with
> > > iio_push_to_buffers_with_ts(), passing the size of the pushed
> > > buffer.
> > >=20
> > > For hid-sensor-magn-3d, use IIO_DECLARE_BUFFER_WITH_TS() to suize
> > > the
> > > buffer for the maximum number of channels supported avoiding need
> > > for separate allocation.
> > >=20
> > > Signed-off-by: Jonathan Cameron
> > > <jonathan.cameron@oss.qualcomm.com>=C2=A0=20
> >=20
> > LGTM.
> > I will do some quick test on this and let you know.
>=20
> No huge rush.=C2=A0 This is the only one I'm going to leave unapplied
> that doesn't need changes (as far as I know!) for now.
>=20

Tested-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Thanks,
Srinivas


> Thanks,
>=20
> Jonathan
>=20
> >=20
> > Thanks,
> > Srinivas
> >=20
> > > ---
> > > Cc: Jiri Kosina <jikos@kernel.org>
> > > Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> > > Cc: Zhang Lixu <lixu.zhang@intel.com>
> > > ---
> > > =C2=A0drivers/iio/gyro/hid-sensor-gyro-3d.c=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 5 +++-=
-
> > > =C2=A0drivers/iio/humidity/hid-sensor-humidity.c=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 5 +++--
> > > =C2=A0drivers/iio/magnetometer/hid-sensor-magn-3d.c=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 | 21 ++++++-
> > > ----
> > > ----------
> > > =C2=A0drivers/iio/orientation/hid-sensor-incl-3d.c=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 7 ++++---
> > > =C2=A0.../iio/position/hid-sensor-custom-intel-hinge.c=C2=A0=C2=A0=C2=
=A0 |=C2=A0 4 ++--
> > > =C2=A05 files changed, 18 insertions(+), 24 deletions(-)
> > >=20
> > > diff --git a/drivers/iio/gyro/hid-sensor-gyro-3d.c
> > > b/drivers/iio/gyro/hid-sensor-gyro-3d.c
> > > index 66778315e86d..083e82cf561c 100644
> > > --- a/drivers/iio/gyro/hid-sensor-gyro-3d.c
> > > +++ b/drivers/iio/gyro/hid-sensor-gyro-3d.c
> > > @@ -182,8 +182,9 @@ static int gyro_3d_proc_event(struct
> > > hid_sensor_hub_device *hsdev,
> > > =C2=A0		if (!gyro_state->timestamp)
> > > =C2=A0			gyro_state->timestamp =3D
> > > iio_get_time_ns(indio_dev);
> > > =C2=A0
> > > -		iio_push_to_buffers_with_timestamp(indio_dev,
> > > &gyro_state->scan,
> > > -						=C2=A0=C2=A0 gyro_state-=C2=A0=20
> > > > timestamp);=C2=A0=20
> > > +		iio_push_to_buffers_with_ts(indio_dev,
> > > &gyro_state-=C2=A0=20
> > > > scan,=C2=A0=20
> > > +					=C2=A0=C2=A0=C2=A0 sizeof(gyro_state-=C2=A0=20
> > > > scan),=C2=A0=20
> > > +					=C2=A0=C2=A0=C2=A0 gyro_state-
> > > >timestamp);
> > > =C2=A0
> > > =C2=A0		gyro_state->timestamp =3D 0;
> > > =C2=A0	}
> > > diff --git a/drivers/iio/humidity/hid-sensor-humidity.c
> > > b/drivers/iio/humidity/hid-sensor-humidity.c
> > > index 12c88efe66be..c09986346c8f 100644
> > > --- a/drivers/iio/humidity/hid-sensor-humidity.c
> > > +++ b/drivers/iio/humidity/hid-sensor-humidity.c
> > > @@ -132,8 +132,9 @@ static int humidity_proc_event(struct
> > > hid_sensor_hub_device *hsdev,
> > > =C2=A0	struct hid_humidity_state *humid_st =3D
> > > iio_priv(indio_dev);
> > > =C2=A0
> > > =C2=A0	if (atomic_read(&humid_st-
> > > >common_attributes.data_ready))
> > > -		iio_push_to_buffers_with_timestamp(indio_dev,
> > > &humid_st->scan,
> > > -						=C2=A0=C2=A0
> > > iio_get_time_ns(indio_dev));
> > > +		iio_push_to_buffers_with_ts(indio_dev,
> > > &humid_st-=C2=A0=20
> > > > scan,=C2=A0=20
> > > +					=C2=A0=C2=A0=C2=A0 sizeof(humid_st-
> > > >scan),
> > > +					=C2=A0=C2=A0=C2=A0
> > > iio_get_time_ns(indio_dev));
> > > =C2=A0
> > > =C2=A0	return 0;
> > > =C2=A0}
> > > diff --git a/drivers/iio/magnetometer/hid-sensor-magn-3d.c
> > > b/drivers/iio/magnetometer/hid-sensor-magn-3d.c
> > > index c8b4fa7785c9..f869560b47fc 100644
> > > --- a/drivers/iio/magnetometer/hid-sensor-magn-3d.c
> > > +++ b/drivers/iio/magnetometer/hid-sensor-magn-3d.c
> > > @@ -37,8 +37,8 @@ struct magn_3d_state {
> > > =C2=A0	struct hid_sensor_common rot_attributes;
> > > =C2=A0	struct hid_sensor_hub_attribute_info
> > > magn[MAGN_3D_CHANNEL_MAX];
> > > =C2=A0
> > > -	/* dynamically sized array to hold sensor values */
> > > -	u32 *iio_vals;
> > > +	/* array sized to hold maximum set of sensor values */
> > > +	IIO_DECLARE_BUFFER_WITH_TS(u32, iio_vals,
> > > MAGN_3D_CHANNEL_MAX);
> > > =C2=A0	/* array of pointers to sensor value */
> > > =C2=A0	u32 *magn_val_addr[MAGN_3D_CHANNEL_MAX];
> > > =C2=A0
> > > @@ -275,9 +275,10 @@ static int magn_3d_proc_event(struct
> > > hid_sensor_hub_device *hsdev,
> > > =C2=A0		if (!magn_state->timestamp)
> > > =C2=A0			magn_state->timestamp =3D
> > > iio_get_time_ns(indio_dev);
> > > =C2=A0
> > > -		iio_push_to_buffers_with_timestamp(indio_dev,
> > > -						=C2=A0=C2=A0 magn_state-=C2=A0=20
> > > > iio_vals,=C2=A0=20
> > > -						=C2=A0=C2=A0 magn_state-=C2=A0=20
> > > > timestamp);=C2=A0=20
> > > +		iio_push_to_buffers_with_ts(indio_dev,
> > > +					=C2=A0=C2=A0=C2=A0 magn_state-
> > > >iio_vals,
> > > +					=C2=A0=C2=A0=C2=A0 sizeof(magn_state-=C2=A0=20
> > > > iio_vals),=C2=A0=20
> > > +					=C2=A0=C2=A0=C2=A0 magn_state-
> > > >timestamp);
> > > =C2=A0		magn_state->timestamp =3D 0;
> > > =C2=A0	}
> > > =C2=A0
> > > @@ -379,16 +380,6 @@ static int magn_3d_parse_report(struct
> > > platform_device *pdev,
> > > =C2=A0		return -ENOMEM;
> > > =C2=A0	}
> > > =C2=A0
> > > -	/* attr_count include timestamp channel, and the
> > > iio_vals
> > > should be aligned to 8byte */
> > > -	st->iio_vals =3D devm_kcalloc(&pdev->dev,
> > > -				=C2=A0=C2=A0=C2=A0 ((attr_count + 1) % 2 +
> > > (attr_count + 1) / 2) * 2,
> > > -				=C2=A0=C2=A0=C2=A0 sizeof(u32), GFP_KERNEL);
> > > -	if (!st->iio_vals) {
> > > -		dev_err(&pdev->dev,
> > > -			"failed to allocate space for iio values
> > > array\n");
> > > -		return -ENOMEM;
> > > -	}
> > > -
> > > =C2=A0	for (i =3D 0, *chan_count =3D 0;
> > > =C2=A0	i < MAGN_3D_CHANNEL_MAX && *chan_count < attr_count;
> > > =C2=A0	i++){
> > > diff --git a/drivers/iio/orientation/hid-sensor-incl-3d.c
> > > b/drivers/iio/orientation/hid-sensor-incl-3d.c
> > > index b5f70732d035..3880e479a499 100644
> > > --- a/drivers/iio/orientation/hid-sensor-incl-3d.c
> > > +++ b/drivers/iio/orientation/hid-sensor-incl-3d.c
> > > @@ -194,9 +194,10 @@ static int incl_3d_proc_event(struct
> > > hid_sensor_hub_device *hsdev,
> > > =C2=A0		if (!incl_state->timestamp)
> > > =C2=A0			incl_state->timestamp =3D
> > > iio_get_time_ns(indio_dev);
> > > =C2=A0
> > > -		iio_push_to_buffers_with_timestamp(indio_dev,
> > > -						=C2=A0=C2=A0 &incl_state-=C2=A0
> > > > scan,=C2=A0=20
> > > -						=C2=A0=C2=A0 incl_state-=C2=A0=20
> > > > timestamp);=C2=A0=20
> > > +		iio_push_to_buffers_with_ts(indio_dev,
> > > +					=C2=A0=C2=A0=C2=A0 &incl_state->scan,
> > > +					=C2=A0=C2=A0=C2=A0 sizeof(incl_state-=C2=A0=20
> > > > scan),=C2=A0=20
> > > +					=C2=A0=C2=A0=C2=A0 incl_state-
> > > >timestamp);
> > > =C2=A0
> > > =C2=A0		incl_state->timestamp =3D 0;
> > > =C2=A0	}
> > > diff --git a/drivers/iio/position/hid-sensor-custom-intel-hinge.c
> > > b/drivers/iio/position/hid-sensor-custom-intel-hinge.c
> > > index 101d84b533c9..98a5e3e03bba 100644
> > > --- a/drivers/iio/position/hid-sensor-custom-intel-hinge.c
> > > +++ b/drivers/iio/position/hid-sensor-custom-intel-hinge.c
> > > @@ -198,8 +198,8 @@ static int hinge_proc_event(struct
> > > hid_sensor_hub_device *hsdev,
> > > =C2=A0		if (!st->timestamp)
> > > =C2=A0			st->timestamp =3D
> > > iio_get_time_ns(indio_dev);
> > > =C2=A0
> > > -		iio_push_to_buffers_with_timestamp(indio_dev,
> > > &st-=C2=A0=20
> > > > scan,=C2=A0=20
> > > -						=C2=A0=C2=A0 st-
> > > >timestamp);
> > > +		iio_push_to_buffers_with_ts(indio_dev, &st-
> > > >scan,
> > > +					=C2=A0=C2=A0=C2=A0 sizeof(st->scan),
> > > st-=C2=A0=20
> > > > timestamp);=C2=A0=20
> > > =C2=A0
> > > =C2=A0		st->timestamp =3D 0;
> > > =C2=A0	}=C2=A0=20
> >=20
