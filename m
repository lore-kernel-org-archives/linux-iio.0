Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC28827442
	for <linux-iio@vger.kernel.org>; Sun,  1 Mar 2026 23:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772407061; cv=none; b=sETl8LhQH4QLFfhVnCoHFp7aYzpVeYt17M98i5bgReRWm8KBNB7o1wE4cz3/E+v1J7ngtCe1ARu+7GGtRdUIfr6OiCbXLUYKc3hOI3l1LdomV+5IsERXRVTsK0gR3UmjD98FWnOuOCYc5pPYKOZ9AdGIceEFaru+xiiAUYMV4HM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772407061; c=relaxed/simple;
	bh=Va2zjAn/HenbczIWmSFI/ZyIqa/Tu1hKfaTvQ3GHfI4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OWRXPTBf5+il/o7dp358nMFYRSQXSzwYqMSXw5LAFJCG6nGIWALYemQPQu0vSi1+wsZR/gT+8mNHpC96veqt+1CsZD4qQaE/QUUqdjL6KEpGeH+XGoi6VQGIcGrdvtgr5vwrpzhU9B/AVPaSW0x4mr1mN1RmsFjjlZRt3QDCFRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=hwEwl2/8; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="hwEwl2/8"
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-463a0e14b4cso1530129b6e.1
        for <linux-iio@vger.kernel.org>; Sun, 01 Mar 2026 15:17:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1772407058; x=1773011858; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KrxaJO0xeL7dG2e7FAM/v7W5HhDcKTT4dj4GlEphmjY=;
        b=hwEwl2/8e5MYL5gb7krK0pyGFvd8Anelww/cYl/P89MOY7Q+gWYHu0EK2kXQjKY0T5
         9xD+6h1nfFwO3TGJvm0rWg/FSdbCgElI2MT1BQdP55tcTEXqG2jl02+PQP28rtBPGJck
         ylbXutnIaIZ/vGoFHWQnOozRs4xEvnTfAFH5MDKsgEyn9xgsSrABUZXCIDQn5XmyyUxS
         r/mor0zslJukeCPUD/feyYLnYXB2ew41dpo18KOgKRqDkTc6P/tR/cinHgXjP4yHEWPI
         N+gdbDUypa94FAnvbUQpl/HNlZ4lajrE0MJMaerwsL+Ll7hyx9dVZjRbbPNxXBH+i+ws
         kRiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772407058; x=1773011858;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KrxaJO0xeL7dG2e7FAM/v7W5HhDcKTT4dj4GlEphmjY=;
        b=NyJIWsxK+VsNVZAKgSaA+EQIzAWarsxrGrNtglBaYcZujRpcl88KfnebcuCUgacL9Z
         d2ZFliWM/cm5h36tWLc6eO0fujGxYtrCkrSYnJkvSegTWg4eJ8aOcz0cRJa3gBWhPItI
         bbG3ih+6k49x3Ik6ie4QvZxlfWvJZibUQslNnWTGS7Dbj4lo1q1awlKGiZhqDQz/zdvo
         ABx/Nnr1L+rlrVWn3y5QxczS36OI0HXEVr7ArTaAPB1SyQ/ddWgFscaVES2CWNkEBUdb
         UBqrQwi5ZN1PX2D1JIgyRTty1BACrHK//3AJWeqMU9rJipAQYywcHHDWFtZVEEgi41+1
         1WEA==
X-Forwarded-Encrypted: i=1; AJvYcCWU3ta7xDDHboBJ7pobbDNIzEGs++sCrMsGsFsVeucDSwR2Yn50bTSzBjzYAjBDORedGsuxV6rfvXw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7SrqR0fsi6TpZUlukHrHXMkpnMQTnETqe/TRFhwjeTfG75T6O
	cQYOxh30UtiUXai2kYdHK6qy0259/9JsZ718WnZVtp9cgJ0lFYM8JMjO1p11meE0HsgmVv9mUay
	z+ALP
X-Gm-Gg: ATEYQzzeaj7USRBjLt666j862g51IksK/FX/9WniWF+JQ6ZucikN4YofWyvt0T1EwtP
	GCBFJkNIm/Uir8Ro5u36viAQZjL84onWmHoFg6UGL1axs8QyKldg24sby4tSIpK4mrYoiGEdiDM
	AUINjXSmVlfAOBMtWYWG9iaqebmN6fsvq0l2j4RyclT57UXjoXvom8oMFaYJta4dN+mIrrMpTgD
	i5Qg5OrNmt8NONpFhrP1R8x1miz2FtiJf4XX90aL+i8sweqVY20FHykyKvY5wjh5AtnwoqHHskP
	NsE/8SQjnMIcL7KBqmzVm7tuRc1FZCGBcWWyQR+Ie7evQJ6aeQf9vkti2Sid/kfW7wW0IoOXu6E
	0Gs8uMseg3Pf3SjJwVyo69B64Bb9cHRKXAcqrW4EI9IgwinyDBNHlUHo0d7q4KidCGiRw0A3v6i
	sYhbCO6ZSqPn2CiMCIx0k1GrO6jMOXAyKQWKGuINBAoGaYvhKzRRvxDhzplRvcrB15roB8+CP2L
	g==
X-Received: by 2002:a05:6808:2205:b0:45e:f947:c8e2 with SMTP id 5614622812f47-464bf033567mr5854954b6e.62.1772407057701;
        Sun, 01 Mar 2026 15:17:37 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:8b9c:d657:204d:5a5f? ([2600:8803:e7e4:500:8b9c:d657:204d:5a5f])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-464bb3ab3e5sm6559584b6e.6.2026.03.01.15.17.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Mar 2026 15:17:36 -0800 (PST)
Message-ID: <ec6ff19b-f8c8-405b-bfaf-02da522782fd@baylibre.com>
Date: Sun, 1 Mar 2026 17:17:35 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [tip: irq/core] genirq: Warn about using IRQF_ONESHOT without a
 threaded handler
To: Jonathan Cameron <jic23@kernel.org>,
 srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Bert Karwatzki <spasswolf@web.de>, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, Jiri Kosina <jikos@kernel.org>,
 Thomas Gleixner <tglx@kernel.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>
References: <20260113120541.YVf2vRA3@linutronix.de>
 <20260202232741.13380-1-spasswolf@web.de>
 <20260203083826.1gOzxrwt@linutronix.de>
 <0a3433112f0bec3d5bd76c7ae9b6774b455203a6.camel@linux.intel.com>
 <20260207154218.2053c98c@jic23-huawei>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260207154218.2053c98c@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2/7/26 9:42 AM, Jonathan Cameron wrote:
> On Tue, 03 Feb 2026 09:29:25 -0800
> srinivas pandruvada <srinivas.pandruvada@linux.intel.com> wrote:
> 
>> On Tue, 2026-02-03 at 09:38 +0100, Sebastian Andrzej Siewior wrote:
>>> On 2026-02-03 00:27:40 [+0100], Bert Karwatzki wrote:  
>>>>
>>>> The warning appears because iio_triggered_buffer_setup_ext() (in 
>>>> drivers/iio/buffer/industrialio-triggered-buffer.c) is called with
>>>> thread = NULL
>>>> during the probe of the iio device and calls iio_alloc_pollfunc()
>>>> (in drivers/iio/industrialio-trigger.c) with thread = NULL and type
>>>> = IRQF_ONESHOT.


I noticed this while testing hid-sensor-rotation.
    
------------[ cut here ]------------
WARNING: kernel/irq/manage.c:1502 at __setup_irq+0xdc/0x864, CPU#0: bash/425
 CPU: 0 UID: 0 PID: 425 Comm: bash Not tainted 7.0.0-rc1-next-20260227ad7944-mainline-00005-g4d0a79e89547-dirty #54 PREEMPT
Hardware name: Generic DA850/OMAP-L138/AM18x
Call trace:
 unwind_backtrace from show_stack+0x10/0x14
 show_stack from dump_stack_lvl+0x3c/0x4c
 dump_stack_lvl from __warn+0x8c/0x108
 __warn from warn_slowpath_fmt+0x1a8/0x1bc
 warn_slowpath_fmt from __setup_irq+0xdc/0x864
 __setup_irq from request_threaded_irq+0xbc/0x170
 request_threaded_irq from iio_trigger_attach_poll_func+0x8c/0x174
 iio_trigger_attach_poll_func from __iio_update_buffers+0x9f8/0xa60
 __iio_update_buffers from enable_store+0x88/0xd8
 enable_store from kernfs_fop_write_iter+0x10c/0x1f8
 kernfs_fop_write_iter from vfs_write+0x220/0x3c0
 vfs_write from ksys_write+0x6c/0xec
 ksys_write from ret_fast_syscall+0x0/0x44
Exception stack(0xc49a5fa8 to 0xc49a5ff0)
5fa0:                   00000002 00125a08 00000001 00125a08 00000002 00000000
5fc0: 00000002 00125a08 b6f6dd50 00000004 00000002 00000004 00000000 00118fd8
5fe0: 00000000 bed6f71c b6e9260c b6eee04c
---[ end trace 0000000000000000 ]---

>>>>
>>>> A simple fix could be this:
>>>>
>>>> diff --git a/drivers/iio/buffer/industrialio-triggered-buffer.c
>>>> b/drivers/iio/buffer/industrialio-triggered-buffer.c
>>>> index 9bf75dee7ff8..40eea3a44724 100644
>>>> --- a/drivers/iio/buffer/industrialio-triggered-buffer.c
>>>> +++ b/drivers/iio/buffer/industrialio-triggered-buffer.c
>>>> @@ -64,7 +64,7 @@ int iio_triggered_buffer_setup_ext(struct iio_dev
>>>> *indio_dev,
>>>>  
>>>>         indio_dev->pollfunc = iio_alloc_pollfunc(h,
>>>>                                                  thread,
>>>> -                                                IRQF_ONESHOT,
>>>> +                                                thread ?
>>>> IRQF_ONESHOT : 0,
>>>>                                                  indio_dev,
>>>>                                                  "%s_consumer%d",
>>>>                                                  indio_dev->name,
>>>>
>>>>
>>>> Are there any problems with this?  
>>>
>>> Urgh. Haven't seen those.
>>>
>>> Looking at all the users of of *iio_triggered_buffer_setup*() the
>>> primary handler is either NULL or iio_pollfunc_store_time(). 
>>> So IRQF_ONESHOST should work all the time.
>>>
>>> Then there is 
>>> - drivers/iio/adc/vf610_adc.c 
>>> - drivers/iio/common/hid-sensors/hid-sensor-trigger.c
>>>
>>> They use iio_pollfunc_store_time() as primary and have no secondary.
>>> This would trigger the warning but not having a secondary handler
>>> while
>>> returning IRQF_WAKE_THREAD should create a warning of its own.
>>> What did I miss?
>>>   
>>
>> hid-sensor doesn't need a bh handler. This patch can fix. 
>>
>> diff --git a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
>> b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
>> index 5540e2d28f4a..b2b09b544f43 100644
>> --- a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
>> +++ b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
>> @@ -227,6 +227,11 @@ static const struct iio_trigger_ops
>> hid_sensor_trigger_ops = {
>>         .set_trigger_state = &hid_sensor_data_rdy_trigger_set_state,
>>  };
>>  
>> +static irqreturn_t triggered_buffer_handler(int irq, void *p)
>> +{
>> +        return IRQ_HANDLED;
>> +}
>> +
>>  int hid_sensor_setup_trigger(struct iio_dev *indio_dev, const char
>> *name,
>>                                 struct hid_sensor_common *attrb)
>>  {
>> @@ -240,7 +245,8 @@ int hid_sensor_setup_trigger(struct iio_dev
>> *indio_dev, const char *name,
>>                 fifo_attrs = NULL;
>>  
>>         ret = iio_triggered_buffer_setup_ext(indio_dev,
>> -                                            &iio_pollfunc_store_time,
>> NULL,
>> +                                            &iio_pollfunc_store_time,
>> +                                            triggered_buffer_handler,
>>                                              IIO_BUFFER_DIRECTION_IN,
>>                                              NULL, fifo_attrs);
>>         if (ret) {
>>
>>
>> Or add it to industrialio-triggered-buffer.c as a common handler for
>> all caller with no bh, whatever Jonathan prefers.
> 
> I'm confused about how this works today.  Why do we store a timestamp
> in the pollfunc structure that is never used by a bottom half?
> 
> If we have an actual top half that doesn't need a bottom half, then the
> core code can easily insert a dummy handler, or register something sensible
> in the first place.
>  


I saw that Jonathan mentioned some other more thorough approaches in
a later reply, but here is the "quick fix" I came up with.

Probably a better solution would be to allow NULL for both IRQ handlers
and just not request the IRQ in that case. I didn't have the time/energy
to dig into what it would take to do that yet.

So here it is to see if it is "good enough". The no_action function
isn't used outside of arch/ though (other than one irqchip driver)
so it makes me suspect that using it might be frowned upon.

---
From e8385576498ad2f833f89af650e3dbc230c91fc0 Mon Sep 17 00:00:00 2001
From: David Lechner <dlechner@baylibre.com>
Date: Sun, 1 Mar 2026 16:53:48 -0600
Subject: [PATCH] iio: hid-sensors: trigger: use no_action for non-interrupt
 trigger

Use the no_action special function to indicate that we aren't actually
using the interrupt for the trigger registered in hid-sensor-trigger.c.

Due to recent changes in the irq subsystem, we are now getting a warning
about a threaded interrupt being registered with only a handler for the
top half.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/common/hid-sensors/hid-sensor-trigger.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
index 5540e2d28f4a..11660adb644a 100644
--- a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
+++ b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
@@ -239,8 +239,12 @@ int hid_sensor_setup_trigger(struct iio_dev *indio_dev, const char *name,
 	else
 		fifo_attrs = NULL;
 
+	/*
+	 * There is no interrupt for the trigger. We are just using this to have
+	 * a trigger automatically attached to the buffer.
+	 */
 	ret = iio_triggered_buffer_setup_ext(indio_dev,
-					     &iio_pollfunc_store_time, NULL,
+					     NULL, no_action,
 					     IIO_BUFFER_DIRECTION_IN,
 					     NULL, fifo_attrs);
 	if (ret) {
-- 
2.43.0

