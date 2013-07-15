Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from exprod5og116.obsmtp.com ([64.18.0.147]:48185 "EHLO
	exprod5og116.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932272Ab3GOOyh (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 15 Jul 2013 10:54:37 -0400
Received: by mail-ob0-f176.google.com with SMTP id v19so13780438obq.7
        for <linux-iio@vger.kernel.org>; Mon, 15 Jul 2013 07:54:35 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <51E3EC8B.3090601@metafoo.de>
References: <1373461729-11261-1-git-send-email-x0199363@ti.com>
	<51E03720.1010806@metafoo.de>
	<CAGH3drqEPxW=QwadCLj=ZOQe0gp_c7mdSiNQnq1_-BMKL9CgJw@mail.gmail.com>
	<51E3EC8B.3090601@metafoo.de>
Date: Mon, 15 Jul 2013 17:54:35 +0300
Message-ID: <CAGH3dro7MxDJRB=5gsBysiKVvXLskZFuagiBMznUnAjCMoZsTQ@mail.gmail.com>
Subject: Re: [PATCH] iio: add APDS9300 ambilent light sensor driver
From: Oleksandr Kravchenko <o.v.kravchenko@globallogic.com>
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Oleksandr Kravchenko <x0199363@ti.com>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	Grant Likely <grant.likely@linaro.org>,
	Rob Herring <rob.herring@calxeda.com>,
	Rob Landley <rob@landley.net>, jic23@cam.ac.uk,
	Peter Meerwald <pmeerw@pmeerw.net>, holler@ahsoftware.de,
	srinivas.pandruvada@intel.com, devicetree-discuss@lists.ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

I can't to find devm_iio_device_alloc() in my kernel v3.11-rc1

On Mon, Jul 15, 2013 at 3:35 PM, Lars-Peter Clausen <lars@metafoo.de> wrote:
> On 07/15/2013 02:27 PM, Oleksandr Kravchenko wrote:
>> Thank you for review! But I don't completely understand one of your comment:
>>
>>>> +static int als_probe(struct i2c_client *client, const struct i2c_device_id *id)
>> [...]
>>>> +     if (client->irq) {
>>>> +             ret = devm_request_threaded_irq(&client->dev, client->irq,
>>>> +                             NULL, als_interrupt_handler,
>>>> +                             IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
>>>> +                             ALS_IRQ_NAME, indio_dev);
>>>
>>> This is a bit racy, you access memory in the irq handler that is freed
>>> before the irq is freed.
>>
>> Do you mean than that indio_dev may be used in interrupt handler after
>> iio_device_free(indio_dev) called in als_remove() function?
>>
>> If so, can I use disable_irq() in als_remove() before iio_device_free()
>> to avoid this problem?
>>
>
> Just add a devm_iio_device_alloc() and use that, instead of trying to bodch
> around the issue.
>



-- 
Oleksandr Kravchenko
GlobalLogic
P +380633213187
P +380994930248
www.globallogic.com

http://www.globallogic.com/email_disclaimer.txt
