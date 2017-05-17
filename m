Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:58885 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754521AbdEQJjG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 17 May 2017 05:39:06 -0400
Message-ID: <1495013919.3030.43.camel@pengutronix.de>
Subject: Re: [PATCH v15 03/13] mux: minimal mux subsystem
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Peter Rosin <peda@lysator.liu.se>
Cc: linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Rosin <peda@axentia.se>,
        Wolfram Sang <wsa@the-dreams.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Cameron <jic23@kernel.org>,
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
Date: Wed, 17 May 2017 11:38:39 +0200
In-Reply-To: <1494791476-14599-4-git-send-email-peda@lysator.liu.se>
References: <1494791476-14599-1-git-send-email-peda@lysator.liu.se>
         <1494791476-14599-4-git-send-email-peda@lysator.liu.se>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, 2017-05-14 at 21:51 +0200, Peter Rosin wrote:
> From: Peter Rosin <peda@axentia.se>
> 
> Add a new minimalistic subsystem that handles multiplexer controllers.
> When multiplexers are used in various places in the kernel, and the
> same multiplexer controller can be used for several independent things,
> there should be one place to implement support for said multiplexer
> controller.
> 
> A single multiplexer controller can also be used to control several
> parallel multiplexers, that are in turn used by different subsystems
> in the kernel, leading to a need to coordinate multiplexer accesses.
> The multiplexer subsystem handles this coordination.
> 
> Thanks go out to Lars-Peter Clausen, Jonathan Cameron, Rob Herring,
> Wolfram Sang, Paul Gortmaker, Dan Carpenter, Colin Ian King, Greg
> Kroah-Hartman and last but certainly not least to Philipp Zabel for
> helpful comments, reviews, patches and general encouragement!
> 
> Reviewed-by: Jonathan Cameron <jic23@kernel.org>
> Signed-off-by: Peter Rosin <peda@axentia.se>

Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
Tested-by: Philipp Zabel <p.zabel@pengutronix.de>
(using video-mux [1] on i.MX6)

[1] https://patchwork.kernel.org/patch/9712131/

regards
Philipp

