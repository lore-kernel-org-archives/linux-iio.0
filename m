Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1104DC4338F
	for <linux-iio@archiver.kernel.org>; Sun,  8 Aug 2021 15:01:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7BA56054E
	for <linux-iio@archiver.kernel.org>; Sun,  8 Aug 2021 15:01:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232036AbhHHPCK (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 8 Aug 2021 11:02:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:46594 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231414AbhHHPCJ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 8 Aug 2021 11:02:09 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4D31160F35;
        Sun,  8 Aug 2021 15:01:48 +0000 (UTC)
Date:   Sun, 8 Aug 2021 16:04:37 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Puranjay Mohan <puranjay12@gmail.com>
Cc:     Michael.Hennerich@analog.com, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        lars@metafoo.de, Dragos.Bogdan@analog.com, Darius.Berghe@analog.com
Subject: Re: [PATCH v8 2/3] iio: accel: Add driver support for ADXL355
Message-ID: <20210808160437.4cf3a280@jic23-huawei>
In-Reply-To: <20210804140309.31468-3-puranjay12@gmail.com>
References: <20210804140309.31468-1-puranjay12@gmail.com>
        <20210804140309.31468-3-puranjay12@gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed,  4 Aug 2021 19:33:08 +0530
Puranjay Mohan <puranjay12@gmail.com> wrote:

> ADXL355 is 3-axis MEMS Accelerometer. It offers low noise density,
> low 0g offset drift, low power with selectable measurement ranges.
> It also features programmable high-pass and low-pass filters.
> 
> Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/adxl354_adxl355.pdf
> Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
Hi Puranjay,

One comment below, but it's a follow up on a discussion going on in the ADXL313 driver
review. I might just make that change whilst applying this, or leave it for
another day. Either way, no need for you to change anything unless you are
doing a v9 for another reason.

...

> +
> +/*
> + * The datasheet defines an intercept of 1885 LSB at 25 degC
> + * and a slope of -9.05 LSB/C. The following formula can be used to find the
> + * temperature:
> + * Temp = ((RAW - 1885)/(-9.05)) + 25 but this doesn't follow the format of
> + * the IIO which is Temp = (RAW + OFFSET) * SCALE. Hence using some rearranging
> + * we get the scale as -110.49723 and offset as -2111.25
> + */
> +#define TEMP_SCALE_VAL -110
> +#define TEMP_SCALE_VAL2 497238
> +#define TEMP_OFFSET_VAL -2111
> +#define TEMP_OFFSET_VAL2 250000
> +
> +/*
> + * At +/- 2g with 20-bit resolution, scale is given in datasheet as
> + * 3.9ug/LSB = 0.0000039 * 9.80665 = 0.00003824593 m/s^2
> + */
> +#define ADXL355_NSCALE	38245

This just came up in another review and wasn't something I've been picking
up on in reviews before now.

These scale defines would be better dropped and the values moved inline
(along with the comments).  It avoids possible unit misunderstandings etc
In short the key thing is, sometimes a number is just a number and
using a define to give it a name is not always helpful, particularly if
it's only used in one place in the code.

