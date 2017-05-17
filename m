Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:44951 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754529AbdEQJjI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 17 May 2017 05:39:08 -0400
Message-ID: <1495013928.3030.44.camel@pengutronix.de>
Subject: Re: [PATCH v15 04/13] mux: gpio: add mux controller driver for gpio
 based multiplexers
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Peter Rosin <peda@lysator.liu.se>
Cc: linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Rosin <peda@axentia.se>,
        Wolfram Sang <wsa@the-dreams.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-doc@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Colin Ian King <colin.king@canonical.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        kernel@pengutronix.de
Date: Wed, 17 May 2017 11:38:48 +0200
In-Reply-To: <1494791476-14599-5-git-send-email-peda@lysator.liu.se>
References: <1494791476-14599-1-git-send-email-peda@lysator.liu.se>
         <1494791476-14599-5-git-send-email-peda@lysator.liu.se>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, 2017-05-14 at 21:51 +0200, Peter Rosin wrote:
> From: Peter Rosin <peda@axentia.se>
> 
> The driver builds a single multiplexer controller using a number
> of gpio pins. For N pins, there will be 2^N possible multiplexer
> states. The GPIO pins can be connected (by the hardware) to several
> multiplexers, which in that case will be operated in parallel.
> 
> Reviewed-by: Jonathan Cameron <jic23@kernel.org>
> Signed-off-by: Peter Rosin <peda@axentia.se>

Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>

regards
Philipp

