Received: from out162-62-58-211.mail.qq.com (out162-62-58-211.mail.qq.com [162.62.58.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BEC730E0D5;
	Tue,  5 May 2026 09:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777973006; cv=none; b=j2wYREj+dNi2lwp/VG3An2LeHi06PZ0+MlmAGuVABHnF6mX4XcsGj96NfA8WDhgU7hz2vj8amScKaXIbhLnOiOI/Z7f9BoJxYoDLhWKcWF/NboxI5t3ZgOchPcclCjjANnGWidw4/xMpTiEyxrH0TR/e2pJK8PKiMhorLwPQ8hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777973006; c=relaxed/simple;
	bh=cUYmbeRkiKG0PTmo4dL9o+CYH9X/iMFGAv2SR+VYGrU=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version:Content-Type; b=FH3xYa3E9BCZV+cNTuszTDIqqe7UeV9DzLuQ34AIVcUL2zWEqkFb5eyrIlMvWvhChDYouw2S5DcWhncIbtmt1C/YKdmD6g0hhu209ui+reOpeBTMQRYZwP2b8NomVBPSi0eVBRIcYi2UpQBX0ehctQNIZyZC22kR0myMbJ0omB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=FxUKzheA; arc=none smtp.client-ip=162.62.58.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="FxUKzheA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1777972972; bh=tSP9epVHVJEwF7d0mIGp91CJqVn/yc2mmYoyU5oZG2w=;
	h=From:To:Cc:Subject:Date;
	b=FxUKzheAW+kQslZbi5GBzJPQN6typCPpKoCR3QjRunXAkaDGT98XLHnak9bS7qzLy
	 4MmmQNAgGrvMUiE98Ti5emurqK9wnxIGLgIkbyYacPxGvqA6RhyjvYll0Ye2PCJvCc
	 lflJE89TGlgOKuC4ztGWJAc1l+0GqNrDw84uQbx0=
Received: from qq.com ([223.88.152.183])
	by newxmesmtplogicsvrszb51-0.qq.com (NewEsmtp) with SMTP
	id 5B033067; Tue, 05 May 2026 17:22:48 +0800
X-QQ-mid: xmsmtpt1777972968tqac7987b
Message-ID: <tencent_96704F824670A593EC348F183D5C5AAC5C0A@qq.com>
X-QQ-XMAILINFO: NaMvLgwjnAy79wcKFyDdhvb1EQXzAulPrwHYwV0Ij/jzZeFdwL9o6F7UXZVtCe
	 uYI4ckFL//Hq7OmiJvW+VpjksxfBkXQpYAOtlYjDUFD4asl9EueWXD5qiBDXjVTAN3vTnVqQOZ7L
	 45qi4wxd/jOW3QEK9Kz13nisHaf3buQo6wW9/7R7EXxeZiRJ/GRhvFEIBAdC3daFj2zVY/K4FSHd
	 IO/1/UndkmkYVbEtnmS814gzBrWiMQ2YgNJKr9grWe4+9RIkFNla9vlcWlqWFeIzjlDjmBnHj0ut
	 oUZT9fgVVW+pyclzsO29W78wdNibaIgNcCSEZGkTwhfggIHAlYzHJxSXMnqCBWMfdsXyW7XcyHsN
	 AzxV43/eU3XcPRgNGOHTrFJ5FR0eL478g7ubeke1gfujmOnKJBD57m1TBy5iMWT0ggXitkkp+yi6
	 bIh4tTP3PhkJDNeFouX0nrkDB9u5I1jAdxqSJQoYowTytBDThtT/XBd9vVYszax0EntvTaQDhweR
	 ZvUbvT9gNAdGewDgiAjfq5nQCuLYvh0Tn5xFDjN1VmIGTn0ml8ONCAydfYIkmcGIaafpVTwx479P
	 UTssqBX3FQ9qS7HAleiHhe7XIm3IPTlEPGdlbSWql0ydvwRXRxI35qtnFE/1d9Y6xMPn0cB1NHq+
	 s/Xcz9XG5Hk5FxKSFlRIEtK+wzXDyoBaFcxaX8fQoXbSs4xcVpl8SYzN7HsEwkS2pUZLfvgMN3Tr
	 Lfb+lNmSUS8zJJf7OfXQUlIb7S4N+54eeqWufcNozGsNQpe2gGuIxH4FQ0G9zBc0DXTQuIfRZoT7
	 BLhHDrDDIFf9UkCt/p+o0QDNZmB+qJut8BbPKGkM3VT/AHjvwtXcSWscSeJBunLRQfa+XI3CsjOE
	 5VGo81DlXF3HpBi4AhGyy/qoRwuWJPmBFVQUY3hvWriri7SN/O5zP3y4FO1WO40hK2sipjX/Lkzp
	 +xCDm28gwwd2TnMGLWDBIc5jsU/StbsJKD7dpbikzLbc/lUF6NhtuR2Up2GtIIwtLaA35NBpgibL
	 OWFlu3ads5coNjgn3Q9A6qfiwokkJtvn/W6pvzJs6kuJhJ8z+VzYQwdmipwrktohNK/mrsklaUfX
	 q7KbOtYjZwzYFdABE=
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
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
Subject: [PATCH v4] iio: adxl313: fix typos in documentation
Date: Tue,  5 May 2026 17:22:43 +0800
X-OQ-MSGID: <20260505092244.862748-1-jiyu03@qq.com>
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

Wrap long line as suggested by Andy Shevchenko.

Signed-off-by: Wang Zihan <jiyu03@qq.com>

---
Changes in v4:
- Wrapped long line per Andy Shevchenko's suggestion

Changes in v3:
- Reworded "a single type of channels" to "multiple channels of a single type"
  per Jonathan Cameron's suggestion
- Split into two sentences for better readability
- Added this changelog as requested

Changes in v2:
- Fixed subject line format (was incorrectly [PATCH 1/4])
---
 Documentation/iio/adxl313.rst | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/iio/adxl313.rst b/Documentation/iio/adxl313.rst
index 966e72c0109a..cc0829be0447 100644
--- a/Documentation/iio/adxl313.rst
+++ b/Documentation/iio/adxl313.rst
@@ -11,7 +11,7 @@ This driver supports Analog Device's ADXL313 on SPI/I2C bus.
 
 * `ADXL313 <https://www.analog.com/ADXL313>`_
 
-The ADXL313is a low noise density, low power, 3-axis accelerometer with
+The ADXL313 is a low noise density, low power, 3-axis accelerometer with
 selectable measurement ranges. The ADXL313 supports the ±0.5 g, ±1 g, ±2 g and
 ±4 g ranges.
 
@@ -112,9 +112,9 @@ apply the following formula:
 Where _offset and _scale are device attributes. If no _offset attribute is
 present, simply assume its value is 0.
 
-The ADXL313 driver offers data for a single types of channels, the table below
-shows the measurement units for the processed value, which are defined by the
-IIO framework:
+The ADXL313 driver offers data for multiple channels of a single type.
+The table below shows the measurement units for the processed value,
+which are defined by the IIO framework:
 
 +-------------------------------------+---------------------------+
 | Channel type                        | Measurement unit          |
-- 
2.54.0

