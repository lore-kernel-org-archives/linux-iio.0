Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98DEB3DC87B;
	Thu,  9 Jul 2026 11:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783596833; cv=none; b=QnyRBkoQOG1rMTfI66yKAP+te6fvlI2CdN6I0PbiGv3A1yu/ODsi8MIti7pIfb063ZbF8uV/feDHybk0WVn0ezpxNCeV8D/+dTMRHBmRZm8BA4PnJHiUFCM+g0wd7Zde4dVZp7UjKtbt18Tnb+ldKEoMGZJXpoJ54708npTleOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783596833; c=relaxed/simple;
	bh=2thS+JuQWS1aHyOnhwwCjgcgqnGH2cFOBsnA4gBpAxI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LtSblA3W/qMuAkGzc2BRrh7YFMlmlnpFA4fBQFNZZarCQQ6nEXcehQ1gybi4oyDvvVcTpKGwfDO6z0ue6+bylLQoi70u2GCl4TZqdq7AoZrkEMhA6+s4RuNhvzhV5ypnjgxGmZ+eAs3lDF6915eTWTQgKVtH2nd6RZf4p9dlB9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=FQpMwqAd; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="FQpMwqAd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1783596827;
	bh=2thS+JuQWS1aHyOnhwwCjgcgqnGH2cFOBsnA4gBpAxI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=FQpMwqAdRIn3M0kP6/OlbiLzjT0si4zJbqCPojCKm6ZSeftfVNy88DMWBPStVuMf1
	 G53rubUvC78GfVJTwajO0SwFxVeyHIZtXWJwd170pPBi6oPvfRRFF0u3NsXOq/6roy
	 KwUfmbktZibJ0la8/V2E1ev0x0R8h4oMmDoRVHiXtwzDLYIgecsHWMSupBpNVZ3975
	 145ng3SJPo4HJPXr2PoyPVykbDENKpUHmX5bSAZDChYW05n9xZySGrvPv8Caq5YAuP
	 u8kXXOwhgRou0GjEup1OXYtpARqme7HT3H8i8YxOfWUK7C1tYpKa6TYzvoCqVU/WIm
	 jZulT9VDU7KKg==
Received: from [100.64.1.21] (unknown [100.64.1.21])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange x25519)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id ED4F717E079B;
	Thu, 09 Jul 2026 13:33:46 +0200 (CEST)
Message-ID: <f2d5801c-1d12-4a61-ac23-aa24dfd0ee5c@collabora.com>
Date: Thu, 9 Jul 2026 13:33:46 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/4] AUXADC driver for the MediaTek mt6323 PMIC
To: rva333@protonmail.com, Jonathan Cameron <jic23@kernel.org>,
 David Lechner <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>, Lee Jones <lee@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, Ben Grisdale <bengris32@protonmail.ch>,
 Conor Dooley <conor.dooley@microchip.com>,
 Andy Shevchenko <andriy.shevchenko@intel.com>
References: <20260709-mt6323-adc-v5-0-d11b8332a735@protonmail.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20260709-mt6323-adc-v5-0-d11b8332a735@protonmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/9/26 12:52, Roman Vivchar via B4 Relay wrote:
> This series adds support for the 15-bit AUXADC hardware block found on
> the MediaTek mt6323 PMIC.
> 
> The previous version of the series for all AUXADC, EFUSE and thermal
> drivers was split after Krzysztof's comment [1].
> 
> Tested on the MediaTek mt6572 and mt8163 SoCs (Ben), both paired with a
> mt6323.
> 
> [1]: https://lore.kernel.org/linux-mediatek/20260504-mt6323-v1-0-799b58b355ff@protonmail.com/T/#med30fad67a090be35f549231336b2dec295233f6
> 
> Tested-by: Ben Grisdale <bengris32@protonmail.ch> # Amazon Echo Dot (2nd Generation)
> Signed-off-by: Roman Vivchar <rva333@protonmail.com>

Whole series is

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Cheers,
Angelo
