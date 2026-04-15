Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1181F3093D8
	for <linux-iio@vger.kernel.org>; Wed, 15 Apr 2026 23:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776294340; cv=none; b=fdA4cQj4VhCGdYBmvbXLdrlPat6REPcQHGI1Q9mNlAR0xMnlVcLqe/4gcGAVokKkuInrEIFVhFMoLCSg2mtBrHgI21xapZXjH9H57QoxBBltlQ1AQmaZDZWOmktxx5z0z8yrU6s4NIUy0BWZ/5un+T75TTuqXojQLqr3DhyKojA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776294340; c=relaxed/simple;
	bh=m3Z8astH60FE+2JkpJnu1ubgLi8KcCr2cHq5yAgdwrM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IOroG4778tmkd7GDCw/Yo3s6gPSIC9hdHi2SSy6IjusN5BMIaY4Ol/Grl/L3J2dy34QFXL84mQLEvnuBvEap8Zd1/MgKHOXkTD3KskcggGn0FDb83Ce8knnaQYS2XxofX/Soy6/AxGW3zL7ZSuQaZ7I4/ne4WHvUG5+xsn6xHhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br; spf=pass smtp.mailfrom=usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=ao4uBXtV; arc=none smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=usp.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="ao4uBXtV"
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-1274204434bso54570c88.1
        for <linux-iio@vger.kernel.org>; Wed, 15 Apr 2026 16:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1776294336; x=1776899136; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NeZSma0Wi698vdQ/W3aq5kZqgnx7KIjXL2hEablokGU=;
        b=ao4uBXtV4yCS7OBtpVl4mdc4Ur9iZ6IEUlDITCwEXochyy3kjy8FNsdsqiFpHqhFFD
         P6ToUtSoAZCyIL5165penYpWB8KcBTv9Vl0awL5Vms5Oyc981B4hlMsiYQn9ph0uOhEc
         o0TRFcc/DJmmhwD5SaeYNKbh6F0szVnGyhVfiB/d1xS2WRzi6R1SqvlvV/TKHNgJsNiP
         cEQQb8v5s71iCScQP+HLNRbsrl2J2xXUrwIdmx35idYoo9+nglkHJdlc85qTTyZrVeUb
         GhZFRqP9cWhxKRgfiHkSA9JTEoza8lmwldN5X/2rSS+P/95AJDsIfl04QNqOSXZhYtsz
         RNXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776294336; x=1776899136;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NeZSma0Wi698vdQ/W3aq5kZqgnx7KIjXL2hEablokGU=;
        b=A3FiqNlQeUSjvxIlsHS68f55zMHgrYmYWl6Q2QcjB1thBfobZEQxiwBbTS8ReRZtQK
         P1c6M3VLSONzvZUOha6mQwD+dQ+QcxF9HHOU7uG3vV9f38yxk/ZojkzgWZAJiHQV5FwP
         Nr4ciGKkqcQC6VeJJvPiB1Y/XW/zjB1T/V59XsUjf4br5CB0aNUcEHoD9mPcyODSigsY
         EPlLA80kuI3zAT9qgYTu6sYUx1lSHMKqU0ZO+Ba8zDYYQQ8ZyOqIYkZ6kZBTkuM9SPVB
         Gu7UqJjZTczrZDBupQ0V8H5KB1PlvvTF2fFpgoTEMStVgv3+nl/vsZnKQmwaVfv6pEfE
         ZGJw==
X-Gm-Message-State: AOJu0YyrHLxKbQGKCMiUDtYQG2r+6EWNHtMV+/DuHoOWNqOuUrDrEcx3
	rqomIG5y6PX22rs9jG1csuw0+JNnjgAgZxo6uQxkvhsEcFIs1+NJE6Tc4t6FhepQZPc=
X-Gm-Gg: AeBDieuXDdX/G9ViY3P83CDEzIr3b8e/5lmsmXfgJ34dhq2L5XDAWDdpJCDmLjKZ5UF
	YUQ5wPfCxK0eWX/iFDgXJHnlzB2B/YNvcxB0CIh7G5cqUoinqXFaqLRtgAoNZWTGOWy1yWSRI7L
	0l3oC4CenWkUo6GxhhQ8ItfRu29ueYDBW8C+cczITtA7v0FFioaugfXC/jAIRk4wdDgtLJs1xkH
	q2MrOqNyMVOY9JcigejN0m762fjiSXv78kdlocqoCpMYHJC9IgTpX/LOV5RGP/xHibT4TCo90E1
	cGZviExhsnGxX5qooOMReT26vxiaMaVqtnEMyTz2M0as3e3rXn1IstaugAdCSv5HCloKxx9c6Ee
	tV0mpueE1KDxchGsgxgARz4dep3oS+GJww2wOEDd5GQFF1e46woHuFugvvVgCJMtAPVEvzmLiyi
	TPQiS8MI80/CD92PrbwX8QHjJ8bFIn3AninPba
X-Received: by 2002:a05:7022:1289:b0:129:1d25:f1da with SMTP id a92af1059eb24-12c63065810mr744826c88.3.1776294335627;
        Wed, 15 Apr 2026 16:05:35 -0700 (PDT)
Received: from localhost ([2804:1b3:aa80:d8ed:ae7:d3d3:e731:d8c2])
        by smtp.gmail.com with UTF8SMTPSA id 5a478bee46e88-2de8c90cd7esm5930580eec.13.2026.04.15.16.05.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 16:05:35 -0700 (PDT)
From: Erick Henrique <erick.henrique.rodrigues@usp.br>
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org
Cc: linux-iio@vger.kernel.org,
	Erick Henrique <erick.henrique.rodrigues@usp.br>
Subject: [PATCH v2] iio: dac: m62332: Use guard(mutex) for locking
Date: Wed, 15 Apr 2026 20:01:18 -0300
Message-ID: <20260415230119.17512-1-erick.henrique.rodrigues@usp.br>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260414233912.662606-1-erick.henrique.rodrigues@usp.br>
References: <20260414233912.662606-1-erick.henrique.rodrigues@usp.br>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace mutex_lock()/mutex_unlock() calls with guard(mutex)() to
simplify locking and make cleanup automatic when the lock goes out
of scope.

Signed-off-by: Erick Henrique <erick.henrique.rodrigues@usp.br>
---
v2: split combined condition in i2c_master_send error handling
    into two separate early returns
---
 drivers/iio/dac/m62332.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/dac/m62332.c b/drivers/iio/dac/m62332.c
index 3497513854d7..4cf06e50c1ec 100644
--- a/drivers/iio/dac/m62332.c
+++ b/drivers/iio/dac/m62332.c
@@ -41,33 +41,27 @@ static int m62332_set_value(struct iio_dev *indio_dev, u8 val, int channel)
 	outbuf[0] = channel;
 	outbuf[1] = val;
 
-	mutex_lock(&data->mutex);
+	guard(mutex)(&data->mutex);
 
 	if (val) {
 		res = regulator_enable(data->vcc);
 		if (res)
-			goto out;
+			return res;
 	}
 
 	res = i2c_master_send(client, outbuf, ARRAY_SIZE(outbuf));
-	if (res >= 0 && res != ARRAY_SIZE(outbuf))
-		res = -EIO;
 	if (res < 0)
-		goto out;
+		return res;
+	if (res != ARRAY_SIZE(outbuf))
+		return -EIO;
 
 	data->raw[channel] = val;
 
 	if (!val)
 		regulator_disable(data->vcc);
 
-	mutex_unlock(&data->mutex);
-
 	return 0;
 
-out:
-	mutex_unlock(&data->mutex);
-
-	return res;
 }
 
 static int m62332_read_raw(struct iio_dev *indio_dev,
-- 
2.51.0

