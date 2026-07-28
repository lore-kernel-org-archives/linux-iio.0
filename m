Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 644DD3E49C6;
	Tue, 28 Jul 2026 21:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785273964; cv=none; b=gIiGoq7ExXHpcbXYP2+f4t5BaZBvNq1eqS0jHaW4mkNMeeJJAggXdsxCNHxgAONfKFAKb3RfKrQOvD0H/ZL/N0iOYMuRlAohu0LkM2UCzz4V0VzP91iuhRBcsAYXg5BaBQRJlVKed3X45QND32ZePa6NjKJEXozxGYDDkxEsvbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785273964; c=relaxed/simple;
	bh=qHJyDlD8JcbfrTE/mhaZwEdjZqBHzhOAm2nMdHYLCdU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o03g2AAI6GPFI5QBlJSeOjmSd9feUuRiV3eCrwPr2WFopBRY42J8QHBB0zZpbrFjg7lUutK2npYl6PKU6A8pSkpVF4oyKY/oo9W5tmAef1kk+yJak6bLTUhN5/Te1LRamxiTmjY4O4+PdDZjdkz66UfO8JW5hh4V5/CJxwhGnIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XnfzHRlN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XnfzHRlN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6012A1F000E9;
	Tue, 28 Jul 2026 21:26:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785273963;
	bh=U0Nmx2Ful6U4YHYmvRnIbaUEm1Rle8hLr4TVXpJezv4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=XnfzHRlNps+7IsOQhCyRSXsBw2xKVKIQilvcOejCfKV+dLDitMLJwaNFyl3iTwRP+
	 9J640R+ITO8B8KaWLSklsIg0MpiFscjKhGNqDvXtI7R3szH7Mfy2eg9NmR7eUGzcPV
	 TFrrHu2sIZ6Frg8OId9GWxZCu4hb4S0KxrMdh2IGbliO9c5h461shhkNu2oHL+Ob34
	 qf/fmJI1GUDxWm5AqWmEmj+gLKP3tPZPztE+cCBHZ9cMiytk9+x6uEtGnk/BLePLT7
	 tSkzDpXmYljZ2dfQerqSiV8sqbjrAF3WFnP2dvB+uEVo1TWxjj9t68n2EhOanW18s8
	 2MsarV3xTHohw==
Date: Tue, 28 Jul 2026 22:25:58 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>, Jean-Baptiste
 Maneyrol <jean-baptiste.maneyrol@tdk.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Chris
 Morgan <macromorgan@hotmail.com>, Luca Weiss <luca.weiss@fairphone.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] iio: imu: inv_icm42600: add support for icm42630
Message-ID: <20260728222558.56062c45@jic23-huawei>
In-Reply-To: <20260728-hardwood-support-f18e98366142@spud>
References: <20260724202708.128267-1-jorijnvdgraaf@catcrafts.net>
	<20260724202708.128267-5-jorijnvdgraaf@catcrafts.net>
	<20260728-hardwood-support-f18e98366142@spud>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 28 Jul 2026 17:53:37 +0100
Conor Dooley <conor@kernel.org> wrote:

> On Fri, Jul 24, 2026 at 10:27:08PM +0200, Jorijn van der Graaf wrote:
> > The TDK InvenSense ICM-42630 is a 6-axis IMU of the ICM-42600 family,
> > found e.g. in the Fairphone 6. It is register-compatible with its
> > siblings (the existing driver works on it unmodified) and reports
> > WHOAMI value 0x0C.
> > 
> > The part appears to be a mobile SKU and has no public datasheet: the
> > identity comes from the Fairphone 6 platform documentation and
> > schematics naming the part, and the WHOAMI value was read from the
> > hardware, whose bank 0 register defaults match the ICM-42600 family
> > layout.
> > 
> > Add the chip id, WHOAMI value and I2C/SPI match entries, using the
> > family default configuration like the ICM-42631. Devicetrees describe
> > the part with an icm42631 fallback; the dedicated entries bind the
> > exact part where the kernel knows it.
> > 
> > Tested on the Fairphone 6 via a backport of this change to the
> > device's 7.1-based kernel (only the id-table style and entry placement
> > adjusted to that base), on a bit-banged SPI bus with INT1 wired to the
> > SoC: probe, accelerometer, gyroscope and temperature raw reads, all
> > full-scale ranges, multiple sampling frequencies, and watermark-paced
> > FIFO reads through the INT1 interrupt.
> > 
> > Acked-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
> > Assisted-by: Claude:claude-fable-5
> > Signed-off-by: Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>  
> 
> This patch is not needed because you can make use of the fallback and
> should be dropped.

This is related to whether we print or not.
 
+ the name is userspace ABI so whilst it will work with the fallback naming
that can cause confusion.  I don't mind just using the fallback in this
particular case given as far as we know this really is effectively identical
to the other part rather than a superset case where later driver changes
will add more features and changing the ABI by 'correcting' the name.

Jonathan

> 
> Thanks,
> Conor.
> 
> > ---
> > v2: place the match entries in numeric position (the only code
> > change); kept the Acked-by.
> >  drivers/iio/imu/inv_icm42600/inv_icm42600.h      | 2 ++
> >  drivers/iio/imu/inv_icm42600/inv_icm42600_core.c | 5 +++++
> >  drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c  | 4 ++++
> >  drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c  | 4 ++++
> >  4 files changed, 15 insertions(+)
> > 
> > diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600.h b/drivers/iio/imu/inv_icm42600/inv_icm42600.h
> > index b55d993f0264..349de5458581 100644
> > --- a/drivers/iio/imu/inv_icm42600/inv_icm42600.h
> > +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600.h
> > @@ -28,6 +28,7 @@ enum inv_icm42600_chip {
> >  	INV_CHIP_ICM42622,
> >  	INV_CHIP_ICM42688,
> >  	INV_CHIP_ICM42631,
> > +	INV_CHIP_ICM42630,
> >  	INV_CHIP_NB,
> >  };
> >  
> > @@ -386,6 +387,7 @@ struct inv_icm42600_sensor_state {
> >  #define INV_ICM42600_WHOAMI_ICM42622			0x46
> >  #define INV_ICM42600_WHOAMI_ICM42688			0x47
> >  #define INV_ICM42600_WHOAMI_ICM42631			0x5C
> > +#define INV_ICM42600_WHOAMI_ICM42630			0x0C
> >  
> >  /* User bank 1 (MSB 0x10) */
> >  #define INV_ICM42600_REG_SENSOR_CONFIG0			0x1003
> > diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
> > index f306e3ffca48..da7bc0f1155c 100644
> > --- a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
> > +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
> > @@ -177,6 +177,11 @@ static const struct inv_icm42600_hw inv_icm42600_hw[INV_CHIP_NB] = {
> >  		.name = "icm42631",
> >  		.conf = &inv_icm42600_default_conf,
> >  	},
> > +	[INV_CHIP_ICM42630] = {
> > +		.whoami = INV_ICM42600_WHOAMI_ICM42630,
> > +		.name = "icm42630",
> > +		.conf = &inv_icm42600_default_conf,
> > +	},
> >  };
> >  
> >  const struct iio_mount_matrix *
> > diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c
> > index e44ed6dcde02..672b19d2e41c 100644
> > --- a/drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c
> > +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c
> > @@ -78,6 +78,7 @@ static const struct i2c_device_id inv_icm42600_id[] = {
> >  	{ .name = "icm42602", .driver_data = INV_CHIP_ICM42602 },
> >  	{ .name = "icm42605", .driver_data = INV_CHIP_ICM42605 },
> >  	{ .name = "icm42622", .driver_data = INV_CHIP_ICM42622 },
> > +	{ .name = "icm42630", .driver_data = INV_CHIP_ICM42630 },
> >  	{ .name = "icm42631", .driver_data = INV_CHIP_ICM42631 },
> >  	{ .name = "icm42686", .driver_data = INV_CHIP_ICM42686 },
> >  	{ .name = "icm42688", .driver_data = INV_CHIP_ICM42688 },
> > @@ -98,6 +99,9 @@ static const struct of_device_id inv_icm42600_of_matches[] = {
> >  	}, {
> >  		.compatible = "invensense,icm42622",
> >  		.data = (void *)INV_CHIP_ICM42622,
> > +	}, {
> > +		.compatible = "invensense,icm42630",
> > +		.data = (void *)INV_CHIP_ICM42630,
> >  	}, {
> >  		.compatible = "invensense,icm42631",
> >  		.data = (void *)INV_CHIP_ICM42631,
> > diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c
> > index 3e2f4eb42e97..3707460d77e1 100644
> > --- a/drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c
> > +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c
> > @@ -75,6 +75,7 @@ static const struct spi_device_id inv_icm42600_id[] = {
> >  	{ .name = "icm42602", .driver_data = INV_CHIP_ICM42602 },
> >  	{ .name = "icm42605", .driver_data = INV_CHIP_ICM42605 },
> >  	{ .name = "icm42622", .driver_data = INV_CHIP_ICM42622 },
> > +	{ .name = "icm42630", .driver_data = INV_CHIP_ICM42630 },
> >  	{ .name = "icm42631", .driver_data = INV_CHIP_ICM42631 },
> >  	{ .name = "icm42686", .driver_data = INV_CHIP_ICM42686 },
> >  	{ .name = "icm42688", .driver_data = INV_CHIP_ICM42688 },
> > @@ -95,6 +96,9 @@ static const struct of_device_id inv_icm42600_of_matches[] = {
> >  	}, {
> >  		.compatible = "invensense,icm42622",
> >  		.data = (void *)INV_CHIP_ICM42622,
> > +	}, {
> > +		.compatible = "invensense,icm42630",
> > +		.data = (void *)INV_CHIP_ICM42630,
> >  	}, {
> >  		.compatible = "invensense,icm42631",
> >  		.data = (void *)INV_CHIP_ICM42631,
> > -- 
> > 2.55.0
> >   

