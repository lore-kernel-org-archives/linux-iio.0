Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA27437FF75;
	Tue, 14 Jul 2026 11:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784026973; cv=none; b=rVAbOpqGA3e22nkbDR8eOkZF3vKI1KtNsiwkGKMDnHOKxk6LOerrSld5XHSvTMIYpRhr3Wv0hPsxrPgOKaHWcX3iawZibZi1l+vs9pKjiVfQYcVhINzdMO0zH18DbLVfmmk8tm9kXOdMRmtRyAYwfQKQiRSy/TPsw/3a/KU3WtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784026973; c=relaxed/simple;
	bh=LkGR2S/oFgI/+IPKjfMY0lgtsj7hpBpubbqxfDZIpLs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hwh3mZLVSRHCxgRve2RxWVG4xj6/AoW/WCUVrdBnXME1uBM0TtZyaMLBoOhh0VKhPyU4GQHDn8zDfsUoQcHHRXFb1xet/xrCeNsEUIQxKBR1H9gZ0iuYGBWPoPRCY4Xhsl58Phh3X2Ww3XeEH8rnXd4QyLG5JUtQnvyyT3ltuIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C/6UYlSw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C/6UYlSw"
Received: by smtp.kernel.org (Postfix) with ESMTPS id CCE94C2BCFF;
	Tue, 14 Jul 2026 11:02:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1784026972;
	bh=LkGR2S/oFgI/+IPKjfMY0lgtsj7hpBpubbqxfDZIpLs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=C/6UYlSwClXIs81nRMWAJVW1BKpx38TOquqYk5CP7/JZtnRnjlMqS4CBGYyLI/8O/
	 uUOsI7JIMq/y1uzDbNDYvYbexvJxn9QSAMiFbiqExUuo06aA7Moh0Psdqlocjj9bB5
	 8grsBwU7dvHgpdgzXbMIGY7SxR1PuPoEu98/dKMHVcTFADH4iPzdiim1v2ZtKCPKCs
	 YNsAWKCeqzKmtCOpU0Gg7y+9AicxYcA4JFUnUnw1wSTJJuBCA5gynOqGtkz8aA4Rr2
	 fAopuMm+x/z6f/fBNIZoMnZx38qbWS8VRpWhO7wefw8udzT9hnu5VYIpTRwSKoixkH
	 V3X3a1rrJoObQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B378FC44508;
	Tue, 14 Jul 2026 11:02:52 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Tue, 14 Jul 2026 12:02:44 +0100
Subject: [PATCH v8 04/17] iio: add IIO_FREQUENCY channel type
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260714-ad9910-iio-driver-v8-4-36939c3c07d2@analog.com>
References: <20260714-ad9910-iio-driver-v8-0-36939c3c07d2@analog.com>
In-Reply-To: <20260714-ad9910-iio-driver-v8-0-36939c3c07d2@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784026971; l=1881;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=1IPBIAnpoq77uH/f9ncnZ8sog7Fcx5CLyDe5QVK2WqI=;
 b=Hh0U0aJccVFe4NQUgS0JeTmEw8mq9gt3x8+qE/+Jy3iK6KQVx1F6Yl5ukbFN9z+TpRABLwDGz
 HGigzqvoW3eDGXKTVl33FgsQFtOccEyRCmvPCYsFZx0JRxmOJG3JBWZ
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


