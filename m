Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:41392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750907AbdJNSXU (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 14 Oct 2017 14:23:20 -0400
Date: Sat, 14 Oct 2017 19:23:16 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: iio: health: Fix max30100 I2C chip
 address in example
Message-ID: <20171014192316.34460c76@archlinux>
In-Reply-To: <20171013215438.fqb3qvevxmwb6i2z@rob-hp-laptop>
References: <1507712948-29300-1-git-send-email-pmeerw@pmeerw.net>
        <20171013215438.fqb3qvevxmwb6i2z@rob-hp-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, 13 Oct 2017 16:54:38 -0500
Rob Herring <robh@kernel.org> wrote:

> On Wed, Oct 11, 2017 at 11:09:07AM +0200, Peter Meerwald-Stadler wrote:
> > Should be in hex, not decimal or even octal
> > 
> > Signed-off-by: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
> > ---
> >  Documentation/devicetree/bindings/iio/health/max30100.txt | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)  
> 
> Acked-by: Rob Herring <robh@kernel.org>
Applied to the togreg branch of iio.git and pushed out as testing.

Thanks,

Jonathan

> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

