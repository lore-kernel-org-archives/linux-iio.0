Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2606C394EA7;
	Thu, 30 Jul 2026 18:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785436997; cv=none; b=sPHa2rcOKQHUYfd4P49b8SXT0pKrz7q9hF11mGuMyd9r+nt3SQrCtv2Aq7U2RJGf2vEetnwBTDUFVlh6yoArMwtIX94iG/Oyqg40evbH7P8IwTGXLehQzwITLxJi+7QCmJprAARMRy00DQOh17xCNXPRbN2BtMhfcR4C6ct8Wvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785436997; c=relaxed/simple;
	bh=tjMALBxvT4Zy3dLjs5ZKneQU7xx9uZZ7B7PpwPgIyyk=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=hwllK59GCfnU4CxTkXmVcHAri4XjvdsVMlkTHMldgP0niYhVKfFRCmJP8pOfSeUFvEiMYuwk9Z85gFNptQ20WeY7AaFrfbfOu5p8+PAVr9JRnAF/RECKPprXBLTm2/Eq7uGMRg6qAQ7LzIYVQNTuXo3Ch1LQyr6F588h4UVCsSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KPLhHT69; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KPLhHT69"
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785436978;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tjMALBxvT4Zy3dLjs5ZKneQU7xx9uZZ7B7PpwPgIyyk=;
	b=KPLhHT69d/1jD25C9hR1L2bafAyhICuhVuLNUA+/Mt5MucotkW9XF7jboDSMJ2DNSzKEE2
	WPldVMFo4pupYYdDU13JQheJvJWeUcZqNj6/JsW3bSVPJ0iRIxPxUzR5leIex7mw8VHDtM
	io6ZnZNK7otQYs0h8OOC0B1oOP+WgFU=
Date: Thu, 30 Jul 2026 18:42:54 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Siratul Islam" <siratul.islam@linux.dev>
Message-ID: <d2a10c41b24a340ab4649ffdb1b50bda85609893@linux.dev>
TLS-Required: No
Subject: Re: [PATCH v6 1/2] dt-bindings: iio: adc: add adi,max40080
To: "Stefan Popa" <stefan.popa@analog.com>, linux-iio@vger.kernel.org
Cc: linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, jic23@kernel.org, andy@kernel.org,
 nuno.sa@analog.com, linux@roeck-us.net, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, dlechner@baylibre.com,
 ciprian.hegbeli@analog.com, u.kleine-koenig@baylibre.com,
 joshua.crofts1@gmail.com, "Stefan Popa" <stefan.popa@analog.com>
In-Reply-To: <20260730131738.822405-2-stefan.popa@analog.com>
References: <20260730131738.822405-1-stefan.popa@analog.com>
 <20260730131738.822405-2-stefan.popa@analog.com>
X-Migadu-Flow: FLOW_OUT

July 30, 2026 at 7:17 PM, "Stefan Popa" <stefan.popa@analog.com> wrote:


>=20
>=20Add device tree bindings for the Analog Devices MAX40080 bidirectiona=
l
> current-sense amplifier with a 12-bit ADC and an I2C/SMBus interface.
>=20
>=20Signed-off-by: Stefan Popa <stefan.popa@analog.com>
> ---
...
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/adi,max40080.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices MAX40080 bidirectional current-sense amplifier
> +
> +maintainers:
> + - Ciprian Hegbeli <ciprian.hegbeli@analog.com>
> + - Stefan Popa <stefan.popa@analog.com>
> +
> +description: |
> + The MAX40080 is a high-precision, bidirectional current-sense amplifi=
er with
> + an integrated 12-bit ADC and an I2C/SMBus interface. It measures the =
voltage
> + across an external shunt resistor and the input bus voltage, and stor=
es the
> + results in an internal FIFO.
> +
> + Datasheet:
> + https://www.analog.com/en/products/max40080.html
About this link, there were some discussion in the previous version where
Jonathan suggested a more standard format (https://www.analog.com/max4008=
0).
But you seem to have kept the same url as before. I'll leave it up to him=
.=20
>=20+
> +properties:
> + compatible:
> + const: adi,max40080
> +
...
> +
> +MAXIM MAX40080 CURRENT SENSE AMPLIFIER DRIVER
> +M: Ciprian Hegbeli <ciprian.hegbeli@analog.com>
> +M: Stefan Popa <stefan.popa@analog.com>
> +L: linux-iio@vger.kernel.org
> +S: Supported
> +W: https://ez.analog.com/linux-software-drivers
> +F: Documentation/devicetree/bindings/iio/adc/adi,max40080.yaml
> --=20
>=202.53.0
>
Please maintain alphabetical order for the MAINTAINERS entry,=20
instead of adding it to the end of the file.
