Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A56E40DFDA;
	Tue,  5 May 2026 01:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.163.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777945777; cv=none; b=VT2RaNduIt3I9n8goyzBlu4GpHoG7jmbiDX/+TXD6a9wD2AO/1pKrLhI564VIOHYuxy/g5XqDPujEo9sMzv/+c5sjkRlMkj9TVBw8v3m55USk+VXBuBbI1sdZthNRyjK0Ia75GEga1JfO19D34/XuRkybjnFewgOR5zwDbz7kGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777945777; c=relaxed/simple;
	bh=jNbH1zk7lf8tGGs927YG8obpAdrvXVvFJJusb6MQ0Tw=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version:Content-Type; b=OXSUZRVRMbpOz2K5/VkUHfQ/qvR2S9FzO+w4xyX/by+L1q5FNnZ8iHW1hJj0qk/y79wlxjPHhZIMxpWjHr69GUyq67AqXC2JDlpf9IdcJcl6FIfCPSmP9F8LKVh3x7UP7AY00DibHedCvH5hq0PycNbuQilHWQ6XYVtvADgviZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=lBCDcUMQ; arc=none smtp.client-ip=43.163.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="lBCDcUMQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1777945765; bh=H2+8c8RNLIACKXU5ZLjGJU3djtP9IEtkUl+PxwNzfzo=;
	h=From:To:Cc:Subject:Date;
	b=lBCDcUMQsz9GDuVO6gKm4mSwmflM1vYSqTtv12uANHXyZp18hGundQBwq6k1dYj05
	 6t16JzSbeP0CnFv/sirSSHBvdipMr9eudL6cYJOkcT1+MB/c96rz9lDVVHqHL5z12/
	 IXchrMZUEZOPslsAP7gbeEh3vvKjxcl/jn0zjj7M=
Received: from qq.com ([223.88.152.183])
	by newxmesmtplogicsvrsza73-0.qq.com (NewEsmtp) with SMTP
	id C549F8A3; Tue, 05 May 2026 09:49:20 +0800
X-QQ-mid: xmsmtpt1777945760tdnrk5i9d
Message-ID: <tencent_5B3B9283E67523E3CBF9150AEE7AD002AE07@qq.com>
X-QQ-XMAILINFO: NGZp1yYNf7Y+gFtepeoSBLscsgnfUXhTOn5dElpoUrYJlx/OmpaLywUrVyM5EI
	 AdDFXXmPHtwBevbWtNiqszDVthrDm6CCADYBE/lNXBCkVMgwJzW2JEndzjOQtSUsdP7kOJMLRUg0
	 8qLm/G7yiNNwobLLxFeitcMYS/b2TfxKzdw8vU3LOn1taIL1TWtAl717lMoNBK27VBSDurNPcAtj
	 0RnjGXU0DKrkVFDzDmGzWrF1zQlO1fjNaJ3Cj0mA1gAsnx2l3H5J5WIHwXLTaKbRqiys87wlfktS
	 ty2QoySPWl/bu/AwH9DIs7drKRmgkYJ7V5ir6D2u2EBnRn/pURaw4OQiTkqIgu72j5E1DbzcHjAp
	 937//NaenghQrefPBIvJEicQyRgtnAQLCXhwdGr7nbtpfUoMos+xov0FQPRS5uGaWcmaNMnHSLtk
	 IXTvHyLX2rtpRgNwo53O7/XIr5KJZ4KwBAS9p2CU6W1kitoSMGokb0Cb+UwgGTdzQAaivgvgvvCh
	 iWbj/FcfKcsmGpG88DzeL7kJBEVopE5udFGIgW1BAXlEjy4F1LG0S5uogNLgfH98jQxrRFM40dqE
	 N/1b1vAtXGPAY9jmI7lVIZCJ4N73+lxLKZqM0JarWaYuYDFdkqaTeahkP7W1kCF7kKW2FEOP/xxF
	 kf0kfRSa4ADvpJ0WVflkZ5kkDIe0YsF+WTIY3qJTQk3qzrmWtRd/d+ZAqXwPAbR1s6gsigm0Ox0x
	 t2LMyTNhh0xH96eoS2IgxNOQjE2vL57Rv6j0XroEZn/GLM5DOXsKGlylmDf6KykVyDQZP5V8kxzR
	 u4pEi+BXv6pYJvrK0lYE24OKXjVP6Ikjul7eCKbJMqHrLY6JxjpiDYMkaXfbDvqduB6GIOeMYS/P
	 0t4eXi9Rw40br4H7YSmsTvl9PwOOXrmHRihXSFvvp5ObEkUDbLE9HP2LAklzUJeyGoBOMgo9VLnG
	 fL61DiXgfKjhd38SXNSE//BC+GHzTTAbgL8dNavT3lFIITY/9d/2Bz7uNTP74MT0cThx0jdA9JK1
	 5ZLoP97i775qV8vIHkcnDMAN6v46cazPdYB3MqrbYN6MiMXX04CoH1zfEJN0C3PB8zZqjhYg==
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
From: Wang Zihan <jiyu03@qq.com>
To: jic23@kernel.org,
	corbet@lwn.net
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	skhan@linuxfoundation.org,
	linux-iio@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wang Zihan <jiyu03@qq.com>
Subject: [PATCH v3] iio: adxl313: fix typos in documentation
Date: Tue,  5 May 2026 09:49:17 +0800
X-OQ-MSGID: <20260505014918.50897-1-jiyu03@qq.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add missing space in "ADXL313is" and improve grammar for
"a single types of channels" to "multiple channels of a single type"
as suggested by Jonathan Cameron.

Signed-off-by: Wang Zihan <jiyu03@qq.com>

---
Changes in v3:
- Reworded "a single type of channels" to "multiple channels of a single type"
  per Jonathan Cameron's suggestion
- Split into two sentences for better readability
- Added this changelog as requested

Changes in v2:
- Fixed subject line format (was incorrectly [PATCH 1/4])
---
 Documentation/iio/adxl313.rst | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/iio/adxl313.rst b/Documentation/iio/adxl313.rst
index 966e72c0109a..a28047e6764c 100644
--- a/Documentation/iio/adxl313.rst
+++ b/Documentation/iio/adxl313.rst
@@ -11,7 +11,7 @@ This driver supports Analog Device's ADXL313 on SPI/I2C bus.
 
 * `ADXL313 <https://www.analog.com/ADXL313>`_
 
-The ADXL313is a low noise density, low power, 3-axis accelerometer with
+The ADXL313 is a low noise density, low power, 3-axis accelerometer with
 selectable measurement ranges. The ADXL313 supports the ±0.5 g, ±1 g, ±2 g and
 ±4 g ranges.
 
@@ -112,8 +112,8 @@ apply the following formula:
 Where _offset and _scale are device attributes. If no _offset attribute is
 present, simply assume its value is 0.
 
-The ADXL313 driver offers data for a single types of channels, the table below
-shows the measurement units for the processed value, which are defined by the
+The ADXL313 driver offers data for multiple channels of a single type.
+The table below shows the measurement units for the processed value, which are defined by the
 IIO framework:
 
 +-------------------------------------+---------------------------+
-- 
2.54.0

