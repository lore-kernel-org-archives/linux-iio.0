Return-Path: <SRS0=kDFh=RT=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F199EC43381
	for <linux-iio@archiver.kernel.org>; Sat, 16 Mar 2019 15:51:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC26721900
	for <linux-iio@archiver.kernel.org>; Sat, 16 Mar 2019 15:51:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552751495;
	bh=U/7GB3yO9nwOwezA2Ypi8xHH1JhtqFwT5fxZexfGrkE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=aGnpeInj70xkP7zTxCQ9ZQ4mF2iVdH2wcjr4jEY1dQq8jKxgnYaF4tHEqk8zIv3sZ
	 XjuknO7czn15De6eudhYendy66+FBpWP38vtsPfD0AxUZM2OxDZDz2lIPKzxM+RKdh
	 7oeAQRZ4HIAsUmTtvHoSIOTsuXR4ilqfgVnLIqr0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726376AbfCPPvf (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 16 Mar 2019 11:51:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:58562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726105AbfCPPvf (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 16 Mar 2019 11:51:35 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2F6F6218E0;
        Sat, 16 Mar 2019 15:51:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552751494;
        bh=U/7GB3yO9nwOwezA2Ypi8xHH1JhtqFwT5fxZexfGrkE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Rc86m/K9ZH2df2aMzzt+dkgX7BDH9/ICZ0W8Sm5uwLoROfLBCTljqzeSU1yrVJIny
         kMTj7dOM3Wrt+Tzn6xky3iidCT04LVGSdKTvZeEiUMrjQ1/VrBahD5Y1OeU5Xg/96R
         eQ/2XAblBXvS/EA8gx255/IQHf2EhYkxkq92ISvA=
Date:   Sat, 16 Mar 2019 15:51:28 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Sven Van Asbroeck <thesven73@gmail.com>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Michal Simek <michal.simek@xilinx.com>,
        Manish Narani <manish.narani@xilinx.com>,
        linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] iio: adc: xilinx: prevent touching unclocked h/w on
 remove
Message-ID: <20190316155128.16ef1da1@archlinux>
In-Reply-To: <20190310185826.25916-3-TheSven73@gmail.com>
References: <20190310185826.25916-1-TheSven73@gmail.com>
        <20190310185826.25916-3-TheSven73@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 10 Mar 2019 14:58:26 -0400
Sven Van Asbroeck <thesven73@gmail.com> wrote:

> In remove, the clock is disabled before canceling the
> delayed work. This means that the delayed work may be
> touching unclocked hardware.
> 
> Fix by disabling the clock after the delayed work is
> fully canceled. This is consistent with the probe error
> path order.
> 
> Signed-off-by: Sven Van Asbroeck <TheSven73@gmail.com>
Applied to the fixes-togreg branch of iio.git.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/xilinx-xadc-core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
> index 15e1a103f37d..1ae86e7359f7 100644
> --- a/drivers/iio/adc/xilinx-xadc-core.c
> +++ b/drivers/iio/adc/xilinx-xadc-core.c
> @@ -1320,8 +1320,8 @@ static int xadc_remove(struct platform_device *pdev)
>  		iio_triggered_buffer_cleanup(indio_dev);
>  	}
>  	free_irq(xadc->irq, indio_dev);
> -	clk_disable_unprepare(xadc->clk);
>  	cancel_delayed_work_sync(&xadc->zynq_unmask_work);
> +	clk_disable_unprepare(xadc->clk);
>  	kfree(xadc->data);
>  	kfree(indio_dev->channels);
>  

