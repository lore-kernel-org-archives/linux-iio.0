Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795170568;
	b=pgT2qDjaduWAyzg6Ffg3Vj0AqZTF+9drfPA0OfVDIX343Ht1tOULR4KfFkPdpwC0+Qne
	 6qy6bLi/hcuUiswHB3aRPE1NUf5Nlmet7FkHHNx+wg/16X8erVnKknX3MqaTk3dQjMhNr
	 2G8Iubi079iXSfF2xDlIF1hM2oqS5MoiVxgsG1hS81HFUyXuiSWb+aMrY7U+5Ion6iq+A
	 R2jlLwo77xdFcazCJ9EgDZlVUWp5fICUQkQDyz4W3eSTrJGRJk2Kfl1ruH0athchCmso1
	 tvhw5hjo7SSIKWW1j/yc3BOHav7V0YMgjkCsPNT5TND5V4++hiFtR2fMPCj3/oEJ1Sw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795170568;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=jTAy/t9Qx0lrwmagh0OZEBBPhEuBNaw2YAMUVykvYNs=;
	b=1muctbtAwdLVwbqJU3VifEH6mQynwE1kxsbXg8d/tqPq26qh6AXpkaeK1SEBb4LBUXX/
	 rjO6a9E9jaRuqLyWrk/NOWUU40x/nwoXwoFyPPojoaNNOgMYMGnWRzfGzseLEGICd3CtY
	 p3tESB95gA3ZmdXaicBf7ZyvsyofkgwtkERkPnZhGJzUx3ozjaF2H9aJE2nRldh+D0qs0
	 PQ2XdZIG5hGA4IEH7KPCORqZPe9enEgjjOJwIm3kRX/8hTF+noK9WXdusmWWOCv2/Le7r
	 vcS565qohJFaej7tlrNS/J8BoxLuLMbx7W2fbe8QQM9rOdRLgXZqQgOelZM1Y+6SOxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C+QotWaX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B4E7606A320;
	Fri, 20 Nov 2026 10:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C+QotWaX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54FCB1F000C4;
	Fri, 20 Nov 2026 10:29:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795170568;
	bh=jTAy/t9Qx0lrwmagh0OZEBBPhEuBNaw2YAMUVykvYNs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=C+QotWaX8sgXVpsrb0UKgyMgRuN0GsKE8AGPYQgO+MzXI5ZUYnaR4WdGffBZMSOPQ
	 bG2Lr5vSHMPO5SQRTPg7+RNzuxuIBLT8SCujZuK58Rzpo2MHBQI7IxI1N/eB1j3Dgd
	 quC/Dsclj2LbS4+cpUDgACxQigMoqapXxUraDj2nQy5ie/GtVD8D8hJoJDKzBIwKfp
	 z3g7AMcIVrihLtinhtmkr6bwUMZQpMV6IKheeTBtYJwaa/hSPa3U/NfjnmGNRYrS28
	 nOG8iR7e6uw38NxkIPQhQS88c0S1xQlLyQUer3Acq74lwh4Khvx2sgYTagnUOnzTbw
	 wOJZvtJH2f24w==
Message-ID: <7d50b14d-2df8-4616-ac66-d6dbb1d24061@kernel.org>
Date: Fri, 20 Nov 2026 11:28:35 +0100
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
Subject: Re: [PATCH v2 0/3] iio: adc: Provide mult_fract() and make use of it
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
 Marcelo Schmitt <marcelo.schmitt@analog.com>,
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>, linux@analog.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Michael Hennerich <michael.hennerich@analog.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Esteban Blanc <eblanc@baylibre.com>, Jonathan Cameron <jic23@kernel.org>,
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>
References: <20261119192408.1724611-1-andriy.shevchenko@linux.intel.com>
Content-Language: en-US
From: Joshua Crofts <crofts@kernel.org>
In-Reply-To: <20261119192408.1724611-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 19/11/2026 20:19, Andy Shevchenko wrote:
> In a couple of IIO ADC driver the suggested new helper mult_fract()
> may be used. So, provide it and update the straightforward users.
> 
> The helper has potential treewide, hence it's provided directly in math.h.
> 
> In v2:
> - updated commit message in patch 1 (Sashiko, c/o Joshua)
> - used local variable to avoid double evaluation (Sashiko, c/o Joshua)
> - collected tags (Marcelo)
> 
> v1: <20261117091638.1463621-1-andriy.shevchenko@linux.intel.com>
> 
> Andy Shevchenko (3):
>   math.h: Add mult_fract() that takes struct __Txx_fract as argument
>   iio: adc: ad4030: Switch to use mult_fract() helper
>   iio: adc: ltc2378: Switch to use mult_fract() helper
> 
>  drivers/iio/adc/ad4030.c  | 13 ++++++-------
>  drivers/iio/adc/ltc2378.c |  4 +++-
>  include/linux/math.h      |  7 +++++++
>  3 files changed, 16 insertions(+), 8 deletions(-)
> 

Fine now.

Reviewed-by: Joshua Crofts <crofts@kernel.org>

-- 
Kind regards,
Joshua Crofts

