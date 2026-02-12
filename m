Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD8029D29B
	for <linux-iio@vger.kernel.org>; Thu, 12 Feb 2026 06:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770877874; cv=none; b=YUc7Us3ZFuYWzbKHpnASAOhDakPURjYo0YmwHAkIMH9sBLSKQb5hETid4RHYbvclKxYwy9SIX2I0Ioye5Pi9eUiIJR1iDbnDqtl1lxZmhMJrDQra3W9hFBOodWIX2obPK7qj79pfodMrsM+u2rgF0L5bmSYfySFw2CfBbwXjvww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770877874; c=relaxed/simple;
	bh=EBFLOEJADpoTiNro5GpxLUVSOG8AoEttij+vms0hlDo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VYkQFUSI3Dx8SwdZoDyiHCt6iARcidbUJKBJcASvYuPmun4TJuXJleVJAW9mNyjPZK0jkQnhdZGQBtzMWhNP9P9hx0OWdryx17NKsBWdIRWG6y7m309ZfUsQruNAJ+85CGye7s/4Ky94qOtqDe8oxojFSeyFF3OoiPF6xi8JN4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LUzz8GPy; arc=none smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LUzz8GPy"
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-124713e4244so295899c88.2
        for <linux-iio@vger.kernel.org>; Wed, 11 Feb 2026 22:31:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770877873; x=1771482673; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zMYuxthpUhmu7qx+N3HqzMNJ6PmngHneJWKEskMoDgI=;
        b=LUzz8GPyE42Ejw4zZUj8wi96RRJBhyPIvYEHF//vub2Z8exdudY/1w1sj77DULU4qa
         jjRwHz0/Ng8LwyJ51CH7a/Ku1n7yFl8jPkuTWVpOtUVr9WzKknRIMTdpBqENvrp5ramM
         A5hRydasvE6UPKoXMZJvc6g94mdaDnLYnddWTc5oHSOVhaXzLY57xEnkuLcNfqsVy1TD
         PNMmhmMtMSOIuLMP9rf+fJTtlUYvsa0PLptHgPmJtsHVBPiy0E9JgCtgGk8SDf6xxl2w
         J0kcwnpqoymSnE7c7rR61hIGy3oodZn4UMxB/HI/7kmNVEcjZyCMZvbXfLsTuiPfb0G4
         0n9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770877873; x=1771482673;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zMYuxthpUhmu7qx+N3HqzMNJ6PmngHneJWKEskMoDgI=;
        b=pjbiOY4vsHyRCi7DYTNrBoWwgmtjuWMtkTvruiaka1PLm8dNSeA7XajbLVFeBpVkgF
         Q8FxUjYmdtgWUihTPISqWmBhdlGo8Nfop88cY099HdpMsjPB23H1sFDo+/nWiQMxefrB
         SIsga5m6ZlhEc3aoh95D/zE1lw0wlideRGyzZdk9umW1u3LwP2LvU+91WchJiIDYK9r5
         M2gDWqozAsGxvcog+j7aR6Pwic2F+J+gcP8Vk3I7fNT45FOnZHCVmXovdVnKT5F7gwI1
         7I02J4i3U3VYFOTjHBmtXJ8wme6al06Ms1Rr5FIcvoae7YufUzbRPTWHB30Gu/qmG+dS
         ZSmA==
X-Gm-Message-State: AOJu0Yx4TyW+6/Xnp6t/PQ0c324kVm0TiviyByGy1HaRlRrJOKXbWJZp
	80T7Wu1No+Imufkc2fKkGsUMqJSDfMSy2wiCa57SKvsc/QSzgMh6jdSr
X-Gm-Gg: AZuq6aKwzq4w10POzbmn6qtUc3t4UJjnLy/+nTYcxjV0TjW/fupLRgWjdSzQsP/oBRX
	mwX2zWDP3f437jkwcT4BkRXANMDHSWiURbub93S5COI8sYQCZF0X83VJVb92YJDd0RJYoSdB/Qs
	a698Dnizhojd3YG+gSm4l1w49pnhpgFlxR2EMvMNxMhtCIakFvUYAjeTxS6+gi2JCYFWlS4LnYD
	j1triDLHQ06SH01s2JOu05JS9z+oNPdZpfxI4OLMZSoHnL4ZEa3i0xRbF9DOdbC0YYySHVOXuRs
	C6QZAx1Jud2/gyCpAHj6ikwXoGK6/rNP2XcP9JvwZB0kMrlwaE6hGU8cinsKGaHoJAp8FoKk0vb
	IiscOOP61hMRp5UJJ7gcvM+md0FAQjDRgJ2fcClm3pqHYZtOiAJxhgjC/ohel2i1DcrbM4wdkrQ
	ucd1aQHd+Tmzz846OUo6Yj9UtDOfAN2D1ZJp14QwabCtrt0p7QZNj0MWz4rxGWReF05Q==
X-Received: by 2002:a05:7022:6993:b0:127:1186:8139 with SMTP id a92af1059eb24-1272f79ca53mr428466c88.7.1770877872582;
        Wed, 11 Feb 2026 22:31:12 -0800 (PST)
Received: from [127.0.1.1] ([45.32.86.188])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1272a6f29dasm4313870c88.12.2026.02.11.22.31.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Feb 2026 22:31:12 -0800 (PST)
From: Yasin Lee <yasin.lee.x@gmail.com>
Date: Thu, 12 Feb 2026 14:26:52 +0800
Subject: [PATCH v2 1/4] iio: proximity: hx9023s: fix out-of-bounds access
 when copying firmware
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260212-upstream-20260219-v2-1-2b28fce5d09e@gmail.com>
References: <20260212-upstream-20260219-v2-0-2b28fce5d09e@gmail.com>
In-Reply-To: <20260212-upstream-20260219-v2-0-2b28fce5d09e@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, yasin.lee.x@outlook.com
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Yasin Lee <yasin.lee.x@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1033; i=yasin.lee.x@gmail.com;
 h=from:subject:message-id; bh=EBFLOEJADpoTiNro5GpxLUVSOG8AoEttij+vms0hlDo=;
 b=owGbwMvMwCEYyfeRr6Zs90zG02pJDJm9xUtLXksv4T6UWGju81bUMdpsZvnHnP/TLqxU/R0id
 pyDO76ro5SFQZCDQVZMkeXM6zes+aoP9wT/ds2AmcPKBDKEgYtTACbifIzhr/hdDZc09XkaghM2
 qiQvt8+2Y08S27zMauPMbLdp5zWL1jEyNPPxmy+w+TdF68KOeXqzc6wb718R/fRxrYjyn8dSvb9
 ZXgMA
X-Developer-Key: i=yasin.lee.x@gmail.com; a=openpgp;
 fpr=CCEBEC056F25E1BC53FB4568590EF10E7C76BB99

Initialize fw_size before copying firmware data into the flexible
array member to match the __counted_by() annotation. This fixes a
potential out-of-bounds access that could lead to a kernel crash.

Fixes: e9ed97be4fcc ("iio: proximity: hx9023s: Added firmware file parsing functionality")
Signed-off-by: Yasin Lee <yasin.lee.x@gmail.com>
---
 drivers/iio/proximity/hx9023s.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/proximity/hx9023s.c b/drivers/iio/proximity/hx9023s.c
index 2918dfc0df54..ad839db6b326 100644
--- a/drivers/iio/proximity/hx9023s.c
+++ b/drivers/iio/proximity/hx9023s.c
@@ -1034,9 +1034,8 @@ static int hx9023s_send_cfg(const struct firmware *fw, struct hx9023s_data *data
 	if (!bin)
 		return -ENOMEM;
 
-	memcpy(bin->data, fw->data, fw->size);
-
 	bin->fw_size = fw->size;
+	memcpy(bin->data, fw->data, bin->fw_size);
 	bin->fw_ver = bin->data[FW_VER_OFFSET];
 	bin->reg_count = get_unaligned_le16(bin->data + FW_REG_CNT_OFFSET);
 

-- 
2.43.0

