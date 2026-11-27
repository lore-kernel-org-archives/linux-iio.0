Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795772887;
	b=rgMfwzvuAaijSs9tVQPg7bOPSg28NdhUrCb2mqbmVtnVeXCipXx0JP06BZV6H6sdGyPm
	 dgHwWDs8ee7Cu+wMjyIfpobws0iW+aSV6ZZx5cMGdDRHUzxaP1VnSiFQHEZS6ea1hEzRb
	 DRTvwWeUX1WMKp7z3aw95lyQBsyTvsR6CS7CSrJzSrx4HGrYp+wGIL4yaPvzr1KpaBgmH
	 ztnAVsxCmHWmW+dvJg4wuPZk53XQyrlBW5Wnd2FelN9Zbxpnzb0mLUbqMmhRbOmoi6Cr8
	 cQgYv3oqQQUsJZIL7jjV/IMf+yMNI7YvBvleR6U040OZYSU1ROKETYgzC1qxU2ztHwA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795772887;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=t3mPvJqSE7LXHOFUTmX0cyml/DTyX3mUI2pndg6S5bQ=;
	b=z+HnY+lgCMCOwGW6KS7YuWjSYnsKiOku9tzrskVEV70VvLSMprsW/HR9TH72ZpfUN7dr
	 nVuAjKYoFy0AuHZxtzbwJuBG4KTvsHwPWWLgYeplJwI/A3YlEf5vTURsd9FwaXI+IMoDf
	 doy9HMgoQ4mhnGxd5YQLgu3uZfKpx8S5flJHL2LjqGneYh5wH9sZIEtDbVgz8fEAgmBZq
	 vvfg+KJmFzZdGODmTXX3kcLXD4U8AiNAbEy+1Sb9hKKHwQ4FTaFOMQK86FcMxIj1v3YSt
	 Elh8ivpS5+SGVIl2GTcdb5TnPyEWeon35FtfMsaPkp/d5nbtHb7MwM6m+6k977nnaxQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CR0B2HWU;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A36F606A337;
	Fri, 27 Nov 2026 09:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CR0B2HWU
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795772886;
	b=hv+2qpCZJVGwwsS1SWxRnlZTudznkQAhy+8+gaZ4GPn9HGasQMuw6NSDErzUzP6F1m7v
	 1dK+xPPAEcRklB2UVEhwV0ATp1HrgKQ/MJem4JVmnQ7kJZuwReuXgPlGEnEBuQeh+ptUD
	 kxqBu2aDUfKNwpFHrWOvGDwWIB9ueUYm0nViXIHDEhibVcmf7x2M2f5s6WZhIC3h1Y7ia
	 eEn9A284g1LIa4z9/6USmTbVXS46KQkoatqs1e7YqIverLjtyJtoVOAkXv5AOq31ijXVz
	 toANohwl8PZDyK7HwQAhj/wkwKTUZ5vGGyFzbpXBeTY+3AZ9Qf0rR9zsvDKqQgC+O/g==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795772886;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=t3mPvJqSE7LXHOFUTmX0cyml/DTyX3mUI2pndg6S5bQ=;
	b=yCzgx9EW2J1oUCFfRPeP1Ul0DNVt9cfuYPlz6TUUcEQePUKMNg2m2DsEsZz3NrRJKWg7
	 jyXQ85NEchJZYi9Pic1oGbKUoGgoni68PIzWJHU4HnON36kwRO/WUiHbwGvAX+5kXzZsF
	 tKZy6C/6IoeRkB8PlhxVTQAz3itZw681mQ9wmvqJWMktqnE1JJXc8Lpxa5EXeUcgnb1Aq
	 OrdDELAP7NiGt5B68j/8PbTh85sExwl0/Iwkr6j+znKaYXMLzLtGK+lXW/3sR6RPtYcZf
	 MVOIokQSXELUKWfZn3ViZ3q+Yf5WARO4F09YHwsgc3wT9zGPv83glnjcqheiRUs/Ivw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 36D391F000C1;
	Fri, 27 Nov 2026 09:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795772886;
	bh=t3mPvJqSE7LXHOFUTmX0cyml/DTyX3mUI2pndg6S5bQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=CR0B2HWU3JGbCm3e2rZtORVIWflLeOionvzm93zrCGfQUbTqjCk3nNVUsm62nF/cp
	 /HLSeCv4qISyEezYHsBAkZEfuK753U95XDhqDwdDYvypEmsONarTUsaPmIhvfYHwyr
	 ZK6hKe3EvfUGkGmpevJjrZ3pBXZ1HY7BC6wcv4YP+UICs0BgsqNL6zIpz1pUhB4ayS
	 CCuY0glU3nsSIZp8c7JBzqaK6dWn1WqozP6e1BiYL7jB2P4bIffvrmgUryxBk+yzWs
	 d+kQ35Huqx+rHxHQjR8w6XgTiusOFBvVAOeBZF9bavJMgNcvGD3J24lm8jTpO0wQMR
	 9WfDF0yDj11UQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id B5BB64B6D1;
	Fri, 27 Nov 2026 09:47:56 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Fri, 27 Nov 2026 09:47:47 +0000
Subject: [PATCH v2 4/5] iio: event: add struct iio_event_attr
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
Message-Id: <20261127-iio-core-attr-review-v2-4-e0aed1e8a81c@analog.com>
References: <20261127-iio-core-attr-review-v2-0-e0aed1e8a81c@analog.com>
In-Reply-To: <20261127-iio-core-attr-review-v2-0-e0aed1e8a81c@analog.com>
To: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795772875; l=7028;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=NnM8uAIs95unllidYtNAMgDZ5VgVeGY7qa5DNOWWAJM=;
 b=vOtOO+eKu4wv+iAiSUFlM2btbxpiP+pXpXda6wz0TXqGjWvn5+2k65BB262+4YI4RS8FBGF9R
 7i2MBdF1UA4CRVVLyN1aPOFD5UNlGlQkQ80mueedNwFMJ1oIBDIp0cn
X-Developer-Key: i=rodrigo.alencar@analog.com; a=ed25519;
 pk=ULeHbgU/OYh/PG/4anHDfLgldFItQHAhOktYRVLMFRo=
X-Endpoint-Received: by B4 Relay for rodrigo.alencar@analog.com/default
 with auth_id=561
X-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Reply-To: rodrigo.alencar@analog.com
Content-Transfer-Encoding: 7bit

From: Rodrigo Alencar <rodrigo.alencar@analog.com>

Event attributes encode both the index of their struct iio_event_spec
and the event info into the attribute address, as
(info << 16) | spec_index, and look the event spec up through the
channel on every access.

Add struct iio_event_attr, extending struct iio_chan_attr with a pointer
to the event spec. The address now only holds the event info, and the
event type and direction are read directly from the spec.

Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
---
 drivers/iio/industrialio-event.c | 63 +++++++++++++++++++++++++---------------
 1 file changed, 40 insertions(+), 23 deletions(-)

diff --git a/drivers/iio/industrialio-event.c b/drivers/iio/industrialio-event.c
index e72b665cc79b..e6a404642417 100644
--- a/drivers/iio/industrialio-event.c
+++ b/drivers/iio/industrialio-event.c
@@ -258,19 +258,35 @@ static const char * const iio_ev_info_text[] = {
 	[IIO_EV_INFO_SCALE] = "scale",
 };
 
-static enum iio_event_direction iio_ev_attr_dir(struct iio_chan_attr *attr)
+/**
+ * struct iio_event_attr - IIO event attribute
+ * @chan_attr:	underlying IIO channel attribute, its address holds the
+ *		event info
+ * @spec:	event specification the attribute belongs to
+ */
+struct iio_event_attr {
+	struct iio_chan_attr chan_attr;
+	const struct iio_event_spec *spec;
+};
+
+static_assert(offsetof(struct iio_event_attr, chan_attr) == 0);
+
+#define to_iio_event_attr(_dev_attr)					\
+	container_of(to_iio_chan_attr(_dev_attr), struct iio_event_attr, chan_attr)
+
+static enum iio_event_direction iio_ev_attr_dir(struct iio_event_attr *attr)
 {
-	return attr->c->event_spec[attr->iio_attr.address & 0xffff].dir;
+	return attr->spec->dir;
 }
 
-static enum iio_event_type iio_ev_attr_type(struct iio_chan_attr *attr)
+static enum iio_event_type iio_ev_attr_type(struct iio_event_attr *attr)
 {
-	return attr->c->event_spec[attr->iio_attr.address & 0xffff].type;
+	return attr->spec->type;
 }
 
-static enum iio_event_info iio_ev_attr_info(struct iio_chan_attr *attr)
+static enum iio_event_info iio_ev_attr_info(struct iio_event_attr *attr)
 {
-	return (attr->iio_attr.address >> 16) & 0xffff;
+	return attr->chan_attr.iio_attr.address;
 }
 
 static ssize_t iio_ev_state_store(struct device *dev,
@@ -279,7 +295,7 @@ static ssize_t iio_ev_state_store(struct device *dev,
 				  size_t len)
 {
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
-	struct iio_chan_attr *this_attr = to_iio_chan_attr(attr);
+	struct iio_event_attr *this_attr = to_iio_event_attr(attr);
 	int ret;
 	bool val;
 
@@ -291,7 +307,7 @@ static ssize_t iio_ev_state_store(struct device *dev,
 		return -EINVAL;
 
 	ret = indio_dev->info->write_event_config(indio_dev,
-		this_attr->c, iio_ev_attr_type(this_attr),
+		this_attr->chan_attr.c, iio_ev_attr_type(this_attr),
 		iio_ev_attr_dir(this_attr), val);
 
 	return (ret < 0) ? ret : len;
@@ -302,14 +318,14 @@ static ssize_t iio_ev_state_show(struct device *dev,
 				 char *buf)
 {
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
-	struct iio_chan_attr *this_attr = to_iio_chan_attr(attr);
+	struct iio_event_attr *this_attr = to_iio_event_attr(attr);
 	int val;
 
 	if (!indio_dev->info->read_event_config)
 		return -EINVAL;
 
 	val = indio_dev->info->read_event_config(indio_dev,
-		this_attr->c, iio_ev_attr_type(this_attr),
+		this_attr->chan_attr.c, iio_ev_attr_type(this_attr),
 		iio_ev_attr_dir(this_attr));
 	if (val < 0)
 		return val;
@@ -322,7 +338,7 @@ static ssize_t iio_ev_value_show(struct device *dev,
 				 char *buf)
 {
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
-	struct iio_chan_attr *this_attr = to_iio_chan_attr(attr);
+	struct iio_event_attr *this_attr = to_iio_event_attr(attr);
 	int val, val2, val_arr[2];
 	int ret;
 
@@ -330,7 +346,7 @@ static ssize_t iio_ev_value_show(struct device *dev,
 		return -EINVAL;
 
 	ret = indio_dev->info->read_event_value(indio_dev,
-		this_attr->c, iio_ev_attr_type(this_attr),
+		this_attr->chan_attr.c, iio_ev_attr_type(this_attr),
 		iio_ev_attr_dir(this_attr), iio_ev_attr_info(this_attr),
 		&val, &val2);
 	if (ret < 0)
@@ -346,7 +362,7 @@ static ssize_t iio_ev_value_store(struct device *dev,
 				  size_t len)
 {
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
-	struct iio_chan_attr *this_attr = to_iio_chan_attr(attr);
+	struct iio_event_attr *this_attr = to_iio_event_attr(attr);
 	int val, val2;
 	int ret;
 
@@ -357,7 +373,7 @@ static ssize_t iio_ev_value_store(struct device *dev,
 	if (ret)
 		return ret;
 	ret = indio_dev->info->write_event_value(indio_dev,
-		this_attr->c, iio_ev_attr_type(this_attr),
+		this_attr->chan_attr.c, iio_ev_attr_type(this_attr),
 		iio_ev_attr_dir(this_attr), iio_ev_attr_info(this_attr),
 		val, val2);
 	if (ret < 0)
@@ -371,11 +387,11 @@ static ssize_t iio_ev_label_show(struct device *dev,
 				 char *buf)
 {
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
-	struct iio_chan_attr *this_attr = to_iio_chan_attr(attr);
+	struct iio_event_attr *this_attr = to_iio_event_attr(attr);
 
 	if (indio_dev->info->read_event_label)
 		return indio_dev->info->read_event_label(indio_dev,
-				 this_attr->c, iio_ev_attr_type(this_attr),
+				 this_attr->chan_attr.c, iio_ev_attr_type(this_attr),
 				 iio_ev_attr_dir(this_attr), buf);
 
 	return -EINVAL;
@@ -384,13 +400,14 @@ static ssize_t iio_ev_label_show(struct device *dev,
 static int iio_device_add_event_attr(struct iio_dev *indio_dev,
 				     const char *postfix,
 				     const struct iio_chan_spec *chan,
+				     unsigned int spec_index,
 				     iio_attr_show_t show,
 				     iio_attr_store_t store,
-				     u64 mask,
+				     enum iio_event_info info,
 				     enum iio_shared_by shared_by)
 {
 	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
-	struct iio_chan_attr *ev_attr;
+	struct iio_event_attr *ev_attr;
 	struct iio_chan_attr_ctx ctx;
 	int ret;
 
@@ -404,7 +421,8 @@ static int iio_device_add_event_attr(struct iio_dev *indio_dev,
 	if (!ev_attr)
 		return -ENOMEM;
 
-	ret = iio_chan_attr_add(&ctx, ev_attr, show, store, mask);
+	ev_attr->spec = &chan->event_spec[spec_index];
+	ret = iio_chan_attr_add(&ctx, &ev_attr->chan_attr, show, store, info);
 	if (ret)
 		kfree(ev_attr);
 
@@ -449,8 +467,7 @@ static int iio_device_add_event(struct iio_dev *indio_dev,
 		}
 
 		ret = iio_device_add_event_attr(indio_dev, postfix, chan,
-						show, store,
-						(i << 16) | spec_index,
+						spec_index, show, store, i,
 						shared_by);
 		kfree(postfix);
 
@@ -488,8 +505,8 @@ static int iio_device_add_event_label(struct iio_dev *indio_dev,
 	if (postfix == NULL)
 		return -ENOMEM;
 
-	ret = iio_device_add_event_attr(indio_dev, postfix, chan,
-					&iio_ev_label_show, NULL, spec_index,
+	ret = iio_device_add_event_attr(indio_dev, postfix, chan, spec_index,
+					&iio_ev_label_show, NULL, 0,
 					IIO_SEPARATE);
 
 	kfree(postfix);

-- 
2.43.0


