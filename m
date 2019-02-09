Return-Path: <SRS0=Oq/L=QQ=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF050C282C4
	for <linux-iio@archiver.kernel.org>; Sat,  9 Feb 2019 20:12:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B18B121919
	for <linux-iio@archiver.kernel.org>; Sat,  9 Feb 2019 20:12:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O+Me3OgI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbfBIUMf (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 9 Feb 2019 15:12:35 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:42168 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726836AbfBIUMf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 9 Feb 2019 15:12:35 -0500
Received: by mail-lj1-f195.google.com with SMTP id l15-v6so5743220lja.9
        for <linux-iio@vger.kernel.org>; Sat, 09 Feb 2019 12:12:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RSvIFzS8z2PUoR/ineev0stzo78ffhXTsG6KSFYNsMI=;
        b=O+Me3OgIYBeJPjt8pdIeOLT2D7WnfeAoVkXlDWOvmIJWRfguJS+MDaE9LWZB+tczDl
         7b6E0D4h6XUuRAXEuX/ZAyv3QiatlB0IF3iUs9hI14MT0KQtp3RgukrDesQkzdCH2b+x
         6NnM6ATdymVdGvz258bsKgiN/6Sbgd9aZAMJXjTAXgZ0k1+7an7hyH3S/xwUNKc9cdw6
         UaUQkozYZwiSopX2yBuNT6oEuYDmEgHDAzv6WaxL9gY470ewBIJai70I1Z+zc/Do9Z9K
         RODG5H/veMjxCvIaeW0tY/luZMkYJsdMJLcW8RdoM8S2xSEMBM/kWoJMDh6uTrZwqAfi
         zfXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RSvIFzS8z2PUoR/ineev0stzo78ffhXTsG6KSFYNsMI=;
        b=oW3+72yXTjr2BHybiUUb9V8vfksIX05gvnUWc2Gzl0C5uJYgY1GsW/4gC3NJXrGL79
         /m0VDZnHkCynZQ+7K9ZqQQaq/j/PJR6DJweuVyh/hNggwEknmT3qM2Ud9lrRQ4cQo5Vn
         iunyFgeYlpWiA5Avag6ApFEU1iAqOMjimOBN9C89YzXo7PGnmSjDvIaCiTSs3OvCIK9o
         efEfEfW7k6yCuALRPtK5I5uDXXgAIq+zXYMSEmnYlA6k6kEnIoCrOgaLlN2BbaOYlU89
         rKMxvoCMqgd5zoD6ocMCCh8gMzlssLoSf1E0sAv/IailmuTaIfr6rjuCFrLVgN1BQ9IE
         fdPA==
X-Gm-Message-State: AHQUAubDmX7NWU9x7aIhqQCK05aMG0hYEm5Wrn61Ql1kIW6LhR8UuvG4
        /sPU/jtTT/XJ5pm9VyuOvJxuuSMd5DQ=
X-Google-Smtp-Source: AHgI3IbS1zDiG94CL9CxAhh3Jk+sfIe7/Zt8bx9Rvz8o32iwpqRxeMA2wZH+/NcykFfHSr3PsWncYg==
X-Received: by 2002:a2e:7f04:: with SMTP id a4-v6mr16995719ljd.156.1549743152780;
        Sat, 09 Feb 2019 12:12:32 -0800 (PST)
Received: from localhost (89-70-37-207.dynamic.chello.pl. [89.70.37.207])
        by smtp.gmail.com with ESMTPSA id 184sm1249436lfz.10.2019.02.09.12.12.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 09 Feb 2019 12:12:32 -0800 (PST)
Date:   Sat, 9 Feb 2019 21:12:10 +0100
From:   Tomasz Duszynski <tduszyns@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org,
        Andreas Brauchli <a.brauchli@elementarea.net>
Subject: Re: [PATCH] iio:chemical:sps30 Suppress some switch fallthrough
 warnings.
Message-ID: <20190209201209.GA19661@arch>
References: <20190209193934.64038cf4@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190209193934.64038cf4@archlinux>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Feb 09, 2019 at 07:39:34PM +0000, Jonathan Cameron wrote:
> Fixes warnings reported on linux-next but marking one path
> and adding an explicit return in the other.
>

Looks good.

Acked-by: Tomasz Duszynski <tduszyns@gmail.com>

> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Andreas Brauchli <a.brauchli@elementarea.net>
> ---
> I'd like to get this one into linux-next fairly quick so it anyone
> has time to do a quick sanity check it would be much appreciated!
>
>  drivers/iio/chemical/sps30.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/iio/chemical/sps30.c b/drivers/iio/chemical/sps30.c
> index 375df5060ed5..edbb956e81e8 100644
> --- a/drivers/iio/chemical/sps30.c
> +++ b/drivers/iio/chemical/sps30.c
> @@ -118,6 +118,7 @@ static int sps30_do_cmd(struct sps30_state *state, u16 cmd, u8 *data, int size)
>  	case SPS30_READ_AUTO_CLEANING_PERIOD:
>  		buf[0] = SPS30_AUTO_CLEANING_PERIOD >> 8;
>  		buf[1] = (u8)SPS30_AUTO_CLEANING_PERIOD;
> +		/* fall through */
>  	case SPS30_READ_DATA_READY_FLAG:
>  	case SPS30_READ_DATA:
>  	case SPS30_READ_SERIAL:
> @@ -295,6 +296,8 @@ static int sps30_read_raw(struct iio_dev *indio_dev,
>  				*val2 = 10000;
>
>  				return IIO_VAL_INT_PLUS_MICRO;
> +			default:
> +				return -EINVAL;
>  			}
>  		default:
>  			return -EINVAL;
> --
> 2.20.1
>
