Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.192
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794206375;
	b=nEsgic0qjC2GnjNWSGUmAbEbfuvaC8Wi8JK077ZJfwR+xkvkWPOOjCOGzLv6ClmXBou4
	 Iv/6bvJdFdXmhsKFPDYga58ezgLA0WHGStP5arZI477ZCy364q1zyJYVrcn0YiyCQpRzc
	 p7yWdVNm0POlg2sXBV2vx9YwAhu/dN8IcwPVJ9DomxURBknQP2++i8YoEQBBquPXiegL1
	 wln6PcjEQ0EBidxrJeMpcaaqqR/UnxJNVXtqZc597lkdqoLvoZYHiUyHA917MrzJJCkAu
	 eJ5wB7zYmrQ+ReInexjDBjxlwvjkQQuhgY6RVAMN+1KwjMCnfmEcI584AGlzeL4INig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794206375;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:Content-Disposition;
	bh=dYiYEdpZoBCk/m+9m0NoamFhEFSafaE8QHgqSYW70HI=;
	b=4Kcn/eB2TE3klzd8Txbl399p+d3j3w9CY7TZ2lmQWDzRjl+4V1NBye7u09giQ9Uy9sVT
	 kVmW6L2nnuam+XghWSQMUHQNKnlo3mEKrNH2bApDao4xgzORX4lk1nzRHODP+CFNnOTyE
	 pin1Wa/Cq/AGMHKTdNuogTWOGG0loO3C1tWdrNmglL/UBTo1rYvlrxizvEwOlh1MmsgTu
	 X17ShdlfWcw2W/Iug/o1n48O4qfes81HyD1kaxO7e5rUpX6qGLmnt50mXsBw/Ia10kUxy
	 Dr9qT/NOt/cBMMKzCXxqqO0UGSSEa+aiGlJjqXcLbtgPQ/OqnOByuUAYsDCZyZkm00A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=i84quMsR;
	arc=none smtp.remote-ip=91.218.175.192
Received: from mta0.migadu.com (out-192.mta0.migadu.com [91.218.175.192])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD27606A31C
	for <linux-iio@vger.kernel.org>; Mon,  9 Nov 2026 06:39:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AFD27606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=i84quMsR
X-Envelope-To: linux-iio@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=MU0CJ6RC8bf8Bdd4IOlFxpmM1i6C8HxAoRfmw4Mt6r0=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794206372; v=1; x=1794811172;
 b=i84quMsRuLJYop7oepd5gPfqt+J7kJJDjapa5Ge51muaG+1VTtGoRYF9q+HmgouRVo/ZfbCu
 xdc/BAIoAuwtO6lMgs7pUeQrNJzrAij1mL0zsAJ0G0jJ9RtRIkXB0XHIrD28hZ3ATw2e5xCAfEe
 rrqVbvLS18iwIW4G8SXtFQWY=
X-Envelope-To: linux-iio@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id ef5496e26729f04f;
	Mon, 09 Nov 2026 06:39:32 +0000
X-Mizu-Trace-ID: ef5496e26729f04f
X-Migadu-Flow: FLOW_OUT
Date: Mon, 9 Nov 2026 06:39:24 +0000
From: Akhilesh Patil <akhilesh.patil@linux.dev>
To: jic23@kernel.org, andy@kernel.org, akhilesh@ee.iitb.ac.in
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	akhileshpatilvnit@gmail.com
Subject: [PATCH] MAINTAINERS: Update Akhilesh Patil Email address
Message-ID: <20261109063924.GA118887@u5ce4748bae3b54.ant.amazon.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Move to my new linux.dev email address akhilesh.patil@linux.dev
I plan to use this email for kernel development going forward.

Signed-off-by: Akhilesh Patil <akhilesh.patil@linux.dev>
---
 .mailmap    | 1 +
 MAINTAINERS | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/.mailmap b/.mailmap
index 7fb33babc931..54238d2f04dd 100644
--- a/.mailmap
+++ b/.mailmap
@@ -1030,3 +1030,4 @@ Zhu Yanjun <zyjzyj2000@gmail.com> <yanjunz@nvidia.com>
 Zijun Hu <zijun.hu@oss.qualcomm.com> <quic_zijuhu@quicinc.com>
 Zijun Hu <zijun.hu@oss.qualcomm.com> <zijuhu@codeaurora.org>
 Zijun Hu <zijun_hu@htc.com>
+Akhilesh Patil <akhilesh.patil@linux.dev> <akhilesh@ee.iitb.ac.in>
diff --git a/MAINTAINERS b/MAINTAINERS
index 222b7fc2c3aa..3aa8fa3c068f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4095,7 +4095,7 @@ F:	Documentation/devicetree/bindings/iio/chemical/aosong,ags02ma.yaml
 F:	drivers/iio/chemical/ags02ma.c
 
 AOSONG ADP810 DIFFERENTIAL PRESSURE SENSOR DRIVER
-M:	Akhilesh Patil <akhilesh@ee.iitb.ac.in>
+M:	Akhilesh Patil <akhilesh.patil@linux.dev>
 L:	linux-iio@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/iio/pressure/aosong,adp810.yaml
-- 
2.34.1

