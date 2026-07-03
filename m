Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6204731064B;
	Fri,  3 Jul 2026 18:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783102165; cv=none; b=Vz6vZxVNeI+8o6/NDcT8Iw+DuAxTvLnXleHwG0ToZjZLcO+FvAWJwwaxgCg4N6+9UcyrB9kj4uiV4OM8i/2R3zAX6Pq2xVzHW2lsh8lmT2y46XwGJmQZrK4srzx7nnv32K4u61y8ursIr7o5Ek/V3aYarMn012da22lY5l6GUHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783102165; c=relaxed/simple;
	bh=yNA/4HKAUUc0vxBuSIvnW8HtCeJPKyqgojGJ2iyx/fE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M7W7jEkT4OP6RvRRC4pyaXB+0Q7KYBvYiVIxg50toQ10/raVHD1BZJ0JSLH6eRN7YEjEkXaBrRIecG4nXVDgiD3Ht7OYjpnJVDszRBX8Ikkinn8hB6DoE1A86UVQVTHNrxelpEtS7FRekH6kB+uHrSaZ5cPk0vnV/CBWbf0t8OM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I19Du1Fw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I19Du1Fw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDAB61F000E9;
	Fri,  3 Jul 2026 18:09:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783102164;
	bh=Gt1g2jGABpVjMdY1s+MJCjyBjm5LGxSMGoVhyMP1AGQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=I19Du1FwDB2Llf3gWLIuHPsDVsFO4mUY4KeLxA/YCmtIxQOPyBIcStJLtFMWdea6L
	 Npb2EwMrm5ysOfoamdIxIQl9W4izy8AuhCsIYu+t+Vq5ktTkE7ASJ//xroMibsn7zG
	 mNe7ADxP5Y3IdCER5QaDICms0DIey2wJbz/7MXp9e8evZGZzDkZt4meqRpspl3x7wY
	 aGzO4BY/xGPvjwCU9AZtHd8skoptWt4vuj65wN44akjalVEaKkiEyZ6azORcR5dwff
	 kB/LzJeHS+qap8ULdKfVyhg2Xlkl48yYUX6nsuEzXhDg60aphYXDohdGxbYyEDgD80
	 yn6v7SQDBI1/g==
Date: Fri, 3 Jul 2026 19:09:20 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Rodrigo Alencar via B4 Relay
 <devnull+rodrigo.alencar.analog.com@kernel.org>
Cc: rodrigo.alencar@analog.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-hardening@vger.kernel.org, Lars-Peter
 Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Philipp
 Zabel <p.zabel@pengutronix.de>, Jonathan Corbet <corbet@lwn.net>, Shuah
 Khan <skhan@linuxfoundation.org>, Kees Cook <kees@kernel.org>, "Gustavo A.
 R. Silva" <gustavoars@kernel.org>
Subject: Re: [PATCH v6 13/16] iio: frequency: ad9910: add output shift
 keying support
Message-ID: <20260703190920.27adb87c@jic23-huawei>
In-Reply-To: <20260618-ad9910-iio-driver-v6-13-79125ffbe430@analog.com>
References: <20260618-ad9910-iio-driver-v6-0-79125ffbe430@analog.com>
	<20260618-ad9910-iio-driver-v6-13-79125ffbe430@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 18 Jun 2026 14:27:29 +0100
Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:

> From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> 
> Add OSK channel with amplitude envelope control capabilities:
> - OSK enable/disable via IIO_CHAN_INFO_ENABLE;
> - Amplitude ramp rate control via IIO_CHAN_INFO_SAMP_FREQ;
> - Amplitude scale factor readback via IIO_CHAN_INFO_RAW (ASF register);
> - Automatic OSK step size configurable through the raw_roc extended
>   attribute, which allows for selectable step sizes in raw units:
> 	- 0: no step, means manual mode (NOT pin controlled)
> 	- 1: I_FS / 2^14 step, automatic mode (pin controlled)
> 	- 2: 2 I_FS / 2^14 step, automatic mode (pin controlled)
> 	- 4: 4 I_FS /2^14 step, automatic mode (pin controlled)

Trivial but good to tidy up formatting. Space after /

> 	- 8: 8 I_FS /2^14 step, automatic mode (pin controlled)
> 	- 16383: I_FS step (max), manual mode (pin controlled)
> 
> The ASF register is initialized with a default amplitude ramp rate during
> device setup to ensure valid readback.
> 
> Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>

