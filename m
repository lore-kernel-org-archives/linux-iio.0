Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE309392C25
	for <linux-iio@vger.kernel.org>; Sat, 27 Jun 2026 08:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782550404; cv=none; b=pbxCN2JxuxzEK/+VgN0xdVuw8bV/3cg0C0W3QLaxB23jnU6tOWokhKiBMZta6YQlhdFy6ak6HBLeCkI9hxZt98uda1DcHCkiIgI31ZkzzO2kCwGbX9WOtnFvnMtFEmGTLrtSpGZhFwrLpKN6G3fCuroRCY5rJ2oeNwrKG8Ejjqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782550404; c=relaxed/simple;
	bh=hz4rsOIiH2SH7OXId2Ii1orrFzniL4MivvLJdr4ysVA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=evYSiD5wlaqU62Y3bZWYD0xACfmh/O710VPaQ0o8rVywcsp7gptQk+x/dPKGQxW285NuFWCL3QsC+ObdW1q3Y3rpHuAjFYduOxl9ksTEApQdH+heGiG+PqyhwhVen7NhT07Qw1UUbEACgZEmfn7rIgap9uTM1e4xxkSeYFhW0WQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KdPkIldR; arc=none smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KdPkIldR"
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-1384ebe7a10so2865299c88.1
        for <linux-iio@vger.kernel.org>; Sat, 27 Jun 2026 01:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782550402; x=1783155202; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=50ge2bDBL0/GirPAj7jZ0yk4rxCXfu6duqZ1IrPQJoM=;
        b=KdPkIldR1z7GQBo8s1X11Kkw33pmg3Ex03zVj9iZPtKYsd7MuMHX1uVrJyIIOkyceJ
         YQyIaQoLYBtRK9RbSddcEadwRw1bMFGh4LwRxbpGoc7ZFgeFRS0VLHJmH7hfizgrqGV/
         LaKLg7dYLdyy0VrLVQq4SonPR0Ita5gOO+MDk/wt5jWp/SJKcw465KUu/HV+O+h6o30E
         jbtOVfG2dtnSuevG6bEYY6JgyEoFIOGIi9uSaK2hSnlj0AtJv2+cGRons2aY7kCLK7UI
         tplvTaQWzj738PD1dM8LWzZAgl5BRkGe/0OmaJKJ1nX00ev8Vog0f6khQ39xgX4+KjI7
         Mxxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782550402; x=1783155202;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=50ge2bDBL0/GirPAj7jZ0yk4rxCXfu6duqZ1IrPQJoM=;
        b=IFwUQYjlg7+trNuvDtMenI+gF9P8851sXEj6UQVBLOw0pjqsbdnV14qejhwGrtH5og
         Dl2qLDHSMwWZAseeFYca/RC3r5rPYi2MBN5224X24tYJQyVWx9LVSSmphp89LZQvNdgE
         5MdVgr4tsHENYWiL/ekoxmadtEwrHeTlok3YAl6yb9OnSzgTJyyJtn9es9qHhK571KEp
         y0oXtQiEbPtby6ANeWaWLooyx/dnSae96oGp5niJEgCT3zog2MPPGMMcFpXU0WmMz0kW
         LvH+kpaCaxxYu4i+k8juLIJtZfKSJOUUtoEIIvtLvIgH5THVO6I95naGaPbkvD+vw/Rf
         pWwg==
X-Forwarded-Encrypted: i=1; AHgh+Rp8/cyLUlQUK/rXuzrW6qCtqpRhcVRQBUJKzDOxPNxJaK5OlAm8MAmtsKOJcdbTEjFFf1/nWLZlN1I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4lW6c1TlFKXrkHfvs0mnm1PmCQUvFiT4PaknS2NSTeD8AXhqU
	S5ksIs1VIARJzdlBWcJdEL55uYS0m34Pk4Ek9dR+bO9oXeL5Wj1qfY7T
X-Gm-Gg: AfdE7ckuFNYNcf9PJ2ebNdyRj6zJTmMBqZCurOjEyba6cJmMthHoNM3Jf1h0au0dwq8
	gp5YnprqKjsHbS90QVptw65gfEbADCY7kdX/lFr8hhSOm/U7Q1HwyUpRB4Gds3vSpv7K9c4CtsH
	Ll1USstINCJmFO3b2kAQseshbNVLLhT4AyKnlkuCrMZ5FLuA+XM6tQLelK1OYUdGDHgrt5845oC
	q0bHsMRR0GD9PLPMgmMRThAbP0DZL3tUOC2Pg8b4boH2V3vfuADQeX/GNgI0orUxEcc1flvbjn+
	INVbTnBycSes/fMsr6sTyBMevoHU/LQGbXASuhR2Bzsl61JybUeazzpDlBww6tWL49iNLzHUU8R
	IjFcyKLLelNfZ6oFbQk2NlwFZ8nL9RZbSrDJ+a7b4gpbRFV7yYKCYuvHbB/IZ3rydP5nqm0iqYD
	Am0asvEWMGR45LrHPNMtO+ifvniH/oKp736TLWxoww8+35Rb8J+vrx/NNVnhidBaxPjEim4vXB6
	F2qosZYuc+3yg==
X-Received: by 2002:a05:7300:e828:b0:30b:f477:6619 with SMTP id 5a478bee46e88-30c84bd5d55mr8506058eec.15.1782550401701;
        Sat, 27 Jun 2026 01:53:21 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:1c17:d4b4:8861:e0a7:292d:b4d1])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c7c52d669sm26950479eec.11.2026.06.27.01.53.18
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 27 Jun 2026 01:53:21 -0700 (PDT)
From: Shardul Deshpande <iamsharduld@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shardul Deshpande <iamsharduld@gmail.com>
Subject: [PATCH v2] iio: light: veml6075: fix UV index reported at half value
Date: Sat, 27 Jun 2026 14:23:13 +0530
Message-ID: <20260627085313.7507-1-iamsharduld@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260626110400.68885-1-iamsharduld@gmail.com>
References: <20260626110400.68885-1-iamsharduld@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

veml6075_get_uvi_micro() normalises the UV index for the configured
integration time. The raw UVA/UVB counts scale linearly with the
integration time, so the responsivity-weighted sum must be divided by the
integration-time scale factor relative to the 50 ms base case (which is
returned undivided).

Per the VEML6075 datasheet the UV_IT field selects the integration time
as 50, 100, 200, 400 and 800 ms for field values 0..4, i.e.
(50 << int_index) ms: each step doubles the integration time and hence
the accumulated counts. The correct scale factor relative to the 50 ms
base is therefore 2^int_index == (1 << int_index). (See also the Vishay
application note "Designing the VEML6075 Into an Application" for the
UV-index responsivity calculation that these constants implement.)

The code instead divided by (2 << int_index) == 2^(int_index + 1), i.e.
twice the correct value, so the reported UV index was half of the true
value for every integration time except 50 ms. As the driver powers up
with VEML6075_IT_100_MS, the UV index was reported at half value out of
the box.

Divide by (1 << int_index) instead. int_index is already bounded to 0..4
by veml6075_read_int_time_index(), and (1 << 0) == 1 reproduces the
undivided 50 ms case, so the per-integration-time switch collapses to a
single expression.

Fixes: 3b82f43238ae ("iio: light: add VEML6075 UVA and UVB light sensor driver")
Cc: stable@vger.kernel.org
Signed-off-by: Shardul Deshpande <iamsharduld@gmail.com>
---
Changes in v2:
- Collapse the per-integration-time switch into a single divide now that
  all cases share the same expression -- int_index is bounded to 0..4 by
  veml6075_read_int_time_index() and (1 << 0) reproduces the 50 ms case.
  (Javier Carrasco)
- Add VEML6075 datasheet (UV_IT integration-time table) and application-
  note references for the integration-time scaling in the changelog.

Link to v1:
https://lore.kernel.org/linux-iio/20260626110400.68885-1-iamsharduld@gmail.com/

 drivers/iio/light/veml6075.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/light/veml6075.c b/drivers/iio/light/veml6075.c
index 59187244a..d0ec06eeb 100644
--- a/drivers/iio/light/veml6075.c
+++ b/drivers/iio/light/veml6075.c
@@ -237,17 +237,13 @@ static int veml6075_get_uvi_micro(struct veml6075_data *data, int uva_comp,
 	if (int_index < 0)
 		return int_index;
 
-	switch (int_index) {
-	case VEML6075_IT_50_MS:
-		return uvia_micro + uvib_micro;
-	case VEML6075_IT_100_MS:
-	case VEML6075_IT_200_MS:
-	case VEML6075_IT_400_MS:
-	case VEML6075_IT_800_MS:
-		return (uvia_micro + uvib_micro) / (2 << int_index);
-	default:
-		return -EINVAL;
-	}
+	/*
+	 * The raw counts scale linearly with the integration time, which
+	 * doubles at each step (50, 100, 200, 400, 800 ms == 50 << int_index
+	 * ms; int_index is bounded to 0..4 above). Normalise to the 50 ms
+	 * base by dividing by 2^int_index; (1 << 0) == 1 leaves 50 ms as-is.
+	 */
+	return (uvia_micro + uvib_micro) / (1 << int_index);
 }
 
 static int veml6075_read_uvi(struct veml6075_data *data, int *val, int *val2)
-- 
2.50.1 (Apple Git-155)

