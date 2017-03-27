Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-lf0-f42.google.com ([209.85.215.42]:33484 "EHLO
        mail-lf0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752336AbdC0Odr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 27 Mar 2017 10:33:47 -0400
Date: Mon, 27 Mar 2017 16:33:33 +0200
From: Johan Hovold <johan@kernel.org>
To: Peter Rosin <peda@axentia.se>
Cc: Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-doc@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Colin Ian King <colin.king@canonical.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: [PATCH v11 11/12] iio: multiplexer: fix unsigned check with less
 than zero
Message-ID: <20170327143333.GB15708@localhost>
References: <1490617069-13119-1-git-send-email-peda@axentia.se>
 <1490617069-13119-12-git-send-email-peda@axentia.se>
 <20170327130653.GA15708@localhost>
 <c8195c34-3f96-b848-e01f-83c63a960153@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <c8195c34-3f96-b848-e01f-83c63a960153@axentia.se>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, Mar 27, 2017 at 03:46:47PM +0200, Peter Rosin wrote:
> On 2017-03-27 15:06, Johan Hovold wrote:
> > On Mon, Mar 27, 2017 at 02:17:48PM +0200, Peter Rosin wrote:
> >> Comparing a size_t with less than zero is always false as size_t
> >> is unsigned. So, change the type of the variable to ssize_t and
> >> replicate the size check from mux_configure_channel() into
> >> mux_write_ext_info() thus ensuring that the size will fit in the
> >> ssize_t variable.
> >>
> >> Detected by CoverityScan, CID#1415278 ("Unsigned compared against 0")
> >>
> >> Fixes: 1da8e16d2812 ("iio: multiplexer: new iio category and iio-mux driver")
> > 
> > You should fold this one and the next patch into the patches that they
> > fix up instead fixing stuff that's not yet merged incrementally like you
> > do here (specifically, the SHA id above will have no matching commit).

> I forgot about that. And similar for the next patch. But how do you
> propose that I attribute the reporters and CoverityScan?

You can mention it in the cover letter and/or commit messages as you
would for other kinds of review feedback.

Johan
