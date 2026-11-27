Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795782805;
	b=2E/CDofsyCi+Pa7f8gNXTxgNlXK6EF5CEzBwDg4msXquZWHL3tRTUHUQZz5dpeQEvq4I
	 cVQd5wmYtk2toK2QH3Y2CqNyHkM79L1tOYfNv7JCiVTtJfMDSUdEsQgxo5uhkuLzNOgNL
	 O5uukHk8iKqTYJQrlFaBgpHFTMp70AY6GZMktEUWLFvhxXVhqZGrh409svpwM5FFBs8Nj
	 ckw+phbJcFJxokS0FGBuBhr5KhmXSm+xCPfUPNMJIOVW44l47JQNpBIhv6MpnLnbsH3Zh
	 K6kqg5SbdE58zMO4+1W1/HOQVNqypgQAtgntdCobGBrrjbUvP5NZCNHPfwLJz4DrkcA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795782805;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=kZPMEzPJEBmK9RydLOqHgkqh2L3rwP0H3qPdw9k3biE=;
	b=CaTTbZ8lX8MgDhS4QoLcVWG0fVKDAv+qKx+ExCyBYMUY9rgvV8MFJSdNdMvPEjgRNu8p
	 kPVsy7yD/NtBdziJM4CS0wtw9mOJmWdt+sLDMJPEbUqcJSqczPw+Vy92WRVErcja5BGej
	 3R2fyXybU/cb2w2o+2x4awKj+dartXpp+XPaY22q63issQwXypYUQI2xZ2D7DOQnxhYmg
	 TZOrat/pmw8k6r0Sa51wHxVbbuIN8v0ADgaI8nWa8h4dWDRQ3W93nIdAhMiNnUpx6npTr
	 3ZW0NPtv1CDIcA7H9SLj+ks7QD+9aoj3329ZGFWRiryZv9Xd4GJiwjtw17sWIJbGqxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="k/yFTWby";
	arc=none smtp.remote-ip=209.85.210.179
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7615606A31E
	for <linux-iio@vger.kernel.org>; Fri, 27 Nov 2026 12:33:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A7615606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=k/yFTWby
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-8b904d10882so3358305b3a.0
        for <linux-iio@vger.kernel.org>; Fri, 27 Nov 2026 04:33:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795782804; x=1796387604; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kZPMEzPJEBmK9RydLOqHgkqh2L3rwP0H3qPdw9k3biE=;
        b=k/yFTWbyE+aL3rT9iWGD1X8+wyV86R1MyMo7ib984Zlrj5GsPgzKDthZ5pYf3jeoM3
         NWhF2S3qjS9lZ8HPlwQCscpr1S3an9ONx816Tnhv7a0inql79SmvnFkQN7A2oyliVIwE
         MI6VcJndloQuryHbQU6QInvXrvc0zm/IrMy0dgTZxr0Y6H5rdiGMj/0SL25sayOORDVi
         3ydz6iVM7VyebaWHk//8V8yMEAf0Z6q2vDW1fL+iqMoZLeOENNke1DjxzFYQBhaWoGZV
         948NJGBf16dI+pbySm/oCE5Wq600E22TY9FPtvvP29AJ0MERjetUCPg2z9YlkAnDfxSK
         m3QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795782804; x=1796387604;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kZPMEzPJEBmK9RydLOqHgkqh2L3rwP0H3qPdw9k3biE=;
        b=ZPyHmuNionz003pd4Vh97S/RieKVbiuI0gdu6blXAZ8yUyAoFyp3yJFxX5dWytJ07s
         QQ39vi56fEtZDFeSKxGbwBoQgFSD4stVcMJ6tZPQgTrqp3szQynrUt4sDm0ckCrY4GsC
         pB+YEMWWdsjpX+qkkgJ7pF4c6LyHWBIcuQyjtBPQUkqeVBJ1065yS46DCeejO33bANxQ
         7LZ/PK92mmawYCWWUpypJU8F8YS9wXmsNXWwXwWJkptdawswDCdPm/Q4upEXi37otrAk
         7JFks/ux3Ng57zsj7yVETN+vidk5LHOMfbrWpGAjIWGPY/epomr/gCtll+JmITlypL3i
         VR7g==
X-Forwarded-Encrypted: i=1; AL+hErEKaiSfKG0okXpKBuwwkivJCps9qtN9edeavoiTfmhiHMxBxT4OMXqOZBPkirE4wfN4qd1IBOm28cE=@vger.kernel.org
X-Gm-Message-State: APuU4Z/B8YWipWHkR4MeQRfbAJoLqCt9OLB+r9t/+KDIj83egMULvFjq
	ESXDBeuB07LNAGWqoo6Vcar/snCpxAbgdARm2b45m33F+Ij2iDjQnWyu
X-Gm-Gg: AZFdTZfGsCDtgkkVFaCsiWYNz4GR/iMfx+BWA+j4UqOxRDfaLGN/GVm66QkKjeFLPWP
	qMm3rCL9eFv8c3jZcWMhng4NFZ/UVRNC/StdrmASo/3d19DGYK/6eO/q5YTLVCs1RTVQ0MoSHcM
	Z41KqCbK7/W65zmH9yz3KDkewKjxnlTvXeUb1PcmAeYvJSpkbrjrfKdXgw2Y3BijfXbOC8FLmb0
	2gxfaoeYvTzWpqOXYoih2cWKEJ6TmtbpD9oUuPVZvL83Ahu/q8j1eqYvbIJtCDv7edKpo3gHFxT
	XhWd4WpexzTpw+g8i7ZY1LzUMBU5nq3qybofPr/yZh6I3sZWISs8QkZq/lNmFFdCmV+YXYQFhNH
	5xdVPAdPBlwx94inIAX63wlGS23so5ua5cW+sV2gLFrsez/epsBRWQfOT/AaUbKVrjWrfwqMrEQ
	pqbuWWjnKS9s/1DH77XMLZcwJwAwtS1iEShf7iGCvKLxXxio2Is163WjcEfYx0wme4LFxF0dxpz
	49Ga7Mhv06RLrWanBbaFWJBOX8EGaR3TkvI1SjgEZg+5fO6U9R7HtrsZeiF7u8v08smTywdUqXf
	8/KnWTvVPvx66Sycz05tvjXf9j08KaI+bdqsVE706R5cpwKYsfjHSP/dcHqyqqi3222FagM=
X-Received: by 2002:a05:6a00:2d06:b0:886:cae0:fb64 with SMTP id d2e1a72fcca58-8c87c85fbbfmr22361125b3a.31.1795782803987;
        Fri, 27 Nov 2026 04:33:23 -0800 (PST)
Received: from localhost ([2401:4900:1c2a:12da:3176:e694:92eb:c932])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c87077944bsm12568899b3a.2.2026.11.27.04.33.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 04:33:23 -0800 (PST)
From: Punnay Sharma <punnaysharma805@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux@analog.com,
	Punnay Sharma <punnaysharma805@gmail.com>
Subject: [PATCH 1/4] staging: iio: impedance-analyzer: ad5933: fix swapped real and imag data
Date: Fri, 27 Nov 2026 18:03:00 +0530
Message-ID: <20261127123303.144052-2-punnaysharma805@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261127123303.144052-1-punnaysharma805@gmail.com>
References: <20261127123303.144052-1-punnaysharma805@gmail.com>
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

With only in_voltage_real enabled, every buffer sample is the imag
value. With only in_voltage_imag enabled, every sample is the real
value. Nothing reports an error.

ad5933_work() picks the register to read with
test_bit(1, indio_dev->active_scan_mask). But real is scan index 0 and
imag is scan index 1. With only real enabled, bit 1 is clear, so the
driver reads AD5933_REG_IMAG_DATA (0x96). With only imag enabled, bit 1
is set, so it reads AD5933_REG_REAL_DATA (0x94). With both enabled, the
read starts at 0x94 and covers both registers, so that case works.

The driver tested bit 0 until the bitmap conversion in the commit
below changed it to bit 1.

Test bit 0 instead.

Fixes: 32b5eecab0f2 ("staging:iio: Switch the channel masks to bitmaps so as to allow for more channels.")
Cc: stable@vger.kernel.org
Signed-off-by: Punnay Sharma <punnaysharma805@gmail.com>
---

Notes:
    Tested in a virtme-ng VM with i2c-stub. I have no AD5933 hardware, so
    there is no real sweep and no real ADC data here. The stub holds 0x1234
    in REAL_DATA and 0x5678 in IMAG_DATA.
    
    Before: with only real enabled, the sample is 0x5678. With only imag
    enabled, it is 0x1234.
    
    After: only real gives 0x1234, and only imag gives 0x5678. Both enabled
    gives 0x1234 0x5678, before and after.

 drivers/staging/iio/impedance-analyzer/ad5933.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/iio/impedance-analyzer/ad5933.c b/drivers/staging/iio/impedance-analyzer/ad5933.c
index 51d73c5ab9a1..bd85cb37ca4b 100644
--- a/drivers/staging/iio/impedance-analyzer/ad5933.c
+++ b/drivers/staging/iio/impedance-analyzer/ad5933.c
@@ -624,7 +624,7 @@ static void ad5933_work(struct work_struct *work)
 		int scan_count = bitmap_weight(indio_dev->active_scan_mask,
 					       iio_get_masklength(indio_dev));
 		ret = ad5933_i2c_read(st->client,
-				      test_bit(1, indio_dev->active_scan_mask) ?
+				      test_bit(0, indio_dev->active_scan_mask) ?
 				      AD5933_REG_REAL_DATA : AD5933_REG_IMAG_DATA,
 				      scan_count * 2, (u8 *)buf);
 		if (ret)
-- 
2.56.0

