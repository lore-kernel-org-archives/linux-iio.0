Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 947BB21B185
	for <linux-iio@vger.kernel.org>; Mon, 13 Apr 2026 09:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776073498; cv=none; b=NT5g6gfHtBLVsZwt9X5ti6gV6E2VkijVIHaDoTNBY0zAXTASie4Zpv6pOM8ZSUQ2KFk1rHgxeVnSZyUbYFF78BO2tPNxG3m6NnOQnQzrCzHHMcTxxr0g+yf9fFIDb2NZJambZWjY7p2z/Iw612mxYg6TkAEYMA4KlRg0txJluaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776073498; c=relaxed/simple;
	bh=4X5FFJkqwA0SoyxfoAdrw76Qn9bVTIvvn1WYMP+xFt8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ft5mk+5GQ71P/J8B6iWycEI5SLTDLY6RB+7RkXUnJj2judyQe5hnfIh0HizF2yUMaBspi1A4DGhkHOPkpXf/olE/FsGNGwxzroU5AQ1iY+6rVQtvRIKcbKesL00K+D+5raZdvjvExbyjxPiQqtpkbfZKZf5BCsFmbKbYGSU3N1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p6L0o48D; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p6L0o48D"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3585ec417f6so1545549a91.1
        for <linux-iio@vger.kernel.org>; Mon, 13 Apr 2026 02:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776073496; x=1776678296; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KCR4GSndquhEVcqcGjFQl1C3tjAubrB1+n8j89zlL3c=;
        b=p6L0o48DWKieUUpAXfPzdlkdr2buimLKAoXDI6SUKIEeAELSqj13ipQrqeF8hFqFSG
         fW7WTSDOD0e02L4LvQz/fgw+PrMM0qwRhLTQJZnxe+yomP7cO0gkTUDo830awz8EdqLr
         CTRCPL/tS6hrIPGpnOvqWMAGedikeyAcjRw0r8oHGRZ6vHYi+m2rZZjw7SV0+/wZe+oz
         Eh1doMrEf9DZTHm38ySI8ZafbGgB+rguFOGKJsjYznYRfsPgjz5oqJwJ/QDLMlBviTVB
         RbxoGvPlhPl5kvY69RFEi8I0BR7IkMjWR+ZfUF1AA1LHaFaWBrZFc/8i7uL0eMIeMIRa
         IaDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776073496; x=1776678296;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KCR4GSndquhEVcqcGjFQl1C3tjAubrB1+n8j89zlL3c=;
        b=YgsewEf2JNK8pCxRlnFT50Ar1L1q9ss6tQ5tPYtRkIAd4TUuLrKrhvvFwmhN7CTEdl
         Vc2PeEe9SCYfuKgxb4DJj+PTxKjeVgO4WLYUWrwt+CcNf2pf/8wDy59AoGq6kFioLltx
         4RfUsPoptFJiYLbHmRi3WpOtKQVjfNT+pNMSowuj5TPh2C74Ic1XxNIKFHGfZbKgkX+w
         eMNhRb3/VC2WptJ4/RP7p5Zsuxrs3cd9oBl30Lf7/Cc3PIkWA69vv09a4zNox1O7bcvV
         VyWWshDTqO0on9RybVLr1OivGKJ5yqyaVJA/L/To4eJjHXrmMcbFsbrw4wLtAam544Z7
         VJAA==
X-Gm-Message-State: AOJu0Ywl5FQj3qpSFcTaCeBAO9SRVvJ9OpPD9R82+EMeItH0nlW6kQXa
	D8751RJZIm7zRpOjmnnlLjQc54tUEN/lJtXnB2TW9f8JQJP/GOLqTRtvBtb8WAA=
X-Gm-Gg: AeBDiev3xAKR1l22UBj6Hzl0M90Aksln/JlZSkwKI+4U/LIVI9qQqvGi6xjI+TM7wGJ
	npDQNWeyRwZft0hTc5Rk90qXt84C9CcTfP3eZ90bzMwa+8Ly+Nfze1RtobsfQjiKnMt9wPeXIGY
	VNKbcQoLmUOoL5IkeiAYsUDYeKaiBrZHwqz2quhFbznUexSzhgYWLUTAQyd5CLt1lkee3mvud6x
	bHmDJaiMCbLxFwOWkzrAIqarwDV4AVjAOsijyYWJUnWzofMkbge2XGHLLw5SWwbH50ZZBkowL+r
	drKrIgDihF0GIxgCOt1mXrvJSpOru72q0TcqfCGds92gNdGi/z7MKojQhBN7hIQDee9xi43xnqw
	vYg1a/M2MCrmbVYHVyEU3B3kvK9axVN/uZrxsfHiJNxQNo4E4ta0W8gb+O3mqTRJLsbvTwVOM2R
	RlolG1+YK6uv/lPyE9yqgysDTNBAf4gcWuymmcqMwx+qb/+JD2U4To8jWOvkcHp7QUVZAQcfTf8
	97VxKc1dvPyIcOe+WSaAtmXr2+HCGdskX2RWdTuYkE9YCozrJHzIIaF
X-Received: by 2002:a17:90b:538c:b0:35b:939c:e859 with SMTP id 98e67ed59e1d1-35e354415eemr16025115a91.12.1776073496456;
        Mon, 13 Apr 2026 02:44:56 -0700 (PDT)
Received: from nik.wlan.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35e42db1b51sm4832562a91.3.2026.04.13.02.44.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 02:44:55 -0700 (PDT)
From: Nikhil Gautam <nikhilgtr@gmail.com>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	dlechner@baylibre.com,
	Nikhil Gautam <nikhilgtr@gmail.com>
Subject: [PATCH v4 0/3] iio: dac: mcp4821: add gain support and fix scale handling
Date: Mon, 13 Apr 2026 15:14:46 +0530
Message-ID: <20260413094449.18837-1-nikhilgtr@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This series updates the MCP4821 DAC driver to support configurable gain
and ensures scale handling follows the IIO ABI.

Patch 1 fixes a spelling issue in an enum name.
Patch 2 performs a small refactor to simplify state handling.
Patch 3 adds configurable gain support and corrects scale handling.

The scale is exposed via IIO_CHAN_INFO_SCALE and reflects the selected
gain. The implementation uses IIO_VAL_FRACTIONAL_LOG2 and ensures that
scale_available matches scale. Writes to the scale attribute are validated
and only supported values are accepted.

Changes in v4:
- Split changes into separate patches as suggested
- Fix scale handling to comply with IIO ABI
- Ensure scale_available matches scale
- Handle sysfs write inputs correctly
- Reject invalid scale values

Changes in v3:
- Restore NULL check in indio_dev allocation

Changes in v2:
- Use IIO_CHAN_INFO_SCALE instead of CALIBSCALE
- Fix error handling and cleanup

Nikhil Gautam (3):
  iio: dac: mcp4821: fix spelling mistake in enum name
  iio: dac: mcp4821: move state initialization outside switch
  iio: dac: mcp4821: add configurable gain and fix scale handling

 drivers/iio/dac/mcp4821.c | 107 ++++++++++++++++++++++++++++++--------
 1 file changed, 85 insertions(+), 22 deletions(-)

-- 
2.43.0

