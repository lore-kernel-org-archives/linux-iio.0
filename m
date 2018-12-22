Return-Path: <SRS0=QpE6=O7=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DA58C43387
	for <linux-iio@archiver.kernel.org>; Sat, 22 Dec 2018 17:33:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DC4A21A4B
	for <linux-iio@archiver.kernel.org>; Sat, 22 Dec 2018 17:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545499995;
	bh=8/LY6lDJ7IIERYkajvRpa/B8M1vxZgnuxDTNBRHpuOc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=anfTJtrRGWZiv3iInNUDE3dmnfrwtQj/qWEoC8xYICbDBQYF+S8Ju5/1PA08tIK1T
	 EqwDiBQRpycDDVYX6E3td+6RBpSU+Lk9B9ZQ514oU4cDbyoZ2kC87wR4123PmEPZ6+
	 4o0VAY+SZeorXoB47nNqhkTOyRHfSwkwdeDrlMNQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392540AbeLVRdJ (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 22 Dec 2018 12:33:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:57178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391420AbeLVRdI (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 22 Dec 2018 12:33:08 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D927421A47;
        Sat, 22 Dec 2018 17:33:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545499987;
        bh=8/LY6lDJ7IIERYkajvRpa/B8M1vxZgnuxDTNBRHpuOc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=o7FsBtDJdsdj/Lgow1UXR9D4mo+eZfFOcGptifMhDvSwMrAww/vlw1idxsUFpNftn
         pl2PdlaBoDplvo7ywVo6AAoULSJeEzHXtUhVGpo4nhJtzdmRBlAzy+eI4Y7MxrdIkH
         QY73hckwJuwGOCBhA7QyoqY5ufcbfnksXvUJM898=
Date:   Sat, 22 Dec 2018 17:33:02 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Amir Mahdi Ghorbanian <indigoomega021@gmail.com>
Cc:     lars@metafoo.de, Michael.Hennerich@analog.com, knaack.h@gmx.de,
        pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] Staging: iio: adis16203: fixed a SPDX identifier
 tag mistake
Message-ID: <20181222173302.1204162e@archlinux>
In-Reply-To: <1545349613-4607-1-git-send-email-indigoomega021@gmail.com>
References: <1545349613-4607-1-git-send-email-indigoomega021@gmail.com>
X-Mailer: Claws Mail 3.17.2 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 20 Dec 2018 15:46:53 -0800
Amir Mahdi Ghorbanian <indigoomega021@gmail.com> wrote:

> Fixed a coding style mistake by adding the SPDX identifier tag to the
> first line of the code
> 
> Signed-off-by: Amir Mahdi Ghorbanian <indigoomega021@gmail.com>
Two things.  It's not a 'mistake' as this driver massively predates the use of
SPDX tags!  Also, there is a problem here as it's current licensing is
inconsistent.  The MODULE_LICENSE is GPL-2.0 which would be GPL-2.0 (no +)
but the original comment was +.

Michael, do you want to take a view on this one?  Copyright is Analog's
so should be fine if you say what is preferred.

Thanks,

Jonathan

> ---
>  drivers/staging/iio/accel/adis16203.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/iio/accel/adis16203.c b/drivers/staging/iio/accel/adis16203.c
> index 5cc96c80..4ae5b74 100644
> --- a/drivers/staging/iio/accel/adis16203.c
> +++ b/drivers/staging/iio/accel/adis16203.c
> @@ -1,9 +1,9 @@
> +// SPDX-License-Identifier: GPL-2.0+
>  /*
>   * ADIS16203 Programmable 360 Degrees Inclinometer
>   *
>   * Copyright 2010 Analog Devices Inc.
>   *
> - * Licensed under the GPL-2 or later.
>   */
>  
>  #include <linux/delay.h>

