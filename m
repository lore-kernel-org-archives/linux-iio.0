Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E17604E50DA;
	Wed, 16 Sep 2026 18:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789584880; cv=none; b=rJQNxRlP5Nol/dGGiWsu2ekPY1piHqm0BQR6awZhjz5EuMQ/NnpNsShXe87rtX3d5i0L6KAlBSLoGfGcyBDNPDU9jMg13R3+BTlqHsd/zHcCr7Y/6VTfFt/fU1vPKjLtbWkfhy3m1wE6NSe+HLFbV2misNkJWGkfX2fxrWYRpxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789584880; c=relaxed/simple;
	bh=SMlESME6LzE8aWZ4w5NQ7hdeXoi4bkuAKaow3g5fvno=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hFgrpMinOcb1mUVl/+TIlNxRGhDQJkC5+KwNuPX5BYNbrGEYkUNC/pUXPQiadYy9hRSZ5AurSSoqD99+XYE045d+dcCzAKY6OCsvLaHuMLc7dp4y6NbYd/0/QDmyJuQ0rS27bC9ZpYVl6R+j/8diSMi+NOp+UYSYppP0SSKPMRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=cq9915zt; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="cq9915zt"
Received: by linux.microsoft.com (Postfix, from userid 1223)
	id D023720B716B; Wed, 16 Sep 2026 11:53:46 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D023720B716B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1789584826;
	bh=NfAoFtUCX6VZ/JKK2qenkRKz/IcHyzV5zXJg6s1JGF0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cq9915ztSf7QwAOkagUlWQTmJv8Fci/xE5Y0rpERB4Vwob7sbKz0LnsPTWFYPoNsM
	 feK1RMsy4ZoYtTQN9dNQc4misdm98EBqKMzaEVNiUfkCr/bzuTQKxVobdna3Oqd9Ra
	 l/NfoeHO7d0GK+/c+tielE7D5cggJezH6J8drc4c=
Date: Wed, 16 Sep 2026 11:53:46 -0700
From: Meagan Lloyd <meaganlloyd@linux.microsoft.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Meagan Lloyd <meaganlloyd@linux.microsoft.com>,
	linux-i3c@lists.infradead.org, alexandre.belloni@bootlin.com,
	vitor.soares@toradex.com, samagazaryan@google.com,
	gregkh@linuxfoundation.org, arnd@arndb.de,
	boris.brezillon@collabora.com,
	oleksandr.shulzhenko.viktorovych@intel.com,
	tgopinath@linux.microsoft.com, corbet@lwn.net,
	skhan@linuxfoundation.org, linux@roeck-us.net, Frank.Li@nxp.com,
	jorge.marques@analog.com, pgaj@cadence.com,
	wsa+renesas@sang-engineering.com, tommaso.merciai.xr@bp.renesas.com,
	nuno.sa@analog.com, Michael.Hennerich@analog.com,
	dlechner@baylibre.com, andy@kernel.org, lorenzo@kernel.org,
	enelsonmoore@gmail.com, rppt@kernel.org, pratyush@kernel.org,
	giovanni.cabiddu@intel.com, gabewhigham@gmail.com,
	haren@linux.ibm.com, pasha.tatashin@soleen.com,
	jirislaby@kernel.org, adrian.ho.yin.ng@altera.com,
	ustc.gu@gmail.com, jszhang@kernel.org, adrian.hunter@intel.com,
	akhilrajeev@nvidia.com, tze.yee.ng@altera.com,
	manikanta.guntupalli@amd.com, shubhrajyoti.datta@amd.com,
	jarkko.nikula@linux.intel.com, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
	linux@analog.com, linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/3] i3c: master: enable driver_override for I3C
Message-ID: <20260916-c8d89d21698f12bf50c8b656@linux.microsoft.com>
References: <20260911210935.1353126-1-meaganlloyd@linux.microsoft.com>
 <20260911210935.1353126-2-meaganlloyd@linux.microsoft.com>
 <20260913012416.165c5886@jic23-hlaptop>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260913012416.165c5886@jic23-hlaptop>

> > Opt-in to driver_override sysfs functionality for I3C subsystem.
> > 
> > Update some I3C drivers that are assuming that if their .probe is
> > invoked that the bus match function already checked the ID table. Go
> > ahead and verify in .probe that i3c_device_match_id() returns a valid
> > match before using the i3c_device_id pointer.
> > 
> > Signed-off-by: Meagan Lloyd <meaganlloyd@linux.microsoft.com>
> > Assisted-by: Claude:claude-opus-4.8 copilot
> 
> Along with splitting these up as this is the sort of change that
> will sometimes need backporting in individual drivers because we are
> layering something on top, I'd look at adding some helpers to skip
> the id as that isn't much used and get the specific fields people
> want.

Yeah, I'll split these up for each individual driver.

i3c_device_match_data() is a good idea. It would reduce the likelihood
that future drivers make the mistake of not checking the id before
dereferencing it for data. I'll include it in the next revision.

Best regards,
Meagan
> 
> > diff --git a/drivers/hwmon/tmp108.c b/drivers/hwmon/tmp108.c
> > index 1c4a58855e2d..98076ae8dce8 100644
> > --- a/drivers/hwmon/tmp108.c
> > +++ b/drivers/hwmon/tmp108.c
> > @@ -581,6 +581,8 @@ static int p3t1085_i3c_probe(struct i3c_device *i3cdev)
> >  				     "Failed to register i3c regmap\n");
> >  
> >  	id = i3c_device_match_id(i3cdev, p3t1085_i3c_ids);
> > +	if (!id)
> > +		return -ENODEV;
> >  
> >  	return tmp108_common_probe(dev, regmap, "p3t1085_i3c", id->data);
> 
> Similar to below, jumping directly to an i3c_device_match_data() helper
> in this series would avoid getting and id that these drivers don't
> need access to.
> 

I acknowledge and agree.

> >  }
> 
> > diff --git a/drivers/iio/adc/ad4062.c b/drivers/iio/adc/ad4062.c
> > index 8e5984055b15..f28b503d16eb 100644
> > --- a/drivers/iio/adc/ad4062.c
> > +++ b/drivers/iio/adc/ad4062.c
> > @@ -1482,14 +1482,20 @@ MODULE_DEVICE_TABLE(i3c, ad4062_id_table);
> >  
> >  static int ad4062_probe(struct i3c_device *i3cdev)
> >  {
> > -	const struct i3c_device_id *id = i3c_device_match_id(i3cdev, ad4062_id_table);
> > -	const struct ad4062_chip_info *chip = id->data;
> > +	const struct i3c_device_id *id;
> > +	const struct ad4062_chip_info *chip;
> >  	struct device *dev = &i3cdev->dev;
> >  	struct iio_dev *indio_dev;
> >  	struct ad4062_state *st;
> >  	bool ref_sel;
> >  	int ret;
> >  
> > +	id = i3c_device_match_id(i3cdev, ad4062_id_table);
> > +	if (!id)
> > +		return -ENODEV;
> > +
> > +	chip = id->data;
> 
> This might be a good opportunity to introduce
> 
> i3c_device_match_data() as in many drivers we don't actually care about
> access to the id itself.
> 
> > +
> >  	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
> >  	if (!indio_dev)
> >  		return -ENOMEM;
> > diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i3c.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i3c.c
> > index cb5c5d7e1f3d..153a03e06801 100644
> > --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i3c.c
> > +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i3c.c
> > @@ -32,6 +32,9 @@ static int st_lsm6dsx_i3c_probe(struct i3c_device *i3cdev)
> >  	struct device *dev = i3cdev_to_dev(i3cdev);
> >  	struct regmap *regmap;
> >  
> 
> Please bring the assignment down to above the check so
> 
> 	id = i3c_device_match_id(i3cdev,st_lsm6dsx_i3c_ids);
> 
> Which is what you did in the previous driver...

You're right. It is more readable that way. Thanks!

> > +	if (!id)
> > +		return -ENODEV;
> > +
> >  	regmap = devm_regmap_init_i3c(i3cdev, &st_lsm6dsx_i3c_regmap_config);
> >  	if (IS_ERR(regmap)) {
> >  		dev_err(dev, "Failed to register i3c regmap %ld\n", PTR_ERR(regmap));
> 
> 
