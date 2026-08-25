Received: from out203-205-221-236.mail.qq.com (out203-205-221-236.mail.qq.com [203.205.221.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D764DF76;
	Tue, 25 Aug 2026 09:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787649491; cv=none; b=a4q56QWKr8hHIe0UWJwkOGHoUNg430XHJvJJ87o/XcEEIKW9AcegFCbPR/+KDlmC2IH5RqHEkW+q7fMV3pFGvmUb/uJAvUndGn1JXMH4BdaW1bcRAP/cjKVrzU8mhI63HEuqrYVlok+WT2IO9y6/Vpe/8iYc4MgLFP7RcM6LSTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787649491; c=relaxed/simple;
	bh=GT5SeKb+HsHIJGzWA2pmC6XOH6mlU5iYaqRX1onb5D4=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=MykGwSZ8KVNo/hETAlK1NqdP5jIAnd86wjOnMD/sIWN8bG1dQqJurw/G/LyKxzEYQY2JnvFz2ruxFqWvDeq5z7BFAqi0bR0aKQFPM9UK8gxyThplZ5b+mbtct/U6FDZD2v+8ypbC3c6GGRy4Eb2wtka7l9DueI80J/SZyf89i1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=Xy7Pbq40; arc=none smtp.client-ip=203.205.221.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="Xy7Pbq40"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1787649485; bh=GT5SeKb+HsHIJGzWA2pmC6XOH6mlU5iYaqRX1onb5D4=;
	h=Date:To:Cc:From:Subject;
	b=Xy7Pbq40fVUqrmZq69BaVm3NIRx66cUqXt+YsV5uKscv9xXbQScqoUTKXZW/+i+EJ
	 ziCpXVouxsGVBi6EiIsmOMrfN6ls00PkvyeL8l73bTv91pTnx0IhsQtO0WmmDZ4iEK
	 KancErfbohAVPN8y01f0BmeVA5B6eVll4YrF0nss=
Received: from [192.168.255.10] ([111.206.145.19])
	by newxmesmtplogicsvrszc56-0.qq.com (NewEsmtp) with SMTP
	id 483062B6; Tue, 25 Aug 2026 17:18:03 +0800
X-QQ-mid: xmsmtpt1787649483t8w0yzphn
Message-ID: <tencent_1936AF0C31F45000EFB7B38019EFD4A06C07@qq.com>
X-QQ-XMAILINFO: MllZffuBkEb5GFR44GyuddH1JdyAz7RXapcXHesUca8XdLArsGFxyAW9ST/QnE
	 d2G6idShpJzPvh/NJ+UBzTAAnns0O6y7Zz/JjjD16dzEruV9pFc/klozBmV2ioM3n99i65gWEjwB
	 jbOy8XLV7fhUS0eTmzyrebDEazdmozuUHVlWkumhDSRWiv1bVTDIEFiTDoDiwmFNtLQaWk8z653b
	 pWHxuhB4YxruVgiZAsEKPf6l5WyQxepZ5ma5gkg9z7R3MR+lGMQlZG5tTrK7gh3ayadaKgI9X+aF
	 X/qbVsk4jgoez/u2VhU+sPRZqzX+O1HyCeUDi5SBgi/GniR8zvDcQ63DAdcQtafEBpIox+4fEhKs
	 5+6fLgI9r03hrSy+ob334X5CVdDcnzhIdRTFtlJBm6C6ik/saFOFILrGYavLCPjWFY2qKnNfyAFA
	 iaH9rgG87ESPkU7dqsxD24zA+jXZdyTzcKpW3VU3j2TrVcQfQlFFn57QnYQs+DGsm7+fm7f9GyT/
	 koef+0jgt9UIyI/ShOUxahgBHTjryz+4FP3vAp0qjMzzGw16jJ1Phr45OTA5ymQ9PGvcTXm8UGpH
	 OfKnvTipEqH3r/3E0VLzmxJEG46s9F3PT8w0ppEQ0ooZaCyd/yu1MBiPpLmN4raVIdSX2cPFNB5E
	 cj7rge3jQzk4oSPEEpTSMFunjZKqGn6Slwpr8+iRaVSeF6BK+gwDZxWLiiV5TUb446Ct13x9hyz1
	 ZT7VP87rjSos8JM0yQz9cMYsQthDfX0TN59weimKj1TdbmpRWEA4UC12Tktw6WonGhQNrT0IMwPK
	 CPuYRnnS6gOvR3Ou5391smXVb0pSjEf3AhTPie965GZBYGRDrRc+c7sEl/5gjj1knqKpI1qWBzXy
	 FESKPCLBQHAOy2ffP4vqGnGs1dp/0Em5JVnlrvFHR30aJZ7A3foioznW+LpnHj6Mmv0mFELKFVof
	 KhdSp9+hr4zp9GAyFo8TyP5REz4z358G35ASLPBqSC2EH5K0DYDGVWZQOQIU/H1s7tQQCGrVWp6T
	 +V9hMhVTuySp5j4s+rVWhenUj6C59PWpCWvWjoS+Og/D8a0YI87DYduNEXkIooazAF8Ch/+bME7w
	 WfEfoorA1R9WvW2pL9Hiw0C12+zw==
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
X-OQ-MSGID: <8304e60c-a80e-4f4d-898d-55cca7f2b00b@qq.com>
Date: Tue, 25 Aug 2026 17:18:01 +0800
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: jic23@kernel.org, linux-iio@vger.kernel.org
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 u.kleine-koenig@baylibre.com, dakr@kernel.org, o-takashi@sakamocchi.jp,
 email@sirat.me, linux-kernel@vger.kernel.org
From: Yang Zi <2959243019@qq.com>
Subject: [PATCH] iio: proximity: sx9310: fix NULL pointer dereference in
 sx9310_check_whoami
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

device_get_match_data() can return NULL, e.g. when the device is matched
through the I2C device ID table rather than the OF/ACPI match tables. In
that case sx9310_check_whoami() dereferences a NULL pointer when reading
ddata->whoami.

Return -ENODEV if no match data is found to avoid the NULL pointer
dereference.

Signed-off-by: Yang Zi <2959243019@qq.com>
---
diff --git a/drivers/iio/proximity/sx9310.c b/drivers/iio/proximity/sx9310.c
index 79ba46d8a0aa..305b41f2847d 100644
--- a/drivers/iio/proximity/sx9310.c
+++ b/drivers/iio/proximity/sx9310.c
@@ -892,6 +892,8 @@ static int sx9310_check_whoami(struct device *dev,
         return ret;
 
     ddata = device_get_match_data(dev);
+    if (!ddata)
+        return -ENODEV;
     if (ddata->whoami != whoami)
         return -ENODEV;
 


