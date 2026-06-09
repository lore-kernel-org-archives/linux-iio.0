Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7242F3B5303
	for <linux-iio@vger.kernel.org>; Tue,  9 Jun 2026 16:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781021849; cv=none; b=QmzShgsLTk87eRoPVFm9vCRxki/z4NrGQHgQvrx7kqlX4WwQVNF8e4+e18aSJngCNd/4LVWYlBZg4cTxCT4fSP9EbJaEwkdsrraO7C3o15ph7HpGUzJqc4lltz0Ix/K76Wt8Rb+OF062RlazXzDjIP4QeY6MlE2HUlReJIjkm9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781021849; c=relaxed/simple;
	bh=iGsfYaqqPaggYpWFXvV7wMfdK7JOLFerDStcNgsImFU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Sni8F3SwH8DCAMASrto6xVohf/KAoWGWr+Wxr7HQHSyM1J3MEV87NmyXLx2qFCNcL8lfYnWoQ6reVM6RUtXqQx6OrWPzPF2vTGl6kNQLC+2/w+pyhANx9QAJy1RdBoru9EhFWFmvF4JPdWmL/8jx9W/FKyiO6mn8g/tbaX7mixE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SgaPRNEt; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SgaPRNEt"
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-43b7e186a0cso2230642fac.0
        for <linux-iio@vger.kernel.org>; Tue, 09 Jun 2026 09:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781021847; x=1781626647; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uYl15/ixnkO8fppgHDZZ9tihfmZdCVJsYU8HZ5wS+/I=;
        b=SgaPRNEtSLpbQl07cHTi8gtXIdnKkml1FEXtDskZftpgDIRKyIzzGb6TWnbfm+OGnR
         PaxOK9dJ+zJLITd2f/PEEMBooAduajcLyXX/sAxmbnhaVBfQy3togpawbt3oM7V1QW66
         JhcgREU9y22H+x93ZICR8Efu75kOH35cP+/XYTONZy0Lfxn9fzkKGR1JILZ8g5Z7SfVn
         XL6D083gXQdl+S5GmPXHVGF04Tb51BhTINyDi9hDcNYTwQhznlhblPT9MZ/4LaPMwgLZ
         M2niZLruMthNrlwBILnGxChGqAVI3gUnkw3WgmNrsjvOOluwI4wAxP6BBiuBfx0kjQJQ
         quVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781021847; x=1781626647;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uYl15/ixnkO8fppgHDZZ9tihfmZdCVJsYU8HZ5wS+/I=;
        b=Qvguk3umOOCnHhc4uHNaX9FrmIDRTJLIKg6WraAD5qGq7gT2WljXWNIjAYEi9D2F4T
         fECeaKl/Tw4ZG8Mc9K/QSVEZeeC7rjzmBmyeaa05XBBEbI6RIfF3ikOiWJkQptUyb7Uc
         H6wtY7JtPyBLrYAHsIubmHWLhjh7A6p5lLNlwouZj2AcwD6wr41HXDUcl0y4Dy+Wfk++
         FB0sU+ixwBLszLQ4rsVkUGmWPfjpThmpjFEsWQsMooZcDBcRpMIq6ba2x2IydsaXlv4y
         Mj3H2ikIi6gKfDIUvYpTqFtV1dJUF176Ec3JTPFbzuE40txdbD0DWnMrQNS0OFiZd761
         k6YA==
X-Gm-Message-State: AOJu0YymyQoVJTqe1AlUjs7jl9QscyTyKfZ51YGX4q6pFuosQZJNfUKl
	FezKhsbaRh/kV1MnS2P4H6F2hNgivwrHK8U89WLZI14LP8DHMDTKr55b
X-Gm-Gg: Acq92OHG5MVoOzTD1LpMAeHT5iCXAmsArHXNtBYI71WgwjaDUXjy/kegTvIjMfWGRui
	4CPaJxhGDGQoxcnVIEGn+5Zxm8N/3fUDRoTbEpyOT/frHXSFxRaBmm6xQwqR1EV4vELMm0r5bw6
	TD79R6McSvX7dA7iSe11trNXqURgtXHU9zWJdL5EkbRB7G1FzrFruWhjSpLwwxWeEYYuBc6EHfO
	Yu6hb0vrPI5i7M+rn9Y7iAwrdmQCqf8DIXrVD/C2dEAEvlsAYTHnD/mQEKjjdpamrCuBgHCdAIR
	8lX5laV8YTvMRySh2523ibZuK4eXZELv5rFUtWgMl+Qb5RgajEWxLLjHLUJ4vTLOwMwoYEaCkQN
	Li2x69+Htp4SY09Sv5nBJtEzB0e/hY3Ypm9uixFFl0683cBbE6H5C0ksiEpIaTLVw3Qe2iUQu+t
	aLHh7TKPmrXZTNYuM+bcHTp2BWTXwJFItFGo5tBA9BbpWYgzP5Dfv4jDscAvMFOfnQ/077
X-Received: by 2002:a05:6870:558f:b0:43d:7b24:7c with SMTP id 586e51a60fabf-4413da479aamr11950799fac.20.1781021847366;
        Tue, 09 Jun 2026 09:17:27 -0700 (PDT)
Received: from linuxescape.lan (23-88-128-2.fttp.usinternet.com. [23.88.128.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-440d8448e3csm18797906fac.13.2026.06.09.09.17.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 09:17:26 -0700 (PDT)
From: Maxwell Doose <m32285159@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND DRIVERS),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list)
Cc: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] Replace Tomasz Duszynski as maintainer for SPS30
Date: Tue,  9 Jun 2026 11:16:59 -0500
Message-ID: <20260609161701.52513-2-m32285159@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all.

This is basically the 2nd half of replacing Tomasz's entries, once
again, in the SPS30 dt-bindings and his entry in MAINTAINERS. All of his
entries across IIO appear to be dead, which is why this is being sent.
Jonathan Cameron's approved of this [1] so his entries in iio are being
replaced and an RFC regarding this topic with Tomasz Cced has been
sitting on lore.kernel.org for about a month now.

Maxwell Doose (2):
  dt-bindings: iio: sensirion,sps30: Add myself as maintainer
  MAINTAINERS: Add myself as maintainer for SPS30

 .../devicetree/bindings/iio/chemical/sensirion,sps30.yaml       | 2 +-
 MAINTAINERS                                                     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

[1] https://lore.kernel.org/linux-iio/20260609140712.2e5d1640@jic23-huawei/
-- 
2.54.0
