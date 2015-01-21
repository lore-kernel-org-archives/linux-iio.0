Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:44194 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754146AbbAUR0D (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 21 Jan 2015 12:26:03 -0500
In-Reply-To: <CAEUmHyYkn6g28=9zqx6DLoFEFNeM1bkV4KyRJH7F7_TNatY-+w@mail.gmail.com>
References: <1421819977-32232-1-git-send-email-varkabhadram@gmail.com> <54BF7D24.5090009@metafoo.de> <CAEUmHyYkn6g28=9zqx6DLoFEFNeM1bkV4KyRJH7F7_TNatY-+w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: [PATCH iio 1/3] imu: inv_mpu6050: use devm_request_irq
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Date: Wed, 21 Jan 2015 17:25:57 +0000
To: Varka Bhadram <varkabhadram@gmail.com>,
	Lars-Peter Clausen <lars@metafoo.de>
CC: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
	Varka Bhadram <varkab@cdac.in>
Message-ID: <CA1EB95B-DE20-4917-963A-E175C1937FFC@jic23.retrosnub.co.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



On 21 January 2015 11:14:11 GMT+00:00, Varka Bhadram <varkabhadram@gmail.com> wrote:
>On Wed, Jan 21, 2015 at 3:49 PM, Lars-Peter Clausen <lars@metafoo.de>
>wrote:
>> On 01/21/2015 06:59 AM, varkabhadram@gmail.com wrote:
>> [...]
>>>
>>>   void inv_mpu6050_remove_trigger(struct inv_mpu6050_state *st)
>>>   {
>>>         iio_trigger_unregister(st->trig);
>>> -       free_irq(st->client->irq, st->trig);
>>>         iio_trigger_free(st->trig);
>>
>>
>> You are changing the relative order between free_irq() and
>> iio_trigger_free() here and by doing so introduce a use-after-free
>race
>> condition. The IRQ handler uses the trigger, so the IRQ has to be
>released
>> before the trigger is freed.
>>
>> This can be easily fixed though by changing the order of patch 1 and
>patch 2
>> in this series.
>
>It does not make any difference if we take this patch series...?
>>
>>
>>
Bad practice to introduce a bug even if for only one patch...  It made Lars review
two changes together when they were separable .

I'd prefer them reordered but will probably cope if not!
-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
