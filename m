Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795197905;
	b=lgk/G8lDTl1GouzLrb6mzh16TuvmTmRvRyRN546LvCDHqHIdMzp5rk+sPJai4PUwbJRG
	 oN0iW1ET3XZFAljGIZm6WDIh6wUHbHdfX8dNP7pcLnpymxC4RbmyvNihg9dsyu41AafRo
	 p7diY3pHhuN37M8AAVAaa4NhKIXhKfGnm45bJ9c+sb1IhdcV7J9eoGuLFeMYj32fTYOEi
	 tC3PK5JQONHfGYfeMQA8qE7rA3/5QAlbRZ4SRCZW7jCj72pvbfAcEYDhlC6XaspkNObvG
	 MyJ0WwIBxuOvEvxBbxRlt92chqDIEwGUgoCHDxHli4sg705clf4BectcMQ5pVXgG1Mg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795197905;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=Z0iC7O32uyMGduUf/rLmlqfyp3kiuwRd3E2PoPpaukw=;
	b=YC+jHHnkei3LYXzLFy32QRe36Mf/oIKug9XcaCS1jUVKoqSzndO6jNi01ZpQ+zouFYgc
	 OJzwCYvXCEWMH435HxCpFMhqrcejPCoxsb0Xme7/aDPJpE7RevyjyD4JCZytnKkEmqRdC
	 483eiHzd7E6yF+g3z2M4RtjRAGvC7f7xn8PsAtsZv8Q5m7JelpctGg+kszcKsN06nBvrx
	 mW60xcM7xVc5BtrqYr17WGYwuk0yoFtONYbdQR6V6xtdqlrpxnlY3GTyLPZ1SQZZPuLWY
	 OYslRffeIv1ZXlHARDFjQiX2g1ou6Pcr7n3WFTHDZpZDOQSiiVN9711MjLMChEN/QlA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lF8jYa+H;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1724A60A3837;
	Fri, 20 Nov 2026 18:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lF8jYa+H
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795197904;
	b=WB5WOkSAIToJIw4clOVQYmFM7BKav2xLplnJihLBHSa28mhAvORmFkpQlLwxdydimk/B
	 vl6t0rUu9LDu52nce74Ce/Z0IxcNoHXB16MaYAQLiozukB9Q/9BGOqdL78oRTssoF9df1
	 21Hs/cSxZKWZ9bxOGi7CuKcpX0PvWf5YD0o0KXePeHNYJAOQRMrN/et4HjFVTX40vj+jL
	 TxMmL0O4OE4VAcBf9hLNc82hTJtwWqm0jtG1W/0hN+0gaqb0TykujglQjAhQOcGkiY8Tw
	 sVBc59JbK2cyyYJq0CP96yTl921YkF675bwLnyJQeDD/+G6w1TmFuebtAYNmPw12wKw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795197904;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=Z0iC7O32uyMGduUf/rLmlqfyp3kiuwRd3E2PoPpaukw=;
	b=YlvlGKTZk+xt2jFrbm1F2AvwUM653t65oFy3ykcsyBGmDcG6yzxjT+CSP1h3gd3NeUzN
	 hVucmIA9T30bvjNE8IBopuf5Ioh3wIa3nZmj5/QTKoUo4UGCIkyV5+dtC6LmfTd/L6jsm
	 LFb430eM125BPbJlH61EEyj9R5YE18eY1JQuzjChIXDZBR/bW/p1RrCGX1ET0DjOsvO4O
	 hDcH/GP4+DqGgmD6doHITWFiVslc+lRr8V8Ot+Z5rrL2pW9GmiuuC+nJtJx4Az1CsQr7P
	 myE6DYOnKk1dfdIsZRlI2me0gAYdVPkDQoMoxCGCobX4yEW1XFlTf7P64FuqMZoTiKA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 48D4D1F0089F;
	Fri, 20 Nov 2026 18:04:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795197904;
	bh=Z0iC7O32uyMGduUf/rLmlqfyp3kiuwRd3E2PoPpaukw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=lF8jYa+HavExLK4/eMgOCETCmR6WSD3PpQM8YFIPrOsbM/wmvDqGMpjaDnW86fRgF
	 X6IuNAjtdpm4DdkDzU5Fgw2hOwA2Y0f9SFhY/u9GwDRvr60HnA9nsexDwRC1f+hU8e
	 NjqDUU6gvEIr8g7/7Yy+H3LlBezt4Oaay9CyVT3AtyLWBsdhxfTrZG7AG09S1Rvy36
	 gXmT/if+UKClVMU+0nftXFj1xb1N2QxdYRlyf3YlCp/4edElCiX+YxEhqcYy1sAC4x
	 X/QQjfls96YD9Fd8Z2kLvb4mlqGa+yG12vE5j/qH3bJpl1O2w2JwRlP34IXLIZUZmj
	 BhwX040MaU6eQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id B5B484B8C1;
	Fri, 20 Nov 2026 18:04:43 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Fri, 20 Nov 2026 18:04:01 +0000
Subject: [PATCH RFC 5/5] iio: sysfs: drop core-only fields from struct
 iio_dev_attr
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
Message-Id: <20261120-iio-core-attr-review-v1-5-05b41f8133c2@analog.com>
References: <20261120-iio-core-attr-review-v1-0-05b41f8133c2@analog.com>
In-Reply-To: <20261120-iio-core-attr-review-v1-0-05b41f8133c2@analog.com>
To: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, 
 Rodrigo Alencar <rodrigo.alencar@analog.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795197883; l=1385;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=65/z2WflfdlMHb7yQxMB5agemZHd6GgMQWFUiigsa0U=;
 b=r6Nvq+rxeQxCWzAcw8aDRZDugDzbMk8jQDXr5u8T7ss65LXsa1FemLTXqJI3/cUwpjb4aGbuM
 LROuVPUNLjfC3wMD5Fu0cTJ/E19QWTfNox/kh+kMSCdsY1DMGbP2F+S
X-Developer-Key: i=rodrigo.alencar@analog.com; a=ed25519;
 pk=ULeHbgU/OYh/PG/4anHDfLgldFItQHAhOktYRVLMFRo=
X-Endpoint-Received: by B4 Relay for rodrigo.alencar@analog.com/default
 with auth_id=561
X-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Reply-To: rodrigo.alencar@analog.com
Content-Transfer-Encoding: 7bit

From: Rodrigo Alencar <rodrigo.alencar@analog.com>

The list node, channel spec and buffer pointer of struct iio_dev_attr
are now only used through struct iio_chan_attr and the types extending
it. Remove them, so that attributes declared by drivers through
IIO_DEVICE_ATTR*() and friends no longer carry them.

On 64-bit, without lockdep, this shrinks struct iio_dev_attr from 72 to
40 bytes.

Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
---
 include/linux/iio/sysfs.h | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/include/linux/iio/sysfs.h b/include/linux/iio/sysfs.h
index de5bb125815c..1e4122b8c13a 100644
--- a/include/linux/iio/sysfs.h
+++ b/include/linux/iio/sysfs.h
@@ -9,23 +9,14 @@
 #ifndef _INDUSTRIAL_IO_SYSFS_H_
 #define _INDUSTRIAL_IO_SYSFS_H_
 
-struct iio_buffer;
-struct iio_chan_spec;
-
 /**
  * struct iio_dev_attr - iio specific device attribute
  * @dev_attr:	underlying device attribute
  * @address:	associated register address
- * @l:		list head for maintaining list of dynamically created attrs
- * @c:		specification for the underlying channel
- * @buffer:	the IIO buffer to which this attribute belongs to (if any)
  */
 struct iio_dev_attr {
 	struct device_attribute dev_attr;
 	u64 address;
-	struct list_head l;
-	struct iio_chan_spec const *c;
-	struct iio_buffer *buffer;
 };
 
 #define to_iio_dev_attr(_dev_attr)				\

-- 
2.43.0


