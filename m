Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793817291;
	b=rMDtRlwfA0ESyp4lfGrBE3nTYlmL00Ca8xFPiizZxQ6hrtcIXty9sbNWhSqHXfx+J5Kw
	 SpX/0smzIS9c31x6tOtBbDZzZrWeqdy7NktP+8mXlSjLaF45QaGpgU+FF1r9aDG12dzIK
	 fKz9bwnHsrd0xptoO1qepFqZuzGo1z+n6ysiCsuYOcY45+fDte3QEFF1gb+DxBoLQI2qo
	 QpDVkMX+QL+4xzUGj8HiVWTZB3AEJZyZl8SzhRRD4+mr9ECKMSdOWCB8M+8ftSnTTtdAV
	 RKhlGfzwD9+rJZRv/sS/rKXMn9hE2m8+KyqqC9nddGqwaQAq81xUHAtnRpcvDyI+O0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793817291;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=YPds6qHWCOYStiDKSkZJvhkMlbF1mlXK1Bt3SccenlA=;
	b=HQSvz0tr4OevB6aOAziLTiTaRatc1Ulew4k53ZxfLEfUG9mCCwFzPZwjwt0N2abZOx4H
	 B0WLgszsULiCABXT1rZq4aVAHZSFpEfzT9U/HCe/H+EWG61JINlA6oxFo6xo1NN6tqB99
	 RJhripVMzwUQjsxPtCg7rhq58hLRymlPLZcIhjJeca10V3T6SjApErgXZHjXBpzbuE3uM
	 qLY9yg67NkJa2E4fqcnJH2pWZWUKfxGiUO29im2BW3hJpP+mTMZ6lBa8bFvqcUfoAmduI
	 BK6LqlXkDkkA7WNmARlpbyICs4JCr4Bi4xiI7XzbVUi8HaqL4WcojafOfUX3uMj59fg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hWd8kYN6;
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC36606A328
	for <linux-iio@vger.kernel.org>; Wed,  4 Nov 2026 18:34:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4CC36606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hWd8kYN6
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4a60f9474c4so8567725e9.0
        for <linux-iio@vger.kernel.org>; Wed, 04 Nov 2026 10:34:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793817290; x=1794422090; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=YPds6qHWCOYStiDKSkZJvhkMlbF1mlXK1Bt3SccenlA=;
        b=hWd8kYN6z1qn2F5WN38k3o5mVbFuhHYozUzcnvBmcFrqmo3qJKOJ6C06CayWmAD7mP
         Jm09XZwQV2T0Lt8FntYGjgoMCQQgUaW8P+JOxGL/vevv5lBQbC+QlMP/KZzMsPSJO4e0
         WWNIgbCCvbOJvtvTkRplJjwNSRZmsG8/mg1nhqiMuwKUNeRmcn+wkknqiZZ/Xd3OYinI
         Wuz6pzpIIcfaLIlxUJ0t8scSbWftP0EoPOtj+d0CMVLfb1V89VWPjCZHxYROBkbSOvhG
         a4+8x8rrOdJlYcE1oa1uoZzVzslmMmkd2ks3ZEkw27vY2z50HdMeCGvcpyRW35JuQEX4
         S3Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793817290; x=1794422090;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YPds6qHWCOYStiDKSkZJvhkMlbF1mlXK1Bt3SccenlA=;
        b=VgUM0f8kUvHSGyjMRcyM4rctK1Ekev3RTjUXNGnRwEdSRcZ/bLC69siiN0QeEPs3O0
         HJyIEBs8wuqWZewGe84mfm/O/OdG8zYgDJ/w/9hik75/a1TQmPk09FQAfk35aAAFvVpv
         u8DfNbtT7GM60AjDv1oNCXvQ2/5p7x0wrw7cCtelW5pCjW0ga3JfidpJaOOhK0TJYLdg
         0GzBUTWrLvx3g4Keotbdvl735aLlXc38y3s9a7ZZZTabOfXr6VP3TcS2BoQdQg7qKZu3
         iOx9J9dDAx1W0XH4Y8blLCkkMaSjuycD7YK5PYIjifreUHplNdAd5Wb7eiOzmONne3Kj
         SYtw==
X-Forwarded-Encrypted: i=1; AKwUvBwTtz1s9wTNi7a7x6mqXwjZ05v3nIWzI5/cQJa2trCynFT9A4+2HQr5+La4pVJTUpCYRZNXNBCfl0M=@vger.kernel.org
X-Gm-Message-State: APuU4Z9cbQ2EKzFcQ/7zF0nC6I3tYbpMVz2ut1YRLVf345qWia9kb3Xg
	5jWlETHiJLdtG3hsvhbHN4XQFYxgODh+2MwHRGB13eLNpa7HktFZqmM3
X-Gm-Gg: AYBFou0Hj6LjS41B6gVCIb08glh7WtFbV2payFBAnWbSQzzB99SUhu2bk4OHjfF+FY6
	Iia7MFSrsnHRVIIGZb2+knntkQ7XV+ZTUq8NW6gux2Q7eWyrZAJUA2hItja5izW/eonOCPzDo+Q
	7KsINUBo9llZmdemnHX4987nfFGYPs0/Dm6h4Lb9wNtKTxiShZ5Tp81EPBCTDs73KdxeT7okxFt
	kRcI38AGB6wJjZManef9yBZzPIrR4h5J2OXy8xyYFstZE+2ImoFFOVrhwI6TghszuNEQJPiprUE
	JxiKEGp4jxL+Kx3Rolvs7J7XhKYWSC5PxtCBh6OP6hgacWz7OwrdbV7hNbO1Xjs/VBwAqO13LEW
	R8MOeE9HinH+0xyZoqjudcnyz6HTgM1Bt4PrIMY+Im47JZ9yiD1wRkhTD82VYOS62H+QYGmSQVH
	cj34bTYvR2hywKgKw/ANi8MJ9JclUmgVGBEJrVCz1m9QD1dme+4zI+7IMKGlVoQn6j3IDqP3e2W
	bdnv9Z+jsaRDxJFEcMV/zyNB0Zqf+J2eLD3pmV4SOd3gbteFCNt5pnSRMUFXLUqwl0z08sliCkl
	5ILXfiLZy6/f3drTSTlnYkr9wXi2jaRZD1DKhg==
X-Received: by 2002:a05:600c:8b2c:b0:4a2:5267:3cd4 with SMTP id 5b1f17b1804b1-4ac151a8c26mr403871945e9.3.1793817289631;
        Wed, 04 Nov 2026 10:34:49 -0800 (PST)
Received: from fedora ([154.183.179.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b432a883ffsm31404915e9.3.2026.11.04.10.34.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 10:34:49 -0800 (PST)
From: Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>
Cc: David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	Joshua Crofts <crofts@kernel.org>,
	linux@analog.com,
	linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
Subject: [PATCH v4 0/2] staging: iio: addac: adt7316: clean up header inclusions
Date: Wed,  4 Nov 2026 20:34:27 +0200
Message-ID: <20261104183429.20125-1-abdelnasserhussein11@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series cleans up header inclusions in adt7316.c. Patch 1 sorts
the includes alphabetically. Patch 2 drops <linux/kernel.h> and
includes the headers the driver actually uses (IWYU), removing the
unused ones.

Changes in v4:
 - Moved the list of added/dropped headers out of the patch 2 commit
   message, as requested by Andy Shevchenko.
 - Added Reviewed-by from Joshua Crofts.

Changes in v3:
 - Split the series as suggested by Joshua Crofts: patch 1 only sorts
   the headers, patch 2 replaces kernel.h and adds/drops headers.

Changes in v2:
 - Split the original patch into a 2-patch series.

Abdelnasser Hussein (2):
  staging: iio: addac: adt7316: sort headers alphabetically
  staging: iio: addac: adt7316: replace kernel.h with explicit headers

 drivers/staging/iio/addac/adt7316.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

-- 
2.56.0

