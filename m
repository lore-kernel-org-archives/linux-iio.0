Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ob0-f170.google.com ([209.85.214.170]:55209 "EHLO
	mail-ob0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751588AbaFFPMm (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 6 Jun 2014 11:12:42 -0400
Received: by mail-ob0-f170.google.com with SMTP id nu7so1037065obb.29
        for <linux-iio@vger.kernel.org>; Fri, 06 Jun 2014 08:12:41 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <5391D279.5060909@metafoo.de>
References: <1402065052-32161-1-git-send-email-josselin.costanzi@mobile-devices.fr>
 <5391D279.5060909@metafoo.de>
From: Josselin Costanzi <josselin.costanzi@mobile-devices.fr>
Date: Fri, 6 Jun 2014 17:12:21 +0200
Message-ID: <CAJA4uhc+RdEmOgyK8f3VHTqgCdAbVtdko1EW8z3BDvFq8Y4Rzw@mail.gmail.com>
Subject: Re: [PATCH] iio: make blocking read wait for data
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

2014-06-06 16:38 GMT+02:00 Lars-Peter Clausen <lars@metafoo.de>:
>
> On 06/06/2014 04:30 PM, Josselin Costanzi wrote:
>>
>> Currently the IIO buffer blocking read only wait until at least one
>> data element is available.
>
> But that is how it is supposed to work. With this patch for example you won't be able to read the last data from the buffer after the buffer has been disabled.

I don't understand the usecase this patch breaks... If the buffer is
disabled then we return what was read alreay.


> Or if for example n is not aligned to the sample size you'll also continue to loop forever.

If n isn't aligned to the sample size, wouldn't iio_read_first_n_kfifo
still return data multiple of samples size? In that case we would copy
complete elements until we try to do a short read which would fail at
n < kfifo_esize(&kf->kf) (in iio_read_first_n_kfifo).

-- 
Josselin Costanzi
  Embedded Linux System Engineer
