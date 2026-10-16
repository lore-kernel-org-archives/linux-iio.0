Received: from rudorff.com (rudorff.com [193.31.26.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B64EF364EB8;
	Fri, 16 Oct 2026 14:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.31.26.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792162690; cv=none; b=B0FEvSTiy9S2MtQ8vwEI7ShoiHk9W6YvHijibvXqTge/MgvvI9Cv6sM4lhI9reCl8T3h0KVsxd2CjOFb52dMGW8icRboNCkLGv7ARy4QzMTODHQnQoxc0nJzb+Vl8cCArYemAxQ+2cTxsnr5HTf4FPJGu36J2kcMQAgV6VAPWl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792162690; c=relaxed/simple;
	bh=4ztPQJ2JqUS4dKv+CVwf97K2sz0l/OjRQSz5MIU0dic=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VSF3KSvEBcIAJJ7wTxczsd58LKeD9b4B6sXGdi76pjivYy6Q8INb6guWhH9gSqxTyWTUNwjt7GuPoeOdGAwYiidAk1gKMGiDOS9w5KzySnG47tcilEItNacQSbFyjBg0mTHoA2dwSahBZ76d09LfQUzk7NI5V/tg7qFIJzqmy0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rudorff.com; spf=pass smtp.mailfrom=rudorff.com; arc=none smtp.client-ip=193.31.26.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rudorff.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rudorff.com
Received: from [IPV6:2a02:3102:b60c:d00:92f6:52ff:0:7ae] (dynamic-2a02-3102-b60c-0d00-92f6-52ff-0000-07ae.310.pool.telefonica.de [IPv6:2a02:3102:b60c:d00:92f6:52ff:0:7ae])
	by rudorff.com (Postfix) with ESMTPSA id 58B0A406C6;
	Fri, 16 Oct 2026 16:58:06 +0200 (CEST)
Message-ID: <13c2c5f3-a066-495f-b2da-c764e00a9454@rudorff.com>
Date: Fri, 16 Oct 2026 16:58:05 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] iio: light: Update DT bindings for GP2AP002
To: Krzysztof Kozlowski <krzk@kernel.org>, Linus Walleij <linusw@kernel.org>,
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20261016-iio-light-gp2ap002-v1-0-7c93312fa8d5@rudorff.com>
 <20261016-iio-light-gp2ap002-v1-2-7c93312fa8d5@rudorff.com>
 <97417be4-fc92-4184-b4d1-43482e50983e@kernel.org>
Content-Language: en-US, de-DE
From: "chr[]" <chris@rudorff.com>
In-Reply-To: <97417be4-fc92-4184-b4d1-43482e50983e@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Am 16.10.26 um 16:45 schrieb Krzysztof Kozlowski:
> On 16/10/2026 16:43, Christoph Rudorff wrote:
>> add missing vled-supply
> 
> Please use full sentences.
> 
> Why missing? Did you check datasheet?

Yes, I did. I mentioned that in the patch fixing the driver.

> 
> Please use subject prefixes matching the subsystem. You can get them for
> example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
> your patch is touching. For bindings, the preferred subjects are
> explained here:

Well, I did ... ok, none of the three commit message subjects of that file 
were well formatted.

> https://www.kernel.org/doc/html/latest/devicetree/bindings/submitting-patches.html#i-for-patch-submitters
> 
> Subject - everything is "update". Be specific. See git history for examples.
> 
> Please organize the patch documenting the bindings (DT bindings) before
> the patch using that ABI.

Will do!

regards,

chris

> See also:
> https://elixir.bootlin.com/linux/v6.14-rc6/source/Documentation/devicetree/bindings/submitting-patches.rst#L46
> 
> 
> Best regards,
> Krzysztof

