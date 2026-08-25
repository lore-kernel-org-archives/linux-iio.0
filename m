Received: from out203-205-221-173.mail.qq.com (out203-205-221-173.mail.qq.com [203.205.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C5F937F33A;
	Tue, 25 Aug 2026 09:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787649678; cv=none; b=ODoWcu2M7Bg5qIB0YM2rJ5ZCAl5PN6L6NG376Qm76eWwYCx7nH421DhovMHmX4GfLf8p+KdPEXY87h1CwXNOxBjpLaKkr/QhPUHiw13tHqEkJUn09V4l7u5xHoYG783zp6Y/q8JFM2KqLUwZrRwxdTgMFXmRea1322mg+YZ6c+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787649678; c=relaxed/simple;
	bh=NUflGsY1xifJdKVEpngILCiPKhvEYXJz8UoZ5yUVvD4=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=kfVGz+/oasMxtr98u53GFBXDSB+3JpFPYDtikpwa09LhhlYR+N5BGamhY2vivRjE1/A8Ld+Dt8ErBOBDHZunrlozFkrTtmzWw4S+C9Ims9Dtw77N4tcFay2b0/TeO/xEAz5uKD+Euf7LWFnoYxss0YSwHw7eNA+02iGUVLqGcZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=OwMhTZoz; arc=none smtp.client-ip=203.205.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="OwMhTZoz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1787649674; bh=NUflGsY1xifJdKVEpngILCiPKhvEYXJz8UoZ5yUVvD4=;
	h=Date:To:Cc:From:Subject;
	b=OwMhTZoz7VE4HOyIC/xC+11dG/fwtMDCKERP58YDyz8z7dE94aFV8L+IBor+/Uts1
	 AbjL9oJ8LRscis/ZFAYBW6bP8oEazhPLClUX7S6uHs9+OQkCXWK2E3X0mmg95qi7Ss
	 /JXXuuenT0Zhv4oq2sKxULxjOLMPDV+Msihh/tdY=
Received: from [192.168.255.10] ([111.206.96.146])
	by newxmesmtplogicsvrszb51-0.qq.com (NewEsmtp) with SMTP
	id 54BAF0B4; Tue, 25 Aug 2026 17:21:11 +0800
X-QQ-mid: xmsmtpt1787649671to3wl6dv6
Message-ID: <tencent_0F43B1BC41CE4066DA52B7B25FBC04C41A09@qq.com>
X-QQ-XMAILINFO: OeJ9zRfntlNPcJMDz6y8C7oBgNLHYDVhSOJ3tzu7/060TCEeZj61DhpS0wNtK6
	 3ORyvMv6l4ds4sSRzQYHkFZ0Z1PEtJV/NEdqMaQxXZFe1+aEJYTWdWsX5ei+/AdkhxC0RVEkpe/N
	 SlxPUt+/Yatwtc7e3wOFHp+nc1eN6Npi4C1vazWiIoO8TWBUQpm1IGxJcoBAzLWkav6RI7Df2H4d
	 ynzQ/VezDEUxIZ8jlJ3EQ5UytKIBJ+xZFP84xPmpGHcivq3HUgzQiAKeQI5E8+qKZRYhROZRdF/V
	 v4+YCRK32xxrjYllsorP9RGPT+d0b0VqJvsKt+fAEnEgoCKgu568eKOLHYg5JBGu2tKX5JAlE/61
	 BzgppdsIC6Ql00YK7tUvtUqBzBJfKXUdvlqLRJaLWkRp8LO0V/p9jqQUG2GWOTAm77jd5zqQoSqc
	 jl46upQe4qPzShW2AM/GaCl0D7/a0mecUUxsYjFJ9rgyS8k6S41ENjMAN3lT/WJ3xKU1eV+dyRH+
	 L5XeE5ojwghW97hADZNroE+QcTjeI7oiaUq6yBE9+AouWTstgW590A4ULHfwF/MUbBHTCC7foP3k
	 VHqQnuV8oyr/pURrjacjtAVNTrc6e4TKcUCFtq285s3aKs1s53zKm7S8fuNdg0F1U1Jxy0xy66jO
	 kbjOnA4ogy+P8m2Uzr3gIPjoxwiu282W0dJFwJeLpPTa/FodRw139jDgfnwCHofWssRalAcUbdpW
	 cPOpmAW/n7RjW4YwP8IQR3xh0Nk8qWoIDZr41hwazFVcZ3iW9XGc2TY9MzRwhAcWNmPPAQqu+wA3
	 vOiksXQC+kGyIU10JHesSnrKfvfitRF7km3PDnvGi2HSn8dWZ1unTHCGd0LTL33VKU8IqHiSEfxx
	 rjRABBeMl1Zf/yTyKRFtDnvmXZLHlxTQ86x1EXaTyZJf/FAMA4CSIwlJJkMTSLoucVtRkeJ4uiLL
	 j2alg1aeno7mQTbzyUnmtsBmuC312OHYHMSdOXSbPpEr8lh1h0Qn107A5zQwIauaCQLwbfVcpREr
	 k8vrlJuNsi98jWc+cCg+4Ih3yWgoY0H3TGmhqhO8h8oXScV9mCtevPmDg8LsZ8EIdLGWB0rHTf0P
	 6QnBhzkaOjgCuBnBmffVJsR6LdqA==
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
X-OQ-MSGID: <bf8d405f-cc9d-483f-beb3-a5c113a53359@qq.com>
Date: Tue, 25 Aug 2026 17:21:10 +0800
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: lorenzo@kernel.org, jic23@kernel.org, linux-iio@vger.kernel.org
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 linux-kernel@vger.kernel.org
From: Yang Zi <2959243019@qq.com>
Subject: [PATCH] iio: humidity: hts221: fix division by zero in calibration
 data parsing
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

hts221_parse_temp_caldata() and hts221_parse_rh_caldata() compute the
sensor slope as ((cal_y1 - cal_y0) * 8000) / (cal_x1 - cal_x0). If the
device reports cal_x1 == cal_x0 the division causes a divide-by-zero
error.

Return -EINVAL when cal_x1 == cal_x0 in both functions before performing
the division.

Signed-off-by: Yang Zi <2959243019@qq.com>
---
diff --git a/drivers/iio/humidity/hts221_core.c b/drivers/iio/humidity/hts221_core.c
index bfeb0a60d3af..7d1f04951d8b 100644
--- a/drivers/iio/humidity/hts221_core.c
+++ b/drivers/iio/humidity/hts221_core.c
@@ -288,6 +288,9 @@ static int hts221_parse_temp_caldata(struct hts221_hw *hw)
         return err;
     cal_x1 = le16_to_cpu(val);
 
+    if (cal_x1 == cal_x0)
+        return -EINVAL;
+
     slope = &hw->sensors[HTS221_SENSOR_T].slope;
     b_gen = &hw->sensors[HTS221_SENSOR_T].b_gen;
 
@@ -327,6 +330,9 @@ static int hts221_parse_rh_caldata(struct hts221_hw *hw)
         return err;
     cal_x1 = le16_to_cpu(val);
 
+    if (cal_x1 == cal_x0)
+        return -EINVAL;
+
     slope = &hw->sensors[HTS221_SENSOR_H].slope;
     b_gen = &hw->sensors[HTS221_SENSOR_H].b_gen;
 

