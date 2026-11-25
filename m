Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795638155;
	b=w1KMgfIDF9FcedxFEeaPLlU8XwrkHY0jNi+42aNSX0sOYGbu0+PoRj1e21g5QhKC0GTl
	 OKcR+opFC8SWi3LpQ3q5dNqFkgZ49wKXrPoFJ1K/C027AxyNTK59Paif5Bx/ft2Hp+OUu
	 Lc34YuaFIvZQTRrdksFBDoYv8DZbXs9a4ob4lFZJUJlspLySbYk5oGMV08c94LhOu3Gdl
	 4e75KykuXlTTCq4TA3nE1iXnB2Op8xItZDAJ8XkQZXxUH4Ul7n0tKqItzQMC8lsJxftQf
	 yJRIvL00eEpQ51NJqIBZF/jG69DQwZ+CZVi8R9sCxnenxk8G9gWXxakJOY6T+GsXm6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795638155;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer;
	bh=Tw6abP5TGyJaCCJ/3YqhHDtPs9CAOD/H6iKvRgGyxpM=;
	b=Mfm1SmcWWg880+sF+yCuk6aRuAmjZrgtZDRPtZa0T+1Z40JuVq1kuDLXg6y3Oa1oF+lK
	 dNnS3ckCIpl38c+okzgBEQemxYwCVU0RxpcyM0Oo9lfg8n0W0kG/QG1iZXHGdxMF0ckfh
	 dhyorCW4c4AXUZDBY7X9xDBuf+1RKqmu7/5pCLPoV8ejtfA/AonaNJEzfkRBcyfIfh+Ur
	 HUVDeiA67wxTYPj8N3wfYpBvhFyI0Pd4tLPmYWNMKrBHY410GAadbazqsXpYPStSXNkJj
	 1iHa3e1V+tLkD8z6QHpB7Dq3jKGQgDgoJ8xOOsSYjUjjA+tl19dLxjOeXPt8LXCBb9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=telaak.dev;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.128.180
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C76606A31E
	for <linux-iio@vger.kernel.org>; Wed, 25 Nov 2026 20:22:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 33C76606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=telaak.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-8b4d86f5328so43126887b3.0
        for <linux-iio@vger.kernel.org>; Wed, 25 Nov 2026 12:22:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795638154; x=1796242954;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Tw6abP5TGyJaCCJ/3YqhHDtPs9CAOD/H6iKvRgGyxpM=;
        b=ZWqb3t7HPnyW+eHBAUJZAaoPFNhr4TaHVU6YHrESU2KZBqPUugy88gqAJE8PHKE6k3
         Ii2BQtNWgAsNvVnwvCd9oKMUjhODUB5iydYqr8jo9W+KOUc4rFFWNBh7PJm4lTU+8bOw
         PYRYml4s5tt2+VgXE1iRmv7IB1sS8RnXIzSzheGk3616VRQ/eEONBr0e7EOK0QvspW/c
         H2rFn0Ov10J3CsCwydJ/1qk1tIfRbHWDyQFv+vPPPkUIMjdMd7cm1KUvswA2JcTiHVMo
         P4NHZx9HWYEoH+ZNlf/u6UQguKHQcq0Sm68NOi2VIAZtO4XJKub96imvg9wua6Vifh6L
         TuRA==
X-Gm-Message-State: APuU4Z8zxrblJthS2aDArok/XRXySVpmk8RxojL8+kr6Pvakgd38JaGj
	zI/Oa0E0k/tlH93onz0PyLBGW80DqGUS6M83UDeiP9upaHpiSoObXVDj
X-Gm-Gg: AZFdTZeBr4KMrL+4hluXy3y5rBoJTBJ7C8sz2VLM2mCV7jQ5a6A8xIE8A2iWHdbWX1Q
	jkrqivc9KxKeHKqvKNvznCF4E6xxBKas15go04nQixw0doV2F0Aoetn0FPN7KDisYl+oLw/u7kQ
	2Wm6TihLUWxUS2DP7ndcDNK9stLPqLOeQhwCEVQH92aXQ+gXkmwt1RzyFX9lu/A2KNlhhsn56Vf
	ndYwMhXCL014RYrmc7lP0VlnZKe7kRmd6zDPVNGufp449hoTtTW06MK4+ZNLqmQz+938idD7SGP
	jvVKXwXbN2DmuSMZQXsb4x6Ng4Gw33/Vn5scVjMcWUzqE/jTTJ1mLs/9w/izoT/DhQadYm0cgDJ
	0xVwH8Idw2wmd3UxTIesF/1Dx70z/zKKgI73RPF2mOF2SlN0pQAuEJQfiZD07Dmf84rTcEknl5Z
	6PKIYr4f7HSxGlwhsImuqRyK0X0Wb8U3uFmXBfsIx2cZ0SvAoRDfwRh14O5ItuRG7tO/bz4lC27
	Ppku3QwpFqEJsLERoRFU2vOlZu0FCWTw6+KUnuouQt/lnTf/zq9a7G7uI6q6MYM9HgDHYwETj+N
	vjfDQc968obLy+ERGnfIb+T8QrqMUUTw3meJlNuKRmCtawfXIdN3gIigKiPIgmCfaKHEC0GZswW
	gVn/e8P/ZQ2cMbW+IkA7XFE76vTODaJYn5bH/kGG/mb1ih14/jE1RKLvAu/rfDY7iXxP3Q7QdZn
	VEEZEuEekllBDS3epl4bQBOxeg
X-Received: by 2002:a05:690c:e06:b0:8b3:59ac:9f5e with SMTP id 00721157ae682-8b5205073a4mr100432837b3.61.1795638154248;
        Wed, 25 Nov 2026 12:22:34 -0800 (PST)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([71.68.170.161])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b5201bb6c7sm77074377b3.6.2026.11.25.12.22.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 12:22:33 -0800 (PST)
From: Joseph Telaak <joseph@telaak.dev>
Date: Wed, 25 Nov 2026 15:22:28 -0500
Subject: [PATCH v2 1/6] iio: ABI: Move out_resistance_raw_available to
 sysfs-bus-iio
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261125-iio-ad5246-v2-1-8feeb630f0b6@telaak.dev>
References: <20261125-iio-ad5246-v2-0-8feeb630f0b6@telaak.dev>
In-Reply-To: <20261125-iio-ad5246-v2-0-8feeb630f0b6@telaak.dev>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Peter Rosin <peda@lysator.liu.se>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joseph Telaak <joseph@telaak.dev>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux@analog.com, devicetree@vger.kernel.org
X-Mailer: b4 0.16.0

The available raw values of a resistance output were documented only
for the mcp4531, without the channel index. ds1803, mcp4531, tpl0102
and x9250 all report them, and indexed channels name the attribute
out_resistanceY_raw_available. Document both forms with the other
generic resistance attributes and drop the driver-specific file.

Signed-off-by: Joseph Telaak <joseph@telaak.dev>
---
 Documentation/ABI/testing/sysfs-bus-iio                       | 10 ++++++++++
 Documentation/ABI/testing/sysfs-bus-iio-potentiometer-mcp4531 |  8 --------
 MAINTAINERS                                                   |  1 -
 3 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index 54800847f2ca..83eb616862ea 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -2034,6 +2034,16 @@ Description:
 		Raw (unscaled no offset etc.) resistance reading.
 		Units after application of scale and offset are ohms.
 
+What:		/sys/bus/iio/devices/iio:deviceX/out_resistance_raw_available
+What:		/sys/bus/iio/devices/iio:deviceX/out_resistanceY_raw_available
+Date:		October 2016
+KernelVersion:	4.9
+Contact:	linux-iio@vger.kernel.org
+Description:
+		The range of available raw values, as the minimum value, the
+		step and the maximum value, all enclosed in square brackets.
+		Example: [0 1 256]
+
 What:		/sys/bus/iio/devices/iio:deviceX/in_coverageY_raw
 KernelVersion:	7.2
 Contact:	linux-iio@vger.kernel.org
diff --git a/Documentation/ABI/testing/sysfs-bus-iio-potentiometer-mcp4531 b/Documentation/ABI/testing/sysfs-bus-iio-potentiometer-mcp4531
deleted file mode 100644
index 2a91fbe394fc..000000000000
--- a/Documentation/ABI/testing/sysfs-bus-iio-potentiometer-mcp4531
+++ /dev/null
@@ -1,8 +0,0 @@
-What:		/sys/bus/iio/devices/iio:deviceX/out_resistance_raw_available
-Date:		October 2016
-KernelVersion:	4.9
-Contact:	Peter Rosin <peda@axentia.se>
-Description:
-		The range of available values represented as the minimum value,
-		the step and the maximum value, all enclosed in square brackets.
-		Example: [0 1 256]
diff --git a/MAINTAINERS b/MAINTAINERS
index c74dadb6cea9..ef6033c5edf3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16691,7 +16691,6 @@ MCP4018 AND MCP4531 MICROCHIP DIGITAL POTENTIOMETER DRIVERS
 M:	Peter Rosin <peda@lysator.liu.se>
 L:	linux-iio@vger.kernel.org
 S:	Maintained
-F:	Documentation/ABI/testing/sysfs-bus-iio-potentiometer-mcp4531
 F:	drivers/iio/potentiometer/mcp4018.c
 F:	drivers/iio/potentiometer/mcp4531.c
 

-- 
Git-155)

