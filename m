Return-Path: <jic23@kernel.org>
Message-ID: <4ED7E7BD.5060003@kernel.org>
Date: Thu, 01 Dec 2011 20:46:53 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Maxime Ripard <maxime.ripard@free-electrons.com>
CC: Jonathan Cameron <jic23@cam.ac.uk>, linux-iio@vger.kernel.org,
 Nicolas Ferre <nicolas.ferre@atmel.com>,
 Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: Future plan for going out of staging
References: <4ED4D7FA.60602@free-electrons.com>
In-Reply-To: <4ED4D7FA.60602@free-electrons.com>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 11/29/2011 01:02 PM, Maxime Ripard wrote:
> Hi Jonathan,
> 
> As I am working on the hardware triggers part of the AT91 ADC driver,
> I'm wondering what is the plan for the second part of moving iio out of
> staging.
Right now I'm waiting for a quiet moment to push through large namespace
movements for the staging tree so that we can get the version not in
staging after staging-next in linux-next.  There's too much churn in
the staging tree to make it feasible any other way that I can think of.
> 
> Obviously, you will wait for the first patchset to get included, but
> what are you planning to move next ?
Plan is to move buffers next.  The sticking point is getting time to
finish writing the stuff to allow push in kernel users.  I have a
version that works, but haven't had a chance to clean it up.
> 
> I don't find the mail, but I recall you telling that the next batch will
> probably move triggers and buffers (or at least only kfifo), do I recall
> correctly ?
Yup.  ring_sw is a dodgy bit of code I wrote a long time ago and have
never been happy with so unless someone else works on it, I'm inclined
to leave that behind!
> 
> Also, do you have some kind of estimate on when we could begin to have
> the next patchset ?

I'm running very low on time at the moment due to family bits and job
getting in the way so can't really commit to a date I'm afraid.

I'm very much open to anyone else offering to take over some of the move
out of staging. Mostly it's just cut and paste stuff with the odd name
change.  Still the recent buffer cleanups need to go in first and a
couple more bits in my tree. I'll post those as a work in progress
shortly.

Jonathan
> 
> Thanks,
> Maxime
> 
