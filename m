Return-Path: <lars@metafoo.de>
Message-ID: <4F9EDBF9.5000806@metafoo.de>
Date: Mon, 30 Apr 2012 20:37:45 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: add mcp4725 I2C DAC driver
References: <4F9E6909.6090409@cam.ac.uk> <1335794080-6398-1-git-send-email-pmeerw@pmeerw.net> <4F9EA43F.7000803@cam.ac.uk>
In-Reply-To: <4F9EA43F.7000803@cam.ac.uk>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 04/30/2012 04:39 PM, Jonathan Cameron wrote:
> On 4/30/2012 2:54 PM, Peter Meerwald wrote:
>> v2 (based on comments from Jonathan Cameron and Lars-Peter Clausen):
>> * did NOT switch to chan_spec yet
> I guess from this you are intending to? I guess whether we merge this as
> is depends
> on what timescale you are thinking of to make that change?
>> * rebase to staging-next tree, update iio header locations
>> * dropped dac.h #include, not needed
>> * strict_strtol() ->  kstrtol()
>> * call iio_device_unregister() in remove()
>> * everything in one patch
> If you want to send it on to Greg KH now and Lars-Peter is happy, then
> that's fine by me.

I don't think it's a good idea to introduce new non chan_spec drivers.
Especially for simple drivers like this one where it is relatively easy to add
chan_spec support. So no ack from my side, but that's not necessarily a blocker
for the patch.

>> Signed-off-by: Peter Meerwald<pmeerw@pmeerw.net>
> Acked-by: Jonathan Cameron <jic23@kernel.org>
