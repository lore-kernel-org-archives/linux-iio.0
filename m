Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:49880 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727462AbeKQEir (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 16 Nov 2018 23:38:47 -0500
Date: Fri, 16 Nov 2018 18:25:15 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Himanshu Jha <himanshujha199640@gmail.com>
Cc: linux-iio@vger.kernel.org
Subject: Re: Adding IIO list archives to lore.kernel.org
Message-ID: <20181116182515.18e35f99@archlinux>
In-Reply-To: <20181112202332.GA19098@himanshu-Vostro-3559>
References: <20181110183247.GA2023@himanshu-Vostro-3559>
        <20181111111947.7969c455@archlinux>
        <20181112202332.GA19098@himanshu-Vostro-3559>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, 13 Nov 2018 01:53:32 +0530
Himanshu Jha <himanshujha199640@gmail.com> wrote:

> On Sun, Nov 11, 2018 at 11:19:47AM +0000, Jonathan Cameron wrote:
> > On Sun, 11 Nov 2018 00:02:47 +0530
> > Himanshu Jha <himanshujha199640@gmail.com> wrote:
> >   
> > > Hi,
> > > 
> > > 
> > > It would be great to have linux-iio list on lore.kernel.org
> > > like few others.
> > > 
> > > https://www.kernel.org/lore.html
> > > 
> > > To request the list to be archieved:
> > > https://korg.wiki.kernel.org/userdoc/lore
> > > 
> > > I would have sent the request myself but I don't have an old
> > > archieve of iio-list and only 5-6 months of archieve.
> > > 
> > > So, old members of IIO are requested to create an archieve
> > > and send it to the admims.
> > > 
> > > Currently, we have marc.info archiving the list and it
> > > looks ulgy(atleast to me) and patchwork.kernel.org but IIRC
> > > it doesn't collect cover letters + no searching features ...
> > > 
> > > 
> > > 
> > > Thanks!  
> > I agree this would be great, but I don't have a remotely clean
> > archive unfortunately.  I might be able to reconstruct an
> > archive from various sources, but it won't be a trivial job.  
> 
> I had contacted Konstantin Ryabitsev for Coccinelle list and asked
> if he could pull pipermail archives of coccinelle
> https://systeme.lip6.fr/pipermail/cocci/
> 
> And he says:
> https://korg.wiki.kernel.org/userdoc/lore#can_you_use_mailman_archives
> 
> He further adds:
> 
> "Just a note that GMail is not a requirement by any means -- the
> list-archive-maker script can be used against any mbox or maildir
> directory. Gmail just happens to be a place where people have most
> complete archives, since nobody bothers deleting anything there."
> 
> Me: Can you pull IIO from marc.info ?
> KR: "Unfortunately, we cannot use marc.info archives, as they don't seem to
> include the original Message-ID, which is crucial for public-inbox
> purposes."
> 
> Anyway, Coccinelle list is now live:
> https://lore.kernel.org/cocci/
> 
> If anyone wants to help send the tarballs of the archieve, please send
> them to me. And it is collaborative effort as all the tarballs will
> be piled up through a script in the aforementioned userdock link neatly
> and without any redundancies.
> 
> The more(or old) the number of contributions, the better the archieve
> would be!
> 
> 
> Sadly, IIO list is not maintained as a pipermail otherwise it would
> have been easier to just pull it from there as done for Coccinelle.
> 
> 
> I will wait till first week of December for achieve donations and then 
> poke Konstantin to fire up 
> https://lore.kernel.org/iio/ and https://lore.kernel.org/kernelnewbies/
I'll see how well that script deals with my slightly messed up archives
(I tend to put private IIO emails in the same folder!)  If it looks good
I have the vast majority available on an imap server so should be fine
doing the IIO archive.

Thanks,

Jonathan

> 
> 
> Thanks!
