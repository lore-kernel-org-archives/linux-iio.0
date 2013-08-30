Return-Path: <lee.jones@linaro.org>
Date: Fri, 30 Aug 2013 09:07:34 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Denis CIOCCA <denis.ciocca@st.com>
Cc: Lukasz Czerwinski <l.czerwinski@samsung.com>,
	"jic23@kernel.org" <jic23@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>
Subject: Re: [PATCH 0/4]iio: STMicroelectronics DT and event support
Message-ID: <20130830080734.GF23998@lee--X1>
References: <1372767338-13179-1-git-send-email-l.czerwinski@samsung.com>
 <521F67CF.4060702@st.com>
 <20130830070628.GE23998@lee--X1>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20130830070628.GE23998@lee--X1>
List-ID: <linux-iio@vger.kernel.org>

> > + Lee Jones in the loop.
> 
> I missed out on these because they weren't sent to LKML. Please ensure
> you always CC any patches due for Mainline there too. I have some
> things to say about these patches, but can't as they're not in my
> inbox. When you send them again, can you CC both LKML and myself
> please?

Oh, and you need to use the new address for the DT ML too.

> > On 07/02/2013 02:15 PM, Lukasz Czerwinski wrote:
> > > Hi,
> > >
> > > This is the patchset that adds device tree and event subsytem support
> > > for generic st_common library.
> > >
> > > I tested our patches with Exynos4x12 board. We tested sensors:
> > > - LSM330DLC accelerometer and gyroscope (I2C)
> > > - LPS331AP pressure sensor (I2C)
> > >
> > > Generally it works fine.
> > > I couldn't implement event patch for lsm330dlc gyroscope because I
> > > don't have connected INT1 pin to SoC.
> > >
> > > My implementation allows to use event system or triggered buffer by
> > > proper declaration of irqs in device tree/platform data.
> > >
> > > Jacek Anaszewski (1):
> > >    iio: lps331ap: Add support for DT
> > >
> > > Lukasz Czerwinski (3):
> > >    iio: st_sensors:  Add DT bindings for st_accel and st_gyro
> > >    iio: st_sensors: Add threshold events support
> > >    iio: accel: Add event subsystem to st_accel driver
> > >
> > >   .../bindings/iio/accelerometer/st_accel.txt        |   54 +++++
> > >   .../devicetree/bindings/iio/gyroscope/st_gyro.txt  |   51 +++++
> > >   .../bindings/iio/pressure/st_pressure.txt          |   41 ++++
> > >   drivers/iio/accel/st_accel.h                       |   19 +-
> > >   drivers/iio/accel/st_accel_core.c                  |  159 +++++++++++++-
> > >   drivers/iio/accel/st_accel_i2c.c                   |   19 +-
> > >   drivers/iio/accel/st_accel_spi.c                   |   19 +-
> > >   drivers/iio/common/st_sensors/st_sensors_core.c    |  225 +++++++++++++++++++-
> > >   drivers/iio/common/st_sensors/st_sensors_i2c.c     |   59 ++++-
> > >   drivers/iio/common/st_sensors/st_sensors_spi.c     |   59 ++++-
> > >   drivers/iio/gyro/st_gyro.h                         |   15 +-
> > >   drivers/iio/gyro/st_gyro_core.c                    |    8 +-
> > >   drivers/iio/gyro/st_gyro_i2c.c                     |   18 +-
> > >   drivers/iio/gyro/st_gyro_spi.c                     |   18 +-
> > >   drivers/iio/magnetometer/st_magn.h                 |    3 +-
> > >   drivers/iio/magnetometer/st_magn_core.c            |    5 +-
> > >   drivers/iio/magnetometer/st_magn_i2c.c             |    2 +-
> > >   drivers/iio/magnetometer/st_magn_spi.c             |    2 +-
> > >   drivers/iio/pressure/st_pressure.h                 |    3 +-
> > >   drivers/iio/pressure/st_pressure_core.c            |   12 +-
> > >   drivers/iio/pressure/st_pressure_i2c.c             |   11 +-
> > >   drivers/iio/pressure/st_pressure_spi.c             |   11 +-
> > >   include/linux/iio/common/st_sensors.h              |   88 +++++++-
> > >   include/linux/platform_data/st_sensors_pdata.h     |    2 +
> > >   24 files changed, 837 insertions(+), 66 deletions(-)
> > >   create mode 100644 Documentation/devicetree/bindings/iio/accelerometer/st_accel.txt
> > >   create mode 100644 Documentation/devicetree/bindings/iio/gyroscope/st_gyro.txt
> > >   create mode 100644 Documentation/devicetree/bindings/iio/pressure/st_pressure.txt
> > >
> 

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
