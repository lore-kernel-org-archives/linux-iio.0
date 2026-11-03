Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793717586;
	b=TIspr6LohlZ7fODLnyo0RiIwQWcmUumv6l4i4P89n86+/Dcw4HiL6iFZ921d+/j7SXib
	 USv05Y2FfQ4ap4pNfJn/pJ9RCy749ZfZ8YfHM/p9kyvrq28+G4Q0yd/yLVRRz9ODZ5q+p
	 5B0wF4PJBWfT/WXx6CjVRFhMNuZnCvDyB5Y437E59AZHQPN/RsibGyiMz/avdGZn6mOtS
	 EEIQhu+7UdtUkB/qXgneYPWIjxvknB7EbtHSFGNLX/ys55ORXwt9agTncLz44xHsdS84t
	 7Nr139xVui2tycrrXiXLD8y4szP4PkeoPemAJPvywOKmkwO+C9h5MrLHL9cxBXMJTBg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793717586;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=bKY/is6AhRtOF4CROF9s6PJ1wA3Cbs/0fe03oh4k6vM=;
	b=dE460vWHg3Y15uG9okNr9ZADYfT7+QcA+BapCkjGygtpGm3hL//QTBHt3TkajiazATNX
	 bJw5XeqO8QKg3TICzyZIkN+RW08Y1bmVUzBl9fN5YRrASv1VLvq2/VBXdWkhX+tq0NSUv
	 2sbyhi7gD5DHWfsvj0fXwbnEsoDfLbKsEQQ17Emnp3aW47eqtyTl5JOUjcCqEAUHHDR8J
	 oxgyDUYPevhfpuKk1EJk73SsKpmc6S7KRKxHw6p90EQz2Tbuzzx4okBfHUEoprvru4plq
	 Xx6MgEP6SvreeuIrkFPrNqhtT+atEQUw+3Qn+/1aTWval4IKyUA5XtzlAPsTlY+x79Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SvbVqmlX;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6AEE60A6F50;
	Tue,  3 Nov 2026 14:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SvbVqmlX
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793717585;
	b=u3pak5ZDCykDHSeE1d5kwrQowlLLJ35KAuOVInLZMHFNxvGIss8yWrvB0NW8YacqDR83
	 vEnG6+bRIIaNnOkX9yzB3C4nDf3FF5NCyH0gQzuYv0bF5ZZCvSbAh/H7T2UgvHYYWaofK
	 BHK/lUVBHkeFPQPPSemP1FF06AsNErzXaj4WVAoV5Xt/W2aBvKiFbkdRE7PGeLvdy7Efc
	 uKkHONecc4zNaA5x8rGXCvYjkfPqsHCZ8HM1e8e5YzAA1jI5iUYJq7HsAvt1bS9Kzy6GJ
	 KnopS9DgICbPjpV0BZHTrzKvUIbIUoUJ4Q6hgvBim3R8SXvqcRy2xTcwvRYzCVy3V4w==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793717585;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=bKY/is6AhRtOF4CROF9s6PJ1wA3Cbs/0fe03oh4k6vM=;
	b=kWfSgoCiJsIcQYxC2O/hkGgUaPUu6P3Y6NqmQ2n3jQD00XzVv/RwuTRXMpUSA1rFZC5A
	 ela6B7s9pFWNIq2r+PhyzLf5qwWQps7kdtU9MrFyW+MyEpSnJxXseSnQbE1bF7iWRGdFF
	 8/kBMYZVO9e6XsuAgZAm3QEqBnInZgkXLUZ9qzV2iD3KrWQUH44eReRClfVOv6CaGop/u
	 o8neKUrgdNifzhTZfs+AVs98iOVTcBrHZDMruHXAUziIclcI8brrrgFf8OQtaa892gNzW
	 Fvonl3J0oJ0BoqiqfcWGgle/MCJw3CWlNCpnqYDxSinh1Wc/z3QxJAmGwUC8yWolP8Q==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id BBD8F1F00919;
	Tue,  3 Nov 2026 14:53:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793717585;
	bh=bKY/is6AhRtOF4CROF9s6PJ1wA3Cbs/0fe03oh4k6vM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=SvbVqmlXks6xLlK9zUdB4Hy670E2w2b1vo0GHQDbs3PtSF34aVjUBYcE6XILJgtGP
	 fwOAk295p9nQMbiTJ4drcQGkinIgB6ROTYf+BECrfbI1z1hB2RYweN7jof6zwt/mcU
	 n7Cbv6vsoTH50F9dNXBL6Bg195Xohiy3Ik3fkW9c4W0fYTROxzgOCQCfXfShES0ekS
	 HuGXBykdl/ADM2giwzWmq/TKQq7oV4sotsWaQsWOtgqttVuU96FXzMHeAASwJOa0Ao
	 iUHzoVPC1eB+w30u0JE/TsHP/U3gOk4SDrW8GoJnhnWa2UYHflN8nNV4CEcyNNMlHF
	 B0amGwMUkfZCQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id C6AFF469BE;
	Tue,  3 Nov 2026 14:53:01 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Tue, 03 Nov 2026 11:53:05 -0300
Subject: [PATCH v3 09/10] iio: ABI: add integration_time for output
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
Message-Id: <20261103-ad9910-backend-support-v3-9-0e9224ddf7b7@analog.com>
References: <20261103-ad9910-backend-support-v3-0-0e9224ddf7b7@analog.com>
In-Reply-To: <20261103-ad9910-backend-support-v3-0-0e9224ddf7b7@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793717581; l=2039;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=snDH6M+COm79T6hMU2A4F2/Mb35rg85wpRy/sNJ/PXk=;
 b=XMaR3gMRMfLQ4YaTo45Hp7SbHV0rE5M9Pt+2Pjla4NxCexrp9YHP/1lEIyECu/XZbKYLNhrxn
 fpi35WWHsovAt6omRy5uNuVvTHm61/CfTAkIjGiRRCrHYheTAZibiJr
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
index 2b6f57041763..b09254a57438 100644
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


