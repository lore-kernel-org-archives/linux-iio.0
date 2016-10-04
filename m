Return-Path: <jic23@jic23.retrosnub.co.uk>
In-Reply-To: <3e6ba1c1-a7a7-ffb1-110e-767604ef6bb5@metafoo.de>
References: <20161003192702.24361-1-jic23@kernel.org> <20161003192702.24361-3-jic23@kernel.org> <3e6ba1c1-a7a7-ffb1-110e-767604ef6bb5@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: [PATCH 02/18] staging:iio:accel:sca3000 merge files into one.
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Date: Tue, 04 Oct 2016 13:29:24 +0100
To: Lars-Peter Clausen <lars@metafoo.de>,Jonathan Cameron <jic23@kernel.org>,linux-iio@vger.kernel.org
CC: knaack.h@gmx.de,pmeerw@pmeerw.net
Message-ID: <5E0F4E5E-A43D-4721-9317-B0BB294B86AA@jic23.retrosnub.co.uk>
List-ID: <linux-iio@vger.kernel.org>



On 4 October 2016 09:46:02 BST, Lars-Peter Clausen <lars@metafoo.de> wrote:
>On 10/03/2016 09:26 PM, Jonathan Cameron wrote:
>> In the early days of IIO we were much more inclined to keep the
>impact
>> of the core IIO elements to the minimum.  As time has moved on it has
>> become clear that hardly any builds are done without buffer support
>> and that it adds considerable complexity to the drivers.
>> 
>> Hence merge down the buffer and non buffer elements of the sca3000
>driver
>> also allowing us to drop the header file used for the interfaces
>between
>> the two.
>> 
>> Signed-off-by: Jonathan Cameron <jic23@kernel.org>
>> ---
>>  drivers/staging/iio/accel/Makefile                 |   3 +-
>>  .../iio/accel/{sca3000_core.c => sca3000.c}        | 498
>++++++++++++++++++++-
>>  drivers/staging/iio/accel/sca3000.h                | 279
>------------
>>  drivers/staging/iio/accel/sca3000_ring.c           | 350
>---------------
>>  4 files changed, 496 insertions(+), 634 deletions(-)
>> 
>> diff --git a/drivers/staging/iio/accel/Makefile
>b/drivers/staging/iio/accel/Makefile
>> index 1810a434a755..6ab95708e696 100644
>> --- a/drivers/staging/iio/accel/Makefile
>> +++ b/drivers/staging/iio/accel/Makefile
>> @@ -14,5 +14,4 @@ obj-$(CONFIG_ADIS16209) += adis16209.o
>>  adis16240-y             := adis16240_core.o
>>  obj-$(CONFIG_ADIS16240) += adis16240.o
>>  
>> -sca3000-y		:= sca3000_core.o sca3000_ring.o
>> -obj-$(CONFIG_SCA3000)	+= sca3000.o
>> +obj-$(CONFIG_SCA3000)	:= sca3000.o
>
>This is fixed when moving the driver out of staging, but using :=
>instead of
>+= here disables all other drivers that came before this one.
Gah. Will fix

-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
