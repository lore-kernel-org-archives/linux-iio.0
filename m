Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3632C51C335
	for <linux-iio@vger.kernel.org>; Mon, 19 Oct 2026 14:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792419411; cv=none; b=hzZkgvk07+AB+8laWtOQRshVA7mhI/xVjiksBaMWgy9wOO+3JYnVX2Y3S7YO71bgHVhepikL8N4inyPXBxz1bt88G/YwQHcnfCxFDmBRQlOULFNb2W46RL3NuGVFPytL8svx8uaUA177Xa6Scqe3kH/pL83Ta8cDDEtyy9BjXe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792419411; c=relaxed/simple;
	bh=fla1bg5rcRUTQWm9+7n3cZD9NexmAMaAbCKTBZoJQIo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Taj89oUe3tLKgfEVdkZbzCABVq5E07F+4hYwIim4c3TpVU3S1Xl18WPZHO1GE9vzbQWGTGDYfktegohZBVltBjELIkTCb0aRcj0Zwlz39w0dvrHn8y+uV1GGYyuS0NLR4gaFUjCGxcT2GgxhhOECjcrbi0dJ7UfjTsphThYGhYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NOZPcbit; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NOZPcbit"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5be4fea434bso759826e87.1
        for <linux-iio@vger.kernel.org>; Mon, 19 Oct 2026 07:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792419408; x=1793024208; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fla1bg5rcRUTQWm9+7n3cZD9NexmAMaAbCKTBZoJQIo=;
        b=NOZPcbitfI/gRFl44pTbWnKVzKx1aTnKaNXsXTm5yxVJ1/MPYRps8CMCfZ5GaC17vB
         4fqDlTY1xAvyxrLAr6KpUIWhYy6OX4M6gSik7KQcXphS6dHQWVlEwcI/lTXpTVtRfdDU
         9C3mX9DrhTMRFc9HhfNtYS6TkxeAV5a7Ozz6wYjV1JkOx/gCUWItB7nrTwHqyKSptJBv
         LbpsdzMFZOjkF0dxeBJCJMUaezvD7b2PcotCA9HgHgc4G1qZL46+FyAX4aMzlTydqWlA
         MHB+HrJjSONhmXQ5bmvoY97UzFwEv8QOcaO+YDVntW2IKlcHWnPEU+Hq0qOoR8m7v8+t
         jnKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792419408; x=1793024208;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=fla1bg5rcRUTQWm9+7n3cZD9NexmAMaAbCKTBZoJQIo=;
        b=Nvbzar9pY1kTSGOaODyRkFfpJy9n6jI6AMREEbZzYsGzVFsqwe0CysvskhJMhwUfFt
         g5ykaeE/j5QLYuwQ0zHrP0FSv68DUpM8VQIQd3NMnhI0TisFDxtfa9JQhMmHRdUIvaVE
         sn/zwPKypxGOWc+IVdL/MTL00ZH+CUM5wcruHzp80nrCsZp2rtXLhJDZrW58MRb583pt
         lvXtfGcpK4YZ1GH7t4vIjJGzDWwOzvL/h4FtGQzgQ5+WLJrV59bpNlMJCrdBv+4W+ol2
         bDjKsJYNn6ijtt6lLMUfeeGnazE6hDpr/eLVqz6iZuWTzgtdX758LGwd9D+ApCaPZQ6J
         anbA==
X-Forwarded-Encrypted: i=1; AKwUvBzHGrPEdQb+RWbKh2isJa50+icpks0Ksg8LMToc9wOJNxckbOtIZDnKDNci3OTLRLmxmybavdXbKcM=@vger.kernel.org
X-Gm-Message-State: AFq9FYJgeGQNWt02acgVXVGdjHAe8NIfMJqKHMmMjMrcanTMwrLn13Ou
	95G4h2lAARgScNavCo/IMjTZsbLIRFBR55fmZQd1GVK70RoMVPD9tXLa
X-Gm-Gg: AYBFou3WLY+D6xM/nU2Euzta0dpWFcdmqFacy7aHkyNC/w0/x8C+2RC2S/oWpNRehuC
	UpHLlbvSbvBxxbkp1XntDQ1eFKmOWtJde0K+qvsU9czPqSVA2EK0mXvw/GEYd0wPrg6gm8IK0Cr
	JUBoT7eolPG3bfkSeLtyMQS1/zYgfccZ/+nKg487WuutvyOUsw5lzmsQ80LH8JWixoyk8zydKNj
	e0xUkNqTx/pD3sq4LxnHMu32F8Ky3c1xQpk7aslasfbUPUeL1DHDMip3szYHohvRGJjp5UvkGqK
	fpKFJOkm97jZYHudIGN0puFYtoEsRMuqo2hqLsuEsV3Sip8+nRiksU/sxp4DaDvQlLunQ0AwHNy
	EbqiQdd8ZEtm8DC7VJMd11y7kIhrscrnERLAUOQUU7gBwwdHmTgU7EV+9rfy6p8YRgPpp2JKjJh
	20vH4/DFE8njMcecucOdK2qMBDoXIiKOIBnT6Fhp0poLKX/ylPVXvB4/hmfZaHFmAHRnKfxyNoR
	i1CIucXiy5jnqSBrrjbx8W4O6cgMbNA3SbuoNFFHAjyfydO1T/vhysndsdCuwmsFpjJkx8GYBJ6
	BDo2Vek=
X-Received: by 2002:a05:6512:3b99:b0:5bc:f2fb:f4be with SMTP id 2adb3069b0e04-5be475aff00mr3545839e87.6.1792419407901;
        Mon, 19 Oct 2026 07:16:47 -0700 (PDT)
Received: from yantra.. (nekmmqvd1y84bxeinum-1.v6.elisa-laajakaista.fi. [2001:99a:d7d:c300:da13:4805:c131:eb3e])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5be4a4347fdsm2097591e87.35.2026.10.19.07.16.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 07:16:47 -0700 (PDT)
From: Rupesh Majhi <zoone.rupert@gmail.com>
To: paulius.zaleckas@gmail.com
Cc: Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org,
	Eddie James <eajames@linux.ibm.com>,
	Joel Stanley <joel@jms.id.au>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Joshua Crofts <joshua.crofts1@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rupesh Majhi <zoone.rupert@gmail.com>
Subject: Re: [PATCH v5 0/5] iio: pressure: dps310: add Zilltek ZTS8032
Date: Mon, 19 Oct 2026 17:16:46 +0300
Message-ID: <20261019141646.49599-1-zoone.rupert@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261019083620.1285782-1-paulius.zaleckas@gmail.com>
References: <20261019083620.1285782-1-paulius.zaleckas@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, Oct 19, 2026 at 11:36:15AM +0300, Paulius Zaleckas wrote:
> I have no DPS310, so patches 3-4 are untested on one.

Tested on a DPS310 on a BeagleBone Black, against iio/testing without
the series (dps310.c as a module on the board's 7.3-rc1 kernel). TMP_CFG
still reads 0x80 after probe, pressure is within 1 Pa of the datasheet
formula at every oversampling rate, and the buffer tests pass as before.

The board adds the sensor through sysfs, so for the OF table I also
booted each patch on QEMU rainier-bmc, which has an infineon,dps310
node. Same output as without the series.

Tested-by: Rupesh Majhi <zoone.rupert@gmail.com>
