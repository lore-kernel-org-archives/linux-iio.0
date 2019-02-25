Return-Path: <SRS0=UDTk=RA=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DED50C4360F
	for <linux-iio@archiver.kernel.org>; Mon, 25 Feb 2019 21:45:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC31920652
	for <linux-iio@archiver.kernel.org>; Mon, 25 Feb 2019 21:45:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551131121;
	bh=OrMEaWOKJ1KKoLlQnim+NyCNlRJI/mi4WXMQ/XRLd6U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=JQhHMdI5ZRWlQMHrqjGF88kkzxDBCERoFYg/mCopPMJERz6j5LpMflQ/qEke3/P79
	 GQxPT3IACU+3ytL2O08gAFUTWHJXkWLvGFsBwHP51b7sNu9f4DE81uHst7nKDxY5FB
	 uj6ZVLiGpkk0fIQ0w5MD3j5m8nLwkcfQ170jtqjc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729834AbfBYV3W (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:29:22 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:38654 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729111AbfBYV3R (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 25 Feb 2019 16:29:17 -0500
Received: by mail-oi1-f193.google.com with SMTP id q81so8563353oic.5;
        Mon, 25 Feb 2019 13:29:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oEm2I/RzozCs4QQvh3z+zp7aPsoDhy9f6U+iD0QDs7A=;
        b=pJb8VNLlGtJN9PdMehRG5swo16gGuwdwQTqcEFv9cSoLs9Szoa0hW/2ajQvvOrHKym
         jsqYCYEZNrshmFwMAl5+HaMuocrEkMdwyLJMjB2aY/fExns4bRH0Y3fICCl6Id5GjcTR
         9icKYSZ47zQFqrDF/ueCfMS8c/F+O2ax2DCz6uUnnwf0kbLAQIXVQ4sxSxWx5ZVAPTZt
         thvYqbXeiIsOkwDm1Ct+kKVVYla2XQ0hWmL/tKltwcjpqNJ8CXB+BWdKHHvbs3q3y/6w
         fdPH32ZWJWdydd0U+nk16a2nciKRkfRJoqpv389dEeccSF9rAGye4Krw0fXH5bryRWV0
         2q8w==
X-Gm-Message-State: AHQUAuYLTZcoV4iHDzii9K4yR5/i6QZejjCSWITMWTGhn8II84C1SoM4
        E6e4rYY9xX+EmwgWcga4M90bkB0=
X-Google-Smtp-Source: AHgI3IZ4FAzSEVNUavrAuqhjbLD5MOeXET8Q4z7N1T1rSt+sQ6NevBVZYZ0qTnxdIMC7chLitG3aCg==
X-Received: by 2002:aca:ddd7:: with SMTP id u206mr261599oig.46.1551130156651;
        Mon, 25 Feb 2019 13:29:16 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 97sm5109421otn.39.2019.02.25.13.29.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Feb 2019 13:29:16 -0800 (PST)
Date:   Mon, 25 Feb 2019 15:29:15 -0600
From:   Rob Herring <robh@kernel.org>
To:     Rui Miguel Silva <rui.silva@linaro.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/5] iio: gyro: add DT bindings to fxas2100x
Message-ID: <20190225212915.GA15828@bogus>
References: <20190204170012.13617-1-rui.silva@linaro.org>
 <20190204170012.13617-2-rui.silva@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190204170012.13617-2-rui.silva@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Feb 04, 2019 at 05:00:08PM +0000, Rui Miguel Silva wrote:
> Add device tree bindings for the FXAS2100x gyroscope.
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
> +  - reg : the I2C address of the sensor
> +
> +Example:
> +
> +fxas2100x@20 {

gyroscope@20

in addition to what's already been mentioned.

> +	compatible = "nxp,fxas2100x"
> +	reg = <0x20>;
> +};
> -- 
> 2.20.1
> 
