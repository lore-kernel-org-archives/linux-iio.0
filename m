Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88553350D74
	for <linux-iio@vger.kernel.org>; Thu, 23 Jul 2026 22:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784844448; cv=none; b=RPuVODMkvz8i7tgiTa9SHJAbBeb/oxmQdAduYswNSYLOOXjx/UhgDPxqWij9qszZjCIU3aBJGb9EMzqUab8fGwTEnrZaMhxq29WuOVNC58vXpbYxRIe/Xn0grabUegY8DAlXV2vfyKexs04tGyI4EsJ6wotTuIzSuMFtiugPFPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784844448; c=relaxed/simple;
	bh=osguR7XSbwltIxqlh5ZvUddHtkSF+K4U79IjIf1s5y8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=h1Exu1Fon0RkSNRJBwwqedVXFTJvVVKBpvdVKwT6ZQjPNYmzZBjuP9rw2EZGR84FFAAFlV8oroIZ4dk+MTIT28P9K8u3X897N9PXU/trpV4Ig/S5wbwk19vaR8YqG9bk0TruWHwhnBnwsEu+K2UXtyZ8ke8bkoTT0UxBuu3d3SE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JS0iH7h6; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JS0iH7h6"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-495437bb891so9406195e9.1
        for <linux-iio@vger.kernel.org>; Thu, 23 Jul 2026 15:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784844446; x=1785449246; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hNA7VmM12lgGWYutRZS6iedGuLDXvqM74kGa1hZEmpg=;
        b=JS0iH7h6gApQIq8r9KGfZqYZTJquhHMqVE2kJMp2AT6JuxcG/ParjbWz6urtwdG/pZ
         bNZWlzZNexFp2pLTvCMkJKsAfe6N/acMeQQpmCAqdCL20PlK6QKoOJCNrx+yPvzquuP+
         S6141dBVohy5Y3/gkI39K2bhJUuYzrlbM7vXA/ikOoMJQ0ConGsr+Ry4QPl6DwkHTHi4
         ae9kg6KGbNJBTFjGXxnaLhwQbAEIG4v1gfa5rH6jAX/SnkCoIKuf4J3B+hCqRXs8m3Pc
         bQUSLbxWhX+p2E3TCs+Y69RTXrZ3cGN9fmVMOEfLhRTseqbvAsfSdQST3LtOzXfQmeW4
         urOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784844446; x=1785449246;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hNA7VmM12lgGWYutRZS6iedGuLDXvqM74kGa1hZEmpg=;
        b=PRbl2YF0IYOaClaEmDkuximKmThPtq+bvT2xKNjuMsrMDzYh9wCNnYicdfUBF/jBRg
         ais3iCt8uv20zpqACwGqjzovlpS5mcZ5iYtMNPcTuienVhvipa1gvBFToAiXV5yF9qmA
         WFRSIIPk1LHm67I5QeMXeLb8T2bHTaDN16sNWzr97G7/kD9QifAv0MJGcRrYyQrlbW+o
         8/F4wEGxATETEEDlSZB3Z720Z+MCA+tn8hMCH7WJ5wEImWaS6kQuPTY74nqgn45pslxA
         ShpYKIGZ/4ViZmbI6HiAkgRNcb1Mm7XLj7CMoEMd7jPPfVXVjdDyrCBdX8qJZqowuJFw
         54LA==
X-Gm-Message-State: AOJu0YyiPvYzcJLL+HWvlS1eOSyUrjEdHQzZYHY+GsJtu7kWmVqfIuEr
	QA7QINnEShn0uT9u/ZJ3+uj/xPo3/2HUxbvw+3KISS99Xpgz1zRXGh4H
X-Gm-Gg: AR+sD10n5qZmy+IZ/KWbiD1/qY5iYEpFvFkY6PockGWrcodWGE8GC7l2VG8CFM121eV
	ungdAgIPJDguPohhb07LahIbVsXgyP/IOYI8426gsDx/sr7wudXpNXZ6c5xuy0HmvCo9cvcm471
	GXLU5QuPWH+0p3+gjEiz4qZE2k6rOcJoL2ZQpHsCbhnhEfXWLaV7VPs1uILfF1TzO98ymd8555c
	5D30/l9Uw4l2bEjOSflIUBVxZfgrciWi24XxaGSEuvJcGWzBMdNLtWpRfBN0i6hGADE4zrvyzUF
	2BOd/EwLByGTh0ddcYKPaVHLcfZW/1GPpZ9c2fyyfusca9lCq2TMT1vGiD+3pAGwhjEZ9PolP5O
	VbSvbxQ50EMk7PdtPfkJAAtxSgq06uRHRA/r+6zo26J6/xNZr0w8lQh0F3Okiu3Cwkdyz7XxGta
	Whge7r9gWbNlPc1g050Zw8Wh4m51GkOnLn1WsIsPFFzUn/D8bGU3U7r57iUYF77NNWIPrnIhMbZ
	da5cPZqkbBVcAQVT1gzEhpXhOeRHep29TZUe3e1ud/yB8hjJVAPMfmN+P/+ck0/WGZwsIFzH0sm
	4oA3Azr8KYs0lVFI3h5E2hhuvqSEPdoWciDcdr/cOHe/os92rUGtVS0FKPikkqgWD5KHInf+9f+
	xZL9UXpfmDfU3+DBC1uddDXOLlg==
X-Received: by 2002:a05:600c:630e:b0:493:f783:c46a with SMTP id 5b1f17b1804b1-49574589f9cmr44643285e9.6.1784844445660;
        Thu, 23 Jul 2026 15:07:25 -0700 (PDT)
Received: from [192.168.1.187] (ip-86-49-244-181.bb.vodafone.cz. [86.49.244.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4957bfe3687sm6935985e9.3.2026.07.23.15.07.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 15:07:25 -0700 (PDT)
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Fri, 24 Jul 2026 00:07:09 +0200
Subject: [PATCH 2/2] iio: light: veml3328: remove extra blank line
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260724-veml3328-cleanup-v1-2-240ecf3e5097@gmail.com>
References: <20260724-veml3328-cleanup-v1-0-240ecf3e5097@gmail.com>
In-Reply-To: <20260724-veml3328-cleanup-v1-0-240ecf3e5097@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Joshua Crofts <joshua.crofts1@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784844443; l=772;
 i=joshua.crofts1@gmail.com; s=20260530; h=from:subject:message-id;
 bh=osguR7XSbwltIxqlh5ZvUddHtkSF+K4U79IjIf1s5y8=;
 b=pKHLgXAJ5q0dOJnBdpJeeLVt2Mi9b37zyOAVlMn52yhNWDqQvL2Vuo7CdHfYlXzvNKNuo27nZ
 ICnT2oZl9pFBsLFXkB3hdJvxu3GyUjZuVQ01qdeXRT7xWWcm4oRCX7M
X-Developer-Key: i=joshua.crofts1@gmail.com; a=ed25519;
 pk=RTDOoVwgeL4oFdASj9U+cxJuIjXuXk73zkjnGOJKbEo=

Remove an extra blank line in the iio_chan_spec[] assignment.

No functional change.

Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
 drivers/iio/light/veml3328.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iio/light/veml3328.c b/drivers/iio/light/veml3328.c
index a65748466116..7884c8250590 100644
--- a/drivers/iio/light/veml3328.c
+++ b/drivers/iio/light/veml3328.c
@@ -70,7 +70,6 @@ static const struct regmap_config veml3328_regmap_config = {
 static const struct iio_chan_spec veml3328_channels[] = {
 	{
 		.type = IIO_LIGHT,
-
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
 		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),
 		.info_mask_shared_by_type_available = BIT(IIO_CHAN_INFO_SCALE),

-- 
2.55.0

