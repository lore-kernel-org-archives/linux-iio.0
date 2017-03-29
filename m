Return-Path: <SRS0=023H=3G=gmail.com=singhalsimran0@kernel.org>
MIME-Version: 1.0
In-Reply-To: <2f65895f-52a8-df0f-0743-7cda5a7915dc@kernel.org>
References: <20170328201528.GA15455@singhal-Inspiron-5558> <2f65895f-52a8-df0f-0743-7cda5a7915dc@kernel.org>
From: SIMRAN SINGHAL <singhalsimran0@gmail.com>
Date: Thu, 30 Mar 2017 02:58:28 +0530
Message-ID: <CALrZqyOPVDA+4n56d3c+jZRsiaQ52vYEjA+Or1j8Z2LNgi58OQ@mail.gmail.com>
Subject: Re: [PATCH] iio: adc: max1363: constify attribute_group structures
To: Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	outreachy-kernel <outreachy-kernel@googlegroups.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Thu, Mar 30, 2017 at 2:41 AM, Jonathan Cameron <jic23@kernel.org> wrote:
> On 28/03/17 21:15, simran singhal wrote:
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
>>   36951     448       0   37399    9217 drivers/iio/adc/max1363.o
>>
>> File size after:
>>    text          data     bss     dec     hex filename
>>   37015           384       0   37399    9217 drivers/iio/adc/max1363.o
>>
>> Signed-off-by: simran singhal <singhalsimran0@gmail.com>
> Applied to the togreg branch of iio.git and pushed out as testing for
> the autobuilders to play with it.
>

But my tree is up-to-date and I also test it before sending.

> Thanks,
>
> Jonathan
>> ---
>>  drivers/iio/adc/max1363.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/iio/adc/max1363.c b/drivers/iio/adc/max1363.c
>> index c6c12fe..80eada4 100644
>> --- a/drivers/iio/adc/max1363.c
>> +++ b/drivers/iio/adc/max1363.c
>> @@ -1007,7 +1007,7 @@ static struct attribute *max1363_event_attributes[] = {
>>       NULL,
>>  };
>>
>> -static struct attribute_group max1363_event_attribute_group = {
>> +static const struct attribute_group max1363_event_attribute_group = {
>>       .attrs = max1363_event_attributes,
>>  };
>>
>>
>
