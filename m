Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20D67C433EF
	for <linux-iio@archiver.kernel.org>; Sat, 25 Jun 2022 12:39:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232704AbiFYMjR (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 25 Jun 2022 08:39:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232600AbiFYMjR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 25 Jun 2022 08:39:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 745B7205DC;
        Sat, 25 Jun 2022 05:39:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 25014B802C7;
        Sat, 25 Jun 2022 12:39:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AB26C341C6;
        Sat, 25 Jun 2022 12:39:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656160753;
        bh=ue66ldEhYTQrp4KMdBXRsriieCbu0xm5/IYYnW96NXg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fAs1ahaZVTfo7LGl5zKomrGPsqMJxnzhxleD08DPVUDg8srwjvmQRpQP++3QH0DJ3
         wFtsyL1komutwcyV3mQCzZVc2PO/t/nUndpbKCyRnBTe9iC55KZa8f+5ODhFas3+Rz
         AQ5007mWcMNMY4BjshrYNTF89pDnkob7O6arSp5sOP3Ju560pW0WR+cVpgcakUG3Uk
         o5+AmGDvqU0rmQHoVTszP0//kJG8LAhzw1TShUQMuXbRTVOn33AWFVXH4RNDmx5rs2
         ZzVkxfE/SV00ekr7lHAhLsxnwdWZjaPS8LQlG+29Q/8XWXXKwAHsoY4cQJK4OU8G7Y
         92nZS1JIYSYTg==
Date:   Sat, 25 Jun 2022 13:48:40 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Marcus Folkesson <marcus.folkesson@gmail.com>
Cc:     Kent Gustavsson <kent@minoris.se>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 09/10] iio: adc: mcp3911: make use of the sign bit
Message-ID: <20220625134840.1f91b141@jic23-huawei>
In-Reply-To: <20220625103853.2470346-9-marcus.folkesson@gmail.com>
References: <20220625103853.2470346-1-marcus.folkesson@gmail.com>
        <20220625103853.2470346-9-marcus.folkesson@gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 25 Jun 2022 12:38:52 +0200
Marcus Folkesson <marcus.folkesson@gmail.com> wrote:

> The device supports negative values as well.
> 
> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
This looks like a fix to me.  So fixes tag and move it to the start
of the series.

Jonathan

> ---
> 
> Notes:
>     v2:
>         - No changes
> 
>  drivers/iio/adc/mcp3911.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/iio/adc/mcp3911.c b/drivers/iio/adc/mcp3911.c
> index a0609d7663e1..a019264e73e3 100644
> --- a/drivers/iio/adc/mcp3911.c
> +++ b/drivers/iio/adc/mcp3911.c
> @@ -144,6 +144,8 @@ static int mcp3911_read_raw(struct iio_dev *indio_dev,
>  		if (ret)
>  			goto out;
>  
> +		*val = sign_extend32(*val, 23);
> +
>  		ret = IIO_VAL_INT;
>  		break;
>  

