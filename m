Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795551746;
	b=yEFkpAZQE6bq2Z4rlfFIUZIqT9YAhjgwCXOHvjdsqSBs2C4t/trkLKxX5iVdvGIyNDx6
	 77mphpp6zsbRcrwMQ86u57t4WoaO9q3vXzRWHOQfh2dPcXOzRIxGrn+m4zfkoh1SegGF6
	 C3c2FWG7YK0HTWXALd51Z6q7h8hMjCEFK5M8XB0kLQxriGgqZm8/WOn5vLcrjtwQOWExe
	 f4/agco8ZfUOQfRXOXdE8PMggk3oD93470zyL8gVx4+HXuN0c3WolvaSFHaMV28n7rAnW
	 sAV428MkfCWh/tS1fA60rBJxFMi25mJyoIUpka4LmsuaGBZH2rYCWJ5Y4etPQFfVn1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795551746;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=cJ2ObhZVOW9zHYEagygnyL7A/D9me4jEjQcn9wi7PeQ=;
	b=4yJdr94snjLdfMyVOvqAK5AlHrLWlRt9yK7EN0sfpQrUjepfkEfRzknlB/j+w6LdOVF8
	 +gVzelnsQtGNYvhc4Ats88hKNYa78aXYUHrkiD0ZohldNCZMmXBBuYNtJNqDYIOspPw1X
	 KcuS1ALJpsPdy0t3p1PZx3I/pJm32OOi9a8NuKWjrYi1R6phS3Nt4zTpz2fOC6mZQMvMA
	 ErtnNfTwc/ZYZAjTa+jA9rQaLcwo8FMWekBn9HT91D0aIYgqbYilCjhrxQnjVlP0PwQCE
	 l7rObV9jEKGqvlkIERiNmE+6ix+HtBHuBvUCdF5M8Tjziw76uJMBfFr2pjffSiG7AmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=teslabs.com;
	spf=fail smtp.mailfrom=teslabs.com;
	dkim=pass header.d=teslabs-com.20260707.gappssmtp.com header.i=@teslabs-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=JHN0T43f;
	arc=none smtp.remote-ip=209.85.221.41
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B65D4606A321
	for <linux-iio@vger.kernel.org>; Tue, 24 Nov 2026 20:22:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B65D4606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=teslabs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=teslabs.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=teslabs-com.20260707.gappssmtp.com header.i=@teslabs-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=JHN0T43f
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-4a2f4ca0dcfso2867445f8f.1
        for <linux-iio@vger.kernel.org>; Tue, 24 Nov 2026 12:22:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=teslabs-com.20260707.gappssmtp.com; s=20260707; t=1795551744; x=1796156544; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=cJ2ObhZVOW9zHYEagygnyL7A/D9me4jEjQcn9wi7PeQ=;
        b=JHN0T43fKCmLaupHQGh44LzbmwRrXUWZiRbTM+wYyWfbCHysfoZqwPjWqjVjU2OT5A
         4mSO+cfbJz8UnHhIeGDCcShhq6a64FLK5uPzS6rtYtbzVSM55ng7xE5AyQjzqr7aP2uO
         4hELDY1Tz4BFYlnuB8XSQsYrweRZVCvfvEYSv9zLKLIV9MCquzadf2SxElCKsfdl4rhS
         q0w+PwUtgIImfhJg+EL8Gy6Hyq7XkTOHpcdo9y8gZhpvDK3n16hmNzcbIHrvAQQ8mAs8
         GgQcXE+wohPAb3ja7ceUCQZEmpkwKh5uwDvH96bPU+YB9yEjGjzhQWhWesaUCuXdga2N
         TEUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795551744; x=1796156544;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cJ2ObhZVOW9zHYEagygnyL7A/D9me4jEjQcn9wi7PeQ=;
        b=J55GF4iSCQblhJRe0RZJBUBn4mvXFJd9R6LiB7Nyjp1cNdQ1pAluiH+p0pTP9n4g45
         Jy0MS017+yDDijG0v/5QhAzFVZe5ciDFtCEcB4/YcQcOo6KxnG6mNHVkwc0IsMGW+8kw
         fWObRlEP4TUlZsfvLYmfSUw8+CVOtvRp/vbLESTP4dQvQpTViZiXV8OTdik5gzBqVCrm
         EVxEPiI1JNJkREo/8/BpdbIsMGOxN2j+wT0ipNXgAP50eIWj+OBGtOtndthd7vWZGbo5
         KZOZTl+WAZOEstncuFdkp21k2IUzooaAW0/TgTmNsmLwB3wj5nDNqA4P69eQX0l4H54O
         6uXA==
X-Forwarded-Encrypted: i=1; AL+hErF3mJSZ34CGvKO1PDB1kzuiMBjqIBpSVkDEJVbDwYkzlJk/Dmh143+yjtYl4nlDlv9nHMAioJh01DU=@vger.kernel.org
X-Gm-Message-State: APuU4Z+uMPQ1wEqAfRhp5MbdIdf4Kg/PqYlKAjDbbw6o4tIBVq7K9TPM
	ElY54xQAb6TOxsTUgzf85kkknY0QHG6ixOg3fibd/zOcgQypRBk1akMw+EoWd50kvR8=
X-Gm-Gg: AZFdTZffqE/ggcjHCAfWVNsSZFCE1JIfe1Ys0JPG7ZA6K+anqjPeL+FhSIHzKWXBQCo
	agfJN59x+QxImeYgqMnIkHpU6YlkJaskOXwxoZtImDv/mCvN+xoTtsPvocfFeYK94ZAWNfpwWlk
	nRtGHMM/Oa+dQHhdjGNKIBpspOtpRwBWyIV7wmpfhde40gaBxpWeEa6c1uKxNA40G8aZgNa3DZe
	RFTvK/NdSS8PgGZc4YaYAH6V0YBFBqt6mvq/27t6esBuQAeG/Q3/gfAT71PsxQTOTO0YzrXdtgw
	HosRQn3fltWleaAd754xE9DkHDGcDW1euzVqiRowFbFbvxKG/wsafyKgsVYpcFFxbwBIjCYVvTN
	nwc166LmEV5W/8ppd2AdqZtiYIE/7KLnKdyHWMD8gZEbw9O4qZKQDyM+w0QK5OIy0hphrCgP7Jg
	tCBYKJ+p3VU91ibsgMpopIHlf8OecSNsfhFWKzeszLQ3FoiFDK3xrLALbik8VhjShXqeYj2uvom
	l2AOHl6KMs6RGz87REpePhIyQhVoU1njXSTmVXKMldn50wMyOwMK+iqB8avv0rySJxPIxiDl7rV
	GgDZxmbVJIFrTINjlztuOiuOdNhRDMUIZwvMSDdfIdtjLuH6vkKQUBu6PHofu0HJSOKEZq7oxw7
	kxLrWsGAVk/M=
X-Received: by 2002:a05:6000:1841:b0:48e:6f76:de9d with SMTP id ffacd0b85a97d-4abb4c7ac1dmr35270346f8f.46.1795551743608;
        Tue, 24 Nov 2026 12:22:23 -0800 (PST)
Received: from localhost.localdomain ([139.47.121.129])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6a67f204sm35130525f8f.21.2026.11.24.12.22.21
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 24 Nov 2026 12:22:23 -0800 (PST)
From: Gerard Marull-Paretas <gerard@teslabs.com>
To: jic23@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com
Cc: fabrice.gasnier@foss.st.com,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 0/2] iio: adc: stm32: describe the STM32H7 temperature sensor calibration
Date: Tue, 24 Nov 2026 21:22:18 +0100
Message-ID: <20261124202220.23721-1-gerard@teslabs.com>
X-Mailer: git-send-email 2.45.2
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The STM32 ADC binding lets an ADC take the factory calibration of its
internal voltage reference (VREFINT_CAL) as an nvmem cell, but not the
two calibration points of the internal temperature sensor (TS_CAL1 and
TS_CAL2), although the STM32F4 and STM32MP1 device trees already
describe those cells.

This series adds the two temperature sensor calibration cells to the
binding, and describes the factory calibration area of the STM32H7 in
system memory, passing its cells to ADC3, which the temperature sensor
and VREFINT are connected to.

PebbleOS uses these bindings, including the new cells, to describe the
STM32H747 and read its temperature sensor.

Gerard Marull-Paretas (2):
  dt-bindings: iio: adc: st,stm32-adc: add temperature sensor
    calibration cells
  ARM: dts: stm32: add the factory calibration data to stm32h743

 .../bindings/iio/adc/st,stm32-adc.yaml        | 10 +++++++++
 arch/arm/boot/dts/st/stm32h743.dtsi           | 21 +++++++++++++++++++
 2 files changed, 31 insertions(+)


base-commit: 8d7fe9885c62fc9a95bf55d9db244d9672a8aadc
-- 
2.45.2

