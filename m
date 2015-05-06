Return-Path: <khoroshilov@ispras.ru>
Message-ID: <554AA035.3060407@ispras.ru>
Date: Thu, 07 May 2015 02:13:57 +0300
From: Alexey Khoroshilov <khoroshilov@ispras.ru>
MIME-Version: 1.0
To: Fabio Estevam <festevam@gmail.com>
CC: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org,
 linux-kernel <linux-kernel@vger.kernel.org>,
 ldv-project@linuxtesting.org
Subject: Re: [PATCH] iio: hid-sensors: Fix memory leak on failure path in
 hid_prox_probe()
References: <1430948924-4756-1-git-send-email-khoroshilov@ispras.ru>	<CAOMZO5AC=SUdXh6+np_2c3vqaKjpk-rZcR_baJ3-e+qt=dxx9w@mail.gmail.com>	<554A923F.2040205@ispras.ru> <CAOMZO5C-Hv=oE4gb32OssGhH-5S4mwOLnwL1HEjCEZ82akSeRg@mail.gmail.com>
In-Reply-To: <CAOMZO5C-Hv=oE4gb32OssGhH-5S4mwOLnwL1HEjCEZ82akSeRg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-iio@vger.kernel.org>

On 07.05.2015 01:32, Fabio Estevam wrote:
> On Wed, May 6, 2015 at 7:14 PM, Alexey Khoroshilov
> <khoroshilov@ispras.ru> wrote:
> 
>> Not exactly. Other calls are after
>>   indio_dev->channels = channels;
>> So,
>> error_free_dev_mem:
>>         kfree(indio_dev->channels);
>> works for them well.
> 
> indio_dev is allocated using devm_ , so you don't need to free it.
> 
> Your patch is not correct because you only  kfree(channels) in the
> prox_parse_report() error case, but you missed the other subsequent
> functions.
> 

No! The other subsequent functions are AFTER (prox_parse_report() error
case is the only BEFORE)
  indio_dev->channels = channels;

and all consequent error cases comes to error_free_dev_mem, where

error_free_dev_mem:
       kfree(indio_dev->channels);

that is equivalent to kfree(channels);

--
Alexey
