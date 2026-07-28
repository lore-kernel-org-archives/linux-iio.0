Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D97862DCF45;
	Tue, 28 Jul 2026 08:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785229027; cv=none; b=I7mNEoSlL/DOQMXCSITTWJHCDJlycu0mldwhiqjJR8ljVNfLPska4Hbwa1FxUNNxUrbLS4btJgDxCgPME0FB+e5ew5BPNKqeKcblvzMl1AbxhiLMvDK7veACI0DMQChxQUHn7gU0B9VZ/7hDcl6epA0rsPIdCncyfPpAeQBUMes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785229027; c=relaxed/simple;
	bh=Espnjtem9bvcKUaeF4V7sJlCl/16E1+vcH39OyQyhxA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jv+gnul9KDanzY2PIAuZqgAtaeuSclFH1IhvVBMZVw9wHZvvSB02s+OoR165317k06ZU7d6bltDdPnknDUw2LC7kL7raLDeeGHDIMGcGXKx1oLOQ7b7WDAg5yU/ZAfCO057p3R5FPHhWZvF7Hfeq9yiG7P6nlogGzyLvGzO0pf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=hPJBJS7Q; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="hPJBJS7Q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1785229023;
	bh=Espnjtem9bvcKUaeF4V7sJlCl/16E1+vcH39OyQyhxA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=hPJBJS7QLi4Vjmi7xZtFmjRuReuaYGx0yP6leV84veSFvdQe7ls6qY16trOVe9Odf
	 0YJPqyKfVzbzdMurUm6FypTE/868DSpVHeZ+m9ZOG3nN6o9kYXNaY2a+osDazQu1hW
	 7QejtWtQQZvLhDrb+LAM+sh0tfUISgkU1qfe+0jU0cZ5cdGw1R2gdc+uqZ/NJWgEU4
	 yaxi3Q3jEGzKG5TbAp+pEhAeVpZlStbKksKA0LA4Pq0ExPj0KGPdqJCi7/mSWrxnvb
	 QtWbrcTPqvibMbRTwJC+BPMLW6TZ2gqfIXjKitFHIsNjn1eiOh1g1XJN2nAS0o/d35
	 n8KmDlshds6CA==
Received: from [100.64.1.21] (unknown [100.64.1.21])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 0CC2917E0676;
	Tue, 28 Jul 2026 10:57:03 +0200 (CEST)
Message-ID: <0b63e6e9-2a0b-44c7-a0bf-66a5aac9610c@collabora.com>
Date: Tue, 28 Jul 2026 10:57:02 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/4] AUXADC driver for the MediaTek mt6323 PMIC
To: Roman Vivchar <rva333@protonmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 Lee Jones <lee@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 Ben Grisdale <bengris32@protonmail.ch>,
 Conor Dooley <conor.dooley@microchip.com>,
 Andy Shevchenko <andriy.shevchenko@intel.com>
References: <20260709-mt6323-adc-v5-0-d11b8332a735@protonmail.com>
 <f2d5801c-1d12-4a61-ac23-aa24dfd0ee5c@collabora.com>
 <20260710005424.5c559b5a@jic23-huawei>
 <c11705b1-fc46-440b-a27e-0cc38f3b2d69@collabora.com>
 <92F7jsoczEi2TOWKT6Qqmppk-KE3uJjCKASTXa0RPV7nJZVfXhxdbuP9RptMsvV4_dnvJAlCh9NYvmiiO2mDGQojZoCozVKhXyOJmp2x6AM=@protonmail.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <92F7jsoczEi2TOWKT6Qqmppk-KE3uJjCKASTXa0RPV7nJZVfXhxdbuP9RptMsvV4_dnvJAlCh9NYvmiiO2mDGQojZoCozVKhXyOJmp2x6AM=@protonmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/28/26 09:58, Roman Vivchar wrote:
> Hi Angelo,
> 
> Could you take a look at patch 4 (DT)?
> 

Yes, I already did, but then I forgot to pick it because ... reasons?

Thanks for the ping, btw.

Cheers,
Angelo
