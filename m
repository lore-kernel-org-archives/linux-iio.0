Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from www381.your-server.de ([78.46.137.84]:37783 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933383AbcIEKdg (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 5 Sep 2016 06:33:36 -0400
Subject: Re: [PATCH v2 2/2] iio: devm_regulator_get_optional never returns
 NULL
To: Crt Mori <cmo@melexis.com>, linux-iio@vger.kernel.org,
        Jonathan Cameron <jic23@kernel.org>
References: <20160905091449.12297-1-cmo@melexis.com>
 <20160905091449.12297-2-cmo@melexis.com>
Cc: Daniel Baluta <daniel.baluta@intel.com>,
        Gregor Boirie <gregor.boirie@parrot.com>,
        Matt Ranostay <mranostay@gmail.com>,
        Sean Nyekjaer <sean.nyekjaer@prevas.dk>,
        Markus Pargmann <mpa@pengutronix.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Linus Walleij <linus.walleij@linaro.org>
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <e7fbc8a9-3a97-5712-f7f3-6346137282eb@metafoo.de>
Date: Mon, 5 Sep 2016 12:33:31 +0200
MIME-Version: 1.0
In-Reply-To: <20160905091449.12297-2-cmo@melexis.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/05/2016 11:14 AM, Crt Mori wrote:
> This patch is inspired by a comment of Jonathan Cameron on patch of
> Linus Walleij commit aeb55fff3891834e07a3144159a7298a19696af8 ("iio:
> st_sensors: fetch and enable regulators unconditionally"). Because
> changes made in this patch are actually reference generators they should
> be using devm_regulator_get_optional, but if they do not explicitly set
> the reference to NULL they should not be using IS_ERR_OR_NULL, but
> simple IS_ERR check.
> 
> Suggested-by: Lars-Peter Clausen <lars@metafoo.de>
> Signed-off-by: Crt Mori <cmo@melexis.com>

Looks good, thanks.

Acked-by: Lars-Peter Clausen <lars@metafoo.de>


