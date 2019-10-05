Return-Path: <SRS0=SkP8=X6=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40666C3E8AB
	for <linux-iio@archiver.kernel.org>; Sat,  5 Oct 2019 11:37:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12F8E222C9
	for <linux-iio@archiver.kernel.org>; Sat,  5 Oct 2019 11:37:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570275459;
	bh=h+ZQ1AZze6o4W0rlDDu4jtuOqUCFUvspO+1anuOBp10=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=tiA+4GPQpAz6sJ3D88/v0CKT3waizg8xNhC0wrHtvInsjQTsclvALuRogZZXWogga
	 JW7ddAH4BzOPGI2MeXHbpeXVbgaTPWG7mXCAYp7A4kf/mYsqHIX7keDb94vLNok6Mn
	 +cDVo2aUFrV/LBR+OIJgBLhoU/ajXT0IiJ328gCI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728049AbfJELhi (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 5 Oct 2019 07:37:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:36528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726902AbfJELhi (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 5 Oct 2019 07:37:38 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1BB3B2133F;
        Sat,  5 Oct 2019 11:37:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570275457;
        bh=h+ZQ1AZze6o4W0rlDDu4jtuOqUCFUvspO+1anuOBp10=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=cl8FoVjZoJbwoneADVxKMEu0WOaFDtoS+mXMHE/gNCxo8cXO+hFgbJgeyv0H8QVTb
         Ay77KPg1ORofnsr7cBGUPZMsXLwwg/p0QG6ANf8hNWNOqpJ73NEtZKJzUyIo7nPLQ6
         s1TMe/1Feslt8ReEgt2m9GLx/3lPPdw8hjBvDy5k=
Date:   Sat, 5 Oct 2019 12:37:32 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Sean Nyekjaer <sean@geanix.com>
Cc:     linux-iio@vger.kernel.org, lorenzo.bianconi83@gmail.com,
        denis.ciocca@st.com, mario.tesi@st.com, armando.visconti@st.com,
        martin@geanix.com
Subject: Re: [PATCH v10 4/5] iio: imu: st_lsm6dsx: always enter interrupt
 thread
Message-ID: <20191005123732.5483c773@archlinux>
In-Reply-To: <20190916135630.2211714-4-sean@geanix.com>
References: <20190916135630.2211714-1-sean@geanix.com>
        <20190916135630.2211714-4-sean@geanix.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 16 Sep 2019 15:56:29 +0200
Sean Nyekjaer <sean@geanix.com> wrote:

> The interrupt source can come from multiple sources,
> fifo and wake interrupts.
> Enter interrupt thread to check which interrupt that has fired.
> 
> Signed-off-by: Sean Nyekjaer <sean@geanix.com>
Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

thanks,

Jonathan

> ---
> Changes since v8:
>  * Remove st_lsm6dsx_handler_irq function to enter interrupt thread
>    at every interrupt
> 
> Changes since v9:
>  * None
> 
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 9 +--------
>  1 file changed, 1 insertion(+), 8 deletions(-)
> 
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> index a7f12cf57f11..6b03c50f4732 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> @@ -1715,13 +1715,6 @@ static struct iio_dev *st_lsm6dsx_alloc_iiodev(struct st_lsm6dsx_hw *hw,
>  	return iio_dev;
>  }
>  
> -static irqreturn_t st_lsm6dsx_handler_irq(int irq, void *private)
> -{
> -	struct st_lsm6dsx_hw *hw = private;
> -
> -	return hw->sip > 0 ? IRQ_WAKE_THREAD : IRQ_NONE;
> -}
> -
>  static irqreturn_t st_lsm6dsx_handler_thread(int irq, void *private)
>  {
>  	struct st_lsm6dsx_hw *hw = private;
> @@ -1779,7 +1772,7 @@ static int st_lsm6dsx_irq_setup(struct st_lsm6dsx_hw *hw)
>  	}
>  
>  	err = devm_request_threaded_irq(hw->dev, hw->irq,
> -					st_lsm6dsx_handler_irq,
> +					NULL,
>  					st_lsm6dsx_handler_thread,
>  					irq_type | IRQF_ONESHOT,
>  					"lsm6dsx", hw);

