Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D645242A7B5;
	Tue, 21 Jul 2026 19:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784662773; cv=none; b=uFTm9lHP/KA5ryOLmIuzPqwCq6KJpeAehIPOrYwm1y3wUM1MqCpXJmGEZWdYYxbjRbeBVPfcjWDwxGzr7UUsfSyDcbUGtjfOM7mgUfIpXaQXBS0IGIB9etz/EGOLEcpoKZF/9AwDs/I6frmSE/KDFQ5uo68IL0yHZzDBjGYPcaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784662773; c=relaxed/simple;
	bh=kXXTDp7YRBrDI+jpYrw4opxbA7UxHzcM/nZW4EcuJm4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=XV6RqH5LSgqEf+eqB1bpkgqMoLzrNLTsuxigwJA11EgEVYD99XCwnrhO6PmHpLWBR0z9AebMLNACdRIjF7exMDKQC2wQwWgy8CnRNDhLI5bxiW2BjqcLnRQg/ZMWKUU1JvZGXNX9gNlrWmWZt+qWV1zpMu3MuMJvVqX1cE8tCGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D13171F000E9;
	Tue, 21 Jul 2026 19:39:25 +0000 (UTC)
Message-ID: <30c072b3-120e-46c4-b959-dd72107a87ee@tuxon.dev>
Date: Tue, 21 Jul 2026 22:39:24 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 13/13] ARM: dts: microchip: sama7d65: add thermal zones
 node
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
 <20260630093603.38663-14-varshini.rajendran@microchip.com>
Content-Language: en-US
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20260630093603.38663-14-varshini.rajendran@microchip.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 6/30/26 12:36, Varshini Rajendran wrote:
> Add thermal zones node with its associated trips and cooling-maps.
> It uses CPUFreq as cooling device for temperatures in the interval
> [90, 100) degrees Celsius and describe the temperature of 100 degrees
> Celsius as critical temperature. System will shut down when reaching
> critical temperature.
> 
> Signed-off-by: Varshini Rajendran<varshini.rajendran@microchip.com>

Reviewed-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
