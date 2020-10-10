Return-Path: <SRS0=sXLK=DR=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7707BC35268
	for <linux-iio@archiver.kernel.org>; Sat, 10 Oct 2020 22:57:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 330802075E
	for <linux-iio@archiver.kernel.org>; Sat, 10 Oct 2020 22:57:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1602370627;
	bh=RK3mSg3UX4zTOJGirJtJfigfLFSX4tQ66YyfihKPWq0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=hDJW9eQUtu0orHnY2xLYro+sfx7/dxj01o/mYH2zulk3pfCfHNoR+GBDEmKa6LeBP
	 SFbKPxCpJZdnyN9PvJrXiBqZCpySPH6PApD3dVaOefOIcE9YqH4vBpWvAhfC9Bh0aN
	 ma8v1tk7N/BKaaE37ng2sj+SXJbvy31UQ1EuyuoM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390368AbgJJW5G (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 10 Oct 2020 18:57:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:54884 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732189AbgJJTmt (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 10 Oct 2020 15:42:49 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2BDFA2222C;
        Sat, 10 Oct 2020 17:05:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602349554;
        bh=RK3mSg3UX4zTOJGirJtJfigfLFSX4tQ66YyfihKPWq0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lgdNQBBm5Q9DALcBRX7i049IJoFS9PHAlvQlT1JDOXB4LjoIJQXpexfaKTizLimoS
         TtFS/Fu3aXeQ59n+2IisrhBfKa0ISjqJEwMgxlcNW8wRmqgYNSPPkYnqS2NRkga+qJ
         zGwmtffYKUtZ12r7ConXt+NYk7kGHPr4ifuP/Cqg=
Date:   Sat, 10 Oct 2020 18:05:49 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rikard Falkeborn <rikard.falkeborn@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: accel: mma8452: Constify static struct
 attribute_group
Message-ID: <20201010180549.629f8102@archlinux>
In-Reply-To: <20200930232939.31131-1-rikard.falkeborn@gmail.com>
References: <20200930232939.31131-1-rikard.falkeborn@gmail.com>
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu,  1 Oct 2020 01:29:39 +0200
Rikard Falkeborn <rikard.falkeborn@gmail.com> wrote:

> The only usage of mma8452_event_attribute_group is to assign its address
> to the event_attrs field in the iio_info struct, which is a const
> pointer. Make it const to allow the compiler to put it in read-only
> memory. This was the only non-const static struct in drivers/iio.
> 
> Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
applied.

Thanks,

Jonathan

> ---
>  drivers/iio/accel/mma8452.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
> index bf1d2c8afdbd..b0176d936423 100644
> --- a/drivers/iio/accel/mma8452.c
> +++ b/drivers/iio/accel/mma8452.c
> @@ -1187,7 +1187,7 @@ static struct attribute *mma8452_event_attributes[] = {
>  	NULL,
>  };
>  
> -static struct attribute_group mma8452_event_attribute_group = {
> +static const struct attribute_group mma8452_event_attribute_group = {
>  	.attrs = mma8452_event_attributes,
>  };
>  

