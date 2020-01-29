Return-Path: <SRS0=yDeB=3S=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6CD7C33CB2
	for <linux-iio@archiver.kernel.org>; Wed, 29 Jan 2020 07:18:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A12D120720
	for <linux-iio@archiver.kernel.org>; Wed, 29 Jan 2020 07:18:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726091AbgA2HSP (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Wed, 29 Jan 2020 02:18:15 -0500
Received: from www381.your-server.de ([78.46.137.84]:55430 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbgA2HSP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 29 Jan 2020 02:18:15 -0500
Received: from sslproxy06.your-server.de ([78.46.172.3])
        by www381.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <lars@metafoo.de>)
        id 1iwhc1-0008Ma-Ko; Wed, 29 Jan 2020 08:18:09 +0100
Received: from [93.104.127.234] (helo=[192.168.178.20])
        by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1iwhc1-000236-CL; Wed, 29 Jan 2020 08:18:09 +0100
Subject: Re: [RESEND PATCH] iio: adc: ad7124: Add direct reg access
To:     Mircea Caprioru <mircea.caprioru@analog.com>, jic23@kernel.org
Cc:     Michael.Hennerich@analog.com, alexandru.ardelean@analog.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org
References: <20200129051435.15366-1-mircea.caprioru@analog.com>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <d5d1eb35-fb5f-07d6-e678-3c54709ea75f@metafoo.de>
Date:   Wed, 29 Jan 2020 08:18:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200129051435.15366-1-mircea.caprioru@analog.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.101.4/25709/Tue Jan 28 12:49:39 2020)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 1/29/20 6:14 AM, Mircea Caprioru wrote:
> From: Mircea <mircea.caprioru@analog.com>
> 
> This patch adds the posibility do read and write registers from userspace
> using the kernel debug direct register access option.

Typo: possibility

> 
> Signed-off-by: Mircea Caprioru <mircea.caprioru@analog.com>
[...]
>   
> +static int ad7124_reg_access(struct iio_dev *indio_dev,
> +			     unsigned int reg,
> +			     unsigned int writeval,
> +			     unsigned int *readval)
> +{
> +	struct ad7124_state *st = iio_priv(indio_dev);
> +	int ret;
> +
> +
> +	if (readval)
> +		ret = ad_sd_read_reg(&st->sd, reg, ad7124_reg_size[reg],
> +				     readval);
> +	else
> +		ret = ad_sd_write_reg(&st->sd, reg, ad7124_reg_size[reg],
> +				      writeval);

Needs a bounds check to make sure that reg is less then the number of 
entries in ad7124_reg_size.
