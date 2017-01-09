Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-qt0-f178.google.com ([209.85.216.178]:35509 "EHLO
        mail-qt0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965030AbdAIKtL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 9 Jan 2017 05:49:11 -0500
Received: by mail-qt0-f178.google.com with SMTP id x49so65923952qtc.2
        for <linux-iio@vger.kernel.org>; Mon, 09 Jan 2017 02:49:11 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170105120027.4nftlpegln2se7bq@sirena.org.uk>
References: <1480432969-20913-1-git-send-email-bgolaszewski@baylibre.com>
 <44cce3d5-f65e-1a35-20a4-5eb9fda42312@metafoo.de> <CAMpxmJWDWk-mXUHHGEKm-VVwzqEGLDQjc274Xq+Qwc2eN=YbsQ@mail.gmail.com>
 <d4c7f1ca-49d4-7abe-bfc9-e1728f62a9fb@metafoo.de> <bf3dde7e-cee8-c54c-db93-447ffa063116@kernel.org>
 <CAMpxmJVJ+y9tRbRBsVg+i0EJO_6EFuvrypwC=ETnBWbMnxRFyg@mail.gmail.com>
 <c670d597-46b6-235f-545f-7136a3abff7f@metafoo.de> <CAMuHMdX3u4cb2Yq2+VV_eDUaw2EqiOjN2TorW+F5-39Mm=mXmQ@mail.gmail.com>
 <9609b56b-194c-9899-1142-ff2ee285c6bd@metafoo.de> <CAMuHMdXnzDUYcr8qiUTwE2peBdjwuVWPRUkms2J8AHFaQ=SHHQ@mail.gmail.com>
 <20170105120027.4nftlpegln2se7bq@sirena.org.uk>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 9 Jan 2017 11:49:10 +0100
Message-ID: <CACRpkdZC5v7mBxVPszr0kX=J+ZKbT+5wBtcW_rbF+G_SaF0+qw@mail.gmail.com>
Subject: Re: [PATCH] iio: misc: add a generic regulator driver
To: Mark Brown <broonie@kernel.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        linux-devicetree <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Patrick Titiano <ptitiano@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Liam Girdwood <lgirdwood@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, Jan 5, 2017 at 1:00 PM, Mark Brown <broonie@kernel.org> wrote:

> The system itself is controlling
> a power line, it knows nothing about what's connected.  It seems like
> this is coming up often enough that someone should probably just write
> an external system control binding, also tying in things like references
> to the console and so on.

That sounds pretty helpful for these usecases.

Yours,
Linus Walleij
