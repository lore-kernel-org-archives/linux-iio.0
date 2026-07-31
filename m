Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B4C36D9E7
	for <linux-iio@vger.kernel.org>; Fri, 31 Jul 2026 21:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785533969; cv=none; b=SZya8dOyqpmg1XoKqrW7D1Dkap/vuRHyLVkH3YEvnsGy27uhkA1+ukf6YRZm/SOXylx703T3TBU+9ONjUQEKnflrnKDvrjt77zf3fjRx17oXzmD4fCYxNl2eC+z/SZV/o/isPgW+/CP0zGofN3IgZwMfx5VRcQgsPNzWmGke7Ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785533969; c=relaxed/simple;
	bh=JA4kOe5Ua+bUiA71v4zf0cTXbC4soPizmuWTSI/8zp0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sHc15a6R75Se4moLd7pZdz2o5WRKzwkPdxBzw8BuqGs6cU3jzPY0k2GNhAqd1qogR2Gm0+mOTseM1cSTBqgEP+uZ+Bn+0a29B0UZImb339lE5n9abVjEwhNjVNJhmIgLhvyoqRSu7mh4g7mQFWh91p37tc1YfUzlS5rQcfaFJAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=maxwelld.cc; spf=pass smtp.mailfrom=maxwelld.cc; dkim=pass (2048-bit key) header.d=maxwelld.cc header.i=@maxwelld.cc header.b=Ipq/VBmJ; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=fr9jk4mz; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=maxwelld.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maxwelld.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maxwelld.cc header.i=@maxwelld.cc header.b="Ipq/VBmJ";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="fr9jk4mz"
DKIM-Signature: a=rsa-sha256; b=Ipq/VBmJvBlTssL/62oywX95HiyoGjUOp4G7weYG/FAenQsKBzSx5Pxpt/mWPXRk5PInafZsJcM8nMmsroAwIifTGhiws9nLYBDZOfnQnqyrU6xO/6x0zCjt7bh1MuC6xq16CvnJV2TayTCUa2++dhsBwqc0uNg+kw2lwlKeKK7AkC8dpWO20L8R9SCXbyTu/wR/gY4qC/CJemAkIKIEF9WdM2QXrjS5JUI9pM/27mmwj4JAp/+GA/XNe8Axe/GN4Wi7h6Q1JBXGKhl879crJvGgb3yVkiww5Ot6rVVWASMeWYc+ipekR9MhadwrG+OdILrO8O6z01zRXACA93E4gA==; s=purelymail1; d=maxwelld.cc; v=1; bh=JA4kOe5Ua+bUiA71v4zf0cTXbC4soPizmuWTSI/8zp0=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=fr9jk4mz5IQVeSO4evyOhWK9zjQN9SGq5oR3fjqAS+o33mj1f8b7ZyzYZ6Bl4cda20ArvSVRZt0h3v3+sIblREmarxG6CiIXasCKDwEavS4sy2MX/l+zk8w0SidxNb+3K6wyMsYbnNWD0wucwwiPBKkM+byMwwet25bzH7KIHSSz5mOq1Qrc2IflHjb0WINzXX/hHEoSSmlh/tXKCYqdc/3HP2vID3vR+/5W2rNf1c7KC4H075KNlEan8Vo7N4Vb9aIlromFa3Q2IGgNxQzhFsi47dPwzPIyBnNTM3qG+Rku3gbI4KCEJt9gjyDGFdswg42IL/2fdkxmfpUl0yM2+g==; s=purelymail1; d=purelymail.com; v=1; bh=JA4kOe5Ua+bUiA71v4zf0cTXbC4soPizmuWTSI/8zp0=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 1013395:40550:null:purelymail
X-Pm-Original-To: linux-iio@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 2117880580;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Fri, 31 Jul 2026 21:39:12 +0000 (UTC)
From: Maxwell Doose <maxwell@maxwelld.cc>
To: jic23@kernel.org
Cc: Tomasz Duszynski <tduszyns@gmail.com>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-kernel@vger.kernel.org (open list),
	linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND DRIVERS),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS)
Subject: [PATCH v2] iio: Update email for Maxwell Doose
Date: Fri, 31 Jul 2026 16:39:11 -0500
Message-ID: <20260731213911.444306-1-maxwell@maxwelld.cc>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail
Content-Type: text/plain; charset=UTF-8

I'm transitioning to a new email, add mapping and update MAINTAINERS
entries to keep email up to date.

Signed-off-by: Maxwell Doose <maxwell@maxwelld.cc>
---
v2:
 - Squash commits (Krzysztof and Jonathan)
---
 .mailmap                                                        | 1 +
 .../devicetree/bindings/iio/chemical/sensirion,scd30.yaml       | 2 +-
 MAINTAINERS                                                     | 2 +-
 3 files changed, 3 insertions(+), 2 deletions(-)

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
diff --git a/Documentation/devicetree/bindings/iio/chemical/sensirion,scd30=
.yaml b/Documentation/devicetree/bindings/iio/chemical/sensirion,scd30.yaml
index 25291bda1a8b..ea0e72f2a690 100644
--- a/Documentation/devicetree/bindings/iio/chemical/sensirion,scd30.yaml
+++ b/Documentation/devicetree/bindings/iio/chemical/sensirion,scd30.yaml
@@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Sensirion SCD30 carbon dioxide sensor
=20
 maintainers:
-  - Maxwell Doose <m32285159@gmail.com>
+  - Maxwell Doose <maxwell@maxwelld.cc>
   - Tomasz Duszynski <tduszyns@gmail.com>
=20
 description: |
diff --git a/MAINTAINERS b/MAINTAINERS
index 2b1ec46c5919..e13186b67c58 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -24549,7 +24549,7 @@ F:=09Documentation/devicetree/bindings/iio/chemical=
/senseair,sunrise.yaml
 F:=09drivers/iio/chemical/sunrise_co2.c
=20
 SENSIRION SCD30 CARBON DIOXIDE SENSOR DRIVER
-M:=09Maxwell Doose <m32285159@gmail.com>
+M:=09Maxwell Doose <maxwell@maxwelld.cc>
 M:=09Tomasz Duszynski <tduszyns@gmail.com>
 S:=09Maintained
 F:=09Documentation/devicetree/bindings/iio/chemical/sensirion,scd30.yaml
--=20
2.55.0

