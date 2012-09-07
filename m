Return-Path: <lars@metafoo.de>
Message-ID: <5049BA8B.9040602@metafoo.de>
Date: Fri, 07 Sep 2012 11:12:43 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>
CC: Jonathan Cameron <jic23@cam.ac.uk>, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: Drop timestamp parameter from buffer store_to callback
References: <5045ED39.5030408@jic23.retrosnub.co.uk> <1346762330-20360-1-git-send-email-lars@metafoo.de> <504913ED.5040901@kernel.org>
In-Reply-To: <504913ED.5040901@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 09/06/2012 11:21 PM, Jonathan Cameron wrote:
> On 09/04/2012 01:38 PM, Lars-Peter Clausen wrote:
>> Drop timestamp parameter from buffer store_to callback and subsequently from
>> iio_push_to_buffer. The timestamp parameter is unused and it seems likely that
>> it will stay unused in the future, so it should be safe to remove it.
> 
> Fine by me. I'll add the hid sensor driver that crossed with this patch
> separately for the first patch, but will have to just drop it in this one.
> Hope you don't mind!
> 
> I'll post the proposed version in a mo.

Sure, no problem.

>>
>> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
>> ---
