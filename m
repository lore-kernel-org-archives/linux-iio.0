Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F59394785
	for <linux-iio@vger.kernel.org>; Sat, 22 Aug 2026 08:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787385827; cv=none; b=Hz8vBy7GeHMBpV6Z3gi8TLT6+Ug7iMguy1b+U3C2Th2hFQL/GqxKnbRbDjN2QG7CbS8UxIi+66FyZlLEDPNo5t99pKgAijRWaQqrEEob+ay7S0M/kU4Y+iRSF1s/kiz/vl3IExgqlIPsmOt/xhbFOQObp88FLRUcxWzHNXYVuNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787385827; c=relaxed/simple;
	bh=rpG/VCz3E0fiiiUyJ53C0DQzWb4f1hZI71QZqg4Rp+c=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Lvj1uvYDqBE81ssScEkUUsuhBiio60VxEpIpulpIzB6Ty+4OWck9UtRLDAcY6xS1aCup4scymtMbpyj5/CH+8p7+ktt2bpDcJ0g/Q57v3bOmG2E6lVzkLaOTXMXoE1seV5fc+ZDmQTT5xdL0iDAw7eQcaGiwwnz//wtalUQkXBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cgxMj8Lj; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cgxMj8Lj"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6a18e24ad25so2513342a12.1
        for <linux-iio@vger.kernel.org>; Sat, 22 Aug 2026 01:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787385824; x=1787990624; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=m4OSEQMVmZRwbqfSd4mt+vl3RCQf7bz0Q1vJp1AMZzY=;
        b=cgxMj8LjcaemIwiv7Z/n1+pSQZcLXhoxq/EsCxNiAICTamOz8fw2JO/yhhdzhwISM2
         jHi4i99D+dVq2qGAgmixSxHqP4LwwwZIlW4+9mrme6HjZEfuXsdh1PqKOma9TZ78HVF4
         SdPNIKqhPt/dJJlO1XzRUVFGzS0FucEOb60CEzD8KPVSu3SITVFHKzBFfJ92srUNFUWV
         2yTVa4f3/lkFw0/ZTUoUP9RzrERxHRliXw63inFp4rPo/KkiZ5H7cXgi3tnOTXNi5Xh0
         KUjylVLTWgSUSKa7Lw/K14mR1nYxaZaHy6Wb+dsq8z/4jXDPYBv31SwjKUM7BEQqiogs
         qeZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787385824; x=1787990624;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=m4OSEQMVmZRwbqfSd4mt+vl3RCQf7bz0Q1vJp1AMZzY=;
        b=OxUUQaWFK+ndUL7T6iT4UN2xahLD5xbviaJ0HknnMrX29O9/Ymlqx2Gn5pajzSKcdx
         oE1763A1+K17mtlK0bDPEBen/nAV1KPGEb/+CzWHReZwoyTr9JS4OIw68LklMg1LKhuI
         P6UlKngOClb9SAWCW1dSz/weJ5/TxjKUWM0VKBChi9HCj0Y6CpBei4zYstMyC18JE/gx
         4rAkQDty5uThG6dpYLjFD3TGkYloR5l7g0adQ22/kY0fM7sESH+E02zss+VQWOShusTY
         OOIhIVhoZpuzbU3m/RPVdjy4w1Uz1p6s7L9UksSQ4zgFvoaseWO7orb6AxnNXQVBYcAU
         QFJA==
X-Gm-Message-State: AFuF++mnPGl+7e6pNO2JopMYlYUkDJO0qe6HMgV6P8dFEWd6k6kyWBjL
	VoEDdr+6zb+0RcCEXm9EXYRmwdXtGodpcfKGZBhvJ3f4IitCTSu1Wv22
X-Gm-Gg: AR+sD10OGslagAMfRzDqiaKPzAneozSTCzA9kuH/HFUGt8mXPmHJeiFRQhN3ntS00d5
	uQWEOPhWjbO8L6HMS2RMOJJlwFQGE4JIjQoMDLK9rQA6aGogMj+lnKH2M4q6+7+j5G5I39NHe/o
	K/ClMAQ9k9TlXvyjzUqX7HQ5PcOWzTYPzTI85HE+HxfPOjaXAdQnQyusTAK6dk7o4/XlVtGHjse
	A9Yn1I2TmAQpYY4fQQTOtwo9CpsgjcHrie+5kdCrlO2TS8RGpbFPTCJLoeK0Sp/0od7yTZAjxTw
	c5PkA1prYtMPX6lISQYTYYwnc4pjwG5CzCGUCLwh+yoDgwyqyRGbLhd6VueEqLSwTBoWsc8CThW
	nNutv8aIgH6dRqCGbGAX7cgDoegBJFFewV7RX3rdruiZJG5mMDvjSsrxW5NS6yr/Jq4S9hm0oMw
	BLQATddIFLHNUHF1l1MHpWAfVtnjOkKuOg98LZpzYgOv/oXwIT5P5mKR+lXVXevYTBLkD1jtLN1
	ZIplsWvZhqekuJDoKZ/cjT9hKZ5OB0ikspospF0SNe8Rb+hw+XkMHNEMrMs0spNfNE3vLgTBZTP
	x7nBEb3ApMyo9yYXjWF250A87FVWbqC6/SFgKBfSLfbslPShCJRRPYsNxKD4rQIFwcSUHlRPENe
	1GGwFhqLxmmpDX133wKNwV8/pxbJsoI3TLtc=
X-Received: by 2002:a05:6402:2549:b0:6a3:9e00:8ed2 with SMTP id 4fb4d7f45d1cf-6a582b8eb17mr3670032a12.16.1787385824406;
        Sat, 22 Aug 2026 01:03:44 -0700 (PDT)
Received: from [192.168.1.187] ([2a02:8308:4092:11f0::f9f])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a3feeca188sm11114235a12.6.2026.08.22.01.03.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Aug 2026 01:03:44 -0700 (PDT)
From: Joshua Crofts <joshua.crofts1@gmail.com>
Subject: [PATCH 00/14] iio: temperature: make headers conform to IWYU
Date: Sat, 22 Aug 2026 10:02:27 +0200
Message-Id: <20260822-kernel-header-removal-v1-0-ee31b124be11@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MQQqDMBBG4avIrDuQBDTaq5QuQudXB20sE5CCe
 HeDy2/x3kEFpij0bA4y7Fp0yxX+0dBnTnkCq1RTcKFzffC8wDJWnpEExobvtqeVZWgxih+ixJ5
 q+zOM+r+/r/d5XmDcyG9nAAAA
X-Change-ID: 20260821-kernel-header-removal-d95efd197d78
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Crt Mori <cmo@melexis.com>, 
 Puranjay Mohan <puranjay@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Joshua Crofts <joshua.crofts1@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787385823; l=2017;
 i=joshua.crofts1@gmail.com; s=20260530; h=from:subject:message-id;
 bh=rpG/VCz3E0fiiiUyJ53C0DQzWb4f1hZI71QZqg4Rp+c=;
 b=jjY0dGHHNxo0B+cU14vR9FFcSln4QgC2XNFsZSAbMGAc4NI4apiZIKpECWcw8EFLTW3sTmWVC
 8DAF3/vkQwECsp27YLLODedaX76935o/EhqFWDDXkGld+pYLHBotncs
X-Developer-Key: i=joshua.crofts1@gmail.com; a=ed25519;
 pk=RTDOoVwgeL4oFdASj9U+cxJuIjXuXk73zkjnGOJKbEo=

This series removes any instances of kernel.h in the temperature/
subdirectory and cleans up the headers in order to improve readability
and enforce IYWU instead of relying on transitive dependencies during
the build process.

I had Gemini generate a summary (a bit more verbose) of changed headers
under the --- in each IWYU patch to improve the review process.

This is part of an ongoing effort to remove kernel.h entirely from IIO.

Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
Joshua Crofts (14):
      iio: temperature: iqs620at-temp: separate IIO header from others
      iio: temperature: iqs620at-temp: make headers conform to IWYU
      iio: temperature: ltc2983: reorder headers
      iio: temperature: ltc2983: make headers conform to IWYU
      iio: temperature: mlx90632: sort headers alphabetically
      iio: temperature: mlx90632: make headers conform to IWYU
      iio: temperature: mlx90635: sort headers alphabetically
      iio: temperature: mlx90635: make headers conform to IWYU
      iio: temperature: tmp117: sort headers alphabetically
      iio: temperature: tmp117: make headers conform to IWYU
      iio: temperature: tsys01: reorder headers
      iio: temperature: tsys01: make headers conform to IWYU
      iio: temperature: tsys02d: reorder headers
      iio: temperature: tsys02d: make headers conform to IWYU

 drivers/iio/temperature/iqs620at-temp.c |  9 +++++++--
 drivers/iio/temperature/ltc2983.c       | 13 +++++++++----
 drivers/iio/temperature/mlx90632.c      |  8 ++++++--
 drivers/iio/temperature/mlx90635.c      |  8 ++++++--
 drivers/iio/temperature/tmp117.c        |  8 ++++----
 drivers/iio/temperature/tsys01.c        | 15 +++++++++------
 drivers/iio/temperature/tsys02d.c       | 12 ++++++++----
 7 files changed, 49 insertions(+), 24 deletions(-)
---
base-commit: 350d1fb9204b13c5f95e511e98b8bcb47574d425
change-id: 20260821-kernel-header-removal-d95efd197d78

Best regards,
-- 
Kind regards,
Joshua Crofts

