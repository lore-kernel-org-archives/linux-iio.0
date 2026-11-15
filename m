Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794733899;
	b=v1Dqnk+LfF3yUq3NbeZAS8TC4Xe2Al50ECjYuDRromVFiQR5h5/J80YJw4tkuvz+JH0x
	 zuznCQ8UVg1cvZ5qWOqoh8qF9Lio3G8TVsq8nCZgY2EZSA52lIC8OUdcgriKuHdX8h+/B
	 +8M/lp+rHUDpXAermFmcu6r0hZEneIIwnWfa/A5pdWjoWlFxeeYuGBNeXrrTzAZ5JdWXc
	 Uz2kxrLffujEo+A4IrLw8aodtb6f8/aZgSSx0FF16LN+8eeb980i2rfWH6WDRBoSepEZE
	 U0LA4kjJajyKxTWrGnuDH4lWOpaEey7RhB2OdGLrhGSLA3JuHmf4siLpynzbDgKaeWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794733899;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=wcWcH7tJyixpCkmaYR6T6VjPcinuyJPX3UgBgsh3a94=;
	b=ozTvje2Gn6CAfj7TTMDHdp4zV/J9qpSpfFJWefSQNhNIahtDt+6IIPgM2A1s1NvTfBxm
	 wksQxiskXi1ezUkIq5MiCd1jtNE14BJBDg4kHoqMXqajmTAx8uldwXl/vY+JKlpPXv4aG
	 ii6ONqZw9HplasD6P9s/WiWzn7xtb7XyH5oAfoEdiH7DYQStpr+oK1r9C58utecv62BS8
	 asMVwpdK7xLBRT+OAssQWP/S+feQ+zTDtTBzSUXJeTergXOdC2bQubPMccLFnrRSD2I/L
	 j016gd0VBQrC9kOKN8X9GH1bsyTR61GAb1266vLlHlfAHKpy0G42X35OkF/ZQOLLbvg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=a2A9FU46;
	arc=none smtp.remote-ip=209.85.218.51
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B0C606A881
	for <linux-iio@vger.kernel.org>; Sun, 15 Nov 2026 09:11:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 99B0C606A881
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=a2A9FU46
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c50d3ac6b51so27168466b.1
        for <linux-iio@vger.kernel.org>; Sun, 15 Nov 2026 01:11:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794733898; x=1795338698; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wcWcH7tJyixpCkmaYR6T6VjPcinuyJPX3UgBgsh3a94=;
        b=a2A9FU46G+YiztCbvxrFji+SXnIeWoZe5W8H+k3kUQ/qCHq4YhLKHZwlVzkXq8280U
         IzF0NuXMD5lXnmObxGmcMI/x/hCT6srMphYqu+k0ksoKEa3JysO06aYhsnEpihXcxEUV
         AG49snclUtE0sPUtYP16iCpRIs8IrDC4UHZYC0mn/4ctNphzJFHeww94U77LCOqWH8vZ
         UwKMOem6ay7imGpw+AVFsZlHetX1a8Hv+s5JcrUsWOfXhjhtJJIG2biWL/wpuwnEEfEy
         xHXbp0GkHCWddGBgMnnFLhS3zfkyxUMI19a9qoGAgqFcp7Wyl426+sP5BPywD7QUYaVp
         okRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794733898; x=1795338698;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wcWcH7tJyixpCkmaYR6T6VjPcinuyJPX3UgBgsh3a94=;
        b=B3/eQ+08spoQ4iow5I1fE9Bq4vfRJ5TjdQVeHph8tQEVoXtkfW204yN0IDla8XBgSv
         a++vC8aQZpwg9i6jrQEuCuRIzjmrtjAGlLSyFOjuAWPXA02NQvohkKvEoUVpHlAkH+7y
         i8HGvAxbnULsvWLBTey4AVUpeob1uzr2Lc+wFIHXgbgnqOPO/yWlbWerOT6ZXuHADxgo
         P+wSnpqVDfiz1XhefO7q+0Ld0EHittF8YQRe3beb7lgItyoOi0UWr9cyQPeUEfPqUT09
         gumFmQpuALKQNb0/f6fKdHla9UDr3+RnWY96D8zJztK0hWFklGEca9Ppv/IR+j3QTQFz
         KXFQ==
X-Forwarded-Encrypted: i=1; AL+hErFqSJBl2p/MEftVDlSpEj77zLiCyD8c1DZbZcP3+qcbg6ubPQySgk/mhz32RwmYc9Eka6oMgZD5+4k=@vger.kernel.org
X-Gm-Message-State: APuU4Z/ApeGfLfPHVq3dasRZWNW1gj0exsH/s8pXK45lUS0gvcnPXNmU
	aMf/uUQO7GentfjbqkWP8qLag/y0ZA8ay6jjG+inr7c7oZV8k9OfTX8A
X-Gm-Gg: AYBFou3Ei9c+vMTten+3ddNCGCaW5KA4j1Z4uRx4wPGwA7yRjMyCcTOGnkDfbbprbfI
	xPicfRgPtt5E+PimshD1Humztxmb5mIyK60ICVlUiJ+uzJm/EoLSvNXMoCZj4SJ62AUwirltQu5
	POyZl7N+VogD0QdVRhtRXZTDXwmOZu8W4BO849lvn/sx+1+Yz+qVtqxahQ82a8JWhleZRgEW0uZ
	a/YHVlfqrl3Dh+qISeG2Pc9YV4JaLwuMZfc6Ok6gF1rwKNavJ0rSRwJ7xQ2L3yxAZlkPorsDH0s
	zp4veWQ4O5JmzRjwR3nmJC1ruVrZeYJDn2In2odJ8ipjHhRM25DRCMDKF7Y142bh6GQhkY1FS9X
	lgInYujeMD9L/2ws8gYkFcX1W5Jw8Qp6d8mdktDGtNjhsvQokCw+k7rG+J4bKniY2lJiP4VzCRE
	YvuBTviv2+Mz8RkeQkJOOQFI/SGfFPTQhy4RQp4rIWWWsJ0i0Vm9FQWSMVIEKJtwoTjZZEWQevt
	rT++Rb5mDHZ2+kYbbxAU21AZibUXjdUIVvTCqfHgUuOUePDctaYAcfyJygAs7C/oFXCrlqTDAQH
	TxhAUlH6+ZPtz8Fp/Zstk8OWwx96LkgUMQ0zmtwfpsRnZfKGHYYddaq2DdMmRfsmj74sLp9HBrK
	TjquQNnhaYQ==
X-Received: by 2002:a17:907:3f8d:b0:c46:8b87:c212 with SMTP id a640c23a62f3a-c50963bba0cmr735412066b.20.1794733897981;
        Sun, 15 Nov 2026 01:11:37 -0800 (PST)
Received: from xeon ([188.163.112.62])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c5095b3dbaesm289392366b.32.2026.11.15.01.11.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2026 01:11:37 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Svyatoslav Ryhel <clamor95@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org,
	mfd@lists.linux.dev
Subject: [PATCH v2 4/4] mfd: max8907: Add ADC cell
Date: Sun, 15 Nov 2026 11:11:20 +0200
Message-ID: <20261115091120.108684-5-clamor95@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261115091120.108684-1-clamor95@gmail.com>
References: <20261115091120.108684-1-clamor95@gmail.com>
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

Add the ADC cell name to the list of MAX8907 cells.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/mfd/max8907.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mfd/max8907.c b/drivers/mfd/max8907.c
index 2aaea750d1690..2d94248011915 100644
--- a/drivers/mfd/max8907.c
+++ b/drivers/mfd/max8907.c
@@ -20,6 +20,7 @@
 #include <linux/slab.h>
 
 static const struct mfd_cell max8907_cells[] = {
+	{ .name = "max8907-adc", },
 	{ .name = "max8907-leds", },
 	{ .name = "max8907-regulator", },
 	{ .name = "max8907-rtc", },
-- 
2.53.0

