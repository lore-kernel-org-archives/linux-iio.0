Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE3D476069;
	Wed, 22 Jul 2026 15:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784735458; cv=none; b=j8LnTGHWBp6eC+WJaZeKBVI5iu9gxAy/43qTOMoMGynjro07AKcrVvj2W1G2scsx366OqHAPFyw4ud842UdAw+2F4LLiDkVhhdPm53PgLf5DZ3ccLOp+0IWi0xaiZzrXsbynbZzwalL7cBHcxuOmwCuCm0t+sWDthrNleIuCSg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784735458; c=relaxed/simple;
	bh=LkGR2S/oFgI/+IPKjfMY0lgtsj7hpBpubbqxfDZIpLs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MhBV0Sytjm12mh7nimMXiJxYmTGWiTsMSNVj2ocvrvC6l3KZHfAzLTxxbBYj1ZPBJCZzH7qe+Qw4BEM013pW3NbvHg1RRC74we29Q6vcP5XXgH7i143cBmPpMEi6kOuEzXSUPA9dxBCduW4UU3WOg6xb/To8lpq36Yx0BdGw7m0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eyhPE0jX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eyhPE0jX"
Received: by smtp.kernel.org (Postfix) with ESMTPS id ECC88C2BCFD;
	Wed, 22 Jul 2026 15:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1784735458;
	bh=LkGR2S/oFgI/+IPKjfMY0lgtsj7hpBpubbqxfDZIpLs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=eyhPE0jXjUaPyXTYnIm0Xnf1ps4+yXfpVjmhiqePLx12VHPQTkJfrA8zss6u0IuH2
	 BY5Ezo0gIZ8kht55xoSCkctoCH7nBsdxqkwFqSDd5xb1BN96CDviX1ZslKiu40Sh1z
	 Kn9zpb8c5coMlJ9f7CeI0x6iKNQFLxnEZKIN91OIhDBuFjIIL8nV1EXixqRBMS95PU
	 CaGKToU6eye7krlyujA+h4agnKfXvxViqpAx4w+5dSeCqyVatnh7zzL6IcTyAFwA72
	 letaJmv+P1oUIZ384egvXolDNgVYoLOHPhUi640h1NScEj5+JZWFhxz15wcERgbU9v
	 uQYcMwyalKurQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2DF1C44539;
	Wed, 22 Jul 2026 15:50:57 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Wed, 22 Jul 2026 16:50:13 +0100
Subject: [PATCH v9 04/17] iio: add IIO_FREQUENCY channel type
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260722-ad9910-iio-driver-v9-4-459d1df5ac56@analog.com>
References: <20260722-ad9910-iio-driver-v9-0-459d1df5ac56@analog.com>
In-Reply-To: <20260722-ad9910-iio-driver-v9-0-459d1df5ac56@analog.com>
To: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-hardening@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 Rodrigo Alencar <rodrigo.alencar@analog.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784735456; l=1881;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=1IPBIAnpoq77uH/f9ncnZ8sog7Fcx5CLyDe5QVK2WqI=;
 b=cnrEDLZ2SbIQgytYCsLM95oa3NsRNdyWC7v1TuQ2RgwlQH2uNF51Yz9unZVFi64HAU/spwo5a
 mnQo8TQ+yCXCtLpxuKURLM7o/GXgos2e68GEuwmtZ9sJckum6i+Hnho
X-Developer-Key: i=rodrigo.alencar@analog.com; a=ed25519;
 pk=ULeHbgU/OYh/PG/4anHDfLgldFItQHAhOktYRVLMFRo=
X-Endpoint-Received: by B4 Relay for rodrigo.alencar@analog.com/default
 with auth_id=561
X-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Reply-To: rodrigo.alencar@analog.com

From: Rodrigo Alencar <rodrigo.alencar@analog.com>

Add IIO_FREQUENCY channel type to support Direct Digital Synthesizer (DDS)
devices that handles frequency values written directly to its buffered
interface.

Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
---
 drivers/iio/industrialio-core.c | 1 +
 include/uapi/linux/iio/types.h  | 1 +
 tools/iio/iio_event_monitor.c   | 2 ++
 3 files changed, 4 insertions(+)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index bdf3d4c06331..a45277bc5d99 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -99,6 +99,7 @@ static const char * const iio_chan_type_name_spec[] = {
 	[IIO_ATTENTION] = "attention",
 	[IIO_ALTCURRENT] = "altcurrent",
 	[IIO_COVERAGE] = "coverage",
+	[IIO_FREQUENCY] = "frequency",
 };
 
 static const char * const iio_modifier_names[] = {
diff --git a/include/uapi/linux/iio/types.h b/include/uapi/linux/iio/types.h
index c9295c707041..1996839d1fce 100644
--- a/include/uapi/linux/iio/types.h
+++ b/include/uapi/linux/iio/types.h
@@ -54,6 +54,7 @@ enum iio_chan_type {
 	IIO_ATTENTION,
 	IIO_ALTCURRENT,
 	IIO_COVERAGE,
+	IIO_FREQUENCY,
 };
 
 enum iio_modifier {
diff --git a/tools/iio/iio_event_monitor.c b/tools/iio/iio_event_monitor.c
index bc3ef4c77c2b..7885f0f7562e 100644
--- a/tools/iio/iio_event_monitor.c
+++ b/tools/iio/iio_event_monitor.c
@@ -66,6 +66,7 @@ static const char * const iio_chan_type_name_spec[] = {
 	[IIO_ATTENTION] = "attention",
 	[IIO_ALTCURRENT] = "altcurrent",
 	[IIO_COVERAGE] = "coverage",
+	[IIO_FREQUENCY] = "frequency",
 };
 
 static const char * const iio_ev_type_text[] = {
@@ -196,6 +197,7 @@ static bool event_is_known(struct iio_event_data *event)
 	case IIO_ATTENTION:
 	case IIO_ALTCURRENT:
 	case IIO_COVERAGE:
+	case IIO_FREQUENCY:
 		break;
 	default:
 		return false;

-- 
2.43.0


