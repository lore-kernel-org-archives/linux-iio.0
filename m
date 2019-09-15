Return-Path: <SRS0=8Qe3=XK=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2DC2C4CEC7
	for <linux-iio@archiver.kernel.org>; Sun, 15 Sep 2019 09:53:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FFA1214AF
	for <linux-iio@archiver.kernel.org>; Sun, 15 Sep 2019 09:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568541187;
	bh=eY/svIwzWeTPEPLCh0a5G9JGZm+IqSfCU4uCCdA91NE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=wpm6+6inFaQ2+V2lDtnQMC0PxsuwbPzfykl31CfH/ub1sjYtRSkfIHnYKLygqbow5
	 9UbnFalYXGt7A+pmn/8posnxkQqoSVru/DdX25BZUQUnAjZrxi5/4gPgcIbMz1TqY4
	 E2C77FL0i8HFRtZerLmeoQHlWxEg6jj0F3oVbYus=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725835AbfIOJxH (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 15 Sep 2019 05:53:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:47994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725497AbfIOJxG (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 15 Sep 2019 05:53:06 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EC8F42077C;
        Sun, 15 Sep 2019 09:53:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568541186;
        bh=eY/svIwzWeTPEPLCh0a5G9JGZm+IqSfCU4uCCdA91NE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=S3NIcyIyIRUhGkWWEzuE2IAuk2NIx7FVAcZfiTht66CwamPfJ3fnV+Jv8Z/Uccw9G
         G6b0SLa4Jqh8xf1gP07alHNNodK87mirrmaiC/FA8zK2O5OnS31axNpQ4Ojw4+op/m
         wnMBAzLIYfPfgF+e/0m9TZ9A5c/Po/FHeXCr5og4=
Date:   Sun, 15 Sep 2019 10:53:00 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rohit Sarkar <rohitsarkar5398@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Stefan Popa <stefan.popa@analog.com>,
        gregkh@linuxfoundation.org, Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Rodrigo Carvalho <rodrigorsdc@gmail.com>
Subject: Re: [PATCH] staging: iio: ADIS16240: Remove unused include
Message-ID: <20190915105300.12cc105f@archlinux>
In-Reply-To: <20190913203627.GA1320@SARKAR>
References: <20190913203627.GA1320@SARKAR>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 14 Sep 2019 02:06:27 +0530
Rohit Sarkar <rohitsarkar5398@gmail.com> wrote:

> Bcc: 
> Subject: [PATCH] staging: iio: adis16240: remove unused include
> Reply-To: 
Something odd happened here with patch formatting.  I fixed it up and
applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan

> 
> '#include<linux/gpio.h>' isn't being used anywhere. Remove it.
> 
> Signed-off-by: Rohit Sarkar <rohitsarkar5398@gmail.com>
> ---
>  drivers/staging/iio/accel/adis16240.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/staging/iio/accel/adis16240.c b/drivers/staging/iio/accel/adis16240.c
> index 82099db4bf0c..a480409090c0 100644
> --- a/drivers/staging/iio/accel/adis16240.c
> +++ b/drivers/staging/iio/accel/adis16240.c
> @@ -7,7 +7,6 @@
>  
>  #include <linux/interrupt.h>
>  #include <linux/irq.h>
> -#include <linux/gpio.h>
>  #include <linux/delay.h>
>  #include <linux/device.h>
>  #include <linux/kernel.h>

