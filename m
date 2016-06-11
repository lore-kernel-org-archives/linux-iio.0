Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:52674 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751182AbcFKRgE (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 11 Jun 2016 13:36:04 -0400
Subject: Re: [RFC PATCH v1 0/9] iio:st_sensors: fixes and lps22hb pressure
 sensor
To: Gregor Boirie <gregor.boirie@parrot.com>, linux-iio@vger.kernel.org
References: <cover.1461056711.git.gregor.boirie@parrot.com>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Denis Ciocca <denis.ciocca@st.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Giuseppe Barba <giuseppe.barba@st.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <d1252690-0d4f-df04-5e7a-128ce7ecdc97@kernel.org>
Date: Sat, 11 Jun 2016 18:36:00 +0100
MIME-Version: 1.0
In-Reply-To: <cover.1461056711.git.gregor.boirie@parrot.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 19/04/16 10:18, Gregor Boirie wrote:
> This preliminary patch series adds support for a new ST LPS22HB pressure sensor
> and introduce a few fixes related to st_pressure core and st_sensors triggered
> buffering.
> It is not meant to be reviewed for definitive inclusion as it touches too many
> drivers / devices I cannot test with.
> Note that as a few minor and more controversial patches (7, 8 and 9) might also
> be candidate for a seperate series.
> 
> Patch 2 makes st_pressure sensors compliant with ABI and fixes a few missing
> sampling gains. Scale / offset computation is modified to address all gains
> currently possible. It impacts LPS331AP, LPS001WP and LPS25H sensors.
> Please please please ! If anyone owning one of these could run some tests, I'd
> be glad to get some feedback since I have none of them.
> 
> Patch 4 is a rework of the way st_sensors samples are stored in memory to comply
> with IIO expected alignment contraints (some st_pressure samples are 24 bits
> long). It is heavily based upon Linux Walleij' approach where each channel is
> captured individually. See http://www.spinics.net/lists/linux-iio/msg24028.html
> and http://www.spinics.net/lists/linux-iio/msg23598.html threads for more infos.
> This patch impacts all st_sensors.
> Please please please ! If anyone owning one of these could run some tests...
> 
> Patch 5 enforces 32 bits storage alignment for 24 bits long st_pressure
> sampling channels.
> Patch 6 enables triggered buffering for st_pressure temperature channels. We
> need temperature samples to control on-board device temperature (noise and
> drift removal).
> Both patches impact st_pressure sensors mentionned above. Please please please !
> If anyone owning one of these could run some tests...
> 
> Regards,
> gregor.
> 
Hi Gregor,

This series has now drifted out of my active list. Hope you get time
to respond to the various minor issues as would be great to get the
remainder of these in place!

Not to worry if it will be a while.

Thanks,

Jonathan
> Gregor Boirie (9):
>   iio:st_pressure:initial lps22hb sensor support
>   iio:st_pressure: fix sampling gains
>   iio:st_pressure: lps22hb temperature support
>   iio:st_sensors: align on storagebits boundaries
>   iio:st_pressure: align storagebits on power of 2
>   iio:st_pressure: temperature triggered buffering
>   iio:st_sensors: unexport st_sensors_get_buffer_element
>   iio:st_sensors: emulate SMBus block read if needed
>   iio:st_sensors: fix power regulator usage
> 
>  .../devicetree/bindings/iio/st-sensors.txt         |   1 +
>  drivers/iio/accel/st_accel_core.c                  |  12 +-
>  drivers/iio/common/st_sensors/st_sensors_buffer.c  |  41 ++--
>  drivers/iio/common/st_sensors/st_sensors_core.c    |  31 ++-
>  drivers/iio/common/st_sensors/st_sensors_i2c.c     |   4 +-
>  drivers/iio/gyro/st_gyro_core.c                    |  12 +-
>  drivers/iio/magnetometer/st_magn_core.c            |  12 +-
>  drivers/iio/pressure/Kconfig                       |   2 +-
>  drivers/iio/pressure/st_pressure.h                 |   1 +
>  drivers/iio/pressure/st_pressure_core.c            | 250 ++++++++++++++++-----
>  drivers/iio/pressure/st_pressure_i2c.c             |   4 +
>  drivers/iio/pressure/st_pressure_spi.c             |   1 +
>  include/linux/iio/common/st_sensors.h              |   4 +-
>  13 files changed, 278 insertions(+), 97 deletions(-)
> 

