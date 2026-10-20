Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792485754;
	b=iifcQntNMkJq1BhQpEE5WjRifb2vIHzAODyYWu0DL+jOmda+g7CoXgnmEaZKfu8WmvVP
	 smqXWgFac0e/BkX/QSzD8WuO46DKZ8NkIxRY+LVd3GU2GLsINvjIdkcX+tJ+/a0FfGLvy
	 Lau7VlcMsG9T2MJzee1uLAlXBvTlWxxbqpf3jfrHf3xf7nWWhvCA5vLxCuggoV37W0IF6
	 i4et97Tco55MEmKCy4w02XvQ7TfrPNJhxCemI9h4GTGhJ4nkwU7jHACWdaWfcDfLVktuk
	 bs9T2VZ14j9tJ6Tj7ZMXK1x9LS7VSbv3IcgxjF7AsXWGc8TcvKeVPPiJi54wNUKyODw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792485754;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=QH2EnkYD50xonK1mDLEj4iXvUx+pAnRtPwytnFJJ+n8=;
	b=BUquMt//nuGlucqrJ/9ADx5rwYA8+wIifA/hu1lHQnk2UdKo5woctHubo8bsjFTI0Y3Q
	 R/vNR/NoSG7uKxSHf6Iyg8brd4QLDX0Pm0Rrd6nWAC7scprpqK/qsaj0B8fDeXWEwvgcC
	 DelzI+p9BuN8kH+2O8UI4+KYAjX6gIqGLKdJnOPGZXadmY5HmErkVQIpyMOLRR2nHGmvf
	 LZdD5PEsMlNGe7WlwyLSF5YQGM5ps4Vmrm45ycbi3dIqZuU+LNRR3WSuLRn1266RGjwSQ
	 e7GohkqYOfXbaP6nvbAT18u/de3LhvP/ke5wTJbY6RTrGz9I4YqD3ieJg79JhFJSDrA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ETFbBu68;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE7B606A31B;
	Tue, 20 Oct 2026 08:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ETFbBu68
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1792485754;
	b=BlAZ+LNeUGeNkXmUsyWWQ+nEYZ1RqCMDxtUyUrhukYTDrRyugKyE/aHvXtF8HdfJfuOq
	 yDGsabMTWDsuGtZTJw+pDJ5pv0vU9TOjkL6s7ewWbC22yiOd8YZ5NUS3hJ8wvcdTNRwIO
	 ZdSxQVQHy+9zilat4BoXg7FWizAhxbC+r2SPklNv1kWtVKRKXsyyEYIg+1JViybyL2iII
	 UcuaSsGio25TWidTfaMTUg0VM0uRbZZR4OUSjOz6hFMskBLcDlqPL4rZpE0deYYoeoo4m
	 w3JYUTlG/xB9Eqt9WBA8axqcnnrksrrKVCx740jXoFY2lmUNxOyuQ5dTPkQk/B3H9DQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1792485754;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=QH2EnkYD50xonK1mDLEj4iXvUx+pAnRtPwytnFJJ+n8=;
	b=wU68RCAby0jZP8e/TbJTwf0qig+DL6Eo8+VwKHE4cnYJnVVQiLQJB7I+3xYdWkrFpr86
	 TrOjIfkzeZxepVSPwtutioOJavxqTZnIrtNobjiD7k84RIA1yF/CZI+PHDXcs/lfeVwOP
	 SzZpcdHcM4KrT5RulrvnY7cuHSwIVuLPVwllyUQPuaU8FIH6xrSacR3Am33ReqhZyu8/1
	 vHbSjj+x6x0wxGipuj9ihuXrEFAG+c/Lowd/0KPBFtlmoevm5+FBF6BpDzNe6WEWU1xoq
	 geL7nWE5B+OMjpNKRQWDAkUV8B+Eqy5/iX/vU816A71GPA0XtFIeq0OQjhUmvmNMezQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id A25931F000C4;
	Tue, 20 Oct 2026 08:42:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792485754;
	bh=QH2EnkYD50xonK1mDLEj4iXvUx+pAnRtPwytnFJJ+n8=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=ETFbBu68YLeb3pxxQoh4D4GJoJzWVAabOHVCiCAvGjb5ExDVyxWWIKWkkLL/wA9Vw
	 xZxUIzNs2ShUkhX4jVxx77JGqCyvrmvRRonrKAn4jM/ST206FRS8ACeUlbKuzidZDk
	 i7aWNiEJJ8aTr/0AOKPmXIHANqlLkF2OVsJQxrm/D3sDrI1sXS0VFEG9aZ6HCcVpRn
	 hGt6cjkIBmBZAhY07WI5JE/mW6Peo96HFI/DfmDCnOCU8jkTUC68tlh4INWekolcQ8
	 bmAaqBZCKzldfh+t3sfkDxCmtj/oKrw2IRUjett1AyfGFwvyZvKAghFsiuJmX532gn
	 G84PqIpWIa5Qw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 27C7F406D4;
	Tue, 20 Oct 2026 08:42:33 +0000 (UTC)
From: Jean-Baptiste Maneyrol via B4 Relay <devnull+jean-baptiste.maneyrol.tdk.com@kernel.org>
Date: Tue, 20 Oct 2026 10:42:30 +0200
Subject: [PATCH] iio: imu: inv_icm42600: update gyro start and stop delay
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261020-iio-imu-inv-icm42600-update-gyro-start-stop-delay-v1-1-ed52290a4ca4@tdk.com>
X-B4-Tracking: v=1; b=H4sIAHUp12oC/yXNywrCMBCF4Vcps3ZgEiSoryIuYjKtIzYJuRRL6
 bsbdXPg25x/g8JZuMBl2CDzIkVi6FCHAdzDholRfDdo0kaROqNIRJkbSlhQ3HzUhghb8rYyTmu
 OWKrNtW9M6PllVzQnb0dWhrQi6L8p8yjvX/N6+7u0+5Nd/YZg3z/AlwJJlQAAAA==
X-Change-ID: 20261019-iio-imu-inv-icm42600-update-gyro-start-stop-delay-68dafe160210
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792485752; l=1399;
 i=jean-baptiste.maneyrol@tdk.com; s=20240923; h=from:subject:message-id;
 bh=rYltn7fKB8YhPW/iRMCE7L2yTLJevy0EmSTjB4xuN+c=;
 b=Un0R6vJGxLUzCcYGg0lb1WZ/8zxo6QNxOlLOvC8TBtfKqpRC72aMq0j11LKV9QpxNaww07QeS
 xL6+W6DGsRuCs+oQOsGrSPRHubEQyds4kp5RK32/fcVVsu+z6GbbdlC
X-Developer-Key: i=jean-baptiste.maneyrol@tdk.com; a=ed25519;
 pk=bRqF1WYk0hR3qrnAithOLXSD0LvSu8DUd+quKLxCicI=
X-Endpoint-Received: by B4 Relay for
 jean-baptiste.maneyrol@tdk.com/20240923 with auth_id=218
X-Original-From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Reply-To: jean-baptiste.maneyrol@tdk.com
Content-Transfer-Encoding: 7bit

From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>

Following datasheet gyroscope specifications, the maximum start time
for gyroscope is 45ms. Stop time is required for letting gyroscope
mechanical structure settle down before enabling it back. 50ms is a
sufficient value for that.

Update values to these numbers.

Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
---
 drivers/iio/imu/inv_icm42600/inv_icm42600.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600.h b/drivers/iio/imu/inv_icm42600/inv_icm42600.h
index 3737e79dbcc1..c4a928fd3b8a 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600.h
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600.h
@@ -439,8 +439,8 @@ struct inv_icm42600_sensor_state {
 #define INV_ICM42600_POWER_UP_TIME_MS		100
 #define INV_ICM42600_RESET_TIME_MS		1
 #define INV_ICM42600_ACCEL_STARTUP_TIME_MS	20
-#define INV_ICM42600_GYRO_STARTUP_TIME_MS	60
-#define INV_ICM42600_GYRO_STOP_TIME_MS		150
+#define INV_ICM42600_GYRO_STARTUP_TIME_MS	45
+#define INV_ICM42600_GYRO_STOP_TIME_MS		50
 #define INV_ICM42600_TEMP_STARTUP_TIME_MS	14
 #define INV_ICM42600_SUSPEND_DELAY_MS		2000
 

---
base-commit: 43ffda3c7f8456bbe641ae8249a077a361b97880
change-id: 20261019-iio-imu-inv-icm42600-update-gyro-start-stop-delay-68dafe160210

Best regards,
--  
Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>


