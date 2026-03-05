Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9DB41799F
	for <linux-iio@vger.kernel.org>; Thu,  5 Mar 2026 00:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772669487; cv=none; b=Tfd7XNkx1kN6ElsSa0Ez5WZsicpcZKdsx+oWePgWfs56qKfWA7pgGC6aISe1tnXMPSlsM/pRltgYA5co9e8v5yvfgFzlK8ss8yQZl2F2OCxklkYk79Dq2/cWkRswbV6jnj4ULLWRrpS2UbU916WNC4QVrym8ANPCGOEW19Y68Es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772669487; c=relaxed/simple;
	bh=ReYvOkczpVQFeeKyuHhGik55MaCNLtaNhsNjs8HWBU0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LHfUK3E7RfsYIPAJ6gnKL+msIYklCioSt9XX+R+bd1bGWFQvXsdnJ8tphFREctU3iRq6V6dQo9SlVZhS8E2pbkH83sKgsvXq0qExrRg02UHhNIhmcFOFmwKny3j7Tj9RN2HtH1DSO8oBEqAAOpjkr3cFdRntPgt33DsI3UZ3JvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=qrUgrcrL; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="qrUgrcrL"
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-45f126d47b8so5465789b6e.2
        for <linux-iio@vger.kernel.org>; Wed, 04 Mar 2026 16:11:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1772669483; x=1773274283; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oA8O5ZwjNTNkBr8c/qYu7tjeiL/FihIILsf+2wRVrh0=;
        b=qrUgrcrL4rxPwc3+aN4gmqqXCRxC5y5elgDFzLK+chPfKZ8VI2X22yc+X8hQyVIG3L
         KGqglCuHGUQ9V9ie84KNG3MmFel6qhVZOl7fGJeOU150E6KrusYnpRzDlShwtWTw8eVL
         8FVNZwirLn7Ul9SVgc3OhUfoCn2HIc+xoJSr7uMKkdVKixrklSJGQ9x+SD+dlcqem5ea
         ocyZrv/bQ7JCrS8FsjkNxoaPrqbh9mHd/GDU4J5Zt+F+ddlP4qry91jWCQzKyYabTdxK
         P2BOe5OeMAQFA8gosN3WAWUW3RC8SxGnQC0bRKMgVatiXTwlHirs1ekLM56Ay0FgSD4k
         NMUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772669483; x=1773274283;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oA8O5ZwjNTNkBr8c/qYu7tjeiL/FihIILsf+2wRVrh0=;
        b=T6dR9mBuGJOc6SJxZAECG8bEtK5wSoHBkbjYo6IQDUXb0FF/MpirIcukFtno56ei/l
         iXdhvEG+PubhlsdETtbsAYyZQTXs7DZrrYq2GA4dRnEZTFvTvbVyWxh9hqFvjSgzq3+L
         auiRNLvTIDk7cgJpcwMvot4KCTzWfTFBXd0VWHfIR9CTxphkUIftxgJgmpxXrPvpk+Ay
         vpqklS0MpDjLhYw+p+xmQnBrht3Afa+7jJjbT7NoyjdAci48ardQGCzfedz7R/9jWvZz
         HH/QRwHTqRKn7FvoTdf+6Q55A0uSeNmPX1m7PqZGlf6nyEKkNdwB42T+P20qsp8aNCdn
         hHjg==
X-Forwarded-Encrypted: i=1; AJvYcCWk7ReUUL8mQ2MVAWkTSbXoIAzkbNMcVsIxdSEDnwe02nptGm4K1m4SrjAiOXQhYbUEC7FIt5qSVyA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyyoa96VjsfWZXpEb/O35kXakUfFt+0zEGHl+BLkR4334kZz6M9
	qHLjMzr8tZFWJtIsunYbBBAfDiY+366hMt/pUrB5lQr3kXpBY+44SmEC7f8+FgorRH0jwuPx6cX
	Dq/pR
X-Gm-Gg: ATEYQzxauOgnBBL3wpQbFEPuBrjYzrOFG5yli+/sGygxiFrIyXRf1KxhCwiuRpVrvG1
	MjFsAiTloYhwQ9mjqCK0YKn+tF9IRHy3pL0bQ8+8C8zX3XUm3HMq5rQXwWBNRlAdBSoVJ9mKQ/M
	XFMqQYE7BgiyeIo1Fqt4JfX8srPDX1aBQbkdqlVEEyQUrUDkb+b5hcl2MJjh4okfH11uYBT7BN1
	FTzscKgs3b8OfbQuKhHcSBttV9G2HHrh5o1SMxiSuPaYioDitqodc5P0uFPyhQHCezBZ8ruBs5z
	7h9HC2XJJno9anJ6UpkQjjNo0I1KuB0XDmNBmQ//PONl6FRj58XxaPHpyJINRmsk1ztdHxEL8AH
	cwTQ2wx929BAso7h9qycKMM0il6389cukb2lZXhfAxzEswxUzhWlktS++ftZxA2QWNXUuOesUaI
	27gXrLB2CG0v9VowJjTx1W5DFvtIXCV240K2i43z0Ij+rFaSvN4DaUykUUlZmlOTwBh8hd4k3WU
	g==
X-Received: by 2002:a05:6808:4feb:b0:45e:fd68:3de4 with SMTP id 5614622812f47-4651a95886cmr2129187b6e.0.1772669483626;
        Wed, 04 Mar 2026 16:11:23 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:d719:8353:352f:b2e0? ([2600:8803:e7e4:500:d719:8353:352f:b2e0])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-464bb5d0a8csm12246284b6e.14.2026.03.04.16.11.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Mar 2026 16:11:23 -0800 (PST)
Message-ID: <0024f138-a8f6-48a2-a68e-a8c36e542b5a@baylibre.com>
Date: Wed, 4 Mar 2026 18:11:22 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: temperature: add ADI MAX30210
To: John Erasmus Mari Geronimo <johnerasmusmari.geronimo@analog.com>,
 linux-iio@vger.kernel.org, jic23@kernel.org
Cc: nuno.sa@analog.com, andy@kernel.org, linux-kernel@vger.kernel.org
References: <20260304122509.67931-1-johnerasmusmari.geronimo@analog.com>
 <20260304122509.67931-2-johnerasmusmari.geronimo@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260304122509.67931-2-johnerasmusmari.geronimo@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/4/26 6:25 AM, John Erasmus Mari Geronimo wrote:
> Add device tree binding documentation for the Analog Devices
> MAX30210 temperature sensor.
> 
> Signed-off-by: John Erasmus Mari Geronimo <johnerasmusmari.geronimo@analog.com>
> ---
>  .../iio/temperature/adi,max30210.yaml         | 62 +++++++++++++++++++
>  MAINTAINERS                                   |  7 +++
>  2 files changed, 69 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/temperature/adi,max30210.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/temperature/adi,max30210.yaml b/Documentation/devicetree/bindings/iio/temperature/adi,max30210.yaml
> new file mode 100644
> index 000000000000..66867880a20f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/temperature/adi,max30210.yaml
> @@ -0,0 +1,62 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright 2026 Analog Devices Inc.
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/temperature/adi,max30210.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices MAX30210 Temperature Sensor
> +
> +maintainers:
> +  - John Erasmus Mari Geronimo <johnerasmusmari.geronimo@analog.com>
> +
> +description: |
> +  The MAX30210 is a temperature sensor with an I2C interface.
> +  https://www.analog.com/media/en/technical-documentation/data-sheets/max30210.pdf
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,max30210
> +
> +  reg:
> +    maxItems: 1
> +
> +  vdd-supply:
> +    description: Analog supply voltage input.

The description makes it sound like there could be other supplies,
but there aren't. It is the "everything" supply, so we can just
call it the power supply.

> +
> +  powerdown-gpios:
> +    description: GPIO connected to the CVT/PDB pin (active low).
> +    maxItems: 1
> +
> +  interrupts:
> +    description: Connected to INT pin. Interrupt triggered on both rising and falling edges.
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - vdd-supply
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        temperature-sensor@40 {
> +            compatible = "adi,max30210";
> +            reg = <0x40>;
> +            vdd-supply = <&vdd>;
> +            powerdown-gpios = <&gpio 12 GPIO_ACTIVE_LOW>;
> +
> +            interrupt-parent = <&gpio>;
> +            interrupts = <17 IRQ_TYPE_EDGE_BOTH>;
> +        };
> +    };
> +...
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1c75276404df..09345b9f32ed 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1638,6 +1638,13 @@ W:	https://ez.analog.com/linux-software-drivers
>  F:	Documentation/devicetree/bindings/iio/dac/adi,max22007.yaml
>  F:	drivers/iio/dac/max22007.c

It looks like MAX22007 is not in alphabetical order. Let's fix it
first so we can put this new one in the right place.

>  
> +ANALOG DEVICES INC MAX30210 DRIVER
> +M:	John Erasmus Mari Geronimo <johnerasmusmari.geronimo@analog.com>
> +L:	linux-iio@vger.kernel.org
> +S:	Supported
> +W:	https://ez.analog.com/linux-software-drivers
> +F:	Documentation/devicetree/bindings/iio/temperature/adi,max30210.yaml
> +
>  ANALOG DEVICES INC ADA4250 DRIVER
>  M:	Antoniu Miclaus <antoniu.miclaus@analog.com>
>  L:	linux-iio@vger.kernel.org

