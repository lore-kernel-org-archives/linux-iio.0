Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795334900;
	b=SPM+CxG7ScjnIOneS35GE31Gb6yTlAVpOjTVR9djGixb1lToFNXVG23HUKbCwxrtuxbf
	 dytjD65iJn32KsNPP4RullL6RtwDk3opyuVDHPKCIzBx1Ol0FYq6g1nsk7vpwUuFZ/TMC
	 Q1qmRlE7F+kJdrJQ+7ZBFLJp8aKJe7rpMr4Co9Wp9qsGSOrFyFw0bcKfS1Ml4K7zD0R/t
	 BzZwo7uB7jBzpDhBZdqRLwfd+NlOu5RVI4p35nU3hOp09dJQItdUfc2WuEkm0q0Hehgv3
	 DnZqRZVeKiULqgHDw0mvvHOzJ5gMzzearObbRBYFTz7WxxfckSHa/OaPCCGNpBXRuEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795334900;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=EWUDpDx3gOF11tISsn8dosM22YoRGivzGRUaW6pDGjY=;
	b=3BKxRpC7eLoiMMe5lmXYfhHIphV7ChWtTOvOQj5tY4lyTwlA/gS9oNn8JQkwMuZc0/im
	 EwUalG65X08nLUAQCpVIfxHVc5/rm8xwVs0T7DqmUeKxe1kQBWxRjbmNEaqBzfx594auk
	 3r8VVkbvdI25Pw9fGJ1MeYKLKQWhbqQtSk81jA0WlVlj0B6oO9eoJWEKeGWteq0Q0eC0S
	 //IwtXP7BXVrXCG/sFh4IlHha0IGb6vCFUcsk8qE05gHK0oRfyKXg4i8KxZS8BStYzRQN
	 WDrFbTY/XxUQF6kXGkPQFokHcUah5cR248CsNnDJxqRyiAkfXQ/+TZ0ZjoVNnS39gdQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uC9Jw2OS;
	arc=none smtp.remote-ip=209.85.208.50
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B2F4606A32C
	for <linux-iio@vger.kernel.org>; Sun, 22 Nov 2026 08:08:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5B2F4606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uC9Jw2OS
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6b86bbce3d1so2906096a12.0
        for <linux-iio@vger.kernel.org>; Sun, 22 Nov 2026 00:08:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795334898; x=1795939698; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=EWUDpDx3gOF11tISsn8dosM22YoRGivzGRUaW6pDGjY=;
        b=uC9Jw2OS4jLuvaA7tEOkaSrik+nD7YprBp5BZGQ8p0mMsug9PjmvJAjm4nvQMe71cR
         thKQP4baCaBUXtbzgXrddTtVes6Ezbew5Vqi2hv8B+0OgeiZ9N/+kv9opvQvEEk8wQlc
         w7Rti00eUP5FvT3SQ4kbGv7OCOeW1w9nVUZ02sqeB8Xq0hNKdUlDgSaxjKmOVzyqcG1s
         4goHEuLlHTfO3Ecal9CGCcMDWRfE6QBbmRkFrULGJPrpzyULOa6I7qsAgU4Lirr7Vi67
         vgnWlKiItkhWhCVYmoLSLoRFpy/IKktMWfMTuyOARFNa1DvuroDa55TH7+u4AdotU1Xy
         PSSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795334898; x=1795939698;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EWUDpDx3gOF11tISsn8dosM22YoRGivzGRUaW6pDGjY=;
        b=P97573HGWnBaXiwTzN+VlVXDEJjXL02A7zp+977H9U+Fc1v/UJAxgLdTJNkZ1MnMpN
         rrh+d40PqfnRtNjAhKkf7AyRIuOE2Zcq1hSDRYSfxSj4bY+8/edx8fdNdMZTMe/+BOSS
         T9f2bKfl4L7WIUhaycXoJIZULrzS1HiRv5WmGAve8++lyAtrAkepAh42XkjQnCPpWh46
         peXzKxao5q2kwWW5udO/FE3d82tfs+5GCVgxr7RsGHQTGMzzA4J5noSnNePsTXTKRftX
         jAZcOm4Hbj8+SXxoA6SBq1DKzerCFm422vd9CSJ22zb3BgYqS47LBXYE0s/1frsL8uUV
         UAbw==
X-Gm-Message-State: APuU4Z8eCCXenmO5pHGlXNpGt9uzIT9jV9nxLg33G7XPVuQot4Yfi05i
	byPkrjkwKs+SyIrFMMGeAdijkpofBzfRuMfgE7rtEDFjmduNj+2obHSU
X-Gm-Gg: AZFdTZc+cjXlVwgWhLXN+1F/HF+6MDPQ24C8+hHoaipIHFGP22qulB7C0rskub6B4Vb
	ilUo34/CzUCD1YNrOCGqlUsz+ebhW3Yi/JZ/WdO6Aoeo3UfBy0GBTf/vuj3jbEl9C+hzSymwmO9
	EzNRAdIE3Fv1bFJqHoVUOmZZVAkPwNOC0BWrPSCV1M0WoNr7411ZqmW3iLZRiAQkHuF0U+kf6yp
	8MwSesmdRD5v9G81LwxRiorsb9xresQydMVPkOkOZxPAJ0XOQjXCt1q5FF7rJzupVgwJEeM5o3v
	DH4rLybpPeMSh4iBjpXn1dh4JexGMQ16SM9gY1rIaUbKOVCeoY2BmW6DhMfhuRGBfNR6GnuXgr2
	3a6tk4hnRFPBe69lseAOQy1oPNIGUXN2LU5rz7tRcj7GpyQqKob5JU448LRcwbiGfwRbSTkkp3/
	0d9uUZpx7zZ06ipP9PYKYhHUeCgNZltd9BOXODs3vHzmX9wNg5pg6EWVjEGL7Vf0HKL33L4y8Wi
	2bxihlk2XzA2t7/l0Cyp1UQ7y5DElxfqTezI1ZykRr78P6mNBzLKDPf8XUiHahwWkufyDXHEoI0
	bBYrVacUQwbGUeE0KPV6lMWpgTpFt6Rx0/StaPIrKzrUOnM50erHutvfQ4Ck16rx/XGiarG60dS
	7BPZEOgn2SyHH48a/CDKMKYG9c1GCnWg=
X-Received: by 2002:a05:6402:1941:b0:6ba:7b46:7885 with SMTP id 4fb4d7f45d1cf-6ba7b468283mr1860652a12.11.1795334897596;
        Sun, 22 Nov 2026 00:08:17 -0800 (PST)
Received: from xeon ([188.163.112.62])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6ba3710601esm3596014a12.27.2026.11.22.00.08.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 00:08:15 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Esben Haabendal <esben@geanix.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Svyatoslav Ryhel <clamor95@gmail.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>,
	Pan Chuang <panchuang@vivo.com>,
	Hemanth Selam <hemanth.selam@gmail.com>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Nikita Travkin <nikita@trvn.ru>
Cc: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/4] iio: light: ltr501: Add LTR-659PS-01 prox sensor support
Date: Sun, 22 Nov 2026 10:07:49 +0200
Message-ID: <20261122080753.36349-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.53.0
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

Add support for the Lite-On LTR-659PS-01 proximity sensor. This device is
nearly identical to the LTR-559ALS-01, but omits all elements related to
ambient light sensing.

---
Changes in v2:
- set IIO_PROXIMITY channel to scan_index 2 since driver will not handle other
  id properly
- add IIO_CHAN_INFO_SAMP_FREQ for IIO_PROXIMITY channel
- isolate missed ALS register calls
- add commit to use read_avail operation
- convert to use modern chip info match

Changes in v3:
- LTR501_INTENSITY_CHANNEL macro adjusted to set predefined info_mask_shared_by_type,
  info_mask_shared_by_type_available and info_mask_shared_by_all_available
- added info_mask_separate_available and info_mask_shared_by_all_available to
  proximity channel
- fixed IIO_CHAN_INFO_SCALE for IIO_INTENSITY since table has -1 entries
- fixed indio_dev->name asignment
- dropped ltr501_has_als_support helper
- fixed channel finding in ltr501_trigger_handler
- isolated more accesses to ALS registers if no_als_support is enabled

Changes in v4:
- adjusted intensity scale passing
- int_time and samp_freq converted into 2d arrays
- for_each_set_bit() + iio_find_channel_from_si() > iio_for_each_active_channel()

Changes in v5
- fixed als_gain_tbl_len calculation
- restored use of iio_find_channel_from_si()

This patchset requires change[1] exporting iio_find_channel_from_si() since else
building as module will fail

[1] https://lore.kernel.org/lkml/20261115083049.46840-1-clamor95@gmail.com/
---

Svyatoslav Ryhel (4):
  iio: light: ltr501: Switch to read_avail() op from manual attribute
    registration
  iio: light: ltr501: Switch to modern match mechanism
  dt-bindings: iio: light: ltr501: Document LTR659 proximity sensor
  iio: light: ltr501: Add support for the LTR-659PS-01 proximity sensor

 .../bindings/iio/light/liteon,ltr501.yaml     |   1 +
 drivers/iio/light/ltr501.c                    | 427 +++++++++---------
 2 files changed, 211 insertions(+), 217 deletions(-)

-- 
2.53.0

