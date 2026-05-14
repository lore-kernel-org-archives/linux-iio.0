Received: from s106b.cyber-folks.pl (s106b.cyber-folks.pl [195.78.66.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B802236E3;
	Thu, 14 May 2026 03:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.78.66.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778728809; cv=none; b=VOwuWo4pBs4lUFhKiFAJ+l28JBWK5tqFXdEINFnp+Vg8N+f/+LaxLmwbWfKbSjTkCVJIsaHnY0Qn8SUo+Fh4CzB4IHh76xXENtirn/h+oQ8KXz6TpT+Ir/7AkSGY+4bFbHP6V4SbmwuewUWVlpvpYnha+EVOPHGUXkUGW1+YZI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778728809; c=relaxed/simple;
	bh=mAW9smyP3Y9zNh0IDxgH/7BBIen5KUX/2eJMMof12rc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=VcomS5/ueECyNovbu5QAkZJWIppg9HylF8Jx9cAkywY7YzP+/ns239Zyj8osreNE561kr3fo+5NJEx9qF531BsUx8l0w7Kuio5+g9Gc2fg/BIOkwPYp5fV6FvzRBp/Hm9cgToiLl+nMo7sWTUZ6uEIdBu3n+krWjI7J5rBUmWvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mmpsystems.pl; spf=pass smtp.mailfrom=mmpsystems.pl; dkim=pass (2048-bit key) header.d=mmpsystems.pl header.i=@mmpsystems.pl header.b=QYij6wex; arc=none smtp.client-ip=195.78.66.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mmpsystems.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mmpsystems.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mmpsystems.pl header.i=@mmpsystems.pl header.b="QYij6wex"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=mmpsystems.pl; s=x; h=Cc:To:Message-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Subject:Date:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=V8Zv1XxU0NXRkczbbte8VINxmUP6BumFNP4JQShgmbg=; b=QYij6wexY6658C8GQB+Ud1GMHS
	UexeAtIdV4B5jonQ3oMluQfemg78ENfSZp7IWxTW2ohf83AwadBuA6hoI/Gjz7W6jgvVo5U39RtrT
	U6vHE0YbnzgzQtUoK3h4OZLc2YA74CM0L0Gly5RhPk2x9l1BR67iZhRUg4w6+HzrI2ekkoRC123Y1
	ICxbqKyo1qJriSlFf9dvFHW73Uz0ZYiezUn/FeWy0bc5y5HiFcpbdUhCZlRP2cfa7Ef23FPK15v9X
	Cn1xO56b2RgSt3vG2hhCbgYlCBwN8TAJ1zkIYU+gLB7eSCKb+U5ubZahS8TzVeqSdqMbTRIpMuX41
	YIheyFzg==;
Received: from [91.102.182.218] (helo=localhost)
	by s106.cyber-folks.pl with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <michal.piekos@mmpsystems.pl>)
	id 1wNMc8-0000000H9MG-1Eyv;
	Thu, 14 May 2026 05:19:56 +0200
From: Michal Piekos <michal.piekos@mmpsystems.pl>
Date: Thu, 14 May 2026 05:19:34 +0200
Subject: [PATCH v2] iio: adc: sun20i-gpadc: support non-contiguous channel
 lookups
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260514-fix-sunxi-gpadc-sparse-channels-v2-1-d4a66b70c7a7@mmpsystems.pl>
X-B4-Tracking: v=1; b=H4sIAEU/BWoC/42OTQ6DIBBGr2JYdxrAlsSueo/GheBUaRQJg0Zjv
 HvBXqDLl7zvZ2eEwSKxR7GzgIslO7kE8lIw0zeuQ7BtYia5VPwuSnjbFWh2q4XON60B8k0ghCw
 7HAikVlpyVer2VrHU4gOmyLnwqn9Ms/6gibk2G72lOIXtvLCI7P2/tggQoIwUKCuuDeJzHD1tF
 HGkqx9YfRzHF6qVKH3kAAAA
X-Change-ID: 20260513-fix-sunxi-gpadc-sparse-channels-2b6b2063bd49
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Chen-Yu Tsai <wens@kernel.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>
Cc: linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Michal Piekos <michal.piekos@mmpsystems.pl>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 llvm@lists.linux.dev
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778728785; l=2567;
 i=michal.piekos@mmpsystems.pl; s=20260301; h=from:subject:message-id;
 bh=mAW9smyP3Y9zNh0IDxgH/7BBIen5KUX/2eJMMof12rc=;
 b=IzE2aCtNGPDvgiHxMVpRWxq6l4Hz7kBMcZiHPIsDF1KFpqFB8KN5/bGtIJbN82SZJaMKOPjtR
 AyNgm7Y1d/EClBYHORnzkw4FSpaGRdXUTikaUr9cxnFtfZu18gfBWjD
X-Developer-Key: i=michal.piekos@mmpsystems.pl; a=ed25519;
 pk=Aixyx03If7ZDamiKKN0lsa+0mtA+WjIuIf2ZQVYNBqg=
X-Authenticated-Id: michal.piekos@mmpsystems.pl

Using consumer driver like iio-hwmon which resolve channels thorugh
io-channels phandles will fail for sparse channels because IIO core by
default threats phandle argument as index into channel array.
        eg. <&gpadc 1> will fail if there is only channel@1 specified

Add .fwnode_xlate() which maps DT phandle to the registered channel
whose chan->channel matches the hardware channel number. It allows
sparse channel maps to be consumed by drivers like iio-hwmon.

Tested on Radxa Cubie A5E.

Signed-off-by: Michal Piekos <michal.piekos@mmpsystems.pl>
---
Changes in v2:
- Move loop variable declaration into the for statement
- Fix indentation using clang-format
- Correct commit wording
- Link to v1: https://patch.msgid.link/20260513-fix-sunxi-gpadc-sparse-channels-v1-1-6c21e290bcee@mmpsystems.pl

To: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
To: Nuno Sá <nuno.sa@analog.com>
To: Andy Shevchenko <andy@kernel.org>
To: Chen-Yu Tsai <wens@kernel.org>
To: Jernej Skrabec <jernej.skrabec@gmail.com>
To: Samuel Holland <samuel@sholland.org>
To: Nathan Chancellor <nathan@kernel.org>
To: Nick Desaulniers <nick.desaulniers+lkml@gmail.com>
To: Bill Wendling <morbo@google.com>
To: Justin Stitt <justinstitt@google.com>
Cc: linux-iio@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-sunxi@lists.linux.dev
Cc: linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev
---
 drivers/iio/adc/sun20i-gpadc-iio.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/iio/adc/sun20i-gpadc-iio.c b/drivers/iio/adc/sun20i-gpadc-iio.c
index 861c14da75ad..78c9a52f38df 100644
--- a/drivers/iio/adc/sun20i-gpadc-iio.c
+++ b/drivers/iio/adc/sun20i-gpadc-iio.c
@@ -139,8 +139,20 @@ static irqreturn_t sun20i_gpadc_irq_handler(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
+static int
+sun20i_gpadc_fwnode_xlate(struct iio_dev *indio_dev,
+			  const struct fwnode_reference_args *iiospec)
+{
+	for (unsigned int i = 0; i < indio_dev->num_channels; i++)
+		if (indio_dev->channels[i].channel == iiospec->args[0])
+			return i;
+
+	return -EINVAL;
+}
+
 static const struct iio_info sun20i_gpadc_iio_info = {
 	.read_raw = sun20i_gpadc_read_raw,
+	.fwnode_xlate = sun20i_gpadc_fwnode_xlate,
 };
 
 static void sun20i_gpadc_reset_assert(void *data)

---
base-commit: 1d5dcaa3bd65f2e8c9baa14a393d3a2dc5db7524
change-id: 20260513-fix-sunxi-gpadc-sparse-channels-2b6b2063bd49

Best regards,
--  
Michal Piekos <michal.piekos@mmpsystems.pl>

