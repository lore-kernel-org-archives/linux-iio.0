Return-Path: <SRS0=8Qe3=XK=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4E9AC4CECC
	for <linux-iio@archiver.kernel.org>; Sun, 15 Sep 2019 12:33:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AB34214D8
	for <linux-iio@archiver.kernel.org>; Sun, 15 Sep 2019 12:33:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568550817;
	bh=VLNlAAWCO4H/Oafb2fRPySYioh8eUZXcPJcx7f4ilKU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=j7C9giUj9iBWaWJpVNGGcSoUbD1RNzqz+zYcoyGa0JWtT5YIDznAX4VlqmCu5pWwf
	 ED36uR/mW9ZTDXUj+BMxc/1BvIGmH/o5FphTCD77Dbe1TiUhgt2SI02t5Ns0sa2N4P
	 UoceWLDOpVUQNx5+6o9UH21KUut+ycieAgL/iEpU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726378AbfIOMdh (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 15 Sep 2019 08:33:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:57918 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726246AbfIOMdh (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 15 Sep 2019 08:33:37 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 23A99214C6;
        Sun, 15 Sep 2019 12:33:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568550816;
        bh=VLNlAAWCO4H/Oafb2fRPySYioh8eUZXcPJcx7f4ilKU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=YUHGN2cAyyZplVHU2GAPYLhcKZiPSdm4BsXo1W1ekHaVWTN9DCmDngUnWkIKWbu3c
         0umPUwRTsREuuv7Yy8WMPivGT5A3BRF87JG2Garfqq+JiPw26MLl+WwV+HplvVqEao
         wPMlykF3PX5VFu8YxH9O9pgk7UanwTsWFbqqsgFQ=
Date:   Sun, 15 Sep 2019 13:33:32 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Sean Nyekjaer <sean@geanix.com>
Cc:     linux-iio@vger.kernel.org, lorenzo.bianconi83@gmail.com,
        denis.ciocca@st.com, mario.tesi@st.com, armando.visconti@st.com,
        martin@geanix.com
Subject: Re: [PATCH v8 4/5] iio: imu: st_lsm6dsx: always enter interrupt
 thread
Message-ID: <20190915133332.3762e860@archlinux>
In-Reply-To: <20190913090708.1442057-5-sean@geanix.com>
References: <20190913090708.1442057-1-sean@geanix.com>
        <20190913090708.1442057-5-sean@geanix.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 13 Sep 2019 11:07:07 +0200
Sean Nyekjaer <sean@geanix.com> wrote:

> The interrupt source can come from multiple sources,
> fifo and wake interrupts.
> Enter interrupt thread to check which interrupt that has fired.
> 
> Signed-off-by: Sean Nyekjaer <sean@geanix.com>
> ---
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> index 810807c52d5f..80a94335175f 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> @@ -1717,9 +1717,7 @@ static struct iio_dev *st_lsm6dsx_alloc_iiodev(struct st_lsm6dsx_hw *hw,
>  
>  static irqreturn_t st_lsm6dsx_handler_irq(int irq, void *private)
>  {
> -	struct st_lsm6dsx_hw *hw = private;
> -
> -	return hw->sip > 0 ? IRQ_WAKE_THREAD : IRQ_NONE;
> +	return IRQ_WAKE_THREAD;

I missed this before.  Isn't this the same as just not providing a top half at all?

I.e. Pass null to request_threaded_irq where this function was.

Thanks,

Jonathan


>  }
>  
>  static irqreturn_t st_lsm6dsx_handler_thread(int irq, void *private)

