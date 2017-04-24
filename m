Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:54585 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1171403AbdDXO7z (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 24 Apr 2017 10:59:55 -0400
Message-ID: <1493045969.2446.47.camel@pengutronix.de>
Subject: Re: [PATCH v14 00/11] mux controller abstraction and iio/i2c muxes
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Peter Rosin <peda@axentia.se>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-doc@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Colin Ian King <colin.king@canonical.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        kernel@pengutronix.de
Date: Mon, 24 Apr 2017 16:59:29 +0200
In-Reply-To: <6fb34ea5-edc8-c7aa-1d49-f6ce1d33a2d4@axentia.se>
References: <1493022995-16917-1-git-send-email-peda@axentia.se>
         <1493031179.2446.9.camel@pengutronix.de>
         <2d978956-d247-917d-4150-a6723917a733@axentia.se>
         <1493043046.2446.37.camel@pengutronix.de>
         <6fb34ea5-edc8-c7aa-1d49-f6ce1d33a2d4@axentia.se>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, 2017-04-24 at 16:36 +0200, Peter Rosin wrote:
[...]
> > How about an atomic use_count on the mux_control, a bool shared that is
> > only set by the first consumer, and controls whether selecting locks?
> 
> That has the drawback that it is hard to restore the mux-control in a safe
> way so that exclusive consumers are allowed after the last shared consumer
> puts the mux away.

True.

> Agreed, it's a corner case, but I had this very similar
> patch going through the compiler when I got this mail. Does it work as well
> as what you suggested?

Yes, this patch works just as well.

regards
Philipp

