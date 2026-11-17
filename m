Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794936395;
	b=xRU5pgZHkYdhQutR9SHFBMuNO8AgVR10ny12eufJAeknVZZCE9pll0HQW5ZXfA3q/S15
	 Zw0EW2LBdLGgwUO55L6GOk4lhlWk7XtGZAEFWoWVdzWiJNQ+dNXF0kFNpZUFpdbyqpreF
	 R8Fws/V2NO8vb6VtflHc/8e2r6BMRXGggTAXMFLBbND4TeSpfTI6+964CVEBS31dRfUQY
	 AtaAoLxl7sgSc1XFJ3Fk+y+m7h0aaUdEHWlTso7lhdtMtUwl6mN8fd6GvEM/rYt2XcsAW
	 y+1zUacYaSCy8JScTtrNov2ztSL85NkeGuJseQKjrK5ua+DMduFAlk0+6XE1uYqZZOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794936395;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=ilc5G8/+9aQdYBwvZEflFTD39tX1L4K1WEy9bWOEMNM=;
	b=W7F5ZqkBX2EzgLtxfX7L8m32joMG25r3iM4Zndz+SCUNxWjaXZ0jQY8bwxPCDH8azrgl
	 S4j2F5jY82Aed35PqaVWuNLdvujx0HJHsitGn2bMDeQkclMWkIe2xeWyd5ap+WVfqVxen
	 HuVAzrBCOK/5PF6KzJrndc1PNEAD9OhXJaHZAHkPvJKHE5UXdD/bAKf1m7I0KnPGrBFBs
	 dAoF94dajtOIQAV3UCq0pHNoj092blCdnUkQpDdserm7HvbpyH/XOtswiS5XwOZKBaWkC
	 oTCTZMAZTXW1+6muWvXNNw80fJx/1EjAA7kMeelf/DUHD1bDuxTarhuAGLdEUgg+I1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=B80da3Sk;
	arc=none smtp.remote-ip=74.125.82.52
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E8AE606A32C
	for <linux-iio@vger.kernel.org>; Tue, 17 Nov 2026 17:26:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3E8AE606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=B80da3Sk
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-1aefd1bf74aso956390c88.1
        for <linux-iio@vger.kernel.org>; Tue, 17 Nov 2026 09:26:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794936394; x=1795541194; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ilc5G8/+9aQdYBwvZEflFTD39tX1L4K1WEy9bWOEMNM=;
        b=B80da3SkgBI11VadNDdAFufDegu8m3LbosxJ910Pb03+r/lraAIaeoWVSAyTuAKbU2
         /XWZf2yp0sgkjPdPjoEhhXBcw6eU+x9qN4PbpyqMlPcydZM0g6kAvK1LrS5diujAmtIw
         L/1aN6JoRkr22C+na+CwR4sI1dHML/+YZROfBtqQmD7+YuoDAd9fLAFTJqncqpcva6/U
         HMIdo4hI3KL3ALTOIUAdiTVTIy9dG3OAw6FTMW6hoJY/DKISbzvV569JB2VJR8tiAz8g
         rmDIebT1J3lhY9JQ1awTQ578oy6Ns2qnbPF4FQ0HlLzO7zq6l6xUQwlev9MXenEYi2Gm
         Q6kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794936394; x=1795541194;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ilc5G8/+9aQdYBwvZEflFTD39tX1L4K1WEy9bWOEMNM=;
        b=RTd6ZOvxsVNjq0E1ckEaMoc9XtXbvO6e/8YOaPYMHH5owo4tOXnqx/HWbDT3cTlQCW
         jqTRD6K1hUns5EDd7pSKKltwNudZ9rPumM/6w/shAr2N5Ln+4xijBFz9UTiy9R09CCTr
         b8b+4JXswNQnkaw7hk0kOrpdzGr1YW8BvJq1unXPGuj0UaLWXoNDlnslUIWkQsWO0v+F
         ojGRGTnUGFMbW/Unsc2a3BxOjVFKCXahjHNl/qQDgveazAcxrvzGhhTfw2BjhkwteJlq
         dynIbfYhbuTAPMMPwxCab47FAZg2C1y9mIMyx+lOZDv58ARXm38Efa9+DqHqzrUsEbTf
         3Iaw==
X-Forwarded-Encrypted: i=1; AL+hErFuQBeiLZemxXQlMKu8M1A1ugcmhG3efzJNJ8P+1a69ByETD7+nhdMJOchnjViMv1uJvbRUwvM65mc=@vger.kernel.org
X-Gm-Message-State: APuU4Z+2eufbkkcgI2N4BcFczQP/Blsx7IcTRS8PcI12b9Rk+QeVslry
	ZcN5TVSsllcmmGOH9bDy2mOBUqEUdX6Q95g+2OK3pSgN3pv3Bj/9yFJl
X-Gm-Gg: AYBFou0OChnI8ziZ014oZIYXyMaemVzm3ESfpscUeEZMCj7GXHA0+2tdBqBTsTduqit
	9SMj7ipoVY+/UX4/jmTn/fbhSTIWhYJ0hpZ8AXgdCJgEjJEu0eokQf25kuJj324rbs6cDJfuV1q
	2NB+QI3zdaXRGv4IF+Hc/PSMiaB9ZgF/v/iukcnCfcwCz63dG8t4nLrCR289ZXHui0XRsmR+xR7
	Q1SmTdBqinCf4WoMVl5uHXkhIHPOrXl6WP4dQIzc9QHnj3slpsed0+iTUiJT/K7npCzDYZrfnJq
	MKg/fWIjPN6V7Nv4+hvHHdVsbhakVjfYBa/a5eWBHjkuUtROoojFdVwwweDVWIniD+TFc+voBX1
	YeB6qDV1pnXc2zpE6HUbCtxmafPz/IDBMd2eGLfDoRwrh/FVE2BJfUbER5GPJkBq5gQ59LZgkij
	tLo7JrFma4EALIWExl0DeOdg9glOcufj4o/zXh19BfyDoMEUnMMyauLs0hjhA4t++PgAEq6/03p
	+Y4O1u1q7hThaSto+LvdMYlDmNASSSGIt3hONBaVn21irJbYGTYTsqBSXSbxQnM7DGv1sD14UgX
	0ns7GQzehHvPuBLm0rHJZ/orSXyNtBQLo/S43Jruxm5LkRVZwZHgnvfQoNVJHFeQSvkDA1gXN/z
	ToqTQgC/o5riySRD+Ldh7I8mb0D+CRRUI8+WL4rBlwK7hwKcySlc1lupgOTKl09/0QX2y3wozmD
	UZsY4dLIUZrgVYUskh08xNbGuzs3W5dIkptnUOiACOcrkZX58hqzb2HmVeJD5bUJk=
X-Received: by 2002:a05:701a:cc90:20b0:1b5:32d6:6784 with SMTP id a92af1059eb24-1b53a470058mr2566794c88.20.1794936394335;
        Tue, 17 Nov 2026 09:26:34 -0800 (PST)
Received: from kapoor.iiserb.ac.in ([203.18.51.239])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5329ec87bsm14263079c88.0.2026.11.17.09.26.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 09:26:33 -0800 (PST)
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
Subject: [PATCH v3 2/2] MAINTAINERS: add a reviewer entry for the Semtech SX9xxx proximity drivers
Date: Tue, 17 Nov 2026 22:56:09 +0530
Message-ID: <20261117172612.25535-3-kapoorarnav43@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261117172612.25535-1-kapoorarnav43@gmail.com>
References: <20261117172612.25535-1-kapoorarnav43@gmail.com>
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

The Semtech SX9310, SX9324, SX9360 and SX9500 proximity sensor drivers
and the shared sx_common code have no MAINTAINERS entry, so
get_maintainer.pl only lists the IIO maintainers and reviewers for them.

Add an entry with me as reviewer. There is no M: or L: line: the IIO
subsystem entry already covers these files, so maintenance and the
mailing list come from there.

Suggested-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Arnav Kapoor <kapoorarnav43@gmail.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0017755f593b..f1fd14dfa448 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -25448,6 +25448,14 @@ F:	include/uapi/linux/selinux_netlink.h
 F:	scripts/selinux/
 F:	security/selinux/
 
+SEMTECH SX9XXX PROXIMITY SENSOR DRIVERS
+R:	Arnav Kapoor <kapoorarnav43@gmail.com>
+F:	drivers/iio/proximity/sx9310.c
+F:	drivers/iio/proximity/sx9324.c
+F:	drivers/iio/proximity/sx9360.c
+F:	drivers/iio/proximity/sx9500.c
+F:	drivers/iio/proximity/sx_common.*
+
 SENSABLE PHANTOM
 M:	Jiri Slaby <jirislaby@kernel.org>
 S:	Maintained
-- 
2.53.0

