Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:57090 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752016AbcLCOj0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 3 Dec 2016 09:39:26 -0500
Subject: Re: [PATCH 10/39] Annotate hardware config module parameters in
 drivers/iio/
To: William Breathitt Gray <vilhelm.gray@gmail.com>,
        David Howells <dhowells@redhat.com>
References: <148059537897.31612.9461043954611464597.stgit@warthog.procyon.org.uk>
 <148059545558.31612.1279403857733187213.stgit@warthog.procyon.org.uk>
 <20161201135025.GB30135@sophia>
Cc: linux-kernel@vger.kernel.org, gnomes@lxorguk.ukuu.org.uk,
        minyard@acm.org, linux-iio@vger.kernel.org,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <627966ae-2071-e755-5506-6b98b97e0f8f@kernel.org>
Date: Sat, 3 Dec 2016 09:05:05 +0000
MIME-Version: 1.0
In-Reply-To: <20161201135025.GB30135@sophia>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 01/12/16 13:50, William Breathitt Gray wrote:
> On Thu, Dec 01, 2016 at 12:30:55PM +0000, David Howells wrote:
>> When the kernel is running in secure boot mode, we lock down the kernel to
>> prevent userspace from modifying the running kernel image.  Whilst this
>> includes prohibiting access to things like /dev/mem, it must also prevent
>> access by means of configuring driver modules in such a way as to cause a
>> device to access or modify the kernel image.
>>
>> To this end, annotate module_param* statements that refer to hardware
>> configuration and indicate for future reference what type of parameter they
>> specify.  The parameter parser in the core sees this information and can
>> skip such parameters with an error message if the kernel is locked down.
>> The module initialisation then runs as normal, but just sees whatever the
>> default values for those parameters is.
>>
>> Note that we do still need to do the module initialisation because some
>> drivers have viable defaults set in case parameters aren't specified and
>> some drivers support automatic configuration (e.g. PNP or PCI) in addition
>> to manually coded parameters.
>>
>> This patch annotates drivers in drivers/iio/.
>>
>> Suggested-by: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
>> Signed-off-by: David Howells <dhowells@redhat.com>
>> cc: William Breathitt Gray <vilhelm.gray@gmail.com>
>> cc: Jonathan Cameron <jic23@kernel.org>
>> cc: linux-iio@vger.kernel.org
> 
> Acked-by: William Breathitt Gray <vilhelm.gray@gmail.com>
Hi David,

I'm on a train so can't check the original thread right now (and will probably
forget to do so later!). I am guessing the new functions are introduced
earlier in the series?  Hence for now I'll assume you want to merge
this lot in one go.

Acked-by: Jonathan Cameron <jic23@kernel.org>

Shout if you want me to take this via the IIO tree after the merge window
closes.

Thanks,

Jonathan
> 
>> ---
>>
>> drivers/iio/adc/stx104.c  |    2 +-
>> drivers/iio/dac/cio-dac.c |    2 +-
>> 2 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/iio/adc/stx104.c b/drivers/iio/adc/stx104.c
>> index 7e3645749eaf..a805bd543acb 100644
>> --- a/drivers/iio/adc/stx104.c
>> +++ b/drivers/iio/adc/stx104.c
>> @@ -49,7 +49,7 @@
>>
>> static unsigned int base[max_num_isa_dev(STX104_EXTENT)];
>> static unsigned int num_stx104;
>> -module_param_array(base, uint, &num_stx104, 0);
>> +module_param_hw_array(base, uint, ioport, &num_stx104, 0);
>> MODULE_PARM_DESC(base, "Apex Embedded Systems STX104 base addresses");
>>
>> /**
>> diff --git a/drivers/iio/dac/cio-dac.c b/drivers/iio/dac/cio-dac.c
>> index 5a743e2a779d..dac086129edf 100644
>> --- a/drivers/iio/dac/cio-dac.c
>> +++ b/drivers/iio/dac/cio-dac.c
>> @@ -39,7 +39,7 @@
>>
>> static unsigned int base[max_num_isa_dev(CIO_DAC_EXTENT)];
>> static unsigned int num_cio_dac;
>> -module_param_array(base, uint, &num_cio_dac, 0);
>> +module_param_hw_array(base, uint, ioport, &num_cio_dac, 0);
>> MODULE_PARM_DESC(base, "Measurement Computing CIO-DAC base addresses");
>>
>> /**
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

