Return-Path: <otavio.salvador@gmail.com>
MIME-Version: 1.0
Sender: otavio.salvador@gmail.com
In-Reply-To: <20130805062059.GA28434@kroah.com>
References: <20130805062059.GA28434@kroah.com>
Date: Mon, 5 Aug 2013 08:51:56 -0300
Message-ID: <CAP9ODKo2nRivgc0dtgNm=5NUg9APCHFbb2L4CAauKv5M8rX4JA@mail.gmail.com>
Subject: Re: iio: add configuration option for debug support
From: Otavio Salvador <otavio@ossystems.com.br>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On Mon, Aug 5, 2013 at 3:20 AM, Greg KH <gregkh@linuxfoundation.org> wrote:
> On Tue, Jul 16, 2013 at 01:56:00PM +0100, Otavio Salvador wrote:
>> Signed-off-by: Otavio Salvador <otavio@ossystems.com.br>
>> Signed-off-by: Jonathan Cameron <jic23@kernel.org>
>> ---
>>  drivers/iio/Kconfig  | 7 +++++++
>>  drivers/iio/Makefile | 2 ++
>>  2 files changed, 9 insertions(+)
>>
>> diff --git a/drivers/iio/Kconfig b/drivers/iio/Kconfig
>> index 524380c..b682f6f 100644
>> --- a/drivers/iio/Kconfig
>> +++ b/drivers/iio/Kconfig
>> @@ -12,6 +12,13 @@ menuconfig IIO
>>
>>  if IIO
>>
>> +config IIO_DEBUG
>> +     boolean "Debug support for Industrial I/O"
>> +     depends on DEBUG_KERNEL
>> +     help
>> +       Say "yes" to enable debug messaging (like dev_dbg and pr_debug)
>> +       support in Industrial I/O subsystem and drivers.
>> +
>>  config IIO_BUFFER
>>       bool "Enable buffer support within IIO"
>>       help
>> diff --git a/drivers/iio/Makefile b/drivers/iio/Makefile
>> index 7a3866c..6e43e5b 100644
>> --- a/drivers/iio/Makefile
>> +++ b/drivers/iio/Makefile
>> @@ -2,6 +2,8 @@
>>  # Makefile for the industrial I/O core.
>>  #
>>
>> +ccflags-$(CONFIG_IIO_DEBUG) := -DDEBUG
>
> No, please don't do this.  I'm going to revert this patch, as iio, and
> the whole rest of the kernel, should be relying on the dynamic debug
> code.  Don't force a user to rebuild their kernel to enable/disable
> debug stuff, that doesn't work well, if at all.
>
> As it is, dev_dbg and pr_debug work just fine with dynamic debugging, no
> need to explicitly make a new Kconfig option and set the DEBUG flag on
> at all.

Thanks for the guidance Greg. Sorry for the hassle.

-- 
Otavio Salvador                             O.S. Systems
http://www.ossystems.com.br        http://projetos.ossystems.com.br
Mobile: +55 (53) 9981-7854            Mobile: +1 (347) 903-9750
