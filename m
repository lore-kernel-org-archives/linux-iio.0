Return-Path: <SRS0=gatg=CJ=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C8ADC433E6
	for <linux-iio@archiver.kernel.org>; Mon, 31 Aug 2020 14:10:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4AABB20719
	for <linux-iio@archiver.kernel.org>; Mon, 31 Aug 2020 14:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598883017;
	bh=e4JtKbjTHubD1Fn1GmcKwE5TJjn7Ww6BNNSqDvYAGLk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=QxtPCidLL40lIx5ihcxk8q7dnDHl7I3YD6EydcxURjiXjqrN0E4wOEDc5wXe3wYNS
	 M2vYhniNiFpmlAUBLxjFTYSYaiTOdqU4LUY/UrfUIAg+Joidt1MAmRXjnRTiJnwGMu
	 2EH0UJ9i1bLbgru8aIl2Hmvu7Cr+Bh6J/uXXFWqo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726446AbgHaOKQ (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Mon, 31 Aug 2020 10:10:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:56950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726326AbgHaOKQ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 31 Aug 2020 10:10:16 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0011F20719;
        Mon, 31 Aug 2020 14:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598883015;
        bh=e4JtKbjTHubD1Fn1GmcKwE5TJjn7Ww6BNNSqDvYAGLk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=JCu1cuMgVDtyDggEttA9h5eLrnRhJy37ZEQTT2Ri/1BBsgELPMMbj7KQWZQGNVOyG
         eMHKqydw5HfoqwsIJP+Pd/rvhn1Bt1HemHBIoGrnTgUC237pkV4CPcMVqsQsMm1u/1
         hFd8M0LFsUOf2TCvunypdwmEKQFKSZIiYXqXTLLs=
Date:   Mon, 31 Aug 2020 15:10:11 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Angelo Compagnucci <angelo.compagnucci@gmail.com>
Cc:     linux-iio@vger.kernel.org,
        Angelo Compagnucci <angelo@amarulasolutions.com>
Subject: Re: [PATCH v3] iio: adc: mcp3422: fix locking scope
Message-ID: <20200831151011.10405ac1@archlinux>
In-Reply-To: <20200831125947.74824-1-angelo@amarulasolutions.com>
References: <20200831125947.74824-1-angelo@amarulasolutions.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 31 Aug 2020 14:59:47 +0200
Angelo Compagnucci <angelo.compagnucci@gmail.com> wrote:

> From: Angelo Compagnucci <angelo.compagnucci@gmail.com>
> 
> Locking should be held for the entire reading sequence involving setting
> the channel, waiting for the channel switch and reading from the
> channel.
> If not, reading from a channel can result mixing with the reading from
> another channel.
> 
> Fixes: 07914c84ba30 ("iio: adc: Add driver for Microchip MCP3422/3/4 high resolution ADC")
> Signed-off-by: Angelo Compagnucci <angelo.compagnucci@gmail.com>
> Signed-off-by: Angelo Compagnucci <angelo@amarulasolutions.com>
> ---
Hi Angelo

Change log?

Given I've just sent a pull request including v2, we are probably now in a mess
if we actually need to use v3.

Jonathan

>  drivers/iio/adc/mcp3422.c | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iio/adc/mcp3422.c b/drivers/iio/adc/mcp3422.c
> index d86c0b5d80a3..f96f0cecbcde 100644
> --- a/drivers/iio/adc/mcp3422.c
> +++ b/drivers/iio/adc/mcp3422.c
> @@ -96,16 +96,12 @@ static int mcp3422_update_config(struct mcp3422 *adc, u8 newconfig)
>  {
>  	int ret;
>  
> -	mutex_lock(&adc->lock);
> -
>  	ret = i2c_master_send(adc->i2c, &newconfig, 1);
>  	if (ret > 0) {
>  		adc->config = newconfig;
>  		ret = 0;
>  	}
>  
> -	mutex_unlock(&adc->lock);
> -
>  	return ret;
>  }
>  
> @@ -138,6 +134,8 @@ static int mcp3422_read_channel(struct mcp3422 *adc,
>  	u8 config;
>  	u8 req_channel = channel->channel;
>  
> +	mutex_lock(&adc->lock);
> +
>  	if (req_channel != MCP3422_CHANNEL(adc->config)) {
>  		config = adc->config;
>  		config &= ~MCP3422_CHANNEL_MASK;
> @@ -145,12 +143,18 @@ static int mcp3422_read_channel(struct mcp3422 *adc,
>  		config &= ~MCP3422_PGA_MASK;
>  		config |= MCP3422_PGA_VALUE(adc->pga[req_channel]);
>  		ret = mcp3422_update_config(adc, config);
> -		if (ret < 0)
> +		if (ret < 0) {
> +			mutex_unlock(&adc->lock);
>  			return ret;
> +		}
>  		msleep(mcp3422_read_times[MCP3422_SAMPLE_RATE(adc->config)]);
>  	}
>  
> -	return mcp3422_read(adc, value, &config);
> +	ret = mcp3422_read(adc, value, &config);
> +
> +	mutex_unlock(&adc->lock);
> +
> +	return ret;
>  }
>  
>  static int mcp3422_read_raw(struct iio_dev *iio,

