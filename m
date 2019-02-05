Return-Path: <SRS0=iTXR=QM=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34AFDC282CB
	for <linux-iio@archiver.kernel.org>; Tue,  5 Feb 2019 10:49:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 048C220844
	for <linux-iio@archiver.kernel.org>; Tue,  5 Feb 2019 10:49:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="RB+czyM6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbfBEKt0 (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Tue, 5 Feb 2019 05:49:26 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40303 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbfBEKt0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 5 Feb 2019 05:49:26 -0500
Received: by mail-wr1-f65.google.com with SMTP id p4so3051990wrt.7
        for <linux-iio@vger.kernel.org>; Tue, 05 Feb 2019 02:49:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=msXF0X0tV0ihye3Q+swp2zgfFKmrPdBgnLUXwrwVzOY=;
        b=RB+czyM6EoAfyB7G0BHIAOQJhCqGV88WIT0mrNETQFcYYiImVB1pwfc/QpuxZcpNsE
         XBY0uzJ3BLs4OytVSuBuofXnX+7HM8Rgy8iRJh6ATx9wJMdDAwQ4kO5V906MmMbIWh5A
         d+FPaBR+mbLtkfk27ViXrYMmnMkR3D0Bmq/xs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=msXF0X0tV0ihye3Q+swp2zgfFKmrPdBgnLUXwrwVzOY=;
        b=FUvwwBlJKEyhVZiEPSsT2O5HVkRLHtjfm/3SO5Zd6UPbDc7RgkKqxcytqR0fGZwxCb
         SUrzEpCIQyL+6Q3S1i1imEahC57XW+nkD2QBUnS0a5ZWH36+RPB8Q/ERm7Z19REFP1Ur
         ULztCTiVnV5nWtooPxQdhPF/OyJq+dqoNXRnSiYzkPxzbXVo7q6iieNG3m/3Gk8akCby
         OvO1TpKWlmh8gpj3BQ5IiTQ53ULoh7S2xYnoiSEIRigsnqhX1gVREoFO6uVRazsr0k0e
         Cv9Ny5gTqWD3fxQQJsAzln9C12Ls1PMypSRm2yIIXptyg5ROKHugiB8p74x4sySTlyPp
         1NhQ==
X-Gm-Message-State: AHQUAuZlDtXgfBu2CoGFhMyTLMJUr66N+rLj+AhzxAExDXWIuytswpy/
        rWaoTi/zst4KjyeQlUC22n3lcg==
X-Google-Smtp-Source: AHgI3IZUOLSHag9pLKWShq98K+nS9lmogFsGppOr34+m9maEHLWEt+x9iU6I7o6ob/XhifqafE4vxQ==
X-Received: by 2002:adf:f8c7:: with SMTP id f7mr2918464wrq.266.1549363764451;
        Tue, 05 Feb 2019 02:49:24 -0800 (PST)
Received: from arch-late (a109-49-46-234.cpe.netcabo.pt. [109.49.46.234])
        by smtp.gmail.com with ESMTPSA id y8sm14034814wmg.13.2019.02.05.02.49.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 05 Feb 2019 02:49:23 -0800 (PST)
References: <20190204170012.13617-1-rui.silva@linaro.org> <20190204170012.13617-2-rui.silva@linaro.org> <CAOMZO5A80yZmE36s1QFX=8uuZ4ctdTVSUoJYUj49t2HcbOKCjQ@mail.gmail.com>
User-agent: mu4e 1.0; emacs 27.0.50
From:   Rui Miguel Silva <rui.silva@linaro.org>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Shawn Guo <shawnguo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        linux-iio@vger.kernel.org,
        "open list\:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH 1/5] iio: gyro: add DT bindings to fxas2100x
In-reply-to: <CAOMZO5A80yZmE36s1QFX=8uuZ4ctdTVSUoJYUj49t2HcbOKCjQ@mail.gmail.com>
Date:   Tue, 05 Feb 2019 10:49:22 +0000
Message-ID: <m31s4m4ij1.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Oi Fabio,
Thanks for the review.

On Mon 04 Feb 2019 at 18:16, Fabio Estevam wrote:
> Hi Rui,
>
> On Mon, Feb 4, 2019 at 3:25 PM Rui Miguel Silva 
> <rui.silva@linaro.org> wrote:
>>
>> Add device tree bindings for the FXAS2100x gyroscope.
>
> Please name it after the real part number: FXAS21002.

Yeah, right now it supports the FXAS21002 but if someone wants to
support for example the FXAS21000 it will be easier and the naming
just there, the main differences are ranges. But as we here are
starting with the FXAS210002, I tend to agree.

>
>>
>> Signed-off-by: Rui Miguel Silva <rui.silva@linaro.org>
>> ---
>>  .../bindings/iio/gyroscope/fxas2100x.txt           | 14 
>>  ++++++++++++++
>>  1 file changed, 14 insertions(+)
>>  create mode 100644 
>>  Documentation/devicetree/bindings/iio/gyroscope/fxas2100x.txt
>>
>> diff --git 
>> a/Documentation/devicetree/bindings/iio/gyroscope/fxas2100x.txt 
>> b/Documentation/devicetree/bindings/iio/gyroscope/fxas2100x.txt
>> new file mode 100644
>> index 000000000000..2aeef9aafec4
>> --- /dev/null
>> +++ 
>> b/Documentation/devicetree/bindings/iio/gyroscope/fxas2100x.txt
>> @@ -0,0 +1,14 @@
>> +* NXP FXAS2100X Gyroscope device tree bindings
>> +
>> +http://www.nxp.com/products/sensors/gyroscopes/3-axis-digital-gyroscope:FXAS21002C
>> +
>> +Required properties:
>> +  - compatible : should be "nxp,fxas2100x"
>
> We usually don't put x in the end. Better put the real part 
> number
> instead: "nxp,fxas21002"

Yeah, agree.

>
>
>> +  - reg : the I2C address of the sensor
>
> Please describe the VDD and VDDIO regulators as well in the
> dt-bindings and also add support for enabling them in the 
> driver.

Will do.

---
Cheers,
	Rui


