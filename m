Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B650837B01F;
	Tue, 21 Apr 2026 09:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776762795; cv=none; b=s8Z4DZNcemckGVmqp7BoGiN/i0hSs/73XZPZ452vVFSHO8YKC/gmAwn85TB60ugNhP/zw1jzWoYOpex2YuVsIKybHfcvKq5+gIB8d7gWSgibqXog11HccsR+T4sj/9tFU+F+VanzraEdmTwR7+dhbmuO96TaGuemXjZOVpHaFQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776762795; c=relaxed/simple;
	bh=dmociZFz2IYYNo4xHUQTB1XzzkNBHzfsm8nH1/Lj3UE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UWSwQVYecqPU9+hAfEWji0JL4j3FLkolheMbpIT5k2KWe/l8fyNa0YeaUQYBmwp+ZFN1cJZg3KN7GxCuWXNGAwKXTcaCmo5Rn8P47k0qaELW1i7JVymcNf1El0yJOf70xNtmNs8tztnyke3XPLRyES8e8H4p7VJusfcgNW7z3yM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=FlyJl7lG; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="FlyJl7lG"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 8F3BD4E42A87;
	Tue, 21 Apr 2026 09:13:05 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 463E9600D2;
	Tue, 21 Apr 2026 09:13:05 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9714010460A48;
	Tue, 21 Apr 2026 11:13:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1776762784; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=dmociZFz2IYYNo4xHUQTB1XzzkNBHzfsm8nH1/Lj3UE=;
	b=FlyJl7lGx4eMMQbCRev9mpvt+7BSTACXMwFG0/G4GCcU9PtfNXDKpav3Wrgho0q3qzOVz2
	uLNwe2kHl1h9N7Vkt8JdSC8z4PN7c4hCbaa1sZwAvD/WVUzr2F0HO6D5AdtqMbWVQ4oylV
	jBYgpqOJJhaFMvUbB0v3PBIMXDxxtQp9Bdl/TpY8cPLngwiBlQU4kACwqFm29ZM52r4LxZ
	IMqMOaXDyVKU4AGlgYaIaLLUL6/SGj9W/PJzkMmnOJhv4kVap2OEsjZ4GZ2qJrc/3pwQ6r
	Y9S9ik9A2Fnnq0+sGVJW23nt5/DVrFVgyXjrBt5sW/Pk/w4iRcHNpVU8FZSImw==
From: =?UTF-8?B?QmVub8OudA==?= Monin <benoit.monin@bootlin.com>
To: Paul Cercueil <paul@crapouillou.net>
Cc: Jonathan Cameron <jic23@kernel.org>,
 David Lechner <dlechner@baylibre.com>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, James Nuss <jamesnuss@nanometrics.ca>
Subject:
 Re: [PATCH] iio: buffer: Fix DMA fence leak in iio_buffer_enqueue_dmabuf()
Date: Tue, 21 Apr 2026 11:12:59 +0200
Message-ID: <MjitYxUvQZ2Xg6TvxwuU6g@bootlin.com>
In-Reply-To: <b3e77a9289eb934a342fd18512f27bdfb368a716.camel@crapouillou.net>
References:
 <20260401-iio-dma-fence-v1-1-40993adbfa96@bootlin.com>
 <b3e77a9289eb934a342fd18512f27bdfb368a716.camel@crapouillou.net>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Last-TLS-Session-Version: TLSv1.3

Hi Paul,

On Monday, 20 April 2026 at 17:12:46 CEST, Paul Cercueil wrote:
> By the way, I did the exact same mistake in the functionfs code
> (drivers/usb/gadget/function/f_fs.c), do you want to fix it there too?
>=20
> (or I'll do it myself eventually)
>=20
I have never used functionfs so I will let you fix it.

Best regards,
=2D-=20
Beno=C3=AEt Monin, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com



