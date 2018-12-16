Return-Path: <SRS0=diYI=OZ=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB8AFC43387
	for <linux-iio@archiver.kernel.org>; Sun, 16 Dec 2018 11:54:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B151D21839
	for <linux-iio@archiver.kernel.org>; Sun, 16 Dec 2018 11:54:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544961298;
	bh=BGuudONu53bpAm0Ozx5ScLy3StJFOX6XFpgaRL+lDuA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=kAPesqfvRr1klppnB47ag0V5Ahf5gmZFohgqxLOnJEn1qN7omavcNiZyQqAi9uezi
	 mwonWZXhNPYw08wh77eJ9/U6uyvkDY9MoE/1BM7AWPUk2a2eH29ptQLSx6gSakjaJk
	 1bTE8sqM2RUSDzy033QX9aP458fK8qlCINnmfFTA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730116AbeLPLy6 (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 16 Dec 2018 06:54:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:36418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730066AbeLPLy6 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 16 Dec 2018 06:54:58 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A5A0A217FB;
        Sun, 16 Dec 2018 11:54:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544961297;
        bh=BGuudONu53bpAm0Ozx5ScLy3StJFOX6XFpgaRL+lDuA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=AWEcFCUAd7wn9+8uheZcU//lhfT5fXDfCnsq3l6BaUrMmH9U00YbSpVAv9qfrJnEC
         ZF+wO1UEhov5/1wIWdgi9dpDghpMklNj30BabqFtFm1lbNG1Nov59QywMSIPXukeWC
         bWnsSXcQ20iY0l+LCFJ6oTIRH0QgfYoRBlDQDOag=
Date:   Sun, 16 Dec 2018 11:54:52 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jeremy Fertic <jeremyfertic@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/11] staging: iio: adt7316: allow adt751x to use
 internal vref for all dacs
Message-ID: <20181216115452.199cd703@archlinux>
In-Reply-To: <20181212005503.28054-9-jeremyfertic@gmail.com>
References: <20181212005503.28054-1-jeremyfertic@gmail.com>
        <20181212005503.28054-9-jeremyfertic@gmail.com>
X-Mailer: Claws Mail 3.17.2 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 11 Dec 2018 17:55:00 -0700
Jeremy Fertic <jeremyfertic@gmail.com> wrote:

> With adt7516/7/9, internal vref is available for dacs a and b, dacs c and
> d, or all dacs. The driver doesn't currently support internal vref for all
> dacs. Change the else if to an if so both bits are checked rather than
> just one or the other.
> 
> Signed-off-by: Jeremy Fertic <jeremyfertic@gmail.com>
This one is nice and separated from the earlier patches and 'obviously' right
I think.  Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

It's also fine to backport though given how broken the driver was before
patches that aren't, I'm not going to mark it for stable!

Thanks,

Jonathan

> ---
>  drivers/staging/iio/addac/adt7316.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/iio/addac/adt7316.c b/drivers/staging/iio/addac/adt7316.c
> index 98101a7157d2..3348fdf08f2e 100644
> --- a/drivers/staging/iio/addac/adt7316.c
> +++ b/drivers/staging/iio/addac/adt7316.c
> @@ -1081,7 +1081,7 @@ static ssize_t adt7316_store_DAC_internal_Vref(struct device *dev,
>  		ldac_config = chip->ldac_config & (~ADT7516_DAC_IN_VREF_MASK);
>  		if (data & 0x1)
>  			ldac_config |= ADT7516_DAC_AB_IN_VREF;
> -		else if (data & 0x2)
> +		if (data & 0x2)
>  			ldac_config |= ADT7516_DAC_CD_IN_VREF;
>  	} else {
>  		ret = kstrtou8(buf, 16, &data);

