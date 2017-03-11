Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:36695 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754017AbdCKRS5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 11 Mar 2017 12:18:57 -0500
Subject: Re: [PATCH] staging: iio: ade7759: Move contents of header file to
 source file
To: sayli karnik <karniksayli1995@gmail.com>,
        outreachy-kernel <outreachy-kernel@googlegroups.com>
References: <20170308094321.GA11025@sayli-HP-15-Notebook-PC>
 <CAKG5xWgQyJ65gfd3c82CoyQPw74HP=-Cb78OPo7ZpfEOc2BPxw@mail.gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <9f194fe1-5f22-11f8-b9b1-6daee215fc01@kernel.org>
Date: Sat, 11 Mar 2017 17:18:53 +0000
MIME-Version: 1.0
In-Reply-To: <CAKG5xWgQyJ65gfd3c82CoyQPw74HP=-Cb78OPo7ZpfEOc2BPxw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/03/17 12:37, sayli karnik wrote:
> On Wed, Mar 8, 2017 at 3:16 PM, sayli karnik <karniksayli1995@gmail.com> wrote:
>> The contents of ade7759.h are only used in ade7759.c. Move the header
>> contents to the source file and delete the header file.
>>
>> Signed-off-by: sayli karnik <karniksayli1995@gmail.com>
>> ---
>>  drivers/staging/iio/meter/ade7759.c | 50 +++++++++++++++++++++++++++++++++-
>>  drivers/staging/iio/meter/ade7759.h | 53 -------------------------------------
>>  2 files changed, 49 insertions(+), 54 deletions(-)
>>  delete mode 100644 drivers/staging/iio/meter/ade7759.h
>>
>> diff --git a/drivers/staging/iio/meter/ade7759.c b/drivers/staging/iio/meter/ade7759.c
>> index 944ee34..0b65f18 100644
>> --- a/drivers/staging/iio/meter/ade7759.c
>> +++ b/drivers/staging/iio/meter/ade7759.c
>> @@ -21,7 +21,55 @@
>>  #include <linux/iio/iio.h>
>>  #include <linux/iio/sysfs.h>
>>  #include "meter.h"
>> -#include "ade7759.h"
>> +
>> +#define ADE7759_WAVEFORM  0x01
>> +#define ADE7759_AENERGY   0x02
>> +#define ADE7759_RSTENERGY 0x03
>> +#define ADE7759_STATUS    0x04
>> +#define ADE7759_RSTSTATUS 0x05
>> +#define ADE7759_MODE      0x06
>> +#define ADE7759_CFDEN     0x07
>> +#define ADE7759_CH1OS     0x08
>> +#define ADE7759_CH2OS     0x09
>> +#define ADE7759_GAIN      0x0A
>> +#define ADE7759_APGAIN    0x0B
>> +#define ADE7759_PHCAL     0x0C
>> +#define ADE7759_APOS      0x0D
>> +#define ADE7759_ZXTOUT    0x0E
>> +#define ADE7759_SAGCYC    0x0F
>> +#define ADE7759_IRQEN     0x10
>> +#define ADE7759_SAGLVL    0x11
>> +#define ADE7759_TEMP      0x12
>> +#define ADE7759_LINECYC   0x13
>> +#define ADE7759_LENERGY   0x14
>> +#define ADE7759_CFNUM     0x15
>> +#define ADE7759_CHKSUM    0x1E
>> +#define ADE7759_DIEREV    0x1F
>> +
>> +#define ADE7759_READ_REG(a)    a
>> +#define ADE7759_WRITE_REG(a) ((a) | 0x80)
>> +
>> +#define ADE7759_MAX_TX    6
>> +#define ADE7759_MAX_RX    6
>> +#define ADE7759_STARTUP_DELAY 1000
>> +
>> +#define ADE7759_SPI_SLOW       (u32)(300 * 1000)
>> +#define ADE7759_SPI_BURST      (u32)(1000 * 1000)
>> +#define ADE7759_SPI_FAST       (u32)(2000 * 1000)
>> +
>> +/**
>> + * struct ade7759_state - device instance specific data
>> + * @us:                        actual spi_device
>> + * @buf_lock:          mutex to protect tx and rx
>> + * @tx:                        transmit buffer
>> + * @rx:                        receive buffer
>> + **/
>> +struct ade7759_state {
>> +       struct spi_device       *us;
>> +       struct mutex            buf_lock;
>> +       u8                      tx[ADE7759_MAX_TX] ____cacheline_aligned;
>> +       u8                      rx[ADE7759_MAX_RX];
>> +};
>>
>>  static int ade7759_spi_write_reg_8(struct device *dev,
>>                 u8 reg_address,
>> diff --git a/drivers/staging/iio/meter/ade7759.h b/drivers/staging/iio/meter/ade7759.h
>> deleted file mode 100644
>> index f0716d2..0000000
>> --- a/drivers/staging/iio/meter/ade7759.h
>> +++ /dev/null
>> @@ -1,53 +0,0 @@
>> -#ifndef _ADE7759_H
>> -#define _ADE7759_H
>> -
>> -#define ADE7759_WAVEFORM  0x01
>> -#define ADE7759_AENERGY   0x02
>> -#define ADE7759_RSTENERGY 0x03
>> -#define ADE7759_STATUS    0x04
>> -#define ADE7759_RSTSTATUS 0x05
>> -#define ADE7759_MODE      0x06
>> -#define ADE7759_CFDEN     0x07
>> -#define ADE7759_CH1OS     0x08
>> -#define ADE7759_CH2OS     0x09
>> -#define ADE7759_GAIN      0x0A
>> -#define ADE7759_APGAIN    0x0B
>> -#define ADE7759_PHCAL     0x0C
>> -#define ADE7759_APOS      0x0D
>> -#define ADE7759_ZXTOUT    0x0E
>> -#define ADE7759_SAGCYC    0x0F
>> -#define ADE7759_IRQEN     0x10
>> -#define ADE7759_SAGLVL    0x11
>> -#define ADE7759_TEMP      0x12
>> -#define ADE7759_LINECYC   0x13
>> -#define ADE7759_LENERGY   0x14
>> -#define ADE7759_CFNUM     0x15
>> -#define ADE7759_CHKSUM    0x1E
>> -#define ADE7759_DIEREV    0x1F
>> -
>> -#define ADE7759_READ_REG(a)    a
>> -#define ADE7759_WRITE_REG(a) ((a) | 0x80)
>> -
>> -#define ADE7759_MAX_TX    6
>> -#define ADE7759_MAX_RX    6
>> -#define ADE7759_STARTUP_DELAY 1000
>> -
>> -#define ADE7759_SPI_SLOW       (u32)(300 * 1000)
>> -#define ADE7759_SPI_BURST      (u32)(1000 * 1000)
>> -#define ADE7759_SPI_FAST       (u32)(2000 * 1000)
>> -
>> -/**
>> - * struct ade7759_state - device instance specific data
>> - * @us:                        actual spi_device
>> - * @buf_lock:          mutex to protect tx and rx
>> - * @tx:                        transmit buffer
>> - * @rx:                        receive buffer
>> - **/
>> -struct ade7759_state {
>> -       struct spi_device       *us;
>> -       struct mutex            buf_lock;
>> -       u8                      tx[ADE7759_MAX_TX] ____cacheline_aligned;
>> -       u8                      rx[ADE7759_MAX_RX];
>> -};
>> -
>> -#endif
> 
> Is this a valid change?
Yes. As far as I can see anyway.  What made you wonder?
If it was just the lack of reply, then I'm afraid the kernel world
doesn't always move that quick!   Usually a wrong patch gets
responses much quicker than a correct one.

Anyhow, applied to the togreg branch of iio.git and pushed out
as testing for the autobuilders to play with.

Thanks,

Jonathan
> 
> thanks,
> sayli
>> --
>> 2.7.4
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

