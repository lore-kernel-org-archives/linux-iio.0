Return-Path: <SRS0=NPK8=R3=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E36BC43381
	for <linux-iio@archiver.kernel.org>; Sun, 24 Mar 2019 16:05:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDB2D20883
	for <linux-iio@archiver.kernel.org>; Sun, 24 Mar 2019 16:05:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553443502;
	bh=zeyRyyK0ErIOpnwuU9roWBgE75uFDWuUyF1JmmSBClY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=u/HK8Qedw38FB1UHU4jmk2OkZGrfCObrGSf893MIGp1FSDrGrtEzBB84e1fonf1he
	 nJXBy1I+8epE6fp01jskKw30U14qdgHv0N21OOoynUNBcQHKmGmaagS1msgZHAMi1y
	 9n33QPurAMnQYmk2xn3DL3/eKoNPYtN93Bh8/7bs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726889AbfCXQFB (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 24 Mar 2019 12:05:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:39144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726743AbfCXQFB (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 24 Mar 2019 12:05:01 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 921D22087E;
        Sun, 24 Mar 2019 16:04:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553443500;
        bh=zeyRyyK0ErIOpnwuU9roWBgE75uFDWuUyF1JmmSBClY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fDvCCuvwKtOgoJCYiUet/DLgD4g/h6CYd90Nge32IwLsTVZf0TaevvBHFwzJiarC4
         o6cnFxgqsXXOq5I/udzsY9wEpsn3qpjdx8UqHFrHu6Rm0Lm3Dyt/lgu7XB4DZohBE3
         WAvJzLm4c7NJbTCQz9mCR3cm+4tfmTs5n7FzlVx4=
Date:   Sun, 24 Mar 2019 16:04:55 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Vladimir Petrigo <vladimir.petrigo@gmail.com>
Cc:     linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org
Subject: Re: [PATCH v2 1/2] staging: iio: ad7280a: Add parentheses to macros
Message-ID: <20190324160455.1cc494e9@archlinux>
In-Reply-To: <1553202928-34824-2-git-send-email-vladimir.petrigo@gmail.com>
References: <1553202928-34824-1-git-send-email-vladimir.petrigo@gmail.com>
        <1553202928-34824-2-git-send-email-vladimir.petrigo@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 22 Mar 2019 00:15:27 +0300
Vladimir Petrigo <vladimir.petrigo@gmail.com> wrote:

> - Fix CHECK Macro argument 'c' may be better as '(c)' to avoid precedence issues
> - Fix CHECK Macro argument 'd' may be better as '(d)' to avoid precedence issues
> 
> Signed-off-by: Vladimir Petrigo <vladimir.petrigo@gmail.com>
Sorry, I ended up taking Cristian's patch for the same issue.

No particular reason other than which email I hit first!

Jonathan

> ---
>  drivers/staging/iio/adc/ad7280a.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/ad7280a.c b/drivers/staging/iio/adc/ad7280a.c
> index d9df126..98cf876 100644
> --- a/drivers/staging/iio/adc/ad7280a.c
> +++ b/drivers/staging/iio/adc/ad7280a.c
> @@ -97,9 +97,9 @@
>  #define AD7280A_NUM_CH			(AD7280A_AUX_ADC_6 - \
>  					AD7280A_CELL_VOLTAGE_1 + 1)
>  
> -#define AD7280A_CALC_VOLTAGE_CHAN_NUM(d, c) ((d * AD7280A_CELLS_PER_DEV) + c)
> -#define AD7280A_CALC_TEMP_CHAN_NUM(d, c)    ((d * AD7280A_CELLS_PER_DEV) + \
> -					     c - AD7280A_CELLS_PER_DEV)
> +#define AD7280A_CALC_VOLTAGE_CHAN_NUM(d, c) (((d) * AD7280A_CELLS_PER_DEV) + (c))
> +#define AD7280A_CALC_TEMP_CHAN_NUM(d, c)    (((d) * AD7280A_CELLS_PER_DEV) + \
> +					     (c) - AD7280A_CELLS_PER_DEV)
>  
>  #define AD7280A_DEVADDR_MASTER		0
>  #define AD7280A_DEVADDR_ALL		0x1F

