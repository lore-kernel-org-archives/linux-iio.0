Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC3731AA9B;
	Tue, 19 May 2026 18:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779215971; cv=none; b=j9FrtK5yGRjNNiPBbu0Tg78HFKTYjUJ7q6ZoQzwj6nPgj99J+qoseN1ZGTm9WfVDCbyT3uqXxORoyifdyzUJimcHie/pTvNbHMpkLRxeoB1VlE1SK+gU4oK/Z/cZP93Nj9AzRLxF6rt4jH4n4kz9nyj581UQtfeeIjdudZhWiw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779215971; c=relaxed/simple;
	bh=xdJFez075sWtbVAIOcJngWoBl8XVHfe4P4+BJMUA4+g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u0xQvTDR4upVf+m35nYvvdstj9Ng3PoQ1miyk1/GT7yUgSuI8U5A3du/eWF6m5iWNBpNEQ76/ufc+JPXtdrDm5+gfQjkZGubMzh2fOn8vc5k5X1IkyBfCIOCj1sxa39xls2GsclR0jL5t7C7xCU4F4uN62DzeAKu8eBSDdeMX4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Aq7FqNHh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Aq7FqNHh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FB0CC2BCB3;
	Tue, 19 May 2026 18:39:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779215971;
	bh=xdJFez075sWtbVAIOcJngWoBl8XVHfe4P4+BJMUA4+g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Aq7FqNHhod63UPzqooHuOuJSo7zkRN55eAEnMc/6gQK9db82GZ5GRkMmNEZQKZAii
	 twSyQL+vZgGuBgReUOE5Q7f6ah1qZvyR/iScyJp014+XL+D83duJzPTamy3YJQQprC
	 87B+fge7Z4rHXFKsKlNdIPcTSjNmFzmzhY2ClUlzwUal7OmzcAq+8MymCLkXZS6FUz
	 7xuGOCv7q+/szLx5A1xxBoO3qYOachooCBuKjYNtZeqjtXOM+owD67oY4ytVFL8CKl
	 KLYOWfKym6TgL9I/MHpjOXxqgfTRfniu9XQK7lL7oRLYywvUemdljkez7tBPDGlfEx
	 BhwAdRozxeEdQ==
Date: Tue, 19 May 2026 19:39:13 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= (The Capable Hub)"
 <u.kleine-koenig@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Puranjay Mohan <puranjay@kernel.org>, Cosmin Tanislav
 <cosmin.tanislav@analog.com>, Marcelo Schmitt <marcelo.schmitt@analog.com>,
 Antoniu Miclaus <antoniu.miclaus@analog.com>, Ramona Gradinariu
 <ramona.gradinariu@analog.com>, Petre Rodan <petre.rodan@subdimension.ro>,
 Dan Robertson <dan@dlrobertson.com>, Herve Codina
 <herve.codina@bootlin.com>, Matti Vaittinen <mazziesaccount@gmail.com>,
 Francesco Dolcini <francesco@dolcini.it>, =?UTF-8?B?Sm/Do28=?= Paulo
 =?UTF-8?B?R29uw6dhbHZlcw==?= <jpaulo.silvagoncalves@gmail.com>, Hugo
 Villeneuve <hvilleneuve@dimonoff.com>, Anshul Dalal <anshulusr@gmail.com>,
 Gustavo Silva <gustavograzs@gmail.com>, Andreas Klinger <ak@it-klinger.de>,
 Tomasz Duszynski <tduszyns@gmail.com>, Ariana Lazar
 <ariana.lazar@microchip.com>, Rui Miguel Silva <rmfrfs@gmail.com>, Linus
 Walleij <linusw@kernel.org>, Javier Carrasco
 <javier.carrasco.cruz@gmail.com>, Li peiyu <579lpy@gmail.com>, Lorenzo
 Bianconi <lorenzo@kernel.org>, Alex Lanzano <lanzano.alex@gmail.com>,
 Jagath Jog J <jagathjog1996@gmail.com>, Jean-Baptiste Maneyrol
 <jean-baptiste.maneyrol@tdk.com>, Remi Buisson <remi.buisson@tdk.com>,
 Christian Eggers <ceggers@arri.de>, Mudit Sharma
 <muditsharma.info@gmail.com>, Kevin Tsai <ktsai@capellamicro.com>,
 =?UTF-8?B?T25kxZllag==?= Jirman <megi@xff.cz>, Dixit Parmar
 <dixitparmar19@gmail.com>, Gerald Loacker <gerald.loacker@wolfvision.net>,
 Akhilesh Patil <akhilesh@ee.iitb.ac.in>, Eddie James
 <eajames@linux.ibm.com>, Petar Stoykov
 <petar.stoykov@prodrive-technologies.com>, Song Qiang
 <songqiang1304521@gmail.com>, Siratul Islam <email@sirat.me>, Crt Mori
 <cmo@melexis.com>, Waqar Hameed <waqar.hameed@axis.com>, Sebastian Andrzej
 Siewior <bigeasy@linutronix.de>, Gustavo Vaz <gustavo.vaz@usp.br>, Sakari
 Ailus <sakari.ailus@linux.intel.com>, Marcus Folkesson
 <marcus.folkesson@gmail.com>, Guenter Roeck <linux@roeck-us.net>, Bartosz
 Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, Chuang Zhu
 <git@chuang.cz>, Kyle Hsieh <kylehsieh1995@gmail.com>, Giorgi Tchankvetadze
 <giorgitchankvetadze1997@gmail.com>, Chen-Yu Tsai <wens@kernel.org>,
 Oleksij Rempel <o.rempel@pengutronix.de>, Romain Gantois
 <romain.gantois@bootlin.com>, Sander Vanheule <sander@svanheule.net>, David
 Jander <david@protonic.nl>, Andrew Davis <afd@ti.com>, chuguangqing
 <chuguangqing@inspur.com>, Shrikant Raskar <raskar.shree97@gmail.com>, Kurt
 Borja <kuurtb@gmail.com>, Denis Benato <benato.denis96@gmail.com>, Ethan
 Tidmore <ethantidmore06@gmail.com>, Tomas Borquez
 <tomasborquez13@gmail.com>, Srinivas Pandruvada
 <srinivas.pandruvada@linux.intel.com>, Shi Hao <i.shihao.999@gmail.com>,
 Xichao Zhao <zhao.xichao@vivo.com>, Erikas Bitovtas <xerikasxx@gmail.com>,
 Aldo Conte <aldocontelk@gmail.com>, Colin Ian King
 <colin.i.king@gmail.com>, Gabriel Almeida <gabrielsousa230@gmail.com>,
 Gabriela Victor <gabevictor333@gmail.com>, Beatriz Viana Costa
 <beatrizvianacosta16@gmail.com>, Frank Li <Frank.Li@nxp.com>, Adrian
 Fluturel <fluturel.adrian@gmail.com>, Antoni Pokusinski
 <apokusinski01@gmail.com>, Yasin Lee <yasin.lee.x@gmail.com>, Felix Gu
 <ustc.gu@gmail.com>, Ben Collins <bcollins@watter.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 7/7] iio: Initialize i2c_device_id arrays using
 member names
Message-ID: <20260519193913.6466630b@jic23-huawei>
In-Reply-To: <4b6ea3483356d758a90bfb8970ed0f1df2f31cfc.1779136001.git.u.kleine-koenig@baylibre.com>
References: <cover.1779136001.git.u.kleine-koenig@baylibre.com>
	<4b6ea3483356d758a90bfb8970ed0f1df2f31cfc.1779136001.git.u.kleine-koenig@baylibre.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 19 May 2026 10:13:09 +0200
Uwe Kleine-K=C3=B6nig (The Capable Hub) <u.kleine-koenig@baylibre.com> wrot=
e:

> While being less compact, using named initializers allows to more easily
> see which members of the structs are assigned which value without having
> to lookup the declaration of the struct. And it's also more robust
> against changes to the struct definition.
>=20
> The mentioned robustness is relevant for a planned change to struct
> i2c_device_id that replaces .driver_data by an anonymous union.
>=20
> This patch doesn't modify the compiled arrays, only their representation
> in source form benefits. The former was confirmed with x86 and arm64
> builds.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig (The Capable Hub) <u.kleine-koenig@b=
aylibre.com>
Hi Uwe,

I'd prefer it split into cases you care about (not just name) and the name =
only ones.
That is unless I'm missing some potential change that breaks initializing
just the first element and hence not the union you plan to add.

It's a lot of churn and the name one isn't enabling anything new unless
I'm missing something.

We also get fixes in these annoyingly often so chances are this will mess
up backports.  Might even be worth splitting it up into directories
just to reduce that backport mess.

Also, have you done a checkpatch check for this?  Nice to not being fighting
it for ever.

Jonathan

> ---
>  drivers/iio/accel/adxl345_i2c.c               |  4 +-
>  drivers/iio/accel/adxl355_i2c.c               |  4 +-
>  drivers/iio/accel/adxl367_i2c.c               |  2 +-
>  drivers/iio/accel/adxl372_i2c.c               |  4 +-
>  drivers/iio/accel/adxl380_i2c.c               |  8 +-
>  drivers/iio/accel/bma180.c                    | 10 +-
>  drivers/iio/accel/bma220_i2c.c                |  2 +-
>  drivers/iio/accel/bma400_i2c.c                |  2 +-
>  drivers/iio/accel/bmi088-accel-i2c.c          |  6 +-
>  drivers/iio/accel/da280.c                     |  6 +-
>  drivers/iio/accel/da311.c                     |  2 +-
>  drivers/iio/accel/dmard06.c                   |  6 +-
>  drivers/iio/accel/dmard09.c                   |  2 +-
>  drivers/iio/accel/dmard10.c                   |  2 +-
>  drivers/iio/accel/fxls8962af-i2c.c            |  8 +-
>  drivers/iio/accel/kxcjk-1013.c                | 10 +-
>  drivers/iio/accel/kxsd9-i2c.c                 |  2 +-
>  drivers/iio/accel/mc3230.c                    |  4 +-
>  drivers/iio/accel/mma7455_i2c.c               |  4 +-
>  drivers/iio/accel/mma7660.c                   |  2 +-
>  drivers/iio/accel/mma8452.c                   | 12 +--
>  drivers/iio/accel/mma9551.c                   |  2 +-
>  drivers/iio/accel/mma9553.c                   |  2 +-
>  drivers/iio/accel/mxc4005.c                   |  4 +-
>  drivers/iio/accel/mxc6255.c                   |  4 +-
>  drivers/iio/accel/st_accel_i2c.c              | 52 +++++-----
>  drivers/iio/accel/stk8312.c                   |  4 +-
>  drivers/iio/accel/stk8ba50.c                  |  2 +-
>  drivers/iio/adc/ad7291.c                      |  2 +-
>  drivers/iio/adc/ad799x.c                      | 16 ++--
>  drivers/iio/adc/gehc-pmc-adc.c                |  2 +-
>  drivers/iio/adc/ina2xx-adc.c                  | 12 +--
>  drivers/iio/adc/ltc2309.c                     |  4 +-
>  drivers/iio/adc/ltc2471.c                     |  4 +-
>  drivers/iio/adc/ltc2485.c                     |  2 +-
>  drivers/iio/adc/ltc2497.c                     |  4 +-
>  drivers/iio/adc/max34408.c                    |  4 +-
>  drivers/iio/adc/mcp3422.c                     | 16 ++--
>  drivers/iio/adc/nau7802.c                     |  2 +-
>  drivers/iio/adc/rohm-bd79124.c                |  2 +-
>  drivers/iio/adc/ti-adc081c.c                  |  6 +-
>  drivers/iio/adc/ti-ads1015.c                  |  6 +-
>  drivers/iio/adc/ti-ads1100.c                  |  4 +-
>  drivers/iio/adc/ti-ads1119.c                  |  2 +-
>  drivers/iio/adc/ti-ads7138.c                  |  4 +-
>  drivers/iio/adc/ti-ads7924.c                  |  2 +-
>  drivers/iio/cdc/ad7150.c                      |  6 +-
>  drivers/iio/cdc/ad7746.c                      |  6 +-
>  drivers/iio/chemical/ags02ma.c                |  2 +-
>  drivers/iio/chemical/ams-iaq-core.c           |  2 +-
>  drivers/iio/chemical/atlas-ezo-sensor.c       |  6 +-
>  drivers/iio/chemical/atlas-sensor.c           | 10 +-
>  drivers/iio/chemical/bme680_i2c.c             |  2 +-
>  drivers/iio/chemical/ccs811.c                 |  4 +-
>  drivers/iio/chemical/ens160_i2c.c             |  2 +-
>  drivers/iio/chemical/sgp30.c                  |  4 +-
>  drivers/iio/chemical/sgp40.c                  |  2 +-
>  drivers/iio/chemical/sps30_i2c.c              |  2 +-
>  drivers/iio/chemical/vz89x.c                  |  4 +-
>  drivers/iio/dac/ad5064.c                      | 94 +++++++++----------
>  drivers/iio/dac/ad5380.c                      | 32 +++----
>  drivers/iio/dac/ad5446-i2c.c                  | 12 +--
>  drivers/iio/dac/ad5696-i2c.c                  | 32 +++----
>  drivers/iio/dac/ds4424.c                      |  8 +-
>  drivers/iio/dac/m62332.c                      |  2 +-
>  drivers/iio/dac/max517.c                      | 10 +-
>  drivers/iio/dac/mcp4725.c                     |  4 +-
>  drivers/iio/dac/mcp4728.c                     |  2 +-
>  drivers/iio/dac/mcp47feb02.c                  | 48 +++++-----
>  drivers/iio/dac/ti-dac5571.c                  | 22 ++---
>  drivers/iio/gyro/bmg160_i2c.c                 |  6 +-
>  drivers/iio/gyro/fxas21002c_i2c.c             |  2 +-
>  drivers/iio/gyro/itg3200_core.c               |  2 +-
>  drivers/iio/gyro/mpu3050-i2c.c                |  2 +-
>  drivers/iio/gyro/st_gyro_i2c.c                | 18 ++--
>  drivers/iio/health/afe4404.c                  |  2 +-
>  drivers/iio/health/max30100.c                 |  2 +-
>  drivers/iio/health/max30102.c                 |  6 +-
>  drivers/iio/humidity/am2315.c                 |  2 +-
>  drivers/iio/humidity/ens210.c                 | 12 +--
>  drivers/iio/humidity/hdc100x.c                | 12 +--
>  drivers/iio/humidity/hdc2010.c                |  4 +-
>  drivers/iio/humidity/hdc3020.c                |  6 +-
>  drivers/iio/humidity/hts221_i2c.c             |  2 +-
>  drivers/iio/humidity/htu21.c                  |  4 +-
>  drivers/iio/humidity/si7005.c                 |  4 +-
>  drivers/iio/humidity/si7020.c                 |  4 +-
>  drivers/iio/imu/bmi160/bmi160_i2c.c           |  4 +-
>  drivers/iio/imu/bmi270/bmi270_i2c.c           |  4 +-
>  drivers/iio/imu/bmi323/bmi323_i2c.c           |  2 +-
>  drivers/iio/imu/bno055/bno055_i2c.c           |  2 +-
>  drivers/iio/imu/fxos8700_i2c.c                |  2 +-
>  .../iio/imu/inv_icm42600/inv_icm42600_i2c.c   | 14 +--
>  .../iio/imu/inv_icm45600/inv_icm45600_i2c.c   | 16 ++--
>  drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c     | 36 +++----
>  drivers/iio/imu/kmx61.c                       |  2 +-
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c   | 48 +++++-----
>  drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_i2c.c   |  4 +-
>  drivers/iio/light/adjd_s311.c                 |  2 +-
>  drivers/iio/light/adux1020.c                  |  2 +-
>  drivers/iio/light/al3000a.c                   |  2 +-
>  drivers/iio/light/al3010.c                    |  2 +-
>  drivers/iio/light/al3320a.c                   |  2 +-
>  drivers/iio/light/apds9300.c                  |  2 +-
>  drivers/iio/light/apds9960.c                  |  2 +-
>  drivers/iio/light/as73211.c                   |  4 +-
>  drivers/iio/light/bh1745.c                    |  2 +-
>  drivers/iio/light/bh1750.c                    | 10 +-
>  drivers/iio/light/bh1780.c                    |  2 +-
>  drivers/iio/light/cm3232.c                    |  2 +-
>  drivers/iio/light/cm3323.c                    |  2 +-
>  drivers/iio/light/cm36651.c                   |  2 +-
>  drivers/iio/light/gp2ap002.c                  |  2 +-
>  drivers/iio/light/gp2ap020a00f.c              |  2 +-
>  drivers/iio/light/isl29018.c                  |  6 +-
>  drivers/iio/light/isl29028.c                  |  4 +-
>  drivers/iio/light/isl29125.c                  |  2 +-
>  drivers/iio/light/isl76682.c                  |  2 +-
>  drivers/iio/light/jsa1212.c                   |  2 +-
>  drivers/iio/light/ltr390.c                    |  2 +-
>  drivers/iio/light/ltr501.c                    |  8 +-
>  drivers/iio/light/ltrf216a.c                  |  4 +-
>  drivers/iio/light/lv0104cs.c                  |  2 +-
>  drivers/iio/light/max44000.c                  |  2 +-
>  drivers/iio/light/max44009.c                  |  2 +-
>  drivers/iio/light/noa1305.c                   |  2 +-
>  drivers/iio/light/opt3001.c                   |  4 +-
>  drivers/iio/light/opt4001.c                   |  4 +-
>  drivers/iio/light/opt4060.c                   |  2 +-
>  drivers/iio/light/pa12203001.c                |  2 +-
>  drivers/iio/light/rpr0521.c                   |  2 +-
>  drivers/iio/light/si1133.c                    |  2 +-
>  drivers/iio/light/si1145.c                    | 14 +--
>  drivers/iio/light/st_uvis25_i2c.c             |  2 +-
>  drivers/iio/light/stk3310.c                   |  8 +-
>  drivers/iio/light/tcs3414.c                   |  2 +-
>  drivers/iio/light/tcs3472.c                   |  2 +-
>  drivers/iio/light/tsl2772.c                   | 22 ++---
>  drivers/iio/light/tsl4531.c                   |  2 +-
>  drivers/iio/light/us5182d.c                   |  2 +-
>  drivers/iio/light/vcnl4000.c                  | 14 +--
>  drivers/iio/light/vcnl4035.c                  |  2 +-
>  drivers/iio/light/veml3235.c                  |  2 +-
>  drivers/iio/light/veml6030.c                  |  6 +-
>  drivers/iio/light/veml6040.c                  |  2 +-
>  drivers/iio/light/veml6046x00.c               |  2 +-
>  drivers/iio/light/veml6070.c                  |  2 +-
>  drivers/iio/light/veml6075.c                  |  2 +-
>  drivers/iio/light/vl6180.c                    |  2 +-
>  drivers/iio/light/zopt2201.c                  |  2 +-
>  drivers/iio/magnetometer/af8133j.c            |  2 +-
>  drivers/iio/magnetometer/ak8974.c             |  8 +-
>  drivers/iio/magnetometer/ak8975.c             | 14 +--
>  drivers/iio/magnetometer/bmc150_magn_i2c.c    |  6 +-
>  drivers/iio/magnetometer/hmc5843_i2c.c        |  8 +-
>  drivers/iio/magnetometer/mag3110.c            |  2 +-
>  drivers/iio/magnetometer/mmc35240.c           |  2 +-
>  drivers/iio/magnetometer/mmc5633.c            |  4 +-
>  drivers/iio/magnetometer/si7210.c             |  2 +-
>  drivers/iio/magnetometer/st_magn_i2c.c        | 18 ++--
>  drivers/iio/magnetometer/tlv493d.c            |  2 +-
>  drivers/iio/magnetometer/tmag5273.c           |  2 +-
>  drivers/iio/magnetometer/yamaha-yas530.c      |  8 +-
>  drivers/iio/potentiometer/ad5272.c            | 10 +-
>  drivers/iio/potentiometer/ds1803.c            |  8 +-
>  drivers/iio/potentiometer/tpl0102.c           |  8 +-
>  drivers/iio/potentiostat/lmp91000.c           |  4 +-
>  drivers/iio/pressure/abp060mg.c               | 90 +++++++++++-------
>  drivers/iio/pressure/abp2030pa_i2c.c          |  2 +-
>  drivers/iio/pressure/adp810.c                 |  2 +-
>  drivers/iio/pressure/bmp280-i2c.c             | 12 +--
>  drivers/iio/pressure/dlhl60d.c                |  4 +-
>  drivers/iio/pressure/dps310.c                 |  2 +-
>  drivers/iio/pressure/hp03.c                   |  2 +-
>  drivers/iio/pressure/hp206c.c                 |  2 +-
>  drivers/iio/pressure/hsc030pa_i2c.c           |  2 +-
>  drivers/iio/pressure/icp10100.c               |  2 +-
>  drivers/iio/pressure/mpl115_i2c.c             |  2 +-
>  drivers/iio/pressure/mpl3115.c                |  2 +-
>  drivers/iio/pressure/mprls0025pa_i2c.c        |  2 +-
>  drivers/iio/pressure/ms5611_i2c.c             |  4 +-
>  drivers/iio/pressure/ms5637.c                 |  8 +-
>  drivers/iio/pressure/rohm-bm1390.c            |  2 +-
>  drivers/iio/pressure/sdp500.c                 |  2 +-
>  drivers/iio/pressure/st_pressure_i2c.c        | 16 ++--
>  drivers/iio/pressure/t5403.c                  |  2 +-
>  drivers/iio/pressure/zpa2326_i2c.c            |  2 +-
>  drivers/iio/proximity/aw96103.c               |  4 +-
>  drivers/iio/proximity/hx9023s.c               |  2 +-
>  drivers/iio/proximity/isl29501.c              |  2 +-
>  drivers/iio/proximity/mb1232.c                | 14 +--
>  .../iio/proximity/pulsedlight-lidar-lite-v2.c |  4 +-
>  drivers/iio/proximity/rfd77402.c              |  2 +-
>  drivers/iio/proximity/srf08.c                 |  6 +-
>  drivers/iio/proximity/sx9310.c                |  4 +-
>  drivers/iio/proximity/sx9500.c                |  2 +-
>  drivers/iio/proximity/vl53l0x-i2c.c           |  2 +-
>  drivers/iio/proximity/vl53l1x-i2c.c           |  2 +-
>  drivers/iio/temperature/max30208.c            |  2 +-
>  drivers/iio/temperature/mcp9600.c             |  4 +-
>  drivers/iio/temperature/mlx90614.c            |  4 +-
>  drivers/iio/temperature/mlx90632.c            |  2 +-
>  drivers/iio/temperature/mlx90635.c            |  2 +-
>  drivers/iio/temperature/tmp006.c              |  2 +-
>  drivers/iio/temperature/tmp007.c              |  2 +-
>  drivers/iio/temperature/tmp117.c              |  4 +-
>  drivers/iio/temperature/tsys01.c              |  2 +-
>  drivers/iio/temperature/tsys02d.c             |  2 +-
>  208 files changed, 678 insertions(+), 656 deletions(-)
>=20
> diff --git a/drivers/iio/accel/adxl345_i2c.c b/drivers/iio/accel/adxl345_=
i2c.c
> index af84c0043c6c..511fb610436c 100644
> --- a/drivers/iio/accel/adxl345_i2c.c
> +++ b/drivers/iio/accel/adxl345_i2c.c
> @@ -43,8 +43,8 @@ static const struct adxl345_chip_info adxl375_i2c_info =
=3D {
>  };
> =20
>  static const struct i2c_device_id adxl345_i2c_id[] =3D {
> -	{ "adxl345", (kernel_ulong_t)&adxl345_i2c_info },
> -	{ "adxl375", (kernel_ulong_t)&adxl375_i2c_info },
> +	{ .name =3D "adxl345", .driver_data =3D (kernel_ulong_t)&adxl345_i2c_in=
fo },
> +	{ .name =3D "adxl375", .driver_data =3D (kernel_ulong_t)&adxl375_i2c_in=
fo },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, adxl345_i2c_id);
> diff --git a/drivers/iio/accel/adxl355_i2c.c b/drivers/iio/accel/adxl355_=
i2c.c
> index 1a512c7b792b..54a99fda1ecb 100644
> --- a/drivers/iio/accel/adxl355_i2c.c
> +++ b/drivers/iio/accel/adxl355_i2c.c
> @@ -41,8 +41,8 @@ static int adxl355_i2c_probe(struct i2c_client *client)
>  }
> =20
>  static const struct i2c_device_id adxl355_i2c_id[] =3D {
> -	{ "adxl355", (kernel_ulong_t)&adxl35x_chip_info[ADXL355] },
> -	{ "adxl359", (kernel_ulong_t)&adxl35x_chip_info[ADXL359] },
> +	{ .name =3D "adxl355", .driver_data =3D (kernel_ulong_t)&adxl35x_chip_i=
nfo[ADXL355] },
> +	{ .name =3D "adxl359", .driver_data =3D (kernel_ulong_t)&adxl35x_chip_i=
nfo[ADXL359] },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, adxl355_i2c_id);
> diff --git a/drivers/iio/accel/adxl367_i2c.c b/drivers/iio/accel/adxl367_=
i2c.c
> index 1c7d2eb054a2..fb50ded68bae 100644
> --- a/drivers/iio/accel/adxl367_i2c.c
> +++ b/drivers/iio/accel/adxl367_i2c.c
> @@ -61,7 +61,7 @@ static int adxl367_i2c_probe(struct i2c_client *client)
>  }
> =20
>  static const struct i2c_device_id adxl367_i2c_id[] =3D {
> -	{ "adxl367" },
> +	{ .name =3D "adxl367" },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, adxl367_i2c_id);
> diff --git a/drivers/iio/accel/adxl372_i2c.c b/drivers/iio/accel/adxl372_=
i2c.c
> index ca2cabf24938..ddb125075778 100644
> --- a/drivers/iio/accel/adxl372_i2c.c
> +++ b/drivers/iio/accel/adxl372_i2c.c
> @@ -44,8 +44,8 @@ static int adxl372_i2c_probe(struct i2c_client *client)
>  }
> =20
>  static const struct i2c_device_id adxl372_i2c_id[] =3D {
> -	{ "adxl371", (kernel_ulong_t)&adxl371_chip_info },
> -	{ "adxl372", (kernel_ulong_t)&adxl372_chip_info },
> +	{ .name =3D "adxl371", .driver_data =3D (kernel_ulong_t)&adxl371_chip_i=
nfo },
> +	{ .name =3D "adxl372", .driver_data =3D (kernel_ulong_t)&adxl372_chip_i=
nfo },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, adxl372_i2c_id);
> diff --git a/drivers/iio/accel/adxl380_i2c.c b/drivers/iio/accel/adxl380_=
i2c.c
> index bd8782d08c7d..367a29298047 100644
> --- a/drivers/iio/accel/adxl380_i2c.c
> +++ b/drivers/iio/accel/adxl380_i2c.c
> @@ -33,10 +33,10 @@ static int adxl380_i2c_probe(struct i2c_client *clien=
t)
>  }
> =20
>  static const struct i2c_device_id adxl380_i2c_id[] =3D {
> -	{ "adxl318", (kernel_ulong_t)&adxl318_chip_info },
> -	{ "adxl319", (kernel_ulong_t)&adxl319_chip_info },
> -	{ "adxl380", (kernel_ulong_t)&adxl380_chip_info },
> -	{ "adxl382", (kernel_ulong_t)&adxl382_chip_info },
> +	{ .name =3D "adxl318", .driver_data =3D (kernel_ulong_t)&adxl318_chip_i=
nfo },
> +	{ .name =3D "adxl319", .driver_data =3D (kernel_ulong_t)&adxl319_chip_i=
nfo },
> +	{ .name =3D "adxl380", .driver_data =3D (kernel_ulong_t)&adxl380_chip_i=
nfo },
> +	{ .name =3D "adxl382", .driver_data =3D (kernel_ulong_t)&adxl382_chip_i=
nfo },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, adxl380_i2c_id);
> diff --git a/drivers/iio/accel/bma180.c b/drivers/iio/accel/bma180.c
> index 7bc6761f5135..e643bc73eefe 100644
> --- a/drivers/iio/accel/bma180.c
> +++ b/drivers/iio/accel/bma180.c
> @@ -1083,11 +1083,11 @@ static int bma180_resume(struct device *dev)
>  static DEFINE_SIMPLE_DEV_PM_OPS(bma180_pm_ops, bma180_suspend, bma180_re=
sume);
> =20
>  static const struct i2c_device_id bma180_ids[] =3D {
> -	{ "bma023", (kernel_ulong_t)&bma180_part_info[BMA023] },
> -	{ "bma150", (kernel_ulong_t)&bma180_part_info[BMA150] },
> -	{ "bma180", (kernel_ulong_t)&bma180_part_info[BMA180] },
> -	{ "bma250", (kernel_ulong_t)&bma180_part_info[BMA250] },
> -	{ "smb380", (kernel_ulong_t)&bma180_part_info[BMA150] },
> +	{ .name =3D "bma023", .driver_data =3D (kernel_ulong_t)&bma180_part_inf=
o[BMA023] },
> +	{ .name =3D "bma150", .driver_data =3D (kernel_ulong_t)&bma180_part_inf=
o[BMA150] },
> +	{ .name =3D "bma180", .driver_data =3D (kernel_ulong_t)&bma180_part_inf=
o[BMA180] },
> +	{ .name =3D "bma250", .driver_data =3D (kernel_ulong_t)&bma180_part_inf=
o[BMA250] },
> +	{ .name =3D "smb380", .driver_data =3D (kernel_ulong_t)&bma180_part_inf=
o[BMA150] },
>  	{ }
>  };
> =20
> diff --git a/drivers/iio/accel/bma220_i2c.c b/drivers/iio/accel/bma220_i2=
c.c
> index 8b6f8e305c8c..b058e97bc6a6 100644
> --- a/drivers/iio/accel/bma220_i2c.c
> +++ b/drivers/iio/accel/bma220_i2c.c
> @@ -47,7 +47,7 @@ static const struct of_device_id bma220_i2c_match[] =3D=
 {
>  MODULE_DEVICE_TABLE(of, bma220_i2c_match);
> =20
>  static const struct i2c_device_id bma220_i2c_id[] =3D {
> -	{ "bma220" },
> +	{ .name =3D "bma220" },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, bma220_i2c_id);
> diff --git a/drivers/iio/accel/bma400_i2c.c b/drivers/iio/accel/bma400_i2=
c.c
> index 24a390c3ae66..23d394c5a791 100644
> --- a/drivers/iio/accel/bma400_i2c.c
> +++ b/drivers/iio/accel/bma400_i2c.c
> @@ -28,7 +28,7 @@ static int bma400_i2c_probe(struct i2c_client *client)
>  }
> =20
>  static const struct i2c_device_id bma400_i2c_ids[] =3D {
> -	{ "bma400" },
> +	{ .name =3D "bma400" },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, bma400_i2c_ids);
> diff --git a/drivers/iio/accel/bmi088-accel-i2c.c b/drivers/iio/accel/bmi=
088-accel-i2c.c
> index 310f863029bb..d9468b1c5aee 100644
> --- a/drivers/iio/accel/bmi088-accel-i2c.c
> +++ b/drivers/iio/accel/bmi088-accel-i2c.c
> @@ -45,9 +45,9 @@ static const struct of_device_id bmi088_of_match[] =3D {
>  MODULE_DEVICE_TABLE(of, bmi088_of_match);
> =20
>  static const struct i2c_device_id bmi088_accel_id[] =3D {
> -	{ "bmi085-accel",  BOSCH_BMI085 },
> -	{ "bmi088-accel",  BOSCH_BMI088 },
> -	{ "bmi090l-accel", BOSCH_BMI090L },
> +	{ .name =3D "bmi085-accel",  .driver_data =3D BOSCH_BMI085 },
> +	{ .name =3D "bmi088-accel",  .driver_data =3D BOSCH_BMI088 },
> +	{ .name =3D "bmi090l-accel", .driver_data =3D BOSCH_BMI090L },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, bmi088_accel_id);
> diff --git a/drivers/iio/accel/da280.c b/drivers/iio/accel/da280.c
> index c2dd123b9021..15acbe1c2cbd 100644
> --- a/drivers/iio/accel/da280.c
> +++ b/drivers/iio/accel/da280.c
> @@ -162,9 +162,9 @@ static const struct acpi_device_id da280_acpi_match[]=
 =3D {
>  MODULE_DEVICE_TABLE(acpi, da280_acpi_match);
> =20
>  static const struct i2c_device_id da280_i2c_id[] =3D {
> -	{ "da217", (kernel_ulong_t)&da217_match_data },
> -	{ "da226", (kernel_ulong_t)&da226_match_data },
> -	{ "da280", (kernel_ulong_t)&da280_match_data },
> +	{ .name =3D "da217", .driver_data =3D (kernel_ulong_t)&da217_match_data=
 },
> +	{ .name =3D "da226", .driver_data =3D (kernel_ulong_t)&da226_match_data=
 },
> +	{ .name =3D "da280", .driver_data =3D (kernel_ulong_t)&da280_match_data=
 },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, da280_i2c_id);
> diff --git a/drivers/iio/accel/da311.c b/drivers/iio/accel/da311.c
> index e1df7b009d89..dcb69c8eaf09 100644
> --- a/drivers/iio/accel/da311.c
> +++ b/drivers/iio/accel/da311.c
> @@ -268,7 +268,7 @@ static int da311_resume(struct device *dev)
>  static DEFINE_SIMPLE_DEV_PM_OPS(da311_pm_ops, da311_suspend, da311_resum=
e);
> =20
>  static const struct i2c_device_id da311_i2c_id[] =3D {
> -	{ "da311" },
> +	{ .name =3D "da311" },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, da311_i2c_id);
> diff --git a/drivers/iio/accel/dmard06.c b/drivers/iio/accel/dmard06.c
> index 33f225d73e7b..2957bf55d110 100644
> --- a/drivers/iio/accel/dmard06.c
> +++ b/drivers/iio/accel/dmard06.c
> @@ -199,9 +199,9 @@ static DEFINE_SIMPLE_DEV_PM_OPS(dmard06_pm_ops, dmard=
06_suspend,
>  				dmard06_resume);
> =20
>  static const struct i2c_device_id dmard06_id[] =3D {
> -	{ "dmard05" },
> -	{ "dmard06" },
> -	{ "dmard07" },
> +	{ .name =3D "dmard05" },
> +	{ .name =3D "dmard06" },
> +	{ .name =3D "dmard07" },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, dmard06_id);
> diff --git a/drivers/iio/accel/dmard09.c b/drivers/iio/accel/dmard09.c
> index d9290e3b9c46..fe35a1270786 100644
> --- a/drivers/iio/accel/dmard09.c
> +++ b/drivers/iio/accel/dmard09.c
> @@ -123,7 +123,7 @@ static int dmard09_probe(struct i2c_client *client)
>  }
> =20
>  static const struct i2c_device_id dmard09_id[] =3D {
> -	{ "dmard09" },
> +	{ .name =3D "dmard09" },
>  	{ }
>  };
> =20
> diff --git a/drivers/iio/accel/dmard10.c b/drivers/iio/accel/dmard10.c
> index 575e8510e1bd..8ba00fd57901 100644
> --- a/drivers/iio/accel/dmard10.c
> +++ b/drivers/iio/accel/dmard10.c
> @@ -229,7 +229,7 @@ static DEFINE_SIMPLE_DEV_PM_OPS(dmard10_pm_ops, dmard=
10_suspend,
>  				dmard10_resume);
> =20
>  static const struct i2c_device_id dmard10_i2c_id[] =3D {
> -	{ "dmard10" },
> +	{ .name =3D "dmard10" },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, dmard10_i2c_id);
> diff --git a/drivers/iio/accel/fxls8962af-i2c.c b/drivers/iio/accel/fxls8=
962af-i2c.c
> index 106198a12474..fa46f5aa34f7 100644
> --- a/drivers/iio/accel/fxls8962af-i2c.c
> +++ b/drivers/iio/accel/fxls8962af-i2c.c
> @@ -28,10 +28,10 @@ static int fxls8962af_probe(struct i2c_client *client)
>  }
> =20
>  static const struct i2c_device_id fxls8962af_id[] =3D {
> -	{ "fxls8962af", fxls8962af },
> -	{ "fxls8964af", fxls8964af },
> -	{ "fxls8967af", fxls8967af },
> -	{ "fxls8974cf", fxls8974cf },
> +	{ .name =3D "fxls8962af", .driver_data =3D fxls8962af },
> +	{ .name =3D "fxls8964af", .driver_data =3D fxls8964af },
> +	{ .name =3D "fxls8967af", .driver_data =3D fxls8967af },
> +	{ .name =3D "fxls8974cf", .driver_data =3D fxls8974cf },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, fxls8962af_id);
> diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-101=
3.c
> index 2823ddde4bf2..8a082ff034dd 100644
> --- a/drivers/iio/accel/kxcjk-1013.c
> +++ b/drivers/iio/accel/kxcjk-1013.c
> @@ -1630,11 +1630,11 @@ static const struct dev_pm_ops kxcjk1013_pm_ops =
=3D {
>  };
> =20
>  static const struct i2c_device_id kxcjk1013_id[] =3D {
> -	{ "kxcjk1013",  (kernel_ulong_t)&kxcjk1013_info },
> -	{ "kxcj91008",  (kernel_ulong_t)&kxcj91008_info },
> -	{ "kxtj21009",  (kernel_ulong_t)&kxtj21009_info },
> -	{ "kxtf9", (kernel_ulong_t)&kxtf9_info },
> -	{ "kx023-1025", (kernel_ulong_t)&kx0231025_info },
> +	{ .name =3D "kxcjk1013", .driver_data =3D (kernel_ulong_t)&kxcjk1013_in=
fo },
> +	{ .name =3D "kxcj91008", .driver_data =3D (kernel_ulong_t)&kxcj91008_in=
fo },
> +	{ .name =3D "kxtj21009", .driver_data =3D (kernel_ulong_t)&kxtj21009_in=
fo },
> +	{ .name =3D "kxtf9", .driver_data =3D (kernel_ulong_t)&kxtf9_info },
> +	{ .name =3D "kx023-1025", .driver_data =3D (kernel_ulong_t)&kx0231025_i=
nfo },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, kxcjk1013_id);
> diff --git a/drivers/iio/accel/kxsd9-i2c.c b/drivers/iio/accel/kxsd9-i2c.c
> index 1fa88b99149e..8f3314db82d2 100644
> --- a/drivers/iio/accel/kxsd9-i2c.c
> +++ b/drivers/iio/accel/kxsd9-i2c.c
> @@ -43,7 +43,7 @@ static const struct of_device_id kxsd9_of_match[] =3D {
>  MODULE_DEVICE_TABLE(of, kxsd9_of_match);
> =20
>  static const struct i2c_device_id kxsd9_i2c_id[] =3D {
> -	{ "kxsd9" },
> +	{ .name =3D "kxsd9" },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, kxsd9_i2c_id);
> diff --git a/drivers/iio/accel/mc3230.c b/drivers/iio/accel/mc3230.c
> index 3e494f9ddc56..b45897210a62 100644
> --- a/drivers/iio/accel/mc3230.c
> +++ b/drivers/iio/accel/mc3230.c
> @@ -230,8 +230,8 @@ static int mc3230_resume(struct device *dev)
>  static DEFINE_SIMPLE_DEV_PM_OPS(mc3230_pm_ops, mc3230_suspend, mc3230_re=
sume);
> =20
>  static const struct i2c_device_id mc3230_i2c_id[] =3D {
> -	{ "mc3230", (kernel_ulong_t)&mc3230_chip_info },
> -	{ "mc3510c", (kernel_ulong_t)&mc3510c_chip_info },
> +	{ .name =3D "mc3230", .driver_data =3D (kernel_ulong_t)&mc3230_chip_inf=
o },
> +	{ .name =3D "mc3510c", .driver_data =3D (kernel_ulong_t)&mc3510c_chip_i=
nfo },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, mc3230_i2c_id);
> diff --git a/drivers/iio/accel/mma7455_i2c.c b/drivers/iio/accel/mma7455_=
i2c.c
> index 2ff8eb1f9ce9..9588fd133b1e 100644
> --- a/drivers/iio/accel/mma7455_i2c.c
> +++ b/drivers/iio/accel/mma7455_i2c.c
> @@ -32,8 +32,8 @@ static void mma7455_i2c_remove(struct i2c_client *i2c)
>  }
> =20
>  static const struct i2c_device_id mma7455_i2c_ids[] =3D {
> -	{ "mma7455" },
> -	{ "mma7456" },
> +	{ .name =3D "mma7455" },
> +	{ .name =3D "mma7456" },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, mma7455_i2c_ids);
> diff --git a/drivers/iio/accel/mma7660.c b/drivers/iio/accel/mma7660.c
> index be3213600cf4..0ecf6c06dcc6 100644
> --- a/drivers/iio/accel/mma7660.c
> +++ b/drivers/iio/accel/mma7660.c
> @@ -259,7 +259,7 @@ static DEFINE_SIMPLE_DEV_PM_OPS(mma7660_pm_ops, mma76=
60_suspend,
>  				mma7660_resume);
> =20
>  static const struct i2c_device_id mma7660_i2c_id[] =3D {
> -	{ "mma7660" },
> +	{ .name =3D "mma7660" },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, mma7660_i2c_id);
> diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
> index 15172ba2972c..57f194faf910 100644
> --- a/drivers/iio/accel/mma8452.c
> +++ b/drivers/iio/accel/mma8452.c
> @@ -1821,12 +1821,12 @@ static const struct dev_pm_ops mma8452_pm_ops =3D=
 {
>  };
> =20
>  static const struct i2c_device_id mma8452_id[] =3D {
> -	{ "fxls8471", (kernel_ulong_t)&mma_chip_info_table[fxls8471] },
> -	{ "mma8451", (kernel_ulong_t)&mma_chip_info_table[mma8451] },
> -	{ "mma8452", (kernel_ulong_t)&mma_chip_info_table[mma8452] },
> -	{ "mma8453", (kernel_ulong_t)&mma_chip_info_table[mma8453] },
> -	{ "mma8652", (kernel_ulong_t)&mma_chip_info_table[mma8652] },
> -	{ "mma8653", (kernel_ulong_t)&mma_chip_info_table[mma8653] },
> +	{ .name =3D "fxls8471", .driver_data =3D (kernel_ulong_t)&mma_chip_info=
_table[fxls8471] },
> +	{ .name =3D "mma8451", .driver_data =3D (kernel_ulong_t)&mma_chip_info_=
table[mma8451] },
> +	{ .name =3D "mma8452", .driver_data =3D (kernel_ulong_t)&mma_chip_info_=
table[mma8452] },
> +	{ .name =3D "mma8453", .driver_data =3D (kernel_ulong_t)&mma_chip_info_=
table[mma8453] },
> +	{ .name =3D "mma8652", .driver_data =3D (kernel_ulong_t)&mma_chip_info_=
table[mma8652] },
> +	{ .name =3D "mma8653", .driver_data =3D (kernel_ulong_t)&mma_chip_info_=
table[mma8653] },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, mma8452_id);
> diff --git a/drivers/iio/accel/mma9551.c b/drivers/iio/accel/mma9551.c
> index 02195deada49..020370b0ec07 100644
> --- a/drivers/iio/accel/mma9551.c
> +++ b/drivers/iio/accel/mma9551.c
> @@ -582,7 +582,7 @@ static const struct acpi_device_id mma9551_acpi_match=
[] =3D {
>  MODULE_DEVICE_TABLE(acpi, mma9551_acpi_match);
> =20
>  static const struct i2c_device_id mma9551_id[] =3D {
> -	{ "mma9551" },
> +	{ .name =3D "mma9551" },
>  	{ }
>  };
> =20
> diff --git a/drivers/iio/accel/mma9553.c b/drivers/iio/accel/mma9553.c
> index f85384a7908f..90ce86244ee8 100644
> --- a/drivers/iio/accel/mma9553.c
> +++ b/drivers/iio/accel/mma9553.c
> @@ -1219,7 +1219,7 @@ static const struct acpi_device_id mma9553_acpi_mat=
ch[] =3D {
>  MODULE_DEVICE_TABLE(acpi, mma9553_acpi_match);
> =20
>  static const struct i2c_device_id mma9553_id[] =3D {
> -	{ "mma9553" },
> +	{ .name =3D "mma9553" },
>  	{ }
>  };
> =20
> diff --git a/drivers/iio/accel/mxc4005.c b/drivers/iio/accel/mxc4005.c
> index a2c3cf13d098..434971fbfb12 100644
> --- a/drivers/iio/accel/mxc4005.c
> +++ b/drivers/iio/accel/mxc4005.c
> @@ -580,8 +580,8 @@ static const struct of_device_id mxc4005_of_match[] =
=3D {
>  MODULE_DEVICE_TABLE(of, mxc4005_of_match);
> =20
>  static const struct i2c_device_id mxc4005_id[] =3D {
> -	{ "mxc4005" },
> -	{ "mxc6655" },
> +	{ .name =3D "mxc4005" },
> +	{ .name =3D "mxc6655" },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, mxc4005_id);
> diff --git a/drivers/iio/accel/mxc6255.c b/drivers/iio/accel/mxc6255.c
> index fc3ed84d1933..901f2b9f16a2 100644
> --- a/drivers/iio/accel/mxc6255.c
> +++ b/drivers/iio/accel/mxc6255.c
> @@ -171,8 +171,8 @@ static const struct acpi_device_id mxc6255_acpi_match=
[] =3D {
>  MODULE_DEVICE_TABLE(acpi, mxc6255_acpi_match);
> =20
>  static const struct i2c_device_id mxc6255_id[] =3D {
> -	{ "mxc6225" },
> -	{ "mxc6255" },
> +	{ .name =3D "mxc6225" },
> +	{ .name =3D "mxc6255" },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, mxc6255_id);
> diff --git a/drivers/iio/accel/st_accel_i2c.c b/drivers/iio/accel/st_acce=
l_i2c.c
> index f24449500533..eecc7fcdb06e 100644
> --- a/drivers/iio/accel/st_accel_i2c.c
> +++ b/drivers/iio/accel/st_accel_i2c.c
> @@ -138,32 +138,32 @@ static const struct acpi_device_id st_accel_acpi_ma=
tch[] =3D {
>  MODULE_DEVICE_TABLE(acpi, st_accel_acpi_match);
> =20
>  static const struct i2c_device_id st_accel_id_table[] =3D {
> -	{ LSM303DLH_ACCEL_DEV_NAME },
> -	{ LSM303DLHC_ACCEL_DEV_NAME },
> -	{ LIS3DH_ACCEL_DEV_NAME },
> -	{ LSM330D_ACCEL_DEV_NAME },
> -	{ LSM330DL_ACCEL_DEV_NAME },
> -	{ LSM330DLC_ACCEL_DEV_NAME },
> -	{ LIS331DLH_ACCEL_DEV_NAME },
> -	{ LSM303DL_ACCEL_DEV_NAME },
> -	{ LSM303DLM_ACCEL_DEV_NAME },
> -	{ LSM330_ACCEL_DEV_NAME },
> -	{ LSM303AGR_ACCEL_DEV_NAME },
> -	{ LIS2DH12_ACCEL_DEV_NAME },
> -	{ LIS3L02DQ_ACCEL_DEV_NAME },
> -	{ LNG2DM_ACCEL_DEV_NAME },
> -	{ H3LIS331DL_ACCEL_DEV_NAME },
> -	{ LIS331DL_ACCEL_DEV_NAME },
> -	{ LIS3LV02DL_ACCEL_DEV_NAME },
> -	{ LIS2DW12_ACCEL_DEV_NAME },
> -	{ LIS3DE_ACCEL_DEV_NAME },
> -	{ LIS2DE12_ACCEL_DEV_NAME },
> -	{ LIS2DS12_ACCEL_DEV_NAME },
> -	{ LIS2HH12_ACCEL_DEV_NAME },
> -	{ LIS302DL_ACCEL_DEV_NAME },
> -	{ LSM303C_ACCEL_DEV_NAME },
> -	{ SC7A20_ACCEL_DEV_NAME },
> -	{ IIS328DQ_ACCEL_DEV_NAME },
> +	{ .name =3D LSM303DLH_ACCEL_DEV_NAME },
> +	{ .name =3D LSM303DLHC_ACCEL_DEV_NAME },
> +	{ .name =3D LIS3DH_ACCEL_DEV_NAME },
> +	{ .name =3D LSM330D_ACCEL_DEV_NAME },
> +	{ .name =3D LSM330DL_ACCEL_DEV_NAME },
> +	{ .name =3D LSM330DLC_ACCEL_DEV_NAME },
> +	{ .name =3D LIS331DLH_ACCEL_DEV_NAME },
> +	{ .name =3D LSM303DL_ACCEL_DEV_NAME },
> +	{ .name =3D LSM303DLM_ACCEL_DEV_NAME },
> +	{ .name =3D LSM330_ACCEL_DEV_NAME },
> +	{ .name =3D LSM303AGR_ACCEL_DEV_NAME },
> +	{ .name =3D LIS2DH12_ACCEL_DEV_NAME },
> +	{ .name =3D LIS3L02DQ_ACCEL_DEV_NAME },
> +	{ .name =3D LNG2DM_ACCEL_DEV_NAME },
> +	{ .name =3D H3LIS331DL_ACCEL_DEV_NAME },
> +	{ .name =3D LIS331DL_ACCEL_DEV_NAME },
> +	{ .name =3D LIS3LV02DL_ACCEL_DEV_NAME },
> +	{ .name =3D LIS2DW12_ACCEL_DEV_NAME },
> +	{ .name =3D LIS3DE_ACCEL_DEV_NAME },
> +	{ .name =3D LIS2DE12_ACCEL_DEV_NAME },
> +	{ .name =3D LIS2DS12_ACCEL_DEV_NAME },
> +	{ .name =3D LIS2HH12_ACCEL_DEV_NAME },
> +	{ .name =3D LIS302DL_ACCEL_DEV_NAME },
> +	{ .name =3D LSM303C_ACCEL_DEV_NAME },
> +	{ .name =3D SC7A20_ACCEL_DEV_NAME },
> +	{ .name =3D IIS328DQ_ACCEL_DEV_NAME },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, st_accel_id_table);
> diff --git a/drivers/iio/accel/stk8312.c b/drivers/iio/accel/stk8312.c
> index f31c6ab3392d..8b5a3e0489e9 100644
> --- a/drivers/iio/accel/stk8312.c
> +++ b/drivers/iio/accel/stk8312.c
> @@ -630,8 +630,8 @@ static DEFINE_SIMPLE_DEV_PM_OPS(stk8312_pm_ops, stk83=
12_suspend,
> =20
>  static const struct i2c_device_id stk8312_i2c_id[] =3D {
>  	/* Deprecated in favour of lowercase form */
> -	{ "STK8312" },
> -	{ "stk8312" },
> +	{ .name =3D "STK8312" },
> +	{ .name =3D "stk8312" },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, stk8312_i2c_id);
> diff --git a/drivers/iio/accel/stk8ba50.c b/drivers/iio/accel/stk8ba50.c
> index a9ff2a273fe1..ccea1331cafc 100644
> --- a/drivers/iio/accel/stk8ba50.c
> +++ b/drivers/iio/accel/stk8ba50.c
> @@ -519,7 +519,7 @@ static DEFINE_SIMPLE_DEV_PM_OPS(stk8ba50_pm_ops, stk8=
ba50_suspend,
>  				stk8ba50_resume);
> =20
>  static const struct i2c_device_id stk8ba50_i2c_id[] =3D {
> -	{ "stk8ba50" },
> +	{ .name =3D "stk8ba50" },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, stk8ba50_i2c_id);
> diff --git a/drivers/iio/adc/ad7291.c b/drivers/iio/adc/ad7291.c
> index 60e12faa3207..6a1493e27a30 100644
> --- a/drivers/iio/adc/ad7291.c
> +++ b/drivers/iio/adc/ad7291.c
> @@ -536,7 +536,7 @@ static int ad7291_probe(struct i2c_client *client)
>  }
> =20
>  static const struct i2c_device_id ad7291_id[] =3D {
> -	{ "ad7291" },
> +	{ .name =3D "ad7291" },
>  	{ }
>  };
> =20
> diff --git a/drivers/iio/adc/ad799x.c b/drivers/iio/adc/ad799x.c
> index 108bb22162ef..db6bc7dff8c2 100644
> --- a/drivers/iio/adc/ad799x.c
> +++ b/drivers/iio/adc/ad799x.c
> @@ -946,14 +946,14 @@ static int ad799x_resume(struct device *dev)
>  static DEFINE_SIMPLE_DEV_PM_OPS(ad799x_pm_ops, ad799x_suspend, ad799x_re=
sume);
> =20
>  static const struct i2c_device_id ad799x_id[] =3D {
> -	{ "ad7991", ad7991 },
> -	{ "ad7995", ad7995 },
> -	{ "ad7999", ad7999 },
> -	{ "ad7992", ad7992 },
> -	{ "ad7993", ad7993 },
> -	{ "ad7994", ad7994 },
> -	{ "ad7997", ad7997 },
> -	{ "ad7998", ad7998 },
> +	{ .name =3D "ad7991", .driver_data =3D ad7991 },
> +	{ .name =3D "ad7995", .driver_data =3D ad7995 },
> +	{ .name =3D "ad7999", .driver_data =3D ad7999 },
> +	{ .name =3D "ad7992", .driver_data =3D ad7992 },
> +	{ .name =3D "ad7993", .driver_data =3D ad7993 },
> +	{ .name =3D "ad7994", .driver_data =3D ad7994 },
> +	{ .name =3D "ad7997", .driver_data =3D ad7997 },
> +	{ .name =3D "ad7998", .driver_data =3D ad7998 },
>  	{ }
>  };
> =20
> diff --git a/drivers/iio/adc/gehc-pmc-adc.c b/drivers/iio/adc/gehc-pmc-ad=
c.c
> index d1167818b17d..24193e941494 100644
> --- a/drivers/iio/adc/gehc-pmc-adc.c
> +++ b/drivers/iio/adc/gehc-pmc-adc.c
> @@ -207,7 +207,7 @@ static const struct of_device_id pmc_adc_of_match[] =
=3D {
>  MODULE_DEVICE_TABLE(of, pmc_adc_of_match);
> =20
>  static const struct i2c_device_id pmc_adc_id_table[] =3D {
> -	{ "pmc-adc" },
> +	{ .name =3D "pmc-adc" },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, pmc_adc_id_table);
> diff --git a/drivers/iio/adc/ina2xx-adc.c b/drivers/iio/adc/ina2xx-adc.c
> index 7c04e3ec1cbc..c412f5ed46a1 100644
> --- a/drivers/iio/adc/ina2xx-adc.c
> +++ b/drivers/iio/adc/ina2xx-adc.c
> @@ -1078,12 +1078,12 @@ static void ina2xx_remove(struct i2c_client *clie=
nt)
>  }
> =20
>  static const struct i2c_device_id ina2xx_id[] =3D {
> -	{ "ina219", ina219 },
> -	{ "ina220", ina219 },
> -	{ "ina226", ina226 },
> -	{ "ina230", ina226 },
> -	{ "ina231", ina226 },
> -	{ "ina236", ina236 },
> +	{ .name =3D "ina219", .driver_data =3D ina219 },
> +	{ .name =3D "ina220", .driver_data =3D ina219 },
> +	{ .name =3D "ina226", .driver_data =3D ina226 },
> +	{ .name =3D "ina230", .driver_data =3D ina226 },
> +	{ .name =3D "ina231", .driver_data =3D ina226 },
> +	{ .name =3D "ina236", .driver_data =3D ina236 },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, ina2xx_id);
> diff --git a/drivers/iio/adc/ltc2309.c b/drivers/iio/adc/ltc2309.c
> index 316256edf150..7db1b09b72be 100644
> --- a/drivers/iio/adc/ltc2309.c
> +++ b/drivers/iio/adc/ltc2309.c
> @@ -233,8 +233,8 @@ static const struct of_device_id ltc2309_of_match[] =
=3D {
>  MODULE_DEVICE_TABLE(of, ltc2309_of_match);
> =20
>  static const struct i2c_device_id ltc2309_id[] =3D {
> -	{ "ltc2305", (kernel_ulong_t)&ltc2305_chip_info },
> -	{ "ltc2309", (kernel_ulong_t)&ltc2309_chip_info },
> +	{ .name =3D "ltc2305", .driver_data =3D (kernel_ulong_t)&ltc2305_chip_i=
nfo },
> +	{ .name =3D "ltc2309", .driver_data =3D (kernel_ulong_t)&ltc2309_chip_i=
nfo },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, ltc2309_id);
> diff --git a/drivers/iio/adc/ltc2471.c b/drivers/iio/adc/ltc2471.c
> index a579107fd5c9..369af700969f 100644
> --- a/drivers/iio/adc/ltc2471.c
> +++ b/drivers/iio/adc/ltc2471.c
> @@ -136,8 +136,8 @@ static int ltc2471_i2c_probe(struct i2c_client *clien=
t)
>  }
> =20
>  static const struct i2c_device_id ltc2471_i2c_id[] =3D {
> -	{ "ltc2471", ltc2471 },
> -	{ "ltc2473", ltc2473 },
> +	{ .name =3D "ltc2471", .driver_data =3D ltc2471 },
> +	{ .name =3D "ltc2473", .driver_data =3D ltc2473 },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, ltc2471_i2c_id);
> diff --git a/drivers/iio/adc/ltc2485.c b/drivers/iio/adc/ltc2485.c
> index 060651dd4130..8c3806e061dd 100644
> --- a/drivers/iio/adc/ltc2485.c
> +++ b/drivers/iio/adc/ltc2485.c
> @@ -124,7 +124,7 @@ static int ltc2485_probe(struct i2c_client *client)
>  }
> =20
>  static const struct i2c_device_id ltc2485_id[] =3D {
> -	{ "ltc2485" },
> +	{ .name =3D "ltc2485" },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, ltc2485_id);
> diff --git a/drivers/iio/adc/ltc2497.c b/drivers/iio/adc/ltc2497.c
> index eb9d521e86e5..8e899d6ffcfa 100644
> --- a/drivers/iio/adc/ltc2497.c
> +++ b/drivers/iio/adc/ltc2497.c
> @@ -142,8 +142,8 @@ static const struct ltc2497_chip_info ltc2497_info[] =
=3D {
>  };
> =20
>  static const struct i2c_device_id ltc2497_id[] =3D {
> -	{ "ltc2497", (kernel_ulong_t)&ltc2497_info[TYPE_LTC2497] },
> -	{ "ltc2499", (kernel_ulong_t)&ltc2497_info[TYPE_LTC2499] },
> +	{ .name =3D "ltc2497", .driver_data =3D (kernel_ulong_t)&ltc2497_info[T=
YPE_LTC2497] },
> +	{ .name =3D "ltc2499", .driver_data =3D (kernel_ulong_t)&ltc2497_info[T=
YPE_LTC2499] },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, ltc2497_id);
> diff --git a/drivers/iio/adc/max34408.c b/drivers/iio/adc/max34408.c
> index 4f45fd22a90c..da847eaed84e 100644
> --- a/drivers/iio/adc/max34408.c
> +++ b/drivers/iio/adc/max34408.c
> @@ -256,8 +256,8 @@ static const struct of_device_id max34408_of_match[] =
=3D {
>  MODULE_DEVICE_TABLE(of, max34408_of_match);
> =20
>  static const struct i2c_device_id max34408_id[] =3D {
> -	{ "max34408", (kernel_ulong_t)&max34408_model_data },
> -	{ "max34409", (kernel_ulong_t)&max34409_model_data },
> +	{ .name =3D "max34408", .driver_data =3D (kernel_ulong_t)&max34408_mode=
l_data },
> +	{ .name =3D "max34409", .driver_data =3D (kernel_ulong_t)&max34409_mode=
l_data },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, max34408_id);
> diff --git a/drivers/iio/adc/mcp3422.c b/drivers/iio/adc/mcp3422.c
> index 50834fdcf738..3180994ade27 100644
> --- a/drivers/iio/adc/mcp3422.c
> +++ b/drivers/iio/adc/mcp3422.c
> @@ -394,14 +394,14 @@ static int mcp3422_probe(struct i2c_client *client)
>  }
> =20
>  static const struct i2c_device_id mcp3422_id[] =3D {
> -	{ "mcp3421", 1 },
> -	{ "mcp3422", 2 },
> -	{ "mcp3423", 3 },
> -	{ "mcp3424", 4 },
> -	{ "mcp3425", 5 },
> -	{ "mcp3426", 6 },
> -	{ "mcp3427", 7 },
> -	{ "mcp3428", 8 },
> +	{ .name =3D "mcp3421", .driver_data =3D 1 },
> +	{ .name =3D "mcp3422", .driver_data =3D 2 },
> +	{ .name =3D "mcp3423", .driver_data =3D 3 },
> +	{ .name =3D "mcp3424", .driver_data =3D 4 },
> +	{ .name =3D "mcp3425", .driver_data =3D 5 },
> +	{ .name =3D "mcp3426", .driver_data =3D 6 },
> +	{ .name =3D "mcp3427", .driver_data =3D 7 },
> +	{ .name =3D "mcp3428", .driver_data =3D 8 },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, mcp3422_id);
> diff --git a/drivers/iio/adc/nau7802.c b/drivers/iio/adc/nau7802.c
> index 970afb27b839..836c9b49c721 100644
> --- a/drivers/iio/adc/nau7802.c
> +++ b/drivers/iio/adc/nau7802.c
> @@ -531,7 +531,7 @@ static int nau7802_probe(struct i2c_client *client)
>  }
> =20
>  static const struct i2c_device_id nau7802_i2c_id[] =3D {
> -	{ "nau7802" },
> +	{ .name =3D "nau7802" },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, nau7802_i2c_id);
> diff --git a/drivers/iio/adc/rohm-bd79124.c b/drivers/iio/adc/rohm-bd7912=
4.c
> index 40d00bd0cc9d..864f3b1366b5 100644
> --- a/drivers/iio/adc/rohm-bd79124.c
> +++ b/drivers/iio/adc/rohm-bd79124.c
> @@ -1104,7 +1104,7 @@ static const struct of_device_id bd79124_of_match[]=
 =3D {
>  MODULE_DEVICE_TABLE(of, bd79124_of_match);
> =20
>  static const struct i2c_device_id bd79124_id[] =3D {
> -	{ "bd79124" },
> +	{ .name =3D "bd79124" },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, bd79124_id);
> diff --git a/drivers/iio/adc/ti-adc081c.c b/drivers/iio/adc/ti-adc081c.c
> index 8ef51c57912d..33f82bdfeb94 100644
> --- a/drivers/iio/adc/ti-adc081c.c
> +++ b/drivers/iio/adc/ti-adc081c.c
> @@ -199,9 +199,9 @@ static int adc081c_probe(struct i2c_client *client)
>  }
> =20
>  static const struct i2c_device_id adc081c_id[] =3D {
> -	{ "adc081c", (kernel_ulong_t)&adc081c_model },
> -	{ "adc101c", (kernel_ulong_t)&adc101c_model },
> -	{ "adc121c", (kernel_ulong_t)&adc121c_model },
> +	{ .name =3D "adc081c", .driver_data =3D (kernel_ulong_t)&adc081c_model =
},
> +	{ .name =3D "adc101c", .driver_data =3D (kernel_ulong_t)&adc101c_model =
},
> +	{ .name =3D "adc121c", .driver_data =3D (kernel_ulong_t)&adc121c_model =
},
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, adc081c_id);
> diff --git a/drivers/iio/adc/ti-ads1015.c b/drivers/iio/adc/ti-ads1015.c
> index c7ffe47449e2..8a272af69f7d 100644
> --- a/drivers/iio/adc/ti-ads1015.c
> +++ b/drivers/iio/adc/ti-ads1015.c
> @@ -1128,9 +1128,9 @@ static const struct ads1015_chip_data tla2024_data =
=3D {
>  };
> =20
>  static const struct i2c_device_id ads1015_id[] =3D {
> -	{ "ads1015", (kernel_ulong_t)&ads1015_data },
> -	{ "ads1115", (kernel_ulong_t)&ads1115_data },
> -	{ "tla2024", (kernel_ulong_t)&tla2024_data },
> +	{ .name =3D "ads1015", .driver_data =3D (kernel_ulong_t)&ads1015_data },
> +	{ .name =3D "ads1115", .driver_data =3D (kernel_ulong_t)&ads1115_data },
> +	{ .name =3D "tla2024", .driver_data =3D (kernel_ulong_t)&tla2024_data },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, ads1015_id);
> diff --git a/drivers/iio/adc/ti-ads1100.c b/drivers/iio/adc/ti-ads1100.c
> index aa8946063c7d..9fe8d54cce83 100644
> --- a/drivers/iio/adc/ti-ads1100.c
> +++ b/drivers/iio/adc/ti-ads1100.c
> @@ -400,8 +400,8 @@ static DEFINE_RUNTIME_DEV_PM_OPS(ads1100_pm_ops,
>  				 NULL);
> =20
>  static const struct i2c_device_id ads1100_id[] =3D {
> -	{ "ads1100" },
> -	{ "ads1000" },
> +	{ .name =3D "ads1100" },
> +	{ .name =3D "ads1000" },
>  	{ }
>  };
> =20
> diff --git a/drivers/iio/adc/ti-ads1119.c b/drivers/iio/adc/ti-ads1119.c
> index 2320be0efb50..d31f3d6eb781 100644
> --- a/drivers/iio/adc/ti-ads1119.c
> +++ b/drivers/iio/adc/ti-ads1119.c
> @@ -804,7 +804,7 @@ static const struct of_device_id __maybe_unused ads11=
19_of_match[] =3D {
>  MODULE_DEVICE_TABLE(of, ads1119_of_match);
> =20
>  static const struct i2c_device_id ads1119_id[] =3D {
> -	{ "ads1119" },
> +	{ .name =3D "ads1119" },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, ads1119_id);
> diff --git a/drivers/iio/adc/ti-ads7138.c b/drivers/iio/adc/ti-ads7138.c
> index ee5c1b8e3a8e..af87f5f19a0f 100644
> --- a/drivers/iio/adc/ti-ads7138.c
> +++ b/drivers/iio/adc/ti-ads7138.c
> @@ -727,8 +727,8 @@ static const struct of_device_id ads7138_of_match[] =
=3D {
>  MODULE_DEVICE_TABLE(of, ads7138_of_match);
> =20
>  static const struct i2c_device_id ads7138_device_ids[] =3D {
> -	{ "ads7128", (kernel_ulong_t)&ads7128_data },
> -	{ "ads7138", (kernel_ulong_t)&ads7138_data },
> +	{ .name =3D "ads7128", .driver_data =3D (kernel_ulong_t)&ads7128_data },
> +	{ .name =3D "ads7138", .driver_data =3D (kernel_ulong_t)&ads7138_data },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, ads7138_device_ids);
> diff --git a/drivers/iio/adc/ti-ads7924.c b/drivers/iio/adc/ti-ads7924.c
> index bbcc4fc22b6e..b57d1c597c11 100644
> --- a/drivers/iio/adc/ti-ads7924.c
> +++ b/drivers/iio/adc/ti-ads7924.c
> @@ -441,7 +441,7 @@ static int ads7924_probe(struct i2c_client *client)
>  }
> =20
>  static const struct i2c_device_id ads7924_id[] =3D {
> -	{ "ads7924" },
> +	{ .name =3D "ads7924" },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, ads7924_id);
> diff --git a/drivers/iio/cdc/ad7150.c b/drivers/iio/cdc/ad7150.c
> index 8106a6a83561..cb9fff3bd67f 100644
> --- a/drivers/iio/cdc/ad7150.c
> +++ b/drivers/iio/cdc/ad7150.c
> @@ -628,9 +628,9 @@ static int ad7150_probe(struct i2c_client *client)
>  }
> =20
>  static const struct i2c_device_id ad7150_id[] =3D {
> -	{ "ad7150", AD7150 },
> -	{ "ad7151", AD7151 },
> -	{ "ad7156", AD7150 },
> +	{ .name =3D "ad7150", .driver_data =3D AD7150 },
> +	{ .name =3D "ad7151", .driver_data =3D AD7151 },
> +	{ .name =3D "ad7156", .driver_data =3D AD7150 },
>  	{ }
>  };
> =20
> diff --git a/drivers/iio/cdc/ad7746.c b/drivers/iio/cdc/ad7746.c
> index cb97e3c978d8..cf68b882bc49 100644
> --- a/drivers/iio/cdc/ad7746.c
> +++ b/drivers/iio/cdc/ad7746.c
> @@ -789,9 +789,9 @@ static int ad7746_probe(struct i2c_client *client)
>  }
> =20
>  static const struct i2c_device_id ad7746_id[] =3D {
> -	{ "ad7745", 7745 },
> -	{ "ad7746", 7746 },
> -	{ "ad7747", 7747 },
> +	{ .name =3D "ad7745", .driver_data =3D 7745 },
> +	{ .name =3D "ad7746", .driver_data =3D 7746 },
> +	{ .name =3D "ad7747", .driver_data =3D 7747 },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, ad7746_id);
> diff --git a/drivers/iio/chemical/ags02ma.c b/drivers/iio/chemical/ags02m=
a.c
> index 151178d4e8f4..8b97ea4a9515 100644
> --- a/drivers/iio/chemical/ags02ma.c
> +++ b/drivers/iio/chemical/ags02ma.c
> @@ -139,7 +139,7 @@ static int ags02ma_probe(struct i2c_client *client)
>  }
> =20
>  static const struct i2c_device_id ags02ma_id_table[] =3D {
> -	{ "ags02ma" },
> +	{ .name =3D "ags02ma" },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, ags02ma_id_table);
> diff --git a/drivers/iio/chemical/ams-iaq-core.c b/drivers/iio/chemical/a=
ms-iaq-core.c
> index 10156d794092..7aa7841c530e 100644
> --- a/drivers/iio/chemical/ams-iaq-core.c
> +++ b/drivers/iio/chemical/ams-iaq-core.c
> @@ -163,7 +163,7 @@ static int ams_iaqcore_probe(struct i2c_client *clien=
t)
>  }
> =20
>  static const struct i2c_device_id ams_iaqcore_id[] =3D {
> -	{ "ams-iaq-core" },
> +	{ .name =3D "ams-iaq-core" },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, ams_iaqcore_id);
> diff --git a/drivers/iio/chemical/atlas-ezo-sensor.c b/drivers/iio/chemic=
al/atlas-ezo-sensor.c
> index 59f3a4fa9e9f..05da3b8a92ab 100644
> --- a/drivers/iio/chemical/atlas-ezo-sensor.c
> +++ b/drivers/iio/chemical/atlas-ezo-sensor.c
> @@ -186,9 +186,9 @@ static const struct iio_info atlas_info =3D {
>  };
> =20
>  static const struct i2c_device_id atlas_ezo_id[] =3D {
> -	{ "atlas-co2-ezo", (kernel_ulong_t)&atlas_ezo_devices[ATLAS_CO2_EZO] },
> -	{ "atlas-o2-ezo", (kernel_ulong_t)&atlas_ezo_devices[ATLAS_O2_EZO] },
> -	{ "atlas-hum-ezo", (kernel_ulong_t)&atlas_ezo_devices[ATLAS_HUM_EZO] },
> +	{ .name =3D "atlas-co2-ezo", .driver_data =3D (kernel_ulong_t)&atlas_ez=
o_devices[ATLAS_CO2_EZO] },
> +	{ .name =3D "atlas-o2-ezo", .driver_data =3D (kernel_ulong_t)&atlas_ezo=
_devices[ATLAS_O2_EZO] },
> +	{ .name =3D "atlas-hum-ezo", .driver_data =3D (kernel_ulong_t)&atlas_ez=
o_devices[ATLAS_HUM_EZO] },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, atlas_ezo_id);
> diff --git a/drivers/iio/chemical/atlas-sensor.c b/drivers/iio/chemical/a=
tlas-sensor.c
> index 8bbba85af699..0e2edcff63f9 100644
> --- a/drivers/iio/chemical/atlas-sensor.c
> +++ b/drivers/iio/chemical/atlas-sensor.c
> @@ -586,11 +586,11 @@ static const struct iio_info atlas_info =3D {
>  };
> =20
>  static const struct i2c_device_id atlas_id[] =3D {
> -	{ "atlas-ph-sm", (kernel_ulong_t)&atlas_devices[ATLAS_PH_SM] },
> -	{ "atlas-ec-sm", (kernel_ulong_t)&atlas_devices[ATLAS_EC_SM] },
> -	{ "atlas-orp-sm", (kernel_ulong_t)&atlas_devices[ATLAS_ORP_SM] },
> -	{ "atlas-do-sm", (kernel_ulong_t)&atlas_devices[ATLAS_DO_SM] },
> -	{ "atlas-rtd-sm", (kernel_ulong_t)&atlas_devices[ATLAS_RTD_SM] },
> +	{ .name =3D "atlas-ph-sm", .driver_data =3D (kernel_ulong_t)&atlas_devi=
ces[ATLAS_PH_SM] },
> +	{ .name =3D "atlas-ec-sm", .driver_data =3D (kernel_ulong_t)&atlas_devi=
ces[ATLAS_EC_SM] },
> +	{ .name =3D "atlas-orp-sm", .driver_data =3D (kernel_ulong_t)&atlas_dev=
ices[ATLAS_ORP_SM] },
> +	{ .name =3D "atlas-do-sm", .driver_data =3D (kernel_ulong_t)&atlas_devi=
ces[ATLAS_DO_SM] },
> +	{ .name =3D "atlas-rtd-sm", .driver_data =3D (kernel_ulong_t)&atlas_dev=
ices[ATLAS_RTD_SM] },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, atlas_id);
> diff --git a/drivers/iio/chemical/bme680_i2c.c b/drivers/iio/chemical/bme=
680_i2c.c
> index 5560ea708b36..4cc0e491621a 100644
> --- a/drivers/iio/chemical/bme680_i2c.c
> +++ b/drivers/iio/chemical/bme680_i2c.c
> @@ -36,7 +36,7 @@ static int bme680_i2c_probe(struct i2c_client *client)
>  }
> =20
>  static const struct i2c_device_id bme680_i2c_id[] =3D {
> -	{ "bme680" },
> +	{ .name =3D "bme680" },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, bme680_i2c_id);
> diff --git a/drivers/iio/chemical/ccs811.c b/drivers/iio/chemical/ccs811.c
> index 998c9239c4c7..ce7187ccd706 100644
> --- a/drivers/iio/chemical/ccs811.c
> +++ b/drivers/iio/chemical/ccs811.c
> @@ -552,8 +552,8 @@ static void ccs811_remove(struct i2c_client *client)
>  }
> =20
>  static const struct i2c_device_id ccs811_id[] =3D {
> -	{ "ccs811" },
> -	{	}
> +	{ .name =3D "ccs811" },
> +	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, ccs811_id);
> =20
> diff --git a/drivers/iio/chemical/ens160_i2c.c b/drivers/iio/chemical/ens=
160_i2c.c
> index aa0dfe639245..ab0e8dcce011 100644
> --- a/drivers/iio/chemical/ens160_i2c.c
> +++ b/drivers/iio/chemical/ens160_i2c.c
> @@ -34,7 +34,7 @@ static int ens160_i2c_probe(struct i2c_client *client)
>  }
> =20
>  static const struct i2c_device_id ens160_i2c_id[] =3D {
> -	{ "ens160" },
> +	{ .name =3D "ens160" },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, ens160_i2c_id);
> diff --git a/drivers/iio/chemical/sgp30.c b/drivers/iio/chemical/sgp30.c
> index 21730d62b5c8..d12d3fe83179 100644
> --- a/drivers/iio/chemical/sgp30.c
> +++ b/drivers/iio/chemical/sgp30.c
> @@ -562,8 +562,8 @@ static void sgp_remove(struct i2c_client *client)
>  }
> =20
>  static const struct i2c_device_id sgp_id[] =3D {
> -	{ "sgp30", (kernel_ulong_t)&sgp_devices[SGP30] },
> -	{ "sgpc3", (kernel_ulong_t)&sgp_devices[SGPC3] },
> +	{ .name =3D "sgp30", .driver_data =3D (kernel_ulong_t)&sgp_devices[SGP3=
0] },
> +	{ .name =3D "sgpc3", .driver_data =3D (kernel_ulong_t)&sgp_devices[SGPC=
3] },
>  	{ }
>  };
> =20
> diff --git a/drivers/iio/chemical/sgp40.c b/drivers/iio/chemical/sgp40.c
> index 07d8ab830211..b2b5e32a9eb2 100644
> --- a/drivers/iio/chemical/sgp40.c
> +++ b/drivers/iio/chemical/sgp40.c
> @@ -355,7 +355,7 @@ static int sgp40_probe(struct i2c_client *client)
>  }
> =20
>  static const struct i2c_device_id sgp40_id[] =3D {
> -	{ "sgp40" },
> +	{ .name =3D "sgp40" },
>  	{ }
>  };
> =20
> diff --git a/drivers/iio/chemical/sps30_i2c.c b/drivers/iio/chemical/sps3=
0_i2c.c
> index c92f04990c34..61781aaabd85 100644
> --- a/drivers/iio/chemical/sps30_i2c.c
> +++ b/drivers/iio/chemical/sps30_i2c.c
> @@ -232,7 +232,7 @@ static int sps30_i2c_probe(struct i2c_client *client)
>  }
> =20
>  static const struct i2c_device_id sps30_i2c_id[] =3D {
> -	{ "sps30" },
> +	{ .name =3D "sps30" },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, sps30_i2c_id);
> diff --git a/drivers/iio/chemical/vz89x.c b/drivers/iio/chemical/vz89x.c
> index 5b358bcd311b..4deacf10b6ef 100644
> --- a/drivers/iio/chemical/vz89x.c
> +++ b/drivers/iio/chemical/vz89x.c
> @@ -385,8 +385,8 @@ static int vz89x_probe(struct i2c_client *client)
>  }
> =20
>  static const struct i2c_device_id vz89x_id[] =3D {
> -	{ "vz89x", (kernel_ulong_t)&vz89x_chips[VZ89X] },
> -	{ "vz89te", (kernel_ulong_t)&vz89x_chips[VZ89TE] },
> +	{ .name =3D "vz89x", .driver_data =3D (kernel_ulong_t)&vz89x_chips[VZ89=
X] },
> +	{ .name =3D "vz89te", .driver_data =3D (kernel_ulong_t)&vz89x_chips[VZ8=
9TE] },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, vz89x_id);
> diff --git a/drivers/iio/dac/ad5064.c b/drivers/iio/dac/ad5064.c
> index 84be5174babd..b5ec33f5c317 100644
> --- a/drivers/iio/dac/ad5064.c
> +++ b/drivers/iio/dac/ad5064.c
> @@ -1001,53 +1001,53 @@ static int ad5064_i2c_probe(struct i2c_client *i2=
c)
>  }
> =20
>  static const struct i2c_device_id ad5064_i2c_ids[] =3D {
> -	{"ad5625", ID_AD5625 },
> -	{"ad5625r-1v25", ID_AD5625R_1V25 },
> -	{"ad5625r-2v5", ID_AD5625R_2V5 },
> -	{"ad5627", ID_AD5627 },
> -	{"ad5627r-1v25", ID_AD5627R_1V25 },
> -	{"ad5627r-2v5", ID_AD5627R_2V5 },
> -	{"ad5629-1", ID_AD5629_1},
> -	{"ad5629-2", ID_AD5629_2},
> -	{"ad5629-3", ID_AD5629_2}, /* similar enough to ad5629-2 */
> -	{"ad5645r-1v25", ID_AD5645R_1V25 },
> -	{"ad5645r-2v5", ID_AD5645R_2V5 },
> -	{"ad5665", ID_AD5665 },
> -	{"ad5665r-1v25", ID_AD5665R_1V25 },
> -	{"ad5665r-2v5", ID_AD5665R_2V5 },
> -	{"ad5667", ID_AD5667 },
> -	{"ad5667r-1v25", ID_AD5667R_1V25 },
> -	{"ad5667r-2v5", ID_AD5667R_2V5 },
> -	{"ad5669-1", ID_AD5669_1},
> -	{"ad5669-2", ID_AD5669_2},
> -	{"ad5669-3", ID_AD5669_2}, /* similar enough to ad5669-2 */
> -	{"ltc2606", ID_LTC2606},
> -	{"ltc2607", ID_LTC2607},
> -	{"ltc2609", ID_LTC2609},
> -	{"ltc2616", ID_LTC2616},
> -	{"ltc2617", ID_LTC2617},
> -	{"ltc2619", ID_LTC2619},
> -	{"ltc2626", ID_LTC2626},
> -	{"ltc2627", ID_LTC2627},
> -	{"ltc2629", ID_LTC2629},
> -	{"ltc2631-l12", ID_LTC2631_L12},
> -	{"ltc2631-h12", ID_LTC2631_H12},
> -	{"ltc2631-l10", ID_LTC2631_L10},
> -	{"ltc2631-h10", ID_LTC2631_H10},
> -	{"ltc2631-l8", ID_LTC2631_L8},
> -	{"ltc2631-h8", ID_LTC2631_H8},
> -	{"ltc2633-l12", ID_LTC2633_L12},
> -	{"ltc2633-h12", ID_LTC2633_H12},
> -	{"ltc2633-l10", ID_LTC2633_L10},
> -	{"ltc2633-h10", ID_LTC2633_H10},
> -	{"ltc2633-l8", ID_LTC2633_L8},
> -	{"ltc2633-h8", ID_LTC2633_H8},
> -	{"ltc2635-l12", ID_LTC2635_L12},
> -	{"ltc2635-h12", ID_LTC2635_H12},
> -	{"ltc2635-l10", ID_LTC2635_L10},
> -	{"ltc2635-h10", ID_LTC2635_H10},
> -	{"ltc2635-l8", ID_LTC2635_L8},
> -	{"ltc2635-h8", ID_LTC2635_H8},
> +	{ .name =3D "ad5625", .driver_data =3D ID_AD5625 },
> +	{ .name =3D "ad5625r-1v25", .driver_data =3D ID_AD5625R_1V25 },
> +	{ .name =3D "ad5625r-2v5", .driver_data =3D ID_AD5625R_2V5 },
> +	{ .name =3D "ad5627", .driver_data =3D ID_AD5627 },
> +	{ .name =3D "ad5627r-1v25", .driver_data =3D ID_AD5627R_1V25 },
> +	{ .name =3D "ad5627r-2v5", .driver_data =3D ID_AD5627R_2V5 },
> +	{ .name =3D "ad5629-1", .driver_data =3D ID_AD5629_1 },
> +	{ .name =3D "ad5629-2", .driver_data =3D ID_AD5629_2 },
> +	{ .name =3D "ad5629-3", .driver_data =3D ID_AD5629_2 }, /* similar enou=
gh to ad5629-2 */
> +	{ .name =3D "ad5645r-1v25", .driver_data =3D ID_AD5645R_1V25 },
> +	{ .name =3D "ad5645r-2v5", .driver_data =3D ID_AD5645R_2V5 },
> +	{ .name =3D "ad5665", .driver_data =3D ID_AD5665 },
> +	{ .name =3D "ad5665r-1v25", .driver_data =3D ID_AD5665R_1V25 },
> +	{ .name =3D "ad5665r-2v5", .driver_data =3D ID_AD5665R_2V5 },
> +	{ .name =3D "ad5667", .driver_data =3D ID_AD5667 },
> +	{ .name =3D "ad5667r-1v25", .driver_data =3D ID_AD5667R_1V25 },
> +	{ .name =3D "ad5667r-2v5", .driver_data =3D ID_AD5667R_2V5 },
> +	{ .name =3D "ad5669-1", .driver_data =3D ID_AD5669_1 },
> +	{ .name =3D "ad5669-2", .driver_data =3D ID_AD5669_2 },
> +	{ .name =3D "ad5669-3", .driver_data =3D ID_AD5669_2 }, /* similar enou=
gh to ad5669-2 */
> +	{ .name =3D "ltc2606", .driver_data =3D ID_LTC2606 },
> +	{ .name =3D "ltc2607", .driver_data =3D ID_LTC2607 },
> +	{ .name =3D "ltc2609", .driver_data =3D ID_LTC2609 },
> +	{ .name =3D "ltc2616", .driver_data =3D ID_LTC2616 },
> +	{ .name =3D "ltc2617", .driver_data =3D ID_LTC2617 },
> +	{ .name =3D "ltc2619", .driver_data =3D ID_LTC2619 },
> +	{ .name =3D "ltc2626", .driver_data =3D ID_LTC2626 },
> +	{ .name =3D "ltc2627", .driver_data =3D ID_LTC2627 },
> +	{ .name =3D "ltc2629", .driver_data =3D ID_LTC2629 },
> +	{ .name =3D "ltc2631-l12", .driver_data =3D ID_LTC2631_L12 },
> +	{ .name =3D "ltc2631-h12", .driver_data =3D ID_LTC2631_H12 },
> +	{ .name =3D "ltc2631-l10", .driver_data =3D ID_LTC2631_L10 },
> +	{ .name =3D "ltc2631-h10", .driver_data =3D ID_LTC2631_H10 },
> +	{ .name =3D "ltc2631-l8", .driver_data =3D ID_LTC2631_L8 },
> +	{ .name =3D "ltc2631-h8", .driver_data =3D ID_LTC2631_H8 },
> +	{ .name =3D "ltc2633-l12", .driver_data =3D ID_LTC2633_L12 },
> +	{ .name =3D "ltc2633-h12", .driver_data =3D ID_LTC2633_H12 },
> +	{ .name =3D "ltc2633-l10", .driver_data =3D ID_LTC2633_L10 },
> +	{ .name =3D "ltc2633-h10", .driver_data =3D ID_LTC2633_H10 },
> +	{ .name =3D "ltc2633-l8", .driver_data =3D ID_LTC2633_L8 },
> +	{ .name =3D "ltc2633-h8", .driver_data =3D ID_LTC2633_H8 },
> +	{ .name =3D "ltc2635-l12", .driver_data =3D ID_LTC2635_L12 },
> +	{ .name =3D "ltc2635-h12", .driver_data =3D ID_LTC2635_H12 },
> +	{ .name =3D "ltc2635-l10", .driver_data =3D ID_LTC2635_L10 },
> +	{ .name =3D "ltc2635-h10", .driver_data =3D ID_LTC2635_H10 },
> +	{ .name =3D "ltc2635-l8", .driver_data =3D ID_LTC2635_L8 },
> +	{ .name =3D "ltc2635-h8", .driver_data =3D ID_LTC2635_H8 },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, ad5064_i2c_ids);
> diff --git a/drivers/iio/dac/ad5380.c b/drivers/iio/dac/ad5380.c
> index 8b813cee7625..2e587bdd3214 100644
> --- a/drivers/iio/dac/ad5380.c
> +++ b/drivers/iio/dac/ad5380.c
> @@ -513,22 +513,22 @@ static int ad5380_i2c_probe(struct i2c_client *i2c)
>  }
> =20
>  static const struct i2c_device_id ad5380_i2c_ids[] =3D {
> -	{ "ad5380-3", ID_AD5380_3 },
> -	{ "ad5380-5", ID_AD5380_5 },
> -	{ "ad5381-3", ID_AD5381_3 },
> -	{ "ad5381-5", ID_AD5381_5 },
> -	{ "ad5382-3", ID_AD5382_3 },
> -	{ "ad5382-5", ID_AD5382_5 },
> -	{ "ad5383-3", ID_AD5383_3 },
> -	{ "ad5383-5", ID_AD5383_5 },
> -	{ "ad5384-3", ID_AD5380_3 },
> -	{ "ad5384-5", ID_AD5380_5 },
> -	{ "ad5390-3", ID_AD5390_3 },
> -	{ "ad5390-5", ID_AD5390_5 },
> -	{ "ad5391-3", ID_AD5391_3 },
> -	{ "ad5391-5", ID_AD5391_5 },
> -	{ "ad5392-3", ID_AD5392_3 },
> -	{ "ad5392-5", ID_AD5392_5 },
> +	{ .name =3D "ad5380-3", .driver_data =3D ID_AD5380_3 },
> +	{ .name =3D "ad5380-5", .driver_data =3D ID_AD5380_5 },
> +	{ .name =3D "ad5381-3", .driver_data =3D ID_AD5381_3 },
> +	{ .name =3D "ad5381-5", .driver_data =3D ID_AD5381_5 },
> +	{ .name =3D "ad5382-3", .driver_data =3D ID_AD5382_3 },
> +	{ .name =3D "ad5382-5", .driver_data =3D ID_AD5382_5 },
> +	{ .name =3D "ad5383-3", .driver_data =3D ID_AD5383_3 },
> +	{ .name =3D "ad5383-5", .driver_data =3D ID_AD5383_5 },
> +	{ .name =3D "ad5384-3", .driver_data =3D ID_AD5380_3 },
> +	{ .name =3D "ad5384-5", .driver_data =3D ID_AD5380_5 },
> +	{ .name =3D "ad5390-3", .driver_data =3D ID_AD5390_3 },
> +	{ .name =3D "ad5390-5", .driver_data =3D ID_AD5390_5 },
> +	{ .name =3D "ad5391-3", .driver_data =3D ID_AD5391_3 },
> +	{ .name =3D "ad5391-5", .driver_data =3D ID_AD5391_5 },
> +	{ .name =3D "ad5392-3", .driver_data =3D ID_AD5392_3 },
> +	{ .name =3D "ad5392-5", .driver_data =3D ID_AD5392_5 },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, ad5380_i2c_ids);
> diff --git a/drivers/iio/dac/ad5446-i2c.c b/drivers/iio/dac/ad5446-i2c.c
> index 40fe7e17fce4..2d4c8908d91e 100644
> --- a/drivers/iio/dac/ad5446-i2c.c
> +++ b/drivers/iio/dac/ad5446-i2c.c
> @@ -65,12 +65,12 @@ static const struct ad5446_chip_info ad5622_chip_info=
 =3D {
>  };
> =20
>  static const struct i2c_device_id ad5446_i2c_ids[] =3D {
> -	{"ad5301", (kernel_ulong_t)&ad5602_chip_info},
> -	{"ad5311", (kernel_ulong_t)&ad5612_chip_info},
> -	{"ad5321", (kernel_ulong_t)&ad5622_chip_info},
> -	{"ad5602", (kernel_ulong_t)&ad5602_chip_info},
> -	{"ad5612", (kernel_ulong_t)&ad5612_chip_info},
> -	{"ad5622", (kernel_ulong_t)&ad5622_chip_info},
> +	{ .name =3D "ad5301", .driver_data =3D (kernel_ulong_t)&ad5602_chip_inf=
o },
> +	{ .name =3D "ad5311", .driver_data =3D (kernel_ulong_t)&ad5612_chip_inf=
o },
> +	{ .name =3D "ad5321", .driver_data =3D (kernel_ulong_t)&ad5622_chip_inf=
o },
> +	{ .name =3D "ad5602", .driver_data =3D (kernel_ulong_t)&ad5602_chip_inf=
o },
> +	{ .name =3D "ad5612", .driver_data =3D (kernel_ulong_t)&ad5612_chip_inf=
o },
> +	{ .name =3D "ad5622", .driver_data =3D (kernel_ulong_t)&ad5622_chip_inf=
o },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, ad5446_i2c_ids);
> diff --git a/drivers/iio/dac/ad5696-i2c.c b/drivers/iio/dac/ad5696-i2c.c
> index d3327bca0e07..56625e1da817 100644
> --- a/drivers/iio/dac/ad5696-i2c.c
> +++ b/drivers/iio/dac/ad5696-i2c.c
> @@ -66,22 +66,22 @@ static int ad5686_i2c_probe(struct i2c_client *i2c)
>  }
> =20
>  static const struct i2c_device_id ad5686_i2c_id[] =3D {
> -	{"ad5311r", ID_AD5311R},
> -	{"ad5337r", ID_AD5337R},
> -	{"ad5338r", ID_AD5338R},
> -	{"ad5671r", ID_AD5671R},
> -	{"ad5673r", ID_AD5673R},
> -	{"ad5675r", ID_AD5675R},
> -	{"ad5677r", ID_AD5677R},
> -	{"ad5691r", ID_AD5691R},
> -	{"ad5692r", ID_AD5692R},
> -	{"ad5693", ID_AD5693},
> -	{"ad5693r", ID_AD5693R},
> -	{"ad5694", ID_AD5694},
> -	{"ad5694r", ID_AD5694R},
> -	{"ad5695r", ID_AD5695R},
> -	{"ad5696", ID_AD5696},
> -	{"ad5696r", ID_AD5696R},
> +	{ .name =3D "ad5311r", .driver_data =3D ID_AD5311R },
> +	{ .name =3D "ad5337r", .driver_data =3D ID_AD5337R },
> +	{ .name =3D "ad5338r", .driver_data =3D ID_AD5338R },
> +	{ .name =3D "ad5671r", .driver_data =3D ID_AD5671R },
> +	{ .name =3D "ad5673r", .driver_data =3D ID_AD5673R },
> +	{ .name =3D "ad5675r", .driver_data =3D ID_AD5675R },
> +	{ .name =3D "ad5677r", .driver_data =3D ID_AD5677R },
> +	{ .name =3D "ad5691r", .driver_data =3D ID_AD5691R },
> +	{ .name =3D "ad5692r", .driver_data =3D ID_AD5692R },
> +	{ .name =3D "ad5693", .driver_data =3D ID_AD5693 },
> +	{ .name =3D "ad5693r", .driver_data =3D ID_AD5693R },
> +	{ .name =3D "ad5694", .driver_data =3D ID_AD5694 },
> +	{ .name =3D "ad5694r", .driver_data =3D ID_AD5694R },
> +	{ .name =3D "ad5695r", .driver_data =3D ID_AD5695R },
> +	{ .name =3D "ad5696", .driver_data =3D ID_AD5696 },
> +	{ .name =3D "ad5696r", .driver_data =3D ID_AD5696R },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, ad5686_i2c_id);
> diff --git a/drivers/iio/dac/ds4424.c b/drivers/iio/dac/ds4424.c
> index 085f73de3f02..b6430b832cf0 100644
> --- a/drivers/iio/dac/ds4424.c
> +++ b/drivers/iio/dac/ds4424.c
> @@ -401,10 +401,10 @@ static void ds4424_remove(struct i2c_client *client)
>  }
> =20
>  static const struct i2c_device_id ds4424_id[] =3D {
> -	{ "ds4402", (kernel_ulong_t)&ds4402_info },
> -	{ "ds4404", (kernel_ulong_t)&ds4404_info },
> -	{ "ds4422", (kernel_ulong_t)&ds4422_info },
> -	{ "ds4424", (kernel_ulong_t)&ds4424_info },
> +	{ .name =3D "ds4402", .driver_data =3D (kernel_ulong_t)&ds4402_info },
> +	{ .name =3D "ds4404", .driver_data =3D (kernel_ulong_t)&ds4404_info },
> +	{ .name =3D "ds4422", .driver_data =3D (kernel_ulong_t)&ds4422_info },
> +	{ .name =3D "ds4424", .driver_data =3D (kernel_ulong_t)&ds4424_info },
>  	{ }
>  };
> =20
> diff --git a/drivers/iio/dac/m62332.c b/drivers/iio/dac/m62332.c
> index 3497513854d7..7e80c0eb5cc1 100644
> --- a/drivers/iio/dac/m62332.c
> +++ b/drivers/iio/dac/m62332.c
> @@ -228,7 +228,7 @@ static void m62332_remove(struct i2c_client *client)
>  }
> =20
>  static const struct i2c_device_id m62332_id[] =3D {
> -	{ "m62332", },
> +	{ .name =3D "m62332" },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, m62332_id);
> diff --git a/drivers/iio/dac/max517.c b/drivers/iio/dac/max517.c
> index d334c67821ad..d2ddc72e0e50 100644
> --- a/drivers/iio/dac/max517.c
> +++ b/drivers/iio/dac/max517.c
> @@ -187,11 +187,11 @@ static int max517_probe(struct i2c_client *client)
>  }
> =20
>  static const struct i2c_device_id max517_id[] =3D {
> -	{ "max517", ID_MAX517 },
> -	{ "max518", ID_MAX518 },
> -	{ "max519", ID_MAX519 },
> -	{ "max520", ID_MAX520 },
> -	{ "max521", ID_MAX521 },
> +	{ .name =3D "max517", .driver_data =3D ID_MAX517 },
> +	{ .name =3D "max518", .driver_data =3D ID_MAX518 },
> +	{ .name =3D "max519", .driver_data =3D ID_MAX519 },
> +	{ .name =3D "max520", .driver_data =3D ID_MAX520 },
> +	{ .name =3D "max521", .driver_data =3D ID_MAX521 },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, max517_id);
> diff --git a/drivers/iio/dac/mcp4725.c b/drivers/iio/dac/mcp4725.c
> index 23b9e3a09ec8..2d6bcfd5deaa 100644
> --- a/drivers/iio/dac/mcp4725.c
> +++ b/drivers/iio/dac/mcp4725.c
> @@ -523,8 +523,8 @@ static const struct mcp4725_chip_info mcp4726 =3D {
>  };
> =20
>  static const struct i2c_device_id mcp4725_id[] =3D {
> -	{ "mcp4725", (kernel_ulong_t)&mcp4725 },
> -	{ "mcp4726", (kernel_ulong_t)&mcp4726 },
> +	{ .name =3D "mcp4725", .driver_data =3D (kernel_ulong_t)&mcp4725 },
> +	{ .name =3D "mcp4726", .driver_data =3D (kernel_ulong_t)&mcp4726 },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, mcp4725_id);
> diff --git a/drivers/iio/dac/mcp4728.c b/drivers/iio/dac/mcp4728.c
> index 4f30b99110b7..64bd9490fc19 100644
> --- a/drivers/iio/dac/mcp4728.c
> +++ b/drivers/iio/dac/mcp4728.c
> @@ -572,7 +572,7 @@ static int mcp4728_probe(struct i2c_client *client)
>  }
> =20
>  static const struct i2c_device_id mcp4728_id[] =3D {
> -	{ "mcp4728" },
> +	{ .name =3D "mcp4728" },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, mcp4728_id);
> diff --git a/drivers/iio/dac/mcp47feb02.c b/drivers/iio/dac/mcp47feb02.c
> index faccb804a5ed..217f78e44af1 100644
> --- a/drivers/iio/dac/mcp47feb02.c
> +++ b/drivers/iio/dac/mcp47feb02.c
> @@ -1170,30 +1170,30 @@ static int mcp47feb02_probe(struct i2c_client *cl=
ient)
>  }
> =20
>  static const struct i2c_device_id mcp47feb02_id[] =3D {
> -	{ "mcp47feb01", (kernel_ulong_t)&mcp47feb01_chip_features },
> -	{ "mcp47feb02", (kernel_ulong_t)&mcp47feb02_chip_features },
> -	{ "mcp47feb04", (kernel_ulong_t)&mcp47feb04_chip_features },
> -	{ "mcp47feb08", (kernel_ulong_t)&mcp47feb08_chip_features },
> -	{ "mcp47feb11", (kernel_ulong_t)&mcp47feb11_chip_features },
> -	{ "mcp47feb12", (kernel_ulong_t)&mcp47feb12_chip_features },
> -	{ "mcp47feb14", (kernel_ulong_t)&mcp47feb14_chip_features },
> -	{ "mcp47feb18", (kernel_ulong_t)&mcp47feb18_chip_features },
> -	{ "mcp47feb21", (kernel_ulong_t)&mcp47feb21_chip_features },
> -	{ "mcp47feb22", (kernel_ulong_t)&mcp47feb22_chip_features },
> -	{ "mcp47feb24", (kernel_ulong_t)&mcp47feb24_chip_features },
> -	{ "mcp47feb28", (kernel_ulong_t)&mcp47feb28_chip_features },
> -	{ "mcp47fvb01", (kernel_ulong_t)&mcp47fvb01_chip_features },
> -	{ "mcp47fvb02", (kernel_ulong_t)&mcp47fvb02_chip_features },
> -	{ "mcp47fvb04", (kernel_ulong_t)&mcp47fvb04_chip_features },
> -	{ "mcp47fvb08", (kernel_ulong_t)&mcp47fvb08_chip_features },
> -	{ "mcp47fvb11", (kernel_ulong_t)&mcp47fvb11_chip_features },
> -	{ "mcp47fvb12", (kernel_ulong_t)&mcp47fvb12_chip_features },
> -	{ "mcp47fvb14", (kernel_ulong_t)&mcp47fvb14_chip_features },
> -	{ "mcp47fvb18", (kernel_ulong_t)&mcp47fvb18_chip_features },
> -	{ "mcp47fvb21", (kernel_ulong_t)&mcp47fvb21_chip_features },
> -	{ "mcp47fvb22", (kernel_ulong_t)&mcp47fvb22_chip_features },
> -	{ "mcp47fvb24", (kernel_ulong_t)&mcp47fvb24_chip_features },
> -	{ "mcp47fvb28", (kernel_ulong_t)&mcp47fvb28_chip_features },
> +	{ .name =3D "mcp47feb01", .driver_data =3D (kernel_ulong_t)&mcp47feb01_=
chip_features },
> +	{ .name =3D "mcp47feb02", .driver_data =3D (kernel_ulong_t)&mcp47feb02_=
chip_features },
> +	{ .name =3D "mcp47feb04", .driver_data =3D (kernel_ulong_t)&mcp47feb04_=
chip_features },
> +	{ .name =3D "mcp47feb08", .driver_data =3D (kernel_ulong_t)&mcp47feb08_=
chip_features },
> +	{ .name =3D "mcp47feb11", .driver_data =3D (kernel_ulong_t)&mcp47feb11_=
chip_features },
> +	{ .name =3D "mcp47feb12", .driver_data =3D (kernel_ulong_t)&mcp47feb12_=
chip_features },
> +	{ .name =3D "mcp47feb14", .driver_data =3D (kernel_ulong_t)&mcp47feb14_=
chip_features },
> +	{ .name =3D "mcp47feb18", .driver_data =3D (kernel_ulong_t)&mcp47feb18_=
chip_features },
> +	{ .name =3D "mcp47feb21", .driver_data =3D (kernel_ulong_t)&mcp47feb21_=
chip_features },
> +	{ .name =3D "mcp47feb22", .driver_data =3D (kernel_ulong_t)&mcp47feb22_=
chip_features },
> +	{ .name =3D "mcp47feb24", .driver_data =3D (kernel_ulong_t)&mcp47feb24_=
chip_features },
> +	{ .name =3D "mcp47feb28", .driver_data =3D (kernel_ulong_t)&mcp47feb28_=
chip_features },
> +	{ .name =3D "mcp47fvb01", .driver_data =3D (kernel_ulong_t)&mcp47fvb01_=
chip_features },
> +	{ .name =3D "mcp47fvb02", .driver_data =3D (kernel_ulong_t)&mcp47fvb02_=
chip_features },
> +	{ .name =3D "mcp47fvb04", .driver_data =3D (kernel_ulong_t)&mcp47fvb04_=
chip_features },
> +	{ .name =3D "mcp47fvb08", .driver_data =3D (kernel_ulong_t)&mcp47fvb08_=
chip_features },
> +	{ .name =3D "mcp47fvb11", .driver_data =3D (kernel_ulong_t)&mcp47fvb11_=
chip_features },
> +	{ .name =3D "mcp47fvb12", .driver_data =3D (kernel_ulong_t)&mcp47fvb12_=
chip_features },
> +	{ .name =3D "mcp47fvb14", .driver_data =3D (kernel_ulong_t)&mcp47fvb14_=
chip_features },
> +	{ .name =3D "mcp47fvb18", .driver_data =3D (kernel_ulong_t)&mcp47fvb18_=
chip_features },
> +	{ .name =3D "mcp47fvb21", .driver_data =3D (kernel_ulong_t)&mcp47fvb21_=
chip_features },
> +	{ .name =3D "mcp47fvb22", .driver_data =3D (kernel_ulong_t)&mcp47fvb22_=
chip_features },
> +	{ .name =3D "mcp47fvb24", .driver_data =3D (kernel_ulong_t)&mcp47fvb24_=
chip_features },
> +	{ .name =3D "mcp47fvb28", .driver_data =3D (kernel_ulong_t)&mcp47fvb28_=
chip_features },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, mcp47feb02_id);
> diff --git a/drivers/iio/dac/ti-dac5571.c b/drivers/iio/dac/ti-dac5571.c
> index 455d61fc3f13..b9efd704e996 100644
> --- a/drivers/iio/dac/ti-dac5571.c
> +++ b/drivers/iio/dac/ti-dac5571.c
> @@ -402,17 +402,17 @@ static const struct of_device_id dac5571_of_id[] =
=3D {
>  MODULE_DEVICE_TABLE(of, dac5571_of_id);
> =20
>  static const struct i2c_device_id dac5571_id[] =3D {
> -	{"dac081c081", (kernel_ulong_t)&dac5571_spec[single_8bit] },
> -	{"dac121c081", (kernel_ulong_t)&dac5571_spec[single_12bit] },
> -	{"dac5571", (kernel_ulong_t)&dac5571_spec[single_8bit] },
> -	{"dac6571", (kernel_ulong_t)&dac5571_spec[single_10bit] },
> -	{"dac7571", (kernel_ulong_t)&dac5571_spec[single_12bit] },
> -	{"dac5574", (kernel_ulong_t)&dac5571_spec[quad_8bit] },
> -	{"dac6574", (kernel_ulong_t)&dac5571_spec[quad_10bit] },
> -	{"dac7574", (kernel_ulong_t)&dac5571_spec[quad_12bit] },
> -	{"dac5573", (kernel_ulong_t)&dac5571_spec[quad_8bit] },
> -	{"dac6573", (kernel_ulong_t)&dac5571_spec[quad_10bit] },
> -	{"dac7573", (kernel_ulong_t)&dac5571_spec[quad_12bit] },
> +	{ .name =3D "dac081c081", .driver_data =3D (kernel_ulong_t)&dac5571_spe=
c[single_8bit] },
> +	{ .name =3D "dac121c081", .driver_data =3D (kernel_ulong_t)&dac5571_spe=
c[single_12bit] },
> +	{ .name =3D "dac5571", .driver_data =3D (kernel_ulong_t)&dac5571_spec[s=
ingle_8bit] },
> +	{ .name =3D "dac6571", .driver_data =3D (kernel_ulong_t)&dac5571_spec[s=
ingle_10bit] },
> +	{ .name =3D "dac7571", .driver_data =3D (kernel_ulong_t)&dac5571_spec[s=
ingle_12bit] },
> +	{ .name =3D "dac5574", .driver_data =3D (kernel_ulong_t)&dac5571_spec[q=
uad_8bit] },
> +	{ .name =3D "dac6574", .driver_data =3D (kernel_ulong_t)&dac5571_spec[q=
uad_10bit] },
> +	{ .name =3D "dac7574", .driver_data =3D (kernel_ulong_t)&dac5571_spec[q=
uad_12bit] },
> +	{ .name =3D "dac5573", .driver_data =3D (kernel_ulong_t)&dac5571_spec[q=
uad_8bit] },
> +	{ .name =3D "dac6573", .driver_data =3D (kernel_ulong_t)&dac5571_spec[q=
uad_10bit] },
> +	{ .name =3D "dac7573", .driver_data =3D (kernel_ulong_t)&dac5571_spec[q=
uad_12bit] },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, dac5571_id);
> diff --git a/drivers/iio/gyro/bmg160_i2c.c b/drivers/iio/gyro/bmg160_i2c.c
> index 1fb8a7969c25..028e5e29c6a1 100644
> --- a/drivers/iio/gyro/bmg160_i2c.c
> +++ b/drivers/iio/gyro/bmg160_i2c.c
> @@ -47,9 +47,9 @@ static const struct acpi_device_id bmg160_acpi_match[] =
=3D {
>  MODULE_DEVICE_TABLE(acpi, bmg160_acpi_match);
> =20
>  static const struct i2c_device_id bmg160_i2c_id[] =3D {
> -	{ "bmg160" },
> -	{ "bmi055_gyro" },
> -	{ "bmi088_gyro" },
> +	{ .name =3D "bmg160" },
> +	{ .name =3D "bmi055_gyro" },
> +	{ .name =3D "bmi088_gyro" },
>  	{ }
>  };
> =20
> diff --git a/drivers/iio/gyro/fxas21002c_i2c.c b/drivers/iio/gyro/fxas210=
02c_i2c.c
> index 43c6b3079487..d537e91caaaf 100644
> --- a/drivers/iio/gyro/fxas21002c_i2c.c
> +++ b/drivers/iio/gyro/fxas21002c_i2c.c
> @@ -39,7 +39,7 @@ static void fxas21002c_i2c_remove(struct i2c_client *i2=
c)
>  }
> =20
>  static const struct i2c_device_id fxas21002c_i2c_id[] =3D {
> -	{ "fxas21002c" },
> +	{ .name =3D "fxas21002c" },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, fxas21002c_i2c_id);
> diff --git a/drivers/iio/gyro/itg3200_core.c b/drivers/iio/gyro/itg3200_c=
ore.c
> index bfe95ec1abda..6b13d54d9b01 100644
> --- a/drivers/iio/gyro/itg3200_core.c
> +++ b/drivers/iio/gyro/itg3200_core.c
> @@ -389,7 +389,7 @@ static DEFINE_SIMPLE_DEV_PM_OPS(itg3200_pm_ops, itg32=
00_suspend,
>  				itg3200_resume);
> =20
>  static const struct i2c_device_id itg3200_id[] =3D {
> -	{ "itg3200" },
> +	{ .name =3D "itg3200" },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, itg3200_id);
> diff --git a/drivers/iio/gyro/mpu3050-i2c.c b/drivers/iio/gyro/mpu3050-i2=
c.c
> index 6549b22e643d..2a5bcec7272c 100644
> --- a/drivers/iio/gyro/mpu3050-i2c.c
> +++ b/drivers/iio/gyro/mpu3050-i2c.c
> @@ -92,7 +92,7 @@ static void mpu3050_i2c_remove(struct i2c_client *clien=
t)
>   * supported by this driver
>   */
>  static const struct i2c_device_id mpu3050_i2c_id[] =3D {
> -	{ "mpu3050" },
> +	{ .name =3D "mpu3050" },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, mpu3050_i2c_id);
> diff --git a/drivers/iio/gyro/st_gyro_i2c.c b/drivers/iio/gyro/st_gyro_i2=
c.c
> index aef5ec8f9dee..b07cb39051b3 100644
> --- a/drivers/iio/gyro/st_gyro_i2c.c
> +++ b/drivers/iio/gyro/st_gyro_i2c.c
> @@ -93,15 +93,15 @@ static int st_gyro_i2c_probe(struct i2c_client *clien=
t)
>  }
> =20
>  static const struct i2c_device_id st_gyro_id_table[] =3D {
> -	{ L3G4200D_GYRO_DEV_NAME },
> -	{ LSM330D_GYRO_DEV_NAME },
> -	{ LSM330DL_GYRO_DEV_NAME },
> -	{ LSM330DLC_GYRO_DEV_NAME },
> -	{ L3GD20_GYRO_DEV_NAME },
> -	{ L3GD20H_GYRO_DEV_NAME },
> -	{ L3G4IS_GYRO_DEV_NAME },
> -	{ LSM330_GYRO_DEV_NAME },
> -	{ LSM9DS0_GYRO_DEV_NAME },
> +	{ .name =3D L3G4200D_GYRO_DEV_NAME },
> +	{ .name =3D LSM330D_GYRO_DEV_NAME },
> +	{ .name =3D LSM330DL_GYRO_DEV_NAME },
> +	{ .name =3D LSM330DLC_GYRO_DEV_NAME },
> +	{ .name =3D L3GD20_GYRO_DEV_NAME },
> +	{ .name =3D L3GD20H_GYRO_DEV_NAME },
> +	{ .name =3D L3G4IS_GYRO_DEV_NAME },
> +	{ .name =3D LSM330_GYRO_DEV_NAME },
> +	{ .name =3D LSM9DS0_GYRO_DEV_NAME },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, st_gyro_id_table);
> diff --git a/drivers/iio/health/afe4404.c b/drivers/iio/health/afe4404.c
> index 032da52a96d0..2357e2dd7017 100644
> --- a/drivers/iio/health/afe4404.c
> +++ b/drivers/iio/health/afe4404.c
> @@ -575,7 +575,7 @@ static int afe4404_probe(struct i2c_client *client)
>  }
> =20
>  static const struct i2c_device_id afe4404_ids[] =3D {
> -	{ "afe4404" },
> +	{ .name =3D "afe4404" },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, afe4404_ids);
> diff --git a/drivers/iio/health/max30100.c b/drivers/iio/health/max30100.c
> index 7dfdb5eb305e..97352485f5e2 100644
> --- a/drivers/iio/health/max30100.c
> +++ b/drivers/iio/health/max30100.c
> @@ -507,7 +507,7 @@ static void max30100_remove(struct i2c_client *client)
>  }
> =20
>  static const struct i2c_device_id max30100_id[] =3D {
> -	{ "max30100" },
> +	{ .name =3D "max30100" },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, max30100_id);
> diff --git a/drivers/iio/health/max30102.c b/drivers/iio/health/max30102.c
> index 47da44efd68b..c830eaf286f7 100644
> --- a/drivers/iio/health/max30102.c
> +++ b/drivers/iio/health/max30102.c
> @@ -596,9 +596,9 @@ static void max30102_remove(struct i2c_client *client)
>  }
> =20
>  static const struct i2c_device_id max30102_id[] =3D {
> -	{ "max30101", max30105 },
> -	{ "max30102", max30102 },
> -	{ "max30105", max30105 },
> +	{ .name =3D "max30101", .driver_data =3D max30105 },
> +	{ .name =3D "max30102", .driver_data =3D max30102 },
> +	{ .name =3D "max30105", .driver_data =3D max30105 },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, max30102_id);
> diff --git a/drivers/iio/humidity/am2315.c b/drivers/iio/humidity/am2315.c
> index 02ca23eb8991..f29baa251f9f 100644
> --- a/drivers/iio/humidity/am2315.c
> +++ b/drivers/iio/humidity/am2315.c
> @@ -250,7 +250,7 @@ static int am2315_probe(struct i2c_client *client)
>  }
> =20
>  static const struct i2c_device_id am2315_i2c_id[] =3D {
> -	{ "am2315" },
> +	{ .name =3D "am2315" },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, am2315_i2c_id);
> diff --git a/drivers/iio/humidity/ens210.c b/drivers/iio/humidity/ens210.c
> index 77418d97f30d..22ad208e6aa6 100644
> --- a/drivers/iio/humidity/ens210.c
> +++ b/drivers/iio/humidity/ens210.c
> @@ -314,12 +314,12 @@ static const struct of_device_id ens210_of_match[] =
=3D {
>  MODULE_DEVICE_TABLE(of, ens210_of_match);
> =20
>  static const struct i2c_device_id ens210_id_table[] =3D {
> -	{ "ens210", (kernel_ulong_t)&ens210_chip_info_data },
> -	{ "ens210a", (kernel_ulong_t)&ens210a_chip_info_data },
> -	{ "ens211", (kernel_ulong_t)&ens211_chip_info_data },
> -	{ "ens212", (kernel_ulong_t)&ens212_chip_info_data },
> -	{ "ens213a", (kernel_ulong_t)&ens213a_chip_info_data },
> -	{ "ens215", (kernel_ulong_t)&ens215_chip_info_data },
> +	{ .name =3D "ens210", .driver_data =3D (kernel_ulong_t)&ens210_chip_inf=
o_data },
> +	{ .name =3D "ens210a", .driver_data =3D (kernel_ulong_t)&ens210a_chip_i=
nfo_data },
> +	{ .name =3D "ens211", .driver_data =3D (kernel_ulong_t)&ens211_chip_inf=
o_data },
> +	{ .name =3D "ens212", .driver_data =3D (kernel_ulong_t)&ens212_chip_inf=
o_data },
> +	{ .name =3D "ens213a", .driver_data =3D (kernel_ulong_t)&ens213a_chip_i=
nfo_data },
> +	{ .name =3D "ens215", .driver_data =3D (kernel_ulong_t)&ens215_chip_inf=
o_data },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, ens210_id_table);
> diff --git a/drivers/iio/humidity/hdc100x.c b/drivers/iio/humidity/hdc100=
x.c
> index c2b36e682e06..87194802cc4f 100644
> --- a/drivers/iio/humidity/hdc100x.c
> +++ b/drivers/iio/humidity/hdc100x.c
> @@ -380,12 +380,12 @@ static int hdc100x_probe(struct i2c_client *client)
>  }
> =20
>  static const struct i2c_device_id hdc100x_id[] =3D {
> -	{ "hdc100x" },
> -	{ "hdc1000" },
> -	{ "hdc1008" },
> -	{ "hdc1010" },
> -	{ "hdc1050" },
> -	{ "hdc1080" },
> +	{ .name =3D "hdc100x" },
> +	{ .name =3D "hdc1000" },
> +	{ .name =3D "hdc1008" },
> +	{ .name =3D "hdc1010" },
> +	{ .name =3D "hdc1050" },
> +	{ .name =3D "hdc1080" },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, hdc100x_id);
> diff --git a/drivers/iio/humidity/hdc2010.c b/drivers/iio/humidity/hdc201=
0.c
> index 1a0f18251381..82d68987556d 100644
> --- a/drivers/iio/humidity/hdc2010.c
> +++ b/drivers/iio/humidity/hdc2010.c
> @@ -317,8 +317,8 @@ static void hdc2010_remove(struct i2c_client *client)
>  }
> =20
>  static const struct i2c_device_id hdc2010_id[] =3D {
> -	{ "hdc2010" },
> -	{ "hdc2080" },
> +	{ .name =3D "hdc2010" },
> +	{ .name =3D "hdc2080" },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, hdc2010_id);
> diff --git a/drivers/iio/humidity/hdc3020.c b/drivers/iio/humidity/hdc302=
0.c
> index 78b2c171c8da..1ae8702ada54 100644
> --- a/drivers/iio/humidity/hdc3020.c
> +++ b/drivers/iio/humidity/hdc3020.c
> @@ -873,9 +873,9 @@ static int hdc3020_resume(struct device *dev)
>  static DEFINE_SIMPLE_DEV_PM_OPS(hdc3020_pm_ops, hdc3020_suspend, hdc3020=
_resume);
> =20
>  static const struct i2c_device_id hdc3020_id[] =3D {
> -	{ "hdc3020" },
> -	{ "hdc3021" },
> -	{ "hdc3022" },
> +	{ .name =3D "hdc3020" },
> +	{ .name =3D "hdc3021" },
> +	{ .name =3D "hdc3022" },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, hdc3020_id);
> diff --git a/drivers/iio/humidity/hts221_i2c.c b/drivers/iio/humidity/hts=
221_i2c.c
> index cbaa7d1af6c4..e823d37384d7 100644
> --- a/drivers/iio/humidity/hts221_i2c.c
> +++ b/drivers/iio/humidity/hts221_i2c.c
> @@ -53,7 +53,7 @@ static const struct of_device_id hts221_i2c_of_match[] =
=3D {
>  MODULE_DEVICE_TABLE(of, hts221_i2c_of_match);
> =20
>  static const struct i2c_device_id hts221_i2c_id_table[] =3D {
> -	{ HTS221_DEV_NAME },
> +	{ .name =3D HTS221_DEV_NAME },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, hts221_i2c_id_table);
> diff --git a/drivers/iio/humidity/htu21.c b/drivers/iio/humidity/htu21.c
> index 7f1775bd26fd..9ba7507f105e 100644
> --- a/drivers/iio/humidity/htu21.c
> +++ b/drivers/iio/humidity/htu21.c
> @@ -230,8 +230,8 @@ static int htu21_probe(struct i2c_client *client)
>  }
> =20
>  static const struct i2c_device_id htu21_id[] =3D {
> -	{"htu21", HTU21},
> -	{"ms8607-humidity", MS8607},
> +	{ .name =3D "htu21", .driver_data =3D HTU21 },
> +	{ .name =3D "ms8607-humidity", .driver_data =3D MS8607 },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, htu21_id);
> diff --git a/drivers/iio/humidity/si7005.c b/drivers/iio/humidity/si7005.c
> index 0797ece1fcba..0c11d0d3afe0 100644
> --- a/drivers/iio/humidity/si7005.c
> +++ b/drivers/iio/humidity/si7005.c
> @@ -163,8 +163,8 @@ static int si7005_probe(struct i2c_client *client)
>  }
> =20
>  static const struct i2c_device_id si7005_id[] =3D {
> -	{ "si7005" },
> -	{ "th02" },
> +	{ .name =3D "si7005" },
> +	{ .name =3D "th02" },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, si7005_id);
> diff --git a/drivers/iio/humidity/si7020.c b/drivers/iio/humidity/si7020.c
> index ff2dba50c0a5..9fb1e3ede3ff 100644
> --- a/drivers/iio/humidity/si7020.c
> +++ b/drivers/iio/humidity/si7020.c
> @@ -267,8 +267,8 @@ static int si7020_probe(struct i2c_client *client)
>  }
> =20
>  static const struct i2c_device_id si7020_id[] =3D {
> -	{ "si7020" },
> -	{ "th06" },
> +	{ .name =3D "si7020" },
> +	{ .name =3D "th06" },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, si7020_id);
> diff --git a/drivers/iio/imu/bmi160/bmi160_i2c.c b/drivers/iio/imu/bmi160=
/bmi160_i2c.c
> index 3e2758f4e0d3..29f3c4acb123 100644
> --- a/drivers/iio/imu/bmi160/bmi160_i2c.c
> +++ b/drivers/iio/imu/bmi160/bmi160_i2c.c
> @@ -38,8 +38,8 @@ static int bmi160_i2c_probe(struct i2c_client *client)
>  }
> =20
>  static const struct i2c_device_id bmi160_i2c_id[] =3D {
> -	{ "bmi120" },
> -	{ "bmi160" },
> +	{ .name =3D "bmi120" },
> +	{ .name =3D "bmi160" },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, bmi160_i2c_id);
> diff --git a/drivers/iio/imu/bmi270/bmi270_i2c.c b/drivers/iio/imu/bmi270=
/bmi270_i2c.c
> index b92da4e0776f..1e6839f9669e 100644
> --- a/drivers/iio/imu/bmi270/bmi270_i2c.c
> +++ b/drivers/iio/imu/bmi270/bmi270_i2c.c
> @@ -33,8 +33,8 @@ static int bmi270_i2c_probe(struct i2c_client *client)
>  }
> =20
>  static const struct i2c_device_id bmi270_i2c_id[] =3D {
> -	{ "bmi260", (kernel_ulong_t)&bmi260_chip_info },
> -	{ "bmi270", (kernel_ulong_t)&bmi270_chip_info },
> +	{ .name =3D "bmi260", .driver_data =3D (kernel_ulong_t)&bmi260_chip_inf=
o },
> +	{ .name =3D "bmi270", .driver_data =3D (kernel_ulong_t)&bmi270_chip_inf=
o },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, bmi270_i2c_id);
> diff --git a/drivers/iio/imu/bmi323/bmi323_i2c.c b/drivers/iio/imu/bmi323=
/bmi323_i2c.c
> index 8457fe304db8..328733ddeed7 100644
> --- a/drivers/iio/imu/bmi323/bmi323_i2c.c
> +++ b/drivers/iio/imu/bmi323/bmi323_i2c.c
> @@ -114,7 +114,7 @@ static const struct acpi_device_id bmi323_acpi_match[=
] =3D {
>  MODULE_DEVICE_TABLE(acpi, bmi323_acpi_match);
> =20
>  static const struct i2c_device_id bmi323_i2c_ids[] =3D {
> -	{ "bmi323" },
> +	{ .name =3D "bmi323" },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, bmi323_i2c_ids);
> diff --git a/drivers/iio/imu/bno055/bno055_i2c.c b/drivers/iio/imu/bno055=
/bno055_i2c.c
> index f49d0905ee33..000bc9392480 100644
> --- a/drivers/iio/imu/bno055/bno055_i2c.c
> +++ b/drivers/iio/imu/bno055/bno055_i2c.c
> @@ -30,7 +30,7 @@ static int bno055_i2c_probe(struct i2c_client *client)
>  }
> =20
>  static const struct i2c_device_id bno055_i2c_id[] =3D {
> -	{ "bno055" },
> +	{ .name =3D "bno055" },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, bno055_i2c_id);
> diff --git a/drivers/iio/imu/fxos8700_i2c.c b/drivers/iio/imu/fxos8700_i2=
c.c
> index 2cc4a27a4527..c81e48c9d8e2 100644
> --- a/drivers/iio/imu/fxos8700_i2c.c
> +++ b/drivers/iio/imu/fxos8700_i2c.c
> @@ -36,7 +36,7 @@ static int fxos8700_i2c_probe(struct i2c_client *client)
>  }
> =20
>  static const struct i2c_device_id fxos8700_i2c_id[] =3D {
> -	{ "fxos8700" },
> +	{ .name =3D "fxos8700" },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, fxos8700_i2c_id);
> diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c b/drivers/ii=
o/imu/inv_icm42600/inv_icm42600_i2c.c
> index 7e4d3ea68721..99d37ac53bbe 100644
> --- a/drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c
> +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c
> @@ -75,13 +75,13 @@ static int inv_icm42600_probe(struct i2c_client *clie=
nt)
>   * supported by this driver
>   */
>  static const struct i2c_device_id inv_icm42600_id[] =3D {
> -	{ "icm42600", INV_CHIP_ICM42600 },
> -	{ "icm42602", INV_CHIP_ICM42602 },
> -	{ "icm42605", INV_CHIP_ICM42605 },
> -	{ "icm42686", INV_CHIP_ICM42686 },
> -	{ "icm42622", INV_CHIP_ICM42622 },
> -	{ "icm42688", INV_CHIP_ICM42688 },
> -	{ "icm42631", INV_CHIP_ICM42631 },
> +	{ .name =3D "icm42600", .driver_data =3D INV_CHIP_ICM42600 },
> +	{ .name =3D "icm42602", .driver_data =3D INV_CHIP_ICM42602 },
> +	{ .name =3D "icm42605", .driver_data =3D INV_CHIP_ICM42605 },
> +	{ .name =3D "icm42686", .driver_data =3D INV_CHIP_ICM42686 },
> +	{ .name =3D "icm42622", .driver_data =3D INV_CHIP_ICM42622 },
> +	{ .name =3D "icm42688", .driver_data =3D INV_CHIP_ICM42688 },
> +	{ .name =3D "icm42631", .driver_data =3D INV_CHIP_ICM42631 },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, inv_icm42600_id);
> diff --git a/drivers/iio/imu/inv_icm45600/inv_icm45600_i2c.c b/drivers/ii=
o/imu/inv_icm45600/inv_icm45600_i2c.c
> index 5ebc18121a11..26fba538a3cf 100644
> --- a/drivers/iio/imu/inv_icm45600/inv_icm45600_i2c.c
> +++ b/drivers/iio/imu/inv_icm45600/inv_icm45600_i2c.c
> @@ -39,14 +39,14 @@ static int inv_icm45600_probe(struct i2c_client *clie=
nt)
>   * supported by this driver.
>   */
>  static const struct i2c_device_id inv_icm45600_id[] =3D {
> -	{ "icm45605", (kernel_ulong_t)&inv_icm45605_chip_info },
> -	{ "icm45606", (kernel_ulong_t)&inv_icm45606_chip_info },
> -	{ "icm45608", (kernel_ulong_t)&inv_icm45608_chip_info },
> -	{ "icm45634", (kernel_ulong_t)&inv_icm45634_chip_info },
> -	{ "icm45686", (kernel_ulong_t)&inv_icm45686_chip_info },
> -	{ "icm45687", (kernel_ulong_t)&inv_icm45687_chip_info },
> -	{ "icm45688p", (kernel_ulong_t)&inv_icm45688p_chip_info },
> -	{ "icm45689", (kernel_ulong_t)&inv_icm45689_chip_info },
> +	{ .name =3D "icm45605", .driver_data =3D (kernel_ulong_t)&inv_icm45605_=
chip_info },
> +	{ .name =3D "icm45606", .driver_data =3D (kernel_ulong_t)&inv_icm45606_=
chip_info },
> +	{ .name =3D "icm45608", .driver_data =3D (kernel_ulong_t)&inv_icm45608_=
chip_info },
> +	{ .name =3D "icm45634", .driver_data =3D (kernel_ulong_t)&inv_icm45634_=
chip_info },
> +	{ .name =3D "icm45686", .driver_data =3D (kernel_ulong_t)&inv_icm45686_=
chip_info },
> +	{ .name =3D "icm45687", .driver_data =3D (kernel_ulong_t)&inv_icm45687_=
chip_info },
> +	{ .name =3D "icm45688p", .driver_data =3D (kernel_ulong_t)&inv_icm45688=
p_chip_info },
> +	{ .name =3D "icm45689", .driver_data =3D (kernel_ulong_t)&inv_icm45689_=
chip_info },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, inv_icm45600_id);
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c b/drivers/iio/imu/=
inv_mpu6050/inv_mpu_i2c.c
> index 8dc61812a8fc..4868e1576cee 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
> @@ -174,24 +174,24 @@ static void inv_mpu_remove(struct i2c_client *clien=
t)
>   * supported by this driver
>   */
>  static const struct i2c_device_id inv_mpu_id[] =3D {
> -	{"mpu6050", INV_MPU6050},
> -	{"mpu6500", INV_MPU6500},
> -	{"mpu6515", INV_MPU6515},
> -	{"mpu6880", INV_MPU6880},
> -	{"mpu9150", INV_MPU9150},
> -	{"mpu9250", INV_MPU9250},
> -	{"mpu9255", INV_MPU9255},
> -	{"icm20608", INV_ICM20608},
> -	{"icm20608d", INV_ICM20608D},
> -	{"icm20609", INV_ICM20609},
> -	{"icm20689", INV_ICM20689},
> -	{"icm20600", INV_ICM20600},
> -	{"icm20602", INV_ICM20602},
> -	{"icm20690", INV_ICM20690},
> -	{"iam20380", INV_IAM20380},
> -	{"iam20680", INV_IAM20680},
> -	{"iam20680hp", INV_IAM20680HP},
> -	{"iam20680ht", INV_IAM20680HT},
> +	{ .name =3D "mpu6050", .driver_data =3D INV_MPU6050 },
> +	{ .name =3D "mpu6500", .driver_data =3D INV_MPU6500 },
> +	{ .name =3D "mpu6515", .driver_data =3D INV_MPU6515 },
> +	{ .name =3D "mpu6880", .driver_data =3D INV_MPU6880 },
> +	{ .name =3D "mpu9150", .driver_data =3D INV_MPU9150 },
> +	{ .name =3D "mpu9250", .driver_data =3D INV_MPU9250 },
> +	{ .name =3D "mpu9255", .driver_data =3D INV_MPU9255 },
> +	{ .name =3D "icm20608", .driver_data =3D INV_ICM20608 },
> +	{ .name =3D "icm20608d", .driver_data =3D INV_ICM20608D },
> +	{ .name =3D "icm20609", .driver_data =3D INV_ICM20609 },
> +	{ .name =3D "icm20689", .driver_data =3D INV_ICM20689 },
> +	{ .name =3D "icm20600", .driver_data =3D INV_ICM20600 },
> +	{ .name =3D "icm20602", .driver_data =3D INV_ICM20602 },
> +	{ .name =3D "icm20690", .driver_data =3D INV_ICM20690 },
> +	{ .name =3D "iam20380", .driver_data =3D INV_IAM20380 },
> +	{ .name =3D "iam20680", .driver_data =3D INV_IAM20680 },
> +	{ .name =3D "iam20680hp", .driver_data =3D INV_IAM20680HP },
> +	{ .name =3D "iam20680ht", .driver_data =3D INV_IAM20680HT },
>  	{ }
>  };
> =20
> diff --git a/drivers/iio/imu/kmx61.c b/drivers/iio/imu/kmx61.c
> index 3cd91d8a89ee..a4d176f81f0e 100644
> --- a/drivers/iio/imu/kmx61.c
> +++ b/drivers/iio/imu/kmx61.c
> @@ -1481,7 +1481,7 @@ static const struct dev_pm_ops kmx61_pm_ops =3D {
>  };
> =20
>  static const struct i2c_device_id kmx61_id[] =3D {
> -	{ "kmx611021" },
> +	{ .name =3D "kmx611021" },
>  	{ }
>  };
> =20
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c b/drivers/iio/im=
u/st_lsm6dsx/st_lsm6dsx_i2c.c
> index b2a7c2eaf50d..edec898cb11f 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c
> @@ -150,30 +150,30 @@ static const struct acpi_device_id st_lsm6dsx_i2c_a=
cpi_match[] =3D {
>  MODULE_DEVICE_TABLE(acpi, st_lsm6dsx_i2c_acpi_match);
> =20
>  static const struct i2c_device_id st_lsm6dsx_i2c_id_table[] =3D {
> -	{ ST_LSM6DS3_DEV_NAME, ST_LSM6DS3_ID },
> -	{ ST_LSM6DS3H_DEV_NAME, ST_LSM6DS3H_ID },
> -	{ ST_LSM6DSL_DEV_NAME, ST_LSM6DSL_ID },
> -	{ ST_LSM6DSM_DEV_NAME, ST_LSM6DSM_ID },
> -	{ ST_ISM330DLC_DEV_NAME, ST_ISM330DLC_ID },
> -	{ ST_LSM6DSO_DEV_NAME, ST_LSM6DSO_ID },
> -	{ ST_ASM330LHH_DEV_NAME, ST_ASM330LHH_ID },
> -	{ ST_LSM6DSOX_DEV_NAME, ST_LSM6DSOX_ID },
> -	{ ST_LSM6DSR_DEV_NAME, ST_LSM6DSR_ID },
> -	{ ST_LSM6DS3TRC_DEV_NAME, ST_LSM6DS3TRC_ID },
> -	{ ST_ISM330DHCX_DEV_NAME, ST_ISM330DHCX_ID },
> -	{ ST_LSM9DS1_DEV_NAME, ST_LSM9DS1_ID },
> -	{ ST_LSM6DS0_DEV_NAME, ST_LSM6DS0_ID },
> -	{ ST_LSM6DSRX_DEV_NAME, ST_LSM6DSRX_ID },
> -	{ ST_LSM6DST_DEV_NAME, ST_LSM6DST_ID },
> -	{ ST_LSM6DSOP_DEV_NAME, ST_LSM6DSOP_ID },
> -	{ ST_ASM330LHHX_DEV_NAME, ST_ASM330LHHX_ID },
> -	{ ST_LSM6DSTX_DEV_NAME, ST_LSM6DSTX_ID },
> -	{ ST_LSM6DSV_DEV_NAME, ST_LSM6DSV_ID },
> -	{ ST_LSM6DSV16X_DEV_NAME, ST_LSM6DSV16X_ID },
> -	{ ST_LSM6DSO16IS_DEV_NAME, ST_LSM6DSO16IS_ID },
> -	{ ST_ISM330IS_DEV_NAME, ST_ISM330IS_ID },
> -	{ ST_ASM330LHB_DEV_NAME, ST_ASM330LHB_ID },
> -	{ ST_ASM330LHHXG1_DEV_NAME, ST_ASM330LHHXG1_ID },
> +	{ .name =3D ST_LSM6DS3_DEV_NAME, .driver_data =3D ST_LSM6DS3_ID },
> +	{ .name =3D ST_LSM6DS3H_DEV_NAME, .driver_data =3D ST_LSM6DS3H_ID },
> +	{ .name =3D ST_LSM6DSL_DEV_NAME, .driver_data =3D ST_LSM6DSL_ID },
> +	{ .name =3D ST_LSM6DSM_DEV_NAME, .driver_data =3D ST_LSM6DSM_ID },
> +	{ .name =3D ST_ISM330DLC_DEV_NAME, .driver_data =3D ST_ISM330DLC_ID },
> +	{ .name =3D ST_LSM6DSO_DEV_NAME, .driver_data =3D ST_LSM6DSO_ID },
> +	{ .name =3D ST_ASM330LHH_DEV_NAME, .driver_data =3D ST_ASM330LHH_ID },
> +	{ .name =3D ST_LSM6DSOX_DEV_NAME, .driver_data =3D ST_LSM6DSOX_ID },
> +	{ .name =3D ST_LSM6DSR_DEV_NAME, .driver_data =3D ST_LSM6DSR_ID },
> +	{ .name =3D ST_LSM6DS3TRC_DEV_NAME, .driver_data =3D ST_LSM6DS3TRC_ID },
> +	{ .name =3D ST_ISM330DHCX_DEV_NAME, .driver_data =3D ST_ISM330DHCX_ID },
> +	{ .name =3D ST_LSM9DS1_DEV_NAME, .driver_data =3D ST_LSM9DS1_ID },
> +	{ .name =3D ST_LSM6DS0_DEV_NAME, .driver_data =3D ST_LSM6DS0_ID },
> +	{ .name =3D ST_LSM6DSRX_DEV_NAME, .driver_data =3D ST_LSM6DSRX_ID },
> +	{ .name =3D ST_LSM6DST_DEV_NAME, .driver_data =3D ST_LSM6DST_ID },
> +	{ .name =3D ST_LSM6DSOP_DEV_NAME, .driver_data =3D ST_LSM6DSOP_ID },
> +	{ .name =3D ST_ASM330LHHX_DEV_NAME, .driver_data =3D ST_ASM330LHHX_ID },
> +	{ .name =3D ST_LSM6DSTX_DEV_NAME, .driver_data =3D ST_LSM6DSTX_ID },
> +	{ .name =3D ST_LSM6DSV_DEV_NAME, .driver_data =3D ST_LSM6DSV_ID },
> +	{ .name =3D ST_LSM6DSV16X_DEV_NAME, .driver_data =3D ST_LSM6DSV16X_ID },
> +	{ .name =3D ST_LSM6DSO16IS_DEV_NAME, .driver_data =3D ST_LSM6DSO16IS_ID=
 },
> +	{ .name =3D ST_ISM330IS_DEV_NAME, .driver_data =3D ST_ISM330IS_ID },
> +	{ .name =3D ST_ASM330LHB_DEV_NAME, .driver_data =3D ST_ASM330LHB_ID },
> +	{ .name =3D ST_ASM330LHHXG1_DEV_NAME, .driver_data =3D ST_ASM330LHHXG1_=
ID },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, st_lsm6dsx_i2c_id_table);
> diff --git a/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_i2c.c b/drivers/iio/im=
u/st_lsm9ds0/st_lsm9ds0_i2c.c
> index 4232a9d800fc..f71ae7a59a22 100644
> --- a/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_i2c.c
> +++ b/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_i2c.c
> @@ -33,8 +33,8 @@ static const struct of_device_id st_lsm9ds0_of_match[] =
=3D {
>  MODULE_DEVICE_TABLE(of, st_lsm9ds0_of_match);
> =20
>  static const struct i2c_device_id st_lsm9ds0_id_table[] =3D {
> -	{ LSM303D_IMU_DEV_NAME },
> -	{ LSM9DS0_IMU_DEV_NAME },
> +	{ .name =3D LSM303D_IMU_DEV_NAME },
> +	{ .name =3D LSM9DS0_IMU_DEV_NAME },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, st_lsm9ds0_id_table);
> diff --git a/drivers/iio/light/adjd_s311.c b/drivers/iio/light/adjd_s311.c
> index edb3d9dc8bed..088b9431d10a 100644
> --- a/drivers/iio/light/adjd_s311.c
> +++ b/drivers/iio/light/adjd_s311.c
> @@ -260,7 +260,7 @@ static int adjd_s311_probe(struct i2c_client *client)
>  }
> =20
>  static const struct i2c_device_id adjd_s311_id[] =3D {
> -	{ "adjd_s311" },
> +	{ .name =3D "adjd_s311" },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, adjd_s311_id);
> diff --git a/drivers/iio/light/adux1020.c b/drivers/iio/light/adux1020.c
> index 66ff9c5fb66a..633a105fd7f0 100644
> --- a/drivers/iio/light/adux1020.c
> +++ b/drivers/iio/light/adux1020.c
> @@ -818,7 +818,7 @@ static int adux1020_probe(struct i2c_client *client)
>  }
> =20
>  static const struct i2c_device_id adux1020_id[] =3D {
> -	{ "adux1020" },
> +	{ .name =3D "adux1020" },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, adux1020_id);
> diff --git a/drivers/iio/light/al3000a.c b/drivers/iio/light/al3000a.c
> index 9871096cbab3..d4e6fedf3d9e 100644
> --- a/drivers/iio/light/al3000a.c
> +++ b/drivers/iio/light/al3000a.c
> @@ -183,7 +183,7 @@ static int al3000a_resume(struct device *dev)
>  static DEFINE_SIMPLE_DEV_PM_OPS(al3000a_pm_ops, al3000a_suspend, al3000a=
_resume);
> =20
>  static const struct i2c_device_id al3000a_id[] =3D {
> -	{ "al3000a" },
> +	{ .name =3D "al3000a" },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, al3000a_id);
> diff --git a/drivers/iio/light/al3010.c b/drivers/iio/light/al3010.c
> index 0932fa2b49fa..f48420135320 100644
> --- a/drivers/iio/light/al3010.c
> +++ b/drivers/iio/light/al3010.c
> @@ -218,7 +218,7 @@ static int al3010_resume(struct device *dev)
>  static DEFINE_SIMPLE_DEV_PM_OPS(al3010_pm_ops, al3010_suspend, al3010_re=
sume);
> =20
>  static const struct i2c_device_id al3010_id[] =3D {
> -	{"al3010", },
> +	{ .name =3D "al3010" },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, al3010_id);
> diff --git a/drivers/iio/light/al3320a.c b/drivers/iio/light/al3320a.c
> index 63f5a85912fc..617b4f15ea3f 100644
> --- a/drivers/iio/light/al3320a.c
> +++ b/drivers/iio/light/al3320a.c
> @@ -246,7 +246,7 @@ static DEFINE_SIMPLE_DEV_PM_OPS(al3320a_pm_ops, al332=
0a_suspend,
>  				al3320a_resume);
> =20
>  static const struct i2c_device_id al3320a_id[] =3D {
> -	{ "al3320a" },
> +	{ .name =3D "al3320a" },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, al3320a_id);
> diff --git a/drivers/iio/light/apds9300.c b/drivers/iio/light/apds9300.c
> index 05ba21675063..d60ade1209f3 100644
> --- a/drivers/iio/light/apds9300.c
> +++ b/drivers/iio/light/apds9300.c
> @@ -492,7 +492,7 @@ static DEFINE_SIMPLE_DEV_PM_OPS(apds9300_pm_ops, apds=
9300_suspend,
>  				apds9300_resume);
> =20
>  static const struct i2c_device_id apds9300_id[] =3D {
> -	{ APDS9300_DRV_NAME },
> +	{ .name =3D APDS9300_DRV_NAME },
>  	{ }
>  };
> =20
> diff --git a/drivers/iio/light/apds9960.c b/drivers/iio/light/apds9960.c
> index 785c5dbe2d08..2686c3b0c03b 100644
> --- a/drivers/iio/light/apds9960.c
> +++ b/drivers/iio/light/apds9960.c
> @@ -1154,7 +1154,7 @@ static const struct dev_pm_ops apds9960_pm_ops =3D {
>  };
> =20
>  static const struct i2c_device_id apds9960_id[] =3D {
> -	{ "apds9960" },
> +	{ .name =3D "apds9960" },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, apds9960_id);
> diff --git a/drivers/iio/light/as73211.c b/drivers/iio/light/as73211.c
> index 9fe830dac679..67f33bbe1c13 100644
> --- a/drivers/iio/light/as73211.c
> +++ b/drivers/iio/light/as73211.c
> @@ -875,8 +875,8 @@ static const struct of_device_id as73211_of_match[] =
=3D {
>  MODULE_DEVICE_TABLE(of, as73211_of_match);
> =20
>  static const struct i2c_device_id as73211_id[] =3D {
> -	{ "as73211", (kernel_ulong_t)&as73211_spec },
> -	{ "as7331", (kernel_ulong_t)&as7331_spec },
> +	{ .name =3D "as73211", .driver_data =3D (kernel_ulong_t)&as73211_spec },
> +	{ .name =3D "as7331", .driver_data =3D (kernel_ulong_t)&as7331_spec },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, as73211_id);
> diff --git a/drivers/iio/light/bh1745.c b/drivers/iio/light/bh1745.c
> index 10b00344bbed..0aa8e5cc6c56 100644
> --- a/drivers/iio/light/bh1745.c
> +++ b/drivers/iio/light/bh1745.c
> @@ -874,7 +874,7 @@ static int bh1745_probe(struct i2c_client *client)
>  }
> =20
>  static const struct i2c_device_id bh1745_idtable[] =3D {
> -	{ "bh1745" },
> +	{ .name =3D "bh1745" },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, bh1745_idtable);
> diff --git a/drivers/iio/light/bh1750.c b/drivers/iio/light/bh1750.c
> index 764f88826fcb..a51ac98c83c8 100644
> --- a/drivers/iio/light/bh1750.c
> +++ b/drivers/iio/light/bh1750.c
> @@ -319,11 +319,11 @@ static int bh1750_suspend(struct device *dev)
>  static DEFINE_SIMPLE_DEV_PM_OPS(bh1750_pm_ops, bh1750_suspend, NULL);
> =20
>  static const struct i2c_device_id bh1750_id[] =3D {
> -	{ "bh1710", BH1710 },
> -	{ "bh1715", BH1750 },
> -	{ "bh1721", BH1721 },
> -	{ "bh1750", BH1750 },
> -	{ "bh1751", BH1750 },
> +	{ .name =3D "bh1710", .driver_data =3D BH1710 },
> +	{ .name =3D "bh1715", .driver_data =3D BH1750 },
> +	{ .name =3D "bh1721", .driver_data =3D BH1721 },
> +	{ .name =3D "bh1750", .driver_data =3D BH1750 },
> +	{ .name =3D "bh1751", .driver_data =3D BH1750 },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, bh1750_id);
> diff --git a/drivers/iio/light/bh1780.c b/drivers/iio/light/bh1780.c
> index a740d1f992a8..ead98fb82af9 100644
> --- a/drivers/iio/light/bh1780.c
> +++ b/drivers/iio/light/bh1780.c
> @@ -255,7 +255,7 @@ static DEFINE_RUNTIME_DEV_PM_OPS(bh1780_dev_pm_ops, b=
h1780_runtime_suspend,
>  				bh1780_runtime_resume, NULL);
> =20
>  static const struct i2c_device_id bh1780_id[] =3D {
> -	{ "bh1780" },
> +	{ .name =3D "bh1780" },
>  	{ }
>  };
> =20
> diff --git a/drivers/iio/light/cm3232.c b/drivers/iio/light/cm3232.c
> index 3a3ad6b4c468..72cf1b25a90b 100644
> --- a/drivers/iio/light/cm3232.c
> +++ b/drivers/iio/light/cm3232.c
> @@ -366,7 +366,7 @@ static void cm3232_remove(struct i2c_client *client)
>  }
> =20
>  static const struct i2c_device_id cm3232_id[] =3D {
> -	{ "cm3232" },
> +	{ .name =3D "cm3232" },
>  	{ }
>  };
> =20
> diff --git a/drivers/iio/light/cm3323.c b/drivers/iio/light/cm3323.c
> index 79ad6e2209ca..0fd4ddb69c06 100644
> --- a/drivers/iio/light/cm3323.c
> +++ b/drivers/iio/light/cm3323.c
> @@ -250,7 +250,7 @@ static int cm3323_probe(struct i2c_client *client)
>  }
> =20
>  static const struct i2c_device_id cm3323_id[] =3D {
> -	{ "cm3323" },
> +	{ .name =3D "cm3323" },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, cm3323_id);
> diff --git a/drivers/iio/light/cm36651.c b/drivers/iio/light/cm36651.c
> index 446dd54d5037..6ebd8ce4ca12 100644
> --- a/drivers/iio/light/cm36651.c
> +++ b/drivers/iio/light/cm36651.c
> @@ -713,7 +713,7 @@ static void cm36651_remove(struct i2c_client *client)
>  }
> =20
>  static const struct i2c_device_id cm36651_id[] =3D {
> -	{ "cm36651" },
> +	{ .name =3D "cm36651" },
>  	{ }
>  };
> =20
> diff --git a/drivers/iio/light/gp2ap002.c b/drivers/iio/light/gp2ap002.c
> index a0d8a58f2704..c83f67ff2464 100644
> --- a/drivers/iio/light/gp2ap002.c
> +++ b/drivers/iio/light/gp2ap002.c
> @@ -690,7 +690,7 @@ static DEFINE_RUNTIME_DEV_PM_OPS(gp2ap002_dev_pm_ops,=
 gp2ap002_runtime_suspend,
>  				 gp2ap002_runtime_resume, NULL);
> =20
>  static const struct i2c_device_id gp2ap002_id_table[] =3D {
> -	{ "gp2ap002" },
> +	{ .name =3D "gp2ap002" },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, gp2ap002_id_table);
> diff --git a/drivers/iio/light/gp2ap020a00f.c b/drivers/iio/light/gp2ap02=
0a00f.c
> index 7e388319ee2e..c218bb3519df 100644
> --- a/drivers/iio/light/gp2ap020a00f.c
> +++ b/drivers/iio/light/gp2ap020a00f.c
> @@ -1525,7 +1525,7 @@ static void gp2ap020a00f_remove(struct i2c_client *=
client)
>  }
> =20
>  static const struct i2c_device_id gp2ap020a00f_id[] =3D {
> -	{ "gp2ap020a00f" },
> +	{ .name =3D "gp2ap020a00f" },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, gp2ap020a00f_id);
> diff --git a/drivers/iio/light/isl29018.c b/drivers/iio/light/isl29018.c
> index b6ab726d1dae..8a39afaa2a37 100644
> --- a/drivers/iio/light/isl29018.c
> +++ b/drivers/iio/light/isl29018.c
> @@ -829,9 +829,9 @@ static const struct acpi_device_id isl29018_acpi_matc=
h[] =3D {
>  MODULE_DEVICE_TABLE(acpi, isl29018_acpi_match);
> =20
>  static const struct i2c_device_id isl29018_id[] =3D {
> -	{"isl29018", isl29018},
> -	{"isl29023", isl29023},
> -	{"isl29035", isl29035},
> +	{ .name =3D "isl29018", .driver_data =3D isl29018 },
> +	{ .name =3D "isl29023", .driver_data =3D isl29023 },
> +	{ .name =3D "isl29035", .driver_data =3D isl29035 },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, isl29018_id);
> diff --git a/drivers/iio/light/isl29028.c b/drivers/iio/light/isl29028.c
> index 374bccad9119..b88e7c4eae3e 100644
> --- a/drivers/iio/light/isl29028.c
> +++ b/drivers/iio/light/isl29028.c
> @@ -673,8 +673,8 @@ static DEFINE_RUNTIME_DEV_PM_OPS(isl29028_pm_ops, isl=
29028_suspend,
>  				 isl29028_resume, NULL);
> =20
>  static const struct i2c_device_id isl29028_id[] =3D {
> -	{ "isl29028" },
> -	{ "isl29030" },
> +	{ .name =3D "isl29028" },
> +	{ .name =3D "isl29030" },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, isl29028_id);
> diff --git a/drivers/iio/light/isl29125.c b/drivers/iio/light/isl29125.c
> index 3acb8a4f1d12..9e0b7e6a3ecf 100644
> --- a/drivers/iio/light/isl29125.c
> +++ b/drivers/iio/light/isl29125.c
> @@ -325,7 +325,7 @@ static DEFINE_SIMPLE_DEV_PM_OPS(isl29125_pm_ops, isl2=
9125_suspend,
>  				isl29125_resume);
> =20
>  static const struct i2c_device_id isl29125_id[] =3D {
> -	{ "isl29125" },
> +	{ .name =3D "isl29125" },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, isl29125_id);
> diff --git a/drivers/iio/light/isl76682.c b/drivers/iio/light/isl76682.c
> index b6f2fc9978f6..9b9052d08e41 100644
> --- a/drivers/iio/light/isl76682.c
> +++ b/drivers/iio/light/isl76682.c
> @@ -319,7 +319,7 @@ static int isl76682_probe(struct i2c_client *client)
>  }
> =20
>  static const struct i2c_device_id isl76682_id[] =3D {
> -	{ "isl76682" },
> +	{ .name =3D "isl76682" },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, isl76682_id);
> diff --git a/drivers/iio/light/jsa1212.c b/drivers/iio/light/jsa1212.c
> index 6978d02a4df5..cc0a7c4a33dd 100644
> --- a/drivers/iio/light/jsa1212.c
> +++ b/drivers/iio/light/jsa1212.c
> @@ -428,7 +428,7 @@ static const struct acpi_device_id jsa1212_acpi_match=
[] =3D {
>  MODULE_DEVICE_TABLE(acpi, jsa1212_acpi_match);
> =20
>  static const struct i2c_device_id jsa1212_id[] =3D {
> -	{ JSA1212_DRIVER_NAME },
> +	{ .name =3D JSA1212_DRIVER_NAME },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, jsa1212_id);
> diff --git a/drivers/iio/light/ltr390.c b/drivers/iio/light/ltr390.c
> index f1702aca582d..bdc74b8226c8 100644
> --- a/drivers/iio/light/ltr390.c
> +++ b/drivers/iio/light/ltr390.c
> @@ -889,7 +889,7 @@ static const struct dev_pm_ops ltr390_pm_ops =3D {
>  };
> =20
>  static const struct i2c_device_id ltr390_id[] =3D {
> -	{ "ltr390" },
> +	{ .name =3D "ltr390" },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, ltr390_id);
> diff --git a/drivers/iio/light/ltr501.c b/drivers/iio/light/ltr501.c
> index 4d99ae336f61..15dd82ecf745 100644
> --- a/drivers/iio/light/ltr501.c
> +++ b/drivers/iio/light/ltr501.c
> @@ -1601,10 +1601,10 @@ static const struct acpi_device_id ltr_acpi_match=
[] =3D {
>  MODULE_DEVICE_TABLE(acpi, ltr_acpi_match);
> =20
>  static const struct i2c_device_id ltr501_id[] =3D {
> -	{ "ltr501", ltr501 },
> -	{ "ltr559", ltr559 },
> -	{ "ltr301", ltr301 },
> -	{ "ltr303", ltr303 },
> +	{ .name =3D "ltr501", .driver_data =3D ltr501 },
> +	{ .name =3D "ltr559", .driver_data =3D ltr559 },
> +	{ .name =3D "ltr301", .driver_data =3D ltr301 },
> +	{ .name =3D "ltr303", .driver_data =3D ltr303 },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, ltr501_id);
> diff --git a/drivers/iio/light/ltrf216a.c b/drivers/iio/light/ltrf216a.c
> index 5f27f754fe1c..aad96fc91565 100644
> --- a/drivers/iio/light/ltrf216a.c
> +++ b/drivers/iio/light/ltrf216a.c
> @@ -551,8 +551,8 @@ static const struct ltr_chip_info ltrf216a_chip_info =
=3D {
>  };
> =20
>  static const struct i2c_device_id ltrf216a_id[] =3D {
> -	{ "ltr308", .driver_data =3D (kernel_ulong_t)&ltr308_chip_info },
> -	{ "ltrf216a", .driver_data =3D (kernel_ulong_t)&ltrf216a_chip_info },
> +	{ .name =3D "ltr308", .driver_data =3D (kernel_ulong_t)&ltr308_chip_inf=
o },
> +	{ .name =3D "ltrf216a", .driver_data =3D (kernel_ulong_t)&ltrf216a_chip=
_info },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, ltrf216a_id);
> diff --git a/drivers/iio/light/lv0104cs.c b/drivers/iio/light/lv0104cs.c
> index 916109ec3217..eba82c334d70 100644
> --- a/drivers/iio/light/lv0104cs.c
> +++ b/drivers/iio/light/lv0104cs.c
> @@ -510,7 +510,7 @@ static int lv0104cs_probe(struct i2c_client *client)
>  }
> =20
>  static const struct i2c_device_id lv0104cs_id[] =3D {
> -	{ "lv0104cs" },
> +	{ .name =3D "lv0104cs" },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, lv0104cs_id);
> diff --git a/drivers/iio/light/max44000.c b/drivers/iio/light/max44000.c
> index 039d45af3a7f..6594054c40c7 100644
> --- a/drivers/iio/light/max44000.c
> +++ b/drivers/iio/light/max44000.c
> @@ -598,7 +598,7 @@ static int max44000_probe(struct i2c_client *client)
>  }
> =20
>  static const struct i2c_device_id max44000_id[] =3D {
> -	{ "max44000" },
> +	{ .name =3D "max44000" },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, max44000_id);
> diff --git a/drivers/iio/light/max44009.c b/drivers/iio/light/max44009.c
> index 8cd7f5664e5b..82b8a806c5fa 100644
> --- a/drivers/iio/light/max44009.c
> +++ b/drivers/iio/light/max44009.c
> @@ -534,7 +534,7 @@ static const struct of_device_id max44009_of_match[] =
=3D {
>  MODULE_DEVICE_TABLE(of, max44009_of_match);
> =20
>  static const struct i2c_device_id max44009_id[] =3D {
> -	{ "max44009" },
> +	{ .name =3D "max44009" },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, max44009_id);
> diff --git a/drivers/iio/light/noa1305.c b/drivers/iio/light/noa1305.c
> index 25f63da70297..6731f1d9ec1c 100644
> --- a/drivers/iio/light/noa1305.c
> +++ b/drivers/iio/light/noa1305.c
> @@ -315,7 +315,7 @@ static const struct of_device_id noa1305_of_match[] =
=3D {
>  MODULE_DEVICE_TABLE(of, noa1305_of_match);
> =20
>  static const struct i2c_device_id noa1305_ids[] =3D {
> -	{ "noa1305" },
> +	{ .name =3D "noa1305" },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, noa1305_ids);
> diff --git a/drivers/iio/light/opt3001.c b/drivers/iio/light/opt3001.c
> index 53bc455b7bad..9f380073c3c9 100644
> --- a/drivers/iio/light/opt3001.c
> +++ b/drivers/iio/light/opt3001.c
> @@ -948,8 +948,8 @@ static const struct opt3001_chip_info opt3002_chip_in=
formation =3D {
>  };
> =20
>  static const struct i2c_device_id opt3001_id[] =3D {
> -	{ "opt3001", (kernel_ulong_t)&opt3001_chip_information },
> -	{ "opt3002", (kernel_ulong_t)&opt3002_chip_information },
> +	{ .name =3D "opt3001", .driver_data =3D (kernel_ulong_t)&opt3001_chip_i=
nformation },
> +	{ .name =3D "opt3002", .driver_data =3D (kernel_ulong_t)&opt3002_chip_i=
nformation },
>  	{ } /* Terminating Entry */
>  };
>  MODULE_DEVICE_TABLE(i2c, opt3001_id);
> diff --git a/drivers/iio/light/opt4001.c b/drivers/iio/light/opt4001.c
> index 95167273bb90..dd152d921b48 100644
> --- a/drivers/iio/light/opt4001.c
> +++ b/drivers/iio/light/opt4001.c
> @@ -438,8 +438,8 @@ static int opt4001_probe(struct i2c_client *client)
>   * opt4001 packaging
>   */
>  static const struct i2c_device_id opt4001_id[] =3D {
> -	{ "opt4001-sot-5x3", (kernel_ulong_t)&opt4001_sot_5x3_info },
> -	{ "opt4001-picostar", (kernel_ulong_t)&opt4001_picostar_info },
> +	{ .name =3D "opt4001-sot-5x3", .driver_data =3D (kernel_ulong_t)&opt400=
1_sot_5x3_info },
> +	{ .name =3D "opt4001-picostar", .driver_data =3D (kernel_ulong_t)&opt40=
01_picostar_info },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, opt4001_id);
> diff --git a/drivers/iio/light/opt4060.c b/drivers/iio/light/opt4060.c
> index d6e915ab355d..c391ad3271c6 100644
> --- a/drivers/iio/light/opt4060.c
> +++ b/drivers/iio/light/opt4060.c
> @@ -1297,7 +1297,7 @@ static int opt4060_probe(struct i2c_client *client)
>  }
> =20
>  static const struct i2c_device_id opt4060_id[] =3D {
> -	{ "opt4060", },
> +	{ .name =3D "opt4060" },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, opt4060_id);
> diff --git a/drivers/iio/light/pa12203001.c b/drivers/iio/light/pa1220300=
1.c
> index 98a1f1624c75..c0f4db8d95f7 100644
> --- a/drivers/iio/light/pa12203001.c
> +++ b/drivers/iio/light/pa12203001.c
> @@ -457,7 +457,7 @@ static const struct acpi_device_id pa12203001_acpi_ma=
tch[] =3D {
>  MODULE_DEVICE_TABLE(acpi, pa12203001_acpi_match);
> =20
>  static const struct i2c_device_id pa12203001_id[] =3D {
> -		{ "txcpa122" },
> +		{ .name =3D "txcpa122" },
>  		{ }
>  };
> =20
> diff --git a/drivers/iio/light/rpr0521.c b/drivers/iio/light/rpr0521.c
> index 9341c1d58cbe..2ac06dad6d19 100644
> --- a/drivers/iio/light/rpr0521.c
> +++ b/drivers/iio/light/rpr0521.c
> @@ -1102,7 +1102,7 @@ static const struct acpi_device_id rpr0521_acpi_mat=
ch[] =3D {
>  MODULE_DEVICE_TABLE(acpi, rpr0521_acpi_match);
> =20
>  static const struct i2c_device_id rpr0521_id[] =3D {
> -	{ "rpr0521" },
> +	{ .name =3D "rpr0521" },
>  	{ }
>  };
> =20
> diff --git a/drivers/iio/light/si1133.c b/drivers/iio/light/si1133.c
> index 44fa152dbd24..41b8a99363d7 100644
> --- a/drivers/iio/light/si1133.c
> +++ b/drivers/iio/light/si1133.c
> @@ -1055,7 +1055,7 @@ static int si1133_probe(struct i2c_client *client)
>  }
> =20
>  static const struct i2c_device_id si1133_ids[] =3D {
> -	{ "si1133" },
> +	{ .name =3D "si1133" },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, si1133_ids);
> diff --git a/drivers/iio/light/si1145.c b/drivers/iio/light/si1145.c
> index ef0abc4499b7..4601ae5d2009 100644
> --- a/drivers/iio/light/si1145.c
> +++ b/drivers/iio/light/si1145.c
> @@ -1334,13 +1334,13 @@ static int si1145_probe(struct i2c_client *client)
>  }
> =20
>  static const struct i2c_device_id si1145_ids[] =3D {
> -	{ "si1132", SI1132 },
> -	{ "si1141", SI1141 },
> -	{ "si1142", SI1142 },
> -	{ "si1143", SI1143 },
> -	{ "si1145", SI1145 },
> -	{ "si1146", SI1146 },
> -	{ "si1147", SI1147 },
> +	{ .name =3D "si1132", .driver_data =3D SI1132 },
> +	{ .name =3D "si1141", .driver_data =3D SI1141 },
> +	{ .name =3D "si1142", .driver_data =3D SI1142 },
> +	{ .name =3D "si1143", .driver_data =3D SI1143 },
> +	{ .name =3D "si1145", .driver_data =3D SI1145 },
> +	{ .name =3D "si1146", .driver_data =3D SI1146 },
> +	{ .name =3D "si1147", .driver_data =3D SI1147 },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, si1145_ids);
> diff --git a/drivers/iio/light/st_uvis25_i2c.c b/drivers/iio/light/st_uvi=
s25_i2c.c
> index 5d9bb4d9be63..ed8cac5b8766 100644
> --- a/drivers/iio/light/st_uvis25_i2c.c
> +++ b/drivers/iio/light/st_uvis25_i2c.c
> @@ -46,7 +46,7 @@ static const struct of_device_id st_uvis25_i2c_of_match=
[] =3D {
>  MODULE_DEVICE_TABLE(of, st_uvis25_i2c_of_match);
> =20
>  static const struct i2c_device_id st_uvis25_i2c_id_table[] =3D {
> -	{ ST_UVIS25_DEV_NAME },
> +	{ .name =3D ST_UVIS25_DEV_NAME },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, st_uvis25_i2c_id_table);
> diff --git a/drivers/iio/light/stk3310.c b/drivers/iio/light/stk3310.c
> index a75a83594a7e..0165d5e2411f 100644
> --- a/drivers/iio/light/stk3310.c
> +++ b/drivers/iio/light/stk3310.c
> @@ -695,10 +695,10 @@ static DEFINE_SIMPLE_DEV_PM_OPS(stk3310_pm_ops, stk=
3310_suspend,
>  				stk3310_resume);
> =20
>  static const struct i2c_device_id stk3310_i2c_id[] =3D {
> -	{ "STK3013" },
> -	{ "STK3310" },
> -	{ "STK3311" },
> -	{ "STK3335" },
> +	{ .name =3D "STK3013" },
> +	{ .name =3D "STK3310" },
> +	{ .name =3D "STK3311" },
> +	{ .name =3D "STK3335" },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, stk3310_i2c_id);
> diff --git a/drivers/iio/light/tcs3414.c b/drivers/iio/light/tcs3414.c
> index 5be461e6dbdb..458178fb629f 100644
> --- a/drivers/iio/light/tcs3414.c
> +++ b/drivers/iio/light/tcs3414.c
> @@ -362,7 +362,7 @@ static DEFINE_SIMPLE_DEV_PM_OPS(tcs3414_pm_ops, tcs34=
14_suspend,
>  				tcs3414_resume);
> =20
>  static const struct i2c_device_id tcs3414_id[] =3D {
> -	{ "tcs3414" },
> +	{ .name =3D "tcs3414" },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, tcs3414_id);
> diff --git a/drivers/iio/light/tcs3472.c b/drivers/iio/light/tcs3472.c
> index 12429a3261b3..5a14f8d39aa4 100644
> --- a/drivers/iio/light/tcs3472.c
> +++ b/drivers/iio/light/tcs3472.c
> @@ -597,7 +597,7 @@ static DEFINE_SIMPLE_DEV_PM_OPS(tcs3472_pm_ops, tcs34=
72_suspend,
>  				tcs3472_resume);
> =20
>  static const struct i2c_device_id tcs3472_id[] =3D {
> -	{ "tcs3472" },
> +	{ .name =3D "tcs3472" },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, tcs3472_id);
> diff --git a/drivers/iio/light/tsl2772.c b/drivers/iio/light/tsl2772.c
> index c8f15ba95267..1b1c704f1d6c 100644
> --- a/drivers/iio/light/tsl2772.c
> +++ b/drivers/iio/light/tsl2772.c
> @@ -1888,17 +1888,17 @@ static int tsl2772_resume(struct device *dev)
>  }
> =20
>  static const struct i2c_device_id tsl2772_idtable[] =3D {
> -	{ "tsl2571", tsl2571 },
> -	{ "tsl2671", tsl2671 },
> -	{ "tmd2671", tmd2671 },
> -	{ "tsl2771", tsl2771 },
> -	{ "tmd2771", tmd2771 },
> -	{ "tsl2572", tsl2572 },
> -	{ "tsl2672", tsl2672 },
> -	{ "tmd2672", tmd2672 },
> -	{ "tsl2772", tsl2772 },
> -	{ "tmd2772", tmd2772 },
> -	{ "apds9930", apds9930 },
> +	{ .name =3D "tsl2571", .driver_data =3D tsl2571 },
> +	{ .name =3D "tsl2671", .driver_data =3D tsl2671 },
> +	{ .name =3D "tmd2671", .driver_data =3D tmd2671 },
> +	{ .name =3D "tsl2771", .driver_data =3D tsl2771 },
> +	{ .name =3D "tmd2771", .driver_data =3D tmd2771 },
> +	{ .name =3D "tsl2572", .driver_data =3D tsl2572 },
> +	{ .name =3D "tsl2672", .driver_data =3D tsl2672 },
> +	{ .name =3D "tmd2672", .driver_data =3D tmd2672 },
> +	{ .name =3D "tsl2772", .driver_data =3D tsl2772 },
> +	{ .name =3D "tmd2772", .driver_data =3D tmd2772 },
> +	{ .name =3D "apds9930", .driver_data =3D apds9930 },
>  	{ }
>  };
> =20
> diff --git a/drivers/iio/light/tsl4531.c b/drivers/iio/light/tsl4531.c
> index a5788c09ad02..2f91ed8a9876 100644
> --- a/drivers/iio/light/tsl4531.c
> +++ b/drivers/iio/light/tsl4531.c
> @@ -227,7 +227,7 @@ static DEFINE_SIMPLE_DEV_PM_OPS(tsl4531_pm_ops, tsl45=
31_suspend,
>  				tsl4531_resume);
> =20
>  static const struct i2c_device_id tsl4531_id[] =3D {
> -	{ "tsl4531" },
> +	{ .name =3D "tsl4531" },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, tsl4531_id);
> diff --git a/drivers/iio/light/us5182d.c b/drivers/iio/light/us5182d.c
> index d2f5a44892a8..d335e5e551f1 100644
> --- a/drivers/iio/light/us5182d.c
> +++ b/drivers/iio/light/us5182d.c
> @@ -949,7 +949,7 @@ static const struct acpi_device_id us5182d_acpi_match=
[] =3D {
>  MODULE_DEVICE_TABLE(acpi, us5182d_acpi_match);
> =20
>  static const struct i2c_device_id us5182d_id[] =3D {
> -	{ "usd5182" },
> +	{ .name =3D "usd5182" },
>  	{ }
>  };
> =20
> diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
> index 9650dbc41f2b..fc2161d5f3c7 100644
> --- a/drivers/iio/light/vcnl4000.c
> +++ b/drivers/iio/light/vcnl4000.c
> @@ -237,13 +237,13 @@ struct vcnl4000_chip_spec {
>  };
> =20
>  static const struct i2c_device_id vcnl4000_id[] =3D {
> -	{ "cm36672p", CM36672P },
> -	{ "cm36686", VCNL4040 },
> -	{ "vcnl4000", VCNL4000 },
> -	{ "vcnl4010", VCNL4010 },
> -	{ "vcnl4020", VCNL4010 },
> -	{ "vcnl4040", VCNL4040 },
> -	{ "vcnl4200", VCNL4200 },
> +	{ .name =3D "cm36672p", .driver_data =3D CM36672P },
> +	{ .name =3D "cm36686", .driver_data =3D VCNL4040 },
> +	{ .name =3D "vcnl4000", .driver_data =3D VCNL4000 },
> +	{ .name =3D "vcnl4010", .driver_data =3D VCNL4010 },
> +	{ .name =3D "vcnl4020", .driver_data =3D VCNL4010 },
> +	{ .name =3D "vcnl4040", .driver_data =3D VCNL4040 },
> +	{ .name =3D "vcnl4200", .driver_data =3D VCNL4200 },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, vcnl4000_id);
> diff --git a/drivers/iio/light/vcnl4035.c b/drivers/iio/light/vcnl4035.c
> index 16aeb17067bc..bf3a49b4351d 100644
> --- a/drivers/iio/light/vcnl4035.c
> +++ b/drivers/iio/light/vcnl4035.c
> @@ -662,7 +662,7 @@ static DEFINE_RUNTIME_DEV_PM_OPS(vcnl4035_pm_ops, vcn=
l4035_runtime_suspend,
>  				 vcnl4035_runtime_resume, NULL);
> =20
>  static const struct i2c_device_id vcnl4035_id[] =3D {
> -	{ "vcnl4035" },
> +	{ .name =3D "vcnl4035" },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, vcnl4035_id);
> diff --git a/drivers/iio/light/veml3235.c b/drivers/iio/light/veml3235.c
> index 9309ad83ca9e..d8a39223009b 100644
> --- a/drivers/iio/light/veml3235.c
> +++ b/drivers/iio/light/veml3235.c
> @@ -525,7 +525,7 @@ static const struct of_device_id veml3235_of_match[] =
=3D {
>  MODULE_DEVICE_TABLE(of, veml3235_of_match);
> =20
>  static const struct i2c_device_id veml3235_id[] =3D {
> -	{ "veml3235" },
> +	{ .name =3D "veml3235" },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, veml3235_id);
> diff --git a/drivers/iio/light/veml6030.c b/drivers/iio/light/veml6030.c
> index 6bcacae3863c..1aca4b80972e 100644
> --- a/drivers/iio/light/veml6030.c
> +++ b/drivers/iio/light/veml6030.c
> @@ -1218,9 +1218,9 @@ static const struct of_device_id veml6030_of_match[=
] =3D {
>  MODULE_DEVICE_TABLE(of, veml6030_of_match);
> =20
>  static const struct i2c_device_id veml6030_id[] =3D {
> -	{ "veml6030", (kernel_ulong_t)&veml6030_chip},
> -	{ "veml6035", (kernel_ulong_t)&veml6035_chip},
> -	{ "veml7700", (kernel_ulong_t)&veml7700_chip},
> +	{ .name =3D "veml6030", .driver_data =3D (kernel_ulong_t)&veml6030_chip=
 },
> +	{ .name =3D "veml6035", .driver_data =3D (kernel_ulong_t)&veml6035_chip=
 },
> +	{ .name =3D "veml7700", .driver_data =3D (kernel_ulong_t)&veml7700_chip=
 },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, veml6030_id);
> diff --git a/drivers/iio/light/veml6040.c b/drivers/iio/light/veml6040.c
> index f563f9f0ee67..0960784b8866 100644
> --- a/drivers/iio/light/veml6040.c
> +++ b/drivers/iio/light/veml6040.c
> @@ -254,7 +254,7 @@ static int veml6040_probe(struct i2c_client *client)
>  }
> =20
>  static const struct i2c_device_id veml6040_id_table[] =3D {
> -	{"veml6040"},
> +	{ .name =3D "veml6040" },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, veml6040_id_table);
> diff --git a/drivers/iio/light/veml6046x00.c b/drivers/iio/light/veml6046=
x00.c
> index e60f24d46e7b..f23d63291f73 100644
> --- a/drivers/iio/light/veml6046x00.c
> +++ b/drivers/iio/light/veml6046x00.c
> @@ -1009,7 +1009,7 @@ static const struct of_device_id veml6046x00_of_mat=
ch[] =3D {
>  MODULE_DEVICE_TABLE(of, veml6046x00_of_match);
> =20
>  static const struct i2c_device_id veml6046x00_id[] =3D {
> -	{ "veml6046x00" },
> +	{ .name =3D "veml6046x00" },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, veml6046x00_id);
> diff --git a/drivers/iio/light/veml6070.c b/drivers/iio/light/veml6070.c
> index 74d7246e5225..aa7e52628d2a 100644
> --- a/drivers/iio/light/veml6070.c
> +++ b/drivers/iio/light/veml6070.c
> @@ -300,7 +300,7 @@ static int veml6070_probe(struct i2c_client *client)
>  }
> =20
>  static const struct i2c_device_id veml6070_id[] =3D {
> -	{ "veml6070" },
> +	{ .name =3D "veml6070" },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, veml6070_id);
> diff --git a/drivers/iio/light/veml6075.c b/drivers/iio/light/veml6075.c
> index edbb43407054..105bae7be899 100644
> --- a/drivers/iio/light/veml6075.c
> +++ b/drivers/iio/light/veml6075.c
> @@ -451,7 +451,7 @@ static int veml6075_probe(struct i2c_client *client)
>  }
> =20
>  static const struct i2c_device_id veml6075_id[] =3D {
> -	{ "veml6075" },
> +	{ .name =3D "veml6075" },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, veml6075_id);
> diff --git a/drivers/iio/light/vl6180.c b/drivers/iio/light/vl6180.c
> index c1314b144367..6cb965418dba 100644
> --- a/drivers/iio/light/vl6180.c
> +++ b/drivers/iio/light/vl6180.c
> @@ -750,7 +750,7 @@ static const struct of_device_id vl6180_of_match[] =
=3D {
>  MODULE_DEVICE_TABLE(of, vl6180_of_match);
> =20
>  static const struct i2c_device_id vl6180_id[] =3D {
> -	{ "vl6180" },
> +	{ .name =3D "vl6180" },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, vl6180_id);
> diff --git a/drivers/iio/light/zopt2201.c b/drivers/iio/light/zopt2201.c
> index 0990e4d266eb..b53be5f7354e 100644
> --- a/drivers/iio/light/zopt2201.c
> +++ b/drivers/iio/light/zopt2201.c
> @@ -516,7 +516,7 @@ static int zopt2201_probe(struct i2c_client *client)
>  }
> =20
>  static const struct i2c_device_id zopt2201_id[] =3D {
> -	{ "zopt2201" },
> +	{ .name =3D "zopt2201" },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, zopt2201_id);
> diff --git a/drivers/iio/magnetometer/af8133j.c b/drivers/iio/magnetomete=
r/af8133j.c
> index b1768c3aa8f3..352f53edad9a 100644
> --- a/drivers/iio/magnetometer/af8133j.c
> +++ b/drivers/iio/magnetometer/af8133j.c
> @@ -504,7 +504,7 @@ static const struct of_device_id af8133j_of_match[] =
=3D {
>  MODULE_DEVICE_TABLE(of, af8133j_of_match);
> =20
>  static const struct i2c_device_id af8133j_id[] =3D {
> -	{ "af8133j" },
> +	{ .name =3D "af8133j" },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, af8133j_id);
> diff --git a/drivers/iio/magnetometer/ak8974.c b/drivers/iio/magnetometer=
/ak8974.c
> index 817b18257608..18dc36945a97 100644
> --- a/drivers/iio/magnetometer/ak8974.c
> +++ b/drivers/iio/magnetometer/ak8974.c
> @@ -1017,10 +1017,10 @@ static DEFINE_RUNTIME_DEV_PM_OPS(ak8974_dev_pm_op=
s, ak8974_runtime_suspend,
>  				 ak8974_runtime_resume, NULL);
> =20
>  static const struct i2c_device_id ak8974_id[] =3D {
> -	{ "ami305" },
> -	{ "ami306" },
> -	{ "ak8974" },
> -	{ "hscdtd008a" },
> +	{ .name =3D "ami305" },
> +	{ .name =3D "ami306" },
> +	{ .name =3D "ak8974" },
> +	{ .name =3D "hscdtd008a" },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, ak8974_id);
> diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer=
/ak8975.c
> index b648b0afa573..07fe622dc6af 100644
> --- a/drivers/iio/magnetometer/ak8975.c
> +++ b/drivers/iio/magnetometer/ak8975.c
> @@ -1099,13 +1099,13 @@ static const struct acpi_device_id ak_acpi_match[=
] =3D {
>  MODULE_DEVICE_TABLE(acpi, ak_acpi_match);
> =20
>  static const struct i2c_device_id ak8975_id[] =3D {
> -	{"AK8963", (kernel_ulong_t)&ak_def_array[AK8963] },
> -	{"ak8963", (kernel_ulong_t)&ak_def_array[AK8963] },
> -	{"ak8975", (kernel_ulong_t)&ak_def_array[AK8975] },
> -	{"ak09911", (kernel_ulong_t)&ak_def_array[AK09911] },
> -	{"ak09912", (kernel_ulong_t)&ak_def_array[AK09912] },
> -	{"ak09916", (kernel_ulong_t)&ak_def_array[AK09916] },
> -	{"ak09918", (kernel_ulong_t)&ak_def_array[AK09918] },
> +	{ .name =3D "AK8963", .driver_data =3D (kernel_ulong_t)&ak_def_array[AK=
8963] },
> +	{ .name =3D "ak8963", .driver_data =3D (kernel_ulong_t)&ak_def_array[AK=
8963] },
> +	{ .name =3D "ak8975", .driver_data =3D (kernel_ulong_t)&ak_def_array[AK=
8975] },
> +	{ .name =3D "ak09911", .driver_data =3D (kernel_ulong_t)&ak_def_array[A=
K09911] },
> +	{ .name =3D "ak09912", .driver_data =3D (kernel_ulong_t)&ak_def_array[A=
K09912] },
> +	{ .name =3D "ak09916", .driver_data =3D (kernel_ulong_t)&ak_def_array[A=
K09916] },
> +	{ .name =3D "ak09918", .driver_data =3D (kernel_ulong_t)&ak_def_array[A=
K09918] },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, ak8975_id);
> diff --git a/drivers/iio/magnetometer/bmc150_magn_i2c.c b/drivers/iio/mag=
netometer/bmc150_magn_i2c.c
> index b110791f688a..7d3cca8cedbe 100644
> --- a/drivers/iio/magnetometer/bmc150_magn_i2c.c
> +++ b/drivers/iio/magnetometer/bmc150_magn_i2c.c
> @@ -39,9 +39,9 @@ static void bmc150_magn_i2c_remove(struct i2c_client *c=
lient)
>  }
> =20
>  static const struct i2c_device_id bmc150_magn_i2c_id[] =3D {
> -	{ "bmc150_magn" },
> -	{ "bmc156_magn" },
> -	{ "bmm150_magn" },
> +	{ .name =3D "bmc150_magn" },
> +	{ .name =3D "bmc156_magn" },
> +	{ .name =3D "bmm150_magn" },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, bmc150_magn_i2c_id);
> diff --git a/drivers/iio/magnetometer/hmc5843_i2c.c b/drivers/iio/magneto=
meter/hmc5843_i2c.c
> index b41709959e2b..4c454b0057b1 100644
> --- a/drivers/iio/magnetometer/hmc5843_i2c.c
> +++ b/drivers/iio/magnetometer/hmc5843_i2c.c
> @@ -71,10 +71,10 @@ static void hmc5843_i2c_remove(struct i2c_client *cli=
ent)
>  }
> =20
>  static const struct i2c_device_id hmc5843_id[] =3D {
> -	{ "hmc5843", HMC5843_ID },
> -	{ "hmc5883", HMC5883_ID },
> -	{ "hmc5883l", HMC5883L_ID },
> -	{ "hmc5983", HMC5983_ID },
> +	{ .name =3D "hmc5843", .driver_data =3D HMC5843_ID },
> +	{ .name =3D "hmc5883", .driver_data =3D HMC5883_ID },
> +	{ .name =3D "hmc5883l", .driver_data =3D HMC5883L_ID },
> +	{ .name =3D "hmc5983", .driver_data =3D HMC5983_ID },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, hmc5843_id);
> diff --git a/drivers/iio/magnetometer/mag3110.c b/drivers/iio/magnetomete=
r/mag3110.c
> index ff09250a06e7..479a12ece8f6 100644
> --- a/drivers/iio/magnetometer/mag3110.c
> +++ b/drivers/iio/magnetometer/mag3110.c
> @@ -619,7 +619,7 @@ static DEFINE_SIMPLE_DEV_PM_OPS(mag3110_pm_ops, mag31=
10_suspend,
>  				mag3110_resume);
> =20
>  static const struct i2c_device_id mag3110_id[] =3D {
> -	{ "mag3110" },
> +	{ .name =3D "mag3110" },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, mag3110_id);
> diff --git a/drivers/iio/magnetometer/mmc35240.c b/drivers/iio/magnetomet=
er/mmc35240.c
> index f3d48d03f7c3..bad36c8dd598 100644
> --- a/drivers/iio/magnetometer/mmc35240.c
> +++ b/drivers/iio/magnetometer/mmc35240.c
> @@ -560,7 +560,7 @@ static const struct acpi_device_id mmc35240_acpi_matc=
h[] =3D {
>  MODULE_DEVICE_TABLE(acpi, mmc35240_acpi_match);
> =20
>  static const struct i2c_device_id mmc35240_id[] =3D {
> -	{ "mmc35240" },
> +	{ .name =3D "mmc35240" },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, mmc35240_id);
> diff --git a/drivers/iio/magnetometer/mmc5633.c b/drivers/iio/magnetomete=
r/mmc5633.c
> index 9d8e27486963..f82cb68f9c57 100644
> --- a/drivers/iio/magnetometer/mmc5633.c
> +++ b/drivers/iio/magnetometer/mmc5633.c
> @@ -532,8 +532,8 @@ static const struct of_device_id mmc5633_of_match[] =
=3D {
>  MODULE_DEVICE_TABLE(of, mmc5633_of_match);
> =20
>  static const struct i2c_device_id mmc5633_i2c_id[] =3D {
> -	{ "mmc5603" },
> -	{ "mmc5633" },
> +	{ .name =3D "mmc5603" },
> +	{ .name =3D "mmc5633" },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, mmc5633_i2c_id);
> diff --git a/drivers/iio/magnetometer/si7210.c b/drivers/iio/magnetometer=
/si7210.c
> index 2a36abd1c99d..5b3fc3030703 100644
> --- a/drivers/iio/magnetometer/si7210.c
> +++ b/drivers/iio/magnetometer/si7210.c
> @@ -413,7 +413,7 @@ static int si7210_probe(struct i2c_client *client)
>  }
> =20
>  static const struct i2c_device_id si7210_id[] =3D {
> -	{ "si7210" },
> +	{ .name =3D "si7210" },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, si7210_id);
> diff --git a/drivers/iio/magnetometer/st_magn_i2c.c b/drivers/iio/magneto=
meter/st_magn_i2c.c
> index ed70e782af5e..26d1edd1e779 100644
> --- a/drivers/iio/magnetometer/st_magn_i2c.c
> +++ b/drivers/iio/magnetometer/st_magn_i2c.c
> @@ -93,15 +93,15 @@ static int st_magn_i2c_probe(struct i2c_client *clien=
t)
>  }
> =20
>  static const struct i2c_device_id st_magn_id_table[] =3D {
> -	{ LSM303DLH_MAGN_DEV_NAME },
> -	{ LSM303DLHC_MAGN_DEV_NAME },
> -	{ LSM303DLM_MAGN_DEV_NAME },
> -	{ LIS3MDL_MAGN_DEV_NAME },
> -	{ LSM303AGR_MAGN_DEV_NAME },
> -	{ LIS2MDL_MAGN_DEV_NAME },
> -	{ LSM9DS1_MAGN_DEV_NAME },
> -	{ IIS2MDC_MAGN_DEV_NAME },
> -	{ LSM303C_MAGN_DEV_NAME },
> +	{ .name =3D LSM303DLH_MAGN_DEV_NAME },
> +	{ .name =3D LSM303DLHC_MAGN_DEV_NAME },
> +	{ .name =3D LSM303DLM_MAGN_DEV_NAME },
> +	{ .name =3D LIS3MDL_MAGN_DEV_NAME },
> +	{ .name =3D LSM303AGR_MAGN_DEV_NAME },
> +	{ .name =3D LIS2MDL_MAGN_DEV_NAME },
> +	{ .name =3D LSM9DS1_MAGN_DEV_NAME },
> +	{ .name =3D IIS2MDC_MAGN_DEV_NAME },
> +	{ .name =3D LSM303C_MAGN_DEV_NAME },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, st_magn_id_table);
> diff --git a/drivers/iio/magnetometer/tlv493d.c b/drivers/iio/magnetomete=
r/tlv493d.c
> index e5e050af2b74..c8eb136cea6f 100644
> --- a/drivers/iio/magnetometer/tlv493d.c
> +++ b/drivers/iio/magnetometer/tlv493d.c
> @@ -499,7 +499,7 @@ static DEFINE_RUNTIME_DEV_PM_OPS(tlv493d_pm_ops, tlv4=
93d_runtime_suspend,
>  				 tlv493d_runtime_resume, NULL);
> =20
>  static const struct i2c_device_id tlv493d_id[] =3D {
> -	{ "tlv493d" },
> +	{ .name =3D "tlv493d" },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, tlv493d_id);
> diff --git a/drivers/iio/magnetometer/tmag5273.c b/drivers/iio/magnetomet=
er/tmag5273.c
> index 2adc3c036ab4..155294b66924 100644
> --- a/drivers/iio/magnetometer/tmag5273.c
> +++ b/drivers/iio/magnetometer/tmag5273.c
> @@ -708,7 +708,7 @@ static DEFINE_RUNTIME_DEV_PM_OPS(tmag5273_pm_ops,
>  				 NULL);
> =20
>  static const struct i2c_device_id tmag5273_id[] =3D {
> -	{ "tmag5273" },
> +	{ .name =3D "tmag5273" },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, tmag5273_id);
> diff --git a/drivers/iio/magnetometer/yamaha-yas530.c b/drivers/iio/magne=
tometer/yamaha-yas530.c
> index 140c422773f6..f0b2a2709172 100644
> --- a/drivers/iio/magnetometer/yamaha-yas530.c
> +++ b/drivers/iio/magnetometer/yamaha-yas530.c
> @@ -1579,10 +1579,10 @@ static DEFINE_RUNTIME_DEV_PM_OPS(yas5xx_dev_pm_op=
s, yas5xx_runtime_suspend,
>  				 yas5xx_runtime_resume, NULL);
> =20
>  static const struct i2c_device_id yas5xx_id[] =3D {
> -	{"yas530", (kernel_ulong_t)&yas5xx_chip_info_tbl[yas530] },
> -	{"yas532", (kernel_ulong_t)&yas5xx_chip_info_tbl[yas532] },
> -	{"yas533", (kernel_ulong_t)&yas5xx_chip_info_tbl[yas533] },
> -	{"yas537", (kernel_ulong_t)&yas5xx_chip_info_tbl[yas537] },
> +	{ .name =3D "yas530", .driver_data =3D (kernel_ulong_t)&yas5xx_chip_inf=
o_tbl[yas530] },
> +	{ .name =3D "yas532", .driver_data =3D (kernel_ulong_t)&yas5xx_chip_inf=
o_tbl[yas532] },
> +	{ .name =3D "yas533", .driver_data =3D (kernel_ulong_t)&yas5xx_chip_inf=
o_tbl[yas533] },
> +	{ .name =3D "yas537", .driver_data =3D (kernel_ulong_t)&yas5xx_chip_inf=
o_tbl[yas537] },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, yas5xx_id);
> diff --git a/drivers/iio/potentiometer/ad5272.c b/drivers/iio/potentiomet=
er/ad5272.c
> index 672b1ca3a920..ac342127d59e 100644
> --- a/drivers/iio/potentiometer/ad5272.c
> +++ b/drivers/iio/potentiometer/ad5272.c
> @@ -204,11 +204,11 @@ static const struct of_device_id ad5272_dt_ids[] =
=3D {
>  MODULE_DEVICE_TABLE(of, ad5272_dt_ids);
> =20
>  static const struct i2c_device_id ad5272_id[] =3D {
> -	{ "ad5272-020", AD5272_020 },
> -	{ "ad5272-050", AD5272_050 },
> -	{ "ad5272-100", AD5272_100 },
> -	{ "ad5274-020", AD5274_020 },
> -	{ "ad5274-100", AD5274_100 },
> +	{ .name =3D "ad5272-020", .driver_data =3D AD5272_020 },
> +	{ .name =3D "ad5272-050", .driver_data =3D AD5272_050 },
> +	{ .name =3D "ad5272-100", .driver_data =3D AD5272_100 },
> +	{ .name =3D "ad5274-020", .driver_data =3D AD5274_020 },
> +	{ .name =3D "ad5274-100", .driver_data =3D AD5274_100 },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, ad5272_id);
> diff --git a/drivers/iio/potentiometer/ds1803.c b/drivers/iio/potentiomet=
er/ds1803.c
> index 8a64d93f7e7b..42394343b5a9 100644
> --- a/drivers/iio/potentiometer/ds1803.c
> +++ b/drivers/iio/potentiometer/ds1803.c
> @@ -235,10 +235,10 @@ static const struct of_device_id ds1803_dt_ids[] =
=3D {
>  MODULE_DEVICE_TABLE(of, ds1803_dt_ids);
> =20
>  static const struct i2c_device_id ds1803_id[] =3D {
> -	{ "ds1803-010", (kernel_ulong_t)&ds1803_cfg[DS1803_010] },
> -	{ "ds1803-050", (kernel_ulong_t)&ds1803_cfg[DS1803_050] },
> -	{ "ds1803-100", (kernel_ulong_t)&ds1803_cfg[DS1803_100] },
> -	{ "ds3502", (kernel_ulong_t)&ds1803_cfg[DS3502] },
> +	{ .name =3D "ds1803-010", .driver_data =3D (kernel_ulong_t)&ds1803_cfg[=
DS1803_010] },
> +	{ .name =3D "ds1803-050", .driver_data =3D (kernel_ulong_t)&ds1803_cfg[=
DS1803_050] },
> +	{ .name =3D "ds1803-100", .driver_data =3D (kernel_ulong_t)&ds1803_cfg[=
DS1803_100] },
> +	{ .name =3D "ds3502", .driver_data =3D (kernel_ulong_t)&ds1803_cfg[DS35=
02] },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, ds1803_id);
> diff --git a/drivers/iio/potentiometer/tpl0102.c b/drivers/iio/potentiome=
ter/tpl0102.c
> index a42b57733363..77149908e1bf 100644
> --- a/drivers/iio/potentiometer/tpl0102.c
> +++ b/drivers/iio/potentiometer/tpl0102.c
> @@ -149,10 +149,10 @@ static int tpl0102_probe(struct i2c_client *client)
>  }
> =20
>  static const struct i2c_device_id tpl0102_id[] =3D {
> -	{ "cat5140-503", CAT5140_503 },
> -	{ "cat5140-104", CAT5140_104 },
> -	{ "tpl0102-104", TPL0102_104 },
> -	{ "tpl0401-103", TPL0401_103 },
> +	{ .name =3D "cat5140-503", .driver_data =3D CAT5140_503 },
> +	{ .name =3D "cat5140-104", .driver_data =3D CAT5140_104 },
> +	{ .name =3D "tpl0102-104", .driver_data =3D TPL0102_104 },
> +	{ .name =3D "tpl0401-103", .driver_data =3D TPL0401_103 },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, tpl0102_id);
> diff --git a/drivers/iio/potentiostat/lmp91000.c b/drivers/iio/potentiost=
at/lmp91000.c
> index eccc2a34358f..359dffa47091 100644
> --- a/drivers/iio/potentiostat/lmp91000.c
> +++ b/drivers/iio/potentiostat/lmp91000.c
> @@ -403,8 +403,8 @@ static const struct of_device_id lmp91000_of_match[] =
=3D {
>  MODULE_DEVICE_TABLE(of, lmp91000_of_match);
> =20
>  static const struct i2c_device_id lmp91000_id[] =3D {
> -	{ "lmp91000" },
> -	{ "lmp91002" },
> +	{ .name =3D "lmp91000" },
> +	{ .name =3D "lmp91002" },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, lmp91000_id);
> diff --git a/drivers/iio/pressure/abp060mg.c b/drivers/iio/pressure/abp06=
0mg.c
> index 699b0fd64985..fd48bed35088 100644
> --- a/drivers/iio/pressure/abp060mg.c
> +++ b/drivers/iio/pressure/abp060mg.c
> @@ -209,44 +209,66 @@ static int abp060mg_probe(struct i2c_client *client)
>  static const struct i2c_device_id abp060mg_id_table[] =3D {
>  	/* mbar & kPa variants (abp060m [60 mbar] =3D=3D abp006k [6 kPa]) */
>  	/*    gage: */
> -	{ "abp060mg", ABP006KG }, { "abp006kg", ABP006KG },
> -	{ "abp100mg", ABP010KG }, { "abp010kg", ABP010KG },
> -	{ "abp160mg", ABP016KG }, { "abp016kg", ABP016KG },
> -	{ "abp250mg", ABP025KG }, { "abp025kg", ABP025KG },
> -	{ "abp400mg", ABP040KG }, { "abp040kg", ABP040KG },
> -	{ "abp600mg", ABP060KG }, { "abp060kg", ABP060KG },
> -	{ "abp001bg", ABP100KG }, { "abp100kg", ABP100KG },
> -	{ "abp1_6bg", ABP160KG }, { "abp160kg", ABP160KG },
> -	{ "abp2_5bg", ABP250KG }, { "abp250kg", ABP250KG },
> -	{ "abp004bg", ABP400KG }, { "abp400kg", ABP400KG },
> -	{ "abp006bg", ABP600KG }, { "abp600kg", ABP600KG },
> -	{ "abp010bg", ABP001GG }, { "abp001gg", ABP001GG },
> +	{ .name =3D "abp060mg", .driver_data =3D ABP006KG },
> +	{ .name =3D "abp006kg", .driver_data =3D ABP006KG },
> +	{ .name =3D "abp100mg", .driver_data =3D ABP010KG },
> +	{ .name =3D "abp010kg", .driver_data =3D ABP010KG },
> +	{ .name =3D "abp160mg", .driver_data =3D ABP016KG },
> +	{ .name =3D "abp016kg", .driver_data =3D ABP016KG },
> +	{ .name =3D "abp250mg", .driver_data =3D ABP025KG },
> +	{ .name =3D "abp025kg", .driver_data =3D ABP025KG },
> +	{ .name =3D "abp400mg", .driver_data =3D ABP040KG },
> +	{ .name =3D "abp040kg", .driver_data =3D ABP040KG },
> +	{ .name =3D "abp600mg", .driver_data =3D ABP060KG },
> +	{ .name =3D "abp060kg", .driver_data =3D ABP060KG },
> +	{ .name =3D "abp001bg", .driver_data =3D ABP100KG },
> +	{ .name =3D "abp100kg", .driver_data =3D ABP100KG },
> +	{ .name =3D "abp1_6bg", .driver_data =3D ABP160KG },
> +	{ .name =3D "abp160kg", .driver_data =3D ABP160KG },
> +	{ .name =3D "abp2_5bg", .driver_data =3D ABP250KG },
> +	{ .name =3D "abp250kg", .driver_data =3D ABP250KG },
> +	{ .name =3D "abp004bg", .driver_data =3D ABP400KG },
> +	{ .name =3D "abp400kg", .driver_data =3D ABP400KG },
> +	{ .name =3D "abp006bg", .driver_data =3D ABP600KG },
> +	{ .name =3D "abp600kg", .driver_data =3D ABP600KG },
> +	{ .name =3D "abp010bg", .driver_data =3D ABP001GG },
> +	{ .name =3D "abp001gg", .driver_data =3D ABP001GG },
>  	/*    differential: */
> -	{ "abp060md", ABP006KD }, { "abp006kd", ABP006KD },
> -	{ "abp100md", ABP010KD }, { "abp010kd", ABP010KD },
> -	{ "abp160md", ABP016KD }, { "abp016kd", ABP016KD },
> -	{ "abp250md", ABP025KD }, { "abp025kd", ABP025KD },
> -	{ "abp400md", ABP040KD }, { "abp040kd", ABP040KD },
> -	{ "abp600md", ABP060KD }, { "abp060kd", ABP060KD },
> -	{ "abp001bd", ABP100KD }, { "abp100kd", ABP100KD },
> -	{ "abp1_6bd", ABP160KD }, { "abp160kd", ABP160KD },
> -	{ "abp2_5bd", ABP250KD }, { "abp250kd", ABP250KD },
> -	{ "abp004bd", ABP400KD }, { "abp400kd", ABP400KD },
> +	{ .name =3D "abp060md", .driver_data =3D ABP006KD },
> +	{ .name =3D "abp006kd", .driver_data =3D ABP006KD },
> +	{ .name =3D "abp100md", .driver_data =3D ABP010KD },
> +	{ .name =3D "abp010kd", .driver_data =3D ABP010KD },
> +	{ .name =3D "abp160md", .driver_data =3D ABP016KD },
> +	{ .name =3D "abp016kd", .driver_data =3D ABP016KD },
> +	{ .name =3D "abp250md", .driver_data =3D ABP025KD },
> +	{ .name =3D "abp025kd", .driver_data =3D ABP025KD },
> +	{ .name =3D "abp400md", .driver_data =3D ABP040KD },
> +	{ .name =3D "abp040kd", .driver_data =3D ABP040KD },
> +	{ .name =3D "abp600md", .driver_data =3D ABP060KD },
> +	{ .name =3D "abp060kd", .driver_data =3D ABP060KD },
> +	{ .name =3D "abp001bd", .driver_data =3D ABP100KD },
> +	{ .name =3D "abp100kd", .driver_data =3D ABP100KD },
> +	{ .name =3D "abp1_6bd", .driver_data =3D ABP160KD },
> +	{ .name =3D "abp160kd", .driver_data =3D ABP160KD },
> +	{ .name =3D "abp2_5bd", .driver_data =3D ABP250KD },
> +	{ .name =3D "abp250kd", .driver_data =3D ABP250KD },
> +	{ .name =3D "abp004bd", .driver_data =3D ABP400KD },
> +	{ .name =3D "abp400kd", .driver_data =3D ABP400KD },
>  	/* psi variants */
>  	/*    gage: */
> -	{ "abp001pg", ABP001PG },
> -	{ "abp005pg", ABP005PG },
> -	{ "abp015pg", ABP015PG },
> -	{ "abp030pg", ABP030PG },
> -	{ "abp060pg", ABP060PG },
> -	{ "abp100pg", ABP100PG },
> -	{ "abp150pg", ABP150PG },
> +	{ .name =3D "abp001pg", .driver_data =3D ABP001PG },
> +	{ .name =3D "abp005pg", .driver_data =3D ABP005PG },
> +	{ .name =3D "abp015pg", .driver_data =3D ABP015PG },
> +	{ .name =3D "abp030pg", .driver_data =3D ABP030PG },
> +	{ .name =3D "abp060pg", .driver_data =3D ABP060PG },
> +	{ .name =3D "abp100pg", .driver_data =3D ABP100PG },
> +	{ .name =3D "abp150pg", .driver_data =3D ABP150PG },
>  	/*    differential: */
> -	{ "abp001pd", ABP001PD },
> -	{ "abp005pd", ABP005PD },
> -	{ "abp015pd", ABP015PD },
> -	{ "abp030pd", ABP030PD },
> -	{ "abp060pd", ABP060PD },
> +	{ .name =3D "abp001pd", .driver_data =3D ABP001PD },
> +	{ .name =3D "abp005pd", .driver_data =3D ABP005PD },
> +	{ .name =3D "abp015pd", .driver_data =3D ABP015PD },
> +	{ .name =3D "abp030pd", .driver_data =3D ABP030PD },
> +	{ .name =3D "abp060pd", .driver_data =3D ABP060PD },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, abp060mg_id_table);
> diff --git a/drivers/iio/pressure/abp2030pa_i2c.c b/drivers/iio/pressure/=
abp2030pa_i2c.c
> index 9f1c1c8a9afb..e71dc8e8e957 100644
> --- a/drivers/iio/pressure/abp2030pa_i2c.c
> +++ b/drivers/iio/pressure/abp2030pa_i2c.c
> @@ -69,7 +69,7 @@ static const struct of_device_id abp2_i2c_match[] =3D {
>  MODULE_DEVICE_TABLE(of, abp2_i2c_match);
> =20
>  static const struct i2c_device_id abp2_i2c_id[] =3D {
> -	{ "abp2030pa" },
> +	{ .name =3D "abp2030pa" },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, abp2_i2c_id);
> diff --git a/drivers/iio/pressure/adp810.c b/drivers/iio/pressure/adp810.c
> index 5282612d1309..47c5ad564c7f 100644
> --- a/drivers/iio/pressure/adp810.c
> +++ b/drivers/iio/pressure/adp810.c
> @@ -199,7 +199,7 @@ static int adp810_probe(struct i2c_client *client)
>  }
> =20
>  static const struct i2c_device_id adp810_id_table[] =3D {
> -	{ "adp810" },
> +	{ .name =3D "adp810" },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, adp810_id_table);
> diff --git a/drivers/iio/pressure/bmp280-i2c.c b/drivers/iio/pressure/bmp=
280-i2c.c
> index 8e459b6c97ff..3f6e0723a9d7 100644
> --- a/drivers/iio/pressure/bmp280-i2c.c
> +++ b/drivers/iio/pressure/bmp280-i2c.c
> @@ -38,12 +38,12 @@ static const struct of_device_id bmp280_of_i2c_match[=
] =3D {
>  MODULE_DEVICE_TABLE(of, bmp280_of_i2c_match);
> =20
>  static const struct i2c_device_id bmp280_i2c_id[] =3D {
> -	{"bmp085", (kernel_ulong_t)&bmp085_chip_info },
> -	{"bmp180", (kernel_ulong_t)&bmp180_chip_info },
> -	{"bmp280", (kernel_ulong_t)&bmp280_chip_info },
> -	{"bme280", (kernel_ulong_t)&bme280_chip_info },
> -	{"bmp380", (kernel_ulong_t)&bmp380_chip_info },
> -	{"bmp580", (kernel_ulong_t)&bmp580_chip_info },
> +	{ .name =3D "bmp085", .driver_data =3D (kernel_ulong_t)&bmp085_chip_inf=
o },
> +	{ .name =3D "bmp180", .driver_data =3D (kernel_ulong_t)&bmp180_chip_inf=
o },
> +	{ .name =3D "bmp280", .driver_data =3D (kernel_ulong_t)&bmp280_chip_inf=
o },
> +	{ .name =3D "bme280", .driver_data =3D (kernel_ulong_t)&bme280_chip_inf=
o },
> +	{ .name =3D "bmp380", .driver_data =3D (kernel_ulong_t)&bmp380_chip_inf=
o },
> +	{ .name =3D "bmp580", .driver_data =3D (kernel_ulong_t)&bmp580_chip_inf=
o },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, bmp280_i2c_id);
> diff --git a/drivers/iio/pressure/dlhl60d.c b/drivers/iio/pressure/dlhl60=
d.c
> index 46feb27fe632..01a873165923 100644
> --- a/drivers/iio/pressure/dlhl60d.c
> +++ b/drivers/iio/pressure/dlhl60d.c
> @@ -340,8 +340,8 @@ static const struct of_device_id dlh_of_match[] =3D {
>  MODULE_DEVICE_TABLE(of, dlh_of_match);
> =20
>  static const struct i2c_device_id dlh_id[] =3D {
> -	{ "dlhl60d", (kernel_ulong_t)&dlhl60d_info },
> -	{ "dlhl60g", (kernel_ulong_t)&dlhl60g_info },
> +	{ .name =3D "dlhl60d", .driver_data =3D (kernel_ulong_t)&dlhl60d_info },
> +	{ .name =3D "dlhl60g", .driver_data =3D (kernel_ulong_t)&dlhl60g_info },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, dlh_id);
> diff --git a/drivers/iio/pressure/dps310.c b/drivers/iio/pressure/dps310.c
> index 8edaa4d10a70..f45af72a0554 100644
> --- a/drivers/iio/pressure/dps310.c
> +++ b/drivers/iio/pressure/dps310.c
> @@ -887,7 +887,7 @@ static int dps310_probe(struct i2c_client *client)
>  }
> =20
>  static const struct i2c_device_id dps310_id[] =3D {
> -	{ DPS310_DEV_NAME },
> +	{ .name =3D DPS310_DEV_NAME },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, dps310_id);
> diff --git a/drivers/iio/pressure/hp03.c b/drivers/iio/pressure/hp03.c
> index cbb4aaf45e2c..424523345060 100644
> --- a/drivers/iio/pressure/hp03.c
> +++ b/drivers/iio/pressure/hp03.c
> @@ -266,7 +266,7 @@ static int hp03_probe(struct i2c_client *client)
>  }
> =20
>  static const struct i2c_device_id hp03_id[] =3D {
> -	{ "hp03" },
> +	{ .name =3D "hp03" },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, hp03_id);
> diff --git a/drivers/iio/pressure/hp206c.c b/drivers/iio/pressure/hp206c.c
> index abe10ccb6770..be14202855cf 100644
> --- a/drivers/iio/pressure/hp206c.c
> +++ b/drivers/iio/pressure/hp206c.c
> @@ -395,7 +395,7 @@ static int hp206c_probe(struct i2c_client *client)
>  }
> =20
>  static const struct i2c_device_id hp206c_id[] =3D {
> -	{"hp206c"},
> +	{ .name =3D "hp206c" },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, hp206c_id);
> diff --git a/drivers/iio/pressure/hsc030pa_i2c.c b/drivers/iio/pressure/h=
sc030pa_i2c.c
> index 3500bda03d75..f4ea30b2980d 100644
> --- a/drivers/iio/pressure/hsc030pa_i2c.c
> +++ b/drivers/iio/pressure/hsc030pa_i2c.c
> @@ -58,7 +58,7 @@ static const struct of_device_id hsc_i2c_match[] =3D {
>  MODULE_DEVICE_TABLE(of, hsc_i2c_match);
> =20
>  static const struct i2c_device_id hsc_i2c_id[] =3D {
> -	{ "hsc030pa" },
> +	{ .name =3D "hsc030pa" },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, hsc_i2c_id);
> diff --git a/drivers/iio/pressure/icp10100.c b/drivers/iio/pressure/icp10=
100.c
> index 3d83d0098a57..02b363c5c45b 100644
> --- a/drivers/iio/pressure/icp10100.c
> +++ b/drivers/iio/pressure/icp10100.c
> @@ -633,7 +633,7 @@ static const struct of_device_id icp10100_of_match[] =
=3D {
>  MODULE_DEVICE_TABLE(of, icp10100_of_match);
> =20
>  static const struct i2c_device_id icp10100_id[] =3D {
> -	{ "icp10100" },
> +	{ .name =3D "icp10100" },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, icp10100_id);
> diff --git a/drivers/iio/pressure/mpl115_i2c.c b/drivers/iio/pressure/mpl=
115_i2c.c
> index 3db9ef4e2770..4a43eba078a8 100644
> --- a/drivers/iio/pressure/mpl115_i2c.c
> +++ b/drivers/iio/pressure/mpl115_i2c.c
> @@ -45,7 +45,7 @@ static int mpl115_i2c_probe(struct i2c_client *client)
>  }
> =20
>  static const struct i2c_device_id mpl115_i2c_id[] =3D {
> -	{ "mpl115" },
> +	{ .name =3D "mpl115" },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, mpl115_i2c_id);
> diff --git a/drivers/iio/pressure/mpl3115.c b/drivers/iio/pressure/mpl311=
5.c
> index aeac1586f12e..f20fa6ad16fe 100644
> --- a/drivers/iio/pressure/mpl3115.c
> +++ b/drivers/iio/pressure/mpl3115.c
> @@ -783,7 +783,7 @@ static DEFINE_SIMPLE_DEV_PM_OPS(mpl3115_pm_ops, mpl31=
15_suspend,
>  				mpl3115_resume);
> =20
>  static const struct i2c_device_id mpl3115_id[] =3D {
> -	{ "mpl3115" },
> +	{ .name =3D "mpl3115" },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, mpl3115_id);
> diff --git a/drivers/iio/pressure/mprls0025pa_i2c.c b/drivers/iio/pressur=
e/mprls0025pa_i2c.c
> index 0fe8cfe0d7e7..92edaf3005eb 100644
> --- a/drivers/iio/pressure/mprls0025pa_i2c.c
> +++ b/drivers/iio/pressure/mprls0025pa_i2c.c
> @@ -69,7 +69,7 @@ static const struct of_device_id mpr_i2c_match[] =3D {
>  MODULE_DEVICE_TABLE(of, mpr_i2c_match);
> =20
>  static const struct i2c_device_id mpr_i2c_id[] =3D {
> -	{ "mprls0025pa" },
> +	{ .name =3D "mprls0025pa" },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, mpr_i2c_id);
> diff --git a/drivers/iio/pressure/ms5611_i2c.c b/drivers/iio/pressure/ms5=
611_i2c.c
> index 1c041b9085fb..b5be6a6daf02 100644
> --- a/drivers/iio/pressure/ms5611_i2c.c
> +++ b/drivers/iio/pressure/ms5611_i2c.c
> @@ -113,8 +113,8 @@ static const struct of_device_id ms5611_i2c_matches[]=
 =3D {
>  MODULE_DEVICE_TABLE(of, ms5611_i2c_matches);
> =20
>  static const struct i2c_device_id ms5611_id[] =3D {
> -	{ "ms5611", MS5611 },
> -	{ "ms5607", MS5607 },
> +	{ .name =3D "ms5611", .driver_data =3D MS5611 },
> +	{ .name =3D "ms5607", .driver_data =3D MS5607 },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, ms5611_id);
> diff --git a/drivers/iio/pressure/ms5637.c b/drivers/iio/pressure/ms5637.c
> index 59705a666979..03945a4fc718 100644
> --- a/drivers/iio/pressure/ms5637.c
> +++ b/drivers/iio/pressure/ms5637.c
> @@ -215,10 +215,10 @@ static const struct ms_tp_data ms8607_data =3D {
>  };
> =20
>  static const struct i2c_device_id ms5637_id[] =3D {
> -	{"ms5637", (kernel_ulong_t)&ms5637_data },
> -	{"ms5805", (kernel_ulong_t)&ms5805_data },
> -	{"ms5837", (kernel_ulong_t)&ms5837_data },
> -	{"ms8607-temppressure", (kernel_ulong_t)&ms8607_data },
> +	{ .name =3D "ms5637", .driver_data =3D (kernel_ulong_t)&ms5637_data },
> +	{ .name =3D "ms5805", .driver_data =3D (kernel_ulong_t)&ms5805_data },
> +	{ .name =3D "ms5837", .driver_data =3D (kernel_ulong_t)&ms5837_data },
> +	{ .name =3D "ms8607-temppressure", .driver_data =3D (kernel_ulong_t)&ms=
8607_data },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, ms5637_id);
> diff --git a/drivers/iio/pressure/rohm-bm1390.c b/drivers/iio/pressure/ro=
hm-bm1390.c
> index 08146ca0f91d..b3be9de03678 100644
> --- a/drivers/iio/pressure/rohm-bm1390.c
> +++ b/drivers/iio/pressure/rohm-bm1390.c
> @@ -888,7 +888,7 @@ static const struct of_device_id bm1390_of_match[] =
=3D {
>  MODULE_DEVICE_TABLE(of, bm1390_of_match);
> =20
>  static const struct i2c_device_id bm1390_id[] =3D {
> -	{ "bm1390glv-z", },
> +	{ .name =3D "bm1390glv-z" },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, bm1390_id);
> diff --git a/drivers/iio/pressure/sdp500.c b/drivers/iio/pressure/sdp500.c
> index 9828c73c4855..ba80dc21faad 100644
> --- a/drivers/iio/pressure/sdp500.c
> +++ b/drivers/iio/pressure/sdp500.c
> @@ -130,7 +130,7 @@ static int sdp500_probe(struct i2c_client *client)
>  }
> =20
>  static const struct i2c_device_id sdp500_id[] =3D {
> -	{ "sdp500" },
> +	{ .name =3D "sdp500" },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, sdp500_id);
> diff --git a/drivers/iio/pressure/st_pressure_i2c.c b/drivers/iio/pressur=
e/st_pressure_i2c.c
> index 0f50bac1fb4d..816bfcfd62ae 100644
> --- a/drivers/iio/pressure/st_pressure_i2c.c
> +++ b/drivers/iio/pressure/st_pressure_i2c.c
> @@ -61,14 +61,14 @@ static const struct acpi_device_id st_press_acpi_matc=
h[] =3D {
>  MODULE_DEVICE_TABLE(acpi, st_press_acpi_match);
> =20
>  static const struct i2c_device_id st_press_id_table[] =3D {
> -	{ LPS001WP_PRESS_DEV_NAME, LPS001WP },
> -	{ LPS25H_PRESS_DEV_NAME,  LPS25H },
> -	{ LPS331AP_PRESS_DEV_NAME, LPS331AP },
> -	{ LPS22HB_PRESS_DEV_NAME, LPS22HB },
> -	{ LPS33HW_PRESS_DEV_NAME, LPS33HW },
> -	{ LPS35HW_PRESS_DEV_NAME, LPS35HW },
> -	{ LPS22HH_PRESS_DEV_NAME, LPS22HH },
> -	{ LPS22DF_PRESS_DEV_NAME, LPS22DF },
> +	{ .name =3D LPS001WP_PRESS_DEV_NAME, .driver_data =3D LPS001WP },
> +	{ .name =3D LPS25H_PRESS_DEV_NAME, .driver_data =3D LPS25H },
> +	{ .name =3D LPS331AP_PRESS_DEV_NAME, .driver_data =3D LPS331AP },
> +	{ .name =3D LPS22HB_PRESS_DEV_NAME, .driver_data =3D LPS22HB },
> +	{ .name =3D LPS33HW_PRESS_DEV_NAME, .driver_data =3D LPS33HW },
> +	{ .name =3D LPS35HW_PRESS_DEV_NAME, .driver_data =3D LPS35HW },
> +	{ .name =3D LPS22HH_PRESS_DEV_NAME, .driver_data =3D LPS22HH },
> +	{ .name =3D LPS22DF_PRESS_DEV_NAME, .driver_data =3D LPS22DF },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, st_press_id_table);
> diff --git a/drivers/iio/pressure/t5403.c b/drivers/iio/pressure/t5403.c
> index c7cb0fd816d3..ab30f6745181 100644
> --- a/drivers/iio/pressure/t5403.c
> +++ b/drivers/iio/pressure/t5403.c
> @@ -251,7 +251,7 @@ static int t5403_probe(struct i2c_client *client)
>  }
> =20
>  static const struct i2c_device_id t5403_id[] =3D {
> -	{ "t5403" },
> +	{ .name =3D "t5403" },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, t5403_id);
> diff --git a/drivers/iio/pressure/zpa2326_i2c.c b/drivers/iio/pressure/zp=
a2326_i2c.c
> index a6034bf05d97..2d8af33f6a29 100644
> --- a/drivers/iio/pressure/zpa2326_i2c.c
> +++ b/drivers/iio/pressure/zpa2326_i2c.c
> @@ -58,7 +58,7 @@ static void zpa2326_remove_i2c(struct i2c_client *clien=
t)
>  }
> =20
>  static const struct i2c_device_id zpa2326_i2c_ids[] =3D {
> -	{ "zpa2326" },
> +	{ .name =3D "zpa2326" },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, zpa2326_i2c_ids);
> diff --git a/drivers/iio/proximity/aw96103.c b/drivers/iio/proximity/aw96=
103.c
> index 3472a2c36e44..8fbb755dcae0 100644
> --- a/drivers/iio/proximity/aw96103.c
> +++ b/drivers/iio/proximity/aw96103.c
> @@ -825,8 +825,8 @@ static const struct of_device_id aw96103_dt_match[] =
=3D {
>  MODULE_DEVICE_TABLE(of, aw96103_dt_match);
> =20
>  static const struct i2c_device_id aw96103_i2c_id[] =3D {
> -	{ "aw96103", (kernel_ulong_t)&aw_chip_info_tbl[AW96103_VAL] },
> -	{ "aw96105", (kernel_ulong_t)&aw_chip_info_tbl[AW96105_VAL] },
> +	{ .name =3D "aw96103", .driver_data =3D (kernel_ulong_t)&aw_chip_info_t=
bl[AW96103_VAL] },
> +	{ .name =3D "aw96105", .driver_data =3D (kernel_ulong_t)&aw_chip_info_t=
bl[AW96105_VAL] },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, aw96103_i2c_id);
> diff --git a/drivers/iio/proximity/hx9023s.c b/drivers/iio/proximity/hx90=
23s.c
> index 9efaa5b6b5bd..c3a93c0e2b64 100644
> --- a/drivers/iio/proximity/hx9023s.c
> +++ b/drivers/iio/proximity/hx9023s.c
> @@ -1199,7 +1199,7 @@ static const struct of_device_id hx9023s_of_match[]=
 =3D {
>  MODULE_DEVICE_TABLE(of, hx9023s_of_match);
> =20
>  static const struct i2c_device_id hx9023s_id[] =3D {
> -	{ "hx9023s" },
> +	{ .name =3D "hx9023s" },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, hx9023s_id);
> diff --git a/drivers/iio/proximity/isl29501.c b/drivers/iio/proximity/isl=
29501.c
> index f69db6f2f380..016626f21218 100644
> --- a/drivers/iio/proximity/isl29501.c
> +++ b/drivers/iio/proximity/isl29501.c
> @@ -995,7 +995,7 @@ static int isl29501_probe(struct i2c_client *client)
>  }
> =20
>  static const struct i2c_device_id isl29501_id[] =3D {
> -	{ "isl29501" },
> +	{ .name =3D "isl29501" },
>  	{ }
>  };
> =20
> diff --git a/drivers/iio/proximity/mb1232.c b/drivers/iio/proximity/mb123=
2.c
> index 34b49c54e68b..1e8ecb9e9c56 100644
> --- a/drivers/iio/proximity/mb1232.c
> +++ b/drivers/iio/proximity/mb1232.c
> @@ -244,13 +244,13 @@ static const struct of_device_id of_mb1232_match[] =
=3D {
>  MODULE_DEVICE_TABLE(of, of_mb1232_match);
> =20
>  static const struct i2c_device_id mb1232_id[] =3D {
> -	{ "maxbotix-mb1202", },
> -	{ "maxbotix-mb1212", },
> -	{ "maxbotix-mb1222", },
> -	{ "maxbotix-mb1232", },
> -	{ "maxbotix-mb1242", },
> -	{ "maxbotix-mb7040", },
> -	{ "maxbotix-mb7137", },
> +	{ .name =3D "maxbotix-mb1202" },
> +	{ .name =3D "maxbotix-mb1212" },
> +	{ .name =3D "maxbotix-mb1222" },
> +	{ .name =3D "maxbotix-mb1232" },
> +	{ .name =3D "maxbotix-mb1242" },
> +	{ .name =3D "maxbotix-mb7040" },
> +	{ .name =3D "maxbotix-mb7137" },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, mb1232_id);
> diff --git a/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c b/drivers/=
iio/proximity/pulsedlight-lidar-lite-v2.c
> index 21336b8f122a..5e9e04540393 100644
> --- a/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
> +++ b/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
> @@ -319,8 +319,8 @@ static void lidar_remove(struct i2c_client *client)
>  }
> =20
>  static const struct i2c_device_id lidar_id[] =3D {
> -	{ "lidar-lite-v2" },
> -	{ "lidar-lite-v3" },
> +	{ .name =3D "lidar-lite-v2" },
> +	{ .name =3D "lidar-lite-v3" },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, lidar_id);
> diff --git a/drivers/iio/proximity/rfd77402.c b/drivers/iio/proximity/rfd=
77402.c
> index 81b8daf17a54..db1e94fc5658 100644
> --- a/drivers/iio/proximity/rfd77402.c
> +++ b/drivers/iio/proximity/rfd77402.c
> @@ -433,7 +433,7 @@ static DEFINE_SIMPLE_DEV_PM_OPS(rfd77402_pm_ops, rfd7=
7402_suspend,
>  				rfd77402_resume);
> =20
>  static const struct i2c_device_id rfd77402_id[] =3D {
> -	{ "rfd77402" },
> +	{ .name =3D "rfd77402" },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, rfd77402_id);
> diff --git a/drivers/iio/proximity/srf08.c b/drivers/iio/proximity/srf08.c
> index d7e4cc48cfbf..01328d155350 100644
> --- a/drivers/iio/proximity/srf08.c
> +++ b/drivers/iio/proximity/srf08.c
> @@ -533,9 +533,9 @@ static const struct of_device_id of_srf08_match[] =3D=
 {
>  MODULE_DEVICE_TABLE(of, of_srf08_match);
> =20
>  static const struct i2c_device_id srf08_id[] =3D {
> -	{ "srf02", SRF02 },
> -	{ "srf08", SRF08 },
> -	{ "srf10", SRF10 },
> +	{ .name =3D "srf02", .driver_data =3D SRF02 },
> +	{ .name =3D "srf08", .driver_data =3D SRF08 },
> +	{ .name =3D "srf10", .driver_data =3D SRF10 },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, srf08_id);
> diff --git a/drivers/iio/proximity/sx9310.c b/drivers/iio/proximity/sx931=
0.c
> index fb02eac78ed4..602f7b95c83e 100644
> --- a/drivers/iio/proximity/sx9310.c
> +++ b/drivers/iio/proximity/sx9310.c
> @@ -1007,8 +1007,8 @@ static const struct of_device_id sx9310_of_match[] =
=3D {
>  MODULE_DEVICE_TABLE(of, sx9310_of_match);
> =20
>  static const struct i2c_device_id sx9310_id[] =3D {
> -	{ "sx9310", (kernel_ulong_t)&sx9310_info },
> -	{ "sx9311", (kernel_ulong_t)&sx9311_info },
> +	{ .name =3D "sx9310", .driver_data =3D (kernel_ulong_t)&sx9310_info },
> +	{ .name =3D "sx9311", .driver_data =3D (kernel_ulong_t)&sx9311_info },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, sx9310_id);
> diff --git a/drivers/iio/proximity/sx9500.c b/drivers/iio/proximity/sx950=
0.c
> index 6c67bae7488c..dadce9b44227 100644
> --- a/drivers/iio/proximity/sx9500.c
> +++ b/drivers/iio/proximity/sx9500.c
> @@ -1025,7 +1025,7 @@ static const struct of_device_id sx9500_of_match[] =
=3D {
>  MODULE_DEVICE_TABLE(of, sx9500_of_match);
> =20
>  static const struct i2c_device_id sx9500_id[] =3D {
> -	{ "sx9500" },
> +	{ .name =3D "sx9500" },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, sx9500_id);
> diff --git a/drivers/iio/proximity/vl53l0x-i2c.c b/drivers/iio/proximity/=
vl53l0x-i2c.c
> index ad3e46d47fa8..21579331c6c3 100644
> --- a/drivers/iio/proximity/vl53l0x-i2c.c
> +++ b/drivers/iio/proximity/vl53l0x-i2c.c
> @@ -393,7 +393,7 @@ static int vl53l0x_probe(struct i2c_client *client)
>  }
> =20
>  static const struct i2c_device_id vl53l0x_id[] =3D {
> -	{ "vl53l0x" },
> +	{ .name =3D "vl53l0x" },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, vl53l0x_id);
> diff --git a/drivers/iio/proximity/vl53l1x-i2c.c b/drivers/iio/proximity/=
vl53l1x-i2c.c
> index 4d9cb3983dba..ff56bfcf8bd2 100644
> --- a/drivers/iio/proximity/vl53l1x-i2c.c
> +++ b/drivers/iio/proximity/vl53l1x-i2c.c
> @@ -730,7 +730,7 @@ static int vl53l1x_probe(struct i2c_client *client)
>  }
> =20
>  static const struct i2c_device_id vl53l1x_id[] =3D {
> -	{ "vl53l1x" },
> +	{ .name =3D "vl53l1x" },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, vl53l1x_id);
> diff --git a/drivers/iio/temperature/max30208.c b/drivers/iio/temperature=
/max30208.c
> index 720469f9dc36..6172abc6d533 100644
> --- a/drivers/iio/temperature/max30208.c
> +++ b/drivers/iio/temperature/max30208.c
> @@ -218,7 +218,7 @@ static int max30208_probe(struct i2c_client *i2c)
>  }
> =20
>  static const struct i2c_device_id max30208_id_table[] =3D {
> -	{ "max30208" },
> +	{ .name =3D "max30208" },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, max30208_id_table);
> diff --git a/drivers/iio/temperature/mcp9600.c b/drivers/iio/temperature/=
mcp9600.c
> index aa42c2b1a369..2091733738b7 100644
> --- a/drivers/iio/temperature/mcp9600.c
> +++ b/drivers/iio/temperature/mcp9600.c
> @@ -551,8 +551,8 @@ static const struct mcp_chip_info mcp9601_chip_info =
=3D {
>  };
> =20
>  static const struct i2c_device_id mcp9600_id[] =3D {
> -	{ "mcp9600", .driver_data =3D (kernel_ulong_t)&mcp9600_chip_info },
> -	{ "mcp9601", .driver_data =3D (kernel_ulong_t)&mcp9601_chip_info },
> +	{ .name =3D "mcp9600", .driver_data =3D (kernel_ulong_t)&mcp9600_chip_i=
nfo },
> +	{ .name =3D "mcp9601", .driver_data =3D (kernel_ulong_t)&mcp9601_chip_i=
nfo },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, mcp9600_id);
> diff --git a/drivers/iio/temperature/mlx90614.c b/drivers/iio/temperature=
/mlx90614.c
> index 1ad21b73e1b4..342f2e4f80d1 100644
> --- a/drivers/iio/temperature/mlx90614.c
> +++ b/drivers/iio/temperature/mlx90614.c
> @@ -699,8 +699,8 @@ static const struct mlx_chip_info mlx90615_chip_info =
=3D {
>  };
> =20
>  static const struct i2c_device_id mlx90614_id[] =3D {
> -	{ "mlx90614", .driver_data =3D (kernel_ulong_t)&mlx90614_chip_info },
> -	{ "mlx90615", .driver_data =3D (kernel_ulong_t)&mlx90615_chip_info },
> +	{ .name =3D "mlx90614", .driver_data =3D (kernel_ulong_t)&mlx90614_chip=
_info },
> +	{ .name =3D "mlx90615", .driver_data =3D (kernel_ulong_t)&mlx90615_chip=
_info },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, mlx90614_id);
> diff --git a/drivers/iio/temperature/mlx90632.c b/drivers/iio/temperature=
/mlx90632.c
> index b44f7036c2cc..3ab7687c4146 100644
> --- a/drivers/iio/temperature/mlx90632.c
> +++ b/drivers/iio/temperature/mlx90632.c
> @@ -1276,7 +1276,7 @@ static int mlx90632_probe(struct i2c_client *client)
>  }
> =20
>  static const struct i2c_device_id mlx90632_id[] =3D {
> -	{ "mlx90632" },
> +	{ .name =3D "mlx90632" },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, mlx90632_id);
> diff --git a/drivers/iio/temperature/mlx90635.c b/drivers/iio/temperature=
/mlx90635.c
> index 1c8948ca54df..8c8bdab106dd 100644
> --- a/drivers/iio/temperature/mlx90635.c
> +++ b/drivers/iio/temperature/mlx90635.c
> @@ -1026,7 +1026,7 @@ static int mlx90635_probe(struct i2c_client *client)
>  }
> =20
>  static const struct i2c_device_id mlx90635_id[] =3D {
> -	{ "mlx90635" },
> +	{ .name =3D "mlx90635" },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, mlx90635_id);
> diff --git a/drivers/iio/temperature/tmp006.c b/drivers/iio/temperature/t=
mp006.c
> index d8d8c8936d17..9939b9cd4796 100644
> --- a/drivers/iio/temperature/tmp006.c
> +++ b/drivers/iio/temperature/tmp006.c
> @@ -391,7 +391,7 @@ static const struct of_device_id tmp006_of_match[] =
=3D {
>  MODULE_DEVICE_TABLE(of, tmp006_of_match);
> =20
>  static const struct i2c_device_id tmp006_id[] =3D {
> -	{ "tmp006" },
> +	{ .name =3D "tmp006" },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, tmp006_id);
> diff --git a/drivers/iio/temperature/tmp007.c b/drivers/iio/temperature/t=
mp007.c
> index 043283b02c4d..d9eea06ff540 100644
> --- a/drivers/iio/temperature/tmp007.c
> +++ b/drivers/iio/temperature/tmp007.c
> @@ -563,7 +563,7 @@ static const struct of_device_id tmp007_of_match[] =
=3D {
>  MODULE_DEVICE_TABLE(of, tmp007_of_match);
> =20
>  static const struct i2c_device_id tmp007_id[] =3D {
> -	{ "tmp007" },
> +	{ .name =3D "tmp007" },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, tmp007_id);
> diff --git a/drivers/iio/temperature/tmp117.c b/drivers/iio/temperature/t=
mp117.c
> index 8972083d903a..6bc18616ad15 100644
> --- a/drivers/iio/temperature/tmp117.c
> +++ b/drivers/iio/temperature/tmp117.c
> @@ -209,8 +209,8 @@ static const struct of_device_id tmp117_of_match[] =
=3D {
>  MODULE_DEVICE_TABLE(of, tmp117_of_match);
> =20
>  static const struct i2c_device_id tmp117_id[] =3D {
> -	{ "tmp116", (kernel_ulong_t)&tmp116_channels_info },
> -	{ "tmp117", (kernel_ulong_t)&tmp117_channels_info },
> +	{ .name =3D "tmp116", .driver_data =3D (kernel_ulong_t)&tmp116_channels=
_info },
> +	{ .name =3D "tmp117", .driver_data =3D (kernel_ulong_t)&tmp117_channels=
_info },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, tmp117_id);
> diff --git a/drivers/iio/temperature/tsys01.c b/drivers/iio/temperature/t=
sys01.c
> index 334bba6fdae6..92c73369b06f 100644
> --- a/drivers/iio/temperature/tsys01.c
> +++ b/drivers/iio/temperature/tsys01.c
> @@ -206,7 +206,7 @@ static int tsys01_i2c_probe(struct i2c_client *client)
>  }
> =20
>  static const struct i2c_device_id tsys01_id[] =3D {
> -	{ "tsys01" },
> +	{ .name =3D "tsys01" },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, tsys01_id);
> diff --git a/drivers/iio/temperature/tsys02d.c b/drivers/iio/temperature/=
tsys02d.c
> index 0cad27205667..3ef72347456e 100644
> --- a/drivers/iio/temperature/tsys02d.c
> +++ b/drivers/iio/temperature/tsys02d.c
> @@ -168,7 +168,7 @@ static int tsys02d_probe(struct i2c_client *client)
>  }
> =20
>  static const struct i2c_device_id tsys02d_id[] =3D {
> -	{ "tsys02d" },
> +	{ .name =3D "tsys02d" },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, tsys02d_id);

