Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.19
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793059597;
	b=Nbkp6DqHENUag2IkhNns+ZzvZ6pBYSyn5zSdPHv56EnQOvb6Jw+nDmtNQriR2cBgo1+G
	 1r6T7kPkxhAfQ5DcVihCjV9FdxoFBCOZZg8zKEqL6G1CPpLuh15IREWlwA1VGvWC347ux
	 akESHazuobP4kSK7agEMTWWmbTo5wiJnxH21Dk/mTqGlU5XaILKG/tGa0hA0cGz9n3Z/a
	 mUtKxcM38L7vyUS5TUCO/doCKWPWkfWHau8qrF/CnPo3tnGpIUJMkWI9JGfggZJ5rxj7m
	 bQnlkSfltGdmO4gbbSb8VEMLb9fJnLQqKl4gGstAuRw/KHOX5vmgqjjAeBu5l1WwfZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793059597;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Subject:
	 From:To:Cc:Date:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=T5U1reEtivZtSWkLpJ3kGwYw3w3qpVQlqtPrzn6cfnY=;
	b=eG7T5f4KI76p/vLSfGwwsYuKMK9b4f+vdnsQR1/lEHzxT/GRmhftD0IduQJJCXEKiqGf
	 WlT4NGd9oC7RhtFP6wxgzcQ4Nw2EHDUGavNAM/BGODQwsMMkN53Ze7BQYofqHoS3Oxfqd
	 xITUxppVkaJQe63RiFs6kJAvJkv/LqQMTKXfzMyi2Li1+h9kK36B5SYb3dZial0AuCZGR
	 C5jY9uVSPjIwLCaBeoPyqV5dEU5uMN6bgsUzBYFobKx9W2Dqie1gzKhNNlDIj0Kyd7iEO
	 gJXHu7BltNur3YYmk4kCO+eNnW0MP9QCjdevumHrmLjd1NF8vlDXBn9isOukxUJsi0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Nc1iocdc;
	arc=none smtp.remote-ip=192.198.163.19
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DBBF606A31A
	for <linux-iio@vger.kernel.org>; Tue, 27 Oct 2026 00:06:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4DBBF606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Nc1iocdc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793059597; x=1824595597;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=iJGeiO8c0hqgT7db4Ltu/eObwQ61kroLOSdhXJPQbYQ=;
  b=Nc1iocdcK38cX3c9ilQBZ5rHF4PQfhB6kTTwbGcts7+wRPVMn//R7wM0
   h/10gBLGwwZzfkw69u4tWYZH8fIQ1AtGb7iSvk+0SnnBVSmIdKC7IwE/s
   yjfMWLDPENpytnDe6oeqDYzQNG3MbmalH/NCr0BHpV+A6a9W2/LsP/YlJ
   hA50bgA2adRnWcRYn1KL3tNcpLVZPnlbQ1C4A9CmTE7a4CEjPgjULThEq
   UldeafcJxrjpejN2Vmo5I1viMiFNC14N77HOTJaMnq7M4Wy80ZtsSY/jc
   81s2Ykin0dW80Ub9cnW8La5/JpvhFE5+4h66H9Ukv4dDlP/4KQmV7OiqP
   g==;
X-CSE-ConnectionGUID: Jolg7MUeSYKBj3DX2IXfdA==
X-CSE-MsgGUID: 6howvqtvR069ytnsdCArzw==
X-IronPort-AV: E=McAfee;i="6800,10657,11947"; a="1854160"
X-IronPort-AV: E=Sophos;i="6.27,180,1787036400"; 
   d="scan'208";a="1854160"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 17:06:36 -0700
X-CSE-ConnectionGUID: zNa+AgrvS0mtKr0Papo6LQ==
X-CSE-MsgGUID: szKpg8fUSDWTLMNhxSdTNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,180,1787036400"; 
   d="scan'208";a="4482323"
Received: from bradocaj-mobl.ger.corp.intel.com (HELO [10.125.108.129]) ([10.125.108.129])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 17:06:36 -0700
Message-ID: <60eab26805ad63d1b39d80fb9a47b0ba9bb5789d.camel@linux.intel.com>
Subject: Re: [PATCH 05/39] iio: hid-sensors: use
 iio_push_to_buffers_with_ts()
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>, 
	linux-iio@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?=
	 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Jiri Kosina
	 <jikos@kernel.org>, Zhang Lixu <lixu.zhang@intel.com>
Date: Mon, 26 Oct 2026 17:06:23 -0700
In-Reply-To: <20261026-iio-v1-5-8b136778eedf@oss.qualcomm.com>
References: <20261026-iio-v1-0-8b136778eedf@oss.qualcomm.com>
	 <20261026-iio-v1-5-8b136778eedf@oss.qualcomm.com>
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

On Mon, 2026-10-26 at 16:05 -0700, Jonathan Cameron wrote:
> Replace the deprecated iio_push_to_buffers_with_timestamp() with
> iio_push_to_buffers_with_ts(), passing the size of the pushed buffer.
>=20
> For hid-sensor-magn-3d, use IIO_DECLARE_BUFFER_WITH_TS() to suize the
> buffer for the maximum number of channels supported avoiding need
> for separate allocation.
>=20
> Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

LGTM.
I will do some quick test on this and let you know.

Thanks,
Srinivas

> ---
> Cc: Jiri Kosina <jikos@kernel.org>
> Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Cc: Zhang Lixu <lixu.zhang@intel.com>
> ---
> =C2=A0drivers/iio/gyro/hid-sensor-gyro-3d.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 5 +++--
> =C2=A0drivers/iio/humidity/hid-sensor-humidity.c=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 5 +++--
> =C2=A0drivers/iio/magnetometer/hid-sensor-magn-3d.c=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 | 21 ++++++-----
> ----------
> =C2=A0drivers/iio/orientation/hid-sensor-incl-3d.c=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 7 ++++---
> =C2=A0.../iio/position/hid-sensor-custom-intel-hinge.c=C2=A0=C2=A0=C2=A0 =
|=C2=A0 4 ++--
> =C2=A05 files changed, 18 insertions(+), 24 deletions(-)
>=20
> diff --git a/drivers/iio/gyro/hid-sensor-gyro-3d.c
> b/drivers/iio/gyro/hid-sensor-gyro-3d.c
> index 66778315e86d..083e82cf561c 100644
> --- a/drivers/iio/gyro/hid-sensor-gyro-3d.c
> +++ b/drivers/iio/gyro/hid-sensor-gyro-3d.c
> @@ -182,8 +182,9 @@ static int gyro_3d_proc_event(struct
> hid_sensor_hub_device *hsdev,
> =C2=A0		if (!gyro_state->timestamp)
> =C2=A0			gyro_state->timestamp =3D
> iio_get_time_ns(indio_dev);
> =C2=A0
> -		iio_push_to_buffers_with_timestamp(indio_dev,
> &gyro_state->scan,
> -						=C2=A0=C2=A0 gyro_state-
> >timestamp);
> +		iio_push_to_buffers_with_ts(indio_dev, &gyro_state-
> >scan,
> +					=C2=A0=C2=A0=C2=A0 sizeof(gyro_state-
> >scan),
> +					=C2=A0=C2=A0=C2=A0 gyro_state->timestamp);
> =C2=A0
> =C2=A0		gyro_state->timestamp =3D 0;
> =C2=A0	}
> diff --git a/drivers/iio/humidity/hid-sensor-humidity.c
> b/drivers/iio/humidity/hid-sensor-humidity.c
> index 12c88efe66be..c09986346c8f 100644
> --- a/drivers/iio/humidity/hid-sensor-humidity.c
> +++ b/drivers/iio/humidity/hid-sensor-humidity.c
> @@ -132,8 +132,9 @@ static int humidity_proc_event(struct
> hid_sensor_hub_device *hsdev,
> =C2=A0	struct hid_humidity_state *humid_st =3D iio_priv(indio_dev);
> =C2=A0
> =C2=A0	if (atomic_read(&humid_st->common_attributes.data_ready))
> -		iio_push_to_buffers_with_timestamp(indio_dev,
> &humid_st->scan,
> -						=C2=A0=C2=A0
> iio_get_time_ns(indio_dev));
> +		iio_push_to_buffers_with_ts(indio_dev, &humid_st-
> >scan,
> +					=C2=A0=C2=A0=C2=A0 sizeof(humid_st->scan),
> +					=C2=A0=C2=A0=C2=A0
> iio_get_time_ns(indio_dev));
> =C2=A0
> =C2=A0	return 0;
> =C2=A0}
> diff --git a/drivers/iio/magnetometer/hid-sensor-magn-3d.c
> b/drivers/iio/magnetometer/hid-sensor-magn-3d.c
> index c8b4fa7785c9..f869560b47fc 100644
> --- a/drivers/iio/magnetometer/hid-sensor-magn-3d.c
> +++ b/drivers/iio/magnetometer/hid-sensor-magn-3d.c
> @@ -37,8 +37,8 @@ struct magn_3d_state {
> =C2=A0	struct hid_sensor_common rot_attributes;
> =C2=A0	struct hid_sensor_hub_attribute_info
> magn[MAGN_3D_CHANNEL_MAX];
> =C2=A0
> -	/* dynamically sized array to hold sensor values */
> -	u32 *iio_vals;
> +	/* array sized to hold maximum set of sensor values */
> +	IIO_DECLARE_BUFFER_WITH_TS(u32, iio_vals,
> MAGN_3D_CHANNEL_MAX);
> =C2=A0	/* array of pointers to sensor value */
> =C2=A0	u32 *magn_val_addr[MAGN_3D_CHANNEL_MAX];
> =C2=A0
> @@ -275,9 +275,10 @@ static int magn_3d_proc_event(struct
> hid_sensor_hub_device *hsdev,
> =C2=A0		if (!magn_state->timestamp)
> =C2=A0			magn_state->timestamp =3D
> iio_get_time_ns(indio_dev);
> =C2=A0
> -		iio_push_to_buffers_with_timestamp(indio_dev,
> -						=C2=A0=C2=A0 magn_state-
> >iio_vals,
> -						=C2=A0=C2=A0 magn_state-
> >timestamp);
> +		iio_push_to_buffers_with_ts(indio_dev,
> +					=C2=A0=C2=A0=C2=A0 magn_state->iio_vals,
> +					=C2=A0=C2=A0=C2=A0 sizeof(magn_state-
> >iio_vals),
> +					=C2=A0=C2=A0=C2=A0 magn_state->timestamp);
> =C2=A0		magn_state->timestamp =3D 0;
> =C2=A0	}
> =C2=A0
> @@ -379,16 +380,6 @@ static int magn_3d_parse_report(struct
> platform_device *pdev,
> =C2=A0		return -ENOMEM;
> =C2=A0	}
> =C2=A0
> -	/* attr_count include timestamp channel, and the iio_vals
> should be aligned to 8byte */
> -	st->iio_vals =3D devm_kcalloc(&pdev->dev,
> -				=C2=A0=C2=A0=C2=A0 ((attr_count + 1) % 2 +
> (attr_count + 1) / 2) * 2,
> -				=C2=A0=C2=A0=C2=A0 sizeof(u32), GFP_KERNEL);
> -	if (!st->iio_vals) {
> -		dev_err(&pdev->dev,
> -			"failed to allocate space for iio values
> array\n");
> -		return -ENOMEM;
> -	}
> -
> =C2=A0	for (i =3D 0, *chan_count =3D 0;
> =C2=A0	i < MAGN_3D_CHANNEL_MAX && *chan_count < attr_count;
> =C2=A0	i++){
> diff --git a/drivers/iio/orientation/hid-sensor-incl-3d.c
> b/drivers/iio/orientation/hid-sensor-incl-3d.c
> index b5f70732d035..3880e479a499 100644
> --- a/drivers/iio/orientation/hid-sensor-incl-3d.c
> +++ b/drivers/iio/orientation/hid-sensor-incl-3d.c
> @@ -194,9 +194,10 @@ static int incl_3d_proc_event(struct
> hid_sensor_hub_device *hsdev,
> =C2=A0		if (!incl_state->timestamp)
> =C2=A0			incl_state->timestamp =3D
> iio_get_time_ns(indio_dev);
> =C2=A0
> -		iio_push_to_buffers_with_timestamp(indio_dev,
> -						=C2=A0=C2=A0 &incl_state-
> >scan,
> -						=C2=A0=C2=A0 incl_state-
> >timestamp);
> +		iio_push_to_buffers_with_ts(indio_dev,
> +					=C2=A0=C2=A0=C2=A0 &incl_state->scan,
> +					=C2=A0=C2=A0=C2=A0 sizeof(incl_state-
> >scan),
> +					=C2=A0=C2=A0=C2=A0 incl_state->timestamp);
> =C2=A0
> =C2=A0		incl_state->timestamp =3D 0;
> =C2=A0	}
> diff --git a/drivers/iio/position/hid-sensor-custom-intel-hinge.c
> b/drivers/iio/position/hid-sensor-custom-intel-hinge.c
> index 101d84b533c9..98a5e3e03bba 100644
> --- a/drivers/iio/position/hid-sensor-custom-intel-hinge.c
> +++ b/drivers/iio/position/hid-sensor-custom-intel-hinge.c
> @@ -198,8 +198,8 @@ static int hinge_proc_event(struct
> hid_sensor_hub_device *hsdev,
> =C2=A0		if (!st->timestamp)
> =C2=A0			st->timestamp =3D iio_get_time_ns(indio_dev);
> =C2=A0
> -		iio_push_to_buffers_with_timestamp(indio_dev, &st-
> >scan,
> -						=C2=A0=C2=A0 st->timestamp);
> +		iio_push_to_buffers_with_ts(indio_dev, &st->scan,
> +					=C2=A0=C2=A0=C2=A0 sizeof(st->scan), st-
> >timestamp);
> =C2=A0
> =C2=A0		st->timestamp =3D 0;
> =C2=A0	}
