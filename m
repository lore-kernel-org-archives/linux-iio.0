Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A911DF74F;
	Thu, 26 Feb 2026 05:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772082782; cv=none; b=UFy84Ie0M0HrSMFFFq1kpPDi4+MNK+atA3ZIuOfBAVVTgUTf1zwpdtWsuBWmfLZUxQLKlaK/JY5CIajX6V7U+CJnkepW1m72J/0ZH8G0Q6CCVLgaI4C0NR5oaNQ7tSN/mXiesCaeX/muNALL4mIkqZMiDJRsE98B5EWh0c8n/8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772082782; c=relaxed/simple;
	bh=cUGWVYbT1gHH454LRXj1SA6j8I8aKW3ClK8FsPfdY4E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LvrvfAg68QGE8IeYnVrKtjA3r6F6R5F1d57rPAxiFcXxzaBEtldWX4/FvHEJX5mQppu12VMTPAhyAHBQQzN/xIM35Ndk1gB5WsoRiYLXObr+JBD0yscHjdsrqOksTXX2llYHVm8kPmqjYn/5FyXYudAdUfZe5DEUQieImQVjo2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=jcT8QWdt; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jcT8QWdt"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=aGgVpz2weby2NNip7NqSmZyrEfMx++8PG0qOyumWZZk=; b=jcT8QWdtVAR5VLgyLxCbtoADqO
	bm5Tau9gnHfuFzJwkdufaBh1erBCcIRAG6dDtMFzjRazvAk89ByfufQTpjlHHoF1t9FXOxmp0iLs8
	PyqWPmOLTB3as0ak9V5SjssRE7ovTbBuSkLvU+PeG62jfuplpeLJNpFw8ov6zXQ9PBZOwpiIQw10i
	Ks9O6YFLXDCZ9jjRWhYDF16Y+FAa/fxDTMgqcsSohqNt6AZfYTmSWZu41SIlNqTV2rwCFtIQ1doJg
	M8MmGr2s0ad26JJV2KOg0ObymEnNa1bcVLJhekDfj0TvaReeCx2KX7HQuX85e8LGJJ6HuMDuXHRIr
	xyxSEEMw==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvTgJ-00000005PM8-0zsn;
	Thu, 26 Feb 2026 05:13:00 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org
Subject: [PATCH] iio: tsl2772: fix all kernel-doc warnings
Date: Wed, 25 Feb 2026 21:12:57 -0800
Message-ID: <20260226051258.555019-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Use the correct kernel-doc notation for struct members to eliminate
kernel-doc warnings:

Warning: include/linux/platform_data/tsl2772.h:88 struct member
 'prox_diode' not described in 'tsl2772_settings'
Warning: include/linux/platform_data/tsl2772.h:88 struct member
 'prox_power' not described in 'tsl2772_settings'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
Cc: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>
Cc: Nuno Sá <nuno.sa@analog.com>
Cc: Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org

 include/linux/platform_data/tsl2772.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-next-20260225.orig/include/linux/platform_data/tsl2772.h
+++ linux-next-20260225/include/linux/platform_data/tsl2772.h
@@ -61,9 +61,9 @@ struct tsl2772_lux {
  *  @prox_pulse_count:      Number if proximity emitter pulses.
  *  @prox_max_samples_cal:  The number of samples that are taken when performing
  *                          a proximity calibration.
- *  @prox_diode             Which diode(s) to use for driving the external
+ *  @prox_diode:            Which diode(s) to use for driving the external
  *                          LED(s) for proximity sensing.
- *  @prox_power             The amount of power to use for the external LED(s).
+ *  @prox_power:            The amount of power to use for the external LED(s).
  */
 struct tsl2772_settings {
 	int als_time;
