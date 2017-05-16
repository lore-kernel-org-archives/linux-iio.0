Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-yw0-f176.google.com ([209.85.161.176]:34606 "EHLO
        mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751437AbdEPFW4 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 16 May 2017 01:22:56 -0400
Received: by mail-yw0-f176.google.com with SMTP id l14so47860962ywk.1
        for <linux-iio@vger.kernel.org>; Mon, 15 May 2017 22:22:56 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <5b3b11e7-6a0b-a578-b6aa-45b5d876f72e@kernel.org>
References: <1494658033-11503-1-git-send-email-raveendra.padasalagi@broadcom.com>
 <5b3b11e7-6a0b-a578-b6aa-45b5d876f72e@kernel.org>
From: Raveendra Padasalagi <raveendra.padasalagi@broadcom.com>
Date: Tue, 16 May 2017 10:52:50 +0530
Message-ID: <CAAFb_vp6R_HSwJ1q_9YOq-kajKQdyQGNA6D_+GSW+BmV=FrMyg@mail.gmail.com>
Subject: Re: [PATCH] iio: adc: bcm_iproc_adc: swap primary and secondary isr handler's
To: Jonathan Cameron <jic23@kernel.org>
Cc: Pavel Roskin <plroskin@gmail.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        linux-iio@vger.kernel.org,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, May 14, 2017 at 8:08 PM, Jonathan Cameron <jic23@kernel.org> wrote:
> On 13/05/17 07:47, Raveendra Padasalagi wrote:
>>
>> The third argument of devm_request_threaded_irq() is the primary
>> handler. It is called in hardirq context and checks whether the
>> interrupt is relevant to the device. If the primary handler returns
>> IRQ_WAKE_THREAD, the secondary handler (a.k.a. handler thread) is
>> scheduled to run in process context.
>>
>> bcm_iproc_adc.c uses the secondary handler as the primary one
>> and the other way around. So this patch fixes the same, along with
>> re-naming the secondary handler and primary handler names properly.
>>
>> Tested on the BCM9583XX iProc SoC based boards.
>>
>> Reported-by: Pavel Roskin <plroskin@gmail.com>
>> Signed-off-by: Raveendra Padasalagi <raveendra.padasalagi@broadcom.com>
>
> So the big question questions are:
> 1) Does this bug have nasty enough effects to send it in the direction
> of stable? (sounds like it might well do to me!)

Yes, This needs to be sent to stable. I will add stable@vger.kernel.org in cc.

> 2) What patch is it fixing.  Should have a fixes tag to make life easy
> for those handling older trees.
>

Ok, I will send out a new patch with fixes tag.

> Otherwise, looks sensible to me.
>
> Jonathan
>
>> ---
>>   drivers/iio/adc/bcm_iproc_adc.c | 8 ++++----
>>   1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/iio/adc/bcm_iproc_adc.c
>> b/drivers/iio/adc/bcm_iproc_adc.c
>> index 21d38c8..7f4f9c4 100644
>> --- a/drivers/iio/adc/bcm_iproc_adc.c
>> +++ b/drivers/iio/adc/bcm_iproc_adc.c
>> @@ -143,7 +143,7 @@ static void iproc_adc_reg_dump(struct iio_dev
>> *indio_dev)
>>         iproc_adc_dbg_reg(dev, adc_priv, IPROC_SOFT_BYPASS_DATA);
>>   }
>>   -static irqreturn_t iproc_adc_interrupt_handler(int irq, void *data)
>> +static irqreturn_t iproc_adc_interrupt_thread(int irq, void *data)
>>   {
>>         u32 channel_intr_status;
>>         u32 intr_status;
>> @@ -167,7 +167,7 @@ static irqreturn_t iproc_adc_interrupt_handler(int
>> irq, void *data)
>>         return IRQ_NONE;
>>   }
>>   -static irqreturn_t iproc_adc_interrupt_thread(int irq, void *data)
>> +static irqreturn_t iproc_adc_interrupt_handler(int irq, void *data)
>>   {
>>         irqreturn_t retval = IRQ_NONE;
>>         struct iproc_adc_priv *adc_priv;
>> @@ -181,7 +181,7 @@ static irqreturn_t iproc_adc_interrupt_thread(int irq,
>> void *data)
>>         adc_priv = iio_priv(indio_dev);
>>         regmap_read(adc_priv->regmap, IPROC_INTERRUPT_STATUS,
>> &intr_status);
>> -       dev_dbg(&indio_dev->dev,
>> "iproc_adc_interrupt_thread(),INTRPT_STS:%x\n",
>> +       dev_dbg(&indio_dev->dev,
>> "iproc_adc_interrupt_handler(),INTRPT_STS:%x\n",
>>                         intr_status);
>>         intr_channels = (intr_status & IPROC_ADC_INTR_MASK) >>
>> IPROC_ADC_INTR;
>> @@ -566,8 +566,8 @@ static int iproc_adc_probe(struct platform_device
>> *pdev)
>>         }
>>         ret = devm_request_threaded_irq(&pdev->dev, adc_priv->irqno,
>> -                               iproc_adc_interrupt_thread,
>>                                 iproc_adc_interrupt_handler,
>> +                               iproc_adc_interrupt_thread,
>>                                 IRQF_SHARED, "iproc-adc", indio_dev);
>>         if (ret) {
>>                 dev_err(&pdev->dev, "request_irq error %d\n", ret);
>>
>
