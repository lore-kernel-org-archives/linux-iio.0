Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A022C1632E7;
	Wed, 27 May 2026 16:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779900676; cv=none; b=hH4wHiFEXP6h+Y3+Yj6xmHm43qeA7MUViw8747+6uPhK03+jB81BbBCKZaRriYiMWlQZPQxD4IkGzavhbCBYgTH52ds7BbHVWPtjQ/q6XmgT6v0I/wk8zHkiM6PZGNG9AswU/xJMdSa2/jXAwIhGXhIQHh5+svksCooXwWbJV5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779900676; c=relaxed/simple;
	bh=gx7/JFRCtf+67JTm57Hx9HOLTcxaxeH/26uhWrQGCqg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OMw04NDFGl1bBkpoxG4D4njBybp5jyS35A4WjYjwfBj9yzPlCCZBL/y/N6pCs15a7V6VYyf8dBd5zlOSTG5eZaCeK4wD6B7DEA24IVvH7MuCHTCWKyrAJmUIvRZdpqQVMkJj6gjXRKGhpXGrBchMD3ngkLexDMKPcN/VEU/zHbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FB8bXbBL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FB8bXbBL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62AA11F000E9;
	Wed, 27 May 2026 16:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779900675;
	bh=af/bGhHY9IEhibJaYFYHkxTMQuvKyzEs/2k0XmlP8GE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=FB8bXbBLM1SIpmakXtAtBTujmhjJ7bFCn7//KxshcmEB/qCvmnjqh8BKm6NXdhz5d
	 0ZzamiyMt/wvX2FxcdpGKfD3LL6tdfeU5l2nN+hPXAMU9c7NV6bp+/Es3JJWcSBVnX
	 ahuFai7lSfth+U5ZP774hYyQPwsPRYpW8AzSO8Cz4hH8SrXSTgkgL0gm6qLbBZbBgm
	 0JgkKxGpO/BG+KoG+F/cI7fb8uCl68dHMhpTCiLyfzbRZ/MDIJ67CIc7o/m14a/nxu
	 2byEDsZaXndgMH6HHv8a9Kq1eW9p5W4Iavrw7ebbWmvQul6Cx8PIS2W6/wA5zsr0ul
	 6oRv7LFCSA4QQ==
Date: Wed, 27 May 2026 17:51:04 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: Liviu Stan <liviu.stan@analog.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Antoniu
 Miclaus <antoniu.miclaus@analog.com>, Francesco Lavra
 <flavra@baylibre.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux@analog.com, devicetree@vger.kernel.org
Subject: Re: [PATCH v4 8/9] dt-bindings: iio: temperature: Add ADT7604
 support to adi,ltc2983
Message-ID: <20260527175104.05880d66@jic23-huawei>
In-Reply-To: <20260526-overexert-mollusk-72b080546d5f@spud>
References: <20260525164013.118614-1-liviu.stan@analog.com>
	<20260525164013.118614-9-liviu.stan@analog.com>
	<20260526-overexert-mollusk-72b080546d5f@spud>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 26 May 2026 17:55:49 +0100
Conor Dooley <conor@kernel.org> wrote:

> On Mon, May 25, 2026 at 07:39:35PM +0300, Liviu Stan wrote:
> > The ADT7604 shares the same die as the LTC2984. It repurposes the
> > custom RTD sensor type (18) as a copper trace resistance sensor
> > and the custom thermistor type (27) as a leak detector, and
> > removes thermocouple, diode and direct ADC sensor types.
> > 
> > Add adi,adt7604 to the compatible list and introduce two new
> > sensor node types specific to this device:
> > 
> > - copper-trace@: maps to the custom RTD sensor type (18). Two
> > variants: sub-ohm (< 1 ohm, adi,copper-trace-sub-ohm boolean,
> > no custom table and excitation current) and standard (> 1 ohm,
> > required adi,custom-copper-trace table, optional excitation current
> > defaulting to the datasheet recommended value). Primary output
> > is resistance in ohms. For > 1 ohm copper traces with a custom table,
> > the chip also outputs temperature in millidegrees Celsius.
> > 
> > - leak-detector@: maps to the custom thermistor sensor type (27).
> > Takes a required adi,custom-leak-detector lookup table encoding
> > resistance (uOhm) against coverage data (%). Two outputs:
> > resistance in ohms and coverage in percent.
> > 
> > Separate node types are used rather than extending the existing
> > rtd@ and thermistor@ nodes because adi,custom-rtd is required
> > for sensor type 18, and several properties (adi,number-of-wires,
> > adi,rtd-curve, adi,rsense-share, adi,single-ended,
> > adi,current-rotate) have no meaning for the new sensor types, since
> > the configuration is hardcoded, and would need to be explicitly
> > forbidden or ignored in the driver.
> > 
> > allOf conditions are added to restrict thermocouple, diode, direct
> > ADC and active temperature nodes to non-ADT7604 devices, and to
> > restrict copper-trace and leak-detector nodes to the ADT7604
> > (some parts only).
> > 
> > Signed-off-by: Liviu Stan <liviu.stan@analog.com>  
> 
> If this approach is acceptable to Jonathan, it is acceptable to me.
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> pw-bot: not-applicable
> 
> > +            leak-detector@14 {
> > +                reg = <14>;
> > +                adi,sensor-type = <33>;
> > +                adi,rsense-handle = <&r_sense>;
> > +                adi,excitation-current-nanoamp = <10000>;
> > +                adi,custom-leak-detector =
> > +                    /bits/ 64 <          0 100>,
> > +                    /bits/ 64 <  202020000  99>,
> > +                    /bits/ 64 <  285710000  70>,
> > +                    /bits/ 64 <  333330000  60>,
> > +                    /bits/ 64 <  400000000  50>,
> > +                    /bits/ 64 <  500000000  40>,
> > +                    /bits/ 64 <  666670000  30>,
> > +                    /bits/ 64 < 1000000000  20>,
> > +                    /bits/ 64 < 2000000000  10>,
> > +                    /bits/ 64 <1000000000000 0>;  
> 
> My OCD hates that you have gone to some effort with alignment here, only
> for this last line's first cell to scupper it completely.
Tweaked to:
diff --git a/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml b/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml
index ab77f987ee02..13e5f29f0588 100644
--- a/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml
+++ b/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml
@@ -744,16 +744,16 @@ examples:
                 adi,rsense-handle = <&r_sense>;
                 adi,excitation-current-nanoamp = <10000>;
                 adi,custom-leak-detector =
-                    /bits/ 64 <          0 100>,
-                    /bits/ 64 <  202020000  99>,
-                    /bits/ 64 <  285710000  70>,
-                    /bits/ 64 <  333330000  60>,
-                    /bits/ 64 <  400000000  50>,
-                    /bits/ 64 <  500000000  40>,
-                    /bits/ 64 <  666670000  30>,
-                    /bits/ 64 < 1000000000  20>,
-                    /bits/ 64 < 2000000000  10>,
-                    /bits/ 64 <1000000000000 0>;
+                    /bits/ 64 <            0 100>,
+                    /bits/ 64 <    202020000  99>,
+                    /bits/ 64 <    285710000  70>,
+                    /bits/ 64 <    333330000  60>,
+                    /bits/ 64 <    400000000  50>,
+                    /bits/ 64 <    500000000  40>,
+                    /bits/ 64 <    666670000  30>,
+                    /bits/ 64 <   1000000000  20>,
+                    /bits/ 64 <   2000000000  10>,
+                    /bits/ 64 <1000000000000   0>;
             };
 
             rtd@18 {



> 
> > +            };  

