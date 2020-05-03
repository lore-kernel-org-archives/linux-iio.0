Return-Path: <SRS0=u9I9=6R=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3F60C28CBC
	for <linux-iio@archiver.kernel.org>; Sun,  3 May 2020 08:58:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B969207DD
	for <linux-iio@archiver.kernel.org>; Sun,  3 May 2020 08:58:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588496320;
	bh=PzPJwhdog6n665ICQFUm4hWA02sPJblPykFkeetcIk4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=PGCqbZHdqDfN+f/eTUPGn60JCLEo09pq1K10f2Z5gppwyOyeU/z4wMnBwKf3kls1M
	 csfS7s5JfL6XeR3Vzp0Qi0oy7G0MEYjoKiADnBn1qkHGjhNjgoucO5zrfbmu6LkptT
	 lm08NmaEmmvYrrs2xU01LqGiC0CJ172OX1dYGE8Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727871AbgECI6j (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 3 May 2020 04:58:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:40392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726445AbgECI6j (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 3 May 2020 04:58:39 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F225620757;
        Sun,  3 May 2020 08:58:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588496319;
        bh=PzPJwhdog6n665ICQFUm4hWA02sPJblPykFkeetcIk4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=bssdfKQmpxdwtkl3EoF629epL3V7tK/iUBx8FX4iENSz5kLmrX5UEWbs9UcI/yCFx
         X5SWJFoyymHdn3uIPtYQcnTKz6IJdRZHa6Ium2icqI1eiige7zUG4wVNnDi/8np1pb
         99ZaqRDsSdQIYCYnzNFxPp6g7BGU9Q4abHIFelSg=
Date:   Sun, 3 May 2020 09:58:35 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Mathieu Othacehe <m.othacehe@gmail.com>
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/5] iio: vcnl4000: Fix i2c swapped word reading.
Message-ID: <20200503095835.37a9bcf2@archlinux>
In-Reply-To: <20200427095559.16131-2-m.othacehe@gmail.com>
References: <20200427095559.16131-1-m.othacehe@gmail.com>
        <20200427095559.16131-2-m.othacehe@gmail.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 27 Apr 2020 11:55:55 +0200
Mathieu Othacehe <m.othacehe@gmail.com> wrote:

> The bytes returned by the i2c reading need to be swapped
> unconditionally. Otherwise, on be16 platforms, an incorrect value will be
> returned.

Missing sign off so I can't apply.  Also, please add an appropriate fixes
tag.

Once that's fixed I'll probably be a bit naughty with this one and
mark it for stable, but take it for the next merge window. Bug has been
there a while without anyone noticing so I don't mind delaying fixing it
a little longer to make it easier to merge the rest of the series.

Thanks,

Jonathan

> ---
>  drivers/iio/light/vcnl4000.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
> index 58e97462e803..e5f86bd00fb0 100644
> --- a/drivers/iio/light/vcnl4000.c
> +++ b/drivers/iio/light/vcnl4000.c
> @@ -219,7 +219,6 @@ static int vcnl4000_measure(struct vcnl4000_data *data, u8 req_mask,
>  				u8 rdy_mask, u8 data_reg, int *val)
>  {
>  	int tries = 20;
> -	__be16 buf;
>  	int ret;
>  
>  	mutex_lock(&data->vcnl4000_lock);
> @@ -246,13 +245,12 @@ static int vcnl4000_measure(struct vcnl4000_data *data, u8 req_mask,
>  		goto fail;
>  	}
>  
> -	ret = i2c_smbus_read_i2c_block_data(data->client,
> -		data_reg, sizeof(buf), (u8 *) &buf);
> +	ret = i2c_smbus_read_word_swapped(data->client, data_reg);
>  	if (ret < 0)
>  		goto fail;
>  
>  	mutex_unlock(&data->vcnl4000_lock);
> -	*val = be16_to_cpu(buf);
> +	*val = ret;
>  
>  	return 0;
>  

