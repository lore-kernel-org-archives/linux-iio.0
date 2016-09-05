Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-oi0-f51.google.com ([209.85.218.51]:33737 "EHLO
        mail-oi0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932568AbcIEJzf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 5 Sep 2016 05:55:35 -0400
Received: by mail-oi0-f51.google.com with SMTP id y2so21059096oie.0
        for <linux-iio@vger.kernel.org>; Mon, 05 Sep 2016 02:55:35 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20160905091449.12297-2-cmo@melexis.com>
References: <20160905091449.12297-1-cmo@melexis.com> <20160905091449.12297-2-cmo@melexis.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 5 Sep 2016 11:55:33 +0200
Message-ID: <CACRpkdZ1KJRqbSjx0TeOsnq8HvYkafHG9R=VOiPn0mPec=3b2w@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] iio: devm_regulator_get_optional never returns NULL
To: Crt Mori <cmo@melexis.com>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Daniel Baluta <daniel.baluta@intel.com>,
        Gregor Boirie <gregor.boirie@parrot.com>,
        Matt Ranostay <mranostay@gmail.com>,
        Sean Nyekjaer <sean.nyekjaer@prevas.dk>,
        Markus Pargmann <mpa@pengutronix.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, Sep 5, 2016 at 11:14 AM, Crt Mori <cmo@melexis.com> wrote:

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

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
