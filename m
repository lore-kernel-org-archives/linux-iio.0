Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC3839448F
	for <linux-iio@vger.kernel.org>; Mon, 13 Jul 2026 22:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783981869; cv=none; b=IqAtGD44Mn7RTCnmBeCRKi0mLnpjaMn59zDTCdfGVrN/pQ1oIFmytw4TtRmy0/HfboE3rRSbEGAnuFoEYP0Sajs8mfWpWcVYHxQEjdh1e+3Qf9IoX7kAMVokpn/Y9CiWiu28BsugsvFXO914ojyfyP4VTya/O75blhIKfEhmdN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783981869; c=relaxed/simple;
	bh=AwvhgsS0DWecN/QZuyMOzZXKUR9SR9VzTCVsECVHm5A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u9lJrh1YWrEefoXiKYYAPtYBCsVej6B3McoL2O8Q+xSU5wgtJ0sioIgVjDEEVGVPIbVO/Vu52FNDmS9y270hjF02qDs8AA5lUtn1A41/OwZ5sLtPR02k9AWy9kTdJRWPjnTjyqYRU7d+NfEa5Ln2IeiamIxtqEV+uHrcR9q6yso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=maxwelld.cc; spf=pass smtp.mailfrom=maxwelld.cc; dkim=pass (2048-bit key) header.d=maxwelld.cc header.i=@maxwelld.cc header.b=IuVwiO45; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=RJwR7gGG; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=maxwelld.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maxwelld.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maxwelld.cc header.i=@maxwelld.cc header.b="IuVwiO45";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="RJwR7gGG"
DKIM-Signature: a=rsa-sha256; b=IuVwiO45+iyOZQpp8KTZOc1TaKfsv7mkMknIuxVMOrHazJ99jFRtN8pLpFpl6B4TTWcFnI3J/YZtJ0kpHAP4zM7r9vCK/hSDtXhkxi9sZE1X9Hzz/hGPN6kTNPpBW6U1j3cqJfo3lhuWE/x1rMhwkT9t4lgauj5At4NgrMt/h3tS/K6etKyIRAPb6bSO8DRkTR/DuyLN5m21llX46jla6F3hRr86T1ERPs8GW6xvTRu2SBEe4JRtH4soFiLf6wcw23qz9jNDZmE0LOOK7wO365IZOJD0S+Rd72txeTdYfs4vZC3Tif4wezKZII/GvbXuY6BmlAj4Xxv5aWCMdLLLNg==; s=purelymail1; d=maxwelld.cc; v=1; bh=AwvhgsS0DWecN/QZuyMOzZXKUR9SR9VzTCVsECVHm5A=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=RJwR7gGGQBTTK+fh1VNNK42XD0xEdpx8pVDtDU/vqCR7WQEwpx4e85phIwzXBEGK3b96SbRmAgQNVs8S0k+tLfRMy6GmjrxpOrPqKot2R+Am466iZNSusBGbpMG1qzcsFuR49k1JoXMC6d2E6Q6/jVZswd+uePgfxDBmAJJRRjVe39IrKq9vZODNPe8n7COaSACxS/7/kqXmvrWuUp505hBesBwNJH7zuAUzxwokkXBR/0qGFrt/z5V3TQLNP2FtY+NP6jcxwRFwHjxQ825KrZ54mOjejXAqDTgOPg0W/Z3dN9aVIAmPhzzNie+oMhz4eANUHfP+1VKfVYYQ3Kn/+A==; s=purelymail1; d=purelymail.com; v=1; bh=AwvhgsS0DWecN/QZuyMOzZXKUR9SR9VzTCVsECVHm5A=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 1013395:40550:null:purelymail
X-Pm-Original-To: linux-iio@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -21516782;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Mon, 13 Jul 2026 22:30:48 +0000 (UTC)
From: Maxwell Doose <maxwell@maxwelld.cc>
To: Tomasz Duszynski <tduszyns@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?=27Nuno=20S=C3=A1=27?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: [PATCH 3/3] dt-bindings: iio: chemical: sensirion,scd30: update email entry
Date: Mon, 13 Jul 2026 17:30:46 -0500
Message-ID: <20260713223046.20779-4-maxwell@maxwelld.cc>
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

Update listed maintainer entry as I am transitioning to a new email.

Signed-off-by: Maxwell Doose <maxwell@maxwelld.cc>
---
 .../devicetree/bindings/iio/chemical/sensirion,scd30.yaml       | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

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
--=20
2.55.0

