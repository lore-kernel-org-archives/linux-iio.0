Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794908867;
	b=1jaKrtmLKLIs9PKjpbt1D4k0MFzXP6+vDXfoRq5NjacstMXHq+JCgFl298+FJMgPtyYG
	 tOtOxOTxJMCD/wMoBx58Tdv7C6r92qxP09m1BYBvWsxsMbu6TVRuwYzTUeP/++drsDbXz
	 uRVBZ0CxKk79g2G3ddHQBLw8z2WiJyH54tsJgB9YJRMtkA0WvvhwX3Z3yoiTMpZll4I5a
	 On/JXxlwube8gBG8RWZfoeT09GkKPajwhcGTRmCI7reOZpbk80P0s38yJ0LyRCWizVBE+
	 GabY0ePrJckvY5H60nLKaCMhJTleG/SEIguCJt2o5mUrKO8+y1E/SAxxP6zt1P9m0zQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794908867;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=RaHMnEwLyGtFm3duWMYl9s2TO4AG17GQCBnv9kTRqT8=;
	b=J1c6PGsqljh7akdh4y2+0/wKQwZOg4gr25wJaJSUy+ei/b1Y2tOo0p5Fv16h0QOVKZG5
	 N7SGYkjYFaYAKGn6NLWtxRm5iA4YZoNW4rrkm/U/5/Tl8ALe4PkhWlGM+MX/u0O+u2mxM
	 IgxpV6Ljupi1L7Cy9iHc6I8Xum7maBVlfxUBpWcE2JW3rXuw0+hoVoVqnkoJJvj+zxpBm
	 SDaKoadTFx8/Ty/AYfaFgHcn61dHUBxK3ckrQuXxVassApai03v3SreCCc8f8qpU3tRIw
	 FOZHTpUeKTdNXU8rWLEtihNBKa0V5FeKysWbVwtQUBxGr0uPW8W5uWLLS3nrGQJ7v7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pk0ck0Wl;
	arc=none smtp.remote-ip=74.125.82.173
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3667C606A33B
	for <linux-iio@vger.kernel.org>; Tue, 17 Nov 2026 09:47:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3667C606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pk0ck0Wl
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-36dbde64409so6519822eec.0
        for <linux-iio@vger.kernel.org>; Tue, 17 Nov 2026 01:47:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794908865; x=1795513665; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=RaHMnEwLyGtFm3duWMYl9s2TO4AG17GQCBnv9kTRqT8=;
        b=pk0ck0WlBblluLIuxABA4I5X1xp+ISFNRpptKwSMRbz7Jia2pAhFrQfdxYrtHug79M
         lQuF1Js2VMcuLyn4X7D2fjZOMvXhw+zyOJIfZvn5X4YZY87aZfjMM2RlNjXK1rMd0wX4
         itRVLtu3xco6gwwJqKxGUflSPQA2gihwgFeO9y4Ugb7eQMeYujTem5sgyIEWBCmGuaRg
         XnwMR/5U5RvTXDEz4/Wrsnc09H/gyJorl22Cjnod77PtQ+TmAqx+swWRV9SE36/z4azg
         GmeeIWxRlLUyLa4/9D/rl7Zg6eQX5g7iq3CP8MrmhVn/LQRI2nurRWTT/1ELZpkzZLcV
         xBSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794908865; x=1795513665;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RaHMnEwLyGtFm3duWMYl9s2TO4AG17GQCBnv9kTRqT8=;
        b=DhILKCyTgdPxmonGAAPnO8xu4XYo0AcsXJNYdhnEwjMQmYY5lg6BuAcLycsfGR8jB5
         TjJeb1jTmat6yJFB20spHJULdZ7Tiy7UigwZochLGqIJY1EjpLT4GflP5d+e1FkRPsY1
         MVIlUI9Bn7lXgQtL/kdrRaKFXZdCkOf67nsj8igMGTUjuRNnyeNEHJutokGLBDKhm13Z
         KpiHXNzd6/bCmqoXad/E8ZGREqJ3VjZDDOB6+9ILuscSQ0zc5cvwHOZ1NGfvPvIK7NTc
         1Am1Ay9GwqrDo8KKBmehQqk6ZtG3BfTQC8c3m65M/uAegJViEMoNuuc8AR8WEjuYEECq
         HRWg==
X-Forwarded-Encrypted: i=1; AL+hErEDumLbHvfYMTzWO/IDSCTEcPyXLloOYx98v3XHUvZ3dLep1O3P2rtk0zH5AIug30zVgyt96jcUUlg=@vger.kernel.org
X-Gm-Message-State: APuU4Z9gppHuoLl2eji7aWf1FM8+zYUcNKDWnckGhiz5q4grxp/e4wHI
	crS5N8gtq247qG/5h168I6RWPqpPWz2udumr6OImbuIjpBahPZynbZDU
X-Gm-Gg: AYBFou1DcaLcPzH2WivpJQe65DZt2CMVKRUl89H6Y0z5MqcvNcO8UwEYW/m8lllfJyi
	Ik1wImECRQyVhs3mB7dqL8KH9EwjWPKdGCUHIxUeNko0f0Vhho8kYhJV8+lJLaSP4vhIDwgSwBi
	/TfB45Kj4smzngE0Vvghdz2v3GR1WSnQhxSPllMQvfAeyBAgn8ZmZG27XjdnDsjDTnevAvMWU8G
	pG0fAG0ksnShuVkL6pDWU2fC8vpuEYiQk8aVq/ImWlULLVrrKjpQPOep788hec+s0MSi/uBH/5E
	bcs0c4P1KjQggn2BU6Wb1Flqmj09R7tAyoDM944GiyjHLuqKPoTu7eaWNvHXYvJY2pMbsQqZaB1
	BWpX5smdRRutTdzSfKPglVc+EgwIzWG3la04lYaOhGwMSM5wVbahrnAJlp0rZqQr3BIxLt7ysbZ
	ph8ElKwN+ECdfikssWVxvponZ84yq3/ntQTBXKOK3/15AjLacoTMvtom4OYmGSfBzqtkD6/eYro
	/t81eVh3ytA/4BY6PyfoTRUM/0bGmFVPLRI2ixGali0gTkZ8Gt4HoKVTeTlhsueUWIELZ+esnsA
	JjrKcV/xcazcpBucesijjOSmsVqBhl3tJFPmXKN76hQy/ZzYy8XHIkNs3qrs5gLQxluGIfHe5+P
	QA5Hxu5pgaOoZFupfpECSW4OtJ5DgMzYEnwqknhn0sd8r5pjOeM4XU7JvmjQLMO8fdivnMokCnr
	LA9BZZFgRbrSA4VWrd5QZU4dEWsw8vH2VrYO3GQob0og==
X-Received: by 2002:a05:693c:6383:20b0:37a:c882:994f with SMTP id 5a478bee46e88-37ac891df02mr10019522eec.9.1794908865256;
        Tue, 17 Nov 2026 01:47:45 -0800 (PST)
Received: from kapoor.iiserb.ac.in ([203.18.51.239])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37955a1c5c2sm42259413eec.14.2026.11.17.01.47.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 01:47:44 -0800 (PST)
From: Arnav Kapoor <kapoorarnav43@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Gwendal Grignou <gwendal@chromium.org>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Arnav Kapoor <kapoorarnav43@gmail.com>
Subject: [PATCH] MAINTAINERS: add a reviewer entry for the Semtech SX9xxx proximity drivers
Date: Tue, 17 Nov 2026 15:17:35 +0530
Message-ID: <20261117094737.15253-1-kapoorarnav43@gmail.com>
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

The Semtech SX9310, SX9324, SX9360 and SX9500 proximity sensor drivers
and the shared sx_common code have no MAINTAINERS entry, so
get_maintainer.pl only lists the IIO maintainers and reviewers for them.

Add an entry with me as reviewer. There is no M: line, so maintenance
falls back to the IIO subsystem entry, as Jonathan suggested.

Link: https://lore.kernel.org/all/20261117031830.69ac22f5@jic23-hlaptop/
Signed-off-by: Arnav Kapoor <kapoorarnav43@gmail.com>
---
As discussed on the SX9310/SX9360 gain series:
https://lore.kernel.org/all/20261117031830.69ac22f5@jic23-hlaptop/
Gwendal, if you'd like to be listed too, I'm happy to add you in a v2.

 MAINTAINERS | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0017755f593b..fdc5004df348 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -25448,6 +25448,20 @@ F:	include/uapi/linux/selinux_netlink.h
 F:	scripts/selinux/
 F:	security/selinux/
 
+SEMTECH SX9XXX PROXIMITY SENSOR DRIVERS
+R:	Arnav Kapoor <kapoorarnav43@gmail.com>
+L:	linux-iio@vger.kernel.org
+F:	Documentation/devicetree/bindings/iio/proximity/semtech,sx9310.yaml
+F:	Documentation/devicetree/bindings/iio/proximity/semtech,sx9324.yaml
+F:	Documentation/devicetree/bindings/iio/proximity/semtech,sx9360.yaml
+F:	Documentation/devicetree/bindings/iio/proximity/semtech,sx9500.yaml
+F:	drivers/iio/proximity/sx9310.c
+F:	drivers/iio/proximity/sx9324.c
+F:	drivers/iio/proximity/sx9360.c
+F:	drivers/iio/proximity/sx9500.c
+F:	drivers/iio/proximity/sx_common.c
+F:	drivers/iio/proximity/sx_common.h
+
 SENSABLE PHANTOM
 M:	Jiri Slaby <jirislaby@kernel.org>
 S:	Maintained

base-commit: 20ce8ef9c9e04cd6c5ae0422e251a9b5936c6b7c
-- 
2.53.0

