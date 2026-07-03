Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76506352C28
	for <linux-iio@vger.kernel.org>; Fri,  3 Jul 2026 20:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783111358; cv=none; b=JBKiWmKYMr505K5yBA465ILS+b5wh24LTOcZ2KX8PZEAUQ/L5aLC7dB3Y9wslb/TXU+0U6pGtoVjUw4PKE7F3t2xPN1/pu+zjGzirsWb0g/qW9fWXODJayPCJbpJH1Zfc6E/8o7y16hQ8RehhTYpAAiI3CRyLpFYoTLIPFQBhmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783111358; c=relaxed/simple;
	bh=Eqv7+V31VY/0AFwk6Of9l7MrPycwP1CheiV+bakSUis=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JsQk7VRJlnzqqjaOLmIeqHhAydpJ/ZHDMynaX3RaAlVRzULfJJ7LMyVOaWxixXihCWxAHHa6bon+aV+iYRDBbkUq+OXVFiGgYJnGUCPSe2ENoGhg7Gub5ICQ0Pn2Gbumd0YxT35OJ9LcSDpS0outuDGrf4JCMan4RmAA7pKzLb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=EnlIRSCw; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="EnlIRSCw"
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-44cd237446cso487298fac.1
        for <linux-iio@vger.kernel.org>; Fri, 03 Jul 2026 13:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1783111354; x=1783716154; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AJlO7KO6NzvLX9GqvLCqKw4zjECJWOBxuWDTUord5Kw=;
        b=EnlIRSCw8FPPcedvFuTf+xNu11mIcOCVqE0YpqYQxqh+xO9YpNMTRLcMThwi8eAdN3
         anLvTqDwOYG+FRrLBwKeWIJHWHgAjU2d+maK/3wbAVEh9YGDzsz3yecRxbXXE1RQLBCQ
         FCKEmQ2p9ePAMt5TdfJSPPC+IFBcynIv1brXIQgR/jcto+qDMBGS1lXbcajBIZQW5+/d
         glNbUyw1WJmK9VSv089qJe9LFOufnNlMH/C1+kKQ2Jqxm0DTnP0Um2RtamYOXkG/Ao2/
         7J+dWwWWuAhP9HxQhGmydpidcHhEsZ9wBmYSCVALSDZKbFfW0d7AIvKNcHiNqpOHHJ5I
         wpMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783111354; x=1783716154;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AJlO7KO6NzvLX9GqvLCqKw4zjECJWOBxuWDTUord5Kw=;
        b=cmOtenUn9Oe627OYszOH2rxMYxrX0W7cZCRQJ+vdcXYqv20GxuA8nBK/IKSf9rVmvQ
         dd9Tgqen+URWX2Ap1/VfB9800U8vTh6BePNiNvWjHBo5K7zxrdjyhp7lDDbC3WP1ddPm
         Q2sGqCEho9wgKrJebAJ78vACaPp+153b8WUkBKYsCQqf+0qyWLphR8SyFcQQm6q36wJO
         KTzVlRV3Rkv2F//eHFuYf+dUyK+XIzx+aEjFlM448arqaOOL/48UOxzIcbQvEqtMcdKf
         v1zIe6jmVsPzWkwymOmcrYKbmoqnslY4TJZcs2qiCgp+ZEdc3giO1tEOpImW10Ria+0U
         8cBA==
X-Forwarded-Encrypted: i=1; AHgh+RoI9Gcj6Y2LHGglwab0BdJMKBr/LfVy9MAMSygI+s52yKYdVLyQ0G5EQp2Tf8xaihO6VYEHjb1Ui78=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnL/2AXGGF53lrJjqqUy/4oAsCIDVnx97uIdmGIOyEFXWB/ldk
	z3dpBFQjg6TfyL5Ly00/TLAPtt35nSzUKpCxD//oKeIVN+nmV6TOfKLmi3C7o1cayJM=
X-Gm-Gg: AfdE7cmBCR+XhFn12C5cUxC6cjC+1mgAYBYf3Rn2fogLZSQb/RB8aD6fS2czSm55Pw1
	mO/1DSt+/Kn5tW5jcV7HOjEFdfZs09s4PZ5jH/2CBhow+uznMlvKKFAsT2NUhJ/3zO0HEytIQZg
	K1JNnjBfKFoueDGsmVjjEsxWoitQpBmVR6iyDtkywF6ZV9HUxKA0FHOSOiMPEhnRi2QjjtHqptE
	BChoFki5tWUbuTY/SDY44IXiFFbW74HoPWVI0OlGLrMG6k1bmz8gR0+mta4/sYBmIJDK8NAPqJu
	hRfzp2pcyDLLFIGEA9qzTJDRzrqS/XV8vu6XAVyGusbtaFrz0sYiYjGRLPaHHuXT/swJ6dfuWMj
	PY/dufoYSRegGbW8TWe4os9JIo8iHPr0j4v8XODaavHPr/U6Ge1uLOIJr//li3x2+jo9fFwPoOz
	/1B2z/omhqWxyiyyL5dcBVum4FZ3IeGg/yGIXWCfYINXiHvdKqMoZSXSmJkzxJP6Y=
X-Received: by 2002:a05:6870:1584:b0:448:558c:d8c7 with SMTP id 586e51a60fabf-44d183e0de2mr539088fac.37.1783111354455;
        Fri, 03 Jul 2026 13:42:34 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:6af9:a9d7:17b5:2644? ([2600:8803:e7e4:500:6af9:a9d7:17b5:2644])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-44cfb5db92dsm2878354fac.13.2026.07.03.13.42.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Jul 2026 13:42:33 -0700 (PDT)
Message-ID: <9768e9af-4ceb-4c07-ad85-4b7a62e81b6e@baylibre.com>
Date: Fri, 3 Jul 2026 15:42:33 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] dt-bindings: iio: adc: add maxim,max40080
To: Stefan Popa <stefan.popa@analog.com>, Jonathan Cameron <jic23@kernel.org>
Cc: =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Ciprian Hegbeli <ciprian.hegbeli@analog.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260703102941.1141341-1-stefan.popa@analog.com>
 <20260703102941.1141341-2-stefan.popa@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260703102941.1141341-2-stefan.popa@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/3/26 5:29 AM, Stefan Popa wrote:
> Add device tree bindings for the Maxim MAX40080 bidirectional
> current-sense amplifier with a 12-bit ADC and an I2C/SMBus interface.
> 
> Signed-off-by: Stefan Popa <stefan.popa@analog.com>
> ---
>  .../bindings/iio/adc/maxim,max40080.yaml      | 55 +++++++++++++++++++
>  1 file changed, 55 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/maxim,max40080.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/maxim,max40080.yaml b/Documentation/devicetree/bindings/iio/adc/maxim,max40080.yaml
> new file mode 100644
> index 0000000000000..4cda6cea6022e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/maxim,max40080.yaml
> @@ -0,0 +1,55 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/maxim,max40080.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Maxim MAX40080 bidirectional current-sense amplifier
> +
> +maintainers:
> +  - Ciprian Hegbeli <ciprian.hegbeli@analog.com>
> +  - Stefan Popa <stefan.popa@analog.com>
> +
> +description: |
> +  The MAX40080 is a high-precision, bidirectional current-sense amplifier with
> +  an integrated 12-bit ADC and an I2C/SMBus interface. It measures the voltage
> +  across an external shunt resistor and the input bus voltage, and stores the
> +  results in an internal FIFO.
> +
> +  Datasheet:
> +    https://www.analog.com/en/products/max40080.html
> +
> +properties:
> +  compatible:
> +    const: maxim,max40080
> +
> +  reg:
> +    maxItems: 1

Missing vdd-supply for power and interrupts for ALERT output.

> +
> +  "#io-channel-cells":
> +    const: 1
> +
> +  shunt-resistor-micro-ohms:
> +    description:
> +      Value of the current-sense shunt resistor connected between the IN+ and
> +      IN- inputs. Used to scale the reported current.
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        adc@20 {
> +            compatible = "maxim,max40080";
> +            reg = <0x20>;
> +            #io-channel-cells = <1>;
> +            shunt-resistor-micro-ohms = <100000>;
> +        };
> +    };

