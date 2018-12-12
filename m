Return-Path: <SRS0=Gvxw=OV=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 348DAC04EB8
	for <linux-iio@archiver.kernel.org>; Wed, 12 Dec 2018 03:58:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D69B120851
	for <linux-iio@archiver.kernel.org>; Wed, 12 Dec 2018 03:58:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=martingkelly-com.20150623.gappssmtp.com header.i=@martingkelly-com.20150623.gappssmtp.com header.b="aaY+HUx3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D69B120851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=martingkelly.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-iio-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726242AbeLLD6O (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Tue, 11 Dec 2018 22:58:14 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37820 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726218AbeLLD6O (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 11 Dec 2018 22:58:14 -0500
Received: by mail-pf1-f193.google.com with SMTP id y126so8199944pfb.4
        for <linux-iio@vger.kernel.org>; Tue, 11 Dec 2018 19:58:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=martingkelly-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=oyMZbGfLU7ZkX0Y8sVma2NvAvSi4yDbuHHJRLQKKFA0=;
        b=aaY+HUx33rEsELJX/wvyhNUOLW0mIYIx0bnnla2ubFC8Rt7kbPG0MQLpMA6P5ho57r
         mCXZbXBm9dE3QNywtWTV4tiYnv313rBgCfDXplUYRF6XAOplW6nt6k8bn3Q+T93JxBPw
         3+x1qlfO0ACTY1/eiytKRvZ8Vjq1WPlDNYQioa3ZbH3X+XR3Y3lNlo1lWvwMIQAauTQf
         JdXjvTwAjsmvC7lMfDP2AjG4u1babw/BcLDPtlWnZcNh7DobUxGLc7Yx9nWEyg1qxSZO
         4jmXE3EcLj3y2KpQILE55ZYrMssm+1K86ICAafegxjyPdR1N+XkynkVHLai6AbefjH13
         afCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oyMZbGfLU7ZkX0Y8sVma2NvAvSi4yDbuHHJRLQKKFA0=;
        b=h6xGd+3i1r5NHaen/WbLtGYGf9CoIDwcKXkGCV7+OTwiaRDyNC+BrffqnvPq5aEWuV
         xY5mZqIap+//MM2l7FIRSlb1mVZs1AYLD1L1eqt7kz1X/ojVNxQ2C+9PHyrKIKyF+6Ro
         MlCAoBbuY4Vx58fzQLZLicQoLv+yKtY5yrczbVT/xUrnIdK0YNtj6mXXYmdbNLguLI1E
         OcTpp+MyoSD7yaRCGHIXFx4JtSCGRwEtNwXM6T8JHt0Z5YYlM90tUeyHIncKtoHrXWCu
         IJ7TKd/Zr1GMxkNmoJmNWNJSnnIT3czrKUERzMZDNWXQMPAXZLDlRvxUzcwxUIKnSzpS
         ykfA==
X-Gm-Message-State: AA+aEWbA7T3FRTXXpkO/i18qBu/PJC2sjmwQWlSgDHn2hkv+T1Lfg9Em
        y/6zE0KvaMz2KSNIfk+JDb9k6Q==
X-Google-Smtp-Source: AFSGD/XF+wpQNDCjQoCkytKQTLMyU2YAQab4LvQm4l8VuFVMWaohGAiUSW9jOknLyV/paV7Y9o69Ow==
X-Received: by 2002:a63:94:: with SMTP id 142mr16615006pga.74.1544587093133;
        Tue, 11 Dec 2018 19:58:13 -0800 (PST)
Received: from [192.168.0.8] (71-212-23-165.tukw.qwest.net. [71.212.23.165])
        by smtp.gmail.com with ESMTPSA id p24sm31005054pfk.155.2018.12.11.19.58.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Dec 2018 19:58:12 -0800 (PST)
Subject: Re: [PATCH v2] iio: bmi160: use all devm functions in probe
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, Daniel Baluta <daniel.baluta@intel.com>
References: <20181210031455.2836-1-martin@martingkelly.com>
 <20181210211534.35aef897@archlinux>
From:   Martin Kelly <martin@martingkelly.com>
Message-ID: <6b821cc5-af11-8bf9-319c-65b62c90bca2@martingkelly.com>
Date:   Tue, 11 Dec 2018 19:58:11 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181210211534.35aef897@archlinux>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 12/10/18 1:15 PM, Jonathan Cameron wrote:
> On Sun,  9 Dec 2018 19:14:55 -0800
> Martin Kelly <martin@martingkelly.com> wrote:
> 
>> From: Martin Kelly <martin@martingkelly.com>
>>
>> Currently, we're using the devm version of some but not all functions.
>> Switch to the devm version of iio_triggered_buffer_setup and
>> iio_device_register to simplify the code a bit and decrease the chance of
>> bugs.
>>
>> Signed-off-by: Martin Kelly <martin@martingkelly.com>
> 
> Great little tidy up. Thanks.  One little tweak. You missed the header so
> I'll tidy that up as well.
> 
> Applied to the togreg branch of iio.git and pushed out as testing for
> the autobuilders to play with it.
> 
> 

Oh, I did miss a header. Good catch and thanks!
