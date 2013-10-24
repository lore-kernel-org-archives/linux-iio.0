Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:60248 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754103Ab3JXJMq (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 24 Oct 2013 05:12:46 -0400
Message-ID: <5268F2C9.5010104@kernel.org>
Date: Thu, 24 Oct 2013 11:13:29 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
CC: Felipe Balbi <balbi@ti.com>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/2] iio: adc: ti_am335x_adc: do not free the kfifo twice
References: <9ctn6ye3lkct930eq1ivw2wc.1382550258829@email.android.com>
In-Reply-To: <9ctn6ye3lkct930eq1ivw2wc.1382550258829@email.android.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/23/13 18:44, Lars-Peter Clausen wrote:
> The code is actually fine as it is. The iio_kfifo_free() function drops a reference, but does not free the buffer's memory if somebody else is still holding a reference.
> 
> - Lars
I'm guessing this came from a crash though.... Sebastian, what motivated the patch?
> 
> Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
> 
>> Since commit 9e69c9 ("iio: Add reference counting for buffers") the iio
>> core frees the buffer. So if the driver does it as well then bad things
>> will happen.
>>
>> Cc: Lars-Peter Clausen <lars@metafoo.de>
>> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>> ---
>>
>> By no means I am the expert here but the other users of iio_kfifo_free() like
>>
>> drivers/iio/industrialio-triggered-buffer.c:    iio_kfifo_free(indio_dev->buffer);
>> drivers/iio/industrialio-triggered-buffer.c:    iio_kfifo_free(indio_dev->buffer);
>>
>> are probably wrong, too. Not to mention staging. So *I* think iio_kfifo_free()
>> should vanish from the tree.
>>
>> drivers/iio/adc/ti_am335x_adc.c | 3 ---
>> 1 file changed, 3 deletions(-)
>>
>> diff --git a/drivers/iio/adc/ti_am335x_adc.c b/drivers/iio/adc/ti_am335x_adc.c
>> index f974dea..3d70f09 100644
>> --- a/drivers/iio/adc/ti_am335x_adc.c
>> +++ b/drivers/iio/adc/ti_am335x_adc.c
>> @@ -254,8 +254,6 @@ static int tiadc_iio_buffered_hardware_setup(struct iio_dev *indio_dev,
>>
>> error_free_irq:
>> 	free_irq(irq, indio_dev);
>> -error_kfifo_free:
>> -	iio_kfifo_free(indio_dev->buffer);
>> 	return ret;
>> }
>>
>> @@ -264,7 +262,6 @@ static void tiadc_iio_buffered_hardware_remove(struct iio_dev *indio_dev)
>> 	struct tiadc_device *adc_dev = iio_priv(indio_dev);
>>
>> 	free_irq(adc_dev->mfd_tscadc->irq, indio_dev);
>> -	iio_kfifo_free(indio_dev->buffer);
>> 	iio_buffer_unregister(indio_dev);
>> }
>>
>> -- 
>> 1.8.4.rc3
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> N�����r��y���b�X��ǧv�^�)޺{.n�+����{��*"��^n�r���z���h����&���G���h�(�階�ݢj"���m�����z�ޖ���f���h���~�mml==
> 
