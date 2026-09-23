Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 589C73E49E9;
	Wed, 23 Sep 2026 17:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790184898; cv=none; b=XB8DCVMcKjGMWvqQSGl/x5WkF70vqkWiAJfW2s03lwpoOkjygbD1EclfqKh34MJPFpEHG6hPbMHzj7psDNk/lRDnAaMmRexlFSGa8mAi/C0apFPAtRq4JRjn9bS2vLBijRG24WUg2Esg/2WB/9YS/3VqJpMKg8mL+qFTYZhdGJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790184898; c=relaxed/simple;
	bh=J4J9x7yb7BhfvES9FzHgh7nrcdN+UU5L6GtQWwjAvLw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BGa5usgBaVUAi1Z6K5r8MBm3D20+Pcvspkdjss7ApQL3ffSXnJzP3iK4mB5i6CO6vY4a633fcQ4niLtHrvY9cy32IZxw8sGpr1zM7kDEnwXOMi8XFuhjRjKMfQVHHKqxdDrxihw4PljEiA6t/Dh5LA3Lpftun8mRXegvbb0+IeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n0tv4Fdc; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n0tv4Fdc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790184897; x=1821720897;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=J4J9x7yb7BhfvES9FzHgh7nrcdN+UU5L6GtQWwjAvLw=;
  b=n0tv4FdcHnO4IHyXzFYhddfC21ufin0WdD2WzxC2XP/Bg8F0rO13gmSv
   gu2+rWkEcgLhWzBjIyKJRSGfYgm6KiXuscjdbr2Gqt4rQv0L6n0byWsBI
   P5r/5W+u1onOuPN0mE0YANl7M2xiBch1PiDXxWc8+gR3+rUeZLyYa1ML9
   TG4ymL8gtLc7QMuVbyiQFrYrfeB6l+okp4YBU9CNteqA2BZhjqJNqeN89
   2WseZDlh578DtvtYXrLwbLaPrCMnabSCoUtmsyV111EoM7c54rcFNzgkY
   kpyomTqC+0WT02p4Y2Xg4b1XOewuCV12sC4tCjPEXf870iAK1ycYTumeA
   A==;
X-CSE-ConnectionGUID: 1sSEPiUUSfKxTEStJcsfyQ==
X-CSE-MsgGUID: sUs8crMBTkKpTowgpvMW5w==
X-IronPort-AV: E=McAfee;i="6800,10657,11914"; a="78464759"
X-IronPort-AV: E=Sophos;i="6.27,119,1787036400"; 
   d="scan'208";a="78464759"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2026 10:34:56 -0700
X-CSE-ConnectionGUID: uvt6cm+uSqyX09TY0OaAuA==
X-CSE-MsgGUID: fIOZ0hjbQk2Izydzz85PgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,119,1787036400"; 
   d="scan'208";a="4801411"
Received: from spandruv-desk2.jf.intel.com ([10.24.80.14])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2026 10:34:55 -0700
Message-ID: <319e10c431f821e672a378943784b6c650b13fab.camel@linux.intel.com>
Subject: Re: [PATCH] iio: accel: bmc150: check reset write error
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: cdcp206@gmail.com, Jonathan Cameron <jic23@kernel.org>, David Lechner
	 <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>, 
 Andy Shevchenko
	 <andy@kernel.org>, Olof Johansson <olof@lixom.net>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 23 Sep 2026 10:34:55 -0700
In-Reply-To: <20260923-iio-bmc150-check-reset-error-v1-1-b8c1ebc4c947@gmail.com>
References: 
	<20260923-iio-bmc150-check-reset-error-v1-1-b8c1ebc4c947@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-09-23 at 11:41 -0500, Carlos Casadiego via B4 Relay wrote:
> From: Carlos Casadiego <cdcp206@gmail.com>
>=20
> The software reset is required to bring the device into a known
> state before reading the chip ID.
>=20
> Check the return value of regmap_write() and abort initialization if
> the reset command cannot be written.
>=20
> Fixes: 1c500840934a ("iio: accel: bmc150: reset chip at init time")
>=20
> Signed-off-by: Carlos Casadiego <cdcp206@gmail.com>

Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

> ---
> =C2=A0drivers/iio/accel/bmc150-accel-core.c | 8 ++++++--
> =C2=A01 file changed, 6 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/iio/accel/bmc150-accel-core.c
> b/drivers/iio/accel/bmc150-accel-core.c
> index 46bb36d9366e..43a39e1ccce5 100644
> --- a/drivers/iio/accel/bmc150-accel-core.c
> +++ b/drivers/iio/accel/bmc150-accel-core.c
> @@ -1561,8 +1561,12 @@ static int bmc150_accel_chip_init(struct
> bmc150_accel_data *data)
> =C2=A0	 * Reset chip to get it in a known good state. A delay of
> 1.8ms after
> =C2=A0	 * reset is required according to the data sheets of
> supported chips.
> =C2=A0	 */
> -	regmap_write(data->regmap, BMC150_ACCEL_REG_RESET,
> -		=C2=A0=C2=A0=C2=A0=C2=A0 BMC150_ACCEL_RESET_VAL);
> +	ret =3D regmap_write(data->regmap, BMC150_ACCEL_REG_RESET,
> +			=C2=A0=C2=A0 BMC150_ACCEL_RESET_VAL);
> +	if (ret < 0) {
> +		dev_err(dev, "Error writing reset register\n");
> +		return ret;
> +	}
> =C2=A0	usleep_range(1800, 2500);
> =C2=A0
> =C2=A0	ret =3D regmap_read(data->regmap, BMC150_ACCEL_REG_CHIP_ID,
> &val);
>=20
> ---
> base-commit: d8c0f48f0b1583308a98401c0c7b1a65d1d43a6c
> change-id: 20260923-iio-bmc150-check-reset-error-389b096b0ad4
>=20
> Best regards,
> --=C2=A0=20
> Carlos Casadiego <cdcp206@gmail.com>
>=20
