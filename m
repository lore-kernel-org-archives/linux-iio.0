Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D62F33955C1;
	Mon,  3 Aug 2026 06:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785737322; cv=none; b=qPtEllhHBluvn4NTxiw4ur/iAY9b6JjjXQ4yPdY0hoW3pvZwgJwY53B3tcbd/p1tus0GZNkFGuXGRsgHBxFWY0vd+Rg8HAtsHsxnM2XZFqLLjiWFxTVgO0fgmHzTMaI4xHi5+ZM2vCD1VE3n0Ul44RFa+OTc21ZSMJPDCapdz8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785737322; c=relaxed/simple;
	bh=KrKJrVGdRrFMxGRITTjazMUcrERHPeiQZarjjwl9E3M=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=mMOAIAZNOHhTJQijFdlFuczaxWLJDnZ3Lbq9eAsJojCocQp/A0bRm+cEbumUuTte44iUjldn4DogicBNt9HXX/TR2dTP2W2kpYVyROo4yIJefToCa9TX47kvRiuVhfp4bEnr8rgsWB43JthK/Kylv7eCtY5RN/ym1SJ+tB8GoU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TCBYUIhH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TCBYUIhH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A350A1F000E9;
	Mon,  3 Aug 2026 06:08:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785737321;
	bh=+429yca2FdBmTXuXrcptqdw7Fqp7trYqd3GPV3frqbY=;
	h=Date:Subject:To:References:From:In-Reply-To;
	b=TCBYUIhHN4DucVc47pLstmUpT4hF82ufvFaZBEzKeeOWC127Bun1glCqoNRff040R
	 Tzm5d8Wy9KdrAXEJ671Bd7m6HVMD45VuBir9mvQnnDlSeiyvvHowCX0O1RCkrkcR/t
	 wcsrKji5wfh/fyLijxWZVpeL6NHsBInN90EqhSZgv87/UUkYJyHlCcEGIxwo/+PTy+
	 EogkVA6flmZMn5h69PEiME9B11PBZ6nxS5S4WXF1eMAoF49Uw85PQFamsJYg7UPaiQ
	 vtJyPXIJWlYQrIqZLNsyztIt9V1i/L0jO/QsRcWSzdikc2zfPC1Pq5JbTc5C81f1lE
	 S6AKIphzKGKFw==
Message-ID: <702e24f0-7dee-4a12-9665-49e85f407b16@kernel.org>
Date: Mon, 3 Aug 2026 09:08:34 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 03/16] iio: adc: at91-sama5d2_adc: rework temp
 calibration layout handling
To: Varshini Rajendran <varshini.rajendran@microchip.com>, jic23@kernel.org,
 dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, nicolas.ferre@microchip.com,
 alexandre.belloni@bootlin.com, claudiu.beznea@tuxon.dev, srini@kernel.org,
 marcelo.schmitt@analog.com, radu.sabau@analog.com,
 Jonathan.Santos@analog.com, jorge.marques@analog.com,
 joshua.crofts1@gmail.com, jishnu.prakash@oss.qualcomm.com,
 antoniu.miclaus@analog.com, mazziesaccount@gmail.com,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260727122633.117435-1-varshini.rajendran@microchip.com>
 <20260727122633.117435-4-varshini.rajendran@microchip.com>
Content-Language: en-US
From: Eugen Hristev <ehristev@kernel.org>
In-Reply-To: <20260727122633.117435-4-varshini.rajendran@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/27/26 15:26, Varshini Rajendran wrote:
> Extend support to handle different temperature calibration layouts.
> 
> Add a temperature calibration data layout structure to describe indexes
> of the factors P1, P4, P6, tag, minimum length of the packet and the
> scaling factors for P1 (p1_scale) which are SoC-specific instead of the
> older non scalable id structure. This helps handle the differences in the
> same function flow and prepare the calibration data to be applied.
> 
> Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>

Reviewed-by: Eugen Hristev <ehristev@kernel.org>
