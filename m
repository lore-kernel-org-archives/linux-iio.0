Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A990390212
	for <linux-iio@vger.kernel.org>; Wed, 12 Aug 2026 16:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786553091; cv=none; b=kbNDT8qR5pd3rDJmxUbO90wk0vIy+sJvdQldA2MjQvkiHjf/Nf36YhUcjS8/enf+V7ozfCWX79BOiv8d3rQUp5jITvLXiIpc8xy6TlT0089FC983Z9Tm5atN1D6RdZv6P882vRF1tYnzG6H9xNgaC+r8lX7hwV0sZcawj3WRszY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786553091; c=relaxed/simple;
	bh=OMdEa+eiE2MKqUHH8XXBut0ICYi8AxN+pkOMvV/Vj1o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mzwsZ1wVCVPzpyufBWBeDdFOCzxeK10HdqnXDWSOL91tCwA4zdcGUWT1JVlDONN0WlvSeThfHI32rasx3nAzZ3KxGeuxzU1dyrB1+iLL+9AxbG15vcWQ3qNGggcZaPxLZkYwQlZnibpiBVzmBVFc6kFy3wcK4rdHF2jGEmOyBZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jPBSu4Zd; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jPBSu4Zd"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-c9aea40d799so728286a12.0
        for <linux-iio@vger.kernel.org>; Wed, 12 Aug 2026 09:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786553089; x=1787157889; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=4Vgp03XD4TAR6Veh5Nvw5ei2/BjzAgfusQS5tUaaQiw=;
        b=jPBSu4ZdV0paiTH/RFzLyHIqC1G4HWaoP7EABn3YzjcqfqblqFPd+FABWX4KQBUbJu
         ihzP4AC6/IoD02BEPw/GFCB31z0KJVP8M+WSPMdUXI/ZDIxTQrjSXD/5uhrfnRDXTG9J
         6j7uC8IB+VvXpluaFeKw9uFTv4SvyurwgSfyGbooYTcfg9xwmsg+a440IkG4Ozmp7Y3I
         Ey5/2DezAsFqnYFPctfV4/0kiTsfPpB4U/VBdsn5khzivZZ2q3pPqtoefEyRBScUsPbL
         A5XAakK9dE2+nxiX4ruBWREVexDuqz+8hHqy4ipFIGtQv42gONgq8VsNwQysQ8LWb/mm
         ngIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786553089; x=1787157889;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4Vgp03XD4TAR6Veh5Nvw5ei2/BjzAgfusQS5tUaaQiw=;
        b=CbVkJ7W7O0+HatwwyNWA35mMtqj9HyPKHnZMnkwPwsuK+jr73AQr5s1MZMwUTpVVUs
         n4LMeQ0h08WvqQBixCn2tohfPWHANJeHUa71TrGPyTnDouFM0j2YNKdoZ6TC8rPSuGkQ
         JRdwIhJoNNhsnxEDPOir9RHw7x3qoFDhJfDjYfibURkBUKBhDucNYct51cd87Ip7FezW
         MB4nNpuvy9/zVGN1E3vHOEKeMMppQX4qdht3gQxb0c9IJbROLT/WuhuknSh/uCZXwwK9
         jrLa++6fRpT3DNzhlWOk1aGKhPfB2cL5J5Vu7W8wRfzY5kObcPFBOmTh3HP89ZQ632gp
         YGcg==
X-Forwarded-Encrypted: i=1; AHgh+RrxlF/QLInFI5uI6rXI0ZjG9dd5P0xkDb0VwEsZGb2Ygi38yaoLERETzs2EvQ5fjOJszE2zdvUM840=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNvPb+dhoVkku9H1NeaWE0oMbGxoA0pb8NQHFDw0sSUHp1Lprq
	n0SruEDUYA1JmZFA9ow7K1XqAlC01QIVeCEaAfyV6PBzJ1nYNlhjcfPX
X-Gm-Gg: AR+sD11OTRDsupttnhhWRFQGpyJ4XFu2BInzZb2tI7HjiqE8Pl/hMn1+76e6alP66u6
	d2uqjwzLZ/BqhFcyZGeH2/EqjXkXeGYyvhIBVXyW9a+77hU0EkDpskZc0qacb61OER5niBHSWaf
	Ta9OHUlr6YKxjIO82hKbZLCJ0Wwux5/8HLrM+P76kG/sbJfpEPdJKzG51Cp/yhlod95AiDWc6BQ
	x+JTNOgHEqMdhR8PjkBJKHRuofWjHWI77nHd3AnGWF1z2KeOQvQyNEKpNCV6NQfDtCfj4OePinX
	Z+c2oo8OunqUaOSAMUKpEV3fQKrIEXsjG7ynEFLnVNfRYUu6p3fbB6Liywhc/VxVkahPy3HKReN
	jJtfZYtix/RypIrd0E0cVF4pkszD6h5nbXHaauDoxSsTDBSTpFxiWo+EDwumnP5KeG+CZSFPw6F
	rPOqWsUgNNGa2hIGH2Z8YXoIyujATwIE1Ww9rly6b4QsO0jWgseunvST/6g4KoCAaJJeKZl+0O5
	T0xZb8wstH2G7XL3AFnTI9c4uuFIeJWjsI=
X-Received: by 2002:a05:6a20:729c:b0:3bf:6d96:ac40 with SMTP id adf61e73a8af0-3cc3f5d3760mr7260641637.12.1786553089218;
        Wed, 12 Aug 2026 09:44:49 -0700 (PDT)
Received: from debian.ari ([47.30.26.35])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31cf40f7151sm12462621eec.12.2026.08.12.09.44.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 09:44:48 -0700 (PDT)
From: Archit Anant <architanant5@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	andy@kernel.org,
	nuno.sa@analog.com,
	u.kleine-koenig@baylibre.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Archit Anant <architanant5@gmail.com>
Subject: [PATCH v3 0/8] iio: adc: ti-ads1015: modernize resource management
Date: Wed, 12 Aug 2026 22:14:25 +0530
Message-Id: <20260812164433.23011-1-architanant5@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series modernizes the ti-ads1015 by transitioning it
to a fully devm_ architecture.

By moving resource allocation, device registration, and runtime power
management to the devm_ infrastructure, the teardown sequence is now
guaranteed to execute safely in the reverse order of initialization.
This allows for the complete removal of the ads1015_remove() function,
eliminating boilerplate code and reducing the risk of future resource
leaks.

Also the driver's configuration logic has been updated to use
the modern FIELD_PREP() and FIELD_GET() macros, allowing the removal
of all custom _SHIFT macros and a redundant helper function.

Additionally, housekeeping patches are included to ensure header
includes remain alphabetically sorted, dev_err_probe() is used
consistently, and PM macros are updated to modern standards.

Changes in v3:
- Added Patch 7 to replace all custom _SHIFT macros with FIELD_PREP
  and FIELD_GET as requested by Jonathan Cameron.
- Added Patch 8 to inline ads1015_set_conv_mode() directly at call
  sites, allowing for the removal of the final _SHIFT macro.

Changes in v2:
- Split the monolithic v1 patch into a 6-patch series to isolate
  housekeeping, bug fixes, and API modernizations for easier review
  and backporting.
- Patch 1: Added to modernize PM ops and remove #ifdef CONFIG_PM.
- Patch 2: Added to fix a pre-existing PM leak on probe failure
  identified by Jonathan Cameron.
- Patch 3: Extracted header sorting into a prerequisite patch.
- Patch 4 & 5: Extracted the introduction of the local 'dev' pointer
  and dev_err_probe() conversions, suggested by Jonathan Cameron.
- Patch 6: Now contains only the devm_ conversions and the removal
  of ads1015_remove().

Archit Anant (8):
  iio: adc: ti-ads1015: use DEFINE_RUNTIME_DEV_PM_OPS()
  iio: adc: ti-ads1015: fix PM leak on probe failure
  iio: adc: ti-ads1015: sort headers alphabetically
  iio: adc: ti-ads1015: use local device pointer in probe
  iio: adc: ti-ads1015: use dev_err_probe() for error handling
  iio: adc: ti-ads1015: convert to fully managed resources
  iio: adc: ti-ads1015: replace custom shift macros with FIELD_PREP/GET
  iio: adc: ti-ads1015: inline ads1015_set_conv_mode()

 drivers/iio/adc/ti-ads1015.c | 176 ++++++++++++++++-------------------
 1 file changed, 81 insertions(+), 95 deletions(-)

-- 
2.39.5

