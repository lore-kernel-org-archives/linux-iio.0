Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A7F4AEBC4;
	Fri, 11 Sep 2026 18:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.229.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789150215; cv=none; b=ct4a9iF9IqrVG9OyHLN6jSaG+pgfXKGzDgRwCpK1g5Uecc2+wpiC99yy8nUkeS3ewBnkoZFROwDNdT4dcHC2o/f+Qi6TLBG6H8+IaSYKXik5vTR2SNT9WgbIxm0JN+H61nkqasmRlXcZJDQoIl+JHJPnQ10gwpiPTMJnF+eZx44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789150215; c=relaxed/simple;
	bh=P56sGtJ8Djp3z7uGYz7K/bRh+Bonq43cI5XEAgw/okg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O6tcap/fY/OyQl/sf92adIB9Rl95QPpyQrLkrU15MLe8/t0Em2XYG8RwvriVNGJmII/0DqoI0EFH0rNTyB2bqxqj5gvx3g+H+8qK/hfM0HIlPy40h2RZ7ThfSxAKcw68Ugmm2PwJfHfpoGBOBmcGIqfoJhQcgQSgBIBHEvK8Tgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=G7jxFTOI; arc=none smtp.client-ip=178.251.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b="G7jxFTOI"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0C2BE10327B;
	Fri, 11 Sep 2026 20:10:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1789150204;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=mQrma2LURwgBlfZT2emMUrj5BCk1p1v6AScmI3ULZLk=;
	b=G7jxFTOI+nFLXuX9a6xdxGOgwyMQbM/aKI4ahgSKjW53Dx/lLOw1bpLY4Sw4bpwlR5crDt
	s305K6iI67A1Skcf65juGH1OAM3PAYUYEpGzQsMo/Q+FTF0Z8bgZXnIvBnwbpinqBugUxU
	ueDHFhSLkPnhW2lWx4dEdu5GuVPnonPZLdu8P2YZ0wYiiwmLecndAGMt3Anw2Y5Z+wXgra
	uyhLEN3DwCgnRrq25l9JGAsFd71A6A/JbDF+4QAN2cODo0ura/rDYdYPDbqPsgTIGdKFJF
	HKeCELxPW16YxhKQssl7kYqsT1ZKnzOOTF4WOiOwCfoAGBdBsGamY7Ycp6YJ6w==
Message-ID: <40827aa9-e7a9-42ee-a004-96d530e377e0@nabladev.com>
Date: Fri, 11 Sep 2026 20:10:02 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/8] arm64: dts: st: add vrefint calibration on stm32mp23
To: Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Olivier Moysan <olivier.moysan@foss.st.com>
References: <20260911-adc-stm32mp25-v1-v1-0-cef26eecdef2@foss.st.com>
 <20260911-adc-stm32mp25-v1-v1-4-cef26eecdef2@foss.st.com>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <20260911-adc-stm32mp25-v1-v1-4-cef26eecdef2@foss.st.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 9/11/26 5:51 PM, Fabrice Gasnier wrote:
> From: Patrice Chotard <patrice.chotard@foss.st.com>
> 
> Describe vrefint calibration cell to be retrieved by ADCs through bsec,
> on STM32MP23.
> 
> Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
You have to implant Co-developed-by into this , please fix globally.
