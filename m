Return-Path: <vapier.adi@gmail.com>
MIME-Version: 1.0
Sender: vapier.adi@gmail.com
In-Reply-To: <1287955358-3153-1-git-send-email-vapier@gentoo.org>
References: <1287955358-3153-1-git-send-email-vapier@gentoo.org>
From: Mike Frysinger <vapier@gentoo.org>
Date: Sun, 24 Oct 2010 17:35:39 -0400
Message-ID: <AANLkTi=iuV0QuCKWROfbEiX9E9qEsTH=Bh1bjC0FBcv_@mail.gmail.com>
Subject: Re: [Device-drivers-devel] [PATCH 00/36] staging: iio: ADI drivers
 for staging-next
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: device-drivers-devel@blackfin.uclinux.org, linux-iio@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Sun, Oct 24, 2010 at 17:22, Mike Frysinger wrote:
> I've rebased all the drivers onto staging-next. =C2=A0I've only fixed the=
 API
> breakage due to the changes made after 2.6.36 (and fixed a few warnings).
> I've also run checkpatch across these.
>
> I have not however addressed any real feedback Jonathan has provided with
> regards to driver correctness or direction. =C2=A0That stuff I'm leaving =
up to
> Michael Hennerich since it's his job and he actually understands this.
>
> Where possible, I'd like to have drivers merged so as to avoid another
> round of "new API just broke all your drivers". =C2=A0We will still look =
into
> feedback given, but we'd like to focus on that rather than random `sed`
> changes as API names change.

btw, how does the merging with IIO occur ?  do you take care of
bouncing them to gregkh ?  or does he watch this list ?  or do i have
to cc him too ?

my assumption is that i send IIO patches to you and then you get them
into the staging tree ...
-mike
