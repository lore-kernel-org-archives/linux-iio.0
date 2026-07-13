Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E87395ACF
	for <linux-iio@vger.kernel.org>; Mon, 13 Jul 2026 22:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783981870; cv=none; b=FxEIMGXhN0Mzol6Yu/XOIFPJ3DTD+ygdMlmwdhLsc3weSBrgIiP2+NPBb5/Sx0RFnrkdVhjJTbqoYKsSdWmIxJk0f4ts6bVhZeFkM84t3QZMzuGxpbqXmVicaAr7It349eQgdsQavvqu97wawODTpfrGO97GoVCxDL6WZ/ZqSLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783981870; c=relaxed/simple;
	bh=PxcfBtE18cB+FZRyyTPPylX3pAFKS4n9eY+bIDx39JY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VFU40l6cnMGmckKoGgCfA8Re0whMh4KJ3a2egSlUq+P+75APbuRTKL+vLdYkf7TSSI+rBpa4IuJ3GnnRPJ0KCFxn34MzSMsiOwHCcASM8iCNJM10nTgQBq1pyAVLMSmmzquFx2Qx2288vJ4TjuK2jg0LPJ1z3Q7adBjN2th7U10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=maxwelld.cc; spf=pass smtp.mailfrom=maxwelld.cc; dkim=pass (2048-bit key) header.d=maxwelld.cc header.i=@maxwelld.cc header.b=MOi31hEJ; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=XMS0uSMG; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=maxwelld.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maxwelld.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maxwelld.cc header.i=@maxwelld.cc header.b="MOi31hEJ";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="XMS0uSMG"
DKIM-Signature: a=rsa-sha256; b=MOi31hEJglG9vpydN2IQE8cQLTu63kHI1gHrirQyfFS02Gr8iz6C8CrmPxQAHjrAgX16ZzQwfyw4cnhQOkr+bFn681FrJK+WLxxLOzFojst6Ffi08r5+xhgASsJfM7RrUG+J/kmck2DGgK/ZcZjiHaZcpc3pSwHTSTPLA/BqELgtO6ycyMURZEbnbtns15Yxg3J9AQYoPrtp9Nq2bCwQ5LrKrJ4ewGduNGpX8IDQaB4sZK5z6agX4WPs5nz6AeQhcfP+sWe8Od2qAzwu+WFqw6T5lv+8sfyUMWXWtlu5bYL/Np4nHTV7+1Hw8lhgkE0yScDOOD9C0CewZ/8bImyZEg==; s=purelymail1; d=maxwelld.cc; v=1; bh=PxcfBtE18cB+FZRyyTPPylX3pAFKS4n9eY+bIDx39JY=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=XMS0uSMGfi97/mxMAE1N6sl0u3Z2sdoyJmHXIQJyohHAN2D3TyUmq9kvfhldo+c+zN2guiVD+OJr8wejtrhBCGewRRmRODZsI9QMyzE8FuYixl1hWD56w2VQ51lsSollULSa9PJOg8kntEGZCvgycB7021a5w4nT2Wn6CWU0PWyaH47PQpt3rYsu7MgDYw1ny/GBFFRnu/lxMIrGfd7h3UMoltF6OEeH7JN6UloWRdGRHhXq1xEzDDzDLnuUIRR4ZwSWuJDalTDDXoayA+qZt1XVTjqrOztOdn8bPBSrd6zJSP/jczgQwV+A0SBbn96FJudsAgj1xoviSHn2oOyHbQ==; s=purelymail1; d=purelymail.com; v=1; bh=PxcfBtE18cB+FZRyyTPPylX3pAFKS4n9eY+bIDx39JY=; h=Feedback-ID:Received:From:To:Subject:Date;
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
Subject: [PATCH 2/3] MAINTAINERS: update email for Maxwell Doose
Date: Mon, 13 Jul 2026 17:30:45 -0500
Message-ID: <20260713223046.20779-3-maxwell@maxwelld.cc>
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

Update MAINTAINERS entry as I am transitioning to a new email.

Signed-off-by: Maxwell Doose <maxwell@maxwelld.cc>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

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

