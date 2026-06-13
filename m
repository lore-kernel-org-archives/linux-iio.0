Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A6DAD24
	for <linux-iio@vger.kernel.org>; Sat, 13 Jun 2026 00:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781312296; cv=none; b=suL7rWzbglT1NNn55ZGiqesxdCquZ1fP/bhmcvCl287lSO+bnBhKFQmdsAtoj6/5LRcxBCdpu43yUjdg4AT1OoavneSPcAxVL+akhI1i1doYyISoLp/mM8OY+14Iqhl4pKn6sw7tDJWkBz9z7dM6pLxGf8930it7X3KwjKtD2nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781312296; c=relaxed/simple;
	bh=Z9R14y/b/INRO5sVutV5vQh2oKTubF9vHDewgR71Plk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OvT+6h6mvwCGwk9py+kXb33HqrYcErCkAac0BgfLQ4p2MbN6vc+FHZILXOHRDgRdtAx5mfdfHWaggT0MyxAwJZ3wOtI6TvCctWDAQ+Uov8G7A3GuH+QAKRith2eMQRi5hZAThtfooJzq9v/SQmPAp9J28FB9CS9FZfjdtOuZXDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IaCSRKSn; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IaCSRKSn"
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-44273dcaca8so774872fac.1
        for <linux-iio@vger.kernel.org>; Fri, 12 Jun 2026 17:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781312295; x=1781917095; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/aaaLGtGMdloDgmx4w88ZqZn+UMMDoCbT7BG6Ejcd2Y=;
        b=IaCSRKSnTI81CxrhC337sSoFeLghrwWUrC2L9bihrGAhlD/e4ZSKTBnsBQD7OZHbxB
         tDF15ONrZSDInXRBvL6txU8I5Z4P9bFsUaUnztnFk1mxoNJvNaUmgUc0crLzmTBrJeNJ
         6Wwot24f5jzC0yAN+kIQemaZkpCiE0r0f04qoP6xt0wT1cUd7GsTz/TdctuGpkb20nbJ
         nuExzLKlblPHVSoAkf60H1Mh6k9P19mIbw8arfrN0om+eqIb7eoIDpMqd7WyDwp17y42
         jgfNoXzAQDg/mi7s6w/mdhRpHku8bGFDNBavaVjGKcT6nSf1QUx7RJKvL3g4ZHd+e2fe
         5BTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781312295; x=1781917095;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/aaaLGtGMdloDgmx4w88ZqZn+UMMDoCbT7BG6Ejcd2Y=;
        b=NaIp2lD+Mm3OXbjYjhvMXgIUl2WT1ou4kv63LABn9FqbjfP8vEkwYncSnYu0Qt3TYi
         4AJTNNazZQPfu8HeOc43HmKXaV4jtQdmTRSOgidTFqpD3mYCoQXhLlJl2lvol0VdTm7T
         c9hgejNUUMK6jOjCw2+CKA4RkZl8PypaKDZ4KLQwaWJlRANBEOzxi4gx3oo6srkZoPo6
         OkkUIfNPZ3/HwAVMxNh0eKb0dukvOA3BF/GV5i86D2TIcCjGhcncuwUe8pzN3T/F4UvJ
         N/OhCuFTzTZFFJtQlTiY52XXN9htSdNxlR8yqzm1ebJZ1/nTloa/cyi8fDOOVgWuHQFD
         L0UA==
X-Forwarded-Encrypted: i=1; AFNElJ8TL1xr2ZHFFrilUJ5IIZgxsdgH4GEklAsOi3Tw/MM9gDwsbxfL2mggITDV0nQUZv9Oox+wWXoJnXM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFh311bjSqEnMq8hS+ccNjLZ1QjXLJTppeQAjh1ZYS88hsseOw
	K91k6UfM2wZt6rTjWO3nbGNDErf2s/RvOT8nKX3HvZtbPs7Y/O8O0oTT
X-Gm-Gg: Acq92OHNJuIIuveQcepPA0lGwgcyJPSwcX7hxDjq+2HA6UWrRLDYd2twb6pja/duUHp
	9/2lr5uKL8tH2YBknSGXX9bPEWMfWUjPorod740+fhMdD2UC6L0X/u97wggMgMcUaymiEjWgdH6
	k0xeZAcQ5WnMRfX8NQlnX50nTyj/Y0q8NtinHIq5R7IQvabbKKFN8v4PtXCO7tbonkraoacBYWd
	87fXyCT3IHzXvZ3xL5inG4DyFWR5Cqt8Bz5Xy0KSeewxFrYCiSTTGvg6ALIQKa2LyCCx+s6isLt
	uL0uCUresG0a1ZHewWKCnsbQ9JTwR/C/LMVenBFyA+pnEspOha8YObkmLvOBXhtuKPTTLeOUt2D
	+2t+wLSsee4T22fynDFv1XiNPWrt+DTSObHcDpalo5d9pFjBGIyosNGwgTAOGU4JwTsA23T/Ymz
	7pOFE2kQIbDXc5HSnyVEI7kYygd93bDIsHInIhMp/BmyAn0adg2LKD45JuMA==
X-Received: by 2002:a05:6820:211:b0:69e:3868:a739 with SMTP id 006d021491bc7-69edd76b56emr2093232eaf.24.1781312294619;
        Fri, 12 Jun 2026 17:58:14 -0700 (PDT)
Received: from linuxescape.lan (23-88-128-2.fttp.usinternet.com. [23.88.128.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4426abf260dsm3150731fac.6.2026.06.12.17.58.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 17:58:13 -0700 (PDT)
From: Maxwell Doose <m32285159@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Vladimir Zapolskiy <vz@mleia.com>,
	Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>,
	Hartmut Knaack <knaack.h@gmx.de>,
	linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND DRIVERS),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/LPC32XX SOC SUPPORT),
	linux-kernel@vger.kernel.org (open list)
Cc: Sangyun Kim <sangyun.kim@snu.ac.kr>,
	Kyungwook Boo <bookyungwook@gmail.com>,
	Jaeyoung Chung <jjy600901@snu.ac.kr>
Subject: [PATCH 0/2] iio: adc: Initialize completions before requesting IRQs
Date: Fri, 12 Jun 2026 19:58:09 -0500
Message-ID: <20260613005812.160572-1-m32285159@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

This short patch series fixes the issues raised by Jaeyoung Chung,
Sangyun Kim, and Kyungwook Boo regarding init_completion() and spurious
IRQs. The report is linked below [1], but I will also put it here
inline:

"lpc32xx_adc_probe() in drivers/iio/adc/lpc32xx_adc.c and
spear_adc_probe() in drivers/iio/adc/spear_adc.c register their
interrupt handler with devm_request_irq() before they initialize
st->completion with init_completion(). If an interrupt arrives after
devm_request_irq() and before init_completion(), the handler calls
complete() on an uninitialized completion, causing a kernel panic.

The probe path, in lpc32xx_adc_probe():

    iodev = devm_iio_device_alloc(&pdev->dev, sizeof(*st)); /* st kzalloc-zeroed */
    ...
    retval = devm_request_irq(&pdev->dev, irq, lpc32xx_adc_isr, 0,
                              LPC32XXAD_NAME, st);           /* register handler */
    ...
    init_completion(&st->completion);                       /* initialize completion */

spear_adc_probe() has the same ordering: devm_request_irq() for
spear_adc_isr() before init_completion(&st->completion).

Both interrupt handlers, lpc32xx_adc_isr() and spear_adc_isr(), call
complete():

    complete(&st->completion);

If the device raises an interrupt before init_completion() runs,
complete() acquires the uninitialized wait.lock and walks the zeroed
task_list in swake_up_locked(). The zeroed task_list makes list_empty()
return false, so swake_up_locked() dereferences a NULL list entry,
triggering a KASAN wild-memory-access.

Suggested fix: move init_completion(&st->completion) above
devm_request_irq(), so the completion is valid before the handler can run.

Reported-by: Sangyun Kim <sangyun.kim@snu.ac.kr>
Reported-by: Kyungwook Boo <bookyungwook@gmail.com>"

+ Reported-by: Jaeyoung Chung <jjy600901@snu.ac.kr>

Quick note, I ended up editing the report a little in the individual
commits to match the driver we were fixing.

[1] Link: https://lore.kernel.org/linux-iio/20260610115700.774689-1-jjy600901@snu.ac.kr/

Maxwell Doose (2):
  iio: adc: lpc32xx: Initialize completion before requesting IRQ
  iio: adc: spear: Initialize completion before requesting IRQ

 drivers/iio/adc/lpc32xx_adc.c | 4 ++--
 drivers/iio/adc/spear_adc.c   | 3 +--
 2 files changed, 3 insertions(+), 4 deletions(-)

-- 
2.54.0

