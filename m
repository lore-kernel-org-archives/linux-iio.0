Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:51817 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966250AbeF1Nrp (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 28 Jun 2018 09:47:45 -0400
Received: by mail-wm0-f66.google.com with SMTP id w137-v6so9806939wmw.1
        for <linux-iio@vger.kernel.org>; Thu, 28 Jun 2018 06:47:44 -0700 (PDT)
References: <20180622182555.000032b6@huawei.com> <1530086736-8005-1-git-send-email-m.othacehe@gmail.com> <1530086736-8005-2-git-send-email-m.othacehe@gmail.com> <alpine.DEB.2.21.1806272103130.5231@vps.pmeerw.net>
From: Mathieu Othacehe <m.othacehe@gmail.com>
To: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: linux-iio@vger.kernel.org, jonathan.cameron@huawei.com,
        pierre-moana.levesque@parrot.com
Subject: Re: [PATCH v2 2/2] iio: light: isl29501: Add support for the ISL29501 ToF sensor.
In-reply-to: <alpine.DEB.2.21.1806272103130.5231@vps.pmeerw.net>
Date: Thu, 28 Jun 2018 15:47:42 +0200
Message-ID: <87tvpnt43l.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


Hi Peter,

Thanks for your comments.

>
> there is no call to register_read() which is unlocked, maybe move the 
> locking into the function?

Sure, I will lock/unlock mutexes in register_read and register_write
functions. 

>> +		.channel = ISL29501_MAGNITUDE_CHANNEL,
>
> .channel not needed?

I use this channel field to distinguish between channels of the same
type in read_raw and write_raw functions so I'd rather keep it, unless
there is a better way?

> 3.14 is a poor approximation :)
>
>> +		*val2 = 6553600;

Indeed :)

I'll use IIO_VAL_INT_PLUS_NANO to express this with the best
possible precision.

I'll post a v3 soon taking your remarks into account.

Mathieu
