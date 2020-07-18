Return-Path: <SRS0=77Uk=A5=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35B35C433DF
	for <linux-iio@archiver.kernel.org>; Sat, 18 Jul 2020 14:58:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 044522076A
	for <linux-iio@archiver.kernel.org>; Sat, 18 Jul 2020 14:58:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595084280;
	bh=hKvCr4AE/jEmDRTSNmSFXQN9Dd46d5UMAR5bbi/AzGM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=xpGLZ6vsee8QczLqbkL7ISoLLp6Vw1RR74rsMFTBNs2YNImQGoZHjJZspg0BEtFtr
	 jj9IPC+G6vud4v+4IAKieEFN4wPaBzzlgYLAP3AEN+cTJ6lc5Nd7qyYUSKTxrZqsZZ
	 HSQwSiQZMz0zxf9ZNnj5UppAbTwvBKnMcG9pWePk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726344AbgGRO57 (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 18 Jul 2020 10:57:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:34686 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726175AbgGRO57 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 18 Jul 2020 10:57:59 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9DC1820656;
        Sat, 18 Jul 2020 14:57:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595084279;
        bh=hKvCr4AE/jEmDRTSNmSFXQN9Dd46d5UMAR5bbi/AzGM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=odkYeHTLn3kzs3hjb6douMOXwDsrL3yhR4MHP6StNpTGf2x3BS9KVsHvU0PT6NsM9
         C56YoeF0SK+Q+pKHPjRD8ulDgxghE3LSFWzzTNTlopF122BkyB+Jba+OVmGwLgdBBL
         SaiBbbtGH7OpW9+nZNCr41ssRqTO2XRbrrMDkbNc=
Date:   Sat, 18 Jul 2020 15:57:54 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org,
        Michael Hennerich <Michael.Hennerich@analog.com>
Subject: Re: [PATCH 14/30] iio: dac: ad5064: Value returned by
 ad5064_vref_name may not be 'const * const'
Message-ID: <20200718155754.1c04162b@archlinux>
In-Reply-To: <20200716135928.1456727-15-lee.jones@linaro.org>
References: <20200716135928.1456727-1-lee.jones@linaro.org>
        <20200716135928.1456727-15-lee.jones@linaro.org>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 16 Jul 2020 14:59:12 +0100
Lee Jones <lee.jones@linaro.org> wrote:

> Fixes the following W=1 kernel build warning(s):
> 
>  drivers/iio/dac/ad5064.c:790:8: warning: type qualifiers ignored on function return type [-Wignored-qualifiers]
>  790 | static const char * const ad5064_vref_name(struct ad5064_state *st,
>  | ^~~~~
> 
> Cc: Michael Hennerich <Michael.Hennerich@analog.com>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
Applied.

Thanks,

Jonathan

> ---
>  drivers/iio/dac/ad5064.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/dac/ad5064.c b/drivers/iio/dac/ad5064.c
> index d33642de9720e..303f6d1a5f311 100644
> --- a/drivers/iio/dac/ad5064.c
> +++ b/drivers/iio/dac/ad5064.c
> @@ -787,7 +787,7 @@ static const char * const ad5064_vref_names[] = {
>  	"vrefD",
>  };
>  
> -static const char * const ad5064_vref_name(struct ad5064_state *st,
> +static const char *ad5064_vref_name(struct ad5064_state *st,
>  	unsigned int vref)
>  {
>  	return st->chip_info->shared_vref ? "vref" : ad5064_vref_names[vref];

