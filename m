Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795095525;
	b=RWoOGmSEMJ8XfVxJsYwwTsg6poPeZ1Qp35bxFFBON3+ftzW25q/BqAOQr+7tVE6/ZiRz
	 eYSGw0fVkoMlom9fSzERAnMP9WLfH3W5ysqHiCVsco8ETiX66wRC3vfg5RE+mgx334Ntq
	 nTo8ppxs7BOvxSLQgxuJde8/GedvxbKlghz3491dimpWqrT6VPYfbNeZ66WRQ39Kf760l
	 zVGI+BFO7a1bhQAuKBsXt54Pwj/beO/fgPFPJhm8JurUERYBVyjGNrSJak9o1rTorFCTZ
	 e920V6pb5KnVg4fe1UJ6aCgUMYEpDEAsgLuv+zEyQPoubD0wZQs0FUHEiyz7wVk2ypA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795095525;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=lzHDabfPCqN/fgg1Vuews1wZyOxAqJ0lU7r6bq+Bt2w=;
	b=ri2S+62Wx3Eni/IIPyr+kbTMVKxmHtxPo+sXx8sDuWabXdOvZWDtXsJKiuchxiSHJ0QB
	 GzlJcnbgYRyiU+n8BiEZBt8tO4lb+7Yi+UcqJaD3FWyO70dKkD5lP5t45AXm2cW+Au1GH
	 JwvPYB3AAcDzSgcER5ixOq35qKVyGNvA3bvfnBUsXv3ps6AhBqfi9d4hwJ30sPtXQPnK2
	 ZBjT5kSiAz+0TLQQpGaqdjSPZmXLYxBOPmXFV7e3JHxzRT16RykTg3X3PKk/YNr+clR9G
	 CCMuw0jktYc1nGgUM1xR/KBcKhx6hXOWHLeJhQx+kRjwZWWMvAdE/uzeV/j3pR42Cng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dG1TRtv7;
	arc=none smtp.remote-ip=74.125.82.173
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 944A3606A320
	for <linux-iio@vger.kernel.org>; Thu, 19 Nov 2026 13:38:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 944A3606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dG1TRtv7
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-37198ed3727so1083464eec.0
        for <linux-iio@vger.kernel.org>; Thu, 19 Nov 2026 05:38:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795095524; x=1795700324; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=lzHDabfPCqN/fgg1Vuews1wZyOxAqJ0lU7r6bq+Bt2w=;
        b=dG1TRtv7rZcQlq7tMxXUbCk/jmogfFZ2xhu+0Cd+AcHTd4daMVa8RUDS8hw5QYFnql
         eLXf/VsigFXEmZ1KoXoI/ye8lVvJb6BaPkn0QVMuncJ/GS+uFJSrds/vwrAfe6hOgN35
         gOFXiz2kIlClcaeeU+rABkZr1+h/xyvABNjRKH6I60GUWe7MrgI1gF8OdsPBSQTO/eFc
         36E6G1HdpPIuh/IKfwRFGqKiTgFKGWQqXYSIVJVlCbUEiNzHrZyOj6EoaZTNScNFm/B/
         t5It4H3zxYTL+Dk03ZgqcV2As9dsffWbpbT0Q5eZD4a9SxfDInmGF3iFNxMjuB2xj/cP
         fD1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795095524; x=1795700324;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lzHDabfPCqN/fgg1Vuews1wZyOxAqJ0lU7r6bq+Bt2w=;
        b=CRXZnUvq+AlTfy5mZ0D+6MWp44uoV812ubxYAh9L8D+cvI9UFy8LHkpg6IoQaALTHN
         4THd+git/g5g//nWoCiPBVZt1qHU8D7R3AYT0HBf/UT9q1GD7a1UAXj2UHk4bRDptOot
         zmU7QMbDD8CJZWFNlrDMJ7Qpe1gRFyh6srdWrdJ6eXgyoVBYYcRSBfjtFMaPbhSleqJl
         2JWo8kfT4ntJBSymvbPqs9N+VxaTUl0wLkVIgzhog2DkUn7nsgScReUe1ELL/000E94q
         EJCLUM5JUdVjThTIGhsJBhfyWtGLSJKtyFpkl0xjk0hnomq/ca8R3QUqYV9dmrewTLwG
         Wd7A==
X-Gm-Message-State: APuU4Z/K5rZjhzjvIBvWr/KgUqQp043/8iqnOVML5uTUXgUVSzeJFfxi
	pvD+qcbJuBef1zWYMNKHFw0Io8ToKVs6UMtjzICWoZkktSymOoKN0bfB
X-Gm-Gg: AZFdTZeG7E1AACkNXht3qLpHnIPveM+Cs7XiHrx0mCKvWGnnlj6zGsTGrw8DDgUBtuV
	4KFeWjO/rPDcKf9AXtAFUyI5eq1gxdD4+Vy9EVJfLDzz5QBmp6GmpS3lb0UGj/XdJCmzhxG7sEc
	3CmJx4AY8K5ip5yGCso2unSz35EdGQEbTaZjgUv+rR/Jo6Q99OBSwlZr3xCLl+Y9wdnSGslp/YJ
	ZXqj3cVOeA5evF2LOZkSEtM7cwK5Ud1ViqRs2cKgv2ZHaGszbNGfWkluJ7km26NjbGLunDwkh1h
	UZpbBIIJEn438oRiNKnXwhEPUBKIRiMopd9B8LYEusNEHv7WWlPCHdeMgntzxI7ONvEa1Eycu1m
	yIuhgF88iWDEWnORO9DltnvmgWh/F2pWBkgavIPX4D3nRsBDAK9D/Iyu2jgIQFvkhgkCTHCldTA
	8eBfAz6AVBLKgAP54moO8ODM8RtzgFfKWGJ5N2x7Dmglg/5atWze9Lu/lCtHedfPpduNFteHACj
	xFyGVtGgelescG73ljdxbNY/+Dq9VnOAFViCcDP5BhBlE3YNtbmk/ivCe8gz/iznp+M2a/jSddt
	E5nOcdhH7DnsAO1b4U99q5ufS8r5XrrisE2OnvshYfNVMtofE5hOh8XOxpiHXqXOC1Ljkg==
X-Received: by 2002:a05:693c:414c:10b0:37a:15c:b8c5 with SMTP id 5a478bee46e88-384b11ebf27mr1183000eec.2.1795095523596;
        Thu, 19 Nov 2026 05:38:43 -0800 (PST)
Received: from APAC-DNT-664.sew.in ([106.219.160.100])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-382a7fbceffsm18806913eec.28.2026.11.19.05.38.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 05:38:43 -0800 (PST)
From: Himanshu Bhardwaj <bhardwajhimanshu2515@gmail.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	Himanshu Bhardwaj <bhardwajhimanshu2515@gmail.com>
Subject: [PATCH] tools: iio: Prefer channel-specific scale and offset values
Date: Thu, 19 Nov 2026 19:08:21 +0530
Message-ID: <20261119133821.949-1-bhardwajhimanshu2515@gmail.com>
X-Mailer: git-send-email 2.53.0.windows.2
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

iioutils_get_param_float() stops at the first directory entry matching
either the channel-specific attribute or its generic counterpart. If
the generic attribute is returned first, a more specific value is ignored.

For example, the MAX31855 driver exposes in_temp_scale as 250 and
in_temp_ambient_scale as 62.5. Reading the ambient scale can therefore
return 250, making the converted ambient temperature four times too
large. The offset lookup uses the same helper.

Continue searching after reading a generic attribute, and stop when the
channel-specific attribute is found. Free the temporary filename before
continuing to avoid leaking it when both attributes are present.

Reproduced with temporary attribute files containing the MAX31855 scale
values and both directory enumeration orders. The fixed helper passes
14 parameter lookup tests, including generic fallback and malformed
values. All three IIO tools build with -Wall -Werror.

Found, implemented and tested with assistance from OpenAI Codex;
independently reviewed and re-tested with Anthropic Claude. No physical
sensor hardware was used.

Fixes: e58537ccce73 ("staging: iio: update example application.")
Signed-off-by: Himanshu Bhardwaj <bhardwajhimanshu2515@gmail.com>
---
 tools/iio/iio_utils.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/iio/iio_utils.c b/tools/iio/iio_utils.c
index e274a0d..5df2c76 100644
--- a/tools/iio/iio_utils.c
+++ b/tools/iio/iio_utils.c
@@ -265,7 +265,12 @@ int iioutils_get_param_float(float *output, const char *param_name,
 				ret = errno ? -errno : -ENODATA;
 
 			fclose(sysfsfp);
-			break;
+			/* Prefer the channel-specific value over the generic one. */
+			if (strcmp(builtname, ent->d_name) == 0)
+				break;
+
+			free(filename);
+			filename = NULL;
 		}
 error_free_filename:
 	if (filename)

base-commit: 4405c18c95d2d0f99f6c581ef0ee8591a1aa6ccd
-- 
2.43.0

