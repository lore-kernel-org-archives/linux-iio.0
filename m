Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795821749;
	b=vsdV+GzcqNauT6nlXMM0bHXmSFJ9IyEdS+FVTSSIEJ70taaJw5TMNz3qnh9lc5oOhwEj
	 V7qEPuyAlgHLFfMYbCLQQZj6u9vABGTFJhPd/PUkv0KqEizqiwc6I2O1WQWeG4U3sSabS
	 1Np7aKy4XzWOK2We6A03DV8UzSrMPidIOpPAZdytQei25n9khGK3jeu224B1V8FXIqDtx
	 ZDSIFPr1Jg1LS1ON7q6ZFhGUra/miYMTq2Fr+rKJ5moAsDw7XdXnEaD5yiKttR+GRgTJh
	 m6lJN69J+czgdDBsM45ZyNhgr+KHFHdeFXZfIfwANTOD0vX82xBoRsd+ZU+IQiJFYNQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795821749;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=XfKxPg9R4n+fm7ov4vSKe0tvTmGYA8ZHDNQOJkWyL2Y=;
	b=TTk4WRdbCODEz1dfmw5DfkvFmrnSzMs6AqkUK0pPHKF9nB+v2Q/SD2bXvv9kuIaC+9Xn
	 tNLbl+4f/9p/6qT8URU/ot5EVnJM4xASTjK+KlHmd9TjV/hxLSUsorf/YzClobxNZQlBC
	 fz2zjkW4ruK1OqFve9oM52nWF1XIbPWfGyv9+B/8SY3zMreAMFcLRci1cORbu5XvBXJsM
	 ttkTDoz+DDXOtREagxk4o+kcqlP2RKCIbG+jQH+sR0IgoqoNs9HDSD/9SVIYF+OH8KQlm
	 s44v3GwC/NjjIpGt+ra5GTCfhkEyn+6N1xRG2X2Y1MorWtFeb63iaVQ7gTdpgAcveLA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hcgLm4VU;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B5A606A31C;
	Fri, 27 Nov 2026 23:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hcgLm4VU
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795821748;
	b=GrS7wWGoQFiDtQXJsI7yTqBL7M/aZaoH8DRgDBY1I4P10OGzkVf5P7ChsSOD6QCbkXWZ
	 LvGffT7wnHq/z3mNXiJmETmHEQdUwgAC1BHToecqXXEqhQ5nrY5g4k6S6JOdPgm+60tX2
	 NwVpWkOAD5bV3JPGfU1O/i1D1DKlwGvdDtZsan1G2NP7WYQfntG8E06v9bSOHNLpZICdU
	 LxrtobzTzgGSn6bt69rZQ1LFudUUpxVIxOsJGDBgOHxgOz5CiElAhWWCFO+p+sdvQ54Lb
	 dNjSOVmWvymJf33cMCuWCmqcHckRj09iq25BoMcJ7lbj4Fj2tjOLBa+vOjM+olCj/UQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795821748;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=XfKxPg9R4n+fm7ov4vSKe0tvTmGYA8ZHDNQOJkWyL2Y=;
	b=jWC0510zuwDbDiMpOBE3bS4ET+6LgLX1q4KswRJr6Fk4gjx8lvJiWMCrgCmFbfJ2cN5w
	 JRRaZmKGO2IAjKmdAIdZfvGIcTIUVh09FOYIQnjFCMSoZObdxndRVmcWNdsa7CneS41Rj
	 yX6UBOHlgFhxdrIDChPAySzP5ZsnSo3Su6prYSUcFAySvGfrfgZfGlSgPcfZ/AS/YOjgh
	 kLaj63Nt4RFAWMvcJCF588gUrQEIhNcu4N7LQ2UfGXfIJGpBJsarpiuqXxs3Gv9TZK+AQ
	 j6uujiaM5DNhTwu5sZq3V1rg921eA9CV4lA4oQfK/6x5M3D2VIOtQABOCSQmWeMuYHw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 0BB201F000C1;
	Fri, 27 Nov 2026 23:22:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795821748;
	bh=XfKxPg9R4n+fm7ov4vSKe0tvTmGYA8ZHDNQOJkWyL2Y=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=hcgLm4VUdDCUhLkKHew/iScOcPa4uMWmQUKeYXLW5ed1K3n2L1u+cNMJVwU5fHmxf
	 ZdnbosC4m4CZVDFOkYQQv6oIHQMgbU8cn15TRXApgriVcwNa1aNZGCkehHmHxNOO6X
	 QGHHFBq0tOE7b/8y0eK+8mRPj3d7c17miBh0O3Pr3QzbTNSEB94Vfme7skAzTdguCM
	 j0IeCc5yODB6si1AtOml4YZzB9GoSQQ8hlILB7o8r9WGyLLcmBysqrLR8Kl+OkDa5n
	 9mqFnlDfLwbdeoQjB6ogSM+BH4pVu1Gid+4QEcpmlicCjDYV2qMFni+mwcKVBio8R/
	 WXRFjUkT2jELg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 7C0D94DE76;
	Fri, 27 Nov 2026 23:22:26 +0000 (UTC)
From: Fabio Forni via B4 Relay <devnull+development.redaril.me@kernel.org>
Subject: [PATCH v2 0/2] iio: afe: rescale: Get driver data using
 platform_get_match_data()
Date: Sat, 28 Nov 2026 00:22:08 +0100
Message-Id: <20261128-iio_rescale_platform_ids-v2-0-4c35f16c4f77@redaril.me>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAA/43NQQqDMBBA0auEWZuSCVKrq95DRIZkrANqZCLSI
 t691BN0+xfvH5BZhTM05gDlXbKkBRrjCwNhpOXFViI0Brzzd3TuYUVSr5wDTdyvE21D0rmXmK2
 LnqpIoa5KgsLAqjzI+6LbrjAwSt6Sfq7Tjr/6B7qjReuwHjBgWTrvn8qRVKbbzNCd5/kF5OXzM
 MEAAAA=
X-Change-ID: 20261008-iio_rescale_platform_ids-0d2a7dac974a
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 Johan Hovold <johan@kernel.org>, Peter Rosin <peda@lysator.liu.se>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: driver-core@lists.linux.dev, linux-kernel@vger.kernel.org, 
 linux-iio@vger.kernel.org, Fabio Forni <development@redaril.me>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1477;
 i=development@redaril.me; h=from:subject:message-id;
 bh=PBSXqgaqkOnXYBgeJ3eZjM3FUUbpqsbEEol5o21C8RY=;
 b=owGbwMvMwCXWeKho1tqFWemMp9WSGLK5BDYGOIhX22z/7WaSd0JtVqqBuj3bzVO603imL392k
 qt1Q4FgRykLgxgXg6yYIst/J6NN3WYmRrf6JWph5rAygQxh4OIUgIlsZGP4p2329/PqD0fsq3cX
 rEzefsbd+WPikT+5WVvP7m729AzsmsbI0Kl4YepSJ+4jaXZrp0r/iZRe6tSr4hQl9587Lzri/1s
 TZgA=
X-Developer-Key: i=development@redaril.me; a=openpgp;
 fpr=FF4232B28B363432DA8F187D81C2729AADA16A67
X-Endpoint-Received: by B4 Relay for development@redaril.me/default with
 auth_id=1033
X-Original-From: Fabio Forni <development@redaril.me>
Reply-To: development@redaril.me

Add a new helper to get data when drivers are bound using platform_device
plus swnodes, that typically happpens when such drivers are dynamically
instantiated.

As swnodes do not implement device_get_match_data(), a fallback mechanism
is needed to access driver_data inside platform_device_id structs. While
drivers can have such logic locally, Andy Shevchenko suggested to add a
global helper for this situation. See discussion in v1. 

v1 was about adding the logic above in iio-rescale: the same goal applies
to this revision. iio-rescale is modified to call the new
platform_get_match_data() helper.

Signed-off-by: Fabio Forni <development@redaril.me>
---
Changes in v2:
- Add platform_get_match_data()
- Use platform_get_match_data() in iio-rescale
- Use imperative mood throughout commits and cover letter
- Link to v1: https://lore.kernel.org/r/20261008-iio_rescale_platform_ids-v1-1-019f1c144022@redaril.me

---
Fabio Forni (2):
      drivers: core: platform: Add platform_get_match_data() helper
      iio: afe: iio-rescale: Add platform IDs

 drivers/base/platform.c         | 28 ++++++++++++++++++++++++++++
 drivers/iio/afe/iio-rescale.c   | 18 +++++++++++++++++-
 include/linux/platform_device.h |  2 ++
 3 files changed, 47 insertions(+), 1 deletion(-)
---
base-commit: 4dce97c6c265544342e716e62fd24bbb232590c5
change-id: 20261008-iio_rescale_platform_ids-0d2a7dac974a

Best regards,
-- 
Fabio Forni <development@redaril.me>


