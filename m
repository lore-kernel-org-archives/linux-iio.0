Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:37410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750931AbdJGLVD (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 7 Oct 2017 07:21:03 -0400
Date: Sat, 7 Oct 2017 12:20:58 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Simon Horman <horms@verge.net.au>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH 3/3] iio: adc: rcar-gyroadc: Use
 of_device_get_match_data() helper
Message-ID: <20171007122058.64daf7e6@archlinux>
In-Reply-To: <20171005091258.GK26369@verge.net.au>
References: <1507118906-8946-1-git-send-email-geert+renesas@glider.be>
        <1507118906-8946-4-git-send-email-geert+renesas@glider.be>
        <20171005091258.GK26369@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, 5 Oct 2017 11:12:59 +0200
Simon Horman <horms@verge.net.au> wrote:

> On Wed, Oct 04, 2017 at 02:08:26PM +0200, Geert Uytterhoeven wrote:
> > Use the of_device_get_match_data() helper instead of open coding.
> > Note that the rcar-gyroadc driver is used with DT only, so there's
> > always a valid match.
> > 
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>  
> 
> Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
> 

Applied to the togreg branch of iio.git and pushed out
as testing for the autobuilders to play with it.

Thanks,

Jonathan
