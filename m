Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D41653DBD41;
	Thu, 18 Jun 2026 13:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781789269; cv=none; b=ngMPtjrkESGLo2LVItcQQiyGEPE/TQ0i3idQunwtcll1yRDDZvBeFcFhCjfKBGxEvFXA1hnYTvV/pxT4M/woyOsWinK5d5KCFr4xbDq4fEJbNsze/EntqjL0K6lhJngaMPnZY+nkqyOF6cTka97V+grccMO9bekrvPz4hO7P+hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781789269; c=relaxed/simple;
	bh=giG/LGDaFZ2K8ecCdCicQUac4jRxs4Zk0QpnfNo2FAs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=l1yp2mxObGbrLhOJjZFLBBEeLrwFA9oMTbGqBVVjsOIpYEUYcd4uKIVbZB3eYeugSk8I+6DH3IH1BkcF+VuYdEjHRk4WjwYiuFDHBrg4UhFF+izXYaeugdoMsn652fIJ54u1a4uz/s0IlIRLjOj7hVJgBoLms0hOBJu94rE5CCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fHxwFt9z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fHxwFt9z"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 98E19C2BCC9;
	Thu, 18 Jun 2026 13:27:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1781789269;
	bh=giG/LGDaFZ2K8ecCdCicQUac4jRxs4Zk0QpnfNo2FAs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=fHxwFt9z16zh6qm8Da+Dgbu+PcwoZh2nein+DdliBq0UTOfv27jSNiP5RpLqIN9ZG
	 1rBWaAF7SWmhHTkxYf0hopX/axGrTs9JySReVZMqjoauowihRjZSLhfYmwsCdnJiUK
	 CEZV47Q+9t2z2CUhNGXlQXjtGnhCEZrcAG7LLmvN3bFjkhX8CxnlwhmoyAAKaWsWwd
	 pZAO+DX7JhvevPAJtqUwNsbA/tAwetAfnO/p7ZlqQZjv3xcZYlGkHkXwfkjoqI6uVl
	 b8CLFJSs9FZI6yu/Va5nsQg6PVwgNcE1OYGPoz+jmQfNq10eGtdAvWDqNKP0XG7PKW
	 j1/yWWS55+0fg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 851B8CD98F8;
	Thu, 18 Jun 2026 13:27:49 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Thu, 18 Jun 2026 14:27:19 +0100
Subject: [PATCH v6 03/16] iio: ABI: add parent entry for iio channels
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260618-ad9910-iio-driver-v6-3-79125ffbe430@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781789267; l=1735;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=+RM1tUZK/kOT/XAZMDgMR43UKpX3Xy/DAmubh8Zz8rs=;
 b=ZF8nnL7+G7D7B6Hs3wKXdPml/nxAoqggXsKMMAzLEeRnTMvV80gv0gEP8CDlYGBW4edPP4v02
 mdmleV4Gdx4BKYGNNDEy67KHi+9RfaXUU7L8xTg2NyiKMSTu7enQoyE
X-Developer-Key: i=rodrigo.alencar@analog.com; a=ed25519;
 pk=ULeHbgU/OYh/PG/4anHDfLgldFItQHAhOktYRVLMFRo=
X-Endpoint-Received: by B4 Relay for rodrigo.alencar@analog.com/default
 with auth_id=561
X-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Reply-To: rodrigo.alencar@analog.com

From: Rodrigo Alencar <rodrigo.alencar@analog.com>

Add documentation for a read-only sysfs attribute that allows to expose
parent-child relationships between IIO channels.

Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
---
 Documentation/ABI/testing/sysfs-bus-iio | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index d9c4e3b53f29..e0f11b39511f 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -2154,6 +2154,23 @@ Description:
 		specific attributes. This is useful for userspace to be able to
 		better identify an individual channel.
 
+What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_parent
+What:		/sys/bus/iio/devices/iio:deviceX/out_voltageY_parent
+What:		/sys/bus/iio/devices/iio:deviceX/in_altvoltageY_parent
+What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltageY_parent
+What:		/sys/bus/iio/devices/iio:deviceX/in_currentY_parent
+What:		/sys/bus/iio/devices/iio:deviceX/out_currentY_parent
+What:		/sys/bus/iio/devices/iio:deviceX/in_altcurrentY_parent
+What:		/sys/bus/iio/devices/iio:deviceX/out_altcurrentY_parent
+KernelVersion:	7.2
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Read-only attribute containing the sysfs name prefix of the parent
+		channel for hierarchical channel relationships (e.g. "out_altvoltage0").
+		The prefix uniquely identifies the parent channel and can be used by
+		userspace to organize channels in tree-like structures that reflects
+		the physical or logical relationships between them.
+
 What:		/sys/bus/iio/devices/iio:deviceX/in_phaseY_raw
 KernelVersion:	4.18
 Contact:	linux-iio@vger.kernel.org

-- 
2.43.0


