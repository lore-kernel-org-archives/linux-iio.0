Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795155693;
	b=pBDRatgKXsFYD+BzNQ9Vla5Usc9VCEvEJwSSJo4zrXALXUBuFhptYeanrnUShuSvQAYE
	 2bFURzK60LoXQ1riDMJqq57pn7rYFhHD9CgkhMKO7Et13oETSYmIai37T5zZEyQcEXBri
	 85ydTtrUb41TyQNFqejVzAGCHhq5BIst7C/bMu0FEazujX5+znXX3fl5yaFF5CgNWXk74
	 X2t7B2jSEJTyr74PCLdYo3nb4bdO7T2GbXDLshfQ66MkYLxM/5JwUERththFXhxj9l2eE
	 whZwqq9r391fv5rS9FDnxnY4EqwMQLGAKph8az77RsNs85BpaVeXeHvgZ12ZRL+JtRA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795155693;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=CGkDigjb9oQlVkXWEL1v0HSz11EjRTz4QjomlLk9gTY=;
	b=QdNGl/WEy0FkarG27upLlDO4uH/a9EhUSe12SNA9M6U7MOmw2lNCb7bTRWZXocgmBhDd
	 ZhA0S4LGxhbz/I687YWDqwiwwYCdsgMFR1z1Y3XKw9zXVHH0cXcegcU8emacnKBDGVtgg
	 mycCCmJyGmGeqkHXH6ifwf7mfGgG6rZX2e88BvZ9EuJ3kiefgLqKUrgrKbslH3zDAj8bu
	 Oivd1XEHIovro5qgucGehVNLNUd/9p3LyzqmhWTITJPWQNTCgyuhukaA7jYTtHPgPXpgI
	 0M5lXJQNtEo3boRcIUoxcIBdL8Sr8BoyHC4KZWX1ndV2T4C32U2Srsp97etyfdP+R7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=jwjVja6U;
	arc=none smtp.remote-ip=111.22.67.151
Received: from cmccmta8.chinamobile.com (cmccmta8.chinamobile.com [111.22.67.151])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CA82606A334
	for <linux-iio@vger.kernel.org>; Fri, 20 Nov 2026 06:21:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7CA82606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=jwjVja6U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=jwjVja6UgcN0DiZuhYoZWcHYUeEY4vCwkZpLv8TkU38sK8+l5BnAleYox9efvAbXOnm2ST4D2Fu5Y
	 NlsIKTBJuzmzfz1MeC82vNRC8ZbeLvcmaI/R499MnHojK1oMmI3KkdZucxFI6/FNXaAkvdc25CPUT1
	 Kvw+lZvxQk+pIeCE=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app06-12006 (RichMail) with SMTP id 2ee66affe6e657a-f18ac;
	Fri, 20 Nov 2026 14:21:26 +0800 (CST)
X-RM-TRANSID:2ee66affe6e657a-f18ac
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from devin-VMware-Virtual-Platform.localdomain (unknown[10.55.1.71])
	by rmsmtp-syy-appsvr04-12004 (RichMail) with SMTP id 2ee46affe6e4aea-188ee;
	Fri, 20 Nov 2026 14:21:26 +0800 (CST)
X-RM-TRANSID:2ee46affe6e4aea-188ee
From: Zhu Jun <zhujun2@cmss.chinamobile.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	knaack.h@gmx.de,
	linux-iio@vger.kernel.org,
	Zhu Jun <zhujun2@cmss.chinamobile.com>
Subject: [PATCH] tools: iio: Close attribute streams on parse errors
Date: Fri, 20 Nov 2026 14:21:25 +0800
Message-ID: <20261120062125.98462-1-zhujun2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.51.0
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

The second enable-attribute pass in build_channel_array() and the name
read in find_type_by_name() jump to cleanup when fscanf() fails without
closing their open FILE streams. Neither cleanup path owns that stream,
so repeated failures leak file descriptors.

Close the attribute stream before leaving these paths and preserve the
original parsing error if closing the stream also fails.

Fixes: 53118557b6a9 ("tools:iio:iio_utils: add error handling")
Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>
---
 tools/iio/iio_utils.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/iio/iio_utils.c b/tools/iio/iio_utils.c
index e274a0d8376b..7e1ab6d752ae 100644
--- a/tools/iio/iio_utils.c
+++ b/tools/iio/iio_utils.c
@@ -403,6 +403,9 @@ int build_channel_array(const char *device_dir, int buffer_idx,
 			errno = 0;
 			if (fscanf(sysfsfp, "%i", &current_enabled) != 1) {
 				ret = errno ? -errno : -ENODATA;
+				if (fclose(sysfsfp))
+					perror("Failed to close enable attribute");
+
 				count--;
 				goto error_cleanup_array;
 			}
@@ -620,6 +623,9 @@ int find_type_by_name(const char *name, const char *type)
 				errno = 0;
 				if (fscanf(namefp, "%s", thisname) != 1) {
 					ret = errno ? -errno : -ENODATA;
+					if (fclose(namefp))
+						perror("Failed to close name attribute");
+
 					goto error_close_dir;
 				}
 


