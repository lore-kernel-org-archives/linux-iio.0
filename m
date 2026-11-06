Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793993575;
	b=SrHiflSenpA76R4Lwj1RzIayxyd6GCCkJ4bNdEFrx3D4eZ8aAGmunBuczGULrHrcnR54
	 iYRYtKUq8R/Ghh4WEzY+5cRZaR9hV1JH/OrJeujjQMGzTn5FYzn1ymOA4PgYaoUMIoWPR
	 TzKYzC2B7wBXoDBO3REeslnscWjXl0sPuVh55FtQ3YT5weMeffztwFV9wAgh47+1laO1J
	 a+e3JM3YQw8t78LCdkWxV7VsAkiP+B7sxMQ4VGpDtZUL8sqcLgvPc/H4PlGvjrYdlg84b
	 nfJch8vvHMDT7zMrFLRYv/A4zaYBi4tquFGu7jco/bBrqJJjbtenUmQC07+RQuedu9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793993575;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=/r3iKwOujJ0k9iRfRMb2nXgYVKkbMoaxokk4Fx5YuMk=;
	b=TNvQ9c3uMEcp/WMkUAT86Db82jNW2ogKNFMhNDbMDaqqCUnA0E/VoCU0bMpRqFE7NwVH
	 ts7mf2C7mmj/1DkSZMR43samXxS6V5sGTXNxIvxcrgcFv1Awd5YYFO/B3gPhG4cDSGj73
	 VhIly9VKZVs4t7KD7Yy7c3lJhT0U+40gn8hBR9OlqiGb5o04LnahmqR+QI/K/NVsA6hb1
	 b3pBfMBVmUCHo6TlB0LwvL91iGuNsdkTkk7jwvyT+M4tfWmSvMXVwRk5+adky1k7JzThF
	 Ne4TwmDEBUkPhhDbWVVYnArxku+AgbK6yJrNtGtpF6ZQJnRiYcy8tsqlwLa0XVnmCtg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--dbalint.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="AJl/oz2K";
	arc=none smtp.remote-ip=209.85.208.200
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com [209.85.208.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2894606A329
	for <linux-iio@vger.kernel.org>; Fri,  6 Nov 2026 19:32:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E2894606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dbalint.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=AJl/oz2K
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-3ab3061668eso4764161fa.1
        for <linux-iio@vger.kernel.org>; Fri, 06 Nov 2026 11:32:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793993573; x=1794598373; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/r3iKwOujJ0k9iRfRMb2nXgYVKkbMoaxokk4Fx5YuMk=;
        b=AJl/oz2KTG1VBy0Y5l0VEECGhtquL5PzpdP1sb9PtaqIkbAB0THpeGHJb5TQPJNosk
         ch/XJCUboLbbLC6YWhyjJIYB08eo6fRvDYaHCPkb2rltS1awwwPwc9foVExjND5mvrX4
         mnPlVGdkq3KCw+eKHc1GrQ+onoCt0iBkP9w7fKKZ25P4tPX/Ekm5iwaO5lBVwOuA7l6b
         sUdG/LgycgOGknHjoqA1+itwl9b1wD728YfdreBKbptA1s+NtbpZtSu/fiW5ChnryDuq
         uYt4gzpJki1bS92vK5T/O2iKIKrHnVhagDegePiKgMl+ayazePUPy9paG1nYwKfCncF2
         9dXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793993573; x=1794598373;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/r3iKwOujJ0k9iRfRMb2nXgYVKkbMoaxokk4Fx5YuMk=;
        b=PkVCMFwyHq6VkGW/8/mJdL9UcpJLMLvmr0SRy0M76/Gsi/qKas6J8RbS1JCRlVE1J6
         69eCxJaBG3DzC0nVzZvoHEQneriRXLYBGEMCHdxhO+3qbeOj8R7+gaEAVE1rkH7WPmAh
         CslsKdT9aXbxBsFnLi1Fz8HBaAEMyOiC2ijZhJToM0dlLfcXG/XAIffnvqWAl0wea1Yu
         7U0hOjkbm/biZz0UEc/wQV+uaCbHb37qvwTvFFb+NdH86AwsBmAu8KJxkgEL6nts7aV2
         QknFpktqQ6wSNtk6KWA+/u3U0sehL3BUxxfme9N4QwGwIlV522yc7kRAPyslKhdZBT/G
         9Z2w==
X-Gm-Message-State: APuU4Z/jSevsHU9OOzAlf+dC387TYZ16SYtjZx5T9HeWJDWPIvyhoIBu
	q1rApL1XSzxy6owGbO310xz/qDC2JEZ4QkjmouwF0AdxxGEUwpLjrkxHgihq/d+fwdHkIdxVu0z
	AZLuBcbUnhg==
X-Received: from ljou21.prod.google.com ([2002:a2e:b815:0:b0:3ac:e012:5784])
 (user=dbalint job=prod-delivery.src-stubby-dispatcher) by 2002:a2e:a80a:0:b0:3a9:8762:d77
 with SMTP id 38308e7fff4ca-3ace3028f4dmr14685591fa.6.1793993573005; Fri, 06
 Nov 2026 11:32:53 -0800 (PST)
Date: Fri,  6 Nov 2026 19:31:15 +0000
In-Reply-To: <20261106193129.43493-1-dbalint@google.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261106193129.43493-1-dbalint@google.com>
X-Mailer: git-send-email 2.56.0.455.g6c5a503b38-goog
Message-ID: <20261106193129.43493-2-dbalint@google.com>
Subject: [PATCH v1 1/3] platform/chrome: cros_ec: fix alignment of ec_params_pwrmon
From: Daniel Balint <dbalint@google.com>
To: Jonathan Cameron <jic23@kernel.org>, Benson Leung <bleung@chromium.org>, Lee Jones <lee@kernel.org>, 
	Tzung-Bi Shih <tzungbi@kernel.org>
Cc: linux-iio@vger.kernel.org, chrome-platform@lists.linux.dev, 
	mfd@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Daniel Balint <dbalint@google.com>
Content-Type: text/plain; charset="UTF-8"

Sync EC_CMD_PWRMON structure padding with ChromeOS EC firmware by adding
explicit reserved padding to struct ec_params_pwrmon (2-byte union
alignment) and struct pwrmon_dump_info (4-byte struct size alignment),
as __ec_align2 and __ec_align4 expand to __packed in Linux.

Fixes: b57af7f8d194 ("platform/chrome: cros_ec: Sync host command header with EC")
Signed-off-by: Daniel Balint <dbalint@google.com>
---
 include/linux/platform_data/cros_ec_commands.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/platform_data/cros_ec_commands.h b/include/linux/platform_data/cros_ec_commands.h
index a7bd69d83522..6d74371c7074 100644
--- a/include/linux/platform_data/cros_ec_commands.h
+++ b/include/linux/platform_data/cros_ec_commands.h
@@ -6635,6 +6635,7 @@ enum ec_pwrmon_cmd {
 
 struct ec_params_pwrmon {
 	uint8_t cmd;
+	uint8_t reserved;
 	union {
 		uint16_t set_rate;
 		uint8_t channel_id;
@@ -6651,6 +6652,7 @@ struct ec_params_pwrmon {
 struct pwrmon_dump_info {
 	uint8_t channel_id;
 	char channel_name[32];
+	uint8_t reserved[3];
 } __ec_align4;
 
 struct ec_response_pwrmon {
-- 
2.56.0.455.g6c5a503b38-goog

