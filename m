Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76E283C10AD
	for <linux-iio@vger.kernel.org>; Mon, 27 Jul 2026 18:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785178145; cv=none; b=F+a9ZqESuzmssjFZY8RRee5BCC9zsHAnxDPP32EROQrU1+js3qVBq7QJ8MRH1J0ziIhaZh9ZnCD8ULkqIlMgO1gqRHDNaRFKLm1SP9NFK3a3ds2xdWu38cXRBEQUfcX7bNQTJFxPo/S/snK93oK63IFNUmNbsvxXFa3f1T+1oQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785178145; c=relaxed/simple;
	bh=7KfZFyqiBPTGv5wkrPslqWTcObXu90hXU19yUkaHgoA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FxvZcchcDGhg6zJysuNhldj/TJHwFyzuJTKdQOMgIxW6CGzCncfglOiqChxVdVeEI7OWXYey/n2GVSWEjxSBMAIP3IuLiP0ImQbDY5HrOjEVOepiXKuxvBBpkIaQi1c25yhjNui88xd3meI2ulBpBjgdXUDdPfAz1/QKQ2lspo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mveQ7mhk; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mveQ7mhk"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2cca0c5799eso29053735ad.0
        for <linux-iio@vger.kernel.org>; Mon, 27 Jul 2026 11:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785178144; x=1785782944; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9Ijvjd9arCNlysK3iRVKSO9sm2ivqVyemvyFLZGCkHI=;
        b=mveQ7mhkhb5kB1w95KhHk2BFARTIWSUn1MMof4za0XUbjgMr23KdCQ6M+IO9IW/lVF
         6P8RkUpXHUJ1tFLCDLuhiJerEcTPMIPxR6vA4jAJ2nhFSmiyQ/Qdlw+e/c4RllpZ+uhF
         2rSnp6ve/ZBMxPW63Nb+WnjdV+Uco4BSGw6vdZaZTALrYuOS2AzNB+fqWuxkrFJOg4EX
         bXGPqOJj64PVdazvPVMiC+2luKME4sdiv1osAS78AMUh5WZbMN9Nt/D4oewlK+Wfdb0a
         pME7dy+6RPlsUY06BK9qdhKRt4CdKSiM40Jm0bOrkfgD+woeZEVLaI74Bsx7Z6woZjsS
         MFAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785178144; x=1785782944;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9Ijvjd9arCNlysK3iRVKSO9sm2ivqVyemvyFLZGCkHI=;
        b=BdTIt3MxDlTR8XUnye5t1cBD8vPvF5/vF6rBh7NKI/CuEGMj9wUboSRLYyleTBiEQe
         2h7LDQlgjuVJCJkVzGEQhsPitEwV65iBjGvLVFxUbLjJgc3LukKhoR20BAXGJ7o5KbUV
         pOIByas4tcgGklWy1YfhlVckRJ8Qkd8RpBacxdm4zgdj3KVqY6JrtBuETTJ82Xo+nj4g
         pb1BCKq5TRRzXl929QQD2ts3TICA2Rj/Apl7sOCzdX1Tx5+kcxG2l0UK21zcWl7UX9Qt
         c+I1fr5P7H6bJ6P0zPGw50A7L3JLfHodRNrfetX91SNsQJGx7DMZohQuvdddLTg6u6XD
         +l/Q==
X-Forwarded-Encrypted: i=1; AHgh+RoaFaDyr9eldX/Vc06/h92YwOK5jHozN9XD9Gvj0sog8UNkbaWkPJH4laJo6Flw/bsOny8IJjJVe2E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0hvqImBZ4/4s2wAuoZO8A5wbHGOBHDR5kNsyf0o+hy8DZu5+U
	j8eaSyJzYDj+Ew+gzHSetTLIPPxZW196vf/n+J/FpSZo9BONJRsDFr/Q
X-Gm-Gg: AR+sD10WDWBUfcvHCHwyDRikX4djUA4b8N8Bi8dV/bTqNCm+m1sESw5XAArqs/elcn9
	RvldQjIIQk3xOn5L/u6m0VN9Awu4ZK03MQF6TfwskEbe9iQDFIKpve8yb7Lh9JR2uO/iEx09O0a
	8OhxB8ghpNvHBhNvOXyA+QvFsGqg9j6kCJqAo0MmWMlrKTlEhjvsqRjqGuvyQclyDoHyUOgpbwT
	EDVq0+8gBpPUvMSXAzhkHd5vO0zSM0kdtSJGPJ5qAuejnxBSM03wlv4/1ow+0ScKqySlp99LZCz
	51rs52nmiwPPkGuXOmC4jZ3B1ENXx3T+BgYarD8I8lDmeV4EuhpisEL8K9vT4hOuP3RkxkSsnCG
	oI4UAp5D+Ofr8eSdvFuc0uwAwlM5XTJgeYeCJIRJFi7RMcDN52lLfdXu8Hzmz3LtHNoiReKzY
X-Received: by 2002:a17:903:18b:b0:2cc:8267:31b5 with SMTP id d9443c01a7336-2cfde7adcbamr88312545ad.19.1785178143798;
        Mon, 27 Jul 2026 11:49:03 -0700 (PDT)
Received: from ubuntu.. ([110.9.142.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cfde7d7b87sm40186245ad.57.2026.07.27.11.49.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 11:49:03 -0700 (PDT)
From: Sang-Heon Jeon <ekffu200098@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Andy Shevchenko <andy@kernel.org>,
	Brian Masney <masneyb@onstation.org>,
	David Lechner <dlechner@baylibre.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Linus Walleij <linusw@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Magnus Damm <magnus.damm@gmail.com>,
	Marek Vasut <marek.vasut+renesas@mailbox.org>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>
Subject: [PATCH 1/9] iio: light: isl29028: return zero in write_raw() on success
Date: Tue, 28 Jul 2026 03:47:38 +0900
Message-ID: <20260727184755.2055414-2-ekffu200098@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260727184755.2055414-1-ekffu200098@gmail.com>
References: <20260727184755.2055414-1-ekffu200098@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

isl29028_write_raw() returns the value of pm_runtime_put_autosuspend(),
which is 1 if the device is already runtime suspended.

In that case write() on the sysfs attribute returns 1 instead of the
number of bytes written. Make isl29028_write_raw() always return zero
on success.

Fixes: 2db5054ac28d ("staging: iio: isl29028: add runtime power management support")
Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
---
 drivers/iio/light/isl29028.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/light/isl29028.c b/drivers/iio/light/isl29028.c
index b88e7c4eae3e..6d5dd17e7a7d 100644
--- a/drivers/iio/light/isl29028.c
+++ b/drivers/iio/light/isl29028.c
@@ -409,7 +409,7 @@ static int isl29028_write_raw(struct iio_dev *indio_dev,
 	if (ret < 0)
 		return ret;
 
-	return ret;
+	return 0;
 }
 
 static int isl29028_read_raw(struct iio_dev *indio_dev,
-- 
2.43.0

