Return-Path: <SRS0=hh5H=RH=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5859EC43381
	for <linux-iio@archiver.kernel.org>; Mon,  4 Mar 2019 09:17:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 339B12082F
	for <linux-iio@archiver.kernel.org>; Mon,  4 Mar 2019 09:17:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726275AbfCDJQ7 (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Mon, 4 Mar 2019 04:16:59 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:45012 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726269AbfCDJQ7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 4 Mar 2019 04:16:59 -0500
Received: by mail-ed1-f68.google.com with SMTP id b20so3606752edw.11
        for <linux-iio@vger.kernel.org>; Mon, 04 Mar 2019 01:16:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3QVCLm5iQKFGA8gH1slkcdVXsupDUT1byrelsmj7Nl4=;
        b=cnoRA5AJJJlfZw4jKC7KYVOegFhLk78fUUVYxyvjUyZZDzzYdRcTGlurHbYEXsKlix
         tiSDUA7a7ES0x9bR8ouyH9jByTRDIcB6dKOcHa7+YqjD1Ea2l2Llno/j/eD2oRIA5i04
         96XbtGj4xTJULbZmJvTNu75Fh7f65IhvdxY3fchFjrmlrQNR+qIQBpjRwEAbHkRBAFJt
         qxaqWO6WFA4SLy12an2+VY9BuYe+shFxh21Vqb8OGOlROkgA1R9zmK5C3+qmUlJo/cCh
         Gg3TT4tpX2OdXUu+RIcTKjxAgNFo2iZ4ZlaUUmiT/ZC+U/kH8CvwAPnyK+wgvcvreF/L
         uAsg==
X-Gm-Message-State: APjAAAXTPvfcSMuUJIJc8mF31Tx7PxstXaOMjwQ0uuPK6iPrb9TU9ZUR
        sK3kjHl71sggwMr0Ptsl3Xolyw==
X-Google-Smtp-Source: APXvYqy1+Y3eYQpQimszHRQg3sBE9HQw+btc7oJ8tl6VdindHCsu1VKIPbhlkG+TSyH0Q8Mbt4925g==
X-Received: by 2002:a50:eb0c:: with SMTP id y12mr14078704edp.237.1551691017725;
        Mon, 04 Mar 2019 01:16:57 -0800 (PST)
Received: from shalem.localdomain (546A5441.cm-12-3b.dynamic.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id gl18sm1091066ejb.49.2019.03.04.01.16.56
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Mar 2019 01:16:56 -0800 (PST)
Subject: Re: [PATCH v2] io: accel: kxcjk1013: restore the range after resume.
To:     "Chen, Hu" <hu1.chen@intel.com>
Cc:     bo.he@intel.com, Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Stephan Gerhold <stephan@gerhold.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190303161728.3571869e@archlinux>
 <20190304070556.24681-1-hu1.chen@intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <23ced5ac-b0a0-7d87-76d7-bdec0c3e0e15@redhat.com>
Date:   Mon, 4 Mar 2019 10:16:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190304070556.24681-1-hu1.chen@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,

On 04-03-19 08:05, Chen, Hu wrote:
> From: "he, bo" <bo.he@intel.com>
> 
> On some laptops, kxcjk1013 is powered off when system enters S3. We need
> restore the range regiter during resume. Otherwise, the sensor doesn't
> work properly after S3.
> 
> Signed-off-by: he, bo <bo.he@intel.com>
> Signed-off-by: Chen, Hu <hu1.chen@intel.com>

Thank you for the patch.

> ---
> Changes in v2:
> - Handle return value independently in resume callback.
> 
>   drivers/iio/accel/kxcjk-1013.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
> index 7096e577b23f..17837e26bcf2 100644
> --- a/drivers/iio/accel/kxcjk-1013.c
> +++ b/drivers/iio/accel/kxcjk-1013.c
> @@ -1437,6 +1437,11 @@ static int kxcjk1013_resume(struct device *dev)
>   
>   	mutex_lock(&data->mutex);
>   	ret = kxcjk1013_set_mode(data, OPERATION);
> +	if (ret < 0) {
> +		mutex_unlock(&data->mutex);
> +		return ret;
> +	}
> +	ret = kxcjk1013_set_range(data, data->range);
>   	mutex_unlock(&data->mutex);
>   
>   	return ret;


I'm not a fan of the extra unlock, IMHO it would be better to instead do:

  	mutex_lock(&data->mutex);
  	ret = kxcjk1013_set_mode(data, OPERATION);
	if (ret == 0)
		ret = kxcjk1013_set_range(data, data->range);
  	mutex_unlock(&data->mutex);

Regards,

Hans

