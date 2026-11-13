Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794547539;
	b=b5b6AR5nANkZukxTTgs/V91KsB+9/BoJVeb1j5BJcoZbR1DdMyI2gZ1w3FYzRCeUUuV+
	 jPp2YPeo8tOQvzeJDzTrRdYLaUTGNDAZhzdrC7WKCZENyOJk6L5nqijAHmrfJVN/1M4nG
	 BmuOBkVtVOp6HFPAKMXEeEasUPImMMqDjykj7EZaHiwO7iEOmLt3af2WZSBvA4yD21w9R
	 jI6rLJs/8Vv+XUZJRADAis5EwQV9CTxuTB4tLy2pCBTHcg6XVCA+FaOzo/i//fWersMz+
	 jRFK1MEUs2tw6xENz8eZKPvQqJ61ItgQ1vUuArCjmSa4RJlktbbscFGQhgrWWDaI8DA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794547539;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Subject:Date:
	 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=1k1ZBJ5LzpgKy9mCLIxV5Gei8N0BYaOcvVjj0wNHHsk=;
	b=xzX1b2lObWp5BWfmyoYC2ZAf87UalQh1ApOL429kNor+v4CkeBj5K8mS2lhhmmZv0Aqq
	 ZqXMmigHr5pKYwiPl/7ijocs/kLDsN6z7SwzC8HYgHQwETGVGU9WKWgaL5W8y0R9vyNw0
	 z4M4MYGthkwIKp+ODYlOK4fWlygr+jRxXu7TUxv/FAbjCzqrjQHjnGH6s7KvbH2UsRdSj
	 Hgu8r198C1Q3Y0ijq80UH1Szqiuc4JuAarPxm7FZGeo91fmy8cyrYTu9QFMNSoZAs2zpC
	 jeweC4wPa4JENQUxeMpEnjgcB4Gy7ZGdjWqbiU70NsYalhO5CGdIkZBxdY9dNQrsCrg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HWxBsus9;
	arc=none smtp.remote-ip=209.85.222.51
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD9F8606A323
	for <linux-iio@vger.kernel.org>; Fri, 13 Nov 2026 05:25:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CD9F8606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HWxBsus9
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-99c042cee7dso768986241.1
        for <linux-iio@vger.kernel.org>; Thu, 12 Nov 2026 21:25:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794547538; x=1795152338; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=1k1ZBJ5LzpgKy9mCLIxV5Gei8N0BYaOcvVjj0wNHHsk=;
        b=HWxBsus9+TexH+K32UbY9OmVeoR4YngQfk9i27+9bKYEkT2dSGR2LDY2E1JldGlLnB
         rO59w5cdBVjtI3GY8x27Ag4xgW0uZxbx0F9WqHIssuG7EDgS8SlyDXJvCuIKjyj/uJpa
         2BIr/NCtFH4qOZaCeFusjYbQDRaT4WcoqjgmAvLW5sLOO4dBsIvs3ML5NJRG4N37ugOn
         Jj8QHPY+MiWpKT0tshbpvodJfpFQeUZasTPSiPmU7rsudju4OfFl5QGEoaHgmR/quw49
         LbkJbEAqcYIxJ5uznW6DjIlQD0zAknaqHfVlLlyswfSb38XnXDifz+Y6DE4JGniJtT/X
         Ld1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794547538; x=1795152338;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=1k1ZBJ5LzpgKy9mCLIxV5Gei8N0BYaOcvVjj0wNHHsk=;
        b=1/teJ/1wX9eSnATV5hJTYl3hb0XHqD2DsdDaDPbUuUbMCP4fpGGIi1mrBgQNtxeIV4
         FIpjuQY4Q6bnCmq6qrK0YQ4S82vnt4Dcyti4dr1XeJviZD7zfEPMdyF+SQ5vMUOFXE7P
         J7F1cfrZkgoL7OZ4ocO9xB6Iex5qJQRkKg71gEEoxuJuoMquRmNOr5wsNf7SlF/2R/yq
         2IvcG/Dr9GdT5NJ3TwwlkEaA42N8RsfYyml0F9X+U8T8/t+3A1WctfsDJqhb4D9Ataml
         DFrY6uBMzLr2QhotXzRdmSb1dnB9wA365tcsv8WN5bzNllUI0bzQh5K4Hcxqw3wQ8cFn
         GFcQ==
X-Gm-Message-State: APuU4Z9Zh03CZeGJtz1tBHZq1kiFPL1BShQVZ/1cPi1DeXDF0r7IOUlV
	nQrJ+Fk+Sl28hbxMEQLVr3rKEK/uOyI4fUQfdxEe75oTOB+OY4QJGdkP
X-Gm-Gg: AYBFou0BfDU8ctPpGnLu6LKYDA8FgdJucrquxzQ1zEdRb6LYE2JlrkY7PmJwbqMGQdp
	0sP0wgICq62/fPysC8v2vMT7Dh5cL2pt3NiFeDjcX0smHN/bc8GE8VBfQJvn1urGS8+YjYJusGD
	uHTVW2Mtm1DWuoO3fAduKhNV/ZsPm+sNP7TYZtlfB8D6gzLyrJJZjp3oOg7+Erbz9NV1jEqNsW0
	ecdENd7/Satzypxo5wC6TqhYiUX8Sjir3+zBK/OxmnjloHcE1CAA7NaXhYuQjCaQQRogwmoKQu2
	Kmayy0fMII3CrgukCroi2prMvEpJUbrPZGMQnKfS0ctgrEez/ZTYRJ/cPuFMQUeJaLZgy/+Ro97
	1KNyyZ9G6csGXwVz8hAE1xXxICoKpQ2wmL6YgNgs1hRNgiPXUXAIHJgUJTva5IdssDjewfdZqpo
	a1FTQJMVkeEEumFjLPhOxsZ+ZxeV2FGzs6VYynA0Xc459JYWvQTnIhGk4B/wgxS3ybC9XFFqBdM
	hlIAHHP2MUMsioXzjEYdCSfs6DSCy3dzxnvrrkTXbfmr105huZa/X8c/KDWU7HTagNAi1EsmQLF
	iC7PPs5160+OwYd3nvb96FBSoKC+t412dti6HMY=
X-Received: by 2002:a05:6102:f0e:b0:7cb:bda3:27ab with SMTP id ada2fe7eead31-7d64d6c64damr508660137.13.1794547537826;
        Thu, 12 Nov 2026 21:25:37 -0800 (PST)
Received: from [192.168.0.8] ([2a09:bac5:565c:aa::11:1e5])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-99c8425d142sm880439241.5.2026.11.12.21.25.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 21:25:36 -0800 (PST)
From: =?utf-8?q?Oscar_Alejandro_S=C3=A1nchez_Lucero?= <aleszlucero@gmail.com>
Subject: [PATCH 0/2] iio: fix kernel-doc warnings in public headers
Date: Thu, 12 Nov 2026 23:25:31 -0600
Message-Id: <20261112-iio-kernel-doc-v1-0-e382fc9a47c2@gmail.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MMQqAMAxA0auUzAZMkCJeRRxsjRqUVloQQXp3i
 +Mb/n8hS1LJMJgXktyaNYYKagz4fQ6boC7VwC1bImJUjXhICnLiEj32rXedFabVWajRlWTV5x+
 OUykf6XA612AAAAA=
X-Change-ID: 20261112-iio-kernel-doc-80cb46e21fb6
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Matti Vaittinen <mazziesaccount@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Oscar_Alejandro_S=C3=A1nchez_Lucero?= <aleszlucero@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794547535; l=1005;
 i=aleszlucero@gmail.com; s=20261104; h=from:subject:message-id;
 bh=EEdK5omgKBmJXs8GL9mTWLGJyllyZj125zUVxHBU0+s=;
 b=v8DmdEanPM5eRXLkQovWbiV5CIAgbSB3h1P2lBhaCeTIY0yTrnOo9JJnFS73REWTwK3Crl0ST
 +g8RSpar+UsDVA+93AMTmUotjwXugcMh/jFUf7IU8J3yJn9zUdbpbuH
X-Developer-Key: i=aleszlucero@gmail.com; a=ed25519;
 pk=zRzEBMID7l1FXqr2CjfnlIn++3m3N05FuNYb5zPA3cw=

Fix two kernel-doc warnings in public IIO headers:
- Rename @consumer_channel to @name in fwnode_iio_channel_get_by_name().
- Replace repeated 'NOTE:' labels in struct iio_itime_sel_mul to avoid
  a duplicate section name warning.

Tested with ./scripts/kernel-doc, ./scripts/checkpatch.pl --strict, and
W=1 builds of drivers/iio/inkern.o and drivers/iio/industrialio-gts-helper.o.

Signed-off-by: Oscar Alejandro Sánchez Lucero <aleszlucero@gmail.com>
---
Oscar Alejandro Sánchez Lucero (2):
      iio: consumers: fix kernel-doc parameter name in fwnode_iio_channel_get_by_name()
      iio: gts-helper: fix duplicate NOTE section in struct iio_itime_sel_mul

 include/linux/iio/consumer.h       | 2 +-
 include/linux/iio/iio-gts-helper.h | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)
---
base-commit: 9d66f26fefacebfeed15de31c1123451a17ff119
change-id: 20261112-iio-kernel-doc-80cb46e21fb6

Best regards,
-- 
Oscar Alejandro Sánchez Lucero <aleszlucero@gmail.com>

