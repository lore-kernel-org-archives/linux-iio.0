Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B5D40A937
	for <linux-iio@vger.kernel.org>; Mon, 17 Aug 2026 11:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786966718; cv=none; b=tYZY8MEXxP1ZoRpErnOMsOkANLD7iiH5hPqqq17A8MJ+xMMsqg2I4SNLqofe1+ZBwUOLP1dotOqk8bjMaZAUDiY+AStP0BU5P4l1YUHFupsZUrZVB+7fz13LzRpZR5pAk19+ZAjhh9EcVkzKE0Y7WeVZ35lmYcErXNdqoN1jVn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786966718; c=relaxed/simple;
	bh=preAQSUiNXBbVUYKY80ddcTWhyOTIGO+mcuB1EQ93A4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qAdfVRwNXghR+7ucOjDEevjnOq7MxK+THhW5PDXqOmxoTeuFiXQQXxp0wfWQ/DkaEuoe03SduhfKmnOMBKEPMfSJmun5rDB5uXP+u41LXWq7x5vdbUMFI26VsFeChTAtGHgHas8Y+73mCaX+SmDTmuW1PpnjH6YYGdzO3csKqKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s44uHB23; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s44uHB23"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c2055573c8cso453406266b.3
        for <linux-iio@vger.kernel.org>; Mon, 17 Aug 2026 04:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786966715; x=1787571515; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ntKnsiwJpy1kfM4krSauxn8fNlU0qOy7OW+x+qrciSM=;
        b=s44uHB23bXSYWN0xx10dqEHph/LjPUrRii7//mfyy5wBJ+Q/1srCESAifTk1gMXe3j
         3HrKsRDf6D9Or73ouvozCxigIr+DT0cALYXZ0dDj452Hz3RV3DQoSe/a0YMN1R0EiibA
         WqpjsMIV6hcJ6r8WfUiAH7AL7PERWTBWIOP1In4lnTckO7IVdYBrG1U/PDWMq2LsRDEh
         Y37jxUde3lzXqxigugp0YM5wzh3TU7Ojr/FGbjujI8et0Gmc25V8TGgeBISxqVjwz1d5
         Lz7cKpdTzuf1dXEFmVhhRToLjK2+isMFJqnqo4LA3TQKfsOwdfvkdiISjD17q0MSz60m
         xW1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786966715; x=1787571515;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ntKnsiwJpy1kfM4krSauxn8fNlU0qOy7OW+x+qrciSM=;
        b=X41/E2HZ0HQrkf6rlQjEZbcXGsBIABTuTE/LoPSPoHIACWsz7HK+FjHJ2+ozaZxJbS
         Px8gplHCqeHPCoJwQS4s5LCvWDIa3nPqwWXqanU1UaXpmhY/xaxrvpHCDFQht98Hx0an
         bo5lV0ePqQJ3RitHnhrq2kqADPub2L2UdItq0Prrrt7V4L4w+/y8kn5XiYzrSbKXAU3U
         yD0Oyl1aqdQK4f3UIhI5wsgPsNEvwXuEbHlzzdjW99wlkKgsEjJ6n48bbge7DGFRGz0c
         AK4/53Ea6L1SS1ypCMx4PqQ+rUCP8cigKPZ8CFARQ7p/+Jgl/NI+WNHuaQsisR8hNykc
         IlQQ==
X-Gm-Message-State: AOJu0Yz4QAv1XZaswp6R2vgNDXfhNuS338HvpTvLMd/eESc2fl+yvOQP
	jCpASDVoZwaxPE8SnRwE3htkZeHBV7/pbxiGriloIbnYpzHMgVtuC3tY
X-Gm-Gg: AR+sD13HDyZwQ1agcm/HL4JjXthluueCNZJ3wHq7UeGz7e+TuOF3V8mrqQjaR0Q7pSK
	QNR70b2dSzOeDXm9kJOxmuD2xO1vwXHSB0vZ+tGMXQWap0Mlda4HTt2aJ1v6YcSlSmOG8xIXjF6
	JQNuvmmc/xMlNhpGyEg6ss6dZaMWBPtLjN9XuUE58vdnGXpuo0Q6Etosb50ogvxHPzLqs/65eQM
	kqpmNOQKB6bT519NCuNIFXnJTeyyiZHbyO/9ka09xGP9+8xOBjBb8LdHqLZ3Z5ejzDKLxx0hzre
	nGZ+ivzSsUsk6aBZiq222SonsZ5POl3BjTi0WnxKGv1IzbqpZLH8LE0yyrGgm+KFFEClUXQV3W6
	Vw9PZ3icxscaMw3mQXcMbRKzh/qjvucqhjtzC3EHVQQqnlp3uBA19bQdj2MkkpUJrVLGIit7HoI
	RsXEFZXXC/73k4oOKwHYycCNhrg9pd0kGhCXmmDq0S3AJC6qGwx6WtVr9ms1vkuKCsCkvR1pbj+
	O/9DWAxMyKCAuSx6fZN+O8VN0RHoS8VBQgCKyCPqW+00qJ4XaSqAc4Mp+7kOEwL9Y5OjkQNv1hZ
	F89Db+r197wrQWhisqtjcE2LyjnDpYvTiCj1IdCKmXlS7d1y3Fhx/NA0W8jsWS7RuAiDl1iJOU/
	O/06lFNV7a3MTzcWN1Ylfi424bK0FS+/8IfNE+rsYxOdj3qkAIUYaFUhb0Qd4giRp3EmsLX4IVJ
	IedA8h9CjbsAGpP1AJsHzl14NWRRPQv0nFvBF/s23QBGaWsmEnvezwbQPxjAMDCaXMK8CER8CvC
	/9fdm371cB0zERkDA==
X-Received: by 2002:a17:907:7b9f:b0:c20:23fb:bb05 with SMTP id a640c23a62f3a-c212a26d65cmr1152187466b.15.1786966715187;
        Mon, 17 Aug 2026 04:38:35 -0700 (PDT)
Received: from cs-280612103108-default.europe-west4-a.c.i2f7e30109524dc12-tp.internal (249.139.91.34.bc.googleusercontent.com. [34.91.139.249])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c217feb99d4sm40879666b.22.2026.08.17.04.38.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 04:38:34 -0700 (PDT)
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] MAINTAINERS: add patchwork link to iio entry
Date: Mon, 17 Aug 2026 11:37:23 +0000
Message-ID: <20260817113738.1324-1-joshua.crofts1@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The IIO subsystem entry in MAINTAINERS is missing the link to the IIO
patchwork system, making its existence lesser known.

Add the missing link.

Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8014b9f82..57d592c27 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12612,6 +12612,7 @@ R:	Nuno Sá <nuno.sa@analog.com>
 R:	Andy Shevchenko <andy@kernel.org>
 L:	linux-iio@vger.kernel.org
 S:	Maintained
+Q:	https://patchwork.kernel.org/project/linux-iio/list/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git
 F:	Documentation/ABI/testing/configfs-iio*
 F:	Documentation/ABI/testing/sysfs-bus-iio*
-- 
2.47.3

