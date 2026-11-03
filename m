Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793744585;
	b=OyJoWmjZ/bJeAM01uxYM80F+nrcWwH7xTB+OIGqWfaAgK1GJ6Na9fOa0nAgI/6c3J7A1
	 k9m71r1k0F/h6L7opOWBLNO8I0KYOSRt/BMjco1pA5tdC7FSJNW84TsQjMPIvMISfDOxJ
	 JSPIzZXPiuMfaoXPxKaM4IzitJ6wX2PWimzXtojAjvViRKNeyEE0NJaqD0L1rIiWHpFd0
	 4GYmkBXIiFgCF9yCO3U8X29WKdiGTEzYc6sOm8SsTn7aGi1Xq+fcgdHD3kAYCFqSVQgU2
	 EgFXmnn/sqyayrY/xdcqOIc0ofEyY68hgFIc1hKPstMt+EwOayTFZtDsN9uxZJ5Ping==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793744585;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=THF8Gn9zKSMxI2CX7V8w53BXwvAHKb6Wu9y7FvwOfiw=;
	b=mny6msMcslP8vKzsL38lltQZpv3NELU0vwtn5vjEbCOcraTttqmjUCxOJVcOTMLcPjqC
	 QvYrByGAgqnh/eTiFgs8oGVBVbdyvjYtAKAoiYPW02LAb2xi+j8dY/F2J+TUx4fmmRV2m
	 qD/6UGdg0SMNeG1wohTMsRTPcvzToAe5j36QsjjEpCbh91NSb+JUefSKLkdGAxAORnph0
	 wTTgf36A1umZFAoGgAw41hO5fp1tksmRdF4Vvk0SCwE2NJu2gVv62H8AwGPXmkjtnUcFm
	 21Q6Kp5+p1tr0U/RRlN4OCnJ3pk6Aln3ZIpFp3pYq1nKFUbKnmF6o+PnEtY3sNP/HMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b="O/b1OBkU";
	arc=none smtp.remote-ip=74.125.82.170
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA62C606A334
	for <linux-iio@vger.kernel.org>; Tue,  3 Nov 2026 22:23:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DA62C606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=O/b1OBkU
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-33bf40b0c8bso69853eec.0
        for <linux-iio@vger.kernel.org>; Tue, 03 Nov 2026 14:23:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1793744584; x=1794349384; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=THF8Gn9zKSMxI2CX7V8w53BXwvAHKb6Wu9y7FvwOfiw=;
        b=O/b1OBkUuusx7DQz9ovmSOPSSxAEV/QAEiEDArBnps+M9LDURrfuDVoWYz7K/VTeli
         cE70AvCQX3EJPH5SJGyoosAKCOCG3NL8rTLrFsNGqscz2ut4PvM/DT4gr0LZZ9hmvLmO
         kRVrkkfDGKX90/e7ioXLP8mqy7m70e9GE5+2c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793744584; x=1794349384;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=THF8Gn9zKSMxI2CX7V8w53BXwvAHKb6Wu9y7FvwOfiw=;
        b=efzawVnlaHskHIo7tbqnGtP6CeLm1t8I0OtUIX6EQvDkQy07mUgcDDKPwoc1bRzsmz
         ac225QB0RgWXbIB4gQMLUs1p7+0qahjjDkeYNRmbE9aKOfMD2XVe2iDMWxEF7sL5XVGB
         CrzwV/d66u5elRaaB+Y5fM6i6/VQ8pHqlOBo/oYI1MvUQwMQx0FKgycL/ZLgctdbWPYN
         pXEnO8q/6X47dxVbfpjonrKzjmvKC/JWi1ly4U8xW6d42FSoI7kFcAoj4h9AZ2PfjQ3T
         ss63BqAfrCPU8BcNnuzOImnzi6+UanSV3w2C6Z8tsKrm/301UrF2bY8zre5E3nwYbqpF
         fFqg==
X-Forwarded-Encrypted: i=1; AKwUvBwsgSfNr9fYnk95NqNDyEsf8z2A30cWmVyQ73FzZxwjAxL20b4jh4iHGs5wx8pQbbsLI84dDf/feF8=@vger.kernel.org
X-Gm-Message-State: APuU4Z/htIEDxgaix8/rIwqXDwI2FAg4xusYsuWiC0w9cyhe/Q/FZTQr
	m74iLnyOra5lN3AjQdPg+o8LAWvoca96vp8k0O1lR4FFuo38hTdqy7C5w8QlQy3kPQ==
X-Gm-Gg: AYBFou14CHLu809ed2jRJbpTGtmW3clK2GwMkNn9LLDU/AUU2pEZbU4a5e/8MCpXKoA
	FRStvfJPTfDkCpv6ft9aqF8iWJaEjxQAqHcBhZt7Jw2uE+1r7cE0+20agLrgG3dKRuKuiD1zhN2
	2WjxKRBGQ1jP5vthqM4bmD9i0bu0ulNa4JerpC82H8qnZfVmlscgFfIMCM1VjWOyl7QrbJ7RJpu
	V0zBKxTnnHomlhEmSKuNdUGkyJ4MhJNcLF/aWWtBYQC63GRdazq1Bh01mV4HJcxFIxBoKWMTE2P
	c6PwCiEloYlv60EYXhnL5rcoUvsNJIlXAXcnUfHp+tRYLYbTeiOTl2k8SYFVo9fe+UTEASRRbFc
	sOysBRBcFsy4vxXlk4BY7XrtOSvBQN+/IHOFfDLHHgt4lTCpUqGXU0MxPRzXXuBHiAsx0Gy1hh5
	LxM1s0+OsdOJa28pmlqmTmvz8T9PJ9tPjbXux7+jK7Q11/pyG4jaCAIKLNizNxDkO4trWZ2DfsI
	b145UShw9IcC0YZSqxe+sgGRPotGCC/XzU1fU35q/B+U4ncg6ugvgftOAJEu27BZja737q8Jpdj
	IeM3S3qrk0Z/kTn0jNEcRXslN260G832exjF2W6s8R9s7Vf8wkG7oodgKWZc/vDfa9vKlzKXUY7
	ub7hhIADYfirXRw==
X-Received: by 2002:a05:693c:69c9:b0:36a:13df:749d with SMTP id 5a478bee46e88-36a423b3dffmr18134134eec.24.1793744583878;
        Tue, 03 Nov 2026 14:23:03 -0800 (PST)
Received: from localhost ([2a00:79e0:2e7c:8:ab71:b3df:693a:fbf2])
        by smtp.gmail.com with UTF8SMTPSA id 5a478bee46e88-36ca38a67edsm988222eec.8.2026.11.03.14.23.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2026 14:23:02 -0800 (PST)
From: Brian Norris <briannorris@chromium.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Fabrice Gasnier <fabrice.gasnier@st.com>,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Ulf Hansson <ulfh@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	Andy Shevchenko <andy@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Brian Norris <briannorris@chromium.org>
Subject: [PATCH v2 1/5] PM: runtime: Only queue an idle check for RPM-linked suppliers (part 2)
Date: Tue,  3 Nov 2026 14:14:39 -0800
Message-ID: <20261103141442.v2.1.If69ddc515c2e9fd4338441e87688b9d690d2ef36@changeid>
X-Mailer: git-send-email 2.56.0.398.g882cbad275-goog
In-Reply-To: <20261103221717.3840215-1-briannorris@chromium.org>
References: <20261103221717.3840215-1-briannorris@chromium.org>
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

Commit be5755f023e7 ("PM: runtime: Only queue an idle check for
RPM-linked suppliers") was incomplete. There are two other cases where
we perform idle checks on non-DL_FLAG_PM_RUNTIME suppliers -- in
pm_runtime_set_suspended(), and in cases where we failed to resume
suppliers.

Fixes: 5244f5e2d801 ("PM: runtime: Defer suspending suppliers")
Signed-off-by: Brian Norris <briannorris@chromium.org>
---
Noticed while touching this function in subsequent work.

(no changes since v1)

 drivers/base/power/runtime.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index 304a2b123420..9d3508d9b4a2 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -343,6 +343,9 @@ static void __rpm_put_suppliers(struct device *dev, bool try_to_suspend)
 
 	list_for_each_entry_rcu(link, &dev->links.suppliers, c_node,
 				device_links_read_lock_held()) {
+		if (!device_link_test(link, DL_FLAG_PM_RUNTIME))
+			continue;
+
 		pm_runtime_release_supplier(link);
 		if (try_to_suspend)
 			pm_request_idle(link->supplier);
-- 
2.56.0.398.g882cbad275-goog

