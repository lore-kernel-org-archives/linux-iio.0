Received: from rudorff.com (rudorff.com [193.31.26.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C0F3A0B38;
	Sat, 17 Oct 2026 17:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.31.26.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792258098; cv=none; b=k8uC+69wpenWlubDK5NkOsa0dKQSsO04XiRvhDnrmSFGbC/6rVAgSHlQ2Tcs0zyTYj2ClI/T99CQ68OdcM8ABGiu4mEXJaKoRvt4op1eGGhBwlR9snPK/4EJVS8SaVFOGZ3IRANf2LeSa/Gmno7M6vajS9i1zxBoUj7wKSfh5Gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792258098; c=relaxed/simple;
	bh=3fAC80zWUljwZHRVx3+iT3BjnoyfEV6/GLxMwc++P2c=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=N6kjSx2bbUyQsRaj/55+6AIrLq8P7+9iz41jx2L3v6+7Dbv02E2tYUItzTKb9gmPc+jFYwy0GAg09cIm3diSPIYI/KUa+pkNh2FVTBcbUOvPn7uNb0np3j6HbMqkmJd+7NUL077MDE5QX7ZgsdVRF3i4Lq6l5sqvhQl7QzUPho8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rudorff.com; spf=pass smtp.mailfrom=rudorff.com; arc=none smtp.client-ip=193.31.26.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rudorff.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rudorff.com
Received: from [127.0.1.1] (dynamic-002-211-221-196.2.211.pool.telefonica.de [2.211.221.196])
	by rudorff.com (Postfix) with ESMTPSA id 928164035A;
	Sat, 17 Oct 2026 19:28:07 +0200 (CEST)
From: Christoph Rudorff <chris@rudorff.com>
Subject: [PATCH v2 0/3] MSM8916-mainline: improve gp2ap002 proximity sensor
 v2
Date: Sat, 17 Oct 2026 19:27:40 +0200
Message-Id: <20261017-iio-light-gp2ap002-v2-0-d6879767a446@rudorff.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAyw02oC/32Nyw6CMBBFf4XM2jFtEVRW/odh0ccUxiglLRAN4
 d8F3Ls8ybnnzpAoMiWoshkiTZw4dCuoQwa21V1DyG5lUEKVUsgSmQM+uWkHbHqleyEUlsYVRa7
 JmpOBddhH8vzeo/f6x2k0D7LDVtqMltMQ4md/neTm/T2YJAo822ueS+X1xRW3OLoQvT/a8IJ6W
 ZYva4TvFMgAAAA=
X-Change-ID: 20261016-iio-light-gp2ap002-6bd553aecb4b
To: Linus Walleij <linusw@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 Christoph Rudorff <chris@rudorff.com>
X-Mailer: b4 0.16.0

Samsung J5 is equipped with GP2AP002 proximity sensor.
Unfortunally the driver wasn't working, no irq received.

According to datasheet page 8 "Recommended external circuit",
it can have tree supplies: vio, vdd and vled.

It missed to power up the LED.

I found this looking in downstream kernel, where
several #ifdefs handled the case of 2 or 3 supplies.

Now it works. Tested on samsung-j5:

$ cd /sys/bus/iio/devices/iio\:device1
$ echo 1 > events/in_proximity_thresh_either_en

$ iio_event_monitor /dev/iio\:device1

Event: time: 1791460068846871297, type: proximity, channel: 0,
evtype: thresh, direction: rising

Event: time: 1791460068876669724, type: proximity, channel: 0,
evtype: thresh, direction: falling

Signed-off-by: Christoph Rudorff <chris@rudorff.com>
---
Changes in v2:
- reorganized patch serie
- gp2ap002: use regulator bulk framework
- Link to v1: https://patch.msgid.link/20261016-iio-light-gp2ap002-v1-0-7c93312fa8d5@rudorff.com

To: Linus Walleij <linusw@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
To: Nuno Sá <nuno.sa@analog.com>
To: Andy Shevchenko <andy@kernel.org>
To: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Conor Dooley <conor+dt@kernel.org>
To: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-iio@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org

---
Christoph Rudorff (3):
      dt-bindings: iio: light: gp2ap002: add vled
      iio: light: gp2ap002: add led power supply
      arm64: dts: qcom: msm8916-samsung-j5: Add proximity sensor

 .../bindings/iio/light/sharp,gp2ap002.yaml         |   4 +
 .../boot/dts/qcom/msm8916-samsung-j5-common.dtsi   |  15 +++
 arch/arm64/boot/dts/qcom/msm8916-samsung-j5.dts    |  32 +++++++
 drivers/iio/light/gp2ap002.c                       | 101 +++++++++++----------
 4 files changed, 106 insertions(+), 46 deletions(-)
---
base-commit: a2de78ee6ed8bf8cd99d177c74865a6e8c3cb6ea
change-id: 20261016-iio-light-gp2ap002-6bd553aecb4b

Best regards,
--  
Christoph Rudorff <chris@rudorff.com>

