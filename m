Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795052174;
	b=3NFE+5HCnKqs+Yd9Z2RxMEdDry/nmqTfYBhoy885ckA0xUsL0tzT4OSjI+oPFIcwJJRZ
	 oFiOGwWbEcXkZICVdfbzipaqmqsUOel33k9ziqxrGQDpQOQ98omC2tRDpSVgQ9ESyHcSs
	 ugxgVrZ6v6I86sY1gOgb/KJpWWURxXni2bpQKMHL0GfHjD+oEg4wAZ02S0KDi0ej+///w
	 3VvnLt5SnKKNLgBktmUgdzsthNyfZZvu7dC/QEI7YpYfZC+xYdDTliSxEbsNi29o74ufA
	 KustLKzWE2PPVFHTKUp+2I9wPXFfczHO0ZMGtYVOXS5JDOI6pxZhxrWpGSliYO4SYfQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795052174;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=6ppFMoyy0hMiK8zLmO0ZtgvhxnZ98SKRntiVkaykdQQ=;
	b=eKCR9u/GMRS7YMgP8kLhmcWyswRG6HcYB/G315Ks7HCaRMSwK2zmXaCf5ZaSalvCjbd6
	 Epwda9rriRHNQzbiUy2Kl+WkbdSVMgUteOQAHNXxtX9JbAIttgnyoSQf23JTGcGpp2rJg
	 Z5Ra1jQA1DOwRLSBGEOIhBwoXhzKZUIEvHNOB/HR+SNZg4FUoyvmQNEDU8PdeXrvcYuQ9
	 z4Y0shSw4sX/uhsgP/b6JLs/z8SchhVuQO6BdQ+ZR8nWHA+ksusiZHcr06VdYrLzMRey+
	 YEwvwPHNuVGfLbR1zgrmzkjEEDyqVha2aZB5m8zvW6uKFRxhqMlRJNwVE9V2nc/nGkA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="R8C7i2W/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35532606A31C;
	Thu, 19 Nov 2026 01:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R8C7i2W/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CE661F000C4;
	Thu, 19 Nov 2026 01:36:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795052174;
	bh=6ppFMoyy0hMiK8zLmO0ZtgvhxnZ98SKRntiVkaykdQQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=R8C7i2W/N1IkQypPHy70VnqdPx8BK/vtrlsEXldYkQiYntcNpzkB3O2oOWynjHW8X
	 cUL58965McsNETAM+8z3k2p1vHYTqSOWNvAdH0uIL6wBQPOCTAFzJfCY4MhK7YtRi5
	 uF1iJ6huwOnCSMtuZXomOHgu/2bH1nPHJBrX5tTaCSqVak37hphpKQmsanN6y88RgR
	 U1xn1sEK1r/S44wdCgKJXeNYaG5/weKVhexEL3SrGI0oouzJExa4117ZuQHPFZRiuI
	 lqtfrtdBQIa3o4O2rD90JlZePsbM72/CPuAeY8s+RZpBXWNo9me5RhmZtt53F+qqiX
	 XtVRkHm/0L1ag==
Date: Thu, 19 Nov 2026 01:36:07 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Linus Walleij <linusw@kernel.org>
Cc: linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Kyungmin Park
 <kyungmin.park@samsung.com>, devicetree@vger.kernel.org, Krzysztof
 Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, Joshua Crofts
 <crofts@kernel.org>
Subject: Re: [PATCH v3 0/5] iio: light: gp2ap020a00f: Add VCC supply and
 GP2AP030A00F support
Message-ID: <20261119013607.2f763ff3@jic23-hlaptop>
In-Reply-To: <20261118-gp2ap030-v3-0-c8df93460110@kernel.org>
References: <20261118-gp2ap030-v3-0-c8df93460110@kernel.org>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 18 Nov 2026 14:46:07 +0100
Linus Walleij <linusw@kernel.org> wrote:

> Describe and enable the optional VCC supply for the GP2AP020A00F and
> GP2AP030A00F. Preserve compatibility with existing device trees that only
> describe the LED supply.
> 
> Extend the existing binding and driver to support the GP2AP030A00F. It
> shares the register layout, but has different proximity resolution
> encodings and no automatic lux calculation. Select model-specific
> initialization, keep reserved bits clear and expose fixed-range raw
> clear and infrared counts. Keep generic supply handling in separate
> patches from the model-specific binding and driver additions.
> 
> Assisted by LLM.
> 
> Signed-off-by: Linus Walleij <linusw@kernel.org>
Applied. Thanks,

J
> ---
> Changes in v3:
> - Return -ENODATA when chip match data is missing.
> - Use four-line initializers for I2C device IDs.
> - Document the 1 ms power-on delay and use USEC_PER_MSEC.
> - Align family descriptions and list supported parts in Kconfig help.
> - Pack GP2AP030A00F samples as 16-bit values and omit zero shifts.
> - Link to v2: https://patch.msgid.link/20261108-gp2ap030-v2-0-24eaa1b9fe59@kernel.org
> 
> Changes in v2:
> - Replace vdd/vio with one optional vcc supply, matching the VCC pin.
> - Use devm_regulator_get_enable() for VCC, allowing dummy regulators.
> - Move the VLED description into the generic supply binding patch.
> - Split variant infrastructure from GP2AP030A00F support.
> - Use "GP2AP020A00F and similar" in family descriptions.
> - Use reverse Christmas tree ordering for local declarations.
> - Explicitly select MANUAL_CALC when automatic ALS calculation is absent.
> - Reject missing chip match data before accessing the device.
> - Use fsleep() for the GP2AP030A00F startup delay.
> - Select static channel arrays and counts through chip_info.
> - Link to v1: https://patch.msgid.link/20261108-gp2ap030-v1-0-55314eb7055b@kernel.org
> 
> ---
> Linus Walleij (5):
>       dt-bindings: iio: light: sharp,gp2ap020a00f: Add VCC supply
>       dt-bindings: iio: light: sharp,gp2ap020a00f: Add GP2AP030A00F
>       iio: light: gp2ap020a00f: Enable the VCC supply
>       iio: light: gp2ap020a00f: Prepare for chip variants
>       iio: light: gp2ap020a00f: Add GP2AP030A00F support
> 
>  .../bindings/iio/light/sharp,gp2ap020a00f.yaml     |  17 ++-
>  drivers/iio/light/Kconfig                          |   6 +-
>  drivers/iio/light/gp2ap020a00f.c                   | 147 +++++++++++++++++++--
>  3 files changed, 151 insertions(+), 19 deletions(-)
> ---
> base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
> change-id: 20261107-gp2ap030-99504c2dc038
> 
> Best regards,
> --  
> Linus Walleij <linusw@kernel.org>
> 

