Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D7B733D6F8
	for <linux-iio@vger.kernel.org>; Thu, 12 Mar 2026 08:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773302907; cv=none; b=FwxgAEf+Qw74i398SMCxPdr1gafRD2YWfvwfDvQIDi/QRxeOX++0OOqcgfGcpCdpv4Pyf1plPO41s0DN1OPqdvwxX/D0yEOijlqg0Eag17Rb5oUaZSYmXQHr0508Z31CNOY3yuTMnJm1SGFyULTEJVL4hXiM9Rg7YofL/scuGCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773302907; c=relaxed/simple;
	bh=ZxjTFXsqNFrtvrj0H2WvygF26glxx8BvJg6vmAxWnMk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Hma6m2HnmgduCrnlyW6BqkK5Cr1SN1CLrtUWn2ZpHxHQ4o7gxuEKobdiust5shYHz2VMxLajzANHvMjqzd4BqUsC3L7lPTBUWZDJr7rQ8XoYOjGtzRbVraRJQHujF6RdnOGo1pFSBycYte6aIQKNZkFErk+FUgBkFngKLmEVa+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S9+Vor/v; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S9+Vor/v"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4853bcdefd3so469295e9.2
        for <linux-iio@vger.kernel.org>; Thu, 12 Mar 2026 01:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773302905; x=1773907705; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=elh38qLeuyRbggDuIo5t/VLJUg6suBY9E3SfjJLpBjk=;
        b=S9+Vor/vTDQj9IHhK8UPmuNUqNNQTzpf1Ziw1zo6+vMLvn14mcmJW8Ppwr8M0RZW0k
         qIgXP71Lg+m7Kh6H16WP/ol7bJbO7u3RSyNGT8nsZcRqPsreTDEPuRDBKU8n2uVzi24s
         PoazSqyE96TQsQmoEPKIfUzsMEVDIOn6yK3P6GbjlASrfGmM3MfuPZ3emmMhsrhrHr16
         ilwp3kBRAGpJPWFvSkD4SwertCYE7sTrdXbNgbmBcIYxvRSvQHq/XU2ZguTSOL75p2oq
         cqkYJGwBS9z6Rz5hZX43UVw8JJA2NO+Cdp5BXXdwog2dDWSH+OhDmXcVdk8RleDDVJMI
         UQ0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773302905; x=1773907705;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=elh38qLeuyRbggDuIo5t/VLJUg6suBY9E3SfjJLpBjk=;
        b=BOpJl47QHjXpVPj91aXBz05EnnKJ5tq0e0rwaWm4pabohTN+ug+2zrtTYnsk6jGX+C
         gr/Flr9ARm3Swww9gsgTowA12lwBWSGjo97k8p68WMBFWuZtgwfhD9+jV5nbDeTGNY/7
         5KrXHkOyhqn28rOwZWqdD6XHKQK3hGr5Tr/Sg4h5qgRzg1TxRwQpWfmOiPYCzpVJwxfL
         1X7evEeidMf1nTg1aNnQAGCsqMJjQghxFZ0tS2OQNbYP/C+QmlIO5BNwfP/fD8x0n0BU
         N4adpB+Mv2CTBzh8Lwtoy+/eHfVQ/vQEu9aGuWMe9lIcwXvPN/WHR1t5nT6NwOdNJEiL
         2HXw==
X-Forwarded-Encrypted: i=1; AJvYcCXAoOuFNKz1GtP5Yz1Tc5JWQDgq9jHXBaJmBGGf5m6eeznwGeqnnJz9lIEzkwuxxlZfoaYmdzKZwXI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbNdmhGGYUHW1JysI0Wc0GmS5yrmJDAJw2nlBEAU7gzIGJW8yW
	rjSBcrBbROTQ4KZUL1O6hUe9I5z9zLNqBlLk1aDQGOTKdpjti8EeJ7wn
X-Gm-Gg: ATEYQzyiLMEAC7V5bLmBCmHZ7KKKpD531PyF/L25nRVJf1J+VuE1T82Bxv+mVLh/HyQ
	uDMkS6fywPTiPReYHL0Y3yvWC+KTLaJvyqNmRZB+5ep1JaBtNbwqPF4pxzitI7khEClw5hZzplr
	AHhyvNQsNmT36Y6sSdcLJGYk6iGlsrQtJhe8J/ktVO4hTU4ZQyJHOd0rUmWko8WP3hjdDqpLoPZ
	tfZ5nn4TYKEkvgH5ia+2WceRSy08wEVu2K+b6dhS4Nb1jM19C1MFPbGw/fz5nX+zkieHw8rVOCh
	5Bs0VSAo5R1LvzxmCp+knDPhXD/Tzf7BtHbghOaRit2mVjxzUHLwCr++tdlRku9goJZjbs5BDws
	/PBDrDIEDDkNjASO3OnmtahssG3XUtz+wnMcY5OzPhvni1TWboEeM7VmrxUCYT7kuHi6MOh6+Ps
	kyp82GpMM3nG/C1/3EZupJ42CMhE54ZqsgSDYPihFIo5ErC5TGRA2jQq4veh7Bpf8e7dn/0I6di
	b49GW++/XiTAafDcwI+QAtiK/US8RYA37DVWJjlauGpeFLEbhAn
X-Received: by 2002:a05:600c:3106:b0:477:7bd8:8f2d with SMTP id 5b1f17b1804b1-4854b155754mr70644355e9.8.1773302904506;
        Thu, 12 Mar 2026 01:08:24 -0700 (PDT)
Received: from fedora ([149.3.87.76])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4854b5f6b95sm106160155e9.6.2026.03.12.01.08.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 01:08:24 -0700 (PDT)
From: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
To: antoniu.miclaus@analog.com,
	lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
Subject: [PATCH 2/3] iio: adc: max1363: Format block comments
Date: Thu, 12 Mar 2026 12:07:52 +0400
Message-ID: <20260312080752.48091-4-giorgitchankvetadze1997@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move the trailing "*/" of multi-line block comments to a separate
line to comply with the kernel comment style.

This resolves checkpatch warnings:

  WARNING: Block comments use a trailing */ on a separate line

No functional change.

Signed-off-by: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
---
 drivers/iio/adc/max1363.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/max1363.c b/drivers/iio/adc/max1363.c
index 3ccc7b2d4f67..b4c2a4b38ec8 100644
--- a/drivers/iio/adc/max1363.c
+++ b/drivers/iio/adc/max1363.c
@@ -39,7 +39,8 @@
 
 /* There is a fair bit more defined here than currently
  * used, but the intention is to support everything these
- * chips do in the long run */
+ * chips do in the long run
+ */
 
 /* see data sheets */
 /* max1363 and max1236, max1237, max1238, max1239 */
@@ -171,7 +172,8 @@ struct max1363_state {
 	struct mutex			lock;
 
 	/* Using monitor modes and buffer at the same time is
-	   currently not supported */
+	   currently not supported
+	*/
 	bool				monitor_on;
 	unsigned int			monitor_speed:3;
 	u8				mask_high;
-- 
2.52.0

