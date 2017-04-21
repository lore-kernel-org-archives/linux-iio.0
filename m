Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:38613 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1161688AbdDUOXS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 21 Apr 2017 10:23:18 -0400
Message-ID: <1492784582.2364.10.camel@pengutronix.de>
Subject: Re: [PATCH v13 03/10] mux: minimal mux subsystem and gpio-based mux
 controller
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Peter Rosin <peda@axentia.se>
Cc: linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
Date: Fri, 21 Apr 2017 16:23:02 +0200
In-Reply-To: <1492101794-13444-4-git-send-email-peda@axentia.se>
References: <1492101794-13444-1-git-send-email-peda@axentia.se>
         <1492101794-13444-4-git-send-email-peda@axentia.se>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, 2017-04-13 at 18:43 +0200, Peter Rosin wrote:
[...]
> +int mux_chip_register(struct mux_chip *mux_chip)
> +{
> +	int i;
> +	int ret;
> +
> +	for (i = 0; i < mux_chip->controllers; ++i) {
> +		struct mux_control *mux = &mux_chip->mux[i];
> +
> +		if (mux->idle_state == mux->cached_state)
> +			continue;

I think this should be changed to
 
-               if (mux->idle_state == mux->cached_state)
+               if (mux->idle_state == mux->cached_state ||
+                   mux->idle_state == MUX_IDLE_AS_IS)
                        continue;

or the following mux_control_set will be called with state ==
MUX_IDLE_AS_IS. Alternatively, mux_control_set should return when passed
this value.

> +		ret = mux_control_set(mux, mux->idle_state);
> +		if (ret < 0) {
> +			dev_err(&mux_chip->dev, "unable to set idle state\n");
> +			return ret;
> +		}
> +	}
> +
> +	ret = device_add(&mux_chip->dev);
> +	if (ret < 0)
> +		dev_err(&mux_chip->dev,
> +			"device_add failed in mux_chip_register: %d\n", ret);
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(mux_chip_register);

regards
Philipp

