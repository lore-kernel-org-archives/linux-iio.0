Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-51.csi.cam.ac.uk ([131.111.8.151]:45458 "EHLO
	ppsw-51.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752799Ab0JDJvN (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 4 Oct 2010 05:51:13 -0400
Message-ID: <4CA9A4DC.3020609@cam.ac.uk>
Date: Mon, 04 Oct 2010 10:56:44 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: "Hennerich, Michael" <Michael.Hennerich@analog.com>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Drivers <Drivers@analog.com>
Subject: Re: [PATCH] staging: iio: adc: Enable driver support for ad799x AD
 converters
References: <1285926110-6678-1-git-send-email-michael.hennerich@analog.com> <1285926110-6678-2-git-send-email-michael.hennerich@analog.com> <4CA5CF74.6030606@cam.ac.uk> <544AC56F16B56944AEC3BD4E3D5917712F0DB8A636@LIMKCMBX1.ad.analog.com> <4CA60343.9050106@cam.ac.uk> <544AC56F16B56944AEC3BD4E3D5917712F0DB8A799@LIMKCMBX1.ad.analog.com>
In-Reply-To: <544AC56F16B56944AEC3BD4E3D5917712F0DB8A799@LIMKCMBX1.ad.analog.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

...
>>> Hi Jonathan,
>>>
>>> We have a few more iio drivers in our repository. Over the next couple
>>> of weeks I'm trying to get them out. Excellent.
>>>
>>>> because I would like it to go in before
>>>> the event clean up series currently sat in my tree. That way I can
>>>> update this one at the same time.
>>>
>>> Oops - this patch was already against your tree:
>>> http://git.kernel.org/?p=linux/kernel/git/jic23/iio_temp.git
>>>
>>> Need to check if it works on Greg's staging.
>> Ah. Shouldn't be too bad.  That's what I get for putting temporary trees
>> up - that one only exists for testing the adis16260 and adis16350 driver
>> changes.
> 
> Well - it looks bad.
> It basically errors on everything I changed in order to make it work on your temp tree.
> I'll send Greg my original version...
Are you sure this was against staging-next branch of the staging-next tree? (which is where
Greg will merge this)  Far as I can see all the changes since that in my temp tree are to do
with the event code cleanups and I don't think that would generate most of these.  The index an
type changes + the rearrangement of the buffer code has been merged for a while.


It applies and builds as is.  git's am checking throws up
/home/jic23/src/kernel/staging-next-2.6/.git/rebase-apply/patch:610: trailing whitespace.
                                i & 0x1 ? 

and sparse gives 
drivers/staging/iio/adc/ad799x_core.c: In function 'ad799x_interrupt_bh':
drivers/staging/iio/adc/ad799x_core.c:391: warning: suggest parentheses around + or - inside shift
drivers/staging/iio/adc/ad799x_core.c:392: warning: right shift count >= width of type
drivers/staging/iio/adc/ad799x_core.c:392: warning: suggest parentheses around + or - inside shift

both of which are probably worth fixing.



> 
> drivers/staging/iio/adc/ad799x_ring.c: In function 'ad799x_single_channel_from_ring':
> drivers/staging/iio/adc/ad799x_ring.c:35: error: 'struct iio_ring_buffer' has no member named 'scan_mask'
> drivers/staging/iio/adc/ad799x_ring.c:39: error: 'struct iio_ring_buffer' has no member named 'scan_count'
> drivers/staging/iio/adc/ad799x_ring.c:53: error: 'struct iio_ring_buffer' has no member named 'scan_mask'
> drivers/staging/iio/adc/ad799x_ring.c: In function 'ad799x_ring_preenable':
> drivers/staging/iio/adc/ad799x_ring.c:85: error: 'struct iio_ring_buffer' has no member named 'scan_mask'
> drivers/staging/iio/adc/ad799x_ring.c:87: error: 'struct iio_ring_buffer' has no member named 'scan_count'
> drivers/staging/iio/adc/ad799x_ring.c:89: error: 'struct iio_ring_access_funcs' has no member named 'set_bytes_per_datum'
> drivers/staging/iio/adc/ad799x_ring.c:93: error: 'struct iio_ring_access_funcs' has no member named 'set_bytes_per_datum'
> drivers/staging/iio/adc/ad799x_ring.c: In function 'ad799x_poll_bh_to_ring':
> drivers/staging/iio/adc/ad799x_ring.c:136: error: 'struct iio_ring_buffer' has no member named 'scan_count'
> drivers/staging/iio/adc/ad799x_ring.c:163: error: 'struct iio_ring_buffer' has no member named 'scan_mask'
> drivers/staging/iio/adc/ad799x_ring.c:169: error: 'struct iio_ring_buffer' has no member named 'scan_mask'
> drivers/staging/iio/adc/ad799x_ring.c: In function 'ad799x_register_ring_funcs_and_init':
> drivers/staging/iio/adc/ad799x_ring.c:225: error: 'struct iio_ring_buffer' has no member named 'scan_el_attrs'
>   LD      drivers/staging/iio/light/built-in.o
> drivers/staging/iio/adc/ad799x_core.c: In function 'ad799x_scan_el_set_state':
> drivers/staging/iio/adc/ad799x_core.c:108: error: 'struct iio_ring_buffer' has no member named 'scan_mask'
> drivers/staging/iio/adc/ad799x_core.c:117:1: error: macro "IIO_SCAN_EL_C" requires 5 arguments, but only 4 given
> drivers/staging/iio/adc/ad799x_core.c: At top level:
> drivers/staging/iio/adc/ad799x_core.c:117: warning: type defaults to 'int' in declaration of 'IIO_SCAN_EL_C'
> drivers/staging/iio/adc/ad799x_core.c:118:1: error: macro "IIO_SCAN_EL_C" requires 5 arguments, but only 4 given
> drivers/staging/iio/adc/ad799x_core.c:118: warning: type defaults to 'int' in declaration of 'IIO_SCAN_EL_C'
> drivers/staging/iio/adc/ad799x_core.c:119:1: error: macro "IIO_SCAN_EL_C" requires 5 arguments, but only 4 given
> drivers/staging/iio/adc/ad799x_core.c:119: warning: type defaults to 'int' in declaration of 'IIO_SCAN_EL_C'
> drivers/staging/iio/adc/ad799x_core.c:120:1: error: macro "IIO_SCAN_EL_C" requires 5 arguments, but only 4 given
> drivers/staging/iio/adc/ad799x_core.c:120: warning: type defaults to 'int' in declaration of 'IIO_SCAN_EL_C'
> drivers/staging/iio/adc/ad799x_core.c:121:1: error: macro "IIO_SCAN_EL_C" requires 5 arguments, but only 4 given
> drivers/staging/iio/adc/ad799x_core.c:121: warning: type defaults to 'int' in declaration of 'IIO_SCAN_EL_C'
> drivers/staging/iio/adc/ad799x_core.c:122:1: error: macro "IIO_SCAN_EL_C" requires 5 arguments, but only 4 given
> drivers/staging/iio/adc/ad799x_core.c:122: warning: type defaults to 'int' in declaration of 'IIO_SCAN_EL_C'
> drivers/staging/iio/adc/ad799x_core.c:123:1: error: macro "IIO_SCAN_EL_C" requires 5 arguments, but only 4 given
> drivers/staging/iio/adc/ad799x_core.c:123: warning: type defaults to 'int' in declaration of 'IIO_SCAN_EL_C'
> drivers/staging/iio/adc/ad799x_core.c:124:1: error: macro "IIO_SCAN_EL_C" requires 5 arguments, but only 4 given
> drivers/staging/iio/adc/ad799x_core.c:124: warning: type defaults to 'int' in declaration of 'IIO_SCAN_EL_C'
> drivers/staging/iio/adc/ad799x_core.c: In function 'ad799x_interrupt_bh':
> drivers/staging/iio/adc/ad799x_core.c:391: warning: suggest parentheses around + or - inside shift
> drivers/staging/iio/adc/ad799x_core.c:392: warning: right shift count >= width of type
> drivers/staging/iio/adc/ad799x_core.c:392: warning: suggest parentheses around + or - inside shift
> drivers/staging/iio/adc/ad799x_core.c: At top level:
> drivers/staging/iio/adc/ad799x_core.c:469: error: 'iio_scan_el_in0' undeclared here (not in a function)
> drivers/staging/iio/adc/ad799x_core.c:470: error: 'iio_const_attr_in0_index' undeclared here (not in a function)
> drivers/staging/iio/adc/ad799x_core.c:471: error: 'iio_scan_el_in1' undeclared here (not in a function)
> drivers/staging/iio/adc/ad799x_core.c:472: error: 'iio_const_attr_in1_index' undeclared here (not in a function)
> drivers/staging/iio/adc/ad799x_core.c:473: error: 'iio_scan_el_in2' undeclared here (not in a function)
> drivers/staging/iio/adc/ad799x_core.c:474: error: 'iio_const_attr_in2_index' undeclared here (not in a function)
> drivers/staging/iio/adc/ad799x_core.c:475: error: 'iio_scan_el_in3' undeclared here (not in a function)
> drivers/staging/iio/adc/ad799x_core.c:476: error: 'iio_const_attr_in3_index' undeclared here (not in a function)
> drivers/staging/iio/adc/ad799x_core.c:499: error: request for member 'dev_attr' in something not a structure or union
> drivers/staging/iio/adc/ad799x_core.c:499: error: request for member 'attr' in something not a structure or union
> drivers/staging/iio/adc/ad799x_core.c:499: error: initializer element is not constant
> drivers/staging/iio/adc/ad799x_core.c:499: error: (near initialization for 'ad7992_scan_el_attrs[0]')
> drivers/staging/iio/adc/ad799x_core.c:500: error: request for member 'dev_attr' in something not a structure or union
> drivers/staging/iio/adc/ad799x_core.c:500: error: request for member 'attr' in something not a structure or union
> drivers/staging/iio/adc/ad799x_core.c:500: error: initializer element is not constant
> drivers/staging/iio/adc/ad799x_core.c:500: error: (near initialization for 'ad7992_scan_el_attrs[1]')
> drivers/staging/iio/adc/ad799x_core.c:501: error: request for member 'dev_attr' in something not a structure or union
> drivers/staging/iio/adc/ad799x_core.c:501: error: request for member 'attr' in something not a structure or union
> drivers/staging/iio/adc/ad799x_core.c:501: error: initializer element is not constant
> drivers/staging/iio/adc/ad799x_core.c:501: error: (near initialization for 'ad7992_scan_el_attrs[2]')
> drivers/staging/iio/adc/ad799x_core.c:502: error: request for member 'dev_attr' in something not a structure or union
> drivers/staging/iio/adc/ad799x_core.c:502: error: request for member 'attr' in something not a structure or union
> drivers/staging/iio/adc/ad799x_core.c:502: error: initializer element is not constant
> drivers/staging/iio/adc/ad799x_core.c:502: error: (near initialization for 'ad7992_scan_el_attrs[3]')
> drivers/staging/iio/adc/ad799x_core.c:531: error: request for member 'dev_attr' in something not a structure or union
> drivers/staging/iio/adc/ad799x_core.c:531: error: request for member 'attr' in something not a structure or union
> drivers/staging/iio/adc/ad799x_core.c:531: error: initializer element is not constant
> drivers/staging/iio/adc/ad799x_core.c:531: error: (near initialization for 'ad7997_8_scan_el_attrs[0]')
> drivers/staging/iio/adc/ad799x_core.c:532: error: request for member 'dev_attr' in something not a structure or union
> drivers/staging/iio/adc/ad799x_core.c:532: error: request for member 'attr' in something not a structure or union
> drivers/staging/iio/adc/ad799x_core.c:532: error: initializer element is not constant
> drivers/staging/iio/adc/ad799x_core.c:532: error: (near initialization for 'ad7997_8_scan_el_attrs[1]')
> drivers/staging/iio/adc/ad799x_core.c:533: error: request for member 'dev_attr' in something not a structure or union
> drivers/staging/iio/adc/ad799x_core.c:533: error: request for member 'attr' in something not a structure or union
> drivers/staging/iio/adc/ad799x_core.c:533: error: initializer element is not constant
> drivers/staging/iio/adc/ad799x_core.c:533: error: (near initialization for 'ad7997_8_scan_el_attrs[2]')
> drivers/staging/iio/adc/ad799x_core.c:534: error: request for member 'dev_attr' in something not a structure or union
> drivers/staging/iio/adc/ad799x_core.c:534: error: request for member 'attr' in something not a structure or union
> drivers/staging/iio/adc/ad799x_core.c:534: error: initializer element is not constant
> drivers/staging/iio/adc/ad799x_core.c:534: error: (near initialization for 'ad7997_8_scan_el_attrs[3]')
> drivers/staging/iio/adc/ad799x_core.c:535: error: request for member 'dev_attr' in something not a structure or union
> drivers/staging/iio/adc/ad799x_core.c:535: error: request for member 'attr' in something not a structure or union
> drivers/staging/iio/adc/ad799x_core.c:535: error: initializer element is not constant
> drivers/staging/iio/adc/ad799x_core.c:535: error: (near initialization for 'ad7997_8_scan_el_attrs[4]')
> drivers/staging/iio/adc/ad799x_core.c:536: error: request for member 'dev_attr' in something not a structure or union
> drivers/staging/iio/adc/ad799x_core.c:536: error: request for member 'attr' in something not a structure or union
> drivers/staging/iio/adc/ad799x_core.c:536: error: initializer element is not constant
> drivers/staging/iio/adc/ad799x_core.c:536: error: (near initialization for 'ad7997_8_scan_el_attrs[5]')
> drivers/staging/iio/adc/ad799x_core.c:537: error: request for member 'dev_attr' in something not a structure or union
> drivers/staging/iio/adc/ad799x_core.c:537: error: request for member 'attr' in something not a structure or union
> drivers/staging/iio/adc/ad799x_core.c:537: error: initializer element is not constant
> drivers/staging/iio/adc/ad799x_core.c:537: error: (near initialization for 'ad7997_8_scan_el_attrs[6]')
> drivers/staging/iio/adc/ad799x_core.c:538: error: request for member 'dev_attr' in something not a structure or union
> drivers/staging/iio/adc/ad799x_core.c:538: error: request for member 'attr' in something not a structure or union
> drivers/staging/iio/adc/ad799x_core.c:538: error: initializer element is not constant
> drivers/staging/iio/adc/ad799x_core.c:538: error: (near initialization for 'ad7997_8_scan_el_attrs[7]')
> drivers/staging/iio/adc/ad799x_core.c:539: error: 'iio_scan_el_in4' undeclared here (not in a function)
> drivers/staging/iio/adc/ad799x_core.c:539: error: request for member 'dev_attr' in something not a structure or union
> drivers/staging/iio/adc/ad799x_core.c:539: error: request for member 'attr' in something not a structure or union
> drivers/staging/iio/adc/ad799x_core.c:539: error: initializer element is not constant
> drivers/staging/iio/adc/ad799x_core.c:539: error: (near initialization for 'ad7997_8_scan_el_attrs[8]')
> drivers/staging/iio/adc/ad799x_core.c:540: error: 'iio_const_attr_in4_index' undeclared here (not in a function)
> drivers/staging/iio/adc/ad799x_core.c:540: error: request for member 'dev_attr' in something not a structure or union
> drivers/staging/iio/adc/ad799x_core.c:540: error: request for member 'attr' in something not a structure or union
> drivers/staging/iio/adc/ad799x_core.c:540: error: initializer element is not constant
> drivers/staging/iio/adc/ad799x_core.c:540: error: (near initialization for 'ad7997_8_scan_el_attrs[9]')
> drivers/staging/iio/adc/ad799x_core.c:541: error: 'iio_scan_el_in5' undeclared here (not in a function)
> drivers/staging/iio/adc/ad799x_core.c:541: error: request for member 'dev_attr' in something not a structure or union
> drivers/staging/iio/adc/ad799x_core.c:541: error: request for member 'attr' in something not a structure or union
> drivers/staging/iio/adc/ad799x_core.c:541: error: initializer element is not constant
> drivers/staging/iio/adc/ad799x_core.c:541: error: (near initialization for 'ad7997_8_scan_el_attrs[10]')
> drivers/staging/iio/adc/ad799x_core.c:542: error: 'iio_const_attr_in5_index' undeclared here (not in a function)
> drivers/staging/iio/adc/ad799x_core.c:542: error: request for member 'dev_attr' in something not a structure or union
> drivers/staging/iio/adc/ad799x_core.c:542: error: request for member 'attr' in something not a structure or union
> drivers/staging/iio/adc/ad799x_core.c:542: error: initializer element is not constant
> drivers/staging/iio/adc/ad799x_core.c:542: error: (near initialization for 'ad7997_8_scan_el_attrs[11]')
> drivers/staging/iio/adc/ad799x_core.c:543: error: 'iio_scan_el_in6' undeclared here (not in a function)
> drivers/staging/iio/adc/ad799x_core.c:543: error: request for member 'dev_attr' in something not a structure or union
> drivers/staging/iio/adc/ad799x_core.c:543: error: request for member 'attr' in something not a structure or union
> drivers/staging/iio/adc/ad799x_core.c:543: error: initializer element is not constant
> drivers/staging/iio/adc/ad799x_core.c:543: error: (near initialization for 'ad7997_8_scan_el_attrs[12]')
> drivers/staging/iio/adc/ad799x_core.c:544: error: 'iio_const_attr_in6_index' undeclared here (not in a function)
> drivers/staging/iio/adc/ad799x_core.c:544: error: request for member 'dev_attr' in something not a structure or union
> drivers/staging/iio/adc/ad799x_core.c:544: error: request for member 'attr' in something not a structure or union
> drivers/staging/iio/adc/ad799x_core.c:544: error: initializer element is not constant
> drivers/staging/iio/adc/ad799x_core.c:544: error: (near initialization for 'ad7997_8_scan_el_attrs[13]')
> drivers/staging/iio/adc/ad799x_core.c:545: error: 'iio_scan_el_in7' undeclared here (not in a function)
> drivers/staging/iio/adc/ad799x_core.c:545: error: request for member 'dev_attr' in something not a structure or union
> drivers/staging/iio/adc/ad799x_core.c:545: error: request for member 'attr' in something not a structure or union
> drivers/staging/iio/adc/ad799x_core.c:545: error: initializer element is not constant
> drivers/staging/iio/adc/ad799x_core.c:545: error: (near initialization for 'ad7997_8_scan_el_attrs[14]')
> drivers/staging/iio/adc/ad799x_core.c:546: error: 'iio_const_attr_in7_index' undeclared here (not in a function)
> drivers/staging/iio/adc/ad799x_core.c:546: error: request for member 'dev_attr' in something not a structure or union
> drivers/staging/iio/adc/ad799x_core.c:546: error: request for member 'attr' in something not a structure or union
> drivers/staging/iio/adc/ad799x_core.c:546: error: initializer element is not constant
> drivers/staging/iio/adc/ad799x_core.c:546: error: (near initialization for 'ad7997_8_scan_el_attrs[15]')
> 
> 
