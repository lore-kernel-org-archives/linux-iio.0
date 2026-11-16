Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794793733;
	b=dSkL3oyjEWAI6Lhibi4tarXBfugo5GrzJH6KF7lXLuTwv3ngOZWlTLwHlhleCSXvQbEH
	 Mlcr+KH6ClpRncjGMgBiMxRd9nueLiv54WgDx6uiG9xTpBdelyu6BMLdF5RRvT2IPQQij
	 ddo05NmtsXZX+ySA99nYWdVXE0s/jsfNFZGt5h19t/UI5olMHZWn/IdAcu1Pr3OExTWzo
	 nlDk3pi8av56cIVlfjIgDzXi0IKPB6ptGZzdreC15FwYnebSzVXdecvLMcIlyVB/3IuQa
	 n2kjyYpZcewqwdYzR2Su0DtPx9iJGUHWSrMXWlVvqYVzXtep47N4TOHDPg0ax8aLYqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794793733;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=tp3wQadL3Gn2RoJEuSW9xzPxfsOsX8PEn9E9rJ60UzA=;
	b=lXd/izCh/UaT1ssYjyCvXng18sy3Tin1nZiNlbCj+pjj51IYy36mxRmf7/dIiA9ZXcZA
	 yeSdtmJ5tfqG27zHUnFflqFsO4L84JPwf7l4RclIbzPumpfrxA+YXIivxTqnuAa+JJOnD
	 wV7K5lBCIgezjKFTexCzA9dLrgWwj+y8bHLdbK7uM4M0cRNL/OqFWCOqpQj+lxzVE/8Wc
	 EM/Ad6rAKEsFNfjPSjE8dRiq9m66HsHSuyG4GtJqeE/q8EIGROnZd1t0pDcGLxkGti/yW
	 xLPFk+8CQ+r38X6mMDYwVJLarY9Jkx6p+R9rcVBip6s8Mjt6BDpPPfkuCMSbnCC7cUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PAPBCWb3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 416D1606A329;
	Mon, 16 Nov 2026 01:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PAPBCWb3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D52DE1F000C5;
	Mon, 16 Nov 2026 01:48:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794793732;
	bh=tp3wQadL3Gn2RoJEuSW9xzPxfsOsX8PEn9E9rJ60UzA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PAPBCWb3H6AWeemU2R8JOJ7TcRqeqXbYEfYC6wR1rqm+uYI2N6nL8DvectYmHDArW
	 nRjrNmtSBOEUD7ORWaW1tXFHiE3blbPNiIu7kWI3MlFS4FIod5OXyQpUudDtJPxYtA
	 Nh4PW8aBG1F9qm0xs05D+meuW+0llR06IekQEEMPb8gkhIToJzQFmE1KTwo1ynLNxX
	 4w2PHbYFMKyjgzgr5ucdbqTF7xm3XCC394sg58i5DMLERodLjtZB66BvKP1iwfs5hR
	 lIQ+ZfKFkcGLrZrYUj8HJBpxSlvz2ezE/LiygxjGvsMy5rRq/MTibTq7swYg2Uia9K
	 eaLc6g0Tlgvlw==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Martin Tuma <martin.tuma@digiteqautomotive.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-media@vger.kernel.org,
	Gustavo Silva <gustavograzs@gmail.com>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Ramona Alexandra Nechita <ramona.nechita@analog.com>,
	Tomislav Denis <tomislav.denis@avl.com>,
	Jorge Marques <jorge.marques@analog.com>,
	Petre Rodan <petre.rodan@subdimension.ro>,
	Dan Robertson <dan@dlrobertson.com>,
	Jianping Shen <Jianping.Shen@de.bosch.com>,
	Gwendal Grignou <gwendal@chromium.org>,
	Maxwell Doose <maxwell@maxwelld.cc>,
	Tomasz Duszynski <tduszyns@gmail.com>,
	Esben Haabendal <esben@geanix.com>,
	Narcisa Ana Maria Vasile <narcisaanamaria12@gmail.com>,
	Jiri Kosina <jikos@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Vasileios Amoiridis <vassilisamir@gmail.com>,
	Abhash Jha <abhashkumarjha123@gmail.com>,
	Puranjay Mohan <puranjay@kernel.org>,
	Nishant Malpani <nish.malpani25@gmail.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Linus Walleij <linusw@kernel.org>,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Subject: [PATCH 01/35] iio: core: add default_trigger and take reference in iio_device_register()
Date: Mon, 16 Nov 2026 01:47:49 +0000
Message-ID: <20261116014823.3132576-2-jic23@kernel.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261116014823.3132576-1-jic23@kernel.org>
References: <20261116014823.3132576-1-jic23@kernel.org>
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

From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

Some drivers choose to set a default trigger in probe() via
indio_dev->trig = iio_trigger_get(trig). The matching iio_trigger_put()
is in iio_device_unregister_trigger_consumer(), called from
iio_dev_release() only if indio_dev->modes includes one of the triggered
modes. If probe() fails after the reference is taken but before
INDIO_BUFFER_TRIGGERED is set (e.g. by iio_triggered_buffer_setup()),
the reference is leaked. In devm managed flows there is no simple way
for the driver to drop the reference on error.  Whilst it is possible
to have enforce strict registration order so that the reference is
only taken once conditions for tear down are met, the requirements are
not intuitive. So move the point of reference acquire later in sequence
to a point where cleanup will always happen.

Add struct iio_dev::default_trigger. Drivers then set this without taking
a reference. The reference is instead taken in
iio_device_register_trigger_consumer(), which pairs with the existing put
under the same modes check, so they always balance.

Also check the return value of iio_device_register_trigger_consumer(),
add an error_unreg_trigger_consumer unwind path for failures that occur
later in registration, and clear indio_dev->trig after the put so the
subsequent call from iio_dev_release() does not drop it again.

Immutable triggers are a little more complex and left for a follow
on patch.

Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
---
 drivers/iio/industrialio-core.c    | 15 ++++++++++++---
 drivers/iio/industrialio-trigger.c | 21 ++++++++++++++++++---
 include/linux/iio/iio.h            |  4 ++++
 3 files changed, 34 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index ed7aa7fd9391..6c704920d619 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -2180,8 +2180,14 @@ int __iio_device_register(struct iio_dev *indio_dev, struct module *this_mod)
 			"Failed to register event set\n");
 		goto error_free_sysfs;
 	}
-	if (indio_dev->modes & INDIO_ALL_TRIGGERED_MODES)
-		iio_device_register_trigger_consumer(indio_dev);
+	if (indio_dev->modes & INDIO_ALL_TRIGGERED_MODES) {
+		ret = iio_device_register_trigger_consumer(indio_dev);
+		if (ret) {
+			dev_err(indio_dev->dev.parent,
+				"Failed to register trigger consumer\n");
+			goto error_unreg_eventset;
+		}
+	}
 
 	if ((indio_dev->modes & INDIO_ALL_BUFFER_MODES) &&
 		indio_dev->setup_ops == NULL)
@@ -2202,10 +2208,13 @@ int __iio_device_register(struct iio_dev *indio_dev, struct module *this_mod)
 
 	ret = cdev_device_add(&iio_dev_opaque->chrdev, &indio_dev->dev);
 	if (ret < 0)
-		goto error_unreg_eventset;
+		goto error_unreg_trigger_consumer;
 
 	return 0;
 
+error_unreg_trigger_consumer:
+	if (indio_dev->modes & INDIO_ALL_TRIGGERED_MODES)
+		iio_device_unregister_trigger_consumer(indio_dev);
 error_unreg_eventset:
 	iio_device_unregister_eventset(indio_dev);
 error_free_sysfs:
diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industrialio-trigger.c
index 76926fee0f84..a0149a5d0163 100644
--- a/drivers/iio/industrialio-trigger.c
+++ b/drivers/iio/industrialio-trigger.c
@@ -760,15 +760,30 @@ EXPORT_SYMBOL(iio_trigger_validate_own_device);
 
 int iio_device_register_trigger_consumer(struct iio_dev *indio_dev)
 {
-	return iio_device_register_sysfs_group(indio_dev,
-					       &iio_trigger_consumer_attr_group);
+	int ret;
+
+	/* Drivers must not both set a default trigger and take a reference */
+	if (indio_dev->default_trigger && WARN_ON(indio_dev->trig))
+		return -EINVAL;
+
+	ret = iio_device_register_sysfs_group(indio_dev,
+					      &iio_trigger_consumer_attr_group);
+	if (ret)
+		return ret;
+
+	if (indio_dev->default_trigger)
+		indio_dev->trig = iio_trigger_get(indio_dev->default_trigger);
+
+	return 0;
 }
 
 void iio_device_unregister_trigger_consumer(struct iio_dev *indio_dev)
 {
 	/* Clean up an associated but not attached trigger reference */
-	if (indio_dev->trig)
+	if (indio_dev->trig) {
 		iio_trigger_put(indio_dev->trig);
+		indio_dev->trig = NULL;
+	}
 }
 
 int iio_device_suspend_triggering(struct iio_dev *indio_dev)
diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index 67718f3b9b7d..8b3fd7673293 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -632,6 +632,9 @@ struct iio_buffer_setup_ops {
  * @active_scan_mask:	[INTERN] union of all scan masks requested by buffers
  * @scan_timestamp:	[INTERN] set if any buffers have requested timestamp
  * @trig:		[INTERN] current device trigger (buffer modes)
+ * @default_trigger:	[DRIVER] optional trigger to use by default. The driver
+ *			does not hold a reference to it; the IIO core takes
+ *			one in iio_device_register().
  * @pollfunc:		[DRIVER] function run on trigger being received
  * @pollfunc_event:	[DRIVER] function run on events trigger being received
  * @channels:		[DRIVER] channel specification structure table
@@ -657,6 +660,7 @@ struct iio_dev {
 	const unsigned long		*active_scan_mask;
 	bool				__private scan_timestamp;
 	struct iio_trigger		*trig;
+	struct iio_trigger		*default_trigger;
 	struct iio_poll_func		*pollfunc;
 	struct iio_poll_func		*pollfunc_event;
 
-- 
2.56.1

