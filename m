Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-51.csi.cam.ac.uk ([131.111.8.151]:38359 "EHLO
	ppsw-51.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752898Ab1H3QXH (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 30 Aug 2011 12:23:07 -0400
Message-ID: <4E5D1057.3020706@cam.ac.uk>
Date: Tue, 30 Aug 2011 17:31:19 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Grant Grundler <grundler@google.com>
CC: Dan Carpenter <error27@gmail.com>, linux-iio@vger.kernel.org,
	devel@driverdev.osuosl.org
Subject: Re: STAGING:iio:light: fix ISL29018 init to handle brownout
References: <20110826011542.GK5975@shale.localdomain> <CANEJEGtys_kBMMPstRahrYq956g22ZgowySxvOCqUpHww6x29w@mail.gmail.com> <4E5CB5CD.5060301@cam.ac.uk> <CANEJEGsohYnKXNUKUSfBpXofcNdt13bY_mnFZRUWMpewNjUykg@mail.gmail.com>
In-Reply-To: <CANEJEGsohYnKXNUKUSfBpXofcNdt13bY_mnFZRUWMpewNjUykg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 08/30/11 17:14, Grant Grundler wrote:
> On Tue, Aug 30, 2011 at 3:05 AM, Jonathan Cameron <jic23@cam.ac.uk> wrote:
> ....
>>> I did change one basic behavior that I think was also broken: cache
>>> the value regardless of if the transaction completed successfully or
>>> not.
>> Don't do that.  That means userspace will get an invalid value if it reads
>> in the meantime. If you have an error on a hardware bus - tell userspace about
>> it and don't 'guess' what is in the register.
> 
> Ah ok - I didn't know this was part of the path to/from user space.
It plausibly isn't, I didn't go over it closely enough to be sure.
Even if not, it's a nasty complexity that will bite someone at some stage.
Mostly comes down to code doing what other code does in the same situation
rather than trying to be clever.


> 
>>
>> Otherwise patch looks fine to me.
> 
> OK - I'll restore previous behavior and submit another patch.
> 
> cheers!
> grant
> 

