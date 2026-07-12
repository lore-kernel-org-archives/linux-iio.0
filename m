Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 068DB2D1913;
	Sun, 12 Jul 2026 13:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783863077; cv=none; b=AMYvYUY3y6bmkRsPrE4ShcDhjgjomRAMT8f1CS6uB3Cp2mHPRdROwxKuRxS6/hNFgiHPM8/vjP8ivAryDGTNUCUKQH040FLuJpO5Ep6tvo+/0Xrqw2EGgt4TP7mToUs7FpDdrSzhVH5jeearYW1iuVwkQShnrjcIEeForhsb+EM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783863077; c=relaxed/simple;
	bh=BWtX0G9rA5gU31Xzh6zT4Wr9r0sxd40ARRXx7TIt5oU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IZ3QnUCSQV7eA0tkX9a2Br0HqTN5VL+v3dvsFPVGvbIa4RBwztBFQt+xeNHKOZzT0FyhWuNh0v32kqEjpDF+IUjTwTW0fKxjWjFUOk1NZaNPPAxIO+B/JuuZOftXlKpmvflefG2xrLLEjQ0I6Hu/Z9wCT2Ohzx0tWcKdWyqmjns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=EFTUW65K; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="EFTUW65K"
Message-ID: <367f53c5d06e85be5b858dabecc9dd308ae14e20.camel@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783863072;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BWtX0G9rA5gU31Xzh6zT4Wr9r0sxd40ARRXx7TIt5oU=;
	b=EFTUW65KHO70xVBUsXGkidjcZzIdXSzogJ5kePGpNMzQSh0MSWhd+Wgrh1unDZcJcR+QV3
	VJ4sv347lyxnXtEwoYFMSg/IU6KQsos2vEGhI8A2kE3LnOs7hlTCMbZWfUQhvUsnTdEtlO
	PAHIDewT0tmLHW0WdD/HoHqyQK3Z/E8=
Subject: Re: [PATCH] iio: adc: mt6323: remove unused header
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Siratul Islam <siratul.islam@linux.dev>
To: rva333@protonmail.com
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>,  Nuno =?ISO-8859-1?Q?S=E1?=	 <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Matthias Brugger	
 <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno	
 <angelogioacchino.delregno@collabora.com>, Uwe
 =?ISO-8859-1?Q?Kleine-K=F6nig?=	 <u.kleine-koenig@baylibre.com>,
 linux-iio@vger.kernel.org, 	linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, 	linux-mediatek@lists.infradead.org
Date: Sun, 12 Jul 2026 19:31:02 +0600
In-Reply-To: <20260712-mt6323-adc-rm-header-v1-1-d96395d1a323@protonmail.com>
References: <20260712-mt6323-adc-rm-header-v1-1-d96395d1a323@protonmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Migadu-Flow: FLOW_OUT

On Sun, 2026-07-12 at 09:26 +0300, Roman Vivchar via B4 Relay wrote:
> From: Roman Vivchar <rva333@protonmail.com>
>=20
> Remove unused mod_devicetable.h header.
>=20
LGTM.

Reviewed-by: Siratul Islam <siratul.islam@linux.dev>

--
Best regards,
Sirat
