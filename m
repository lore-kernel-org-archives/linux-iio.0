Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87939C433ED
	for <linux-iio@archiver.kernel.org>; Sun,  9 May 2021 13:52:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55D2961421
	for <linux-iio@archiver.kernel.org>; Sun,  9 May 2021 13:52:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbhEINxw (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 9 May 2021 09:53:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:24052 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229602AbhEINxw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 9 May 2021 09:53:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620568368;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pQhCUclC3vWbKPwAxuypGCQXicMBFinzWK31CzO/npg=;
        b=UiUokIJWAvMCnxTe/PiXxa8gqOA2H7nR4u7oQJgy1oiFeBe68HLdKf3H0H0kDK0XX6J0Yu
        aPR2SJwG+d+LiXc0sdE1MDLweXGBVh12xslLhi/LpWuuD1R+WN3FKmDyVotJzgDjMglz3K
        L/9OECbyWnjVMmM2FQAw7CaOVK2RKTk=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-476-odItOdLvOX6JtyFsVr2rLw-1; Sun, 09 May 2021 09:52:47 -0400
X-MC-Unique: odItOdLvOX6JtyFsVr2rLw-1
Received: by mail-ed1-f72.google.com with SMTP id y15-20020aa7d50f0000b02903885ee98723so7499956edq.16
        for <linux-iio@vger.kernel.org>; Sun, 09 May 2021 06:52:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pQhCUclC3vWbKPwAxuypGCQXicMBFinzWK31CzO/npg=;
        b=Lt+w3xcGTZh2lVZMwGPrr8J9qwVUHSwIsAX58OGJfEwvaJI6EXIQm7NJ48dvB5impZ
         4t42z3Uwfshw+hZz6E9oNPMHkx84Z6aAx02Wxal7Ypv+oVLw1WjBZ8iG5UM3Ash7mlrO
         ujirenGWgtBsubx9A2qH2ghxFdJQ03Fq/vSFLMkZ44UnAteuugQeJWfmxgm6olZnQIA6
         7WcBsA4NA4wukTr2zkgp38ZdScfq5JyCpP+uS0Mk5kaS+k0PpdWgkFatqgtAZGCNnKP1
         gx0jkpWAUpF/Vj326d04Tx5ZKxTFpnfqN3FNl2u7Ay6AGkIvXY4PP7Adxh9lg/ms0le0
         kIHw==
X-Gm-Message-State: AOAM532ikk5qhjPWCfGHVRMvBKly7KlJcN2S9+JZM08JXpxvmehyf/NU
        gpLxXIYShI/gZxhJzKZDhR5tI1b4+Wnab+QxhZvvHkgCRM+HV1CegZY/VDgJv/Nt+6ir2qG1Exb
        MjwjHPuartE+5PQjc96qP
X-Received: by 2002:a17:906:82c2:: with SMTP id a2mr21175142ejy.84.1620568366005;
        Sun, 09 May 2021 06:52:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw8Xb2nbUX0usEZyP/Xc/zlPXx8OrAiHJBaDexVWB7gcYY7gVat0/Vl2ndXXu8uRLQvZFXrOg==
X-Received: by 2002:a17:906:82c2:: with SMTP id a2mr21175131ejy.84.1620568365855;
        Sun, 09 May 2021 06:52:45 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id w14sm8828021edj.6.2021.05.09.06.52.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 May 2021 06:52:45 -0700 (PDT)
Subject: Re: [PATCH 04/28] iio: accel: bmc150-accel: Balanced runtime pm + use
 pm_runtime_resume_and_get()
To:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Julia Lawall <Julia.Lawall@inria.fr>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20210509113354.660190-1-jic23@kernel.org>
 <20210509113354.660190-5-jic23@kernel.org>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <ab152f9b-f4b8-fefc-5d4b-81a6e91fed90@redhat.com>
Date:   Sun, 9 May 2021 15:52:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210509113354.660190-5-jic23@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,

On 5/9/21 1:33 PM, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> A call to pm_runtime_put_noidle() doesn't match any call that would
> result in a get().  It is safe because runtime pm core protects against
> the reference counter going 0, but it makes it harder to understand the
> code.
> 
> Whilst here use pm_runtime_resume_and_get() to tidy things up.
> The Coccinelle script didn't get this one due to more complex code
> structure.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Hans de Goede <hdegoede@redhat.com>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans


> ---
>  drivers/iio/accel/bmc150-accel-core.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/accel/bmc150-accel-core.c b/drivers/iio/accel/bmc150-accel-core.c
> index 62a164a7b852..43cfadf8f6b7 100644
> --- a/drivers/iio/accel/bmc150-accel-core.c
> +++ b/drivers/iio/accel/bmc150-accel-core.c
> @@ -389,7 +389,7 @@ static int bmc150_accel_set_power_state(struct bmc150_accel_data *data, bool on)
>  	int ret;
>  
>  	if (on) {
> -		ret = pm_runtime_get_sync(dev);
> +		ret = pm_runtime_resume_and_get(dev);
>  	} else {
>  		pm_runtime_mark_last_busy(dev);
>  		ret = pm_runtime_put_autosuspend(dev);
> @@ -398,9 +398,6 @@ static int bmc150_accel_set_power_state(struct bmc150_accel_data *data, bool on)
>  	if (ret < 0) {
>  		dev_err(dev,
>  			"Failed: %s for %d\n", __func__, on);
> -		if (on)
> -			pm_runtime_put_noidle(dev);
> -
>  		return ret;
>  	}
>  
> @@ -1836,7 +1833,6 @@ int bmc150_accel_core_remove(struct device *dev)
>  
>  	pm_runtime_disable(dev);
>  	pm_runtime_set_suspended(dev);
> -	pm_runtime_put_noidle(dev);
>  
>  	bmc150_accel_unregister_triggers(data, BMC150_ACCEL_TRIGGERS - 1);
>  
> 

