Return-Path: <SRS0=pjyC=RR=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85D3EC43381
	for <linux-iio@archiver.kernel.org>; Thu, 14 Mar 2019 19:10:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FCAF2186A
	for <linux-iio@archiver.kernel.org>; Thu, 14 Mar 2019 19:10:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fM0X650E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726848AbfCNTKO (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Thu, 14 Mar 2019 15:10:14 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:38217 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726752AbfCNTKO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 14 Mar 2019 15:10:14 -0400
Received: by mail-lj1-f195.google.com with SMTP id x13so5810933ljj.5;
        Thu, 14 Mar 2019 12:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NoBys0XUH33gJCFy/NMWg7uT8bSItn2PQlbXrvK8T6Y=;
        b=fM0X650ETHan8MyhluPzDc0UTbfclGhONxac+ZCkA3SyyRou24gmEr6BNdwazt1BlK
         iBPXl40Hi2IICRyc/8U8aJ19+O/0d81UfMi5nFmOG/QdBZ8NOGrsZbKlsXUCuhnetUbj
         kwU7dxgEcl/tlVDe/zXZVB7iJEolQSdR7t33DJk1MlS901QM5OQ9G6M9CDx4LT/xWUNC
         AoWl09GorBiseAqsI2NYnqK1XfIpJUxvPULSdNwQIgjGmTUOSl6vC60HUnKHpIPFLc7H
         oyUXmwC4rbzOFOmlPeu6wOygIW6uNFRNQccHHwLMKiUf0pMi8aWRdGH89UO2qMAh4Xx1
         //Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NoBys0XUH33gJCFy/NMWg7uT8bSItn2PQlbXrvK8T6Y=;
        b=PKSeHLK7SkVT1jsr2S0FtvdwAZIaDvN1+njpU5GaSBW3B3AEoOxgTXo/NdQ2B4tzV7
         SuEz4OVXtKNMruF3ZR9V6V4c1yw9himJGTcWHgmBXk6Vrq+qGsUDyDEg24MGAxb30apy
         A3QkAPmr6oVxISLK9211EmA+SUMaK1kwd1xuNeODH3Imo0KZYzoFrdjWAe7Mr7mZKX/8
         rJBAJyika019y8QdV4dsQA2CNl1Puc2vzqP/M47WCuWsMdwlH8e4NEkyuV/4hmbtcp3v
         dROd8F78J7uTFBtiGqYXX3m7tDaMiANk5nP3ZbHz0JBdzluQ9u2UQdXc9PgPUZnowJis
         h4sQ==
X-Gm-Message-State: APjAAAWxslY8CXuoh1Kd31gr73bPgyr9TRDChkbLpyLF/7vjVv4FIIzx
        9KMtRce/7cy20UIO5qYCymE=
X-Google-Smtp-Source: APXvYqwKNTbnGByeSO62xYlvthidvquynA4O6dstjWO5frNYAxoLV0vOer/0pYnk+cDfwZahtxzUeA==
X-Received: by 2002:a2e:97d3:: with SMTP id m19mr5664585ljj.116.1552590612016;
        Thu, 14 Mar 2019 12:10:12 -0700 (PDT)
Received: from localhost (89-64-61-106.dynamic.chello.pl. [89.64.61.106])
        by smtp.gmail.com with ESMTPSA id g2sm1024522ljd.54.2019.03.14.12.10.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Mar 2019 12:10:10 -0700 (PDT)
Date:   Thu, 14 Mar 2019 20:09:45 +0100
From:   Tomasz Duszynski <tduszyns@gmail.com>
To:     Rui Miguel Silva <rui.silva@linaro.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Shawn Guo <shawnguo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 1/6] iio: gyro: add DT bindings to fxas21002c
Message-ID: <20190314190943.GB23693@arch>
References: <20190313184002.2501-1-rui.silva@linaro.org>
 <20190313184002.2501-2-rui.silva@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190313184002.2501-2-rui.silva@linaro.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Mar 13, 2019 at 06:39:57PM +0000, Rui Miguel Silva wrote:
> Add device tree bindings for the FXAS21002C gyroscope.
>
> Signed-off-by: Rui Miguel Silva <rui.silva@linaro.org>
> ---
>  .../bindings/iio/gyroscope/nxp,fxas21002c.txt | 26 +++++++++++++++++++
>  1 file changed, 26 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/gyroscope/nxp,fxas21002c.txt
>
> diff --git a/Documentation/devicetree/bindings/iio/gyroscope/nxp,fxas21002c.txt b/Documentation/devicetree/bindings/iio/gyroscope/nxp,fxas21002c.txt
> new file mode 100644
> index 000000000000..68b4cd283d1d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/gyroscope/nxp,fxas21002c.txt
> @@ -0,0 +1,26 @@
> +* NXP FXAS21002C Gyroscope device tree bindings
> +
> +http://www.nxp.com/products/sensors/gyroscopes/3-axis-digital-gyroscope:FXAS21002C
> +
> +Required properties:
> +  - compatible : should be "nxp,fxas21002c"
> +  - reg : the I2C address of the sensor or SPI chip select number for the
> +          device.
> +  - vdd-supply: phandle to the regulator that provides power to the sensor.
> +  - vddio-supply: phandle to the regulator that provides power to the bus.
> +
> +Optional properties:
> +  - reset-gpios : gpio used to reset the device, see gpio/gpio.txt
> +  - interrupts : device support 2 interrupts, INT1 and INT2.
> +                 See interrupt-controller/interrupts.txt

Mentioning supported irq flags seems to be fairy common across driver
bindings. At least one does not need to scan driver sources to find what is
supported.

One more thing. Your are using drive-open-drain property. Perhaps it's
worth mentioning it in this binding.

> +  - interrupt-names: should contain "INT1" or "INT2", the gyroscope interrupt
> +                     line in use.
> +
> +Example:
> +
> +gyroscope@20 {
> +	compatible = "nxp,fxas21002c";
> +	reg = <0x20>;
> +	vdd-supply = <&reg_peri_3p15v>;
> +	vddio-supply = <&reg_peri_3p15v>;
> +};
> --
> 2.20.1
>
