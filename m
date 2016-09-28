Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from www381.your-server.de ([78.46.137.84]:58475 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750793AbcI1HTk (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 28 Sep 2016 03:19:40 -0400
Subject: Re: [PATCH v3] iio: temperature: maxim_thermocouple: Replace unsigned
 int with __be16/__be32 to fix endianness warnings
To: Matt Ranostay <mranostay@gmail.com>,
        sayli karnik <karniksayli1995@gmail.com>
References: <20160927181039.GA16272@sayli-HP-15-Notebook-PC>
 <CAKzfze8K65dar8LPkQscSy=ESU7M-P=PY3-VsFS4P_ufvz4fPg@mail.gmail.com>
Cc: outreachy-kernel@googlegroups.com,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <69edaf73-92f5-aa45-39f6-97a48d2c3b3b@metafoo.de>
Date: Wed, 28 Sep 2016 09:19:33 +0200
MIME-Version: 1.0
In-Reply-To: <CAKzfze8K65dar8LPkQscSy=ESU7M-P=PY3-VsFS4P_ufvz4fPg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

[...]
>>
>> diff --git a/drivers/iio/temperature/maxim_thermocouple.c b/drivers/iio/temperature/maxim_thermocouple.c
>> index 39dd202..01cad6e 100644
>> --- a/drivers/iio/temperature/maxim_thermocouple.c
>> +++ b/drivers/iio/temperature/maxim_thermocouple.c
>> @@ -123,22 +123,24 @@ static int maxim_thermocouple_read(struct maxim_thermocouple_data *data,
>>  {
>>         unsigned int storage_bytes = data->chip->read_size;
>>         unsigned int shift = chan->scan_type.shift + (chan->address * 8);
>> -       unsigned int buf;
>> +       __be16 buf1;
>> +       __be32 buf2;
>>         int ret;
>>
>> -       ret = spi_read(data->spi, (void *) &buf, storage_bytes);
>> -       if (ret)
>> -               return ret;
>> -
>>         switch (storage_bytes) {
>>         case 2:
>> -               *val = be16_to_cpu(buf);
>> +               ret = spi_read(data->spi, (void *)&buf1, storage_bytes);
>> +               *val = be16_to_cpu(buf1);
> 
> Meh don't really like having buf1, and buf2 esp since they only used
> in one branch of the switch statement. And waste 2-4 byte of stack :).
> 
> I recommend something like:
> 
> case 2: {
>         __be16 buf;
>         ret = spi_read(data->spi, (void *)&buf1, storage_bytes);
>         *val = be16_to_cpu(buf1);
>         break;
> }
> case 4:
> ....
> 

I'd be quite surprised if the compiled end result actually looks different
between this and the original patch. Compilers are quite smart these days. I
wouldn't worry too much about it and keep the original solution, since it
has a nicer code flow to it.

