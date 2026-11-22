Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795333625;
	b=B77VSZ6vd8w6zv0DNOELlKYvVFNJVBXQoGe9sv+Uf5h3hufEMM9mWHZD5/rOmuxPlDoo
	 AUYza7UxTKO8quUx+7b4hA92v/3AfEGynO+vuvwJRUcq9QosSuZpFJ8ary2vTRYz8Sbfk
	 q+gQVkOd+aMnM7u/vn7ZN7oQBNFlNjH7tL41ZbEPVU+CJnf1JNI9IUSsdTAzYR8ydtddM
	 l0ZFClEfwl/rlGMxRgjYKFSjeXnOCZ9k0HYEOYNulyNSsl9WgiZQz+rG4bdlMNsbfzLEd
	 6caD39cwNO5OYhK/7UXR8uz8g7EnKoPhtjlBFjIr+VYFP/em/d5pltd59ZP5T0DMEZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795333625;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Kj+W82NANvfKgUyKf6IsWAM4Mpg0yQ4fSrxz7u58oqs=;
	b=jzKHw3UHb5xx4PDcro0NTBY9XGC/xI4CLn5xgaD7RxKCXLUaymGh8QNVmCF+StxRu4/3
	 iucgpUueaq0EHJzz0jAymhr8xrHdoNAaa9JvMYdcDwGGWMx+ub4nTWyFxjXuCXEEnfjyn
	 47RcF+c+RgLQYzbcIWK9JlOJ1ymlz9gw0lg4plePRhCrikCJQzW72NhHznoEuyyfMDCI+
	 MD2KtmOMzl54GqFEVYIHzbT/Lhdo4CGBoXeNaa7TAWNGxP/2/uVBGB4eRSJYBmZgaAX0Y
	 TjgM3Tiz+yyrXaUnAv/tH6chTaCo14S63MvJ20SB0btvnmuujMkXjLcXPEjRze5vb9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JNMQQkdc;
	arc=none smtp.remote-ip=74.125.82.179
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 565FE606A335
	for <linux-iio@vger.kernel.org>; Sun, 22 Nov 2026 07:47:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 565FE606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JNMQQkdc
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-3712b6d9843so2003167eec.1
        for <linux-iio@vger.kernel.org>; Sat, 21 Nov 2026 23:47:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795333624; x=1795938424; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Kj+W82NANvfKgUyKf6IsWAM4Mpg0yQ4fSrxz7u58oqs=;
        b=JNMQQkdcmULr0DYvlgyP4WMcFM9gusTnKZyos7J2BRoW5/O7xoyz+Ng0CpLtX9E2nR
         zBFu/tKNkrKsxvfhkomnA95E67ZJOi3npDO4Ziqmgf/mK42zgNWueBqNHduSckNKnydz
         WiuhMjEIBWL4IMxCy2tEklRd94yH1DG3j7ZXnKnTi2yg8BJwl70W0IkHKdQFzGxQxsYF
         lkgRT7dlHT/JNQEpqmRRyrqW5atC/kyLYjPCTbXjfMd3IkRr7csmSWM/k6tzwfqo6ofU
         hi4fbmnpFUGbmOguDLg2EnwkrQHQ+WFoUQ7QTHMjIjrf5+W47/+mZovZCJ8ebrkxSGN9
         zWTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795333624; x=1795938424;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Kj+W82NANvfKgUyKf6IsWAM4Mpg0yQ4fSrxz7u58oqs=;
        b=GOlKKDAeewIKx5f97Z3vefLw+xzVvCcmKVorbTNdvSpCXGaguA61mAnOLI3H//C+tw
         93SFGlXBWCpwZZCh9AAvGkxrwFHtnLMcJNnxHI2EG1cnQCPsr1xPwju3i3TmDPQYUKSM
         ToGWly5tTgiqVjTrJrlbkQW6B11lDBLmborwp7LGK5A42Z4ch29YV41TKvkNkPG+5C1z
         MIAvZlc/vLcr8BTp1a+mhfsAHE7QU4TDhUzmfpRQlq7aJnroEIln+/a5w2rXDFCje/aJ
         6nAgG3VER1Yd+Jj9wtp6d7oJ9fFl9qZVCXBHZumXjPlr8nmUUhxZGvixW4Sgv3Xn6y4j
         elGg==
X-Forwarded-Encrypted: i=1; AL+hErFB2Lxvd30fayllo78SL0PfXila3jBxrxj0S8UFtOETsla2CtDntv4SwK460rftrsderLfzPKDjN5c=@vger.kernel.org
X-Gm-Message-State: APuU4Z9M02ljae/SKIp3zPwYB1rdCsBGvDHmQvi7iKj+EDdhdZduKRqZ
	AAG9SfhCJ+M5Aw63LJY+IvCVhorA2ALNxZCvRSPM2OAIGnR43YqFc6h8
X-Gm-Gg: AZFdTZfY+ze23TKnI4y54g5glTTvSCaLGI1E5IpflZp58AM6AKqxgbNuIc8WbfP1MUn
	f0dAKSyAKoGScPrscl6VQ1/Pvxvn9+3+7WQF3ITZKQxXo7zyRLwz0C93+RhpGmfBodwoN6+FxSZ
	IbrioYXMccfaEo2tCe0vp2KbUKGcWsc+1hirg3DRxZULNGCE/JKM4gcqyQFXJd6Zk0bx5cAUxmB
	7/0D9h6gBwvd5svSTyDYIV/OmDNznbHet6agmbBNWNZqGdVDCNw+W2y30N087G83hNd2x/FeLsj
	pSVSpy2/2Ntu2yOzW6j5lByHa/l6miHA668S5FnJY9TChFsqZ/RDvnrmW9fTrNWwmuSoHGpdRLj
	zn/8E1YsxhQwpZWa5dn8sykZI0KMHE/ekB6s6LrQER1OXhQDn28pXYeM/48pSLDUXypu49qH5dk
	f8Jtnv+aQF9Odqe27LJJ+3mSsgUgMujbbH07GQt24MbdYRVVJALujfhDIJgiQo4itcVAvIvX7IX
	JrRl03kUuQCCDjAxLYSANhv/GAd13H0Irnf1BZ97jD45GBWIEprU6fcw7YEjCJRyKA7F0gzKwC6
	cyyaxg7L74D/T309SPb1XlL9pOQIdt/cXsL/I5Qgz8arCNd+7Y2J7BmGv1U2vorZEgCN6HrhTbY
	WwkN3s4z5k+mtGF7fPgvJkV5ir0rCXHgo6HQ2CMSPkaW/GWwGVrQGU2C3mSF+JOY6guPOE196pr
	epgPX9T7UrT2AePSSGFsgDhSzVslFPkdFPyf+i8v74Mg==
X-Received: by 2002:a05:7301:6408:b0:36a:270:ce76 with SMTP id 5a478bee46e88-38570f2b27dmr8893767eec.33.1795333624512;
        Sat, 21 Nov 2026 23:47:04 -0800 (PST)
Received: from kapoor.iiserb.ac.in ([203.18.51.239])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385667decc2sm24898071eec.9.2026.11.21.23.47.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 23:47:04 -0800 (PST)
From: Arnav Kapoor <kapoorarnav43@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Gwendal Grignou <gwendal@chromium.org>,
	Stephen Boyd <swboyd@chromium.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Arnav Kapoor <kapoorarnav43@gmail.com>
Subject: [PATCH v2 1/6] iio: proximity: sx_common: fix raw reads while the trigger is in use
Date: Sun, 22 Nov 2026 13:16:41 +0530
Message-ID: <20261122074649.239441-2-kapoorarnav43@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261122074649.239441-1-kapoorarnav43@gmail.com>
References: <20261122074649.239441-1-kapoorarnav43@gmail.com>
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

sx_common_read_proximity() only reinitialises the completion after
waiting on it, so a complete() that arrives when no read is waiting is
consumed by the next read, which then returns old data without waiting
for a conversion that includes the channel it just enabled. This
happens in two ways:

- The device trigger has no validate_device(), so another IIO device
  can use it. While it does, set_trigger_state() keeps the CONVDONE
  interrupt enabled and the IRQ thread calls complete() for every
  conversion.
- A read interrupted by a signal reinitialises the completion and
  returns, but a CONVDONE interrupt already raised can still complete
  it once the mutex is dropped.

Also, when it is done, the read disables the CONVDONE interrupt
unconditionally, which stops the trigger for the other device.

Reinitialise the completion before enabling the interrupt, and leave
the interrupt enabled when the trigger is, as set_trigger_state()
already does for pending raw reads.

The interrupted-wait case was reported by the Sashiko AI reviewer on an
unrelated sx9324 patch.

Fixes: 72ad02b15d63 ("iio: Add SEMTECH SX9310/9311 sensor driver")
Signed-off-by: Arnav Kapoor <kapoorarnav43@gmail.com>
---
 drivers/iio/proximity/sx_common.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/proximity/sx_common.c b/drivers/iio/proximity/sx_common.c
index 4d4937395d9a..66d06435da05 100644
--- a/drivers/iio/proximity/sx_common.c
+++ b/drivers/iio/proximity/sx_common.c
@@ -167,6 +167,15 @@ static int sx_common_put_event_channel(struct sx_common_data *data, int channel)
 				     data->chan_event & ~BIT(channel));
 }
 
+/* The trigger needs the CONVDONE interrupt too, leave it on while in use. */
+static int sx_common_put_convdone_irq(struct sx_common_data *data)
+{
+	if (data->trigger_enabled)
+		return 0;
+
+	return sx_common_disable_irq(data, SX_COMMON_CONVDONE_IRQ);
+}
+
 /**
  * sx_common_read_proximity() - Read raw proximity value.
  * @data:	Internal data
@@ -188,18 +197,22 @@ int sx_common_read_proximity(struct sx_common_data *data,
 	if (ret)
 		goto out;
 
+	/*
+	 * Forget conversions that completed before this read, e.g. while the
+	 * trigger was in use, so that we wait for a fresh one.
+	 */
+	reinit_completion(&data->completion);
+
 	ret = sx_common_enable_irq(data, SX_COMMON_CONVDONE_IRQ);
 	if (ret)
 		goto out_put_channel;
 
 	mutex_unlock(&data->mutex);
 
-	if (data->client->irq) {
+	if (data->client->irq)
 		ret = wait_for_completion_interruptible(&data->completion);
-		reinit_completion(&data->completion);
-	} else {
+	else
 		ret = data->chip_info->ops.wait_for_sample(data);
-	}
 
 	mutex_lock(&data->mutex);
 
@@ -212,7 +225,7 @@ int sx_common_read_proximity(struct sx_common_data *data,
 
 	*val = sign_extend32(be16_to_cpu(rawval), chan->scan_type.realbits - 1);
 
-	ret = sx_common_disable_irq(data, SX_COMMON_CONVDONE_IRQ);
+	ret = sx_common_put_convdone_irq(data);
 	if (ret)
 		goto out_put_channel;
 
@@ -225,7 +238,7 @@ int sx_common_read_proximity(struct sx_common_data *data,
 	return IIO_VAL_INT;
 
 out_disable_irq:
-	sx_common_disable_irq(data, SX_COMMON_CONVDONE_IRQ);
+	sx_common_put_convdone_irq(data);
 out_put_channel:
 	sx_common_put_read_channel(data, chan->channel);
 out:
-- 
2.53.0

