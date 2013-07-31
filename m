Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-we0-f182.google.com ([74.125.82.182]:60800 "EHLO
	mail-we0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755379Ab3GaLWQ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 31 Jul 2013 07:22:16 -0400
Received: by mail-we0-f182.google.com with SMTP id u55so474476wes.41
        for <linux-iio@vger.kernel.org>; Wed, 31 Jul 2013 04:22:15 -0700 (PDT)
Message-ID: <51F8F366.1090009@gmail.com>
Date: Wed, 31 Jul 2013 13:22:14 +0200
From: Lo <dm81xx@gmail.com>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Subject: Re: continuous  mode driver for spi device with interrupt
References: <51F81A1D.7000003@gmail.com> <51F83DFE.6010107@kernel.org>
In-Reply-To: <51F83DFE.6010107@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hello Jonathan,
On 07/31/2013 12:28 AM, Jonathan Cameron wrote:
> On 07/30/13 20:55, Lo wrote:
[snip]
>>
>> Where my access funcs are:
>>      .preenable = &my_buffer_preenable,
>>      .postenable = &iio_triggered_buffer_postenable,
>>      .predisable = &iio_triggered_buffer_predisable,
>>      .postdisable = &my_buffer_postdisable
>> where:
>> preenable just sets iio->buffer->access->set_bytes_per_datum(iio->buffer, 19);
>
> The kfifo always contains aligned data. Hence it will be padded to the largest
> sized element.  The only way it would correctly be 19 would be to have 19 8 bit
> or lower channels.  Seems unlikely.  Also why doesn't the generic
> function work for your case?
>
I took a look at the dummy driver, I switched to the generic function.

>> and enables the irq
>> postenable disables the irq
>>
>> My irq handler does basically this:
>>      disable_irq_nosync(irq);
> Don't think you should need this if using the ONESHOT flag as it should be
> masked until handled. It's late here though so I might be completly wrong :)
>
Then I assume my irq handler should not return IRQ_HANDLED, but 
IRQ_WAKE_THREAD instead, right?

>>      iio_trigger_poll(adc->trig, iio_get_time_ns());
>>      return IRQ_HANDLED;
>>
>> My poll handler does this:
>>      ring->access->store_to(ring, (u8 *)data, pf->timestamp);
>>      iio_trigger_notify_done(iio->trig);
>>      enable_irq(adc->spi->irq);
>>      return IRQ_HANDLED;
> Looks fine.
> Take a look at the dummy driver (still in drivers/staging/iio) as that can be tested
> without any hardware. (iio_simple_dummy)
Thanks! that's what I need, but I kept looking in the adc related stuff.
I've compiled the dummy driver, but apparently my assumed way of using 
the buffer mode is wrong. My buffer length is 0, bytes per datum also.
I compiled the generic_buffer.c but don't know how to use that on the 
dummy device either. I can run it and by reading the source I saw I must 
pass the iiodevice name (./buftest -n iio_dummy_part_no ), but I've got 
no idea what I should pass as trigger argument. Btw: which arguments are 
required/optional?

--Lo


