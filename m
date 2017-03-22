Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:48464 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753387AbdCVUVh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 22 Mar 2017 16:21:37 -0400
Subject: Re: [PATCH 1/2] staging: ade7754: Move header content to
 implementation file
To: simran singhal <singhalsimran0@gmail.com>, lars@metafoo.de
References: <1490022905-18422-1-git-send-email-singhalsimran0@gmail.com>
 <1490022905-18422-2-git-send-email-singhalsimran0@gmail.com>
Cc: Michael.Hennerich@analog.com, knaack.h@gmx.de, pmeerw@pmeerw.net,
        gregkh@linuxfoundation.org, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <fb4d6260-a2d5-0ca9-8e48-13b58e39e84a@kernel.org>
Date: Wed, 22 Mar 2017 20:21:24 +0000
MIME-Version: 1.0
In-Reply-To: <1490022905-18422-2-git-send-email-singhalsimran0@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 20/03/17 15:15, simran singhal wrote:
> The contents of ade7754.h are only used in ade7754.c.
> Move the header contents to the implementation file,
> and delete the header file.
> 
> Signed-off-by: simran singhal <singhalsimran0@gmail.com>
Unfortunately already done by sayli karnik back on the 8th of March.

Jonathan
> ---
>  drivers/staging/iio/meter/ade7754.c | 87 ++++++++++++++++++++++++++++++++++-
>  drivers/staging/iio/meter/ade7754.h | 90 -------------------------------------
>  2 files changed, 86 insertions(+), 91 deletions(-)
>  delete mode 100644 drivers/staging/iio/meter/ade7754.h
> 
> diff --git a/drivers/staging/iio/meter/ade7754.c b/drivers/staging/iio/meter/ade7754.c
> index 024463a..42f7b06 100644
> --- a/drivers/staging/iio/meter/ade7754.c
> +++ b/drivers/staging/iio/meter/ade7754.c
> @@ -21,7 +21,92 @@
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
>  #include "meter.h"
> -#include "ade7754.h"
> +
> +#define ADE7754_AENERGY   0x01
> +#define ADE7754_RAENERGY  0x02
> +#define ADE7754_LAENERGY  0x03
> +#define ADE7754_VAENERGY  0x04
> +#define ADE7754_RVAENERGY 0x05
> +#define ADE7754_LVAENERGY 0x06
> +#define ADE7754_PERIOD    0x07
> +#define ADE7754_TEMP      0x08
> +#define ADE7754_WFORM     0x09
> +#define ADE7754_OPMODE    0x0A
> +#define ADE7754_MMODE     0x0B
> +#define ADE7754_WAVMODE   0x0C
> +#define ADE7754_WATMODE   0x0D
> +#define ADE7754_VAMODE    0x0E
> +#define ADE7754_IRQEN     0x0F
> +#define ADE7754_STATUS    0x10
> +#define ADE7754_RSTATUS   0x11
> +#define ADE7754_ZXTOUT    0x12
> +#define ADE7754_LINCYC    0x13
> +#define ADE7754_SAGCYC    0x14
> +#define ADE7754_SAGLVL    0x15
> +#define ADE7754_VPEAK     0x16
> +#define ADE7754_IPEAK     0x17
> +#define ADE7754_GAIN      0x18
> +#define ADE7754_AWG       0x19
> +#define ADE7754_BWG       0x1A
> +#define ADE7754_CWG       0x1B
> +#define ADE7754_AVAG      0x1C
> +#define ADE7754_BVAG      0x1D
> +#define ADE7754_CVAG      0x1E
> +#define ADE7754_APHCAL    0x1F
> +#define ADE7754_BPHCAL    0x20
> +#define ADE7754_CPHCAL    0x21
> +#define ADE7754_AAPOS     0x22
> +#define ADE7754_BAPOS     0x23
> +#define ADE7754_CAPOS     0x24
> +#define ADE7754_CFNUM     0x25
> +#define ADE7754_CFDEN     0x26
> +#define ADE7754_WDIV      0x27
> +#define ADE7754_VADIV     0x28
> +#define ADE7754_AIRMS     0x29
> +#define ADE7754_BIRMS     0x2A
> +#define ADE7754_CIRMS     0x2B
> +#define ADE7754_AVRMS     0x2C
> +#define ADE7754_BVRMS     0x2D
> +#define ADE7754_CVRMS     0x2E
> +#define ADE7754_AIRMSOS   0x2F
> +#define ADE7754_BIRMSOS   0x30
> +#define ADE7754_CIRMSOS   0x31
> +#define ADE7754_AVRMSOS   0x32
> +#define ADE7754_BVRMSOS   0x33
> +#define ADE7754_CVRMSOS   0x34
> +#define ADE7754_AAPGAIN   0x35
> +#define ADE7754_BAPGAIN   0x36
> +#define ADE7754_CAPGAIN   0x37
> +#define ADE7754_AVGAIN    0x38
> +#define ADE7754_BVGAIN    0x39
> +#define ADE7754_CVGAIN    0x3A
> +#define ADE7754_CHKSUM    0x3E
> +#define ADE7754_VERSION   0x3F
> +
> +#define ADE7754_READ_REG(a)    a
> +#define ADE7754_WRITE_REG(a) ((a) | 0x80)
> +
> +#define ADE7754_MAX_TX    4
> +#define ADE7754_MAX_RX    4
> +#define ADE7754_STARTUP_DELAY 1000
> +
> +#define ADE7754_SPI_SLOW	(u32)(300 * 1000)
> +#define ADE7754_SPI_BURST	(u32)(1000 * 1000)
> +#define ADE7754_SPI_FAST	(u32)(2000 * 1000)
> +
> +/**
> + * struct ade7754_state - device instance specific data
> + * @us:			actual spi_device
> + * @buf_lock:		mutex to protect tx and rx
> + * @tx:			transmit buffer
> + * @rx:			receive buffer
> + **/
> +struct ade7754_state {
> +	struct spi_device	*us;
> +	struct mutex		buf_lock;
> +	u8			tx[ADE7754_MAX_TX] ____cacheline_aligned;
> +	u8			rx[ADE7754_MAX_RX];
> +};
>  
>  static int ade7754_spi_write_reg_8(struct device *dev, u8 reg_address, u8 val)
>  {
> diff --git a/drivers/staging/iio/meter/ade7754.h b/drivers/staging/iio/meter/ade7754.h
> deleted file mode 100644
> index 28f71c2..0000000
> --- a/drivers/staging/iio/meter/ade7754.h
> +++ /dev/null
> @@ -1,90 +0,0 @@
> -#ifndef _ADE7754_H
> -#define _ADE7754_H
> -
> -#define ADE7754_AENERGY   0x01
> -#define ADE7754_RAENERGY  0x02
> -#define ADE7754_LAENERGY  0x03
> -#define ADE7754_VAENERGY  0x04
> -#define ADE7754_RVAENERGY 0x05
> -#define ADE7754_LVAENERGY 0x06
> -#define ADE7754_PERIOD    0x07
> -#define ADE7754_TEMP      0x08
> -#define ADE7754_WFORM     0x09
> -#define ADE7754_OPMODE    0x0A
> -#define ADE7754_MMODE     0x0B
> -#define ADE7754_WAVMODE   0x0C
> -#define ADE7754_WATMODE   0x0D
> -#define ADE7754_VAMODE    0x0E
> -#define ADE7754_IRQEN     0x0F
> -#define ADE7754_STATUS    0x10
> -#define ADE7754_RSTATUS   0x11
> -#define ADE7754_ZXTOUT    0x12
> -#define ADE7754_LINCYC    0x13
> -#define ADE7754_SAGCYC    0x14
> -#define ADE7754_SAGLVL    0x15
> -#define ADE7754_VPEAK     0x16
> -#define ADE7754_IPEAK     0x17
> -#define ADE7754_GAIN      0x18
> -#define ADE7754_AWG       0x19
> -#define ADE7754_BWG       0x1A
> -#define ADE7754_CWG       0x1B
> -#define ADE7754_AVAG      0x1C
> -#define ADE7754_BVAG      0x1D
> -#define ADE7754_CVAG      0x1E
> -#define ADE7754_APHCAL    0x1F
> -#define ADE7754_BPHCAL    0x20
> -#define ADE7754_CPHCAL    0x21
> -#define ADE7754_AAPOS     0x22
> -#define ADE7754_BAPOS     0x23
> -#define ADE7754_CAPOS     0x24
> -#define ADE7754_CFNUM     0x25
> -#define ADE7754_CFDEN     0x26
> -#define ADE7754_WDIV      0x27
> -#define ADE7754_VADIV     0x28
> -#define ADE7754_AIRMS     0x29
> -#define ADE7754_BIRMS     0x2A
> -#define ADE7754_CIRMS     0x2B
> -#define ADE7754_AVRMS     0x2C
> -#define ADE7754_BVRMS     0x2D
> -#define ADE7754_CVRMS     0x2E
> -#define ADE7754_AIRMSOS   0x2F
> -#define ADE7754_BIRMSOS   0x30
> -#define ADE7754_CIRMSOS   0x31
> -#define ADE7754_AVRMSOS   0x32
> -#define ADE7754_BVRMSOS   0x33
> -#define ADE7754_CVRMSOS   0x34
> -#define ADE7754_AAPGAIN   0x35
> -#define ADE7754_BAPGAIN   0x36
> -#define ADE7754_CAPGAIN   0x37
> -#define ADE7754_AVGAIN    0x38
> -#define ADE7754_BVGAIN    0x39
> -#define ADE7754_CVGAIN    0x3A
> -#define ADE7754_CHKSUM    0x3E
> -#define ADE7754_VERSION   0x3F
> -
> -#define ADE7754_READ_REG(a)    a
> -#define ADE7754_WRITE_REG(a) ((a) | 0x80)
> -
> -#define ADE7754_MAX_TX    4
> -#define ADE7754_MAX_RX    4
> -#define ADE7754_STARTUP_DELAY 1000
> -
> -#define ADE7754_SPI_SLOW	(u32)(300 * 1000)
> -#define ADE7754_SPI_BURST	(u32)(1000 * 1000)
> -#define ADE7754_SPI_FAST	(u32)(2000 * 1000)
> -
> -/**
> - * struct ade7754_state - device instance specific data
> - * @us:			actual spi_device
> - * @buf_lock:		mutex to protect tx and rx
> - * @tx:			transmit buffer
> - * @rx:			receive buffer
> - **/
> -struct ade7754_state {
> -	struct spi_device	*us;
> -	struct mutex		buf_lock;
> -	u8			tx[ADE7754_MAX_TX] ____cacheline_aligned;
> -	u8			rx[ADE7754_MAX_RX];
> -};
> -
> -#endif
> 

