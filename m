Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6DB746C4B5;
	Tue, 21 Jul 2026 19:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784662711; cv=none; b=sEHkc55A+BCAQuj+Hj/4XSHEZjvaHrp6ljEtrFhmnlWBOD+7wdgkteXEbRu9Bdwk1861AFfayrhxOXxfXxSiwZXQsiE5Rc1Js40AD4e53VoIfApCUD1/y0cL11/4dUo71WDeeAskg23xWa5DfDdtv4uJ1hSHW7+rEk5u7ZfhbP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784662711; c=relaxed/simple;
	bh=FC9xajO74RnTtad5w93op62Lwxp7rVk1+RYahkhTJNo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Z7VVgT+O5qVdTusXpwHFi8GLQiOQgd7wlW+F007fE52uBIZ6GLo4mbhq9LT99kn0rkR0C6AIH27/3CU1qic/b2X+RnQ/EICDd5ypPTKWCTkWiByfpXwfzYkB0bumJsXqELnT3p55dr2hzfSwKE4HTKcRG2QWr7yH0NMDt8n18C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B77D31F00A3F;
	Tue, 21 Jul 2026 19:38:24 +0000 (UTC)
Message-ID: <74e3aeee-d18f-4476-b503-8f87578cbfe4@tuxon.dev>
Date: Tue, 21 Jul 2026 22:38:23 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 12/13] ARM: dts: microchip: sama7d65: add temperature
 sensor
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
 <20260630093603.38663-13-varshini.rajendran@microchip.com>
Content-Language: en-US
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20260630093603.38663-13-varshini.rajendran@microchip.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 6/30/26 12:36, Varshini Rajendran wrote:
> Add temperature sensor node.
> 
> Signed-off-by: Varshini Rajendran<varshini.rajendran@microchip.com>

Reviewed-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
