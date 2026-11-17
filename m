Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794936383;
	b=s8MVghWHDSkNkTKpqck7ojCG6YjqDXNDRpsNxyqma2ZgABO5ZYWRlqJZH+XNnAPSDT/c
	 +/WDiz9TzAtmzK6Q3qzkq7GkHvgO5QSUfWfGACubZ2+s0dwTr6VWbKAKIx5glomLDpawC
	 YhwTkISEtcH6hh5X/A/oGILoLPLefA+sRUsoMgH2rLYCuduADgJMu4Gn0ws1mPYzCySkU
	 iKZdlvvpQEqP+9C1rthwnP7ZqlovWJnxqQrXTR8EOzWex1b9KJhcWaJg7xOPHs0P3alkV
	 qdkjE04SQWaXv1sZ5nkI0eplxs5qD/GLfaWAJm4oN0jq3tBMBXro5EHi4/tBrq6cRKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794936383;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=M+o9+9qekLBCMmwzgiZ85/sw7Z0aupiEWaDsdwZ/4vM=;
	b=RF8dBBnGmBTsSUZ4mgYXzef+tgFYA9uI4ciPzhlpBpRLHOyB1iGxCYPJ+8by9RlQgwlH
	 Z72m78C0dkkXXWRwPm/p6+EDQGUiuTEtpQ1y+zvQ105xDsMXSd7vFHnE5fcJb0dO/fVRL
	 URVZCNUmbTfpVN7O39VeCwepeJSEfGBxEHfd5fZVDigKTEvAFJXvlta06MpDcipLaIrS1
	 I+9vMkzk3qpS+jnSZKCbizj4jxE4JUyto7lJfK8aacZ1ITHMHPV97nVRkvrAYcqzoJHd2
	 Hx/FN+KMAj/nsYLrdJQJ/LnrP7oVoux8YMU/hiu9P9qUzyg32GZuObOu+L1oJ6ULRDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lrpOdjQX;
	arc=none smtp.remote-ip=74.125.82.45
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB32606A32F
	for <linux-iio@vger.kernel.org>; Tue, 17 Nov 2026 17:26:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1AB32606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lrpOdjQX
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-1a8cc11ac42so99447c88.0
        for <linux-iio@vger.kernel.org>; Tue, 17 Nov 2026 09:26:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794936382; x=1795541182; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=M+o9+9qekLBCMmwzgiZ85/sw7Z0aupiEWaDsdwZ/4vM=;
        b=lrpOdjQXBkqUxxULtoY/C0zWkzRPNV8v9WPWwkie6mJNfrRKPe79e6wA0+DFLUp8LZ
         yZjaOYS1qN1PdIHncPT3qqkwux8/LI/qM8Gg6HtuASnXYKBNJW3yQ3EQmVj7iFuNDfIe
         drj+2qZIrdViGVUXMrYdejHOi8go7g1A+ZdU0YsODa59s0SLJGRfpiPrjBuxyp34fIIL
         bbXR1b+a6jvF9VmwEjYzEwKKI/u46m7fbo0P6KejAbPBvUv2Nnnj/6BcPsn0FR0eH4mS
         mIxcDKI/4xQCMdje79OxI1SBfxZvY7PlLXwwjLA20wHJ2n4Ti279uOC6z86M+427Ib0e
         MAMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794936382; x=1795541182;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=M+o9+9qekLBCMmwzgiZ85/sw7Z0aupiEWaDsdwZ/4vM=;
        b=GLrMJ9yZmpTzvygStMCQ4/QYoweeQAvFqAZnrHIlgLhb102Ro4ednb4qh8sT2LPsJb
         KWxlGy4kcrLZM8ZEBUM3GEUJ1IMPrRp2+i4ZzbAAo+e5Jd2RhR4OqEZi5HjGyaAa2HmM
         9YoSV1q6gOi4uhWGtfn7Mj4avG8ThK10Tu55wqyZAMfXpQRKi99SOrCktCGxYl9BfxTw
         SBFn9+HuMM9aWKeBPl0MOg1oK1zjHOu8rsSMwea1blRqClcyoSUoeW9Ksx3h+hhTLf3+
         xTYahyMFA4jgpJUeBibkUVSKTWOGqQ3KhCiSOaSmg4gAwRbmQXFq0zaJXtXYW37ulfkt
         sh5w==
X-Forwarded-Encrypted: i=1; AL+hErHYoIPtSrIPH25dsu8wvP/MIg+9K3aIf/GgfWVfeGlSdOKHwJR1WWN0AcG67/7w8mc5ZPJZPIsi7pQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z/wGeX22/ZMYqx/FZ/UPjrEuC+xavhdatV69yFJ7og9kgJJ0DEH
	9PcfsWzrEFz+o8mBZgKtvFSHuAf+FAeClnt6l8Ou7vaiHez7ze+bxIhgf42T/SA5gvs=
X-Gm-Gg: AYBFou16VQQINFxDgmO1QhIPZYN8WrCHcYM6wuC0dCcCOAC9Vmh1CoP9dPctBDXKO5B
	ydV5S/JjFCywjmoih6/hGRuRK9wWzDd01qFmiyWuaTKelWQPNrAVP98jSbJeiOjXvZpB90eo5sF
	BtSNW9jOSIWDmfYAMT8vQclaoGW7/lJMlg296i1goZ1+311klFZjdR5vkxzzkkSoe9cgkbfI//J
	GUE9rgtYYfK9akVtl/f0UBtkK+v2v9I2g29cULiZi7a8kc3TGRFj8UGX3iqcBZYGpVOv4u9Idz/
	aRSi2X73y+J8uWsbZcS8p5IwboqEtGGnaUJZhGI0d7svZZVxqtKu5Wsa55emsx2NW6YZXAvcNZh
	G0NHour3gW7V5GTlhh7rNt2Ozu0PDkt09HFYgYZcbsa72WJ4a0REU74OoxUDeli3lL45j3XmJvz
	JTbjcDP7wsuAIqVqpnen0Uc0TaHETkkMgkXmo8wp7uoJmZ4xIj2stfy5KgCa/xF9N50bWAw4d6d
	sp0WCXgtai51dBoJV5bqT0RofOdkwOEFgoRjByMbMxuWW+wCDKF16WVcpX4xpgYK1c3SJDWbRn+
	bpTq3H/SYMwNn/8uKUmyZu7YfBMZQk34cN5e3UhK4p2GI7EJGYy63zXescM7oMjendjUdbiLMI7
	hRkAPP6LkRHme8PybkovrRw/6SKgesbX8QIHtFu85NGcKsZh5Zgj/hXxU07ehqrJ6sitboVNoWF
	K40ltf+GX5J+n9nYXgYrxMv6Divc2AtgQAKCC4ILjfTws=
X-Received: by 2002:a05:7022:7e82:b0:163:c5eb:d42f with SMTP id a92af1059eb24-1b543c23b8amr254647c88.5.1794936381830;
        Tue, 17 Nov 2026 09:26:21 -0800 (PST)
Received: from kapoor.iiserb.ac.in ([203.18.51.239])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5329ec87bsm14263079c88.0.2026.11.17.09.26.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 09:26:21 -0800 (PST)
From: Arnav Kapoor <kapoorarnav43@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Gwendal Grignou <gwendal@chromium.org>,
	Daniel Campello <campello@chromium.org>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Arnav Kapoor <kapoorarnav43@gmail.com>
Subject: [PATCH v3 0/2] Semtech SX9xxx: add a reviewer entry and binding maintainer
Date: Tue, 17 Nov 2026 22:56:07 +0530
Message-ID: <20261117172612.25535-1-kapoorarnav43@gmail.com>
X-Mailer: git-send-email 2.53.0
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

Add a MAINTAINERS reviewer entry for the Semtech SX9310, SX9324, SX9360
and SX9500 proximity drivers, and add myself to the maintainers of their
DT bindings.

Jonathan agreed to a reviewer-only entry here:
https://lore.kernel.org/all/20261117031830.69ac22f5@jic23-hlaptop/

Changes in v3:
- Patch 2: replace the Link: tag and the reference to it with a
  Suggested-by: tag (Andy)
- Patch 2: drop the L: line, the IIO subsystem entry already provides
  linux-iio for these files (Andy)
- Patch 2: drop the DT binding F: lines, patch 1 already lists me in
  the maintainers: field of the bindings (Andy)

v2: https://lore.kernel.org/all/20261117110939.214932-1-kapoorarnav43@gmail.com/
v1: https://lore.kernel.org/all/20261117094737.15253-1-kapoorarnav43@gmail.com/

Arnav Kapoor (2):
  dt-bindings: iio: proximity: semtech: add myself as maintainer
  MAINTAINERS: add a reviewer entry for the Semtech SX9xxx proximity
    drivers

 .../devicetree/bindings/iio/proximity/semtech,sx9310.yaml | 1 +
 .../devicetree/bindings/iio/proximity/semtech,sx9324.yaml | 1 +
 .../devicetree/bindings/iio/proximity/semtech,sx9360.yaml | 1 +
 .../devicetree/bindings/iio/proximity/semtech,sx9500.yaml | 1 +
 MAINTAINERS                                               | 8 ++++++++
 5 files changed, 12 insertions(+)


base-commit: 20ce8ef9c9e04cd6c5ae0422e251a9b5936c6b7c
-- 
2.53.0

