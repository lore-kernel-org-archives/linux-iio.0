Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792627292;
	b=fcaJKAsXIY+sJ9JlfIUhAQPYM+mFCESwaD2QFM2ZPcC6n5vInyw0rTwAkg1EXjma2TLg
	 ZQZNnD/v+P3z4CJA00K5ZdwouUX+niAOCmnAHnmZLKQgggSLgb/vQwxofuUbxahqYpmXv
	 4I5Hvn9RZ152vL9TDLP9+6MZFzaWmAz530wj8FCNTUlgdywWsBGAFWfI7+2rB94BUEpow
	 pHutXJhWwA10b81kpI0ZrfyZYjZ0evVKbEeBQ0/LUcK84PngnvHiNUFGU+dt/jX31EGZC
	 u/gBXboK72xVO5LFsvtSTN9hN+h8KM8r9jSfuNQF+HoyMwH0pbUafmzm6gkfWlvH7rg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792627292;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=x/XHFLeuklX28g57VcXmkzvZarjLghDnz4MbxZ3DLl8=;
	b=1dGROpllC/X+rE0qtRJnsUQeKC7HZtT3pMI9xadhF09pA4GmcqFJ2cE9lxDhdQt1121e
	 UtsDXb3LR7Eu2ZRQJKKGm8je1gyNjGhcZgnexRMw+JV1smVSCXwa+9hyIB3+eBC4wacWM
	 cCaDyu9VvaAU8JGxDAwkB4BKedoqLm9Q34OHCBUP2D4zYYDoKd2p1/Ha8ZdNJpb9pqhuY
	 bF5X2qhA8fj8hjc4zLJNP8ZfS+GKp/njHSP/kgMrgROvX9apWTXCG+2cDnEw3Nwv6jwlZ
	 Puta8EMJ6U2HFOmC0cx0R0yOFJSAeZ6U50KevY9ZbzGNC/S4cMulS7Io9c3wwUDgwtA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=F+55gpLc;
	arc=none smtp.remote-ip=74.125.82.49
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19AEE60A3812
	for <linux-iio@vger.kernel.org>; Thu, 22 Oct 2026 00:01:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 19AEE60A3812
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=F+55gpLc
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-15dd124bbe7so2357116c88.1
        for <linux-iio@vger.kernel.org>; Wed, 21 Oct 2026 17:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1792627291; x=1793232091; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=x/XHFLeuklX28g57VcXmkzvZarjLghDnz4MbxZ3DLl8=;
        b=F+55gpLcgKIi59jDG/3y17J2mxJwaqdwqcW86tiRBV2JAs/BaAbfIOeFgAGyLUYzKH
         LIFB0gfg+W+YxjLa8c3aGFpPveB7TcYCc2z+T0FySZsflkSLkcIH4kmtcB1mbU+JbBIt
         tjJsT9HgE/HsItHIeujqomYP5BMBYSz5vhReA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792627291; x=1793232091;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=x/XHFLeuklX28g57VcXmkzvZarjLghDnz4MbxZ3DLl8=;
        b=kdoPsYv7p9pZc7oxb29aSyOcyRUkk0jh+GRoiSAoac4K9A96CIYFVA5BPz5qpFKtcv
         ztyEZzxvDJ3XKvs8d2skb3+zq9k4rx/P+Dtk7webkraWzUjuHph/su202gsId0eym111
         BPcjPLr42zAB/itiyaLLfP0D9CrSkojj4Lt8rInPKpiebfF0N+jCPHovd9SFBSMt+A00
         5i4ChEFWnCA7bMbO8vtM5naYSClhVF+ksmo2bjl0EoaDMWcpTZnkLLw+UU001DWHgI4w
         Rzyyl8agPIiRjaxh8bjUi1sU4PUvbTD1X4Fuq73iZg0HVflgXk7LP2vDq27gGbhvgDaA
         RsQQ==
X-Forwarded-Encrypted: i=1; AKwUvBxIkpjbT4Fjg7mp0c9A8NwDeZNkC2q5CDGx62WrstYch5EyTVZMXPOARQkvTWOalS7NIn5ncoQIs/8=@vger.kernel.org
X-Gm-Message-State: AFq9FYLcDNWI0GAx5994dB82jiWTVDRqtG/S6HA4CMlBe32BGa8KlhIo
	ZO8+int0gc45t/C1Bi6eFxo8wZgjHqI07oVfCUkZw1Od+q/HFLvcx/sFV9qFvgzFLQ==
X-Gm-Gg: AYBFou39b7sTC5maJ9qBfXqVT3JuKjmOXI2N1Hfn7Eej3V+gaO3wpk9hGBz2izWXOAE
	HcHjPPAJslb9WOxNyd+v82ykbvePXtTy2wckcy8wybqT0cXI3gJAutdT/llGhmRMo8u4f0LnSbY
	igdSqh4tCgoMuGfaTI2AgkFGt5FpSVVCn31dMeQU0OboJhsoOqwFryjyz66Jr+ZoVtmt/TgxJU9
	mc2JCmMhstS1q9r5ZC1rTKXD86t2BXkYBWL+UMv1G3h3SYdCdBGJDzfrpz9pjt9XIv8gqKvx3Qt
	avc1g6nf6j6yjYZ6idCrySDTr0HYOgOABZ+XfoYyvgsB8WQ6N0CObCjsnhVVcq942BxYCS7AZXA
	U+mGpSoiZBXBT497x0W3o67hRIwCRIEcPqqIZmlPQ0Rat3xlYA9hdJOF/CFXew2mbLaiRwel8jE
	omycdXK9GXfoy6YCN8qV/FQaiNpsS5/JcBk1xOVEvavGNdyd1yhn6cKm1AYQKo1aSQumXG4+0lW
	LkUWHsmaoWwaRSxPIgQ2Bo1METVnB0elq1RJrIozvjWlDN3ToAZ1lH2NsGUeR+z/gBkCxHMDGn4
	Zs1Hy/0L3PFnr3iYxFU=
X-Received: by 2002:a05:701b:4518:20b0:143:3617:c5ae with SMTP id a92af1059eb24-1909f5c8459mr4538483c88.2.1792627291054;
        Wed, 21 Oct 2026 17:01:31 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e7c:8:14ab:bfeb:ac88:458f])
        by smtp.gmail.com with UTF8SMTPSA id a92af1059eb24-1903a275026sm14432191c88.5.2026.10.21.17.01.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Oct 2026 17:01:30 -0700 (PDT)
From: Brian Norris <briannorris@chromium.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Ulf Hansson <ulfh@kernel.org>,
	linux-pm@vger.kernel.org,
	Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	linux-iio@vger.kernel.org,
	Brian Norris <briannorris@chromium.org>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 09/17] iio: hid-sensors: Discard pm_runtime_put_autosuspend() return values
Date: Wed, 21 Oct 2026 16:57:10 -0700
Message-ID: <20261021165858.v2.9.Idbac8a0f9ecdd345191130e256e8d881d991bfc7@changeid>
X-Mailer: git-send-email 2.56.0.218.g1ec904b173-goog
In-Reply-To: <20261021235818.3059519-1-briannorris@chromium.org>
References: <20261021235818.3059519-1-briannorris@chromium.org>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The hid-sensors driver propagates the return value of
pm_runtime_put_autosuspend(), which is not particularly useful.

Returning an error code from pm_runtime_put_autosuspend() merely means
that it has not queued up a timer or work item to check whether or not
the device can be suspended and there are many perfectly valid
situations in which that can happen, like after writing "on" to the
device's runtime PM "control" attribute in sysfs for one example.

For this reason, modify this driver to simply discard the
pm_runtime_put_autosuspend() return value.

This will facilitate a planned change of the
pm_runtime_put_autosuspend() return type to void in the future, similar
to commit 3afd8df02433 ("PM: runtime: Change pm_runtime_put() return
type to void").

Signed-off-by: Brian Norris <briannorris@chromium.org>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
---

Changes in v2:
 * Split iio patch into per-driver patches

 .../iio/common/hid-sensors/hid-sensor-trigger.c    | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
index 60808e2430ca..d76a6d9f04f6 100644
--- a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
+++ b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
@@ -154,21 +154,17 @@ int hid_sensor_power_state(struct hid_sensor_common *st, bool state)
 {
 
 #ifdef CONFIG_PM
-	int ret;
-
 	if (atomic_add_unless(&st->runtime_pm_enable, 1, 1))
 		pm_runtime_enable(&st->pdev->dev);
 
 	if (state) {
 		atomic_inc(&st->user_requested_state);
-		ret = pm_runtime_resume_and_get(&st->pdev->dev);
-	} else {
-		atomic_dec(&st->user_requested_state);
-		pm_runtime_use_autosuspend(&st->pdev->dev);
-		ret = pm_runtime_put_autosuspend(&st->pdev->dev);
+		return pm_runtime_resume_and_get(&st->pdev->dev);
 	}
-	if (ret < 0)
-		return ret;
+
+	atomic_dec(&st->user_requested_state);
+	pm_runtime_use_autosuspend(&st->pdev->dev);
+	pm_runtime_put_autosuspend(&st->pdev->dev);
 
 	return 0;
 #else
-- 
2.56.0.218.g1ec904b173-goog

