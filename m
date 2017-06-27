Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:45618 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751412AbdF0GoB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 27 Jun 2017 02:44:01 -0400
Date: Tue, 27 Jun 2017 08:43:54 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: jic23@kernel.org, paolocretaro@gmail.com,
        linux-amlogic@lists.infradead.org, linux-iio@vger.kernel.org
Subject: Re: patch "iio: adc: meson-saradc: use NULL instead of 0 for
 pointer" added to staging-testing
Message-ID: <20170627064354.GA29793@kroah.com>
References: <14984537865458@kroah.com>
 <CAFBinCDOSaHF9GwGhMUpZjR7AUVWVwk7EJmHWt0q8bkChBhMZA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAFBinCDOSaHF9GwGhMUpZjR7AUVWVwk7EJmHWt0q8bkChBhMZA@mail.gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, Jun 26, 2017 at 08:57:18PM +0200, Martin Blumenstingl wrote:
> Hi Greg, Hi Jonathan,
> 
> On Mon, Jun 26, 2017 at 7:09 AM,  <gregkh@linuxfoundation.org> wrote:
> >
> > This is a note to let you know that I've just added the patch titled
> >
> >     iio: adc: meson-saradc: use NULL instead of 0 for pointer
> >
> > to my staging git tree which can be found at
> >     git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git
> > in the staging-testing branch.
> >
> > The patch will show up in the next release of the linux-next tree
> > (usually sometime within the next 24 hours during the week.)
> >
> > The patch will be merged to the staging-next branch sometime soon,
> > after it passes testing, and the merge window is open.
> >
> > If you have any questions about this process, please let me know.
> is there a way to drop below patch from your repo?
> during testing I found out that the code before and after this patch
> leads to a NULL deref. I provided a fix (see [0]) which solves the
> crash and the warning as reported by Paolo - and that fix is already
> part of v4.12-rc6
> so the patch below will cause a merge conflict

I already handled the merge conflict, can you verify I got it right in
my tree?

thanks,

greg k-h
