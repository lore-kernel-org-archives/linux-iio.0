Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2115F569F0E
	for <linux-iio@vger.kernel.org>; Wed, 14 Oct 2026 17:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791999470; cv=none; b=jU3JPteeEgeVXU30xJ5kP91IKBBjhX7FFKMtPHm6AD2MJHzL791tyqcnJ4Rtxp4vz1O12M3Ugov1qNZaZM7EDi73vtKLBdperLzSZf+UaMPNt16I+IxSVscKUlu33Bix+ThyEf+NxRy4kjfr8too/trOqmx0HaskSleYoBLsclk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791999470; c=relaxed/simple;
	bh=tdlRIBPqud+ZhHQo4q4pnSx+uKMSRqHTAuSs1iG0fRo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=AiG8QTmfV50QaI3jPmLbyAZUv/u3xhoOz17S8gFYcUdyrb5UAR6UBXsoQTHhSNbYy4tGhsITrtz6BeBpKGU9cyiOZ0DIeYKgfbXLGOM8TE6rMuPr5mMD/rKfQc0gW3aYUaEcdIt0iRZ98FviBmW1EX6hlwia4LY8lSNrNfEF5ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FpfsMsSM; arc=none smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FpfsMsSM"
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-353804b591eso7756141eec.0
        for <linux-iio@vger.kernel.org>; Wed, 14 Oct 2026 10:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791999462; x=1792604262; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=jiGXiZIuMeD+fd3PiQCqnKfyIvL4Mb1E4TW6EqOHmI4=;
        b=FpfsMsSMosBNqQ3Ssee+8b82uoByJ5wLWxsuDXHskeHz6JJgndJqYvEz3gGtIoMiFP
         caLVzNOGqT9sIRqbwSxx+1prbkxL+/mrE289br59x5n9CbdfQuawE+Yxoi7sTprK5LUJ
         JFkZTBtbDCW/WxGJZkKna3Dzln6MKddig+QAtDDq0S1EKjpf/+fOUinlFJPF07gO0tO1
         gfNURgBknB83O8QZ5+ewXmiNlQiFU/fZCewHQZM8MOMlg5MoPohNO5q0GtTUiDAm8bPu
         P8XGnRN+flibBqzBv65rtL7wnZiwJbOKVP7ryQTmkU+s08TqTruHdfiRTwiCvfuGSZe1
         aHeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791999462; x=1792604262;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=jiGXiZIuMeD+fd3PiQCqnKfyIvL4Mb1E4TW6EqOHmI4=;
        b=dyG8UjfumNduLmOhj3SX3pV5THJ6Q7bzTv1qlbtxmUM6A46LiJupPSBxPEEIpxrcTZ
         40kF6Hl61v2utbifC9MOCAJwrOCid7NnGUctWUmZ4/cn7+/z2kNYvqGA6d6r93mUau2f
         v4rhvLrKPxWmY84zEmvKf/B+bPGHVZBYQmempjovunbpR9UgoMi2HU83nj2F2QWW/4kK
         hrP+W1/r3yFuFVIKX+tMZ6amDrLJhewuLN4os6Jr1fXf9txzsnEpiVp1ObmMxXAC5a2J
         y/Qgp4Zaz3wYykcUVcOfJQkjgGECE9mXHRiy5QsRiCQet7EHvISbbarL+cOjvkkojNt1
         EYpA==
X-Gm-Message-State: AFq9FYI+ASGEjg+iGwy/Vx5UTTp9eAcYbH71Kh8ySGZ5QVIgKGw9DOfy
	QoOZDpnqhWh7c8dvYwRhW+GUcaXGsht+xI5ZuzTxtzkK8WdiTWrYbxTtxH5EHYlN
X-Gm-Gg: AYBFou0WYlGoQl/rV2+7SPfNnj0CrjmIjJymqPl4E5UKebUtrcCYkpoSVPMUHWtcEeK
	+JID6DpLAFHIOiTSRg8gMvuPw/D65dH3oBANyqqBxfxGuot3AKi7IjvYXdTMRfVGM8v0NRs4nb7
	39+xyTBdAWs4voLthrdAGmTd4aFrCR3ndYqpOEQDteTryUqgjwm1QogPt9xo1aFgLL4wA56Ta5M
	fE5hBN4A43/qfCl2CrFgCTCswpxYk9K8MrLgCEKeGfQSb1cHc/hMmJ1qxrRZyFmaTtDCm+EIc1O
	erISvJMXtWvwAfubBDX2f4+CTv0NjX4gEeGjmAqP5FpVa8ssN8Xdnic6JGAAUcPwyoz+sT5Odhr
	5rxp/o771GM5DvaqEs7blngPsr6ljj8ZWA+1ZmHPLhpWOb/GIvavOYFYJV6St8ZYc+XVvXwMo+T
	IEys8P339fPlJZBJkvYXFkLBlYSehZXcbE0aFM9auDumyr5S/lxA6J2hBgI1zpi4AymsxfZ8Kt
X-Received: by 2002:a05:7300:7301:b0:351:2a18:c172 with SMTP id 5a478bee46e88-3537e0866b3mr29042179eec.15.1791999461798;
        Wed, 14 Oct 2026 10:37:41 -0700 (PDT)
Received: from [127.0.1.1] ([2405:201:201e:816f:c447:39f8:9b8a:fbce])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537c841648sm61523451eec.3.2026.10.14.10.37.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 10:37:41 -0700 (PDT)
From: Viral Patel <viral8854@gmail.com>
Date: Wed, 14 Oct 2026 23:07:36 +0530
Subject: [PATCH] iio: magnetometer: tlv493d: fix magnetic field scale
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261014-tlv493d-scale-fix-v1-1-69a722176c06@gmail.com>
X-B4-Tracking: v=1; b=H4sIAN+9z2oC/x2MWwqAIBAAryL73YLag+oq0YflVgtRoSFBePeWP
 mdg5oVIgSlCr14IlDjyeQiYQsG8uWMlZC8MVtvGaFPhvaeqKz3G2e2ECz9YOz215VRbbx1IdwU
 S/T+HMecP4WnipGMAAAA=
To: Dixit Parmar <dixitparmar19@gmail.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jonathan Cameron <jic23@kernel.org>, Viral Patel <viral8854@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791999457; l=1696;
 i=viral8854@gmail.com; s=20261014; h=from:subject:message-id;
 bh=tdlRIBPqud+ZhHQo4q4pnSx+uKMSRqHTAuSs1iG0fRo=;
 b=7YiJVZ7Ah4Y0W9OkYus8X2I16UgRiHjLD0enDJfXvjxjuzrxx07oJcKtJK1kqiILlFg+Y6I6N
 h05luhL9tXuBUH1Mpv8aq9kPj52gbpuDienauv/eq4w9A1EEIkJaHQe
X-Developer-Key: i=viral8854@gmail.com; a=ed25519;
 pk=UC+UDB53t70pTK4wncXf3tfh0hsYMCqpxYnTaKX3MYA=

The TLV493D-A1B6 datasheet specifies a magnetic resolution of
98 uT/LSB (0.098 mT/LSB). IIO reports magnetic field in Gauss
(1 mT = 10 G), so the scale should be 0.98 G/LSB.

The driver currently reports 98/1000 = 0.098 G/LSB, which
under-reports the magnetic field by a factor of 10. The comment
also gives the resolution as 0.0098 mT (9.8 uT), mixing up units.

Correct the scale value and the comment.

Fixes: 106511d280c7 ("iio: magnetometer: add support for Infineon TLV493D 3D Magentic sensor")
Signed-off-by: Viral Patel <viral8854@gmail.com>
---
Found while comparing this driver against the TLE493D-W2B6 register
map for a new driver I am working on. Compile-tested only; I do not
have TLV493D-A1B6 hardware.
---
 drivers/iio/magnetometer/tlv493d.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/magnetometer/tlv493d.c b/drivers/iio/magnetometer/tlv493d.c
index 03415cc2c9b3..234e3ce63ff7 100644
--- a/drivers/iio/magnetometer/tlv493d.c
+++ b/drivers/iio/magnetometer/tlv493d.c
@@ -299,11 +299,11 @@ static int tlv493d_read_raw(struct iio_dev *indio_dev,
 		switch (chan->type) {
 		case IIO_MAGN:
 			/*
-			 * Magnetic field scale: 0.0098 mTesla (i.e. 9.8 µT)
-			 * Magnetic field in Gauss: mT * 10 = 0.098.
+			 * Magnetic field scale: 0.098 mTesla (i.e. 98 µT) per LSB.
+			 * In Gauss (1 mT = 10 G): 0.98 G per LSB.
 			 */
 			*val = 98;
-			*val2 = 1000;
+			*val2 = 100;
 			return IIO_VAL_FRACTIONAL;
 		case IIO_TEMP:
 			/*

---
base-commit: ceb05f22e5cdc3f8bd3f7d5dcfc57843942191dd
change-id: 20261014-tlv493d-scale-fix-5a0b83b52d2a

Best regards,
-- 
Viral Patel <viral8854@gmail.com>

