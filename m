Return-Path: <linux-iio-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEDA7C7618D
	for <linux-iio@archiver.kernel.org>; Mon, 20 Mar 2023 09:58:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbjCTJ61 (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Mon, 20 Mar 2023 05:58:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjCTJ6N (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 20 Mar 2023 05:58:13 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C45A1ADCD;
        Mon, 20 Mar 2023 02:57:48 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id x36so11436290ljq.7;
        Mon, 20 Mar 2023 02:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679306261;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1LMXKG6NMIg0Gv3t+Wrwm5rwjc756Ivu7vADxQ5aP+M=;
        b=ezyEI/ZIzVBI1MidryinliabgVrgu7ypE2xwfafuPCEbULuACRxheKpTwCGOfHsigU
         E4r8eGd6yCeM+XKBT7YFKFle72sJHb2G+Q2D73gK49FXxi0UlAypBBNAAeXouJ6+fyg+
         InGhRlAUY2SG9KMPt/JBsDtF48u+DoHFoNnFgKS2k9qcH1VrqIWOpdha8sZn3tiIxF9L
         qclpOnNrj9nsWXVgB0QBubRk4lnXqvRLTcFgRXMAzgz5A7xiN77e7TEpOGTYI0//BI4k
         F9fFGUf+2hrnTgHi320i6Lt+Itk6bV+KwRpvAi+KWJ39FDwgEG6i92yg2ykefkAFLeiL
         k0oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679306261;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1LMXKG6NMIg0Gv3t+Wrwm5rwjc756Ivu7vADxQ5aP+M=;
        b=4BGg+bV8jUvNP3+F0ZpTMv5L1Mu2fuJYxQ4JTrigvv4Xiwly/ixMs/jX8K9iwqasrL
         OmX+iFKbYNUMdIxHPPAaJufss82bOL8jvaMDe13SWk7BMpWnbJneddryeFw6l1U/10yN
         yWHdhE/yL2dbu146hlvQabtkibHzzJUXnm9AJEkS3LvWEd/oJKWto6ABG2hcmq4SYASe
         CXt+EhPu0NWllhXqDvov1JoGq/KfxhiIjaiwvN9nCESKodEyxylN1g83g2TsveQNGhI7
         zeU8uLl4QQ4wChcVPb8RZUxF6U7tGFOkssMffYtDBTrVeJslQc4exgWT0/ZkzanFE9+Z
         GEDw==
X-Gm-Message-State: AO0yUKXRfNBFFjOVoItLZgx6M/CvyBM5SKLN5ZE+aQrFCQpK5mcuRXI3
        kPIt8L9o7fFi3NXoL9Fh4AI=
X-Google-Smtp-Source: AK7set9xnKXNuz3PdRLoQHBwasugNGtYGrqTBVWuEPm9OyIzVuSvykWJJGwAOMb4YmpP0Zu9nKmgpg==
X-Received: by 2002:a2e:9c46:0:b0:293:2bc6:d50b with SMTP id t6-20020a2e9c46000000b002932bc6d50bmr5385935ljj.18.1679306261065;
        Mon, 20 Mar 2023 02:57:41 -0700 (PDT)
Received: from ?IPV6:2001:14ba:16f3:4a00::1? (dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::1])
        by smtp.gmail.com with ESMTPSA id l15-20020a2e700f000000b002958a51df76sm1656708ljc.92.2023.03.20.02.57.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Mar 2023 02:57:40 -0700 (PDT)
Message-ID: <d7bf589e-edb8-aa18-0f14-cc7848b4428d@gmail.com>
Date:   Mon, 20 Mar 2023 11:57:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 3/3] iio: accel: Add support for Kionix/ROHM KX132
 accelerometer
Content-Language: en-US, en-GB
To:     Mehdi Djait <mehdi.djait.k@gmail.com>, jic23@kernel.org
Cc:     krzysztof.kozlowski+dt@linaro.org,
        andriy.shevchenko@linux.intel.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <cover.1679009443.git.mehdi.djait.k@gmail.com>
 <6f31fe7dbd142c01315891f6868ff75f7d7cde32.1679009443.git.mehdi.djait.k@gmail.com>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <6f31fe7dbd142c01315891f6868ff75f7d7cde32.1679009443.git.mehdi.djait.k@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 3/17/23 01:48, Mehdi Djait wrote:
> Add support for the basic accelerometer features such as getting the
> acceleration data via IIO. (raw reads, triggered buffer [data-ready] or
> using the WMI IRQ).
> 

Hi Mehdi,

I have nothing to say to this patch yet. Let's see how it looks like 
after the comments from Jonathan/Andy have been discussed/reworked :)

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

