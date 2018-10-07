Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:37536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726448AbeJGW7W (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 7 Oct 2018 18:59:22 -0400
Date: Sun, 7 Oct 2018 16:51:35 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Simon Horman <horms@verge.net.au>
Cc: Marek Vasut <marek.vasut@gmail.com>, linux-iio@vger.kernel.org,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Joe Perches <joe@perches.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH V2] iio: adc: Fix Renesas GyroADC MAINTAINERS entry
Message-ID: <20181007165135.5ec280c0@archlinux>
In-Reply-To: <20181004093552.wmyhcfweh6pim55e@verge.net.au>
References: <20181002010013.8765-1-marek.vasut+renesas@gmail.com>
        <20181004093552.wmyhcfweh6pim55e@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, 4 Oct 2018 11:35:52 +0200
Simon Horman <horms@verge.net.au> wrote:

> On Tue, Oct 02, 2018 at 03:00:13AM +0200, Marek Vasut wrote:
> > Fix the F: entry in MAINTAINERS file, point it to the correct file.
> > While at it, add DT binding doc F: entry too.
> > 
> > Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
> > Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> > Cc: Joe Perches <joe@perches.com>
> > Cc: Jonathan Cameron <jic23@kernel.org>
> > Cc: Simon Horman <horms+renesas@verge.net.au>
> > Cc: Wolfram Sang <wsa@the-dreams.de>
> > Cc: linux-renesas-soc@vger.kernel.org
> > ---
> > V2: Add DT binding doc F: entry  
> 
> Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Applied to the togreg branch of iio.git and pushed out as
testing for the autobuilders to completely ignore it.

Thanks,

Jonathan
> 
