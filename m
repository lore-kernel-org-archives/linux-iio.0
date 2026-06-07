Received: from mail-dy1-f194.google.com (mail-dy1-f194.google.com [74.125.82.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF50938734A
	for <linux-iio@vger.kernel.org>; Sun,  7 Jun 2026 14:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780842091; cv=none; b=juPB/SdcrPFLtpBboIlSVl2hp5y2v/e77VG7Q5GR8Kl41BqbASs0ohdkMrgK/hiq+G/m+LGq4mbF6a48ltSqVibD11QW2+7+YLoHRRkv1VB2ALnmyeQhwzqRx+a0iTfguSyBgYqknwk7JcnW78TXjtMJZGVXv/krdwPg8i6Yr6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780842091; c=relaxed/simple;
	bh=CTqloBSGqoz185l7mRoYpe6BZ8rpvKSiDZmoaMwHCYg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rqqU7dtjuh0e13j6LDDaNfZ3SkjmshbL8rgirL+FWNgy5CBcObzWqyh2Se0zWJjA7bMcMZ8fUid26gT8o55wclkBGJcUa4v11N1gwBAvgkofeNwt0D+4pyVlTLhvoGdsT9ifVz9ND6QMtK016/TQG2xGvde6em6zi8nm674di+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l+o445hY; arc=none smtp.client-ip=74.125.82.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l+o445hY"
Received: by mail-dy1-f194.google.com with SMTP id 5a478bee46e88-304fb780deaso3416431eec.1
        for <linux-iio@vger.kernel.org>; Sun, 07 Jun 2026 07:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780842090; x=1781446890; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SpyFbxr/mTMl7pdReZGEnZhJ3HiTnoY15x4rU9Q0ppc=;
        b=l+o445hYrfo9F3uCWXZKPVgyZBXbO+xCj04Bh//TL0bPHCeNRS/x+NfV1nJ8Nq4VUa
         tG+mYRd2B9F85ufe+LxyO6r7hKPUtTh1sucTpsDk0FhdI0Ml+nIogWmQqP2+rtYlEakz
         0WCwSwEuAP8av7JTdb1s3DWGUCB4tKTZkkFD2cdSvqI3/foMvjqGjkPmF6j1OsarlIZM
         vjdRDCXzBSMOETxFHXBez3oVh3wWoHOWKRdWNTC9egg2lAMoYScoyeXntu9wCWTZuEXT
         60PfB0V8/TTbR6imtOIdRpfRTSotdhwnytrPpQMcEkcQSStpBAhJK4gL0cRdSqmSRaL8
         jXBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780842090; x=1781446890;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SpyFbxr/mTMl7pdReZGEnZhJ3HiTnoY15x4rU9Q0ppc=;
        b=dpAMA4y9DlvO+bDHB6jaJc/O5vRW1HxbBq1d2sZ3nPj5tSmoEke6lNyeFg6zvNpT2r
         s1y+91zV5pTvJrEYpn9tCyM4nQefuB4Q2hwrCtJ7P9RqAa0CT5QkrhQGQNvFf2u+fWBY
         S+nUkq6ICFBCv2Z9W50RRb7YRkW/qGWzuJLsj8X5vnNOalC9+QUN5ai2bvLDzvQrEuZ5
         WMScNkjbRRCBaQAIaWA85Dz/3iVVZnxronBalRO+tA3OFUyc1ZgKG2kTovKACEUfynC7
         6nyqsPfXGO4YBEpVLogfAbzFrsn+VuozAfzNGZywnHzvmzHVWrEFFcDCmxasEHM/syWf
         wdxw==
X-Gm-Message-State: AOJu0YzEuc0EfCa1tHoerdYRU4jtGCwvlP5LOYB9O5SnFYRY0DQor+LR
	FoXPqKOE8GHr+Iiu5nUf9QIvEkweR2+HUg8l0SZ4hCSmP5CqyUtgvMIc
X-Gm-Gg: Acq92OE0G6+pMweMR1Yub4pHdwus4+EBDawCIC1ajEiymdE/vf7qqi7C1vAlOgVJUJE
	YlHTZgyGIB1Yi2CFjtJ+M9UHgUjycJb5957dmZ0qL+R1Cmajdh/5xGNwDH6yWKFX2pmTj1IvGEG
	ERa4sgAo0p0R4/hrGmRl3O3swAV5ijhKXFpFj74RAPJXhsd2xgYOpAD/msefCJz8oey2/1qin/4
	/bXamZWPPVrW92wk4OPpjn758faOP1toNfyfGaKpV8d+5kNQ6fEepSQuDAc5a+krkZk0yxz2MeL
	yBDy+UkrC9Wm7UVDyg7d/n4gyjUxVz/qmTbKNJOVfTBlddO8Gbc5Wj5F+UNL3CEp2169pMYbO4n
	HQpEtLkCB2uMslRMbuI7IQ9tvG7IJD4gAvZhPZt2IwxfnzBCs7W/2T+3KOyBiMjYCqfyyjY6la+
	oL0MlxGKFtB7z6J8Q8BFqY3KBGYdN8x5tMLnjkHQuap8tuyHEzgoFuPubG3R2CPB+ix1mHh0RKw
	Ejp
X-Received: by 2002:a05:7300:320c:b0:304:e7c9:b528 with SMTP id 5a478bee46e88-3077b2f4881mr5868816eec.30.1780842089764;
        Sun, 07 Jun 2026 07:21:29 -0700 (PDT)
Received: from localhost.localdomain ([76.32.119.210])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3074dcbe995sm17662842eec.13.2026.06.07.07.21.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2026 07:21:29 -0700 (PDT)
From: Hungyu Lin <dennylin0707@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Hungyu Lin <dennylin0707@gmail.com>
Subject: [PATCH] iio: magnetometer: bmc150: simplify member access formatting
Date: Sun,  7 Jun 2026 14:21:20 +0000
Message-Id: <20260607142120.60621-1-dennylin0707@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Keep the structure member dereference on a single line to
improve readability.

Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
---
 drivers/iio/magnetometer/bmc150_magn.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/magnetometer/bmc150_magn.c b/drivers/iio/magnetometer/bmc150_magn.c
index bf2551988008..d2075a18e6a7 100644
--- a/drivers/iio/magnetometer/bmc150_magn.c
+++ b/drivers/iio/magnetometer/bmc150_magn.c
@@ -311,8 +311,7 @@ static int bmc150_magn_set_odr(struct bmc150_magn_data *data, int val)
 			ret = regmap_update_bits(data->regmap,
 						 BMC150_MAGN_REG_OPMODE_ODR,
 						 BMC150_MAGN_MASK_ODR,
-						 bmc150_magn_samp_freq_table[i].
-						 reg_val <<
+						 bmc150_magn_samp_freq_table[i].reg_val <<
 						 BMC150_MAGN_SHIFT_ODR);
 			if (ret < 0)
 				return ret;
-- 
2.34.1

