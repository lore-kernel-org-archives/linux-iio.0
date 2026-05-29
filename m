Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A92C93D090E
	for <linux-iio@vger.kernel.org>; Fri, 29 May 2026 10:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780051564; cv=none; b=l+lXFPTXA0pidbxGpyHc2JqI9dQLbue1XgPPxC6krfHKeiD3uOk49riMdMFuomADKaviSfv2NJW8XADEgmnnTFVkWG1A3DAaHApbt0aLhtCaNKVzo1v0cdkXBbH9DK6uSlfhuxIs4YNCj/0t3jF13Q14Qv3e40bqh8GbjMYq6Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780051564; c=relaxed/simple;
	bh=audYFOC1F1czBfQ12j4ij8tbLhn97+qowaIfjvNDfss=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mXd8wzDvd7UPyWSGLkok4PZ51Oj0GKB90STrrnpb3eLfB6ZWzu5Z4osoCzdEEjuWn1e7eYvJsIu/tNOP3wd8dJu5PTNI+4BRehy4UTx1YaskbzGEJEUEIYzF4znAkhs2+lofR/Um0XGXVKkw6Efvz+h4OiVmk77lIMs01e5tpM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UV3phIFD; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UV3phIFD"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-393da0280d1so14727391fa.0
        for <linux-iio@vger.kernel.org>; Fri, 29 May 2026 03:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780051561; x=1780656361; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8RX6HPkvTVnTrWIRcVhe8QYP1zROuwlfOtGDPwiQtAU=;
        b=UV3phIFDpmyO8gMVz5LW5vlxzQ1vbWuBC3mAgsxPlOC7euEYCtovQmOp/vve0EyAgV
         tTXq7mFyr6XnX7T4V8vFCy8JRkVQGO15S+PfoYFv3MBZUDgcIFTHh994QQKTyInlRPsU
         W89B2YZKRM/3VpvYuveDP3dxA3tmnha1TjMzQheeGwxuFcpswRVZhAIBq257ePRHxpwY
         Gsx+u7UbB5t083dBKhKsZbTEC/CFn6He9eC4pykOrK2Qe3vv0VaFzZGmI0wRMxsdbJiB
         DyOdcO112BjMZFu4wputF1zcEwblOx0b6VhgTFmkOx1R5gyOjC4Ul94oZez02nqV8Moj
         cNbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780051561; x=1780656361;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8RX6HPkvTVnTrWIRcVhe8QYP1zROuwlfOtGDPwiQtAU=;
        b=H8P9jkXCOgVXPkwOstWeWiXH1y5rE+CCRZQ9goxTIou7NH40P63Xt+eerX2wX6RXu9
         Hs2TgH7uzXTRGIImjdDdStZ7F1ucwVeffO+nMCSs19UlVazfnl9xbRcrRbu3Zhl3JQlm
         /6jFyd3cn3QgoYUsdWiwpgQFYNJOCewcbTlSHSvwExthC2uXpJ4/m6NpqJ57swKik5E2
         lmLfhB28LdX7OC73uzKGnYn1o3DR+HXkfxrEyV6F3Ra9S7Di4Zv7YXHYiLoqqYGwITUk
         7NooswYnuma9M9m3aAucFqvDyLQ10CoPxrfptz3UHukvnT2xngElTG86NAIw2qAcJzMQ
         srIQ==
X-Forwarded-Encrypted: i=1; AFNElJ9mNGea9MYedDP9Hr1E3uZ8n6nD0PGXUANxMky+2J1iOMRQeuGgQll40XwjoiWeLZzxkXSq9KgUmT4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjjANSRAKUkYeaygJdGb08sGHJQH7OTmTanFYiDF+qFdgmbMM9
	GBqo5IWswD5UonS7Pvlhj6Oq8P6BHOOAAbm+tMVBWDG7vjCgU3Blt4jW
X-Gm-Gg: Acq92OE9M2hqT25rv86DegSwhrsSE7T1CzdCJp2hx2pyYySAmRujchWdpQ1AT+d9HYk
	psBNK8QfIFiZM177zgvjAxk/9Qc9eyIfyAuaLA9uVUtGs8PgrFDwqOR+bw108cNOpslAYnSU/uF
	3h8ml98VxgHyawadNoCUVmdCgiV8Q8OneMJI9utMe5LTvAYXXVRzeAGJ2YAd5yiTCyf2tthUKJ9
	auQ1m7WvtVNUKN4xnn4D9ABT+Ezs1LbOUPOsPxgRvxGQSzV3PvJu+oP/VAzEVyjnCEHnq0wiGFe
	ZOujkym1yZCc/pQMHg2WPtrTmYexwqpzEOqU5cjyNMGq9mwqpcU66hjb0IIBkNJbGZ1baBTVzgs
	YMbwe3mYlGhPLRorhEHTUAd1w9KCStWwCgd/AUrUwNm1hG8kf3XAu0sJNqBsfIKzLPJtilv/83+
	gAXJ+DKzNQyWz9Lsk/wrOfqyf9MMG0wabC7tk9KrZbI/iBXckubPNSv7c=
X-Received: by 2002:a05:6512:3988:b0:5a8:7396:63e3 with SMTP id 2adb3069b0e04-5aa59523751mr306571e87.5.1780051558250;
        Fri, 29 May 2026 03:45:58 -0700 (PDT)
Received: from localhost.localdomain ([94.158.61.193])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aa5b788811sm192604e87.63.2026.05.29.03.45.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 03:45:57 -0700 (PDT)
From: Stepan Ionichev <sozdayvek@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] iio: light: us5182d: use devm_pm_runtime_enable() to fix probe error path
Date: Fri, 29 May 2026 15:45:42 +0500
Message-Id: <ba9abb34df8a0b16015817c44bd4a22d53d2c065.1780051096.git.sozdayvek@gmail.com>
X-Mailer: git-send-email 2.33.0.windows.2
In-Reply-To: <cover.1780051096.git.sozdayvek@gmail.com>
References: <cover.1780051096.git.sozdayvek@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

us5182d_probe() calls pm_runtime_enable() and then iio_device_register().
If iio_device_register() fails the function jumps to out_err but the
existing out_err handler does not call pm_runtime_disable(), leaking the
runtime PM enable_count on probe failure and on subsequent rebind.

Switch to devm_pm_runtime_enable() so the enable (and the matching
dont_use_autosuspend) are torn down automatically.  On its new error path
the probe jumps to the existing out_err label so the shutdown_en() cleanup
stays in step with the rest of the manual unwind.  The pm_runtime_disable()
and pm_runtime_set_suspended() calls in us5182d_remove() are dropped; the
devm action runs after .remove() and handles the teardown.

Signed-off-by: Stepan Ionichev <sozdayvek@gmail.com>
---
 drivers/iio/light/us5182d.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/light/us5182d.c b/drivers/iio/light/us5182d.c
index d2f5a44892a8..ada75f710bfc 100644
--- a/drivers/iio/light/us5182d.c
+++ b/drivers/iio/light/us5182d.c
@@ -880,7 +880,9 @@ static int us5182d_probe(struct i2c_client *client)
 			goto out_err;
 	}
 
-	pm_runtime_enable(&client->dev);
+	ret = devm_pm_runtime_enable(&client->dev);
+	if (ret)
+		goto out_err;
 	pm_runtime_set_autosuspend_delay(&client->dev,
 					 US5182D_SLEEP_MS);
 	pm_runtime_use_autosuspend(&client->dev);
@@ -904,9 +906,6 @@ static void us5182d_remove(struct i2c_client *client)
 
 	iio_device_unregister(i2c_get_clientdata(client));
 
-	pm_runtime_disable(&client->dev);
-	pm_runtime_set_suspended(&client->dev);
-
 	ret = us5182d_shutdown_en(data, US5182D_CFG0_SHUTDOWN_EN);
 	if (ret)
 		dev_warn(&client->dev, "Failed to shut down (%pe)\n",
-- 
2.43.0

