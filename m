Return-Path: <linux-iio-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4780CC38147
	for <linux-iio@archiver.kernel.org>; Wed, 18 Jan 2023 15:24:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231255AbjARPYG (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Wed, 18 Jan 2023 10:24:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231248AbjARPXu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 18 Jan 2023 10:23:50 -0500
Received: from relay06.th.seeweb.it (relay06.th.seeweb.it [5.144.164.167])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D601F1BAD0
        for <linux-iio@vger.kernel.org>; Wed, 18 Jan 2023 07:21:25 -0800 (PST)
Received: from SoMainline.org (94-211-6-86.cable.dynamic.v4.ziggo.nl [94.211.6.86])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id BE9203F829;
        Wed, 18 Jan 2023 16:21:22 +0100 (CET)
Date:   Wed, 18 Jan 2023 16:21:21 +0100
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>,
        linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v2 1/1] iio: adc: qcom-spmi-adc5: Fix the channel name
Message-ID: <20230118152121.blb74eplrqz5rww2@SoMainline.org>
References: <20230118100623.42255-1-andriy.shevchenko@linux.intel.com>
 <20230118123528.oaxtjbdier3ojd3m@SoMainline.org>
 <Y8fyonSp49QoAb8v@smile.fi.intel.com>
 <20230118140423.y4ogqdkyti7vcwaz@SoMainline.org>
 <Y8gCRECOja+FxRsf@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8gCRECOja+FxRsf@smile.fi.intel.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 2023-01-18 16:29:24, Andy Shevchenko wrote:
...
> The devm_kstrdup(fwnode_get_name()) is an open coded variant of the above.
> I don't think we need to open code and produce NIH even a single API. And
> no, there is no magic behind that. At least from the fwnode point of view.
> 
> You may very well say that > 1500 instances of "%pOF" is a magic...

Forgive me for not having a clear definition of "open coding" in mind
(showing a different way of implementing something, compared to the
"status quo" that I was not yet aware of?), nor knowing what NIH is
supposed to mean in this context.  We're in bike-shedding territory
anyway, guess I should just bookmark the page that details all the many
`%` format strings available.

...
> > I find the latter clearer as it doesn't require the reader to figure out
> > that name - name cancels itself out.  Alternatively we can write
> > strchrnul(name, '@')[0].
> 
> I don't like to have Pythonisms in the C code, really.
> 
> P.S. I guess this little patch already emptied my bandwidth, so I leave
> any further discussion to you and IIO maintainers. Thank you for the
> review!

Just soaking up kernel coding standards here :)

- Marijn
