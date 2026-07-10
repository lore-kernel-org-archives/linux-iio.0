Received: from mail-10696.protonmail.ch (mail-10696.protonmail.ch [79.135.106.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13170403AF1;
	Fri, 10 Jul 2026 10:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.96
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783677984; cv=none; b=qy/pG+zkGwvfihYaI7SGDThMHvOQyQrK7+PbQtnBzBOdLyi2TfeGPugp2V9EcnSF6zOhrhZtlLqrCGObcpT31L8zuAfG+R4SRmFIZHGcqPn04U55SLFgmNq57ihIRs1nTdoRLcs6Mtu/YpSyIGLT8GdSx/02/IHY80SUV1PVcZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783677984; c=relaxed/simple;
	bh=bZtt9hqfiH8yRk8Y6EHE38Zx3h0iymmFuYoAuIHZpGc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cL3ndBkv87h/pBv2Ai8lPEB/Pxxinm6fo0gIfgQhGqYZIjj3C4N7GUu1zJMnThRgwvQUhS5OutZHfNEGGK3TmKuWJx5kgB2sD/ay0OF33QrBPQHRe1zOhk8jf2P0KgJhKYjPE3KJ6IAPOdOGRVP6hXSTli2BDgISCc0JtJYod/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=U8hhGQ7V; arc=none smtp.client-ip=79.135.106.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="U8hhGQ7V"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1783677971; x=1783937171;
	bh=bZtt9hqfiH8yRk8Y6EHE38Zx3h0iymmFuYoAuIHZpGc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=U8hhGQ7VomZ9uCLFY8xtreukqqVFxjRaNesy39m8uy4yjDH/ZFgiC/i5RnCC3C6o6
	 Dom22Z/C7+D+RBR3lw3h6Zo9ByqJrkDQHiJ7djCTu0y4CaUAfp3bwdIixrwK4tjwkk
	 2qJNJd9GJrjZQ3F/Y6SiOnVxFQW/msgkkeYthBcQDSxgIaiMtiJYuhaegNOs7qMLaT
	 rkzBeQPxMemtPk09cv52Df7txq3kbcWSHqnm2o1QWhcYhWUPmrq1yQgYaYf27d2uuX
	 cZih2rYk19O+wm7T+UpBr39onBWBhVlWS2VVAcju/x2YtXy9+EKpIlctVbJNUX2WYt
	 ZWHgwj/nL102A==
Date: Fri, 10 Jul 2026 10:06:05 +0000
To: =?utf-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>, Jonathan Cameron <jic23@kernel.org>
From: Roman Vivchar <rva333@protonmail.com>
Cc: David Lechner <dlechner@baylibre.com>, =?utf-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Lee Jones <lee@kernel.org>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, Ben Grisdale <bengris32@protonmail.ch>, Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: Re: [PATCH v5 2/4] iio: adc: mt6323-auxadc: add mt6323 PMIC AUXADC driver
Message-ID: <KnchjScV7RNnhDi3rI7qqdZSgivkk8WJiQEGWYifNJJjMzzJrEFfZGEuPWSrQisnh_JDj15_CLSLtO2HEjUFe6Jr4wgramAhYwmJjHy6aiw=@protonmail.com>
In-Reply-To: <alChi9oG0-2XUFXK@monoceros>
References: <20260709-mt6323-adc-v5-0-d11b8332a735@protonmail.com> <20260709-mt6323-adc-v5-2-d11b8332a735@protonmail.com> <alChi9oG0-2XUFXK@monoceros>
Feedback-ID: 173184497:user:proton
X-Pm-Message-ID: b24ef4ce02959c9f36191eeefd7da36d6ded1b5f
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Uwe,

On Friday, July 10th, 2026 at 10:39 AM, Uwe Kleine-K=C3=B6nig <u.kleine-koe=
nig@baylibre.com> wrote:

> Hello,
>
> On Thu, Jul 09, 2026 at 01:52:48PM +0300, Roman Vivchar via B4 Relay wrot=
e:
> > +#include <linux/mod_devicetable.h>
>
> Please don't add new users for this header file. Only use those
> <linux/device-id/*.h> that you actually need (if any).
>

Jonathan, since you've already picked up the driver to the iio testing
tree, would you prefer v6 or a separate patch on top of iio tree?

In any case, I will drop the header since it's not needed.

Best regards,
Roman
