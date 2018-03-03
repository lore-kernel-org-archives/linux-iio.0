Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:57414 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751896AbeCCPAE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 3 Mar 2018 10:00:04 -0500
Date: Sat, 3 Mar 2018 15:00:01 +0000
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To: Daniel Baluta <daniel.baluta@gmail.com>
Cc: "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>
Subject: Re: [PATCH] staging: iio: ad5933: merge ring init function into
 probe function
Message-ID: <20180303150001.7040ecc9@archlinux>
In-Reply-To: <CAEnQRZAL17PCfdK0nUx35e5DUznt_g7CGb5fNv=v_HXtFq9APg@mail.gmail.com>
References: <20180216120915.19277-1-alexandru.ardelean@analog.com>
        <20180224121747.6ff4b90b@archlinux>
        <1519631043.4724.14.camel@analog.com>
        <CAEnQRZAL17PCfdK0nUx35e5DUznt_g7CGb5fNv=v_HXtFq9APg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, 26 Feb 2018 12:47:28 +0200
Daniel Baluta <daniel.baluta@gmail.com> wrote:

> On Mon, Feb 26, 2018 at 9:44 AM, Ardelean, Alexandru
> <alexandru.Ardelean@analog.com> wrote:
> > On Sat, 2018-02-24 at 12:18 +0000, Jonathan Cameron wrote:  
> >> On Fri, 16 Feb 2018 14:09:15 +0200
> >> Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:
> >>  
> >> > This is a small cleanup of the driver's init code.
> >> > It does not fix anything.
> >> >
> >> > The `devm_iio_kfifo_allocate()` function is used instead of
> >> > `iio_kfifo_allocate()`.  This removes the need for explicit deallocation of
> >> > the driver's iio_buffer, which will now be handled via
> >> > `iio_device_unregister()`.
> >> >
> >> > The `setup_ops` assignment has been moved into the `ad5933_probe()` call,
> >> > since it's a one-liner.
> >> >
> >> > Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> >> > ---
> >> >
> >> > Note: this change is based on top of `fixes-togreg-post-rc1` branch which
> >> > contains commit (7d2b8e6aaf9: staging: iio: ad5933: switch buffer mode to
> >> > software)  
> >>
> >> It will take a few weeks for that to get to my togreg branch so please
> >> do remind me if it has and I seem to have forgotten this!
> >>
> >> Jonathan  
> >
> > I'm a bit new to how things progress in the iio subtree.
> > [Curious] Is there a recommended branch that is regularly updated with accepted
> > patches ?
> > Or which branches do I need to rebase when submitting other patches ?  
> 
> 
> Salut Alexandru,
> 
> You can use the togreg branch of iio tree.
That tends to only get updated fairly infrequently except when I'm doing
a pull request but that is 'in theory' the right branch to use.

In practice, the only reason I'd change things in the testing branch
is a build failure or a comment from someone suggesting a reason to pull
a patch.  Mind you I've been pretty bad at remembering to push that out
as well recently :(  I only find out when I realise I didn't get a build
report from 0-day when I get to work on Monday.

Jonathan

> 
> thanks,
> Daniel.

