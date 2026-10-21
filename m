Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792627315;
	b=qGUkjUOxwWmz+KLreuEZqP5e9flJHcyTnDNqRzu93g+GkK7JFZXDX+LQIVMgXwhWLtM4
	 YbfHRttJDYuemuo44wgoz2FuPSTSHaAml9bS1OhegWfG2XFLSCKH5UfLIH1fNvuaCGGeu
	 GO1TNFa3dhceRtzj/PYBSyHPkMq+9ydXdESWAa7sUY0CaH7c1VByfouG43bnhXlCHG5N2
	 mwwqi470dH4Pb6oaS0SR79LDeheNAgBiColRi6mRwUSqQIyN5SAMqqUMCxc3UJp7KjjOd
	 inn2IEiqQBO4crpCVzfmnMCBA6Bj4pJgwoU+ubknQufnI3r9cM120OvnRcLL8Wfpt4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792627315;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=n3xDMUCpAKA+W1udgKw6gUi4Aniek2eVFJ0ny2jPCSQ=;
	b=4bqdBryYE63G+8tnHfcYajWbvS3v/hx5104W6fieONerWDQKVmkIC1Nf6q3DneI8hYAQ
	 M2aQ7tuuzXJQsRLYV9KFpob/SCVEhHnn2otltznAnfzpf7Z1NgXZT2kWAnQwMCL4vFX+R
	 p4pUWIimeJuYFTjWa0NJw8lWc5WysUXNl6q3u4PcXFLBUNxZ4Nl4oB2MDVAwoN501Zemk
	 prqBvxNVv7HjpAeJgJfZb5T6+AKKJmOXYY4R/8XyJk+aqtC5fw32gGV8nqPinU1ao+tm0
	 DzFlV5vrlFDIkH24SXgo9lIFlUn5rs63q135toiwIyuFR1jm/+0u3vZdPvPDbxY1yDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=kvIRrwjF;
	arc=none smtp.remote-ip=74.125.82.48
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88B160A5BC3
	for <linux-iio@vger.kernel.org>; Thu, 22 Oct 2026 00:01:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C88B160A5BC3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=kvIRrwjF
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-157fe9d771bso1659460c88.0
        for <linux-iio@vger.kernel.org>; Wed, 21 Oct 2026 17:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1792627314; x=1793232114; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=n3xDMUCpAKA+W1udgKw6gUi4Aniek2eVFJ0ny2jPCSQ=;
        b=kvIRrwjFl/SmlvjoHbZEubwmV1VUTKswii2wq2ZZEjoyn9z+qojvyG+qmSgXdXNLPQ
         07CFtQMCqOO1ZmBsLY8ITCgQvab7T6BG59XbmrP2u9l2tvkPuelMWZBZ/o1evdAlIgPf
         IqygWD7HfNf8t1a35mOslK+V/a6f6Ijkih2Vs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792627314; x=1793232114;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=n3xDMUCpAKA+W1udgKw6gUi4Aniek2eVFJ0ny2jPCSQ=;
        b=DyLBVXVgss3qBBVHB8MGjk6S0eir9J2APOtumv1MZ89cbRckuivu/T4hIp9bMxGcNx
         JtFbCnu5T9X6gJdNAJ531STrr5wp9jst8WBBYLQTui1hQ3KT1zUxqjI6KNs6tNUXIMmV
         aoYQh/QLBht16Vm8VelmbNa9Mv5fboJb6Vryt4zHmJFGDgXNWuqpcEh9+oh+BMyJA0VY
         jPtJ7gF4V0fPAWBdHEUOQ/S8sAL8+R5I7fVmWy88mJpvqU9Z1cM5FBim1WZUdG4QL+Nm
         GpOuRzsjRkJy4zjPpAIFgGo0juprvXvNHwZq5NdbvocFD4uwzgRJDKtaUtXUdyfV+WP3
         l+iA==
X-Forwarded-Encrypted: i=1; AKwUvBxT4E2c6yGENTIe2wjaPZQzgS1kzNtSuw71AXEHv0ilOUKC+4zypQQgDH0yCrHDgl4dFx7n+6L4CVc=@vger.kernel.org
X-Gm-Message-State: AFq9FYKLpVGVZrWGYR+rq5cbmkg7hcA4TxDAmkOHCMXhY9QNC8JPz52D
	G1cAB0Kzz5BZlQYzhtBC3/Q8NcoRvERiPViBBH0mg4jIcvkdTdmb6/HXzEq9nhcSrw==
X-Gm-Gg: AYBFou3ArgCpfZAp157Ak52ab3XMqCzwsHe3+jzzA3mwfbtpD394Y6nXemFGuUYb3xY
	OHAuWldWVQKj3gPfXoGh2V3MK5+ZDmlPgL26HCtlDU/1B3M64QQtJcPNg9ZZ/TyCH4Le6RrdawF
	DpHtLHioeLFaLD1Aiy1Dpb5FafOnQ72fE68cSBJkbYAUuFbYrpGzlUPBI6bi4C9wnleY38R8XRI
	R+ceCJneJArGpwopT1P+f2LnekUm3Z3k+W52xVwvo6onaW2tnOXe/tJSkFn6UKDKXrBDda0cHFQ
	t3xCyFj3lsLcZdaWoto5UXDr31ksAdfLzdy0F/7xGIyo82sAUppiZyVrfPzkwFx3UOrXjOxcfuo
	hkGmoHWgQCjnZoGuI+fnJuNuoWfe2QgYTV3TA3KpgTVAb7jtDFjSrmHWjZyiEzJWsVFBQdgz5I0
	42NJyxxIJjXOiNw+5dK6+dq0/U+M2t3VD9xtkBYOQIb39gYhBp9po+zOzwq+QWD8kkgreWWf2Xw
	d7AOylwTnGMMjmeaPJ2HeOdLT98MOeAcgP+ggl/1xZRvo5+Apqz8XS92EzLRkJMbEdjlZ5jhv+R
	tcEpK59GfG2v3sN5LNg=
X-Received: by 2002:a05:701b:4194:10b0:15b:7f7a:730d with SMTP id a92af1059eb24-190a632f93fmr4268943c88.28.1792627313833;
        Wed, 21 Oct 2026 17:01:53 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e7c:8:14ab:bfeb:ac88:458f])
        by smtp.gmail.com with UTF8SMTPSA id a92af1059eb24-1903d87ab1bsm10000732c88.21.2026.10.21.17.01.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Oct 2026 17:01:52 -0700 (PDT)
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
Subject: [PATCH v2 17/17] iio: light: us5182d: Discard pm_runtime_put_autosuspend() return values
Date: Wed, 21 Oct 2026 16:57:18 -0700
Message-ID: <20261021165858.v2.17.I2a58d2ac56600e492fd431e173bd0d67f180c6a3@changeid>
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

 drivers/iio/light/us5182d.c | 32 ++++++++++----------------------
 1 file changed, 10 insertions(+), 22 deletions(-)

diff --git a/drivers/iio/light/us5182d.c b/drivers/iio/light/us5182d.c
index ab518311fd79..98279bd1ab25 100644
--- a/drivers/iio/light/us5182d.c
+++ b/drivers/iio/light/us5182d.c
@@ -366,45 +366,36 @@ static int us5182d_set_power_state(struct us5182d_data *data, bool on)
 	if (on)
 		return pm_runtime_resume_and_get(&data->client->dev);
 
-	return pm_runtime_put_autosuspend(&data->client->dev);
+	pm_runtime_put_autosuspend(&data->client->dev);
+
+	return 0;
 }
 
 static int us5182d_read_value(struct us5182d_data *data,
 			      struct iio_chan_spec const *chan)
 {
-	int ret, value;
+	int ret;
 
 	mutex_lock(&data->lock);
 
 	if (data->power_mode == US5182D_ONESHOT) {
 		ret = us5182d_oneshot_en(data);
 		if (ret < 0)
-			goto out_err;
+			goto out;
 	}
 
 	ret = us5182d_set_power_state(data, true);
 	if (ret < 0)
-		goto out_err;
+		goto out;
 
 	if (chan->type == IIO_LIGHT)
 		ret = us5182d_get_als(data);
 	else
 		ret = us5182d_get_px(data);
-	if (ret < 0)
-		goto out_poweroff;
-
-	value = ret;
 
-	ret = us5182d_set_power_state(data, false);
-	if (ret < 0)
-		goto out_err;
-
-	mutex_unlock(&data->lock);
-	return value;
-
-out_poweroff:
 	us5182d_set_power_state(data, false);
-out_err:
+
+out:
 	mutex_unlock(&data->lock);
 	return ret;
 }
@@ -676,11 +667,8 @@ static int us5182d_write_event_config(struct iio_dev *indio_dev,
 		goto err;
 	}
 
-	if (!state) {
-		ret = us5182d_set_power_state(data, false);
-		if (ret < 0)
-			goto err;
-	}
+	if (!state)
+		us5182d_set_power_state(data, false);
 
 	if (!data->falling_en && !data->rising_en && !data->default_continuous)
 		data->power_mode = US5182D_ONESHOT;
-- 
2.56.0.218.g1ec904b173-goog

