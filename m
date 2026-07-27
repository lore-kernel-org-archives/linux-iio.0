Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC07C3ED3CC
	for <linux-iio@vger.kernel.org>; Mon, 27 Jul 2026 15:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785164980; cv=none; b=Gn8b4oftsBS9t+XZAj31/nMY4K5PtvdI1vhvpNzUexnZP/ED+/Uid9qhX0KkYz5+nUci1+KjU7RnMIJC05vK9+KJrn0AlxSZuU4BxI6rA2IuMh2LPNewFMt/FObAqBlfrk6/UXDeA6SfJz3WevSSA+LCt1weKxI+6nBFfzu4fi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785164980; c=relaxed/simple;
	bh=HSuzWCNfmtGOZwoIGq5Nl7XfdshlgFq1Zx4Gb4KZxT0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DidViGAg96qB6zmsVEreCjdJ7ksriokBlM5m+eyJDj9WcWyzgiHvX4ESqsE4aZoUaVbdviXWXanqtfJlnr6cKKGpCWqenpp4RmzuZ1kgc6w6ZBd2taKtRcOJK7AYPA5DE5ToSq9K0YO7WudDTrEHzvMFtGGY6rReDUS3QZOLbIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZPdAcBwW; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZPdAcBwW"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5b28c91fba5so3319950e87.1
        for <linux-iio@vger.kernel.org>; Mon, 27 Jul 2026 08:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785164977; x=1785769777; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zkj+aZ90VE+X2jMZTbdBhdtF1Q29knWNG0mAcpOL1oE=;
        b=ZPdAcBwWl4b8zf5GzwvqflvCbm5ukpdVlpzzncmEmimRgPU2GBz96SEtDJORr2s4CS
         JlYSuthABQncj1HJRDYUhi1glQjNc7Hy8jOyHHC8GD1pOHnXS9+Ea2V1AtuWZNWCcpkZ
         J6nhFyEOuvmCqw/iY2mfKw8XldjNsGSVpVGRgTTVL6dve0sDHW7QYdllMAr2218v/DZY
         JwLf4PBEXh0vyNvoh4aK/IEAFoEApIZflLWskmX/O/WGAueL03YcRSDBTxo3drxnmE3F
         MFE1lA/k1zHgPetHOJmmhw/VX0V6aTLjd9wCevbTmQvmOXF7aYwc4lRuK0FCRKdpNObA
         iT2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785164977; x=1785769777;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zkj+aZ90VE+X2jMZTbdBhdtF1Q29knWNG0mAcpOL1oE=;
        b=nUEE6eJRDDYcLvbXcrU7s2+5kWijTtMNn6bYj5lBH0TIwk/OsyboD0IL0przG0cqzM
         wl4PXuGdD7pDPKd++1i3E9o/fIZhV6xxy4m7Sw3qkt5ZYM87PEjRfJ9L+xCkMvpvo0aJ
         iWkxGG8Id9WqGdwwHywG3TONjU4/3kWih+eDmmBnZyiJgfgA/JC5TNSC29iijJBWWtnn
         L4+VB8w2ujkWVP+mrH9Ikyg9l+wKn/aNC2n9jrwQ0sgIHA6LemKyC/8weqXbCy6BDsDo
         XXgqURBFLLwrAQMpS9xqT5+4ppZg7U8S5nkZo/k9wUHTMQ7G+/Snk5DADTA2vyUhMcUp
         ZhEQ==
X-Forwarded-Encrypted: i=1; AHgh+RrPZ/5niYDVKsEoLIcTSwdtLLyfYtlP06VKoyghMtpAoJ0w5fdt57IZYwA77b82L0YUDJWHFIlPaxk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1hPHAmKTq7C2HExeBzHBvDxukJBah/Gw7dYMcm21RChv5yu9G
	rH30X0rT79iRxVBsSCOmT+gaPxHoe1bqgEEjoOQjlaAkFFVIRtb0v9BJFfw8RRsN
X-Gm-Gg: AR+sD11DFiP2Hx6WQ8M7g+76LTq191iaNOtRz/CH7DYOUo8+jwgFIUle8ljm4TRZF3l
	uTYhwrlSXBBxyivYkHYkCZ12nLLjL56eMYdUdkiVjhGSb4x5/tKCDcG1zL2S1SRT163CpUBneBA
	te+N3B75Itq3fQBwCa/gyt9usM3uRSe0PbHfoxFZipjaU8KPOFJboR2Oo/MmpluVKvSHs2Y8aph
	oxWM+hC53EnHGgKkb9QFnJvShEZXAJ0NCxdbQ653exnEVWyRd+AY88CXQ7OSfQTviHLEP0fDUSb
	Pz5ptNUTKekwwZvXMqPzOwuoaJq/blqufWaT7X/47YzmrYBP/Xl1zI8OTi1dydUMR7WnDEDmW9d
	kVkf3LxS5h8721dgo4iI6RxEmC2lr8/0vokjKuu2jy8BCSLzLEHPK5OQroNF8vEFy6Ajbd2hEtK
	DSUomd9mUcenxPCP5lPpKdJlyI3lXB85D9sbrVkuCVya06DaPz2EnjkedsY6HVlBU+c9xOmX7uU
	A==
X-Received: by 2002:a05:6512:6d5:b0:5ae:acbd:439c with SMTP id 2adb3069b0e04-5b2c1a4f09emr1724048e87.23.1785164976430;
        Mon, 27 Jul 2026 08:09:36 -0700 (PDT)
Received: from yantra.. (dsl-trebng21-58c187-236.dhcp.inet.fi. [88.193.135.236])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b2be1f83c4sm1481719e87.69.2026.07.27.08.09.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 08:09:35 -0700 (PDT)
From: Rupesh Majhi <zoone.rupert@gmail.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Eddie James <eajames@linux.ibm.com>,
	Jonathan Cameron <jic23@kernel.org>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: pressure: dps310: fix pressure result shift bit definition
Date: Mon, 27 Jul 2026 18:09:34 +0300
Message-ID: <20260727150934.9471-1-zoone.rupert@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <bb74b15e-6a95-4eaa-82bf-7c256b554c45@baylibre.com>
References: <20260727070547.649074-1-zoone.rupert@gmail.com> <bb74b15e-6a95-4eaa-82bf-7c256b554c45@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On 7/27/26 4:27 PM, David Lechner wrote:
> In your followup work, it would be nice to start with a patch to
> sort these in a logical order.
>
> Right now, there is a mix of GENMASK being sorted from high to low
> while bits are low to high (with DPS310_INT_HL being out of order).
> Normally, we go from low to high on everything because that is how
> datasheets usually list things.

Makes sense, I will do that. I have a cleanup series queued from Andy's
review of the ACPI fix, so the sort will go in as the first patch of that,
after the buffer work lands.

One thing worth flagging about the block you pasted: it keeps FIFO_EN at
BIT(5) and SPI_EN at BIT(6), which is what the driver has today, but the
datasheet puts FIFO_EN at bit 1 and SPI_MODE at bit 0. Datasheet V1.1
(2019-07-11), section 8.6 "Interrupt and FIFO configuration (CFG_REG)", the
bit table reads INT_HL, INT_FIFO, INT_TMP, INT_PRS, T_SHIFT, P_SHIFT,
FIFO_EN, SPI_MODE for bits 7 down to 0. So bits 5 and 6 are INT_TMP and
INT_FIFO.

Neither define is used right now, so nothing is broken today, but the FIFO
enable is needed by the FIFO patches. I have that as a separate one-liner
ahead of them, since it changes values rather than moving lines around.

That leaves CFG_REG looking like this once both go in:

#define DPS310_CFG_REG		0x09
#define  DPS310_INT_HL		BIT(7)
#define  DPS310_TMP_SHIFT_EN	BIT(3)
#define  DPS310_PRS_SHIFT_EN	BIT(2)
#define  DPS310_FIFO_EN		BIT(1)
#define  DPS310_SPI_EN		BIT(0)

I left the three interrupt enables at bits 6 to 4 out, since nothing uses
them and the driver has no interrupt path. Say if you would rather see them
defined for completeness.

The rest of your ordering I will take as is.

Thanks for looking at this.

Rupesh
