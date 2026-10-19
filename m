Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1882226FDBF
	for <linux-iio@vger.kernel.org>; Mon, 19 Oct 2026 01:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792373155; cv=none; b=idfZFDHB5evWXRjX//upM15adQ9lFCT9lg/fdH9JGC9+DmYhhlrh1nILm8bae/SVNDtOlFnhsjgg3JNGPov1LFjYzHvK5TBqJfbFi/7yCAjLV3+RXc5CkBdK/FnkFjeK9cLez9m+4rcgtMmSMTiUJ229MN0ci8lPW3VfP/ZaPCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792373155; c=relaxed/simple;
	bh=F9/emr7vEfrCscIQuoGwe/cp/5Bx/9AZOgGZ6xMCSCs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nrWAqqDS5iWNAAUTLbk0hs6fLUWhUSjKcflBbbb9uWpTSK3pXTp9fciL1W77aW8y/55/Kn+nE0izWKUNjBt9ERlCbLD5mk+GYwLiVGQ2YYPeHPxZMw3L7o3CyqM/AoJdwW8KXAgJm0YnzhFYceuZtoJ/Fy1c9dCvrmiq5woPJvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E/LUv0dr; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E/LUv0dr"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-8897e83332fso1318406b3a.1
        for <linux-iio@vger.kernel.org>; Sun, 18 Oct 2026 18:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792373153; x=1792977953; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=6DSfuGuXiQE3/PgnWB5NySCEqOJab79pGf9ZzrORjUw=;
        b=E/LUv0drEhvqkHYbI7pw+HEMgSRXXZNWWQfZTdPEggyzrpYj+bJBKLMXczcQf8Gvd+
         ZpwdWfVvh8Eh/9e8eI5LAfeyXj/NgU2poFU0ejbvdi85Pf0CrsCOlbG8j4ppz+pi0ZQ6
         17G4LZoZB4xDR75TDlSVbOM+hRHWKP84xZilIlLH1/SPWnUneqMwis7uVi/w/GIxzdpq
         kHlnQ2Qns0uI8njaqGz/vAvRRw2yqmOc2mYaiIRwzxsG1jTZ6/vzrsGkVYKXcjqtTxik
         3yQ6pCzJx3PCsYRoSSzKUcURjok10+zwA8/1B2WlwAFoyWLOCUCEXTxP2PoMpLdXwYX4
         PJVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792373153; x=1792977953;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6DSfuGuXiQE3/PgnWB5NySCEqOJab79pGf9ZzrORjUw=;
        b=dZ8V1mtUIo3DzbeVp3o5Pbtj4KoDOpLYG1LJjfo7SXR2qYO5Pf998BSaXDh1q7f4P+
         RUHCo7Wg+N4BLEqyakCT8I4jkMtXiqAvOOdLZJtgKtMEkH+KXPkISoO3qF1hQoLBsM+S
         RS38+7YC3s3Pf1GUM3te3WbaHqj46xgpH9UhRQRpoCDsRq+MhDT/rwHpARr44Kq3HTa5
         gtZP5CCMedCLHK6RtluSmtzrPNRD8MH5Ys/sAg2jzvKt203J6viJko9N6rW+PTdm326L
         x6KJLDFjGdzKv5voBr/fnfSiHGuoY9259pmKU3MtBdPEFW9phW9Ki/RY2Ri7Ne8zab+A
         zA5g==
X-Forwarded-Encrypted: i=1; AKwUvBwnMHBfBdYtto9iiRY+BdqJscnq9YOMFGs0dCBT4QRhf3HtEwG9XAZHYLiLquMIBfl1lDzHfXsi45M=@vger.kernel.org
X-Gm-Message-State: AFq9FYKlbV9EaEJRdg2UDWDhWMrtjsAN6h/Pi3c/wD5dm/hZaAUkTJdo
	zzmNfk1/DywY0qPTZeJJ0hpJK/wrrvrYNA9nY1E5F0d20OCjdXjVIEHL
X-Gm-Gg: AYBFou0+6T1muZocFTxscA7sufBZ2lZ66+RhVyyuZK/MoX0XZjGcMKUVFwhO6dD4uil
	rDKafy19cgpr/ojfCfRiQr88CdUTFUOVweKh0CiAIZu6A037pluAE+knC1jPYIm65hA9jjjTOh/
	5nmBad14CkhTEsHoTTCT5wG81C9RS1CFuFec+dwOBWFK3r41z+bG2ku+B5W7hz2FvFM9D6e6msv
	/qVOksBw94xHGWmBndJRbSCCv1KSNUwwXiOszEVtULMWG4KxNLO3uJrhTvqH0tvbB7tRW3tx/Jv
	9P8Y1PTjdQTtOier7gOtapJq9KktbuqMQ/8qzr91pat3mEPl3S0Yp/MdI8LQ5WVhAJjc9jWQN0C
	0xXJJEswyyY/F+cyTgNGHRKzCWy2lYu4wPQyChfcOWGVkVxIfpoApjdUi+dU/BizkMRU3qS+XIn
	/mrpPde1i+CzTyf0+r0kHLUD61Atp/Pz8cixJLQVQ5tN9Mv349jIUdeF9lHW9Hsz/YdDQ7avQYe
	fcLQeBPVSn/VY1YRXuz2Dt6zSCbTDH+U+fgoHIj6jdjKOcPQwjFUeSeAfa4p/WLb+YJGPv/AoNU
	u7pY5hrQcbeKx/WEzA==
X-Received: by 2002:a05:6a00:2355:b0:89f:2b65:2a1 with SMTP id d2e1a72fcca58-8a04b80bd93mr3056691b3a.8.1792373153272;
        Sun, 18 Oct 2026 18:25:53 -0700 (PDT)
Received: from DESKTOP-G3E0OSP.localdomain ([58.224.60.243])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-89fcd67cf30sm2731309b3a.17.2026.10.18.18.25.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 18:25:52 -0700 (PDT)
From: Jinseob Kim <kimjinseob88@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: [PATCH v12 0/2] iio: osf: add KUnit coverage
Date: Mon, 19 Oct 2026 10:24:45 +0900
Message-ID: <cover.1792372045.git.kimjinseob88@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Jonathan asked for the updated KUnit patches, replacing the two pending
v11 test patches. The six v11 production patches are already applied and
are not included again. This KUnit-only v12 maps patch 1/2 to v11 7/8 and
patch 2/2 to v11 8/8. The separately submitted kfifo RAW-cache fix is not
part of this series.

Allow tests in the existing OSF composite when the driver is a module,
without exporting internal symbols or creating a separate test module.
The supported configurations are OSF=y/KUNIT=y/TEST=y,
OSF=m/KUNIT=y/TEST=y and OSF=m/KUNIT=m/TEST=y. Add deferred mutex cleanup
for pending sessions, receive serialization and IIO fixtures, and require
producer/configuration handshakes before checking concurrent state.

The unchanged OSF/test sources previously passed all 16 core and 2 IIO
cases, GCC and Clang W=1 builds, KASAN, lockdep and debug mutex checks.
Actual module load/run/unload validation covered built-in and modular
KUnit. With built-in KUnit, 200 production and 200 test-module reloads
exercised 20,000 buffer toggles; modular KUnit completed 20 of each reload
and 2,000 toggles. Local assertion-abort validation checked seven cleanup
paths. These are reused results for identical sources, not new v12 runs.
Existing upstream compiler warnings are retained in the validation logs.

The immutable signed commits retain the original IIO testing snapshot:
6a27f3a7d1063aec5aa3d9370161e850fc3a85dd
Runtime unregister concurrency validation used that base plus mainline
commit 84bb0fc46ccf6a545b8fdf57cda83770186ed8dd
("iio: buffer: serialize buffer teardown with mode claims"). The fix is
a runtime prerequisite, not a patch in this series.

Current IIO testing, fetched for this preparation, is:
19c5db3507633edc21b4172d99f573c2dfbf42b1
Its rewritten OSF commits have identical patch IDs and OSF source blobs,
and it now contains 84bb0fc46ccf. Both patches apply cleanly there as well
as to the original base, with unchanged OSF/test content. The base-commit
below deliberately identifies the original signed series base; the new
testing application check is not a claim of a fresh kernel runtime run.

Previous patches, now marked superseded in Patchwork:
https://lore.kernel.org/linux-iio/20261011231340.42885-8-kimjinseob88@gmail.com/
https://lore.kernel.org/linux-iio/20261011231340.42885-9-kimjinseob88@gmail.com/

Jonathan's request for updated patches:
https://lore.kernel.org/linux-iio/20261018190454.054d3385@jic23-hlaptop/

Changes since v11:
- Send only the two replacement tests; omit the six applied driver patches.
- Allow the supported composite module configurations with a bool selector.
- Add deferred destruction for pending-session, receive and IIO mutexes.
- Strengthen producer/configuration worker entry synchronization.
- Document the IIO core unregister prerequisite and validation base split.

Jinseob Kim (2):
  iio: osf: add core KUnit tests
  iio: osf: add IIO KUnit tests

 drivers/iio/sensorhubs/osf/Kconfig         |   16 +
 drivers/iio/sensorhubs/osf/Makefile        |    1 +
 drivers/iio/sensorhubs/osf/osf_core_test.c | 1064 ++++++++++++++++++++
 drivers/iio/sensorhubs/osf/osf_iio_test.c  |  395 ++++++++
 4 files changed, 1476 insertions(+)
 create mode 100644 drivers/iio/sensorhubs/osf/osf_core_test.c
 create mode 100644 drivers/iio/sensorhubs/osf/osf_iio_test.c


base-commit: 6a27f3a7d1063aec5aa3d9370161e850fc3a85dd
