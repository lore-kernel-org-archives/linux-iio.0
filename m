Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:59228 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755993Ab3KWRmB (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 23 Nov 2013 12:42:01 -0500
Message-ID: <5290F73D.1000306@kernel.org>
Date: Sat, 23 Nov 2013 18:43:09 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Sachin Kamat <sachin.kamat@linaro.org>, linux-iio@vger.kernel.org
CC: lars@metafoo.de
Subject: Re: [PATCH Resend 00/33] iio: Implement and use devm_iio_device_register
References: <1383046796-329-1-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1383046796-329-1-git-send-email-sachin.kamat@linaro.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/29/13 11:39, Sachin Kamat wrote:
> Resending this series after rebasing onto the latest iio tree.
> Previous version is available at [1].
> [1] http://www.spinics.net/lists/linux-iio/msg10682.html
> 
> * Added tested and reviewed by tags to patch 1. Thank you Lars.
> * Included a patch (patch2) to re-organise the kernel doc
>   as suggested by Lars.

Hi Sachin,

Having finaly waded through this whole set I have a few general comments.
Firstly, I am sorry I am refusing to take so many of these.  I did mention
in response to an earlier series that I was not keen on applying this
shortening in code, if there was stuff that should be done after the
unregister, but which was not.

I have kept to that as I would much rather see those drivers improved by
adding for example power down of the part on removal of the driver or making
sure that the removal is in the correct order.  Feel free to try and
talk me around though!

Anyhow, thanks for your hard work on this.

Note that if anyone wants to take a look at the reasons I have refused to
take the individual patches, they may well highlight places I feel the
individual drivers could be easily improved.

Thanks,

Jonathan
> 
> Sachin Kamat (33):
>   iio: core: Implement devm_iio_device_{register,unregister}
>   iio: core: Move kernel doc to the right location
>   iio: accel: kxsd9: Use devm_iio_device_register
>   iio: adc: mcp3422: Use devm_iio_device_register
>   iio: adc: twl6030-gpadc: Use devm_iio_device_register
>   iio: adc: viperboard: Use devm_iio_device_register
>   iio: dac: ad5421: Use devm_iio_device_register
>   iio: dac: ad5755: Use devm_iio_device_register
>   iio: dac: max517: Use devm_iio_device_register
>   iio: dac: mcp4725: Use devm_iio_device_register
>   iio: gyro: adis16130: Use devm_iio_device_register
>   iio: gyro: adxrs450: Use devm_iio_device_register
>   iio: light: vcnl4000: Use devm_iio_device_register
>   staging: iio: adis16220: Use devm_iio_device_register
>   staging: iio: ad7816: Use devm_iio_device_register
>   staging: iio: lpc32xx_adc: Use devm_iio_device_register
>   staging: iio: addac: Use devm_iio_device_register
>   staging: iio: ad7150: Use devm_iio_device_register
>   staging: iio: ad7746: Use devm_iio_device_register
>   staging: iio: ad5930: Use devm_iio_device_register
>   staging: iio: ad9850: Use devm_iio_device_register
>   staging: iio: ad9852: Use devm_iio_device_register
>   staging: iio: ad9910: Use devm_iio_device_register
>   staging: iio: ad9951: Use devm_iio_device_register
>   staging: iio: adis16060: Use devm_iio_device_register
>   staging: iio: isl29018: Use devm_iio_device_register
>   staging: iio: isl29028: Use devm_iio_device_register
>   staging: iio: tsl2583: Use devm_iio_device_register
>   staging: iio: tsl2x7x_core: Use devm_iio_device_register
>   staging: iio: ade7854: Use devm_iio_device_register
>   staging: iio: ad2s1200: Use devm_iio_device_register
>   staging: iio: ad2s90: Use devm_iio_device_register
>   staging: iio: ad7152: Use devm_iio_device_register
> 
>  Documentation/driver-model/devres.txt      |    2 +
>  drivers/iio/accel/kxsd9.c                  |   10 +--
>  drivers/iio/adc/mcp3422.c                  |    9 +--
>  drivers/iio/adc/twl6030-gpadc.c            |    5 +-
>  drivers/iio/adc/viperboard_adc.c           |   12 +---
>  drivers/iio/dac/ad5421.c                   |   12 +---
>  drivers/iio/dac/ad5755.c                   |   12 +---
>  drivers/iio/dac/max517.c                   |    9 +--
>  drivers/iio/dac/mcp4725.c                  |    9 +--
>  drivers/iio/gyro/adis16130.c               |    9 +--
>  drivers/iio/gyro/adxrs450.c                |   14 +---
>  drivers/iio/industrialio-core.c            |  101 ++++++++++++++++++++++++++++
>  drivers/iio/industrialio-event.c           |    6 ++
>  drivers/iio/industrialio-trigger.c         |   24 +++++++
>  drivers/iio/light/vcnl4000.c               |    9 +--
>  drivers/staging/iio/accel/adis16220_core.c |    7 +-
>  drivers/staging/iio/adc/ad7816.c           |   12 +---
>  drivers/staging/iio/adc/lpc32xx_adc.c      |   12 +---
>  drivers/staging/iio/addac/adt7316-i2c.c    |    6 --
>  drivers/staging/iio/addac/adt7316-spi.c    |    6 --
>  drivers/staging/iio/addac/adt7316.c        |   12 +---
>  drivers/staging/iio/addac/adt7316.h        |    1 -
>  drivers/staging/iio/cdc/ad7150.c           |   12 +---
>  drivers/staging/iio/cdc/ad7152.c           |   12 +---
>  drivers/staging/iio/cdc/ad7746.c           |   12 +---
>  drivers/staging/iio/frequency/ad5930.c     |   10 +--
>  drivers/staging/iio/frequency/ad9850.c     |   10 +--
>  drivers/staging/iio/frequency/ad9852.c     |   10 +--
>  drivers/staging/iio/frequency/ad9910.c     |   10 +--
>  drivers/staging/iio/frequency/ad9951.c     |   10 +--
>  drivers/staging/iio/gyro/adis16060_core.c  |   10 +--
>  drivers/staging/iio/light/isl29018.c       |   13 +---
>  drivers/staging/iio/light/isl29028.c       |   11 +--
>  drivers/staging/iio/light/tsl2583.c        |   10 +--
>  drivers/staging/iio/light/tsl2x7x_core.c   |    4 +-
>  drivers/staging/iio/meter/ade7854-i2c.c    |    6 --
>  drivers/staging/iio/meter/ade7854-spi.c    |    7 --
>  drivers/staging/iio/meter/ade7854.c        |   14 +---
>  drivers/staging/iio/meter/ade7854.h        |    1 -
>  drivers/staging/iio/resolver/ad2s1200.c    |   10 +--
>  drivers/staging/iio/resolver/ad2s90.c      |   10 +--
>  include/linux/iio/iio.h                    |   81 +---------------------
>  42 files changed, 168 insertions(+), 394 deletions(-)
> 
