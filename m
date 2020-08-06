Return-Path: <SRS0=+PUP=BQ=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC969C433E1
	for <linux-iio@archiver.kernel.org>; Thu,  6 Aug 2020 18:39:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 234E622C9F
	for <linux-iio@archiver.kernel.org>; Thu,  6 Aug 2020 18:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596739158;
	bh=sgrriGvvtWI7kCSGARd8WdvCWTR8opdRkGZeXw3CrHc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=yQzBwS5nmuXoZ1GVA7EsiVB4WA8UzhlWzwXK7GzrR+/VsBCsJGSDOHHHZhvoO4Zcg
	 +Yx3eiSJRCrd0dKOUEb0kyXkZujMQdo1lsCAWAIbaeo4gmPI5XqEAPzzxiVDp+ke/l
	 i9vb9ZGSVlcG2+p2jpDsUuX/MP5sZfyO5XkYCwrU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728862AbgHFSjH (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Thu, 6 Aug 2020 14:39:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:54062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728414AbgHFSaD (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 6 Aug 2020 14:30:03 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4AF502311C;
        Thu,  6 Aug 2020 18:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596738603;
        bh=sgrriGvvtWI7kCSGARd8WdvCWTR8opdRkGZeXw3CrHc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fNG5DOvIyahVPtBri53Saf++y4xlyIv8+02SJ89wIyCnFUIN5lVQG8ETo/KJ4fjU/
         iDP+46UYeEdydoTAxvShr4Sk+kL3koN/yFZoXpLuXfyhAV19ULaPqTmgPBbR07Xk/l
         SSN642xHxzS6pzimTimBnabcqxDsjGQ9OXlp0RFU=
Date:   Thu, 6 Aug 2020 19:29:53 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Daniel Campello <campello@chromium.org>
Cc:     LKML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Douglas Anderson <dianders@chromium.org>,
        Enrico Granata <egranata@chromium.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Stephen Boyd <swboyd@chromium.org>, linux-iio@vger.kernel.org
Subject: Re: [PATCH v5 06/15] iio: sx9310: Fixes various memory handling
Message-ID: <20200806192953.7a963543@archlinux>
In-Reply-To: <20200803175559.v5.6.I8accffd77d616cb55b29bc3021cb0f5e1da3b68a@changeid>
References: <20200803235815.778997-1-campello@chromium.org>
        <20200803175559.v5.6.I8accffd77d616cb55b29bc3021cb0f5e1da3b68a@changeid>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon,  3 Aug 2020 17:58:06 -0600
Daniel Campello <campello@chromium.org> wrote:

> Makes use __aligned(8) to ensure that the timestamp is correctly aligned
> when we call io_push_to_buffers_with_timestamp().
> Also makes use of sizeof() for regmap_bulk_read instead of static value.
> 
> Signed-off-by: Daniel Campello <campello@chromium.org>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Applied

> ---
> 
> Changes in v5:
>  - Really use a pointer to buffer struct on
> iio_push_to_buffers_with_timestamp().
> 
> Changes in v4:
>  - Use pointer to buffer struct on iio_push_to_buffers_with_timestamp().
> 
> Changes in v3:
>  - Changed buffer to struct type to align timestamp memory properly.
> 
> Changes in v2:
>  - Fixed commit message from "iio: sx9310: Align memory"
> 
>  drivers/iio/proximity/sx9310.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/proximity/sx9310.c b/drivers/iio/proximity/sx9310.c
> index 66ecdd309e0ddc..127b1ba79e2dea 100644
> --- a/drivers/iio/proximity/sx9310.c
> +++ b/drivers/iio/proximity/sx9310.c
> @@ -132,8 +132,11 @@ struct sx9310_data {
>  	 */
>  	bool prox_stat[SX9310_NUM_CHANNELS];
>  	bool trigger_enabled;
> -	__be16 buffer[SX9310_NUM_CHANNELS +
> -		      4]; /* 64-bit data + 64-bit timestamp */
> +	/* Ensure correct alignment of timestamp when present. */
> +	struct {
> +		__be16 channels[SX9310_NUM_CHANNELS];
> +		s64 ts __aligned(8);
> +	} buffer;
>  	/* Remember enabled channels and sample rate during suspend. */
>  	unsigned int suspend_ctrl0;
>  	struct completion completion;
> @@ -344,7 +347,7 @@ static int sx9310_read_prox_data(struct sx9310_data *data,
>  	if (ret < 0)
>  		return ret;
>  
> -	return regmap_bulk_read(data->regmap, chan->address, val, 2);
> +	return regmap_bulk_read(data->regmap, chan->address, val, sizeof(*val));
>  }
>  
>  /*
> @@ -694,10 +697,10 @@ static irqreturn_t sx9310_trigger_handler(int irq, void *private)
>  		if (ret < 0)
>  			goto out;
>  
> -		data->buffer[i++] = val;
> +		data->buffer.channels[i++] = val;
>  	}
>  
> -	iio_push_to_buffers_with_timestamp(indio_dev, data->buffer,
> +	iio_push_to_buffers_with_timestamp(indio_dev, &data->buffer,
>  					   pf->timestamp);
>  
>  out:

