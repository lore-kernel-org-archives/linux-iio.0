Return-Path: <jic23@cam.ac.uk>
Message-ID: <4BE2A93C.7030502@cam.ac.uk>
Date: Thu, 06 May 2010 12:34:20 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: Barry Song <21cnbao@gmail.com>, linux-iio@vger.kernel.org,
 Barry Song <Barry.Song@analog.com>
Subject: Re: [PATCH RFC] staging:iio: adis16209 accelerometer driver initial
 	import
References: <1273073011-13052-1-git-send-email-jic23@cam.ac.uk> 	<4BE1D162.90309@cam.ac.uk> <l2w3c17e3571005060233yf53496f7s7598fcc9ab72be85@mail.gmail.com> <4BE298BF.2080400@cam.ac.uk>
In-Reply-To: <4BE298BF.2080400@cam.ac.uk>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On 05/06/10 11:23, Jonathan Cameron wrote:
> On 05/06/10 10:33, Barry Song wrote:
>> Thanks a lot for your review and good comments. I have updated
>> adis16209 and adis16240(which has been tested too) according to your
>> comment. I am 100% sure we will pull new iio features to our tree. But
>> i am busy on testing adis16220/260/350, so if possible, i still need
>> your help to merge them into 2.6.35 just like adis16300/400 for the
>> moment.
> You are welcome.  Post the updated patches here as and when they are ready.
> It would be great to get a nasty 
 Freudian slip of the day.  That was meant to say 'nice' :)
>large driver set merged for 2.6.35 as
> iio could do with exposure and publicity that will generate!
> 
> All the reponses look good to me, so looking forward to seeing the
> updated driver.  I'll have a think about the best fix in the core for the
> current need to register an empty event attribute group.  It is kind of
> a driver bug, but then the stage you are at is pretty typical for a driver
> still under development so it would be nice if it didn't cause a problem!
> 
> As long as the patches are new drivers or fixs, I'd imaging Greg will be keep taking them
> until at least the beginning of the merge window (probably a couple of
> weeks time).  As staging usually merges pretty late, we may well sneak
> in a few more when the window is open, but that's entirely up to Greg.
> 
