Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1731383C6E
	for <linux-iio@vger.kernel.org>; Wed,  2 Sep 2026 18:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788373926; cv=none; b=QWtl8m1VN1Dey+e1faYVQFFpUmnFXj7rlceEqwkW3utf2wWI2cJYM7veGVPgW/zVJKYdyDFtO2ufk/c4Z/9WSQhMBxIayjjl5xdm2Je/wZjmaN3LAJlSqn1f4av4rYKO8AqOxewthLuHq5wHdhTpiA3QtdlyrdfnNk1BF9N9ExA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788373926; c=relaxed/simple;
	bh=5SbQ4qVfDk+O3G5b8f8HVnIF2DIqTxp8g+oQUr1NxyA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tH8sRlBN8cXwqlJ/lBdjFWPm6BRab0W2COueP2sFSG+EwwxpPEFg1UB0+pYFEeRxBAVz7U9F2TQO4I3jf7eyLTphrinKL3JdrWatLploAqMtDIg6nvLIAKjLHIGSuZkQmEf6BySutjiPkKZigXnFuBVF0fkwOPAarfoo4TKhEAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=SWcF0QU6; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="SWcF0QU6"
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-46f53c8a5fbso374180fac.2
        for <linux-iio@vger.kernel.org>; Wed, 02 Sep 2026 11:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1788373919; x=1788978719; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yi0Sf+aTtT6rp3DHMlcGuCDc4NN0FWj4XsTs8T+XdFU=;
        b=SWcF0QU6RhZnqsXP8ya+9RlEFTJFGKOAhGTzhyd8dRoK4sJ0RBIvuZaKxeH3turVNU
         LlrL3sbfw33+m6Qul5qtdqataDzv64uyyrrF6F4QD0MENKQ5fyA3BugKklixuAsNNqsh
         nSPMl5fHJ1Xuwu6iPyUJbZYithVB34ymu5snpRxPsttu3/LtLw1vpmBSoPwHlD4Qaqo1
         HiFCuYmq3s8m0EHpwO7sANzRLNj0WMYqDqQY08YQRUpSG69OiZb6VL3q3COMwDesn5q3
         LB+Azsm334Aiu7/fevVoSCpHWkjPgMjtULV7rkg//5YjVYWpqG5VjYR6p1axnYNNFidb
         FmUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788373919; x=1788978719;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yi0Sf+aTtT6rp3DHMlcGuCDc4NN0FWj4XsTs8T+XdFU=;
        b=hR/y1n2ww7IxVR1hx5zuSUe7GId/ls7ozED3w8vjjoyMeypTz6kEwahDgePOBVPt4p
         u1g1Av171RyyRs34+ky01NIviR+zIWat0V5Xzqd7eN2o/LIsLm11AKq1JFlu14ummn7w
         +aEb50SwmGrl1n++y7U/YFib9xlVoD4Yh9wSGCi/8SwJ7BJ5/n6oBU3KN8OG6Cnfhg7N
         AZJbzKiEf9x59oMfsSgY+jJSPBnIBaQXl98jF3ePjHqoz4U21LH3tdGL4jgMBvz6Rqfg
         nCFtfJw2XHKEa0jevZGQMCZeXTKMtMfUnP8CfEuM63a32zVRkEkBATAkElE3Tpg0Oxnj
         IE9A==
X-Forwarded-Encrypted: i=1; AHgh+Rr6Dyv6JhevowAdB0yEa6qJqHONjfm+TlYqdNaMNs9IXVosjEU0xoZwrSbT8snNgbgRLol59Fr1ItA=@vger.kernel.org
X-Gm-Message-State: AFuF++n3pCe9opBgLWOliistozobMGeAnQHq7f1LmBmysi787oYquFft
	g7WCzTPi9XcwVVYdqAAPvimLfXlDW/jSwaz9O3OVJAyycV2IQ4Vc9vHVboGMa2i1lTc=
X-Gm-Gg: AYBFou0nxYdneNnKmHqf6AIMkGJG0KBinnX+JPGV0e0WYj/r+eQA2L5VfKwSc90/jjH
	DhcpVvcCUixBsUknTty9NXac0vP3e2qoME4on8U4EAzgFs8MMgfp8uyFZQXXwnJc70PMfNA6C4F
	ldP4r917cCckCo9wXQPPGCs1WoQAGs0bCF9aF7H+EFJK/ph0NKowwPw+LzrOpXZv+FPo5p6yCz6
	DYXAAxUZUJr6VnHQ8Ql2q0Q5i10alAcvDwEgsowG132vp6BMdb00YC8fUpFaFxwJuMspEmcOLrW
	5YaaN48Hz/FeSDCLMGDruVmNwhlmtjzK6DJkE3XrDJdyIKWdORqslqiKv1oHRXE50/Dv0aCxcJS
	64tYRXTlwa3qBwjRnRaVSJUEO1juUr0ITtMJolYfY+xK77QtgxxWztemyoUEUdzk4RG1H1BQipG
	Vx0meL1FkFCQuRVCtH8aIlLmWRl4taVzju46YWQZZHwArCJpvIvZPOVsbs893JiRyARNvzRavMN
	i2sDSZCgexEnlp0TGh3vCTAjzcTNuIgn70KT+iQ
X-Received: by 2002:a05:6870:440c:b0:46c:feb7:5443 with SMTP id 586e51a60fabf-46f8341bc02mr4883463fac.0.1788373919124;
        Wed, 02 Sep 2026 11:31:59 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:518a:9db8:615b:293f? ([2600:8803:e7e4:500:518a:9db8:615b:293f])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-46f32933b9asm4606620fac.9.2026.09.02.11.31.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Sep 2026 11:31:58 -0700 (PDT)
Message-ID: <60dc58c6-dfe2-4377-9a73-f65cda56179c@baylibre.com>
Date: Wed, 2 Sep 2026 13:31:57 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: adc: ti,ads1015: Add label
 property
To: Flaviu Nistor <flaviu.nistor@gmail.com>,
 Jonathan Cameron <jic23@kernel.org>, Nuno Sa <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Daniel Baluta <daniel.baluta@nxp.com>,
 Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org
References: <20260902172230.5234-1-flaviu.nistor@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260902172230.5234-1-flaviu.nistor@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/2/26 12:22 PM, Flaviu Nistor wrote:
> Add support for an optional label property per channel similar to other adc
> chips. This allows assigning distinct names for each channel which can
> match the schematic signal name.
> 
> Signed-off-by: Flaviu Nistor <flaviu.nistor@gmail.com>
> ---
>  Documentation/devicetree/bindings/iio/adc/ti,ads1015.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/ti,ads1015.yaml b/Documentation/devicetree/bindings/iio/adc/ti,ads1015.yaml
> index 718f633c6e04..777a75c21d7f 100644
> --- a/Documentation/devicetree/bindings/iio/adc/ti,ads1015.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/ti,ads1015.yaml
> @@ -66,6 +66,11 @@ patternProperties:
>            - minimum: 0
>              maximum: 7
>  
> +      label:
> +        $ref: /schemas/types.yaml#/definitions/string
> +        description:
> +          A descriptive name for this channel, like "vcc_ram" or "CH3".
> +

Apparently this chip has quite old dt-bindings. Normally, we would have
included adc.yaml to get this and other channel properties.

And we would have used diff-channels and single-channel from that to
describe which pins are associated with which channel rather than having
a magic number for reg. And the ti,datarate looks suspicious as sampling
frequency is usually we control at runtime.

Anyway, none of that is really relevant to this patch. We'll see what
Jonathan says about using adc.yaml here vs. adding a label property.

>        ti,gain:
>          $ref: /schemas/types.yaml#/definitions/uint32
>          minimum: 0
> @@ -125,6 +130,7 @@ examples:
>                  reg = <4>;
>                  ti,gain = <3>;
>                  ti,datarate = <5>;
> +                label = "CH3";
>              };
>          };
>      };

