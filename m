Return-Path: <Michael.Hennerich@analog.com>
Message-ID: <4FD5B743.7070500@analog.com>
Date: Mon, 11 Jun 2012 11:15:47 +0200
From: Michael Hennerich <michael.hennerich@analog.com>
Reply-To: <michael.hennerich@analog.com>
MIME-Version: 1.0
To: Shubhrajyoti Datta <omaplinuxkernel@gmail.com>
CC: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"jic23@kernel.org" <jic23@kernel.org>, "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>, "device-drivers-devel@blackfin.uclinux.org"
	<device-drivers-devel@blackfin.uclinux.org>
Subject: Re: [PATCH] iio: ad9523: Fix argument type mismatch
References: <1339401064-5218-1-git-send-email-michael.hennerich@analog.com> <CAM=Q2ctNYnq9S9fr4K6sh+k3311nMON8Yho+-vAdd3dSdOXRHg@mail.gmail.com>
In-Reply-To: <CAM=Q2ctNYnq9S9fr4K6sh+k3311nMON8Yho+-vAdd3dSdOXRHg@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
List-ID: <linux-iio@vger.kernel.org>

On 06/11/2012 11:02 AM, Shubhrajyoti Datta wrote:
> Hi Michael,
>
> On Mon, Jun 11, 2012 at 1:21 PM,<michael.hennerich@analog.com>  wrote:
>> From: Michael Hennerich<michael.hennerich@analog.com>
>>
>> drivers/iio/frequency/ad9523.c:378 ad9523_vco_out_map()
>>          warn: value 2 can't fit into 1 'out'
>>
>> Signed-off-by: Michael Hennerich<michael.hennerich@analog.com>
>> Reported-by: Dan Carpenter<dan.carpenter@oracle.com>
>> ---
>>   drivers/iio/frequency/ad9523.c |    2 +-
>>   1 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/drivers/iio/frequency/ad9523.c b/drivers/iio/frequency/ad9523.c
>> index 7272924..43f47d9 100644
>> --- a/drivers/iio/frequency/ad9523.c
>> +++ b/drivers/iio/frequency/ad9523.c
>> @@ -361,7 +361,7 @@ static int ad9523_io_update(struct iio_dev *indio_dev)
>>   }
>>
>>   static int ad9523_vco_out_map(struct iio_dev *indio_dev,
>> -                             unsigned ch, bool out)
>> +                             unsigned ch, unsigned out)
> Unsigned defaults to unsigned int right shouldnt it be a char?
> Or am I missing something.
>
Hi Shubhrajyoti,

can you explain why this matters?
If you take a closer look at the disassembly -
you will notice that 'unsigned int' will generate nicer code.

-- 
Greetings,
Michael

--
Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
Sitz der Gesellschaft: Muenchen; Registergericht: Muenchen HRB 40368;
Geschaeftsfuehrer:Dr.Carsten Suckrow, Thomas Wessel, William A. Martin,
Margaret Seif
