Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792627300;
	b=IL7Ywo2W6ziFEmINeb0wwYS3KtgvD0U1MiF1FV2/JUYtbovdicfGkhZagogyx0YAMJbJ
	 F/DCkAoMbaZawqHbob70SGc2oyKOb3ebK8WptxErycIYSxI4DcxAD64HkRUMzj09C8w3V
	 iKOST9qIQosenx6L+PW9hS5RmH+w28LTPJ2jrdwF6uVKfKut+OaRdmMArExX/oit55JnV
	 fdvvTGQw+NnDDNOQ91Pnkw9GQ7YdzRZG8lFeXE4qkneCyZxYO1YFRz9luw58pELhcp11p
	 7bl3Py4hmmHga/SEQjpBIJ8fZIB5A/c3e3o6dCNtCGRI2GJbQ1kNoe/ZXmrEUfbozZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792627300;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=/GMv02swmZTGafXC+zgXG/S425qXp9I+QwglxrC5H34=;
	b=u4dY79SgBb/rKDfQyEJGiE4N5wU7HNWg4Kn6+fzfwid1wEf/y5z0ouNZv707bkW/kSP+
	 IOPQR8q58M+YZGpu0NWVjVAaUfYP8h4DkS75AnWragFns7XbztTlyZ+CPiplM265h+gC5
	 NZnUgqkqpFA4hitkdHciCzgq83ai2eHwY9SAcA+CWkKhLnj5w6y9vnKWx760jWfWc+tXG
	 y8jpBmCTxWjiLKgb1oew9dv//273shF35Uogb9YYQocGwgbCjMDQLsdsPSw/u7iWEDfO6
	 bc+qXDEx83XY2urLZROrY3dSuj+2Zj+8ktIV+Ds5YTii411gldDXj1bMAdlizcmPJ+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=MWkMTRS8;
	arc=none smtp.remote-ip=74.125.82.182
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF9F60A4AC4
	for <linux-iio@vger.kernel.org>; Thu, 22 Oct 2026 00:01:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0FF9F60A4AC4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=MWkMTRS8
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-3282db206d3so3012378eec.0
        for <linux-iio@vger.kernel.org>; Wed, 21 Oct 2026 17:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1792627299; x=1793232099; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/GMv02swmZTGafXC+zgXG/S425qXp9I+QwglxrC5H34=;
        b=MWkMTRS8ZhEtf2LO+YZAG/BGXXBLmrdQVgMsI4F2HXEMzbhWeBHLHQYi4y/LMBdAuE
         t+X+1E1LrDwxZnfXFjOrXD3Q8p6k2ll3d8KnpEKtfzaAW2Zfq9I5BEq7b0l1Uju77Edd
         AqUGcdg3o+3Ffgl0cv8pZlA2yuCobNDyh8PuE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792627299; x=1793232099;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/GMv02swmZTGafXC+zgXG/S425qXp9I+QwglxrC5H34=;
        b=yDdakoJrxdi7uBw31+q8Zx1d5P0qZ8yuSSakon3WIXh5JiK0ekW8PQp3lYj5Ia+AsX
         2w+3fsr6O3Pv6ijK51KnjPqTRa0At/EkP6GHAagZ4LmyamISm89V/uqLrIFnG+YXwWQP
         Dut3CaHGlkysvMFdPRlUfmCrpbG5CYwbe6nfl1DSyAiVDYIQ0y+QO2SmmnkGu2+CGFmf
         vzcKAceeIzd1fH1NIdTXZlKAnKyyB4oqmUzcWcjG3/R4hfBdA0c8NnZsPFMteE2XcY6I
         x0i0QC3JTrQfxJOkorCf4hwqC5JsJ6tVGGTGxKqKxhvahlhdMmICNxZybQMtSdiyK+jf
         lzqQ==
X-Forwarded-Encrypted: i=1; AKwUvBzPsOgTbZoG+87taeXn9iV22ikLmaDMninOzdTPTGqWyqxYAVTpKifyaqiipAGBmjogj0n4CK1Utmk=@vger.kernel.org
X-Gm-Message-State: AFq9FYJd1vfej3TKA3c/oiJYM+Uerk0CjQCY4iBDmPOfEf3NSc9k/Wbc
	j9wnRNv6sENeTf2/9v1DPGNcgQ1p99sc/iD0OfxBOAdnAu9BLeM9EHZMwKu9t3i27g==
X-Gm-Gg: AYBFou1sfG9pB6sOQA3VTOhds1lfO/dUk47KoLXD0WUOW8vpGw43NaWmH0NJO8+X22o
	mOon0ZHT+XN9z5ZgHUSqZdHqIceDek6a46SFxL+34Gq9fZhNpsM6aBCEGuV1JdIMPbzfmiK6fUW
	rXkEPkqUvsZOHupAG72F1ml3D8pGq0fIZrtZ/5YAwwTY6zeS80i7VOcuOJPwGZRUizGzFbOLb6U
	NQ+5Mpggy9wM5710SYLR13AHcndxtIwTWrbt70j9C5R99gB+qjNlmRxn9az4bC//Yu30LKOD214
	G8xoafSiHFDxDHj2gWmMoLatrl1pRk1dJDLgd9CNk2coTx0OQE3TVrQtIqF28qaSWpwPzVyjkIo
	PWj0ljj5Tlr6fslJykB8a3YEhpGx8+dCpYmGCoVHcW9gxVTbBAnJYNILKCzaLfX1kZ8e80pR1k3
	Rz/BaXupCPdv3QFgzg9W+9BTnQvrAxidr3Jxz1zxm7pXoYx/jx3XXOCkwGDbjBV4WTYeMY+BJP3
	zkDR9zRql8rtAaxp13ZqAJuYR+TxiBqy7i+Gk2o2VmAkQVBVhZRKtI5qcWz7vOaa30oNVmC4BFK
	KfJZ7TPem+j9FJb97nQ=
X-Received: by 2002:a05:693c:62d2:b0:351:13b4:9c59 with SMTP id 5a478bee46e88-3674a40e089mr4985582eec.2.1792627298780;
        Wed, 21 Oct 2026 17:01:38 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e7c:8:14ab:bfeb:ac88:458f])
        by smtp.gmail.com with UTF8SMTPSA id 5a478bee46e88-368ee692656sm909622eec.28.2026.10.21.17.01.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Oct 2026 17:01:37 -0700 (PDT)
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
Subject: [PATCH v2 12/17] iio: imu: kmx61: Discard pm_runtime_put_autosuspend() return values
Date: Wed, 21 Oct 2026 16:57:13 -0700
Message-ID: <20261021165858.v2.12.Ibb6be74faca4446a1147537fa1a82bb6b9d5c580@changeid>
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

The kmx61 driver propagates the return value of
pm_runtime_put_autosuspend(), which is not particularly useful.

Returning an error code from pm_runtime_put_autosuspend() merely means
that it has not queued up a timer or work item to check whether or not
the device can be suspended and there are many perfectly valid
situations in which that can happen, like after writing "on" to the
device's runtime PM "control" attribute in sysfs for one example.

For this reason, modify this driver to simply discard the
pm_runtime_put_autosuspend() return value.

Note: kmx61_set_power_state() is a possible inlining candidate, but it
performs some non-trivial logic on the {acc,mag}_ps fields, so I leave
it alone.

This will facilitate a planned change of the
pm_runtime_put_autosuspend() return type to void in the future, similar
to commit 3afd8df02433 ("PM: runtime: Change pm_runtime_put() return
type to void").

Signed-off-by: Brian Norris <briannorris@chromium.org>
---

Changes in v2:
 * Split iio patch into per-driver patches

 drivers/iio/imu/kmx61.c | 25 ++++++++++---------------
 1 file changed, 10 insertions(+), 15 deletions(-)

diff --git a/drivers/iio/imu/kmx61.c b/drivers/iio/imu/kmx61.c
index a4962b88ef58..9d626882adb0 100644
--- a/drivers/iio/imu/kmx61.c
+++ b/drivers/iio/imu/kmx61.c
@@ -747,16 +747,15 @@ static int kmx61_set_power_state(struct kmx61_data *data, bool on, u8 device)
 		data->mag_ps = on;
 	}
 
-	if (on)
+	if (on) {
 		ret = pm_runtime_resume_and_get(&data->client->dev);
-	else
-		ret = pm_runtime_put_autosuspend(&data->client->dev);
-	if (ret < 0) {
-		dev_err(&data->client->dev,
-			"Failed: kmx61_set_power_state for %d, ret %d\n",
-			on, ret);
-
-		return ret;
+		if (ret < 0) {
+			dev_err(&data->client->dev,
+				"%s: failed to resume: %d\n", __func__, ret);
+			return ret;
+		}
+	} else {
+		pm_runtime_put_autosuspend(&data->client->dev);
 	}
 #endif
 	return 0;
@@ -801,15 +800,11 @@ static int kmx61_read_raw(struct iio_dev *indio_dev,
 			return ret;
 
 		ret = kmx61_read_measurement(data, base_reg, chan->scan_index);
-		if (ret < 0) {
-			kmx61_set_power_state(data, false, chan->address);
+		kmx61_set_power_state(data, false, chan->address);
+		if (ret < 0)
 			return ret;
-		}
 		*val = sign_extend32(ret >> chan->scan_type.shift,
 				     chan->scan_type.realbits - 1);
-		ret = kmx61_set_power_state(data, false, chan->address);
-		if (ret)
-			return ret;
 		return IIO_VAL_INT;
 	}
 	case IIO_CHAN_INFO_SCALE:
-- 
2.56.0.218.g1ec904b173-goog

