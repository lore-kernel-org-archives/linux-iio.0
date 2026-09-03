Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B93B38757D
	for <linux-iio@vger.kernel.org>; Thu,  3 Sep 2026 04:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788411264; cv=none; b=RyNsQLuPIGHqvoGtnV/eYXqLw50pzTB4vTqiLVki2Un2DU+EUfKUzaEc4VORUeDVz0Def1Nm17vQG5Hsm1ls2JMmhIhjr5DgfZ8nfXxPbneZFpkxIK3C23Bdoph7qdc5niaBeo/GxN1JQhz90OnZeBjdxX6gyESyDLbFttRhmDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788411264; c=relaxed/simple;
	bh=eMG8f/UZxgC4RbM16xCsfyE7Jgui1peQP0C6f3+v8p4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OH8cymI05TUwGa0phmdNiJK+4hYLJgyU/zqBDyc3QpOvhnMWMuA5WUpIqHxe1ex1U8dTtfOzbvyQz4StEivuf4kQEf4p/PSiNBhVV10RDnR8vbjufA5laRDM5BMgpU6UljdI0Jnj2IyRIqWjRLqoHuB5f4m0rlEVuFAG0cipqaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CiUt6T2b; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CiUt6T2b"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-39927410578so3428148a91.1
        for <linux-iio@vger.kernel.org>; Wed, 02 Sep 2026 21:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788411262; x=1789016062; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xjkh/gkNj2lHRKcC2314o/TZsS+moGdJRwGE/ISLp/s=;
        b=CiUt6T2bKcZa6DuwotkYgblsABrig6Oca+ZiHtHwYwJjWMpdl4IWPuIrDjQt+GCNF6
         k48N++cTRW4IMyAa99789f57mvjEiuVJF3sLgE9Rgj9ONea8mHNMcvl19tGOaQHkbx1r
         0SEgJ2r0bV4LyUWK41jZtw92LsBbwnxZ61LCfQWVdv8tJ4F15x6izzoxwRoRwyw6RI4i
         iN4Q/U93T5Yi3RmvRlDwl7zFg4o+vy7Z46XUspd+lBHWElu+MTeDNZuRErxXelvEZ46W
         vDQbgIMHulEPTwK6Yzt4Sk+X46LaoDK3BodMLPTRYJTDlbb+GtA20I6assgmTWKk3tOA
         +ARg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788411262; x=1789016062;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xjkh/gkNj2lHRKcC2314o/TZsS+moGdJRwGE/ISLp/s=;
        b=mP31b+nQA5sYzGpCCBCl7zCeWhJhHTQxIuhd/Xn6B1SFlnJwqgB7R42G3hbfBxSzPF
         Vfs7a8bRnHVnp03fPlhMC0it9UakbjwCoiQiXJ7AjVcIVaiHjMaqX8PkgPONlKNGOHZW
         XVbMCNsRaAB3eTMbQurkJ+x4LJ8hdl9FL/zWc+n0xe+SDvLjpWk3HZGp3qNm/IDPYJjX
         ImO3m5WOg/TbvF6eU/o85BNH21yvR/Qwy2ONfkXPR6/QLRKrp6X4RIhoB48g03+BYTbV
         Ybth6H6yraKEiH9cr5dasP+Jn6xs0wXHHjCFNnPlNbI940rZafwNPhf+s6pDx9oGpZZP
         3zHg==
X-Gm-Message-State: AFuF++kh5Bbdv8HcofQV9PFPcAOXP3Yln1hPWzNQrnb42Iz27dt/EGMc
	rqox18f/C1QEAzTiWxFpx4NNjXpnA0DplcNi7LpXm+sR9T/lkHZS+9zT
X-Gm-Gg: AYBFou1Oq6s51yYJmZOfxti3bFeNVZGjXe/w0o1kpjKojt2CNtDIff5+qxXv/rBGaR8
	rimN6BPp3S741A6AEPuep/Nu2iJt39POwgz8xgeefCgbOCkaKo9HCDYn2K+EHde4SzeLT8BTXQM
	yXIKfdberoCt/ZOSUPUeK0+razT9Ab8lYkDC5Yfv42NdpCDZYnlsi5ezXagjuIDBQJmFOnUipcf
	vOjinEXOy4uJk7Tq6H00daZaACLOapdm+cR92jmJfih/khDKwdEoUu/HNtVXVYkaWRGoUuRswwZ
	Ewjqs1GQymwJTsghjp/scgP3kNbwb/oNu3W9mJxsZtzlgYBGuSojZTRX54X+2yLJHyC/5zATtzy
	V5CklXFRrigubFD8CwlKydG/AM0KxMcO+ssvJ8MoII9EocDUoIKnV3A0tDrFQV+YR76F5alYxjW
	kWVuhJ4B45JJKb6KOYgNlAO9dW0C/GRPfduMaKFuEWVa9VrGtnVxX0KiBi2zbpnSF9Yw==
X-Received: by 2002:a17:90b:2807:b0:383:5a16:bd70 with SMTP id 98e67ed59e1d1-39aee16f931mr16587728a91.16.1788411261874;
        Wed, 02 Sep 2026 21:54:21 -0700 (PDT)
Received: from [192.168.20.42] ([115.70.157.242])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39ae8f1cf6dsm2300801a91.3.2026.09.02.21.54.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 21:54:21 -0700 (PDT)
From: Tsz Shan Chan <tsz.chan.dev@gmail.com>
X-Google-Original-From: Tsz Shan Chan <tchan@jacques.com.au>
Date: Thu, 03 Sep 2026 14:53:47 +1000
Subject: [PATCH v3 2/5] iio: light: vcnl4000: clear DRDY interrupt when
 buffer disabled
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260903-vcnl4000-v3-2-5e69c2e715a8@jacques.com.au>
References: <20260903-vcnl4000-v3-0-5e69c2e715a8@jacques.com.au>
In-Reply-To: <20260903-vcnl4000-v3-0-5e69c2e715a8@jacques.com.au>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Tsz Shan Chan <tchan@jacques.com.au>
X-Mailer: b4 0.14.3

on vcnl4010/4020, interrupt status bits are cleared by writing 1 to the
corresponding bit in the ISR register. If data ready interrupt triggers
when the iio buffer is disabled, the DRDY bit is never cleared and the
interrupt line stays low.

Clear the DRDY bit in the interrupt handler when the buffer is disabled.

Signed-off-by: Tsz Shan Chan <tchan@jacques.com.au>
---
 drivers/iio/light/vcnl4000.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
index cf55fe6afcba..c5f34e748e1a 100644
--- a/drivers/iio/light/vcnl4000.c
+++ b/drivers/iio/light/vcnl4000.c
@@ -1545,8 +1545,13 @@ static irqreturn_t vcnl4010_irq_thread(int irq, void *p)
 					  isr & VCNL4010_INT_THR);
 	}
 
-	if (isr & VCNL4010_INT_DRDY && iio_buffer_enabled(indio_dev))
-		iio_trigger_poll_nested(indio_dev->trig);
+	if ((isr & VCNL4010_INT_DRDY)) {
+		if (iio_buffer_enabled(indio_dev))
+			iio_trigger_poll_nested(indio_dev->trig);
+		else
+			i2c_smbus_write_byte_data(data->client, VCNL4010_ISR,
+						  isr & VCNL4010_INT_DRDY);
+	}
 
 end:
 	return IRQ_HANDLED;

-- 
2.55.0

