Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E1F2EA754
	for <linux-iio@vger.kernel.org>; Sun, 12 Apr 2026 09:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775986704; cv=none; b=TJRazFP0um0Ii6YxERBHNfulK+wBLMK1m2aLItqjZKU/bmpDqv7cHGPAnHOtdIJK9VsS7GiXkbybt2vQP2j3VuLtkrMuUTn286Ow46yj6uHA9pLLvz9zM74nrybcdUI5uj+G+w3GWXLcJT4dIvGfxoXZqx9Yc3tYSpnAUVkBJYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775986704; c=relaxed/simple;
	bh=nBRBtUqIxqHQgzoWyQRujvp/pvAfKzrm++3kXZfgEiM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Yu2kOIKhDlUJKLORWtgSl2OcJty1Xkgikzrff0dOEUNesFHCHC6Oq3b0vBjN3AOTVw+QGJTuYoexWIxjRn85kwi5cyn9Kll330XlLgU/xbwnOChTb9LUJU65zoNuE+2A6g8b+9X0gK4wu86Uzm0sDGg8RQUGgCxUyCmxpwg02CY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lh0AsgZ/; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lh0AsgZ/"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-82cebbdab08so2729276b3a.2
        for <linux-iio@vger.kernel.org>; Sun, 12 Apr 2026 02:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775986703; x=1776591503; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K7EJe494qZFjCt/60vOmrTjUFRjvoNKSlUjaDCPjNfI=;
        b=lh0AsgZ/uVZsjJsogzJ08f3/+SBGyFG82H9L8m4LOn5psl33CuBCbWzfEbdC4JJ4Ti
         MveNmeFxnUrFm+hoLCGzlzdLy2zY6XjYEe7yiuyIe63/gWBvu2zIHS1nXrPlmy9ykNMg
         Knf6YIN8JxbHXWBGgIbRNIiwYWv316xGIqYVJenQVmHiYclqwqksd4wfT3RLtqSvV/Cx
         CuSN05Q+gJFKEFPz1w8Xa14ruydS0RHF6ydMeY/p349P6mOUeB0Ai8cgEKtTCZR7HQoP
         vU77vX9QBqQ9AfihC84IsjhW7SSb5NpeT1kV4xaoQe4GeBBrkwGKBlsFdymVbogeoB94
         ymzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775986703; x=1776591503;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=K7EJe494qZFjCt/60vOmrTjUFRjvoNKSlUjaDCPjNfI=;
        b=UfkS9fzj4Mw7PhYI9S8oECCEKWWgd3bnuSvmuCCicrZSSmKsV1J+Evcv4GcHY5AWSZ
         nF2bXzjSoS1TFwx925V/aNz337RYpQqrW42pD5jGYFZYrBp2nJQdC0FMk5suFBHEkXXS
         BJgtxmzf0UNCfJD+l1IZWPIrzvXSGbc+yAaB2zcdrrhs4M0jWttxvwM3GbypmtZau962
         yduOTETcj85QA5VJighlQU3Tnf85zREU4GH4o6O784A4fL7oxLtmoc6kraPABqTMiTXy
         0bf9Y47Q0zrNIS8ZQap4uq5ojfz16D0VavjM8XIdjOzA6dmel+EPvoyYAlj9P8noNyCV
         qubg==
X-Forwarded-Encrypted: i=1; AJvYcCXx9hxCocLHIMcgzK+TT36pI2W/1DmFXzrTqm5wCfA0BoWj/Vs5Nj5dMO2HljuI5NY3d2famx21AwQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyi02ofFMVBW0RWHi554DYR4azJ0RjdEUZ1MznWY97bdgakZTr/
	lEyDAikxzUkkOagb6e9dYCmldddClVA1PdL/T/JhLSJvEskB1io9CLEA
X-Gm-Gg: AeBDiesNMfKy+riOyAcr0abxqBqSTVmPyEyjzDPH5bV/5qNQiRnrLPhEzaQQJ2LM68M
	r5TcbRKwK2/NMuCsiRu9j28/8Q0mi0DqbJE7pwha71FWmkJI74E18jB73nByqnga9Q2hgrM+tNO
	D/TEx5EQQkrJScaFEi2Wvaixtc52je0CnZIEEO4GUFNRBgEi9iWA56LMtBCZx/GTFwzfLw+Q+8z
	I0no8vDIhVpttW/JVTUG+kVozQQG5ulW52E2YrjdU3DN0zrmBGbnXiK4nyZpisbN3iJkn0FCuFr
	2pujJdIL4oFjsDE+jJ8Tf3/j9xv3LOIMBCO4VPQb2G7zKmzjyeQemqhzRksnbxVAwk0R68lUcAf
	decu+hFvS6+v0EVDQ9anIHMKY9YXChGXArRhjzKCwYL9+C9lhTgzO5zxneUuO3e/LTRHJWS6oQF
	OJ0t8EpdKZzyDBYujUWbV25jlrIsEiwI1/Ze2DSpB6Cl35KMcLCw5f2yJ4MQz9CQKSGgXCNYQPc
	N/R/Lz7xkg=
X-Received: by 2002:a05:6a00:1305:b0:82f:b5:8044 with SMTP id d2e1a72fcca58-82f0c1e261amr10289351b3a.6.1775986702850;
        Sun, 12 Apr 2026 02:38:22 -0700 (PDT)
Received: from debian.ari ([152.56.156.42])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f0c36130csm7885038b3a.24.2026.04.12.02.38.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Apr 2026 02:38:22 -0700 (PDT)
From: Archit Anant <architanant5@gmail.com>
To: jic23@kernel.org,
	dlechner@baylibre.com
Cc: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Archit Anant <architanant5@gmail.com>
Subject: [PATCH v8 4/5] iio: adc: ad799x: cache regulator voltages during probe
Date: Sun, 12 Apr 2026 15:07:38 +0530
Message-Id: <20260412093739.17116-5-architanant5@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260412093739.17116-1-architanant5@gmail.com>
References: <20260412093739.17116-1-architanant5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since the reference voltage for this ADC is not expected to
change at runtime, determine the active reference voltage (either VREF
or VCC) during probe() and cache it in a single variable in the state
structure.

Suggested-by: Jonathan Cameron <jic23@kernel.org>
Suggested-by: David Lechner <dlechner@baylibre.com>
Reviewed-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Archit Anant <architanant5@gmail.com>
---
 drivers/iio/adc/ad799x.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/adc/ad799x.c b/drivers/iio/adc/ad799x.c
index d8389b6e19b5..e37bb64edd2b 100644
--- a/drivers/iio/adc/ad799x.c
+++ b/drivers/iio/adc/ad799x.c
@@ -30,6 +30,7 @@
 #include <linux/slab.h>
 #include <linux/sysfs.h>
 #include <linux/types.h>
+#include <linux/units.h>
 
 #include <linux/iio/buffer.h>
 #include <linux/iio/events.h>
@@ -135,6 +136,9 @@ struct ad799x_state {
 	u16				config;
 
 	unsigned int			transfer_size;
+
+	int				vref_uV;
+
 	IIO_DECLARE_BUFFER_WITH_TS(__be16, rx_buf, AD799X_MAX_CHANNELS);
 };
 
@@ -303,14 +307,7 @@ static int ad799x_read_raw(struct iio_dev *indio_dev,
 			GENMASK(chan->scan_type.realbits - 1, 0);
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
-		if (st->vref)
-			ret = regulator_get_voltage(st->vref);
-		else
-			ret = regulator_get_voltage(st->reg);
-
-		if (ret < 0)
-			return ret;
-		*val = ret / 1000;
+		*val = st->vref_uV / (MICRO / MILLI);
 		*val2 = chan->scan_type.realbits;
 		return IIO_VAL_FRACTIONAL_LOG2;
 	}
@@ -829,9 +826,20 @@ static int ad799x_probe(struct i2c_client *client)
 			ret = regulator_enable(st->vref);
 			if (ret)
 				goto error_disable_reg;
+			ret = regulator_get_voltage(st->vref);
+			if (ret < 0)
+				goto error_disable_vref;
+			st->vref_uV = ret;
 		}
 	}
 
+	if (!st->vref) {
+		ret = regulator_get_voltage(st->reg);
+		if (ret < 0)
+			goto error_disable_reg;
+		st->vref_uV = ret;
+	}
+
 	st->client = client;
 
 	indio_dev->name = id->name;
-- 
2.39.5

