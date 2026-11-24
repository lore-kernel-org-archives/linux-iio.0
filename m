Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795503022;
	b=j1E3TB3t3xfRYexVBpwbrF6oLIyTBdUmca8bxT/8zQxrDQOz7/eL7zFwWGmy+CKdVMXm
	 GgUrIUjK9rvkk6vZ9GBhp7E2qhpexMUnZkdAbZrXIBkiyDUrqRqLxm6mGbujVKeotPwan
	 Tag8i6scqDGCxqS/RAXbtU+lqxZ2gdCMAuQFOhC/WbEKTH8KiMPnm0VWsoGu9uur1sxVb
	 LarEmMjLLpR9r1VrTVi/O4bi5a/soSrSTCK8mn8w8GgxZ25JQZNiGCHXSQDs8FIp3rFSP
	 ADVOMPY62rFFCCTbp1Rr5EAyRwntCms0pqwkpqTiPeawTAL5le8ByyHJYGHOBCcfc4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795503022;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=feSDKfXb4X0Cc0WCkXLJBrlF54Mp6pt66emQvGVPBQA=;
	b=JlTy50q9KicVGLLpIR0jOF0J1xXkYsMmtL7wUJW2wSwHVWu5zQtJM1jqeBAqbpn1FNY3
	 K0Kwcym9xF3n81K71xty43TiYHc0q8PMZboB3xHh9TrBYq4+Lvp2NpO59t87VRKfVeK92
	 zN4Pbc0nj9Jxml7K/NmqtRD8F2oLi59N/ECQxLfGB0wl294FCHCpV5nE/KMKJNbvgknyC
	 DPrVlGTKvS6dvc+xJUSp0+eOBis0hOJnzaM666If8+HTEr3RjvJXXJTv6U9ijpkNaY87O
	 FqLYD5XOOz+4mPBZ7U/WeGk+ZJ/pSJ+TT56T+9VaPwB/0xbQ5F5MloEIjuEGeu9SUPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ig3BjHTB;
	arc=none smtp.remote-ip=209.85.167.42
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B13B606A32D
	for <linux-iio@vger.kernel.org>; Tue, 24 Nov 2026 06:50:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5B13B606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ig3BjHTB
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5bcdae234ecso5680179e87.3
        for <linux-iio@vger.kernel.org>; Mon, 23 Nov 2026 22:50:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795503020; x=1796107820; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=feSDKfXb4X0Cc0WCkXLJBrlF54Mp6pt66emQvGVPBQA=;
        b=Ig3BjHTBdtYBH6XVlNiNPlmJdR0UL7uoCWxTIuClZ3Yss2MI3TvUKNxoDyXHxtS1+k
         g200IJSVV1vxF/1yZIxAZqppvQ9QmsErlWSiiA+tw4EpXQRi284tqreJGq4VngV8YRBS
         6ae+/s6d2SdqTEOSQWo8f1XiN9SixRwf+3Ef1pSpU7I1RfPrx9HDI/1aFBB0OcWQI25B
         6gJrthtiaQm5NS4kCAC8qLQs7rHUdmAmIgRwVcgs7SMPKmXsuePYMtQTs2M4rU2LWMQ8
         cdbhF/a4IbWl4snzBEFR+6qEGtS+ZNhpBYEijqMpvZbo3exEgXKgkqaNict30vFHFi0o
         1DUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795503020; x=1796107820;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=feSDKfXb4X0Cc0WCkXLJBrlF54Mp6pt66emQvGVPBQA=;
        b=IsP39hjFYhu8w2pFjBbfDSAgi7Nmec5Ii74LnxVU/jEnR00tGnOtZQTfcC0gprkDU0
         HatKjp7gl72DrLIgdxK+ozP+RfQNHhsq3LBtkYow5A7kGtZE1ldq21Vf70meL3iktYct
         CIYWvogW2KA+SzarwP2v/Apkn3+mtNfDkugVBqX9wOkpHX5/AE8K0jmYtS3z6dlI+5hn
         oeyO/LuUgZASV5hlwJprGwHESLtmaXrMJaZud+6Os8zIWp+Rn67f9yGbr4mihPL0dSir
         YeIjCLJflrScxw4u58WFhIcX8/1mGARcWai8/RRirpfT+t5fJRw9P5p/GI2n9JRkwATW
         Lz9Q==
X-Forwarded-Encrypted: i=1; AL+hErEaxojZlkWaysBh5mJbRnFLOwr1iToxPFaOu/KIy6CUXRDsHYSYNRqEeO0A/7KHTazbXrYAtB6VUrc=@vger.kernel.org
X-Gm-Message-State: APuU4Z/ofG6w1tcLGd2Ihm6sBFcZyDnCwY0sXrARIbBFGLFN0B7WG3j+
	OyTr/Ukf3CmjTG0Zt5q+Kn7RusaXZHrAVow/A0Us3iF2O1Zj05uejo1Y
X-Gm-Gg: AZFdTZdUveziIrOeOjSW2K+rnKjkDsdjPfD/nHmDzy0Gq12h4uRQiD8Wydz9rp1rcR3
	ucC0fyxk4X3oKLAaNMrWCdv8G6dGP696k17BclKpl8hmc6Vsr3YoVvL6kNg4KuuulzRAredqO9U
	ReAJLzU0dNOGOKVgrSj01Rn1bEu/D0IbAlxvl9pc9i6hyy1Vu1E7i4QQSFHb6Wmv0WdWwMis3G1
	Cn33lsS3ZxG7YUdupCdILVaNtKFOy/kulyFScM5DKnPZJGZO4yWxUW2a4ut3g7gkEdUL3IlKWkB
	sRSFpR0o+0d6sU3VpF8qCV5I6wlwNCUQmVFlie8sB2RubGLR5h9P4RwehOMasZGsFxOcQr1mTYB
	NN8CSka6zkFEJN3XJTaP49cM7MQPgP4tRfKNhjhqmBcmzuNu49qJn/zxabcndNPJTgPM+Ie9ypL
	5e/P66os/s1ceqHsNfHqz+EJjesQEdz0bTPBYNChGXTfo3ZqbinZmtG1szdwWpyDIXwCrHniRZ/
	Z3tlEOE8IZIZjRC0F8LzAp4o5yPMYFNm/b3Ao+ujtiHVtVBJr3Z6D4ETuFIvGSquoBUHZPr1FrA
	5NTrxgaBA7D+NSxKjbH4k/UfVj/UtKlIKmPTQJmk4r1vIQN3y3XRRPAAYHHV+wSyixmqmRLXbdC
	cL6i8qA2H/MEkZsu1M5nEeJvx+HdD3CySoEkpDg==
X-Received: by 2002:a05:6512:1591:b0:5bf:e43d:999 with SMTP id 2adb3069b0e04-5c1bc8057e0mr4229386e87.42.1795503020353;
        Mon, 23 Nov 2026 22:50:20 -0800 (PST)
Received: from yantra.. (nekmmqsyyquzw1lm5eb-1.v6.elisa-laajakaista.fi. [2001:99a:d7d:c300:3cd2:d52a:a1ef:5dd3])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5c1bd018b45sm3538556e87.41.2026.11.23.22.50.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 22:50:19 -0800 (PST)
From: Rupesh Majhi <zoone.rupert@gmail.com>
To: Andy Shevchenko <andy@kernel.org>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Eddie James <eajames@linux.ibm.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lucas Stankus <lucas.p.stankus@gmail.com>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Petre Rodan <petre.rodan@subdimension.ro>
Cc: linux@analog.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rupesh Majhi <zoone.rupert@gmail.com>
Subject: [PATCH 1/6] iio: core: add iio_debugfs_reg_access_regmap()
Date: Tue, 24 Nov 2026 08:50:11 +0200
Message-ID: <20261124065016.185124-2-zoone.rupert@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261124065016.185124-1-zoone.rupert@gmail.com>
References: <20261124065016.185124-1-zoone.rupert@gmail.com>
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

More than 25 drivers implement debugfs_reg_access with only a
regmap_read() or regmap_write() on the regmap of the parent device.
Add a helper that looks that regmap up with dev_get_regmap(), so these
drivers can drop their own copy.

Signed-off-by: Rupesh Majhi <zoone.rupert@gmail.com>
---
 drivers/iio/industrialio-core.c | 28 ++++++++++++++++++++++++++++
 include/linux/iio/iio.h         |  2 ++
 2 files changed, 30 insertions(+)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index dabd57a0994e..e658687d978f 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -28,6 +28,7 @@
 #include <linux/overflow.h>
 #include <linux/poll.h>
 #include <linux/property.h>
+#include <linux/regmap.h>
 #include <linux/sched.h>
 #include <linux/seq_buf.h>
 #include <linux/slab.h>
@@ -446,6 +447,33 @@ static void __exit iio_exit(void)
 	debugfs_remove(iio_debugfs_dentry);
 }
 
+/**
+ * iio_debugfs_reg_access_regmap() - debugfs register access through regmap
+ * @indio_dev: IIO device
+ * @reg: register address
+ * @writeval: value to write when @readval is NULL
+ * @readval: where to store the value read, or NULL for a write
+ *
+ * For &iio_info.debugfs_reg_access when the parent device has one regmap.
+ *
+ * Returns: 0 on success, -ENODEV if the parent has no regmap, or the error
+ * from regmap.
+ */
+int iio_debugfs_reg_access_regmap(struct iio_dev *indio_dev, unsigned int reg,
+				  unsigned int writeval, unsigned int *readval)
+{
+	struct regmap *map = dev_get_regmap(indio_dev->dev.parent, NULL);
+
+	if (!map)
+		return -ENODEV;
+
+	if (readval)
+		return regmap_read(map, reg, readval);
+
+	return regmap_write(map, reg, writeval);
+}
+EXPORT_SYMBOL_GPL(iio_debugfs_reg_access_regmap);
+
 #if defined(CONFIG_DEBUG_FS)
 static ssize_t iio_debugfs_read_reg(struct file *file, char __user *userbuf,
 			      size_t count, loff_t *ppos)
diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index 8b3fd7673293..8407e6e4620a 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -677,6 +677,8 @@ struct iio_dev {
 
 int iio_device_id(struct iio_dev *indio_dev);
 int iio_device_get_current_mode(struct iio_dev *indio_dev);
+int iio_debugfs_reg_access_regmap(struct iio_dev *indio_dev, unsigned int reg,
+				  unsigned int writeval, unsigned int *readval);
 bool iio_buffer_enabled(struct iio_dev *indio_dev);
 
 const struct iio_chan_spec
-- 
2.43.0

