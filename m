Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wr0-f193.google.com ([209.85.128.193]:33061 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934042AbeFVBfD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 21 Jun 2018 21:35:03 -0400
MIME-Version: 1.0
In-Reply-To: <55337e35-a4f7-e543-6384-e1f523d3f463@posteo.de>
References: <d3cdb3fef8434663c95b7b2f799c5ee4446a5231.1528397238.git.leonard.crestez@nxp.com>
 <55337e35-a4f7-e543-6384-e1f523d3f463@posteo.de>
From: harinath Nampally <harinath922@gmail.com>
Date: Thu, 21 Jun 2018 21:34:21 -0400
Message-ID: <CAAGUq_ppBDi0N-SrjKpZvhhfA0tay32gTLBtmXwMb=n4_rUjxQ@mail.gmail.com>
Subject: Re: [PATCH] iio: mma8452: Fix ignoring MMA8452_INT_DRDY
To: Martin Kepplinger <martink@posteo.de>
Cc: Leonard Crestez <leonard.crestez@nxp.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 2018-06-07 20:52, Leonard Crestez wrote:
> Interrupts are ignored if no event bit is set in the status status
> register and this breaks the buffer interface. No data is shown when
> running "iio_generic_buffer -n mma8451 -a" and interrupt counts go
> crazy.
>
> Fix by not returning IRQ_NONE if DRDY is set.
>
> Fixes: 605f72de137a ("iio: accel: mma8452: improvements to handle
> multiple events")
>
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
Thanks for catching it. Looks good to me.
Acked-by: Harinath Nampally <harinath922@gmail.com>

Thanks,
Harinath


On Wed, Jun 20, 2018 at 5:15 AM, Martin Kepplinger <martink@posteo.de> wrote:
> On 2018-06-07 20:52, Leonard Crestez wrote:
>> Interrupts are ignored if no event bit is set in the status status
>> register and this breaks the buffer interface. No data is shown when
>> running "iio_generic_buffer -n mma8451 -a" and interrupt counts go
>> crazy.
>>
>> Fix by not returning IRQ_NONE if DRDY is set.
>>
>> Fixes: 605f72de137a ("iio: accel: mma8452: improvements to handle
>> multiple events")
>>
>> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
>
> At least this does no harm to events. So if this solves your problem:
>
> Acked-by: Martin Kepplinger <martink@posteo.de>
>
> thanks,
>
>                             martin
>
>>
>> ---
>>  drivers/iio/accel/mma8452.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> Perhaps this whole early-exit check could be dropped? It is not clear
>> how it helps.
>>
>> If for some models we want to ignore unsupported events then maybe this
>> should be checked for each individual bit. Instead of
>>
>> if (src & MMA8452_INT_FF_MT) {
>>
>> Check for:
>>
>> if ((src & MMA8452_INT_FF_MT) && (data->chip_info->enabled_events & MMA8452_INT_FF_MT))
>>
>> diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
>> index 7a2da7f9d4dc..5485b35fe553 100644
>> --- a/drivers/iio/accel/mma8452.c
>> +++ b/drivers/iio/accel/mma8452.c
>> @@ -1032,11 +1032,11 @@ static irqreturn_t mma8452_interrupt(int irq, void *p)
>>
>>       src = i2c_smbus_read_byte_data(data->client, MMA8452_INT_SRC);
>>       if (src < 0)
>>               return IRQ_NONE;
>>
>> -     if (!(src & data->chip_info->enabled_events))
>> +     if (!(src & (data->chip_info->enabled_events | MMA8452_INT_DRDY)))
>>               return IRQ_NONE;
>>
>>       if (src & MMA8452_INT_DRDY) {
>>               iio_trigger_poll_chained(indio_dev->trig);
>>               ret = IRQ_HANDLED;
>>
>
