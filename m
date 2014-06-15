Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-we0-f173.google.com ([74.125.82.173]:64431 "EHLO
	mail-we0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751198AbaFOPX5 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 15 Jun 2014 11:23:57 -0400
From: Johannes Thumshirn <morbidrsa@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Dan Carpenter <dan.carpenter@oracle.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-iio@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [patch] iio: adc: checking for NULL instead of IS_ERR() in probe
References: <20140328083126.GO25192@mwanda>
	<CAGH8bx77dKAm7w53F5MfTXaPm6KxQcVCXERnW-oXmR5Ww-HLTw@mail.gmail.com>
	<5336995C.90701@kernel.org> <87lht2q86y.fsf@sauron.localdomain>
	<539C6783.4060607@kernel.org>
Date: Sun, 15 Jun 2014 17:23:53 +0200
In-Reply-To: <539C6783.4060607@kernel.org> (Jonathan Cameron's message of
	"Sat, 14 Jun 2014 16:17:23 +0100")
Message-ID: <87wqcici2e.fsf@sauron.localdomain>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Jonathan Cameron <jic23@kernel.org> writes:

> On 12/06/14 19:44, Johannes Thumshirn wrote:
>> Jonathan Cameron <jic23@kernel.org> writes:
>>
>>> On 28/03/14 14:07, johannes thumshirn wrote:
>>>> On Fri, Mar 28, 2014 at 9:33 AM, Dan Carpenter <dan.carpenter@oracle.com> wrote:
>>>>>
>>>>> mcb_request_mem() returns an ERR_PTR(), it doesn't return NULL.
>>>>>
>>>>> Fixes: 74aeac4da66f ('iio: adc: Add MEN 16z188 ADC driver')
>>>>> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
>>>>>
>>>>> diff --git a/drivers/iio/adc/men_z188_adc.c b/drivers/iio/adc/men_z188_adc.c
>>>>> index 6989c16..b58d630 100644
>>>>> --- a/drivers/iio/adc/men_z188_adc.c
>>>>> +++ b/drivers/iio/adc/men_z188_adc.c
>>>>> @@ -121,8 +121,8 @@ static int men_z188_probe(struct mcb_device *dev,
>>>>>           indio_dev->num_channels = ARRAY_SIZE(z188_adc_iio_channels);
>>>>>
>>>>>           mem = mcb_request_mem(dev, "z188-adc");
>>>>> -       if (!mem)
>>>>> -               return -ENOMEM;
>>>>> +       if (IS_ERR(mem))
>>>>> +               return PTR_ERR(mem);
>>>>>
>>>>>           adc->base = ioremap(mem->start, resource_size(mem));
>>>>>           if (adc->base == NULL)
>>>>
>>>> Acked-by: Johannes Thumshirn <johannes.thumshirn@men.de>
>>>>
>>> Acked-by: Jonathan Cameron <jic23@kernel.org>
>>>
>>> Or I can pick this up after the merge window has closed if Greg hasn't
>>> already taken it.
>>>
>>> Jonathan
>>
>> Did someone actually take this patch, or was it somehow lost?
>>
> I've picked it up now and applied it to the fixes-togreg branch of iio.git
>
> Thanks for pointing out I'd forgotten it and sorry about that. I've also
> marked it for stable.

Thanks a lot
