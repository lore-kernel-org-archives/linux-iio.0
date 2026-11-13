Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794532804;
	b=JxrYKBGQ/dG/9B4vJ6XjvrUG7/UPhBhMOZwG19aV4xkCOVi+tvUZlL1SE01nC5gQZEa3
	 FYg/rvpeKVrEXs7k0QJQEYoJcE9xNZwKLpnLnis8Tgj7AKJtnSL+tsa7/ufmsOQtExeoa
	 sHVs8qsGJRSW/s1DmvpoJwJdGug6KDTFzV2aTDd+aW+nWwMX8ayA0VAvNFT/oiRRsyvHT
	 eYuEprSi01H8lPHvFDL+EMdDBVu+qUxjz99Blse8NicvS6+nsaEq4Y2RD1RmEuFIaQl72
	 vq6Fg1PgduzKuJ4bzA5DaRX4GndBkHHnlZ/4qhvo4zr0WsaM0P1N7fQVW8U+hkXnROw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794532804;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=ihVMGHo1BmleIkV3EOT0D9R5nIHHW1mYzBlrGw9jfGs=;
	b=YOJjSfBAcAi8Do1iZZ592g7botkhepTrLxWnX4jEwYHiP+i2dGwv4xU8Hmdop4MQqruv
	 PEJF7G1BrbMdrr7kotMQbnM9wLNzAZ0klaD6bjK+i35bAGLgkFl1uxLbzwcLYqR+V3s05
	 tgNOnLmSksLvBvt7pK0ZeHebIjWrISZYLNUj8XjpcfuuyPWxxBV7twA/uH4G82YM5ge9L
	 5+EHgbSUyiDOHOx1hVTyW5RWZO7uiACrmc1dSbnb/9+CGlrbfmdaZzhDNUoHVLthuSb1z
	 x0Scp0JfSZaYfV0YQLs9iWzHA8X/c7W2IqFoJdFmUra/lEhDv+rqKA2fBPLir4oISbg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hJVTzpjW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0FF5606A323;
	Fri, 13 Nov 2026 01:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hJVTzpjW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8EB91F000C4;
	Fri, 13 Nov 2026 01:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794532803;
	bh=ihVMGHo1BmleIkV3EOT0D9R5nIHHW1mYzBlrGw9jfGs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=hJVTzpjWkmPY0v3/KVrmMhVkRvcRtGSnUzNTZ/4hUNWmc4LjO4zfXjHbuQ8hV8/vZ
	 fK613O872Bdx0JJDQbaC6RZByiVHo3JEmetLyjkqhMmed5YIm7QfOo9U2+8YQIyYIP
	 McBQcK0R3OisJdmCy+DxZu10DZwPCmkpWrxgk+IIqTyPKtnbelc9NDsirKVYXqABxK
	 6/yHEticQ5mzgqTM1XcQTP7mKSpQElkjVaaq5PyqWG+t07ZzTCg4b0nXRTvoZaFa0C
	 BtQtOdduxum2riLmUmP0Q/PrY0L/0nQNZR+Pur30+AB3eBl6gb+rx3OaUS8VgvMHEE
	 0q1cZyhyLzmZA==
Date: Fri, 13 Nov 2026 01:19:57 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Akhilesh Patil <akhilesh.patil@linux.dev>
Cc: andy@kernel.org, krzk+dt@kernel.org, dlechner@baylibre.com,
 robh@kernel.org, crofts@kernel.org, conor+dt@kernel.org,
 alexandre.belloni@bootlin.com, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-rtc@vger.kernel.org, akhileshpatilvnit@gmail.com,
 akhilesh@ee.iitb.ac.in
Subject: Re: [PATCH v4] MAINTAINERS: Update Akhilesh Patil Email address
Message-ID: <20261113011957.5d8836ff@jic23-hlaptop>
In-Reply-To: <20261112091641.GA3643677@u5ce4748bae3b54.ant.amazon.com>
References: <20261112091641.GA3643677@u5ce4748bae3b54.ant.amazon.com>
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

On Thu, 12 Nov 2026 09:16:41 +0000
Akhilesh Patil <akhilesh.patil@linux.dev> wrote:

> Move to my new linux.dev email address akhilesh.patil@linux.dev
> I plan to use this email for kernel development going forward.
> Also update email address in few yaml and driver source files.
> 
> Signed-off-by: Akhilesh Patil <akhilesh.patil@linux.dev>

I can pick this one up with an rtc ack, or it can go through that
tree. I don't mind which.

Acked-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

Thanks,

Jonathan

> ---
> 
> Changes in v4: 
> - No source change.
> - Added entire change log for all versions.
> - Link to v3: 
> https://lore.kernel.org/linux-iio/20261110052942.GA2505113@u5ce4748bae3b54.ant.amazon.com/
> 
> Changes in v3: 
> - Fixed order of entry in .mailmap
> - Link to v2: 
> https://lore.kernel.org/all/20261109104443.GA531570@u5ce4748bae3b54.ant.amazon.com/ 
> 
> Changes in v2:
> - Updated email ID in relevant device tree source files and driver source files.
> - Link to v1: 
> https://lore.kernel.org/linux-iio/20261109063924.GA118887@u5ce4748bae3b54.ant.amazon.com/
> 
>  .mailmap                                                      | 1 +
>  .../devicetree/bindings/iio/pressure/aosong,adp810.yaml       | 2 +-
>  Documentation/devicetree/bindings/rtc/st,m41t93.yaml          | 2 +-
>  MAINTAINERS                                                   | 2 +-
>  drivers/iio/pressure/adp810.c                                 | 4 ++--
>  5 files changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/.mailmap b/.mailmap
> index 7fb33babc931..d09fd3708023 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -27,6 +27,7 @@ Adrian Bunk <bunk@stusta.de>
>  Ajay Kaher <ajay.kaher@broadcom.com> <akaher@vmware.com>
>  Akhil P Oommen <akhilpo@oss.qualcomm.com> <akhilpo@codeaurora.org>
>  Akhil P Oommen <akhilpo@oss.qualcomm.com> <quic_akhilpo@quicinc.com>
> +Akhilesh Patil <akhilesh.patil@linux.dev> <akhilesh@ee.iitb.ac.in>
>  Alan Cox <alan@lxorguk.ukuu.org.uk>
>  Alan Cox <root@hraefn.swansea.linux.org.uk>
>  Aleksandar Markovic <aleksandar.markovic@mips.com> <aleksandar.markovic@imgtec.com>
> diff --git a/Documentation/devicetree/bindings/iio/pressure/aosong,adp810.yaml b/Documentation/devicetree/bindings/iio/pressure/aosong,adp810.yaml
> index ad5f26ce5043..ca4d4210f609 100644
> --- a/Documentation/devicetree/bindings/iio/pressure/aosong,adp810.yaml
> +++ b/Documentation/devicetree/bindings/iio/pressure/aosong,adp810.yaml
> @@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
>  title: aosong adp810 differential pressure sensor
>  
>  maintainers:
> -  - Akhilesh Patil <akhilesh@ee.iitb.ac.in>
> +  - Akhilesh Patil <akhilesh.patil@linux.dev>
>  
>  description:
>    ADP810 is differential pressure and temperature sensor. It has I2C bus
> diff --git a/Documentation/devicetree/bindings/rtc/st,m41t93.yaml b/Documentation/devicetree/bindings/rtc/st,m41t93.yaml
> index bdd995c5c1f4..837679dc01ac 100644
> --- a/Documentation/devicetree/bindings/rtc/st,m41t93.yaml
> +++ b/Documentation/devicetree/bindings/rtc/st,m41t93.yaml
> @@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
>  title: ST M41T93 RTC and compatible
>  
>  maintainers:
> -  - Akhilesh Patil <akhilesh@ee.iitb.ac.in>
> +  - Akhilesh Patil <akhilesh.patil@linux.dev>
>  
>  description:
>    ST M41T93 is spi based Real Time Clock (RTC) with time, date,
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 222b7fc2c3aa..3aa8fa3c068f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4095,7 +4095,7 @@ F:	Documentation/devicetree/bindings/iio/chemical/aosong,ags02ma.yaml
>  F:	drivers/iio/chemical/ags02ma.c
>  
>  AOSONG ADP810 DIFFERENTIAL PRESSURE SENSOR DRIVER
> -M:	Akhilesh Patil <akhilesh@ee.iitb.ac.in>
> +M:	Akhilesh Patil <akhilesh.patil@linux.dev>
>  L:	linux-iio@vger.kernel.org
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/iio/pressure/aosong,adp810.yaml
> diff --git a/drivers/iio/pressure/adp810.c b/drivers/iio/pressure/adp810.c
> index 82aa433548d2..832df6ba0ee3 100644
> --- a/drivers/iio/pressure/adp810.c
> +++ b/drivers/iio/pressure/adp810.c
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  /*
> - * Copyright (c) 2025 Akhilesh Patil <akhilesh@ee.iitb.ac.in>
> + * Copyright (c) 2025 Akhilesh Patil <akhilesh.patil@linux.dev>
>   *
>   * Driver for adp810 pressure and temperature sensor
>   * Datasheet:
> @@ -219,6 +219,6 @@ static struct i2c_driver adp810_driver = {
>  };
>  module_i2c_driver(adp810_driver);
>  
> -MODULE_AUTHOR("Akhilesh Patil <akhilesh@ee.iitb.ac.in>");
> +MODULE_AUTHOR("Akhilesh Patil <akhilesh.patil@linux.dev>");
>  MODULE_DESCRIPTION("Driver for Aosong ADP810 sensor");
>  MODULE_LICENSE("GPL");

