Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:55827 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933443AbcCIUX2 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 9 Mar 2016 15:23:28 -0500
Subject: Re: [RFC PATCH 1/2] iio: core: implement
 iio_{claim|release}_direct_mode()
To: Alison Schofield <amsfield22@gmail.com>
References: <cover.1456794364.git.amsfield22@gmail.com>
 <9a2950402af7277a4928a10eade4cc8b1187d8c8.1456794364.git.amsfield22@gmail.com>
 <56D6EA82.8090601@metafoo.de> <56DB1F3C.8020302@kernel.org>
 <20160309200654.GA11631@d830.WORKGROUP>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	outreachy-kernel@googlegroups.com, knaack.h@gmx.de,
	pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, Michael.Hennerich@analog.com,
	gregkh@linuxfoundation.org, devel@driverdev.osuosl.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <56E08637.7050205@kernel.org>
Date: Wed, 9 Mar 2016 20:23:19 +0000
MIME-Version: 1.0
In-Reply-To: <20160309200654.GA11631@d830.WORKGROUP>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/03/16 20:06, Alison Schofield wrote:
> On Sat, Mar 05, 2016 at 06:02:36PM +0000, Jonathan Cameron wrote:
>> On 02/03/16 13:28, Lars-Peter Clausen wrote:
>>> On 03/01/2016 08:02 PM, Alison Schofield wrote:
>>>> It is often the case that the driver wants to be sure a device stays
>>>> in direct mode while it is executing a task or series of tasks.  To
>>>> accomplish this today, the driver performs this sequence: 1) take the
>>>> device state lock, 2)verify it is not in a buffered mode, 3) execute
>>>> some tasks, and 4) release that lock.
>>>>
>>>> This patch introduces a pair of helper functions that simplify these
>>>> steps and make it more semantically expressive.
>>>>
>>>> iio_claim_direct_mode()
>>>>         If the device is not in any buffered mode it is guaranteed
>>>>         to stay that way until iio_release_direct_mode() is called.
>>>>
>>>> iio_release_direct_mode()
>>>>         Release the claim. Device is no longer guaranteed to stay
>>>>         in direct mode.
>>>>
>>>> Signed-off-by: Alison Schofield <amsfield22@gmail.com>
>>>
>>> Looks basically good.
>> Agreed - nothing to add from me to what Lars has covered here.
>> Nice to 'hide' the accesses to mlock as well as will cut out the desire
>> to 'abuse it'.  Amusingly we only just 'fixed' the docs to to say this
>> element of iio_dev was usable by drivers.  Once we have these new functions
>> in use throughout the tree, we will want to flip that back again to internal
>> only.
>>
>> Jonathan
>>
> Thanks for the review (& Lars too)  
> 
> Thinking about your note about flipping the mlock field back to
> INTERNAL (from DRIVER), this change, even when it's applied to
> all relevant instances, doesn't get us all the way there.
> 
> While these claim/release functions will remove direct access to mlock
> where a driver wants to hold direct mode, the drivers are grabbing
> mlock for other reasons also.  (too many reasons/instances for me to
> quickly understand or summarize)  
> 
> I'm willing to look at it further and comment if that's helpful.
It would certainly be interesting to evaluate this.  I suspect that most
are either in some obscure way connected to the mode or are 'misusing'
the lock for more general purposes where a driver specific lock would make
more sense.

Jonathan
> 
> alisons
> 
> 
> 
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

