Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtpo.poczta.interia.pl ([217.74.65.158]:55883 "EHLO
        smtpo.poczta.interia.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726546AbeJYPPB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 25 Oct 2018 11:15:01 -0400
Date: Thu, 25 Oct 2018 08:43:56 +0200
From: Slawomir Stepien <sst@poczta.fm>
To: Nishad Kamdar <nishadkamdar@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] staging: iio: ad2s1210: Switch to the gpio descriptor
 interface
Message-ID: <20181025064356.GA18633@x220.localdomain>
References: <20181024145051.GA18490@nishad>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20181024145051.GA18490@nishad>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On paź 24, 2018 20:20, Nishad Kamdar wrote:
> Use the gpiod interface instead of the deprecated old non-descriptor
> interface.
> 
> Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
> ---
> Changes in v4:
>  - Add spaces after { and before } in gpios[]
>    initialization.
>  - Check the correct pointer for error.
>  - Align the dev_err msg to existing format in the code.
> Changes in v3:
>  - Use a pointer to pointer for gpio_desc in
>    struct ad2s1210_gpio as it will be used to
>    modify a pointer.
>  - Use dot notation to initialize the structure.
>  - Use a pointer variable to avoid writing gpios[i].
> Changes in v2:
>  - Use the spi_device struct embedded in st instead
>    of passing it as an argument to ad2s1210_setup_gpios().
>  - Use an array of structs to reduce redundant code in
>    in ad2s1210_setup_gpios().
>  - Remove ad2s1210_free_gpios() as devm API is being used.
> ---
>  drivers/staging/iio/resolver/ad2s1210.c | 92 ++++++++++++++-----------
>  drivers/staging/iio/resolver/ad2s1210.h |  3 -
>  2 files changed, 50 insertions(+), 45 deletions(-)

Looks good to me.

Reviewed-by: Slawomir Stepien <sst@poczta.fm>

-- 
Slawomir Stepien
