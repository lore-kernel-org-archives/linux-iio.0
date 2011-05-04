Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:59856 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754529Ab1EDO7E (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 4 May 2011 10:59:04 -0400
Message-ID: <4DC16A47.3040602@cam.ac.uk>
Date: Wed, 04 May 2011 16:01:27 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
CC: linux-iio@vger.kernel.org, Michael.Hennerich@analog.com
Subject: Re: [PATCH 00/99] IIO: moving forward patch set.
References: <1304510351-10922-1-git-send-email-jic23@cam.ac.uk> <201105041533.21498.arnd@arndb.de>
In-Reply-To: <201105041533.21498.arnd@arndb.de>
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 05/04/11 14:33, Arnd Bergmann wrote:
> On Wednesday 04 May 2011, Jonathan Cameron wrote:
>> First to Arnd: Obviously I'm not expecting you to review this
>> 'little' set. I just wanted to keep you in the loop on what happened
>> with your suggestions.
>>
> 
> Thanks for the update, this looks like excellent progress!
> 
> I've briefly looked over most of the patches and they all look good
> to me, I especially like the total diffstat of 
>  112 files changed, 7402 insertions(+), 12638 deletions(-)
The stats cheat a bit as I combined 3 of the big drivers into one in the
middle of the set.  Still, a general downward trend with no loss
of functionality is always nice ;)
> 
> One of the main problems we discussed earlier is the chardev interface
> with its event handling, and I think you got it exactly right now, but
> I'm not completely sure if I understand correctly what you do there,
> so maybe you can explain how it works with the new buffer device.
There are still some corners to be ironed out. It's better than it was -
but we still need to look at the issue of blocking reads.
> 
> Ideally, that could be in man-page style so it can go into section 4 of
> the man pages, /usr/share/man/man4/iio.4.
Good idea. I'll add it to the todo list.  Right now pretty much all the docs
we have in tree are way out of date, so that's next on my list.

Thanks for your time looking at this. It has been very helpful indeed.

Jonathan
