Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792627290;
	b=ncRjQqVSxQ8clOgaQFAKJo+4z6pjwUG875GGyeZm7wBiAr2ipFrzg0Tri4SJbYE2/8q8
	 /3XmqCDR5Rx7idIzUCUES4ctL7SYkQ8U0722tanmYlIl6pYiIVVO7+Ks00QiBOoZGVfCP
	 AwdyRsKIXTCrB2hpFvnrul+pEVkhCj6wO5Lqu44RCYLEbQrtNMu531lEhy5XatDfs0HcU
	 vJK4XUH2R9IJ2UxOnkpJK5Z6+/FOsWYZJw5SF/J8zHEghqX58X/dF6NyCLvYF7LBrWlGa
	 rUIXCwlybbLzjnvUZ9/SQv9qW3c6fev4L2EUBZ0/sxLx3nMVoIjXaphdMK7FlJ4ARXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792627290;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=qGPgAY2uzbFWVW1gwGK7OSQ0FTtWRIw5OwqDXn3zsW8=;
	b=ncTOBELik+NzyIw3QT+Udtu9h8PGQHuKyVhF3uUu+h6v5L82pquJAB33kyqzQXRbP5PW
	 QhZ3bGYuZ+fFNVR/R3aTS6ik6nZlQ/MCA4uLuZ7snlebzdnWzHzv1SFf9UT4Rv1D5P+cK
	 9moe5bRPHRxPAU5wDXNkaAyEBvYMU+6S5V3kVMPeFQXc9XVWxqVsKnpzHiytrYae5GBBg
	 8bRwlrp7iXwoTMUF9InEjt3zanDn7fJqgMp+y/p+MzYbz/FoZik9z4AAG1PCYI+NOUe2j
	 afUrx7zVA8WnC6JcWgZQgua6EZxhqQj/Mrv/hH3RSdHB4Q3YkqeeCytcKcfcVH5RkTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=WIFND+kT;
	arc=none smtp.remote-ip=74.125.82.173
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9656860A2602
	for <linux-iio@vger.kernel.org>; Thu, 22 Oct 2026 00:01:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9656860A2602
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=WIFND+kT
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-3282db206d3so3012094eec.0
        for <linux-iio@vger.kernel.org>; Wed, 21 Oct 2026 17:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1792627289; x=1793232089; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qGPgAY2uzbFWVW1gwGK7OSQ0FTtWRIw5OwqDXn3zsW8=;
        b=WIFND+kTBwBCsBYJNd1wpQLhBQ+sITxmOuOQV6VZxXbnAKapDVGgjeSp26Q37/WxrX
         CupVn8dGVWLQLfysitFEgwtRNtjR/s1eV/liJOqQVF69QLg8Yum64TcWI1pFs2S7yAUy
         ogArNfoZMqceGQfsV5l+PUi6SDdOX+qgbIvYI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792627289; x=1793232089;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qGPgAY2uzbFWVW1gwGK7OSQ0FTtWRIw5OwqDXn3zsW8=;
        b=1bEYRB2e4ddbkkZmWVsvQyggLpUFqu0mlqyy+k8uk1Fkhd5lKd2rAE9QTE/FIvCKD6
         K4M2ONtzEYJsCD23jbXmzSGBE4/3T2Nz2dE0xTGBkWLNUggJA8ORKbN5AuZl1T3gGI+H
         XzSuif2wEUftOykLh7LC/JT05ZKwh1MpprsKVMaFNdYJ3ffUqnhStu2vBKrIA2bbEFyj
         c6jL3NxkVmgZHU8Q09p3k+TP9RGq8uhhNz9i6g77oUTUPV1RjrXeiVuJMyXv0snLSzYh
         9Hs28EYCwsol4udj1Ql0ZTDC8Rn7h5NdX4a9oYTPDajAb1WEmADucvH/TUGHkiBxbGoZ
         l78A==
X-Forwarded-Encrypted: i=1; AKwUvByNzI3za2n33XJym6N+Z0MP3aK0/Er7SpRH2V0dwIM5ZGqghQdyFrZ0UskFTOzHx083+tJ5mwahedI=@vger.kernel.org
X-Gm-Message-State: AFq9FYJVrf8RkKzKME8g7TE4a/QNSPdTg9Xu54S6H4XpKXUfTa3auwDP
	s6T92xXbzIKnpibJh/bTBqU5ZMH35KcsXhl8s8QPcHw3VMYCPKIJU+IW+sgMM18GdQ==
X-Gm-Gg: AYBFou2VTNNvp1hH3uVEqYQoZSFkp+4AcKzOWnHnY4ahENimiQtsASzQqR32tC1yGE9
	uPD8cB6jPpVFC5U0vZZWOKMU2y0ZZW7vuuVA7C5nSnymmi1CcdRfOnsk7qTeiebTVaV6Xw8+Kji
	/h5rvEVpivM8OgYML0fMjsqQWK3b8AjCRcWtMrPodkAYnosWaSAnpW6B2V4CRCpJ2WkBXvxk02I
	v1HSrb+xjzOrNDIsRnqeyNLp5YHPR6NrtkO7LNPGk+FfT2+5Ynh1vISky31764NqHpQDNGeBsFi
	VhGnu49+XzhmEkDLE5fpKixURy7PNZ9MGF0IpasRPKCuMYPAE7YuMSpJVaON50Wm2VTYsTKTrxq
	tcuIXmzFRxxOS5EiUHWHrGG13Qxfkg5nQZayANMJTWoe/eMqAJcDvDJkOiyMCrvd/ujdpgWUfsB
	1oNBMu0g8skyzn/YCCaaNd850QAOjDULPm5lQyYuXsIqiUB69dJ8nF3OSo2366eUSc0cFXOTciD
	K22cyD2xBQ1bW0C9nbxPXv1yEoKstnj7QhSx7gbp95lRZFpPIuuFL24l+j5aQifBuSsu/Z4CWuJ
	FcX0Fp7MLqAjWY2T61E=
X-Received: by 2002:a05:693c:8092:b0:368:2548:c08b with SMTP id 5a478bee46e88-368255807aemr2585617eec.21.1792627288539;
        Wed, 21 Oct 2026 17:01:28 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e7c:8:14ab:bfeb:ac88:458f])
        by smtp.gmail.com with UTF8SMTPSA id 5a478bee46e88-36740cc848fsm10850448eec.13.2026.10.21.17.01.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Oct 2026 17:01:27 -0700 (PDT)
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
Subject: [PATCH v2 08/17] iio: chemical: atlas-sensor: Discard pm_runtime_put_autosuspend() return values
Date: Wed, 21 Oct 2026 16:57:09 -0700
Message-ID: <20261021165858.v2.8.I55d76837b3feb481080e43d358375445ca0993c6@changeid>
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

The atlas-sensor driver propagates the return value of
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

 drivers/iio/chemical/atlas-sensor.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/iio/chemical/atlas-sensor.c b/drivers/iio/chemical/atlas-sensor.c
index 1d4a9919df1a..48598475512f 100644
--- a/drivers/iio/chemical/atlas-sensor.c
+++ b/drivers/iio/chemical/atlas-sensor.c
@@ -426,9 +426,7 @@ static int atlas_buffer_predisable(struct iio_dev *indio_dev)
 	if (ret)
 		return ret;
 
-	ret = pm_runtime_put_autosuspend(&data->client->dev);
-	if (ret)
-		return ret;
+	pm_runtime_put_autosuspend(&data->client->dev);
 
 	return 0;
 }
-- 
2.56.0.218.g1ec904b173-goog

