Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:57572 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932400AbdJZPwG (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 26 Oct 2017 11:52:06 -0400
Date: Thu, 26 Oct 2017 16:46:32 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-iio@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Subject: Re: iio/accel/bmc150: Improve unlocking of a mutex in two functions
Message-ID: <20171026164632.4d577d95@archlinux>
In-Reply-To: <12013256-ad6a-86ed-9bc1-e5d868189914@users.sourceforge.net>
References: <66d582a4-a77e-cd78-4215-49587ec2259e@users.sourceforge.net>
        <fb223eb2-ddab-396e-372e-e9496be8bf0f@redhat.com>
        <c32ea2ea-5961-6589-6b51-1184d9565a38@users.sourceforge.net>
        <6a2c614a-4d0d-f2d2-1689-4c67a2fc3eea@redhat.com>
        <7a76d804-797c-8a7f-a755-9e42f9157287@users.sourceforge.net>
        <26467a3c-00e7-7358-5087-bf35469feb06@redhat.com>
        <12013256-ad6a-86ed-9bc1-e5d868189914@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, 25 Oct 2017 20:07:48 +0200
SF Markus Elfring <elfring@users.sourceforge.net> wrote:

> > What you are suggesting breaks this pattern  
> 
> I might be looking for an other balance between involved implementation
> details after your constructive feedback for my first approach
> in this software module.
> 
> 
> > (not using a goto in the last if (err) case)  
> 
> I would find it nice when a bit more code reduction is feasible.
> 
> 
> > which makes the code harder to read and makes things harder
> > (and potentially leads to introducing bugs) when
> > a step4() gets added.  
> 
> There is a choice between conservative adjustments and progressive
> software refactoring where both directions can lead to similar
> development risks.
> 
> 
> >>> because that way the error handling is consistent between all steps
> >>> and if another step is later added at the end, the last step will
> >>> not require modification.  
> 
> Such a view might express a change resistance.
> 
> 
> >> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/drivers/iio/accel/kxcjk-1013.c?id=1540d0106bcbc4e52013d759a0a0752ae7b4a09d#n760  
> > 
> > So I just checked this one,  
> 
> Thanks for your interest.
> 
> 
> > this one is tricky because the lock is taking inside
> > a switch-case and doing gotos inside the case is not pretty.  
> 
> I imagine that I would like to use scoped lock objects
> in affected source files. (Other programming languages support
> such synchronisation constructs directly.)

I'd keep it simple for now. Also, I'd actually take a different
approach to tidy up this case we are talking about here.

Factor out the whole case IIO_CHAN_INFO_RAW block as a 
utility function.  Then nice clean and simple lock handling
can be done in the error paths without the readability problems
that you get doing it deeply nested.

Btw. There is another issue in that code that needs fixing
which is that it will race with the buffer being enabled.
It should be using the iio_claim_direct infrastructure to
prevent that cleanly. 

That example is definitely more ugly that it needs to be
so would be nice to clean it up if you have time.

Thanks,

Jonathan
> 
> 
> > Basically I believe there is no one-size fits all solution
> > here and refactoring like this may introduce bugs, so one
> > needs to weight the amount of work + regression risk vs
> > the benefits of the code being cleaner going forward.  
> 
> It seems that our software development discussion can be
> continued in a constructive way then.
> 
> Regards,
> Markus
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

