Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:57998 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932446AbcIEUEl (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 5 Sep 2016 16:04:41 -0400
Subject: Re: A potential bug in drivers/iio/light/opt3001.ko
To: Pavel Andrianov <andrianov@ispras.ru>
References: <e5806302-9d1b-b262-766a-e64ca9a0159c@ispras.ru>
 <61728463-8bd8-c68e-ef4a-7a3e0ddd7899@kernel.org>
 <0bb361fc-5912-eae2-e081-05e45f774798@ispras.ru>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexander Koch <mail@alexanderkoch.net>,
        Vaishali Thakkar <vaishali.thakkar@oracle.com>,
        ldv-project@linuxtesting.org,
        Andreas Dannenberg <dannenberg@ti.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <0a1ed5de-b22a-dd74-7d12-2fc92f65d2fc@kernel.org>
Date: Mon, 5 Sep 2016 21:04:38 +0100
MIME-Version: 1.0
In-Reply-To: <0bb361fc-5912-eae2-e081-05e45f774798@ispras.ru>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 05/09/16 15:15, Pavel Andrianov wrote:
> 03.09.2016 19:38, Jonathan Cameron пишет:
>> On 31/08/16 11:23, Pavel Andrianov wrote:
>>> Hi!
>>>
>>> There is a bug in drivers/iio/light/opt3001.ko. Regard such case:
>>>
>>> Thread 1                             Thread 2
>>> -> opt3001_read_raw
>>>   -> mutex_lock(&opt->lock)
>>>   -> opt3001_get_lux()
>>>     ..
>>>     ->i2c_smbus_write_word_swapped()
>>>             Now an interrupt comes
>>>                                      -> opt3001_irq
>>>                                        -> mutex_lock(&opt->lock)
>>>
>>> This is a deadlock, as the flag ok_to_ignore_lock has not been set yet.
>> Good find.  Will need reordering to set the ok_to_ignore_lock first.
>> Whether it ever actually happens will depend on just how long that EOC
>> interrupt takes to happen.  Still it's a theoretical problem with
>> a fairly simple fix so let's fix it.
>>>
>>> Regard another case:
>>>
>>> Thread 1                             Thread 2
>>> -> opt3001_read_raw
>>>   -> mutex_lock(&opt->lock)
>>>   -> opt3001_get_lux()
>>>     ..
>>>     -> i2c_smbus_write_word_swapped()
>>>     opt->ok_to_ignore_lock = true;
>>>             Now an interrupt comes
>>>                                      -> opt3001_irq
>>>                                        ..
>>>                                        opt->result_ready = true
>>>                                        wake_up()
>>>      opt->result_ready = false;
>>>      wait_event_timeout()
>>>
>>> In this case the first thread misses the result and waits until timeout expires.
>>>
>> Agreed - looks like some reordering is needed here as well.
>>
>> Jonathan
>>
> 
> In opt3001_get_lux has a comment, that i2c_smbus_write_word_swapped
> (line 246) enables interrupt mechanism. If an interrupt can not arise
> before the function, the assignments to both of flags should be moved
> before i2c_smbus_write_word_swapped and this is the best fix for both
> of issues. Do you know if my assumption is correct and interrupts are
> disabled before i2c_smbus_write_word_swapped call?

Andreas, can you confirm this for us?

Thanks,

Jonathan

