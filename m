Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:37695 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753626Ab2GIUi5 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 9 Jul 2012 16:38:57 -0400
Received: by pbbrp8 with SMTP id rp8so19767971pbb.19
        for <linux-iio@vger.kernel.org>; Mon, 09 Jul 2012 13:38:57 -0700 (PDT)
Date: Mon, 9 Jul 2012 13:38:53 -0700
From: Greg KH <gregkh@linuxfoundation.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PULL] IIO fixes
Message-ID: <20120709203853.GA29046@kroah.com>
References: <4FF9DFB7.70903@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4FF9DFB7.70903@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, Jul 08, 2012 at 08:29:59PM +0100, Jonathan Cameron wrote:
> Hi Greg,
> 
> To get a clean start on doing this without merges this is on top of
> your staging/staging-next tree of a few days back.
> 
> I 'think' the signed tag should be correct.
> 
> All comments welcome.
> 
> The following changes since commit 0932966b1ca03217c6e0c18375867b1a99ee5af0:
> 
>   staging: ccg: print MAC addresses via %pM (2012-07-06 16:24:00 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git
> tags/fixes-togreg_8_7_2012

What's with the line-wrap?

And the numbers after "togreg"?  What's that for?

> 
> for you to fetch changes up to 7b7627410e2c211f24787f61e6419e16d259aa13:
> 
>   iio: Fix inkern remove incorrect put of device (2012-07-08 20:02:31 +0100)
> 
> ----------------------------------------------------------------
> Mixed bag of IIO fixes.
> 
> Quite a few cases of interrupt handlers returning
> errors and a few more specific bits and bobs.
> 
> Most of these only effect fairly obscure error
> paths. The IRQF_ONESHOT one may cause trouble
> given the requests will now be rejected.
> 
> Jonathan
> 
> 8_7_2012

The date perhaps?  I've not seen that in a commit message before, I
doubt it's needed :)

Other than those minor things, looks good, I've pulled and pushed this
out.

thanks,

greg k-h
