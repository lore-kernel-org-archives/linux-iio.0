Return-Path: <lars@metafoo.de>
Message-ID: <5399A09B.2070608@metafoo.de>
Date: Thu, 12 Jun 2014 14:44:11 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Josselin Costanzi <josselin.costanzi@mobile-devices.fr>
CC: linux-iio@vger.kernel.org, jic23@kernel.org
Subject: Re: [PATCH v2] iio: make blocking read wait for data
References: <1402417591-32536-1-git-send-email-josselin.costanzi@mobile-devices.fr>
In-Reply-To: <1402417591-32536-1-git-send-email-josselin.costanzi@mobile-devices.fr>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-ID: <linux-iio@vger.kernel.org>

On 06/10/2014 06:26 PM, Josselin Costanzi wrote:
> Currently the IIO buffer blocking read only wait until at least one
> data element is available.
> This patch adds the possibility for the userspace to to blocking calls
> for multiple elements. This should limit the read() calls count when
> trying to get data in batches.
> This commit also fix a bug where data is lost if an error happens
> after some data is already read.
>
> Signed-off-by: Josselin Costanzi <josselin.costanzi@mobile-devices.fr>

This is going into the right direction. But where did that timeout come 
from? If a user wants a timeout on the read() call they should open the 
device in non-blocking mode and use poll() with a timeout. I dont think we 
should add a different way of doing this since the poll() method already 
works fine.

Also read() should still return once it got data and not wait until the full 
buffer has been read. Also poll() should not return until there is more data 
than the watermark in the buffer. So this means the pollq of the buffer 
should not be woken up until more data is in the buffer then the watermark. 
E.g. in iio_store_to_kfifo

if (kfifo_len(&kf->kf) >= kf->buffer.watermark)
	wake_up_interruptible_poll(&r->pollq, POLLIN | POLLRDNORM);

iio_kfifo_buf_data_available() can be re-factored to return the amount of 
data that is available rather than just if data is available or not.

In iio_buffer_data_available() you can then compare the result of the 
data_available() callback with the watermark and return true or false 
depending on that.

There is one more case that needs to be handled which is the buffer being 
disabled. When the buffer is disabled iio_buffer_data_available() should 
return true if there is data in the buffer regardless of whether it is above 
or below the watermark. This also means that the pollq needs to be woken up 
when the buffer is disabled. This should be done in iio_buffer_deactivate() 
before the iio_buffer_put().

- Lars
