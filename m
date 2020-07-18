Return-Path: <SRS0=77Uk=A5=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E9CAC433DF
	for <linux-iio@archiver.kernel.org>; Sat, 18 Jul 2020 14:40:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BD7E2076A
	for <linux-iio@archiver.kernel.org>; Sat, 18 Jul 2020 14:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595083205;
	bh=nvn1jkxHHeYYWEQoAjKg5uofe3fLSd64oTcVeFIWWM0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=igJnqEWzZugBybNImGhcoFIwYg45Lz1VGV6IfYlWv9gFAQKY5aQbvks5K086FhRws
	 Hgtz5yaIFmv5b58du9bXvnEFKZCuTTofU6Y2vXoPs9WjrFhFkyqwFGIuhBw5XWAmeE
	 S9MpHNY4NDHJa6CIrH+0pMvhX3Zty2QlRc82D/H8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbgGROkE (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 18 Jul 2020 10:40:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:60180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726798AbgGROkE (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 18 Jul 2020 10:40:04 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C858520684;
        Sat, 18 Jul 2020 14:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595083204;
        bh=nvn1jkxHHeYYWEQoAjKg5uofe3fLSd64oTcVeFIWWM0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=o8r+0ObtPAJmTRvOUxAuMKPAjOpO9G/4WFhdifT4R1z0WEhSQg2L2Act7vwLMmG6P
         zUGOKsPNNUybqCaKFFHlF75HePtOM6ljxenhS5uULWbSxfLiwH1kaFoGsfgc6JxQpX
         DRPK0a+c19ZfYQnNh5WhGtnpaH8ytxiBVCmXjBVM=
Date:   Sat, 18 Jul 2020 15:40:00 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH 10/30] iio: dummy: iio_simple_dummy: Add newline after
 function-end
Message-ID: <20200718154000.60e04716@archlinux>
In-Reply-To: <20200716135928.1456727-11-lee.jones@linaro.org>
References: <20200716135928.1456727-1-lee.jones@linaro.org>
        <20200716135928.1456727-11-lee.jones@linaro.org>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 16 Jul 2020 14:59:08 +0100
Lee Jones <lee.jones@linaro.org> wrote:

> Fixes the following checkpatch.pl warning(s):
> 
>  CHECK: Please use a blank line after function/struct/union/enum declarations
>  #46: FILE: drivers/iio/dummy/iio_simple_dummy.c:690:
>   }
>  +/*
>  total: 0 errors, 0 warnings, 1 checks, 22 lines checked
> 
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
Applied

> ---
>  drivers/iio/dummy/iio_simple_dummy.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iio/dummy/iio_simple_dummy.c b/drivers/iio/dummy/iio_simple_dummy.c
> index be66b26373723..cc4335963d0cf 100644
> --- a/drivers/iio/dummy/iio_simple_dummy.c
> +++ b/drivers/iio/dummy/iio_simple_dummy.c
> @@ -687,6 +687,7 @@ static int iio_dummy_remove(struct iio_sw_device *swd)
>  
>  	return 0;
>  }
> +
>  /*
>   * module_iio_sw_device_driver() -  device driver registration
>   *

