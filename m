Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9105948CD49
	for <linux-iio@vger.kernel.org>; Fri, 14 Aug 2026 17:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786730097; cv=none; b=Is1LAMy4RlI4QINZZbh/g5w3F1RNMS70tMExdREv37cvLli5t1HNINzrdPSSwk95VDs9/KLqczRTEuCw+30E2vnIZnkRLKsu2H7cA8a52/HIAxcLhkdKUblzZl4OxJr33AH8CvrzBy/CKYuywFD8vxMIHAqE3LifJnFY4pIH36U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786730097; c=relaxed/simple;
	bh=Gytm2vBeZorxYJyVN7QlG9nHNUrB3j8irWdN57s46Bo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jqu8sPBpy708dHtQL2dCLSg76l6FDjJZavLH8uTGcm85mJIlHNAmNrRElpsRcjfv914F3SjhuRUiI/RXBxGtrczaM9acwXbwksdHalSoNlMApW+EHP1riPwY+I14pqzVN1xmxxN7Qj0zDppiTz4wJUmMpoBoQG/CsOM0X7/r1x4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L+0RarqV; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L+0RarqV"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-c9e607d81fcso814438a12.2
        for <linux-iio@vger.kernel.org>; Fri, 14 Aug 2026 10:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786730096; x=1787334896; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/kOURHIJRc19iLa4xa55l8prRTy60NCsC9eHTfO2q2M=;
        b=L+0RarqVv+BfvwXKj96SRelT/yHmUzV6JI2gnX+Kyo9fSAtMVeXhXPXiqEVDHBNT9s
         qXLw+ArFhj5Jpwj58gYt2Dq7lorRU5qE4YurlGwDiWFEgfza8uP7Q5JQXtyRy/L5Wn2u
         G0XVnHS033jrAmSyMN4Y3nSMS54CblhC0cf8HlsiGXU5UO7KD3+AZWXS2goYLRKIsf4G
         Ta5A/629StHQT5WIBZF3J0QyLWOz//0OXWJMEIkaH7vfCLSJoDzjzLbhG0jT1oVqdk6m
         AW3jbhDsSq+wmITrcRrEhzTmXxgp2sK1LkfFZnH0fDoz/YJ0iqymJf7xSOcl442jF6Dj
         nYvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786730096; x=1787334896;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/kOURHIJRc19iLa4xa55l8prRTy60NCsC9eHTfO2q2M=;
        b=ieu2nGedasVMYnh5PCU10hXcV8gEmlo6AzJ56ac73OmWV4jFd+9GlNpEfACNnOUHyq
         AcFWEyjoq0fc+IALQsRkAdc5Clr4X/SWW7VRU07mAd4CrC9gci7UuoxALPETLTcTgIRa
         JY3v0raQL+bBoIeeNLFTvXOqfIRyFLLjVP/FYtW4AOA+awUzN0F5eNh4kLgTZ8g71ZF/
         FVkfpYp4FH0jLkhISIhHfQd7gUNhzky8jjQQaWGrYs4w8qHTJrG3eZzYE+Y9Oqtp0A2k
         pi62MGFEYJE+UzCw/ZEOsABYYR2rUTWdsnwZB6zEPgxUaxp/wwTzRjijLF7J1qQIZw4B
         0C5w==
X-Forwarded-Encrypted: i=1; AHgh+RqFS7GKJcBXFCx2FQ0JUgcgDUz2b1qyudxltnDkM0n2FlcwJ7dufM/1t65ajo9jn43Tpx5NpnjayKY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxv1n6/N3BK2Whzv/91c2Tf4w31YuBbpt8A4vpdVp6lWpo3slcP
	bHcc/LdsJ1vToNv4zkDNs778dm6wYBXdZX+ZfDCmAgofoO5uBxPk41o=
X-Gm-Gg: AR+sD10Bk3tJyHyjk7wsvciB/aD/HTDm0PHZODfbMniJEEGe066JqzTXFbLldnxFVXF
	Qfk36M4/SVzbOliiPPY6h1d5Y1xqcbv7QLMHuDNimrcpnEY7YszyvBkNhxF040wpXobW4CA4JZX
	ja7RgjMkT0Bc1DPDRE8lBiDmCjYmFmaHWXP8s/Xea4HVpzRn9ehSrwfQAx6yx3fUQ08bk6TOq1a
	xjk1hv7OVLFko+6GFsy2PV6ZP6XyVRKAEQBgIKgr7zdNO1LTeXd9bAXsmsTVciDIwoibEnyqvXQ
	gqVKz3/YUrcCuZmA27cSxc5gs0bSRtHGsNXidcq4/nEO6sUrGjjGsd1TIN2ghV8ygl3xtXOvvgk
	LwALOwxCi+/6f54q+ZsgUQQ8s8vCMISM4OBSwEEbRVq3WmwXLYi7NqM4dIIZg9b0tuKJYhQ3Trh
	AoP0Eb3FfMeDNkLMlgdiDyJESdvHblJ+B5bONBHlr8D5OmbdHTCKLR8DJkfJzvu45D2Y/7ixyEb
	ZTzKPdNGfdwCfj3TFD+L18kAV3fUgbbMjxxz5/h
X-Received: by 2002:a05:6a20:c90b:b0:3b3:fc6:622d with SMTP id adf61e73a8af0-3cc71ddfe6emr9097217637.38.1786730095658;
        Fri, 14 Aug 2026 10:54:55 -0700 (PDT)
Received: from localhost.localdomain ([186.158.238.108])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1413887ee70sm11128710c88.11.2026.08.14.10.54.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 10:54:55 -0700 (PDT)
From: =?UTF-8?q?Nicol=C3=A1s=20Antinori?= <nico.antinori.7@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: =?UTF-8?q?Nicol=C3=A1s=20Antinori?= <nico.antinori.7@gmail.com>,
	Andy Shevchenko <andy@kernel.org>,
	Brigham Campbell <me@brighamcampbell.com>,
	Conor Dooley <conor+dt@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Jori Koolstra <jkoolstra@xs4all.nl>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Rob Herring <robh@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev
Subject: [PATCH v3 1/2] dt-bindings: trivial-devices: add Aosong AM2315 and AM2320 chips
Date: Fri, 14 Aug 2026 14:50:19 -0300
Message-ID: <cf3671822902e82c133563e2169334dd8c41ceb1.1786725567.git.nico.antinori.7@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1786725567.git.nico.antinori.7@gmail.com>
References: <cover.1786725567.git.nico.antinori.7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Aosong AM2315 and AM2320 are temperature and humidity sensors that do
not require configuration.

Signed-off-by: Nicolás Antinori <nico.antinori.7@gmail.com>
---
 Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index 435c4baab436..92b757579eef 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -62,6 +62,8 @@ properties:
             # Aosong temperature & humidity sensors with I2C interface
           - aosong,aht10
           - aosong,aht20
+          - aosong,am2315
+          - aosong,am2320
           - aosong,dht20
             # Arduino microcontroller interface over SPI on UnoQ board
           - arduino,unoq-mcu
--
2.47.3

