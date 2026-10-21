Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792627282;
	b=Gjmrtqy9rvDB/pUqRVrmjtW1JH+1rgr9aSCEDTGlEO5Nxz6qM/at0PwQKG2keVOA8qb+
	 VZbupxdGC7gqoY+zyfjXlEob8IzRfCGJJUxpOGWVb12uwQ6VYbxUBkTAsC7f0KU/0cps7
	 mtF1cWsZNlkuoXCjNlYNH1+hLz8pnJY1/c/lbiLnu7TyTgiUJrVCBwtmbVu7zG+7bFDbG
	 Ej0WwTRyYS/Ddjlucx8seTn2rnD6YMLiwtY3UrmW29IRBUX8urFkcNsgguvSemq7AfLgH
	 wwOPrGaOZQGMfhhw+16sWdb9ESpu7ttvX0vRJABnIn32mk6sHbS2OV0efbINi9+PDmg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792627282;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=QhFY06BE5+5Ny++OsMlUpBWCJIit6t0dr+PR4S2GFPQ=;
	b=b/poNvFHXfR0MIw1nTMv17t57H15+dXCZ6fJsAPiEVWpsBa3Tj2JSgXL1BlGvwv0zVuC
	 3O+bfUrkQSXiuiG8qZoDs0vRt+sbsvnRi/klNWeSwGTSepiNhUVgFnoxcm6Y7EtNbzurX
	 PRNkr3ywwQtdruG1oBLSxMmjoS41DEESZ3ggmefRWAk51cpn4Yf6FfWlNTCEiij99SMaa
	 qNf/G6ML+LC7M5j61YFSixYMgQkh1t8zP/iZ2RtrsW8WO5lUjonryvb1oNKP7emyNz72l
	 /pDoNEE4GdvGAihiRaTnjXqu9NcQKFZXNv65xfCLdkKhHv/alSJ3esZmzxxVc/A/4mA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=mHDJQO7R;
	arc=none smtp.remote-ip=74.125.82.176
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA5A60A2612
	for <linux-iio@vger.kernel.org>; Thu, 22 Oct 2026 00:01:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3DA5A60A2612
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=mHDJQO7R
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-3535a54bed9so1800908eec.1
        for <linux-iio@vger.kernel.org>; Wed, 21 Oct 2026 17:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1792627281; x=1793232081; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QhFY06BE5+5Ny++OsMlUpBWCJIit6t0dr+PR4S2GFPQ=;
        b=mHDJQO7RHSt8C0nb9o9/P45YFrQ1u2ObK225d5PFwb5QNfM4xlE+GGtv0JoPBXuB34
         ECuaEzjJI13qpryHWfPrRyJVVa2l2nJoXe1xZqMOX7A9A3+01CPCv16KrOykup3V4MbK
         RNZ/MpnN9sSljSGHlKVFMNor1VaBXPQ5hVFrg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792627281; x=1793232081;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QhFY06BE5+5Ny++OsMlUpBWCJIit6t0dr+PR4S2GFPQ=;
        b=wobRnAIzOeSnufzlKJO5x+DHosWXLl/ottG15f6EtI08wrDckq/XFjl+Fhe0JW5siV
         50cV/VL8HxQaabava4zEPMW96BVMaBi49qvfl2vcdOWtbc+6160NJoCUBENIHDNqedkh
         ULAV89M1ic3FWelUf8MBbQ8tTVxZh2dzW2g0EUe3rqoX/mfny3JoNq3Hv7IK/DA6EuoC
         wPrl8daVr8Ff6SHm4521sFJQ+m1FE4FV8UFAuI/GjjnGiZ1Bf7RWF1GhUTUs8kSeO4QC
         sEPDApxJ2+MJZ+wuvxR9TkcTIzC2uSfje39hNK8RzmppzIOHoET+DfYfxkHSdVEC3xoE
         5eLg==
X-Forwarded-Encrypted: i=1; AKwUvBx0pnjvrSSChIDz+iCLt7zeTed2fe0te0s6BnlufrcxMxz/ZA2jXyEGJTCrvGu77wfKKLLT0SrQC/o=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ+1zswp2jY2GjiYOEIgdddOHXOQsKjNHNacL2zSxF9aqfVRZfm
	nqln57I5hLxKEIpYtPnezC9igEAuMo0uV6Uco0p7J37sTPokXksZLA5QjozZquOvrqjraz6vQp1
	vbX0=
X-Gm-Gg: AYBFou1zX+22P7jWwhncUKms1FCwAceurEpYmGhZE8BlXFsCE/tO8VVaqCgXOhPEnuL
	9jqWQ0nciUNbGLBwo+guqu3x7fJqAHp9YGwRJ3JGoa5+EmWzir+6NoT897b+KpwBU4PMUhXTABu
	98SmjnqAuqXh2reX9fkcn7hgacL6XN3+GruDA6jXLyD8rrWIZ8EHo8HkaGzfI9UG1glzC48fvO9
	VSdNDGuAAiyxADmm9x1Tilcf6wlA1KjhCHFeQ/8DGLebgK5agWtEMXbUQJrVKLiUJQCV3YGorHQ
	1aGnfQYPAVOXnGIhYwvTMZCI0zTZBm3VXA7YUtvK+Ip/lLMNpA9es6/hm8aQ1JcnxYNpJ6drxh9
	ouirJupOVfFwqbO4qSubc77Tcsrkm4h3dNo/DO1M0USEN1Prd5h+ZnITcY829qdYmSeJ9/kR2vU
	ZQEWx5rzV2JVrJ3tjEj5xMlPvF4E0Ob916G/7eRaOq2ucWUW/cVgiGZ2mwo3hQ1JH6aqAJcbK7Z
	eJTMuB/n5huBFeDx9aZWV55l+bXNk74aHGwXPZzWAfRwtUrmO4ezEYP2/PduQvrsT4mLXpq4/ZW
	bVnJkmEDByKnS8Ac7/g=
X-Received: by 2002:a05:693c:8399:10b0:35e:f1a5:9ba6 with SMTP id 5a478bee46e88-3674a40738emr5533249eec.5.1792627281152;
        Wed, 21 Oct 2026 17:01:21 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e7c:8:14ab:bfeb:ac88:458f])
        by smtp.gmail.com with UTF8SMTPSA id 5a478bee46e88-3674198f1d8sm15879233eec.24.2026.10.21.17.01.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Oct 2026 17:01:20 -0700 (PDT)
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
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 05/17] iio: accel: bmc150: Discard pm_runtime_put_autosuspend() return values
Date: Wed, 21 Oct 2026 16:57:06 -0700
Message-ID: <20261021165858.v2.5.Ib5830d24f9dc7f06103c568f53134ecb7825ca4f@changeid>
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

This driver propagates the return value of pm_runtime_put_autosuspend(),
which is not particularly useful.

Returning an error code from pm_runtime_put_autosuspend() merely means
that it has not queued up a timer or work item to check whether or not
the device can be suspended and there are many perfectly valid
situations in which that can happen, like after writing "on" to the
device's runtime PM "control" attribute in sysfs for one example.

For this reason, modify this driver to simply discard the
pm_runtime_put_autosuspend() return value, and inline the pm_runtime
helper, now that it behaves the same with and without CONFIG_PM.

While at it, I notice that bmc150_accel_set_interrupt() mismanages the
reference counts. It should only drop a reference after it's done
touching the hardware in question. Adjust the local &intr->users
reference count alongside the error handling too, to ensure proper
balance.

This will facilitate a planned change of the
pm_runtime_put_autosuspend() return type to void in the future, similar
to commit 3afd8df02433 ("PM: runtime: Change pm_runtime_put() return
type to void").

Signed-off-by: Brian Norris <briannorris@chromium.org>
---

Changes in v2:
 * Split iio patch into per-driver patches
 * Inlining
 * Refcount ordering

 drivers/iio/accel/bmc150-accel-core.c | 75 +++++++++++----------------
 1 file changed, 31 insertions(+), 44 deletions(-)

diff --git a/drivers/iio/accel/bmc150-accel-core.c b/drivers/iio/accel/bmc150-accel-core.c
index 46bb36d9366e..9ad6429fb584 100644
--- a/drivers/iio/accel/bmc150-accel-core.c
+++ b/drivers/iio/accel/bmc150-accel-core.c
@@ -326,29 +326,6 @@ static int bmc150_accel_get_startup_times(struct bmc150_accel_data *data)
 
 	return BMC150_ACCEL_MAX_STARTUP_TIME_MS;
 }
-
-static int bmc150_accel_set_power_state(struct bmc150_accel_data *data, bool on)
-{
-	struct device *dev = regmap_get_device(data->regmap);
-	int ret;
-
-	if (on)
-		ret = pm_runtime_resume_and_get(dev);
-	else
-		ret = pm_runtime_put_autosuspend(dev);
-	if (ret < 0) {
-		dev_err(dev,
-			"Failed: %s for %d\n", __func__, on);
-		return ret;
-	}
-
-	return 0;
-}
-#else
-static int bmc150_accel_set_power_state(struct bmc150_accel_data *data, bool on)
-{
-	return 0;
-}
 #endif
 
 #ifdef CONFIG_ACPI
@@ -530,24 +507,18 @@ static int bmc150_accel_set_interrupt(struct bmc150_accel_data *data, int i,
 	if (state) {
 		if (atomic_inc_return(&intr->users) > 1)
 			return 0;
+
+		ret = pm_runtime_resume_and_get(dev);
+		if (ret < 0) {
+			dev_err(dev, "failed to resume: %d\n", ret);
+			atomic_dec(&intr->users);
+			return ret;
+		}
 	} else {
 		if (atomic_dec_return(&intr->users) > 0)
 			return 0;
 	}
 
-	/*
-	 * We will expect the enable and disable to do operation in reverse
-	 * order. This will happen here anyway, as our resume operation uses
-	 * sync mode runtime pm calls. The suspend operation will be delayed
-	 * by autosuspend delay.
-	 * So the disable operation will still happen in reverse order of
-	 * enable operation. When runtime pm is disabled the mode is always on,
-	 * so sequence doesn't matter.
-	 */
-	ret = bmc150_accel_set_power_state(data, state);
-	if (ret < 0)
-		return ret;
-
 	/* map the interrupt to the appropriate pins */
 	ret = regmap_update_bits(data->regmap, info->map_reg, info->map_bitmask,
 				 (state ? info->map_bitmask : 0));
@@ -564,10 +535,18 @@ static int bmc150_accel_set_interrupt(struct bmc150_accel_data *data, int i,
 		goto out_fix_power_state;
 	}
 
+	if (!state)
+		pm_runtime_put_autosuspend(dev);
+
 	return 0;
 
 out_fix_power_state:
-	bmc150_accel_set_power_state(data, false);
+	if (state) {
+		pm_runtime_put_autosuspend(dev);
+		atomic_dec(&intr->users);
+	} else {
+		atomic_inc(&intr->users);
+	}
 	return ret;
 }
 
@@ -625,8 +604,9 @@ static int bmc150_accel_get_axis(struct bmc150_accel_data *data,
 	__le16 raw_val;
 
 	mutex_lock(&data->mutex);
-	ret = bmc150_accel_set_power_state(data, true);
+	ret = pm_runtime_resume_and_get(dev);
 	if (ret < 0) {
+		dev_err(dev, "failed to resume: %d\n", ret);
 		mutex_unlock(&data->mutex);
 		return ret;
 	}
@@ -635,16 +615,14 @@ static int bmc150_accel_get_axis(struct bmc150_accel_data *data,
 			       &raw_val, sizeof(raw_val));
 	if (ret < 0) {
 		dev_err(dev, "Error reading axis %d\n", axis);
-		bmc150_accel_set_power_state(data, false);
+		pm_runtime_put_autosuspend(dev);
 		mutex_unlock(&data->mutex);
 		return ret;
 	}
 	*val = sign_extend32(le16_to_cpu(raw_val) >> chan->scan_type.shift,
 			     chan->scan_type.realbits - 1);
-	ret = bmc150_accel_set_power_state(data, false);
+	pm_runtime_put_autosuspend(dev);
 	mutex_unlock(&data->mutex);
-	if (ret < 0)
-		return ret;
 
 	return IIO_VAL_INT;
 }
@@ -1477,8 +1455,14 @@ static int bmc150_accel_fifo_set_mode(struct bmc150_accel_data *data)
 static int bmc150_accel_buffer_preenable(struct iio_dev *indio_dev)
 {
 	struct bmc150_accel_data *data = iio_priv(indio_dev);
+	struct device *dev = regmap_get_device(data->regmap);
+	int ret;
+
+	ret = pm_runtime_resume_and_get(dev);
+	if (ret < 0)
+		dev_err(dev, "failed to resume: %d\n", ret);
 
-	return bmc150_accel_set_power_state(data, true);
+	return ret;
 }
 
 static int bmc150_accel_buffer_postenable(struct iio_dev *indio_dev)
@@ -1540,8 +1524,11 @@ static int bmc150_accel_buffer_predisable(struct iio_dev *indio_dev)
 static int bmc150_accel_buffer_postdisable(struct iio_dev *indio_dev)
 {
 	struct bmc150_accel_data *data = iio_priv(indio_dev);
+	struct device *dev = regmap_get_device(data->regmap);
 
-	return bmc150_accel_set_power_state(data, false);
+	pm_runtime_put_autosuspend(dev);
+
+	return 0;
 }
 
 static const struct iio_buffer_setup_ops bmc150_accel_buffer_ops = {
-- 
2.56.0.218.g1ec904b173-goog

