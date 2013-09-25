Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:32872 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751014Ab3IYRJw (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 25 Sep 2013 13:09:52 -0400
In-Reply-To: <52430F81.6030601@metafoo.de>
References: <524106f9.teHmhjmgqBH0qZNH%fengguang.wu@intel.com> <5242907D.2060203@metafoo.de> <cbf017e1-1d05-42e9-b0bf-851a22e3c9bb@email.android.com> <31c01b8f-6ba1-438d-87e5-42fba9566086@email.android.com> <52430F81.6030601@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: [next:master 1495/1772] drivers/staging/iio/iio_simple_dummy_buffer.c:86:2: error: implicit declaration of function 'iio_push_to_buffers_with_timestamp'
From: Jonathan Cameron <jic23@kernel.org>
Date: Wed, 25 Sep 2013 18:09:46 +0100
To: Lars-Peter Clausen <lars@metafoo.de>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Zubair Lutfullah <zubair.lutfullah@gmail.com>
Message-ID: <de21550d-6bcc-4011-9460-90bf8fad1425@email.android.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



Lars-Peter Clausen <lars@metafoo.de> wrote:
>On 09/25/2013 06:22 PM, Jonathan Cameron wrote:
>> 
>> 
>> Jonathan Cameron <jic23@kernel.org> wrote:
>>>
>>>
>>> Lars-Peter Clausen <lars@metafoo.de> wrote:
>>>> On 09/24/2013 05:28 AM, kbuild test robot wrote:
>>>>> tree:  
>>>> git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
>>>> master
>>>>> head:   1fa8f71dfa6e28c89afad7ac71dcb19b8c8da8b7
>>>>> commit: 09a799d04eb17e19bbc80cb0e350a3ec89552b01 [1495/1772]
>>>> staging:iio:dummy: Use iio_push_to_buffers_with_timestamp()
>>>>> config: i386-randconfig-j6-09240827 (attached as .config)
>>>>>
>>>>> All error/warnings:
>>>>>
>>>>>     drivers/staging/iio/iio_simple_dummy_buffer.c: In function
>>>> 'iio_simple_dummy_trigger_h':
>>>>>>> drivers/staging/iio/iio_simple_dummy_buffer.c:86:2: error:
>>> implicit
>>>> declaration of function 'iio_push_to_buffers_with_timestamp'
>>>> [-Werror=implicit-function-declaration]
>>>>>       iio_push_to_buffers_with_timestamp(indio_dev, data,
>>>> iio_get_time_ns());
>>>>>       ^
>>>>>     drivers/staging/iio/iio_simple_dummy_buffer.c: At top level:
>>>>>     drivers/staging/iio/iio_simple_dummy_buffer.c:108:16: error:
>>>> 'iio_sw_buffer_preenable' undeclared here (not in a function)
>>>>>       .preenable = &iio_sw_buffer_preenable,
>>>>>                     ^
>>>>>     drivers/staging/iio/iio_simple_dummy_buffer.c: In function
>>>> 'iio_simple_dummy_configure_buffer':
>>>>>     drivers/staging/iio/iio_simple_dummy_buffer.c:141:8: error:
>>>> dereferencing pointer to incomplete type
>>>>>       buffer->scan_timestamp = true;
>>>>>             ^
>>>>>     cc1: some warnings being treated as errors
>>>>>
>>>>> vim +/iio_push_to_buffers_with_timestamp +86
>>>> drivers/staging/iio/iio_simple_dummy_buffer.c
>>>>>
>>>>>      80				/* random access read from the 'device' */
>>>>>      81				data[i] = fakedata[j];
>>>>>      82				len += 2;
>>>>>      83			}
>>>>>      84		}
>>>>>      85	
>>>>>    > 86		iio_push_to_buffers_with_timestamp(indio_dev, data,
>>>> iio_get_time_ns());
>>>>>      87	
>>>>>      88		kfree(data);
>>>>>      89	
>>>>
>>>>
>>>> Hm, the config that generated this has:
>>>>
>>>> CONFIG_IIO=m
>>>> # CONFIG_IIO_BUFFER is not set
>>>> CONFIG_IIO_KFIFO_BUF=m
>>>>
>>>> How is it possible that IIO_KFIFO_BUF is selected but not
>IIO_BUFFER?
>>>>
>>> How does a SELECT interact with an IF in kconfig?  I am not sure..
>>>
>>> We select the kfifo_buf and that is under IF IIO_BUFFER.
>> 
>> The documentation for select makes it clear that it does not enforce
>dependencies so I guess any select of Kfifo_buf must also select
>iio_buffer?  Sometimes there seems to be no right way of doing this
>stuff...
>
>Just wanted to say that we never do this, but then looked at the latest
>iio/togreg and the commit that causes it seems to be "ca9a5638 iio:
>ti_am335x_adc: Add continuous sampling support". Which selects the
>KFIFO
>buffer without either selecting IIO_BUFFER as well or depending on
>IIO_BUFFER.

Yup my bad given I put that in the original patch based on an earlier autobuilder message and didn't think it through properly.

Sorry about that. Will get a fix in place shortly.

Jonathan
>
>- Lars

-- 
Sent from my Android phone with K-9 Mail. Please excuse my brevity.
