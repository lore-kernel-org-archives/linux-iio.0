Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:51070 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755486AbcKEQq1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 5 Nov 2016 12:46:27 -0400
Subject: Re: TODO task for MMA8452 Accelerometer
To: Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Mani Sadhasivam <manivannanece23@gmail.com>
References: <20161102155018.GA5226@mani-Aspire-E5-573>
 <alpine.DEB.2.02.1611021707350.16085@pmeerw.net>
Cc: martink@posteo.de, linux-iio@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <c7560cd6-3148-57d5-ad43-ee0ef89b626d@kernel.org>
Date: Sat, 5 Nov 2016 16:46:24 +0000
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.02.1611021707350.16085@pmeerw.net>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 02/11/16 16:31, Peter Meerwald-Stadler wrote:
> Hello Mani,
> 
> adding linux-iio@
> 
>> This is Mani, working on MMA8452 Accelerometer with Beaglebone black. I 
>> just wanna know whether the TODO : 'Orientation events' task for this 
>> Accelerometer is undergoing or not. If not, can I work on the same under 
>> your mentoring.
>> For your kind info, I'm a recent undergraduate working in a Product 
>> development company called MathWorks. I'm learning Linux Kernel 
>> development as a hobby. Also, I thought taking up this task would be a 
>> good starting point for Linux Kernel Development.
> 
> not sure if someone is working on it, I have not seen patches
> 
>> If this task is already done, kindly suggest me a task to help me get 
>> involved with Linux community.
> 
> you have probably chosen a quite involved task; it is not immediately 
> clear how to realize orientation detection (at least to me :)
We could do it in a number of different ways.

One option to think about would be to do it in a 'clasification sense'
similar to we do for human activity detection.  There we assign
a percentage likelihood (scaling is a bit arbitrary) to the various
possible states.  Might fit well for orientation detection as
it's not really a binary thing.

If we treat it as more of a threshold with hysteresis then a
more conventional 'event' might fit. For this device it's actually
nicely defined in the docs for once.  Could be done
as an event on each of the angle axis with hysteresis. 
Now the angl type is rather poorly documented right now and there
is no way of knowing what frame of reference it is measured in so
there are some loose ends to tie up in that case as well.

As Peter and Martin have said. Non obvious!

So if you want to do this have a good think about possible interfaces
and propose one for review (perhaps with code implementing it).

Jonathan
> 
> regards, p.
> 

