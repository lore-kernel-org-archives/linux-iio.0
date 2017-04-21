Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ve1eur01on0139.outbound.protection.outlook.com ([104.47.1.139]:54580
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1161812AbdDUQkF (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 21 Apr 2017 12:40:05 -0400
Subject: Re: [PATCH v13 03/10] mux: minimal mux subsystem and gpio-based mux
 controller
To: Philipp Zabel <p.zabel@pengutronix.de>
References: <1492101794-13444-1-git-send-email-peda@axentia.se>
 <1492101794-13444-4-git-send-email-peda@axentia.se>
 <1492784318.2364.8.camel@pengutronix.de>
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
Message-ID: <23158179-3667-c4d7-c8ac-b7a011d77749@axentia.se>
Date: Fri, 21 Apr 2017 17:08:17 +0200
MIME-Version: 1.0
In-Reply-To: <1492784318.2364.8.camel@pengutronix.de>
Content-Type: text/plain; charset="utf-8"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 2017-04-21 16:18, Philipp Zabel wrote:
> Hi Peter,
> 
> On Thu, 2017-04-13 at 18:43 +0200, Peter Rosin wrote:
> [...]
>> +int mux_control_select(struct mux_control *mux, int state)
> 
> state could be unsigned int for the consumer facing API.
> 
>> +{
>> +	int ret;
> 
> And mux_control_select should check that (0 <= state < mux->states).

Yes, that makes sense. I worried that we might end up with
signed/unsigned comparisons since the internal state still needs
to be signed, but that didn't happen when I tried...

I'll include this change in v14.

Cheers,
peda
