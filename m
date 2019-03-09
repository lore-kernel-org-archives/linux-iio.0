Return-Path: <SRS0=9Bew=RM=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69A44C43381
	for <linux-iio@archiver.kernel.org>; Sat,  9 Mar 2019 18:18:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40B18206DF
	for <linux-iio@archiver.kernel.org>; Sat,  9 Mar 2019 18:18:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552155527;
	bh=Uy1ZnZAkD8mYG5A13dA8ULOs4ORlMyAYLfFWQOuxFU4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=Hv8AGT8GjYHq16EpJmihPSYJg7j8FM/9wjOn63ybJK/ozI4k4QmhJZM1YdGGEz/yg
	 g4q3qXMLnHvVfUfSr62vB1drkDxt/Ohqjh6LhR+BTYEYJ8UdbhxxRerOiM/3c6FPXo
	 Y8g/x4v79oyp+rb90EqnebuA+6ublL5nydf/cq2E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbfCISSq (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 9 Mar 2019 13:18:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:42554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726313AbfCISSq (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 9 Mar 2019 13:18:46 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 409EA206DF;
        Sat,  9 Mar 2019 18:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552155526;
        bh=Uy1ZnZAkD8mYG5A13dA8ULOs4ORlMyAYLfFWQOuxFU4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=0Bfd/2eegYAp0PLwm5b3GDCESq3e2Xo3ZwRAvHMH88xnVsgqE7E1clqKB2Rthy9HH
         1AMdVyca/EbVBTc9M33KWZiJ30XK1IsL1JwBvmJCQg9FxeUc3n0h0lhx9svebJ1Avh
         GCQBZ9OfdrrwZWPvmuTJMVh1VAq/uMnEFPmeBvaU=
Date:   Sat, 9 Mar 2019 18:18:41 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Sean Nyekjaer <sean@geanix.com>
Cc:     linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: dac: ti-dac5571: Update the module author
 email address
Message-ID: <20190309181841.0671f9ac@archlinux>
In-Reply-To: <20190305073627.6880-2-sean@geanix.com>
References: <20190305073627.6880-1-sean@geanix.com>
        <20190305073627.6880-2-sean@geanix.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue,  5 Mar 2019 08:36:27 +0100
Sean Nyekjaer <sean@geanix.com> wrote:

> Update the module author to the current email address
> 
> Signed-off-by: Sean Nyekjaer <sean@geanix.com>
Applied.

Thanks,

Jonathan
> ---
>  drivers/iio/dac/ti-dac5571.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/dac/ti-dac5571.c b/drivers/iio/dac/ti-dac5571.c
> index f6dcd8bce2b0..891e9cac019e 100644
> --- a/drivers/iio/dac/ti-dac5571.c
> +++ b/drivers/iio/dac/ti-dac5571.c
> @@ -429,6 +429,6 @@ static struct i2c_driver dac5571_driver = {
>  };
>  module_i2c_driver(dac5571_driver);
>  
> -MODULE_AUTHOR("Sean Nyekjaer <sean.nyekjaer@prevas.dk>");
> +MODULE_AUTHOR("Sean Nyekjaer <sean@geanix.dk>");
>  MODULE_DESCRIPTION("Texas Instruments 8/10/12-bit 1/4-channel DAC driver");
>  MODULE_LICENSE("GPL v2");

