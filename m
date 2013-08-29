Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from eu1sys200aog119.obsmtp.com ([207.126.144.147]:55039 "EHLO
	eu1sys200aog119.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753117Ab3H2PZW convert rfc822-to-8bit
	(ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Thu, 29 Aug 2013 11:25:22 -0400
From: Denis CIOCCA <denis.ciocca@st.com>
To: Lukasz Czerwinski <l.czerwinski@samsung.com>,
	lee Jones <lee.jones@linaro.org>
Cc: "jic23@kernel.org" <jic23@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"devicetree-discuss@lists.ozlabs.org"
	<devicetree-discuss@lists.ozlabs.org>
Date: Thu, 29 Aug 2013 17:25:03 +0200
Subject: Re: [PATCH 0/4]iio: STMicroelectronics DT and event support
Message-ID: <521F67CF.4060702@st.com>
References: <1372767338-13179-1-git-send-email-l.czerwinski@samsung.com>
In-Reply-To: <1372767338-13179-1-git-send-email-l.czerwinski@samsung.com>
Content-Type: text/plain; charset=US-ASCII
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

+ Lee Jones in the loop.

BR,
Denis


On 07/02/2013 02:15 PM, Lukasz Czerwinski wrote:
> Hi,
>
> This is the patchset that adds device tree and event subsytem support
> for generic st_common library.
>
> I tested our patches with Exynos4x12 board. We tested sensors:
> - LSM330DLC accelerometer and gyroscope (I2C)
> - LPS331AP pressure sensor (I2C)
>
> Generally it works fine.
> I couldn't implement event patch for lsm330dlc gyroscope because I
> don't have connected INT1 pin to SoC.
>
> My implementation allows to use event system or triggered buffer by
> proper declaration of irqs in device tree/platform data.
>
> Jacek Anaszewski (1):
>    iio: lps331ap: Add support for DT
>
> Lukasz Czerwinski (3):
>    iio: st_sensors:  Add DT bindings for st_accel and st_gyro
>    iio: st_sensors: Add threshold events support
>    iio: accel: Add event subsystem to st_accel driver
>
>   .../bindings/iio/accelerometer/st_accel.txt        |   54 +++++
>   .../devicetree/bindings/iio/gyroscope/st_gyro.txt  |   51 +++++
>   .../bindings/iio/pressure/st_pressure.txt          |   41 ++++
>   drivers/iio/accel/st_accel.h                       |   19 +-
>   drivers/iio/accel/st_accel_core.c                  |  159 +++++++++++++-
>   drivers/iio/accel/st_accel_i2c.c                   |   19 +-
>   drivers/iio/accel/st_accel_spi.c                   |   19 +-
>   drivers/iio/common/st_sensors/st_sensors_core.c    |  225 +++++++++++++++++++-
>   drivers/iio/common/st_sensors/st_sensors_i2c.c     |   59 ++++-
>   drivers/iio/common/st_sensors/st_sensors_spi.c     |   59 ++++-
>   drivers/iio/gyro/st_gyro.h                         |   15 +-
>   drivers/iio/gyro/st_gyro_core.c                    |    8 +-
>   drivers/iio/gyro/st_gyro_i2c.c                     |   18 +-
>   drivers/iio/gyro/st_gyro_spi.c                     |   18 +-
>   drivers/iio/magnetometer/st_magn.h                 |    3 +-
>   drivers/iio/magnetometer/st_magn_core.c            |    5 +-
>   drivers/iio/magnetometer/st_magn_i2c.c             |    2 +-
>   drivers/iio/magnetometer/st_magn_spi.c             |    2 +-
>   drivers/iio/pressure/st_pressure.h                 |    3 +-
>   drivers/iio/pressure/st_pressure_core.c            |   12 +-
>   drivers/iio/pressure/st_pressure_i2c.c             |   11 +-
>   drivers/iio/pressure/st_pressure_spi.c             |   11 +-
>   include/linux/iio/common/st_sensors.h              |   88 +++++++-
>   include/linux/platform_data/st_sensors_pdata.h     |    2 +
>   24 files changed, 837 insertions(+), 66 deletions(-)
>   create mode 100644 Documentation/devicetree/bindings/iio/accelerometer/st_accel.txt
>   create mode 100644 Documentation/devicetree/bindings/iio/gyroscope/st_gyro.txt
>   create mode 100644 Documentation/devicetree/bindings/iio/pressure/st_pressure.txt
>
