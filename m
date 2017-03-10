Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-yw0-f195.google.com ([209.85.161.195]:35260 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934674AbdCJMi1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 10 Mar 2017 07:38:27 -0500
Received: by mail-yw0-f195.google.com with SMTP id h11so3273549ywa.2
        for <linux-iio@vger.kernel.org>; Fri, 10 Mar 2017 04:38:21 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170308094321.GA11025@sayli-HP-15-Notebook-PC>
References: <20170308094321.GA11025@sayli-HP-15-Notebook-PC>
From: sayli karnik <karniksayli1995@gmail.com>
Date: Fri, 10 Mar 2017 18:07:40 +0530
Message-ID: <CAKG5xWgQyJ65gfd3c82CoyQPw74HP=-Cb78OPo7ZpfEOc2BPxw@mail.gmail.com>
Subject: Re: [PATCH] staging: iio: ade7759: Move contents of header file to
 source file
To: outreachy-kernel <outreachy-kernel@googlegroups.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, Mar 8, 2017 at 3:16 PM, sayli karnik <karniksayli1995@gmail.com> wrote:
> The contents of ade7759.h are only used in ade7759.c. Move the header
> contents to the source file and delete the header file.
>
> Signed-off-by: sayli karnik <karniksayli1995@gmail.com>
> ---
>  drivers/staging/iio/meter/ade7759.c | 50 +++++++++++++++++++++++++++++++++-
>  drivers/staging/iio/meter/ade7759.h | 53 -------------------------------------
>  2 files changed, 49 insertions(+), 54 deletions(-)
>  delete mode 100644 drivers/staging/iio/meter/ade7759.h
>
> diff --git a/drivers/staging/iio/meter/ade7759.c b/drivers/staging/iio/meter/ade7759.c
> index 944ee34..0b65f18 100644
> --- a/drivers/staging/iio/meter/ade7759.c
> +++ b/drivers/staging/iio/meter/ade7759.c
> @@ -21,7 +21,55 @@
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
>  #include "meter.h"
> -#include "ade7759.h"
> +
> +#define ADE7759_WAVEFORM  0x01
> +#define ADE7759_AENERGY   0x02
> +#define ADE7759_RSTENERGY 0x03
> +#define ADE7759_STATUS    0x04
> +#define ADE7759_RSTSTATUS 0x05
> +#define ADE7759_MODE      0x06
> +#define ADE7759_CFDEN     0x07
> +#define ADE7759_CH1OS     0x08
> +#define ADE7759_CH2OS     0x09
> +#define ADE7759_GAIN      0x0A
> +#define ADE7759_APGAIN    0x0B
> +#define ADE7759_PHCAL     0x0C
> +#define ADE7759_APOS      0x0D
> +#define ADE7759_ZXTOUT    0x0E
> +#define ADE7759_SAGCYC    0x0F
> +#define ADE7759_IRQEN     0x10
> +#define ADE7759_SAGLVL    0x11
> +#define ADE7759_TEMP      0x12
> +#define ADE7759_LINECYC   0x13
> +#define ADE7759_LENERGY   0x14
> +#define ADE7759_CFNUM     0x15
> +#define ADE7759_CHKSUM    0x1E
> +#define ADE7759_DIEREV    0x1F
> +
> +#define ADE7759_READ_REG(a)    a
> +#define ADE7759_WRITE_REG(a) ((a) | 0x80)
> +
> +#define ADE7759_MAX_TX    6
> +#define ADE7759_MAX_RX    6
> +#define ADE7759_STARTUP_DELAY 1000
> +
> +#define ADE7759_SPI_SLOW       (u32)(300 * 1000)
> +#define ADE7759_SPI_BURST      (u32)(1000 * 1000)
> +#define ADE7759_SPI_FAST       (u32)(2000 * 1000)
> +
> +/**
> + * struct ade7759_state - device instance specific data
> + * @us:                        actual spi_device
> + * @buf_lock:          mutex to protect tx and rx
> + * @tx:                        transmit buffer
> + * @rx:                        receive buffer
> + **/
> +struct ade7759_state {
> +       struct spi_device       *us;
> +       struct mutex            buf_lock;
> +       u8                      tx[ADE7759_MAX_TX] ____cacheline_aligned;
> +       u8                      rx[ADE7759_MAX_RX];
> +};
>
>  static int ade7759_spi_write_reg_8(struct device *dev,
>                 u8 reg_address,
> diff --git a/drivers/staging/iio/meter/ade7759.h b/drivers/staging/iio/meter/ade7759.h
> deleted file mode 100644
> index f0716d2..0000000
> --- a/drivers/staging/iio/meter/ade7759.h
> +++ /dev/null
> @@ -1,53 +0,0 @@
> -#ifndef _ADE7759_H
> -#define _ADE7759_H
> -
> -#define ADE7759_WAVEFORM  0x01
> -#define ADE7759_AENERGY   0x02
> -#define ADE7759_RSTENERGY 0x03
> -#define ADE7759_STATUS    0x04
> -#define ADE7759_RSTSTATUS 0x05
> -#define ADE7759_MODE      0x06
> -#define ADE7759_CFDEN     0x07
> -#define ADE7759_CH1OS     0x08
> -#define ADE7759_CH2OS     0x09
> -#define ADE7759_GAIN      0x0A
> -#define ADE7759_APGAIN    0x0B
> -#define ADE7759_PHCAL     0x0C
> -#define ADE7759_APOS      0x0D
> -#define ADE7759_ZXTOUT    0x0E
> -#define ADE7759_SAGCYC    0x0F
> -#define ADE7759_IRQEN     0x10
> -#define ADE7759_SAGLVL    0x11
> -#define ADE7759_TEMP      0x12
> -#define ADE7759_LINECYC   0x13
> -#define ADE7759_LENERGY   0x14
> -#define ADE7759_CFNUM     0x15
> -#define ADE7759_CHKSUM    0x1E
> -#define ADE7759_DIEREV    0x1F
> -
> -#define ADE7759_READ_REG(a)    a
> -#define ADE7759_WRITE_REG(a) ((a) | 0x80)
> -
> -#define ADE7759_MAX_TX    6
> -#define ADE7759_MAX_RX    6
> -#define ADE7759_STARTUP_DELAY 1000
> -
> -#define ADE7759_SPI_SLOW       (u32)(300 * 1000)
> -#define ADE7759_SPI_BURST      (u32)(1000 * 1000)
> -#define ADE7759_SPI_FAST       (u32)(2000 * 1000)
> -
> -/**
> - * struct ade7759_state - device instance specific data
> - * @us:                        actual spi_device
> - * @buf_lock:          mutex to protect tx and rx
> - * @tx:                        transmit buffer
> - * @rx:                        receive buffer
> - **/
> -struct ade7759_state {
> -       struct spi_device       *us;
> -       struct mutex            buf_lock;
> -       u8                      tx[ADE7759_MAX_TX] ____cacheline_aligned;
> -       u8                      rx[ADE7759_MAX_RX];
> -};
> -
> -#endif

Is this a valid change?

thanks,
sayli
> --
> 2.7.4
>
