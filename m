Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from www381.your-server.de ([78.46.137.84]:40115 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751691AbcIBNkO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 2 Sep 2016 09:40:14 -0400
Subject: Re: [PATCH] iio: fetch and enable regulators unconditionally
To: Crt Mori <cmo@melexis.com>, linux-iio@vger.kernel.org,
        Jonathan Cameron <jic23@kernel.org>
References: <20160902132717.5839-1-cmo@melexis.com>
Cc: Daniel Baluta <daniel.baluta@intel.com>,
        Gregor Boirie <gregor.boirie@parrot.com>,
        Matt Ranostay <mranostay@gmail.com>,
        Sean Nyekjaer <sean.nyekjaer@prevas.dk>,
        Markus Pargmann <mpa@pengutronix.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Linus Walleij <linus.walleij@linaro.org>
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <e069a51d-bf8d-ae70-6061-d3118491cd1d@metafoo.de>
Date: Fri, 2 Sep 2016 15:40:09 +0200
MIME-Version: 1.0
In-Reply-To: <20160902132717.5839-1-cmo@melexis.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi,

Thanks for the patch.

On 09/02/2016 03:27 PM, Crt Mori wrote:
> This patch is inspired by a comment of Jonathan Cameron on patch of
> Linus Walleij commit aeb55fff3891834e07a3144159a7298a19696af8 ("iio: st_sensors: fetch and enable regulators unconditionally").
> 
> The explanation for this change is same as in that patch:
> "Supplies are *not* optional (optional means that the supply is
> optional in the electrical sense, not the software sense) so we need to
> get the and enable them at all times.

Some supplies are optional. I.e. the part is able to operate (potentially
with limited functionality) even if the optional external supply has not
been connected to the pin.

E.g. many converters have a built-in voltage reference but are able to
optionally accept an external reference. The driver needs to know if the
external reference is not connected or not to be able to allow or disallow
applications to switch the part into external reference mode. This is the
case for the ad7266 and ad5761 drivers and using regulator_get_optional() is
correct here.

Same seems to be true for the ads8688 and the fsl-imx-gcq, judging by how
their code is structured.

- Lars
