Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 434B5388890;
	Tue, 21 Jul 2026 19:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784662398; cv=none; b=rwArg7uALsKrccDIu2QOF9QVKKP1aZ+Uvyd3d6UXVN62U8kzkLjt5QrRQceVrJsId1KRet4PeVpaoMaywQts1DcYeF7ryCkWerphi/THIa1PTb578JF8tVpUOqOl9lSJzEBO4HXeQdENNRA3ww1BwGdl7yNmQBPIGZICSc3P0HM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784662398; c=relaxed/simple;
	bh=+P3nVtAHCjoi3/mGL7dtOzPUa5yc7wbZ12Yya7uftns=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=BSA9wYmPt3gcCYVkSSUOaiSA+UQP7nWidh2+pdor1hcQyjYr+Zd6WYBj11b/R73uVeQ8PINdtt30rD+gO/SO6HJ7zXDKLVcQWsBVGsWCqY1SdqZK9Kz0E3lS6iGzna2l2Opt7WDj9vhax0jjHmiot7Do4FDpaSDo5PTqTv2RoUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 237D41F00A3A;
	Tue, 21 Jul 2026 19:33:11 +0000 (UTC)
Message-ID: <9aa15b9e-0e0d-4bb1-b8a0-a74806644104@tuxon.dev>
Date: Tue, 21 Jul 2026 22:33:10 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 09/13] ARM: dts: microchip: sama7d65_curiosity: Enable
 ADC, DVFS
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
 <20260630093603.38663-10-varshini.rajendran@microchip.com>
Content-Language: en-US
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20260630093603.38663-10-varshini.rajendran@microchip.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 6/30/26 12:35, Varshini Rajendran wrote:
> Add regulator, pinmux and enable ADC for sama7d65 curiosity. Add
> cpu-supply regulator for DVFS.
> 
> Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>

Reviewed-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>

