Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F11357CE8;
	Sat,  1 Aug 2026 02:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785550465; cv=none; b=c8bx1w912i3uOPyWhUwg/jdYilRrQwPmN+L0w8oljWGtyHBC2T8IsJE1eq3Yhj0sR+JaSEkCnJWItbcQll1nwIuUOvoCefgnAGnIx9Uwkucw4NKAhWtsk3yx+iRHUTg6B7iesdza74UguZVbWNlX5q6jlmL7iaF8dioQA7sTpXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785550465; c=relaxed/simple;
	bh=KRUO23UU8BVFyQS5KgPGzrlI8QmlWO9gglL27+RTyKU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OgfUF3mhszUuL9BaPQBIaIF8FPDb5kOxWhbSdyHvvLSahM6Guey9vwMd99ippI7y6vtUrpjTL9H804MqemO5SW8t4rQ9Xx0YTfgKObPs8/NnIyVB/t+rWs18vFaCW9RPYFupm10Mfm6nbZ2UBN9+GVxJzpETGRJFeKuMKMVewOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gW2GDjOW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gW2GDjOW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C144A1F00AC4;
	Sat,  1 Aug 2026 02:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785550464;
	bh=orVQNd/2zHKQaSBQxkSy/VCEDjroalGuV+v6+496uno=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=gW2GDjOWYy0gO1UHtOM7NfEABZ6Hh9NQQk2djeQ/ZYQkG1zK324wR8hnc3hMx/KQa
	 3FjVjVyn7WMVLZ/xABcF779Ym1OUrKI5rXP72hHIw5XZTSnn5KyAGDoNwW60HXpE3U
	 EMPl7BjxAc4SQ3BzaphMuwPYM6ROAxNs9OfQd0IOOOSTU2kfZN5ZjUJFk7LO55zFz5
	 kEiKg6ndTtGqjf8rYkGrcbQgaGHuPFudciw+6NUzn9cROQu63VZg5LYzF9zn6j1lZK
	 oPBZMZpAoaz/n7yG5aAqzgoEsGZuTmQSemq/gYNdqEzjMmRpAHnuPwE1aOhm547Mb9
	 WQW4yWWhu31PQ==
Date: Sat, 1 Aug 2026 03:14:18 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Chris Morgan <macromorgan@hotmail.com>
Cc: Chris Morgan <macroalpha82@gmail.com>, linux-iio@vger.kernel.org,
 andy@kernel.org, nuno.sa@analog.com, dlechner@baylibre.com,
 jean-baptiste.maneyrol@tdk.com, linux-rockchip@lists.infradead.org,
 devicetree@vger.kernel.org, heiko@sntech.de, conor+dt@kernel.org,
 krzk+dt@kernel.org, robh@kernel.org, andriy.shevchenko@intel.com
Subject: Re: [PATCH V21 0/9] Add Invensense ICM42607
Message-ID: <20260801031418.31ecb46a@jic23-huawei>
In-Reply-To: <PH0PR19MB99733896FD0C3E2C24017C52AFA5CA2@PH0PR19MB997338.namprd19.prod.outlook.com>
References: <20260728225542.174825-1-macroalpha82@gmail.com>
	<PH0PR19MB99733896FD0C3E2C24017C52AFA5CA2@PH0PR19MB997338.namprd19.prod.outlook.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 28 Jul 2026 19:12:47 -0500
Chris Morgan <macromorgan@hotmail.com> wrote:

> On Tue, Jul 28, 2026 at 05:55:31PM -0500, Chris Morgan wrote:
> > From: Chris Morgan <macromorgan@hotmail.com>
> > 
> > Add support for the ICM42607 IMU. This sensor shares the same
> > functionality but a different register layout with the existing
> > ICM42600.
> > 
> > This driver should work with the ICM42607 and ICM42607P over both I2C
> > and SPI, however only the ICM42607P over I2C could be tested.
> > 
> > Changes Since v19:
> >  - Removed remove routines and converted call to sensors_off to void,
> >    and then added a devm_add_action_or_reset() to call it on device
> >    teardown.
> > 
> > Changes Since V20:
> >  - Added missing include to inv_icm42607_temp.c.
> >  - Corrected note pointed out by Sashiko.dev as incorrect.
> >  - Added an additional delay for poweron based on the odr value of the
> >    given sensor. After doing an extensive amount of testing with low
> >    odr values (and even the default value for the gyro sensor) I was
> >    able to intermittently create EINVAL conditions because the driver
> >    was not waiting long enough after enabling the sensor, even
> >    accounting for the sleep delay. Adding a delay for the time it takes
> >    for the sensor to register a value corrected this intermittent issue
> >    as best I can tell. 
> > 
> > Chris Morgan (9):
> >   dt-bindings: iio: imu: icm42600: Add mount-matrix
> >   dt-bindings: iio: imu: icm42600: Add icm42607
> >   iio: imu: inv_icm42607: Add inv_icm42607 Core Driver
> >   iio: imu: inv_icm42607: Add SPI For icm42607
> >   iio: imu: inv_icm42607: Add PM support for icm42607
> >   iio: imu: inv_icm42607: Add Accelerometer for icm42607
> >   iio: imu: inv_icm42607: Add Gyroscope to icm42607
> >   iio: imu: inv_icm42607: Add Temp Support in icm42607
> >   arm64: dts: rockchip: Add icm42607p IMU for RG-DS
> > 
> >  .../bindings/iio/imu/invensense,icm42600.yaml |  20 +-
> >  .../dts/rockchip/rk3568-anbernic-rg-ds.dts    |   8 +-
> >  drivers/iio/imu/Kconfig                       |   1 +
> >  drivers/iio/imu/Makefile                      |   1 +
> >  drivers/iio/imu/inv_icm42607/Kconfig          |  30 +
> >  drivers/iio/imu/inv_icm42607/Makefile         |  13 +
> >  drivers/iio/imu/inv_icm42607/inv_icm42607.h   | 421 +++++++++++
> >  .../iio/imu/inv_icm42607/inv_icm42607_accel.c | 316 ++++++++
> >  .../iio/imu/inv_icm42607/inv_icm42607_core.c  | 702 ++++++++++++++++++
> >  .../iio/imu/inv_icm42607/inv_icm42607_gyro.c  | 313 ++++++++
> >  .../iio/imu/inv_icm42607/inv_icm42607_i2c.c   |  97 +++
> >  .../iio/imu/inv_icm42607/inv_icm42607_spi.c   | 107 +++
> >  .../iio/imu/inv_icm42607/inv_icm42607_temp.c  |  99 +++
> >  .../iio/imu/inv_icm42607/inv_icm42607_temp.h  |  38 +
> >  14 files changed, 2164 insertions(+), 2 deletions(-)
> >  create mode 100644 drivers/iio/imu/inv_icm42607/Kconfig
> >  create mode 100644 drivers/iio/imu/inv_icm42607/Makefile
> >  create mode 100644 drivers/iio/imu/inv_icm42607/inv_icm42607.h
> >  create mode 100644 drivers/iio/imu/inv_icm42607/inv_icm42607_accel.c
> >  create mode 100644 drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
> >  create mode 100644 drivers/iio/imu/inv_icm42607/inv_icm42607_gyro.c
> >  create mode 100644 drivers/iio/imu/inv_icm42607/inv_icm42607_i2c.c
> >  create mode 100644 drivers/iio/imu/inv_icm42607/inv_icm42607_spi.c
> >  create mode 100644 drivers/iio/imu/inv_icm42607/inv_icm42607_temp.c
> >  create mode 100644 drivers/iio/imu/inv_icm42607/inv_icm42607_temp.h
> > 
> > -- 
> > 2.43.0
> >   
> 
> Woot! Perfect sashiko score. 21st time's the charm...
Nice and LGTM so applied patches 1-8.  The final one should get picked up
via the appropriate rockchip tree.  

It was a hard slog, but having watching sashiko rip apart a driver
of mine this week (long since merged) I definitely sympathise.

Congratulations. Applied to the testing branch of iio.git where the much
less 'risky' 0-day build bot will check we didn't miss anything on that front.

Thanks,

Jonathan

> 
> Thank you,
> Chris

