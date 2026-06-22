Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7823A1D14;
	Mon, 22 Jun 2026 10:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782124048; cv=none; b=Pv/rprh9N3f6mvul1JxqteGcPPcmny3S0o8XzcotCpKpTBQ3DROw7miyFLWlretiHyFcGowTEaM+yOhH4D82JBK0eb1MCzT8irgAIQHMS1RM2/Rwfzj84vCWWomrjwUASxp7UAHsGtkmVn3HFB9n+ROxQyPccQB/U2tHjuWeP2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782124048; c=relaxed/simple;
	bh=XDYTEXR0lgD+wLN6MproUH7PwD4+ylhzpN/JYad2Fvg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HRUT6krEQk2cKg1IFdaKuwIOKMkfA8qh/kt8zEs//Q41cbd6cPttasXUysFWepebkh9ywZihBqpuzHgEEIljaD5ysJrBDMqN1QCmICSeist5bOiiCrPi/uj8/lu9gOgE9/DE3Ta6TnJEqDGtui4T3Ty4EgCl4EIvzR75/yNuVkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YBe0CXiN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YBe0CXiN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C5A21F000E9;
	Mon, 22 Jun 2026 10:27:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782124047;
	bh=/lE1FezMr7OwuD4X6kCWi5XoM/mNVm/48z+H+d2y2to=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=YBe0CXiNhKuJm10mmhpWlGEPbvFb/SAl8WRzZ311wIGiWCll3ncDpvDBYNNbuJk/w
	 IEjU9LtdRlVtKLKeBf7JTg3psmbg8WDMiCzuajDvQ6HOGNFPjNe7YWz8hGJlLzv/GX
	 8JK+If4RgsA0zJ7RkWDvo1Cto7LjW0qe3QMXAFSZpRqYoI7Xw02zE7oGThqH7EvfQy
	 mCaDxoQ0EhABfrOt9MIYvk4pPqeTT0VdoLWGRnp+0rjSHi8NR6V9er3ER4Y7S7kI6n
	 FKUZzCP5u2wxYNStPDLuJSoR5TQm/sNa4p+KoincOEU0pAyVCztGXvf16CwcJncfOX
	 3L2Apk/OfQAVg==
Date: Mon, 22 Jun 2026 11:27:17 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
Cc: Chris Morgan <macroalpha82@gmail.com>, "linux-iio@vger.kernel.org"
 <linux-iio@vger.kernel.org>, "andy@kernel.org" <andy@kernel.org>,
 "nuno.sa@analog.com" <nuno.sa@analog.com>, "dlechner@baylibre.com"
 <dlechner@baylibre.com>, "linux-rockchip@lists.infradead.org"
 <linux-rockchip@lists.infradead.org>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>, "heiko@sntech.de" <heiko@sntech.de>,
 "conor+dt@kernel.org" <conor+dt@kernel.org>, "krzk+dt@kernel.org"
 <krzk+dt@kernel.org>, "robh@kernel.org" <robh@kernel.org>,
 "andriy.shevchenko@intel.com" <andriy.shevchenko@intel.com>, Chris Morgan
 <macromorgan@hotmail.com>, Krzysztof Kozlowski
 <krzysztof.kozlowski@oss.qualcomm.com>
Subject: Re: [PATCH V13 2/9] dt-bindings: iio: imu: icm42600: Add icm42607
Message-ID: <20260622112717.4548dc95@jic23-huawei>
In-Reply-To: <BE1P281MB1426C557A66945951D382EDDCEEF2@BE1P281MB1426.DEUP281.PROD.OUTLOOK.COM>
References: <20260615172554.160910-1-macroalpha82@gmail.com>
	<20260615172554.160910-3-macroalpha82@gmail.com>
	<20260621181804.27b44942@jic23-huawei>
	<BE1P281MB1426C557A66945951D382EDDCEEF2@BE1P281MB1426.DEUP281.PROD.OUTLOOK.COM>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 22 Jun 2026 09:23:28 +0000
Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com> wrote:

> Hello Chris and Jonathan,
> 
> concerning dt bindings, my initial understanding was that we had a file per
> driver. But here, Chris is doing a new driver for icm42607 while adding new
> bindings here.
> 
> Does it means we don't have 1 binding file per driver, and there is no need
> to create a new binding file for inv_icm42607 driver?

Yes.  We often combine bindings when there is a lot of duplication and
only a few device specific rules are needed to describe the new parts.

Jonathan

> 
> Despite the naming, icm42607 chips are a complete new design very different
> than all other icm42600 chips. It using similar IPs for things like the FIFO,
> but all other parts are different. Especially, it doesn't use banks for
> registers access but indirect access delegated to the chip internals for
> accessing certain registers.
> 
> Thanks,
> JB
> 
> >From: Chris Morgan <macromorgan@hotmail.com>
> >
> >Add the ICM42607 and ICM42607P inertial measurement unit.
> >
> >This device is functionally very similar to the icm42600 series with a
> >very different register layout. The driver does not require an
> >interrupt for these specific chip revisions.
> >
> >Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> >Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> >---
> > .../bindings/iio/imu/invensense,icm42600.yaml  | 18 +++++++++++++++++-
> > 1 file changed, 17 insertions(+), 1 deletion(-)
> >
> >diff --git a/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml b/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml
> >index 9b2af104f186..81b6e85decd5 100644
> >--- a/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml
> >+++ b/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml
> >@@ -30,6 +30,8 @@ properties:
> >       - invensense,icm42600
> >       - invensense,icm42602
> >       - invensense,icm42605
> >+      - invensense,icm42607
> >+      - invensense,icm42607p
> >       - invensense,icm42622
> >       - invensense,icm42631
> >       - invensense,icm42686
> >@@ -67,10 +69,24 @@ properties:
> > required:
> >   - compatible
> >   - reg
> >-  - interrupts
> > 
> > allOf:
> >   - $ref: /schemas/spi/spi-peripheral-props.yaml#
> >+  - if:
> >+      properties:
> >+        compatible:
> >+          contains:
> >+            enum:
> >+              - invensense,icm42600
> >+              - invensense,icm42602
> >+              - invensense,icm42605
> >+              - invensense,icm42622
> >+              - invensense,icm42631
> >+              - invensense,icm42686
> >+              - invensense,icm42688
> >+    then:
> >+      required:
> >+        - interrupts
> > 
> > unevaluatedProperties: false
> > 
> >-- 
> >2.43.  

