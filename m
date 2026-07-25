Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C392735F193
	for <linux-iio@vger.kernel.org>; Sat, 25 Jul 2026 08:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784967134; cv=none; b=q196ybK0KKn+Lq15VDMZwcPCzS6ctCCyMab4Q33B8EtRKyCZmz9mIaTIV1navbkSkU7rU+AyLBdriyk4yqChhRqeBzbZ1hP1PO0Tjx9BPHyc8G0AE9RrEVFDLabFfF+hYYia35vVA8C9hPt5NP8vVud9vGDuZkuU+UNliKpSEcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784967134; c=relaxed/simple;
	bh=b3mINTHQtv2zBQQWidwSIYv1mOw4iSfkHVzuPqJpMuY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BQcyszG559j2YuNNKqztMPvHvYUdBbi6eyyLIEiYSEdKbagQydscqXqJnMNrnVVzBC/ynwzfMdoK9w9ti2HF9ddQZTouDF2jSB6hlI+oPl3aYBLGhTaDpfOrOE8J4qo+w5XHnsslPJogMS9pxHHCbO2o4+iEMzLiCMA5N8/cs1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LOASwlkT; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LOASwlkT"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-495437bb891so10665795e9.1
        for <linux-iio@vger.kernel.org>; Sat, 25 Jul 2026 01:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784967131; x=1785571931; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=G1XTqKHyp1mTZN9MChbQUL99Guwmopp4ygsT+DbcbKM=;
        b=LOASwlkThx8vKef1MJYi0TTbwUQxlCLZ148xzhyIZ3wea3YSRd4qvVHGSz03Dw63Kb
         mGiMYNTYr50VSX0MwX7o5nUjVzAU2UiHDv+ZbIkCd3iSjgsXPpL87m6T/ulO6K1bvbit
         MgOr+Feet1sgdl9jVH4Q5+fWEG6UUmEZe6Po8bMmWEEpCe2eTldbPqWSSMcsxYfH7boc
         68/0G1ERq8sOJXUbt9TUfnYjDvkYqhitH6NbS+Z42HJuWzd4CygyFpM9fojC5kjHHzk3
         L9z2irTySonsahKNz5gRZ7L7wrnOttFjboj6oSzGubpuHVjtHH1hDdnheV1u7q8FxN6G
         MZcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784967131; x=1785571931;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=G1XTqKHyp1mTZN9MChbQUL99Guwmopp4ygsT+DbcbKM=;
        b=k0sG+7+P3qspIsS+HI1FgtRzj3oEue89QYBveLJ2q5v/m+i5Ap38SDlYVsSZ02m8vL
         DmU/fWwJLwRWIQBu8xX3BoJiJNF/TRTf9CpmC6LJXSkqvZUibOkkSdvQSUd8ZBn5YaNi
         PBz/RkEQpqP0s8sSkoPUt05BKpQp/aDB5yd7yGchl0H4XMV8MLv8pjVSMxO7keLR1DsL
         /zdrb8+zoVLWksVBlMuNWO65a8KAdHl9faEHccuubAiYl1n1N2PupWDwc59RCtfvzMfI
         6OgbDD6wS95UW79C+7fUdTrWKI86ZUSLbAU/9vqG+5IqFIo0ZdJrovRSIN7dBOdqNdg0
         yPNw==
X-Forwarded-Encrypted: i=1; AHgh+RoS2zFaNK/6Ke1AYpm/kb8w1yNCkn98Muj9J1qND51+kJ1YvMQLREq0XJH+Gs64WwOT7WKcKxY4FVk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz78C4nQuR6PZRpswIYcaIrOFGE+lI/1eyvSR9IGwGUcnyF+zBv
	2tk9HXsCdJq500lbHCXFoIUokLGB3ZQOI108Ezin43sa28Z4ZJV5V/3g
X-Gm-Gg: AR+sD12VEPKkys/VnW/cwykfB56oyspI06HaJpptOnoDGXX4G6CETtBzyq7Uy8HG2gS
	huJibGRtB36mdWbLQCmkA2//PIWbBT/u2T8b0kQ/owd8Ff2SedchSDISUyu+MSHqm8fuZepFU6j
	ScjXWxdGK93Idq92Ma8aCkmm7dwOwgk3+CFQ+5+Ss/4c3GgycdXH/7hAyVpFzvw4SrBdwa0euCJ
	aUUteKwUrUkQsNCqs27zBr80p9snJ2VcuOuIbvl5q9ahGvrIDGWbZgDeAZVZP3ltSaq7V2q6Ziv
	qSPOWSKq7n5DiWqdJioxI70MQHqu5NFwOtK7vjHzUfqGHgVHNkJ7gcFWz8tyQ68cX8gytv8Mhxv
	5nPgur26We/y86kT90/gkARgyMTvS93yKITfqpZzbuSgy1q6VbNvtlVgvl6v1/s8/kga+Ffv4UM
	lMLTWJbGJ7KGPfOX5Fp2CYX5CdDrB1lm/qEKOr7W7XPiVC3v8jJBjIHRcflByUTTtBE54L+GNIR
	SAIZfXmMge8XYnLIGW6jLBF+4mUqxmIK5mdSKyfxkl94BXbxT9bTRjovb14ZZhVw8U+SoTj6ZM0
	bP2uasA3N8VVacJ04v92tisVDN++7oJY6HVwhgQeis9yXFqIaJUTEWE0mKz9X6MOtckoz+9ySNl
	SZAncxJxS+aI=
X-Received: by 2002:a05:600c:4f89:b0:495:501a:fcf8 with SMTP id 5b1f17b1804b1-496b5c7181emr17455845e9.9.1784967130814;
        Sat, 25 Jul 2026 01:12:10 -0700 (PDT)
Received: from systembl0wer (ip-86-49-244-181.bb.vodafone.cz. [86.49.244.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-496b499cc49sm57113005e9.9.2026.07.25.01.12.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jul 2026 01:12:10 -0700 (PDT)
Date: Sat, 25 Jul 2026 10:12:08 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: iio: dac: add support for mcp47a1
Message-ID: <20260725101208.06f60b70@systembl0wer>
In-Reply-To: <20260725000439.5ad6f4d1@jic23-huawei>
References: <20260721-mcp47a1-add-support-v1-0-da045a2567e3@gmail.com>
	<20260721-mcp47a1-add-support-v1-1-da045a2567e3@gmail.com>
	<20260725000439.5ad6f4d1@jic23-huawei>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 25 Jul 2026 00:04:51 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Tue, 21 Jul 2026 20:24:38 +0200
> Joshua Crofts <joshua.crofts1@gmail.com> wrote:
> 
> > The Microchip MCP47A1 is a 6-bit volatile Digital-to-Analog converted
> > which communicates via I2C.
> > 
> > Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
> > ---
> >  .../bindings/iio/dac/microchip,mcp47a1.yaml        | 56 ++++++++++++++++++++++
> >  MAINTAINERS                                        |  6 +++
> >  2 files changed, 62 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/dac/microchip,mcp47a1.yaml b/Documentation/devicetree/bindings/iio/dac/microchip,mcp47a1.yaml
> > new file mode 100644
> > index 000000000000..3322fca03b3a
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/dac/microchip,mcp47a1.yaml  
> 
> > +
> > +examples:
> > +  - |
> > +    i2c {
> > +          #address-cells = <1>;
> > +          #size-cells = <0>;
> > +
> > +          dac@2e {
> > +              compatible = "microchip,mcp47a1";
> > +              reg = <0x2e>;
> > +              vref-supply = <&vref_regulator>;
> > +              vdd-supply = <&vdd_regulator>;
> > +          };
> > +
> > +          dac@3e {
> > +              compatible = "microchip,mcp47a1";  
> Hi Joshua,
> 
> What is the advantage of the second example?  I'd drop it.
> 

Hi Jonathan,

Per the datasheet, the MCP47A1 can have two different I2C slave
addresses (0x2e and 0x3e), which allows two DACs to share the
same bus, something I thought would be good to illustrate in the
example.

-- 
Kind regards,
Joshua Crofts
