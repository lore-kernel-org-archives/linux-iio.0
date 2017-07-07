Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-eopbgr00132.outbound.protection.outlook.com ([40.107.0.132]:59213
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750839AbdGGE5e (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 7 Jul 2017 00:57:34 -0400
Subject: Re: [PATCH] iio: multiplexer: add NULL check on devm_kzalloc() and
 devm_kmemdup() return values
To: "Gustavo A. R. Silva" <garsilva@embeddedor.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20170707045311.GA4535@embeddedgus>
From: Peter Rosin <peda@axentia.se>
Message-ID: <df6ae9c6-8ac7-368b-a1c2-4403387df02b@axentia.se>
Date: Fri, 7 Jul 2017 06:57:27 +0200
MIME-Version: 1.0
In-Reply-To: <20170707045311.GA4535@embeddedgus>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 2017-07-07 06:53, Gustavo A. R. Silva wrote:
> Check return values from call to devm_kzalloc() and devm_kmemup()

If someone cares enough: s/devm_kmemup/evm_kmemdup/


> in order to prevent a NULL pointer dereference.
> 
> This issue was detected using Coccinelle and the following semantic patch:
> 
> @@
> expression x;
> identifier fld;
> @@
> 
> * x = devm_kzalloc(...);
>    ... when != x == NULL
>    x->fld
> 
> Cc: Peter Rosin <peda@axentia.se>
> Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>

Either way,

Reviewed-by: Peter Rosin <peda@axentia.se>

Thanks!
