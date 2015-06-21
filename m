Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:43714 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751639AbbFUNEv (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 21 Jun 2015 09:04:51 -0400
Message-ID: <5586B670.2020607@kernel.org>
Date: Sun, 21 Jun 2015 14:04:48 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>, jmfriedt@femto-st.fr,
	linux-iio@vger.kernel.org
CC: Michael.Hennerich@analog.com, knaack.h@gmx.de, pmeerw@pmeerw.net
Subject: Re: [PATCH 1/1] iio: DAC: ad5624r_spi: fix bit shift of output data
 value
References: <1434718086-14722-1-git-send-email-jmfriedt@femto-st.fr> <55841173.30506@metafoo.de>
In-Reply-To: <55841173.30506@metafoo.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 19/06/15 13:56, Lars-Peter Clausen wrote:
> On 06/19/2015 02:48 PM, jmfriedt@femto-st.fr wrote:
>> From: JM Friedt <jmfriedt@femto-st.fr>
>>
>> The value sent on the SPI bus is shifted by an erroneous number of bits. The shift
>> value was already computed in the iio_chan_spec structure and hence subtracting this
>> argument to 16 yields an erroneous data position in the SPI stream.
>>
>> Signed-off-by: JM Friedt <jmfriedt@femto-st.fr>
> 
> Looks good, thanks.
> 
> Acked-by: Lars-Peter Clausen <lars@metafoo.de>
Applied to the fixes-togreg branch of iio.git and marked for stable.
Note this won't go upstream now until after the merge window
(so a couple of weeks at least).

Thanks,

Jonathan
> 
>> ---
>>   drivers/iio/dac/ad5624r_spi.c |    4 ++--
>>   1 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/iio/dac/ad5624r_spi.c b/drivers/iio/dac/ad5624r_spi.c
>> index 61bb9d4..e98428d 100644
>> --- a/drivers/iio/dac/ad5624r_spi.c
>> +++ b/drivers/iio/dac/ad5624r_spi.c
>> @@ -22,7 +22,7 @@
>>   #include "ad5624r.h"
>>
>>   static int ad5624r_spi_write(struct spi_device *spi,
>> -                 u8 cmd, u8 addr, u16 val, u8 len)
>> +                 u8 cmd, u8 addr, u16 val, u8 shift)
>>   {
>>       u32 data;
>>       u8 msg[3];
>> @@ -35,7 +35,7 @@ static int ad5624r_spi_write(struct spi_device *spi,
>>        * 14-, 12-bit input code followed by 0, 2, or 4 don't care bits,
>>        * for the AD5664R, AD5644R, and AD5624R, respectively.
>>        */
>> -    data = (0 << 22) | (cmd << 19) | (addr << 16) | (val << (16 - len));
>> +    data = (0 << 22) | (cmd << 19) | (addr << 16) | (val << shift);
>>       msg[0] = data >> 16;
>>       msg[1] = data >> 8;
>>       msg[2] = data;
>>
> 

--
To unsubscribe from this list: send the line "unsubscribe linux-iio" in
