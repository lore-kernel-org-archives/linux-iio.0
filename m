Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:50999 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751514AbbJDOfp (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 4 Oct 2015 10:35:45 -0400
Subject: Re: [PATCH] Staging: iio: meter: Use devm functions
To: Shraddha Barke <shraddha.6596@gmail.com>
References: <1443933272-23398-1-git-send-email-shraddha.6596@gmail.com>
 <56111645.3060004@kernel.org>
 <alpine.DEB.2.11.1510041809250.26738@shraddha-370R4E-370R4V-370R5E-3570RE-370R5V>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <5611393E.4070602@kernel.org>
Date: Sun, 4 Oct 2015 15:35:42 +0100
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.11.1510041809250.26738@shraddha-370R4E-370R4V-370R5E-3570RE-370R5V>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 04/10/15 13:43, Shraddha Barke wrote:
> 
> 
> On Sun, 4 Oct 2015, Jonathan Cameron wrote:
> 
>> On 04/10/15 05:34, Shraddha Barke wrote:
>>> Introduce use of managed resource function devm_iio_trigger_alloc
>>> instead of iio_trigger_alloc and devm_request_irq instead of request_irq
>>> Remove corresponding calls to iio_trigger_free and free_irq in the probe
>>> and remove functions.
>>> The now unnecessary labels error_free_trig and err_free_irq are dropped.
>>>
>>> Signed-off-by: Shraddha Barke <shraddha.6596@gmail.com>
>>> ---
>>>
>>>  drivers/staging/iio/meter/ade7758_trigger.c | 26 ++++++++++----------------
>>>  1 file changed, 10 insertions(+), 16 deletions(-)
>>>
>>> diff --git a/drivers/staging/iio/meter/ade7758_trigger.c b/drivers/staging/iio/meter/ade7758_trigger.c
>>> index 5b35a7f..e313b37 100644
>>> --- a/drivers/staging/iio/meter/ade7758_trigger.c
>>> +++ b/drivers/staging/iio/meter/ade7758_trigger.c
>>> @@ -63,21 +63,21 @@ int ade7758_probe_trigger(struct iio_dev *indio_dev)
>>>      struct ade7758_state *st = iio_priv(indio_dev);
>>>      int ret;
>>>
>>> -    st->trig = iio_trigger_alloc("%s-dev%d",
>>> -                    spi_get_device_id(st->us)->name,
>>> -                    indio_dev->id);
>>> +    st->trig = devm_iio_trigger_alloc(&indio_dev->id, "%s-dev%d",
>>> +                      spi_get_device_id(st->us)->name,
>>> +                      indio_dev->id);
>>>      if (!st->trig) {
>>>          ret = -ENOMEM;
>>>          goto error_ret;
>>>      }
>>>
>>> -    ret = request_irq(st->us->irq,
>>> -              ade7758_data_rdy_trig_poll,
>>> -              IRQF_TRIGGER_LOW,
>>> -              spi_get_device_id(st->us)->name,
>>> -              st->trig);
>>> +    ret = devm_request_irq(&indio_dev->dev, st->us->irq,
>>> +                   ade7758_data_rdy_trig_poll,
>>> +                   IRQF_TRIGGER_LOW,
>>> +                   spi_get_device_id(st->us)->name,
>>> +                   st->trig);
>>>      if (ret)
>>> -        goto error_free_trig;
>>> +        goto error_ret
>>>
>>>      st->trig->dev.parent = &st->us->dev;
>>>      st->trig->ops = &ade7758_trigger_ops;
>>> @@ -87,14 +87,10 @@ int ade7758_probe_trigger(struct iio_dev *indio_dev)
>>>      /* select default trigger */
>>>      indio_dev->trig = iio_trigger_get(st->trig);
>>>      if (ret)
>>> -        goto error_free_irq;
>>> +        goto error_ret;
>>>
>>>      return 0;
>>>
>>> -error_free_irq:
>>> -    free_irq(st->us->irq, st->trig);
>>> -error_free_trig:
>>> -    iio_trigger_free(st->trig);
>>>  error_ret:
>>>      return ret;
>> Whilst you are here, direct returns are preferred when there is no unwinding to do
>> so if you could just return the error from anywhere it does the goto error_ret
>> that would be great!
> 
> I was a little skeptical about the change from request_irq to devm_request_irq because I'm not sure whether the things that are
> freed by the function are needed by the interrupt handler.  Do you think it's correct?
Good point. It's a dangerous corner as there is a whole load of stuff in the _core.c file
remove which will move from after to before this call.  I'd actually be a bit dubious about
using any devm stuff in here without working on that file a touch first.

The st->tx, st->rx allocations could be trivially made devm as well.
(be careful here as there are two lots of rx and tx buffers so that
the other lot can be left intact to do the ring reads nice and quickly
whatever other reads and writes occur).

The unconfigure_ring does a bit more and is the sticky issue.

I'd leave the whole lot as non devm functions as it meets the 'obviously correct'
requirement and the devm equivalent does not...

Still worth cleaning up those goto error_ret bits though!

Jonathan
> 
> Shraddha
>>
>> Thanks,
>>
>> Jonathan
>>>  }
>>> @@ -104,6 +100,4 @@ void ade7758_remove_trigger(struct iio_dev *indio_dev)
>>>      struct ade7758_state *st = iio_priv(indio_dev);
>>>
>>>      iio_trigger_unregister(st->trig);
>>> -    free_irq(st->us->irq, st->trig);
>>> -    iio_trigger_free(st->trig);
>>>  }
>>>
>>
>>
> -- 
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

