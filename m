Return-Path: <SRS0=77Uk=A5=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72ECAC433E1
	for <linux-iio@archiver.kernel.org>; Sat, 18 Jul 2020 15:51:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C89020829
	for <linux-iio@archiver.kernel.org>; Sat, 18 Jul 2020 15:51:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595087507;
	bh=/d26/T16Jl834WEaxmzPmRbg84m0LV3DyqaNHiMZGOs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=bmelFuBBK+knvOon8HFFG6SExetIuYy0qLJZIB99pSilfL0RVWtx756rSlwCALWlK
	 Xr1fgtj3SD+qKey2NCn+aPy+/+2jyMkGWEUoXDUBXxkcL4AYnr8y7GmGTagMXGhZ3n
	 6FgJLPYmHU/V2vvAuPERzqiMSkscgDqSFZIdD20w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbgGRPvq (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 18 Jul 2020 11:51:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:49024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726155AbgGRPvq (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 18 Jul 2020 11:51:46 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9355E2076A;
        Sat, 18 Jul 2020 15:51:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595087505;
        bh=/d26/T16Jl834WEaxmzPmRbg84m0LV3DyqaNHiMZGOs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fQiIDS4wSwngiSrAULgxgjPoQDWLnGd/oMomVnQMK4Dy9dgWqtEU92MNjY7h8AJ90
         Ej0QS9XFVej0KbgK9TGNnjwtX7xpDRPMJythFevjiuUEj/AuOdUDtUEhHjo1uFPwep
         DVVIf1h3RBXiBoG/VrrQQSGmhu0myRFO4kXQxJ+o=
Date:   Sat, 18 Jul 2020 16:51:41 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH 16/30] iio: accel: sca3000: Fix 2 misspellings and
 demote nonconforming kerneldocs
Message-ID: <20200718165141.41f3e8a3@archlinux>
In-Reply-To: <20200717165538.3275050-17-lee.jones@linaro.org>
References: <20200717165538.3275050-1-lee.jones@linaro.org>
        <20200717165538.3275050-17-lee.jones@linaro.org>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 17 Jul 2020 17:55:24 +0100
Lee Jones <lee.jones@linaro.org> wrote:

> Fixes the following W=1 kernel build warning(s):
> 
>  drivers/iio/accel/sca3000.c:210: warning: Function parameter or member 'mot_det_mult_xz' not described in 'sca3000_chip_info'
>  drivers/iio/accel/sca3000.c:210: warning: Function parameter or member 'mot_det_mult_y' not described in 'sca3000_chip_info'
>  drivers/iio/accel/sca3000.c:871: warning: Function parameter or member 'indio_dev' not described in 'sca3000_read_event_value'
>  drivers/iio/accel/sca3000.c:871: warning: Function parameter or member 'chan' not described in 'sca3000_read_event_value'
>  drivers/iio/accel/sca3000.c:871: warning: Function parameter or member 'type' not described in 'sca3000_read_event_value'
>  drivers/iio/accel/sca3000.c:871: warning: Function parameter or member 'dir' not described in 'sca3000_read_event_value'
>  drivers/iio/accel/sca3000.c:871: warning: Function parameter or member 'info' not described in 'sca3000_read_event_value'
>  drivers/iio/accel/sca3000.c:871: warning: Function parameter or member 'val' not described in 'sca3000_read_event_value'
>  drivers/iio/accel/sca3000.c:871: warning: Function parameter or member 'val2' not described in 'sca3000_read_event_value'
>  drivers/iio/accel/sca3000.c:1110: warning: Function parameter or member 'indio_dev' not described in 'sca3000_read_event_config'
>  drivers/iio/accel/sca3000.c:1110: warning: Function parameter or member 'chan' not described in 'sca3000_read_event_config'
>  drivers/iio/accel/sca3000.c:1110: warning: Function parameter or member 'type' not described in 'sca3000_read_event_config'
>  drivers/iio/accel/sca3000.c:1110: warning: Function parameter or member 'dir' not described in 'sca3000_read_event_config'
> 
> Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
Applied.

Thanks,

Jonathan

> ---
>  drivers/iio/accel/sca3000.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iio/accel/sca3000.c b/drivers/iio/accel/sca3000.c
> index 6e429072e44a4..3952187166ffa 100644
> --- a/drivers/iio/accel/sca3000.c
> +++ b/drivers/iio/accel/sca3000.c
> @@ -186,9 +186,9 @@ struct sca3000_state {
>   * @option_mode_2_freq:		option mode 2 sampling frequency
>   * @option_mode_2_3db_freq:	3db cutoff frequency of the low pass filter for
>   * the second option mode.
> - * @mod_det_mult_xz:		Bit wise multipliers to calculate the threshold
> + * @mot_det_mult_xz:		Bit wise multipliers to calculate the threshold
>   * for motion detection in the x and z axis.
> - * @mod_det_mult_y:		Bit wise multipliers to calculate the threshold
> + * @mot_det_mult_y:		Bit wise multipliers to calculate the threshold
>   * for motion detection in the y axis.
>   *
>   * This structure is used to hold information about the functionality of a given
> @@ -859,9 +859,9 @@ static ssize_t sca3000_read_av_freq(struct device *dev,
>   */
>  static IIO_DEV_ATTR_SAMP_FREQ_AVAIL(sca3000_read_av_freq);
>  
> -/**
> +/*
>   * sca3000_read_event_value() - query of a threshold or period
> - **/
> + */
>  static int sca3000_read_event_value(struct iio_dev *indio_dev,
>  				    const struct iio_chan_spec *chan,
>  				    enum iio_event_type type,
> @@ -1100,9 +1100,9 @@ static irqreturn_t sca3000_event_handler(int irq, void *private)
>  	return IRQ_HANDLED;
>  }
>  
> -/**
> +/*
>   * sca3000_read_event_config() what events are enabled
> - **/
> + */
>  static int sca3000_read_event_config(struct iio_dev *indio_dev,
>  				     const struct iio_chan_spec *chan,
>  				     enum iio_event_type type,

