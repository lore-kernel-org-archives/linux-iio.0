Return-Path: <SRS0=Oq/L=QQ=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 300BBC282C4
	for <linux-iio@archiver.kernel.org>; Sat,  9 Feb 2019 16:41:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEB6F21929
	for <linux-iio@archiver.kernel.org>; Sat,  9 Feb 2019 16:41:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549730486;
	bh=XuJU5vMqAWOnBInQ/KzMviuSSEqZ5JNuHM05Qnlq2No=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=IC1gOKRyrwqo2H0FueV5B7XvzkGyoNuDpGmGCPlaGEHcHGnJDLC4LHih1wBJMz6sk
	 ey+YcgL+bEaKC7bqIBIAwCLdAuCPUrClufdv19Jb5BBefGYhcolpU1Qd3/iNbr3MZz
	 QqsULTGGtJsKofzvM6efxFpgADwcL8eusK3dyKmA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727014AbfBIQlZ (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 9 Feb 2019 11:41:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:58738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726880AbfBIQlZ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 9 Feb 2019 11:41:25 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 27A03217D8;
        Sat,  9 Feb 2019 16:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549730484;
        bh=XuJU5vMqAWOnBInQ/KzMviuSSEqZ5JNuHM05Qnlq2No=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=T6Yp/r6Ho9Haa4uimV8Rs/alj8ok/HfaLnMs6UIrj4l0yRzvPSwPdph3Lnc64ybat
         apZEA5ttZn2aI7EocIhXCAoN+A2vFqw2qrNl0esqVnkH+1HAq5w+Eu0w8mM06HFmc3
         Uh/YQ1jKkGLrDxAUE0c6bp0QjvrHw6vRU7UM+1rw=
Date:   Sat, 9 Feb 2019 16:41:06 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Tomasz Duszynski <tduszyns@gmail.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] iio: chemical: sps30: fix a loop timeout test
Message-ID: <20190209164106.50de74f9@archlinux>
In-Reply-To: <20190209090350.GD4865@kadam>
References: <20190209090350.GD4865@kadam>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 9 Feb 2019 12:03:52 +0300
Dan Carpenter <dan.carpenter@oracle.com> wrote:

> The "while (tries--) {" loop is a postop so it exits with "tries" set
> to -1.
> 
> Fixes: 232e0f6ddeae ("iio: chemical: add support for Sensirion SPS30 sensor")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Thanks.

Applied to the togreg branch of iio.git.  Should make it in before
the merge window so no need for stable etc.

thanks,

Jonathan
> ---
>  drivers/iio/chemical/sps30.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/chemical/sps30.c b/drivers/iio/chemical/sps30.c
> index e03a28a67146..375df5060ed5 100644
> --- a/drivers/iio/chemical/sps30.c
> +++ b/drivers/iio/chemical/sps30.c
> @@ -210,7 +210,7 @@ static int sps30_do_meas(struct sps30_state *state, s32 *data, int size)
>  		msleep_interruptible(300);
>  	}
>  
> -	if (!tries)
> +	if (tries == -1)
>  		return -ETIMEDOUT;
>  
>  	ret = sps30_do_cmd(state, SPS30_READ_DATA, tmp, sizeof(int) * size);

