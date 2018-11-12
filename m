Return-Path: <SRS0=6tCW=NX=gmail.com=himanshujha199640@kernel.org>
Date: Tue, 13 Nov 2018 01:53:32 +0530
From: Himanshu Jha <himanshujha199640@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org
Subject: Re: Adding IIO list archives to lore.kernel.org
Message-ID: <20181112202332.GA19098@himanshu-Vostro-3559>
References: <20181110183247.GA2023@himanshu-Vostro-3559>
 <20181111111947.7969c455@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20181111111947.7969c455@archlinux>
List-ID: <linux-iio@vger.kernel.org>

On Sun, Nov 11, 2018 at 11:19:47AM +0000, Jonathan Cameron wrote:
> On Sun, 11 Nov 2018 00:02:47 +0530
> Himanshu Jha <himanshujha199640@gmail.com> wrote:
> 
> > Hi,
> > 
> > 
> > It would be great to have linux-iio list on lore.kernel.org
> > like few others.
> > 
> > https://www.kernel.org/lore.html
> > 
> > To request the list to be archieved:
> > https://korg.wiki.kernel.org/userdoc/lore
> > 
> > I would have sent the request myself but I don't have an old
> > archieve of iio-list and only 5-6 months of archieve.
> > 
> > So, old members of IIO are requested to create an archieve
> > and send it to the admims.
> > 
> > Currently, we have marc.info archiving the list and it
> > looks ulgy(atleast to me) and patchwork.kernel.org but IIRC
> > it doesn't collect cover letters + no searching features ...
> > 
> > 
> > 
> > Thanks!
> I agree this would be great, but I don't have a remotely clean
> archive unfortunately.  I might be able to reconstruct an
> archive from various sources, but it won't be a trivial job.

I had contacted Konstantin Ryabitsev for Coccinelle list and asked
if he could pull pipermail archives of coccinelle
https://systeme.lip6.fr/pipermail/cocci/

And he says:
https://korg.wiki.kernel.org/userdoc/lore#can_you_use_mailman_archives

He further adds:

"Just a note that GMail is not a requirement by any means -- the
list-archive-maker script can be used against any mbox or maildir
directory. Gmail just happens to be a place where people have most
complete archives, since nobody bothers deleting anything there."

Me: Can you pull IIO from marc.info ?
KR: "Unfortunately, we cannot use marc.info archives, as they don't seem to
include the original Message-ID, which is crucial for public-inbox
purposes."

Anyway, Coccinelle list is now live:
https://lore.kernel.org/cocci/

If anyone wants to help send the tarballs of the archieve, please send
them to me. And it is collaborative effort as all the tarballs will
be piled up through a script in the aforementioned userdock link neatly
and without any redundancies.

The more(or old) the number of contributions, the better the archieve
would be!


Sadly, IIO list is not maintained as a pipermail otherwise it would
have been easier to just pull it from there as done for Coccinelle.


I will wait till first week of December for achieve donations and then 
poke Konstantin to fire up 
https://lore.kernel.org/iio/ and https://lore.kernel.org/kernelnewbies/


Thanks!
-- 
Himanshu Jha
Undergraduate Student
Department of Electronics & Communication
Guru Tegh Bahadur Institute of Technology
