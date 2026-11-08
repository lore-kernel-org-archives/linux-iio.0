Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794171112;
	b=FRxKA5dSf5mzCetLMggHeqZJC38lwYAt3nCYm4bRyYi4Ce2qxCBhKB9Bk/FUUv7QQhU0
	 bzgBsuSMBqoEDlGgLph4DPo8wmSAITAdfN4q2fZlof9+yh2/W/dbELhBkjX2rHsqxir0c
	 nDxL7lRZ5TztNCg+vvfLOlVuoNDYM0hcCCWoNMuF0Quhqi560qIeAsVxy/NHiVNnst1fm
	 YA0/KPV4hkUT6oD9HaLg0VsojWMJstly4kqUPgBSWpx9PSzafr0i7rx0iBth8d/E9HKWt
	 xqP5hBd5vyU9mdjBI/piMoyJk3jJlQQAZ08Rbo89van9FblBqmSCTk68y3Qb0k3+1IQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794171112;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=X87kPqxtbmal3tbue4lsjoMJOKxCwD6E7IkS8YJjNaM=;
	b=d4+sNqf+mzHGlxyzlu/iNQv0I/M7yRUMAxbce9lVm8fnJwfFhXZjB3MCljPqmWUIbWlI
	 ZrTisAky8gVfqye/zDNNhCYKEYL+q3HeQya6Ys/RGK+HMZxzM5UBkcLjaR3lT8+PUpxZy
	 +f1fGW4dmIkZlyeim0xKb71vBbmVHIT7NExHkZ82IlRBukDnIZtodlUFccz/3ta0znMaI
	 Ey4JKhE+VtJVqr1lqYFlwlsmTbpMrvEHURyUnL8i/zVcLFy4+yPJkSScAMgNCCiWsg5PG
	 f95JUmDREiJUYXf7o7pLluXvsXqltvcYznKdjcGctnFhsrXKlfw/oR97qoYYNLhrpZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PMP7vLbi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9863F606A31C;
	Sun,  8 Nov 2026 20:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PMP7vLbi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB5401F0089F;
	Sun,  8 Nov 2026 20:51:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794171112;
	bh=X87kPqxtbmal3tbue4lsjoMJOKxCwD6E7IkS8YJjNaM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=PMP7vLbiA+IW3DL55XyjfV+QZfBHQNl9FAqzn2qNHONqMGSDOFqrN2a2fu0rulJWG
	 2tBqpvV+KTOYhbX4DYN5IDUHXL/Axc2CFpXRq/k+4+k/RpEQw94BxYqJ7stwBhL2Ot
	 l70bKJv3BKVBlHUhMkxpZHzzrGYDGAExA+D4qOp4QOtmXNPv0lgbwrpCaBjo95xyjC
	 ezdHAbWSEYedR1ibqjFj796MElcqd9aY2a4Lyfbc4NVPmHE4OCHE33ZjJb2aAaO8HZ
	 v6YEDSAQMNURyVzaCwmsLEJ9/I3n/7+XEgMNq+PYCFmpix8GnBsCIY0KPRCIPSFOXw
	 EtxgnR8O2WEgA==
Date: Sun, 8 Nov 2026 20:51:43 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, Lee Jones <lee@kernel.org>,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-iio@vger.kernel.org, mfd@lists.linux.dev
Subject: Re: [PATCH v1 2/4] mfd: max8907: Add ADC client support
Message-ID: <20261108205143.134d6aa0@jic23-hlaptop>
In-Reply-To: <20261108095634.100517-3-clamor95@gmail.com>
References: <20261108095634.100517-1-clamor95@gmail.com>
	<20261108095634.100517-3-clamor95@gmail.com>
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

On Sun,  8 Nov 2026 11:56:32 +0200
Svyatoslav Ryhel <clamor95@gmail.com> wrote:

> The Maxim MAX8907 has an 8-channel ADC at a fixed location. Add client
> support for it along with its regmap and interrupts.
> 
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>

> diff --git a/include/linux/mfd/max8907.h b/include/linux/mfd/max8907.h
> index 35b2ede54f856..cf304afc782d6 100644
> --- a/include/linux/mfd/max8907.h
> +++ b/include/linux/mfd/max8907.h
> @@ -153,6 +153,51 @@
>  #define MAX8907_REG_MPL_CNTL		0x1E
>  
>  /* ADC and Touch Screen Controller register map */
> +#define MAX8907_REG_TSC_STA_INT		0x00
> +#define MAX8907_REG_TSC_INT_MASK	0x01
> +#define MAX8907_REG_TSC_CNFG1		0x02
> +#define MAX8907_REG_TSC_CNFG2		0x03

....

> +/* Regulator stride */

I'm not sure what this means. Stride of what?  Seems to
be some offsets in the register address.

>  #define MAX8907_CTL			0
>  #define MAX8907_SEQCNT			1
>  #define MAX8907_VOUT			2
> @@ -165,6 +210,8 @@
>  #define MAX8907_MASK_OUT5V_ENSRC	0x0E
>  #define MAX8907_MASK_OUT5V_EN		0x01
>  #define MAX8907_MASK_POWER_OFF		0x40
> +#define MAX8907_MASK_RST_CFG_INT_REF_EN	0x01
> +#define MAX8907_MASK_NREF_OK		0x10

