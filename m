Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AECAA466B72;
	Fri, 21 Aug 2026 10:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787306661; cv=none; b=VjDiIHuNkNm3mj71oK5vgsFH2xQkjz4bpPrBVFNbPzYm47Vq6qR/XcrooUQ9VvVINJ/sCfhMBVELT4ymqY39WJDPGrn2lwxc6fI+/TwuCKPCPxwLz6O//lB/mhTKJP2p3Eo67dyXlaqghleGq3v+bL2MmiP3djW5k9qVMlg0A/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787306661; c=relaxed/simple;
	bh=/ys5Fia+84x6IhVwA1pPs8Br2dxL7pzvqdukcHa4HBE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pJGQUtytkXjx2Xj9RWbLp7do7/o3fz6hFtTP3AtyOlQlOKmwhGnUGpVtTLnhJnWlEv0YVPQpfjSB13vWXOlLY3Dy5xrHvODf3JLKBEV722BOTA5JD6fygQWCykBLsCrPjj3/ZqsEz6/SlAwX0hPX5EF4SgLp9MiGdZhK4flonJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B803E1F00A3A;
	Fri, 21 Aug 2026 10:04:10 +0000 (UTC)
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Michael Hennerich <Michael.Hennerich@analog.com>
Cc: linux-iio@vger.kernel.org,
	linux@analog.com,
	linux-clk@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 0/2] iio: Make sure clk_init_data is fully initialized
Date: Fri, 21 Aug 2026 12:04:05 +0200
Message-ID: <cover.1787240005.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

	Hi all,

The clk_init_data structure contains several mutually-exclusive members
for different methods to specify the possible parents of a clock,
prompting drivers to initialize only the members they need.  However,
not initializing all members may cause subtle issues, which are only
exposed when CONFIG_INIT_STACK_ALL_PATTERN or CONFIG_INIT_STACK_NONE is
enabled.

Hence this series aims to make sure all members are fully initialized,
to avoid such bugs, and to prevent future breakage when converting
drivers to a different method for specifying the parents.

Part One[1] fixed all cases that I identified to be real bugs, in
response to a crash I saw on BeagleBone Black.

This series is the IIO subpart of Part Two, which fixes remaining cases
that are currently harmless.  These are still fragile, and may cause
future breakage when converting drivers to a different method for
specifying the parents.

Thanks for your comments!

[1] "[PATCH treewide 0/5] clk: Make sure clk_init_data is fully
     initialized (part 1)"
    https://lore.kernel.org/cover.1787165329.git.geert+renesas@glider.be

Geert Uytterhoeven (2):
  iio: adc: meson-saradc: Make sure clk_init_data is fully initialized
  iio: frequency: adf4350: Make sure clk_init_data is fully initialized

 drivers/iio/adc/meson_saradc.c  | 2 +-
 drivers/iio/frequency/adf4350.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
2.43.0

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
