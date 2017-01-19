Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:39716 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752332AbdASLlt (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 19 Jan 2017 06:41:49 -0500
Date: Thu, 19 Jan 2017 12:42:01 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: William Breathitt Gray <vilhelm.gray@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        Alexandre Courbot <gnurou@gmail.com>
Subject: Re: [PATCH 3/3] iio: pc104: Mask PC/104 drivers via the PC104
 Kconfig option
Message-ID: <20170119114201.GA31804@kroah.com>
References: <cover.1484073324.git.vilhelm.gray@gmail.com>
 <512f7f9909c9ff6964b34e0302eeb404e703f033.1484073325.git.vilhelm.gray@gmail.com>
 <4236ccf5-1480-ea3c-fee6-35ea252e3756@kernel.org>
 <20170110214535.GA21354@sophia>
 <CACRpkdaXRHJXjujQDi2NhXpg+yYzDBmfoq+e9tiTkNNAyECs=w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CACRpkdaXRHJXjujQDi2NhXpg+yYzDBmfoq+e9tiTkNNAyECs=w@mail.gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, Jan 11, 2017 at 04:45:26PM +0100, Linus Walleij wrote:
> On Tue, Jan 10, 2017 at 10:45 PM, William Breathitt Gray
> <vilhelm.gray@gmail.com> wrote:
> > On Tue, Jan 10, 2017 at 09:13:02PM +0000, Jonathan Cameron wrote:
> >>On 10/01/17 18:51, William Breathitt Gray wrote:
> >>> PC/104 drivers should be hidden on machines which do not support PC/104
> >>> devices. This patch adds the PC104 Kconfig option as a dependency for
> >>> the relevant PC/104 device driver Kconfig options.
> >>>
> >>> Cc: Jonathan Cameron <jic23@kernel.org>
> >>> Cc: Hartmut Knaack <knaack.h@gmx.de>
> >>> Cc: Lars-Peter Clausen <lars@metafoo.de>
> >>> Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
> >>> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
> >>Acked-by: Jonathan Cameron <jic23@kernel.org>
> >>
> >>Now the question is how to merge this one.  Let me know if you
> >>want me to take this one via IIO after the first patch is in.
> >>If you want to take it another route I'm fine with that.
> >>
> >>Jonathan
> >
> > This is such a simple patchset that I envision Greg K-H picking up all
> > three patches via driver-core; however, I'm pretty indifferent about the
> > ultimate path in the end. I'll leave it up to Greg K-H to decide.
> 
> As long as Greg merges the first patch we can merge the two
> others orthogonally I think.
> 
> It's just Kconfig symbols, not things that break compile.
> 
> (But I bet someone will come with automated warnings about
> unused symbols in the kernel...)

We already have that tool, scripts/checkkconfigsymbols.pl :)

I'll go merge this first patch now.

thanks,

greg k-h
