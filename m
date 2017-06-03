Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:41988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751077AbdFCJIE (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 3 Jun 2017 05:08:04 -0400
Date: Sat, 3 Jun 2017 10:07:58 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Sanchayan Maity <maitysanchayan@gmail.com>,
        Gregor Boirie <gregor.boirie@parrot.com>,
        Matt Ranostay <mranostay@gmail.com>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chris Healy <Chris.Healy@zii.aero>,
        Jeff White <Jeff.White@zii.aero>,
        Vladimir Barinov <vladimir.barinov@cogentembedded.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH/RFC] iio: hi8435: do not enable all events by default
Message-ID: <20170603100758.6164e219@kernel.org>
In-Reply-To: <b47aa21c-925d-7a83-7bd0-0d9d73f79017@cogentembedded.com>
References: <20170523080830.20571-1-nikita.yoush@cogentembedded.com>
        <20170524202735.3cf4e14e@kernel.org>
        <2e6019f5-94fc-bb13-f616-0c1cfe81a7db@cogentembedded.com>
        <20170528164846.3fa3d4d8@kernel.org>
        <b47aa21c-925d-7a83-7bd0-0d9d73f79017@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, 29 May 2017 08:40:26 +0300
Nikita Yushchenko <nikita.yoush@cogentembedded.com> wrote:

> >> Still, isn't there subsystem-level default that all events are disabled
> >> by default?  If such, then current hi8435 state breaks subsystem-level
> >> rules, which is a [userspace-visible] bug.  I'm not sure how far should
> >> we go in bug compatibility.  
> >
> > It is indeed the subsystem default (as much as we have one)
> > 
> > This is a moderately obscure chip for linux systems, do we have a good handle
> > on where it is being used - i.e. are most of the devices under control of
> > people we can discuss this with?  
> 
> Company I work with, uses this chip in several boards; what they need is
> a service that monitors all connected chip's outputs and detects
> changes.  They originally wanted gpio-style access to use with userspace
> polling, and were not pleased with entire IIO thing. However it's
> important for them to minimize required kernel patches against mainline,
> thus if mainline supports this chip as IIO device that's ok for them.
Was always an odd corner case - and I'll admit it wasn't one that made
me very comfortable either. One option would be to put a GPIO bridge
driver in place so that both interfaces are available.  I know this is
something Linus and I have thought about in the past for various
use cases.
> 
> Questions like default event enable state has little practical impact.
> It's more about keeping architecture clean.
I'm going to go with not changing this, even though it matters little to
either of you.  Simply because we clearly do have a non trivial number of
users and this would be ABI breakage.

Jonathan

> 
> Nikita
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

