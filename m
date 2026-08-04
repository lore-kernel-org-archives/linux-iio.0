Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2F344C67B
	for <linux-iio@vger.kernel.org>; Tue,  4 Aug 2026 17:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785863163; cv=none; b=AqKyy55wyrvMsehASLknaKe9yERPEYwQkBoDVH+/jcEGxKmBj5nzeVKjctEjpSvfn/fWv5Vecv4NMXGhlzyZkonr4joGDku6N5T3XYNTshCDlCTpKVLgP6H4K0KlIW+5orYqJQk1DbKlFZ+BboubgiXmjRQMBYsJ4goXkMPtjZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785863163; c=relaxed/simple;
	bh=fNsiQ4H4dUnXgAib4RUCLYEAN1rBwtnvY4VBYKSLsg8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=enPRcH6/v3p6yH8D5rUSPRZf0R9sf2Wf5QFIE1bJcoa+ULTj6jaWWXGTvXhpHtsZJjinX8M36x2xGERSmG0mCV5JGffurl2B1nSAGKG2Qe1UgZBWm+3u5Vp+NqtxZ3ZaKWs4SeQyouruAf9Ejkk/BIGvQ5u/4R3sdZZkH1bjXKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CMy7E6xB; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CMy7E6xB"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-38f0f132f56so996722a91.0
        for <linux-iio@vger.kernel.org>; Tue, 04 Aug 2026 10:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785863149; x=1786467949; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=LksaQirVyyRYvWZqZp8juYzuZLaLOR8yizwcni9laKI=;
        b=CMy7E6xBOO1aQYEE8K5DYgIp5o/R4VufjYy66Dqx6gXNSvFa19KNSRCDRA1gDebXts
         oFzQBesyfXBAxikV0nelQk8f5zw/J5ZToA2bvHl5QoBgKCMYPJZauL/xzJBOJxnCq5Wd
         l7PiASSFQrOgsOQcirgw7kIBaLGQvaiHb4czycw60bNcM3Oy/ssSZnKBv9Nm42bIU85f
         U48N7XvH0Bp47uBuitftte7R/Be9c4iej5JTK7wuXtNNSQhrFaHJi9OLCA8q+9c/Xe7t
         gIO0uf1HveC8ceHqBcOev0MznJDl26blyNXhhYwO1DZD93JmneC6TCPZdmaZs1EhSO0p
         V02Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785863149; x=1786467949;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LksaQirVyyRYvWZqZp8juYzuZLaLOR8yizwcni9laKI=;
        b=FUPkVD281lMe1zVOzakGiWAKiwb0+v8m+f8kkv9kk+FpEks+m77q3eTJMgWE/RV+7G
         1bRMkO9PMo/vY1YBDsCH0BmyZ/O6Mc7X1G4TiImVi/zfUJs3yjFHUftXZ8PnZqOS4azv
         rdvEx+uThHB7OdBixusL3Fe2+yFIzcMeAH9YzPfP7xFiDOiR462mr317U33+ZqoEk8/S
         OJDKj7QEfLQDkX5rJBCLCWglqqacrblzPq/5VTaS9sM3D1axHztup+cbfKkZw5IpW5xi
         VF+2rrHFN+JqIctuUd6cAXDIsiqFv7oKwxdHsNaepE0MAMkNyw4Y06o3mMQnPP+XnBUZ
         UJDg==
X-Forwarded-Encrypted: i=1; AHgh+RpOnfqr3uYWSKBIh+v0+Mn5K2xJbSVKvJyYAyhXU0ep85Cn1skUqSv54stvsMmqsp9HaMb72NVWl7g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJOdeizR4yK3Ca0MNsFlylqEj5mhc9QYaWHzJNK7ZXoUTyEu+C
	j296B4vp/lwGcPJKdV9FCHnNibMZnpQDn9xxwGPbzXS9H+QwoA7WKfR9
X-Gm-Gg: AR+sD13HqaovulM0kiDdye0qP3xj1EmDso8t8j7S4qaAkNKg3eP38EsFUjIir+eZf+k
	IBCwTeAnD5YJPwgUXIO4qfVC0tKBGP5xh5kHXRc71PBrUmQzYPbAgKZDJTZQBXsfBIJIW/VrfWM
	D4ljNmwKXcUJhE2E0kNzfELKkPQjwpXsmGyrMIPYx7MjCG+W4FekBo8GtpIs9Frn+XatlSvEJY9
	lM7l0KVxldJUEhHHapJlTy+BxiuHCDDH6mPGXe6xET+W661vcMKBUo3vVR4IMkxPKWKZ6MNaFrR
	mPvbFgeMsa4MBvs259R5qQJT3zDUoDJBFUDMElxkSmL7fxAnBY8BgKiv8S/9v6BU1cmpu9jmmAa
	cPazFgS9D/t0DiRmd9az4EWtVlniQxklB1k3UcSXbLlgvqMf4kKq0NCYGrea0VMa3Vofm2E2mxT
	qD4uNzBl9RqjJHiTUfT8uGtj5LBuk5fmY1LhX4kAf6YyxKzIy2eDzwfO90TBo=
X-Received: by 2002:a05:6a20:9392:b0:3c3:75c5:48d5 with SMTP id adf61e73a8af0-3cb6c7536cdmr5854873637.4.1785863149251;
        Tue, 04 Aug 2026 10:05:49 -0700 (PDT)
Received: from ubuntu.. ([2405:201:8026:213e:1461:a94d:d559:948d])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31586162e80sm7230582eec.0.2026.08.04.10.05.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 10:05:48 -0700 (PDT)
From: mdshahid03@gmail.com
To: Jonathan Cameron <jic23@kernel.org>
Cc: Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Markus Elfring <Markus.Elfring@web.de>,
	Joshua Crofts <joshua.crofts1@gmail.com>,
	linux-iio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Mohammad Shahid <mdshahid03@gmail.com>
Subject: [PATCH v5 0/3] iio: adc: bcm_iproc_adc: Simplify probe error handling
Date: Tue,  4 Aug 2026 22:35:18 +0530
Message-ID: <20260804170521.196393-1-mdshahid03@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mohammad Shahid <mdshahid03@gmail.com>

This series simplifies probe error handling in bcm_iproc_adc.

Patch 1 removes redundant probe error messages after
devm_request_threaded_irq(), where the helper already reports the error.

Patch 2 introduces a local device pointer to reduce repetition and
prepare for subsequent error handling cleanup.

Patch 3 converts immediate-return probe error paths to dev_err_probe()
while leaving cleanup paths unchanged.

Changes in v5:
- Keep Patch 2 focused on introducing a local device pointer with
  minimal code churn.
- Convert only immediate-return probe error paths in Patch 3.
- Leave cleanup (goto) error paths unchanged as suggested during
  review. Those will be converted separately together with the planned
  devm-managed cleanup using devm_add_action_or_reset().
- Improve line wrapping and formatting based on review comments.

---
Mohammad Shahid (3):
  iio: adc: bcm_iproc_adc: Remove redundant probe error messages
  iio: adc: bcm_iproc_adc: Introduce local device pointer
  iio: adc: bcm_iproc_adc: Convert probe error handling to
    dev_err_probe()

 drivers/iio/adc/bcm_iproc_adc.c | 48 +++++++++++++--------------------
 1 file changed, 18 insertions(+), 30 deletions(-)

-- 
2.43.0

