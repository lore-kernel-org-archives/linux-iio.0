Return-Path: <SRS0=77Uk=A5=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1004DC433E0
	for <linux-iio@archiver.kernel.org>; Sat, 18 Jul 2020 15:44:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6D7D2080D
	for <linux-iio@archiver.kernel.org>; Sat, 18 Jul 2020 15:44:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595087062;
	bh=m8j9ACFyZJwuRQ05NiSfsU7NHB7bGakx320RUCzzw9o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=ifmTZ6KaAe0LIdoXjw7ViJR0UIZ9zxyeoS8ejF79MEDWyJFUTGzDhtxFzVQhgVRBE
	 T0ZJlP8c77I4PyMqblG0wfTQCVRvwCfEbuetohtWSdvThBpSh3DWlO6/pQr3LUZog7
	 lbglVsTIHCaTGtVTnkv++BVYjAIL8sl8m1a9k1ro=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbgGRPoW (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 18 Jul 2020 11:44:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:45834 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726155AbgGRPoW (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 18 Jul 2020 11:44:22 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6441820734;
        Sat, 18 Jul 2020 15:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595087061;
        bh=m8j9ACFyZJwuRQ05NiSfsU7NHB7bGakx320RUCzzw9o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=igBjveGbwdhjVYl/80iDZiZ3H7XGpOAvsktSxH9RFaP5SkKYqKri/Q1Gmi8HbqTsP
         mRAP7PV/hpjDcVSlgFS0PMIk0lxfpmHq2ImyR4HxWLnoaYL0KUijsgTyYqMEeqludE
         ZM1+FiLPsKKXOeDodeJFGiHABvKl3sSPo6DKlXbg=
Date:   Sat, 18 Jul 2020 16:44:17 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, Adriana Reus <adriana.reus@intel.com>
Subject: Re: [PATCH 10/30] iio: light: us5182d: Fix formatting in kerneldoc
 function block
Message-ID: <20200718164417.250f5f05@archlinux>
In-Reply-To: <20200717165538.3275050-11-lee.jones@linaro.org>
References: <20200717165538.3275050-1-lee.jones@linaro.org>
        <20200717165538.3275050-11-lee.jones@linaro.org>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 17 Jul 2020 17:55:18 +0100
Lee Jones <lee.jones@linaro.org> wrote:

> Kerneldoc expects attributes/parameters to be in '@*.: ' format.
> 
> Fixes the following W=1 kernel build warning(s):
> 
>  drivers/iio/light/us5182d.c:457: warning: Function parameter or member 'data' not described in 'us5182d_update_dark_th'
>  drivers/iio/light/us5182d.c:457: warning: Function parameter or member 'index' not described in 'us5182d_update_dark_th'
>  drivers/iio/light/us5182d.c:479: warning: Function parameter or member 'data' not described in 'us5182d_apply_scale'
>  drivers/iio/light/us5182d.c:479: warning: Function parameter or member 'index' not described in 'us5182d_apply_scale'
> 
> Cc: Adriana Reus <adriana.reus@intel.com>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
Applied.

Thanks,

Jonathan

> ---
>  drivers/iio/light/us5182d.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/light/us5182d.c b/drivers/iio/light/us5182d.c
> index b995f21a33479..24843597beba5 100644
> --- a/drivers/iio/light/us5182d.c
> +++ b/drivers/iio/light/us5182d.c
> @@ -446,8 +446,8 @@ static int us5182d_read_raw(struct iio_dev *indio_dev,
>  
>  /**
>   * us5182d_update_dark_th - update Darh_Th registers
> - * @data	us5182d_data structure
> - * @index	index in us5182d_dark_ths array to use for the updated value
> + * @data:	us5182d_data structure
> + * @index:	index in us5182d_dark_ths array to use for the updated value
>   *
>   * Function needs to be called with a lock held because it needs two i2c write
>   * byte operations as these registers (0x27 0x28) don't work in word mode
> @@ -469,8 +469,8 @@ static int us5182d_update_dark_th(struct us5182d_data *data, int index)
>  
>  /**
>   * us5182d_apply_scale - update the ALS scale
> - * @data	us5182d_data structure
> - * @index	index in us5182d_scales array to use for the updated value
> + * @data:	us5182d_data structure
> + * @index:	index in us5182d_scales array to use for the updated value
>   *
>   * Function needs to be called with a lock held as we're having more than one
>   * i2c operation.

