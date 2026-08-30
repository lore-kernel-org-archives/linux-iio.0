Received: from out-2uec-a106.jellyfish.systems (out-2uec-a106.jellyfish.systems [63.250.43.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4853F32C92A
	for <linux-iio@vger.kernel.org>; Sun, 30 Aug 2026 20:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.250.43.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788121222; cv=none; b=HTIhVHfW2hJvYvbJEevnzp3wAakgzFlrt+Tn3oVsSuASh641XXAzQ8+KETuq9zucdcd0044q3v+yg92ZxQah/ZN+HleIOMQv441SOeCsoEjiHbbayWLv4j9GRx6EbwmKApKjeA70QFLscpNjWkAv+/vBdRGo3jHJ64S5K+vvr58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788121222; c=relaxed/simple;
	bh=r4RyBd1+2rZJnAt+P/8o29QnDiXHkVkx0+IAic5RRyQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DFkvXq/Fk3UU+G8sIZuT/w29Gz2pcHlsPlXH/wolAE5dfX5YiaxMpLcpi/hv+oOVaMwvjAOQnxTfKwdqr35Y1DTVr9hbqcfLD2AJgYJRvig31J5tqbvJn4uMFFy0es+TfcSkGJoTdBY2X+iz8OoXPZaXuPMdrfFcd0gAEBL+1iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=catcrafts.net; spf=pass smtp.mailfrom=catcrafts.net; arc=none smtp.client-ip=63.250.43.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=catcrafts.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=catcrafts.net
Received: from mail.privateemail.com (unknown [87.215.145.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.privateemail.com (Postfix) with ESMTPSA id 4hY3Q10vf3z8sWQ;
	Sun, 30 Aug 2026 20:19:52 +0000 (UTC)
From: Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>,
	Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Luca Weiss <luca.weiss@fairphone.com>
Subject: Re: [PATCH v2 5/5] iio: light: stk3310: support the Sensortek STK36C61
Date: Sun, 30 Aug 2026 22:19:50 +0200
Message-ID: <20260830201950.63838-1-jorijnvdgraaf@catcrafts.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <apRGQVfPKWHvE2Ct@debian-BULLSEYE-live-builder-AMD64>
References: <20260826175409.326131-1-jorijnvdgraaf@catcrafts.net> <20260826175409.326131-6-jorijnvdgraaf@catcrafts.net> <apEMCqQXyj1tAMoP@debian-BULLSEYE-live-builder-AMD64> <20260828154705.11962-1-jorijnvdgraaf@catcrafts.net> <apRGQVfPKWHvE2Ct@debian-BULLSEYE-live-builder-AMD64>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Envelope-From: jorijnvdgraaf@catcrafts.net

On Sun, Aug 30, 2026 at 12:03:29PM -0300, Marcelo Schmitt wrote:
> Having a closer look at the data sheet I found for STK36C61, I noticed registers
> 0x13 and 0x14 are not listed. Does the newer part has ambient light sensing
> besides the clear channel?

That looks to be the "STK36C61-A Preliminary Datasheet v0.9" hosted by
LCSC [1], which I hadn't found before, so the cover letter's "There is
no public datasheet" is wrong. It documents the -A variant, however,
and gives PDT_ID as 0x93, while the part in the Fairphone 6 reports
0x95. It does agree with the device on the colour-engine layout: RGBC
data at 0x15-0x1C, a clear-channel gain in GAINCTRL 0x4E, and the
shared GAIN_RGB/IT_ALS fields in ALSCTRL1.

Yes, there is ambient light sensing besides the clear channel:
0x13/0x14 are present on this device despite their absence from the
datasheet map. They behave exactly like the stk3310's ALS data
registers and are what the illuminance channel reads. The ALS word
tracks the green channel exactly, proven by the x16 gain step moving
both from 25 to 404. The sheet's own text does describe the function:
it defines DATA_ALS[15:0] ("16-bits ALS channel raw data"), windows it
with the THDH/THDL_ALS thresholds at 0x0A-0x0D, and calls FLG_ALS_INT
"the Green channel out-of-windows event", which is consistent with the
ALS == green behaviour I measured.

[1] https://www.lcsc.com/datasheet/C49230205.pdf

Thanks,
Jorijn
