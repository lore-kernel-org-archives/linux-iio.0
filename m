Return-Path: <SRS0=023H=3G=gmail.com=singhalsimran0@kernel.org>
MIME-Version: 1.0
In-Reply-To: <f6c27795-30e3-1353-92c5-5352d8727137@kernel.org>
References: <20170328202147.GA21830@singhal-Inspiron-5558> <f6c27795-30e3-1353-92c5-5352d8727137@kernel.org>
From: SIMRAN SINGHAL <singhalsimran0@gmail.com>
Date: Thu, 30 Mar 2017 02:58:05 +0530
Message-ID: <CALrZqyOazbo32ZT26VxUH3nco1KkVgQV5zfzqQRyqoV-sUA7Mg@mail.gmail.com>
Subject: Re: [PATCH] iio: dac: ad5504: constify attribute_group structures
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>,
	Hartmut Knaack <knaack.h@gmx.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	outreachy-kernel <outreachy-kernel@googlegroups.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Thu, Mar 30, 2017 at 2:39 AM, Jonathan Cameron <jic23@kernel.org> wrote:
> On 28/03/17 21:21, simran singhal wrote:
>> Check for attribute_group structures that are only stored in the
>> event_attrs filed of iio_info structure. As the event_attrs field of
>> iio_info structures is constant, so these attribute_group structures can
>> also be declared constant. Done using coccinelle:
>>
>> @r1 disable optional_qualifier @
>> identifier i;
>> position p;
>> @@
>> static struct attribute_group i@p = {...};
>>
>> @ok1@
>> identifier r1.i;
>> position p;
>> struct iio_info x;
>> @@
>> x.event_attrs=&i@p;
>>
>> @bad@
>> position p!={r1.p,ok1.p};
>> identifier r1.i;
>> @@
>> i@p
>>
>> @depends on !bad disable optional_qualifier@
>> identifier r1.i;
>> @@
>> static
>> +const
>> struct attribute_group i={...};
>>
>> @depends on !bad disable optional_qualifier@
>> identifier r1.i;
>> @@
>> +const
>> struct attribute_group i;
>>
>> File size before:
>>    text    data     bss     dec     hex filename
>>    3046     360       0    3406     d4e drivers/iio/dac/ad5504.o
>>
>> File size after:
>>    text          data     bss     dec     hex filename
>>    3110           296       0    3406     d4e drivers/iio/dac/ad5504.o
>>
>> Signed-off-by: simran singhal <singhalsimran0@gmail.com>
> Applied to the togreg branch of iio.git and pushed out as testing
> for the autobuilders to play with it.
>
But my tree is up-to-date and I also test it before sending.

> Thanks,
>
> Jonathan
>> ---
>>  drivers/iio/dac/ad5504.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/iio/dac/ad5504.c b/drivers/iio/dac/ad5504.c
>> index 788b3d6..22a027d 100644
>> --- a/drivers/iio/dac/ad5504.c
>> +++ b/drivers/iio/dac/ad5504.c
>> @@ -212,7 +212,7 @@ static struct attribute *ad5504_ev_attributes[] = {
>>       NULL,
>>  };
>>
>> -static struct attribute_group ad5504_ev_attribute_group = {
>> +static const struct attribute_group ad5504_ev_attribute_group = {
>>       .attrs = ad5504_ev_attributes,
>>  };
>>
>>
>
