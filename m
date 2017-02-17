Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from www381.your-server.de ([78.46.137.84]:55211 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934088AbdBQQQo (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 17 Feb 2017 11:16:44 -0500
Subject: Re: [RFC 4/4] iio: trigger: add GPIO trigger
To: Fabrice Gasnier <fabrice.gasnier@st.com>, jic23@kernel.org,
        linux@armlinux.org.uk, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1487347429-31761-1-git-send-email-fabrice.gasnier@st.com>
 <1487347429-31761-5-git-send-email-fabrice.gasnier@st.com>
Cc: linux-iio@vger.kernel.org, mark.rutland@arm.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        knaack.h@gmx.de, pmeerw@pmeerw.net, benjamin.gaignard@linaro.org,
        benjamin.gaignard@st.com, linus.walleij@linaro.org
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <06f74b54-91fa-31c5-f015-52a6524059ef@metafoo.de>
Date: Fri, 17 Feb 2017 17:16:26 +0100
MIME-Version: 1.0
In-Reply-To: <1487347429-31761-5-git-send-email-fabrice.gasnier@st.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 02/17/2017 05:03 PM, Fabrice Gasnier wrote:
> GPIOs can be used to generate triggers for any IIO device.
> Introduce generic GPIO trigger driver. It offers some options
> to tune polarity (e.g. rising/falling edge), and label so trigger
> name may be customized.
> By default, gpio triggers will be named gpiotrigX, where X is gpio
> number as returned by desc_to_gpio() call.
> Rising edge is selected if polarity isn't set.

If you want to use the GPIO only as an interrupt, just use it as an
interrupt directly, no need to go the route via the GPIO.
