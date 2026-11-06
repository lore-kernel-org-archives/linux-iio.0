Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793987262;
	b=1AbLFzCIueH1TPfmEemnhkiKapNjtxbDTBpeirK0HUx8o1atduoMMYCpHKUV+2UODqbK
	 z8Cbv35jTwRvlYb+Qll8/aj5mfKhGoimDszP8o6laEvJ7k4jAGRrlU7IlxmeukB28spnO
	 BP0owIHfWk6PLvvqF0esbhYESLV1ExsMh2faKRfZ39eBFOwTHevfIbR+lMZ1NNce16VVz
	 GCvq2dZkqt0UIVgDI2MygL7yM4YoNDRPC926/eR+YX6nWS/jhY9BFV/PCGrZuO8/s52fE
	 tJJQoORTA2JYEYlO/HaT3BIB3Hl3XYV5l4uR01DKO4TXO1NB48ImT2UrjxGncrjmmsA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793987262;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=eRHNQnSyg+HxFwUHDEG9hXimdhxcL6M8ICyQ7BsYEvw=;
	b=b1Fj1A1GC0tRws37JwykqG6k957nSc4yZnIoAmj9EYIHrCY+UR0w3jT3LRD25FZyX+89
	 WD5aiyAIkv3jGfvaixS8PJJf6eMgfXi9NGFlqvtkB804TOj5IKXZV0m6ev/lq7+/DcCM2
	 Za06ASdpWv2861Orl3vrfG0R6PzYr8RhQqj1cL/TRMQgX35UVV0WPfs52oSDO0jcg7vON
	 9zzSvzu8eziARzIGPlps2jCqhQouIUsTf3/B/tMPUSonlstPnJaR15cpjVQ3AMrMS5n4m
	 NgRFqKptIVVxz2Y7Yb/OSjH+V6LFpzX8HW4wGU8adYCdTCEVP5XG2UJOy2F/0xCjFpA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=irYQ0vGG;
	arc=none smtp.remote-ip=209.85.219.45
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A8AC606A32C
	for <linux-iio@vger.kernel.org>; Fri,  6 Nov 2026 17:47:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5A8AC606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=irYQ0vGG
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-91ea3f6a506so7755076d6.0
        for <linux-iio@vger.kernel.org>; Fri, 06 Nov 2026 09:47:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793987261; x=1794592061; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=eRHNQnSyg+HxFwUHDEG9hXimdhxcL6M8ICyQ7BsYEvw=;
        b=irYQ0vGGtJEO65oqBeVPfGhntnDs1Tg04R8NYPfcJIO8nCY2yk/xAla5YLR6XWgf12
         V7/Hd8xR2/GalEG2wlDsKuyTK73e8tCswlih26s6RmqYGUI1dmEQVq0kl9uwLbQeFpBq
         qCyaQok0PVrR3AYWyNGHK8Z1N+sa16mo6zl0IVyKP2xAStt9ERmUhSJgTtxEGwOzQJAD
         asUzwgQUUlDQhG+txlGzi3DjEc8k218OYS9v28X/nZEGDXgaWpnStVwKqHYqPCyq1Ad7
         UyM+b02QWrfJo70vyA3lX0NJCsAYGumArxT7I/duur6hdYakBgNo4YFvQYPh5k71Hd/U
         qjnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793987261; x=1794592061;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eRHNQnSyg+HxFwUHDEG9hXimdhxcL6M8ICyQ7BsYEvw=;
        b=pmYGKXU6Ipcb56GtMd0l1tK5IyIF7jEM+NzXWEqCv8adW3u5tryzxWCHpq+QQ7ChS9
         cMXTfYJp4e8JmqbgJbsjwexO1UdL7PoAdjJF8UADD7tryuVmwYwe0r/P7DkODOCfrkgP
         Wcwkn295G1YSUbIhEw0MCgnxSAvjexw7sFDM2Fyrnl4WB72h/cl6wHe7PWUsrH6m483L
         gNzdWiliF51tcwraGrIleb/5ODUto1u7SytbscvP2QXzNQe4qqG6fuhB4Yjbyez7G7/w
         VpDST4RR4YSfvT2JizlM7Zy5P1Fr+fZOj+u00zsRHOmHC3XOz1siDAUSJqbd11Xg43On
         FjpA==
X-Forwarded-Encrypted: i=1; AL+hErHrjLRZ8+Uxvqe/B6WG1WphE74XrIybG5k6iqG11VWL9sw508ZbnWHTDPzP1huZhDzhzGNqaxv+SF0=@vger.kernel.org
X-Gm-Message-State: APuU4Z/9YyJMM+VN6BjmdG/eYqupaZ9YsN6yJMK5lPVFD1kew9kEnFja
	I1Vy1rjdw9klLuzipEjBVFDKipNJ1kEJHdLJK0dq2TtuXGmcL8shEWkS
X-Gm-Gg: AYBFou25+b/AG9YqzG7SpEy9e/jiRpRr7ZNRKHiqm9fbfTuz9ukzWIQHmWut2rgltSf
	J2OOw5OGUzDr1Kg6ZwyNywKhZBgF2MHCpE3osV64sMjf0/xfO5YOAScAB+eraowQGIB+RXEoYF7
	XypixZC3Wi6GfQG+c4f+mf3KaDmuNlMW8/AmQ4hhtDS6ae8wcOas7b6IUIFaoGYhFxe3B1CYaFT
	hs1yomPhR4AQyyXLDWl9QrR/ZrxwfiQ/gwTTnHINZwff2Zy9y1ZAMxxCyFu0aqUoh/KxjKA864m
	CTOZ9iCpbojyqWgrD/Z3IJew93cs9gFqR+lKqjUwKhaNRSr4N2kosGq1KpmQj3Ixp1Rmj4nnteG
	JRJ9Esxg5pnn0dbFcyWnBZ82SbPxGdj9mEIqgMcuuNP2x/sim6O2p70ufGUlByeP90YMu2BK6/v
	SoxjQKKEkuSVYlNg9yKVz9NEwPk1qQoXlHVhxv6B3ElLSQvBDmVMKeI3xXnOwJXiu+hEfNyFNLg
	sdnUWqslofLZdd83VOuyriw+pCG2Wve+hkOOjC5NePB+YdhHc6eLGxs+c2uBEbgKBd2My+o/muh
	gkZt6EAGqMa2JBFUgH3UmjAtvJ5hSEOIrxL7764=
X-Received: by 2002:a05:6214:469e:b0:91c:6386:eca5 with SMTP id 6a1803df08f44-91ea977060fmr45840816d6.30.1793987260806;
        Fri, 06 Nov 2026 09:47:40 -0800 (PST)
Received: from linux.. ([8.34.174.240])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91ea6ab543csm25408536d6.39.2026.11.06.09.47.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 09:47:40 -0800 (PST)
From: Changyul Lee <lcy8047@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Changyul Lee <lcy8047@gmail.com>
Subject: [PATCH] iio: trigger: free the trigger ID after device_del()
Date: Fri,  6 Nov 2026 12:47:37 -0500
Message-ID: <20261106174737.2580011-1-lcy8047@gmail.com>
X-Mailer: git-send-email 2.43.0
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

iio_trigger_unregister() returns the trigger ID to iio_trigger_ida
before device_del() removes the "trigger<N>" device. A trigger
registered in between can get the same ID, and its device_add() fails:

  sysfs: cannot create duplicate filename '/bus/iio/devices/trigger0'

For example, adding a sysfs trigger while an hrtimer trigger is being
removed through configfs, or the other way around, hits this because the
two paths do not share a lock.

Free the ID after device_del(), as the error path of
iio_trigger_register() already does, and drop the "Possible issue in
here" comment.

Fixes: 1637db44413e ("Staging: IIO: Trigger support added to core.")
Signed-off-by: Changyul Lee <lcy8047@gmail.com>
---
Found with a static analysis tool we are developing.

Reproduced in QEMU (x86_64) with two threads running for 20 seconds.
One writes to add_trigger and remove_trigger of iio_sysfs_trigger, the
other creates and removes an hrtimer trigger in configfs. Without this
patch, device_add() failed with the error above 160 to 1148 times per
run in three runs. With it, it never failed.

 drivers/iio/industrialio-trigger.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industrialio-trigger.c
index 76926fee0f84..206ede2c9b3c 100644
--- a/drivers/iio/industrialio-trigger.c
+++ b/drivers/iio/industrialio-trigger.c
@@ -105,9 +105,8 @@ void iio_trigger_unregister(struct iio_trigger *trig_info)
 	scoped_guard(mutex, &iio_trigger_list_lock)
 		list_del(&trig_info->list);
 
-	ida_free(&iio_trigger_ida, trig_info->id);
-	/* Possible issue in here */
 	device_del(&trig_info->dev);
+	ida_free(&iio_trigger_ida, trig_info->id);
 }
 EXPORT_SYMBOL(iio_trigger_unregister);
 

base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
-- 
2.43.0

