Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E9A35DA47
	for <linux-iio@vger.kernel.org>; Tue,  6 Oct 2026 04:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791262472; cv=none; b=l3vIERi2urukZ95wTXI6stRuCZmPk9xCADoj/HECJhXSoR7mWmTmylSHN3LXjOTm97X9aN6HQ0kHOpuLh59wlM6JTEPF2ELkQK9+TtHLh0qsEV8liVeKtisFYAA7PyMIGW/prpk86selRxEbk4HDLr6FpTPL82XpsfcvBoCQhpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791262472; c=relaxed/simple;
	bh=st4dtKolWBUXgeyf3H36mB4fMu+aQ/9skKTQlwMh940=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ri51UCnDEHhSE3+xdrTWmANGloUL2CDQCYn/cw5DXKqnJGJdt7MEN4A5Kom9uxPlRO/1xhE5dhFMR9ySZZJRPnEKzTaiwDcBOO7EHhHlT5LaNBkXU3nv9WIoVvM62z0FC6w91MpyRmPo8S3V5ffaKf24E3EDC1nZOppraGAq4XM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VwTcKKRv; arc=none smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VwTcKKRv"
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-3514e7cbbbaso52971eec.1
        for <linux-iio@vger.kernel.org>; Mon, 05 Oct 2026 21:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791262470; x=1791867270; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=D1STebYYWN/Tm/3PMY6fG9dk0bK7CpzsFE061Yg4uRk=;
        b=VwTcKKRvaJZuRLk4FqYL6fDrLokTkJcGKs/t7bzLx8zDLoenETKpPogrh5z8VoFC0m
         jLKtV7kkTpUewZmEmMjRFcJFbuaeTKwZflvoP8PgLtiN0FdcZyFWceIVkwbd3i6gXBNU
         37KfbI/cE+yBcLIzera1bi2jJfJcmrmM5NalvGkI3sW3x1cS34crHshqPZnvsn/enAVA
         DdWSUCbTu5ZWBXcO27z1fSAY/9W3F8t/l1pMKWCeLaPX2ltHlhW9j14HLqJ8+N14RnyH
         67jVIABfzaO6k9GNfewcvdZAjTG1wdZdzgL157tayDtJeDfchcAFqdUymbV97KF/8fQw
         AVHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791262470; x=1791867270;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=D1STebYYWN/Tm/3PMY6fG9dk0bK7CpzsFE061Yg4uRk=;
        b=PWwKBpHOHF7bYdkH02zXxZu/gl1/VNE2eLyTxQSTSWdqtplNlSWL+AwSSugHCaglLe
         ILbK2FgRjlQwY+BfYCdZ1hkejfwKP6yFuzGErt9SVmndQa2aOixDXrd3xLz3XMrmvMi6
         HiCei0cTOq1kRQRPpfb75C/RQqvlkqdU/lXSW80MZNhvyCGfXZt5FsaD0Ju1/4j6lA3n
         mwl1jkrcu1nlJWEvJyXtE+3+5fc4XLf0O968m+5KgcS8lue9nM0IjfnHRpWShBoPdyna
         aClXONXm+jsfobdUa1rwEkhuJ4G3LjMTElOboZKHjYAYKpdQcjq3BjouXvWZAVMIi6e1
         mnmA==
X-Forwarded-Encrypted: i=1; AKwUvBwL1SdyQ2Vcm1cPgxQ8tQO90UqITUi36geVwu5gsiEhY634Tu1cUT6Sjg4srAnDIgA+18vVhjAXLM8=@vger.kernel.org
X-Gm-Message-State: AFuF++mOpz/m7N6NHx4CSU7u+vxez8eZVe/iw5cRX/hhPE355ogGy2Sv
	toZEdyf5kR/hx3yi1SxWVGSZwz4YKLdzEIWhvmG71bdHz5pQfKpu02wV
X-Gm-Gg: AYBFou070s9benF/ke6zwxnoPOrCKSZAbIDDuTyjBcOtPFDXftUezV5fqjdYg22KC72
	V7BYHt8hX8aA8reVPSZdUil+dJDk1kC10nXqJAqZb4iFKo5l6Fa+/s+2hV+tjJorPbjLGJU08tY
	bZwOxWdrDkxGmwuOaIUb+4eSmba+MfH30S8+kqK2uZ/doNXhK6bTftFmVZRuvE2MuhKCW3XulnL
	Zxr+M95NZBpzhjjhkCfZBGwhE6s4JjIoJX2WeBUglzdatVcVxwIDVbgFEBElTKs9q+i5Wodu5HB
	8o7P3/YWgWreneF2tPQMyvmskvTrVDvX3PIT9zUUJ+zeJQksnRF/sao6e9knNMVSaLp+McyFG44
	GcMRmWMGJQAf0+Yef9r5a6sUbRb94Q54bXqQK9SNmS+15k/qJFqyfU3xShYG/Om0dGtNsm+lk4c
	4zJlxJf5qg8xi48anOndsletkkLG6i3dzUTo+HoZlJVI1vcSWcOonlm6tt7cSCbXI5SvnlonH2B
	G1cLMYDuH/C+nS+oDr4kuty6pe5SN5sHzUT+t7NmTkFFDxjJlrroqYHd/ERSmuHbayWUg/vAQhT
	76Yiuv04D/c+M6s8SEpV1UbYlUhQow==
X-Received: by 2002:a05:7301:b08:b0:346:d790:9e10 with SMTP id 5a478bee46e88-3514e30cb1dmr236401eec.39.1791262469540;
        Mon, 05 Oct 2026 21:54:29 -0700 (PDT)
Received: from kapoor.iiserb.ac.in ([203.18.51.214])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-35146b3b5aesm5539737eec.29.2026.10.05.21.54.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 21:54:28 -0700 (PDT)
From: Arnav Kapoor <kapoorarnav43@gmail.com>
To: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
	Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Sean Nyekjaer <sean@geanix.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Arnav Kapoor <kapoorarnav43@gmail.com>
Subject: [PATCH v2 1/2] iio: imu: inv_icm42600: drop stale vdd_supply kernel-doc
Date: Tue,  6 Oct 2026 10:24:03 +0530
Message-ID: <20261006045413.14320-2-kapoorarnav43@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261006045413.14320-1-kapoorarnav43@gmail.com>
References: <20261006045413.14320-1-kapoorarnav43@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The vdd_supply member was removed from struct inv_icm42600_state when
the driver switched to devm_regulator_get_enable() for the VDD
regulator, but its kernel-doc entry was left behind. This triggers a
W=1 warning:

  Warning: drivers/iio/imu/inv_icm42600/inv_icm42600.h:186 Excess struct
  member 'vdd_supply' description in 'inv_icm42600_state'

Drop the stale line.

Fixes: 9fd569aa3d70 ("iio: imu: inv_icm42600: Use devm_regulator_get_enable() for vdd regulator")
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Assisted-by: LLM
Signed-off-by: Arnav Kapoor <kapoorarnav43@gmail.com>
---
 drivers/iio/imu/inv_icm42600/inv_icm42600.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600.h b/drivers/iio/imu/inv_icm42600/inv_icm42600.h
index e56943931b6a..3737e79dbcc1 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600.h
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600.h
@@ -151,7 +151,6 @@ struct inv_icm42600_apex {
  *  @chip:		chip identifier.
  *  @name:		chip name.
  *  @map:		regmap pointer.
- *  @vdd_supply:	VDD voltage regulator for the chip.
  *  @vddio_supply:	I/O voltage regulator for the chip.
  *  @irq:		chip irq, required to enable/disable and set wakeup
  *  @orientation:	sensor chip orientation relative to main hardware.
-- 
2.53.0

