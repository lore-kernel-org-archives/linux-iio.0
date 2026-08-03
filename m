Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D34336F411
	for <linux-iio@vger.kernel.org>; Mon,  3 Aug 2026 13:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785764636; cv=none; b=OVvqMgm701OrWfIy+fvleRHRMy3THoBdTFcoP7z1xypxdEGDNeLxYPIYmKYOwvWFpZ9ILPfS/Ma7nWiwOSfKpGFJTC+8SaCsprTmJKEYIohZVaIB0vUaExRfWBvQxseb139MoJ0bStsBnpXH3T6aXjK29YkWIBFH4V3in4GRtDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785764636; c=relaxed/simple;
	bh=uadqEvQ33RoumdDgRD8mOqoK9D3L0OV9czzlaVb+nQU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O6HY6UIZ66yJc/IsX4fZFMg6tgUTwX0d50JG6HRJze17CM4cPwv77mGbbjRIhW2Z1SGmQ4YSHhNp0yz5kTm+upxBGO9CgSQ69VaCNdK9Fco2YpqWYChtc68TYDncBQUlulPrpNe46pH0NQFVtDb6Cjh+DQqbnyCKSQO+xGyNKS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p4a3jTva; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p4a3jTva"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-47f633e6058so3207496f8f.0
        for <linux-iio@vger.kernel.org>; Mon, 03 Aug 2026 06:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785764632; x=1786369432; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=U105CJup5mg63GYZ31mc/wyHUW4fHSDWiBJ61uMcMyI=;
        b=p4a3jTvaA6RNjv8Nf87aHMv1/7pVw2bmVmPnvjwQmQGHawqMHJqsJ3Qo4nL7mF6cec
         vQ3T9HWN1+KrBo7GEMoSdb9vggftbI/hlaS4Z0IDWvChAqJyA0LegfAorpadaBBWLto8
         32z2J2oT9h/0lk6TBuRTPjMJahYplxKlJOhnfqBFaQyL7nouj6HKVvUwFmdTPtfxr49r
         i1cBEii1YfpTTersivyfxbSW4ao7ic21toYSrD1eyHL3mmk12AwpM/2+GJD9lyp2hveS
         VxYtI0MGGA0Tf/0urgRHyu8k3cYdJ1fydeeiuZJ4pBrWd9WfNoW7QwCye6s01TMykhPq
         SnLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785764632; x=1786369432;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=U105CJup5mg63GYZ31mc/wyHUW4fHSDWiBJ61uMcMyI=;
        b=QDaISXCZuuxlnksbxzIp0fTCdalcJDcSAJce2Dn6kWQS2uuNeBPaEeR8uvq7g3TPC0
         8S0wD+BLIwWIF5/PUVrGfsVd83WM/ig8HfheMYruxQCWkgp8n+/9G9rwplknbhxvTxdP
         BT/aQIJ7R8vaipl1Orx+tAnJqf9zwJnMIUOHk1cSXI29iGYPOLGp69bT2S7MXE3i+TC4
         h4jn6WQF6W130jSJGTVKQCiPHkAj+FaNQeH9UPEQ7i75Jv84Dkt/DdhtrUCe/c7f9q1h
         ZSG+Gf7og4cM5Alhs961IJHPMO3C9w25Z4Oby5A+jeGtGqcvkTPa09EU3CS4cLWBfd6g
         aEsg==
X-Forwarded-Encrypted: i=1; AHgh+RrxGMhG6K7n9aKK31nRY7DoQukDzH/7eJUtSndzHzYZJWAuqMWKoy5MHph1oCjlO9R5r22Sib/ijR0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyT7KGOezyU6yGnLbzzOoLhSmUCi6USJ8JwakOa3xqjHO3yd+Vn
	owCsbiomkVPb0SqiPC5jRxuMbgTDDdu8qbtrmAUUh13PMGWsMvqrUTax
X-Gm-Gg: AR+sD12x8xslt8BF5EXB/QmocyGrtKT7R4J7keUzpvxlpC4jWJO5f+MCsYKdUZ9ITaA
	AfAQZzM3aPR5fI3TP0PDgo9twq181TLxosO0JWr/eaTdyMrs1yV2T8lTYfbOjb3Jyfie+WM93zI
	pfmvwVPq8uLny+UAMIypRlqn9kAsRkNp6CWvqgtE+myHrmt/evWH1IZQAKv8dkgTW8SWQzOM7ia
	KbWcemurOUPK5f4yc0uqu17s7Tk3WZU7RSHsUFOrhkoREgAr9A1HhM6DAxFLyhpEugdz5kAJFCq
	axPaB1nsbCOesy116GhoS3DBY8LisKCHWkgBswcPIhf46bZWcU71WT4UxuQGCBr2ypX6YZvk7Hj
	SVRDgkR9Up+fVwAuVqFjgwLmoqnsmMZ2dCz9YLIWOyx+TRJcVGWD49dkMJFvXPToIbJ+ZafP2Qg
	3fcdc+JBZ5s8oPKzB3jYwyOBmV+qYUM/3i14ak36xEU6OJSzZxj9cY8A1uWcjSpSHHvqsgddpCL
	FgOjuV9Rg==
X-Received: by 2002:a05:6000:1ace:b0:47f:70f1:a577 with SMTP id ffacd0b85a97d-47fd72a8698mr25355055f8f.17.1785764632235;
        Mon, 03 Aug 2026 06:43:52 -0700 (PDT)
Received: from fedora ([154.182.126.98])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd4068fb7sm34328908f8f.0.2026.08.03.06.43.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 06:43:51 -0700 (PDT)
From: Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
To: jic23@kernel.org
Cc: nuno.sa@analog.com,
	Michael.Hennerich@analog.com,
	gregkh@linuxfoundation.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
Subject: [PATCH v3 0/2] staging: iio: ad7816: Fix DMA from stack and race conditions
Date: Mon,  3 Aug 2026 16:43:42 +0300
Message-ID: <20260803134346.6733-1-abdelnasserhussein11@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series addresses two issues in the ad7816 driver:
1. Adds a mutex to prevent race conditions during SPI reads.
2. Moves the DMA buffer from the stack to the device structure and
   aligns it properly using IIO_DMA_MINALIGN.

Changes in v3:
- Fixed a formatting issue in the v2 cover letter that caused it to be sent empty. No code changes.

Changes in v2:
- Added a mutex to protect the SPI read sequence.
- Used __aligned(IIO_DMA_MINALIGN) for the DMA buffer.
- Corrected the sizeof() argument in spi_read().
- Added the missing Fixes: tag.

Abdelnasser Hussein (2):
  staging: iio: ad7816: serialize ad7816_spi_read() with a mutex
  staging: iio: ad7816: avoid DMA from stack in spi_read

 drivers/staging/iio/adc/ad7816.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

-- 
2.54.0

