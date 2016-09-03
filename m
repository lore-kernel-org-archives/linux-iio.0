Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:45311 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753296AbcICQis (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 3 Sep 2016 12:38:48 -0400
Subject: Re: A potential bug in drivers/iio/light/opt3001.ko
To: Pavel Andrianov <andrianov@ispras.ru>
References: <e5806302-9d1b-b262-766a-e64ca9a0159c@ispras.ru>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexander Koch <mail@alexanderkoch.net>,
        Vaishali Thakkar <vaishali.thakkar@oracle.com>,
        ldv-project@linuxtesting.org,
        Andreas Dannenberg <dannenberg@ti.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <61728463-8bd8-c68e-ef4a-7a3e0ddd7899@kernel.org>
Date: Sat, 3 Sep 2016 17:38:44 +0100
MIME-Version: 1.0
In-Reply-To: <e5806302-9d1b-b262-766a-e64ca9a0159c@ispras.ru>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 31/08/16 11:23, Pavel Andrianov wrote:
> Hi!
> 
> There is a bug in drivers/iio/light/opt3001.ko. Regard such case:
> 
> Thread 1                             Thread 2
> -> opt3001_read_raw
>   -> mutex_lock(&opt->lock)
>   -> opt3001_get_lux()
>     ..
>     ->i2c_smbus_write_word_swapped()
>             Now an interrupt comes
>                                      -> opt3001_irq
>                                        -> mutex_lock(&opt->lock)
> 
> This is a deadlock, as the flag ok_to_ignore_lock has not been set yet.
Good find.  Will need reordering to set the ok_to_ignore_lock first.
Whether it ever actually happens will depend on just how long that EOC
interrupt takes to happen.  Still it's a theoretical problem with
a fairly simple fix so let's fix it.
> 
> Regard another case:
> 
> Thread 1                             Thread 2
> -> opt3001_read_raw
>   -> mutex_lock(&opt->lock)
>   -> opt3001_get_lux()
>     ..
>     -> i2c_smbus_write_word_swapped()
>     opt->ok_to_ignore_lock = true;
>             Now an interrupt comes
>                                      -> opt3001_irq
>                                        ..
>                                        opt->result_ready = true
>                                        wake_up()
>      opt->result_ready = false;
>      wait_event_timeout()
> 
> In this case the first thread misses the result and waits until timeout expires.
> 
Agreed - looks like some reordering is needed here as well.

Jonathan
