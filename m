Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C083630BB
	for <linux-iio@vger.kernel.org>; Tue,  7 Apr 2026 15:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775575031; cv=none; b=fq5DQFD0/jq85B9zsVqT2q6wpX1jFkZuA37zm7oIaE4tychgTzNvN/+kafzcLf+8ltWCNZKtBRx7lNmnQBP4ixQNFsUFPjp9OKmykMUaU7QUQEvA+/IJPO+gvC0hZTMqU6bMnCXtL5mUQnG1kp2z2BMj4V7HOnmjCRs820PKSdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775575031; c=relaxed/simple;
	bh=bMBU/Sp/Hd+8dWJzIBSChhEWAq6h8QnFVVi6t0Td8CM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=upxC15PTkPWPFUEQz3MjjM5cj7n2ek8WVz+0hlpad528QD4Cd8ZDYyCG01Txhgkw6sCAYuMzDBBHzcMMAqh5C8Uh0v2F7P8GT8nCHEWBv+Q5eu9s2W2DG20pLPUC6jURZqGGhI92483wcgutnKQgItK0qmejW+ph1i3gsymr5D0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lSnqMTS9; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lSnqMTS9"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-488a88aeec9so36577525e9.2
        for <linux-iio@vger.kernel.org>; Tue, 07 Apr 2026 08:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775575027; x=1776179827; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I7ul7R4AdJ4kZnhxBsfC1ozDk40Au8wWcQ7o5oSGrE0=;
        b=lSnqMTS9+wbM/oBZcgbxOGZKhLCkCDXgnvavJHOE9jyx/nW+DTT+BCCST0DniaCA5Q
         6zerFEx/9u2aCoAIX0ZZDQZev8zma9nXtPpJUuyMIz1Bd11wpUEqB8uTMKQsVX9UFiCJ
         XjD7tKnXTRivw8RuMaqrTG+vshmSfz+y+y/brYyC9RqnhFkmNrCpbp2Lo6LyyR0VoBJT
         sciA2G1FZrxGBso3A1VKI0X14bMmojSl6BmarLJVo8pPUXxDy0dlF5GNtm7RPIltSyE9
         grminKiiqxe6iCSnUeHsHmNhPOVAulunqHprRnKa50fiIgTdVsUn7y1IAxpv3UtGMrit
         +itw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775575027; x=1776179827;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=I7ul7R4AdJ4kZnhxBsfC1ozDk40Au8wWcQ7o5oSGrE0=;
        b=UxByGEpjWmB+JKoxGOTozgGNuliEWmblHP4ziNviBxF2a8/P8mZi3oeBKswrW/91Zm
         C7bOfl2I2+S3jEWR/ABmLNYF7LQIjZAlaPAJnWcAct9/L+sGcFeMwETEFtX/barKEhTc
         //8vGpZTDrnIEEuTPZhb28awpfLKZdxFsTd00prlfdk7rjFHEepm9zQUE/pDLlTk6BqE
         2+F6HRQbQNWAOxVBJewMTLTcJUtDO391fD79UKbBu5p5SAs0/Ll92fauFPuAAF77Kwt2
         C9hJdwpdDLJawWqt2DHV1J9riYl+gtlD3DBxkIYa1JER4tfvIo6pHA39lrxP36yfG63n
         kz8Q==
X-Forwarded-Encrypted: i=1; AJvYcCXcF3nmdsJPJf2RZUwHFAJ2JLAxVs/0o1GbTUaEPTSxmDoeD0JrjGNUtUE1e5KHLCBeS6hXG2Y5fIg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzogMvDNAfyyTkVFUBzOCZP+O5YCeUkqr+puz+AR96bDAcqlw7k
	dxokB8dSebCsuJ7SFnio5TRRQf4+Nzz1L/xE5FkV/fEBq0AbDyzPJzxc
X-Gm-Gg: AeBDievznsyIiLuLf6Uz6U15jcoFdNgQg4WuM1/rwdbYaGBA7AEBcDZiSlrMpJQwsca
	Afh5gRKrlJmfwAnEhM3MCxxUIgZ53Pu4m45jecU3NWwST1Go3oe+j4OiMMmyQcBRiuQ9A45w+Z5
	xCsvt8FHPw3T2+lTuO7ssZWhan1ysnDymhXRBb/0GoEgnJyBu+nG31JchocjA9goeydSw3by2yu
	RmbU+/V4omlfUneLmSD56zDJ1vX2PZYeqX8trwqlAx7vtj0kuLn4LosmJONiTfZqSRAnXoEkrjb
	VaZfY8CJUQ+g3OI83SAhYzihCjgPkL034SO0WsYHQO5FuY4pfNKnfNm2pxfHu+nsaxykQqCBlWG
	G+NwCnR9YkAzXX6kBvYKlZnEr3zA0iHiOYdHiGOxYE4cIhPryk7ztVleF9VuZxBPdhEbzf+0EmM
	WnjKEGjPInrCI2HKMX30Hr6p2UW1AAqKfPWbKZ1LHLdVuyJCQUlDc=
X-Received: by 2002:a05:6000:184d:b0:43d:61:652a with SMTP id ffacd0b85a97d-43d292e8ab6mr25974359f8f.40.1775575027008;
        Tue, 07 Apr 2026 08:17:07 -0700 (PDT)
Received: from aldo-conte-t14.tailf68ad9.ts.net ([37.163.52.91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e2a6f13sm51924922f8f.3.2026.04.07.08.17.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 08:17:06 -0700 (PDT)
From: Aldo Conte <aldocontelk@gmail.com>
To: jic23@kernel.org
Cc: ktsai@capellamicro.com,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	daniel.baluta@intel.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	me@brighamcampbell.com,
	linux-kernel-mentees@lists.linux.dev
Subject: [PATCH v4 1/2] iio: light: cm3323: fix reg_conf not being initialized correctly
Date: Tue,  7 Apr 2026 17:17:01 +0200
Message-ID: <20260407151702.15208-2-aldocontelk@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260407151702.15208-1-aldocontelk@gmail.com>
References: <20260407151702.15208-1-aldocontelk@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The code stores the return value of i2c_smbus_write_word_data()
in data->reg_conf; however, this value represents the result
of the write operation and not the value actually written to
the configuration register. This meant that the contents of
data->reg_conf did not truly reflect the contents
of the hardware register.

Instead, save the value of the register before the write
and use this value in the I2C write.

The bug was found by code inspection: i2c_smbus_write_word_data()
returns 0 on success, not the value written to the register.

Tested using i2c-stub on a Raspberry Pi 3B running a custom 6.19.10
kernel. Before loading the driver, the configuration register 0x00
CM3323_CMD_CONF was populated with 0x0030 using
`i2cset -y 11 0x10 0x00 0x0030 w`, encoding an integration time of 320ms
in bits[6:4].

Due to incorrect initialization of data->reg_conf in
cm3323_init(), the print of integration_time returns 0.040000
instead of the expected 0.320000. This happens because the read of the
integration_time depends on cm3323_get_it_bits() that is based on the
value of data->reg_conf, which is erroneously set to 0.

With this fix applied, data->reg_conf correctly saves 0x0030 after init
and the successive integration_time reports 0.320000 as expected.

Fixes: 8b0544263761 ("iio: light: Add support for Capella CM3323 color sensor")
Cc: stable@vger.kernel.org
Signed-off-by: Aldo Conte <aldocontelk@gmail.com>
---
 drivers/iio/light/cm3323.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/light/cm3323.c b/drivers/iio/light/cm3323.c
index 79ad6e2209ca..0fe61b8a7029 100644
--- a/drivers/iio/light/cm3323.c
+++ b/drivers/iio/light/cm3323.c
@@ -89,15 +89,14 @@ static int cm3323_init(struct iio_dev *indio_dev)
 
 	/* enable sensor and set auto force mode */
 	ret &= ~(CM3323_CONF_SD_BIT | CM3323_CONF_AF_BIT);
+	data->reg_conf = ret;
 
-	ret = i2c_smbus_write_word_data(data->client, CM3323_CMD_CONF, ret);
+	ret = i2c_smbus_write_word_data(data->client, CM3323_CMD_CONF, data->reg_conf);
 	if (ret < 0) {
 		dev_err(&data->client->dev, "Error writing reg_conf\n");
 		return ret;
 	}
 
-	data->reg_conf = ret;
-
 	return 0;
 }
 
-- 
2.53.0

