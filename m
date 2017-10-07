Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:37242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750948AbdJGLRj (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 7 Oct 2017 07:17:39 -0400
Date: Sat, 7 Oct 2017 12:17:34 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Simon Horman <horms@verge.net.au>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH 1/3] iio: adc: rcar-gyroadc: Cast pointer to uintptr_t
 to fix warning on 64-bit
Message-ID: <20171007121734.0328cf9d@archlinux>
In-Reply-To: <20171005091150.GI26369@verge.net.au>
References: <1507118906-8946-1-git-send-email-geert+renesas@glider.be>
        <1507118906-8946-2-git-send-email-geert+renesas@glider.be>
        <20171005091150.GI26369@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, 5 Oct 2017 11:11:51 +0200
Simon Horman <horms@verge.net.au> wrote:

> On Wed, Oct 04, 2017 at 02:08:24PM +0200, Geert Uytterhoeven wrote:
> > On 64-bit:
> > 
> >     drivers/iio/adc/rcar-gyroadc.c: In function 'rcar_gyroadc_parse_subdevs':
> >     drivers/iio/adc/rcar-gyroadc.c:352:15: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
> >        childmode = (unsigned int)of_id->data;
> > 		   ^
> > 
> > Cast the pointer to uintptr_t instead of unsigned int to fix this.
> > 
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>  
> 
> Reviewed-by: Simon Horman <horms+renesas@verge.net.au>

Applied to the togreg branch of iio.git and pushed out as testing for the
autobuilders to play with it.

Thanks,

Jonathan

> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

