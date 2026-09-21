Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF643ACA60;
	Mon, 21 Sep 2026 10:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789985766; cv=none; b=Sb9xo7AXsBGNK39wpzSv4mhhUGRxemKT+yrSPdLkm4QulEEsHTQ08Lj0qEFm7ea1dzPJz4JPIQeC/FALXHJQx3R45af0P5eJCbicr/f0kCD5jllVa6a56mjK8lEp+cMnk+RMsFX/IxHqBirTSQsOHeGmAjVGU+rECM7bd85Y+1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789985766; c=relaxed/simple;
	bh=Lo6e24+OYras1PE/uj4vcsvTH4ido1eqB1uEmKdu8AA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b5G9QLLaX34KT6eTtlhlt7o8hN7zMbvSccAyR0OuhkyamRqz5N4/8zfrO+jc+ofIGza78E6BtZpXh8Wg130EnJm8HJdLffuybhMyEstiuCR/c/rpn/Y6tgPKzpKttSBMxbFa4qzvUphY5wdgMap7uvoFk/gJjPoCAUIt6wid0Ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=VfHMWqm8; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="VfHMWqm8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1789985762;
	bh=Lo6e24+OYras1PE/uj4vcsvTH4ido1eqB1uEmKdu8AA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=VfHMWqm8b9SnxR37a2o+QHFo05DzegEUwaCfzQU/6eS3IyI2Ccii7SQVwhZD8qGlJ
	 wFEbG89uI/HGYx5imCLuXEdiU9+L51gbcm8BU3pEpJ0hA0cgVT4bNZzIbzGTpPwlRG
	 YzFkkrkcnccFD1fWXVgTKdHXa64v6rjvfqhzF2ziIHSXEp/5UDKFlQE5XpYgeU0eGW
	 my+doEkkJcDrMkXOZ3uUcOF7frqTwW5L0vECs/MuIvE5fj1l81G9wjvx6K7Tn9B1DA
	 YKjWxODMOeeM4wIiDJwW3WYOrj2fNfYIqx46Zw6SjmIZLH94fREHdI2GKWZXX5BYso
	 kpBNDYvQEqfsg==
Received: from [100.64.1.21] (unknown [100.64.1.21])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange x25519)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 0641417E020C;
	Mon, 21 Sep 2026 12:16:01 +0200 (CEST)
Message-ID: <817d5599-a2ad-4f47-ab07-a74b0325950d@collabora.com>
Date: Mon, 21 Sep 2026 12:16:01 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] dt-bindings: iio: adc: mediatek,mt6359-auxadc: add
 mt6397 PMIC AUXADC
To: Ryan Brue <ryanbrue.dev@gmail.com>, Jonathan Cameron <jic23@kernel.org>,
 David Lechner <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>, Lee Jones <lee@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, mfd@lists.linux.dev,
 Roman Vivchar <rva333@protonmail.com>,
 Luca Leonardo Scorcia <l.scorcia@gmail.com>,
 Andy Shevchenko <andriy.shevchenko@intel.com>
References: <20260920-rbrue-suez-upstreaming-mt6397-auxadc-v3-0-c00edacbee64@gmail.com>
 <20260920-rbrue-suez-upstreaming-mt6397-auxadc-v3-1-c00edacbee64@gmail.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20260920-rbrue-suez-upstreaming-mt6397-auxadc-v3-1-c00edacbee64@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/20/26 07:31, Ryan Brue wrote:
> The MediaTek mt6397 PMIC includes a 10-bit AUXADC used for battery voltage
> and battery temperature measurements. It is not register compatible with
> mt6359: a conversion is requested by writing a channel number to a select
> field and pulsing an edge triggered start bit rather than by setting the
> channel's bit in a request register, and the results live elsewhere.
> It therefore gets its own compatible rather than a fallback.
> 
> Add the binding and the header naming the channels a consumer puts in
> io-channels. The battery channel is named for the input it measures,
> ISENSE, which is what mt6323-auxadc calls the same input.
> 
> Assisted-by: LLM
> Signed-off-by: Ryan Brue <ryanbrue.dev@gmail.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
