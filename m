Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794722455;
	b=UmO0+ZF44UG2vS8T0EbXzdcQNH/kdSZQ8MnYgcmofpOh1KbRlF7gqoNxqo/WazTLkvVg
	 P7KMauZmLlVS5+eT35DxetvOFgZxsaWzmrAQoxEPGJFficoUTRibV3OdI79MiNLnRsq0R
	 FHCbTpsq6K5ku+zC51LmjgsdgL0flAjbwwMneLBY+zf/hT7kJ51/q516Bhs3naFj2J46u
	 C21r8O1m1wUfTK8BQBI6UNpbbB0EEr7Ccq3nFIDT/C8ib00/P2MTawnnuou7mDXl24JSA
	 9mxdQ/QMN6Bf07gIy4Yf6GOFyi0DTMmGtZsYBjrJhdimNKIcsC16JvYbOR46fnAK6hw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794722455;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=Rcm6PBzt77uXg2O98RKrxcPu8z5TvEZJQp1zVdZlUEo=;
	b=pUwimG/AmKunrhPKLSgNT+kJ325Ke7yetj3Z0mWcd0kzfEWLWz4iB9qOOCXtVo1CVNvd
	 ncSOLyMyMNmEQtUwtnt+uD0YHeMEMeHxhOhv6lvHLwNuqg8MW0gsWmM7rg7T4gbj2oHdq
	 wvUvTm0Z9x+4teedMjI3U6eKhi+xPKKBxLQaYAGREGRW3XJeD9mF4vN7iHSQts5xJnMy+
	 EaZr7Pxh/BLjnY8h2w8R7vOZ7JDNG9jTIm3fEzrgf2qgxbVcVvskGO1ALwYi3tlLdqHX3
	 pGv5Hm0PEeW/xfV2tNmsdwoCw0Z3+Q0dzbJiQilPGMtMIh2ZqIH+2CiD2N62tFhHYzA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ztduLjMY;
	arc=none smtp.remote-ip=209.85.216.49
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A224C606A327
	for <linux-iio@vger.kernel.org>; Sun, 15 Nov 2026 06:00:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A224C606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ztduLjMY
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3b0b3754f57so1687514a91.0
        for <linux-iio@vger.kernel.org>; Sat, 14 Nov 2026 22:00:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794722454; x=1795327254; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Rcm6PBzt77uXg2O98RKrxcPu8z5TvEZJQp1zVdZlUEo=;
        b=ztduLjMYjjrlv1t9WyJo0gCOo/zoZH09sQ6ohfjVVRJRuzIZrcVujYHjxI1bFjIY2H
         C2ZqJPGnsBSAh93qK6zPM901yi8Ba9SV31t1hXEjXbY+9SxXEkMIhDLgYEFFHYGS3T5O
         wnpFgzkFbR2bu6wyWmecoySXeUVwdGDiA/4H+lGYpsYffLUYAYeDdSCsky1NWa6KxSdb
         5B0doqf+bti9rIfkHv0fCJKHtOWT4sSViZrWzJbirgB5GpM8+57whyMJD+S/cKtc3QAg
         TNR/bGvsvKDg79FEW7xRF3n1E8R8PQoVBjWRdfw/M0Vcm4KwxGX9eIbhvp4aXHo5VQ5p
         Q/1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794722454; x=1795327254;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Rcm6PBzt77uXg2O98RKrxcPu8z5TvEZJQp1zVdZlUEo=;
        b=nQw6ewTxAiKUMLeIGOY/SWHMFpD6ry4Y6M0G0y07gVViSR29ODGdRRBGV72nDYDa5O
         nBar7Ry1miMbuqEoGLLJHDQjVcXL4ZkaxWEmwePGNfKYfhckdN6dpyZrvIjRSKPgKX+0
         9bMaYSjcnDipF/+DPAe+9N4z8M2l2DNubKFeJekmW+qfLGak76GQjnNtSdym0YHQquH3
         gEK2DurWnS57pp3SjgVDYeoBy9SXvV+VnnGUR0j6XYfhpX7LDVQN4NC4gC9ihLr2xyzp
         Sr12NT/biZ7nwH9WJR4Qhlpxry/7EB+ufMfXTECMxmQTVYEJQ50/eukEgZtp2Wy3ALPP
         rG5Q==
X-Gm-Message-State: APuU4Z9b69i5BaNAoPK9S7SHUaLRbrq+UsH9TNNz5fTO6wcz4ah7jGcX
	r0ek+RQi3WZ9GlB8fCW0+ktW9z4RUhMSn+jBEPEtRbQ6EzTO9SToOb5378I+8g==
X-Gm-Gg: AYBFou36T3ojCpc9TDlyimNXwgGNltNxwKoNH3dGiHk0ENrz3Qig1Lugu+F+LwIa13O
	1VjT498ZfTS088eV6gjSXbSg3zpWUBwTLuhEwOHBXOKgxmskIxF7fEMi1wExSMDKk/VqiTM9aq4
	sr6r2rOtH8BWJo/JnF8KBSm8a5JzNp9aiMS6CV5kkdmUfIZvjh6Xe+UhSNgAsK8A340Ia8C0eT3
	z6z6qQURwhgrydR1lKdVrWIgK8kDiNCdW0bd3few3aME4cK+efUpXlZG6YhoJGcoBQivR+m6acZ
	sWYwbDh4+zi1P4Ah0re4y5TxYhhfEcY8e8dkkJNQG2u0BhNRd49NArMdl3tm8fn2J05kv9wc/3m
	B6bZLsJky485Z9AAKsgvhNRboGxzRsYIU7uT0KrVyNT4yZ/CBw2rKLn2z71g03x8TA1/am4qgzW
	PgCIj9MrudHv9Fo08ehjy9ev9fKIm3fQ1gRS62h1TnGqEayEmPWUjm9Hf7fNaH/3Xs0YHXHHIqj
	o3MVcrOj+Qk/g/wv2WpfEYez6CIMo2yZtswmIaydmiSIqBBAKcSbma+CR0NB81TUVfJHDUZirmz
	T6vbqJfUUMF3bjPJpWRC4wgw+oBR6g/dQ2WhCz5vMhBvpzlXoLTE0YOVoR4I583V9at5/DlwQNy
	+GFGwS/4jp3KVkQX+BITYrQ==
X-Received: by 2002:a17:90b:1d45:b0:3a8:c0cd:57f3 with SMTP id 98e67ed59e1d1-3b1b09f3aeemr6901341a91.18.1794722454050;
        Sat, 14 Nov 2026 22:00:54 -0800 (PST)
Received: from not-op-Victus-by-HP-Gaming-Laptop-15-fb3xxx ([2001:4490:48e1:a6d:b698:9913:39f1:6954])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1aec43699sm10988889a91.10.2026.11.14.22.00.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 22:00:53 -0800 (PST)
From: Akshat Chandra <notmissinge@gmail.com>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	andy@kernel.org,
	Lukasz Kulga <lukasz.kulga@gmail.com>
Subject: [PATCH v2 0/2] iio: chemical: add support for SGP41 sensor
Date: Sun, 15 Nov 2026 11:29:38 +0530
Message-ID: <20261115055941.362185-1-notmissinge@gmail.com>
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

The SGP41 is a gas sensor used for air quality monitoring by sensing
VOC and NOx.

This driver follows the approach of exposing raw resistance values to userspace, where the gas-index algorithm can
be applied.

Temperature and relative humidity compensation are supported and can
be configured through the driver's IIO attributes.

The SGP41 is similar to the existing SGP40, but requires its own driver
for the following reasons:

- It has a dedicated conditioning command that must be performed before
  raw measurements.
- A measurement returns a 6-byte response containing two raw tick
  values, each with its own CRC, rather than the SGP40's single value.
- It supports both VOC and NOx measurements and requires the heater to
  be powered off after use.

The series consists of two patches:

  1/2: dt-bindings: iio: chemical: Add Sensirion SGP41 binding
       Add a dedicated Device Tree binding, including the VDD supply.
  2/2: iio: chemical: Add support for Sensirion SGP41
       Add the IIO driver for the sensor.

Changes in v2:
- Split the binding and driver into separate patches.
- Add a dedicated Device Tree binding documenting the VDD supply.
- Update the driver and patch descriptions following review feedback.
- Fixed some issues in driver.

v1: https://patchew.org/linux/20260831151235.64076-1-notmissinge%40gmail.com/

Signed-off-by: Akshat Chandra <notmissinge@gmail.com>
