Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795695227;
	b=ed5LsWd66kzTL9+R4z7wgb2YNDTN9GvzwmF4li7301sBQZF4MG/5I5Rr9wFKldbEjuKn
	 aG+xHjxa3Hhsjlm7kyDkBmXSq9YApNWBAtb/TKGP7n6DW/WIBQ1WwqbMqv7qigbsgZ6yV
	 NrLARILuVrMr9a+cCLmJyb3ddQhPETJ1n3NkYiBHf5hd8wSVEUrd1YLXnA0/z8bNSA9Oh
	 im6EcmILNvU0G2TKpL0sIkw6Oo9NJUGM/ot0zsOq1uO0sLjQE2cCEmUUpgZYO3krSRsHk
	 gKneLOCwDoAkCKWb/cYRHM2iKtRenq7bPNeiYhazjEgNDYQCEr8ug1FWlTmzpDZGwSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795695227;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=D8Hl+ZArBMHl5ZMBuXt18rLKsISWNonXQJoD4xB5WWk=;
	b=4YzUh5/1fp4Ak7tPGL23PNgpd1BdjKgrLnfwWGTGrDgT5vW10/8eC3EdeizstPrwpXOR
	 PDyUq6vahbFWBOzvS8tvqMRHobQoAmlyj72pDQoVTdlertfkc1N30VIY6lyAyF1qOg3HB
	 a9CsL2ZHN1ZliZR+uOCQIQgjQFLxuHllxzKJFw03uKLQUe7vZVXu/pabCEMPY4KSGwuxt
	 7i3K1Pne4uDfzMgVL6aYTP83BJkUFYfJ5FnkKQdI1W4+8RH9mPnbkMIjUdsha6bx/3gvQ
	 zSPRmEXGVoSlrQEcrwiVujdTej8pKZ1JDxYweZCP1ZuFo2hGsk4dwkgH/uq3prxMaCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0dbZRonn;
	arc=none smtp.remote-ip=209.85.208.179
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63DD5606A33D
	for <linux-iio@vger.kernel.org>; Thu, 26 Nov 2026 12:13:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 63DD5606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0dbZRonn
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-3ab4354db11so68444711fa.1
        for <linux-iio@vger.kernel.org>; Thu, 26 Nov 2026 04:13:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795695225; x=1796300025; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=D8Hl+ZArBMHl5ZMBuXt18rLKsISWNonXQJoD4xB5WWk=;
        b=0dbZRonn2vtZEp8dpn687vWKKWl/p9+l/gLUQQ6AI8/C/06FwxEo+x2JxOOWDLeCSD
         eKq0mVr5bYdSdjVRjx2PRzn0k9/PuTOLspjr9m0cLO86Q+/0FY8IKy6b4EQ2JzkCTvSV
         wLhGpuqsIVrAlgQVsXZwM0z407UfyeaAeOlNIs6oqIJ4GGIWlEXsI+qX2IpM33bs8Syf
         j1pJcebOrGuuFsblz/84xrzI473CobGuD8tXsw6w485ASJ3mzl1fLz9pnKnDXnmbvr8+
         o8CnUth/KemgSZkRrXzLcFlv+d20jdpO3H5Nuwtj4+IHRVFkDf1i2OdqrvvvQyGZpWWL
         RO/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795695225; x=1796300025;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=D8Hl+ZArBMHl5ZMBuXt18rLKsISWNonXQJoD4xB5WWk=;
        b=p1NpcOsXlYBd3ptK/QAcmS221jm85jpJeit7s08DGDLZ7xL9wmDVKDXVfZflt4XWH3
         xhcE65gHbYpZ4djXZXSOyyPnoWfIgV/EcajIIhJcWxpQFqKIIHIhNPg3esSPmEkMFQU3
         1bfWAXVBLYokVbV7vKKiu4154MSKhroG5OV5zMa0q0s+3bFp9a4HUg6Y99TF3EBbOSIZ
         k/TtNC4zzHVbwnzHEAA8p17+wGsZ+OJ7cUCqYCaT5U6xSXDP0hbzOSvGhJ0DdbPnn63e
         L1LdR2la9bMyQOMQQldaADG9VH0QUMrMHFJcqRrL7Ivj0dZVV6j2dCsLGdHSfKVp+Yp6
         Kfqg==
X-Gm-Message-State: APuU4Z/nbxra0o3drNz15KqYRSt2eXiZ1JOJ3/24wYySxHlFK5XjS0YU
	Att247h/Y8h/pw3DynuOu3OoZoAXsUAvvdsty3j8aaGPlrIjZ9De+1uf
X-Gm-Gg: AZFdTZf2AFikbmHCP0IDWBpG1UzWAH82gh5mDhdYlJmAD3vcGr5T1xg62DAvb2G2YVn
	XULM+VZT7NRNmZ8ph5ZjXmL0fHYYBbNcufqTMQhQe5JXOvbVXxx026I9D3P3K5rCh07qmNWMV/J
	SqxO0yuNiXh9vTbAgmaJgdSMqArATHKgeKrshTYFdaLGgtkFDvt+C7gwf2FXdrI5pndhnJdCPdx
	GA5/WCE/uy6my+dpWJrZq1qw0Vh+2AyDedRQiqdSImCa4X4xWUyMF2lrFRt9l57RJECbubI7pNo
	8fkiksfQyJajhjZ0kYhV6Iqr1assBcjN+8trMWRIO//yTs1v64umxkw63CKmr9jS9Q3yqIYOL+P
	5q4tHzNrrszwT7DSIUbkPDXzFPj0MdNhvHe6jpjZ2J93pktsnQ/p/sFPJSAMowSp3erwkXaNhfr
	pIzcebs2TkpX1pM//FsuUh6AksljGSjZmmKO2NJe7FlU4foNyd6d6187wsrwHpEul9O+zfhdlJU
	fCthFgioBCMYgGDb4iCZtuyDL/NVP6goQif5yXpcICFF6ML+ADudGkHx2y+mqigit/kKg3jhK2g
	lVtnnWIrV5+hF4AM4n15Eg0KDFeqolRJdS+vk3ruMqYf/W1451KnIL1NLrDxs15bjZ9xkfa6CWH
	OCVoPlgdZ7fjdHq3Pai0L+tWDT4P+vhREN8u7
X-Received: by 2002:a2e:8a94:0:b0:3a9:d9db:61b0 with SMTP id 38308e7fff4ca-3ae7fa718c7mr56022941fa.24.1795695225369;
        Thu, 26 Nov 2026 04:13:45 -0800 (PST)
Received: from yantra.. (nekmmqtmzjx8yvukhae-1.v6.elisa-laajakaista.fi. [2001:99a:d7d:c300:68b4:f70:61d8:6e86])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3ae8044e8e0sm56541791fa.5.2026.11.26.04.13.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 04:13:45 -0800 (PST)
From: Rupesh Majhi <zoone.rupert@gmail.com>
To: Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Eddie James <eajames@linux.ibm.com>,
	Jonathan Cameron <jic23@kernel.org>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rupesh Majhi <zoone.rupert@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: [PATCH v2 4/7] iio: pressure: dps310: use KILO for the Pa to kPa conversion
Date: Thu, 26 Nov 2026 14:13:27 +0200
Message-ID: <20261126121331.10438-5-zoone.rupert@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261126121331.10438-1-zoone.rupert@gmail.com>
References: <20261126121331.10438-1-zoone.rupert@gmail.com>
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

Spell the Pa to kPa divisor as KILO from units.h, in both places.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Rupesh Majhi <zoone.rupert@gmail.com>
---
 drivers/iio/pressure/dps310.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/pressure/dps310.c b/drivers/iio/pressure/dps310.c
index 493eb56bde98..f802c2c59072 100644
--- a/drivers/iio/pressure/dps310.c
+++ b/drivers/iio/pressure/dps310.c
@@ -33,6 +33,7 @@
 #include <linux/slab.h>
 #include <linux/time.h>
 #include <linux/unaligned.h>
+#include <linux/units.h>
 #include <linux/workqueue.h>
 
 #include <linux/iio/buffer.h>
@@ -895,13 +896,13 @@ static int dps310_read_pressure(struct dps310_data *data, int *val, int *val2,
 		if (rc)
 			return rc;
 
-		*val2 = 1000; /* Convert Pa to KPa per IIO ABI */
+		*val2 = KILO; /* Convert Pa to KPa per IIO ABI */
 		return IIO_VAL_FRACTIONAL;
 
 	case IIO_CHAN_INFO_SCALE:
 		/* The raw value is in Pa, the ABI wants kPa */
 		*val = 1;
-		*val2 = 1000;
+		*val2 = KILO;
 		return IIO_VAL_FRACTIONAL;
 
 	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
-- 
2.43.0

