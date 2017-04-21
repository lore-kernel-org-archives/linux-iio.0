Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-he1eur01on0102.outbound.protection.outlook.com ([104.47.0.102]:40386
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1036225AbdDUOcb (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 21 Apr 2017 10:32:31 -0400
Subject: Re: [PATCH v13 03/10] mux: minimal mux subsystem and gpio-based mux
 controller
To: Philipp Zabel <p.zabel@pengutronix.de>
References: <1492101794-13444-1-git-send-email-peda@axentia.se>
 <1492101794-13444-4-git-send-email-peda@axentia.se>
 <1492784582.2364.10.camel@pengutronix.de>
CC: <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jonathan Corbet <corbet@lwn.net>, <linux-i2c@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-doc@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Colin Ian King <colin.king@canonical.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        <kernel@pengutronix.de>
From: Peter Rosin <peda@axentia.se>
Message-ID: <9e3d48c4-0dbc-3e80-c653-b0357abf1d6f@axentia.se>
Date: Fri, 21 Apr 2017 16:32:20 +0200
MIME-Version: 1.0
In-Reply-To: <1492784582.2364.10.camel@pengutronix.de>
Content-Type: text/plain; charset="utf-8"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 2017-04-21 16:23, Philipp Zabel wrote:
> On Thu, 2017-04-13 at 18:43 +0200, Peter Rosin wrote:
> [...]
>> +int mux_chip_register(struct mux_chip *mux_chip)
>> +{
>> +	int i;
>> +	int ret;
>> +
>> +	for (i = 0; i < mux_chip->controllers; ++i) {
>> +		struct mux_control *mux = &mux_chip->mux[i];
>> +
>> +		if (mux->idle_state == mux->cached_state)
>> +			continue;
> 
> I think this should be changed to
>  
> -               if (mux->idle_state == mux->cached_state)
> +               if (mux->idle_state == mux->cached_state ||
> +                   mux->idle_state == MUX_IDLE_AS_IS)
>                         continue;
> 
> or the following mux_control_set will be called with state ==
> MUX_IDLE_AS_IS. Alternatively, mux_control_set should return when passed
> this value.

That cannot happen because ->cached_state is initialized to -1
in mux_chip_alloc, so should always be == MUX_IDLE_AS_IS when
registering. And drivers are not supposed to touch ->cached_state.
I.e., ->cached_state is "owned" by the core.

Cheers,
peda

>> +		ret = mux_control_set(mux, mux->idle_state);
>> +		if (ret < 0) {
>> +			dev_err(&mux_chip->dev, "unable to set idle state\n");
>> +			return ret;
>> +		}
>> +	}
>> +
>> +	ret = device_add(&mux_chip->dev);
>> +	if (ret < 0)
>> +		dev_err(&mux_chip->dev,
>> +			"device_add failed in mux_chip_register: %d\n", ret);
>> +	return ret;
>> +}
>> +EXPORT_SYMBOL_GPL(mux_chip_register);
> 
> regards
> Philipp
> 

