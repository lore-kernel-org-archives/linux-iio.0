Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792627312;
	b=eeasQzV3RZA+GHNejQE7AkjauGY1Mjbyq0YlMru8VqmxqTrxCyE50KMOhB3uOqfIz26q
	 omSdriRAB9cHiZipjjAsSXUyaq6LfPpXCccNtk2+JCGqkLaVLQ/xv2fbNonUrke4lT7LI
	 6KGdbcjrWZ0aYrG42sJFhOLGIcKtf3o+vLxq5RMSFcPyBUu3kirSaz06hwtKNvOh0A3RD
	 5XcGUCkDNUqHB7rqj3cW1cINZtwlw1VDAURJaGC/NciFZEJCcSwGqeri7Pgxj35evAE2P
	 t5CShkjt00dwYsFsk844Hswsp4WJVUk+osZGTA9sKynToAbsUGo+jJ5hUUlNwF8qH3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792627312;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=A2hj0UfttoWfWnVmfQgXmyBs/YW0e/AChXA2zyZLurE=;
	b=EwP1bB623uXoePCq6LK9pQggMSoHMtt/taEn+imxNQF8xbYV8krWJVQ06sQO18VOdQLb
	 8lc7UiD5OuY/mWd8aHmmiDr1vZJ2g1cX1+SWpvLTe3c73OWkyMG+V7FdS6iA69Ai3isB3
	 oj2ZzrA/n9OXcY+i0Cp8Rw9g7hEY/59YTPSiSZcN32C5GwDynlVD8O6QtIhkawyaI+Gqm
	 AylUCEOgkKjYcAUTHEnc5BaVtmtya0jQwQLyiNNKIXC1r7CDunTQEutAffHwDwBQ0hOiX
	 dcZ9Aa0iGmHEi2A95wbO0z2awdgQ1sDMOq4dlc7lfvP/49Ldz9lo/w3jduz90oGwvaQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=afzVRXlH;
	arc=none smtp.remote-ip=74.125.82.181
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C35A760A4AF4
	for <linux-iio@vger.kernel.org>; Thu, 22 Oct 2026 00:01:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C35A760A4AF4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=afzVRXlH
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-354ba08cfd1so2158105eec.1
        for <linux-iio@vger.kernel.org>; Wed, 21 Oct 2026 17:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1792627311; x=1793232111; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=A2hj0UfttoWfWnVmfQgXmyBs/YW0e/AChXA2zyZLurE=;
        b=afzVRXlH7AyuOv6MQn72cix8RjgPhIb/LYyiVfbScV3+/W3r+nXIxRv7O+d96h6sDo
         6dtVNUUUkNbYBYO7WruxmW1s1NtFcoKPzex0Gr8p5sp9U/4RR2cKDpQrY9M8ibdCj/5S
         kF5x57ccX229im/onuXbSpaJR4+sgQuzDP6Ac=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792627311; x=1793232111;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=A2hj0UfttoWfWnVmfQgXmyBs/YW0e/AChXA2zyZLurE=;
        b=kRlk9NTqhP3UTKbEasm0YnOqj3WBso6PzeGh6iMs5HcIUUw1k2RgN6U887yeBwRAe0
         Q0O1mvGOSXkE4/VMSHBe2wIqVF+FFGqqr0HUjbhUqooe7ee8OEglDn9hhl3l0h95eBPf
         M94EZxlFBU7OxiSDknJQDLqpAkH3pWZCcO0WBn9QBWJ3HfPKQUqYDzFob86UKG4qnjyM
         TUhfez5+kdHcGoqJdij05ArlZuzZzOnrUH9B9hySPYlUcQP4+QUoni3cAL4+CJgZajck
         3tFXShIWJTApLhUP8dDYSPRrfhPCOZGadqbLjGP1MTHeK0lrFNjI2uDq+a9E96I04MC9
         9JMA==
X-Forwarded-Encrypted: i=1; AKwUvBzccP7KKFrACObKcxZgxchU3fy9GP0UH8lwg+d+FOoh6TuNw0h1VERsFq/s5CntSTpF5X4GwIbO85s=@vger.kernel.org
X-Gm-Message-State: AFq9FYJkiKVMkL6q7eT+mXA5iMp2Bu1U2H1Imu3gnd2HEl0AlLPWaIuN
	MEIqCrdxgKvj91tM9Ie1wx28LbLaRRETZKGpdWZkejGKSXKJFH/1xqUu39EZdnvjCg==
X-Gm-Gg: AYBFou3f2fAvX1zFv919LAfu5T9kIj+PMwt0gRD1EmWCQD2ZMLOVNIoy3GK9VaefIKe
	AWJVSEzd+50JpYxnKXgsDdY62AlLJxWLhsqlXTY3UB//D/gZxWTDKy16NgVrdQdjq0YBabKYwVG
	2vJSg9iZvAjfEYkCAolUzW238W3SY/77u7yGY357ADEAxyTQyw0fXdbRdw15hu+5KoHPa+Y5RO4
	/4gQHWWY3YtDHQ50yW1SzJlZKnbkzCJqkv+XkfGDCuXR8ljGX//MJIwFWntxhRpyoVg62tYpv50
	fMVv5NOK48SPrvzHh4RMpP1OUWg8AsCzD07ZRicnpp23H9dyOKu5EuaQ8D/iWRGiUbnYzFvjSNK
	63/TorZFiww/bQtXvIT7Zh/FDBPUdMEX32up3SD9urpSg817A0v0wE3MIvxFZff6UD7kanx1/DG
	mA40ExXJFifKT2k2NbeP9qgMG6s25eg5mFNMsFC5LDD6DQ8vmlVqRQ+wfVhPtnR8GlRHHU5TY2Z
	Hb/F0pp0FZcv4A/WKHFWmP/ot/qg3VpwR44ucc7X2iYSwbQh5aGQwRPsk/84A3mMr482+O5tRpW
	xTOg+C49TLNgs30Jg294AbvFu7uZYkZn/PWZsa+v
X-Received: by 2002:a05:701b:4248:20b0:16d:dd5c:4261 with SMTP id a92af1059eb24-190a7e0c294mr4435702c88.46.1792627310929;
        Wed, 21 Oct 2026 17:01:50 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e7c:8:14ab:bfeb:ac88:458f])
        by smtp.gmail.com with UTF8SMTPSA id a92af1059eb24-1903a180ca2sm8704538c88.6.2026.10.21.17.01.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Oct 2026 17:01:50 -0700 (PDT)
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
Subject: [PATCH v2 16/17] iio: light: tsl2583: Discard pm_runtime_put_autosuspend() return values
Date: Wed, 21 Oct 2026 16:57:17 -0700
Message-ID: <20261021165858.v2.16.Ic3775fd68cac415d959c0456c4d4c36e9e5b95e5@changeid>
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
pm_runtime_put_autosuspend() return value.

This will facilitate a planned change of the
pm_runtime_put_autosuspend() return type to void in the future, similar
to commit 3afd8df02433 ("PM: runtime: Change pm_runtime_put() return
type to void").

Signed-off-by: Brian Norris <briannorris@chromium.org>
---

Changes in v2:
 * Split iio patch into per-driver patches

 drivers/iio/light/tsl2583.c | 27 ++++-----------------------
 1 file changed, 4 insertions(+), 23 deletions(-)

diff --git a/drivers/iio/light/tsl2583.c b/drivers/iio/light/tsl2583.c
index 2d041b7530e6..a5b2b7fb6dd9 100644
--- a/drivers/iio/light/tsl2583.c
+++ b/drivers/iio/light/tsl2583.c
@@ -647,7 +647,7 @@ static int tsl2583_read_raw(struct iio_dev *indio_dev,
 			    int *val, int *val2, long mask)
 {
 	struct tsl2583_chip *chip = iio_priv(indio_dev);
-	int ret, pm_ret;
+	int ret;
 
 	ret = pm_runtime_resume_and_get(&chip->client->dev);
 	if (ret < 0)
@@ -716,19 +716,7 @@ static int tsl2583_read_raw(struct iio_dev *indio_dev,
 read_done:
 	mutex_unlock(&chip->als_mutex);
 
-	if (ret < 0) {
-		pm_runtime_put_autosuspend(&chip->client->dev);
-		return ret;
-	}
-
-	/*
-	 * Preserve the ret variable if the call to
-	 * pm_runtime_put_autosuspend() is successful so the reading
-	 * (if applicable) is returned to user space.
-	 */
-	pm_ret = pm_runtime_put_autosuspend(&chip->client->dev);
-	if (pm_ret < 0)
-		return pm_ret;
+	pm_runtime_put_autosuspend(&chip->client->dev);
 
 	return ret;
 }
@@ -780,16 +768,9 @@ static int tsl2583_write_raw(struct iio_dev *indio_dev,
 
 	mutex_unlock(&chip->als_mutex);
 
-	if (ret < 0) {
-		pm_runtime_put_autosuspend(&chip->client->dev);
-		return ret;
-	}
+	pm_runtime_put_autosuspend(&chip->client->dev);
 
-	ret = pm_runtime_put_autosuspend(&chip->client->dev);
-	if (ret < 0)
-		return ret;
-
-	return 0;
+	return ret;
 }
 
 static const struct iio_info tsl2583_info = {
-- 
2.56.0.218.g1ec904b173-goog

