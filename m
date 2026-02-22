Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE321E0B9C;
	Sun, 22 Feb 2026 18:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771786762; cv=none; b=RLm/aAyaJ72stss35j/S0Q/KACqbPZ8lAxOuyGJcj105oL2ZqEG/PqsLmmA/8uIHJpq9kp8vO3BjMd+RkuLngUV3Zs2nZk5kIFTWKT+rvgBzAf7/H+dCG+maWsAbHjiTYEU7ZdrpNIsgJhy2K9vUfOlJZzDuAM46f9zpnxt05CM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771786762; c=relaxed/simple;
	bh=CVy4Tj2u5H4VFaJURPYOOEa0YyV2n450PQLCt8qncCM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LlqhRy51XhZt05TEbQdk4tnh2i7g2ky9oI3J8aEyTUm67NxeJO+pmg1ZhIS/LZ6TzJiOm+ZElvEsl+eroGnDx1SKpGZavu745w1VzPxKE2jOEh/j66mbvTsJKzby9ytwBBTc56O+tkeuEv+EMhyduqoXG77VfXCuYe5gcgPNMG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uvb2fFZ2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uvb2fFZ2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 963ABC116D0;
	Sun, 22 Feb 2026 18:59:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771786762;
	bh=CVy4Tj2u5H4VFaJURPYOOEa0YyV2n450PQLCt8qncCM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Uvb2fFZ2D0HCE4xtvx6tg1yCNbr1yDnLvLn+5qeG+PGrq1ynau1okHlnWAzKZfch5
	 y+eHj8kg3oTYcZofd37TGR+82cQHkqcvAIPRgU/XZXgwjJ+cubER1mix88j62Gwbw7
	 C6H96KE5JRK4rUxIk1yfzB5XxWC/XVt1fNaUKIWu8mlmKGDuESx3minvwybXpSD6Ip
	 DhYK9arWJax4r6Fb2adLesIKzCrh0L2RQEpFhmdy3722WrdVvKT0EYnK+otoLmrYDx
	 b5rebWdCnVbxq6mZNZ+957WdKMql2RI+Lf9ynBfImX0K61FlIsnIOk5e8HrPeT2Vvi
	 mh0bHG/xMehSA==
Date: Sun, 22 Feb 2026 18:59:13 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Antoniu Miclaus <antoniu.miclaus@analog.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Nicolas Ferre
 <nicolas.ferre@microchip.com>, Alexandre Belloni
 <alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: adc: at91_adc: change at91_ts_sample to return
 void
Message-ID: <20260222185913.75670523@jic23-huawei>
In-Reply-To: <01eb6fc5-4a71-4877-8a62-ef397a1036c9@baylibre.com>
References: <20260202115733.21382-1-antoniu.miclaus@analog.com>
	<01eb6fc5-4a71-4877-8a62-ef397a1036c9@baylibre.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 2 Feb 2026 09:11:58 -0600
David Lechner <dlechner@baylibre.com> wrote:

> On 2/2/26 5:57 AM, Antoniu Miclaus wrote:
> > The return value of at91_ts_sample() is never checked by its caller.
> > Change the return type to void to make this explicit. The error
> > conditions are already logged via dev_err() which provides sufficient
> > visibility into hardware issues.
> > 
> > Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> > ---  
> Reviewed-by: David Lechner <dlechner@baylibre.com>
> 

Applied. Thanks,
