Return-Path: <andrianov@ispras.ru>
From: Pavel Andrianov <andrianov@ispras.ru>
Subject: A potential bug in drivers/iio/light/opt3001.ko
To: Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Alexander Koch <mail@alexanderkoch.net>,
 Vaishali Thakkar <vaishali.thakkar@oracle.com>, ldv-project@linuxtesting.org
Message-ID: <e5806302-9d1b-b262-766a-e64ca9a0159c@ispras.ru>
Date: Wed, 31 Aug 2016 13:23:39 +0300
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-iio@vger.kernel.org>

Hi!

There is a bug in drivers/iio/light/opt3001.ko. Regard such case:

Thread 1                             Thread 2
-> opt3001_read_raw
   -> mutex_lock(&opt->lock)
   -> opt3001_get_lux()
     ..
     ->i2c_smbus_write_word_swapped()
             Now an interrupt comes
                                      -> opt3001_irq
                                        -> mutex_lock(&opt->lock)

This is a deadlock, as the flag ok_to_ignore_lock has not been set yet.

Regard another case:

Thread 1                             Thread 2
-> opt3001_read_raw
   -> mutex_lock(&opt->lock)
   -> opt3001_get_lux()
     ..
     -> i2c_smbus_write_word_swapped()
     opt->ok_to_ignore_lock = true;
             Now an interrupt comes
                                      -> opt3001_irq
                                        ..
                                        opt->result_ready = true
                                        wake_up()
      opt->result_ready = false;
      wait_event_timeout()

In this case the first thread misses the result and waits until timeout 
expires.

-- 
Pavel Andrianov
Linux Verification Center, ISPRAS
web: http://linuxtesting.org
e-mail: andrianov@ispras.ru
