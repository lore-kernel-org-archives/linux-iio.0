Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794899470;
	b=WPbjbAbnhYDWtcGxV4DqaPzPsxvRejH/yc7BlvhUYmFzY15uyeDLc5YoT3MB30S6/dUU
	 JNS0L7qn4VEnT+XyTLg3YyJnhw5fAoS/RX071JZCR97+oeSj7zvrGiii6SgAeivzEBB0X
	 a/e5mJorswujEP+SEwZsGbzdZSpmwvXUAP2D6cPw9c75W76b0ly5H9B5hK393bgI1s+ZI
	 uvmHZrLlrgyWsFI8ONYY/NLrXfSsq3YNOk4+6YgGbaVBBVOwVyY/79YqJ13e8hV6NAurJ
	 tx7ktoErKjbtQ7oHkkEfbpUNAjKMp30QW4ktc/vRxb3PtHxX1V6jmqfLYA/7l28nMYQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794899470;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=gjKSfnR41czAX7FnlXWF4qxIewRkv7yswZCJCCRHYG8=;
	b=kEKbaC8hl2QT08IXP0s3PZVRj0M6rH1sVUCfEMPbPdzoj4NWj3/CFM/7D5E0FJQnZ+Jb
	 cHfXJ97Kme4F8MoXhZIJNhu2j0mZUucraTVl0RMzyYH2NQ0ZN90/Ns1WmFK5TaqkoZr3/
	 fMhspK7VjEmWUxBHxAwxs+LnZt6qWFb4mRVIx62afr37qjZet4ouqWEg0eW1NFZJfgSER
	 k0vKnSDdZIdIYHOE4ri6stFISAf0BgaTIwBKgZ6gsvX3ta3605fnGhLcsFDNmndQP/P0D
	 IDaamzvTaiV9Z9WPreizNwgo0qZb/2v4+s5cRQbosrbYxms0Uq6Dg4TMctUFZfYTQiA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m8Dl3zXF;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43F24606A32C;
	Tue, 17 Nov 2026 07:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m8Dl3zXF
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794899464;
	b=1UtIkajGyXrju9oOuJ+yNLWpBmbse0XIUEt6bjrqez5huTqiTGv2alpGgQJq26PDpqS9
	 7JdzZmt+Er/+bOmudw+qLZwmUxWOsks3lGMdXLk6ke4qbZ5YxN6sE5sHdXdXKYTJ3DSjD
	 p5paLdUCqMrDcWCbO8N0O8ZjAV7K3DbKDBly0N0ad38EY3ZHP9SUvDsq0sPmrVknJ1JWm
	 R05xvZQjppuwh3EdPxxkj6XJ6Kw303O57s+Wf6o66++O1jE/cpDEl0V5S6Dlw39+s/4Vf
	 culYmOHHKrjXaAkdxhE2TBuR0+sbOQ++uqy80y7tewqDbRO4WclG2At34CB+jeo+sXw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794899464;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=gjKSfnR41czAX7FnlXWF4qxIewRkv7yswZCJCCRHYG8=;
	b=GbxIMJI6/08ASFrOaE1dOCJxT21WSIjFV3Xz3QsLhgg4fKOlD6e8K4sphdjpok0G8WTU
	 jKCwuXhM2NToOjlwe7wOXCAZc/39fGO3ozwrNPS6A520DVBOcIIJ1uxVMOZO5IpODhzFV
	 BIB+wapBEs38lhFBxIpVptx5bw+GzEadCGqwSAwUV8W+KwFK+Y4Ex2l8UXBjZPOGEDmrQ
	 0rvDuIELRUS/eVAWwEcW3Vq0Qr7aqWPE2phcIvgjBkwFFXs8eWhScfpfKH4209ZYK4Xtc
	 eZuXFTMTGXkOaUJeZWJh+awCHSxSEspEVj8GGeXEMt5BgYjo7Dilrne7VRKKjXxwlNA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 2ED401F000C4;
	Tue, 17 Nov 2026 07:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794899464;
	bh=gjKSfnR41czAX7FnlXWF4qxIewRkv7yswZCJCCRHYG8=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=m8Dl3zXFQyAPaF5FmmzK8gS7ofQf+LPGEu4F/diq1SqrbCIDxWtMnT5xj84V/bok5
	 kEfYBF/UAMSogCF3khoyulqmUN/16lSyuzddka0zDZbu3YUI4N00RucNyMoSDEtsH1
	 2sNeWUbwOJr1k31ho1oXkzg7u1G9iTzIXaFtQgYx9lYgNJYoStafflgyAzHQ0dd960
	 sjdSn0HczPrPI10mmZPoZek298OhoH3q+8I/zB4QilXE8tw+bFC2lQDNQQMOhC1I0z
	 v38UFFyuRf/D+z7+zoPZB3l58VRPlT/gpUbmebHRNpLhpWbr3+muW3r2jB7wNKaxg8
	 49Yy4wHEBbKcQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id A00094A70A;
	Tue, 17 Nov 2026 07:11:03 +0000 (UTC)
From: Raffaele Tranfaglia via B4 Relay <devnull+raffaele.tranfaglia.gmail.com@kernel.org>
Subject: [PATCH v2 0/2] iio: light: adux1020: guard() conversion and
 follow-up cleanup
Date: Tue, 17 Nov 2026 07:11:00 +0000
Message-Id: <20261117-adux1020-guard-v2-0-89707fa070c9@gmail.com>
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
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WNQQ6CMBBFr0JmbU2noBZW3sOwKO0AY4SaFgiGc
 HcB1y5f8v77C0QKTBGKZIFAE0f2/QbqlIBtTd+QYLcxKKmuiFIL48YZpZKiGU1wItVKWrrlmc5
 S2EbvQDXPR/BR/jiO1ZPssFd2o+U4+PA5Hifcvb/xCQUKV+X2olWNRObedIZfZ+s7KNd1/QJXm
 FzevgAAAA==
X-Change-ID: 20261108-adux1020-guard-3820ce794843
To: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux@analog.com, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Raffaele Tranfaglia <raffaele.tranfaglia@gmail.com>, 
 Joshua Crofts <crofts@kernel.org>, 
 Andy Shevchenko <andriy.shevchenko@intel.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794899463; l=1513;
 i=raffaele.tranfaglia@gmail.com; s=20261011; h=from:subject:message-id;
 bh=8fhMW5mm0iEr5bWCoFt/XsKE4zlSiXDS51NkKQm5AEo=;
 b=3vJ+8ilR+BrxEexRFvic6Ry2GRChnC/YBYJimlZz6hIONX0l+nL2BybrWml2IJUEryhP/XrTw
 qauGYSVybpKDBEylSQYSxzRkLuIZYWPLnFwJBpnV9W4vaus54XhIA5h
X-Developer-Key: i=raffaele.tranfaglia@gmail.com; a=ed25519;
 pk=mweuSGNM6vguCTdqa+aiHwMXdgk70suj2wolzCp6XGM=
X-Endpoint-Received: by B4 Relay for raffaele.tranfaglia@gmail.com/20261011
 with auth_id=1160
X-Original-From: Raffaele Tranfaglia <raffaele.tranfaglia@gmail.com>
Reply-To: raffaele.tranfaglia@gmail.com

Patch 1 converts the driver to guard(mutex), as Jonathan suggested
when applying the sampling frequency hardening patch. Patch 2 uses the
direct returns this allows to flatten the channel type checks in
adux1020_read_raw() and adux1020_write_raw().

Tested on arm64 QEMU with i2c-stub and lockdep enabled: reading and
writing the sampling frequency (valid and invalid values), reading the
LED current, reading in_proximity_raw and enabling the threshold
event. No lockdep warnings and no hangs after the error paths.

I prepared these patches with the help of an AI coding assistant, and
reviewed and tested them myself.

Signed-off-by: Raffaele Tranfaglia <raffaele.tranfaglia@gmail.com>
---
Changes in v2:
- Drop the unreferenced Link tag (Andy)
- Move ret to the end of the declarations in adux1020_read_raw() (Andy)
- New patch 2: return early on unsupported channel types instead of
  nesting (Jonathan)
- Link to v1: https://patch.msgid.link/20261108-adux1020-guard-v1-1-db9c582f1eea@gmail.com

---
Raffaele Tranfaglia (2):
      iio: light: adux1020: use guard() to simplify lock handling
      iio: light: adux1020: return early on unsupported channel types

 drivers/iio/light/adux1020.c | 189 ++++++++++++++++++-------------------------
 1 file changed, 77 insertions(+), 112 deletions(-)
---
base-commit: d922ed738439e1d5b4701df7f4cdd49a09925624
change-id: 20261108-adux1020-guard-3820ce794843

Best regards,
--  
Raffaele Tranfaglia <raffaele.tranfaglia@gmail.com>


