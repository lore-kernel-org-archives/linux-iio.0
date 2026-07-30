Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB7583AA4E0;
	Thu, 30 Jul 2026 19:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785440203; cv=none; b=DvuvRtV2AWBrNGkroFdptCk443n9rd69BN1BrIdJms4Huy6TYUThrUYIPPu0t2W3AQVy9LZAkORzF8IgbfEAnM5BtuT3HFk7Y51GAunfdYprSVbxB/L3GYCOxhMdTi8Y+zxFG+lduHxVIZmtOjypNeZYf20/vtTOIUYWdRzHNdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785440203; c=relaxed/simple;
	bh=gXM2uHcZ0BT1egGODlahZ0/bg1Nmk6mpO/+jOkZRUvc=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=lHYuCM8UKFCBZkkmuVAEWNztdB9GBeLyDbn0JL0P4l1WAt/i4q9XWrdq5iabLEJMFkVnqAhFGZlngbNRP20zcRV6vPrB5on1S3toHSv8wZy6LaYdAF7dhLATuL7f7Da0I7XBfFabL72yPWe1MNXpomrRHEkHRKY6OjFMxPCwcEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=ZrqsjbP6; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="ZrqsjbP6"
Received: from mail01.layka.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 328BB41BB2;
	Thu, 30 Jul 2026 21:36:40 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id g_CoqoGw_zcD; Thu, 30 Jul 2026 21:36:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1785440199; bh=gXM2uHcZ0BT1egGODlahZ0/bg1Nmk6mpO/+jOkZRUvc=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To;
	b=ZrqsjbP6oNBo2EBxfWyWs5H4giKy9svA+O8x+E7EMUNXlBo6K4IcN7qHwnU/fbejR
	 NZbObViE6bjWx/vPc7uzlUGGARmFxn9hHZDWbhKoPSBVRC0Go2nGFNlQJScG+nLAo2
	 t2v5Hg3ydTpR/iznzazl+0PscIaT2njJPkqkbh+spRWRjSwhZt8op029/H2mQKitNU
	 xOyjPnKZdCxdTfBxVW6KmQXbT5fmkLe9i10TzQAdbpQewro8WiYzHy76M2ZLVNJHU+
	 z5nOohZ5AltVf+AJyLRTTwLIZ/mQ4azNpAHZepguAIEVSbVgCCotiTPAmkhVyPbM9X
	 dtDVJwZZqoGPQ==
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 31 Jul 2026 01:06:25 +0530
Message-Id: <DKC5Q1ZHLH2W.VZI09E6IC82D@disroot.org>
Cc: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-samsung-soc@vger.kernel.org>
Subject: Re: [PATCH v2 2/3] iio: proximity: add driver for Sharp GP2AP070S
 proximity sensor
From: "Kaustabh Chakraborty" <kauschluss@disroot.org>
To: "Kaustabh Chakraborty" <kauschluss@disroot.org>, "Jonathan Cameron"
 <jic23@kernel.org>, "David Lechner" <dlechner@baylibre.com>,
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy Shevchenko"
 <andy@kernel.org>, "Rob Herring" <robh@kernel.org>, "Krzysztof Kozlowski"
 <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>, "Peter Griffin"
 <peter.griffin@linaro.org>, "Alim Akhtar" <alim.akhtar@samsung.com>
References: <20260731-gp2ap070s-v2-0-1bdfee07d5ea@disroot.org>
 <20260731-gp2ap070s-v2-2-1bdfee07d5ea@disroot.org>
In-Reply-To: <20260731-gp2ap070s-v2-2-1bdfee07d5ea@disroot.org>

On 2026-07-31 01:01 +05:30, Kaustabh Chakraborty wrote:
> The GP2AP070S is a proximity sensor designed and manufactured by Sharp
> Corporation. This sensor is used in mobile devices, including, but not
> limited to - the Samsung Galaxy J6.
>
> The driver has been adopted from Samsung's downstream kernel
> implementation [1]. Due to the lack of public documentation about the
> schematics of this device. The downstream driver acts as the secondary
> source of information. Driver clarity has also been improved with the
> help of the GP2AP* drivers in iio/light.
>
> Link: https://github.com/Exynos7870/android_kernel_samsung_universal7870/=
blob/lineage-16.0/drivers/sensors/gp2ap070s.c [1]
> Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>

This is stale. I'm sending v3 right away.
