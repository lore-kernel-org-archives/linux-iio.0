Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794793740;
	b=E3KDwYalCTqRts9sAQ7TlLPkNsny5hbht3w4lvZqlghu29xDtkLWjnXd7LRFkRGBJMMD
	 qzd5/xyYmO89bjpYW4UZedfOl3KkU5uGpzRgkdSrn8XFDPefOubzGoXZPmCTlHLio4EqT
	 nbpYSmpa8gsrms+3xjilhS4bI6RYUS/i+lKmcr2FLuJj9n+1xIT2IIS1vF714W1S6uI8F
	 Y/fDi4CE+w/MtE7VcMvjJVjIG0OIC/2r7sK0mgsDF4OvA+bpbkAl+bVLHv7qHCYp9Tj7S
	 +HLrEzF2Tr7qGKrnuterL0whkqGZSPmQQGMufn7GFs110Jk4jyKz4aD7MyRftunkNJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794793740;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=5QlkdgiEt3bFKeaMjJR+PirbC0QvZV3PxdIlagr3OCY=;
	b=OjPSx/6J/pt45fWhVSx0YyrohwPBZcarozXxRCl+pnH66YE+ApaqZtNziir3u38EVrSs
	 FEeI/s6bxlTLVhmfUuy0aK1a6jYepKolza74mDIV03klEUz1yHrFpxjiJXkIF8FXOXzUw
	 KYS+rDtgWCw+UlHQUQoFIyaS8PoOc8z0XxLG7O1QuYfPL9BPyc72Gz5o4N7Dn9L4bumTN
	 vXpo2U5CkCRRkDq8JcoR/pdkuaIStfIYHxC88MVnGP5Rn49MQhJxBDe4Os3Cu+Gy/saVu
	 uS8L7NLH+GrNK+nhcDAKrqhW9jKNsIyNPUzZsLUbZXvOpidGT22y7L9asblH0UU5iFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CqjFF0tF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F003F606A32F;
	Mon, 16 Nov 2026 01:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CqjFF0tF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80AA91F000C5;
	Mon, 16 Nov 2026 01:48:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794793739;
	bh=5QlkdgiEt3bFKeaMjJR+PirbC0QvZV3PxdIlagr3OCY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CqjFF0tFuyi7R6UjySyzwdbMIOnu1UnrM0OTQx7u+fyb/Ob0ZiB/XVD+iayq72t0f
	 VQgPvqhoQxgepJwUVT86A62IKv7a3d/pJtFswHx80ZcDjvI/PNeziXN4NU6MjiP5Ah
	 EZlBMhn0QKDBoanQdjYgSdsiFld3imYcWXrAWY2kVwXMOoOotQzJ5SkipasyjNSYhg
	 AJlgZ/dIxyiJLJDW8BkjALuH7/7pjz9mq87eX86P8RZUqhRHTwnd7gHR5RSt79qlsx
	 d15P5JERCJO5WPd/N4krEvx9idRgtG/bQ8guobMsp+XULIoivcR/vlbyZEaWuGS3Bx
	 QqNlsb2g6LcjA==
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
Subject: [PATCH 02/35] media: pci: mgb4: use IIO default_trigger
Date: Mon, 16 Nov 2026 01:47:50 +0000
Message-ID: <20261116014823.3132576-3-jic23@kernel.org>
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

Set indio_dev->default_trigger rather than taking a reference to the
trigger in probe_trigger(). The IIO core now takes the reference during
iio_device_register().

Previously the reference was taken before iio_triggered_buffer_setup()
set INDIO_BUFFER_TRIGGERED, so a failure in that call leaked the trigger
reference as the IIO core only drops it for devices with triggered modes.

Fixes: 0ab13674a9bd ("media: pci: mgb4: Added Digiteq Automotive MGB4 driver")
Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

---
Ideally I'd like to take this though the IIO tree. There are load of
other changes coming on top of this, ultimately making the
struct iio_dev->trigger opaque to drivers. I can provide an immutable
branch if that is likely to be necessary.

Note as these are just a case of a resource leak in an obscure
error path I haven't been marking them as fixes and it probably
isn't worth backporting them.
---
 drivers/media/pci/mgb4/mgb4_trigger.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/pci/mgb4/mgb4_trigger.c b/drivers/media/pci/mgb4/mgb4_trigger.c
index 70cad324df60..f48052b76d6d 100644
--- a/drivers/media/pci/mgb4/mgb4_trigger.c
+++ b/drivers/media/pci/mgb4/mgb4_trigger.c
@@ -126,7 +126,7 @@ static int probe_trigger(struct iio_dev *indio_dev, int irq)
 	if (ret)
 		goto error_free_irq;
 
-	indio_dev->trig = iio_trigger_get(st->trig);
+	indio_dev->default_trigger = st->trig;
 
 	return 0;
 
-- 
2.56.1

