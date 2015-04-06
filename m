Return-Path: <daniel.baluta@gmail.com>
MIME-Version: 1.0
Sender: daniel.baluta@gmail.com
In-Reply-To: <1428171965.634.35.camel@x220>
References: <1428076680-28005-1-git-send-email-daniel.baluta@intel.com>
	<1428076680-28005-2-git-send-email-daniel.baluta@intel.com>
	<1428171965.634.35.camel@x220>
Date: Mon, 6 Apr 2015 16:42:45 +0300
Message-ID: <CAEnQRZAo7h65mDYceKVbSyUsz-7SEDqtxvDmhZ13ZviytELdbg@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] iio: configfs: Add configfs support to IIO
From: Daniel Baluta <daniel.baluta@intel.com>
To: Paul Bolle <pebolle@tiscali.nl>
Cc: Daniel Baluta <daniel.baluta@intel.com>, Jonathan Cameron <jic23@kernel.org>,
	Joel Becker <jlbec@evilplan.org>, Lars-Peter Clausen <lars@metafoo.de>, Hartmut Knaack <knaack.h@gmx.de>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	"octavian.purdila@intel.com" <octavian.purdila@intel.com>, Peter Meerwald <pmeerw@pmeerw.net>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Sat, Apr 4, 2015 at 9:26 PM, Paul Bolle <pebolle@tiscali.nl> wrote:
> On Fri, 2015-04-03 at 18:57 +0300, Daniel Baluta wrote:
>> --- a/drivers/iio/Kconfig
>> +++ b/drivers/iio/Kconfig
>> +config IIO_CONFIGFS
>> +     tristate "Enable IIO configuration via configfs"
>> +     select CONFIGFS_FS
>> +     help
>> +       This allows configuring various IIO bits through configfs
>> +       (e.g. software triggers). For more info see
>> +       Documentation/iio/iio_configfs.txt.
>
>> --- a/drivers/iio/Makefile
>> +++ b/drivers/iio/Makefile
>> @@ -5,6 +5,7 @@
>>  obj-$(CONFIG_IIO) += industrialio.o
>>  industrialio-y := industrialio-core.o industrialio-event.o inkern.o
>>  industrialio-$(CONFIG_IIO_BUFFER) += industrialio-buffer.o
>> +industrialio-$(CONFIG_IIO_CONFIGFS) += industrialio-configfs.o
>>  industrialio-$(CONFIG_IIO_TRIGGER) += industrialio-trigger.o
>>  industrialio-$(CONFIG_IIO_BUFFER_CB) += buffer_cb.o
>
> It seems I didn't pay attention to this Makefile the first time I looked
> at this series. And actually reading it I noticed that
> industrialio-configfs.o can only be part of the industrial.ko module,
> can't it? So this Makefile doesn't allow to build a separate
> industrialio-configfs.ko module, right? If so, my previous review, in
> which I claimed to spot a nit, was a waste of our time.
>
> Because I now experienced that if this gets build with CONFIG_IIO=m and
> CONFIG_IIO_CONFIGFS=y one gets:
>     $ make -C ../.. CONFIG_IIO_CONFIGFS=y M=$PWD industrialio.ko
>     make: Entering directory `[...]'
>       CC [M]  [...]/drivers/iio/industrialio-core.o
>       CC [M]  [...]/linux/drivers/iio/industrialio-event.o
>       CC [M]  [...]drivers/iio/inkern.o
>       CC [M]  [...]/drivers/iio/industrialio-buffer.o
>       CC [M]  [...]/drivers/iio/industrialio-configfs.o
>       CC [M]  [...]/drivers/iio/industrialio-trigger.o
>       CC [M]  [...]/drivers/iio/buffer_cb.o
>       LD [M]  [...]/drivers/iio/industrialio.o
>     [...]/drivers/iio/industrialio-configfs.o: In function `iio_configfs_init':
>     industrialio-configfs.c:(.init.text+0x0): multiple definition of `init_module'
>     [...]/drivers/iio/industrialio-core.o:industrialio-core.c:(.init.text+0x0): first defined here
>     [...]/drivers/iio/industrialio-configfs.o: In function `iio_configfs_exit':
>     industrialio-configfs.c:(.exit.text+0x0): multiple definition of `cleanup_module'
>     [...]/drivers/iio/industrialio-core.o:industrialio-core.c:(.exit.text+0x0): first defined here
>     make[1]: *** [[...]/drivers/iio/industrialio.o] Error 1
>     make: *** [industrialio.ko] Error 2
>     make: Leaving directory `[...]'
>
> (I didn't yet test other configurations.)
>
> So before I waste even more of your time: were you trying to make
> configfs support a part of the industrialio module or were you trying to
> make configfs support available as a separate module?


Hi Paul,

Thanks a lot for review. I seee the problem now :).

I want to build a separate industrialio-configs.ko module, I will fix this
and resend asap.

thanks,
Daniel.
