Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BF1547ECE7
	for <linux-iio@vger.kernel.org>; Fri, 31 Jul 2026 23:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785541727; cv=none; b=TAtIy9/inA4k7BlLPMO6W4Fixo3E5LcmFX4FsklvskwRluCk71wOvB8WEJwf17aBx0KWuHWJ0rCTGnIruiKfDaANqpfHNaQi7pp2Xy5cpvd7dg2bsJX5656bzwJuRg38szG2NQhODeOGso0US9h++X1AWAeCr2GeFLlRYkxkVM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785541727; c=relaxed/simple;
	bh=c+6LBRZqxnlV+Poy+2P0UFws3gQZVbw81vTzagh3zv8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=FUJi5h71Miq+QH/5qKb6uPvb9jCUAWDYy24uvNoN/ubyR5eQlYstf3zQU9HKRFzyfWSFKOVVvs2I92Lwm4h2j2uKQBI6jXAlAJI7Q05APjttM88qBQc2kg2rfdaUoFkOenpAHviNeDOkBe65cWAhGYivzGwBvtzdRn7tbZQwOfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=XD7ZyiQT; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="XD7ZyiQT"
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7ec3b429a3aso1159674a34.1
        for <linux-iio@vger.kernel.org>; Fri, 31 Jul 2026 16:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1785541724; x=1786146524; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=VkynhgYqOsi1KeeeeqeVudrSYgLIueejsLxAWNaiNm8=;
        b=XD7ZyiQT53dggqKCKD163/EIUNWsRO3/OVxSblHw75qqQwBjHh/0bz6ery8nkdnRvI
         2UUKVgaF329vbX74VVvALm+HOssAMTARHuSKE8dkfdMANPT/wHvUEsP08RmFvT1drj5k
         KaFH+8DcPzTtEL2Z7cZ/Fdhimoh9BFJ62901xrQ72QJNGGZR2Nt+OAAcAsU2F2LkZlL+
         vlRUzwehTlYQWDVp428U37z1G1Ny7vCz3fzwtn5nO0WI3pk3v5Lo83XZ55xZ9JKSMhHK
         IOTA8qDgziYwT4CmwR+JLSvGkseoy1t1A66VWIKum0zo22GXgXLuP6CQlzUjQLVR5mCV
         ESiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785541724; x=1786146524;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=VkynhgYqOsi1KeeeeqeVudrSYgLIueejsLxAWNaiNm8=;
        b=mnbnMS2WgUE30+vcuWuL3b11Ke014aODotyIEOL0coJ+vh+f3LfYQhd5IRs7IWgLgD
         h9FNS3s8b8Kk/ielk1BJVa420xitlk8T35Ogku3RSf7l519qY5Z2pw7OTSKcKIHnVf0f
         7uxYlQO5/GRoBCbkwAy7odKYGi+WnAscHgKQ3zuleI/VH9vvyVcyScRoVtSGUQN36hs8
         /2uK8KLWEw3kkog9ZXZ/6VtX+/Bghiyq8fRAceWjK8rNAU1rmp33yuxubaDG31+vuW+4
         N0CpgWspT2fYCTbycgCaIBt+IhRpOl/o+7oKreakBVO9u05XdhEqaH+aSnTWi+zOPuuu
         wNYA==
X-Forwarded-Encrypted: i=1; AHgh+RoAjFda1tUjiNf6irlZCOodZWp63OloTUulL770B6HfUKUsEH4VNNotXbCi3KFwij/Rm6jazZmTqBw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRve7uo8iKc39rwnlBajjmGfjyrFOZQ6k4DyCbmvfsigtSEGoM
	UU1dO5oaZJDMIvtXp/oGllvGfJcWa7GOrsdD73Cq6OVKW03man5ql3DfMmB+b8XSn5Y=
X-Gm-Gg: AR+sD10HFDFkK7havtm/kF6cgy9yvUftM/asrIuV2jMgzb+UfIKxQUplFNBv8Sv1Vf1
	MzKcK2P1SK5d46JQ1Mon4xQPl+8+PzsfDaQk8X36+ecCMvC3xrWvSMGrAYbud9ZFgHO5goGxhpB
	IoiuAP5Vx6KuDIXAX5kSd8b2M9WWnobx9RCocLy/3JvmyCdLPyrf78ldRx14GwChemMVl6ox/RU
	JVIjrAxncfmhSwD4UNjk2bBEAQ8GhN3piLjEdQ46KwVS9m/x/829qdy76DS+vc7FUkMY092RaxZ
	/GKILQyHZC7KOUHQTkHXK9EDtdHQH5Oktg+q2fj3NC3bHgoamB9xEjIjUDvAHCjylx+umHWrgkm
	7zDVpXvzYRGPLDhDMjYFFmvm4DX+VUS/ZUvNt08gQ1G96TKMmvcSleFruLxFQkc/IcDyoO2XhSu
	7RjIWNJiwKnxR0yfw4/Jk2N0ncrDCbf+6rUwaT97HCvmCLtxSpImzjp3pmYi2LND+eyg==
X-Received: by 2002:a05:6830:412a:b0:7e6:fa37:9797 with SMTP id 46e09a7af769-7f196ce0911mr3290464a34.6.1785541724110;
        Fri, 31 Jul 2026 16:48:44 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:fa40:746f:401a:3b75])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f18ed3c814sm1736940a34.6.2026.07.31.16.48.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 16:48:43 -0700 (PDT)
From: "David Lechner (TI)" <dlechner@baylibre.com>
Subject: [PATCH v2 0/3] iio: adc: ti-ads112c14: continuous mode support
Date: Fri, 31 Jul 2026 18:48:09 -0500
Message-Id: <20260731-iio-adc-ti-ads112c14-continuous-mode-v2-0-eb13da38e8fc@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/5WQu27DMAxFf8XQXNaSYseNp/5HkEEPOmFRW6keR
 oLA/17aKdCpQyfiAtQ9h3qIhJEwib56iIgzJQoTB/1SCXcx0xmBPGehpd7LTjdAFMB4B5l4JKW
 0Uw24MGWaSigJxuARvFftm+zaZi8PgquuEQe6bZjj6ZlTsR/o8tr9sxHxqzA/P9d+8WyzwdUfc
 FuGgR97iGg8NApbr5yR3u36ebd2W5OQFceRcl+xSaojjoE5NffVPNn9LFavC6Uc4n37jVltGv8
 7fFYg4YBW2s40g9Ty3Zr7J9mIrywgTsuyfAM2aVMKcwEAAA==
X-Change-ID: 20260724-iio-adc-ti-ads112c14-continuous-mode-dd1580754609
To: Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: Chris Hall <c-hall@ti.com>, Patrick Edwards <pedwards@ti.com>, 
 Kurt Borja <kuurtb@gmail.com>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, "David Lechner (TI)" <dlechner@baylibre.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2213; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=c+6LBRZqxnlV+Poy+2P0UFws3gQZVbw81vTzagh3zv8=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBqbTQ+SZTFT8rXAloelnkDDzaPs32ZkG1AG6jnz
 H2YYyEL3HWJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCam00PgAKCRDCzCAB/wGP
 wOuIB/4j5GiYI54yW58D5kUY9QgDgyyCidybvdkYmmj4KSbC8CmmtWkFvkFzyflDo8zVTJAc30m
 6I8ja/2jEaQo+tsNNJae1gLb1dH2dZxXzZxWXCqhval0z+ToctpZ9VolwSQhyAHXDS2YRmrHT1n
 XXQ9hmv/mTyzCpr5cnBrW5rnAKSwJa1Oq7BrGsTfLucjgGf/afOVKyntKjQPvElgByHSiQCXnRn
 ObbwSHnbtiyScjpwlXbX1ZPYu+BhoyDtvhpUgoLNasWutxCM/5zEIPtL/V6H+Ynp7CqMvL+N8ny
 t2Lto/S0JJcfE2Hc+P151ISMC09ZHNWw1PLt4FNNERWuhac2
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

The TI ADS112C14 ADC has a continuous mode where it can trigger
conversions using its own clock and signals that data is ready using
the /DRDY line. This allows capturing data at higher rates since it
avoids the settling time between conversions. But it is limited to only
being able to sample one channel at a time.

Users will be able to select between continuous and single-shot mode
for buffered reads by selecting the trigger. If the "own" trigger from
the /DRDY interrupt is selected, continuous mode will be used. Or if
some other (software) trigger is selected, single-shot mode will be used
as was already implemented before this series.

Supporting open-drain /DRDY is deferred for future work. In simple cases
we have just done a `drive-open-drain` DT property for this, but on this
chip there is more than one pin (GPIO, FAULT interrupt) that could also
need to be open-drain and not all at the same time.

Signed-off-by: David Lechner (TI) <dlechner@baylibre.com>
---
Changes in v2:
- Split out irq and poll code paths into separate functions.
- Split refactoring into separate patch.
- Use iio_validate_scan_mask_onehot().
- Just return immediately on error in buffer_predisable().
- Don't set default trigger.
- Code style improvements.
- Fixed null pointer dereference bug when no trigger.
- Link to v1: https://patch.msgid.link/20260724-iio-adc-ti-ads112c14-continuous-mode-v1-0-9eb0b7a4f020@baylibre.com

---
David Lechner (TI) (3):
      iio: adc: ti-ads112c14: add DRDY interrupt support
      iio: adc: ti-ads112c14: create data read helper functions
      iio: adc: ti-ads112c14: add continuous mode support

 drivers/iio/adc/ti-ads112c14.c | 296 +++++++++++++++++++++++++++++++++++++----
 1 file changed, 267 insertions(+), 29 deletions(-)
---
base-commit: e0484d62e8e1cff75b210938be835ea6221bda59
change-id: 20260724-iio-adc-ti-ads112c14-continuous-mode-dd1580754609
prerequisite-change-id: 20260714-iio-adc-ti-ads112c14-buffered-read-41e5d1ca0dc3:v3
prerequisite-patch-id: ff8860e03c2f50d9502778dc5b62d26792ed6b65
prerequisite-patch-id: 267a53bbe8c25f05cfe1a448b1ad516cdb2c73d5

Best regards,
--  
David Lechner (TI) <dlechner@baylibre.com>

