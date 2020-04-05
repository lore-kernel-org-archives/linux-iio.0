Return-Path: <SRS0=q/te=5V=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DB79C2D0F4
	for <linux-iio@archiver.kernel.org>; Sun,  5 Apr 2020 12:17:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6CE820709
	for <linux-iio@archiver.kernel.org>; Sun,  5 Apr 2020 12:17:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586089054;
	bh=FmrjPoKwkFMnRTFo5RutxIqfKLfNyXhh7eoysKvfepc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=sgONlxEY/S35hJBDVev4cTOg8oS2LT5V+oyg83EC6xDDucbtzr61CPJsejhwn6dq+
	 N7dRQ10Nyqic/Q5QoQE2C9BChm0sIacgnjRlAna5O4otJO/CuVeCJY7u0i6zLhTRjq
	 ljqUJSEU3QaJFC2u/FJ8t1Z1GzLxgcbT1r2/Ir0A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbgDEMRe (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 5 Apr 2020 08:17:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:46770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726626AbgDEMRe (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 5 Apr 2020 08:17:34 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 14BB120659;
        Sun,  5 Apr 2020 12:17:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586089054;
        bh=FmrjPoKwkFMnRTFo5RutxIqfKLfNyXhh7eoysKvfepc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=paleTjZKfoFCv1WnfjqCI+SWn1K11PvQuqygpzgHbrwH5SQ5HSkx0i/zxI6/bbumO
         Mlgz5MXcJhzfZblNx+SCMEK/pjZz2UsoMp7V0dJMVxPqhKugXUYlufN3SPF0jT0FqF
         S3EZghJAQLYhibutaLFJ2NaOUP6TBvQ4DyjOx5VA=
Date:   Sun, 5 Apr 2020 13:17:30 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH 5/5] iio: xilinx-xadc: Fix typo
Message-ID: <20200405131730.43b9dbae@archlinux>
In-Reply-To: <20200403132717.24682-5-lars@metafoo.de>
References: <20200403132717.24682-1-lars@metafoo.de>
        <20200403132717.24682-5-lars@metafoo.de>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri,  3 Apr 2020 15:27:17 +0200
Lars-Peter Clausen <lars@metafoo.de> wrote:

> Fix a typo. 'at the a time' -> 'at a time'.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Independent of the rest of the series so I applied this one via the slow route.
Mainly so we can forget about it if the others are going via the fixes route.

Applied to the togreg branch of iio.git and pushed out as testing.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/xilinx-xadc-core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
> index c724b8788007..d7fecab9252e 100644
> --- a/drivers/iio/adc/xilinx-xadc-core.c
> +++ b/drivers/iio/adc/xilinx-xadc-core.c
> @@ -663,7 +663,7 @@ static int xadc_trigger_set_state(struct iio_trigger *trigger, bool state)
>  	mutex_lock(&xadc->mutex);
>  
>  	if (state) {
> -		/* Only one of the two triggers can be active at the a time. */
> +		/* Only one of the two triggers can be active at a time. */
>  		if (xadc->trigger != NULL) {
>  			ret = -EBUSY;
>  			goto err_out;

