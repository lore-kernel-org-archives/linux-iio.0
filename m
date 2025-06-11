Received: from unicom145.biz-email.net (unicom145.biz-email.net [210.51.26.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA5D25334B;
	Wed, 11 Jun 2025 08:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.26.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749632367; cv=none; b=CfeP5TkBSN0pAtB60NktioVsfe5LhAK3efQGszPGRdRcpiwFoQ57UM6ta3om5IIM2E49JeHnFYj/kymgF0VkADq4ntZYmj5y93HWhd1GtNOTifgF0R7rjtyglR25kXTuFERuoGlBO5F+gfGslWkAlX9fSdWFXW18tohdSnaERl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749632367; c=relaxed/simple;
	bh=+EWtSJ8MP+4Yp1bq9//XPWjvZZuVOQu5/60e0t7FJNM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MXSV/uJz3YZJFfVC23VKQ1G/SILSmupEgBN3gBky4M+emXl31c3q6NPj87jNnMk2qGzK8mO3RJGvtWRa1i9p8KIvqXg3GqZSptfVrRcnNObuIrmHBpDUpot1gxlf8r3S+2+FM7vRGgQnzCnTKc2nYoMf7QoKiVp6mswaknkCVtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.26.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from jtjnmail201606.home.langchao.com
        by unicom145.biz-email.net ((D)) with ASMTP (SSL) id 202506111659061079;
        Wed, 11 Jun 2025 16:59:06 +0800
Received: from jtjnmail201607.home.langchao.com (10.100.2.7) by
 jtjnmail201606.home.langchao.com (10.100.2.6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 11 Jun 2025 16:59:05 +0800
Received: from localhost.localdomain.com (10.94.12.179) by
 jtjnmail201607.home.langchao.com (10.100.2.7) with Microsoft SMTP Server id
 15.1.2507.39; Wed, 11 Jun 2025 16:59:05 +0800
From: chuguangqing <chuguangqing@inspur.com>
To: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>, Jean-Baptiste Maneyrol
	<jmaneyrol@invensense.com>
CC: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>, chuguangqing
	<chuguangqing@inspur.com>
Subject: [PATCH 10/10] iio: light: opt4060: convert to use maple tree register cache
Date: Wed, 11 Jun 2025 16:58:38 +0800
Message-ID: <20250611085838.4761-11-chuguangqing@inspur.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250611085838.4761-1-chuguangqing@inspur.com>
References: <20250611085838.4761-1-chuguangqing@inspur.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
tUid: 202561116590618cd26c374da5421bc4e811ef719d038
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

The maple tree register cache is based on a much more modern data structure
than the rbtree cache and makes optimisation choices which are probably
more appropriate for modern systems than those made by the rbtree cache.

Signed-off-by: chuguangqing <chuguangqing@inspur.com>
---
 drivers/iio/light/opt4060.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/light/opt4060.c b/drivers/iio/light/opt4060.c
index f4085020e03e..88ed85cf1844 100644
--- a/drivers/iio/light/opt4060.c
+++ b/drivers/iio/light/opt4060.c
@@ -1063,7 +1063,7 @@ static const struct regmap_config opt4060_regmap_config = {
 	.name = "opt4060",
 	.reg_bits = 8,
 	.val_bits = 16,
-	.cache_type = REGCACHE_RBTREE,
+	.cache_type = REGCACHE_MAPLE,
 	.max_register = OPT4060_DEVICE_ID,
 	.readable_reg = opt4060_readable_reg,
 	.writeable_reg = opt4060_writable_reg,
-- 
2.31.1

