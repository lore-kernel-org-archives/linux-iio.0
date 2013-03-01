Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-170.synserver.de ([212.40.185.170]:1060 "EHLO
	smtp-out-170.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750696Ab3CAPCr (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 1 Mar 2013 10:02:47 -0500
Message-ID: <5130C37D.6050907@metafoo.de>
Date: Fri, 01 Mar 2013 16:04:29 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Guenter Roeck <linux@roeck-us.net>
CC: linux-iio@vger.kernel.org
Subject: Re: IIO_BUFFER - IIO_TRIGGERED_BUFFER circular dependency
References: <20130301043222.GA5606@roeck-us.net> <5130AF56.8020407@metafoo.de> <20130301144111.GA31945@roeck-us.net>
In-Reply-To: <20130301144111.GA31945@roeck-us.net>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 03/01/2013 03:41 PM, Guenter Roeck wrote:
> On Fri, Mar 01, 2013 at 02:38:30PM +0100, Lars-Peter Clausen wrote:
>> On 03/01/2013 05:32 AM, Guenter Roeck wrote:
>>> Hi all,
>>>
>>> IIO_TRIGGERED_BUFFER depends on IIO_BUFFER because of:
>>>
>>> drivers/iio/industrialio-triggered-buffer.c:20:16: error:
>>> ‘iio_sw_buffer_preenable’ undeclared here (not in a function)
>>>
>>> On the other side, it is often selected as follows.
>>>
>>> 	select IIO_TRIGGERED_BUFFER if (IIO_BUFFER)
>>>
>>> For that reason, selecting IIO_BUFFER in the IIO_TRIGGERED_BUFFER declaration
>>> results in a circular dependency. Sometimes the "if (IIO_BUFFER)" when selecting
>>> IIO_TRIGGERED_BUFFER is missing, though, which can result in the compile error.
>>>
>>> What is the proper solution ?
>>> - Add "if (IIO_BUFFER)" whenever IIO_TRIGGERED_BUFFER is selected
>>> or
>>> - Remove "if (IIO_BUFFER)" from IIO_TRIGGERED_BUFFER selection and add "select
>>>   IIO_BUFFER" to the IIO_TRIGGERED_BUFFER declaration
>>>
>>> I would prefer the latter to solve the problem for good.
>>
>> Hi,
>>
>> This is a bit tricky, some drivers have optional buffer support, so they
>> only select the helper module if buffer support is enabled, since they don't
>> use the helper module if buffer support is disabled. Other driver though
>> always want buffer support so they select the helper module unconditionally.
>> So far it was the responsibility of the driver's Kconfig entry to make sure
>> that if it selects IIO_TRIGGERED_BUFFER it needs to make sure that
>> IIO_BUFFER is also selected. As far as I can see all drivers do this
>> currently. Which one breaks things for you?
>>
> It is a randconfig thing, so it breaks in some of my nightly randconfig builds,
> and it has also been reported as build failure in the official builds. I can dig
> out some affected configurations and send it to you if you like.

Yes that would be great, thanks.

> but the gist of
> it is that IIO_TRIGGERED_BUFFER can be selected without IIO_BUFFER, but depends
> on it. That just isn't correct. Of course, the other option might be to make
> IIO_TRIGGERED_BUFFER dependent on IIO_BUFFER. Would that be acceptable ?
> 

That won't work, you can overwrite 'depends on' by selecting the symbol.

But the reason why there is a cyclic dependency is not because of the
'select IIO_TRIGGERED_BUFFER if (IIO_BUFFER)' but rather because
IIO_TRIGGERED_BUFFER is in an 'if IIO_BUFFER' section. Moving it out there
fixes the cyclic dependency error. But creates a recursive dependency warning.

I think we could avoid this warning by introducing a new symbol. E.g.
IIO_BUFFER_INTERN (bad name). IIO_BUFFER_INTERN won't be user selectable. It
will be selected by IIO_BUFFER and IIO_TRIGGERED_BUFFER and if it is
selected buffer support is built. E.g. something like this:

diff --git a/drivers/iio/Kconfig b/drivers/iio/Kconfig
index b2f963b..f7bf173 100644
--- a/drivers/iio/Kconfig
+++ b/drivers/iio/Kconfig
@@ -14,11 +14,15 @@ if IIO

 config IIO_BUFFER
 	bool "Enable buffer support within IIO"
+	select IIO_BUFFER_INTERN
 	help
 	  Provide core support for various buffer based data
 	  acquisition methods.

-if IIO_BUFFER
+config IIO_BUFFER_INTERN
+	bool
+
+if IIO_BUFFER_INTERN

 config IIO_BUFFER_CB
 boolean "IIO callback buffer used for push in-kernel interfaces"
@@ -35,15 +39,16 @@ config IIO_KFIFO_BUF
 	  no buffer events so it is up to userspace to work out how
 	  often to read from the buffer.

+endif # IIO_BUFFER
+
 config IIO_TRIGGERED_BUFFER
 	tristate
 	select IIO_TRIGGER
 	select IIO_KFIFO_BUF
+	select IIO_BUFFER_INTERN
 	help
 	  Provides helper functions for setting up triggered buffers.

-endif # IIO_BUFFER
-
 config IIO_TRIGGER
 	boolean "Enable triggered sampling support"
 	help
diff --git a/drivers/iio/Makefile b/drivers/iio/Makefile
index a0e8cdd..a43df71 100644
--- a/drivers/iio/Makefile
+++ b/drivers/iio/Makefile
@@ -4,7 +4,7 @@

 obj-$(CONFIG_IIO) += industrialio.o
 industrialio-y := industrialio-core.o industrialio-event.o inkern.o
-industrialio-$(CONFIG_IIO_BUFFER) += industrialio-buffer.o
+industrialio-$(CONFIG_IIO_BUFFER_INTERN) += industrialio-buffer.o
 industrialio-$(CONFIG_IIO_TRIGGER) += industrialio-trigger.o
 industrialio-$(CONFIG_IIO_BUFFER_CB) += buffer_cb.o


Although this has the downside that it is not immediately visible anymore
whether buffer support is going to be built or not.

- Lars
