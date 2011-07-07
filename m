Return-Path: <bfreed@google.com>
MIME-Version: 1.0
Sender: bfreed@google.com
In-Reply-To: <20110706232720.GA28400@kroah.com>
References: <1309978586-10092-1-git-send-email-bfreed@chromium.org>
	<20110706232720.GA28400@kroah.com>
Date: Thu, 7 Jul 2011 10:03:53 -0700
Message-ID: <CAEYUcX2C4XqYW1NgqzV+KbdHdcKRs1V3RFVnCN7C=bhojywA=g@mail.gmail.com>
Subject: Re: [PATCH 1/3] staging:iio: Reorder channel type strings to match
 the iio.h enums.
From: Bryan Freed <bfreed@chromium.org>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, jic23@cam.ac.uk, gregkh@suse.de,
        rklein@nvidia.com, linux-iio@vger.kernel.org
Content-Type: multipart/alternative; boundary=000e0cd4bde2aa111004a77db3c0
List-ID: <linux-iio@vger.kernel.org>

--000e0cd4bde2aa111004a77db3c0
Content-Type: text/plain; charset=ISO-8859-1

These are made from git://
git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git last synced
on 6/22.

I synced up just now and had no problem cherry-picking the first two patches
into a new branch.
The third one required a manual merge, but I am not sure why.  They were all
my diffs.

I will resubmit them all in a moment.

bryan.

On Wed, Jul 6, 2011 at 4:27 PM, Greg KH <greg@kroah.com> wrote:

> On Wed, Jul 06, 2011 at 11:56:24AM -0700, Bryan Freed wrote:
> > This makes comparison between the iio_chan_type_name_spec_shared strings
> > and the iio_chan_type enums easier.
>
> This, and patch 2/3, don't apply at all to my tree, what did you make
> them against?
>
> greg k-h
>

--000e0cd4bde2aa111004a77db3c0
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

These are made from git://<a href=3D"http://git.kernel.org/pub/scm/linux/ke=
rnel/git/torvalds/linux-2.6.git">git.kernel.org/pub/scm/linux/kernel/git/to=
rvalds/linux-2.6.git</a> last synced on 6/22.<div><br></div><div>I synced u=
p just now and had no problem cherry-picking the first two patches into a n=
ew branch.</div>
<div>The third one required a manual merge, but I am not sure why. =A0They =
were all my diffs.</div><div><br></div><div>I will resubmit them all in a m=
oment.</div><div><br></div><div>bryan.<br><br><div class=3D"gmail_quote">On=
 Wed, Jul 6, 2011 at 4:27 PM, Greg KH <span dir=3D"ltr">&lt;<a href=3D"mail=
to:greg@kroah.com">greg@kroah.com</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex;"><div class=3D"im">On Wed, Jul 06, 2011 at 1=
1:56:24AM -0700, Bryan Freed wrote:<br>
&gt; This makes comparison between the iio_chan_type_name_spec_shared strin=
gs<br>
&gt; and the iio_chan_type enums easier.<br>
<br>
</div>This, and patch 2/3, don&#39;t apply at all to my tree, what did you =
make<br>
them against?<br>
<br>
greg k-h<br>
</blockquote></div><br></div>

--000e0cd4bde2aa111004a77db3c0--
