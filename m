Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D694B338907
	for <linux-iio@vger.kernel.org>; Tue, 10 Feb 2026 23:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770766792; cv=none; b=UVuFXWsIoiYjDeXZtKXth08af6P891l6F+G7nrdGBg6ftkxiFMdw1CL5fPaMDCbAAPtV1uvHxcN5qaoZqJqomGteSsICG3HVkSLTZYJ+K6GihQcey2UleBT2fJjStk9Ff6r/rdFeZyZdGM4602FvfTkRnEQkWycA0MvDIGildfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770766792; c=relaxed/simple;
	bh=alcTba3NNgp3uAOB7INWl5RVhtuv+nSX/0a3jNB7mD0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P5JEnWJ1zc/6QHTeZkpecL9mc6LZHRapYOvPcUfL/JIgBnUIiIYgj4d0+sUgfEp9hu31tJtywPCdGDB3zn7M8Oq1t8Pz4i/2F/53lk9KzdEoJVUi3erTzoA20mcGXMHo9xapS8Y6c/qVSgJOkeucJshGDswbR9v+Q3aNzud2SAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gUWEXcL2; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gUWEXcL2"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-89549b2f538so29310046d6.2
        for <linux-iio@vger.kernel.org>; Tue, 10 Feb 2026 15:39:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770766790; x=1771371590; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mXEjlJzkw45hYyDsHBkcqrXQ5nKOPOstxOlGehSaFQw=;
        b=gUWEXcL2Ql+imHdSS9fLdUo+UQlCSsvV2nlBCaKse/lDulfK0E2djNipU/XF9eSYFN
         zpjmy4GULsMv82IEaiJ380lt1zHT9JtL6ub7zS8TF+PL+KIeupu5Uf3jkErf3qFtc/VB
         4gf2xzgaAfrf229tlGFuRbQLWO18LV7m4/jmqZbeDAA/VJQ2+byybvkpd+vxCPbtioGY
         nnBSPGJmT1yHDkZ7luGBb+g5uy8xndjqcUDX4dXke+34Npbt1lS8LWcLrw5493uES66D
         9lt+xHzzBTL2L/hn728aNu7/oC0FwB9DW9eRgge18/jlluPaiXfaTuRPNzsAsdwgsJZs
         ezAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770766790; x=1771371590;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mXEjlJzkw45hYyDsHBkcqrXQ5nKOPOstxOlGehSaFQw=;
        b=TPWJQiR7tXxuIwx2MSguf+woDqXfpP6CTs74WFCgI+iLiKRlf2DsnJyICWMdYZzUwB
         SBYNjPb/sBiBLJYANtzzG+RKTkekGny7RiOFqf+QOlZdohp3VrRbutF6Qvl7KRYuwljl
         BhgRV7INwgHFN4tvglOivECKjPMLeonP84mxyCgPDiZ83zWkPsiSEnKj008VVMc3s8xS
         eiTWRyfw4omo3kjYI6+Pf5STstlN5XEwiMyFzC7yjx3WA3IsCYoK5F1Rr9O6Uid5NgBS
         bTN0KU2sZbV3w/Z7bMpalXJn6kwucibkAFreAGn25V6wlFlsOSJ/gPngr893sB2jTvsd
         Y5Nw==
X-Forwarded-Encrypted: i=1; AJvYcCWWTiebGABB2Yu2SUKKpiEyGkdGJwD4L6m44TKfuvkwh+X7u71jL3mI/Ntz2IMeL8P1otlg6Dz/B2k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHbb1us5SxUV2aHdJSBWHSctH+RBLUaWeuMJB84BCUAQ0Bk+Yl
	8fAUKd31ynkgq5gW997V/NoU5A91lhiZsG1up9dxoWAsX5JtqhhDfDF0DgFuDQ==
X-Gm-Gg: AZuq6aK12t7Et9b1h/kAt5k8tWHJrOAEsUcMQUAriZ9GipbVEm13SRVXS/AFb9wwWTL
	KBm6sYOkG1qoY2hjZ0kmnle1TJBgd9+vyLrKPSLnKHq08fGoNGjpgt/vxQLPQfO+LHXuKKYl3Kh
	EibveOPf/PlFWWAzq7iJANes2MceIFDZNoFTDRQnBFK5t1RszARfCZk5RQo4ShzUDL00NyZvKYR
	V7YdWOe6nxltwfU7gCpVFKDGIQVCf389TNuuF8+qa1h1tns/LP4Kct98oXs+0e6T00/FD6Cg/5N
	dU5NDeuohvzbY4FJ+61KzkYWDS3gaPRYDqUvgJYCFiRWnovLpq8UI1nV59WFj2o+vNaUzEDQwRU
	LMpoPtuV1ZZa+IkUVPx+V1hdr1i4KiXGuMaMgSAnbkciiAWBgk2fSr2SLwUsFdGHJqacwbcEL8c
	ryvN/x9uUxNvSi9C0XFTHsmM2yMGFLotSfFQmdDXG5sw==
X-Received: by 2002:a05:622a:1827:b0:4f1:b9fc:eeda with SMTP id d75a77b69052e-506810af248mr15529241cf.37.1770766789654;
        Tue, 10 Feb 2026 15:39:49 -0800 (PST)
Received: from localhost.localdomain ([50.21.71.60])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50682f13f20sm1850561cf.14.2026.02.10.15.39.48
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 10 Feb 2026 15:39:49 -0800 (PST)
From: Neel Bullywon <neelb2403@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Neel Bullywon <neelb2403@gmail.com>
Subject: [PATCH v6 0/3] iio: magnetometer: bmc150_magn: cleanup and formatting
Date: Tue, 10 Feb 2026 18:39:42 -0500
Message-ID: <20260210233945.40975-1-neelb2403@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series cleans up the bmc150_magn driver in three patches:

1/3: Replace manual mutex lock/unlock with guard()/scoped_guard()
2/3: Replace msleep(5) with fsleep(5 * USEC_PER_MSEC)
3/3: Minor formatting cleanup for initializer lists and indentation

Changes in v6:
- Split fsleep change into its own patch (Andy).
- Use scoped_guard() instead of { guard() } for the IIO_CHAN_INFO_RAW
  case block in read_raw (Andy).
- Use 5 * USEC_PER_MSEC instead of 5000 for fsleep (Andy).
- Restyle bmc150_magn_samp_freq_table to group four entries per line
  with index comments (Andy).
- Remove trailing comma from scan_masks terminator (Andy).

Changes in v5:
- Split into two patches: functional and formatting (Jonathan).
- Use fsleep() instead of usleep_range() (Jonathan).
- Use scoped_guard() for short single-statement scopes (Jonathan).
- Add {} scope for guard() in case blocks (Jonathan).
- Leave trigger_handler unchanged (Jonathan).
- Drop all unnecessary reformatting (Jonathan).

Changes in v4:
- Extend guard() usage to all mutex_lock() instances in the driver.
- Replace msleep(5) with usleep_range(5000, 6000).

Changes in v3:
- Add Reviewed-by tags.

Changes in v2:
- Use guard() for mutex protection in bmc150_magn_data_rdy_trigger_set_state.

Neel Bullywon (3):
  iio: magnetometer: bmc150_magn: use automated cleanup for mutex
  iio: magnetometer: bmc150_magn: replace msleep with fsleep
  iio: magnetometer: bmc150_magn: minor formatting cleanup

 drivers/iio/magnetometer/bmc150_magn.c | 157 ++++++++++---------------
 1 file changed, 64 insertions(+), 93 deletions(-)


base-commit: e7aa57247700733e52a8e2e4dee6a52c2a76de02
-- 
2.44.0

