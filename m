Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 638213D3CF6
	for <linux-iio@vger.kernel.org>; Mon, 16 Mar 2026 17:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773681599; cv=none; b=XAsYHp0WRk3u+eqXal416FYH3EWskIxjxxBDqH80PgRwJ/u22JFXAvzoDwo7ielvLotxHzlu+B5pH9mQQ3HrgxpLH0dPPu9Kk++ytkqAw64gsgF9f3XgTbZsa/y90CapgcDieh6TaXOqwSLgXQRkVYHrPl9T05gYRK6YApR1vgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773681599; c=relaxed/simple;
	bh=F8JhpNRtISwTJCZ0mFH9huui70rVNKoYVUHt0NiS600=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=idL2K35IxWN4lbiwD7EV4B/bE1vaw/zbtZcjzq8/rWDZ8z4Du7piLpwjTdrM1N+bklJDcKxB8Zym/JJqDClTiSRu0p5uB8siQRvvkdyuaxRyAytfMsB3sUKsZ5/PiV7gAmmSI7JeAGe0eQIneKoxpSGujaMeki+sUSrNv9i/lRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P0XfAtwB; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P0XfAtwB"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b976536806cso590607766b.0
        for <linux-iio@vger.kernel.org>; Mon, 16 Mar 2026 10:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773681597; x=1774286397; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NwqEwLydPXTJh37lAhGuKLAvUQ1T9VTG2r0Fov0v/5k=;
        b=P0XfAtwBdOvGFKYo+PTFs/vZ/4mclwhGJT3I+2/p8DyJeNobGGBFtctWHTCjfGDXMu
         RzXC6DHveAUq9CYbkXeTE1tY24DoBmq0g2fIpgIQIy/vxk23Z+yKnwMBAxv1KKjld7wI
         gKh3y6WHEqPEnqz1ua7Azu38LDwElq2AfcNgSuIEwtXUai5FnLwUIdYwJqYWUXPWrNRc
         v/s+Gwyx1Uq71OCTmcZg71vQMLYcGGRk0fmYaPEc1G7+blAYLiZsoseT3l/dmgvEZH85
         u0GKCgT24x4RIYEmLOq8ALc4SyaUkuP/evt+i9GdwkitwPDYL2zIsi9TjU4bUzadbktu
         hWEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773681597; x=1774286397;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NwqEwLydPXTJh37lAhGuKLAvUQ1T9VTG2r0Fov0v/5k=;
        b=N0VZpY4Rn7ouqofcggbrhh+EG/wXmkWWc81r4IAK6AARA69emW0flAr/Xx5P7LU9Di
         vSAdrd2hWM2+zXchZsYOfwtuITl9I7pSDevA987C9MWD75AtziVui6KONMTAkY+gOKCH
         2hpBN+/nDhCQWQyuHR/CQ4hQ32XQjCyIxH3TdcDe5ub+8p7ASx0+cFWinGOs0asukMko
         hvYja4YGnlM84awS30/aAq78BHNNmrjXPBTnkz3GgI/HCeeQwIxbgJs98f/KnJOMmSxu
         XyqUBRBc+3Srf5geHNWwrAK99oAgj6JIl64Eg/UHybIGHmeW9ET7rhL6Bx2yLvktlaCd
         EExw==
X-Gm-Message-State: AOJu0Yy8wWWM8OUkAsPHA+roRoNNvDJlRRKO11+5eaTpMyaohJDi1rJH
	UgnLi5TawgfZfielKBgLNTnCVqJ5fE3w6qtrTDvytjtR28Gn3/zjbOSa
X-Gm-Gg: ATEYQzze48wlY2ue9nECMDP4Ve3LCy8TKRIIqKdeJQXbR0h3QMQE9743I/FtAkICSa7
	5+fDczcPJwqludflOyKMaBRIzpTDqR0qW9K7LjwuwWBtLT+tRP0wKrKuTpjjxcJMmjVXjfTGC/I
	qJ9BR1/A9zATsRPHfyzfPm1akr67UhGmdm9v5u7aSFq961I31USAj/BNjcAGEWaPYYfTPtw1s81
	JBvNRpwasmtAG+6eu1QdooKtn1DySsOj6KwWxuvTfj2yEXxcn/QydaEr4oAz+UeGeNwgzj57OvZ
	dBe20u0uqomJnbAGnaAjB3MkzPlSy7ia61ffxI/9MVLcpRoCATexvOJycgNqyjCKMREc+AgARxx
	ulyKD2SCQ05yhO+T1Aa5dviLgq32Jz+PiV+i/N0SXfA3DSu63C3I8+Z6jiWXdC+2Nt5vclYepR4
	vySXf6wyho6oqSZbl4JGCIsX5FQQ==
X-Received: by 2002:a17:907:7f8a:b0:b97:c5dd:c661 with SMTP id a640c23a62f3a-b97c5ddc833mr211421066b.45.1773681596530;
        Mon, 16 Mar 2026 10:19:56 -0700 (PDT)
Received: from [192.168.0.39] ([79.133.247.80])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b97846174cfsm505940266b.22.2026.03.16.10.19.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 10:19:56 -0700 (PDT)
From: Erikas Bitovtas <xerikasxx@gmail.com>
Date: Mon, 16 Mar 2026 19:19:49 +0200
Subject: [PATCH v4 5/7] iio: light: vcnl4000: remove error messages for
 trigger and irq
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260316-vcnl4000-regulators-v4-5-854fc2eaf54b@gmail.com>
References: <20260316-vcnl4000-regulators-v4-0-854fc2eaf54b@gmail.com>
In-Reply-To: <20260316-vcnl4000-regulators-v4-0-854fc2eaf54b@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Peter Meerwald <pmeerw@pmeerw.net>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht, 
 phone-devel@vger.kernel.org, Erikas Bitovtas <xerikasxx@gmail.com>
X-Mailer: b4 0.14.3

The error code is available in the log after return. In our case,
attaching a triggered buffer can only fail if we are out of memory, as
no other buffer is being attached. Remove duplicate error messages to
reduce noise in dmesg.

Reviewed-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Erikas Bitovtas <xerikasxx@gmail.com>
---
 drivers/iio/light/vcnl4000.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
index cd7e6ee42cc5..76aee16d479b 100644
--- a/drivers/iio/light/vcnl4000.c
+++ b/drivers/iio/light/vcnl4000.c
@@ -2033,11 +2033,8 @@ static int vcnl4000_probe(struct i2c_client *client)
 						      NULL,
 						      data->chip_spec->trig_buffer_func,
 						      data->chip_spec->buffer_setup_ops);
-		if (ret < 0) {
-			dev_err(&client->dev,
-				"unable to setup iio triggered buffer\n");
+		if (ret < 0)
 			return ret;
-		}
 	}
 
 	if (client->irq && data->chip_spec->irq_thread) {
@@ -2047,10 +2044,8 @@ static int vcnl4000_probe(struct i2c_client *client)
 						IRQF_ONESHOT,
 						"vcnl4000_irq",
 						indio_dev);
-		if (ret < 0) {
-			dev_err(&client->dev, "irq request failed\n");
+		if (ret < 0)
 			return ret;
-		}
 
 		ret = vcnl4010_probe_trigger(indio_dev);
 		if (ret < 0)

-- 
2.53.0

