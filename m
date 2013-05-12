Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:36162 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751152Ab3ELSsw (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 12 May 2013 14:48:52 -0400
In-Reply-To: <518FC54B.3090009@metafoo.de>
References: <1367860863-6863-1-git-send-email-jic23@kernel.org> <1367860863-6863-4-git-send-email-jic23@kernel.org> <518FC54B.3090009@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: [PATCH 3/4] staging:iio:triggers:interrupt trigger - one per platform device.
From: Jonathan Cameron <jic23@kernel.org>
Date: Sun, 12 May 2013 19:48:47 +0100
To: Lars-Peter Clausen <lars@metafoo.de>
CC: linux-iio@vger.kernel.org
Message-ID: <3889650b-a67e-4dbe-ab38-89924a7c1af7@email.android.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



Lars-Peter Clausen <lars@metafoo.de> wrote:

>[...]
>>  
>> @@ -39,57 +36,48 @@ static const struct iio_trigger_ops
>iio_interrupt_trigger_ops = {
>>  static int iio_interrupt_trigger_probe(struct platform_device *pdev)
>>  {
>>  	struct iio_interrupt_trigger_info *trig_info;
>> -	struct iio_trigger *trig, *trig2;
>> +	struct iio_trigger *trig;
>>  	unsigned long irqflags;
>>  	struct resource *irq_res;
>>  	int irq, ret = 0, irq_res_cnt = 0;
>>  [...]
>> +	irq_res = platform_get_resource(pdev, IORESOURCE_IRQ, irq_res_cnt);
>
>irq_res_cnt is always zero.

Oops. Thanks
>
>> [...]
>--
>To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Sent from my Android phone with K-9 Mail. Please excuse my brevity.
