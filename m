Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:33622 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751420AbdJEJMK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 5 Oct 2017 05:12:10 -0400
Date: Thu, 5 Oct 2017 11:11:51 +0200
From: Simon Horman <horms@verge.net.au>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Jonathan Cameron <jic23@kernel.org>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH 1/3] iio: adc: rcar-gyroadc: Cast pointer to uintptr_t to
 fix warning on 64-bit
Message-ID: <20171005091150.GI26369@verge.net.au>
References: <1507118906-8946-1-git-send-email-geert+renesas@glider.be>
 <1507118906-8946-2-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1507118906-8946-2-git-send-email-geert+renesas@glider.be>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, Oct 04, 2017 at 02:08:24PM +0200, Geert Uytterhoeven wrote:
> On 64-bit:
> 
>     drivers/iio/adc/rcar-gyroadc.c: In function 'rcar_gyroadc_parse_subdevs':
>     drivers/iio/adc/rcar-gyroadc.c:352:15: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
>        childmode = (unsigned int)of_id->data;
> 		   ^
> 
> Cast the pointer to uintptr_t instead of unsigned int to fix this.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
