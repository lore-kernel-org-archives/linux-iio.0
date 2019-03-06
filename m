Return-Path: <SRS0=AU7e=RJ=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44458C43381
	for <linux-iio@archiver.kernel.org>; Wed,  6 Mar 2019 08:43:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2046A20675
	for <linux-iio@archiver.kernel.org>; Wed,  6 Mar 2019 08:43:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729064AbfCFIn1 (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Wed, 6 Mar 2019 03:43:27 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:36524 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbfCFIn1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 6 Mar 2019 03:43:27 -0500
Received: by mail-ed1-f66.google.com with SMTP id g9so9601892eds.3
        for <linux-iio@vger.kernel.org>; Wed, 06 Mar 2019 00:43:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Jk6odKMg/O/nSsls4wjhQaV1/5sByi0cTfR8gR1keOk=;
        b=o1mhqqLuZEyRozJ2Xbf1obNb8sOJVK1G96RF/YfovAPLWBlL6d1Wf0up2n3bD/qMgq
         oHjYpsIiiUHvzWtbxsIiFNQ70Tk4EdNXhim8G0nTdK1+XV9gIp74KJZRQLH9RE1oib+r
         qYTLh1X+3zkMW3HAYaHwz2/uaQTGiW7yODafi+jEVNi35jY10vFIgRh4xmFgaiy29O1t
         NCtHxtISxdn3jnVw16H82aBW7aosrTofxgQmKnlwg95YoVuyw0q1yeckAeHi8ENX+K6R
         7q7a+DuVKrxGbQVLyybCdV0zgak27a3525gxZI/MKIwuyaDSc7zjM+jjw+hZAMGnuwtD
         e9RA==
X-Gm-Message-State: APjAAAXv+1pXKrVinGfoxSilrxTX1xt0uxwEqw7c1oKTFYKII9rz5ypr
        iEDiM+jhYdhEi6fXwaltzhWjpw==
X-Google-Smtp-Source: APXvYqz9UrLPnN6IoYEvk7klLjV8Z6xyCIs21U4FvtisU9CY1LmZqLi6N7tMcn1pF5/P5YTVv+JInw==
X-Received: by 2002:a17:906:4347:: with SMTP id z7mr3164978ejm.190.1551861805562;
        Wed, 06 Mar 2019 00:43:25 -0800 (PST)
Received: from shalem.localdomain (546A5441.cm-12-3b.dynamic.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id t25sm279483eda.69.2019.03.06.00.43.24
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Mar 2019 00:43:24 -0800 (PST)
Subject: Re: [PATCH v3] io: accel: kxcjk1013: restore the range after resume.
To:     "Chen, Hu" <hu1.chen@intel.com>
Cc:     bo.he@intel.com, Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Stephan Gerhold <stephan@gerhold.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <23ced5ac-b0a0-7d87-76d7-bdec0c3e0e15@redhat.com>
 <20190306023224.23695-1-hu1.chen@intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <cac7810e-04df-8aca-fbd9-2433b544960c@redhat.com>
Date:   Wed, 6 Mar 2019 09:43:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190306023224.23695-1-hu1.chen@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,

On 06-03-19 03:32, Chen, Hu wrote:
> From: "he, bo" <bo.he@intel.com>
> 
> On some laptops, kxcjk1013 is powered off when system enters S3. We need
> restore the range regiter during resume. Otherwise, the sensor doesn't
> work properly after S3.
> 
> Signed-off-by: he, bo <bo.he@intel.com>
> Signed-off-by: Chen, Hu <hu1.chen@intel.com>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans



> ---
>   v3: Avoid unnecessary mutex_unlock (Hans).
>   v2: Handle return value independently (Jonathan).
> 
>   drivers/iio/accel/kxcjk-1013.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
> index 7096e577b23f..50f3ff386bea 100644
> --- a/drivers/iio/accel/kxcjk-1013.c
> +++ b/drivers/iio/accel/kxcjk-1013.c
> @@ -1437,6 +1437,8 @@ static int kxcjk1013_resume(struct device *dev)
>   
>   	mutex_lock(&data->mutex);
>   	ret = kxcjk1013_set_mode(data, OPERATION);
> +	if (ret == 0)
> +		ret = kxcjk1013_set_range(data, data->range);
>   	mutex_unlock(&data->mutex);
>   
>   	return ret;
> 
