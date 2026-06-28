Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F0A1A5B8A
	for <linux-iio@vger.kernel.org>; Sun, 28 Jun 2026 07:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782630859; cv=none; b=uXliFFurMHHJoFFRLBSy2If6yzopsWY5IaOXmQPR8yz3L+OR3qW9bHP31mYdQrY5kBPxrEZ2HABY8G8OqWyMcjn1TMc/fDvhUFN2z4ezsx/Hq5wecxU5Rpw6pNt2MSJTwiB3XYUMXzDQDjYnsZKscuZ/tHrKv9Nddo0uU47R444=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782630859; c=relaxed/simple;
	bh=xmwWSaBy4FHvE2lZSfawLpH4uzj+yitUohO7k8IBseA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JK5pUP3joKgNBkXHmVaHTxA0zfvjtaeWxTAfKDf+2R1mKDbo3Ti90Z7JwK1V8Zhj23B0EFQAMxJW0Vdb0ElJUAiawCREJscwJC8zhHTnZwSZR7vENFfPqQ3tHGg622oMfmuGlfkWXwoqQLBtCMgYNziduhheDYzaLvHkbgLX6vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gc9uIqYq; arc=none smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gc9uIqYq"
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-1397e093f90so3502641c88.1
        for <linux-iio@vger.kernel.org>; Sun, 28 Jun 2026 00:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782630857; x=1783235657; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iBiW+Jb5ofAnhQsaYWPoJcN5SGqMaVDonBUCRupHVH8=;
        b=gc9uIqYqQUrXuJeBbcpJUS5q4TotDHjRLnL4cM5DKgwtOIcsg4FU35k/jH4w1OWDbc
         b3+c1OLFALpcsn/w4it67tgk5PtYCdWUj3oln81Nhi6l7k1kJlz3SU8fK1HLlYzgFMJC
         vWyut4x0RrRwKuzYTXhIRQS0B+xupUSfFflZqEbvRAhEX5qa3ePa8zOmGK5/2UlL0wZC
         7xgMfjav2egEbw7kEujjeXlZG62GQ1XCBDieOJ7WJB/QdDkZFLEdY4uGiAT+SBrM1idm
         Sa84EOMnLnIU5Si0btfyPK1lUikusfyQYtUZBGHu9XzJQlDrLh6auvytc2oR02/98wva
         Hz0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782630857; x=1783235657;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iBiW+Jb5ofAnhQsaYWPoJcN5SGqMaVDonBUCRupHVH8=;
        b=hW4a1sybsZloTUbk6+ZU3jt6Tq582bFr9tBmcH9jNy/ZHnbpf2ODZTrvjVB3sMpS7E
         74dVJxelkIXpBe9AbgBiaP7lP+pwun5hh4mlyFJvCJTh+CtSJTIVGna2q5M718LS7OlL
         s1DUt2txa7XbHfau09GUShZ8TPkERFwcQppxkaGeMo/rd37WNATRk0C1u/SNiCgZi4hu
         X2atFs3Dhcw7Cg9Ti1HCKgrzdOeU/w0ApcL1crlbYcHbvjI1vXin0ltcVg4XW/H05qKg
         M05Ex6eZZ2aURWVOBfe7Wuk8NvA6rcauaG8HOpOEt5dliYlkXepsJzLuEq9m7cUx6AXS
         Nxow==
X-Forwarded-Encrypted: i=1; AHgh+Rowk+FXxqbN1/5mxC9zu/5DUA6PN6FWdLHe6SXWwF/CH8u6km4Yk6vEtJfyps3+Aj05cxGh5BEOfdY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxi+Flf7us5vxCSARMWYTPqDNsFVCNvIxSz3Gi/yOqiPhv1+Ets
	TMOc+8KnLm/4o3Y/hXUQheUd8P8xmQIMyeLpjxoW8mWp5pGVN06oU0R7mB3zm0fE
X-Gm-Gg: AfdE7cnYV+UEkUOnpYLruapjuY6BLpWPNPNfpPiCxEThj51gHSCe4pZrFvEQDpVHD7R
	hWrbQA3iR5BRjtfpG3KGXINAo018W8POoQvsKNx5NVvFeisstafKPO53D4jmi53ngpzsCeJlbug
	7oS7fGbzhrEiYBwfmZHogm+xRno47rf0dZrNmZWAh66yN+Wqs4X7abGHOHsAoZvWuMaEDpsSj9J
	GAW3Pe1X6VAgCiyDDTzCLeQ+2Bd9NByPc9hQ4+i09APNEy0dE9OdZt/ab+kkTSSpsvIDmEI/XxE
	KG5WoihOIuS8tXMp6ips6DdXsB3B8KoGXsvooAeZ0bTm+8hdk1Dv1o8TxP5MjWGQSY93IfhMTC1
	/nHI/EX851PP7R9Gszi1cM9upVhP0+cPBJe/ggl/PMJY4i9fKbvQAVtX0C3mcAu8fYgGfbya/iu
	CWwcp4Ofq+t8r3+BUJKrGEksM8I2RbimwJQbp+8hV/6eSiCdHOoMG7HSU8LQT/TSn6ww==
X-Received: by 2002:a05:7300:7fac:b0:304:2176:a871 with SMTP id 5a478bee46e88-30c84a265a1mr12633771eec.0.1782630856923;
        Sun, 28 Jun 2026 00:14:16 -0700 (PDT)
Received: from moksh-Nitro-ANV15-51.. ([45.118.104.214])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c7c9e9214sm34474940eec.20.2026.06.28.00.14.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2026 00:14:16 -0700 (PDT)
From: Moksh Panicker <mokshpanicker.7@gmail.com>
To: jic23@kernel.org
Cc: nuno.sa@analog.com,
	Michael.Hennerich@analog.com,
	dlechner@baylibre.com,
	joshua.crofts1@gmail.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	Moksh Panicker <mokshpanicker.7@gmail.com>
Subject: [PATCH 1/2] iio: adc: ad7779: Remove unused completion field
Date: Sun, 28 Jun 2026 07:14:04 +0000
Message-Id: <20260628071405.51030-1-mokshpanicker.7@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260627192638.5623df0e@systembl0wer>
References: <20260627192638.5623df0e@systembl0wer>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

struct ad7779_state contains a completion field that is initialized
in ad7779_setup_without_backend() but never waited on or signaled
anywhere in the driver. Remove the dead code.

Suggested-by: Joshua Crofts <joshua.crofts1@gmail.com>
Signed-off-by: Moksh Panicker <mokshpanicker.7@gmail.com>
---
 drivers/iio/adc/ad7779.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/iio/adc/ad7779.c b/drivers/iio/adc/ad7779.c
index 695cc79e78da..c1a99b4c1256 100644
--- a/drivers/iio/adc/ad7779.c
+++ b/drivers/iio/adc/ad7779.c
@@ -143,7 +143,6 @@ struct ad7779_state {
 	const struct ad7779_chip_info *chip_info;
 	struct clk *mclk;
 	struct iio_trigger *trig;
-	struct completion completion;
 	unsigned int sampling_freq;
 	enum ad7779_filter filter_enabled;
 	struct iio_backend *back;
@@ -852,7 +851,6 @@ static int ad7779_setup_without_backend(struct ad7779_state *st, struct iio_dev
 
 	indio_dev->trig = iio_trigger_get(st->trig);
 
-	init_completion(&st->completion);
 
 	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
 					      &iio_pollfunc_store_time,
-- 
2.34.1

