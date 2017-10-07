Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:37328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750931AbdJGLTP (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 7 Oct 2017 07:19:15 -0400
Date: Sat, 7 Oct 2017 12:19:10 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Simon Horman <horms@verge.net.au>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH 2/3] iio: adc: rcar-gyroadc: Enable compile-testing on
 non-ARM
Message-ID: <20171007121910.02be4ecb@archlinux>
In-Reply-To: <20171005091219.GJ26369@verge.net.au>
References: <1507118906-8946-1-git-send-email-geert+renesas@glider.be>
        <1507118906-8946-3-git-send-email-geert+renesas@glider.be>
        <20171005091219.GJ26369@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, 5 Oct 2017 11:12:21 +0200
Simon Horman <horms@verge.net.au> wrote:

> On Wed, Oct 04, 2017 at 02:08:25PM +0200, Geert Uytterhoeven wrote:
> > The rcar-gyroadc driver compiles fine on other platforms, hence increase
> > compile coverage.
> > 
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>  
> 
> Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
> 
Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan
