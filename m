Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:48736 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752541AbcEAVZy (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 1 May 2016 17:25:54 -0400
Subject: Re: [RFC 0/7] iio: inv_mpu6050: Support i2c master and external
 readings
To: Crestez Dan Leonard <leonard.crestez@intel.com>,
	linux-iio@vger.kernel.org
References: <cover.1461953982.git.leonard.crestez@intel.com>
Cc: linux-kernel@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Daniel Baluta <daniel.baluta@intel.com>,
	Ge Gao <GGao@invensense.com>, Peter Rosin <peda@axentia.se>,
	Mark Brown <broonie@kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <f22534df-13b5-0889-66d7-e4fb7f480f00@kernel.org>
Date: Sun, 1 May 2016 18:04:08 +0100
MIME-Version: 1.0
In-Reply-To: <cover.1461953982.git.leonard.crestez@intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 29/04/16 20:02, Crestez Dan Leonard wrote:
> This series attempts to implement support for external readings in i2c master
> mode. I don't expect this to go in this form but I wanted to present a
> functional version in order to start the discussion earlier.
> 
> 
> The I2C master support is useful even without external readings. For example in
> SPI mode this is the only way to contact auxiliary devices. Differences from
> the previous version:
>  - Require an explicit "inv,i2c-aux-master" bool property. Supporting dynamic
> switches between bypass/master mode is extremely difficult and not really
> worthwhile. Switching to bypass mode requires explicitly disabling all i2c
> master functionality, including external readings! After Peter Rosin's mux
> cleanup patches go in I would like to disable the mux entirely when in master
> mode.
>  - Describe i2c clients behind i2c@1. Maybe it should be i2c@0 like mux mode?
>  - Validate parameters and return an error on unsupported ops (like read_word)
>  - Wait for SLV4_DONE even on writes!
>  - Fix issues when other parts of the driver write to the same registers.
> 
> My initial idea was to use regcache and regmap_update_bits to handle config
> bits like in PATCH 2. It turn out that the device has several registers with a
> combination of volatile "command bits" (writing triggers an action) and "config
> bits" (value must normally be preserved). This requires manually storing the
> state of those config bits in "chip_config". I could try to make do without
> regcache support, even though it offers some advantages.
If you were to break these registers up into regmap fields it might solve 
this..  Regmap writes always go through whatever - whether they match the
existing state of the cache or not.  If fields are involved the write will get
built up from whatever field you change and whatever the cache has for other
elements.  I guess it only works if they volatile bits are contiguous though.
Maybe hand rolling it is cleaner here.

Mark, any clever thoughts on this?
> 
>
> Support for external sensors is rather nasty. What it does is dynamically copy
> iio_chan_spec from the slave device and register it for itself (with an updated
> scan index). Then it forwards everything but IIO_CHAN_INFO_RAW to the other
> driver while serving raw value requests from the MPU's own registers.
> 
> The original device is still registered with linux as a normal driver and works
> normally and you can poke at it to configure stuff like sample rates and
> scaling factors. You can read the same samples from the slaved device, just
> slower. For example:
> 	cat /sys/bus/iio/devices/iio:device1/in_magn_*_raw
> will be slower than:
> 	cat /sys/bus/iio/devices/iio:device0/in_magn_*_raw
> In the first case values are read through SLV4, byte-by-byte. In the second
> they are served directly from EXT_SENS_DATA_* registers.
ouch
> 
> In theory the ak8975 inside mpu9150 could be supported as a slave device but
> that requires further work. Unlike the hmc5883l I've been testing with that
> sensor does not update automatically by default. This means that the mpu6050
> buffer code must call a function from that driver to "enable automatic updates"
> somehow. For example this could be implemented as an additional bufferop?
That's hideous, but sure I guess we could have such an op.
> 
> So far this works surprisingly well without any changes in the iio core or
> drivers for aux devices. But perhaps "external channels" should be listed in
> struct iio_dev and a special marking should be done for iio_chan_spec's which
> can accessed this way.
> 
> External/slaved channels are limited to 16bits because it would otherwise be
> difficult to comply with iio alignment requirements. Support for other channel
> sizes should be implemented separately. There should be a separate discussion
> for how to properly support driver-specified channel offsets instead of
> implicit iio rules.
hmm. You'd need to give more detail on what sort of alignments we are looking at.
It might just be a case of the driver having to do a bit of memcpy magic to 
'fix up' the alignment being read from the device. 
> 
> Patches 1,2,3,4 and 6 are required cleanups/fixed to make the rest work. They
> could go in separately.
> 
> Crestez Dan Leonard (7):
>   iio: inv_mpu6050: Do burst reads using spi/i2c directly
>   iio: inv_mpu6050: Initial regcache support
>   iio: inv_mpu6050: Only toggle DATA_RDY_EN in inv_reset_fifo
>   iio: inv_mpu6050: Cache non-volatile bits of user_ctrl
>   iio: inv_mpu6050: Add support for auxiliary I2C master
>   iio: inv_mpu6050: Check channel configuration on preenable
>   iio: inv_mpu6050: Add support for external sensors
> 
>  .../devicetree/bindings/iio/imu/inv_mpu6050.txt    |  96 ++-
>  drivers/iio/imu/inv_mpu6050/inv_mpu_core.c         | 708 ++++++++++++++++++++-
>  drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c          |   5 -
>  drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h          | 116 +++-
>  drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c         | 134 +++-
>  drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c          |   5 -
>  drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c      |  15 +-
>  7 files changed, 1029 insertions(+), 50 deletions(-)
> 

