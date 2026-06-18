Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D41FF3DD50B;
	Thu, 18 Jun 2026 13:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781789269; cv=none; b=mH23velANnfsrVQsDfCzuMJnubgXizwBwFrwi3QhJbDz6E9lYoEaaEkFr2Xmk4NzWn99D7lIFpjdAOhaADna7jzISYILplGQU/WcvHlAqiWX4XAxjVtiaIr7FZG/qer4kNzHjGcCulnncRLJdsWzdMuliWJ8C8m1TjPAg+BKsAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781789269; c=relaxed/simple;
	bh=qHawdcPfPi3PiGqRcP9Q4i2MCtYyaZB/NNEyuXF5xpk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jjMa0eXPdTMuLi478dDsaM7UOSQAdDnf9fBhYgYX/m/kg3ydfbrwqIAHVYf4Ze5dP/eTZfH4HBbiHWLcjQMBPGbOPDjUlsmJ1XXGA3jmnjlu7pqlxY1H+qxk4qE6BnyyNmylMkj85LT8LJzShF519wpiLP4n/QUzpT6bbn8dVLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kgPbEOYu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kgPbEOYu"
Received: by smtp.kernel.org (Postfix) with ESMTPS id A3DB5C2BCFC;
	Thu, 18 Jun 2026 13:27:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1781789269;
	bh=qHawdcPfPi3PiGqRcP9Q4i2MCtYyaZB/NNEyuXF5xpk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=kgPbEOYueKcZCeb4lDoGoqEIOo8INZcnNsWnnVUnAxf1eZ/roueeJr0VozjucjWoF
	 XDBbXGpk9EWouIHu8NQJMmf6gRcyJCCxojAvtWYdzu77T4jRBKkHFYdYrzB+EObMfs
	 uAIOGy5Fb46EDp+Pi1IHGj1SdLV7hBRReALB5n6OFrI5fYoyBTcnkVwJFM3ueawDMX
	 2SOkeLCuAFe2HFR62kOmCnRIwlIERx+FF0cx4pJyDLAdsHfk4D3ka95kZaFtsRTs9b
	 gHDXr8RWL+x1rWQLzKOyeUNyn74n2T2NmPlntBKjH3e6c3jsvGwP0Y78tYkDppCLmy
	 Kj+zjYDmxhbuA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A285CD98ED;
	Thu, 18 Jun 2026 13:27:49 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Thu, 18 Jun 2026 14:27:20 +0100
Subject: [PATCH v6 04/16] iio: add IIO_FREQUENCY channel type
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260618-ad9910-iio-driver-v6-4-79125ffbe430@analog.com>
References: <20260618-ad9910-iio-driver-v6-0-79125ffbe430@analog.com>
In-Reply-To: <20260618-ad9910-iio-driver-v6-0-79125ffbe430@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781789267; l=1881;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=jbim5xwfgPdYaBnTd6/fD5egETTIvvXZPgiaoHdTiW4=;
 b=Um9rSH9LV76bFmQRzurf1NB2s90fNyf8lCW9A6PBoUGGCrr5aOUToPKzCHPBBrNXCTR3Q6H3N
 mejRLLbEU8mDA+1FivbKlWvC6xmbn9NlEVfyY6qIIFBkRE3sn8Mr+vh
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
index 93c2540d4cd2..f9fd353f79e1 100644
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


