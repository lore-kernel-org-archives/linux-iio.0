Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:36372 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933682AbdCUSus (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 21 Mar 2017 14:50:48 -0400
Date: Tue, 21 Mar 2017 11:50:41 -0700
From: Alison Schofield <amsfield22@gmail.com>
To: simran singhal <singhalsimran0@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, outreachy-kernel@googlegroups.com
Subject: Re: [Outreachy kernel] [PATCH v3 0/2] Replace mlock with private
 lock and delete whitespaces
Message-ID: <20170321185040.GA11324@d830.WORKGROUP>
References: <1490119436-20042-1-git-send-email-singhalsimran0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1490119436-20042-1-git-send-email-singhalsimran0@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, Mar 21, 2017 at 11:33:54PM +0530, simran singhal wrote:
> The patch series replaces mlock with a private lock for driver ad9834 and
> Fix coding style issues related to white spaces.

Hi Simran,  

I'm getting lost.  Patchset Subject Line needs subsystem and driver.
The comment above says ad9834 but the patches below say ade7753.

Can we drive adis16060 through ACK and then come back to this one?
(ie. applyling lessons learned)

thanks,
alisons
> 
> v3:
>   -Using new private "lock" instead of using "buf_lock"
>    as it can cause deadlock.
>   -Sending it as a series of two patches.
> 
> v2:
>   -Using the existing buf_lock instead of lock.
>    
> 
> simran singhal (2):
>   staging: iio: ade7753: Remove trailing whitespaces
>   staging: iio: ade7753: Replace mlock with driver private lock
> 
>  drivers/staging/iio/meter/ade7753.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 
> -- 
> 2.7.4
> 
> -- 
> You received this message because you are subscribed to the Google Groups "outreachy-kernel" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to outreachy-kernel+unsubscribe@googlegroups.com.
> To post to this group, send email to outreachy-kernel@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/outreachy-kernel/1490119436-20042-1-git-send-email-singhalsimran0%40gmail.com.
> For more options, visit https://groups.google.com/d/optout.
