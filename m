Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B03FF43B4AE
	for <linux-iio@vger.kernel.org>; Tue, 14 Jul 2026 08:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784019245; cv=none; b=ORdqRsdjXHINvAxDKDrjiwOnXepkr2ej8tMd9bYndbsOmMnO/4MZoyazxaiPm714r4uuwt/wd6jU1oFCBlDcu0is9yD1Y9kyalhMiR8qg/1XK0qQkYzzRi5Z27ARC2njVRB97hMVN44mtfPFYhDyl0CE4VIy7UXTYDfaXlZSt6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784019245; c=relaxed/simple;
	bh=+Wg0xXzXfXlOq8LYCymCteD0JyocqtY9m9udaiPSyGU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h5RpRK+KQSm3QotO6Qn9JwVW/y+KGQZoHmeaJZRcJ3Ie4I+A7/njbaD7CriWWIhcM78xg49Gwb8RcsFk5rJqPX5Y6l1l/MMOW5CGrUHrSNv5tQ5ljx+u5nE0DgZTbG0ExGm5i8iSrOHYyky8SUGxQ2Sv1+6B1IZFotegLy/QYu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ROGS8s1Q; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ROGS8s1Q"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c15ba3a2b4bso472112666b.1
        for <linux-iio@vger.kernel.org>; Tue, 14 Jul 2026 01:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784019242; x=1784624042; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9QOPJ2ykF/Eu4mRV1f56hVXyVkIVyfFygrcAtErrlD8=;
        b=ROGS8s1Q9sIAOEwxqt2eylYuocogXDJPk4KwKM+dYKjSDB6aYxYoa6StfrNVcA0pes
         OfA8kmLWG1apuV2nVAECdSlB5K2vYqXK7cZ1W0RT/w52Ise7ASBSLurlyiSa6yhmxbZi
         AzLw/EBl02m8QWGScWaIOudL9oaoSJcbAIptJrc8NFzWKYh/tINd6lkzgSHmfO6OCdSD
         N2414xUxZCx8BauGdDh2ymjDNiv7TCyyE9gurRUM4Jvk4L+9hLiaW+fIygQgFLq/eWvI
         qTQsslhkr01fg3zaBUKgWph06CZ4VYxu/rT7U1+B6Wj/u9n+7XJ03wJB5ci6r4b4SvS0
         4AxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784019242; x=1784624042;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9QOPJ2ykF/Eu4mRV1f56hVXyVkIVyfFygrcAtErrlD8=;
        b=BLKBf2cqosaJbZMkyE7lS7bf3X80EI8MuKLSLypgsBAw1D2yMqu9ckL56KeiqchWPd
         S6ph4KPNv7Dd88peG++1dIr599fitYgZdtdRHFSGi+heY3ODpzPownJ3FdJYpsw5gTN7
         tbp4Prmbmwxb62AdMqHmmpvM40Yu11ym6VrEFU9jFBCLis5loDcUadm7Kvw1oOy0p2bl
         Ocj0GikNTTlIz+ebfvT94DIq0QrcKlIlQ6YZN1VTQ3zs3kUKze5sO+IEEkVwAcXxjqPT
         F5+vV02+G543VblNc/xv+QH0Xsq9QAGzEhuvjpNaIAcoAT/UHmb2D0av1g1xIM18FuQd
         rqHQ==
X-Gm-Message-State: AOJu0Yy4F8A5HqMBm4KrV+8c0mg2iU35HzIu2XmSUTg6UqQjKTna7ASf
	oBr2IISqlZojGNnGcJq4wcqpjzYRAXwYLzxaf6AZGGQyF+OCSA94CYGm
X-Gm-Gg: AfdE7clutqxMJnx5Sid6FKsvE5mEzp33kYT1CXpgDpfRHyP8HQIWfCnmd6gqOWX6NtH
	gxaVeTeiAC26tHYu8okSMOFa1JT86aRhYUkm6EtEFzClHljcCaTzA1/mjOPb/vmFl2vHWkYI3mp
	YhugBmnRHslvTXV7aBNfCkHwWSeekr9mtG74z5VqIJct9OscufObEwlSYeXjXFmoQbhQCKBCWLG
	YdFMkDGQ/0700AlbGQ8WzRgew5zD67xT1cSoEjRIV2O9VtvL5MMYPLuPZFeZWdoVC3OJQV35HEq
	rrGFTlo1pbHpb2XEKkpAizLtPRmLd5U/Ju4TY5vEMcPy6F0SE9/p3Z9Zd9JHtcrVn64uLJEqu8f
	vqmzEXoLrk5Eif5W7TBwLq1GxnHe+wlZ4uGDSwEedrQVtp8PhTkRsspx9/hgnNH5S1jQJTPd9CF
	NFi/7c/rEQ2HvEEqER540x9yNVCU6fPkDU3Xs=
X-Received: by 2002:a17:907:3ea2:b0:c15:abe2:e1df with SMTP id a640c23a62f3a-c16618ac78dmr113170866b.43.1784019241690;
        Tue, 14 Jul 2026 01:54:01 -0700 (PDT)
Received: from DE-PF5B95TD.embedded.cmblu.dev ([87.129.199.250])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c15ad82279csm1143689366b.13.2026.07.14.01.54.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 01:54:01 -0700 (PDT)
From: Wadim Mueller <wafgo01@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Maxwell Doose <maxwell@maxwelld.cc>
Cc: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
	Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
Subject: [PATCH v5 3/4] iio: core: add IIO_VAL_DECIMAL64_FEMTO format type
Date: Tue, 14 Jul 2026 10:53:57 +0200
Message-ID: <20260714085358.20842-4-wafgo01@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260714085358.20842-1-wafgo01@gmail.com>
References: <20260714085358.20842-1-wafgo01@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extend the IIO_VAL_DECIMAL64_* family with a femto-scaled variant
(scale 15), following the existing MILLI/MICRO/NANO/PICO pattern. Both
the read formatting path in __iio_format_value() and the write parsing
path in iio_write_channel_info() (via kstrtodec64()) already derive
their scale from "type - IIO_VAL_DECIMAL64_BASE", so the new type only
needs to be added to the respective switch cases.

This is needed by drivers reporting very small SI quantities where the
existing pico scale loses precision. For example the Sensirion SLF3S
liquid flow sensor reports its volume-flow scale in m^3/s, where the
SLF3S-0600F scale is ~1.667e-12 m^3/s: at pico scale only a single
significant digit survives, whereas femto scale preserves the full
sensor resolution.

Signed-off-by: Wadim Mueller <wafgo01@gmail.com>
Reviewed-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
---
 drivers/iio/industrialio-core.c | 2 ++
 include/linux/iio/types.h       | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index d6b547207591..8e593f5741e1 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -715,6 +715,7 @@ static ssize_t __iio_format_value(char *buf, size_t offset, unsigned int type,
 	case IIO_VAL_DECIMAL64_MICRO:
 	case IIO_VAL_DECIMAL64_NANO:
 	case IIO_VAL_DECIMAL64_PICO:
+	case IIO_VAL_DECIMAL64_FEMTO:
 	{
 		int scale = type - IIO_VAL_DECIMAL64_BASE;
 		s64 frac;
@@ -1032,6 +1033,7 @@ static ssize_t iio_write_channel_info(struct device *dev,
 		case IIO_VAL_DECIMAL64_MICRO:
 		case IIO_VAL_DECIMAL64_NANO:
 		case IIO_VAL_DECIMAL64_PICO:
+		case IIO_VAL_DECIMAL64_FEMTO:
 			dec_scale = type - IIO_VAL_DECIMAL64_BASE;
 			fallthrough;
 		case IIO_VAL_INT_64:
diff --git a/include/linux/iio/types.h b/include/linux/iio/types.h
index 924ac9dc6893..d8944c9e5e90 100644
--- a/include/linux/iio/types.h
+++ b/include/linux/iio/types.h
@@ -42,6 +42,7 @@ enum iio_event_info {
 #define IIO_VAL_DECIMAL64_MICRO		(IIO_VAL_DECIMAL64_BASE + 6)
 #define IIO_VAL_DECIMAL64_NANO		(IIO_VAL_DECIMAL64_BASE + 9)
 #define IIO_VAL_DECIMAL64_PICO		(IIO_VAL_DECIMAL64_BASE + 12)
+#define IIO_VAL_DECIMAL64_FEMTO		(IIO_VAL_DECIMAL64_BASE + 15)
 
 static inline s64 iio_val_s64_compose(s32 val0, s32 val1)
 {
-- 
2.43.0

