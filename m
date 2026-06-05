Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E7336CDFD;
	Fri,  5 Jun 2026 17:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780681666; cv=none; b=muoZbDE73BYO+l6amg6ez3L7AHy3tPUXp4XZhmkIqnjVgNLCMlpiTNuzznfnkVZEQjuYxHDC8LgbkvyxNcgdZfx2toTXeNdPLFcd+H1vGwIO91+el6stDgfa5g/etOcysw4AWwdCZiyAO9gXCZQAkrcHiSWY7+UqzxytrNCLzxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780681666; c=relaxed/simple;
	bh=iFckiDNyiON/IdX8+g1901W3jvIFJdYTVUDj1qnv3i0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DWyljVrG9kLYDCFORC58ZfdpXPKk9r38FQHhRh6kp2UP9oyIVZoUIANy9VJAOg2KzqvlwwV5K6D3fhGuEmfyhG7bsqjSIbyt+B0DAeGHA4SrSPxmjB/NAyM4VLIieggOQ2QlvA3uislJbHhRE/Tfz75hKhZUy1ye2JpWqQseXhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WTWF5eFb; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WTWF5eFb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780681662; x=1812217662;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=iFckiDNyiON/IdX8+g1901W3jvIFJdYTVUDj1qnv3i0=;
  b=WTWF5eFb3orCyfqi0ez3nAHKZgp5dEmkF+7f5b6ZmXaDF3DGmaw1fsDw
   wh+kcMAlfKFk/5cL0t7RdWWjEw5VDtpuuzc47JSvosTK+BQwJ2aiBIMGp
   AmENPrNla7CuJjkPejXPxj98SJ7bvCUbPjomOfeLOa07dshY0V//cE/Xp
   4Q82y0mV9SPgmuQLtfDdX0A1exT6Rqevsyo6vTeBJxAy+NlOpuDrKocQi
   DjIQ0WKoaBT3ZtRD6ZflQ211J9PZlGbxtZ2leBr0tpsRAU/wgLQrqTYnd
   SODYk7erfO/ZvHy+GJt9IwRY/T1l5VlIcnHJzg9nhoQQTcenFOAoG0Z/5
   Q==;
X-CSE-ConnectionGUID: hvhuhM7hR6GxzpqOftcpKA==
X-CSE-MsgGUID: MJl/FEGjSM+ewpQ0ND1IGg==
X-IronPort-AV: E=McAfee;i="6800,10657,11808"; a="81377348"
X-IronPort-AV: E=Sophos;i="6.24,189,1774335600"; 
   d="scan'208";a="81377348"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2026 10:47:42 -0700
X-CSE-ConnectionGUID: t19rByvZRkmt7/IH2dhyVg==
X-CSE-MsgGUID: zQ0/xsGPSkqtoUGd0PEupA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,189,1774335600"; 
   d="scan'208";a="240449450"
Received: from ettammin-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.178])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2026 10:47:38 -0700
Date: Fri, 5 Jun 2026 20:47:36 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Herman van Hazendonk <github.com@herrie.org>
Cc: jic23@kernel.org, linusw@kernel.org, denis.ciocca@st.com,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	sanjayembeddedse@gmail.com, maudspierings@gocontroll.com,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] iio: common: st_sensors: honour channel endianness
 in read_axis_data
Message-ID: <aiMLuIlRPHXuj3cH@ashevche-desk.local>
References: <cover.1780652883.git.github.com@herrie.org>
 <0dac8e8e2872dc180b138923b5cd4fd18eee047b.1780652883.git.github.com@herrie.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0dac8e8e2872dc180b138923b5cd4fd18eee047b.1780652883.git.github.com@herrie.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Jun 05, 2026 at 12:08:41PM +0200, Herman van Hazendonk wrote:
> st_sensors_read_axis_data() unconditionally decoded multi-byte
> results with get_unaligned_le16() / get_unaligned_le24() regardless
> of the channel's declared scan_type.endianness.
> 
> For every ST sensor that has used this helper since it was introduced
> this happened to be fine because the ST IMU/accel/gyro/pressure
> families publish their data registers as little-endian and the
> channel specs in those drivers declare IIO_LE accordingly.
> 
> The LSM303DLH magnetometer however publishes its X/Y/Z output as a
> pair of big-endian bytes (the H register sits at the lower address,
> 0x03/0x05/0x07, and the L register immediately after), and its
> channel specs in st_magn_core.c correctly declare IIO_BE -- but
> read_axis_data() ignored that and decoded as little-endian, swapping
> the high and low bytes of every magnetometer sample.
> 
> The bug is most visible on a stationary chip: in earth's field the
> true X reading is small and the high byte sits at 0x00, so swapping
> the bytes pins sysfs X at exactly the low byte's pattern (e.g. 0x00F0
> = 240). Y and Z still appear "to vary" because their magnitudes are
> larger and the noise in the low byte produces big swings in the
> swapped high byte:
> 
>   before (chip flat, sysfs in_magn_*_raw):
>       X=240 (stuck), Y= 12032..23296, Z=-16128..-9728
> 
>   after (direct i2c-dev big-endian decode, same chip same orientation):
>       X≈-4096, Y≈210, Z≈80     (sensible values reflecting earth's
>                                 ambient field at low gauss range)
> 
> Fix read_axis_data() to dispatch on ch->scan_type.endianness and
> call get_unaligned_be16() / get_unaligned_be24() when the channel
> declares IIO_BE. Existing IIO_LE consumers (st_accel, st_gyro,
> st_pressure, st_lsm6dsx and others) are unaffected because their
> channel specs already declare IIO_LE and the LE path is unchanged.

...

> -	if (byte_for_channel == 1)
> +	if (byte_for_channel == 1) {
>  		*data = (s8)*outdata;

Maybe for the consistency's sake use sign_extend32() everywhere?

> +	} else if (byte_for_channel == 2) {
> +		if (ch->scan_type.endianness == IIO_BE)
> +			*data = (s16)get_unaligned_be16(outdata);
> +		else
> +			*data = (s16)get_unaligned_le16(outdata);
> +	} else if (byte_for_channel == 3) {
> +		if (ch->scan_type.endianness == IIO_BE)
> +			*data = (s32)sign_extend32(get_unaligned_be24(outdata),
> +						   23);
> +		else
> +			*data = (s32)sign_extend32(get_unaligned_le24(outdata),
> +						   23);

Why do you need casting here? sign_extend32() should return signed type.
With this being addressed, you can make them one-liners.

> +	}

	u32 tmp;
	...
	if (byte_for_channel == 1) {
		// this way is done to show the below variant
		tmp = *outdata;
		*data = sign_extend32(tmp, 7);
	} else if (byte_for_channel == 2) {
		if (ch->scan_type.endianness == IIO_BE)
			tmp = get_unaligned_be16(outdata);
		else
			tmp = get_unaligned_le16(outdata);
		*data = sign_extend32(tmp, 15);
	} else if (byte_for_channel == 3) {
		if (ch->scan_type.endianness == IIO_BE)
			tmp = get_unaligned_be24(outdata);
		else
			tmp = get_unaligned_le24(outdata);
		*data = sign_extend32(tmp, 23);
	}

Or even

	if (byte_for_channel == 1) {
		tmp = *outdata;
	} else if (byte_for_channel == 2) {
		if (ch->scan_type.endianness == IIO_BE)
			tmp = get_unaligned_be16(outdata);
		else
			tmp = get_unaligned_le16(outdata);
	} else if (byte_for_channel == 3) {
		if (ch->scan_type.endianness == IIO_BE)
			tmp = get_unaligned_be24(outdata);
		else
			tmp = get_unaligned_le24(outdata);
	} else {
		...error...
	}
	*data = sign_extend32(tmp, BYTES_TO_BITS(byte_for_channel) - 1);


-- 
With Best Regards,
Andy Shevchenko


