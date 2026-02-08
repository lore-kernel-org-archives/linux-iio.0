Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C5033B97E
	for <linux-iio@vger.kernel.org>; Sun,  8 Feb 2026 09:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770542717; cv=none; b=vDMpga2zsNgG7osd9BOeKdqYxOWONrwOl9P0aO2m6aLeND8T7G+RDNThn+R6K1cBSYnOtmLrzdBmf220QaiLTPPIU/hOHrcpYMdcN0d81uYb+BQFcpO2pM9z9tyHkLtAakLCB5OPf8dcfoleWGeGWeGdSnUYs6SJcI2eEoEMd1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770542717; c=relaxed/simple;
	bh=XeoEd6PTxccp07L+s3/OmGwhyoss8PjEBCE16OPFOMc=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hLdQyG6RMaS3bXQdgggEoOSsRCeAU/h1YQFPSidc5OXZ51pU2uY4GfipsH+S5xgb3NpUqUntUTKWbw/DGI6acOy8GJR4J7WqxOoMtHv8CUMsUQBzA1a3VDrTrWv8jhWxgjE50M0YbgTd0VQzrPjmQgwf4pmwwDGzYdIDEzNekLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cMNekdAp; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cMNekdAp"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-4362197d174so2019881f8f.3
        for <linux-iio@vger.kernel.org>; Sun, 08 Feb 2026 01:25:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770542716; x=1771147516; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3k1pQBX12h0BSUE4QM+2bV+LNA/Oczy6ilqlLzeMHL8=;
        b=cMNekdApxL5+9gNfKqPjqTBHnozGiCTZKYbRQd4ZT8V766z6mqNdOtIN5zaAMM3+zY
         Ccfuz1Uxqi9+bTejQpBxdJFnwFNtl8e+9DfeSubnxiDq6WSGMqEm747p1/Cr2kzLnRkA
         Llb/635HmYVBJB4MfFizIPiS+ANEUgQoIiHmV9WDRvmG7Kjx49gMJ9g1SMilEx7YQYXH
         HYsOnwLfXk8z1mW/XCYLViruoVu1qlIWAhCVUWC88btngDCzwx4seWUCSOB2jG2cMqWJ
         0gP8vmZovNjVzoBxGG9xkZVvYyERVYQIrOHXXq2bBiEuzaidmn43w9n82CyGys1J8Qbj
         f68w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770542716; x=1771147516;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3k1pQBX12h0BSUE4QM+2bV+LNA/Oczy6ilqlLzeMHL8=;
        b=PAUVXEEZ5VT87i1r6hsUfaBwFxLVxMXL8GJvOkroeQpejLeUz//dzN9KE0oyhLdKnH
         aR37DWzTwp0AYfdIVFFhp0vikqpMlJsfFwCTvHqKYglpu0hl5/BgCwIUPpJ4zOLF8h7z
         CXvh3iWfU5UU+2ixuAPP/gOHkFZMPhXRZ34EsscokHUd8qxqAYtiANj0ZCw/rTsxkjcw
         pvd2FOz7Chf2071qNoJQzMcn7P6JwUVvpmzAVwz/yEDUXU4oNpm3O6uPIpv+BidfqXvC
         P2NruFm7HBsk1KZRc9UK3toL+3ucDRSDQLsBln94STno2phuFVCPSGWC44b6PAFjXcqt
         GdkQ==
X-Forwarded-Encrypted: i=1; AJvYcCUfx6Pg/0oHsvOSeey74JXJ44DcVk59fU7/pD6vffKVVMcDTKb21cso0mB8bfeFbC/FenYE01XUa/c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6/qYqlinfMbijtGtxNVmCE6b4AvVpLYvXFUWGULShIX+iLtxz
	YH1uZbrNnBelCx/xb7Q4uQwTo0trMODJSHJqM1FT7jOdb/L+fBTn8gEx
X-Gm-Gg: AZuq6aKC0rSATsawhppGg+DJMPpz1TIrCmIymhxbMI1Ilb4uXHbSw56KwLV9SrNWOzD
	WklTGlg6XUt9eN6V6cH3w2//VjNxz+RtttbNapYRY+p47AxaRquidbCLmRhP3URXO9qBbQ7XjN/
	RWgvwjZwEAKyEnXSLxA0d2cbc/KyR4YKq7xvyYOZUqL/fCV66yJz6oaa9tl9jtPm0W4l5l+sxAB
	v7ggDxjPOy/j0SifXM/vorNlQrkU5cVA/bhQ5CepQBS/QXTbI/HKtxbwsnQGXptfLtuuLmk7SX+
	2Hdv/EpHHGAPSgXI3UHjz9MBQJSuLFTpI9x+yc7Pqxe4VwT7PeUhiSDZkxqA4USrNRz5mTrnxn2
	lX55141tgUNoACtcGbEOD/vgmC9IoBPVkMJ3OqYzy5RW0AH6NTAWbgA/nFCBlUI2zIDqK+nQriL
	ii3Y9VWfY11qMxmr4qZKr32gT3SLqqLFfiIoTrVZUYcmCGZwjcdMOSdCjtrj0=
X-Received: by 2002:a5d:5f82:0:b0:435:94dc:8c78 with SMTP id ffacd0b85a97d-43629378331mr12835803f8f.40.1770542715900;
        Sun, 08 Feb 2026 01:25:15 -0800 (PST)
Received: from ?IPv6:2001:818:ea56:d000:94c4:fb0e:28f:2a8d? ([2001:818:ea56:d000:94c4:fb0e:28f:2a8d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-436296bd211sm19565112f8f.13.2026.02.08.01.25.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Feb 2026 01:25:15 -0800 (PST)
Message-ID: <95ba8b40af82959dac08d3576579eb1451f28364.camel@gmail.com>
Subject: Re: [PATCH v2 4/4] iio: adc: ad4080: add support for AD4880
 dual-channel ADC
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>, Lars-Peter Clausen	
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron	 <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?=	 <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring	 <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley	
 <conor+dt@kernel.org>, Olivier Moysan <olivier.moysan@foss.st.com>, Mark
 Brown	 <broonie@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, 	linux-kernel@vger.kernel.org,
 linux-spi@vger.kernel.org
Date: Sun, 08 Feb 2026 09:26:19 +0000
In-Reply-To: <8685e3e53667e82c7cdfd66ee6fb1ec3d3c009cd.1770393792.git.antoniu.miclaus@analog.com>
References: <cover.1770393792.git.antoniu.miclaus@analog.com>
	 <8685e3e53667e82c7cdfd66ee6fb1ec3d3c009cd.1770393792.git.antoniu.miclaus@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-02-06 at 18:07 +0200, Antoniu Miclaus wrote:
> Add support for the AD4880, a dual-channel 20-bit 40MSPS SAR ADC with
> integrated fully differential amplifiers (FDA).
>=20
> The AD4880 has two independent ADC channels, each with its own SPI
> configuration interface. The driver uses spi_new_ancillary_device() to
> create an additional SPI device for the second channel, allowing both
> channels to share the same SPI bus with different chip selects.
>=20
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---

...

>=20
> -	ret =3D devm_iio_backend_enable(dev, st->back);
> +	/*
> +	 * Request buffer from the first backend only. For multi-channel
> +	 * devices (e.g., AD4880), all backends share a single IIO buffer
> +	 * as data from all ADC channels is interleaved into one stream.
> +	 */
> +	ret =3D devm_iio_backend_request_buffer(dev, st->back[0], indio_dev);
> =C2=A0	if (ret)
> =C2=A0		return ret;

Ahh that's a pitty. When I read the cover, I thought we would finally have =
a multi
buffer user so we could fix some issues with it :)

- Nuno S=C3=A1

