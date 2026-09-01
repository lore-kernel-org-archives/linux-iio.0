Received: from out-93wp-a20.jellyfish.systems (out-93wp-a20.jellyfish.systems [104.207.68.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 258A9430CD3
	for <linux-iio@vger.kernel.org>; Tue,  1 Sep 2026 02:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.207.68.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788231324; cv=none; b=IJX/eL9P34OJzDUI3TNJpC+XwrTLyBtAECgaiU8Kzz+MoiChsbaE/rOxVj6mw8jy4ucip4kc5PncqR0TaNwH5FROjcb9NwJWc9YZRPFSNtEn2KgLPCzlmWOB0FzwML8AAIPk6HtjhddvYidGQdhoav1r77Wo+ksctK48N3RZWMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788231324; c=relaxed/simple;
	bh=2Db92YQxRxEw73LT1zTO7HWVubeMGWOaqBYNfy0Tldc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jnu/RGYDP4gS+PVxajFhE34rnB31VC+f3hi1mJOpbyTrPILxWdlhz8/oqlWBooOS9StjtcjQbSeKzRXWNG3fodyFvXH2SiDJHEwp5/o0kyiHaEj6SxrbtikLngBCLa9o0a8ZSTGFYTTbEbwZeGD13cZrj4ZedWR+/Z1s+SW+RmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=catcrafts.net; spf=pass smtp.mailfrom=catcrafts.net; arc=none smtp.client-ip=104.207.68.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=catcrafts.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=catcrafts.net
Received: from mail.privateemail.com (unknown [87.215.145.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.privateemail.com (Postfix) with ESMTPSA id 4hYr7d4pxyz2x9B;
	Tue, 01 Sep 2026 02:55:09 +0000 (UTC)
From: Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
	Luca Weiss <luca.weiss@fairphone.com>
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
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/5] iio: light: stk3310: support the Sensortek STK36C61
Date: Tue,  1 Sep 2026 04:55:02 +0200
Message-ID: <20260901025502.231703-1-jorijnvdgraaf@catcrafts.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <apYqUv_uuqZlhtOh@debian-BULLSEYE-live-builder-AMD64>
References: <20260826175409.326131-1-jorijnvdgraaf@catcrafts.net> <20260826175409.326131-6-jorijnvdgraaf@catcrafts.net> <apEMCqQXyj1tAMoP@debian-BULLSEYE-live-builder-AMD64> <20260828154705.11962-1-jorijnvdgraaf@catcrafts.net> <apRGQVfPKWHvE2Ct@debian-BULLSEYE-live-builder-AMD64> <20260830201950.63838-1-jorijnvdgraaf@catcrafts.net> <DL2YT4S4U7C4.2CPGBR94G01FD@fairphone.com> <apYiYnlM-agfG9he@debian-BULLSEYE-live-builder-AMD64> <apYqUv_uuqZlhtOh@debian-BULLSEYE-live-builder-AMD64>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Envelope-From: jorijnvdgraaf@catcrafts.net

On Mon, Aug 31, 2026 at 10:28:50PM -0300, Marcelo Schmitt wrote:
> Never mind, I completely missed the point of it having a preliminary datasheet.
> It might be sensible to try to estimate if the final version will keep the same
> name and PDT_ID.

On the name: the Fairphone 6 repair document's block diagram labels
the part "3IN1 ALPS/RGB sensor/STK36C61", without the A ([1], page
107), while the LCSC and JLCPCB listings carry the -A name. The
diagram is provenance rather than proof because the same page
misrenders two other part names and I have not read the package
marking itself.

The driver name would follow the existing family convention either
way: this driver already binds the four STK3311 variants (STK3311,
-A, -S34, -X), each with its own chip ID in stk3310_chip_ids, under
the single name "stk3311".

On the ID: the published sheet says 0x93, Luca's 0.9.2 revision says
0x95, and the part in the phone reads 0x95. stk3310_chip_ids is a
flat accept-list, so if a final sheet moved the ID again it would be
added alongside, not swapped.

Luca, can you confirm which part is actually in the device, the
STK36C61 or the STK36C61-A?

[1] https://www.fairphone.com/wp-content/uploads/2025/08/Fairphone-Gen.-6_-Information-on-how-to-repair-dispose-of-and-recycle-EN-NL-FR-DE.pdf

Thanks,
Jorijn
