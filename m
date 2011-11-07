Return-Path: <lars@metafoo.de>
Message-ID: <4EB78AB0.6070301@metafoo.de>
Date: Mon, 07 Nov 2011 08:37:20 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>
CC: Jesper Juhl <jj@chaosbits.net>, linux-iio@vger.kernel.org,
 devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
 Paul Gortmaker <paul.gortmaker@windriver.com>,
 Michael Hennerich <michael.hennerich@analog.com>,
 Greg Kroah-Hartman <gregkh@suse.de>,
 Jonathan Cameron <jic23@cam.ac.uk>
Subject: Re: [PATCH] [staging] iio, adc: Do not leak memory in ad7280_event_handler()
References: <alpine.LNX.2.00.1111062246580.5763@swampdragon.chaosbits.net> <4EB70100.8030703@kernel.org>
In-Reply-To: <4EB70100.8030703@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 11/06/2011 10:49 PM, Jonathan Cameron wrote:
> On 11/06/2011 09:49 PM, Jesper Juhl wrote:
>> If ad7280_read_all_channels() returns <0 then we'll leak the memory
>> allocated to 'channels' when we return and that variable goes out of
>> scope.
>> This patch fixes the leak.
>>
> Looks right to me - good spot. Only choice is whether a single exit
> point makes sense rather than undwinding it here? Michael?
> I'm happy with either solution, hence the ack.

A similar patch has already been sent last week and should be in Gregs queue.
See: http://comments.gmane.org/gmane.linux.kernel.iio/2433

- Lars
