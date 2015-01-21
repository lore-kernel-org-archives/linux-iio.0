Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-la0-f42.google.com ([209.85.215.42]:62495 "EHLO
	mail-la0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751602AbbAULOM (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 21 Jan 2015 06:14:12 -0500
Received: by mail-la0-f42.google.com with SMTP id ms9so17291145lab.1
        for <linux-iio@vger.kernel.org>; Wed, 21 Jan 2015 03:14:11 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <54BF7D24.5090009@metafoo.de>
References: <1421819977-32232-1-git-send-email-varkabhadram@gmail.com>
	<54BF7D24.5090009@metafoo.de>
Date: Wed, 21 Jan 2015 16:44:11 +0530
Message-ID: <CAEUmHyYkn6g28=9zqx6DLoFEFNeM1bkV4KyRJH7F7_TNatY-+w@mail.gmail.com>
Subject: Re: [PATCH iio 1/3] imu: inv_mpu6050: use devm_request_irq
From: Varka Bhadram <varkabhadram@gmail.com>
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
	Varka Bhadram <varkab@cdac.in>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, Jan 21, 2015 at 3:49 PM, Lars-Peter Clausen <lars@metafoo.de> wrote:
> On 01/21/2015 06:59 AM, varkabhadram@gmail.com wrote:
> [...]
>>
>>   void inv_mpu6050_remove_trigger(struct inv_mpu6050_state *st)
>>   {
>>         iio_trigger_unregister(st->trig);
>> -       free_irq(st->client->irq, st->trig);
>>         iio_trigger_free(st->trig);
>
>
> You are changing the relative order between free_irq() and
> iio_trigger_free() here and by doing so introduce a use-after-free race
> condition. The IRQ handler uses the trigger, so the IRQ has to be released
> before the trigger is freed.
>
> This can be easily fixed though by changing the order of patch 1 and patch 2
> in this series.

It does not make any difference if we take this patch series...?
>
>
>



-- 
Thanks and Regards,
Varka Bhadram.
