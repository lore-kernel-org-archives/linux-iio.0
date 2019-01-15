Return-Path: <SRS0=ObhF=PX=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12EF2C43612
	for <linux-iio@archiver.kernel.org>; Tue, 15 Jan 2019 02:13:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D23F520659
	for <linux-iio@archiver.kernel.org>; Tue, 15 Jan 2019 02:13:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=martingkelly-com.20150623.gappssmtp.com header.i=@martingkelly-com.20150623.gappssmtp.com header.b="SdkO5qPz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727403AbfAOCN2 (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Mon, 14 Jan 2019 21:13:28 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:33502 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726886AbfAOCN2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 14 Jan 2019 21:13:28 -0500
Received: by mail-pl1-f195.google.com with SMTP id z23so541321plo.0
        for <linux-iio@vger.kernel.org>; Mon, 14 Jan 2019 18:13:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=martingkelly-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gMBIDsNAalFYB0850sa3IFqPi56CukaEtOrmWGkfXc8=;
        b=SdkO5qPzNnFbvz4dN99DL/+2rrzgL/lUsZstR5Da7hAVhdHnGwJ23ZIm6Thb8eaxT3
         T1zQNRovV1JyyUiMg2NE2MvSuR0W6sWA6OxiW7ovZ8AXHlPxLevC4CkT9YPARyy12Vjz
         7nKgAKimQWQkeomUMUMxr3Emm1mNWWc7T4kfdK1tAgX/Cb+RnO4B7OUYnDMr0n1EuyOU
         tw8pLYzKoiElzlJcEajsr0Kp0FBlcIAFL8GpmbGCVxewblbZpKGsd+2y0RQi1jjKghUz
         JQ01F3GDVU4zZ/RguTSS568NPc0CrwQZt0rpXysqZwh4P01h2//m6pmJKW0x+wmgOCal
         E/KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gMBIDsNAalFYB0850sa3IFqPi56CukaEtOrmWGkfXc8=;
        b=IdaDJRbtwlv8mEpX1KD91dtf7PPTOmT5jvAuiY94aHMPYet4A9NLVciRnwNKNSoNL6
         blHl9QMYGKHXOONWE535IQ92rbB02zMiACds7j9ezrbGL02AsvHZeB8BzNHWmVDrgMp0
         /CunFB4mm55xpHGeAxpV6WutGzh4CCLX5vix9gJKK0YfJLvnla6Ucdl/T06FrNkHlWMy
         +9EgLLP9uFUMINupy/1I6+Nlb3I3FwXug7XlNoJRyocibDxsnEuvbiJbMd16mtcCYTvC
         Lzh7v5vvJAUpuswXRCOfGZM4zFOr/ohcaufEDZNJmlla8TgmWvZDvL7nyeK/tp82arNZ
         bs0w==
X-Gm-Message-State: AJcUukcLv2D8Tibym69iUXzTtY7FE1vl5pOpDUmEN4pDL/8GuMX28w0H
        1FQAFjMz0fiGNWv0j66TTnYv1g==
X-Google-Smtp-Source: ALg8bN7EGIzWc4dfvJN6VZDDD63YCU0iC3oca+6e6qFOBFMuAaB63CQZY0/HqzIgSqI9EuGkjOUMpg==
X-Received: by 2002:a17:902:d68c:: with SMTP id v12mr1631184ply.4.1547518406903;
        Mon, 14 Jan 2019 18:13:26 -0800 (PST)
Received: from [192.168.0.8] (174-21-177-9.tukw.qwest.net. [174.21.177.9])
        by smtp.gmail.com with ESMTPSA id t21sm2283340pgg.24.2019.01.14.18.13.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Jan 2019 18:13:26 -0800 (PST)
Subject: Re: [PATCH 0/5] iio:bmi160: add drdy interrupt support
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>
References: <20190114035621.5252-1-martin@martingkelly.com>
From:   Martin Kelly <martin@martingkelly.com>
Message-ID: <0c8451a9-8d13-bcc1-a662-0d225c124618@martingkelly.com>
Date:   Mon, 14 Jan 2019 18:13:25 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190114035621.5252-1-martin@martingkelly.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 1/13/19 7:56 PM, Martin Kelly wrote:
> From: Martin Kelly <martin@martingkelly.com>
> 
> This patch series adds drdy interrupt support to the BMI160 IMU. It also updates
> the relevant DT bindings and does a little bit of related cleanup.
> 
> Martin Kelly (5):
>    iio:bmi160: add SPDX identifiers
>    iio:bmi160: add drdy interrupt support
>    dt-bindings: fix incorrect bmi160 IRQ note
>    dt-bindings:bmi160: add "BOTH" int pin type
>    iio:bmi160:snap timestamp closer to event
> 
>   .../devicetree/bindings/iio/imu/bmi160.txt         |  17 +-
>   drivers/iio/imu/bmi160/Makefile                    |   1 +
>   drivers/iio/imu/bmi160/bmi160.h                    |  13 +-
>   drivers/iio/imu/bmi160/bmi160_core.c               | 280 ++++++++++++++++++++-
>   drivers/iio/imu/bmi160/bmi160_i2c.c                |   8 +-
>   drivers/iio/imu/bmi160/bmi160_spi.c                |   6 +-
>   drivers/iio/imu/bmi160/bmi160_trigger.c            |  60 +++++
>   7 files changed, 360 insertions(+), 25 deletions(-)
>   create mode 100644 drivers/iio/imu/bmi160/bmi160_trigger.c
> 
> --
> 2.11.0
> 

I realized this patch series does not contain updated binding 
documentation for the added bmi160,int1-open-drain and 
bmi160,int2-open-drain keys. I assume there will be other review 
feedback, so I will add a patch for this in a v2 series.
