Return-Path: <SRS0=RyTo=5Z=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB380C2BA2B
	for <linux-iio@archiver.kernel.org>; Thu,  9 Apr 2020 11:05:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1F3C20771
	for <linux-iio@archiver.kernel.org>; Thu,  9 Apr 2020 11:05:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gerhold.net header.i=@gerhold.net header.b="chGUEpHn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726583AbgDILFF (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Thu, 9 Apr 2020 07:05:05 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([85.215.255.25]:15215 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbgDILFF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 9 Apr 2020 07:05:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1586430304;
        s=strato-dkim-0002; d=gerhold.net;
        h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=JZtWUKSt/SSRJuXHNVjkglmAeQX7E7zzV3vHhB09VW0=;
        b=chGUEpHntb16dm8h1gVnLKFvqbWHU1w6NsIZQvqomGz+eEWj5sSIK7419u/YIBWK4S
        XB3J7D7+7MF5t99y/HWIotDV6h+3eaB++D7EmxJFI/hG8MtsCKqvEjo1OOmVhXXOkaf3
        vj1F54wqnEGUWpRF8j5qA3EwSJiGUC3xOW6UT/Mu8JxoSqj9CyhOskyIxToADEWWB6jR
        UTj4ZlxxEzB/IzaM0dGdo1KJcBZ9gVGjk3Cz+yVLbzM2KsEx1GUHQOqu2shhi/swJ/Du
        c0Als63JPcHr0bJVoFfxLG0KiM7j2DbrvBrLUN3aD1+hd/mhK2fBk1OK1w6vGBPmRyuJ
        QRIQ==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u26zEodhPgRDZ8j7Ic/HYoo="
X-RZG-CLASS-ID: mo00
Received: from gerhold.net
        by smtp.strato.de (RZmta 46.2.1 DYNA|AUTH)
        with ESMTPSA id u043b8w39B1uLf8
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Thu, 9 Apr 2020 13:01:56 +0200 (CEST)
Date:   Thu, 9 Apr 2020 13:01:52 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Alexandre Bard <alexandre.bard@netmodule.com>
Cc:     lorenzo.bianconi83@gmail.com, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: imu: st_lsm6dsx: Fix reading array out of bounds
Message-ID: <20200409110128.GA53758@gerhold.net>
References: <20200409085818.9533-1-alexandre.bard@netmodule.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200409085818.9533-1-alexandre.bard@netmodule.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Apr 09, 2020 at 10:58:18AM +0200, Alexandre Bard wrote:
> Former code was iterating through all possible IDs whereas only a few
> per settings array are really available. Leading to several out of
> bounds readings.
> 
> Line is now longer than 80 characters. But since it is a classic for
> loop I think it is better to keep it like this than splitting it.
> 
> Signed-off-by: Alexandre Bard <alexandre.bard@netmodule.com>
> ---
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> index 84d219ae6aee..be8882ff30eb 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> @@ -1350,7 +1350,7 @@ static int st_lsm6dsx_check_whoami(struct st_lsm6dsx_hw *hw, int id,
>  	int err, i, j, data;
>  
>  	for (i = 0; i < ARRAY_SIZE(st_lsm6dsx_sensor_settings); i++) {
> -		for (j = 0; j < ST_LSM6DSX_MAX_ID; j++) {
> +		for (j = 0; j < ARRAY_SIZE(st_lsm6dsx_sensor_settings[i].id); j++) {

id in st_lsm6dsx_settings is declared as:

	struct {
		enum st_lsm6dsx_hw_id hw_id;
		const char *name;
	} id[ST_LSM6DSX_MAX_ID];

so it's always ST_LSM6DSX_MAX_ID long
(additional entries are just zero-initialized).

Isn't ARRAY_SIZE(st_lsm6dsx_sensor_settings[i].id) == ST_LSM6DSX_MAX_ID
in this case?

>  			if (st_lsm6dsx_sensor_settings[i].id[j].name &&
>  			    id == st_lsm6dsx_sensor_settings[i].id[j].hw_id)
>  				break;
> -- 
> 2.20.1
> 
