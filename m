Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:35140 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751135AbdB1RTF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 28 Feb 2017 12:19:05 -0500
Date: Tue, 28 Feb 2017 18:18:42 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Peter Rosin <peda@axentia.se>
Cc: linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH v9 00/10] mux controller abstraction and iio/i2c muxes
Message-ID: <20170228171842.GA11127@kroah.com>
References: <1486568517-6997-1-git-send-email-peda@axentia.se>
 <6d87465f-b983-3f62-c7cf-41ed4e50170d@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <6d87465f-b983-3f62-c7cf-41ed4e50170d@axentia.se>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, Feb 28, 2017 at 04:17:52PM +0100, Peter Rosin wrote:
> Hi!
> 
> The status of this series [1] is that Rob Herring has acked/reviewed all
> devicetree changes, so I suppose that's ok. Jonathan Cameron has acked
> the additions to the iio subsystem and reviewed the new iio driver.
> Wolfram Sang has acked the i2c-mux driver. That's acks or reviews from
> the maintainers for all changes to the maintained areas.
> 
> What's not covered by the above is the mux subsystem itself. Jonathan
> has also acked or reviewed those changes, but I get the feeling that
> more tags are desired? So, please review the core of the mux subsystem
> and the two drivers! It's small. Really. And much of it is boilerplate
> devm functions. The relevant patches are:
> 
>  3/10 "mux: minimal mux subsystem and gpio-based mux controller"
> 10/10 "mux: adg792a: add mux controller driver for ADG792A/G"
> 
> I also wonder how I should proceed next. Jonathan kindly provided some
> hints. I have created a project on gitlab [2] to track future mux
> changes and where this series is also available (in the "mux" branch,
> of course subject to rebases, at least for now). I intend to create a
> for-next branch that I hope Stephen Rothwell will be happy to add to
> linux-next at some point after v4.11-rc1. Whomever I will feed future
> changes to will also pull from that tree. Etc. At least that's my
> picture of how this is going to work.
> 
> The question then becomes to whom I will send pull requests? My guess is
> that the plausible candidates are Greg K-H, Linus Torvalds and Andrew
> Morton. Any taker? Are there other candidates? I don't have any particular
> preference. If I don't hear anything I'll probably just send a pull
> request to Linus for the next merge window (i.e. targeting 4.12-rc1).
> 
> Or am I perhaps getting ahead of myself? Is a new tree overkill? I
> don't expect it to be exactly busy...

I pull in lots of semi-random driver subsystems into my char-misc driver
tree, and I can do that here for you as well if you want me to, to
forward things on to Linus at the proper times.

Just let me know.

thanks,

greg k-h
