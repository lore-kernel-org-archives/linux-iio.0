Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51DE133260F
	for <linux-iio@vger.kernel.org>; Mon, 16 Mar 2026 17:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773682071; cv=none; b=Ge/wpkFMox+9lfe7ZidqW9h32SqHdyofkPL9pd9ZdBUvyAvIJlrQBPSwbr7keurSsI9Xp+veyvGDV++3R98wVmkVLLAV5VF6OHffh3wiqNzOS6Be47SW/OQyqXNMuoG3Rrl/9JD9i6qO+o0l3fRN5n0/gFvlwgztOOuA+T+HfGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773682071; c=relaxed/simple;
	bh=UH3kb4gt0+9ZpweWT40BehwDYP5y+PKMX0nK5W8Jvnw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZeNeEfieeM/Ea8jI23teOe7BGL89TqRRMAlTtL7p5Tj5lnN7su/9L8iKKLMFd1xWI26Gl06uTDulq1QwU+QVni0cy9wbcrl+9kvYoGxDcuNo2DU3ImNJf0yJNHvRALA48hszHhfgtjI6OLwPsuEeI5yP0i0aTYzQQjbB7F1cayQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C2uYT0PH; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C2uYT0PH"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-82a15b44c3cso1856644b3a.0
        for <linux-iio@vger.kernel.org>; Mon, 16 Mar 2026 10:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773682070; x=1774286870; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+5vDax/ZtqQf5s3e6+BhsYeXroKNvJZuzGVQzpGYaig=;
        b=C2uYT0PH9ErItzUtrxuXkyKbGZwhk/b9icHSe16sjHqGUmu513fTW8pSJyvX2+kuqH
         j1X8xvGv1gZ6JmTsoRzLkII/6Ms4Qbc4YMxYPD5ct60Ed4HGiItNDCaMZfWcpg5HOAs2
         uMjTc79Bjt4XWfUOcJCA1Wet3JR07VZMwYvYrHvA51ud3EzqQYgb3FiIesnN5DfhI9sc
         iFq2K90RPr8xxtg24mRw7+j3EMsMlNVn7MqANa4GlMvKeUjIerdAoWd13nDW1UsiE3qJ
         QEBVSEM9VGbJpMm6+iBjHZC6jxlMLnvvGSPlE/QtqcI1lyBCU4ulXRMXwqzMN5WjTKG8
         5apw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773682070; x=1774286870;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+5vDax/ZtqQf5s3e6+BhsYeXroKNvJZuzGVQzpGYaig=;
        b=KIx1Nr+cYp2/xPxNkQ/J2rDiizN0rP6LeOah5sFCSNil9EqvRjSH1d91GuTQ6rg7I7
         mafBHseeCi6gUvGB/nB/A3aNsqhjXfEpHR2p4CngdTw7QjUG5NxPLuq+f33337eR5Ifp
         8OEUpGr/X/tw77nDfGiVGuU3I2rCTTqotJ35kk5NIPb01p5ugBlh4aTa7JkiNlslxBp2
         /IVw+PP1tZHnOET1KUZXUcndnQfpQo3t1oPnH4r4QgcyMJRhCsInaNSB8NVVZdtYdIbj
         NcNSuMbapCIcQ7ckE4DICNQcAmEJ17cvXzPGKbsfZMUrM8pVEojAc7h9ta8bIA9HLQYG
         nbCQ==
X-Forwarded-Encrypted: i=1; AJvYcCV3/r5Ka5cSRkV3Eny96pC9vGz0m4jjyh3li6Gd5r+ZhcF+deYsZBzDyHNYeYhdLeXRyYpZ0kgxAhw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxx8BD6Hkj82R19XbkY8vsDnilEWZaEPu65rhM35Q3euLr8hQFv
	LNZtIXvYBP1hdbgz54tMc/vTUTneaymIr4ALVP6oEeADUPtsW4TKQJV4
X-Gm-Gg: ATEYQzy6X7yd6T/2pRoltKy0tQAAa5k2UMwRd9FzvsyK+jM8Rn9G/PfRAs2TPMuPzwt
	hygNohcypFZlLpt8s3I+rrSU2DSYO2Syp0CHtbm29MD4+8zpi1eQOH4MY6MzvhoxV+snl15WHH4
	FfUwyzHPV01TbvKT3GdQKNKhARIXRgPzi63TgFTzmIyuazcD08RpDexudKwhJuaTnODkxoNGrS2
	qj7URgfUnIp5Z0pJ446GVWh4aGy5qLBF1g+3oiB+1YHN28S5Z94F76U9f4SqYJOe6a4btPPGq7t
	dHdj99yiEIvI9RH3n6F8nr/rGFfIVzv2Xf9Dw/SVP9G7P5jhQ15eiPAlvDKLPwN9Ti0C4bhYzp4
	yCXaP3ZrrTgJMYS2awWN9RgdVkuKUMoOhm8TRJOi0p4MDmvIHdcaNhFH0NGtOt6maRAo0uXul2F
	087egQSLUIte1kQEaZTK8l2aEgRHKep7bvQN3UurzXvYNsvXSCtT4ELM3xdxVKcCKi/hU6ni6Z3
	TiL
X-Received: by 2002:a05:6a00:198d:b0:829:80d4:ff2d with SMTP id d2e1a72fcca58-82a19851b30mr11879087b3a.28.1773682069504;
        Mon, 16 Mar 2026 10:27:49 -0700 (PDT)
Received: from atharv-HP-Pavilion-x360-2-in-1-Laptop-14-ek1xxx.. ([103.216.213.160])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a07341986sm14016183b3a.32.2026.03.16.10.27.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 10:27:48 -0700 (PDT)
From: Atharv Dubey <atharvd440@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	marcelo.schmitt@analog.com,
	mazziesaccount@gmail.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Atharv Dubey <atharvd440@gmail.com>
Subject: [PATCH 00/11] iio: adc: replace deprecated iio_push_to_buffers_with_timestamp() 
Date: Mon, 16 Mar 2026 22:57:25 +0530
Message-ID: <20260316172735.11430-1-atharvd440@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello ,

The helper iio_push_to_buffers_with_timestamp() is deprecated in the IIO
subsystem. The recommended replacement is
iio_push_to_buffers_with_ts().

This patch series updates multiple ADC drivers to use the newer helper
API. No functional changes are intended; the patches only replace the
deprecated calls and adjust arguments where required.

The goal is to remove usage of the deprecated helper and keep the
drivers aligned with the current IIO buffer interface. 

Regards, 
Atharv  

---
Atharv Dubey (11):
  iio: ad_sigma_delta: replace deprecated
    iio_push_to_buffers_with_timestamp()
  iio: ad7766: replace deprecated iio_push_to_buffers_with_timestamp()
  iio: adc : ads7950 : replace deprecated
    iio_push_to_buffers_with_timestamp()
  iio: adc : cc10001 : replace deprecated
    iio_push_to_buffers_with_timestamp()
  iio: adc : ad7887 : replace deprecated
    iio_push_to_buffers_with_timestamp()
  iio: adc : hx711 : replace deprecated
    iio_push_to_buffers_with_timestamp()
  iio: adc : at91 : replace deprecated
    iio_push_to_buffers_with_timestamp()
  iio: adc : ad799x : replace deprecated
    iio_push_to_buffers_with_timestamp()
  iio: adc : adc161s626 : replace deprecated
    iio_push_to_buffers_with_timestamp()
  iio: adc : mt6360 : replace deprecated
    iio_push_to_buffers_with_timestamp()
  iio: adc : ad7944 : replace deprecated
    iio_push_to_buffers_with_timestamp()

 drivers/iio/adc/ad7766.c         |  4 ++--
 drivers/iio/adc/ad7887.c         |  4 ++--
 drivers/iio/adc/ad7944.c         | 10 ++++++----
 drivers/iio/adc/ad799x.c         |  5 +++--
 drivers/iio/adc/ad_sigma_delta.c |  6 +++---
 drivers/iio/adc/at91_adc.c       |  2 +-
 drivers/iio/adc/cc10001_adc.c    |  3 ++-
 drivers/iio/adc/hx711.c          |  5 +++--
 drivers/iio/adc/mt6360-adc.c     |  2 +-
 drivers/iio/adc/ti-adc161s626.c  |  5 +++--
 drivers/iio/adc/ti-ads7950.c     |  2 +-
 11 files changed, 27 insertions(+), 21 deletions(-)

-- 
2.43.0

