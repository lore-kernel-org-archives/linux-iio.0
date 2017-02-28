Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36509 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751030AbdB1RHR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 28 Feb 2017 12:07:17 -0500
Received: by mail-wm0-f67.google.com with SMTP id r18so3377254wmd.3
        for <linux-iio@vger.kernel.org>; Tue, 28 Feb 2017 09:06:22 -0800 (PST)
Date: Tue, 28 Feb 2017 19:06:19 +0200
From: Narcisa Ana Maria Vasile <narcisaanamaria12@gmail.com>
To: Alison Schofield <amsfield22@gmail.com>
Cc: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        outreachy-kernel@googlegroups.com, linux-iio@vger.kernel.org
Subject: Re: [Outreachy kernel] [PATCH] staging: iio: Deleted TODO file which
 contained redundant information
Message-ID: <20170228170618.GA1177@nati-X550JK>
References: <1488299669-22372-1-git-send-email-narcisaanamaria12@gmail.com>
 <20170228164926.GA15033@d830.WORKGROUP>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170228164926.GA15033@d830.WORKGROUP>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, Feb 28, 2017 at 08:49:26AM -0800, Alison Schofield wrote:
> On Tue, Feb 28, 2017 at 06:34:29PM +0200, Narcisa Ana Maria Vasile wrote:
> > The TODO file contained redundant information which can be obtained
> > using ./scripts/get_maintainer.pl.
> 
> Hi Narcisa,
> I think we want to leave the TODO file even though it is fairly sparse
> at this time.  It's content will grow & shrink with actual todo items,
> and of course, it's nice to have the git log for reference.
> alisons
>
  Hi, 
  Ok, thanks for letting me know
  Narcisa
> > 
> > Signed-off-by: Narcisa Ana Maria Vasile <narcisaanamaria12@gmail.com>
> > ---
> >  drivers/staging/iio/TODO | 8 --------
> >  1 file changed, 8 deletions(-)
> >  delete mode 100644 drivers/staging/iio/TODO
> > 
> > diff --git a/drivers/staging/iio/TODO b/drivers/staging/iio/TODO
> > deleted file mode 100644
> > index 4922402..0000000
> > --- a/drivers/staging/iio/TODO
> > +++ /dev/null
> > @@ -1,8 +0,0 @@
> > -2016 10/09
> > -
> > -ADI Drivers:
> > -CC the device-drivers-devel@blackfin.uclinux.org mailing list when
> > -e-mailing the normal IIO list (see below).
> > -
> > -Contact: Jonathan Cameron <jic23@kernel.org>.
> > -Mailing list: linux-iio@vger.kernel.org
> > -- 
> > 1.9.1
> > 
> > -- 
> > You received this message because you are subscribed to the Google Groups "outreachy-kernel" group.
> > To unsubscribe from this group and stop receiving emails from it, send an email to outreachy-kernel+unsubscribe@googlegroups.com.
> > To post to this group, send email to outreachy-kernel@googlegroups.com.
> > To view this discussion on the web visit https://groups.google.com/d/msgid/outreachy-kernel/1488299669-22372-1-git-send-email-narcisaanamaria12%40gmail.com.
> > For more options, visit https://groups.google.com/d/optout.
