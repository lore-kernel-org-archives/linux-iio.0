Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37400486B8F;
	Sun, 20 Sep 2026 23:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789946984; cv=none; b=eBOtVwnX0pWpe3jCwtbUxHSe4PCPuiNor4KaNQundmIjSy1QDJSgskmf9qDbkAbuHXGMy4ZvqRCSN7hINbPEW7OeqjxYvo38qQ7/9c3jWay3qxsq6yTHN9wt5oehCQXbYKpQ8zLqvabE34rMy4DwkdoP9ginw7x96WnMFdJJKh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789946984; c=relaxed/simple;
	bh=N2Au9r+zMcyHCgr4T8u1BEPd546PYXxMg/KsTwAtO3E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bI0yXiI1pkvpJ3T4vYpNgyKjKX4RhK86n/XL/dApc7JXKAoxF4Niqho02ADne1mzWkhB+YJwXDlY3m1HIGPDin2ghIwRXtg9ZoJp9bSFt8JcNDnp0qDJdl3ZoxTkTLL39X3P9wAZGi5donwvatxXcR4YRzCto8VdIIJyoq2yqRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gX1tS/uy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gX1tS/uy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BB421F000FF;
	Sun, 20 Sep 2026 23:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789946982;
	bh=MEkF27XUvCQ5Nvijd1E9vzEq6RzWp47jl2fDe/xRNJ0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=gX1tS/uyS1TSvfxYWk/Y5C2Xn12QJ/2ZebP3aPL3FCdlIMiQCF8vb5qB1HuV1PBgw
	 HlgQ/rfaO1fAbwboAP7V2lw+nckAHST4jkLGT3+X8bEGDPeBJHV6yPc+DptwUINujd
	 iSuUx+lx09QZLY1U/mPzTlVrSYpCQkf1RVzd0PHFOAxqVo1cpsHOAVa9FDYg1YhZ8S
	 O7x84GuTdQmMgxxwRJGlZjqpy6W91FKjKrIW2p+4m9Q93VutHiQROV0pjsRy46xkoI
	 7gGt97HFa28ExzM65441rI789hLLadiygID1hLIVgQdBhz2gYrbN6rn33BE3ynhcTi
	 dDGtB+QcRFULQ==
Date: Mon, 21 Sep 2026 00:29:36 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: Kanak Shilledar <kanak.shilledar@axis.com>, Henrik Grimler
 <henrik.grimler@axis.com>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jean-Baptiste Maneyrol
 <jean-baptiste.maneyrol@tdk.com>, Joshua Crofts <joshua.crofts1@gmail.com>,
 Chris Morgan <macromorgan@hotmail.com>, kernel@axis.com,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/5] iio: imu: inv_icm42607: Simplify IIO channel
 macros
Message-ID: <20260921002936.6e06e790@jic23-hlaptop>
In-Reply-To: <aq_lwtGT8G-BTLM2@debian-BULLSEYE-live-builder-AMD64>
References: <20260917-b4-inv_icm42370p-v4-0-fd9373f123c9@axis.com>
	<20260917-b4-inv_icm42370p-v4-2-fd9373f123c9@axis.com>
	<aq_lwtGT8G-BTLM2@debian-BULLSEYE-live-builder-AMD64>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 20 Sep 2026 10:55:14 -0300
Marcelo Schmitt <marcelo.schmitt1@gmail.com> wrote:

> On 09/17, Kanak Shilledar wrote:
> > The INV_ICM42607_ACCEL_CHAN and INV_ICM42607_GYRO_CHAN macro had a third
> > parameter of _ext_info, drop it and just point the .ext_info field to
> > the respective inv_icm42607_*_ext_infos. This reduces the repetitive
> > calling of inv_icm42607_*_ext_infos struct in the IIO channel spec
> > struct and makes the code more easy to follow.
> > 
> > Signed-off-by: Kanak Shilledar <kanak.shilledar@axis.com>
> > ---
> >  drivers/iio/imu/inv_icm42607/inv_icm42607_accel.c | 23 ++++++++++-------------
> >  drivers/iio/imu/inv_icm42607/inv_icm42607_gyro.c  | 23 ++++++++++-------------
> >  2 files changed, 20 insertions(+), 26 deletions(-)
> > 
> > diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_accel.c b/drivers/iio/imu/inv_icm42607/inv_icm42607_accel.c
> > index 0b3f035c2da0c..8f61bc9014526 100644
> > --- a/drivers/iio/imu/inv_icm42607/inv_icm42607_accel.c
> > +++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_accel.c
> > @@ -17,7 +17,7 @@
> >  #include "inv_icm42607.h"
> >  #include "inv_icm42607_temp.h"
> >  
> > -#define INV_ICM42607_ACCEL_CHAN(_modifier, _index, _ext_info)			\
> > +#define INV_ICM42607_ACCEL_CHAN(_modifier, _index)				\
> >  {										\
> >  	.type = IIO_ACCEL,							\
> >  	.modified = 1,								\
> > @@ -34,9 +34,14 @@
> >  		.storagebits = 16,						\
> >  		.endianness = IIO_BE,						\
> >  	},									\
> > -	.ext_info = _ext_info,							\
> > +	.ext_info = inv_icm42607_accel_ext_infos,				\
> >  }
> >  
> > +static const struct iio_chan_spec_ext_info inv_icm42607_accel_ext_infos[] = {
> > +	IIO_MOUNT_MATRIX(IIO_SHARED_BY_ALL, inv_icm42607_get_mount_matrix),
> > +	{ }
> > +};
> > +  
> Moving iio_chan_spec_ext_info declaration upwards looks like a spurious change.
> If moving the declaration upwards is really needed, the commit message could
> have a phrase or two explaining why.

It would have some sort of logic if they were before the .ext_info
in the macro just on basis we generally expect to look earlier
in a file for things that are used.  Obviously doesn't matter
given that is in a macro called much later.

Fully agree some explanatory comments would be useful!

Jonathan

> 
> >  enum inv_icm42607_accel_scan {
> >  	INV_ICM42607_ACCEL_SCAN_X,
> >  	INV_ICM42607_ACCEL_SCAN_Y,
> > @@ -44,18 +49,10 @@ enum inv_icm42607_accel_scan {
> >  	INV_ICM42607_ACCEL_SCAN_TEMP,
> >  };
> >  
> > -static const struct iio_chan_spec_ext_info inv_icm42607_accel_ext_infos[] = {
> > -	IIO_MOUNT_MATRIX(IIO_SHARED_BY_ALL, inv_icm42607_get_mount_matrix),
> > -	{ }
> > -};
> > -
> >  static const struct iio_chan_spec inv_icm42607_accel_channels[] = {
> > -	INV_ICM42607_ACCEL_CHAN(IIO_MOD_X, INV_ICM42607_ACCEL_SCAN_X,
> > -				inv_icm42607_accel_ext_infos),
> > -	INV_ICM42607_ACCEL_CHAN(IIO_MOD_Y, INV_ICM42607_ACCEL_SCAN_Y,
> > -				inv_icm42607_accel_ext_infos),
> > -	INV_ICM42607_ACCEL_CHAN(IIO_MOD_Z, INV_ICM42607_ACCEL_SCAN_Z,
> > -				inv_icm42607_accel_ext_infos),
> > +	INV_ICM42607_ACCEL_CHAN(IIO_MOD_X, INV_ICM42607_ACCEL_SCAN_X),
> > +	INV_ICM42607_ACCEL_CHAN(IIO_MOD_Y, INV_ICM42607_ACCEL_SCAN_Y),
> > +	INV_ICM42607_ACCEL_CHAN(IIO_MOD_Z, INV_ICM42607_ACCEL_SCAN_Z),
> >  	INV_ICM42607_TEMP_CHAN(INV_ICM42607_ACCEL_SCAN_TEMP),
> >  };
> >  
> > diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_gyro.c b/drivers/iio/imu/inv_icm42607/inv_icm42607_gyro.c
> > index 5b4683c2dd1e4..8e8d36461e515 100644
> > --- a/drivers/iio/imu/inv_icm42607/inv_icm42607_gyro.c
> > +++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_gyro.c
> > @@ -17,7 +17,7 @@
> >  #include "inv_icm42607.h"
> >  #include "inv_icm42607_temp.h"
> >  
> > -#define INV_ICM42607_GYRO_CHAN(_modifier, _index, _ext_info)			\
> > +#define INV_ICM42607_GYRO_CHAN(_modifier, _index)				\
> >  {										\
> >  	.type = IIO_ANGL_VEL,							\
> >  	.modified = 1,								\
> > @@ -34,9 +34,14 @@
> >  		.storagebits = 16,						\
> >  		.endianness = IIO_BE,						\
> >  	},									\
> > -	.ext_info = _ext_info,							\
> > +	.ext_info = inv_icm42607_gyro_ext_infos,				\
> >  }
> >  
> > +static const struct iio_chan_spec_ext_info inv_icm42607_gyro_ext_infos[] = {
> > +	IIO_MOUNT_MATRIX(IIO_SHARED_BY_ALL, inv_icm42607_get_mount_matrix),
> > +	{ }
> > +};
> > +  
> Same here, why moving inv_icm42607_gyro_ext_infos declarations up is necessary?
> 
> >  enum inv_icm42607_gyro_scan {
> >  	INV_ICM42607_GYRO_SCAN_X,
> >  	INV_ICM42607_GYRO_SCAN_Y,
> > @@ -44,18 +49,10 @@ enum inv_icm42607_gyro_scan {
> >  	INV_ICM42607_GYRO_SCAN_TEMP,
> >  };
> >  
> > -static const struct iio_chan_spec_ext_info inv_icm42607_gyro_ext_infos[] = {
> > -	IIO_MOUNT_MATRIX(IIO_SHARED_BY_ALL, inv_icm42607_get_mount_matrix),
> > -	{ }
> > -};
> > -
> >  static const struct iio_chan_spec inv_icm42607_gyro_channels[] = {
> > -	INV_ICM42607_GYRO_CHAN(IIO_MOD_X, INV_ICM42607_GYRO_SCAN_X,
> > -			       inv_icm42607_gyro_ext_infos),
> > -	INV_ICM42607_GYRO_CHAN(IIO_MOD_Y, INV_ICM42607_GYRO_SCAN_Y,
> > -			       inv_icm42607_gyro_ext_infos),
> > -	INV_ICM42607_GYRO_CHAN(IIO_MOD_Z, INV_ICM42607_GYRO_SCAN_Z,
> > -			       inv_icm42607_gyro_ext_infos),
> > +	INV_ICM42607_GYRO_CHAN(IIO_MOD_X, INV_ICM42607_GYRO_SCAN_X),
> > +	INV_ICM42607_GYRO_CHAN(IIO_MOD_Y, INV_ICM42607_GYRO_SCAN_Y),
> > +	INV_ICM42607_GYRO_CHAN(IIO_MOD_Z, INV_ICM42607_GYRO_SCAN_Z),
> >  	INV_ICM42607_TEMP_CHAN(INV_ICM42607_GYRO_SCAN_TEMP),
> >  };
> >  
> > 
> > -- 
> > 2.43.0
> >   

