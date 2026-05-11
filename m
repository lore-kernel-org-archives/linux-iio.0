Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E845924887E
	for <linux-iio@vger.kernel.org>; Mon, 11 May 2026 17:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778519587; cv=none; b=SbPvkW5XoRxVVnWjHbgA1EKCmrkkpGY0CABUnI9T6Qn+kCAvc97a5Ev7TyJIXvJf3wE5+Yk6YMaZe4V8hUMTQ+ZDOMFbeDIZd6ogaPPZ7PxXoWprUPJAoBQ28ZNbao6a2h6NH9y+sip787FW5Hy6M7MtAjrAmPZE1DVmD1KfRFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778519587; c=relaxed/simple;
	bh=N0B6aeBfvO3+5jUCRXLgc9fs4gJYVndcLiF0eEoluaI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kzn8zp750CnYpTB5ZwesQVZlNgG9VYh3QImlVZmKptFlxaQ6QvXplmygBsIObxW95hd4gIqzcjXhakiy0F+olg9jHbDLPi1G4reNNu+oz6rCMLhhU9pPgQ7vzy+U/cuDJcC239DsYr5UWiNgxmyX47sI8HrHaeQY1Xxy15GlnM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vd7oYNv9; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vd7oYNv9"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-367cbac9c37so1592327a91.2
        for <linux-iio@vger.kernel.org>; Mon, 11 May 2026 10:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778519585; x=1779124385; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dkzJ/hC822piYaCvNo19iUpPViiOD5q0JLp4DMc5nn0=;
        b=Vd7oYNv9q6S6lz4VYEdEzeXW5ZsU2/DHn59381sLq8JB+JE4X5xpPQAmkzxSlaX/3y
         vn6BpyA6X4JxP0axG7byqkw1b794DzeKLahWWFrKpXwco0AxMl/MSSSrOL2cBq5R7ACG
         l6n+OtlmqukUuQvJUQGLKr3vvgJ4dIVvh3WZEgoY28yxgM3Oe0WLvVR6Yo4U32NhZ+QF
         MAFnya7asD7TinDiBc9nIQVCRvLA0V5gfTehvQ46+Hmx7jCXO4x3JkR2gI5sqiNNurSG
         IdUqzPF0mSasS6py7V3XlfWXrD1hl0slVGSXpu+OyalvOsacihAQrgD25y7FuzuATz06
         X18g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778519585; x=1779124385;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dkzJ/hC822piYaCvNo19iUpPViiOD5q0JLp4DMc5nn0=;
        b=W4HCu00bryJi9HalUdUV0vEgttdGvyoyEV8bfINP7qzpFRyHENaT6P0zoHQbdrXq9W
         5siYvMLtrw8hOup6u7AL1PB4KVkMSAt2m222XtsYyVflbAzg591DWb0ftkP16kq4wiE/
         15CRBxZdRDqqyD1C86FO7Z5rqML0sH6FsxwpF01Rl9J7ANvpIqBnj+YWkSd+xilqOtTb
         t2N3ZAxHP+FlGCcAJ1w8y1OnhZnBDY1cCOCpIwjyUObb0gEgYCn7xeKnSdoV/zrz3C+o
         k5kxx9xn8vKqPF8VnNiNL34BwaxbmNozYpKzgus4x8UTxnRX/LcDVTFqXAopiivamtOF
         S6Ow==
X-Forwarded-Encrypted: i=1; AFNElJ/ZlwruH5j5P2Wq0nnEvAL5ucOP1Y3wTXW0xDQOtkI0tuyWc2a+6M4Gh/idE+WjqeOOBzeVD73mSVM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxzuU21i2rAB6GrWEsKClqYdQnMiDDn6/AXcXOv5yfw54eANhF
	YS7mbhcTJM6IRTXUhWkZe4VpxYRUNG5A4sFdnKazSobcOjJ2KL/5+/OCcrS29XPu
X-Gm-Gg: Acq92OFn/6qg+J1OzkGD+YlQScwUrXXuPiNQ6V1NDQbSfFwLi4oQEBZB0YDBqglT42D
	kwdOOf6bmeHrTeM5CflfOrtvnCVbDfPwb5bmE2t4wpQuaekW9PfzEqrZfhtfDmCUToSkh61JjA3
	2BMdrwcoH1cJ8JXwajuiPPNYuv+ioaZMDs4UyR7Q1RYBCF8QVmBBSWu1arMKXuIckVTZ4LlOK3u
	s4SiPEZWEA9oJ8QW3BK/hXcTOaTypTCeOlZ92h2sbUNxwDGxQmIFFA05vMBmuJx0pVG+q+DN525
	3S/T/fVe1lzE00c/jR1K1EegzMd7cneDfakRgzDDXakVvmAjOb5nAAATCm75o5byNmnP+trmpjR
	AJCsBauAjv77ylRS0BaUEjpt+F9LAunQIH7A/9dQdbFD8yVgcMvvh46TsOcu8rlU83lAooeqmzw
	GssuKDjiDvSbbfxOoe2aYgALvSEiiMdzj/FZdIZmqnKebz5pn9x0s8nfJsAyrNpCfbqoPqLR7Sz
	g==
X-Received: by 2002:a17:90b:2d4f:b0:368:65bc:e32b with SMTP id 98e67ed59e1d1-36865bce380mr4105229a91.15.1778519584761;
        Mon, 11 May 2026 10:13:04 -0700 (PDT)
Received: from avinash-INBOOK-Y2-PLUS.bbrouter ([115.99.181.159])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-367d683fb92sm8055704a91.12.2026.05.11.10.13.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 10:13:04 -0700 (PDT)
From: Abinash Singh <abinashsinghlalotra@gmail.com>
To: jic23@kernel.org,
	gregkh@linuxfoundation.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Abinash Singh <abinashlalotra@gmail.com>
Subject: [PATCH] staging: Documentation: dds: replace frequencyY with frequency
Date: Mon, 11 May 2026 22:42:55 +0530
Message-ID: <20260511171255.9668-1-abinashsinghlalotra@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Abinash Singh <abinashlalotra@gmail.com>

The documented frequencyY attribute naming is implementation
specific and differs from common IIO sysfs attribute
conventions.

Replace the non-standard frequencyY attribute documentation with
out_altvoltageX_frequency and document tuning word selection
through out_altvoltageX_frequencysymbol

This makes the documented ABI naming consistent with standard
IIO sysfs attribute conventions and clarifies how tuning word
registers are selected and programmed.


Signed-off-by: Abinash Singh <abinashlalotra@gmail.com>
---

The out_altvoltageX_frequencysymbol and
out_altvoltageX_frequency_scale attributes can be added
through extended channel attributes (.ext_info in channel_spec struct of IIO)

Feedback on this approach would be appreciated, and if
there is some other way in your mind. I would like to 
work on that.

I am also interested in working on the sysfs-bus-iio-dds
documentation and the ad9834 driver. I recently bought an
AD9833 IC for experimentation and testing.

Thanks

 .../iio/Documentation/sysfs-bus-iio-dds       | 31 ++++++++++---------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/drivers/staging/iio/Documentation/sysfs-bus-iio-dds b/drivers/staging/iio/Documentation/sysfs-bus-iio-dds
index ee8c509c6733..dfc6ae3964d1 100644
--- a/drivers/staging/iio/Documentation/sysfs-bus-iio-dds
+++ b/drivers/staging/iio/Documentation/sysfs-bus-iio-dds
@@ -1,33 +1,34 @@
 
-What:		/sys/bus/iio/devices/.../out_altvoltageX_frequencyY
+What:		/sys/bus/iio/devices/.../out_altvoltageX_frequency
 KernelVersion:	2.6.37
 Contact:	linux-iio@vger.kernel.org
 Description:
-		Stores frequency into tuning word Y.
-		There will be more than one out_altvoltageX_frequencyY file,
-		which allows for pin controlled FSK Frequency Shift Keying
-		(out_altvoltageX_pincontrol_frequency_en is active) or the user
-		can control the desired active tuning word by writing Y to the
+		Stores frequency into active tuning word register.
+		To select active tuning word register, the user
+		must write the desired index to the
 		out_altvoltageX_frequencysymbol file.
+		For pin controlled FSK (Frequency Shift Keying),
+		tuning word registers must be loaded by selecting
+		each via out_altvoltageX_frequencysymbol before enabling
+		out_altvoltageX_pincontrol_frequency_en.
 
-What:		/sys/bus/iio/devices/.../out_altvoltageX_frequencyY_scale
+What:		/sys/bus/iio/devices/.../out_altvoltageX_frequency_scale
 KernelVersion:	2.6.37
 Contact:	linux-iio@vger.kernel.org
 Description:
-		Scale to be applied to out_altvoltageX_frequencyY in order to
-		obtain the desired value in Hz. If shared across all frequency
-		registers Y is not present. It is also possible X is not present
+		Scale to be applied to out_altvoltageX_frequency in order to
+		obtain the desired value in Hz. It is also possible X is not present
 		if shared across all channels.
 
 What:		/sys/bus/iio/devices/.../out_altvoltageX_frequencysymbol
 KernelVersion:	2.6.37
 Contact:	linux-iio@vger.kernel.org
 Description:
-		Specifies the active output frequency tuning word. The value
-		corresponds to the Y in out_altvoltageX_frequencyY.
-		To exit this mode the user can write
-		out_altvoltageX_pincontrol_frequency_en or
-		out_altvoltageX_out_enable file.
+		Specifies the active output frequency tuning word index.
+		Writing an index here selects which tuning word register
+		is written by out_altvoltageX_frequency. To exit this mode
+		the user can write out_altvoltageX_pincontrol_frequency_en
+		or out_altvoltageX_out_enable file.
 
 What:		/sys/bus/iio/devices/.../out_altvoltageX_phaseY
 KernelVersion:	2.6.37
-- 
2.43.0

