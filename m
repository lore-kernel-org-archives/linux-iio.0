Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99641393DCD
	for <linux-iio@vger.kernel.org>; Mon, 13 Jul 2026 22:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783981871; cv=none; b=PZfACjrtzkBJHQNkQNXt2RiHGodn90hzAYeJPTksj7gGUa+Q3OR8Z5t8XIZeBMFwmDgwMCIPI5xGZpkhlqS6nU5PpqzzR0FmbK1VVG+6SiXeEcKYHBX40FUyiIbS5iSCX1WLHJEo3qwBoJk2NCRj7hZJSDCSmB1WFxrjgra6WxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783981871; c=relaxed/simple;
	bh=60BTcnmNPlpWwpmVVLsBDeDGOKUQEyaGzD/IqQQ2aNY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GeLRRc3IyNAOgH16stoYxOSEiBhJpEVsUab5PdQDeApRKvlG0mzDIqzlxl49SJPdYMqD9D07y8n5PGT9fa35Osvr7kDxpoOAd5FXXGEWl23kh12L29JTKHHrEefWmlcj4Nxw8K5B3CVYwyrz9nSmlPYZ3c5vyAZBttEd4EuBvBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=maxwelld.cc; spf=pass smtp.mailfrom=maxwelld.cc; dkim=pass (2048-bit key) header.d=maxwelld.cc header.i=@maxwelld.cc header.b=JY6Vf3Pu; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=YSUcY2I3; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=maxwelld.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maxwelld.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maxwelld.cc header.i=@maxwelld.cc header.b="JY6Vf3Pu";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="YSUcY2I3"
DKIM-Signature: a=rsa-sha256; b=JY6Vf3PuCXC97k7QYz4WwVnv+uk8oo6QKeI4Z63BEB+bZZbLAj1aA7KUsS+ydy1ZRiNOgmNOGjpnuaObUZ99AzMbrHZEE5cze5expsUCm2YB4N4yJhENjSnBU5tbcqGo7zQaui6nPlS+zUeKstEAbc0SlspEXbN68f4oHs8sNCscs1Eo4AT7E3vIr+6X6iPYpCxqjrefP24Bo1jJgvdkl1Yorwts6hiG/C7Zu03Mf1F2BaE/OuTN19YnbqyplgYzKn9LWoQeoLVFIhjqmlHSQABssaa6P/E4s+o3Jn+XpgIM7xkhnxnc7IfyxoRVdWiPP+oXlkOnlDFpu7bbK3waiA==; s=purelymail1; d=maxwelld.cc; v=1; bh=60BTcnmNPlpWwpmVVLsBDeDGOKUQEyaGzD/IqQQ2aNY=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=YSUcY2I3x6HhZRxHpchce4MMSlwthGHGeEwXIzwDL9oLk5MVHQTrtfzDhulRRBMIh/yRyP68Xje6Sz1cnz95h390y1XMo53EMUXQo3Of6OJPoWrVDKhuYX9Tbx35hhvfSttEBzAcXo71yNyHsRTD6tHES+AIWwZcrV1vByHfu711W8t76CotzIp80koUVUbGdUyzURB6h5DZUyZhDAlWIjMgXLBXSvstOkz0Ay58CzxfCpLS7mtvIh/v+8C1v4kepeYKlLHfYAmc6CE+RyZTR2uSJOt8503ug29V0FkWKbTNgZE58L0QCvLYlbdoxtDwT9eMVFDPYtYXYDGZobHQNg==; s=purelymail1; d=purelymail.com; v=1; bh=60BTcnmNPlpWwpmVVLsBDeDGOKUQEyaGzD/IqQQ2aNY=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 1013395:40550:null:purelymail
X-Pm-Original-To: linux-iio@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -21516782;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Mon, 13 Jul 2026 22:30:47 +0000 (UTC)
From: Maxwell Doose <maxwell@maxwelld.cc>
To: Tomasz Duszynski <tduszyns@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?=27Nuno=20S=C3=A1=27?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: [PATCH 1/3] mailmap: add email mapping
Date: Mon, 13 Jul 2026 17:30:44 -0500
Message-ID: <20260713223046.20779-2-maxwell@maxwelld.cc>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260713223046.20779-1-maxwell@maxwelld.cc>
References: <20260713223046.20779-1-maxwell@maxwelld.cc>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail
Content-Type: text/plain; charset=UTF-8

I'm transitioning to a new email, add mapping to keep email up to date.

Signed-off-by: Maxwell Doose <maxwell@maxwelld.cc>
---
 .mailmap | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.mailmap b/.mailmap
index 2b09883a19d6..5261076e32b4 100644
--- a/.mailmap
+++ b/.mailmap
@@ -589,6 +589,7 @@ Maxim Mikityanskiy <maxtram95@gmail.com> <maximmi@nvidi=
a.com>
 Maxime Ripard <mripard@kernel.org> <maxime@cerno.tech>
 Maxime Ripard <mripard@kernel.org> <maxime.ripard@bootlin.com>
 Maxime Ripard <mripard@kernel.org> <maxime.ripard@free-electrons.com>
+Maxwell Doose <maxwell@maxwelld.cc> <m32285159@gmail.com>
 Maya Erez <quic_merez@quicinc.com> <merez@codeaurora.org>
 Mayuresh Janorkar <mayur@ti.com>
 Md Sadre Alam <quic_mdalam@quicinc.com> <mdalam@codeaurora.org>
--=20
2.55.0

