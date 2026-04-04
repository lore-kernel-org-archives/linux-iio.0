Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E695E2E54BD
	for <linux-iio@vger.kernel.org>; Sat,  4 Apr 2026 20:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775336339; cv=none; b=PEyIui+ZaPeK8AykTydEyEAuoAG7I0d8t/p7cXQTCLeR/1WhzE8qVsIdfRwLgHgxWB0E6QRPk3RDG2sVg1PxQiUS22DfruOUoQI+maniI4x6hvTNSuWwAbF0tms3OFwGMtXd8whVkITsu5sxmF2iuBAcsPL7PsIylDpcAwHD9wM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775336339; c=relaxed/simple;
	bh=9nvdIFs0RiVU6vxasKbbrN5eV05nBxgSym4LflyWbDc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X3HRcz+LQtF3ca5J2WtWwRkUq9Bk/5iirw7RoCMdp/xn0N7KPTAB7T1yTvADOoEQJoEmijzIWJY4E+CF0lSQiapGL6stMTMb4cdjAMb6UP5iQKmCp+QB72//TWZcuvk/ZzkWDFANeCzuDezlVAtQAeiTPAEll9SVEB7QwknG51I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VdKiJeBu; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VdKiJeBu"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-488a14c31eeso7615035e9.0
        for <linux-iio@vger.kernel.org>; Sat, 04 Apr 2026 13:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775336336; x=1775941136; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=duUyI1SAeNVm/Wy4g4Wo7s4yIGMomxToV5BpPoZ9vuI=;
        b=VdKiJeBu3aKxznBlalOgyX8bhtNzZo6tY6nquA4cKYJ2B2Bi4+XIBbMpCWH4aOMh52
         bKofN2Y+G4Vh6yM2u5fVdO0M046nO10A0S08rSG1D6GtsocSLKHyT8PQsr91wPlS4RV3
         nX7kMK1vtQ3X8XAjK7IlX6iyQw2Y74XQr1Ha4kvKHhFJm48u8lbBtSXskPJ4N3SIFo1n
         jTddHpXxYBCSZVszP01Wsc8uU1l2timnBBDSQRWbB/4bTVZW+m+cjyrLO1Un4uGedQag
         vpwF6Q7KcPeZQKL3uR4kk3ewbbYy5Ex5kOoKTD8jFHQ/KHyRX7bhu7ViLodgWlhfb8th
         qAvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775336336; x=1775941136;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=duUyI1SAeNVm/Wy4g4Wo7s4yIGMomxToV5BpPoZ9vuI=;
        b=UCP90nDFWUvr8/FSSy3CCUMzaXjQYvL39RxX27RoYqI8P7jak+MqZJ8rgjUrol1Sy7
         AsFMJBeVzRldyoBfVQSt4mn4inwSsSvqNBksLFf+7A7f22rsWHfuiuU1n1n6rtGGxqhL
         SlaI3/8zfOM7Dd0eJto4oUwu9ab0ZuvJCUpNy74uG8zFZqr7C+w9IxEoQ9xgvSHse4pn
         Dbwb3aLnvCmTThJIX+PIVGFf3wCLb5pfyN3bVedK19U1c8jsksC7Xxgm9SuWMCxi/Ih1
         goMT36SSC8AJAJO2Cf2MtLB433+XPmYRmu20i71gV0HYQj3JGRNXxsvIn9ZGopWUiak4
         ZInQ==
X-Forwarded-Encrypted: i=1; AJvYcCUrGTChNoPjTZTUJDV0qNWTrdscYyuNTgQFg01esmPgcFPkvlqR9u7GOLhOjfm1smddpFI2ZSzHuig=@vger.kernel.org
X-Gm-Message-State: AOJu0YygkDoAl12D9SapQPpMo/jV2/C2tHouvap6CYUrYqKOP5gCAg5O
	6Z8CpKSiMQHz73lNvEPxY2VcGj+Gn1QJjQQferGQW7XgnBt6G/hYEn7o
X-Gm-Gg: AeBDiesF+qJ68ZnbnZjiJLkZGop/qVTG4u3yms2/q2yCO5btuZoOQsyyJQezix1O0EX
	3CJz95IdrQjX9Yu7eSV9mS3HhX6dwAL3fV2MiHAFdwQ5/Hf9DR85Djre/fy/IUiuFldnAyyT/Rt
	V+KWuz2M/nEBMlR0FeZ83Sy+3aOFD3Qm7mxrTYNgALyInr9ZKpFvTZJck3mK05VbUzEq/oMjXyW
	UdgIA4H25LNbmI+r3Zj+oLwvT9GZ56su91KOxFlOQvzBItqBwrCnimMD5LyMlLhgqbAhvNxhiov
	2ZrIBiMVSfnea7S0qRpoAYMZntRSA8B0EpCQNiGSu3Qp2VA6ZnC3eURO0twclusFQx4l9k4PK39
	kbwHipUN32/sNW6/0rhJYhZDm5wQL/8Mpnp2DmFvPhuAIlQk+C6CG5CwCIWiV0K6zPfi8VFvUFZ
	AMgt+xxg4O7/fNP2oKnDogZyIZwdrJXaEsJGqEh1HxSuHonTJoXY32
X-Received: by 2002:a05:600c:3042:b0:488:a25e:14b2 with SMTP id 5b1f17b1804b1-488a25e153amr36322295e9.9.1775336335750;
        Sat, 04 Apr 2026 13:58:55 -0700 (PDT)
Received: from aldo-conte-t14.tailf68ad9.ts.net ([94.164.143.38])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488a36f22b1sm84749535e9.10.2026.04.04.13.58.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Apr 2026 13:58:55 -0700 (PDT)
From: Aldo Conte <aldocontelk@gmail.com>
To: jic23@kernel.org
Cc: ktsai@capellamicro.com,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	daniel.baluta@intel.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	me@brighamcampbell.com,
	linux-kernel-mentees@lists.linux.dev
Subject: [PATCH v2 0/2] iio: light: cm3323: fix and cleanup
Date: Sat,  4 Apr 2026 22:58:50 +0200
Message-ID: <20260404205853.18559-1-aldocontelk@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series fixes a bug and does a cleanup of the CM3323 
color light sensor driver.

Patch 1 fixes data->reg_conf being incorrectly initialized with the 
return value of the i2c_smbus_write_word_data() instead of the actual 	
register value. Tested with i2c-stub on a Raspberri Pi 3B.

Patch 2 converts dev_err() to dev_err_probe() in the probe path.

Changes in v2:
- Patch 1: fix typos in commit message
- Patch 2: add struct device *dev to shorten dev_err_probe() calls
  to one-liners (suggested by Andy Shevchenko)

Aldo Conte (2):
  iio: light: cm3323: fix reg_conf not being initialized correctly
  iio: light: cm3323: use dev_err_probe() in probe path

 drivers/iio/light/cm3323.c | 23 +++++++++--------------
 1 file changed, 9 insertions(+), 14 deletions(-)

-- 
2.53.0

