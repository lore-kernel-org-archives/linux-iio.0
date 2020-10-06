Return-Path: <SRS0=IObS=DN=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34C7EC41604
	for <linux-iio@archiver.kernel.org>; Tue,  6 Oct 2020 19:39:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA76C206CB
	for <linux-iio@archiver.kernel.org>; Tue,  6 Oct 2020 19:39:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="GNNB43lZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726323AbgJFTjN (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Tue, 6 Oct 2020 15:39:13 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:2576 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725943AbgJFTjN (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 6 Oct 2020 15:39:13 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 4C5ST95m3Xz6D;
        Tue,  6 Oct 2020 21:39:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1602013150; bh=WfMGi2j/s4NLE/IArNdm11UxaiMauv154f6EGk5HmZk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GNNB43lZG1uXGM0+tJdkf3jI/5O6e/BHOjPuZnOaOaVvohLXvcZTlUWITgtUE1Q/2
         mv3Zb9dlzq8vsQy8P5zrDZ6TV+UAxGN1X2wtBpto+uyvKV5PQaBlLhGfiM3qF/pzbQ
         zr+3Cn8gvqU1cucym4c7jAe6S2AbJ15b6Gbqqs/uFVEDNhxWtI9hJrARwsVk4Cz4ea
         AbTteE9cssxRW7sXa2OMO3MN4kYzPhsA8WkZLG8LWpBd8VW0p0SU56MPILHnwbtk+U
         hD96DTRWcFGrgIfEECojMWWHiT7pEktVTp9EbMUffjX6cSlhskT2Ma1UAY4Sk2p4YB
         9+uduqFyCaA3Q==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.4 at mail
Date:   Tue, 6 Oct 2020 21:39:07 +0200
From:   =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
To:     dmitry.torokhov@gmail.com
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        linux-iio@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: adc: exynos: do not rely on 'users' counter in
 ISR
Message-ID: <20201006193907.GA30199@qmqm.qmqm.pl>
References: <20201006041214.GA4145870@dtor-ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201006041214.GA4145870@dtor-ws>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Oct 05, 2020 at 09:12:14PM -0700, dmitry.torokhov@gmail.com wrote:
> The order in which 'users' counter is decremented vs calling drivers'
> close() method is implementation specific, and we should not rely on
> it. Let's introduce driver private flag and use it to signal ISR
> to exit when device is being closed.
> 
> This has a side-effect of fixing issue of accessing inut->users
> outside of input->mutex protection.
[...]

Reviewed-by: Micha³ Miros³aw <mirq-linux@rere.qmqm.pl>
(after with a fix mentioned below)

> --- a/drivers/iio/adc/exynos_adc.c
> +++ b/drivers/iio/adc/exynos_adc.c
[...]
> @@ -712,6 +715,7 @@ static int exynos_adc_ts_open(struct input_dev *dev)
>  {
>  	struct exynos_adc *info = input_get_drvdata(dev);
>  
> +	WRITE_ONCE(info->ts_enabled, true);
>  	enable_irq(info->tsirq);
>  
>  	return 0;
> @@ -721,6 +725,7 @@ static void exynos_adc_ts_close(struct input_dev *dev)
>  {
>  	struct exynos_adc *info = input_get_drvdata(dev);
>  
> +	WRITE_ONCE(info->ts_enabled, true);
>  	disable_irq(info->tsirq);

Shouldn't 'true' be 'false' here?

Best Regards,
Micha³ Miros³aw
