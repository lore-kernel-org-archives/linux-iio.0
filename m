Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D6DD367288;
	Mon, 21 Sep 2026 10:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789985807; cv=none; b=HRwMICKN2MzIOKrhA8pijW7h+S2KVlrw+kAIEsgH+q/ythFWEL92fxtac8A2SSm556E24u1/nK/GvO2hVtQU+PWtjGp6gh84cFUe4O/wcilbf9qo41fk7twPL4GC0DMjoqxnhYaOZwLd2ReXWp+sT6ZsldEFM+bSHFoC/yE3lR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789985807; c=relaxed/simple;
	bh=DVHjoDLlRZ8xarvRTXy+GeqFMaFzqMyhGQvV2Jvh3ms=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RvtIYwapkc09RlftwQbhpxAC7PI/XVVuzCVFUs/Dzo5fm6PbHkaK0css0Sxwod4fQF767RWye3Qt8Slr74fXcljghyHxjiunLDQSLd3SdDRWoSUWBifrnqP5FegZyKdQbYU/Gm3+fHVGG/gPVv26y3jb0ZiQUUbKSf/Sgnmfc7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=fGkWIRlU; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="fGkWIRlU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1789985804;
	bh=DVHjoDLlRZ8xarvRTXy+GeqFMaFzqMyhGQvV2Jvh3ms=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=fGkWIRlUpT3FUMIocCMnGjrfqk3tG23xRw/lOgpYwLSIUor1o7zDXMvYSjiBQHNje
	 82q2pjNI7OynoPk06TSzBBrp2dFXlzZJ4U6C3AGpPNpR9ZYLcK4qwKlTVHi75zdaaF
	 yxAyEzpnnqnNLNy/9LyacTq82h6slOISlpYVfTRz7ZXjsNUqhN3xVCQRpVTpfKWuI/
	 Xi8rM57Wyh23iVTXAgSB6eWB3V+uQCykH1qiO5scVgRlgHLYTwOmUD9fLvHVmfNuY1
	 oHZ5XJ4uUW9kAf4GNCjQmGig2kFW/MHcvJRcFpZt+8W2JV61c/CvnGuPm+I8wCElPG
	 yzCW6NZE2gZtg==
Received: from [100.64.1.21] (unknown [100.64.1.21])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 070DF17E047B;
	Mon, 21 Sep 2026 12:16:43 +0200 (CEST)
Message-ID: <fc0fcb6d-a935-4795-91fb-f3ee17ced650@collabora.com>
Date: Mon, 21 Sep 2026 12:16:43 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] mfd: mt6397-core: Add mt6397 AUXADC support
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
 <20260920-rbrue-suez-upstreaming-mt6397-auxadc-v3-3-c00edacbee64@gmail.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20260920-rbrue-suez-upstreaming-mt6397-auxadc-v3-3-c00edacbee64@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/20/26 07:31, Ryan Brue wrote:
> The mt6397 PMIC includes an AUXADC. Register the AUXADC in the mt6397
> devices array to allow the corresponding driver to probe using compatible
> string.
> 
> Assisted-by: LLM
> Signed-off-by: Ryan Brue <ryanbrue.dev@gmail.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

