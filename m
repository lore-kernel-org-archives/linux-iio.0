Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA27C2749DF
	for <linux-iio@vger.kernel.org>; Tue, 23 Jun 2026 08:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782202163; cv=none; b=stYj2at9AEq7DxJpsKpf0Q/gm+Q8QkKvlk37HDKbbb5vGJtrbFBMFsUzLKVAem4bVh/49U6KwN847PXfluU0pUaBwubJ/t1kd+zaU+40RzeooFUBVNLzdTIZtgPkIsNEkg8twGaqWV/1O/WryJEE9dT2XOMFySdVHCdoGTLhzVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782202163; c=relaxed/simple;
	bh=MPCmAKkqeHTIWje3rRyG9MZV0BIqTQnKAkADHspGPlk=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iBYosg6tm3k0H/DhXiJ88Jd0WCUR3fRh6SnnczC0knn61ZMUxR8HOvOcFF5fuqXLujh6tj46SuMlFwdgAkHmIocvAAS+sPCx+UBzPYLf2t+jCIk0z4vnaSmfPnI4FA0klbiAuPpr+XL6A5wcbL8HYMJYOUXv2DcItCRR7FurPFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X7Y18Utu; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X7Y18Utu"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-697ce8cfe65so1942476a12.3
        for <linux-iio@vger.kernel.org>; Tue, 23 Jun 2026 01:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782202159; x=1782806959; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HBE10nkMH0DGX0PhbRc9aI2/6zrD4VSqmtFlG2MV5dU=;
        b=X7Y18Utuo60wjWEEXD6Zv4olQI4cRz8CNNzPjD6WgW22xl8f1bYz0aLz7GOn4JjPpR
         nMxhrQQoSoC4EeQugUetfTOJ7h8uVe4EsiHwyxNzesNT8wNOCNuIAeowNzw4v56oVmN0
         IqeGBMJKgxyzyRB3W0IhL7BReqU6HXw7BDBcFEGmPtOU0IgbujGH7dadXkZMkanmigWb
         PWh9Xmgufp32Szi8bXP0WuZkOrU/IjLzXr/JOoNnYmINLAv8GiZACOM3P0BW9qpHwsK6
         hew/otf2yqnVy2lJ225QyEBRry61O4QsR09ofSBAReweZb4uJtNPaQP0GCaJpX9rlDIp
         ekag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782202159; x=1782806959;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HBE10nkMH0DGX0PhbRc9aI2/6zrD4VSqmtFlG2MV5dU=;
        b=ZiY6shuw5KOAgYz9rtja/TVST5mY5lsQB6AU6rujZQX8E+vOpAWwMmkX9v/na4Xbi1
         Wdv3LzwuMUwh3NPuFaNKEnyjRY3jAsigE31yWxjRkq6kYEDRIkW58jOQA4UY/JW3xxh4
         CV0QrqtNx6RtQJqWs1maFNKe8sq4kHLCJvziJzxMh4N4Mt4JFvGbbCq0JNHAJwTwsxPq
         RilVB1hpx7+GgbA8uHSu9SLj2HmNC6zDgPRbhbNmvXjx/Ojr0tsA20tq0JaxyB4TSRFY
         O6ge+wX/A+2q12BR64VkSILjNeLw1bjtspF0KmdywJ4cVLUWZSo9sU14xjOG76QWq4Gz
         Xw+Q==
X-Forwarded-Encrypted: i=1; AFNElJ9CQj4x+SeOdhbx1TAd7sFhw5/xmzwLqbj70X0+HrmIamFSsSvuqIAc7uxqT/GGC1HmNrtRuuOGWHU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTCljhpGKGxJacGxo5TxRpYHzC9xmhMPziAtz3NMMi8eHIJKRp
	BPZD0GQyeBcHpV+/tHTota4rqSVmXveEfnU/t0qO6ntGCfut7VxdACtz
X-Gm-Gg: AfdE7cla0cFhj1jaVzMN2+Fa5YAKj8JtQivDVPGm+hnZ59/iNNDVy7wg0jdTJXk99ei
	SkC5W5prUlcNWLG1sMsg+yLHib2aWbikn/qqNbofPFOQG6SYXOGtW9tpDZ8t5ollOKc/YEPM5ka
	4zQ8R5OHrJuyG+UnVDp2gifUgASZreQDPBlM6dX39H5fNHfB3BK/Mt+PDK/xU+vws0orr+53ZAh
	uUJ8LDsy/rqI6PVmWZsiOTy2XgVXIdBJ5gTZ/vgXCzweLICOrSFXYpf4UBAgi5xBkeII5GRJnIY
	uaboP/Op9eDA7XeUxtFN8ojxWCqFfkC2SVdPaaj7XwJpjZJ9FrdNJ+4sG/dEqrtBziknva2hb3x
	C1uAjd1rr1sZp3xvzwowCltjkMKTJU46rsgJD8ynM/geYVVyUeu5Dc04vGMhZRmPzWMmxPuGxWD
	wx3NsaieiS/lpsudLl6aSpyPBekewQ+4eYCVp0AKCKb5PwrXu8zz0h0CT+Fus3XgiPIy8AlFJLc
	5v2CB7A9rP6CTYq0NfZnh1Drs6D
X-Received: by 2002:a05:6402:2793:b0:697:be0e:4b72 with SMTP id 4fb4d7f45d1cf-697dbacc392mr772587a12.1.1782202158604;
        Tue, 23 Jun 2026 01:09:18 -0700 (PDT)
Received: from RDEALENC-L01.ad.analog.com (24.206.116.103.netskope-rdns.com. [24.206.116.103])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6977be640a5sm3982054a12.26.2026.06.23.01.09.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 01:09:17 -0700 (PDT)
From: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
X-Google-Original-From: Rodrigo Alencar <rdealenc@rdealenc-l01.ad.analog.com>
Date: Tue, 23 Jun 2026 09:09:14 +0100
To: Nuno =?utf-8?B?U8Oh?= <noname.nuno@gmail.com>, 
	Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Conor Dooley <conor@kernel.org>, 
	Janani Sunil <jan.sun97@gmail.com>, Janani Sunil <janani.sunil@analog.com>, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	David Lechner <dlechner@baylibre.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 1/2] dt-bindings: iio: dac: Add AD5529R
Message-ID: <5guhkvoxhkzevjm4b45hhk3772akpnz3givr3gb56x5ywamzyf@oiycreun4y62>
References: <20260619-obstinate-polo-a230bef97fda@spud>
 <20260619-bunch-diocese-dd7805cc17ff@spud>
 <ajU73_TkKrSbqD4f@nsa>
 <20260619-concierge-doozy-9c161533c369@spud>
 <ajVlD-j0nIGrRVow@nsa>
 <20260621153330.79b6600c@jic23-huawei>
 <5u4dnsgxwcwie45f24cacyzf3dko4srhyyyhcpom6tsvhqtmpc@y7d7gmex6n7k>
 <ajkMBh-R_7pYaoAn@nsa>
 <pifhwgj3cp2vc7ia4m6penh52iekzjljrp75y5b7j57vvtooad@32wfqruiqqjl>
 <ajklksIDLsj0BZul@nsa>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ajklksIDLsj0BZul@nsa>

On 22/06/26 13:20, Nuno Sá wrote:
> On Mon, Jun 22, 2026 at 12:51:20PM +0100, Rodrigo Alencar wrote:
> > On 22/06/26 11:29, Nuno Sá wrote:
> > > On Mon, Jun 22, 2026 at 10:24:05AM +0100, Rodrigo Alencar wrote:
> > > > On 21/06/26 15:33, Jonathan Cameron wrote:
> > > > > On Fri, 19 Jun 2026 16:54:11 +0100
> > > > > Nuno Sá <noname.nuno@gmail.com> wrote:
> > > > > 
> > > > > > On Fri, Jun 19, 2026 at 03:12:07PM +0100, Conor Dooley wrote:
> > > > > > > On Fri, Jun 19, 2026 at 02:01:08PM +0100, Nuno Sá wrote:  
> > > > > > > > On Fri, Jun 19, 2026 at 12:40:54PM +0100, Conor Dooley wrote:  
> > > > > > > > > On Fri, Jun 19, 2026 at 12:36:55PM +0100, Conor Dooley wrote:  
> > > > > > > > > > On Fri, Jun 19, 2026 at 12:33:11PM +0200, Janani Sunil wrote:  
> > > > > > > > > > > 
> > > > > > > > > > > On 6/14/26 21:44, Jonathan Cameron wrote:  
> > > > > > > > > > > > On Tue, 9 Jun 2026 16:47:23 +0200
> > > > > > > > > > > > Janani Sunil <jan.sun97@gmail.com> wrote:
> > > > > > > > > > > >   
> > > > > > > > > > > > > On 5/26/26 15:11, Rodrigo Alencar wrote:  
> > > > > > > > > > > > > > On 26/05/19 05:42PM, Janani Sunil wrote:  
> > > > > > > > > > > > > > > Devicetree bindings for AD5529R 16 channel 12/16 bit high voltage,
> > > > > > > > > > > > > > > buffered voltage output digital-to-analog converter (DAC) with an
> > > > > > > > > > > > > > > integrated precision reference.  
> > > > > > > > > > > > > > ...
> > > > > > > > > > > > > > Probably others may comment on that, but...
> > > > > > > > > > > > > > 
> > > > > > > > > > > > > > This parent node may support device addressing for multi-device support through
> > > > > > > > > > > > > > those ID pins. I suppose that each device may have its own power supplies or
> > > > > > > > > > > > > > other resources like the toggle pins or reset and enable.
> > > > > > > > > > > > > > 
> > > > > > > > > > > > > > That way I suppose that an example would look like...  
> > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > +patternProperties:
> > > > > > > > > > > > > > > +  "^channel@([0-9]|1[0-5])$":
> > > > > > > > > > > > > > > +    type: object
> > > > > > > > > > > > > > > +    description: Child nodes for individual channel configuration
> > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > +    properties:
> > > > > > > > > > > > > > > +      reg:
> > > > > > > > > > > > > > > +        description: Channel number.
> > > > > > > > > > > > > > > +        minimum: 0
> > > > > > > > > > > > > > > +        maximum: 15
> > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > +      adi,output-range-microvolt:
> > > > > > > > > > > > > > > +        description: |
> > > > > > > > > > > > > > > +          Output voltage range for this channel as [min, max] in microvolts.
> > > > > > > > > > > > > > > +          If not specified, defaults to 0V to 5V range.
> > > > > > > > > > > > > > > +        oneOf:
> > > > > > > > > > > > > > > +          - items:
> > > > > > > > > > > > > > > +              - const: 0
> > > > > > > > > > > > > > > +              - enum: [5000000, 10000000, 20000000, 40000000]
> > > > > > > > > > > > > > > +          - items:
> > > > > > > > > > > > > > > +              - const: -5000000
> > > > > > > > > > > > > > > +              - const: 5000000
> > > > > > > > > > > > > > > +          - items:
> > > > > > > > > > > > > > > +              - const: -10000000
> > > > > > > > > > > > > > > +              - const: 10000000
> > > > > > > > > > > > > > > +          - items:
> > > > > > > > > > > > > > > +              - const: -15000000
> > > > > > > > > > > > > > > +              - const: 15000000
> > > > > > > > > > > > > > > +          - items:
> > > > > > > > > > > > > > > +              - const: -20000000
> > > > > > > > > > > > > > > +              - const: 20000000
> > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > +    required:
> > > > > > > > > > > > > > > +      - reg
> > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > +    additionalProperties: false
> > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > +required:
> > > > > > > > > > > > > > > +  - compatible
> > > > > > > > > > > > > > > +  - reg
> > > > > > > > > > > > > > > +  - vdd-supply
> > > > > > > > > > > > > > > +  - avdd-supply
> > > > > > > > > > > > > > > +  - hvdd-supply
> > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > +dependencies:
> > > > > > > > > > > > > > > +  spi-cpha: [ spi-cpol ]
> > > > > > > > > > > > > > > +  spi-cpol: [ spi-cpha ]
> > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > +allOf:
> > > > > > > > > > > > > > > +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > +unevaluatedProperties: false
> > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > +examples:
> > > > > > > > > > > > > > > +  - |
> > > > > > > > > > > > > > > +    #include <dt-bindings/gpio/gpio.h>
> > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > +    spi {
> > > > > > > > > > > > > > > +        #address-cells = <1>;
> > > > > > > > > > > > > > > +        #size-cells = <0>;
> > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > +        dac@0 {
> > > > > > > > > > > > > > > +            compatible = "adi,ad5529r-16";
> > > > > > > > > > > > > > > +            reg = <0>;
> > > > > > > > > > > > > > > +            spi-max-frequency = <25000000>;
> > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > +            vdd-supply = <&vdd_regulator>;
> > > > > > > > > > > > > > > +            avdd-supply = <&avdd_regulator>;
> > > > > > > > > > > > > > > +            hvdd-supply = <&hvdd_regulator>;
> > > > > > > > > > > > > > > +            hvss-supply = <&hvss_regulator>;
> > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > +            reset-gpios = <&gpio0 87 GPIO_ACTIVE_LOW>;
> > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > +            #address-cells = <1>;
> > > > > > > > > > > > > > > +            #size-cells = <0>;
> > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > +            channel@0 {
> > > > > > > > > > > > > > > +                reg = <0>;
> > > > > > > > > > > > > > > +                adi,output-range-microvolt = <0 5000000>;
> > > > > > > > > > > > > > > +            };
> > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > +            channel@1 {
> > > > > > > > > > > > > > > +                reg = <1>;
> > > > > > > > > > > > > > > +                adi,output-range-microvolt = <(-10000000) 10000000>;
> > > > > > > > > > > > > > > +            };
> > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > +            channel@2 {
> > > > > > > > > > > > > > > +                reg = <2>;
> > > > > > > > > > > > > > > +                adi,output-range-microvolt = <0 40000000>;
> > > > > > > > > > > > > > > +            };
> > > > > > > > > > > > > > > +        };
> > > > > > > > > > > > > > > +    };  
> > > > > > > > > > > > > > ...
> > > > > > > > > > > > > > 
> > > > > > > > > > > > > > 	spi {
> > > > > > > > > > > > > > 		#address-cells = <1>;
> > > > > > > > > > > > > > 		#size-cells = <0>;
> > > > > > > > > > > > > > 
> > > > > > > > > > > > > > 		multi-dac@0 {
> > > > > > > > > > > > > > 			compatible = "adi,ad5529r-16";
> > > > > > > > > > > > > > 			reg = <0>;
> > > > > > > > > > > > > > 			spi-max-frequency = <25000000>;
> > > > > > > > > > > > > > 
> > > > > > > > > > > > > > 			#address-cells = <1>;
> > > > > > > > > > > > > > 			#size-cells = <0>;
> > > > > > > > > > > > > > 
> > > > > > > > > > > > > > 			dac@0 {
> > > > > > > > > > > > > > 				reg = <0>;
> > > > > > > > > > > > > > 				vdd-supply = <&vdd_regulator>;
> > > > > > > > > > > > > > 				avdd-supply = <&avdd_regulator>;
> > > > > > > > > > > > > > 				hvdd-supply = <&hvdd_regulator>;
> > > > > > > > > > > > > > 				hvss-supply = <&hvss_regulator>;
> > > > > > > > > > > > > > 
> > > > > > > > > > > > > > 				reset-gpios = <&gpio0 87 GPIO_ACTIVE_LOW>;
> > > > > > > > > > > > > > 
> > > > > > > > > > > > > > 				#address-cells = <1>;
> > > > > > > > > > > > > > 				#size-cells = <0>;
> > > > > > > > > > > > > > 
> > > > > > > > > > > > > > 				channel@0 {
> > > > > > > > > > > > > > 					reg = <0>;
> > > > > > > > > > > > > > 					adi,output-range-microvolt = <0 5000000>;
> > > > > > > > > > > > > > 				};
> > > > > > > > > > > > > > 
> > > > > > > > > > > > > > 				channel@1 {
> > > > > > > > > > > > > > 					reg = <1>;
> > > > > > > > > > > > > > 					adi,output-range-microvolt = <(-10000000) 10000000>;
> > > > > > > > > > > > > > 				};
> > > > > > > > > > > > > > 
> > > > > > > > > > > > > > 				channel@2 {
> > > > > > > > > > > > > > 					reg = <2>;
> > > > > > > > > > > > > > 					adi,output-range-microvolt = <0 40000000>;
> > > > > > > > > > > > > > 				};
> > > > > > > > > > > > > > 			}
> > > > > > > > > > > > > > 
> > > > > > > > > > > > > > 			dac@1 {
> > > > > > > > > > > > > > 				reg = <1>;
> > > > > > > > > > > > > > 				vdd-supply = <&vdd_regulator>;
> > > > > > > > > > > > > > 				avdd-supply = <&avdd_regulator>;
> > > > > > > > > > > > > > 				hvdd-supply = <&hvdd_regulator>;
> > > > > > > > > > > > > > 				hvss-supply = <&hvss_regulator>;
> > > > > > > > > > > > > > 
> > > > > > > > > > > > > > 				reset-gpios = <&gpio0 88 GPIO_ACTIVE_LOW>;
> > > > > > > > > > > > > > 
> > > > > > > > > > > > > > 				#address-cells = <1>;
> > > > > > > > > > > > > > 				#size-cells = <0>;
> > > > > > > > > > > > > > 
> > > > > > > > > > > > > > 				channel@0 {
> > > > > > > > > > > > > > 					reg = <0>;
> > > > > > > > > > > > > > 					adi,output-range-microvolt = <0 5000000>;
> > > > > > > > > > > > > > 				};
> > > > > > > > > > > > > > 
> > > > > > > > > > > > > > 				channel@1 {
> > > > > > > > > > > > > > 					reg = <1>;
> > > > > > > > > > > > > > 					adi,output-range-microvolt = <(-10000000) 10000000>;
> > > > > > > > > > > > > > 				};
> > > > > > > > > > > > > > 			}
> > > > > > > > > > > > > > 		};
> > > > > > > > > > > > > > 	};
> > > > > > > > > > > > > > 
> > > > > > > > > > > > > > then you might need something like:
> > > > > > > > > > > > > > 
> > > > > > > > > > > > > > 	patternProperties:
> > > > > > > > > > > > > > 		"^dac@[0-3]$":
> > > > > > > > > > > > > > 
> > > > > > > > > > > > > > and put most of the things under this node pattern.
> > > > > > > > > > > > > > 
> > > > > > > > > > > > > > So the main driver that you're putting together might need to handle up to four instances.
> > > > > > > > > > > > > > Even if your current driver cannot handle this, the dt-bindings might need cover that.
> > > > > > > > > > > > > > 
> > > > > > > > > > > > > > Need to double check if each dac node needs a separate compatible, so you would maybe populate
> > > > > > > > > > > > > > a platform data to be shared with the child nodes, which would be a separate driver.
> > > > > > > > > > > > > > (not sure if it would make sense to mix and match ad5529r-16 and ad5529r-12).  
> > > > > > > > > > > > > Hi Rodrigo,
> > > > > > > > > > > > > 
> > > > > > > > > > > > > Thank you for looking at this.
> > > > > > > > > > > > > 
> > > > > > > > > > > > > For now, I would prefer to keep the binding scoped to a single AD5529R device instance. The current
> > > > > > > > > > > > > hardware/use case we have only needs one device node and the driver is written around that model as well.
> > > > > > > > > > > > > While the device addressing pins could allow multi-device topology, we do not have an actual platform using
> > > > > > > > > > > > > that configuration at the moment, so I would prefer not to introduce an extra parent/child binding structure
> > > > > > > > > > > > > speculatively without a validating use case.  
> > > > > > > > > > > > Interesting feature - kind of similar to address control on a typical i2c bus device, or
> > > > > > > > > > > > looking at it another way a kind of distributed SPI mux.
> > > > > > > > > > > > 
> > > > > > > > > > > > Challenge of a binding is we need to anticipate the future.  So I think we do need something
> > > > > > > > > > > > like Rodrigo is suggesting even if we only (for now) support a single instance in the driver.
> > > > > > > > > > > > That would leave the path open to supporting the addressing at a later date.
> > > > > > > > > > > > An alternative might be to look at it like a chained device setup. In those we pretend there
> > > > > > > > > > > > is just one device with a lot of channels etc.  The snag is that here things are more loosely
> > > > > > > > > > > > coupled whereas for those devices it tends to be you have to read / write the same register
> > > > > > > > > > > > in all devices in the chain as one big SPI message.
> > > > > > > > > > > > 
> > > > > > > > > > > > +CC Mark Brown as he may know of some precedence for this feature. For his reference..
> > > > > > > > > > > > - Each of these device has 2 ID pins.  The SPI transfers have to contain the 2 bit
> > > > > > > > > > > > value that matches that or they are ignored.  Thus a single bus + 1 chip select can
> > > > > > > > > > > > be used to talk to 4 devices.  Question is what that looks like in device tree + I guess
> > > > > > > > > > > > longer term how to support it cleanly in SPI.  
> > > > > > > > > > 
> > > > > > > > > > I'd swear I have seen this before, from some Microchip devices. Let me
> > > > > > > > > > see if I can find what I am thinking of...  
> > > > > > > > > 
> > > > > > > > > 
> > > > > > > > > microchip,mcp3911 and microchip,mcp3564 both seem to do this with
> > > > > > > > > slightly different properties.
> > > > > > > > > 
> > > > > > > > >   microchip,device-addr:
> > > > > > > > >     description: Device address when multiple MCP3911 chips are present on the same SPI bus.
> > > > > > > > >     $ref: /schemas/types.yaml#/definitions/uint32
> > > > > > > > >     enum: [0, 1, 2, 3]
> > > > > > > > >     default: 0
> > > > > > > > > 
> > > > > > > > > and
> > > > > > > > > 
> > > > > > > > > 
> > > > > > > > >   microchip,hw-device-address:
> > > > > > > > >     $ref: /schemas/types.yaml#/definitions/uint32
> > > > > > > > >     minimum: 0
> > > > > > > > >     maximum: 3
> > > > > > > > >     description:
> > > > > > > > >       The address is set on a per-device basis by fuses in the factory,
> > > > > > > > >       configured on request. If not requested, the fuses are set for 0x1.
> > > > > > > > >       The device address is part of the device markings to avoid
> > > > > > > > >       potential confusion. This address is coded on two bits, so four possible
> > > > > > > > >       addresses are available when multiple devices are present on the same
> > > > > > > > >       SPI bus with only one Chip Select line for all devices.
> > > > > > > > >       Each device communication starts by a CS falling edge, followed by the
> > > > > > > > >       clocking of the device address (BITS[7:6] - top two bits of COMMAND BYTE
> > > > > > > > >       which is first one on the wire).
> > > > > > > > > 
> > > > > > > > > This sounds exactly like the sort of feature that you're dealing with
> > > > > > > > > here?
> > > > > > > > >   
> > > > > > > > 
> > > > > > > > The core idea yes but for this chip, things are a bit more annoying (but
> > > > > > > > Janani can correct me if I'm wrong). Here, each device can, in theory,
> > > > > > > > have it's own supplies, pins and at the very least, channels with maybe
> > > > > > > > different scales. That is why Janani is proposing dac nodes. Given I
> > > > > > > > honestly don't like much of that "adi,ad5529r-bus" compatible I wondered
> > > > > > > > about solving this at the spi level.
> > > > > > > > 
> > > > > > > > Ah and to make it more annoying, we can also mix 12 and 16 bits variants
> > > > > > > > together in the same bus.  
> > > > > > > 
> > > > > > > I'm definitely missing something, because that property for the
> > > > > > > microchip devices is not impacted what else is on the bus. AFAICT, you
> > > > > > > could have an mcp3911 and an mcp3564 on the same bus even though both
> > > > > > > are completely different devices with different drivers. They have
> > > > > > > individual device nodes and their own supplies etc etc. These aren't
> > > > > > > per-channel properties on an adc or dac, they're per child device on a
> > > > > > > spi bus.  
> > > > > > 
> > > > > > Maybe I'm the one missing something :). IIRC, spi would not allow two
> > > > > > devices on the same CS right? Because for this chip we would need
> > > > > > something like:
> > > > > > 
> > > > > > spi {
> > > > > > 	dac@0 {
> > > > > > 		reg = <0>;
> > > > > > 		adi,pin-id = <0>;
> > > > > > 	};
> > > > > > 
> > > > > > 	dac@1 {
> > > > > > 		reg = <0>; // which seems already problematic?
> > > > > > 		adi,pin-id <1>;
> > > > > > 	};
> > > > > > 
> > > > > > 	...
> > > > > > 
> > > > > > 	//up to 4
> > > > > > };
> > > > > Yeah. It's not clear to me how that works for the microchip devices
> > > > > (I suspect it doesn't!)
> > > > > 
> > > > > Just thinking as I type, but could we do something a bit nasty with
> > > > > a gpio mux that doesn't actually switch but represents the GPIO being
> > > > > shared?  Given this is all tied to the spi bus that should all happen
> > > > > under serializing locks. 
> > > > > 
> > > > > Agreed though that this would be nicer as an SPI thing that let
> > > > > us specify that a single CS is share by multiple devices and their
> > > > > is some other signal acting to select which one we are talking to.
> > > > > 
> > > > 
> > > > If the device-addressing on the same chip-select is to be handled
> > > > by the spi framework, wouldn't we lose device-specific features?
> > > > 
> > > > I understand that this multi-device feature is there mostly to extend the
> > > > channel count from 16 to 32, 48 or 64. I suppose the command:
> > > > 
> > > > 	"MULTI DEVICE SW LDAC MODE"
> > > > 
> > > > exists so that software can update channel values accross multiple devices.
> > > 
> > > Right! You do have a point! I agree the main driver for a feature like
> > > this is likely to extend the channel count and effectively "aggregate"
> > > devices.
> > > 
> > > But I would say that even with the spi solution the MULTI DEVICE stuff
> > > should be doable (as we still need a sort of adi,pin-id property). 
> > 
> > I don't think we can have something like an IIO buffer shared by multiple
> > devices. Synchronizing separate devices would be doable with proper hardware
> > support for this (probably involving an FGPA).
> 
> True!
> 
> >  
> > > But yes, I do feel that the whole feature is for aggregation so seeing
> > > one device with 32 channels is the expectation here? Rather than seeing
> > > two devices with 16 channels.
> > 
> > Yes, I think aggregation is the whole point there... so that the IIO driver
> > is multi-device-aware.
> 
> Which makes me feel that different pins per device might be possible
> from an HW point of view but does not make much sense. For example, for
> the buffer example I would expect LDAC to be shared between all the
> devices.

That is why I would still suggest the multi-dac node in the middle...
the parent node can hold shared resources, while the dac children can
have their own, overriding or inheriting stuff.

-- 
Kind regards,

Rodrigo Alencar
