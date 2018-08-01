Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:51666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727608AbeHAVQg (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 1 Aug 2018 17:16:36 -0400
Date: Wed, 1 Aug 2018 20:29:15 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: gregkh@linuxfoundation.org, linux-iio@vger.kernel.org
Subject: Re: [PULL V2] 3rd set of new IIO device support, features, cleanups
 and  fixes for the 4.19 cycle.
Message-ID: <20180801202915.446d7c68@archlinux>
In-Reply-To: <20180801195415.5e6cfbbe@archlinux>
References: <20180801195415.5e6cfbbe@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

And now I think I managed to send it with a stray . on the end of linux-iio=
@vger.kernel.org
It's clearly one of those days.

On Wed, 1 Aug 2018 19:54:15 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> The following changes since commit 6d4abf1c0e265d8e99c155b91c1cf44e37793e=
53:
>=20
>   staging: axis-fifo: fix return value check in axis_fifo_probe() (2018-0=
7-28 09:26:31 +0200)
>=20
> are available in the Git repository at:
>=20
>   git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fo=
r-4.19c
>=20
> for you to fetch changes up to 496fb59e1274086d0c67681fb1369e9941660dd9:
>=20
>   iio: light: si1133: fix uninitialized resp variable (2018-08-01 19:01:3=
5 +0100)
>=20
> ----------------------------------------------------------------
> Third set of IIO new device support, cleanups and features for the 4.19 c=
ycle.
>=20
> This is a somewhat sneaky late pull request given Linus has announced
> a likely 1 week delay.  If it is too late I'll resend after the merge
> window.  I merged in the fixes branch as those are primarily around
> things queued for the merge window.
>=20
> Particulary good to see the output of our Himanshu Jha, a GSOC student
> who developed the bme680 driver.
>=20
> New device support:
> * bme680 gas sensor (with temperature, humidity and pressure)
>   - new driver to support this device
> * vcn4000
>   - support vcnl4200 (lots of rework to allow this)
>   - ids added for VCNL4010 and VCNL4020 sensors
>=20
> New features:
> * ad9523
>   - support the various external signal options via gpios.
>=20
> Cleanups and fixes
> * ad_sigma_delta
>   - unsigned long for a timeout.
> * ad9523
>   - fix a wrong return value that was indicating successful write failed
>     and might lead to an infinite loop.
> * si1133
>   - fix an impossible test.
>   - fix an uninitialsed variable by reading from the device in all paths.
> * xilinx xadc
>   - check for return values in clk related functions
>   - limit the pcap clock frequency to supported ranges.
>   - stash the irq to avoid calling platform_get_irq from the remove path.
>   - ensure the irq is actually requested before we enable the hardware to
>     output it.
>=20
> ----------------------------------------------------------------
> Colin Ian King (1):
>       iio: light: si1133 fix test for val being not zero or not one.
>=20
> Himanshu Jha (1):
>       iio: chemical: Add support for Bosch BME680 sensor
>=20
> Jonathan Cameron (1):
>       Merge branch 'fixes-togreg' into togreg
>=20
> Lars-Peter Clausen (1):
>       iio: ad9523: Fix return value for ad952x_store()
>=20
> Manish Narani (4):
>       iio: adc: xilinx: Check for return values in clk related functions
>       iio: adc: xilinx: limit pcap clock frequency value
>       iio: adc: xilinx: Remove platform_get_irq from xadc_remove function
>       iio: adc: xilinx: Move request_irq before enabling interrupts
>=20
> Maxime Roussin-B=C3=A9langer (1):
>       iio: light: si1133: fix uninitialized resp variable
>=20
> Michael Hennerich (1):
>       iio: ad9523: support for external signals via gpios
>=20
> Nicholas Mc Guire (1):
>       iio: ad_sigma_delta: use unsigned long for timeout
>=20
> Tomas Novotny (4):
>       iio: vcnl4000: make the driver extendable
>       iio: vcnl4000: add VCNL4010 and VCNL4020 device id
>       iio: vcnl4000: warn on incorrectly specified device id
>       iio: vcnl4000: add support for VCNL4200
>=20
>  drivers/iio/adc/ad_sigma_delta.c   |   5 +-
>  drivers/iio/adc/xilinx-xadc-core.c |  40 +-
>  drivers/iio/adc/xilinx-xadc.h      |   1 +
>  drivers/iio/chemical/Kconfig       |  23 +
>  drivers/iio/chemical/Makefile      |   3 +
>  drivers/iio/chemical/bme680.h      |  96 ++++
>  drivers/iio/chemical/bme680_core.c | 959 +++++++++++++++++++++++++++++++=
++++++
>  drivers/iio/chemical/bme680_i2c.c  |  85 ++++
>  drivers/iio/chemical/bme680_spi.c  | 125 +++++
>  drivers/iio/frequency/ad9523.c     |  32 +-
>  drivers/iio/light/Kconfig          |   5 +-
>  drivers/iio/light/si1133.c         |   5 +-
>  drivers/iio/light/vcnl4000.c       | 220 ++++++++-
>  13 files changed, 1558 insertions(+), 41 deletions(-)
>  create mode 100644 drivers/iio/chemical/bme680.h
>  create mode 100644 drivers/iio/chemical/bme680_core.c
>  create mode 100644 drivers/iio/chemical/bme680_i2c.c
>  create mode 100644 drivers/iio/chemical/bme680_spi.c

