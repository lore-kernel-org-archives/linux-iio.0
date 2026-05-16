Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D03F48460;
	Sat, 16 May 2026 15:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778944085; cv=none; b=TQBs/WkGM8N7aJyXhbZZn/RJ6tVA8BTksbBz360P0p0yyr+p92jb/NMTtEkKJv3sCUEcsszQ2TM9fo2kwmFO9kZYzxKqasukVKFBwtyAIF6IPSS4azlCrRM4MxiZzLn5uY+ak7eqezGdWf8l4qRdARuD9Oe3u+PpcGel3CVtw2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778944085; c=relaxed/simple;
	bh=jho9MdaE5yAkm0BJknveYPFKVoDYTuZ4VchAhGg/BK4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oCR0YUhb+hEVuCNjWnC6pX4rmeQlM63nX1W/0yYUUGWxANf10wgyPebFeRdO50ujXhwh2v7TkGXBd2aw5wjeD4L5wRoRLJMChs+Fu07xD9S8Bi8+ZkkrQpOiRehCFpRxxDmfcSVBs/KqQke6vwgtgWvm9qWr5l1y8menHitWfv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n0LfOzIm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n0LfOzIm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 505AEC19425;
	Sat, 16 May 2026 15:07:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778944085;
	bh=jho9MdaE5yAkm0BJknveYPFKVoDYTuZ4VchAhGg/BK4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=n0LfOzImIclfoGNYZLw0Gsjg8a8TTDP/OnSDzlX9OwzLL+qHTlOF7LZGcMStxaVKc
	 k5pv/PQ0Iiwsa39jk8JStUBycGHary6q0rlul+LooZe5TsoC2BbcJg09HoJQUwIAjR
	 MXy2Y6ZTWGndxP6JUIczhTyx6Ul/oMXsth4II/hgXDyY80kcVkVwsPqjaGHCgtYaen
	 soyuWtA+E1oEPqW92MfQA8WSwPZNS/vTdOUvCT5lua+ncepOkWRZkjwdLU9X73sWVi
	 ou/4T/WGXrmNxPACe+fZY/P8Em4TRg4fz20Vw8P1+LbfcihRoI/Ez6uRi2s57z+xZI
	 tkgwnBuFvSo8w==
Date: Sat, 16 May 2026 16:07:54 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Chris Morgan <macromorgan@hotmail.com>
Cc: Chris Morgan <macroalpha82@gmail.com>, linux-iio@vger.kernel.org,
 andy@kernel.org, nuno.sa@analog.com, dlechner@baylibre.com,
 jean-baptiste.maneyrol@tdk.com, linux-rockchip@lists.infradead.org,
 devicetree@vger.kernel.org, heiko@sntech.de, conor+dt@kernel.org,
 krzk+dt@kernel.org, robh@kernel.org, andriy.shevchenko@intel.com
Subject: Re: [PATCH V7 03/11] iio: imu: inv_icm42607: Add inv_icm42607 Core
 Driver
Message-ID: <20260516160754.08e8e2e4@jic23-huawei>
In-Reply-To: <DS4PR19MB997335152F245D758A97162671A5052@DS4PR19MB997335.namprd19.prod.outlook.com>
References: <20260515130018.237378-1-macroalpha82@gmail.com>
	<20260515130018.237378-4-macroalpha82@gmail.com>
	<20260515193102.123b664a@jic23-huawei>
	<DS4PR19MB997335152F245D758A97162671A5052@DS4PR19MB997335.namprd19.prod.outlook.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 15 May 2026 20:51:01 -0500
Chris Morgan <macromorgan@hotmail.com> wrote:

> On Fri, May 15, 2026 at 07:31:02PM +0100, Jonathan Cameron wrote:
> > On Fri, 15 May 2026 08:00:08 -0500
> > Chris Morgan <macroalpha82@gmail.com> wrote:
> >   
> > > From: Chris Morgan <macromorgan@hotmail.com>
> > > 
> > > Add the core component of a new inv_icm42607 driver. This includes
> > > a few setup functions and the full register definition in the
> > > header file.
> > > 
> > > Signed-off-by: Chris Morgan <macromorgan@hotmail.com>  
> > 
> > Sashiko led you into the weeks with irq request return values.
> > It was less broken in v6 :(
> > 
> > As to it's other comments on checking for line high/low values (0x00 / 0xFF)
> > for whoami is something we don't normally bother with but you could if you like.
> > I'm fairly sure we've had both those values turn up as valid in some devices
> > in the past.
> > 
> > Otherwise just trivial stuff I noticed whilst having a fresh read through.
> > All stuff I might have tweaked whilst applying or just let through but
> > seeing as you are going to be doing a v8, please take a look.
> > 
> > Jonathan  
> 
> I think I'll ignore that comment about the high-low values, but it does make
> valid points about using the wrong call to invalidate the regmap cache and
> also the wrong call to set the SPI_MODE_3 stuff.
> 
> All in all I'll try to post another version in another day or two with the
> recommended fixes (as best I can) and see if it still complains. I'm expecting
> a few complaints like the 0x00/0xFF or some stuff about "keeping the temp sensor
> enabled" which is a non-issue per the datasheet. Hopefully I'm near the finish
> line either way.
> 
Yup. It's a useful tool but not perfect!

> > 
> >   
> > > ---
> > >  drivers/iio/imu/inv_icm42607/inv_icm42607.h   | 334 ++++++++++++++++++
> > >  .../iio/imu/inv_icm42607/inv_icm42607_core.c  | 207 +++++++++++
> > >  2 files changed, 541 insertions(+)
> > >  create mode 100644 drivers/iio/imu/inv_icm42607/inv_icm42607.h
> > >  create mode 100644 drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
> > > 
> > > diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607.h b/drivers/iio/imu/inv_icm42607/inv_icm42607.h
> > > new file mode 100644
> > > index 000000000000..1916e0b08bca
> > > --- /dev/null
> > > +++ b/drivers/iio/imu/inv_icm42607/inv_icm42607.h

> >   
> > > +/* Sleep times required by the driver */
> > > +#define INV_ICM42607_POWER_UP_TIME_US			100000
> > > +#define INV_ICM42607_RESET_TIME_MS			1
> > > +#define INV_ICM42607_ACCEL_STARTUP_TIME_MS		20
> > > +#define INV_ICM42607_GYRO_STARTUP_TIME_MS		60
> > > +#define INV_ICM42607_GYRO_STOP_TIME_MS			150
> > > +#define INV_ICM42607_TEMP_STARTUP_TIME_MS		14
> > > +#define INV_ICM42607_SUSPEND_DELAY_MS			2000  
> > 
> > Can we have spec references for these?  We often hit problems later
> > with devices that are a little bit slow and no one is sure if it's because
> > the sleeps are wrong or device is actually out of spec. Hence
> > it is useful to be able to quickly check these.  
> 
> I took these from the driver I basically copied wholesale and changed
> the registers for according to the datasheet, but I didn't take a very
> close look at these (which I am now).
> 
> The POWER_UP_TIME_US, assuming it's the same as "Supply Ramp Time" from
> the datasheet is 100ms which matches. Likewise, the "Start-up time for
> register read/write" listed under "Power-On Reset" shows 1ms, which
> matches.
> 
> The ACCEL_STARTUP_TIME_MS should probably be 10ms, and the
> GYRO_STARTUP_TIME_MS should probably be 30ms. I don't see a startup
> time listed for the temperature sensor but I do see "Stabilization
> Time" which lists 77us. Gyro stop time and suspend delay time I cannot
> find a reference for... logically if those values are needed I think
> they should likely be the same as the gyro start time and power up
> time, respectively right?

Stops tend to be pretty quick as no need to wait for stuff to stabilize.
It's pretty rare to have a value for them - however, I guess if there
was one in the driver maybe just add a comment that says 'from driver
+ link'.

> 
> The values I am referencing now appear under the electrical
> characteristics section (section 3) of the datasheet for both the
> icm42607p (my test devices, over i2c) and the icm42607(c).
> 
Nice.

> > > +static int inv_icm42607_setup(struct inv_icm42607_state *st,
> > > +			      inv_icm42607_bus_setup bus_setup)
> > > +{
> > > +	const struct device *dev = regmap_get_device(st->map);
> > > +	unsigned int val;
> > > +	int ret;
> > > +
> > > +	ret = regmap_read(st->map, INV_ICM42607_REG_WHOAMI, &val);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	if (val != st->hw->whoami)
> > > +		dev_warn(dev, "invalid whoami %#02x expected %#02x (%s)\n",
> > > +			 val, st->hw->whoami, st->hw->name);
> > > +
> > > +	ret = regmap_write(st->map, INV_ICM42607_REG_SIGNAL_PATH_RESET,
> > > +			   INV_ICM42607_SIGNAL_PATH_RESET_SOFT_RESET);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	fsleep(1000);  
> > 
> > Do we need an explicit sleep here, or is the idea just to save on
> > a read that can't succeed in the poll that follows?  I'd be tempted
> > to drop this if it's not absolutely needed just to avoid explaining it.
> > This isn't fast path code. If we need to leave the device alone after
> > reset for a bit then a datasheet reference is needed.
> >   
> 
> Data sheet only really says that the time required after a *hard* reset
> is 1ms, it honestly doesn't say anything about a soft reset.
> 
> I also thought I got rid of the read_poll_timeout, since I'm already
> waiting 1ms... if you think this fsleep is needed or not I'll defer
> to you.
If you are sleeping long enough a single check + fail if not ready is fine.

> 
> Honestly this whole path thing got messed up when we wanted to code for
> 3 wire SPI. For 3 wire I need to make sure I enable it as soon as the reset
> completes, so it's probably not even right here. I need to add bus_setup()
> before the read not after. So to support 3-wire it needs to go:
> bus_setup()
> whoami check
> reset
> wait (maybe)
> bus_setup() again
> check int_status (if we can after the bus_setup)
> do the rest
> 
> whereas if we explicitly say no 3-wire then we can drop the first bus setup
> and use regmap_read_poll_timeout to get the status.

Can do no 3 wire initially as long as we check for dt-binding and error
out with a helpful message.  It'll be a feature someone else can figure
out how to add later.


> 
> >   
> > > +
> > > +	st = devm_kzalloc(dev, sizeof(*st), GFP_KERNEL);
> > > +	if (!st)
> > > +		return -ENOMEM;  
> >   
> 
> I sincerely appreciate all your help on this. Here I was thinking this would
> be easy and I could focus on a joystick/LED driver next... how wrong I was!

IMUs are about as hard as it gets for sensors!  This one is far from the most complex, but
none the less there are a lot of things going on.

Jonathan

> 
> Chris

