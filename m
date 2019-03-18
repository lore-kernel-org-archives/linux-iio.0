Return-Path: <SRS0=+BiV=RV=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D0F5C43381
	for <linux-iio@archiver.kernel.org>; Mon, 18 Mar 2019 08:28:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5533F21738
	for <linux-iio@archiver.kernel.org>; Mon, 18 Mar 2019 08:28:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="N+gGoEKJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbfCRI2p (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Mon, 18 Mar 2019 04:28:45 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41212 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726449AbfCRI2p (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 18 Mar 2019 04:28:45 -0400
Received: by mail-wr1-f66.google.com with SMTP id p1so15937194wrs.8
        for <linux-iio@vger.kernel.org>; Mon, 18 Mar 2019 01:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=rIFeQKoeO4byL9tO4WbPEnnY0XxjbbPY8sZGQdRf22g=;
        b=N+gGoEKJ2bTfRdYJd276Y0FbZ8PdCK2/4ay3emvQS3dfwWM0RFQX1RIt+mwznOxjH2
         aPLES+397I/7UoWrYKj2Y/w5ip1cd95lwccUvGtPPkhifFUubjKocUslulV6KnN3tmwK
         YGSimsFvSJ0soRvKe9b1lGlx9RSiYLgMJhVZXg8aWY55d4zQr7Zsg8qmgrZFh8TsOS0k
         g5hNUquAS4fP6tlJS5/B9uAY8bVdG5uBkjse0Lv1QlWBpF7+hkNQumQ+57EU8toJplPS
         Z9Y4QE67esf3UlVmAcSFWse8jzAYH3dxr3ru990jBwUECYVdX6j+UCJwZdUXI83CKyd/
         3tSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=rIFeQKoeO4byL9tO4WbPEnnY0XxjbbPY8sZGQdRf22g=;
        b=tsqlEEupeh6LvTD/jA/Mj66J6ZEmP++QCK6tcAKRa8y6tU05F1ODFmXqvDIQIr9LQN
         LNjoh2EultqGvlZLXZDTuxKBn04sDmHNC4XbU8kA2RUjULFoBnqAKuBN7rwAlMsh00Ug
         NgKBLjvsi3IbmatcNnuYJ9JuM5vSWg3zQslqmK1USyMVv5G2eYdXA0ANUNCYWEiuaewz
         NDgLbhDgwpoTdRjwk6FRXyxG1lb4iRPcC5UTgTwmDq/51PyV4Vkk66VVIDMeKSusV/nf
         JmIlmAM0aFZZqoxllx9xppd4XWOZAPxgoPGN/gT5YYFLHtecxM36u7neH1KBJjL52qn4
         kiPg==
X-Gm-Message-State: APjAAAWY2G1ArDLHL5oG9qcpFgOkbJ6FtxHxxEyGoBl9LJbUOiY+2XmR
        SXGgDsPhM0UamqBO19ct98g+tw==
X-Google-Smtp-Source: APXvYqwaGfgHgxu2xeGD7vvO5hyyr4QAO4TuZluTVv7u+n67vGYI6pKSzjtVoigXaQO3WX1pTM4GKg==
X-Received: by 2002:adf:c543:: with SMTP id s3mr10573371wrf.192.1552897724016;
        Mon, 18 Mar 2019 01:28:44 -0700 (PDT)
Received: from arch-late (a109-49-46-234.cpe.netcabo.pt. [109.49.46.234])
        by smtp.gmail.com with ESMTPSA id o1sm4590958wrs.51.2019.03.18.01.28.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Mar 2019 01:28:42 -0700 (PDT)
References: <20190313184002.2501-1-rui.silva@linaro.org> <20190313184002.2501-2-rui.silva@linaro.org> <20190314190943.GB23693@arch>
User-agent: mu4e 1.0; emacs 27.0.50
From:   Rui Miguel Silva <rui.silva@linaro.org>
To:     Tomasz Duszynski <tduszyns@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Shawn Guo <shawnguo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 1/6] iio: gyro: add DT bindings to fxas21002c
In-reply-to: <20190314190943.GB23693@arch>
Date:   Mon, 18 Mar 2019 08:28:40 +0000
Message-ID: <m38sxcwpqf.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Tomasz,
On Thu 14 Mar 2019 at 19:09, Tomasz Duszynski wrote:
> On Wed, Mar 13, 2019 at 06:39:57PM +0000, Rui Miguel Silva 
> wrote:
>> Add device tree bindings for the FXAS21002C gyroscope.
>>
>> Signed-off-by: Rui Miguel Silva <rui.silva@linaro.org>
>> ---
>>  .../bindings/iio/gyroscope/nxp,fxas21002c.txt | 26 
>>  +++++++++++++++++++
>>  1 file changed, 26 insertions(+)
>>  create mode 100644 
>>  Documentation/devicetree/bindings/iio/gyroscope/nxp,fxas21002c.txt
>>
>> diff --git 
>> a/Documentation/devicetree/bindings/iio/gyroscope/nxp,fxas21002c.txt 
>> b/Documentation/devicetree/bindings/iio/gyroscope/nxp,fxas21002c.txt
>> new file mode 100644
>> index 000000000000..68b4cd283d1d
>> --- /dev/null
>> +++ 
>> b/Documentation/devicetree/bindings/iio/gyroscope/nxp,fxas21002c.txt
>> @@ -0,0 +1,26 @@
>> +* NXP FXAS21002C Gyroscope device tree bindings
>> +
>> +http://www.nxp.com/products/sensors/gyroscopes/3-axis-digital-gyroscope:FXAS21002C
>> +
>> +Required properties:
>> +  - compatible : should be "nxp,fxas21002c"
>> +  - reg : the I2C address of the sensor or SPI chip select 
>> number for the
>> +          device.
>> +  - vdd-supply: phandle to the regulator that provides power 
>> to the sensor.
>> +  - vddio-supply: phandle to the regulator that provides power 
>> to the bus.
>> +
>> +Optional properties:
>> +  - reset-gpios : gpio used to reset the device, see 
>> gpio/gpio.txt
>> +  - interrupts : device support 2 interrupts, INT1 and INT2.
>> +                 See interrupt-controller/interrupts.txt
>
> Mentioning supported irq flags seems to be fairy common across 
> driver
> bindings. At least one does not need to scan driver sources to 
> find what is
> supported.
>
> One more thing. Your are using drive-open-drain property. 
> Perhaps it's
> worth mentioning it in this binding.

Yeah, Thanks for the reviews, I will take them in account in v4.

---
Cheers,
	Rui

>
>> +  - interrupt-names: should contain "INT1" or "INT2", the 
>> gyroscope interrupt
>> +                     line in use.
>> +
>> +Example:
>> +
>> +gyroscope@20 {
>> +	compatible = "nxp,fxas21002c";
>> +	reg = <0x20>;
>> +	vdd-supply = <&reg_peri_3p15v>;
>> +	vddio-supply = <&reg_peri_3p15v>;
>> +};
>> --
>> 2.20.1
>>

