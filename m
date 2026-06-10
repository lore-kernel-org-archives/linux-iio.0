Received: from mail-dy1-f193.google.com (mail-dy1-f193.google.com [74.125.82.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F21840629E
	for <linux-iio@vger.kernel.org>; Wed, 10 Jun 2026 13:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781099938; cv=none; b=k34tvnhT8NGVLMsSKX66pojxZa1ep8qVws454gZMp4yWTg55nN4l9gSD1ugwDXSbJOqXF3szEAWVrSjaFmUU2ET/AURuVLf1AWQu1LjQnQAq9NdF4K/vzO45E/VJ4GWCaX9hqYBp5FbqV8SkyRjmXAWqmsPUGFKKtdHV4FeJ/zE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781099938; c=relaxed/simple;
	bh=Y2CUM2AKTSs69WVEmR2vzDzMX60ql5sF6WL2aIjGCWI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=StlnladQBsFRj0a2to8LW41weDKZWXNlegjLiUW8AD4sxEYOhDhfme6HhJlb+5Lb7H/ZLsBz+nzgKhfO5jjr35h0w9bobtOIAyOOmFlKvDbYK6a07aQcn3sUY0IV6cSx4bLK4i7382pZ6i2MBxzkUOOyBLyRsaGzrn1he/tLSVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J1IAouhc; arc=none smtp.client-ip=74.125.82.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J1IAouhc"
Received: by mail-dy1-f193.google.com with SMTP id 5a478bee46e88-304ec41197bso6762679eec.1
        for <linux-iio@vger.kernel.org>; Wed, 10 Jun 2026 06:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781099936; x=1781704736; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nMlGQmXNm/nl7p4d+v73wkRbjfTyYIWc/LPR5eyxG8I=;
        b=J1IAouhczQ0yWYubu1D2JU8DpblDkAnyKykhAdfYu63q8f2m0XINiPcQSHCltGnsZg
         4d/0lss99YQw8NfD6HFVh+kjNe3h4XXhiIW44OADlFWqLGS1ykodTI1/+EnrJYSiSMzg
         g0MhEzDeN84MowPVZK2irVKv7S0bJ+/5WZld56TfaVuBBP1zxIRhyR0q21HZU8zGAsVT
         eZuacykZykYRUi/VlSUU0So0YWQXpVCxnWguiKs15YokQtpNklplpQw15P1001Mj1SCI
         zgfPPOfNn1HEGyO8SK6vCN4bKklOOiIkqOjR39P6gcW7ylAKq/8pSvAKq2YpQYqRS0g7
         hVZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781099936; x=1781704736;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nMlGQmXNm/nl7p4d+v73wkRbjfTyYIWc/LPR5eyxG8I=;
        b=m1xaQm0XHAmT1L8p+niierPAfKFLpxN/lOKhZGY0leCbWjtSBHVsOxxCJ7qDEXjyKI
         8U71Vln/XfVZYwMn4Wgtjys5GRI/rAhJMfh+063OpECqAoOBUIeNmDmt36XsBHyaoLYx
         BpZNZ81YWV2Hh7s36qK8/ussemRS0kZu0tytJ1KlIWBLHOl0JyKxDXrK0NKX4lsTpv88
         jaNa++aPvK3xZqMD0d8H/SP55aSK1mvds2SibRzUc++LY1vNfj9MUxWwBRgHCGoTC9YG
         wOQ3qA56PJLcEbXNfVBsmixlM9FjUTZW7y/EaS9ts0ooJDdPp9UucaNMncApYjKCMQ3i
         RUNA==
X-Forwarded-Encrypted: i=1; AFNElJ/TlpVnQBqifJSzbtG+mAMUj27/OOeyCELvUFUJAw3eDYRxKWwVvlzdbIPDzzCt7ukf2Og8WMd3mqI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmYg8DMi5dL70tG2I+Jy/37JVgcf0nntZmPvfjULNkAn4vdruB
	8eoggXsH6ETf+XtkPTuq69Ia/2W1YvrfK5QWV46j3Y59SbH7w2qoFJtp
X-Gm-Gg: Acq92OH0KXKchqXZD+rP/45yb+jGd2INERJRR85KzYoRB9sRBbg0fMh07wXXC6Npd9s
	H13wFxMvbro+QjkWW/+bS+cEb70LsGn+20S0LCjCkhqG9sducyEl8Pc8GqNdaiSYYnOELHX+nmo
	zHRx3pFch1RmHF1SeYWQLPSg1eliHlxKMnFmaJ8LK0vFcwZ732OTNab5vRfSP7mNr7aAunshEfP
	hHj8EtV1a6y0FKa7lxRg02MMRqftmCXU1dNEa0w9IM6YnqcvEJm+UnZ5EBXbpshZCsxaiFW6nJC
	AOu6jAgGPUtjsLTSreWvvqB/p6n5RYgF5ozULajafHfGdnWq6VL0bnf8ynwTmE5ZUARe2jkOgsb
	WPt/IkFv37CpVG0y6SswiKKE1Jju/i3IPOQfdRI9u7dWKzoXjfNI8q83NFcAnsVAR0LPU+focbR
	OT+1bRYlgLqjCrUWUZ67YTuA9ZpWBQRyPVqNqN3MGW5NNVwUjmih4SXy+3hqTE2+/eAQ==
X-Received: by 2002:a05:7300:3b06:b0:2ed:e14:e954 with SMTP id 5a478bee46e88-3077b8014d6mr13717634eec.30.1781099936410;
        Wed, 10 Jun 2026 06:58:56 -0700 (PDT)
Received: from localhost.localdomain ([76.32.119.210])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3074dcbe995sm33092237eec.13.2026.06.10.06.58.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 06:58:56 -0700 (PDT)
From: Hungyu Lin <dennylin0707@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hungyu Lin <dennylin0707@gmail.com>
Subject: [PATCH v6 0/2] iio: magnetometer: bmc150: use FIELD_PREP and FIELD_GET helpers
Date: Wed, 10 Jun 2026 13:58:29 +0000
Message-Id: <20260610135831.91739-1-dennylin0707@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v6:
 - Group linux/*.h and linux/iio/*.h includes separately
   as suggested by Andy Shevchenko

v5:
 - Remove the extra blank line in bmc150_magn_get_odr()
   that was inadvertently retained in v4

v4:
 - Split include sorting into a separate prerequisite patch

v3:
 - Add missing include <linux/bitfield.h>

v2:
 - Use FIELD_PREP() and FIELD_GET() helpers as suggested by
   Jonathan Cameron
 - Simplify bmc150_magn_set_odr() by returning directly from
   the matching table entry

Hungyu Lin (2):
  iio: magnetometer: bmc150: sort includes
  iio: magnetometer: bmc150: use FIELD_PREP and FIELD_GET helpers

 drivers/iio/magnetometer/bmc150_magn.c | 50 +++++++++++++-------------
 1 file changed, 24 insertions(+), 26 deletions(-)

-- 
2.34.1

