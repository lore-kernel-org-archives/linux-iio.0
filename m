Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.251.105.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794912658;
	b=O2DT9W9ylmiExHHZw7IgEWFCGBkG6pXAAf+58S67V7qaeqZ5Dtdx8lDTsb2pBXr5IhoH
	 D2477nSxQdfmrtj959ovv749ArmjTYqp5m1KYVdt0dchKKI32ctFEmoWWc/rboS19DhGi
	 FmMHrGin/9YENkM7LcpYD3cJts7/KzXbADG5b+Kp6KcyVC3gA8lyGzRX/7EQp3BYeMdwK
	 WDNHKO2jyjYiuBG5JKxTchiyXCVKIDNQcxk8xUPgdSL0AJ32wbfX0lpuBgvVspabbEVsp
	 ziUbrWkg/llm2mdtE3kLWidmKiO2s9rRDlBi3MVfGOXhlEFFYVskfz7xOrnmbbBD6UA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794912658;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:From:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=dQe8cmA4nsyOb9bGE5lcRIBNwi+AFNzjopJUX/lBJMU=;
	b=iaNro0pamZ8wHMDHWnf/qJNXB2TGIsB05NuhWgkqjgAh+IPzRbx7IRz+lzOP3V33A+R/
	 QEijlNgnqda0ByK20TWx0EmPROnw1jBUWiIfPchevbcGfms4JXAh1HuFDH/jGrBq0Ttxu
	 aHf+sADz5uwOUt3ilyt2je0UN2QCBJhS5jUTDROZTujDuRKnQ3gOr3aUXArNaU/yYrYBt
	 90YQL2hfSg64XhgssqNVRqIuVOPQTqdhfxlkLsOIOrKEZQXNY4Lobc4Bqd0sPqaJi2iYS
	 D9WQIZDMMkbzU/idtG/BzTvBTex/R8JV50jkSTIY3S0StSk2bWhZ/BOQB49RvVv6XQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=okI7KpRd;
	arc=none smtp.remote-ip=148.251.105.195
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA6D606A31C;
	Tue, 17 Nov 2026 10:50:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6EA6D606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=okI7KpRd
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1794912655;
	bh=BJ7G2PRuc7uvUsxw8X+YUPtt6Tmdw+QHSmLN8I9bpK8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=okI7KpRd2hnHUCZ6KFPvVdk06X3NDoOg1vcpLGIV5POlhc3Hl63myTKOGqEmNZLQF
	 bAr6z5nKfVxLK68MDnrUL7CH16nB7WCCXFLmIWYYomRM1WRSMm7QS29DQhn7cedeBm
	 HnE7b+NTsL6FKWJRYKLjKbVMOyiNDSq+LowgjrVHIAbukJmNA38UYs97MPAvrXbVf/
	 AsXFX79K499lmar9Pox5XQSaH6rAM28oFhWTodehVuFSIlP9IZ6/DHPKuIEPH/h8Ec
	 cdDofK6xQmLtdYbmyVF8QMWJ4jThGtQ/yqHVqt2K0QPkgSNmtBe7lXNcqWuapbs/9G
	 rHac4mVK5ljPA==
Received: from [100.64.1.21] (unknown [100.64.1.21])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange x25519)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id E565A17E04B4;
	Tue, 17 Nov 2026 11:50:54 +0100 (CET)
Message-ID: <b1b4c984-14d5-41b3-84af-10df541790dd@collabora.com>
Date: Tue, 17 Nov 2026 11:50:54 +0100
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/2] iio: adc: mt6397-auxadc: add mt6397 PMIC AUXADC
 driver
To: Ryan Brue <ryanbrue.dev@gmail.com>, Jonathan Cameron <jic23@kernel.org>,
 David Lechner <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>
Cc: Roman Vivchar <rva333@protonmail.com>,
 Luca Leonardo Scorcia <l.scorcia@gmail.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 Andy Shevchenko <andriy.shevchenko@intel.com>
References: <20261025-rbrue-suez-upstreaming-mt6397-auxadc-v5-0-5c3c7a5a1851@gmail.com>
 <20261025-rbrue-suez-upstreaming-mt6397-auxadc-v5-2-5c3c7a5a1851@gmail.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20261025-rbrue-suez-upstreaming-mt6397-auxadc-v5-2-5c3c7a5a1851@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/25/26 06:18, Ryan Brue wrote:
> The mt6397 AUXADC is a 10-bit ADC behind the SoC's PMIC wrapper. On boards
> built around this PMIC it is the only way to read the battery: the SoC's
> AUXADC is wired to board thermistors and the charger ICs these boards use
> have no ADC of their own.
> 
> Add a driver exposing the battery voltage and battery temperature
> channels. Only those two are described, so a channel ID in the device tree
> indexes the driver's channel array rather than the PMIC's channel number,
> as mt6323-auxadc does. The ready bit lives in a channel's raw result
> register, but the value comes from the chip's factory-calibrated copy.
> 
> The battery voltage is measured through ISENSE, because a board with a
> switching charger in the power path leaves BATSNS on the charger's system
> rail instead of on the pack. The thermistor only reads correctly with the
> PMIC's battery-detect bias and input buffer enabled, which take 20 ms to
> settle. Both are switched back off afterwards.
> 
> Reads average sixteen conversions in software; the chip's sample
> accumulator makes no measurable difference at any setting, so it is left
> at one sample per conversion.
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> Signed-off-by: Ryan Brue <ryanbrue.dev@gmail.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
