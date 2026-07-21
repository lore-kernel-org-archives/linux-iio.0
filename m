Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B2CF38E8AB;
	Tue, 21 Jul 2026 19:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784662807; cv=none; b=jQvNhid2ZMbI1nb5T8qUSwfLz2RN0m3klD4DmE3pVrPQdgzg0vwbjhkLBBBgW4yi1R4IUS+qN/vfTwVDs7Sfx2pOkBEk1g7KQsO+2h1tLBwgK5OTwqYwQwvITCpb3oKeDV7BEr5VwTfS7Dlb1PAvKvwn77jDBCDHEq7cRFs/jms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784662807; c=relaxed/simple;
	bh=YU/4yB+wDX4I0rtUcTZauZ5LkBNnDFH/mN+ZLzoyXTg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=UYG3MokjfFAN2Bnu5pKDAJkyiW1YJLLicefc0qdRzOg+EOvFv7P85Q+91U6CtO5J25usRK/0SM8RCHNOyuaEEQU3JDP+VqtIdZAuPdhXzPdu5A7EBOK2zec0rlwqXdnruC+lgrga768wPDSV9ACHYFMioYJi7t5UcwHxCNnB+qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 506241F00A3A;
	Tue, 21 Jul 2026 19:40:01 +0000 (UTC)
Message-ID: <076d0c6d-f995-4423-b5a4-5ecd3b684b50@tuxon.dev>
Date: Tue, 21 Jul 2026 22:39:59 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 11/13] ARM: dts: microchip: sama7d65: add cells for
 temperature calibration
To: Varshini Rajendran <varshini.rajendran@microchip.com>,
 ehristev@kernel.org, jic23@kernel.org, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, nicolas.ferre@microchip.com,
 alexandre.belloni@bootlin.com, srini@kernel.org, marcelo.schmitt@analog.com,
 jorge.marques@analog.com, mazziesaccount@gmail.com,
 Jonathan.Santos@analog.com, jishnu.prakash@oss.qualcomm.com,
 antoniu.miclaus@analog.com, duje@dujemihanovic.xyz,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260630093603.38663-1-varshini.rajendran@microchip.com>
 <20260630093603.38663-12-varshini.rajendran@microchip.com>
Content-Language: en-US
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20260630093603.38663-12-varshini.rajendran@microchip.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 6/30/26 12:36, Varshini Rajendran wrote:
> Add NVMEM cell to ADC for temperature calibration data.
> 
> Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>

Reviewed-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
