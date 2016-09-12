Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from www381.your-server.de ([78.46.137.84]:41081 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758280AbcILMS1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 12 Sep 2016 08:18:27 -0400
Subject: Re: [PATCH v2 1/1] iio:buffer: let poll report an error for
 unregistered devices
To: Jonathan Cameron <jic23@kernel.org>,
        Gregor Boirie <gregor.boirie@parrot.com>,
        linux-iio@vger.kernel.org
References: <cover.1473430265.git.gregor.boirie@parrot.com>
 <579ce80942853be7eb6e6320727df0d4ffbd0903.1473430265.git.gregor.boirie@parrot.com>
 <7f729816-f82c-7ad1-8505-6df24a619131@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <a544ae58-5e8b-7fd7-16ff-eb5d4144cc58@metafoo.de>
Date: Mon, 12 Sep 2016 14:18:08 +0200
MIME-Version: 1.0
In-Reply-To: <7f729816-f82c-7ad1-8505-6df24a619131@kernel.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi,

I had some more comments inline in v1, please see below.

On 09/10/2016 05:44 PM, Jonathan Cameron wrote:
>> @@ -162,13 +163,20 @@ unsigned int iio_buffer_poll(struct file *filp,
>>  {
>>  	struct iio_dev *indio_dev = filp->private_data;
>>  	struct iio_buffer *rb = indio_dev->buffer;
>> +	bool rdy;
>>  
>>  	if (!indio_dev->info)
>> -		return 0;
>> +		return POLLERR;

I've had a look at what other subsystems do and input returns POLLERR |
POLLHUP. Maybe we should mirror this.

>>  
>>  	poll_wait(filp, &rb->pollq, wait);
>> -	if (iio_buffer_ready(indio_dev, rb, rb->watermark, 0))
>> +	rdy = iio_buffer_ready(indio_dev, rb, rb->watermark, 0);
>> +
>> +	if (!indio_dev->info)
>> +		return POLLERR;

Why check indio_dev->info twice though, since there is no locking involved
the second check does gain us anything in terms of race condition avoidance.
I think we should have one check after the poll_wait() call. If the device
is unregistered we wake the pollq. So adding it there should make sure that
the poll() callback is called again if the device is unregistered after the
check.

I'm not sure though if we'd need a explicit memory barrier or whether
poll_wait() can act as a implicit one. But probably we are ok, given that
poll_wait() should take a lock.

To be sure that the code is race free we need a guarantee that there is
strict ordering between the indio_dev->info = NULL and wake_up() in
unregister as well as between poll_wait() and the if (indio_dev->info) check
in poll().

The scenario is basically

CPU0				CPU1
---------------------------------------------------------
poll_wait()			indio_dev->info = NULL
if (!indio_dev->info)		wake_up()


If strict ordering is not observed for either side we could end up missing
the unregister and poll() will block forever just as before.
