Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794213870;
	b=XgztUx5+FkAownvfO0eS2rlr5PDdScz/zrrMqkzyW68yFIO4Fl/CgSs6CAoeWL4xSgys
	 4EhuPKXTwR2FquyPpzMa62HAzXF4bRzJYFHVBW0BC/gn+GwB/amk57LCYYXtmiRE9Z2nx
	 06x6wUlqQ/jsSffWV/seXi5zqHI8nyLJbEjsrZJX4GY3G5e4cPGFiK0TlXyjR0aHQmqJT
	 aMUTIXn4bDLaw/cytUsMd03q/is4dy/sYVQYJwsyL+ndtBnn6rUDfgwoQDdnYqgz4E+/D
	 ePDD27vDr2+3//GI7pEiC2N4Yb8KAEHk5ul6axAf0yyPatVOJupW4jzGO9QsOQKEVPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794213870;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=kSWF2kuv83msu0L1SOhEm6iVW6rIPqvCwEF2UoZ5xlg=;
	b=gAXuFGRenLjeDWEUywcz7NhO9fpgwvprgqPNjG4hycYSTZTVrgPB6bhFe3qA7bW71HJX
	 vq/6Mr8HbK3sSJiZrj2ByBD4+5QMr2vNwF2mQpQmiWiCyP/IpqTrjht1tPHNvQ3lXsM5e
	 iPlW0kWRS7YlR7wvJLRadVyNXR61hkdSnP37s4bkdrv6f7L3G+UTuYF3VMXzuZnGJLP6x
	 i/+cdHHs0yrpNT0r6IuUNceHtVPxB33mWshMCulnr42+FpWI7JdzRog3Uofp/YVfoZu23
	 DJiIs7PPSJNAXtImDYBwmmrtCyORhsYYvi255hk/pxq2zl4zqXm+/hF7qRCTH3rRbkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=x6cNtGK3;
	arc=none smtp.remote-ip=209.85.210.169
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F99C606A321
	for <linux-iio@vger.kernel.org>; Mon,  9 Nov 2026 08:44:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9F99C606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=x6cNtGK3
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-8b3577deeb0so237304b3a.3
        for <linux-iio@vger.kernel.org>; Mon, 09 Nov 2026 00:44:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794213869; x=1794818669; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=kSWF2kuv83msu0L1SOhEm6iVW6rIPqvCwEF2UoZ5xlg=;
        b=x6cNtGK3ePw318rIzwt0OFqFCFA9OEIncfFgZbuEzg9b59N1TYpAW/T1mmJGvPgwjl
         FvNInd8U5QKUU5MUilph0RK9qxp4mSv67cyA110sKrj352y7h8cHRK5utB9KSSbhB6VW
         xuWFx5eogWt0BNbTE0fsTkDwRaDPvssAPArt+88W/dFqqlBm5obog40uWk9xwndFS6H7
         a6f0TKy4NHYQnLEWHfy876tISXw/+mJzbNTsQDqXva9pQGfV/9ZqRBwp0k01eTzKyGej
         KwCbRYFLmDnjtSRHrMtDKFO2JNTlNsWgORSojOapdzfUKgZDY0EduxArBcSEwLng5Yiu
         gFGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794213869; x=1794818669;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kSWF2kuv83msu0L1SOhEm6iVW6rIPqvCwEF2UoZ5xlg=;
        b=Ft8gMt0YzMnc1cUMHGfbs8eKvHdLcqnRwb0szbT9U3jXZzzwynZ19Q+tctrmZI4FUW
         PjXXkyv9vLh8F9z2H5rL0ABXJD6jEh+ydiGFx7om6PG8yj4y2Vy3W9pcCp+DGGkry7p3
         FgFT1iqC2hCDEQt+VX1tQI77IMYFQxrGAbJOcO8evCMksnV6J2xusLFlq4Hhng1Rtg+x
         mHFvYvs31qg6LNPjDm3VU1QEQfxeJwuSoR0TYjaIZSLmbnXrMTfcJhazfxg+hLbdwiDr
         Bh4ZIePbKnYQOjaXzdw/8AOncbHIYxO51BaGMbIK6ztESkWZG/xXUZWazaQz0B/1SAL4
         uq3Q==
X-Forwarded-Encrypted: i=1; AL+hErHXIrrxVMA3yXQgvv4enGBYfnsF8WIj7Fs9LbkTWpkkPujk/K1QL/M2mC0Lex0N6LVsANywinzJXmg=@vger.kernel.org
X-Gm-Message-State: APuU4Z/izt+PVqA5qT9nZMcCTv5u0VYS3RRVo5rRRN/0m80QMRC+rDJB
	pXpdtaF6rcZlfnaFVrQf1AbiXcS/WjOFmQO5vf7Uk3c5y6xUlItPNqXTIBCSfg==
X-Gm-Gg: AYBFou0aYFIK0bS9jTfru279cZYvkfC5R3L0vRbeevDmcaqsJWnywTTd0rn8maxWZ39
	YBcJW2JI/SLh4Czqp3w7VoG5D7rxSKLbhoQt3xOYkbIgXClexOiLxKzITV65DtPKB6qaMcoV6ZI
	Fzi5KIaSiVBi/WdCVBu5Z3pTXjsUhgG9DapSRee4oN+bA0tfpBO/chgAPR2dz4+W4xJfn8KY9mb
	K+sHSPq21nvy92lYbk0gke2M2tBTbKxUs+f01MUKtCaGvsP3BklsW2ZdcyJ0tjCR1Ir3l/uaizE
	9e4LalgynAQ1/aS+4AbYsosz4XYEL9GXc8xI9yMLKxZNaUrqvrRtvkZro/8wrEXXgIx5gWWh5j6
	hxp1SvQG583acY13WG4PLKT6O3k1rAv/B+0D+n8AniYhF/gc9gdma5A605+aqeUhEXUSlETxDDf
	GeYMUVsVO7SalVmtWxMkR8e5cl3Dx7nA5Q2347UF0aIR76E4TRjojb2blwATV3fWNFGG1J0mMmg
	lyr0itzw/a+zlIVvC4bKlAk9iERT+WRxpAC5xcoVcm50gkdaETAvHbZiqMQb6gitcwWTGgT8hbw
	UlNV4MvUyEsdVZrcY6XAMGB5cvnChwDPvLvrxYXvxtFNplCkpg5llZDpgXl0TfTWIBzVNhNuw/m
	1lRt3KwYr/URYO1kwkbbAKvaRmq1wk/hkWWvxnsauAYxy
X-Received: by 2002:a05:6a21:e58c:b0:3eb:a628:1095 with SMTP id adf61e73a8af0-3eed2c07761mr2906916637.20.1794213868862;
        Mon, 09 Nov 2026 00:44:28 -0800 (PST)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cdb96816fc6sm1413751a12.5.2026.11.09.00.44.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 00:44:27 -0800 (PST)
From: phucduc.bui@gmail.com
To: wbg@kernel.org,
	andriy.shevchenko@intel.com,
	David Lechner <david@lechnology.com>
Cc: andy@kernel.org,
	dlechner@baylibre.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	m32285159@gmail.com,
	nuno.sa@analog.com,
	phucduc.bui@gmail.com,
	sozdayvek@gmail.com
Subject: [PATCH v4 0/2] counter: ti-eqep: Fix runtime PM leak and use devm_counter_add()
Date: Mon,  9 Nov 2026 15:43:40 +0700
Message-ID: <20261109084342.51865-1-phucduc.bui@gmail.com>
X-Mailer: git-send-email 2.43.0
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

From: bui duc phuc <phucduc.bui@gmail.com>

Hi,

This series picks up Stepan's v3 [1], which had no follow-up since
May, with William's agreement [2].

v4:
 - Reword commit message of patch 1 as suggested by Andy
 - Add patch 2 to use devm_counter_add() and drop ti_eqep_remove()
   as suggested by William.

Link v3: 
https://lore.kernel.org/all/20260529095834.2561-1-sozdayvek@gmail.com/
Link v2: 
https://lore.kernel.org/all/20260525152137.7428-1-sozdayvek@gmail.com/
Link v1: 
https://lore.kernel.org/all/20260523184448.7609-1-sozdayvek@gmail.com/

[1] https://lore.kernel.org/all/20260529095834.2561-1-sozdayvek@gmail.com/
[2] https://lore.kernel.org/all/20261106193208.4136410-1-wbg@kernel.org/

Compile-tested only.

Best regards,
Phuc

Stepan Ionichev (1):
  counter: ti-eqep: Fix runtime PM leak on probe failure

bui duc phuc (1):
  counter: ti-eqep: Use devm_counter_add()

 drivers/counter/ti-eqep.c | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

-- 
2.43.0

