Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC09C284693
	for <linux-iio@vger.kernel.org>; Thu, 18 Jun 2026 23:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781824600; cv=none; b=lTgqT2X64gEp2fKztG83wa3kvfCSfriucmuaztSNaZ0a2JOcBJFVYC2lt10TBrx/MKpKUNp7VgbBFsZ7x6B5/oswCQRetUJ6vpmMa5gZLOuIa6y2QFP5Nc2Y/te3KCXfpLglt0Q04w3GtUKdcnPi0DRh6UIVUZt3P2h+m9QKnfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781824600; c=relaxed/simple;
	bh=uYkbjUxKxZ2WrsbVYP5zIg8sM3STYeehqLx9On9ms1g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nZ5kWinV+FxxNf7r95MwdxVwp/gOA6o74pwYjWMRRrxSTwdCExDZO0gYx5TXA0xeg0NoiZzYLC9YTbW9QVYfzJT+IAYeuzjV2M4s4uUeECmFATfb0XZ/uabZSc8xEHTHepyfaYxGK1Ck6HJQrfIjEeq426r8rZOsIbvw2U6bmzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d3iEKt0p; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d3iEKt0p"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-8423f236418so813082b3a.1
        for <linux-iio@vger.kernel.org>; Thu, 18 Jun 2026 16:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781824598; x=1782429398; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y6nfe1mUm5w2Z2at1HYxXfkhKWhlbFCWlsl4N5d/Kxs=;
        b=d3iEKt0pvCClSEmafcxRJJ9+bjRR3IzwtA0oNFMVyjbXT7GCklo1xatXeNbMDrxlwO
         AYNfAUAMxOB8LXfxIaK0DyEcKg0GH0f1eRtlgG0GcAs9Hk8Lhzr1HgAiGs+1K0rrZVdT
         7mDipRUSPtfwVB4mt/EX5EKALbY80ylG2XY0bPfDg1Qmt3CjpyRf6+DXMZ+VYVx+eroS
         Ou1p45ynWvjtzPwM2zuLo6xEkVwUw21LknhxlGH+y4V3/JLJQQ9RORz8Mr2sJzO8zSNe
         recsz3DKgIAxobZRj5/A9walpsF3N5n92tbUI8jAQxmSyrY2icHC5nPvAei/LjTYAV4N
         Qj/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781824598; x=1782429398;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Y6nfe1mUm5w2Z2at1HYxXfkhKWhlbFCWlsl4N5d/Kxs=;
        b=Z7KNvp2wFqfRsH136TlgwwCIkf07gSMUvm6tgVp84Zdq9NLOVs6kLmZH+8QdIDwyvN
         y2D+3/Zx4w7iobi+RYTSGZQG4yZgo2+a2xjQUU2av/fmgbKwFgvg+287/E5jJRZ3b3F4
         a2GJO8YWmO8IPSGf4IqWfUjm1mSJVXYXs7SUVa5DHFMo4Z5UGwvGvA+IoLgvWYo85HWF
         OquYVrL1ZCq6Wwd4h8WSAhjDzA7JP345bdfktJWTTk4kHMtXS/P+HBgEsYu/uIDC80S9
         vGzCZxpHCH3BzKcQxUxwROpbOQ2zBgy0LjwwfA6+vqMf5+iHwSdBbqF5z5AeJFc7vaRv
         t4gg==
X-Forwarded-Encrypted: i=1; AFNElJ94jfLXU6PQVaCZ+zh4FIcUjGB5TQQv6qATXEA5l6Qhn7lpWgVuofXxwXRAWXveM55tqmtc+OGOKkI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwqJCJWqstVom9hx9Rf6z20TJiBwfsFWw9PkYIehOU1iJgMZCs
	9cMh4ZnnFJeNlIe0pcxjYqY5AGguNd/cRUyYH5dgsOIKni0dKtXXXUBT
X-Gm-Gg: AfdE7cmIXj4w9/qc1z6juPc6MH0W5xzEkO3RMnIFGHitvkijsCVul8OU9RYZQy16d+e
	l0u+ZgBwmeB6F6O+OrtrhmjutUK0lnHS9dKF+WJV5vaOGNnFgIKVb0D24yN1fAq90XTAzDeXmSq
	HaIUJMLmQOPWpMOb07Ig/YNbcWzvhhdSc3S0frl68IyEfTvrIre8N8hyoTrvpbLzJbO75fP4t0g
	zpuwhR0/RSkkjc0I84PPRB77GzZJqAvlbneyynTfYRjN0ssgIc4thM3vMNE3VgQ9tggxyl8YU9T
	/74l88l/3YIL9lh89eT18DFN72SujL6jDeFpjjuY8Dxq2TqZzNr6bF7JHj1Im5eVyM9QEvzBIE9
	MQcL+yArogy/+7NjyK2Qgv9C/+3Vse7X7WKHqqdWrdO5R7K6lRZ/FMH7gwNQ6PKaaRqfVh7QdR4
	dz3UHkOvXzjcc5i5sSiN7RSia8oW2QV+kt5Wdf+z6Ro9GBsXIsSKzBTVQnkLIU0c8uC1xaF1iAY
	Mbjk2Mn
X-Received: by 2002:a05:6a00:124f:b0:841:89a4:5f86 with SMTP id d2e1a72fcca58-8455088e289mr1202056b3a.21.1781824598336;
        Thu, 18 Jun 2026 16:16:38 -0700 (PDT)
Received: from thorfinn ([2401:4900:8836:4853:aa0f:55df:e7d8:852f])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-845537fa3e9sm225135b3a.39.2026.06.18.16.16.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 16:16:37 -0700 (PDT)
From: Prashant Rahul <prashantrahul23@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org
Cc: Shuah Khan <shuahkhan@gmail.com>,
	Prashant Rahul <prashantrahul23@gmail.com>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Petr Mladek <pmladek@suse.com>,
	Oleg Nesterov <oleg@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Ogness <john.ogness@linutronix.de>,
	linux-kernel@vger.kernel.or
Subject: [PATCH 3/5] iio: adc: ti-adc108s102: log buffer setup failure in probe
Date: Fri, 19 Jun 2026 04:44:36 +0530
Message-ID: <20260618231543.413771-4-prashantrahul23@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260618231543.413771-1-prashantrahul23@gmail.com>
References: <20260616130612.73122-1-prashantrahul23@gmail.com>
 <20260618231543.413771-1-prashantrahul23@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Errors are logged when enabling the regulator or adding the cleanup
action fails, but not when buffer setup fails. Log the error returned by
the buffer setup path as well.

Signed-off-by: Prashant Rahul <prashantrahul23@gmail.com>
---
 drivers/iio/adc/ti-adc108s102.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ti-adc108s102.c b/drivers/iio/adc/ti-adc108s102.c
index 7d615e2bbf39..440afe584f5d 100644
--- a/drivers/iio/adc/ti-adc108s102.c
+++ b/drivers/iio/adc/ti-adc108s102.c
@@ -256,7 +256,7 @@ static int adc108s102_probe(struct spi_device *spi)
 					      &adc108s102_trigger_handler,
 					      NULL);
 	if (ret)
-		return ret;
+		return dev_err_probe(&spi->dev, ret, "iio triggered buffer setup failed\n");
 
 	ret = devm_iio_device_register(&spi->dev, indio_dev);
 	if (ret)
-- 
2.54.0

