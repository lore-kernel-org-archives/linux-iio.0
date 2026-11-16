Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794847204;
	b=u5f9/hhahLKs6YyOXrw6Dsgb4tCrQ21Q6DnKVZSbdkH8Z+O2BWQC9ZzrT8yYvJDpwNAe
	 AsNCC/piZdbI5UPQ3TkBzVvJwLPTDhEOKakB1KPv83dM/KSi//KIOCyzBnkicZvYr6Or0
	 RNTYWrRGVnRdWWCPhb8J1KkpSKustslmMp93RNF4/Ho8lv3eErPBJSU9zuSfFUBzUX1/2
	 1XKG4dBcELsb3GWK0irc0AKkOCLpwJYsxzw4nU2p9uAiz9UkZy+2gXpbBMjWuhJsm6MDW
	 0BfpKgkdrzUOa1pnqaf8xHTbWJKdTiUbrSAqPqCq/sVs5oqZAkb8zXM5dFbWdm15AKg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794847204;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=riwJVkXXXY98ikf3VHi8s78+yiqK/Cu9IX+o8diodTk=;
	b=xkO9p1XdyW+91iauiSzZsBABm4sBbnNJPHJ2gHxdCFWGqRCjo6oq3IwBIDL2Uw0nP8YY
	 wlh+NEcFzFEKP+/T7fk1DFy7A/Nx8xrcCh5tnP9fakZ5JcbKjzLIYwK2LJA9fsUdDMqUU
	 /In1ed8jX98L0Yb7KGl9XAuPP91EgAJa/8jfabHrl2bqruSMeFgSm1jL5HWPOB1ga2k0K
	 EJRIwnacRZWwsbvL0O8d78eQ4wFAAymHQqcGUCQC1S1yE7/+pEVmHgkborjuBJzqepouB
	 lcHqdIxCvJUN+8wPeAOJFpqhkb2rKnI3GGOXt/eLdWN4tpFAatmhieFAeS2Zrwo+xQQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cyaYND59;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7080860A261F;
	Mon, 16 Nov 2026 16:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cyaYND59
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794847204;
	b=myNzfDcM2cfOognTzyaS0EyQyE2OemkXHK6HdJlt9lXLVqDNlSj/jOYp3ARMRx/aIv9H
	 AHQv1OxoyjGeUzIOaHE90arJEbFLW3fS8OOXyJ80/ALUQYS2usKqjNd8TgOeeJ4JMKsSH
	 KPgi97SlsjkhoLohKh+UGPjunK/gJECbodWctVkme0kjLt4qr+xs0UOu8vCTpv+QRLJSB
	 gjO5mFBzZAHQaKueOeyBRKfaM7BBpFeHjyI0pVQ+GmkbBl3yPgkNEmofjSZM8+brFlHVA
	 5e88cW7ZDmf50415vqJNCMym4DfOSCglck+DpDMKH7PKYLxo0g344bqIrHYhv7JtGNA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794847204;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=riwJVkXXXY98ikf3VHi8s78+yiqK/Cu9IX+o8diodTk=;
	b=fGQnDlRRy8MNiC2ABkW8ocwmqcqZb23etEmjOSRIP+JrmZKrWqUwycajpnBncxieHBu3
	 MoD2r9qH3XD+S7YLzlfLkXk4r5+D/J4gObmGgR3qf3xNJ+t5TRsjfpuHwEta07OnnBqok
	 RMw14EEOjrz+y0FVqkJ3kaBCTvEwpRo42U1Fb1nTIplmnMLEybHhdIVuRibuuZ8TPYEaO
	 HWKeXK9f1fA3OAfm7SYqBrn2ty5OWW8TOfc7eQyJI3hw9NRTCa+F6geXAGGMLH2qac7P/
	 DyyYk0pJ/6ZbLvf5SAnpE3SEKPR6Q/wwSG067T1ikRN2NzpSgMfUANKavE21bdluIZg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id CB3591F000C9;
	Mon, 16 Nov 2026 16:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794847204;
	bh=riwJVkXXXY98ikf3VHi8s78+yiqK/Cu9IX+o8diodTk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=cyaYND595ZkwUqpUmcsp3p7Eh42gsehEMGy2G+Y5m2Vu5bM/fnDdOigspspadI+D6
	 VQKXG3VF6uVMjuyxB4HTlFAKLVW0xUHNIGWXhWsv0AiKGDOKhwzaukWMyZBQ9kgbPT
	 rkcixJAbGzB9CG8VfEm3526HkXs9Zz7rKnl/7Qv70lrPeg8xg37dh5XOXyCH1uVshU
	 ATBuY8XYVXs8BAAc+WbQP53LER53xeI6ekDRjM1W+ISCCD6WHfLBTOR/elLAH1iYYM
	 chsk5npzbbqswrx5kIqwmSseWUfOJbiVrQ39MpJTqcWhETsyFs+KXA6L3tYVTA/5wH
	 hkiEnauyOF8jg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id AED2F4A542;
	Mon, 16 Nov 2026 16:39:59 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Mon, 16 Nov 2026 16:40:03 +0000
Subject: [PATCH v4 11/12] iio: ABI: add integration_time for output
 channels
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
Message-Id: <20261116-ad9910-backend-support-v4-11-fcf1ad364ed5@analog.com>
References: <20261116-ad9910-backend-support-v4-0-fcf1ad364ed5@analog.com>
In-Reply-To: <20261116-ad9910-backend-support-v4-0-fcf1ad364ed5@analog.com>
To: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux@analog.com, devicetree@vger.kernel.org, linux-pwm@vger.kernel.org, 
 linux-doc@vger.kernel.org, 
 Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Cc: Olivier Moysan <olivier.moysan@foss.st.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, 
 Rodrigo Alencar <rodrigo.alencar@analog.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794847197; l=2039;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=ArKliXzwidNFOs9CJk/f2j2v2U2NbJL4NaNVqhddipA=;
 b=Q5g0nX6WMGgj7rZG6tdRZ2HXOf3pZ0naLyBp29XIQutPkkLPl/GjZI1NRcP/XdyJ9TXdYGcWD
 bgdASXVcH6UBZV83IEUpjNT68+veYVYo0to57sDUFv7rMaTw7oSe/cE
X-Developer-Key: i=rodrigo.alencar@analog.com; a=ed25519;
 pk=ULeHbgU/OYh/PG/4anHDfLgldFItQHAhOktYRVLMFRo=
X-Endpoint-Received: by B4 Relay for rodrigo.alencar@analog.com/default
 with auth_id=561
X-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Reply-To: rodrigo.alencar@analog.com
Content-Transfer-Encoding: 8bit

From: Rodrigo Alencar <rodrigo.alencar@analog.com>

Document the integration_time attribute for output channels, which is
the time interval during which the output is generated by integrating
a quantity, such as its rate of change. It is the output counterpart of
the integration_time already defined for input channels.
Add entries for the altcurrent, frequency and phase channel types, which
are going to be used by the AD9910 DDS driver.

Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
---
 Documentation/ABI/testing/sysfs-bus-iio | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index 5e987c502b13..54800847f2ca 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -1744,6 +1744,23 @@ Description:
 		seconds. If shared across all channels of a given type,
 		<type>_integration_time is used.
 
+What:		/sys/bus/iio/devices/iio:deviceX/out_altcurrentY_integration_time
+What:		/sys/bus/iio/devices/iio:deviceX/out_frequencyY_integration_time
+What:		/sys/bus/iio/devices/iio:deviceX/out_phaseY_integration_time
+KernelVersion:	7.5
+Contact:	linux-iio@vger.kernel.org
+Description:
+		This attribute is used to get/set the integration time in
+		seconds of an output channel, i.e., the time interval during
+		which the output is generated by integrating (accumulating) a
+		quantity over time, such as the rate of change (roc) of the
+		channel. The output variation over this interval corresponds to
+		the integral of that quantity, which may be bounded by limits
+		configured through other channel attributes. The written value
+		may be adjusted to the nearest interval supported by the
+		hardware. If shared across all channels of a given type,
+		<type>_integration_time is used.
+
 What:		/sys/.../iio:deviceX/in_velocity_sqrt(x^2+y^2+z^2)_integration_time
 KernelVersion:	4.0
 Contact:	linux-iio@vger.kernel.org

-- 
2.43.0


