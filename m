Return-Path: <SRS0=dQzZ=QL=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D8DDC282C4
	for <linux-iio@archiver.kernel.org>; Mon,  4 Feb 2019 18:17:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3F992175B
	for <linux-iio@archiver.kernel.org>; Mon,  4 Feb 2019 18:16:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jLHSOe+p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728631AbfBDSQ7 (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Mon, 4 Feb 2019 13:16:59 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:43479 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727691AbfBDSQ7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 4 Feb 2019 13:16:59 -0500
Received: by mail-ot1-f67.google.com with SMTP id a11so1334016otr.10;
        Mon, 04 Feb 2019 10:16:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qu6CAEmEIFdD3Tilr8XaZabduP85zVRZJGZpqCPYLF0=;
        b=jLHSOe+p67bPO+10Qo3lp+aeT9A5oqdxkJvvbOIFghk0lX5RZJQzFRT6Pg/q/Z0y8o
         6NFTIWgyh4bvaA5sA4TWvKcdmW+9YDBnSRyUTuPGtzjnXm9hLgFgXd7NXT8fo9IbWmuJ
         GZMb7ZMCA82eB+W31zZMDDDWe1AudIlBhoAvoY4oxwuzNZCR2+EwYs5knoofOf28MCee
         i1q1o756oZS11O0Bb/yMmcniAzMnZqTyMWXBMT66itU/A+WJGOkNfAwe4m+oAZIxaS51
         SZknhAK+MZO1KDiNxE8v9L7sz5qQUi9PWQ3epFujpix+nRbyEnGgQ8xk4dtcNLsOPz2F
         v5fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qu6CAEmEIFdD3Tilr8XaZabduP85zVRZJGZpqCPYLF0=;
        b=IevxNskAjIf04qJHt78jOeDIxloN/nUC/RQqsQl4dKZGZENfH00em2K8A6cfmQVDjR
         UkvG6d7SNwKUlJ/ynLnpA/QEzk/NCRR4YVbC5vuAkEfIC7S2LVD3vvnyF4x/2Tq7oBoe
         rIAuYBq+thnFXIJ/Tm8nphDSSi++2CISGzWQ6ErAmGqhr3MAlFBzT6MyCYQpcEoj/dqC
         Qa5Sy4+iOVIeMW6wssZaLAZRbaAPTIpfmnPIZClOoTbtSmqIpkjFGmh6ajtE+S3qYX0E
         rA+RP/rHjyJl8MdfdWPAIfqNH/IUdflbSVh9qk3sxzrGj3LgfnWCTZ0e1AINnMlozYsU
         XAwA==
X-Gm-Message-State: AHQUAua0kiodhWEz+69aHEUNhhcEBJJNFdpYlMt+etyMJEoLXPlhhGNv
        bi2AzL4yxY+ybHc2+bRWWumLubaXf+6xtoP9ADttzmdZ
X-Google-Smtp-Source: AHgI3IbsCL2uNuyViqBtCJ6VwV2awIWC/pmJKjZv+1zAbFuH70y0TaVdfkcBPX4c4LD/+wucO7qt19d6bgUXzoblpFk=
X-Received: by 2002:aca:cdd0:: with SMTP id d199mr382483oig.266.1549304218333;
 Mon, 04 Feb 2019 10:16:58 -0800 (PST)
MIME-Version: 1.0
References: <20190204170012.13617-1-rui.silva@linaro.org> <20190204170012.13617-2-rui.silva@linaro.org>
In-Reply-To: <20190204170012.13617-2-rui.silva@linaro.org>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Mon, 4 Feb 2019 16:16:53 -0200
Message-ID: <CAOMZO5A80yZmE36s1QFX=8uuZ4ctdTVSUoJYUj49t2HcbOKCjQ@mail.gmail.com>
Subject: Re: [PATCH 1/5] iio: gyro: add DT bindings to fxas2100x
To:     Rui Miguel Silva <rui.silva@linaro.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Shawn Guo <shawnguo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        linux-iio@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Rui,

On Mon, Feb 4, 2019 at 3:25 PM Rui Miguel Silva <rui.silva@linaro.org> wrote:
>
> Add device tree bindings for the FXAS2100x gyroscope.

Please name it after the real part number: FXAS21002.

>
> Signed-off-by: Rui Miguel Silva <rui.silva@linaro.org>
> ---
>  .../bindings/iio/gyroscope/fxas2100x.txt           | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/gyroscope/fxas2100x.txt
>
> diff --git a/Documentation/devicetree/bindings/iio/gyroscope/fxas2100x.txt b/Documentation/devicetree/bindings/iio/gyroscope/fxas2100x.txt
> new file mode 100644
> index 000000000000..2aeef9aafec4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/gyroscope/fxas2100x.txt
> @@ -0,0 +1,14 @@
> +* NXP FXAS2100X Gyroscope device tree bindings
> +
> +http://www.nxp.com/products/sensors/gyroscopes/3-axis-digital-gyroscope:FXAS21002C
> +
> +Required properties:
> +  - compatible : should be "nxp,fxas2100x"

We usually don't put x in the end. Better put the real part number
instead: "nxp,fxas21002"


> +  - reg : the I2C address of the sensor

Please describe the VDD and VDDIO regulators as well in the
dt-bindings and also add support for enabling them in the driver.
