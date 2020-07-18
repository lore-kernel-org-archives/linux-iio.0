Return-Path: <SRS0=77Uk=A5=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D1B8C433E2
	for <linux-iio@archiver.kernel.org>; Sat, 18 Jul 2020 14:36:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 344522076A
	for <linux-iio@archiver.kernel.org>; Sat, 18 Jul 2020 14:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595083011;
	bh=LOVA6bWlbvtzxOWrN1ippzAT/DsF8cYs8LZI8JmearI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=kKoaz0vNt5XneC1NYgOHK5QV/T3zafGsNEFmVha1gCt42IA2nVhuqF3Q51z0Oj8Yy
	 sZAY45HuAqoHp0/18MyK7YwjDUXJvOmbT4eLNzESLbeBxpEpTSlO7R8pynS6ERnVcz
	 CxXUCxBqPoTUqCrBNsW4IkO2FR/CRin7JzOG4F8E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbgGROgu (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 18 Jul 2020 10:36:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:59310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726574AbgGROgu (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 18 Jul 2020 10:36:50 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B86B120684;
        Sat, 18 Jul 2020 14:36:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595083010;
        bh=LOVA6bWlbvtzxOWrN1ippzAT/DsF8cYs8LZI8JmearI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=u8uEUPGnDZcv9pQ0uMO1h3KVXKrHSkOAud/4bHZZEWTldfBkO+9YpN4FppKE+1BxS
         5oc6IwQPZAKvdwI6d1KJjQvySavV0S30c4fcI/PmmHCFawJQw91fqldd6+OB7j+Gf1
         ejWrqZ7E++i0QsBXN34uW+BRp3YqnmD3hDIpp264=
Date:   Sat, 18 Jul 2020 15:36:46 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org,
        Michael Hennerich <Michael.Hennerich@analog.com>
Subject: Re: [PATCH 08/30] iio: dac: ad5380: Fix kerneldoc attribute
 formatting for 'lock'
Message-ID: <20200718153646.1c076801@archlinux>
In-Reply-To: <20200716135928.1456727-9-lee.jones@linaro.org>
References: <20200716135928.1456727-1-lee.jones@linaro.org>
        <20200716135928.1456727-9-lee.jones@linaro.org>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 16 Jul 2020 14:59:06 +0100
Lee Jones <lee.jones@linaro.org> wrote:

> Kerneldoc expects attributes/parameters to be in '@*.: ' format.
> 
> Fixes the following W=1 kernel build warning(s):
> 
>  drivers/iio/dac/ad5380.c:64: warning: Function parameter or member 'lock' not described in 'ad5380_state'
> 
> Cc: Michael Hennerich <Michael.Hennerich@analog.com>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
Applied.

> ---
>  drivers/iio/dac/ad5380.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/dac/ad5380.c b/drivers/iio/dac/ad5380.c
> index b37e5675f7162..fd3358cccc7c5 100644
> --- a/drivers/iio/dac/ad5380.c
> +++ b/drivers/iio/dac/ad5380.c
> @@ -51,7 +51,7 @@ struct ad5380_chip_info {
>   * @vref_reg:		vref supply regulator
>   * @vref:		actual reference voltage used in uA
>   * @pwr_down:		whether the chip is currently in power down mode
> - * @lock		lock to protect the data buffer during regmap ops
> + * @lock:		lock to protect the data buffer during regmap ops
>   */
>  
>  struct ad5380_state {

