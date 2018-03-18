Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:47320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751744AbeCRKPM (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 18 Mar 2018 06:15:12 -0400
Date: Sun, 18 Mar 2018 10:15:06 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: linux-iio@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Pravin Shedge <pravin.shedge4linux@gmail.com>,
        Quentin Schulz <quentin.schulz@free-electrons.com>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Subject: Re: iio/gyro/bmg160_core: Improve unlocking of a mutex in five
 functions
Message-ID: <20180318101506.460f3967@archlinux>
In-Reply-To: <73f0a187-57d1-c877-ba9f-3b15f6a61640@users.sourceforge.net>
References: <16623de4-351d-135b-f3ff-701a465c5d92@users.sourceforge.net>
        <20180317195422.037a8b57@archlinux>
        <73f0a187-57d1-c877-ba9f-3b15f6a61640@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, 18 Mar 2018 09:19:47 +0100
SF Markus Elfring <elfring@users.sourceforge.net> wrote:

> Am 17.03.2018 um 20:54 schrieb Jonathan Cameron:
> > On Wed, 14 Mar 2018 16:15:32 +0100
> > SF Markus Elfring <elfring@users.sourceforge.net> wrote:
> >   
> >> From: Markus Elfring <elfring@users.sourceforge.net>
> >> Date: Wed, 14 Mar 2018 16:06:49 +0100
> >>
> >> * Add jump targets so that a call of the function "mutex_unlock" is stored
> >>   only once in these function implementations.
> >>
> >> * Replace 19 calls by goto statements.
> >>
> >> This issue was detected by using the Coccinelle software.
> >>
> >> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>  
> > 
> > Hi Markus,
> > 
> > Some of these are good and sensible changes  
> 
> Such feedback is nice.
> 
> 
> > - others break the code.  
> 
> Which concrete places do you find questionable here?
> 
> 
> >> -		return ret;
> >> +
> >> +		goto set_power_state;
> >>  	default:
> >>  		return -EINVAL;  
> > We exit with the mutex locked now and it should not be.  
> 
> I wonder about your source code interpretation here.
> The mutex was (and is still only) locked within case branches, isn't it?
> 
You are correct, this does however reflect the issue with the resulting
lack of balance here.  I saw the mutex was getting unlocked outside
the local scope and so assumed that it was also take outside the local
scope.  That isn't true, so we have hurt readability.

It might make sense to move the lock and unlock outside the switch statement
but we certainly don't want to the the confusion that the lack of balance is
causing here.

I read it quickly and got the wrong idea which generally implies it is not
as clear as we would like.

Hence this change isn't going anywhere I'm afraid.

Jonathan

> 
> >   
> >>  	}
> >>  
> >>  	return -EINVAL;  
> > Mutex is still locked here and the return is wrong.  
> 
> Should this statement get any more software development attention?
> 
> Regards,
> Markus

