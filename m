Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from onstation.org ([52.200.56.107]:55952 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756176AbdD1QRS (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 28 Apr 2017 12:17:18 -0400
Date: Fri, 28 Apr 2017 12:17:16 -0400
From: Brian Masney <masneyb@onstation.org>
To: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Cc: Sebastian Reichel <sre@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: iio: isl29028: add isl29030 support
Message-ID: <20170428161716.GA3075@607924cbbc93>
References: <20170428155558.17723-1-sebastian.reichel@collabora.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170428155558.17723-1-sebastian.reichel@collabora.co.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, Apr 28, 2017 at 05:55:58PM +0200, Sebastian Reichel wrote:
> isl29030 is basically the same chip. The only difference
> is the chip's first pin. For isl29028 its named ADDR0 and
> can be used to change the chip's i2c address. For isl29030
> on the other hand that pin is named Ials and is an analog
> current output proportional to ALS/IR. This change is
> irrelevant for the Linux driver.
> 
> This has been tested on Motorola Droid 4.
> 
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
> ---
>  Documentation/devicetree/bindings/i2c/trivial-devices.txt | 1 +
>  drivers/staging/iio/light/isl29028.c                      | 6 ++++++
>  2 files changed, 7 insertions(+)

Hi Sebastian,

I moved this driver out of the staging directory earlier this week.
You'll need to base your patch off of IIO testing:

https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/log/?h=testing

Your patch should apply cleanly once you update the file path.

Brian
