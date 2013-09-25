Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailhost.informatik.uni-hamburg.de ([134.100.9.70]:40292 "EHLO
	mailhost.informatik.uni-hamburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751883Ab3IYH1Q (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 25 Sep 2013 03:27:16 -0400
Message-ID: <5242907D.2060203@metafoo.de>
Date: Wed, 25 Sep 2013 09:27:57 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [next:master 1495/1772] drivers/staging/iio/iio_simple_dummy_buffer.c:86:2:
 error: implicit declaration of function 'iio_push_to_buffers_with_timestamp'
References: <524106f9.teHmhjmgqBH0qZNH%fengguang.wu@intel.com>
In-Reply-To: <524106f9.teHmhjmgqBH0qZNH%fengguang.wu@intel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/24/2013 05:28 AM, kbuild test robot wrote:
> tree:   git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
> head:   1fa8f71dfa6e28c89afad7ac71dcb19b8c8da8b7
> commit: 09a799d04eb17e19bbc80cb0e350a3ec89552b01 [1495/1772] staging:iio:dummy: Use iio_push_to_buffers_with_timestamp()
> config: i386-randconfig-j6-09240827 (attached as .config)
>
> All error/warnings:
>
>     drivers/staging/iio/iio_simple_dummy_buffer.c: In function 'iio_simple_dummy_trigger_h':
>>> drivers/staging/iio/iio_simple_dummy_buffer.c:86:2: error: implicit declaration of function 'iio_push_to_buffers_with_timestamp' [-Werror=implicit-function-declaration]
>       iio_push_to_buffers_with_timestamp(indio_dev, data, iio_get_time_ns());
>       ^
>     drivers/staging/iio/iio_simple_dummy_buffer.c: At top level:
>     drivers/staging/iio/iio_simple_dummy_buffer.c:108:16: error: 'iio_sw_buffer_preenable' undeclared here (not in a function)
>       .preenable = &iio_sw_buffer_preenable,
>                     ^
>     drivers/staging/iio/iio_simple_dummy_buffer.c: In function 'iio_simple_dummy_configure_buffer':
>     drivers/staging/iio/iio_simple_dummy_buffer.c:141:8: error: dereferencing pointer to incomplete type
>       buffer->scan_timestamp = true;
>             ^
>     cc1: some warnings being treated as errors
>
> vim +/iio_push_to_buffers_with_timestamp +86 drivers/staging/iio/iio_simple_dummy_buffer.c
>
>      80				/* random access read from the 'device' */
>      81				data[i] = fakedata[j];
>      82				len += 2;
>      83			}
>      84		}
>      85	
>    > 86		iio_push_to_buffers_with_timestamp(indio_dev, data, iio_get_time_ns());
>      87	
>      88		kfree(data);
>      89	


Hm, the config that generated this has:

CONFIG_IIO=m
# CONFIG_IIO_BUFFER is not set
CONFIG_IIO_KFIFO_BUF=m

How is it possible that IIO_KFIFO_BUF is selected but not IIO_BUFFER?

- Lars

