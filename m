Received: from mail-qk2-f42.google.com (mail-qk2-f42.google.com [74.125.230.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E57D47F2F8
	for <linux-iio@vger.kernel.org>; Mon, 28 Sep 2026 21:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790629634; cv=none; b=SNTfQOqKsTXZItbnqqtqABjJKQE+0eKeRKCX46bYHKuUM6ggMlLJMI5xU7qVN3hatKRYTciPjcV1BDJXu0ZwFX/cmpYN+X08jRBvUG4Ah25A5qEX62EFAcRzZBbj3wBAgivZnvafNDaBSQjyQL+eeqcHs+8ImYqwcLXBYSzibAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790629634; c=relaxed/simple;
	bh=Gpg40NJhOK7FiALEjoDD61BtRfKkLJmAAC/7/tjw5k4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sdEbu+B88PDu/UF5uoc7V5oLg4Xm81kK/+GJZQQdhjy2u+1qiXGXUF6spFegEjRZKm25M04n62oAhc4uUUevFswv620NYvZp4WxGMbo+O4dHZMqdXCqSt34sn1z4bLfRJLMQg8rBKhinbyappOZR+pEGV3MRZLiaD3YkZ0qyHaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rvEXUDBq; arc=none smtp.client-ip=74.125.230.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rvEXUDBq"
Received: by mail-qk2-f42.google.com with SMTP id af79cd13be357-93be29bb454so524239385a.1
        for <linux-iio@vger.kernel.org>; Mon, 28 Sep 2026 14:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790629631; x=1791234431; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Q9Rmo3WqMy3UpRN33V6S5xmA8tMoREA9/x/jJyiwIN8=;
        b=rvEXUDBqiLeyOGGvSw74QTRHzTXAbIgr5ApuTP1eOkIrGroCZIPiv4GZ0KUN4G/c6w
         q98u42O+d4T4+oLh2jJlVghiG4dn3Xwp9PlCwz43P7hpUD1hXKjpqZZtuyx4BG3bJR9e
         +424rZOticc7EbME+PuK+IXuQdgOfQveV/hTqFskwSnhqzYJzpL6TPkRIu8045BPxysF
         xLKE/mqvGNViel5sL7AwxI3a2giRHM5jvEiFRvRwGP0VnyLhizMNjWjKJQZ8YyH0kPjm
         fSs+M0TnMD99IIksN21vF0xBEC2sCpU5WfgnmGnTU+o8ojb1r8vY7tOi00eXZxvnKvWU
         xRBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790629631; x=1791234431;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Q9Rmo3WqMy3UpRN33V6S5xmA8tMoREA9/x/jJyiwIN8=;
        b=XtiNBD4KMMdAr/tVsNNjpTFd87hg4Ebid9NE+tPcppxtVl8V7hPilWuWnBWKb+5KFl
         gqUGGGT66RDFGuh0I9jScuj+nUn5JHMJInRNmjd2tlKpEdgoLCwT5J6ZnZBDYjt3Dahu
         ljHNQOigmm/+aWOzw0BMZ0PyEjvKd4GWlAtXU8l+G8lfOhddaIzFWjmWxEgXz+rKHV4L
         /3lvLpNjs4h7RVeP0yGNjgpRqKWn3RgwmgTFkSfSLgoQCVzuSvb5bNckeQALQc+0DXdT
         OdqoZlAdL3l1PBkQx7zPtd+VK8xdRw9WNhDp7m74NjrjLCkv7zEzm/9P6fFWH+EPCWOI
         a8ZA==
X-Forwarded-Encrypted: i=1; AKwUvBwoN3WPNg3T5cKADXHg0TAs3TMsmyQy7SIF3YepPWU1nlBnZU+876/azUeDOIjRCdXPcxgdlYTVJVo=@vger.kernel.org
X-Gm-Message-State: AFuF++kmIj/Vca00fsl43WkDSiafnFfX0AOBSxM81K7ddVtQawAHvaja
	6ZcvxJ0AfJnwPyD95jtZSXgOihWo+QAJKFnpgIq82+i3c+YfUuMrn3ppfxwhlFMR
X-Gm-Gg: AYBFou2BgVO1g7lOqflC+Qu11hcGLs6fNxsJGwWltC3z3GB4U4ifliaLH3OmwYoSM9q
	XHP1asAEl8J9PVtknFSg+awFQA/UQzqsPceZCgkW4H2WEHpVt5foxQZTMDGYYiyj+ICfkOZT5mC
	Up+XLfmzhze5yz0lEhEKcmQoTVdVi2TRbyDa4gKC0zv2wNa0XSZlJt0YEanwB5E/lMfONRNAS34
	HYVnnYKpL6NMJu8ipH2pT1oMSh9/eaiAeWeOzEmC16xE3lGgiofAd2y+wEf46p1myewqYeqg7KK
	En8Cmx8W/zmdQ+yqPhr4RPxfWCecIfv3ZbK7TFq4G1FGPjhRZESgSMY74FGft3fFQK2rErWaknu
	FMBUZtVFG6n3+iWdppauf67pVp9qF9mGRk7jBEDoSV46M2D/LamhIsQlVqHRVTIDrpm+3sDnY0R
	+3U1xulRbATSU7wYZpJJLZeys3IMe3JLy6xQ4PnVbfOEOJyyyRIGuudfWJZyvHlml6NcntvGHhL
	M+/Ugqtt1oYD+Li5mXM09Y1uqC5i0Kne5CzglHhdAHRWvRyyzpAIhf1caXr3H1EVNHFoqeyILy1
	8Y8zhAw=
X-Received: by 2002:a05:620a:4495:b0:936:6c8a:f7aa with SMTP id af79cd13be357-93c43b86612mr2216726685a.4.1790629631346;
        Mon, 28 Sep 2026 14:07:11 -0700 (PDT)
Received: from cachyos-SlimIce.lan (1841343-static.dvnpiaaa.metronetinc.net. [195.252.229.229])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93c814342f9sm241348885a.29.2026.09.28.14.07.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 14:07:10 -0700 (PDT)
From: Jared Wuerzburger <jwuerz@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Samuel Dionne-Riel <samuel@dionne-riel.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 1/2] iio: imu: st_lsm6dsx: Use C99 initializers in ACPI match table
Date: Mon, 28 Sep 2026 16:06:47 -0500
Message-ID: <20260928210648.17166-2-jwuerz@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260928210648.17166-1-jwuerz@gmail.com>
References: <20260928210648.17166-1-jwuerz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the ACPI match table to designated initializers, in line with
the ongoing effort to do so for all ID tables. This also drops the
trailing comma after the last member of each entry, which is only
useful when more members may follow.

Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Assisted-by: LLM
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Jared Wuerzburger <jwuerz@gmail.com>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c
index edec898cb1..c4097ce2bf 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c
@@ -143,8 +143,8 @@ static const struct of_device_id st_lsm6dsx_i2c_of_match[] = {
 MODULE_DEVICE_TABLE(of, st_lsm6dsx_i2c_of_match);
 
 static const struct acpi_device_id st_lsm6dsx_i2c_acpi_match[] = {
-	{ "SMO8B30", ST_LSM6DS3TRC_ID, },
-	{ "SMOCF00", ST_LSM6DSO_ID, },
+	{ .id = "SMO8B30", .driver_data = ST_LSM6DS3TRC_ID },
+	{ .id = "SMOCF00", .driver_data = ST_LSM6DSO_ID },
 	{ }
 };
 MODULE_DEVICE_TABLE(acpi, st_lsm6dsx_i2c_acpi_match);
-- 
2.55.0

